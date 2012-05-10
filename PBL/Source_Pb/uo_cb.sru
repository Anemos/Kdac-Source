$PBExportHeader$uo_cb.sru
$PBExportComments$Focus¸¦ °¡Áú ¶§ Default·Î ¹Ù²ñ.
forward
global type uo_cb from commandbutton
end type
end forward

global type uo_cb from commandbutton
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
end type
global uo_cb uo_cb

event getfocus;this.weight = 700
this.default = true

end event

event losefocus;this.weight = 400
this.default = false

end event

on uo_cb.create
end on

on uo_cb.destroy
end on

