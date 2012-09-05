$PBExportHeader$w_pism100i.srw
$PBExportComments$월별 LPI 현황 - 그래프
forward
global type w_pism100i from w_pism_sheet03
end type
type dw_lpi from u_pism_dw within w_pism100i
end type
end forward

global type w_pism100i from w_pism_sheet03
dw_lpi dw_lpi
end type
global w_pism100i w_pism100i

on w_pism100i.create
int iCurrent
call super::create
this.dw_lpi=create dw_lpi
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lpi
end on

on w_pism100i.destroy
call super::destroy
destroy(this.dw_lpi)
end on

event open;call super::open;wf_setRetCondition(STYEAR)

ib_wcallview = True 
end event

event ue_postopen;call super::ue_postopen;//dw_lpi2.InsertRow(0)
end event

event resize;call super::resize;dw_lpi.Width = newwidth - ( dw_lpi.x + 10 ) 
dw_lpi.Height = newheight - ( dw_lpi.y + uo_status.Height + 10 ) 

end event

event ue_retrieve;call super::ue_retrieve;Integer li_ret 

f_pism_working_msg(istr_mh.year + '년 ' + & 
						 uo_div.is_uo_divisionname + "공장 " + uo_wc.is_uo_workcentername + " 조", '월별 ' + dw_lpi.Title + "를 조회중입니다. 잠시만 기다려 주십시오.") 

dw_lpi.SetTransObject(SqlPIS) 
li_ret = dw_lpi.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.year) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
If li_ret = 0 Then f_pism_messagebox(Information!, -1, "조회실패", istr_mh.year + '년~n' + uo_wc.is_uo_workcentername + " 조의 생산실적이 존재하지 않습니다.")

dw_lpi.SetFocus() 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_lpi 
lstr_prt.DataObject = 'd_pism100i_02_p' 
lstr_prt.title = istr_mh.year + '년 ' + uo_div.is_uo_divisionname + "공장 " + dw_lpi.Title 

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

type uo_status from w_pism_sheet03`uo_status within w_pism100i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism100i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism100i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism100i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism100i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism100i
end type

type uo_month from w_pism_sheet03`uo_month within w_pism100i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism100i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism100i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism100i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism100i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism100i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism100i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism100i
end type

type dw_lpi from u_pism_dw within w_pism100i
integer x = 9
integer y = 160
integer width = 2775
integer height = 1548
integer taborder = 11
boolean bringtotop = true
string title = "월별 LPI"
string dataobject = "d_pism100i_02"
integer ii_selection = 0
end type

