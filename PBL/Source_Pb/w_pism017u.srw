$PBExportHeader$w_pism017u.srw
$PBExportComments$조별 작업일보 MH집계제외 사원등록
forward
global type w_pism017u from w_pism_sheet02
end type
type dw_excemp from u_pism_dw within w_pism017u
end type
end forward

global type w_pism017u from w_pism_sheet02
dw_excemp dw_excemp
end type
global w_pism017u w_pism017u

event closequery;call super::closequery;If wd_modifiedChk(dw_excemp, True) = 1 Then This.TriggerEvent("ue_save") 
end event

event open;call super::open;wf_setRetCondition(STDATE) 
end event

event resize;call super::resize;dw_excemp.Width = newwidth - ( dw_excemp.x + 10 ) 
dw_excemp.Height = newheight - ( dw_excemp.y + uo_status.Height + 10 ) 
end event

event ue_postopen;call super::ue_postopen;This.TriggerEvent("ue_retrieve") 
end event

event ue_retrieve;call super::ue_retrieve;If wd_modifiedChk(dw_excemp, True) = 1 Then This.TriggerEvent("ue_save") 

dw_excemp.SetRedraw(False)
dw_excemp.SetTransObject(SqlPIS)
dw_excemp.Retrieve(istr_mh.area, istr_mh.div, uo_date.is_uo_Date) 
dw_excemp.SetRedraw(True)
end event

event ue_save;call super::ue_save;dw_excemp.Event save_data() 
end event

on w_pism017u.create
int iCurrent
call super::create
this.dw_excemp=create dw_excemp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_excemp
end on

on w_pism017u.destroy
call super::destroy
destroy(this.dw_excemp)
end on

type uo_status from w_pism_sheet02`uo_status within w_pism017u
end type

type st_fromto from w_pism_sheet02`st_fromto within w_pism017u
end type

type uo_todate from w_pism_sheet02`uo_todate within w_pism017u
end type

type gb_2 from w_pism_sheet02`gb_2 within w_pism017u
end type

type uo_fromdate from w_pism_sheet02`uo_fromdate within w_pism017u
end type

type uo_month from w_pism_sheet02`uo_month within w_pism017u
end type

type uo_year from w_pism_sheet02`uo_year within w_pism017u
end type

type uo_date from w_pism_sheet02`uo_date within w_pism017u
end type

type uo_area from w_pism_sheet02`uo_area within w_pism017u
end type

type uo_div from w_pism_sheet02`uo_div within w_pism017u
end type

type uo_frmonth from w_pism_sheet02`uo_frmonth within w_pism017u
end type

type st_fromtomonth from w_pism_sheet02`st_fromtomonth within w_pism017u
end type

type gb_1 from w_pism_sheet02`gb_1 within w_pism017u
end type

type uo_tomonth from w_pism_sheet02`uo_tomonth within w_pism017u
end type

type dw_excemp from u_pism_dw within w_pism017u
integer x = 9
integer y = 180
integer width = 2272
integer height = 1452
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_pism010u_10"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_multiselection = false
integer ii_selection = 0
end type

event itemchanged;call super::itemchanged;This.AcceptText() 

end event

event save_data;call super::save_data;Return f_pism_dwupdate(This, True)
end event

