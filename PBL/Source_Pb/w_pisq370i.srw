$PBExportHeader$w_pisq370i.srw
$PBExportComments$발생월별 Warranty 불량유형 현황
forward
global type w_pisq370i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq370i
end type
type uo_division from u_pisc_select_division within w_pisq370i
end type
type gb_2 from groupbox within w_pisq370i
end type
type dw_pisq370i_01 from datawindow within w_pisq370i
end type
type st_3 from statictext within w_pisq370i
end type
type sle_itemcode from singlelineedit within w_pisq370i
end type
type sle_itemname from singlelineedit within w_pisq370i
end type
type uo_month from u_pisc_date_scroll_month within w_pisq370i
end type
type pb_serch from picturebutton within w_pisq370i
end type
type dw_print from datawindow within w_pisq370i
end type
type gb_3 from groupbox within w_pisq370i
end type
end forward

global type w_pisq370i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "발생월별 Warranty 불량유형 현황"
uo_area uo_area
uo_division uo_division
gb_2 gb_2
dw_pisq370i_01 dw_pisq370i_01
st_3 st_3
sle_itemcode sle_itemcode
sle_itemname sle_itemname
uo_month uo_month
pb_serch pb_serch
dw_print dw_print
gb_3 gb_3
end type
global w_pisq370i w_pisq370i

type variables

datawindowchild	idwc_badreason, idwc_badtype
Boolean	ib_open
str_pisr_partkb istr_partkb

end variables

on w_pisq370i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_2=create gb_2
this.dw_pisq370i_01=create dw_pisq370i_01
this.st_3=create st_3
this.sle_itemcode=create sle_itemcode
this.sle_itemname=create sle_itemname
this.uo_month=create uo_month
this.pb_serch=create pb_serch
this.dw_print=create dw_print
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_pisq370i_01
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.sle_itemcode
this.Control[iCurrent+7]=this.sle_itemname
this.Control[iCurrent+8]=this.uo_month
this.Control[iCurrent+9]=this.pb_serch
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.gb_3
end on

on w_pisq370i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_2)
destroy(this.dw_pisq370i_01)
destroy(this.st_3)
destroy(this.sle_itemcode)
destroy(this.sle_itemname)
destroy(this.uo_month)
destroy(this.pb_serch)
destroy(this.dw_print)
destroy(this.gb_3)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq290i_01, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_itemcode, ls_date

// 필수 입력항목 체크
//
IF f_checknullorspace(sle_itemcode.Text) = TRUE THEN
	MessageBox('확 인', '품번을 입력하세요', StopSign!)
	sle_itemcode.SetFocus()
	RETURN
END IF

// 조회조건을 구한다
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_itemcode			= sle_itemcode.Text
ls_Date				= uo_month.is_uo_month + '.01'

// 데이타를 조회한다
//
dw_pisq370i_01.Retrieve(ls_areacode, ls_DivisionCode, ls_itemcode, ls_date)



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
dw_pisq370i_01.SetTransObject(SQLPIS)

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

event ue_print;call super::ue_print;
String		ls_area, ls_division, ls_date, ls_item
transaction	ls_trans
str_easy		lstr_prt
window		lw_open

dw_pisq370i_01.ShareData(dw_print)

ls_trans	= SQLPIS

ls_area		= uo_area.is_uo_areaname
ls_division	= uo_division.is_uo_divisionname
ls_date		= uo_month.is_uo_month
ls_item		= sle_itemcode.Text + '(' + sle_itemname.Text + ')'

MessageBox('확 인', '출력시 배율을 97%로 하여 출력하세요')

// 인쇄 DataWindow 저장
//
lstr_prt.transaction	= ls_trans
lstr_prt.datawindow	= dw_print
lstr_prt.title			= "발생월별 Warranty 불량유형 현황"
lstr_prt.tag			= This.ClassName()
lstr_prt.dwsyntax 	= "t_area.text = '" + ls_area + "'" + "t_division.text = '" + ls_division + "'" + "t_date.text = '" + ls_date + "'" + "t_item.text = '" + ls_item + "'" + &
							  "m_35_t.text = '" + mid(f_monthcalc( ls_date + '.01', 35),3,5) + "'" +&
							  "m_34_t.text = '" + mid(f_monthcalc( ls_date + '.01', 34),3,5) + "'" +&
							  "m_33_t.text = '" + mid(f_monthcalc( ls_date + '.01', 33),3,5) + "'" +&
							  "m_32_t.text = '" + mid(f_monthcalc( ls_date + '.01', 32),3,5) + "'" +&
							  "m_31_t.text = '" + mid(f_monthcalc( ls_date + '.01', 31),3,5) + "'" +&
							  "m_30_t.text = '" + mid(f_monthcalc( ls_date + '.01', 30),3,5) + "'" +&
							  "m_29_t.text = '" + mid(f_monthcalc( ls_date + '.01', 29),3,5) + "'" +&
							  "m_28_t.text = '" + mid(f_monthcalc( ls_date + '.01', 28),3,5) + "'" +&
							  "m_27_t.text = '" + mid(f_monthcalc( ls_date + '.01', 27),3,5) + "'" +&
							  "m_26_t.text = '" + mid(f_monthcalc( ls_date + '.01', 26),3,5) + "'" +&
							  "m_25_t.text = '" + mid(f_monthcalc( ls_date + '.01', 25),3,5) + "'" +&
							  "m_24_t.text = '" + mid(f_monthcalc( ls_date + '.01', 24),3,5) + "'" +&
							  "m_23_t.text = '" + mid(f_monthcalc( ls_date + '.01', 23),3,5) + "'" +&
							  "m_22_t.text = '" + mid(f_monthcalc( ls_date + '.01', 22),3,5) + "'" +&
							  "m_21_t.text = '" + mid(f_monthcalc( ls_date + '.01', 21),3,5) + "'" +&
							  "m_20_t.text = '" + mid(f_monthcalc( ls_date + '.01', 20),3,5) + "'" +&
							  "m_19_t.text = '" + mid(f_monthcalc( ls_date + '.01', 19),3,5) + "'" +&
							  "m_18_t.text = '" + mid(f_monthcalc( ls_date + '.01', 18),3,5) + "'" +&
							  "m_17_t.text = '" + mid(f_monthcalc( ls_date + '.01', 17),3,5) + "'" +&
							  "m_16_t.text = '" + mid(f_monthcalc( ls_date + '.01', 16),3,5) + "'" +&
							  "m_15_t.text = '" + mid(f_monthcalc( ls_date + '.01', 15),3,5) + "'" +&
							  "m_14_t.text = '" + mid(f_monthcalc( ls_date + '.01', 14),3,5) + "'" +&
							  "m_13_t.text = '" + mid(f_monthcalc( ls_date + '.01', 13),3,5) + "'" +&
							  "m_12_t.text = '" + mid(f_monthcalc( ls_date + '.01', 12),3,5) + "'" +&
							  "m_11_t.text = '" + mid(f_monthcalc( ls_date + '.01', 11),3,5) + "'" +&
							  "m_10_t.text = '" + mid(f_monthcalc( ls_date + '.01', 10),3,5) + "'" +&
							  "m_09_t.text = '" + mid(f_monthcalc( ls_date + '.01', 09),3,5) + "'" +&
							  "m_08_t.text = '" + mid(f_monthcalc( ls_date + '.01', 08),3,5) + "'" +&
							  "m_07_t.text = '" + mid(f_monthcalc( ls_date + '.01', 07),3,5) + "'" +&
							  "m_06_t.text = '" + mid(f_monthcalc( ls_date + '.01', 06),3,5) + "'" +&
							  "m_05_t.text = '" + mid(f_monthcalc( ls_date + '.01', 05),3,5) + "'" +&
							  "m_04_t.text = '" + mid(f_monthcalc( ls_date + '.01', 04),3,5) + "'" +&
							  "m_03_t.text = '" + mid(f_monthcalc( ls_date + '.01', 03),3,5) + "'" +&
							  "m_02_t.text = '" + mid(f_monthcalc( ls_date + '.01', 02),3,5) + "'" +&
							  "m_01_t.text = '" + mid(f_monthcalc( ls_date + '.01', 01),3,5) + "'" +&
							  "m_00_t.text = '" + mid(f_monthcalc( ls_date + '.01', 00),3,5) + "'" 


f_close_report("2", lstr_prt.title)						// Open된 출력Window 닫기
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq370i_01.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq370i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq370i
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

//string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
//datawindow 	ldw_division
//ldw_division = uo_division.dw_1
//ls_areacode  = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
//

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

// 트랜잭션을 연결한다
//
dw_pisq370i_01.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq370i
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event constructor;call super::constructor;
//PostEvent("ue_post_constructor")

//PostEvent("ue_select")

end event

event ue_post_constructor;call super::ue_post_constructor;//
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
//string ls_productgroupname, ls_areacode, ls_productgroup, ls_DivisionCode
//datawindow 	ldw_productgroup
//
//ldw_productgroup	= uo_productgroup.dw_1
//ls_areacode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
//ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
//
//f_pisc_retrieve_dddw_productgroup(ldw_productgroup,ls_areacode,ls_DivisionCode,'%',true,ls_productgroup,ls_productgroupname)
//
//
end event

event ue_select;call super::ue_select;
// 트랜잭션을 연결한다
//
dw_pisq370i_01.SetTransObject(SQLPIS)

end event

type gb_2 from groupbox within w_pisq370i
integer x = 18
integer y = 12
integer width = 4613
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

type dw_pisq370i_01 from datawindow within w_pisq370i
integer x = 41
integer y = 220
integer width = 4562
integer height = 2336
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq370i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_pisq370i
integer x = 1815
integer y = 72
integer width = 178
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
string text = "품번:"
boolean focusrectangle = false
end type

type sle_itemcode from singlelineedit within w_pisq370i
integer x = 1979
integer y = 60
integer width = 425
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event modified;
String	ls_itemname

// 품명을 구한다
//
ls_itemname = f_getitemname(sle_itemcode.Text)

// 해당코드의 유무판정
//
IF f_checknullorspace(ls_itemname) = TRUE THEN
	Messagebox('확 인', '해당하는 품명이 없습니다', StopSign!)
	sle_itemcode.SetFocus()
	sle_itemname.Text = ''
	RETURN
END IF

sle_itemname.Text = ls_itemname

end event

type sle_itemname from singlelineedit within w_pisq370i
integer x = 2409
integer y = 60
integer width = 873
integer height = 72
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type uo_month from u_pisc_date_scroll_month within w_pisq370i
event destroy ( )
integer x = 1198
integer y = 60
integer height = 80
integer taborder = 50
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type pb_serch from picturebutton within w_pisq370i
integer x = 3282
integer y = 52
integer width = 238
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag = 2			// 전체품번
OpenWithParm ( w_pisr013i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_itemcode.Text = lstr_Rtn.code
sle_itemname.Text = lstr_Rtn.name

end event

type dw_print from datawindow within w_pisq370i
boolean visible = false
integer x = 41
integer y = 432
integer width = 3479
integer height = 1480
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq370i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisq370i
integer x = 18
integer y = 192
integer width = 4613
integer height = 2388
integer taborder = 100
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

