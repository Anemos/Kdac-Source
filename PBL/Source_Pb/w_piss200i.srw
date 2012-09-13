$PBExportHeader$w_piss200i.srw
$PBExportComments$이체재고현황
forward
global type w_piss200i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss200i
end type
type uo_area from u_pisc_select_area within w_piss200i
end type
type uo_division from u_pisc_select_division within w_piss200i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss200i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_piss200i
end type
type dw_print from datawindow within w_piss200i
end type
type cb_1 from commandbutton within w_piss200i
end type
type st_h_bar from uo_xc_splitbar within w_piss200i
end type
type dw_2 from datawindow within w_piss200i
end type
type gb_1 from groupbox within w_piss200i
end type
end forward

global type w_piss200i from w_ipis_sheet01
integer width = 4498
string title = "재고현황"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
dw_print dw_print
cb_1 cb_1
st_h_bar st_h_bar
dw_2 dw_2
gb_1 gb_1
end type
global w_piss200i w_piss200i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
string is_custgubun,is_custcode,is_shipoemgubun
boolean ib_open
end variables

on w_piss200i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.dw_print=create dw_print
this.cb_1=create cb_1
this.st_h_bar=create st_h_bar
this.dw_2=create dw_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.uo_modelgroup
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.st_h_bar
this.Control[iCurrent+9]=this.dw_2
this.Control[iCurrent+10]=this.gb_1
end on

on w_piss200i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.dw_print)
destroy(this.cb_1)
destroy(this.st_h_bar)
destroy(this.dw_2)
destroy(this.gb_1)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_sheet, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_2, BELOW)

of_resize()
end event

event ue_retrieve;call super::ue_retrieve;long ll_rowcount
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

event ue_print;dw_sheet.sharedata(dw_print)
String	ls_mod
str_easy	lstr_prt

//ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '이체재고현황'
lstr_prt.tag			= '이체재고현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss200i
end type

type dw_sheet from u_vi_std_datawindow within w_piss200i
integer x = 18
integer y = 224
integer width = 3575
integer height = 544
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss200i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;string ls_divisioncode,ls_itemcode

if row < 1 then return

ls_divisioncode = dw_sheet.object.divisioncode[row]
ls_itemcode     = dw_sheet.object.itemcode[row]

dw_2.retrieve(is_areacode,ls_divisioncode,ls_itemcode)
end event

type uo_area from u_pisc_select_area within w_piss200i
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
dw_2.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname

is_areacode = is_uo_areacode
if ib_open = true then
	f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_modelgroup,ls_modelgroupname)
end if
dw_sheet.reset()
dw_2.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_areacode = is_uo_areacode
end event

type uo_division from u_pisc_select_division within w_piss200i
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
dw_2.settransobject(sqlpis)

string ls_productgroupname,ls_modelgroupname,ls_itemname
is_divisioncode = is_uo_divisioncode
if ib_open = true then
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if
dw_sheet.reset()
dw_2.reset()
end event

type uo_productgroup from u_pisc_select_productgroup within w_piss200i
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
dw_sheet.reset()
dw_2.reset()
end event

type uo_modelgroup from u_pisc_select_modelgroup within w_piss200i
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

dw_sheet.reset()
dw_2.reset()
end event

type dw_print from datawindow within w_piss200i
boolean visible = false
integer x = 2875
integer y = 460
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss200i_02"
boolean minbox = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_piss200i
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

type st_h_bar from uo_xc_splitbar within w_piss200i
integer x = 50
integer y = 1084
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_sheet,ABOVE)
of_register(dw_2,BELOW)
end event

type dw_2 from datawindow within w_piss200i
integer x = 101
integer y = 1140
integer width = 411
integer height = 432
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss200i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss200i
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

