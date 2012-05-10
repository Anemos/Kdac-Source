$PBExportHeader$w_piso041u.srw
$PBExportComments$라인마스터 - 신규등록
forward
global type w_piso041u from window
end type
type uo_workcenter from u_pisc_select_workcenter within w_piso041u
end type
type uo_division from u_pisc_select_division within w_piso041u
end type
type uo_area from u_pisc_select_area within w_piso041u
end type
type cb_2 from commandbutton within w_piso041u
end type
type cb_1 from commandbutton within w_piso041u
end type
type gb_1 from groupbox within w_piso041u
end type
type dw_line from datawindow within w_piso041u
end type
type gb_2 from groupbox within w_piso041u
end type
end forward

global type w_piso041u from window
integer width = 3493
integer height = 1468
boolean titlebar = true
string title = "라인마스터 등록"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_line dw_line
gb_2 gb_2
end type
global w_piso041u w_piso041u

type variables
Boolean		ib_open, ib_save
str_parms	istr_parms
window		iw_sheet
datawindow	idw_1
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;dw_line.SetTransObject(SQLPIS)

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

wf_retrieve()

ib_open = True
end event

public subroutine wf_retrieve ();Long		ll_background_color
String	ls_mod

cb_1.Enabled	= False

ll_background_color	= 16777215

dw_line.ReSet()
dw_line.InsertRow(0)

ls_mod	= "LineCode.BackGround.Color = '" + String(ll_background_color) + "' "

dw_line.Modify(ls_mod)

dw_line.SetItem(1, "AreaCode", uo_area.is_uo_areacode)
dw_line.SetItem(1, "AreaName", uo_area.is_uo_areaname)
dw_line.SetItem(1, "DivisionCode", uo_division.is_uo_divisioncode)
dw_line.SetItem(1, "DivisionName", uo_division.is_uo_divisionname)
dw_line.SetItem(1, "WorkCenter", uo_workcenter.is_uo_workcenter)
dw_line.SetItem(1, "WorkCenterName", uo_workcenter.is_uo_workcentername)
dw_line.SetItem(1, "LineGubun", "A")
dw_line.SetItem(1, "KBUseFlag", "Y")
dw_line.SetItem(1, "NextRouting", "W")
dw_line.SetItem(1, "SupplyGubun", "N")
dw_line.SetItem(1, "CapaQty", 0)
dw_line.SetItem(1, "ShiftCount", 2)
dw_line.SetItem(1, "ShiftTime", 8)
dw_line.SetItem(1, "CycleTime", 0)
dw_line.SetItem(1, "JPHQty", 0)
dw_line.SetItem(1, "DisplayCount", 5)
dw_line.SetItem(1, "MaxCycleGubun", "N")
dw_line.SetItem(1, "CycleCount", 1)

dw_line.Modify("HostWorkCenter.Visible = 0")
dw_line.Modify("HostLineCode.Visible = 0")
dw_line.Modify("HostWorkCenter_t.Visible = 0")
dw_line.Modify("HostLineCode_t.Visible = 0")

end subroutine

on w_piso041u.create
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_line=create dw_line
this.gb_2=create gb_2
this.Control[]={this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_line,&
this.gb_2}
end on

on w_piso041u.destroy
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_line)
destroy(this.gb_2)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size		= istr_parms.string_arg[1]
iw_sheet		= istr_parms.window_arg[1]
idw_1			= istr_parms.datawindow_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type uo_workcenter from u_pisc_select_workcenter within w_piso041u
integer x = 1166
integer y = 96
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type uo_division from u_pisc_select_division within w_piso041u
integer x = 590
integer y = 96
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_line.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											False, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_piso041u
integer x = 64
integer y = 96
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_line.SetTransObject(SQLPIS)
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
	wf_retrieve()
End If
end event

type cb_2 from commandbutton within w_piso041u
integer x = 2377
integer y = 76
integer width = 411
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;//If ib_save Then
//	CloseWithReturn(Parent, "CHANGE")
//Else
	CloseWithReturn(Parent, "CANCEL")
//End If
end event

type cb_1 from commandbutton within w_piso041u
integer x = 1957
integer y = 76
integer width = 411
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "저 장(&S)"
end type

event clicked;String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, &
			ls_lineshortname, ls_linefullname, &
			ls_lineid, ls_linegubun, ls_kbuseflag, ls_nextrouting, &
			ls_supplygubun, ls_hostworkcenter, ls_hostlinecode, ls_maxcyclegubun
Int		li_capaqty, li_shiftcount, li_shifttime, li_jphqty, li_displaycount, &
			li_cyclecount
Long		ll_count, ll_find
Decimal	ld_cycletime

dw_line.AcceptText()

ls_areacode			= Trim(dw_line.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_line.GetItemString(1, "DivisionCode"))
ls_workcenter		= Trim(dw_line.GetItemString(1, "WorkCenter"))
ls_linecode			= Trim(dw_line.GetItemString(1, "LineCode"))

ls_lineshortname	= Trim(dw_line.GetItemString(1, "LineShortName"))
ls_linefullname	= Trim(dw_line.GetItemString(1, "LineFullName"))
//ls_lineid			= Trim(dw_line.GetItemString(1, "LineID"))
ls_linegubun		= Trim(dw_line.GetItemString(1, "LineGubun"))
ls_kbuseflag		= Trim(dw_line.GetItemString(1, "KBUseFlag"))
ls_nextrouting		= Trim(dw_line.GetItemString(1, "NextRouting"))
ls_supplygubun		= Trim(dw_line.GetItemString(1, "SupplyGubun"))
ls_hostworkcenter	= Trim(dw_line.GetItemString(1, "HostWorkCenter"))
ls_hostlinecode	= Trim(dw_line.GetItemString(1, "HostLineCode"))
li_capaqty			= dw_line.GetItemNumber(1, "CapaQty")
li_shiftcount		= dw_line.GetItemNumber(1, "ShiftCount")
li_shifttime		= dw_line.GetItemNumber(1, "ShiftTime")
ld_cycletime		= dw_line.GetItemNumber(1, "CycleTime")
li_jphqty			= dw_line.GetItemNumber(1, "JPHQty")
li_displaycount	= dw_line.GetItemNumber(1, "DisplayCount")
ls_maxcyclegubun	= Trim(dw_line.GetItemString(1, "MaxCycleGubun"))
li_cyclecount		= dw_line.GetItemNumber(1, "CycleCount")

If ls_linecode = "" Or IsNull(ls_linecode) = True Or Len(ls_linecode) <> 1 Then
	MessageBox("라인마스터", "정확한 라인 코드를 등록하십시오.", StopSign!)
	Return
End If

If ls_lineshortname = "" Or IsNull(ls_lineshortname) = True Or Len(ls_lineshortname) = 0 Then
	MessageBox("라인마스터", "정확한 라인단축명을 등록하십시오.", StopSign!)
	Return
End If

If ls_linefullname = "" Or IsNull(ls_linefullname) = True Or Len(ls_linefullname) = 0 Then
	MessageBox("라인마스터", "정확한 라인명을 등록하십시오.", StopSign!)
	Return
End If

ll_count = 0

Select	Count(LineCode)
Into		:ll_count
From		tmstline
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode
Using SQLPIS;

If ll_count > 0 Then
	MessageBox("라인마스터", "등록한 라인 코드는 이미 등록되어 있습니다." + &
									"~r~n~r~n새로운 라인 코드를 등록하십시오.", StopSign!)
	Return
End If

ll_count = 0
If ls_supplygubun = "Y" Then
	Select	Count(LineCode)
	Into		:ll_count
	From		tmstline
	Where		AreaCode			= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_hostworkcenter		And
				LineCode			= :ls_hostlinecode
	Using SQLPIS;
	
	If ll_count > 0 Then
		//
	Else
		MessageBox("라인마스터", "외주라인의 경우 'Host 입고실적 조코드 및 라인코드'을 등록해야 합니다." + &
										"~r~n~r~n정확한 조코드 및 라인코드를 등록하십시오.", StopSign!)
		Return
	End If
Else
	SetNull(ls_hostworkcenter)
	SetNull(ls_hostlinecode)
End If

If MessageBox("라인마스터", "새로운 라인마스터 정보를 저장하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Insert	tmstline
Select	AreaCode				= :ls_areacode,
			DivisionCode		= :ls_divisioncode,
			WorkCenter			= :ls_workcenter,
			LineCode				= :ls_linecode,
			LineShortName		= :ls_lineshortname,
			LineFullName		= :ls_linefullname,
			LineID				= Null,
			LineGubun			= :ls_linegubun,
			KBUseFlag			= :ls_kbuseflag,
			NextRouting			= :ls_nextrouting,
			SupplyGubun			= :ls_supplygubun,
			HostWorkCenter		= :ls_hostworkcenter,
			HostLineCode		= :ls_hostlinecode,
			CapaQty				= :li_capaqty,
			ShiftCount			= :li_shiftcount,
			ShiftTime			= :li_shifttime,
			CycleTime			= :ld_cycletime,
			JPHQty				= :li_jphqty,
			DisplayCount		= :li_displaycount,
			MaxCycleGubun		= :ls_maxcyclegubun,
			CycleCount			= :li_cyclecount,
			LastEmp				= 'Y',
			LastDate				= GetDate()
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	MessageBox("라인마스터", "새로운 라인마스터를 저장하였습니다.", Information!)
	wf_retrieve()
	iw_sheet.TriggerEvent("ue_retrieve")
	ll_find	= idw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"WorkCenter = '" + ls_workcenter + "' And " + &
								"LineCode = '" + ls_linecode + "'", 1, idw_1.RowCount())
	If ll_find > 0 Then
		idw_1.SetRow(ll_find)
		idw_1.Trigger Event RowFocusChanged(ll_find)
		idw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("라인마스터", "새로운 라인마스터를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

type gb_1 from groupbox within w_piso041u
integer x = 23
integer y = 16
integer width = 1870
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
borderstyle borderstyle = stylelowered!
end type

type dw_line from datawindow within w_piso041u
integer x = 27
integer y = 236
integer width = 3397
integer height = 1108
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso040u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;Int		li_cyclecount
String	ls_maxcyclegubun

AcceptText()

If row > 0 Then
	cb_1.Enabled	= True
	CHOOSE CASE Upper(Trim(String(dwo.name))	)
		CASE "CYCLECOUNT"
			If li_cyclecount = 0 Then
				ls_maxcyclegubun = "Y"
			Else
				ls_maxcyclegubun = "N"
			End If
			SetItem(1, "MaxCycleGubun", ls_maxcyclegubun)
		CASE "SUPPLYGUBUN"
			If Data = 'N' Then
				dw_line.Modify("HostWorkCenter.Visible = 0")
				dw_line.Modify("HostLineCode.Visible = 0")
				dw_line.Modify("HostWorkCenter_t.Visible = 0")
				dw_line.Modify("HostLineCode_t.Visible = 0")
			Else
				dw_line.Modify("HostWorkCenter.Visible = 1")
				dw_line.Modify("HostLineCode.Visible = 1")
				dw_line.Modify("HostWorkCenter_t.Visible = 1")
				dw_line.Modify("HostLineCode_t.Visible = 1")
			End If
	END CHOOSE
End If
end event

event editchanged;AcceptText()

If row > 0 Then
	cb_1.Enabled	= True
End If
end event

event itemerror;Return 1
end event

type gb_2 from groupbox within w_piso041u
integer x = 1897
integer y = 16
integer width = 955
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

