$PBExportHeader$uo_datawindow.sru
$PBExportComments$grid datawindow의 표준 object
forward
global type uo_datawindow from datawindow
end type
end forward

global type uo_datawindow from datawindow
integer width = 494
integer height = 360
integer taborder = 1
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_key pbm_dwnkey
event ue_enter pbm_dwnprocessenter
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_dwnmousemove
end type
global uo_datawindow uo_datawindow

type variables
boolean	ib_select_row	=	True	// Select Current Row
boolean	ib_enter			=	True	// Enter칠때 한컬럼 넘어가기
boolean	ib_copy			=	true	// copy
boolean	ib_filter		=	True	// filter
boolean	ib_sort			=	True	// sort
boolean	ib_excel			=	True	// down to Excel
boolean	ib_print			=	True	// print
boolean	ib_toggle		=	True	// 한영전환
boolean	ib_date			=	True	// 날짜window
String   is_l_col			=	''		// Enter시 처리
String   is_f_col			=	''		// Enter시 처리
String	is_head_nm					// head
String	is_border					// Border 
String 	is_sort_updown = 'a'		// sort시 오름차순일지 내림차순일지 판단 
end variables

event ue_enter;////////////////////////////////////////////////////////
// 1. 만약 Row의 마지막 입력컬럼(is_l_col)에서 Enter를 
//    누를경우 자동으로 InsertRow해준 후 
//    is_f_col에 fucus를 준다.
// 2. Enter를 누른경우 Tab을 누른것과 같은 효과를 제공
////////////////////////////////////////////////////////

long ll_row

If	is_l_col <> '' AND This.GetColumnName() = is_l_col	And This.GetRow() = This.RowCount() Then
	If	This.GetItemStatus( This.GetRow(), 0, Primary!) = NewModified! Then
		ll_row = This.InsertRow(0)
		This.ScrollTorow(ll_row)
		This.SetRow(ll_row)
		This.SetColumn(is_f_col)
		Return
	End If
End If

If	ib_enter	Then
	Send(Handle(This),256,9,Long(0,0))
	return 1
End If


end event

event ue_lbuttonup;////////////////////////////////////////////////////////
// 마우스를 눌렀다 떼는 경우 (이전 모습으로 복원)
////////////////////////////////////////////////////////

If	ib_sort Then
	This.Modify(is_head_nm + ".Border = " + is_border)
End if

end event

event clicked;///////////////////////////////////////////////////////////// 
// Head부분을 눌러 Sort를 수행한다.
/////////////////////////////////////////////////////////////

String ls_col_nm, ls_type, ls_mod
string ls_find,ls_column_name,ls_col_type
long ll_find
//If row > 0 then 
//	this.setrow(row)
//	return
//end if
//
If ib_sort = false then return 0

is_head_nm = dwo.name

If Upper(Mid(This.Describe(is_head_nm + ".band"), 1, 6)) = "HEADER" then
	
	If This.RowCount() < 1 then Return 0
	
	is_border = Trim(This.Describe(is_head_nm + ".border"))	
	This.Modify(is_head_nm + ".Border = 5")

   ls_column_name = This.Describe("#1.Name")  // highlight된 row를 기억했다가 sort한후 다시 hightlight하기 위함
  	ls_col_type    = This.Describe(ls_column_name+".ColType")
	  
	If left(ls_col_type,4) = "char" then	  
		ls_col_nm = mid(is_head_nm, 1, Len(is_head_nm) - 2)		//Column 명
		ls_find = This.GetItemString(This.Getrow(),1)
		If is_sort_updown = 'a' then
			is_sort_updown = 'd' 
		elseif is_sort_updown = 'd' then
			is_sort_updown = 'a'
		End If	
		f_dw_sort(This, is_sort_updown)
		ll_find = This.Find("#1 = '" + ls_find + "'",1,This.RowCount())
		This.ScrollTorow(ll_find)		
		this.GroupCalc()
	Else
		f_dw_sort(This, ls_col_nm)
		this.GroupCalc()
	End IF	
else
		is_border = Trim(This.Describe(is_head_nm + ".border"))	
End If

//Preview Mode 인 경우를 제외하고 Select Row한다.
ls_mod = this.Describe("DataWindow.Print.Preview")	
If	ib_select_row and Upper(ls_mod) = 'NO' and row > 0 Then
	This.SelectRow(0,False)
	This.Setrow(row)
	This.SelectRow(row,True)
	This.setfocus()
end if


end event

event rowfocuschanged;////////////////////////////////////////////////////////
// Current Row를 반전시킨다. (ib_select_row = True)
////////////////////////////////////////////////////////

long rtn
string ls_mod

ls_mod = this.Describe("DataWindow.Print.Preview")	

//Preview Mode 인 경우를 제외
If	ib_select_row and Upper(ls_mod) = 'NO' Then
	rtn = f_row_focus(This);
End If
end event

event constructor;string ls_toggle_env

// Transaction Set
This.SetTransObject(sqlcmms)

//사용자 설정이 Toggle = No인 경우 return
//ls_toggle_env = ProfileString(gs_ini, "USER", "TOGGLE", " ")
//If Upper(ls_toggle_env) = 'NO' Then
//	ib_toggle = false
//End if

end event

event itemerror;return 1
end event

event rbuttondown;////////////////////////////////////////////////////////
// 오른쪽 마우스버튼을 눌렀을 때 POPUP MENU를 띄운다.
////////////////////////////////////////////////////////

m_pop_menu NewMenu
string ls_name, ls_data, ls_type, ls_col_type

ls_type = dwo.type
If ls_type = 'column' Then
	ls_name = dwo.name
	ls_col_type = this.Describe(ls_name+".ColType")
	If pos(ls_col_type,'char',1) > 0 Then
		ls_data = dwo.Primary[row]
	Else
		ls_data = ''
	End if
End if

If ib_copy = true and row > 0 Then
	this.SelectRow(0,False)
	this.SelectRow(row, True)
	this.setfocus()
End if

NewMenu = CREATE m_pop_menu
NewMenu.mf_get_dw(this, row, ls_name, ls_data)
//Popup Menu 조정

NewMenu.m_action.item[1].visible = ib_filter
NewMenu.m_action.item[2].visible = ib_filter
NewMenu.m_action.item[3].visible = ib_filter
NewMenu.m_action.item[4].visible = ib_sort
NewMenu.m_action.item[5].visible = ib_excel
NewMenu.m_action.item[6].visible = ib_print
NewMenu.m_action.PopMenu(w_frame.PointerX(), w_frame.PointerY())

destroy NewMenu

end event

event itemfocuschanged;////////////////////////////////////////////////////////////
// 한영전환 토글
////////////////////////////////////////////////////////////

int li_pos
string ls_col_nm,ls_mod,ls_tag,ls_div

//사용자 환경에 따라 자동 한영변환 기능 설정
//If ib_toggle = false Then return
//
//ls_col_nm = this.GetColumnName()
////현재 Column의 Tag
//ls_mod = ls_col_nm + ".Tag"
//ls_tag = this.Describe(ls_mod)
////구분자 뒤의 토글 옵션을 체크
//li_pos = pos(ls_tag,"/")
//ls_div = mid(ls_tag,li_pos + 1,1)
////옵션에 따라 한영전환 처리
//Choose Case Upper(ls_div)
//	Case 'K'
//		f_toggle_kor(handle(this))
//	Case 'E'
//		f_toggle_eng(handle(this))
//End Choose

end event

on uo_datawindow.create
end on

on uo_datawindow.destroy
end on

event dberror;messagebox(string(sqldbcode),sqlerrtext)
f_show_dberror(sqldbcode)
return 1
end event

