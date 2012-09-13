$PBExportHeader$w_piso040u.srw
$PBExportComments$라인마스터
forward
global type w_piso040u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_piso040u
end type
type uo_area from u_pisc_select_area within w_piso040u
end type
type uo_division from u_pisc_select_division within w_piso040u
end type
type uo_workcenter from u_pisc_select_workcenter within w_piso040u
end type
type uo_line from u_pisc_select_line within w_piso040u
end type
type dw_detail from datawindow within w_piso040u
end type
type st_h_bar from uo_xc_splitbar within w_piso040u
end type
type gb_1 from groupbox within w_piso040u
end type
type gb_2 from groupbox within w_piso040u
end type
end forward

global type w_piso040u from w_ipis_sheet01
integer width = 4110
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
dw_detail dw_detail
st_h_bar st_h_bar
gb_1 gb_1
gb_2 gb_2
end type
global w_piso040u w_piso040u

type variables
Boolean	ib_open, ib_change
end variables

on w_piso040u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_h_bar
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_piso040u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_detail, BELOW)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)

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

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
	uo_status.st_message.text =  "라인마스터 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "라인마스터 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("라인마스터", "라인마스터 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()

ib_change	= False
end event

event ue_save;call super::ue_save;String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, &
			ls_lineshortname, ls_linefullname, &
			ls_lineid, ls_linegubun, ls_kbuseflag, ls_nextrouting, &
			ls_supplygubun, ls_hostworkcenter, ls_hostlinecode, ls_maxcyclegubun
Int		li_capaqty, li_shiftcount, li_shifttime, li_jphqty, li_displaycount, &
			li_cyclecount
Long		ll_find
Decimal	ld_cycletime

dw_detail.AcceptText()

ls_areacode			= Trim(dw_detail.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_detail.GetItemString(1, "DivisionCode"))
ls_workcenter		= Trim(dw_detail.GetItemString(1, "WorkCenter"))
ls_linecode			= Trim(dw_detail.GetItemString(1, "LineCode"))

ls_lineshortname	= Trim(dw_detail.GetItemString(1, "LineShortName"))
ls_linefullname	= Trim(dw_detail.GetItemString(1, "LineFullName"))
//ls_lineid			= Trim(dw_detail.GetItemString(1, "LineID"))
ls_linegubun		= Trim(dw_detail.GetItemString(1, "LineGubun"))
ls_kbuseflag		= Trim(dw_detail.GetItemString(1, "KBUseFlag"))
ls_nextrouting		= Trim(dw_detail.GetItemString(1, "NextRouting"))
ls_supplygubun		= Trim(dw_detail.GetItemString(1, "SupplyGubun"))
ls_hostworkcenter	= Trim(dw_detail.GetItemString(1, "HostWorkCenter"))
ls_hostlinecode	= Trim(dw_detail.GetItemString(1, "HostLineCode"))
li_capaqty			= dw_detail.GetItemNumber(1, "CapaQty")
li_shiftcount		= dw_detail.GetItemNumber(1, "ShiftCount")
li_shifttime		= dw_detail.GetItemNumber(1, "ShiftTime")
ld_cycletime		= dw_detail.GetItemNumber(1, "CycleTime")
li_jphqty			= dw_detail.GetItemNumber(1, "JPHQty")
li_displaycount	= dw_detail.GetItemNumber(1, "DisplayCount")
ls_maxcyclegubun	= Trim(dw_detail.GetItemString(1, "MaxCycleGubun"))
li_cyclecount		= dw_detail.GetItemNumber(1, "CycleCount")

If ls_supplygubun = "Y" Then
	Select	Count(LineCode)
	Into		:ll_find
	From		tmstline
	Where		AreaCode			= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_hostworkcenter		And
				LineCode			= :ls_hostlinecode
	Using SQLPIS;
	
	If ll_find > 0 Then
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

If MessageBox("라인마스터", "변경된 라인마스터 정보를 저장하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Update	tmstline
Set		LineShortName		= :ls_lineshortname,
			LineFullName		= :ls_linefullname,
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
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("라인마스터", "변경된 라인마스터를 저장하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
	ll_find	= 0
	ll_find	= dw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"WorkCenter = '" + ls_workcenter + "' And " + &
								"LineCode = '" + ls_linecode + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then
		dw_1.SetRow(ll_find)
		dw_1.Trigger Event RowFocusChanged(ll_find)
		dw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("라인마스터", "변경된 라인마스터를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

event ue_insert;call super::ue_insert;istr_parms.string_arg[1] = is_size
istr_parms.window_arg[1] = iw_this
istr_parms.datawindow_arg[1] = dw_1

OpenWithParm(w_piso041u, istr_parms)
If Upper(Message.StringParm) = "CHANGE" Then
	iw_this.TriggerEvent("ue_retrieve")
End If
end event

event ue_delete;call super::ue_delete;String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode
Long		ll_count
Decimal	ld_cycletime

If dw_1.GetRow() > 0 Then
	//
Else
	MessageBox("라인마스터", "삭제하시려는 라인마스터를 선택하십시오.", Exclamation!)
	Return
End If

dw_detail.AcceptText()

ls_areacode			= Trim(dw_detail.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_detail.GetItemString(1, "DivisionCode"))
ls_workcenter		= Trim(dw_detail.GetItemString(1, "WorkCenter"))
ls_linecode			= Trim(dw_detail.GetItemString(1, "LineCode"))

ll_count = 0

Select	Count(LineCode)
Into		:ll_count
From		tmstkb
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode
Using SQLPIS;

If ll_count > 0 Then
//	If MessageBox("라인마스터", "선택하신 라인은 간판마스터에 등록되어 있습니다." + &
//									"~r~n~r~n선택하신 라인마스터를 삭제하시겠습니까?", &
//									Question!, YesNo!, 2) = 2 Then
//		Return
//	End If
	MessageBox("라인마스터", "선택하신 라인은 간판마스터에 등록되어 있습니다." + &
									"~r~n~r~n라인마스터를 삭제할 수 없습니다.", &
									StopSign!)
	Return
Else
	If MessageBox("라인마스터", "선택하신 라인마스터 정보를 삭제하시겠습니까?", &
												Question!, YesNo!, 2) = 2 Then
		Return
	End If
End If


SQLPIS.AutoCommit = False

// EIS DB에 반영하기 위해 삭제되는 라인마스터 저장
Insert	tdelete
Select	TableName		= 'tmstline',
			DeleteData		= LTrim(RTrim(A.AreaCode)) + '/' + LTrim(RTrim(A.DivisionCode)) + '/' + LTrim(RTrim(A.WorkCenter)) + '/' + LTrim(RTrim(A.LineCode)),
			DeleteTime		= GetDate(),
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
From		tmstline	A
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	//
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "삭제되는 라인마스터 정보를 저장하는 중에 오류가 발생하였습니다."
	MessageBox("라인 마스터", "삭제되는 라인마스터 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 라인 마스터 삭제
Delete	tmstline
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("라인마스터", "선택하신 라인마스터를 삭제하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("라인마스터", "선택하신 라인마스터를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piso040u
end type

type dw_1 from u_vi_std_datawindow within w_piso040u
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 184
integer width = 645
integer height = 1360
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_piso040u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;//

end event

event rowfocuschanged;String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_supplygubun

If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)

	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
	ls_divisioncode	= Trim(GetItemString(CurrentRow, "DivisionCode"))
	ls_workcenter		= Trim(GetItemString(CurrentRow, "WorkCenter"))
	ls_linecode			= Trim(GetItemString(CurrentRow, "LineCode"))
	ls_supplygubun		= Trim(GetItemString(CurrentRow, "SupplyGubun"))

	ib_change	= False
	dw_detail.ReSet()
	dw_detail.Retrieve(ls_areacode,		ls_divisioncode, &
							ls_workcenter,		ls_linecode)
	dw_detail.Modify("linecode.protect = 1")
	If ls_supplygubun = 'N' Then
		dw_detail.Modify("HostWorkCenter.Visible = 0")
		dw_detail.Modify("HostLineCode.Visible = 0")
		dw_detail.Modify("HostWorkCenter_t.Visible = 0")
		dw_detail.Modify("HostLineCode_t.Visible = 0")
	Else
		dw_detail.Modify("HostWorkCenter.Visible = 1")
		dw_detail.Modify("HostLineCode.Visible = 1")
		dw_detail.Modify("HostWorkCenter_t.Visible = 1")
		dw_detail.Modify("HostLineCode_t.Visible = 1")
	End If
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_piso040u
integer x = 50
integer y = 68
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
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

type uo_division from u_pisc_select_division within w_piso040u
integer x = 549
integer y = 68
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")

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

type uo_workcenter from u_pisc_select_workcenter within w_piso040u
integer x = 1147
integer y = 68
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

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

type uo_line from u_pisc_select_line within w_piso040u
integer x = 1824
integer y = 68
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_detail from datawindow within w_piso040u
integer x = 965
integer y = 700
integer width = 1947
integer height = 1040
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso040u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemerror;Return 1
end event

event itemchanged;Int		li_cyclecount
String	ls_maxcyclegubun

AcceptText()

If row > 0 Then
	CHOOSE CASE Upper(Trim(String(dwo.name))	)
		CASE "CYCLECOUNT"
			ib_change	= True
			If li_cyclecount = 0 Then
				ls_maxcyclegubun = "Y"
			Else
				ls_maxcyclegubun = "N"
			End If
			SetItem(1, "MaxCycleGubun", ls_maxcyclegubun)
		CASE "SUPPLYGUBUN"
			ib_change	= True
			If Data = 'N' Then
				dw_detail.Modify("HostWorkCenter.Visible = 0")
				dw_detail.Modify("HostLineCode.Visible = 0")
				dw_detail.Modify("HostWorkCenter_t.Visible = 0")
				dw_detail.Modify("HostLineCode_t.Visible = 0")
			Else
				dw_detail.Modify("HostWorkCenter.Visible = 1")
				dw_detail.Modify("HostLineCode.Visible = 1")
				dw_detail.Modify("HostWorkCenter_t.Visible = 1")
				dw_detail.Modify("HostLineCode_t.Visible = 1")
			End If
	END CHOOSE
End If
end event

event editchanged;AcceptText()

ib_change	= True
end event

type st_h_bar from uo_xc_splitbar within w_piso040u
integer x = 14
integer y = 1568
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type gb_1 from groupbox within w_piso040u
integer x = 14
integer width = 1111
integer height = 180
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

type gb_2 from groupbox within w_piso040u
integer x = 1129
integer width = 1289
integer height = 180
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

