$PBExportHeader$w_dw_saveas_option_r.srw
$PBExportComments$datawindow saveas option ����
forward
global type w_dw_saveas_option_r from window
end type
type st_2 from statictext within w_dw_saveas_option_r
end type
type cb_3 from commandbutton within w_dw_saveas_option_r
end type
type st_1 from statictext within w_dw_saveas_option_r
end type
type cb_2 from commandbutton within w_dw_saveas_option_r
end type
type cb_1 from commandbutton within w_dw_saveas_option_r
end type
type gb_1 from groupbox within w_dw_saveas_option_r
end type
end forward

global type w_dw_saveas_option_r from window
integer x = 1074
integer y = 484
integer width = 1550
integer height = 568
boolean titlebar = true
string title = "���Ϸ� ���� �ɼǼ���"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
st_2 st_2
cb_3 cb_3
st_1 st_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_dw_saveas_option_r w_dw_saveas_option_r

type prototypes
FUNCTION boolean chdir(string d) LIBRARY "FUNCky32.DLL"
end prototypes

type variables
//��ȯ�� ����
INTEGER	ii_return = -1

// 2001.11.14
DataWindow	idw_source
end variables

event open;SetPointer(HourGlass!)

//ȭ���߾ӿ� ��ġ
f_pisc_win_center_move(THIS)

//2001.11.14
idw_source = Message.PowerObjectParm
end event

on w_dw_saveas_option_r.create
this.st_2=create st_2
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.cb_3,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.gb_1}
end on

on w_dw_saveas_option_r.destroy
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event close;CloseWithReturn( THIS, ii_return )
end event

type st_2 from statictext within w_dw_saveas_option_r
integer x = 823
integer y = 124
integer width = 526
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long backcolor = 79741120
boolean enabled = false
string text = "�� ��� ����Ÿ "
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_dw_saveas_option_r
integer x = 78
integer y = 276
integer width = 695
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
string text = "����� ���� Columns"
end type

event clicked;//2001.11.14
OpenWithParm(w_dw_saveas_user_r, idw_source)

ii_return = 3
CLOSE(PARENT)

end event

type st_1 from statictext within w_dw_saveas_option_r
integer x = 823
integer y = 304
integer width = 526
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long backcolor = 79741120
boolean enabled = false
string text = "�� �ѱ� ��� ����"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_dw_saveas_option_r
integer x = 174
integer y = 592
integer width = 695
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
string text = "�ڵ带 �ѱ۸����� ����"
end type

event clicked;ii_return = 2
CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_dw_saveas_option_r
integer x = 78
integer y = 96
integer width = 695
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
string text = "���� ������ �״������"
end type

event clicked;//2001.11.14
//ii_return = 1
//CLOSE(PARENT)

ii_return = idw_source.SaveAs("", Excel!, True)

// 2001.11.14 - ���� ���丮�� diconet ���丮�� ����(Funcky32.dll �̿�)
// ������������� ���� ���丮�� �ٲ�� toolbar icon�� �������� ���ϱ� ����
//chdir(gstr_login.ss_work_directory)

Close(Parent)
end event

type gb_1 from groupbox within w_dw_saveas_option_r
integer x = 18
integer width = 1472
integer height = 456
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long backcolor = 79741120
end type

