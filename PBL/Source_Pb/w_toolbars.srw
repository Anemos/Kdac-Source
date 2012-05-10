$PBExportHeader$w_toolbars.srw
$PBExportComments$Toolbar Control Window
forward
global type w_toolbars from window
end type
type rb_floating from radiobutton within w_toolbars
end type
type rb_bottom from radiobutton within w_toolbars
end type
type rb_right from radiobutton within w_toolbars
end type
type rb_top from radiobutton within w_toolbars
end type
type rb_left from radiobutton within w_toolbars
end type
type cb_2 from commandbutton within w_toolbars
end type
type cb_visible from commandbutton within w_toolbars
end type
type cbx_showtips from checkbox within w_toolbars
end type
type cbx_showtext from checkbox within w_toolbars
end type
type gb_1 from groupbox within w_toolbars
end type
end forward

global type w_toolbars from window
integer x = 850
integer y = 468
integer width = 1157
integer height = 856
boolean titlebar = true
string title = "Toolbars"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
rb_floating rb_floating
rb_bottom rb_bottom
rb_right rb_right
rb_top rb_top
rb_left rb_left
cb_2 cb_2
cb_visible cb_visible
cbx_showtips cbx_showtips
cbx_showtext cbx_showtext
gb_1 gb_1
end type
global w_toolbars w_toolbars

type variables
/* Current application */
Application  i_application

/* Owning toolbar window */
Window	i_window
end variables

event open;/* Owning toolbar window is passed as reference */
i_window = message.powerobjectparm

/* Note the current application */
i_application = GetApplication ()

/* Set toolbar alignment status */
choose case i_window.toolbaralignment
	case alignatbottom! 
		rb_bottom.checked = true
	case alignatleft!
		rb_left.checked = true
	case alignatright! 
		rb_right.checked = true
	case alignattop! 
		rb_top.checked = true
	case floating!
		rb_floating.checked = true
end choose

/* Set toolbar visible status */
if i_window.toolbarvisible then
	cb_visible.text = "&Hide"
else
	cb_visible.text = "&Show"
end if

/* Set toolbar text mode status */
cbx_showtext.checked = i_application.toolbartext 

/* Set toolbar tips mode status */
cbx_showtips.checked = i_application.toolbartips 

end event

on w_toolbars.create
this.rb_floating=create rb_floating
this.rb_bottom=create rb_bottom
this.rb_right=create rb_right
this.rb_top=create rb_top
this.rb_left=create rb_left
this.cb_2=create cb_2
this.cb_visible=create cb_visible
this.cbx_showtips=create cbx_showtips
this.cbx_showtext=create cbx_showtext
this.gb_1=create gb_1
this.Control[]={this.rb_floating,&
this.rb_bottom,&
this.rb_right,&
this.rb_top,&
this.rb_left,&
this.cb_2,&
this.cb_visible,&
this.cbx_showtips,&
this.cbx_showtext,&
this.gb_1}
end on

on w_toolbars.destroy
destroy(this.rb_floating)
destroy(this.rb_bottom)
destroy(this.rb_right)
destroy(this.rb_top)
destroy(this.rb_left)
destroy(this.cb_2)
destroy(this.cb_visible)
destroy(this.cbx_showtips)
destroy(this.cbx_showtext)
destroy(this.gb_1)
end on

type rb_floating from radiobutton within w_toolbars
integer x = 119
integer y = 476
integer width = 334
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Floating"
end type

event clicked;/* Make toolbar float */
i_window.toolbaralignment = floating!
end event

type rb_bottom from radiobutton within w_toolbars
integer x = 119
integer y = 388
integer width = 315
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Bottom"
end type

event clicked;/* Align toolbar at bottom */
i_window.toolbaralignment = alignatbottom!
end event

type rb_right from radiobutton within w_toolbars
integer x = 119
integer y = 300
integer width = 261
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Right"
end type

event clicked;/* Align toolbar at right */
i_window.toolbaralignment = alignatright!
end event

type rb_top from radiobutton within w_toolbars
integer x = 119
integer y = 212
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Top"
end type

event clicked;/* Align toolbar at top */
i_window.toolbaralignment = alignattop!
end event

type rb_left from radiobutton within w_toolbars
integer x = 119
integer y = 116
integer width = 247
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "&Left"
end type

event clicked;/* Align toolbar at left */
i_window.toolbaralignment = alignatleft!
end event

type cb_2 from commandbutton within w_toolbars
integer x = 663
integer y = 216
integer width = 334
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string text = "&Done"
end type

on clicked;/* Close toolbar configuration window */
Close (parent)
end on

type cb_visible from commandbutton within w_toolbars
integer x = 658
integer y = 72
integer width = 334
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
string text = "&Hide"
boolean default = true
end type

event clicked;/* Indicate opposite toolbar visible status */

//li_rtn2 = w_frame.GetToolbar(2,true)
//	w_frame.SetToolbar(1, false)
//	w_frame.SetToolbar(2, false)

if this.text = "&Hide" then
	i_window.toolbarvisible = False
	this.text = "&Show"
else
	i_window.toolbarvisible = True
	this.text = "&Hide"
end if
end event

type cbx_showtips from checkbox within w_toolbars
integer x = 617
integer y = 616
integer width = 439
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "Show Ti&ps"
end type

event clicked;/* Set toolbar tips mode */
i_application.toolbartips = this.checked 

end event

type cbx_showtext from checkbox within w_toolbars
integer x = 55
integer y = 616
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "Show Te&xt"
end type

event clicked;/* Set toolbar text mode */
i_application.toolbartext = this.checked 

end event

type gb_1 from groupbox within w_toolbars
integer x = 55
integer y = 44
integer width = 507
integer height = 544
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "¸¼Àº °íµñ"
long textcolor = 33554432
long backcolor = 12632256
string text = "Move"
end type

