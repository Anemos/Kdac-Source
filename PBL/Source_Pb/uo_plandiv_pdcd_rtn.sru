$PBExportHeader$uo_plandiv_pdcd_rtn.sru
forward
global type uo_plandiv_pdcd_rtn from userobject
end type
type dw_1 from datawindow within uo_plandiv_pdcd_rtn
end type
end forward

global type uo_plandiv_pdcd_rtn from userobject
integer width = 2519
integer height = 128
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_1 dw_1
end type
global uo_plandiv_pdcd_rtn uo_plandiv_pdcd_rtn

forward prototypes
public function string uf_return ()
end prototypes

public function string uf_return ();string l_s_plant,l_s_dvsn,l_s_pdcd

l_s_plant = dw_1.GetItemString(1,'xplant')
l_s_dvsn  = dw_1.GetItemString(1,'div')
l_s_pdcd  = dw_1.GetItemString(1,'pdcd')
return l_s_plant + l_s_dvsn + l_s_pdcd
end function

on uo_plandiv_pdcd_rtn.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on uo_plandiv_pdcd_rtn.destroy
destroy(this.dw_1)
end on

event constructor;DataWindowChild  cdw_1
String ls_autarea

if f_spacechk(g_s_autarea) = -1	then
	ls_autarea = 'D'
else
	ls_autarea = g_s_autarea
end if

dw_1.GetChild("XPLANT",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('SLE220')

dw_1.GetChild("DIV",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve(ls_autarea)

dw_1.GetChild("PDCD",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve(g_s_autdiv)

dw_1.settransobject(sqlca)
dw_1.retrieve()

dw_1.setitem(1,'xplant',ls_autarea)
dw_1.setitem(1,'div',g_s_autdiv)
end event

type dw_1 from datawindow within uo_plandiv_pdcd_rtn
integer y = 8
integer width = 2496
integer height = 116
integer taborder = 10
string title = "none"
string dataobject = "dddw_plandiv_rtn_01"
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
ELSEIF ls_colnm = 'div' Then
    dw_1.SetItem(1,'PDCD', ' ')
    ls_data = dw_1.GetItemString(1,'DIV')
    dw_1.GetChild("PDCD",cdw_1)
    cdw_1.SetTransObject(Sqlca)
    cdw_1.Retrieve(ls_data)
END IF


end event

