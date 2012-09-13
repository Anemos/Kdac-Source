$PBExportHeader$w_pisq120i.srw
$PBExportComments$������Ȳ �� ��ǰǥ���
forward
global type w_pisq120i from w_ipis_sheet01
end type
type dw_pisq120i from u_vi_std_datawindow within w_pisq120i
end type
type cb_print from commandbutton within w_pisq120i
end type
type dw_print from datawindow within w_pisq120i
end type
type uo_area from u_pisc_select_area within w_pisq120i
end type
type uo_division from u_pisc_select_division within w_pisq120i
end type
type st_2 from statictext within w_pisq120i
end type
type sle_date from singlelineedit within w_pisq120i
end type
type st_3 from statictext within w_pisq120i
end type
type sle_suppliercode from singlelineedit within w_pisq120i
end type
type sle_suppliername from singlelineedit within w_pisq120i
end type
type cbx_reprint from checkbox within w_pisq120i
end type
type pb_serch from picturebutton within w_pisq120i
end type
type gb_1 from groupbox within w_pisq120i
end type
end forward

global type w_pisq120i from w_ipis_sheet01
integer width = 4699
integer height = 2136
string title = "������Ȳ �� ��ǰǥ���"
dw_pisq120i dw_pisq120i
cb_print cb_print
dw_print dw_print
uo_area uo_area
uo_division uo_division
st_2 st_2
sle_date sle_date
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
cbx_reprint cbx_reprint
pb_serch pb_serch
gb_1 gb_1
end type
global w_pisq120i w_pisq120i

type variables

str_pisr_partkb istr_partkb
end variables

on w_pisq120i.create
int iCurrent
call super::create
this.dw_pisq120i=create dw_pisq120i
this.cb_print=create cb_print
this.dw_print=create dw_print
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.sle_date=create sle_date
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.cbx_reprint=create cbx_reprint
this.pb_serch=create pb_serch
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq120i
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.dw_print
this.Control[iCurrent+4]=this.uo_area
this.Control[iCurrent+5]=this.uo_division
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.sle_date
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.sle_suppliercode
this.Control[iCurrent+10]=this.sle_suppliername
this.Control[iCurrent+11]=this.cbx_reprint
this.Control[iCurrent+12]=this.pb_serch
this.Control[iCurrent+13]=this.gb_1
end on

on w_pisq120i.destroy
call super::destroy
destroy(this.dw_pisq120i)
destroy(this.cb_print)
destroy(this.dw_print)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.sle_date)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.cbx_reprint)
destroy(this.pb_serch)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq120i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_DeliveryDate, ls_PrintFlag

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_SupplierCode	= sle_suppliercode.Text + '%'
ls_ItemCode			= '%'
ls_DeliveryDate	= sle_date.Text + '%'

IF cbx_reprint.Checked = TRUE THEN
	ls_PrintFlag	= '%'
ELSE
	ls_PrintFlag	= 'N'
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq120i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_DeliveryDate, ls_SupplierCode, ls_ItemCode, ls_PrintFlag)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq120i, 1, True)	


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
dw_pisq120i.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

//sle_date.Text = String(f_getsysdatetime(), 'yyyy.mm.dd')

end event

event ue_print;call super::ue_print;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode
String	ls_PrintFlag, ls_RePrint

// �۾������ ������ ó���� ���� �ʴ´�
//
IF dw_pisq120i.GetSelectedRow(0) = 0 THEN
	MessageBox('Ȯ ��', '�۾������ �����ϴ�', StopSign!)
	RETURN
END IF

IF dw_pisq120i.AcceptText() <> 1 THEN RETURN

// ��ǰǥ ��¿� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "AreaCode")
ls_DivisionCode	= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "DivisionCode")
ls_SupplierCode	= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "SupplierCode")
ls_DeliveryNo		= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "DeliveryNo")
ls_ItemCode			= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "ItemCode")

ls_PrintFlag		= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "PrintFlag")
ls_RePrint			= dw_pisq120i.GetItemString(dw_pisq120i.GetSelectedRow(0), "as_RePrint")

// ��¿��θ� Ȯ���Ѵ�(������� üũ�� �ȵ� ��°��� ����Ҽ�����)
// 
IF ls_PrintFlag = 'Y' AND ls_RePrint = 'N' THEN
	MessageBox('Ȯ ��', '����� �ڷ��Դϴ�~r~n����� �Ͻ÷��� ������� üũ�� ������ּ���', StopSign!)
	RETURN
END IF

// ����ڷḦ ǥ���Ѵ�
//
dw_print.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode)


//dw_print.modify("t_3.text   	= '" + ls_DeliveryNo + "'")

transaction	ls_trans
str_easy		lstr_prt
window		lw_open

ls_trans	= SQLPIS

// �μ� DataWindow ����
//
lstr_prt.transaction	=	ls_trans
lstr_prt.datawindow	= 	dw_print
lstr_prt.title			= 	"��ǰǥ ���"
lstr_prt.tag			= 	This.ClassName()
//lstr_prt.dwsyntax = "t_3.text   	= '" + ls_DeliveryNo + "'"

f_close_report("2", lstr_prt.title)						// Open�� ���Window �ݱ�
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

UPDATE TQQCRESULT 
	SET PRINTFLAG		= 'Y'  
 WHERE AREACODE		= :ls_AreaCode
	AND DIVISIONCODE	= :ls_DivisionCode
	AND SUPPLIERCODE	= :ls_SupplierCode
	AND DELIVERYNO		= :ls_DeliveryNo
	AND ITEMCODE		= :ls_ItemCode	USING SQLPIS;

// AUTO COMMIT�� FASLE�� ����
//
SQLPIS.AUTOCommit = FALSE

IF SQLPIS.SQLCode = 0 THEN
	// Commit ó��
	//
	COMMIT USING SQLPIS;
	SQLPIS.AUTOCommit = TRUE
ELSE 
	// RollBack ó��
	//
	RollBack using SQLPIS ;
	SQLPIS.AUTOCommit = TRUE
	MessageBox('Ȯ ��', 'ó���� �����߽��ϴ�')
END IF

// ó���� �Ϸ��� ȭ���� �ڷḦ �ٽ� ǥ���Ѵ�
//
This.TriggerEvent("ue_retrieve")

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq120i.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq120i
integer x = 18
integer width = 3598
end type

type dw_pisq120i from u_vi_std_datawindow within w_pisq120i
integer x = 18
integer y = 196
integer width = 3589
integer height = 1692
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pisq120i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
IF left(This.GetBandAtPointer(), 6) <> 'header' THEN
	// ó���� ��ǰǥ ���ó���� �Ѱ��ش�
	//
	cb_print.TriggerEvent (Clicked!)
END IF
end event

type cb_print from commandbutton within w_pisq120i
integer x = 4187
integer y = 44
integer width = 407
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "ȭ�����"
end type

event clicked;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_DeliveryNo, ls_ItemCode
String	ls_PrintFlag, ls_RePrint

// �۾������ ������ ó���� ���� �ʴ´�
//
IF dw_pisq120i.RowCount() = 0 THEN
	MessageBox('Ȯ ��', '�۾������ �����ϴ�', StopSign!)
	RETURN
END IF

IF dw_pisq120i.AcceptText() <> 1 THEN RETURN

transaction	ls_trans
str_easy		lstr_prt
window		lw_open

ls_trans	= SQLPIS

// �μ� DataWindow ����
//
lstr_prt.transaction	=	ls_trans
lstr_prt.datawindow	= 	dw_pisq120i
lstr_prt.title			= 	"������Ȳ ���"
lstr_prt.tag			= 	Parent.ClassName()

f_close_report("2", lstr_prt.title)						// Open�� ���Window �ݱ�
Opensheetwithparm(lw_open, lstr_prt, "w_prt", w_frame, 0, Layered!)

end event

type dw_print from datawindow within w_pisq120i
boolean visible = false
integer x = 41
integer y = 268
integer width = 2414
integer height = 1480
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq120i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_area from u_pisc_select_area within w_pisq120i
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
dw_pisq120i.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq120i
event destroy ( )
integer x = 576
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
dw_pisq120i.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

end event

type st_2 from statictext within w_pisq120i
integer x = 1166
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
string text = "��ǰ����:"
boolean focusrectangle = false
end type

type sle_date from singlelineedit within w_pisq120i
integer x = 1467
integer y = 60
integer width = 375
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
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event modified;
IF f_checknullorspace(sle_date.Text) = FALSE THEN
	IF IsDate(sle_date.Text) = FALSE THEN
		MessageBox('Ȯ ��', '���ڸ� �ٸ��� �Է��ϼ���', StopSign!)
		sle_date.SetFocus()
	END IF
END IF

end event

type st_3 from statictext within w_pisq120i
integer x = 1902
integer y = 72
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
boolean focusrectangle = false
end type

type sle_suppliercode from singlelineedit within w_pisq120i
integer x = 2199
integer y = 60
integer width = 215
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

type sle_suppliername from singlelineedit within w_pisq120i
integer x = 2427
integer y = 60
integer width = 718
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
borderstyle borderstyle = stylelowered!
end type

type cbx_reprint from checkbox within w_pisq120i
integer x = 3552
integer y = 64
integer width = 448
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
string text = "��°�����:"
boolean lefttext = true
end type

type pb_serch from picturebutton within w_pisq120i
integer x = 3145
integer y = 48
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
istr_partkb.flag		= 2			//���־�ü(����,����)
istr_partkb.remark	= sle_suppliercode.Text
OpenWithParm ( w_pisr012i, istr_partkb )
lstr_Rtn = Message.PowerObjectParm
IF lstr_Rtn.code = '' Then Return
sle_suppliercode.Text = lstr_Rtn.code
sle_suppliername.Text = lstr_Rtn.name


end event

type gb_1 from groupbox within w_pisq120i
integer x = 18
integer y = 12
integer width = 4613
integer height = 168
integer taborder = 70
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

