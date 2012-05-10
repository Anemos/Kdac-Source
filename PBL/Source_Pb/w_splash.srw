$PBExportHeader$w_splash.srw
$PBExportComments$splash È­¸é
forward
global type w_splash from window
end type
type p_1 from picture within w_splash
end type
end forward

global type w_splash from window
integer width = 2094
integer height = 1232
boolean border = false
windowtype windowtype = popup!
long backcolor = 67108864
p_1 p_1
end type
global w_splash w_splash

on w_splash.create
this.p_1=create p_1
this.Control[]={this.p_1}
end on

on w_splash.destroy
destroy(this.p_1)
end on

event open;f_win_center(this)
end event

type p_1 from picture within w_splash
integer width = 2098
integer height = 1244
string picturename = "pic\KM2000SPLASH.BMP"
boolean focusrectangle = false
end type

