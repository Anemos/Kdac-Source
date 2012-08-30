$PBExportHeader$w_bom303i.srw
$PBExportComments$가공관리비 M-BOM 조회(견적)
forward
global type w_bom303i from w_origin_sheet02
end type
type st_3 from statictext within w_bom303i
end type
type sle_itno from singlelineedit within w_bom303i
end type
type st_4 from statictext within w_bom303i
end type
type st_5 from statictext within w_bom303i
end type
type st_6 from statictext within w_bom303i
end type
type sle_ininv from singlelineedit within w_bom303i
end type
type sle_outinv from singlelineedit within w_bom303i
end type
type ddlb_choice from dropdownlistbox within w_bom303i
end type
type pb_itemfind from picturebutton within w_bom303i
end type
type st_8 from statictext within w_bom303i
end type
type uo_today from uo_today_bom within w_bom303i
end type
type pb_excel from picturebutton within w_bom303i
end type
type pb_print from picturebutton within w_bom303i
end type
type dw_print from datawindow within w_bom303i
end type
type uo_plant from uo_plandiv_bom within w_bom303i
end type
type tab_history from tab within w_bom303i
end type
type tabpage_indent from userobject within tab_history
end type
type dw_indent from datawindow within tabpage_indent
end type
type tabpage_indent from userobject within tab_history
dw_indent dw_indent
end type
type tabpage_partlist from userobject within tab_history
end type
type dw_partlist from datawindow within tabpage_partlist
end type
type tabpage_partlist from userobject within tab_history
dw_partlist dw_partlist
end type
type tabpage_single from userobject within tab_history
end type
type rb_implo from radiobutton within tabpage_single
end type
type rb_explo from radiobutton within tabpage_single
end type
type dw_single from datawindow within tabpage_single
end type
type gb_1 from groupbox within tabpage_single
end type
type tabpage_single from userobject within tab_history
rb_implo rb_implo
rb_explo rb_explo
dw_single dw_single
gb_1 gb_1
end type
type tab_history from tab within w_bom303i
tabpage_indent tabpage_indent
tabpage_partlist tabpage_partlist
tabpage_single tabpage_single
end type
type st_7 from statictext within w_bom303i
end type
type sle_osinv from singlelineedit within w_bom303i
end type
type st_1 from statictext within w_bom303i
end type
type rb_pre from radiobutton within w_bom303i
end type
type rb_post from radiobutton within w_bom303i
end type
type dw_condition_info1 from datawindow within w_bom303i
end type
type gb_2 from groupbox within w_bom303i
end type
type gb_3 from groupbox within w_bom303i
end type
type str_bomdata_info from structure within w_bom303i
end type
end forward

type str_bomdata_info from structure
	string		it_wkct
	string		it_opcd
	string		it_edtm
	string		it_edte
end type

global type w_bom303i from w_origin_sheet02
integer width = 4658
integer height = 2708
string title = "History 조회"
st_3 st_3
sle_itno sle_itno
st_4 st_4
st_5 st_5
st_6 st_6
sle_ininv sle_ininv
sle_outinv sle_outinv
ddlb_choice ddlb_choice
pb_itemfind pb_itemfind
st_8 st_8
uo_today uo_today
pb_excel pb_excel
pb_print pb_print
dw_print dw_print
uo_plant uo_plant
tab_history tab_history
st_7 st_7
sle_osinv sle_osinv
st_1 st_1
rb_pre rb_pre
rb_post rb_post
dw_condition_info1 dw_condition_info1
gb_2 gb_2
gb_3 gb_3
end type
global w_bom303i w_bom303i

type variables
decimal{3}	id_dom_moveamount		=	0,id_exp_moveamount	=	0,id_out_moveamount	=	0,id_fos_moveamount	=	0,&
				id_dom_inputamount	=	0,id_exp_inputamount	=	0,id_out_inputamount	=	0,id_fos_inputamount	=	0,&
				id_dom_outamount		=	0,id_exp_outamount	=	0,id_out_outamount	=	0,id_fos_outamount	=	0
end variables

forward prototypes
public subroutine wf_reset ()
end prototypes

public subroutine wf_reset ();tab_history.tabpage_indent.dw_indent.reset()
tab_history.tabpage_partlist.dw_partlist.reset()
tab_history.tabpage_single.dw_single.reset()
dw_condition_info1.reset()
sle_ininv.text		= 	''
sle_outinv.text	= 	''
sle_osinv.text	= 	''
end subroutine

on w_bom303i.create
int iCurrent
call super::create
this.st_3=create st_3
this.sle_itno=create sle_itno
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.sle_ininv=create sle_ininv
this.sle_outinv=create sle_outinv
this.ddlb_choice=create ddlb_choice
this.pb_itemfind=create pb_itemfind
this.st_8=create st_8
this.uo_today=create uo_today
this.pb_excel=create pb_excel
this.pb_print=create pb_print
this.dw_print=create dw_print
this.uo_plant=create uo_plant
this.tab_history=create tab_history
this.st_7=create st_7
this.sle_osinv=create sle_osinv
this.st_1=create st_1
this.rb_pre=create rb_pre
this.rb_post=create rb_post
this.dw_condition_info1=create dw_condition_info1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.sle_itno
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_5
this.Control[iCurrent+5]=this.st_6
this.Control[iCurrent+6]=this.sle_ininv
this.Control[iCurrent+7]=this.sle_outinv
this.Control[iCurrent+8]=this.ddlb_choice
this.Control[iCurrent+9]=this.pb_itemfind
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.uo_today
this.Control[iCurrent+12]=this.pb_excel
this.Control[iCurrent+13]=this.pb_print
this.Control[iCurrent+14]=this.dw_print
this.Control[iCurrent+15]=this.uo_plant
this.Control[iCurrent+16]=this.tab_history
this.Control[iCurrent+17]=this.st_7
this.Control[iCurrent+18]=this.sle_osinv
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.rb_pre
this.Control[iCurrent+21]=this.rb_post
this.Control[iCurrent+22]=this.dw_condition_info1
this.Control[iCurrent+23]=this.gb_2
this.Control[iCurrent+24]=this.gb_3
end on

on w_bom303i.destroy
call super::destroy
destroy(this.st_3)
destroy(this.sle_itno)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.sle_ininv)
destroy(this.sle_outinv)
destroy(this.ddlb_choice)
destroy(this.pb_itemfind)
destroy(this.st_8)
destroy(this.uo_today)
destroy(this.pb_excel)
destroy(this.pb_print)
destroy(this.dw_print)
destroy(this.uo_plant)
destroy(this.tab_history)
destroy(this.st_7)
destroy(this.sle_osinv)
destroy(this.st_1)
destroy(this.rb_pre)
destroy(this.rb_post)
destroy(this.dw_condition_info1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;setpointer(HourGlass!)
this.uo_status.st_winid.text 	= this.classname()
this.uo_status.st_kornm.text 	= g_s_kornm
this.uo_status.st_date.text 	= string(g_s_date, "@@@@-@@-@@")
sle_itno.setfocus()
i_b_insert 	= false
i_b_print	= false
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
			     i_b_dprint,    i_b_dchar)


end event

event key;call super::key;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if
end event

event ue_retrieve;call super::ue_retrieve;string  	ls_plant,ls_div,ls_itno,ls_date
integer 	ln_count

SetPointer(HourGlass!)
ls_plant 	= 	trim(uo_plant.dw_1.getitemstring(1,'xplant'))
ls_div   	= 	trim(uo_plant.dw_1.getitemstring(1,'div'))
ls_itno  	= 	upper(trim(sle_itno.text))
ls_date		=	f_dateedit(uo_today.is_uo_date)
sle_ininv.text		= 	''
sle_outinv.text	= 	''
sle_osinv.text		= 	''
id_dom_inputamount	=	0
id_exp_inputamount	=	0	
id_fos_inputamount	=	0
id_out_inputamount	=	0

if f_spacechk(ls_itno) = -1 then
	uo_status.st_message.text = f_message("I020")
	sle_itno.setfocus()
	return 0
end if

dw_condition_info1.settransobject(sqlca)
dw_condition_info1.retrieve(g_s_company,ls_plant,ls_div,ls_itno)

if	tab_history.selectedtab	=	1	then
	if trim(ddlb_choice.text) = "전체 전개" then
		f_creation_bom_sf(g_s_company,ls_plant,ls_div,ls_itno,ls_date,'A')
	else
		f_creation_bom_sf(g_s_company,ls_plant,ls_div,ls_itno,ls_date,'C')
	end if
	
	tab_history.tabpage_indent.dw_indent.reset()
	if mid(ls_date,1,6) >= mid(g_s_date,1,6) then
		tab_history.tabpage_indent.dw_indent.dataobject	=	'd_bom303i_indent_current'
		tab_history.tabpage_indent.dw_indent.settransobject(sqlca)
		ln_count = 	tab_history.tabpage_indent.dw_indent.retrieve()
	else
		tab_history.tabpage_indent.dw_indent.dataobject	=	'd_bom303i_indent_history'
		tab_history.tabpage_indent.dw_indent.settransobject(sqlca)
		ln_count = 	tab_history.tabpage_indent.dw_indent.retrieve(mid(ls_date,1,6))
	end if
elseif	tab_history.selectedtab	=	2	then
	if trim(ddlb_choice.text) = "전체 전개" then
		f_creation_bom_sf(g_s_company,ls_plant,ls_div,ls_itno,ls_date,'A')
	else
		f_creation_bom_sf(g_s_company,ls_plant,ls_div,ls_itno,ls_date,'C')
	end if
	
	tab_history.tabpage_partlist.dw_partlist.reset()
	if mid(ls_date,1,6) >= mid(g_s_date,1,6) then
		tab_history.tabpage_partlist.dw_partlist.dataobject	=	'd_bom301i_partlist_current'
		tab_history.tabpage_partlist.dw_partlist.settransobject(sqlca)
		ln_count = 	tab_history.tabpage_partlist.dw_partlist.retrieve()
	else
		tab_history.tabpage_partlist.dw_partlist.dataobject	=	'd_bom301i_partlist_history'
		tab_history.tabpage_partlist.dw_partlist.settransobject(sqlca)
		ln_count = 	tab_history.tabpage_partlist.dw_partlist.retrieve(mid(ls_date,1,6))
	end if
elseif	tab_history.selectedtab	=	3	then
	tab_history.tabpage_single.dw_single.reset()
	if mid(ls_date,1,6) >= mid(g_s_date,1,6) then
		if tab_history.tabpage_single.rb_explo.checked	=	true	then
			tab_history.tabpage_single.dw_single.dataobject	=	'd_bom301i_single_current_explo'
			tab_history.tabpage_single.dw_single.settransobject(sqlca)
		elseif	tab_history.tabpage_single.rb_implo.checked	=	true	then
			tab_history.tabpage_single.dw_single.dataobject	=	'd_bom301i_single_current_implo'
			tab_history.tabpage_single.dw_single.settransobject(sqlca)
		end if
	else
		if tab_history.tabpage_single.rb_explo.checked	=	true	then
			tab_history.tabpage_single.dw_single.dataobject	=	'd_bom301i_single_history_explo'
			tab_history.tabpage_single.dw_single.settransobject(sqlca)
		elseif	tab_history.tabpage_single.rb_implo.checked	=	true	then
			tab_history.tabpage_single.dw_single.dataobject	=	'd_bom301i_single_history_implo'
			tab_history.tabpage_single.dw_single.settransobject(sqlca)
		end if
	end if
	ln_count = 	tab_history.tabpage_single.dw_single.retrieve(ls_plant,ls_div,ls_itno,ls_date)
end if
pb_print.visible		=	false
pb_print.enabled		=	false
if ln_count < 1 then
	pb_excel.visible	=	false
	pb_excel.enabled	=	false
	uo_status.st_message.text 	= f_message("I020")
else
	pb_excel.visible	=	true
	pb_excel.enabled	=	true
	if	tab_history.selectedtab	<>	3	then
		pb_print.visible	=	true
		pb_print.enabled	=	true
	end if
	uo_status.st_message.text 	= f_message("I010")
end if


end event

type uo_status from w_origin_sheet02`uo_status within w_bom303i
end type

type st_3 from statictext within w_bom303i
integer x = 1358
integer y = 60
integer width = 137
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
string text = "품번"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_bom303i
event ue_slekeydown pbm_keydown
integer x = 1504
integer y = 44
integer width = 512
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
textcase textcase = upper!
integer limit = 15
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_bom303i
integer x = 2322
integer y = 52
integer width = 279
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

type st_5 from statictext within w_bom303i
integer x = 3822
integer y = 36
integer width = 320
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "내  자(I)"
boolean focusrectangle = false
end type

type st_6 from statictext within w_bom303i
integer x = 3822
integer y = 112
integer width = 320
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "외  자(I)"
boolean focusrectangle = false
end type

type sle_ininv from singlelineedit within w_bom303i
integer x = 4137
integer y = 24
integer width = 448
integer height = 72
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
boolean righttoleft = true
end type

type sle_outinv from singlelineedit within w_bom303i
integer x = 4137
integer y = 96
integer width = 448
integer height = 72
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
boolean righttoleft = true
end type

type ddlb_choice from dropdownlistbox within w_bom303i
integer x = 2615
integer y = 140
integer width = 489
integer height = 336
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
string text = "공장별 전개"
boolean sorted = false
string item[] = {"공장별 전개","전체 전개"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;wf_reset()
end event

type pb_itemfind from picturebutton within w_bom303i
integer x = 2030
integer y = 32
integer width = 233
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string ls_parm, ls_plant,ls_div, ls_pdcd, ls_rtncd

ls_rtncd 		= uo_plant.uf_return()
ls_plant 		= mid(ls_rtncd,1,1)
ls_div 			= mid(ls_rtncd,2,1)
ls_pdcd  		= trim(mid(ls_rtncd,3))
ls_parm 			= ls_plant + ls_div + ls_pdcd
openwithparm(w_bom110u_res_03,ls_parm)
ls_parm 			= message.stringparm
sle_itno.text	= ls_parm

end event

type st_8 from statictext within w_bom303i
integer x = 2327
integer y = 156
integer width = 274
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
string text = "전개구분"
boolean focusrectangle = false
end type

type uo_today from uo_today_bom within w_bom303i
event ue_keydown pbm_keydown
integer x = 2615
integer y = 44
integer taborder = 70
boolean bringtotop = true
end type

on uo_today.destroy
call uo_today_bom::destroy
end on

event ue_select;call super::ue_select;wf_reset()
end event

type pb_excel from picturebutton within w_bom303i
boolean visible = false
integer x = 2098
integer y = 140
integer width = 169
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if	tab_history.selectedtab			=	1	then
	f_Save_to_Excel_number(tab_history.tabpage_indent.dw_indent)
elseif	tab_history.selectedtab	=	2	then
	f_Save_to_Excel_number(tab_history.tabpage_partlist.dw_partlist)	
elseif	tab_history.selectedtab	=	3	then
	f_Save_to_Excel_number(tab_history.tabpage_single.dw_single)
end if
end event

type pb_print from picturebutton within w_bom303i
boolean visible = false
integer x = 1911
integer y = 140
integer width = 169
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;treeviewitem l_tvi_cur
window 	l_to_open
str_easy l_str_prt
string 	mod_string,mod_costring
string 	ls_refdate,ls_divnm,ls_plant,ls_div,ls_date,ls_pdcd,ls_itno,ls_itnm,ls_prtdate,ls_comcd
integer 	ln_row,ln_rowcount,ln_currentrow
dec{0} 	ldc_total,ldc_total1,ldc_total2
									
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
uo_status.st_message.Text = "출력 준비중 입니다..."
SetPointer(HourGlass!)
ls_plant 		= 	trim(uo_plant.dw_1.getitemstring(1,'xplant'))
ls_div   		= 	trim(uo_plant.dw_1.getitemstring(1,'div'))
ls_itno  		= 	upper(trim(sle_itno.text))
SELECT 	"PBINV"."INV101"."PDCD"  INTO :ls_pdcd  	FROM "PBINV"."INV101"  
	WHERE "PBINV"."INV101"."COMLTD" 		= '01'  		AND  
			"PBINV"."INV101"."XPLANT" 		= :ls_plant AND  
			"PBINV"."INV101"."DIV" 			= :ls_div  	AND  
			"PBINV"."INV101"."ITNO"			= :ls_itno    
using sqlca;
ls_pdcd = mid(ls_pdcd,1,2)
ls_date			=	f_dateedit(uo_today.is_uo_date)
ls_refdate 		= 	string(mid(ls_date,1,8),"@@@@.@@.@@")
ls_divnm 		= 	f_bom_get_divname(ls_plant,ls_div)
ls_itnm 			= 	mid(f_bom_get_itemname(ls_itno),1,30)
ls_prtdate 		= 	string(g_s_date,"@@@@.@@.@@")
mod_costring 	= 	"refdate_t.text 		= '" + ls_refdate +	"'~tdivnm_t.text 	= '" + ls_divnm &
					+ 	"'~tmodelno_t.text 	= '" + ls_itno 	+ 	"'~titpdcd_t.text = '" + ls_pdcd &
					+ 	"'~tprtdate_t.text 	= '" + ls_prtdate + 	"'"
if tab_history.selectedtab =	1	then
	dw_print.reset()
	dw_print.dataobject = "d_report_indented_est"
	if rb_pre.checked then
		ls_comcd = '공제전 - 가공관리비'
	else
		ls_comcd = '공제후 - 가공관리비'
	end if
	ldc_total2 	= truncate(id_dom_inputamount,0) + truncate(id_exp_inputamount,0) + truncate(id_fos_inputamount,0)
	mod_string 	= mod_costring &
					+ "~tinucan_t.text 	= '" + string(truncate(id_dom_inputamount,0),"#,##0") + "'~toutucan_t.text 	= '" + string(truncate(id_exp_inputamount,0),"#,##0") +"'~t" &
					+ "fosucan_t.text 	= '" + string(truncate(id_fos_inputamount,0),"#,##0") + "'~ttotalucan_t.text 	= '" &
					+ string(ldc_total2,"#,##0") + "'~tosucan_t.text = '" + string(truncate(id_out_inputamount,0),"#,##0") + "'~tmodelnm_t.text = '" + ls_itnm + "'" &
					+ "~tcomcd_t.text 	= '" + ls_comcd + "'"
	ln_rowcount = tab_history.tabpage_indent.dw_indent.rowcount()
	for ln_row 	= 1 to ln_rowcount
		ln_currentrow 									= dw_print.insertrow(0)
		dw_print.object.lev[ln_currentrow] 			= right(tab_history.tabpage_indent.dw_indent.object.lev[ln_row],6)
		dw_print.object.itemno[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.tcitn[ln_row]
		dw_print.object.itdamdang[ln_currentrow] 	= tab_history.tabpage_indent.dw_indent.object.itdamdang[ln_row]
		dw_print.object.itemnm[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.itemname[ln_row]
    		dw_print.object.itspec[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.spec[ln_row]
		dw_print.object.itunmsr[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.xunit[ln_row]
		dw_print.object.itpqtym[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.tqty1[ln_row]
		dw_print.object.itiumcv[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.convqty[ln_row]
		dw_print.object.itprum[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.xunit1[ln_row]
		dw_print.object.itprunt[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.itprunt[ln_row]
		dw_print.object.itpcurr[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.itpcurr[ln_row]
		dw_print.object.itptod[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.itptod[ln_row]
		dw_print.object.itprutc[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.itprutc[ln_row]
		dw_print.object.itpvend[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.itpvend[ln_row]
		dw_print.object.itpvsrno[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.itpvsrno[ln_row]
		dw_print.object.itclsb[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.cls[ln_row]
		dw_print.object.itsrce[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.srce[ln_row]
  		dw_print.object.itlot[ln_currentrow] 			= tab_history.tabpage_indent.dw_indent.object.lotsize[ln_row]
		dw_print.object.itlead[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.leadtime[ln_row]
		dw_print.object.itiucan[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.inputdanga[ln_row]
		dw_print.object.itwkct[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.twkct[ln_row]
		dw_print.object.itopcd[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.toption[ln_row]
		dw_print.object.itptotdan[ln_currentrow] 	= tab_history.tabpage_indent.dw_indent.object.itptotdan[ln_row]
		dw_print.object.itedtm[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.tedtm[ln_row]
		dw_print.object.itedte[ln_currentrow] 		= tab_history.tabpage_indent.dw_indent.object.tedte[ln_row]
		if (tab_history.tabpage_indent.dw_indent.object.topchk[ln_row] = '2') or &
					( tab_history.tabpage_indent.dw_indent.object.srce[ln_row] = '03')	then
			dw_print.object.itoption[ln_currentrow] = 'X'
		else
			dw_print.object.itoption[ln_currentrow] = ' '
		end if
	next
elseif tab_history.selectedtab	=	2	then
	dw_print.reset()
	dw_print.dataobject 	= 	"d_report_partlist"
	mod_string 				= 	mod_costring
	ln_rowcount 			= 	tab_history.tabpage_partlist.dw_partlist.rowcount()
	for ln_row = 1 to ln_rowcount
		ln_currentrow = dw_print.insertrow(0)
		dw_print.object.itemno[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.tcitn[ln_row]
//		dw_print.object.itrev[ln_currentrow] 			= tab_history.tabpage_partlist.dw_partlist.object.itrev[ln_row]
		dw_print.object.itrev[ln_currentrow] 			= ''
		dw_print.object.itemnm[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.itemname[ln_row]
		dw_print.object.itspec[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.spec[ln_row]
		dw_print.object.itunmsr[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.xunit[ln_row]
		dw_print.object.itpqtym[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.sumqty[ln_row]
		dw_print.object.itiumcv[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.convqty[ln_row]
		dw_print.object.itprum[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.xunit1[ln_row]
		dw_print.object.itclsb[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.cls[ln_row]
		dw_print.object.itsrce[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.srce[ln_row]
		dw_print.object.itabc[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.abccd[ln_row]
		dw_print.object.itlot[ln_currentrow] 			= tab_history.tabpage_partlist.dw_partlist.object.lotsize[ln_row]
		dw_print.object.itlead[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.leadtime[ln_row]
		dw_print.object.itimasa[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.outdanga[ln_row]
		dw_print.object.itucav[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.movedanga[ln_row]
		dw_print.object.itiucan[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.inputdanga[ln_row]
		dw_print.object.itwkct[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.twkct[ln_row]
		dw_print.object.itopcd[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.toption[ln_row]
		dw_print.object.itedtm[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.tedtm[ln_row]
		dw_print.object.itedte[ln_currentrow] 		= tab_history.tabpage_partlist.dw_partlist.object.tedte[ln_row]
		if tab_history.tabpage_partlist.dw_partlist.object.tcalculate[ln_row] = 'N'	then
			dw_print.object.itoption[ln_currentrow] = 'X'
		else
			dw_print.object.itoption[ln_currentrow] = ' '
		end if
	next
end if
			
//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  	= sqlca
l_str_prt.datawindow   	= dw_print
l_str_prt.title 			= "BOM REPORT 화면"
l_str_prt.dwsyntax 		= mod_string
l_str_prt.tag			  	= This.ClassName()
f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""	
return 0
end event

type dw_print from datawindow within w_bom303i
boolean visible = false
integer x = 2304
integer y = 128
integer width = 146
integer height = 128
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_plant from uo_plandiv_bom within w_bom303i
event destroy ( )
integer x = 46
integer y = 28
integer taborder = 90
boolean bringtotop = true
end type

on uo_plant.destroy
call uo_plandiv_bom::destroy
end on

type tab_history from tab within w_bom303i
integer x = 37
integer y = 272
integer width = 4571
integer height = 2192
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_indent tabpage_indent
tabpage_partlist tabpage_partlist
tabpage_single tabpage_single
end type

on tab_history.create
this.tabpage_indent=create tabpage_indent
this.tabpage_partlist=create tabpage_partlist
this.tabpage_single=create tabpage_single
this.Control[]={this.tabpage_indent,&
this.tabpage_partlist,&
this.tabpage_single}
end on

on tab_history.destroy
destroy(this.tabpage_indent)
destroy(this.tabpage_partlist)
destroy(this.tabpage_single)
end on

event selectionchanged;pb_excel.visible	=	false
pb_excel.enabled	=	false
pb_print.visible	=	false
pb_print.enabled	=	false
if newindex = 1 then
	this.tabpage_indent.tabtextcolor 	= rgb(255,0,0)
	this.tabpage_partlist.tabtextcolor 	= rgb(0,0,0)
	this.tabpage_single.tabtextcolor 	= rgb(0,0,0)
	if	this.tabpage_indent.dw_indent.rowcount() > 0	then
		pb_excel.visible	=	true
		pb_excel.enabled	=	true
		pb_print.visible	=	true
		pb_print.enabled	=	true
	end if
elseif newindex = 2 then
	this.tabpage_indent.tabtextcolor 	= rgb(0,0,0)
	this.tabpage_partlist.tabtextcolor 	= rgb(255,0,0)
	this.tabpage_single.tabtextcolor 	= rgb(0,0,0)	
	if	this.tabpage_partlist.dw_partlist.rowcount() > 0	then
		pb_excel.visible	=	true
		pb_excel.enabled	=	true
		pb_print.visible	=	true
		pb_print.enabled	=	true
	end if
elseif newindex = 3 then
	this.tabpage_indent.tabtextcolor 	= rgb(0,0,0)
	this.tabpage_partlist.tabtextcolor 	= rgb(0,0,0)
	this.tabpage_single.tabtextcolor 	= rgb(255,0,0)
	if	this.tabpage_single.dw_single.rowcount() > 0	then
		pb_excel.visible	=	true
		pb_excel.enabled	=	true
	end if
end if

end event

type tabpage_indent from userobject within tab_history
integer x = 18
integer y = 100
integer width = 4535
integer height = 2076
long backcolor = 12632256
string text = "Indented BOM"
long tabtextcolor = 255
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_indent dw_indent
end type

on tabpage_indent.create
this.dw_indent=create dw_indent
this.Control[]={this.dw_indent}
end on

on tabpage_indent.destroy
destroy(this.dw_indent)
end on

type dw_indent from datawindow within tabpage_indent
integer x = 18
integer y = 28
integer width = 4498
integer height = 2036
integer taborder = 80
string dataobject = "d_bom303i_indent_current"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;s_opmdata_info opmdata
integer 		i
string		ls_plant,ls_div,ls_itno,ls_date,ls_vndname,ls_damdang, ls_option, ls_comcd 

ls_date		=	f_dateedit(uo_today.is_uo_date)

for	i	=	1	to	rowcount
	ls_plant	=	this.object.toplant[i]
	ls_div	=	this.object.todvsn[i]	
	ls_itno	=	this.object.tcitn[i]
	if	this.object.srce[i]	=	'01'	then
		opmdata 	= 	f_bom_get_opmdata(ls_plant,ls_div,this.object.tcitn[i],ls_date)
		this.setitem(i,"itprunt"	,	opmdata.it_prunt)
		this.setitem(i,"itpcurr"	,	opmdata.it_pcurr)
		this.setitem(i,"itptod"		,	opmdata.it_ptod)
		this.setitem(i,"itprutc"	,	opmdata.it_prutc)
		this.setitem(i,"itpvend"	,	opmdata.it_pvend)
		this.setitem(i,"itpvsrno"	, 	opmdata.it_pvsrno)
		this.setitem(i,"itptotdan"	, 	opmdata.it_prutc)
		this.setitem(i,"itdamdang"	, 	'')		
	elseif	this.object.srce[i]	= '02' or this.object.srce[i]	=	'04' then
		this.setitem(i,"itpcurr", "WON")
		ls_vndname = f_bom_get_itemvendor(ls_plant,ls_div,ls_itno,ls_date)
		this.setitem(i,"itpvend", mid(ls_vndname,1,30))
		if mid(ls_vndname,31,1) = 'E' then
			select xplan into :ls_damdang from pbinv.inv101
				where comltd = '01' and xplant = :ls_plant and div = :ls_div and itno = :ls_itno
			using sqlca ;
		end if
		this.setitem(i,"itdamdang"	, 	ls_damdang )		
		this.setitem(i,"itptotdan"	, 	this.object.inputdanga[i])
	end if
	if	trim(this.object.topchk[i]) <> '2' and this.object.srce[i] <> '03' then
		choose case this.object.cls[i]
			case '10'
				if this.object.srce[i] 	= 	'02' or this.object.srce[i] =	'04' then
					if rb_post.checked and this.object.comcd[i] = 'Y' then
						//고객사유상 공제후 로 대상품 제외
					else
						id_dom_inputamount	=	id_dom_inputamount	+	truncate(this.object.inputamount[i],6)		
					end if
				elseif this.object.srce[i] =	'01' then
					if rb_post.checked and this.object.comcd[i] = 'Y' then
						//고객사유상 공제후 로 대상품 제외
					else
						id_exp_inputamount	=	id_exp_inputamount	+	truncate(this.object.inputamount[i],6)	
					end if
				elseif this.object.srce[i] = 	'06' then
					if rb_post.checked and this.object.comcd[i] = 'Y' then
						//고객사유상 공제후 로 대상품 제외
					else
						id_fos_inputamount	=	id_fos_inputamount	+	truncate(this.object.inputamount[i],6)	
					end if
				end if
			case '40','50'
				if this.object.srce[i] 	= '04' then
					if rb_post.checked and this.object.comcd[i] = 'Y' then
						//고객사유상 공제후 로 대상품 제외
					else
						id_out_inputamount	=	id_out_inputamount	+	truncate(this.object.inputamount[i],6)	
					end if
				end if
		end choose
	else
		if rb_post.checked and this.object.comcd[i] = 'Y' then
			//*** 호환부품번이 고객사유상대상이면서 호환주품번이 대상품이 아닌경우
			//*** 재료비계산에서 대상금액을 제외시킴
			ls_option = this.object.toption[i]
			ls_plant = this.object.tplnt[i]
			ls_div = this.object.tdvsn[i]
			
			select comcd into :ls_comcd
			from pbinv.inv101
			where comltd = '01' and xplant = :ls_plant and 
				div = :ls_div and itno = :ls_option
			using sqlca;
			
			if isnull(ls_comcd) then ls_comcd = ''
			if ls_comcd <> 'Y' then
				choose case this.object.cls[i]
					case '10'
						if this.object.srce[i] 	= 	'02' or this.object.srce[i] =	'04' then
							id_dom_inputamount	=	id_dom_inputamount	-	truncate(this.object.inputamount[i],6)		
						elseif this.object.srce[i] =	'01' then
							id_exp_inputamount	=	id_exp_inputamount	-	truncate(this.object.inputamount[i],6)	
						elseif this.object.srce[i] = 	'06' then
							id_fos_inputamount	=	id_fos_inputamount	-	truncate(this.object.inputamount[i],6)	
						end if
					case '40','50'
						if this.object.srce[i] 	= '04' then
							id_out_inputamount	=	id_out_inputamount	-	truncate(this.object.inputamount[i],6)	
						end if
				end choose
			end if
		end if
	end if
next 
sle_ininv.text		= 	string(truncate(id_dom_inputamount,0),"###,###")
sle_outinv.text	= 	string(truncate(id_exp_inputamount,0),"###,###")
sle_osinv.text		= 	string(truncate(id_out_inputamount,0),"###,###")
end event

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

type tabpage_partlist from userobject within tab_history
integer x = 18
integer y = 100
integer width = 4535
integer height = 2076
long backcolor = 12632256
string text = "Part List"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_partlist dw_partlist
end type

on tabpage_partlist.create
this.dw_partlist=create dw_partlist
this.Control[]={this.dw_partlist}
end on

on tabpage_partlist.destroy
destroy(this.dw_partlist)
end on

type dw_partlist from datawindow within tabpage_partlist
integer x = 18
integer y = 28
integer width = 4498
integer height = 2032
integer taborder = 30
string title = "none"
string dataobject = "d_bom301i_partlist_current"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//integer 		i
//decimal{3}	ld_ininv	=	0,ld_outinv	=	0,ld_osinv	=	0
//for	i	=	1	to	rowcount
//	if	trim(this.object.tcalculate[i])	= 	'Y'	then
//		choose case this.object.cls[i]
//			case '10'
//				if this.object.srce[i] 		= 	'02' or this.object.srce[i] = 	'04' then
//					ld_ininv		=	ld_ininv		+	truncate(this.object.sumqty[i] * this.object.movedanga[i],6)
//				elseif this.object.srce[i] =	'01' then
//					ld_outinv	=	ld_outinv	+	truncate(this.object.sumqty[i] * this.object.movedanga[i],6)
//				elseif this.object.srce[i] = 	'05' or this.object.srce[i] = 	'06' then
//					
//				end if
//			case '40','50'
//				if this.object.srce[i] = '04' then
//					ld_osinv		=	ld_osinv		+	truncate(this.object.sumqty[i] * this.object.movedanga[i],6)
//				end if
//		end choose
//	end if
//next
//sle_ininv.text		= 	string(truncate(ld_ininv,0),"###,###")
//sle_outinv.text	= 	string(truncate(ld_outinv,0),"###,###")
//sle_osinv.text		= 	string(truncate(ld_osinv,0),"###,###")
end event

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

type tabpage_single from userobject within tab_history
integer x = 18
integer y = 100
integer width = 4535
integer height = 2076
long backcolor = 12632256
string text = "Single Level"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
rb_implo rb_implo
rb_explo rb_explo
dw_single dw_single
gb_1 gb_1
end type

on tabpage_single.create
this.rb_implo=create rb_implo
this.rb_explo=create rb_explo
this.dw_single=create dw_single
this.gb_1=create gb_1
this.Control[]={this.rb_implo,&
this.rb_explo,&
this.dw_single,&
this.gb_1}
end on

on tabpage_single.destroy
destroy(this.rb_implo)
destroy(this.rb_explo)
destroy(this.dw_single)
destroy(this.gb_1)
end on

type rb_implo from radiobutton within tabpage_single
integer x = 448
integer y = 60
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "상위조회"
end type

type rb_explo from radiobutton within tabpage_single
integer x = 59
integer y = 60
integer width = 402
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "하위조회"
boolean checked = true
end type

type dw_single from datawindow within tabpage_single
integer x = 18
integer y = 156
integer width = 4498
integer height = 1904
integer taborder = 80
string title = "none"
string dataobject = "d_bom301i_single_current_explo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;string 	ls_opt_itno,ls_plant,ls_div,ls_itno,ls_date,ls_ygchk,ls_yyyymm
integer	i
dec{2}   lc_move, lc_input, lc_out, lc_scmove, lc_scinput, lc_scout

ls_plant 	= 	trim(uo_plant.dw_1.getitemstring(1,'xplant'))
ls_div   	= 	trim(uo_plant.dw_1.getitemstring(1,'div'))
ls_date		=	f_dateedit(uo_today.is_uo_date)
ls_yyyymm   =  mid(ls_date,1,6)

for	i	=	1	to	rowcount
	ls_itno = this.object.itemcode[i]
	ls_opt_itno = f_option_chk_after(ls_plant,ls_div,ls_itno,ls_date) 
	if trim(ls_opt_itno) = trim(ls_itno) then
		this.object.optionno[i]	= 	'*'
	elseif f_spacechk(ls_opt_itno) = -1 then
		this.object.optionno[i]	= 	' '
	else
		this.object.optionno[i]	= 	ls_opt_itno
	end if
	
	ls_ygchk = this.object.ygchk[i]
	if ls_yyyymm >= mid(g_s_date,1,6) then
	  select decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN b.costls
		 ELSE 0.000000 END / b.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN
		 CASE WHEN b.costav = 0 THEN b.costls ELSE b.costav END
		 ELSE 0.000000 END / b.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN
		 CASE WHEN b.outqty <> 0
			 THEN abs(B.OUTAMT / B.OUTQTY)
			 ELSE B.COSTLS END
		 ELSE 0.000000 END / b.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN ifnull(c.sccostls,0)
		 ELSE 0.000000 END / b.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN
		 CASE WHEN ifnull(c.sccostav,0) = 0 THEN
			ifnull(c.sccostls,0) ELSE ifnull(c.sccostav,0) END
		 ELSE 0.000000 END / b.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN
		 CASE WHEN ifnull(c.sciscostav,0) = 0 THEN
			ifnull(c.sccostls,0) ELSE ifnull(c.sciscostav,0) END
		 ELSE 0.000000 END / b.convqty,6),15,2)
	  into :lc_input,:lc_move,:lc_out,
		 :lc_scinput,:lc_scmove,:lc_scout
	  from pbinv.inv101 b left outer join pbinv.inv101a c
		 on b.comltd = c.comltd and b.xplant = c.xplant and
			b.div = c.div and b.itno = c.itno
	  where b.comltd = '01' and b.xplant = :ls_plant and
		 b.div = :ls_div and b.itno = :ls_itno
	  using sqlca;
	else
	  select decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN b.costls
		 ELSE 0.000000 END / d.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN
		 CASE WHEN b.costav = 0 THEN b.costls ELSE b.costav END
		 ELSE 0.000000 END / d.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN
		 CASE WHEN b.outqty <> 0
			 THEN abs(B.OUTAMT / B.OUTQTY)
			 ELSE B.COSTLS END
		 ELSE 0.000000 END / d.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN ifnull(c.sccostls,0)
		 ELSE 0.000000 END / d.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN
		 CASE WHEN ifnull(c.sccostav,0) = 0 THEN
			ifnull(c.sccostls,0) ELSE ifnull(c.sccostav,0) END
		 ELSE 0.000000 END / d.convqty,6),15,2),
	  decimal(truncate(
		 CASE WHEN b.srce NOT IN ('05','03',' ') THEN
		 CASE WHEN ifnull(c.sciscostav,0) = 0 THEN
			ifnull(c.sccostls,0) ELSE ifnull(c.sciscostav,0) END
		 ELSE 0.000000 END / d.convqty,6),15,2)
	  into :lc_input,:lc_move,:lc_out,
		 :lc_scinput,:lc_scmove,:lc_scout
	  from pbinv.inv402 b left outer join pbinv.inv402a c
		 on b.comltd = c.comltd and b.xyear = c.xyear and
			b.xplant = c.xplant and b.div = c.div and
			b.itno = c.itno
		 inner join pbinv.inv101 d
		 on b.comltd = d.comltd and b.xplant = d.xplant and
		 	 b.div = d.div and b.itno = d.itno
	  where b.comltd = '01' and b.xplant = :ls_plant and
		 b.div = :ls_div and b.itno = :ls_itno and
		 b.xyear = :ls_yyyymm
	  using sqlca;
	end if
	
	if ls_ygchk = 'Y' then
		this.setitem(i,"outdanga",lc_scout)
		this.setitem(i,"movedanga",lc_scmove)
		this.setitem(i,"inputdanga",lc_scinput)
	else
		this.setitem(i,"outdanga",lc_out)
		this.setitem(i,"movedanga",lc_move)
		this.setitem(i,"inputdanga",lc_input)
	end if
next
end event

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

type gb_1 from groupbox within tabpage_single
integer x = 14
integer width = 846
integer height = 140
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_7 from statictext within w_bom303i
integer x = 3822
integer y = 184
integer width = 320
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "사  급(I)"
boolean focusrectangle = false
end type

type sle_osinv from singlelineedit within w_bom303i
integer x = 4137
integer y = 168
integer width = 448
integer height = 72
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
boolean righttoleft = true
end type

type st_1 from statictext within w_bom303i
integer x = 3205
integer y = 44
integer width = 421
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
string text = "고객사유상"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type rb_pre from radiobutton within w_bom303i
integer x = 3205
integer y = 156
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공제전"
boolean checked = true
end type

event clicked;wf_reset()
end event

type rb_post from radiobutton within w_bom303i
integer x = 3506
integer y = 156
integer width = 302
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공제후"
end type

event clicked;wf_reset()
end event

type dw_condition_info1 from datawindow within w_bom303i
integer x = 18
integer y = 148
integer width = 1879
integer height = 88
integer taborder = 90
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom303i_condition_info1"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_bom303i
integer x = 9
integer y = 8
integer width = 3141
integer height = 244
integer taborder = 11
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_bom303i
integer x = 3159
integer y = 8
integer width = 1445
integer height = 244
integer taborder = 11
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

