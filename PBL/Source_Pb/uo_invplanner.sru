$PBExportHeader$uo_invplanner.sru
$PBExportComments$자재담당 UserObject
forward
global type uo_invplanner from userobject
end type
type dw_1 from datawindow within uo_invplanner
end type
end forward

global type uo_invplanner from userobject
integer width = 923
integer height = 108
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_invplanner uo_invplanner

on uo_invplanner.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_invplanner.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_invplanner
integer width = 905
integer height = 116
integer taborder = 10
string title = "none"
string dataobject = "d_invplanner"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SQLCA)
This.InsertRow(0)

end event

