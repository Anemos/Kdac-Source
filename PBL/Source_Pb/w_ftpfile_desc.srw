$PBExportHeader$w_ftpfile_desc.srw
forward
global type w_ftpfile_desc from window
end type
type cb_cancel from commandbutton within w_ftpfile_desc
end type
type cb_ok from commandbutton within w_ftpfile_desc
end type
type sle_desc from singlelineedit within w_ftpfile_desc
end type
type gb_1 from groupbox within w_ftpfile_desc
end type
end forward

global type w_ftpfile_desc from window
integer width = 2898
integer height = 692
boolean titlebar = true
string title = "파일 내역"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
sle_desc sle_desc
gb_1 gb_1
end type
global w_ftpfile_desc w_ftpfile_desc

on w_ftpfile_desc.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_desc=create sle_desc
this.gb_1=create gb_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.sle_desc,&
this.gb_1}
end on

on w_ftpfile_desc.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_desc)
destroy(this.gb_1)
end on

event open;str_parm st_get_temp

//중앙에 Open
f_win_center(this)

st_get_temp = message.powerobjectparm

gb_1.Text = trim(st_get_temp.s_parm[1])
sle_desc.setfocus()
end event

event key;IF keyflags = 0 THEN
	IF key = KeyEnter! THEN
		cb_ok.TriggerEvent('clicked')
	end if
END IF
end event

type cb_cancel from commandbutton within w_ftpfile_desc
integer x = 1467
integer y = 392
integer width = 475
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "업로드 취소"
end type

event clicked;str_parm st_give_temp

st_give_temp.check = FALSE

closewithreturn(parent, st_give_temp)
end event

type cb_ok from commandbutton within w_ftpfile_desc
integer x = 841
integer y = 392
integer width = 475
integer height = 128
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입력"
end type

event clicked;str_parm st_give_temp

st_give_temp.check = TRUE
st_give_temp.s_array[1, 1] = trim(sle_desc.Text)

closewithreturn(parent, st_give_temp)
end event

type sle_desc from singlelineedit within w_ftpfile_desc
event ue_downenter pbm_keydown
integer x = 46
integer y = 148
integer width = 2770
integer height = 132
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

event ue_downenter;IF KeyDown(KeyEnter!) THEN 
	cb_ok.triggerevent("clicked")
end if
end event

type gb_1 from groupbox within w_ftpfile_desc
integer x = 23
integer y = 40
integer width = 2825
integer height = 284
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean italic = true
boolean underline = true
long textcolor = 16711680
long backcolor = 67108864
end type

