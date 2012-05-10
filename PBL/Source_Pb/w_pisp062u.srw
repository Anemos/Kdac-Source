$PBExportHeader$w_pisp062u.srw
$PBExportComments$일일생산계획 - SR 현황
forward
global type w_pisp062u from window
end type
type cb_4 from commandbutton within w_pisp062u
end type
type cb_3 from commandbutton within w_pisp062u
end type
type st_1 from statictext within w_pisp062u
end type
type ddlb_1 from dropdownlistbox within w_pisp062u
end type
type dw_print from datawindow within w_pisp062u
end type
type cb_2 from commandbutton within w_pisp062u
end type
type st_v_bar from uo_xc_splitbar within w_pisp062u
end type
type dw_qty from datawindow within w_pisp062u
end type
type cb_1 from commandbutton within w_pisp062u
end type
type gb_1 from groupbox within w_pisp062u
end type
type gb_5 from groupbox within w_pisp062u
end type
type dw_1 from datawindow within w_pisp062u
end type
type gb_2 from groupbox within w_pisp062u
end type
end forward

global type w_pisp062u from window
integer y = 1000
integer width = 91
integer height = 152
boolean titlebar = true
string title = "SR 및 DDRS 현황"
boolean minbox = true
windowtype windowtype = child!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
cb_4 cb_4
cb_3 cb_3
st_1 st_1
ddlb_1 ddlb_1
dw_print dw_print
cb_2 cb_2
st_v_bar st_v_bar
dw_qty dw_qty
cb_1 cb_1
gb_1 gb_1
gb_5 gb_5
dw_1 dw_1
gb_2 gb_2
end type
global w_pisp062u w_pisp062u

type variables
Boolean	ib_open, ib_change
String	is_todate, is_plandate[16], is_areacode, is_divisioncode, &
			is_workcenter, is_linecode, is_itemcode, is_invcompute = "1"
Long		il_selected_row_qty//, il_scrollpos_ver
datawindow	idw_1, idw_qty
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_set_invqty ()
end prototypes

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_qty.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

dw_qty.ShareData(dw_1)
//dw_1.ShareData(dw_qty)
//dw_1.ShareData(dw_print)

ib_open = True
end event

public subroutine wf_set_invqty ();Long		i, j, ll_invqty, ll_computeqty, ll_row
String	ls_itemcode, ls_itemcode_info

idw_1.AcceptText()

ll_row	= dw_1.GetRow()

If ll_row > 0 Then
	//
Else
	Return
End If

ls_itemcode_info	= Trim(dw_1.GetItemString(ll_row, "ItemCode"))

If idw_1.RowCount() > 0 Then
	For i = 1 To idw_1.RowCount()
		ls_itemcode	= Trim(idw_1.GetItemString(i, "ItemCode"))
		If ls_itemcode = ls_itemcode_info Then
			For j = 1 To 16
				ll_invqty		= 0
				ll_computeqty	= 0
				ll_invqty		= dw_qty.GetItemNumber(ll_row, "invqty" + Right("00" + String(j), 2))
				ll_computeqty	= dw_qty.GetItemNumber(ll_row, "ComputeQty" + Right("00" + String(j), 2))
				idw_1.SetItem(i, "InvQty" + Right("00" + String(j), 2), ll_invqty)
				idw_1.SetItem(i, "DummyQty" + Right("00" + String(j), 2), ll_computeqty)
			Next
		End If
	Next
End If
idw_1.AcceptText()
end subroutine

on w_pisp062u.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.dw_print=create dw_print
this.cb_2=create cb_2
this.st_v_bar=create st_v_bar
this.dw_qty=create dw_qty
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_5=create gb_5
this.dw_1=create dw_1
this.gb_2=create gb_2
this.Control[]={this.cb_4,&
this.cb_3,&
this.st_1,&
this.ddlb_1,&
this.dw_print,&
this.cb_2,&
this.st_v_bar,&
this.dw_qty,&
this.cb_1,&
this.gb_1,&
this.gb_5,&
this.dw_1,&
this.gb_2}
end on

on w_pisp062u.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.dw_print)
destroy(this.cb_2)
destroy(this.st_v_bar)
destroy(this.dw_qty)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_5)
destroy(this.dw_1)
destroy(this.gb_2)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size		= istr_parms.string_arg[1]
idw_1			= istr_parms.datawindow_arg[1]
idw_qty		= istr_parms.datawindow_arg[2]

//f_pisc_win_move(This, ls_size)

//Show()

PostEvent("ue_postopen")
end event

event resize;//il_resize_count ++
//
//of_resize_register(dw_1, LEFT)
//of_resize_register(st_v_bar, SPLIT)
//of_resize_register(dw_qty, RIGHT)
//
//of_resize()

dw_1.Resize(dw_1.Width, newheight - gb_1.Y - gb_1.Height - 10)
st_v_bar.Move(dw_1.X + dw_1.Width + 5, dw_1.Y)
st_v_bar.Resize(15, dw_1.Height)
dw_qty.Move(st_v_bar.X + st_v_bar.Width + 5, dw_1.Y)
dw_qty.Resize(newwidth - st_v_bar.X - st_v_bar.Width - 20, dw_1.Height)

end event

type cb_4 from commandbutton within w_pisp062u
integer x = 3447
integer y = 60
integer width = 544
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "제품 인쇄(&P)"
end type

event clicked;Int		li_row
String	ls_mod, ls_itemcode
str_easy	lstr_prt

li_row	= dw_1.GetRow()

ls_itemcode	= Trim(dw_1.GetItemString(li_row, 'ItemCode'))

ls_mod	= "changeqty01_t.Text = '" + "~r~n" + Right(is_plandate[1], 5) + "'" + &
				"changeqty02_t.Text = '" + "~r~n" + Right(is_plandate[2], 5) + "'" + &
				"changeqty03_t.Text = '" + "~r~n" + Right(is_plandate[3], 5) + "'" + &
				"changeqty04_t.Text = '" + "~r~n" + Right(is_plandate[4], 5) + "'" + &
				"changeqty05_t.Text = '" + "~r~n" + Right(is_plandate[5], 5) + "'" + &
				"changeqty06_t.Text = '" + "~r~n" + Right(is_plandate[6], 5) + "'" + &
				"changeqty07_t.Text = '" + "~r~n" + Right(is_plandate[7], 5) + "'" + &
				"changeqty08_t.Text = '" + "~r~n" + Right(is_plandate[8], 5) + "'" + &
				"changeqty09_t.Text = '" + "~r~n" + Right(is_plandate[9], 5) + "'" + &
				"changeqty10_t.Text = '" + "~r~n" + Right(is_plandate[10], 5) + "'" + &
				"changeqty11_t.Text = '" + "~r~n" + Right(is_plandate[11], 5) + "'" + &
				"changeqty12_t.Text = '" + "~r~n" + Right(is_plandate[12], 5) + "'" + &
				"changeqty13_t.Text = '" + "~r~n" + Right(is_plandate[13], 5) + "'" + &
				"changeqty14_t.Text = '" + "~r~n" + Right(is_plandate[14], 5) + "'" + &
				"changeqty15_t.Text = '" + "~r~n" + Right(is_plandate[15], 5) + "'"

If dw_print.Retrieve(is_todate, &
							is_plandate[1],						is_plandate[2], &
							is_plandate[3],						is_plandate[4], &
							is_plandate[5],						is_plandate[6], &
							is_plandate[7],						is_plandate[8], &
							is_plandate[9],						is_plandate[10], &
							is_plandate[11],						is_plandate[12], &
							is_plandate[13],						is_plandate[14], &
							is_plandate[15],						is_plandate[16], &
							is_areacode,							is_divisioncode, &
							is_workcenter,							is_linecode, &
							ls_itemcode) > 0 Then
		
	lstr_prt.transaction = sqlpis
	lstr_prt.datawindow	= dw_print
	lstr_prt.title			= 'SR 및 DDRS 현황'
	lstr_prt.tag			= 'SR 및 DDRS 현황'
	lstr_prt.dwsyntax		= ls_mod
	OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
End If
end event

type cb_3 from commandbutton within w_pisp062u
integer x = 2359
integer y = 60
integer width = 544
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "숨기기(&C)"
end type

event clicked;	If IsValid(w_pisp062u) Then
		If w_pisp062u.Visible Then
			w_pisp062u.Visible	= False
		Else
			w_pisp062u.Visible	= True
		End If
	End If
end event

type st_1 from statictext within w_pisp062u
integer x = 649
integer y = 84
integer width = 942
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "재고계산 방식 전체 품번 적용:"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_pisp062u
integer x = 1600
integer y = 68
integer width = 631
integer height = 324
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "SR"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"SR","DDRS","SR / DDRS","DDRS + 소요량"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Long		i, j, k, ll_invqty, ll_computeqty
String	ls_areacode, ls_divisioncode, ls_itemcode
String	ls_itemcode_info

SetPointer(HourGlass!)

CHOOSE CASE index
	CASE 1
		is_invcompute	= "1"
	CASE 2
		is_invcompute	= "2"
	CASE 3
		is_invcompute	= "3"
	CASE 4
		is_invcompute	= "4"
END CHOOSE

For i = 1 To dw_1.RowCount()
	ls_areacode			= Trim(dw_1.GetItemString(i, "AreaCode"))
	ls_divisioncode	= Trim(dw_1.GetItemString(i, "DivisionCode"))
	ls_itemcode			= Trim(dw_1.GetItemString(i, "ItemCode"))
	
	Update	tinv
		Set	InvCompute		= :is_invcompute,
				LastEmp			= 'Y',
				LastDate			= GetDate()
	 Where	AreaCode			= :ls_areacode
		And	DivisionCode	= :ls_divisioncode
		And	ItemCode			= :ls_itemcode
	Using SQLPIS;
	
	dw_1.SetItem(i, "InvCompute", is_invcompute)
Next

// 일일 생산 계획의 색상을 변경하자.
idw_1.AcceptText()

If dw_1.RowCount() > 0 Then
	For k = 1 To dw_1.RowCount()
		ls_itemcode_info	= Trim(dw_1.GetItemString(k, "ItemCode"))
		If idw_1.RowCount() > 0 Then
			For i = 1 To idw_1.RowCount()
				ls_itemcode	= Trim(idw_1.GetItemString(i, "ItemCode"))
				If ls_itemcode = ls_itemcode_info Then
					For j = 1 To 16
						ll_invqty		= 0
						ll_computeqty	= 0
						ll_invqty		= dw_qty.GetItemNumber(k, "invqty" + Right("00" + String(j), 2))
						ll_computeqty	= dw_qty.GetItemNumber(k, "ComputeQty" + Right("00" + String(j), 2))
						idw_1.SetItem(i, "InvQty" + Right("00" + String(j), 2), ll_invqty)
						idw_1.SetItem(i, "DummyQty" + Right("00" + String(j), 2), ll_computeqty)
					Next
				End If
			Next
		End If
	Next
End If

idw_1.AcceptText()

SetPointer(Arrow!)

end event

type dw_print from datawindow within w_pisp062u
integer x = 215
integer y = 356
integer width = 663
integer height = 364
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp062u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type cb_2 from commandbutton within w_pisp062u
integer x = 3991
integer y = 60
integer width = 544
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "전체 인쇄(&P)"
end type

event clicked;String	ls_mod
str_easy	lstr_prt

ls_mod	= "changeqty01_t.Text = '" + "~r~n" + Right(is_plandate[1], 5) + "'" + &
				"changeqty02_t.Text = '" + "~r~n" + Right(is_plandate[2], 5) + "'" + &
				"changeqty03_t.Text = '" + "~r~n" + Right(is_plandate[3], 5) + "'" + &
				"changeqty04_t.Text = '" + "~r~n" + Right(is_plandate[4], 5) + "'" + &
				"changeqty05_t.Text = '" + "~r~n" + Right(is_plandate[5], 5) + "'" + &
				"changeqty06_t.Text = '" + "~r~n" + Right(is_plandate[6], 5) + "'" + &
				"changeqty07_t.Text = '" + "~r~n" + Right(is_plandate[7], 5) + "'" + &
				"changeqty08_t.Text = '" + "~r~n" + Right(is_plandate[8], 5) + "'" + &
				"changeqty09_t.Text = '" + "~r~n" + Right(is_plandate[9], 5) + "'" + &
				"changeqty10_t.Text = '" + "~r~n" + Right(is_plandate[10], 5) + "'" + &
				"changeqty11_t.Text = '" + "~r~n" + Right(is_plandate[11], 5) + "'" + &
				"changeqty12_t.Text = '" + "~r~n" + Right(is_plandate[12], 5) + "'" + &
				"changeqty13_t.Text = '" + "~r~n" + Right(is_plandate[13], 5) + "'" + &
				"changeqty14_t.Text = '" + "~r~n" + Right(is_plandate[14], 5) + "'" + &
				"changeqty15_t.Text = '" + "~r~n" + Right(is_plandate[15], 5) + "'"

If dw_print.Retrieve(is_todate, &
							is_plandate[1],						is_plandate[2], &
							is_plandate[3],						is_plandate[4], &
							is_plandate[5],						is_plandate[6], &
							is_plandate[7],						is_plandate[8], &
							is_plandate[9],						is_plandate[10], &
							is_plandate[11],						is_plandate[12], &
							is_plandate[13],						is_plandate[14], &
							is_plandate[15],						is_plandate[16], &
							is_areacode,							is_divisioncode, &
							is_workcenter,							is_linecode, &
							is_itemcode) > 0 Then
		
	lstr_prt.transaction = sqlpis
	lstr_prt.datawindow	= dw_print
	lstr_prt.title			= 'SR 및 DDRS 현황'
	lstr_prt.tag			= 'SR 및 DDRS 현황'
	lstr_prt.dwsyntax		= ls_mod
	OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
End If
end event

type st_v_bar from uo_xc_splitbar within w_pisp062u
integer x = 2331
integer y = 280
integer width = 14
end type

event constructor;call super::constructor;of_register(dw_1,LEFT)
of_register(dw_qty,RIGHT)
end event

type dw_qty from datawindow within w_pisp062u
event ue_editchanged ( long fl_row,  string fs_column,  long fl_data )
event ue_dwnkey pbm_dwnkey
integer x = 2377
integer y = 236
integer width = 722
integer height = 528
string title = "none"
string dataobject = "d_pisp062u_01_qty"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_editchanged;String	ls_column, ls_todate

AcceptText()
If fl_row > 0 Then
	ls_column = Right(fs_column, 2)

	ls_todate = f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())
	
	// 금일을 포함한 이전 계획은 변경이 불가능하다.
	If is_plandate[Integer(ls_column)] >= ls_todate Then
//		ib_change = True
		dw_1.SetItem(fl_row, "ChangeFlag", 'Y')
		dw_1.SetItem(fl_row, "ChangeFlag" + ls_column, 'Y')
	Else
		Return
	End If

	wf_set_invqty()
End If
end event

event ue_dwnkey;//화살표키(위,아래)와 pageUp,PageDown키 처리
LONG		ll_row, ll_column

ll_row = this.GetRow()

IF ll_row = 0 THEN RETURN -1

IF Key = KeyTab! THEN
	Return 0
END IF

IF Key = KeyDownArrow! THEN
	ll_column	= GetColumn()
	If ll_column > 69 And ll_column < 85 Then
		ll_column	= ll_column + 17
		This.SetRow(ll_row)
		This.SetColumn(ll_column)
	ElseIf ll_column > 86 And ll_column < 102 Then
		ll_column	= ll_column + 17
		This.SetRow(ll_row)
		This.SetColumn(ll_column)
	ElseIf ll_column > 103 And ll_column < 119 Then
		ll_column	= ll_column - 34
		This.SetRow(ll_row)
		This.SetColumn(ll_column)
	Else
		//
	End If
END IF

IF Key = KeyUpArrow! THEN
	ll_column	= GetColumn()
	If ll_column > 69 And ll_column < 85 Then
		ll_column	= ll_column + 34
		This.SetRow(ll_row)
		This.SetColumn(ll_column)
	ElseIf ll_column > 86 And ll_column < 102 Then
		ll_column	= ll_column - 17
		This.SetRow(ll_row)
		This.SetColumn(ll_column)
	ElseIf ll_column > 103 And ll_column < 119 Then
		ll_column	= ll_column - 17
		This.SetRow(ll_row)
		This.SetColumn(ll_column)
	Else
		//
	End If
END IF

Return 1
end event

event editchanged;AcceptText()

If row > 0 Then
	Trigger Event ue_editchanged(row, String(dwo.name), Long(Data))
End If
end event

event itemerror;Return 1
end event

event itemfocuschanged;If row <> il_selected_row_qty Then
	dw_1.Post Event RowFocusChanged(Row)
	dw_1.SetRow(Row)
	dw_1.ScrollToRow(Row)

	il_selected_row_qty	= row
End If
end event

event scrollvertical;dw_1.Object.DataWindow.VerticalScrollPosition	= scrollpos
end event

type cb_1 from commandbutton within w_pisp062u
integer x = 2903
integer y = 60
integer width = 544
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "소요량 저장(&S)"
end type

event clicked;int		i, j, li_count, &
			li_kdqty, li_asqty, li_etcqty01, li_etcqty02, li_etcqty03
String	ls_changeflag, ls_changeflag_date, ls_date, &
			ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

dw_1.AcceptText()

If dw_1.RowCount() > 0 Then
	//
Else
	MessageBox("SR 및 DDRS 현황", "소요량 정보를 조회하십시오.", Information!)
	Return
End If

If MessageBox("SR 및 DDRS 현황","변경하신 소요량 정보를 저장하시겠습니까 ?", Question!, YesNo!, 1) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

For i = 1 To dw_1.RowCount()
	ls_changeflag	= Trim(dw_1.GetItemString(i, "ChangeFlag"))
	If ls_changeflag = "Y" Then
		ls_areacode			= Trim(dw_1.GetItemString(i, "AreaCode"))
		ls_divisioncode	= Trim(dw_1.GetItemString(i, "DivisionCode"))
		ls_itemcode			= Trim(dw_1.GetItemString(i, "ItemCode"))
		For j = 1 To 16
			ls_date	= Right("0" + String(j), 2)
			ls_changeflag_date	= "N"
			ls_changeflag_date	= Trim(dw_1.GetItemString(i, "ChangeFlag" + ls_date))
			If ls_changeflag_date = "Y" Then
//				messagebox("", is_plandate[j] + ' ' + ls_itemcode)
				li_kdqty				= dw_1.GetItemNumber(i, "KDQty" + ls_date)
				li_asqty				= dw_1.GetItemNumber(i, "ASQty" + ls_date)
				li_etcqty01			= dw_1.GetItemNumber(i, "EtcQty01" + ls_date)
				li_etcqty02			= dw_1.GetItemNumber(i, "EtcQty02" + ls_date)
				li_etcqty03			= dw_1.GetItemNumber(i, "EtcQty03" + ls_date)
	
				li_count	= 0
				
				Select	Count(PlanDate)
				Into		:li_count
				From		tplanddrs
				Where		PlanDate			= :is_plandate[j]				And
							AreaCode			= :ls_areacode				And
							DivisionCode	= :ls_divisioncode		And
							ItemCode			= :ls_itemcode
				Using SQLPIS;

				If li_count > 0 Then
//					messagebox("", "U")
					Update	tplanddrs
						Set	KDQty				= :li_kdqty,
								ASQty				= :li_asqty,
								EtcQty01			= :li_etcqty01,
								EtcQty02			= :li_etcqty02,
								EtcQty03			= :li_etcqty03,
								LastEmp			= 'Y',
								LastDate			= GetDate()
					Where		PlanDate			= :is_plandate[j]				And
								AreaCode			= :ls_areacode				And
								DivisionCode	= :ls_divisioncode		And
								ItemCode			= :ls_itemcode
					Using SQLPIS;
					
					If SQLPIS.sqlcode = 0 Then
						lb_error	= False
					Else
						lb_error = True
						Exit
					End If
				Else
//					messagebox("", "I")
					Insert Into tplanddrs(PlanDate,
												AreaCode,				DivisionCode,
												ItemCode,
												PlanQty,
												PlanQty01,				PlanQty02,
												PlanQty03,				PlanQty04,
												PlanQty05,				PlanQty06,
												PlanQty07,				PlanQty08,
												PlanQty09,
												KDQty,					ASQty,
												EtcQty01,				EtcQty02,
												EtcQty03,
												LastEmp,					LastDate)
					Values					(:is_plandate[j],
												:ls_areacode,			:ls_divisioncode,
												:ls_itemcode,
												0,
												0,							0,
												0,							0,
												0,							0,
												0,							0,
												0,
												:li_kdqty,				:li_asqty,
												:li_etcqty01,			:li_etcqty02,
												:li_etcqty03,
												'Y',				GetDate())
					Using SQLPIS;

					If SQLPIS.sqlcode = 0 Then
						lb_error	= False
					Else
						lb_error = True
						Exit
					End If
				End If
			End If
		Next
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("SR 및 DDRS 현황", "변경된 소요량 정보를 저장하는 도중에 오류가 발생하였습니다.", StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("SR 및 DDRS 현황", "변경된 소요량 정보를 저장하였습니다.", Information!)
End If
end event

type gb_1 from groupbox within w_pisp062u
integer x = 23
integer width = 558
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_5 from groupbox within w_pisp062u
integer x = 2295
integer width = 2304
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_pisp062u
event ue_itemchanged ( long fl_row,  string fs_column,  string fs_data )
event ue_dwnkey pbm_dwnkey
integer x = 23
integer y = 208
integer width = 2176
integer height = 536
string title = "none"
string dataobject = "d_pisp062u_01_data"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_itemchanged;Int		li_count, i, li_invqty
long		ll_kdqty
String	ls_areacode, ls_divisioncode, ls_itemcode, ls_invcompute

AcceptText()
If fl_row > 0 Then
	If Upper(fs_column) <> "INVCOMPUTE" Then
		Return
	End If
	
	ls_areacode			= Trim(dw_1.GetItemString(fl_row, "AreaCode"))
	ls_divisioncode	= Trim(dw_1.GetItemString(fl_row, "DivisionCode"))
	ls_itemcode			= Trim(dw_1.GetItemString(fl_row, "ItemCode"))
	
	ls_invcompute		= Trim(dw_1.GetItemString(fl_row, "InvCompute"))
		
	li_count	= 0
					
	Select	Count(ItemCode)
	Into		:li_count
	From		tinv
	Where		AreaCode			= :ls_areacode				And
				DivisionCode	= :ls_divisioncode		And
				ItemCode			= :ls_itemcode
	Using SQLPIS;

	If li_count > 0 Then
		Update	tinv
			Set	InvCompute		= :ls_invcompute,
					LastEmp			= 'Y',
					LastDate			= GetDate()
		 Where	AreaCode			= :ls_areacode
			And	DivisionCode	= :ls_divisioncode
			And	ItemCode			= :ls_itemcode
		Using SQLPIS;
	Else
		Insert Into tinv(AreaCode,				DivisionCode,
								ItemCode,
								InvQty,				
								RepairQty,			DefectQty,
								MoveInvQty,			ShipInvQty,
								InvCompute,
								LastEmp,					LastDate)
		Values				(:ls_areacode,			:ls_divisioncode,
								:ls_itemcode,
								0,
								0,							0,
								0,							0,
								:ls_invcompute,
								'Y',				GetDate())
		Using SQLPIS;
	End If

	If SQLPIS.sqlcode = 0 Then
		Commit Using SQLPIS;
//		Return
	Else
		RollBack Using SQLPIS;
//		Return
	End If

	wf_set_invqty()
End If

end event

event ue_dwnkey;//화살표키(위,아래)와 pageUp,PageDown키 처리
LONG		ll_row

ll_row = this.GetRow()

IF ll_row = 0 THEN RETURN -1

IF Key = KeyTab! THEN
	Return 0
END IF

Return 1
end event

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

event scrollvertical;dw_qty.Object.DataWindow.VerticalScrollPosition	= scrollpos
end event

event itemchanged;AcceptText()

If row > 0 Then
	Trigger Event ue_itemchanged(row, String(dwo.name), Data)
End If

//Int		li_count, i, li_invqty
//String	ls_areacode, ls_divisioncode, ls_itemcode, ls_invcompute
//
//AcceptText()
//If row > 0 Then
//	If Upper(string(dwo.name)) <> "INVCOMPUTE" Then
//		Return
//	End If
//	
//	ls_areacode			= Trim(dw_1.GetItemString(row, "AreaCode"))
//	ls_divisioncode	= Trim(dw_1.GetItemString(row, "DivisionCode"))
//	ls_itemcode			= Trim(dw_1.GetItemString(row, "ItemCode"))
//	
//	ls_invcompute		= Trim(dw_1.GetItemString(row, "InvCompute"))
//
//		messageBox("", ls_invcompute)
//		
//	li_count	= 0
//					
//	Select	Count(ItemCode)
//	Into		:li_count
//	From		tinv
//	Where		AreaCode			= :ls_areacode				And
//				DivisionCode	= :ls_divisioncode		And
//				ItemCode			= :ls_itemcode
//	Using SQLPIS;
//
//	If li_count > 0 Then
//		Update	tinv
//			Set	InvCompute		= :ls_invcompute,
//					LastEmp			= :g_s_empno,
//					LastDate			= GetDate()
//		 Where	AreaCode			= :ls_areacode
//			And	DivisionCode	= :ls_divisioncode
//			And	ItemCode			= :ls_itemcode
//		Using SQLPIS;
//	Else
//		Insert Into tinv(AreaCode,				DivisionCode,
//								ItemCode,
//								InvQty,				
//								RepairQty,			DefectQty,
//								MoveInvQty,			ShipInvQty,
//								InvCompute,
//								LastEmp,					LastDate)
//		Values				(:ls_areacode,			:ls_divisioncode,
//								:ls_itemcode,
//								0,
//								0,							0,
//								0,							0,
//								:ls_invcompute,
//								:g_s_empno,				GetDate())
//		Using SQLPIS;
//	End If
//
//	If SQLPIS.sqlcode = 0 Then
//		Commit Using SQLPIS;
//		Return
//	Else
//		RollBack Using SQLPIS;
//		Return
//	End If
//	
//	wf_set_invqty()
//End If
//
end event

type gb_2 from groupbox within w_pisp062u
integer x = 585
integer width = 1705
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

