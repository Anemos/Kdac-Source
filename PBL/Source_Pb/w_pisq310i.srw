$PBExportHeader$w_pisq310i.srw
$PBExportComments$Containment �ҷ���Ȳ(�����ҷ���)
forward
global type w_pisq310i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisq310i
end type
type uo_division from u_pisc_select_division within w_pisq310i
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisq310i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisq310i
end type
type gb_2 from groupbox within w_pisq310i
end type
type dw_pisq310i_01_graph from datawindow within w_pisq310i
end type
type dw_pisq310i_01 from datawindow within w_pisq310i
end type
type st_countview2 from statictext within w_pisq310i
end type
type uo_month from u_pisc_date_scroll_month within w_pisq310i
end type
type dw_pisq310i_01_com from datawindow within w_pisq310i
end type
end forward

global type w_pisq310i from w_ipis_sheet01
integer width = 4681
integer height = 2784
string title = "Containment �ҷ���Ȳ(ǰ����)"
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
gb_2 gb_2
dw_pisq310i_01_graph dw_pisq310i_01_graph
dw_pisq310i_01 dw_pisq310i_01
st_countview2 st_countview2
uo_month uo_month
dw_pisq310i_01_com dw_pisq310i_01_com
end type
global w_pisq310i w_pisq310i

type variables

datawindowchild	idwc_badreason, idwc_badtype
Boolean	ib_open

end variables

on w_pisq310i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.gb_2=create gb_2
this.dw_pisq310i_01_graph=create dw_pisq310i_01_graph
this.dw_pisq310i_01=create dw_pisq310i_01
this.st_countview2=create st_countview2
this.uo_month=create uo_month
this.dw_pisq310i_01_com=create dw_pisq310i_01_com
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_productgroup
this.Control[iCurrent+4]=this.uo_modelgroup
this.Control[iCurrent+5]=this.gb_2
this.Control[iCurrent+6]=this.dw_pisq310i_01_graph
this.Control[iCurrent+7]=this.dw_pisq310i_01
this.Control[iCurrent+8]=this.st_countview2
this.Control[iCurrent+9]=this.uo_month
this.Control[iCurrent+10]=this.dw_pisq310i_01_com
end on

on w_pisq310i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.gb_2)
destroy(this.dw_pisq310i_01_graph)
destroy(this.dw_pisq310i_01)
destroy(this.st_countview2)
destroy(this.uo_month)
destroy(this.dw_pisq310i_01_com)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq290i_01, FULL)
//
//of_resize()
//
end event

event ue_retrieve;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto

// ��ȸ������ ���Ѵ�
//
ls_areacode  		= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')
ls_productgroup	= uo_productgroup.dw_1.GetItemString(uo_productgroup.dw_1.GetRow(), 'dddwcode') 
ls_modelgroup		= uo_modelgroup.dw_1.GetItemString(uo_modelgroup.dw_1.GetRow(), 'dddwcode') 

ls_Datefm			= uo_month.is_uo_month + '.01'
ls_Dateto			= uo_month.is_uo_month + '.' + String(f_get_lastday_of_month(uo_month.is_uo_month),'00')

IF ls_productgroup = 'ALL' OR f_checknullorspace(ls_productgroup) = TRUE THEN
	ls_productgroup = '%'
END IF

IF ls_modelgroup = 'ALL' OR f_checknullorspace(ls_modelgroup) = TRUE THEN
	ls_modelgroup = '%'
END IF

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq310i_01.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto)
dw_pisq310i_01_graph.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto)

dw_pisq310i_01_com.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto)


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
// Ʈ������� �����Ѵ�
//
dw_pisq310i_01.SetTransObject(SQLPIS)
dw_pisq310i_01_graph.SetTransObject(SQLPIS)
dw_pisq310i_01_com.SetTransObject(SQLPIS)

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

event ue_print;call super::ue_print;
IF MessageBox('Ȯ ��', '�׷��� ����� ������ ȭ����� �ٷ� ��µ˴ϴ�.~r~n����Ͻðڽ��ϱ�?',&
							  Exclamation!, OKCancel!, 2) = 2 THEN RETURN 0

// �׷��� ��׶��� ������ �ٲ۴�
//
dw_pisq310i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
dw_pisq310i_01_com.print()

end event

event activate;call super::activate;// Ʈ������� �����Ѵ�
//
dw_pisq310i_01.SetTransObject(SQLPIS)
dw_pisq310i_01_graph.SetTransObject(SQLPIS)
dw_pisq310i_01_com.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq310i
integer x = 18
integer y = 2592
integer width = 3598
end type

type uo_area from u_pisc_select_area within w_pisq310i
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
//	iw_this.TriggerEvent("ue_reset")
End If

// Ʈ������� �����Ѵ�
//
dw_pisq310i_01.SetTransObject(SQLPIS)
dw_pisq310i_01_graph.SetTransObject(SQLPIS)
dw_pisq310i_01_com.SetTransObject(SQLPIS)


end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisq310i
event destroy ( )
integer x = 599
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event constructor;call super::constructor;
//PostEvent("ue_post_constructor")

//PostEvent("ue_select")

end event

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

//	iw_this.TriggerEvent("ue_reset")
End If

// Ʈ������� �����Ѵ�
//
dw_pisq310i_01.SetTransObject(SQLPIS)
dw_pisq310i_01_graph.SetTransObject(SQLPIS)
dw_pisq310i_01_com.SetTransObject(SQLPIS)


end event

type uo_productgroup from u_pisc_select_productgroup within w_pisq310i
integer x = 1198
integer y = 60
integer taborder = 30
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
//	iw_this.TriggerEvent("ue_reset")
End If

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisq310i
integer x = 2130
integer y = 60
integer taborder = 40
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
//	iw_this.TriggerEvent("ue_reset")
End If

end event

type gb_2 from groupbox within w_pisq310i
integer x = 18
integer y = 12
integer width = 4613
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

type dw_pisq310i_01_graph from datawindow within w_pisq310i
event ue_rbuttonup pbm_dwnrbuttonup
integer x = 18
integer y = 200
integer width = 4613
integer height = 1788
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq310i_01_graph"
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

type dw_pisq310i_01 from datawindow within w_pisq310i
integer x = 18
integer y = 2004
integer width = 4613
integer height = 584
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq310i_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_countview2 from statictext within w_pisq310i
boolean visible = false
integer x = 1513
integer y = 932
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

type uo_month from u_pisc_date_scroll_month within w_pisq310i
event destroy ( )
integer x = 3099
integer y = 60
integer height = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type dw_pisq310i_01_com from datawindow within w_pisq310i
boolean visible = false
integer x = 32
integer y = 268
integer width = 2267
integer height = 1604
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq310i_01_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

