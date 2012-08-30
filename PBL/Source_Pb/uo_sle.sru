$PBExportHeader$uo_sle.sru
$PBExportComments$SingleLineEdit
forward
global type uo_sle from singlelineedit
end type
end forward

global type uo_sle from singlelineedit
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
event ue_keydown pbm_keydown
event ue_doubleclick pbm_lbuttondblclk
event ue_enchange pbm_enchange
end type
global uo_sle uo_sle

type variables
string	is_toggle		//한영전환
boolean	ib_toggle	= true	//한영전환 여부
end variables

event getfocus;this.backcolor = rgb(200,255,200)
selecttext(1,len(text))

//사용자 설정에 따라 한영자동 변환 여부 결정
//If ib_toggle = false Then return
//	
////설정에 따라 한영변환
//Choose Case Upper(is_toggle)
//	Case 'K'
//		f_toggle_kor(handle(this))
//	Case 'E'
//		f_toggle_eng(handle(this))
//End Choose

end event

event constructor;string ls_toggle_env

//사용자설정이 Toggle = No 인경우 return
//ls_toggle_env = ProfileString(gs_ini, "USER", "TOGGLE", " ")
//If Upper(ls_toggle_env) = 'NO' Then
//	ib_toggle = false
//End if

end event

event losefocus;this.backcolor = rgb(255,255,255)

end event

on uo_sle.create
end on

on uo_sle.destroy
end on

