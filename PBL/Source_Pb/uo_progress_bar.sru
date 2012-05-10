$PBExportHeader$uo_progress_bar.sru
$PBExportComments$Progress meter, similar to the ones found in the Setup programs.
forward
global type uo_progress_bar from userobject
end type
type st_1 from statictext within uo_progress_bar
end type
type rc_2 from rectangle within uo_progress_bar
end type
end forward

global type uo_progress_bar from userobject
integer width = 1495
integer height = 100
boolean border = true
long backcolor = 16777215
long tabtextcolor = 33554432
st_1 st_1
rc_2 rc_2
end type
global uo_progress_bar uo_progress_bar

type variables
// Determines if the progress bar has touched the 
// percentage text
boolean    ib_invert
end variables

forward prototypes
public subroutine uf_set_position (decimal ac_pct_complete)
end prototypes

public subroutine uf_set_position (decimal ac_pct_complete);//////////////////////////////////////////////////////////////////////
//
// Function: uf_set_position
//
// Purpose: expands the progress meter and updates the percentage
//				to the percentage argument passed to this function
//
//	Scope: public
//
//	Arguments: ac_pct_complete		the percentage that the progress meter
//											should be set to
//	
//	Returns: none
//
//////////////////////////////////////////////////////////////////////

long	ll_color


//////////////////////////////////////////////////////////////////////
// Reset instance variable and colors if progress meter has been restarted
//////////////////////////////////////////////////////////////////////
if 	Int (ac_pct_complete) = 0 then
	ib_invert = false
	st_1.TextColor = RGB (0, 0, 255)
	st_1.BackColor = RGB (255, 255, 255)	
end if


//////////////////////////////////////////////////////////////////////
// expand the progess bar
//////////////////////////////////////////////////////////////////////
rc_2.width = ac_pct_complete / 100.0 * this.width
rc_2.visible = true

//////////////////////////////////////////////////////////////////////
// update the percentage text
//////////////////////////////////////////////////////////////////////
st_1.text = String (ac_pct_complete / 100.0, "##0%")


//////////////////////////////////////////////////////////////////////
// check to see if the progress bar touches the percentage text.  
// If so, invert the percentage text colors.
//////////////////////////////////////////////////////////////////////
if not ib_invert then
	if rc_2.width >= st_1.x then
		ib_invert = true
		ll_color = st_1.textcolor
		st_1.TextColor = st_1.BackColor
		st_1.BackColor = ll_color
	end if
end if
end subroutine

on uo_progress_bar.create
this.st_1=create st_1
this.rc_2=create rc_2
this.Control[]={this.st_1,&
this.rc_2}
end on

on uo_progress_bar.destroy
destroy(this.st_1)
destroy(this.rc_2)
end on

event constructor;st_1.x = (this.width  - st_1.width ) / 2
st_1.y = (this.height - st_1.height) / 2
 
end event

type st_1 from statictext within uo_progress_bar
integer x = 649
integer y = 12
integer width = 192
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 16711680
long backcolor = 16777215
string text = "0%"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type rc_2 from rectangle within uo_progress_bar
boolean visible = false
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 16711680
integer width = 32
integer height = 144
end type

