$PBExportHeader$w_pisp210u.srw
$PBExportComments$간판 마스터
forward
global type w_pisp210u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp210u
end type
type uo_area from u_pisc_select_area within w_pisp210u
end type
type uo_division from u_pisc_select_division within w_pisp210u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp210u
end type
type uo_line from u_pisc_select_line within w_pisp210u
end type
type dw_detail from datawindow within w_pisp210u
end type
type st_h_bar from uo_xc_splitbar within w_pisp210u
end type
type rb_1 from radiobutton within w_pisp210u
end type
type uo_item from u_pisc_select_item_kb_line within w_pisp210u
end type
type rb_2 from radiobutton within w_pisp210u
end type
type rb_3 from radiobutton within w_pisp210u
end type
type dw_save from datawindow within w_pisp210u
end type
type st_right from statictext within w_pisp210u
end type
type st_bar from statictext within w_pisp210u
end type
type st_left from statictext within w_pisp210u
end type
type dw_print from datawindow within w_pisp210u
end type
type gb_1 from groupbox within w_pisp210u
end type
type gb_2 from groupbox within w_pisp210u
end type
type gb_3 from groupbox within w_pisp210u
end type
type gb_4 from groupbox within w_pisp210u
end type
end forward

global type w_pisp210u from w_ipis_sheet01
integer width = 4434
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
dw_detail dw_detail
st_h_bar st_h_bar
rb_1 rb_1
uo_item uo_item
rb_2 rb_2
rb_3 rb_3
dw_save dw_save
st_right st_right
st_bar st_bar
st_left st_left
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_pisp210u w_pisp210u

type variables
Boolean	ib_open, ib_change, ib_drag
String	is_prdstopgubun = '%'
// il_drag_row	=> Drag 하기위해 처음에 선택한 Row
// il_old_row	=> Drag 하여 Drop 시킨 곳의 Row
Long		il_drag_row, il_new_row
end variables

forward prototypes
public function integer wf_orderchange_groupcount (long fl_row)
public subroutine wf_orderchange_bar_visible (long fl_row)
public subroutine wf_orderchange_save ()
public function boolean wf_save ()
end prototypes

public function integer wf_orderchange_groupcount (long fl_row);//// 조회된 데이터윈도우는 Linecode 별로 grouping 한 상태이다.
//// 따라서, 현재 선택한 Row가 몇번째로 Grouping 된 라인인지를 가져와야 한다.
//// 왜냐면, Drag 할 때 이동 라인이 Row단위로 이동되기 때문에
//// 데이터윈도우의 Summary 갯수만큼 Y 축의 위치를 바로잡아야 한다...씨불
//
//Long		i, ll_summary
//String	ls_workcenter, ls_linecode, ls_workcenter_old, ls_linecode_old
//
//ll_first_row	= Long(dw_1.Object.DataWindow.FirstRowOnPage)
//ll_last_row		= Long(dw_1.Object.DataWindow.LastRowOnPage)
//	
//If fl_row > 0 Then
//	If fl_row = 1 Then
//		ll_summary	= 0
//	Else
//		ls_workcenter_old	= Trim(dw_1.GetItemString(1, "WorkCenter"))
//		ls_linecode_old	= Trim(dw_1.GetItemString(1, "LineCode"))
//		For i = 2 To fl_row
//			ls_workcenter	= Trim(dw_1.GetItemString(i, "WorkCenter"))
//			ls_linecode		= Trim(dw_1.GetItemString(i, "LineCode"))
//			If ls_workcenter	<> ls_workcenter_old	Or &
//				ls_linecode		<> ls_linecode_old Then
//				ll_summary	= ll_summary + 1
//			End If
//			ls_workcenter_old	= ls_workcenter
//			ls_linecode_old	= ls_linecode
//		Next
//	End If
//Else
//	ll_summary	= 0
//End If
//	
//Return	ll_summary

// 조회된 데이터윈도우는 Linecode 별로 grouping 한 상태이다.
// 따라서, 현재 선택한 Row가 몇번째로 Grouping 된 라인인지를 가져와야 한다.
// 왜냐면, Drag 할 때 이동 라인이 Row단위로 이동되기 때문에
// 데이터윈도우의 Summary 갯수만큼 Y 축의 위치를 바로잡아야 한다...씨불

Long		i, ll_summary, ll_first_row, ll_last_row
String	ls_workcenter, ls_linecode, ls_workcenter_old, ls_linecode_old

ll_first_row	= Long(dw_1.Object.DataWindow.FirstRowOnPage)
//ll_last_row		= Long(dw_1.Object.DataWindow.LastRowOnPage)
	
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

//messagebox("", string(fl_row) + '   ' + string(ll_first_row))
	
	st_bar.Move(dw_1.X, dw_1.Y + ll_header + ll_summary + (ll_detail * (fl_row - ll_first_row)))
//	st_bar.Move(dw_1.X, dw_1.Y + ll_header + (ll_detail * (fl_row - ll_first_row)))
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

public subroutine wf_orderchange_save ();Int		li_sortorder, li_oldorder
Long		ll_find
Boolean	lb_error
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode, &
			ls_errortext

If i_s_level <> '5' Then
	MessageBox("간판마스", "권한이 없습니다.")
	Return
End If

// 일단 순서를 변경하려는 정보를 구하자..
ls_areacode			= Trim(dw_1.GetItemString(il_drag_row, "AreaCode"))
ls_divisioncode	= Trim(dw_1.GetItemString(il_drag_row, "DivisionCode"))
ls_workcenter		= Trim(dw_1.GetItemString(il_drag_row, "WorkCenter"))
ls_linecode			= Trim(dw_1.GetItemString(il_drag_row, "LineCode"))
ls_itemcode			= Trim(dw_1.GetItemString(il_drag_row, "ItemCode"))
li_oldorder			= dw_1.GetItemNumber(il_drag_row, "SortOrder")

li_sortorder			= dw_1.GetItemNumber(il_new_row, "SortOrder")

If li_oldorder = li_sortorder Then
	Return
End If

// 만약 다른 라인으로 옮기려는 경우는 그냥 파져나가야 한다.
If ls_areacode			= Trim(dw_1.GetItemString(il_new_row, "AreaCode"))	And &
	ls_divisioncode	= Trim(dw_1.GetItemString(il_new_row, "DivisionCode"))	And &
	ls_workcenter		= Trim(dw_1.GetItemString(il_new_row, "WorkCenter"))	And &
	ls_linecode			= Trim(dw_1.GetItemString(il_new_row, "LineCode"))	Then
Else
	uo_status.st_message.text =  "조회순서는 동일 라인에서만 변경이 가능합니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판마스터", "조회순서는 동일 라인에서만 변경이 가능합니다.")
	Return
End If

SQLPIS.AutoCommit = False
// 다른 넘들의 순서를 바꾸자
If li_sortorder < li_oldorder Then	//지시를 앞으로 이동
	Update	tmstkb
	Set		SortOrder	= A.SortOrder + 1,
				LastEmp		= 'Y',
				LastDate		= GetDate()
	From		tmstkb	A
	Where		A.AreaCode			= :ls_areacode			And
				A.DivisionCode		= :ls_divisioncode	And
				A.WorkCenter		= :ls_workcenter		And
				A.LineCode			= :ls_linecode			And
				(A.SortOrder	Between :li_sortorder And :li_oldorder)
	Using		SQLPIS;

	Update	tmstkbhis
	Set		SortOrder	= A.SortOrder + 1,
				LastEmp		= 'Y',
				LastDate		= GetDate()
	From		tmstkbhis	A
	Where		A.AreaCode			= :ls_areacode			And
				A.DivisionCode		= :ls_divisioncode	And
				A.WorkCenter		= :ls_workcenter		And
				A.LineCode			= :ls_linecode			And
				A.ApplyTo			= '9999.12.31'			And
				(A.SortOrder	Between :li_sortorder And :li_oldorder)
	Using		SQLPIS;
Else					//지시를 뒤로 이동
	Update	tmstkb
	Set		SortOrder	= A.SortOrder - 1,
				LastEmp		= 'Y',
				LastDate		= GetDate()
	From		tmstkb	A
	Where		A.AreaCode			= :ls_areacode			And
				A.DivisionCode		= :ls_divisioncode	And
				A.WorkCenter		= :ls_workcenter		And
				A.LineCode			= :ls_linecode			And
				(A.SortOrder	Between :li_oldorder And :li_sortorder)
	Using		SQLPIS;

	Update	tmstkbhis
	Set		SortOrder	= A.SortOrder - 1,
				LastEmp		= 'Y',
				LastDate		= GetDate()
	From		tmstkbhis	A
	Where		A.AreaCode			= :ls_areacode			And
				A.DivisionCode		= :ls_divisioncode	And
				A.WorkCenter		= :ls_workcenter		And
				A.LineCode			= :ls_linecode			And
				A.ApplyTo			= '9999.12.31'			And
				(A.SortOrder	Between :li_oldorder And :li_sortorder)
	Using		SQLPIS;

End If

// 이제 변경하려는 넘의 순서를 바꾸자
Update	tmstkb
Set		SortOrder		= :li_sortorder,
			LastEmp			= 'Y',
			LastDate			= GetDate()
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode
Using		SQLPIS;

If SQLPIS.sqlcode <> 0 Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("간판마스터","간판마스터의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

Update	tmstkbhis
Set		SortOrder		= :li_sortorder,
			LastEmp			= 'Y',
			LastDate			= GetDate()
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode			And
			ApplyTo			= '9999.12.31'
Using		SQLPIS;

If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("간판마스터","간판마스터의 조회순서를 변경하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")

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
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("간판마스터","간판마스터 이력의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If
end subroutine

public function boolean wf_save ();Int		li_count, li_rackqty, li_lotsize, li_dividerate, li_pcsperhour, &
			li_safetyinvqty, li_sortorder
String	ls_applydate_close, ls_areacode, ls_divisioncode, ls_workcenter, &
			ls_linecode, ls_itemcode, &
			ls_modelid, ls_productgubun, ls_lineid, ls_kbid, &
			ls_normalkbsn, ls_tempkbsn, ls_stockgubun, ls_prdstopgubun, &
			ls_rackcode, ls_carname, ls_mainlinegubun, ls_stocklocation, ls_errortext
Real		lr_kbfactor, lr_safetyfactor
Boolean	lb_error

dw_detail.AcceptText()

ls_areacode			= Trim(dw_detail.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_detail.GetItemString(1, "DivisionCode"))
ls_workcenter		= Trim(dw_detail.GetItemString(1, "WorkCenter"))
ls_linecode			= Trim(dw_detail.GetItemString(1, "LineCode"))
ls_itemcode			= Trim(dw_detail.GetItemString(1, "ItemCode"))

ls_applydate_close	= f_pisc_get_date_applydate(ls_areacode, ls_divisioncode, f_pisc_get_date_nowtime())

ls_modelid			= Trim(dw_detail.GetItemString(1, "ModelID"))
ls_productgubun	= Trim(dw_detail.GetItemString(1, "ProductGubun"))
//ls_applyfrom		= Trim(dw_detail.GetItemString(1, "ApplyFrom"))
ls_lineid			= Trim(dw_detail.GetItemString(1, "LineID"))
ls_kbid				= Trim(dw_detail.GetItemString(1, "KBID"))
ls_normalkbsn		= Trim(dw_detail.GetItemString(1, "NormalKBSN"))
ls_tempkbsn			= Trim(dw_detail.GetItemString(1, "TempKBSN"))
ls_stockgubun		= Trim(dw_detail.GetItemString(1, "StockGubun"))
ls_prdstopgubun	= Trim(dw_detail.GetItemString(1, "PrdStopGubun"))
ls_rackcode			= Trim(dw_detail.GetItemString(1, "RackCode"))
li_rackqty			= dw_detail.GetItemNumber(1, "RackQty")
li_lotsize			= dw_detail.GetItemNumber(1, "LotSize")
ls_carname			= Trim(dw_detail.GetItemString(1, "CarName"))
ls_mainlinegubun	= Trim(dw_detail.GetItemString(1, "MainLineGubun"))
li_dividerate		= dw_detail.GetItemNumber(1, "DivideRate")
li_pcsperhour		= dw_detail.GetItemNumber(1, "PCSPerHour")
li_safetyinvqty	= dw_detail.GetItemNumber(1, "SafetyInvQty")
lr_kbfactor			= dw_detail.GetItemNumber(1, "KBFactor")
lr_safetyfactor	= dw_detail.GetItemNumber(1, "SafetyFactor")
ls_stocklocation	= Trim(dw_detail.GetItemString(1, "StockLocation"))
li_sortorder		= dw_detail.GetItemNumber(1, "SortOrder")

If li_rackqty > 0 Then
	//
Else
	uo_status.st_message.text =  "수용수는 '0'보다 커야 합니다."
	MessageBox("간판 마스터", "수용수는 '0'보다 커야 합니다.", StopSign!)
	Return	False
End If

If Len(ls_modelid) = 0 Or IsNull(ls_modelid) = True Or ls_modelid = '' Then
	MessageBox("간판 마스터", "정확한 '식별ID' 을 입력하십시오", StopSign!)
	Return	False
End If

If Len(ls_modelid) > 0 Then
	Select	Count(ModelID)
	Into		:li_count
	From		tmstkb
	Where		AreaCode			= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				ItemCode			<> :ls_itemcode		And
				ModelID			= :ls_modelid
	Using	SQLPIS;
	
	If li_count > 0 Then
		uo_status.st_message.text =  "다른 간판마스터의 제품과 동일한 '식별ID' 입니다."
		MessageBox("간판 마스터", "다른 간판마스터의 제품과 동일한 '식별ID' 입니다." + &
												"~r~n~r~n새로운 식별ID 을 입력하십시오", StopSign!)
		Return	False
	End If
End If

SQLPIS.AutoCommit = False

dw_save.ReSet()
If dw_save.Retrieve(	ls_areacode,				ls_divisioncode, &
							ls_workcenter,				ls_linecode, &
							ls_itemcode, &
							ls_applydate_close, 		ls_modelid, &
							ls_lineid, 					ls_kbid, &
							ls_normalkbsn,				ls_tempkbsn, &
							ls_productgubun,			ls_stockgubun, &
							ls_prdstopgubun, 			ls_rackcode, &
							li_rackqty,					li_lotsize, &
							ls_carname, &
							ls_mainlinegubun,			li_dividerate, &
							li_pcsperhour,				li_safetyinvqty, &
							lr_kbfactor,				lr_safetyfactor, &
							ls_stocklocation,			li_sortorder, &
							g_s_empno) > 0 Then
	If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
		lb_error	= False
		ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
	Else
		lb_error = True
		ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
	End If
Else
	lb_error = True
	ls_errortext	= "간판 마스터 변경을 시도하였지만 오류가 발생했습니다."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "변경된 간판 마스터 정보를 저장하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("간판 마스터", "변경된 간판 마스터 정보를 저장하는 도중에 오류가 발생하였습니다.", StopSign!)
	Return False
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_change	= True
	Return True
End If
end function

on w_pisp210u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.rb_1=create rb_1
this.uo_item=create uo_item
this.rb_2=create rb_2
this.rb_3=create rb_3
this.dw_save=create dw_save
this.st_right=create st_right
this.st_bar=create st_bar
this.st_left=create st_left
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_h_bar
this.Control[iCurrent+8]=this.rb_1
this.Control[iCurrent+9]=this.uo_item
this.Control[iCurrent+10]=this.rb_2
this.Control[iCurrent+11]=this.rb_3
this.Control[iCurrent+12]=this.dw_save
this.Control[iCurrent+13]=this.st_right
this.Control[iCurrent+14]=this.st_bar
this.Control[iCurrent+15]=this.st_left
this.Control[iCurrent+16]=this.dw_print
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.gb_2
this.Control[iCurrent+19]=this.gb_3
this.Control[iCurrent+20]=this.gb_4
end on

on w_pisp210u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.rb_1)
destroy(this.uo_item)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.dw_save)
destroy(this.st_right)
destroy(this.st_bar)
destroy(this.st_left)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_detail, BELOW)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)

dw_print.SetTransObject(SQLPIS)

dw_1.ShareData(dw_print)

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

If ib_change Then
	li_return =  MessageBox("간판 마스터", "변경된 간판 마스터 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에 조회하시겠습니까?", &
											Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_save() Then
			uo_status.st_message.text =  "변경된 간판 마스터 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
//			uo_status.st_message.text =  "변경된 간판 마스터 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
//			MessageBox("간판 마스터", "변경된 간판 마스터 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
End If

ib_change = False
iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
						uo_item.is_uo_itemcode,				is_prdstopgubun) > 0 Then
	uo_status.st_message.text =  "간판 마스터 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "간판 마스터 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 마스터", "간판 마스터 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
dw_save.ReSet()
dw_print.ReSet()

ib_change	= False

// Drag 에 관련된 변수도 ReSet 하자
st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False			
il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False

end event

event ue_save;Int	li_row
Long	ll_find
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

dw_detail.AcceptText()

If ib_change = False Then
	uo_status.st_message.text =  "변경된 간판 마스터 정보가 없습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 마스터","변경된 간판 마스터 정보가 없습니다.")
	Return
End If

If MessageBox("간판 마스터","변경하신 간판 마스터 정보를 저장하시겠습니까 ?", &
							Question!, YesNo!, 1) = 2 Then
	Return
Else
	uo_status.st_message.text =  "변경된 간판 마스터 정보 저장 중..." //+ f_message("Work Carlendar 정보 등록 중...")
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
	uo_status.st_message.text =  "변경된 간판 마스터 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
	MessageBox("간판 마스터", "변경된 간판 마스터 정보를 저장하였습니다.", Information!)
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
End If
end event

event ue_delete;call super::ue_delete;int		li_return, li_row, li_count
String	ls_applydate_close, ls_areacode, ls_divisioncode, ls_workcenter, &
			ls_linecode, ls_itemcode
Boolean	lb_error


li_row	= dw_1.GetRow()

If li_row > 0 Then
	ls_areacode			= Trim(dw_1.GetItemString(li_row, "AreaCode"))
	ls_divisioncode	= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
	ls_workcenter		= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
	ls_linecode			= Trim(dw_1.GetItemString(li_row, "LineCode"))
	ls_itemcode			= Trim(dw_1.GetItemString(li_row, "ItemCode"))
	
	Select	Count(KBNo)
	Into		:li_count
	From		tkb
	Where		AreaCode			= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_workcenter		And
				LineCode			= :ls_linecode			And
				ItemCode			= :ls_itemcode			And
				KBStatusCode	<> 'F'
	Using SQLPIS;
	
	If li_count > 1 Then
		uo_status.st_message.text =  "생산중 또는 창고입고 상태인 간판이 존재하는 간판마스터는 삭제할 수 없습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
		MessageBox("간판 마스터", "생산중 또는 창고입고 상태인 간판이 존재하는 간판마스터는 삭제할 수 없습니다.", StopSign!)
		Return
	End If	
Else	
	uo_status.st_message.text =  "간판 마스터을 삭제하려는 제품을 선택하여 주십시요." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("간판 마스터", "간판 마스터을 삭제하려는 제품을 선택하여 주십시요.", StopSign!)
	Return
End If

If ib_change Then
	li_return =  MessageBox("간판 마스터", "변경된 간판 마스터 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에" + &
							"~r~n~r~n선택하신 제품의 간판 마스터 정보를 삭제하시겠습니까?", &
										Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_save() Then
			uo_status.st_message.text =  "변경된 간판 마스터 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
//			uo_status.st_message.text =  "변경된 간판 마스터 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
//			MessageBox("간판 마스터", "변경된 간판 마스터 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
	ib_change = False
Else
	If MessageBox("간판 마스터", "선택하신 제품의 간판 마스터 정보를 삭제하시겠습니까?", &
												Question!, YesNo!, 2) = 2 Then
		Return
	End If
End If

ls_areacode			= Trim(dw_1.GetItemString(li_row, "AreaCode"))
ls_divisioncode	= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
ls_workcenter		= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
ls_linecode			= Trim(dw_1.GetItemString(li_row, "LineCode"))
ls_itemcode			= Trim(dw_1.GetItemString(li_row, "ItemCode"))

ls_applydate_close	= f_pisc_get_date_applydate(ls_areacode, ls_divisioncode, f_pisc_get_date_nowtime())

SQLPIS.AutoCommit = False

// EIS DB에 반영하기 위해 삭제되는 간판 번호 저장
Insert	tdelete
Select	TableName		= 'tkb',
			DeleteData		= A.KBNo,
			DeleteTime		= GetDate(),
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
From		tkb	A
Where		A.AreaCode			= :ls_areacode			And
			A.DivisionCode		= :ls_divisioncode	And
			A.WorkCenter		= :ls_workcenter		And
			A.LineCode			= :ls_linecode			And
			A.ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "삭제되는 간판 번호 정보를 저장하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "삭제되는 간판 번호 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 간판번호 삭제
Delete	tkb
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "간판 정보를 삭제하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "간판 정보를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// EIS DB에 반영하기 위해 삭제되는 간판번호 이력 저장
Insert	tdelete
Select	TableName		= 'tkbhis',
			DeleteData		= LTrim(RTrim(A.KBNo)) + '/' + LTrim(RTrim(A.KBReleaseDate)) + '/' + LTrim(RTrim(Convert(varchar(10), A.KBReleaseSeq))),
			DeleteTime		= GetDate(),
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
From		tkbhis	A
Where		A.AreaCode			= :ls_areacode			And
			A.DivisionCode		= :ls_divisioncode	And
			A.WorkCenter		= :ls_workcenter		And
			A.LineCode			= :ls_linecode			And
			A.ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "삭제되는 간판번호 이력 정보를 저장하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "삭제되는 간판번호 이력 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 간판 번호 이력 삭제
Delete	tkbhis
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "간판 이력 정보를 삭제하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "간판 이력 정보를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// EIS DB에 반영하기 위해 삭제되는 간판마스터 저장
Insert	tdelete
Select	TableName		= 'tmstkb',
			DeleteData		= LTrim(RTrim(A.AreaCode)) + '/' + LTrim(RTrim(A.DivisionCode)) + '/' + LTrim(RTrim(A.WorkCenter)) + '/' + LTrim(RTrim(A.LineCode)) + '/' + LTrim(RTrim(A.ItemCode)),
			DeleteTime		= GetDate(),
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
From		tmstkb	A
Where		A.AreaCode			= :ls_areacode			And
			A.DivisionCode		= :ls_divisioncode	And
			A.WorkCenter		= :ls_workcenter		And
			A.LineCode			= :ls_linecode			And
			A.ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "삭제되는 간판마스터 정보를 저장하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "삭제되는 간판마스터 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 간판 마스터 삭제
Delete	tmstkb
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "간판 마스터 정보를 삭제하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "간판 마스터 정보를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// EIS DB에 반영하기 위해 삭제되는 간판마스터 저장
Insert	tdelete
Select	TableName		= 'tmstkbhis',
			DeleteData		= LTrim(RTrim(A.AreaCode)) + '/' + LTrim(RTrim(A.DivisionCode)) + '/' + LTrim(RTrim(A.WorkCenter)) + '/' + LTrim(RTrim(A.LineCode)) + '/' + LTrim(RTrim(A.ItemCode)) + '/' + LTrim(RTrim(A.ApplyFrom)) + '/' + LTrim(RTrim(A.ApplyTo)),
			DeleteTime		= GetDate(),
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
From		tmstkbhis	A
Where		A.AreaCode			= :ls_areacode			And
			A.DivisionCode		= :ls_divisioncode	And
			A.WorkCenter		= :ls_workcenter		And
			A.LineCode			= :ls_linecode			And
			A.ItemCode			= :ls_itemcode			And
			A.ApplyFrom			= :ls_applydate_close	And
			A.ApplyTo			= :ls_applydate_close			
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "삭제되는 간판마스터 정보를 저장하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "삭제되는 간판마스터 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 간판마스터 이력 삭제
Delete	tmstkbhis
Where		AreaCode			= :ls_areacode				And
			DivisionCode	= :ls_divisioncode		And
			WorkCenter		= :ls_workcenter			And
			LineCode			= :ls_linecode				And
			ItemCode			= :ls_itemcode				And
			ApplyFrom		= :ls_applydate_close	And
			ApplyTo			= :ls_applydate_close			
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "간판 마스터 이력을 삭제하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "간판 마스터 이력을 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

Update	tmstkbhis
Set		ApplyTo				= :ls_applydate_close,
			LastEmp				= 'Y',
			LastDate				= GetDate()
Where		AreaCode			= :ls_areacode				And
			DivisionCode	= :ls_divisioncode		And
			WorkCenter		= :ls_workcenter			And
			LineCode			= :ls_linecode				And
			ItemCode			= :ls_itemcode				And
			ApplyFrom		<= :ls_applydate_close	And
			ApplyTo			> :ls_applydate_close			
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "간판 마스터 이력을 변경하는 중에 오류가 발생하였습니다."
	MessageBox("간판 마스터", "간판 마스터 이력을 변경하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "변경된 간판 마스터 정보를 삭제하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("간판 마스터", "변경된 간판 마스터 정보를 삭제하는 도중에 오류가 발생하였습니다.", StopSign!)
	Return
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_change	= False
	uo_status.st_message.text =  "선택하신 간판 마스터 정보를 삭제하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("간판 마스터", "선택하신 간판 마스터 정보를 삭제하였습니다.", StopSign!)
	TriggerEvent("ue_retrieve")
End If
end event

event ue_insert;call super::ue_insert;Int	li_return

If ib_change Then
	li_return =  MessageBox("간판 마스터", "변경된 간판 마스터 정보가 존재합니다." + &
							"~r~n~r~n변경된 정보를 저장하신 후에" + &
							"~r~n~r~n새로운 간판 마스터 정보를 추가하시겠습니까?", &
										Question!, YesNoCancel!, 3)
	If li_return = 1 Then		
		If wf_save() Then
			uo_status.st_message.text =  "변경된 간판 마스터 정보를 저장하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
	//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
	//			uo_status.st_message.text =  "변경된 간판 마스터 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	//			MessageBox("간판 마스터", "변경된 간판 마스터 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
			Return
		End If
	ElseIf li_return = 3 Then
		Return
	End If
End If

ib_change = False
	
istr_parms.string_arg[1] = is_size
	
OpenWithParm(w_pisp211u, istr_parms)

If Upper(Message.StringParm) = "CHANGE" Then
	TriggerEvent("ue_retrieve")
End If
end event

event closequery;call super::closequery;int	li_return

If ib_change Then
	li_return =  MessageBox("간판 마스터", "변경된 간판 마스터 정보가 존재합니다." + &
							"~r~n~r~n변경된 간판 마스터 정보를 저장하신 후에 종료하시겠습니까?", &
											Question!, YesNoCancel!, 3)

	If li_return = 1 Then		
		If wf_save() Then
			Return 0
//			uo_status.st_message.text =  "Work Calendar 정보를 변경하였습니다." // + f_message("Work Calendar 정보를 변경하였습니다.")
//			MessageBox("Work Calendar", "Work Calendar 정보를 변경하였습니다.", Information!)
		Else
//			uo_status.st_message.text =  "변경된 일일생산계획 정보를 저장하는 중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
//			MessageBox("일일생산계획", "변경된 일일생산계획 정보를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
			Return 1
		End If
	ElseIf li_return = 2 Then
		Return 0
	ElseIf li_return = 3 Then
		Return 1
	End If
End If
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

//ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '간판마스터'
lstr_prt.tag			= '간판마스터'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)

dw_print.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp210u
end type

type dw_1 from u_vi_std_datawindow within w_pisp210u
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 184
integer width = 645
integer height = 1564
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp210u_01"
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
string	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

If CurrentRow > 0 Then
	SelectRow(0,FALSE)
	SelectRow(currentrow,TRUE)
	setfocus()
	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
	ls_divisioncode	= Trim(GetItemString(CurrentRow, "DivisionCode"))
	ls_workcenter		= Trim(GetItemString(CurrentRow, "WorkCenter"))
	ls_linecode			= Trim(GetItemString(CurrentRow, "LineCode"))
	ls_itemcode			= Trim(GetItemString(CurrentRow, "ItemCode"))
	
	dw_detail.Retrieve(ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode)
	
//	ls_filter_list ="(" + "AreaCode" + " = '" + ls_areacode + "' " + ") " + &
//						"And" + "  " + &
//						"(" + "DivisionCode" + " = '" + ls_divisioncode + "' " + ") "
// 	ldwc_wc.SetFilter(ls_filter_list)
//	ldwc_wc.Filter()

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

event dragdrop;call super::dragdrop;// il_drag_row => il_old_row

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
			// il_old_row	=> Drag 하여 Drop 시킨 곳의 Row
			If il_drag_row > il_new_row Then
				il_new_row	= il_new_row
			Else
				il_new_row	= il_new_row - 1
			End If

			// DragDrop 도 끝나고,
			// 바로 DB에 순서변경하자...
			wf_orderchange_save()

//			If il_drag_row > il_old_row Then
//				ll_focus	= il_old_row
//			Else
//				ll_focus	= il_old_row - 1
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

type uo_area from u_pisc_select_area within w_pisp210u
integer x = 50
integer y = 68
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
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

type uo_division from u_pisc_select_division within w_pisp210u
integer x = 549
integer y = 68
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
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

type uo_workcenter from u_pisc_select_workcenter within w_pisp210u
integer x = 1147
integer y = 68
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

type uo_line from u_pisc_select_line within w_pisp210u
integer x = 1824
integer y = 68
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

type dw_detail from datawindow within w_pisp210u
integer x = 965
integer y = 700
integer width = 1947
integer height = 724
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisp210u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
AcceptText()
ib_change		= True

//If Upper(string(dwo.name)) = "AREACODE" Then
////	Post Event ue_check(row)
//End If

end event

event editchanged;
AcceptText()
ib_change		= True
end event

event itemerror;Return 1
end event

event dragwithin;st_bar.Visible		= False
st_left.Visible	= False
st_right.Visible	= False

il_drag_row = 0
il_new_row	= 0
//Drag(End!)
ib_drag	= False
end event

type st_h_bar from uo_xc_splitbar within w_pisp210u
integer x = 754
integer y = 1468
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type rb_1 from radiobutton within w_pisp210u
integer x = 3410
integer y = 76
integer width = 229
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "전체"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If Checked Then
	is_prdstopgubun = "%"
	iw_this.TriggerEvent("ue_reset")
Else
	rb_2.Checked	= False
	rb_3.Checked	= False
End If
end event

type uo_item from u_pisc_select_item_kb_line within w_pisp210u
integer x = 2450
integer y = 68
boolean bringtotop = true
end type

on uo_item.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type rb_2 from radiobutton within w_pisp210u
integer x = 3675
integer y = 76
integer width = 288
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "생산중"
borderstyle borderstyle = stylelowered!
end type

event clicked;If Checked Then
	is_prdstopgubun = "N"
	iw_this.TriggerEvent("ue_reset")
Else
	rb_1.Checked	= False
	rb_3.Checked	= False
End If
end event

type rb_3 from radiobutton within w_pisp210u
integer x = 3986
integer y = 76
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "생산중단"
borderstyle borderstyle = stylelowered!
end type

event clicked;If Checked Then
	is_prdstopgubun = "Y"
	iw_this.TriggerEvent("ue_reset")
Else
	rb_1.Checked	= False
	rb_2.Checked	= False
End If
end event

type dw_save from datawindow within w_pisp210u
integer x = 1842
integer y = 1460
integer width = 805
integer height = 396
boolean bringtotop = true
boolean titlebar = true
string title = "간판마스터 변경 저장"
string dataobject = "d_pisp211u_03_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type st_right from statictext within w_pisp210u
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

type st_bar from statictext within w_pisp210u
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

type st_left from statictext within w_pisp210u
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

type dw_print from datawindow within w_pisp210u
integer x = 1074
integer y = 1508
integer width = 681
integer height = 388
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp210u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible = False
end event

type gb_1 from groupbox within w_pisp210u
integer x = 14
integer width = 1111
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

type gb_2 from groupbox within w_pisp210u
integer x = 1129
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

type gb_3 from groupbox within w_pisp210u
integer x = 3374
integer width = 997
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

type gb_4 from groupbox within w_pisp210u
integer x = 2414
integer width = 955
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

