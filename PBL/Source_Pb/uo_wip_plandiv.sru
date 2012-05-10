$PBExportHeader$uo_wip_plandiv.sru
forward
global type uo_wip_plandiv from userobject
end type
type dw_1 from datawindow within uo_wip_plandiv
end type
end forward

global type uo_wip_plandiv from userobject
integer width = 1271
integer height = 112
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_wip_plandiv uo_wip_plandiv

forward prototypes
public function string uf_return ()
end prototypes

public function string uf_return ();string ls_plant, ls_dvsn

ls_plant = dw_1.getitemstring(1,"xplant")
ls_dvsn = dw_1.getitemstring(1,"div")

return ls_plant + ls_dvsn
end function

on uo_wip_plandiv.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_wip_plandiv.destroy
destroy(this.dw_1)
end on

event constructor;DataWindowChild  cdw_1, cdw_2

dw_1.GetChild("XPLANT",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('SLE220')

dw_1.GetChild("DIV",cdw_2)
cdw_2.SetTransObject(Sqlca)
cdw_2.Retrieve('D')

dw_1.settransobject(sqlca)
dw_1.retrieve()


end event

type dw_1 from datawindow within uo_wip_plandiv
integer y = 8
integer width = 1248
integer height = 116
integer taborder = 10
string dataobject = "dddw_plandiv_wip"
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

