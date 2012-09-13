$PBExportHeader$w_piss231i.srw
$PBExportComments$출하변동현황
forward
global type w_piss231i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss231i
end type
type uo_area from u_pisc_select_area within w_piss231i
end type
type uo_division from u_pisc_select_division within w_piss231i
end type
type uo_ from u_pisc_date_scroll_month within w_piss231i
end type
type gb_1 from groupbox within w_piss231i
end type
type dw_graph from datawindow within w_piss231i
end type
type dw_print from datawindow within w_piss231i
end type
type pb_excel from picturebutton within w_piss231i
end type
type pb_print from picturebutton within w_piss231i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss231i
end type
type dw_item from datawindow within w_piss231i
end type
type st_2 from statictext within w_piss231i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_piss231i
end type
end forward

global type w_piss231i from w_ipis_sheet01
integer width = 4663
integer height = 2716
string title = "출하변동관리"
event ue_keydown pbm_keydown
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_ uo_
gb_1 gb_1
dw_graph dw_graph
dw_print dw_print
pb_excel pb_excel
pb_print pb_print
uo_productgroup uo_productgroup
dw_item dw_item
st_2 st_2
uo_modelgroup uo_modelgroup
end type
global w_piss231i w_piss231i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
string is_custgubun,is_custcode,is_shipoemgubun
boolean ib_open
datawindowchild child_dw
end variables

event ue_keydown;if key = keyenter! then
	this.triggerevent("ue_retrieve")
end if

end event

on w_piss231i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_=create uo_
this.gb_1=create gb_1
this.dw_graph=create dw_graph
this.dw_print=create dw_print
this.pb_excel=create pb_excel
this.pb_print=create pb_print
this.uo_productgroup=create uo_productgroup
this.dw_item=create dw_item
this.st_2=create st_2
this.uo_modelgroup=create uo_modelgroup
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_graph
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.pb_excel
this.Control[iCurrent+9]=this.pb_print
this.Control[iCurrent+10]=this.uo_productgroup
this.Control[iCurrent+11]=this.dw_item
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.uo_modelgroup
end on

on w_piss231i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_)
destroy(this.gb_1)
destroy(this.dw_graph)
destroy(this.dw_print)
destroy(this.pb_excel)
destroy(this.pb_print)
destroy(this.uo_productgroup)
destroy(this.dw_item)
destroy(this.st_2)
destroy(this.uo_modelgroup)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_graph, ABOVE)
//of_resize_register(st_h_bar, SPLIT)
//of_resize_register(dw_sheet, BELOW)
//
//of_resize()
//
end event

event ue_retrieve;long ll_rowcount

dw_graph.ReSet() 
dw_print.ReSet()
dw_sheet.ReSet()

if trim(is_itemcode) = 'ALL' or f_spacechk(is_itemcode) = -1 then
	is_itemcode = '%'
end if
ll_rowcount =  dw_sheet.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode)
if ll_rowcount = 0  then 
	pb_print.visible = false
	pb_print.enabled = false
	MessageBox('확인' ,'조회할 자료가 없읍니다.')
	return
end if	
dw_graph.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode)
dw_print.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode)
pb_print.visible = true
pb_print.enabled = true

end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
dw_graph.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng,ls_itemname,ls_productgroupname,ls_modelgroupname
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
If dw_item.GetChild('DDDWCode', child_dw) = 1 Then
	child_dw.SetTransObject(sqlpis)
	child_Dw.reset()
	If child_dw.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup) < 1  Then
		dw_item.ReSet()
		dw_item.InsertRow(0)
		dw_item.Setitem(1, 'dddwcode', 'ALL')
	End If
End If
ib_open = true
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_graph.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
// is_productgroup = 'ALL'
dw_item.InsertRow(0)
dw_item.Setitem(1, 'dddwcode', 'ALL')

end event

event ue_print;call super::ue_print;dw_print.print()
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss231i
integer x = 18
integer y = 2508
integer width = 4571
end type

type dw_sheet from u_vi_std_datawindow within w_piss231i
integer x = 18
integer y = 2032
integer width = 4594
integer height = 468
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss231i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_area from u_pisc_select_area within w_piss231i
integer x = 608
integer y = 100
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
	If dw_item.GetChild('DDDWCode', child_dw) = 1 Then
 		child_dw.SetTransObject(sqlpis)
		child_Dw.reset()
		If child_dw.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup) < 1  Then
			dw_item.ReSet()
			dw_item.InsertRow(0)
			dw_item.Setitem(1, 'dddwcode', 'ALL')
		End If
	End If
end if
dw_sheet.reset()
dw_graph.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_areacode = is_uo_areacode
end event

type uo_division from u_pisc_select_division within w_piss231i
integer x = 1088
integer y = 100
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_graph.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_itemname,ls_productgroupname,ls_modelgroupname
is_divisioncode = is_uo_divisioncode
if ib_open = true then
   f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
	If dw_item.GetChild('DDDWCode', child_dw) = 1 Then
 		child_dw.SetTransObject(sqlpis)
		child_Dw.reset()
		If child_dw.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup) < 1  Then
			dw_item.ReSet()
			dw_item.InsertRow(0)
			dw_item.Setitem(1, 'dddwcode', 'ALL')
		End If
	End If
end if
dw_graph.reset()
dw_sheet.reset()
 
end event

type uo_ from u_pisc_date_scroll_month within w_piss231i
event destroy ( )
integer x = 27
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_.destroy
call u_pisc_date_scroll_month::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_month
dw_sheet.reset()
dw_graph.reset()
long ll_rowcount
If dw_item.GetChild('DDDWCode', child_dw) = 1 Then
 		child_dw.SetTransObject(sqlpis)
		child_Dw.reset()
		child_dw.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup)
		ll_rowcount = child_dw.RowCount()
		If ll_rowcount < 1  Then
			dw_item.ReSet()
			dw_item.InsertRow(0)
			dw_item.Setitem(1, 'dddwcode', 'ALL')
		End If
End If


end event

type gb_1 from groupbox within w_piss231i
integer x = 9
integer y = 28
integer width = 4608
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
end type

type dw_graph from datawindow within w_piss231i
integer x = 23
integer y = 232
integer width = 4590
integer height = 1788
integer taborder = 50
string title = "none"
string dataobject = "d_piss231i_05"
boolean maxbox = true
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_piss231i
boolean visible = false
integer x = 78
integer y = 440
integer width = 3730
integer height = 1324
integer taborder = 20
string dataobject = "d_piss231i_03"
boolean minbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_piss231i
boolean visible = false
integer x = 4389
integer y = 68
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

type pb_print from picturebutton within w_piss231i
boolean visible = false
integer x = 4398
integer y = 68
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

event clicked;dw_print.print()
end event

type uo_productgroup from u_pisc_select_productgroup within w_piss231i
integer x = 1637
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;long ll_rowcount
string ls_productgroupname,ls_modelgroupname,ls_itemname

is_productgroup = is_uo_productgroup
f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
If dw_item.GetChild('DDDWCode', child_dw) = 1 Then
	child_dw.SetTransObject(sqlpis)
	child_Dw.reset()
	child_dw.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup)
	ll_rowcount = child_dw.RowCount()
	If ll_rowcount < 1  Then
		dw_item.ReSet()
		dw_item.InsertRow(0)
		dw_item.Setitem(1, 'dddwcode', 'ALL')
	End If
End If


end event

type dw_item from datawindow within w_piss231i
integer x = 3616
integer y = 104
integer width = 704
integer height = 72
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_piss_dddw_item_model_tplanrelease"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;If is_itemcode <> data Then
	If data = 'ALL' Then
		is_itemcode = '%'
	Else
		is_itemcode = data
	End If
End If
end event

type st_2 from statictext within w_piss231i
integer x = 3429
integer y = 112
integer width = 192
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "품 번"
boolean focusrectangle = false
end type

type uo_modelgroup from u_pisc_select_modelgroup within w_piss231i
integer x = 2523
integer y = 100
integer taborder = 60
boolean bringtotop = true
end type

event ue_select;call super::ue_select;long ll_rowcount
// string ls_productgroupname,ls_modelgroupname,ls_itemname
is_modelgroup = is_uo_modelgroup
If dw_item.GetChild('DDDWCode', child_dw) = 1 Then
 		child_dw.SetTransObject(sqlpis)
		child_Dw.reset()
		child_dw.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup)
		ll_rowcount = child_dw.RowCount()
		If ll_rowcount < 1  Then
			dw_item.ReSet()
			dw_item.InsertRow(0)
			dw_item.Setitem(1, 'dddwcode', 'ALL')
		End If
End If


end event

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

