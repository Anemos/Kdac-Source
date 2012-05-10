$PBExportHeader$w_calendar.srw
$PBExportComments$날짜입력을 위한 조회 window (f_calendar 와 같이있어야함)
forward
global type w_calendar from window
end type
type pb_next from picturebutton within w_calendar
end type
type pb_prev from picturebutton within w_calendar
end type
type dw_cal from datawindow within w_calendar
end type
end forward

global type w_calendar from window
integer x = 1422
integer y = 1060
integer width = 914
integer height = 912
boolean titlebar = true
string title = "날짜를 선택하시오."
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "..\BMPs\Note10.ico"
pb_next pb_next
pb_prev pb_prev
dw_cal dw_cal
end type
global w_calendar w_calendar

type variables
Int ii_Day, ii_Month, ii_Year
String is_old_column
String ls_DateFormat
Date id_date_selected
end variables

forward prototypes
public subroutine init_cal (date ad_start_date)
public function integer days_in_month (integer month, integer year)
public subroutine draw_month (integer year, integer month)
public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month)
public function integer highlight_column (string as_column)
public function integer unhighlight_column (string as_column)
end prototypes

public subroutine init_cal (date ad_start_date);Int li_FirstDayNum, li_Cell, li_DaysInMonth
String ls_Year, ls_Month, ls_Return, ls_Cell
Date ld_FirstDay

//Insert a row into the script datawindow
dw_cal.InsertRow(0)

//Set the variables for Day, Month and Year from the date passed to the function
ii_Month = Month(ad_start_date)
ii_Year = Year(ad_start_date)
ii_Day = Day(ad_start_date)

//Find how many days in the relevant month
li_daysinmonth = days_in_month(ii_month, ii_year)

//Find the date of the first day of this month
ld_FirstDay = Date(ii_Year, ii_month, 1)

//What day of the week is the first day of the month
li_FirstDayNum = DayNumber(ld_FirstDay)

//Set the starting "cell" in the datawindow. i.e the column in which
//the first day of the month will be displayed
li_Cell = li_FirstDayNum + ii_Day - 1

//Set the Title of the calendar with the Month and Year
ls_Month = string(ii_Year) + "년 " + string(ii_Month) + "월 "
dw_cal.Object.st_month.text = ls_month

//Enter the numbers of the days
enter_day_numbers(li_FirstDayNum, li_DaysInMonth)

//dw_cal.SetItem(1,li_cell,String(Day(ad_start_date)))

//Define the first Cell as a string
ls_cell = 'cell'+string(li_cell)

//Display the first day in bold (or 3D)
highlight_column (ls_cell)

//Set the instance variable i_old_column to hold the current cell, so
//when we change it, we know the old setting
is_old_column = ls_Cell

end subroutine

public function integer days_in_month (integer month, integer year);//Most cases are straight forward in that there are a fixed number of 
//days in 11 of the 12 months.  February is, of course, the problem.
//In a leap year February has 29 days, otherwise 28.

Int nDaysInMonth

CHOOSE CASE month
	CASE 1, 3, 5, 7, 8, 10, 12
		nDaysInMonth = 31
	CASE 4, 6, 9, 11
		nDaysInMonth = 30
	CASE 2
		If Mod(year,100) = 0 then
			nDaysInMonth = 28
		ElseIf Mod(year,4) = 0 then 
			nDaysInMonth = 29
		Else 
			nDaysInMonth = 28
		End If

END CHOOSE

//Return the number of days in the relevant month
return nDaysInMonth
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
li_daysinmonth = days_in_month(ii_month,ii_year)

//Find the date of the first day in the month
ld_firstday = Date(ii_year,ii_month,1)

//Find what day of the week this is
li_FirstDayNum = DayNumber(ld_firstday)

//Set the first cell
li_cell = li_FirstDayNum + ii_day - 1

//If there was an old column turn off the highlight
unhighlight_column (is_old_column)

//Set the Title
ls_month = string(ii_year) + "년 " + string(ii_month) + "월" 
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

public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month);Int li_count, li_daycount

//Blank the columns before the first day of the month
For li_count = 1 to ai_start_day_num -1
	dw_cal.SetItem(1,li_count,"")
	dw_cal.Modify('cell' + string(li_count) + ".border=0")
Next

//Set the columns for the days to the String of their Day number
For li_count = 1 to ai_days_in_month
	//Use li_daycount to find which column needs to be set
	li_daycount = ai_start_day_num + li_count - 1
	dw_cal.SetItem(1,li_daycount,String(li_count))
	dw_cal.Modify('cell' + string(li_daycount) + ".border=6")
Next

//Blank remainder of columns
For li_count = li_daycount + 1 to 42
	dw_cal.SetItem(1,li_count,"")
	dw_cal.Modify('cell' + string(li_count) + ".border=0")
Next

//If there was an old column turn off the highlight
if dw_cal.describe(is_old_column + ".border") <> '0' then unhighlight_column (is_old_column)

is_old_column = ''


end subroutine

public function integer highlight_column (string as_column);//Highlight the current column/date

string ls_return

ls_return = dw_cal.Modify(as_column + ".border=5")
If ls_return <> "" then 
	MessageBox("Modify",ls_return)
	Return -1
End if

Return 1
end function

public function integer unhighlight_column (string as_column);//If the highlight is on the column set the border of the column back to normal

string ls_return

If as_column <> '' then
	ls_return = dw_cal.Modify(as_column + ".border=6")
	If ls_return <> "" then 
		MessageBox("Modify",ls_return)
		Return -1
	End if
End If

Return 1
end function

event open;date 		ld_date
string	ls_date
Long ll_scr_hor, ll_scr_ver

//윈도를 중앙에에
f_win_center(this)

//Reset the datawindow
reset(dw_cal)

ls_date = message.stringParm

if isNumber(ls_date) then
	if len(ls_date) = 6 then
		ls_date = mid(ls_date, 1, 2) + '/' + mid(ls_date, 3, 2) + '/' + mid(ls_date, 5, 2)
	elseif len(ls_date) = 8 then
		ls_date = mid(ls_date, 1, 4) + '/' + mid(ls_date, 5, 2) + '/' + mid(ls_date, 7, 2)
	end if
end if

if isDate(ls_date) then
	ld_date = date(ls_date)
else
	ld_date = date(string(g_s_date,"@@@@-@@-@@"))
end if


init_cal(ld_date)

dw_cal.setfocus()

end event

on w_calendar.create
this.pb_next=create pb_next
this.pb_prev=create pb_prev
this.dw_cal=create dw_cal
this.Control[]={this.pb_next,&
this.pb_prev,&
this.dw_cal}
end on

on w_calendar.destroy
destroy(this.pb_next)
destroy(this.pb_prev)
destroy(this.dw_cal)
end on

event close;//CloseWithReturn(this, '')
end event

type pb_next from picturebutton within w_calendar
event clicked pbm_bnclicked
integer x = 709
integer y = 32
integer width = 101
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = ".\bmp\next1.bmp"
alignment htextalign = left!
end type

event clicked;//Increment the month number, but if its 13, set back to 1 (January)
ii_month = ii_month + 1
If ii_month = 13 then
	ii_month = 1
	ii_year = ii_year + 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_year) + "/" + string(ii_month) + "/" + string(ii_day))) Then ii_day = 1
	
//Draw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
//sle_date.text = String( id_date_selected, ls_dateFormat )

end event

type pb_prev from picturebutton within w_calendar
event clicked pbm_bnclicked
integer x = 73
integer y = 32
integer width = 101
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean originalsize = true
string picturename = ".\bmp\prior1.bmp"
alignment htextalign = left!
end type

event clicked;//Decrement the month, if 0, set to 12 (December)
ii_month = ii_month - 1
If ii_month = 0 then
	ii_month = 12
	ii_year = ii_year - 1
End If

//check if selected day is no longer valid for new month
If not(isdate(string(ii_year) + "/" + string(ii_month) + "/" + string(ii_day))) Then ii_day = 1

//Darw the month
draw_month ( ii_year, ii_month )

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year,ii_month,ii_Day)
//sle_date.text = String( id_date_selected, ls_dateFormat )

end event

type dw_cal from datawindow within w_calendar
event ue_keydown pbm_dwnkey
integer x = 18
integer y = 20
integer width = 864
integer height = 788
integer taborder = 30
string dataobject = "d_calendar"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;String ls_day

if keyDown(KeyEnter!)  then
	ls_day = dw_cal.GetItemString(1, is_old_column)
	If isNull(ls_day) or ls_day = '' then Return
	ii_day = Integer(ls_day)
	id_date_selected = date(ii_year, ii_month, ii_Day)
	CloseWithReturn(parent, string(id_date_selected,'yyyy-mm-dd'))
end if

if keyDown(KeyEscape!) then close(parent)
end event

event clicked;String ls_clickedcolumn
String ls_day, ls_return
string ls_col_name

IF row < 1 THEN RETURN

//Return if click was not on a valid dwobject, depending on what was
//clicked, dwo will be null or dwo.name will be "datawindow"
If dwo.name = "datawindow" Then Return
If dwo.Type = 'text' Then Return
If string(dwo.id) = '' Then Return

//Find which column was clicked on and return if it is not valid
ls_clickedcolumn = dwo.name
If ls_clickedcolumn = '' Then Return

//Set Day to the text of the clicked column. Return if it is an empty column
ls_day = dwo.primary[1]
If isNull(ls_day) or ls_day = '' then Return

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
//id_date_selected = date(ii_year, ii_month, ii_Day)
//em_date.text = String( id_date_selected, 'yyyy/mm/dd')			///////////////////


//messagebox("dwo.name",string(dwo.name))
//messagebox("dwo.id",string(dwo.id))
//messagebox("dwo.primary[1]",string(dwo.primary[1]))

end event

event doubleclicked;String ls_day

IF row < 1 THEN RETURN

If dwo.name = "datawindow" Then Return
If dwo.Type = 'text' Then Return
If string(dwo.id) = '' Then Return

//Set the Day to the chosen column
ls_day = dwo.primary[1]
If isNull(ls_day) or ls_day = '' then Return
ii_day = Integer(ls_day)

//Return the chosen date into the SingleLineEdit in the chosen format
id_date_selected = date(ii_year, ii_month, ii_Day)

CloseWithReturn(parent, string(id_date_selected,'yyyy-mm-dd'))

end event

