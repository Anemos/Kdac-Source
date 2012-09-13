$PBExportHeader$w_pisq285i.srw
$PBExportComments$Containment 검사현황
forward
global type w_pisq285i from w_ipis_sheet01
end type
type dw_pisq285i from u_vi_std_datawindow within w_pisq285i
end type
type uo_area from u_pisc_select_area within w_pisq285i
end type
type uo_division from u_pisc_select_division within w_pisq285i
end type
type st_4 from statictext within w_pisq285i
end type
type uo_date from u_pisc_date_applydate within w_pisq285i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq285i
end type
type cb_saveas from commandbutton within w_pisq285i
end type
type gb_1 from groupbox within w_pisq285i
end type
end forward

global type w_pisq285i from w_ipis_sheet01
integer width = 4690
integer height = 2136
string title = "Containment 검사현황"
dw_pisq285i dw_pisq285i
uo_area uo_area
uo_division uo_division
st_4 st_4
uo_date uo_date
uo_dateto uo_dateto
cb_saveas cb_saveas
gb_1 gb_1
end type
global w_pisq285i w_pisq285i

type variables

end variables

on w_pisq285i.create
int iCurrent
call super::create
this.dw_pisq285i=create dw_pisq285i
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_4=create st_4
this.uo_date=create uo_date
this.uo_dateto=create uo_dateto
this.cb_saveas=create cb_saveas
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq285i
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.uo_date
this.Control[iCurrent+6]=this.uo_dateto
this.Control[iCurrent+7]=this.cb_saveas
this.Control[iCurrent+8]=this.gb_1
end on

on w_pisq285i.destroy
call super::destroy
destroy(this.dw_pisq285i)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_4)
destroy(this.uo_date)
destroy(this.uo_dateto)
destroy(this.cb_saveas)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq285i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_datefm, ls_dateto

// 조회에 필요한 정보를 구한다
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_datefm			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_dateto			= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')

// 데이타를 조회한다
//
dw_pisq285i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_datefm, ls_dateto)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq285i, 1, True)	


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
dw_pisq285i.SetTransObject(SQLPIS)

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq285i.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq285i
integer x = 18
integer width = 3598
end type

type dw_pisq285i from u_vi_std_datawindow within w_pisq285i
integer x = 18
integer y = 192
integer width = 4512
integer height = 1696
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_pisq285i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
//cb_print.TriggerEvent(Clicked!)
end event

type uo_area from u_pisc_select_area within w_pisq285i
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
dw_pisq285i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq285i
event destroy ( )
integer x = 544
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
dw_pisq285i.SetTransObject(SQLPIS)

end event

type st_4 from statictext within w_pisq285i
integer x = 1760
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

type uo_date from u_pisc_date_applydate within w_pisq285i
event destroy ( )
integer x = 1093
integer y = 64
integer taborder = 50
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_dateto from u_pisc_date_applydate_1 within w_pisq285i
event destroy ( )
integer x = 1806
integer y = 64
integer taborder = 60
boolean bringtotop = true
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

type cb_saveas from commandbutton within w_pisq285i
integer x = 4142
integer y = 44
integer width = 448
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "엑셀파일저장"
end type

event clicked;
dw_pisq285i.SaveAs()



end event

type gb_1 from groupbox within w_pisq285i
integer x = 18
integer y = 12
integer width = 4613
integer height = 168
integer taborder = 70
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

