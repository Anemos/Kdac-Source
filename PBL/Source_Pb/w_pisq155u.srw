$PBExportHeader$w_pisq155u.srw
$PBExportComments$QC�� ��ǰ�Һз��� ǰ������
forward
global type w_pisq155u from w_ipis_sheet01
end type
type dw_pisq155u_01 from u_vi_std_datawindow within w_pisq155u
end type
type uo_area from u_pisc_select_area within w_pisq155u
end type
type uo_division from u_pisc_select_division within w_pisq155u
end type
type dw_pisq155u_02 from u_vi_std_datawindow within w_pisq155u
end type
type dw_pisq155u_03 from u_vi_std_datawindow within w_pisq155u
end type
type st_2 from statictext within w_pisq155u
end type
type st_3 from statictext within w_pisq155u
end type
type st_4 from statictext within w_pisq155u
end type
type st_5 from statictext within w_pisq155u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisq155u
end type
type dw_pisq155u_04 from u_vi_std_datawindow within w_pisq155u
end type
type dw_pisq155u_05 from u_vi_std_datawindow within w_pisq155u
end type
type st_6 from statictext within w_pisq155u
end type
type pb_1 from picturebutton within w_pisq155u
end type
type dw_print from datawindow within w_pisq155u
end type
type gb_2 from groupbox within w_pisq155u
end type
type gb_3 from groupbox within w_pisq155u
end type
end forward

global type w_pisq155u from w_ipis_sheet01
integer width = 4690
integer height = 2784
string title = "QC�� ��ǰ�Һз��� ǰ������"
dw_pisq155u_01 dw_pisq155u_01
uo_area uo_area
uo_division uo_division
dw_pisq155u_02 dw_pisq155u_02
dw_pisq155u_03 dw_pisq155u_03
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
uo_workcenter uo_workcenter
dw_pisq155u_04 dw_pisq155u_04
dw_pisq155u_05 dw_pisq155u_05
st_6 st_6
pb_1 pb_1
dw_print dw_print
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq155u w_pisq155u

type variables

String	is_AreaCode, is_DivisionCode
Boolean	ib_open


end variables

on w_pisq155u.create
int iCurrent
call super::create
this.dw_pisq155u_01=create dw_pisq155u_01
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq155u_02=create dw_pisq155u_02
this.dw_pisq155u_03=create dw_pisq155u_03
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.uo_workcenter=create uo_workcenter
this.dw_pisq155u_04=create dw_pisq155u_04
this.dw_pisq155u_05=create dw_pisq155u_05
this.st_6=create st_6
this.pb_1=create pb_1
this.dw_print=create dw_print
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq155u_01
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_pisq155u_02
this.Control[iCurrent+5]=this.dw_pisq155u_03
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.uo_workcenter
this.Control[iCurrent+11]=this.dw_pisq155u_04
this.Control[iCurrent+12]=this.dw_pisq155u_05
this.Control[iCurrent+13]=this.st_6
this.Control[iCurrent+14]=this.pb_1
this.Control[iCurrent+15]=this.dw_print
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_3
end on

on w_pisq155u.destroy
call super::destroy
destroy(this.dw_pisq155u_01)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq155u_02)
destroy(this.dw_pisq155u_03)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.uo_workcenter)
destroy(this.dw_pisq155u_04)
destroy(this.dw_pisq155u_05)
destroy(this.st_6)
destroy(this.pb_1)
destroy(this.dw_print)
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
ll_rowcnt = dw_pisq155u_01.Retrieve(is_AreaCode, is_DivisionCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_LargeGroupCode	 = dw_pisq155u_01.GetItemString(1, 'LargeGroupCode')
ll_rowcnt = dw_pisq155u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_MiddleGroupCode = dw_pisq155u_02.GetItemString(1, 'MiddleGroupCode')
ll_rowcnt = dw_pisq155u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)
if ll_rowcnt < 1 then
	return 0
end if
ls_SmallGroupCode	 = dw_pisq155u_03.GetItemString(1, 'SmallGroupCode')

dw_pisq155u_05.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq155u_01, 1, True)	
f_SetHighlight(dw_pisq155u_02, 1, True)	
f_SetHighlight(dw_pisq155u_03, 1, True)	
f_SetHighlight(dw_pisq155u_05, 1, True)	

uo_workcenter.TriggerEvent('ue_select')
end event

event ue_postopen;call super::ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq155u_01.SetTransObject(SQLPIS)
dw_pisq155u_02.SetTransObject(SQLPIS)
dw_pisq155u_03.SetTransObject(SQLPIS)
dw_pisq155u_04.SetTransObject(SQLPIS)
dw_pisq155u_05.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										FALSE, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)

ib_open = True

// ó���� ��ȸ�� �ѱ��
//
This.PostEvent("ue_retrieve")

end event

event ue_delete;call super::ue_delete;
Long	ll_select_row

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq155u_05.GetSelectedRow(0)

// ���õ� ���� �����Ѵ�
//
dw_pisq155u_05.DeleteRow(dw_pisq155u_05.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq155u_05.RowCount() THEN
	f_SetHighlight(dw_pisq155u_05, dw_pisq155u_05.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq155u_05, ll_select_row, True)	
END IF

Int	li_save

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq155u_05.Update()

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

uo_workcenter.TriggerEvent('ue_select')
end event

event ue_save;call super::ue_save;
Int	li_save

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq155u_05.Update()

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

uo_workcenter.TriggerEvent('ue_select')












//
//Int	li_save
//
//// �ʼ��Է� �׸��� üũ�Ѵ�
////
//IF wf_checkcolumn() = FALSE THEN RETURN
//
//// ���������� ���ÿ��θ� üũ�Ѵ�
////
//IF f_checkfinalprocess(dw_pisq150u_04) = 0 THEN 
//	MessageBox('Ȯ ��', '���������� �ݵ�� 1���� �����ؾ� �մϴ�', StopSign!)
//	RETURN
//END IF
//
//// ���������� ���������� üũ�Ѵ�
////
//IF f_checkfinalprocess(dw_pisq150u_04) > 1 THEN 
//	MessageBox('Ȯ ��', '���������� �ݵ�� 1���� �����ؾ� �մϴ�', StopSign!)
//	RETURN
//END IF
//
//// AUTO COMMIT�� FASLE�� ����
////
//SQLPIS.AUTOCommit = FALSE
//
//li_save = dw_pisq150u_04.Update()
//
//IF li_save = 1 THEN
//	// Commit ó��
//	//
//	COMMIT USING SQLPIS;
//ELSE 
//	// RollBack ó��
//	//
//	ROLLBACK USING SQLPIS;
//	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
//END IF
//
//SQLPIS.AUTOCommit = TRUE
//
end event

event ue_print;call super::ue_print;
String	ls_mod
str_easy	lstr_prt

dw_print.Retrieve(is_AreaCode, is_DivisionCode)

//ls_mod	= "st_msg.Text = '" + "������ : " + uo_date.is_uo_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '��ǰ�Һз��� ����ǰ��'
lstr_prt.tag			= '��ǰ�Һз��� ����ǰ��'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq155u_01.SetTransObject(SQLPIS)
dw_pisq155u_02.SetTransObject(SQLPIS)
dw_pisq155u_03.SetTransObject(SQLPIS)
dw_pisq155u_04.SetTransObject(SQLPIS)
dw_pisq155u_05.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq155u
integer x = 18
integer width = 3598
end type

type dw_pisq155u_01 from u_vi_std_datawindow within w_pisq155u
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
if dw_pisq155u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq155u_01.GetItemString(dw_pisq155u_01.GetSelectedRow(0), 'LargeGroupCode')
dw_pisq155u_02.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode)
ls_MiddleGroupCode= dw_pisq155u_02.GetItemString(1, 'MiddleGroupCode')
dw_pisq155u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)
ls_SmallGroupCode	= dw_pisq155u_03.GetItemString(1, 'SmallGroupCode')

dw_pisq155u_05.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq155u_02, 1, True)	
f_SetHighlight(dw_pisq155u_03, 1, True)	
f_SetHighlight(dw_pisq155u_05, 1, True)	



end event

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)

end event

type uo_area from u_pisc_select_area within w_pisq155u
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

If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											FALSE, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)

End If

// Ʈ������� �����Ѵ�
//
dw_pisq155u_01.SetTransObject(SQLPIS)
dw_pisq155u_02.SetTransObject(SQLPIS)
dw_pisq155u_03.SetTransObject(SQLPIS)
dw_pisq155u_04.SetTransObject(SQLPIS)
dw_pisq155u_05.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq155u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;
// Ʈ������� �����Ѵ�
//
dw_pisq155u_01.SetTransObject(SQLPIS)
dw_pisq155u_02.SetTransObject(SQLPIS)
dw_pisq155u_03.SetTransObject(SQLPIS)
dw_pisq155u_04.SetTransObject(SQLPIS)
dw_pisq155u_05.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

If ib_open Then
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											FALSE, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	parent.TriggerEvent('ue_retrieve')
End If


end event

type dw_pisq155u_02 from u_vi_std_datawindow within w_pisq155u
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
if dw_pisq155u_02.GetSelectedRow(0) < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq155u_02.GetItemString(dw_pisq155u_02.GetSelectedRow(0), 'LargeGroupCode')
ls_MiddleGroupCode= dw_pisq155u_02.GetItemString(dw_pisq155u_02.GetSelectedRow(0), 'MiddleGroupCode')
dw_pisq155u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode)
ls_SmallGroupCode	= dw_pisq155u_03.GetItemString(1, 'SmallGroupCode')

dw_pisq155u_05.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq155u_03, 1, True)	
f_SetHighlight(dw_pisq155u_05, 1, True)	


end event

type dw_pisq155u_03 from u_vi_std_datawindow within w_pisq155u
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
if dw_pisq155u_03.GetSelectedRow(0) < 1 then
	return 0
end if
ls_LargeGroupCode	= dw_pisq155u_01.GetItemString(dw_pisq155u_01.GetSelectedRow(0), 'LargeGroupCode')
ls_MiddleGroupCode= dw_pisq155u_02.GetItemString(dw_pisq155u_02.GetSelectedRow(0), 'MiddleGroupCode')
ls_SmallGroupCode	= dw_pisq155u_03.GetItemString(dw_pisq155u_03.GetSelectedRow(0), 'SmallGroupCode')

dw_pisq155u_05.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_MiddleGroupCode, ls_SmallGroupCode)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq155u_05, 1, True)	


end event

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)
end event

type st_2 from statictext within w_pisq155u
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

type st_3 from statictext within w_pisq155u
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

type st_4 from statictext within w_pisq155u
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

type st_5 from statictext within w_pisq155u
integer x = 87
integer y = 1180
integer width = 951
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
string text = "< ����ý�Ʈ ǰ�� >"
boolean focusrectangle = false
end type

type uo_workcenter from u_pisc_select_workcenter within w_pisq155u
event destroy ( )
integer x = 1211
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;
dw_pisq155u_04.ReSet()
dw_pisq155u_04.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, uo_workcenter.is_uo_workcenter)
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq155u_04, 1, True)	

end event

type dw_pisq155u_04 from u_vi_std_datawindow within w_pisq155u
integer x = 46
integer y = 1248
integer width = 1819
integer height = 1300
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisq155u_04"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_pisq155u_05 from u_vi_std_datawindow within w_pisq155u
integer x = 1888
integer y = 1248
integer width = 2715
integer height = 1300
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_pisq155u_05"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;
THIS.SelectRow(0,FALSE)
THIS.SelectRow(row,TRUE)


end event

type st_6 from statictext within w_pisq155u
integer x = 1934
integer y = 1180
integer width = 951
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
string text = "< �Һз��� ǰ��>"
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_pisq155u
integer x = 1646
integer y = 1160
integer width = 219
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string picturename = "C:\kdac\bmp\userright.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row
long	ll_SaveRow[] 

// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_pisq155u_04.GetSelectedRow(0)
IF ll_row = 0 THEN
	// ���õ� ���� ������ ����
	//
	RETURN 0
ELSE
	// ���õ� ���� ã�Ƽ� �迭�� ���õ����� ���ȣ�� �����Ѵ�
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisq155u_04.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// ����ȭ���� ���õ� �ڷḦ ����ȭ������ �̵��Ѵ�
// 
FOR ll_row = 1 TO ll_index - 1
	// ����ȭ�鿡 ���྿�� ����鼭 ����ȭ���� �ڷḦ ����ȭ�鿡 ��Ʈ�Ѵ�
	//
	ll_LastRow = dw_pisq155u_05.InsertRow(0)
	dw_pisq155u_05.SetItem(ll_LastRow, 'AREACODE'			, uo_area.is_uo_areacode)
	dw_pisq155u_05.SetItem(ll_LastRow, 'DIVISIONCODE'		, uo_division.is_uo_divisioncode)
	dw_pisq155u_05.SetItem(ll_LastRow, 'LARGEGROUPCODE'	, dw_pisq155u_01.GetItemString(dw_pisq155u_01.GetSelectedRow(0), 'largegroupcode'))
	dw_pisq155u_05.SetItem(ll_LastRow, 'MIDDLEGROUPCODE'	, dw_pisq155u_02.GetItemString(dw_pisq155u_02.GetSelectedRow(0), 'middlegroupcode'))
	dw_pisq155u_05.SetItem(ll_LastRow, 'SMALLGROUPCODE'	, dw_pisq155u_03.GetItemString(dw_pisq155u_03.GetSelectedRow(0), 'smallgroupcode'))
	dw_pisq155u_05.SetItem(ll_LastRow, 'WORKCENTER'			, uo_workcenter.is_uo_workcenter)
	dw_pisq155u_05.SetItem(ll_LastRow, 'WORKCENTERNAME'	, uo_workcenter.is_uo_workcentername)
	dw_pisq155u_05.SetItem(ll_LastRow, 'ITEMCODE'			, dw_pisq155u_04.GetitemString(ll_SaveRow[ll_row], 'itemcode'))
	dw_pisq155u_05.SetItem(ll_LastRow, 'ITEMNAME'			, dw_pisq155u_04.GetitemString(ll_SaveRow[ll_row], 'itemname'))
	dw_pisq155u_05.SetItem(ll_LastRow, 'SUBLINECODE'		, dw_pisq155u_04.GetitemString(ll_SaveRow[ll_row], 'sublinecode'))
	dw_pisq155u_05.SetItem(ll_LastRow, 'SUBLINENO'			, dw_pisq155u_04.GetitemString(ll_SaveRow[ll_row], 'sublineno'))
	// ����ȭ���� ���õ��࿡ ����ǥ�ø� ��Ʈ�Ѵ�
	//
	dw_pisq155u_04.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq155u_04.GetSelectedRow(0)

// �̵��� ���� ����ȭ���� �������� �����Ѵ�(���� �ǵڿ������� �����Ѵ�)
//
FOR ll_row = dw_pisq155u_04.RowCount() to 1 step -1
	IF dw_pisq155u_04.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq155u_04.DeleteRow(ll_row)
	END IF
NEXT

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq155u_04.RowCount() THEN
	f_SetHighlight(dw_pisq155u_04, dw_pisq155u_04.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq155u_04, ll_select_row, True)	
END IF

f_SetHighlight(dw_pisq155u_05, dw_pisq155u_05.RowCount(), True)	

end event

type dw_print from datawindow within w_pisq155u
boolean visible = false
integer x = 1029
integer y = 328
integer width = 1376
integer height = 704
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq155u_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisq155u
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

type gb_3 from groupbox within w_pisq155u
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

