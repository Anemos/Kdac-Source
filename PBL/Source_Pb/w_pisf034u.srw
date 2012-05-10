$PBExportHeader$w_pisf034u.srw
$PBExportComments$반출증작성및승인요청
forward
global type w_pisf034u from w_cmms_sheet01
end type
type uo_area from u_cmms_select_area within w_pisf034u
end type
type uo_division from u_cmms_select_division within w_pisf034u
end type
type rb_1 from radiobutton within w_pisf034u
end type
type rb_2 from radiobutton within w_pisf034u
end type
type cbx_1 from checkbox within w_pisf034u
end type
type st_2 from statictext within w_pisf034u
end type
type pb_1 from picturebutton within w_pisf034u
end type
type dw_condition from datawindow within w_pisf034u
end type
type dw_buyback from datawindow within w_pisf034u
end type
type dw_2 from datawindow within w_pisf034u
end type
type gb_1 from groupbox within w_pisf034u
end type
type gb_2 from groupbox within w_pisf034u
end type
type gb_3 from groupbox within w_pisf034u
end type
type gb_4 from groupbox within w_pisf034u
end type
type gb_5 from groupbox within w_pisf034u
end type
type gb_6 from groupbox within w_pisf034u
end type
end forward

global type w_pisf034u from w_cmms_sheet01
string title = "반출증 승인요청"
event ue_init ( )
uo_area uo_area
uo_division uo_division
rb_1 rb_1
rb_2 rb_2
cbx_1 cbx_1
st_2 st_2
pb_1 pb_1
dw_condition dw_condition
dw_buyback dw_buyback
dw_2 dw_2
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
end type
global w_pisf034u w_pisf034u

type variables
String	is_deptname, is_empname, is_buybackflag, is_chkrb

boolean ib_opened = false
end variables

event ue_init();pb_1.Enabled =  m_frame.m_action.m_save.Enabled 

if f_spacechk(gs_kmarea) = -1 or &
   f_spacechk(gs_kmdivision) = -1 then
	return 
end if

SELECT cc_name  
	INTO :is_deptname  
	FROM cc_master  
	WHERE cc_code = :g_s_deptcd
	USING	sqlcmms;

is_empname = g_s_kornm

dw_buyback.SetItem( 1, 'areacode'		, gs_kmarea )
dw_buyback.SetItem( 1, 'divisioncode'	, gs_kmdivision )
dw_buyback.SetItem( 1, 'buybackdept'	, g_s_deptcd )
dw_buyback.SetItem( 1, 'cc_name'		, is_deptname )
dw_buyback.SetItem( 1, 'buybackemp'		, g_s_empno )
dw_buyback.SetItem( 1, 'empname'			, is_empname )
end event

on w_pisf034u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.rb_1=create rb_1
this.rb_2=create rb_2
this.cbx_1=create cbx_1
this.st_2=create st_2
this.pb_1=create pb_1
this.dw_condition=create dw_condition
this.dw_buyback=create dw_buyback
this.dw_2=create dw_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.rb_2
this.Control[iCurrent+5]=this.cbx_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.pb_1
this.Control[iCurrent+8]=this.dw_condition
this.Control[iCurrent+9]=this.dw_buyback
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.gb_5
this.Control[iCurrent+16]=this.gb_6
end on

on w_pisf034u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.cbx_1)
destroy(this.st_2)
destroy(this.pb_1)
destroy(this.dw_condition)
destroy(this.dw_buyback)
destroy(this.dw_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
end on

event open;call super::open;
dw_condition.SetTransObject(sqlcmms)
dw_condition.Reset()
dw_condition.InsertRow(1)
dw_condition.Object.suppliercode_t.Text = '반출처:'

dw_buyback.SetTransObject(sqlcmms)
dw_buyback.reset()
dw_buyback.InsertRow(1)

dw_2.settransobject(sqlcmms)
dw_2.reset()

rb_1.Checked = True
is_chkrb = 'rb_1'
dw_buyback.object.buybackno.protect = 1
rb_1.Weight = 700

wf_icon_onoff(true,  false,  true,  false,  false,  false,  false,  false)
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 5 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 120 // statusbar 의 높이는 120 ( Gap 포함 )

dw_2.Width = newwidth 	- ( dw_2.x + ls_gap * 2 )
dw_2.Height= newheight 	- ( dw_2.y + ls_status )
end event

event ue_postopen;call super::ue_postopen;
This.TriggerEvent( "ue_init" )
pb_1.enabled = false
cbx_1.checked = true
end event

event ue_retrieve;call super::ue_retrieve;
String	ls_usecenter
Long 		ll_Row
String	ls_BuyBackNo, ls_status

dw_condition.AcceptText()
ls_usecenter	= dw_condition.GetItemString(1, 'suppliercode')

If isNull(ls_usecenter) Or Trim(ls_usecenter) = '' Then 
	MessageBox('확인', '반출처를 입력하세요.', Information! )
	return
else
	dw_buyback.setitem(1,'BuybackSupplier',ls_usecenter)
End If

dw_buyback.AcceptText()
ls_BuyBackNo = dw_buyback.GetItemString(1, 'buybackno')

If isNull(ls_BuyBackNo) Or Trim(ls_BuyBackNo) = '' then 
	//MessageBox('확인', '발행할 발주서번호가 입력되지 않았습니다.', Information! )
	if rb_2.checked = true then
		
		select top 1 buybackno into :ls_buybackno
		from part_buyback
		where areacode = :gs_kmarea and divisioncode = :gs_kmdivision and
				buybackdept = :g_s_deptcd and statusflag = 'A'
		using sqlcmms;
		
		if sqlcmms.sqlcode <> 0 then
			uo_status.st_message.text = '반출데이타가 없습니다.'
			return 0
		end if
	else
		ls_buybackno = ''
	end if
End If

if rb_2.checked = true then
	is_chkrb = 'rb_2'
	ls_status = dw_buyback.GetItemString(1, 'StatusFlag')
	is_buybackflag = dw_buyback.GetItemString( 1, 'BuyBackFlag')
	//반출증대상여부
	if is_buybackflag  = 'Y' then
		cbx_1.checked = true
	else
		cbx_1.checked = false
	end if
	//입력-A, 승인요청-1, 승인-2
	if ls_status = 'A' or ls_status = '1' then
		pb_1.enabled = true
	else
		pb_1.enabled = false
		wf_icon_onoff(true,  false,  false,  false,  false,  false,  false ,  false)
		uo_status.st_message.text = "승인된 반출증번호입니다."
		return 
	end if
else
	is_chkrb = 'rb_1'
	if cbx_1.checked = true then
		is_buybackflag = 'Y'
		dw_buyback.setitem(1,'BuyBackFlag','Y')
	else
		is_buybackflag = 'N'
		dw_buyback.setitem(1,'BuyBackFlag','N')
	end if
end if

dw_2.settransobject(sqlcmms)
ll_Row = dw_2.Retrieve(gs_kmarea, gs_kmdivision,ls_usecenter, ls_BuyBackNo, is_buybackflag)
If ll_Row < 1 Then 
	uo_status.st_message.text = '공무자재 불출데이타가 존재하지 않습니다.'
End If	

Return


end event

event ue_save;call super::ue_save;
Long 		ll_RowCnt, ll_selectChk, ll_rackqty
Long	I, li_Cnt, li_selectCnt
DateTime	ldt_nowTime
String	ls_BuyBackNo, ls_usecenter, ls_BuyBackSeq, ls_takingname, ls_dept
String   ls_buybackdate, ls_carno, ls_buybackflag, ls_itemcode, ls_xuse
String	ls_null, ls_status, ls_costgubun, ls_check
String	ls_message = ''

setNull(ls_null)

ll_RowCnt	= dw_2.RowCount()

If ll_RowCnt < 1 Then 
	uo_status.st_message.text = "저장할 데이타가 없습니다."
	Return
end if
setpointer(hourglass!)
dw_buyback.AcceptText()
dw_2.AcceptText()

ls_usecenter	= dw_buyback.GetItemString( 1, 'buybacksupplier' )
ls_status = dw_buyback.GetItemString( 1, 'StatusFlag')
ls_carno	= dw_buyback.GetItemString( 1, 'carno' )
If isNull(ls_usecenter) Or Trim(ls_usecenter) = '' Then 
	MessageBox("반출증작성오류", "반출처가 입력되지 않았습니다.", StopSign! )
	Return 
End If	

If isNull(ls_carno) Or Trim(ls_carno) = '' Then 
	MessageBox("반출증작성오류", "차량번호가 입력되지 않았습니다.", StopSign! )
	Return 
End If	

ls_takingname	= dw_buyback.GetItemString( 1, 'takingname' )
If isNull(ls_takingname) Or Trim(ls_takingname) = '' Then 
	MessageBox("반출증작성오류", "인수자가 입력되지 않았습니다.", StopSign! )
	Return 
End If	

// 발행번호 가져오기
if is_chkrb = 'rb_1' then
	ls_buybackno = f_get_slno_s(g_s_deptcd)
	if f_spacechk(ls_buybackno) = -1 then
		uo_status.st_message.text = "전산번호 생성에 실패했습니다."
		return 0
	end if
	dw_buyback.setitem( 1, 'buybackno',ls_buybackno)
end if
dw_buyback.accepttext()
ls_BuyBackNo	= dw_buyback.GetItemString( 1, 'buybackno' )
If isNull(ls_BuyBackNo) Or Trim(ls_BuyBackNo) = '' Then 
	MessageBox("반출증작성오류", "발행번호가 입력되지 않았습니다.", StopSign! )
	Return 
End If	
If len(trim(ls_BuyBackNo)) <> 11 Then 
	MessageBox("반출증작성오류", "발행번호가 올바르지 않았습니다.", StopSign! )
	Return 
End If

ldt_nowTime	= f_cmms_sysdate()									//현재 시스템시간
ls_buybackdate = String(ldt_nowTime,"yyyymmdd")
li_Cnt		= 0
li_selectCnt= 0 
//작성값 설정
dw_buyback.SetItem(1, 'buybacktime'	, ldt_nowTime )
dw_buyback.SetItem(1, 'lastemp'		, 'Y' )	//Interface Flag 활용
dw_buyback.SetItem(1, 'lastdate'		, ldt_nowTime )
if is_chkrb = 'rb_2' then
	DELETE FROM "PBINV"."INV302"  
			WHERE ( "PBINV"."INV302"."COMLTD" = '01' ) AND  
					( "PBINV"."INV302"."XPLANT" = :gs_kmarea ) AND  
					( "PBINV"."INV302"."DIV" = :gs_kmdivision ) AND  
					( "PBINV"."INV302"."SLNO" = :ls_buybackno )   
			using sqlca;
	
	DELETE FROM "PBINV"."INV303"  
			WHERE ( "PBINV"."INV303"."COMLTD" = '01' ) AND  
					( "PBINV"."INV303"."XPLANT" = :gs_kmarea ) AND  
					( "PBINV"."INV303"."DIV" = :gs_kmdivision ) AND  
					( "PBINV"."INV303"."SLNO" = :ls_buybackno )   
			using sqlca;
end if
//반출번호 Header 저장
INSERT INTO "PBINV"."INV302"  
( "COMLTD", "XPLANT","DIV","SLNO","VSRNO","XDATE","CARNO","RTNPRT","ITYPE",   
  "KBCD","MTYPE","COMREQPLN","COMREQDAT","COMREQTM","COMPLN","COMDAT",   
  "COMTM","DESREQPLN","DESREQDAT","DESREQTM","PRTPLN","PRTDAT","PRTTM",   
  "DESPLN","DESDAT","DESTM","DESCD","STCD","EXTD","INPTID","INPTDT",   
  "UPDTID","UPDTDT","IPADDR","MACADDR" )  
VALUES ( '01', :gs_kmarea, :gs_kmdivision, :ls_buybackno,  
  :ls_usecenter,:ls_buybackdate,:ls_carno,:is_buybackflag,'B',
  ' ','M',' ',' ',' ',' ',' ',
  ' ',' ',' ',' ',' ',' ',' ',
  ' ',' ',' ',' ',' ',' ',:g_s_empno,:g_s_date,
  ' ',' ',:g_s_ipaddr,:g_s_macaddr)  using sqlca;

if sqlca.sqlcode <> 0 then
	MESSAGEBOX("CHK",ls_buybackno + ": " +SQLCA.SQLERRTEXT)
	uo_status.st_message.text = '01저장이 실패했습니다.' + sqlca.sqlerrtext
	return 0
end if

For I = 1 To ll_RowCnt Step 1
	ll_selectChk	= dw_2.GetItemNumber( I, 'selectchk' )
	If ll_selectChk = 1 Then 
		li_Cnt		 = li_Cnt + 1
		li_selectCnt = li_selectCnt + 1
		dw_2.SetItem(I, 'buybackno'	, ls_BuyBackNo )
		
		ls_itemcode = dw_2.GetItemString( I, 'part_code')
		if li_selectCnt = 1 then
			ls_check = ls_itemcode
		end if
		if ls_itemcode = ls_check then
			ls_buybackflag = dw_2.GetItemString( I, 'buybackflag' )
			ll_rackqty = ll_rackqty + dw_2.GetItemNumber( I, 'out_qty')
			ls_xuse = dw_2.GetItemString( I, 'part_used')
			continue
		else
			//insert
			INSERT INTO "PBINV"."INV303"  
			( "COMLTD","XPLANT","DIV","SLNO","ITNO", "XUSE","QTY",   
			  "EXTD","INPTID","INPTDT","UPDTID","UPDTDT","IPADDR","MACADDR" )  
			VALUES ( '01', :gs_kmarea, :gs_kmdivision, :ls_buybackno,  
			  :ls_check,:ls_xuse,:ll_rackqty,' ',:g_s_empno,:g_s_date,
			  ' ',' ',:g_s_ipaddr,:g_s_macaddr)  
			using sqlca;
			if sqlca.sqlcode <> 0 then
				DELETE FROM "PBINV"."INV302"  
				WHERE ( "PBINV"."INV302"."COMLTD" = '01' ) AND  
						( "PBINV"."INV302"."XPLANT" = :gs_kmarea ) AND  
						( "PBINV"."INV302"."DIV" = :gs_kmdivision ) AND  
						( "PBINV"."INV302"."SLNO" = :ls_buybackno )   
				using sqlca;
				DELETE FROM "PBINV"."INV303"  
				WHERE ( "PBINV"."INV303"."COMLTD" = '01' ) AND  
						( "PBINV"."INV303"."XPLANT" = :gs_kmarea ) AND  
						( "PBINV"."INV303"."DIV" = :gs_kmdivision ) AND  
						( "PBINV"."INV303"."SLNO" = :ls_buybackno )   
				using sqlca;
				uo_status.st_message.text = '02저장이 실패했습니다.' + sqlca.sqlerrtext
				return 0
			end if
			ls_check = ls_itemcode
			ls_buybackflag = dw_2.GetItemString( I, 'buybackflag' )
			ll_rackqty = dw_2.GetItemNumber( I, 'out_qty')
			ls_xuse = dw_2.GetItemString( I, 'part_used')
		end if	
	Else
		li_Cnt			= li_Cnt + 1
		dw_2.SetItem(I, 'buybackno'	, ls_null )
	End If
Next

//insert
INSERT INTO "PBINV"."INV303"  
( "COMLTD","XPLANT","DIV","SLNO","ITNO", "XUSE","QTY",   
  "EXTD","INPTID","INPTDT","UPDTID","UPDTDT","IPADDR","MACADDR" )  
VALUES ( '01', :gs_kmarea, :gs_kmdivision, :ls_buybackno,  
  :ls_itemcode,:ls_xuse,:ll_rackqty,' ',:g_s_empno,:g_s_date,
  ' ',' ',:g_s_ipaddr,:g_s_macaddr)  
using sqlca;
if sqlca.sqlcode <> 0 then
	DELETE FROM "PBINV"."INV302"  
	WHERE ( "PBINV"."INV302"."COMLTD" = '01' ) AND  
			( "PBINV"."INV302"."XPLANT" = :gs_kmarea ) AND  
			( "PBINV"."INV302"."DIV" = :gs_kmdivision ) AND  
			( "PBINV"."INV302"."SLNO" = :ls_buybackno )   
	using sqlca;
	DELETE FROM "PBINV"."INV303"  
	WHERE ( "PBINV"."INV303"."COMLTD" = '01' ) AND  
			( "PBINV"."INV303"."XPLANT" = :gs_kmarea ) AND  
			( "PBINV"."INV303"."DIV" = :gs_kmdivision ) AND  
			( "PBINV"."INV303"."SLNO" = :ls_buybackno )   
	using sqlca;
	uo_status.st_message.text = '03저장이 실패했습니다.' + sqlca.sqlerrtext
	return 0
end if

//저장시작
sqlcmms.AutoCommit = False
SetPointer(HourGlass!)

//If li_selectCnt > 0 Then 
dw_buyback.SetTransObject(Sqlcmms)						
If dw_buyback.Update() = -1 Then 
	ls_message = 'buybackUpdate_Err'
//	MessageBox("반출증작성오류", "반출증정보 저장에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If
//Else 
//	//?
//End If

dw_2.SetTransObject(Sqlcmms)						
If dw_2.Update() = -1 Then 
	ls_message = 'Update_Err'
//	MessageBox("반출증작성오류", "반출간판정보 Update에서 오류가 발생하였습니다.", StopSign! )
	Goto RollBack_			
End If

Commit Using sqlcmms;
sqlcmms.AutoCommit = True
//This.TriggerEvent( "ue_retrieve" )
//SetPointer(Arrow!)
MessageBox("반출증작성완료", String(li_selectCnt) + " 건의 간판에 대한 반출증을 작성 하였습니다.", Information! )
pb_1.enabled = true
Return 0


RollBack_:
RollBack Using sqlcmms;
sqlcmms.AutoCommit = True
SetPointer(Arrow!)

If	ls_message = 'buybackUpdate_Err' Then
	MessageBox("반출증작성오류", "반출증정보 저장에서 오류가 발생하였습니다.", StopSign! )
ElseIf ls_message = 'Update_Err' Then
	MessageBox("반출증작성오류", "반출간판정보 Update에서 오류가 발생하였습니다.", StopSign! )
Else
	MessageBox("반출증작성오류", "승인요청에 실패하였습니다.", StopSign! )
End If

return -1
end event

event activate;call super::activate;if ib_opened then
	if uo_area.is_uo_areacode <> gs_kmarea then
		uo_area.is_uo_areacode = gs_kmarea
		uo_area.dw_1.setitem(1,"DDDWCode",gs_kmarea)
		uo_area.triggerevent('ue_select')
	end if
	uo_division.is_uo_divisioncode = gs_kmdivision
	uo_division.dw_1.setitem(1,"DDDWCode",gs_kmdivision)
end if
ib_opened = true

dw_condition.SetTransObject(sqlcmms)
dw_buyback.SetTransObject(sqlcmms)
dw_2.settransobject(sqlcmms)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf034u
end type

type uo_area from u_cmms_select_area within w_pisf034u
integer x = 82
integer y = 80
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_cmms_select_area::destroy
end on

event ue_select;call super::ue_select;
f_cmms_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										false, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

dw_condition.Reset()
dw_condition.InsertRow(1)
dw_condition.Object.suppliercode_t.Text = '반출처:'

dw_buyback.Reset()
dw_buyback.InsertRow(1)
//dw_scan.setItem(1, 'scancode', '')

dw_2.Reset()
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode

if f_spacechk(gs_kmdivision) = -1 then
	ls_divisioncode = '%'
else
	ls_divisioncode = gs_kmdivision
end if
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,ls_divisioncode,false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_cmms_select_division within w_pisf034u
integer x = 590
integer y = 80
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

event ue_select;call super::ue_select;dw_condition.SetTransObject(sqlcmms)
dw_condition.Reset()
dw_condition.InsertRow(1)
dw_condition.Object.suppliercode_t.Text = '반출처:'

dw_buyback.Reset()
dw_buyback.InsertRow(1)
parent.triggerevent('ue_postopen')

dw_2.Reset()
end event

type rb_1 from radiobutton within w_pisf034u
integer x = 1280
integer y = 80
integer width = 325
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "새반출"
end type

event clicked;rb_1.Weight = 700
rb_2.Weight = 400

String	ls_buybackNo, ls_buybacksupplier

dw_condition.Accepttext()
ls_buybacksupplier = dw_condition.GetItemString(1, 'suppliercode')
dw_2.Reset()

// 새 반출증작성시에는 저장시에 반출번호가 적용됨.
dw_buyback.object.buybackno.protect = 1

dw_buyback.Reset()
dw_buyback.InsertRow(1)
dw_buyback.SetItem(1, 'areacode'		, gs_kmarea )
dw_buyback.SetItem(1, 'divisioncode', gs_kmdivision )
dw_buyback.SetItem(1, 'buybackdept'	, g_s_deptcd )
dw_buyback.SetItem(1, 'cc_name'		, is_deptname )
dw_buyback.SetItem(1, 'buybacksupplier', ls_buybacksupplier )
dw_buyback.SetItem(1, 'buybackemp'	, g_s_empno )
dw_buyback.SetItem(1, 'empname'		, is_empname )
end event

type rb_2 from radiobutton within w_pisf034u
integer x = 1609
integer y = 80
integer width = 366
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기존반출"
end type

event clicked;rb_1.Weight = 400
rb_2.Weight = 700

String	ls_buybackNo, ls_buybacksupplier

dw_condition.Accepttext()
ls_buybacksupplier = dw_condition.GetItemString(1, 'suppliercode')
dw_2.Reset()

dw_buyback.object.buybackno.protect = 0

dw_buyback.Reset()
dw_buyback.InsertRow(1)
dw_buyback.SetItem(1, 'areacode'		, gs_kmarea )
dw_buyback.SetItem(1, 'divisioncode', gs_kmdivision )
dw_buyback.SetItem(1, 'buybackdept'	, g_s_deptcd )
dw_buyback.SetItem(1, 'cc_name'		, is_deptname )
dw_buyback.SetItem(1, 'buybacksupplier', ls_buybacksupplier )
dw_buyback.SetItem(1, 'buybackemp'	, g_s_empno )
dw_buyback.SetItem(1, 'empname'		, is_empname )

end event

type cbx_1 from checkbox within w_pisf034u
integer x = 2075
integer y = 80
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "반출증대상"
boolean lefttext = true
end type

type st_2 from statictext within w_pisf034u
integer x = 2601
integer y = 88
integer width = 297
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "승인요청"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_pisf034u
integer x = 2930
integer y = 44
integer width = 178
integer height = 144
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\E-mail.gif"
string disabledname = "NotFound!"
alignment htextalign = left!
end type

event clicked;Int li_Rtn
string ls_mail, ls_buybackno, ls_buybackdept

ls_buybackno = dw_buyback.getitemstring(1,"BuyBackno")
ls_buybackdept = dw_buyback.getitemstring(1,"BuyBackdept")

if f_spacechk(ls_buybackno) = -1 then
	uo_status.st_message.text = "반출정보가 존재하지 않습니다."
	return 0
end if
li_Rtn = MessageBox('확인!', '발행번호 : ' + ls_buybackno + &
					' 인 사급자재를 승인요청 하시겠습니까?', Question!, YesNo! )

If li_Rtn = 2 Then Return 0

SetPointer(HourGlass!)

//팀장에게 승인요청메일 발송.
if f_SendMail( f_Mgr_MailAddr( (Left(g_s_deptcd, 2) + '00') ), "반출 승인요청",  &
			+ "발행번호 : " + ls_buybackno + " 인 사급공무자재를 승인요청합니다 (" + &
				g_s_kornm + ") " + g_s_datetime, "" ) = 1 then
	uo_status.st_message.text = ""
	return 0
end if


//승인요청 상태코드 업데이트
// 'A' : 반출입력, '1' : 승인요청, '2' : 승인
UPDATE PART_BUYBACK  
     SET StatusFlag = '1'  
   WHERE ( AreaCode = :gs_kmarea ) AND  
         ( DivisionCode = :gs_kmdivision ) AND  
         ( BuyBackNo = :ls_buybackno ) AND  
         ( BuyBackDept = :ls_buybackdept )   
	using sqlcmms;
	
UPDATE "PBINV"."INV302"  
     SET "STCD" = '1', "DESCD" = '1' 
   WHERE ( "PBINV"."INV302"."COMLTD" = '01' ) AND  
         ( "PBINV"."INV302"."XPLANT" = :gs_kmarea ) AND  
         ( "PBINV"."INV302"."DIV" = :gs_kmdivision ) AND  
         ( "PBINV"."INV302"."SLNO" = :ls_buybackno )   
	using sqlca;


// 확정요청되었습니다.
uo_status.st_message.Text = "승인요청이 완료되었습니다."

//메일 전송완료
pb_1.enabled = false
end event

type dw_condition from datawindow within w_pisf034u
integer x = 64
integer y = 248
integer width = 1929
integer height = 108
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf_condition1"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;String	ls_buttonname, ls_buybackNo, ls_data[]

ls_buttonname 	= dwo.name

if f_code_search('d_lookup_comp', '', ls_data[]) then
	This.SetItem( row, 'suppliercode', ls_data[1] )
	This.SetItem( row, 'supplierkorname', ls_data[2] )
else
	return 0
end if

If rb_1.Checked Then
//	dw_buyback.SetTransObject(sqlcmms)
//	dw_buyback.InsertRow(1)
	//ls_buybackNo = wf_setbuybackno()
//	dw_buyback.SetItem(1, 'buybackno'	, ls_buybackNo)
//	dw_buyback.SetItem(1, 'areacode'		, )
//	dw_buyback.SetItem(1, 'divisioncode', istr_partkb.divCode)
//	dw_buyback.SetItem(1, 'buybackdept'	, g_s_deptcd)
//	dw_buyback.SetItem(1, 'buybacksupplier', ls_data[1] )
//	dw_buyback.SetItem(1, 'deptname'		, is_deptname)
//	dw_buyback.SetItem(1, 'buybackemp'	, g_s_empno)
//	dw_buyback.SetItem(1, 'empname'		, is_empname)
	Return 0
Else
	rb_2.TriggerEvent("clicked")
//	dw_buyback.Reset()
//	dw_buyback.SetTransObject(sqlpis)
//	dw_buyback.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_buybackNo, g_s_deptcd)
End If

Return 0
end event

event itemchanged;String 	ls_colName, ls_suppcode, ls_suppno, ls_suppname
String	ls_deptcode//, ls_deptname
String	ls_Null, ls_buybackNo 
//DataWindowChild ldwc

this.AcceptText()

SetNull(ls_Null)
ls_colName = This.GetcolumnName()
ls_suppcode	= data

SELECT comp_name
	 INTO :ls_suppname  
	 FROM comp_master 
	WHERE comp_code = :ls_suppcode 
	Using	sqlcmms	;
	
	If sqlpis.SqlCode <> 0 Then 
		This.SetItem( This.GetRow(), 'suppliercode'		, ls_Null )
		This.SetItem( This.GetRow(), 'supplierkorname'	, ls_Null )
		//istr_partkb.suppcode = '%'
		Return 1
	End If
	This.SetItem( This.GetRow(), 'supplierkorname'	, ls_suppname )
	//istr_partkb.suppcode = ls_suppcode

//If rb_1.Checked Then
//	dw_buyback.Reset()
//	dw_buyback.SetTransObject(sqlpis)
//	dw_buyback.InsertRow(1)
//	ls_buybackNo = wf_setbuybackno()
//	dw_buyback.SetItem(1, 'buybackno'	, ls_buybackNo)
//	dw_buyback.SetItem(1, 'areacode'		, istr_partkb.areaCode)
//	dw_buyback.SetItem(1, 'divisioncode', istr_partkb.divCode)
//	dw_buyback.SetItem(1, 'buybackdept'	, g_s_deptcd)
//	dw_buyback.SetItem(1, 'buybacksupplier', data )
//	dw_buyback.SetItem(1, 'deptname'		, is_deptname)
//	dw_buyback.SetItem(1, 'buybackemp'	, g_s_empno)
//	dw_buyback.SetItem(1, 'empname'		, is_empname)
//	Return 0
//Else
//	rb_2.TriggerEvent("clicked")
////	dw_buyback.Reset()
////	dw_buyback.SetTransObject(sqlpis)
////	dw_buyback.Retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_buybackNo, g_s_deptcd)
//End If

Return
end event

type dw_buyback from datawindow within w_pisf034u
integer x = 73
integer y = 444
integer width = 2985
integer height = 412
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf034u_02"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
//////////////////////////////////////
// 반출증 내용 편집
//////////////////////////////////////
String 	ls_colName
String	ls_deptname, ls_suppcode
String	ls_Null 
String	ls_areacode, ls_divcode, ls_BuyBackNo, ls_deptcode, ls_usecenter
int ll_Row

SetNull(ls_Null)

dw_condition.AcceptText()
ls_suppcode = dw_condition.GetItemString(1, 'suppliercode')
If isNull(ls_suppcode) Or trim(ls_suppcode) = '' Then 
	MessageBox( "확인", "반출처가 선택되지 않았습니다.", StopSign! )
	This.SetItem(1, 'buybackno', ls_Null )
	This.SetFocus()
	Return 1
End If


ls_colName = This.GetcolumnName()

Choose Case ls_colName
	Case 'buybackno'

			dw_2.Reset()
			
			  SELECT AreaCode, DivisionCode,	BuyBackNo, BuyBackDept,	BuyBackSupplier
				 INTO :ls_areacode, :ls_divcode, :ls_BuyBackNo, :ls_deptcode, :ls_usecenter
				 FROM PART_BUYBACK  
				WHERE areacode = :gs_kmarea and divisioncode = :gs_kmdivision and
						BuyBackNo = :data 
				USING sqlcmms;

			If sqlcmms.SqlCode <> 0 Then 
				MessageBox( "발행번호확인", "발행번호가 올바르지 않거나 내역이 없읍니다.", Information! )
				This.SetItem(1, 'buybackno', ls_Null )
				This.SetFocus()
				Return 1
			End If
			
			If ls_usecenter <> ls_suppcode Then
				MessageBox( "발행번호확인", "해당 사용처의 발행번호가 아닙니다.", Information! )
				This.SetItem(1, 'buybackno', ls_Null )
				This.SetFocus()
				Return 1
			End If
			
//			dw_buyback.SetRedraw(False)
//			dw_buyback.SetTransObject(sqlcmms)
//			dw_buyback.Retrieve(gs_kmarea, gs_kmdivision, data, g_s_deptcd)
//			dw_buyback.SetRedraw(True)

			dw_buyback.Reset()
			ll_Row = dw_buyback.Retrieve(gs_kmarea, gs_kmdivision, data, g_s_deptcd)
			If ll_Row < 1 Then 
				dw_buyback.reset()
				dw_buyback.InsertRow(1)
				parent.TriggerEvent( "ue_init" )
				uo_status.st_message.text = '해당 발행번호에 대한 내역이 없읍니다.'
			End If
	Case 'carno' 
	Case 'takingname' 
	Case 'remark' 
End Choose 
end event

type dw_2 from datawindow within w_pisf034u
integer x = 37
integer y = 896
integer width = 3369
integer height = 880
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf034u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;Long		ll_RowCnt
INteger	li_i

ll_RowCnt = This.RowCount()

If ll_RowCnt < 1 Then Return

FOR li_i = ll_RowCnt To 1 Step -1
	dw_2.SetItem( li_i, 'selectchk', 1 )
Next

pb_1.enabled = false

Return
end event

event itemchanged;
if dwo.name = 'selectchk' then
	pb_1.enabled = false
end if
end event

type gb_1 from groupbox within w_pisf034u
integer x = 2560
integer width = 581
integer height = 204
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisf034u
integer x = 27
integer width = 1170
integer height = 204
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisf034u
integer x = 1216
integer width = 805
integer height = 204
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_pisf034u
integer x = 2043
integer width = 498
integer height = 204
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_5 from groupbox within w_pisf034u
integer x = 32
integer y = 204
integer width = 1998
integer height = 176
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_6 from groupbox within w_pisf034u
integer x = 32
integer y = 380
integer width = 3369
integer height = 496
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

