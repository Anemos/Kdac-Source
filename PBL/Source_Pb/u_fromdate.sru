$PBExportHeader$u_fromdate.sru
$PBExportComments$기준일 Calendar DropDownDataWindow SingleLineEditor, Picture Button, External DataWindow
forward
global type u_fromdate from userobject
end type
type pb_next from picturebutton within u_fromdate
end type
type pb_prev from picturebutton within u_fromdate
end type
type sle_date from singlelineedit within u_fromdate
end type
type pb_ddlb from picturebutton within u_fromdate
end type
type dw_cal from datawindow within u_fromdate
end type
end forward

global type u_fromdate from userobject
string tag = "u_fromdate"
integer width = 421
integer height = 80
long backcolor = 79741120
long tabtextcolor = 33554432
long tabbackcolor = 15793151
long picturemaskcolor = 536870912
event ue_variable_set pbm_custom01
event ue_size pbm_custom02
event ue_valid_check pbm_custom03
event ue_movefocus pbm_custom04
event ue_getfocus pbm_custom05
event ue_losefocus pbm_custom06
pb_next pb_next
pb_prev pb_prev
sle_date sle_date
pb_ddlb pb_ddlb
dw_cal dw_cal
end type
global u_fromdate u_fromdate

type variables
Int ii_Day, ii_Month, ii_Year
String is_old_column
String ls_DateFormat
Date id_date_selected

end variables

forward prototypes
public function integer unhighlight_column (string as_column)
public subroutine draw_month (integer year, integer month)
public function integer highlight_column (string as_column)
public function string get_month_string (integer as_month)
public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month)
public subroutine init_cal (date ad_start_date)
public function integer get_month_number (string as_month)
public subroutine set_date_format (string as_date_format)
end prototypes

event ue_size;GraphicObject	uo_which_control

If gb_focus Then
	gb_focus = False
Else
	uo_which_control = GetFocus() 
	If IsValid(uo_which_control) Then	
		If uo_which_control.Tag = "u_fromdate" Then 
			Return
		Else
			width  = 417
			height = 85
		End If
	End If
End If
end event

public function integer unhighlight_column (string as_column);//If the highlight is on the column set the border of the column back to normal

string ls_return

If as_column <> '' then
	ls_return = dw_cal.Modify(as_column + ".border=0")
	If ls_return <> "" then
		gb_focus = True
		MessageBox("Modify",ls_return)
		Return -1
	End if
End If

Return 1
end function

public subroutine draw_month (integer year, integer month);Int  li_FirstDayNum, li_cell, li_daysinmonth
Date ld_firstday
String ls_month, ls_cell, ls_return

//Set Pointer to an Hourglass and turn off redrawing of Calendar
SetPointer(Hourglass!)
SetRedraw(dw_cal,FALSE)

//Set Instance variables to arguments
ii_month = month
ii_year = year

//check in the instance day is valid for month/year 
//back the day down one if invalid for month ie 31 will become 30
Do While Date(ii_year,ii_month,ii_day) = Date(00,1,1)
	ii_day --
Loop

//Work out how many days in the month
li_daysinmonth = f_get_cmms_lastday_of_month(ii_month,ii_year)

//Find the date of the first day in the month
ld_firstday = Date(ii_year,ii_month,1)

//Find what day of the week this is
li_FirstDayNum = DayNumber(ld_firstday)

//Set the first cell
li_cell = li_FirstDayNum + ii_day - 1

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

//Set the Title
ls_month = get_month_string(ii_month) + " " + string(ii_year)
dw_cal.Object.st_month.text = ls_month

//Enter the day numbers into the datawindow
enter_day_numbers(li_FirstDayNum,li_daysinmonth)

//Define the current cell name
ls_cell = 'cell'+string(li_cell)

//Highlight the current date
highlight_column (ls_cell)

//Set the old column for next time
is_old_column = ls_cell

//Reset the pointer and Redraw
SetPointer(Arrow!)
dw_cal.SetRedraw(TRUE)

end subroutine

public function integer highlight_column (string as_column);//Highlight the current column/date

string ls_return

ls_return = dw_cal.Modify(as_column + ".border=5")
If ls_return <> "" then 
	gb_focus = True
	MessageBox("Modify",ls_return)
	Return -1
End if

Return 1
end function

public function string get_month_string (integer as_month);String ls_month

CHOOSE CASE as_month
	CASE 1
		ls_month = "1 월"
	CASE 2
		ls_month = "2 월"
	CASE 3
		ls_month = "3 월"
	CASE 4
		ls_month = "4 월"
	CASE 5
		ls_month = "5 월"
	CASE 6
		ls_month = "6 월"
	CASE 7
		ls_month = "7 월"
	CASE 8
		ls_month = "8 월"
	CASE 9
		ls_month = "9 월"
	CASE 10
		ls_month = "10 월"
	CASE 11
		ls_month = "11 월"
	CASE 12
		ls_month = "12 월"
END CHOOSE

return ls_month
end function

public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month);Int li_count, li_daycount

//Blank the columns before the first day of the month
For li_count = 1 to ai_start_day_num
	dw_cal.SetItem(1,li_count,"")
Next

//Set the columns for the days to the String of their Day number
For li_count = 1 to ai_days_in_month
	//Use li_daycount to find which column needs to be set
	li_daycount = ai_start_day_num + li_count - 1
	dw_cal.SetItem(1,li_daycount,String(li_count))
Next

//Move to next column
li_daycount = li_daycount + 1

//Blank remainder of columns
For li_count = li_daycount to 42
	dw_cal.SetItem(1,li_count,"")
Next

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

is_old_column = ''


end subroutine

public subroutine init_cal (date ad_start_date);Int li_FirstDayNum, li_Cell, li_DaysInMonth
String ls_Year, ls_Month, ls_Return, ls_Cell
Date ld_FirstDay

//Insert a row into the script datawindow
dw_cal.InsertRow(0)

//Set the variables for Day, Month and Year from the date passed to
//the function
ii_Month = Month(ad_start_date)
ii_Year = Year(ad_start_date)
ii_Day = Day(ad_start_date)

//Find how many days in the relevant month
li_daysinmonth = f_get_cmms_lastday_of_month(ii_month, ii_year)

//Find the date of the first day of this month
ld_FirstDay = Date(ii_Year, ii_month, 1)

//What day of the week is the first day of the month
li_FirstDayNum = DayNumber(ld_FirstDay)

//Set the starting "cell" in the datawindow. i.e the column in which
//the first day of the month will be displayed
li_Cell = li_FirstDayNum + ii_Day - 1

//Set the Title of the calendar with the Month and Year
ls_Month = get_month_string(ii_Month) + " " + string(ii_Year)
dw_cal.Object.st_month.text = ls_month

//Enter the numbers of the days
enter_day_numbers(li_FirstDayNum, li_DaysInMonth)

dw_cal.SetItem(1,li_cell,String(Day(ad_start_date)))

//Define the first Cell as a string
ls_cell = 'cell'+string(li_cell)

//Display the first day in bold (or 3D)
highlight_column (ls_cell)

//Set the instance variable i_old_column to hold the current cell, so
//when we change it, we know the old setting
is_old_column = ls_Cell

end subroutine

public function integer get_month_number (string as_month);CHOOSE CASE as_month
	CASE "Jan"
		Return 1
	CASE "Feb"
		Return 2
	CASE "Mar"
		Return 3
	CASE "Apr"
		Return 4
	CASE "May"
		Return 5
	CASE "Jun"
		Return 6
	CASE "Jul"
		Return 7
	CASE "Aug"
		Return 8
	CASE "Sep"
		Return 9
	CASE "Oct"
		Return 10
	CASE "Nov"
		Return 11
	CASE "Dec"
		Return 12
END CHOOSE
end function

public subroutine set_date_format (string as_date_format);ls_DateFormat = as_date_format

If Not isnull(id_date_selected) then 
	sle_date.text = string(id_date_selected,ls_dateformat)
End If
end subroutine

on u_fromdate.create
this.pb_next=create pb_next
this.pb_prev=create pb_prev
this.sle_date=create sle_date
this.pb_ddlb=create pb_ddlb
this.dw_cal=create dw_cal
this.Control[]={this.pb_next,&
this.pb_prev,&
this.sle_date,&
this.pb_ddlb,&
this.dw_cal}
end on

on u_fromdate.destroy
destroy(this.pb_next)
destroy(this.pb_prev)
destroy(this.sle_date)
destroy(this.pb_ddlb)
destroy(this.dw_cal)
end on

event constructor;width  = 417
height = 85

BringToTop = True
id_date_selected	= date(string(date(string(g_s_date,"@@@@-@@-@@")), 'yy.mm') + '.01')
init_cal(id_date_selected)
set_date_format ('yyyy.mm.dd')
TriggerEvent("ue_variable_set")
end event

type pb_next from picturebutton within u_fromdate
string tag = "u_fromdate"
integer x = 535
integer y = 92
integer width = 73
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">"
string picturename = "next1.bmp"
string disabledname = "next1.bmp"
alignment htextalign = left!
end type

event clicked;//Increment the month number, but if its 13, set back to 1 (January)
ii_month = ii_month + 1
If ii_month = 13 then
	ii_month = 1
	ii_year = ii_year + 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_month) + "/" + string(ii_day) + "/"+ string(ii_year))) Then ii_day = 1
	
//Draw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
sle_date.text = String( id_date_selected, ls_dateFormat )
Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_valid_check")

end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

type pb_prev from picturebutton within u_fromdate
string tag = "u_fromdate"
integer x = 9
integer y = 92
integer width = 73
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<"
string picturename = "prior1.bmp"
string disabledname = "prior1.bmp"
alignment htextalign = left!
end type

event clicked;//Decrement the month, if 0, set to 12 (December)
ii_month = ii_month - 1
If ii_month = 0 then
	ii_month = 12
	ii_year = ii_year - 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_month) + "/" + string(ii_day) + "/"+ string(ii_year))) Then ii_day = 1

//Darw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
sle_date.text = String( id_date_selected, ls_dateFormat )

Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_valid_check")
end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

type sle_date from singlelineedit within u_fromdate
event ue_keyenter pbm_keydown
string tag = "u_fromdate"
integer width = 343
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16776960
boolean autohscroll = false
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event ue_keyenter;If KeyDown(KeyEnter!) Then
	Parent.TriggerEvent("ue_movefocus")
End If
end event

event losefocus;If IsDate(Text) Then
	Text = String(Date(Text),"yyyy.mm.dd")
	id_date_selected = date(Text)
	
	init_cal(date(Text))
	set_date_format ( 'yyyy.mm.dd' )
	
	Parent.TriggerEvent("ue_variable_set")
	Parent.TriggerEvent("ue_valid_check")
	Parent.TriggerEvent("ue_size")
Else
	gb_focus = True
	MessageBox("Invalid Date", "일자가 잘못 입력되었습니다...~n~r오늘 날짜로 초기화 합니다 ....")
	init_cal(date(string(g_s_date,"@@@@-@@-@@")))
	id_date_selected = date(string(g_s_date,"@@@@-@@-@@"))
	set_date_format ( 'yyyy.mm.dd' )
	Parent.TriggerEvent("ue_variable_set")
	Parent.TriggerEvent("ue_valid_check")
	SetFocus()	
End If

Parent.TriggerEvent('ue_losefocus')
end event

event getfocus;String ls_return

Parent.width  = 417
Parent.height = 85
Parent.TriggerEvent("ue_variable_set")

If is_old_column <> '' then
	ls_return = dw_cal.Modify(is_old_Column + ".font.weight='400'")
	If ls_return <> "" then 
		gb_focus = True
		MessageBox("Modify",ls_return)
	End If
End If

Parent.TriggerEvent('ue_getfocus')
end event

type pb_ddlb from picturebutton within u_fromdate
event clicked pbm_bnclicked
string tag = "u_fromdate"
integer x = 343
integer width = 73
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "<"
string picturename = "ddlb.bmp"
alignment htextalign = left!
end type

event clicked;//Works as a toggle, if the DropDown is visible, make it invisible
//otherwise make it visible

date 	ld_date

Parent.BringToTop = True

If Parent.height > 85 then
	Parent.width  = 417
	Parent.height = 85
	Parent.TriggerEvent("ue_variable_set")
	Parent.TriggerEvent("ue_valid_check")
Else

	//Reset the datawindow
	reset(dw_cal)

	// If there is already a date in the edit box then make this the
	// current date in the calendar, otherwise use today
	If ii_day = 0 Then ii_day = 1
	ld_date = date(ii_year, ii_month, ii_day)  // This line used for debugging
	init_cal(date(ii_year, ii_month, ii_day))

	Parent.BringToTop = True
	Parent.width  = 618
	Parent.height = 665

	dw_cal.setfocus()
End If
end event

event losefocus;Parent.TriggerEvent("ue_size")
Parent.TriggerEvent('ue_losefocus')
end event

event getfocus;Parent.TriggerEvent('ue_getfocus')
end event

type dw_cal from datawindow within u_fromdate
event ue_downkey pbm_dwnkey
string tag = "u_fromdate"
integer y = 88
integer width = 617
integer height = 572
integer taborder = 10
string dataobject = "d_calendar"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event ue_downkey;//This script will allow someone to use the ctrl right arrow and
//ctrl left arrow key combinations to change the months on
//the calendar

If keydown(keyRightArrow!) and keydown(keyControl!) then
	pb_next.triggerevent(clicked!)
Elseif keydown(keyLeftArrow!) and keydown(keyControl!) then
	pb_prev.triggerevent(clicked!)
End If
end event

event clicked;String ls_clickedcolumn, ls_clickedcolumnID
String ls_day, ls_return
string ls_col_name

//Return if click was not on a valid dwobject, depending on what was
//clicked, dwo will be null or dwo.name will be "datawindow"

If IsNull(dwo) Then Return
If dwo.name = "datawindow" Then Return

//Find which column was clicked on and return if it is not valid
ls_clickedcolumn = dwo.name
If Mid(ls_clickedcolumn,1,4) <> 'cell' Then Return
ls_clickedcolumnID = dwo.id
If ls_clickedcolumn = '' Then Return

//Set Day to the text of the clicked column. Return if it is an empty column
ls_day = dwo.primary[1]
If ls_day = "" then Return

//Convert to a number and place in Instance variable
ii_day = Integer(ls_day)

//If the highlight was on a previous column (is_old_column <> '')
//set the border of the old column back to normal
unhighlight_column (is_old_column)

//Highlight chosen day/column
dwo.border = 5

//Set the old column for next time
is_old_column = ls_clickedcolumn

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year, ii_month, ii_Day)
sle_date.text = String( id_date_selected, ls_dateformat )
parent.width  = 417
parent.height = 85
Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_valid_check")


end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

