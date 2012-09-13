$PBExportHeader$w_pisp021u.srw
$PBExportComments$Work Calendar - Calendar 복사
forward
global type w_pisp021u from window
end type
type st_month from statictext within w_pisp021u
end type
type st_2 from statictext within w_pisp021u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp021u
end type
type uo_line from u_pisc_select_line within w_pisp021u
end type
type uo_division from u_pisc_select_division within w_pisp021u
end type
type uo_area from u_pisc_select_area within w_pisp021u
end type
type cb_2 from commandbutton within w_pisp021u
end type
type cb_1 from commandbutton within w_pisp021u
end type
type gb_1 from groupbox within w_pisp021u
end type
type dw_save from datawindow within w_pisp021u
end type
end forward

global type w_pisp021u from window
integer width = 1454
integer height = 780
boolean titlebar = true
string title = "Work Calendar 복사"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
st_month st_month
st_2 st_2
uo_workcenter uo_workcenter
uo_line uo_line
uo_division uo_division
uo_area uo_area
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_save dw_save
end type
global w_pisp021u w_pisp021u

type variables
Boolean		ib_open
String		is_applymonth
str_parms	istr_parms
DataWindow	idw_cal_workgubun
end variables

event ue_postopen;dw_save.SetTransObject(SQLPIS)

st_month.Text = is_applymonth

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										True, &
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

f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										True, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)

ib_open = True
end event

on w_pisp021u.create
this.st_month=create st_month
this.st_2=create st_2
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_save=create dw_save
this.Control[]={this.st_month,&
this.st_2,&
this.uo_workcenter,&
this.uo_line,&
this.uo_division,&
this.uo_area,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_save}
end on

on w_pisp021u.destroy
destroy(this.st_month)
destroy(this.st_2)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_save)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]
is_applymonth		= istr_parms.string_arg[2]
idw_cal_workgubun	= istr_parms.datawindow_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type st_month from statictext within w_pisp021u
integer x = 306
integer y = 124
integer width = 402
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisp021u
integer x = 64
integer y = 124
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기준월:"
boolean focusrectangle = false
end type

type uo_workcenter from u_pisc_select_workcenter within w_pisp021u
integer x = 178
integer y = 396
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If
end event

type uo_line from u_pisc_select_line within w_pisp021u
integer x = 128
integer y = 488
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

type uo_division from u_pisc_select_division within w_pisp021u
integer x = 128
integer y = 304
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_save.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If

end event

type uo_area from u_pisc_select_area within w_pisp021u
integer x = 128
integer y = 212
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_save.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											True, &
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
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If
end event

type cb_2 from commandbutton within w_pisp021u
integer x = 992
integer y = 172
integer width = 393
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;CloseWithReturn(Parent, "CANCEL")
end event

type cb_1 from commandbutton within w_pisp021u
integer x = 992
integer y = 48
integer width = 393
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저 장(&S)"
end type

event clicked;int		i, li_julianday
String	ls_workgubun, ls_applydate, ls_errortext
Boolean	lb_error

If MessageBox("Work Carlendar","Work Carlendar 정보를 저장하시겠습니까 ?", Question!, YesNo!) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False
For i = 1 To idw_cal_workgubun.RowCount()
	ls_applydate	= Trim(idw_cal_workgubun.GetItemString(i, "ApplyDate"))
	ls_workgubun	= Trim(idw_cal_workgubun.GetItemString(i, "WorkGubun"))
	li_julianday	= idw_cal_workgubun.GetItemNumber(i, "DayNo")
	
	dw_save.ReSet()
	If dw_save.Retrieve(is_applymonth,				ls_applydate, &
					uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
					uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
					li_julianday,							ls_workgubun, &
					g_s_empno) > 0 Then
		If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
			lb_error	= False
			ls_errortext = Trim(dw_save.GetItemString(1, "ErrorText"))
		Else
			lb_error = True
			ls_errortext = Trim(dw_save.GetItemString(1, "ErrorText"))
			Exit
		End If
	Else
		lb_error = True
		ls_errortext = "Work Calendar 복사를 시도하였지만 오류가 발생했습니다."
		Exit
	End If

//	li_count = 0
//
//	Select	Count(ApplyDate)
//	Into		:li_count
//	From		tcalendarwork
//	Where		AreaCode			= :uo_area.is_uo_areacode
//	And		DivisionCode	= :uo_division.is_uo_divisioncode
//	And		WorkCenter		= :uo_workcenter.is_uo_workcenter
//	And		LineCode			= :uo_line.is_uo_linecode
//	And		ApplyMonth		= :uo_month.is_uo_month
//	And		ApplyDate		= :ls_applydate
//	Using	SQLPIS;
//	
//	If li_count > 0 Then
//
//		Update	tcalendarwork
//			Set	WorkGubun		= :ls_workgubun,
//					LastEmp			= :g_s_empno,
//					LastDate			= GetDate()
//		 Where	AreaCode			= :uo_area.is_uo_areacode
//			And	DivisionCode	= :uo_division.is_uo_divisioncode
//			And	WorkCenter		= :uo_workcenter.is_uo_workcenter
//			And	LineCode			= :uo_line.is_uo_linecode
//			And	ApplyMonth		= :uo_month.is_uo_month
//			And	ApplyDate		= :ls_applydate
//		Using SQLPIS;
//		If SQLPIS.sqlcode = 0 Then
//			lb_error	= False
//		Else
//			lb_error = True
//			Exit
//		End If
//	Else
//		Insert Into tcalendarwork	(AreaCode,								DivisionCode,
//											WorkCenter,								LineCode,
//											ApplyMonth,								ApplyDate,
//											DayNo,									WorkGubun,
//											Remark,
//											LastEmp,									LastDate)
//		Values							(:uo_area.is_uo_areacode,			:uo_division.is_uo_divisioncode,
//											:uo_workcenter.is_uo_workcenter,	:uo_line.is_uo_linecode,
//											:uo_month.is_uo_month,				:ls_applydate,
//											:li_julianday,							:ls_workgubun,
//											Null,
//											:g_s_empno,								GetDate())
//		Using SQLPIS;
//		If SQLPIS.sqlcode = 0 Then
//			lb_error	= False
//		Else
//			lb_error = True
//			Exit
//		End If
//	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
//	uo_status.st_message.text =  "Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("Work Calendar", "Work Calendar 정보를 저장하는 중에 오류가 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
//	uo_status.st_message.text =  "Work Calendar 정보를 변경하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
	MessageBox("Work Calendar", "Work Calendar 정보를 저장하였습니다.", Information!)
End If

//CloseWithReturn(Parent, "CHANGE")
end event

type gb_1 from groupbox within w_pisp021u
integer x = 23
integer y = 20
integer width = 933
integer height = 616
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "복사하려는 라인 선택"
borderstyle borderstyle = stylelowered!
end type

type dw_save from datawindow within w_pisp021u
integer x = 859
integer y = 304
integer width = 558
integer height = 380
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_pisp021u_01_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

