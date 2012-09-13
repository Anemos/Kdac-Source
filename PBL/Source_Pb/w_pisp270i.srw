$PBExportHeader$w_pisp270i.srw
$PBExportComments$간판 번호 List
forward
global type w_pisp270i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp270i
end type
type uo_area from u_pisc_select_area within w_pisp270i
end type
type uo_division from u_pisc_select_division within w_pisp270i
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp270i
end type
type uo_line from u_pisc_select_line within w_pisp270i
end type
type dw_detail from datawindow within w_pisp270i
end type
type st_h_bar from uo_xc_splitbar within w_pisp270i
end type
type uo_item from u_pisc_select_item_kb_line within w_pisp270i
end type
type gb_1 from groupbox within w_pisp270i
end type
type gb_2 from groupbox within w_pisp270i
end type
type gb_4 from groupbox within w_pisp270i
end type
end forward

global type w_pisp270i from w_ipis_sheet01
integer width = 3886
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
dw_detail dw_detail
st_h_bar st_h_bar
uo_item uo_item
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
end type
global w_pisp270i w_pisp270i

type variables
Boolean	ib_open
end variables

on w_pisp270i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.uo_item=create uo_item
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_h_bar
this.Control[iCurrent+8]=this.uo_item
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_4
end on

on w_pisp270i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.uo_item)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_detail, BELOW)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										True, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)

f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										uo_line.is_uo_linecode, &
										'%', &
										True, &
										uo_item.is_uo_itemcode, &
										uo_item.is_uo_itemname)
										
ib_open = True
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
						uo_item.is_uo_itemcode) > 0 Then
	uo_status.st_message.text =  "간판 번호 List 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "간판 번호 List 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 번호 List", "간판 번호 List 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp270i
end type

type dw_1 from u_vi_std_datawindow within w_pisp270i
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 184
integer width = 645
integer height = 1184
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp270i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_vscroll;//// DataWindow Event_ID pbm_vscroll 

Long ll_scrollPos, ll_detail
String ls_Row, ls_vScrollPos, ls_Chk 

//ll_header		= Long(Describe("DataWindow.Header.Height"))
ll_detail		= Long(Describe("DataWindow.Detail.Height"))

If scrollcode = 0 Then 		// ▲ 
	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> 행간높이 
	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 

	Return 1 
ElseIf scrollcode = 1 Then 	// ▼
	
	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
	ll_scrollPos = Long(ls_vScrollPos) + ll_detail 
	
	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
	If ls_Chk <> '' Then MessageBox("", ls_Chk)
	Return 1 
End If 

end event

event clicked;//

end event

event rowfocuschanged;//
string	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

If CurrentRow > 0 Then
	SelectRow(0,FALSE)
	SelectRow(currentrow,TRUE)
	
	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
	ls_divisioncode	= Trim(GetItemString(CurrentRow, "DivisionCode"))
	ls_workcenter		= Trim(GetItemString(CurrentRow, "WorkCenter"))
	ls_linecode			= Trim(GetItemString(CurrentRow, "LineCode"))
	ls_itemcode			= Trim(GetItemString(CurrentRow, "ItemCode"))
	
	dw_detail.Retrieve(ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode)
	
//	ls_filter_list ="(" + "AreaCode" + " = '" + ls_areacode + "' " + ") " + &
//						"And" + "  " + &
//						"(" + "DivisionCode" + " = '" + ls_divisioncode + "' " + ") "
// 	ldwc_wc.SetFilter(ls_filter_list)
//	ldwc_wc.Filter()

End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_pisp270i
integer x = 50
integer y = 68
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
End If

end event

type uo_division from u_pisc_select_division within w_pisp270i
integer x = 549
integer y = 68
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
											
	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp270i
integer x = 1147
integer y = 68
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
End If

end event

type uo_line from u_pisc_select_line within w_pisp270i
integer x = 1824
integer y = 68
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
End If

end event

type dw_detail from datawindow within w_pisp270i
integer x = 965
integer y = 700
integer width = 1947
integer height = 724
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisp270i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_pisp270i
integer x = 14
integer y = 1404
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type uo_item from u_pisc_select_item_kb_line within w_pisp270i
integer x = 2450
integer y = 68
boolean bringtotop = true
end type

on uo_item.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type gb_1 from groupbox within w_pisp270i
integer x = 14
integer width = 1111
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp270i
integer x = 1129
integer width = 1280
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pisp270i
integer x = 2414
integer width = 955
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

