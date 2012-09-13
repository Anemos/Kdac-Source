$PBExportHeader$w_pisk250i.srw
$PBExportComments$일별생산추이(모델군별)
forward
global type w_pisk250i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisk250i
end type
type uo_area from u_pisc_select_area within w_pisk250i
end type
type uo_division from u_pisc_select_division within w_pisk250i
end type
type dw_detail from datawindow within w_pisk250i
end type
type st_h_bar from uo_xc_splitbar within w_pisk250i
end type
type gb_1 from groupbox within w_pisk250i
end type
type gb_2 from groupbox within w_pisk250i
end type
type uo_month from u_pisc_date_scroll_month within w_pisk250i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisk250i
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisk250i
end type
type dw_print from datawindow within w_pisk250i
end type
type gb_3 from groupbox within w_pisk250i
end type
end forward

global type w_pisk250i from w_ipis_sheet01
integer width = 4110
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
dw_detail dw_detail
st_h_bar st_h_bar
gb_1 gb_1
gb_2 gb_2
uo_month uo_month
uo_modelgroup uo_modelgroup
uo_productgroup uo_productgroup
dw_print dw_print
gb_3 gb_3
end type
global w_pisk250i w_pisk250i

type variables
Boolean	ib_open
end variables

on w_pisk250i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.gb_1=create gb_1
this.gb_2=create gb_2
this.uo_month=create uo_month
this.uo_modelgroup=create uo_modelgroup
this.uo_productgroup=create uo_productgroup
this.dw_print=create dw_print
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.st_h_bar
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.uo_month
this.Control[iCurrent+9]=this.uo_modelgroup
this.Control[iCurrent+10]=this.uo_productgroup
this.Control[iCurrent+11]=this.dw_print
this.Control[iCurrent+12]=this.gb_3
end on

on w_pisk250i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.uo_month)
destroy(this.uo_modelgroup)
destroy(this.uo_productgroup)
destroy(this.dw_print)
destroy(this.gb_3)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_detail, BELOW)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

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
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_month.is_uo_month, &
						uo_area.is_uo_areacode,					uo_division.is_uo_divisioncode, &
						uo_productgroup.is_uo_productgroup,	uo_modelgroup.is_uo_modelgroup, &
						'%') > 0 Then
	uo_status.st_message.text =  "일별 생산추이 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "일별 생산추이 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("일별 생산추이(모델군별)", "일별 생산추이 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
dw_print.ReSet()
end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
end event

event ue_print;call super::ue_print;String	ls_mod, ls_date
str_easy	lstr_prt

ls_date	= "기준월 : " + uo_month.is_uo_month

ls_mod	= "st_msg.Text = '" + ls_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '일별생산추이(모델군별)'
lstr_prt.tag			= '일별생산추이(모델군별)'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisk250i
end type

type dw_1 from u_vi_std_datawindow within w_pisk250i
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 184
integer width = 645
integer height = 1472
integer taborder = 10
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisk250i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_vscroll;//// DataWindow Event_ID pbm_vscroll 

//Long ll_scrollPos, ll_detail
//String ls_Row, ls_vScrollPos, ls_Chk 
//
////ll_header		= Long(Describe("DataWindow.Header.Height"))
//ll_detail		= Long(Describe("DataWindow.Detail.Height"))
//
//If scrollcode = 0 Then 		// ▲ 
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> 행간높이 
//	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//
//	Return 1 
//ElseIf scrollcode = 1 Then 	// ▼
//	
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) + ll_detail 
//	
//	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//	If ls_Chk <> '' Then MessageBox("", ls_Chk)
//	Return 1 
//End If 
//
end event

event clicked;//

end event

event rowfocuschanged;String	ls_prdmonth, ls_areacode, ls_divisioncode, ls_productgroup, ls_modelgroup, &
			ls_itemcode, ls_series_name

If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
	ls_prdmonth			= Trim(GetItemString(CurrentRow, "PrdMonth"))
	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
	ls_divisioncode	= Trim(GetItemString(CurrentRow, "DivisionCode"))
	ls_productgroup	= Trim(GetItemString(CurrentRow, "ProductGroup"))
	ls_modelgroup		= Trim(GetItemString(CurrentRow, "ModelGroup"))
	ls_itemcode			= Trim(GetItemString(CurrentRow, "ItemCode"))

	dw_detail.ReSet()
	If dw_detail.Retrieve(ls_prdmonth, &
							ls_areacode,			ls_divisioncode, &
							ls_productgroup,		ls_modelgroup, &
							ls_itemcode) > 0 Then
		dw_detail.visible = False
		ls_series_name = dw_detail.SeriesName ("gr_1", 1)
		dw_detail.SetSeriesStyle ( "gr_1", ls_series_name, foreground!,	rgb(0,0,200))
		ls_series_name = dw_detail.SeriesName ("gr_1", 2)
		dw_detail.SetSeriesStyle ( "gr_1", ls_series_name, foreground!,	rgb(200,0,0))
		dw_detail.visible = True
	End If
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_pisk250i
integer x = 718
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
	dw_print.SetTransObject(SQLPIS)
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

type uo_division from u_pisc_select_division within w_pisk250i
integer x = 1216
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
	dw_print.SetTransObject(SQLPIS)
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

type dw_detail from datawindow within w_pisk250i
integer x = 965
integer y = 700
integer width = 1947
integer height = 724
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisk250i_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_pisk250i
integer x = 14
integer y = 1696
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type gb_1 from groupbox within w_pisk250i
integer x = 681
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
end type

type gb_2 from groupbox within w_pisk250i
integer x = 1797
integer width = 1888
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_month from u_pisc_date_scroll_month within w_pisk250i
integer x = 50
integer y = 68
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type uo_modelgroup from u_pisc_select_modelgroup within w_pisk250i
integer x = 2743
integer y = 68
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type uo_productgroup from u_pisc_select_productgroup within w_pisk250i
integer x = 1838
integer y = 68
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
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

type dw_print from datawindow within w_pisk250i
integer x = 887
integer y = 336
integer width = 718
integer height = 500
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_pisk250i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_3 from groupbox within w_pisk250i
integer x = 14
integer width = 663
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

