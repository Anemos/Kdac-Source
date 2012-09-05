$PBExportHeader$w_pism060i.srw
$PBExportComments$조별 종합효율 및 LPI 조회
forward
global type w_pism060i from w_pism_sheet02
end type
type dw_allovereff from u_pism_dw within w_pism060i
end type
end forward

global type w_pism060i from w_pism_sheet02
long il_obj_split_h_y = 46688592
dw_allovereff dw_allovereff
end type
global w_pism060i w_pism060i

on w_pism060i.create
int iCurrent
call super::create
this.dw_allovereff=create dw_allovereff
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_allovereff
end on

on w_pism060i.destroy
call super::destroy
destroy(this.dw_allovereff)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_allovereff, FULL)
//
//of_resize()

dw_allovereff.Width = newwidth - ( dw_allovereff.x + 10 ) 
dw_allovereff.Height = newheight - ( dw_allovereff.y + uo_status.Height + 10 ) 
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(istr_mh.year + '년 ' + istr_mh.month + '월 ' + & 
						 uo_div.is_uo_divisionname + "공장", dw_allovereff.Tag + "를 조회중입니다. 잠시만 기다려 주십시오.") 

dw_allovereff.SetTransObject(SqlPIS)
li_ret = dw_allovereff.Retrieve(istr_mh.area, istr_mh.div, uo_month.is_uo_month)  

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + '년 ' + istr_mh.month + "월~n~n해당 기준년도의 생산실적이 존재하지 않습니다.")

dw_allovereff.Setfocus() 
end event

event open;call super::open;wf_setRetCondition(STMONTH) 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_allovereff
lstr_prt.DataObject = 'd_pism060i_01_p' 
lstr_prt.title = istr_mh.year + '년 ' + istr_mh.month + '월 ' + dw_allovereff.Tag

lstr_prt.dwsyntax = "title.text = '" + istr_mh.year + '년 ' + istr_mh.month + '월 ' + dw_allovereff.Tag + "'	" + &
						  "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

type uo_status from w_pism_sheet02`uo_status within w_pism060i
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism060i
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism060i
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism060i
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism060i
end type

type uo_month from w_pism_sheet02`uo_month within w_pism060i
end type

type uo_year from w_pism_sheet02`uo_year within w_pism060i
end type

type uo_date from w_pism_sheet02`uo_date within w_pism060i
end type

type uo_area from w_pism_sheet02`uo_area within w_pism060i
end type

type uo_div from w_pism_sheet02`uo_div within w_pism060i
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism060i
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism060i
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism060i
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism060i
end type

type dw_allovereff from u_pism_dw within w_pism060i
string tag = "조별 종합효율 및 LPI"
integer x = 5
integer y = 148
integer width = 2711
integer height = 1320
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism060i_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

