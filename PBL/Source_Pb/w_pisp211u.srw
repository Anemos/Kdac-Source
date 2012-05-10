$PBExportHeader$w_pisp211u.srw
$PBExportComments$간판 마스터 - 마스터변경
forward
global type w_pisp211u from window
end type
type dw_save from datawindow within w_pisp211u
end type
type st_2 from statictext within w_pisp211u
end type
type dw_item_search from u_pisp_itemcode_input within w_pisp211u
end type
type cb_3 from commandbutton within w_pisp211u
end type
type uo_line from u_pisc_select_line within w_pisp211u
end type
type cb_1 from commandbutton within w_pisp211u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp211u
end type
type uo_division from u_pisc_select_division within w_pisp211u
end type
type uo_area from u_pisc_select_area within w_pisp211u
end type
type gb_2 from groupbox within w_pisp211u
end type
type dw_item from datawindow within w_pisp211u
end type
type gb_4 from groupbox within w_pisp211u
end type
type gb_5 from groupbox within w_pisp211u
end type
type gb_1 from groupbox within w_pisp211u
end type
type gb_3 from groupbox within w_pisp211u
end type
type dw_detail from datawindow within w_pisp211u
end type
type gb_6 from groupbox within w_pisp211u
end type
type dw_save_1 from datawindow within w_pisp211u
end type
end forward

global type w_pisp211u from window
integer width = 3854
integer height = 1944
boolean titlebar = true
string title = "간판 마스터 변경"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
dw_save dw_save
st_2 st_2
dw_item_search dw_item_search
cb_3 cb_3
uo_line uo_line
cb_1 cb_1
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
gb_2 gb_2
dw_item dw_item
gb_4 gb_4
gb_5 gb_5
gb_1 gb_1
gb_3 gb_3
dw_detail dw_detail
gb_6 gb_6
dw_save_1 dw_save_1
end type
global w_pisp211u w_pisp211u

type variables
Boolean		ib_open, ib_change, ib_save
String		is_saveflag	= ""	// "UPDATE" 이미 등록된 간판마스터를 변경 저장
										// "INSERT" 새롭게 간판마스터를 추가하는 경우
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;dw_item.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
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

wf_retrieve()

ib_open = True
end event

public subroutine wf_retrieve ();ib_change		= False
is_saveflag		= ""

dw_item.ReSet()
dw_detail.ReSet()
dw_save.ReSet()
dw_save_1.ReSet()

If dw_item.Retrieve(uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
							uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
Else
	MessageBox("간판 마스터 변경", "간판 마스터를 변경할 제품이 존재하지 않습니다.")
End If

dw_item_search.Reset()
dw_item_search.InsertRow(1)
dw_item_search.SetColumn(1)
dw_item_search.SetRow(1)
dw_item_search.SetFocus()
end subroutine

on w_pisp211u.create
this.dw_save=create dw_save
this.st_2=create st_2
this.dw_item_search=create dw_item_search
this.cb_3=create cb_3
this.uo_line=create uo_line
this.cb_1=create cb_1
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.gb_2=create gb_2
this.dw_item=create dw_item
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_1=create gb_1
this.gb_3=create gb_3
this.dw_detail=create dw_detail
this.gb_6=create gb_6
this.dw_save_1=create dw_save_1
this.Control[]={this.dw_save,&
this.st_2,&
this.dw_item_search,&
this.cb_3,&
this.uo_line,&
this.cb_1,&
this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.gb_2,&
this.dw_item,&
this.gb_4,&
this.gb_5,&
this.gb_1,&
this.gb_3,&
this.dw_detail,&
this.gb_6,&
this.dw_save_1}
end on

on w_pisp211u.destroy
destroy(this.dw_save)
destroy(this.st_2)
destroy(this.dw_item_search)
destroy(this.cb_3)
destroy(this.uo_line)
destroy(this.cb_1)
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.gb_2)
destroy(this.dw_item)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.dw_detail)
destroy(this.gb_6)
destroy(this.dw_save_1)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type dw_save from datawindow within w_pisp211u
integer x = 1371
integer y = 716
integer width = 937
integer height = 436
boolean titlebar = true
string title = "변경된 간판마스터 저장"
string dataobject = "d_pisp211u_03_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type st_2 from statictext within w_pisp211u
integer x = 59
integer y = 304
integer width = 160
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "품번:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_item_search from u_pisp_itemcode_input within w_pisp211u
integer x = 233
integer y = 288
integer taborder = 0
end type

event ue_enter;call super::ue_enter;String	ls_itemcode, ls_itemcode_check
dwobject ldwo_this

ls_itemcode_check	= Trim(GetItemString(1,1))
AcceptText()
ls_itemcode			= Trim(GetItemString(1,1))

If ls_itemcode_check = ls_itemcode Then
	Post Event ItemChanged(1, ldwo_this, ls_itemcode)
End If
end event

event itemchanged;call super::itemchanged;Long		ll_find
String	ls_itemcode

ls_itemcode	= Trim(Data)

ll_find	= dw_item.Find("ItemCode = '" + ls_itemcode + "' ", 1, dw_item.RowCount())

If ll_find > 0 Then
	dw_item.Trigger Event RowFocusChanged(ll_find)
	dw_item.ScrollToRow(ll_find)
	dw_item.SetRow(ll_find)
Else
	MessageBox("간판 마스터 추가", "입력하신 제품은 등록이 불가능 합니다." + &
											"~r~n~r~n'제품선택' 항목에 조회된 제품을 입력하십시오.")
End If

dw_item_search.Reset()
dw_item_search.InsertRow(1)
dw_item_search.SetColumn(1)
dw_item_search.SetRow(1)
dw_item_search.SetFocus()
end event

type cb_3 from commandbutton within w_pisp211u
integer x = 3145
integer y = 56
integer width = 425
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;If ib_save Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type uo_line from u_pisc_select_line within w_pisp211u
integer x = 1861
integer y = 64
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type cb_1 from commandbutton within w_pisp211u
integer x = 2597
integer y = 56
integer width = 425
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저 장(&S)"
end type

event clicked;Int		li_count, li_rackqty, li_lotsize, li_dividerate, li_pcsperhour, &
			li_safetyinvqty, li_sortorder
String	ls_applydate_close, ls_areacode, ls_divisioncode, ls_workcenter, &
			ls_linecode, ls_itemcode, &
			ls_modelid, ls_productgubun, ls_lineid, ls_kbid, &
			ls_normalkbsn, ls_tempkbsn, ls_stockgubun, ls_prdstopgubun, &
			ls_rackcode, ls_carname, ls_mainlinegubun, ls_stocklocation, &
			ls_errortext
Real		lr_kbfactor, lr_safetyfactor
Boolean	lb_error

If is_saveflag = "UPDATE" Then
	If ib_change = False Then
		MessageBox("간판 마스터 변경","변경된 간판 마스터 정보가 없습니다.")
		Return
	End If
	
	If MessageBox("간판 마스터 변경", "등록되어 있던 간판마스터를 변경하시겠습니까?", &
														Question!, YesNo!, 2) = 2 Then
		Return
	End If
Else
	If MessageBox("간판 마스터 변경", "새로운 간판마스터를 추가하시겠습니까?", &
								Question!, YesNo!, 2) = 2 Then
		Return
	End If
End If

dw_detail.AcceptText()

ls_areacode			= Trim(dw_detail.GetItemString(1, "AreaCode"))
ls_divisioncode	= Trim(dw_detail.GetItemString(1, "DivisionCode"))
ls_workcenter		= Trim(dw_detail.GetItemString(1, "WorkCenter"))
ls_linecode			= Trim(dw_detail.GetItemString(1, "LineCode"))
ls_itemcode			= Trim(dw_detail.GetItemString(1, "ItemCode"))

ls_applydate_close	= f_pisc_get_date_applydate(ls_areacode, ls_divisioncode, f_pisc_get_date_nowtime())

ls_modelid			= Trim(dw_detail.GetItemString(1, "ModelID"))
//ls_applyfrom		= Trim(dw_detail.GetItemString(1, "ApplyFrom"))
ls_lineid			= Trim(dw_detail.GetItemString(1, "LineID"))
ls_kbid				= Trim(dw_detail.GetItemString(1, "KBID"))
ls_normalkbsn		= Trim(dw_detail.GetItemString(1, "NormalKBSN"))
ls_tempkbsn			= Trim(dw_detail.GetItemString(1, "TempKBSN"))
ls_productgubun	= Trim(dw_detail.GetItemString(1, "ProductGubun"))
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

If Len(ls_linecode) > 0 And IsNull(ls_linecode) = False Then
	//
Else	
	MessageBox("간판 마스터 변경", "정확한 라인을 선택하여 주십시요.", StopSign!)
	Return
End If

If li_rackqty > 0 Then
	//
Else	
	MessageBox("간판 마스터 변경", "수용수는 '0'보다 커야 합니다.", StopSign!)
	Return
End If

If Len(ls_modelid) = 0 Or IsNull(ls_modelid) = True Or ls_modelid = '' Then
	MessageBox("간판 마스터 변경", "정확한 '식별ID' 을 입력하십시오", StopSign!)
	Return
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
		MessageBox("간판 마스터 변경", "다른 간판마스터의 제품과 동일한 '식별ID' 입니다." + &
												"~r~n~r~n새로운 식별ID 을 입력하십시오", StopSign!)
		Return
	End If
End If

If is_saveflag = "UPDATE" Then
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
		MessageBox("간판 마스터 변경", "변경된 간판 마스터 정보를 저장하는 도중에 오류가 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
	Else
		Commit Using SQLPIS;
		SQLPIS.AutoCommit = True
		ib_save			= True
		ib_change		= False
		is_saveflag		= ""
		MessageBox("간판 마스터 변경", "변경된 간판 마스터 정보를 저장하였습니다.", Information!)
		wf_retrieve()
	End If
Else
	// Line ID 을 구하자.
	SetNull(ls_lineid)
	Select	LineID
	Into		:ls_lineid
	From		tmstline
	Where		AreaCode 		= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				WorkCenter		= :ls_workcenter		And
				LineCode			= :ls_linecode
	Using SQLPIS;

	If IsNull(ls_lineid) Or Len(ls_lineid) < 1 Or ls_lineid = "X" Or ls_lineid = "" Then
		Select	Max(LineID)
		Into		:ls_lineid
		From		tmstline
		Where		AreaCode 		= :ls_areacode			And
					DivisionCode	= :ls_divisioncode
		Using SQLPIS;

		If IsNull(ls_lineid) Or Len(ls_lineid) < 1 Or ls_lineid = "X" Or ls_lineid = "" Then
			ls_lineid = '01'
		Else
			If f_pisc_get_string_add(ls_lineid, ls_lineid) Then
				//
			Else
				MessageBox("간판 마스터 변경", "'라인ID' 을 더이상 생성할 수 없습니다.", StopSign!)
				Return
			End If
//			ls_lineid = Right('00' + String(Integer(ls_lineid) + 1), 2)
		End If
		
		// 이건 그냥 Update 하자...헤헤
		Update	tmstline
		Set		LineID			= :ls_lineid,
					LastEmp			= 'Y',
					LastDate			= GetDate()
		Where		AreaCode			= :ls_areacode			And
					DivisionCode	= :ls_divisioncode	And
					WorkCenter		= :ls_workcenter		And
					LineCode			= :ls_linecode
		Using SQLPIS;
	End If

	// KB ID 을 구하자
	// KB ID 은 라인단위로 하지 말구...공장 단위로 구하도록 하자...
	SetNull(ls_kbid)
	Select	KBID
	Into		:ls_kbid
	From		tmstkb
	Where		AreaCode 		= :ls_areacode			And
				DivisionCode	= :ls_divisioncode	And
				ItemCode			= :ls_itemcode
	Using SQLPIS;

	If IsNull(ls_kbid) Or Len(ls_kbid) < 1 Or ls_kbid = "" Then
		// KB ID 은 라인단위로 하지 말구...공장 단위로 구하도록 하자...
		Select	Max(KBID)
		Into		:ls_kbid
		From		tmstkb
		Where		AreaCode 		= :ls_areacode			And
					DivisionCode	= :ls_divisioncode
		Using SQLPIS;
	
		If IsNull(ls_kbid) Or Len(ls_kbid) < 1 Or ls_kbid = "" Then
			ls_kbid = '0001'
		Else
			If f_pisc_get_string_add(ls_kbid, ls_kbid) Then
				//
			Else
				MessageBox("간판 마스터 변경", "'간판ID' 을 더이상 생성할 수 없습니다.", StopSign!)
				Return
			End If
	//		ls_kbid = Right('0000' + String(Integer(ls_kbid) + 1), 4)
		End If
	End If
	// 간판번호 순번을 구하자
	ls_normalkbsn	= ls_areacode + ls_divisioncode + ls_lineid + ls_kbid + "000"
	ls_tempkbsn		= ls_areacode + ls_divisioncode + ls_lineid + ls_kbid + "X00"

	SQLPIS.AutoCommit = False
	dw_save_1.ReSet()
	If dw_save_1.Retrieve(	ls_areacode,				ls_divisioncode, &
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
		If Upper(dw_save_1.GetItemString(1, "Error")) = "00" Then
			lb_error	= False
			ls_errortext	= Trim(dw_save_1.GetItemString(1, "ErrorText"))
		Else
			lb_error = True
			ls_errortext	= Trim(dw_save_1.GetItemString(1, "ErrorText"))
		End If
	Else
		lb_error = True
		ls_errortext	= "간판 마스터 추가를 시도하였지만 오류가 발생했습니다."
	End If

	If lb_error Then
		RollBack Using SQLPIS;
		SQLPIS.AutoCommit = True
		MessageBox("간판 마스터 변경", "변경된 간판 마스터 정보를 추가하는 도중에 오류가 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
	Else
		Commit Using SQLPIS;
		SQLPIS.AutoCommit = True
		ib_save			= True
		ib_change		= False
		is_saveflag		= ""
		MessageBox("간판 마스터 변경", "변경된 간판 마스터 정보를 추가하였습니다.", Information!)
		wf_retrieve()
	End If
End If


//Int		li_count, li_sortorder_old
//String	ls_applydate_close, ls_areacode, ls_divisioncode, ls_workcenter, &
//			ls_linecode, ls_itemcode, &
//			ls_modelid, ls_productgubun, ls_applyfrom, ls_lineid, ls_kbid, &
//			ls_normalkbsn, ls_tempkbsn, ls_stockgubun, ls_prdstopgubun, &
//			ls_rackcode, ls_mainlinegubun, ls_stocklocation
//Long		ll_rackqty, ll_lotsize, ll_dividerate, ll_pcsperhour, &
//			ll_safetyinvqty, ll_sortorder
//Real		lr_kbfactor, lr_safetyfactor
//Boolean	lb_error
//
//If ib_change = False Then
//	MessageBox("간판 마스터 변경","변경된 간판 마스터 정보가 없습니다.")
//	Return
//End If
//
//If is_saveflag = "UPDATE" Then
//	If MessageBox("간판 마스터 변경", "기 등록되어 있던 간판마스터를 변경하시겠습니까?", &
//														Question!, YesNo!, 2) = 2 Then
//		Return
//	End If
//Else
//	If MessageBox("간판 마스터 변경", "새로운 간판마스터를 추가하시겠습니까?", &
//								Question!, YesNo!, 2) = 2 Then
//		Return
//	End If
//End If
//
//dw_detail.AcceptText()
//
//ls_areacode			= Trim(dw_detail.GetItemString(1, "AreaCode"))
//ls_divisioncode	= Trim(dw_detail.GetItemString(1, "DivisionCode"))
//ls_workcenter		= Trim(dw_detail.GetItemString(1, "WorkCenter"))
//ls_linecode			= Trim(dw_detail.GetItemString(1, "LineCode"))
//ls_itemcode			= Trim(dw_detail.GetItemString(1, "ItemCode"))
//
//ls_applydate_close	= f_pisc_get_date_applydate(ls_areacode, ls_divisioncode, f_pisc_get_date_nowtime())
//
//ls_modelid			= Trim(dw_detail.GetItemString(1, "ModelID"))
//ls_productgubun	= Trim(dw_detail.GetItemString(1, "ProductGubun"))
//ls_applyfrom		= Trim(dw_detail.GetItemString(1, "ApplyFrom"))
//ls_lineid			= Trim(dw_detail.GetItemString(1, "LineID"))
//ls_kbid				= Trim(dw_detail.GetItemString(1, "KBID"))
//ls_normalkbsn		= Trim(dw_detail.GetItemString(1, "NormalKBSN"))
//ls_tempkbsn			= Trim(dw_detail.GetItemString(1, "TempKBSN"))
//ls_stockgubun		= Trim(dw_detail.GetItemString(1, "StockGubun"))
//ls_prdstopgubun	= Trim(dw_detail.GetItemString(1, "PrdStopGubun"))
//ls_rackcode			= Trim(dw_detail.GetItemString(1, "RackCode"))
//ll_rackqty			= dw_detail.GetItemNumber(1, "RackQty")
//ll_lotsize			= dw_detail.GetItemNumber(1, "LotSize")
//ls_mainlinegubun	= Trim(dw_detail.GetItemString(1, "MainLineGubun"))
//ll_dividerate		= dw_detail.GetItemNumber(1, "DivideRate")
//ll_pcsperhour		= dw_detail.GetItemNumber(1, "PCSPerHour")
//ll_safetyinvqty	= dw_detail.GetItemNumber(1, "SafetyInvQty")
//lr_kbfactor			= dw_detail.GetItemNumber(1, "KBFactor")
//lr_safetyfactor	= dw_detail.GetItemNumber(1, "SafetyFactor")
//ls_stocklocation	= Trim(dw_detail.GetItemString(1, "StockLocation"))
//ll_sortorder		= dw_detail.GetItemNumber(1, "SortOrder")
//
//If ll_rackqty < 1 Then
//	MessageBox("간판 마스터 변경", "수용수는 '0'보다 커야 합니다.", StopSign!)
//	Return
//End If
//
//If Len(ls_modelid) > 0 Then
//	Select	Count(ModelID)
//	Into		:li_count
//	From		tmstkb
//	Where		AreaCode			= :ls_areacode			And
//				DivisionCode	= :ls_divisioncode	And
//				ItemCode			<> :ls_itemcode		And
//				ModelID			= :ls_modelid
//	Using	SQLPIS;
//	
//	If li_count > 0 Then
//		MessageBox("간판 마스터 변경", "다른 간판마스터의 제품과 동일한 '식별ID' 입니다." + &
//												"~r~n~r~n새로운 식별ID 을 입력하십시오", StopSign!)
//		Return
//	End If
//End If
//
//If is_saveflag = "UPDATE" Then
//	If dw_item.GetRow() > 0 Then
//		li_sortorder_old	= dw_item.GetItemNumber(dw_item.GetRow(), "SortOrder")
//	Else
//		li_sortorder_old	= ll_sortorder
//	End If
//
//	SQLPIS.AutoCommit = False
//	
//	Update	tmstkb
//	Set		ModelID				= :ls_modelid,
//				ProductGubun		= :ls_productgubun,
//				ApplyFrom			= :ls_applydate_close,
//				LineID				= :ls_lineid,
//				KBID					= :ls_kbid,
//				NormalKBSN			= :ls_normalkbsn,
//				TempKBSN				= :ls_tempkbsn,
//				StockGubun			= :ls_stockgubun,
//				PrdStopGubun		= :ls_prdstopgubun,
//				RackCode				= :ls_rackcode,
//				RackQty				= :ll_rackqty,
//				LotSize				= :ll_lotsize,
//				MainLineGubun		= :ls_mainlinegubun,
//				DivideRate			= :ll_dividerate,
//				PCSPerHour			= :ll_pcsperhour,
//				SafetyInvQty		= :ll_safetyinvqty,
//				KBFactor				= :lr_kbfactor,
//				SafetyFactor		= :lr_safetyfactor,
//				StockLocation		= :ls_stocklocation,
//				SortOrder			= :ll_sortorder,
//				LastEmp				= :g_s_empno,
//				LastDate				= GetDate()
//	Where		AreaCode			= :ls_areacode			And
//				DivisionCode	= :ls_divisioncode	And
//				WorkCenter		= :ls_workcenter		And
//				LineCode			= :ls_linecode			And
//				ItemCode			= :ls_itemcode
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터 정보를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//	Update	tmstkbhis
//	Set		ApplyTo				= :ls_applydate_close,
//				LastEmp				= :g_s_empno,
//				LastDate				= GetDate()
//	Where		AreaCode			= :ls_areacode				And
//				DivisionCode	= :ls_divisioncode		And
//				WorkCenter		= :ls_workcenter			And
//				LineCode			= :ls_linecode				And
//				ItemCode			= :ls_itemcode				And
//				ApplyFrom		<= :ls_applydate_close	And
//				ApplyTo			> :ls_applydate_close			
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터 이력을 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//	
//	Insert Into	tmstkbhis	(	AreaCode,				DivisionCode,		WorkCenter,
//										LineCode,				ItemCode,			ApplyFrom,
//										ApplyTo,					ModelID,				LineID,
//										KBID,						NormalKBSN,			TempKBSN,
//										ProductGubun,			StockGubun,			PrdStopGubun,
//										RackCode,				RackQty,				LotSize,
//										MainLineGubun,			DivideRate,			PCSPerHour,
//										SafetyInvQty,			KBFactor,			SafetyFactor,
//										StockLocation,			SortOrder,			LastEmp,
//										LastDate)
//	Values						(	:ls_areacode,			:ls_divisioncode, :ls_workcenter,
//										:ls_linecode,			:ls_itemcode,		:ls_applydate_close,
//										'9999.12.31',			:ls_modelid,		:ls_lineid,
//										:ls_kbid,				:ls_normalkbsn,	:ls_tempkbsn,
//										:ls_productgubun,		:ls_stockgubun,	:ls_prdstopgubun,
//										:ls_rackcode,			:ll_rackqty,		:ll_lotsize,
//										:ls_mainlinegubun,	:ll_dividerate,	:ll_pcsperhour,
//										:ll_safetyinvqty,		:lr_kbfactor,		:lr_safetyfactor,
//										:ls_stocklocation,	:ll_sortorder,		:g_s_empno,
//										GetDate())
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터 이력을 추가하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//	Update	tmstkb
//	Set		ModelID				= :ls_modelid,
//				ProductGubun		= :ls_productgubun,
//				StockGubun			= :ls_stockgubun,
//				RackQty				= :ll_rackqty,
//				SafetyInvQty		= :ll_safetyinvqty,
//				StockLocation		= :ls_stocklocation,
//				SortOrder			= :ll_sortorder,
//				LastEmp				= :g_s_empno,
//				LastDate				= GetDate()
//	Where		AreaCode			= :ls_areacode			And
//				DivisionCode	= :ls_divisioncode	And
//				(WorkCenter		<> :ls_workcenter	Or	LineCode	<> :ls_linecode)	And
//				ItemCode			= :ls_itemcode
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터의 타 제품을 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//	Update	tmstkbhis
//	Set		ModelID				= :ls_modelid,
//				ProductGubun		= :ls_productgubun,
//				StockGubun			= :ls_stockgubun,
//				RackQty				= :ll_rackqty,
//				SafetyInvQty		= :ll_safetyinvqty,
//				StockLocation		= :ls_stocklocation,
//				SortOrder			= :ll_sortorder,
//				LastEmp				= :g_s_empno,
//				LastDate				= GetDate()
//	Where		AreaCode			= :ls_areacode				And
//				DivisionCode	= :ls_divisioncode		And
//				(WorkCenter		<> :ls_workcenter	Or	LineCode	<> :ls_linecode)	And
//				ItemCode			= :ls_itemcode				And
//				ApplyTo			= '9999.12.31'
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터 이력의 타 제품을 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//	// 조회순서가 변경된 경우만...처리하자.
//	If ll_sortorder <> li_sortorder_old Then
//		If ll_sortorder > li_sortorder_old Then
//			Update	tmstkb
//			Set		SortOrder			= SortOrder - 1,
//						LastEmp				= :g_s_empno,
//						LastDate				= GetDate()
//			Where		AreaCode			= :ls_areacode			And
//						DivisionCode	= :ls_divisioncode	And
//						WorkCenter		= :ls_workcenter		And
//						LineCode			= :ls_linecode			And
//						ItemCode			<> :ls_itemcode		And
//						(SortOrder		Between :li_sortorder_old And :ll_sortorder)
//			Using SQLPIS;
//			
//			If SQLPIS.sqlcode = 0 Then
//				lb_error	= False
//			Else
//				RollBack Using SQLPIS;
//				SQLPIS.AutoCommit = True
//				lb_error	= True
//				MessageBox("간판 마스터 변경", "간판 마스터의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//				Return
//			End If
//			
//			Update	tmstkbhis
//			Set		SortOrder			= SortOrder - 1,
//						LastEmp				= :g_s_empno,
//						LastDate				= GetDate()
//			Where		AreaCode			= :ls_areacode			And
//						DivisionCode	= :ls_divisioncode	And
//						WorkCenter		= :ls_workcenter		And
//						LineCode			= :ls_linecode			And
//						ItemCode			<> :ls_itemcode		And
//						ApplyTo			= '9999.12.31'			And
//						(SortOrder		Between :li_sortorder_old And :ll_sortorder)
//			Using SQLPIS;
//			
//			If SQLPIS.sqlcode = 0 Then
//				lb_error	= False
//			Else
//				RollBack Using SQLPIS;
//				SQLPIS.AutoCommit = True
//				lb_error	= True
//				MessageBox("간판 마스터 변경", "간판 마스터 이력의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//				Return
//			End If
//		Else
//			Update	tmstkb
//			Set		SortOrder			= SortOrder + 1,
//						LastEmp				= :g_s_empno,
//						LastDate				= GetDate()
//			Where		AreaCode			= :ls_areacode			And
//						DivisionCode	= :ls_divisioncode	And
//						WorkCenter		= :ls_workcenter		And
//						LineCode			= :ls_linecode			And
//						ItemCode			<> :ls_itemcode		And
//						(SortOrder		Between :ll_sortorder And :li_sortorder_old)
//			Using SQLPIS;
//			
//			If SQLPIS.sqlcode = 0 Then
//				lb_error	= False
//			Else
//				RollBack Using SQLPIS;
//				SQLPIS.AutoCommit = True
//				lb_error	= True
//				MessageBox("간판 마스터 변경", "간판 마스터의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//				Return
//			End If
//			
//			Update	tmstkbhis
//			Set		SortOrder			= SortOrder + 1,
//						LastEmp				= :g_s_empno,
//						LastDate				= GetDate()
//			Where		AreaCode			= :ls_areacode			And
//						DivisionCode	= :ls_divisioncode	And
//						WorkCenter		= :ls_workcenter		And
//						LineCode			= :ls_linecode			And
//						ItemCode			<> :ls_itemcode		And
//						ApplyTo			= '9999.12.31'			And
//						(SortOrder		Between :ll_sortorder And :li_sortorder_old)
//			Using SQLPIS;
//			
//			If SQLPIS.sqlcode = 0 Then
//				lb_error	= False
//			Else
//				RollBack Using SQLPIS;
//				SQLPIS.AutoCommit = True
//				lb_error	= True
//				MessageBox("간판 마스터 변경", "간판 마스터 이력의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//				Return
//			End If
//		End If
//	End If
//	
//	If lb_error Then
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		MessageBox("간판 마스터 변경", "변경된 간판 마스터 정보를 저장하는 도중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	Else
//		Commit Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		ib_save			= True
//		ib_change		= False
//		is_saveflag		= ""
//		MessageBox("간판 마스터 변경", "변경된 간판 마스터 정보를 저장하였습니다.", StopSign!)
//		wf_retrieve()
//		Return
//	End If
//	Return
//Else			// 새로운 간판 추가
//	// Line ID 을 구하자.
//	SetNull(ls_lineid)
//	Select	LineID
//	Into		:ls_lineid
//	From		tmstline
//	Where		AreaCode 		= :ls_areacode			And
//				DivisionCode	= :ls_divisioncode	And
//				WorkCenter		= :ls_workcenter		And
//				LineCode			= :ls_linecode
//	Using SQLPIS;
//
//	If IsNull(ls_lineid) Or Len(ls_lineid) < 1 Or ls_lineid = "X" Then
//		Select	Max(LineID)
//		Into		:ls_lineid
//		From		tmstline
//		Where		AreaCode 		= :ls_areacode			And
//					DivisionCode	= :ls_divisioncode
//		Using SQLPIS;
//
//		If IsNull(ls_lineid) Or Len(ls_lineid) < 1 Or ls_lineid = "X" Then
//			ls_lineid = '01'
//		Else
//			If f_pisc_get_addstring(ls_lineid, ls_lineid) Then
//				//
//			Else
//				MessageBox("간판 마스터 변경", "'라인ID' 을 더이상 생성할 수 없습니다.", StopSign!)
//				Return
//			End If
////			ls_lineid = Right('00' + String(Integer(ls_lineid) + 1), 2)
//		End If
//		
//		// 이건 그냥 Update 하자...헤헤
//		Update	tmstline
//		Set		LineID			= :ls_lineid,
//					LastEmp			= :g_s_empno,
//					LastDate			= GetDate()
//		Where		AreaCode			= :ls_areacode			And
//					DivisionCode	= :ls_divisioncode	And
//					WorkCenter		= :ls_workcenter		And
//					LineCode			= :ls_linecode
//		Using SQLPIS;		
////		If SQLPIS.sqlcode = 0 Then
////			lb_error	= False
////			Commit Using SQLPIS;
////		Else
////			RollBack Using SQLPIS;
////			SQLPIS.AutoCommit = True
////			lb_error	= True
////			MessageBox("간판 마스터 변경", "간판 마스터 이력의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
////			Return
////		End If
//	End If
//
//	// KB ID 을 구하자
//	// KB ID 은 라인단위로 하지 말구...조 단위로 구하도록 하자...
//	SetNull(ls_kbid)
//	Select	Max(KBID)
//	Into		:ls_kbid
//	From		tmstkb
//	Where		AreaCode 		= :ls_areacode			And
//				DivisionCode	= :ls_divisioncode	And
//				WorkCenter		= :ls_workcenter
//	Using SQLPIS;
//
//	If IsNull(ls_kbid) Or Len(ls_lineid) < 1 Then
//		ls_kbid = '0001'
//	Else
//		If f_pisc_get_addstring(ls_kbid, ls_kbid) Then
//			//
//		Else
//			MessageBox("간판 마스터 변경", "'간판ID' 을 더이상 생성할 수 없습니다.", StopSign!)
//			Return
//		End If
////		ls_kbid = Right('0000' + String(Integer(ls_kbid) + 1), 4)
//	End If
//
//	// 간판번호 순번을 구하자
//	ls_normalkbsn	= ls_areacode + ls_divisioncode + ls_lineid + ls_kbid + "000"
//	ls_tempkbsn		= ls_areacode + ls_divisioncode + ls_lineid + ls_kbid + "X00"
//
//	SQLPIS.AutoCommit = False
//	
//	Insert Into	tmstkb	(	AreaCode,				DivisionCode,		WorkCenter,
//									LineCode,				ItemCode,			ApplyFrom,
//									ModelID,					LineID,
//									KBID,						NormalKBSN,			TempKBSN,
//									ProductGubun,			StockGubun,			PrdStopGubun,
//									RackCode,				RackQty,				LotSize,
//									MainLineGubun,			DivideRate,			PCSPerHour,
//									SafetyInvQty,			KBFactor,			SafetyFactor,
//									StockLocation,			SortOrder,			LastEmp,
//									LastDate)
//	Values					(	:ls_areacode,			:ls_divisioncode, :ls_workcenter,
//									:ls_linecode,			:ls_itemcode,		:ls_applydate_close,
//									:ls_modelid,			:ls_lineid,
//									:ls_kbid,				:ls_normalkbsn,	:ls_tempkbsn,
//									:ls_productgubun,		:ls_stockgubun,	:ls_prdstopgubun,
//									:ls_rackcode,			:ll_rackqty,		:ll_lotsize,
//									:ls_mainlinegubun,	:ll_dividerate,	:ll_pcsperhour,
//									:ll_safetyinvqty,		:lr_kbfactor,		:lr_safetyfactor,
//									:ls_stocklocation,	:ll_sortorder,		:g_s_empno,
//									GetDate())
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터 정보를 추가하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//	Insert Into	tmstkbhis	(	AreaCode,				DivisionCode,		WorkCenter,
//										LineCode,				ItemCode,			ApplyFrom,
//										ApplyTo,					ModelID,				LineID,
//										KBID,						NormalKBSN,			TempKBSN,
//										ProductGubun,			StockGubun,			PrdStopGubun,
//										RackCode,				RackQty,				LotSize,
//										MainLineGubun,			DivideRate,			PCSPerHour,
//										SafetyInvQty,			KBFactor,			SafetyFactor,
//										StockLocation,			SortOrder,			LastEmp,
//										LastDate)
//	Values						(	:ls_areacode,			:ls_divisioncode, :ls_workcenter,
//										:ls_linecode,			:ls_itemcode,		:ls_applydate_close,
//										'9999.12.31',			:ls_modelid,		:ls_lineid,
//										:ls_kbid,				:ls_normalkbsn,	:ls_tempkbsn,
//										:ls_productgubun,		:ls_stockgubun,	:ls_prdstopgubun,
//										:ls_rackcode,			:ll_rackqty,		:ll_lotsize,
//										:ls_mainlinegubun,	:ll_dividerate,	:ll_pcsperhour,
//										:ll_safetyinvqty,		:lr_kbfactor,		:lr_safetyfactor,
//										:ls_stocklocation,	:ll_sortorder,		:g_s_empno,
//										GetDate())
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터 이력을 추가하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//	Update	tmstkb
//	Set		ModelID				= :ls_modelid,
//				ProductGubun		= :ls_productgubun,
//				StockGubun			= :ls_stockgubun,
//				RackQty				= :ll_rackqty,
//				SafetyInvQty		= :ll_safetyinvqty,
//				StockLocation		= :ls_stocklocation,
//				SortOrder			= :ll_sortorder,
//				LastEmp				= :g_s_empno,
//				LastDate				= GetDate()
//	Where		AreaCode			= :ls_areacode			And
//				DivisionCode	= :ls_divisioncode	And
//				(WorkCenter		<> :ls_workcenter	Or	LineCode	<> :ls_linecode)	And
//				ItemCode			= :ls_itemcode
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터의 타 제품을 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//	Update	tmstkbhis
//	Set		ModelID				= :ls_modelid,
//				ProductGubun		= :ls_productgubun,
//				StockGubun			= :ls_stockgubun,
//				RackQty				= :ll_rackqty,
//				SafetyInvQty		= :ll_safetyinvqty,
//				StockLocation		= :ls_stocklocation,
//				SortOrder			= :ll_sortorder,
//				LastEmp				= :g_s_empno,
//				LastDate				= GetDate()
//	Where		AreaCode			= :ls_areacode				And
//				DivisionCode	= :ls_divisioncode		And
//				(WorkCenter		<> :ls_workcenter	Or	LineCode	<> :ls_linecode)	And
//				ItemCode			= :ls_itemcode				And
//				ApplyTo			= '9999.12.31'
//	Using SQLPIS;
//	
//	If SQLPIS.sqlcode = 0 Then
//		lb_error	= False
//	Else
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		lb_error	= True
//		MessageBox("간판 마스터 변경", "간판 마스터 이력의 타 제품을 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	End If
//	
//		Update	tmstkb
//		Set		SortOrder			= SortOrder + 1,
//					LastEmp				= :g_s_empno,
//					LastDate				= GetDate()
//		Where		AreaCode			= :ls_areacode			And
//					DivisionCode	= :ls_divisioncode	And
//					WorkCenter		= :ls_workcenter		And
//					LineCode			= :ls_linecode			And
//					ItemCode			<> :ls_itemcode		And
//					SortOrder		>= :ll_sortorder
//		Using SQLPIS;
//		
//		If SQLPIS.sqlcode = 0 Then
//			lb_error	= False
//		Else
//			RollBack Using SQLPIS;
//			SQLPIS.AutoCommit = True
//			lb_error	= True
//			MessageBox("간판 마스터 변경", "간판 마스터의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//			Return
//		End If
//		
//		Update	tmstkbhis
//		Set		SortOrder			= SortOrder - 1,
//					LastEmp				= :g_s_empno,
//					LastDate				= GetDate()
//		Where		AreaCode			= :ls_areacode			And
//					DivisionCode	= :ls_divisioncode	And
//					WorkCenter		= :ls_workcenter		And
//					LineCode			= :ls_linecode			And
//					ItemCode			<> :ls_itemcode		And
//					ApplyTo			= '9999.12.31'			And
//					SortOrder		>= :ll_sortorder
//		Using SQLPIS;
//		
//		If SQLPIS.sqlcode = 0 Then
//			lb_error	= False
//		Else
//			RollBack Using SQLPIS;
//			SQLPIS.AutoCommit = True
//			lb_error	= True
//			MessageBox("간판 마스터 변경", "간판 마스터 이력의 조회순서를 변경하는 중에 오류가 발생하였습니다.", StopSign!)
//			Return
//		End If
//	
//	If lb_error Then
//		RollBack Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		MessageBox("간판 마스터 변경", "변경된 간판 마스터 정보를 추가하는 도중에 오류가 발생하였습니다.", StopSign!)
//		Return
//	Else
//		Commit Using SQLPIS;
//		SQLPIS.AutoCommit = True
//		ib_save			= True
//		ib_change		= False
//		is_saveflag		= ""
//		MessageBox("간판 마스터 변경", "변경된 간판 마스터 정보를 추가하였습니다.", StopSign!)
//		wf_retrieve()
//		Return
//	End If
//	Return
//End If
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp211u
integer x = 1170
integer y = 64
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

type uo_division from u_pisc_select_division within w_pisp211u
integer x = 549
integer y = 64
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_item.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
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
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp211u
integer x = 55
integer y = 64
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_item.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
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
	
	wf_retrieve()
End If
end event

type gb_2 from groupbox within w_pisp211u
integer x = 2464
integer width = 1326
integer height = 180
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

type dw_item from datawindow within w_pisp211u
event ue_check ( integer fi_row )
integer x = 46
integer y = 468
integer width = 1810
integer height = 1316
string title = "none"
string dataobject = "d_pisp211u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_check;//Int		i, li_checkcount, li_possiblecount
//String	ls_checkflag
//
//AcceptText()
//
//If Trim(GetItemString(fi_row, "kbstatuscode")) = "C" Or Trim(GetItemString(fi_row, "kbstatuscode")) = "D" Then
//	//
//Else
//	SetItem(fi_row, "CheckFlag", "N")
//	Return
//End If
//
//For i = 1 To RowCount()
//	If Trim(GetItemString(i, "kbstatuscode")) = "C" Or Trim(GetItemString(i, "kbstatuscode")) = "D" Then
//		li_possiblecount	= li_possiblecount + 1
//	End If
//	
//	ls_checkflag	= Trim(GetItemString(i, "CheckFlag"))
//	If ls_checkflag = "Y" Then
//		li_checkcount = li_checkcount + 1
//	End If
//Next
//
//If li_checkcount > 0 Then
//	ib_check		= True
//	cb_2.Enabled	= True
//	If li_checkcount = li_possiblecount Then
//		cbx_1.Checked	= True
//	Else
//		cbx_1.Checked	= False
//	End If
//Else	
//	ib_check		= False
//	cb_2.Enabled	= False
//	cbx_1.Checked	= False
//End If
//
////dw_kbno.Reset()
////dw_kbno.InsertRow(1)
////dw_kbno.SetColumn(1)
////dw_kbno.SetRow(1)
////dw_kbno.SetFocus()
////
end event

event constructor;//Visible	= False
end event

event rowfocuschanged;Long		ll_count, ll_rackqty, ll_dividerate, ll_safetyinvqty, ll_sortorder
String	ls_possibleflag, ls_itemcode, ls_itemname, ls_modelid, &
			ls_applydate_close, ls_inspectgubun, &
			ls_lineid, ls_kbid, ls_productgubun, ls_stockgubun, ls_rackcode, &
			ls_stocklocation, ls_carname

If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
	
	is_saveflag		= ""
	ib_change		= False
	dw_detail.ReSet()
	ls_possibleflag	= Trim(GetItemString(CurrentRow, "PossibleFlag"))
	ls_itemcode			= Trim(GetItemString(CurrentRow, "ItemCode"))

	If ls_possibleflag = "Y" Then
		is_saveflag	= "INSERT"
		ls_itemname			= Trim(GetItemString(CurrentRow, "ItemName"))
		ls_modelid			= Trim(GetItemString(CurrentRow, "ModelID"))
		ls_applydate_close	= f_pisc_get_date_applydate(uo_area.is_uo_areacode, &
																	uo_division.is_uo_divisioncode, &
																		f_pisc_get_date_nowtime())
		ll_rackqty			= GetItemNumber(CurrentRow, "RackQty")
		
		// 계획분배율을 구하자...
		// 계획분배율은 합이 100이 되어야 하므로...
		Select	LineID,
					KBID,
					ProductGubun,
					StockGubun,
					RackCode,
					CarName,
					StockLocation,
					SafetyInvQty,
					IsNull(Sum(IsNull(DivideRate, 0)), 0)
		Into		:ls_lineid,
					:ls_kbid,
					:ls_productgubun,
					:ls_stockgubun,
					:ls_rackcode,
					:ls_carname,
					:ls_stocklocation,
					:ll_safetyInvQty,
					:ll_dividerate
		From		tmstkb
		Where		AreaCode			= :uo_area.is_uo_areacode				And
					DivisionCode	= :uo_division.is_uo_divisioncode	And
					ItemCode			= :ls_itemcode
		Group By LineID, KBID, ProductGubun, StockGubun, RackCode, CarName,
					StockLocation, SafetyInvQty
		Using SQLPIS;

		ll_dividerate	= 100 - ll_dividerate

		// Sort Order 을 구하자
		Select	IsNull(Max(SortOrder), 0)
		Into		:ll_sortorder
		From		tmstkb
		Where		AreaCode			= :uo_area.is_uo_areacode				And
					DivisionCode	= :uo_division.is_uo_divisioncode	And
					WorkCenter		= :uo_workcenter.is_uo_workcenter	And
					LineCode			= :uo_line.is_uo_linecode
		Using SQLPIS;
		
		If IsNull(ll_sortorder) Or ll_sortorder = 0 Then
			ll_sortorder = 1
		Else
			ll_sortorder = ll_sortorder + 1
		End If
		
		ls_stockgubun	= 'N'
		// 입고검사 여부를 구하자.
		Select	Count(ItemCode)
		Into		:ll_count
		From		tqcontainqcitem	A
		Where		AreaCode			= :uo_area.is_uo_areacode				And
					DivisionCode	= :uo_division.is_uo_divisioncode	And
					A.ItemCode			= :ls_itemcode							And
					A.ApplyDateFrom	<= :ls_applydate_close				And
					A.ApplyDateTo		> :ls_applydate_close
		Using SQLPIS;
		If ll_count > 0 Then
				ls_inspectgubun	= "Y"
		Else
				ls_inspectgubun	= "N"
		End If
		
		dw_detail.InsertRow(0)
		dw_detail.SetItem(1, "AreaCode", uo_area.is_uo_areacode)
		dw_detail.SetItem(1, "AreaName", uo_area.is_uo_areaname)
		dw_detail.SetItem(1, "DivisionCode", uo_division.is_uo_divisioncode)
		dw_detail.SetItem(1, "DivisionName", uo_division.is_uo_divisionname)
		dw_detail.SetItem(1, "WorkCenter", uo_workcenter.is_uo_workcenter)
		dw_detail.SetItem(1, "WorkCenterName", uo_workcenter.is_uo_workcentername)
		dw_detail.SetItem(1, "LineCode", uo_line.is_uo_linecode)
		dw_detail.SetItem(1, "LineShortName", uo_line.is_uo_lineshortname)
		dw_detail.SetItem(1, "LineFullName", uo_line.is_uo_linefullname)
		dw_detail.SetItem(1, "ItemCode", ls_itemcode)
		dw_detail.SetItem(1, "ItemName", ls_itemname)
		dw_detail.SetItem(1, "ModelID", ls_modelid)
		dw_detail.SetItem(1, "ApplyFrom", ls_applydate_close)
		dw_detail.SetItem(1, "LineID", ls_lineid)
		dw_detail.SetItem(1, "KBID", ls_kbid)
		dw_detail.SetItem(1, "NormalKBSN", "X")
		dw_detail.SetItem(1, "TempKBSN", "X")
		dw_detail.SetItem(1, "RackQty", ll_rackqty)
		dw_detail.SetItem(1, "SortOrder", ll_sortorder)
		dw_detail.SetItem(1, "ProductGubun", ls_productgubun)
		dw_detail.SetItem(1, "InspectGubun", ls_inspectgubun)
		dw_detail.SetItem(1, "StockGubun", ls_stockgubun)
		dw_detail.SetItem(1, "PrdStopGubun", "N")
		dw_detail.SetItem(1, "RackCode", ls_rackcode)
		dw_detail.SetItem(1, "LotSize", 0)
		dw_detail.SetItem(1, "CarName", ls_carname)
		dw_detail.SetItem(1, "MainLineGubun", "M")
		dw_detail.SetItem(1, "DivideRate", ll_dividerate)
		dw_detail.SetItem(1, "PCSPerHour", 0)
		dw_detail.SetItem(1, "SafetyInvQty", ll_safetyinvqty)
		dw_detail.SetItem(1, "KBFactor", 1)
		dw_detail.SetItem(1, "SafetyFactor", 1)
		dw_detail.SetItem(1, "StockLocation", ls_stocklocation)
	Else
		If dw_detail.Retrieve(uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
									uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
									ls_itemcode) > 0 Then
			is_saveflag	= "UPDATE"
//			MessageBox("간판 마스터 변경", "선택하신 제품은 이미 선택하신 라인에 등록되어 있는 간판입니다.")
		End If
//		Return
	End If
End If
end event

event itemchanged;
//AcceptText()
//
//If row > 0 Then
//	If Upper(string(dwo.name)) = "CHECKFLAG" Then
//		Post Event ue_check(row)
//	End If
//End If
end event

type gb_4 from groupbox within w_pisp211u
integer x = 18
integer width = 1115
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_5 from groupbox within w_pisp211u
integer x = 1138
integer width = 1321
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisp211u
integer x = 18
integer y = 200
integer width = 1870
integer height = 232
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "제품 검색"
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp211u
integer x = 18
integer y = 412
integer width = 1870
integer height = 1408
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_detail from datawindow within w_pisp211u
integer x = 1929
integer y = 276
integer width = 1819
integer height = 1512
string title = "무간판 생산/입고 등록 취소"
string dataobject = "d_pisp211u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//Visible	= False
end event

event itemchanged;
AcceptText()
ib_change		= True

//If Upper(string(dwo.name)) = "AREACODE" Then
////	Post Event ue_check(row)
//End If

end event

event editchanged;AcceptText()
ib_change		= True
end event

event itemerror;Return 1
end event

type gb_6 from groupbox within w_pisp211u
integer x = 1902
integer y = 200
integer width = 1888
integer height = 1620
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "간판 마스터 상세 정보"
borderstyle borderstyle = stylelowered!
end type

type dw_save_1 from datawindow within w_pisp211u
integer x = 1371
integer y = 1188
integer width = 937
integer height = 436
boolean bringtotop = true
boolean titlebar = true
string title = "간판마스터 추가 저장"
string dataobject = "d_pisp211u_04_u"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

