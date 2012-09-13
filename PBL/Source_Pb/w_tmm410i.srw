$PBExportHeader$w_tmm410i.srw
$PBExportComments$시험/측정출력물관리
forward
global type w_tmm410i from w_origin_sheet07
end type
type dw_report from datawindow within w_tmm410i
end type
type uo_tmgubun from u_tmm_select_tmgubun within w_tmm410i
end type
end forward

global type w_tmm410i from w_origin_sheet07
dw_report dw_report
uo_tmgubun uo_tmgubun
end type
global w_tmm410i w_tmm410i

on w_tmm410i.create
int iCurrent
call super::create
this.dw_report=create dw_report
this.uo_tmgubun=create uo_tmgubun
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_report
this.Control[iCurrent+2]=this.uo_tmgubun
end on

on w_tmm410i.destroy
call super::destroy
destroy(this.dw_report)
destroy(this.uo_tmgubun)
end on

event open;call super::open;dw_1.settransobject(sqlca)

dw_1.insertrow(0)
dw_1.object.divcode.visible = false
dw_1.object.divcode_t.visible = false
dw_1.object.t_1.visible = false
dw_1.object.todate.visible = false
uo_tmgubun.visible = false
end event

type r_1 from w_origin_sheet07`r_1 within w_tmm410i
end type

type uo_status from w_origin_sheet07`uo_status within w_tmm410i
end type

type lb_1 from w_origin_sheet07`lb_1 within w_tmm410i
string item[] = {"1. 당월전체[시험/측정]현황","2, 누적전체[시험/측정]현황","3. 당월담당별현황","4. 당월기술연구소프로젝트별현황","5. 당월협력업체수수료현황","6. 기간별누적[시험/측정]현황","7. 담당자별 실적집계표"}
end type

event lb_1::selectionchanged;call super::selectionchanged;choose case index
	case 3
		dw_1.object.divcode.visible = true
		dw_1.object.divcode_t.visible = true
		dw_1.object.t_1.visible = false
		dw_1.object.todate.visible = false
		uo_tmgubun.visible = false
	case 6
		dw_1.object.t_1.visible = true
		dw_1.object.todate.visible = true
		uo_tmgubun.visible = false
	case 7
		dw_1.object.divcode.visible = false
		dw_1.object.divcode_t.visible = false
		dw_1.object.t_1.visible = true
		dw_1.object.todate.visible = true
		uo_tmgubun.visible = true
	case else
		dw_1.object.divcode.visible = false
		dw_1.object.divcode_t.visible = false
		dw_1.object.t_1.visible = false
		dw_1.object.todate.visible = false
		uo_tmgubun.visible = false
end choose
end event

type cb_cancel from w_origin_sheet07`cb_cancel within w_tmm410i
boolean enabled = false
end type

type cb_ok from w_origin_sheet07`cb_ok within w_tmm410i
end type

event cb_ok::clicked;call super::clicked;string ls_startdate, ls_enddate, ls_divcode, ls_yyyymm, mod_string, ls_tmgubun
window 	l_to_open
str_easy l_str_prt

//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."

dw_1.accepttext()
ls_yyyymm = dw_1.getitemstring(1,"refdate")
if f_dateedit(ls_yyyymm + '01') = space(8) then
	uo_status.st_message.text = "날짜가 올바르지 않습니다."
	return 0
end if

choose case lb_1.selectedindex()
	case 1
		dw_report.dataobject = "d_tmm410i_02_tablet"
		dw_report.settransobject(sqlca)
		ls_startdate = ls_yyyymm + '01'
		ls_enddate = f_relativedate(f_relative_month(ls_startdate,1),-1)
		mod_string =  "t_base.text = '당월( " + string(ls_yyyymm,"@@@@.@@") + " )'"
		dw_report.retrieve(ls_startdate, ls_enddate)
	case 2
		dw_report.dataobject = "d_tmm410i_02_tablet"
		dw_report.settransobject(sqlca)
		ls_startdate = mid(ls_yyyymm,1,4) + '0101'
		ls_enddate = f_relativedate(f_relative_month(ls_yyyymm + '01',1),-1)
		mod_string =  "t_base.text = '누적( " + string(ls_startdate,"@@@@.@@.@@") + " - " + string(ls_enddate,"@@@@.@@.@@") + " )'"
		dw_report.retrieve(ls_startdate, ls_enddate)
	case 3
		dw_report.dataobject = "d_tmm410i_04_tablet"
		dw_report.settransobject(sqlca)
		ls_startdate = ls_yyyymm + '01'
		ls_enddate = f_relativedate(f_relative_month(ls_yyyymm + '01',1),-1)
		ls_divcode = dw_1.getitemstring(1,"divcode")
		mod_string =  "t_base.text = '당월( " + string(ls_yyyymm,"@@@@.@@") + " )'"
		if ls_divcode = '1' then
			ls_divcode = '%'
		end if
		dw_report.retrieve(ls_startdate, ls_enddate, ls_divcode)
	case 4
		dw_report.dataobject = "d_tmm410i_05_tablet"
		dw_report.settransobject(sqlca)
		ls_startdate = ls_yyyymm + '01'
		ls_enddate = f_relativedate(f_relative_month(ls_yyyymm + '01',1),-1)
		mod_string =  "t_base.text = '당월( " + string(ls_yyyymm,"@@@@.@@") + " )'"
		dw_report.retrieve(ls_startdate, ls_enddate)
	case 5
		dw_report.dataobject = "d_tmm410i_06_tablet"
		dw_report.settransobject(sqlca)
		ls_startdate = ls_yyyymm + '01'
		ls_enddate = f_relativedate(f_relative_month(ls_yyyymm + '01',1),-1)
		mod_string =  "t_base.text = '당월( " + string(ls_yyyymm,"@@@@.@@") + " )'"
		dw_report.retrieve(ls_startdate, ls_enddate)
	case 6
		dw_report.dataobject = "d_tmm410i_02_tablet"
		dw_report.settransobject(sqlca)
		ls_startdate = ls_yyyymm + '01'
		ls_enddate = dw_1.getitemstring(1,"todate")
		ls_enddate = f_relativedate(f_relative_month(ls_enddate + '01',1),-1)
		if f_dateedit(ls_enddate) = space(8) or ls_enddate < ls_startdate then
			uo_status.st_message.text = "날짜가 올바르지 않습니다."
			return 0
		end if
		mod_string =  "t_base.text = '기간별누적( " + string(ls_startdate,"@@@@.@@.@@") + " - " + string(ls_enddate,"@@@@.@@.@@") + " )'"
		dw_report.retrieve(ls_startdate, ls_enddate)
	case 7
		dw_report.dataobject = "d_tmm410i_07_tablet"
		dw_report.settransobject(sqlca)
		ls_tmgubun = uo_tmgubun.is_uo_cocode
		ls_startdate = ls_yyyymm + '01'
		ls_enddate = dw_1.getitemstring(1,"todate")
		ls_enddate = f_relativedate(f_relative_month(ls_enddate + '01',1),-1)
		if f_dateedit(ls_enddate) = space(8) or ls_enddate < ls_startdate then
			uo_status.st_message.text = "날짜가 올바르지 않습니다."
			return 0
		end if
		mod_string =  "t_base.text = '조회기간( " + string(ls_startdate,"@@@@.@@.@@") + " - " + string(ls_enddate,"@@@@.@@.@@") + " )'"
		dw_report.retrieve(ls_tmgubun, ls_startdate, ls_enddate)
	case else	
		uo_status.st_message.text = "출력할 목록을 선택하십시요."
		return 0
end choose

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax     = mod_string
l_str_prt.tag			  = This.ClassName()
	
f_close_report("2", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

uo_status.st_message.Text = ""
return 0


end event

type dw_1 from w_origin_sheet07`dw_1 within w_tmm410i
boolean visible = true
integer x = 965
integer y = 1340
integer width = 2272
integer height = 924
string dataobject = "d_tmm410i_01"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

type gb_01 from w_origin_sheet07`gb_01 within w_tmm410i
end type

type gb_00 from w_origin_sheet07`gb_00 within w_tmm410i
end type

type ln_1 from w_origin_sheet07`ln_1 within w_tmm410i
end type

type ln_2 from w_origin_sheet07`ln_2 within w_tmm410i
end type

type ln_4 from w_origin_sheet07`ln_4 within w_tmm410i
end type

type ln_3 from w_origin_sheet07`ln_3 within w_tmm410i
end type

type st_0 from w_origin_sheet07`st_0 within w_tmm410i
end type

type dw_report from datawindow within w_tmm410i
boolean visible = false
integer x = 3406
integer y = 600
integer width = 686
integer height = 400
integer taborder = 40
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_tmgubun from u_tmm_select_tmgubun within w_tmm410i
integer x = 1006
integer y = 1516
integer taborder = 50
boolean bringtotop = true
end type

on uo_tmgubun.destroy
call u_tmm_select_tmgubun::destroy
end on

