$PBExportHeader$w_pism190i.srw
$PBExportComments$월 및 일별 종합효율/가동율/작업효율/LPI 조회
forward
global type w_pism190i from w_pism_sheet02
end type
type tab_work from tab within w_pism190i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_pism190i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_day_mhlist from u_pism_dw within w_pism190i
end type
type dw_month_mhlist from u_pism_dw within w_pism190i
end type
end forward

global type w_pism190i from w_pism_sheet02
integer width = 5161
tab_work tab_work
dw_day_mhlist dw_day_mhlist
dw_month_mhlist dw_month_mhlist
end type
global w_pism190i w_pism190i

type variables
integer in_index
end variables

forward prototypes
public function long wf_prdatawindowretrieve (datawindow aprdw)
end prototypes

public function long wf_prdatawindowretrieve (datawindow aprdw);Long ll_ret 

aprdw.SetTransObject(SqlPIS)

Choose Case tab_work.SelectedTab 
	Case 1 			// 월별 현황 
		ll_ret = aprdw.Retrieve(istr_mh.area, istr_mh.div, '%', uo_frMonth.is_uo_month, uo_toMonth.is_uo_month)
	Case 2 			// 일별 현황 
		ll_ret = aprdw.Retrieve(istr_mh.area, istr_mh.div, '%', uo_fromdate.is_uo_date, uo_todate.is_uo_date)
End Choose 

Return ll_ret 
end function

event resize;call super::resize;tab_work.Width = newwidth - ( tab_work.x + 10 ) 

dw_day_mhlist.Width = newwidth - ( dw_day_mhlist.x + 10 ) 
dw_month_mhlist.Width = dw_day_mhlist.Width 

dw_day_mhlist.Height = newheight - ( dw_day_mhlist.y + uo_status.Height + 10 ) 
dw_month_mhlist.Height = dw_day_mhlist.Height 
end event

event ue_postopen;call super::ue_postopen;dw_day_mhlist.Modify("seq.Width = 0"); dw_day_mhlist.Modify("DataWindow.Sparse = 'workcentername'") 
dw_month_mhlist.Modify("seq.Width = 0"); dw_month_mhlist.Modify("DataWindow.Sparse = 'workcentername'")

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

If tab_work.SelectedTab = 1 Then 
	lstr_prt.datawindow = dw_month_mhlist
	lstr_prt.DataObject = 'd_pism190i_1p' 
//	lstr_prt.title = istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내 " + tab_work.control[tab_work.SelectedTab].Tag
Else
	lstr_prt.datawindow = dw_day_mhlist
	lstr_prt.DataObject = 'd_pism190i_2p' 
//	lstr_prt.title = istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내 " + tab_work.control[tab_work.SelectedTab].Tag
End If 

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" 

lstr_prt.parent_win = This 

OpenSheetWithParm(w_pism_prt01, lstr_prt, w_frame, 0, Layered! )

end event

event ue_retrieve;call super::ue_retrieve;Long ll_ret 
String ls_conDate

// CrossTab 오류방지를 위한 데이타윈도우 오브젝트 조회시 재배당 2010.05.06
dw_day_mhlist.dataobject = 'd_pism190i_02'
dw_day_mhlist.Modify("seq.Width = 0")
dw_day_mhlist.Modify("DataWindow.Sparse = 'workcentername'") 

dw_month_mhlist.dataobject = 'd_pism190i_01'
dw_month_mhlist.Modify("seq.Width = 0")
dw_month_mhlist.Modify("DataWindow.Sparse = 'workcentername'")


If tab_work.SelectedTab = 1 Then 
	ls_conDate = uo_frMonth.is_uo_month + "∼" + uo_toMonth.is_uo_month 
Else
	ls_conDate = uo_fromdate.is_uo_date + "∼" + uo_todate.is_uo_date 
End If 

f_pism_working_msg(ls_conDate + " " + uo_div.is_uo_divisionname + "공장", &
						 tab_work.control[tab_work.SelectedTab].Text + " 을 조회중입니다. 잠시만 기다려 주십시오.") 

ll_ret = tab_work.Event ue_Retrieve(tab_work.SelectedTab) 

If IsValid(w_pism_working) Then Close(w_pism_working) 

If ll_ret = 0 Then 
	f_pism_messagebox(Information!, -1, "조회실패", ls_conDate + " " + &
						   uo_div.is_uo_divisionname + "공장 의 생산실적이 존재하지 않습니다.")
end if
			
tab_work.control[tab_work.SelectedTab].SetFocus() 
end event

on w_pism190i.create
int iCurrent
call super::create
this.tab_work=create tab_work
this.dw_day_mhlist=create dw_day_mhlist
this.dw_month_mhlist=create dw_month_mhlist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_work
this.Control[iCurrent+2]=this.dw_day_mhlist
this.Control[iCurrent+3]=this.dw_month_mhlist
end on

on w_pism190i.destroy
call super::destroy
destroy(this.tab_work)
destroy(this.dw_day_mhlist)
destroy(this.dw_month_mhlist)
end on

type uo_status from w_pism_sheet02`uo_status within w_pism190i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism190i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism190i
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism190i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism190i
end type

type uo_month from w_pism_sheet02`uo_month within w_pism190i
end type

type uo_year from w_pism_sheet02`uo_year within w_pism190i
end type

type uo_date from w_pism_sheet02`uo_date within w_pism190i
end type

type uo_area from w_pism_sheet02`uo_area within w_pism190i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism190i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism190i
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism190i
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism190i
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism190i
end type

type tab_work from tab within w_pism190i
event type long ue_retrieve ( integer ai_selectedtab )
integer x = 2519
integer y = 28
integer width = 1641
integer height = 108
integer taborder = 40
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

dw_month_mhlist.SetRedraw(False); dw_day_mhlist.SetRedraw(False) 

If ai_selectedtab = 1 Then 		// 월별 공수투입 현황 
	dw_month_mhlist.SetTransObject(SqlPIS) 
	ll_ret = dw_month_mhlist.Retrieve(istr_mh.area, istr_mh.div, '%', uo_frMonth.is_uo_month, uo_toMonth.is_uo_month)
ElseIf ai_selectedtab = 2 Then 	// 일별 공수투입 현황 
	dw_day_mhlist.SetTransObject(SqlPIS) 
	ll_ret = dw_day_mhlist.Retrieve(istr_mh.area, istr_mh.div, '%', uo_fromdate.is_uo_date, uo_todate.is_uo_date)
End If

dw_month_mhlist.SetRedraw(True); dw_day_mhlist.SetRedraw(True) 

Return ll_ret 
end event

event selectionchanged;Choose Case newindex 
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

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 100
integer width = 1605
integer height = -8
long backcolor = 12632256
string text = "월별 종합효율/..."
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
integer x = 18
integer y = 100
integer width = 1605
integer height = -8
long backcolor = 12632256
string text = "일별 종합효율/..."
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_day_mhlist from u_pism_dw within w_pism190i
string tag = "dispmh"
integer x = 9
integer y = 144
integer width = 1710
integer height = 704
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pism190i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

event retrieveend;//If rowcount = 0 Then 
//	This.Object.DataWindow.HorizontalScrollSplit = '0' 
//	This.Object.DataWindow.HorizontalScrollPosition2 = '0'  		
//Else
//	This.Object.DataWindow.HorizontalScrollSplit = '1270' 
//	This.Object.DataWindow.HorizontalScrollPosition2 = '1270'  		
//End If 
end event

type dw_month_mhlist from u_pism_dw within w_pism190i
integer x = 9
integer y = 144
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_pism190i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event scrollvertical;call super::scrollvertical;This.SetRedraw(True) 
end event

