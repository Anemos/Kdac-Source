$PBExportHeader$w_pisp093u.srw
$PBExportComments$�������� - ������ ���� ���
forward
global type w_pisp093u from window
end type
type dw_save_1 from datawindow within w_pisp093u
end type
type cb_3 from commandbutton within w_pisp093u
end type
type st_lotno from statictext within w_pisp093u
end type
type uo_code from u_pisc_select_code within w_pisp093u
end type
type uo_shift from u_pisc_select_shift_1 within w_pisp093u
end type
type dw_kbno from u_pisp_kbno_scan within w_pisp093u
end type
type uo_line from u_pisc_select_line within w_pisp093u
end type
type uo_date from u_pisc_date_yesterday within w_pisp093u
end type
type cbx_1 from checkbox within w_pisp093u
end type
type cb_1 from commandbutton within w_pisp093u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp093u
end type
type uo_division from u_pisc_select_division within w_pisp093u
end type
type uo_area from u_pisc_select_area within w_pisp093u
end type
type cb_2 from commandbutton within w_pisp093u
end type
type gb_1 from groupbox within w_pisp093u
end type
type gb_3 from groupbox within w_pisp093u
end type
type dw_save from datawindow within w_pisp093u
end type
type gb_2 from groupbox within w_pisp093u
end type
type dw_nokb from datawindow within w_pisp093u
end type
type gb_4 from groupbox within w_pisp093u
end type
type gb_5 from groupbox within w_pisp093u
end type
type gb_6 from groupbox within w_pisp093u
end type
type gb_7 from groupbox within w_pisp093u
end type
type gb_8 from groupbox within w_pisp093u
end type
type gb_9 from groupbox within w_pisp093u
end type
end forward

global type w_pisp093u from window
integer width = 3890
integer height = 2196
boolean titlebar = true
string title = "������ ����/�԰� ���"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
dw_save_1 dw_save_1
cb_3 cb_3
st_lotno st_lotno
uo_code uo_code
uo_shift uo_shift
dw_kbno dw_kbno
uo_line uo_line
uo_date uo_date
cbx_1 cbx_1
cb_1 cb_1
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
cb_2 cb_2
gb_1 gb_1
gb_3 gb_3
dw_save dw_save
gb_2 gb_2
dw_nokb dw_nokb
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
gb_7 gb_7
gb_8 gb_8
gb_9 gb_9
end type
global w_pisp093u w_pisp093u

type variables
Boolean		ib_open, ib_check, ib_save
String		is_plandate
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_retrieve ()
public subroutine wf_get_lotno ()
end prototypes

event ue_postopen;dw_nokb.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
dw_save_1.SetTransObject(SQLPIS)

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

f_pisc_retrieve_dddw_shift(uo_shift.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										False, &
										uo_shift.is_uo_shiftcode, &
										uo_shift.is_uo_shiftname)

f_pisc_retrieve_dddw_code(uo_code.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'PNOKB', &
										'%', &
										False, &
										uo_code.is_uo_codegroup, &
										uo_code.is_uo_codeid, &
										uo_code.is_uo_codegroupname, &
										uo_code.is_uo_codename)

// �ѹ� ��ȸ�� ����..
// �ٵ� ó�� �����ϴ� ��쿡�� �޼����� ����� ����..����
dw_nokb.Retrieve(	uo_date.is_uo_date, &
						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
						uo_code.is_uo_codegroup,			uo_code.is_uo_codeid)

wf_get_lotno()

ib_open = True
end event

public subroutine wf_retrieve ();ib_check			= False
cb_2.Enabled	= False
cbx_1.Checked	= False

dw_nokb.ReSet()
dw_save.ReSet()
dw_save_1.ReSet()

If dw_nokb.Retrieve(	uo_date.is_uo_date, &
							uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
							uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
							uo_code.is_uo_codegroup,			uo_code.is_uo_codeid) > 0 Then
Else
//	MessageBox("������ ����/�԰� ���", "������ ����/�԰� �̷��� �������� �ʽ��ϴ�.")
End If
end subroutine

public subroutine wf_get_lotno ();//Time		lt_shifttime
//DateTime	ldt_lotdate
//String	ls_lotno

//If uo_shift.is_uo_shiftcode = 'A' Then
//	lt_shifttime	= Time("09:00:00")
//Else
//	lt_shifttime	= Time("21:00:00")
//End If

//ldt_lotdate	= DateTime(Date(uo_date.is_uo_date), lt_shifttime)

st_lotno.Text	= f_pisc_get_lotno(uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_date.is_uo_date, &
											uo_shift.is_uo_shiftcode)


end subroutine

on w_pisp093u.create
this.dw_save_1=create dw_save_1
this.cb_3=create cb_3
this.st_lotno=create st_lotno
this.uo_code=create uo_code
this.uo_shift=create uo_shift
this.dw_kbno=create dw_kbno
this.uo_line=create uo_line
this.uo_date=create uo_date
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_2=create cb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_save=create dw_save
this.gb_2=create gb_2
this.dw_nokb=create dw_nokb
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_7=create gb_7
this.gb_8=create gb_8
this.gb_9=create gb_9
this.Control[]={this.dw_save_1,&
this.cb_3,&
this.st_lotno,&
this.uo_code,&
this.uo_shift,&
this.dw_kbno,&
this.uo_line,&
this.uo_date,&
this.cbx_1,&
this.cb_1,&
this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.cb_2,&
this.gb_1,&
this.gb_3,&
this.dw_save,&
this.gb_2,&
this.dw_nokb,&
this.gb_4,&
this.gb_5,&
this.gb_6,&
this.gb_7,&
this.gb_8,&
this.gb_9}
end on

on w_pisp093u.destroy
destroy(this.dw_save_1)
destroy(this.cb_3)
destroy(this.st_lotno)
destroy(this.uo_code)
destroy(this.uo_shift)
destroy(this.dw_kbno)
destroy(this.uo_line)
destroy(this.uo_date)
destroy(this.cbx_1)
destroy(this.cb_1)
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_save)
destroy(this.gb_2)
destroy(this.dw_nokb)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.gb_9)
end on

event open;String		ls_size

//Pareant Window�� �߾����� Window�� �̵���Ű�� ���Ͽ� Parent Window�� X,Y,Width,Height ���� ���Ѵ�.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]
is_plandate			= istr_parms.string_arg[2]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type dw_save_1 from datawindow within w_pisp093u
integer x = 1595
integer y = 1296
integer width = 955
integer height = 448
boolean bringtotop = true
boolean titlebar = true
string title = "������ ����/�԰� ��� ���"
string dataobject = "d_pisp093u_03_u"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type cb_3 from commandbutton within w_pisp093u
integer x = 3273
integer y = 308
integer width = 517
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��  ��(&C)"
end type

event clicked;If ib_save Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type st_lotno from statictext within w_pisp093u
integer x = 398
integer y = 296
integer width = 384
integer height = 104
integer textsize = -18
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 128
long backcolor = 12632256
string text = "LotNo"
boolean focusrectangle = false
end type

type uo_code from u_pisc_select_code within w_pisp093u
integer x = 864
integer y = 308
end type

on uo_code.destroy
call u_pisc_select_code::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
//	wf_retrieve()
End If
end event

type uo_shift from u_pisc_select_shift_1 within w_pisp093u
integer x = 59
integer y = 304
end type

on uo_shift.destroy
call u_pisc_select_shift_1::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_get_lotno()
//	wf_reset()
//	wf_retrieve()
End If
end event

type dw_kbno from u_pisp_kbno_scan within w_pisp093u
integer x = 1669
integer y = 272
integer taborder = 0
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

event itemchanged;Int		li_count, li_kb_rackqty
String	ls_kbno, ls_applydate_close, &
			ls_kb_areacode, ls_kb_divisioncode, ls_kb_workcenter, ls_kb_linecode, &
			ls_kb_itemcode, ls_kb_kbstatuscode, ls_kb_kbactivegubun, ls_stockgubun, &
			ls_errortext
decimal	ld_unitcost
Boolean	lb_error

ls_kbno	= Data

If Len(ls_kbno) <> 11 Then
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���","���ǹ�ȣ�� 11�ڸ� �Դϴ�.~r~n��Ȯ�� ���� ��ȣ�� �Է��Ͻʽÿ�.")
	GoTo Scrip_Out
End If

ls_applydate_close	= f_pisc_get_date_applydate_close(uo_area.is_uo_areacode, &
																		uo_division.is_uo_divisioncode, &
																		f_pisc_get_date_nowtime())
																		
If Left(uo_date.is_uo_date, 7) < Left(ls_applydate_close, 7) Then
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "�������� ������ ����/�԰� ����� �Ұ����մϴ�.", StopSign!)
	GoTo Scrip_Out
End If

If uo_date.is_uo_date > ls_applydate_close Then
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "������ ���� ������ ������ ����/�԰� ����� �Ұ����մϴ�.", StopSign!)
	GoTo Scrip_Out
End If

li_count	= 0
Select	Count(A.KBNo)
Into		:li_count
From		tplanrelease		A
Where		A.PlanDate			= :uo_date.is_uo_date	And
			A.KBNo				= :ls_kbno					And
			A.ReleaseGubun		= 'U'							And
			A.PrdFlag			= 'N'
Using	SQLPIS;

If li_count > 0 Then
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ �����Ͻ� ���ڿ� ���ؼ� ��ϵ� �����Դϴ�." + &
									"~r~n~r~n���ǹ�ȣ�� �ٽ� �ѹ� Ȯ���Ͽ� �ֽʽÿ�.")
	GoTo Scrip_Out
End If

li_count	= 0
Select	Count(A.KBNo)
Into		:li_count
From		tkbhis		A
Where		A.KBNo				= :ls_kbno					And
			A.KBReleaseDate	= :uo_date.is_uo_date
Using	SQLPIS;

If li_count > 0 Then
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ �����Ͻ� ���ڿ� �������ø� �����ߴ� �����Դϴ�." + &
									"~r~n~r~n���� ������ �Ϸ翡 �ѹ��� �������ð� �����մϴ�." + &
									"~r~n~r~n���ǹ�ȣ�� �ٽ� �ѹ� Ȯ���Ͽ� �ֽʽÿ�.")
	GoTo Scrip_Out
End If

li_count	= 0
Select	Count(A.KBNo),
			A.AreaCode,
			A.DivisionCode,
			A.WorkCenter,
			A.LineCode,
			A.ItemCode,
			A.KBStatusCode,
			A.KBActiveGubun,
			A.RackQty,
			B.StockGubun
Into		:li_count,
			:ls_kb_areacode,
			:ls_kb_divisioncode,
			:ls_kb_workcenter,
			:ls_kb_linecode,
			:ls_kb_itemcode,
			:ls_kb_kbstatuscode,
			:ls_kb_kbactivegubun,
			:li_kb_rackqty,
			:ls_stockgubun
From		tkb		A,
			tmstkb	B
Where		A.KBNo				= :ls_kbno			And
			A.AreaCode			= B.AreaCode		And
			A.DivisionCode		= B.DivisionCode	And
			A.WorkCenter		= B.WorkCenter		And
			A.LineCode			= B.LineCode		And
			A.ItemCode			= B.ItemCode		And
			B.PrdStopGubun		= 'N'
Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode, 
			A.KBStatusCode, A.KBActiveGubun, A.RackQty, B.StockGubun
Using	SQLPIS;

If li_count > 0 Then
	//
Else
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ ������ ����/�԰� ����� ������ �� �����ϴ�." + &
									"~r~n~r~n���ǹ�ȣ �� ���Ǹ����͸� �ٽ� �ѹ� Ȯ���Ͽ� �ֽʽÿ�.")
	GoTo Scrip_Out
End If

If uo_area.is_uo_areacode				= ls_kb_areacode		And &
	uo_division.is_uo_divisioncode	= ls_kb_divisioncode	And &
	uo_workcenter.is_uo_workcenter	= ls_kb_workcenter	And &
	uo_line.is_uo_linecode				= ls_kb_linecode	Then
	//
Else
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ ������ ����/�԰� ����� ������ �� �����ϴ�." + &
									"~r~n~r~n�Է��Ͻ� ������ ���õ� ������ ������ �ƴմϴ�.")
	GoTo Scrip_Out
End If

If ls_kb_kbstatuscode = 'F' Then
	//
Else
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ ������ ����/�԰� ����� ������ �� �����ϴ�." + &
									"~r~n~r~n�Է��Ͻ� ������ ȸ�� ���°� �ƴմϴ�.")
	GoTo Scrip_Out
End If

If ls_kb_kbactivegubun = 'A' Then
	//
Else
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ ������ ����/�԰� ����� ������ �� �����ϴ�." + &
									"~r~n~r~n�Է��Ͻ� ������ Active ���°� �ƴմϴ�.")
	GoTo Scrip_Out
End If

// BOM �� �ִ��� Ȯ��
li_count	= 0
Select	Count(A.BOMPItemNo)
Into		:li_count
From		tmstbom	A
Where		A.AreaCode			= :ls_kb_areacode			And
			A.DivisionCode		= :ls_kb_divisioncode	And
			A.BOMPItemNo		= :ls_kb_itemcode
Using	SQLPIS;

If li_count > 0 Then
	//
Else
	f_pisc_beep()
	MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ ǰ���� ������ ����/�԰� ����� ������ �� �����ϴ�." + &
									"~r~n~r~nBOM �� ��ϵǾ� ���� ���� ǰ���Դϴ�.")
	GoTo Scrip_Out
End If

If ls_stockgubun = 'B' Then
	// ���� ȸ��ǰ�� �ܰ� Ȯ���� �ʿ䰡 ����.
Else
	// �ܰ��� �ִ��� Ȯ��
	ld_unitcost	= 0
	Select	UnitCost
	Into		:ld_unitcost
	From		tmstitemcost	A
	Where		A.AreaCode			= :ls_kb_areacode			And
				A.DivisionCode		= :ls_kb_divisioncode	And
				A.ItemCode			= :ls_kb_itemcode
	Using	SQLPIS;
	
	If ld_unitcost > 0 Then
		//
	Else
		f_pisc_beep()
		MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ ǰ���� ������ ����/�԰� ����� ������ �� �����ϴ�." + &
										"~r~n~r~n�ܰ��� ��ϵǾ� ���� ���� ǰ���Դϴ�.")
		GoTo Scrip_Out
	End If
End If

If MessageBox("������ ����/�԰� ���", "�Է��Ͻ� ������ ������ ����/�԰� ��� ó�� �Ͻðڽ��ϱ�?", &
					Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False
dw_save.ReSet()
If dw_save.Retrieve(	uo_date.is_uo_date, 			Trim(st_lotno.Text),	&
							ls_kbno, &
							uo_code.is_uo_codegroup,	uo_code.is_uo_codeid, &
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
	ls_errortext	= "������ ����/�԰� ����� �õ��Ͽ����� ������ �߻��߽��ϴ�."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("������ ����/�԰� ���","������ ����/�԰� ����� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
											"~r~n~r~n(����)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	MessageBox("������ ����/�԰� ���", "������ ����/�԰� ����� �����Ͽ����ϴ�.", Information!)
	wf_retrieve()
End If

Scrip_Out:

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type uo_line from u_pisc_select_line within w_pisp093u
integer x = 2619
integer y = 68
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type uo_date from u_pisc_date_yesterday within w_pisp093u
integer x = 50
integer y = 68
end type

event ue_select;String	ls_applydate_close

If ib_open Then
//	ls_applydate_close	= f_pisc_get_date_applydate_close(uo_area.is_uo_areacode, &
//																			uo_division.is_uo_divisioncode, &
//																			f_pisc_get_date_nowtime())
																			
//	If Left(uo_date.is_uo_date, 7) < Left(ls_applydate_close, 7) Then
//		MessageBox("������ ����/�԰� ���", "�������� ������ ����/�԰� ����� �Ұ����մϴ�.", StopSign!)
//		Return
//	End If
//
//	If uo_date.is_uo_date > ls_applydate_close Then
//		MessageBox("������ ����/�԰� ���", "�̷� ������ ������ ����/�԰� ����� �Ұ����մϴ�.", StopSign!)
//		Return
//	End If
	
	wf_get_lotno()
	wf_retrieve()
End If
end event

on uo_date.destroy
call u_pisc_date_yesterday::destroy
end on

type cbx_1 from checkbox within w_pisp093u
integer x = 2834
integer y = 304
integer width = 352
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "��ü����"
borderstyle borderstyle = stylelowered!
end type

event clicked;Int	i, li_checkcount

If dw_nokb.RowCount() > 0 Then
	If cbx_1.Checked = False Then
		li_checkcount		= 0
		For i = 1 To dw_nokb.RowCount()
			If Trim(dw_nokb.GetItemString(i, "KBStatusCode")) = "C" Or Trim(dw_nokb.GetItemString(i, "KBStatusCode")) = "D" Then
				dw_nokb.SetItem(i, "CheckFlag", "N")
			End If
		Next
	Else
		For i = 1 To dw_nokb.RowCount()
			If Trim(dw_nokb.GetItemString(i, "KBStatusCode")) = "C" Or Trim(dw_nokb.GetItemString(i, "KBStatusCode")) = "D" Then
				dw_nokb.SetItem(i, "CheckFlag", "Y")
				li_checkcount		= li_checkcount + 1
			End If
		Next
	End If
End If

If li_checkcount > 0 Then
	ib_check		= True
	cb_2.Enabled	= True
	cbx_1.Checked	= True
Else
	ib_check		= False
	cb_2.Enabled	= False
	cbx_1.Checked	= False
End If
end event

type cb_1 from commandbutton within w_pisp093u
integer x = 3273
integer y = 64
integer width = 517
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�������̷�(&R)"
end type

event clicked;wf_retrieve()
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp093u
integer x = 1929
integer y = 68
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
	wf_retrieve()
End If
end event

type uo_division from u_pisc_select_division within w_pisp093u
integer x = 1307
integer y = 68
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_nokb.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
	dw_save_1.SetTransObject(SQLPIS)
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
	
	f_pisc_retrieve_dddw_shift(uo_shift.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											False, &
											uo_shift.is_uo_shiftcode, &
											uo_shift.is_uo_shiftname)
	
	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PNOKB', &
											'%', &
											False, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
	wf_get_lotno()
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp093u
integer x = 814
integer y = 68
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_nokb.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
	dw_save_1.SetTransObject(SQLPIS)
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
	
	f_pisc_retrieve_dddw_shift(uo_shift.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											False, &
											uo_shift.is_uo_shiftcode, &
											uo_shift.is_uo_shiftname)
	
	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PNOKB', &
											'%', &
											False, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
	wf_get_lotno()
	wf_retrieve()
End If
end event

type cb_2 from commandbutton within w_pisp093u
integer x = 3273
integer y = 188
integer width = 517
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string text = "��� ���(&D)"
end type

event clicked;Int		i, li_cycleorder, li_releaseorder, li_kbreleaseseq
String	ls_prddate, ls_kbno, ls_kbreleasedate, ls_errortext
Boolean	lb_error

If MessageBox("������ ����/�԰� ���", "������ ������ ������ ����/�԰� ����� ����Ͻðڽ��ϱ�?" + &
							"~r~n~r~n(����)" + &
							"~r~n���� �����޿� ������ ����/�԰� ����� ������ ����ϴ� ��쿡��" + &
							"~r~n�ý��� �������� �������Ƿ� ���� ������ ������ �谨�˴ϴ�.", &
							Question!, YesNo!, 2) = 2 Then
	Return
End If

ls_prddate	= uo_date.is_uo_date

SQLPIS.AutoCommit = False

If dw_nokb.RowCount() > 0 Then
	For i = 1 To dw_nokb.RowCount()
		If Trim(dw_nokb.GetItemString(i, "CheckFlag")) = "Y" Then
			ls_kbno				= Trim(dw_nokb.GetItemString(i, "KBNo"))
			ls_kbreleasedate	= Trim(dw_nokb.GetItemString(i, "KBReleaseDate"))
			li_kbreleaseseq	= dw_nokb.GetItemNumber(i, "KBReleaseSeq")
			dw_save_1.ReSet()
			If dw_save_1.Retrieve(	ls_prddate, &
											ls_kbno,					ls_kbreleasedate, &
											li_kbreleaseseq, 		g_s_empno) > 0 Then
				If Upper(dw_save_1.GetItemString(1, "Error")) = "00" Then
					lb_error	= False
					ls_errortext	= Trim(dw_save_1.GetItemString(1, "ErrorText"))
				Else
					lb_error = True
					ls_errortext	= Trim(dw_save_1.GetItemString(1, "ErrorText"))
					Exit
				End If
			Else
				lb_error = True
				ls_errortext	= "������ ����/�԰� ��� ��Ҹ� �õ��Ͽ����� ������ �߻��߽��ϴ�."
				Exit
			End If
		End If
	Next
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("������ ����/�԰� ���","���ǹ�ȣ : " + ls_kbno + " �� ó���ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
											"~r~n~r~n(����)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	MessageBox("������ ����/�԰� ���", "������ ����/�԰� ��� ��Ҹ� �����Ͽ����ϴ�.", Information!)
	wf_retrieve()
End If
end event

type gb_1 from groupbox within w_pisp093u
integer x = 14
integer width = 759
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp093u
integer x = 2793
integer y = 200
integer width = 425
integer height = 248
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "��Ұ���"
borderstyle borderstyle = stylelowered!
end type

type dw_save from datawindow within w_pisp093u
integer x = 1595
integer y = 812
integer width = 955
integer height = 448
boolean bringtotop = true
boolean titlebar = true
string title = "������ ����/�԰� ���"
string dataobject = "d_pisp093u_02_u"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_2 from groupbox within w_pisp093u
integer x = 3223
integer width = 617
integer height = 448
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

type dw_nokb from datawindow within w_pisp093u
event ue_check ( integer fi_row )
integer x = 14
integer y = 452
integer width = 3826
integer height = 1628
string title = "none"
string dataobject = "d_pisp093u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_check;Int		i, li_checkcount, li_possiblecount
String	ls_checkflag

AcceptText()

If Trim(GetItemString(fi_row, "kbstatuscode")) = "C" Or Trim(GetItemString(fi_row, "kbstatuscode")) = "D" Then
	//
Else
	SetItem(fi_row, "CheckFlag", "N")
	Return
End If

For i = 1 To RowCount()
	If Trim(GetItemString(i, "kbstatuscode")) = "C" Or Trim(GetItemString(i, "kbstatuscode")) = "D" Then
		li_possiblecount	= li_possiblecount + 1
	End If
	
	ls_checkflag	= Trim(GetItemString(i, "CheckFlag"))
	If ls_checkflag = "Y" Then
		li_checkcount = li_checkcount + 1
	End If
Next

If li_checkcount > 0 Then
	ib_check		= True
	cb_2.Enabled	= True
	If li_checkcount = li_possiblecount Then
		cbx_1.Checked	= True
	Else
		cbx_1.Checked	= False
	End If
Else	
	ib_check		= False
	cb_2.Enabled	= False
	cbx_1.Checked	= False
End If

//dw_kbno.Reset()
//dw_kbno.InsertRow(1)
//dw_kbno.SetColumn(1)
//dw_kbno.SetRow(1)
//dw_kbno.SetFocus()
//
end event

event constructor;//Visible	= False
end event

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

event itemchanged;
AcceptText()

If row > 0 Then
	If Upper(string(dwo.name)) = "CHECKFLAG" Then
		Post Event ue_check(row)
	End If
End If
end event

type gb_4 from groupbox within w_pisp093u
integer x = 777
integer width = 1115
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_5 from groupbox within w_pisp093u
integer x = 1897
integer width = 1321
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_6 from groupbox within w_pisp093u
integer x = 1618
integer y = 200
integer width = 1170
integer height = 248
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "���� Scanning"
borderstyle borderstyle = stylelowered!
end type

type gb_7 from groupbox within w_pisp093u
integer x = 823
integer y = 200
integer width = 791
integer height = 248
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "������ ���� ����"
borderstyle borderstyle = stylelowered!
end type

type gb_8 from groupbox within w_pisp093u
integer x = 14
integer y = 200
integer width = 338
integer height = 248
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "��/��"
borderstyle borderstyle = stylelowered!
end type

type gb_9 from groupbox within w_pisp093u
integer x = 357
integer y = 200
integer width = 462
integer height = 248
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long backcolor = 12632256
string text = "Lot No."
borderstyle borderstyle = stylelowered!
end type

