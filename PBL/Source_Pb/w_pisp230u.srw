$PBExportHeader$w_pisp230u.srw
$PBExportComments$월간 운영 간판 매수
forward
global type w_pisp230u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp230u
end type
type uo_area from u_pisc_select_area within w_pisp230u
end type
type uo_division from u_pisc_select_division within w_pisp230u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp230u
end type
type uo_line from u_pisc_select_line within w_pisp230u
end type
type uo_month from u_pisc_date_scroll_month within w_pisp230u
end type
type cb_1 from commandbutton within w_pisp230u
end type
type cb_2 from commandbutton within w_pisp230u
end type
type dw_save from datawindow within w_pisp230u
end type
type dw_print from datawindow within w_pisp230u
end type
type gb_1 from groupbox within w_pisp230u
end type
type gb_2 from groupbox within w_pisp230u
end type
type gb_4 from groupbox within w_pisp230u
end type
type gb_5 from groupbox within w_pisp230u
end type
end forward

global type w_pisp230u from w_ipis_sheet01
integer width = 4946
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
dw_print dw_print
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
end type
global w_pisp230u w_pisp230u

type variables
Boolean	ib_open
end variables

on w_pisp230u.create
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
this.dw_print=create dw_print
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
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.gb_5
end on

on w_pisp230u.destroy
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
destroy(this.dw_print)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_1, FULL)
//
//of_resize()
//
//dw_2.Move(st_v_bar.X, st_v_bar.Y + st_v_bar.Height + 15)
//dw_2.Resize(dw_1.Width, newheight - dw_1.Y - dw_1.Height - 30)
il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

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

event ue_retrieve;
iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_month.is_uo_month, &
						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
	uo_status.st_message.text =  "월간 운영 간판매수 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "월간 운영 간판매수 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("월간 운영 간판매수", "월간 운영 간판매수 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_save.ReSet()
dw_print.ReSet()

end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt

//ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '월간 운영 간판 매수'
lstr_prt.tag			= '월간 운영 간판 매수'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp230u
end type

type dw_1 from u_vi_std_datawindow within w_pisp230u
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 184
integer width = 1458
integer height = 1452
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp230u_01"
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
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_pisp230u
integer x = 709
integer y = 68
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
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
End If

end event

type uo_division from u_pisc_select_division within w_pisp230u
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
	dw_1.SetTransObject(SQLPIS)
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
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp230u
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
End If

end event

type uo_line from u_pisc_select_line within w_pisp230u
integer x = 2482
integer y = 68
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type uo_month from u_pisc_date_scroll_month within w_pisp230u
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

type cb_1 from commandbutton within w_pisp230u
integer x = 3113
integer y = 56
integer width = 727
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "선택 제품 간판생성(&A)"
end type

event clicked;Int		i, li_row, li_createkbcount, li_rackqty
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode, &
			ls_applyfrom, ls_kbsn, ls_normalkbsn, ls_errortext
Boolean	lb_error

li_row = dw_1.GetRow()

If li_row > 0 Then
	//
Else
	uo_status.st_message.text =  "제품을 선택하여 주십시오." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("월간 운영 간판매수", "제품을 선택하여 주십시오.")
	Return
End If

li_createkbcount	= dw_1.GetItemNumber(li_row, "CreateKBCount")

If li_createkbcount > 0 Then
	//
Else
	uo_status.st_message.text =  "선택한 제품은 추가 생성할 간판이 없습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("월간 운영 간판매수", "선택한 제품은 추가 생성할 간판이 없습니다.")
	Return
End If

If MessageBox("월간 운영 간판매수", "선택하신 제품의 간판번호를 생성하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

ls_areacode			= Trim(dw_1.GetItemString(li_row, "AreaCode"))
ls_divisioncode	= Trim(dw_1.GetItemString(li_row, "DivisionCode"))
ls_workcenter		= Trim(dw_1.GetItemString(li_row, "WorkCenter"))
ls_linecode			= Trim(dw_1.GetItemString(li_row, "LineCode"))
ls_itemcode			= Trim(dw_1.GetItemString(li_row, "ItemCode"))
//ls_applyfrom		= Trim(dw_1.GetItemString(li_row, "ApplyFrom"))
//li_rackqty			= dw_1.GetItemNumber(li_row, "RackQty")
//ls_normalkbsn		= Trim(dw_1.GetItemString(li_row, "NormalKBSN"))

Select	RackQty,
			NormalKBSN
Into		:li_rackqty,
			:ls_normalkbsn
From		tmstkb
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter		And
			LineCode			= :ls_linecode			And
			ItemCode			= :ls_itemcode
Using	SQLPIS;

ls_applyfrom	= f_pisc_get_date_applydate_close('%', '%', f_pisc_get_date_nowtime())

SQLPIS.AutoCommit = False
For i = 1 To li_createkbcount
	ls_kbsn	= Right(ls_normalkbsn, 3)
	If f_pisc_get_kbno_next_normal(ls_kbsn, ls_kbsn) Then
		ls_normalkbsn	= Left(ls_normalkbsn, 8) + ls_kbsn
		dw_save.ReSet()
		If dw_save.Retrieve(	ls_normalkbsn, &
									ls_areacode,			ls_divisioncode, &
									ls_workcenter,			ls_linecode, &
									ls_itemcode,			ls_applyfrom, &
									'N',						'N', &
									li_rackqty,				g_s_empno) > 0 Then
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
			ls_errortext	= "간판 번호 생성을 시도하였지만 오류가 발생했습니다."
			Exit
		End If
//	Else
//		MessageBox("", "TT")
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("월간 운영 간판매수","월간 운영 간판매수를 생성하는 중에 오류 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("월간 운영 간판매수", "월간 운영 간판매수를 생성하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
	If dw_1.RowCount() >= li_row Then
		dw_1.SetRow(li_row)
		dw_1.Trigger Event RowFocusChanged(li_row)
	End If
End If
end event

type cb_2 from commandbutton within w_pisp230u
integer x = 3840
integer y = 56
integer width = 736
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회 제품 간판생성(&S)"
end type

event clicked;Int		i, j, li_createkbcount, li_createcount, li_rackqty
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode, &
			ls_itemname, ls_modelid, ls_applyfrom, ls_kbsn, ls_normalkbsn, ls_errortext
Boolean	lb_error

If dw_1.RowCount() > 0 Then
	//
Else
	uo_status.st_message.text =  "월간 운영 간판매수를 생성할 제품 정보가 없습니다." //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("월간 운영 간판매수", "월간 운영 간판매수를 생성할 제품 정보가 없습니다.")
	Return
End If

If MessageBox("월간 운영 간판매수", "조회하신 제품들의 월간 운영 간판매수를 생성하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

ls_applyfrom	= f_pisc_get_date_applydate_close('%', '%', f_pisc_get_date_nowtime())

SQLPIS.AutoCommit = False
For i = 1 To dw_1.RowCount()
	dw_1.Trigger Event RowFocusChanged(i)
	li_createkbcount	= dw_1.GetItemNumber(i, "CreateKBCount")
	If li_createkbcount > 0 Then
		li_createcount	= li_createcount + 1
		ls_areacode			= Trim(dw_1.GetItemString(i, "AreaCode"))
		ls_divisioncode	= Trim(dw_1.GetItemString(i, "DivisionCode"))
		ls_workcenter		= Trim(dw_1.GetItemString(i, "WorkCenter"))
		ls_linecode			= Trim(dw_1.GetItemString(i, "LineCode"))
		ls_itemcode			= Trim(dw_1.GetItemString(i, "ItemCode"))
		ls_itemname			= Trim(dw_1.GetItemString(i, "ItemName"))
		ls_modelid			= Trim(dw_1.GetItemString(i, "ModelID"))
//		ls_applyfrom		= Trim(dw_1.GetItemString(i, "ApplyFrom"))
//		li_rackqty			= dw_1.GetItemNumber(i, "RackQty")
//		ls_normalkbsn		= Trim(dw_1.GetItemString(i, "NormalKBSN"))

		Select	RackQty,
					NormalKBSN
		Into		:li_rackqty,
					:ls_normalkbsn
		From		tmstkb
		Where		AreaCode			= :ls_areacode			And
					DivisionCode	= :ls_divisioncode	And
					WorkCenter		= :ls_workcenter		And
					LineCode			= :ls_linecode			And
					ItemCode			= :ls_itemcode
		Using	SQLPIS;

		For j = 1 To li_createkbcount
			ls_kbsn	= Right(ls_normalkbsn, 3)
			If f_pisc_get_kbno_next_normal(ls_kbsn, ls_kbsn) Then
				ls_normalkbsn	= Left(ls_normalkbsn, 8) + ls_kbsn
				dw_save.ReSet()
				If dw_save.Retrieve(	ls_normalkbsn, &
											ls_areacode,			ls_divisioncode, &
											ls_workcenter,			ls_linecode, &
											ls_itemcode, &
											ls_applyfrom,			li_rackqty, &
											g_s_empno) > 0 Then
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
					ls_errortext	= "간판 번호 생성을 시도하였지만 오류가 발생했습니다."
					Exit
				End If
			End If
		Next
	End If
	If lb_error Then
		Exit
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("월간 운영 간판매수", "품번 : " + ls_itemcode + &
									"~r~n~r~n품명 : " + ls_itemname + &
									"~r~n~r~n식별ID : " + ls_modelid + &
									"~r~n~r~n의 월간 운영 간판매수를 생성하는 중에 오류 발생하였습니다." + &
									"~r~n~r~n(참고)" + &
									"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	If li_createcount > 0 Then
		MessageBox("월간 운영 간판매수", "월간 운영 간판매수를 생성하였습니다.", Information!)
		iw_this.TriggerEvent("ue_retrieve")
	Else
		MessageBox("월간 운영 간판매수", "월간 운영 간판매수를 추가 생성할 제품이 없습니다.", Information!)
	End If
End If

end event

type dw_save from datawindow within w_pisp230u
integer x = 1586
integer y = 532
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

type dw_print from datawindow within w_pisp230u
integer x = 1728
integer y = 1116
integer width = 823
integer height = 460
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp230u_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible = false
end event

type gb_1 from groupbox within w_pisp230u
integer x = 672
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

type gb_2 from groupbox within w_pisp230u
integer x = 1787
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

type gb_4 from groupbox within w_pisp230u
integer x = 3072
integer width = 1550
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

type gb_5 from groupbox within w_pisp230u
integer x = 14
integer width = 654
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

