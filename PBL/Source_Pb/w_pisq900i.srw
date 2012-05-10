$PBExportHeader$w_pisq900i.srw
$PBExportComments$°Ë»ç±âÁØ¼­ °ü¸®È­¸é(¿î¿µÀÚ¿ë)
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
string title = "°Ë»ç±âÁØ¼­ °ü¸®È­¸é(¿î¿µÀÚ¿ë)"
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

// Á¶È¸¿¡ ÇÊ¿äÇÑ Á¤º¸¸¦ ±¸ÇÑ´Ù
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

// ÀÏÀÚ¸¦ ÀÔ·ÂÇÏÁö ¾ÊÀ¸¸é ÃÖ¼ÒÀÏÀÚ¸¦ ¼ÂÆ®ÇÑ´Ù
//
IF f_checknullorspace(ls_enactmentdate_fm) = TRUE THEN
	ls_enactmentdate_fm	= '0000.00.00'
END IF

// ÀÏÀÚ¸¦ ÀÔ·ÂÇÏÁö ¾ÊÀ¸¸é ÃÖ´ëÀÏÀÚ¸¦ ¼ÂÆ®ÇÑ´Ù
//
IF f_checknullorspace(ls_enactmentdate_to) = TRUE THEN
	ls_enactmentdate_to	= '9999.12.31'
END IF

// µ¥ÀÌÅ¸¸¦ Á¶È¸ÇÑ´Ù
//
dw_pisq900i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_enactmentdate_fm, ls_enactmentdate_to, ls_SupplierCode, ls_itemcode, ls_chkflag)

// µ¥ÀÌÅ¸À©µµ¿ìÀÇ Ã¹¹øÂ° Æ÷Ä¿½ºÇà¿¡ ¹ÝÀüÇ¥½Ã¸¦ ³ªÅ¸³½´Ù
//
f_SetHighlight(dw_pisq900i, 1, True)	




end event

event open;call super::open;
////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : Á¶È¸,     ag_02 : ÀÔ·Â,     ag_03 : ÀúÀå,     ag_04 : »èÁ¦,     ag_05 : ÀÎ¼â
// ag_06 : Ã³À½,     ag_07 : ÀÌÀü,     ag_08 : ´ÙÀ½,     ag_09 : ³¡,       ag_10 : ¹Ì¸®º¸±â
// ag_11 : ´ë»óÁ¶È¸, ag_12 : ÀÚ·á»ý¼º, ag_13 : »ó¼¼Á¶È¸, ag_14 : È­¸éÀÎ¼â, ag_15 : Æ¯¼ö¹®ÀÚ 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// Åø¹ÙÀÇ ¾ÆÀÌÄÜÀ» Àç¼³Á¤ÇÑ´Ù
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
// Æ®·£Àè¼ÇÀ» ¿¬°áÇÑ´Ù
//
dw_pisq900i.SetTransObject(SQLPIS)

uo_date.st_name.Text	= '½ÂÀÎÀÏ:'

end event

event activate;call super::activate;
// Æ®·£Àè¼ÇÀ» ¿¬°áÇÑ´Ù
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
//	Arguments	:	DataWindow		fdw_1						Á¶È¸ÇÏ°íÀÚ ÇÏ´Â DDDW Object
//						string			fs_empno					Á¶È¸ÇÏ°íÀÚ ÇÏ´Â »ç¹ø (Áö¿ªº°/°øÀåº° ±ÇÇÑ¿¡ µû¸¥ Á¶È¸¸¦ À§ÇÏ¿©)
//						string			fs_areacode				Á¶È¸ÇÏ°íÀÚ ÇÏ´Â Áö¿ª
//						string			fs_divisioncode		Á¶È¸ÇÏ°íÀÚ ÇÏ´Â °øÀå ÄÚµå (ÀÏ¹ÝÀûÀ¸·Î '%' À» »ç¿ëÇÏµµ·Ï)
//						boolean			fb_allflag				Á¶È¸µÈ °øÀå Á¤º¸°¡ 2°³ ÀÌ»óÀÇ Record ÀÏ °æ¿ì
//																		True : 'ÀüÃ¼' Ç×¸ñ »ðÀÔ (°øÀåÄÚµå´Â '%', °øÀå¸íÀº 'ÀüÃ¼')
//																		False : 'ÀüÃ¼' Ç×¸ñ ¹Ì »ðÀÔ
//						string			rs_divisioncode		¼±ÅÃµÈ °øÀå ÄÚµå (reference)
//						string			rs_divisionname		¼±ÅÃµÈ °øÀå ¸í (reference)
//						string			rs_divisionnameeng	¼±ÅÃµÈ °øÀå ¿µ¹® ¸í (reference)
//	Returns		: none
//	Description	: °øÀåÀ» ¼±ÅÃÇÏ±â À§ÇÑ DDDW À» Á¶È¸ÇÏ±â À§ÇÏ¿©
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

// Æ®·£Àè¼ÇÀ» ¿¬°áÇÑ´Ù
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
// Æ®·£Àè¼ÇÀ» ¿¬°áÇÑ´Ù
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
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
string text = "Çù·Â¾÷Ã¼:"
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
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event modified;
// ¾÷Ã¼¸íÀ» ±¸ÇÑ´Ù
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
string facename = "±¼¸²Ã¼"
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
string facename = "±¼¸²Ã¼"
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
string facename = "±¼¸²Ã¼"
string text = "±âÁØ¼­ »èÁ¦"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno

// ÀÛ¾÷´ë»óÀÌ ¾øÀ¸¸é Ã³¸®¸¦ ÇÏÁö ¾Ê´Â´Ù
//
IF dw_pisq900i.GetSelectedRow(0) = 0 THEN
	MessageBox('È® ÀÎ', 'ÀÛ¾÷´ë»óÀÌ ¾ø½À´Ï´Ù', StopSign!)
	RETURN
END IF

IF MessageBox("È® ÀÎ", '±âÁØ¼­¸¦ »èÁ¦ÇÏ½Ã°Ú½À´Ï±î‘,', Exclamation!, OKCancel!, 2) = 2 THEN
	RETURN
END IF

// ±âÁØ¼­»èÁ¦¿¡ ÇÊ¿äÇÑ Á¤º¸¸¦ ±¸ÇÑ´Ù
//
ls_AreaCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_StandardRevno")

dw_pisq900i.DeleteRow(dw_pisq900i.GetSelectedRow(0))

// AUTO COMMITÀ» FASLE·Î ÁöÁ¤
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
	MessageBox('È® ÀÎ', '±âÁØ¼­ »èÁ¦Ã³¸®¿¡ ½ÇÆÐÇß½À´Ï´Ù.')
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
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
string text = "½ÂÀÎ"
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
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "¹Ý¼Û"
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
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "ÀüÃ¼"
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
string facename = "±¼¸²Ã¼"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag		= 2			//¿ÜÁÖ¾÷Ã¼(Áö¿ª,°øÀå)
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
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
string text = "Ç°¹ø:"
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
string facename = "±¼¸²Ã¼"
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
string facename = "±¼¸²Ã¼"
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
string facename = "±¼¸²Ã¼"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag = 2			// ÀüÃ¼Ç°¹ø
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
string facename = "±¼¸²Ã¼"
string text = "½ÂÀÎÀÇ·Ú"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno

// ÀÛ¾÷´ë»óÀÌ ¾øÀ¸¸é Ã³¸®¸¦ ÇÏÁö ¾Ê´Â´Ù
//
IF dw_pisq900i.GetSelectedRow(0) = 0 THEN
	MessageBox('È® ÀÎ', 'ÀÛ¾÷´ë»óÀÌ ¾ø½À´Ï´Ù', StopSign!)
	RETURN
END IF

// ±âÁØ¼­¼öÁ¤¿¡ ÇÊ¿äÇÑ Á¤º¸¸¦ ±¸ÇÑ´Ù
//
ls_AreaCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_StandardRevno")

// AUTO COMMITÀ» FASLE·Î ÁöÁ¤
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
	MessageBox('È® ÀÎ', '½ÂÀÎÀÇ·Ú º¯°æ¿¡ ½ÇÆÐÇß½À´Ï´Ù.')
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
string facename = "±¼¸²Ã¼"
boolean enabled = false
string text = "´ç´çÀÚ¹Ý¼Û"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno

// ÀÛ¾÷´ë»óÀÌ ¾øÀ¸¸é Ã³¸®¸¦ ÇÏÁö ¾Ê´Â´Ù
//
IF dw_pisq900i.GetSelectedRow(0) = 0 THEN
	MessageBox('È® ÀÎ', 'ÀÛ¾÷´ë»óÀÌ ¾ø½À´Ï´Ù', StopSign!)
	RETURN
END IF

// ±âÁØ¼­¼öÁ¤¿¡ ÇÊ¿äÇÑ Á¤º¸¸¦ ±¸ÇÑ´Ù
//
ls_AreaCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_StandardRevno")

// AUTO COMMITÀ» FASLE·Î ÁöÁ¤
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
	MessageBox('È® ÀÎ', '´ã´çÀÚ¹Ý¼Û º¯°æ¿¡ ½ÇÆÐÇß½À´Ï´Ù.')
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
string facename = "±¼¸²Ã¼"
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
string facename = "±¼¸²Ã¼"
string text = "ÀÓ½ÃÀúÀå"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_StandardRevno

// ÀÛ¾÷´ë»óÀÌ ¾øÀ¸¸é Ã³¸®¸¦ ÇÏÁö ¾Ê´Â´Ù
//
IF dw_pisq900i.GetSelectedRow(0) = 0 THEN
	MessageBox('È® ÀÎ', 'ÀÛ¾÷´ë»óÀÌ ¾ø½À´Ï´Ù', StopSign!)
	RETURN
END IF

// ±âÁØ¼­¼öÁ¤¿¡ ÇÊ¿äÇÑ Á¤º¸¸¦ ±¸ÇÑ´Ù
//
ls_AreaCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_AreaCode")
ls_DivisionCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_DivisionCode")
ls_SupplierCode	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_SupplierCode")
ls_ItemCode			= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_ItemCode")
ls_StandardRevno	= dw_pisq900i.GetItemString(dw_pisq900i.GetSelectedRow(0), "as_StandardRevno")

// AUTO COMMITÀ» FASLE·Î ÁöÁ¤
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
	MessageBox('È® ÀÎ', 'ÀÓ½ÃÀúÀå º¯°æ¿¡ ½ÇÆÐÇß½À´Ï´Ù.')
END IF

SQLPIS.AUTOCommit = TRUE

end event

