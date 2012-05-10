$PBExportHeader$w_mpm331i.srw
$PBExportComments$W/C별 부하현황표
forward
global type w_mpm331i from w_ipis_sheet01
end type
type dw_mpm331i_graph from u_vi_std_datawindow within w_mpm331i
end type
type uo_from from u_mpms_date_applydate within w_mpm331i
end type
type uo_to from u_mpms_date_applydate_1 within w_mpm331i
end type
type st_1 from statictext within w_mpm331i
end type
type dw_report from datawindow within w_mpm331i
end type
type st_2 from statictext within w_mpm331i
end type
type st_3 from statictext within w_mpm331i
end type
type sle_daytime from singlelineedit within w_mpm331i
end type
type sle_daynumber from singlelineedit within w_mpm331i
end type
type dw_mpm331i_01 from datawindow within w_mpm331i
end type
type gb_1 from groupbox within w_mpm331i
end type
end forward

global type w_mpm331i from w_ipis_sheet01
dw_mpm331i_graph dw_mpm331i_graph
uo_from uo_from
uo_to uo_to
st_1 st_1
dw_report dw_report
st_2 st_2
st_3 st_3
sle_daytime sle_daytime
sle_daynumber sle_daynumber
dw_mpm331i_01 dw_mpm331i_01
gb_1 gb_1
end type
global w_mpm331i w_mpm331i

on w_mpm331i.create
int iCurrent
call super::create
this.dw_mpm331i_graph=create dw_mpm331i_graph
this.uo_from=create uo_from
this.uo_to=create uo_to
this.st_1=create st_1
this.dw_report=create dw_report
this.st_2=create st_2
this.st_3=create st_3
this.sle_daytime=create sle_daytime
this.sle_daynumber=create sle_daynumber
this.dw_mpm331i_01=create dw_mpm331i_01
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mpm331i_graph
this.Control[iCurrent+2]=this.uo_from
this.Control[iCurrent+3]=this.uo_to
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_report
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.sle_daytime
this.Control[iCurrent+9]=this.sle_daynumber
this.Control[iCurrent+10]=this.dw_mpm331i_01
this.Control[iCurrent+11]=this.gb_1
end on

on w_mpm331i.destroy
call super::destroy
destroy(this.dw_mpm331i_graph)
destroy(this.uo_from)
destroy(this.uo_to)
destroy(this.st_1)
destroy(this.dw_report)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_daytime)
destroy(this.sle_daynumber)
destroy(this.dw_mpm331i_01)
destroy(this.gb_1)
end on

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
i_b_retrieve 	= True
i_b_insert 	 	= False
i_b_save 		= False
i_b_delete 		= False
i_b_print 		= True
i_b_dretrieve 	= False
i_b_dprint 		= False
i_b_dchar 		= False
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
				  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
end event

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_mpm331i_graph.Width = newwidth 	- ( ls_gap * 3 )
dw_mpm331i_graph.Height= ( newheight * 4 / 6 ) - ls_split

dw_mpm331i_01.x = dw_mpm331i_graph.x
dw_mpm331i_01.y = dw_mpm331i_graph.y + dw_mpm331i_graph.Height + ls_split
dw_mpm331i_01.Width = dw_mpm331i_graph.Width
dw_mpm331i_01.Height = newheight - (dw_mpm331i_graph.y + dw_mpm331i_graph.Height + ls_split + ls_status)
end event

event ue_postopen;call super::ue_postopen;long ll_daynumber, ll_daytime
string ls_fromdate, ls_todate

dw_mpm331i_graph.settransobject(sqlmpms)
dw_mpm331i_01.settransobject(sqlmpms)
dw_report.settransobject(sqlmpms)

ls_fromdate = uo_from.is_uo_date
ls_todate = uo_to.is_uo_date

SELECT COUNT(*) INTO :ll_daynumber
FROM TMPMCALENDAR
WHERE ApplyDate >= :ls_fromdate AND ApplyDate <= :ls_todate AND
	WorkGubun = 'W'
using sqlmpms;

sle_daynumber.text = string(ll_daynumber)
sle_daytime.text = '10'
end event

event ue_retrieve;call super::ue_retrieve;string ls_fromdate, ls_todate
int li_rowcnt, li_daynumber, li_daytime

dw_mpm331i_graph.reset()
dw_mpm331i_01.reset()

ls_fromdate = uo_from.is_uo_date
ls_todate = uo_to.is_uo_date
li_daynumber = Integer(sle_daynumber.text)
li_daytime = Integer(sle_daytime.text)

li_rowcnt = dw_mpm331i_graph.retrieve( ls_fromdate, ls_todate, li_daynumber, li_daytime)

if li_rowcnt < 1 then
	uo_status.st_message.text = "조회할 자료가 없습니다."
else
	dw_mpm331i_01.retrieve( ls_fromdate, ls_todate, li_daynumber, li_daytime)
	uo_status.st_message.text = "조회되었습니다."
end if
end event

event ue_print;call super::ue_print;integer li_rowcnt, li_daynumber, li_daytime
string  mod_string,ls_rownum,ls_fromdate, ls_todate, l_s_command, l_s_tmp
string  ls_kijun

window 	l_to_open
str_easy l_str_prt

								
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

li_rowcnt = dw_mpm331i_01.rowcount()

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

ls_fromdate = uo_from.is_uo_date
ls_todate = uo_to.is_uo_date
li_daynumber = Integer(trim(sle_daynumber.text))
li_daytime = Integer(trim(sle_daytime.text))

dw_report.reset()
dw_report.retrieve( ls_fromdate, ls_todate, li_daynumber, li_daytime)

////////////////////
//출력 Data -> 출력
////////////////////

//출력전 초기배율
dw_report.setredraw(true)
dw_report.Object.Datawindow.Zoom = "100"

// 용지
l_s_command = " datawindow.Print.Paper.Size = " + "9"

// orientation (1.Landscape(가로)  2.Portrait (세로)
l_s_command = l_s_command + " datawindow.Print.Orientation = " + "1"

// now alter the datawindow
l_s_tmp = dw_report.modify(l_s_command)

if len(l_s_tmp) > 0 then // if error the display the 
	messagebox("확 인", "Error message = " + l_s_tmp + "~r~nCommand = " + l_s_command)
	dw_report.Setredraw(false)
	return 0
end if
dw_report.print()
dw_report.Setredraw(false)

uo_status.st_message.Text = "출력 되었습니다."
return 0
end event

type uo_status from w_ipis_sheet01`uo_status within w_mpm331i
end type

type dw_mpm331i_graph from u_vi_std_datawindow within w_mpm331i
integer x = 27
integer y = 204
integer width = 3223
integer height = 1192
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_mpm331i_graph"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_from from u_mpms_date_applydate within w_mpm331i
integer x = 91
integer y = 68
integer taborder = 20
boolean bringtotop = true
end type

on uo_from.destroy
call u_mpms_date_applydate::destroy
end on

event ue_select;call super::ue_select;long ll_daynumber, ll_daytime
string ls_fromdate, ls_todate

ls_fromdate = uo_from.is_uo_date
ls_todate = uo_to.is_uo_date

SELECT COUNT(*) INTO :ll_daynumber
FROM TMPMCALENDAR
WHERE ApplyDate >= :ls_fromdate AND ApplyDate <= :ls_todate AND
	WorkGubun = 'W'
using sqlmpms;

sle_daynumber.text = string(ll_daynumber)
end event

type uo_to from u_mpms_date_applydate_1 within w_mpm331i
integer x = 827
integer y = 72
integer taborder = 30
boolean bringtotop = true
end type

on uo_to.destroy
call u_mpms_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;long ll_daynumber, ll_daytime
string ls_fromdate, ls_todate

ls_fromdate = uo_from.is_uo_date
ls_todate = uo_to.is_uo_date

SELECT COUNT(*) INTO :ll_daynumber
FROM TMPMCALENDAR
WHERE ApplyDate >= :ls_fromdate AND ApplyDate <= :ls_todate AND
	WorkGubun = 'W'
using sqlmpms;

sle_daynumber.text = string(ll_daynumber)
end event

type st_1 from statictext within w_mpm331i
integer x = 763
integer y = 80
integer width = 64
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_report from datawindow within w_mpm331i
boolean visible = false
integer x = 2853
integer y = 524
integer width = 686
integer height = 492
boolean bringtotop = true
string dataobject = "d_mpm331p_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_mpm331i
integer x = 1422
integer y = 76
integer width = 311
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "작업일수:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_mpm331i
integer x = 2245
integer y = 76
integer width = 494
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "1일가용시간:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_daytime from singlelineedit within w_mpm331i
integer x = 2702
integer y = 68
integer width = 357
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type sle_daynumber from singlelineedit within w_mpm331i
integer x = 1742
integer y = 68
integer width = 421
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type dw_mpm331i_01 from datawindow within w_mpm331i
integer x = 32
integer y = 1412
integer width = 3218
integer height = 400
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_mpm331i_01"
boolean hscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpm331i
integer x = 32
integer width = 3205
integer height = 188
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

