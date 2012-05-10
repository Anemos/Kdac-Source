$PBExportHeader$w_pisq260u.srw
$PBExportComments$Containment �ҷ��������
forward
global type w_pisq260u from w_ipis_sheet01
end type
type gb_1 from groupbox within w_pisq260u
end type
type gb_5 from groupbox within w_pisq260u
end type
type dw_pisq260u_01 from u_vi_std_datawindow within w_pisq260u
end type
type uo_area from u_pisc_select_area within w_pisq260u
end type
type uo_division from u_pisc_select_division within w_pisq260u
end type
type dw_pisq260u_02 from u_vi_std_datawindow within w_pisq260u
end type
type st_2 from statictext within w_pisq260u
end type
type st_3 from statictext within w_pisq260u
end type
type cb_reason_ins from commandbutton within w_pisq260u
end type
type cb_reason_del from commandbutton within w_pisq260u
end type
type cb_reason_save from commandbutton within w_pisq260u
end type
type cb_type_save from commandbutton within w_pisq260u
end type
type cb_type_del from commandbutton within w_pisq260u
end type
type cb_type_ins from commandbutton within w_pisq260u
end type
type gb_2 from groupbox within w_pisq260u
end type
type gb_3 from groupbox within w_pisq260u
end type
end forward

global type w_pisq260u from w_ipis_sheet01
integer width = 2843
integer height = 2784
string title = "Containment �ҷ��������"
gb_1 gb_1
gb_5 gb_5
dw_pisq260u_01 dw_pisq260u_01
uo_area uo_area
uo_division uo_division
dw_pisq260u_02 dw_pisq260u_02
st_2 st_2
st_3 st_3
cb_reason_ins cb_reason_ins
cb_reason_del cb_reason_del
cb_reason_save cb_reason_save
cb_type_save cb_type_save
cb_type_del cb_type_del
cb_type_ins cb_type_ins
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq260u w_pisq260u

type variables

String	is_AreaCode, is_DivisionCode

end variables

on w_pisq260u.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_5=create gb_5
this.dw_pisq260u_01=create dw_pisq260u_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq260u_02=create dw_pisq260u_02
this.st_2=create st_2
this.st_3=create st_3
this.cb_reason_ins=create cb_reason_ins
this.cb_reason_del=create cb_reason_del
this.cb_reason_save=create cb_reason_save
this.cb_type_save=create cb_type_save
this.cb_type_del=create cb_type_del
this.cb_type_ins=create cb_type_ins
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_5
this.Control[iCurrent+3]=this.dw_pisq260u_01
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.dw_pisq260u_02
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.cb_reason_ins
this.Control[iCurrent+10]=this.cb_reason_del
this.Control[iCurrent+11]=this.cb_reason_save
this.Control[iCurrent+12]=this.cb_type_save
this.Control[iCurrent+13]=this.cb_type_del
this.Control[iCurrent+14]=this.cb_type_ins
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_3
end on

on w_pisq260u.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.dw_pisq260u_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq260u_02)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_reason_ins)
destroy(this.cb_reason_del)
destroy(this.cb_reason_save)
destroy(this.cb_type_save)
destroy(this.cb_type_del)
destroy(this.cb_type_ins)
destroy(this.gb_2)
destroy(this.gb_3)
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
String	ls_BadReasonCode
long ll_rowcnt

uo_status.st_message.text = ""
// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

// ����Ÿ�� ��ȸ�Ѵ�
//
ll_rowcnt = dw_pisq260u_01.Retrieve(is_AreaCode, is_DivisionCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_BadReasonCode = dw_pisq260u_01.GetItemString(1, 'containbadreasoncode')
dw_pisq260u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_BadReasonCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq260u_01, 1, True)
f_SetHighlight(dw_pisq260u_02, 1, True)


end event

event open;call super::open;
////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : ��ȸ,     ag_02 : �Է�,     ag_03 : ����,     ag_04 : ����,     ag_05 : �μ�
// ag_06 : ó��,     ag_07 : ����,     ag_08 : ����,     ag_09 : ��,       ag_10 : �̸�����
// ag_11 : �����ȸ, ag_12 : �ڷ����, ag_13 : ����ȸ, ag_14 : ȭ���μ�, ag_15 : Ư������ 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
// ������ �������� �缳���Ѵ�
//
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

// Ʈ������� �����Ѵ�
//
dw_pisq260u_01.SetTransObject(SQLPIS)
dw_pisq260u_02.SetTransObject(SQLPIS)

// ó���� ��ȸ�� �ѱ��
//
This.PostEvent("ue_retrieve")

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq260u_01.SetTransObject(SQLPIS)
dw_pisq260u_02.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq260u
integer x = 18
integer width = 3598
end type

type gb_1 from groupbox within w_pisq260u
integer x = 1417
integer y = 2376
integer width = 1344
integer height = 168
integer taborder = 80
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_5 from groupbox within w_pisq260u
integer x = 46
integer y = 2376
integer width = 1344
integer height = 168
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

type dw_pisq260u_01 from u_vi_std_datawindow within w_pisq260u
integer x = 46
integer y = 320
integer width = 1344
integer height = 2040
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq260u_01"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
String	ls_BadReasonCode, ls_flag

//IF currentrow <> 999 THEN
//	IF dw_pisq260u_02.ModifiedCount( ) <> 0 THEN
//		MessageBox('Ȯ ��', '�۾����� �ڷᰡ �ֽ��ϴ�')
//		dw_pisq260u_02.SetColumn('containbadtypecode')
//		dw_pisq260u_02.SetFocus()
//		ls_flag = 'Y'
//		RETURN
//	ELSE
//		ls_flag = 'N'
//	END IF
//END IF

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
if dw_pisq260u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_BadReasonCode = dw_pisq260u_01.GetItemString(dw_pisq260u_01.GetSelectedRow(0), 'containbadreasoncode')
dw_pisq260u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_BadReasonCode)
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq260u_02, 1, True)	







end event

event clicked;call super::clicked;
//This.Trigger Event RowFocusChanged(999)
This.TriggerEvent(RowFocusChanged!)

end event

type uo_area from u_pisc_select_area within w_pisq260u
integer x = 59
integer y = 60
integer taborder = 10
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_empno					��ȸ�ϰ��� �ϴ� ��� (������/���庰 ���ѿ� ���� ��ȸ�� ���Ͽ�)
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� ���� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (�����ڵ�� '%', ������� '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_divisioncode		���õ� ���� �ڵ� (reference)
//						string			rs_divisionname		���õ� ���� �� (reference)
//						string			rs_divisionnameeng	���õ� ���� ���� �� (reference)
//	Returns		: none
//	Description	: ������ �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

// Ʈ������� �����Ѵ�
//
dw_pisq260u_01.SetTransObject(SQLPIS)
dw_pisq260u_02.SetTransObject(SQLPIS)

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow ldw_division
ldw_division = uo_division.dw_1
ls_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq260u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;
// Ʈ������� �����Ѵ�
//
dw_pisq260u_01.SetTransObject(SQLPIS)
dw_pisq260u_02.SetTransObject(SQLPIS)

parent.TriggerEvent('ue_retrieve')
end event

type dw_pisq260u_02 from u_vi_std_datawindow within w_pisq260u
integer x = 1417
integer y = 320
integer width = 1344
integer height = 2040
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq260u_02"
boolean vscrollbar = true
end type

type st_2 from statictext within w_pisq260u
integer x = 91
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< �� �� �� �� >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq260u
integer x = 1463
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< �� �� �� �� >"
boolean focusrectangle = false
end type

type cb_reason_ins from commandbutton within w_pisq260u
integer x = 233
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 80
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
Long	ll_ins_row

uo_status.st_message.text = ""
// ���� �Է����� ���Ѵ�
//
ll_ins_row = dw_pisq260u_01.InsertRow(0)

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
//
messagebox("chk",is_areacode + is_divisioncode)
dw_pisq260u_01.SetItem(ll_ins_row, 'areacode', is_areacode)
dw_pisq260u_01.SetItem(ll_ins_row, 'divisioncode', is_divisioncode)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq260u_01.SetColumn('containbadreasoncode')
dw_pisq260u_01.SetFocus()

// ���� �Է��࿡ ����ǥ�ø� �Ѵ�
//
f_SetHighlight(dw_pisq260u_01, ll_ins_row, True)	

// �ű� �Է°��� �߻��ϸ� �����з��� ����Ÿ�����츦 �ʱ�ȭ�Ѵ�
//
dw_pisq260u_02.ReSet()


end event

type cb_reason_del from commandbutton within w_pisq260u
integer x = 617
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
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
Long	ll_select_row

uo_status.st_message.text = ""
// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq260u_01.GetSelectedRow(0)

// ���õ� ���� �ҷ����� ������ �Ǵ��Ͽ� ���°�츸 ������ �����ϴ�
//
IF dw_pisq260u_02.RowCount() > 0 THEN 
	MessageBox('Ȯ ��', '������ �ҷ������� ���°�츸 ������ �����մϴ�', StopSign!)
	RETURN
END IF

// ���õ� ���� �����Ѵ�
//
dw_pisq260u_01.DeleteRow(dw_pisq260u_01.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq260u_01.RowCount() THEN
	f_SetHighlight(dw_pisq260u_01, dw_pisq260u_01.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq260u_01, ll_select_row, True)	
END IF

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq260u_01.TriggerEvent(RowFocusChanged!)
end event

type cb_reason_save from commandbutton within w_pisq260u
integer x = 1001
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
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
Int	li_save

uo_status.st_message.text = ""
// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq260u_01.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = "����Ǿ����ϴ�."
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF


end event

type cb_type_save from commandbutton within w_pisq260u
integer x = 2373
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 100
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
Int	li_save

uo_status.st_message.text = ""
// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq260u_02.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	uo_status.st_message.text = "����Ǿ����ϴ�."
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF

end event

type cb_type_del from commandbutton within w_pisq260u
integer x = 1989
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
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
Long	ll_select_row

uo_status.st_message.text = ""
// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq260u_02.GetSelectedRow(0)


// ���õ� ���� �����Ѵ�
//
dw_pisq260u_02.DeleteRow(dw_pisq260u_02.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq260u_02.RowCount() THEN
	f_SetHighlight(dw_pisq260u_02, dw_pisq260u_02.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq260u_02, ll_select_row, True)	
END IF

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq260u_02.TriggerEvent(RowFocusChanged!)
end event

type cb_type_ins from commandbutton within w_pisq260u
integer x = 1605
integer y = 2412
integer width = 329
integer height = 104
integer taborder = 90
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
Long		ll_ins_row
String	ls_BadReasonCode

uo_status.st_message.text = ""
if dw_pisq260u_01.GetSelectedRow(0) < 1 then
	uo_status.st_message.text = "�ҷ������� �����Ͻʽÿ�"
	return 0
end if
// ���� �Է����� ���Ѵ�
//
ll_ins_row = dw_pisq260u_02.InsertRow(0)

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
//
ls_badreasoncode = dw_pisq260u_01.GetItemString(dw_pisq260u_01.GetSelectedRow(0), 'containbadreasoncode')
dw_pisq260u_02.SetItem(ll_ins_row, 'areacode'				, is_areacode)
dw_pisq260u_02.SetItem(ll_ins_row, 'divisioncode'			, is_divisioncode)
dw_pisq260u_02.SetItem(ll_ins_row, 'containbadreasoncode', ls_badreasoncode)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq260u_02.SetColumn('containbadtypecode')
dw_pisq260u_02.SetFocus()

// ���� �Է��࿡ ����ǥ�ø� �Ѵ�
//
f_SetHighlight(dw_pisq260u_02, ll_ins_row, True)	


end event

type gb_2 from groupbox within w_pisq260u
integer x = 18
integer y = 188
integer width = 2770
integer height = 2384
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

type gb_3 from groupbox within w_pisq260u
integer x = 18
integer y = 12
integer width = 2770
integer height = 168
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

