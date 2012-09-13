$PBExportHeader$w_rtn01_rtninfo_history.srw
$PBExportComments$공정정보 이력조회 화면
forward
global type w_rtn01_rtninfo_history from window
end type
type dw_1 from datawindow within w_rtn01_rtninfo_history
end type
end forward

global type w_rtn01_rtninfo_history from window
integer width = 3566
integer height = 1700
boolean titlebar = true
string title = "공정정보 이력조회"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
end type
global w_rtn01_rtninfo_history w_rtn01_rtninfo_history

on w_rtn01_rtninfo_history.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_rtn01_rtninfo_history.destroy
destroy(this.dw_1)
end on

event open;str_parms lstr_parm

dw_1.settransobject(sqlca)
lstr_parm = Message.PowerObjectParm

dw_1.retrieve(lstr_parm.string_arg[1], lstr_parm.string_arg[2], lstr_parm.string_arg[3], &
	lstr_parm.string_arg[4], lstr_parm.string_arg[5], lstr_parm.string_arg[6], &
	lstr_parm.string_arg[7], lstr_parm.integer_arg[1])
end event

type dw_1 from datawindow within w_rtn01_rtninfo_history
integer x = 23
integer y = 24
integer width = 3502
integer height = 1564
integer taborder = 10
string title = "none"
string dataobject = "d_rtn01_detail_rtninfo_history"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

