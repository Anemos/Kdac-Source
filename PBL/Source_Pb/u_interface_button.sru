$PBExportHeader$u_interface_button.sru
$PBExportComments$Interface Button
forward
global type u_interface_button from userobject
end type
type cb_exit from commandbutton within u_interface_button
end type
type cb_stop from commandbutton within u_interface_button
end type
type cb_start from commandbutton within u_interface_button
end type
end forward

global type u_interface_button from userobject
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
global u_interface_button u_interface_button

forward prototypes
public subroutine uf_button_enable (boolean fb_start, boolean fb_stop, boolean fb_exit)
end prototypes

public subroutine uf_button_enable (boolean fb_start, boolean fb_stop, boolean fb_exit);cb_start.Enabled	= fb_start
cb_stop.Enabled	= fb_stop
cb_exit.Enabled	= fb_exit
cb_exit.Cancel		= fb_exit
end subroutine

on u_interface_button.create
this.cb_exit=create cb_exit
this.cb_stop=create cb_stop
this.cb_start=create cb_start
this.Control[]={this.cb_exit,&
this.cb_stop,&
this.cb_start}
end on

on u_interface_button.destroy
destroy(this.cb_exit)
destroy(this.cb_stop)
destroy(this.cb_start)
end on

type cb_exit from commandbutton within u_interface_button
integer x = 1106
integer width = 549
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "프로그램 종료 (&X)"
boolean cancel = true
end type

event clicked;Parent.Post Event ue_exit()
end event

type cb_stop from commandbutton within u_interface_button
integer x = 558
integer width = 549
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
boolean enabled = false
string text = "WorkJob 종료 (&E)"
end type

event clicked;Parent.Post Event ue_click_stop()
end event

type cb_start from commandbutton within u_interface_button
integer width = 558
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "WorkJob 시작 (&R)"
end type

event clicked;Parent.Post Event ue_click_start()
end event

