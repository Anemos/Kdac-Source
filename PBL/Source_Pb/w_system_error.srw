$PBExportHeader$w_system_error.srw
$PBExportComments$System Error 발생시 내용을 Display                                    [Yangsh]
forward
global type w_system_error from window
end type
type mle_text from multilineedit within w_system_error
end type
type cb_savetofile from commandbutton within w_system_error
end type
type cb_print from commandbutton within w_system_error
end type
type cb_halt from commandbutton within w_system_error
end type
type cb_continue from commandbutton within w_system_error
end type
type st_linelabel from statictext within w_system_error
end type
type st_objecteventlabel from statictext within w_system_error
end type
type st_objectlabel from statictext within w_system_error
end type
type st_windowmenulabel from statictext within w_system_error
end type
type st_textlabel from statictext within w_system_error
end type
type st_numberlabel from statictext within w_system_error
end type
type st_line from statictext within w_system_error
end type
type st_objectevent from statictext within w_system_error
end type
type st_object from statictext within w_system_error
end type
type st_windowmenu from statictext within w_system_error
end type
type st_number from statictext within w_system_error
end type
end forward

global type w_system_error from window
integer x = 247
integer y = 224
integer width = 2135
integer height = 1112
boolean titlebar = true
string title = "시스템 오류 발생"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
mle_text mle_text
cb_savetofile cb_savetofile
cb_print cb_print
cb_halt cb_halt
cb_continue cb_continue
st_linelabel st_linelabel
st_objecteventlabel st_objecteventlabel
st_objectlabel st_objectlabel
st_windowmenulabel st_windowmenulabel
st_textlabel st_textlabel
st_numberlabel st_numberlabel
st_line st_line
st_objectevent st_objectevent
st_object st_object
st_windowmenu st_windowmenu
st_number st_number
end type
global w_system_error w_system_error

event open;Title	= "시스템 오류 발생 (" + gs_appname + ")"

f_set_window_title(This)
st_number.text			= String( error.Number )
mle_text.Text 			= error.Text
st_windowmenu.text	= error.WindowMenu
st_object.text 		= error.Object
st_objectevent.text 	= error.ObjectEvent
st_line.text 			= String( error.Line )
end event

on w_system_error.create
this.mle_text=create mle_text
this.cb_savetofile=create cb_savetofile
this.cb_print=create cb_print
this.cb_halt=create cb_halt
this.cb_continue=create cb_continue
this.st_linelabel=create st_linelabel
this.st_objecteventlabel=create st_objecteventlabel
this.st_objectlabel=create st_objectlabel
this.st_windowmenulabel=create st_windowmenulabel
this.st_textlabel=create st_textlabel
this.st_numberlabel=create st_numberlabel
this.st_line=create st_line
this.st_objectevent=create st_objectevent
this.st_object=create st_object
this.st_windowmenu=create st_windowmenu
this.st_number=create st_number
this.Control[]={this.mle_text,&
this.cb_savetofile,&
this.cb_print,&
this.cb_halt,&
this.cb_continue,&
this.st_linelabel,&
this.st_objecteventlabel,&
this.st_objectlabel,&
this.st_windowmenulabel,&
this.st_textlabel,&
this.st_numberlabel,&
this.st_line,&
this.st_objectevent,&
this.st_object,&
this.st_windowmenu,&
this.st_number}
end on

on w_system_error.destroy
destroy(this.mle_text)
destroy(this.cb_savetofile)
destroy(this.cb_print)
destroy(this.cb_halt)
destroy(this.cb_continue)
destroy(this.st_linelabel)
destroy(this.st_objecteventlabel)
destroy(this.st_objectlabel)
destroy(this.st_windowmenulabel)
destroy(this.st_textlabel)
destroy(this.st_numberlabel)
destroy(this.st_line)
destroy(this.st_objectevent)
destroy(this.st_object)
destroy(this.st_windowmenu)
destroy(this.st_number)
end on

type mle_text from multilineedit within w_system_error
integer x = 558
integer y = 128
integer width = 1509
integer height = 368
integer taborder = 1
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean vscrollbar = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_savetofile from commandbutton within w_system_error
integer x = 576
integer y = 884
integer width = 457
integer height = 108
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "화일로 저장"
end type

event clicked;string ls_pathfile, ls_filename
integer li_file

// Prompt the user for a filename
CHOOSE CASE GetFileSaveName( "오류 내용의 저장", &
		ls_pathfile, ls_filename, "err", "오류화일(*.err),*.err" )
	CASE 1  // Good -- write the error
		li_file = FileOpen( ls_pathfile, LineMode!, Write!, &
					LockReadWrite!, Append! )
		IF li_file <> -1 THEN
			FileWrite( li_file, " " )
			FileWrite( li_file, "--------------------------------------------" )
			FileWrite( li_File, "  발생일자 : " + String(Today(), 'yyyy/M/d') + " " + String(Now(), 'hh:mm'))
			FileWrite( li_file, " " )
			FileWrite( li_file, "       오류 번호 : " + st_number.text )
			FileWrite( li_file, "       오류 내용 : " + mle_text.text)
			FileWrite( li_file, "     Window/menu : " + st_windowmenu.text)
			FileWrite( li_file, "          Object : " + st_object.text)
			FileWrite( li_file, "           Event : " + st_objectevent.text)
			FileWrite( li_file, "       Line 번호 : " + st_line.text)
			FileWrite( li_file, "--------------------------------------------" )
			FileClose( li_file )
		ELSE
			MessageBox( "Stop", "File Writing Failed!", StopSign! )
		END IF			
	CASE 0  // Cancel -- ignore
	CASE -1 // Error
			MessageBox( "Stop","Error Saved!", StopSign! )
END CHOOSE
end event

type cb_print from commandbutton within w_system_error
integer x = 91
integer y = 884
integer width = 457
integer height = 108
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "출력(&P)"
end type

event clicked;long ll_job

SetPointer(Hourglass!)

ll_job = PrintOpen("System Error(Printing..)")
IF ll_job < 0 THEN
	SetPointer(Arrow!)
	MessageBox("Print", "Failed Printing..", StopSign! )
	RETURN
END IF

Print( ll_job, "  <<< System Error Log >>> ")
Print( ll_job, " ")
Print( ll_job, " ")
Print( ll_job, "  Date : " + String(Today(), 'yyyy/M/d') + " " + String(Now(), 'hh:mm'))
Print( ll_job, " ")
Print( ll_job, " ")
Print( ll_job, "       Error No : " + st_number.text)
Print( ll_job, "       Error Msg : " + mle_text.text)
Print( ll_job, "     Window/menu : " + st_windowmenu.text)
Print( ll_job, "          Object : " + st_object.text)
Print( ll_job, "           Event : " + st_objectevent.text)
Print( ll_job, "       Line No : " + st_line.text)

PrintClose( ll_job )
SetPointer(Arrow!)
end event

type cb_halt from commandbutton within w_system_error
integer x = 1545
integer y = 884
integer width = 457
integer height = 108
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "시스템 종료"
boolean default = true
end type

event clicked;CloseWithReturn( parent, 0 )
end event

type cb_continue from commandbutton within w_system_error
integer x = 1061
integer y = 884
integer width = 457
integer height = 108
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "계속진행(&C)"
end type

event clicked;CloseWithReturn( parent, 1 )
end event

type st_linelabel from statictext within w_system_error
integer x = 50
integer y = 768
integer width = 466
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Line 번호 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_objecteventlabel from statictext within w_system_error
integer x = 50
integer y = 680
integer width = 466
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Event:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_objectlabel from statictext within w_system_error
integer x = 50
integer y = 592
integer width = 466
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Object :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_windowmenulabel from statictext within w_system_error
integer x = 18
integer y = 504
integer width = 498
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Window/menu :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_textlabel from statictext within w_system_error
integer x = 69
integer y = 132
integer width = 448
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "오류 내용 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_numberlabel from statictext within w_system_error
integer x = 69
integer y = 44
integer width = 448
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "오류 번호 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_line from statictext within w_system_error
integer x = 558
integer y = 764
integer width = 1509
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "st_line"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_objectevent from statictext within w_system_error
integer x = 558
integer y = 676
integer width = 1509
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "st_objectevent"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_object from statictext within w_system_error
integer x = 558
integer y = 588
integer width = 1509
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "st_object"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_windowmenu from statictext within w_system_error
integer x = 558
integer y = 500
integer width = 1509
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "st_windowmenu"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_number from statictext within w_system_error
integer x = 558
integer y = 40
integer width = 1509
integer height = 88
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "st_number"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

