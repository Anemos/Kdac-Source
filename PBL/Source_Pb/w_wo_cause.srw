$PBExportHeader$w_wo_cause.srw
forward
global type w_wo_cause from window
end type
type cb_2 from commandbutton within w_wo_cause
end type
type cb_1 from commandbutton within w_wo_cause
end type
type dw_2 from uo_datawindow within w_wo_cause
end type
type dw_1 from uo_datawindow within w_wo_cause
end type
end forward

global type w_wo_cause from window
integer width = 2135
integer height = 1376
boolean titlebar = true
string title = "고장원인 코드 검색"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_wo_cause w_wo_cause

event open;dw_1.settransobject(sqlcmms)
dw_2.settransobject(sqlcmms)
dw_1.retrieve(gs_kmarea,gs_kmdivision)
end event

on w_wo_cause.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_wo_cause.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_wo_cause
integer x = 1687
integer y = 1176
integer width = 402
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취    소"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_wo_cause
integer x = 1253
integer y = 1176
integer width = 402
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "선    택"
end type

event clicked;string aaa, bbb
str_parm s_parm

if dw_1.getrow()<1 then return

aaa=dw_1.getitemstring(dw_1.getrow(),1)
bbb=dw_2.getitemstring(dw_2.getrow(),1)

s_parm.s_parm[1] = aaa
s_parm.s_parm[2] = bbb

CloseWithReturn(parent, s_parm)
end event

type dw_2 from uo_datawindow within w_wo_cause
integer x = 969
integer width = 1152
integer height = 1140
integer taborder = 20
string dataobject = "dd_cause_b"
boolean ib_enter = false
boolean ib_filter = false
boolean ib_sort = false
boolean ib_excel = false
boolean ib_print = false
boolean ib_toggle = false
boolean ib_date = false
end type

event retrieveend;call super::retrieveend;this.Event Trigger RowFocusChanged(1)
end event

type dw_1 from uo_datawindow within w_wo_cause
integer width = 965
integer height = 1140
integer taborder = 10
string dataobject = "dd_cause_a"
boolean ib_enter = false
boolean ib_filter = false
boolean ib_sort = false
boolean ib_excel = false
boolean ib_print = false
boolean ib_toggle = false
boolean ib_date = false
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then return

dw_2.retrieve(this.getitemstring(currentrow,1), this.getitemstring(currentrow,3), this.getitemstring(currentrow,4))
end event

