$PBExportHeader$w_pism031u.srw
$PBExportComments$유사군 명칭 관리
forward
global type w_pism031u from window
end type
type dw_wcitemgroup from datawindow within w_pism031u
end type
type cb_delete from commandbutton within w_pism031u
end type
type cb_add from commandbutton within w_pism031u
end type
type cb_save from commandbutton within w_pism031u
end type
end forward

global type w_pism031u from window
integer width = 997
integer height = 1336
boolean titlebar = true
string title = "유사군 명칭 편집"
windowtype windowtype = response!
long backcolor = 12632256
dw_wcitemgroup dw_wcitemgroup
cb_delete cb_delete
cb_add cb_add
cb_save cb_save
end type
global w_pism031u w_pism031u

type variables
str_pism_wcgroup istr_wcgroup 
end variables

on w_pism031u.create
this.dw_wcitemgroup=create dw_wcitemgroup
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_save=create cb_save
this.Control[]={this.dw_wcitemgroup,&
this.cb_delete,&
this.cb_add,&
this.cb_save}
end on

on w_pism031u.destroy
destroy(this.dw_wcitemgroup)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_save)
end on

event open;istr_wcgroup = message.PowerObjectParm 

istr_wcgroup.dw_wcgroup.ShareData(dw_wcitemgroup)

f_pisc_win_center_move(This) 

dw_wcitemgroup.SetFilter("wcitemgroup <> '' And Not IsNull(wcitemgroup)")
dw_wcitemgroup.Filter() 
end event

type dw_wcitemgroup from datawindow within w_pism031u
integer width = 946
integer height = 1104
integer taborder = 10
string title = "none"
string dataobject = "d_pism_wcitemgroup_dd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;//If This.RowCount() = 0 or currentrow = 0 Then Return 
//
//Integer li_inschk 
//Boolean lb_Enabled
//
//li_inschk = This.GetItemNumber(currentrow, "inschk") 
//If li_insChk = 0 Then lb_Enabled = True
//
//cb_delete.Enabled = lb_Enabled 
end event

event losefocus;dw_wcitemgroup.AcceptText()
end event

type cb_delete from commandbutton within w_pism031u
integer x = 320
integer y = 1116
integer width = 315
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;Long ll_delRow, ll_findRow 
String ls_wcGroup 

ll_delRow = dw_wcitemgroup.GetRow() 
ls_wcGroup = dw_wcitemgroup.GetItemString(ll_delRow, "wcitemgroup")
ll_findRow = istr_wcgroup.dw_wcitem.Find("wcitemgroup = '" + ls_wcGroup + "' And useflag <> '3'", 1, istr_wcgroup.dw_wcitem.RowCount()) 
If ll_findRow > 0 Then 
 If f_pism_MessageBox(Question!, 999, "삭제", "'" + ls_wcGroup + "' 명칭으로 그룹화된 품번이 존재합니다. ~n~n모두 함께 삭제하시겠습니까?") <> 1 Then Return 
End If

f_pism_working_msg("유사그룹 취소", "해당 유사그룹의 품번을 취소중입니다.") 

ll_findRow = istr_wcgroup.dw_wcitem.Find("wcitemgroup = '" + ls_wcGroup + "'", 1, istr_wcgroup.dw_wcitem.RowCount()) 
Do While ll_findRow > 0 
	If istr_wcgroup.dw_wcitem.Dynamic Event delete_row(ll_findRow) = 0 Then Exit 
	ll_findRow = istr_wcgroup.dw_wcitem.Find("wcitemgroup = '" + ls_wcGroup + "'", 1, istr_wcgroup.dw_wcitem.RowCount()) 
Loop 
dw_wcitemgroup.DeleteRow(dw_wcitemgroup.Getrow()) 

If IsValid(w_pism_working) Then Close(w_pism_working)

end event

type cb_add from commandbutton within w_pism031u
integer x = 5
integer y = 1116
integer width = 315
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "추가"
end type

event clicked;cb_delete.Enabled = True 

dw_wcitemgroup.ScrollToRow(dw_wcitemgroup.InsertRow(0))
dw_wcitemgroup.Setfocus()
end event

type cb_save from commandbutton within w_pism031u
integer x = 635
integer y = 1116
integer width = 315
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
end type

event clicked;
dw_wcitemgroup.AcceptText()
dw_wcitemgroup.SetFilter(''); dw_wcitemgroup.Filter() 

Close(Parent)
end event

