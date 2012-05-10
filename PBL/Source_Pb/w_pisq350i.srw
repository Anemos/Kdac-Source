$PBExportHeader$w_pisq350i.srw
$PBExportComments$Weibull Chart 조회
forward
global type w_pisq350i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq350i
end type
type uo_division from u_pisc_select_division within w_pisq350i
end type
type gb_2 from groupbox within w_pisq350i
end type
type dw_pisq350i_01 from datawindow within w_pisq350i
end type
type st_3 from statictext within w_pisq350i
end type
type sle_itemcode from singlelineedit within w_pisq350i
end type
type dw_pisq350i_02 from datawindow within w_pisq350i
end type
type st_4 from statictext within w_pisq350i
end type
type sle_analyzecode from singlelineedit within w_pisq350i
end type
type sle_analyzename from singlelineedit within w_pisq350i
end type
type rb_dptv from radiobutton within w_pisq350i
end type
type rb_iptv from radiobutton within w_pisq350i
end type
type uo_month from u_pisc_date_scroll_month within w_pisq350i
end type
type pb_serch from picturebutton within w_pisq350i
end type
type cb_saveas from commandbutton within w_pisq350i
end type
type gb_3 from groupbox within w_pisq350i
end type
type sle_itemname from singlelineedit within w_pisq350i
end type
type st_2 from statictext within w_pisq350i
end type
type st_34 from statictext within w_pisq350i
end type
end forward

global type w_pisq350i from w_ipis_sheet01
integer width = 4837
integer height = 2784
string title = "Weibull Chart 조회"
uo_area uo_area
uo_division uo_division
gb_2 gb_2
dw_pisq350i_01 dw_pisq350i_01
st_3 st_3
sle_itemcode sle_itemcode
dw_pisq350i_02 dw_pisq350i_02
st_4 st_4
sle_analyzecode sle_analyzecode
sle_analyzename sle_analyzename
rb_dptv rb_dptv
rb_iptv rb_iptv
uo_month uo_month
pb_serch pb_serch
cb_saveas cb_saveas
gb_3 gb_3
sle_itemname sle_itemname
st_2 st_2
st_34 st_34
end type
global w_pisq350i w_pisq350i

type variables

datawindowchild	idwc_badreason, idwc_badtype
Boolean	ib_open
str_pisr_partkb istr_partkb

end variables

forward prototypes
public subroutine wf_monthcreate ()
public subroutine wf_dptvcreate ()
end prototypes

public subroutine wf_monthcreate ();
Long	ll_row

dw_pisq350i_02.SetRedraw(FALSE)
FOR ll_row = 1 TO 36
	IF dw_pisq350i_02.GetItemNumber(ll_row, 'as_title') = ll_row THEN
	ELSE
		dw_pisq350i_02.InsertRow(ll_row)
		dw_pisq350i_02.SetItem(ll_row, 'as_title', ll_row)
	END IF
NEXT
dw_pisq350i_02.SetRedraw(TRUE)

end subroutine

public subroutine wf_dptvcreate ();

String	ls_colname
Decimal	ld_qty
Long		ll_row, ll_idx

// 월DPTV/IPTV를 생성한다
//
ll_row = dw_pisq350i_01.InsertRow(0)
IF rb_dptv.Checked = TRUE THEN
	dw_pisq350i_01.SetItem(ll_row, 'as_titl', '월DPTV')
END IF
IF rb_iptv.Checked = TRUE THEN
	dw_pisq350i_01.SetItem(ll_row, 'as_titl', '월IPTV')
END IF

FOR ll_idx = 35 TO 0 STEP -1
	ls_colname = 'M_' + String(ll_idx, '00')
	ld_qty = dw_pisq350i_01.GetItemNumber(1, ls_colname) / dw_pisq350i_01.GetItemNumber(3, ls_colname) * 1000
	dw_pisq350i_01.SetItem(ll_row, ls_colname, ld_qty)
NEXT

// 누적DPTV/IPTV를 생성한다
//
ll_row = dw_pisq350i_01.InsertRow(0)
IF rb_dptv.Checked = TRUE THEN
	dw_pisq350i_01.SetItem(ll_row, 'as_titl', '누적DPTV')
END IF
IF rb_iptv.Checked = TRUE THEN
	dw_pisq350i_01.SetItem(ll_row, 'as_titl', '누적IPTV')
END IF

FOR ll_idx = 35 TO 0 STEP -1
	ls_colname = 'M_' + String(ll_idx, '00')
	ld_qty = dw_pisq350i_01.GetItemNumber(2, ls_colname) / dw_pisq350i_01.GetItemNumber(4, ls_colname) * 1000
	dw_pisq350i_01.SetItem(ll_row, ls_colname, ld_qty)
NEXT

end subroutine

on w_pisq350i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_2=create gb_2
this.dw_pisq350i_01=create dw_pisq350i_01
this.st_3=create st_3
this.sle_itemcode=create sle_itemcode
this.dw_pisq350i_02=create dw_pisq350i_02
this.st_4=create st_4
this.sle_analyzecode=create sle_analyzecode
this.sle_analyzename=create sle_analyzename
this.rb_dptv=create rb_dptv
this.rb_iptv=create rb_iptv
this.uo_month=create uo_month
this.pb_serch=create pb_serch
this.cb_saveas=create cb_saveas
this.gb_3=create gb_3
this.sle_itemname=create sle_itemname
this.st_2=create st_2
this.st_34=create st_34
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_pisq350i_01
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.sle_itemcode
this.Control[iCurrent+7]=this.dw_pisq350i_02
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.sle_analyzecode
this.Control[iCurrent+10]=this.sle_analyzename
this.Control[iCurrent+11]=this.rb_dptv
this.Control[iCurrent+12]=this.rb_iptv
this.Control[iCurrent+13]=this.uo_month
this.Control[iCurrent+14]=this.pb_serch
this.Control[iCurrent+15]=this.cb_saveas
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.sle_itemname
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_34
end on

on w_pisq350i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_2)
destroy(this.dw_pisq350i_01)
destroy(this.st_3)
destroy(this.sle_itemcode)
destroy(this.dw_pisq350i_02)
destroy(this.st_4)
destroy(this.sle_analyzecode)
destroy(this.sle_analyzename)
destroy(this.rb_dptv)
destroy(this.rb_iptv)
destroy(this.uo_month)
destroy(this.pb_serch)
destroy(this.cb_saveas)
destroy(this.gb_3)
destroy(this.sle_itemname)
destroy(this.st_2)
destroy(this.st_34)
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
String	ls_areacode, ls_DivisionCode, ls_datefm, ls_dateto, ls_itemcode, ls_analyzecode, ls_dptvgubun

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
ls_Datefm			= uo_month.is_uo_month + '.01'
ls_Dateto			= uo_month.is_uo_month + '.' + String(f_get_lastday_of_month(uo_month.is_uo_month),'00')
ls_analyzecode		= sle_analyzecode.Text + '%'

IF rb_dptv.Checked = TRUE THEN
	ls_dptvgubun	= '1'
END IF
IF rb_iptv.Checked = TRUE THEN
	ls_dptvgubun	= '%'
END IF

dw_pisq350i_01.SetReDraw(FALSE)

// 데이타를 조회한다
//
dw_pisq350i_01.Retrieve(ls_areacode, ls_DivisionCode, ls_datefm, ls_dateto, ls_itemcode, ls_analyzecode, ls_dptvgubun)
dw_pisq350i_02.Retrieve(ls_areacode, ls_DivisionCode, ls_datefm, ls_dateto, ls_itemcode, ls_analyzecode, ls_dptvgubun)

// 월DPTV/IPTV, 누적DPTV/IPTV를 작성한다
// 
wf_dptvcreate()

// 경과월이 없는 경과월을 생성한다
// 
wf_monthcreate()

dw_pisq350i_01.SetReDraw(TRUE)

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
dw_pisq350i_01.SetTransObject(SQLPIS)
dw_pisq350i_02.SetTransObject(SQLPIS)

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

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq350i_01.SetTransObject(SQLPIS)
dw_pisq350i_02.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq350i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq350i
integer x = 59
integer y = 44
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
dw_pisq350i_01.SetTransObject(SQLPIS)
dw_pisq350i_02.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq350i
event destroy ( )
integer x = 553
integer y = 44
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
dw_pisq350i_01.SetTransObject(SQLPIS)
dw_pisq350i_02.SetTransObject(SQLPIS)

end event

type gb_2 from groupbox within w_pisq350i
integer x = 18
integer y = 260
integer width = 4613
integer height = 2332
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_pisq350i_01 from datawindow within w_pisq350i
integer x = 46
integer y = 292
integer width = 4558
integer height = 672
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq350i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_pisq350i
integer x = 59
integer y = 156
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

type sle_itemcode from singlelineedit within w_pisq350i
integer x = 224
integer y = 144
integer width = 425
integer height = 72
integer taborder = 40
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

type dw_pisq350i_02 from datawindow within w_pisq350i
integer x = 46
integer y = 980
integer width = 4558
integer height = 1592
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq350i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_pisq350i
integer x = 1765
integer y = 156
integer width = 302
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
string text = "불량유형:"
boolean focusrectangle = false
end type

type sle_analyzecode from singlelineedit within w_pisq350i
integer x = 2057
integer y = 144
integer width = 242
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 6
borderstyle borderstyle = stylelowered!
end type

event modified;
String	ls_areacode, ls_DivisionCode, ls_analyzecode, ls_smallgroupname

ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_analyzecode 	= sle_analyzecode.Text
	
SELECT A.SMALLGROUPNAME  
  INTO :ls_smallgroupname
  FROM TQWARRANTYSMALL A
 WHERE A.AREACODE			= :ls_areacode
	AND A.DIVISIONCODE	= :ls_DivisionCode
	AND A.PRODUCTGROUP	= SUBSTRING(:ls_analyzecode, 1, 2)
	AND A.LARGEGROUPCODE	= SUBSTRING(:ls_analyzecode, 3, 1)
	AND A.MIDDLEGROUPCODE= SUBSTRING(:ls_analyzecode, 4, 1)
	AND A.SMALLGROUPCODE	= SUBSTRING(:ls_analyzecode, 5, 2)
USING SQLPIS;

IF SQLPIS.SQLCode = 0 THEN
	sle_analyzename.Text = ls_smallgroupname
ELSE
	sle_analyzename.Text = ' '
	MessageBox('확 인', '해당코드는 미등록 코드입니다', StopSign!)
	This.SetFocus()
END IF

end event

type sle_analyzename from singlelineedit within w_pisq350i
integer x = 2304
integer y = 144
integer width = 617
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
integer limit = 12
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type rb_dptv from radiobutton within w_pisq350i
integer x = 2971
integer y = 60
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
string text = "DPTV"
boolean checked = true
end type

type rb_iptv from radiobutton within w_pisq350i
integer x = 2971
integer y = 148
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
string text = "IPTV"
end type

type uo_month from u_pisc_date_scroll_month within w_pisq350i
event destroy ( )
integer x = 1111
integer y = 44
integer height = 80
integer taborder = 30
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type pb_serch from picturebutton within w_pisq350i
integer x = 1445
integer y = 132
integer width = 238
integer height = 96
integer taborder = 60
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

type cb_saveas from commandbutton within w_pisq350i
integer x = 4096
integer y = 68
integer width = 498
integer height = 140
integer taborder = 70
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
dw_pisq350i_01.SaveAs()
dw_pisq350i_02.SaveAs()



end event

type gb_3 from groupbox within w_pisq350i
integer x = 18
integer y = 12
integer width = 4613
integer height = 240
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type sle_itemname from singlelineedit within w_pisq350i
integer x = 654
integer y = 144
integer width = 786
integer height = 72
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

type st_2 from statictext within w_pisq350i
integer x = 1765
integer y = 36
integer width = 1170
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "불량유형코드입력시 제품군 + 분석코드"
boolean focusrectangle = false
end type

type st_34 from statictext within w_pisq350i
integer x = 1765
integer y = 88
integer width = 814
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "형태로 입력하세요(30AB01)"
boolean focusrectangle = false
end type

