$PBExportHeader$w_pisq380i.srw
$PBExportComments$Warranty 품질실적
forward
global type w_pisq380i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq380i
end type
type uo_division from u_pisc_select_division within w_pisq380i
end type
type dw_pisq380i_01 from u_vi_std_datawindow within w_pisq380i
end type
type gb_2 from groupbox within w_pisq380i
end type
type uo_year from u_pisc_date_scroll_year within w_pisq380i
end type
type gb_3 from groupbox within w_pisq380i
end type
type st_5 from statictext within w_pisq380i
end type
type dw_print from datawindow within w_pisq380i
end type
type rb_iptv from radiobutton within w_pisq380i
end type
type rb_dptv from radiobutton within w_pisq380i
end type
end forward

global type w_pisq380i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Warranty 품질실적"
uo_area uo_area
uo_division uo_division
dw_pisq380i_01 dw_pisq380i_01
gb_2 gb_2
uo_year uo_year
gb_3 gb_3
st_5 st_5
dw_print dw_print
rb_iptv rb_iptv
rb_dptv rb_dptv
end type
global w_pisq380i w_pisq380i

type variables


string is_custgubun,is_custcode

Boolean	ib_open

end variables

on w_pisq380i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq380i_01=create dw_pisq380i_01
this.gb_2=create gb_2
this.uo_year=create uo_year
this.gb_3=create gb_3
this.st_5=create st_5
this.dw_print=create dw_print
this.rb_iptv=create rb_iptv
this.rb_dptv=create rb_dptv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq380i_01
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.uo_year
this.Control[iCurrent+6]=this.gb_3
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.dw_print
this.Control[iCurrent+9]=this.rb_iptv
this.Control[iCurrent+10]=this.rb_dptv
end on

on w_pisq380i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq380i_01)
destroy(this.gb_2)
destroy(this.uo_year)
destroy(this.gb_3)
destroy(this.st_5)
destroy(this.dw_print)
destroy(this.rb_iptv)
destroy(this.rb_dptv)
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
String	ls_areacode, ls_divisioncode, ls_datefm, ls_dateto, ls_dptvgubun

// 조회에 필요한 값을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_datefm			= uo_year.is_uo_year + '.12.01'
ls_Dateto			= uo_year.is_uo_year + '.12.31'

IF rb_dptv.Checked = TRUE THEN
	ls_dptvgubun	= '1%'
END IF
IF rb_iptv.Checked = TRUE THEN
	ls_dptvgubun	= '%'
END IF

// 데이타를 조회한다
//
dw_pisq380i_01.Retrieve(ls_areacode, ls_divisioncode, ls_datefm, ls_dateto)


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
string ls_codegroup,ls_codegroupname,ls_codename

// 트랜잭션을 연결한다
//
dw_pisq380i_01.SetTransObject(SQLEIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
ib_open = true										

end event

event ue_print;call super::ue_print;
String		ls_year, ls_areaname, ls_divisionname
transaction	ls_trans
str_easy		lstr_prt
window		lw_open


dw_pisq380i_01.ShareData(dw_print)


ls_trans	= SQLEIS

//dw_print.modify("t_year.text   	= '" + ls_DeliveryNo + "'")

ls_year 			= uo_year.is_uo_year + '년'
ls_areaname		= uo_area.is_uo_areaname
ls_divisionname= uo_division.is_uo_divisionname

// 인쇄 DataWindow 저장
//
lstr_prt.transaction	=	ls_trans
lstr_prt.datawindow	= 	dw_print
lstr_prt.title			= 	"WARRANTY 품질실적(내수금액) - 매출24개월 평균 출력"
lstr_prt.tag			= 	This.ClassName()
lstr_prt.dwsyntax 	= "t_year.text   	= '" + ls_year + "'" + "t_areaname.text   	= '" + ls_areaname + "'" + "t_divisionname.text   	= '" + ls_divisionname + "'"

f_close_report("2", lstr_prt.title)						// Open된 출력Window 닫기
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("확인","EIS 서버에 연결하는데 실패했습니다.")
end if
end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq380i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq380i
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

type uo_division from u_pisc_select_division within w_pisq380i
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

type dw_pisq380i_01 from u_vi_std_datawindow within w_pisq380i
integer x = 37
integer y = 208
integer width = 4553
integer height = 2348
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq380i_01"
boolean vscrollbar = true
end type

event rowfocuschanged;//
end event

event clicked;//
end event

type gb_2 from groupbox within w_pisq380i
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

type uo_year from u_pisc_date_scroll_year within w_pisq380i
integer x = 1262
integer y = 64
integer taborder = 40
boolean bringtotop = true
end type

on uo_year.destroy
call u_pisc_date_scroll_year::destroy
end on

type gb_3 from groupbox within w_pisq380i
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

type st_5 from statictext within w_pisq380i
integer x = 1257
integer y = 72
integer width = 233
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
string text = "정산년:"
boolean focusrectangle = false
end type

type dw_print from datawindow within w_pisq380i
boolean visible = false
integer x = 1193
integer y = 1136
integer width = 1925
integer height = 1000
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq380i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_iptv from radiobutton within w_pisq380i
boolean visible = false
integer x = 2085
integer y = 72
integer width = 242
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
boolean enabled = false
string text = "IPTV"
end type

type rb_dptv from radiobutton within w_pisq380i
boolean visible = false
integer x = 1829
integer y = 72
integer width = 242
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
boolean enabled = false
string text = "DPTV"
boolean checked = true
end type

