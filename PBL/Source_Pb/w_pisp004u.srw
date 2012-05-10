$PBExportHeader$w_pisp004u.srw
$PBExportComments$평준화 계획 계산
forward
global type w_pisp004u from window
end type
type cb_1 from commandbutton within w_pisp004u
end type
type cb_2 from commandbutton within w_pisp004u
end type
type st_msg from statictext within w_pisp004u
end type
type uo_date from u_pisc_date_applydate within w_pisp004u
end type
type cbx_1 from checkbox within w_pisp004u
end type
type cb_3 from commandbutton within w_pisp004u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp004u
end type
type uo_division from u_pisc_select_division within w_pisp004u
end type
type uo_area from u_pisc_select_area within w_pisp004u
end type
type cb_4 from commandbutton within w_pisp004u
end type
type dw_save from datawindow within w_pisp004u
end type
type dw_cycle from datawindow within w_pisp004u
end type
type gb_4 from groupbox within w_pisp004u
end type
type gb_1 from groupbox within w_pisp004u
end type
type gb_3 from groupbox within w_pisp004u
end type
type gb_2 from groupbox within w_pisp004u
end type
end forward

global type w_pisp004u from window
integer width = 3287
integer height = 2088
boolean titlebar = true
string title = "평준화 계획 계산"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
cb_1 cb_1
cb_2 cb_2
st_msg st_msg
uo_date uo_date
cbx_1 cbx_1
cb_3 cb_3
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
cb_4 cb_4
dw_save dw_save
dw_cycle dw_cycle
gb_4 gb_4
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
end type
global w_pisp004u w_pisp004u

type variables
Boolean		ib_open, ib_check, ib_save
String		is_plandate
str_parms	istr_parms
window		iw_sheet
end variables

forward prototypes
public subroutine wf_reset ()
public subroutine wf_retrieve ()
end prototypes

event ue_postopen();uo_date.id_uo_date = Date(is_plandate)
uo_date.is_uo_date = String(uo_date.id_uo_date, 'YYYY.MM.DD')
uo_date.init_cal(uo_date.id_uo_date)
uo_date.set_date_format ('yyyy.mm.dd')
uo_date.TriggerEvent("ue_variable_set")
uo_date.TriggerEvent("ue_select")

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
										True, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)

dw_cycle.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)	
wf_retrieve()
ib_open = True
end event

public subroutine wf_reset ();ib_check = False
cbx_1.Checked	= False

dw_cycle.ReSet()
dw_save.ReSet()
end subroutine

public subroutine wf_retrieve ();wf_reset()
If dw_cycle.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
			  			   uo_workcenter.is_uo_workcenter) > 0 Then
//	cb_1.Enabled	= True
Else
	MessageBox("평준화 계획 계산", "평준화 계획을 계산하려는 라인 정보가 존재하지 않습니다.")
End If
end subroutine

on w_pisp004u.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_msg=create st_msg
this.uo_date=create uo_date
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_4=create cb_4
this.dw_save=create dw_save
this.dw_cycle=create dw_cycle
this.gb_4=create gb_4
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.Control[]={this.cb_1,&
this.cb_2,&
this.st_msg,&
this.uo_date,&
this.cbx_1,&
this.cb_3,&
this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.cb_4,&
this.dw_save,&
this.dw_cycle,&
this.gb_4,&
this.gb_1,&
this.gb_3,&
this.gb_2}
end on

on w_pisp004u.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_msg)
destroy(this.uo_date)
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_4)
destroy(this.dw_save)
destroy(this.dw_cycle)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]
is_plandate			= istr_parms.string_arg[2]
iw_sheet				= istr_parms.window_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")  
end event

type cb_1 from commandbutton within w_pisp004u
integer x = 69
integer y = 52
integer width = 786
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "라인 조회(&R)"
end type

event clicked;wf_retrieve()
end event

type cb_2 from commandbutton within w_pisp004u
integer x = 859
integer y = 52
integer width = 786
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "평준화Cycle 초기화(&I)"
end type

event clicked;Int		i, li_cyclecount
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_maxcyclegubun
Boolean	lb_error

If dw_cycle.RowCount() > 0 Then
	//
Else
	MessageBox("평준화 계획 계산", "평준화Cycle을 초기화하려는 라인 정보가 존재하지 않습니다.")
	Return
End If

If MessageBox("평준화 계획 계산", "평준화Cycle 초기화를 수행하면 조회한 모든 라인의 평준화 Cycle은 '최다 Cycle' 이 됩니다." + &
							"~r~n~r~n조회한 모든 라인의 평준화 Cycle을 초기화 하시겠습니까?", &
							Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

For i = 1 To dw_cycle.RowCount()
	ls_areacode			= Trim(dw_cycle.GetItemString(i, "AreaCode"))
	ls_divisioncode	= Trim(dw_cycle.GetItemString(i, "DivisionCode"))
	ls_workcenter		= Trim(dw_cycle.GetItemString(i, "WorkCenter"))
	ls_linecode			= Trim(dw_cycle.GetItemString(i, "LineCode"))
	ls_maxcyclegubun = "Y"
	li_cyclecount		= 0
	
	Update	tmstline
	Set		MaxCycleGubun	= :ls_maxcyclegubun,
				CycleCount		= :li_cyclecount,
				LastEmp			= 'Y',
				LastDate			= GetDate()
	Where		AreaCode			= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_workcenter		And
				LineCode			= :ls_linecode
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
	MessageBox("평준화 계획 계산", "평준화 Cycle을 초기화하는 중에 오류가 발생하였습니다.", StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("평준화 계획 계산", "평준화 Cycle을 초기화 하였습니다.", Information!)
	wf_retrieve()
End If
end event

type st_msg from statictext within w_pisp004u
integer x = 59
integer y = 428
integer width = 3099
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "당일 평준화 계획을 계산할 라인을 체크하신 후에 ~'평준화 계획 계산(&S)~' 버튼을 클릭하십시오."
boolean focusrectangle = false
end type

type uo_date from u_pisc_date_applydate within w_pisp004u
integer x = 64
integer y = 260
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type cbx_1 from checkbox within w_pisp004u
integer x = 2642
integer y = 264
integer width = 539
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "전체 라인 선택"
end type

event clicked;Int	i

If dw_cycle.RowCount() > 0 Then
	If cbx_1.Checked = False Then
		ib_check		= False
		cbx_1.Checked	= False
		For i = 1 To dw_cycle.RowCount()
			dw_cycle.SetItem(i, "checkFlag", "N")
		Next
	Else
		ib_check		= True
		cbx_1.Checked	= True
		For i = 1 To dw_cycle.RowCount()
			dw_cycle.SetItem(i, "checkFlag", "Y")
		Next
	End If
End If
end event

type cb_3 from commandbutton within w_pisp004u
integer x = 1650
integer y = 52
integer width = 786
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "평준화 계획 계산(&G)"
end type

event clicked;Int		i, li_count, li_cyclecount
String	ls_plandate, ls_applydate_close, &
			ls_computeflag, ls_areacode, ls_divisioncode, &
			ls_workcenter, ls_workcentername, ls_linecode, ls_linefullname, ls_maxcyclegubun, &
			ls_errortext
Boolean	lb_error

If ib_check = False Then
	MessageBox("평준화 계획 계산", "평준화 계획을 계산하기 위하여 선택된 라인이 없습니다.")
	Return
End If

ls_plandate		= uo_date.is_uo_date
ls_applydate_close	= f_pisc_get_date_applydate_close('%', '%', f_pisc_get_date_nowtime())

If ls_plandate < ls_applydate_close Then
	st_msg.Text = "오늘 이전 날짜의 평준화 계획은 계산할 수 없습니다."
	MessageBox("평준화 계획 계산", "오늘 이전 날짜의 당일 평준화계획은 계산할 수 없습니다.")
	Return
End If

If MessageBox("평준화 계획 계산", "평준화 계획을 계산하시겠습니까?", &
							Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

For i = 1 To dw_cycle.RowCount()
	dw_save.ReSet()
	ls_computeflag		= Trim(dw_cycle.GetItemString(i, "CheckFlag"))
	If ls_computeflag = "Y" Then
		ls_areacode			= Trim(dw_cycle.GetItemString(i, "AreaCode"))
		ls_divisioncode	= Trim(dw_cycle.GetItemString(i, "DivisionCode"))
		ls_workcenter		= Trim(dw_cycle.GetItemString(i, "WorkCenter"))
		ls_workcentername	= Trim(dw_cycle.GetItemString(i, "WorkCenterName"))
		ls_linecode			= Trim(dw_cycle.GetItemString(i, "LineCode"))
		ls_linefullname	= Trim(dw_cycle.GetItemString(i, "LineFullName"))
		ls_maxcyclegubun	= Trim(dw_cycle.GetItemString(i, "MaxCycleGubun"))
		li_cyclecount		= dw_cycle.GetItemNumber(i, "CycleCount")

		li_count	= 0
		Select	Count(PlanDate)
		Into		:li_count
		From		tplanrelease
		Where		PlanDate			= :ls_plandate			And
					AreaCode			= :ls_areacode				And
					DivisionCode	= :ls_divisioncode		And
					WorkCenter		= :ls_workcenter			And
					LineCode			= :ls_linecode				And
					ReleaseGubun	In ('Y', 'T', 'N')
		Using SQLPIS;

		If li_count > 0 Then
			st_msg.Text = ls_workcentername + " 조, " + ls_linefullname + " 라인은" + &
							" 조립지시가 수행되어 있어서 평준화 계획은 계산할 수 없습니다."
			lb_error	= True
			ls_errortext	= ls_workcentername + " 조, " + ls_linefullname + " 라인은" + &
							" 조립지시가 수행되어 있어서 평준화 계획은 계산할 수 없습니다."
			Exit
		Else
			st_msg.Text = ls_workcentername + " 조, " + ls_linefullname + " 라인의" + &
							" 평준화 계획 계산중..."
			If dw_save.Retrieve(ls_plandate, ls_areacode, ls_divisioncode, ls_workcenter, &
								ls_linecode, ls_maxcyclegubun, li_cyclecount, g_s_empno) > 0 Then
				If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
					lb_error	= False
					ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
				Else
					lb_error = True
					ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
					Exit
				End If
			Else
				lb_error = True
				ls_errortext	= "평준화 계획 계산을 시도하였지만 오류가 발생했습니다."
				Exit
			End If
		End If
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	st_msg.Text = ls_workcentername + " 조, " + ls_linefullname + " 라인을" + &
					"계산하는 중에 오류가 발생.."
	MessageBox("평준화 계획 계산", ls_workcentername + " 조, " + &
												"~r~n" + ls_linefullname + " 라인의" + &
												"~r~n평준화 계획을 계산하는 중에 오류가 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
//	ib_save	= True
	st_msg.Text = "평준화 계획을 계산하였습니다."
	MessageBox("평준화 계획 계산", "평준화 계획을 계산하였습니다.", Information!)
	wf_retrieve()
	iw_sheet.TriggerEvent("ue_retrieve")
End If
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp004u
integer x = 1883
integer y = 260
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type uo_division from u_pisc_select_division within w_pisp004u
integer x = 1303
integer y = 260
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_cycle.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp004u
integer x = 782
integer y = 260
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_cycle.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
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
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	wf_retrieve()
End If
end event

type cb_4 from commandbutton within w_pisp004u
integer x = 2441
integer y = 52
integer width = 727
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종  료(&C)"
end type

event clicked;//If ib_save Then
//	CloseWithReturn(Parent, "CHANGE")
//Else
	CloseWithReturn(Parent, "CANCEL")
//End If
end event

type dw_save from datawindow within w_pisp004u
integer x = 1984
integer y = 1084
integer width = 809
integer height = 412
boolean bringtotop = true
boolean titlebar = true
string title = "평준화계획 계산"
string dataobject = "d_pisp004u_02_u"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_cycle from datawindow within w_pisp004u
event ue_check ( integer fi_row )
integer x = 23
integer y = 528
integer width = 3195
integer height = 1432
string title = "none"
string dataobject = "d_pisp004u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_check;Int		i, li_checkcount
String	ls_checkflag

AcceptText()

For i = 1 To RowCount()
	ls_checkflag	= Trim(GetItemString(i, "CheckFlag"))
	If ls_checkflag = "Y" Then
		li_checkcount = li_checkcount + 1
	End If
Next

If li_checkcount > 0 Then
	ib_check		= True
	If li_checkcount = RowCount() Then
		cbx_1.Checked	= True
	Else
		cbx_1.Checked	= False
	End If
Else	
	ib_check		= False
	cbx_1.Checked	= False
End If
end event

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

event itemchanged;Int		li_cyclecount
String	ls_column, ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_maxcyclegubun

AcceptText()

If row > 0 Then
	ls_column = Trim(String(dwo.name))	
	CHOOSE CASE Upper(ls_column)
		CASE "CYCLECOUNT"
			SQLPIS.AutoCommit = False
			ls_areacode			= Trim(dw_cycle.GetItemString(row, "AreaCode"))
			ls_divisioncode	= Trim(dw_cycle.GetItemString(row, "DivisionCode"))
			ls_workcenter		= Trim(dw_cycle.GetItemString(row, "WorkCenter"))
			ls_linecode			= Trim(dw_cycle.GetItemString(row, "LineCode"))
			li_cyclecount		= dw_cycle.GetItemNumber(row, "CycleCount")

			If li_cyclecount = 0 Then
				ls_maxcyclegubun = "Y"
			Else
				ls_maxcyclegubun = "N"
			End If
				
			Update	tmstline
			Set		MaxCycleGubun	= :ls_maxcyclegubun,
						CycleCount		= :li_cyclecount,
						LastEmp			= 'Y',
						LastDate			= GetDate()
			Where		AreaCode			= :ls_areacode			And
						DivisionCode	= :ls_divisioncode	And
						WorkCenter		= :ls_workcenter		And
						LineCode			= :ls_linecode
			Using SQLPIS;
				
			If SQLPIS.sqlcode = 0 Then
				Commit Using SQLPIS;
				SQLPIS.AutoCommit = True
			Else
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("평준화 Cycle 설정", "변경된 평준화 Cycle을 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			End If
		CASE "CHECKFLAG"
			Post Event ue_check(row)
	END CHOOSE
End If
end event

event constructor;this.settransobject(Sqlpis)
end event

type gb_4 from groupbox within w_pisp004u
integer x = 23
integer width = 3195
integer height = 196
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisp004u
integer x = 23
integer y = 176
integer width = 2574
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisp004u
integer x = 2606
integer y = 176
integer width = 613
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisp004u
integer x = 23
integer y = 356
integer width = 3195
integer height = 164
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

