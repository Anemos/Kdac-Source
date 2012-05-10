$PBExportHeader$w_pisp003u.srw
$PBExportComments$평준화 Cycle 설정
forward
global type w_pisp003u from window
end type
type cb_1 from commandbutton within w_pisp003u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp003u
end type
type uo_division from u_pisc_select_division within w_pisp003u
end type
type uo_area from u_pisc_select_area within w_pisp003u
end type
type cb_3 from commandbutton within w_pisp003u
end type
type cb_2 from commandbutton within w_pisp003u
end type
type gb_1 from groupbox within w_pisp003u
end type
type dw_cycle from datawindow within w_pisp003u
end type
type gb_2 from groupbox within w_pisp003u
end type
end forward

global type w_pisp003u from window
integer width = 3291
integer height = 1956
boolean titlebar = true
string title = "평준화 Cycle 설정"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
cb_1 cb_1
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
cb_3 cb_3
cb_2 cb_2
gb_1 gb_1
dw_cycle dw_cycle
gb_2 gb_2
end type
global w_pisp003u w_pisp003u

type variables
Boolean		ib_open, ib_change
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_reset ()
public subroutine wf_retrieve ()
end prototypes

event ue_postopen();
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
wf_reset()
wf_retrieve()

ib_open = True
end event

public subroutine wf_reset ();ib_change = False

cb_1.Enabled	= False
cb_2.Enabled	= False

dw_cycle.ReSet()
end subroutine

public subroutine wf_retrieve ();If dw_cycle.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter) > 0 Then
	cb_1.Enabled	= True
Else
	MessageBox("평준화 Cycle 설정", "평준화 Cycle 정보가 존재하지 않습니다.")
End If
end subroutine

on w_pisp003u.create
this.cb_1=create cb_1
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_3=create cb_3
this.cb_2=create cb_2
this.gb_1=create gb_1
this.dw_cycle=create dw_cycle
this.gb_2=create gb_2
this.Control[]={this.cb_1,&
this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.cb_3,&
this.cb_2,&
this.gb_1,&
this.dw_cycle,&
this.gb_2}
end on

on w_pisp003u.destroy
destroy(this.cb_1)
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.dw_cycle)
destroy(this.gb_2)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type cb_1 from commandbutton within w_pisp003u
integer x = 1961
integer y = 76
integer width = 384
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "초기화 (&I)"
end type

event clicked;Int		i, li_cyclecount
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_maxcyclegubun
Boolean	lb_error

If MessageBox("평준화 Cycle 설정", "초기화를 수행하면 조회한 모든 라인의 평준화 Cycle은 '최다 Cycle' 이 됩니다." + &
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
	MessageBox("평준화 Cycle 설정", "평준화 Cycle을 초기화하는 중에 오류가 발생하였습니다.", StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("평준화 Cycle 설정", "평준화 Cycle을 초기화 하였습니다.", Information!)
	wf_reset()
	wf_retrieve()
End If
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp003u
integer x = 1166
integer y = 96
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_reset()
	wf_retrieve()
End If
end event

type uo_division from u_pisc_select_division within w_pisp003u
integer x = 590
integer y = 96
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_cycle.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	wf_reset()
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp003u
integer x = 64
integer y = 96
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_cycle.SetTransObject(SQLPIS)
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

	wf_reset()
	wf_retrieve()
End If
end event

type cb_3 from commandbutton within w_pisp003u
integer x = 2747
integer y = 76
integer width = 384
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료 (&C)"
end type

event clicked;CloseWithReturn(Parent, "CANCEL")
end event

type cb_2 from commandbutton within w_pisp003u
integer x = 2354
integer y = 76
integer width = 384
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "저 장 (&S)"
end type

event clicked;Int		i, li_cyclecount
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_maxcyclegubun
Boolean	lb_error

If ib_change = False Then
	MessageBox("평준화 Cycle 설정", "변경된 평준화 Cycle이 없습니다.")
	Return
End If

If MessageBox("평준화 Cycle 설정", "변경된 평준화 Cycle을 저장하시겠습니까?", &
							Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

For i = 1 To dw_cycle.RowCount()
	ls_areacode			= Trim(dw_cycle.GetItemString(i, "AreaCode"))
	ls_divisioncode	= Trim(dw_cycle.GetItemString(i, "DivisionCode"))
	ls_workcenter		= Trim(dw_cycle.GetItemString(i, "WorkCenter"))
	ls_linecode			= Trim(dw_cycle.GetItemString(i, "LineCode"))
	li_cyclecount		= dw_cycle.GetItemNumber(i, "CycleCount")
	
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
		lb_error	= False
	Else
		lb_error = True
		Exit
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("평준화 Cycle 설정", "변경된 평준화 Cycle을 저장하는 중에 오류가 발생하였습니다.", StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("평준화 Cycle 설정", "변경된 평준화 Cycle을 저장하였습니다.", Information!)
End If
end event

type gb_1 from groupbox within w_pisp003u
integer x = 23
integer y = 16
integer width = 1851
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "조 선택"
end type

type dw_cycle from datawindow within w_pisp003u
integer x = 27
integer y = 236
integer width = 3195
integer height = 1580
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisp003u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//Visible	= False
end event

event itemchanged;AcceptText()

If row > 0 Then
	ib_change		= True
	cb_2.Enabled	= True
End If
end event

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

type gb_2 from groupbox within w_pisp003u
integer x = 1879
integer y = 16
integer width = 1344
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

