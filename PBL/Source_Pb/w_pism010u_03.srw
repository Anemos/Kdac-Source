$PBExportHeader$w_pism010u_03.srw
$PBExportComments$품번, 품명, 규격 FILTER
forward
global type w_pism010u_03 from window
end type
type cb_1 from commandbutton within w_pism010u_03
end type
type sle_1 from singlelineedit within w_pism010u_03
end type
end forward

global type w_pism010u_03 from window
integer width = 1403
integer height = 236
boolean titlebar = true
string title = "찾기 입력윈도우"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
sle_1 sle_1
end type
global w_pism010u_03 w_pism010u_03

on w_pism010u_03.create
this.cb_1=create cb_1
this.sle_1=create sle_1
this.Control[]={this.cb_1,&
this.sle_1}
end on

on w_pism010u_03.destroy
destroy(this.cb_1)
destroy(this.sle_1)
end on

type cb_1 from commandbutton within w_pism010u_03
integer x = 1102
integer y = 16
integer width = 270
integer height = 124
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검색"
end type

type sle_1 from singlelineedit within w_pism010u_03
integer x = 9
integer y = 8
integer width = 1056
integer height = 136
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

