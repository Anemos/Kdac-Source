$PBExportHeader$w_pisz050u.srw
$PBExportComments$조별 목표지수/목표공수 등록
forward
global type w_pisz050u from w_pism_sheet01
end type
type uo_styear from u_pisc_date_scroll_year within w_pisz050u
end type
type tab_work from tab within w_pisz050u
end type
type tabpage_1 from userobject within tab_work
end type
type dw_valuetar from u_pism_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_work
dw_valuetar dw_valuetar
end type
type tabpage_2 from userobject within tab_work
end type
type dw_tarmh from u_pism_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_work
dw_tarmh dw_tarmh
end type
type tab_work from tab within w_pisz050u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_divtarlpi from commandbutton within w_pisz050u
end type
type pb_excel from picturebutton within w_pisz050u
end type
type gb_2 from groupbox within w_pisz050u
end type
end forward

global type w_pisz050u from w_pism_sheet01
integer width = 4663
uo_styear uo_styear
tab_work tab_work
cb_divtarlpi cb_divtarlpi
pb_excel pb_excel
gb_2 gb_2
end type
global w_pisz050u w_pisz050u

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

on w_pisz050u.create
int iCurrent
call super::create
this.uo_styear=create uo_styear
this.tab_work=create tab_work
this.cb_divtarlpi=create cb_divtarlpi
this.pb_excel=create pb_excel
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_styear
this.Control[iCurrent+2]=this.tab_work
this.Control[iCurrent+3]=this.cb_divtarlpi
this.Control[iCurrent+4]=this.pb_excel
this.Control[iCurrent+5]=this.gb_2
end on

on w_pisz050u.destroy
call super::destroy
destroy(this.uo_styear)
destroy(this.tab_work)
destroy(this.cb_divtarlpi)
destroy(this.pb_excel)
destroy(this.gb_2)
end on

event resize;call super::resize;tab_work.Width = newwidth - ( tab_work.x + 10 ) 
tab_work.Height = newheight - ( tab_work.y + 100 ) 
end event

event ue_retrieve;call super::ue_retrieve;Long ll_ret 

If tab_work.SelectedTab = 1 Then 
	If wf_saveChk(tab_work.tabpage_1.dw_valuetar) 	= -1 Then Return 0 
Else
	If wf_saveChk(tab_work.tabpage_2.dw_tarmh) 		= -1 Then Return 0 
End If 

f_pism_working_msg(istr_mh.year + '년도 ' + &
						 uo_wc.is_uo_workcentername + " 조", tab_work.control[tab_work.SelectedTab].Text + "를 조회중입니다. 잠시만 기다려 주십시오.") 

ll_ret = tab_work.Event ue_Retrieve(tab_work.SelectedTab) 
If IsValid(w_pism_working) Then Close(w_pism_working) 
istr_retrievemh = istr_mh

pb_excel.visible = false
pb_excel.enabled = false
If ll_ret < 1 Then 
	f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + "년도~n~n해당 기준년도의 생산실적이 존재하지 않습니다.")
elseif tab_work.selectedtab = 2 then	
	pb_excel.visible = true
	pb_excel.enabled = true
end if

end event

event ue_postopen;call super::ue_postopen;istr_mh.year = uo_styear.is_uo_year
end event

event open;call super::open;ib_wcallView = True 
cb_wcfilter.Visible = False 

cb_divtarlpi.Enabled = m_frame.m_action.m_save.Enabled 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

If tab_work.SelectedTab = 1 Then 
	lstr_prt.datawindow = tab_work.tabpage_1.dw_valuetar
	lstr_prt.DataObject = 'd_pism050u_02_p'
	lstr_prt.title = istr_retrievemh.year + '년도 ' + uo_wc.is_uo_workcentername + " 조 목표지수" 
Else
	lstr_prt.datawindow = tab_work.tabpage_2.dw_tarmh 
	lstr_prt.DataObject = 'd_pism050u_04_p' 
	lstr_prt.title = istr_retrievemh.year + '년도 ' + uo_wc.is_uo_workcentername + " 조 목표공수" 
End If 
lstr_prt.prscale = '84'

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )

end event

event ue_save;call super::ue_save;If tab_work.SelectedTab = 1 Then 
	Long ls_return
	ls_return = f_pism_dwupdate(tab_work.tabpage_1.dw_valuetar, True)
	if ( ((istr_mh.area + istr_mh.div) <> 'DH') and ((istr_mh.area + istr_mh.div) <> 'DV')) then
		DECLARE pism_update PROCEDURE for sp_pism050u_03_update
				@ps_area 		= :istr_mh.area, 
				@ps_div 			= :istr_mh.div, 
				@ps_wc			= :istr_mh.wc, 
				@ps_styear		= :istr_mh.year,
				@ps_lastemp		= :g_s_empno
		Using SQLPIS;
		EXECUTE pism_update ;
	end if
	return ls_return
Else
	return f_pism_dwupdate(tab_work.tabpage_2.dw_tarmh, True) 
End If 

end event

event ue_search;
If tab_work.SelectedTab = 1 Then Return 
OpenWithParm(w_pism_finditem, tab_work.tabpage_2.dw_tarmh) 

end event

event closequery;call super::closequery;If tab_work.SelectedTab = 1 Then 
	wf_saveChk(tab_work.tabpage_1.dw_valuetar)
Else
	wf_saveChk(tab_work.tabpage_2.dw_tarmh)
End If 
end event

type uo_status from w_pism_sheet01`uo_status within w_pisz050u
integer width = 4585
end type

type uo_wc from w_pism_sheet01`uo_wc within w_pisz050u
end type

type uo_area from w_pism_sheet01`uo_area within w_pisz050u
end type

type uo_div from w_pism_sheet01`uo_div within w_pisz050u
end type

type cb_wcfilter from w_pism_sheet01`cb_wcfilter within w_pisz050u
integer x = 2747
integer y = 44
end type

type gb_1 from w_pism_sheet01`gb_1 within w_pisz050u
end type

type uo_styear from u_pisc_date_scroll_year within w_pisz050u
integer x = 2213
integer y = 52
integer taborder = 20
boolean bringtotop = true
end type

on uo_styear.destroy
call u_pisc_date_scroll_year::destroy
end on

event ue_select;call super::ue_select;istr_mh.year = uo_styear.is_uo_year
end event

type tab_work from tab within w_pisz050u
event resize pbm_size
event type long ue_retrieve ( integer ai_selectedtab )
integer x = 5
integer y = 160
integer width = 3410
integer height = 1756
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
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event resize;tabpage_1.dw_valuetar.Width = newwidth - ( tabpage_1.dw_valuetar.x + 40 )
tabpage_1.dw_valuetar.Height = newheight - ( tabpage_1.dw_valuetar.y + 120 ) 

tabpage_2.dw_tarmh.Width = newwidth - ( tabpage_2.dw_tarmh.x + 40 ) 
tabpage_2.dw_tarmh.Height = newheight - ( tabpage_2.dw_tarmh.y + 120 ) 

end event

event type long ue_retrieve(integer ai_selectedtab);
If ai_selectedTab = 1 Then 
	tabpage_1.dw_valuetar.SetTransObject(SqlPIS)
	Return tabpage_1.dw_valuetar.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year, g_s_empno)
Else
	tabpage_2.dw_tarmh.SetTransObject(SqlPIS)
	Return tabpage_2.dw_tarmh.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year, g_s_empno)
End If 

Return 0 
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
if newindex = 2 then
	if this.tabpage_2.dw_tarmh.rowcount() > 0 then
		pb_excel.visible = true
		pb_excel.enabled = true
	end if
end if
end event

type tabpage_1 from userobject within tab_work
integer x = 18
integer y = 100
integer width = 3374
integer height = 1640
long backcolor = 12632256
string text = "목표지수"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_valuetar dw_valuetar
end type

on tabpage_1.create
this.dw_valuetar=create dw_valuetar
this.Control[]={this.dw_valuetar}
end on

on tabpage_1.destroy
destroy(this.dw_valuetar)
end on

type dw_valuetar from u_pism_dw within tabpage_1
integer y = 8
integer width = 2775
integer height = 960
integer taborder = 11
string title = "월별 목표지수"
string dataobject = "d_pism050u_02"
boolean vscrollbar = true
integer ii_selection = 0
end type

event itemchanged;call super::itemchanged;String ls_WorkCenter 
Decimal{1} ld_calcMH 
Long ll_findRow 

This.SetItem(row, "lastemp", g_s_empno) 
This.SetItem(row, "lastdate", f_pisc_get_date_nowtime()) 

This.AcceptText() 
ls_WorkCenter = This.GetItemString(row, "workcenter") 

ll_findRow = 1 + ( 13 * Truncate( row / 13, 0 ) )  

If left(dwo.name, 7) = 'totinmh' Then 
	ld_calcMH = This.GetItemNumber( ll_findRow, "calc_totinmh") 
ElseIf left(dwo.name, 5) = 'actmh' Then 
	ld_calcMH = This.GetItemNumber( ll_findRow, "calc_totactmh") 
ElseIf left(dwo.name, 7) = 'basicmh' Then 
	ld_calcMH = This.GetItemNumber( ll_findRow, "calc_basicmh") 
Else
	Return 
End If 

ll_findRow = This.Find( "workcenter = '" + ls_WorkCenter + "' And tarmonth = '" + istr_mh.year + ".13'", 1, This.RowCount()) 
If ll_findRow = 0 Then Return 

This.SetItem(ll_findRow, String(dwo.name), ld_calcMH) 
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 10) 
end event

event retrieveend;call super::retrieveend;This.SetFocus() 
end event

type tabpage_2 from userobject within tab_work
string tag = "목표공수"
integer x = 18
integer y = 100
integer width = 3374
integer height = 1640
long backcolor = 12632256
string text = "목표공수"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tarmh dw_tarmh
end type

on tabpage_2.create
this.dw_tarmh=create dw_tarmh
this.Control[]={this.dw_tarmh}
end on

on tabpage_2.destroy
destroy(this.dw_tarmh)
end on

type dw_tarmh from u_pism_dw within tabpage_2
event type integer finditem ( string as_itemcode )
integer y = 8
integer width = 2587
integer height = 1440
integer taborder = 11
boolean bringtotop = true
string title = "월별 목표공수"
string dataobject = "d_pism050u_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 0
end type

event type integer finditem(string as_itemcode);Long ll_findRow 
String ls_Chk 

ll_findRow = This.Find("ItemCode = '" + as_ItemCode + "'", 1, This.RowCount()) 
If ll_findRow > 0 Then This.ScrollToRow(ll_findRow)
If ll_findRow = 0 Then f_pism_MessageBox(Information!, 999, "품번검색실패", as_ItemCode + " 해당 품번을 찾을 수 없습니다.") 

Return ll_findRow 

end event

event retrieveend;call super::retrieveend;This.SetRedraw(True) 

uo_status.st_message.text = '목표공수 = 전년도 기준공수 / 해당월 목표LPI' 

end event

event ue_key;///
end event

event itemchanged;call super::itemchanged;
This.SetItem(row, "lastemp", g_s_empno)
This.SetItem(row, "lastdate", f_pisc_get_date_nowtime())

end event

type cb_divtarlpi from commandbutton within w_pisz050u
integer x = 2747
integer y = 44
integer width = 672
integer height = 84
integer taborder = 31
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "공장단위 목표LPI"
end type

event clicked;String ls_modChk 

OpenWithParm(w_pisz051u, istr_mh) 

ls_modChk = message.StringParm 
If ls_modChk = '1' Then Parent.TriggerEvent("ue_retrieve") 
end event

type pb_excel from picturebutton within w_pisz050u
boolean visible = false
integer x = 4453
integer y = 12
integer width = 155
integer height = 132
integer taborder = 30
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
//	f_save_to_excel(tab_work.tabpage_1.dw_valuetar)
elseif tab_work.selectedtab = 2 then
	f_save_to_excel(tab_work.tabpage_2.dw_tarmh)	
end if
end event

type gb_2 from groupbox within w_pisz050u
integer x = 2181
integer y = 4
integer width = 549
integer height = 132
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

