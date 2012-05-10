$PBExportHeader$w_pisq115i.srw
$PBExportComments$검사성적서 조회 및 출력
forward
global type w_pisq115i from w_ipis_sheet01
end type
type dw_pisq115i from u_vi_std_datawindow within w_pisq115i
end type
type uo_area from u_pisc_select_area within w_pisq115i
end type
type uo_division from u_pisc_select_division within w_pisq115i
end type
type st_4 from statictext within w_pisq115i
end type
type cb_detail from commandbutton within w_pisq115i
end type
type uo_date from u_pisc_date_applydate within w_pisq115i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq115i
end type
type rb_qcdate from radiobutton within w_pisq115i
end type
type rb_makedate from radiobutton within w_pisq115i
end type
type cb_saveas from commandbutton within w_pisq115i
end type
type cb_print from commandbutton within w_pisq115i
end type
type st_5 from statictext within w_pisq115i
end type
type st_3 from statictext within w_pisq115i
end type
type sle_suppliercode from singlelineedit within w_pisq115i
end type
type sle_itemcode from singlelineedit within w_pisq115i
end type
type sle_itemname from singlelineedit within w_pisq115i
end type
type sle_suppliername from singlelineedit within w_pisq115i
end type
type pb_serch from picturebutton within w_pisq115i
end type
type pb_serch2 from picturebutton within w_pisq115i
end type
type gb_1 from groupbox within w_pisq115i
end type
end forward

global type w_pisq115i from w_ipis_sheet01
integer width = 4690
integer height = 2136
string title = "검사성적서 현황"
dw_pisq115i dw_pisq115i
uo_area uo_area
uo_division uo_division
st_4 st_4
cb_detail cb_detail
uo_date uo_date
uo_dateto uo_dateto
rb_qcdate rb_qcdate
rb_makedate rb_makedate
cb_saveas cb_saveas
cb_print cb_print
st_5 st_5
st_3 st_3
sle_suppliercode sle_suppliercode
sle_itemcode sle_itemcode
sle_itemname sle_itemname
sle_suppliername sle_suppliername
pb_serch pb_serch
pb_serch2 pb_serch2
gb_1 gb_1
end type
global w_pisq115i w_pisq115i

type variables

str_pisr_partkb istr_partkb

end variables

on w_pisq115i.create
int iCurrent
call super::create
this.dw_pisq115i=create dw_pisq115i
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_4=create st_4
this.cb_detail=create cb_detail
this.uo_date=create uo_date
this.uo_dateto=create uo_dateto
this.rb_qcdate=create rb_qcdate
this.rb_makedate=create rb_makedate
this.cb_saveas=create cb_saveas
this.cb_print=create cb_print
this.st_5=create st_5
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_itemcode=create sle_itemcode
this.sle_itemname=create sle_itemname
this.sle_suppliername=create sle_suppliername
this.pb_serch=create pb_serch
this.pb_serch2=create pb_serch2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq115i
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.cb_detail
this.Control[iCurrent+6]=this.uo_date
this.Control[iCurrent+7]=this.uo_dateto
this.Control[iCurrent+8]=this.rb_qcdate
this.Control[iCurrent+9]=this.rb_makedate
this.Control[iCurrent+10]=this.cb_saveas
this.Control[iCurrent+11]=this.cb_print
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.sle_suppliercode
this.Control[iCurrent+15]=this.sle_itemcode
this.Control[iCurrent+16]=this.sle_itemname
this.Control[iCurrent+17]=this.sle_suppliername
this.Control[iCurrent+18]=this.pb_serch
this.Control[iCurrent+19]=this.pb_serch2
this.Control[iCurrent+20]=this.gb_1
end on

on w_pisq115i.destroy
call super::destroy
destroy(this.dw_pisq115i)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_4)
destroy(this.cb_detail)
destroy(this.uo_date)
destroy(this.uo_dateto)
destroy(this.rb_qcdate)
destroy(this.rb_makedate)
destroy(this.cb_saveas)
destroy(this.cb_print)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_itemcode)
destroy(this.sle_itemname)
destroy(this.sle_suppliername)
destroy(this.pb_serch)
destroy(this.pb_serch2)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq115i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_itemcode, ls_datefm, ls_dateto, ls_chkflag

// 조회에 필요한 정보를 구한다
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_datefm			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_dateto			= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')
ls_SupplierCode	= sle_suppliercode.Text + '%'
ls_itemcode			= sle_itemcode.Text + '%'

IF rb_qcdate.Checked THEN
	ls_chkflag = '1'
END IF
IF rb_makedate.Checked THEN
	ls_chkflag = '2'
END IF

// 데이타를 조회한다
//
dw_pisq115i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_itemcode, ls_datefm, ls_dateto, ls_chkflag)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq115i, 1, True)	
 
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
dw_pisq115i.SetTransObject(SQLPIS)

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq115i.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq115i
integer x = 18
integer width = 3598
end type

type dw_pisq115i from u_vi_std_datawindow within w_pisq115i
integer x = 18
integer y = 292
integer width = 3589
integer height = 1596
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_pisq115i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
//cb_print.TriggerEvent(Clicked!)
end event

type uo_area from u_pisc_select_area within w_pisq115i
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
dw_pisq115i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq115i
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
dw_pisq115i.SetTransObject(SQLPIS)

end event

type st_4 from statictext within w_pisq115i
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

type cb_detail from commandbutton within w_pisq115i
integer x = 4206
integer y = 44
integer width = 384
integer height = 108
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검사내역"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_Deliveryno
String   ls_ItemCode, ls_Revno

// 출력대상이 없으면 처리를 하지 않는다
//
IF dw_pisq115i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '검사내역 대상이 없습니다', StopSign!)
	RETURN
END IF

// 기준서출력에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "SupplierCode")
ls_Deliveryno		= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "Deliveryno")
ls_ItemCode			= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "ItemCode")
ls_Revno          = dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "StandardRevno")

// 인스턴스 스트럭쳐에 값을 저장한다
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_Deliveryno
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_Revno
istr_parms.String_arg[9] = 'MOD'

// 검사성적서 세부내역 화면 오픈
//
OpenWithParm(w_pisq116i, istr_parms)

end event

type uo_date from u_pisc_date_applydate within w_pisq115i
event destroy ( )
integer x = 1093
integer y = 64
integer taborder = 30
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_dateto from u_pisc_date_applydate_1 within w_pisq115i
event destroy ( )
integer x = 1806
integer y = 64
integer taborder = 40
boolean bringtotop = true
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

type rb_qcdate from radiobutton within w_pisq115i
integer x = 2318
integer y = 56
integer width = 352
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "검사일자"
boolean checked = true
end type

type rb_makedate from radiobutton within w_pisq115i
integer x = 2702
integer y = 56
integer width = 352
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "작성일자"
end type

type cb_saveas from commandbutton within w_pisq115i
integer x = 3278
integer y = 44
integer width = 448
integer height = 108
integer taborder = 90
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
dw_pisq115i.SaveAs()



end event

type cb_print from commandbutton within w_pisq115i
integer x = 3758
integer y = 44
integer width = 416
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "성적서 출력"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_Deliveryno, ls_ItemCode
String   ls_revno

// 출력대상이 없으면 처리를 하지 않는다
//
IF dw_pisq115i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '출력대상이 없습니다', StopSign!)
	RETURN
END IF

// 기준서출력에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "SupplierCode")
ls_Deliveryno		= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "Deliveryno")
ls_ItemCode			= dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "ItemCode")
ls_revno          = dw_pisq115i.GetItemString(dw_pisq115i.GetSelectedRow(0), "Standardrevno")

// 인스턴스 스트럭쳐에 값을 저장한다
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_Deliveryno
istr_parms.String_arg[5] = ls_ItemCode
istr_parms.String_arg[6] = ls_revno

// 검사성적서 세부내역 화면 오픈
//
OpenWithParm(w_pisq117p, istr_parms)

end event

type st_5 from statictext within w_pisq115i
integer x = 1618
integer y = 172
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
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq115i
integer x = 50
integer y = 172
integer width = 293
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
string text = "협력업체:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_suppliercode from singlelineedit within w_pisq115i
integer x = 352
integer y = 160
integer width = 320
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
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event modified;
// 업체명을 구한다
//
sle_suppliername.Text = f_getsuppliername(sle_suppliercode.Text)



end event

type sle_itemcode from singlelineedit within w_pisq115i
integer x = 1806
integer y = 160
integer width = 425
integer height = 72
integer taborder = 60
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
sle_itemname.Text = f_getitemname(sle_itemcode.Text)

end event

type sle_itemname from singlelineedit within w_pisq115i
integer x = 2235
integer y = 160
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
borderstyle borderstyle = stylelowered!
end type

type sle_suppliername from singlelineedit within w_pisq115i
integer x = 677
integer y = 160
integer width = 663
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_serch from picturebutton within w_pisq115i
integer x = 1339
integer y = 152
integer width = 238
integer height = 96
integer taborder = 70
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
istr_partkb.flag		= 2			//외주업체(지역,공장)
istr_partkb.remark	= sle_suppliercode.Text

OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_suppliercode.Text = lstr_Rtn.code
sle_suppliername.Text = lstr_Rtn.name


end event

type pb_serch2 from picturebutton within w_pisq115i
integer x = 3026
integer y = 152
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

type gb_1 from groupbox within w_pisq115i
integer x = 18
integer y = 12
integer width = 4613
integer height = 264
integer taborder = 130
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

