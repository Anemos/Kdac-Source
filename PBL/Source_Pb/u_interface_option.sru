$PBExportHeader$u_interface_option.sru
$PBExportComments$Interface Option(¼öµ¿, ÀÚµ¿)
forward
global type u_interface_option from userobject
end type
type rb_auto from radiobutton within u_interface_option
end type
type st_1 from statictext within u_interface_option
end type
type rb_manual from radiobutton within u_interface_option
end type
type gb_option from groupbox within u_interface_option
end type
end forward

global type u_interface_option from userobject
integer width = 1285
integer height = 132
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_button_click ( boolean ab_auto )
event resize ( unsignedlong sizetype,  integer newwidth,  integer newheight )
rb_auto rb_auto
st_1 st_1
rb_manual rb_manual
gb_option gb_option
end type
global u_interface_option u_interface_option

type variables
boolean ub_auto = False
end variables

event resize;gb_option.Width = newwidth - 20
end event

on u_interface_option.create
this.rb_auto=create rb_auto
this.st_1=create st_1
this.rb_manual=create rb_manual
this.gb_option=create gb_option
this.Control[]={this.rb_auto,&
this.st_1,&
this.rb_manual,&
this.gb_option}
end on

on u_interface_option.destroy
destroy(this.rb_auto)
destroy(this.st_1)
destroy(this.rb_manual)
destroy(this.gb_option)
end on

type rb_auto from radiobutton within u_interface_option
integer x = 960
integer y = 28
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long backcolor = 67108864
string text = "ÀÚ µ¿"
end type

event clicked;If Not ub_auto Then
	ub_auto = True
	TextColor	= 255
	rb_manual.TextColor = 0
	Parent.Event Trigger ue_button_click(ub_auto)
End If

end event

type st_1 from statictext within u_interface_option
integer x = 23
integer y = 32
integer width = 599
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 8388736
long backcolor = 67108864
boolean enabled = false
string text = "WorkJob Option :"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_manual from radiobutton within u_interface_option
integer x = 663
integer y = 28
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 255
long backcolor = 67108864
string text = "¼ö µ¿"
boolean checked = true
end type

event clicked;If ub_auto Then
	ub_auto = False
	TextColor	= 255
	rb_auto.TextColor = 0
	Parent.Event Trigger ue_button_click(ub_auto)
End If

end event

type gb_option from groupbox within u_interface_option
integer width = 1266
integer height = 120
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 67108864
end type

