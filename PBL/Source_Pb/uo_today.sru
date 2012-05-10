$PBExportHeader$uo_today.sru
$PBExportComments$select date
forward
global type uo_today from userobject
end type
type st_2 from statictext within uo_today
end type
type st_1 from statictext within uo_today
end type
type pb_next from picturebutton within uo_today
end type
type pb_prev from picturebutton within uo_today
end type
type dw_cal from datawindow within uo_today
end type
type pb_ddlb from picturebutton within uo_today
end type
type sle_date from singlelineedit within uo_today
end type
end forward

global type uo_today from userobject
string tag = "u_today"
integer width = 265
integer height = 140
long backcolor = 32827087
long tabtextcolor = 33554432
long tabbackcolor = 15793151
long picturemaskcolor = 536870912
event ue_variable_set pbm_custom01
event ue_size pbm_custom02
event ue_valid_check pbm_custom03
event ue_movefocus pbm_custom04
event ue_getfocus pbm_custom05
event ue_losefocus pbm_custom06
event ue_test pbm_bnclicked
st_2 st_2
st_1 st_1
pb_next pb_next
pb_prev pb_prev
dw_cal dw_cal
pb_ddlb pb_ddlb
sle_date sle_date
end type
global uo_today uo_today

type variables
Int ii_Day, ii_Month, ii_Year
String is_old_column
String ls_DateFormat
Date id_date_selected

end variables

forward prototypes
public subroutine draw_month (integer year, integer month)
public subroutine enter_day_numbers (integer ai_start_day_num, integer ai_days_in_month)
public function integer get_month_number (string as_month)
public function string get_month_string (integer as_month)
public function integer highlight_column (string as_column)
public subroutine set_date_format (string as_date_format)
public function integer unhighlight_column (string as_column)
public subroutine init_cal (date ad_start_date)
public function integer days_in_month (integer month, integer year)
end prototypes

event ue_size;//GraphicObject	uo_which_control
//
//If gb_focus Then
//	gb_focus = False
//Else
//	uo_which_control = GetFocus() 
//	If IsValid(uo_which_control) Then	
//		If uo_which_control.Tag = "u_today" Then 
//			Return
//		Else
//			width  = 266
//			height = 137
//		End If
//	End If
//End If
end event

event ue_test;pb_ddlb.Triggerevent("clicked")
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

public subroutine set_date_format (string as_date_format);ls_DateFormat = as_date_format

If Not isnull(id_date_selected) then 
	sle_date.text = string(id_date_selected,ls_dateformat)
End If
end subroutine

public function integer unhighlight_column (string as_column);//If the highlight is on the column set the border of the column back to normal

string ls_return

If as_column <> '' then
	ls_return = dw_cal.Modify(as_column + ".border=6")
	If ls_return <> "" then
		gb_focus = True
		MessageBox("Modify",ls_return)
		Return -1
	End if
End If

Return 1
end function

public subroutine init_cal (date ad_start_date);Int		li_FirstDayNum, li_Cell, li_DaysInMonth
String	ls_Year, ls_Month, ls_Return, ls_Cell
Date		ld_FirstDay

//Insert a row into the script datawindow
dw_cal.InsertRow(0)

//Set the variables for Day, Month and Year from the date passed to
//the function
ii_Month	= Month(ad_start_date)
ii_Year	= Year(ad_start_date)
ii_Day	= Day(ad_start_date)

//Find how many days in the relevant month
li_DaysInMonth	= days_in_month(ii_month, ii_year)

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

		If Mod(year,100) = 0 And year <> 2000 then
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

on uo_today.create
this.st_2=create st_2
this.st_1=create st_1
this.pb_next=create pb_next
this.pb_prev=create pb_prev
this.dw_cal=create dw_cal
this.pb_ddlb=create pb_ddlb
this.sle_date=create sle_date
this.Control[]={this.st_2,&
this.st_1,&
this.pb_next,&
this.pb_prev,&
this.dw_cal,&
this.pb_ddlb,&
this.sle_date}
end on

on uo_today.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_next)
destroy(this.pb_prev)
destroy(this.dw_cal)
destroy(this.pb_ddlb)
destroy(this.sle_date)
end on

event constructor;STRING	ls_applydate_close

DATETIME	ld_server_datetime

// 높이,넓비
width  = 266
height = 137

// 최상위
BringToTop = True

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ld_server_datetime	= DATETIME(TODAY(),NOW())

ls_applydate_close	= f_mpms_get_applydate(ld_server_datetime)

id_date_selected		= Date(ls_applydate_close)

//MESSAGEBOX('id_date_selected',STRING(id_date_selected))

init_cal(id_date_selected)


set_date_format ('yyyy.mm.dd')
TriggerEvent("ue_variable_set")

end event

type st_2 from statictext within uo_today
integer x = 1051
integer y = 168
integer width = 311
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "다음 달 ▶"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_today
integer x = 453
integer y = 168
integer width = 325
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "◀ 이전 달"
boolean focusrectangle = false
end type

type pb_next from picturebutton within uo_today
string tag = "u_today"
integer x = 1381
integer y = 148
integer width = 407
integer height = 204
integer textsize = -26
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "▶"
string picturename = "bmp\background.gif"
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

type pb_prev from picturebutton within uo_today
string tag = "u_today"
integer x = 18
integer y = 148
integer width = 407
integer height = 204
integer textsize = -26
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "◀"
string picturename = "bmp\background.gif"
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

type dw_cal from datawindow within uo_today
event ue_downkey pbm_dwnkey
string tag = "u_today"
integer y = 140
integer width = 1801
integer height = 1612
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

string ls_ret_date

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

ls_ret_date = string(id_date_selected,"yyyy.mm.dd")

sle_date.text = ls_ret_date

//IF w_mpsg010b.pb_keycode.enabled THEN
//
//	// 분할 LOT 정보 갱신
//	w_pisg090i.em_search_date.TriggerEvent("ue_date_change")
//ELSE
//	// 계획대비 생산실적 정보 갱신
//	w_pisg080i.em_search_date.TriggerEvent("ue_date_change")
//END IF
//w_mpsg050u.dw_mpsg050u_01.setitem(1,"as_workdate",ls_ret_date)

parent.width  = 266
parent.height = 137
Parent.TriggerEvent("ue_variable_set")
Parent.TriggerEvent("ue_valid_check")

end event
event losefocus;Parent.TriggerEvent("ue_size")
end event

type pb_ddlb from picturebutton within uo_today
event clicked pbm_bnclicked
string tag = "u_today"
integer width = 265
integer height = 136
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "▼"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;//Works as a toggle, if the DropDown is visible, make it invisible
//otherwise make it visible

date 	ld_date

Parent.BringToTop = True

If Parent.height > 230 then
	Parent.width  = 266
	Parent.height = 137
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
	Parent.width  = 1797
	Parent.height = 1736

	dw_cal.setfocus()
End If
end event

event losefocus;Parent.TriggerEvent("ue_size")
Parent.TriggerEvent('ue_losefocus')
end event

event getfocus;Parent.TriggerEvent('ue_getfocus')
end event

type sle_date from singlelineedit within uo_today
event ue_keyenter pbm_keydown
string tag = "u_today"
integer x = 37
integer y = 8
integer width = 192
integer height = 124
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16776960
boolean border = false
boolean autohscroll = false
integer limit = 10
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
	init_cal(today())
	id_date_selected = today()
	set_date_format ( 'yyyy.mm.dd' )
	Parent.TriggerEvent("ue_variable_set")
	Parent.TriggerEvent("ue_valid_check")
	SetFocus()	
End If

Parent.TriggerEvent('ue_losefocus')
end event

event getfocus;String ls_return

Parent.width  = 919
Parent.height = 213
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

