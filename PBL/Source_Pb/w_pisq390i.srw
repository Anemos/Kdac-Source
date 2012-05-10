$PBExportHeader$w_pisq390i.srw
$PBExportComments$Warranty�� ���̱׷���
forward
global type w_pisq390i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq390i
end type
type uo_division from u_pisc_select_division within w_pisq390i
end type
type dw_pisq390i_01 from u_vi_std_datawindow within w_pisq390i
end type
type gb_2 from groupbox within w_pisq390i
end type
type dw_pisq390i_01_graph from datawindow within w_pisq390i
end type
type st_countview2 from statictext within w_pisq390i
end type
type gb_3 from groupbox within w_pisq390i
end type
type uo_year from u_pisc_date_scroll_year within w_pisq390i
end type
type st_5 from statictext within w_pisq390i
end type
type dw_pisq390i_01_com from datawindow within w_pisq390i
end type
end forward

global type w_pisq390i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Warranty�� ���̱׷���"
uo_area uo_area
uo_division uo_division
dw_pisq390i_01 dw_pisq390i_01
gb_2 gb_2
dw_pisq390i_01_graph dw_pisq390i_01_graph
st_countview2 st_countview2
gb_3 gb_3
uo_year uo_year
st_5 st_5
dw_pisq390i_01_com dw_pisq390i_01_com
end type
global w_pisq390i w_pisq390i

type variables


string is_custgubun,is_custcode

Boolean	ib_open

end variables

on w_pisq390i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq390i_01=create dw_pisq390i_01
this.gb_2=create gb_2
this.dw_pisq390i_01_graph=create dw_pisq390i_01_graph
this.st_countview2=create st_countview2
this.gb_3=create gb_3
this.uo_year=create uo_year
this.st_5=create st_5
this.dw_pisq390i_01_com=create dw_pisq390i_01_com
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_pisq390i_01
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.dw_pisq390i_01_graph
this.Control[iCurrent+6]=this.st_countview2
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.uo_year
this.Control[iCurrent+9]=this.st_5
this.Control[iCurrent+10]=this.dw_pisq390i_01_com
end on

on w_pisq390i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq390i_01)
destroy(this.gb_2)
destroy(this.dw_pisq390i_01_graph)
destroy(this.st_countview2)
destroy(this.gb_3)
destroy(this.uo_year)
destroy(this.st_5)
destroy(this.dw_pisq390i_01_com)
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
String	ls_areacode, ls_divisioncode, ls_datefm, ls_dateto
Long		ll_row

// ��ȸ�� �ʿ��� ���� ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_datefm			= uo_year.is_uo_year + '.12.01'
ls_Dateto			= uo_year.is_uo_year + '.12.31'

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq390i_01.Retrieve(ls_areacode, ls_divisioncode, ls_datefm, ls_dateto)
dw_pisq390i_01_graph.Retrieve(ls_areacode, ls_divisioncode, ls_datefm, ls_dateto)

dw_pisq390i_01_com.Retrieve(ls_areacode, ls_divisioncode, ls_datefm, ls_dateto)

//
//// �׷����� ǥ���Ѵ�
////
//dw_pisq390i_01_graph.SetRedraw(FALSE)
//dw_pisq390i_01_graph.Reset()
//
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c11all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a11all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.01')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c11all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a11all') * 100)
//END IF
//
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c10all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a10all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.02')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c10all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a10all') * 100)
//END IF
//	
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c09all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a09all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.03')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c09all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a09all') * 100)
//END IF
//	
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c08all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a08all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.04')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c08all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a08all') * 100)
//END IF
//	
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c07all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a07all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.05')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c07all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a07all') * 100)
//END IF
//		
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c06all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a06all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.06')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c06all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a06all') * 100)
//END IF
//		
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c05all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a05all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.07')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c05all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a05all') * 100)
//END IF
//		
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c04all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a04all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.08')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c04all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a04all') * 100)
//END IF
//		
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c03all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a03all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.09')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c03all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a03all') * 100)
//END IF
//		
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c02all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a02all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.10')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c02all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a02all') * 100)
//END IF
//		
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c01all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a01all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.11')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c01all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a01all') * 100)
//END IF
//		
//IF dw_pisq390i_01.GetItemNumber(1, 'as_c00all') <> 0 AND dw_pisq390i_01.GetItemNumber(1, 'as_24a00all') <> 0 THEN
//	ll_row = dw_pisq390i_01_graph.InsertRow(0)
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_date', Mid(uo_year.is_uo_year , 3, 2) + '.12')
//	dw_pisq390i_01_graph.SetItem(ll_row, 'as_rate', &
//	dw_pisq390i_01.GetItemNumber(1, 'as_c00all') / dw_pisq390i_01.GetItemNumber(1, 'as_24a00all') * 100)
//END IF
//dw_pisq390i_01_graph.SetRedraw(TRUE)
//
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

event ue_postopen;
string ls_codegroup,ls_codegroupname,ls_codename

// Ʈ������� �����Ѵ�
//
dw_pisq390i_01.SetTransObject(SQLEIS)
dw_pisq390i_01_graph.SetTransObject(SQLEIS)
dw_pisq390i_01_com.SetTransObject(SQLEIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
ib_open = true										

end event

event ue_print;call super::ue_print;
IF MessageBox('Ȯ ��', '�׷��� ����� ������ ȭ����� �ٷ� ��µ˴ϴ�.~r~n����Ͻðڽ��ϱ�?',&
							  Exclamation!, OKCancel!, 2) = 2 THEN RETURN 0

// �׷��� ��׶��� ������ �ٲ۴�
//
dw_pisq390i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
dw_pisq390i_01_com.print()

end event

event activate;call super::activate;if Not f_pisc_connect_eis_server(sqleis) then
	Messagebox("Ȯ��","EIS ������ �����ϴµ� �����߽��ϴ�.")
end if

end event

event close;call super::close;
f_pisc_disconnect_eis_server(sqleis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq390i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq390i
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
	
End If


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

type uo_division from u_pisc_select_division within w_pisq390i
event destroy ( )
integer x = 613
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//
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

type dw_pisq390i_01 from u_vi_std_datawindow within w_pisq390i
integer x = 37
integer y = 1540
integer width = 4553
integer height = 1016
integer taborder = 100
boolean bringtotop = true
string dataobject = "d_pisq390i_01"
boolean vscrollbar = true
end type

event rowfocuschanged;//
end event

event clicked;//
end event

type gb_2 from groupbox within w_pisq390i
integer x = 18
integer y = 12
integer width = 4594
integer height = 168
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type dw_pisq390i_01_graph from datawindow within w_pisq390i
event ue_rbuttonup pbm_dwnrbuttonup
integer x = 46
integer y = 212
integer width = 4535
integer height = 1316
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq390i_01_graph"
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

type st_countview2 from statictext within w_pisq390i
boolean visible = false
integer x = 2615
integer y = 808
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

type gb_3 from groupbox within w_pisq390i
integer x = 18
integer y = 184
integer width = 4594
integer height = 2392
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

type uo_year from u_pisc_date_scroll_year within w_pisq390i
event destroy ( )
integer x = 1262
integer y = 64
integer taborder = 50
boolean bringtotop = true
end type

on uo_year.destroy
call u_pisc_date_scroll_year::destroy
end on

type st_5 from statictext within w_pisq390i
integer x = 1257
integer y = 72
integer width = 233
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
string text = "�����:"
boolean focusrectangle = false
end type

type dw_pisq390i_01_com from datawindow within w_pisq390i
boolean visible = false
integer x = 1819
integer y = 520
integer width = 1371
integer height = 1068
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq390i_01_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

