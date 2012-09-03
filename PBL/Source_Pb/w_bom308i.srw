$PBExportHeader$w_bom308i.srw
$PBExportComments$���������� BOM �ܰ��̵�� (���ϰ���)
forward
global type w_bom308i from w_origin_sheet02
end type
type st_3 from statictext within w_bom308i
end type
type dw_cost_report from datawindow within w_bom308i
end type
type dw_ind_list from datawindow within w_bom308i
end type
type st_4 from statictext within w_bom308i
end type
type ddlb_dvd from dropdownlistbox within w_bom308i
end type
type uo_1 from uo_plandiv_pdcd within w_bom308i
end type
type pb_down from picturebutton within w_bom308i
end type
type dw_4 from datawindow within w_bom308i
end type
type dw_bom308i_01 from u_vi_std_datawindow within w_bom308i
end type
type gb_3 from groupbox within w_bom308i
end type
end forward

global type w_bom308i from w_origin_sheet02
integer width = 5211
integer height = 4248
string title = "���ϼ��� BOM�ܰ� �̵��ǰ��ȸ"
st_3 st_3
dw_cost_report dw_cost_report
dw_ind_list dw_ind_list
st_4 st_4
ddlb_dvd ddlb_dvd
uo_1 uo_1
pb_down pb_down
dw_4 dw_4
dw_bom308i_01 dw_bom308i_01
gb_3 gb_3
end type
global w_bom308i w_bom308i

type variables
string 	is_dvsn, is_pdcd,is_plant,is_year,is_month,is_modstring,is_modstringind
string 	is_itno	            
int 		in_tab_index,in_rowcnt
long 		in_tabcnt
string 	is_uochkplant,is_uochkdvsn, is_uochkpdcd
dec 		id_uochkyear
end variables

forward prototypes
public subroutine wf_set_valuelist (string a_pastdate, string a_comsec)
public subroutine wf_reset ()
end prototypes

public subroutine wf_set_valuelist (string a_pastdate, string a_comsec);
end subroutine

public subroutine wf_reset ();
end subroutine

on w_bom308i.create
int iCurrent
call super::create
this.st_3=create st_3
this.dw_cost_report=create dw_cost_report
this.dw_ind_list=create dw_ind_list
this.st_4=create st_4
this.ddlb_dvd=create ddlb_dvd
this.uo_1=create uo_1
this.pb_down=create pb_down
this.dw_4=create dw_4
this.dw_bom308i_01=create dw_bom308i_01
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_cost_report
this.Control[iCurrent+3]=this.dw_ind_list
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.ddlb_dvd
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.pb_down
this.Control[iCurrent+8]=this.dw_4
this.Control[iCurrent+9]=this.dw_bom308i_01
this.Control[iCurrent+10]=this.gb_3
end on

on w_bom308i.destroy
call super::destroy
destroy(this.st_3)
destroy(this.dw_cost_report)
destroy(this.dw_ind_list)
destroy(this.st_4)
destroy(this.ddlb_dvd)
destroy(this.uo_1)
destroy(this.pb_down)
destroy(this.dw_4)
destroy(this.dw_bom308i_01)
destroy(this.gb_3)
end on

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve") 
end if
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar �� Height �Ǵ� Width �� 20 
Integer ls_gap = 10 		// window �� dw_control �� Gap�� 5
Integer ls_status = 100 // statusbar �� ���̴� 120 ( Gap ���� )

dw_bom308i_01.Width = newwidth 	- ( ls_gap * 3 + 20)
dw_bom308i_01.Height= newheight - ( dw_bom308i_01.y + ls_status + 20 )
end event

event open;call super::open;dw_bom308i_01.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_4.insertrow(0)

i_b_print = false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;SetPointer(HourGlass!)
string  ls_plant,ls_div,ls_pdcd,ls_rtncd,ls_message,ls_applydate, ls_fromdt, ls_todt

ls_rtncd 	= uo_1.uf_return()
ls_applydate = dw_4.getitemstring(1,"zdate")
ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
ls_fromdt = mid(ls_applydate,1,6) + '01'
ls_todt = mid(ls_applydate,1,6) + '31'


dw_bom308i_01.reset()
if dw_bom308i_01.retrieve(g_s_company, ls_fromdt, ls_todt, ls_applydate, ls_plant, ls_div, ls_pdcd ) > 0 then
	uo_status.st_message.text = "��ȸ�Ǿ����ϴ�."
else
	uo_status.st_message.text = "��ȸ�� ����Ÿ�� �����ϴ�"
end if

return 0

end event

type uo_status from w_origin_sheet02`uo_status within w_bom308i
end type

type st_3 from statictext within w_bom308i
integer x = 55
integer y = 168
integer width = 288
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
string text = "��������"
boolean focusrectangle = false
end type

type dw_cost_report from datawindow within w_bom308i
boolean visible = false
integer x = 3255
integer y = 152
integer width = 123
integer height = 92
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_307i_report_costlist_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_ind_list from datawindow within w_bom308i
boolean visible = false
integer x = 3406
integer y = 28
integer width = 160
integer height = 268
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_307i_report_indcost"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_bom308i
integer x = 891
integer y = 172
integer width = 343
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "���񱸺�"
boolean focusrectangle = false
end type

type ddlb_dvd from dropdownlistbox within w_bom308i
integer x = 1225
integer y = 160
integer width = 608
integer height = 424
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 15780518
boolean enabled = false
string text = "none"
boolean sorted = false
string item[] = {"���庰(������)","����(������)","���庰(������)","����(������)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;wf_reset()
end event

type uo_1 from uo_plandiv_pdcd within w_bom308i
integer x = 59
integer y = 28
integer taborder = 70
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd::destroy
end on

type pb_down from picturebutton within w_bom308i
integer x = 1897
integer y = 148
integer width = 274
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_bom308i_01)
end event

type dw_4 from datawindow within w_bom308i
integer x = 343
integer y = 160
integer width = 471
integer height = 88
integer taborder = 30
boolean bringtotop = true
string dataobject = "dddw_bom306i_select_zdate"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_bom308i_01 from u_vi_std_datawindow within w_bom308i
integer x = 9
integer y = 296
integer width = 3346
integer height = 1616
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_bom308i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_3 from groupbox within w_bom308i
integer x = 9
integer y = 12
integer width = 4562
integer height = 264
integer taborder = 70
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type
