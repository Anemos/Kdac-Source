$PBExportHeader$w_pism240i.srw
$PBExportComments$WorkCenter 대당MH 조회
forward
global type w_pism240i from w_pism_sheet02
end type
type dw_pism240i_01 from u_pism_dw within w_pism240i
end type
type cb_maiindown from commandbutton within w_pism240i
end type
end forward

global type w_pism240i from w_pism_sheet02
integer width = 3986
integer height = 3036
dw_pism240i_01 dw_pism240i_01
cb_maiindown cb_maiindown
end type
global w_pism240i w_pism240i

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

event open;call super::open;//wf_setRetCondition(STFROMTODATE) STDATE
wf_setRetCondition(STDATE)
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

//il_resize_count ++
//
//of_resize_register(dw_manottime, FULL)
//
//of_resize()
//

dw_pism240i_01.Width = newwidth 	- ( ls_gap * 4 )
dw_pism240i_01.Height= newheight - (dw_pism240i_01.y + ls_split + ls_status)

end event

event ue_print;call super::ue_print;//str_pism_prt lstr_prt		//출력조건
//
//lstr_prt.Transaction = SqlPIS 
//
//lstr_prt.datawindow = dw_manottime
//lstr_prt.DataObject = 'd_pism180i_01_rev1_p' 
//lstr_prt.title = uo_fromdate.is_uo_date + " - " + uo_todate.is_uo_date + "  " + dw_manottime.Title 
//
//lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" + &
//						  "t_3.Text = '" + uo_fromdate.is_uo_date + " - " + uo_todate.is_uo_date + "  인당 O/T 현황"  + "'" 
//
//OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

//** 사용자가 날짜를 키보드로 입력하고 다른키 조작없이 마우스로 조회아이콘을 클릭하는 경우
//** 바뀐날짜가 조회되지 않는것을 방지하기 위해 이벤트 실행
uo_date.TriggerEvent("ue_losefocus")


f_pism_working_msg(uo_div.is_uo_divisionname + "공장", dw_pism240i_01.Title + "를 조회중입니다. 잠시만 기다려 주십시오.") 
 
dw_pism240i_01.SetTransObject(SqlPIS)
li_ret = dw_pism240i_01.Retrieve(istr_mh.area, istr_mh.div, uo_date.is_uo_date ) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", " 해당 기준일의 MH정보가 존재하지 않습니다.")

dw_pism240i_01.SetFocus() 
end event

on w_pism240i.create
int iCurrent
call super::create
this.dw_pism240i_01=create dw_pism240i_01
this.cb_maiindown=create cb_maiindown
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pism240i_01
this.Control[iCurrent+2]=this.cb_maiindown
end on

on w_pism240i.destroy
call super::destroy
destroy(this.dw_pism240i_01)
destroy(this.cb_maiindown)
end on

type uo_status from w_pism_sheet02`uo_status within w_pism240i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism240i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism240i
integer x = 2043
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism240i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism240i
integer x = 1280
integer width = 667
integer height = 92
end type

type uo_month from w_pism_sheet02`uo_month within w_pism240i
boolean visible = false
integer x = 1285
integer y = 44
end type

type uo_year from w_pism_sheet02`uo_year within w_pism240i
boolean visible = false
integer x = 1289
integer y = 44
end type

type uo_date from w_pism_sheet02`uo_date within w_pism240i
boolean visible = false
integer x = 1275
integer y = 48
end type

type uo_area from w_pism_sheet02`uo_area within w_pism240i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism240i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism240i
boolean visible = false
integer x = 1271
integer y = 44
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism240i
boolean visible = false
integer x = 1925
integer y = 44
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism240i
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism240i
boolean visible = false
integer x = 1280
integer y = 48
end type

type dw_pism240i_01 from u_pism_dw within w_pism240i
integer x = 18
integer y = 164
integer width = 3328
integer height = 1604
integer taborder = 21
boolean bringtotop = true
string title = "WorkCenter별 대당MH"
string dataobject = "d_pism240i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_modelno
integer li_rowcnt

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

return 0
end event

type cb_maiindown from commandbutton within w_pism240i
integer x = 2098
integer y = 24
integer width = 654
integer height = 120
integer taborder = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "MH다운로드"
end type

event clicked;f_save_to_excel_number(dw_pism240i_01)
end event

