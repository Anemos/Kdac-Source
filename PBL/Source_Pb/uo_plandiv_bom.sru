$PBExportHeader$uo_plandiv_bom.sru
forward
global type uo_plandiv_bom from userobject
end type
type dw_1 from datawindow within uo_plandiv_bom
end type
end forward

global type uo_plandiv_bom from userobject
integer width = 1271
integer height = 124
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_plandiv_bom uo_plandiv_bom

forward prototypes
public function string uf_return ()
public function string uf_name ()
end prototypes

public function string uf_return ();string l_s_plant,l_s_dvsn

l_s_plant = dw_1.GetItemString(1,'xplant')
l_s_dvsn  = dw_1.GetItemString(1,'div')

return l_s_plant + l_s_dvsn
end function

public function string uf_name ();string l_s_name

l_s_name = trim(dw_1.getitemstring(dw_1.getrow(),"div"))

return l_s_name
end function

on uo_plandiv_bom.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_plandiv_bom.destroy
destroy(this.dw_1)
end on

event constructor;DataWindowChild  cdw_1, cdw_2
String ls_autarea

if f_spacechk(g_s_autarea) = -1	then
	ls_autarea = 'D'
else
	ls_autarea = g_s_autarea
end if

dw_1.GetChild("XPLANT",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('SLE220')

dw_1.GetChild("DIV",cdw_2)
cdw_2.SetTransObject(Sqlca)
cdw_2.Retrieve(ls_autarea)

dw_1.settransobject(sqlca)
dw_1.retrieve()

dw_1.SetItem(1,'xplant', ls_autarea)
dw_1.SetItem(1,'div', g_s_autdiv)



end event

type dw_1 from datawindow within uo_plandiv_bom
integer x = 9
integer y = 8
integer width = 1243
integer height = 116
integer taborder = 10
string title = "none"
string dataobject = "dddw_plandiv_bom"
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

