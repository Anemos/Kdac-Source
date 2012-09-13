$PBExportHeader$w_pisr030c.srw
$PBExportComments$Work Calendar( 제품군)
forward
global type w_pisr030c from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisr030c
end type
type uo_area from u_pisc_select_area within w_pisr030c
end type
type uo_division from u_pisc_select_division within w_pisr030c
end type
type uo_month from u_pisc_date_scroll_month within w_pisr030c
end type
type dw_workgubun from datawindow within w_pisr030c
end type
type dw_print from datawindow within w_pisr030c
end type
type uo_product from u_pisc_select_productgroup within w_pisr030c
end type
type gb_1 from groupbox within w_pisr030c
end type
type gb_3 from groupbox within w_pisr030c
end type
end forward

global type w_pisr030c from w_ipis_sheet01
integer width = 3931
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_month uo_month
dw_workgubun dw_workgubun
dw_print dw_print
uo_product uo_product
gb_1 gb_1
gb_3 gb_3
end type
global w_pisr030c w_pisr030c

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

	Update	tpartcalendarwork
		Set	WorkGubun		= :ls_workgubun,
				LastEmp			= 'Y',	//Interface Flag 활용
				LastDate			= GetDate()
	 Where	AreaCode			= :uo_area.is_uo_areacode
		And	DivisionCode	= :uo_division.is_uo_divisioncode
		And   ProductGroup	like :uo_product.is_uo_productgroup
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

on w_pisr030c.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_month=create uo_month
this.dw_workgubun=create dw_workgubun
this.dw_print=create dw_print
this.uo_product=create uo_product
this.gb_1=create gb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_month
this.Control[iCurrent+5]=this.dw_workgubun
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.uo_product
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_3
end on

on w_pisr030c.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_month)
destroy(this.dw_workgubun)
destroy(this.dw_print)
destroy(this.uo_product)
destroy(this.gb_1)
destroy(this.gb_3)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;idw_primary	= dw_1
idw_cal_workgubun = dw_workgubun

idw_cal_workgubun.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
iw_this.TriggerEvent("ue_reset")

f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
	uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
	uo_product.is_uo_productgroupname)

ib_open = True
uo_month.uf_setdata(date(f_pisc_get_date_nowtime()))
uo_month.uf_setfocus()
end event

event ue_retrieve;int		li_return, li_shopcount, li_rowcnt
string   ls_productgroup

If ib_cal_change Then
	li_return =  MessageBox("Work Calendar", "변경된 Work Calendar 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_cal_save() Then
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text = "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("Work Calendar", "변경된 Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
End If

ib_cal_change = False

iw_this.TriggerEvent("ue_reset")
ls_productgroup = uo_product.is_uo_productgroup
if ls_productgroup = '%' then
	if uo_area.is_uo_areacode = 'D' and uo_division.is_uo_divisioncode = 'A' then
		uo_status.st_message.text =  "제품군을 선택해 주십시요."
		return 0
	else
		SELECT TOP 1 ProductGroup INTO :ls_productgroup
		FROM TMSTPRODUCTGROUP
		WHERE AreaCode = :uo_area.is_uo_areacode  AND DivisionCode = :uo_division.is_uo_divisioncode
		ORDER BY ProductGroup ASC
		using sqlpis;
		
		if sqlpis.sqlcode <> 0 or f_spacechk(ls_productgroup) = -1 then
			uo_status.st_message.text =  "제품군에 대한 정보가 없습니다. 시스템개발팀으로 연락바랍니다."
			return 0
		end if
	end if
end if
//1
idw_cal_workgubun.SetTransObject(sqlpis)
If idw_cal_workgubun.Retrieve(uo_month.is_uo_month, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, ls_productgroup) > 0 Then
	idw_primary.SetReDraw(False)
	wf_cal_init(uo_month.is_uo_month)
	idw_primary.SetReDraw(True)
	uo_status.st_message.text =  "Work Calendar 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "Work Calendar 정보가 존재하지 않습니다." //+ f_message("변경된 데이타가 없습니다.")
	//MessageBox("Work Calendar", "Work Calendar 정보가 존재하지 않습니다.")
	li_return = MessageBox("Work Calendar", "Work Calendar 정보가 존재하지 않습니다.~r~n" + &
												"Work Calendar 정보를 신규로 생성하시겠습니까?", Question!, YesNo!, 2)
	IF li_return = 1 THEN	//2
		Integer	li_i, li_weekno
		String	ls_date, ls_WorkGubun, ls_dayname
		Long		ll_DayNo
		
		sqlpis.AutoCommit = False
		
		ls_productgroup = '00'
		DO WHILE TRUE
			SELECT TOP 1 ProductGroup INTO :ls_productgroup
			FROM TMSTPRODUCTGROUP
			WHERE AreaCode = :uo_area.is_uo_areacode  AND DivisionCode = :uo_division.is_uo_divisioncode AND
				ProductGroup > :ls_productgroup
			ORDER BY ProductGroup ASC
			using sqlpis;
			
			if sqlpis.sqlcode <> 0 or f_spacechk(ls_productgroup) = -1 then
				exit
			end if
		
			For li_i = 1 To 31 Step 1
				ls_date = left(uo_month.is_uo_month, 7) + '.' + String(li_i, "00")
				If Not isDate( ls_date ) Then Exit
				li_weekno = DayNumber(Date(ls_date))
				If li_weekno = 1 Or li_weekno = 7 Then 
					ls_WorkGubun = 'H'
				Else 
					ls_WorkGubun = 'W'
				End If				
				ll_DayNo	= DaysAfter (Date( left(uo_month.is_uo_month, 4) + '.01.01'), Date(ls_date)) + 1
							
				INSERT INTO TPARTCALENDARWORK  
						( AreaCode, DivisionCode, ProductGroup, ApplyMonth, ApplyDate, DayNo, WorkGubun, Remark, LastEmp, LastDate )  
				VALUES (	:uo_area.is_uo_areacode,   
							:uo_division.is_uo_divisioncode,
							:ls_productgroup,
							:uo_month.is_uo_month,   
							:ls_date,   
							:ll_DayNo,   
							:ls_WorkGubun,   
							Null,   
							'N',   	//Interface Flag 활용
							GetDate() )
				Using	sqlpis;
				If sqlpis.Sqlcode <> 0 Then Goto Rollback_	
			Next
		LOOP
		
		Commit Using sqlpis;
		sqlpis.AutoCommit = True
		uo_status.st_message.text = "Work Calendar 생성에 성공하였습니다." //+ f_message("변경된 데이타가 없습니다.")
		MessageBox("Work Calendar", "Work Calendar 생성에 성공하였습니다.", Information!)
		This.TriggerEvent( "ue_retrieve" )
		Return
		
		Rollback_:
		Rollback Using sqlpis;
		sqlpis.AutoCommit = True
		uo_status.st_message.text = "Work Calendar 생성에 실패했습니다." //+ f_message("변경된 데이타가 없습니다.")
		MessageBox("Work Calendar", "Work Calendar 생성에 실패했습니다.", Information!)
		Return		
	END IF	//2
End If	//1

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

idw_primary.ReSet()
idw_cal_workgubun.ReSet()

if uo_area.is_uo_areacode = 'D' and uo_division.is_uo_divisioncode = 'A' then
	uo_product.visible = true
else
	uo_product.visible = false
end if
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
					"st_msg.Text = '" + "자재(외주간판)" + "'"
	idw_primary.Modify(ls_mod)
	idw_primary.Print()
//	uo_status.st_message.text =  "Shop Calendar 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
//	uo_status.st_message.text =  "Shop Calendar 정보가 존재하지 않습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("Shop Calendar", "Shop Calendar 정보를 조회하신 후에 인쇄하십시오.")
End If

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisr030c
end type

type dw_1 from u_vi_std_datawindow within w_pisr030c
integer x = 14
integer y = 216
integer width = 3584
integer height = 1668
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisr030c_01"
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

type uo_area from u_pisc_select_area within w_pisr030c
integer x = 718
integer y = 72
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;If ib_open Then
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	iw_this.TriggerEvent("ue_reset")
End If
end event

type uo_division from u_pisc_select_division within w_pisr030c
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
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
		uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
		uo_product.is_uo_productgroupname)
End If
end event

type uo_month from u_pisc_date_scroll_month within w_pisr030c
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

type dw_workgubun from datawindow within w_pisr030c
integer x = 1815
integer y = 564
integer width = 1326
integer height = 632
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_pisr030c_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_print from datawindow within w_pisr030c
integer x = 165
integer y = 324
integer width = 1627
integer height = 1160
integer taborder = 21
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

type uo_product from u_pisc_select_productgroup within w_pisr030c
integer x = 1824
integer y = 76
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

type gb_1 from groupbox within w_pisr030c
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
end type

type gb_3 from groupbox within w_pisr030c
integer x = 681
integer width = 2066
integer height = 192
integer taborder = 11
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

