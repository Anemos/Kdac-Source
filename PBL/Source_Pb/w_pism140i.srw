$PBExportHeader$w_pism140i.srw
$PBExportComments$월 및 일별 공수투입 상세현황
forward
global type w_pism140i from w_pism_sheet03
end type
type tab_work from tab within w_pism140i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_pism140i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_day_mhlist from u_pism_dw within w_pism140i
end type
type dw_header from u_pism_dw within w_pism140i
end type
type dw_month_mhlist from datawindow within w_pism140i
end type
end forward

global type w_pism140i from w_pism_sheet03
long il_obj_above_y = 44138184
long il_obj_above_height = 44139336
long il_obj_split_v_x = 24064208
long il_obj_split_v_width = 44138120
long il_obj_split_v_y = 44138440
long il_obj_split_v_height = 44139976
long il_obj_split_h_x = 24097256
long il_obj_split_h_width = 44139080
long il_obj_split_h_y = 44139656
long il_obj_split_h_height = 44138312
tab_work tab_work
dw_day_mhlist dw_day_mhlist
dw_header dw_header
dw_month_mhlist dw_month_mhlist
end type
global w_pism140i w_pism140i

type variables
Boolean ib_Scrolling1, ib_Scrolling2, ib_Scrolling3 
end variables

forward prototypes
public function long wf_prdatawindowretrieve (datawindow aprdw)
end prototypes

public function long wf_prdatawindowretrieve (datawindow aprdw);Long ll_ret 

aprdw.SetTransObject(SqlPIS)

Choose Case tab_work.SelectedTab 
	Case 1 			// 월별 공수투입 현황 
		ll_ret = aprdw.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, uo_frMonth.is_uo_month, uo_toMonth.is_uo_month)
	Case 2 			// 일별 공수투입 현황 
		ll_ret = aprdw.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, uo_fromdate.is_uo_date, uo_todate.is_uo_date)
End Choose 

Return ll_ret 
end function

on w_pism140i.create
int iCurrent
call super::create
this.tab_work=create tab_work
this.dw_day_mhlist=create dw_day_mhlist
this.dw_header=create dw_header
this.dw_month_mhlist=create dw_month_mhlist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_work
this.Control[iCurrent+2]=this.dw_day_mhlist
this.Control[iCurrent+3]=this.dw_header
this.Control[iCurrent+4]=this.dw_month_mhlist
end on

on w_pism140i.destroy
call super::destroy
destroy(this.tab_work)
destroy(this.dw_day_mhlist)
destroy(this.dw_header)
destroy(this.dw_month_mhlist)
end on

event resize;call super::resize;tab_work.Width = newwidth - ( tab_work.x + 10 ) 

dw_day_mhlist.Height = newheight - ( dw_day_mhlist.y + uo_status.Height + 12 ) 
dw_month_mhlist.Height = dw_day_mhlist.Height 

dw_header.Height = dw_day_mhlist.Height - 50
dw_day_mhlist.Width = newwidth - ( dw_day_mhlist.x + 10 ) 
dw_month_mhlist.Width = dw_day_mhlist.Width 
end event

event ue_retrieve;call super::ue_retrieve;Long ll_ret 
String ls_conDate

// CrossTab 오류방지를 위한 데이타윈도우 오브젝트 조회시 재배당 2010.05.06
dw_day_mhlist.dataobject = 'd_pism140i_02'
dw_day_mhlist.Modify("seq1.Width = 0") 
dw_day_mhlist.Modify("seq2.Width = 0") 
dw_day_mhlist.Modify("displevel.Width = 0") 

dw_month_mhlist.dataobject = 'd_pism140i_01'
dw_month_mhlist.Modify("seq1.Width = 0") 
dw_month_mhlist.Modify("seq2.Width = 0") 
dw_month_mhlist.Modify("displevel.Width = 0") 


If tab_work.SelectedTab = 1 Then 
	ls_conDate = uo_frMonth.is_uo_month + "∼" + uo_toMonth.is_uo_month 
Else
	ls_conDate = uo_fromdate.is_uo_date + "∼" + uo_todate.is_uo_date 
End If 

f_pism_working_msg(ls_conDate + " " + uo_div.is_uo_divisionname + "공장 " + &
						 uo_wc.is_uo_workcentername + " 조", tab_work.control[tab_work.SelectedTab].Text + " 을 조회중입니다. 잠시만 기다려 주십시오.") 

ll_ret = tab_work.Event ue_Retrieve(tab_work.SelectedTab) 

If IsValid(w_pism_working) Then Close(w_pism_working) 

If ll_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", ls_conDate + " " + &
																		 uo_wc.is_uo_workcentername + " 조 의 생산실적이 존재하지 않습니다.")

tab_work.control[tab_work.SelectedTab].SetFocus() 
end event

event open;call super::open;ib_wcallview = True 

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건
String ls_conDate 

lstr_prt.Transaction = SqlPIS 

If tab_work.SelectedTab = 1 Then 
	lstr_prt.datawindow = dw_month_mhlist
	lstr_prt.DataObject = 'd_pism140i_1p' 
	
	ls_conDate = uo_frMonth.is_uo_month + "∼" + uo_toMonth.is_uo_month 
Else
	lstr_prt.datawindow = dw_day_mhlist
	lstr_prt.DataObject = 'd_pism140i_2p' 
	
	ls_conDate = uo_fromdate.is_uo_date + "∼" + uo_todate.is_uo_date 
End If 

lstr_prt.title = ls_conDate + " " + uo_wc.is_uo_workcentername + " 조 " + tab_work.control[tab_work.SelectedTab].Text
lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + " " + &
							uo_wc.is_uo_workcenterName + " 조'" 

lstr_prt.parent_win = This 

OpenSheetWithParm(w_pism_prt01, lstr_prt, w_frame, 0, Layered! )

end event

event ue_postopen;call super::ue_postopen;dw_day_mhlist.Modify("seq1.Width = 0") 
dw_day_mhlist.Modify("seq2.Width = 0") 
dw_day_mhlist.Modify("displevel.Width = 0") 
//dw_day_mhlist.Modify("dispname.Width = 0") -- 수행시 조명이 보이질 않음(??) 

dw_month_mhlist.Modify("seq1.Width = 0") 
dw_month_mhlist.Modify("seq2.Width = 0") 
dw_month_mhlist.Modify("displevel.Width = 0") 
//dw_month_mhlist.Modify("dispname.Width = 0") -- 수행시 조명이 보이질 않음(??) 

end event

type uo_status from w_pism_sheet03`uo_status within w_pism140i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism140i
integer x = 1102
integer width = 1038
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism140i
integer x = 2862
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism140i
integer width = 2144
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism140i
integer x = 2181
end type

type uo_year from w_pism_sheet03`uo_year within w_pism140i
integer x = 2208
end type

type uo_month from w_pism_sheet03`uo_month within w_pism140i
integer x = 2203
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism140i
integer x = 2185
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism140i
integer x = 2158
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism140i
integer x = 2711
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism140i
integer x = 2770
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism140i
integer x = 2907
end type

type uo_area from w_pism_sheet03`uo_area within w_pism140i
integer x = 37
end type

type uo_div from w_pism_sheet03`uo_div within w_pism140i
integer x = 544
end type

type tab_work from tab within w_pism140i
event type long ue_retrieve ( integer ai_selectedtab )
integer x = 3392
integer y = 28
integer width = 1641
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event type long ue_retrieve(integer ai_selectedtab);Long ll_ret 

dw_header.SetRedraw(False); dw_month_mhlist.SetRedraw(False); dw_day_mhlist.SetRedraw(False) 

If dw_header.RowCount() > 0 Then 
	dw_header.ScrollToRow(1)
Else
	dw_header.SetTransObject(SqlPIS)
	dw_header.Retrieve('2')
End If

If ai_selectedtab = 1 Then 		// 월별 공수투입 현황 
	dw_month_mhlist.SetTransObject(SqlPIS) 
	dw_month_mhlist.reset()
	ll_ret = dw_month_mhlist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, uo_frMonth.is_uo_month, uo_toMonth.is_uo_month)
	
ElseIf ai_selectedtab = 2 Then 	// 일별 공수투입 현황 
	dw_day_mhlist.SetTransObject(SqlPIS) 
	dw_day_mhlist.reset()
	ll_ret = dw_day_mhlist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, uo_fromdate.is_uo_date, uo_todate.is_uo_date)
End If

dw_header.SetRedraw(True); dw_month_mhlist.SetRedraw(True); dw_day_mhlist.SetRedraw(True) 

Return ll_ret 
end event

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;
dw_header.ScrollToRow(1) 

Choose Case newindex 
	Case 1
		wf_setRetCondition(STFROMTOMONTH) 
		dw_month_mhlist.ScrollToRow(1)
		dw_month_mhlist.Visible = True 
		dw_day_mhlist.Visible = False 
		
	Case 2
		wf_setRetCondition(STFROMTODATE) 
		dw_day_mhlist.ScrollToRow(1)
		dw_day_mhlist.Visible = True 
		dw_month_mhlist.Visible = False
		
End Choose 

end event

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 100
integer width = 1605
integer height = -4
long backcolor = 12632256
string text = "월별 투입현황"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
integer x = 18
integer y = 100
integer width = 1605
integer height = -4
long backcolor = 12632256
string text = "일별 투입현황"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_day_mhlist from u_pism_dw within w_pism140i
string tag = "dispmh,dispmh"
integer x = 1015
integer y = 160
integer width = 1710
integer height = 1192
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism140i_02"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 0
end type

event scrollvertical;call super::scrollvertical;If ib_Scrolling1 or ib_Scrolling2 Then Return
ib_Scrolling3 = True
dw_header.Modify("DataWindow.VerticalScrollPosition=" + String(scrollpos))
ib_Scrolling3 = False
end event

event clicked;call super::clicked;dw_day_mhlist.selectrow(0,false)
dw_day_mhlist.selectrow(row,true)
dw_month_mhlist.selectrow(0,false)
dw_month_mhlist.selectrow(row,true)
dw_header.selectrow(0,false)
dw_header.selectrow(row,true)
end event

type dw_header from u_pism_dw within w_pism140i
integer x = 5
integer y = 160
integer width = 1006
integer height = 1404
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pism130i_01_header"
integer ii_selection = 0
end type

event scrollvertical;call super::scrollvertical;If ib_Scrolling2 or ib_Scrolling3 Then Return
ib_Scrolling1 = True
If tab_work.SelectedTab = 1 Then 
	dw_month_mhlist.Modify("DataWindow.VerticalScrollPosition=" + String(scrollpos))
Else
	dw_day_mhlist.Modify("DataWindow.VerticalScrollPosition=" + String(scrollpos))
End If 
ib_Scrolling1 = False
end event

event clicked;call super::clicked;dw_day_mhlist.selectrow(0,false)
dw_day_mhlist.selectrow(row,true)
dw_month_mhlist.selectrow(0,false)
dw_month_mhlist.selectrow(row,true)
dw_header.selectrow(0,false)
dw_header.selectrow(row,true)
end event

type dw_month_mhlist from datawindow within w_pism140i
integer x = 1015
integer y = 160
integer width = 2363
integer height = 1524
integer taborder = 21
string title = "none"
string dataobject = "d_pism140i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event scrollvertical;If ib_Scrolling1 or ib_Scrolling3 Then Return
ib_Scrolling2 = True
dw_header.Modify("DataWindow.VerticalScrollPosition=" + String(scrollpos))
ib_Scrolling2 = False
end event

event clicked;dw_day_mhlist.selectrow(0,false)
dw_day_mhlist.selectrow(row,true)
dw_month_mhlist.selectrow(0,false)
dw_month_mhlist.selectrow(row,true)
dw_header.selectrow(0,false)
dw_header.selectrow(row,true)
end event

