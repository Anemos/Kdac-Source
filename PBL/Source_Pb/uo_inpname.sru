$PBExportHeader$uo_inpname.sru
$PBExportComments$���� input
forward
global type uo_inpname from userobject
end type
type st_1 from statictext within uo_inpname
end type
type sle_1 from singlelineedit within uo_inpname
end type
end forward

global type uo_inpname from userobject
integer width = 928
integer height = 120
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
sle_1 sle_1
end type
global uo_inpname uo_inpname

on uo_inpname.create
this.st_1=create st_1
this.sle_1=create sle_1
this.Control[]={this.st_1,&
this.sle_1}
end on

on uo_inpname.destroy
destroy(this.st_1)
destroy(this.sle_1)
end on

event getfocusobject;f_toggle_per( handle(This), 'KOR' ) // Ű���� �ѱ۷� ����...
return 0
end event

type st_1 from statictext within uo_inpname
integer x = 82
integer y = 28
integer width = 283
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "��    ��"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within uo_inpname
integer x = 366
integer y = 12
integer width = 521
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event getfocus;f_toggle_per( handle( Parent ), 'KOR' )
end event

event losefocus;f_toggle_per( handle( Parent ), 'ENG' )
end event

