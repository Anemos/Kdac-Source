$PBExportHeader$w_piss230i.srw
$PBExportComments$월일별출하현황
forward
global type w_piss230i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss230i
end type
type uo_area from u_pisc_select_area within w_piss230i
end type
type uo_division from u_pisc_select_division within w_piss230i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss230i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_piss230i
end type
type uo_scustgubun from u_pisc_select_code within w_piss230i
end type
type uo_custcode from u_piss_select_custcode within w_piss230i
end type
type st_8 from statictext within w_piss230i
end type
type uo_ from u_pisc_date_scroll_month within w_piss230i
end type
type st_h_bar from uo_xc_splitbar within w_piss230i
end type
type gb_1 from groupbox within w_piss230i
end type
type dw_graph from datawindow within w_piss230i
end type
type dw_print from datawindow within w_piss230i
end type
type uo_itemcode from u_pisc_select_item_model_kdac within w_piss230i
end type
type pb_excel from picturebutton within w_piss230i
end type
type pb_print from picturebutton within w_piss230i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss230i
end type
type st_2 from statictext within w_piss230i
end type
end forward

global type w_piss230i from w_ipis_sheet01
integer width = 4681
integer height = 2304
string title = "월일별출하현황"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
st_8 st_8
uo_ uo_
st_h_bar st_h_bar
gb_1 gb_1
dw_graph dw_graph
dw_print dw_print
uo_itemcode uo_itemcode
pb_excel pb_excel
pb_print pb_print
uo_shipoemgubun uo_shipoemgubun
st_2 st_2
end type
global w_piss230i w_piss230i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
string is_custgubun,is_custcode,is_shipoemgubun
boolean ib_open
end variables

on w_piss230i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.uo_=create uo_
this.st_h_bar=create st_h_bar
this.gb_1=create gb_1
this.dw_graph=create dw_graph
this.dw_print=create dw_print
this.uo_itemcode=create uo_itemcode
this.pb_excel=create pb_excel
this.pb_print=create pb_print
this.uo_shipoemgubun=create uo_shipoemgubun
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.uo_modelgroup
this.Control[iCurrent+6]=this.uo_scustgubun
this.Control[iCurrent+7]=this.uo_custcode
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.uo_
this.Control[iCurrent+10]=this.st_h_bar
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.dw_graph
this.Control[iCurrent+13]=this.dw_print
this.Control[iCurrent+14]=this.uo_itemcode
this.Control[iCurrent+15]=this.pb_excel
this.Control[iCurrent+16]=this.pb_print
this.Control[iCurrent+17]=this.uo_shipoemgubun
this.Control[iCurrent+18]=this.st_2
end on

on w_piss230i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.uo_)
destroy(this.st_h_bar)
destroy(this.gb_1)
destroy(this.dw_graph)
destroy(this.dw_print)
destroy(this.uo_itemcode)
destroy(this.pb_excel)
destroy(this.pb_print)
destroy(this.uo_shipoemgubun)
destroy(this.st_2)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_graph, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_sheet, BELOW)

of_resize()

end event

event ue_retrieve;long ll_rowcount
ll_rowcount =  dw_graph.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_custgubun,is_custcode,is_productgroup,is_modelgroup,is_itemcode,is_shipoemgubun)
ll_rowcount =  dw_sheet.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_custgubun,is_custcode,is_productgroup,is_modelgroup,is_itemcode,is_shipoemgubun)
if ll_rowcount = 0  then 
	pb_print.visible = false
	pb_print.enabled = false
	pb_excel.visible = false
	pb_excel.enabled = false
	MessageBox('확인' ,'조회할 자료가 없읍니다.')
	return
end if	
pb_print.visible = true
pb_print.enabled = true
pb_excel.visible = true
pb_excel.enabled = true
dw_print.reset()
dw_print.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_custgubun,is_custcode,is_productgroup,is_modelgroup,is_itemcode,is_shipoemgubun)
		

end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
dw_graph.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname
string ls_codegroup,ls_codegroupname,ls_codename,ls_custname
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',true,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',true,is_custcode,ls_custname)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',TRUE,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
ib_open = true
end event

event ue_print;call super::ue_print;//dw_sheet.sharedata(dw_print)
if dw_print.rowcount() > 0 then
	dw_print.print()
end if
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_graph.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss230i
integer y = 2052
end type

type dw_sheet from u_vi_std_datawindow within w_piss230i
integer x = 18
integer y = 1616
integer width = 3575
integer height = 428
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss230i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_area from u_pisc_select_area within w_piss230i
integer x = 667
integer y = 92
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_graph.settransobject(sqlpis)
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
dw_graph.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_areacode = is_uo_areacode
end event

type uo_division from u_pisc_select_division within w_piss230i
integer x = 1207
integer y = 92
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_graph.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_productgroupname,ls_modelgroupname,ls_itemname
is_divisioncode = is_uo_divisioncode
if ib_open = true then
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if
dw_graph.reset()
dw_sheet.reset()

end event

type uo_productgroup from u_pisc_select_productgroup within w_piss230i
integer x = 1778
integer y = 92
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
dw_graph.reset()

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_piss230i
integer x = 2674
integer y = 92
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
dw_sheet.reset()
dw_graph.reset()

end event

type uo_scustgubun from u_pisc_select_code within w_piss230i
event destroy ( )
integer x = 402
integer y = 200
integer width = 709
integer taborder = 80
boolean bringtotop = true
end type

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

event constructor;call super::constructor;//postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',true,is_custcode,ls_custname)
dw_sheet.reset()
dw_graph.reset()

end event

event ue_post_constructor;string ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

type uo_custcode from u_piss_select_custcode within w_piss230i
event destroy ( )
integer x = 1106
integer y = 200
integer taborder = 90
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

type st_8 from statictext within w_piss230i
integer x = 50
integer y = 208
integer width = 357
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "거래처구분:"
boolean focusrectangle = false
end type

type uo_ from u_pisc_date_scroll_month within w_piss230i
event destroy ( )
integer x = 59
integer y = 92
integer taborder = 40
boolean bringtotop = true
end type

on uo_.destroy
call u_pisc_date_scroll_month::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_month
dw_sheet.reset()
dw_graph.reset()

end event

type st_h_bar from uo_xc_splitbar within w_piss230i
integer x = 123
integer y = 1328
integer width = 434
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_graph,ABOVE)
of_register(dw_sheet,BELOW)
end event

type gb_1 from groupbox within w_piss230i
integer x = 23
integer y = 28
integer width = 4594
integer height = 280
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
end type

type dw_graph from datawindow within w_piss230i
integer x = 23
integer y = 312
integer width = 4165
integer height = 928
integer taborder = 50
string title = "none"
string dataobject = "d_piss230i_02"
boolean maxbox = true
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_piss230i
boolean visible = false
integer x = 78
integer y = 440
integer width = 3730
integer height = 1324
integer taborder = 20
string dataobject = "d_piss230i_03"
boolean minbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_itemcode from u_pisc_select_item_model_kdac within w_piss230i
event destroy ( )
integer x = 2126
integer y = 180
integer taborder = 60
boolean bringtotop = true
end type

on uo_itemcode.destroy
call u_pisc_select_item_model_kdac::destroy
end on

event ue_select;call super::ue_select;is_itemcode = is_uo_itemcode

end event

type pb_excel from picturebutton within w_piss230i
boolean visible = false
integer x = 4448
integer y = 168
integer width = 155
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_sheet)
end event

type pb_print from picturebutton within w_piss230i
boolean visible = false
integer x = 4270
integer y = 168
integer width = 155
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;parent.triggerevent('ue_print')
end event

type uo_shipoemgubun from u_pisc_select_code within w_piss230i
event destroy ( )
integer x = 3890
integer y = 92
integer width = 709
integer taborder = 90
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;is_shipoemgubun = is_uo_codeid
if is_shipoemgubun = '' or isnull(is_shipoemgubun) then
	is_shipoemgubun = '%'
end if	
dw_graph.reset()
dw_sheet.reset()




end event

event ue_post_constructor;call super::ue_post_constructor;is_shipoemgubun = is_uo_codeid

end event

type st_2 from statictext within w_piss230i
integer x = 3598
integer y = 104
integer width = 293
integer height = 48
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "출하구분:"
boolean focusrectangle = false
end type

