$PBExportHeader$w_piso101u.srw
$PBExportComments$�޼������� ���� - ���
forward
global type w_piso101u from window
end type
type uo_division from u_pisc_select_division within w_piso101u
end type
type uo_area from u_pisc_select_area within w_piso101u
end type
type cb_2 from commandbutton within w_piso101u
end type
type cb_1 from commandbutton within w_piso101u
end type
type gb_1 from groupbox within w_piso101u
end type
type dw_ip from datawindow within w_piso101u
end type
type gb_2 from groupbox within w_piso101u
end type
end forward

global type w_piso101u from window
integer width = 2354
integer height = 860
boolean titlebar = true
string title = "�޽��� ���"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
uo_division uo_division
uo_area uo_area
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_ip dw_ip
gb_2 gb_2
end type
global w_piso101u w_piso101u

type variables
Boolean		ib_open, ib_save
str_parms	istr_parms
window		iw_sheet
datawindow	idw_1
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;dw_ip.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
wf_retrieve()

ib_open = True
end event

public subroutine wf_retrieve ();Long		ll_background_color
String	ls_mod

cb_1.Enabled	= False

ll_background_color	= 16777215

dw_ip.ReSet()
dw_ip.InsertRow(0)

ls_mod	= "MessageGubun.BackGround.Color = '" + String(ll_background_color) + "' " + &
				"PCIP.BackGround.Color = '" + String(ll_background_color) + "' "

dw_ip.Modify(ls_mod)

dw_ip.SetItem(1, "AreaCode", uo_area.is_uo_areacode)
dw_ip.SetItem(1, "DivisionCode", uo_division.is_uo_divisioncode)
end subroutine

on w_piso101u.create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_ip=create dw_ip
this.gb_2=create gb_2
this.Control[]={this.uo_division,&
this.uo_area,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_ip,&
this.gb_2}
end on

on w_piso101u.destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_ip)
destroy(this.gb_2)
end on

event open;String		ls_size

//Pareant Window�� �߾����� Window�� �̵���Ű�� ���Ͽ� Parent Window�� X,Y,Width,Height ���� ���Ѵ�.
istr_parms	= Message.PowerObjectParm

ls_size		= istr_parms.string_arg[1]
iw_sheet		= istr_parms.window_arg[1]
idw_1			= istr_parms.datawindow_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type uo_division from u_pisc_select_division within w_piso101u
integer x = 590
integer y = 96
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_ip.SetTransObject(SQLPIS)
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_piso101u
integer x = 64
integer y = 96
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_ip.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	wf_retrieve()
End If
end event

type cb_2 from commandbutton within w_piso101u
integer x = 1819
integer y = 76
integer width = 411
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�� ��(&C)"
end type

event clicked;//If ib_save Then
//	CloseWithReturn(Parent, "CHANGE")
//Else
	CloseWithReturn(Parent, "CANCEL")
//End If
end event

type cb_1 from commandbutton within w_piso101u
integer x = 1399
integer y = 76
integer width = 411
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string text = "�� ��(&S)"
end type

event clicked;Long		ll_count, ll_find
String	ls_areacode, ls_divisioncode, ls_messagegubun, ls_pcip, ls_pcemp, ls_pcname

dw_ip.AcceptText()

ls_areacode			= Trim(dw_ip.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_ip.GetItemString(1, "DivisionCode"))
ls_messagegubun	= Trim(dw_ip.GetItemString(1, "MessageGubun"))
ls_pcip				= Trim(dw_ip.GetItemString(1, "PCIP"))
ls_pcemp				= Trim(dw_ip.GetItemString(1, "PCEmp"))
ls_pcname			= Trim(dw_ip.GetItemString(1, "PCName"))

If ls_messagegubun = "" Or IsNull(ls_messagegubun) = True Or Len(ls_messagegubun) = 0 Then
	MessageBox("�޼������� ����", "��Ȯ�� �޼��� ���� �ڵ带 ����Ͻʽÿ�.", StopSign!)
	Return
End If

If ls_pcip = "" Or IsNull(ls_pcip) = True Or Len(ls_pcip) = 0 Then
	MessageBox("�޼������� ����", "��Ȯ�� IP Address �ڵ带 ����Ͻʽÿ�.", StopSign!)
	Return
End If

ll_count = 0

Select	Count(PCIP)
Into		:ll_count
From		tmstip
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			MessageGubun	= :ls_messagegubun	And
			PCIP				= :ls_pcip
Using SQLPIS;

If ll_count > 0 Then
	MessageBox("�޼������� ����", "����� �޼������� �� IP Address �� �̹� ��ϵǾ� �ֽ��ϴ�." + &
									"~r~n~r~n���ο� �޼������� �� IP Address �� ����Ͻʽÿ�.", StopSign!)
	Return
End If

If MessageBox("�޼������� ����", "���ο� �޼������� ���� ������ �����Ͻðڽ��ϱ�?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Insert	tmstip
Select	AreaCode				= :ls_areacode,
			DivisionCode		= :ls_divisioncode,
			MessageGubun		= :ls_messagegubun,
			PCIP					= :ls_pcip,
			PCEmp					= :ls_pcemp,
			PCName				= :ls_pcname,
			PCWorkGubun			= Null,
			LastEmp				= 'Y',
			LastDate				= GetDate()
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	MessageBox("�޼������� ����", "���ο� �޼������� ���� ������ �����Ͽ����ϴ�.", Information!)
	wf_retrieve()
	iw_sheet.TriggerEvent("ue_retrieve")
	ll_find	= idw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"MessageGubun = '" + ls_messagegubun + "' And " + &
								"PCIP = '" + ls_pcip + "'", 1, idw_1.RowCount())	
	If ll_find > 0 Then
		idw_1.SetRow(ll_find)
		idw_1.Trigger Event RowFocusChanged(ll_find)
		idw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("�޼������� ����", "���ο� �޼������� ���� ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
End If

end event

type gb_1 from groupbox within w_piso101u
integer x = 23
integer y = 16
integer width = 1307
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
string text = "���� ����"
borderstyle borderstyle = stylelowered!
end type

type dw_ip from datawindow within w_piso101u
integer x = 27
integer y = 236
integer width = 2267
integer height = 496
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso100u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;Int		li_cyclecount
String	ls_maxcyclegubun

AcceptText()

//If row > 0 Then
//	cb_1.Enabled	= True
//	CHOOSE CASE Upper(Trim(String(dwo.name))	)
//		CASE "CYCLECOUNT"
//			If li_cyclecount = 0 Then
//				ls_maxcyclegubun = "Y"
//			Else
//				ls_maxcyclegubun = "N"
//			End If
//			SetItem(1, "MaxCycleGubun", ls_maxcyclegubun)
//		CASE "SUPPLYGUBUN"
//			If Data = 'N' Then
//				dw_line.Modify("HostWorkCenter.Visible = 0")
//				dw_line.Modify("HostLineCode.Visible = 0")
//				dw_line.Modify("HostWorkCenter_t.Visible = 0")
//				dw_line.Modify("HostLineCode_t.Visible = 0")
//			Else
//				dw_line.Modify("HostWorkCenter.Visible = 1")
//				dw_line.Modify("HostLineCode.Visible = 1")
//				dw_line.Modify("HostWorkCenter_t.Visible = 1")
//				dw_line.Modify("HostLineCode_t.Visible = 1")
//			End If
//	END CHOOSE
//End If
end event

event editchanged;AcceptText()

If row > 0 Then
	cb_1.Enabled	= True
End If
end event

event itemerror;Return 1
end event

type gb_2 from groupbox within w_piso101u
integer x = 1339
integer y = 16
integer width = 955
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

