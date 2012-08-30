$PBExportHeader$w_ftpfile_pw.srw
forward
global type w_ftpfile_pw from window
end type
type sle_pw from singlelineedit within w_ftpfile_pw
end type
type cb_ok from commandbutton within w_ftpfile_pw
end type
type cb_cancel from commandbutton within w_ftpfile_pw
end type
type gb_1 from groupbox within w_ftpfile_pw
end type
end forward

global type w_ftpfile_pw from window
integer width = 1518
integer height = 656
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
sle_pw sle_pw
cb_ok cb_ok
cb_cancel cb_cancel
gb_1 gb_1
end type
global w_ftpfile_pw w_ftpfile_pw

event open;str_parm st_get_temp

//¡ﬂæ”ø° Open
f_win_center(this)

st_get_temp = message.powerobjectparm
this.Title = trim(st_get_temp.s_parm[1])

sle_pw.setfocus()
end event

on w_ftpfile_pw.create
this.sle_pw=create sle_pw
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
this.Control[]={this.sle_pw,&
this.cb_ok,&
this.cb_cancel,&
this.gb_1}
end on

on w_ftpfile_pw.destroy
destroy(this.sle_pw)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.gb_1)
end on

type sle_pw from singlelineedit within w_ftpfile_pw
event ue_downenter pbm_keydown
integer x = 59
integer y = 136
integer width = 1349
integer height = 124
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±º∏≤√º"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event ue_downenter;IF KeyDown(KeyEnter!) THEN 
	cb_ok.triggerevent("clicked")
end if
end event

type cb_ok from commandbutton within w_ftpfile_pw
integer x = 229
integer y = 360
integer width = 457
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±º∏≤√º"
string text = "»Æ¿Œ"
end type

event clicked;str_parm st_give_temp

st_give_temp.check = TRUE
st_give_temp.s_array[1, 1] = trim(sle_pw.Text)

closewithreturn(parent, st_give_temp)
end event

type cb_cancel from commandbutton within w_ftpfile_pw
integer x = 809
integer y = 360
integer width = 457
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±º∏≤√º"
string text = "√Îº“"
end type

event clicked;str_parm st_give_temp

st_give_temp.check = FALSE

closewithreturn(parent, st_give_temp)
end event

type gb_1 from groupbox within w_ftpfile_pw
integer x = 32
integer y = 28
integer width = 1413
integer height = 276
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±º∏≤√º"
boolean italic = true
long textcolor = 33554432
long backcolor = 67108864
string text = "∫Òπ–π¯»£»Æ¿Œ"
end type

