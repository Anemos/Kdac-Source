$PBExportHeader$u_progress_bar_pur.sru
$PBExportComments$Progress meter, similar to the ones found in the Setup programs.
forward
global type u_progress_bar_pur from userobject
end type
type st_1 from statictext within u_progress_bar_pur
end type
type rc_2 from rectangle within u_progress_bar_pur
end type
end forward

global type u_progress_bar_pur from userobject
integer width = 1211
integer height = 76
boolean border = true
long backcolor = 16777215
long tabtextcolor = 33554432
st_1 st_1
rc_2 rc_2
end type
global u_progress_bar_pur u_progress_bar_pur

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
if Int (ac_pct_complete) = 0 then
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

on u_progress_bar_pur.create
this.st_1=create st_1
this.rc_2=create rc_2
this.Control[]={this.st_1,&
this.rc_2}
end on

on u_progress_bar_pur.destroy
destroy(this.st_1)
destroy(this.rc_2)
end on

type st_1 from statictext within u_progress_bar_pur
integer x = 517
integer y = 4
integer width = 137
integer height = 64
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 16777215
string text = "0%"
long bordercolor = 16711680
boolean focusrectangle = false
end type

type rc_2 from rectangle within u_progress_bar_pur
boolean visible = false
long linecolor = 16711680
integer linethickness = 4
long fillcolor = 16711680
integer width = 32
integer height = 144
end type

