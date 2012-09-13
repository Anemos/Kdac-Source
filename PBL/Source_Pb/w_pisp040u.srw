$PBExportHeader$w_pisp040u.srw
$PBExportComments$월간생산계획
forward
global type w_pisp040u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp040u
end type
type uo_area from u_pisc_select_area within w_pisp040u
end type
type uo_division from u_pisc_select_division within w_pisp040u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisp040u
end type
type uo_month from u_pisc_date_scroll_month within w_pisp040u
end type
type cb_1 from commandbutton within w_pisp040u
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisp040u
end type
type dw_print from datawindow within w_pisp040u
end type
type gb_1 from groupbox within w_pisp040u
end type
type gb_2 from groupbox within w_pisp040u
end type
type gb_3 from groupbox within w_pisp040u
end type
type gb_4 from groupbox within w_pisp040u
end type
end forward

global type w_pisp040u from w_ipis_sheet01
integer width = 4677
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_month uo_month
cb_1 cb_1
uo_modelgroup uo_modelgroup
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_pisp040u w_pisp040u

type variables
Boolean	ib_open
end variables

on w_pisp040u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_month=create uo_month
this.cb_1=create cb_1
this.uo_modelgroup=create uo_modelgroup
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.uo_month
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.uo_modelgroup
this.Control[iCurrent+8]=this.dw_print
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_4
end on

on w_pisp040u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_month)
destroy(this.cb_1)
destroy(this.uo_modelgroup)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_Print.SetTransObject(SQLPIS)

dw_1.ShareData(dw_print)

cb_1.Enabled	= m_frame.m_action.m_save.Enabled

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)

f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_productgroup.is_uo_productgroup, &
										'%', &
										True, &
										uo_modelgroup.is_uo_modelgroup, &
										uo_modelgroup.is_uo_modelgroupname)
ib_open = True
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(uo_month.is_uo_month, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
					uo_productgroup.is_uo_productgroup, uo_modelgroup.is_uo_modelgroup) > 0 Then
	uo_status.st_message.text =  "월간생산계획 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "월간생산계획이 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("월간생산계획", "월간생산계획이 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_print.ReSet()
end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt

ls_mod	= "st_msg.Text = '" + "기준월 : " + uo_month.is_uo_month + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '월간 생산계획'
lstr_prt.tag			= '월간 생산계획'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_Print.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp040u
end type

type dw_1 from u_vi_std_datawindow within w_pisp040u
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 196
integer width = 3584
integer height = 1676
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisp040u_01"
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
If CurrentRow > 0 Then
	this.SelectRow(0,FALSE)
	this.SelectRow(currentrow,TRUE)
End If
end event

event ue_lbuttonup;//
end event

type uo_area from u_pisc_select_area within w_pisp040u
integer x = 667
integer y = 72
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_Print.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)

	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

end event

type uo_division from u_pisc_select_division within w_pisp040u
integer x = 1157
integer y = 72
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_Print.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)

	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If

end event

type uo_productgroup from u_pisc_select_productgroup within w_pisp040u
integer x = 1746
integer y = 72
integer height = 68
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)
End If
end event

type uo_month from u_pisc_date_scroll_month within w_pisp040u
integer x = 37
integer y = 72
integer height = 80
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type cb_1 from commandbutton within w_pisp040u
integer x = 3611
integer y = 64
integer width = 768
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일일 생산계획 계산(&G)"
end type

event clicked;//If dw_1.GetRow() > 0 Then
	istr_parms.string_arg[1] = is_size
	istr_parms.string_arg[2] = uo_month.is_uo_month
	If dw_1.GetRow() > 0 Then
		istr_parms.string_arg[3] = Trim(dw_1.GetItemString(dw_1.GetRow(), "ItemCode"))
	Else
		istr_parms.string_arg[3] = "%"
	End If

	OpenWithParm(w_pisp002u, istr_parms)
//Else
//	uo_status.st_message.text =  "일일생산계획을 재계산하려는 제품을 선택하여 주십시요." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
//	MessageBox("월간생산계획", "일일생산계획을 재계산하려는 제품을 선택하여 주십시요.", StopSign!)
//	Return	
//End If
end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisp040u
integer x = 2629
integer y = 72
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type dw_print from datawindow within w_pisp040u
integer x = 1563
integer y = 228
integer width = 823
integer height = 536
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp040u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_1 from groupbox within w_pisp040u
integer x = 14
integer width = 631
integer height = 192
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

type gb_2 from groupbox within w_pisp040u
integer x = 649
integer width = 1074
integer height = 192
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

type gb_3 from groupbox within w_pisp040u
integer x = 1728
integer width = 1824
integer height = 192
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

type gb_4 from groupbox within w_pisp040u
integer x = 3557
integer width = 878
integer height = 192
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

