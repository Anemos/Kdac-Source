$PBExportHeader$w_connect.srw
$PBExportComments$DB CONNECTÁß...
forward
global type w_connect from window
end type
type st_2 from statictext within w_connect
end type
type st_4 from statictext within w_connect
end type
type st_1 from statictext within w_connect
end type
end forward

global type w_connect from window
integer x = 997
integer y = 664
integer width = 1541
integer height = 292
boolean border = false
windowtype windowtype = popup!
long backcolor = 80269524
st_2 st_2
st_4 st_4
st_1 st_1
end type
global w_connect w_connect

on w_connect.create
this.st_2=create st_2
this.st_4=create st_4
this.st_1=create st_1
this.Control[]={this.st_2,&
this.st_4,&
this.st_1}
end on

on w_connect.destroy
destroy(this.st_2)
destroy(this.st_4)
destroy(this.st_1)
end on

event open;f_centerwindow(THIS)

end event

type st_2 from statictext within w_connect
integer x = 18
integer y = 176
integer width = 1490
integer height = 12
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long backcolor = 8421504
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_connect
integer x = 823
integer y = 216
integer width = 667
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long backcolor = 80269524
boolean enabled = false
string text = "Version 1.00 since 2002"
alignment alignment = right!
boolean focusrectangle = false
end type

event clicked;close(parent)
end event

type st_1 from statictext within w_connect
integer x = 55
integer y = 48
integer width = 1426
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 80269524
boolean enabled = false
string text = "CONNECTING SYSTEM"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;MessageBox("ÇÏÇÏÇÏ", "³»°¡ ¸¸µé¾úÁö·Õ...")
end event

