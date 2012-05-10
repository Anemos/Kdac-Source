$PBExportHeader$w_pisz051u.srw
$PBExportComments$������� ��ǥLPI ���
forward
global type w_pisz051u from w_pism_resp01
end type
type cb_2 from commandbutton within w_pisz051u
end type
type cb_save from commandbutton within w_pisz051u
end type
type dw_divtarlpi from u_pism_dw within w_pisz051u
end type
end forward

global type w_pisz051u from w_pism_resp01
integer width = 1728
integer height = 2784
string title = "������� ��ǥLPI ���"
boolean controlmenu = false
cb_2 cb_2
cb_save cb_save
dw_divtarlpi dw_divtarlpi
end type
global w_pisz051u w_pisz051u

type variables
String is_modChk 
end variables

on w_pisz051u.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_save=create cb_save
this.dw_divtarlpi=create dw_divtarlpi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.dw_divtarlpi
end on

on w_pisz051u.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.dw_divtarlpi)
end on

event open;call super::open;cb_save.Enabled = False 

This.TriggerEvent("ue_retrieve") 
end event

event ue_retrieve;call super::ue_retrieve;dw_divtarlpi.SetTransObject(SqlPIS)
dw_divtarlpi.Retrieve(istr_mh.area, istr_mh.div, istr_mh.year, g_s_empno) 
dw_divtarlpi.Setfocus() 
end event

type cb_2 from commandbutton within w_pisz051u
integer x = 1189
integer y = 2596
integer width = 507
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�ݱ�"
end type

event clicked;If cb_save.Enabled Then 
	If f_pism_MessageBox(Question!, 999, "������� ��ǥLPI", "������ ���� �ֽ��ϴ�. �����Ͻðڽ��ϱ�?") = 1 Then & 
		cb_save.TriggerEvent(Clicked!) 
End If 

CloseWithReturn ( Parent, is_modChk )
end event

type cb_save from commandbutton within w_pisz051u
integer x = 681
integer y = 2596
integer width = 507
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;If dw_divtarlpi.Event save_data() = -1 Then
	f_pism_MessageBox(StopSign!, -1, "������� ��ǥLPI", "�Է��Ͻ� ��ǥ���� ���忡 �����߽��ϴ�.") 
	Return 
End If 

is_modChk = '1' 
This.Enabled = False 


end event

type dw_divtarlpi from u_pism_dw within w_pisz051u
integer x = 9
integer width = 1682
integer height = 2592
integer taborder = 20
string dataobject = "d_pism050u_05"
integer ii_selection = 0
end type

event itemchanged;call super::itemchanged;Decimal{1} ld_tarLPI, ld_calc_bunmo, ld_calc_bunja 

This.AcceptText() 

ld_tarLPI = This.GetItemNumber(row, "calc_tarlpi") 
If IsNull(ld_tarLPI) Then ld_tarLPI = 0 
This.SetItem(row, "tarlpi", ld_tarLPI) 
This.SetItem(row, "lastemp", g_s_empno)
This.Setitem(row, "lastdate", f_pisc_get_date_nowtime()) 

ld_calc_bunja = This.GetItemNumber(row, "calc_bunja") 
ld_calc_bunmo = This.GetItemNumber(row, "calc_bunmo") 

This.SetItem(13, "tarlpi_bunja", ld_calc_bunja)
This.SetItem(13, "tarlpi_bunmo", ld_calc_bunmo)

ld_tarLPI = This.GetItemNumber(13, "calc_tarlpi") 
This.SetItem(13, "tarlpi", ld_tarLPI)

cb_save.Enabled = True 
end event

event save_data;call super::save_data;This.AcceptText() 
Return f_pism_dwupdate(This, True) 
end event

