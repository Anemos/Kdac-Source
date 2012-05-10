$PBExportHeader$w_rtn042u_email_attach.srw
$PBExportComments$Ã·ºÎ³»¿ë[ÀÌ¸ÞÀÏ¹ß¼Û]
forward
global type w_rtn042u_email_attach from window
end type
type mle_1 from multilineedit within w_rtn042u_email_attach
end type
type st_1 from statictext within w_rtn042u_email_attach
end type
type cb_close from commandbutton within w_rtn042u_email_attach
end type
end forward

global type w_rtn042u_email_attach from window
integer x = 302
integer y = 500
integer width = 2098
integer height = 616
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
mle_1 mle_1
st_1 st_1
cb_close cb_close
end type
global w_rtn042u_email_attach w_rtn042u_email_attach

type variables

end variables

on w_rtn042u_email_attach.create
this.mle_1=create mle_1
this.st_1=create st_1
this.cb_close=create cb_close
this.Control[]={this.mle_1,&
this.st_1,&
this.cb_close}
end on

on w_rtn042u_email_attach.destroy
destroy(this.mle_1)
destroy(this.st_1)
destroy(this.cb_close)
end on

event open;f_sysdate()

this.title = message.stringparm
end event

type mle_1 from multilineedit within w_rtn042u_email_attach
integer x = 23
integer y = 84
integer width = 2039
integer height = 308
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rtn042u_email_attach
integer x = 5
integer y = 12
integer width = 453
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
string text = "[Ã·ºÎ ³»¿ë]"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_rtn042u_email_attach
integer x = 1577
integer y = 424
integer width = 485
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
string text = "´Ý±â"
end type

event clicked;string ls_message, ls_modtext
long ll_rtn

ls_message = mle_1.text

ll_rtn = 1
ls_modtext = ls_message
//do while(true)
//	ll_rtn = pos(ls_modtext,"~r",ll_rtn)
//	if ll_rtn = 0 then
//		exit
//	end if
//	ls_modtext = replace(ls_modtext,ll_rtn,1,"</br>")
//	ll_rtn = ll_rtn + 1
//loop

CloseWithReturn(Parent, ls_modtext) 
end event

