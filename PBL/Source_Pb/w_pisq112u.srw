$PBExportHeader$w_pisq112u.srw
$PBExportComments$�˻缺���� ������ �ߺ� �ŷ���ǥ��ȣ ǥ��(���ǿ�)
forward
global type w_pisq112u from w_ipis_sheet01
end type
type cb_ok from commandbutton within w_pisq112u
end type
type dw_pisq112u_01 from u_vi_std_datawindow within w_pisq112u
end type
type gb_1 from groupbox within w_pisq112u
end type
end forward

global type w_pisq112u from w_ipis_sheet01
integer width = 2912
integer height = 2176
string title = "�ŷ���ǥ��ȣ ����"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_ok cb_ok
dw_pisq112u_01 dw_pisq112u_01
gb_1 gb_1
end type
global w_pisq112u w_pisq112u

type variables


end variables

on w_pisq112u.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.dw_pisq112u_01=create dw_pisq112u_01
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.dw_pisq112u_01
this.Control[iCurrent+3]=this.gb_1
end on

on w_pisq112u.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.dw_pisq112u_01)
destroy(this.gb_1)
end on

event resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq030u, FULL)
//
//of_resize()
//
end event

event open;
String	ls_areacode, ls_divisioncode, ls_slno

// �����찣�� ������ ��Ʈ���� �迭�� �޴´�
//
istr_parms = message.powerobjectparm

// �������� �������� ��ǥ�� �缳���Ѵ�
//
This.x = 1
This.y = 265

// �������� �������� Ÿ��Ʋ�� �缳���Ѵ�
//
this.title = 'w_pisq112u(�ŷ���ǥ��ȣ ����)'

// Ʈ������� �����Ѵ�
//
dw_pisq112u_01.SetTransObject(SQLPIS)

ls_areacode			= istr_parms.String_arg[1]
ls_divisioncode	= istr_parms.String_arg[2]
ls_slno				= istr_parms.String_arg[3]

// �ڷḦ ��ȸ�Ѵ�
//
dw_pisq112u_01.Retrieve(ls_areacode, ls_divisioncode, ls_slno)

// ����Ÿ�����쿡 ��Ŀ���� �ִ� �࿡ ����ǥ�ø� ��Ÿ����(1��)
//
f_SetHighlight(dw_pisq112u_01, 1, True)	


// ����ũ�� ������ ������ ��Ʈ�Ѵ�
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")


end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq112u
integer x = 32
integer y = 2104
integer width = 3602
end type

type cb_ok from commandbutton within w_pisq112u
integer x = 2478
integer y = 1936
integer width = 384
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��  ��"
end type

event clicked;

String	ls_slno

// ������ �������� ����� ���Ѵ�
//
ls_slno = dw_pisq112u_01.GetItemString(dw_pisq112u_01.GetSelectedRow(0), "slno")

istr_parms.String_arg[4] = ls_slno

// ������ ����� �����Ѵ�
//
CloseWithReturn(Parent, istr_parms)
end event

type dw_pisq112u_01 from u_vi_std_datawindow within w_pisq112u
integer x = 32
integer y = 28
integer width = 2825
integer height = 1872
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq112u_01"
end type

event doubleclicked;call super::doubleclicked;
// ó���� �˻���ؼ� ����ó���� �Ѱ��ش�
//
cb_ok.TriggerEvent (Clicked!)
end event

type gb_1 from groupbox within w_pisq112u
integer x = 9
integer width = 2875
integer height = 2072
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

