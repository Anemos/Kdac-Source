$PBExportHeader$w_pisq270u.srw
$PBExportComments$Containment ���˻�ǰ ���
forward
global type w_pisq270u from w_ipis_sheet01
end type
type dw_pisq270u_left from u_vi_std_datawindow within w_pisq270u
end type
type dw_pisq270u_right from u_vi_std_datawindow within w_pisq270u
end type
type pb_1 from picturebutton within w_pisq270u
end type
type pb_2 from picturebutton within w_pisq270u
end type
type uo_area from u_pisc_select_area within w_pisq270u
end type
type uo_division from u_pisc_select_division within w_pisq270u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq270u
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisq270u
end type
type st_2 from statictext within w_pisq270u
end type
type st_3 from statictext within w_pisq270u
end type
type gb_1 from groupbox within w_pisq270u
end type
type gb_2 from groupbox within w_pisq270u
end type
end forward

global type w_pisq270u from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Containment ���˻�ǰ ���"
dw_pisq270u_left dw_pisq270u_left
dw_pisq270u_right dw_pisq270u_right
pb_1 pb_1
pb_2 pb_2
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
st_2 st_2
st_3 st_3
gb_1 gb_1
gb_2 gb_2
end type
global w_pisq270u w_pisq270u

type variables

Boolean	ib_open

end variables

on w_pisq270u.create
int iCurrent
call super::create
this.dw_pisq270u_left=create dw_pisq270u_left
this.dw_pisq270u_right=create dw_pisq270u_right
this.pb_1=create pb_1
this.pb_2=create pb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.st_2=create st_2
this.st_3=create st_3
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq270u_left
this.Control[iCurrent+2]=this.dw_pisq270u_right
this.Control[iCurrent+3]=this.pb_1
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.uo_productgroup
this.Control[iCurrent+8]=this.uo_modelgroup
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
end on

on w_pisq270u.destroy
call super::destroy
destroy(this.dw_pisq270u_left)
destroy(this.dw_pisq270u_right)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.st_2)
destroy(this.st_3)
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

event ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup

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

// ����Ÿ�� ��ȸ�Ѵ�(����ȭ��)
//
dw_pisq270u_left.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

// ����Ÿ�� ��ȸ�Ѵ�(����ȭ��)
//
dw_pisq270u_right.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq270u_left, 1, True)	
f_SetHighlight(dw_pisq270u_right, 1, True)	


end event

event ue_postopen;// Ʈ������� �����Ѵ�
//
dw_pisq270u_left.SetTransObject(SQLPIS)
dw_pisq270u_right.SetTransObject(SQLPIS)

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

event ue_save;Int	li_save

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

li_save = dw_pisq270u_right.Update()

IF li_save = 1 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
This.TriggerEvent('ue_retrieve')

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq270u_left.SetTransObject(SQLPIS)
dw_pisq270u_right.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq270u
integer x = 18
integer y = 2592
integer width = 3598
end type

type dw_pisq270u_left from u_vi_std_datawindow within w_pisq270u
integer x = 46
integer y = 300
integer width = 1545
integer height = 2248
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq270u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type dw_pisq270u_right from u_vi_std_datawindow within w_pisq270u
integer x = 1929
integer y = 300
integer width = 2290
integer height = 2248
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_pisq270u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;

String	ls_colname, ls_coldata

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// ��������
	//
	CASE "applydatefrom"
		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('Ȯ ��', '�������ڸ� ��Ȯ�� �Է��Ͻÿ�')
			RETURN 1
		END IF

	// ��������
	//
	CASE "applydateto"
		IF IsDate(ls_coldata) = FALSE THEN
			MessageBox('Ȯ ��', '�������ڸ� ��Ȯ�� �Է��Ͻÿ�')
			RETURN 1
		END IF
END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

type pb_1 from picturebutton within w_pisq270u
integer x = 1609
integer y = 672
integer width = 302
integer height = 188
integer taborder = 20
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
ll_row = dw_pisq270u_left.GetSelectedRow(0)
IF ll_row = 0 THEN
	// ���õ� ���� ������ ����
	//
	RETURN
ELSE
	// ���õ� ���� ã�Ƽ� �迭�� ���õ����� ���ȣ�� �����Ѵ�
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisq270u_left.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// ����ȭ���� ���õ� �ڷḦ ����ȭ������ �̵��Ѵ�
// 
FOR ll_row = 1 TO ll_index - 1
	// ����ȭ�鿡 ���྿�� ����鼭 ����ȭ���� �ڷḦ ����ȭ�鿡 ��Ʈ�Ѵ�
	//
	ll_LastRow = dw_pisq270u_right.InsertRow(0)
	dw_pisq270u_right.SetItem(ll_LastRow, 'AREACODE'			, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_AREACODE'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'DIVISIONCODE'		, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_DIVISIONCODE'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'PRODUCTGROUP'		, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_PRODUCTGROUP'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'MODELGROUP'			, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_MODELGROUP'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'ITEMCODE'			, dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_ITEMCODE'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'TMSTITEM_ITEMNAME', dw_pisq270u_left.GetitemString(ll_SaveRow[ll_row], 'AS_ITEMNAME'))
	// ��������, �������ڿ� �ʱⰪ�� ��Ʈ�Ѵ�(�ý�������, �ƽ�����)
	dw_pisq270u_right.SetItem(ll_LastRow, 'APPLYDATEFROM'		, String(f_getsysdatetime(), 'yyyy.mm.dd'))
	dw_pisq270u_right.SetItem(ll_LastRow, 'APPLYDATETO'		, '2999.12.31')

	// ����ȭ���� ���õ��࿡ ����ǥ�ø� ��Ʈ�Ѵ�
	//
	dw_pisq270u_left.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq270u_left.GetSelectedRow(0)

// �̵��� ���� ����ȭ���� �������� �����Ѵ�(���� �ǵڿ������� �����Ѵ�)
//
FOR ll_row = dw_pisq270u_left.RowCount() to 1 step -1
	IF dw_pisq270u_left.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq270u_left.DeleteRow(ll_row)
	END IF
NEXT

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq270u_left.RowCount() THEN
	f_SetHighlight(dw_pisq270u_left, dw_pisq270u_left.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq270u_left, ll_select_row, True)	
END IF

f_sethighlight(dw_pisq270u_right,dw_pisq270u_right.RowCount(),TRUE)

end event

type pb_2 from picturebutton within w_pisq270u
integer x = 1609
integer y = 1064
integer width = 302
integer height = 188
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string picturename = "C:\kdac\bmp\userleft.bmp"
alignment htextalign = left!
end type

event clicked;
long	ll_row, ll_LastRow, ll_index = 1, ll_select_row
long	ll_SaveRow[] 

// ���õ� ���� �ִ��� üũ�Ѵ�
//
ll_row = dw_pisq270u_right.GetSelectedRow(0)
IF ll_row = 0 THEN
	// ���õ� ���� ������ ����
	//
	RETURN
ELSE
	// ���õ� ���� ã�Ƽ� �迭�� ���õ����� ���ȣ�� �����Ѵ�
	//
	do
		ll_SaveRow[ll_index] = ll_row
		ll_index++
		ll_row = dw_pisq270u_right.GetSelectedRow(ll_row)
	loop while ll_row > 0
END IF

// ������ȭ���� ���õ��࿡ ����ǥ�ø� ��Ʈ�Ѵ�
//
FOR ll_row = 1 TO ll_index - 1
	dw_pisq270u_right.SetItem(ll_SaveRow[ll_row], 'DEL_CHK', 'Y')
NEXT

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq270u_right.GetSelectedRow(0)

// �������� �����Ѵ�(���� �ǵڿ������� �����Ѵ�)
//
FOR ll_row = dw_pisq270u_right.RowCount() to 1 step -1
	IF dw_pisq270u_right.GetItemString(ll_row, 'DEL_CHK') = 'Y' THEN
		dw_pisq270u_right.DeleteRow(ll_row)
	END IF
NEXT

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq270u_right.RowCount() THEN
	f_SetHighlight(dw_pisq270u_right, dw_pisq270u_right.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq270u_right, ll_select_row, True)	
END IF

Parent.TriggerEvent('ue_save')
end event

type uo_area from u_pisc_select_area within w_pisq270u
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
											FALSE, &
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
dw_pisq270u_left.SetTransObject(SQLPIS)
dw_pisq270u_right.SetTransObject(SQLPIS)

end event

event ue_post_constructor;call super::ue_post_constructor;
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


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq270u
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
dw_pisq270u_left.SetTransObject(SQLPIS)
dw_pisq270u_right.SetTransObject(SQLPIS)



end event

type uo_productgroup from u_pisc_select_productgroup within w_pisq270u
integer x = 1198
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event constructor;call super::constructor;
//PostEvent("ue_post_constructor")


PostEvent("ue_select")


end event

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

event ue_post_constructor;//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////	Function		:	f_pisc_retrieve_dddw_modelgroup
////	Access		:	public
////	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
////						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
////						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ�
////						string			fs_modelgroup		   ��ȸ�ϰ��� �ϴ� ��ǰ�� �ڵ�
////						string			fs_modelgroup			��ȸ�ϰ��� �ϴ� �𵨱� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
////						boolean			fb_allflag				��ȸ�� �𵨱� ������ 2�� �̻��� Record �� ���
////																		True : '��ü' �׸� ���� (�𵨱��ڵ�� '%', �𵨱����� '��ü')
////																		False : '��ü' �׸� �� ����
////						string			rs_mdoelgroup			���õ� �𵨱� �ڵ� (reference)
////						string			rs_modelgroupname		���õ� �𵨱� �� (reference)
////	Returns		: none
////	Description	: �𵨱��� �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
//// Company		: DAEWOO Information System Co., Ltd. IAS
//// Author		: Kim Jin-Su
//// Coded Date	: 2002.09.04
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//string ls_areacode, ls_productgroup, ls_DivisionCode, ls_modelgroupcode, ls_modelgroupname
//datawindow 	ldw_modelgroup
//
//ldw_modelgroup 	= uo_modelgroup.dw_1
//ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
//ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
//ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode')
//
//f_pisc_retrieve_dddw_modelgroup(ldw_modelgroup,ls_areacode,ls_DivisionCode,ls_productgroup,'%',true,ls_modelgroupcode,ls_modelgroupname)
//
//

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisq270u
integer x = 2130
integer y = 60
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

type st_2 from statictext within w_pisq270u
integer x = 69
integer y = 228
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< ���˻�ǰ >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq270u
integer x = 1952
integer y = 228
integer width = 457
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 16711680
long backcolor = 12632256
string text = "< ���˻�ǰ >"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisq270u
integer x = 18
integer y = 12
integer width = 4233
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

type gb_2 from groupbox within w_pisq270u
integer x = 18
integer y = 192
integer width = 4233
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

