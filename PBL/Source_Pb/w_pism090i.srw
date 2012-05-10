$PBExportHeader$w_pism090i.srw
$PBExportComments$월별 종합효율/가동율/작업효율 현황 - 그래프
forward
global type w_pism090i from w_pism_sheet03
end type
type tab_work from tab within w_pism090i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_pism090i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_dispvalue from u_pism_dw within w_pism090i
end type
type dw_lpi from u_pism_dw within w_pism090i
end type
end forward

global type w_pism090i from w_pism_sheet03
integer width = 5280
tab_work tab_work
dw_dispvalue dw_dispvalue
dw_lpi dw_lpi
end type
global w_pism090i w_pism090i

on w_pism090i.create
int iCurrent
call super::create
this.tab_work=create tab_work
this.dw_dispvalue=create dw_dispvalue
this.dw_lpi=create dw_lpi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_work
this.Control[iCurrent+2]=this.dw_dispvalue
this.Control[iCurrent+3]=this.dw_lpi
end on

on w_pism090i.destroy
call super::destroy
destroy(this.tab_work)
destroy(this.dw_dispvalue)
destroy(this.dw_lpi)
end on

event open;call super::open;wf_setRetCondition(STYEAR)

ib_wcallview = True 
end event

event resize;call super::resize;tab_work.Width = newwidth - ( tab_work.x + 10 ) 

dw_dispValue.Width = newwidth - ( dw_dispValue.x + 10 ) 
dw_dispValue.Height = newheight - ( dw_dispValue.y + uo_status.Height + 10 ) 

dw_lpi.Width = dw_dispValue.Width; dw_lpi.Height = dw_dispValue.Height 
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(istr_mh.year + '년 ' + & 
						 uo_div.is_uo_divisionname + "공장 " + uo_wc.is_uo_workcentername + " 조", '월별 ' + tab_work.Control[tab_work.SelectedTab].Text + "을 조회중입니다. 잠시만 기다려 주십시오.") 
If tab_work.SelectedTab = 1 Then 
	dw_dispvalue.SetTransObject(SqlPIS) 
	li_ret = dw_dispvalue.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year) 
Else
	dw_lpi.SetTransObject(SqlPIS) 
	li_ret = dw_lpi.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year) 
End If 

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + '년~n' + uo_wc.is_uo_workcentername + " 조의 생산실적이 존재하지 않습니다.")

end event

event ue_postopen;call super::ue_postopen;//dw_dispvalue.InsertRow(0)
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

If tab_work.SelectedTab = 1 Then 
	lstr_prt.datawindow = dw_dispvalue 
	lstr_prt.DataObject = 'd_pism090i_01_p' 
Else
	lstr_prt.datawindow = dw_lpi 
	lstr_prt.DataObject = 'd_pism100i_02_p' 	
End If 

lstr_prt.title = istr_mh.year + '년 ' + uo_div.is_uo_divisionname + "공장 " + tab_work.Control[tab_work.SelectedTab].Text 

lstr_prt.dwsyntax = "title.text = '" + istr_mh.year + '년 월별 ' + tab_work.Control[tab_work.SelectedTab].Text + "'	" + &
						  "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! ) 
end event

type uo_status from w_pism_sheet03`uo_status within w_pism090i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism090i
end type

event uo_wc::ue_select;call super::ue_select;dw_dispvalue.Reset(); dw_lpi.Reset() 
end event

type st_fromto from w_pism_sheet03`st_fromto within w_pism090i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism090i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism090i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism090i
end type

type uo_month from w_pism_sheet03`uo_month within w_pism090i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism090i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism090i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism090i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism090i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism090i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism090i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism090i
end type

event uo_div::ue_select;call super::ue_select;dw_dispvalue.Reset(); dw_lpi.Reset() 
end event

type tab_work from tab within w_pism090i
integer x = 2949
integer y = 28
integer width = 1495
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

event selectionchanged;Choose Case newindex 
	Case 1		// 종합효율/실동율/작업효율 
		dw_dispvalue.Visible = True 
		dw_lpi.Visible = False 
	Case 2		// LPI 
		dw_lpi.Visible = True 
		dw_dispvalue.Visible = False 
End Choose 
end event

type tabpage_1 from userobject within tab_work
string tag = "1"
integer x = 18
integer y = 100
integer width = 1458
integer height = -4
long backcolor = 12632256
string text = "종합효율/실동율/작업효율"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
string tag = "2"
integer x = 18
integer y = 100
integer width = 1458
integer height = -4
long backcolor = 12632256
string text = "LPI"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_dispvalue from u_pism_dw within w_pism090i
integer y = 152
integer width = 3209
integer height = 1740
integer taborder = 11
string dataobject = "d_pism090i_01_graph"
integer ii_selection = 0
end type

event retrieveend;call super::retrieveend;This.SetFocus()
end event

type dw_lpi from u_pism_dw within w_pism090i
integer y = 152
integer width = 3209
integer height = 1740
integer taborder = 11
string dataobject = "d_pism100i_02"
integer ii_selection = 0
end type

event retrieveend;call super::retrieveend;This.SetFocus()
end event

