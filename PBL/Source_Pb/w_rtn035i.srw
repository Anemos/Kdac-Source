$PBExportHeader$w_rtn035i.srw
$PBExportComments$라우팅 표준시간 조회
forward
global type w_rtn035i from w_origin_sheet02
end type
type st_4 from statictext within w_rtn035i
end type
type tv_indent from treeview within w_rtn035i
end type
type dw_indentlist from datawindow within w_rtn035i
end type
type em_1 from editmask within w_rtn035i
end type
type pb_excel from picturebutton within w_rtn035i
end type
type rb_line from radiobutton within w_rtn035i
end type
type rb_outline from radiobutton within w_rtn035i
end type
type gb_1 from groupbox within w_rtn035i
end type
type str_bomdata_info from structure within w_rtn035i
end type
end forward

type str_bomdata_info from structure
	string		it_wkct
	string		it_opcd
	string		it_edtm
	string		it_edte
end type

global type w_rtn035i from w_origin_sheet02
integer width = 4768
integer height = 2908
string title = "BOM/Routing 정보"
st_4 st_4
tv_indent tv_indent
dw_indentlist dw_indentlist
em_1 em_1
pb_excel pb_excel
rb_line rb_line
rb_outline rb_outline
gb_1 gb_1
end type
global w_rtn035i w_rtn035i

type variables
datastore ids_data1[],ids_data2,ids_data3
protected:
string root_nm , i_s_setdate , li_chk_option
integer i_n_pos,i_l_mid ,i_n_curlevel,li_chk_level
//integer i_n_hold,i_n_wkhold   //재료비계산에서 쓰이는 변수
dec{3} ic_set_pqtym[]      //[a,b] a:레벨 b:자동핸들부여값
long i_l_cnt


end variables

forward prototypes
public subroutine wf_init ()
private subroutine wf_add_items (long ag_parent, integer ag_level, integer ag_rows, ref treeview ag_this)
public function str_bomdata_info wf_get_bomdata (string a_plant, string a_div, string a_pitno, string a_citno, string a_date)
private subroutine wf_itempopulate (long ag_handle, ref treeview ag_tvcurrent)
public subroutine wf_lvitempop (long ag_handle, treeview ag_tvcurrent, string ag_chk)
private subroutine wf_set_items (integer ag_level, integer ag_row, ref treeviewitem ag_tvinew, long ag_phandle, ref treeview ag_this)
end prototypes

public subroutine wf_init ();em_1.backcolor = rgb(255,250,239)
end subroutine

private subroutine wf_add_items (long ag_parent, integer ag_level, integer ag_rows, ref treeview ag_this);
end subroutine

public function str_bomdata_info wf_get_bomdata (string a_plant, string a_div, string a_pitno, string a_citno, string a_date);str_bomdata_info a_str
string ls_midval,ls_kijun_date
integer li_cnt

select pwkct,pedtm,pedte 
	into :a_str.it_wkct,:a_str.it_edtm,:a_str.it_edte
from "PBPDM"."BOM001" a
where   a.plant = :a_plant and 
        a.pdvsn = :a_div   and
		a.ppitn = :a_pitno and
		a.pcitn = :a_citno and a.pchdt = :a_date using sqlca;
if f_spacechk(a_str.it_wkct) = -1 then
	select hwkct,hedtm,hedte 
		into :a_str.it_wkct,:a_str.it_edtm,:a_str.it_edte
	from "PBPDM"."BOM002" 
	where   hplant = :a_plant and
	        hdvsn  = :a_div and
			hpitn  = :a_pitno and
			hcitn  = :a_citno and hchdt = :a_date using sqlca;
end if
em_1.getdata(ls_kijun_date)
ls_midval = f_option_chk_after(a_plant,a_div,a_citno,ls_kijun_date) 
if ls_midval <> '    ' then
	if ls_midval = a_citno then
		ls_midval = '*'
	end if
end if
a_str.it_opcd = ls_midval
return a_str
end function

private subroutine wf_itempopulate (long ag_handle, ref treeview ag_tvcurrent);
end subroutine

public subroutine wf_lvitempop (long ag_handle, treeview ag_tvcurrent, string ag_chk);
end subroutine

private subroutine wf_set_items (integer ag_level, integer ag_row, ref treeviewitem ag_tvinew, long ag_phandle, ref treeview ag_this);
end subroutine

on w_rtn035i.create
int iCurrent
call super::create
this.st_4=create st_4
this.tv_indent=create tv_indent
this.dw_indentlist=create dw_indentlist
this.em_1=create em_1
this.pb_excel=create pb_excel
this.rb_line=create rb_line
this.rb_outline=create rb_outline
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.tv_indent
this.Control[iCurrent+3]=this.dw_indentlist
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.pb_excel
this.Control[iCurrent+6]=this.rb_line
this.Control[iCurrent+7]=this.rb_outline
this.Control[iCurrent+8]=this.gb_1
end on

on w_rtn035i.destroy
call super::destroy
destroy(this.st_4)
destroy(this.tv_indent)
destroy(this.dw_indentlist)
destroy(this.em_1)
destroy(this.pb_excel)
destroy(this.rb_line)
destroy(this.rb_outline)
destroy(this.gb_1)
end on

event open;call super::open;long l_n_root, l_n_rows
integer l_n_cnt
date ld_curdate
string ls_chgdate
treeviewitem l_tvi_root

setpointer(HourGlass!)

// f_window_resize(this)
pb_excel.enabled = false

em_1.text = g_s_date
wf_init()

i_b_insert = false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)

return 0
end event

event close;call super::close;integer l_n_cnt
for l_n_cnt = 1 to 16
	destroy ids_Data1[l_n_cnt]
next
destroy ids_Data2 
destroy ids_data3
end event

event ue_retrieve;long           l_n_rows
integer        l_n_count
string         l_s_plant,l_s_div, l_s_itno, root_data,l_s_itnm, ls_month
date           ld_refdate


uo_status.st_message.text = ""
//SetPointer(HourGlass!)

// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)

ld_refdate = date(em_1.text)
i_s_setdate = f_dateedit(string(ld_refdate,"yyyy/mm/dd"))
if i_s_setdate = space(8) then
	uo_status.st_message.text = f_message("E290")
	em_1.backcolor = rgb(255,255,0)
	em_1.setfocus()
	return 0
else
	em_1.backcolor = rgb(255,250,239)
end if

f_pism_working_msg(This.title,"Routing 정보를 조회중입니다. 잠시만 기다려 주십시오.") 

dw_indentlist.reset()

l_n_rows = dw_indentlist.retrieve(g_s_company,i_s_setdate)
If IsValid(w_pism_working) Then Close(w_pism_working) 
if l_n_rows = 0 then
	pb_excel.enabled = false
	uo_status.st_message.text = f_message("I020")
	return -1
else
	if rb_line.checked then
		dw_indentlist.setredraw(false)
		dw_indentlist.setfilter("cls <> '50'")
		dw_indentlist.Filter()
		dw_indentlist.setredraw(true)
	else
		dw_indentlist.setredraw(false)
		dw_indentlist.setfilter("cls = '50'")
		dw_indentlist.Filter()
		dw_indentlist.setredraw(true)
	end if
end if

pb_excel.enabled = true
return 0

end event

event resize;call super::resize;dw_indentlist.Width = newwidth - ( dw_indentlist.x + 10 ) 
dw_indentlist.Height = newheight - ( dw_indentlist.y + uo_status.Height + 10 ) 
end event

type uo_status from w_origin_sheet02`uo_status within w_rtn035i
end type

type st_4 from statictext within w_rtn035i
integer x = 1166
integer y = 72
integer width = 270
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준일자"
boolean focusrectangle = false
end type

type tv_indent from treeview within w_rtn035i
event ue_tvvscroll pbm_vscroll
boolean visible = false
integer x = 2601
integer y = 152
integer width = 123
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
integer indent = 1
boolean disabledragdrop = false
boolean tooltips = false
string picturename[] = {"Custom039!","Custom050!","Exit!","","","","","","","","","","","","",""}
long picturemaskcolor = 536870912
long statepicturemaskcolor = 536870912
end type

type dw_indentlist from datawindow within w_rtn035i
integer x = 18
integer y = 208
integer width = 4576
integer height = 2264
boolean bringtotop = true
string title = " "
string dataobject = "d_rtn035i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
else
	this.selectrow(0,false)
end if

return 0
end event

event constructor;this.settransobject(Sqlca)
end event

type em_1 from editmask within w_rtn035i
integer x = 1472
integer y = 60
integer width = 379
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

type pb_excel from picturebutton within w_rtn035i
integer x = 2112
integer y = 44
integer width = 174
integer height = 132
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_indentlist)
end event

type rb_line from radiobutton within w_rtn035i
integer x = 87
integer y = 68
integer width = 457
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "사내라인"
boolean checked = true
end type

type rb_outline from radiobutton within w_rtn035i
integer x = 539
integer y = 68
integer width = 425
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "사내외주"
end type

type gb_1 from groupbox within w_rtn035i
integer x = 14
integer width = 4581
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

