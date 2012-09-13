$PBExportHeader$w_pisp002u.srw
$PBExportComments$일일생산계획 계산
forward
global type w_pisp002u from window
end type
type dw_divide_item from datawindow within w_pisp002u
end type
type cb_1 from commandbutton within w_pisp002u
end type
type cb_2 from commandbutton within w_pisp002u
end type
type uo_month from u_pisc_date_scroll_month within w_pisp002u
end type
type dw_divide from datawindow within w_pisp002u
end type
type uo_item from u_pisc_select_item_kb_model within w_pisp002u
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_pisp002u
end type
type uo_productgroup from u_pisc_select_productgroup within w_pisp002u
end type
type st_msg from statictext within w_pisp002u
end type
type uo_division from u_pisc_select_division within w_pisp002u
end type
type uo_area from u_pisc_select_area within w_pisp002u
end type
type cb_4 from commandbutton within w_pisp002u
end type
type cb_3 from commandbutton within w_pisp002u
end type
type dw_save from datawindow within w_pisp002u
end type
type gb_2 from groupbox within w_pisp002u
end type
type gb_3 from groupbox within w_pisp002u
end type
type gb_4 from groupbox within w_pisp002u
end type
type gb_5 from groupbox within w_pisp002u
end type
type gb_6 from groupbox within w_pisp002u
end type
type gb_1 from groupbox within w_pisp002u
end type
type gb_7 from groupbox within w_pisp002u
end type
end forward

global type w_pisp002u from window
integer width = 3803
integer height = 2020
boolean titlebar = true
string title = "일일 생산계획 계산"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
dw_divide_item dw_divide_item
cb_1 cb_1
cb_2 cb_2
uo_month uo_month
dw_divide dw_divide
uo_item uo_item
uo_modelgroup uo_modelgroup
uo_productgroup uo_productgroup
st_msg st_msg
uo_division uo_division
uo_area uo_area
cb_4 cb_4
cb_3 cb_3
dw_save dw_save
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
gb_1 gb_1
gb_7 gb_7
end type
global w_pisp002u w_pisp002u

type variables
Boolean		ib_open, ib_compute
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen();String	ls_areacode, ls_divisioncode, ls_productgroup, ls_modelgroup, ls_itemcode

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_productgroup.is_uo_productgroup, &
										uo_productgroup.is_uo_productgroupname)

f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_productgroup.is_uo_productgroup, &
										'%', &
										True, &
										uo_modelgroup.is_uo_modelgroup, &
										uo_modelgroup.is_uo_modelgroupname)

f_pisc_retrieve_dddw_item_kb_model(uo_item.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_productgroup.is_uo_productgroup, &
										uo_modelgroup.is_uo_modelgroup, &
										'%', &
										True, &
										uo_item.is_uo_itemcode, &
										uo_item.is_uo_itemname)

//If istr_parms.string_arg[3] <> "%" Then
//	Select	AreaCode			= A.AreaCode,
//				DivisionCode	= A.DivisionCode,
//				ProductGroup	= A.ProductGroup,
//				ModelGroup		= A.ModelGroup,
//				ItemCode			= A.ItemCode
//	Into		:ls_areacode,
//				:ls_divisioncode,
//				:ls_productgroup,
//				:ls_modelgroup,
//				:ls_itemcode
//	From		vmstkb_model	A
//	Where		A.ItemCode		= :istr_parms.string_arg[3]
//	Using SQLPIS;
//	
//	
//	uo_area.dw_1.SetItem(1, 'DDDWCode', ls_areacode)
//	uo_division.dw_1.SetItem(1, 'DDDWCode', ls_divisioncode)
//	uo_productgroup.dw_1.SetItem(1, 'DDDWCode', ls_productgroup)
//	uo_modelgroup.dw_1.SetItem(1, 'DDDWCode', ls_modelgroup)
//	uo_item.dw_1.SetItem(1, 'DDDWCode', ls_itemcode)
//	
//	uo_area.is_uo_areacode					= ls_areacode
//	uo_division.is_uo_divisioncode		= ls_divisioncode
//	uo_productgroup.is_uo_productgroup	= ls_productgroup
//	uo_modelgroup.is_uo_modelgroup		= ls_modelgroup
//	uo_item.is_uo_itemcode					= ls_itemcode
//End If
dw_save.SetTransObject(SQLPIS)
dw_divide.SetTransObject(SQLPIS)
dw_divide_item.SetTransObject(SQLPIS)
wf_retrieve()
ib_open = True
end event

public subroutine wf_retrieve ();dw_divide_item.ReSet()
dw_divide.ReSet()
dw_divide_item.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
								uo_productgroup.is_uo_productgroup, uo_modelgroup.is_uo_modelgroup, &
								uo_item.is_uo_itemcode)
dw_divide.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode, &
						uo_productgroup.is_uo_productgroup, uo_modelgroup.is_uo_modelgroup, &
						uo_item.is_uo_itemcode)
end subroutine

on w_pisp002u.create
this.dw_divide_item=create dw_divide_item
this.cb_1=create cb_1
this.cb_2=create cb_2
this.uo_month=create uo_month
this.dw_divide=create dw_divide
this.uo_item=create uo_item
this.uo_modelgroup=create uo_modelgroup
this.uo_productgroup=create uo_productgroup
this.st_msg=create st_msg
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_save=create dw_save
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_1=create gb_1
this.gb_7=create gb_7
this.Control[]={this.dw_divide_item,&
this.cb_1,&
this.cb_2,&
this.uo_month,&
this.dw_divide,&
this.uo_item,&
this.uo_modelgroup,&
this.uo_productgroup,&
this.st_msg,&
this.uo_division,&
this.uo_area,&
this.cb_4,&
this.cb_3,&
this.dw_save,&
this.gb_2,&
this.gb_3,&
this.gb_4,&
this.gb_5,&
this.gb_6,&
this.gb_1,&
this.gb_7}
end on

on w_pisp002u.destroy
destroy(this.dw_divide_item)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.uo_month)
destroy(this.dw_divide)
destroy(this.uo_item)
destroy(this.uo_modelgroup)
destroy(this.uo_productgroup)
destroy(this.st_msg)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_save)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_1)
destroy(this.gb_7)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]
//is_applymonth		= istr_parms.string_arg[2]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type dw_divide_item from datawindow within w_pisp002u
integer x = 1637
integer y = 1064
integer width = 1184
integer height = 548
boolean titlebar = true
string title = "라인분배율 저장 제품 조회"
string dataobject = "d_pisp002u_03"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type cb_1 from commandbutton within w_pisp002u
integer x = 1051
integer y = 228
integer width = 709
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "계획분배율 조회(&R)"
end type

event clicked;	wf_retrieve()

end event

type cb_2 from commandbutton within w_pisp002u
integer x = 1760
integer y = 228
integer width = 709
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "계획분배율 저장(&S)"
end type

event clicked;int		i, j, li_dividerate, li_dividerate_item
String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode, &
			ls_areacode_item, ls_divisioncode_item, ls_itemcode_item
Boolean	lb_error

If dw_divide.RowCount() > 0 Or dw_divide_item.RowCount() > 0 Then
	//
Else
	MessageBox("일일 생산계획 계산", "라인별 계획분배율을 저장할 라인 정보가 존재하지 않습니다.", StopSign!)
	Return
End If

// 여기부터는 제품의 계획분배율이 100 % 인지 확인하는 것
// 일단 첫번째의 제품코드를 가져오자
For i = 1 To dw_divide_item.RowCount()
	li_dividerate_item		= 0
	ls_areacode_item			= Trim(dw_divide_item.GetItemString(i, "AreaCode"))
	ls_divisioncode_item		= Trim(dw_divide_item.GetItemString(i, "DivisionCode"))
	ls_itemcode_item			= Trim(dw_divide_item.GetItemString(i, "ItemCode"))
	For j = 1 To dw_divide.RowCount()
		ls_areacode			= Trim(dw_divide.GetItemString(j, "AreaCode"))
		ls_divisioncode	= Trim(dw_divide.GetItemString(j, "DivisionCode"))
		ls_workcenter		= Trim(dw_divide.GetItemString(j, "WorkCenter"))
		ls_linecode			= Trim(dw_divide.GetItemString(j, "LineCode"))
		ls_itemcode			= Trim(dw_divide.GetItemString(j, "ItemCode"))
		li_dividerate		= dw_divide.GetItemNumber(j, "DivideRate")
		If ls_areacode = ls_areacode_item And ls_divisioncode = ls_divisioncode_item And &
				ls_itemcode = ls_itemcode_item Then
			li_dividerate_item	= li_dividerate_item + li_dividerate
		End If
	Next
	If li_dividerate_item <> 100 Then
		MessageBox("일일 생산계획 계산", "라인별 계획분배율의 합은 '100 %'가 되어야 합니다." + &
													"~r~n~r~n품번: " + ls_itemcode_item + " 의 계획분배율을 확인하십시오.", StopSign!)
		Return
	End If
Next	

// 여기부터 저장...
If MessageBox("일일 생산계획 계산","변경된 계획분배율 정보를 저장하시겠습니까 ?", Question!, YesNo!) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False
For i = 1 To dw_divide.RowCount()
	ls_areacode			= Trim(dw_divide.GetItemString(i, "AreaCode"))
	ls_divisioncode	= Trim(dw_divide.GetItemString(i, "DivisionCode"))
	ls_workcenter		= Trim(dw_divide.GetItemString(i, "WorkCenter"))
	ls_linecode			= Trim(dw_divide.GetItemString(i, "LineCode"))
	ls_itemcode			= Trim(dw_divide.GetItemString(i, "ItemCode"))
	li_dividerate		= dw_divide.GetItemNumber(i, "DivideRate")
	
	Update	tmstkb
		Set	DivideRate		= :li_dividerate,
				LastEmp			= 'Y',
				LastDate			= GetDate()
	 Where	AreaCode			= :ls_areacode
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
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("일일 생산계획 계산", "계획분배율 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("일일 생산계획 계산", "계획분배율 정보를 저장하였습니다.", Information!)
End If

//CloseWithReturn(Parent, "CHANGE")
end event

type uo_month from u_pisc_date_scroll_month within w_pisp002u
integer x = 41
integer y = 64
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type dw_divide from datawindow within w_pisp002u
event ue_vscroll pbm_vscroll
integer x = 46
integer y = 668
integer width = 3657
integer height = 1200
string title = "none"
string dataobject = "d_pisp002u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
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

event editchanged;AcceptText()
end event

event itemerror;Return 1
end event

event rowfocuschanged;If CurrentRow > 0 Then
	this.SelectRow(0,FALSE)
	this.SelectRow(currentrow,TRUE)
End If
end event

type uo_item from u_pisc_select_item_kb_model within w_pisp002u
integer x = 41
integer y = 240
end type

on uo_item.destroy
call u_pisc_select_item_kb_model::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_pisp002u
event destroy ( )
integer x = 2784
integer y = 64
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	f_pisc_retrieve_dddw_item_kb_model(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											uo_modelgroup.is_uo_modelgroup, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If

end event

type uo_productgroup from u_pisc_select_productgroup within w_pisp002u
event destroy ( )
integer x = 1883
integer y = 64
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)

	f_pisc_retrieve_dddw_item_kb_model(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											uo_modelgroup.is_uo_modelgroup, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If

end event

type st_msg from statictext within w_pisp002u
integer x = 41
integer y = 444
integer width = 3643
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "계획분배율을 확인하신 후에 ~'일일 생산계획 계산(&G)~' 버튼을 클릭하시면 일일 생산계획이 계산됩니다."
boolean focusrectangle = false
end type

type uo_division from u_pisc_select_division within w_pisp002u
integer x = 1234
integer y = 64
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_save.SetTransObject(SQLPIS)
	dw_divide.SetTransObject(SQLPIS)
	dw_divide_item.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)
	
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)

	f_pisc_retrieve_dddw_item_kb_model(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											uo_modelgroup.is_uo_modelgroup, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp002u
integer x = 727
integer y = 64
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_save.SetTransObject(SQLPIS)
	dw_divide.SetTransObject(SQLPIS)
	dw_divide_item.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_productgroup.is_uo_productgroup, &
											uo_productgroup.is_uo_productgroupname)
	
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											'%', &
											True, &
											uo_modelgroup.is_uo_modelgroup, &
											uo_modelgroup.is_uo_modelgroupname)

	f_pisc_retrieve_dddw_item_kb_model(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_productgroup.is_uo_productgroup, &
											uo_modelgroup.is_uo_modelgroup, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
	wf_retrieve()
End If
end event

type cb_4 from commandbutton within w_pisp002u
integer x = 3269
integer y = 228
integer width = 393
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;If ib_compute Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type cb_3 from commandbutton within w_pisp002u
integer x = 2469
integer y = 228
integer width = 800
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일일 생산계획 계산(&G)"
end type

event clicked;Boolean	lb_error
String	ls_errortext

If MessageBox("일일생산계획 계산","일일생산계획을 계산 하시겠습니까 ?", Question!, YesNo!) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

dw_save.ReSet()
If dw_save.Retrieve('R', &
				uo_month.is_uo_month, &
				uo_area.is_uo_areacode,					uo_division.is_uo_divisioncode, &
				uo_productgroup.is_uo_productgroup,	uo_modelgroup.is_uo_modelgroup, &
				uo_item.is_uo_itemcode,								g_s_empno) > 0 Then
	If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
		lb_error	= False
		ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
	Else
		lb_error = True
		ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
	End If
Else
	lb_error = True
	ls_errortext	= "일일생산계획 계산을 시도하였지만 오류가 발생했습니다."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("일일생산계획 계산", "일일생산계획을 계산하는 중에 오류가 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_compute	= True
	st_msg.Text	= "일일 생산계획 화면에서 계산된 일일 생산계획 정보를 확인하십시오."
	MessageBox("일일생산계획 계산", "일일생산계획을 계산 하였습니다.", Information!)
End If

//	li_count = 0
//
//	Select	Count(ApplyDate)
//	Into		:li_count
//	From		tcalendarwork
//	Where		AreaCode			= :uo_area.is_uo_areacode
//	And		DivisionCode	= :uo_division.is_uo_divisioncode
//	And		WorkCenter		= :uo_workcenter.is_uo_workcenter
//	And		LineCode			= :uo_line.is_uo_linecode
//	And		ApplyMonth		= :uo_month.is_uo_month
//	And		ApplyDate		= :ls_applydate
//	Using	SQLPIS;
//	
//	If li_count > 0 Then
//
//		Update	tcalendarwork
//			Set	WorkGubun		= :ls_workgubun,
//					LastEmp			= :g_s_empno,
//					LastDate			= GetDate()
//		 Where	AreaCode			= :uo_area.is_uo_areacode
//			And	DivisionCode	= :uo_division.is_uo_divisioncode
//			And	WorkCenter		= :uo_workcenter.is_uo_workcenter
//			And	LineCode			= :uo_line.is_uo_linecode
//			And	ApplyMonth		= :uo_month.is_uo_month
//			And	ApplyDate		= :ls_applydate
//		Using SQLPIS;
//		If SQLPIS.sqlcode = 0 Then
//			lb_error	= False
//		Else
//			lb_error = True
//			Exit
//		End If
//	Else
//		Insert Into tcalendarwork	(AreaCode,								DivisionCode,
//											WorkCenter,								LineCode,
//											ApplyMonth,								ApplyDate,
//											DayNo,									WorkGubun,
//											Remark,
//											LastEmp,									LastDate)
//		Values							(:uo_area.is_uo_areacode,			:uo_division.is_uo_divisioncode,
//											:uo_workcenter.is_uo_workcenter,	:uo_line.is_uo_linecode,
//											:uo_month.is_uo_month,				:ls_applydate,
//											:li_julianday,							:ls_workgubun,
//											Null,
//											:g_s_empno,								GetDate())
//		Using SQLPIS;
//		If SQLPIS.sqlcode = 0 Then
//			lb_error	= False
//		Else
//			lb_error = True
//			Exit
//		End If
//	End If
end event

type dw_save from datawindow within w_pisp002u
integer x = 690
integer y = 1056
integer width = 823
integer height = 460
boolean bringtotop = true
boolean titlebar = true
string title = "일일 생산계획 계산"
string dataobject = "d_pisp002u_01_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_2 from groupbox within w_pisp002u
integer x = 14
integer width = 658
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_3 from groupbox within w_pisp002u
integer x = 677
integer width = 1157
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_4 from groupbox within w_pisp002u
integer x = 1838
integer width = 1902
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_5 from groupbox within w_pisp002u
integer x = 9
integer y = 160
integer width = 974
integer height = 212
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_6 from groupbox within w_pisp002u
integer x = 983
integer y = 160
integer width = 2757
integer height = 212
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisp002u
integer x = 9
integer y = 352
integer width = 3730
integer height = 212
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
end type

type gb_7 from groupbox within w_pisp002u
integer x = 9
integer y = 596
integer width = 3730
integer height = 1304
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "계획분배율 정보"
end type

