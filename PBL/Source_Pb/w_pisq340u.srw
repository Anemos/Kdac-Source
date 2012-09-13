$PBExportHeader$w_pisq340u.srw
$PBExportComments$Warrantyǰ �м� SHEET �Է�
forward
global type w_pisq340u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq340u
end type
type uo_division from u_pisc_select_division within w_pisq340u
end type
type dw_pisq340u_01 from u_vi_std_datawindow within w_pisq340u
end type
type gb_2 from groupbox within w_pisq340u
end type
type uo_custcode from u_piss_select_custcode within w_pisq340u
end type
type st_8 from statictext within w_pisq340u
end type
type uo_scustgubun from u_pisc_select_code within w_pisq340u
end type
type uo_date from u_pisc_date_applydate within w_pisq340u
end type
type uo_month from u_pisc_date_scroll_month within w_pisq340u
end type
type uo_month2 from u_pisc_date_scroll_month within w_pisq340u
end type
type rb_field from radiobutton within w_pisq340u
end type
type rb_as from radiobutton within w_pisq340u
end type
type gb_3 from groupbox within w_pisq340u
end type
end forward

global type w_pisq340u from w_ipis_sheet01
integer width = 4933
integer height = 2784
string title = "Warrantyǰ �м� SHEET �Է�"
uo_area uo_area
uo_division uo_division
dw_pisq340u_01 dw_pisq340u_01
gb_2 gb_2
uo_custcode uo_custcode
st_8 st_8
uo_scustgubun uo_scustgubun
uo_date uo_date
uo_month uo_month
uo_month2 uo_month2
rb_field rb_field
rb_as rb_as
gb_3 gb_3
end type
global w_pisq340u w_pisq340u

type variables


string is_custgubun,is_custcode
datawindowchild	idwc_warrantycode
Boolean	ib_open

end variables

forward prototypes
public function boolean wf_checkcolumn ()
end prototypes

public function boolean wf_checkcolumn ();
Long		ll_row
Boolean	lb_rtn = TRUE

// �˻���� üũ
//
FOR ll_row = 1 TO dw_pisq340u_01.RowCount()
	// �˻翩�ΰ� �˻��ΰ�� �˻������ �ԷµǾ�� �Ѵ�
	//
	IF dw_pisq340u_01.GetItemString(ll_row, 'qcflag') = '0' THEN
		IF dw_pisq340u_01.GetItemNumber(ll_row, 'qcqty') = 0 OR &
			IsNull(dw_pisq340u_01.GetItemNumber(ll_row, 'qcqty')) = TRUE THEN
			MessageBox('Ȯ ��', '�˻������ �Է��ϼ���', StopSign!)
			dw_pisq340u_01.ScrollToRow(ll_row)
			f_SetHighlight(dw_pisq340u_01, ll_row, True)	
			dw_pisq340u_01.SetColumn('qcqty')
			dw_pisq340u_01.SetFocus()
			RETURN FALSE
		END IF
	END IF
NEXT

RETURN lb_rtn

end function

on w_pisq340u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq340u_01=create dw_pisq340u_01
this.gb_2=create gb_2
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.uo_scustgubun=create uo_scustgubun
this.uo_date=create uo_date
this.uo_month=create uo_month
this.uo_month2=create uo_month2
this.rb_field=create rb_field
this.rb_as=create rb_as
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq340u_01
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.uo_custcode
this.Control[iCurrent+6]=this.st_8
this.Control[iCurrent+7]=this.uo_scustgubun
this.Control[iCurrent+8]=this.uo_date
this.Control[iCurrent+9]=this.uo_month
this.Control[iCurrent+10]=this.uo_month2
this.Control[iCurrent+11]=this.rb_field
this.Control[iCurrent+12]=this.rb_as
this.Control[iCurrent+13]=this.gb_3
end on

on w_pisq340u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq340u_01)
destroy(this.gb_2)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.uo_scustgubun)
destroy(this.uo_date)
destroy(this.uo_month)
destroy(this.uo_month2)
destroy(this.rb_field)
destroy(this.rb_as)
destroy(this.gb_3)
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
String	ls_areacode, ls_divisioncode, ls_analyzedate, ls_customercode, ls_itemcode
Long		ll_row, ll_rtnrow
integer  li_net

uo_status.st_message.text = ""
//Ȯ���۾� (�߰� 2003.03.25)
if i_s_level = "5" then
	dw_pisq340u_01.accepttext()
	if dw_pisq340u_01.modifiedcount() > 0 then
		li_net=messagebox("Ȯ��",f_message("U090"),question!,yesnocancel!,2)
		if li_net=1 then
			triggerevent("ue_save")
			if i_n_erreturn = -1 then
				return 1
			end if
		elseif li_net=3 then
			return 1
		end if
	end if
end if

// ��ȸ�� �ʿ��� ���� ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_analyzedate		= uo_date.sle_date.Text
ls_customercode	= is_custcode

// Child Retrieve(�м�����ڵ�)
//
ll_row = idwc_warrantycode.Retrieve(ls_AreaCode, ls_DivisionCode, '%')

IF ll_row = 0 THEN 
	MessageBox('Ȯ ��', '�м�����ڵ带 �Է��Ͻ��� ����ϼ���')
	RETURN 
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
ll_rtnrow = dw_pisq340u_01.Retrieve(ls_areacode, ls_divisioncode, ls_analyzedate, ls_customercode)


IF ll_rtnrow = 0 THEN
	uo_status.st_message.text = "��ȸ�� �ڷᰡ �����ϴ�."
	RETURN 0
else
	uo_status.st_message.text = "��ȸ�Ǿ����ϴ�."
END IF

// ��ȸ�� ����Ÿ�� ���ȭ���� ���� ��Ʈ�Ѵ�
//
uo_month.em_date.text	= dw_pisq340u_01.GetItemString(1, 'raisedate')		// �߻���
uo_month2.em_date.Text	= dw_pisq340u_01.GetItemString(1, 'accountdate')	// �����

IF dw_pisq340u_01.GetItemString(1, 'fieldflag') = '1' THEN
	rb_field.Checked	= TRUE																// Field Claim
ELSE 
	rb_as.Checked		= TRUE																// AS Claim
END IF

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq340u_01, 1, True)	

return 0


end event

event ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq340u_01.SetTransObject(SQLPIS)

// Child Datawindow ����(�м�����ڵ�)
//
dw_pisq340u_01.GetChild ('analyzecode' , idwc_warrantycode)

idwc_warrantycode.SetTransObject( SQLPIS )

uo_date.st_name.Text	= '�м���:'
uo_month.st_1.Text	= '�߻���:'
uo_month2.st_1.Text	= '�����:'

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
ib_open = True
end event

event ue_delete;call super::ue_delete;
Long	ll_select_row
uo_status.st_message.text = ""

IF dw_pisq340u_01.RowCount() = 0 THEN
	MessageBox('Ȯ ��', '������ ����� �����ϴ�')
	RETURN
END IF

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq340u_01.GetSelectedRow(0)

// ���õ� ���� �����Ѵ�
//
dw_pisq340u_01.DeleteRow(ll_select_row)

uo_status.st_message.text = "����������� ������ ����Ÿ�� �����˴ϴ�."
// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq340u_01.RowCount() THEN
	f_SetHighlight(dw_pisq340u_01, dw_pisq340u_01.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq340u_01, ll_select_row, True)	
END IF

end event

event ue_insert;
String	ls_areacode, ls_divisioncode, ls_analyzedate, ls_customercode, ls_itemcode
String	ls_raisedate, ls_accountdate, ls_productgroup, ls_customitemcode, ls_fieldflag
Long		ll_row, ll_rtn, ll_seqno
long 		ll_dbmax, ll_rowmax, ll_rowdata, ll_selrow, ll_rowcnt, ll_duplicate

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')

ls_analyzedate		= uo_date.sle_date.Text
ls_customercode	= is_custcode

//�߰�����(kisskim, 2003.02.24) : Child Retrieve(�м�����ڵ�)
ll_row = idwc_warrantycode.Retrieve(ls_AreaCode, ls_DivisionCode,'%')
IF ll_row = 0 THEN 
	MessageBox('Ȯ ��', '�м�����ڵ带 �Է��Ͻ��� ����ϼ���')
	RETURN 
END IF

IF rb_field.Checked = TRUE THEN
	ls_fieldflag = '1'
END IF

IF rb_as.Checked = TRUE THEN
	ls_fieldflag = '2'
END IF

//SerialNo ��������
ll_rowcnt = dw_pisq340u_01.RowCount()

select count(*) into :ll_dbmax
from tqwarrantysheet
where areacode = :ls_areacode and divisioncode = :ls_divisioncode and
	analyzedate = :ls_analyzedate and customercode = :ls_customercode  using sqlpis;

for ll_selrow = 1 to ll_rowcnt
	ll_rowdata = dw_pisq340u_01.getitemnumber(ll_selrow,'seqno')
	//�Էµ� ����Ÿ �߿� �ְ�
	if ll_rowdata > ll_rowmax then
		ll_rowmax = ll_rowdata
	end if
next

If ll_rowmax > ll_dbmax then
	ll_seqno = ll_rowmax + 1
else
	ll_seqno = ll_dbmax + 1
end if

// ���� �Է����� ���Ѵ�
//
ll_row = dw_pisq340u_01.InsertRow(0)

ls_raisedate		= uo_month.em_date.text
ls_accountdate		= uo_month2.em_date.Text

dw_pisq340u_01.SetItem(ll_row, 'areacode'			, ls_areacode)
dw_pisq340u_01.SetItem(ll_row, 'divisioncode'	, ls_divisioncode)
dw_pisq340u_01.SetItem(ll_row, 'analyzedate'		, ls_analyzedate)
dw_pisq340u_01.SetItem(ll_row, 'customercode'	, ls_customercode)
dw_pisq340u_01.SetItem(ll_row, 'seqno'				, ll_seqno)

dw_pisq340u_01.SetItem(ll_row, 'raisedate'		, ls_raisedate)
dw_pisq340u_01.SetItem(ll_row, 'accountdate'		, ls_accountdate)
dw_pisq340u_01.SetItem(ll_row, 'fieldflag'		, ls_fieldflag)
dw_pisq340u_01.SetItem(ll_row, 'lastemp'		, g_s_empno)

// ������ �ű��࿡ ī���Ѵ�
//
IF ll_row > 1 THEN
	dw_pisq340u_01.SetItem(ll_row, 'itemcode'				, &
											 dw_pisq340u_01.GetItemString(ll_row - 1, 'itemcode'))
	dw_pisq340u_01.SetItem(ll_row, 'itemname'				, &
											 dw_pisq340u_01.GetItemString(ll_row - 1, 'itemname'))
	dw_pisq340u_01.SetItem(ll_row, 'productgroup'		, &
											 dw_pisq340u_01.GetItemString(ll_row - 1, 'productgroup'))
	dw_pisq340u_01.SetItem(ll_row, 'productgroupname'	, &
											 dw_pisq340u_01.GetItemString(ll_row - 1, 'productgroupname'))
	dw_pisq340u_01.SetItem(ll_row, 'CUSTOMITEMCODE'		, &
											 dw_pisq340u_01.GetItemString(ll_row - 1, 'CUSTOMITEMCODE'))
	
	
	dw_pisq340u_01.SetItem(ll_row, 'adaptcar'		, &
											 dw_pisq340u_01.GetItemString(ll_row - 1, 'adaptcar'))
	dw_pisq340u_01.SetItem(ll_row, 'modelname'	, &
											 dw_pisq340u_01.GetItemString(ll_row - 1, 'modelname'))
	dw_pisq340u_01.SetItem(ll_row, 'carno'			, &
											 dw_pisq340u_01.GetItemString(ll_row - 1, 'carno'))
//	dw_pisq340u_01.SetItem(ll_row, 'dcrno'			, &
//											 dw_pisq340u_01.GetItemString(ll_row - 1, 'dcrno'))
//	dw_pisq340u_01.SetItem(ll_row, 'repairsite'	, &
//											 dw_pisq340u_01.GetItemString(ll_row - 1, 'repairsite'))
//	dw_pisq340u_01.SetItem(ll_row, 'cardistance'	, &
//											 dw_pisq340u_01.GetItemNumber(ll_row - 1, 'cardistance'))
//	dw_pisq340u_01.SetItem(ll_row, 'lotno'			, &
//											 dw_pisq340u_01.GetItemString(ll_row - 1, 'lotno'))
//	dw_pisq340u_01.SetItem(ll_row, 'outdate'		, &
//											 dw_pisq340u_01.GetItemString(ll_row - 1, 'outdate'))
//	dw_pisq340u_01.SetItem(ll_row, 'repairdate'	, & 
//											 dw_pisq340u_01.GetItemString(ll_row - 1, 'repairdate'))
	// ����ǥ�ø� ��Ÿ����
	//
	f_SetHighlight(dw_pisq340u_01, ll_row, True)	
	dw_pisq340u_01.ScrollToRow(ll_row)
	dw_pisq340u_01.SetColumn('carno')
	dw_pisq340u_01.SetFocus()
ELSE
	// ����ǥ�ø� ��Ÿ����
	//
	f_SetHighlight(dw_pisq340u_01, 1, True)	
	dw_pisq340u_01.SetColumn('adaptcar')
	dw_pisq340u_01.SetFocus()
END IF

end event

event ue_save;call super::ue_save;
String	ls_areacode, ls_divisioncode, ls_prdenddate, ls_kbno, ls_productgroup, ls_modelgroup
Int	li_save

uo_status.st_message.text = ""
dw_pisq340u_01.accepttext()
// �ʼ��Է� �׸��� üũ�Ѵ�
//
IF dw_pisq340u_01.RowCount() < 1 THEN
	MessageBox('Ȯ ��', '������ �ڷᰡ �����ϴ�')
END IF

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

// �����Ѵ�
//
li_save = dw_pisq340u_01.Update()
IF li_save <> 1 THEN
	// RollBack ó��
	//
	ROLLBACK USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
	RETURN 0
else
	uo_status.st_message.text = "����Ǿ����ϴ�."
END IF

SQLPIS.AUTOCommit = TRUE

end event

event activate;
// Ʈ������� �����Ѵ�
//
dw_pisq340u_01.SetTransObject(SQLPIS)
idwc_warrantycode.SetTransObject( SQLPIS )

String ls_codegroup, ls_codegroupname, ls_codename
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)

return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq340u
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq340u
integer x = 50
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
	
End If

// Ʈ������� �����Ѵ�
//
dw_pisq340u_01.SetTransObject(SQLPIS)
idwc_warrantycode.SetTransObject( SQLPIS )

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

//string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
//datawindow 	ldw_division
//ldw_division = uo_division.dw_1
//ls_areacode  = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
//

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq340u
event destroy ( )
integer x = 608
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select();call super::ue_select;// Ʈ������� �����Ѵ�
//
dw_pisq340u_01.SetTransObject(SQLPIS)
idwc_warrantycode.SetTransObject( SQLPIS )

//
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
////	Function		:	f_pisc_retrieve_dddw_productgroup
////	Access		:	public
////	Arguments	:	DataWindow		fdw_1						��ȸ�ϰ��� �ϴ� DDDW Object
////						string			fs_areacode				��ȸ�ϰ��� �ϴ� ����
////						string			fs_divisioncode		��ȸ�ϰ��� �ϴ� ���� �ڵ�
////						string			fs_productgroup		��ȸ�ϰ��� �ϴ� ��ǰ�� �ڵ� (�Ϲ������� '%' �� ����ϵ���)
////						boolean			fb_allflag				��ȸ�� ��ǰ�� ������ 2�� �̻��� Record �� ���
////																		True : '��ü' �׸� ���� (��ǰ���ڵ�� '%', ��ǰ������ '��ü')
////																		False : '��ü' �׸� �� ����
////						string			rs_productgroup		���õ� ��ǰ�� �ڵ� (reference)
////						string			rs_productgroupname	���õ� ��ǰ�� �� (reference)
////	Returns		: none
////	Description	: ��ǰ���� �����ϱ� ���� DDDW �� ��ȸ�ϱ� ���Ͽ�
//// Company		: DAEWOO Information System Co., Ltd. IAS
//// Author		: Kim Jin-Su
//// Coded Date	: 2002.09.04
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//If ib_open Then
//	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											'%', &
//											True, &
//											uo_productgroup.is_uo_productgroup, &
//											uo_productgroup.is_uo_productgroupname)
//											
//	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											uo_productgroup.is_uo_productgroup, &
//											'%', &
//											True, &
//											uo_modelgroup.is_uo_modelgroup, &
//											uo_modelgroup.is_uo_modelgroupname)
//
////	iw_this.TriggerEvent("ue_reset")
//End If
//
//
//
end event

type dw_pisq340u_01 from u_vi_std_datawindow within w_pisq340u
integer x = 50
integer y = 344
integer width = 4530
integer height = 2208
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisq340u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event itemchanged;
String	ls_colname, ls_coldata
String	ls_areacode, ls_divisioncode, ls_analyzedate, ls_customercode, ls_itemcode, ls_smallgroupname
String	ls_itemname, ls_productgroup, ls_productgroupname
long 		ll_data, ll_dbmax, ll_dbdata, ll_rowmax, ll_rowdata, ll_selrow, ll_rowcnt, ll_duplicate

ll_rowcnt = This.rowcount()
// ��ȸ�� �ʿ��� ���� ���Ѵ�
//
ls_areacode  		= this.getitemstring(row,'areacode')
ls_DivisionCode	= this.getitemstring(row,'divisioncode')
ls_analyzedate		= this.getitemstring(row,'analyzedate')
ls_customercode	= this.getitemstring(row,'customercode')
ls_productgroup	= This.GetItemString(row, 'productgroup')

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// ǰ���� �Է��ϸ� �ش��� �׷��ڵ带 �����´�
	//
	CASE 'itemcode'
		// �信�� ǰ��, ��ǰ��, ��ǰ������ ���Ѵ�
		//
		SELECT TOP 1
				 B.ITEMNAME		  	,
				 A.PRODUCTGROUP	,
				 C.PRODUCTGROUPNAME
		  INTO :ls_itemname		, 
				 :ls_productgroup	, 
				 :ls_productgroupname
		  FROM TMSTMODEL A, TMSTITEM B, TMSTPRODUCTGROUP C	
		 WHERE A.AREACODE       = C.AREACODE 
		   AND A.DIVISIONCODE   = C.DIVISIONCODE
			AND A.ITEMCODE       = B.ITEMCODE
			AND A.PRODUCTGROUP   = C.PRODUCTGROUP
		 	AND A.AREACODE			= :ls_areacode
			AND A.DIVISIONCODE	= :ls_DivisionCode
			AND A.ITEMCODE			= :ls_coldata
		 USING SQLPIS;

		IF SQLPIS.SQLCode <> 0 THEN
			MessageBox('Ȯ ��', '�ش��ڵ�� �̵�� �ڵ��Դϴ�', StopSign!)
			This.SetColumn('itemcode')
			This.SetItem(row,ls_colname,'')
			This.SetFocus()
			RETURN 1
		END IF

		// ǰ��, ��ǰ��, ��ǰ������ ȭ�鿡 ǥ���Ѵ�
		//
		This.Setitem(row, 'itemname'			, ls_itemname)
		This.Setitem(row, 'productgroup'		, ls_productgroup)
		This.Setitem(row, 'productgroupname', ls_productgroupname)
		
		//�ش���ǰ���� ���� �м��ڵ� ��ȸ( PGM���� : 2003.03.25)
		idwc_warrantycode.Retrieve(ls_AreaCode, ls_DivisionCode, ls_productgroup + '%')

	// �м��ڵ带 �Է��ϸ� �ش���� �����´�
	//
	CASE 'analyzecode'
		SELECT A.SMALLGROUPNAME  
		  INTO :ls_smallgroupname
		  FROM TQWARRANTYSMALL A
		 WHERE A.AREACODE			= :ls_areacode
		   AND A.DIVISIONCODE	= :ls_DivisionCode
		   AND A.PRODUCTGROUP	= :ls_productgroup
			AND A.LARGEGROUPCODE	= SUBSTRING(:ls_coldata, 1, 1)
			AND A.MIDDLEGROUPCODE= SUBSTRING(:ls_coldata, 2, 1)
			AND A.SMALLGROUPCODE	= SUBSTRING(:ls_coldata, 3, 2)
		USING SQLPIS;

		IF SQLPIS.SQLCode = 0 THEN
			This.Setitem(row, 'smallgroupname', ls_smallgroupname)
		ELSE
			MessageBox('Ȯ ��', 'ǰ���� �ش��ϴ� ��ǰ���� �м��ڵ� ����� ��ǰ���� Ʋ���ų� �̵�� �ڵ��Դϴ�', StopSign!)
			This.Setitem(row, 'analyzecode'	 , '')
			This.Setitem(row, 'smallgroupname', '')
			This.SetColumn('analyzecode')
			This.SetFocus()
			RETURN 1
		END IF
	// �м��ڵ带 �Է��ϸ� �ش���� �����´�
	//
	CASE 'seqno'
		ll_data = long(data)
		ll_rowmax = ll_data
		ll_duplicate = 0
		select count(*) into :ll_dbdata
		from tqwarrantysheet
		where areacode = :ls_areacode and divisioncode = :ls_divisioncode and
			analyzedate = :ls_analyzedate and customercode = :ls_customercode and
			seqno = :ll_data using sqlpis;
		
		select count(*) into :ll_dbmax
		from tqwarrantysheet
		where areacode = :ls_areacode and divisioncode = :ls_divisioncode and
			analyzedate = :ls_analyzedate and customercode = :ls_customercode  using sqlpis;
		
		for ll_selrow = 1 to ll_rowcnt
			if ll_selrow = row then
				continue
			end if
			ll_rowdata = This.getitemnumber(ll_selrow,'seqno')
			//�Էµ� ����Ÿ �߿� �ְ�
			if ll_rowdata > ll_rowmax then
				ll_rowmax = ll_rowdata
			end if
			//�Էµ� ����Ÿ�� ��ġ����
			if ll_rowdata = ll_data then
				ll_duplicate = 1
			end if
		next
		
		if ll_dbdata > 0 or ll_duplicate = 1 then
			MessageBox('Ȯ ��', '�̹� �����ϴ� SerialNo�Դϴ�.', StopSign!)
			if ll_rowmax > ll_dbmax then
				This.setitem(row,'seqno',ll_rowmax + 1)
			else
				This.setitem(row,'seqno',ll_dbmax + 1)
			end if
			return 1
		end if
END CHOOSE

//------------------------------------------------------------------------------
// END OF SCRIPT
//------------------------------------------------------------------------------

end event

type gb_2 from groupbox within w_pisq340u
integer x = 18
integer y = 12
integer width = 4594
integer height = 288
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_custcode from u_piss_select_custcode within w_pisq340u
event destroy ( )
integer x = 2930
integer y = 64
integer width = 987
integer taborder = 50
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
//dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode


end event

type st_8 from statictext within w_pisq340u
integer x = 1993
integer y = 72
integer width = 160
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "����:"
boolean focusrectangle = false
end type

type uo_scustgubun from u_pisc_select_code within w_pisq340u
event destroy ( )
integer x = 2158
integer y = 64
integer width = 713
integer taborder = 40
boolean bringtotop = true
end type

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

event constructor;call super::constructor;postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
//dw_sheet.reset()

end event

event ue_post_constructor;
string ls_custname
//is_custgubun = is_uo_codeid

f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

type uo_date from u_pisc_date_applydate within w_pisq340u
event destroy ( )
integer x = 1234
integer y = 60
integer taborder = 30
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_month from u_pisc_date_scroll_month within w_pisq340u
event destroy ( )
integer x = 50
integer y = 172
integer height = 80
integer taborder = 70
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type uo_month2 from u_pisc_date_scroll_month within w_pisq340u
event destroy ( )
integer x = 718
integer y = 172
integer height = 80
integer taborder = 80
boolean bringtotop = true
end type

on uo_month2.destroy
call u_pisc_date_scroll_month::destroy
end on

type rb_field from radiobutton within w_pisq340u
integer x = 1408
integer y = 172
integer width = 457
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "Field Claim"
boolean checked = true
end type

type rb_as from radiobutton within w_pisq340u
integer x = 1911
integer y = 172
integer width = 347
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "AS Claim"
end type

type gb_3 from groupbox within w_pisq340u
integer x = 23
integer y = 312
integer width = 4594
integer height = 2260
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

