$PBExportHeader$uo_sumplanner.sru
$PBExportComments$시설담당 UserObject
forward
global type uo_sumplanner from userobject
end type
type dw_1 from datawindow within uo_sumplanner
end type
end forward

global type uo_sumplanner from userobject
integer width = 928
integer height = 116
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_sumplanner uo_sumplanner

on uo_sumplanner.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_sumplanner.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_sumplanner
integer x = 5
integer y = 8
integer width = 923
integer height = 108
integer taborder = 10
string title = "none"
string dataobject = "d_sum_planner"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SQLCA)
This.insertRow(0)
end event

