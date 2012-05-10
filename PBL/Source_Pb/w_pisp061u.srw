$PBExportHeader$w_pisp061u.srw
$PBExportComments$일일생산계획 - 계획 추가
forward
global type w_pisp061u from window
end type
type st_date from statictext within w_pisp061u
end type
type dw_item from u_vi_std_datawindow within w_pisp061u
end type
type uo_line from u_pisc_select_line within w_pisp061u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp061u
end type
type uo_division from u_pisc_select_division within w_pisp061u
end type
type uo_area from u_pisc_select_area within w_pisp061u
end type
type cb_2 from commandbutton within w_pisp061u
end type
type cb_1 from commandbutton within w_pisp061u
end type
type gb_1 from groupbox within w_pisp061u
end type
type gb_2 from groupbox within w_pisp061u
end type
type gb_4 from groupbox within w_pisp061u
end type
type gb_5 from groupbox within w_pisp061u
end type
type gb_3 from groupbox within w_pisp061u
end type
end forward

global type w_pisp061u from window
integer width = 3959
integer height = 1900
boolean titlebar = true
string title = "일일생산계획(계획 추가)"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
st_date st_date
dw_item dw_item
uo_line uo_line
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
gb_3 gb_3
end type
global w_pisp061u w_pisp061u

type variables
Boolean	ib_open, ib_change
String	is_plandate[16]
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_set_date ()
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;Long		ll_find
String	ls_areacode, ls_divisioncode, ls_productgroup, ls_modelgroup, ls_itemcode
Datawindowchild ldwc_area, ldwc_division, ldwc_productgroup, ldwc_modelgroup, &
					ldwc_item

st_date.Text	= "기준일:" + is_plandate[1]

dw_item.SetTransObject(SQLPIS)

uo_area.is_uo_areacode = istr_parms.string_arg[3]
uo_area.dw_1.SetItem(1, 'DDDWCode', uo_area.is_uo_areacode)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
uo_division.is_uo_divisioncode	= istr_parms.string_arg[4]
uo_division.dw_1.SetItem(1, 'DDDWCode', uo_division.is_uo_divisioncode)


f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										False, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)
uo_workcenter.is_uo_workcenter	= istr_parms.string_arg[5]
uo_workcenter.dw_1.SetItem(1, 'DDDWCode', uo_workcenter.is_uo_workcenter)

f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										False, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)
uo_line.is_uo_linecode	= istr_parms.string_arg[6]
uo_line.dw_1.SetItem(1, 'DDDWCode', uo_line.is_uo_linecode)

wf_set_date()
wf_retrieve()

ib_open = True
end event

public subroutine wf_set_date ();String	ls_mod

//is_plandate[1]		= ""
is_plandate[2]		= ""
is_plandate[3]		= ""
is_plandate[4]		= ""
is_plandate[5]		= ""
is_plandate[6]		= ""
is_plandate[7]		= ""
is_plandate[8]		= ""
is_plandate[9]		= ""
is_plandate[10]	= ""
is_plandate[11]	= ""
is_plandate[12]	= ""
is_plandate[13]	= ""
is_plandate[14]	= ""
is_plandate[15]	= ""
is_plandate[16]	= ""

//is_plandate[1]		= uo_date.is_uo_date
is_plandate[2]		= String(Relativedate(Date(is_plandate[1]), 1), "YYYY.MM.DD")
is_plandate[3]		= String(Relativedate(Date(is_plandate[2]), 1), "YYYY.MM.DD")
is_plandate[4]		= String(Relativedate(Date(is_plandate[3]), 1), "YYYY.MM.DD")
is_plandate[5]		= String(Relativedate(Date(is_plandate[4]), 1), "YYYY.MM.DD")
is_plandate[6]		= String(Relativedate(Date(is_plandate[5]), 1), "YYYY.MM.DD")
is_plandate[7]		= String(Relativedate(Date(is_plandate[6]), 1), "YYYY.MM.DD")
is_plandate[8]		= String(Relativedate(Date(is_plandate[7]), 1), "YYYY.MM.DD")
is_plandate[9]		= String(Relativedate(Date(is_plandate[8]), 1), "YYYY.MM.DD")
is_plandate[10]	= String(Relativedate(Date(is_plandate[9]), 1), "YYYY.MM.DD")
is_plandate[11]	= String(Relativedate(Date(is_plandate[10]), 1), "YYYY.MM.DD")
is_plandate[12]	= String(Relativedate(Date(is_plandate[11]), 1), "YYYY.MM.DD")
is_plandate[13]	= String(Relativedate(Date(is_plandate[12]), 1), "YYYY.MM.DD")
is_plandate[14]	= String(Relativedate(Date(is_plandate[13]), 1), "YYYY.MM.DD")
is_plandate[15]	= String(Relativedate(Date(is_plandate[14]), 1), "YYYY.MM.DD")
is_plandate[16]	= String(Relativedate(Date(is_plandate[15]), 1), "YYYY.MM.DD")

end subroutine

public subroutine wf_retrieve ();String	ls_todate

wf_set_date()

ls_todate	= f_pisc_get_date_applydate_close("%", "%", f_pisc_get_date_nowtime())

dw_item.ReSet()
If dw_item.Retrieve(	ls_todate, &
							is_plandate[1],						is_plandate[2], &
							is_plandate[3],						is_plandate[4], &
							is_plandate[5],						is_plandate[6], &
							is_plandate[7],						is_plandate[8], &
							is_plandate[9],						is_plandate[10], &
							is_plandate[11],						is_plandate[12], &
							is_plandate[13],						is_plandate[14], &
							is_plandate[15],						is_plandate[16], &
						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
//	dw_item.ScrolltoRow(1)
//	dw_item.Post Event RowFocusChanged(1)
Else
	MessageBox("일일생산계획 - 계획추가", &
						"선택하신 라인에는 일일생산계획을 추가할 수 있는" + &
						"~r~n제품이 없습니다." + &
						"~r~n~r~n다른 라인을 선택하여 주십시요.", StopSign!)
End If
end subroutine

on w_pisp061u.create
this.st_date=create st_date
this.dw_item=create dw_item
this.uo_line=create uo_line
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_3=create gb_3
this.Control[]={this.st_date,&
this.dw_item,&
this.uo_line,&
this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.gb_2,&
this.gb_4,&
this.gb_5,&
this.gb_3}
end on

on w_pisp061u.destroy
destroy(this.st_date)
destroy(this.dw_item)
destroy(this.uo_line)
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_3)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]
is_plandate[1]		= istr_parms.string_arg[2]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type st_date from statictext within w_pisp061u
integer x = 50
integer y = 88
integer width = 603
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "기준일:"
boolean focusrectangle = false
end type

type dw_item from u_vi_std_datawindow within w_pisp061u
integer x = 59
integer y = 304
integer width = 3799
integer height = 1428
integer taborder = 0
string dataobject = "d_pisp061u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_line from u_pisc_select_line within w_pisp061u
integer x = 2496
integer y = 80
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp061u
integer x = 1806
integer y = 80
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

type uo_division from u_pisc_select_division within w_pisp061u
integer x = 1193
integer y = 80
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_item.SetTransObject(SQLPIS)
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
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp061u
integer x = 704
integer y = 80
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_item.SetTransObject(SQLPIS)
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
	wf_retrieve()
End If
end event

type cb_2 from commandbutton within w_pisp061u
integer x = 3493
integer y = 64
integer width = 361
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;If ib_change Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type cb_1 from commandbutton within w_pisp061u
integer x = 3131
integer y = 64
integer width = 357
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "추 가(&I)"
end type

event clicked;Int		i, j, li_count
Long		ll_selected_count, ll_selected_rows[]
String	ls_itemcode, ls_plandate
Boolean	lb_error

ll_selected_count = f_pisc_dw_selected_row (dw_item, ll_selected_rows)
If ll_selected_count > 0 Then
	//
Else
	MessageBox("일일생산계획 - 계획추가", "일일생산계획을 추가하려는 제품을 선택하여 주십시오.", StopSign!)
	Return
End If

SQLPIS.AutoCommit = False
For i = ll_selected_count To 1 Step -1
	ls_itemcode	= Trim(dw_item.GetItemString(ll_selected_rows[i], "ItemCode"))
	For j = 1 To 16
		ls_plandate	= is_plandate[j]
	
		If j = 1 Then
			li_count = 0

			Select	Count(PlanDate)
			Into		:li_count
			From		tplanddrs
			Where		PlanDate			= :ls_plandate								And
						AreaCode			= :uo_area.is_uo_areacode				And
						DivisionCode	= :uo_division.is_uo_divisioncode	And
						ItemCode			= :ls_itemcode
			Using	SQLPIS;
			
			If li_count > 0 Then
				Update	tplanddrs
					Set	EtcQty01			= 1,
							LastEmp			= 'Y',
							LastDate			= GetDate()
				Where		PlanDate			= :ls_plandate								And
							AreaCode			= :uo_area.is_uo_areacode				And
							DivisionCode	= :uo_division.is_uo_divisioncode	And
							ItemCode			= :ls_itemcode
				Using SQLPIS;
			Else
				Insert Into tplanddrs(PlanDate,
											AreaCode,								DivisionCode,
											ItemCode,
											PlanQty,									PlanQty01,
											PlanQty02,								PlanQty03,
											PlanQty04,								PlanQty05,
											PlanQty06,								PlanQty07,
											PlanQty08,								PlanQty09,
											KDQty,									ASQty,
											EtcQty01,								EtcQty02,
											EtcQty03,
											LastEmp,									LastDate)
				Values					(:ls_plandate,
											:uo_area.is_uo_areacode,			:uo_division.is_uo_divisioncode,
											:ls_itemcode,
											0,											0,
											0,											0,
											0,											0,
											0,											0,
											0,											0,
											0,											0,
											1,											0,
											0,
											'Y',								GetDate())
				Using SQLPIS;
			End If
		End If
		
		// 계획을 변경하자.
		li_count = 0
	
		Select	Count(PlanDate)
		Into		:li_count
		From		tplanday
		Where		PlanDate			= :ls_plandate								And
					AreaCode			= :uo_area.is_uo_areacode				And
					DivisionCode	= :uo_division.is_uo_divisioncode	And
					WorkCenter		= :uo_workcenter.is_uo_workcenter	And
					LineCode			= :uo_line.is_uo_linecode			And
					ItemCode			= :ls_itemcode
		Using	SQLPIS;
		
		If li_count > 0 Then
//	계획이 있으면 건딜지 말것.
//			Update	tplanday
//				Set	PlanQty			= 0,
//						ChangeQty		= 0,
//						NormalKBCount	= 0,
//						NormalKBQty		= 0,
//						TempKBCount		= 0,
//						TempKBQty		= 0,
//						LastEmp			= :g_s_empno,
//						LastDate			= GetDate()
//			Where		PlanDate			= :ls_plandate								And
//						AreaCode			= :uo_area.is_uo_areacode				And
//						DivisionCode	= :uo_division.is_uo_divisioncode	And
//						WorkCenter		= :uo_workcenter.is_uo_workcenter	And
//						LineCode			= :uo_line.is_uo_linecode			And
//						ItemCode			= :ls_itemcode
//			Using SQLPIS;
//			If SQLPIS.sqlcode = 0 Then
//				lb_error	= False
//			Else
//				lb_error = True
//				Exit
//			End If
		Else
			Insert Into tplanday	(PlanDate,
										AreaCode,								DivisionCode,
										WorkCenter,								LineCode,
										ItemCode,
										PlanQty,									ChangeQty,
										NormalKBCount,							NormalKBQty,
										TempKBCount,							TempKBQty,
										LastEmp,									LastDate)
			Values					(:ls_plandate,
										:uo_area.is_uo_areacode,			:uo_division.is_uo_divisioncode,
										:uo_workcenter.is_uo_workcenter,	:uo_line.is_uo_linecode,
										:ls_itemcode,
										0,											0,
										0,											0,
										0,											0,
										'Y',								GetDate())
			Using SQLPIS;
			If SQLPIS.sqlcode = 0 Then
				lb_error	= False
			Else
				lb_error = True
				Exit
			End If
		End If
	Next
	If lb_error = True Then
		Exit
	End If
Next

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("일일생산계획 - 계획추가", "추가할 계획 정보를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_change = True
	MessageBox("일일생산계획 - 계획추가", "추가할 계획 정보를 저장하였습니다.", Information!)
	wf_retrieve()
End If
end event

type gb_1 from groupbox within w_pisp061u
integer x = 23
integer width = 654
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp061u
integer x = 681
integer width = 1093
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pisp061u
integer x = 1778
integer width = 1298
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_5 from groupbox within w_pisp061u
integer x = 3081
integer width = 823
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp061u
integer x = 23
integer y = 228
integer width = 3881
integer height = 1536
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "일일생산계획 추가 제품 선택"
borderstyle borderstyle = stylelowered!
end type

