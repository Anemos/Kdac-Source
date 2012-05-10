$PBExportHeader$w_pisp241u.srw
$PBExportComments$간판 번호 관리 - 간판 (재)발행
forward
global type w_pisp241u from window
end type
type st_3 from statictext within w_pisp241u
end type
type st_2 from statictext within w_pisp241u
end type
type em_2 from editmask within w_pisp241u
end type
type em_1 from editmask within w_pisp241u
end type
type dw_save from datawindow within w_pisp241u
end type
type cb_1 from commandbutton within w_pisp241u
end type
type dw_kbno_print from u_vi_std_datawindow within w_pisp241u
end type
type cb_left from commandbutton within w_pisp241u
end type
type cbx_1 from checkbox within w_pisp241u
end type
type cb_right from commandbutton within w_pisp241u
end type
type rb_3 from radiobutton within w_pisp241u
end type
type rb_2 from radiobutton within w_pisp241u
end type
type rb_1 from radiobutton within w_pisp241u
end type
type uo_item from u_pisc_select_item_kb_line within w_pisp241u
end type
type cb_3 from commandbutton within w_pisp241u
end type
type uo_line from u_pisc_select_line within w_pisp241u
end type
type cb_2 from commandbutton within w_pisp241u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp241u
end type
type uo_division from u_pisc_select_division within w_pisp241u
end type
type uo_area from u_pisc_select_area within w_pisp241u
end type
type gb_2 from groupbox within w_pisp241u
end type
type gb_4 from groupbox within w_pisp241u
end type
type gb_5 from groupbox within w_pisp241u
end type
type gb_6 from groupbox within w_pisp241u
end type
type gb_7 from groupbox within w_pisp241u
end type
type gb_8 from groupbox within w_pisp241u
end type
type dw_kbno_info from u_vi_std_datawindow within w_pisp241u
end type
type gb_3 from groupbox within w_pisp241u
end type
type dw_print from datawindow within w_pisp241u
end type
type gb_1 from groupbox within w_pisp241u
end type
type gb_9 from groupbox within w_pisp241u
end type
end forward

global type w_pisp241u from window
integer width = 3566
integer height = 2184
boolean titlebar = true
string title = "간판 (재)발행"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
st_3 st_3
st_2 st_2
em_2 em_2
em_1 em_1
dw_save dw_save
cb_1 cb_1
dw_kbno_print dw_kbno_print
cb_left cb_left
cbx_1 cbx_1
cb_right cb_right
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
uo_item uo_item
cb_3 cb_3
uo_line uo_line
cb_2 cb_2
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
gb_7 gb_7
gb_8 gb_8
dw_kbno_info dw_kbno_info
gb_3 gb_3
dw_print dw_print
gb_1 gb_1
gb_9 gb_9
end type
global w_pisp241u w_pisp241u

type variables
Boolean		ib_open, ib_save
String		is_printoption	= "ALL"	// "UPDATE" 이미 등록된 간판마스터를 변경 저장
										// "INSERT" 새롭게 간판마스터를 추가하는 경우
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_move_kbno (datawindow fdw_from, datawindow fdw_to)
public subroutine wf_retrieve ()
end prototypes

event ue_postopen();uo_area.is_uo_areacode = istr_parms.string_arg[3]
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
uo_workcenter.is_uo_workcenter	= istr_parms.string_arg[5]
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
uo_line.is_uo_linecode	= istr_parms.string_arg[6]
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
ib_open = True
dw_kbno_info.SetTransObject(SQLPIS)
dw_kbno_print.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
wf_retrieve()


end event

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

public subroutine wf_retrieve ();
dw_kbno_info.ReSet()
dw_kbno_print.ReSet()
dw_print.ReSet()
dw_save.ReSet()

If dw_kbno_info.Retrieve(uo_area.is_uo_areacode,		uo_division.is_uo_divisioncode, &
							uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
							uo_item.is_uo_itemcode,				is_printoption) > 0 Then
//	dw_kbno_print.Retrieve(uo_area.is_uo_areacode,		uo_division.is_uo_divisioncode, &
//							uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
//							uo_item.is_uo_itemcode,				is_printoption)
Else
	MessageBox("간판 (재)발행", "(재)발행할 간판이 존재하지 않는 제품입니다.")
End If

end subroutine

on w_pisp241u.create
this.st_3=create st_3
this.st_2=create st_2
this.em_2=create em_2
this.em_1=create em_1
this.dw_save=create dw_save
this.cb_1=create cb_1
this.dw_kbno_print=create dw_kbno_print
this.cb_left=create cb_left
this.cbx_1=create cbx_1
this.cb_right=create cb_right
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.uo_item=create uo_item
this.cb_3=create cb_3
this.uo_line=create uo_line
this.cb_2=create cb_2
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_7=create gb_7
this.gb_8=create gb_8
this.dw_kbno_info=create dw_kbno_info
this.gb_3=create gb_3
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_9=create gb_9
this.Control[]={this.st_3,&
this.st_2,&
this.em_2,&
this.em_1,&
this.dw_save,&
this.cb_1,&
this.dw_kbno_print,&
this.cb_left,&
this.cbx_1,&
this.cb_right,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.uo_item,&
this.cb_3,&
this.uo_line,&
this.cb_2,&
this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.gb_2,&
this.gb_4,&
this.gb_5,&
this.gb_6,&
this.gb_7,&
this.gb_8,&
this.dw_kbno_info,&
this.gb_3,&
this.dw_print,&
this.gb_1,&
this.gb_9}
end on

on w_pisp241u.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.em_2)
destroy(this.em_1)
destroy(this.dw_save)
destroy(this.cb_1)
destroy(this.dw_kbno_print)
destroy(this.cb_left)
destroy(this.cbx_1)
destroy(this.cb_right)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.uo_item)
destroy(this.cb_3)
destroy(this.uo_line)
destroy(this.cb_2)
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.dw_kbno_info)
destroy(this.gb_3)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_9)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

event activate;dw_kbno_info.SetTransObject(SQLPIS)
dw_kbno_print.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)

end event

type st_3 from statictext within w_pisp241u
integer x = 1760
integer y = 304
integer width = 288
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "위여백:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisp241u
integer x = 1760
integer y = 220
integer width = 288
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "왼쪽여백:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_2 from editmask within w_pisp241u
integer x = 2057
integer y = 296
integer width = 133
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "5"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0"
string minmax = "0~~"
end type

type em_1 from editmask within w_pisp241u
integer x = 2057
integer y = 216
integer width = 133
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "8"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0"
string minmax = "0~~"
end type

type dw_save from datawindow within w_pisp241u
integer x = 2318
integer y = 1552
integer width = 937
integer height = 436
boolean bringtotop = true
boolean titlebar = true
string title = "간판 번호 인쇄 내역 저장"
string dataobject = "d_pisp241u_04_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type cb_1 from commandbutton within w_pisp241u
integer x = 2290
integer y = 244
integer width = 384
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

type dw_kbno_print from u_vi_std_datawindow within w_pisp241u
integer x = 1938
integer y = 496
integer width = 1527
integer height = 1532
integer taborder = 0
string dataobject = "d_pisp241u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type cb_left from commandbutton within w_pisp241u
integer x = 1655
integer y = 1228
integer width = 215
integer height = 256
integer textsize = -16
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "<<"
end type

event clicked;wf_move_kbno(dw_kbno_print, dw_kbno_info)

If dw_kbno_info.RowCount() = 0 Then
	cbx_1.Checked = True
Else
	cbx_1.Checked = False
End If
end event

type cbx_1 from checkbox within w_pisp241u
integer x = 887
integer y = 256
integer width = 800
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "전체 간판번호 (재)발행"
end type

event clicked;
//If dw_kbno_info.RowCount() > 0 Then
//	dw_kbno_info.RowsMove(1, dw_kbno_info.RowCount(), Primary!, &
//										dw_kbno_print, dw_kbno_print.RowCount() + 1, Primary!)
//End If

If cbx_1.Checked Then
	If dw_kbno_info.RowCount() > 0 Then
		dw_kbno_info.RowsMove(1, dw_kbno_info.RowCount(), Primary!, &
											dw_kbno_print, dw_kbno_print.RowCount() + 1, Primary!)
	End If
Else
	If dw_kbno_print.RowCount() > 0 Then
		If dw_kbno_info.RowCount() = 0 Then
			dw_kbno_print.RowsMove(1, dw_kbno_print.RowCount(), Primary!, &
												dw_kbno_info, dw_kbno_info.RowCount() + 1, Primary!)
		End If
	End If
End If
end event

type cb_right from commandbutton within w_pisp241u
integer x = 1655
integer y = 800
integer width = 215
integer height = 256
integer textsize = -16
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = ">>"
end type

event clicked;wf_move_kbno(dw_kbno_info, dw_kbno_print)

If dw_kbno_info.RowCount() = 0 Then
	cbx_1.Checked = True
Else
	cbx_1.Checked = False
End If

//Int	i, li_selected_row, li_row
//
//li_selected_row = 0
//
////For i = 1 To dw_kbno_info.RowCount()
////	li_selectedrow = dw_kbno_info.GetSelectedRow(li_selectedrow)
////	dw_kbno_info.RowsMove(li_selectedrow, li_selectedrow, Primary!, &
////										dw_kbno_print, dw_kbno_print.RowCount() + 1, Primary!)
////Next
//
////If li_selectedrow > 0 Then
//	DO While li_selected_row <= dw_kbno_info.RowCount()
//		li_selected_row = dw_kbno_info.GetSelectedRow(li_selected_row)
//		messagebox("", string(li_selected_row))
//		If li_selected_row > 0 Then
//			li_row = dw_kbno_print.InsertRow(0)
//			dw_kbno_print.SetItem(li_row, "KBNo", Trim(dw_kbno_info.GetItemString(li_selected_row, "KBNo")))
//			dw_kbno_print.SetItem(li_row, "TempGubun", Trim(dw_kbno_info.GetItemString(li_selected_row, "TempGubun")))
//			dw_kbno_print.SetItem(li_row, "TempGubunName", Trim(dw_kbno_info.GetItemString(li_selected_row, "TempGubunName")))
//			dw_kbno_print.SetItem(li_row, "RackQty", dw_kbno_info.GetItemNumber(li_selected_row, "RackQty"))
//			dw_kbno_print.SetItem(li_row, "PrintCount", dw_kbno_info.GetItemNumber(li_selected_row, "PrintCount"))
//			dw_kbno_print.SetItem(li_row, "PrintDate", dw_kbno_info.GetItemDateTime(li_selected_row, "PrintDate"))
//			
//			dw_kbno_info.DeleteRow(li_selected_row)
//
////		dw_kbno_info.RowsMove(li_selected_row, li_selected_row, Primary!, &
////											dw_kbno_print, dw_kbno_print.RowCount() + 1, Primary!)
//		Else
//			Exit
//		End If
//	LOOP
////End If

//dw_kbno_print.Object.Data = dw_kbno_info.Object.Data.Selected


end event

type rb_3 from radiobutton within w_pisp241u
integer x = 590
integer y = 256
integer width = 238
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "발행"
end type

event clicked;If Checked Then
	is_printoption = "PRINT"
	wf_retrieve()
Else
	rb_1.Checked	= False
	rb_2.Checked	= False
End If
end event

type rb_2 from radiobutton within w_pisp241u
integer x = 288
integer y = 256
integer width = 293
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "미발행"
end type

event clicked;If Checked Then
	is_printoption = "NONPRINT"
	wf_retrieve()
Else
	rb_1.Checked	= False
	rb_3.Checked	= False
End If
end event

type rb_1 from radiobutton within w_pisp241u
integer x = 55
integer y = 256
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "전체"
boolean checked = true
end type

event clicked;If Checked Then
	is_printoption = "ALL"
	wf_retrieve()
Else
	rb_2.Checked	= False
	rb_3.Checked	= False
End If
end event

type uo_item from u_pisc_select_item_kb_line within w_pisp241u
integer x = 2514
integer y = 64
end type

on uo_item.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type cb_3 from commandbutton within w_pisp241u
integer x = 3067
integer y = 244
integer width = 384
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

type uo_line from u_pisc_select_line within w_pisp241u
integer x = 1861
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

type cb_2 from commandbutton within w_pisp241u
integer x = 2679
integer y = 244
integer width = 384
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "(재)발행(&P)"
end type

event clicked;Int		i, li_rowcount
String	ls_kbno_1, ls_kbno_2, ls_kbno_3, ls_errortext
Boolean	lb_error_print, lb_error

li_rowcount = dw_kbno_print.RowCount()

If li_rowcount > 0 Then
Else
	MessageBox("간판 (재)발행", "(재)발행 하려는 간판을 선택하여 주십시오.", StopSign!)
	Return
End If

If MessageBox("간판 (재)발행", "선택하신 간판을 (재)발행 하시겠습니까?", &
													Question!, YesNo!, 2) = 2 Then
	Return
End If

dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_1.Text))*100 )  )
//dw_print.Modify("datawindow.print.margin.Right  = " + String( Integer(Trim(Em_Right.Text))*100 ) )
dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_2.Text))*100 ) )
//dw_print.Modify("datawindow.print.margin.Bottom = " + String( Integer(Trim(Em_Bottom.Text))*100 ) )

For i = 1 To li_rowcount
	dw_print.ReSet()
	CHOOSE CASE Mod(i, 3)
		CASE 1
			ls_kbno_1	= Trim(dw_kbno_print.GetItemString(i, "KBNo"))
			ls_kbno_2	= ""
			ls_kbno_3	= ""
			If i = li_rowcount Then
				If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
					If dw_print.Print() = 1 Then
						dw_save.ReSet()
						If dw_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
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
							ls_errortext	= "간판 인쇄 내역 저장을 시도하였지만 오류가 발생했습니다."
							Exit
						End If
					Else
						lb_error_print	= True
						Exit
					End If
				Else
					lb_error_print	= True
					Exit
				End If
			End If
		CASE 2
			ls_kbno_2	= Trim(dw_kbno_print.GetItemString(i, "KBNo"))
			ls_kbno_3	= ""
			If i = li_rowcount Then
				If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
					If dw_print.Print() = 1 Then
						dw_save.ReSet()
						If dw_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
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
							ls_errortext	= "간판 인쇄 내역 저장을 시도하였지만 오류가 발생했습니다."
							Exit
						End If
					Else
						lb_error_print	= True
						Exit
					End If
				Else
					lb_error_print	= True
					Exit
				End If
			End If
		CASE 0
			ls_kbno_3	= Trim(dw_kbno_print.GetItemString(i, "KBNo"))
			If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
				If dw_print.Print() = 1 Then
					dw_save.ReSet()
					If dw_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
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
						ls_errortext	= "간판 인쇄 내역 저장을 시도하였지만 오류가 발생했습니다."
						Exit
					End If
				Else
					lb_error_print	= True
					Exit
				End If
			Else
				lb_error_print	= True
				Exit
			End If
	END CHOOSE
Next

If lb_error_print Then
	MessageBox("간판 (재)발행", "인쇄 오류" + &
										"~r~n~r~n간판번호: " + ls_kbno_1 + " " + ls_kbno_2 + " " + ls_kbno_3 + &
										"~r~n~r~n인쇄 중에 오류가 발생했습니다.", StopSign!)
	Return
End If

If lb_error Then
	MessageBox("간판 (재)발행","간판 인쇄 내역을 저장하는 중에 오류 발생하였습니다." + &
										"~r~n~r~n간판번호: " + ls_kbno_1 + " " + ls_kbno_2 + " " + ls_kbno_3 + &
										"~r~n~r~n저장 중에 오류가 발생했습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	MessageBox("간판 (재)발행", "간판 인쇄 내역을 저장하였습니다.", Information!)
End If

ib_save	= True
wf_retrieve()


// 2002.10.10 년도에 했던 방식
// 인쇄를 다한 후에 인쇄내역을 저장했는데..
// 중간까지 인쇄는 성공했을때...골때려 진다..

//Int		i, li_rowcount
//String	ls_kbno_1, ls_kbno_2, ls_kbno_3, ls_errortext
//Boolean	ib_print, lb_error
//
//li_rowcount = dw_kbno_print.RowCount()
//
//For i = 1 To li_rowcount
//	dw_print.ReSet()
//	CHOOSE CASE Mod(i, 3)
//		CASE 1
//			ls_kbno_1	= Trim(dw_kbno_print.GetItemString(i, "KBNo"))
//			ls_kbno_2	= ""
//			ls_kbno_3	= ""
//			If i = li_rowcount Then
//				If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
//					If dw_print.Print() <> 1 Then
//						ib_print	= False
//						Exit
//					End If
//				Else
//					ib_print	= False
//					Exit
//				End If
//			End If
//		CASE 2
//			ls_kbno_2	= Trim(dw_kbno_print.GetItemString(i, "KBNo"))
//			ls_kbno_3	= ""
//			If i = li_rowcount Then
//				If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
//					If dw_print.Print() <> 1 Then
//						ib_print	= False
//						Exit
//					End If
//				Else
//					ib_print	= False
//					Exit
//				End If
//			End If
//		CASE 3
//			ls_kbno_3	= Trim(dw_kbno_print.GetItemString(i, "KBNo"))
//			If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
//				If dw_print.Print() <> 1 Then
//					ib_print	= False
//					Exit
//				End If
//			Else
//				ib_print	= False
//				Exit
//			End If
//	END CHOOSE
//Next
//
//If ib_print Then
//	MessageBox("간판 (재)발행", "인쇄 오류", StopSign!)
//	Return
//End If
//
//SQLPIS.AutoCommit = False
//For i = 1 To li_rowcount
//	ls_kbno_1	= Trim(dw_kbno_print.GetItemString(i, "KBNo"))
//	If dw_save.Retrieve(ls_kbno_1, g_s_empno) > 0 Then
//		If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
//			lb_error	= False
//			ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
//		Else
//			lb_error = True
//			ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
//			Exit
//		End If
//	Else
//		lb_error = True
//		ls_errortext	= "간판 인쇄 내역 저장을 시도하였지만 오류가 발생했습니다."
//		Exit
//	End If
//Next
//
//If lb_error Then
//	RollBack Using SQLPIS;
//	SQLPIS.AutoCommit = True
//	MessageBox("간판 (재)발행","간판 인쇄 내역을 저장하는 중에 오류 발생하였습니다." + &
//											"~r~n~r~n(참고)" + &
//											"~r~n1. " + ls_errortext, StopSign!)
//Else
//	Commit Using SQLPIS;
//	SQLPIS.AutoCommit = True
//	ib_save	= True
//	MessageBox("간판 (재)발행", "간판 인쇄 내역을 저장하였습니다.", Information!)
//	wf_retrieve()
//End If
//
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp241u
integer x = 1170
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

type uo_division from u_pisc_select_division within w_pisp241u
integer x = 549
integer y = 64
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_kbno_info.SetTransObject(SQLPIS)
	dw_kbno_print.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
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
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp241u
integer x = 55
integer y = 64
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_kbno_info.SetTransObject(SQLPIS)
	dw_kbno_print.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
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
	wf_retrieve()
End If
end event

type gb_2 from groupbox within w_pisp241u
integer x = 2464
integer width = 1033
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

type gb_4 from groupbox within w_pisp241u
integer x = 18
integer width = 1115
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_5 from groupbox within w_pisp241u
integer x = 1138
integer width = 1321
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_6 from groupbox within w_pisp241u
integer x = 1902
integer y = 416
integer width = 1595
integer height = 1644
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "(재)발행하려는 간판"
end type

type gb_7 from groupbox within w_pisp241u
integer x = 846
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

type gb_8 from groupbox within w_pisp241u
integer x = 18
integer y = 160
integer width = 823
integer height = 232
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type dw_kbno_info from u_vi_std_datawindow within w_pisp241u
integer x = 55
integer y = 496
integer width = 1527
integer height = 1532
integer taborder = 0
string dataobject = "d_pisp241u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type gb_3 from groupbox within w_pisp241u
integer x = 18
integer y = 416
integer width = 1600
integer height = 1644
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "간판 번호 정보"
end type

type dw_print from datawindow within w_pisp241u
integer x = 1166
integer y = 1560
integer width = 937
integer height = 436
boolean bringtotop = true
boolean titlebar = true
string title = "간판 번호 인쇄"
string dataobject = "d_pisp241u_03"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_1 from groupbox within w_pisp241u
integer x = 2245
integer y = 160
integer width = 1253
integer height = 232
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type gb_9 from groupbox within w_pisp241u
integer x = 1723
integer y = 160
integer width = 517
integer height = 232
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

