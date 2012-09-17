$PBExportHeader$w_pism071i.srw
$PBExportComments$조별 부하율 및 잔업율 조회(표준대비)
forward
global type w_pism071i from w_pism_sheet02
end type
type dw_buharate from u_pism_dw within w_pism071i
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
type pb_down from picturebutton within w_pism071i
end type
end forward

global type w_pism071i from w_pism_sheet02
dw_buharate dw_buharate
dw_all_down dw_all_down
tab_work tab_work
pb_down pb_down
end type
global w_pism071i w_pism071i

forward prototypes
public function long wf_prdatawindowretrieve (datawindow aprdw)
end prototypes

public function long wf_prdatawindowretrieve (datawindow aprdw);Long ll_rowCnt 

aprdw.SetTransObject(sqleis)
ll_rowCnt = aprdw.Retrieve(istr_mh.from_date, istr_mh.to_date)
if ll_rowCnt > 0 then
	integer li_rowcnt, li_cnt, li_currow
	datastore lds_01
	
	lds_01 = create datastore
	lds_01.dataobject = "d_pism071i_01_all_jin"
	lds_01.settransobject(sqleis)
	
	li_rowcnt = lds_01.retrieve('J','S',istr_mh.from_date, istr_mh.to_date )
	for li_cnt = 1 to li_rowcnt
		li_currow = aprdw.insertrow(0)
		aprdw.setitem(li_currow,"Areacode",'J')
		aprdw.setitem(li_currow,"Divisioncode",'S')
		aprdw.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		aprdw.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		aprdw.setitem(li_currow,"totMH",lds_01.getitemnumber(li_cnt,"totMH"))
		aprdw.setitem(li_currow,"jungsiMH",lds_01.getitemnumber(li_cnt,"jungsiMH"))
		aprdw.setitem(li_currow,"etcMH",lds_01.getitemnumber(li_cnt,"etcMH"))
		aprdw.setitem(li_currow,"gunteMH",lds_01.getitemnumber(li_cnt,"gunteMH"))
		aprdw.setitem(li_currow,"excpaidMH",lds_01.getitemnumber(li_cnt,"excpaidMH"))
		aprdw.setitem(li_currow,"bugaMH",lds_01.getitemnumber(li_cnt,"bugaMH"))
		aprdw.setitem(li_currow,"S4MH",lds_01.getitemnumber(li_cnt,"S4MH"))
		aprdw.setitem(li_currow,"F67MH",lds_01.getitemnumber(li_cnt,"F67MH"))
		aprdw.setitem(li_currow,"tarqtyMH",lds_01.getitemnumber(li_cnt,"tarqtyMH"))
	next
	
	lds_01.reset()
	li_rowcnt = lds_01.retrieve('J','H',istr_mh.from_date, istr_mh.to_date )
	for li_cnt = 1 to li_rowcnt
		li_currow = aprdw.insertrow(0)
		aprdw.setitem(li_currow,"Areacode",'J')
		aprdw.setitem(li_currow,"Divisioncode",'H')
		aprdw.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		aprdw.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		aprdw.setitem(li_currow,"totMH",lds_01.getitemnumber(li_cnt,"totMH"))
		aprdw.setitem(li_currow,"jungsiMH",lds_01.getitemnumber(li_cnt,"jungsiMH"))
		aprdw.setitem(li_currow,"etcMH",lds_01.getitemnumber(li_cnt,"etcMH"))
		aprdw.setitem(li_currow,"gunteMH",lds_01.getitemnumber(li_cnt,"gunteMH"))
		aprdw.setitem(li_currow,"excpaidMH",lds_01.getitemnumber(li_cnt,"excpaidMH"))
		aprdw.setitem(li_currow,"bugaMH",lds_01.getitemnumber(li_cnt,"bugaMH"))
		aprdw.setitem(li_currow,"S4MH",lds_01.getitemnumber(li_cnt,"S4MH"))
		aprdw.setitem(li_currow,"F67MH",lds_01.getitemnumber(li_cnt,"F67MH"))
		aprdw.setitem(li_currow,"tarqtyMH",lds_01.getitemnumber(li_cnt,"tarqtyMH"))
	next
	
	destroy lds_01
end if

Return ll_rowCnt 

end function

on w_pism071i.create
int iCurrent
call super::create
this.dw_buharate=create dw_buharate
this.dw_all_down=create dw_all_down
this.tab_work=create tab_work
this.pb_down=create pb_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_buharate
this.Control[iCurrent+2]=this.dw_all_down
this.Control[iCurrent+3]=this.tab_work
this.Control[iCurrent+4]=this.pb_down
end on

on w_pism071i.destroy
call super::destroy
destroy(this.dw_buharate)
destroy(this.dw_all_down)
destroy(this.tab_work)
destroy(this.pb_down)
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

//** 사용자가 날짜를 키보드로 입력하고 다른키 조작없이 마우스로 조회아이콘을 클릭하는 경우
//** 바뀐날짜가 조회되지 않는것을 방지하기 위해 이벤트 실행
uo_fromdate.TriggerEvent("ue_loasefocus")
uo_todate.TriggerEvent("ue_loasefocus")

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
	
	dw_all_down.settransobject(sqleis)
	if wf_prdatawindowretrieve(dw_all_down) > 0 then
		uo_status.st_message.text = "조회 되었습니다."
	else
		uo_status.st_message.text = "조회할 정보가 없습니다."
	end if
		
	return 0
end if
end event

event open;call super::open;wf_setRetCondition(STFROMTODATE) 
f_pisc_connect_eis_server(sqleis)
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

end if
end event

event close;call super::close;f_pisc_disconnect_eis_server(sqleis)
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
		pb_down.Visible = False
	Case 2
		dw_all_down.Visible = True 
		dw_buharate.Visible = False 
		pb_down.Visible = True
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

type pb_down from picturebutton within w_pism071i
integer x = 2619
integer y = 28
integer width = 357
integer height = 124
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
end type

event clicked;integer l_n_value, li_chk
string l_s_docname, l_s_named

if dw_all_down.rowcount() < 1 then
	uo_status.st_message.text = "저장할 자료가 없습니다."
	return -1
end if

l_s_docname = dw_all_down.Tag
l_n_value = GetFileSaveName("저장 하기", l_s_docname, l_s_named, "xls", "Excel files (*.xls), *.xls")
if l_n_value = 1 then
	li_Chk = dw_all_down.saveas(l_s_docname, HTMLTABLE!, true) 
	If li_Chk = -1 Then 
		f_pism_messagebox(StopSign!, -1, "확 인", "파일저장 오류 입니다.") 
		Return 
	End If 
else
	Return 
end if

OleObject     myOleObject
int           i_Result
String        excel_title

myOleObject = Create OleObject //ole 오브젝트 생성

i_Result = myOleObject.ConnectToNewObject( "excel.application" )
// 엑셀에 연결
excel_title = myOleObject.Application.Caption

myOleObject.Application.Visible = True

myOleObject.WorkBooks.Open(l_s_docname)
myOleObject.WindowState = 3 
// 엑셀윈도우의 상태 지정 1-normal, 2-min, 3-max

myoleobject.DisConnectObject() //연결종료
Destroy myoleobject //오브젝트 제거

return 0
end event

