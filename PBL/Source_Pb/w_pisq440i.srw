$PBExportHeader$w_pisq440i.srw
$PBExportComments$RRPPM율 추이그래프
forward
global type w_pisq440i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq440i
end type
type uo_division from u_pisc_select_division within w_pisq440i
end type
type dw_pisq440i_01 from u_vi_std_datawindow within w_pisq440i
end type
type gb_2 from groupbox within w_pisq440i
end type
type uo_custcode from u_piss_select_custcode within w_pisq440i
end type
type st_8 from statictext within w_pisq440i
end type
type uo_scustgubun from u_pisc_select_code within w_pisq440i
end type
type dw_pisq440i_01_graph from datawindow within w_pisq440i
end type
type st_countview2 from statictext within w_pisq440i
end type
type uo_month from u_pisc_date_scroll_month within w_pisq440i
end type
type dw_pisq440i_01_com from datawindow within w_pisq440i
end type
type cbx_all from checkbox within w_pisq440i
end type
type gb_3 from groupbox within w_pisq440i
end type
end forward

global type w_pisq440i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "RRPPM율 추이그래프"
uo_area uo_area
uo_division uo_division
dw_pisq440i_01 dw_pisq440i_01
gb_2 gb_2
uo_custcode uo_custcode
st_8 st_8
uo_scustgubun uo_scustgubun
dw_pisq440i_01_graph dw_pisq440i_01_graph
st_countview2 st_countview2
uo_month uo_month
dw_pisq440i_01_com dw_pisq440i_01_com
cbx_all cbx_all
gb_3 gb_3
end type
global w_pisq440i w_pisq440i

type variables


string is_custgubun,is_custcode

Boolean	ib_open

end variables

on w_pisq440i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq440i_01=create dw_pisq440i_01
this.gb_2=create gb_2
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.dw_pisq440i_01_graph=create dw_pisq440i_01_graph
this.st_countview2=create st_countview2
this.uo_month=create uo_month
this.dw_pisq440i_01_com=create dw_pisq440i_01_com
this.cbx_all=create cbx_all
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq440i_01
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.uo_custcode
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.uo_scustgubun
this.Control[iCurrent+8]=this.dw_pisq440i_01_graph
this.Control[iCurrent+9]=this.st_countview2
this.Control[iCurrent+10]=this.uo_month
this.Control[iCurrent+11]=this.dw_pisq440i_01_com
this.Control[iCurrent+12]=this.cbx_all
this.Control[iCurrent+13]=this.gb_3
end on

on w_pisq440i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq440i_01)
destroy(this.gb_2)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.dw_pisq440i_01_graph)
destroy(this.st_countview2)
destroy(this.uo_month)
destroy(this.dw_pisq440i_01_com)
destroy(this.cbx_all)
destroy(this.gb_3)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq020i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_areacode, ls_divisioncode, ls_raisedate, ls_customercode

// 조회에 필요한 값을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_raisedate		= uo_month.is_uo_month + '.01'
ls_customercode	= is_custcode

// 전체가 선택되면
//
IF cbx_all.Checked = TRUE THEN
	ls_customercode = '%'
END IF

// 데이타를 조회한다
//
dw_pisq440i_01.Retrieve(ls_areacode, ls_divisioncode, ls_customercode, ls_raisedate)
dw_pisq440i_01_graph.Retrieve(ls_areacode, ls_divisioncode, ls_customercode, ls_raisedate)

dw_pisq440i_01_com.Retrieve(ls_areacode, ls_divisioncode, ls_customercode, ls_raisedate)

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

event ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq440i_01.SetTransObject(SQLEIS)
dw_pisq440i_01_graph.SetTransObject(SQLEIS)
dw_pisq440i_01_com.SetTransObject(SQLEIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
ib_open = True
end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if

String ls_codegroup, ls_codegroupname, ls_codename
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

event ue_print;call super::ue_print;
IF MessageBox('확 인', '그래프 출력은 별도의 화면없이 바로 출력됩니다.~r~n출력하시겠습니까?',&
							  Exclamation!, OKCancel!, 2) = 2 THEN RETURN 0

// 그래프 백그라운드 색상을 바꾼다
//
dw_pisq440i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
dw_pisq440i_01_com.print()

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq440i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq440i
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

If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
End If


end event

event ue_post_constructor;call super::ue_post_constructor;
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

//string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
//datawindow 	ldw_division
//ldw_division = uo_division.dw_1
//ls_areacode  = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
//

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq440i
event destroy ( )
integer x = 613
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////	Function		:	f_pisc_retrieve_dddw_productgroup
////	Access		:	public
////	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
////						string			fs_areacode				조회하고자 하는 지역
////						string			fs_divisioncode		조회하고자 하는 공장 코드
////						string			fs_productgroup		조회하고자 하는 제품군 코드 (일반적으로 '%' 을 사용하도록)
////						boolean			fb_allflag				조회된 제품군 정보가 2개 이상의 Record 일 경우
////																		True : '전체' 항목 삽입 (제품군코드는 '%', 제품군명은 '전체')
////																		False : '전체' 항목 미 삽입
////						string			rs_productgroup		선택된 제품군 코드 (reference)
////						string			rs_productgroupname	선택된 제품군 명 (reference)
////	Returns		: none
////	Description	: 제품군을 선택하기 위한 DDDW 을 조회하기 위하여
//// Company		: DAEWOO Information System Co., Ltd. IAS
//// Author		: Kim Jin-Su
//// Coded Date	: 2002.09.04
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//If ib_open Then
//	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											'%', &
//											True, &
//											uo_productgroup.is_uo_productgroup, &
//											uo_productgroup.is_uo_productgroupname)
//											
//	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											uo_productgroup.is_uo_productgroup, &
//											'%', &
//											True, &
//											uo_modelgroup.is_uo_modelgroup, &
//											uo_modelgroup.is_uo_modelgroupname)
//
////	iw_this.TriggerEvent("ue_reset")
//End If
//
//
//
end event

type dw_pisq440i_01 from u_vi_std_datawindow within w_pisq440i
integer x = 46
integer y = 1572
integer width = 4535
integer height = 976
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq440i_01"
boolean vscrollbar = true
end type

event rowfocuschanged;//
end event

event clicked;//
end event

type gb_2 from groupbox within w_pisq440i
integer x = 18
integer y = 12
integer width = 4594
integer height = 168
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_custcode from u_piss_select_custcode within w_pisq440i
event destroy ( )
integer x = 2971
integer y = 60
integer width = 987
integer taborder = 50
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
//dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

type st_8 from statictext within w_pisq440i
integer x = 1915
integer y = 68
integer width = 302
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "고객구분:"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_pisq440i
event destroy ( )
integer x = 2203
integer y = 60
integer width = 713
integer taborder = 40
boolean bringtotop = true
end type

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

event constructor;call super::constructor;postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',FALSE,is_custcode,ls_custname)
//dw_sheet.reset()

end event

event ue_post_constructor;string ls_custname
//is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',FALSE,is_custcode,ls_custname)


end event

type dw_pisq440i_01_graph from datawindow within w_pisq440i
event ue_rbuttonup pbm_dwnrbuttonup
integer x = 46
integer y = 212
integer width = 4535
integer height = 1340
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq440i_01_graph"
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

type st_countview2 from statictext within w_pisq440i
boolean visible = false
integer x = 2615
integer y = 808
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

type uo_month from u_pisc_date_scroll_month within w_pisq440i
event destroy ( )
integer x = 1239
integer y = 60
integer height = 80
integer taborder = 30
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type dw_pisq440i_01_com from datawindow within w_pisq440i
boolean visible = false
integer x = 1586
integer y = 416
integer width = 1225
integer height = 840
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq440i_01_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_all from checkbox within w_pisq440i
integer x = 4064
integer y = 68
integer width = 201
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
string text = "전체"
boolean lefttext = true
end type

type gb_3 from groupbox within w_pisq440i
integer x = 18
integer y = 184
integer width = 4594
integer height = 2392
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

