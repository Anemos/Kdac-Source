$PBExportHeader$w_system_error.srw
$PBExportComments$KDAC System ErrorÈ­¸é
forward
global type w_system_error from window
end type
type dw_error from datawindow within w_system_error
end type
type cb_print from commandbutton within w_system_error
end type
type cb_exit from commandbutton within w_system_error
end type
type cb_continue from commandbutton within w_system_error
end type
end forward

global type w_system_error from window
integer x = 763
integer y = 640
integer width = 2144
integer height = 1116
boolean titlebar = true
string title = "ÇÁ·Î±×·¥¿¡¼­ ¿À·ù¹ß»ý!!!!!"
windowtype windowtype = response!
long backcolor = 12632256
toolbaralignment toolbaralignment = alignatleft!
dw_error dw_error
cb_print cb_print
cb_exit cb_exit
cb_continue cb_continue
end type
global w_system_error w_system_error

on w_system_error.create
this.dw_error=create dw_error
this.cb_print=create cb_print
this.cb_exit=create cb_exit
this.cb_continue=create cb_continue
this.Control[]={this.dw_error,&
this.cb_print,&
this.cb_exit,&
this.cb_continue}
end on

on w_system_error.destroy
destroy(this.dw_error)
destroy(this.cb_print)
destroy(this.cb_exit)
destroy(this.cb_continue)
end on

event open;/////////////////////////////////////////////////////////////////////////
//
// Event	 :  w_system_error.open
//
// Purpose: 
// 			Displays system errors and allows the user to either continue
//				running the application, exit the application, or print the 
//				error message.  Called from the systemerror event in the
//				application object.
//
// Log:
// 
// DATE		NAME				REVISION
//------		-------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
///////////////////////////////////////////////////////////////////////////

dw_error.insertrow (1)
 
dw_error.setitem (1,"errornum",string(error.number))
dw_error.setitem (1,"message" ,error.text)
dw_error.setitem (1,"where"   ,error.windowmenu)
dw_error.setitem (1,"object"  ,error.object)
dw_error.setitem (1,"event"   ,error.objectevent)
dw_error.setitem (1,"line"    ,string(error.line))
end event

type dw_error from datawindow within w_system_error
integer x = 55
integer y = 16
integer width = 1618
integer height = 984
integer taborder = 10
boolean enabled = false
string dataobject = "d_system_error"
borderstyle borderstyle = stylelowered!
end type

type cb_print from commandbutton within w_system_error
integer x = 1710
integer y = 300
integer width = 366
integer height = 104
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string text = "ÀÎ¼â"
end type

event clicked;/////////////////////////////////////////////////////////////////////////
//
// Event	 :  w_system_error.cb_print.clicked!
//
// Purpose:
// 			Event cb_print.clicked - Print the current error message
//				and write the error message to the supplied file name.
//
// Log:
// 
//  DATE		NAME				REVISION
// ------	-------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
///////////////////////////////////////////////////////////////////////////

String	ls_line
Long	ln_prt

ln_prt   = printopen("System Error")
// Print each string variable
f_sysdate()
//print    (ln_prt, "System error message - "+string(today())+" - "+string(now(), "HH:MM:SS"))
print    (ln_prt, "System error message - "+g_s_date+" - "+string(now(), "HH:MM:SS"))
print    (ln_prt, " ")

ls_line = "Error Number  : " + getitemstring(dw_error,1,1)
print    (ln_prt, ls_line)

ls_line = "Error Message : " + getitemstring(dw_error,1,2)
print    (ln_prt, ls_line)

ls_line = "Window/Menu   : " + getitemstring(dw_error,1,3)
print    (ln_prt, ls_line)

ls_line = "Object        : " + getitemstring(dw_error,1,4)
print    (ln_prt, ls_line)

ls_line = "Event         : " + getitemstring(dw_error,1,5)
print    (ln_prt, ls_line)

ls_line = "Line Number   : " + getitemstring(dw_error,1,6)
print    (ln_prt, ls_line)

printclose(ln_prt)
return
end event

type cb_exit from commandbutton within w_system_error
integer x = 1710
integer y = 44
integer width = 366
integer height = 104
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string text = "Á¾·á"
boolean default = true
end type

on clicked;/////////////////////////////////////////////////////////////////////////
//
// Event	 :  w_system_error.cb_exit
//
// Purpose:
// 			Ends the application session
//
// Log:
// 
// DATE		NAME				REVISION
//------		-------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
///////////////////////////////////////////////////////////////////////////

halt close
end on

type cb_continue from commandbutton within w_system_error
integer x = 1710
integer y = 172
integer width = 366
integer height = 104
integer taborder = 20
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string text = "°è¼Ó"
end type

on clicked;/////////////////////////////////////////////////////////////////////////
//
// Event	 :  w_system_error.cb_continue
//
// Purpose:
// 			Closes w_system_error
//
// Log:
// 
// DATE		NAME				REVISION
//------		-------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
///////////////////////////////////////////////////////////////////////////

close(parent)
end on

