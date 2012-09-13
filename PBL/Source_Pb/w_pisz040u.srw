$PBExportHeader$w_pisz040u.srw
$PBExportComments$전년도 기준공수 등록
forward
global type w_pisz040u from w_pism_sheet01
end type
type uo_styear from u_pism_year-1 within w_pisz040u
end type
type tab_work from tab within w_pisz040u
end type
type tabpage_1 from userobject within tab_work
end type
type dw_stmh from u_pism_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_work
dw_stmh dw_stmh
end type
type tabpage_2 from userobject within tab_work
end type
type dw_overalleff from u_pism_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_work
dw_overalleff dw_overalleff
end type
type tab_work from tab within w_pisz040u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_stmonth from commandbutton within w_pisz040u
end type
type pb_excel from picturebutton within w_pisz040u
end type
end forward

global type w_pisz040u from w_pism_sheet01
integer width = 3973
uo_styear uo_styear
tab_work tab_work
cb_stmonth cb_stmonth
pb_excel pb_excel
end type
global w_pisz040u w_pisz040u

type variables

end variables

forward prototypes
public function integer wf_savechk (datawindow adw)
end prototypes

public function integer wf_savechk (datawindow adw);
If adw.ModifiedCount() > 0 Then Goto saveChk_proc

Return 0

saveChk_proc:

If f_pism_MessageBox(Question!, 999, adw.Title, "수정된 자료가 있습니다. 저장하시겠습니까?") = 1 Then 
	Return This.Event ue_save(0,1) 
End If 

Return 0
end function

on w_pisz040u.create
int iCurrent
call super::create
this.uo_styear=create uo_styear
this.tab_work=create tab_work
this.cb_stmonth=create cb_stmonth
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_styear
this.Control[iCurrent+2]=this.tab_work
this.Control[iCurrent+3]=this.cb_stmonth
this.Control[iCurrent+4]=this.pb_excel
end on

on w_pisz040u.destroy
call super::destroy
destroy(this.uo_styear)
destroy(this.tab_work)
destroy(this.cb_stmonth)
destroy(this.pb_excel)
end on

event resize;call super::resize;tab_work.Width = newwidth - ( tab_work.x + 10 )
tab_work.Height = newheight - ( tab_work.y + 100 )
end event

event ue_retrieve;call super::ue_retrieve;Long ll_ret 

If wf_saveChk(tab_work.tabpage_1.dw_stmh) = -1 Then Return 0 

f_pism_working_msg(istr_mh.year + '년도 ' + &
						 uo_wc.is_uo_workcentername + " 조", tab_work.control[tab_work.SelectedTab].Tag + "를 조회중입니다. 잠시만 기다려 주십시오.") 

ll_ret = tab_work.Event ue_Retrieve(tab_work.SelectedTab) 

If IsValid(w_pism_working) Then Close(w_pism_working) 

pb_excel.visible = false
pb_excel.enabled = false
If ll_ret < 1 Then 
	f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + "년도~n~n해당 기준년도의 생산실적이 존재하지 않습니다.")
elseif tab_work.selectedtab = 1 then	
	pb_excel.visible = true
	pb_excel.enabled = true
end if
This.Event ue_retresult(ll_ret) 
tab_work.control[tab_work.SelectedTab].Setfocus() 
end event

event open;call super::open;ib_wcallView = True 

cb_stmonth.Enabled = m_frame.m_action.m_save.Enabled 
end event

event ue_postopen;call super::ue_postopen;istr_mh.year = uo_styear.uf_setapplyYear(istr_mh)

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건
String ls_ModString = "	" 
Integer I, li_viewChk, li_viewCnt 

lstr_prt.Transaction = SqlPIS 

If tab_work.SelectedTab = 1 Then 
	lstr_prt.datawindow = tab_work.tabpage_1.dw_stmh
	lstr_prt.DataObject = 'd_pism040u_02_p' 
	lstr_prt.title = istr_mh.year + '년도 ' + uo_wc.is_uo_workcentername + " 조 기준공수" 
	
	For I = 1 To 12 
		li_viewChk = f_pism_stmonth_visiblechk(istr_mh.Area, istr_mh.Div, istr_mh.year, String(I, "00") )
		If li_viewChk = 0 Then 
			li_viewCnt++ 
			ls_ModString += "mh_" + String(I, "00") + ".visible = " + String(li_viewChk) 
		End If 
	Next 
	
	ls_ModString += "	title.x = " + String(5794 + ((12 - li_viewCnt) * 1534 / 2)) + "	" + & 
						 "pagecnt.x = " + String(15319 + ((12 - li_viewCnt) * 1534)) + "	" + & 
						 "p_footer.x = " + String(15478 + ((12 - li_viewCnt) * 1534))
Else
	lstr_prt.datawindow = tab_work.tabpage_2.dw_overalleff 
	lstr_prt.DataObject = 'd_pism040u_03_p' 
	lstr_prt.title = istr_mh.year + '년도 ' + uo_wc.is_uo_workcentername + " 조 기준월별 종합효율" 

	For I = 1 To 12 
		li_viewChk = f_pism_stmonth_visiblechk(istr_mh.Area, istr_mh.Div, istr_mh.year, String(I, "00") )
		If li_viewChk = 0 Then 
			li_viewCnt++ 
			ls_ModString += "rate_" + String(I, "00") + ".visible = " + String(li_viewChk) 
		End If 
	Next 

	ls_ModString += "	title.x = " + String((12 - li_viewCnt) * 1746 / 2) + "	" + & 
						 "pagecnt.x = " + String(7434 + ((12 - li_viewCnt) * 1746)) + "	" + & 
						 "l_gr.x2 = " + String(12938 + ((12 - li_viewCnt) * 1746)) 
End If 

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'" 
If ls_ModString <> "	" Then lstr_prt.dwsyntax += ls_ModString 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )

end event

event ue_save;call super::ue_save;tab_work.Event ue_Save(tab_work.SelectedTab) 

end event

event ue_search;If tab_work.SelectedTab = 2 Then Return 
OpenWithParm(w_pism_finditem, tab_work.tabpage_1.dw_stmh) 

end event

event closequery;call super::closequery;wf_saveChk(tab_work.tabpage_1.dw_stmh) 
end event

type uo_status from w_pism_sheet01`uo_status within w_pisz040u
end type

type uo_wc from w_pism_sheet01`uo_wc within w_pisz040u
end type

type uo_area from w_pism_sheet01`uo_area within w_pisz040u
end type

type uo_div from w_pism_sheet01`uo_div within w_pisz040u
end type

event uo_div::ue_select;call super::ue_select;istr_mh.year = uo_styear.uis_appYear 

//Integer I, li_viewChk 
//
//tab_work.tabpage_1.dw_stmh.SetRedraw(False)
//
//For I = 1 To 12 
//	li_viewChk = f_pism_stmonth_visiblechk(istr_mh.Area, istr_mh.Div, istr_mh.year, String(I, "00") )
//	tab_work.tabpage_1.dw_stmh.Modify("mh_" + String(I, "00") + ".visible = " + String(li_viewChk)) 
//	tab_work.tabpage_2.dw_overalleff.Modify("rate_" + String(I, "00") + ".visible = " + String(li_viewChk)) 
//Next 
//
//tab_work.tabpage_1.dw_stmh.SetRedraw(True)
end event

type cb_wcfilter from w_pism_sheet01`cb_wcfilter within w_pisz040u
end type

type gb_1 from w_pism_sheet01`gb_1 within w_pisz040u
end type

type uo_styear from u_pism_year-1 within w_pisz040u
integer x = 2176
integer taborder = 20
boolean bringtotop = true
end type

on uo_styear.destroy
call u_pism_year-1::destroy
end on

event ue_variable_change;call super::ue_variable_change;istr_mh.year = uo_styear.uis_appYear
end event

type tab_work from tab within w_pisz040u
event resize pbm_size
event type long ue_retrieve ( integer ai_selectedtab )
event ue_save ( integer ai_selectedtab )
integer x = 14
integer y = 168
integer width = 3634
integer height = 1720
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event resize;
tabpage_1.dw_stmh.Width = newwidth - ( tabpage_1.dw_stmh.x + 40 ) 
tabpage_1.dw_stmh.Height = newheight - ( tabpage_1.dw_stmh.y + 120 ) 

tabpage_2.dw_overalleff.Width = newwidth - ( tabpage_2.dw_overalleff.x + 40 ) 
tabpage_2.dw_overalleff.Height = newheight - ( tabpage_2.dw_overalleff.y + 120 ) 

end event

event type long ue_retrieve(integer ai_selectedtab);
If ai_selectedTab = 1 Then 
	tabpage_1.dw_stmh.SetTransObject(SqlPIS)
	Return tabpage_1.dw_stmh.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year, g_s_empno)
Else
	tabpage_2.dw_overalleff.SetTransObject(SqlPIS)
	Return tabpage_2.dw_overalleff.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year)
End If 

Return 0 
end event

event ue_save(integer ai_selectedtab);If ai_selectedTab = 1 Then 
	tabpage_1.dw_stmh.TriggerEvent("save_data") 
End If 
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

event selectionchanged;pb_excel.visible = false
pb_excel.enabled = false
if newindex = 1 then
	if this.tabpage_1.dw_stmh.rowcount() > 0 then
		pb_excel.visible = true
		pb_excel.enabled = true
	end if
end if
end event

type tabpage_1 from userobject within tab_work
string tag = "기준공수"
integer x = 18
integer y = 100
integer width = 3598
integer height = 1604
long backcolor = 12632256
string text = "기준공수"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_stmh dw_stmh
end type

on tabpage_1.create
this.dw_stmh=create dw_stmh
this.Control[]={this.dw_stmh}
end on

on tabpage_1.destroy
destroy(this.dw_stmh)
end on

type dw_stmh from u_pism_dw within tabpage_1
integer y = 8
integer width = 3442
integer height = 1108
integer taborder = 11
string title = "전년도 조별 기준공수"
string dataobject = "d_pism040u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event retrieveend;call super::retrieveend;Integer I, li_viewChk 

This.SetRedraw(False) 

For I = 1 To 12 
	li_viewChk = f_pism_stmonth_visiblechk(istr_mh.Area, istr_mh.Div, istr_mh.year, String(I, "00") )
	This.Modify("mh_" + String(I, "00") + ".visible = " + String(li_viewChk)) 
Next 

This.SetRedraw(True)
end event

event retrievestart;call super::retrievestart;This.SetRedraw(False)
end event

event save_data;call super::save_data;Long ls_return
string ls_year

ls_year   = string(long(istr_mh.year) + 1,"0000") 
ls_return = f_pism_dwupdate(This, True) 
if ( ((istr_mh.area + istr_mh.div) <> 'DH') and ((istr_mh.area + istr_mh.div) <> 'DV')) then
	DECLARE pism_update PROCEDURE for sp_pism050u_03_update
			@ps_area 		= :istr_mh.area, 
			@ps_div 			= :istr_mh.div, 
			@ps_wc			= :istr_mh.wc, 
			@ps_styear		= :ls_year,
			@ps_lastemp		= :g_s_empno
	Using SQLPIS;
	EXECUTE pism_update ;
end if
return ls_return

end event

event itemchanged;call super::itemchanged;String ls_modChk 
Decimal{4} ld_stMH, ld_stmonthavg, ld_styearavg 

ls_modChk = This.GetItemString(row, "modifyflag")
If IsNull(ls_modChk) Then ls_modChk = '1' 
If ls_modChk <> '1' Then Return 

ld_stMH = Double(data) 
ld_stmonthavg = This.GetItemNumber(row, "stmonthavg"); If IsNull(ld_stmonthavg) Then ld_stmonthavg = 0 
ld_styearavg  = This.GetItemNumber(row, "styearavg"); If IsNull(ld_styearavg) Then ld_styearavg = 0 

//If ( ld_stMH > ld_stmonthavg ) And ( ld_stMH > ld_styearavg ) Then 
//	f_pism_MessageBox(StopSign!, -1, "기준공수 입력오류", "입력값이 기준월누계치(연간누계치)보다 클 수 없습니다.")
//	ld_stMH = This.GetItemNumber(row, "stmh") 
//	This.SetItem(row, "stmh", ld_stMH); This.SelectText(1, 10) 
//	Return 1 
//Else
	This.AcceptText() 
//End If 

//This.SetItem(row, "modifyflag", ls_modChk) 
This.SetItem(row, "lastemp", g_s_empno)
This.SetItem(row, "lastdate", f_pisc_get_date_nowtime())

end event

type tabpage_2 from userobject within tab_work
string tag = "기준월별 종합효율"
integer x = 18
integer y = 100
integer width = 3598
integer height = 1604
long backcolor = 12632256
string text = "종합효율"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_overalleff dw_overalleff
end type

on tabpage_2.create
this.dw_overalleff=create dw_overalleff
this.Control[]={this.dw_overalleff}
end on

on tabpage_2.destroy
destroy(this.dw_overalleff)
end on

type dw_overalleff from u_pism_dw within tabpage_2
integer y = 8
integer width = 3113
integer height = 1484
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism040u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
integer ii_selection = 1
end type

event retrieveend;call super::retrieveend;Integer I, li_viewChk 

This.SetRedraw(False) 

For I = 1 To 12 
	li_viewChk = f_pism_stmonth_visiblechk(istr_mh.Area, istr_mh.Div, istr_mh.year, String(I, "00") )
	This.Modify("rate_" + String(I, "00") + ".visible = " + String(li_viewChk)) 
Next 

This.SetRedraw(True)

end event

type cb_stmonth from commandbutton within w_pisz040u
integer x = 2848
integer y = 44
integer width = 567
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "기준월등록"
end type

event clicked;String ls_modChk 

OpenWithParm(w_pisz041u, istr_mh)

ls_modChk = message.StringParm
If ls_modChk = '1' Then Parent.TriggerEvent("ue_retrieve") 
end event

type pb_excel from picturebutton within w_pisz040u
boolean visible = false
integer x = 4453
integer y = 12
integer width = 155
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if tab_work.selectedtab = 1 then
	f_save_to_excel(tab_work.tabpage_1.dw_stmh)
elseif tab_work.selectedtab = 2 then
	 
end if
end event

