$PBExportHeader$u_pisc_select_custitem_kdac.sru
$PBExportComments$제품 선택(모델군에 속한) - is_uo_itemcode, is_uo_itemname
forward
global type u_pisc_select_custitem_kdac from userobject
end type
type pb_1 from picturebutton within u_pisc_select_custitem_kdac
end type
type sle_2 from singlelineedit within u_pisc_select_custitem_kdac
end type
type sle_1 from singlelineedit within u_pisc_select_custitem_kdac
end type
type st_1 from statictext within u_pisc_select_custitem_kdac
end type
end forward

global type u_pisc_select_custitem_kdac from userobject
integer width = 1504
integer height = 116
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_select ( )
event ue_post_constructor ( )
event ue_keydown pbm_keydown
pb_1 pb_1
sle_2 sle_2
sle_1 sle_1
st_1 st_1
end type
global u_pisc_select_custitem_kdac u_pisc_select_custitem_kdac

type variables
string	is_uo_itemcode, is_uo_itemname
boolean	ib_allflag
end variables

on u_pisc_select_custitem_kdac.create
this.pb_1=create pb_1
this.sle_2=create sle_2
this.sle_1=create sle_1
this.st_1=create st_1
this.Control[]={this.pb_1,&
this.sle_2,&
this.sle_1,&
this.st_1}
end on

on u_pisc_select_custitem_kdac.destroy
destroy(this.pb_1)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.st_1)
end on

event constructor;is_uo_itemcode = '%'
this.PostEvent("ue_select")
end event

type pb_1 from picturebutton within u_pisc_select_custitem_kdac
integer x = 1262
integer width = 238
integer height = 108
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm = ''

openwithparm(w_ipis_find_custitem,l_s_parm)

l_s_parm = message.stringparm
sle_1.text = trim(mid(l_s_parm,1,15))
sle_2.text = trim(mid(l_s_parm,16,50))
is_uo_itemcode = sle_1.text  
is_uo_itemname = sle_2.text
sle_1.setfocus()
end event

type sle_2 from singlelineedit within u_pisc_select_custitem_kdac
integer x = 805
integer y = 20
integer width = 448
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within u_pisc_select_custitem_kdac
event ue_keydown pbm_keydown
event ue_gettext pbm_gettext
event ue_enchange pbm_enchange
integer x = 366
integer y = 20
integer width = 421
integer height = 68
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if key = keyenter!	then
	window ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event ue_enchange;//String ls_itemcode,ls_itemname
//
//ls_itemcode = trim(sle_1.text)
//
//Select A.ItemName into :ls_itemname
//	From	vmstmodel	A
//Where	A.Itemcode = :ls_itemcode using sqlpis ;
//
//If is_uo_itemcode <> ls_itemcode Then
//	If f_spacechk(ls_itemcode) = -1 Then
//		is_uo_itemcode = '%'
//		is_uo_itemname = ''
//	Else
//		is_uo_itemcode = ls_itemcode
//		is_uo_itemname = ls_itemname
//	End If
//	sle_2.text = is_uo_itemname
//	Parent.PostEvent("ue_select")
//End If
end event

type st_1 from statictext within u_pisc_select_custitem_kdac
integer y = 28
integer width = 366
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "거래처품번:"
alignment alignment = right!
boolean focusrectangle = false
end type

