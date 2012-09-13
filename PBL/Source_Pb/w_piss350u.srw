$PBExportHeader$w_piss350u.srw
$PBExportComments$사내출하및반납입력
forward
global type w_piss350u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss350u
end type
type uo_division from u_pisc_select_division within w_piss350u
end type
type uo_date from u_pisc_date_applydate within w_piss350u
end type
type dw_save from datawindow within w_piss350u
end type
type dw_print from datawindow within w_piss350u
end type
type sle_kbno from singlelineedit within w_piss350u
end type
type gb_1 from groupbox within w_piss350u
end type
type gb_2 from groupbox within w_piss350u
end type
type dw_sheet from datawindow within w_piss350u
end type
type dw_2 from datawindow within w_piss350u
end type
end forward

global type w_piss350u from w_ipis_sheet01
integer width = 4571
integer height = 2356
string title = "제품입고정보입력"
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_save dw_save
dw_print dw_print
sle_kbno sle_kbno
gb_1 gb_1
gb_2 gb_2
dw_sheet dw_sheet
dw_2 dw_2
end type
global w_piss350u w_piss350u

type variables
string is_kbno
string is_areacode,is_divisioncode,is_prddate,is_itemcode,is_productgroup
long  il_qty
end variables

forward prototypes
public function integer wf_referance_data (string fs_areacode, string fs_divisioncode, string fs_kbno)
public function boolean wf_kb_valid_check (string fs_kbno)
public function boolean wf_update_tshipetc ()
public function boolean wf_update_tlotno (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, string fs_shipgubun, integer fl_shipqty)
public function boolean wf_update_tkb ()
public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate)
public function boolean wf_errchk (string fs_column)
public function boolean wf_create_kbno ()
end prototypes

public function integer wf_referance_data (string fs_areacode, string fs_divisioncode, string fs_kbno);string ls_prddate,ls_workcenter,ls_itemcode,ls_itemname,ls_modelid
long   ll_prdqty,ll_row

// 생산일자,조코드,품번,품명,생산수량 select
select a.prddate,a.workcenter,a.itemcode,b.itemname,a.prdqty
  into :ls_prddate,:ls_workcenter,:ls_itemcode,:ls_itemname,:ll_prdqty
  from tkb a,tmstitem b
 where kbno = :fs_kbno
   and areacode = :fs_areacode
	and divisioncode = :fs_divisioncode
	and a.itemcode = b.itemcode
	using sqlpis;

//식별id select
select distinct modelid
  into :ls_modelid
  from tmstkb
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
	and itemcode = :ls_itemcode
	using sqlpis;

ll_row = dw_sheet.insertrow(0)

dw_sheet.object.prddate[ll_row] = ls_prddate
dw_sheet.object.workcenter[ll_row] = ls_workcenter
dw_sheet.object.itemcode[ll_row] = ls_itemcode
dw_sheet.object.itemname[ll_row] = ls_itemname
dw_sheet.object.modelid[ll_row] = ls_modelid
dw_sheet.object.kbno[ll_row] = fs_kbno
dw_sheet.object.kbqty[ll_row] = ll_prdqty

dw_sheet.selectrow(0,false)
dw_sheet.selectrow(ll_row,true)
dw_sheet.scrolltorow(ll_row)

il_qty = ll_prdqty
is_itemcode = ls_itemcode
is_kbno = fs_kbno

return 1


end function

public function boolean wf_kb_valid_check (string fs_kbno);string ls_itemcode,ls_invgubunflag
Integer	li_count
long ll_etcqty
ll_etcqty = dw_sheet.object.etcqty[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_invgubunflag = dw_sheet.object.invgubunflag[1]

if ll_etcqty = 0 or isnull(ll_etcqty) then
   messagebox("확인","수량을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('etcqty')
	return false
end if	
if ls_itemcode = '' or isnull(ls_itemcode) then
   messagebox("확인","품번을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('itemcode')
	return false
end if	

SELECT Count(KBNO) 
  into :li_count
  FROM TKB
 WHERE	TKB.AreaCode	   = :is_areacode
   and   TKB.DivisionCode	= :is_divisioncode
   and	TKB.KBStatusCode	= 'D' 
   and	TKB.KBNO				= :fs_kbno
   and	TKB.itemcode		= :ls_itemcode
   and	KBActiveGubun		= 'A'
	and   invgubunflag  = :ls_invgubunflag
	using sqlpis;
If li_count > 0 then 
	Return True
Else
	Return False
End if

end function

public function boolean wf_update_tshipetc ();string ls_proofno,ls_deptcode,ls_itemcode,ls_proofno_seq,ls_year,ls_month,ls_inputflag,ls_projectno,ls_invgubunflag,ls_reason
string ls_confirmno,ls_confirmno1,ls_yymm,ls_seqno,ls_shipgubun
long ll_etcqty

string ls_close_date
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

select max(substring(confirmno,7,4))
  into :ls_confirmno
  from tshipetc_interface
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and inputdate like substring(:ls_close_date,1,7) + '%'
 using sqlpis;
if ls_confirmno = '' or isnull(ls_confirmno) then
	ls_proofno_seq = 'Z000'
else
	ls_proofno_seq	= right(ls_confirmno,4)
end if
ls_year  = mid(ls_close_date,4,1) 
ls_month = mid(ls_close_date,6,2)		
ls_shipgubun = dw_sheet.object.shipgubun[1]
f_pisc_get_string_add(ls_proofno_seq,ls_proofno_seq)

ls_confirmno1 = is_areacode + is_divisioncode + ls_shipgubun
dw_sheet.object.confirmno1[1] = ls_confirmno1
dw_sheet.object.yymm[1] = ls_year + ls_month
ls_seqno = ls_proofno_seq
dw_sheet.object.seqno[1] = ls_proofno_seq
ls_confirmno = ls_confirmno1 + ls_year + ls_month  + ls_proofno_seq
dw_sheet.object.confirmno[1] = ls_confirmno
ls_deptcode     = dw_sheet.object.deptcode[1]
ls_inputflag    = dw_sheet.object.inputflag[1]
ls_projectno    = dw_sheet.object.projectno[1]
ls_invgubunflag = dw_sheet.object.invgubunflag[1]
ls_reason       = dw_sheet.object.reason[1]
ls_itemcode     = dw_sheet.object.itemcode[1]
ll_etcqty       = dw_sheet.object.etcqty[1]
  INSERT INTO TSHIPETC_interface  
         ( AreaCode,   
           DivisionCode,   
           InputDate,   
           InputFlag,   
           DeptCode,   
           ProjectNo,   
           ConfirmNo,   
           ItemCode,   
			  seqno,
           InvGubunFlag,   
           EtcQty,   
           Reason,  
			  misflag,
			  interfaceflag,
           LastEmp,   
           LastDate )  
  VALUES ( :is_areacode,   
           :is_divisioncode,   
           :is_prddate,   
           :ls_inputflag,   
           :ls_deptcode,   
           :ls_projectno,   
           :ls_confirmno,   
           :ls_itemcode,   
			  1,
           :ls_invgubunflag,   
           :ll_etcqty,   
           :ls_reason,   
			  'A',
			  'Y',
           :g_s_empno,   
           getdate() )
			  using sqlpis;
if sqlpis.sqlcode <> 0 then
    uo_status.st_message.text = "Tshipetc_interface update시 오류가 발생하였습니다." 
	return false
else
	return true
end if	
end function

public function boolean wf_update_tlotno (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, string fs_shipgubun, integer fl_shipqty);long ll_count
select count(*) 
  into :ll_count
  from tlotno
  where tracedate    = :fs_close_date
    and areacode     = :fs_areacode
	 and divisioncode = :fs_divisioncode
	 and lotno        = :fs_lotno
	 and itemcode     = :fs_itemcode
	 and custcode     = 'XXXXXX'
	 and shipgubun    = :fs_shipgubun
	 using sqlpis;
if isnull(ll_count)	 then
	ll_count = 0
end if	
if ll_count = 0 then
  INSERT INTO TLOTNO  
         ( TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,custcode,shipgubun,
           shipusage,PrdQty,StockQty,ShipQty,
           LastEmp,LastDate )  
  VALUES ( :fs_close_date,:fs_areacode,:fs_divisioncode,:fs_lotno,:fs_itemcode,'XXXXXX',:fs_shipgubun,
           'X',0,0,:fl_shipqty,
           'Y',getdate() ) 
	  using sqlpis;
else			  
	update tlotno
	   set shipqty     = shipqty + :fl_shipqty,
		    lastemp      = 'Y',
			 lastdate     = getdate()
    where tracedate    = :fs_close_date
      and areacode     = :fs_areacode
	   and divisioncode = :fs_divisioncode
	   and lotno        = :fs_lotno
	   and itemcode     = :fs_itemcode
	   and custcode     = 'XXXXXX'
	   and shipgubun    = :fs_shipgubun
	 using sqlpis;
end if
if sqlpis.sqlcode <> 0 then
   uo_status.st_message.text = "Tlotno update시 오류가 발생하였습니다." 
	return false
end if
return true

end function

public function boolean wf_update_tkb ();long ll_rowcount,i,ll_currentqty,ll_readingqty
string ls_kbno,ls_kbstatuscode,ls_shipgubun,ls_itemcode,ls_lotno
ll_rowcount = dw_2.rowcount()
boolean lb_commit
lb_commit = true
string ls_close_date
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
ls_shipgubun  = dw_sheet.object.shipgubun[1]
ls_itemcode   = dw_sheet.object.itemcode[1]

for i = 1 to ll_rowcount step 1
	ll_currentqty = dw_2.object.currentqty[i]
	ll_readingqty = dw_2.object.readingqty[i]
	ls_kbno       = dw_2.object.kbno[i]
	select lotno
	  into :ls_lotno
	  from tkb
	 where areacode = :is_areacode
	   and divisioncode = :is_divisioncode
	   and kbno = :ls_kbno
	 using sqlpis;
	if isnull(ls_lotno) or ls_lotno = '' then
		ls_lotno = 'XXXXXX'
	end if
	if ll_currentqty = ll_readingqty then
		ls_kbstatuscode = 'F'
	else
		ls_kbstatuscode = 'D'
	end if
	update tkb 
	   set shipdate     = :ls_close_date,
		    kbshiptime   = getdate(),
			 shipqty      = shipqty    + :ll_readingqty,
			 kbstatuscode = :ls_kbstatuscode,
			 currentqty   = currentqty - :ll_readingqty,
			 lastdate     = getdate(),
			 lastemp      = 'Y'
	 where areacode = :is_areacode
	   and divisioncode = :is_divisioncode
	   and kbno = :ls_kbno
	 using sqlpis;
	IF SQLPIS.SQLCODE <> 0 THEN
      uo_status.st_message.text = "Tkb update시 오류가 발생하였습니다." 		
		lb_commit = false
		exit
   end if		
	update tkbhis
	   set shipdate = :is_prddate,
		    kbshiptime = getdate(),
			 shipqty = shipqty + :ll_readingqty,
			 kbstatuscode = :ls_kbstatuscode,
			 currentqty   = currentqty - :ll_readingqty,
			 lastdate     = getdate(),
			 lastemp      = 'Y'
	 where areacode = :is_areacode
	   and divisioncode = :is_divisioncode
	   and kbno = :ls_kbno
		and kbstatuscode = 'D'
	 using sqlpis;
	IF SQLPIS.SQLCODE <> 0 THEN
      uo_status.st_message.text = "Tkbhis update시 오류가 발생하였습니다." 		
      lb_commit = false
		exit
   end if		
//   if not wf_update_tlotno(ls_close_date,is_areacode,is_divisioncode,'XXXXXX',ls_itemcode,ls_shipgubun,ll_readingqty) then
//      uo_status.st_message.text = "Tlotno update시 오류가 발생하였습니다." 
//      lb_commit = false
//		exit
//	end if
next	 

return lb_commit


end function

public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate);dw_sheet.accepttext()
string ls_tempkbsn,ls_kbsn,ls_applyfrom,ls_itemcode,ls_deptcode,ls_temp_kbno
long ll_invqty,ll_etcqty,i,ll_repairqty,ll_defectqty,ll_count,ll_totqty
string ls_projectno,ls_confirmno,ls_confirmno1,ls_yymm,ls_seqno,ls_shipgubun,ls_inputflag
string ls_projectname,ls_deptshortname4
ls_inputflag = dw_sheet.object.inputflag[1]
ll_etcqty = dw_sheet.object.etcqty[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_projectno = trim(dw_sheet.object.projectno[1])
ls_shipgubun = trim(dw_sheet.object.shipgubun[1])
ls_confirmno1 = trim(dw_sheet.object.confirmno1[1])
ls_seqno = trim(dw_sheet.object.seqno[1])
ls_yymm = trim(dw_sheet.object.yymm[1])
ls_confirmno = ls_confirmno1 + ls_yymm + ls_seqno
dw_sheet.object.confirmno[1] = ls_confirmno

string ls_productgroup
string ls_invgubunflag
string ls_close_date
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
dw_sheet.accepttext()
ll_etcqty = dw_sheet.object.etcqty[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_invgubunflag = dw_sheet.object.invgubunflag[1]
if ls_invgubunflag = 'N' then //정품
   ll_invqty = ll_etcqty
	ll_repairqty = 0
	ll_defectqty = 0
elseif ls_invgubunflag = 'R' then //요수리
		 ll_invqty = 0
		 ll_repairqty = ll_etcqty
		 ll_defectqty = 0
else  //폐품
		 ll_invqty = 0
		 ll_repairqty = 0
		 ll_defectqty = ll_etcqty
end if		 
if ls_inputflag = '1' then  //출하
   ll_invqty = ll_invqty * -1
	ll_repairqty = ll_repairqty * -1
	ll_defectqty = ll_defectqty * -1
end if	
	
if ls_inputflag = '1' then //출하
   if not wf_update_tlotno(ls_close_date,is_areacode,is_divisioncode,'XXXXXX',ls_itemcode,ls_shipgubun,ll_etcqty) then
   	uo_status.st_message.text = "Tlotno update시 오류가 발생하였습니다." 	
	   Return false
	end if
else  //반납
   if not wf_update_tlotno(ls_close_date,is_areacode,is_divisioncode,'XXXXXX',ls_itemcode,ls_shipgubun,ll_etcqty * -1) then
   	uo_status.st_message.text = "Tlotno update시 오류가 발생하였습니다." 	
	   Return false
	end if
end if
//창고 입고시 tinv
if wf_update_tshipetc() = false then
   uo_status.st_message.text = "Tshipetc update시 오류가 발생하였습니다." 	
   Return false
End if
select count(*)
  into :ll_count
  from tinv
 where ItemCode		= :ls_itemcode
	and areacode      = :fs_areacode
	and divisioncode = :fs_divisioncode
	using sqlpis;
if ll_count > 0 then
	Update tinv
		set Invqty	   = invqty	   + :ll_invqty,
		    repairqty  = repairqty + :ll_repairqty,
			 defectqty  = defectqty + :ll_defectqty,
			 LastEmp		= 'Y',
			 LastDate	= GetDate()
	 where ItemCode	  = :ls_itemcode
		and areacode     = :fs_areacode
      and divisioncode = :fs_divisioncode
		using sqlpis;
else
	Insert into tinv(AreaCode,DivisionCode, Itemcode,
						  Invqty,repairqty,defectqty,Lastemp,lastDate)
			Values(:fs_areacode,:fs_divisioncode,:ls_itemcode, &
					 :ll_invqty,:ll_repairqty,:ll_defectqty,'Y',Getdate())
	using sqlpis;
end if
if sqlpis.sqlcode = 0 then
Else
   uo_status.st_message.text = "Tinv update시 오류가 발생하였습니다." 	
	Return false
End if

if wf_update_tkb() = false then
   uo_status.st_message.text = "Tkb update시 오류가 발생하였습니다." 
	Return false
End if

return true
end function

public function boolean wf_errchk (string fs_column);string ls_deptcode,ls_deptname,ls_itemcode,ls_itemname,ls_itemspec,ls_itemtype,ls_item_check
string ls_shipgubun,ls_seqno,ls_confirmno,ls_confirmno1,ls_yymm
long ll_etcqty,ll_count
string ls_itemclass,ls_itembuysource,ls_deptshortname4,ls_projectname,ls_projectno
ll_etcqty = dw_sheet.object.etcqty[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_shipgubun = dw_sheet.object.shipgubun[1]
ls_projectno = dw_sheet.object.projectno[1]
//dw_sheet.object.yymm[1] = mid(is_prddate,4,1) + mid(is_prddate,6,2)
//ls_confirmno1 = dw_sheet.object.confirmno1[1]
//ls_yymm = dw_sheet.object.yymm[1]
//ls_seqno = dw_sheet.object.seqno[1]
//ls_confirmno = ls_confirmno1 + ls_yymm + ls_seqno
CHOOSE CASE fs_column
	CASE 'deptcode'
		  select deptname,isnull(deptshortname4,'X')
		    into :ls_deptname,:ls_deptshortname4
			 from tmstdept
  		   where deptcode = :ls_deptcode
			using sqlpis;
		  if ls_deptname = '' or isnull(ls_deptname) then
			  messagebox("확인","미등록된 부서입니다.")
			  dw_sheet.object.deptcode[1] = ''
			  dw_sheet.object.deptname[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('deptcode')
			  return false
		  end if
		  dw_sheet.object.deptname[1] = ls_deptname
		  if ls_deptshortname4 <> 'D' then  //연구개발이 아니면
     		  dw_sheet.object.projectno[1] = ''
		     dw_sheet.object.projectname[1] = ''
			  dw_sheet.setcolumn('itemcode')
			  dw_sheet.Object.projectno.Protect=1
		  else
//			  dw_sheet.settaborder('projectno',40)
			  dw_sheet.Object.projectno.Protect=0			  
		  end if
	CASE 'projectno'
		  select projectname
		    into :ls_projectname
			 from tmstproject
  		   where projectno = :ls_projectno
			using sqlpis;
		  if ls_projectname = '' or isnull(ls_projectname) then
			  messagebox("확인","미등록된 프로젝트번호입니다.")
			  dw_sheet.object.projectno[1] = ''
			  dw_sheet.object.projectname[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('projectno')
			  return false
		  end if
		  dw_sheet.object.projectname[1] = ls_projectname
   CASE 'itemcode'
		  select itemname,itemspec
		    into :ls_itemname,:ls_itemspec
			 from TMSTitem
  		   where 
			  itemcode = :ls_itemcode
			  //and areacode = :is_areacode
			  //and divisioncode = :is_divisioncode
			using sqlpis;
		  if sqlpis.sqlcode <> 0 then
			  messagebox("확인","미등록된 품번입니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
//			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
		  dw_sheet.object.itemname[1] = ls_itemname
		  if f_piss_itemtype_check(is_areacode,is_divisioncode,ls_itemcode) = '2' then 
			  messagebox("확인","단품은 입력할 수 없습니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
//			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
			
//		  dw_sheet.object.itemspec[1] = ls_itemspec
		  select top 1 productgroup,itemclass,itembuysource
		    into :is_productgroup,:ls_itemclass,:ls_itembuysource
			 from tmstmodel
			where areacode = :is_areacode
			  and divisioncode = :is_divisioncode
			  and itemcode = :ls_itemcode
			  using sqlpis;
		  if is_productgroup = '' or isnull(is_productgroup) then
			  messagebox("확인","모델마스타에 없습니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
//			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if
		  if ls_itemclass = '' or isnull(ls_itemclass) then
			  ls_itemclass = ' '
		  end if
		  if ls_itembuysource = '' or isnull(ls_itembuysource) then
			  ls_itembuysource = ' '
		  end if
		  if ls_itemclass = '10' and (ls_itembuysource = '05' or ls_itembuysource = '06') then
			  messagebox("확인","출하할 수 없는 품번입니다.")
			  dw_sheet.object.itemcode[1] = ''
			  dw_sheet.object.itemname[1] = ''
//			  dw_sheet.object.itemspec[1] = ''
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('itemcode')
			  return false
		  end if

   CASE 'etcqty'
		  if isnull(ll_etcqty) or ll_etcqty = 0 then
			  messagebox("확인","수량을 입력하세요.")
			  dw_sheet.setfocus()
			  dw_sheet.setcolumn('etcqty')
			  return false
		  end if
		  dw_2.reset()
		  sle_kbno.text = ''
		  sle_kbno.setfocus()
END CHOOSE

return true
end function

public function boolean wf_create_kbno ();dw_sheet.accepttext()
string ls_tempkbsn,ls_kbsn,ls_applyfrom,ls_itemcode,ls_deptcode,ls_temp_kbno,ls_invgubunflag
long ll_rackqty,i,ll_remainqty,ll_count,ll_etcqty
ls_deptcode = dw_sheet.object.deptcode[1]
ll_etcqty = dw_sheet.object.etcqty[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_invgubunflag = dw_sheet.object.invgubunflag[1]
boolean lb_commit
lb_commit = true

select top 1 rackqty
  into :ll_rackqty
  from tmstkb
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and itemcode = :ls_itemcode
  using sqlpis;
if ll_rackqty = 0 or isnull(ll_rackqty) then
   ll_rackqty = ll_etcqty
end if	

ll_remainqty = ll_etcqty

ll_count = ceiling(ll_etcqty/ll_rackqty)

for i = 1 to ll_count step 1
	select max(kbno)
	  into :ls_temp_kbno
	  from tkb
	 where areacode     = :is_areacode
		and divisioncode = :is_divisioncode
		and applyfrom    like substring(:is_prddate,1,7) + '%'
		and substring(kbno,3,1) = 'Z'
		using sqlpis;
	if ls_temp_kbno = '' or isnull(ls_temp_kbno) then
		ls_temp_kbno = is_areacode + is_divisioncode + 'Z' + mid(is_prddate,3,2) +mid(is_prddate,6,2) + '0000'
	end if
	
	ls_kbsn	= Right(ls_temp_kbno, 4)
	
	If not f_pisc_get_string_add(ls_kbsn, ls_kbsn) Then
		uo_status.st_message.text = "f_pisc_get_string_add error"
		lb_commit = false
		exit
	end if	
	if ll_remainqty <= ll_rackqty then
		ll_rackqty = ll_remainqty
	else
		ll_remainqty = ll_remainqty - ll_rackqty
	end if
	ls_temp_kbno	= Left(ls_temp_kbno, 7) + ls_kbsn
	dw_save.ReSet()
	is_kbno = ls_temp_kbno
	If dw_save.Retrieve(is_kbno,is_areacode,is_divisioncode,ls_deptcode,'X',ls_itemcode,is_prddate, &
							  'T','N',ll_rackqty,g_s_empno) > 0 Then
		If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
			update tkbhis
				set kbreleasedate = :is_prddate,
					 kbreleaseseq = 1,
					 printcount = 1,
					 releasegubun  = 'C',
					 invgubunflag = :ls_invgubunflag,
					 kbprinttime = getdate(),
					 stockqty   = :ll_rackqty,
					 stockdate  = :is_prddate,
					 kbstocktime = getdate(),
					 kbactivegubun = 'A',
					 kbstatuscode = 'D',
					 lastemp     = 'Y',
					 lastdate    = getdate()
				where areacode = :is_areacode
				  and divisioncode = :is_divisioncode
				  and kbno = :is_kbno
				  using sqlpis;
			update tkb
				set kbstatuscode = 'D',
				    kbactivegubun = 'A',
					 printcount = 1,
					 releasegubun  = 'C',
					 invgubunflag   = :ls_invgubunflag,
					 kbprinttime = getdate(),
					 stockqty   = :ll_rackqty,
					 stockdate  = :is_prddate,					 
					 kbstocktime = getdate(),
					 lastemp     = 'Y',
					 lastdate    = getdate()
				where areacode = :is_areacode
				  and divisioncode = :is_divisioncode
				  and kbno = :is_kbno
				  using sqlpis;
			dw_print.retrieve(is_areacode,is_divisioncode,is_kbno)
			dw_print.print()
		else
			uo_status.st_message.text = "현품표 생성시 오류 발생"
			lb_commit = false
			exit
		end if
	end if
next
return lb_commit
end function

on w_piss350u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.dw_save=create dw_save
this.dw_print=create dw_print
this.sle_kbno=create sle_kbno
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_sheet=create dw_sheet
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.dw_save
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.sle_kbno
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.dw_sheet
this.Control[iCurrent+10]=this.dw_2
end on

on w_piss350u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_save)
destroy(this.dw_print)
destroy(this.sle_kbno)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_sheet)
destroy(this.dw_2)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
end event

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_sheet, FULL)
//
//of_resize()
//
end event

event ue_retrieve;//long ll_count
//
//setpointer(hourglass!)
//ll_count = dw_1.retrieve(is_prddate,is_areacode,is_divisioncode)
//setpointer(arrow!)
//if ll_count = 0 then
//	messagebox("확인","조회된 자료가 없습니다.")
//	uo_date.setfocus()
//	return
//end if	
end event

event ue_save;int net
string ls_proofno
dw_sheet.accepttext()
string ls_tempkbsn,ls_kbsn,ls_applyfrom,ls_itemcode,ls_deptcode,ls_temp_kbno,ls_invgubunflag
long ll_invqty,ll_etcqty,i,ll_repairqty,ll_defectqty,ll_count,ll_totqty
string ls_projectno,ls_confirmno,ls_confirmno1,ls_yymm,ls_seqno,ls_shipgubun,ls_inputflag
string ls_deptshortname4
boolean lb_kb
long ll_inv_normal,ll_inv_defect,ll_inv_repair
lb_kb = true
if dw_sheet.rowcount() = 0 then
	return 
end if	
ls_inputflag = dw_sheet.object.inputflag[1]
ll_etcqty = dw_sheet.object.etcqty[1]
ls_itemcode = dw_sheet.object.itemcode[1]
ls_deptcode = dw_sheet.object.deptcode[1]
ls_projectno = trim(dw_sheet.object.projectno[1])
ls_shipgubun = trim(dw_sheet.object.shipgubun[1])
ls_invgubunflag = trim(dw_sheet.object.invgubunflag[1])
ls_confirmno1 = trim(dw_sheet.object.confirmno1[1])
ls_seqno = trim(dw_sheet.object.seqno[1])
ls_yymm = trim(dw_sheet.object.yymm[1])
ls_projectno = trim(dw_sheet.object.projectno[1])
ls_yymm = trim(dw_sheet.object.yymm[1])
ls_confirmno = ls_confirmno1 + ls_yymm + ls_seqno
dw_sheet.object.confirmno[1] = ls_confirmno

//if ls_shipgubun = '' or isnull(ls_shipgubun) then
//	messagebox("확인","출하구분을 입력하세요.")
//	dw_sheet.setfocus()
//	dw_sheet.setcolumn('shipgubun')
//	return 
//end if	
if ls_deptcode = '' or isnull(ls_deptcode) then
	messagebox("확인","부서를 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('deptcode')
	return 
end if	
select isnull(deptshortname4,'X')
  into :ls_deptshortname4
  from tmstdept
 where deptcode = :ls_deptcode
 using sqlpis;
if ls_deptshortname4 = 'D' then  //연구개발
	if ls_projectno = '' or isnull(ls_projectno) then
		messagebox("확인","프로젝트번호를 입력하세요.")
		dw_sheet.setfocus()
		dw_sheet.setcolumn('projectno')
		return 
	end if	
end if
if ls_itemcode = '' or isnull(ls_itemcode) then
	messagebox("확인","품번을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('itemcode')
	return 
end if	
if ll_etcqty = 0 or isnull(ll_etcqty) then
	messagebox("확인","수량을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('etcqty')
	return 
end if	
if ls_inputflag = '1' then
	if dw_2.rowcount() = 0 then
		messagebox("확인","간판을 Reading하세요.")
		sle_kbno.setfocus()
		lb_kb = false
	end if
	if lb_kb = true then
		ll_totqty = dw_2.object.totqty[1]
		if ll_totqty <> ll_etcqty then
			messagebox("확인","간판을 더 Reading 하세요.")
			sle_kbno.setfocus()
			lb_kb = false
		end if
	end if
end if		
if lb_kb = false then
	Net = MessageBox("확인","간판없이 출하하시겠읍니까?",Exclamation!, OKCancel!, 2)
	if net = 2 then
		return
	end if
end if		
if isnull(ls_deptcode) or ls_deptcode = '' then
	messagebox("확인","부서를 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('deptcode')
	return
end if	
if isnull(ls_itemcode) or ls_itemcode = '' then
	messagebox("확인","품번을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('itemcode')
	return
end if	
if isnull(ll_etcqty) or ll_etcqty <= 0 then
	messagebox("확인","수량을 확인하세요.")
	dw_sheet.object.etcqty[1] = 0
	dw_sheet.setfocus()
	dw_sheet.setcolumn('etcqty')
	return
end if	
ls_inputflag = dw_sheet.object.inputflag[1]
select invqty,repairqty,defectqty
  into :ll_inv_normal,:ll_inv_repair,:ll_inv_defect
  from tinv
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and itemcode     = :ls_itemcode
	using sqlpis;
if ls_inputflag = '1' then //출하
   if ls_invgubunflag = 'N' then //정품 
	   if ll_etcqty > ll_inv_normal then
			messagebox("확인","재고보다 수량이 큽니다.")
			dw_sheet.object.etcqty[1] = 0
			dw_sheet.setfocus()
			dw_sheet.setcolumn('etcqty')
			return
		end if
	end if
   if ls_invgubunflag = 'R' then //정품 
	   if ll_etcqty > ll_inv_repair then
			messagebox("확인","재고보다 수량이 큽니다.")
			dw_sheet.object.etcqty[1] = 0
			dw_sheet.setfocus()
			dw_sheet.setcolumn('etcqty')
			return
		end if
	end if
   if ls_invgubunflag = 'D' then //정품 
	   if ll_etcqty > ll_inv_defect then
			messagebox("확인","재고보다 수량이 큽니다.")
			dw_sheet.object.etcqty[1] = 0
			dw_sheet.setfocus()
			dw_sheet.setcolumn('etcqty')
			return
		end if
	end if
end if	
			
sqlpis.autocommit = false

//if ls_inputflag = '1' then //출하 

if wf_save(is_areacode,is_divisioncode,is_kbno) then

	if ls_inputflag = '2' then // 반납
	   if wf_create_kbno() then
         commit using sqlpis;
			sqlpis.autocommit = true
      else
			rollback using sqlpis;
         sqlpis.autocommit = true			
			messagebox("오류","간판생성시 오류 발생")			
		end if
	else
	   commit using sqlpis;	
		sqlpis.autocommit = true
	end if
else
	rollback using sqlpis;
	sqlpis.autocommit = true
end if

ls_proofno = dw_sheet.object.confirmno[1]
messagebox("확인",'증빙서 번호 : ' + mid(ls_proofno,1,3) + '-' + mid(ls_proofno,4,3) + '-' + right(ls_proofno,4))
dw_sheet.reset()
dw_2.reset()
sle_kbno.text = ''
sle_kbno.enabled = true
dw_sheet.setfocus()
dw_sheet.insertrow(0)
dw_sheet.setcolumn('inputflag')





end event

event ue_postopen;call super::ue_postopen;dw_save.settransobject(sqlpis)
dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_sheet.insertrow(0)
// dw_sheet.setcolumn('shipgubun')
dw_sheet.setfocus()
end event

event ue_insert;call super::ue_insert;dw_sheet.reset()
dw_sheet.setfocus()
dw_2.reset()
dw_sheet.insertrow(0)
sle_kbno.text = ''
//dw_sheet.setcolumn('shipgubun')
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss350u
integer y = 2152
end type

type uo_area from u_pisc_select_area within w_piss350u
integer x = 795
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_sheet.insertrow(0)
//is_divisioncode = is_uo_divisioncode
//if dw_sheet.rowcount() > 0 then
//	dw_sheet.object.confirmno1[1] = is_areacode + is_divisioncode + dw_sheet.object.shipgubun[1]
//end if	
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_empno					조회하고자 하는 사번 (지역별/공장별 권한에 따른 조회를 위하여)
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 공장 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (공장코드는 '%', 공장명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_divisioncode		선택된 공장 코드 (reference)
//						string			rs_divisionname		선택된 공장 명 (reference)
//						string			rs_divisionnameeng	선택된 공장 영문 명 (reference)
//	Returns		: none
//	Description	: 공장을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_piss350u
integer x = 1367
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_save.settransobject(sqlpis)
dw_sheet.reset()
dw_2.reset()
dw_sheet.insertrow(0)
is_divisioncode = is_uo_divisioncode
if dw_sheet.rowcount() > 0 then
	dw_sheet.object.confirmno1[1] = is_areacode + is_divisioncode + dw_sheet.object.shipgubun[1]
end if	
end event

type uo_date from u_pisc_date_applydate within w_piss350u
integer x = 55
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;is_prddate = is_uo_date
end event

event ue_select;call super::ue_select;if is_prddate <> is_uo_date then
	dw_sheet.reset()
end if	
is_prddate = is_uo_date
if dw_sheet.rowcount() > 0 then
	dw_sheet.object.confitm1[1] = is_areacode + is_divisioncode + dw_sheet.object.shipgubun[1]
	dw_sheet.object.yymm[1] = mid(is_prddate,4,1) + mid(is_prddate,6,2)
end if	
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_losefocus;call super::ue_losefocus;is_prddate = is_uo_date
end event

type dw_save from datawindow within w_piss350u
boolean visible = false
integer x = 832
integer y = 996
integer width = 937
integer height = 840
integer taborder = 120
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss220u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_piss350u
boolean visible = false
integer x = 1961
integer y = 1064
integer width = 411
integer height = 432
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss310i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_kbno from singlelineedit within w_piss350u
integer x = 3237
integer y = 256
integer width = 1006
integer height = 168
integer taborder = 60
boolean bringtotop = true
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
boolean autohscroll = false
textcase textcase = upper!
integer limit = 11
borderstyle borderstyle = stylelowered!
end type

event modified;
string ls_kbno 
long ll_count,ll_currentqty,ll_find,ll_totqty,ll_etcqty

if dw_2.rowcount() > 0 then
   ll_totqty = dw_2.object.totqty[1]
else
	ll_totqty = 0 
end if	
ll_etcqty = dw_sheet.object.etcqty[1]
if ll_totqty = ll_etcqty then
	sle_kbno.text = ''
	messagebox("확인","간판READING 완료하였읍니다.")
	return
end if	
ls_kbno = trim(sle_kbno.text)
if wf_kb_valid_check(ls_kbno) then
else	
	messagebox("확인","간판 번호를 확인하세요.")
	sle_kbno.text = ''
	sle_kbno.setfocus()
end if

select count(*)
  into :ll_count
  from tkb
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and kbno = :ls_kbno
	and kbactivegubun = 'A'
	and kbstatuscode = 'D'
	using sqlpis;
if ll_count = 0 then
	messagebox("확인","간판번호를 확인하세요.")
	sle_kbno.text = ''
	sle_kbno.setfocus()
   return
end if	

ll_find = dw_2.find("kbno = '" + ls_kbno + "'" ,1,dw_2.rowcount())
if ll_find > 0 then
	messagebox("확인","이미 READING한 간판번호입니다.")
	sle_kbno.text = ''
	sle_kbno.setfocus()
   return
end if	
select currentqty
  into :ll_currentqty
  from tkb
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and kbno = :ls_kbno
	and kbactivegubun = 'A'
	and kbstatuscode = 'D'
	using sqlpis;
 
dw_2.insertrow(1)
ll_totqty = dw_2.object.totqty[1]
ll_etcqty = dw_sheet.object.etcqty[1]
dw_2.object.kbno[1] = ls_kbno
dw_2.object.currentqty[1] = ll_currentqty
if ll_etcqty - ll_totqty >= ll_currentqty then
	dw_2.object.readingqty[1] = ll_currentqty
else
	dw_2.object.readingqty[1] = ll_etcqty - ll_totqty
	messagebox("확인","간판READING 완료하였읍니다.")	
end if
if ll_currentqty <> dw_2.object.readingqty[1] then
	messagebox("확인","짜투리 간판으로 사용하십시요.")
end if	
sle_kbno.text = ''
sle_kbno.setfocus()
end event

type gb_1 from groupbox within w_piss350u
integer x = 23
integer y = 28
integer width = 2016
integer height = 172
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
end type

type gb_2 from groupbox within w_piss350u
integer x = 3131
integer y = 192
integer width = 1271
integer height = 264
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "간판번호"
end type

type dw_sheet from datawindow within w_piss350u
event ue_post_change ( )
integer x = 27
integer y = 224
integer width = 3067
integer height = 752
integer taborder = 50
string title = "none"
string dataobject = "d_piss350u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_post_change;string ls_inputflag
ls_inputflag = dw_sheet.object.inputflag[1]
if ls_inputflag = '1' then
	sle_kbno.enabled = true
else
	sle_kbno.enabled = false
end if
sle_kbno.text = ''
dw_2.reset()
end event

event itemchanged;this.accepttext()
if dwo.name = 'inputflag' then
	postevent('ue_post_change')
end if	

if wf_errchk(dwo.name) = false then
    return 1
end if	 

end event

event itemerror;return 1
end event

event losefocus;dw_sheet.accepttext()
end event

type dw_2 from datawindow within w_piss350u
integer x = 3131
integer y = 468
integer width = 1271
integer height = 1628
integer taborder = 130
string title = "none"
string dataobject = "d_piss350u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

