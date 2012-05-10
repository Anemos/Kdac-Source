$PBExportHeader$w_pisp251u.srw
$PBExportComments$간판 상태 정보 - 간판 상태 전환
forward
global type w_pisp251u from window
end type
type dw_kbno from u_pisp_kbno_scan within w_pisp251u
end type
type cb_1 from commandbutton within w_pisp251u
end type
type st_2 from statictext within w_pisp251u
end type
type cb_2 from commandbutton within w_pisp251u
end type
type dw_kbno_sleeping from u_vi_std_datawindow within w_pisp251u
end type
type cb_left from commandbutton within w_pisp251u
end type
type cb_right from commandbutton within w_pisp251u
end type
type uo_item from u_pisc_select_item_kb_line within w_pisp251u
end type
type cb_3 from commandbutton within w_pisp251u
end type
type uo_line from u_pisc_select_line within w_pisp251u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp251u
end type
type uo_division from u_pisc_select_division within w_pisp251u
end type
type uo_area from u_pisc_select_area within w_pisp251u
end type
type gb_2 from groupbox within w_pisp251u
end type
type gb_4 from groupbox within w_pisp251u
end type
type gb_5 from groupbox within w_pisp251u
end type
type gb_1 from groupbox within w_pisp251u
end type
type gb_6 from groupbox within w_pisp251u
end type
type dw_kbno_active from u_vi_std_datawindow within w_pisp251u
end type
type gb_3 from groupbox within w_pisp251u
end type
type dw_save from datawindow within w_pisp251u
end type
type gb_7 from groupbox within w_pisp251u
end type
type gb_8 from groupbox within w_pisp251u
end type
end forward

global type w_pisp251u from window
integer width = 3378
integer height = 2148
boolean titlebar = true
string title = "간판 상태 전환"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
dw_kbno dw_kbno
cb_1 cb_1
st_2 st_2
cb_2 cb_2
dw_kbno_sleeping dw_kbno_sleeping
cb_left cb_left
cb_right cb_right
uo_item uo_item
cb_3 cb_3
uo_line uo_line
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
gb_1 gb_1
gb_6 gb_6
dw_kbno_active dw_kbno_active
gb_3 gb_3
dw_save dw_save
gb_7 gb_7
gb_8 gb_8
end type
global w_pisp251u w_pisp251u

type variables
Boolean		ib_open, ib_save
//String		is_kbactivegubun
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_save ()
public subroutine wf_move_kbno (datawindow fdw_from, datawindow fdw_to)
public subroutine wf_retrieve ()
end prototypes

event ue_postopen();
uo_area.is_uo_areacode = istr_parms.string_arg[3]
uo_area.dw_1.SetItem(1, 'DDDWCode', uo_area.is_uo_areacode)

uo_division.is_uo_divisioncode	= istr_parms.string_arg[4]
f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
uo_division.dw_1.SetItem(1, 'DDDWCode', uo_division.is_uo_divisioncode)	

f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										False, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)

uo_workcenter.is_uo_workcenter	= trim(istr_parms.string_arg[5])
uo_workcenter.dw_1.SetItem(1, 'DDDWCode', uo_workcenter.is_uo_workcenter)	


f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										False, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)
uo_line.is_uo_linecode	= trim(istr_parms.string_arg[6])
uo_line.dw_1.SetItem(1, 'DDDWCode', uo_line.is_uo_linecode)

f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										uo_line.is_uo_linecode, &
										'%', &
										False, &
										uo_item.is_uo_itemcode, &
										uo_item.is_uo_itemname)

uo_item.is_uo_itemcode	= istr_parms.string_arg[7]
uo_item.dw_1.SetItem(1, 'DDDWCode', uo_item.is_uo_itemcode)

dw_kbno_active.SetTransObject(SQLPIS)
dw_kbno_sleeping.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
wf_retrieve()

ib_open = True
end event

public subroutine wf_save ();Long		i
String	ls_kbno, ls_errortext
Boolean	lb_error
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Store the row numbers of the selected rows in an array
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Active 전환
dw_save.ReSet()
SQLPIS.AutoCommit = False
For i = 1 To dw_kbno_active.RowCount()
	ls_kbno		= Trim(dw_kbno_active.GetItemString(i, "KBNo"))
	dw_save.ReSet()
	If dw_save.Retrieve(	ls_kbno, 'A', g_s_empno) > 0 Then
		If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
			lb_error	= False
			ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
		Else
			lb_error = True
			ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
			Exit
		End If
	Else
		lb_error = True
		ls_errortext	= "Active 상태 전환 등록을 시도하였지만 오류가 발생했습니다."
		Exit
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("간판 상태 전환","Active 상태 전환 등록을 저장하는 중에 오류 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	// 여기부터는 Sleeping 전환
	dw_save.ReSet()
	For i = 1 To dw_kbno_sleeping.RowCount()
		ls_kbno		= Trim(dw_kbno_sleeping.GetItemString(i, "KBNo"))
		dw_save.ReSet()
		If dw_save.Retrieve(	ls_kbno, 'S', g_s_empno) > 0 Then
			If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
				lb_error	= False
				ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
			Else
				lb_error = True
				ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
				Exit
			End If
		Else
			lb_error = True
			ls_errortext	= "Sleeping 상태 전환 등록을 시도하였지만 오류가 발생했습니다."
			Exit
		End If
	Next
	
	If lb_error Then
		RollBack Using SQLPIS;
		SQLPIS.AutoCommit = True
		MessageBox("간판 상태 전환","Sleeping 상태 전환 등록을 저장하는 중에 오류 발생하였습니다." + &
												"~r~n~r~n(참고)" + &
												"~r~n1. " + ls_errortext, StopSign!)
	Else
		Commit Using SQLPIS;
		SQLPIS.AutoCommit = True
		ib_save	= True
		MessageBox("간판 상태 전환", "간판 상태 전환 등록을 저장하였습니다.", Information!)
		wf_retrieve()
	End If
End If
end subroutine

public subroutine wf_move_kbno (datawindow fdw_from, datawindow fdw_to);///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		: wf_move_kbno
//	Access		: protected
//	Arguments	: DataWindow fdw_from		Source DataWindow for Emp Move
// 				  DataWindow fdw_to			Target DataWindow for Emp Move
//	Returns		: none
//	Description	: 간판번호를 이동한다.
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: 
// Coded Date	: 2002.10.10
///////////////////////////////////////////////////////////////////////////////////////////////////////////

Long		ll_find, i, ll_selected_rows[], ll_selected_count, ll_rowcount
String	ls_empcode, ls_group_id

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Store the row numbers of the selected rows in an array
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ll_selected_count = f_pisc_dw_selected_row (fdw_from, ll_selected_rows)
If ll_selected_count = 0 Then Return

fdw_from.SetRedraw(False)
fdw_to.SetRedraw(False)

//// User 삭제의 경우 dw_update(invisible datawindow)에 GroupID : SetItem ''
//If fdw_from = dw_1 Then
//	SetNull(ls_group_id)
//Else
//// User 추가의 경우 dw_update(invisible datawindow)에 GroupID : SetItem Instance Variable(is_group_id)
//	ls_group_id	= is_groupid
//End If

For i = ll_selected_count To 1 Step -1
//	ls_empcode		= fdw_from.GetItemString(ll_selected_rows[i], 'empcode')
	fdw_from.RowsMove (ll_selected_rows[i], ll_selected_rows[i], Primary!, fdw_to, fdw_to.RowCount() + 1, primary!)
//	ll_find			= dw_update.Find("EmpCode = '" + ls_empcode + "'", 1, dw_update.RowCount())
//	// If Exist Then Update(SetItem)
//	If ll_find > 0 Then
//		dw_update.SetItem(ll_find, 'GroupID', ls_group_id)
//		dw_update.SetItem(ll_find, 'lastEmp', gs_empcode)
//		dw_update.SetItem(ll_find, 'LastDate', f_get_nowtime())
//	// If Not Exist Then InsertRow() & SetItem()
//	Else
//		dw_update.InsertRow(1)
//		dw_update.SetItem(1, 'EmpCode', ls_empcode)
//		dw_update.SetItem(1, 'GroupID', ls_group_id)
//		dw_update.SetItem(1, 'lastEmp', gs_empcode)
//		dw_update.SetItem(1, 'LastDate', f_get_nowtime())
//	End If
Next

fdw_to.Sort()

fdw_from.SetRedraw(True)
fdw_to.SetRedraw(True)

fdw_to.SetFocus()
ll_rowcount = fdw_to.RowCount()
fdw_to.ScrollToRow(ll_rowcount)
//If Not cb_save.Enabled Then cb_save.Enabled	= True
//wf_set_count()
//ib_move	= True
Return
end subroutine

public subroutine wf_retrieve ();dw_kbno_active.ReSet()
dw_kbno_sleeping.ReSet()
dw_save.ReSet()

If dw_kbno_active.Retrieve(uo_area.is_uo_areacode,		uo_division.is_uo_divisioncode, &
							uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
							uo_item.is_uo_itemcode,				"A") > 0 Then
Else
//	MessageBox("간판 상태 전환", "Active 상태의 간판이 존재하지 않습니다.")
End If

If dw_kbno_sleeping.Retrieve(uo_area.is_uo_areacode,		uo_division.is_uo_divisioncode, &
							uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
							uo_item.is_uo_itemcode,				"S") > 0 Then
Else
//	MessageBox("간판 상태 전환", "Sleeping 상태의 간판이 존재하지 않습니다.")
End If
end subroutine

on w_pisp251u.create
this.dw_kbno=create dw_kbno
this.cb_1=create cb_1
this.st_2=create st_2
this.cb_2=create cb_2
this.dw_kbno_sleeping=create dw_kbno_sleeping
this.cb_left=create cb_left
this.cb_right=create cb_right
this.uo_item=create uo_item
this.cb_3=create cb_3
this.uo_line=create uo_line
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_1=create gb_1
this.gb_6=create gb_6
this.dw_kbno_active=create dw_kbno_active
this.gb_3=create gb_3
this.dw_save=create dw_save
this.gb_7=create gb_7
this.gb_8=create gb_8
this.Control[]={this.dw_kbno,&
this.cb_1,&
this.st_2,&
this.cb_2,&
this.dw_kbno_sleeping,&
this.cb_left,&
this.cb_right,&
this.uo_item,&
this.cb_3,&
this.uo_line,&
this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.gb_2,&
this.gb_4,&
this.gb_5,&
this.gb_1,&
this.gb_6,&
this.dw_kbno_active,&
this.gb_3,&
this.dw_save,&
this.gb_7,&
this.gb_8}
end on

on w_pisp251u.destroy
destroy(this.dw_kbno)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.dw_kbno_sleeping)
destroy(this.cb_left)
destroy(this.cb_right)
destroy(this.uo_item)
destroy(this.cb_3)
destroy(this.uo_line)
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.dw_kbno_active)
destroy(this.gb_3)
destroy(this.dw_save)
destroy(this.gb_7)
destroy(this.gb_8)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type dw_kbno from u_pisp_kbno_scan within w_pisp251u
integer x = 955
integer y = 216
integer taborder = 0
end type

event ue_enter;call super::ue_enter;String	ls_kbno, ls_kbno_check
dwobject ldwo_this

ls_kbno_check	= Trim(GetItemString(1,1))
AcceptText()
ls_kbno			= Trim(GetItemString(1,1))

If ls_kbno_check <> ls_kbno Then
	Post Event ItemChanged(1, ldwo_this, ls_kbno)
End If
end event

event itemchanged;call super::itemchanged;Int		i
String	ls_kbno

ls_kbno	= Data

If Len(ls_kbno) <> 11 Then
	f_pisc_beep()
	MessageBox("간판 번호 정보","간판번호는 11자리 입니다.~r~n정확한 간판 번호를 입력하십시오.")
	Return
End If

For i = 1 To dw_kbno_active.RowCount()
	If ls_kbno = Trim(dw_kbno_active.GetItemString(i, "KBNo")) Then
		dw_kbno_active.SelectRow(i, True)
		Return
	End If
Next

For i = 1 To dw_kbno_sleeping.RowCount()
	If ls_kbno = Trim(dw_kbno_sleeping.GetItemString(i, "KBNo")) Then
		dw_kbno_sleeping.SelectRow(i, True)
		Return
	End If
Next

//li_count	= 0
//Select	Count(A.KBNo)
//Into		:li_count
//From		tkb		A
//Where		A.KBNo	= :is_kbno
//Using	SQLPIS;
//
//If li_count > 0 Then
//	//
//Else
//	f_pisc_beep()
//	MessageBox("간판 번호 정보", "입력하신 간판은 시스템에서 관리하지 않는 간판입니다." + &
//									"~r~n~r~n간판번호를 다시 한번 확인하여 주십시오.")
//	Return
//End If
end event

type cb_1 from commandbutton within w_pisp251u
integer x = 2144
integer y = 244
integer width = 357
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조 회(&R)"
end type

event clicked;wf_retrieve()
end event

type st_2 from statictext within w_pisp251u
integer x = 50
integer y = 212
integer width = 818
integer height = 168
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "간판을 선택하신 후에 ~'>>~' 또는 ~'<<~'  버튼을 클릭하십시오."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_pisp251u
integer x = 2510
integer y = 244
integer width = 357
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저 장(&S)"
end type

event clicked;If MessageBox("간판 상태 전환", "간판 상태 전환을 저장하시겠습니까?" + &
											"~r~n~r~n(주의)" + &
											"~r~n~r~n1. 회수 상태인 간판만 상태가 전환됩니다.", &
													Question!, YesNo!, 2) = 2 Then
	Return
End If

wf_save()
end event

type dw_kbno_sleeping from u_vi_std_datawindow within w_pisp251u
integer x = 1879
integer y = 500
integer width = 1403
integer height = 1376
integer taborder = 0
string dataobject = "d_pisp251u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;this.settransobject(sqlpis)
end event

type cb_left from commandbutton within w_pisp251u
integer x = 1554
integer y = 1268
integer width = 229
integer height = 256
integer textsize = -16
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "<<"
end type

event clicked;wf_move_kbno(dw_kbno_sleeping, dw_kbno_active)
end event

type cb_right from commandbutton within w_pisp251u
integer x = 1554
integer y = 840
integer width = 229
integer height = 256
integer textsize = -16
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = ">>"
end type

event clicked;wf_move_kbno(dw_kbno_active, dw_kbno_sleeping)
end event

type uo_item from u_pisc_select_item_kb_line within w_pisp251u
integer x = 2418
integer y = 64
end type

on uo_item.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type cb_3 from commandbutton within w_pisp251u
integer x = 2875
integer y = 244
integer width = 389
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;If ib_save Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type uo_line from u_pisc_select_line within w_pisp251u
integer x = 1801
integer y = 64
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											False, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp251u
integer x = 1129
integer y = 64
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
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											False, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If
end event

type uo_division from u_pisc_select_division within w_pisp251u
integer x = 535
integer y = 64
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											False, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											False, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	dw_kbno_active.SetTransObject(SQLPIS)
	dw_kbno_sleeping.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp251u
integer x = 46
integer y = 64
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
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
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
	
	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											False, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
   dw_kbno_active.SetTransObject(SQLPIS)
	dw_kbno_sleeping.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)											
	wf_retrieve()
End If
end event

type gb_2 from groupbox within w_pisp251u
integer x = 2391
integer width = 937
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_4 from groupbox within w_pisp251u
integer x = 18
integer width = 1093
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_5 from groupbox within w_pisp251u
integer x = 1115
integer width = 1271
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisp251u
integer x = 18
integer y = 160
integer width = 873
integer height = 232
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_6 from groupbox within w_pisp251u
integer x = 1833
integer y = 420
integer width = 1495
integer height = 1492
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "Sleeping 상태 간판"
end type

type dw_kbno_active from u_vi_std_datawindow within w_pisp251u
integer x = 59
integer y = 500
integer width = 1403
integer height = 1376
integer taborder = 0
string dataobject = "d_pisp251u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;this.settransobject(sqlpis)
end event

type gb_3 from groupbox within w_pisp251u
integer x = 18
integer y = 420
integer width = 1481
integer height = 1492
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "Active 상태 간판"
end type

type dw_save from datawindow within w_pisp251u
integer x = 2007
integer y = 1248
integer width = 937
integer height = 436
boolean bringtotop = true
boolean titlebar = true
string title = "간판 번호 인쇄"
string dataobject = "d_pisp251u_02_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
this.settransobject(sqlpis)
end event

type gb_7 from groupbox within w_pisp251u
integer x = 2080
integer y = 160
integer width = 1248
integer height = 236
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_8 from groupbox within w_pisp251u
integer x = 896
integer y = 160
integer width = 1179
integer height = 236
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

