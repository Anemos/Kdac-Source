$PBExportHeader$w_pisq910i.srw
$PBExportComments$���� ������� ��� ����ȭ��(��ڿ�)
forward
global type w_pisq910i from w_ipis_sheet01
end type
type dw_pisq910i from u_vi_std_datawindow within w_pisq910i
end type
type uo_area from u_pisc_select_area within w_pisq910i
end type
type uo_division from u_pisc_select_division within w_pisq910i
end type
type cb_cancel from commandbutton within w_pisq910i
end type
type uo_date from u_pisc_date_applydate within w_pisq910i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq910i
end type
type rb_qcdate from radiobutton within w_pisq910i
end type
type rb_makedate from radiobutton within w_pisq910i
end type
type cb_saveas from commandbutton within w_pisq910i
end type
type cb_print from commandbutton within w_pisq910i
end type
type st_5 from statictext within w_pisq910i
end type
type st_3 from statictext within w_pisq910i
end type
type sle_suppliercode from singlelineedit within w_pisq910i
end type
type sle_itemcode from singlelineedit within w_pisq910i
end type
type sle_itemname from singlelineedit within w_pisq910i
end type
type sle_suppliername from singlelineedit within w_pisq910i
end type
type pb_serch from picturebutton within w_pisq910i
end type
type pb_serch2 from picturebutton within w_pisq910i
end type
type st_4 from statictext within w_pisq910i
end type
type sle_slno from singlelineedit within w_pisq910i
end type
type gb_1 from groupbox within w_pisq910i
end type
end forward

global type w_pisq910i from w_ipis_sheet01
integer width = 4690
integer height = 2136
string title = "�˻缺���� ��Ȳ"
dw_pisq910i dw_pisq910i
uo_area uo_area
uo_division uo_division
cb_cancel cb_cancel
uo_date uo_date
uo_dateto uo_dateto
rb_qcdate rb_qcdate
rb_makedate rb_makedate
cb_saveas cb_saveas
cb_print cb_print
st_5 st_5
st_3 st_3
sle_suppliercode sle_suppliercode
sle_itemcode sle_itemcode
sle_itemname sle_itemname
sle_suppliername sle_suppliername
pb_serch pb_serch
pb_serch2 pb_serch2
st_4 st_4
sle_slno sle_slno
gb_1 gb_1
end type
global w_pisq910i w_pisq910i

type variables

str_pisr_partkb istr_partkb

end variables

on w_pisq910i.create
int iCurrent
call super::create
this.dw_pisq910i=create dw_pisq910i
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cb_cancel=create cb_cancel
this.uo_date=create uo_date
this.uo_dateto=create uo_dateto
this.rb_qcdate=create rb_qcdate
this.rb_makedate=create rb_makedate
this.cb_saveas=create cb_saveas
this.cb_print=create cb_print
this.st_5=create st_5
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_itemcode=create sle_itemcode
this.sle_itemname=create sle_itemname
this.sle_suppliername=create sle_suppliername
this.pb_serch=create pb_serch
this.pb_serch2=create pb_serch2
this.st_4=create st_4
this.sle_slno=create sle_slno
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq910i
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.uo_date
this.Control[iCurrent+6]=this.uo_dateto
this.Control[iCurrent+7]=this.rb_qcdate
this.Control[iCurrent+8]=this.rb_makedate
this.Control[iCurrent+9]=this.cb_saveas
this.Control[iCurrent+10]=this.cb_print
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.sle_suppliercode
this.Control[iCurrent+14]=this.sle_itemcode
this.Control[iCurrent+15]=this.sle_itemname
this.Control[iCurrent+16]=this.sle_suppliername
this.Control[iCurrent+17]=this.pb_serch
this.Control[iCurrent+18]=this.pb_serch2
this.Control[iCurrent+19]=this.st_4
this.Control[iCurrent+20]=this.sle_slno
this.Control[iCurrent+21]=this.gb_1
end on

on w_pisq910i.destroy
call super::destroy
destroy(this.dw_pisq910i)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cb_cancel)
destroy(this.uo_date)
destroy(this.uo_dateto)
destroy(this.rb_qcdate)
destroy(this.rb_makedate)
destroy(this.cb_saveas)
destroy(this.cb_print)
destroy(this.st_5)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_itemcode)
destroy(this.sle_itemname)
destroy(this.sle_suppliername)
destroy(this.pb_serch)
destroy(this.pb_serch2)
destroy(this.st_4)
destroy(this.sle_slno)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq910i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_itemcode, ls_datefm, ls_dateto
String	ls_slno, ls_chkflag

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
//ls_datefm			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
//ls_dateto			= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')
ls_datefm			= '1900.01.01'
ls_dateto			= '2999.12.31'
ls_SupplierCode	= sle_suppliercode.Text + '%'
ls_itemcode			= sle_itemcode.Text + '%'
ls_slno				= sle_slno.Text + '%'

IF rb_qcdate.Checked THEN
	ls_chkflag = '1'
END IF
IF rb_makedate.Checked THEN
	ls_chkflag = '2'
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq910i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_itemcode, ls_datefm, ls_dateto, ls_chkflag, ls_slno)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq910i, 1, True)	
 
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


end event

event ue_postopen;call super::ue_postopen;
// Ʈ������� �����Ѵ�
//
dw_pisq910i.SetTransObject(SQLPIS)


end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq910i.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq910i
integer x = 18
integer width = 3598
end type

type dw_pisq910i from u_vi_std_datawindow within w_pisq910i
integer x = 18
integer y = 292
integer width = 1993
integer height = 1596
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_pisq910i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
//cb_print.TriggerEvent(Clicked!)
end event

type uo_area from u_pisc_select_area within w_pisq910i
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
dw_pisq910i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq910i
event destroy ( )
integer x = 544
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
dw_pisq910i.SetTransObject(SQLPIS)

end event

type cb_cancel from commandbutton within w_pisq910i
integer x = 4206
integer y = 44
integer width = 384
integer height = 196
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�������"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_Deliveryno, ls_ItemCode
String	ls_chargename, ls_null

SetNull(ls_null)

// ����� ������ ó���� ���� �ʴ´�
//
IF dw_pisq910i.GetSelectedRow(0) = 0 THEN
	MessageBox('Ȯ ��', '����� �����ϴ�', StopSign!)
	RETURN
END IF

// ������ҿ� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "SupplierCode")
ls_Deliveryno		= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "Deliveryno")
ls_ItemCode			= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "ItemCode")
ls_chargename		= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "chargename")

IF Trim(ls_chargename) = '������' THEN
	// �ۼ��ڸ��� '������'�ΰ��� ������ ���� �ڵ� �ۼ��Ȱ��̹Ƿ� �������� �����Ѵ�
	//

	// AUTO COMMIT�� FASLE�� ����
	//
	SQLPIS.AUTOCommit = FALSE
	
	DELETE FROM TQQCRESULT
	 WHERE AREACODE		= :ls_AreaCode
		AND DIVISIONCODE	= :ls_DivisionCode
		AND SUPPLIERCODE	= :ls_SupplierCode
		AND DELIVERYNO		= :ls_Deliveryno
		AND ITEMCODE		= :ls_ItemCode
	 USING SQLPIS;
	
	IF SQLPIS.SQLCode = 0 THEN
		COMMIT USING SQLPIS;
		SQLPIS.AUTOCommit = TRUE
		MessageBox('Ȯ ��', '�������� �����Ǿ����ϴ�')
	ELSE
		ROLLBACK USING SQLPIS;
		SQLPIS.AUTOCommit = TRUE
		MessageBox('Ȯ ��', '���ؼ� ����ó���� �����߽��ϴ�.')
	END IF
ELSE
	// �ۼ��ڸ��� '������'�� �ƴѰ��� ��ü���� �ۼ��� �������̹Ƿ� �ʱ�ȭ ó���Ѵ�
	//

	// AUTO COMMIT�� FASLE�� ����
	//
	SQLPIS.AUTOCommit = FALSE
	
	UPDATE TQQCRESULT  
		SET JUDGEFLAG		= '9',   
			 GOODQTY			= 0,   
			 BADQTY			= 0,   
			 BADREASON		= :ls_null,   
			 BADMEMO			= :ls_null,   
			 INSPECTORCODE	= :ls_null,   
			 CONFIRMCODE	= :ls_null,   
			 CONFIRMFLAG	= 'N',   
			 QCDATE			= :ls_null,   
			 QCTIME			= :ls_null,   
			 QCLEADTIME		= :ls_null,   
			 SLNO				= '',   
			 DELIVERYDATE	= :ls_null,   
			 DELIVERYTIME	= :ls_null,   
			 LastEmp			= :ls_null  
	 WHERE AREACODE		= :ls_AreaCode
		AND DIVISIONCODE	= :ls_DivisionCode
		AND SUPPLIERCODE	= :ls_SupplierCode
		AND DELIVERYNO		= :ls_Deliveryno
		AND ITEMCODE		= :ls_ItemCode
	 USING SQLPIS;
	
	IF SQLPIS.SQLCode = 0 THEN
		COMMIT USING SQLPIS;
		SQLPIS.AUTOCommit = TRUE
		MessageBox('Ȯ ��', '�������� �ʱ�ȭ ó�� �Ǿ����ϴ�')
	ELSE
		ROLLBACK USING SQLPIS;
		SQLPIS.AUTOCommit = TRUE
		MessageBox('Ȯ ��', '������ �ʱ�ȭ ó���� �����߽��ϴ�.')
	END IF
END IF

Parent.TriggerEvent('ue_retrieve')
end event

type uo_date from u_pisc_date_applydate within w_pisq910i
event destroy ( )
boolean visible = false
integer x = 2107
integer y = 340
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_dateto from u_pisc_date_applydate_1 within w_pisq910i
event destroy ( )
boolean visible = false
integer x = 2112
integer y = 336
boolean bringtotop = true
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

type rb_qcdate from radiobutton within w_pisq910i
boolean visible = false
integer x = 2203
integer y = 316
integer width = 352
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�˻�����"
boolean checked = true
end type

type rb_makedate from radiobutton within w_pisq910i
boolean visible = false
integer x = 2185
integer y = 324
integer width = 352
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�ۼ�����"
end type

type cb_saveas from commandbutton within w_pisq910i
boolean visible = false
integer x = 3520
integer y = 352
integer width = 448
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "������������"
end type

event clicked;
dw_pisq910i.SaveAs()



end event

type cb_print from commandbutton within w_pisq910i
boolean visible = false
integer x = 3026
integer y = 356
integer width = 416
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "������ ���"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_Deliveryno, ls_ItemCode

// ��´���� ������ ó���� ���� �ʴ´�
//
IF dw_pisq910i.GetSelectedRow(0) = 0 THEN
	MessageBox('Ȯ ��', '��´���� �����ϴ�', StopSign!)
	RETURN
END IF

// ���ؼ���¿� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "SupplierCode")
ls_Deliveryno		= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "Deliveryno")
ls_ItemCode			= dw_pisq910i.GetItemString(dw_pisq910i.GetSelectedRow(0), "ItemCode")

// �ν��Ͻ� ��Ʈ���Ŀ� ���� �����Ѵ�
//
istr_parms.String_arg[1] = ls_AreaCode
istr_parms.String_arg[2] = ls_DivisionCode
istr_parms.String_arg[3] = ls_SupplierCode
istr_parms.String_arg[4] = ls_Deliveryno
istr_parms.String_arg[5] = ls_ItemCode

// �˻缺���� ���γ��� ȭ�� ����
//
OpenWithParm(w_pisq117p, istr_parms)

end event

type st_5 from statictext within w_pisq910i
integer x = 1618
integer y = 172
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "ǰ��:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisq910i
integer x = 50
integer y = 172
integer width = 293
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
string text = "���¾�ü:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_suppliercode from singlelineedit within w_pisq910i
integer x = 352
integer y = 160
integer width = 320
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 5
borderstyle borderstyle = stylelowered!
end type

event modified;
// ��ü���� ���Ѵ�
//
sle_suppliername.Text = f_getsuppliername(sle_suppliercode.Text)



end event

type sle_itemcode from singlelineedit within w_pisq910i
integer x = 1806
integer y = 160
integer width = 425
integer height = 72
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event modified;
sle_itemname.Text = f_getitemname(sle_itemcode.Text)

end event

type sle_itemname from singlelineedit within w_pisq910i
integer x = 2235
integer y = 160
integer width = 786
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type sle_suppliername from singlelineedit within w_pisq910i
integer x = 677
integer y = 160
integer width = 663
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_serch from picturebutton within w_pisq910i
integer x = 1339
integer y = 152
integer width = 238
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag		= 2			//���־�ü(����,����)
istr_partkb.remark	= sle_suppliercode.Text

OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_suppliercode.Text = lstr_Rtn.code
sle_suppliername.Text = lstr_Rtn.name


end event

type pb_serch2 from picturebutton within w_pisq910i
integer x = 3026
integer y = 152
integer width = 238
integer height = 96
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean default = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;
str_pisr_return lstr_Rtn

istr_partkb.areacode = uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.divcode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
istr_partkb.flag = 2			// ��üǰ��
OpenWithParm ( w_pisr013i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_itemcode.Text = lstr_Rtn.code
sle_itemname.Text = lstr_Rtn.name

end event

type st_4 from statictext within w_pisq910i
integer x = 1088
integer y = 72
integer width = 494
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
string text = "�ŷ���ǥ��ȣ:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_slno from singlelineedit within w_pisq910i
integer x = 1591
integer y = 60
integer width = 425
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
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event modified;
sle_itemname.Text = f_getitemname(sle_itemcode.Text)

end event

type gb_1 from groupbox within w_pisq910i
integer x = 18
integer y = 12
integer width = 4613
integer height = 264
integer taborder = 100
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

