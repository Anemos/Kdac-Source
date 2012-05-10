$PBExportHeader$uo_today_bom_win.sru
$PBExportComments$¿œ¿⁄ º±≈√ - ±›¿œ - is_uo_date
forward
global type uo_today_bom_win from userobject
end type
type pb_next from picturebutton within uo_today_bom_win
end type
type pb_prev from picturebutton within uo_today_bom_win
end type
type pb_ddlb from picturebutton within uo_today_bom_win
end type
type dw_cal from datawindow within uo_today_bom_win
end type
end forward

global type uo_today_bom_win from userobject
string tag = "u_today"
integer width = 631
integer height = 612
long backcolor = 12632256
long tabtextcolor = 33554432
long tabbackcolor = 15793151
long picturemaskcolor = 536870912
event ue_variable_set pbm_custom01
event ue_size pbm_custom02
event ue_valid_check pbm_custom03
event ue_movefocus pbm_custom04
event ue_getfocus pbm_custom05
event ue_losefocus pbm_custom06
event ue_select pbm_custom07
event ue_keydown pbm_keydown
pb_next pb_next
pb_prev pb_prev
pb_ddlb pb_ddlb
dw_cal dw_cal
end type
global uo_today_bom_win uo_today_bom_win

type variables
Int		in_Day, in_Month, in_Year
String	is_old_column
String	is_DateFormat
date		id_uo_date
string	is_uo_date

end variables

forward prototypes
public function string get_month_string (integer as_month)
public function integer highlight_column (string as_column)
public function integer unhighlight_column (string as_column)
public function integer days_in_month (integer month, integer year)
public subroutine draw_month (integer year, integer month)
public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month)
public function integer get_month_number (string as_month)
public subroutine init_cal (date ad_start_date)
public subroutine set_date_format (string as_date_format)
end prototypes

public function string get_month_string (integer as_month);String ls_month

CHOOSE CASE as_month
	CASE 1
		ls_month = "01"
	CASE 2
		ls_month = "02"
	CASE 3
		ls_month = "03"
	CASE 4
		ls_month = "04"
	CASE 5
		ls_month = "05"
	CASE 6
		ls_month = "06"
	CASE 7
		ls_month = "07"
	CASE 8
		ls_month = "08"
	CASE 9
		ls_month = "09"
	CASE 10
		ls_month = "10 "
	CASE 11
		ls_month = "11"
	CASE 12
		ls_month = "12"
END CHOOSE

return ls_month


//String ls_month
//
//CHOOSE CASE as_month
//	CASE 1
//		ls_month = "1 Í≈"
//	CASE 2
//		ls_month = "2 Í≈"
//	CASE 3
//		ls_month = "3 Í≈"
//	CASE 4
//		ls_month = "4 Í≈"
//	CASE 5
//		ls_month = "5 Í≈"
//	CASE 6
//		ls_month = "6 Í≈"
//	CASE 7
//		ls_month = "7 Í≈"
//	CASE 8
//		ls_month = "8 Í≈"
//	CASE 9
//		ls_month = "9 Í≈"
//	CASE 10
//		ls_month = "10 Í≈"
//	CASE 11
//		ls_month = "11 Í≈"
//	CASE 12
//		ls_month = "12 Í≈"
//END CHOOSE
//
//return ls_month
end function

public function integer highlight_column (string as_column);//Highlight the current column/date

string ls_return

ls_return = dw_cal.Modify(as_column + ".border=5")
If ls_return <> "" then 
//	gb_focus = True
	MessageBox("Modify",ls_return)
	Return -1
End if

Return 1
end function

public function integer unhighlight_column (string as_column);//If the highlight is on the column set the border of the column back to normal

string ls_return

If as_column <> '' then
	ls_return = dw_cal.Modify(as_column + ".border=0")
	If ls_return <> "" then
//		gb_focus = True
		MessageBox("Modify",ls_return)
		Return -1
	End if
End If

Return 1
end function

public function integer days_in_month (integer month, integer year);//Most cases are straight forward in that there are a fixed number of 
//days in 11 of the 12 months.  February is, of course, the problem.
//In a leap year February has 29 days, otherwise 28.

Int 		nDaysInMonth
Boolean 	bLeapYear

CHOOSE CASE month
	CASE 1, 3, 5, 7, 8, 10, 12
		nDaysInMonth = 31
	CASE 4, 6, 9, 11
		nDaysInMonth = 30
	CASE 2
	//If a year is divisible by 100 without a remainder, then it is
	//NOT a leap year

		If Mod(year,100) = 0 then
			bLeapYear = False

	//If the year is not divisible by 100, but is by 4 then it is a
	//leap year

		ElseIf Mod(year,4) = 0 then 
			bLeapYear = True

	//If neither case is true then it is not a leap year

		Else 
			bLeapYear = False
		End If

	//If it is a leap year, February has 29 days, otherwise 28

		If bLeapYear then
			nDaysInMonth = 29
		Else
			nDaysInMonth = 28
		End If

END CHOOSE

//Return the number of days in the relevant month
return nDaysInMonth
end function

public subroutine draw_month (integer year, integer month);Int  		ln_FirstDayNum, ln_cell, ln_daysinmonth
Date 		ld_firstday
String 	ls_month, ls_cell, ls_return

//Set Pointer to an Hourglass and turn off redrawing of Calendar
SetPointer(Hourglass!)
SetRedraw(dw_cal,FALSE)

//Set Instance variables to arguments
in_month = month
in_year = year

//check in the instance day is valid for month/year 
//back the day down one if invalid for month ie 31 will become 30
//Do While Date(in_year,in_month,in_day) = Date(00,1,1)
//	in_day --
//Loop

//Work out how many days in the month
ln_daysinmonth = days_in_month(in_month,in_year)

//Find the date of the first day in the month
ld_firstday = Date(in_year,in_month,1)

//Find what day of the week this is
ln_FirstDayNum = DayNumber(ld_firstday)

//Set the first cell
ln_cell = ln_FirstDayNum + in_day - 1

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

//Set the Title
//ls_month = get_month_string(in_month) + " " + string(in_year)
ls_Month = string(in_Year) + "." + get_month_string(in_Month)
dw_cal.Object.st_month.text = ls_month

//Enter the day numbers into the datawindow
enter_day_numbers(ln_FirstDayNum,ln_daysinmonth)

//Define the current cell name
ls_cell = 'cell'+string(ln_cell)

//Highlight the current date
highlight_column (ls_cell)

//Set the old column for next time
is_old_column = ls_cell

//Reset the pointer and Redraw
SetPointer(Arrow!)
dw_cal.SetRedraw(TRUE)

end subroutine

public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month);Int ln_count, ln_daycount

//Blank the columns before the first day of the month
For ln_count = 1 to ai_start_day_num
	dw_cal.SetItem(1,ln_count,"")
Next

//Set the columns for the days to the String of their Day number
For ln_count = 1 to ai_days_in_month
	//Use ln_daycount to find which column needs to be set
	ln_daycount = ai_start_day_num + ln_count - 1
	dw_cal.SetItem(1,ln_daycount,String(ln_count))
Next

//Move to next column
ln_daycount = ln_daycount + 1

//Blank remainder of columns
For ln_count = ln_daycount to 42
	dw_cal.SetItem(1,ln_count,"")
Next

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

is_old_column = ''


end subroutine

public function integer get_month_number (string as_month);Int ln_month_number

CHOOSE CASE as_month
	CASE "Jan"
		ln_month_number = 1
	CASE "Feb"
		ln_month_number = 2
	CASE "Mar"
		ln_month_number = 3
	CASE "Apr"
		ln_month_number = 4
	CASE "May"
		ln_month_number = 5
	CASE "Jun"
		ln_month_number = 6
	CASE "Jul"
		ln_month_number = 7
	CASE "Aug"
		ln_month_number = 8
	CASE "Sep"
		ln_month_number = 9
	CASE "Oct"
		ln_month_number = 10
	CASE "Nov"
		ln_month_number = 11
	CASE "Dec"
		ln_month_number = 12
END CHOOSE

return ln_month_number
end function

public subroutine init_cal (date ad_start_date);Int 		ln_FirstDayNum,ln_Cell,ln_DaysInMonth
String 	ls_Year, ls_Month, ls_Return, ls_Cell
Date 		ld_FirstDay

//Insert a row into the script datawindow
dw_cal.InsertRow(0)
//Set the variables for Day, Month and Year from the date passed to
//the function
in_Month = Month(ad_start_date)
in_Year 	= Year(ad_start_date)
in_Day 	= Day(ad_start_date)
//Find how many days in the relevant month
ln_daysinmonth = days_in_month(in_month, in_year)
//Find the date of the first day of this month
ld_FirstDay 	= Date(in_Year, in_month, 1)
//What day of the week is the first day of the month
ln_FirstDayNum = DayNumber(ld_FirstDay)
//Set the starting "cell" in the datawindow. i.e the column in which
//the first day of the month will be displayed
ln_Cell 			= ln_FirstDayNum + in_Day - 1
//Set the Title of the calendar with the Month and Year
//ls_Month = get_month_string(in_Month) + " " + string(in_Year)
ls_Month 		= string(in_Year) + "." + get_month_string(in_Month)
dw_cal.Object.st_month.text = ls_month
//Enter the numbers of the days
enter_day_numbers(ln_FirstDayNum, ln_DaysInMonth)
dw_cal.SetItem(1,ln_cell,String(Day(ad_start_date)))
//Define the first Cell as a string
ls_cell = 'cell'+string(ln_cell)
//Display the first day in bold (or 3D)
highlight_column (ls_cell)
//Set the instance variable i_old_column to hold the current cell, so
//when we change it, we know the old setting
is_old_column = ls_Cell

end subroutine

public subroutine set_date_format (string as_date_format);is_DateFormat = as_date_format

If Not isnull(id_uo_date) then 
//	sle_date.text = string(id_uo_date,is_dateformat)
End If
end subroutine

on uo_today_bom_win.create
this.pb_next=create pb_next
this.pb_prev=create pb_prev
this.pb_ddlb=create pb_ddlb
this.dw_cal=create dw_cal
this.Control[]={this.pb_next,&
this.pb_prev,&
this.pb_ddlb,&
this.dw_cal}
end on

on uo_today_bom_win.destroy
destroy(this.pb_next)
destroy(this.pb_prev)
destroy(this.pb_ddlb)
destroy(this.dw_cal)
end on

event constructor;BringToTop = True

DateTime	ld_now
select current_timestamp into :ld_now	from  pbcommon.comm000 using sqlca ;
id_uo_date = Date(ld_now)
is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
init_cal(id_uo_date)
set_date_format ('yyyy.mm.dd')
pb_ddlb.triggerevent("clicked")
end event

type pb_next from picturebutton within uo_today_bom_win
string tag = "u_today"
integer x = 535
integer y = 28
integer width = 73
integer height = 88
integer taborder = 20
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\arrow_next.bmp"
alignment htextalign = left!
end type

event clicked;//Increment the month number, but if its 13, set back to 1 (January)
in_month = in_month + 1
If in_month = 13 then
	in_month = 1
	in_year 	= in_year + 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(in_month) + "/" + string(in_day) + "/"+ string(in_year))) Then in_day = 1
	
//Draw the month
draw_month ( in_year, in_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_uo_date 		= date(in_year,in_month,in_Day)
is_uo_date 		= String(id_uo_date, 'YYYY.MM.DD')
//sle_date.text 	= String( id_uo_date, is_dateFormat )
Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_select")
Parent.TriggerEvent("ue_valid_check")

end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

type pb_prev from picturebutton within uo_today_bom_win
string tag = "u_today"
integer x = 9
integer y = 28
integer width = 73
integer height = 88
integer taborder = 30
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\arrow_prior.bmp"
alignment htextalign = left!
end type

event clicked;//Decrement the month, if 0, set to 12 (December)
in_month = in_month - 1
If in_month = 0 then
	in_month = 12
	in_year 	= in_year - 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(in_month) + "/" + string(in_day) + "/"+ string(in_year))) Then in_day = 1

//Darw the month
draw_month ( in_year, in_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_uo_date 		= date(in_year,in_month,in_Day)
is_uo_date 		= String(id_uo_date, 'YYYY.MM.DD')
//sle_date.text 	= String( id_uo_date, is_dateFormat )

Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_select")
Parent.TriggerEvent("ue_valid_check")
end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

type pb_ddlb from picturebutton within uo_today_bom_win
event clicked pbm_bnclicked
string tag = "u_today"
boolean visible = false
integer x = 402
integer y = 320
integer width = 73
integer height = 60
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string picturename = "C:\KDAC\bmp\arrow_ddlb.bmp"
alignment htextalign = left!
end type

event clicked;//Works as a toggle, if the DropDown is visible, make it invisible
//otherwise make it visible
date 	ld_date

Parent.BringToTop = True
If Parent.height > 73 then
	Parent.width  = 439
	Parent.height = 73
	Parent.TriggerEvent("ue_variable_set")
	Parent.TriggerEvent("ue_select")
	Parent.TriggerEvent("ue_valid_check")
Else
	//Reset the datawindow
	reset(dw_cal)
	// If there is already a date in the edit box then make this the
	// current date in the calendar, otherwise use today
	If in_day = 0 Then in_day = 1
	ld_date = date(in_year, in_month, in_day)  // This line used for debugging
	is_uo_date = String(ld_date, 'YYYY.MM.DD')
	init_cal(date(in_year, in_month, in_day))

	Parent.BringToTop = True
	Parent.width  		= 622
	Parent.height 		= 664

//	dw_cal.setfocus()
End If
end event

event losefocus;Parent.TriggerEvent("ue_size")
Parent.TriggerEvent('ue_losefocus')
end event

event getfocus;Parent.TriggerEvent('ue_getfocus')
end event

type dw_cal from datawindow within uo_today_bom_win
event ue_downkey pbm_dwnkey
string tag = "u_today"
integer y = 24
integer width = 617
integer height = 572
integer taborder = 10
string dataobject = "dddw_calendar_bom"
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

event clicked;String ls_clickedcolumn,ls_clickedcolumnID
String ls_day,ls_return
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
in_day = Integer(ls_day)

//If the highlight was on a previous column (is_old_column <> '')
//set the border of the old column back to normal
unhighlight_column (is_old_column)

//Highlight chosen day/column
dwo.border = 5

//Set the old column for next time
is_old_column = ls_clickedcolumn

//Return the chosen date into the SingleLineEdit in the chosen format
id_uo_date 		= date(in_year, in_month, in_Day)
is_uo_date 		= String(id_uo_date, 'YYYY.MM.DD')
//Parent.TriggerEvent("ue_variable_set")
//Parent.TriggerEvent("ue_select")
//Parent.TriggerEvent("ue_valid_check")


end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

