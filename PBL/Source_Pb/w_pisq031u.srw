$PBExportHeader$w_pisq031u.srw
$PBExportComments$�˻���ؼ� ����(�����ڼ��� �������� ������)
forward
global type w_pisq031u from window
end type
type gb_2 from groupbox within w_pisq031u
end type
type cb_consert from commandbutton within w_pisq031u
end type
type dw_pisq031u_01 from u_vi_std_datawindow within w_pisq031u
end type
type cb_ok from commandbutton within w_pisq031u
end type
type gb_1 from groupbox within w_pisq031u
end type
type dw_pisq031u_02 from u_vi_std_datawindow within w_pisq031u
end type
type st_1 from statictext within w_pisq031u
end type
type st_2 from statictext within w_pisq031u
end type
end forward

global type w_pisq031u from window
integer width = 2181
integer height = 1712
boolean titlebar = true
string title = "�����ڼ���"
windowtype windowtype = response!
long backcolor = 67108864
gb_2 gb_2
cb_consert cb_consert
dw_pisq031u_01 dw_pisq031u_01
cb_ok cb_ok
gb_1 gb_1
dw_pisq031u_02 dw_pisq031u_02
st_1 st_1
st_2 st_2
end type
global w_pisq031u w_pisq031u

type variables

String	is_areadivision
end variables

on w_pisq031u.create
this.gb_2=create gb_2
this.cb_consert=create cb_consert
this.dw_pisq031u_01=create dw_pisq031u_01
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.dw_pisq031u_02=create dw_pisq031u_02
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.gb_2,&
this.cb_consert,&
this.dw_pisq031u_01,&
this.cb_ok,&
this.gb_1,&
this.dw_pisq031u_02,&
this.st_1,&
this.st_2}
end on

on w_pisq031u.destroy
destroy(this.gb_2)
destroy(this.cb_consert)
destroy(this.dw_pisq031u_01)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.dw_pisq031u_02)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;
// �������� �������� ��ǥ�� �缳���Ѵ�
//
This.x = 500
This.y = 570

// �������� �������� Ÿ��Ʋ�� �缳���Ѵ�
//
this.title = 'w_pisq031u(�����ڼ���)'

is_areadivision = Message.StringParm

// Ʈ������� �����Ѵ�
//
dw_pisq031u_01.SetTransObject(SQLPIS)
dw_pisq031u_02.SetTransObject(SQLPIS)

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq031u_01.Retrieve(g_s_empno)
dw_pisq031u_02.Retrieve(mid(is_areadivision,1,1), mid(is_areadivision,2,1), g_s_empno)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq031u_01, 1, True)	
f_SetHighlight(dw_pisq031u_02, 1, True)	

end event

type gb_2 from groupbox within w_pisq031u
integer x = 32
integer y = 28
integer width = 2080
integer height = 180
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type cb_consert from commandbutton within w_pisq031u
integer x = 974
integer y = 1484
integer width = 384
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����������"
end type

event clicked;
String	ls_EmpNo, ls_empname

// �����ڸ� ���Ѵ�
//
ls_EmpNo		= dw_pisq031u_01.GetItemString(dw_pisq031u_01.GetSelectedRow(0), "EmpNo")
ls_empname	= dw_pisq031u_01.GetItemString(dw_pisq031u_01.GetSelectedRow(0), "EmpName")

// ���õ� �����ڸ� ����ȭ�鿡 ǥ���Ѵ�
//
IF dw_pisq031u_02.RowCount() = 0 THEN
	dw_pisq031u_02.InsertRow(0)
END IF
dw_pisq031u_02.SetItem(1, "consertempno", ls_EmpNo)
dw_pisq031u_02.SetItem(1, "empname", ls_empname)

// ���忡 �ʿ��� �⺻�ڷḦ ��Ʈ�Ѵ�
//
dw_pisq031u_02.SetItem(1, "areacode"		, mid(is_areadivision,1,1))
dw_pisq031u_02.SetItem(1, "divisioncode"	, mid(is_areadivision,2,1))
dw_pisq031u_02.SetItem(1, "empno"			, g_s_empno)

f_SetHighlight(dw_pisq031u_02, 1, True)	


// ������ ����� �����Ѵ�
//
//CloseWithReturn(Parent, ls_EmpNo)
end event

type dw_pisq031u_01 from u_vi_std_datawindow within w_pisq031u
integer x = 27
integer y = 224
integer width = 1330
integer height = 1240
integer taborder = 20
string dataobject = "d_pisq031u_01"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
// ó���� �˻���ؼ� ����ó���� �Ѱ��ش�
//
//cb_ok.TriggerEvent (Clicked!)
end event

type cb_ok from commandbutton within w_pisq031u
integer x = 1733
integer y = 1484
integer width = 384
integer height = 104
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�����ڼ���"
end type

event clicked;
String	ls_EmpNo = ''
Int		li_save 

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq031u_02.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF

// ������ �������� ����� ���Ѵ�
//
ls_EmpNo	= dw_pisq031u_02.GetItemString(dw_pisq031u_02.GetSelectedRow(0), "consertempno")

// ������ ����� �����Ѵ�
//
CloseWithReturn(Parent, ls_EmpNo)
end event

type gb_1 from groupbox within w_pisq031u
integer width = 2149
integer height = 1612
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

type dw_pisq031u_02 from u_vi_std_datawindow within w_pisq031u
integer x = 1376
integer y = 224
integer width = 741
integer height = 1240
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisq031u_02"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
// ó���� �˻���ؼ� ����ó���� �Ѱ��ش�
//
//cb_ok.TriggerEvent (Clicked!)
end event

type st_1 from statictext within w_pisq031u
integer x = 50
integer y = 60
integer width = 2025
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 67108864
string text = "�����ڸ� �����Ͻð� �ѹ� ������ �����ڴ� ������ ������������"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisq031u
integer x = 50
integer y = 124
integer width = 2025
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 67108864
string text = "�ϱ� �������� ��� ���ǿ����� �����ڴ� 1�θ� ���� �����մϴ�"
boolean focusrectangle = false
end type

