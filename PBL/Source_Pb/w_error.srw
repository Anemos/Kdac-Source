$PBExportHeader$w_error.srw
$PBExportComments$generic error window used in the application systemerror event
forward
global type w_error from window
end type
type st_1 from statictext within w_error
end type
type mle_1 from multilineedit within w_error
end type
type dw_error from datawindow within w_error
end type
type cb_print from commandbutton within w_error
end type
type cb_exit from commandbutton within w_error
end type
type cb_continue from commandbutton within w_error
end type
end forward

global type w_error from window
integer x = 379
integer y = 428
integer width = 2231
integer height = 1384
boolean titlebar = true
string title = "System Error"
windowtype windowtype = response!
long backcolor = 78748035
string icon = "target.ico"
toolbaralignment toolbaralignment = alignatleft!
st_1 st_1
mle_1 mle_1
dw_error dw_error
cb_print cb_print
cb_exit cb_exit
cb_continue cb_continue
end type
global w_error w_error

on w_error.create
this.st_1=create st_1
this.mle_1=create mle_1
this.dw_error=create dw_error
this.cb_print=create cb_print
this.cb_exit=create cb_exit
this.cb_continue=create cb_continue
this.Control[]={this.st_1,&
this.mle_1,&
this.dw_error,&
this.cb_print,&
this.cb_exit,&
this.cb_continue}
end on

on w_error.destroy
destroy(this.st_1)
destroy(this.mle_1)
destroy(this.dw_error)
destroy(this.cb_print)
destroy(this.cb_exit)
destroy(this.cb_continue)
end on

event open;/////////////////////////////////////////////////////////////////////////
// Event	 :  w_system_error.open
// Purpose:
// 			Displays system errors and allows the user to either continue
//				running the application, exit the application, or print the 
//				error message.  Called from the systemerror event in the
//				application object.
// Log:
// DATE		NAME				REVISION
//------		-------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
///////////////////////////////////////////////////////////////////////////
Integer			li_ScreenH, li_ScreenW
Environment		le_Env

// 윈도우를 가운데 위치 시킨다.
GetEnvironment(le_Env)

li_ScreenH = PixelsToUnits(le_Env.ScreenHeight, YPixelsToUnits!)
li_ScreenW = PixelsToUnits(le_Env.ScreenWidth, XPixelsToUnits!)

This.Y = (li_ScreenH - This.Height) / 2
This.X = (li_ScreenW - This.Width) / 2

dw_error.insertrow (1)

dw_error.setitem (1,"errornum",string(error.number))
dw_error.setitem (1,"message" ,error.text)
dw_error.setitem (1,"where"   ,error.windowmenu)
dw_error.setitem (1,"object"  ,error.object)
dw_error.setitem (1,"event"   ,error.objectevent)
dw_error.setitem (1,"line"    ,string(error.line))



end event

type st_1 from statictext within w_error
integer x = 59
integer y = 812
integer width = 485
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "사용자 COMMENT"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_error
integer x = 59
integer y = 880
integer width = 2098
integer height = 256
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type dw_error from datawindow within w_error
integer x = 55
integer y = 40
integer width = 2085
integer height = 740
integer taborder = 10
boolean enabled = false
string dataobject = "d_error"
borderstyle borderstyle = stylelowered!
end type

type cb_print from commandbutton within w_error
integer x = 1422
integer y = 1180
integer width = 430
integer height = 88
integer taborder = 40
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Print"
end type

event clicked;// 출력버턴 클릭시
// 
string 	ls_line
long		ll_prt

ll_prt   = printopen("System Error")

print    (ll_prt, "System error message - "+string(today())+" - "+string(now(), "HH:MM:SS"))
print    (ll_prt, " ")

ls_line = "Error Number  : " + getitemstring(dw_error,1,1)
print    (ll_prt, ls_line)

ls_line = "Error Message : " + getitemstring(dw_error,1,2)
print    (ll_prt, ls_line)

ls_line = "Window/Menu   : " + getitemstring(dw_error,1,3)
print    (ll_prt, ls_line)

ls_line = "Object        : " + getitemstring(dw_error,1,4)
print    (ll_prt, ls_line)

ls_line = "Event         : " + getitemstring(dw_error,1,5)
print    (ll_prt, ls_line)

ls_line = "Line Number   : " + getitemstring(dw_error,1,6)
print    (ll_prt, ls_line)

PrintClose(ll_prt)
Return




end event

type cb_exit from commandbutton within w_error
integer x = 453
integer y = 1180
integer width = 430
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Exit The Program"
boolean default = true
end type

event clicked;// 종료버턴 클릭시
// 
String	ls_module, ls_windowid, ls_errornum
String	ls_errortext, ls_errorobject, ls_errorevent
String	ls_errorline, ls_remark

If dw_error.RowCount() > 0 Then
	ls_errornum		= dw_error.GetItemString(1, "errornum")
	ls_errortext	= dw_error.GetItemString(1, "message")
	ls_windowid		= dw_error.GetItemString(1, "where")
	ls_errorobject	= dw_error.GetItemString(1, "object")
	ls_errorevent	= dw_error.GetItemString(1, "event")
	ls_errorline	= dw_error.GetItemString(1, "line")
	ls_remark		= Mid(mle_1.Text, 1, 255)
End If
			
Halt Close


end event

type cb_continue from commandbutton within w_error
integer x = 937
integer y = 1180
integer width = 430
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Continue"
end type

event clicked;// 계속버턴 클릭시
// 
String	ls_module, ls_screenid, ls_errornum
String	ls_errortext, ls_errorobject, ls_errorevent
String	ls_errorline, ls_remark

If dw_error.RowCount() > 0 Then
	ls_errornum		= dw_error.GetItemString(1, "errornum")
	ls_errortext	= dw_error.GetItemString(1, "message")

	ls_screenid		= dw_error.GetItemString(1, "where")
	ls_errorobject	= dw_error.GetItemString(1, "object")
	ls_errorevent	= dw_error.GetItemString(1, "event")
	ls_errorline	= dw_error.GetItemString(1, "line")
	ls_remark		= Mid(mle_1.Text, 1, 255)
End If
			
Close(Parent)





end event

