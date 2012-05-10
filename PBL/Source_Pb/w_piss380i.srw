$PBExportHeader$w_piss380i.srw
$PBExportComments$�������ϰ�������Ȳ
forward
global type w_piss380i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss380i
end type
type uo_area from u_pisc_select_area within w_piss380i
end type
type uo_division from u_pisc_select_division within w_piss380i
end type
type uo_date from u_pisc_date_applydate within w_piss380i
end type
type sle_1 from singlelineedit within w_piss380i
end type
type ddlb_1 from dropdownlistbox within w_piss380i
end type
type st_2 from statictext within w_piss380i
end type
type dw_print from datawindow within w_piss380i
end type
type gb_1 from groupbox within w_piss380i
end type
end forward

global type w_piss380i from w_ipis_sheet01
integer width = 4663
integer height = 2688
string title = "�԰��������ȸ"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_date uo_date
sle_1 sle_1
ddlb_1 ddlb_1
st_2 st_2
dw_print dw_print
gb_1 gb_1
end type
global w_piss380i w_piss380i

type variables
string is_prddate,is_areacode,is_divisioncode,is_gubun
end variables

on w_piss380i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.sle_1=create sle_1
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.dw_print=create dw_print
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_date
this.Control[iCurrent+5]=this.sle_1
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_print
this.Control[iCurrent+9]=this.gb_1
end on

on w_piss380i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.sle_1)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.dw_print)
destroy(this.gb_1)
end on

event resize;call super::resize;//
//il_resize_count ++
//
//of_resize_register(dw_sheet, ABOVE)
//of_resize_register(st_h_bar, SPLIT)
//of_resize_register(dw_sheet1, BELOW)
//
//of_resize()

end event

event ue_retrieve;call super::ue_retrieve;string ls_prddate,ls_areacode,ls_divisioncode,ls_time
long ll_count
select convert(char(19),getdate(),121) + ' ����' 
into :ls_time from sysusers using sqlpis;
sle_1.text = ls_time
ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,is_prddate,is_gubun)
if ll_count = 0 then
	messagebox("Ȯ��","��ȸ�� �ڷᰡ �����ϴ�.")
	uo_date.setfocus()
	return
end if	
dw_print.retrieve(is_areacode,is_divisioncode,is_prddate,is_gubun)



end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

event open;call super::open;ddlb_1.text = '��ü'
is_gubun = 'A'
end event

event ue_print;call super::ue_print;string ls_date
ls_date = mid(g_s_date,1,4) + '.' + mid(g_s_date,5,2) + '.' + mid(g_s_date,7,2) 
dw_print.modify("printdate_t.text = '" + ls_date + "'" )
dw_print.print()
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss380i
integer y = 2460
integer width = 4599
end type

type dw_sheet from u_vi_std_datawindow within w_piss380i
integer x = 18
integer y = 216
integer width = 4599
integer height = 2228
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss380i_01_rev1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_area from u_pisc_select_area within w_piss380i
integer x = 795
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_sheet.reset()
dw_print.reset()
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
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss380i
integer x = 1367
integer y = 100
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
dw_print.reset()
end event

type uo_date from u_pisc_date_applydate within w_piss380i
integer x = 73
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_losefocus;call super::ue_losefocus;is_prddate = is_uo_date
end event

event constructor;call super::constructor;is_prddate = is_uo_date
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;if is_prddate <> is_uo_date then
	dw_sheet.reset()
	dw_print.reset()
end if	
is_prddate = is_uo_date

end event

type sle_1 from singlelineedit within w_piss380i
integer x = 2752
integer y = 84
integer width = 1856
integer height = 128
integer taborder = 20
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
boolean border = false
end type

type ddlb_1 from dropdownlistbox within w_piss380i
integer x = 2176
integer y = 100
integer width = 457
integer height = 280
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 15780518
boolean sorted = false
string item[] = {"��ü","���(+)","���(-)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index = 1 then
	is_gubun = 'A'
elseif index = 2 then
	is_gubun = 'B'
elseif index = 3 then
	is_gubun = 'C'
end if
end event

type st_2 from statictext within w_piss380i
integer x = 1952
integer y = 112
integer width = 215
integer height = 64
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
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_print from datawindow within w_piss380i
boolean visible = false
integer x = 2990
integer y = 416
integer width = 686
integer height = 400
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_piss380i_01_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss380i
integer x = 23
integer y = 28
integer width = 2670
integer height = 172
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "��ȸ����"
end type

