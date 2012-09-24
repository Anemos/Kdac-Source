$PBExportHeader$w_pisp240u_back.srw
$PBExportComments$���� ��ȣ ����
forward
global type w_pisp240u_back from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp240u_back
end type
type uo_area from u_pisc_select_area within w_pisp240u_back
end type
type uo_division from u_pisc_select_division within w_pisp240u_back
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp240u_back
end type
type uo_line from u_pisc_select_line within w_pisp240u_back
end type
type uo_month from u_pisc_date_scroll_month within w_pisp240u_back
end type
type cb_1 from commandbutton within w_pisp240u_back
end type
type cb_2 from commandbutton within w_pisp240u_back
end type
type dw_save from datawindow within w_pisp240u_back
end type
type st_h_bar from uo_xc_splitbar within w_pisp240u_back
end type
type dw_detail from datawindow within w_pisp240u_back
end type
type cb_3 from commandbutton within w_pisp240u_back
end type
type gb_1 from groupbox within w_pisp240u_back
end type
type gb_2 from groupbox within w_pisp240u_back
end type
type gb_4 from groupbox within w_pisp240u_back
end type
type gb_5 from groupbox within w_pisp240u_back
end type
end forward

global type w_pisp240u_back from w_ipis_sheet01
integer width = 4681
integer height = 2344
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
uo_month uo_month
cb_1 cb_1
cb_2 cb_2
dw_save dw_save
st_h_bar st_h_bar
dw_detail dw_detail
cb_3 cb_3
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
end type
global w_pisp240u_back w_pisp240u_back

type variables
Boolean	ib_open
end variables

on w_pisp240u_back.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.uo_month=create uo_month
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_save=create dw_save
this.st_h_bar=create st_h_bar
this.dw_detail=create dw_detail
this.cb_3=create cb_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_5=create gb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.uo_month
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.dw_save
this.Control[iCurrent+10]=this.st_h_bar
this.Control[iCurrent+11]=this.dw_detail
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.gb_4
this.Control[iCurrent+16]=this.gb_5
end on

on w_pisp240u_back.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.uo_month)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_save)
destroy(this.st_h_bar)
destroy(this.dw_detail)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
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

cb_1.Enabled	= m_frame.m_action.m_save.Enabled
cb_3.Enabled	= m_frame.m_action.m_save.Enabled

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
										
//f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
//										uo_area.is_uo_areacode, &
//										uo_division.is_uo_divisioncode, &
//										uo_workcenter.is_uo_workcenter, &
//										uo_line.is_uo_linecode, &
//										'%', &
//										True, &
//										uo_item.is_uo_itemcode, &
//										uo_item.is_uo_itemname)
ib_open = True
end event

event ue_retrieve;
iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_month.is_uo_month, &
						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
	uo_status.st_message.text =  "���� ��ȣ ���� ����" //+ f_message("����� ����Ÿ�� �����ϴ�.")
Else
	uo_status.st_message.text =  "���� ��ȣ ���� ������ �������� �ʽ��ϴ�" //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("���� ��ȣ ����", "���� ��ȣ ���� ������ �������� �ʽ��ϴ�")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
dw_save.ReSet()
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp240u_back
integer y = 2144
end type

type dw_1 from u_vi_std_datawindow within w_pisp240u_back
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 184
integer width = 1458
integer height = 1924
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp240u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event clicked;//

end event

event rowfocuschanged;//
If CurrentRow > 0 Then
	SelectRow(0,FALSE)
	SelectRow(currentrow,TRUE)
	
	dw_detail.ReSet()
	dw_detail.InsertRow(0)
	dw_detail.SetItem(1, "NormalKBCount", 0)
	dw_detail.SetItem(1, "TempKBCount", 0)
	dw_detail.SetItem(1, "TempKBRackQty", 0)
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_pisp240u_back
integer x = 709
integer y = 68
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

//	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											uo_workcenter.is_uo_workcenter, &
//											uo_line.is_uo_linecode, &
//											'%', &
//											True, &
//											uo_item.is_uo_itemcode, &
//											uo_item.is_uo_itemname)
End If

end event

type uo_division from u_pisc_select_division within w_pisp240u_back
integer x = 1207
integer y = 68
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

//	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											uo_workcenter.is_uo_workcenter, &
//											uo_line.is_uo_linecode, &
//											'%', &
//											True, &
//											uo_item.is_uo_itemcode, &
//											uo_item.is_uo_itemname)
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp240u_back
integer x = 1806
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

//	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											uo_workcenter.is_uo_workcenter, &
//											uo_line.is_uo_linecode, &
//											'%', &
//											True, &
//											uo_item.is_uo_itemcode, &
//											uo_item.is_uo_itemname)
End If

end event

type uo_line from u_pisc_select_line within w_pisp240u_back
integer x = 2482
integer y = 68
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

//	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
//											uo_area.is_uo_areacode, &
//											uo_division.is_uo_divisioncode, &
//											uo_workcenter.is_uo_workcenter, &
//											uo_line.is_uo_linecode, &
//											'%', &
//											True, &
//											uo_item.is_uo_itemcode, &
//											uo_item.is_uo_itemname)
End If

end event

type uo_month from u_pisc_date_scroll_month within w_pisp240u_back
integer x = 46
integer y = 68
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

type cb_1 from commandbutton within w_pisp240u_back
integer x = 3113
integer y = 56
integer width = 443
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���� ����(&C)"
end type

event clicked;Int		i, li_row, li_normalkbrackqty, li_tempkbrackqty, li_normalkbcount, li_tempkbcount
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode, &
			ls_applyfrom, ls_normalkbsn, ls_tempkbsn, ls_kbsn, ls_errortext
Boolean	lb_error

dw_detail.AcceptText()

li_row = dw_1.GetRow()

If li_row > 0 Then
	//
Else
	uo_status.st_message.text =  "���� ��ȣ�� ������ ��ǰ�� �����Ͽ� �ֽʽÿ�." //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("���� ��ȣ ����", "���� ��ȣ�� ������ ��ǰ�� �����Ͽ� �ֽʽÿ�.")
	Return
End If

ls_areacode				= Trim(dw_1.GetItemString(li_row, "AreaCode"))
ls_divisioncode		= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
ls_workcenter			= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
ls_linecode				= Trim(dw_1.GetItemString(li_row, "LineCode"))
ls_itemcode				= Trim(dw_1.GetItemString(li_row, "ItemCode"))
//ls_applyfrom			= Trim(dw_1.GetItemString(li_row, "ApplyFrom"))
//li_normalkbrackqty	= dw_1.GetItemNumber(li_row, "RackQty")
//ls_normalkbsn			= Trim(dw_1.GetItemString(li_row, "NormalKBSN"))
//ls_tempkbsn				= Trim(dw_1.GetItemString(li_row, "TempKBSN"))

Select	RackQty,
			NormalKBSN,
			TempKBSN
Into		:li_normalkbrackqty,
			:ls_normalkbsn,
			:ls_tempkbsn
From		tmstkb
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode
Using	SQLPIS;

li_normalkbcount		= dw_detail.GetItemNumber(1, "NormalKBCount")
li_tempkbcount			= dw_detail.GetItemNumber(1, "TempKBCount")
li_tempkbrackqty		= dw_detail.GetItemNumber(1, "TempKBRackQty")

ls_applyfrom	= f_pisc_get_date_applydate_close('%', '%', f_pisc_get_date_nowtime())

// � ���� ������ �� Ȯ�����Ŀ�
// Ȯ�� �޼����� ������..
If li_normalkbcount > 0 Then
	If li_tempkbcount > 0 Then
		If li_tempkbrackqty > 0 Then
			If MessageBox("���� ��ȣ ����", "���԰��� �� �ӽð����� �����Ͻðڽ��ϱ�?", &
														Question!, YesNo!, 2) = 2 Then
				Return
			End If
		Else
			If MessageBox("���� ��ȣ ����", "���԰��� �� �ӽð����� ���ÿ� �����Ͻ÷��� �մϴ�." + &
															"~r~n~r~n�׷���, �ӽð����� ������� ��Ȯ���� �ʾ� ���԰��Ǹ� �����˴ϴ�." + &
															"~r~n~r~n���԰��Ǹ� �����Ͻðڽ��ϱ�?", &
														Question!, YesNo!, 2) = 2 Then
				Return
			End If
		End If
	Else
		If MessageBox("���� ��ȣ ����", "���԰����� �����Ͻðڽ��ϱ�?", &
													Question!, YesNo!, 2) = 2 Then
			Return
		End If		
	End If
Else
	If li_tempkbcount > 0 Then
		If li_tempkbrackqty > 0 Then
			If MessageBox("���� ��ȣ ����", "�ӽð����� �����Ͻðڽ��ϱ�?", &
														Question!, YesNo!, 2) = 2 Then
				Return
			End If
		Else
			uo_status.st_message.text =  "������ �ӽð����� ������� ��Ȯ�� ����Ͻʽÿ�." //+ f_message("����� ����Ÿ�� �����ϴ�.")
			MessageBox("���� ��ȣ ����", "������ �ӽð����� ������� ��Ȯ�� ����Ͻʽÿ�.")
			Return
		End If
	Else
		uo_status.st_message.text =  "������ ���� �ż� �� ������� ��Ȯ�� ����Ͻʽÿ�." //+ f_message("����� ����Ÿ�� �����ϴ�.")
		MessageBox("���� ��ȣ ����", "������ ���� �ż� �� ������� ��Ȯ�� ����Ͻʽÿ�.")
		Return
	End If
End If

// ��~~~��
// ���ǹ�ȣ�� ��������..
If li_normalkbcount > 0 Then
	If li_tempkbcount > 0 Then
		If li_tempkbrackqty > 0 Then
			// ���� �� �ӽ� ���� ���� ����
				// �ϴ� ���� ���� ����
			lb_error	= False
			SQLPIS.AutoCommit = False
			For i = 1 To li_normalkbcount
				ls_kbsn	= Right(ls_normalkbsn, 3)
				If f_pisc_get_kbno_next_normal(ls_kbsn, ls_kbsn) Then
					ls_normalkbsn	= Left(ls_normalkbsn, 8) + ls_kbsn
//messagebox("", ls_normalkbsn)
					dw_save.ReSet()
					If dw_save.Retrieve(	ls_normalkbsn, &
												ls_areacode,			ls_divisioncode, &
												ls_workcenter,			ls_linecode, &
												ls_itemcode,			ls_applyfrom, &
												'N',						'N', &
												li_normalkbrackqty,	g_s_empno) > 0 Then
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
						ls_errortext	= "���԰��� ��ȣ ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
						Exit
					End If
				End If
			Next			
			If lb_error Then
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("���� ��ȣ ����","���԰��� ��ȣ�� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
														"~r~n~r~n(����)" + &
														"~r~n1. " + ls_errortext, StopSign!)
				Return
			Else
				// ������ �ӽð��� ������ ����..�ƹ��͵� ���� ����..
			End If

				// ���� ���ʹ� �ӽð��� ����
//			lb_error	= False
//			SQLPIS.AutoCommit = False
			i = 1
			For i = 1 To li_tempkbcount
				ls_kbsn	= Right(ls_tempkbsn, 2)
				If f_pisc_get_kbno_next_temp(ls_kbsn, ls_kbsn) Then
					ls_tempkbsn	= Left(ls_tempkbsn, 9) + ls_kbsn
//		messagebox("", ls_tempkbsn)
					dw_save.ReSet()
					If dw_save.Retrieve(	ls_tempkbsn, &
												ls_areacode,			ls_divisioncode, &
												ls_workcenter,			ls_linecode, &
												ls_itemcode,			ls_applyfrom, &
												'T',						'N', &
												li_tempkbrackqty,		g_s_empno) > 0 Then
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
						ls_errortext	= "�ӽð��� ��ȣ ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
						Exit
					End If
				End If
			Next
			
			If lb_error Then
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("���� ��ȣ ����","�ӽð��� ��ȣ�� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
														"~r~n~r~n(����)" + &
														"~r~n1. " + ls_errortext, StopSign!)
			Else
				Commit Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("���� ��ȣ ����", "���԰��� �� �ӽð��� ��ȣ�� �����Ͽ����ϴ�.", Information!)
				iw_this.TriggerEvent("ue_retrieve")
				If dw_1.RowCount() >= li_row Then
					dw_1.SetRow(li_row)
					dw_1.Trigger Event RowFocusChanged(li_row)
					dw_1.ScrollToRow(li_row)
				End If
			End If
		Else
			// ���� ���Ǹ� ���� => �ӽð��ǵ� �����Ϸ��� ������, �ӽð��� ������� 0 ���� �۴�.
			lb_error	= False
			SQLPIS.AutoCommit = False
			For i = 1 To li_normalkbcount
				ls_kbsn	= Right(ls_normalkbsn, 3)
				If f_pisc_get_kbno_next_normal(ls_kbsn, ls_kbsn) Then
					ls_normalkbsn	= Left(ls_normalkbsn, 8) + ls_kbsn
					dw_save.ReSet()
					If dw_save.Retrieve(	ls_normalkbsn, &
												ls_areacode,			ls_divisioncode, &
												ls_workcenter,			ls_linecode, &
												ls_itemcode,			ls_applyfrom, &
												'N',						'N', &
												li_normalkbrackqty,	g_s_empno) > 0 Then
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
						ls_errortext	= "���԰��� ��ȣ ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
						Exit
					End If
				End If
			Next
			
			If lb_error Then
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("���� ��ȣ ����","���԰��� ��ȣ�� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
														"~r~n~r~n(����)" + &
														"~r~n1. " + ls_errortext, StopSign!)
			Else
				Commit Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("���� ��ȣ ����", "���԰��� ��ȣ�� �����Ͽ����ϴ�.", Information!)
				iw_this.TriggerEvent("ue_retrieve")
				If dw_1.RowCount() >= li_row Then
					dw_1.SetRow(li_row)
					dw_1.Trigger Event RowFocusChanged(li_row)
					dw_1.ScrollToRow(li_row)
				End If
			End If
		End If
	Else
		//���� ���Ǹ� ����
		lb_error	= False
		SQLPIS.AutoCommit = False
		For i = 1 To li_normalkbcount
			ls_kbsn	= Right(ls_normalkbsn, 3)
			If f_pisc_get_kbno_next_normal(ls_kbsn, ls_kbsn) Then
				ls_normalkbsn	= Left(ls_normalkbsn, 8) + ls_kbsn
				dw_save.ReSet()
				If dw_save.Retrieve(	ls_normalkbsn, &
											ls_areacode,			ls_divisioncode, &
											ls_workcenter,			ls_linecode, &
											ls_itemcode,			ls_applyfrom, &
											'N',						'N', &
											li_normalkbrackqty,	g_s_empno) > 0 Then
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
					ls_errortext	= "���԰��� ��ȣ ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
					Exit
				End If
			End If
		Next
		
		If lb_error Then
			RollBack Using SQLPIS;
			SQLPIS.AutoCommit = True
			MessageBox("���� ��ȣ ����","���԰��� ��ȣ�� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
													"~r~n~r~n(����)" + &
													"~r~n1. " + ls_errortext, StopSign!)
		Else
			Commit Using SQLPIS;
			SQLPIS.AutoCommit = True
			MessageBox("���� ��ȣ ����", "���԰��� ��ȣ�� �����Ͽ����ϴ�.", Information!)
			iw_this.TriggerEvent("ue_retrieve")
			If dw_1.RowCount() >= li_row Then
				dw_1.SetRow(li_row)
				dw_1.Trigger Event RowFocusChanged(li_row)
				dw_1.ScrollToRow(li_row)
			End If
		End If
	End If
Else
	If li_tempkbcount > 0 Then
		If li_tempkbrackqty > 0 Then
			// �ӽð��Ǹ� ����
			lb_error	= False
			SQLPIS.AutoCommit = False
			For i = 1 To li_tempkbcount
				ls_kbsn	= Right(ls_tempkbsn, 2)
				If f_pisc_get_kbno_next_temp(ls_kbsn, ls_kbsn) Then
					ls_tempkbsn	= Left(ls_tempkbsn, 9) + ls_kbsn
					dw_save.ReSet()
					If dw_save.Retrieve(	ls_tempkbsn, &
												ls_areacode,			ls_divisioncode, &
												ls_workcenter,			ls_linecode, &
												ls_itemcode,			ls_applyfrom, &
												'T',						'N', &
												li_tempkbrackqty,		g_s_empno) > 0 Then
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
						ls_errortext	= "�ӽð��� ��ȣ ������ �õ��Ͽ����� ������ �߻��߽��ϴ�."
						Exit
					End If
				End If
			Next
			
			If lb_error Then
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("���� ��ȣ ����","�ӽð��� ��ȣ�� �����ϴ� �߿� ���� �߻��Ͽ����ϴ�." + &
														"~r~n~r~n(����)" + &
														"~r~n1. " + ls_errortext, StopSign!)
			Else
				Commit Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("���� ��ȣ ����", "�ӽð��� ��ȣ�� �����Ͽ����ϴ�.", Information!)
				iw_this.TriggerEvent("ue_retrieve")
				If dw_1.RowCount() >= li_row Then
					dw_1.SetRow(li_row)
					dw_1.Trigger Event RowFocusChanged(li_row)
					dw_1.ScrollToRow(li_row)
				End If
			End If
		Else
			// �ӽð��Ǹ� �����Ϸ��� ������, ������� 0 ���� �۾� �׳� ������.
		End If
	Else
		// �ƹ��͵� ���ϱ� �׳�..������
	End If
End If
end event

type cb_2 from commandbutton within w_pisp240u_back
integer x = 4137
integer y = 56
integer width = 443
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean enabled = false
string text = "���� ����(&D)"
end type

event clicked;Int		li_row, li_count
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

li_row = dw_1.GetRow()

If li_row > 0 Then
	//
Else
	uo_status.st_message.text =  "���ǹ�ȣ�� ������ ��ǰ�� �����Ͽ� �ֽʽÿ�." //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("���� ��ȣ ����", "���ǹ�ȣ�� ������ ��ǰ�� �����Ͽ� �ֽʽÿ�.")
	Return
End If

ls_areacode				= Trim(dw_1.GetItemString(li_row, "AreaCode"))
ls_divisioncode		= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
ls_workcenter			= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
ls_linecode				= Trim(dw_1.GetItemString(li_row, "LineCode"))
ls_itemcode				= Trim(dw_1.GetItemString(li_row, "ItemCode"))

Select	Count(KBNo)
Into		:li_count
From		tkb
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode			And
			(KBActiveGubun = 'A' Or PrintCount		> 0)
Using SQLPIS;

If li_count > 0 Then
	uo_status.st_message.text =  "�μ��� ���� �Ǵ� Active ������ ������ �����մϴ�." //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("���� ��ȣ ����", "�μ��� ���� �Ǵ� Active ������ ������ �����Ͽ� �����Ͻ� ��ǰ�� ���ǹ�ȣ�� ������ �� �����ϴ�.")
	Return
End If


If MessageBox("���� ��ȣ ����", "�����Ͻ� ��ǰ�� ���� ��ȣ�� �����Ͻðڽ��ϱ�?" + &
									"~r~n~r~n���԰��� �� �ӽð����� ��� ��ȣ�� �����˴ϴ�." + &
									"~r~n~r~n�����Ͻ� ��ǰ�� ���� ������ ������ �����Ͻðڽ��ϱ�?", &
									Question!, YesNo!, 2) = 2 Then
	Return
End If

// ���� ��ȣ�� ��������.
SQLPIS.AutoCommit = False

// ���� ���̺� ����
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
	uo_status.st_message.text =  "���� ��ȣ ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�."
	MessageBox("���� ��ȣ ����", "���� ��ȣ ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
	Return
End If

Delete	tkbhis
Where		AreaCode			= :ls_areacode				And
			DivisionCode	= :ls_divisioncode		And
			WorkCenter		= :ls_workcenter			And
			LineCode			= :ls_linecode				And
			ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "���� ��ȣ �̷��� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�."
	MessageBox("���� ��ȣ ����", "���� ��ȣ �̷��� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
	Return
End If

// ���Ǹ����� ����
Update	tmstkb
Set		NormalKBSN		= Left(NormalKBSN, 8) + '000',
			TempKBSN			= Left(TempKBSN, 8) + 'X00',
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
Where		AreaCode			= :ls_areacode				And
			DivisionCode	= :ls_divisioncode		And
			WorkCenter		= :ls_workcenter			And
			LineCode			= :ls_linecode				And
			ItemCode			= :ls_itemcode
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "���� ������ ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�."
	MessageBox("���� ��ȣ ����", "���� ������ ������ �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
	Return
End If

Update	tmstkbhis
Set		NormalKBSN		= Left(NormalKBSN, 8) + '000',
			TempKBSN			= Left(TempKBSN, 8) + 'X00',
			LastEmp			= :g_s_empno,
			LastDate			= GetDate()
Where		AreaCode			= :ls_areacode				And
			DivisionCode	= :ls_divisioncode		And
			WorkCenter		= :ls_workcenter			And
			LineCode			= :ls_linecode				And
			ItemCode			= :ls_itemcode				And
			ApplyTo			= '9999.12.31'
Using SQLPIS;

If SQLPIS.sqlcode = 0 Then
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "���� ������ �̷��� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�."
	MessageBox("���� ��ȣ ����", "���� ������ �̷��� �����ϴ� �߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
	Return
End If


If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "���� ��ȣ ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
	MessageBox("���� ��ȣ ����", "���� ��ȣ ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.", StopSign!)
	Return
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "�����Ͻ� ���� ��ȣ ������ �����Ͽ����ϴ�." //+f_message("Work Calendar ������ �����ϴ� ���߿� ������ �߻��Ͽ����ϴ�.")
	MessageBox("���� ��ȣ ����", "�����Ͻ� ���� ��ȣ ������ �����Ͽ����ϴ�.", StopSign!)
	iw_this.TriggerEvent("ue_retrieve")
	If dw_1.RowCount() >= li_row Then
		dw_1.SetRow(li_row)
		dw_1.Trigger Event RowFocusChanged(li_row)
	End If
End If
end event

event constructor;Visible = False
end event

type dw_save from datawindow within w_pisp240u_back
integer x = 1719
integer y = 436
integer width = 955
integer height = 460
boolean bringtotop = true
boolean titlebar = true
string title = "���� ��ȣ ����"
string dataobject = "d_pisp240u_03_u"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type st_h_bar from uo_xc_splitbar within w_pisp240u_back
integer x = 1568
integer y = 972
integer width = 599
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type dw_detail from datawindow within w_pisp240u_back
integer x = 1559
integer y = 1020
integer width = 1253
integer height = 432
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisp240u_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event editchanged;AcceptText()
end event

event itemerror;Return 1
end event

type cb_3 from commandbutton within w_pisp240u_back
integer x = 3557
integer y = 56
integer width = 576
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���� (��)����(&P)"
end type

event clicked;istr_parms.string_arg[1] = is_size
	
OpenWithParm(w_pisp241u, istr_parms)

If Upper(Message.StringParm) = "CHANGE" Then
	iw_this.TriggerEvent("ue_retrieve")
End If
end event

type gb_1 from groupbox within w_pisp240u_back
integer x = 672
integer width = 1111
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp240u_back
integer x = 1787
integer width = 1280
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pisp240u_back
integer x = 3072
integer width = 1106
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_5 from groupbox within w_pisp240u_back
integer x = 14
integer width = 654
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type
