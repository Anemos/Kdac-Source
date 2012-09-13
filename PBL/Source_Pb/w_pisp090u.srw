$PBExportHeader$w_pisp090u.srw
$PBExportComments$��������
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

// il_drag_row	=> Drag �ϱ����� ó���� ������ Row
// il_old_row	=> Drag �Ͽ� Drop ��Ų ���� Row
Long		il_drag_row, il_new_row

// ��ĳ���� ���ǿ� ���õ� ����
String	is_kb_areacode, is_kb_divisioncode, is_kb_workcenter, is_kb_linecode, &
			is_kb_itemcode, is_kb_tempgubun, is_kb_kbstatuscode, is_kb_kbactivegubun
Int		ii_kb_rackqty, &
			ii_kb_cycleorder // �̰� wf_kbno_item_find() ���� ã�´�.
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

public function integer wf_orderchange_groupcount (long fl_row);// ��ȸ�� ������������� Linecode ���� grouping �� �����̴�.
// ����, ���� ������ Row�� ���°�� Grouping �� ���������� �����;� �Ѵ�.
// �ֳĸ�, Drag �� �� �̵� ������ Row������ �̵��Ǳ� ������
// �������������� Summary ������ŭ Y ���� ��ġ�� �ٷ���ƾ� �Ѵ�...����

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
	MessageBox("��������", "������ �����ϴ�.")
	Return
End If

// �ϴ� ������ �����Ϸ��� ������ ������..
ls_releasedate		= uo_date.is_uo_date
ls_areacode			= Trim(dw_1.GetItemString(il_drag_row, "AreaCode"))
ls_divisioncode	= Trim(dw_1.GetItemString(il_drag_row, "DivisionCode"))
ls_workcenter		= Trim(dw_1.GetItemString(il_drag_row, "WorkCenter"))
ls_linecode			= Trim(dw_1.GetItemString(il_drag_row, "LineCode"))
li_cycleorder		= dw_1.GetItemNumber(il_drag_row, "CycleOrder")
// ��ȹ�� ���µ� ������ ��쿡�� PlanKBCount ���� �������� �ȵȴ�.
//li_plankbcount		= dw_1.GetItemNumber(il_drag_row, "PlanNormalKBCount") + dw_1.GetItemNumber(il_drag_row, "PlanTempKBCount")
//li_changekbcount	= dw_1.GetItemNumber(il_drag_row, "PlanNormalKBCount") + dw_1.GetItemNumber(il_drag_row, "PlanTempKBCount")
li_plankbcount		= dw_1.GetItemNumber(il_drag_row, "KBCount")
li_changekbcount	= dw_1.GetItemNumber(il_drag_row, "KBCount")
// �ű���� ��ġ�� ���ü����� ������..
li_changeorder		= dw_1.GetItemNumber(il_new_row, "CycleOrder")

// ���� ������ ���ô� ������ �� ����
ls_applydate_close	= f_pisc_get_date_applydate_close(ls_areacode, ls_divisioncode, f_pisc_get_date_nowtime())

If ls_applydate_close > ls_releasedate Then
	uo_status.st_message.text =  "������ ���� ������ ���ü����� ������ �Ұ����մϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
	MessageBox("���� ����", "������ ���� ������ ���ü����� ������ �Ұ����մϴ�.", StopSign!)
	Return
End If

// ���� �ٸ� �������� �ű���� ���� �׳� ���������� �Ѵ�.
If ls_areacode			= Trim(dw_1.GetItemString(il_new_row, "AreaCode"))	And &
	ls_divisioncode	= Trim(dw_1.GetItemString(il_new_row, "DivisionCode"))	And &
	ls_workcenter		= Trim(dw_1.GetItemString(il_new_row, "WorkCenter"))	And &
	ls_linecode			= Trim(dw_1.GetItemString(il_new_row, "LineCode"))	Then
Else
	uo_status.st_message.text =  "���ü����� ���� ���ο����� ������ �����մϴ�." //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("���� ����", "���ü����� ���� ���ο����� ������ �����մϴ�.")
	Return
End If

// ���ø� ������ �̵���ų ���
// ���� �� ���̿� �̹� �����Ϸ�� ������ �ϳ��� ������
// �̵� �Ұ���..
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
		MessageBox("���� ����", "�����Ϸ��� ���� ���� ���̿� �̹� �����Ϸ�� ������ �����մϴ�." + &
											"~r~n~r~n�����Ϸ�� ������ ���ü����� ������ �Ұ��� �մϴ�.")
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
		MessageBox("���� ����", "�����Ϸ��� ���� ���� ���̿� ������ ����/�԰� ��ϵ� ������ �����մϴ�." + &
											"~r~n~r~n������ ����/�԰� ��ϵ� ������ ���ü����� ������ �Ұ��� �մϴ�.")
		Return
	End If
End If

// �̹� �����Ϸ�� ������ �ִ� ���
// �����Ϸ� ���� ���� ���û����� ���� �ż��� �̵��� �� �ִ�.
li_prdkbcount = dw_1.GetItemNumber(il_drag_row, "PrdNormalKBCount") + dw_1.GetItemNumber(il_drag_row, "PrdTempKBCount")

If li_prdkbcount > 0 Then
	// ��� ������ �����Ϸ� �����̹Ƿ�, ���� ���� ������ �Ұ���
	If li_prdkbcount >= li_plankbcount	Then
		uo_status.st_message.text =  "�����Ͻ� ���ô� �̹� ��� ������ �����Ϸ�� �����Դϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
		MessageBox("���� ����", "�����Ͻ� ���ô� �̹� ��� ������ �����Ϸ�� �����Դϴ�.", StopSign!)
		Return
	End If
	
	// �Ϻ� ���Ǹ� �����Ϸ�� ��� �̴�.
	// �̰�� ���û����� ���Ǹ� �̵��� �����ϴ�.
	If	MessageBox("���� ����", "�����Ͻ� ���ô�" + String(li_prdkbcount) + " ���� ������ �����Ϸ�� �����Դϴ�." + &
										"~r~n~r~n�ִ� " + &
										String(li_plankbcount - li_prdkbcount) + &
										" ���� ���Ǹ� ���� ������ ������ �� �ֽ��ϴ�." + &
										"~r~n~r~n" + &
										String(li_plankbcount - li_prdkbcount) + &
										" ���� ������ ���ü����� �����Ͻ� �ڽ��ϱ�?", &
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
	ls_errortext	= "���ü��� ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("���� ����","���ü����� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�." + &
											"~r~n~r~n(����)" + &
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

// ��ĳ���� ���ǿ� ���õ� ���� �ʱ�ȭ
is_kb_areacode			= ""
is_kb_divisioncode	= ""
is_kb_workcenter		= ""
is_kb_linecode			= ""
is_kb_itemcode			= ""
is_kb_tempgubun		= ""
is_kb_kbstatuscode	= ""
is_kb_kbactivegubun		= ""
ii_kb_rackqty			= 0
ii_kb_cycleorder		= 0	// �̰� wf_kbno_item_find() ���� ã�´�.

//ls_sn	= Mid(fs_kbno, 9, 3)
//
//If Not IsNumber(ls_sn) Then
//	f_pisc_beep()
//	MessageBox("���� ����","�߸��� ���� ��ȣ�Դϴ�.~r~n��Ȯ�� ���� ��ȣ�� �Է��Ͻʽÿ�.")
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
	MessageBox("���� ����", "�Է��Ͻ� ������ �����Ͻ� ���ڿ� ���ؼ� ��ϵ� �����Դϴ�." + &
									"~r~n~r~n���ǹ�ȣ�� �ٽ� �ѹ� Ȯ���Ͽ� �ֽʽÿ�.")
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
	MessageBox("���� ����", "�Է��Ͻ� ������ �����Ͻ� ���ڿ� �������ø� �����ߴ� �����Դϴ�." + &
									"~r~n~r~n���� ������ �Ϸ翡 �ѹ��� �������ð� �����մϴ�." + &
									"~r~n~r~n���ǹ�ȣ�� �ٽ� �ѹ� Ȯ���Ͽ� �ֽʽÿ�.")
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
	MessageBox("���� ����", "�Է��Ͻ� ������ �������ø� ������ �� �����ϴ�." + &
									"~r~n~r~n���ǹ�ȣ �� ���Ǹ����͸� �ٽ� �ѹ� Ȯ���Ͽ� �ֽʽÿ�.")
	Return	False
End If

If is_kb_kbstatuscode = 'F' Then
	//
Else
	f_pisc_beep()
	MessageBox("���� ����", "�Է��Ͻ� ������ �������ø� ������ �� �����ϴ�." + &
									"~r~n~r~n�Է��Ͻ� ������ ȸ�� ���°� �ƴմϴ�.")
	Return	False
End If

If is_kb_kbactivegubun = 'A' Then
	//
Else
	f_pisc_beep()
	MessageBox("���� ����", "�Է��Ͻ� ������ �������ø� ������ �� �����ϴ�." + &
									"~r~n~r~n�Է��Ͻ� ������ Active ���°� �ƴմϴ�.")
	Return	False
End If

// BOM �� �ִ��� Ȯ��
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
	MessageBox("���� ����", "�Է��Ͻ� ������ ǰ���� �������ø� ������ �� �����ϴ�." + &
									"~r~n~r~nBOM �� ��ϵǾ� ���� ���� ǰ���Դϴ�.")
	Return	False
End If

If ls_stockgubun = 'B' Then
	// ���� ȸ��ǰ�� �ܰ� Ȯ���� �ʿ䰡 ����.
Else
	// �ܰ��� �ִ��� Ȯ��
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
		MessageBox("���� ����", "�Է��Ͻ� ������ ǰ���� �������ø� ������ �� �����ϴ�." + &
										"~r~n~r~n�ܰ��� ��ϵǾ� ���� ���� ǰ���Դϴ�.")
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
	ls_errortext	= "�������ø� �õ��Ͽ����� ������ �߻��߽��ϴ�."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("���� ����","�Է��Ͻ� ������ �������ø� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�." + &
											"~r~n~r~n(����)" + &
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
			If is_kb_tempgubun = "N" Then				// �Է��� ���� ���԰���
				If li_plannormalkbcount > 0 Then
					li_equal_normal	= li_equal_normal + 1
					If li_plannormalkbcount > li_releasenormalkbcount Then	// �������ð� ����
						ls_possible	= "OK"
						Exit
					Else																		// ���� �������� �Ұ���
						ls_possible	= "NONNORMAL"										// ��ȹ�� �߰��� �� ���� ���� ��..
					End If
				End If
			Else												// �Է��� ���� �ӽð���
				If li_plantempkbcount > 0 Then
					li_equal_temp	= li_equal_temp + 1
					If li_plantempkbcount > li_releasetempkbcount Then
						If li_plantempkbcount = 1 Then	// �ӽð��� ��ȹ�ż��� ������ ���� ����
							If li_plantempkbqty = ii_kb_rackqty Then		// �������ð� ����
								ls_possible	= "OK"
								Exit
							Else
								ls_possible	= "NONTEMPQTY"	// ������� ��ġ�ϴ� �ӽð��ǰ�ȹ�� ����.��ȹ�� �߰��� �� ���� ���� ��..
							End If
						Else										// �ӽð��� ��ȹ�ż��� �������� ��� ��������
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
								ls_possible	= "NONTEMPQTY"	// ������� ��ġ�ϴ� �ӽð��ǰ�ȹ�� ����.��ȹ�� �߰��� �� ���� ���� ��..
							End If
						End If
					Else
						ls_possible	= "NONTEMP"		// �ӽð��� ��ȹ�� ����.��ȹ�� �߰��� �� ���� ���� ��..
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
				If MessageBox("���� ����", "��ȹ�� ���� ��ǰ�� ���� ���� �������� �߰� Ȯ��" + &
										"~r~n~r~n���� ����ȭ��ȹ�� ���� ��ǰ�� ���԰��� �Դϴ�." + &
										"~r~n~r~n�Է��Ͻ� ���� ������ �߰��� �������� �Ͻðڽ��ϱ�?" + &
										"~r~n~r~n(����)" + &
										"~r~n1. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�.", &
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
				If MessageBox("���� ����", "��ȹ�� ���� ��ǰ�� �ӽ� ���� �������� �߰� Ȯ��" + &
										"~r~n~r~n���� ����ȭ��ȹ�� ���� ��ǰ�� �ӽð��� �Դϴ�." + &
										"~r~n~r~n�Է��Ͻ� �ӽ� ������ �߰��� �������� �Ͻðڽ��ϱ�?" + &
										"~r~n~r~n(����)" + &
										"~r~n1. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�.", &
										Question!, YesNo!, 2) = 1 Then
					ls_return	= "INSERT_ITEM"
				Else
					ls_return	= "NON"
				End If
				Return	ls_return
			End If
		End If
	Else
		// ���ο��� �ٸ� ��ǰ�� ���� ����ȭ��ȹ�� �ִµ�...
		// �� ��ǰ�� ���Ӱ� �߰��Ϸ��� �� ��...
		f_pisc_beep()
		If MessageBox("���� ����", "����ȹ ��ǰ �������� �߰� Ȯ��" + &
										"~r~n~r~n�Է��Ͻ� ���ǿ� �ش��ϴ� ��ǰ�� ��ȸ�� ���ó����� �������� �ʽ��ϴ�." + &
										"~r~n~r~n�Է��Ͻ� ������ �߰��� �������� �Ͻðڽ��ϱ�?" + &
										"~r~n~r~n(����)" + &
										"~r~n1. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�.", &
										Question!, YesNo!, 2) = 1 Then
			ls_return	= "INSERT_ITEM"
		Else
			ls_return	= "NON"
		End If
		Return	ls_return
	End If
Else
	// �� ��� ��ȸ�� ������ �ִ� ���� ��ȸ�� ������ ���� ��� �޼��� ������ �ٸ���.
	If dw_1.RowCount() > 0 Then
		f_pisc_beep()
		If MessageBox("���� ����", "����ȹ ��ǰ �������� �߰� Ȯ��" + &
										"~r~n~r~n�Է��Ͻ� ���ǿ� �ش��ϴ� ������ ��ȸ�� ���ó����� �������� �ʽ��ϴ�." + &
										"~r~n�Է��Ͻ� ������ �߰��� �������� �Ͻðڽ��ϱ�?" + &
										"~r~n~r~n(����)" + &
										"~r~n1. ������ �߰��� �����Ͻ� �Ŀ� �ش� ������ ���ó����� �� Ȯ���Ͻñ� �ٶ��ϴ�." + &
										"~r~n2. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�. ", &
										Question!, YesNo!, 2) = 1 Then
			ls_return	= "INSERT_LINE"
		Else
			ls_return	= "NON"
		End If
	Else
		If MessageBox("���� ����", "��ȸ�� �������� ������ �����ϴ�." + &
									"~r~n~r~n���� ����ȭ��ȹ ���� �Ǵ� �������� ���� ������ ���� ��쿡��" + &
									"~r~n�������ø� �����ϸ� ���� ����ȭ��ȹ�� ���Ӱ� �߰��˴ϴ�." + &
									"~r~n~r~n�������ø� �����Ͻðڽ��ϱ�?" + &
									"~r~n~r~n(����)" + &
									"~r~n1. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�.", &
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
	If MessageBox("���� ����", "����ȹ ��ǰ �������� �߰� Ȯ��" + &
									"~r~n~r~n�Է��Ͻ� ���� ������ ��ǰ�� �̹� �������ð� ��� ����Ǿ����ϴ�." + &
									"~r~n~r~n�Է��Ͻ� ���� ������ �߰��� �������� �Ͻðڽ��ϱ�?" + &
									"~r~n~r~n(����)" + &
									"~r~n1. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�.", &
									Question!, YesNo!, 2) = 1 Then
		ls_return	= "INSERT"
	Else
		ls_return	= "NON"
	End If
	Return	ls_return
ElseIf ls_possible	= "NONTEMP" Then
	f_pisc_beep()
	If MessageBox("���� ����", "����ȹ ��ǰ �������� �߰� Ȯ��" + &
									"~r~n~r~n�Է��Ͻ� �ӽ� ������ ��ǰ�� �̹� �������ð� ��� ����Ǿ����ϴ�." + &
									"~r~n~r~n�Է��Ͻ� �ӽ� ������ �߰��� �������� �Ͻðڽ��ϱ�?" + &
									"~r~n~r~n(����)" + &
									"~r~n1. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�.", &
									Question!, YesNo!, 2) = 1 Then
		ls_return	= "INSERT"
	Else
		ls_return	= "NON"
	End If
	Return	ls_return
ElseIf ls_possible	= "NONTEMPQTY" Then
	f_pisc_beep()
	If MessageBox("���� ����", "����ȹ ��ǰ �������� �߰� Ȯ��" + &
									"~r~n~r~n�Է��Ͻ� �ӽ� ������ ������� ��ȹ��ǰ�� ������� ��ġ���� �ʽ��ϴ�." + &
									"~r~n�Է��Ͻ� �ӽ� ������ ����� : " + STring(ii_kb_rackqty) + &
									"~r~n��ȹ ��ǰ�� ����� : " + STring(li_plantempkbqty) + &
									"~r~n~r~n�Է��Ͻ� �ӽ� ������ �߰��� �������� �Ͻðڽ��ϱ�?" + &
									"~r~n~r~n(����)" + &
									"~r~n1. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�.", &
									Question!, YesNo!, 2) = 1 Then
		ls_return	= "INSERT"
	Else
		ls_return	= "NON"
	End If
	Return	ls_return
Else
	f_pisc_beep()
	MessageBox("���� ����", "�Է��Ͻ� ������ �������ø� ������ �� �����ϴ�." + &
									"~r~n~r~n�Է��Ͻ� ������ ������ �ٽ� Ȯ���Ͽ� �ֽʽÿ�.")
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
	uo_status.st_message.text =  "���� ���� ����" //+ f_message("����� ����Ÿ�� �����ϴ�.")
Else
	uo_status.st_message.text =  "���� ���� ������ �������� �ʽ��ϴ�" //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("���� ����", "���� ���� ������ �������� �ʽ��ϴ�")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_orderchange_save.ReSet()
dw_kbno_info.ReSet()
dw_kbno_release.ReSet()
dw_print.ReSet()

// Drag �� ���õ� ������ ReSet ����
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

ls_mod	= "st_msg.Text = '" + "������ : " + uo_date.is_uo_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '��������'
lstr_prt.tag			= '��������'
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
string facename = "����ü"
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
//If scrollcode = 0 Then 		// �� 
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> �ణ���� 
//	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//
//	Return 1 
//ElseIf scrollcode = 1 Then 	// ��
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
//Dragged���� Object�� �˾Ƴ���.
ldo_object = DraggedObject()
ib_drag	= False
//// Dragged Object�� DataWindow�̰� �ڽ�(This)�̸� �������� ���� ���� �Լ��� �����Ѵ�. 
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
	If ldw_control = This Then
		If il_drag_row <> il_new_row And (il_drag_row > il_new_row Or &
			il_new_row - il_drag_row > 1) And &
			il_new_row <> 0 And &
			il_drag_row <> 0 Then
			
			// il_drag_row	=> Drag �ϱ����� ó���� ������ Row
			// il_new_row	=> Drag �Ͽ� Drop ��Ų ���� Row
			If il_drag_row > il_new_row Then
				il_new_row	= il_new_row
			Else
				il_new_row	= il_new_row - 1
			End If

			// DragDrop �� ������,
			// �ٷ� DB�� ������������...
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
string facename = "����ü"
string text = "����ȭ��ȹ ���(&G)"
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
//	uo_status.st_message.text =  "���� ����ȭ��ȹ�� ����Ϸ��� ������ �����Ͽ� �ֽʽÿ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
//	MessageBox("���� ����ȭ��ȹ", "���� ����ȭ��ȹ�� ����Ϸ��� ������ �����Ͽ� �ֽʽÿ�.", StopSign!)
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
string facename = "����ü"
string text = "���ü��� ����(&C)"
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
// ��ȹ�� ���µ� ������ ��쿡�� PlanKBCount ���� �������� �ȵȴ�.
//	istr_parms.string_arg[16] = String(dw_1.GetItemNumber(li_row, "PlanNormalKBCount") + dw_1.GetItemNumber(li_row, "PlanTempKBCount"))
	istr_parms.string_arg[16] = String(dw_1.GetItemNumber(li_row, "KBCount"))
	
	istr_parms.string_arg[17] = String(dw_1.RowCount())

	li_prdkbcount = dw_1.GetItemNumber(li_row, "PrdNormalKBCount") + dw_1.GetItemNumber(li_row, "PrdTempKBCount")

	ls_applydate_close	= f_pisc_get_date_applydate_close(istr_parms.string_arg[3], istr_parms.string_arg[4], f_pisc_get_date_nowtime())
	
	If ls_applydate_close > uo_date.is_uo_date Then
		uo_status.st_message.text =  "������ ���� ������ ���ü����� ������ �Ұ����մϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
		MessageBox("���� ����", "������ ���� ������ ���ü����� ������ �Ұ����մϴ�.", StopSign!)
		Return
	End If

	If li_prdkbcount > 0 Then
		If li_prdkbcount >= Integer(istr_parms.string_arg[16])	Then
			uo_status.st_message.text =  "�����Ͻ� ���ô� �̹� ��� ������ �����Ϸ�� �����Դϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
			MessageBox("���� ����", "�����Ͻ� ���ô� �̹� ��� ������ �����Ϸ�� �����Դϴ�.", StopSign!)
			Return
		End If
	End If

	OpenWithParm(w_pisp005u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
		iw_this.TriggerEvent("ue_retrieve")
	End If
Else
	uo_status.st_message.text =  "���ü����� �����Ϸ��� ������ �����Ͽ� �ֽʽÿ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
	MessageBox("���� ����", "���ü����� �����Ϸ��� ������ �����Ͽ� �ֽʽÿ�.", StopSign!)
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
string facename = "����ü"
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
string facename = "����ü"
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
string facename = "����ü"
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
string title = "���ü��� ���� ����"
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
	MessageBox("��������", "������ �����ϴ�.")
	Return
End If

If Len(Data) <> 11 Then
	f_pisc_beep()
	MessageBox("���� ����","���ǹ�ȣ�� 11�ڸ� �Դϴ�.~r~n��Ȯ�� ���� ��ȣ�� �Է��Ͻʽÿ�.")
	GoTo Scrip_Out
End If

// ���� ������ ���ô� ������ �� ����
ls_applydate_close	= f_pisc_get_date_applydate_close('%', '%', f_pisc_get_date_nowtime())

If ls_applydate_close > uo_date.is_uo_date Then
	uo_status.st_message.text =  "������ ���� ������ �������� ������ �Ұ����մϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
	MessageBox("���� ����", "������ ���� ������ �������� ������ �Ұ����մϴ�.", StopSign!)
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
//	uo_status.st_message.text =  "�������ø� ������ ������ ������ ��ȸ�Ͻʽÿ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
//	If MessageBox("���� ����", "��ȸ�� �������� ������ �����ϴ�." + &
//								"~r~n~r~n���� ����ȭ��ȹ ���� �Ǵ� �������� ���� ������ ���� ��쿡��" + &
//								"~r~n�������ø� �����ϸ� ���� ����ȭ��ȹ�� ���Ӱ� �߰��˴ϴ�." + &
//								"~r~n~r~n�������ø� �����Ͻðڽ��ϱ�?" + &
//								"~r~n~r~n(����)" + &
//								"~r~n1. ����, ���� ������ ���ð� �ƴ� ���� �����ȹ�� ���Ӱ� �����˴ϴ�.", &
//								Question!, YesNo!, 2) = 1 Then
//		// �������� ����...����
//	Else
//		GoTo Scrip_Out
//	End If
//End If

// ������ ���µ��� üũ����
If wf_kbno_check(Data) = False Then
	GoTo Scrip_Out
End If

// ������ ���� �� ��ȸ�� �����������쿡�� ���ð� ���������� �˾ƺ���...����
ls_return	= wf_kbno_find_item(Data)
If ls_return = "NON" Then
	GoTo Scrip_Out
End If

// ��..���� ������ DB�� �����ؾ���
If ls_return = "UPDATE" Or ls_return = "INSERT" Or &
						ls_return = "INSERT_ITEM" Or ls_return = "INSERT_LINE" Then
	// ls_return �� "INSET", "INSERT_ITEM", "INSERT_LINE" �� ��� �׳� "INSERT" �� ������
	// ���ν������� ������ �ɼ��� �˾Ƽ� ó���Ѵ�.
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

// DB �� ���强��...Retrieve ���� ����,,�׳� ������ �����쿡 ���� ��������..
If ls_return = "UPDATE" Then		// ���ð��� �ż��� ���������Ƿ�..������ ã�Ƽ� ������ ����
	ll_find	= dw_1.Find("AreaCode = '" + is_kb_areacode + "' And " + &
								"DivisionCode = '" + is_kb_divisioncode + "' And " + &
								"WorkCenter = '" + is_kb_workcenter + "' And " + &
								"LineCode = '" + is_kb_linecode + "' And " + &
								"CycleOrder = " + String(ii_kb_cycleorder), 1, dw_1.RowCount())
	If ll_find > 0 Then
		ll_row	= ll_find
	End If
ElseIf ls_return = "INSERT" Then	// ������ ���Ӱ� �߰��ϹǷ�..���� ū �������ٰ� ���� ��Ű��..
	// �ϴ� ó������ �Ȱ��� ���� ã��
	ll_find	= dw_1.Find("AreaCode = '" + is_kb_areacode + "' And " + &
								"DivisionCode = '" + is_kb_divisioncode + "' And " + &
								"WorkCenter = '" + is_kb_workcenter + "' And " + &
								"LineCode = '" + is_kb_linecode + "' And " + &
								"ItemCode = '" + is_kb_itemcode + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then	// �������� �Ȱ��� ���� �ִ��� �� ã��...���
		If ll_find = dw_1.RowCount() Then
			ll_row	= ll_find		// ������ ������ ������ Row �� ������
		Else
			ll_row	= ll_find		// ������ ������ ������ Row �� ������
			Do While	ll_find < dw_1.RowCount()	// ��� �Ȱ��� ���� ã�Ƽ�...����
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
						ll_row	= ll_find		// ������ ������ ������ Row �� ������
//						ll_find	= ll_find + 1
					End If
				Else
					Exit
				End If
			Loop
		End If
	End If
Else	// "INSERT_ITEM", "INSERT_LINE" �� ���
	// �� ���� ó���ϱⰡ �� ��������...�׳� �����������츦 �ٽ� ��ȸ����..
	ll_row	= 1	// �̰Ǹ� �� ��ũ���� ���� �׳� ����������...����
End If

// ��...� ������ ã�����ϱ�...������ ������Ű��..
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
		// �� �����ϴ�..
		// �׳�, �ٽ� ��ȸ����...����
		iw_this.TriggerEvent("ue_retrieve")
		// ���Ӱ� �߰��� ��ǰ�� ã�� Focus �� �����ؾ���....
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
		// �� �����ϴ�..
		// �׳�, �ٽ� ��ȸ����...����
		// �� ��� �ش� ������ ���ð� �ٽ� ��ȸ�ȴٴ� ������ ����
		// ����. Focus �� �׳� ����...�����ϴ� ���� �˾Ƽ� ã����...����
		iw_this.TriggerEvent("ue_retrieve")
//		dw_1.Trigger Event RowFocusChanged(ll_row + 1)
	End If
Else
	GoTo Scrip_Out
End If

// �׳� RowFocusChanged �̺�Ʈ�� �߻����Ѽ�..���� ���� ������ ��ȸ����..
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
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���� ��ȣ :"
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
string facename = "����ü"
string text = "�������� ���(&D)"
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
		uo_status.st_message.text =  "������ ���� ������ ���� ��Ҵ� �Ұ����մϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
		MessageBox("���� ����", "������ ���� ������ ���� ��Ҵ� �Ұ����մϴ�." + &
										"~r~n~r~n���ؼ� ���� ó���� �����Ͻʽÿ�.", StopSign!)
		Return
	End If

//	If li_prdkbcount > 0 Then
//		If li_prdkbcount >= li_plankbcount	Then
//			uo_status.st_message.text =  "�����Ͻ� ���ô� �̹� ��� ������ �����Ϸ� ó���� �����Դϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
//			MessageBox("���� ����", "�����Ͻ� ���ô� �̹� ��� ������ �����Ϸ� ó���� �����Դϴ�.", StopSign!)
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
	uo_status.st_message.text =  "���ø� ����Ϸ��� ������ �����Ͽ� �ֽʽÿ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
	MessageBox("���� ����", "���ø� ����Ϸ��� ������ �����Ͽ� �ֽʽÿ�.", StopSign!)
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
string facename = "����ü"
string text = "������ ����/�԰� ���(&N)"
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
string facename = "����ü"
string text = "���ؼ����� ȸ��(&U)"
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
string facename = "����ü"
string text = "���ð��� ����(&V)"
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
string title = "���� ���� ����"
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
string title = "���� ���� ����"
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
string facename = "����ü"
string text = "���ǹ���(&K)"
end type

event clicked;Int	li_row

li_row	= dw_1.GetRow()

If li_row > 0 Then
	//
Else
	MessageBox("��������", "��ǰ�� �����Ͽ� �ֽʽÿ�.", StopSign!)
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
string facename = "����ü"
string text = "�ӽð���(&T)"
end type

event clicked;If dw_1.GetRow() > 0 Then
	istr_parms.string_arg[1] = is_size
	istr_parms.datawindow_arg[1] = dw_1

	OpenWithParm(w_pisp094u, istr_parms)
	If Upper(Message.StringParm) = "CHANGE" Then
	//		iw_this.TriggerEvent("ue_retrieve")
	End If
Else
	MessageBox("��������", "�ӽð����� ������ �������� ������ ��ȸ�Ͻʽÿ�.")
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
string title = "�μ�"
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
string facename = "����ü"
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
string facename = "����ü"
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
string facename = "����ü"
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
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

