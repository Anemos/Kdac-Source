$PBExportHeader$w_pisp020u.srw
$PBExportComments$Work Calendar
forward
global type w_pisp020u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp020u
end type
type uo_area from u_pisc_select_area within w_pisp020u
end type
type uo_division from u_pisc_select_division within w_pisp020u
end type
type uo_month from u_pisc_date_scroll_month within w_pisp020u
end type
type cb_1 from commandbutton within w_pisp020u
end type
type dw_workgubun from datawindow within w_pisp020u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp020u
end type
type uo_line from u_pisc_select_line within w_pisp020u
end type
type dw_print from datawindow within w_pisp020u
end type
type gb_1 from groupbox within w_pisp020u
end type
type gb_2 from groupbox within w_pisp020u
end type
type gb_4 from groupbox within w_pisp020u
end type
type gb_3 from groupbox within w_pisp020u
end type
end forward

global type w_pisp020u from w_ipis_sheet01
integer width = 3931
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_month uo_month
cb_1 cb_1
dw_workgubun dw_workgubun
uo_workcenter uo_workcenter
uo_line uo_line
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
gb_3 gb_3
end type
global w_pisp020u w_pisp020u

type variables
datawindow	idw_primary, idw_cal_workgubun
boolean		ib_open, ib_cal_change
end variables

forward prototypes
public subroutine wf_cal_dw_resize (integer newwidth, integer newheight)
public subroutine wf_cal_init (string fs_month)
public function integer wf_cal_get_week ()
public subroutine wf_cal_enter_day (integer fi_start_day_num, integer fi_days_in_month)
public function integer wf_cal_days_in_month (integer fi_year, integer fi_month)
public function boolean wf_cal_save ()
end prototypes

public subroutine wf_cal_dw_resize (integer newwidth, integer newheight);Int		i, li_range	= 20, li_scroll_width = 100, li_mod, li_y
Int		li_text_width, li_dw_width
Int		li_text_height, li_dw_height, li_title_height, li_cell_height
Int		li_week_count
String	ls_modify = '', ls_modstring, ls_height

// Calender DataWindow Width Resize Service
li_dw_width	= idw_primary.Width
li_text_width	= (li_dw_width - ( 7 * li_range ) - li_scroll_width) / 7

ls_modify	= "st_su.X = '" + String((1 * li_range) + (0 * li_text_width)) + "' " + &
				  "st_su.Width = '" + String(li_text_width) + "' " + &
				  "st_mo.X = '" + String((2 * li_range) + (1 * li_text_width)) + "' " + &
				  "st_mo.Width = '" + String(li_text_width) + "' " + &
				  "st_tu.X = '" + String((3 * li_range) + (2 * li_text_width)) + "' " + &
				  "st_tu.Width = '" + String(li_text_width) + "' " + &
				  "st_we.X = '" + String((4 * li_range) + (3 * li_text_width)) + "' " + &
				  "st_we.Width = '" + String(li_text_width) + "' " + &
				  "st_th.X = '" + String((5 * li_range) + (4 * li_text_width)) + "' " + &
				  "st_th.Width = '" + String(li_text_width) + "' " + &
				  "st_fr.X = '" + String((6 * li_range) + (5 * li_text_width)) + "' " + &
				  "st_fr.Width = '" + String(li_text_width) + "' " + &
				  "st_sa.X = '" + String((7 * li_range) + (6 * li_text_width)) + "' " + &
				  "st_sa.Width = '" + String(li_text_width) + "' "

For i = 1 To 42
	li_mod	= Mod(i,7)
	If li_mod = 0 Then li_mod = 7;

	ls_modstring	= 'cell' + String(i) + ".X = '" + String((li_mod * li_range) + ((li_mod - 1) * li_text_width)) + "' " + &
						  'cell' + String(i) + ".Width = '" + String(li_text_width) + "' " + &
						  'work' + String(i) + ".X = '" + String((li_mod * li_range) + ((li_mod - 1) * li_text_width) + li_range) + "' "  + &
						  'st_' + String(i) + ".X = '" + String((li_mod * li_range) + ((li_mod - 1) * li_text_width)) + "' " + &
						  'st_' + String(i) + ".Width = '" + String(li_text_width) + "' "
	ls_modify	= ls_modify + ls_modstring
Next

// Calender DataWindow Height Resize Service
li_dw_height		= idw_primary.Height
li_title_height	= Integer(idw_primary.Describe("st_su.Height"))
li_cell_height		= Integer(idw_primary.Describe("cell1.Height"))

li_text_height		= (li_dw_height - ( 6 * li_range ) - li_scroll_width - li_title_height) / 6
li_week_count	= wf_cal_get_week()
For i = 1 To 42
	li_mod	= Truncate((i + 6) / 7, 0)
	li_y		= ((li_mod + 1) * li_range) + ((li_mod - 1) * li_text_height) + li_title_height
	
	ls_modstring	= 'cell' + String(i) + ".Y = '" + String(li_y)	+ "' " + &
						  'work' + String(i) + ".Y = '" + String(li_y + li_cell_height + li_range) + "' " + &
						  'st_' + String(i) + ".Y = '" + String(li_y)	+ "' " + &
						  'st_' + String(i) + ".Height = '" + String(li_text_height) + "' "

	If i = (li_week_count * 7) Then
		ls_height = " DataWindow.Detail.Height = '" + String(li_y + li_text_height + 4) + "'"
	End If

	ls_modify	= ls_modify + ls_modstring
Next

ls_modify	= ls_modify + ls_height

idw_primary.Modify(ls_modify)

//idw_primary.SetRedraw(True)
end subroutine

public subroutine wf_cal_init (string fs_month);Int		li_year, li_month, li_day, li_firstdaynum, li_cell, li_daysinmonth
String	ls_year, ls_month, ls_cell
Date		ld_firstday

//idw_primary.SetRedraw(False)
//DataWindow에 새로운 Row를 Insert한다.
idw_primary.Reset()
idw_primary.InsertRow(0)

// Parameter(Date;fd_start_date)의 년, 월, 일을 계산한다.
li_year	= Integer(Left(fs_month, 4))
li_month	= Integer(Right(fs_month, 2))
li_day	= 1

// 해당월의 일수를 계산한다.(Function Call)
li_daysinmonth = wf_cal_days_in_month(li_year, li_month)

// 해당월의 첫번째 날
ld_firstday = Date(li_year, li_month, li_day)

// 1일의 요일
li_firstdaynum = DayNumber(ld_firstday)

// DataWindow Modify를 위한 첫번째 Cell(Cell1 - Cell42)을 선택한다.
li_cell = li_firstdaynum + li_day - 1

//Set the Title of the calendar with the Month and Year
//ls_month = get_month_string(ii_month) + " " + string(ii_year)
//idw_primary.Object.st_month.text = ls_month

//Enter the numbers of the days
wf_cal_enter_day(li_firstdaynum, li_daysinmonth)

idw_primary.SetItem(1,li_cell,String(Day(ld_firstday)))

wf_cal_dw_resize(idw_primary.width, idw_primary.height)

//idw_primary.SetRedraw(True)
end subroutine

public function integer wf_cal_get_week ();int		li_year, li_month, li_last_day
string	ls_first_week, ls_last_week
DateTime	ldt_first, ldt_last

li_year	= Integer(Left(uo_month.is_uo_month,4))
li_month	= Integer(Right(uo_month.is_uo_month,2))
li_last_day	= wf_cal_days_in_month(li_year, li_month)

ldt_first	= DateTime(Date(li_year, li_month, 1))
ldt_last	= DateTime(Date(li_year, li_month, li_last_day))

Select	DateName(wk, :ldt_first),
			DateName(wk, :ldt_last)
  Into	:ls_first_week,
  			:ls_last_week
  From	sysusers
Using SQLPIS;

Return Integer(ls_last_week) - Integer(ls_first_week) + 1
end function

public subroutine wf_cal_enter_day (integer fi_start_day_num, integer fi_days_in_month);Int		li_count, li_daycount, li_week_count
String	ls_modstring = '', ls_height, ls_workgubun, ls_desc

// 1일 이전의 Cell에 Blank Set
For li_count = 1 to fi_start_day_num - 1
	idw_primary.SetItem(1, li_count,			"")
	idw_primary.SetItem(1, li_count + 42,	"")
	// St_n 의 Background Color를 White로 변경한다.
	ls_modstring	= ls_modstring + " work" + string(li_count) + ".BackGround.Color = '16777215'"
Next

// Date Numbet Set
For li_count = 1 to fi_days_in_month
	//Use li_daycount to find which column needs to be set
	ls_workgubun	= idw_cal_workgubun.GetItemString(li_count, 'workgubun')
	li_daycount = fi_start_day_num + li_count - 1
	idw_primary.SetItem(1, li_daycount,			String(li_count))
	idw_primary.SetItem(1, li_daycount + 42,	ls_workgubun)
	If ls_workgubun = 'W' Then
//		ls_modstring	= ls_modstring + " work" + string(li_daycount) + ".BackGround.Color = '16711680'"
		ls_modstring	= ls_modstring + " work" + string(li_daycount) + ".BackGround.Color = '31317469'" + &
								" work" + string(li_daycount) + ".Color = '16711680'"
	Else
		ls_modstring	= ls_modstring + " work" + string(li_daycount) + ".BackGround.Color = '255'" + &
								" work" + string(li_daycount) + ".Color = '16777215'"
	End If
Next

// Date 외에 Column Blank Set
li_daycount = li_daycount + 1

For li_count = li_daycount to 42
	idw_primary.SetItem(1,li_count,		"")
	idw_primary.SetItem(1,li_count + 42, "")
	ls_modstring	= ls_modstring + " work" + string(li_count) + ".BackGround.Color = '16777215'"
Next

li_week_count	= wf_cal_get_week()

ls_height	= String(Integer(idw_primary.Describe("st_" + string(li_week_count * 7) + ".Y")) +	&
				  Integer(idw_primary.Describe("st_" + string(li_week_count * 7) + ".Height")) + 4)

ls_modstring	= ls_modstring + " DataWindow.Detail.Height = '" + ls_height + "'"
idw_primary.Modify(ls_modstring)
end subroutine

public function integer wf_cal_days_in_month (integer fi_year, integer fi_month);//Most cases are straight forward in that there are a fixed number of 
//days in 11 of the 12 months.  February is, of course, the problem.
//In a leap year February has 29 days, otherwise 28.

Int 		li_days_in_month
Boolean	lb_leap_year

CHOOSE CASE fi_month
	CASE 1, 3, 5, 7, 8, 10, 12
		li_days_in_month = 31
	CASE 4, 6, 9, 11
		li_days_in_month = 30
	CASE 2
	// 100으로 나누어 나머지가 0 이면 윤달이 아님
		If Mod(fi_year,100) = 0 then
			lb_leap_year = False

	// 100으로 나누어 나머지가 0이 아니고, 4로 나누어 나머지가 0 이면 윤달임
		ElseIf Mod(fi_year,4) = 0 then 
			lb_leap_year = True

	// 그외의 경우는 윤달이 아님
		Else 
			lb_leap_year = False
		End If

	//윤달일 경우는 29일, 윤달이 아닐 경우는 28일
		If lb_leap_year then
			li_days_in_month = 29
		Else
			li_days_in_month = 28
		End If

END CHOOSE

// Return the number of days in the relevant month
Return li_days_in_month
end function

public function boolean wf_cal_save ();int		i, li_daysinmonth, li_firstdaynum, li_cell
date		ld_firstday
String	ls_workgubun, ls_applydate
Boolean	lb_error

// 해당월의 일수를 계산한다.(Function Call)
li_daysinmonth = wf_cal_days_in_month(Integer(Left(uo_month.is_uo_month, 4)), Integer(Right(uo_month.is_uo_month, 2)))
// 해당월의 첫번째 날
ld_firstday = Date(Integer(Left(uo_month.is_uo_month, 4)), Integer(Right(uo_month.is_uo_month, 2)), 1)
// 1일의 요일
li_firstdaynum = DayNumber(ld_firstday)
// DataWindow Modify를 위한 첫번째 Cell(Cell1 - Cell42)을 선택한다.
li_cell = li_firstdaynum + 1 - 1

SQLPIS.AutoCommit = False
For i = li_cell To 42
	ls_workgubun	= Trim(idw_primary.GetItemString(1, "work" + String(i)))
	ls_applydate	= uo_month.is_uo_month + '.' + Right('0' + String(i - li_cell + 1), 2)

	Update	tcalendarwork
		Set	WorkGubun		= :ls_workgubun,
				LastEmp			= 'Y',
				LastDate			= GetDate()
	 Where	AreaCode			= :uo_area.is_uo_areacode
		And	DivisionCode	= :uo_division.is_uo_divisioncode
		And	WorkCenter		= :uo_workcenter.is_uo_workcenter
		And	LineCode			= :uo_line.is_uo_linecode
		And	ApplyMonth		= :uo_month.is_uo_month
		And	ApplyDate		= :ls_applydate
	Using SQLPIS;
	If SQLPIS.sqlcode = 0 Then
		lb_error	= False
	Else
		lb_error = True
		Exit
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	Return True
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	Return True
End If
end function

on w_pisp020u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_month=create uo_month
this.cb_1=create cb_1
this.dw_workgubun=create dw_workgubun
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_month
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_workgubun
this.Control[iCurrent+7]=this.uo_workcenter
this.Control[iCurrent+8]=this.uo_line
this.Control[iCurrent+9]=this.dw_print
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_4
this.Control[iCurrent+13]=this.gb_3
end on

on w_pisp020u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_month)
destroy(this.cb_1)
destroy(this.dw_workgubun)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_3)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;idw_primary	= dw_1
idw_cal_workgubun = dw_workgubun

cb_1.Enabled	= m_frame.m_action.m_save.Enabled

idw_cal_workgubun.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										False, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										False, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)

ib_open = True

end event

event ue_retrieve;int	li_return

If ib_cal_change Then
	li_return =  MessageBox("Work Calendar", "변경된 Work Calendar 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_cal_save() Then
			uo_status.st_message.text =  "변경된 Work Calendar 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text =  "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("Work Calendar", "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
End If

ib_cal_change = False

iw_this.TriggerEvent("ue_reset")

idw_primary	= dw_1

If idw_cal_workgubun.Retrieve(uo_month.is_uo_month, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
					uo_workcenter.is_uo_workcenter, uo_line.is_uo_linecode) > 0 Then
	idw_primary.SetReDraw(False)
	wf_cal_init(uo_month.is_uo_month)
	idw_primary.SetReDraw(True)
	uo_status.st_message.text =  "Work Calendar 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "Work Calendar 정보가 존재하지 않습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("Work Calendar", "Work Calendar 정보가 존재하지 않습니다.")
End If
end event

event ue_save;call super::ue_save;int		i, li_daysinmonth, li_firstdaynum, li_cell
date		ld_firstday
String	ls_workgubun, ls_applydate
Boolean	lb_error

idw_primary.AcceptText()
//		If is_security > '2' Then
//			f_message("Work Carlendar에 관련된 데이타를 변경할 수 있는 권한이 없습니다.")
//			MessageBox("Work Carlendar", "Work Carlendar에 관련된 데이타를 변경할 수 있는 권한이 없습니다.", StopSign!)
//			Return
//		End If

If ib_cal_change = False Then
	uo_status.st_message.text =  "변경된 정보가 없습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("Work Carlendar","변경된 정보가 없습니다.")
	Return
End If

If MessageBox("Work Carlendar","변경하신 Work Carlendar 정보를 저장하시겠습니까 ?", Question!, YesNo!) = 2 Then
	Return
Else
	uo_status.st_message.text =  "변경된 Work Carlendar 정보 저장 중..." //+ f_message("Work Carlendar 정보 등록 중...")
End If

If wf_cal_save() Then
	ib_cal_change	= False
	uo_status.st_message.text =  "변경된 Work Calendar 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
	MessageBox("Work Calendar", "변경된 Work Calendar 정보를 저장하였습니다.", Information!)
	TriggerEvent("ue_retrieve")
Else
	uo_status.st_message.text =  "변경된 Work Calendar 정보를 저장하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("Work Calendar", "변경된 Work Calendar 정보를 저장하는 도중에 오류가 발생하였습니다.", StopSign!)
End If

end event

event ue_reset;call super::ue_reset;ib_cal_change = False

dw_1.ReSet()
idw_cal_workgubun.ReSet()
dw_print.ReSet()
end event

event closequery;call super::closequery;int	li_return

If ib_cal_change Then
	li_return =  MessageBox("Work Calendar", "변경된 Work Calendar 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 종료하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_cal_save() Then
			Return 0
//			uo_status.st_message.text =  "Work Calendar 정보를 변경하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text =  "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("Work Calendar", "변경된 Work Calendar 정보를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
			Return 1
		End If
	ElseIf li_return = 2 Then
		Return 0
	ElseIf li_return = 3 Then
		Return 1
	End If
End If
end event

event ue_print;call super::ue_print;String	ls_mod

idw_primary	= dw_print

If idw_cal_workgubun.RowCount() > 0 Then
	idw_primary.SetReDraw(False)
	wf_cal_init(uo_month.is_uo_month)
	idw_primary.SetReDraw(True)
	ls_mod	= "st_title.Text = '" + "Work Calendar" + "'" + &
					"st_month.Text = '" + "(" + uo_month.is_uo_month + ")" + "'" + &
					"st_msg.Text = '" + "라인 : " + uo_line.is_uo_linefullname + "'"
	idw_primary.Modify(ls_mod)
	idw_primary.Print()
//	uo_status.st_message.text =  "Shop Calendar 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
//	uo_status.st_message.text =  "Shop Calendar 정보가 존재하지 않습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("Shop Calendar", "Shop Calendar 정보를 조회하신 후에 인쇄하십시오.")
End If

end event

event activate;call super::activate;dw_workgubun.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp020u
end type

type dw_1 from u_vi_std_datawindow within w_pisp020u
integer x = 14
integer y = 216
integer width = 3584
integer height = 1668
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisp020u_01"
end type

event rowfocuschanged;//
end event

event clicked;//
end event

event dberror;//
end event

event doubleclicked;//
end event

event error;//
end event

event getfocus;//
end event

event itemerror;//
end event

event rbuttondown;//
end event

event ue_key;//
end event

event ue_lbuttonup;//
end event

event itemchanged;call super::itemchanged;String	ls_date, ls_workgubun, ls_modstring

AcceptText()
If row > 0 Then
	ib_cal_change = True

	ls_date = string(dwo.name)
	ls_workgubun = Upper(data)

	If ls_workgubun = 'W' Then
		ls_modstring	= ls_date + ".BackGround.Color = '31317469'" + &
								ls_date + ".Color = '16711680'"
	Else
		ls_modstring	= ls_date + ".BackGround.Color = '255'" + &
								ls_date + ".Color = '16777215'"
	End If

	Modify(ls_modstring)

	uo_status.st_message.text =  "Work Calendar 정보가 변경되었습니다."
End If
end event

type uo_area from u_pisc_select_area within w_pisp020u
integer x = 718
integer y = 72
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;If ib_open Then
	idw_cal_workgubun.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											False, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If
end event

type uo_division from u_pisc_select_division within w_pisp020u
integer x = 1230
integer y = 72
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	idw_cal_workgubun.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											False, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If

end event

type uo_month from u_pisc_date_scroll_month within w_pisp020u
integer x = 46
integer y = 72
integer height = 80
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type cb_1 from commandbutton within w_pisp020u
integer x = 3205
integer y = 64
integer width = 608
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Calendar 복사(&C)"
end type

event clicked;Int		li_return
String	ls_parm

If idw_cal_workgubun.RowCount() > 0 Then
	//
Else
	uo_status.st_message.text =  "복사할 Work Calendar 정보를 조회하신 후에 복사를 수행하십시오." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("Work Calendar", "복사할 Work Calendar 정보를 조회하신 후에 복사를 수행하십시오.", StopSign!)
	Return
End If

If ib_cal_change Then
	li_return =  MessageBox("Work Calendar", "Work Calendar을 변경하셨습니다." + &
							"~r~n~r~n변경된 내역을 저장하신 후에 Calendar 복사를 수행 하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then
		If wf_cal_save() Then
			ib_cal_change	= False
			uo_status.st_message.text =  "Work Calendar 정보를 변경하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
			TriggerEvent("ue_retrieve")
		Else
			uo_status.st_message.text =  "Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("Work Calendar", "Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
End If

ib_cal_change = False

istr_parms.string_arg[1] = is_size
istr_parms.string_arg[2] = uo_month.is_uo_month
istr_parms.datawindow_arg[1] = idw_cal_workgubun

OpenWithParm(w_pisp021u, istr_parms)
end event

type dw_workgubun from datawindow within w_pisp020u
integer x = 1413
integer y = 308
integer width = 1326
integer height = 632
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_pisp020u_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp020u
integer x = 1861
integer y = 72
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If
end event

type uo_line from u_pisc_select_line within w_pisp020u
integer x = 2551
integer y = 72
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type dw_print from datawindow within w_pisp020u
integer x = 165
integer y = 324
integer width = 869
integer height = 492
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp010i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
Resize(3447, 1932)
end event

type gb_1 from groupbox within w_pisp020u
integer x = 14
integer width = 663
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp020u
integer x = 681
integer width = 1147
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pisp020u
integer x = 3150
integer width = 722
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp020u
integer x = 1833
integer width = 1312
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

