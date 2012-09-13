$PBExportHeader$w_pisq285i.srw
$PBExportComments$Containment �˻���Ȳ
forward
global type w_pisq285i from w_ipis_sheet01
end type
type dw_pisq285i from u_vi_std_datawindow within w_pisq285i
end type
type uo_area from u_pisc_select_area within w_pisq285i
end type
type uo_division from u_pisc_select_division within w_pisq285i
end type
type st_4 from statictext within w_pisq285i
end type
type uo_date from u_pisc_date_applydate within w_pisq285i
end type
type uo_dateto from u_pisc_date_applydate_1 within w_pisq285i
end type
type cb_saveas from commandbutton within w_pisq285i
end type
type gb_1 from groupbox within w_pisq285i
end type
end forward

global type w_pisq285i from w_ipis_sheet01
integer width = 4690
integer height = 2136
string title = "Containment �˻���Ȳ"
dw_pisq285i dw_pisq285i
uo_area uo_area
uo_division uo_division
st_4 st_4
uo_date uo_date
uo_dateto uo_dateto
cb_saveas cb_saveas
gb_1 gb_1
end type
global w_pisq285i w_pisq285i

type variables

end variables

on w_pisq285i.create
int iCurrent
call super::create
this.dw_pisq285i=create dw_pisq285i
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_4=create st_4
this.uo_date=create uo_date
this.uo_dateto=create uo_dateto
this.cb_saveas=create cb_saveas
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pisq285i
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.uo_date
this.Control[iCurrent+6]=this.uo_dateto
this.Control[iCurrent+7]=this.cb_saveas
this.Control[iCurrent+8]=this.gb_1
end on

on w_pisq285i.destroy
call super::destroy
destroy(this.dw_pisq285i)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_4)
destroy(this.uo_date)
destroy(this.uo_dateto)
destroy(this.cb_saveas)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_pisq285i, FULL)

of_resize()

end event

event ue_retrieve;
String	ls_AreaCode, ls_DivisionCode, ls_datefm, ls_dateto

// ��ȸ�� �ʿ��� ������ ���Ѵ�
//
ls_AreaCode			= uo_area.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_DivisionCode	= uo_division.dw_1.GetItemString(uo_area.dw_1.GetRow(), 'dddwcode')
ls_datefm			= String(uo_date.id_uo_date, 'yyyy.mm.dd')
ls_dateto			= String(uo_dateto.id_uo_date, 'yyyy.mm.dd')

// ����Ÿ�� ��ȸ�Ѵ�
//
dw_pisq285i.Retrieve(ls_AreaCode, ls_DivisionCode, ls_datefm, ls_dateto)

// ����Ÿ�������� ù��° ��Ŀ���࿡ ����ǥ�ø� ��Ÿ����
//
f_SetHighlight(dw_pisq285i, 1, True)	


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
dw_pisq285i.SetTransObject(SQLPIS)

end event

event activate;call super::activate;
// Ʈ������� �����Ѵ�
//
dw_pisq285i.SetTransObject(SQLPIS)

f_icon_set(true , false, false,  false,  true , &
           false, false, false,  false,  false, &
		  	  false, false, false,  true ,  true , &
			  false, false )
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisq285i
integer x = 18
integer width = 3598
end type

type dw_pisq285i from u_vi_std_datawindow within w_pisq285i
integer x = 18
integer y = 192
integer width = 4512
integer height = 1696
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_pisq285i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
//cb_print.TriggerEvent(Clicked!)
end event

type uo_area from u_pisc_select_area within w_pisq285i
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
dw_pisq285i.SetTransObject(SQLPIS)

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

type uo_division from u_pisc_select_division within w_pisq285i
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
dw_pisq285i.SetTransObject(SQLPIS)

end event

type st_4 from statictext within w_pisq285i
integer x = 1760
integer y = 76
integer width = 46
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type uo_date from u_pisc_date_applydate within w_pisq285i
event destroy ( )
integer x = 1093
integer y = 64
integer taborder = 50
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_dateto from u_pisc_date_applydate_1 within w_pisq285i
event destroy ( )
integer x = 1806
integer y = 64
integer taborder = 60
boolean bringtotop = true
end type

on uo_dateto.destroy
call u_pisc_date_applydate_1::destroy
end on

type cb_saveas from commandbutton within w_pisq285i
integer x = 4142
integer y = 44
integer width = 448
integer height = 108
integer taborder = 80
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
dw_pisq285i.SaveAs()



end event

type gb_1 from groupbox within w_pisq285i
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

