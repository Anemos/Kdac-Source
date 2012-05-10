$PBExportHeader$w_piss210i.srw
$PBExportComments$납기준수율
forward
global type w_piss210i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss210i
end type
type uo_area from u_pisc_select_area within w_piss210i
end type
type uo_division from u_pisc_select_division within w_piss210i
end type
type uo_date from u_pisc_date_applydate within w_piss210i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss210i
end type
type st_2 from statictext within w_piss210i
end type
type dw_print from datawindow within w_piss210i
end type
type cb_1 from commandbutton within w_piss210i
end type
type gb_1 from groupbox within w_piss210i
end type
end forward

global type w_piss210i from w_ipis_sheet01
string title = "납기준수율"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_date uo_date
uo_1 uo_1
st_2 st_2
dw_print dw_print
cb_1 cb_1
gb_1 gb_1
end type
global w_piss210i w_piss210i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
boolean ib_open
end variables

on w_piss210i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.uo_1=create uo_1
this.st_2=create st_2
this.dw_print=create dw_print
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_date
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.gb_1
end on

on w_piss210i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.dw_print)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;call super::ue_retrieve;long ll_count

ll_count = dw_sheet.retrieve(is_shipdate1,is_shipdate2,is_areacode,is_divisioncode)

if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	uo_date.setfocus()
	return
end if	
end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname

f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

ib_open = true
end event

event ue_print;call super::ue_print;dw_sheet.sharedata(dw_print)
String	ls_mod
str_easy	lstr_prt

//ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '납기준수율'
lstr_prt.tag			= '납기준수율'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss210i
end type

type dw_sheet from u_vi_std_datawindow within w_piss210i
integer x = 18
integer y = 232
integer width = 3575
integer height = 1596
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss210i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_pisc_select_area within w_piss210i
integer x = 1417
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
end if
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_areacode = is_uo_areacode
end event

type uo_division from u_pisc_select_division within w_piss210i
integer x = 1989
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
dw_sheet.reset()

end event

type uo_date from u_pisc_date_applydate within w_piss210i
integer x = 73
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_losefocus;call super::ue_losefocus;is_shipdate1 = is_uo_date
end event

event constructor;call super::constructor;is_shipdate1 = is_uo_date
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;if is_shipdate1 <> is_uo_date then
	dw_sheet.reset()
end if	
is_shipdate1 = is_uo_date

end event

type uo_1 from u_pisc_date_applydate_1 within w_piss210i
integer x = 850
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate2 = is_uo_date
end event

type st_2 from statictext within w_piss210i
integer x = 763
integer y = 104
integer width = 82
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
string text = "->"
boolean focusrectangle = false
end type

type dw_print from datawindow within w_piss210i
boolean visible = false
integer x = 2103
integer y = 784
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss210i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_piss210i
boolean visible = false
integer x = 3072
integer y = 60
integer width = 457
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

type gb_1 from groupbox within w_piss210i
integer x = 23
integer y = 28
integer width = 2565
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

