$PBExportHeader$uo_plandiv_wip02.sru
forward
global type uo_plandiv_wip02 from userobject
end type
type dw_1 from datawindow within uo_plandiv_wip02
end type
end forward

global type uo_plandiv_wip02 from userobject
integer width = 928
integer height = 260
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_plandiv_wip02 uo_plandiv_wip02

on uo_plandiv_wip02.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_plandiv_wip02.destroy
destroy(this.dw_1)
end on

event constructor;DataWindowChild  cdw_1, cdw_2

dw_1.GetChild("XPLANT",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('SLE220')

dw_1.GetChild("DIV",cdw_2)
cdw_2.SetTransObject(Sqlca)
cdw_2.Retrieve('D')

dw_1.InsertRow(0)


end event

type dw_1 from datawindow within uo_plandiv_wip02
integer width = 901
integer height = 244
integer taborder = 10
string title = "none"
string dataobject = "dddw_plandiv_wip02"
boolean border = false
boolean livescroll = true
end type

event itemchanged;DataWindowChild  cdw_1
String ls_data, ls_colnm

This.AcceptText()
ls_colnm = This.GetColumnName()
IF ls_colnm = 'xplant' Then
   dw_1.SetItem(1,'div', ' ')
   ls_data = dw_1.GetItemString(1,'xplant')
   dw_1.GetChild("DIV",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_data)
END IF


end event

