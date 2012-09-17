$PBExportHeader$u_interface_error.sru
$PBExportComments$Interface status panel
forward
global type u_interface_error from userobject
end type
type cb_cancel from commandbutton within u_interface_error
end type
type cb_repair from commandbutton within u_interface_error
end type
type st_read from statictext within u_interface_error
end type
type st_written from statictext within u_interface_error
end type
type st_error from statictext within u_interface_error
end type
type st_time from statictext within u_interface_error
end type
type st_title from statictext within u_interface_error
end type
type gb_4 from groupbox within u_interface_error
end type
type gb_3 from groupbox within u_interface_error
end type
type gb_2 from groupbox within u_interface_error
end type
type gb_1 from groupbox within u_interface_error
end type
end forward

global type u_interface_error from userobject
integer width = 1975
integer height = 260
boolean border = true
long backcolor = 12632256
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_repair ( )
event ue_cancel ( )
cb_cancel cb_cancel
cb_repair cb_repair
st_read st_read
st_written st_written
st_error st_error
st_time st_time
st_title st_title
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global u_interface_error u_interface_error

type variables
Transaction it_source, it_destination
p_pipe_wmeter ip_pipe
int ii_id

end variables

on u_interface_error.create
this.cb_cancel=create cb_cancel
this.cb_repair=create cb_repair
this.st_read=create st_read
this.st_written=create st_written
this.st_error=create st_error
this.st_time=create st_time
this.st_title=create st_title
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_cancel,&
this.cb_repair,&
this.st_read,&
this.st_written,&
this.st_error,&
this.st_time,&
this.st_title,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on u_interface_error.destroy
destroy(this.cb_cancel)
destroy(this.cb_repair)
destroy(this.st_read)
destroy(this.st_written)
destroy(this.st_error)
destroy(this.st_time)
destroy(this.st_title)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_cancel from commandbutton within u_interface_error
integer x = 1701
integer y = 36
integer width = 247
integer height = 96
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
boolean enabled = false
string text = "Cancel"
end type

event clicked;Parent.Event Trigger ue_cancel()
end event

type cb_repair from commandbutton within u_interface_error
integer x = 1449
integer y = 36
integer width = 247
integer height = 96
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
boolean enabled = false
string text = "Repair"
end type

event clicked;Parent.Event Trigger ue_repair()
end event

type st_read from statictext within u_interface_error
integer x = 32
integer y = 68
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 41943040
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_written from statictext within u_interface_error
integer x = 370
integer y = 68
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 41943040
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_error from statictext within u_interface_error
integer x = 709
integer y = 68
integer width = 265
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_time from statictext within u_interface_error
integer x = 1038
integer y = 68
integer width = 379
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 41943040
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_title from statictext within u_interface_error
integer x = 5
integer y = 180
integer width = 594
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 32768
long backcolor = 12632256
boolean enabled = false
string text = "Work Job ¼öÇà³»¿ª :"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_4 from groupbox within u_interface_error
integer x = 1015
integer width = 421
integer height = 148
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 41943040
long backcolor = 12632256
string text = " Time "
end type

type gb_3 from groupbox within u_interface_error
integer x = 677
integer width = 329
integer height = 148
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 41943040
long backcolor = 12632256
string text = "Errors"
end type

type gb_2 from groupbox within u_interface_error
integer x = 338
integer width = 329
integer height = 148
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 41943040
long backcolor = 12632256
string text = " Written "
end type

type gb_1 from groupbox within u_interface_error
integer width = 329
integer height = 148
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 41943040
long backcolor = 12632256
string text = " Read "
end type

