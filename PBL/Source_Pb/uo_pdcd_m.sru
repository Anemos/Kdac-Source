$PBExportHeader$uo_pdcd_m.sru
$PBExportComments$Á¦Ç°±º UserObject
forward
global type uo_pdcd_m from userobject
end type
type dw_1 from datawindow within uo_pdcd_m
end type
end forward

global type uo_pdcd_m from userobject
integer width = 891
integer height = 112
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_pdcd_m uo_pdcd_m

on uo_pdcd_m.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_pdcd_m.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within uo_pdcd_m
integer width = 896
integer height = 112
integer taborder = 10
string title = "none"
string dataobject = "d_pdcd_m"
boolean border = false
boolean livescroll = true
end type

event constructor;DataWindowChild cdw_1

This.GetChild('code', cdw_1)
cdw_1.SetTransObject(SQLCA)
cdw_1.Retrieve()

This.InsertRow(0)
end event

