$PBExportHeader$uo_plandiv_pdcd_all.sru
forward
global type uo_plandiv_pdcd_all from userobject
end type
type dw_1 from datawindow within uo_plandiv_pdcd_all
end type
type gb_1 from groupbox within uo_plandiv_pdcd_all
end type
end forward

global type uo_plandiv_pdcd_all from userobject
integer width = 2565
integer height = 212
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_keydown pbm_keydown
dw_1 dw_1
gb_1 gb_1
end type
global uo_plandiv_pdcd_all uo_plandiv_pdcd_all

forward prototypes
public function string uf_return ()
end prototypes

public function string uf_return ();string 	ls_plant,ls_dvsn,ls_pdcd

ls_plant = string(dw_1.GetItemString(1,'xplant'),'@')
ls_dvsn  = string(dw_1.GetItemString(1,'div'),'@')
ls_pdcd  = string(dw_1.GetItemString(1,'pdcd'),'@@')
return ls_plant + ls_dvsn + ls_pdcd
end function

on uo_plandiv_pdcd_all.create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.gb_1}
end on

on uo_plandiv_pdcd_all.destroy
destroy(this.dw_1)
destroy(this.gb_1)
end on

event constructor;DataWindowChild  	cdw_1
String 				ls_autarea,ls_autdiv

if f_spacechk(g_s_autarea) = -1	then
	ls_autarea = 'D'
else
	ls_autarea = g_s_autarea
end if

if f_spacechk(g_s_autdiv) = -1	then
	ls_autdiv = 'A'
else
	ls_autdiv = g_s_autdiv
end if

dw_1.GetChild("XPLANT",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve('SLE220')

dw_1.GetChild("DIV",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve(ls_autarea)

dw_1.GetChild("PDCD",cdw_1)
cdw_1.SetTransObject(Sqlca)
cdw_1.Retrieve(ls_autdiv)

dw_1.settransobject(sqlca)
dw_1.retrieve()

dw_1.setitem(1,'xplant',g_s_autarea)
dw_1.setitem(1,'div',g_s_autdiv)
// dw_1.setitem(1,'pdcd',cdw_1.getitemstring(2,1))
end event

type dw_1 from datawindow within uo_plandiv_pdcd_all
event ue_keydown pbm_dwnkey
integer x = 64
integer y = 56
integer width = 2437
integer height = 112
string title = "none"
string dataobject = "dddw_plandiv_ALL_01"
boolean border = false
end type

event itemchanged;DataWindowChild  	cdw_1
String 				ls_data, ls_colnm

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

type gb_1 from groupbox within uo_plandiv_pdcd_all
integer x = 18
integer width = 2523
integer height = 192
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

