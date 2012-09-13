$PBExportHeader$w_pisq040i.srw
$PBExportComments$검사기준서 조회 및 출력(조회)
forward
global type w_pisq040i from w_ipis_sheet01
end type
type dw_pisq040i from u_vi_std_datawindow within w_pisq040i
end type
type uo_area from u_pisc_select_area within w_pisq040i
end type
type uo_division from u_pisc_select_division within w_pisq040i
end type
type st_3 from statictext within w_pisq040i
end type
type sle_suppliercode from singlelineedit within w_pisq040i
end type
type sle_suppliername from singlelineedit within w_pisq040i
end type
type st_4 from statictext within w_pisq040i
end type
type cb_print from commandbutton within w_pisq040i
end type
type uo_date from u_pisc_date_applydate within w_pisq040i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq040i
end type
type rb_consert from radiobutton within w_pisq040i
end type
type rb_return from radiobutton within w_pisq040i
end type
type rb_all from radiobutton within w_pisq040i
end type
type pb_serch from picturebutton within w_pisq040i
end type
type st_5 from statictext within w_pisq040i
end type
type sle_itemcode from singlelineedit within w_pisq040i
end type
type sle_itemname from singlelineedit within w_pisq040i
end type
type pb_serch2 from picturebutton within w_pisq040i
end type
type cb_image from commandbutton within w_pisq040i
end type
type cb_imageend from commandbutton within w_pisq040i
end type
type gb_1 from groupbox within w_pisq040i
end type
type p_image from picture within w_pisq040i
end type
type cb_fullimage from commandbutton within w_pisq040i
end type
end forward

global type w_pisq040i from w_ipis_sheet01
integer width = 4690
integer height = 2848
string title = "검사기준서 관리현황"
dw_pisq040i dw_pisq040i
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
p_image p_image
cb_fullimage cb_fullimage
end type
global w_pisq040i w_pisq040i

type variables

str_pisr_partkb istr_partkb

end variables

forward prototypes
public subroutine wf_imagechange ()
end prototypes

public subroutine wf_imagechange ();
blob lb_gyoid_pic, lb_pic 
Int  li_FileNo, li_FileNum, l_n_chk_loops, l_n_mod, l_n_int
long ll_pic = 1, ll_length

String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno

ls_AreaCode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_StandardRevno")

selectblob drawingname 
		into :lb_gyoid_pic 
   	from TQQcStandard
	  where areacode 		= :ls_areacode
		 and divisioncode	= :ls_divisioncode
		 and suppliercode	= :ls_suppliercode
		 and itemcode		= :ls_itemcode
		 and standardrevno= :ls_standardrevno
	  using sqlpis;

IF SQLPIS.SQLCode <> 0 THEN
	RETURN 	
END IF

ll_length = Len(lb_gyoid_pic)

IF ll_length = 0 OR IsNull(ll_length) THEN
	RETURN 	
END IF

ll_pic =1
//임시파일을 열어서 작업을 준비
//
//li_FileNo = FileOpen("C:\kdac_ipis\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)
li_FileNo = FileOpen("c:\kdac\bmp\temp.jpg", StreamMode!, Write!, Shared!, Replace!)


l_n_chk_loops = ll_length / 32765
l_n_mod   = mod(ll_length, 32765)
if l_n_chk_loops > 0 then
	for l_n_int = 1 to l_n_chk_loops
		lb_pic = blobmid( lb_gyoid_pic, ((l_n_int - 1) * 32765) + 1, 32765)
		filewrite(li_fileno, lb_pic) 
	next
	if l_n_mod > 0 then
		lb_pic = blobmid( lb_gyoid_pic, l_n_chk_loops * 32765 + 1, l_n_mod)
		filewrite(li_fileno, lb_pic) 
	end if
else
	if l_n_mod > 0 then
		lb_pic = blobmid(lb_gyoid_pic, 1, l_n_mod)
		filewrite(li_fileno, lb_pic)
	end if
end if

//IF li_FileNo > 0 Then 
//	DO   
//	  lb_pic=blobmid(lb_gyoid_pic, ll_pic, 32765)
//	  FileWrite(li_FileNo, lb_pic) 
//	  ll_pic = ll_pic + 32765 
//	LOOP UNTIL long(lb_pic) = 0 
//End IF 
FileClose(li_FileNo)

end subroutine

on w_pisq040i.create
int iCurrent
call super::create
this.dw_pisq040i=create dw_pisq040i
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
this.p_image=create p_image
this.cb_fullimage=create cb_fullimage
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq040i
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
this.Control[iCurrent+22]=this.p_image
this.Control[iCurrent+23]=this.cb_fullimage
end on

on w_pisq040i.destroy
call super::destroy
destroy(this.dw_pisq040i)
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
destroy(this.p_image)
destroy(this.cb_fullimage)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq040i, FULL)

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
dw_pisq040i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate_fm, ls_enactmentdate_to, ls_SupplierCode, ls_itemcode, ls_chkflag)

// 데이타윈도우의 첫번째 포커스행에 반전표시를 나타낸다
//
f_SetHighlight(dw_pisq040i, 1, True)	




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
dw_pisq040i.SetTransObject(SQLPIS)

uo_date.st_name.Text	= '승인일:'

end event

event activate;call super::activate;
// 트랜잭션을 연결한다
//
dw_pisq040i.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq040i
integer x = 18
integer width = 3598
end type

type dw_pisq040i from u_vi_std_datawindow within w_pisq040i
integer x = 18
integer y = 292
integer width = 3589
integer height = 1596
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq040i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	cb_print.TriggerEvent(Clicked!)
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno

// 필요한 정보를 구한다
//
ls_AreaCode					= dw_pisq040i.GetItemString(currentrow, "as_AreaCode")
ls_DivisionCode			= dw_pisq040i.GetItemString(currentrow, "as_DivisionCode")
ls_SupplierCode			= dw_pisq040i.GetItemString(currentrow, "as_SupplierCode")
ls_ItemCode					= dw_pisq040i.GetItemString(currentrow, "as_ItemCode")
ls_StandardRevno			= dw_pisq040i.GetItemString(currentrow, "as_StandardRevno")

// 약도유무를 판정하여 버튼을 처리한다
//
IF f_checkimage(ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno) THEN
	cb_fullimage.Enabled	= TRUE
	cb_image.Enabled		= TRUE
	cb_imageend.Enabled	= TRUE
ELSE
	cb_fullimage.Enabled	= FALSE
	cb_image.Enabled		= FALSE
	cb_imageend.Enabled	= FALSE
END IF
end event

type uo_area from u_pisc_select_area within w_pisq040i
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
dw_pisq040i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq040i
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
dw_pisq040i.SetTransObject(SQLPIS)


end event

type st_3 from statictext within w_pisq040i
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

type sle_suppliercode from singlelineedit within w_pisq040i
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

type sle_suppliername from singlelineedit within w_pisq040i
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

type st_4 from statictext within w_pisq040i
boolean visible = false
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

type cb_print from commandbutton within w_pisq040i
integer x = 4146
integer y = 48
integer width = 453
integer height = 96
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기준서 출력"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno
String	ls_SanctionCode, ls_ChargeConsertFlag, ls_SanctionConsertFlag

// 출력대상이 없으면 처리를 하지 않는다
//
IF dw_pisq040i.GetSelectedRow(0) = 0 THEN
	MessageBox('확 인', '출력대상이 없습니다', StopSign!)
	RETURN
END IF

// 기준서출력에 필요한 정보를 구한다
//
ls_AreaCode					= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode					= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), "as_StandardRevno")

// 인스턴스 스트럭쳐에 값을 저장한다
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_ItemCode
istr_parms.String_arg[5] = ls_StandardRevno

// 검사기준서 검토화면 오픈
//
OpenWithParm(w_pisq040p, istr_parms)

end event

type uo_date from u_pisc_date_applydate within w_pisq040i
event destroy ( )
boolean visible = false
integer x = 2862
integer y = 60
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_dateto from u_pisc_date_applydate_1 within w_pisq040i
event destroy ( )
boolean visible = false
integer x = 3575
integer y = 60
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

type rb_consert from radiobutton within w_pisq040i
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
end type

type rb_return from radiobutton within w_pisq040i
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
string text = "반송"
end type

type rb_all from radiobutton within w_pisq040i
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
string text = "전체"
boolean checked = true
end type

type pb_serch from picturebutton within w_pisq040i
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
string disabledname = "C:\kdac\bmp\not_search.gif"
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

type st_5 from statictext within w_pisq040i
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

type sle_itemcode from singlelineedit within w_pisq040i
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

type sle_itemname from singlelineedit within w_pisq040i
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

type pb_serch2 from picturebutton within w_pisq040i
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
string disabledname = "C:\kdac\bmp\not_search.gif"
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

type cb_image from commandbutton within w_pisq040i
integer x = 3675
integer y = 156
integer width = 453
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "도면보기"
end type

event clicked;
String	ls_areacode, ls_divisioncode, ls_suppliercode, ls_itemcode, ls_standardrevno

ls_areacode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_areacode')
ls_divisioncode	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_divisioncode')
ls_suppliercode	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_suppliercode')
ls_itemcode			= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_itemcode')
ls_standardrevno	= dw_pisq040i.GetItemString(dw_pisq040i.GetSelectedRow(0), 'as_standardrevno')

blob lb_pic

SetPointer(HourGlass!)

p_image.Visible	= True
//p_image.x			= 59
//p_image.y			= 332
//p_image.Width		= 3557
//p_image.Height		= 1844

selectblob drawingname 
		into :lb_pic 
   	from TQQcStandard
	  where areacode 		= :ls_areacode
		 and divisioncode	= :ls_divisioncode
		 and suppliercode	= :ls_suppliercode
		 and itemcode		= :ls_itemcode
		 and standardrevno= :ls_standardrevno
	 using sqlpis;

p_image.Setpicture(lb_pic)

SetPointer(Arrow!)

end event

type cb_imageend from commandbutton within w_pisq040i
integer x = 4146
integer y = 156
integer width = 453
integer height = 96
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "도면닫기"
end type

event clicked;
p_image.Visible	= FALSE

end event

type gb_1 from groupbox within w_pisq040i
integer x = 18
integer y = 12
integer width = 4613
integer height = 264
integer taborder = 110
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
end type

type p_image from picture within w_pisq040i
boolean visible = false
integer x = 27
integer y = 300
integer width = 4594
integer height = 2280
boolean border = true
boolean focusrectangle = false
end type

event clicked;
p_image.Visible = FALSE

end event

type cb_fullimage from commandbutton within w_pisq040i
integer x = 3154
integer y = 156
integer width = 503
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "전체도면보기"
end type

event clicked;integer li_rtn
// 해당 이미지를 불러온다
//
wf_imagechange()

li_rtn = Run("explorer c:\kdac\bmp\temp.jpg", Maximized!)

return 0


end event

