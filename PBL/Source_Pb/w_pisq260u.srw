$PBExportHeader$w_pisq260u.srw
$PBExportComments$Containment 불량유형등록
forward
global type w_pisq260u from w_ipis_sheet01
end type
type gb_1 from groupbox within w_pisq260u
end type
type gb_5 from groupbox within w_pisq260u
end type
type dw_pisq260u_01 from u_vi_std_datawindow within w_pisq260u
end type
type uo_area from u_pisc_select_area within w_pisq260u
end type
type uo_division from u_pisc_select_division within w_pisq260u
end type
type dw_pisq260u_02 from u_vi_std_datawindow within w_pisq260u
end type
type st_2 from statictext within w_pisq260u
end type
type st_3 from statictext within w_pisq260u
end type
type cb_reason_ins from commandbutton within w_pisq260u
end type
type cb_reason_del from commandbutton within w_pisq260u
end type
type cb_reason_save from commandbutton within w_pisq260u
end type
type cb_type_save from commandbutton within w_pisq260u
end type
type cb_type_del from commandbutton within w_pisq260u
end type
type cb_type_ins from commandbutton within w_pisq260u
end type
type gb_2 from groupbox within w_pisq260u
end type
type gb_3 from groupbox within w_pisq260u
end type
end forward

global type w_pisq260u from w_ipis_sheet01
integer width = 2843
integer height = 2784
string title = "Containment 불량유형등록"
gb_1 gb_1
gb_5 gb_5
dw_pisq260u_01 dw_pisq260u_01
uo_area uo_area
uo_division uo_division
dw_pisq260u_02 dw_pisq260u_02
st_2 st_2
st_3 st_3
cb_reason_ins cb_reason_ins
cb_reason_del cb_reason_del
cb_reason_save cb_reason_save
cb_type_save cb_type_save
cb_type_del cb_type_del
cb_type_ins cb_type_ins
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq260u w_pisq260u

type variables

String	is_AreaCode, is_DivisionCode

end variables

on w_pisq260u.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_5=create gb_5
this.dw_pisq260u_01=create dw_pisq260u_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq260u_02=create dw_pisq260u_02
this.st_2=create st_2
this.st_3=create st_3
this.cb_reason_ins=create cb_reason_ins
this.cb_reason_del=create cb_reason_del
this.cb_reason_save=create cb_reason_save
this.cb_type_save=create cb_type_save
this.cb_type_del=create cb_type_del
this.cb_type_ins=create cb_type_ins
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_5
this.Control[iCurrent+3]=this.dw_pisq260u_01
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.dw_pisq260u_02
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.cb_reason_ins
this.Control[iCurrent+10]=this.cb_reason_del
this.Control[iCurrent+11]=this.cb_reason_save
this.Control[iCurrent+12]=this.cb_type_save
this.Control[iCurrent+13]=this.cb_type_del
this.Control[iCurrent+14]=this.cb_type_ins
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_3
end on

on w_pisq260u.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.dw_pisq260u_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq260u_02)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_reason_ins)
destroy(this.cb_reason_del)
destroy(this.cb_reason_save)
destroy(this.cb_type_save)
destroy(this.cb_type_del)
destroy(this.cb_type_ins)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq080i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_BadReasonCode
long ll_rowcnt

uo_status.st_message.text = ""
// 조회에 필요한 정보를 구한다
//
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

// 데이타를 조회한다
//
ll_rowcnt = dw_pisq260u_01.Retrieve(is_AreaCode, is_DivisionCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_BadReasonCode = dw_pisq260u_01.GetItemString(1, 'containbadreasoncode')
dw_pisq260u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_BadReasonCode)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq260u_01, 1, True)
f_SetHighlight(dw_pisq260u_02, 1, True)


end event

event open;call super::open;
////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// 툴바의 아이콘을 재설정한다
//
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

// 트랜잭션을 연결한다
//
dw_pisq260u_01.SetTransObject(SQLPIS)
dw_pisq260u_02.SetTransObject(SQLPIS)

// 처리를 조회로 넘긴다
//
This.PostEvent("ue_retrieve")

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq260u_01.SetTransObject(SQLPIS)
dw_pisq260u_02.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq260u
integer x = 18
integer width = 3598
end type

type gb_1 from groupbox within w_pisq260u
integer x = 1417
integer y = 2376
integer width = 1344
integer height = 168
integer taborder = 80
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_5 from groupbox within w_pisq260u
integer x = 46
integer y = 2376
integer width = 1344
integer height = 168
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_pisq260u_01 from u_vi_std_datawindow within w_pisq260u
integer x = 46
integer y = 320
integer width = 1344
integer height = 2040
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq260u_01"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
String	ls_BadReasonCode, ls_flag

//IF currentrow <> 999 THEN
//	IF dw_pisq260u_02.ModifiedCount( ) <> 0 THEN
//		MessageBox('확 인', '작업중인 자료가 있습니다')
//		dw_pisq260u_02.SetColumn('containbadtypecode')
//		dw_pisq260u_02.SetFocus()
//		ls_flag = 'Y'
//		RETURN
//	ELSE
//		ls_flag = 'N'
//	END IF
//END IF

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
if dw_pisq260u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_BadReasonCode = dw_pisq260u_01.GetItemString(dw_pisq260u_01.GetSelectedRow(0), 'containbadreasoncode')
dw_pisq260u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_BadReasonCode)
// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq260u_02, 1, True)	







end event

event clicked;call super::clicked;
//This.Trigger Event RowFocusChanged(999)
This.TriggerEvent(RowFocusChanged!)

end event

type uo_area from u_pisc_select_area within w_pisq260u
integer x = 59
integer y = 60
integer taborder = 10
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
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

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

// 트랜잭션을 연결한다
//
dw_pisq260u_01.SetTransObject(SQLPIS)
dw_pisq260u_02.SetTransObject(SQLPIS)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow ldw_division
ldw_division = uo_division.dw_1
ls_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq260u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;
// 트랜잭션을 연결한다
//
dw_pisq260u_01.SetTransObject(SQLPIS)
dw_pisq260u_02.SetTransObject(SQLPIS)

parent.TriggerEvent('ue_retrieve')
end event

type dw_pisq260u_02 from u_vi_std_datawindow within w_pisq260u
integer x = 1417
integer y = 320
integer width = 1344
integer height = 2040
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq260u_02"
boolean vscrollbar = true
end type

type st_2 from statictext within w_pisq260u
integer x = 91
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< 불 량 원 인 >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq260u
integer x = 1463
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< 불 량 유 형 >"
boolean focusrectangle = false
end type

type cb_reason_ins from commandbutton within w_pisq260u
integer x = 233
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입  력"
end type

event clicked;
Long	ll_ins_row

uo_status.st_message.text = ""
// 최종 입력행을 구한다
//
ll_ins_row = dw_pisq260u_01.InsertRow(0)

// 키부분의 값을 비표시 칼럼에 셋트한다
//
messagebox("chk",is_areacode + is_divisioncode)
dw_pisq260u_01.SetItem(ll_ins_row, 'areacode', is_areacode)
dw_pisq260u_01.SetItem(ll_ins_row, 'divisioncode', is_divisioncode)

// 포커스를 이동한다
//
dw_pisq260u_01.SetColumn('containbadreasoncode')
dw_pisq260u_01.SetFocus()

// 최종 입력행에 반전표시를 한다
//
f_SetHighlight(dw_pisq260u_01, ll_ins_row, True)	

// 신규 입력건이 발생하면 하위분류의 데이타윈도우를 초기화한다
//
dw_pisq260u_02.ReSet()


end event

type cb_reason_del from commandbutton within w_pisq260u
integer x = 617
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭  제"
end type

event clicked;
Long	ll_select_row

uo_status.st_message.text = ""
// 선택된 행값을 구한다
//
ll_select_row = dw_pisq260u_01.GetSelectedRow(0)

// 선택된 행의 불량유형 유무를 판단하여 없는경우만 삭제가 가능하다
//
IF dw_pisq260u_02.RowCount() > 0 THEN 
	MessageBox('확 인', '하위의 불량유형이 없는경우만 삭제가 가능합니다', StopSign!)
	RETURN
END IF

// 선택된 행을 삭제한다
//
dw_pisq260u_01.DeleteRow(dw_pisq260u_01.GetSelectedRow(0))

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq260u_01.RowCount() THEN
	f_SetHighlight(dw_pisq260u_01, dw_pisq260u_01.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq260u_01, ll_select_row, True)	
END IF

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
dw_pisq260u_01.TriggerEvent(RowFocusChanged!)
end event

type cb_reason_save from commandbutton within w_pisq260u
integer x = 1001
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저  장"
end type

event clicked;
Int	li_save

uo_status.st_message.text = ""
// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq260u_01.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = "저장되었습니다."
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
END IF


end event

type cb_type_save from commandbutton within w_pisq260u
integer x = 2373
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저  장"
end type

event clicked;
Int	li_save

uo_status.st_message.text = ""
// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq260u_02.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	uo_status.st_message.text = "저장되었습니다."
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
END IF

end event

type cb_type_del from commandbutton within w_pisq260u
integer x = 1989
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭  제"
end type

event clicked;
Long	ll_select_row

uo_status.st_message.text = ""
// 선택된 행값을 구한다
//
ll_select_row = dw_pisq260u_02.GetSelectedRow(0)


// 선택된 행을 삭제한다
//
dw_pisq260u_02.DeleteRow(dw_pisq260u_02.GetSelectedRow(0))

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq260u_02.RowCount() THEN
	f_SetHighlight(dw_pisq260u_02, dw_pisq260u_02.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq260u_02, ll_select_row, True)	
END IF

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
dw_pisq260u_02.TriggerEvent(RowFocusChanged!)
end event

type cb_type_ins from commandbutton within w_pisq260u
integer x = 1605
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입  력"
end type

event clicked;
Long		ll_ins_row
String	ls_BadReasonCode

uo_status.st_message.text = ""
if dw_pisq260u_01.GetSelectedRow(0) < 1 then
	uo_status.st_message.text = "불량유형을 선택하십시요"
	return 0
end if
// 최종 입력행을 구한다
//
ll_ins_row = dw_pisq260u_02.InsertRow(0)

// 키부분의 값을 비표시 칼럼에 셋트한다
//
ls_badreasoncode = dw_pisq260u_01.GetItemString(dw_pisq260u_01.GetSelectedRow(0), 'containbadreasoncode')
dw_pisq260u_02.SetItem(ll_ins_row, 'areacode'				, is_areacode)
dw_pisq260u_02.SetItem(ll_ins_row, 'divisioncode'			, is_divisioncode)
dw_pisq260u_02.SetItem(ll_ins_row, 'containbadreasoncode', ls_badreasoncode)

// 포커스를 이동한다
//
dw_pisq260u_02.SetColumn('containbadtypecode')
dw_pisq260u_02.SetFocus()

// 최종 입력행에 반전표시를 한다
//
f_SetHighlight(dw_pisq260u_02, ll_ins_row, True)	


end event

type gb_2 from groupbox within w_pisq260u
integer x = 18
integer y = 188
integer width = 2770
integer height = 2384
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisq260u
integer x = 18
integer y = 12
integer width = 2770
integer height = 168
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

