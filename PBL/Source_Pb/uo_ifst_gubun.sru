$PBExportHeader$uo_ifst_gubun.sru
$PBExportComments$간접제/업무지원품 구분
forward
global type uo_ifst_gubun from userobject
end type
type st_a from statictext within uo_ifst_gubun
end type
type rb_b from radiobutton within uo_ifst_gubun
end type
type rb_a from radiobutton within uo_ifst_gubun
end type
type gb_1 from groupbox within uo_ifst_gubun
end type
end forward

global type uo_ifst_gubun from userobject
integer width = 1193
integer height = 144
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_a st_a
rb_b rb_b
rb_a rb_a
gb_1 gb_1
end type
global uo_ifst_gubun uo_ifst_gubun

forward prototypes
public function string uf_get_ifst ()
end prototypes

public function string uf_get_ifst ();// 간접제('0'), 업무지원품('1')

IF rb_a.checked = true Then
	return "0"
Else
	return "1"
End IF
	
end function

on uo_ifst_gubun.create
this.st_a=create st_a
this.rb_b=create rb_b
this.rb_a=create rb_a
this.gb_1=create gb_1
this.Control[]={this.st_a,&
this.rb_b,&
this.rb_a,&
this.gb_1}
end on

on uo_ifst_gubun.destroy
destroy(this.st_a)
destroy(this.rb_b)
destroy(this.rb_a)
destroy(this.gb_1)
end on

type st_a from statictext within uo_ifst_gubun
integer x = 18
integer y = 52
integer width = 334
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "구     분"
boolean focusrectangle = false
end type

type rb_b from radiobutton within uo_ifst_gubun
integer x = 741
integer y = 48
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "업무지원품"
borderstyle borderstyle = stylelowered!
end type

type rb_a from radiobutton within uo_ifst_gubun
integer x = 430
integer y = 48
integer width = 302
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "간접재"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within uo_ifst_gubun
integer x = 398
integer width = 782
integer height = 124
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

