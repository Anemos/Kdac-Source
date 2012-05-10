$PBExportHeader$w_pisq130i.srw
$PBExportComments$���԰˻� �ҷ���(���� �ҷ���)
forward
global type w_pisq130i from w_ipis_sheet01
end type
type gb_2 from groupbox within w_pisq130i
end type
type uo_area from u_pisc_select_area within w_pisq130i
end type
type uo_division from u_pisc_select_division within w_pisq130i
end type
type st_3 from statictext within w_pisq130i
end type
type sle_suppliercode from singlelineedit within w_pisq130i
end type
type sle_suppliername from singlelineedit within w_pisq130i
end type
type dw_pisq130i_01_graph from datawindow within w_pisq130i
end type
type dw_pisq130i_01 from datawindow within w_pisq130i
end type
type rb_lot from radiobutton within w_pisq130i
end type
type rb_qty from radiobutton within w_pisq130i
end type
type st_countview2 from statictext within w_pisq130i
end type
type uo_month from u_pisc_date_scroll_month within w_pisq130i
end type
type cb_1 from commandbutton within w_pisq130i
end type
type dw_pisq130i_02_com from datawindow within w_pisq130i
end type
type gb_1 from groupbox within w_pisq130i
end type
type dw_pisq130i_01_com from datawindow within w_pisq130i
end type
type pb_serch from picturebutton within w_pisq130i
end type
type cb_excel from commandbutton within w_pisq130i
end type
end forward

global type w_pisq130i from w_ipis_sheet01
integer width = 4690
integer height = 2708
string title = "���԰˻� �ҷ���(���� �ҷ���)"
gb_2 gb_2
uo_area uo_area
uo_division uo_division
st_3 st_3
sle_suppliercode sle_suppliercode
sle_suppliername sle_suppliername
dw_pisq130i_01_graph dw_pisq130i_01_graph
dw_pisq130i_01 dw_pisq130i_01
rb_lot rb_lot
rb_qty rb_qty
st_countview2 st_countview2
uo_month uo_month
cb_1 cb_1
dw_pisq130i_02_com dw_pisq130i_02_com
gb_1 gb_1
dw_pisq130i_01_com dw_pisq130i_01_com
pb_serch pb_serch
cb_excel cb_excel
end type
global w_pisq130i w_pisq130i

type variables

str_pisr_partkb istr_partkb
end variables

on w_pisq130i.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_3=create st_3
this.sle_suppliercode=create sle_suppliercode
this.sle_suppliername=create sle_suppliername
this.dw_pisq130i_01_graph=create dw_pisq130i_01_graph
this.dw_pisq130i_01=create dw_pisq130i_01
this.rb_lot=create rb_lot
this.rb_qty=create rb_qty
this.st_countview2=create st_countview2
this.uo_month=create uo_month
this.cb_1=create cb_1
this.dw_pisq130i_02_com=create dw_pisq130i_02_com
this.gb_1=create gb_1
this.dw_pisq130i_01_com=create dw_pisq130i_01_com
this.pb_serch=create pb_serch
this.cb_excel=create cb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.sle_suppliercode
this.Control[iCurrent+6]=this.sle_suppliername
this.Control[iCurrent+7]=this.dw_pisq130i_01_graph
this.Control[iCurrent+8]=this.dw_pisq130i_01
this.Control[iCurrent+9]=this.rb_lot
this.Control[iCurrent+10]=this.rb_qty
this.Control[iCurrent+11]=this.st_countview2
this.Control[iCurrent+12]=this.uo_month
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.dw_pisq130i_02_com
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.dw_pisq130i_01_com
this.Control[iCurrent+17]=this.pb_serch
this.Control[iCurrent+18]=this.cb_excel
end on

on w_pisq130i.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_3)
destroy(this.sle_suppliercode)
destroy(this.sle_suppliername)
destroy(this.dw_pisq130i_01_graph)
destroy(this.dw_pisq130i_01)
destroy(this.rb_lot)
destroy(this.rb_qty)
destroy(this.st_countview2)
destroy(this.uo_month)
destroy(this.cb_1)
destroy(this.dw_pisq130i_02_com)
destroy(this.gb_1)
destroy(this.dw_pisq130i_01_com)
destroy(this.pb_serch)
destroy(this.cb_excel)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq130i, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_QcDatefm, ls_QcDateto

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_SupplierCode	= sle_suppliercode.Text + '%'
ls_ItemCode			= '%'
ls_QcDatefm			= uo_month.is_uo_month + '.01'
ls_QcDateto			= uo_month.is_uo_month + '.' + String(f_get_lastday_of_month(uo_month.is_uo_month),'00')

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq130i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_QcDatefm, ls_QcDateto)

// �׷����� ǥ���Ѵ�
//
dw_pisq130i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_QcDatefm, ls_QcDateto)

IF rb_qty.Checked = TRUE THEN
	dw_pisq130i_01_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_QcDatefm, ls_QcDateto)
END IF	

IF rb_lot.Checked = TRUE THEN
	dw_pisq130i_02_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_SupplierCode, ls_ItemCode, ls_QcDatefm, ls_QcDateto)
END IF	

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
dw_pisq130i_01.SetTransObject(SQLPIS)
dw_pisq130i_01_graph.SetTransObject(SQLPIS)
dw_pisq130i_01_com.SetTransObject(SQLPIS)
dw_pisq130i_02_com.SetTransObject(SQLPIS)

end event

event ue_print;call super::ue_print;
IF MessageBox('Ȯ ��', '�׷��� ����� ������ ȭ����� �ٷ� ��µ˴ϴ�.~r~n����Ͻðڽ��ϱ�?',&
							  Exclamation!, OKCancel!, 2) = 2 THEN RETURN 0

IF rb_qty.Checked = TRUE THEN
	// �׷��� ��׶��� ������ �ٲ۴�
	//
	dw_pisq130i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq130i_01_com.print()

//	dw_pisq130i_01_com.Object.dw_report.Object.t_1.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_2.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_3.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_4.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_5.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_5.Color = RGB(0,0,0)
//
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_4.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_5.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_6.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_7.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_8.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_9.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_10.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_11.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_12.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_13.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_14.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_15.Background.Color = RGB(255,255,255)
//
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_4.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_5.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_6.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_7.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_8.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_9.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_10.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_11.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_12.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_13.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_14.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_15.Color = RGB(0,0,0)

END IF	

IF rb_lot.Checked = TRUE THEN
	// �׷��� ��׶��� ������ �ٲ۴�
	//
	dw_pisq130i_02_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq130i_02_com.print()
END IF	

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq130i_01.SetTransObject(SQLPIS)
dw_pisq130i_01_graph.SetTransObject(SQLPIS)
dw_pisq130i_01_com.SetTransObject(SQLPIS)
dw_pisq130i_02_com.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq130i
integer x = 18
integer y = 2124
integer width = 3598
end type

type gb_2 from groupbox within w_pisq130i
integer x = 3369
integer y = 36
integer width = 631
integer height = 124
integer taborder = 50
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type uo_area from u_pisc_select_area within w_pisq130i
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
dw_pisq130i_01.SetTransObject(SQLPIS)
dw_pisq130i_01_graph.SetTransObject(SQLPIS)
dw_pisq130i_01_com.SetTransObject(SQLPIS)
dw_pisq130i_02_com.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq130i
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
dw_pisq130i_01.SetTransObject(SQLPIS)
dw_pisq130i_01_graph.SetTransObject(SQLPIS)
dw_pisq130i_01_com.SetTransObject(SQLPIS)
dw_pisq130i_02_com.SetTransObject(SQLPIS)

end event

type st_3 from statictext within w_pisq130i
integer x = 1833
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

type sle_suppliercode from singlelineedit within w_pisq130i
integer x = 2130
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

type sle_suppliername from singlelineedit within w_pisq130i
integer x = 2359
integer y = 60
integer width = 709
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

type dw_pisq130i_01_graph from datawindow within w_pisq130i
event ue_rbuttonup pbm_dwnrbuttonup
integer x = 18
integer y = 192
integer width = 4613
integer height = 2028
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq130i_01_graph"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_rbuttonup;
st_countview2.Visible = FALSE

// �ý��� �˾��޴� ǥ�ø� �����Ѵ�.
//
RETURN 1


end event

event rbuttondown;
//------------------------------------------------------------------------------
// ó������		:	Application Rbuttondown Script
//						- �׷����� VALUE���� ǥ���Ѵ�.
// ����μ�		:	None
// ��ȯ��		:	None
//------------------------------------------------------------------------------

// �׷����� VALUE���� ǥ���ϴ� �Լ��� ȣ���Ѵ�. (����� �����Լ�)
//
f_DisplayGraphValue (This, st_countview2)

//------------------------------------------------------------------------------
// End of Script
//------------------------------------------------------------------------------

end event

type dw_pisq130i_01 from datawindow within w_pisq130i
integer x = 18
integer y = 2232
integer width = 4613
integer height = 356
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq130i_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_lot from radiobutton within w_pisq130i
integer x = 3401
integer y = 72
integer width = 256
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
string text = "LOT��"
end type

event clicked;
// LOT�� ��ȸ�� ����Ÿ�����츦 ��Ʈ�Ѵ�
//
dw_pisq130i_01.dataobject = 'd_pisq130i_02'
dw_pisq130i_01_graph.dataobject = 'd_pisq130i_02_graph'

dw_pisq130i_01.SetTransObject(SQLPIS)
dw_pisq130i_01_graph.SetTransObject(SQLPIS)



end event

type rb_qty from radiobutton within w_pisq130i
integer x = 3698
integer y = 72
integer width = 288
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
string text = "������"
boolean checked = true
end type

event clicked;
// LOT�� ��ȸ�� ����Ÿ�����츦 ��Ʈ�Ѵ�
//
dw_pisq130i_01.dataobject = 'd_pisq130i_01'
dw_pisq130i_01_graph.dataobject = 'd_pisq130i_01_graph'

dw_pisq130i_01.SetTransObject(SQLPIS)
dw_pisq130i_01_graph.SetTransObject(SQLPIS)



end event

type st_countview2 from statictext within w_pisq130i
boolean visible = false
integer x = 1554
integer y = 628
integer width = 224
integer height = 96
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 12632256
long bordercolor = 12632256
boolean focusrectangle = false
end type

type uo_month from u_pisc_date_scroll_month within w_pisq130i
event destroy ( )
integer x = 1170
integer y = 60
integer height = 80
integer taborder = 20
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type cb_1 from commandbutton within w_pisq130i
boolean visible = false
integer x = 4306
integer y = 40
integer width = 297
integer height = 120
integer taborder = 50
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�� ��"
end type

event clicked;
IF rb_qty.Checked = TRUE THEN
	// �׷��� ��׶��� ������ �ٲ۴�
	//
	dw_pisq130i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq130i_01_com.print()

//	dw_pisq130i_01_com.Object.dw_report.Object.t_1.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_2.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_3.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_4.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_5.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.t_5.Color = RGB(0,0,0)
//
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_4.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_5.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_6.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_7.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_8.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_9.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_10.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_11.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_12.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_13.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_14.Background.Color = RGB(255,255,255)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_15.Background.Color = RGB(255,255,255)
//
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_4.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_5.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_6.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_7.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_8.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_9.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_10.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_11.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_12.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_13.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_14.Color = RGB(0,0,0)
//	dw_pisq130i_01_com.Object.dw_report.Object.compute_15.Color = RGB(0,0,0)

END IF	

IF rb_lot.Checked = TRUE THEN
	// �׷��� ��׶��� ������ �ٲ۴�
	//
	dw_pisq130i_02_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq130i_02_com.print()
END IF	

end event

type dw_pisq130i_02_com from datawindow within w_pisq130i
boolean visible = false
integer x = 2331
integer y = 204
integer width = 2231
integer height = 1708
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq130i_02_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisq130i
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

type dw_pisq130i_01_com from datawindow within w_pisq130i
boolean visible = false
integer x = 37
integer y = 204
integer width = 2231
integer height = 1648
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq130i_01_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_serch from picturebutton within w_pisq130i
integer x = 3067
integer y = 52
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

type cb_excel from commandbutton within w_pisq130i
integer x = 4059
integer y = 44
integer width = 485
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��������"
end type

event clicked;f_save_to_excel(dw_pisq130i_01)
end event

