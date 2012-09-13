$PBExportHeader$uo_inpempno_1.sru
$PBExportComments$사번성명입력(일용직)
forward
global type uo_inpempno_1 from userobject
end type
type st_2 from statictext within uo_inpempno_1
end type
type st_1 from statictext within uo_inpempno_1
end type
type sle_2 from singlelineedit within uo_inpempno_1
end type
type st_50 from statictext within uo_inpempno_1
end type
type rb_2 from radiobutton within uo_inpempno_1
end type
type sle_1 from singlelineedit within uo_inpempno_1
end type
type rb_1 from radiobutton within uo_inpempno_1
end type
type st_3 from statictext within uo_inpempno_1
end type
end forward

global type uo_inpempno_1 from userobject
integer width = 3429
integer height = 124
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_2 st_2
st_1 st_1
sle_2 sle_2
st_50 st_50
rb_2 rb_2
sle_1 sle_1
rb_1 rb_1
st_3 st_3
end type
global uo_inpempno_1 uo_inpempno_1

on uo_inpempno_1.create
this.st_2=create st_2
this.st_1=create st_1
this.sle_2=create sle_2
this.st_50=create st_50
this.rb_2=create rb_2
this.sle_1=create sle_1
this.rb_1=create rb_1
this.st_3=create st_3
this.Control[]={this.st_2,&
this.st_1,&
this.sle_2,&
this.st_50,&
this.rb_2,&
this.sle_1,&
this.rb_1,&
this.st_3}
end on

on uo_inpempno_1.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_2)
destroy(this.st_50)
destroy(this.rb_2)
destroy(this.sle_1)
destroy(this.rb_1)
destroy(this.st_3)
end on

event constructor;string l_s_empno

l_s_empno = sle_1.text

//sle_2.text = f_get_empname(l_s_empno)
//st_1.text  = f_classrtn(l_s_empno)
//st_2.text  = f_deptnmrtn(l_s_empno, 'A')
end event

type st_2 from statictext within uo_inpempno_1
integer x = 2112
integer y = 20
integer width = 1211
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within uo_inpempno_1
integer x = 1541
integer y = 20
integer width = 517
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within uo_inpempno_1
integer x = 1051
integer y = 20
integer width = 384
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event getfocus;rb_2.checked = true
f_toggle_per( handle(This), 'KOR' ) // 키보드 한글로 설정...
end event

type st_50 from statictext within uo_inpempno_1
integer x = 823
integer y = 32
integer width = 229
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "성   명"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within uo_inpempno_1
integer x = 741
integer y = 28
integer width = 73
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
end type

event clicked;sle_2.setfocus()
end event

type sle_1 from singlelineedit within uo_inpempno_1
integer x = 325
integer y = 20
integer width = 384
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
integer limit = 6
borderstyle borderstyle = stylelowered!
end type

event getfocus;rb_1.checked = true
f_toggle_per( handle(This), 'ENG' ) // 키보드 ENGLISH로 설정...
end event

type rb_1 from radiobutton within uo_inpempno_1
integer x = 23
integer y = 28
integer width = 73
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
boolean checked = true
end type

event clicked;sle_1.setfocus()
end event

type st_3 from statictext within uo_inpempno_1
integer x = 114
integer y = 32
integer width = 210
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "사  번"
boolean focusrectangle = false
end type

