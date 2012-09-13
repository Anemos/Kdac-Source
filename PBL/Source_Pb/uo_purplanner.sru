$PBExportHeader$uo_purplanner.sru
$PBExportComments$구매담당 UserObject
forward
global type uo_purplanner from userobject
end type
type dw_1 from datawindow within uo_purplanner
end type
end forward

global type uo_purplanner from userobject
integer width = 919
integer height = 108
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_purplanner uo_purplanner

on uo_purplanner.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_purplanner.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_purplanner
integer width = 997
integer height = 104
integer taborder = 10
string title = "none"
string dataobject = "d_purplanner"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SQLCA)
This.InsertRow(0)
end event

