$PBExportHeader$w_rtn012u_res01.srw
forward
global type w_rtn012u_res01 from window
end type
type dw_1 from datawindow within w_rtn012u_res01
end type
end forward

global type w_rtn012u_res01 from window
integer x = 302
integer y = 700
integer width = 2327
integer height = 1552
boolean titlebar = true
string title = "유사품번 Error 조회"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
dw_1 dw_1
end type
global w_rtn012u_res01 w_rtn012u_res01

on w_rtn012u_res01.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_rtn012u_res01.destroy
destroy(this.dw_1)
end on

type dw_1 from datawindow within w_rtn012u_res01
integer x = 18
integer y = 36
integer width = 2231
integer height = 1332
integer taborder = 10
string title = "none"
string dataobject = "d_rtn01_dw_rtn011_error"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

