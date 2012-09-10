$PBExportHeader$w_pism010u_01.srw
$PBExportComments$공수항목 HELP
forward
global type w_pism010u_01 from w_pism_resp01
end type
type cb_close from commandbutton within w_pism010u_01
end type
type dw_mhcodehelp from u_pism_dw within w_pism010u_01
end type
end forward

global type w_pism010u_01 from w_pism_resp01
integer width = 3525
integer height = 2032
string title = "공수항목 HELP"
cb_close cb_close
dw_mhcodehelp dw_mhcodehelp
end type
global w_pism010u_01 w_pism010u_01

on w_pism010u_01.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_mhcodehelp=create dw_mhcodehelp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_mhcodehelp
end on

on w_pism010u_01.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_mhcodehelp)
end on

event ue_retrieve;call super::ue_retrieve;dw_mhcodehelp.SetTransObject(SqlPIS) 
dw_mhcodehelp.Retrieve() 
end event

event open;call super::open;This.TriggerEvent("ue_retrieve") 
end event

type cb_close from commandbutton within w_pism010u_01
integer x = 2962
integer y = 1852
integer width = 530
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;f_pism_dwupdate(dw_mhcodehelp, True) 

Close(Parent) 
end event

type dw_mhcodehelp from u_pism_dw within w_pism010u_01
integer width = 3493
integer height = 1844
integer taborder = 10
string dataobject = "d_pism010u_11"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

