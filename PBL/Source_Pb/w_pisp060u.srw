$PBExportHeader$w_pisp060u.srw
$PBExportComments$일일생산계획
forward
global type w_pisp060u from w_ipis_sheet01
end type
type gb_5 from groupbox within w_pisp060u
end type
type dw_1 from datawindow within w_pisp060u
end type
type st_v_bar from uo_xc_splitbar within w_pisp060u
end type
type dw_qty from datawindow within w_pisp060u
end type
type dw_print from datawindow within w_pisp060u
end type
type uo_date from u_pisc_date_applydate within w_pisp060u
end type
type uo_area from u_pisc_select_area within w_pisp060u
end type
type uo_division from u_pisc_select_division within w_pisp060u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp060u
end type
type uo_line from u_pisc_select_line within w_pisp060u
end type
type uo_item from u_pisc_select_item_kb_line within w_pisp060u
end type
type cb_1 from commandbutton within w_pisp060u
end type
type cb_3 from commandbutton within w_pisp060u
end type
type cb_2 from commandbutton within w_pisp060u
end type
type cb_4 from commandbutton within w_pisp060u
end type
type gb_1 from groupbox within w_pisp060u
end type
type gb_2 from groupbox within w_pisp060u
end type
type gb_3 from groupbox within w_pisp060u
end type
type gb_4 from groupbox within w_pisp060u
end type
end forward

global type w_pisp060u from w_ipis_sheet01
integer width = 4677
string title = ""
gb_5 gb_5
dw_1 dw_1
st_v_bar st_v_bar
dw_qty dw_qty
dw_print dw_print
uo_date uo_date
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
uo_item uo_item
cb_1 cb_1
cb_3 cb_3
cb_2 cb_2
cb_4 cb_4
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_pisp060u w_pisp060u

type variables
Boolean	ib_open, ib_change
String	is_todate, is_plandate[16]
Long		il_selected_row_qty//, il_scrollpos_ver
end variables

forward prototypes
public subroutine wf_set_date ()
public function boolean wf_save ()
public subroutine wf_set_invqty ()
public subroutine wf_set_invqty_all ()
end prototypes

public subroutine wf_set_date ();String	ls_mod, ls_todate

is_plandate[1]		= ""
is_plandate[2]		= ""
is_plandate[3]		= ""
is_plandate[4]		= ""
is_plandate[5]		= ""
is_plandate[6]		= ""
is_plandate[7]		= ""
is_plandate[8]		= ""
is_plandate[9]		= ""
is_plandate[10]	= ""
is_plandate[11]	= ""
is_plandate[12]	= ""
is_plandate[13]	= ""
is_plandate[14]	= ""
is_plandate[15]	= ""
is_plandate[16]	= ""

is_todate			= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())
is_plandate[1]		= uo_date.is_uo_date
is_plandate[2]		= String(Relativedate(Date(is_plandate[1]), 1), "YYYY.MM.DD")
is_plandate[3]		= String(Relativedate(Date(is_plandate[2]), 1), "YYYY.MM.DD")
is_plandate[4]		= String(Relativedate(Date(is_plandate[3]), 1), "YYYY.MM.DD")
is_plandate[5]		= String(Relativedate(Date(is_plandate[4]), 1), "YYYY.MM.DD")
is_plandate[6]		= String(Relativedate(Date(is_plandate[5]), 1), "YYYY.MM.DD")
is_plandate[7]		= String(Relativedate(Date(is_plandate[6]), 1), "YYYY.MM.DD")
is_plandate[8]		= String(Relativedate(Date(is_plandate[7]), 1), "YYYY.MM.DD")
is_plandate[9]		= String(Relativedate(Date(is_plandate[8]), 1), "YYYY.MM.DD")
is_plandate[10]	= String(Relativedate(Date(is_plandate[9]), 1), "YYYY.MM.DD")
is_plandate[11]	= String(Relativedate(Date(is_plandate[10]), 1), "YYYY.MM.DD")
is_plandate[12]	= String(Relativedate(Date(is_plandate[11]), 1), "YYYY.MM.DD")
is_plandate[13]	= String(Relativedate(Date(is_plandate[12]), 1), "YYYY.MM.DD")
is_plandate[14]	= String(Relativedate(Date(is_plandate[13]), 1), "YYYY.MM.DD")
is_plandate[15]	= String(Relativedate(Date(is_plandate[14]), 1), "YYYY.MM.DD")
is_plandate[16]	= String(Relativedate(Date(is_plandate[15]), 1), "YYYY.MM.DD")

w_pisp062u.is_todate				= is_todate
w_pisp062u.is_plandate[1]		= is_plandate[1]
w_pisp062u.is_plandate[2]		= is_plandate[2]
w_pisp062u.is_plandate[3]		= is_plandate[3]
w_pisp062u.is_plandate[4]		= is_plandate[4]
w_pisp062u.is_plandate[5]		= is_plandate[5]
w_pisp062u.is_plandate[6]		= is_plandate[6]
w_pisp062u.is_plandate[7]		= is_plandate[7]
w_pisp062u.is_plandate[8]		= is_plandate[8]
w_pisp062u.is_plandate[9]		= is_plandate[9]
w_pisp062u.is_plandate[10]		= is_plandate[10]
w_pisp062u.is_plandate[11]		= is_plandate[11]
w_pisp062u.is_plandate[12]		= is_plandate[12]
w_pisp062u.is_plandate[13]		= is_plandate[13]
w_pisp062u.is_plandate[14]		= is_plandate[14]
w_pisp062u.is_plandate[15]		= is_plandate[15]
w_pisp062u.is_plandate[16]		= is_plandate[16]
w_pisp062u.is_areacode			= uo_area.is_uo_areacode
w_pisp062u.is_divisioncode		= uo_division.is_uo_divisioncode
w_pisp062u.is_workcenter		= uo_workcenter.is_uo_workcenter
w_pisp062u.is_linecode			= uo_line.is_uo_linecode
w_pisp062u.is_itemcode			= uo_item.is_uo_itemcode

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
dw_qty.Modify(ls_mod)

ls_mod	= "changeqty01_t.Text = '" + Right(is_plandate[1], 5) + "'" + &
				"changeqty02_t.Text = '" + Right(is_plandate[2], 5) + "'" + &
				"changeqty03_t.Text = '" + Right(is_plandate[3], 5) + "'" + &
				"changeqty04_t.Text = '" + Right(is_plandate[4], 5) + "'" + &
				"changeqty05_t.Text = '" + Right(is_plandate[5], 5) + "'" + &
				"changeqty06_t.Text = '" + Right(is_plandate[6], 5) + "'" + &
				"changeqty07_t.Text = '" + Right(is_plandate[7], 5) + "'" + &
				"changeqty08_t.Text = '" + Right(is_plandate[8], 5) + "'" + &
				"changeqty09_t.Text = '" + Right(is_plandate[9], 5) + "'" + &
				"changeqty10_t.Text = '" + Right(is_plandate[10], 5) + "'" + &
				"changeqty11_t.Text = '" + Right(is_plandate[11], 5) + "'" + &
				"changeqty12_t.Text = '" + Right(is_plandate[12], 5) + "'" + &
				"changeqty13_t.Text = '" + Right(is_plandate[13], 5) + "'" + &
				"changeqty14_t.Text = '" + Right(is_plandate[14], 5) + "'" + &
				"changeqty15_t.Text = '" + Right(is_plandate[15], 5) + "'"
w_pisp062u.dw_qty.Modify(ls_mod)
end subroutine

public function boolean wf_save ();int		i, j, li_count, li_rackqty, li_changeqty, &
			li_normalkbcount, li_normalkbqty, li_tempkbcount, li_tempkbqty
String	ls_changeflag, ls_changeflag_date, ls_todate, ls_releasedate, &
			ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

dw_1.AcceptText()

ls_todate	= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())

SQLPIS.AutoCommit = False

For i = 1 To dw_1.RowCount()
	ls_changeflag	= Trim(dw_1.GetItemString(i, "ChangeFlag"))

	If ls_changeflag = "Y" Then
		ls_areacode			= Trim(dw_1.GetItemString(i, "AreaCode"))
		ls_divisioncode	= Trim(dw_1.GetItemString(i, "DivisionCode"))
		ls_workcenter		= Trim(dw_1.GetItemString(i, "WorkCenter"))
		ls_linecode			= Trim(dw_1.GetItemString(i, "LineCode"))
		ls_itemcode			= Trim(dw_1.GetItemString(i, "ItemCode"))
//		li_rackqty			= dw_1.GetItemNumber(i, "RackQty")
		Select	RackQty
		Into		:li_rackqty
		From		tmstkb
		Where		AreaCode			= :ls_areacode			And
					DivisionCode	= :ls_divisioncode	And
					WorkCenter		= :ls_workcenter		And
					LineCode			= :ls_linecode			And
					ItemCode			= :ls_itemcode
		Using	SQLPIS;
//		-- 일단 조립지시가 된 일자까지는 일일생산계획을 건딜면....안되지..
//		-- 근데, 라인별로 관리해야 한다.
//		-- 왜냐하면, 평준화순서계획이 라인단위로 수립되므로
//		-- 라인에 해당하는 제품의 일일생산계획을 바꿔도 그 라인에 제품 하나라도 조립 지시가 되면
//		-- 평준화 순서계획은 바꿀수 없다.
		li_count	= 0
//		SetNull(ls_releasedate)
		Select	Max(PlanDate), Count(PlanDate)
		Into		:ls_releasedate, :li_count
		From		tplanrelease
		Where		AreaCode			= :ls_areacode				And
					DivisionCode	= :ls_divisioncode		And
					WorkCenter		= :ls_workcenter			And
					LineCode			= :ls_linecode				And
					ReleaseGubun	In ('Y', 'T', 'N', 'U')
		Using SQLPIS;

		If li_count > 0 Then
			ls_releasedate	= ls_releasedate
		Else
			ls_releasedate	= ls_todate
		End If

		For j = 1 To 15
			If is_plandate[j] > ls_todate And is_plandate[j] > ls_releasedate Then
				ls_changeflag_date	= "N"
				ls_changeflag_date	= Trim(dw_1.GetItemString(i, "ChangeFlag" + Right("0" + String(j), 2)))
				If ls_changeflag_date = "Y" Then
					li_changeqty	= dw_1.GetItemNumber(i, "ChangeQty" + Right("0" + String(j), 2))
					If li_rackqty < 1 Then
						li_rackqty = 1
					End If
					// 정규 및 임시 간판 매수를 미리 계산하자.
					If li_changeqty > 0 Then
						li_normalkbcount	= li_changeqty / li_rackqty
						li_normalkbqty		= li_normalkbcount * li_rackqty
					
						If Mod(li_changeqty, li_rackqty) > 0 Then
							li_tempkbcount	= 1
						Else
							li_tempkbcount	= 0
						End If
					
						li_tempkbqty		= li_changeqty - li_normalkbqty
					Else
						li_normalkbcount	= 0
						li_normalkbqty		= 0
						li_tempkbcount		= 0
						li_tempkbqty		= 0
					End If

					Select	Count(PlanDate)
					Into		:li_count
					From		tplanday
					Where		PlanDate			= :is_plandate[j]			And
								AreaCode			= :ls_areacode				And
								DivisionCode	= :ls_divisioncode		And
								WorkCenter		= :ls_workcenter			And
								LineCode			= :ls_linecode				And
								ItemCode			= :ls_itemcode
					Using SQLPIS;
	
					If li_count > 0 Then
						Update	tplanday
							Set	ChangeQty		= :li_changeqty,
									NormalKBCount	= :li_normalkbcount,
									NormalKBQty		= :li_normalkbqty,
									TempKBCount		= :li_tempkbcount,
									TempKBQty		= :li_tempkbqty,
									LastEmp			= 'Y',
									LastDate			= GetDate()
						 Where	PlanDate			= :is_plandate[j]
							And	AreaCode			= :ls_areacode
							And	DivisionCode	= :ls_divisioncode
							And	WorkCenter		= :ls_workcenter
							And	LineCode			= :ls_linecode
							And	ItemCode			= :ls_itemcode
						Using SQLPIS;
						
						If SQLPIS.sqlcode = 0 Then
							lb_error	= False
						Else
							lb_error = True
							Exit
						End If
					Else
						Insert Into tplanday	(PlanDate,
													AreaCode,				DivisionCode,
													WorkCenter,				LineCode,
													ItemCode,
													PlanQty,					ChangeQty,
													NormalKBCount,			NormalKBQty,
													TempKBCount,			TempKBQty,
													LastEmp,					LastDate)
						Values					(:is_plandate[j],
													:ls_areacode,			:ls_divisioncode,
													:ls_workcenter,		:ls_linecode,
													:ls_itemcode,
													0,							:li_changeqty,
													:li_normalkbcount,	:li_normalkbqty,
													:li_tempkbcount,		:li_tempkbqty,
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
			End If
		Next
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	Return False
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	Return True
End If
end function

public subroutine wf_set_invqty ();Long		i, j, ll_invqty, ll_computeqty, ll_row
String	ls_itemcode, ls_itemcode_info

dw_1.AcceptText()

ll_row	= w_pisp062u.dw_1.GetRow()

If ll_row > 0 Then
	//
Else
	Return
End If

ls_itemcode_info	= Trim(w_pisp062u.dw_1.GetItemString(ll_row, "ItemCode"))

If dw_1.RowCount() > 0 Then
	For i = 1 To dw_1.RowCount()
		ls_itemcode	= Trim(dw_1.GetItemString(i, "ItemCode"))
		If ls_itemcode = ls_itemcode_info Then
			For j = 1 To 16
				ll_invqty		= 0
				ll_computeqty	= 0
				ll_invqty		= w_pisp062u.dw_qty.GetItemNumber(ll_row, "invqty" + Right("00" + String(j), 2))
				ll_computeqty	= w_pisp062u.dw_qty.GetItemNumber(ll_row, "ComputeQty" + Right("00" + String(j), 2))
				dw_1.SetItem(i, "InvQty" + Right("00" + String(j), 2), ll_invqty)
				dw_1.SetItem(i, "DummyQty" + Right("00" + String(j), 2), ll_computeqty)
			Next
		End If
	Next
End If
dw_1.AcceptText()
end subroutine

public subroutine wf_set_invqty_all ();Long		k, i, j, ll_invqty, ll_computeqty
String	ls_itemcode, ls_itemcode_info

If w_pisp062u.dw_1.RowCount() > 0 Then
	For k = 1 To w_pisp062u.dw_1.RowCount()
		ls_itemcode_info	= Trim(w_pisp062u.dw_1.GetItemString(k, "ItemCode"))
		If dw_1.RowCount() > 0 Then
			For i = 1 To dw_1.RowCount()
				ls_itemcode	= Trim(dw_1.GetItemString(i, "ItemCode"))
				If ls_itemcode = ls_itemcode_info Then
					For j = 1 To 16
						ll_invqty		= 0
						ll_computeqty	= 0
						ll_invqty		= w_pisp062u.dw_qty.GetItemNumber(k, "InvQty" + Right("00" + String(j), 2))
						ll_computeqty	= w_pisp062u.dw_qty.GetItemNumber(k, "ComputeQty" + Right("00" + String(j), 2))
						dw_1.SetItem(i, "InvQty" + Right("00" + String(j), 2), ll_invqty)
						dw_1.SetItem(i, "DummyQty" + Right("00" + String(j), 2), ll_computeqty)
					Next
				End If
			Next
		End If
	Next
End If

//dw_1.AcceptText()
end subroutine

on w_pisp060u.create
int iCurrent
call super::create
this.gb_5=create gb_5
this.dw_1=create dw_1
this.st_v_bar=create st_v_bar
this.dw_qty=create dw_qty
this.dw_print=create dw_print
this.uo_date=create uo_date
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.uo_item=create uo_item
this.cb_1=create cb_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_4=create cb_4
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_v_bar
this.Control[iCurrent+4]=this.dw_qty
this.Control[iCurrent+5]=this.dw_print
this.Control[iCurrent+6]=this.uo_date
this.Control[iCurrent+7]=this.uo_area
this.Control[iCurrent+8]=this.uo_division
this.Control[iCurrent+9]=this.uo_workcenter
this.Control[iCurrent+10]=this.uo_line
this.Control[iCurrent+11]=this.uo_item
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.cb_2
this.Control[iCurrent+15]=this.cb_4
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.gb_2
this.Control[iCurrent+18]=this.gb_3
this.Control[iCurrent+19]=this.gb_4
end on

on w_pisp060u.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.dw_1)
destroy(this.st_v_bar)
destroy(this.dw_qty)
destroy(this.dw_print)
destroy(this.uo_date)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.uo_item)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_4)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, LEFT)
of_resize_register(st_v_bar, SPLIT)
of_resize_register(dw_qty, RIGHT)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_qty.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

dw_1.ShareData(dw_qty)
//dw_1.ShareData(dw_print)

cb_2.Enabled	= m_frame.m_action.m_save.Enabled
cb_3.Enabled	= m_frame.m_action.m_save.Enabled
cb_4.Enabled	= m_frame.m_action.m_save.Enabled

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

f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										uo_line.is_uo_linecode, &
										'%', &
										True, &
										uo_item.is_uo_itemcode, &
										uo_item.is_uo_itemname)
If IsValid(w_pisp062u) = False Then
	istr_parms.string_arg[1] = is_size
	istr_parms.datawindow_arg[1] = dw_1
	istr_parms.datawindow_arg[2] = dw_qty
	OpenWithParm(w_pisp062u, istr_parms)
	//Open(w_pisp062u)
	w_pisp062u.Visible	= False
	w_pisp062u.Resize(iw_this.Width - 20, 1150)
	w_pisp062u.Move(dw_1.X + 10, dw_1.Y + 900)
	
//	w_pisp062u.dw_1.SetTransObject(SQLPIS)
//	w_pisp062u.dw_qty.SetTransObject(SQLPIS)
//	w_pisp062u.dw_print.SetTransObject(SQLPIS)
	
	w_pisp062u.cb_1.Enabled	= m_frame.m_action.m_save.Enabled
	w_pisp062u.ddlb_1.Enabled	= m_frame.m_action.m_save.Enabled
End If

ib_open = True
iw_this.TriggerEvent("ue_reset")
end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_qty.ReSet()
dw_print.ReSet()

w_pisp062u.dw_1.ReSet()
w_pisp062u.dw_qty.ReSet()
w_pisp062u.dw_print.ReSet()

ib_change = False

wf_set_date()
end event

event ue_retrieve;call super::ue_retrieve;int		li_return
String	ls_todate

If ib_change Then
	li_return =  MessageBox("일일생산계획", "변경된 일일생산계획 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?" + &
							"~r~n~r~n(주의)" + &
							"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 저장됩니다.", Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_save() Then
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
		Else
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
End If

SetPointer(HourGlass!)

ib_change = False

iw_this.TriggerEvent("ue_reset")
ls_todate	= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())

If dw_1.Retrieve(ls_todate, &
				is_plandate[1],						is_plandate[2], &
				is_plandate[3],						is_plandate[4], &
				is_plandate[5],						is_plandate[6], &
				is_plandate[7],						is_plandate[8], &
				is_plandate[9],						is_plandate[10], &
				is_plandate[11],						is_plandate[12], &
				is_plandate[13],						is_plandate[14], &
				is_plandate[15],						is_plandate[16], &
				uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
				uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
				uo_item.is_uo_itemcode) > 0 Then

	uo_status.st_message.text =  "S/R 및 DDRS 현황 정보 조회중입니다..." //+ f_message("변경된 데이타가 없습니다.")
	If IsValid(w_pisp062u) Then
		w_pisp062u.dw_qty.Retrieve(ls_todate, &
							is_plandate[1],						is_plandate[2], &
							is_plandate[3],						is_plandate[4], &
							is_plandate[5],						is_plandate[6], &
							is_plandate[7],						is_plandate[8], &
							is_plandate[9],						is_plandate[10], &
							is_plandate[11],						is_plandate[12], &
							is_plandate[13],						is_plandate[14], &
							is_plandate[15],						is_plandate[16], &
							uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
							uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
							uo_item.is_uo_itemcode)
	End If
	uo_status.st_message.text =  "일일생산계획 정보" //+ f_message("변경된 데이타가 없습니다.")
	wf_set_invqty_all()
	dw_1.SetRow(1)
	dw_1.Trigger Event RowFocusChanged(1)
	dw_1.ScrollToRow(1)
Else
	SetPointer(Arrow!)
	uo_status.st_message.text =  "일일생산계획이 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("일일생산계획", "일일생산계획이 존재하지 않습니다")
End If

SetPointer(Arrow!)
end event

event closequery;call super::closequery;int	li_return

If ib_change Then
	li_return =  MessageBox("일일생산계획", "변경된 일일생산계획 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 종료하시겠습니까?" + &
							"~r~n~r~n(주의)" + &
							"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 저장됩니다.", Question!, YesNoCancel!, 3)

	If li_return = 1 Then		
		If wf_save() Then
			If IsValid(w_pisp062u) Then
				Close(w_pisp062u)
			End If
			Return 0
//			uo_status.st_message.text =  "Work Calendar 정보를 변경하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("일일생산계획", "변경된 일일생산계획 정보를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
			Return 1
		End If
	ElseIf li_return = 2 Then
		If IsValid(w_pisp062u) Then
			Close(w_pisp062u)
		End If
		Return 0
	ElseIf li_return = 3 Then
		Return 1
	End If
Else
	If IsValid(w_pisp062u) Then
		Close(w_pisp062u)
	End If
End If
end event

event ue_delete;call super::ue_delete;int		li_return, li_row, li_count
Long		ll_find
String	ls_planmonth, ls_todate, ls_releasedate, &
			ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

li_row	= dw_1.GetRow()

If li_row > 0 Then
	//
Else	
	uo_status.st_message.text =  "일일생산계획을 삭제하려는 제품을 선택하여 주십시오." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "일일생산계획을 삭제하려는 제품을 선택하여 주십시오.", StopSign!)
	Return
End If

If ib_change Then
	li_return =  MessageBox("일일생산계획", "변경된 일일생산계획 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에" + &
							"~r~n~r~n선택하신 제품의 " + Left(uo_date.is_uo_date, 7) + &
							"월의 일일생산계획을 삭제하시겠습니까?" + &
							"~r~n~r~n(주의)" + &
							"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 삭제됩니다.", Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_save() Then
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
	ib_change = False
Else
	If MessageBox("일일생산계획", "선택하신 제품의 " + Left(uo_date.is_uo_date, 7) + &
		"월의 일일생산계획을 삭제하시겠습니까?" + &
		"~r~n~r~n(주의)" + &
		"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 삭제됩니다.", Question!, YesNo!, 2) = 2 Then
		Return
	End If
End If

ls_planmonth	= Left(uo_date.is_uo_date, 7)
ls_todate		= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())

ls_areacode			= Trim(dw_1.GetItemString(li_row, "AreaCode"))
ls_divisioncode	= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
ls_workcenter		= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
ls_linecode			= Trim(dw_1.GetItemString(li_row, "LineCode"))
ls_itemcode			= Trim(dw_1.GetItemString(li_row, "ItemCode"))

//		-- 일단 조립지시가 된 일자까지는 일일생산계획을 건딜면....안되지..
//		-- 근데, 라인별로 관리해야 한다.
//		-- 왜냐하면, 평준화순서계획이 라인단위로 수립되므로
//		-- 라인에 해당하는 제품의 일일생산계획을 바꿔도 그 라인에 제품 하나라도 조립 지시가 되면
//		-- 평준화 순서계획은 바꿀수 없다.
li_count = 0
Select	Max(PlanDate), Count(PlanDate)
Into		:ls_releasedate, :li_count
From		tplanrelease
Where		PlanDate			Like :ls_planmonth + '.__'		And
			AreaCode			= :ls_areacode				And
			DivisionCode	= :ls_divisioncode		And
			WorkCenter		= :ls_workcenter			And
			LineCode			= :ls_linecode				And
			ReleaseGubun	In ('Y', 'T', 'N', 'U')
Using SQLPIS;

If li_count > 0 Then
	ls_releasedate	= ls_releasedate
Else
	ls_releasedate	= ls_todate
End If

SQLPIS.AutoCommit = False

Update	tplanday
Set		ChangeQty		= 0,
			NormalKBCount	= 0,
			NormalKBQty		= 0,
			TempKBCount		= 0,
			TempKBQty		= 0,
			LastEmp			= 'Y',
			LastDate			= GetDate()
Where		PlanDate			Like :ls_planmonth + '.__'		And
			PlanDate			> :ls_todate				And
			PlanDate			> :ls_releasedate			And
			AreaCode			= :ls_areacode				And
			DivisionCode	= :ls_divisioncode		And
			WorkCenter		= :ls_workcenter			And
			LineCode			= :ls_linecode				And
			ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_change	= False
	uo_status.st_message.text =  "일일생산계획 정보를 삭제하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "일일생산계획 정보를 삭제하였습니다.", Information!)
	TriggerEvent("ue_retrieve")
	ll_find	= dw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"WorkCenter = '" + ls_workcenter + "' And " + &
								"LineCode = '" + ls_linecode + "' And " + &
								"ItemCode = '" + ls_itemcode + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then
		dw_1.SetFocus()
		dw_1.SetRow(ll_find)
		dw_1.Trigger Event RowFocusChanged(ll_find)
		dw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "일일생산계획 정보를 삭제하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "일일생산계획 정보를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If
end event

event ue_insert;call super::ue_insert;int		li_return, li_row

If ib_change Then
	li_return =  MessageBox("일일생산계획", "변경된 일일생산계획 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 생산계획을 추가하시겠습니까?" + &
							"~r~n~r~n(주의)" + &
							"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 저장됩니다.", Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_save() Then
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
End If

ib_change = False

li_row	= dw_1.GetRow()

If li_row > 0 Then
	//
Else
	MessageBox("일일생산계획", "제품을 선택하여 주십시오.", StopSign!)
	Return
End If

istr_parms.string_arg[1] = is_size
istr_parms.string_arg[2] = uo_date.is_uo_date

istr_parms.string_arg[3] = Trim(dw_1.GetItemString(li_row, 'AreaCode'))
istr_parms.string_arg[4] = Trim(dw_1.GetItemString(li_row, 'DivisionCode'))
istr_parms.string_arg[5] = Trim(dw_1.GetItemString(li_row, 'WorkCenter'))
istr_parms.string_arg[6] = Trim(dw_1.GetItemString(li_row, 'LineCode'))
//istr_parms.string_arg[7] = Trim(dw_1.GetItemString(li_row, 'ItemCode'))

OpenWithParm(w_pisp061u, istr_parms)

If Upper(Message.StringParm) = "CHANGE" Then
	TriggerEvent("ue_retrieve")
End If
end event

event ue_save;call super::ue_save;Int	li_row
Long	ll_find
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

dw_1.AcceptText()

If ib_change = False Then
	uo_status.st_message.text =  "변경된 정보가 없습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("일일생산계획","변경된 정보가 없습니다.")
	Return
End If

If MessageBox("일일생산계획","변경하신 일일생산계획 정보를 저장하시겠습니까 ?" + &
							"~r~n~r~n(주의)" + &
							"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 저장됩니다.", Question!, YesNo!, 1) = 2 Then
	Return
Else
	uo_status.st_message.text =  "변경된 일일생산계획 정보 저장 중..." //+ f_message("Work Carlendar 정보 등록 중...")
End If

li_row = dw_1.GetRow()

If li_row > 0 Then
	ls_areacode			= Trim(dw_1.GetItemString(li_row, "AreaCode"))
	ls_divisioncode	= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
	ls_workcenter		= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
	ls_linecode			= Trim(dw_1.GetItemString(li_row, "LineCode"))
	ls_itemcode			= Trim(dw_1.GetItemString(li_row, "ItemCode"))
End If

If wf_save() Then
	ib_change	= False
	uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
	MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하였습니다.", Information!)
	TriggerEvent("ue_retrieve")
	ll_find	= dw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"WorkCenter = '" + ls_workcenter + "' And " + &
								"LineCode = '" + ls_linecode + "' And " + &
								"ItemCode = '" + ls_itemcode + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then
		dw_1.SetRow(ll_find)
		dw_1.Trigger Event RowFocusChanged(ll_find)
		dw_1.ScrollToRow(ll_find)
	End If
Else
	uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하는 도중에 오류가 발생하였습니다.", StopSign!)
End If
end event

event ue_print;call super::ue_print;String	ls_todate, ls_mod
str_easy	lstr_prt

ls_todate	= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())

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

If dw_print.Retrieve(ls_todate, &
				is_plandate[1],						is_plandate[2], &
				is_plandate[3],						is_plandate[4], &
				is_plandate[5],						is_plandate[6], &
				is_plandate[7],						is_plandate[8], &
				is_plandate[9],						is_plandate[10], &
				is_plandate[11],						is_plandate[12], &
				is_plandate[13],						is_plandate[14], &
				is_plandate[15],						is_plandate[16], &
				uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
				uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
				uo_item.is_uo_itemcode) > 0 Then

	lstr_prt.transaction = sqlpis
	lstr_prt.datawindow	= dw_print
	lstr_prt.title			= '일일 생산계획'
	lstr_prt.tag			= '일일 생산계획'
	lstr_prt.dwsyntax		= ls_mod
	OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
End If
end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_qty.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

If IsValid(w_pisp062u) Then
	w_pisp062u.dw_1.SetTransObject(SQLPIS)
	w_pisp062u.dw_qty.SetTransObject(SQLPIS)
	w_pisp062u.dw_print.SetTransObject(SQLPIS)

	w_pisp062u.cb_1.Enabled	= m_frame.m_action.m_save.Enabled
	w_pisp062u.ddlb_1.Enabled	= m_frame.m_action.m_save.Enabled
End If
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp060u
end type

type gb_5 from groupbox within w_pisp060u
integer x = 2615
integer width = 1691
integer height = 332
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_1 from datawindow within w_pisp060u
event ue_dwnkey pbm_dwnkey
integer x = 14
integer y = 336
integer width = 2194
integer height = 1056
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisp060u_01_data"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;//화살표키(위,아래)와 pageUp,PageDown키 처리
LONG		ll_row

ll_row = this.GetRow()

IF ll_row = 0 THEN RETURN -1

IF Key = KeyTab! THEN
	Return 0
END IF

IF Key = KeyDownArrow! THEN
	Return 0
END IF

IF Key = KeyUpArrow! THEN
	Return 0
END IF

IF Key = KeyPageDown! THEN
	Return 0
END IF

IF Key = KeyPageUp! THEN
	Return 0
END IF

Return 1
end event

event rowfocuschanged;Long		ll_find
String	ls_itemcode_old, ls_itemcode_new

If CurrentRow > 0 Then
	SelectRow(0,FALSE)
	SelectRow(currentrow,TRUE)
	
//	ls_itemcode_old	= Trim(dw_1.GetItemString(il_selected_row_qty, "ItemCode"))
	ls_itemcode_new	= Trim(dw_1.GetItemString(CurrentRow, "ItemCode"))
//	
//	If il_selected_row_qty <> CurrentRow And ls_itemcode_new <> ls_itemcode_old Then
		If IsValid(w_pisp062u) Then
			ll_find = w_pisp062u.dw_1.Find("ItemCode ='"+ls_itemcode_new+"'", 1, w_pisp062u.dw_1.RowCount())
			If ll_find > 0 Then
				w_pisp062u.dw_1.SetRow(ll_find)
				w_pisp062u.dw_1.Post Event RowFocusChanged(ll_find)
				w_pisp062u.dw_1.ScrolltoRow(ll_find)
//				dw_info.Object.DataWindow.HorizontalScrollPosition	= il_scrollpos_ver
			End If
		End If
//	End If
End If
end event

event scrollvertical;dw_qty.Object.DataWindow.VerticalScrollPosition	= scrollpos
end event

type st_v_bar from uo_xc_splitbar within w_pisp060u
integer x = 2309
integer y = 368
integer width = 14
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,LEFT)
of_register(dw_qty,RIGHT)
end event

type dw_qty from datawindow within w_pisp060u
event ue_editchanged ( long fl_row,  string fs_column,  long fl_data )
event ue_dwnkey pbm_dwnkey
event ue_vscroll pbm_vscroll
integer x = 2336
integer y = 340
integer width = 827
integer height = 672
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisp060u_01_qty"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_editchanged;String	ls_column, ls_todate, ls_itemcode
Long		ll_find, ll_oldqty, ll_changeqty, i, li_invqty

AcceptText()

If fl_row > 0 Then
	ls_column = Right(fs_column, 2)

	ls_todate = f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())
	
	// 금일을 포함한 이전 계획은 변경이 불가능하다.
	If is_plandate[Integer(ls_column)] > ls_todate Then
		ib_change = True
		dw_1.SetItem(fl_row, "ChangeFlag", 'Y')
		dw_1.SetItem(fl_row, "ChangeFlag" + ls_column, 'Y')
	Else
		Return
	End If

	// 여기부터 S/R 및 DDRS 현황의 계획도 변경하자..
	ll_oldqty	= dw_1.GetItemNumber(fl_row, "OldQty" + ls_column)
	dw_1.SetItem(fl_row, "OldQty" + ls_column, fl_data)

	ls_itemcode	= Trim(dw_1.GetItemString(fl_row, "ItemCode"))
	If IsValid(w_pisp062u) Then
		ll_find = w_pisp062u.dw_1.Find("ItemCode ='"+ls_itemcode+"'", 1, w_pisp062u.dw_1.RowCount())
		If ll_find > 0 Then
			ll_changeqty	= w_pisp062u.dw_1.GetItemNumber(ll_find, "ChangeQty" + ls_column)
			w_pisp062u.dw_1.SetItem(ll_find, "ChangeQty" + ls_column, ll_changeqty + (fl_data - ll_oldqty))
			w_pisp062u.dw_1.AcceptText()
			//iw_this.PostEvent("ue_set_invqty")
			wf_set_invqty()
			cb_1.SetFocus()
			dw_qty.SetFocus()
		End If
	End If
End If
end event

event ue_dwnkey;//화살표키(위,아래)와 pageUp,PageDown키 처리
LONG		ll_row
Long		ll_scrollPos, ll_detail
String	ls_Row, ls_vScrollPos, ls_Chk 

ll_row = this.GetRow()

IF ll_row = 0 THEN RETURN -1

IF Key = KeyTab! THEN
	Return 0
END IF

IF Key = KeyDownArrow! THEN
	Return 0
END IF

IF Key = KeyUpArrow! THEN
	Return 0
END IF

IF Key = KeyPageDown! THEN
	Return 0
END IF

IF Key = KeyPageUp! THEN
	Return 0
END IF

Return 1
end event

event ue_vscroll;//// DataWindow Event_ID pbm_vscroll 

//Long ll_scrollPos, ll_detail
//String ls_Row, ls_vScrollPos, ls_Chk 
//
////ll_header		= Long(Describe("DataWindow.Header.Height"))
//ll_detail		= Long(Describe("DataWindow.Detail.Height"))
//
//If scrollcode = 0 Then 		// ▲ 
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> 행간높이 
//	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//
//	Return 1 
//ElseIf scrollcode = 1 Then 	// ▼
//	
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) + ll_detail 
//	
//	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//	If ls_Chk <> '' Then MessageBox("", ls_Chk)
//	Return 1 
//End If 

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

event scrollhorizontal;If IsValid(w_pisp062u) Then
	w_pisp062u.dw_qty.Object.DataWindow.HorizontalScrollPosition	= scrollpos
End If
end event

event scrollvertical;dw_1.Object.DataWindow.VerticalScrollPosition	= scrollpos
end event

type dw_print from datawindow within w_pisp060u
integer x = 1074
integer y = 1056
integer width = 631
integer height = 408
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp060u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type uo_date from u_pisc_date_applydate within w_pisp060u
integer x = 55
integer y = 68
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type uo_area from u_pisc_select_area within w_pisp060u
integer x = 818
integer y = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_qty.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)

	w_pisp062u.dw_1.SetTransObject(SQLPIS)
	w_pisp062u.dw_qty.SetTransObject(SQLPIS)
	w_pisp062u.dw_print.SetTransObject(SQLPIS)

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

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	
	iw_this.TriggerEvent("ue_reset")
End If

end event

type uo_division from u_pisc_select_division within w_pisp060u
integer x = 1321
integer y = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_qty.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)

	w_pisp062u.dw_1.SetTransObject(SQLPIS)
	w_pisp062u.dw_qty.SetTransObject(SQLPIS)
	w_pisp062u.dw_print.SetTransObject(SQLPIS)

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

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	
	iw_this.TriggerEvent("ue_reset")
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp060u
integer x = 41
integer y = 224
boolean bringtotop = true
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
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	
	iw_this.TriggerEvent("ue_reset")
End If

end event

type uo_line from u_pisc_select_line within w_pisp060u
integer x = 731
integer y = 224
boolean bringtotop = true
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
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	
	iw_this.TriggerEvent("ue_reset")
End If

end event

type uo_item from u_pisc_select_item_kb_line within w_pisp060u
integer x = 1687
integer y = 224
boolean bringtotop = true
end type

on uo_item.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type cb_1 from commandbutton within w_pisp060u
integer x = 2665
integer y = 72
integer width = 786
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "S/R 및 DDRS 현황(&V)"
end type

event clicked;//If ib_info = False Then
//	ib_info = True
//	istr_parms.string_arg[1] = is_size
//	istr_parms.string_arg[2] = Left(uo_date.is_uo_date, 7)
//	OpenWithParm(w_pisp062u, istr_parms)
//	w_pisp062u.Resize(iw_this.Width - 50, 800)
//	w_pisp062u.Move(dw_1.X, dw_1.Y + 900)
//Else
	If IsValid(w_pisp062u) Then
		If w_pisp062u.Visible Then
			w_pisp062u.Visible	= False
		Else
			w_pisp062u.Visible	= True
		End If
	End If
//End If
end event

type cb_3 from commandbutton within w_pisp060u
integer x = 2665
integer y = 196
integer width = 786
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회된 계획 삭제(&A)"
end type

event clicked;int		i, li_return, li_count
String	ls_planmonth, ls_todate, ls_releasedate, &
			ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

If ib_change Then
	li_return =  MessageBox("일일생산계획", "변경된 일일생산계획 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에" + &
							"~r~n~r~n조회하신 모든 제품의 " + Left(uo_date.is_uo_date, 7) + &
							"월의 일일생산계획을 삭제하시겠습니까?" + &
							"~r~n~r~n(주의)" + &
							"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 삭제됩니다.", Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_save() Then
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
	ib_change = False
Else
	If MessageBox("일일생산계획", "조회하신 모든 제품의 " + Left(uo_date.is_uo_date, 7) + &
		"월의 일일생산계획을 삭제하시겠습니까?" + &
		"~r~n~r~n(주의)" + &
		"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 삭제됩니다.", Question!, YesNo!, 2) = 2 Then
		Return
	End If
End If

ls_planmonth	= Left(uo_date.is_uo_date, 7)
ls_todate		= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())

SQLPIS.AutoCommit = False

If dw_1.RowCount() > 0 Then
	For i = 1 To dw_1.RowCount()
		ls_areacode			= Trim(dw_1.GetItemString(i, "AreaCode"))
		ls_divisioncode	= Trim(dw_1.GetItemString(i, "DivisionCode"))
		ls_workcenter		= Trim(dw_1.GetItemString(i, "WorkCenter"))
		ls_linecode			= Trim(dw_1.GetItemString(i, "LineCode"))
		ls_itemcode			= Trim(dw_1.GetItemString(i, "ItemCode"))
		//		-- 일단 조립지시가 된 일자까지는 일일생산계획을 건딜면....안되지..
		//		-- 근데, 라인별로 관리해야 한다.
		//		-- 왜냐하면, 평준화순서계획이 라인단위로 수립되므로
		//		-- 라인에 해당하는 제품의 일일생산계획을 바꿔도 그 라인에 제품 하나라도 조립 지시가 되면
		//		-- 평준화 순서계획은 바꿀수 없다.
		li_count = 0
		Select	Max(PlanDate), Count(PlanDate)
		Into		:ls_releasedate, :li_count
		From		tplanrelease
		Where		PlanDate			Like :ls_planmonth + '.__'		And
					AreaCode			= :ls_areacode				And
					DivisionCode	= :ls_divisioncode		And
					WorkCenter		= :ls_workcenter			And
					LineCode			= :ls_linecode				And
					ReleaseGubun	In ('Y', 'T', 'N', 'U')
		Using SQLPIS;
		
		If li_count > 0 Then
			ls_releasedate	= ls_releasedate
		Else
			ls_releasedate	= ls_todate
		End If
		
		Update	tplanday
		Set		ChangeQty		= 0,
					NormalKBCount	= 0,
					NormalKBQty		= 0,
					TempKBCount		= 0,
					TempKBQty		= 0,
					LastEmp			= 'Y',
					LastDate			= GetDate()
		Where		PlanDate			Like :ls_planmonth + '.__'		And
					PlanDate			> :ls_todate				And
					PlanDate			> :ls_releasedate		And
					AreaCode			= :ls_areacode				And
					DivisionCode	= :ls_divisioncode		And
					WorkCenter		= :ls_workcenter			And
					LineCode			= :ls_linecode				And
					ItemCode			= :ls_itemcode
		Using SQLPIS;

		If SQLPIS.sqlcode = 0 Then
			lb_error	= False
		Else
			lb_error	= True
			Exit
		End If
	Next
End If

If lb_error = False Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_change	= False
	uo_status.st_message.text =  "일일생산계획 정보를 삭제하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "일일생산계획 정보를 삭제하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "일일생산계획 정보를 삭제하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "일일생산계획 정보를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If
end event

type cb_2 from commandbutton within w_pisp060u
integer x = 3470
integer y = 72
integer width = 786
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일일 생산계획 계산(&G)"
end type

event clicked;//If dw_1.GetRow() > 0 Then
	istr_parms.string_arg[1] = is_size
	istr_parms.string_arg[2] = Left(uo_date.is_uo_date, 7)
	If dw_1.GetRow() > 0 Then
		istr_parms.string_arg[3] = Trim(dw_1.GetItemString(dw_1.GetRow(), "ItemCode"))
	Else
		istr_parms.string_arg[3] = "%"
	End If

	OpenWithParm(w_pisp002u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
		iw_this.TriggerEvent("ue_reset")
		iw_this.TriggerEvent("ue_retrieve")
	End If
//Else
//	uo_status.st_message.text =  "일일생산계획을 재계산하려는 제품을 선택하여 주십시요." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
//	MessageBox("일일생산계획", "일일생산계획을 재계산하려는 제품을 선택하여 주십시요.", StopSign!)
//	Return	
//End If
end event

type cb_4 from commandbutton within w_pisp060u
integer x = 3470
integer y = 196
integer width = 786
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생산중단 품번 등록(&S)"
end type

event clicked;int		li_return, li_row
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

If ib_change Then
	li_return =  MessageBox("일일생산계획", "변경된 일일생산계획 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에" + &
							"~r~n~r~n선택하신 제품을 생산중단 처리하시겠습니까?", Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_save() Then
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
	ib_change = False
Else
	If MessageBox("일일생산계획", "선택하신 제품을 생산중단 등록 하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
		Return
	End If
End If

ib_change = False
li_row	= dw_1.GetRow()

If li_row > 0 Then
	ls_areacode			= Trim(dw_1.GetItemString(li_row, "AreaCode"))
	ls_divisioncode	= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
	ls_workcenter		= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
	ls_linecode			= Trim(dw_1.GetItemString(li_row, "LineCode"))
	ls_itemcode			= Trim(dw_1.GetItemString(li_row, "ItemCode"))
	
	SQLPIS.AutoCommit = False
	
	Update	tmstkb
	Set		PrdStopGubun	= 'Y',
				LastEmp			= 'Y',
				LastDate			= GetDate()
	Where		AreaCode			= :ls_areacode				And
				DivisionCode	= :ls_divisioncode		And
				WorkCenter		= :ls_workcenter			And
				LineCode			= :ls_linecode				And
				ItemCode			= :ls_itemcode
	Using SQLPIS;

	If SQLPIS.sqlcode = 0 Then
		//
	Else
		RollBack Using SQLPIS;
		SQLPIS.AutoCommit = True
		uo_status.st_message.text =  "간판마스터에 제품의 생산중단을 등록하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("일일생산계획", "간판마스터에 제품의 생산중단을 등록하는 중에 오류가 발생하였습니다.", StopSign!)
		Return
	End If
	
	Update	tmstkbhis
	Set		PrdStopGubun	= 'Y',
				LastEmp			= 'Y',
				LastDate			= GetDate()
	Where		AreaCode			= :ls_areacode				And
				DivisionCode	= :ls_divisioncode		And
				WorkCenter		= :ls_workcenter			And
				LineCode			= :ls_linecode				And
				ItemCode			= :ls_itemcode				And
				ApplyTo			= '9999.12.31'
	Using SQLPIS;

	If SQLPIS.sqlcode = 0 Then
		Commit Using SQLPIS;
		SQLPIS.AutoCommit = True
		uo_status.st_message.text =  "선택하신 제품의 생산중단을 등록하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("일일생산계획", "선택하신 제품의 생산중단을 등록하였습니다.", Information!)
		iw_this.TriggerEvent("ue_retrieve")
	Else
		RollBack Using SQLPIS;
		SQLPIS.AutoCommit = True
		uo_status.st_message.text =  "간판마스터 이력에 제품의 생산중단을 등록하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("일일생산계획", "간판마스터 이력에 제품의 생산중단을 등록하는 중에 오류가 발생하였습니다.", StopSign!)
		Return
	End If
End If
end event

type gb_1 from groupbox within w_pisp060u
integer x = 14
integer width = 759
integer height = 176
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisp060u
integer x = 777
integer width = 1833
integer height = 176
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisp060u
integer x = 14
integer y = 156
integer width = 1637
integer height = 176
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_pisp060u
integer x = 1655
integer y = 156
integer width = 955
integer height = 176
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

