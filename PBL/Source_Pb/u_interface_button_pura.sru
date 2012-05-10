$PBExportHeader$u_interface_button_pura.sru
$PBExportComments$Interface Button
forward
global type u_interface_button_pura from userobject
end type
type cb_exit from commandbutton within u_interface_button_pura
end type
type cb_stop from commandbutton within u_interface_button_pura
end type
type cb_start from commandbutton within u_interface_button_pura
end type
end forward

global type u_interface_button_pura from userobject
integer width = 1669
integer height = 120
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_click_start ( )
event ue_click_stop ( )
event ue_exit ( )
cb_exit cb_exit
cb_stop cb_stop
cb_start cb_start
end type
global u_interface_button_pura u_interface_button_pura

forward prototypes
public subroutine uf_button_enable (boolean fb_start, boolean fb_stop, boolean fb_exit)
end prototypes

public subroutine uf_button_enable (boolean fb_start, boolean fb_stop, boolean fb_exit);cb_start.Enabled	= fb_start
cb_stop.Enabled	= fb_stop
cb_exit.Enabled	= fb_exit
cb_exit.Cancel		= fb_exit
end subroutine

on u_interface_button_pura.create
this.cb_exit=create cb_exit
this.cb_stop=create cb_stop
this.cb_start=create cb_start
this.Control[]={this.cb_exit,&
this.cb_stop,&
this.cb_start}
end on

on u_interface_button_pura.destroy
destroy(this.cb_exit)
destroy(this.cb_stop)
destroy(this.cb_start)
end on

type cb_exit from commandbutton within u_interface_button_pura
integer x = 1106
integer width = 549
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
string text = "���α׷� ���� (&X)"
boolean cancel = true
end type

event clicked;Parent.Post Event ue_exit()
end event

type cb_stop from commandbutton within u_interface_button_pura
integer x = 553
integer width = 549
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
boolean enabled = false
string text = "Interface ���� (&E)"
end type

event clicked;Parent.Post Event ue_click_stop()
end event

type cb_start from commandbutton within u_interface_button_pura
integer width = 549
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
string text = "Interface ���� (&R)"
end type

event clicked;Parent.Post Event ue_click_start()
end event

