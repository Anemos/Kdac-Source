$PBExportHeader$uo_srce_m.sru
$PBExportComments$±∏¿‘º± UserObject
forward
global type uo_srce_m from userobject
end type
type dw_1 from datawindow within uo_srce_m
end type
end forward

global type uo_srce_m from userobject
integer width = 928
integer height = 120
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_srce_m uo_srce_m

on uo_srce_m.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_srce_m.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_srce_m
integer width = 933
integer height = 124
integer taborder = 10
string title = "none"
string dataobject = "d_srce_m"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SQLCA)
This.InsertRow(0)
end event

