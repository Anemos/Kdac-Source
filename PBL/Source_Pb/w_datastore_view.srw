$PBExportHeader$w_datastore_view.srw
forward
global type w_datastore_view from window
end type
type dw_1 from datawindow within w_datastore_view
end type
end forward

global type w_datastore_view from window
integer width = 4064
integer height = 2020
boolean titlebar = true
string title = "DataStore View"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "Information!"
dw_1 dw_1
end type
global w_datastore_view w_datastore_view

type variables
DataStore	ids
end variables

event open;
ids = Message.PowerObjectParm

dw_1.DataObject = ids.DataObject

ids.ShareData( dw_1 )

end event

on w_datastore_view.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_datastore_view.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_datastore_view
integer x = 46
integer y = 36
integer width = 3941
integer height = 1836
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(SQLCA)
end event

