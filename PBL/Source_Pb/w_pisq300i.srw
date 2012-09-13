$PBExportHeader$w_pisq300i.srw
$PBExportComments$Containment �ҷ���Ȳ(ǰ���� �ҷ�����)
forward
global type w_pisq300i from w_ipis_sheet01
end type
type dw_pisq300i_01_graph from datawindow within w_pisq300i
end type
type st_countview2 from statictext within w_pisq300i
end type
type dw_pisq300i_01 from u_vi_std_datawindow within w_pisq300i
end type
type cb_exit from commandbutton within w_pisq300i
end type
type cb_print from commandbutton within w_pisq300i
end type
type dw_pisq300i_01_com from datawindow within w_pisq300i
end type
type gb_2 from groupbox within w_pisq300i
end type
type gb_1 from groupbox within w_pisq300i
end type
end forward

global type w_pisq300i from w_ipis_sheet01
integer width = 4690
integer height = 2800
string title = "Containment �ҷ���Ȳ(ǰ���� �ҷ�����)"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_pisq300i_01_graph dw_pisq300i_01_graph
st_countview2 st_countview2
dw_pisq300i_01 dw_pisq300i_01
cb_exit cb_exit
cb_print cb_print
dw_pisq300i_01_com dw_pisq300i_01_com
gb_2 gb_2
gb_1 gb_1
end type
global w_pisq300i w_pisq300i

type variables

datawindowchild	idwc_largegroup, idwc_middlegroup, idwc_smallgroup

end variables

on w_pisq300i.create
int iCurrent
call super::create
this.dw_pisq300i_01_graph=create dw_pisq300i_01_graph
this.st_countview2=create st_countview2
this.dw_pisq300i_01=create dw_pisq300i_01
this.cb_exit=create cb_exit
this.cb_print=create cb_print
this.dw_pisq300i_01_com=create dw_pisq300i_01_com
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq300i_01_graph
this.Control[iCurrent+2]=this.st_countview2
this.Control[iCurrent+3]=this.dw_pisq300i_01
this.Control[iCurrent+4]=this.cb_exit
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.dw_pisq300i_01_com
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
end on

on w_pisq300i.destroy
call super::destroy
destroy(this.dw_pisq300i_01_graph)
destroy(this.st_countview2)
destroy(this.dw_pisq300i_01)
destroy(this.cb_exit)
destroy(this.cb_print)
destroy(this.dw_pisq300i_01_com)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_pisq130i, FULL)
//
//of_resize()
//
end event

event open;
String	ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto, ls_itemcode

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

// �����찣�� ������ ��Ʈ���� �迭�� �޴´�
//
istr_parms = message.powerobjectparm

// �������� �������� ��ǥ�� �缳���Ѵ�
//
This.x = 1
This.y = 265

// �������� �������� Ÿ��Ʋ�� �缳���Ѵ�
//
this.title = 'w_pisq300i(Containment �ҷ���Ȳ(ǰ���� �ҷ�����))'

// Ʈ������� �����Ѵ�
//
dw_pisq300i_01.SetTransObject(SQLPIS)
dw_pisq300i_01_graph.SetTransObject(SQLPIS)
dw_pisq300i_01_com.SetTransObject(SQLPIS)
// ��ȸ������ ���Ѵ�
//
ls_areacode  	= istr_parms.String_arg[1]
ls_DivisionCode= istr_parms.String_arg[2]
ls_productgroup= istr_parms.String_arg[3]
ls_modelgroup	= istr_parms.String_arg[4]
ls_datefm		= istr_parms.String_arg[5]
ls_dateto		= istr_parms.String_arg[6]
ls_itemcode		= istr_parms.String_arg[7]

// �ڷḦ ��ȸ�Ѵ�
//
dw_pisq300i_01.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto, ls_itemcode)
dw_pisq300i_01_graph.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto, ls_itemcode)
dw_pisq300i_01_com.Retrieve(ls_areacode, ls_DivisionCode, ls_productgroup, ls_modelgroup, ls_datefm, ls_dateto, ls_itemcode)

// ����Ÿ�����쿡 ��Ŀ���� �ִ� �࿡ ����ǥ�ø� ��Ÿ����(1��)
//
f_SetHighlight(dw_pisq300i_01, 1, True)	

// ����ũ�� ������ ������ ��Ʈ�Ѵ�
//
this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")


end event

event activate;call super::activate;f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq300i
integer x = 18
integer y = 2124
integer width = 3598
end type

type dw_pisq300i_01_graph from datawindow within w_pisq300i
event ue_rbuttonup pbm_dwnrbuttonup
integer x = 46
integer y = 220
integer width = 4576
integer height = 1656
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq300i_01_graph"
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

event retrieverow;
IF istr_parms.long_arg[1] = row THEN
	RETURN 1
END IF

end event

type st_countview2 from statictext within w_pisq300i
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

type dw_pisq300i_01 from u_vi_std_datawindow within w_pisq300i
integer x = 46
integer y = 1892
integer width = 4576
integer height = 668
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_pisq300I_01"
boolean vscrollbar = true
end type

event retrieverow;call super::retrieverow;
IF istr_parms.long_arg[1] = row THEN
	RETURN 1
END IF

end event

type cb_exit from commandbutton within w_pisq300i
integer x = 4233
integer y = 48
integer width = 352
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��  ��"
end type

event clicked;
Close(Parent)
end event

type cb_print from commandbutton within w_pisq300i
integer x = 3822
integer y = 48
integer width = 352
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��  ��"
end type

event clicked;
IF MessageBox('Ȯ ��', '�׷��� ����� ������ ȭ����� �ٷ� ��µ˴ϴ�.~r~n����Ͻðڽ��ϱ�?',&
							  Exclamation!, OKCancel!, 2) = 2 THEN RETURN 0

// �׷��� ��׶��� ������ �ٲ۴�
//
dw_pisq300i_01_com.Object.dw_graph.Object.gr_1.BackColor = RGB(255,255,255)
dw_pisq300i_01_com.print()

end event

type dw_pisq300i_01_com from datawindow within w_pisq300i
boolean visible = false
integer x = 32
integer y = 312
integer width = 2267
integer height = 1604
integer taborder = 80
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisq300i_01_com"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisq300i
integer x = 18
integer y = 188
integer width = 4631
integer height = 2396
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisq300i
integer x = 18
integer y = 12
integer width = 4631
integer height = 168
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
end type

