$PBExportHeader$w_find_002.srw
$PBExportComments$ǰ�� ã��(ǰ������) Response Window
forward
global type w_find_002 from window
end type
type cb_3 from commandbutton within w_find_002
end type
type sle_1 from singlelineedit within w_find_002
end type
type cb_2 from commandbutton within w_find_002
end type
type cb_1 from commandbutton within w_find_002
end type
type dw_1 from datawindow within w_find_002
end type
type gb_1 from groupbox within w_find_002
end type
end forward

global type w_find_002 from window
integer x = 201
integer y = 500
integer width = 2002
integer height = 1400
boolean titlebar = true
string title = "ǰ�� ã��"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 12632256
cb_3 cb_3
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_find_002 w_find_002

on w_find_002.create
this.cb_3=create cb_3
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.sle_1,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_find_002.destroy
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;string l_s_pdcd, l_s_parm,l_s_prname

dw_1.settransobject(sqlca)
dw_1.reset()

end event
type cb_3 from commandbutton within w_find_002
integer x = 1554
integer y = 184
integer width = 261
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�� ��"
boolean default = true
end type

event clicked;string l_s_parm, l_s_div , l_s_pdcd , l_s_itno,l_s_plant
integer l_n_row
dw_1.reset()

l_s_parm = message.stringparm
l_s_plant = mid(l_s_parm,1,1)
l_s_div = mid(l_s_parm,2,1)
// l_s_pdcd = mid(l_s_parm,2,2) + "%"


if f_spacechk(sle_1.text) = -1 then
	messagebox("Ȯ��","�˻�� �Է��ϼ���")
   return
end if

l_s_itno = "%" + upper(trim(sle_1.text)) + "%"
l_n_row = dw_1.retrieve(l_s_plant,l_s_div,l_s_itno)
if l_n_row < 1 then
	messagebox("Ȯ��","�ش��ڷᰡ �����ϴ�")
end if

end event

type sle_1 from singlelineedit within w_find_002
integer x = 87
integer y = 120
integer width = 786
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_find_002
integer x = 1527
integer y = 1192
integer width = 288
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�� ��"
end type

event clicked;string l_s_itno
l_s_itno = ""
closewithreturn(parent,l_s_itno)
end event

type cb_1 from commandbutton within w_find_002
integer x = 1202
integer y = 1192
integer width = 288
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Ȯ ��"
end type

event clicked;string l_s_itno,l_s_itnm
integer l_s_row

l_s_row = dw_1.getrow()
l_s_itno = string(dw_1.getitemstring(l_s_row,"inv101_itno"),"@@@@@@@@@@@@@@@")
l_s_itnm = trim(dw_1.getitemstring(l_s_row,"inv002_itnm"))
if f_spacechk(l_s_itno) = -1 then
	messagebox("Ȯ��","ǰ���� �����ϼ���")
	return
else
	closewithreturn(parent,l_s_itno + l_s_itnm)
end if
end event

type dw_1 from datawindow within w_find_002
integer x = 46
integer y = 336
integer width = 1851
integer height = 824
string title = "none"
string dataobject = "d_find002_item"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string l_s_itno,l_s_itnm
this.selectrow(0,false)
this.selectrow(row,true)
l_s_itno = string(dw_1.getitemstring(row,"inv101_itno"),"@@@@@@@@@@@@@@@")
l_s_itnm = trim(dw_1.getitemstring(row,"inv002_itnm"))
if f_spacechk(l_s_itno) = -1 then
	messagebox("Ȯ��","ǰ���� �����ϼ���")
	return
else
	closewithreturn(parent,l_s_itno + l_s_itnm)
end if



end event

type gb_1 from groupbox within w_find_002
integer x = 50
integer y = 32
integer width = 859
integer height = 252
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 255
long backcolor = 12632256
string text = "�˻���( ǰ������ �˻� )"
end type

