$PBExportHeader$uo_inpemp.sru
$PBExportComments$사번성명입력
forward
global type uo_inpemp from userobject
end type
type pb_1 from picturebutton within uo_inpemp
end type
type sle_2 from singlelineedit within uo_inpemp
end type
type st_50 from statictext within uo_inpemp
end type
type rb_2 from radiobutton within uo_inpemp
end type
type sle_1 from singlelineedit within uo_inpemp
end type
type rb_1 from radiobutton within uo_inpemp
end type
type st_3 from statictext within uo_inpemp
end type
end forward

global type uo_inpemp from userobject
integer width = 1737
integer height = 124
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_1 pb_1
sle_2 sle_2
st_50 st_50
rb_2 rb_2
sle_1 sle_1
rb_1 rb_1
st_3 st_3
end type
global uo_inpemp uo_inpemp

on uo_inpemp.create
this.pb_1=create pb_1
this.sle_2=create sle_2
this.st_50=create st_50
this.rb_2=create rb_2
this.sle_1=create sle_1
this.rb_1=create rb_1
this.st_3=create st_3
this.Control[]={this.pb_1,&
this.sle_2,&
this.st_50,&
this.rb_2,&
this.sle_1,&
this.rb_1,&
this.st_3}
end on

on uo_inpemp.destroy
destroy(this.pb_1)
destroy(this.sle_2)
destroy(this.st_50)
destroy(this.rb_2)
destroy(this.sle_1)
destroy(this.rb_1)
destroy(this.st_3)
end on

event getfocusobject;f_toggle_per( handle(This), 'KOR' ) // 키보드 한글로 설정...
return 0
end event

type pb_1 from picturebutton within uo_inpemp
integer x = 1486
integer y = 8
integer width = 238
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm

l_s_parm = trim(sle_2.text) 

openwithparm(w_per000i, l_s_parm)
sle_1.text = mid(message.stringParm , 1, 6)
sle_2.text = mid(message.stringParm , 7)
end event

event destructor;//sle_1.text = mid(message.stringParm , 1, 6)
//sle_2.text = mid(message.stringParm , 7)
end event

type sle_2 from singlelineedit within uo_inpemp
integer x = 1051
integer y = 16
integer width = 384
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event getfocus;rb_2.checked = true
end event

type st_50 from statictext within uo_inpemp
integer x = 846
integer y = 32
integer width = 210
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 12632256
string text = "성   명"
boolean focusrectangle = false
end type

type rb_2 from radiobutton within uo_inpemp
integer x = 763
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

type sle_1 from singlelineedit within uo_inpemp
integer x = 306
integer y = 16
integer width = 384
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16777215
textcase textcase = upper!
integer limit = 6
borderstyle borderstyle = stylelowered!
end type

event getfocus;rb_1.checked = true
f_toggle_per( handle(This), 'ENG' ) // 키보드 한글로 설정...

end event

type rb_1 from radiobutton within uo_inpemp
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

type st_3 from statictext within uo_inpemp
integer x = 114
integer y = 32
integer width = 187
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 12632256
string text = "사  번"
boolean focusrectangle = false
end type

