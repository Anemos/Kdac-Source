$PBExportHeader$w_piso031u.srw
$PBExportComments$조마스터 - 사내외주 등록
forward
global type w_piso031u from window
end type
type cb_3 from commandbutton within w_piso031u
end type
type uo_division from u_pisc_select_division within w_piso031u
end type
type uo_area from u_pisc_select_area within w_piso031u
end type
type cb_2 from commandbutton within w_piso031u
end type
type cb_1 from commandbutton within w_piso031u
end type
type gb_1 from groupbox within w_piso031u
end type
type dw_supplier from datawindow within w_piso031u
end type
type gb_2 from groupbox within w_piso031u
end type
end forward

global type w_piso031u from window
integer width = 2633
integer height = 1328
boolean titlebar = true
string title = "사내외주 조마스터 등록"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
cb_3 cb_3
uo_division uo_division
uo_area uo_area
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
dw_supplier dw_supplier
gb_2 gb_2
end type
global w_piso031u w_piso031u

type variables
Boolean		ib_open, ib_save
str_parms	istr_parms
window		iw_sheet
datawindow	idw_1
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;dw_supplier.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

wf_retrieve()

ib_open = True
end event

public subroutine wf_retrieve ();
dw_supplier.ReSet()

dw_supplier.Retrieve(uo_area.is_uo_areacode, uo_division.is_uo_divisioncode)
end subroutine

on w_piso031u.create
this.cb_3=create cb_3
this.uo_division=create uo_division
this.uo_area=create uo_area
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.dw_supplier=create dw_supplier
this.gb_2=create gb_2
this.Control[]={this.cb_3,&
this.uo_division,&
this.uo_area,&
this.cb_2,&
this.cb_1,&
this.gb_1,&
this.dw_supplier,&
this.gb_2}
end on

on w_piso031u.destroy
destroy(this.cb_3)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.dw_supplier)
destroy(this.gb_2)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size		= istr_parms.string_arg[1]
iw_sheet		= istr_parms.window_arg[1]
idw_1			= istr_parms.datawindow_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type cb_3 from commandbutton within w_piso031u
integer x = 2089
integer y = 76
integer width = 411
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;//If ib_save Then
//	CloseWithReturn(Parent, "CHANGE")
//Else
	CloseWithReturn(Parent, "CANCEL")
//End If
end event

type uo_division from u_pisc_select_division within w_piso031u
integer x = 590
integer y = 96
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_supplier.SetTransObject(SQLPIS)
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_piso031u
integer x = 64
integer y = 96
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_supplier.SetTransObject(SQLPIS)
	wf_retrieve()
End If
end event

type cb_2 from commandbutton within w_piso031u
integer x = 1669
integer y = 76
integer width = 411
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저 장(&S)"
end type

event clicked;String	ls_areacode, ls_divisioncode, ls_workcenter, &
			ls_workcentername, ls_workcentergubun1, ls_workcentergubun2
Long		ll_row, ll_count, ll_find

ll_row	= dw_supplier.GetRow()

If ll_row > 0 Then
	//
Else
	MessageBox("조마스터", "등록하시려는 외주업체를 선택하십시오.", Exclamation!)
	Return
End If

dw_supplier.AcceptText()

ls_areacode				= uo_area.is_uo_areacode
ls_divisioncode		= uo_division.is_uo_divisioncode
ls_workcenter			= Trim(dw_supplier.GetItemString(ll_row, "SupplierCode"))
ls_workcentername		= Trim(dw_supplier.GetItemString(ll_row, "SupplierKorName"))
ls_workcentergubun1	= "S"
ls_workcentergubun2	= "A"

ll_count = 0

Select	Count(WorkCenter)
Into		:ll_count
From		tmstworkcenter
Where		AreaCode			= :ls_areacode			And
			DivisionCode	= :ls_divisioncode	And
			WorkCenter		= :ls_workcenter
Using SQLPIS;

If ll_count > 0 Then
	MessageBox("조마스터", "선택하신 외주업체는 이미 등록되어 있습니다." + &
									"~r~n~r~n새로운 새로운 외주업체를 등록하십시오.", StopSign!)
	Return
End If

If MessageBox("조마스터", "새로운 외주업체를 조마스터 정보로 저장하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

Insert	tmstworkcenter
Select	AreaCode				= :ls_areacode,
			DivisionCode		= :ls_divisioncode,
			WorkCenter			= :ls_workcenter,
			WorkCenterName		= :ls_workcentername,
			WorkCenterGubun1	= :ls_workcentergubun1,
			WorkCenterGubun2	= :ls_workcentergubun2,
			LastEmp				= 'Y',
			LastDate				= GetDate()
Using SQLPIS;
	
If SQLPIS.sqlcode = 0 Then
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	MessageBox("조마스터", "새로운 조마스터를 저장하였습니다.", Information!)
	wf_retrieve()
	iw_sheet.TriggerEvent("ue_retrieve")
	ll_find	= idw_1.Find("AreaCode = '" + ls_areacode + "' And " + &
								"DivisionCode = '" + ls_divisioncode + "' And " + &
								"WorkCenter = '" + ls_workcenter + "'", 1, idw_1.RowCount())
	If ll_find > 0 Then
		idw_1.SetRow(ll_find)
		idw_1.Trigger Event RowFocusChanged(ll_find)
		idw_1.ScrollToRow(ll_find)
	End If
Else
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("조마스터", "새로운 조마스터를 저장하는 중에 오류가 발생하였습니다.", StopSign!)
End If

end event

type cb_1 from commandbutton within w_piso031u
integer x = 1248
integer y = 76
integer width = 411
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조 회(&R)"
end type

event clicked;wf_retrieve()
end event

type gb_1 from groupbox within w_piso031u
integer x = 23
integer y = 16
integer width = 1161
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "공장 선택"
borderstyle borderstyle = stylelowered!
end type

type dw_supplier from datawindow within w_piso031u
integer x = 27
integer y = 236
integer width = 2537
integer height = 964
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso031u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

type gb_2 from groupbox within w_piso031u
integer x = 1189
integer y = 16
integer width = 1376
integer height = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

