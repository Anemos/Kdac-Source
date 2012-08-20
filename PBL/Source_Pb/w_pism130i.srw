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
type cb_all_down from commandbutton within w_pism130i
end type
type dw_all_down from datawindow within w_pism130i
end type
end forward

global type w_pism130i from w_pism_sheet02
integer width = 3968
tab_work tab_work
dw_mhlist dw_mhlist
dw_header dw_header
dw_mhdetaillist dw_mhdetaillist
cb_all_down cb_all_down
dw_all_down dw_all_down
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
this.cb_all_down=create cb_all_down
this.dw_all_down=create dw_all_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_work
this.Control[iCurrent+2]=this.dw_mhlist
this.Control[iCurrent+3]=this.dw_header
this.Control[iCurrent+4]=this.dw_mhdetaillist
this.Control[iCurrent+5]=this.cb_all_down
this.Control[iCurrent+6]=this.dw_all_down
end on

on w_pism130i.destroy
call super::destroy
destroy(this.tab_work)
destroy(this.dw_mhlist)
destroy(this.dw_header)
destroy(this.dw_mhdetaillist)
destroy(this.cb_all_down)
destroy(this.dw_all_down)
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

type cb_all_down from commandbutton within w_pism130i
integer x = 3456
integer y = 24
integer width = 457
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "전공장다운"
end type

event clicked;string l_s_docname, l_s_named
int l_n_value, li_chk

if String(tab_work.SelectedTab) <> '1' then
	uo_status.st_message.text = "공수투입현황만 전사다운로드가 가능합니다."
	return -1
end if

// EIS DB
SQLEIS 							= 	CREATE transaction
SQLEIS.DBMS       			= 	ProfileString(gs_inifile,"DATABASE_EIS","DBMS",			" ")
SQLEIS.ServerName 			= 	ProfileString(gs_inifile,"DATABASE_EIS","ServerName",	" ")
SQLEIS.Database   			= 	ProfileString(gs_inifile,"DATABASE_EIS","Database",		" ")
SQLEIS.LogID      				= 	ProfileString(gs_inifile,"DATABASE_EIS","LogId",			" ")
SQLEIS.LogPass    			= 	ProfileString(gs_inifile,"DATABASE_EIS","LogPass",		" ")
SQLEIS.DBParm 				= 	"CommitOnDisconnect='No'"
SQLEIS.AutoCommit 			= 	True

gs_appname						= 	ProfileString(gs_inifile,"PARAMETER","AppName"," ")

connect using SQLEIS;

If SQLEIS.sqlcode <> 0 then
	disconnect using sqleis ;
	destroy sqleis
	uo_status.st_message.text = "EIS 서버에 접근할수 없습니다."
	return -1
end if

dw_all_down.settransobject(sqleis)

if dw_all_down.retrieve(istr_mh.from_date, istr_mh.to_date, String(tab_work.SelectedTab)) > 0 then
	integer li_rowcnt, li_cnt, li_currow
	string ls_areacode
	datastore lds_01

	lds_01 = create datastore
	lds_01.dataobject = "d_pism130i_01_all_jin"
	lds_01.settransobject(sqleis)
	
	li_rowcnt = lds_01.retrieve('J','S',istr_mh.from_date, istr_mh.to_date, String(tab_work.SelectedTab))
	for li_cnt = 1 to li_rowcnt
		li_currow = dw_all_down.insertrow(0)
		dw_all_down.setitem(li_currow,"Areacode",'J')
		dw_all_down.setitem(li_currow,"Divisioncode",'S')
		dw_all_down.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		dw_all_down.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		dw_all_down.setitem(li_currow,"Seq1",lds_01.getitemnumber(li_cnt,"Seq1"))
		dw_all_down.setitem(li_currow,"Seq2",lds_01.getitemnumber(li_cnt,"Seq2"))
		dw_all_down.setitem(li_currow,"dispLevel",lds_01.getitemstring(li_cnt,"dispLevel"))
		dw_all_down.setitem(li_currow,"dispName",lds_01.getitemstring(li_cnt,"dispName"))
		dw_all_down.setitem(li_currow,"dispMH",lds_01.getitemnumber(li_cnt,"dispMH"))
		dw_all_down.setitem(li_currow,"dispRate",lds_01.getitemnumber(li_cnt,"dispRate"))
	next
	
	lds_01.reset()
	li_rowcnt = lds_01.retrieve('J','H',istr_mh.from_date, istr_mh.to_date, String(tab_work.SelectedTab))
	for li_cnt = 1 to li_rowcnt
		li_currow = dw_all_down.insertrow(0)
		dw_all_down.setitem(li_currow,"Areacode",'J')
		dw_all_down.setitem(li_currow,"Divisioncode",'H')
		dw_all_down.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		dw_all_down.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		dw_all_down.setitem(li_currow,"Seq1",lds_01.getitemnumber(li_cnt,"Seq1"))
		dw_all_down.setitem(li_currow,"Seq2",lds_01.getitemnumber(li_cnt,"Seq2"))
		dw_all_down.setitem(li_currow,"dispLevel",lds_01.getitemstring(li_cnt,"dispLevel"))
		dw_all_down.setitem(li_currow,"dispName",lds_01.getitemstring(li_cnt,"dispName"))
		dw_all_down.setitem(li_currow,"dispMH",lds_01.getitemnumber(li_cnt,"dispMH"))
		dw_all_down.setitem(li_currow,"dispRate",lds_01.getitemnumber(li_cnt,"dispRate"))
	next

	destroy lds_01

	f_save_to_excel_execute(dw_all_down,'1')
//	// 엑셀저장 시작
//	
//	If dw_all_down.RowCount() = 0 Then Return 
//
//	l_s_docname = Parent.Title 
//	
//	l_n_value = GetFileSaveName("저장 하기", l_s_docname, l_s_named, "xls", "Excel files (*.xls), *.xls")
//	if l_n_value = 1 then
//		li_Chk = dw_all_down.saveas(l_s_docname, HTMLTABLE!, true) 
////		li_Chk = dw_all_down.saveas(l_s_docname, Excel!, true)
//		If li_Chk = -1 Then 
//			f_pism_messagebox(StopSign!, -1, "확 인", "파일저장 오류 입니다.") 
//		End If 
//	end if
//	
//	if l_n_value = 1 and li_chk <> -1 then
//		OleObject     myOleObject
//		int           i_Result
//		String        excel_title
//		
//		myOleObject = Create OleObject //ole 오브젝트 생성
//		
//		i_Result = myOleObject.ConnectToNewObject( "excel.application" )
//		// 엑셀에 연결
//		excel_title = myOleObject.Application.Caption
//		
//		myOleObject.Application.Visible = True
//		
//		myOleObject.WorkBooks.Open(l_s_docname)
//		myOleObject.WindowState = 3 
//		// 엑셀윈도우의 상태 지정 1-normal, 2-min, 3-max
//		
//		myoleobject.DisConnectObject() //연결종료
//		Destroy myoleobject //오브젝트 제거
//	end if	
else
	uo_status.st_message.text = "조회할 정보가 없습니다."
end if

disconnect using sqleis ;
destroy sqleis
	
return 0
end event

type dw_all_down from datawindow within w_pism130i
boolean visible = false
integer x = 3547
integer y = 164
integer width = 325
integer height = 400
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pism130i_01_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

