$PBExportHeader$w_pisq150u.srw
$PBExportComments$QC�� ��ǰ�� ���� �� �������� ���
forward
global type w_pisq150u from w_ipis_sheet01
end type
type dw_pisq150u_01 from u_vi_std_datawindow within w_pisq150u
end type
type uo_area from u_pisc_select_area within w_pisq150u
end type
type uo_division from u_pisc_select_division within w_pisq150u
end type
type dw_pisq150u_02 from u_vi_std_datawindow within w_pisq150u
end type
type dw_pisq150u_03 from u_vi_std_datawindow within w_pisq150u
end type
type st_2 from statictext within w_pisq150u
end type
type st_3 from statictext within w_pisq150u
end type
type st_4 from statictext within w_pisq150u
end type
type st_5 from statictext within w_pisq150u
end type
type dw_pisq150u_04 from u_vi_std_datawindow within w_pisq150u
end type
type gb_2 from groupbox within w_pisq150u
end type
type gb_3 from groupbox within w_pisq150u
end type
end forward

global type w_pisq150u from w_ipis_sheet01
integer width = 4690
integer height = 2784
string title = "QC�� ��ǰ�� ���� �� �������� ���"
dw_pisq150u_01 dw_pisq150u_01
uo_area uo_area
uo_division uo_division
dw_pisq150u_02 dw_pisq150u_02
dw_pisq150u_03 dw_pisq150u_03
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
dw_pisq150u_04 dw_pisq150u_04
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq150u w_pisq150u

type variables

String	is_AreaCode, is_DivisionCode

end variables

forward prototypes
public function boolean wf_checkcolumn ()
end prototypes

public function boolean wf_checkcolumn ();
Int		li_row
Boolean	lb_rtn = TRUE

IF dw_pisq150u_04.AcceptText() <> 1 THEN 	RETURN FALSE

// ��ü�� �ڷḦ üũ�Ѵ�
//
FOR li_row = 1 TO dw_pisq150u_04.RowCount()
	IF f_checknullorspace(dw_pisq150u_04.GetItemString(li_row, 'processcode')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� �����ڵ带 �Է��ϼ���', StopSign!)
		dw_pisq150u_04.SetColumn('processcode')
		lb_rtn = FALSE
		EXIT
	END IF
	IF f_checknullorspace(dw_pisq150u_04.GetItemString(li_row, 'processname')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� �������� �Է��ϼ���', StopSign!)
		dw_pisq150u_04.SetColumn('processname')
		lb_rtn = FALSE
		EXIT
	END IF
	IF dw_pisq150u_04.GetItemNumber(li_row, 'processcost') = 0 OR &
		IsNull(dw_pisq150u_04.GetItemNumber(li_row, 'processcost')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� ���������� �Է��ϼ���', StopSign!)
		dw_pisq150u_04.SetColumn('processcost')
		lb_rtn = FALSE
		EXIT
	END IF
	dw_pisq150u_04.SetItem(li_row,'lastemp',g_s_empno)
	dw_pisq150u_04.SetItem(li_row,'lastdate', f_pisc_get_date_nowtime() )
NEXT

dw_pisq150u_04.ScrollToRow(li_row)
f_SetHighlight(dw_pisq150u_04, li_row, True)	
dw_pisq150u_04.SetFocus()

RETURN lb_rtn

end function

on w_pisq150u.create
int iCurrent
call super::create
this.dw_pisq150u_01=create dw_pisq150u_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq150u_02=create dw_pisq150u_02
this.dw_pisq150u_03=create dw_pisq150u_03
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.dw_pisq150u_04=create dw_pisq150u_04
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq150u_01
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_pisq150u_02
this.Control[iCurrent+5]=this.dw_pisq150u_03
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.dw_pisq150u_04
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_3
end on

on w_pisq150u.destroy
call super::destroy
destroy(this.dw_pisq150u_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq150u_02)
destroy(this.dw_pisq150u_03)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_pisq150u_04)
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
String	ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode
long ll_rowcnt

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
if uo_area.dw_1.GetRow() < 1 then
	return 0
end if
is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

// ����Ÿ�� ��ȸ�Ѵ�
//
ll_rowcnt = dw_pisq150u_01.Retrieve(is_AreaCode, is_DivisionCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_LargeGroupCode	 = dw_pisq150u_01.GetItemString(1, 'LargeGroupCode')
ll_rowcnt = dw_pisq150u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_MiddleGroupCode = dw_pisq150u_02.GetItemString(1, 'MiddleGroupCode')
ll_rowcnt = dw_pisq150u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_SmallGroupCode	 = dw_pisq150u_03.GetItemString(1, 'SmallGroupCode')
ll_rowcnt = dw_pisq150u_04.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode)
if ll_rowcnt < 1 then
	return 0
end if
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq150u_01, 1, True)	
f_SetHighlight(dw_pisq150u_02, 1, True)	
f_SetHighlight(dw_pisq150u_03, 1, True)	
f_SetHighlight(dw_pisq150u_04, 1, True)	


end event

event open;call super::open;
// Ʈ������� �����Ѵ�
//
dw_pisq150u_01.SetTransObject(SQLPIS)
dw_pisq150u_02.SetTransObject(SQLPIS)
dw_pisq150u_03.SetTransObject(SQLPIS)
dw_pisq150u_04.SetTransObject(SQLPIS)

// ó���� ��ȸ�� �ѱ��
//
This.PostEvent("ue_retrieve")

end event

event ue_save;call super::ue_save;
Int	li_save

// �ʼ��Է� �׸��� üũ�Ѵ�
//

IF wf_checkcolumn() = FALSE THEN RETURN

IF dw_pisq150u_04.RowCount() > 0 THEN 
	// ���������� ���ÿ��θ� üũ�Ѵ�
	//
	IF f_checkfinalprocess(dw_pisq150u_04) = 0 THEN 
		MessageBox('Ȯ ��', '���������� �ݵ�� 1���� �����ؾ� �մϴ�', StopSign!)
		RETURN
	END IF
	
	// ���������� ���������� üũ�Ѵ�
	//
	IF f_checkfinalprocess(dw_pisq150u_04) > 1 THEN 
		MessageBox('Ȯ ��', '���������� �ݵ�� 1���� �����ؾ� �մϴ�', StopSign!)
		RETURN
	END IF
END IF

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq150u_04.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	uo_status.st_message.text = "���������� ó���Ǿ����ϴ�."
ELSE 
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF


end event

event ue_insert;call super::ue_insert;
Long		ll_ins_row
String	ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode

// ���� �Է����� ���Ѵ�
//
ll_ins_row = dw_pisq150u_04.InsertRow(0)

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
//
ls_largegroupcode	= dw_pisq150u_03.GetItemString(dw_pisq150u_03.GetSelectedRow(0), 'largegroupcode')
ls_middlegroupcode= dw_pisq150u_03.GetItemString(dw_pisq150u_03.GetSelectedRow(0), 'middlegroupcode')
ls_smallgroupcode	= dw_pisq150u_03.GetItemString(dw_pisq150u_03.GetSelectedRow(0), 'smallgroupcode')

dw_pisq150u_04.SetItem(ll_ins_row, 'areacode'		 , is_areacode)
dw_pisq150u_04.SetItem(ll_ins_row, 'divisioncode'	 , is_divisioncode)
dw_pisq150u_04.SetItem(ll_ins_row, 'largegroupcode' , ls_largegroupcode)
dw_pisq150u_04.SetItem(ll_ins_row, 'middlegroupcode', ls_middlegroupcode)
dw_pisq150u_04.SetItem(ll_ins_row, 'smallgroupcode' , ls_smallgroupcode)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq150u_04.SetColumn('processcode')
dw_pisq150u_04.SetFocus()

// ���� �Է��࿡ ����ǥ�ø� �Ѵ�
//
f_SetHighlight(dw_pisq150u_04, ll_ins_row, True)	

end event

event ue_delete;call super::ue_delete;
Long	ll_select_row

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq150u_04.GetSelectedRow(0)

// ���õ� ���� �����Ѵ�
//
dw_pisq150u_04.DeleteRow(dw_pisq150u_04.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq150u_04.RowCount() THEN
	f_SetHighlight(dw_pisq150u_04, dw_pisq150u_04.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq150u_04, ll_select_row, True)	
END IF

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq150u_01.SetTransObject(SQLPIS)
dw_pisq150u_02.SetTransObject(SQLPIS)
dw_pisq150u_03.SetTransObject(SQLPIS)
dw_pisq150u_04.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq150u
integer x = 18
integer width = 3598
end type

type dw_pisq150u_01 from u_vi_std_datawindow within w_pisq150u
integer x = 46
integer y = 320
integer width = 1819
integer height = 828
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq150u_01"
boolean vscrollbar = true
end type

event rowfocuschanged;
String	ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
if dw_pisq150u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq150u_01.GetItemString(dw_pisq150u_01.GetSelectedRow(0), 'LargeGroupCode')
dw_pisq150u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode)
ls_MiddleGroupCode= dw_pisq150u_02.GetItemString(1, 'MiddleGroupCode')
dw_pisq150u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)
ls_SmallGroupCode	= dw_pisq150u_03.GetItemString(1, 'SmallGroupCode')
dw_pisq150u_04.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq150u_02, 1, True)	
f_SetHighlight(dw_pisq150u_03, 1, True)	
f_SetHighlight(dw_pisq150u_04, 1, True)	



end event

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)

end event

type uo_area from u_pisc_select_area within w_pisq150u
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
dw_pisq150u_01.SetTransObject(SQLPIS)
dw_pisq150u_02.SetTransObject(SQLPIS)
dw_pisq150u_03.SetTransObject(SQLPIS)
dw_pisq150u_04.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq150u
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
dw_pisq150u_01.SetTransObject(SQLPIS)
dw_pisq150u_02.SetTransObject(SQLPIS)
dw_pisq150u_03.SetTransObject(SQLPIS)
dw_pisq150u_04.SetTransObject(SQLPIS)

parent.TriggerEvent('ue_retrieve')
end event

type dw_pisq150u_02 from u_vi_std_datawindow within w_pisq150u
integer x = 1888
integer y = 320
integer width = 1344
integer height = 828
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq150u_02"
boolean vscrollbar = true
end type

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)
end event

event rowfocuschanged;
String	ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
if dw_pisq150u_02.GetSelectedRow(0) < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq150u_02.GetItemString(dw_pisq150u_02.GetSelectedRow(0), 'LargeGroupCode')
ls_MiddleGroupCode= dw_pisq150u_02.GetItemString(dw_pisq150u_02.GetSelectedRow(0), 'MiddleGroupCode')
dw_pisq150u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)
ls_SmallGroupCode	= dw_pisq150u_03.GetItemString(1, 'SmallGroupCode')
dw_pisq150u_04.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq150u_03, 1, True)	
f_SetHighlight(dw_pisq150u_04, 1, True)	


end event

type dw_pisq150u_03 from u_vi_std_datawindow within w_pisq150u
integer x = 3255
integer y = 320
integer width = 1344
integer height = 828
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq150u_03"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
String	ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
if dw_pisq150u_03.GetSelectedRow(0) < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq150u_03.GetItemString(dw_pisq150u_03.GetSelectedRow(0), 'LargeGroupCode')
ls_MiddleGroupCode= dw_pisq150u_03.GetItemString(dw_pisq150u_03.GetSelectedRow(0), 'MiddleGroupCode')
ls_SmallGroupCode	= dw_pisq150u_03.GetItemString(dw_pisq150u_03.GetSelectedRow(0), 'SmallGroupCode')
dw_pisq150u_04.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq150u_04, 1, True)	


end event

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)
end event

type st_2 from statictext within w_pisq150u
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

type st_3 from statictext within w_pisq150u
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

type st_4 from statictext within w_pisq150u
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

type st_5 from statictext within w_pisq150u
integer x = 87
integer y = 1180
integer width = 1335
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
string text = "< QC��ǰ�� �Һз� ���� �� �������� >"
boolean focusrectangle = false
end type

type dw_pisq150u_04 from u_vi_std_datawindow within w_pisq150u
integer x = 46
integer y = 1252
integer width = 4553
integer height = 1300
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq150u_04"
boolean vscrollbar = true
end type

type gb_2 from groupbox within w_pisq150u
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

type gb_3 from groupbox within w_pisq150u
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

