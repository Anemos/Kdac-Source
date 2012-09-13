$PBExportHeader$uo_abc.sru
$PBExportComments$ABC µî±Þ UserObject
forward
global type uo_abc from userobject
end type
type ddlb_1 from dropdownlistbox within uo_abc
end type
type st_1 from statictext within uo_abc
end type
end forward

global type uo_abc from userobject
integer width = 841
integer height = 116
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
ddlb_1 ddlb_1
st_1 st_1
end type
global uo_abc uo_abc

on uo_abc.create
this.ddlb_1=create ddlb_1
this.st_1=create st_1
this.Control[]={this.ddlb_1,&
this.st_1}
end on

on uo_abc.destroy
destroy(this.ddlb_1)
destroy(this.st_1)
end on

type ddlb_1 from dropdownlistbox within uo_abc
integer x = 288
integer y = 8
integer width = 549
integer height = 324
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
string item[] = {"A","B","C","D","S"}
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within uo_abc
integer x = 18
integer y = 28
integer width = 256
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 67108864
string text = "ABC µî±Þ"
boolean focusrectangle = false
end type

