$PBExportHeader$w_pisg060b.srw
$PBExportComments$�������_���������Ͽ���
forward
global type w_pisg060b from window
end type
type st_3 from statictext within w_pisg060b
end type
type st_2 from statictext within w_pisg060b
end type
type pb_exit from picturebutton within w_pisg060b
end type
type gb_2 from groupbox within w_pisg060b
end type
type st_1 from statictext within w_pisg060b
end type
end forward

global type w_pisg060b from window
integer x = 1298
integer y = 760
integer width = 2350
integer height = 1064
boolean titlebar = true
string title = "������� ����"
windowtype windowtype = response!
long backcolor = 80269524
st_3 st_3
st_2 st_2
pb_exit pb_exit
gb_2 gb_2
st_1 st_1
end type
global w_pisg060b w_pisg060b

type variables
INTEGER	ii_time_count
end variables

on w_pisg060b.create
this.st_3=create st_3
this.st_2=create st_2
this.pb_exit=create pb_exit
this.gb_2=create gb_2
this.st_1=create st_1
this.Control[]={this.st_3,&
this.st_2,&
this.pb_exit,&
this.gb_2,&
this.st_1}
end on

on w_pisg060b.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.pb_exit)
destroy(this.gb_2)
destroy(this.st_1)
end on

event timer;/*######################################################################
#####		�ð��� üũ�Ͽ�	COLOR ����										 #####
######################################################################*/

ii_time_count = ii_time_count + 1

if MOD(ii_time_count, 2) = 1 then
	st_2.text	= ''
	st_3.text	= ''
else
	st_2.text	= '������� ����'
	st_3.text	= '������ Ȯ���Ͽ� �ֽʽÿ�.'
end if

end event

event open;f_centerwindow(this)

timer(0.5)

pb_exit.SetFocus()

end event

type st_3 from statictext within w_pisg060b
integer x = 96
integer y = 360
integer width = 2144
integer height = 160
integer textsize = -28
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 65535
long backcolor = 0
string text = "������ Ȯ���Ͽ� �ֽʽÿ�."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisg060b
integer x = 96
integer y = 132
integer width = 2144
integer height = 180
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 65535
long backcolor = 0
string text = "������� ����"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_exit from picturebutton within w_pisg060b
integer x = 901
integer y = 672
integer width = 535
integer height = 224
integer taborder = 20
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Ȯ��"
boolean default = true
vtextalign vtextalign = vcenter!
end type

event clicked;/*######################################################################
#####		w_pisg060b ������ ����												 #####
######################################################################*/

// �������ȭ�� �ֻ�����
w_pisg030i.BringToTop = TRUE

// ���ǹ�ȣ �Է�â�� �ʱ�ȭ�� FOCUS
w_pisg030i.em_kb_no.text = ''
w_pisg030i.em_kb_no.SetFocus()

Close(w_pisg060b)

end event

type gb_2 from groupbox within w_pisg060b
integer x = 55
integer y = 628
integer width = 2222
integer height = 316
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 255
long backcolor = 80269524
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_pisg060b
integer x = 55
integer y = 48
integer width = 2222
integer height = 564
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 0
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

