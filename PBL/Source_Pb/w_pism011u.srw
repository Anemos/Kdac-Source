$PBExportHeader$w_pism011u.srw
$PBExportComments$공수발생 세부내역 등록
forward
global type w_pism011u from w_pism_resp01
end type
type uo_rowskip from u_pism_rowskip within w_pism011u
end type
type dw_submh_free from datawindow within w_pism011u
end type
type tab_work from tab within w_pism011u
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_1 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_2 from userobject within tab_work
end type
type tabpage_3 from userobject within tab_work
end type
type tabpage_3 from userobject within tab_work
end type
type tab_work from tab within w_pism011u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type cb_save from commandbutton within w_pism011u
end type
type cb_delete from commandbutton within w_pism011u
end type
type cb_add from commandbutton within w_pism011u
end type
type cb_close from commandbutton within w_pism011u
end type
end forward

global type w_pism011u from w_pism_resp01
integer width = 2391
integer height = 1484
string title = "공수발생내역 편집"
boolean controlmenu = false
uo_rowskip uo_rowskip
dw_submh_free dw_submh_free
tab_work tab_work
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
cb_close cb_close
end type
global w_pism011u w_pism011u

type variables
Boolean ib_initChk
String is_modChk 
end variables

forward prototypes
public subroutine wf_setbutenabled (boolean ab_saveenabled)
public subroutine wf_retdetailworkdd (long al_row)
end prototypes

public subroutine wf_setbutenabled (boolean ab_saveenabled);Long ll_rowCnt 
Boolean lb_delEnabled 

ll_rowCnt = dw_submh_free.RowCount() 
If ll_rowCnt = 1 Then 
	If dw_submh_free.Find("IsNull(mhcode) or mhcode = ''", 1, 1) <> 1 Then lb_delEnabled = True
ElseIf ll_rowCnt > 1 Then 
	lb_delEnabled = True 
End If 

cb_delete.Enabled = lb_delEnabled 
cb_save.Enabled = ab_saveenabled  
end subroutine

public subroutine wf_retdetailworkdd (long al_row);DataWindowChild ldwc
String ls_mhCode

If al_row <= 0 Then Return 
If dw_submh_free.GetChild('tmhdailysub_detailwork', ldwc) = -1 Then Return 
ls_mhCode = dw_submh_free.GetItemString(al_row, "mhcode") 
ldwc.SetTransObject(SqlPIS) 
If IsNull(ls_mhCode) Or ls_mhCode = '' Then 
	ldwc.Reset() 
Else 
	ldwc.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.mhGbn, ls_mhCode) 
End If
ldwc.InsertRow(1) 
If dw_submh_free.GetChild('tmhdailysub_equipcode', ldwc) = -1 Then Return 
ldwc.SetTransObject(SqlCMMS) 
if ls_mhcode = 'U3' then
	ldwc.Retrieve(istr_mh.area,istr_mh.div,istr_mh.wc)
else
	ldwc.reset()
	ldwc.InsertRow(1) 
end if




end subroutine

on w_pism011u.create
int iCurrent
call super::create
this.uo_rowskip=create uo_rowskip
this.dw_submh_free=create dw_submh_free
this.tab_work=create tab_work
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_rowskip
this.Control[iCurrent+2]=this.dw_submh_free
this.Control[iCurrent+3]=this.tab_work
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.cb_close
end on

on w_pism011u.destroy
call super::destroy
destroy(this.uo_rowskip)
destroy(this.dw_submh_free)
destroy(this.tab_work)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_close)
end on

event open;call super::open;uo_rowskip.uf_setDW(dw_submh_free) 
cb_save.Enabled = False 
end event

event ue_retrieve;call super::ue_retrieve;dw_submh_free.SetRedraw(False)

dw_submh_free.SetTransObject(sqlPIS) 
If dw_submh_free.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, istr_mh.mhgbn) = 0 Then 
	cb_add.TriggerEvent("clicked") 
Else
	If Not IsNull(istr_mh.longParm) Then dw_submh_free.ScrollToRow(istr_mh.longParm) 
End If 
wf_setbutenabled(False) 
dw_submh_free.SetRedraw(True)

uo_rowskip.uf_setbutton() 
end event

type uo_rowskip from u_pism_rowskip within w_pism011u
integer y = 1200
integer taborder = 90
end type

on uo_rowskip.destroy
call u_pism_rowskip::destroy
end on

type dw_submh_free from datawindow within w_pism011u
event type long insert_data ( )
event type integer delete_data ( long al_delchk )
event type integer save_data ( )
integer x = 23
integer y = 112
integer width = 2272
integer height = 1044
integer taborder = 80
string title = "none"
string dataobject = "d_pism011u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long insert_data();Integer I 
Long ll_insrow, ll_findRow, ll_seq, ll_maxSeq 

ll_findRow = This.Find("IsNull(mhcode) or mhcode = ''", 1, This.RowCount()) 
If ll_findRow > 0 Then 
	ll_insrow = ll_findRow 
	Goto Exit_pr 
End If 

ll_insrow = This.insertRow(0)
If ll_insRow > 99 Then 
	f_pism_MessageBox(Information!, -1, "등록실패", "99개 항목이상 등록이 불가능합니다.")
	Return -1 
End If 

This.SetItem(ll_insRow, "areacode", istr_mh.area)
This.SetItem(ll_insrow, "divisioncode", istr_mh.div)
This.SetItem(ll_insrow, "workcenter", istr_mh.wc)
This.SetItem(ll_insrow, "workday", istr_mh.wday)
This.SetItem(ll_insrow, "mhgubun", istr_mh.mhgbn)

ll_findRow = This.Find("max(seqno) = seqno", 1, This.RowCount()) 

For I = 1 To This.RowCount() 
	ll_seq = This.GetItemNumber(I, "seqno") 
	If ll_seq > ll_maxSeq Then ll_maxSeq = ll_seq 
Next 

This.SetItem(ll_insrow, "seqno", ll_maxSeq + 1)

Exit_pr: 

This.ScrollToRow(ll_insRow) 
This.SetColumn("mhcode"); This.Setfocus()

wf_setbutenabled(True) 

Return ll_insrow 
end event

event type integer delete_data(long al_delchk);Long ll_delRow, ll_findRow 
String ls_delWork, ls_mhcode 

If al_delChk = 0 Then 
	ll_findRow = This.Find("IsNull(mhcode) or mhcode = '' or " + &
								  "IsNull(tmhdailysub_detailwork) or tmhdailysub_detailwork = ''", 1, This.RowCount()) 
	Do While ll_findRow > 0 
		This.DeleteRow(ll_findRow)
		ll_findRow = This.Find("IsNull(mhcode) or mhcode = '' or " + &
								  "IsNull(tmhdailysub_detailwork) or tmhdailysub_detailwork = ''", 1, This.RowCount()) 
	Loop 
Else
	ll_delRow = al_delChk 
	
	//ll_delRow = This.GetRow()
	ls_mhcode = This.GetItemString(ll_delRow, "mhcode")
	If IsNull(ls_mhcode) Then Goto Del_row
	
	ls_delWork = This.GetItemString(ll_delRow, "tmhdailysub_detailwork")
	If IsNull(ls_delWork) Then ls_delWork = '' 
	
	If f_pism_MessageBox(Question!, 9999, tab_work.Control[tab_work.SelectedTab].Text, ls_mhcode + " " + ls_delWork) <> 1 Then Return 0
Del_row:
	This.DeleteRow(ll_delRow) 
	
End If 

If al_delChk = 0 Then Return 1 
If This.RowCount() = 0 Then 
	cb_add.TriggerEvent(Clicked!) 
Else
	This.Event RowFocusChanged(ll_delRow) 
End If 

wf_setbutenabled(True) 

Return 1 
end event

event type integer save_data();string ls_mhcode

//if f_spacechk(this.object.mhcode[1]) = -1 then
//	ls_mhcode = ''
//end if
//
//if ls_mhcode <> 'U3' then
//	this.object.tmhdailysub_equipcode[1] = ''
//end if
//
If f_pism_dwupdate(This, True) <> -1 Then 
	is_modChk = '1' 
	If This.RowCount() = 0 Then cb_add.TriggerEvent(Clicked!) 
	wf_setbutenabled(False) 
	Return 1 
End If 

Return -1 

end event

event retrievestart;DataWindowChild ldwc 
If dw_submh_free.GetChild('mhcode', ldwc) <> -1 Then
	ldwc.SetTransObject(SqlPIS); ldwc.Retrieve(istr_mh.mhgbn)
End If 
If dw_submh_free.GetChild('workcenter_1', ldwc) <> -1 Then
	ldwc.SetTransObject(SqlPIS); ldwc.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc)
End If 
If dw_submh_free.GetChild('tmhdailysub_detailwork', ldwc) <> -1 Then
	ldwc.SetTransObject(SqlPIS); ldwc.InsertRow(0) 
End If 
If dw_submh_free.GetChild('tmhdailysub_equipcode', ldwc) <> -1 Then
	ldwc.SetTransObject(SqlCMMS); ldwc.InsertRow(0) 
End If

end event

event itemfocuschanged;String ls_value

CHOOSE CASE dwo.name
	CASE 'tmhdailysub_detailwork'
		ls_value = String(THIS.Object.tmhdailysub_detailwork[row])
		
	CASE 'tmhdailysub_fromtime'
		ls_value = "hh:mm"
		
	CASE 'tmhdailysub_totime'
		ls_value = "hh:mm"
		
	CASE 'tmhdailysub_submh'
		ls_value = String(THIS.Object.tmhdailysub_submh[row], '#0.0')
			
	CASE ELSE
		ls_value = ""
END CHOOSE
THIS.SelectText(1,len(ls_value))
end event

event itemchanged;This.AcceptText() 

wf_setbutenabled(True) 
If String(dwo.Name) = 'mhcode_1' or String(dwo.Name) = 'mhcode' Then wf_retdetailworkdd(row) 
If String(dwo.Name) = 'tmhdailysub_detailwork' Then This.SelectText(1, Len(data)) 


end event

event rowfocuschanged;uo_rowskip.uf_setbutton() 
wf_retdetailworkdd(currentrow) 
end event

event losefocus;This.AcceptText() 
end event

type tab_work from tab within w_pism011u
integer width = 2341
integer height = 1192
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
boolean createondemand = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;
Parent.Title = This.Control[newindex].Text + ' 공수 발생내역 편집'
istr_mh.mhgbn = This.Control[newindex].Tag 

Parent.TriggerEvent("ue_retrieve") 
end event

event selectionchanging;Integer I 

If ib_initChk Then Goto Exit_pr 
If This.Control[newindex].Tag <> istr_mh.mhgbn Then 
	
	For I = 1 To UpperBound(This.Control[])
		If istr_mh.mhgbn = This.Control[I].Tag Then 
			This.SelectedTab = I
			Exit
		End If 
	Next 
	Return 1 
End If 

Exit_pr:

ib_initChk = True 

If cb_save.Enabled Then 
	If f_pism_MessageBox(Question!, 999, "저장", "수정된 자료를 저장하시겠습니까?") = 1 Then cb_save.TriggerEvent(Clicked!) 
	Return 
End If 
end event

type tabpage_1 from userobject within tab_work
string tag = "F"
integer x = 18
integer y = 100
integer width = 2304
integer height = 1076
long backcolor = 12632256
string text = "부가작업"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_work
string tag = "U"
integer x = 18
integer y = 100
integer width = 2304
integer height = 1076
long backcolor = 12632256
string text = "유휴"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_work
string tag = "Z"
integer x = 18
integer y = 100
integer width = 2304
integer height = 1076
long backcolor = 12632256
string text = "능률저하"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
end type

type cb_save from commandbutton within w_pism011u
integer x = 1888
integer y = 1216
integer width = 224
integer height = 152
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;Long ll_findRow 

dw_submh_free.AcceptText()

ll_findRow = dw_submh_free.Find("( Not IsNull(mhcode) ) And ( IsNull(tmhdailysub_detailwork) or " + &
										  "tmhdailysub_detailwork = '')", 1, dw_submh_free.RowCount()) 
If ll_findRow > 0 Then f_pism_MessageBox(Information!, 999, "입력오류", "공수 발생내역이 입력되지 않은 항목은 저장되지 않습니다.")

if dw_submh_free.object.mhcode[1] <> 'U3' then
	dw_submh_free.object.tmhdailysub_equipcode[1] = ''
	dw_submh_free.object.tmhdailysub_equipcode_1[1] = ''
else
	if dw_submh_free.object.mhcode[1] = 'U3' and f_spacechk(dw_submh_free.object.tmhdailysub_equipcode[1]) = -1 then
		messagebox("확인","설비고장시에는 반드시 장비코드를 입력해야 합니다")
		return
	end if
end if
If dw_submh_free.Event delete_data(0) = -1 Then Return
If dw_submh_free.Event save_data() <> -1 Then Return 
end event

type cb_delete from commandbutton within w_pism011u
integer x = 1664
integer y = 1216
integer width = 224
integer height = 152
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;dw_submh_free.Event delete_data(dw_submh_free.GetRow()) 
end event

type cb_add from commandbutton within w_pism011u
integer x = 1440
integer y = 1216
integer width = 224
integer height = 152
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "추가"
end type

event clicked;dw_submh_free.Event Insert_data() 
end event

type cb_close from commandbutton within w_pism011u
integer x = 2112
integer y = 1216
integer width = 224
integer height = 152
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;If cb_save.Enabled Then 
	If f_pism_MessageBox(Question!, 999, "저장", "수정된 자료를 저장하시겠습니까?") = 1 Then cb_save.TriggerEvent(Clicked!) 
End If 
CloseWithReturn(Parent, is_modChk) 
end event

