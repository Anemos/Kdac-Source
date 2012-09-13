$PBExportHeader$w_pisq525u.srw
$PBExportComments$��������ڵ���(����)
forward
global type w_pisq525u from w_ipis_sheet01
end type
type dw_pisq525u_01 from u_vi_std_datawindow within w_pisq525u
end type
type gb_2 from groupbox within w_pisq525u
end type
end forward

global type w_pisq525u from w_ipis_sheet01
integer width = 4695
integer height = 2700
string title = "��������ڵ���(����)"
dw_pisq525u_01 dw_pisq525u_01
gb_2 gb_2
end type
global w_pisq525u w_pisq525u

type variables

String	is_AreaCode, is_DivisionCode
Long		il_selectcnt

end variables

on w_pisq525u.create
int iCurrent
call super::create
this.dw_pisq525u_01=create dw_pisq525u_01
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq525u_01
this.Control[iCurrent+2]=this.gb_2
end on

on w_pisq525u.destroy
call super::destroy
destroy(this.dw_pisq525u_01)
destroy(this.gb_2)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq080i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
dw_pisq525u_01.Retrieve()

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq525u_01, 1, True)	


end event

event ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq525u_01.SetTransObject(SQLEIS)

This.TriggerEvent('ue_retrieve')
end event

event ue_save;call super::ue_save;
Int	li_save

// AUTO COMMIT�� FASLE�� ����
//
SQLEIS.AUTOCommit = FALSE

li_save = dw_pisq525u_01.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLEIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF

end event

event ue_insert;call super::ue_insert;
Long	ll_ins_row

// ���� �Է����� ���Ѵ�
//
ll_ins_row = dw_pisq525u_01.InsertRow(0)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq525u_01.SetColumn('dealercode')
dw_pisq525u_01.SetFocus()

// ���� �Է��࿡ ����ǥ�ø� �Ѵ�
//
f_SetHighlight(dw_pisq525u_01, ll_ins_row, True)	


end event

event ue_delete;call super::ue_delete;
Long	ll_select_row

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq525u_01.GetSelectedRow(0)

// ���õ� ���� �����Ѵ�
//
dw_pisq525u_01.DeleteRow(dw_pisq525u_01.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq525u_01.RowCount() THEN
	f_SetHighlight(dw_pisq525u_01, dw_pisq525u_01.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq525u_01, ll_select_row, True)	
END IF

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("Ȯ��","EIS ������ �����ϴµ� �����߽��ϴ�.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

event ue_print;call super::ue_print;if dw_pisq525u_01.rowcount() < 1 then
	uo_status.st_message.text = "�ٿ�ε��� �ڷᰡ �����ϴ�."
end if

f_save_to_excel_number(dw_pisq525u_01)

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq525u
integer x = 18
integer width = 3598
end type

type dw_pisq525u_01 from u_vi_std_datawindow within w_pisq525u
integer x = 46
integer y = 44
integer width = 4562
integer height = 2504
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq525u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_2 from groupbox within w_pisq525u
integer x = 18
integer y = 12
integer width = 4622
integer height = 2560
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

