$PBExportHeader$w_pisq900i.srw
$PBExportComments$검사기준서 관리화면(운영자용)
forward
global type w_pisq900i from w_ipis_sheet01
end type
type dw_pisq900i from u_vi_std_datawindow within w_pisq900i
end type
type uo_area from u_pisc_select_area within w_pisq900i
end type
type uo_division from u_pisc_select_division within w_pisq900i
end type
type st_3 from statictext within w_pisq900i
end type
type sle_suppliercode from singlelineedit within w_pisq900i
end type
type sle_suppliername from singlelineedit within w_pisq900i
end type
type st_4 from statictext within w_pisq900i
end type
type cb_print from commandbutton within w_pisq900i
end type
type uo_date from u_pisc_date_applydate within w_pisq900i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq900i
end type
type rb_consert from radiobutton within w_pisq900i
end type
type rb_return from radiobutton within w_pisq900i
end type
type rb_all from radiobutton within w_pisq900i
end type
type pb_serch from picturebutton within w_pisq900i
end type
type st_5 from statictext within w_pisq900i
end type
type sle_itemcode from singlelineedit within w_pisq900i
end type
type sle_itemname from singlelineedit within w_pisq900i
end type
type pb_serch2 from picturebutton within w_pisq900i
end type
type cb_image from commandbutton within w_pisq900i
end type
type cb_imageend from commandbutton within w_pisq900i
end type
type gb_1 from groupbox within w_pisq900i
end type
type cb_fullimage from commandbutton within w_pisq900i
end type
end forward

global type w_pisq900i from w_ipis_sheet01
integer width = 4690
integer height = 2848
string title = "검사기준서 관리화면(운영자용)"
dw_pisq900i dw_pisq900i
uo_area uo_area
uo_division uo_division
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
st_4 st_4
cb_print cb_print
uo_date uo_date
uo_dateto uo_dateto
rb_consert rb_consert
rb_return rb_return
rb_all rb_all
pb_serch pb_serch
st_5 st_5
sle_itemcode sle_itemcode
sle_itemname sle_itemname
pb_serch2 pb_serch2
cb_image cb_image
cb_imageend cb_imageend
gb_1 gb_1
cb_fullimage cb_fullimage
end type
global w_pisq900i w_pisq900i

type variables

str_pisr_partkb istr_partkb

end variables

on w_pisq900i.create
int iCurrent
call super::create
this.dw_pisq900i=create dw_pisq900i
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.st_4=create st_4
this.cb_print=create cb_print
this.uo_date=create uo_date
this.uo_dateto=create uo_dateto
this.rb_consert=create rb_consert
this.rb_return=create rb_return
this.rb_all=create rb_all
this.pb_serch=create pb_serch
this.st_5=create st_5
this.sle_itemcode=create sle_itemcode
this.sle_itemname=create sle_itemname
this.pb_serch2=create pb_serch2
this.cb_image=create cb_image
this.cb_imageend=create cb_imageend
this.gb_1=create gb_1
this.cb_fullimage=create cb_fullimage
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq900i
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.sle_suppliercode
this.Control[iCurrent+6]=this.sle_suppliername
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.cb_print
this.Control[iCurrent+9]=this.uo_date
this.Control[iCurrent+10]=this.uo_dateto
this.Control[iCurrent+11]=this.rb_consert
this.Control[iCurrent+12]=this.rb_return
this.Control[iCurrent+13]=this.rb_all
this.Control[iCurrent+14]=this.pb_serch
this.Control[iCurrent+15]=this.st_5
this.Control[iCurrent+16]=this.sle_itemcode
this.Control[iCurrent+17]=this.sle_itemname
this.Control[iCurrent+18]=this.pb_serch2
this.Control[iCurrent+19]=this.cb_image
this.Control[iCurrent+20]=this.cb_imageend
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.cb_fullimage
end on

on w_pisq900i.destroy
call super::destroy
destroy(this.dw_pisq900i)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.st_4)
destroy(this.cb_print)
destroy(this.uo_date)
destroy(this.uo_dateto)
destroy(this.rb_consert)
destroy(this.rb_return)
destroy(this.rb_all)
destroy(this.pb_serch)
destroy(this.st_5)
destroy(this.sle_itemcode)
destroy(this.sle_itemname)
destroy(this.pb_serch2)
destroy(this.cb_image)
destroy(this.cb_imageend)
destroy(this.gb_1)
destroy(this.cb_fullimage)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq900i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_enactmentdate_fm, ls_enactmentdate_to
String	ls_SupplierCode, ls_itemcode, ls_chkflag

// 조회에 필요한 정보를 구한다
//
ls_AreaCode				= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode		= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_enactmentdate_fm	= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_enactmentdate_to	= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')
ls_SupplierCode		= sle_suppliercode.Text + '%'
ls_itemcode				= sle_itemcode.Text + '%'

IF rb_consert.Checked THEN
	ls_chkflag = '2'
END IF
IF rb_return.Checked THEN
	ls_chkflag = '1'
END IF
IF rb_all.Checked THEN
	ls_chkflag = '%'
END IF

ls_enactmentdate_fm	= '0000.00.00'
ls_enactmentdate_to	= '9999.12.31'

// 일자를 입력하지 않으면 최소일자를 셋트한다
//
IF f_checknullorspace(ls_enactmentdate_fm) = TRUE THEN
	ls_enactmentdate_fm	= '0000.00.00'
END IF

// 일자를 입력하지 않으면 최대일자를 셋트한다
//
IF f_checknullorspace(ls_enactmentdate_to) = TRUE THEN
	ls_enactmentdate_to	= '9999.12.31'
END IF

// 데이타를 조회한다
//
dw_pisq900i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate_fm, ls_enactmentdate_to, ls_SupplierCode, ls_itemcode, ls_chkflag)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq900i, 1, True)	




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

IF g_s_empno = 'ADMIN' or &
	g_s_empno = '000030' THEN
	//
ELSE
	CLOSE(This)
END IF

end event

event ue_postopen;call super::ue_postopen;
// 트랜잭션을 연결한다
//
dw_pisq900i.SetTransObject(SQLPIS)

uo_date.st_name.Text	= '승인일:'

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq900i.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq900i
integer x = 18
integer width = 3598
end type

type dw_pisq900i from u_vi_std_datawindow within w_pisq900i
integer x = 18
integer y = 292
integer width = 3589
integer height = 1596
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_pisq040i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_pisc_select_area within w_pisq900i
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
dw_pisq900i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq900i
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
dw_pisq900i.SetTransObject(SQLPIS)


end event

type st_3 from statictext within w_pisq900i
integer x = 983
integer y = 180
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

type sle_suppliercode from singlelineedit within w_pisq900i
integer x = 1285
integer y = 168
integer width = 425
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

type sle_suppliername from singlelineedit within w_pisq900i
integer x = 1714
integer y = 168
integer width = 873
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

type st_4 from statictext within w_pisq900i
integer x = 3529
integer y = 72
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
boolean enabled = false
string text = "~~"
boolean focusrectangle = false
end type

type cb_print from commandbutton within w_pisq900i
integer x = 4146
integer y = 48
integer width = 453
integer height = 96
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기준서 삭제"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq900i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	RETURN
END IF

IF MessageBox("확 인", '기준서를 삭제하시겠습니까�,', Exclamation!, OKCancel!, 2) = 2 THEN
	RETURN
END IF

// 기준서삭제에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_StandardRevno")

dw_pisq900i.DeleteRow(dw_pisq900i.GetSelectedRow(0))

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

DELETE FROM TQQCSTANDARD  
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SUPPLIERCODE	= :ls_SupplierCode
	AND ITEMCODE		= :ls_ItemCode
	AND STANDARDREVNO	= :ls_StandardRevno
 USING SQLPIS;

IF SQLPIS.SQLCode <> 0 THEN
	MessageBox('확 인', '기준서 삭제처리에 실패했습니다.')
END IF

DELETE FROM TQQCSTANDARDDETAIL
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SUPPLIERCODE	= :ls_SupplierCode
	AND ITEMCODE		= :ls_ItemCode
	AND STANDARDREVNO	= :ls_StandardRevno
 USING SQLPIS;

DELETE FROM TQQCSTANDARDCHANGE
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SUPPLIERCODE	= :ls_SupplierCode
	AND ITEMCODE		= :ls_ItemCode
 USING SQLPIS;

DELETE FROM TQQCSTANDARDCHANGEDETAIL
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SUPPLIERCODE	= :ls_SupplierCode
	AND ITEMCODE		= :ls_ItemCode
 USING SQLPIS;

SQLPIS.AUTOCommit = TRUE

end event

type uo_date from u_pisc_date_applydate within w_pisq900i
event destroy ( )
integer x = 2862
integer y = 60
integer taborder = 80
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_dateto from u_pisc_date_applydate_1 within w_pisq900i
event destroy ( )
integer x = 3575
integer y = 60
integer taborder = 100
boolean bringtotop = true
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

type rb_consert from radiobutton within w_pisq900i
integer x = 64
integer y = 160
integer width = 224
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
string text = "승인"
boolean checked = true
end type

type rb_return from radiobutton within w_pisq900i
integer x = 288
integer y = 160
integer width = 224
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
boolean enabled = false
string text = "반송"
end type

type rb_all from radiobutton within w_pisq900i
integer x = 512
integer y = 160
integer width = 224
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
boolean enabled = false
string text = "전체"
end type

type pb_serch from picturebutton within w_pisq900i
integer x = 2587
integer y = 160
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
istr_partkb.flag		= 2			//외주업체(지역,공장)
istr_partkb.remark	= sle_suppliercode.Text

OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_suppliercode.Text = lstr_Rtn.code
sle_suppliername.Text = lstr_Rtn.name


end event

type st_5 from statictext within w_pisq900i
integer x = 1097
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
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_itemcode from singlelineedit within w_pisq900i
integer x = 1285
integer y = 60
integer width = 425
integer height = 72
integer taborder = 30
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

type sle_itemname from singlelineedit within w_pisq900i
integer x = 1714
integer y = 60
integer width = 873
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

type pb_serch2 from picturebutton within w_pisq900i
integer x = 2587
integer y = 56
integer width = 238
integer height = 96
integer taborder = 40
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

type cb_image from commandbutton within w_pisq900i
integer x = 3675
integer y = 156
integer width = 453
integer height = 96
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "승인의뢰"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq900i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	RETURN
END IF

// 기준서수정에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_StandardRevno")

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

UPDATE TQQCSTANDARD  
	SET CONSERTDEPENDENCEFLAG	= 'Y',   
		 CHARGECONSERTFLAG		= 'X',   
		 CHARGECODE					= ' ',   
		 SANCTIONCONSERTFLAG		= 'X',   
		 SANCTIONCODE				= ' ',   
		 CONSERTDATE				= ' ',   
		 APPLYDATE					= ' '  
 WHERE TQQCSTANDARD.AREACODE			= :ls_AreaCode
	AND TQQCSTANDARD.DIVISIONCODE		= :ls_DivisionCode
	AND TQQCSTANDARD.SUPPLIERCODE		= :ls_SupplierCode
	AND TQQCSTANDARD.ITEMCODE			= :ls_ItemCode
	AND TQQCSTANDARD.STANDARDREVNO	= :ls_StandardRevno
 USING SQLPIS;

IF SQLPIS.SQLCode <> 0 THEN
	MessageBox('확 인', '승인의뢰 변경에 실패했습니다.')
END IF

SQLPIS.AUTOCommit = TRUE

end event

type cb_imageend from commandbutton within w_pisq900i
integer x = 4146
integer y = 156
integer width = 453
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "당당자반송"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq900i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	RETURN
END IF

// 기준서수정에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_StandardRevno")

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

UPDATE TQQCSTANDARD  
	SET CONSERTDEPENDENCEFLAG	= 'Y',   
		 CHARGECONSERTFLAG		= 'N',   
		 SANCTIONCONSERTFLAG		= 'X',   
		 SANCTIONCODE				= ' ',   
		 CONSERTDATE				= ' ',   
		 APPLYDATE					= ' '  
 WHERE TQQCSTANDARD.AREACODE			= :ls_AreaCode
	AND TQQCSTANDARD.DIVISIONCODE		= :ls_DivisionCode
	AND TQQCSTANDARD.SUPPLIERCODE		= :ls_SupplierCode
	AND TQQCSTANDARD.ITEMCODE			= :ls_ItemCode
	AND TQQCSTANDARD.STANDARDREVNO	= :ls_StandardRevno
 USING SQLPIS;

IF SQLPIS.SQLCode <> 0 THEN
	MessageBox('확 인', '담당자반송 변경에 실패했습니다.')
END IF

SQLPIS.AUTOCommit = TRUE

end event

type gb_1 from groupbox within w_pisq900i
integer x = 18
integer y = 12
integer width = 4613
integer height = 264
integer taborder = 140
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type cb_fullimage from commandbutton within w_pisq900i
integer x = 3154
integer y = 156
integer width = 503
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "임시저장"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno

// 작업대상이 없으면 처리를 하지 않는다
//
IF dw_pisq900i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '작업대상이 없습니다', StopSign!)
	RETURN
END IF

// 기준서수정에 필요한 정보를 구한다
//
ls_AreaCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_StandardRevno")

// AUTO COMMIT을 FASLE로 지정
//
SQLPIS.AUTOCommit = FALSE

UPDATE TQQCSTANDARD  
	SET CONSERTDEPENDENCEFLAG	= 'N',   
		 CHARGECONSERTFLAG		= 'X',   
		 CHARGECODE					= ' ',   
		 SANCTIONCONSERTFLAG		= 'X',   
		 SANCTIONCODE				= ' ',   
		 CONSERTDATE				= ' ',   
		 APPLYDATE					= ' '  
 WHERE TQQCSTANDARD.AREACODE			= :ls_AreaCode
	AND TQQCSTANDARD.DIVISIONCODE		= :ls_DivisionCode
	AND TQQCSTANDARD.SUPPLIERCODE		= :ls_SupplierCode
	AND TQQCSTANDARD.ITEMCODE			= :ls_ItemCode
	AND TQQCSTANDARD.STANDARDREVNO	= :ls_StandardRevno
 USING SQLPIS;

IF SQLPIS.SQLCode <> 0 THEN
	MessageBox('확 인', '임시저장 변경에 실패했습니다.')
END IF

SQLPIS.AUTOCommit = TRUE

end event

