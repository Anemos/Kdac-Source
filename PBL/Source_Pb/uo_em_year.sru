$PBExportHeader$uo_em_year.sru
$PBExportComments$년입력EditMask
forward
global type uo_em_year from editmask
end type
end forward

global type uo_em_year from editmask
integer width = 261
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean spin = true
event ue_keydown pbm_keydown
event ue_doubleclick pbm_lbuttondblclk
event ue_enchange pbm_enchange
end type
global uo_em_year uo_em_year

event ue_keydown;If key = keyenter! Then
	If This.Text < '1990' or This.text > '3000' Then	//프로그램 연도 허용한계
		messagebox("확인","올바른 연도가 아닙니다.")
	End if
End if
end event

event constructor;this.text = string(f_cmms_sysdate(),"yyyy")
end event

event getfocus;this.backcolor = rgb(200,255,200)
this.selecttext(1,len(text))

end event

event losefocus;this.backcolor = rgb(255,255,255)

end event

on uo_em_year.create
end on

on uo_em_year.destroy
end on

