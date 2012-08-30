$PBExportHeader$u_st_horizontal.sru
$PBExportComments$Horizontal Var
forward
global type u_st_horizontal from statictext
end type
end forward

global type u_st_horizontal from statictext
integer width = 105
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string pointer = "Ho_split.cur"
long backcolor = 0
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
event ue_mousedown pbm_lbuttondown
event ue_mouseup pbm_lbuttonup
event ue_mousemove pbm_mousemove
end type
global u_st_horizontal u_st_horizontal

event ue_mousedown;//When mouse clicked, show Bar in Black
BackColor = 0

setposition(ToTop!)
end event

event ue_mouseup;setposition(ToBottom!)
end event

on u_st_horizontal.create
end on

on u_st_horizontal.destroy
end on

