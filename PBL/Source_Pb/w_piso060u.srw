$PBExportHeader$w_piso060u.srw
$PBExportComments$단말기/라인 관리 마스터
forward
global type w_piso060u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_piso060u
end type
type uo_area from u_pisc_select_area within w_piso060u
end type
type uo_division from u_pisc_select_division within w_piso060u
end type
type dw_detail from datawindow within w_piso060u
end type
type st_h_bar from uo_xc_splitbar within w_piso060u
end type
type gb_1 from groupbox within w_piso060u
end type
end forward

global type w_piso060u from w_ipis_sheet01
integer width = 4110
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
dw_detail dw_detail
st_h_bar st_h_bar
gb_1 gb_1
end type
global w_piso060u w_piso060u

type variables
Boolean	ib_open
end variables

on w_piso060u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_detail
this.Control[iCurrent+5]=this.st_h_bar
this.Control[iCurrent+6]=this.gb_1
end on

on w_piso060u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.gb_1)
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
ib_open = True
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						"%") > 0 Then
	uo_status.st_message.text =  "단말기/라인 관리 마스터 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "단말기/라인 관리 마스터 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("단말기/라인 관리 마스터", "단말기/라인 관리 마스터 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
end event

event ue_insert;call super::ue_insert;Int		li_row_trm, li_row_line
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_terminalcode
Long		ll_count, ll_find

li_row_trm	= dw_1.GetRow()
li_row_line	= dw_detail.GetRow()

If li_row_trm > 0 Then
	//
Else
	MessageBox("단말기/라인 관리 마스터", "추가하시려는 단말기를 선택하십시오.", Exclamation!)
	Return
End If

If li_row_line > 0 Then
	//
Else
	MessageBox("단말기/라인 관리 마스터", "추가하시려는 라인을 선택하십시오.", Exclamation!)
	Return
End If

ls_terminalcode	= Trim(dw_1.GetItemString(li_row_trm, "TerminalCode"))
ls_areacode			= Trim(dw_detail.GetItemString(li_row_line, "AreaCode"))
ls_divisioncode	= Trim(dw_detail.GetItemString(li_row_line, "DivisionCode"))
ls_workcenter		= Trim(dw_detail.GetItemString(li_row_line, "WorkCenter"))
ls_linecode			= Trim(dw_detail.GetItemString(li_row_line, "LineCode"))

ll_count = 0

Select	Count(TerminalCode)
Into		:ll_count
From		tmstterminalline
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			TerminalCode	= :ls_terminalcode
Using SQLPIS;

If ll_count > 0 Then
	MessageBox("단말기/라인 관리 마스터", "선택한 단말기 및 라인 코드는 이미 등록되어 있습니다." + &
									"~r~n~r~n새로운 라인 코드를 선택하십시오.", StopSign!)
	Return
End If

If MessageBox("단말기/라인 관리 마스터", "선택하신 단말기/라인 관리 마스터 정보를 추가하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Insert	tmstterminalline
Select	AreaCode				= :ls_areacode,
			DivisionCode		= :ls_divisioncode,
			WorkCenter			= :ls_workcenter,
			LineCode				= :ls_linecode,
			TerminalCode		= :ls_terminalcode,
			MainLineGubun		= Null,
			PrdGatherGubun		= Null,
			LastEmp				= 'Y',
			LastDate				= GetDate()
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("단말기/라인 관리 마스터", "선택하신 단말기/라인 관리 마스터를 추가하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
	ll_find	= 0
	ll_find	= dw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"WorkCenter = '" + ls_workcenter + "' And " + &
								"LineCode = '" + ls_linecode + "' And " + &
								"TerminalCode = '" + ls_terminalcode + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then
		dw_1.SetRow(ll_find)
		dw_1.Trigger Event RowFocusChanged(ll_find)
		dw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("단말기/라인 관리 마스터", "선택하신 단말기/라인 관리 마스터를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

event ue_delete;Int		li_row
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_terminalcode

li_row = dw_1.GetRow()

If li_row > 0 Then
	//
Else
	MessageBox("단말기/라인 관리 마스터", "삭제하시려는 단말기/라인 관리 마스터를 선택하십시오.", Exclamation!)
	Return
End If

ls_areacode			= Trim(dw_1.GetItemString(li_row, "AreaCode"))
ls_divisioncode	= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
ls_workcenter		= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
ls_linecode			= Trim(dw_1.GetItemString(li_row, "LineCode"))
ls_terminalcode	= Trim(dw_1.GetItemString(li_row, "TerminalCode"))

If ls_areacode = "" Or IsNull(ls_areacode) = True Or Len(ls_areacode) = 0 Or &
	ls_divisioncode = "" Or IsNull(ls_divisioncode) = True Or Len(ls_divisioncode) = 0 Then
	MessageBox("단말기/라인 관리 마스터", "선택하신 단말기는 단말기/라인 관리 마스터에 등록되어 있지 않습니다.", StopSign!)
	Return
End If

If MessageBox("단말기/라인 관리 마스터", "선택하신 단말기/라인 관리 마스터 정보를 삭제하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Delete	tmstterminalline
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			TerminalCode	= :ls_terminalcode
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("단말기/라인 관리 마스터", "선택하신 단말기/라인 관리 마스터를 삭제하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("단말기/라인 관리 마스터", "선택하신 단말기/라인 관리 마스터를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piso060u
end type

type dw_1 from u_vi_std_datawindow within w_piso060u
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 184
integer width = 645
integer height = 1536
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_piso060u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;//

end event

event rowfocuschanged;String	ls_areacode, ls_divisioncode, ls_terminalcode

If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)

//	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
//	ls_divisioncode	= Trim(GetItemString(CurrentRow, "DivisionCode"))
	ls_areacode			= uo_area.is_uo_areacode
	ls_divisioncode	= uo_division.is_uo_divisioncode
	ls_terminalcode	= Trim(GetItemString(CurrentRow, "TerminalCode"))

	dw_detail.ReSet()
	dw_detail.Retrieve(ls_areacode,	ls_divisioncode, ls_terminalcode)
//	dw_detail.Modify("terminalcode.protect = 1")
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_piso060u
integer x = 50
integer y = 68
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;If ib_open Then
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
End If

end event

type uo_division from u_pisc_select_division within w_piso060u
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
End If

end event

type dw_detail from datawindow within w_piso060u
integer x = 887
integer y = 600
integer width = 1947
integer height = 544
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso060u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

type st_h_bar from uo_xc_splitbar within w_piso060u
integer x = 878
integer y = 468
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type gb_1 from groupbox within w_piso060u
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

