$PBExportHeader$w_pism250i.srw
$PBExportComments$[사업계획]완제품 대당MH 조회
forward
global type w_pism250i from w_pism_sheet02
end type
type dw_pism250i_01 from u_pism_dw within w_pism250i
end type
type dw_pism250i_02 from u_pism_dw within w_pism250i
end type
type cb_maiindown from commandbutton within w_pism250i
end type
type cb_detaildown from commandbutton within w_pism250i
end type
type st_4 from statictext within w_pism250i
end type
type uo_2 from uo_ccyy_mps within w_pism250i
end type
type uo_3 from u_bpm_select_arev within w_pism250i
end type
type gb_3 from groupbox within w_pism250i
end type
end forward

global type w_pism250i from w_pism_sheet02
integer width = 4023
integer height = 3140
dw_pism250i_01 dw_pism250i_01
dw_pism250i_02 dw_pism250i_02
cb_maiindown cb_maiindown
cb_detaildown cb_detaildown
st_4 st_4
uo_2 uo_2
uo_3 uo_3
gb_3 gb_3
end type
global w_pism250i w_pism250i

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
wf_setRetCondition(9)
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

dw_pism250i_01.Width = newwidth 	- ( ls_gap * 4 )
dw_pism250i_01.Height= ( newheight * 2 / 5 ) - dw_pism250i_01.y

dw_pism250i_02.x = dw_pism250i_01.x
dw_pism250i_02.y = dw_pism250i_01.y + dw_pism250i_01.Height + ls_split
dw_pism250i_02.Width = dw_pism250i_01.Width
dw_pism250i_02.Height = newheight - ( dw_pism250i_01.y + dw_pism250i_01.Height + ls_split + ls_status)

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

event ue_retrieve;call super::ue_retrieve;string ls_year, ls_revno
Integer li_ret 

//** 사용자가 날짜를 키보드로 입력하고 다른키 조작없이 마우스로 조회아이콘을 클릭하는 경우
//** 바뀐날짜가 조회되지 않는것을 방지하기 위해 이벤트 실행
uo_date.TriggerEvent("ue_loasefocus")
ls_year  = uo_2.uf_return()
ls_revno = uo_3.is_uo_revno

f_pism_working_msg(uo_div.is_uo_divisionname + "공장", dw_pism250i_01.Title + "를 조회중입니다. 잠시만 기다려 주십시오.") 
 
dw_pism250i_01.SetTransObject(SqlPIS)
li_ret = dw_pism250i_01.Retrieve(istr_mh.area, istr_mh.div, ls_year, ls_revno ) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", " 해당 기준일의 MH정보가 존재하지 않습니다.")

dw_pism250i_01.SetFocus() 
end event

on w_pism250i.create
int iCurrent
call super::create
this.dw_pism250i_01=create dw_pism250i_01
this.dw_pism250i_02=create dw_pism250i_02
this.cb_maiindown=create cb_maiindown
this.cb_detaildown=create cb_detaildown
this.st_4=create st_4
this.uo_2=create uo_2
this.uo_3=create uo_3
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_pism250i_01
this.Control[iCurrent+2]=this.dw_pism250i_02
this.Control[iCurrent+3]=this.cb_maiindown
this.Control[iCurrent+4]=this.cb_detaildown
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.uo_2
this.Control[iCurrent+7]=this.uo_3
this.Control[iCurrent+8]=this.gb_3
end on

on w_pism250i.destroy
call super::destroy
destroy(this.dw_pism250i_01)
destroy(this.dw_pism250i_02)
destroy(this.cb_maiindown)
destroy(this.cb_detaildown)
destroy(this.st_4)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;string ls_refyear, ls_message, ls_revno, ls_chkrevno

ls_message = right(message.stringparm,6)
ls_revno = mid(ls_message,1,2)
ls_refyear = mid(ls_message,3,4)

SELECT REVNO INTO :ls_chkrevno
FROM PBBPM.BPM519
WHERE COMLTD = '01' AND XYEAR = :ls_refyear AND REVNO = :ls_revno
ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
FETCH FIRST 1 ROW ONLY
using sqlca;

if f_spacechk(ls_chkrevno) = -1 then
	SELECT XYEAR, REVNO INTO :ls_refyear,:ls_revno
	FROM PBBPM.BPM519
	WHERE COMLTD = '01'
	ORDER BY XYEAR DESC, REVNO DESC, SEQNO ASC
	FETCH FIRST 1 ROW ONLY
	using sqlca;
	
	uo_2.uf_reset(integer(mid(f_relativedate(mid(g_s_date,1,4) + '1231',1),1,4)))
	ls_revno = '%'
else
	uo_2.uf_reset(integer(ls_refyear))
end if

f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										ls_revno, &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

type uo_status from w_pism_sheet02`uo_status within w_pism250i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism250i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism250i
integer x = 2043
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism250i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism250i
integer x = 1280
integer width = 667
integer height = 92
end type

type uo_month from w_pism_sheet02`uo_month within w_pism250i
boolean visible = false
integer x = 1285
integer y = 44
end type

type uo_year from w_pism_sheet02`uo_year within w_pism250i
boolean visible = false
integer x = 1289
integer y = 44
end type

type uo_date from w_pism_sheet02`uo_date within w_pism250i
boolean visible = false
integer x = 1275
integer y = 48
end type

type uo_area from w_pism_sheet02`uo_area within w_pism250i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism250i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism250i
boolean visible = false
integer x = 1271
integer y = 44
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism250i
boolean visible = false
integer x = 1925
integer y = 44
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism250i
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism250i
boolean visible = false
integer x = 1280
integer y = 48
end type

type dw_pism250i_01 from u_pism_dw within w_pism250i
integer x = 18
integer y = 400
integer width = 3328
integer height = 564
integer taborder = 21
boolean bringtotop = true
string title = "완제품별 대당MH"
string dataobject = "d_pism250i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

event rowfocuschanged;call super::rowfocuschanged;String ls_modelno, ls_year, ls_revno
integer li_rowcnt

if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )

ls_year  = uo_2.uf_return()
ls_revno = uo_3.is_uo_revno
ls_modelno = This.getitemstring( currentrow, "zmdno" )

dw_pism250i_02.SetTransObject(sqlpis)
li_rowcnt = dw_pism250i_02.retrieve(istr_mh.area, istr_mh.div, ls_year, ls_revno , ls_modelno)

return 0
end event

type dw_pism250i_02 from u_pism_dw within w_pism250i
integer x = 27
integer y = 1008
integer width = 3305
integer height = 768
integer taborder = 31
boolean bringtotop = true
string title = "대당 MH 세부내역"
string dataobject = "d_pism250i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

type cb_maiindown from commandbutton within w_pism250i
integer x = 1728
integer y = 160
integer width = 654
integer height = 120
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "제품MH다운로드"
end type

event clicked;f_save_to_excel_number(dw_pism250i_01)
end event

type cb_detaildown from commandbutton within w_pism250i
integer x = 2414
integer y = 156
integer width = 654
integer height = 120
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "세부내역다운로드"
end type

event clicked;f_save_to_excel_number(dw_pism250i_02)
end event

type st_4 from statictext within w_pism250i
integer x = 55
integer y = 188
integer width = 297
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년도"
boolean focusrectangle = false
end type

type uo_2 from uo_ccyy_mps within w_pism250i
event destroy ( )
integer x = 347
integer y = 176
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
end type

on uo_2.destroy
call uo_ccyy_mps::destroy
end on

event ue_modify;call super::ue_modify;f_bpm_retrieve_dddw_arev(uo_3.dw_1, &
										uo_2.uf_return(), &
										'%', &
										False, &
										uo_3.is_uo_revno, &
										uo_3.is_uo_refyear )
										
uo_3.Triggerevent('ue_select')
end event

type uo_3 from u_bpm_select_arev within w_pism250i
event destroy ( )
integer x = 731
integer y = 180
integer height = 88
integer taborder = 70
boolean bringtotop = true
end type

on uo_3.destroy
call u_bpm_select_arev::destroy
end on

type gb_3 from groupbox within w_pism250i
integer x = 14
integer y = 148
integer width = 1669
integer height = 136
integer taborder = 80
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

