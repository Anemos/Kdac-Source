$PBExportHeader$w_pisq200i.srw
$PBExportComments$�ְ��� FTTQ ��Ȳ
forward
global type w_pisq200i from w_ipis_sheet01
end type
type gb_3 from groupbox within w_pisq200i
end type
type gb_2 from groupbox within w_pisq200i
end type
type uo_area from u_pisc_select_area within w_pisq200i
end type
type uo_division from u_pisc_select_division within w_pisq200i
end type
type dw_pisq200i_01_graph from datawindow within w_pisq200i
end type
type dw_pisq200i_01 from datawindow within w_pisq200i
end type
type st_countview2 from statictext within w_pisq200i
end type
type dw_pisq200i_00 from datawindow within w_pisq200i
end type
type cbx_process from checkbox within w_pisq200i
end type
type gb_1 from groupbox within w_pisq200i
end type
type rb_asemble from radiobutton within w_pisq200i
end type
type rb_all from radiobutton within w_pisq200i
end type
type rb_machine from radiobutton within w_pisq200i
end type
type rb_large from radiobutton within w_pisq200i
end type
type rb_middle from radiobutton within w_pisq200i
end type
type rb_small from radiobutton within w_pisq200i
end type
type uo_date from u_pisc_date_applydate within w_pisq200i
end type
type dw_pisq200i_01_com from datawindow within w_pisq200i
end type
type dw_pisq200i_02_com from datawindow within w_pisq200i
end type
type dw_pisq200i_03_com from datawindow within w_pisq200i
end type
type dw_pisq200i_04_com from datawindow within w_pisq200i
end type
end forward

global type w_pisq200i from w_ipis_sheet01
integer width = 4690
integer height = 2708
string title = "�ְ��� FTTQ ��Ȳ"
gb_3 gb_3
gb_2 gb_2
uo_area uo_area
uo_division uo_division
dw_pisq200i_01_graph dw_pisq200i_01_graph
dw_pisq200i_01 dw_pisq200i_01
st_countview2 st_countview2
dw_pisq200i_00 dw_pisq200i_00
cbx_process cbx_process
gb_1 gb_1
rb_asemble rb_asemble
rb_all rb_all
rb_machine rb_machine
rb_large rb_large
rb_middle rb_middle
rb_small rb_small
uo_date uo_date
dw_pisq200i_01_com dw_pisq200i_01_com
dw_pisq200i_02_com dw_pisq200i_02_com
dw_pisq200i_03_com dw_pisq200i_03_com
dw_pisq200i_04_com dw_pisq200i_04_com
end type
global w_pisq200i w_pisq200i

type variables

datawindowchild	idwc_largegroup, idwc_middlegroup, idwc_smallgroup

end variables

on w_pisq200i.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_pisq200i_01_graph=create dw_pisq200i_01_graph
this.dw_pisq200i_01=create dw_pisq200i_01
this.st_countview2=create st_countview2
this.dw_pisq200i_00=create dw_pisq200i_00
this.cbx_process=create cbx_process
this.gb_1=create gb_1
this.rb_asemble=create rb_asemble
this.rb_all=create rb_all
this.rb_machine=create rb_machine
this.rb_large=create rb_large
this.rb_middle=create rb_middle
this.rb_small=create rb_small
this.uo_date=create uo_date
this.dw_pisq200i_01_com=create dw_pisq200i_01_com
this.dw_pisq200i_02_com=create dw_pisq200i_02_com
this.dw_pisq200i_03_com=create dw_pisq200i_03_com
this.dw_pisq200i_04_com=create dw_pisq200i_04_com
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.dw_pisq200i_01_graph
this.Control[iCurrent+6]=this.dw_pisq200i_01
this.Control[iCurrent+7]=this.st_countview2
this.Control[iCurrent+8]=this.dw_pisq200i_00
this.Control[iCurrent+9]=this.cbx_process
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.rb_asemble
this.Control[iCurrent+12]=this.rb_all
this.Control[iCurrent+13]=this.rb_machine
this.Control[iCurrent+14]=this.rb_large
this.Control[iCurrent+15]=this.rb_middle
this.Control[iCurrent+16]=this.rb_small
this.Control[iCurrent+17]=this.uo_date
this.Control[iCurrent+18]=this.dw_pisq200i_01_com
this.Control[iCurrent+19]=this.dw_pisq200i_02_com
this.Control[iCurrent+20]=this.dw_pisq200i_03_com
this.Control[iCurrent+21]=this.dw_pisq200i_04_com
end on

on w_pisq200i.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_pisq200i_01_graph)
destroy(this.dw_pisq200i_01)
destroy(this.st_countview2)
destroy(this.dw_pisq200i_00)
destroy(this.cbx_process)
destroy(this.gb_1)
destroy(this.rb_asemble)
destroy(this.rb_all)
destroy(this.rb_machine)
destroy(this.rb_large)
destroy(this.rb_middle)
destroy(this.rb_small)
destroy(this.uo_date)
destroy(this.dw_pisq200i_01_com)
destroy(this.dw_pisq200i_02_com)
destroy(this.dw_pisq200i_03_com)
destroy(this.dw_pisq200i_04_com)
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
String	ls_maflag, ls_QcDate, ls_QcDateB1
String	ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_groupflag

// �������� �Һз������� ����
//
IF rb_small.Checked = FALSE AND cbx_process.Checked = TRUE THEN
	MessageBox('Ȯ ��', '�������� �Һз������� �����մϴ�', StopSign!)
	RETURN
END IF

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_QcDate			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_QcDateB1			= String(RelativeDate(date(ls_QcDate), -365), 'yyyy.mm.dd')

ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_largegroupcode	= dw_pisq200i_00.GetItemString(1, 'largegroupcode')
ls_middlegroupcode= dw_pisq200i_00.GetItemString(1, 'middlegroupcode')
ls_smallgroupcode	= dw_pisq200i_00.GetItemString(1, 'smallgroupcode')

// ������ üũ��
//
IF rb_machine.Checked = TRUE THEN
	ls_maflag = 'M'
END IF

// ������ üũ��
//
IF rb_asemble.Checked = TRUE THEN
	ls_maflag = 'A'
END IF

// ��ü üũ��
//
IF rb_all.Checked = TRUE THEN
	ls_maflag = '%'
END IF

// ��з��� ��ȸ
//
IF rb_large.Checked = TRUE THEN
	dw_pisq200i_01.dataobject			= 'd_pisq200i_01'
	dw_pisq200i_01_graph.dataobject	= 'd_pisq200i_01_graph'
	dw_pisq200i_01.SetTransObject(SQLPIS)
	dw_pisq200i_01_graph.SetTransObject(SQLPIS)
	// ����Ÿ/�׷����� ��ȸ�Ѵ�
	//
	dw_pisq200i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1)
	dw_pisq200i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate)

	dw_pisq200i_01_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1)
END IF

// �ߺз��� ��ȸ
//
IF rb_middle.Checked = TRUE THEN
	dw_pisq200i_01.dataobject			= 'd_pisq200i_02'
	dw_pisq200i_01_graph.dataobject	= 'd_pisq200i_02_graph'
	dw_pisq200i_01.SetTransObject(SQLPIS)
	dw_pisq200i_01_graph.SetTransObject(SQLPIS)
	// ����Ÿ/�׷����� ��ȸ�Ѵ�
	//
	dw_pisq200i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1, ls_largegroupcode)
	dw_pisq200i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_largegroupcode)

	dw_pisq200i_02_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1, ls_largegroupcode)
END IF

// �Һз��� ��ȸ
//
IF rb_small.Checked = TRUE AND cbx_process.Checked = FALSE THEN
	dw_pisq200i_01.dataobject			= 'd_pisq200i_03'
	dw_pisq200i_01_graph.dataobject	= 'd_pisq200i_03_graph'
	dw_pisq200i_01.SetTransObject(SQLPIS)
	dw_pisq200i_01_graph.SetTransObject(SQLPIS)
	// ����Ÿ/�׷����� ��ȸ�Ѵ�
	//
	dw_pisq200i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1, ls_largegroupcode, ls_middlegroupcode)
	dw_pisq200i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate,ls_largegroupcode, ls_middlegroupcode)

	dw_pisq200i_03_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1, ls_largegroupcode, ls_middlegroupcode)
END IF

// �Һз��������� ��ȸ
//
IF rb_small.Checked = TRUE AND cbx_process.Checked = TRUE THEN
	dw_pisq200i_01.dataobject			= 'd_pisq200i_04'
	dw_pisq200i_01_graph.dataobject	= 'd_pisq200i_04_graph'
	dw_pisq200i_01.SetTransObject(SQLPIS)
	dw_pisq200i_01_graph.SetTransObject(SQLPIS)
	// ����Ÿ/�׷����� ��ȸ�Ѵ�
	//
	dw_pisq200i_01.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1,ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)
	dw_pisq200i_01_graph.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate,ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)

	dw_pisq200i_04_com.Retrieve(ls_AreaCode, ls_DivisionCode, ls_maflag, ls_QcDate, ls_QcDateB1,ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode)
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
dw_pisq200i_01.SetTransObject(SQLPIS)
dw_pisq200i_01_graph.SetTransObject(SQLPIS)
dw_pisq200i_01_com.SetTransObject(SQLPIS)
dw_pisq200i_02_com.SetTransObject(SQLPIS)
dw_pisq200i_03_com.SetTransObject(SQLPIS)
dw_pisq200i_04_com.SetTransObject(SQLPIS)

// Child Datawindow ����(��ǰ ��/��/�� �з�)
//
dw_pisq200i_00.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq200i_00.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq200i_00.GetChild ('smallgroupcode' , idwc_smallgroup)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )

dw_pisq200i_00.PostEvent(Constructor!)

end event

event ue_print;call super::ue_print;
IF MessageBox('Ȯ ��', '�׷��� ����� ������ ȭ����� �ٷ� ��µ˴ϴ�.~r~n����Ͻðڽ��ϱ�?',&
							  Exclamation!, OKCancel!, 2) = 2 THEN RETURN 0

// ��з��� ���
//
IF rb_large.Checked = TRUE THEN
	// �׷��� ��׶��� ������ �ٲ۴�
	//
	dw_pisq200i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq200i_01_com.print()
END IF

// �ߺз��� ���
//
IF rb_middle.Checked = TRUE THEN
	dw_pisq200i_02_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq200i_02_com.print()
END IF

// �Һз��� ���
//
IF rb_small.Checked = TRUE AND cbx_process.Checked = FALSE THEN
	dw_pisq200i_03_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq200i_03_com.print()
END IF

// �Һз��������� ���
//
IF rb_small.Checked = TRUE AND cbx_process.Checked = TRUE THEN
	dw_pisq200i_04_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
	dw_pisq200i_04_com.print()
END IF

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq200i_01.SetTransObject(SQLPIS)
dw_pisq200i_01_graph.SetTransObject(SQLPIS)
dw_pisq200i_01_com.SetTransObject(SQLPIS)
dw_pisq200i_02_com.SetTransObject(SQLPIS)
dw_pisq200i_03_com.SetTransObject(SQLPIS)
dw_pisq200i_04_com.SetTransObject(SQLPIS)

// Child Datawindow ����(��ǰ ��/��/�� �з�)
//
dw_pisq200i_00.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq200i_00.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq200i_00.GetChild ('smallgroupcode' , idwc_smallgroup)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq200i
integer x = 18
integer y = 2124
integer width = 3598
end type

type gb_3 from groupbox within w_pisq200i
integer x = 3182
integer y = 40
integer width = 1033
integer height = 112
integer taborder = 60
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisq200i
integer x = 3182
integer y = 148
integer width = 1033
integer height = 112
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

type uo_area from u_pisc_select_area within w_pisq200i
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
dw_pisq200i_01.SetTransObject(SQLPIS)
dw_pisq200i_01_graph.SetTransObject(SQLPIS)
dw_pisq200i_01_com.SetTransObject(SQLPIS)
dw_pisq200i_02_com.SetTransObject(SQLPIS)
dw_pisq200i_03_com.SetTransObject(SQLPIS)
dw_pisq200i_04_com.SetTransObject(SQLPIS)

// Child Datawindow ����(��ǰ ��/��/�� �з�)
//
dw_pisq200i_00.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq200i_00.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq200i_00.GetChild ('smallgroupcode' , idwc_smallgroup)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )

dw_pisq200i_00.PostEvent(Constructor!)
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

type uo_division from u_pisc_select_division within w_pisq200i
event destroy ( )
integer x = 594
integer y = 60
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;
// ����� ���常 ����/������ �ְ� �׿ܴ� ������ ��ü
//
IF uo_division.is_uo_divisioncode = 'V' THEN
	rb_machine.Visible = TRUE
	rb_asemble.Visible = TRUE
	rb_all.Visible 	 = TRUE
ELSE
	rb_machine.Visible = FALSE
	rb_asemble.Visible = FALSE
	rb_all.Visible 	 = FALSE
END IF	

// Ʈ������� �����Ѵ�
//
dw_pisq200i_01.SetTransObject(SQLPIS)
dw_pisq200i_01_graph.SetTransObject(SQLPIS)
dw_pisq200i_01_com.SetTransObject(SQLPIS)
dw_pisq200i_02_com.SetTransObject(SQLPIS)
dw_pisq200i_03_com.SetTransObject(SQLPIS)
dw_pisq200i_04_com.SetTransObject(SQLPIS)

// Child Datawindow ����(��ǰ ��/��/�� �з�)
//
dw_pisq200i_00.GetChild ('largegroupcode' , idwc_largegroup)
dw_pisq200i_00.GetChild ('middlegroupcode', idwc_middlegroup)
dw_pisq200i_00.GetChild ('smallgroupcode' , idwc_smallgroup)

idwc_largegroup.SetTransObject( SQLPIS )
idwc_middlegroup.SetTransObject( SQLPIS )
idwc_smallgroup.SetTransObject( SQLPIS )

dw_pisq200i_00.PostEvent(Constructor!)
end event

type dw_pisq200i_01_graph from datawindow within w_pisq200i
event ue_rbuttonup pbm_dwnrbuttonup
integer x = 18
integer y = 296
integer width = 4613
integer height = 1692
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_01_graph"
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

type dw_pisq200i_01 from datawindow within w_pisq200i
integer x = 18
integer y = 2004
integer width = 4613
integer height = 584
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_countview2 from statictext within w_pisq200i
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

type dw_pisq200i_00 from datawindow within w_pisq200i
integer x = 59
integer y = 164
integer width = 3118
integer height = 76
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq190i_00"
boolean border = false
boolean livescroll = true
end type

event constructor;
String	ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode
String	ls_date, ls_processcode, ls_badreasoncode
Long		ll_retrieverow 

if uo_area.dw_1.GetRow() < 1 then
	return 0
end if
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_division.dw_1.GetRow(), 'dddwcode')

// Child Retrieve(��з�)
//
ll_retrieverow = idwc_largegroup.Retrieve(ls_AreaCode, ls_DivisionCode)
if ll_retrieverow < 1 then
	return 0
end if
// Child Window���� ��з� �ڵ带 ���Ѵ�
//
ls_largegroupcode = idwc_largegroup.GetItemString(1, 'largegroupcode')

// Child Retrieve(�ߺз�)
//
ll_retrieverow = idwc_middlegroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode)
if ll_retrieverow < 1 then
	return 0
end if
// Child Window���� �ߺз� �ڵ带 ���Ѵ�
//
ls_middlegroupcode = idwc_middlegroup.GetItemString(1, 'middlegroupcode')

// Child Retrieve(�Һз�)
//
ll_retrieverow = idwc_smallgroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
if ll_retrieverow < 1 then
	return 0
end if
// Child Window���� �Һз� �ڵ带 ���Ѵ�
//
ls_smallgroupcode = idwc_smallgroup.GetItemString(1, 'smallgroupcode')

dw_pisq200i_00.InsertRow(0)
dw_pisq200i_00.SetItem(1, 'largegroupcode' , ls_largegroupcode)
dw_pisq200i_00.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
dw_pisq200i_00.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)

end event

event itemchanged;
String	ls_colname, ls_coldata, ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode, ls_smallgroupcode

IF dw_pisq200i_00.AcceptText() <> 1 THEN RETURN

ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')

// Column Name 
//
ls_colname = This.GetColumnName()

// Column Data
//
ls_coldata = Trim(data)

CHOOSE CASE ls_colname
	// ��з��� �����
	//
	CASE 'largegroupcode'
		// ����� ��з� �ڵ带 ���Ѵ�
		//
		ls_largegroupcode = ls_coldata
		
		// Child Retrieve(�ߺз�)
		//
		idwc_middlegroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode)

		// Child Window���� �ߺз� �ڵ带 ���Ѵ�
		//
		ls_middlegroupcode = idwc_middlegroup.GetItemString(1, 'middlegroupcode')
		
		// Child Retrieve(�Һз�)
		//
		idwc_smallgroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
		// Child Window���� �Һз� �ڵ带 ���Ѵ�
		//
		ls_smallgroupcode  = idwc_smallgroup.GetItemString(1, 'smallgroupcode')

		dw_pisq200i_00.SetItem(1, 'middlegroupcode', ls_middlegroupcode)
		dw_pisq200i_00.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)

	// �ߺз��� �����
	//
	CASE 'middlegroupcode'
		// ��/�ߺз� �ڵ带 ���Ѵ�
		//
		ls_largegroupcode  = dw_pisq200i_00.GetItemString(1, 'largegroupcode')
		ls_middlegroupcode = ls_coldata
	
		// Child Retrieve(�Һз�)
		//
		idwc_smallgroup.Retrieve(ls_AreaCode, ls_DivisionCode, ls_largegroupcode, ls_middlegroupcode)
		// Child Window���� �Һз� �ڵ带 ���Ѵ�
		//
		ls_smallgroupcode  = idwc_smallgroup.GetItemString(1, 'smallgroupcode')
		dw_pisq200i_00.SetItem(1, 'smallgroupcode' , ls_smallgroupcode)
END CHOOSE

end event

type cbx_process from checkbox within w_pisq200i
integer x = 2843
integer y = 60
integer width = 288
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
string text = "������"
boolean lefttext = true
end type

type gb_1 from groupbox within w_pisq200i
integer x = 18
integer y = 12
integer width = 4613
integer height = 272
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

type rb_asemble from radiobutton within w_pisq200i
boolean visible = false
integer x = 3570
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
string text = "����"
end type

event clicked;//
//// LOT�� ��ȸ�� ����Ÿ�����츦 ��Ʈ�Ѵ�
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_02'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_02_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_all from radiobutton within w_pisq200i
boolean visible = false
integer x = 3877
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
string text = "��ü"
boolean checked = true
end type

event clicked;//
//// LOT�� ��ȸ�� ����Ÿ�����츦 ��Ʈ�Ѵ�
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_01'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_01_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_machine from radiobutton within w_pisq200i
boolean visible = false
integer x = 3264
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
string text = "����"
end type

event clicked;//
//// LOT�� ��ȸ�� ����Ÿ�����츦 ��Ʈ�Ѵ�
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_02'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_02_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_large from radiobutton within w_pisq200i
integer x = 3264
integer y = 180
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
string text = "��з�"
boolean checked = true
end type

event clicked;//
//// LOT�� ��ȸ�� ����Ÿ�����츦 ��Ʈ�Ѵ�
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_02'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_02_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_middle from radiobutton within w_pisq200i
integer x = 3570
integer y = 180
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
string text = "�ߺз�"
end type

event clicked;//
//// LOT�� ��ȸ�� ����Ÿ�����츦 ��Ʈ�Ѵ�
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_02'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_02_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type rb_small from radiobutton within w_pisq200i
integer x = 3877
integer y = 180
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
string text = "�Һз�"
end type

event clicked;//
//// LOT�� ��ȸ�� ����Ÿ�����츦 ��Ʈ�Ѵ�
////
//dw_pisq190i_01.dataobject = 'd_pisq190i_01'
//dw_pisq190i_01_graph.dataobject = 'd_pisq190i_01_graph'
//
//dw_pisq190i_01.SetTransObject(SQLPIS)
//dw_pisq190i_01_graph.SetTransObject(SQLPIS)
//
//
//
end event

type uo_date from u_pisc_date_applydate within w_pisq200i
event destroy ( )
integer x = 1198
integer y = 60
integer taborder = 70
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type dw_pisq200i_01_com from datawindow within w_pisq200i
boolean visible = false
integer x = 32
integer y = 312
integer width = 2267
integer height = 1604
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_01_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisq200i_02_com from datawindow within w_pisq200i
boolean visible = false
integer x = 366
integer y = 308
integer width = 2267
integer height = 1604
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_02_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisq200i_03_com from datawindow within w_pisq200i
boolean visible = false
integer x = 773
integer y = 308
integer width = 2267
integer height = 1604
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_03_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_pisq200i_04_com from datawindow within w_pisq200i
boolean visible = false
integer x = 1143
integer y = 316
integer width = 2267
integer height = 1604
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq200i_04_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

