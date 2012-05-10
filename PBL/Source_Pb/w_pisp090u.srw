$PBExportHeader$w_pisp090u.srw
$PBExportComments$조립지시
forward
global type w_pisp090u from w_ipis_sheet01
end type
type gb_5 from groupbox within w_pisp090u
end type
type dw_1 from u_vi_std_datawindow within w_pisp090u
end type
type uo_area from u_pisc_select_area within w_pisp090u
end type
type uo_division from u_pisc_select_division within w_pisp090u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp090u
end type
type uo_line from u_pisc_select_line within w_pisp090u
end type
type cb_8 from commandbutton within w_pisp090u
end type
type uo_date from u_pisc_date_tomorrow within w_pisp090u
end type
type cb_2 from commandbutton within w_pisp090u
end type
type st_bar from statictext within w_pisp090u
end type
type st_left from statictext within w_pisp090u
end type
type st_right from statictext within w_pisp090u
end type
type dw_orderchange_save from datawindow within w_pisp090u
end type
type dw_kbno from u_pisp_kbno_scan within w_pisp090u
end type
type st_2 from statictext within w_pisp090u
end type
type cb_3 from commandbutton within w_pisp090u
end type
type cb_7 from commandbutton within w_pisp090u
end type
type cb_6 from commandbutton within w_pisp090u
end type
type cb_1 from commandbutton within w_pisp090u
end type
type dw_kbno_info from datawindow within w_pisp090u
end type
type dw_kbno_release from datawindow within w_pisp090u
end type
type cb_5 from commandbutton within w_pisp090u
end type
type cb_4 from commandbutton within w_pisp090u
end type
type dw_print from datawindow within w_pisp090u
end type
type gb_1 from groupbox within w_pisp090u
end type
type gb_2 from groupbox within w_pisp090u
end type
type gb_3 from groupbox within w_pisp090u
end type
type gb_4 from groupbox within w_pisp090u
end type
end forward

global type w_pisp090u from w_ipis_sheet01
integer width = 4677
string title = ""
gb_5 gb_5
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
cb_8 cb_8
uo_date uo_date
cb_2 cb_2
st_bar st_bar
st_left st_left
st_right st_right
dw_orderchange_save dw_orderchange_save
dw_kbno dw_kbno
st_2 st_2
cb_3 cb_3
cb_7 cb_7
cb_6 cb_6
cb_1 cb_1
dw_kbno_info dw_kbno_info
dw_kbno_release dw_kbno_release
cb_5 cb_5
cb_4 cb_4
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_pisp090u w_pisp090u

type variables
Boolean	ib_open, ib_drag

// il_drag_row	=> Drag 하기위해 처음에 선택한 Row
// il_old_row	=> Drag 하여 Drop 시킨 곳의 Row
Long		il_drag_row, il_new_row

// 스캐닝한 간판에 관련된 변수
String	is_kb_areacode, is_kb_divisioncode, is_kb_workcenter, is_kb_linecode, &
			is_kb_itemcode, is_kb_tempgubun, is_kb_kbstatuscode, is_kb_kbactivegubun
Int		ii_kb_rackqty, &
			ii_kb_cycleorder // 이건 wf_kbno_item_find() 에서 찾는다.
end variables

forward prototypes
public subroutine wf_orderchange_bar_visible (long fl_row)
public function integer wf_orderchange_groupcount (long fl_row)
public subroutine wf_orderchange_save ()
public function boolean wf_kbno_check (string fs_kbno)
public function boolean wf_kbno_release (string fs_option, string fs_kbno)
public function string wf_kbno_find_item (string fs_kbno)
end prototypes

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

public subroutine wf_orderchange_save ();Long		ll_find
Int		li_prdkbcount, li_cycleorder, li_plankbcount, li_changeorder, li_changekbcount
Boolean	lb_error
String	ls_applydate_close, &
			ls_releasedate, ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, &
			ls_errortext

If i_s_level <> '5' Then
	MessageBox("조립지시", "권한이 없습니다.")
	Return
End If

// 일단 순서를 변경하려는 정보를 구하자..
ls_releasedate		= uo_date.is_uo_date
ls_areacode			= Trim(dw_1.GetItemString(il_drag_row, "AreaCode"))
ls_divisioncode	= Trim(dw_1.GetItemString(il_drag_row, "DivisionCode"))
ls_workcenter		= Trim(dw_1.GetItemString(il_drag_row, "WorkCenter"))
ls_linecode			= Trim(dw_1.GetItemString(il_drag_row, "LineCode"))
li_cycleorder		= dw_1.GetItemNumber(il_drag_row, "CycleOrder")
// 계획이 없는데 지시한 경우에는 PlanKBCount 에서 가져오면 안된다.
//li_plankbcount		= dw_1.GetItemNumber(il_drag_row, "PlanNormalKBCount") + dw_1.GetItemNumber(il_drag_row, "PlanTempKBCount")
//li_changekbcount	= dw_1.GetItemNumber(il_drag_row, "PlanNormalKBCount") + dw_1.GetItemNumber(il_drag_row, "PlanTempKBCount")
li_plankbcount		= dw_1.GetItemNumber(il_drag_row, "KBCount")
li_changekbcount	= dw_1.GetItemNumber(il_drag_row, "KBCount")
// 옮기려는 위치의 지시순번을 구하자..
li_changeorder		= dw_1.GetItemNumber(il_new_row, "CycleOrder")

// 이전 일자의 지시는 변경할 수 없슴
ls_applydate_close	= f_pisc_get_date_applydate_close(ls_areacode, ls_divisioncode, f_pisc_get_date_nowtime())

If ls_applydate_close > ls_releasedate Then
	uo_status.st_message.text =  "기준일 이전 일자의 지시순서는 변경이 불가능합니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("조립 지시", "기준일 이전 일자의 지시순서는 변경이 불가능합니다.", StopSign!)
	Return
End If

// 만약 다른 라인으로 옮기려는 경우는 그냥 파져나가야 한다.
If ls_areacode			= Trim(dw_1.GetItemString(il_new_row, "AreaCode"))	And &
	ls_divisioncode	= Trim(dw_1.GetItemString(il_new_row, "DivisionCode"))	And &
	ls_workcenter		= Trim(dw_1.GetItemString(il_new_row, "WorkCenter"))	And &
	ls_linecode			= Trim(dw_1.GetItemString(il_new_row, "LineCode"))	Then
Else
	uo_status.st_message.text =  "지시순서는 동일 라인에서만 변경이 가능합니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("조립 지시", "지시순서는 동일 라인에서만 변경이 가능합니다.")
	Return
End If

// 지시를 앞으로 이동시킬 경우
// 만약 그 사이에 이미 조립완료된 간판이 하나라도 있으면
// 이동 불가능..
If li_cycleorder > li_changeorder Then
	ll_find = 0
	Select	Count(PlanDate)
	Into		:ll_find
	From		tplanrelease
	Where		PlanDate			= :ls_releasedate		And
				AreaCode			= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_workcenter		And
				LineCode			= :ls_linecode			And
				(CycleOrder		Between :li_changeorder	And (:li_cycleorder - 1)) And
				PrdFlag			In ('E')
	Using SQLPIS;	
	If ll_find > 0 Then
		MessageBox("조립 지시", "변경하려는 지시 순번 사이에 이미 조립완료된 간판이 존재합니다." + &
											"~r~n~r~n조립완료된 간판의 지시순서는 변경이 불가능 합니다.")
		Return
	End If	
Else
	ll_find = 0
	Select	Count(PlanDate)
	Into		:ll_find
	From		tplanrelease
	Where		PlanDate			= :ls_releasedate		And
				AreaCode			= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_workcenter		And
				LineCode			= :ls_linecode			And
				(CycleOrder		Between :li_cycleorder	And :li_changeorder) And
				ReleaseGubun	In ('U')
	Using SQLPIS;
	
	If ll_find > 0 Then
		MessageBox("조립 지시", "변경하려는 지시 순번 사이에 무간판 생산/입고 등록된 간판이 존재합니다." + &
											"~r~n~r~n무간판 생산/입고 등록된 간판의 지시순서는 변경이 불가능 합니다.")
		Return
	End If
End If

// 이미 조립완료된 간판이 있는 경우
// 조립완료 되지 않은 지시상태의 간판 매수만 이동할 수 있다.
li_prdkbcount = dw_1.GetItemNumber(il_drag_row, "PrdNormalKBCount") + dw_1.GetItemNumber(il_drag_row, "PrdTempKBCount")

If li_prdkbcount > 0 Then
	// 모든 간판이 조립완료 상태이므로, 지시 순서 변경은 불가능
	If li_prdkbcount >= li_plankbcount	Then
		uo_status.st_message.text =  "선택하신 지시는 이미 모든 간판이 조립완료된 상태입니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("조립 지시", "선택하신 지시는 이미 모든 간판이 조립완료된 상태입니다.", StopSign!)
		Return
	End If
	
	// 일부 간판만 조립완료된 경우 이다.
	// 이경우 지시상태의 간판만 이동이 가능하다.
	If	MessageBox("조립 지시", "선택하신 지시는" + String(li_prdkbcount) + " 매의 간판이 조립완료된 상태입니다." + &
										"~r~n~r~n최대 " + &
										String(li_plankbcount - li_prdkbcount) + &
										" 매의 간판만 지시 순서를 변경할 수 있습니다." + &
										"~r~n~r~n" + &
										String(li_plankbcount - li_prdkbcount) + &
										" 매의 간판의 지시순서를 변경하시 겠습니까?", &
										Question!, YesNo!, 2) = 1 Then
		li_changekbcount	= li_plankbcount - li_prdkbcount
	Else
		li_changekbcount	= li_changekbcount
	End If
End If

dw_orderchange_save.ReSet()

SQLPIS.AutoCommit = False

If dw_orderchange_save.Retrieve(ls_releasedate, &
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
	MessageBox("조립 지시","지시순서를 변경하는 중에 오류가 발생하였습니다." + &
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

public function boolean wf_kbno_check (string fs_kbno);Int		li_count
decimal	ld_unitcost
String	ls_stockgubun

// 스캐닝한 간판에 관련된 변수 초기화
is_kb_areacode			= ""
is_kb_divisioncode	= ""
is_kb_workcenter		= ""
is_kb_linecode			= ""
is_kb_itemcode			= ""
is_kb_tempgubun		= ""
is_kb_kbstatuscode	= ""
is_kb_kbactivegubun		= ""
ii_kb_rackqty			= 0
ii_kb_cycleorder		= 0	// 이건 wf_kbno_item_find() 에서 찾는다.

//ls_sn	= Mid(fs_kbno, 9, 3)
//
//If Not IsNumber(ls_sn) Then
//	f_pisc_beep()
//	MessageBox("조립 지시","잘못된 간판 번호입니다.~r~n정확한 간판 번호를 입력하십시오.")
//	Return False
//End If

li_count	= 0
Select	Count(A.KBNo)
Into		:li_count
From		tplanrelease		A
Where		A.PlanDate			= :uo_date.is_uo_date	And
			A.KBNo				= :fs_kbno					And
			A.ReleaseGubun		= 'U'							And
			A.PrdFlag			= 'N'
Using	SQLPIS;

If li_count > 0 Then
	f_pisc_beep()
	MessageBox("조립 지시", "입력하신 간판은 선택하신 일자에 미준수 등록된 간판입니다." + &
									"~r~n~r~n간판번호를 다시 한번 확인하여 주십시오.")
	Return	False
End If

li_count	= 0
Select	Count(A.KBNo)
Into		:li_count
From		tkbhis		A
Where		A.KBNo				= :fs_kbno					And
			A.KBReleaseDate	= :uo_date.is_uo_date
			
Using	SQLPIS;

If li_count > 0 Then
	f_pisc_beep()
	MessageBox("조립 지시", "입력하신 간판은 선택하신 일자에 조립지시를 수행했던 간판입니다." + &
									"~r~n~r~n동일 간판은 하루에 한번만 조립지시가 가능합니다." + &
									"~r~n~r~n간판번호를 다시 한번 확인하여 주십시오.")
	Return	False
End If

li_count	= 0
Select	Count(A.KBNo),
			A.AreaCode,
			A.DivisionCode,
			A.WorkCenter,
			A.LineCode,
			A.ItemCode,
			A.TempGubun,
			A.KBStatusCode,
			A.KBActiveGubun,
			A.RackQty,
			B.StockGubun
Into		:li_count,
			:is_kb_areacode,
			:is_kb_divisioncode,
			:is_kb_workcenter,
			:is_kb_linecode,
			:is_kb_itemcode,
			:is_kb_tempgubun,
			:is_kb_kbstatuscode,
			:is_kb_kbactivegubun,
			:ii_kb_rackqty,
			:ls_stockgubun
From		tkb		A,
			tmstkb	B
Where		A.KBNo				= :fs_kbno			And
			A.AreaCode			= B.AreaCode		And
			A.DivisionCode		= B.DivisionCode	And
			A.WorkCenter		= B.WorkCenter		And
			A.LineCode			= B.LineCode		And
			A.ItemCode			= B.ItemCode		And
			B.PrdStopGubun		= 'N'
Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode, 
			A.TempGubun, A.KBStatusCode, A.KBActiveGubun, A.RackQty, B.StockGubun
Using	SQLPIS;

If li_count > 0 Then
	//
Else
	f_pisc_beep()
	MessageBox("조립 지시", "입력하신 간판은 조립지시를 수행할 수 없습니다." + &
									"~r~n~r~n간판번호 및 간판마스터를 다시 한번 확인하여 주십시오.")
	Return	False
End If

If is_kb_kbstatuscode = 'F' Then
	//
Else
	f_pisc_beep()
	MessageBox("조립 지시", "입력하신 간판은 조립지시를 수행할 수 없습니다." + &
									"~r~n~r~n입력하신 간판은 회수 상태가 아닙니다.")
	Return	False
End If

If is_kb_kbactivegubun = 'A' Then
	//
Else
	f_pisc_beep()
	MessageBox("조립 지시", "입력하신 간판은 조립지시를 수행할 수 없습니다." + &
									"~r~n~r~n입력하신 간판은 Active 상태가 아닙니다.")
	Return	False
End If

// BOM 에 있는지 확인
li_count	= 0
Select	Count(A.BOMPItemNo)
Into		:li_count
From		tmstbom	A
Where		A.AreaCode			= :is_kb_areacode			And
			A.DivisionCode		= :is_kb_divisioncode	And
			A.BOMPItemNo		= :is_kb_itemcode
Using	SQLPIS;

If li_count > 0 Then
	//
Else
	f_pisc_beep()
	MessageBox("조립 지시", "입력하신 간판의 품번은 조립지시를 수행할 수 없습니다." + &
									"~r~n~r~nBOM 에 등록되어 있지 않은 품번입니다.")
	Return	False
End If

If ls_stockgubun = 'B' Then
	// 공정 회수품은 단가 확인할 필요가 없다.
Else
	// 단가가 있는지 확인
	ld_unitcost	= 0
	Select	UnitCost
	Into		:ld_unitcost
	From		tmstitemcost	A
	Where		A.AreaCode			= :is_kb_areacode			And
				A.DivisionCode		= :is_kb_divisioncode	And
				A.ItemCode			= :is_kb_itemcode
	Using	SQLPIS;
	
	If ld_unitcost > 0 Then
		//
	Else
		f_pisc_beep()
		MessageBox("조립 지시", "입력하신 간판의 품번은 조립지시를 수행할 수 없습니다." + &
										"~r~n~r~n단가가 등록되어 있지 않은 품번입니다.")
		Return	False
	End If
End If

Return	True
end function

public function boolean wf_kbno_release (string fs_option, string fs_kbno);Boolean	lb_error
String	ls_errortext

dw_kbno_release.ReSet()

SQLPIS.AutoCommit = False

If dw_kbno_release.Retrieve(fs_option,				uo_date.is_uo_date, &
									ii_kb_cycleorder,		fs_kbno, &
									g_s_empno) > 0 Then
	If Upper(dw_kbno_release.GetItemString(1, "Error")) = "00" Then
		lb_error	= False
		ls_errortext	= Trim(dw_kbno_release.GetItemString(1, "ErrorText"))
	Else
		lb_error = True
		ls_errortext	= Trim(dw_kbno_release.GetItemString(1, "ErrorText"))
	End If
Else
	lb_error = True
	ls_errortext	= "조립지시를 시도하였지만 오류가 발생했습니다."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("조립 지시","입력하신 간판의 조립지시를 수행하는 중에 오류가 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
	Return	False
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	Return	True
End If
end function

public function string wf_kbno_find_item (string fs_kbno);Int		li_count, i, li_plannormalkbcount, li_plantempkbcount, li_plantempkbqty, &
			li_releasenormalkbcount, li_releasetempkbcount
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode, &
			ls_possible, ls_return
Int		li_equal, li_equal_item, li_equal_normal, li_equal_temp

For i = 1 To dw_1.RowCount()
	ls_areacode			= Trim(dw_1.GetItemString(i, "AreaCode"))
	ls_divisioncode	= Trim(dw_1.GetItemString(i, "DivisionCode"))
	ls_workcenter		= Trim(dw_1.GetItemString(i, "WorkCenter"))
	ls_linecode			= Trim(dw_1.GetItemString(i, "LineCode"))
	ls_itemcode			= Trim(dw_1.GetItemString(i, "ItemCode"))

	ii_kb_cycleorder			= 0
	ii_kb_cycleorder			= dw_1.GetItemNumber(i, "CycleOrder")

	li_plannormalkbcount		= dw_1.GetItemNumber(i, "PlanNormalKBCount")
	li_plantempkbcount		= dw_1.GetItemNumber(i, "PlanTempKBCount")
	li_plantempkbqty			= dw_1.GetItemNumber(i, "PlanTempKBQty")

	li_releasenormalkbcount	= dw_1.GetItemNumber(i, "ReleaseNormalKBCount")
	li_releasetempkbcount	= dw_1.GetItemNumber(i, "ReleaseTempKBCount")

	If ls_areacode			= is_kb_areacode		And &
		ls_divisioncode	= is_kb_divisioncode	And &
		ls_workcenter		= is_kb_workcenter	And &
		ls_linecode			= is_kb_linecode	Then
		li_equal	= li_equal + 1
		If ls_areacode			= is_kb_areacode		And &
			ls_divisioncode	= is_kb_divisioncode	And &
			ls_workcenter		= is_kb_workcenter	And &
			ls_linecode			= is_kb_linecode		And &
			ls_itemcode			= is_kb_itemcode	Then
			li_equal_item	= li_equal_item + 1
			If is_kb_tempgubun = "N" Then				// 입력한 것이 정규간판
				If li_plannormalkbcount > 0 Then
					li_equal_normal	= li_equal_normal + 1
					If li_plannormalkbcount > li_releasenormalkbcount Then	// 조립지시가 가능
						ls_possible	= "OK"
						Exit
					Else																		// 정상 조립지시 불가능
						ls_possible	= "NONNORMAL"										// 계획을 추가할 지 물어 봐야 함..
					End If
				End If
			Else												// 입력한 것이 임시간판
				If li_plantempkbcount > 0 Then
					li_equal_temp	= li_equal_temp + 1
					If li_plantempkbcount > li_releasetempkbcount Then
						If li_plantempkbcount = 1 Then	// 임시간판 계획매수이 한장일 경우는 심플
							If li_plantempkbqty = ii_kb_rackqty Then		// 조립지시가 가능
								ls_possible	= "OK"
								Exit
							Else
								ls_possible	= "NONTEMPQTY"	// 수용수와 일치하는 임시간판계획이 없슴.계획을 추가할 지 물어 봐야 함..
							End If
						Else										// 임시간판 계획매수가 여러장일 경우 지랄같음
							li_count	= 0
							Select	Count(CycleOrder)
							Into		:li_count
							From		tplanrelease
							Where		PlanDate			= :uo_date.is_uo_date	And
										AreaCode			= :ls_areacode				And
										DivisionCode	= :ls_divisioncode		And
										WorkCenter		= :ls_workcenter			And
										LineCode			= :ls_linecode				And
										CycleOrder		= :ii_kb_cycleorder		And
										TempGubun		= 'T'							And
										ReleaseGubun	= 'C'							And
										PrdFlag			= 'C'							And
										PlanKBQty		= :ii_kb_rackqty
							Using SQLPIS;
							If li_count > 0 Then
								ls_possible	= "OK"
								Exit
							Else
								ls_possible	= "NONTEMPQTY"	// 수용수와 일치하는 임시간판계획이 없슴.계획을 추가할 지 물어 봐야 함..
							End If
						End If
					Else
						ls_possible	= "NONTEMP"		// 임시간판 계획이 없슴.계획을 추가할 지 물어 봐야 함..
					End If
				End If
			End If
		End If
	End If
Next

If li_equal > 0 Then
	If li_equal_item > 0 Then
		If is_kb_tempgubun = 'N' Then
			If li_equal_normal > 0 Then
				//
			Else
				f_pisc_beep()
				If MessageBox("조립 지시", "계획이 없는 제품의 정규 간판 조립지시 추가 확인" + &
										"~r~n~r~n당일 평준화계획이 없는 제품의 정규간판 입니다." + &
										"~r~n~r~n입력하신 정규 간판을 추가로 조립지시 하시겠습니까?" + &
										"~r~n~r~n(주의)" + &
										"~r~n1. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다.", &
										Question!, YesNo!, 2) = 1 Then
					ls_return	= "INSERT_ITEM"
				Else
					ls_return	= "NON"
				End If
				Return	ls_return
			End If
		Else
			If li_equal_temp > 0 Then
				//
			Else
				f_pisc_beep()
				If MessageBox("조립 지시", "계획이 없는 제품의 임시 간판 조립지시 추가 확인" + &
										"~r~n~r~n당일 평준화계획이 없는 제품의 임시간판 입니다." + &
										"~r~n~r~n입력하신 임시 간판을 추가로 조립지시 하시겠습니까?" + &
										"~r~n~r~n(주의)" + &
										"~r~n1. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다.", &
										Question!, YesNo!, 2) = 1 Then
					ls_return	= "INSERT_ITEM"
				Else
					ls_return	= "NON"
				End If
				Return	ls_return
			End If
		End If
	Else
		// 라인에는 다른 제품의 당일 평준화계획이 있는데...
		// 이 제품을 새롭게 추가하려구 할 때...
		f_pisc_beep()
		If MessageBox("조립 지시", "무계획 제품 조립지시 추가 확인" + &
										"~r~n~r~n입력하신 간판에 해당하는 제품이 조회한 지시내역에 존재하지 않습니다." + &
										"~r~n~r~n입력하신 간판을 추가로 조립지시 하시겠습니까?" + &
										"~r~n~r~n(주의)" + &
										"~r~n1. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다.", &
										Question!, YesNo!, 2) = 1 Then
			ls_return	= "INSERT_ITEM"
		Else
			ls_return	= "NON"
		End If
		Return	ls_return
	End If
Else
	// 이 경우 조회한 내역이 있는 경우와 조회한 내역이 없느 경우 메세지 내용이 다르다.
	If dw_1.RowCount() > 0 Then
		f_pisc_beep()
		If MessageBox("조립 지시", "무계획 제품 조립지시 추가 확인" + &
										"~r~n~r~n입력하신 간판에 해당하는 라인이 조회한 지시내역에 존재하지 않습니다." + &
										"~r~n입력하신 간판을 추가로 조립지시 하시겠습니까?" + &
										"~r~n~r~n(주의)" + &
										"~r~n1. 간판을 추가로 지시하신 후에 해당 라인의 지시내역을 꼭 확인하시기 바랍니다." + &
										"~r~n2. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다. ", &
										Question!, YesNo!, 2) = 1 Then
			ls_return	= "INSERT_LINE"
		Else
			ls_return	= "NON"
		End If
	Else
		If MessageBox("조립 지시", "조회된 조립지시 내역이 없습니다." + &
									"~r~n~r~n당일 평준화계획 정보 또는 조립지시 내역 정보가 없는 경우에는" + &
									"~r~n조립지시를 수행하면 당일 평준화계획이 새롭게 추가됩니다." + &
									"~r~n~r~n조립지시를 수행하시겠습니까?" + &
									"~r~n~r~n(주의)" + &
									"~r~n1. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다.", &
									Question!, YesNo!, 2) = 1 Then
			ls_return	= "INSERT_LINE"
		Else
			ls_return	= "NON"
		End If
	End If
	Return	ls_return
End If

If ls_possible	= "OK" Then
	ls_return	= "UPDATE"
ElseIf ls_possible	= "NONNORMAL" Then
	f_pisc_beep()
	If MessageBox("조립 지시", "무계획 제품 조립지시 추가 확인" + &
									"~r~n~r~n입력하신 정규 간판의 제품은 이미 조립지시가 모두 수행되었습니다." + &
									"~r~n~r~n입력하신 정규 간판을 추가로 조립지시 하시겠습니까?" + &
									"~r~n~r~n(주의)" + &
									"~r~n1. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다.", &
									Question!, YesNo!, 2) = 1 Then
		ls_return	= "INSERT"
	Else
		ls_return	= "NON"
	End If
	Return	ls_return
ElseIf ls_possible	= "NONTEMP" Then
	f_pisc_beep()
	If MessageBox("조립 지시", "무계획 제품 조립지시 추가 확인" + &
									"~r~n~r~n입력하신 임시 간판의 제품은 이미 조립지시가 모두 수행되었습니다." + &
									"~r~n~r~n입력하신 임시 간판을 추가로 조립지시 하시겠습니까?" + &
									"~r~n~r~n(주의)" + &
									"~r~n1. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다.", &
									Question!, YesNo!, 2) = 1 Then
		ls_return	= "INSERT"
	Else
		ls_return	= "NON"
	End If
	Return	ls_return
ElseIf ls_possible	= "NONTEMPQTY" Then
	f_pisc_beep()
	If MessageBox("조립 지시", "무계획 제품 조립지시 추가 확인" + &
									"~r~n~r~n입력하신 임시 간판의 수용수와 계획제품의 수용수가 일치하지 않습니다." + &
									"~r~n입력하신 임시 간판의 수용수 : " + STring(ii_kb_rackqty) + &
									"~r~n계획 제품의 수용수 : " + STring(li_plantempkbqty) + &
									"~r~n~r~n입력하신 임시 간판을 추가로 조립지시 하시겠습니까?" + &
									"~r~n~r~n(주의)" + &
									"~r~n1. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다.", &
									Question!, YesNo!, 2) = 1 Then
		ls_return	= "INSERT"
	Else
		ls_return	= "NON"
	End If
	Return	ls_return
Else
	f_pisc_beep()
	MessageBox("조립 지시", "입력하신 간판은 조립지시를 수행할 수 없습니다." + &
									"~r~n~r~n입력하신 간판의 정보를 다시 확인하여 주십시오.")
	ls_return	= "NON"
	Return	ls_return
End If

Return	ls_return
end function

on w_pisp090u.create
int iCurrent
call super::create
this.gb_5=create gb_5
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.cb_8=create cb_8
this.uo_date=create uo_date
this.cb_2=create cb_2
this.st_bar=create st_bar
this.st_left=create st_left
this.st_right=create st_right
this.dw_orderchange_save=create dw_orderchange_save
this.dw_kbno=create dw_kbno
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_1=create cb_1
this.dw_kbno_info=create dw_kbno_info
this.dw_kbno_release=create dw_kbno_release
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.uo_workcenter
this.Control[iCurrent+6]=this.uo_line
this.Control[iCurrent+7]=this.cb_8
this.Control[iCurrent+8]=this.uo_date
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.st_bar
this.Control[iCurrent+11]=this.st_left
this.Control[iCurrent+12]=this.st_right
this.Control[iCurrent+13]=this.dw_orderchange_save
this.Control[iCurrent+14]=this.dw_kbno
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.cb_3
this.Control[iCurrent+17]=this.cb_7
this.Control[iCurrent+18]=this.cb_6
this.Control[iCurrent+19]=this.cb_1
this.Control[iCurrent+20]=this.dw_kbno_info
this.Control[iCurrent+21]=this.dw_kbno_release
this.Control[iCurrent+22]=this.cb_5
this.Control[iCurrent+23]=this.cb_4
this.Control[iCurrent+24]=this.dw_print
this.Control[iCurrent+25]=this.gb_1
this.Control[iCurrent+26]=this.gb_2
this.Control[iCurrent+27]=this.gb_3
this.Control[iCurrent+28]=this.gb_4
end on

on w_pisp090u.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.cb_8)
destroy(this.uo_date)
destroy(this.cb_2)
destroy(this.st_bar)
destroy(this.st_left)
destroy(this.st_right)
destroy(this.dw_orderchange_save)
destroy(this.dw_kbno)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_1)
destroy(this.dw_kbno_info)
destroy(this.dw_kbno_release)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_orderchange_save.SetTransObject(SQLPIS)
dw_kbno_info.SetTransObject(SQLPIS)
dw_kbno_release.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

dw_1.ShareData(dw_print)

cb_2.Enabled	= m_frame.m_action.m_save.Enabled
cb_3.Enabled	= m_frame.m_action.m_save.Enabled
cb_4.Enabled	= m_frame.m_action.m_save.Enabled
cb_5.Enabled	= m_frame.m_action.m_save.Enabled
cb_6.Enabled	= m_frame.m_action.m_save.Enabled
cb_7.Enabled	= m_frame.m_action.m_save.Enabled
cb_8.Enabled	= m_frame.m_action.m_save.Enabled

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
	uo_status.st_message.text =  "조립 지시 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "조립 지시 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("조립 지시", "조립 지시 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_orderchange_save.ReSet()
dw_kbno_info.ReSet()
dw_kbno_release.ReSet()
dw_print.ReSet()

// Drag 에 관련된 변수도 ReSet 하자
st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False			
il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()

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
lstr_prt.title			= '조립지시'
lstr_prt.tag			= '조립지시'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_orderchange_save.SetTransObject(SQLPIS)
dw_kbno_info.SetTransObject(SQLPIS)
dw_kbno_release.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp090u
end type

event uo_status::dragwithin;call super::dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

type gb_5 from groupbox within w_pisp090u
integer x = 14
integer width = 4594
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_1 from u_vi_std_datawindow within w_pisp090u
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 392
integer width = 3584
integer height = 1472
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp090u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_vscroll;//// DataWindow Event_ID pbm_vscroll 
//
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
//
end event

event clicked;//
If row > 0 Then
//	ib_drag	= True

	SelectRow(0, False)
	SelectRow(row, True)

	wf_orderchange_bar_visible(row)

	il_drag_row	= row
	This.Drag (Begin!)
End If
end event

event rowfocuschanged;//
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode
Int		li_cycleorder

If CurrentRow > 0 Then
	If Not ib_drag Then
		this.SelectRow(0,FALSE)
		this.SelectRow(currentrow,TRUE)
		
		ls_areacode			= Trim(dw_1.GetItemString(CurrentRow, "AreaCode"))
		ls_divisioncode	= Trim(dw_1.GetItemString(CurrentRow, "DivisionCode"))
		ls_workcenter		= Trim(dw_1.GetItemString(CurrentRow, "WorkCenter"))
		ls_linecode			= Trim(dw_1.GetItemString(CurrentRow, "LineCode"))
		li_cycleorder		= dw_1.GetItemNumber(CurrentRow, "CycleOrder")

		dw_kbno_info.ReSet()
		dw_kbno_info.Retrieve(uo_date.is_uo_date, &
										ls_areacode,			ls_divisioncode, &
										ls_workcenter,			ls_linecode, &
										li_cycleorder)
//messagebox("", string(li_cycleorder))
		dw_kbno.Reset()
		dw_kbno.InsertRow(1)
		dw_kbno.SetColumn(1)
		dw_kbno.SetRow(1)
		dw_kbno.SetFocus()
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
//			SetRow(ll_focus)
//			Post Event RowFocusChanged(ll_focus)
		End If
	End If
End If
//dw_1.SetRedraw(True)
end event

event dragwithin;Long	ll_first_row, ll_header, ll_detail, ll_last_row, ll_summary
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
			ll_summary		= ll_detail * wf_orderchange_groupcount(row)

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

type uo_area from u_pisc_select_area within w_pisp090u
integer x = 754
integer y = 252
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;//If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_orderchange_save.SetTransObject(SQLPIS)
	dw_kbno_info.SetTransObject(SQLPIS)
	dw_kbno_release.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
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
	
//End If

end event

type uo_division from u_pisc_select_division within w_pisp090u
integer x = 1239
integer y = 252
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_orderchange_save.SetTransObject(SQLPIS)
	dw_kbno_info.SetTransObject(SQLPIS)
	dw_kbno_release.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
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

type uo_workcenter from u_pisc_select_workcenter within w_pisp090u
integer x = 1819
integer y = 252
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

type uo_line from u_pisc_select_line within w_pisp090u
integer x = 2487
integer y = 252
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type cb_8 from commandbutton within w_pisp090u
integer x = 3968
integer y = 52
integer width = 613
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "평준화계획 계산(&G)"
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

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

event dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

type uo_date from u_pisc_date_tomorrow within w_pisp090u
integer x = 32
integer y = 256
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

on uo_date.destroy
call u_pisc_date_tomorrow::destroy
end on

type cb_2 from commandbutton within w_pisp090u
integer x = 617
integer y = 52
integer width = 562
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "지시순서 변경(&C)"
end type

event clicked;Int		li_row, li_prdkbcount
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
	istr_parms.string_arg[14] = String(dw_1.GetItemNumber(li_row, "PlanNormalKBQty") + dw_1.GetItemNumber(li_row, "PlanTempKBQty"))

	istr_parms.string_arg[15] = String(dw_1.GetItemNumber(li_row, "CycleOrder"))
// 계획이 없는데 지시한 경우에는 PlanKBCount 에서 가져오면 안된다.
//	istr_parms.string_arg[16] = String(dw_1.GetItemNumber(li_row, "PlanNormalKBCount") + dw_1.GetItemNumber(li_row, "PlanTempKBCount"))
	istr_parms.string_arg[16] = String(dw_1.GetItemNumber(li_row, "KBCount"))
	
	istr_parms.string_arg[17] = String(dw_1.RowCount())

	li_prdkbcount = dw_1.GetItemNumber(li_row, "PrdNormalKBCount") + dw_1.GetItemNumber(li_row, "PrdTempKBCount")

	ls_applydate_close	= f_pisc_get_date_applydate_close(istr_parms.string_arg[3], istr_parms.string_arg[4], f_pisc_get_date_nowtime())
	
	If ls_applydate_close > uo_date.is_uo_date Then
		uo_status.st_message.text =  "기준일 이전 일자의 지시순서는 변경이 불가능합니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("조립 지시", "기준일 이전 일자의 지시순서는 변경이 불가능합니다.", StopSign!)
		Return
	End If

	If li_prdkbcount > 0 Then
		If li_prdkbcount >= Integer(istr_parms.string_arg[16])	Then
			uo_status.st_message.text =  "선택하신 지시는 이미 모든 간판이 조립완료된 상태입니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
			MessageBox("조립 지시", "선택하신 지시는 이미 모든 간판이 조립완료된 상태입니다.", StopSign!)
			Return
		End If
	End If

	OpenWithParm(w_pisp005u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
		iw_this.TriggerEvent("ue_retrieve")
	End If
Else
	uo_status.st_message.text =  "지시순서를 변경하려는 정보를 선택하여 주십시요." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("조립 지시", "지시순서를 변경하려는 정보를 선택하여 주십시요.", StopSign!)
	Return
End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

event dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

type st_bar from statictext within w_pisp090u
integer x = 1243
integer y = 584
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

type st_left from statictext within w_pisp090u
integer x = 1225
integer y = 564
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

type st_right from statictext within w_pisp090u
integer x = 2043
integer y = 564
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

type dw_orderchange_save from datawindow within w_pisp090u
integer x = 2267
integer y = 840
integer width = 526
integer height = 320
boolean bringtotop = true
boolean titlebar = true
string title = "지시순서 변경 저장"
string dataobject = "d_pisp005u_01_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible	= False
end event

type dw_kbno from u_pisp_kbno_scan within w_pisp090u
event ue_enter pbm_dwnprocessenter
integer x = 3493
integer y = 216
integer taborder = 0
boolean bringtotop = true
end type

event ue_enter;call super::ue_enter;String	ls_kbno, ls_kbno_check
dwobject ldwo_this

ls_kbno_check	= Trim(GetItemString(1,1))
AcceptText()
ls_kbno			= Trim(GetItemString(1,1))

If ls_kbno_check = ls_kbno Then
	Post Event ItemChanged(1, ldwo_this, ls_kbno)
End If
end event

event itemchanged;Long		ll_find, ll_row
Int		li_releasenormalkbcount, li_releasenormalkbqty, &
			li_releasetempkbcount, li_releasetempkbqty, &
			li_plannormalkbcount, li_plannormalkbqty, &
			li_plantempkbcount, li_plantempkbqty, &
			li_cycleorder
String	ls_return, ls_option, ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, &
			ls_itemcode, ls_applydate_close, ls_releasegubun

If i_s_level <> '5' Then
	MessageBox("조립지시", "권한이 없습니다.")
	Return
End If

If Len(Data) <> 11 Then
	f_pisc_beep()
	MessageBox("조립 지시","간판번호는 11자리 입니다.~r~n정확한 간판 번호를 입력하십시오.")
	GoTo Scrip_Out
End If

// 이전 일자의 지시는 변경할 수 없슴
ls_applydate_close	= f_pisc_get_date_applydate_close('%', '%', f_pisc_get_date_nowtime())

If ls_applydate_close > uo_date.is_uo_date Then
	uo_status.st_message.text =  "기준일 이전 일자의 조립지시 수행은 불가능합니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("조립 지시", "기준일 이전 일자의 조립지시 수행은 불가능합니다.", StopSign!)
	GoTo Scrip_Out
End If

If ls_applydate_close = uo_date.is_uo_date Then
	ls_releasegubun	= 'T'
Else
	ls_releasegubun	= 'Y'
End If

//If dw_1.RowCount() > 0 Then
//	//
//Else
//	uo_status.st_message.text =  "조립지시를 수행할 라인의 정보를 조회하십시오." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
//	If MessageBox("조립 지시", "조회된 조립지시 내역이 없습니다." + &
//								"~r~n~r~n당일 평준화계획 정보 또는 조립지시 내역 정보가 없는 경우에는" + &
//								"~r~n조립지시를 수행하면 당일 평준화계획이 새롭게 추가됩니다." + &
//								"~r~n~r~n조립지시를 수행하시겠습니까?" + &
//								"~r~n~r~n(주의)" + &
//								"~r~n1. 만일, 당일 일자의 지시가 아닌 경우는 생산계획이 새롭게 증가됩니다.", &
//								Question!, YesNo!, 2) = 1 Then
//		// 조립지시 하자...헤헤
//	Else
//		GoTo Scrip_Out
//	End If
//End If

// 간판의 상태등을 체크하자
If wf_kbno_check(Data) = False Then
	GoTo Scrip_Out
End If

// 간판의 변수 및 조회한 데이터윈도우에서 지시가 가능한지를 알아보자...헤헤
ls_return	= wf_kbno_find_item(Data)
If ls_return = "NON" Then
	GoTo Scrip_Out
End If

// 자..이제 간판을 DB에 저장해야지
If ls_return = "UPDATE" Or ls_return = "INSERT" Or &
						ls_return = "INSERT_ITEM" Or ls_return = "INSERT_LINE" Then
	// ls_return 이 "INSET", "INSERT_ITEM", "INSERT_LINE" 일 경우 그냥 "INSERT" 로 콜하자
	// 프로시저에서 각각의 옵션을 알아서 처리한다.
	If ls_return = "UPDATE" Then
		ls_option = "UPDATE"
	Else
		ls_option = "INSERT"
	End If
	If wf_kbno_release(ls_option, Data) = False Then
		GoTo Scrip_Out
	End If
Else
	GoTo Scrip_Out
End If

// DB 에 저장성공...Retrieve 하지 말고,,그냥 데이터 윈도우에 수량 증가하자..
If ls_return = "UPDATE" Then		// 지시가능 매수가 남아있으므로..순번을 찾아서 수량만 증가
	ll_find	= dw_1.Find("AreaCode = '" + is_kb_areacode + "' And " + &
								"DivisionCode = '" + is_kb_divisioncode + "' And " + &
								"WorkCenter = '" + is_kb_workcenter + "' And " + &
								"LineCode = '" + is_kb_linecode + "' And " + &
								"CycleOrder = " + String(ii_kb_cycleorder), 1, dw_1.RowCount())
	If ll_find > 0 Then
		ll_row	= ll_find
	End If
ElseIf ls_return = "INSERT" Then	// 간판을 새롭게 추가하므로..가장 큰 순번에다가 증가 시키자..
	// 일단 처음으로 똑같은 넘을 찾자
	ll_find	= dw_1.Find("AreaCode = '" + is_kb_areacode + "' And " + &
								"DivisionCode = '" + is_kb_divisioncode + "' And " + &
								"WorkCenter = '" + is_kb_workcenter + "' And " + &
								"LineCode = '" + is_kb_linecode + "' And " + &
								"ItemCode = '" + is_kb_itemcode + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then	// 다음에도 똑같은 넘이 있는지 또 찾자...계속
		If ll_find = dw_1.RowCount() Then
			ll_row	= ll_find		// 실제로 수량을 증가할 Row 을 구하자
		Else
			ll_row	= ll_find		// 실제로 수량을 증가할 Row 을 구하자
			Do While	ll_find < dw_1.RowCount()	// 계속 똑같은 넘을 찾아서...ㅆㅂ
				ll_find	= dw_1.Find("AreaCode = '" + is_kb_areacode + "' And " + &
											"DivisionCode = '" + is_kb_divisioncode + "' And " + &
											"WorkCenter = '" + is_kb_workcenter + "' And " + &
											"LineCode = '" + is_kb_linecode + "' And " + &
											"ItemCode = '" + is_kb_itemcode + "'", ll_find + 1, dw_1.RowCount())
				If ll_find > 0 Then
					If ll_find = dw_1.RowCount() Then
						ll_row	= ll_find
						Exit
					Else
						ll_row	= ll_find		// 실제로 수량을 증가할 Row 을 구하자
//						ll_find	= ll_find + 1
					End If
				Else
					Exit
				End If
			Loop
		End If
	End If
Else	// "INSERT_ITEM", "INSERT_LINE" 의 경우
	// 이 경우는 처리하기가 넘 지랄같다...그냥 데이터윈도우를 다시 조회하자..
	ll_row	= 1	// 이건만 남 스크립을 위해 그냥 선언해주자...ㅆㅂ
End If

// 자...어떤 넘인지 찾았으니까...수량을 증가시키자..
If ll_row > 0 Then
	If ls_return = "UPDATE" Or ls_return = "INSERT" Then
		li_releasenormalkbcount	= dw_1.GetItemNumber(ll_row, "ReleaseNormalKBCount")
		li_releasenormalkbqty	= dw_1.GetItemNumber(ll_row, "ReleaseNormalKBQty")
		li_releasetempkbcount	= dw_1.GetItemNumber(ll_row, "ReleaseTempKBCount")
		li_releasetempkbqty		= dw_1.GetItemNumber(ll_row, "ReleaseTempKBQty")
		If is_kb_tempgubun = "N" Then
			dw_1.SetItem(ll_row, "ReleaseNormalKBCount", li_releasenormalkbcount + 1)
			dw_1.SetItem(ll_row, "ReleaseNormalKBQty", li_releasenormalkbqty + ii_kb_rackqty)
		Else
			dw_1.SetItem(ll_row, "ReleaseTempKBCount", li_releasetempkbcount + 1)
			dw_1.SetItem(ll_row, "ReleaseTempKBQty", li_releasetempkbqty + ii_kb_rackqty)
		End If
		If ls_return = "INSERT" And ls_releasegubun = "Y" Then
			li_plannormalkbcount	= dw_1.GetItemNumber(ll_row, "planNormalKBCount")
			li_plannormalkbqty	= dw_1.GetItemNumber(ll_row, "planNormalKBQty")
			li_plantempkbcount	= dw_1.GetItemNumber(ll_row, "planTempKBCount")
			li_plantempkbqty		= dw_1.GetItemNumber(ll_row, "planTempKBQty")
			If is_kb_tempgubun = "N" Then
				dw_1.SetItem(ll_row, "planNormalKBCount", li_plannormalkbcount + 1)
				dw_1.SetItem(ll_row, "planNormalKBQty", li_plannormalkbqty + ii_kb_rackqty)
			Else
				dw_1.SetItem(ll_row, "planTempKBCount", li_plantempkbcount + 1)
				dw_1.SetItem(ll_row, "planTempKBQty", li_plantempkbqty + ii_kb_rackqty)
			End If
		End If
	ElseIf ls_return	= "INSERT_ITEM" Then
		// 넘 복잡하다..
		// 그냥, 다시 조회하자...히히
		iw_this.TriggerEvent("ue_retrieve")
		// 새롭게 추가한 제품의 찾아 Focus 를 변경해야지....
		ll_find	= dw_1.Find("AreaCode = '" + is_kb_areacode + "' And " + &
									"DivisionCode = '" + is_kb_divisioncode + "' And " + &
									"WorkCenter = '" + is_kb_workcenter + "' And " + &
									"LineCode = '" + is_kb_linecode + "' And " + &
									"ItemCode = '" + is_kb_itemcode + "'", ll_find + 1, dw_1.RowCount())
		If ll_find > 0 Then
			dw_1.SetRow(ll_find)
			dw_1.Trigger Event RowFocusChanged(ll_find)
			dw_1.ScrollToRow(ll_find)
		End If
	Else
		// 넘 복잡하다..
		// 그냥, 다시 조회하자...히히
		// 이 경우 해당 라인의 지시가 다시 조회된다는 보장이 없다
		// 따라서. Focus 는 그냥 두자...지시하는 넘이 알아서 찾으라구...헤헤
		iw_this.TriggerEvent("ue_retrieve")
//		dw_1.Trigger Event RowFocusChanged(ll_row + 1)
	End If
Else
	GoTo Scrip_Out
End If

// 그냥 RowFocusChanged 이벤트를 발생시켜서..지시 간판 정보를 조회하자..
//If ll_row <> dw_1.GetRow() Then
If ls_return = "UPDATE" Or ls_return = "INSERT" Then
	dw_1.SetRow(ll_row)
	dw_1.Trigger Event RowFocusChanged(ll_row)
	dw_1.ScrollToRow(ll_row)
End If

Scrip_Out:

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

event losefocus;call super::losefocus;//f_message("Ready")
end event

event getfocus;call super::getfocus;//f_message("Scan a KANBAN for release")
end event

event dragwithin;call super::dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

type st_2 from statictext within w_pisp090u
integer x = 3113
integer y = 264
integer width = 352
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "간판 번호 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_pisp090u
integer x = 1179
integer y = 52
integer width = 562
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조립지시 취소(&D)"
end type

event clicked;Int		li_row, li_plankbcount, li_prdkbcount
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
	istr_parms.string_arg[14] = String(dw_1.GetItemNumber(li_row, "CycleOrder"))

	li_plankbcount	= dw_1.GetItemNumber(li_row, "ReleaseNormalKBCount") + dw_1.GetItemNumber(li_row, "ReleaseTempKBCount")
	li_prdkbcount	= dw_1.GetItemNumber(li_row, "PrdNormalKBCount") + dw_1.GetItemNumber(li_row, "PrdTempKBCount")

	istr_parms.string_arg[15] = String(li_plankbcount)
	
	ls_applydate_close	= f_pisc_get_date_applydate_close(istr_parms.string_arg[3], istr_parms.string_arg[4], f_pisc_get_date_nowtime())
	If ls_applydate_close > uo_date.is_uo_date Then
		uo_status.st_message.text =  "기준일 이전 일자의 지시 취소는 불가능합니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("조립 지시", "기준일 이전 일자의 지시 취소는 불가능합니다." + &
										"~r~n~r~n미준수 간판 처리를 수행하십시오.", StopSign!)
		Return
	End If

//	If li_prdkbcount > 0 Then
//		If li_prdkbcount >= li_plankbcount	Then
//			uo_status.st_message.text =  "선택하신 지시는 이미 모든 간판은 조립완료 처리된 상태입니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
//			MessageBox("조립 지시", "선택하신 지시는 이미 모든 간판은 조립완료 처리된 상태입니다.", StopSign!)
//			Return
//		End If
//	End If

	OpenWithParm(w_pisp091u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
		iw_this.TriggerEvent("ue_retrieve")
		dw_1.SetRow(li_row)
		dw_1.Trigger Event RowFocusChanged(li_row)
	End If
Else
	uo_status.st_message.text =  "지시를 취소하려는 정보를 선택하여 주십시요." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("조립 지시", "지시를 취소하려는 정보를 선택하여 주십시요.", StopSign!)
	Return
End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type cb_7 from commandbutton within w_pisp090u
integer x = 3168
integer y = 52
integer width = 805
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "무간판 생산/입고 등록(&N)"
end type

event clicked;	istr_parms.string_arg[1] = is_size

	OpenWithParm(w_pisp093u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
		iw_this.TriggerEvent("ue_retrieve")
	End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type cb_6 from commandbutton within w_pisp090u
integer x = 2551
integer y = 52
integer width = 617
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "미준수간판 회수(&U)"
end type

event clicked;	istr_parms.string_arg[1] = is_size

	OpenWithParm(w_pisp092u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
		iw_this.TriggerEvent("ue_retrieve")
	End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type cb_1 from commandbutton within w_pisp090u
integer x = 55
integer y = 52
integer width = 562
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "지시간판 정보(&V)"
end type

event clicked;If dw_kbno_info.Visible Then
	dw_kbno_info.Visible = False
Else
	dw_kbno_info.Resize(1769, 1372)
	dw_kbno_info.Move(dw_1.X + 2500, dw_1.Y + 400)
	dw_kbno_info.Visible = True
End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type dw_kbno_info from datawindow within w_pisp090u
integer x = 151
integer y = 808
integer width = 1778
integer height = 856
boolean bringtotop = true
boolean titlebar = true
string title = "지시 간판 정보"
string dataobject = "d_pisp090u_02"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

event constructor;visible	= False
end event

event clicked;dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type dw_kbno_release from datawindow within w_pisp090u
integer x = 2267
integer y = 1216
integer width = 526
integer height = 320
boolean bringtotop = true
boolean titlebar = true
string title = "간판 지시 저장"
string dataobject = "d_pisp090u_03_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible	= False
end event

type cb_5 from commandbutton within w_pisp090u
integer x = 2149
integer y = 52
integer width = 402
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판발행(&K)"
end type

event clicked;Int	li_row

li_row	= dw_1.GetRow()

If li_row > 0 Then
	//
Else
	MessageBox("조립지시", "제품을 선택하여 주십시오.", StopSign!)
	Return
End If

istr_parms.string_arg[1] = is_size
//istr_parms.string_arg[2] = uo_date.is_uo_date

istr_parms.string_arg[3] = Trim(dw_1.GetItemString(li_row, 'AreaCode'))
istr_parms.string_arg[4] = Trim(dw_1.GetItemString(li_row, 'DivisionCode'))
istr_parms.string_arg[5] = Trim(dw_1.GetItemString(li_row, 'WorkCenter'))
istr_parms.string_arg[6] = Trim(dw_1.GetItemString(li_row, 'LineCode'))
istr_parms.string_arg[7] = Trim(dw_1.GetItemString(li_row, 'ItemCode'))

OpenWithParm(w_pisp006u, istr_parms)
If Upper(Message.StringParm) = "CHANGE" Then
//		iw_this.TriggerEvent("ue_retrieve")
End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type cb_4 from commandbutton within w_pisp090u
integer x = 1742
integer y = 52
integer width = 407
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "임시간판(&T)"
end type

event clicked;If dw_1.GetRow() > 0 Then
	istr_parms.string_arg[1] = is_size
	istr_parms.datawindow_arg[1] = dw_1

	OpenWithParm(w_pisp094u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
	//		iw_this.TriggerEvent("ue_retrieve")
	End If
Else
	MessageBox("조립지시", "임시간판을 발행할 조립지시 내역을 조회하십시오.")
End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type dw_print from datawindow within w_pisp090u
integer x = 2875
integer y = 808
integer width = 599
integer height = 372
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp090u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible	= False
end event

type gb_1 from groupbox within w_pisp090u
integer x = 14
integer y = 164
integer width = 718
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisp090u
integer x = 731
integer y = 164
integer width = 1070
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisp090u
integer x = 1806
integer y = 164
integer width = 1253
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_4 from groupbox within w_pisp090u
integer x = 3067
integer y = 164
integer width = 1541
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

