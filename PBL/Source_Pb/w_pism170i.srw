$PBExportHeader$w_pism170i.srw
$PBExportComments$작업일보 특기사항 조회
forward
global type w_pism170i from w_pism_sheet03
end type
type dw_remark from u_pism_dw within w_pism170i
end type
end forward

global type w_pism170i from w_pism_sheet03
integer width = 4471
dw_remark dw_remark
end type
global w_pism170i w_pism170i

event open;call super::open;wf_setRetCondition(STFROMTODATE)  

ib_wcallview = True 
end event

on w_pism170i.create
int iCurrent
call super::create
this.dw_remark=create dw_remark
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_remark
end on

on w_pism170i.destroy
call super::destroy
destroy(this.dw_remark)
end on

event ue_retrieve;call super::ue_retrieve;Long ll_ret 

f_pism_working_msg(istr_mh.From_Date + "'~'" + istr_mh.To_Date + " 기간내" + & 
						 uo_wc.is_uo_workcentername + " 조", dw_remark.Tag + "을 조회중입니다. 잠시만 기다려 주십시오.") 

dw_remark.SetTransObject(SqlPIS)
ll_ret = dw_remark.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.from_date, istr_mh.to_date) 

If IsValid(w_pism_working) Then Close(w_pism_working) 

If ll_ret = 0 Then f_pism_messagebox(Information!, -1, "결과값 없음", istr_mh.From_Date + "∼" + istr_mh.To_Date + &
																		 "~n~n해당 기간내 " +  uo_wc.is_uo_workcentername + " 조의 특기사항이 존재하지 않습니다.")
																		 
dw_remark.Setfocus() 
end event

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_allovereff, FULL)
//
//of_resize()

dw_remark.Width = newwidth - ( dw_remark.x + 10 )
dw_remark.Height = newheight - ( dw_remark.y + uo_status.Height + 10 ) 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.datawindow = dw_remark
lstr_prt.DataObject = 'd_pism170i_01_p' 
lstr_prt.title = istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내 " + dw_remark.Tag 

lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'	" + & 
						  "t_frdate.Text = '" + istr_mh.From_Date + "∼" + istr_mh.To_Date + " 기간내'" 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )
end event

type uo_status from w_pism_sheet03`uo_status within w_pism170i
end type

type uo_wc from w_pism_sheet03`uo_wc within w_pism170i
end type

type st_fromto from w_pism_sheet03`st_fromto within w_pism170i
end type

type gb_1 from w_pism_sheet03`gb_1 within w_pism170i
end type

type uo_fromdate from w_pism_sheet03`uo_fromdate within w_pism170i
end type

type uo_year from w_pism_sheet03`uo_year within w_pism170i
end type

type uo_month from w_pism_sheet03`uo_month within w_pism170i
end type

type uo_frmonth from w_pism_sheet03`uo_frmonth within w_pism170i
end type

type gb_2 from w_pism_sheet03`gb_2 within w_pism170i
end type

type uo_tomonth from w_pism_sheet03`uo_tomonth within w_pism170i
end type

type st_fromtomonth from w_pism_sheet03`st_fromtomonth within w_pism170i
end type

type uo_todate from w_pism_sheet03`uo_todate within w_pism170i
end type

type uo_area from w_pism_sheet03`uo_area within w_pism170i
end type

type uo_div from w_pism_sheet03`uo_div within w_pism170i
end type

type dw_remark from u_pism_dw within w_pism170i
string tag = "작업일보 특기사항"
integer x = 5
integer y = 144
integer width = 2578
integer height = 1444
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pism170i_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

