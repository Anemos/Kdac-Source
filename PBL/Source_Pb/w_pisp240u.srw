$PBExportHeader$w_pisp240u.srw
$PBExportComments$간판 번호 관리
forward
global type w_pisp240u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp240u
end type
type uo_area from u_pisc_select_area within w_pisp240u
end type
type uo_division from u_pisc_select_division within w_pisp240u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp240u
end type
type uo_line from u_pisc_select_line within w_pisp240u
end type
type cb_1 from commandbutton within w_pisp240u
end type
type dw_save from datawindow within w_pisp240u
end type
type st_h_bar from uo_xc_splitbar within w_pisp240u
end type
type dw_detail from datawindow within w_pisp240u
end type
type cb_3 from commandbutton within w_pisp240u
end type
type dw_print from datawindow within w_pisp240u
end type
type gb_1 from groupbox within w_pisp240u
end type
type gb_2 from groupbox within w_pisp240u
end type
type gb_4 from groupbox within w_pisp240u
end type
type cb_2 from commandbutton within w_pisp240u
end type
end forward

global type w_pisp240u from w_ipis_sheet01
integer width = 4384
integer height = 2344
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
cb_1 cb_1
dw_save dw_save
st_h_bar st_h_bar
dw_detail dw_detail
cb_3 cb_3
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
cb_2 cb_2
end type
global w_pisp240u w_pisp240u

type variables
Boolean	ib_open
end variables

on w_pisp240u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.cb_1=create cb_1
this.dw_save=create dw_save
this.st_h_bar=create st_h_bar
this.dw_detail=create dw_detail
this.cb_3=create cb_3
this.dw_print=create dw_print
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.dw_save
this.Control[iCurrent+8]=this.st_h_bar
this.Control[iCurrent+9]=this.dw_detail
this.Control[iCurrent+10]=this.cb_3
this.Control[iCurrent+11]=this.dw_print
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.cb_2
end on

on w_pisp240u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.cb_1)
destroy(this.dw_save)
destroy(this.st_h_bar)
destroy(this.dw_detail)
destroy(this.cb_3)
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.cb_2)
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

cb_1.Enabled	= m_frame.m_action.m_save.Enabled
cb_2.Enabled	= m_frame.m_action.m_save.Enabled
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

If dw_1.Retrieve(	uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
	uo_status.st_message.text =  "간판 번호 관리 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "간판 번호 관리 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 번호 관리", "간판 번호 관리 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
dw_save.ReSet()
dw_print.ReSet()

end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt

//ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '간판 번호 관리'
lstr_prt.tag			= '간판 번호 관리'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp240u
integer y = 2144
end type

type dw_1 from u_vi_std_datawindow within w_pisp240u
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
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

type uo_area from u_pisc_select_area within w_pisp240u
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

type uo_division from u_pisc_select_division within w_pisp240u
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

type uo_workcenter from u_pisc_select_workcenter within w_pisp240u
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

type uo_line from u_pisc_select_line within w_pisp240u
integer x = 1824
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

type cb_1 from commandbutton within w_pisp240u
integer x = 2455
integer y = 56
integer width = 562
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판번호 생성(&C)"
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
	uo_status.st_message.text =  "간판 번호를 생성할 제품을 선택하여 주십시오." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 번호 관리", "간판 번호를 생성할 제품을 선택하여 주십시오.")
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

// 어떤 넘을 생성할 지 확인한후에
// 확인 메세지를 보내자..
If li_normalkbcount > 0 Then
	If li_tempkbcount > 0 Then
		If li_tempkbrackqty > 0 Then
			If MessageBox("간판 번호 관리", "정규간판 및 임시간판을 생성하시겠습니까?", &
														Question!, YesNo!, 2) = 2 Then
				Return
			End If
		Else
			If MessageBox("간판 번호 관리", "정규간판 및 임시간판을 동시에 생성하시려고 합니다." + &
															"~r~n~r~n그러나, 임시간판의 수용수가 정확하지 않아 정규간판만 생성됩니다." + &
															"~r~n~r~n정규간판만 생성하시겠습니까?", &
														Question!, YesNo!, 2) = 2 Then
				Return
			End If
		End If
	Else
		If MessageBox("간판 번호 관리", "정규간판을 생성하시겠습니까?", &
													Question!, YesNo!, 2) = 2 Then
			Return
		End If		
	End If
Else
	If li_tempkbcount > 0 Then
		If li_tempkbrackqty > 0 Then
			If MessageBox("간판 번호 관리", "임시간판을 생성하시겠습니까?", &
														Question!, YesNo!, 2) = 2 Then
				Return
			End If
		Else
			uo_status.st_message.text =  "생성할 임시간판의 수용수를 정확히 등록하십시오." //+ f_message("변경된 데이타가 없습니다.")
			MessageBox("간판 번호 관리", "생성할 임시간판의 수용수를 정확히 등록하십시오.")
			Return
		End If
	Else
		uo_status.st_message.text =  "생성할 간판 매수 및 수용수를 정확히 등록하십시오." //+ f_message("변경된 데이타가 없습니다.")
		MessageBox("간판 번호 관리", "생성할 간판 매수 및 수용수를 정확히 등록하십시오.")
		Return
	End If
End If

// 자~~~아
// 간판번호를 생성하자..
If li_normalkbcount > 0 Then
	If li_tempkbcount > 0 Then
		If li_tempkbrackqty > 0 Then
			// 정규 및 임시 간판 동시 생성
				// 일단 정규 간판 생성
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
						ls_errortext	= "정규간판 번호 생성을 시도하였지만 오류가 발생했습니다."
						Exit
					End If
				End If
			Next			
			If lb_error Then
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("간판 번호 관리","정규간판 번호를 생성하는 중에 오류 발생하였습니다." + &
														"~r~n~r~n(참고)" + &
														"~r~n1. " + ls_errortext, StopSign!)
				Return
			Else
				// 다음의 임시간판 생성을 위해..아무것도 하지 말자..
			End If

				// 여기 부터는 임시간판 생성
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
						ls_errortext	= "임시간판 번호 생성을 시도하였지만 오류가 발생했습니다."
						Exit
					End If
				End If
			Next
			
			If lb_error Then
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("간판 번호 관리","임시간판 번호를 생성하는 중에 오류 발생하였습니다." + &
														"~r~n~r~n(참고)" + &
														"~r~n1. " + ls_errortext, StopSign!)
			Else
				Commit Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("간판 번호 관리", "정규간판 및 임시간판 번호를 생성하였습니다.", Information!)
				iw_this.TriggerEvent("ue_retrieve")
				If dw_1.RowCount() >= li_row Then
					dw_1.SetRow(li_row)
					dw_1.Trigger Event RowFocusChanged(li_row)
					dw_1.ScrollToRow(li_row)
				End If
			End If
		Else
			// 정규 간판만 생성 => 임시간판도 생성하려구 했지만, 임시간판 수용수가 0 보다 작다.
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
						ls_errortext	= "정규간판 번호 생성을 시도하였지만 오류가 발생했습니다."
						Exit
					End If
				End If
			Next
			
			If lb_error Then
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("간판 번호 관리","정규간판 번호를 생성하는 중에 오류 발생하였습니다." + &
														"~r~n~r~n(참고)" + &
														"~r~n1. " + ls_errortext, StopSign!)
			Else
				Commit Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("간판 번호 관리", "정규간판 번호를 생성하였습니다.", Information!)
				iw_this.TriggerEvent("ue_retrieve")
				If dw_1.RowCount() >= li_row Then
					dw_1.SetRow(li_row)
					dw_1.Trigger Event RowFocusChanged(li_row)
					dw_1.ScrollToRow(li_row)
				End If
			End If
		End If
	Else
		//정규 간판만 생성
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
					ls_errortext	= "정규간판 번호 생성을 시도하였지만 오류가 발생했습니다."
					Exit
				End If
			End If
		Next
		
		If lb_error Then
			RollBack Using SQLPIS;
			SQLPIS.AutoCommit = True
			MessageBox("간판 번호 관리","정규간판 번호를 생성하는 중에 오류 발생하였습니다." + &
													"~r~n~r~n(참고)" + &
													"~r~n1. " + ls_errortext, StopSign!)
		Else
			Commit Using SQLPIS;
			SQLPIS.AutoCommit = True
			MessageBox("간판 번호 관리", "정규간판 번호를 생성하였습니다.", Information!)
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
			// 임시간판만 생성
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
						ls_errortext	= "임시간판 번호 생성을 시도하였지만 오류가 발생했습니다."
						Exit
					End If
				End If
			Next
			
			If lb_error Then
				RollBack Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("간판 번호 관리","임시간판 번호를 생성하는 중에 오류 발생하였습니다." + &
														"~r~n~r~n(참고)" + &
														"~r~n1. " + ls_errortext, StopSign!)
			Else
				Commit Using SQLPIS;
				SQLPIS.AutoCommit = True
				MessageBox("간판 번호 관리", "임시간판 번호를 생성하였습니다.", Information!)
				iw_this.TriggerEvent("ue_retrieve")
				If dw_1.RowCount() >= li_row Then
					dw_1.SetRow(li_row)
					dw_1.Trigger Event RowFocusChanged(li_row)
					dw_1.ScrollToRow(li_row)
				End If
			End If
		Else
			// 임시간판만 생성하려구 했지만, 수용수가 0 보다 작아 그냥 나가자.
		End If
	Else
		// 아무것도 않하구 그냥..나가자
	End If
End If
end event

type dw_save from datawindow within w_pisp240u
integer x = 1719
integer y = 436
integer width = 955
integer height = 460
boolean bringtotop = true
boolean titlebar = true
string title = "간판 번호 생성"
string dataobject = "d_pisp240u_03_u"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type st_h_bar from uo_xc_splitbar within w_pisp240u
integer x = 1568
integer y = 972
integer width = 599
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type dw_detail from datawindow within w_pisp240u
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

type cb_3 from commandbutton within w_pisp240u
integer x = 3579
integer y = 56
integer width = 695
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판번호 (재)발행(&P)"
end type

event clicked;Int	li_row

li_row	= dw_1.GetRow()

If li_row > 0 Then
	//
Else
	MessageBox("간판관리", "제품을 선택하여 주십시오.", StopSign!)
	Return
End If

istr_parms.string_arg[1] = is_size
//istr_parms.string_arg[2] = uo_date.is_uo_date

istr_parms.string_arg[3] = Trim(dw_1.GetItemString(li_row, 'AreaCode'))
istr_parms.string_arg[4] = Trim(dw_1.GetItemString(li_row, 'DivisionCode'))
istr_parms.string_arg[5] = Trim(dw_1.GetItemString(li_row, 'WorkCenter'))
istr_parms.string_arg[6] = Trim(dw_1.GetItemString(li_row, 'LineCode'))
istr_parms.string_arg[7] = Trim(dw_1.GetItemString(li_row, 'ItemCode'))
	
OpenWithParm(w_pisp241u, istr_parms)

If Upper(Message.StringParm) = "CHANGE" Then
	iw_this.TriggerEvent("ue_retrieve")
End If
end event

type dw_print from datawindow within w_pisp240u
integer x = 1810
integer y = 1528
integer width = 713
integer height = 428
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp240u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible = false
end event

type gb_1 from groupbox within w_pisp240u
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

type gb_2 from groupbox within w_pisp240u
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

type gb_4 from groupbox within w_pisp240u
integer x = 2414
integer width = 1906
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

type cb_2 from commandbutton within w_pisp240u
integer x = 3017
integer y = 56
integer width = 562
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판번호 삭제(&D)"
end type

event clicked;Int		li_row, li_count
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode
Boolean	lb_error

li_row = dw_1.GetRow()

If li_row > 0 Then
	//
Else
	uo_status.st_message.text =  "간판번호를 삭제할 제품을 선택하여 주십시오." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 번호 관리", "간판번호를 삭제할 제품을 선택하여 주십시오.")
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
	uo_status.st_message.text =  "인쇄한 간판 또는 Active 상태인 간판이 존재합니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 번호 관리", "인쇄한 간판 또는 Active 상태인 간판이 존재하여 선택하신 제품의 간판번호를 삭제할 수 없습니다.")
	Return
End If


If MessageBox("간판 번호 관리", "선택하신 제품의 간판 번호를 삭제하시겠습니까?" + &
									"~r~n~r~n정규간판 및 임시간판의 모든 번호가 삭제됩니다." + &
									"~r~n~r~n선택하신 제품의 간판 마스터 정보를 삭제하시겠습니까?", &
									Question!, YesNo!, 2) = 2 Then
	Return
End If

// 간판 번호를 삭제하자.
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
	MessageBox("간판 번호 관리", "삭제되는 간판 번호 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 간판 테이블 삭제
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
	uo_status.st_message.text =  "간판 번호 정보를 삭제하는 중에 오류가 발생하였습니다."
	MessageBox("간판 번호 관리", "간판 번호 정보를 삭제하는 중에 오류가 발생하였습니다.", StopSign!)
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
	MessageBox("간판 번호 관리", "삭제되는 간판번호 이력 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 간판번호 이력 삭제
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
	uo_status.st_message.text =  "간판 번호 이력을 변경하는 중에 오류가 발생하였습니다."
	MessageBox("간판 번호 관리", "간판 번호 이력을 변경하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 간판마스터 변경
Update	tmstkb
Set		NormalKBSN		= Left(NormalKBSN, 8) + '000',
			TempKBSN			= Left(TempKBSN, 8) + 'X00',
			LastEmp			= 'Y',
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
	uo_status.st_message.text =  "간판 마스터 정보를 변경하는 중에 오류가 발생하였습니다."
	MessageBox("간판 번호 관리", "간판 마스터 정보를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If

// 간판마스터 이력 변경
Update	tmstkbhis
Set		NormalKBSN		= Left(NormalKBSN, 8) + '000',
			TempKBSN			= Left(TempKBSN, 8) + 'X00',
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
	lb_error	= False
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	lb_error	= True
	uo_status.st_message.text =  "간판 마스터 이력을 변경하는 중에 오류가 발생하였습니다."
	MessageBox("간판 번호 관리", "간판 마스터 이력을 변경하는 중에 오류가 발생하였습니다.", StopSign!)
	Return
End If


If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "간판 번호 정보를 삭제하는 도중에 오류가 발생하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("간판 번호 관리", "간판 번호 정보를 삭제하는 도중에 오류가 발생하였습니다.", StopSign!)
	Return
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	uo_status.st_message.text =  "선택하신 간판 번호 정보를 삭제하였습니다." //+f_message("Work Calendar 정보를 변경하는 도중에 오류가 발생하였습니다.")
	MessageBox("간판 번호 관리", "선택하신 간판 번호 정보를 삭제하였습니다.", StopSign!)
	iw_this.TriggerEvent("ue_retrieve")
	If dw_1.RowCount() >= li_row Then
		dw_1.SetRow(li_row)
		dw_1.Trigger Event RowFocusChanged(li_row)
	End If
End If
end event

event constructor;//Visible = False
end event

