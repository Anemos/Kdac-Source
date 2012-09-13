$PBExportHeader$w_pisp080u.srw
$PBExportComments$평준화 계획
forward
global type w_pisp080u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp080u
end type
type uo_area from u_pisc_select_area within w_pisp080u
end type
type uo_division from u_pisc_select_division within w_pisp080u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp080u
end type
type uo_line from u_pisc_select_line within w_pisp080u
end type
type cb_2 from commandbutton within w_pisp080u
end type
type uo_date from u_pisc_date_tomorrow within w_pisp080u
end type
type cb_1 from commandbutton within w_pisp080u
end type
type st_bar from statictext within w_pisp080u
end type
type st_left from statictext within w_pisp080u
end type
type st_right from statictext within w_pisp080u
end type
type dw_orderchange_save from datawindow within w_pisp080u
end type
type dw_print from datawindow within w_pisp080u
end type
type gb_1 from groupbox within w_pisp080u
end type
type gb_2 from groupbox within w_pisp080u
end type
type gb_3 from groupbox within w_pisp080u
end type
type gb_5 from groupbox within w_pisp080u
end type
end forward

global type w_pisp080u from w_ipis_sheet01
integer width = 4677
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
cb_2 cb_2
uo_date uo_date
cb_1 cb_1
st_bar st_bar
st_left st_left
st_right st_right
dw_orderchange_save dw_orderchange_save
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_5 gb_5
end type
global w_pisp080u w_pisp080u

type variables
Boolean	ib_open, ib_drag

// il_drag_row	=> Drag 하기위해 처음에 선택한 Row
// il_new_row	=> Drag 하여 Drop 시킨 곳의 Row
Long		il_drag_row, il_new_row
end variables

forward prototypes
public function integer wf_orderchange_groupcount (long fl_row)
public subroutine wf_orderchange_bar_visible (long fl_row)
public subroutine wf_orderchange_save ()
end prototypes

public function integer wf_orderchange_groupcount (long fl_row);// 조회된 데이터윈도우는 Linecode 별로 grouping 한 상태이다.
// 따라서, 현재 선택한 Row가 몇번째로 Grouping 된 라인인지를 가져와야 한다.
// 왜냐면, Drag 할 때 이동 라인이 Row단위로 이동되기 때문에
// 데이터윈도우의 Summary 갯수만큼 Y 축의 위치를 바로잡아야 한다...씨불

Long		i, ll_summary, ll_first_row
String	ls_workcenter, ls_linecode, ls_workcenter_old, ls_linecode_old

ll_first_row	= Long(dw_1.Object.DataWindow.FirstRowOnPage)

If fl_row > 0 Then
	If fl_row = ll_first_row Then
		ll_summary	= 0
	Else
		ls_workcenter_old	= Trim(dw_1.GetItemString(ll_first_row, "WorkCenter"))
		ls_linecode_old	= Trim(dw_1.GetItemString(ll_first_row, "LineCode"))
		For i = ll_first_row + 1 To fl_row
			ls_workcenter	= Trim(dw_1.GetItemString(i, "WorkCenter"))
			ls_linecode		= Trim(dw_1.GetItemString(i, "LineCode"))
			If ls_workcenter	<> ls_workcenter_old	Or &
				ls_linecode		<> ls_linecode_old Then
				ll_summary	= ll_summary + 1
			End If
			ls_workcenter_old	= ls_workcenter
			ls_linecode_old	= ls_linecode
		Next
	End If
Else
	ll_summary	= 0
End If
	
Return	ll_summary
end function

public subroutine wf_orderchange_bar_visible (long fl_row);Long		ll_first_row, ll_header, ll_detail, ll_summary
String	ls_workcetner, ls_linecode

If Not st_left.Visible	Then
	ll_first_row	= Long(dw_1.Object.DataWindow.FirstRowOnPage)
	ll_header		= Long(dw_1.Describe("DataWindow.Header.Height"))
	ll_detail		= Long(dw_1.Describe("DataWindow.Detail.Height"))
	
	ll_summary		= ll_detail * wf_orderchange_groupcount(fl_row)
	
	st_bar.Move(dw_1.X, dw_1.Y + ll_header + ll_summary + (ll_detail * (fl_row - ll_first_row)))
	st_bar.Resize(dw_1.Width, 15)
		
	st_left.Move(dw_1.X - st_left.Width + 4, &
				 dw_1.Y + ll_header + ll_summary + (ll_detail * (fl_row - ll_first_row)) - ((st_left.Height - st_bar.Height) / 2))
	st_left.Resize(20, st_left.Height)
	
	st_right.Move(dw_1.X + dw_1.Width, &
				 dw_1.Y + ll_header + ll_summary + (ll_detail * (fl_row - ll_first_row)) - ((st_right.Height - st_bar.Height) / 2))
	st_right.Resize(20, st_right.Height)

	st_left.Visible	= True
	st_bar.Visible		= True
	st_right.Visible	= True
End If
end subroutine

public subroutine wf_orderchange_save ();Int		li_count, li_cycleorder, li_plankbcount, li_changeorder, li_changekbcount
Long		ll_find
Boolean	lb_error
String	ls_applydate_close, ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, &
			ls_errortext

If i_s_level <> '5' Then
	MessageBox("평준화 순서 계획", "권한이 없습니다.")
	Return
End If

// 일단 순서를 변경하려는 정보를 구하자..
ls_areacode			= Trim(dw_1.GetItemString(il_drag_row, "AreaCode"))
ls_divisioncode	= Trim(dw_1.GetItemString(il_drag_row, "DivisionCode"))
ls_workcenter		= Trim(dw_1.GetItemString(il_drag_row, "WorkCenter"))
ls_linecode			= Trim(dw_1.GetItemString(il_drag_row, "LineCode"))
li_cycleorder		= dw_1.GetItemNumber(il_drag_row, "CycleOrder")
// 계획이 없는데 지시한 경우에는 PlanKBCount 에서 가져오면 안된다.
//li_plankbcount		= dw_1.GetItemNumber(il_drag_row, "PlanKBCount")
//li_changekbcount	= dw_1.GetItemNumber(il_drag_row, "PlanKBCount")
li_plankbcount		= dw_1.GetItemNumber(il_drag_row, "KBCount")
li_changekbcount	= dw_1.GetItemNumber(il_drag_row, "KBCount")
// 옮기려는 위치의 지시순번을 구하자..
li_changeorder		= dw_1.GetItemNumber(il_new_row, "CycleOrder")

// 이전 일자의 지시는 변경할 수 없슴
ls_applydate_close	= f_pisc_get_date_applydate_close(ls_areacode, ls_divisioncode, f_pisc_get_date_nowtime())

If ls_applydate_close > uo_date.is_uo_date Then
	uo_status.st_message.text =  "기준일 이전 일자의 지시순서는 변경이 불가능합니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("당일 평준화계획", "기준일 이전 일자의 지시순서는 변경이 불가능합니다.", StopSign!)
	Return
End If

// 만약 다른 라인으로 옮기려는 경우는 그냥 파져나가야 한다.
If ls_areacode			= Trim(dw_1.GetItemString(il_new_row, "AreaCode"))	And &
	ls_divisioncode	= Trim(dw_1.GetItemString(il_new_row, "DivisionCode"))	And &
	ls_workcenter		= Trim(dw_1.GetItemString(il_new_row, "WorkCenter"))	And &
	ls_linecode			= Trim(dw_1.GetItemString(il_new_row, "LineCode"))	Then
Else
	uo_status.st_message.text =  "지시순서는 동일 라인에서만 변경이 가능합니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("당일 평준화계획", "지시순서는 동일 라인에서만 변경이 가능합니다.")
	Return
End If

// 지시를 앞으로 이동시킬 경우
// 만약 그 사이에 이미 조립완료된 간판이 하나라도 있으면
// 이동 불가능..
If li_cycleorder > li_changeorder Then
	li_count = 0
	Select	Count(PlanDate)
	Into		:li_count
	From		tplanrelease
	Where		PlanDate			= :uo_date.is_uo_date	And
				AreaCode			= :ls_areacode	And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_workcenter	And
				LineCode			= :ls_linecode	And
				(CycleOrder		Between :li_changeorder	And (:li_cycleorder - 1)) And
				PrdFlag			In ('E')
	Using SQLPIS;
	
	If li_count > 0 Then
		MessageBox("당일 평준화계획", "변경하려는 지시 순번 사이에 이미 조립완료된 간판이 존재합니다." + &
											"~r~n~r~n조립완료된 간판의 지시순서는 변경이 불가능 합니다.")
		Return
	End If
Else	// 무간판 뒤로도 이동 못하게..
	li_count = 0
	Select	Count(PlanDate)
	Into		:li_count
	From		tplanrelease
	Where		PlanDate			= :uo_date.is_uo_date	And
				AreaCode			= :ls_areacode	And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_workcenter	And
				LineCode			= :ls_linecode	And
				(CycleOrder		Between :li_cycleorder	And :li_changeorder) And
				ReleaseGubun	In ('U')
	Using SQLPIS;
	
	If li_count > 0 Then
		MessageBox("당일 평준화계획", "변경하려는 지시 순번 사이에 무간판 생산/입고 등록된 간판이 존재합니다." + &
											"~r~n~r~n무간판 생산/입고 등록된 간판의 지시순서는 변경이 불가능 합니다.")
		Return
	End If
End If

// 이미 조립완료된 간판이 있는 경우
// 조립완료 되지 않은 지시상태의 간판 매수만 이동할 수 있다.
li_count = 0
Select	Count(PlanDate)
Into		:li_count
From		tplanrelease
Where		PlanDate			= :uo_date.is_uo_date	And
			AreaCode			= :ls_areacode	And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter	And
			LineCode			= :ls_linecode	And
			CycleOrder		= :li_cycleorder	And
			PrdFlag			In ('E')
Using SQLPIS;

If li_count > 0 Then
	// 모든 간판이 조립완료 상태이므로, 지시 순서 변경은 불가능
	If li_count >= li_plankbcount	Then
		uo_status.st_message.text =  "선택하신 지시는 이미 모든 간판이 조립완료된 상태입니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("당일 평준화계획", "선택하신 지시는 이미 모든 간판이 조립완료된 상태입니다.", StopSign!)
		Return
	End If
	// 일부 간판만 조립완료된 경우 이다.
	// 이경우 지시상태의 간판만 이동이 가능하다.
	If	MessageBox("당일 평준화계획", "선택하신 지시는" + String(li_count) + " 매의 간판이 조립완료된 상태입니다." + &
										"~r~n~r~n최대 " + &
										String(li_plankbcount - li_count) + &
										" 매의 간판만 지시 순서를 변경할 수 있습니다." + &
										"~r~n~r~n" + &
										String(li_plankbcount - li_count) + &
										" 매의 간판의 지시순서를 변경하시 겠습니까?", &
										Question!, YesNo!, 2) = 1 Then
		li_changekbcount	= li_plankbcount - li_count
	Else
		li_changekbcount	= li_changekbcount
	End If
End If



dw_orderchange_save.ReSet()

SQLPIS.AutoCommit = False

If dw_orderchange_save.Retrieve(uo_date.is_uo_date, &
					ls_areacode,					ls_divisioncode, &
					ls_workcenter,					ls_linecode, &
					li_cycleorder,					li_plankbcount, &
					li_changeorder,				li_changekbcount, &
					g_s_empno) > 0 Then
	If Upper(dw_orderchange_save.GetItemString(1, "Error")) = "00" Then
		lb_error	= False
		ls_errortext	= Trim(dw_orderchange_save.GetItemString(1, "ErrorText"))
	Else
		lb_error = True
		ls_errortext	= Trim(dw_orderchange_save.GetItemString(1, "ErrorText"))
	End If
Else
	lb_error = True
	ls_errortext	= "지시순서 변경을 시도하였지만 오류가 발생했습니다."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("당일 평준화계획","지시순서를 변경하는 중에 오류가 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	iw_this.TriggerEvent("ue_retrieve")
	ll_find	= 0
	ll_find	= dw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"WorkCenter = '" + ls_workcenter + "' And " + &
								"LineCode = '" + ls_linecode + "' And " + &
								"CycleOrder = " + String(li_changeorder) + "", 1, dw_1.RowCount())
	If ll_find > 0 Then
		dw_1.SetRow(ll_find)
		dw_1.Trigger Event RowFocusChanged(ll_find)
		dw_1.ScrollToRow(ll_find)
	End If
End If
end subroutine

on w_pisp080u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.cb_2=create cb_2
this.uo_date=create uo_date
this.cb_1=create cb_1
this.st_bar=create st_bar
this.st_left=create st_left
this.st_right=create st_right
this.dw_orderchange_save=create dw_orderchange_save
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.uo_date
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.st_bar
this.Control[iCurrent+10]=this.st_left
this.Control[iCurrent+11]=this.st_right
this.Control[iCurrent+12]=this.dw_orderchange_save
this.Control[iCurrent+13]=this.dw_print
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.gb_5
end on

on w_pisp080u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.cb_2)
destroy(this.uo_date)
destroy(this.cb_1)
destroy(this.st_bar)
destroy(this.st_left)
destroy(this.st_right)
destroy(this.dw_orderchange_save)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_5)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_orderchange_save.SetTransObject(SQLPIS)

dw_1.ShareData(dw_print)

cb_1.Enabled	= m_frame.m_action.m_save.Enabled
cb_2.Enabled	= m_frame.m_action.m_save.Enabled

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

ib_open = True
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(uo_date.is_uo_date, &
					uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
					uo_workcenter.is_uo_workcenter, uo_line.is_uo_linecode) > 0 Then
	uo_status.st_message.text =  "당일 평준화계획 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "당일 평준화계획 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("당일 평준화계획", "당일 평준화계획 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_print.ReSet()
dw_orderchange_save.ReSet()

// Drag 에 관련된 변수도 ReSet 하자
st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False			
il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False

end event

event open;call super::open;st_left.Visible		= False
st_bar.Visible			= False
st_right.Visible		= False
end event

event dragwithin;call super::dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt

ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '평준화 계획'
lstr_prt.tag			= '평준화 계획'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_orderchange_save.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp080u
end type

event uo_status::dragwithin;call super::dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

type dw_1 from u_vi_std_datawindow within w_pisp080u
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 188
integer width = 1440
integer height = 1704
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp080u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_vscroll;//// DataWindow Event_ID pbm_vscroll 

Long ll_scrollPos, ll_detail
String ls_Row, ls_vScrollPos, ls_Chk 

//ll_header		= Long(Describe("DataWindow.Header.Height"))
ll_detail		= Long(Describe("DataWindow.Detail.Height"))

If scrollcode = 0 Then 		// ▲ 
	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> 행간높이 
	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 

	Return 1 
ElseIf scrollcode = 1 Then 	// ▼
	
	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
	ll_scrollPos = Long(ls_vScrollPos) + ll_detail 
	
	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
	If ls_Chk <> '' Then MessageBox("", ls_Chk)
	Return 1 
End If 

end event

event clicked;//
If row > 0 Then
	ib_drag	= True

	SelectRow(0, False)
	SelectRow(row, True)

	wf_orderchange_bar_visible(row)

	il_drag_row	= row
	This.Drag (Begin!)
End If
end event

event rowfocuschanged;//
If CurrentRow > 0 Then
	If Not ib_drag Then
		this.SelectRow(0,FALSE)
		this.SelectRow(currentrow,TRUE)
	End If
End If
end event

event ue_lbuttonup;//
st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

event dragdrop;// il_drag_row => il_new_row

Long	ll_focus, ll_kb_rowcount
DragObject	ldo_object
DataWindow	ldw_control

//dw_1.SetRedraw(False)
//Dragged중인 Object를 알아낸다.
ldo_object = DraggedObject()
ib_drag	= False
//// Dragged Object가 DataWindow이고 자신(This)이면 조립지시 순서 변경 함수를 실행한다. 
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
	If ldw_control = This Then
		If il_drag_row <> il_new_row And (il_drag_row > il_new_row Or &
			il_new_row - il_drag_row > 1) And &
			il_new_row <> 0 And &
			il_drag_row <> 0 Then
			
			// il_drag_row	=> Drag 하기위해 처음에 선택한 Row
			// il_new_row	=> Drag 하여 Drop 시킨 곳의 Row
			If il_drag_row > il_new_row Then
				il_new_row	= il_new_row
			Else
				il_new_row	= il_new_row - 1
			End If

			// DragDrop 도 끝나고,
			// 바로 DB에 순서변경하자...
			wf_orderchange_save()

//			If il_drag_row > il_new_row Then
//				ll_focus	= il_new_row
//			Else
//				ll_focus	= il_new_row - 1
//			End If
//			Post Event RowFocusChanged(ll_focus)
		End If
	End If
End If
//dw_1.SetRedraw(True)
end event

event dragwithin;call super::dragwithin;Long	ll_first_row, ll_header, ll_detail, ll_last_row, ll_summary
DragObject	ldo_object
DataWindow	ldw_control

If Not ib_drag Then
	ib_drag	= True
End If

If row > 0 Then
	If il_new_row <> row Then
		ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
		ll_header		= Long(Describe("DataWindow.Header.Height"))
		ll_detail		= Long(Describe("DataWindow.Detail.Height"))

		ll_summary		= ll_detail * wf_orderchange_groupcount(row)

		st_bar.Move(X, Y + ll_header + ll_summary + (ll_detail * (row - ll_first_row)))
		st_left.Move(X - st_left.Width + 4, &
						 Y + ll_header + ll_summary + (ll_detail * (row - ll_first_row)) - ((st_left.Height - st_bar.Height) / 2))
		st_right.Move(X + Width, &
						 Y + ll_header + ll_summary + (ll_detail * (row - ll_first_row)) - ((st_right.Height - st_bar.Height) / 2))
	
		il_new_row = row
	End If
Else
	ll_last_row 	= Long(Object.DataWindow.LastRowOnPage)
	ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
	ll_header		= Long(Describe("DataWindow.Header.Height"))
	ll_detail		= Long(Describe("DataWindow.Detail.Height"))
	If PointerY() > ll_header Then
		If ll_last_row < RowCount() Then
			ScrollNextRow()
		Else
			ll_summary		= ll_detail * wf_orderchange_groupcount(ll_last_row)

			st_bar.Move(X, Y + ll_header + ll_summary + (ll_detail * (ll_last_row - ll_first_row + 1)))
			st_left.Move(X - st_left.Width + 4, &
							 Y + ll_header + ll_summary + (ll_detail * (ll_last_row - ll_first_row + 1)) - ((st_left.Height - st_bar.Height) / 2))
			st_right.Move(X + Width, &
							 Y + ll_header + ll_summary + (ll_detail * (ll_last_row - ll_first_row + 1)) - ((st_right.Height - st_bar.Height) / 2))
					
			il_new_row = ll_last_row + 1
		End If
	Else
		ScrollPriorRow()
	End If
End If
end event

event rbuttondown;//
end event

type uo_area from u_pisc_select_area within w_pisp080u
integer x = 754
integer y = 64
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	dw_orderchange_save.SetTransObject(SQLPIS)
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
	
End If

end event

type uo_division from u_pisc_select_division within w_pisp080u
integer x = 1239
integer y = 64
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	dw_orderchange_save.SetTransObject(SQLPIS)
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
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp080u
integer x = 1819
integer y = 64
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
End If

end event

type uo_line from u_pisc_select_line within w_pisp080u
integer x = 2487
integer y = 64
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type cb_2 from commandbutton within w_pisp080u
integer x = 3707
integer y = 56
integer width = 704
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "평준화 계획 계산(&G)"
end type

event clicked;//If dw_1.GetRow() > 0 Then
	istr_parms.string_arg[1] = is_size
	istr_parms.string_arg[2] = uo_date.is_uo_date
	istr_parms.window_arg[1] = Parent


	OpenWithParm(w_pisp004u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
		iw_this.TriggerEvent("ue_retrieve")
	End If
//Else
//	uo_status.st_message.text =  "당일 평준화계획을 계산하려는 정보를 선택하여 주십시요." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
//	MessageBox("당일 평준화계획", "당일 평준화계획을 계산하려는 정보를 선택하여 주십시요.", StopSign!)
//	Return	
//End If
end event

event dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

type uo_date from u_pisc_date_tomorrow within w_pisp080u
integer x = 32
integer y = 68
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

on uo_date.destroy
call u_pisc_date_tomorrow::destroy
end on

type cb_1 from commandbutton within w_pisp080u
integer x = 3099
integer y = 56
integer width = 608
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "지시순서 변경(&C)"
end type

event clicked;Int		li_row, li_count
String	ls_applydate_close

li_row = dw_1.GetRow()

If li_row > 0 Then
	
	istr_parms.string_arg[1] = is_size
	istr_parms.string_arg[2] = uo_date.is_uo_date
	istr_parms.string_arg[3] = Trim(dw_1.GetItemString(li_row, "AreaCode"))
	istr_parms.string_arg[4] = Trim(dw_1.GetItemString(li_row, "DivisionCode"))
	istr_parms.string_arg[5] = Trim(dw_1.GetItemString(li_row, "WorkCenter"))
	istr_parms.string_arg[6] = Trim(dw_1.GetItemString(li_row, "WorkCenterName"))
	istr_parms.string_arg[7] = Trim(dw_1.GetItemString(li_row, "LineCode"))
	istr_parms.string_arg[8] = Trim(dw_1.GetItemString(li_row, "LineFullName"))
	istr_parms.string_arg[9] = Trim(dw_1.GetItemString(li_row, "ItemCode"))
	istr_parms.string_arg[10] = Trim(dw_1.GetItemString(li_row, "ItemName"))
	istr_parms.string_arg[11] = Trim(dw_1.GetItemString(li_row, "ModelID"))
	istr_parms.string_arg[12] = Trim(dw_1.GetItemString(li_row, "ProductGubunName"))
	istr_parms.string_arg[13] = String(dw_1.GetItemNumber(li_row, "RackQty"))
	istr_parms.string_arg[14] = String(dw_1.GetItemNumber(li_row, "PlanKBQty"))

	istr_parms.string_arg[15] = String(dw_1.GetItemNumber(li_row, "CycleOrder"))
// 계획이 없는데 지시한 경우에는 PlanKBCount 에서 가져오면 안된다.
//	istr_parms.string_arg[16] = String(dw_1.GetItemNumber(li_row, "PlanKBCount"))
	istr_parms.string_arg[16] = String(dw_1.GetItemNumber(li_row, "KBCount"))

	istr_parms.string_arg[17] = String(dw_1.RowCount())

	ls_applydate_close	= f_pisc_get_date_applydate_close(istr_parms.string_arg[3], istr_parms.string_arg[4], f_pisc_get_date_nowtime())
	
	If ls_applydate_close > uo_date.is_uo_date Then
		uo_status.st_message.text =  "기준일 이전 일자의 지시순서는 변경이 불가능합니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("당일 평준화계획", "기준일 이전 일자의 지시순서는 변경이 불가능합니다.", StopSign!)
		Return
	End If

	li_count = 0
	Select	Count(PlanDate)
	Into		:li_count
	From		tplanrelease
	Where		PlanDate			= :istr_parms.string_arg[2]	And
				AreaCode			= :istr_parms.string_arg[3]	And
				DivisionCode	= :istr_parms.string_arg[4]	And
				WorkCenter		= :istr_parms.string_arg[5]	And
				LineCode			= :istr_parms.string_arg[7]	And
				CycleOrder		= :istr_parms.string_arg[15]	And
				PrdFlag			In ('E')
	Using SQLPIS;

	If li_count = 0 Then
		If li_count >= Integer(istr_parms.string_arg[16])	Then
			uo_status.st_message.text =  "선택하신 지시는 이미 모든 간판이 조립완료된 상태입니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("당일 평준화계획", "선택하신 지시는 이미 모든 간판이 조립완료된 상태입니다.", StopSign!)
			Return
		End If
	End If

	OpenWithParm(w_pisp005u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
		iw_this.TriggerEvent("ue_retrieve")
	End If
Else
	uo_status.st_message.text =  "지시순서를 변경하려는 정보를 선택하여 주십시요." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("당일 평준화계획", "지시순서를 변경하려는 정보를 선택하여 주십시요.", StopSign!)
	Return
End If
end event

event dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

type st_bar from statictext within w_pisp080u
integer x = 1243
integer y = 420
integer width = 800
integer height = 16
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 8388736
boolean focusrectangle = false
end type

type st_left from statictext within w_pisp080u
integer x = 1225
integer y = 400
integer width = 18
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 8388736
boolean focusrectangle = false
end type

type st_right from statictext within w_pisp080u
integer x = 2043
integer y = 400
integer width = 18
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 8388736
boolean focusrectangle = false
end type

type dw_orderchange_save from datawindow within w_pisp080u
integer x = 823
integer y = 560
integer width = 1170
integer height = 612
boolean bringtotop = true
boolean titlebar = true
string title = "지시변경 저장"
string dataobject = "d_pisp005u_01_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible	= False
end event

type dw_print from datawindow within w_pisp080u
integer x = 2245
integer y = 688
integer width = 727
integer height = 408
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp080u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_1 from groupbox within w_pisp080u
integer x = 14
integer width = 718
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

type gb_2 from groupbox within w_pisp080u
integer x = 731
integer width = 1070
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

type gb_3 from groupbox within w_pisp080u
integer x = 1806
integer width = 1253
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

type gb_5 from groupbox within w_pisp080u
integer x = 3063
integer width = 1385
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

