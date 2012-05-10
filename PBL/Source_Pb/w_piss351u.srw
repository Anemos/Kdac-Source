$PBExportHeader$w_piss351u.srw
$PBExportComments$사내출하및반납입력(군산용)
forward
global type w_piss351u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss351u
end type
type uo_division from u_pisc_select_division within w_piss351u
end type
type uo_date from u_pisc_date_applydate within w_piss351u
end type
type gb_1 from groupbox within w_piss351u
end type
type dw_sheet from datawindow within w_piss351u
end type
type ddlb_1 from dropdownlistbox within w_piss351u
end type
type st_2 from statictext within w_piss351u
end type
end forward

global type w_piss351u from w_ipis_sheet01
integer width = 4571
integer height = 2356
string title = "제품입고정보입력"
uo_area uo_area
uo_division uo_division
uo_date uo_date
gb_1 gb_1
dw_sheet dw_sheet
ddlb_1 ddlb_1
st_2 st_2
end type
global w_piss351u w_piss351u

type variables
string is_kbno,is_itemgubun
string is_areacode,is_divisioncode,is_prddate,is_itemcode,is_productgroup
long  il_qty
end variables

forward prototypes
public function boolean wf_update_tshipetc ()
public function boolean wf_update_tlotno (string fs_close_date, string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, string fs_shipgubun, integer fl_shipqty)
public function boolean wf_errchk (string fs_column)
public function boolean wf_update_tseqinv (string fs_custcode, string fs_custitemcode, long fl_shipqty)
public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate)
end prototypes

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
	uo_status.st_message.text = "tstocketc error : " + sqlpis.sqlerrtext
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
	uo_status.st_message.text = "tlotno : " + sqlpis.sqlerrtext
	return false
end if
return true

end function

public function boolean wf_errchk (string fs_column);string ls_deptcode,ls_deptname,ls_itemcode,ls_itemname,ls_itemspec,ls_itemtype,ls_item_check
string ls_shipgubun,ls_seqno,ls_confirmno,ls_confirmno1,ls_yymm
long   ll_etcqty,ll_count
string ls_itemclass,ls_itembuysource
string ls_deptshortname4,ls_projectname,ls_projectno
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
		    into :ls_deptname, :ls_deptshortname4
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
			  dw_sheet.settaborder('projectno',0)
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
			if is_itemgubun = 'Y' then
				select itemcode into :ls_itemcode from tseqmstitem
					where customeritemcode = :ls_itemcode using sqlpis ;
				if sqlca.sqlcode <> 0 then 
					ls_itemcode = '' 
				end if
			end if
		  	select itemname,itemspec
		    into :ls_itemname,:ls_itemspec
			 from TMSTITEM
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
 		  dw_sheet.object.itemcode[1] = ls_itemcode
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
END CHOOSE

return true
end function

public function boolean wf_update_tseqinv (string fs_custcode, string fs_custitemcode, long fl_shipqty);string ls_Areacode,ls_Divisioncode,ls_itemcode,ls_partid
long ln_rowcount,ln_stockqty

select areacode,divisioncode,itemcode,partid into :ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid from tseqmstitem
	where customercode = :fs_custcode and customeritemcode = :fs_custitemcode
using sqlpis ;
if sqlpis.sqlcode <> 0 then
	return true
end if

select stockqty into :ln_stockqty from tseqinv
	where 	areacode = :ls_areacode and divisioncode = :ls_divisioncode 
	and	 	itemcode = :ls_itemcode and partid = :ls_partid
using sqlpis ;
if isnull(ln_stockqty) or ( ln_stockqty - fl_shipqty ) < 0 then
	return false
elseif ln_rowcount = 1 then
	update	tseqinv
		set	stockqty	=	stockqty	- :fl_shipqty
	where	areacode = :ls_areacode and divisioncode 	= 	:ls_divisioncode	
	and 	itemcode = :ls_itemcode and partid			= 	:ls_partid
	using sqlpis ;
	if sqlpis.sqlnrows <> 1 then
		return false
	end if
end if

ln_rowcount = 0
select count(*) into :ln_rowcount from tseqtrans
	where 	areacode = :ls_areacode and divisioncode = :ls_divisioncode 
	and	 	itemcode = :ls_itemcode and partid = :ls_partid and tracedate	=	:is_prddate 
using sqlpis ;

if isnull(ln_rowcount) or ln_rowcount = 0 then
		insert into tseqtrans
		values	( :is_prddate,:ls_areacode,:ls_divisioncode,:ls_itemcode,:ls_partid,0,0,:fl_shipqty,:g_s_empno,getdate())
		using	sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
elseif ln_rowcount = 1 then
		update	tseqtrans
			set	shipqty	=	shipqty + :fl_shipqty
		where	areacode = :ls_areacode and divisioncode 	= 	:ls_divisioncode	
		and 	itemcode = :ls_itemcode and partid			= 	:ls_partid and tracedate = :is_prddate
		using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			return false
		end if
end if

return true
end function

public function boolean wf_save (string fs_areacode, string fs_divisioncode, string fs_applydate);dw_sheet.accepttext()
string ls_tempkbsn,ls_kbsn,ls_applyfrom,ls_itemcode,ls_deptcode,ls_temp_kbno,ls_custcode 
long ll_invqty,ll_etcqty,i,ll_repairqty,ll_defectqty,ll_count,ll_totqty
string ls_projectno,ls_confirmno,ls_confirmno1,ls_yymm,ls_seqno,ls_shipgubun,ls_inputflag
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
	   uo_status.st_message.text = "Tlotno 출하시 오류가 발생하였습니다."
      Return false
	end if
	if is_areacode = 'K' or is_areacode = 'B' then
		if is_areacode = 'K' then ls_custcode = 'L10502'
		if is_areacode = 'B' then ls_custcode = 'L10500'
		if not wf_update_tseqinv(ls_custcode,ls_itemcode,ll_etcqty) then
			Return false
		end if
	end if
end if

if ls_inputflag = '2' then //반납
   if not wf_update_tlotno(ls_close_date,is_areacode,is_divisioncode,'XXXXXX',ls_itemcode,ls_shipgubun,ll_etcqty * -1) then
	   uo_status.st_message.text = "Tlotno 반납시 오류가 발생하였습니다."
      Return false
	end if
	if is_areacode = 'K' or is_areacode = 'B' then	
		if is_areacode = 'K' then ls_custcode = 'L10502'
		if is_areacode = 'B' then ls_custcode = 'L10500'
		if not wf_update_tseqinv(ls_custcode,ls_itemcode,ll_etcqty * -1) then
			Return false
		end if
	end if
end if

//창고 입고시 tinv
if wf_update_tshipetc() = false then
	uo_status.st_message.text = "Tshipetc insert시 오류가 발생하였습니다."
   Return false
End if
select count(*)
  into :ll_count
  from tinv
 where ItemCode		= :ls_itemcode
	and areacode      = :fs_areacode
	and divisioncode  = :fs_divisioncode
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
	uo_status.st_message.text = "TINV insert시 오류가 발생하였습니다."
	Return false
End if

return true
end function

on w_piss351u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.gb_1=create gb_1
this.dw_sheet=create dw_sheet
this.ddlb_1=create ddlb_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.dw_sheet
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.st_2
end on

on w_piss351u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.gb_1)
destroy(this.dw_sheet)
destroy(this.ddlb_1)
destroy(this.st_2)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)

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
string ls_tempkbsn,ls_kbsn,ls_applyfrom,ls_itemcode,ls_deptcode,ls_temp_kbno
long ll_invqty,ll_etcqty,i,ll_repairqty,ll_defectqty,ll_count,ll_totqty
string ls_projectno,ls_confirmno,ls_confirmno1,ls_yymm,ls_seqno,ls_shipgubun,ls_inputflag
string ls_deptshortname4
if dw_sheet.rowcount() = 0 then
	return 
end if	
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
//if ls_shipgubun = '' or isnull(ls_shipgubun) then
//	messagebox("확인","출하구분을 입력하세요.")
//	dw_sheet.setfocus()
////	dw_sheet.setcolumn('shipgubun')
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

//if ls_itemcode = '' or isnull(ls_itemcode) then
//	messagebox("확인","품번을 입력하세요.")
//	dw_sheet.setfocus()
//	dw_sheet.setcolumn('itemcode')
//	return 
//end if	
if ll_etcqty = 0 or isnull(ll_etcqty) then
	messagebox("확인","수량을 입력하세요.")
	dw_sheet.setfocus()
	dw_sheet.setcolumn('etcqty')
	return 
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

sqlpis.autocommit = false
ls_inputflag = dw_sheet.object.inputflag[1]

if wf_save(is_areacode,is_divisioncode,is_kbno) then
   commit using sqlpis;
	sqlpis.autocommit = true
	ls_proofno = dw_sheet.object.confirmno[1]
   messagebox("확인",'증빙서 번호 : ' + mid(ls_proofno,1,3) + '-' + mid(ls_proofno,4,3) + '-' + right(ls_proofno,4))
else
	rollback using sqlpis;
	sqlpis.autocommit = true
end if

dw_sheet.reset()

dw_sheet.setfocus()
dw_sheet.insertrow(0)
dw_sheet.setcolumn('inputflag')





end event

event ue_postopen;call super::ue_postopen;dw_sheet.insertrow(0)
//dw_sheet.setcolumn('shipgubun')
dw_sheet.setfocus()
end event

event ue_insert;call super::ue_insert;if is_itemgubun = 'N' then
	dw_sheet.object.itemcode_t.text = 'KDAC품번'
elseif is_itemgubun = 'Y' then
	dw_sheet.object.itemcode_t.text = '거래처품번'
else
	dw_sheet.object.itemcode_t.text = ''
end if
dw_sheet.reset()
dw_sheet.setfocus()
dw_sheet.insertrow(0)
//dw_sheet.setcolumn('shipgubun')
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss351u
integer y = 2152
end type

type uo_area from u_pisc_select_area within w_piss351u
integer x = 795
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_sheet.insertrow(0)
//dw_sheet.setcolumn('shipgubun')
dw_sheet.setfocus()
///////////////////////////////////////////////////////////////////////////////////////////////////////////
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

type uo_division from u_pisc_select_division within w_piss351u
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
dw_sheet.reset()
dw_sheet.insertrow(0)
is_divisioncode = is_uo_divisioncode
if dw_sheet.rowcount() > 0 then
	dw_sheet.object.confirmno1[1] = is_areacode + is_divisioncode + dw_sheet.object.shipgubun[1]
end if	
end event

type uo_date from u_pisc_date_applydate within w_piss351u
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

type gb_1 from groupbox within w_piss351u
integer x = 23
integer y = 28
integer width = 3077
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

type dw_sheet from datawindow within w_piss351u
event ue_post_change ( )
integer x = 32
integer y = 224
integer width = 3067
integer height = 752
integer taborder = 50
string title = "none"
string dataobject = "d_piss350u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

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

type ddlb_1 from dropdownlistbox within w_piss351u
integer x = 2363
integer y = 96
integer width = 549
integer height = 324
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string item[] = {"비서열품","서열품"}
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = "비서열품"
is_itemgubun = 'N'

end event

event selectionchanged;if index = 1 then
	is_itemgubun = 'N'
	dw_sheet.object.itemcode_t.text = 'KDAC품번'
elseif index = 2 then
	is_itemgubun = 'Y'
	dw_sheet.object.itemcode_t.text = '거래처품번'
else
	is_itemgubun = ' '
	dw_sheet.object.itemcode_t.text = ''
end if
dw_sheet.reset()
dw_sheet.setfocus()
dw_sheet.insertrow(0)
end event

type st_2 from statictext within w_piss351u
integer x = 2025
integer y = 108
integer width = 315
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "품목구분:"
boolean focusrectangle = false
end type

