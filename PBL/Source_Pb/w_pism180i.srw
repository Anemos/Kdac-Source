$PBExportHeader$w_pism180i.srw
$PBExportComments$인당 O/T 시간 조회
forward
global type w_pism180i from w_pism_sheet02
end type
type dw_manottime from u_pism_dw within w_pism180i
end type
type tab_work from tab within w_pism180i
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tab_work from tab within w_pism180i
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type pb_down from picturebutton within w_pism180i
end type
type dw_all_down from u_pism_dw within w_pism180i
end type
end forward

global type w_pism180i from w_pism_sheet02
integer width = 3694
integer height = 2204
dw_manottime dw_manottime
tab_work tab_work
pb_down pb_down
dw_all_down dw_all_down
end type
global w_pism180i w_pism180i

forward prototypes
public function long wf_prdatawindowretrieve (datawindow aprdw)
end prototypes

public function long wf_prdatawindowretrieve (datawindow aprdw);Long ll_rowCnt 

aprdw.SetTransObject(sqleis)
ll_rowCnt = aprdw.Retrieve(istr_mh.from_date, istr_mh.to_date)
aprdw.setredraw(false)
if ll_rowCnt > 0 then
	integer li_rowcnt, li_cnt, li_currow
	datastore lds_01
	
	lds_01 = create datastore
	lds_01.dataobject = "d_pism180i_01_all_jin"
	lds_01.settransobject(sqleis)
	
	li_rowcnt = lds_01.retrieve('J','S',istr_mh.from_date, istr_mh.to_date )
	for li_cnt = 1 to li_rowcnt
		li_currow = aprdw.insertrow(0)
		aprdw.setitem(li_currow,"Areacode",'J')
		aprdw.setitem(li_currow,"Divisioncode",'S')
		aprdw.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		aprdw.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		aprdw.setitem(li_currow,"otTime1",lds_01.getitemnumber(li_cnt,"otTime1"))
		aprdw.setitem(li_currow,"otTime2",lds_01.getitemnumber(li_cnt,"otTime2"))
		aprdw.setitem(li_currow,"otManCnt",lds_01.getitemnumber(li_cnt,"otManCnt"))
		aprdw.setitem(li_currow,"excWCGbn",lds_01.getitemstring(li_cnt,"excWCGbn"))
		aprdw.setitem(li_currow,"etcmSuppMH",lds_01.getitemnumber(li_cnt,"etcmSuppMH"))
		aprdw.setitem(li_currow,"etcpSuppMH",lds_01.getitemnumber(li_cnt,"etcpSuppMH"))
	next
	
	lds_01.reset()
	li_rowcnt = lds_01.retrieve('J','H',istr_mh.from_date, istr_mh.to_date )
	for li_cnt = 1 to li_rowcnt
		li_currow = aprdw.insertrow(0)
		aprdw.setitem(li_currow,"Areacode",'J')
		aprdw.setitem(li_currow,"Divisioncode",'H')
		aprdw.setitem(li_currow,"WorkCenter",lds_01.getitemstring(li_cnt,"WorkCenter"))
		aprdw.setitem(li_currow,"WorkCenterName",lds_01.getitemstring(li_cnt,"WorkCenterName"))
		aprdw.setitem(li_currow,"otTime1",lds_01.getitemnumber(li_cnt,"otTime1"))
		aprdw.setitem(li_currow,"otTime2",lds_01.getitemnumber(li_cnt,"otTime2"))
		aprdw.setitem(li_currow,"otManCnt",lds_01.getitemnumber(li_cnt,"otManCnt"))
		aprdw.setitem(li_currow,"excWCGbn",lds_01.getitemstring(li_cnt,"excWCGbn"))
		aprdw.setitem(li_currow,"etcmSuppMH",lds_01.getitemnumber(li_cnt,"etcmSuppMH"))
		aprdw.setitem(li_currow,"etcpSuppMH",lds_01.getitemnumber(li_cnt,"etcpSuppMH"))
	next
	
	destroy lds_01
end if
aprdw.setredraw(true)
Return ll_rowCnt 

end function

event open;call super::open;wf_setRetCondition(STFROMTODATE) 
f_pisc_connect_eis_server(sqleis)

end event

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_manottime, FULL)
//
//of_resize()
//
tab_work.Width = newwidth - ( tab_work.x + 10 ) 
dw_manottime.Width = newwidth - ( dw_manottime.x + 10 ) 
dw_manottime.Height = newheight - ( dw_manottime.y + uo_status.Height + 10 ) 

dw_all_down.x= dw_manottime.x
dw_all_down.y= dw_manottime.y
dw_all_down.Width = dw_manottime.Width
dw_all_down.Height= dw_manottime.Height
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_manottime
lstr_prt.DataObject = 'd_pism180i_01_rev1_p' 
lstr_prt.title = uo_fromdate.is_uo_date + " - " + uo_todate.is_uo_date + "  " + dw_manottime.Title 

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" + &
						  "t_3.Text = '" + uo_fromdate.is_uo_date + " - " + uo_todate.is_uo_date + "  인당 O/T 현황"  + "'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

//** 사용자가 날짜를 키보드로 입력하고 다른키 조작없이 마우스로 조회아이콘을 클릭하는 경우
//** 바뀐날짜가 조회되지 않는것을 방지하기 위해 이벤트 실행
uo_fromdate.TriggerEvent("ue_loasefocus")
uo_todate.TriggerEvent("ue_loasefocus")

if tab_work.SelectedTab = 1 then
	f_pism_working_msg(uo_div.is_uo_divisionname + "공장", dw_manottime.Title + "를 조회중입니다. 잠시만 기다려 주십시오.") 
	
	dw_manottime.SetTransObject(SqlPIS)
	li_ret = dw_manottime.Retrieve(istr_mh.area, istr_mh.div, uo_fromdate.is_uo_date,uo_todate.is_uo_date) 
	
	If IsValid(w_pism_working) Then Close(w_pism_working) 
	If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", " 해당 기준일의 근태내역이 존재하지 않습니다.")
	
	dw_manottime.SetFocus() 
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

on w_pism180i.create
int iCurrent
call super::create
this.dw_manottime=create dw_manottime
this.tab_work=create tab_work
this.pb_down=create pb_down
this.dw_all_down=create dw_all_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_manottime
this.Control[iCurrent+2]=this.tab_work
this.Control[iCurrent+3]=this.pb_down
this.Control[iCurrent+4]=this.dw_all_down
end on

on w_pism180i.destroy
call super::destroy
destroy(this.dw_manottime)
destroy(this.tab_work)
destroy(this.pb_down)
destroy(this.dw_all_down)
end on

event ue_postopen;call super::ue_postopen;if g_s_autarea <> '' then
	tab_work.tabpage_2.enabled = false
else
	tab_work.tabpage_2.enabled = true
end if
end event

type uo_status from w_pism_sheet02`uo_status within w_pism180i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism180i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism180i
integer x = 2043
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism180i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism180i
integer x = 1280
integer width = 667
integer height = 92
end type

type uo_month from w_pism_sheet02`uo_month within w_pism180i
boolean visible = false
integer x = 1285
integer y = 44
end type

type uo_year from w_pism_sheet02`uo_year within w_pism180i
boolean visible = false
integer x = 1289
integer y = 44
end type

type uo_date from w_pism_sheet02`uo_date within w_pism180i
boolean visible = false
integer x = 1275
integer y = 48
end type

type uo_area from w_pism_sheet02`uo_area within w_pism180i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism180i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism180i
boolean visible = false
integer x = 1271
integer y = 44
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism180i
boolean visible = false
integer x = 1925
integer y = 44
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism180i
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism180i
boolean visible = false
integer x = 1280
integer y = 48
end type

type dw_manottime from u_pism_dw within w_pism180i
integer x = 9
integer y = 308
integer width = 1755
integer height = 1300
integer taborder = 21
boolean bringtotop = true
string title = "인당 O/T 시간"
string dataobject = "d_pism180i_01_rev1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

type tab_work from tab within w_pism180i
event type long ue_retrieve ( integer ai_selectedtab )
event create ( )
event destroy ( )
integer x = 18
integer y = 180
integer width = 1458
integer height = 112
integer taborder = 50
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
		dw_manottime.Visible = True 
		dw_all_down.Visible = False 
		pb_down.Visible = False
	Case 2
		dw_all_down.Visible = True 
		dw_manottime.Visible = False 
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

type pb_down from picturebutton within w_pism180i
integer x = 2619
integer y = 28
integer width = 357
integer height = 124
integer taborder = 60
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

type dw_all_down from u_pism_dw within w_pism180i
string tag = "인당 OT 전사"
integer x = 1797
integer y = 308
integer width = 1755
integer height = 1300
integer taborder = 31
boolean bringtotop = true
string title = "인당 OT 전사"
string dataobject = "d_pism180i_01_all"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

