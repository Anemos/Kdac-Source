$PBExportHeader$w_piss390i.srw
$PBExportComments$영업진행재고현황
forward
global type w_piss390i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss390i
end type
type uo_area from u_pisc_select_area within w_piss390i
end type
type uo_division from u_pisc_select_division within w_piss390i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss390i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_piss390i
end type
type dw_print from datawindow within w_piss390i
end type
type cb_1 from commandbutton within w_piss390i
end type
type gb_1 from groupbox within w_piss390i
end type
end forward

global type w_piss390i from w_ipis_sheet01
integer width = 4498
string title = "재고현황"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
dw_print dw_print
cb_1 cb_1
gb_1 gb_1
end type
global w_piss390i w_piss390i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
string is_custgubun,is_custcode,is_shipoemgubun
boolean ib_open
end variables

on w_piss390i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.dw_print=create dw_print
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.uo_modelgroup
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.gb_1
end on

on w_piss390i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.dw_print)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcount
if is_productgroup = '' or isnull(is_productgroup) then
	is_productgroup = '%'
end if	
if is_modelgroup = '' or isnull(is_modelgroup) then
	is_modelgroup = '%'
end if	

ll_rowcount =  dw_sheet.retrieve(is_areacode,is_divisioncode,is_productgroup,is_modelgroup)

if ll_rowcount = 0  then 
	MessageBox('확인','조회할 자료가 없읍니다.')
	return
end if

end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname
string ls_codegroup,ls_codegroupname,ls_codename
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)

ib_open = true
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

end event

event ue_print;String	ls_mod,ls_date
str_easy	lstr_prt
dw_sheet.sharedata(dw_print)
//ls_date = is_prddate + ' - ' + is_prddate1
//
ls_mod	= "t_msg.Text = '" + "기준일 : " + ls_date + "' "
//ls_mod	= ls_mod + is_mod1
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '영업진행재고현황'
lstr_prt.tag			= '영업진행재고현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
//
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss390i
end type

type dw_sheet from u_vi_std_datawindow within w_piss390i
integer x = 18
integer y = 224
integer width = 3575
integer height = 1572
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss390i_01"
boolean minbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_area from u_pisc_select_area within w_piss390i
integer x = 69
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname

is_areacode = is_uo_areacode
if ib_open = true then
	f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_modelgroup,ls_modelgroupname)
end if
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_areacode = is_uo_areacode
end event

type uo_division from u_pisc_select_division within w_piss390i
integer x = 626
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

string ls_productgroupname,ls_modelgroupname,ls_itemname
is_divisioncode = is_uo_divisioncode
if ib_open = true then
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if
dw_sheet.reset()

end event

type uo_productgroup from u_pisc_select_productgroup within w_piss390i
integer x = 1243
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;string ls_productgroupname,ls_modelgroupname,ls_itemname
is_productgroup = is_uo_productgroup
if ib_open = true then
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_piss390i
integer x = 2194
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;string ls_itemname
is_modelgroup = is_uo_modelgroup
if ib_open = true then
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if

end event

type dw_print from datawindow within w_piss390i
boolean visible = false
integer x = 1801
integer y = 448
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss390i_02"
boolean minbox = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_piss390i
integer x = 4215
integer y = 40
integer width = 206
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "출력"
end type

event clicked;parent.triggerevent('ue_print')
end event

type gb_1 from groupbox within w_piss390i
integer x = 23
integer y = 28
integer width = 3136
integer height = 184
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
borderstyle borderstyle = stylelowered!
end type

