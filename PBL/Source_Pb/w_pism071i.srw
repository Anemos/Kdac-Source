$PBExportHeader$w_pism071i.srw
$PBExportComments$조별 부하율 및 잔업율 조회(표준대비)
forward
global type w_pism071i from w_pism_sheet02
end type
type dw_buharate from u_pism_dw within w_pism071i
end type
type cb_down from commandbutton within w_pism071i
end type
type dw_all_down from datawindow within w_pism071i
end type
type tab_work from tab within w_pism071i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_pism071i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_pism071i from w_pism_sheet02
dw_buharate dw_buharate
cb_down cb_down
dw_all_down dw_all_down
tab_work tab_work
end type
global w_pism071i w_pism071i

on w_pism071i.create
int iCurrent
call super::create
this.dw_buharate=create dw_buharate
this.cb_down=create cb_down
this.dw_all_down=create dw_all_down
this.tab_work=create tab_work
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_buharate
this.Control[iCurrent+2]=this.cb_down
this.Control[iCurrent+3]=this.dw_all_down
this.Control[iCurrent+4]=this.tab_work
end on

on w_pism071i.destroy
call super::destroy
destroy(this.dw_buharate)
destroy(this.cb_down)
destroy(this.dw_all_down)
destroy(this.tab_work)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_allovereff, FULL)
//
//of_resize()
tab_work.Width = newwidth - ( tab_work.x + 10 ) 
dw_buharate.Width = newwidth - ( dw_buharate.x + 10 ) 
dw_buharate.Height = newheight - ( dw_buharate.y + uo_status.Height + 10 ) 

dw_all_down.x= dw_buharate.x
dw_all_down.y= dw_buharate.y
dw_all_down.Width = dw_buharate.Width
dw_all_down.Height= dw_buharate.Height
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

if tab_work.SelectedTab = 1 then
	f_pism_working_msg(uo_div.is_uo_divisionname + "공장", dw_buharate.Tag + "를 조회중입니다. 잠시만 기다려 주십시오.") 
	
	dw_buharate.SetTransObject(SqlPIS)
	li_ret = dw_buharate.Retrieve(istr_mh.area, istr_mh.div, uo_fromdate.is_uo_date,uo_todate.is_uo_date)  
	
	If IsValid(w_pism_working) Then Close(w_pism_working) 
	If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", "해당 기준일자의 생산실적이 존재하지 않습니다.")
	
	dw_buharate.SetFocus() 
else
	string l_s_docname, l_s_named
	int l_n_value, li_chk
	
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
	dw_all_down.setredraw(false)
	if dw_all_down.retrieve( istr_mh.from_date, istr_mh.to_date ) > 0 then
		// RetrieveEnd event에서 진천공장데이타 조회함
		dw_all_down.accepttext()
		dw_all_down.setredraw(true)
	else
		uo_status.st_message.text = "조회할 정보가 없습니다."
	end if
	
	disconnect using sqleis ;
	destroy sqleis
		
	return 0
end if
end event

event open;call super::open;wf_setRetCondition(STFROMTODATE) 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

if tab_work.SelectedTab = 1 then
	lstr_prt.Transaction = SqlPIS 
	
	lstr_prt.datawindow = dw_buharate
	lstr_prt.DataObject = 'd_pism071i_01_p' 
	lstr_prt.title = dw_buharate.Tag
	
	lstr_prt.dwsyntax = "t_title.text = '" + uo_fromdate.is_uo_date + ' - ' + uo_todate.is_uo_date + ' ' + dw_buharate.Tag + "'	" + &
							  "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" 
	OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
else
	lstr_prt.Transaction = SqlPIS 
	
	lstr_prt.datawindow = dw_all_down
	lstr_prt.DataObject = 'd_pism071i_01_all_p' 
	lstr_prt.title = dw_all_down.Tag
	
	lstr_prt.dwsyntax = "t_title.text = '" + uo_fromdate.is_uo_date + ' - ' + uo_todate.is_uo_date + ' ' + dw_buharate.Tag + "'	" + &
							  "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" 
	OpenSheetWithParm(w_pism_prt01, lstr_prt, w_frame, 0, Layered! )
end if
end event

type uo_status from w_pism_sheet02`uo_status within w_pism071i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism071i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism071i
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism071i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism071i
end type

type uo_month from w_pism_sheet02`uo_month within w_pism071i
end type

type uo_year from w_pism_sheet02`uo_year within w_pism071i
end type

type uo_date from w_pism_sheet02`uo_date within w_pism071i
end type

type uo_area from w_pism_sheet02`uo_area within w_pism071i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism071i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism071i
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism071i
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism071i
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism071i
end type

type dw_buharate from u_pism_dw within w_pism071i
string tag = "조별 부하율 및 잔업율"
integer x = 18
integer y = 300
integer width = 1906
integer height = 1320
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism071i_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

type cb_down from commandbutton within w_pism071i
integer x = 2601
integer y = 32
integer width = 471
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "전공장다운로드"
end type

type dw_all_down from datawindow within w_pism071i
string tag = "조별 부하율 및 잔업율(전사)"
integer x = 1952
integer y = 304
integer width = 1518
integer height = 1312
integer taborder = 50
string dataobject = "d_pism071i_01_all"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;if rowcount > 0 then
	integer li_rowcnt, li_cnt, li_currow
	datastore lds_01
	
	lds_01 = create datastore
	lds_01.dataobject = "d_pism071i_01_all_jin"
	lds_01.settransobject(sqleis)
	
	li_rowcnt = lds_01.retrieve('J','S',istr_mh.from_date, istr_mh.to_date )
	for li_cnt = 1 to li_rowcnt
		li_currow = dw_all_down.insertrow(0)
		dw_all_down.setitem(li_currow,"Areacode",'J')
		dw_all_down.setitem(li_currow,"Divisioncode",'S')
		dw_all_down.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		dw_all_down.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		dw_all_down.setitem(li_currow,"totMH",lds_01.getitemnumber(li_cnt,"totMH"))
		dw_all_down.setitem(li_currow,"jungsiMH",lds_01.getitemnumber(li_cnt,"jungsiMH"))
		dw_all_down.setitem(li_currow,"etcMH",lds_01.getitemnumber(li_cnt,"etcMH"))
		dw_all_down.setitem(li_currow,"gunteMH",lds_01.getitemnumber(li_cnt,"gunteMH"))
		dw_all_down.setitem(li_currow,"excpaidMH",lds_01.getitemnumber(li_cnt,"excpaidMH"))
		dw_all_down.setitem(li_currow,"S4MH",lds_01.getitemnumber(li_cnt,"S4MH"))
		dw_all_down.setitem(li_currow,"F67MH",lds_01.getitemnumber(li_cnt,"F67MH"))
		dw_all_down.setitem(li_currow,"tarqtyMH",lds_01.getitemnumber(li_cnt,"tarqtyMH"))
	next
	
	lds_01.reset()
	li_rowcnt = lds_01.retrieve('J','H',istr_mh.from_date, istr_mh.to_date )
	for li_cnt = 1 to li_rowcnt
		li_currow = dw_all_down.insertrow(0)
		dw_all_down.setitem(li_currow,"Areacode",'J')
		dw_all_down.setitem(li_currow,"Divisioncode",'H')
		dw_all_down.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		dw_all_down.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		dw_all_down.setitem(li_currow,"totMH",lds_01.getitemnumber(li_cnt,"totMH"))
		dw_all_down.setitem(li_currow,"jungsiMH",lds_01.getitemnumber(li_cnt,"jungsiMH"))
		dw_all_down.setitem(li_currow,"etcMH",lds_01.getitemnumber(li_cnt,"etcMH"))
		dw_all_down.setitem(li_currow,"gunteMH",lds_01.getitemnumber(li_cnt,"gunteMH"))
		dw_all_down.setitem(li_currow,"excpaidMH",lds_01.getitemnumber(li_cnt,"excpaidMH"))
		dw_all_down.setitem(li_currow,"S4MH",lds_01.getitemnumber(li_cnt,"S4MH"))
		dw_all_down.setitem(li_currow,"F67MH",lds_01.getitemnumber(li_cnt,"F67MH"))
		dw_all_down.setitem(li_currow,"tarqtyMH",lds_01.getitemnumber(li_cnt,"tarqtyMH"))
	next
	
	destroy lds_01
end if
end event

type tab_work from tab within w_pism071i
event type long ue_retrieve ( integer ai_selectedtab )
event create ( )
event destroy ( )
integer x = 18
integer y = 180
integer width = 1458
integer height = 112
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
Choose Case newindex 
	Case 1
		dw_buharate.Visible = True 
		dw_all_down.Visible = False 
	Case 2
		dw_all_down.Visible = True 
		dw_buharate.Visible = False 
End Choose 
end event

type tabpage_1 from userobject within tab_work
string tag = "공장별 조회화면"
integer x = 18
integer y = 100
integer width = 1422
integer height = -4
long backcolor = 12632256
string text = "공장별 조회화면"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
string tag = "전공장조회"
integer x = 18
integer y = 100
integer width = 1422
integer height = -4
long backcolor = 12632256
string text = "전공장 조회화면"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

