$PBExportHeader$w_pism013u.srw
$PBExportComments$작업일보 작성용 품번목록 선택
forward
global type w_pism013u from w_pism_resp01
end type
type st_3 from statictext within w_pism013u
end type
type st_1 from statictext within w_pism013u
end type
type cb_save from commandbutton within w_pism013u
end type
type cb_remakeprodlist from commandbutton within w_pism013u
end type
type cb_close from commandbutton within w_pism013u
end type
type st_wcname from statictext within w_pism013u
end type
type st_wccode from statictext within w_pism013u
end type
type st_2 from statictext within w_pism013u
end type
type cb_add from commandbutton within w_pism013u
end type
type cb_del from commandbutton within w_pism013u
end type
type dw_wcitemlist from u_pism_dw within w_pism013u
end type
type dw_prodlist from u_pism_dw within w_pism013u
end type
type gb_2 from groupbox within w_pism013u
end type
type dw_prodlist_save from datawindow within w_pism013u
end type
end forward

global type w_pism013u from w_pism_resp01
integer width = 3886
integer height = 2500
string title = "작업일보작성용 품번선택"
boolean controlmenu = false
st_3 st_3
st_1 st_1
cb_save cb_save
cb_remakeprodlist cb_remakeprodlist
cb_close cb_close
st_wcname st_wcname
st_wccode st_wccode
st_2 st_2
cb_add cb_add
cb_del cb_del
dw_wcitemlist dw_wcitemlist
dw_prodlist dw_prodlist
gb_2 gb_2
dw_prodlist_save dw_prodlist_save
end type
global w_pism013u w_pism013u

type variables
String is_modChk 
Constant String MKLABTACOK = '1', MKDAILYOK = '2', MKLABTACNOT = '3', MKDAILYNOT = '4' 
end variables

on w_pism013u.create
int iCurrent
call super::create
this.st_3=create st_3
this.st_1=create st_1
this.cb_save=create cb_save
this.cb_remakeprodlist=create cb_remakeprodlist
this.cb_close=create cb_close
this.st_wcname=create st_wcname
this.st_wccode=create st_wccode
this.st_2=create st_2
this.cb_add=create cb_add
this.cb_del=create cb_del
this.dw_wcitemlist=create dw_wcitemlist
this.dw_prodlist=create dw_prodlist
this.gb_2=create gb_2
this.dw_prodlist_save=create dw_prodlist_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_remakeprodlist
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.st_wcname
this.Control[iCurrent+7]=this.st_wccode
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.cb_add
this.Control[iCurrent+10]=this.cb_del
this.Control[iCurrent+11]=this.dw_wcitemlist
this.Control[iCurrent+12]=this.dw_prodlist
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.dw_prodlist_save
end on

on w_pism013u.destroy
call super::destroy
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.cb_remakeprodlist)
destroy(this.cb_close)
destroy(this.st_wcname)
destroy(this.st_wccode)
destroy(this.st_2)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.dw_wcitemlist)
destroy(this.dw_prodlist)
destroy(this.gb_2)
destroy(this.dw_prodlist_save)
end on

event resize;call super::resize;Long ll_width 

ll_width = newwidth / 2 - ( dw_wcitemlist.x + ( cb_add.Width / 2 ) ) 
dw_wcitemlist.Width = ll_width 

cb_add.x = dw_wcitemlist.x + dw_wcitemlist.Width + 5 
cb_del.x = cb_add.x 

dw_prodlist.x = cb_add.x + cb_add.Width + 5 

dw_prodlist.Width = newwidth - ( dw_prodlist.x + 10 ) 

dw_wcitemlist.Height = newheight - ( dw_wcitemlist.y + 10 )
dw_prodlist.Height = dw_wcitemlist.Height 
cb_remakeprodlist.x = newwidth - ( cb_close.Width + cb_save.Width + cb_remakeprodlist.Width + 10 )
cb_save.x  = cb_remakeprodlist.x + cb_remakeprodlist.width 
cb_close.x = cb_save.x + cb_save.width 

end event

event open;call super::open;dw_prodlist_save.Visible = False 
cb_save.Enabled = False 

st_wccode.Text = istr_mh.wc; st_wcname.Text = f_pism_getwcname(istr_mh) 
If istr_mh.dailyStatus = MKDAILYOK Then cb_remakeprodlist.Enabled = m_frame.m_action.m_save.Enabled 
cb_add.Enabled = m_frame.m_action.m_save.Enabled 
cb_del.Enabled = m_frame.m_action.m_save.Enabled 

If IsNull(istr_mh.wday) or istr_mh.wday = '' Then istr_mh.wday = String(Today(),'YYYY.MM.DD') 

This.postEvent("ue_retrieve") 

end event

event ue_retrieve;call super::ue_retrieve;dw_wcitemlist.SetTransObject(SqlPIS)
dw_wcitemlist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday)

dw_prodlist.SetTransObject(SqlPIS)
dw_prodlist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, '1')

dw_prodlist_save.SetTransObject(SqlPIS)
dw_prodlist_save.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday) 

end event

type st_3 from statictext within w_pism013u
integer x = 2103
integer y = 188
integer width = 997
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[ 작업일보 작성용 품번목록 ]"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pism013u
integer x = 14
integer y = 196
integer width = 823
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[ 유사그룹별 품번목록 ]"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_pism013u
integer x = 2551
integer y = 36
integer width = 526
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "저장"
end type

event clicked;If dw_prodlist_save.Event save_data() = -1 Then Return  
is_modChk = '2' 

//If istr_mh.dailyStatus <> MKDAILYOK Then is_modChk = ''
This.Enabled = False 

end event

type cb_remakeprodlist from commandbutton within w_pism013u
integer x = 2021
integer y = 36
integer width = 526
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "작업일보 갱신"
end type

event clicked;cb_save.TriggerEvent(Clicked!)
is_modChk = '1'
CloseWithReturn(Parent, is_modchk)
end event

type cb_close from commandbutton within w_pism013u
integer x = 3081
integer y = 36
integer width = 526
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;
If dw_prodlist_save.ModifiedCount() > 0 or dw_prodlist_save.DeletedCount() > 0 Then 
	If f_pism_MessageBox(Question!, 999, '작업일보 생산품번 저장', st_wcname.Text + " 조~n~n" + &
        											 "의 수정된 자료가 있습니다. 저장하시겠습니까?") = 1 Then &
		cb_save.TriggerEvent(Clicked!) 
End If 

CloseWithReturn(Parent, is_modchk)
end event

type st_wcname from statictext within w_pism013u
integer x = 457
integer y = 48
integer width = 709
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_wccode from statictext within w_pism013u
integer x = 197
integer y = 48
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pism013u
integer x = 64
integer y = 60
integer width = 142
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조:"
boolean focusrectangle = false
end type

type cb_add from commandbutton within w_pism013u
integer x = 1943
integer y = 756
integer width = 151
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "▶"
end type

event clicked;Long ll_rowCnt, ll_insRow, ll_selected_count, ll_selected_rows[], ll_findRow 
Integer I 
String ls_ItemCode, ls_ItemName, ls_ItemSpec, ls_LineCode, ls_LineNo, ls_wcGroup, ls_FindStr 

ll_selected_count = f_pism_return_selected (dw_wcitemlist, ll_selected_rows)
If ll_selected_count = 0 Then Return

If ll_selected_count > 0 Then 
	dw_prodlist.SetRedraw(False)
	dw_wcitemlist.SelectRow(0, False)

	For i = ll_selected_count To 1 Step -1 
		
		If dw_wcitemlist.RowsCopy(ll_selected_rows[I], ll_selected_rows[I], Primary!, dw_prodlist, 1, Primary!) = -1 Then Continue 
	
		ls_ItemCode = dw_wcitemlist.GetItemString(ll_selected_rows[I], "itemcode")
		ls_ItemName = dw_wcitemlist.GetItemString(ll_selected_rows[I], "itemname")
		ls_ItemSpec = dw_wcitemlist.GetItemString(ll_selected_rows[I], "itemspec")
		ls_LineCode = dw_wcitemlist.GetItemString(ll_selected_rows[I], "sublinecode")
		ls_LineNo   = dw_wcitemlist.GetItemString(ll_selected_rows[I], "sublineno") 
		ls_wcGroup  = dw_wcitemlist.GetItemString(ll_selected_rows[I], "wcitemgroup")
		
		dw_prodlist.SetItem(1, "useflag", '1')
		dw_prodlist.SelectRow(1, True) 
		
		ls_FindStr = "itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
													"sublineno = '" + ls_LineNo + "'" 
		ll_findRow = dw_prodlist_save.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
													"sublineno = '" + ls_LineNo + "'", 1, dw_prodlist_save.RowCount()) 
		If ll_findRow > 0 Then 
			dw_prodlist_save.SetItem(ll_findRow, "useflag", '1')
		Else
			dw_prodlist.RowsCopy(1, 1, Primary!, dw_prodlist_save, 1, Primary!) 
			dw_prodlist.SetItem(1, "Seq", 0); ll_findRow = 1 
		End If
		
		dw_wcitemlist.DeleteRow(ll_selected_rows[I]) 	
	Next 
	dw_prodlist.Sort() 
	dw_prodlist.SetRedraw(True)	
	cb_remakeprodlist.Enabled = True
	cb_save.Enabled = True 
End If

end event

type cb_del from commandbutton within w_pism013u
integer x = 1943
integer y = 876
integer width = 151
integer height = 120
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "◀"
end type

event clicked;Long ll_rowCnt, ll_findRow, ll_selected_count, ll_selected_rows[] 
Integer I 
String ls_ItemCode, ls_LineCode, ls_LineNo, ls_wcGrouop 

ll_selected_count = f_pism_return_selected (dw_prodlist, ll_selected_rows)
If ll_selected_count = 0 Then Return

If ll_selected_count > 0 Then 
	dw_wcitemlist.SetRedraw(False)
	dw_prodlist.SelectRow(0, False)
	For i = ll_selected_count To 1 Step -1 
		If dw_prodlist.RowsCopy(ll_selected_rows[I], ll_selected_rows[I], Primary!, dw_wcitemlist, 1, Primary!) = -1 Then Continue 
		
		ls_ItemCode = dw_prodlist.GetItemString(ll_selected_rows[I], "itemcode")
		ls_LineCode = dw_prodlist.GetItemString(ll_selected_rows[I], "sublinecode")
		ls_LineNo   = dw_prodlist.GetItemString(ll_selected_rows[I], "sublineno") 
		ls_wcGrouop = dw_prodlist.GetItemString(ll_selected_rows[I], "wcitemgroup")
		
		dw_wcitemlist.SelectRow(1, True) 
		ll_findRow = dw_prodlist_save.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
													  "sublineno = '" + ls_LineNo + "'", 1, dw_prodlist_save.RowCount()) 
		If ll_findRow > 0 Then 
			If IsNull(ls_wcGrouop) Then 
				dw_prodlist_save.DeleteRow(ll_findRow)
				dw_wcitemlist.SetItem(1, "wcItemGroupChk", '1') 
			Else
				dw_prodlist_save.SetItem(ll_findRow, "useflag", '0') 
				
				dw_wcitemlist.SetItem(1, "wcItemGroupChk", '0') 
			End If 
		End If 
		dw_prodlist.DeleteRow(ll_selected_rows[I]) 	
	Next 
	dw_wcitemlist.Sort() 
	dw_wcitemlist.SetRedraw(True)	
	cb_remakeprodlist.Enabled = True
	cb_save.Enabled = True 
End If 
end event

type dw_wcitemlist from u_pism_dw within w_pism013u
integer x = 5
integer y = 264
integer width = 1925
integer height = 1816
integer taborder = 30
string dataobject = "d_pism012u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;dw_prodlist.SelectRow(0, False)
end event

type dw_prodlist from u_pism_dw within w_pism013u
integer x = 2098
integer y = 264
integer width = 1408
integer height = 1816
integer taborder = 30
string dataobject = "d_pism012u_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;dw_wcitemlist.SelectRow(0, False)
end event

type gb_2 from groupbox within w_pism013u
integer x = 14
integer width = 1211
integer height = 140
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_prodlist_save from datawindow within w_pism013u
event type integer save_data ( )
integer x = 727
integer y = 1044
integer width = 2363
integer height = 1076
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "none"
string dataobject = "d_pism012u_02_save"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type integer save_data();//Long ll_rowCnt, ll_seq, ll_seqRow 
//String ls_oldwcGroup, ls_wcGroup 
//Integer I 
//
//ll_rowCnt = dw_prodlist.RowCount() 
//For I = 1 To ll_rowCnt 
//	ls_wcGroup = dw_prodlist.GetItemString(I, "wcitemgroup") 
//	If ls_oldwcGroup = ls_wcGroup Then Continue 
//	ll_seq = 0 
//	ll_seqRow = This.Find("wcitemgroup = '" + ls_wcGroup + "'", 1, This.RowCount())
//	Do While ll_seqRow > 0 
//		If ll_seq = 0 Then ll_seq = I 
//		This.SetItem(ll_seqRow, "seq", ll_seq) 
//		If ll_seqRow = This.RowCount() Then Exit 
//		ll_seqRow = This.Find("wcitemgroup = '" + ls_wcGroup + "'", ll_seqRow + 1, This.RowCount()) 
//	Loop 
//	ls_oldwcGroup = ls_wcGroup 
//Next
//
Return f_pism_dwupdate(dw_prodlist_save, True) 
end event

