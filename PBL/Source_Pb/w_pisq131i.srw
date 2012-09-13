$PBExportHeader$w_pisq131i.srw
$PBExportComments$수입검사 불량율(업체별 WORST 10)
forward
global type w_pisq131i from w_ipis_sheet01
end type
type gb_2 from groupbox within w_pisq131i
end type
type uo_area from u_pisc_select_area within w_pisq131i
end type
type uo_division from u_pisc_select_division within w_pisq131i
end type
type dw_pisq131i_01_graph from datawindow within w_pisq131i
end type
type dw_pisq131i_01 from datawindow within w_pisq131i
end type
type rb_lot from radiobutton within w_pisq131i
end type
type rb_qty from radiobutton within w_pisq131i
end type
type st_countview2 from statictext within w_pisq131i
end type
type uo_date from u_pisc_date_applydate within w_pisq131i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq131i
end type
type st_4 from statictext within w_pisq131i
end type
type dw_pisq131i_01_com from datawindow within w_pisq131i
end type
type dw_pisq131i_02_com from datawindow within w_pisq131i
end type
type cb_excel from commandbutton within w_pisq131i
end type
type dw_down from datawindow within w_pisq131i
end type
type gb_1 from groupbox within w_pisq131i
end type
end forward

global type w_pisq131i from w_ipis_sheet01
integer width = 4690
integer height = 2708
string title = "수입검사 불량율(업체별 WORST 10)"
gb_2 gb_2
uo_area uo_area
uo_division uo_division
dw_pisq131i_01_graph dw_pisq131i_01_graph
dw_pisq131i_01 dw_pisq131i_01
rb_lot rb_lot
rb_qty rb_qty
st_countview2 st_countview2
uo_date uo_date
uo_dateto uo_dateto
st_4 st_4
dw_pisq131i_01_com dw_pisq131i_01_com
dw_pisq131i_02_com dw_pisq131i_02_com
cb_excel cb_excel
dw_down dw_down
gb_1 gb_1
end type
global w_pisq131i w_pisq131i

type variables

end variables

on w_pisq131i.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq131i_01_graph=create dw_pisq131i_01_graph
this.dw_pisq131i_01=create dw_pisq131i_01
this.rb_lot=create rb_lot
this.rb_qty=create rb_qty
this.st_countview2=create st_countview2
this.uo_date=create uo_date
this.uo_dateto=create uo_dateto
this.st_4=create st_4
this.dw_pisq131i_01_com=create dw_pisq131i_01_com
this.dw_pisq131i_02_com=create dw_pisq131i_02_com
this.cb_excel=create cb_excel
this.dw_down=create dw_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_pisq131i_01_graph
this.Control[iCurrent+5]=this.dw_pisq131i_01
this.Control[iCurrent+6]=this.rb_lot
this.Control[iCurrent+7]=this.rb_qty
this.Control[iCurrent+8]=this.st_countview2
this.Control[iCurrent+9]=this.uo_date
this.Control[iCurrent+10]=this.uo_dateto
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.dw_pisq131i_01_com
this.Control[iCurrent+13]=this.dw_pisq131i_02_com
this.Control[iCurrent+14]=this.cb_excel
this.Control[iCurrent+15]=this.dw_down
this.Control[iCurrent+16]=this.gb_1
end on

on w_pisq131i.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq131i_01_graph)
destroy(this.dw_pisq131i_01)
destroy(this.rb_lot)
destroy(this.rb_qty)
destroy(this.st_countview2)
destroy(this.uo_date)
destroy(this.uo_dateto)
destroy(this.st_4)
destroy(this.dw_pisq131i_01_com)
destroy(this.dw_pisq131i_02_com)
destroy(this.cb_excel)
destroy(this.dw_down)
destroy(this.gb_1)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq130i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_QcDatefm, ls_QcDateto

// 조회에 필요한 정보를 구한다
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_QcDatefm			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_QcDateto			= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')

// 데이타를 조회한다
//
dw_pisq131i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_QcDatefm, ls_QcDateto)

// 그래프를 표시한다
//
dw_pisq131i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_QcDatefm, ls_QcDateto)

IF rb_qty.Checked = TRUE THEN
	dw_pisq131i_01_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_QcDatefm, ls_QcDateto)
END IF	

IF rb_lot.Checked = TRUE THEN
	dw_pisq131i_02_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_QcDatefm, ls_QcDateto)
END IF	

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




end event

event ue_postopen;call super::ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq131i_01.SetTransObject(SQLPIS)
dw_pisq131i_01_graph.SetTransObject(SQLPIS)
dw_pisq131i_01_com.SetTransObject(SQLPIS)
dw_pisq131i_02_com.SetTransObject(SQLPIS)

dw_down.settransobject(sqlpis)

end event

event ue_print;call super::ue_print;
IF MessageBox('확 인', '그래프 출력은 별도의 화면없이 바로 출력됩니다.~r~n출력하시겠습니까?',&
							  Exclamation!, OKCancel!, 2) = 2 THEN RETURN 0

IF rb_qty.Checked = TRUE THEN
	// 그래프 백그라운드 색상을 바꾼다
	//
	dw_pisq131i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq131i_01_com.print()
END IF	

IF rb_lot.Checked = TRUE THEN
	// 그래프 백그라운드 색상을 바꾼다
	//
	dw_pisq131i_02_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq131i_02_com.print()
END IF	

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq131i_01.SetTransObject(SQLPIS)
dw_pisq131i_01_graph.SetTransObject(SQLPIS)
dw_pisq131i_01_com.SetTransObject(SQLPIS)
dw_pisq131i_02_com.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq131i
integer x = 27
integer y = 1776
integer width = 3598
end type

type gb_2 from groupbox within w_pisq131i
integer x = 2473
integer y = 36
integer width = 631
integer height = 124
integer taborder = 50
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_area from u_pisc_select_area within w_pisq131i
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
dw_pisq131i_01.SetTransObject(SQLPIS)
dw_pisq131i_01_graph.SetTransObject(SQLPIS)
dw_pisq131i_01_com.SetTransObject(SQLPIS)
dw_pisq131i_02_com.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq131i
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
dw_pisq131i_01.SetTransObject(SQLPIS)
dw_pisq131i_01_graph.SetTransObject(SQLPIS)
dw_pisq131i_01_com.SetTransObject(SQLPIS)
dw_pisq131i_02_com.SetTransObject(SQLPIS)

end event

type dw_pisq131i_01_graph from datawindow within w_pisq131i
event ue_rbuttonup pbm_dwnrbuttonup
integer x = 18
integer y = 192
integer width = 4613
integer height = 1960
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq131i_01_graph"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_rbuttonup;
st_countview2.Visible = FALSE

// 시스템 팝업메뉴 표시를 억제한다.
//
RETURN 1


end event

event rbuttondown;
//------------------------------------------------------------------------------
// 처리개요		:	Application Rbuttondown Script
//						- 그래프의 VALUE값을 표시한다.
// 사용인수		:	None
// 반환값		:	None
//------------------------------------------------------------------------------

// 그래프의 VALUE값을 표시하는 함수를 호출한다. (사용자 정의함수)
//
f_DisplayGraphValue (This, st_countview2)

//------------------------------------------------------------------------------
// End of Script
//------------------------------------------------------------------------------

end event

type dw_pisq131i_01 from datawindow within w_pisq131i
integer x = 18
integer y = 2160
integer width = 4613
integer height = 428
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq131i_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_lot from radiobutton within w_pisq131i
integer x = 2505
integer y = 72
integer width = 256
integer height = 60
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "LOT별"
end type

event clicked;
// LOT별 조회용 데이타윈도우를 셋트한다
//
dw_pisq131i_01.dataobject = 'd_pisq131i_02'
dw_pisq131i_01_graph.dataobject = 'd_pisq131i_02_graph'
dw_down.dataobject = 'd_pisq131i_04'

dw_pisq131i_01.SetTransObject(SQLPIS)
dw_pisq131i_01_graph.SetTransObject(SQLPIS)
dw_down.settransobject(sqlpis)



end event

type rb_qty from radiobutton within w_pisq131i
integer x = 2802
integer y = 72
integer width = 288
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "수량별"
boolean checked = true
end type

event clicked;
// LOT별 조회용 데이타윈도우를 셋트한다
//
dw_pisq131i_01.dataobject = 'd_pisq131i_01'
dw_pisq131i_01_graph.dataobject = 'd_pisq131i_01_graph'
dw_down.dataobject = 'd_pisq131i_03'

dw_pisq131i_01.SetTransObject(SQLPIS)
dw_pisq131i_01_graph.SetTransObject(SQLPIS)
dw_down.settransobject(sqlpis)



end event

type st_countview2 from statictext within w_pisq131i
boolean visible = false
integer x = 1554
integer y = 628
integer width = 224
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_date from u_pisc_date_applydate within w_pisq131i
event destroy ( )
integer x = 1202
integer y = 64
integer taborder = 60
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_dateto from u_pisc_date_applydate_1 within w_pisq131i
event destroy ( )
integer x = 1915
integer y = 64
integer taborder = 70
boolean bringtotop = true
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

type st_4 from statictext within w_pisq131i
integer x = 1870
integer y = 76
integer width = 46
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type dw_pisq131i_01_com from datawindow within w_pisq131i
boolean visible = false
integer x = 37
integer y = 204
integer width = 2249
integer height = 1636
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq131i_01_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisq131i_02_com from datawindow within w_pisq131i
boolean visible = false
integer x = 2309
integer y = 204
integer width = 2318
integer height = 1636
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq131i_02_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_excel from commandbutton within w_pisq131i
integer x = 3237
integer y = 48
integer width = 535
integer height = 104
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "엑셀다운로드"
end type

event clicked;String	ls_AreaCode, ls_DivisionCode, ls_QcDatefm, ls_QcDateto

// 조회에 필요한 정보를 구한다
//
dw_down.reset()

ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_QcDatefm			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_QcDateto			= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')

if dw_down.retrieve(ls_AreaCode,ls_DivisionCode,ls_QcDatefm,ls_QcDateto) < 1 then
	uo_status.st_message.text = "다운로드할 자료가 없습니다."
	return 0
end if

f_save_to_excel(dw_down)
end event

type dw_down from datawindow within w_pisq131i
boolean visible = false
integer x = 3794
integer y = 28
integer width = 320
integer height = 152
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_pisq131i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq131i
integer x = 18
integer y = 12
integer width = 4613
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

