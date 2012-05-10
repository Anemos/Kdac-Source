$PBExportHeader$uo_em_day.sru
$PBExportComments$��¥�Է�EditMask
forward
global type uo_em_day from editmask
end type
end forward

global type uo_em_day from editmask
integer width = 421
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy/mm/dd"
boolean spin = true
event ue_keydown pbm_keydown
event ue_doubleclick pbm_lbuttondblclk
event ue_enchange pbm_enchange
end type
global uo_em_day uo_em_day

event ue_keydown;string ls_date

If key = keyenter! Then
	ls_date = mid(this.text,1,4) + mid(this.text,6,2) + mid(this.text,9,2)
	If f_date_check(ls_date) = 0 Then
		messagebox("Ȯ��","�ùٸ� ��¥�� �ƴմϴ�.")
	End if
End if
end event

event ue_doubleclick;//this.text = f_calendar(this.text,1)
end event

event constructor;This.Text = String(f_cmms_sysdate(),"yyyy/mm/dd")
end event

event losefocus;this.backcolor = rgb(255,255,255)

end event

event getfocus;this.backcolor = rgb(200,255,200)
this.selecttext(9,2)
//this.selecttext(1,len(text))

end event

on uo_em_day.create
end on

on uo_em_day.destroy
end on

