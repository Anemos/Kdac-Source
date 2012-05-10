$PBExportHeader$w_pisr145r.srw
$PBExportComments$이원화업체 Respond Window
forward
global type w_pisr145r from window
end type
type dw_1 from datawindow within w_pisr145r
end type
end forward

global type w_pisr145r from window
integer width = 2363
integer height = 1268
boolean titlebar = true
string title = "이원화품번 업체정보"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_pisr145r w_pisr145r

type variables
str_pisr_partkb istr_partkb
end variables

on w_pisr145r.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_pisr145r.destroy
destroy(this.dw_1)
end on

event open;istr_partkb = Message.PowerObjectParm

f_pisc_win_center_move(This)

dw_1.settransobject(sqlpis)
dw_1.retrieve(istr_partkb.areacode, istr_partkb.divcode, istr_partkb.itemcode)
end event

type dw_1 from datawindow within w_pisr145r
integer x = 14
integer y = 16
integer width = 2313
integer height = 1124
integer taborder = 10
string title = "none"
string dataobject = "d_pisr145r_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

