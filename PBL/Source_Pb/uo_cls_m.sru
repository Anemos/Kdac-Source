$PBExportHeader$uo_cls_m.sru
$PBExportComments$∞Ë¡§  User Object
forward
global type uo_cls_m from userobject
end type
type dw_1 from datawindow within uo_cls_m
end type
end forward

global type uo_cls_m from userobject
integer width = 928
integer height = 120
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_cls_m uo_cls_m

on uo_cls_m.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_cls_m.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_cls_m
integer x = 5
integer y = 4
integer width = 919
integer height = 120
integer taborder = 10
string title = "none"
string dataobject = "d_cls_m"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SQLCA)
This.InsertRow(0)
end event

