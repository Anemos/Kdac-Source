$PBExportHeader$w_mpms_today.srw
$PBExportComments$데이터윈도우용 달력윈도우
forward
global type w_mpms_today from window
end type
type cb_1 from commandbutton within w_mpms_today
end type
type uo_1 from u_mpms_dw_today within w_mpms_today
end type
end forward

global type w_mpms_today from window
integer x = 1056
integer y = 484
integer width = 626
integer height = 652
boolean titlebar = true
string title = "일자선택"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cb_1 cb_1
uo_1 uo_1
end type
global w_mpms_today w_mpms_today

on w_mpms_today.create
this.cb_1=create cb_1
this.uo_1=create uo_1
this.Control[]={this.cb_1,&
this.uo_1}
end on

on w_mpms_today.destroy
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;////f_win_center(This)
//

str_mpms_xy str_get_parm
str_get_parm = Message.PowerObjectParm

If Not Isnull(str_get_parm.lx) and str_get_parm.lx <> 0 then
	This.x = str_get_parm.lx
	This.y = str_get_parm.ly
Else
	f_mpms_win_center(This)
End If	
end event
event close;//If This.uo_1.sle_date.text = string(g_s_date,"@@@@-@@-@@") then
//	closewithreturn(This,This.uo_1.sle_date.text)
//	close(This)
//end if	

end event

event closequery;//Setnull(gl_x)
//Setnull(gl_y)
end event

type cb_1 from commandbutton within w_mpms_today
integer x = 923
integer y = 780
integer width = 402
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "none"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type uo_1 from u_mpms_dw_today within w_mpms_today
integer width = 645
integer height = 604
integer taborder = 10
end type

on uo_1.destroy
call u_mpms_dw_today::destroy
end on

event ue_variable_set;closewithreturn(parent,sle_date.text)

end event

