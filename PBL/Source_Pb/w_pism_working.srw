$PBExportHeader$w_pism_working.srw
$PBExportComments$ÀÛ¾÷Áß Mess
forward
global type w_pism_working from window
end type
type p_1 from picture within w_pism_working
end type
type st_workmess from statictext within w_pism_working
end type
type st_headtext from statictext within w_pism_working
end type
end forward

global type w_pism_working from window
integer x = 1056
integer y = 484
integer width = 2281
integer height = 264
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 12632256
boolean palettewindow = true
p_1 p_1
st_workmess st_workmess
st_headtext st_headtext
end type
global w_pism_working w_pism_working

forward prototypes
public subroutine wf_setmsg (str_pism_msg astr_msg)
public subroutine wf_setmsg (string as_title, string as_workmsg)
end prototypes

public subroutine wf_setmsg (str_pism_msg astr_msg);
//st_headtext.Text = astr_msg.headtext 
This.Title = astr_msg.headtext 
st_workmess.Text = astr_msg.detailtext

end subroutine

public subroutine wf_setmsg (string as_title, string as_workmsg);This.Title = as_title
st_workmess.Text = as_workmsg
end subroutine

on w_pism_working.create
this.p_1=create p_1
this.st_workmess=create st_workmess
this.st_headtext=create st_headtext
this.Control[]={this.p_1,&
this.st_workmess,&
this.st_headtext}
end on

on w_pism_working.destroy
destroy(this.p_1)
destroy(this.st_workmess)
destroy(this.st_headtext)
end on

event open;Str_pism_msg	lstr_msg

lstr_msg		=	message.PowerObjectParm 
f_pisc_win_center_move(This)
//st_headtext.Text = lstr_msg.headtext 
This.Title				=	lstr_msg.headtext  
st_workmess.Text	=	lstr_msg.detailtext

end event

type p_1 from picture within w_pism_working
integer y = 28
integer width = 123
integer height = 88
boolean originalsize = true
string picturename = "c:\kdac\bmp\run.bmp"
boolean focusrectangle = false
end type

type st_workmess from statictext within w_pism_working
integer x = 32
integer y = 60
integer width = 2222
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long backcolor = 12632256
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_headtext from statictext within w_pism_working
boolean visible = false
integer x = 37
integer y = 24
integer width = 2213
integer height = 76
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

