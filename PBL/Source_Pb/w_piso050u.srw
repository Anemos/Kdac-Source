$PBExportHeader$w_piso050u.srw
$PBExportComments$�ܸ��⸶����
forward
global type w_piso050u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_piso050u
end type
type uo_area from u_pisc_select_area within w_piso050u
end type
type uo_division from u_pisc_select_division within w_piso050u
end type
type dw_detail from datawindow within w_piso050u
end type
type st_h_bar from uo_xc_splitbar within w_piso050u
end type
type gb_1 from groupbox within w_piso050u
end type
end forward

global type w_piso050u from w_ipis_sheet01
integer width = 4110
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
dw_detail dw_detail
st_h_bar st_h_bar
gb_1 gb_1
end type
global w_piso050u w_piso050u

type variables
Boolean	ib_open, ib_change
end variables

on w_piso050u.create
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

on w_piso050u.destroy
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
	uo_status.st_message.text =  "�ܸ��⸶���� ����" //+ f_message("����� ����Ÿ�� �����ϴ�.")
Else
	uo_status.st_message.text =  "�ܸ��⸶���� ������ �������� �ʽ��ϴ�" //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("�ܸ��⸶����", "�ܸ��⸶���� ������ �������� �ʽ��ϴ�")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()

ib_change	= False
end event

event ue_save;call super::ue_save;String	ls_areacode, ls_divisioncode, ls_terminalcode, ls_terminalname, ls_terminalip
Long		ll_find

dw_detail.AcceptText()

ls_areacode			= Trim(dw_detail.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_detail.GetItemString(1, "DivisionCode"))
ls_terminalcode	= Trim(dw_detail.GetItemString(1, "TerminalCode"))
ls_terminalname	= Trim(dw_detail.GetItemString(1, "TerminalName"))
ls_terminalip		= Trim(dw_detail.GetItemString(1, "TerminalIP"))

If MessageBox("�ܸ��⸶����", "����� �ܸ��⸶���� ������ �����Ͻðڽ��ϱ�?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Update	tmstterminal
Set		TerminalName		= :ls_terminalname,
			TerminalIP			= :ls_terminalip,
			LastEmp				= 'Y',
			LastDate				= GetDate()
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			TerminalCode	= :ls_terminalcode
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("�ܸ��⸶����", "����� �ܸ��⸶���͸� �����Ͽ����ϴ�.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
	ll_find	= 0
	ll_find	= dw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"TerminalCode = '" + ls_terminalcode + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then
		dw_1.SetRow(ll_find)
		dw_1.Trigger Event RowFocusChanged(ll_find)
		dw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("�ܸ��⸶����", "����� �ܸ��⸶���͸� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
End If

end event

event ue_insert;call super::ue_insert;istr_parms.string_arg[1] = is_size
istr_parms.window_arg[1] = iw_this
istr_parms.datawindow_arg[1] = dw_1

OpenWithParm(w_piso051u, istr_parms)
If Upper(Message.StringParm) = "CHANGE" Then
	iw_this.TriggerEvent("ue_retrieve")
End If
end event

event ue_delete;call super::ue_delete;String	ls_areacode, ls_divisioncode, ls_terminalcode
Long		ll_count

If dw_1.GetRow() > 0 Then
	//
Else
	MessageBox("�ܸ��⸶����", "�����Ͻ÷��� �ܸ��⸶���͸� �����Ͻʽÿ�.", Exclamation!)
	Return
End If

dw_detail.AcceptText()

ls_areacode			= Trim(dw_detail.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_detail.GetItemString(1, "DivisionCode"))
ls_terminalcode	= Trim(dw_detail.GetItemString(1, "TerminalCode"))

ll_count = 0

Select	Count(LineCode)
Into		:ll_count
From		tmstterminalline
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			TerminalCode	= :ls_terminalcode
Using SQLPIS;

If ll_count > 0 Then
	If MessageBox("�ܸ��⸶����", "�����Ͻ� �ܸ���� �ܸ���/���� ���� �����Ϳ� ��ϵǾ� �ֽ��ϴ�." + &
									"~r~n~r~n�����Ͻ� �ܸ��⸶���͸� �����Ͻðڽ��ϱ�?", &
									Question!, YesNo!, 2) = 2 Then
		Return
	End If
Else
	If MessageBox("�ܸ��⸶����", "�����Ͻ� �ܸ��⸶���� ������ �����Ͻðڽ��ϱ�?", &
												Question!, YesNo!, 2) = 2 Then
		Return
	End If
End If


SQLPIS.AutoCommit = False

Delete	tmstterminal
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			TerminalCode	= :ls_terminalcode
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("�ܸ��⸶����", "�����Ͻ� �ܸ��⸶���͸� �����Ͽ����ϴ�.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("�ܸ��⸶����", "�����Ͻ� �ܸ��⸶���͸� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
End If

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piso050u
end type

type dw_1 from u_vi_std_datawindow within w_piso050u
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 184
integer width = 645
integer height = 1632
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_piso050u_01"
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

	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
	ls_divisioncode	= Trim(GetItemString(CurrentRow, "DivisionCode"))
	ls_terminalcode	= Trim(GetItemString(CurrentRow, "TerminalCode"))

	ib_change	= False
	dw_detail.ReSet()
	dw_detail.Retrieve(ls_areacode,	ls_divisioncode, ls_terminalcode)
	dw_detail.Modify("terminalcode.protect = 1")
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_piso050u
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

type uo_division from u_pisc_select_division within w_piso050u
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

type dw_detail from datawindow within w_piso050u
integer x = 887
integer y = 600
integer width = 1947
integer height = 544
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso050u_02"
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

//If row > 0 Then
//	CHOOSE CASE Upper(Trim(String(dwo.name))	)
//		CASE "CYCLECOUNT"
//			ib_change	= True
//			If li_cyclecount = 0 Then
//				ls_maxcyclegubun = "Y"
//			Else
//				ls_maxcyclegubun = "N"
//			End If
//			SetItem(1, "MaxCycleGubun", ls_maxcyclegubun)
//		CASE "SUPPLYGUBUN"
//			ib_change	= True
//			If Data = 'N' Then
//				dw_detail.Modify("HostWorkCenter.Visible = 0")
//				dw_detail.Modify("HostLineCode.Visible = 0")
//				dw_detail.Modify("HostWorkCenter_t.Visible = 0")
//				dw_detail.Modify("HostLineCode_t.Visible = 0")
//			Else
//				dw_detail.Modify("HostWorkCenter.Visible = 1")
//				dw_detail.Modify("HostLineCode.Visible = 1")
//				dw_detail.Modify("HostWorkCenter_t.Visible = 1")
//				dw_detail.Modify("HostLineCode_t.Visible = 1")
//			End If
//	END CHOOSE
//End If
end event

event editchanged;AcceptText()

ib_change	= True
end event

type st_h_bar from uo_xc_splitbar within w_piso050u
integer x = 878
integer y = 468
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type gb_1 from groupbox within w_piso050u
integer x = 14
integer width = 1111
integer height = 180
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

