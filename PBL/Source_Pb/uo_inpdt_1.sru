$PBExportHeader$uo_inpdt_1.sru
$PBExportComments$¿œ¿⁄(editmask)
forward
global type uo_inpdt_1 from userobject
end type
type em_2 from editmask within uo_inpdt_1
end type
type em_1 from editmask within uo_inpdt_1
end type
type st_1 from statictext within uo_inpdt_1
end type
end forward

global type uo_inpdt_1 from userobject
integer width = 987
integer height = 128
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
em_2 em_2
em_1 em_1
st_1 st_1
end type
global uo_inpdt_1 uo_inpdt_1

on uo_inpdt_1.create
this.em_2=create em_2
this.em_1=create em_1
this.st_1=create st_1
this.Control[]={this.em_2,&
this.em_1,&
this.st_1}
end on

on uo_inpdt_1.destroy
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_1)
end on

type em_2 from editmask within uo_inpdt_1
integer x = 567
integer y = 16
integer width = 402
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±º∏≤√º"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

type em_1 from editmask within uo_inpdt_1
integer x = 23
integer y = 16
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±º∏≤√º"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####/##/##"
boolean autoskip = true
end type

type st_1 from statictext within uo_inpdt_1
integer x = 453
integer y = 20
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
alignment alignment = center!
boolean focusrectangle = false
end type

