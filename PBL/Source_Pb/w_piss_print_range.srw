$PBExportHeader$w_piss_print_range.srw
$PBExportComments$������������� �Է¹���
forward
global type w_piss_print_range from window
end type
type cb_print from commandbutton within w_piss_print_range
end type
type sle_range from singlelineedit within w_piss_print_range
end type
type st_3 from statictext within w_piss_print_range
end type
type st_2 from statictext within w_piss_print_range
end type
type st_1 from statictext within w_piss_print_range
end type
type gb_1 from groupbox within w_piss_print_range
end type
type gb_2 from groupbox within w_piss_print_range
end type
end forward

global type w_piss_print_range from window
integer width = 2272
integer height = 492
boolean titlebar = true
string title = "�������������"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_print cb_print
sle_range sle_range
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
gb_2 gb_2
end type
global w_piss_print_range w_piss_print_range

on w_piss_print_range.create
this.cb_print=create cb_print
this.sle_range=create sle_range
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_print,&
this.sle_range,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1,&
this.gb_2}
end on

on w_piss_print_range.destroy
destroy(this.cb_print)
destroy(this.sle_range)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;sle_range.setfocus()
end event
type cb_print from commandbutton within w_piss_print_range
integer x = 1783
integer y = 252
integer width = 389
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�μ�"
end type

event clicked;if f_spacechk(sle_range.text) = -1 then
	messagebox("�˸�","�μ����������� �Է��Ͻʽÿ�!")
	return 0
end if

closewithreturn(w_piss_print_range,sle_range.text)
end event
type sle_range from singlelineedit within w_piss_print_range
integer x = 494
integer y = 252
integer width = 1202
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_piss_print_range
integer x = 69
integer y = 268
integer width = 439
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "�μ������� :"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_piss_print_range
integer x = 87
integer y = 132
integer width = 1353
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "�Է����� : 1,2, 5-10 ���� �Ͻø� �˴ϴ�."
boolean focusrectangle = false
end type

type st_1 from statictext within w_piss_print_range
integer x = 87
integer y = 48
integer width = 2098
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "���� ��� 1������, 5������, 5 ���� 10 �������� �μ��ϰ��� �Ѵٸ�,"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss_print_range
integer x = 32
integer width = 2203
integer height = 220
integer taborder = 10
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
end type

type gb_2 from groupbox within w_piss_print_range
integer x = 32
integer y = 212
integer width = 2203
integer height = 152
integer taborder = 20
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
end type

