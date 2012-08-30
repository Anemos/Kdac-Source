$PBExportHeader$w_lookup.srw
$PBExportComments$모든 코드 찾기 화면
forward
global type w_lookup from window
end type
type cb_2 from commandbutton within w_lookup
end type
type st_msg from statictext within w_lookup
end type
type cb_1 from commandbutton within w_lookup
end type
type st_2 from statictext within w_lookup
end type
type cb_3 from commandbutton within w_lookup
end type
type cb_ok from commandbutton within w_lookup
end type
type sle_1 from singlelineedit within w_lookup
end type
type dw_code from datawindow within w_lookup
end type
type gb_1 from groupbox within w_lookup
end type
end forward

global type w_lookup from window
integer x = 233
integer y = 176
integer width = 2400
integer height = 1912
boolean titlebar = true
string title = "코드 찾기"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
boolean clientedge = true
event ue_set_lookup_datawindow ( )
event ue_show_date ( )
event ue_hide_date ( )
event ue_retrieve ( )
cb_2 cb_2
st_msg st_msg
cb_1 cb_1
st_2 st_2
cb_3 cb_3
cb_ok cb_ok
sle_1 sle_1
dw_code dw_code
gb_1 gb_1
end type
global w_lookup w_lookup

type variables
string is_original_sql
string is_filter
string is_head_nm,is_col_nm,is_where
long il_selectedrow

end variables

event ue_retrieve;string old_select,new_select,where_clause,ls_sle_nm,ls_where
long ll_row
int li_pos

st_msg.text = ""

//조회조건 결정
If IsNull(sle_1.text) or trim(sle_1.text) = "" Then
	ls_sle_nm = ' '
Else
	ls_sle_nm = sle_1.text
End if

//새로운 조회조건을 만든다.
old_select = dw_code.GetSQLSelect( )
li_pos = pos(UPPER(old_select),'WHERE',1)

ls_where = is_where

if trim(is_where) <> "" then
	ls_where = ls_where + ' AND '
end if
	
If li_pos > 0 Then
	ls_where = ' AND ' + ls_where
Else
	ls_where = 'WHERE ' + ls_where
End if

where_clause =   ls_where + " (("+is_col_nm+" LIKE '%"+ls_sle_nm+"%' ) or " + &
									" (' ' = '"+ls_sle_nm+"')) "

// Add the new where clause to old_select
new_select = old_select + ' ' + where_clause
dw_code.SetSQLSelect(new_select)

ll_row = dw_code.retrieve()

//원래의 sql문장을 복원
dw_code.SetSQLSelect(old_select)

if  ll_row > 0 then
   dw_code.Sort()
else
	st_msg.text =  "해당자료가 없습니다...!!"
	SetFocus(sle_1)
	return
end if

dw_code.SelectRow(0,False)
dw_code.SelectRow(dw_code.GetRow(),True)
dw_code.setfocus()



end event

on w_lookup.create
this.cb_2=create cb_2
this.st_msg=create st_msg
this.cb_1=create cb_1
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_ok=create cb_ok
this.sle_1=create sle_1
this.dw_code=create dw_code
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.st_msg,&
this.cb_1,&
this.st_2,&
this.cb_3,&
this.cb_ok,&
this.sle_1,&
this.dw_code,&
this.gb_1}
end on

on w_lookup.destroy
destroy(this.cb_2)
destroy(this.st_msg)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_ok)
destroy(this.sle_1)
destroy(this.dw_code)
destroy(this.gb_1)
end on

event open;string ls_dw
str_lookup str_param
long ll_row

//f_win_center(this)

str_param = Message.PowerObjectParm

dw_code.dataobject = str_param.ls_dataobject
dw_code.SetTransobject(sqlcmms)
dw_code.Retrieve()

if dw_code.RowCount() > 0 then
	ll_row = dw_code.find(' #1 = ' + "'" + str_param.ls_value + "'", 1, dw_code.RowCount())
	if ll_row > 0 then
		dw_code.SelectRow(0, false)
		dw_code.SetRow(ll_row)
		dw_code.SelectRow(ll_row, true)
		dw_code.ScrollToRow(ll_row)
	end if
end if

st_2.text = dw_code.Describe("#1" +  ".Tag")
is_col_nm = dw_code.Describe("#1" +  ".dbName")

this.move(str_param.ll_x, str_param.ll_y)

sle_1.SetFocus()
end event

type cb_2 from commandbutton within w_lookup
integer x = 1993
integer y = 80
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "찾기"
end type

event clicked;parent.triggerevent("ue_retrieve")
end event

type st_msg from statictext within w_lookup
integer x = 18
integer y = 1712
integer width = 2322
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 65535
long backcolor = 33554432
boolean enabled = false
string text = "선택하세요..."
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_lookup
integer x = 1399
integer y = 1600
integer width = 311
integer height = 100
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "새로고침"
end type

event clicked;dw_code.retrieve()
end event

type st_2 from statictext within w_lookup
integer x = 46
integer y = 96
integer width = 494
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "코드:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_lookup
integer x = 2021
integer y = 1600
integer width = 311
integer height = 100
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취 소"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_lookup
integer x = 1710
integer y = 1600
integer width = 311
integer height = 100
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "확 인"
end type

event clicked;string ls_code
long ll_row

ll_row = dw_code.GetRow()
if ll_row > 0 then
	ls_code = dw_code.GetItemString(ll_row, 1)
else
	setnull(ls_code)
end if

closewithreturn(parent, ls_code)
end event

type sle_1 from singlelineedit within w_lookup
event uo_keydown pbm_keydown
integer x = 539
integer y = 80
integer width = 1440
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 32305643
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event uo_keydown;if key = keyenter! then
	parent.triggerevent("ue_retrieve")
end if

//int li_movement 
//long ll_row
//string ll_col
//str_lookup str_param
//
//str_param = message.Powerobjectparm
//ll_col = str_param.ls_col
//
//	If KeyDown (keyUparrow!) then
//		li_movement = -1
//	End If
//	
//	
//	If KeyDown (keyDownarrow!) then
//		li_movement = 1
//	End If
//	
//	If li_movement <> 0 Then
//		dw_code.SetRedraw(False)
//		ll_row = dw_code.GetSelectedRow(0)
//		ll_row = ll_row + li_movement
//		If ll_row < 1 or ll_row > dw_code.RowCount( ) Then 
//			Beep(1)
//			dw_code.SetRedraw(True)
//			Return
//		End If
//		dw_code.selectrow(0,False)
//		dw_code.SelectRow(ll_row , True)
//		dw_code.ScrollToRow (ll_row)
//		SLE_1.text = dw_code.GetItemString(ll_row , 1)
////		is_filter = SLE_1.text
//		il_selectedrow = ll_row
//		SLE_1.SelectText(len(SLE_1.text) + 1,0)
//		message.processed = true
//		dw_code.SetRedraw(True)
//		Return
//	End If
//	
//	
//	string	ls_character
//	long	ll_found_row
//	int		li_num_chars
//	
//	ls_character = Char(message.wordparm)
//	
//	//filter out non alpha characters
//	//If (Lower(ls_character) < "a" or Lower(ls_character) > "z") and  ls_character <> Char(8) Then 
//	//	message.processed = true
//	//	dw_code.SetRedraw(True)
//	//	Return
//	//End If
//	
//	// Backspace 
//	If message.wordparm = 8   then
//		li_num_chars = Len(is_filter)
//		If li_num_chars > 0 then is_filter = Left(is_filter, li_num_chars -1)		
//	else
//		is_filter = is_filter + ls_character
//	end if
//	
////	MESSAGEBOX('', IS_FILTER)
//	// Do case-insensitive search
//	If Len(is_filter) > 0 Then
////		ll_found_row = dw_code.Find("Lower(#1) >=~"" + Lower(is_filter) + "~"",1, 99999)
//		ll_found_row = dw_code.Find(ll_col + " = '" + is_filter + "'",1, dw_code.rowcount())		
//		If ll_found_row > 0 then 
//			dw_code.SetRedraw(FALSE)
//			dw_code.SelectRow(0, FALSE)
//			dw_code.ScrollToRow(ll_found_row)
//			dw_code.SelectRow(ll_found_row, TRUE)
//			dw_code.SetRedraw(TRUE)
//	// is_filterer function did not find any matching row
//		Else
//			Beep(1)
//			li_num_chars = Len(is_filter)
//			//If li_num_chars > 0 Then is_filter = Left(is_filter, li_num_chars -1)		
//	// Throw away last character
//			message.processed = true
//		End If
//	// is_filterer length is 0, so unhighlight former selected row
//	Else	
//		dw_code.SelectRow(0, FALSE)
//	End If
//	
//	// Remember number of highlighted row
//	il_selectedrow = ll_found_row			
//
//	
//		
//	
//
end event

type dw_code from datawindow within w_lookup
event uo_lbuttondown pbm_lbuttondown
event uo_mousemove pbm_mousemove
event uo_lbuttonup pbm_lbuttonup
event keydown pbm_dwnkey
integer x = 18
integer y = 224
integer width = 2322
integer height = 1364
integer taborder = 50
string dragicon = "lookup.ico"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "lookup.ico"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event uo_lbuttonup;this.Modify(is_head_nm + ".Border = 6")
end event

event keydown;if KeyDown(KeyEnter!) then
	cb_ok.triggerevent(clicked!)
elseif	KeyDown(KeyEscape!) then
	cb_3.triggerevent(clicked!)
else
	This.TriggerEvent(rowfocuschanged!)
end if


end event

event rowfocuschanged;if currentrow <= 0 then return

selectrow(0, false)
setrow(currentrow)
selectrow(currentrow, true)

//sle_1.SetFocus()
end event

event clicked;this.Event Trigger RowFocusChanged(row)

if row < 1 then
	is_head_nm = dwo.name	//Head 명
   if f_getobjectpoint_head(dw_code,is_col_nm) = 1 then
   	f_dw_sort(dw_code,is_col_nm)
	   st_2.text = dw_code.Describe(is_col_nm + ".Tag") 
		is_col_nm = dw_code.Describe(is_col_nm + ".dbName")
   end if
end if

//sle_1.SetFocus()
end event

event doubleclicked;if row <= 0 then return

cb_ok.triggerevent('clicked')
end event

event losefocus;dw_code.SelectRow(0,False)
end event

type gb_1 from groupbox within w_lookup
integer x = 27
integer y = 12
integer width = 2313
integer height = 204
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "Quick Seach"
end type

