$PBExportHeader$w_pisq445u_back.srw
$PBExportComments$RRPPM ��ǥ�� ���
forward
global type w_pisq445u_back from w_ipis_sheet01
end type
type dw_pisq445u_02 from u_vi_std_datawindow within w_pisq445u_back
end type
type uo_area from u_pisc_select_area within w_pisq445u_back
end type
type uo_division from u_pisc_select_division within w_pisq445u_back
end type
type dw_pisq445u_01 from u_vi_std_datawindow within w_pisq445u_back
end type
type st_2 from statictext within w_pisq445u_back
end type
type st_3 from statictext within w_pisq445u_back
end type
type st_5 from statictext within w_pisq445u_back
end type
type dw_pisq445u_03 from u_vi_std_datawindow within w_pisq445u_back
end type
type sle_date from singlelineedit within w_pisq445u_back
end type
type st_4 from statictext within w_pisq445u_back
end type
type sle_1 from singlelineedit within w_pisq445u_back
end type
type gb_2 from groupbox within w_pisq445u_back
end type
type gb_3 from groupbox within w_pisq445u_back
end type
end forward

global type w_pisq445u_back from w_ipis_sheet01
integer width = 3799
integer height = 3012
string title = "�ҷ��������"
dw_pisq445u_02 dw_pisq445u_02
uo_area uo_area
uo_division uo_division
dw_pisq445u_01 dw_pisq445u_01
st_2 st_2
st_3 st_3
st_5 st_5
dw_pisq445u_03 dw_pisq445u_03
sle_date sle_date
st_4 st_4
sle_1 sle_1
gb_2 gb_2
gb_3 gb_3
end type
global w_pisq445u_back w_pisq445u_back

type variables

String	is_AreaCode, is_DivisionCode

end variables

forward prototypes
public function boolean wf_checkcolumn ()
end prototypes

public function boolean wf_checkcolumn ();
Int		li_row
Boolean	lb_rtn = TRUE

IF dw_pisq445u_03.AcceptText() <> 1 THEN RETURN FALSE

// ��ü�� �ڷḦ üũ�Ѵ�
//
FOR li_row = 1 TO dw_pisq445u_03.RowCount()
	IF f_checknullorspace(dw_pisq445u_03.GetItemString(li_row, 'badtypecode')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� �ҷ������ڵ带 �Է��ϼ���', StopSign!)
		dw_pisq445u_03.SetColumn('badtypecode')
		lb_rtn = FALSE
		EXIT
	END IF
	IF f_checknullorspace(dw_pisq445u_03.GetItemString(li_row, 'badtypename')) = TRUE THEN
		MessageBox('Ȯ ��', String(li_row) + '��°�� �ҷ��������� �Է��ϼ���', StopSign!)
		dw_pisq445u_03.SetColumn('badtypename')
		lb_rtn = FALSE
		EXIT
	END IF
NEXT

dw_pisq445u_03.ScrollToRow(li_row)
f_SetHighlight(dw_pisq445u_03, li_row, True)	
dw_pisq445u_03.SetFocus()

RETURN lb_rtn

end function

on w_pisq445u_back.create
int iCurrent
call super::create
this.dw_pisq445u_02=create dw_pisq445u_02
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq445u_01=create dw_pisq445u_01
this.st_2=create st_2
this.st_3=create st_3
this.st_5=create st_5
this.dw_pisq445u_03=create dw_pisq445u_03
this.sle_date=create sle_date
this.st_4=create st_4
this.sle_1=create sle_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq445u_02
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_pisq445u_01
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.dw_pisq445u_03
this.Control[iCurrent+9]=this.sle_date
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.sle_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
end on

on w_pisq445u_back.destroy
call super::destroy
destroy(this.dw_pisq445u_02)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq445u_01)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.dw_pisq445u_03)
destroy(this.sle_date)
destroy(this.st_4)
destroy(this.sle_1)
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

event ue_retrieve;//
//String	ls_date, ls_customercode
//Long		ll_insrow
//
//// ��ȸ�� �ʿ��� ������ ���Ѵ�
////
//is_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
//is_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
//ls_date				= sle_date.Text
//ls_customercode	= '1'
//
//IF f_checknullorspace(ls_date) = TRUE THEN
//	MessageBox('Ȯ ��', '���س⵵�� �Է��� ��ȸ�ϼ���', StopSign!)
//	sle_date.SetFocus()
//	RETURN
//END IF
//
//// �ű԰����� ���������� Ȯ���Ѵ�(�ű�/�����ǿ� ���� ó������� Ʋ���⶧��)
////
//il_selectcnt = 0
//SELECT count(*)
//  INTO :il_selectcnt
//  FROM TQRRPPMGOALREJECT  A
// WHERE A.AREACODE			= :is_AreaCode
//   AND A.DIVISIONCODE	= :is_DivisionCode
//   AND A.STANDARDYEAR	= :ls_date
//   AND A.CUSTOMERCODE	= :ls_customercode
// USING SQLEIS;
//
//IF il_selectcnt = 0 THEN
//	// �ű԰�
//	//
//	dw_pisq445u_01.dataobject = 'd_pisq445u_03'
//ELSE
//	// ������
//	//
//	dw_pisq445u_01.dataobject = 'd_pisq445u_04'
//END IF
//
//dw_pisq445u_01.SetTransObject(SQLEIS)
//dw_pisq445u_01.Retrieve(is_AreaCode, is_DivisionCode, ls_date)
//
//// �ű԰��϶��� ��Ż�Է¶��� �������� ������ش�
////
//IF il_selectcnt = 0 THEN
//	// �ű԰�
//	//
//	ll_insrow = dw_pisq445u_01.InsertRow(0)
//	dw_pisq445u_01.SetItem(ll_insrow, 'tmstproductgroup_productgroup', 'ZZ')
//	dw_pisq445u_01.SetItem(ll_insrow, 'tmstproductgroup_productgroupname', 'TOTAL')
//ELSE
//	dw_pisq445u_01.SetItem(dw_pisq445u_01.RowCount(), 'tmstproductgroup_productgroupname', 'TOTAL')
//END IF
//
//// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
////
//f_SetHighlight(dw_pisq445u_01, 1, True)	
//
end event

event open;call super::open;
// Ʈ������� �����Ѵ�
//
dw_pisq445u_01.SetTransObject(SQLEIS)
dw_pisq445u_02.SetTransObject(SQLEIS)
dw_pisq445u_03.SetTransObject(SQLEIS)

// ó���� ��ȸ�� �ѱ��
//
This.PostEvent("ue_retrieve")

end event

event ue_insert;call super::ue_insert;
Long		ll_ins_row
String	ls_largegroupcode, ls_codeid

// ���� �Է����� ���Ѵ�
//
ll_ins_row = dw_pisq445u_03.InsertRow(0)

// Ű�κ��� ���� ��ǥ�� Į���� ��Ʈ�Ѵ�
//
ls_largegroupcode	= dw_pisq445u_01.GetItemString(dw_pisq445u_01.GetSelectedRow(0), 'largegroupcode')
ls_codeid			= dw_pisq445u_02.GetItemString(dw_pisq445u_02.GetSelectedRow(0), 'codeid')

dw_pisq445u_03.SetItem(ll_ins_row, 'areacode'		 , is_areacode)
dw_pisq445u_03.SetItem(ll_ins_row, 'divisioncode'	 , is_divisioncode)
dw_pisq445u_03.SetItem(ll_ins_row, 'largegroupcode' , ls_largegroupcode)
dw_pisq445u_03.SetItem(ll_ins_row, 'badreasoncode'	 , ls_codeid)

// ��Ŀ���� �̵��Ѵ�
//
dw_pisq445u_03.SetColumn('badtypecode')
dw_pisq445u_03.SetFocus()

// ���� �Է��࿡ ����ǥ�ø� �Ѵ�
//
f_SetHighlight(dw_pisq445u_03, ll_ins_row, True)	

end event

event ue_delete;call super::ue_delete;
Long	ll_select_row

// ���õ� �ప�� ���Ѵ�
//
ll_select_row = dw_pisq445u_03.GetSelectedRow(0)

// ���õ� ���� �����Ѵ�
//
dw_pisq445u_03.DeleteRow(dw_pisq445u_03.GetSelectedRow(0))

// ����Ÿ�����쿡 ����ǥ�ø� ��Ÿ����
//
IF ll_select_row >= dw_pisq445u_03.RowCount() THEN
	f_SetHighlight(dw_pisq445u_03, dw_pisq445u_03.RowCount(), True)	
ELSE
	f_SetHighlight(dw_pisq445u_03, ll_select_row, True)	
END IF

end event

event ue_save;call super::ue_save;Int	li_save

// �ʼ��Է� �׸��� üũ�Ѵ�
//
IF wf_checkcolumn() = FALSE THEN RETURN

// AUTO COMMIT�� FASLE�� ����
//
SQLEIS.AUTOCommit = FALSE

li_save = dw_pisq445u_03.Update()

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

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq445u_01.SetTransObject(SQLEIS)
dw_pisq445u_02.SetTransObject(SQLEIS)
dw_pisq445u_03.SetTransObject(SQLEIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq445u_back
integer x = 18
integer width = 3598
end type

type dw_pisq445u_02 from u_vi_std_datawindow within w_pisq445u_back
integer x = 1550
integer y = 336
integer width = 1751
integer height = 884
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq445u_02"
boolean vscrollbar = true
end type

event rowfocuschanged;//
//String	ls_LargeGroupCode, ls_codeid
//
//// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
////
//ls_LargeGroupCode	= dw_pisq445u_01.GetItemString(dw_pisq445u_01.GetSelectedRow(0), 'LargeGroupCode')
//dw_pisq445u_02.Retrieve('QCPR01')
//
//ls_codeid 			= dw_pisq445u_02.GetItemString(1, 'codeid')
//dw_pisq445u_03.Retrieve(is_AreaCode, is_DivisionCode, ls_LargeGroupCode, ls_codeid)
//
//// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
////
//f_SetHighlight(dw_pisq445u_02, 1, True)	
//f_SetHighlight(dw_pisq445u_03, 1, True)	
//
//
//
end event

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)

end event

type uo_area from u_pisc_select_area within w_pisq445u_back
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
dw_pisq445u_01.SetTransObject(SQLEIS)
dw_pisq445u_02.SetTransObject(SQLEIS)
dw_pisq445u_03.SetTransObject(SQLEIS)

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

type uo_division from u_pisc_select_division within w_pisq445u_back
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
dw_pisq445u_01.SetTransObject(SQLEIS)
dw_pisq445u_02.SetTransObject(SQLEIS)
dw_pisq445u_03.SetTransObject(SQLEIS)

parent.TriggerEvent('ue_retrieve')
end event

type dw_pisq445u_01 from u_vi_std_datawindow within w_pisq445u_back
integer x = 114
integer y = 320
integer width = 1152
integer height = 904
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq445u_01"
end type

event clicked;call super::clicked;
This.TriggerEvent(RowFocusChanged!)
end event

event rowfocuschanged;
String	ls_custgubun

// �������� �ٲ𶧸��� ���ο� ����Ÿ�� ��ȸ�Ѵ�
//
ls_custgubun = dw_pisq445u_01.GetItemString(dw_pisq445u_01.GetSelectedRow(0), 'codeid')
dw_pisq445u_02.Retrieve(ls_custgubun)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq445u_03, 1, True)	


end event

type st_2 from statictext within w_pisq445u_back
integer x = 128
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
string text = "< �� �� ó �� �� >"
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq445u_back
integer x = 1545
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
string text = "< �� �� ó >"
boolean focusrectangle = false
end type

type st_5 from statictext within w_pisq445u_back
integer x = 187
integer y = 1360
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
string text = "< �� ǥ �� �� �� >"
boolean focusrectangle = false
end type

type dw_pisq445u_03 from u_vi_std_datawindow within w_pisq445u_back
integer x = 69
integer y = 1440
integer width = 3456
integer height = 1060
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_pisq445u_03"
boolean vscrollbar = true
end type

type sle_date from singlelineedit within w_pisq445u_back
integer x = 1513
integer y = 60
integer width = 233
integer height = 72
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
integer limit = 4
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_pisq445u_back
integer x = 1211
integer y = 72
integer width = 302
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���س⵵:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_pisq445u_back
integer x = 2533
integer y = 44
integer width = 859
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisq445u_back
integer x = 18
integer y = 188
integer width = 3657
integer height = 2580
integer taborder = 90
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisq445u_back
integer x = 18
integer y = 12
integer width = 2395
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
borderstyle borderstyle = stylelowered!
end type

