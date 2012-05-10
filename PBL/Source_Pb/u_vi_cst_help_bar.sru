$PBExportHeader$u_vi_cst_help_bar.sru
$PBExportComments$window help bar, PGM-ID와 User Message,일자,시간을 표시
forward
global type u_vi_cst_help_bar from userobject
end type
type st_map_id from statictext within u_vi_cst_help_bar
end type
type st_clock from statictext within u_vi_cst_help_bar
end type
type st_msg from statictext within u_vi_cst_help_bar
end type
type st_dumy from statictext within u_vi_cst_help_bar
end type
end forward

global type u_vi_cst_help_bar from userobject
integer width = 3479
integer height = 92
long backcolor = 81576884
long tabtextcolor = 33554432
event documentation pbm_custom75
st_map_id st_map_id
st_clock st_clock
st_msg st_msg
st_dumy st_dumy
end type
global u_vi_cst_help_bar u_vi_cst_help_bar

type variables
window iw_parent_window
integer ii_menu_ht = 0
Boolean ib_show_clock
integer ii_resizeable_offset
end variables

forward prototypes
public subroutine uf_set_msg (string as_msg, long al_textcolor)
public subroutine uf_resized ()
public subroutine uf_init (window aw_win, boolean ab_clock_on, string as_map_id)
public subroutine uf_set_clock ()
end prototypes

event documentation;/*
User Object : u_help_bar
	This is a Microhelp like object than can be dropped on any window
	and used to give information to a user much like using the
	Setmicrohelp function on an MDI Frame window. It 
	automatically places and resizes itself if it is initialized and 
	called from the resize event of the window. It can optionally display
	the date and time in the right hand portion of the bar.
	The developer needs to place the following function calls to the
	object in the appropriate events. If the clock is to be displayed then
	the developer also needs to set a timer event on the window (usually
	for 60 seconds).

Functions :
	init(window,boolean); Called in the open event of the window that it
		is placed on. The first parameter registers the window with the
		object and the second parameter tells the object whether to display
		the date and time or not. Only needs to be called once.
		Usage : init(this,true)
	resize(); Called from the resize event of the parent window. It 
		resizes and moves the bar so that it is always the width of the 
		window and at the bottom of the window.
	set_clock(); Called from the timer event of the parent window. It 
		causes the curent time to be displayed.
	Set_msg(string); Called to display a new message in the left hand
		portion of the bar. Call with an empty string to clear the display.

*/		


         
end event

public subroutine uf_set_msg (string as_msg, long al_textcolor);///////////////////////////////////////////////////////////////////////////
//
// Function:	uf_set_msg
//
//	Purpose:
//
//					Sets the message on the user object to the message
//					passed to this function.  Can be called from any
//					event script in the parent window.
//
// Scope:		public
//
// Parameters:
//					as_msg			:	string
//					al_TextColor	:  글씨색(defalut는 깜장)
//
// Returns : 	None
//
//	DATE			NAME			REVISION
// ----		------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
//////////////////////////////////////////////////////////////////////////
st_msg.TextColor = al_textcolor
st_msg.text = ' '+as_msg

end subroutine

public subroutine uf_resized ();///////////////////////////////////////////////////////////////////////////
//
// Function:	uf_resized
//
//	Purpose:
//
//		This function's primary purpose is correctly place the user
//		object on the window it is placed on.  This function should
//		be called from the parent window's resize event.
//
// Scope:		public
//
// Parameters:
//					None
//
// Returns : 	None
//
//	DATE			NAME		REVISION
// ----		------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
//////////////////////////////////////////////////////////////////////

INT	li_y

//if ii_menu_ht=0 then return // object has not been initialized yet
// using hide then show has less flicker than set redraw off for this
// object when changing the size and moving it.

ii_menu_ht = 1
//hide(this)

// resize the object to the new size of the window
this.width      = iw_parent_window.width

st_msg.width = iw_parent_window.width - st_map_id.width*1.15
st_clock.x   = st_msg.x + st_msg.width - (st_clock.width + st_map_id.x)
st_dumy.width = iw_parent_window.x + st_clock.x + st_clock.width + 20
//li_y = iw_parent_window.height - (this.height+ii_menu_ht) + ii_resizeable_offset
li_y = iw_parent_window.height - (this.height+ii_menu_ht + 100  + ii_resizeable_offset) 
IF iw_parent_window.HScrollBar THEN		//수평scrollbar가 있으면 그 높이만큼 위로
	IF li_y > 100 THEN
		li_y = li_y - 100
	END IF
END IF


// move the object to the bottom of the window
move(this,1,li_y)

show(this)
end subroutine

public subroutine uf_init (window aw_win, boolean ab_clock_on, string as_map_id);///////////////////////////////////////////////////////////////////////////
//
// Function:	uf_init
//
//	Purpose:
//
//		Called in the open event of the window that it is placed on. The
//		first parameter registers the window with the object and the second
//		parameter tells the object whether to display the date and time or
//		not. Only needs to be called once.
//
// Scope:		public
//
// Parameters:
//					aw_win	   :window
//					ab_clock_on	:boolean
//
// Returns : None
//
//	DATE			NAME			REVISION
// ----		------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
//////////////////////////////////////////////////////////////////////////*


iw_parent_window = aw_win

//MAp-ID를 화면에 표시
st_map_id.text = as_map_id

ii_menu_ht = 98

// If the window argument passed is resizable...
if aw_win.resizable then
	ii_resizeable_offset = 0
else
	ii_resizeable_offset = 16
end if

// is the clock shown ?
ib_show_clock = ab_clock_on
if not ib_show_clock then 
	hide(st_clock)
else
	uf_set_clock()
end if

// make it fit on the window properly
uf_resized()


end subroutine

public subroutine uf_set_clock ();///////////////////////////////////////////////////////////////////////////
//
// Function:	uf_set_clock
//
//	Purpose:
//
//		Causes the clock portion of the UO to be refreshed. Is typically 
//    called from the timer event of the window that the user object is
//    on.
//
// Scope:		public
//
// Parameters:
//					None
//
// Returns :   None
//
//	DATE			NAME			REVISION
// ----		------------------------------------------------------------
// Powersoft Corporation	INITIAL VERSION
//
//////////////////////////////////////////////////////////////////////////
INT		li_daynumber		//요일을 숫자로 표시
STRING	ls_dayname			//요일을 한글로( ex. 월, 화, 수... )

//요일 이름 결정
li_daynumber = DayNumber(Today())
CHOOSE CASE li_daynumber
	CASE 1
		ls_dayname = "일"
	CASE 2
		ls_dayname = "월"
	CASE 3
		ls_dayname = "화"
	CASE 4
		ls_dayname = "수"
	CASE 5
		ls_dayname = "목"
	CASE 6
		ls_dayname = "금"
	CASE 7	
		ls_dayname = "토"
	CASE ELSE
		ls_dayname = "？"
END CHOOSE	

st_clock.text = String(Today(),"yyyy년mm월dd일")+ & 
                "(" + ls_dayname + ")" +"  " + &
					 String(Now(),"hh:mm:ss")
end subroutine

on u_vi_cst_help_bar.create
this.st_map_id=create st_map_id
this.st_clock=create st_clock
this.st_msg=create st_msg
this.st_dumy=create st_dumy
this.Control[]={this.st_map_id,&
this.st_clock,&
this.st_msg,&
this.st_dumy}
end on

on u_vi_cst_help_bar.destroy
destroy(this.st_map_id)
destroy(this.st_clock)
destroy(this.st_msg)
destroy(this.st_dumy)
end on

type st_map_id from statictext within u_vi_cst_help_bar
integer x = 5
integer y = 8
integer width = 261
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_clock from statictext within u_vi_cst_help_bar
integer x = 2505
integer y = 8
integer width = 960
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 30264781
boolean enabled = false
string text = "2001년06월04일(월) 19:30:12 "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_msg from statictext within u_vi_cst_help_bar
integer x = 265
integer y = 8
integer width = 3200
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 30264781
boolean enabled = false
string text = " Ready"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_dumy from statictext within u_vi_cst_help_bar
integer width = 3479
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

