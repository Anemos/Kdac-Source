$PBExportHeader$w_pisq140u.srw
$PBExportComments$QC�� ��ǰ�� �з����
forward
global type w_pisq140u from w_ipis_sheet01
end type
type gb_1 from groupbox within w_pisq140u
end type
type gb_4 from groupbox within w_pisq140u
end type
type gb_5 from groupbox within w_pisq140u
end type
type dw_pisq140u_01 from u_vi_std_datawindow within w_pisq140u
end type
type uo_area from u_pisc_select_area within w_pisq140u
end type
type uo_division from u_pisc_select_division within w_pisq140u
end type
type dw_pisq140u_02 from u_vi_std_datawindow within w_pisq140u
end type
type dw_pisq140u_03 from u_vi_std_datawindow within w_pisq140u
end type
type st_2 from statictext within w_pisq140u
end type
type st_3 from statictext within w_pisq140u
end type
type st_4 from statictext within w_pisq140u
end type
type cb_large_ins from commandbutton within w_pisq140u
end type
type cb_large_del from commandbutton within w_pisq140u
end type
type cb_large_save from commandbutton within w_pisq140u
end type
type cb_middle_save from commandbutton within w_pisq140u
end type
type cb_middle_del from commandbutton within w_pisq140u
end type
type cb_middle_ins from commandbutton within w_pisq140u
end type
type cb_small_ins from commandbutton within w_pisq140u
end type
type cb_small_del from commandbutton within w_pisq140u
end type
type cb_small_save from commandbutton within w_pisq140u
end type
type gb_2 from groupbox within w_pisq140u
end type
type gb_3 from groupbox within w_pisq140u
end type
end forward

global type w_pisq140u from w_ipis_sheet01
integer width = 4690
integer height = 2784
string title = "QC�� ��ǰ�� �з����"
gb_1 gb_1
gb_4 gb_4
gb_5 gb_5
dw_pisq140u_01 dw_pisq140u_01
uo_area uo_area
uo_division uo_division
dw_pisq140u_02 dw_pisq140u_02
dw_pisq140u_03 dw_pisq140u_03
st_2 st_2
st_3 st_3
st_4 st_4
cb_large_ins cb_large_ins
cb_large_del cb_large_del
cb_large_save cb_large_save
cb_middle_save cb_middle_save
cb_middle_del cb_middle_del
cb_middle_ins cb_middle_ins
cb_small_ins cb_small_ins
cb_small_del cb_small_del
cb_small_save cb_small_save
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq140u w_pisq140u

type variables

String	is_AreaCode, is_DivisionCode

end variables

on w_pisq140u.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_5=create gb_5
this.dw_pisq140u_01=create dw_pisq140u_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq140u_02=create dw_pisq140u_02
this.dw_pisq140u_03=create dw_pisq140u_03
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.cb_large_ins=create cb_large_ins
this.cb_large_del=create cb_large_del
this.cb_large_save=create cb_large_save
this.cb_middle_save=create cb_middle_save
this.cb_middle_del=create cb_middle_del
this.cb_middle_ins=create cb_middle_ins
this.cb_small_ins=create cb_small_ins
this.cb_small_del=create cb_small_del
this.cb_small_save=create cb_small_save
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.gb_5
this.Control[iCurrent+4]=this.dw_pisq140u_01
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.dw_pisq140u_02
this.Control[iCurrent+8]=this.dw_pisq140u_03
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.cb_large_ins
this.Control[iCurrent+13]=this.cb_large_del
this.Control[iCurrent+14]=this.cb_large_save
this.Control[iCurrent+15]=this.cb_middle_save
this.Control[iCurrent+16]=this.cb_middle_del
this.Control[iCurrent+17]=this.cb_middle_ins
this.Control[iCurrent+18]=this.cb_small_ins
this.Control[iCurrent+19]=this.cb_small_del
this.Control[iCurrent+20]=this.cb_small_save
this.Control[iCurrent+21]=this.gb_2
this.Control[iCurrent+22]=this.gb_3
end on

on w_pisq140u.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.dw_pisq140u_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq140u_02)
destroy(this.dw_pisq140u_03)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.cb_large_ins)
destroy(this.cb_large_del)
destroy(this.cb_large_save)
destroy(this.cb_middle_save)
destroy(this.cb_middle_del)
destroy(this.cb_middle_ins)
destroy(this.cb_small_ins)
destroy(this.cb_small_del)
destroy(this.cb_small_save)
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

event ue_retrieve;long ll_rowcnt
String	ls_LargeGroupCode, ls_MiddleGroupCode

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
if uo_area.dw_1.GetRow() < 1 then
	return 0
end if
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

// ����Ÿ�� ��ȸ�Ѵ�
// �������� - 2003.03.25
ll_rowcnt = dw_pisq140u_01.Retrieve(is_AreaCode, is_DivisionCode)
if ll_rowcnt < 1 then
	uo_status.st_message.text = "��ȸ�� �ڷᰡ �����ϴ�."
	return 0
else
	uo_status.st_message.text = "��ȸ�Ǿ����ϴ�."
end if
ls_LargeGroupCode = dw_pisq140u_01.GetItemString(1, 'LargeGroupCode')
ll_rowcnt = dw_pisq140u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_MiddleGroupCode = dw_pisq140u_02.GetItemString(1, 'MiddleGroupCode')
ll_rowcnt = dw_pisq140u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)
if ll_rowcnt < 1 then
	return 0
end if	
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq140u_01, 1, True)	
f_SetHighlight(dw_pisq140u_02, 1, True)	
f_SetHighlight(dw_pisq140u_03, 1, True)	


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
dw_pisq140u_01.SetTransObject(SQLPIS)
dw_pisq140u_02.SetTransObject(SQLPIS)
dw_pisq140u_03.SetTransObject(SQLPIS)

// ó���� ��ȸ�� �ѱ��
//
This.PostEvent("ue_retrieve")

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq140u_01.SetTransObject(SQLPIS)
dw_pisq140u_02.SetTransObject(SQLPIS)
dw_pisq140u_03.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq140u
integer x = 18
integer width = 3598
end type

type gb_1 from groupbox within w_pisq140u
integer x = 1536
integer y = 2376
integer width = 1381
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

type gb_4 from groupbox within w_pisq140u
integer x = 2935
integer y = 2376
integer width = 1655
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

type gb_5 from groupbox within w_pisq140u
integer x = 46
integer y = 2376
integer width = 1477
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

type dw_pisq140u_01 from u_vi_std_datawindow within w_pisq140u
integer x = 46
integer y = 320
integer width = 1477
integer height = 2040
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq140u_01"
boolean vscrollbar = true
end type

event rowfocuschanged;long ll_selrow, ll_rowcnt
String	ls_LargeGroupCode, ls_MiddleGroupCode

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
ll_selrow = dw_pisq140u_01.GetSelectedRow(0)
if ll_selrow < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq140u_01.GetItemString(dw_pisq140u_01.GetSelectedRow(0), 'LargeGroupCode')
ll_rowcnt = dw_pisq140u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_MiddleGroupCode= dw_pisq140u_02.GetItemString(1, 'MiddleGroupCode')
dw_pisq140u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq140u_02, 1, True)	
f_SetHighlight(dw_pisq140u_03, 1, True)	



end event

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)

end event

type uo_area from u_pisc_select_area within w_pisq140u
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
dw_pisq140u_01.SetTransObject(SQLPIS)
dw_pisq140u_02.SetTransObject(SQLPIS)
dw_pisq140u_03.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq140u
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
dw_pisq140u_01.SetTransObject(SQLPIS)
dw_pisq140u_02.SetTransObject(SQLPIS)
dw_pisq140u_03.SetTransObject(SQLPIS)

parent.TriggerEvent('ue_retrieve')

end event

type dw_pisq140u_02 from u_vi_std_datawindow within w_pisq140u
integer x = 1536
integer y = 320
integer width = 1367
integer height = 2040
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq140u_02"
boolean vscrollbar = true
end type

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)
end event

event rowfocuschanged;long ll_selrow, ll_rowcnt
String	ls_LargeGroupCode, ls_MiddleGroupCode

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
ll_selrow = dw_pisq140u_02.GetSelectedRow(0)
if ll_selrow < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq140u_02.GetItemString(dw_pisq140u_02.GetSelectedRow(0), 'LargeGroupCode')
ls_MiddleGroupCode= dw_pisq140u_02.GetItemString(dw_pisq140u_02.GetSelectedRow(0), 'MiddleGroupCode')
dw_pisq140u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq140u_03, 1, True)	


end event

type dw_pisq140u_03 from u_vi_std_datawindow within w_pisq140u
integer x = 2921
integer y = 320
integer width = 1669
integer height = 2040
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq140u_03"
boolean vscrollbar = true
end type

type st_2 from statictext within w_pisq140u
integer x = 87
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< QC��ǰ�� ��з� >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq140u
integer x = 1925
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< QC��ǰ�� �ߺз� >"
boolean focusrectangle = false
end type

type st_4 from statictext within w_pisq140u
integer x = 3296
integer y = 236
integer width = 718
integer height = 68
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< QC��ǰ�� �Һз� >"
boolean focusrectangle = false
end type

type cb_large_ins from commandbutton within w_pisq140u
integer x = 224
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

// ���� �Է����� ���Ѵ�
//
uo_status.st_message.text = ""
ll_ins_row = dw_pisq140u_01.InsertRow(0)

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
//
dw_pisq140u_01.SetItem(ll_ins_row, 'areacode', is_areacode)
dw_pisq140u_01.SetItem(ll_ins_row, 'divisioncode', is_divisioncode)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq140u_01.SetColumn('largegroupcode')
dw_pisq140u_01.SetFocus()

// ���� �Է��࿡ ����ǥ�ø� �Ѵ�
//
f_SetHighlight(dw_pisq140u_01, ll_ins_row, True)	

// �ű� �Է°��� �߻��ϸ� �����з��� ����Ÿ�����츦 �ʱ�ȭ�Ѵ�
//
dw_pisq140u_02.ReSet()
dw_pisq140u_03.ReSet()


end event

type cb_large_del from commandbutton within w_pisq140u
integer x = 608
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

// ���õ� �ప�� ���Ѵ�
//
uo_status.st_message.text = ""
ll_select_row = dw_pisq140u_01.GetSelectedRow(0)
if ll_select_row < 1 then
	return 0
end if

// ���õ� ���� �ߺз��� ������ �Ǵ��Ͽ� ���°�츸 ������ �����ϴ�
//
IF dw_pisq140u_02.RowCount() > 0 THEN 
	MessageBox('Ȯ ��', '������ �ߺз��� ���°�츸 ������ �����մϴ�', StopSign!)
	RETURN
END IF

// ���õ� ���� �����Ѵ�
//
dw_pisq140u_01.DeleteRow(dw_pisq140u_01.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq140u_01.RowCount() THEN
	f_SetHighlight(dw_pisq140u_01, dw_pisq140u_01.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq140u_01, ll_select_row, True)	
END IF

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq140u_01.TriggerEvent(RowFocusChanged!)
end event

type cb_large_save from commandbutton within w_pisq140u
integer x = 992
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

// AUTO COMMIT�� FASLE�� ����
//
uo_status.st_message.text = ""
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq140u_01.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = '����Ǿ����ϴ�.'
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = 'ó���� �����߽��ϴ�.'
END IF




end event

type cb_middle_save from commandbutton within w_pisq140u
integer x = 2469
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

li_save = dw_pisq140u_02.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = '����Ǿ����ϴ�.'
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = 'ó���� �����߽��ϴ�.'
END IF



end event

type cb_middle_del from commandbutton within w_pisq140u
integer x = 2085
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
ll_select_row = dw_pisq140u_02.GetSelectedRow(0)
if ll_select_row < 1 then
	return 0
end if
// ���õ� ���� �Һз��� ������ �Ǵ��Ͽ� ���°�츸 ������ �����ϴ�
//
IF dw_pisq140u_03.RowCount() > 0 THEN 
	MessageBox('Ȯ ��', '������ �Һз��� ���°�츸 ������ �����մϴ�', StopSign!)
	RETURN
END IF

// ���õ� ���� �����Ѵ�
//
dw_pisq140u_02.DeleteRow(dw_pisq140u_02.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq140u_02.RowCount() THEN
	f_SetHighlight(dw_pisq140u_02, dw_pisq140u_02.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq140u_02, ll_select_row, True)	
END IF

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq140u_02.TriggerEvent(RowFocusChanged!)
end event

type cb_middle_ins from commandbutton within w_pisq140u
integer x = 1701
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
Long		ll_ins_row, ll_selrow
String	ls_largegroupcode

uo_status.st_message.text = ""
//���� �߰� - 2003.03.25
ll_selrow = dw_pisq140u_01.GetSelectedRow(0)
if ll_selrow < 1 then
	return 0
end if
// ���� �Է����� ���Ѵ�
ll_ins_row = dw_pisq140u_02.InsertRow(0)

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
ls_largegroupcode = dw_pisq140u_01.GetItemString(dw_pisq140u_01.GetSelectedRow(0), 'largegroupcode')
dw_pisq140u_02.SetItem(ll_ins_row, 'areacode'		, is_areacode)
dw_pisq140u_02.SetItem(ll_ins_row, 'divisioncode'	, is_divisioncode)
dw_pisq140u_02.SetItem(ll_ins_row, 'largegroupcode', ls_largegroupcode)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq140u_02.SetColumn('middlegroupcode')
dw_pisq140u_02.SetFocus()

// ���� �Է��࿡ ����ǥ�ø� �Ѵ�
//
f_SetHighlight(dw_pisq140u_02, ll_ins_row, True)	

// �ű� �Է°��� �߻��ϸ� �����з��� ����Ÿ�����츦 �ʱ�ȭ�Ѵ�
//
dw_pisq140u_03.ReSet()

end event

type cb_small_ins from commandbutton within w_pisq140u
integer x = 3218
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
Long		ll_ins_row, ll_selrow
String	ls_largegroupcode, ls_middlegroupcode

uo_status.st_message.text = ""
//���� �߰� - 2003.03.25
ll_selrow = dw_pisq140u_02.GetSelectedRow(0)
if ll_selrow < 1 then
	return 0
end if
// ���� �Է����� ���Ѵ�
ll_ins_row = dw_pisq140u_03.InsertRow(0)

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
ls_largegroupcode  = dw_pisq140u_02.GetItemString(dw_pisq140u_02.GetSelectedRow(0), 'largegroupcode')
ls_middlegroupcode = dw_pisq140u_02.GetItemString(dw_pisq140u_02.GetSelectedRow(0), 'middlegroupcode')
dw_pisq140u_03.SetItem(ll_ins_row, 'areacode'		 , is_areacode)
dw_pisq140u_03.SetItem(ll_ins_row, 'divisioncode'	 , is_divisioncode)
dw_pisq140u_03.SetItem(ll_ins_row, 'largegroupcode' , ls_largegroupcode)
dw_pisq140u_03.SetItem(ll_ins_row, 'middlegroupcode', ls_middlegroupcode)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq140u_03.SetColumn('smallgroupcode')
dw_pisq140u_03.SetFocus()

// ���� �Է��࿡ ����ǥ�ø� �Ѵ�
//
f_SetHighlight(dw_pisq140u_03, ll_ins_row, True)	

end event

type cb_small_del from commandbutton within w_pisq140u
integer x = 3602
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

event clicked;String ls_areacode, ls_divisioncode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
Long	ll_select_row, ll_rowcnt

// ���õ� �ప�� ���Ѵ�
//
uo_status.st_message.text = ""
ll_select_row = dw_pisq140u_03.GetSelectedRow(0)
if ll_select_row < 1 then
	return 0
end if

//�Һз����� ǰ���� ����Ǿ� �ִ� ���� �����ϰ� �����ؾ� ��
// ������ : 2003.09.29
ls_largegroupcode = dw_pisq140u_03.getitemstring(dw_pisq140u_03.GetSelectedRow(0),'largegroupcode')
ls_middlegroupcode = dw_pisq140u_03.getitemstring(dw_pisq140u_03.GetSelectedRow(0),'middlegroupcode')
ls_smallgroupcode = dw_pisq140u_03.getitemstring(dw_pisq140u_03.GetSelectedRow(0),'smallgroupcode')
ls_areacode = dw_pisq140u_03.getitemstring(dw_pisq140u_03.GetSelectedRow(0),'areacode')
ls_divisioncode = dw_pisq140u_03.getitemstring(dw_pisq140u_03.GetSelectedRow(0),'divisioncode')

  SELECT count(*)  
    	INTO :ll_rowcnt  
    	FROM TQSMALLGROUPTOITEM  
   	WHERE ( TQSMALLGROUPTOITEM.AREACODE = :ls_areacode ) AND  
         	( TQSMALLGROUPTOITEM.DIVISIONCODE = :ls_divisioncode ) AND  
         	( TQSMALLGROUPTOITEM.LARGEGROUPCODE = :ls_largegroupcode ) AND  
         	( TQSMALLGROUPTOITEM.MIDDLEGROUPCODE = :ls_middlegroupcode ) AND  
         	( TQSMALLGROUPTOITEM.SMALLGROUPCODE = :ls_smallgroupcode )   
     	using sqlpis;

if ll_rowcnt > 0 then
	uo_status.st_message.text = "�Һз���ǰ�����ῡ�� ǰ���� ������ ������ �����Ͻʽÿ�."
	return 0
end if

// ���õ� ���� �����Ѵ�
//
dw_pisq140u_03.DeleteRow(dw_pisq140u_03.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq140u_03.RowCount() THEN
	f_SetHighlight(dw_pisq140u_03, dw_pisq140u_03.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq140u_03, ll_select_row, True)	
END IF

end event

type cb_small_save from commandbutton within w_pisq140u
integer x = 3986
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

li_save = dw_pisq140u_03.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = '����Ǿ����ϴ�.'
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = 'ó���� �����߽��ϴ�.'
END IF



end event

type gb_2 from groupbox within w_pisq140u
integer x = 18
integer y = 188
integer width = 4613
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

type gb_3 from groupbox within w_pisq140u
integer x = 18
integer y = 12
integer width = 4613
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

