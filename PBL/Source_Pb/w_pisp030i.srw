$PBExportHeader$w_pisp030i.srw
$PBExportComments$6개월 Rolling 생산계획
forward
global type w_pisp030i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp030i
end type
type uo_area from u_pisc_select_area within w_pisp030i
end type
type uo_division from u_pisc_select_division within w_pisp030i
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisp030i
end type
type uo_month from u_pisc_date_scroll_month within w_pisp030i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisp030i
end type
type dw_print from datawindow within w_pisp030i
end type
type gb_1 from groupbox within w_pisp030i
end type
type gb_2 from groupbox within w_pisp030i
end type
type gb_3 from groupbox within w_pisp030i
end type
end forward

global type w_pisp030i from w_ipis_sheet01
integer width = 3813
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_month uo_month
uo_modelgroup uo_modelgroup
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_pisp030i w_pisp030i

type variables
Boolean	ib_open
end variables

on w_pisp030i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_month=create uo_month
this.uo_modelgroup=create uo_modelgroup
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.uo_month
this.Control[iCurrent+6]=this.uo_modelgroup
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_pisp030i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_month)
destroy(this.uo_modelgroup)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_Print.SetTransObject(SQLPIS)

dw_1.ShareData(dw_print)

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

iw_this.PostEvent("ue_reset")
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(uo_month.is_uo_month, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
					uo_productgroup.is_uo_productgroup, uo_modelgroup.is_uo_modelgroup) > 0 Then
	uo_status.st_message.text =  "6개월 Rolling 생산계획 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "6개월 Rolling 생산계획이 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("6개월 Rolling 생산계획", "6개월 Rolling 생산계획이 존재하지 않습니다")
End If
end event

event ue_reset;call super::ue_reset;String	ls_month, ls_month_p, ls_month_c, ls_month1, ls_month2, ls_month3, ls_month4, ls_month5, &
			ls_modstring

dw_1.ReSet()
dw_print.ReSet()

ls_month		= uo_month.is_uo_month
ls_month1	= f_pisc_get_date_nextmonth(ls_month)
ls_month2	= f_pisc_get_date_nextmonth(ls_month1)
ls_month3	= f_pisc_get_date_nextmonth(ls_month2)
ls_month4	= f_pisc_get_date_nextmonth(ls_month3)
ls_month5	= f_pisc_get_date_nextmonth(ls_month4)

ls_month_p	= ls_month + "~r~n월초품의"
ls_month_c	= ls_month + "~r~n변경품의"
ls_month1	= "~r~n" + ls_month1
ls_month2	= "~r~n" + ls_month2
ls_month3	= "~r~n" + ls_month3
ls_month4	= "~r~n" + ls_month4
ls_month5	= "~r~n" + ls_month5

ls_modstring	= "planqty_t.Text = '" + ls_month_p + "' " + "changeqty_t.Text = '" + ls_month_c + "' " + &
					"planqtym1_t.Text = '" + ls_month1 + "' " + "planqtym2_t.Text = '" + ls_month2 + "' " + &
					"planqtym3_t.Text = '" + ls_month3 + "' " + "planqtym4_t.Text = '" + ls_month4 + "' " + &
					"planqtym5_t.Text = '" + ls_month5 + "' "

dw_1.Modify(ls_modstring)
end event

event ue_print;call super::ue_print;String	ls_month, ls_month_p, ls_month_c, ls_month1, ls_month2, ls_month3, ls_month4, ls_month5, &
			ls_mod
str_easy	lstr_prt

ls_month		= uo_month.is_uo_month
ls_month1	= f_pisc_get_date_nextmonth(ls_month)
ls_month2	= f_pisc_get_date_nextmonth(ls_month1)
ls_month3	= f_pisc_get_date_nextmonth(ls_month2)
ls_month4	= f_pisc_get_date_nextmonth(ls_month3)
ls_month5	= f_pisc_get_date_nextmonth(ls_month4)

ls_month_p	= ls_month + "~r~n월초품의"
ls_month_c	= ls_month + "~r~n변경품의"
ls_month1	= "~r~n" + ls_month1
ls_month2	= "~r~n" + ls_month2
ls_month3	= "~r~n" + ls_month3
ls_month4	= "~r~n" + ls_month4
ls_month5	= "~r~n" + ls_month5

ls_mod	= "planqty_t.Text = '" + ls_month_p + "' " + "changeqty_t.Text = '" + ls_month_c + "' " + &
				"planqtym1_t.Text = '" + ls_month1 + "' " + "planqtym2_t.Text = '" + ls_month2 + "' " + &
				"planqtym3_t.Text = '" + ls_month3 + "' " + "planqtym4_t.Text = '" + ls_month4 + "' " + &
				"planqtym5_t.Text = '" + ls_month5 + "' "


lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '6개월 Rolling 계획'
lstr_prt.tag			= '6개월 Rolling 계획'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_Print.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp030i
end type

type dw_1 from u_vi_std_datawindow within w_pisp030i
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 196
integer width = 3584
integer height = 1668
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisp030i_01"
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

type uo_area from u_pisc_select_area within w_pisp030i
integer x = 718
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

type uo_division from u_pisc_select_division within w_pisp030i
integer x = 1230
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

type uo_productgroup from u_pisc_select_productgroup within w_pisp030i
integer x = 1879
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

type uo_month from u_pisc_date_scroll_month within w_pisp030i
integer x = 46
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

type uo_modelgroup from u_pisc_select_modelgroup within w_pisp030i
integer x = 2789
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

type dw_print from datawindow within w_pisp030i
integer x = 1541
integer y = 432
integer width = 837
integer height = 484
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp030i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_1 from groupbox within w_pisp030i
integer x = 14
integer width = 663
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

type gb_2 from groupbox within w_pisp030i
integer x = 681
integer width = 1147
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

type gb_3 from groupbox within w_pisp030i
integer x = 1833
integer width = 1915
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

