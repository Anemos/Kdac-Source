$PBExportHeader$w_piso051u.srw
$PBExportComments$단말기마스터 - 등록
forward
global type w_piso051u from window
end type
type uo_division from u_pisc_select_division within w_piso051u
end type
type uo_area from u_pisc_select_area within w_piso051u
end type
type cb_2 from commandbutton within w_piso051u
end type
type cb_1 from commandbutton within w_piso051u
end type
type gb_1 from groupbox within w_piso051u
end type
type dw_terminal from datawindow within w_piso051u
end type
type gb_2 from groupbox within w_piso051u
end type
end forward

global type w_piso051u from window
integer width = 2354
integer height = 780
boolean titlebar = true
string title = "단말기마스터 등록"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
uo_division uo_division
uo_area uo_area
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_terminal dw_terminal
gb_2 gb_2
end type
global w_piso051u w_piso051u

type variables
Boolean		ib_open, ib_save
str_parms	istr_parms
window		iw_sheet
datawindow	idw_1
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;dw_terminal.SetTransObject(SQLPIS)

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

dw_terminal.ReSet()
dw_terminal.InsertRow(0)

ls_mod	= "TerminalCode.BackGround.Color = '" + String(ll_background_color) + "' "

dw_terminal.Modify(ls_mod)

dw_terminal.SetItem(1, "AreaCode", uo_area.is_uo_areacode)
dw_terminal.SetItem(1, "DivisionCode", uo_division.is_uo_divisioncode)

end subroutine

on w_piso051u.create
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_terminal=create dw_terminal
this.gb_2=create gb_2
this.Control[]={this.uo_division,&
this.uo_area,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_terminal,&
this.gb_2}
end on

on w_piso051u.destroy
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_terminal)
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

type uo_division from u_pisc_select_division within w_piso051u
integer x = 590
integer y = 96
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_terminal.SetTransObject(SQLPIS)
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_piso051u
integer x = 64
integer y = 96
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_terminal.SetTransObject(SQLPIS)
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

type cb_2 from commandbutton within w_piso051u
integer x = 1819
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

type cb_1 from commandbutton within w_piso051u
integer x = 1399
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

event clicked;Long		ll_count, ll_find
String	ls_areacode, ls_divisioncode, ls_terminalcode, ls_terminalname, ls_terminalip

dw_terminal.AcceptText()

ls_areacode			= Trim(dw_terminal.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_terminal.GetItemString(1, "DivisionCode"))
ls_terminalcode	= Trim(dw_terminal.GetItemString(1, "TerminalCode"))
ls_terminalname	= Trim(dw_terminal.GetItemString(1, "TerminalName"))
ls_terminalip		= Trim(dw_terminal.GetItemString(1, "TerminalIP"))

If ls_terminalcode = "" Or IsNull(ls_terminalcode) = True Or Len(ls_terminalcode) = 0 Then
	MessageBox("단말기마스터", "정확한 단말기 코드를 등록하십시오.", StopSign!)
	Return
End If

//If ls_terminalname = "" Or IsNull(ls_terminalname) = True Or Len(ls_terminalname) = 0 Then
//	MessageBox("단말기마스터", "정확한 단말기명을 등록하십시오.", StopSign!)
//	Return
//End If

ll_count = 0

Select	Count(TerminalCode)
Into		:ll_count
From		tmstterminal
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			TerminalCode	= :ls_terminalcode
Using SQLPIS;

If ll_count > 0 Then
	MessageBox("단말기마스터", "등록한 단말기 코드는 이미 등록되어 있습니다." + &
									"~r~n~r~n새로운 단말기 코드를 등록하십시오.", StopSign!)
	Return
End If

If MessageBox("단말기마스터", "새로운 단말기마스터 정보를 저장하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Insert	tmstterminal
Select	AreaCode				= :ls_areacode,
			DivisionCode		= :ls_divisioncode,
			TerminalCode		= :ls_terminalcode,
			TerminalName		= :ls_terminalname,
			TerminalIP			= :ls_terminalip,
			TerminalGubun		= Null,
			ScannerGubun		= Null,
			ScannerPort			= Null,
			DIOUseFlag			= Null,
			DIOAddress			= Null,
			LastEmp				= 'Y',
			LastDate				= GetDate()
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	MessageBox("단말기마스터", "새로운 단말기마스터를 저장하였습니다.", Information!)
	wf_retrieve()
	iw_sheet.TriggerEvent("ue_retrieve")
	ll_find	= idw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"TerminalCode = '" + ls_terminalcode + "'", 1, idw_1.RowCount())
	If ll_find > 0 Then
		idw_1.SetRow(ll_find)
		idw_1.Trigger Event RowFocusChanged(ll_find)
		idw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("단말기마스터", "새로운 단말기마스터를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

type gb_1 from groupbox within w_piso051u
integer x = 23
integer y = 16
integer width = 1307
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "공장 선택"
borderstyle borderstyle = stylelowered!
end type

type dw_terminal from datawindow within w_piso051u
integer x = 27
integer y = 236
integer width = 2267
integer height = 416
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso050u_02"
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

type gb_2 from groupbox within w_piso051u
integer x = 1339
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

