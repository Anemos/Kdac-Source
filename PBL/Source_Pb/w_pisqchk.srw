$PBExportHeader$w_pisqchk.srw
$PBExportComments$�ٿ�ε� Ȯ�ο�
forward
global type w_pisqchk from window
end type
type cb_1 from commandbutton within w_pisqchk
end type
type st_6 from statictext within w_pisqchk
end type
type st_5 from statictext within w_pisqchk
end type
type st_4 from statictext within w_pisqchk
end type
type st_3 from statictext within w_pisqchk
end type
type st_2 from statictext within w_pisqchk
end type
type st_1 from statictext within w_pisqchk
end type
type gb_1 from groupbox within w_pisqchk
end type
end forward

global type w_pisqchk from window
integer width = 2533
integer height = 1076
boolean titlebar = true
string title = "���׷��̵� Ȯ�ο� ������"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
gb_1 gb_1
end type
global w_pisqchk w_pisqchk

on w_pisqchk.create
this.cb_1=create cb_1
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.gb_1}
end on

on w_pisqchk.destroy
destroy(this.cb_1)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_1)
end on

type cb_1 from commandbutton within w_pisqchk
integer x = 1883
integer y = 808
integer width = 567
integer height = 96
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;close(w_pisqchk)
end event

type st_6 from statictext within w_pisqchk
integer x = 146
integer y = 660
integer width = 2071
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "�ý��۰����� ( T:2236 ) ��⼷�븮���� �����ٶ��ϴ�."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_pisqchk
integer x = 146
integer y = 540
integer width = 1861
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "�� �޽����� ������ �ʴ� �ܸ��Ⱑ ���� ��쿡�� "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_pisqchk
integer x = 142
integer y = 428
integer width = 1271
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "���α׷��� ���� �Ǵ� ����ýÿ� "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisqchk
integer x = 110
integer y = 280
integer width = 1632
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "�޽�����±Ⱓ : 2005.04.18 ~~ 2005.05.15"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisqchk
integer x = 114
integer y = 188
integer width = 1390
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "�� �޽����� �Ѵް� �������� �˴ϴ�."
alignment alignment = center!
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisqchk
integer x = 59
integer y = 52
integer width = 2327
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 65535
long backcolor = 0
string text = "�� �ܸ���� ���������� ���α׷��� �ٿ�ε��� �� �ֽ��ϴ�."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisqchk
integer x = 37
integer y = 372
integer width = 2423
integer height = 400
integer taborder = 10
integer textsize = -6
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
end type

