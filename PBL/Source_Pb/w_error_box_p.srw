$PBExportHeader$w_error_box_p.srw
$PBExportComments$error message를 표시화고 출력한다~t
forward
global type w_error_box_p from window
end type
type cb_print from commandbutton within w_error_box_p
end type
type mle_msg from multilineedit within w_error_box_p
end type
type cb_ok from commandbutton within w_error_box_p
end type
end forward

global type w_error_box_p from window
integer x = 681
integer y = 652
integer width = 1824
integer height = 1092
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 81576884
cb_print cb_print
mle_msg mle_msg
cb_ok cb_ok
end type
global w_error_box_p w_error_box_p

on w_error_box_p.create
this.cb_print=create cb_print
this.mle_msg=create mle_msg
this.cb_ok=create cb_ok
this.Control[]={this.cb_print,&
this.mle_msg,&
this.cb_ok}
end on

on w_error_box_p.destroy
destroy(this.cb_print)
destroy(this.mle_msg)
destroy(this.cb_ok)
end on

type cb_print from commandbutton within w_error_box_p
integer x = 974
integer y = 852
integer width = 274
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "굴림"
string text = "출력(&P)"
end type

on clicked;INT	li_job

li_job = PrintOpen()

SetPointer ( hourglass! )

Print(li_job, mle_msg.text)
PrintClose(li_job)

end on

type mle_msg from multilineedit within w_error_box_p
integer x = 55
integer y = 60
integer width = 1682
integer height = 756
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "굴림"
long backcolor = 16777215
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_ok from commandbutton within w_error_box_p
integer x = 526
integer y = 852
integer width = 274
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "굴림"
string text = "확인(&Y)"
boolean default = true
end type

on clicked;Close( parent )
end on

