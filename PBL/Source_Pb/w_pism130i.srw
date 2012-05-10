$PBExportHeader$w_pism130i.srw
$PBExportComments$조별 공수투입 현황
forward
global type w_pism130i from w_pism_sheet02
end type
type tab_work from tab within w_pism130i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_pism130i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_mhlist from u_pism_dw within w_pism130i
end type
type dw_header from u_pism_dw within w_pism130i
end type
type dw_mhdetaillist from u_pism_dw within w_pism130i
end type
end forward

global type w_pism130i from w_pism_sheet02
tab_work tab_work
dw_mhlist dw_mhlist
dw_header dw_header
dw_mhdetaillist dw_mhdetaillist
end type
global w_pism130i w_pism130i

type variables
Boolean ib_Scrolling1, ib_Scrolling2 
end variables

forward prototypes
public function long wf_prdatawindowretrieve (datawindow aprdw)
end prototypes

public function long wf_prdatawindowretrieve (datawindow aprdw);Long ll_rowCnt 

aprdw.SetTransObject(SqlPIS)
ll_rowCnt = aprdw.Retrieve(istr_mh.area, istr_mh.div, istr_mh.from_date, istr_mh.to_date, String(tab_work.SelectedTab)) 

Return ll_rowCnt 

end function

event open;call super::open;wf_setRetCondition(STFROMTODATE) 
end event

on w_pism130i.create
int iCurrent
call super::create
this.tab_work=create tab_work
this.dw_mhlist=create dw_mhlist
this.dw_header=create dw_header
this.dw_mhdetaillist=create dw_mhdetaillist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_work
this.Control[iCurrent+2]=this.dw_mhlist
this.Control[iCurrent+3]=this.dw_header
this.Control[iCurrent+4]=this.dw_mhdetaillist
end on

on w_pism130i.destroy
call super::destroy
destroy(this.tab_work)
destroy(this.dw_mhlist)
destroy(this.dw_header)
destroy(this.dw_mhdetaillist)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(tab_work, RIGHT)
//
//of_resize()

tab_work.Width = newwidth - ( tab_work.x + 10 ) 
dw_mhlist.Height = newheight - ( dw_mhlist.y + uo_status.Height + 12 ) 

dw_header.Height = dw_mhlist.Height - 50
dw_mhlist.Width = newwidth - ( dw_mhlist.x + 10 ) 
end event

event ue_retrieve;call super::ue_retrieve;Long ll_ret 

// CrossTab 오류방지를 위한 데이타윈도우 오브젝트 조회시 재배당 2010.05.06
dw_mhlist.dataobject = 'd_pism130i_01'
dw_mhlist.settransobject(sqlpis)
dw_mhlist.Modify("seq1.Width = 0") 
dw_mhlist.Modify("seq2.Width = 0") 
dw_mhlist.Modify("displevel.Width = 0") 
dw_mhdetaillist.dataobject = 'd_pism130i_02'
dw_mhdetaillist.settransobject(sqlpis)

f_pism_working_msg(istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내 " + & 
						 uo_div.is_uo_divisionname + " 공장", tab_work.control[tab_work.SelectedTab].Tag + " 을 조회중입니다. 잠시만 기다려 주십시오.") 

ll_ret = tab_work.Event ue_Retrieve(tab_work.SelectedTab) 

If IsValid(w_pism_working) Then Close(w_pism_working) 

If ll_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", istr_mh.From_Date + "∼" + istr_mh.To_Date + &
																		 " 기간내~n~n해당 공장의 생산실적이 존재하지 않습니다.")

tab_work.control[tab_work.SelectedTab].SetFocus() 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.DataObject = 'd_pism130i_p' 
lstr_prt.title = istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내 " + tab_work.control[tab_work.SelectedTab].Tag
lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" 

lstr_prt.parent_win = This 

OpenSheetWithParm(w_pism_prt01, lstr_prt, w_frame, 0, Layered! )

end event

event ue_postopen;call super::ue_postopen;dw_mhlist.Modify("seq1.Width = 0") 
dw_mhlist.Modify("seq2.Width = 0") 
dw_mhlist.Modify("displevel.Width = 0") 
//dw_mhlist.Modify("dispname.Width = 0") -- 수행시 조명이 보이질 않음(??) 

end event

type uo_status from w_pism_sheet02`uo_status within w_pism130i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism130i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism130i
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism130i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism130i
end type

type uo_month from w_pism_sheet02`uo_month within w_pism130i
end type

type uo_year from w_pism_sheet02`uo_year within w_pism130i
end type

type uo_date from w_pism_sheet02`uo_date within w_pism130i
end type

type uo_area from w_pism_sheet02`uo_area within w_pism130i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism130i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism130i
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism130i
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism130i
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism130i
end type

type tab_work from tab within w_pism130i
event type long ue_retrieve ( integer ai_selectedtab )
integer x = 2533
integer y = 24
integer width = 1152
integer height = 112
integer taborder = 20
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

dw_header.SetRedraw(False); dw_mhlist.SetRedraw(False) 

dw_header.SetTransObject(SqlPIS) 
dw_header.Retrieve(String(ai_selectedtab)) 

//If ai_selectedtab = 1 Then 		// 공수투입 현황
	dw_mhlist.SetTransObject(SqlPIS)
	ll_ret = dw_mhlist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.from_date, istr_mh.to_date, String(ai_selectedtab)) 
	
//ElseIf ai_selectedtab = 2 Then 	// 공수투입 상세현황 
//	dw_mhdetaillist.SetTransObject(SqlPIS)
//	Return dw_mhdetaillist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.from_date, istr_mh.to_date)
//End If

dw_header.SetRedraw(True); dw_mhlist.SetRedraw(True) 
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
//Choose Case newindex 
//	Case 1
		dw_mhlist.Visible = True 
		dw_mhdetaillist.Visible = False 
//	Case 2
//		dw_mhdetaillist.Visible = True 
//		dw_mhlist.Visible = False 
//End Choose 
end event

type tabpage_1 from userobject within tab_work
string tag = "조별 공수투입현황"
integer x = 18
integer y = 100
integer width = 1115
integer height = -4
long backcolor = 12632256
string text = "공수투입현황"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
string tag = "조별 공수투입 상세현황"
integer x = 18
integer y = 100
integer width = 1115
integer height = -4
long backcolor = 12632256
string text = "상세현황"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type dw_mhlist from u_pism_dw within w_pism130i
string tag = "dispmh,dispmh"
integer x = 1019
integer y = 164
integer width = 2510
integer height = 1404
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism130i_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 0
end type

event scrollvertical;call super::scrollvertical;If ib_Scrolling1 Then Return
ib_Scrolling2 = True
dw_header.Modify("DataWindow.VerticalScrollPosition=" + String(scrollpos))
ib_Scrolling2 = False 
end event

event clicked;call super::clicked;dw_mhlist.selectrow(0,false)
dw_mhlist.selectrow(row,true)
dw_header.selectrow(0,false)
dw_header.selectrow(row,true)
end event

type dw_header from u_pism_dw within w_pism130i
integer x = 5
integer y = 160
integer width = 1006
integer height = 1404
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism130i_01_header"
integer ii_selection = 0
end type

event scrollvertical;call super::scrollvertical;If ib_Scrolling2 Then Return
ib_Scrolling1 = True
dw_mhlist.Modify("DataWindow.VerticalScrollPosition=" + String(scrollpos))
ib_Scrolling1 = False
end event

event clicked;call super::clicked;dw_mhlist.selectrow(0,false)
dw_mhlist.selectrow(row,true)
dw_header.selectrow(0,false)
dw_header.selectrow(row,true)
end event

type dw_mhdetaillist from u_pism_dw within w_pism130i
string tag = "dispmh,dispmh"
integer x = 1015
integer y = 160
integer width = 2007
integer height = 1148
integer taborder = 11
string dataobject = "d_pism130i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 0
end type

