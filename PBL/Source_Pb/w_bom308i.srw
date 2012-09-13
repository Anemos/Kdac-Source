$PBExportHeader$w_bom308i.srw
$PBExportComments$가공관리비 BOM 단가미등록 (일일결산용)
forward
global type w_bom308i from w_origin_sheet02
end type
type st_3 from statictext within w_bom308i
end type
type dw_cost_report from datawindow within w_bom308i
end type
type dw_ind_list from datawindow within w_bom308i
end type
type uo_1 from uo_plandiv_pdcd within w_bom308i
end type
type pb_down from picturebutton within w_bom308i
end type
type dw_4 from datawindow within w_bom308i
end type
type dw_bom308i_01 from u_vi_std_datawindow within w_bom308i
end type
type tab_work from tab within w_bom308i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_bom308i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_bom308i_02 from u_vi_std_datawindow within w_bom308i
end type
type uo_date from uo_ccyymm_mps within w_bom308i
end type
type gb_3 from groupbox within w_bom308i
end type
end forward

global type w_bom308i from w_origin_sheet02
integer width = 5248
integer height = 4352
string title = "일일손익 BOM단가 미등록품조회"
st_3 st_3
dw_cost_report dw_cost_report
dw_ind_list dw_ind_list
uo_1 uo_1
pb_down pb_down
dw_4 dw_4
dw_bom308i_01 dw_bom308i_01
tab_work tab_work
dw_bom308i_02 dw_bom308i_02
uo_date uo_date
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
this.uo_1=create uo_1
this.pb_down=create pb_down
this.dw_4=create dw_4
this.dw_bom308i_01=create dw_bom308i_01
this.tab_work=create tab_work
this.dw_bom308i_02=create dw_bom308i_02
this.uo_date=create uo_date
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_cost_report
this.Control[iCurrent+3]=this.dw_ind_list
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.pb_down
this.Control[iCurrent+6]=this.dw_4
this.Control[iCurrent+7]=this.dw_bom308i_01
this.Control[iCurrent+8]=this.tab_work
this.Control[iCurrent+9]=this.dw_bom308i_02
this.Control[iCurrent+10]=this.uo_date
this.Control[iCurrent+11]=this.gb_3
end on

on w_bom308i.destroy
call super::destroy
destroy(this.st_3)
destroy(this.dw_cost_report)
destroy(this.dw_ind_list)
destroy(this.uo_1)
destroy(this.pb_down)
destroy(this.dw_4)
destroy(this.dw_bom308i_01)
destroy(this.tab_work)
destroy(this.dw_bom308i_02)
destroy(this.uo_date)
destroy(this.gb_3)
end on

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve") 
end if
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

tab_work.Width = newwidth - ( tab_work.x + 10 ) 
dw_bom308i_01.Width = newwidth 	- ( ls_gap * 3 + 20)
dw_bom308i_01.Height= newheight - ( dw_bom308i_01.y + ls_status + 20 )

dw_bom308i_02.x= dw_bom308i_01.x
dw_bom308i_02.y= dw_bom308i_01.y
dw_bom308i_02.Width = dw_bom308i_01.Width
dw_bom308i_02.Height= dw_bom308i_01.Height

uo_date.x = dw_4.x
uo_date.y = dw_4.y

end event

event open;call super::open;dw_bom308i_01.settransobject(sqlca)
dw_bom308i_02.settransobject(sqlca)
dw_4.settransobject(sqlca)
dw_4.insertrow(0)

i_b_print = false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;SetPointer(HourGlass!)
string  ls_plant,ls_div,ls_pdcd,ls_rtncd,ls_message,ls_applydate, ls_fromdt, ls_todt, ls_yyyymm

ls_rtncd 	= uo_1.uf_return()
ls_applydate = dw_4.getitemstring(1,"zdate")
ls_plant 	= trim(mid(ls_rtncd,1,1)) + '%' 
ls_div   	= trim(mid(ls_rtncd,2,1)) + '%' 
ls_pdcd  	= trim(mid(ls_rtncd,3,2)) + '%' 
ls_yyyymm 	= uo_date.uf_yyyymm()


if tab_work.SelectedTab = 1 then
	if f_spacechk(ls_applydate) = -1 then
		uo_status.st_message.text = "기준일자를 선택하세요."
		return -1
	end if
	
	ls_fromdt = mid(ls_applydate,1,6) + '01'
   ls_todt = mid(ls_applydate,1,6) + '31'
	
	dw_bom308i_01.reset()
	if dw_bom308i_01.retrieve(g_s_company, ls_fromdt, ls_todt, ls_applydate, ls_plant, ls_div, ls_pdcd ) > 0 then
		uo_status.st_message.text = "조회되었습니다."
	else
		uo_status.st_message.text = "조회할 데이타가 없습니다"
	end if
else
	ls_fromdt = ls_yyyymm + '01'
	ls_todt = ls_yyyymm + '31'
	
	dw_bom308i_02.reset()
	if dw_bom308i_02.retrieve(g_s_company, ls_fromdt, ls_todt, ls_yyyymm, ls_plant, ls_div, ls_pdcd ) > 0 then
		uo_status.st_message.text = "조회되었습니다."
	else
		uo_status.st_message.text = "조회할 데이타가 없습니다"
	end if
end if

return 0

end event

type uo_status from w_origin_sheet02`uo_status within w_bom308i
end type

type st_3 from statictext within w_bom308i
integer x = 32
integer y = 320
integer width = 288
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준일자"
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
integer x = 2642
integer y = 36
integer width = 274
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if tab_work.SelectedTab = 1 then
	f_save_to_excel(dw_bom308i_01)
else
	f_save_to_excel(dw_bom308i_02)
end if
end event

type dw_4 from datawindow within w_bom308i
integer x = 329
integer y = 312
integer width = 471
integer height = 88
integer taborder = 30
boolean bringtotop = true
string dataobject = "dddw_bom306i_select_zdate"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_bom308i_01 from u_vi_std_datawindow within w_bom308i
integer x = 14
integer y = 432
integer width = 1842
integer height = 1632
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_bom308i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type tab_work from tab within w_bom308i
event type long ue_retrieve ( integer ai_selectedtab )
event create ( )
event destroy ( )
integer x = 18
integer y = 180
integer width = 1152
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event type long ue_retrieve(integer ai_selectedtab);//Long ll_ret 
//
//dw_header.SetRedraw(False); dw_mhlist.SetRedraw(False) 
//
//dw_header.SetTransObject(SqlPIS) 
//dw_header.Retrieve(String(ai_selectedtab)) 
//
////If ai_selectedtab = 1 Then 		// 공수투입 현황
//	dw_mhlist.SetTransObject(SqlPIS)
//	ll_ret = dw_mhlist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.from_date, istr_mh.to_date, String(ai_selectedtab)) 
//	
////ElseIf ai_selectedtab = 2 Then 	// 공수투입 상세현황 
////	dw_mhdetaillist.SetTransObject(SqlPIS)
////	Return dw_mhdetaillist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.from_date, istr_mh.to_date)
////End If
//
//dw_header.SetRedraw(True); dw_mhlist.SetRedraw(True) 
//Return ll_ret 
return 0
end event

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;
Choose Case newindex 
	Case 1
		dw_bom308i_01.Visible = True 
		dw_4.Visible = True
		dw_bom308i_02.Visible = False 
		uo_date.Visible = False
	Case 2
		dw_bom308i_02.Visible = True 
		uo_date.Visible = True
		dw_4.Visible = False
		dw_bom308i_01.Visible = False 
End Choose 
end event

type tabpage_1 from userobject within tab_work
string tag = "단가 미등록품 조회"
integer x = 18
integer y = 100
integer width = 1115
integer height = -4
long backcolor = 12632256
string text = "일결산용"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
string tag = "단가 미등록품 조회"
integer x = 18
integer y = 100
integer width = 1115
integer height = -4
long backcolor = 12632256
string text = "월결산용"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_bom308i_02 from u_vi_std_datawindow within w_bom308i
integer x = 1902
integer y = 432
integer width = 1989
integer height = 1632
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_bom308i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_date from uo_ccyymm_mps within w_bom308i
event destroy ( )
integer x = 891
integer y = 316
integer taborder = 60
boolean bringtotop = true
end type

on uo_date.destroy
call uo_ccyymm_mps::destroy
end on

event constructor;call super::constructor;string ls_date
ls_date = uf_add_month_mps(mid(g_s_date,1,6),-1)
this.uf_reset(integer(mid(ls_date,1,4)),integer(mid(ls_date,5,2)))

end event

event ue_modify;call super::ue_modify;dw_bom308i_02.reset()
end event

type gb_3 from groupbox within w_bom308i
integer x = 18
integer y = 12
integer width = 3049
integer height = 148
integer taborder = 70
integer textsize = -2
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

