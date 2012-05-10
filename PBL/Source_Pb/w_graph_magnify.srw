$PBExportHeader$w_graph_magnify.srw
$PBExportComments$그래프 크게 보기
forward
global type w_graph_magnify from window
end type
type dw_magnify from datawindow within w_graph_magnify
end type
end forward

global type w_graph_magnify from window
integer x = 5
integer y = 212
integer width = 4434
integer height = 2384
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_magnify dw_magnify
end type
global w_graph_magnify w_graph_magnify

on w_graph_magnify.create
this.dw_magnify=create dw_magnify
this.Control[]={this.dw_magnify}
end on

on w_graph_magnify.destroy
destroy(this.dw_magnify)
end on

event open;string ls_parm, ls_gubun, ls_fromdt, ls_todt, ls_tempdt

ls_parm = message.stringparm
ls_gubun = mid(ls_parm,1,1)

ls_tempdt = uf_add_month( mid(ls_parm, 2) , 1) + '01'
ls_todt = f_relativedate( ls_tempdt,-1)
ls_tempdt = uf_add_month( mid(ls_parm, 2) , -12)
ls_fromdt = ls_tempdt + '01'

if ls_gubun = 'A' then
	This.title = '월별 거래처별 불량발생 추이'
	dw_magnify.dataobject = 'd_qctl313i_07'
	dw_magnify.settransobject(sqlcs)
else
	This.title = '월별 공장별 불량발생 추이'
	dw_magnify.dataobject = 'd_qctl313i_08'
	dw_magnify.settransobject(sqlcs)
end if

dw_magnify.retrieve(ls_fromdt, ls_todt)
end event

type dw_magnify from datawindow within w_graph_magnify
integer x = 32
integer y = 32
integer width = 4352
integer height = 2236
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

