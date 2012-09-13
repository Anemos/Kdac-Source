$PBExportHeader$uo_inpdt.sru
$PBExportComments$¿œ¿⁄
forward
global type uo_inpdt from userobject
end type
type sle_2 from singlelineedit within uo_inpdt
end type
type st_1 from statictext within uo_inpdt
end type
type sle_1 from singlelineedit within uo_inpdt
end type
end forward

global type uo_inpdt from userobject
integer width = 1193
integer height = 128
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
sle_2 sle_2
st_1 st_1
sle_1 sle_1
end type
global uo_inpdt uo_inpdt

on uo_inpdt.create
this.sle_2=create sle_2
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.sle_2,&
this.st_1,&
this.sle_1}
end on

on uo_inpdt.destroy
destroy(this.sle_2)
destroy(this.st_1)
destroy(this.sle_1)
end on

type sle_2 from singlelineedit within uo_inpdt
integer x = 658
integer y = 12
integer width = 457
integer height = 96
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within uo_inpdt
integer x = 539
integer y = 12
integer width = 91
integer height = 72
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within uo_inpdt
integer x = 46
integer y = 12
integer width = 457
integer height = 96
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

