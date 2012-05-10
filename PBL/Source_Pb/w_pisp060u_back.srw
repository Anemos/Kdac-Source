$PBExportHeader$w_pisp060u_back.srw
$PBExportComments$일일생산계획
forward
global type w_pisp060u_back from w_ipis_sheet01
end type
type gb_4 from groupbox within w_pisp060u_back
end type
type gb_2 from groupbox within w_pisp060u_back
end type
type gb_1 from groupbox within w_pisp060u_back
end type
type gb_3 from groupbox within w_pisp060u_back
end type
type dw_1 from u_vi_std_datawindow within w_pisp060u_back
end type
type uo_area from u_pisc_select_area within w_pisp060u_back
end type
type uo_division from u_pisc_select_division within w_pisp060u_back
end type
type cb_4 from commandbutton within w_pisp060u_back
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp060u_back
end type
type uo_line from u_pisc_select_line within w_pisp060u_back
end type
type cb_1 from commandbutton within w_pisp060u_back
end type
type cb_2 from commandbutton within w_pisp060u_back
end type
type dw_info from datawindow within w_pisp060u_back
end type
type uo_item from u_pisc_select_item_kb_line within w_pisp060u_back
end type
type cb_3 from commandbutton within w_pisp060u_back
end type
type uo_date from u_pisc_date_tomorrow within w_pisp060u_back
end type
type st_v_bar from uo_xc_splitbar within w_pisp060u_back
end type
type dw_qty from datawindow within w_pisp060u_back
end type
type gb_5 from groupbox within w_pisp060u_back
end type
end forward

global type w_pisp060u_back from w_ipis_sheet01
integer width = 4677
string title = ""
gb_4 gb_4
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
dw_1 dw_1
uo_area uo_area
uo_division uo_division
cb_4 cb_4
uo_workcenter uo_workcenter
uo_line uo_line
cb_1 cb_1
cb_2 cb_2
dw_info dw_info
uo_item uo_item
cb_3 cb_3
uo_date uo_date
st_v_bar st_v_bar
dw_qty dw_qty
gb_5 gb_5
end type
global w_pisp060u_back w_pisp060u_back

type variables
Boolean	ib_open, ib_dummy, ib_change, ib_change_dummy
Long		il_row_second, il_scrollpos_ver
end variables

forward prototypes
public function boolean wf_save_dummy ()
public subroutine wf_set_invqty ()
public function boolean wf_save ()
public subroutine wf_set_invqty_all ()
end prototypes

public function boolean wf_save_dummy ();int		i, j, li_lastday, li_count, &
			li_kdqty, li_asqty, li_etcqty01, li_etcqty02, li_etcqty03
String	ls_changeflag, ls_changeflag_date, ls_date, ls_plandate, &
			ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

li_lastday = f_pisc_get_date_lastday_of_month(Integer(Mid(uo_date.is_uo_date, 6, 2)), Integer(Left(uo_date.is_uo_date, 4)))

SQLPIS.AutoCommit = False

For i = 1 To dw_info.RowCount()
	
	ls_changeflag	= Trim(dw_info.GetItemString(i, "ChangeFlag"))
	
	If ls_changeflag = "Y" Then
		For j = 1 To li_lastday
			ls_date	= Right("0" + String(j), 2)
			ls_changeflag_date	= "N"
			ls_changeflag_date	= Trim(dw_info.GetItemString(i, "ChangeFlag" + ls_date))
			If ls_changeflag_date = "Y" Then
				
				ls_plandate			= Left(uo_date.is_uo_date, 7) + "." + ls_date
				ls_areacode			= Trim(dw_info.GetItemString(i, "AreaCode"))
				ls_divisioncode	= Trim(dw_info.GetItemString(i, "DivisionCode"))
//				ls_workcenter		= Trim(dw_info.GetItemString(i, "WorkCenter"))
//				ls_linecode			= Trim(dw_info.GetItemString(i, "LineCode"))
				ls_itemcode			= Trim(dw_info.GetItemString(i, "ItemCode"))
				li_kdqty				= dw_info.GetItemNumber(i, "KDQty" + ls_date)
				li_asqty				= dw_info.GetItemNumber(i, "ASQty" + ls_date)
				li_etcqty01			= dw_info.GetItemNumber(i, "EtcQty01" + ls_date)
				li_etcqty02			= dw_info.GetItemNumber(i, "EtcQty02" + ls_date)
				li_etcqty03			= dw_info.GetItemNumber(i, "EtcQty03" + ls_date)
	
				li_count	= 0
				
				Select	Count(PlanDate)
				Into		:li_count
				From		tplanddrs
				Where		PlanDate			= :ls_plandate				And
							AreaCode			= :ls_areacode				And
							DivisionCode	= :ls_divisioncode		And
							ItemCode			= :ls_itemcode
				Using SQLPIS;

				If li_count > 0 Then
					Update	tplanddrs
						Set	KDQty				= :li_kdqty,
								ASQty				= :li_asqty,
								EtcQty01			= :li_etcqty01,
								EtcQty02			= :li_etcqty02,
								EtcQty03			= :li_etcqty03,
								LastEmp			= :g_s_empno,
								LastDate			= GetDate()
					Where		PlanDate			= :ls_plandate				And
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
					Values					(:ls_plandate,
												:ls_areacode,			:ls_divisioncode,
												:ls_itemcode,
												0,							0,
												0,							0,
												0,							0,
												0,							0,
												0,							0,
												:li_kdqty,				:li_asqty,
												:li_etcqty01,			:li_etcqty02,
												:li_etcqty03,
												:g_s_empno,				GetDate())
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
	Return False
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	Return True
End If
end function

public subroutine wf_set_invqty ();Long		i, j, ll_invqty, ll_computeqty, ll_row
String	ls_itemcode, ls_itemcode_info, ls_invcompute

ll_row	= dw_info.GetRow()

If ll_row > 0 Then
	//
Else
	Return
End If

ls_itemcode_info	= Trim(dw_info.GetItemString(ll_row, "ItemCode"))

If dw_1.RowCount() > 0 Then
	For i = 1 To dw_1.RowCount()
		ls_itemcode	= Trim(dw_1.GetItemString(i, "ItemCode"))
		If ls_itemcode = ls_itemcode_info Then
			ls_invcompute	= Trim(dw_info.GetItemString(ll_row, "InvCompute"))
			For j = 1 To 31
				ll_invqty	= 0
				ll_invqty	= dw_info.GetItemNumber(ll_row, "forecastinv" + Right("00" + String(j), 2))
				dw_1.SetItem(i, "InvQty" + Right("00" + String(j), 2), ll_invqty)
				CHOOSE CASE ls_invcompute
					CASE "1"
						ll_computeqty	= dw_info.GetItemNumber(ll_row, "SRQty" + Right("00" + String(j), 2))
					CASE "2"
						ll_computeqty	= dw_info.GetItemNumber(ll_row, "DDRSQty" + Right("00" + String(j), 2))
					CASE "3"
						ll_computeqty	= dw_info.GetItemNumber(ll_row, "SRQty" + Right("00" + String(j), 2))
						If ll_computeqty > 0 Then
							ll_computeqty	= ll_computeqty
						Else
							ll_computeqty	= dw_info.GetItemNumber(ll_row, "DDRSQty" + Right("00" + String(j), 2))
						End If
					CASE "4"
						ll_computeqty	= dw_info.GetItemNumber(ll_row, "DDRSQty" + Right("00" + String(j), 2)) + dw_info.GetItemNumber(ll_row, "DummyQty" + Right("00" + String(j), 2))
				END CHOOSE
				dw_1.SetItem(i, "EtcQty" + Right("00" + String(j), 2), ll_computeqty)
			Next
		End If
	Next
End If
dw_1.AcceptText()
end subroutine

public function boolean wf_save ();int		i, j, li_lastday, li_count, li_rackqty, li_changeqty, &
			li_normalkbcount, li_normalkbqty, li_tempkbcount, li_tempkbqty
String	ls_changeflag, ls_changeflag_date, ls_tomorrow, ls_lastday, ls_date, &
			ls_planmonth, ls_plandate, &
			ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

dw_1.AcceptText()

ls_planmonth	= Left(uo_date.is_uo_date, 7)
ls_tomorrow		= String(RelativeDate(Date(f_pisc_get_date_nowtime()), 1), "YYYY.MM.DD")
li_lastday	= f_pisc_get_date_lastday_of_month(Integer(Mid(ls_planmonth, 6, 2)), Integer(Left(ls_planmonth, 4)))
ls_lastday	= ls_planmonth + "." + Right("00" + String(li_lastday), 2)

SQLPIS.AutoCommit = False

For i = 1 To dw_1.RowCount()
	ls_changeflag	= Trim(dw_1.GetItemString(i, "ChangeFlag"))

	If ls_changeflag = "Y" Then
		ls_plandate			= Left(uo_date.is_uo_date, 7) + "." + ls_date
		ls_areacode			= Trim(dw_1.GetItemString(i, "AreaCode"))
		ls_divisioncode	= Trim(dw_1.GetItemString(i, "DivisionCode"))
		ls_workcenter		= Trim(dw_1.GetItemString(i, "WorkCenter"))
		ls_linecode			= Trim(dw_1.GetItemString(i, "LineCode"))
		ls_itemcode			= Trim(dw_1.GetItemString(i, "ItemCode"))
		li_rackqty			= dw_1.GetItemNumber(i, "RackQty")

//		-- 일단 조립지시가 된 일자까지는 일일생산계획을 건딜면....안되지..
//		-- 근데, 라인별로 관리해야 한다.
//		-- 왜냐하면, 평준화순서계획이 라인단위로 수립되므로
//		-- 라인에 해당하는 제품의 일일생산계획을 바꿔도 그 라인에 제품 하나라도 조립 지시가 되면
//		-- 평준화 순서계획은 바꿀수 없다.
		li_count	= 0
		SetNull(ls_plandate)
		Select	Max(PlanDate), Count(PlanDate)
		Into		:ls_plandate, :li_count
		From		tplanrelease
		Where		PlanDate			Like :ls_planmonth + '.__'		And
					AreaCode			= :ls_areacode				And
					DivisionCode	= :ls_divisioncode		And
					WorkCenter		= :ls_workcenter			And
					LineCode			= :ls_linecode				And
					ReleaseGubun	In ('Y', 'T', 'N', 'U')
		Using SQLPIS;

		If li_count > 0 Then
			ls_plandate = String(RelativeDate(Date(ls_plandate), 1), "YYYY.MM.DD")
			If ls_plandate > ls_lastday Then
				GoTo No_Date
			Else
				If ls_plandate	> ls_tomorrow Then
					ls_plandate	= ls_plandate
				Else
					If ls_tomorrow > ls_lastday Then
						GoTo No_Date
					Else
						ls_plandate	= ls_tomorrow
					End If
				End If
			End If
		Else
			If (ls_planmonth + '.01') > ls_tomorrow Then
				ls_plandate	= ls_planmonth + '.01'
			Else
				ls_plandate	= ls_tomorrow
			End If
		End If

		For j = Integer(Right(ls_plandate, 2)) To li_lastday
			ls_date		= Right("0" + String(j), 2)
			ls_plandate	= ls_planmonth + "." + ls_date
			ls_changeflag_date	= "N"
			ls_changeflag_date	= Trim(dw_1.GetItemString(i, "ChangeFlag" + ls_date))
			If ls_changeflag_date = "Y" Then
				li_changeqty		= dw_1.GetItemNumber(i, "ChangeQty" + ls_date)

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
				Where		PlanDate			= :ls_plandate				And
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
								LastEmp			= :g_s_empno,
								LastDate			= GetDate()
					 Where	PlanDate			= :ls_plandate
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
					Values					(:ls_plandate,
												:ls_areacode,			:ls_divisioncode,
												:ls_workcenter,		:ls_linecode,
												:ls_itemcode,
												0,							:li_changeqty,
												:li_normalkbcount,	:li_normalkbqty,
												:li_tempkbcount,		:li_tempkbqty,
												:g_s_empno,				GetDate())
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
	No_Date:
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

public subroutine wf_set_invqty_all ();Long		k, i, j, ll_invqty, ll_computeqty
String	ls_itemcode, ls_itemcode_info, ls_invcompute

If dw_info.RowCount() > 0 Then
	For k = 1 To dw_info.RowCount()
		ls_itemcode_info	= Trim(dw_info.GetItemString(k, "ItemCode"))
		ls_invcompute	= Trim(dw_info.GetItemString(k, "InvCompute"))
		If dw_1.RowCount() > 0 Then
			For i = 1 To dw_1.RowCount()
				ls_itemcode	= Trim(dw_1.GetItemString(i, "ItemCode"))
				If ls_itemcode = ls_itemcode_info Then
					For j = 1 To 31
						ll_invqty	= 0
						ll_invqty	= dw_info.GetItemNumber(k, "forecastinv" + Right("00" + String(j), 2))
						dw_1.SetItem(i, "InvQty" + Right("00" + String(j), 2), ll_invqty)
						CHOOSE CASE ls_invcompute
							CASE "1"
								ll_computeqty	= dw_info.GetItemNumber(k, "SRQty" + Right("00" + String(j), 2))
							CASE "2"
								ll_computeqty	= dw_info.GetItemNumber(k, "DDRSQty" + Right("00" + String(j), 2))
							CASE "3"
								ll_computeqty	= dw_info.GetItemNumber(k, "SRQty" + Right("00" + String(j), 2))
								If ll_computeqty > 0 Then
									ll_computeqty	= ll_computeqty
								Else
									ll_computeqty	= dw_info.GetItemNumber(k, "DDRSQty" + Right("00" + String(j), 2))
								End If
							CASE "4"
								ll_computeqty	= dw_info.GetItemNumber(k, "DDRSQty" + Right("00" + String(j), 2)) + dw_info.GetItemNumber(k, "DummyQty" + Right("00" + String(j), 2))
						END CHOOSE
						dw_1.SetItem(i, "EtcQty" + Right("00" + String(j), 2), ll_computeqty)
					Next
				End If
			Next
		End If
	Next
End If

//dw_1.AcceptText()
end subroutine

on w_pisp060u_back.create
int iCurrent
call super::create
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cb_4=create cb_4
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_info=create dw_info
this.uo_item=create uo_item
this.cb_3=create cb_3
this.uo_date=create uo_date
this.st_v_bar=create st_v_bar
this.dw_qty=create dw_qty
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.uo_area
this.Control[iCurrent+7]=this.uo_division
this.Control[iCurrent+8]=this.cb_4
this.Control[iCurrent+9]=this.uo_workcenter
this.Control[iCurrent+10]=this.uo_line
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.dw_info
this.Control[iCurrent+14]=this.uo_item
this.Control[iCurrent+15]=this.cb_3
this.Control[iCurrent+16]=this.uo_date
this.Control[iCurrent+17]=this.st_v_bar
this.Control[iCurrent+18]=this.dw_qty
this.Control[iCurrent+19]=this.gb_5
end on

on w_pisp060u_back.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cb_4)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_info)
destroy(this.uo_item)
destroy(this.cb_3)
destroy(this.uo_date)
destroy(this.st_v_bar)
destroy(this.dw_qty)
destroy(this.gb_5)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, LEFT)
of_resize_register(st_v_bar, SPLIT)
of_resize_register(dw_qty, RIGHT)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_qty.SetTransObject(SQLPIS)
dw_info.SetTransObject(SQLPIS)

dw_1.ShareData(dw_qty)

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

ib_open = True
end event

event ue_retrieve;int		li_return
String	ls_today

If ib_change Then
	li_return =  MessageBox("일일생산계획", "변경된 일일생산계획 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?" + &
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

iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(uo_date.is_uo_date, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
					uo_workcenter.is_uo_workcenter, uo_line.is_uo_linecode, uo_item.is_uo_itemcode) > 0 Then
	uo_status.st_message.text =  "S/R 및 DDRS 현황 정보 조회중입니다..." //+ f_message("변경된 데이타가 없습니다.")
	ls_today	= String(f_pisc_get_date_nowtime(), "YYYY.MM.DD")
	dw_info.Retrieve(ls_today, &
					Left(uo_date.is_uo_date, 8), &
					uo_date.is_uo_date, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
					uo_workcenter.is_uo_workcenter, uo_line.is_uo_linecode, uo_item.is_uo_itemcode)
	uo_status.st_message.text =  "일일생산계획 정보" //+ f_message("변경된 데이타가 없습니다.")
	wf_set_invqty_all()
Else
	uo_status.st_message.text =  "일일생산계획이 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("일일생산계획", "일일생산계획이 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_qty.ReSet()
dw_info.ReSet()

ib_change = False
ib_change_dummy = False
end event

event ue_save;call super::ue_save;dw_1.AcceptText()

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

If wf_save() Then
	ib_change	= False
	ib_change_dummy	= False
	uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
	MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하였습니다.", Information!)
	TriggerEvent("ue_retrieve")
Else
	uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "변경된 일일생산계획 정보를 저장하는 도중에 오류가 발생하였습니다.", StopSign!)
End If
end event

event closequery;call super::closequery;int	li_return

If ib_change Then
	li_return =  MessageBox("일일생산계획", "변경된 일일생산계획 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 종료하시겠습니까?" + &
							"~r~n~r~n(주의)" + &
							"~r~n~r~n1. 조립지시가 확정된 이후 일자의 일일생산계획만 저장됩니다.", Question!, YesNoCancel!, 3)

	If li_return = 1 Then		
		If wf_save() Then
			Return 0
//			uo_status.st_message.text =  "Work Calendar 정보를 변경하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("일일생산계획", "변경된 일일생산계획 정보를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
			Return 1
		End If
	ElseIf li_return = 2 Then
		Return 0
	ElseIf li_return = 3 Then
		Return 1
	End If
End If
end event

event ue_delete;int		li_return, li_row, li_count
String	ls_lastday, ls_tomorrow, ls_plandate, ls_planmonth, &
			ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

li_row	= dw_1.GetRow()

If li_row > 0 Then
	//
Else	
	uo_status.st_message.text =  "일일생산계획을 삭제하려는 제품을 선택하여 주십시요." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "일일생산계획을 삭제하려는 제품을 선택하여 주십시요.", StopSign!)
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
ls_tomorrow		= String(RelativeDate(Date(f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())), 1), "YYYY.MM.DD")
ls_lastday	= ls_planmonth + "." + Right("00" + String(f_pisc_get_date_lastday_of_month(Integer(Mid(ls_planmonth, 6, 2)), Integer(Left(ls_planmonth, 4)))), 2)

ls_planmonth		= Left(uo_date.is_uo_date, 7)
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
Into		:ls_plandate, :li_count
From		tplanrelease
Where		PlanDate			Like :ls_planmonth + '.__'		And
			AreaCode			= :ls_areacode				And
			DivisionCode	= :ls_divisioncode		And
			WorkCenter		= :ls_workcenter			And
			LineCode			= :ls_linecode				And
			ReleaseGubun	In ('Y', 'T', 'N', 'U')
Using SQLPIS;

If li_count > 0 Then
	ls_plandate = String(RelativeDate(Date(ls_plandate), 1), "YYYY.MM.DD")
	If ls_plandate > ls_lastday Then
		uo_status.st_message.text =  "선택하신 제품의 라인은 이미 금월의 마지막일자까지 조립지시가 수행되었습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("일일생산계획", "선택하신 제품의 라인은 이미 금월의 마지막일자까지 조립지시가 수행되었습니다.", StopSign!)
		Return
	Else
		If ls_plandate	> ls_tomorrow Then
			ls_plandate	= ls_plandate
		Else
			If ls_tomorrow > ls_lastday Then
				uo_status.st_message.text =  "월의 마지막 날은 해당월의 일일생산계획을 삭제할 수 없습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
				MessageBox("일일생산계획", "월의 마지막 날은 해당월의 일일생산계획을 삭제할 수 없습니다.", StopSign!)
				Return
			Else
				ls_plandate	= ls_tomorrow
			End If
		End If
	End If
Else
	If (ls_planmonth + '.01') > ls_tomorrow Then
		ls_plandate	= ls_planmonth + '.01'
	Else
		ls_plandate	= ls_tomorrow
	End If
End If


SQLPIS.AutoCommit = False

Update	tplanday
Set		ChangeQty		= 0,
			NormalKBCount	= 0,
			NormalKBQty		= 0,
			TempKBCount		= 0,
			TempKBQty		= 0,
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
Where		PlanDate			Like :ls_planmonth + '.__'		And
			PlanDate			>= :ls_plandate			And
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
	ib_change_dummy	= False
	uo_status.st_message.text =  "일일생산계획 정보를 삭제하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "일일생산계획 정보를 삭제하였습니다.", Information!)
	TriggerEvent("ue_retrieve")
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "일일생산계획 정보를 삭제하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "일일생산계획 정보를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If
end event

event ue_insert;call super::ue_insert;int		li_return

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

istr_parms.string_arg[1] = is_size
istr_parms.string_arg[2] = Left(uo_date.is_uo_date, 7)
	
OpenWithParm(w_pisp061u, istr_parms)

If Upper(Message.StringParm) = "CHANGE" Then
	TriggerEvent("ue_retrieve")
End If
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp060u_back
end type

type gb_4 from groupbox within w_pisp060u_back
integer x = 14
integer width = 4608
integer height = 204
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

type gb_2 from groupbox within w_pisp060u_back
integer x = 814
integer y = 184
integer width = 1189
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

type gb_1 from groupbox within w_pisp060u_back
integer x = 14
integer y = 184
integer width = 795
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

type gb_3 from groupbox within w_pisp060u_back
integer x = 2007
integer y = 184
integer width = 1330
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

type dw_1 from u_vi_std_datawindow within w_pisp060u_back
integer x = 14
integer y = 368
integer width = 2990
integer height = 772
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_pisp060u_01_data"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event clicked;//
//
Int		ll_find
String	ls_itemcode

If Row > 0 Then
//	this.SelectRow(0,FALSE)
//	this.SelectRow(currentrow,TRUE)
	
	ls_itemcode	= Trim(this.GetItemString(Row, "ItemCode"))
	
	ll_find = dw_info.Find("ItemCode ='"+ls_itemcode+"'", 1, dw_info.RowCount())
	If ll_find > 0 Then
		dw_info.ScrolltoRow(ll_find)
		dw_info.Post Event RowFocusChanged(ll_find)
		dw_info.SetRow(ll_find)
	End If
	dw_qty.Post Event RowFocusChanged(Row)
	dw_qty.SetRow(Row)
End If
end event

event rowfocuschanged;//
Long		ll_find
String	ls_itemcode_old, ls_itemcode_new

If CurrentRow > 0 Then
	this.SelectRow(0,FALSE)
	this.SelectRow(currentrow,TRUE)

	ls_itemcode_old	= Trim(dw_1.GetItemString(il_row_second, "ItemCode"))
	ls_itemcode_new	= Trim(dw_1.GetItemString(CurrentRow, "ItemCode"))
	
	If il_row_second <> CurrentRow And ls_itemcode_new <> ls_itemcode_old Then
		il_row_second	= CurrentRow	
		ll_find = dw_info.Find("ItemCode ='"+ls_itemcode_new+"'", 1, dw_info.RowCount())
		If ll_find > 0 Then
			dw_info.ScrolltoRow(ll_find)
			dw_info.Post Event RowFocusChanged(ll_find)
			dw_info.SetRow(ll_find)
			dw_info.Object.DataWindow.HorizontalScrollPosition	= il_scrollpos_ver
		End If
		dw_qty.Post Event RowFocusChanged(CurrentRow)
		dw_qty.SetRow(CurrentRow)
	End If
End If
end event

event ue_lbuttonup;//
end event

event rbuttondown;//
end event

event ue_key;//
end event

type uo_area from u_pisc_select_area within w_pisp060u_back
integer x = 873
integer y = 248
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
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
	
End If

end event

type uo_division from u_pisc_select_division within w_pisp060u_back
integer x = 1390
integer y = 248
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

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
	
End If

end event

type cb_4 from commandbutton within w_pisp060u_back
integer x = 3346
integer y = 68
integer width = 805
integer height = 96
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

type uo_workcenter from u_pisc_select_workcenter within w_pisp060u_back
integer x = 2034
integer y = 248
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

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
	
End If

end event

type uo_line from u_pisc_select_line within w_pisp060u_back
integer x = 2720
integer y = 248
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	
End If

end event

type cb_1 from commandbutton within w_pisp060u_back
integer x = 229
integer y = 68
integer width = 805
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "S/R 및 DDRS 현황(&V)"
end type

event clicked;If dw_info.Visible Then
	dw_info.Visible = False
Else
	If ib_dummy = False Then
		ib_dummy = True
		dw_info.Resize(iw_this.Width - 50, 800)
		dw_info.Move(dw_1.X, dw_1.Y + 900)
	End If
	dw_info.Visible = True
End If
end event

type cb_2 from commandbutton within w_pisp060u_back
integer x = 1262
integer y = 68
integer width = 805
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생산계획 저장(&S)"
end type

event clicked;iw_this.TriggerEvent("ue_save")
end event

type dw_info from datawindow within w_pisp060u_back
integer x = 59
integer y = 1232
integer width = 1243
integer height = 580
boolean bringtotop = true
boolean titlebar = true
string title = "S/R 및 DDRS 현황"
string dataobject = "d_pisp060u_02"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

event rowfocuschanged;//If CurrentRow > 0 Then
//	this.SelectRow(0,FALSE)
//	this.SelectRow(currentrow,TRUE)
//End If
end event

event editchanged;String	ls_date

AcceptText()
If row > 0 Then
	ls_date = Right(string(dwo.name), 2)

	ib_change_dummy = True
	dw_info.SetItem(row, "ChangeFlag", 'Y')
	dw_info.SetItem(row, "ChangeFlag" + ls_date, 'Y')

	wf_set_invqty()
End If
end event

event itemchanged;Int		li_count, i, li_invqty
String	ls_areacode, ls_divisioncode, ls_itemcode, ls_invcompute

AcceptText()
If row > 0 Then
	If Upper(string(dwo.name)) <> "INVCOMPUTE" Then
		Return
	End If
	
	ls_areacode			= Trim(dw_info.GetItemString(row, "AreaCode"))
	ls_divisioncode	= Trim(dw_info.GetItemString(row, "DivisionCode"))
	ls_itemcode			= Trim(dw_info.GetItemString(row, "ItemCode"))
	
	ls_invcompute		= Trim(dw_info.GetItemString(row, "InvCompute"))
		
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
					LastEmp			= :g_s_empno,
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
								:g_s_empno,				GetDate())
		Using SQLPIS;
	End If

	If SQLPIS.sqlcode = 0 Then
		Commit Using SQLPIS;
		Return
	Else
		RollBack Using SQLPIS;
		Return
	End If
	
	wf_set_invqty()
End If

end event

event itemerror;Return 1
end event

type uo_item from u_pisc_select_item_kb_line within w_pisp060u_back
integer x = 3392
integer y = 248
boolean bringtotop = true
end type

on uo_item.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type cb_3 from commandbutton within w_pisp060u_back
integer x = 2313
integer y = 68
integer width = 805
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "소요량 저장(&F)"
end type

event clicked;Long		ll_row
String	ls_today

dw_info.AcceptText()

If ib_change_dummy = False Then
	uo_status.st_message.text =  "변경된 소요량 정보가 없습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("일일생산계획","변경된 소요량 정보가 없습니다.")
	Return
End If

If MessageBox("일일생산계획","변경하신 소요량 정보를 저장하시겠습니까 ?", Question!, YesNo!, 1) = 2 Then
	Return
Else
	uo_status.st_message.text =  "변경된 소요량 정보 저장 중..." //+ f_message("Work Carlendar 정보 등록 중...")
End If

If wf_save_dummy() Then
	ib_change_dummy	= False
	uo_status.st_message.text =  "변경된 소요량 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
	MessageBox("일일생산계획", "변경된 소요량 정보를 저장하였습니다.", Information!)
	ll_row	= dw_info.GetRow()
	ls_today	= String(f_pisc_get_date_nowtime(), "YYYY.MM.DD")
	dw_info.Retrieve(ls_today, &
					Left(uo_date.is_uo_date, 8), &
					uo_date.is_uo_date, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
					uo_workcenter.is_uo_workcenter, uo_line.is_uo_linecode, uo_item.is_uo_itemcode)
	If ll_row > 0 Then
		dw_info.Post Event RowFocusChanged(ll_row)
		dw_info.SetRow(ll_row)
		dw_info.Object.DataWindow.HorizontalScrollPosition	= il_scrollpos_ver
	End If
	uo_status.st_message.text =  "일일생산계획 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "변경된 소요량 정보를 저장하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("일일생산계획", "변경된 소요량 정보를 저장하는 도중에 오류가 발생하였습니다.", StopSign!)
End If
end event

type uo_date from u_pisc_date_tomorrow within w_pisp060u_back
integer x = 64
integer y = 248
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

on uo_date.destroy
call u_pisc_date_tomorrow::destroy
end on

type st_v_bar from uo_xc_splitbar within w_pisp060u_back
integer x = 3031
integer y = 448
integer width = 14
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,LEFT)
of_register(dw_qty,RIGHT)
end event

type dw_qty from datawindow within w_pisp060u_back
event ue_editchanged ( long fl_row,  string fs_column,  long fl_data )
integer x = 3086
integer y = 380
integer width = 713
integer height = 724
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisp060u_01_qty"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_editchanged;String	ls_date, ls_planmonth, ls_tomorrow, ls_itemcode, ls_itemcode_2
Long		ll_find, ll_oldqty, ll_changeqty, i, li_invqty

AcceptText()

If fl_row > 0 Then
	ls_date = Right(fs_column, 2)

	ls_planmonth	= Left(uo_date.is_uo_date, 7)
//	ls_tomorrow		= String(RelativeDate(Date(f_pisc_get_date_nowtime()), 1), "YYYY.MM.DD")
	ls_tomorrow		= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())
	
	// 이전날 계획은 변경이 불가능하다.
	If ls_tomorrow <= (ls_planmonth + "." + ls_date) Then
		ib_change = True
		dw_1.SetItem(fl_row, "ChangeFlag", 'Y')
		dw_1.SetItem(fl_row, "ChangeFlag" + ls_date, 'Y')
	Else
		Return
	End If

	// 여기부터 S/R 및 DDRS 현황의 계획도 변경하자..
	ll_oldqty	= dw_1.GetItemNumber(fl_row, "DummyQty" + ls_date)
	dw_1.SetItem(fl_row, "DummyQty" + ls_date, fl_data)

	ls_itemcode	= Trim(dw_1.GetItemString(fl_row, "ItemCode"))
	ll_find = dw_info.Find("ItemCode ='"+ls_itemcode+"'", 1, dw_info.RowCount())
	If ll_find > 0 Then
		ll_changeqty	= dw_info.GetItemNumber(ll_find, "ChangeQty" + ls_date)
		dw_info.SetItem(ll_find, "ChangeQty" + ls_date, ll_changeqty + (fl_data - ll_oldqty))
		dw_info.AcceptText()
		wf_set_invqty()
	End If
End If
end event

event rowfocuschanged;//If CurrentRow > 0 Then
//	this.SelectRow(0,FALSE)
//	this.SelectRow(currentrow,TRUE)
//End If
end event

event editchanged;String	ls_date, ls_planmonth, ls_tomorrow

AcceptText()

If row > 0 Then
	Trigger Event ue_editchanged(row, String(dwo.name), Long(Data))
End If
end event

event itemerror;Return 1
end event

event scrollvertical;//dw_1.Object.DataWindow.VerticalScrollPosition	= scrollpos
end event

event itemfocuschanged;dw_1.Post Event RowFocusChanged(Row)
dw_1.SetRow(Row)
end event

event scrollhorizontal;dw_info.Object.DataWindow.HorizontalScrollPosition	= scrollpos
il_scrollpos_ver = scrollpos
end event

type gb_5 from groupbox within w_pisp060u_back
integer x = 3342
integer y = 184
integer width = 1280
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

