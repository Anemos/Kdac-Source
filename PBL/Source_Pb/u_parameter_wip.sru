$PBExportHeader$u_parameter_wip.sru
$PBExportComments$Interface Parameter Setting
forward
global type u_parameter_wip from userobject
end type
type dw_2 from datawindow within u_parameter_wip
end type
type cb_save from commandbutton within u_parameter_wip
end type
type dw_1 from datawindow within u_parameter_wip
end type
type gb_1 from groupbox within u_parameter_wip
end type
end forward

global type u_parameter_wip from userobject
integer width = 2610
integer height = 580
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event resize ( unsignedlong sizetype,  integer newwidth,  integer newheight )
event type string ue_retrieve ( string ag_plant,  string ag_gubun,  ref integer rowcount )
dw_2 dw_2
cb_save cb_save
dw_1 dw_1
gb_1 gb_1
end type
global u_parameter_wip u_parameter_wip

type variables
boolean ib_change = False
boolean ib_save = False
end variables

event resize;int li_border = 15, li_gb_range = 20

SetRedraw(False)
gb_1.Resize(newwidth - li_border, newheight - li_border)

cb_save.Move(newwidth - cb_save.Width - (3 * li_gb_range), gb_1.Y + li_gb_range + li_border)

dw_1.Resize(newwidth - cb_save.Width - li_border - (5 * li_gb_range), newheight - li_border - (2 * li_gb_range))
dw_2.Resize(dw_1.Width, dw_1.Height)
dw_2.Move(dw_1.X, dw_1.Y)

SetRedraw(True)
end event

event type string ue_retrieve(string ag_plant, string ag_gubun, ref integer rowcount);Int li_return

rowcount = 0

If ib_change Then
	li_return = MessageBox("Save","Parameter 설정값이 변경 되었습니다.~r~n저장하시겠습니까 ?", Question!, YesNoCancel!)
	CHOOSE CASE li_return
		CASE 1
			ib_save = True
			cb_save.TriggerEvent(Clicked!)
			If ib_change Then
				Return 'F'
			Else
				ib_change	= False
				dw_1.SetTransObject(SQLCA)
				rowcount 	= dw_1.Retrieve(ag_plant,ag_gubun)
				Return 'Y'
			End If
		CASE 2
			ib_change	= False
			Return 'N'
		CASE 3
			Return 'C'
	END CHOOSE
Else
	dw_1.SetTransObject(SQLCA)
	rowcount = dw_1.Retrieve(ag_plant,ag_gubun)
	Return 'Y'
End If
end event

on u_parameter_wip.create
this.dw_2=create dw_2
this.cb_save=create cb_save
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.dw_2,&
this.cb_save,&
this.dw_1,&
this.gb_1}
end on

on u_parameter_wip.destroy
destroy(this.dw_2)
destroy(this.cb_save)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type dw_2 from datawindow within u_parameter_wip
integer x = 320
integer y = 72
integer width = 768
integer height = 424
integer taborder = 30
string dataobject = "d_parameter_background"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;InsertRow(1)
end event

type cb_save from commandbutton within u_parameter_wip
integer x = 2290
integer y = 32
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
boolean enabled = false
string text = "&Save"
end type

event clicked;Int li_return

//SQLCA.AutoCommit	= False

li_return = dw_1.Update()

If li_return = 1 Then
	//Commit;
	ib_change = False
	If ib_save Then
		ib_save = False
	Else
		MessageBox("OK", "Save OK")
	End If
Else
	//RollBack;
End If

//SQLCA.AutoCommit = True
end event

type dw_1 from datawindow within u_parameter_wip
integer x = 18
integer y = 20
integer width = 2235
integer height = 520
integer taborder = 10
string dataobject = "d_wip_parameter"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;String ls_modstring
boolean lb_cycletime_check = False
Int li_cycletime

If Not ib_change Then
	cb_save.Enabled	= True
	ib_change = True
End If

//CHOOSE CASE Upper(dwo.Name)
//	CASE 'CYCLEOPTION'
//		CHOOSE CASE Data
//			CASE 'ON'
//				ls_modstring = "Cycletime_t.Text = '' " + &
//									"Cycletime.Protect = 1 "
//				dw_1.SetItem(row, 'CycleTime', 0)
//			CASE 'SS'
//				lb_cycletime_check = True
//				ls_modstring = "Cycletime_t.Text = '초 간격' " + &
//									"Cycletime.Protect = 0 "
//			CASE 'MI'
//				lb_cycletime_check = True
//				ls_modstring = "Cycletime_t.Text = '분 간격' " + &
//									"Cycletime.Protect = 0 "
//			CASE 'HH'
//				lb_cycletime_check = True
//				ls_modstring = "Cycletime_t.Text = '시간 간격' " + &
//									"Cycletime.Protect = 0 "
//			CASE 'DD'
//				lb_cycletime_check = True
//				ls_modstring = "Cycletime_t.Text = '일 간격' " + &
//									"Cycletime.Protect = 0 "
//			CASE 'WW'
//				lb_cycletime_check = True
//				ls_modstring = "Cycletime_t.Text = '주일 간격' " + &
//									"Cycletime.Protect = 0 "
//			CASE 'MM'
//				lb_cycletime_check = True
//				ls_modstring = "Cycletime_t.Text = '달 간격' " + &
//									"Cycletime.Protect = 0 "
//			CASE 'YY'
//				lb_cycletime_check = True
//				ls_modstring = "Cycletime_t.Text = '년 간격' " + &
//									"Cycletime.Protect = 0 "
//		END CHOOSE
//		
//		dw_1.Modify(ls_modstring)
//		If lb_cycletime_check Then
//			If dw_1.GetItemNumber(row, 'CycleTime') = 0 Then
//				dw_1.SetItem(row, 'CycleTime', 1)
//			End If
//		End If
//END CHOOSE
end event

event editchanged;AcceptText()
end event

event itemerror;Return 1
end event

event dberror;If SQLDBCODE = 10005 Then
	MessageBox("DataBase Error", "DataBase와의 연결이 비정상 적으로 종료 되었습니다.~r~n종료 후 다시 수행하세요.")
Else
	MessageBox("SQL Error : " + String(sqldbcode), sqlerrtext)
End If

Return 1

end event

event retrieveend;String ls_option, ls_modstring

ib_change = False
cb_save.Enabled	= False

If rowcount > 0 Then
	BringToTop = True
//	ls_option = GetItemString(1, 'CycleOption')
//	CHOOSE CASE Upper(ls_option)
//		CASE 'ON'
//			ls_modstring = "Cycletime_t.Text = '' " + &
//								"Cycletime.Protect = 1 "
//		CASE 'SS'
//			ls_modstring = "Cycletime_t.Text = '초 간격' " + &
//								"Cycletime.Protect = 0 "
//		CASE 'MI'
//			ls_modstring = "Cycletime_t.Text = '분 간격' " + &
//								"Cycletime.Protect = 0 "
//		CASE 'HH'
//			ls_modstring = "Cycletime_t.Text = '시간 간격' " + &
//								"Cycletime.Protect = 0 "
//		CASE 'DD'
//			ls_modstring = "Cycletime_t.Text = '일 간격' " + &
//								"Cycletime.Protect = 0 "
//		CASE 'WW'
//			ls_modstring = "Cycletime_t.Text = '주일 간격' " + &
//								"Cycletime.Protect = 0 "
//		CASE 'MM'
//			ls_modstring = "Cycletime_t.Text = '달 간격' " + &
//								"Cycletime.Protect = 0 "
//		CASE 'YY'
//			ls_modstring = "Cycletime_t.Text = '년 간격' " + &
//								"Cycletime.Protect = 0 "
//	END CHOOSE
//	
//	dw_1.Modify(ls_modstring)
Else
	dw_2.BringToTop = True
End If
end event

type gb_1 from groupbox within u_parameter_wip
integer width = 2597
integer height = 560
integer taborder = 30
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
end type

