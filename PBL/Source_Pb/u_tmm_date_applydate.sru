$PBExportHeader$u_tmm_date_applydate.sru
$PBExportComments$일자 선택 - 시스템 기준일 - is_uo_date
forward
global type u_tmm_date_applydate from userobject
end type
type st_name from statictext within u_tmm_date_applydate
end type
type pb_next from picturebutton within u_tmm_date_applydate
end type
type pb_prev from picturebutton within u_tmm_date_applydate
end type
type sle_date from singlelineedit within u_tmm_date_applydate
end type
type pb_ddlb from picturebutton within u_tmm_date_applydate
end type
type dw_cal from datawindow within u_tmm_date_applydate
end type
end forward

global type u_tmm_date_applydate from userobject
string tag = "u_today"
integer width = 677
integer height = 84
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
st_name st_name
pb_next pb_next
pb_prev pb_prev
sle_date sle_date
pb_ddlb pb_ddlb
dw_cal dw_cal
end type
global u_tmm_date_applydate u_tmm_date_applydate

type variables
Int		ii_Day, ii_Month, ii_Year
String	is_old_column
String	is_DateFormat
date		id_uo_date
string	is_uo_date

end variables

forward prototypes
public subroutine draw_month (integer year, integer month)
public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month)
public function integer get_month_number (string as_month)
public function string get_month_string (integer as_month)
public function integer highlight_column (string as_column)
public function integer unhighlight_column (string as_column)
public subroutine set_date_format (string as_date_format)
public subroutine init_cal (date ad_start_date)
public function integer days_in_month (integer month, integer year)
end prototypes

event ue_size;GraphicObject	uo_which_control

//If gb_focus Then
//	gb_focus = False
//Else
	uo_which_control = GetFocus() 
	If IsValid(uo_which_control) Then	
		If uo_which_control.Tag = "u_today" Then 
			Return
		Else
			width  = 672
			height = 73
		End If
	End If
//End If
end event

event ue_movefocus;This.SetFocus()
end event

event ue_losefocus;GraphicObject	uo_which_control

//If gb_focus Then
//	gb_focus = False
//Else
	uo_which_control = GetFocus() 
	If IsValid(uo_which_control) Then	
		If uo_which_control.Tag = "u_today" Then 
			Return
		Else
			width  = 672
			height = 73
		End If
	End If
//End If
end event

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
//Do While Date(ii_year,ii_month,ii_day) = Date(00,1,1)
//	ii_day --
//Loop

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
//ls_month = get_month_string(ii_month) + " " + string(ii_year)
ls_Month = string(ii_Year) + "." + get_month_string(ii_Month)
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

public function integer get_month_number (string as_month);Int li_month_number

CHOOSE CASE as_month
	CASE "Jan"
		li_month_number = 1
	CASE "Feb"
		li_month_number = 2
	CASE "Mar"
		li_month_number = 3
	CASE "Apr"
		li_month_number = 4
	CASE "May"
		li_month_number = 5
	CASE "Jun"
		li_month_number = 6
	CASE "Jul"
		li_month_number = 7
	CASE "Aug"
		li_month_number = 8
	CASE "Sep"
		li_month_number = 9
	CASE "Oct"
		li_month_number = 10
	CASE "Nov"
		li_month_number = 11
	CASE "Dec"
		li_month_number = 12
END CHOOSE

return li_month_number
end function

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
//		ls_month = "1 月"
//	CASE 2
//		ls_month = "2 月"
//	CASE 3
//		ls_month = "3 月"
//	CASE 4
//		ls_month = "4 月"
//	CASE 5
//		ls_month = "5 月"
//	CASE 6
//		ls_month = "6 月"
//	CASE 7
//		ls_month = "7 月"
//	CASE 8
//		ls_month = "8 月"
//	CASE 9
//		ls_month = "9 月"
//	CASE 10
//		ls_month = "10 月"
//	CASE 11
//		ls_month = "11 月"
//	CASE 12
//		ls_month = "12 月"
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

public subroutine set_date_format (string as_date_format);is_DateFormat = as_date_format

If Not isnull(id_uo_date) then 
	sle_date.text = string(id_uo_date,is_dateformat)
End If
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
li_daysinmonth = days_in_month(ii_month, ii_year)

//Find the date of the first day of this month
ld_FirstDay = Date(ii_Year, ii_month, 1)

//What day of the week is the first day of the month
li_FirstDayNum = DayNumber(ld_FirstDay)

//Set the starting "cell" in the datawindow. i.e the column in which
//the first day of the month will be displayed
li_Cell = li_FirstDayNum + ii_Day - 1

//Set the Title of the calendar with the Month and Year
//ls_Month = get_month_string(ii_Month) + " " + string(ii_Year)
ls_Month = string(ii_Year) + "." + get_month_string(ii_Month)
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

public function integer days_in_month (integer month, integer year);//Most cases are straight forward in that there are a fixed number of 
//days in 11 of the 12 months.  February is, of course, the problem.
//In a leap year February has 29 days, otherwise 28.

Int nDaysInMonth
Boolean bLeapYear

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

on u_tmm_date_applydate.create
this.st_name=create st_name
this.pb_next=create pb_next
this.pb_prev=create pb_prev
this.sle_date=create sle_date
this.pb_ddlb=create pb_ddlb
this.dw_cal=create dw_cal
this.Control[]={this.st_name,&
this.pb_next,&
this.pb_prev,&
this.sle_date,&
this.pb_ddlb,&
this.dw_cal}
end on

on u_tmm_date_applydate.destroy
destroy(this.st_name)
destroy(this.pb_next)
destroy(this.pb_prev)
destroy(this.sle_date)
destroy(this.pb_ddlb)
destroy(this.dw_cal)
end on

event constructor;width  = 672
height = 73

BringToTop = True
//id_uo_date = Date(f_mpms_get_applydate(f_mpms_get_nowtime()))
id_uo_date = Date(f_tmm_get_nowtime())
is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
init_cal(id_uo_date)
set_date_format ('yyyy.mm.dd')
TriggerEvent("ue_variable_set")
TriggerEvent("ue_select")
end event

type st_name from statictext within u_tmm_date_applydate
integer y = 8
integer width = 224
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기준일: "
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_next from picturebutton within u_tmm_date_applydate
string tag = "u_today"
integer x = 768
integer y = 92
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
id_uo_date = date(ii_year,ii_month,ii_Day)
is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
sle_date.text = String( id_uo_date, is_dateFormat )
Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_select")
Parent.TriggerEvent("ue_valid_check")

end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

type pb_prev from picturebutton within u_tmm_date_applydate
string tag = "u_today"
integer x = 242
integer y = 92
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
id_uo_date = date(ii_year,ii_month,ii_Day)
is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
sle_date.text = String( id_uo_date, is_dateFormat )

Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_select")
Parent.TriggerEvent("ue_valid_check")
end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

type sle_date from singlelineedit within u_tmm_date_applydate
event ue_keyenter pbm_keydown
string tag = "u_today"
integer x = 233
integer width = 361
integer height = 68
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

event ue_keyenter;If KeyDown(KeyEnter!) Then
	Parent.TriggerEvent("ue_movefocus")
End If
end event

event losefocus;//If IsDate(Text) Then
//	Text = String(Date(Text),"yyyy.mm.dd")
//	id_uo_date = date(Text)
//	is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
//	
//	init_cal(date(Text))
//	set_date_format ( 'yyyy.mm.dd' )
//	Parent.TriggerEvent("ue_variable_set")
//	Parent.TriggerEvent("ue_select")
//	Parent.TriggerEvent("ue_valid_check")
//	Parent.TriggerEvent("ue_size")
//Else
//	MessageBox("일자 오류", "잘못된 일자 입니다." + &
//									"~r~n정확한 일자를 입력하십시요." + &
//									"~r~n~r~n일자 입력(예) : 2002.09.09 형식")
//	init_cal(id_uo_date)
//	is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
//	set_date_format ( 'yyyy.mm.dd' )
//	Parent.TriggerEvent("ue_variable_set")
//	Parent.TriggerEvent("ue_select")
//	Parent.TriggerEvent("ue_valid_check")
//	SetFocus()
//End If
//
//Parent.TriggerEvent('ue_losefocus')
end event

event getfocus;String ls_return

Parent.width  = 672
Parent.height = 73
// 2002.09.05 진수가 막음
// sle에 마우스 가져가면 계속 이벤트 발생하니까 짜증...
//Parent.TriggerEvent("ue_variable_set")
//Parent.TriggerEvent("ue_select")

If is_old_column <> '' then
	ls_return = dw_cal.Modify(is_old_Column + ".font.weight='400'")
	If ls_return <> "" then 
//		gb_focus = True
		MessageBox("Modify",ls_return)
	End If
End If

Parent.TriggerEvent('ue_getfocus')
end event

event modified;If IsDate(Text) Then
	Text = String(Date(Text),"yyyy.mm.dd")
	id_uo_date = date(Text)
	is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
	
	init_cal(date(Text))
	set_date_format ( 'yyyy.mm.dd' )
	Parent.TriggerEvent("ue_variable_set")
	Parent.TriggerEvent("ue_select")
	Parent.TriggerEvent("ue_valid_check")
	Parent.TriggerEvent("ue_size")
Else
	MessageBox("일자 오류", "잘못된 일자 입니다." + &
									"~r~n정확한 일자를 입력하십시요." + &
									"~r~n~r~n일자 입력(예) : 2002.09.09 형식")
	init_cal(id_uo_date)
	is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
	set_date_format ( 'yyyy.mm.dd' )
	Parent.TriggerEvent("ue_variable_set")
	Parent.TriggerEvent("ue_select")
	Parent.TriggerEvent("ue_valid_check")
	SetFocus()
End If

Parent.TriggerEvent('ue_losefocus')
end event

type pb_ddlb from picturebutton within u_tmm_date_applydate
event clicked pbm_bnclicked
string tag = "u_today"
integer x = 599
integer y = 4
integer width = 69
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
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
	Parent.width  = 672
	Parent.height = 73
	Parent.TriggerEvent("ue_variable_set")
	Parent.TriggerEvent("ue_select")
	Parent.TriggerEvent("ue_valid_check")
Else

	//Reset the datawindow
	reset(dw_cal)

	// If there is already a date in the edit box then make this the
	// current date in the calendar, otherwise use today
	If ii_day = 0 Then ii_day = 1
	ld_date = date(ii_year, ii_month, ii_day)  // This line used for debugging
	is_uo_date = String(ld_date, 'YYYY.MM.DD')
	init_cal(date(ii_year, ii_month, ii_day))

	Parent.BringToTop = True
	Parent.width  = 855
	Parent.height = 665

//	dw_cal.setfocus()
End If
end event

event losefocus;Parent.TriggerEvent("ue_size")
Parent.TriggerEvent('ue_losefocus')
end event

event getfocus;Parent.TriggerEvent('ue_getfocus')
end event

type dw_cal from datawindow within u_tmm_date_applydate
event ue_downkey pbm_dwnkey
string tag = "u_today"
integer x = 233
integer y = 88
integer width = 617
integer height = 572
integer taborder = 10
string dataobject = "d_tmm_dddw_cal"
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
id_uo_date = date(ii_year, ii_month, ii_Day)
is_uo_date = String(id_uo_date, 'YYYY.MM.DD')
sle_date.text = String( id_uo_date, is_dateformat )
parent.width  = 672
parent.height = 73
Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_select")
Parent.TriggerEvent("ue_valid_check")


end event

event losefocus;Parent.TriggerEvent("ue_size")
end event

