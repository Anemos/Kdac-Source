$PBExportHeader$w_pisq280u.srw
$PBExportComments$Containment �˻���
forward
global type w_pisq280u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq280u
end type
type uo_division from u_pisc_select_division within w_pisq280u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq280u
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisq280u
end type
type dw_pisq280u_01 from u_vi_std_datawindow within w_pisq280u
end type
type dw_pisq280u_02 from u_vi_std_datawindow within w_pisq280u
end type
type dw_pisq280u_03 from u_vi_std_datawindow within w_pisq280u
end type
type gb_1 from groupbox within w_pisq280u
end type
type gb_2 from groupbox within w_pisq280u
end type
end forward

global type w_pisq280u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Containment �˻���"
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
dw_pisq280u_01 dw_pisq280u_01
dw_pisq280u_02 dw_pisq280u_02
dw_pisq280u_03 dw_pisq280u_03
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq280u w_pisq280u

type variables

datawindowchild	idwc_badreason, idwc_badtype
Boolean	ib_open

end variables

forward prototypes
public function boolean wf_checkcolumn ()
end prototypes

public function boolean wf_checkcolumn ();
Long		ll_row
Boolean	lb_rtn = TRUE

IF dw_pisq280u_01.AcceptText() <> 1 THEN RETURN FALSE

// �˻���� üũ
//
FOR ll_row = 1 TO dw_pisq280u_01.RowCount()
	// �˻翩�ΰ� �˻��ΰ�� �˻������ �ԷµǾ�� �Ѵ�
	//
	IF dw_pisq280u_01.GetItemString(ll_row, 'qcflag') = '0' THEN
		IF dw_pisq280u_01.GetItemNumber(ll_row, 'qcqty') = 0 OR &
			IsNull(dw_pisq280u_01.GetItemNumber(ll_row, 'qcqty')) = TRUE THEN
			MessageBox('Ȯ ��', '�˻������ �Է��ϼ���', StopSign!)
			dw_pisq280u_01.ScrollToRow(ll_row)
			f_SetHighlight(dw_pisq280u_01, ll_row, True)	
			dw_pisq280u_01.SetColumn('qcqty')
			dw_pisq280u_01.SetFocus()
			RETURN FALSE
		END IF
	END IF
NEXT

RETURN lb_rtn

end function

on w_pisq280u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.dw_pisq280u_01=create dw_pisq280u_01
this.dw_pisq280u_02=create dw_pisq280u_02
this.dw_pisq280u_03=create dw_pisq280u_03
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_productgroup
this.Control[iCurrent+4]=this.uo_modelgroup
this.Control[iCurrent+5]=this.dw_pisq280u_01
this.Control[iCurrent+6]=this.dw_pisq280u_02
this.Control[iCurrent+7]=this.dw_pisq280u_03
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_pisq280u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.dw_pisq280u_01)
destroy(this.dw_pisq280u_02)
destroy(this.dw_pisq280u_03)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq020i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;call super::ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_prdenddate, ls_kbno, ls_badreason

// ��ȸ������ ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 

IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF

IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF

// ����Ÿ�� ��ȸ�Ѵ�(�˻系��)
//
dw_pisq280u_01.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq280u_01, 1, True)	

// ����Ÿ�� ��ȸ�Ѵ�(�ҷ�����)
//
if dw_pisq280u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_prdenddate		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')
dw_pisq280u_02.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq280u_02, 1, True)	

// ���ϵ� ������ ǥ��(�ҷ�����, �ҷ�����)
//
if idwc_badreason.Retrieve(ls_areacode, ls_DivisionCode) < 1 then
	return 0
end if
ls_badreason = idwc_badreason.GetItemString(1, 'containbadreasoncode')
idwc_badtype.Retrieve(ls_areacode, ls_DivisionCode, ls_badreason)

dw_pisq280u_03.ReSet()

end event

event ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq280u_01.SetTransObject(SQLPIS)
dw_pisq280u_02.SetTransObject(SQLPIS)
dw_pisq280u_03.SetTransObject(SQLPIS)

dw_pisq280u_03.GetChild ('badreasoncode' 	, idwc_badreason)
dw_pisq280u_03.GetChild ('badtypecode' 	, idwc_badtype)

idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)

f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_productgroup.is_uo_productgroup, &
										'%', &
										True, &
										uo_modelgroup.is_uo_modelgroup, &
										uo_modelgroup.is_uo_modelgroupname)
ib_open = True
end event

event ue_insert;call super::ue_insert;
String	ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno
String	ls_itemcode, ls_itemname

// ��ȸ���ڷᰡ ������ ����
//
IF dw_pisq280u_01.RowCount() < 1 THEN RETURN

// ���� �Է����� ���Ѵ�
//
dw_pisq280u_03.ReSet()
dw_pisq280u_03.InsertRow(0)

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
//
ls_areacode  		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'areacode')
ls_DivisionCode	= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'DivisionCode')
ls_prdenddate		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')
ls_itemcode			= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'itemcode')
ls_itemname			= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'tmstitem_itemname')

dw_pisq280u_03.SetItem(1, 'areacode'		, ls_areacode)
dw_pisq280u_03.SetItem(1, 'divisioncode'	, ls_divisioncode)
dw_pisq280u_03.SetItem(1, 'prdenddate'		, ls_prdenddate)
dw_pisq280u_03.SetItem(1, 'kbno'				, ls_kbno)
dw_pisq280u_03.SetItem(1, 'as_itemcode'	, ls_itemcode)
dw_pisq280u_03.SetItem(1, 'as_itemname'	, ls_itemname)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq280u_03.SetColumn('badreasoncode')
dw_pisq280u_03.SetFocus()


end event

event ue_delete;call super::ue_delete;
String	ls_areacode, ls_divisioncode, ls_prdenddate, ls_kbno
Int		li_save

IF dw_pisq280u_03.RowCount() = 0 THEN
	MessageBox('Ȯ ��', '������ ����� �����ϴ�')
	RETURN
END IF


// ��ȸ�� �ʿ��� �⺻�ڷḦ ���Ѵ�
//
ls_areacode			= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'areacode')
ls_divisioncode	= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'divisioncode')
ls_prdenddate		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')

// ���õ� ���� �����Ѵ�
//
dw_pisq280u_03.DeleteRow(1)

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// �ҷ������� �����Ѵ�
//
li_save = dw_pisq280u_03.Update()
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
	RETURN
END IF

// �ҷ����� �ڷḦ ��ȸ�Ѵ�
//
dw_pisq280u_02.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq280u_02, 1, True)	

dw_pisq280u_03.ReSet()

end event

event ue_save;call super::ue_save;
String	ls_areacode, ls_divisioncode, ls_prdenddate, ls_kbno, ls_productgroup, ls_modelgroup
Int	li_save, li_saverow

// �ʼ��Է� �׸��� üũ�Ѵ�
//
IF wf_checkcolumn() = FALSE THEN RETURN

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// �˻系���� �����Ѵ�
//
li_save = dw_pisq280u_01.Update()
IF li_save <> 1 THEN
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
	RETURN
END IF

// �ҷ������� �����Ѵ�
//
li_save = dw_pisq280u_03.Update()
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
	RETURN
END IF

// ��ȸ�� �ʿ��� �⺻�ڷḦ ���Ѵ�
//
ls_areacode			= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'areacode')
ls_divisioncode	= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'divisioncode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 
IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF

IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF

// ��ȸ�� �������� �����Ѵ�
//
li_saverow = dw_pisq280u_01.GetSelectedRow(0)

// ����Ÿ�� ��ȸ�Ѵ�(�˻系��)
//
dw_pisq280u_01.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

IF li_saverow > dw_pisq280u_01.RowCount() THEN
	li_saverow = dw_pisq280u_01.RowCount() 
END IF

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq280u_01, li_saverow, True)	

ls_prdenddate		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')

// ����Ÿ�� ��ȸ�Ѵ�(�ҷ�����)
//
dw_pisq280u_02.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq280u_02, 1, True)	

dw_pisq280u_03.ReSet()
//cb_Ins.TriggerEvent(clicked!)


end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq280u_01.SetTransObject(SQLPIS)
dw_pisq280u_02.SetTransObject(SQLPIS)
dw_pisq280u_03.SetTransObject(SQLPIS)

idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq280u
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq280u
integer x = 59
integer y = 60
integer taborder = 20
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
											True, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)

	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

// Ʈ������� �����Ѵ�
//
dw_pisq280u_01.SetTransObject(SQLPIS)
dw_pisq280u_02.SetTransObject(SQLPIS)
dw_pisq280u_03.SetTransObject(SQLPIS)

idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq280u
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_productgroup
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ�
//						string			fs_productgroup		��ȸ�ϰ��� �ϴ� ��ǰ�� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� ��ǰ�� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (��ǰ���ڵ�� '%', ��ǰ������ '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_productgroup		���õ� ��ǰ�� �ڵ� (reference)
//						string			rs_productgroupname	���õ� ��ǰ�� �� (reference)
//	Returns		: none
//	Description	: ��ǰ���� �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////

If ib_open Then
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)
											
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)

End If

// Ʈ������� �����Ѵ�
//
dw_pisq280u_01.SetTransObject(SQLPIS)
dw_pisq280u_02.SetTransObject(SQLPIS)
dw_pisq280u_03.SetTransObject(SQLPIS)

idwc_badreason.SetTransObject( SQLPIS )
idwc_badtype.SetTransObject( SQLPIS )


end event

type uo_productgroup from u_pisc_select_productgroup within w_pisq280u
integer x = 1198
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_modelgroup
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
//						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
//						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ�
//						string			fs_modelgroup		   ��ȸ�ϰ��� �ϴ� ��ǰ�� �ڵ�
//						string			fs_modelgroup			��ȸ�ϰ��� �ϴ� �𵨱� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
//						boolean			fb_allflag				��ȸ�� �𵨱� ������ 2�� �̻��� Record �� ���
//																		True : '��ü' �׸� ���� (�𵨱��ڵ�� '%', �𵨱����� '��ü')
//																		False : '��ü' �׸� �� ����
//						string			rs_mdoelgroup			���õ� �𵨱� �ڵ� (reference)
//						string			rs_modelgroupname		���õ� �𵨱� �� (reference)
//	Returns		: none
//	Description	: �𵨱��� �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////


If ib_open Then
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisq280u
integer x = 2130
integer y = 60
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
//	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_pisq280u_01 from u_vi_std_datawindow within w_pisq280u
integer x = 41
integer y = 216
integer width = 3753
integer height = 1324
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq280u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;
//This.Trigger Event RowFocusChanged(999)
This.TriggerEvent(RowFocusChanged!)

end event

event rowfocuschanged;call super::rowfocuschanged;
String	ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno

// ��ȸ������ ���Ѵ�
//
if dw_pisq280u_01.GetSelectedRow(0) < 1 then
	return 0
end if
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_prdenddate 		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'prdenddate')
ls_kbno		  		= dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'kbno')

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq280u_02.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno)
// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq280u_02, 1, True)	







end event

event itemchanged;call super::itemchanged;
String	ls_colname, ls_coldata

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// ��з��� �����
	//
	CASE 'qcflag'
		// ��������� �˻������ ��Ʈ�Ѵ�(�˻���, �˻����ڵ� ��Ʈ�Ѵ�)
		//
		IF ls_coldata = '0' THEN
			This.SetItem(row, 'qcqty'	, This.GetItemNumber(row, 'rackqty'))
			This.SetItem(row, 'qcempno', g_s_empno)
			This.SetItem(row, 'qcdate'	, String(f_getsysdatetime(), 'yyyy.mm.dd'))
		ELSE
			This.SetItem(row, 'qcqty'	, 0)
			This.SetItem(row, 'qcempno', '')
			This.SetItem(row, 'qcdate'	, '')
		END IF
END CHOOSE



end event

type dw_pisq280u_02 from u_vi_std_datawindow within w_pisq280u
integer x = 41
integer y = 1552
integer width = 3753
integer height = 812
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq280u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event retrieveend;call super::retrieveend;
String	ls_itemcode, ls_itemname
Long		ll_idx 

dw_pisq280u_02.SetRedraw(FALSE)

ls_itemcode = dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'itemcode')
ls_itemname = dw_pisq280u_01.GetItemString(dw_pisq280u_01.GetSelectedRow(0), 'tmstitem_itemname')

// �˻系���� ���õ� ǰ��, ǰ���� �ҷ����� �Է�ȭ�鿡 ��Ʈ�Ѵ�
//
FOR ll_idx = 1 to rowcount
	dw_pisq280u_02.SetItem(ll_idx, 'as_itemcode', ls_itemcode)
	dw_pisq280u_02.SetItem(ll_idx, 'as_itemname', ls_itemname)
NEXT

dw_pisq280u_02.SetRedraw(TRUE)

end event

event doubleclicked;
String	ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno, ls_badreasoncode, ls_badtypecode
String	ls_itemcode, ls_itemname

// ��ȸ������ ���Ѵ�
//
ls_areacode  		= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'areacode')
ls_DivisionCode	= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'DivisionCode')
ls_prdenddate		= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'prdenddate')
ls_kbno				= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'kbno')
ls_badreasoncode	= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'badreasoncode')
ls_badtypecode		= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'badtypecode')
ls_itemcode			= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'as_itemcode')
ls_itemname			= dw_pisq280u_02.GetItemString(dw_pisq280u_02.GetSelectedRow(0), 'as_itemname')

dw_pisq280u_03.Retrieve(ls_areacode, ls_DivisionCode, ls_prdenddate, ls_kbno, ls_badreasoncode, ls_badtypecode)

idwc_badreason.Retrieve(ls_areacode, ls_DivisionCode)
idwc_badtype.Retrieve(ls_areacode, ls_DivisionCode, ls_badreasoncode)

dw_pisq280u_03.SetItem(1, 'as_itemcode', ls_itemcode)
dw_pisq280u_03.SetItem(1, 'as_itemname', ls_itemname)

end event

type dw_pisq280u_03 from u_vi_std_datawindow within w_pisq280u
integer x = 41
integer y = 2380
integer width = 3753
integer height = 172
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq280u_03"
boolean livescroll = false
end type

event rowfocuschanged;//
end event

event clicked;//
end event

event itemchanged;
String	ls_colname, ls_coldata, ls_areacode, ls_divisioncode, ls_badtypecode

IF dw_pisq280u_03.AcceptText() <> 1 THEN RETURN

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// �ҷ������� �����
	//
	CASE 'badreasoncode'
		ls_areacode			= dw_pisq280u_03.GetItemString(1, 'areacode')
		ls_divisioncode	= dw_pisq280u_03.GetItemString(1, 'divisioncode')
		
		// �ҷ����� ���ϵ������츦  ��ȸ�Ѵ�
		//
		idwc_badtype.Retrieve(ls_AreaCode, ls_DivisionCode, ls_coldata)
		
		ls_badtypecode = idwc_badtype.GetItemString(row, 'badtypecode')

		dw_pisq280u_03.SetItem(row, 'badtypecode', ls_badtypecode)
		
END CHOOSE

end event

type gb_1 from groupbox within w_pisq280u
integer x = 18
integer y = 192
integer width = 3808
integer height = 2384
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

type gb_2 from groupbox within w_pisq280u
integer x = 18
integer y = 12
integer width = 3808
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

