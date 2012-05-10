$PBExportHeader$w_ftpfile_chg.srw
forward
global type w_ftpfile_chg from window
end type
type st_2 from statictext within w_ftpfile_chg
end type
type st_1 from statictext within w_ftpfile_chg
end type
type sle_filedesc from singlelineedit within w_ftpfile_chg
end type
type sle_filenam from singlelineedit within w_ftpfile_chg
end type
type cb_cancel from commandbutton within w_ftpfile_chg
end type
type cb_ok from commandbutton within w_ftpfile_chg
end type
type gb_1 from groupbox within w_ftpfile_chg
end type
end forward

global type w_ftpfile_chg from window
integer width = 2935
integer height = 840
boolean titlebar = true
string title = "파일 수정"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
sle_filedesc sle_filedesc
sle_filenam sle_filenam
cb_cancel cb_cancel
cb_ok cb_ok
gb_1 gb_1
end type
global w_ftpfile_chg w_ftpfile_chg

on w_ftpfile_chg.create
this.st_2=create st_2
this.st_1=create st_1
this.sle_filedesc=create sle_filedesc
this.sle_filenam=create sle_filenam
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.st_1,&
this.sle_filedesc,&
this.sle_filenam,&
this.cb_cancel,&
this.cb_ok,&
this.gb_1}
end on

on w_ftpfile_chg.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_filedesc)
destroy(this.sle_filenam)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_1)
end on

event open;str_parm st_get_temp

//중앙에 Open
f_win_center(this)

st_get_temp = message.powerobjectparm

sle_filenam.Text = trim(st_get_temp.s_parm[1])
sle_filedesc.Text = trim(st_get_temp.s_parm[2])

sle_filenam.setfocus()
end event

type st_2 from statictext within w_ftpfile_chg
integer x = 87
integer y = 332
integer width = 311
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "파일내역"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ftpfile_chg
integer x = 87
integer y = 176
integer width = 261
integer height = 88
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 67108864
string text = "파일명"
boolean focusrectangle = false
end type

type sle_filedesc from singlelineedit within w_ftpfile_chg
integer x = 411
integer y = 312
integer width = 2414
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_filenam from singlelineedit within w_ftpfile_chg
integer x = 416
integer y = 156
integer width = 1166
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_ftpfile_chg
integer x = 1499
integer y = 532
integer width = 457
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
end type

event clicked;str_parm st_give_temp

st_give_temp.check = FALSE

closewithreturn(parent, st_give_temp)
end event

type cb_ok from commandbutton within w_ftpfile_chg
integer x = 864
integer y = 532
integer width = 457
integer height = 128
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "수정"
end type

event clicked;str_parm st_give_temp
String ls_cfnam, ls_cfdesc

ls_cfnam = trim(sle_filenam.Text)
ls_cfdesc = trim(sle_filedesc.Text)

if ls_cfnam = "" or isNull(ls_cfnam) then
	MessageBox("파일명 오류", "파일명을 입력하세요!!", Exclamation!)
	return
end if 

st_give_temp.check = TRUE
st_give_temp.s_parm[1] = trim(sle_filenam.Text)
st_give_temp.s_parm[2] = trim(sle_filedesc.Text)

closewithreturn(parent, st_give_temp)
end event

type gb_1 from groupbox within w_ftpfile_chg
integer x = 50
integer y = 52
integer width = 2811
integer height = 428
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean italic = true
boolean underline = true
long textcolor = 134217730
long backcolor = 67108864
string text = "수정사항"
end type

