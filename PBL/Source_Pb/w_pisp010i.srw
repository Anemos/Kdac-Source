$PBExportHeader$w_pisp010i.srw
$PBExportComments$Shop Calendar
forward
global type w_pisp010i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp010i
end type
type uo_area from u_pisc_select_area within w_pisp010i
end type
type uo_division from u_pisc_select_division within w_pisp010i
end type
type uo_month from u_pisc_date_scroll_month within w_pisp010i
end type
type dw_2 from datawindow within w_pisp010i
end type
type dw_print from datawindow within w_pisp010i
end type
type gb_1 from groupbox within w_pisp010i
end type
type gb_2 from groupbox within w_pisp010i
end type
end forward

global type w_pisp010i from w_ipis_sheet01
integer width = 3671
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_month uo_month
dw_2 dw_2
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
end type
global w_pisp010i w_pisp010i

type variables
datawindow	idw_primary, idw_cal_workgubun
boolean		ib_open
end variables

forward prototypes
public subroutine wf_cal_dw_resize (integer newwidth, integer newheight)
public subroutine wf_cal_init (string fs_month)
public subroutine wf_cal_enter_day (integer fi_start_day_num, integer fi_days_in_month)
public function integer wf_cal_get_week ()
public function integer wf_cal_days_in_month (integer fi_year, integer fi_month)
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
//DataWindow�� ���ο� Row�� Insert�Ѵ�.
idw_primary.Reset()
idw_primary.InsertRow(0)

// Parameter(Date;fd_start_date)�� ��, ��, ���� ����Ѵ�.
li_year	= Integer(Left(fs_month, 4))
li_month	= Integer(Right(fs_month, 2))
li_day	= 1

// �ش���� �ϼ��� ����Ѵ�.(Function Call)
li_daysinmonth = wf_cal_days_in_month(li_year, li_month)

// �ش���� ù��° ��
ld_firstday = Date(li_year, li_month, li_day)

// 1���� ����
li_firstdaynum = DayNumber(ld_firstday)

// DataWindow Modify�� ���� ù��° Cell(Cell1 - Cell42)�� �����Ѵ�.
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

public subroutine wf_cal_enter_day (integer fi_start_day_num, integer fi_days_in_month);Int		li_count, li_daycount, li_week_count
String	ls_modstring = '', ls_height, ls_workgubun, ls_desc

// 1�� ������ Cell�� Blank Set
For li_count = 1 to fi_start_day_num - 1
	idw_primary.SetItem(1, li_count,			"")
	idw_primary.SetItem(1, li_count + 42,	"")
	// St_n �� Background Color�� White�� �����Ѵ�.
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

// Date �ܿ� Column Blank Set
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
	// 100���� ������ �������� 0 �̸� ������ �ƴ�
		If Mod(fi_year,100) = 0 then
			lb_leap_year = False

	// 100���� ������ �������� 0�� �ƴϰ�, 4�� ������ �������� 0 �̸� ������
		ElseIf Mod(fi_year,4) = 0 then 
			lb_leap_year = True

	// �׿��� ���� ������ �ƴ�
		Else 
			lb_leap_year = False
		End If

	//������ ���� 29��, ������ �ƴ� ���� 28��
		If lb_leap_year then
			li_days_in_month = 29
		Else
			li_days_in_month = 28
		End If

END CHOOSE

// Return the number of days in the relevant month
Return li_days_in_month
end function

on w_pisp010i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_month=create uo_month
this.dw_2=create dw_2
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_month
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_print
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
end on

on w_pisp010i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_month)
destroy(this.dw_2)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;idw_primary	= dw_1
idw_cal_workgubun = dw_2

idw_cal_workgubun.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)


ib_open = True

end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

idw_primary	= dw_1

If idw_cal_workgubun.Retrieve(uo_month.is_uo_month, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode) > 0 Then
	idw_primary.SetReDraw(False)
	wf_cal_init(uo_month.is_uo_month)
	idw_primary.SetReDraw(True)
	uo_status.st_message.text =  "Shop Calendar ����" //+ f_message("����� ����Ÿ�� �����ϴ�.")
Else
	uo_status.st_message.text =  "Shop Calendar ������ �������� �ʽ��ϴ�." //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("Shop Calendar", "Shop Calendar ������ �������� �ʽ��ϴ�.")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
idw_cal_workgubun.ReSet()
dw_print.ReSet()
end event

event ue_print;call super::ue_print;String	ls_mod

idw_primary	= dw_print

If idw_cal_workgubun.RowCount() > 0 Then
	idw_primary.SetReDraw(False)
	wf_cal_init(uo_month.is_uo_month)
	idw_primary.SetReDraw(True)
	ls_mod	= "st_title.Text = '" + "Shop Calendar" + "'" + &
					"st_month.Text = '" + "(" + uo_month.is_uo_month + ")" + "'" + &
					"st_msg.Text = '" + "���� : " + uo_division.is_uo_divisionname + "'"
	idw_primary.Modify(ls_mod)
	idw_primary.Print()
//	uo_status.st_message.text =  "Shop Calendar ����" //+ f_message("����� ����Ÿ�� �����ϴ�.")
Else
//	uo_status.st_message.text =  "Shop Calendar ������ �������� �ʽ��ϴ�." //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("Shop Calendar", "Shop Calendar ������ ��ȸ�Ͻ� �Ŀ� �μ��Ͻʽÿ�.")
End If

end event

event activate;call super::activate;dw_2.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp010i
end type

type dw_1 from u_vi_std_datawindow within w_pisp010i
integer x = 14
integer y = 216
integer width = 3584
integer height = 1668
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisp010i_01"
end type

event rowfocuschanged;//
end event

event clicked;//
end event

event doubleclicked;//
end event

event ue_key;//
end event

event ue_lbuttonup;//
end event

event dberror;//
end event

event error;//
end event

event getfocus;//
end event

event itemerror;//
end event

event losefocus;//
end event

event rbuttondown;//
end event

event ue_accepttext;//
end event

type uo_area from u_pisc_select_area within w_pisp010i
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
End If
end event

type uo_division from u_pisc_select_division within w_pisp010i
integer x = 1230
integer y = 72
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	idw_cal_workgubun.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
End If

end event

type uo_month from u_pisc_date_scroll_month within w_pisp010i
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

type dw_2 from datawindow within w_pisp010i
integer x = 1413
integer y = 308
integer width = 1326
integer height = 632
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_pisp010i_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_print from datawindow within w_pisp010i
integer x = 133
integer y = 324
integer width = 992
integer height = 516
boolean bringtotop = true
boolean titlebar = true
string title = "�μ�"
string dataobject = "d_pisp010i_01_print"
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
Resize(3447, 1932)
end event

type gb_1 from groupbox within w_pisp010i
integer x = 14
integer width = 663
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp010i
integer x = 681
integer width = 1147
integer height = 192
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type
