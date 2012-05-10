$PBExportHeader$uo_em_mon.sru
$PBExportComments$년월입력EditMask
forward
global type uo_em_mon from editmask
end type
end forward

global type uo_em_mon from editmask
integer width = 329
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
string mask = "yyyy/mm"
boolean spin = true
event ue_keydown pbm_keydown
event ue_doubleclick pbm_lbuttondblclk
event ue_enchange pbm_enchange
end type
global uo_em_mon uo_em_mon

event ue_keydown;string ls_date

If key = keyenter! Then
	ls_date = mid(this.text,1,4) + mid(this.text,6,2) + '01'
	If f_date_check(ls_date) = 0 Then
		messagebox("확인","올바른 날짜가 아닙니다.")
	End if
End if
end event

event constructor;this.text = string(f_cmms_sysdate(),"yyyy/mm")
end event

event getfocus;this.backcolor = rgb(200,255,200)
this.selecttext(6,2)
//this.selecttext(1,len(text))

end event

event losefocus;this.backcolor = rgb(255,255,255)

end event

on uo_em_mon.create
end on

on uo_em_mon.destroy
end on

