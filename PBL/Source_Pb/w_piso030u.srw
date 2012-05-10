$PBExportHeader$w_piso030u.srw
$PBExportComments$조마스터
forward
global type w_piso030u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_piso030u
end type
type uo_area from u_pisc_select_area within w_piso030u
end type
type uo_division from u_pisc_select_division within w_piso030u
end type
type uo_workcenter from u_pisc_select_workcenter within w_piso030u
end type
type dw_detail from datawindow within w_piso030u
end type
type st_h_bar from uo_xc_splitbar within w_piso030u
end type
type gb_2 from groupbox within w_piso030u
end type
type gb_3 from groupbox within w_piso030u
end type
end forward

global type w_piso030u from w_ipis_sheet01
integer width = 4110
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
dw_detail dw_detail
st_h_bar st_h_bar
gb_2 gb_2
gb_3 gb_3
end type
global w_piso030u w_piso030u

type variables
Boolean	ib_open
end variables

on w_piso030u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.dw_detail
this.Control[iCurrent+6]=this.st_h_bar
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_3
end on

on w_piso030u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.gb_2)
destroy(this.gb_3)
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
ib_open = True
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter) > 0 Then
	uo_status.st_message.text =  "조마스터 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "조마스터 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("조마스터", "조마스터 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
end event

event ue_insert;call super::ue_insert;istr_parms.string_arg[1] = is_size
istr_parms.window_arg[1] = iw_this
istr_parms.datawindow_arg[1] = dw_1

OpenWithParm(w_piso031u, istr_parms)
If Upper(Message.StringParm) = "CHANGE" Then
	iw_this.TriggerEvent("ue_retrieve")
End If
end event

event ue_delete;call super::ue_delete;String	ls_areacode, ls_divisioncode, ls_workcenter, ls_workcentergubun1, ls_workcentergubun2
Long		ll_count
Decimal	ld_cycletime

If dw_1.GetRow() > 0 Then
	//
Else
	MessageBox("조마스터", "삭제하시려는 조마스터를 선택하십시오.", Exclamation!)
	Return
End If

dw_detail.AcceptText()

ls_areacode				= Trim(dw_detail.GetItemString(1, "AreaCode"))
ls_divisioncode		= Trim(dw_detail.GetItemString(1, "DivisionCode"))
ls_workcenter			= Trim(dw_detail.GetItemString(1, "WorkCenter"))
ls_workcentergubun1	= Trim(dw_detail.GetItemString(1, "WorkCenterGubun1"))
ls_workcentergubun2	= Trim(dw_detail.GetItemString(1, "WorkCenterGubun2"))

If ls_workcentergubun1 <> 'S' Then
	MessageBox("조마스터", "선택하신 조는 사내외주 조가 아닙니다." + &
									"~r~n~r~n사내외주 조만 삭제가 가능합니다.", StopSign!)
	Return
End If

ll_count = 0

Select	Count(WorkCenter)
Into		:ll_count
From		tmstline
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter
Using SQLPIS;

If ll_count > 0 Then
	MessageBox("조마스터", "선택하신 조에는 라인마스터가 등록되어 있습니다.." + &
									"~r~n~r~n라인마스터를 삭제하신 후에 조마스터를 삭제하여 주십시오.", StopSign!)
	Return
End If

If MessageBox("조마스터", "선택하신 사내외주 조마스터 정보를 삭제하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

// EIS DB에 반영하기 위해 삭제되는 조마스터 저장
Insert	tdelete
Select	TableName		= 'tmstworkcenter',
			DeleteData		= LTrim(RTrim(A.AreaCode)) + '/' + LTrim(RTrim(A.DivisionCode)) + '/' + LTrim(RTrim(A.WorkCenter)),
			DeleteTime		= GetDate(),
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
From		tmstworkcenter	A
Where		AreaCode				= :ls_areacode			And
			DivisionCode		= :ls_divisioncode	And
			WorkCenter			= :ls_workcenter		And
			WorkCenterGubun1	= 'S'
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	//
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "삭제되는 조마스터 정보를 저장하는 중에 오류가 발생하였습니다."
	MessageBox("조 마스터", "삭제되는 조마스터 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 조 마스터 삭제
Delete	tmstworkcenter
Where		AreaCode				= :ls_areacode			And
			DivisionCode		= :ls_divisioncode	And
			WorkCenter			= :ls_workcenter		And
			WorkCenterGubun1	= 'S'
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("조마스터", "선택하신 사내외주 조마스터를 삭제하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("조마스터", "선택하신 사내외주 조마스터를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

event ue_save;call super::ue_save;String	ls_areacode, ls_divisioncode, ls_workcenter, &
			ls_workcentername, ls_workcentergubun1, ls_workcentergubun2
Long		ll_find

dw_detail.AcceptText()

ls_areacode				= Trim(dw_detail.GetItemString(1, "AreaCode"))
ls_divisioncode		= Trim(dw_detail.GetItemString(1, "DivisionCode"))
ls_workcenter			= Trim(dw_detail.GetItemString(1, "WorkCenter"))
ls_workcentername		= Trim(dw_detail.GetItemString(1, "WorkCenterName"))
ls_workcentergubun1	= Trim(dw_detail.GetItemString(1, "WorkCenterGubun1"))

If ls_workcentergubun1 <> 'S' Then
	MessageBox("조마스터", "선택하신 조는 사내외주 조가 아닙니다." + &
									"~r~n~r~n사내외주 조만 변경이 가능합니다.", StopSign!)
	Return
End If

If MessageBox("조마스터", "변경된 라인마스터 정보를 저장하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Update	tmstworkcenter
Set		WorkCenterName		= :ls_workcentername,
			LastEmp				= 'Y',
			LastDate				= GetDate()
Where		AreaCode				= :ls_areacode			And
			DivisionCode		= :ls_divisioncode	And
			WorkCenter			= :ls_workcenter		And
			WorkCenterGubun1	= 'S'
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("조마스터", "변경된 조마스터를 저장하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")

	ll_find	= dw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"WorkCenter = '" + ls_workcenter + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then
		dw_1.SetRow(ll_find)
		dw_1.Trigger Event RowFocusChanged(ll_find)
		dw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("조마스터", "변경된 조마스터를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piso030u
end type

type dw_1 from u_vi_std_datawindow within w_piso030u
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 184
integer width = 645
integer height = 1772
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_piso030u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;//

end event

event rowfocuschanged;String	ls_areacode, ls_divisioncode, ls_workcenter, ls_workcentergubun1, &
			ls_mod
Long		ll_color

If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)

	ls_areacode				= Trim(GetItemString(CurrentRow, "AreaCode"))
	ls_divisioncode		= Trim(GetItemString(CurrentRow, "DivisionCode"))
	ls_workcenter			= Trim(GetItemString(CurrentRow, "WorkCenter"))
	ls_workcentergubun1	= Trim(GetItemString(CurrentRow, "WorkCenterGubun1"))

	dw_detail.ReSet()
	dw_detail.Retrieve(ls_areacode,		ls_divisioncode, &
							ls_workcenter)
//	If ls_workcentergubun1 = 'S' Then
//		ll_color	= 16777215
//		ls_mod	= "WorkCenterName.BackGround.Color='" + String(ll_color) + "'" + &
//						"WorkCenterName.protect = 0"
//	Else
//		ll_color	= 12632256
//		ls_mod	= "WorkCenterName.BackGround.Color='" + String(ll_color) + "'" + &
//						"WorkCenterName.protect = 1"
//	End If
	If ls_workcentergubun1 = 'S' Then
		ll_color	= 16777215
		ls_mod	= "WorkCenterName.protect = 0"
	Else
		ll_color	= 12632256
		ls_mod	= "WorkCenterName.protect = 1"
	End If
	dw_detail.Modify(ls_mod)
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_piso030u
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
End If

end event

type uo_division from u_pisc_select_division within w_piso030u
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
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_piso030u
integer x = 1170
integer y = 68
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_detail from datawindow within w_piso030u
integer x = 965
integer y = 700
integer width = 1947
integer height = 724
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso030u_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_piso030u
integer x = 818
integer y = 1512
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type gb_2 from groupbox within w_piso030u
integer x = 1143
integer width = 731
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

type gb_3 from groupbox within w_piso030u
integer x = 14
integer width = 1125
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

