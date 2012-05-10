$PBExportHeader$w_bom_dept_filter.srw
$PBExportComments$부서 필터링(BOM014)
forward
global type w_bom_dept_filter from window
end type
type dw_update from datawindow within w_bom_dept_filter
end type
type st_2 from statictext within w_bom_dept_filter
end type
type st_1 from statictext within w_bom_dept_filter
end type
type cb_del from commandbutton within w_bom_dept_filter
end type
type cb_add from commandbutton within w_bom_dept_filter
end type
type cb_close from commandbutton within w_bom_dept_filter
end type
type cb_save from commandbutton within w_bom_dept_filter
end type
type dw_bom014 from datawindow within w_bom_dept_filter
end type
type dw_dac001 from datawindow within w_bom_dept_filter
end type
end forward

global type w_bom_dept_filter from window
integer x = 302
integer y = 500
integer width = 3419
integer height = 1192
boolean titlebar = true
string title = "부서 Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
dw_update dw_update
st_2 st_2
st_1 st_1
cb_del cb_del
cb_add cb_add
cb_close cb_close
cb_save cb_save
dw_bom014 dw_bom014
dw_dac001 dw_dac001
end type
global w_bom_dept_filter w_bom_dept_filter

type variables
long  ii_LastRow
end variables

forward prototypes
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
end prototypes

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	li_Idx, li_last_row

li_last_row = ii_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If li_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if li_last_row > al_aclickedrow then
	For li_Idx = li_last_row to al_aclickedrow STEP -1
		dw.selectrow(li_Idx,TRUE)	
	end for	
else
	For li_Idx = li_last_row to al_aclickedrow 
		dw.selectrow(li_Idx,TRUE)	
	next	
end if
dw.setredraw(true)
Return 1

end function

on w_bom_dept_filter.create
this.dw_update=create dw_update
this.st_2=create st_2
this.st_1=create st_1
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_bom014=create dw_bom014
this.dw_dac001=create dw_dac001
this.Control[]={this.dw_update,&
this.st_2,&
this.st_1,&
this.cb_del,&
this.cb_add,&
this.cb_close,&
this.cb_save,&
this.dw_bom014,&
this.dw_dac001}
end on

on w_bom_dept_filter.destroy
destroy(this.dw_update)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_bom014)
destroy(this.dw_dac001)
end on

event open;Long ll_findRow, ll_rowCnt 
String ls_Wc, ls_Filter 
Integer I = 1, li_chk 

dw_dac001.Retrieve() 
ll_rowCnt = dw_update.Retrieve(g_s_empno) 
For I = 1 To ll_rowCnt 
	ls_wc = dw_update.GetItemString(I, "workcenter")
	ll_findRow = dw_dac001.Find("dcode = '" + Trim(ls_Wc) + "'", 1, dw_dac001.RowCount()) 
	If ll_findRow > 0 Then 
		li_Chk = dw_dac001.RowsCopy(ll_findRow, ll_findRow, Primary!, dw_bom014, 1, Primary!) 
		If li_Chk = 1 Then dw_dac001.DeleteRow(ll_findRow) 
	End If 	
Next 
dw_bom014.Sort(); dw_bom014.SetRedraw(True) 
end event

type dw_update from datawindow within w_bom_dept_filter
boolean visible = false
integer x = 1097
integer y = 512
integer width = 1097
integer height = 384
integer taborder = 40
boolean enabled = false
string title = "none"
string dataobject = "d_bom_bom014_update"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca) ;
end event

type st_2 from statictext within w_bom_dept_filter
integer x = 1765
integer y = 16
integer width = 453
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[조 FILTER]"
boolean focusrectangle = false
end type

type st_1 from statictext within w_bom_dept_filter
integer x = 5
integer y = 12
integer width = 453
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[조 LIST]"
boolean focusrectangle = false
end type

type cb_del from commandbutton within w_bom_dept_filter
integer x = 1618
integer y = 512
integer width = 142
integer height = 128
integer taborder = 30
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

ll_selected_count = f_bom_return_selected (dw_bom014, ll_selected_rows)
If ll_selected_count = 0 Then Return

If ll_selected_count > 0 Then 
	dw_dac001.SetRedraw(False)
	dw_bom014.SelectRow(0, False)
	For i = ll_selected_count To 1 Step -1 
		If dw_bom014.RowsCopy(ll_selected_rows[I], ll_selected_rows[I], Primary!, dw_dac001, 1, Primary!) = -1 Then Continue 
		ls_wc = dw_bom014.GetItemString(ll_selected_rows[I], "dac001_dcode") 
		dw_dac001.SelectRow(1, True) 
		ll_findRow = dw_update.Find("workcenter = '" + ls_wc + "'", 1, dw_update.RowCount()) 
		If ll_findRow > 0 Then dw_update.DeleteRow(ll_findRow)
		dw_bom014.DeleteRow(ll_selected_rows[I]) 	
	Next 
	dw_dac001.Sort() 
	dw_dac001.SetRedraw(True)	
	cb_save.Enabled = True 
End If 
end event

type cb_add from commandbutton within w_bom_dept_filter
integer x = 1618
integer y = 384
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

ll_selected_count = f_bom_return_selected (dw_dac001, ll_selected_rows)
If ll_selected_count = 0 Then Return

If ll_selected_count > 0 Then 
	dw_bom014.SetRedraw(False)
	dw_dac001.SelectRow(0, False)

	For i = ll_selected_count To 1 Step -1 
		
		If dw_dac001.RowsCopy(ll_selected_rows[I], ll_selected_rows[I], Primary!, dw_bom014, 1, Primary!) = -1 Then Continue 
	
		ls_wc = dw_dac001.GetItemString(ll_selected_rows[I], "dcode") 
		dw_bom014.SelectRow(1, True) 
		
		ll_findRow = dw_update.Find("workcenter = '" + ls_wc + "'", 1, dw_update.RowCount()) 
		If ll_findRow = 0 Then 
			ll_findRow = dw_update.InsertRow(0)
			dw_update.SetItem(ll_findRow, "empno", g_s_empno) 
			dw_update.SetItem(ll_findRow, "workcenter", ls_wc) 
			dw_update.SetItem(ll_findRow, "inptid", g_s_empno) 
			dw_update.SetItem(ll_findRow, "inptdt", g_s_date) 			
		End If 
		dw_dac001.DeleteRow(ll_selected_rows[I]) 	
	Next 
	dw_bom014.Sort() 
	dw_bom014.SetRedraw(True)	
	
	cb_save.Enabled = True 
End If

end event

type cb_close from commandbutton within w_bom_dept_filter
integer x = 2903
integer y = 960
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

event clicked;//If dw_update.ModifiedCount() > 0 or dw_update.DeletedCount() > 0 Then 
//	If f_pism_MessageBox(Question!, 999, '저장', "수정된 자료가 있습니다. 저장하시겠습니까?") = 1 Then &
//		cb_save.TriggerEvent(Clicked!) 
//End If 
//
Close(Parent) 
end event

type cb_save from commandbutton within w_bom_dept_filter
integer x = 2414
integer y = 960
integer width = 485
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "저장"
end type

event clicked;if dw_update.update() <> 1 then
	messagebox("확인","부서 필터 정보 저장중 오류가 발생했습니다.시스템개발팀에 문의바랍니다")
	return
end if
This.Enabled = False 
end event

type dw_bom014 from datawindow within w_bom_dept_filter
integer x = 1765
integer y = 96
integer width = 1609
integer height = 832
integer taborder = 10
string title = "none"
string dataobject = "d_bom_bom014"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
if row <= 0 then
	return
end if
If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	ii_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	ii_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

event constructor;this.settransobject(sqlca) ;
end event

type dw_dac001 from datawindow within w_bom_dept_filter
integer y = 96
integer width = 1609
integer height = 832
integer taborder = 10
string title = "none"
string dataobject = "d_bom_dac001"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca) ;
end event

event clicked;if row <= 0 then
	return
end if
If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	ii_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	ii_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
end event

