$PBExportHeader$w_pism180i_old.srw
$PBExportComments$인당 O/T 시간 조회
forward
global type w_pism180i_old from w_pism_sheet02
end type
type dw_manottime from u_pism_dw within w_pism180i_old
end type
end forward

global type w_pism180i_old from w_pism_sheet02
dw_manottime dw_manottime
end type
global w_pism180i_old w_pism180i_old

event open;call super::open;wf_setRetCondition(STMONTH)

end event

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_manottime, FULL)

of_resize()

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_manottime
lstr_prt.DataObject = 'd_pism180i_01_p' 
lstr_prt.title = istr_mh.year + '년 ' + istr_mh.month + '월 ' + dw_manottime.Title 

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + "'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(istr_mh.year + '년 ' + istr_mh.month + '월 ' + & 
						 uo_div.is_uo_divisionname + "공장 ", dw_manottime.Title + "(을)를 조회중입니다. 잠시만 기다려 주십시오.") 

dw_manottime.SetTransObject(SqlPIS)
li_ret = dw_manottime.Retrieve(istr_mh.area, istr_mh.div, uo_month.is_uo_month)  

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + '년 ' + istr_mh.month + "월~n~n해당 기준월의 근태내역이 존재하지 않습니다.")

dw_manottime.SetFocus() 
end event

on w_pism180i_old.create
int iCurrent
call super::create
this.dw_manottime=create dw_manottime
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_manottime
end on

on w_pism180i_old.destroy
call super::destroy
destroy(this.dw_manottime)
end on

type uo_status from w_pism_sheet02`uo_status within w_pism180i_old
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism180i_old
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism180i_old
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism180i_old
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism180i_old
end type

type uo_month from w_pism_sheet02`uo_month within w_pism180i_old
end type

type uo_year from w_pism_sheet02`uo_year within w_pism180i_old
end type

type uo_date from w_pism_sheet02`uo_date within w_pism180i_old
end type

type uo_area from w_pism_sheet02`uo_area within w_pism180i_old
end type

type uo_div from w_pism_sheet02`uo_div within w_pism180i_old
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism180i_old
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism180i_old
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism180i_old
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism180i_old
end type

type dw_manottime from u_pism_dw within w_pism180i_old
integer x = 9
integer y = 148
integer width = 3163
integer height = 1328
integer taborder = 21
boolean bringtotop = true
string title = "인당 O/T 시간"
string dataobject = "d_pism180i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
integer ii_selection = 1
end type

