$PBExportHeader$w_pisq160u.srw
$PBExportComments$불량유형등록
forward
global type w_pisq160u from w_ipis_sheet01
end type
type dw_pisq160u_01 from u_vi_std_datawindow within w_pisq160u
end type
type uo_area from u_pisc_select_area within w_pisq160u
end type
type uo_division from u_pisc_select_division within w_pisq160u
end type
type dw_pisq160u_02 from u_vi_std_datawindow within w_pisq160u
end type
type st_2 from statictext within w_pisq160u
end type
type st_3 from statictext within w_pisq160u
end type
type st_5 from statictext within w_pisq160u
end type
type dw_pisq160u_03 from u_vi_std_datawindow within w_pisq160u
end type
type gb_2 from groupbox within w_pisq160u
end type
type gb_3 from groupbox within w_pisq160u
end type
end forward

global type w_pisq160u from w_ipis_sheet01
integer width = 3355
integer height = 2700
string title = "불량유형등록"
dw_pisq160u_01 dw_pisq160u_01
uo_area uo_area
uo_division uo_division
dw_pisq160u_02 dw_pisq160u_02
st_2 st_2
st_3 st_3
st_5 st_5
dw_pisq160u_03 dw_pisq160u_03
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq160u w_pisq160u

type variables

String	is_AreaCode, is_DivisionCode

end variables

forward prototypes
public function boolean wf_checkcolumn ()
end prototypes

public function boolean wf_checkcolumn ();
Int		li_row
Boolean	lb_rtn = TRUE

IF dw_pisq160u_03.AcceptText() <> 1 THEN RETURN FALSE

// 전체의 자료를 체크한다
//
FOR li_row = 1 TO dw_pisq160u_03.RowCount()
	IF f_checknullorspace(dw_pisq160u_03.GetItemString(li_row, 'badtypecode')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 불량유형코드를 입력하세요', StopSign!)
		dw_pisq160u_03.SetColumn('badtypecode')
		lb_rtn = FALSE
		EXIT
	END IF
	IF f_checknullorspace(dw_pisq160u_03.GetItemString(li_row, 'badtypename')) = TRUE THEN
		MessageBox('확 인', String(li_row) + '번째의 불량유형명을 입력하세요', StopSign!)
		dw_pisq160u_03.SetColumn('badtypename')
		lb_rtn = FALSE
		EXIT
	END IF
NEXT

dw_pisq160u_03.ScrollToRow(li_row)
f_SetHighlight(dw_pisq160u_03, li_row, True)	
dw_pisq160u_03.SetFocus()

RETURN lb_rtn

end function

on w_pisq160u.create
int iCurrent
call super::create
this.dw_pisq160u_01=create dw_pisq160u_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq160u_02=create dw_pisq160u_02
this.st_2=create st_2
this.st_3=create st_3
this.st_5=create st_5
this.dw_pisq160u_03=create dw_pisq160u_03
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq160u_01
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_pisq160u_02
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.dw_pisq160u_03
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_pisq160u.destroy
call super::destroy
destroy(this.dw_pisq160u_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq160u_02)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.dw_pisq160u_03)
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
String	ls_LargeGroupCode, ls_codeid
long ll_retrieverow

// 조회에 필요한 정보를 구한다
//
if uo_area.dw_1.GetRow() < 1 then
	return 0
end if
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

// 데이타를 조회한다
//
ll_retrieverow = dw_pisq160u_01.Retrieve(is_AreaCode, is_DivisionCode)
if ll_retrieverow < 1 then
	return 0
end if
dw_pisq160u_02.Retrieve('QCPR01')

ls_LargeGroupCode	= dw_pisq160u_01.GetItemString(1, 'LargeGroupCode')
ls_codeid			= dw_pisq160u_02.GetItemString(1, 'codeid')
dw_pisq160u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_codeid)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq160u_01, 1, True)	
f_SetHighlight(dw_pisq160u_02, 1, True)	
f_SetHighlight(dw_pisq160u_03, 1, True)	


end event

event open;call super::open;
// 트랜잭션을 연결한다
//
dw_pisq160u_01.SetTransObject(SQLPIS)
dw_pisq160u_02.SetTransObject(SQLPIS)
dw_pisq160u_03.SetTransObject(SQLPIS)

// 처리를 조회로 넘긴다
//
This.PostEvent("ue_retrieve")

end event

event ue_insert;call super::ue_insert;
Long		ll_ins_row
String	ls_largegroupcode, ls_codeid

// 최종 입력행을 구한다
//
ll_ins_row = dw_pisq160u_03.InsertRow(0)

// 키부분의 값을 비표시 칼럼에 셋트한다
//
ls_largegroupcode	= dw_pisq160u_01.GetItemString(dw_pisq160u_01.GetSelectedRow(0), 'largegroupcode')
ls_codeid			= dw_pisq160u_02.GetItemString(dw_pisq160u_02.GetSelectedRow(0), 'codeid')

dw_pisq160u_03.SetItem(ll_ins_row, 'areacode'		 , is_areacode)
dw_pisq160u_03.SetItem(ll_ins_row, 'divisioncode'	 , is_divisioncode)
dw_pisq160u_03.SetItem(ll_ins_row, 'largegroupcode' , ls_largegroupcode)
dw_pisq160u_03.SetItem(ll_ins_row, 'badreasoncode'	 , ls_codeid)

// 포커스를 이동한다
//
dw_pisq160u_03.SetColumn('badtypecode')
dw_pisq160u_03.SetFocus()

// 최종 입력행에 반전표시를 한다
//
f_SetHighlight(dw_pisq160u_03, ll_ins_row, True)	

end event

event ue_delete;call super::ue_delete;
Long	ll_select_row

// 선택된 행값을 구한다
//
ll_select_row = dw_pisq160u_03.GetSelectedRow(0)

// 선택된 행을 삭제한다
//
dw_pisq160u_03.DeleteRow(dw_pisq160u_03.GetSelectedRow(0))

// 데이타윈도우에 반전표시를 나타낸다
//
IF ll_select_row >= dw_pisq160u_03.RowCount() THEN
	f_SetHighlight(dw_pisq160u_03, dw_pisq160u_03.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq160u_03, ll_select_row, True)	
END IF

end event

event ue_save;call super::ue_save;
Int	li_save

// 필수입력 항목을 체크한다
//
IF wf_checkcolumn() = FALSE THEN RETURN

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq160u_03.Update()

IF li_save = 1 THEN
	// Commit 처리
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = "정상적으로 처리되었습니다."
ELSE 
	// RollBack 처리
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('확 인', '처리에 실패했습니다')
END IF



end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq160u_01.SetTransObject(SQLPIS)
dw_pisq160u_02.SetTransObject(SQLPIS)
dw_pisq160u_03.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq160u
integer x = 18
integer width = 3598
end type

type dw_pisq160u_01 from u_vi_std_datawindow within w_pisq160u
integer x = 46
integer y = 320
integer width = 1353
integer height = 828
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq160u_01"
boolean vscrollbar = true
end type

event rowfocuschanged;
String	ls_LargeGroupCode, ls_codeid

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
if dw_pisq160u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq160u_01.GetItemString(dw_pisq160u_01.GetSelectedRow(0), 'LargeGroupCode')
dw_pisq160u_02.Retrieve('QCPR01')

ls_codeid 			= dw_pisq160u_02.GetItemString(1, 'codeid')
dw_pisq160u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_codeid)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq160u_02, 1, True)	
f_SetHighlight(dw_pisq160u_03, 1, True)	



end event

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)

end event

type uo_area from u_pisc_select_area within w_pisq160u
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
dw_pisq160u_01.SetTransObject(SQLPIS)
dw_pisq160u_02.SetTransObject(SQLPIS)
dw_pisq160u_03.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq160u
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
dw_pisq160u_01.SetTransObject(SQLPIS)
dw_pisq160u_02.SetTransObject(SQLPIS)
dw_pisq160u_03.SetTransObject(SQLPIS)

parent.TriggerEvent('ue_retrieve')
end event

type dw_pisq160u_02 from u_vi_std_datawindow within w_pisq160u
integer x = 1417
integer y = 320
integer width = 969
integer height = 828
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq160u_02"
end type

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)
end event

event rowfocuschanged;
String	ls_LargeGroupCode, ls_codeid

// 선택행이 바뀔때마다 새로운 데이타를 조회한다
//
if dw_pisq160u_02.GetSelectedRow(0) < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq160u_01.GetItemString(dw_pisq160u_01.GetSelectedRow(0), 'LargeGroupCode')
ls_codeid			= dw_pisq160u_02.GetItemString(dw_pisq160u_02.GetSelectedRow(0), 'codeid')
dw_pisq160u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_codeid)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq160u_03, 1, True)	


end event

type st_2 from statictext within w_pisq160u
integer x = 87
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< QC제품군 대분류 >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq160u
integer x = 1454
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< 불량원인 >"
boolean focusrectangle = false
end type

type st_5 from statictext within w_pisq160u
integer x = 87
integer y = 1180
integer width = 1335
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "< 불량유형 >"
boolean focusrectangle = false
end type

type dw_pisq160u_03 from u_vi_std_datawindow within w_pisq160u
integer x = 46
integer y = 1252
integer width = 2341
integer height = 1300
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq160u_03"
boolean vscrollbar = true
end type

type gb_2 from groupbox within w_pisq160u
integer x = 18
integer y = 188
integer width = 2395
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

type gb_3 from groupbox within w_pisq160u
integer x = 18
integer y = 12
integer width = 2395
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

