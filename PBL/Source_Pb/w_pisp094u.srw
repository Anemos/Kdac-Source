$PBExportHeader$w_pisp094u.srw
$PBExportComments$�������� - �ӽð��� ����
forward
global type w_pisp094u from window
end type
type em_2 from editmask within w_pisp094u
end type
type em_1 from editmask within w_pisp094u
end type
type st_3 from statictext within w_pisp094u
end type
type st_2 from statictext within w_pisp094u
end type
type st_1 from statictext within w_pisp094u
end type
type dw_save_active from datawindow within w_pisp094u
end type
type dw_print_save from datawindow within w_pisp094u
end type
type dw_print from datawindow within w_pisp094u
end type
type dw_kbno from datawindow within w_pisp094u
end type
type st_msg from statictext within w_pisp094u
end type
type cb_2 from commandbutton within w_pisp094u
end type
type cb_1 from commandbutton within w_pisp094u
end type
type dw_save_kbno from datawindow within w_pisp094u
end type
type gb_7 from groupbox within w_pisp094u
end type
type gb_6 from groupbox within w_pisp094u
end type
type gb_1 from groupbox within w_pisp094u
end type
type gb_2 from groupbox within w_pisp094u
end type
end forward

global type w_pisp094u from window
integer width = 3442
integer height = 1832
boolean titlebar = true
string title = "�ӽð��� ����"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
em_2 em_2
em_1 em_1
st_3 st_3
st_2 st_2
st_1 st_1
dw_save_active dw_save_active
dw_print_save dw_print_save
dw_print dw_print
dw_kbno dw_kbno
st_msg st_msg
cb_2 cb_2
cb_1 cb_1
dw_save_kbno dw_save_kbno
gb_7 gb_7
gb_6 gb_6
gb_1 gb_1
gb_2 gb_2
end type
global w_pisp094u w_pisp094u

type variables
Boolean		ib_open, ib_save
string		is_tempgubun = "T"
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

//dw_kbno.SetTransObject(SQLPIS)
//dw_kbno_buffer.SetTransObject(SQLPIS)
dw_save_kbno.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_print_save.SetTransObject(SQLPIS)
dw_save_active.SetTransObject(SQLPIS)

wf_retrieve()

ib_open = True
end event

public subroutine wf_retrieve ();String		ls_areacode, ls_divisioncode, ls_workcenter, ls_workcentername, &
				ls_linecode, ls_lineshortname, ls_linefullname, &
				ls_itemcode, ls_itemname, ls_modelid, ls_productgubun, ls_productgubunname, &
				ls_tempkbsn, ls_kbsn
Long			i, ll_plantempkbcount, ll_releasetempkbcount, ll_plantempkbqty


dw_kbno.ReSet()
dw_save_kbno.ReSet()

dw_print.ReSet()
dw_print_save.ReSet()
dw_save_active.ReSet()

If istr_parms.datawindow_arg[1].RowCount() > 0 Then
	For i = 1 To istr_parms.datawindow_arg[1].RowCount()
		ll_plantempkbcount		= istr_parms.datawindow_arg[1].GetItemNumber(i, "PlanTempKBCount")
		ll_releasetempkbcount	= istr_parms.datawindow_arg[1].GetItemNumber(i, "ReleaseTempKBCount")
		If ll_plantempkbcount > 0 Then
			If (ll_plantempkbcount - ll_releasetempkbcount) > 0 Then
				ls_areacode			= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "AreaCode"))
				ls_divisioncode	= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "DivisionCode"))
				ls_workcenter		= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "WorkCenter"))
				ls_workcentername	= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "WorkCenterName"))
				ls_linecode			= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "LineCode"))
				ls_lineshortname	= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "LineShortName"))
				ls_linefullname	= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "LineFullName"))
				ls_itemcode			= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "ItemCode"))
				ls_itemname			= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "ItemName"))
				ls_modelid			= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "ModelID"))
				ls_productgubun	= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "ProductGubun"))
				ls_productgubunname	= Trim(istr_parms.datawindow_arg[1].GetItemString(i, "ProductGubunName"))
				ll_plantempkbqty	= istr_parms.datawindow_arg[1].GetItemNumber(i, "PlanTempKBQty")
				
				Select	TempKBSN
				Into		:ls_tempkbsn
				From		tmstkb
				Where		AreaCode			= :ls_areacode			And
							DivisionCode	= :ls_divisioncode	And
							WorkCenter		= :ls_workcenter		And
							LineCode			= :ls_linecode			And
							ItemCode			= :ls_itemcode
				Using		SQLPIS;
				
				dw_kbno.InsertRow(0)
				dw_kbno.SetItem(dw_kbno.RowCount(), "AreaCode", ls_areacode)
				dw_kbno.SetItem(dw_kbno.RowCount(), "DivisionCode", ls_divisioncode)
				dw_kbno.SetItem(dw_kbno.RowCount(), "WorkCenter", ls_workcenter)
				dw_kbno.SetItem(dw_kbno.RowCount(), "WorkCenterName", ls_workcentername)
				dw_kbno.SetItem(dw_kbno.RowCount(), "LineCode", ls_linecode)
				dw_kbno.SetItem(dw_kbno.RowCount(), "LineShortName", ls_lineshortname)
				dw_kbno.SetItem(dw_kbno.RowCount(), "LineFullName", ls_linefullname)
				dw_kbno.SetItem(dw_kbno.RowCount(), "ItemCode", ls_itemcode)
				dw_kbno.SetItem(dw_kbno.RowCount(), "ItemName", ls_itemname)
				dw_kbno.SetItem(dw_kbno.RowCount(), "ModelID", ls_modelid)
				dw_kbno.SetItem(dw_kbno.RowCount(), "ProductGubun", ls_productgubun)
				dw_kbno.SetItem(dw_kbno.RowCount(), "ProductGubunName", ls_productgubunname)
				dw_kbno.SetItem(dw_kbno.RowCount(), "RackQty", ll_plantempkbqty)

				ls_kbsn	= Right(ls_tempkbsn, 2)
				If f_pisc_get_kbno_next_temp(ls_kbsn, ls_kbsn) Then
					ls_tempkbsn	= Left(ls_tempkbsn, 9) + ls_kbsn
					dw_kbno.SetItem(dw_kbno.RowCount(), "TempKBSN", ls_tempkbsn)
				End If
			End If
		End If
	Next
End If
end subroutine

on w_pisp094u.create
this.em_2=create em_2
this.em_1=create em_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_save_active=create dw_save_active
this.dw_print_save=create dw_print_save
this.dw_print=create dw_print
this.dw_kbno=create dw_kbno
this.st_msg=create st_msg
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_save_kbno=create dw_save_kbno
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.em_2,&
this.em_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_save_active,&
this.dw_print_save,&
this.dw_print,&
this.dw_kbno,&
this.st_msg,&
this.cb_2,&
this.cb_1,&
this.dw_save_kbno,&
this.gb_7,&
this.gb_6,&
this.gb_1,&
this.gb_2}
end on

on w_pisp094u.destroy
destroy(this.em_2)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_save_active)
destroy(this.dw_print_save)
destroy(this.dw_print)
destroy(this.dw_kbno)
destroy(this.st_msg)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_save_kbno)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;String		ls_size

//Pareant Window�� �߾����� Window�� �̵���Ű�� ���Ͽ� Parent Window�� X,Y,Width,Height ���� ���Ѵ�.
istr_parms	= Message.PowerObjectParm

ls_size	= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type em_2 from editmask within w_pisp094u
integer x = 2075
integer y = 148
integer width = 133
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
string text = "5"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0"
string minmax = "0~~"
end type

type em_1 from editmask within w_pisp094u
integer x = 2075
integer y = 60
integer width = 133
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
string text = "8"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#0"
string minmax = "0~~"
end type

type st_3 from statictext within w_pisp094u
integer x = 1778
integer y = 152
integer width = 288
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "������:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisp094u
integer x = 1778
integer y = 68
integer width = 288
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "���ʿ���:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisp094u
integer x = 59
integer y = 152
integer width = 1646
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "�����ǰ� ���ÿ� �μ�˴ϴ�.(Active ���� �ڵ� ��ȭ)"
boolean focusrectangle = false
end type

type dw_save_active from datawindow within w_pisp094u
integer x = 2203
integer y = 692
integer width = 526
integer height = 292
boolean bringtotop = true
boolean titlebar = true
string title = "Active ��ȯ"
string dataobject = "d_pisp251u_02_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_print_save from datawindow within w_pisp094u
integer x = 1600
integer y = 688
integer width = 539
integer height = 288
boolean bringtotop = true
boolean titlebar = true
string title = "�μ� ���� ����"
string dataobject = "d_pisp241u_04_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_print from datawindow within w_pisp094u
integer x = 1024
integer y = 684
integer width = 517
integer height = 296
boolean bringtotop = true
boolean titlebar = true
string title = "���� ��ȣ �μ�"
string dataobject = "d_pisp241u_03"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type dw_kbno from datawindow within w_pisp094u
integer x = 46
integer y = 352
integer width = 3301
integer height = 1320
string title = "none"
string dataobject = "d_pisp094u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If CurrentRow > 0 Then
	this.SelectRow(0,FALSE)
	this.SelectRow(currentrow,TRUE)
End If
end event

type st_msg from statictext within w_pisp094u
integer x = 46
integer y = 68
integer width = 1682
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "~'���� ���� �� ����~' ��ư�� Ŭ���Ͻø� �ӽð��ǹ�ȣ��"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_pisp094u
integer x = 2971
integer y = 88
integer width = 366
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�� ��(&C)"
end type

event clicked;If ib_save Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type cb_1 from commandbutton within w_pisp094u
integer x = 2299
integer y = 88
integer width = 672
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���� ���� �� ����(&P)"
end type

event clicked;Int		i, li_rackqty
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode, &
			ls_applyfrom, ls_kbno, ls_kbsn, &
			ls_kbno_1, ls_kbno_2, ls_kbno_3, ls_errortext
Boolean	lb_error, lb_error_print

// ����ż� �� ������� ��Ȯ���� Ȯ������.
If dw_kbno.RowCount() > 0 Then
	//
Else
	MessageBox("�ӽð��� ����", "������ �� �ִ� �ӽð����� �����ϴ�.")
End If

// ������� ��ȣ���� �� �μ�
If MessageBox("�ӽð��� ����", "�ӽð����� ���� �Ͻðڽ��ϱ�?", Question!, YesNo!, 2) = 2 Then
	Return
End If

ls_applyfrom		= f_pisc_get_date_applydate_close('%', '%', f_pisc_get_date_nowtime())

// ���� ��ȣ�� ��������.
SQLPIS.AutoCommit = False
For i = 1 To dw_kbno.RowCount()
	ls_areacode			= Trim(dw_kbno.GetItemString(i, "AreaCode"))
	ls_divisioncode	= Trim(dw_kbno.GetItemString(i, "DivisionCode"))
	ls_workcenter		= Trim(dw_kbno.GetItemString(i, "WorkCenter"))
	ls_linecode			= Trim(dw_kbno.GetItemString(i, "LineCode"))
	ls_itemcode			= Trim(dw_kbno.GetItemString(i, "ItemCode"))
	li_rackqty			= dw_kbno.GetItemNumber(i, "RackQty")
//	ls_kbno				= Trim(dw_kbno.GetItemString(i, "TempKBSN"))

	Select	TempKBSN
	Into		:ls_kbno
	From		tmstkb
	Where		AreaCode			= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_workcenter		And
				LineCode			= :ls_linecode			And
				ItemCode			= :ls_itemcode
	Using	SQLPIS;

	ls_kbsn	= Right(ls_kbno, 2)
	If f_pisc_get_kbno_next_temp(ls_kbsn, ls_kbsn) Then
		ls_kbno	= Left(ls_kbno, 9) + ls_kbsn
		dw_save_kbno.ReSet()
		If dw_save_kbno.Retrieve(	ls_kbno, &
									ls_areacode,			ls_divisioncode, &
									ls_workcenter,			ls_linecode, &
									ls_itemcode,			ls_applyfrom, &
									'T',						'N', &
									li_rackqty,				g_s_empno) > 0 Then
			If Upper(dw_save_kbno.GetItemString(1, "Error")) = "00" Then
				lb_error	= False
				ls_errortext	= Trim(dw_save_kbno.GetItemString(1, "ErrorText"))
			Else
				lb_error = True
				ls_errortext	= Trim(dw_save_kbno.GetItemString(1, "ErrorText"))
				Exit
			End If
		Else
			lb_error = True
			ls_errortext	= "���� ��ȣ ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
			Exit
		End If
	Else
//		MessageBox("���� ����", "���� ��ȣ�� �� �̻� ������ �� �����ϴ�.")
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("���� ����","���� ��ȣ�� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
											"~r~n~r~n(����)" + &
											"~r~n1. " + ls_errortext, StopSign!)
	Return
Else
	// ������ �ӽð��� ������ ����..�ƹ��͵� ���� ����..
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
End If

dw_print.Modify("datawindow.print.margin.left   = " + String( Integer(Trim(em_1.Text))*100 )  )
//dw_print.Modify("datawindow.print.margin.Right  = " + String( Integer(Trim(Em_Right.Text))*100 ) )
dw_print.Modify("datawindow.print.margin.Top    = " + String( Integer(Trim(em_2.Text))*100 ) )
//dw_print.Modify("datawindow.print.margin.Bottom = " + String( Integer(Trim(Em_Bottom.Text))*100 ) )

// ������ʹ� �μ⸦ ����...
For i = 1 To dw_kbno.RowCount()
	dw_print.ReSet()
	CHOOSE CASE Mod(i, 3)
		CASE 1
			ls_kbno_1	= Trim(dw_kbno.GetItemString(i, "TempKBSN"))
			ls_kbno_2	= ""
			ls_kbno_3	= ""
			If i = dw_kbno.RowCount() Then
				If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
					If dw_print.Print() = 1 Then
						dw_print_save.ReSet()
						If dw_print_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
							If Upper(dw_print_save.GetItemString(1, "Error")) = "00" Then
								lb_error	= False
								ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
							Else
								lb_error = True
								ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
								Exit
							End If
						Else
							lb_error = True
							ls_errortext	= "���� ���� �μ� ���� ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
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
			ls_kbno_2	= Trim(dw_kbno.GetItemString(i, "TempKBSN"))
			ls_kbno_3	= ""
			If i = dw_kbno.RowCount() Then
				If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
					If dw_print.Print() = 1 Then
						dw_print_save.ReSet()
						If dw_print_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
							If Upper(dw_print_save.GetItemString(1, "Error")) = "00" Then
								lb_error	= False
								ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
							Else
								lb_error = True
								ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
								Exit
							End If
						Else
							lb_error = True
							ls_errortext	= "���� �μ� ���� ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
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
			ls_kbno_3	= Trim(dw_kbno.GetItemString(i, "TempKBSN"))
			If dw_print.retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3) > 0 Then
				If dw_print.Print() = 1 Then
					dw_print_save.ReSet()
					If dw_print_save.Retrieve(ls_kbno_1, ls_kbno_2, ls_kbno_3, g_s_empno) > 0 Then
						If Upper(dw_print_save.GetItemString(1, "Error")) = "00" Then
							lb_error	= False
							ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
						Else
							lb_error = True
							ls_errortext	= Trim(dw_print_save.GetItemString(1, "ErrorText"))
							Exit
						End If
					Else
						lb_error = True
						ls_errortext	= "���� �μ� ���� ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
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
	MessageBox("���� ����", "�μ� ����" + &
										"~r~n~r~n���ǹ�ȣ: " + ls_kbno_1 + " " + ls_kbno_2 + " " + ls_kbno_3 + &
										"~r~n~r~n�μ� �߿� ������ �߻��߽��ϴ�.", StopSign!)
	Return
End If

If lb_error Then
	MessageBox("���� ����","���� �μ� ������ �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
										"~r~n~r~n���ǹ�ȣ: " + ls_kbno_1 + " " + ls_kbno_2 + " " + ls_kbno_3 + &
										"~r~n~r~n���� �߿� ������ �߻��߽��ϴ�." + &
											"~r~n~r~n(����)" + &
											"~r~n1. " + ls_errortext, StopSign!)
	Return
Else
//	MessageBox("���� ����", "���� �μ� ������ �����Ͽ����ϴ�.", Information!)
End If

// ������ʹ� Active ��ȯ
dw_save_active.ReSet()
SQLPIS.AutoCommit = False
For i = 1 To dw_kbno.RowCount()
	ls_kbno		= Trim(dw_kbno.GetItemString(i, "TempKBSN"))
	dw_save_active.ReSet()
	If dw_save_active.Retrieve(ls_kbno, 'A', g_s_empno) > 0 Then
		If Upper(dw_save_active.GetItemString(1, "Error")) = "00" Then
			lb_error	= False
			ls_errortext	= Trim(dw_save_active.GetItemString(1, "ErrorText"))
		Else
			lb_error = True
			ls_errortext	= Trim(dw_save_active.GetItemString(1, "ErrorText"))
			Exit
		End If
	Else
		lb_error = True
		ls_errortext	= "Active ���� ��ȯ ����� �õ��Ͽ����� ������ �߻��߽��ϴ�."
		Exit
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("���� ����","Sleeping ���� ��ȯ ����� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
											"~r~n~r~n(����)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("���� ����", "������ �����Ͽ����ϴ�.", Information!)
	cb_2.TriggerEvent(Clicked!)
End If
end event

type dw_save_kbno from datawindow within w_pisp094u
integer x = 379
integer y = 684
integer width = 603
integer height = 288
boolean bringtotop = true
boolean titlebar = true
string title = "���ǹ�ȣ ���� ����"
string dataobject = "d_pisp240u_03_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_7 from groupbox within w_pisp094u
integer x = 9
integer y = 280
integer width = 3374
integer height = 1424
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "������ �ӽð��� ����"
borderstyle borderstyle = stylelowered!
end type

type gb_6 from groupbox within w_pisp094u
integer x = 2258
integer width = 1125
integer height = 252
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisp094u
integer x = 14
integer width = 1728
integer height = 252
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp094u
integer x = 1746
integer width = 507
integer height = 252
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

