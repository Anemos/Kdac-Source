$PBExportHeader$w_piss360u.srw
$PBExportComments$현품표취소
forward
global type w_piss360u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss360u
end type
type uo_division from u_pisc_select_division within w_piss360u
end type
type sle_1 from singlelineedit within w_piss360u
end type
type dw_sheet from u_vi_std_datawindow within w_piss360u
end type
type st_2 from statictext within w_piss360u
end type
type gb_1 from groupbox within w_piss360u
end type
type gb_2 from groupbox within w_piss360u
end type
end forward

global type w_piss360u from w_ipis_sheet01
integer width = 4475
integer height = 2612
string title = "현품표취소"
uo_area uo_area
uo_division uo_division
sle_1 sle_1
dw_sheet dw_sheet
st_2 st_2
gb_1 gb_1
gb_2 gb_2
end type
global w_piss360u w_piss360u

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
boolean ib_open
end variables

forward prototypes
public function boolean wf_update_tlotno (string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, long fl_cancelqty)
public function boolean wf_save ()
public function boolean wf_err_check ()
public function boolean wf_kb_valid_check (string fs_areacode, string fs_divisioncode, string fs_kbno)
public function boolean wf_update_tstock_interface (string fs_areacode, string fs_divisioncode, string fs_kbno, string fs_itemcode, long fl_cancelqty)
end prototypes

public function boolean wf_update_tlotno (string fs_areacode, string fs_divisioncode, string fs_lotno, string fs_itemcode, long fl_cancelqty);string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())
long ll_count
select count(*)
  into :ll_count
  from tlotno
  where tracedate    = :ls_close_date
    and areacode     = :fs_areacode
	 and divisioncode = :fs_divisioncode
	 and lotno        = :fs_lotno
	 and itemcode     = :fs_itemcode
	 and custcode     = 'XXXXXX'
	 and shipgubun    = 'X'
	 using sqlpis;
if ll_count > 0 then
	update tlotno 
	   set stockqty = stockqty - :fl_cancelqty
  where tracedate    = :ls_close_date
    and areacode     = :fs_areacode
	 and divisioncode = :fs_divisioncode
	 and lotno        = :fs_lotno
	 and itemcode     = :fs_itemcode
	 and custcode     = 'XXXXXX'
	 and shipgubun    = 'X'
	 using sqlpis;
else
	  INSERT INTO TLOTNO  
         ( TraceDate,AreaCode,DivisionCode,LotNo,ItemCode,CustCode,ShipGubun,   
           ShipUsage,PrdQty,StockQty,ShipQty,LastEmp,LastDate )  
          VALUES 
         ( :ls_close_date,:fs_areacode,:fs_divisioncode,:fs_lotno,:fs_itemcode,'XXXXXX','X',   
           'X',0,:fl_cancelqty * -1,0,'Y',getdate() ) 
			  using sqlpis;
end if			  
return true
end function

public function boolean wf_save ();long ll_rowcount,i,ll_cancelqty,ll_currentqty,ll_count,ll_invqty,ll_defectqty,ll_repairqty
string ls_kbno,ls_kbstatuscode,ls_itemcode,ls_invgubunflag,ls_lotno,ls_item_type
dw_sheet.accepttext()
ll_rowcount = dw_sheet.rowcount()
boolean lb_commit
lb_commit = true

for i=1 to ll_rowcount step 1
	 ls_kbno = dw_sheet.object.kbno[i]
	 ll_cancelqty = dw_sheet.object.cancelqty[i]
	 ll_currentqty = dw_sheet.object.currentqty[i]
	 ls_kbno = dw_sheet.object.kbno[i]
	 ls_itemcode = dw_sheet.object.itemcode[i]
	 if ll_cancelqty = ll_currentqty then
		 ls_kbstatuscode = 'F'
	 else
		 ls_kbstatuscode = 'D'
	 end if
    ls_item_type = f_piss_itemtype_check(is_areacode,is_divisioncode,ls_itemcode)
	 if ll_cancelqty > 0 then
		 if ls_item_type <> '2' then //상품은 인터페이스안함 
			 if not wf_update_tstock_interface(is_areacode,is_divisioncode,ls_kbno,ls_itemcode,ll_cancelqty) then
				 lb_commit = false
				 exit
			 end if
  		 end if
		 select invgubunflag,lotno
		   into :ls_invgubunflag,:ls_lotno
			from tkb
		 where areacode     =  :is_areacode
		   and divisioncode = :is_divisioncode
			and kbno         = :ls_kbno
		 using sqlpis;
		 if ls_invgubunflag = 'D' then
			 ll_defectqty = ll_cancelqty
		 elseif ls_invgubunflag = 'R' then
			     ll_repairqty = ll_cancelqty
		 else 
			ll_invqty = ll_cancelqty
		 end if
				  
		 update tkb
		   set currentqty   = currentqty - :ll_cancelqty,
			    kbstatuscode = :ls_kbstatuscode,
				 lastemp      = 'Y',
				 lastdate     = getdate()
		 where areacode     =  :is_areacode
		   and divisioncode = :is_divisioncode
			and kbno         = :ls_kbno
		 using sqlpis;
		 if sqlpis.sqlcode <> 0 then
			 lb_commit = false
			 exit
		 end if
		 update tkbhis
		   set currentqty   = currentqty - :ll_cancelqty,
			    kbstatuscode = :ls_kbstatuscode,
				 lastdate     = getdate(),
				 lastemp      = 'Y'
		 where areacode     =  :is_areacode
		   and divisioncode = :is_divisioncode
			and kbno         = :ls_kbno
			and kbstatuscode = 'D'
		 using sqlpis;
		 if sqlpis.sqlcode <> 0 then
			 lb_commit = false
			 exit
		 end if
		 if not wf_update_tlotno(is_areacode,is_divisioncode,ls_lotno,ls_itemcode,ll_cancelqty) then
			 lb_commit = false
			 exit
		 end if
		 select count(*)
		   into :ll_count
			from tinv
        WHERE itemcode 	   = :ls_itemcode
	       And areacode     = :is_areacode
	       and divisioncode = :is_divisioncode
	     using sqlpis;
		 if ll_count > 0 then
			 UPDATE tinv
				 SET invqty	     = invqty - :ll_invqty,
				     repairqty   = repairqty - :ll_repairqty,
					  defectqty   = defectqty - :ll_defectqty,
					  LastEmp		  = 'Y',
					  LastDate	  = GetDate()
			  WHERE itemcode 	   = :ls_itemcode
				 And areacode     = :is_areacode
				 and divisioncode = :is_divisioncode
			  using sqlpis;
		else
			  INSERT INTO TINV  
							 (Areacode,DivisionCode,ItemCode,InvQty,RepairQty,DefectQty,   
							  MoveInvQty,ShipInvQty,InvCompute,LastEmp,LastDate )  
				  VALUES ( :is_areacode,:is_divisioncode,:ls_itemcode,:ll_invqty * -1,:ll_repairqty * -1,:ll_defectqty * -1,
				           0,0,null,'Y',getdate() ) 
							  using sqlpis;
		end if
		if sqlpis.sqlcode <> 0 then
			uo_status.st_message.text = '재고정보 저장에 오류가 발생하였습니다. '+  sqlpis.sqlerrtext
			lb_commit = false
			exit
		End If
	 end if
next	 
return lb_commit
end function

public function boolean wf_err_check ();long ll_count

dw_sheet.accepttext()
ll_count = dw_sheet.rowcount()
if ll_count < 1 then
	return false
end if	

long   ll_currentqty,ll_cancelqty,ll_invqty,i
string ls_itemcode

for i = 1 to ll_count
	
	ll_currentqty = dw_sheet.object.currentqty[i]
	ll_cancelqty  = dw_sheet.object.cancelqty[i]
	ls_itemcode   = dw_sheet.object.itemcode[i]
	
	select invqty
		into :ll_invqty
		from tinv
	  WHERE itemcode 	   = :ls_itemcode
		 And areacode     = :is_areacode
		 and divisioncode = :is_divisioncode
	  using sqlpis;
	  
	if ll_cancelqty > ll_invqty then
		messagebox("확인","취소 수량이 현재고수량 보다 큽니다.")
		dw_sheet.object.cancelqty[i] = 0
		dw_sheet.setfocus()
		dw_sheet.setcolumn('cancelqty')
		dw_sheet.setrow(i)
		return false
	end if
	
	if ll_cancelqty > ll_currentqty then
		messagebox("확인","취소 수량이 잔량 보다 큽니다.")
		dw_sheet.object.cancelqty[i] = 0
		dw_sheet.setfocus()
		dw_sheet.setcolumn('cancelqty')
		dw_sheet.setrow(i)
		return false
	end if
next


return true
end function

public function boolean wf_kb_valid_check (string fs_areacode, string fs_divisioncode, string fs_kbno);Integer	li_count
long   ll_currentqty
string ls_kbstatuscode,ls_kbactivegubun,ls_inspectgubun,ls_stockgubun,ls_itemcode,ls_itemname
if mid(fs_kbno,3,1) <> 'Z' then
   messagebox("확인","현품표가 아닙니다.")
   return false
end if

SELECT Count(a.KBNO),kbstatuscode,kbactivegubun,currentqty,itemcode
  into :li_count,:ls_kbstatuscode,:ls_kbactivegubun,:ll_currentqty,:ls_itemcode
  FROM TKB a
 WHERE	a.AreaCode	   = :is_areacode
   and   a.DivisionCode	= :is_divisioncode
   and	a.KBNO			= :fs_kbno
	and	a.KBActiveGubun	= 'A'
GROUP BY kbstatuscode,kbactivegubun,currentqty,itemcode
	using sqlpis;
if (li_count = 0) or isnull(li_count) then	
   messagebox("확인","올바르지 않는 간판입니다.")
   return false
end if
if (ls_kbstatuscode <> 'D') then
   messagebox("확인","미입고된 간판입니다.")
   return false
end if	
select itemname
  into :ls_itemname
  from tmstitem
 where itemcode = :ls_itemcode
 using sqlpis;
long ll_find
ll_find = dw_sheet.find("itemcode = '" + ls_itemcode + "'", 1, dw_sheet.rowcount())
if ll_find  > 0 then
	messagebox("확인","이미 해당품번이 존재합니다.같은 품번의 동시 취소작업은 불가. 하나씩만 별도로 취소작업 가능" )
   return false
end if
dw_sheet.insertrow(1)
dw_sheet.object.kbno[1] = fs_kbno
dw_sheet.object.itemcode[1] = ls_itemcode
dw_sheet.object.itemname[1] = ls_itemname
dw_sheet.object.currentqty[1] = ll_currentqty
dw_sheet.object.cancelqty[1] = ll_currentqty
Return True

end function

public function boolean wf_update_tstock_interface (string fs_areacode, string fs_divisioncode, string fs_kbno, string fs_itemcode, long fl_cancelqty);string ls_kbreleasedate,ls_workcenter,ls_linecode,ls_itemcode,ls_supplygubun,ls_hostworkcenter,ls_hostlinecode
string ls_stockdate,ls_invgubunflag,ls_deptcode,ls_releasegubun

string ls_close_date  //마감일자
ls_close_date = f_pisc_get_date_applydate_close("%", "%",f_pisc_get_date_nowtime())

long ll_seqno,ll_kbreleaseseq,ll_rackqty,ll_cancelqty 

select kbreleasedate,kbreleaseseq,workcenter,linecode,itemcode,stockdate,invgubunflag,releasegubun,rackqty
  into :ls_kbreleasedate,:ll_kbreleaseseq,:ls_workcenter,:ls_linecode,:ls_itemcode,:ls_stockdate,:ls_invgubunflag,:ls_releasegubun,:ll_rackqty
  from tkbhis
  where kbno = :fs_kbno
    and kbstatuscode = 'D'
 using sqlpis;
select supplygubun,hostworkcenter,hostlinecode
  into :ls_supplygubun,:ls_hostworkcenter,:ls_hostlinecode
  from tmstline
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
	and workcenter = :ls_workcenter
	and linecode = :ls_linecode
 using sqlpis;
if ls_supplygubun = 'Y' then
	ls_workcenter = ls_hostworkcenter
	ls_linecode   = ls_hostlinecode
end if	

if (left(ls_stockdate,7) <> left(ls_close_date,7)) or (ls_workcenter = 'XXXX') or & 
   trim(ls_releasegubun) = 'C' or ( fl_cancelqty <> ll_rackqty ) then  //월이 틀리거나 조가 'XXXX' , 출하 취소건인경우
	  if ls_workcenter = 'XXXX' then 
   	   select deptcode
         into :ls_deptcode
         from tmstemp
         where empno = :g_s_empno
         using sqlpis;
	  end if	
      
		if ls_deptcode = '' or isnull(ls_deptcode) then
       	ls_deptcode = 'XXXX'
      end if
		
		select max(seqno)
		into :ll_seqno
		from tstockcancel_interface
		where kbno          = :fs_kbno
		  and kbreleasedate = :ls_kbreleasedate
		  and kbreleaseseq  = :ll_kbreleaseseq
		  and misflag       = 'D'
		  using sqlpis;
	if isnull(ll_seqno) then	  
		ll_seqno = 0
	end if
	ll_seqno = ll_seqno + 1
	
	INSERT INTO Tstockcancel_interface  
			( kbno,kbreleasedate,kbreleaseseq,seqno,   
			  stockdate,areacode,divisioncode,workcenter,linecode,
			  itemcode,stockqty,
			  misflag,interfaceflag,lastemp,lastdate)
	VALUES (:fs_kbno,:ls_kbreleasedate,:ll_kbreleaseseq,:ll_seqno,
			  :ls_close_date,:is_areacode,:is_divisioncode,:ls_deptcode,:ls_invgubunflag,
			  :ls_itemcode,:fl_cancelqty,
			  'A','Y',:g_s_empno,getdate())
		using sqlpis;
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = "tstockcancel_interface error : " + sqlpis.sqlerrtext
		return false
	end if
else   //월이 같으면 
	select max(seqno)
		into :ll_seqno
		from tstock_interface
		where kbno          = :fs_kbno
		  and kbreleasedate = :ls_kbreleasedate
		  and kbreleaseseq  = :ll_kbreleaseseq
		  and misflag       = 'D'
		  using sqlpis;
	if isnull(ll_seqno) then	  
		ll_seqno = 0
	end if
	ll_seqno = ll_seqno + 1
	INSERT INTO Tstock_interface  
			( kbno,kbreleasedate,kbreleaseseq,seqno,   
			  stockdate,areacode,divisioncode,workcenter,linecode,
			  itemcode,stockqty,
			  misflag,interfaceflag,lastemp,lastdate)
	VALUES (:fs_kbno,:ls_kbreleasedate,:ll_kbreleaseseq,:ll_seqno,
			  :ls_stockdate,:is_areacode,:is_divisioncode,:ls_workcenter,:ls_linecode,
			  :ls_itemcode,:fl_cancelqty,
			  'D','Y',:g_s_empno,getdate())
		using sqlpis;
	if sqlpis.sqlcode <> 0 then
		uo_status.st_message.text = "tstock_interface error : " + sqlpis.sqlerrtext
		return false
	end if
end if
return true

end function

on w_piss360u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.sle_1=create sle_1
this.dw_sheet=create dw_sheet
this.st_2=create st_2
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.sle_1
this.Control[iCurrent+4]=this.dw_sheet
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_piss360u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.sle_1)
destroy(this.dw_sheet)
destroy(this.st_2)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname

f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)

ib_open = true

sle_1.setfocus()
end event

event ue_save;if not wf_err_check() then
   return 
end if	
sqlpis.autocommit = false
dw_sheet.accepttext()
if wf_save() then
	commit using sqlpis;
   sqlpis.autocommit = true
	messagebox("확인","작업이 완료되었읍니다.")
else
	rollback using sqlpis;
	sqlpis.autocommit = true
end if

dw_sheet.reset()
sle_1.text = ''
sle_1.setfocus()
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss360u
integer x = 18
integer y = 2404
end type

type uo_area from u_pisc_select_area within w_piss360u
integer x = 137
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname

is_areacode = is_uo_areacode
if ib_open = true then
	f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
end if
dw_sheet.reset()
sle_1.text = ''
sle_1.setfocus()

end event

event ue_post_constructor;call super::ue_post_constructor;is_areacode = is_uo_areacode
end event

type uo_division from u_pisc_select_division within w_piss360u
integer x = 709
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
string ls_productgroupname,ls_modelgroupname,ls_itemname
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
sle_1.text = ''
sle_1.setfocus()

end event

type sle_1 from singlelineedit within w_piss360u
integer x = 1335
integer y = 76
integer width = 699
integer height = 128
integer taborder = 70
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
textcase textcase = upper!
integer limit = 11
borderstyle borderstyle = stylelowered!
end type

event modified;If wf_kb_valid_check(is_areacode,is_divisioncode,This.Text) Then
Else
//	MessageBox("확인", "올바르지 않은 간판입니다." + "~r~n"+ "간판번호를 확인한 후, Scanning하여 주십시오...")
End if
this.text = ''
this.setfocus()
end event

type dw_sheet from u_vi_std_datawindow within w_piss360u
integer x = 37
integer y = 232
integer width = 1911
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_piss360u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;//this.accepttext()
//if wf_err_check( ) = false then  
//    return 1
//end if	   
end event

type st_2 from statictext within w_piss360u
integer x = 2130
integer y = 88
integer width = 1486
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "저장시 재고에서 취소 수량만큼 빠집니다."
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss360u
integer x = 23
integer y = 28
integer width = 1280
integer height = 184
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

type gb_2 from groupbox within w_piss360u
integer x = 1294
integer y = 8
integer width = 777
integer height = 224
integer taborder = 70
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

