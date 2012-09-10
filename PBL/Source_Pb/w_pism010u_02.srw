$PBExportHeader$w_pism010u_02.srw
$PBExportComments$사번별 담당조 FILTER
forward
global type w_pism010u_02 from w_pism_resp01
end type
type dw_autwc from datawindow within w_pism010u_02
end type
type cb_close from commandbutton within w_pism010u_02
end type
type cb_save from commandbutton within w_pism010u_02
end type
type st_2 from statictext within w_pism010u_02
end type
type dw_wcfilter from u_pism_dw within w_pism010u_02
end type
type st_1 from statictext within w_pism010u_02
end type
type cb_del from commandbutton within w_pism010u_02
end type
type cb_add from commandbutton within w_pism010u_02
end type
type dw_wclist from u_pism_dw within w_pism010u_02
end type
end forward

global type w_pism010u_02 from w_pism_resp01
integer width = 3410
integer height = 1192
string title = "담당조 FILTER"
dw_autwc dw_autwc
cb_close cb_close
cb_save cb_save
st_2 st_2
dw_wcfilter dw_wcfilter
st_1 st_1
cb_del cb_del
cb_add cb_add
dw_wclist dw_wclist
end type
global w_pism010u_02 w_pism010u_02

on w_pism010u_02.create
int iCurrent
call super::create
this.dw_autwc=create dw_autwc
this.cb_close=create cb_close
this.cb_save=create cb_save
this.st_2=create st_2
this.dw_wcfilter=create dw_wcfilter
this.st_1=create st_1
this.cb_del=create cb_del
this.cb_add=create cb_add
this.dw_wclist=create dw_wclist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_autwc
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.dw_wcfilter
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_del
this.Control[iCurrent+8]=this.cb_add
this.Control[iCurrent+9]=this.dw_wclist
end on

on w_pism010u_02.destroy
call super::destroy
destroy(this.dw_autwc)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.st_2)
destroy(this.dw_wcfilter)
destroy(this.st_1)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.dw_wclist)
end on

event open;call super::open;dw_autwc.Visible = False
cb_add.Enabled = m_frame.m_action.m_save.Enabled 
cb_del.Enabled = m_frame.m_action.m_save.Enabled 

This.TriggerEvent("ue_retrieve") 
end event

event ue_retrieve;call super::ue_retrieve;Long ll_findRow, ll_rowCnt 
String ls_Wc, ls_Filter 
Integer I = 1, li_chk 

dw_wclist.SetTransObject(SqlPIS)
dw_wclist.Retrieve(istr_mh.area, istr_mh.div, '%') 

dw_wcfilter.SetTransObject(SqlPIS)

dw_autwc.SetTransObject(SqlPIS)
ll_rowCnt = dw_autwc.Retrieve(g_s_empno) 

For I = 1 To ll_rowCnt 
	ls_wc = dw_autwc.GetItemString(I, "autworkcenter")
	
	ll_findRow = dw_wclist.Find("workcenter = '" + Trim(ls_Wc) + "'", 1, dw_wclist.RowCount()) 
	If ll_findRow > 0 Then 
		li_Chk = dw_wclist.RowsCopy(ll_findRow, ll_findRow, Primary!, dw_wcfilter, 1, Primary!) 
		If li_Chk = 1 Then dw_wclist.DeleteRow(ll_findRow) 
	End If 	
Next 
dw_wcfilter.Sort(); dw_wcfilter.SetRedraw(True) 
end event

type dw_autwc from datawindow within w_pism010u_02
integer x = 992
integer y = 720
integer width = 1330
integer height = 376
integer taborder = 30
string title = "none"
string dataobject = "d_pism010u_02_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_pism010u_02
integer x = 2894
integer y = 992
integer width = 485
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;If dw_autwc.ModifiedCount() > 0 or dw_autwc.DeletedCount() > 0 Then 
	If f_pism_MessageBox(Question!, 999, '저장', "수정된 자료가 있습니다. 저장하시겠습니까?") = 1 Then &
		cb_save.TriggerEvent(Clicked!) 
End If 

Close(Parent) 
end event

type cb_save from commandbutton within w_pism010u_02
integer x = 2409
integer y = 992
integer width = 485
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "저장"
end type

event clicked;If f_pism_dwupdate(dw_autwc, True) = -1 Then Return  
This.Enabled = False 
end event

type st_2 from statictext within w_pism010u_02
integer x = 1765
integer y = 24
integer width = 453
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "[조 FILTER]"
boolean focusrectangle = false
end type

type dw_wcfilter from u_pism_dw within w_pism010u_02
integer x = 1769
integer y = 88
integer width = 1609
integer height = 892
integer taborder = 20
string dataobject = "d_pism_select_workcenter"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type st_1 from statictext within w_pism010u_02
integer x = 5
integer y = 20
integer width = 453
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "[조 LIST]"
boolean focusrectangle = false
end type

type cb_del from commandbutton within w_pism010u_02
integer x = 1618
integer y = 508
integer width = 142
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "◀"
end type

event clicked;Long ll_rowCnt, ll_findRow, ll_selected_count, ll_selected_rows[] 
Integer I 
String ls_wc 

ll_selected_count = f_pism_return_selected (dw_wcfilter, ll_selected_rows)
If ll_selected_count = 0 Then Return

If ll_selected_count > 0 Then 
	dw_wclist.SetRedraw(False)
	dw_wcfilter.SelectRow(0, False)
	For i = ll_selected_count To 1 Step -1 
		If dw_wcfilter.RowsCopy(ll_selected_rows[I], ll_selected_rows[I], Primary!, dw_wclist, 1, Primary!) = -1 Then Continue 
		
		ls_wc = dw_wcfilter.GetItemString(ll_selected_rows[I], "workcenter") 
		
		dw_wclist.SelectRow(1, True) 
		ll_findRow = dw_autwc.Find("autworkcenter = '" + ls_wc + "'", 1, dw_autwc.RowCount()) 
		If ll_findRow > 0 Then dw_autwc.DeleteRow(ll_findRow)
		dw_wcfilter.DeleteRow(ll_selected_rows[I]) 	
	Next 
	dw_wclist.Sort() 
	dw_wclist.SetRedraw(True)	
	
	cb_save.Enabled = True 
End If 
end event

type cb_add from commandbutton within w_pism010u_02
integer x = 1618
integer y = 380
integer width = 142
integer height = 128
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "▶"
end type

event clicked;Long ll_rowCnt, ll_insRow, ll_selected_count, ll_selected_rows[], ll_findRow 
Integer I 
String ls_wc 

ll_selected_count = f_pism_return_selected (dw_wclist, ll_selected_rows)
If ll_selected_count = 0 Then Return

If ll_selected_count > 0 Then 
	dw_wcfilter.SetRedraw(False)
	dw_wclist.SelectRow(0, False)

	For i = ll_selected_count To 1 Step -1 
		
		If dw_wclist.RowsCopy(ll_selected_rows[I], ll_selected_rows[I], Primary!, dw_wcfilter, 1, Primary!) = -1 Then Continue 
	
		ls_wc = dw_wclist.GetItemString(ll_selected_rows[I], "workcenter") 
		dw_wcfilter.SelectRow(1, True) 
		
		ll_findRow = dw_autwc.Find("autworkcenter = '" + ls_wc + "'", 1, dw_autwc.RowCount()) 
		If ll_findRow = 0 Then 
			ll_findRow = dw_autwc.InsertRow(0)
			dw_autwc.SetItem(ll_findRow, "empno", g_s_empno) 
			dw_autwc.SetItem(ll_findRow, "areacode", istr_mh.area) 
			dw_autwc.SetItem(ll_findRow, "divisioncode", istr_mh.div) 
			dw_autwc.SetItem(ll_findRow, "autworkcenter", ls_wc) 
			
		End If 
		
		dw_wclist.DeleteRow(ll_selected_rows[I]) 	
	Next 
	dw_wcfilter.Sort() 
	dw_wcfilter.SetRedraw(True)	
	
	cb_save.Enabled = True 
End If

end event

type dw_wclist from u_pism_dw within w_pism010u_02
integer y = 88
integer width = 1609
integer height = 892
integer taborder = 10
string dataobject = "d_pism_select_workcenter"
boolean hscrollbar = true
boolean vscrollbar = true
end type

