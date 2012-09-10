$PBExportHeader$w_pism015u.srw
$PBExportComments$작업일보 출력
forward
global type w_pism015u from w_pism_sheet01
end type
type tab_work from tab within w_pism015u
end type
type tabpage_1 from userobject within tab_work
end type
type st_8 from statictext within tabpage_1
end type
type sle_prcopys from singlelineedit within tabpage_1
end type
type st_2 from statictext within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type ddlb_scale from dropdownlistbox within tabpage_1
end type
type st_5 from statictext within tabpage_1
end type
type p_3 from picture within tabpage_1
end type
type st_4 from statictext within tabpage_1
end type
type sle_prscale from singlelineedit within tabpage_1
end type
type st_3 from statictext within tabpage_1
end type
type p_2 from picture within tabpage_1
end type
type dw_prdaily from datawindow within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_work
st_8 st_8
sle_prcopys sle_prcopys
st_2 st_2
st_6 st_6
ddlb_scale ddlb_scale
st_5 st_5
p_3 p_3
st_4 st_4
sle_prscale sle_prscale
st_3 st_3
p_2 p_2
dw_prdaily dw_prdaily
gb_2 gb_2
end type
type tabpage_2 from userobject within tab_work
end type
type cb_seqreset from commandbutton within tabpage_2
end type
type cb_save from commandbutton within tabpage_2
end type
type cb_delete from commandbutton within tabpage_2
end type
type cb_insert from commandbutton within tabpage_2
end type
type dw_prwcitem from u_pism_dw within tabpage_2
end type
type dw_prwcitem_save from u_pism_dw within tabpage_2
end type
type tabpage_2 from userobject within tab_work
cb_seqreset cb_seqreset
cb_save cb_save
cb_delete cb_delete
cb_insert cb_insert
dw_prwcitem dw_prwcitem
dw_prwcitem_save dw_prwcitem_save
end type
type tab_work from tab within w_pism015u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type cb_prodlist from commandbutton within w_pism015u
end type
type st_help from statictext within w_pism015u
end type
type st_7 from statictext within w_pism015u
end type
end forward

global type w_pism015u from w_pism_sheet01
integer width = 3872
tab_work tab_work
cb_prodlist cb_prodlist
st_help st_help
st_7 st_7
end type
global w_pism015u w_pism015u

type variables
Integer ii_page1LineCnt = 26, ii_page2LineCnt = 33 
String is_modChk = '0' 
end variables

on w_pism015u.create
int iCurrent
call super::create
this.tab_work=create tab_work
this.cb_prodlist=create cb_prodlist
this.st_help=create st_help
this.st_7=create st_7
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_work
this.Control[iCurrent+2]=this.cb_prodlist
this.Control[iCurrent+3]=this.st_help
this.Control[iCurrent+4]=this.st_7
end on

on w_pism015u.destroy
call super::destroy
destroy(this.tab_work)
destroy(this.cb_prodlist)
destroy(this.st_help)
destroy(this.st_7)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(tab_work, FULL)

of_resize()

end event

event ue_retrieve;call super::ue_retrieve;Long ll_ret 

If tab_work.tabpage_2.dw_prwcitem_save.ModifiedCount() > 0 Or tab_work.tabpage_2.dw_prwcitem_save.DeletedCount() > 0 Then 
	If f_pism_MessageBox(Question!, 999, "저장", "수정된 내역이 있습니다. 저장하시겠습니까?") = 1 Then &
		tab_work.tabpage_2.cb_save.TriggerEvent(Clicked!) 
End If 

tab_work.control[tab_work.SelectedTab].SetRedraw(False)

f_pism_working_msg(uo_area.is_uo_areaname + " " + uo_div.is_uo_divisionname + " " + uo_wc.is_uo_workcentername + "조", &
						 "작업일보 미리보기 작업을 준비중입니다. 잠시만 기다려 주십시오.") 

ll_ret = tab_work.Event ue_Retrieve(tab_work.SelectedTab) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
tab_work.control[tab_work.SelectedTab].SetRedraw(True)

tab_work.control[tab_work.SelectedTab].SetFocus()

is_modChk = '0' 
end event

event ue_postopen;call super::ue_postopen;tab_work.tabpage_1.dw_prdaily.Modify("datawindow.print.Preview = Yes")
tab_work.tabpage_1.dw_prdaily.Modify("datawindow.print.Preview.Rulers = Yes")

cb_prodlist.Enabled = m_frame.m_action.m_save.Enabled  
tab_work.tabpage_2.cb_insert.Enabled = m_frame.m_action.m_save.Enabled 
tab_work.tabpage_2.cb_delete.Enabled = m_frame.m_action.m_save.Enabled 
tab_work.tabpage_2.cb_save.Enabled   = m_frame.m_action.m_save.Enabled 
tab_work.tabpage_2.cb_seqreset.Enabled = m_frame.m_action.m_save.Enabled 

If cb_wcfilter.Text = '담당조 FILTER 취소' Then wf_autworkcenter(True) 

end event

event ue_print;call super::ue_print;String ls_prCopys 

ls_prCopys = Trim(tab_work.tabpage_1.sle_prcopys.Text) 
If ls_prCopys = '' Then 
	MessageBox("출력실패", "출력매수를 확인하십시오")
	Return 
End If 
tab_work.tabpage_1.dw_prdaily.Modify("datawindow.print.copies = " + ls_prCopys ) 
tab_work.tabpage_1.dw_prdaily.Print() 

end event

event open;call super::open;st_help.Text = "생산품목 [ 갑지 : " + String(ii_page1LineCnt) + " 라인, 을지 : " + String(ii_page2LineCnt) + " 라인 ]" 
tab_work.tabpage_2.dw_prwcitem_save.Visible = False 
end event

event closequery;call super::closequery;If tab_work.tabpage_2.dw_prwcitem_save.ModifiedCount() > 0 Or tab_work.tabpage_2.dw_prwcitem_save.DeletedCount() > 0 Then 
	If f_pism_MessageBox(Question!, 999, "저장", "수정된 내역이 있습니다. 저장하시겠습니까?") = 1 Then &
		tab_work.tabpage_2.cb_save.TriggerEvent(Clicked!) 
End If 

end event

type uo_status from w_pism_sheet01`uo_status within w_pism015u
end type

type uo_wc from w_pism_sheet01`uo_wc within w_pism015u
end type

type uo_area from w_pism_sheet01`uo_area within w_pism015u
end type

type uo_div from w_pism_sheet01`uo_div within w_pism015u
end type

type cb_wcfilter from w_pism_sheet01`cb_wcfilter within w_pism015u
integer y = 44
integer height = 80
end type

type gb_1 from w_pism_sheet01`gb_1 within w_pism015u
end type

type tab_work from tab within w_pism015u
event resize pbm_size
event type long ue_retrieve ( integer ai_selectedtab )
integer x = 14
integer y = 152
integer width = 3273
integer height = 1852
integer taborder = 20
boolean bringtotop = true
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
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

event resize;tabpage_1.dw_prdaily.Width = newwidth - ( tabpage_1.dw_prdaily.x + 40 )
tabpage_1.dw_prdaily.Height = newheight - ( tabpage_1.dw_prdaily.y + 120 )

tabpage_2.dw_prwcitem.Width = newwidth - ( tabpage_2.dw_prwcitem.x + 40 ) 
tabpage_2.dw_prwcitem.Height = newheight - ( tabpage_2.dw_prwcitem.y + 120 ) 
end event

event type long ue_retrieve(integer ai_selectedtab);//If ai_selectedTab = 1 Then 
String ls_curr 

ls_curr = String(f_pisc_get_date_nowtime(), 'YYYY.MM.DD') 
tabpage_2.dw_prwcitem_save.SetTransObject(SqlPIS)
tabpage_2.dw_prwcitem_save.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, ls_curr) 
tabpage_2.dw_prwcitem.SetTransObject(SqlPIS) 
tabpage_2.dw_prwcitem.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc) 
tabpage_1.dw_prdaily.SetTransObject(SqlPIS)
tabpage_1.dw_prdaily.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc) 
Return 0

//End If 

end event

on tab_work.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_work.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;If newindex = 1 Then 
	If is_modChk = '1' Then Parent.TriggerEvent("ue_retrieve") 
End If
end event

type tabpage_1 from userobject within tab_work
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3237
integer height = 1736
long backcolor = 12632256
string text = "미리보기"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_8 st_8
sle_prcopys sle_prcopys
st_2 st_2
st_6 st_6
ddlb_scale ddlb_scale
st_5 st_5
p_3 p_3
st_4 st_4
sle_prscale sle_prscale
st_3 st_3
p_2 p_2
dw_prdaily dw_prdaily
gb_2 gb_2
end type

on tabpage_1.create
this.st_8=create st_8
this.sle_prcopys=create sle_prcopys
this.st_2=create st_2
this.st_6=create st_6
this.ddlb_scale=create ddlb_scale
this.st_5=create st_5
this.p_3=create p_3
this.st_4=create st_4
this.sle_prscale=create sle_prscale
this.st_3=create st_3
this.p_2=create p_2
this.dw_prdaily=create dw_prdaily
this.gb_2=create gb_2
this.Control[]={this.st_8,&
this.sle_prcopys,&
this.st_2,&
this.st_6,&
this.ddlb_scale,&
this.st_5,&
this.p_3,&
this.st_4,&
this.sle_prscale,&
this.st_3,&
this.p_2,&
this.dw_prdaily,&
this.gb_2}
end on

on tabpage_1.destroy
destroy(this.st_8)
destroy(this.sle_prcopys)
destroy(this.st_2)
destroy(this.st_6)
destroy(this.ddlb_scale)
destroy(this.st_5)
destroy(this.p_3)
destroy(this.st_4)
destroy(this.sle_prscale)
destroy(this.st_3)
destroy(this.p_2)
destroy(this.dw_prdaily)
destroy(this.gb_2)
end on

type st_8 from statictext within tabpage_1
integer x = 2427
integer y = 76
integer width = 101
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "매"
boolean focusrectangle = false
end type

type sle_prcopys from singlelineedit within tabpage_1
integer x = 2254
integer y = 56
integer width = 146
integer height = 84
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "1"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within tabpage_1
integer x = 1874
integer y = 72
integer width = 402
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "출력매수 :"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_1
integer x = 823
integer y = 76
integer width = 64
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "%"
boolean focusrectangle = false
end type

type ddlb_scale from dropdownlistbox within tabpage_1
integer x = 558
integer y = 56
integer width = 247
integer height = 512
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "100"
boolean allowedit = true
boolean sorted = false
string item[] = {"50","60","70","80","90","100","150","200"}
borderstyle borderstyle = stylelowered!
end type

event modified;dw_prdaily.Object.DataWindow.Print.Preview.Zoom = This.Text 
end event

type st_5 from statictext within tabpage_1
integer x = 183
integer y = 72
integer width = 366
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "미리보기 :"
boolean focusrectangle = false
end type

type p_3 from picture within tabpage_1
integer x = 69
integer y = 64
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "bmp\preview.bmp"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_1
integer x = 1705
integer y = 72
integer width = 69
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "%"
boolean focusrectangle = false
end type

type sle_prscale from singlelineedit within tabpage_1
integer x = 1504
integer y = 56
integer width = 178
integer height = 84
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
string text = "85"
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within tabpage_1
integer x = 1125
integer y = 68
integer width = 370
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "출력배율 :"
boolean focusrectangle = false
end type

type p_2 from picture within tabpage_1
integer x = 1015
integer y = 64
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "bmp\PRINTER.BMP"
boolean focusrectangle = false
end type

type dw_prdaily from datawindow within tabpage_1
integer y = 164
integer width = 3090
integer height = 1508
integer taborder = 20
string title = "none"
string dataobject = "d_pism010u_01_blank_p"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;This.SetRedraw(False)
This.Modify("datawindow.zoom = " + sle_prscale.Text )
This.SetRedraw(True)

end event

type gb_2 from groupbox within tabpage_1
integer x = 5
integer width = 2537
integer height = 152
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type tabpage_2 from userobject within tab_work
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3237
integer height = 1736
long backcolor = 12632256
string text = "여백라인 설정"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_seqreset cb_seqreset
cb_save cb_save
cb_delete cb_delete
cb_insert cb_insert
dw_prwcitem dw_prwcitem
dw_prwcitem_save dw_prwcitem_save
end type

on tabpage_2.create
this.cb_seqreset=create cb_seqreset
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_insert=create cb_insert
this.dw_prwcitem=create dw_prwcitem
this.dw_prwcitem_save=create dw_prwcitem_save
this.Control[]={this.cb_seqreset,&
this.cb_save,&
this.cb_delete,&
this.cb_insert,&
this.dw_prwcitem,&
this.dw_prwcitem_save}
end on

on tabpage_2.destroy
destroy(this.cb_seqreset)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_insert)
destroy(this.dw_prwcitem)
destroy(this.dw_prwcitem_save)
end on

type cb_seqreset from commandbutton within tabpage_2
integer x = 841
integer y = 48
integer width = 594
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "전체 여백라인 삭제"
end type

event clicked;Long ll_findRow 
String ls_Sort 

If f_pism_MessageBox(Question!, 999, "초기화", "해당 작업일보의 여백라인을 모두 제거하시겠습니까?") <> 1 Then Return 

ll_findRow = dw_prwcitem.Find("useflag = '3'", 1, dw_prwcitem.RowCount()) 
Do While ll_findRow > 0 
	dw_prwcitem.DeleteRow(ll_findRow) 
	ll_findRow = dw_prwcitem.Find("useflag = '3'", 1, dw_prwcitem.RowCount()) 
Loop 

ll_findRow = dw_prwcitem_save.Find("useflag = '3'", 1, dw_prwcitem_save.RowCount()) 
Do While ll_findRow > 0 
	dw_prwcitem_save.DeleteRow(ll_findRow) 
	ll_findRow = dw_prwcitem_save.Find("useflag = '3'", 1, dw_prwcitem_save.RowCount()) 
Loop 

dw_prwcitem.SetFocus() 
end event

type cb_save from commandbutton within tabpage_2
integer x = 1435
integer y = 48
integer width = 416
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;dw_prwcitem_save.TriggerEvent("save_data") 

is_modChk = '1' 
dw_prwcitem.ScrollToRow(1); dw_prwcitem.SetFocus() 
end event

type cb_delete from commandbutton within tabpage_2
integer x = 425
integer y = 48
integer width = 416
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;Long 		ll_selected_count, ll_selected_rows[], ll_delRow, ll_spcRow 
Integer 	I, li_spcSeq, li_spcSeq_all 
String 		ls_wcGroup 

ll_selected_count = f_pism_return_selected (tab_work.tabpage_2.dw_prwcitem, ll_selected_rows)

If ll_selected_count = 0 Then Return 0 

If ll_selected_count > 0 Then 
	dw_prwcitem.SetRedraw(False)
	For i = ll_selected_count To 1 Step -1 
		If  dw_prwcitem.GetItemString(ll_selected_rows[I], "useflag") <> '3' Then Continue 
		ll_spcRow = dw_prwcitem.Find("useflag = '3'", 1, dw_prwcitem.RowCount())
		Do While ll_spcRow <> ll_selected_rows[I] 
			If ll_spcRow >= dw_prwcitem.RowCount() Then Exit 
			li_spcSeq++ 
			ll_spcRow = dw_prwcitem.Find("useflag = '3'", ll_spcRow + 1, dw_prwcitem.RowCount())
		Loop 
		
		ll_delRow = dw_prwcitem_save.Find("useflag = '3'", 1, dw_prwcitem_save.RowCount()) 
		Do While li_spcSeq <> li_spcSeq_all 
			If ll_delRow >= dw_prwcitem.RowCount() Then Exit 
			li_spcSeq_all++ 
			ll_delRow = dw_prwcitem_save.Find("useflag = '3'", ll_delRow + 1, dw_prwcitem_save.RowCount())
		Loop 
		dw_prwcitem.DeleteRow(ll_selected_rows[I]) 
		dw_prwcitem_save.DeleteRow(ll_delRow) 
	Next 
	dw_prwcitem.SetRedraw(True)
End If 

dw_prwcitem.SetFocus() 
end event

type cb_insert from commandbutton within tabpage_2
integer x = 9
integer y = 48
integer width = 416
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삽입"
end type

event clicked;dw_prwcitem.Event insert_data(dw_prwcitem.Getrow() + 1) 
dw_prwcitem.SetFocus() 
end event

type dw_prwcitem from u_pism_dw within tabpage_2
event insert_data ( long al_insrow )
integer x = 5
integer y = 136
integer width = 2889
integer height = 1200
integer taborder = 11
string dataobject = "d_pism010u_09"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event insert_data(long al_insrow);Long ll_insRow, ll_orgRow, ll_alltarRow, ll_findrow 
String ls_NULL, ls_wcGroup, ls_ItemCode, ls_LineCode, ls_LineNo 

SetNull(ls_NULL) //; SetNull(ls_wcGroup) 
//This.SelectRow(0, False) 
ll_insRow = This.InsertRow(al_insrow) 

ll_orgRow = ll_insRow - 1 
This.SetItem(ll_insRow, "areacode", istr_mh.area)
This.SetItem(ll_insrow, "divisioncode", istr_mh.div)
This.SetItem(ll_insrow, "workcenter", istr_mh.wc)
If al_insRow = 0 Then 
	ls_wcGroup = '' 
Else
	ls_wcGroup = This.GetItemString(ll_orgRow, "wcitemgroup") 
End If 
	
//If ll_insrow > 0 And This.GetItemString(ll_orgRow, "useflag") <> '3' And &
//	al_insRow > 0 Then ls_wcGroup = This.GetItemString(ll_orgRow, "wcitemgroup") 

If ll_orgRow > 0 Then 
	If This.GetItemString(ll_orgRow, "useflag") <> '3' Then 
		ls_ItemCode = This.GetItemString(ll_orgRow, "ItemCode")
		ls_LineCode = This.GetItemString(ll_orgRow, "subLineCode")
		ls_LineNo = This.GetItemString(ll_orgRow, "subLineNo") 
		
		ll_alltarRow = dw_prwcitem_save.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
														 "sublineno = '" + ls_LineNo + "'", 1, dw_prwcitem_save.RowCount()) 
		If ll_alltarRow = 0 Then 
			f_pism_MessageBox(StopSign!, -1, "여백라인 삽입 실패", "여백라인 삽입위치의 항목찾기에 실패했습니다.")
			This.DeleteRow(ll_insRow) 
			Return 
		Else
			ll_alltarRow += 1 
		End If 
	Else
		If IsNull(ls_wcGroup) Or ls_wcGroup = '' Then 
			ll_alltarRow = 0 
		Else
			ll_alltarRow = dw_prwcitem_save.Find("wcitemgroup = '" + ls_wcGroup + "' And useflag = '3'", 1, dw_prwcitem_save.RowCount()) 
			If ll_alltarRow = 0 Then 
				ll_findrow = dw_prwcitem_save.Find("wcitemgroup = '" + ls_wcGroup + "'", 1, dw_prwcitem_save.RowCount()) 
				Do While ll_findrow > 0 
					If ll_findRow >= dw_prwcitem_save.RowCount() Then Exit 
					ll_alltarRow = ll_findrow 
					ll_findrow = dw_prwcitem_save.Find("wcitemgroup = '" + ls_wcGroup + "'", ll_findrow + 1, dw_prwcitem_save.RowCount()) 
				Loop
			Else
				ll_alltarRow += 1 
			End If 
			SetNull(ls_wcGroup) 
		End If 
	End If 
End If 

This.SetItem(ll_insrow, "wcitemgroup", ls_wcGroup)
This.SetItem(ll_insRow, "itemcode", '')
This.SetItem(ll_insRow, "sublinecode", '')
This.SetItem(ll_insRow, "sublineno", '')
This.SetItem(ll_insRow, "useflag", '3')
This.GroupCalc() 

ll_insrow = dw_prwcitem_save.InsertRow(ll_alltarRow)
dw_prwcitem_save.SetItem(ll_insRow, "areacode", istr_mh.area)
dw_prwcitem_save.SetItem(ll_insrow, "divisioncode", istr_mh.div)
dw_prwcitem_save.SetItem(ll_insrow, "workcenter", istr_mh.wc)
dw_prwcitem_save.SetItem(ll_insRow, "wcitemgroup", ls_wcGroup) 
dw_prwcitem_save.SetItem(ll_insRow, "ItemCode", '') 
dw_prwcitem_save.SetItem(ll_insRow, "sublinecode", '')
dw_prwcitem_save.SetItem(ll_insRow, "sublineno", '')
dw_prwcitem_save.SetItem(ll_insRow, "useflag", '3')

dw_prwcitem_save.SelectRow(ll_insRow, True)

//This.ScrollToRow(ll_insRow); This.Selectrow(ll_insRow, True)
end event

event delete_data;call super::delete_data;Long 		ll_selected_count, ll_selected_rows[], ll_delRow, ll_spcRow 
Integer 	I, li_spcSeq, li_spcSeq_all 
String 		ls_wcGroup 

ll_selected_count = f_pism_return_selected (This, ll_selected_rows)

If ll_selected_count = 0 Then Return 0 

If ll_selected_count > 0 Then 
	This.SetRedraw(False)

	For i = ll_selected_count To 1 Step -1 
		If This.GetItemString(ll_selected_rows[I], "useflag") <> '3' Then Continue 
		ll_spcRow = This.Find("( wcitemgroup = '' Or IsNull(wcitemgroup) ) And useflag = '3'", 1, This.RowCount())
		Do While ll_spcRow <> ll_selected_rows[I] 
			If ll_spcRow >= This.RowCount() Then Exit 
			li_spcSeq++ 
			ll_spcRow = This.Find("( wcitemgroup = '' Or IsNull(wcitemgroup) ) And useflag = '3'", ll_spcRow + 1, This.RowCount())
		Loop 
		
		ll_delRow = dw_prwcitem_save.Find("( wcitemgroup = '' Or IsNull(wcitemgroup) ) And useflag = '3'", 1, dw_prwcitem_save.RowCount()) 
		Do While li_spcSeq <> li_spcSeq_all 
			If ll_delRow >= This.RowCount() Then Exit 
			li_spcSeq_all++ 
			ll_delRow = dw_prwcitem_save.Find("( wcitemgroup = '' Or IsNull(wcitemgroup) ) And useflag = '3'", ll_delRow + 1, dw_prwcitem_save.RowCount())
		Loop 
	
////	If This.GetItemString(ll_selected_rows[I], "useflag") <> '3' Then Continue 
//		ls_wcGroup = trim(This.GetItemString(ll_selected_rows[I], "wcitemgroup"))
//		ls_itemcode = trim(This.GetItemString(ll_selected_rows[I], "itemcode"))
//		If IsNull(ls_wcGroup) Or ls_wcGroup = '' or IsNull(ls_Itemcode) Or ls_Itemcode = '' Then 
////			ll_spcRow = This.Find("( wcitemgroup = '' Or IsNull(wcitemgroup) ) And useflag = '3'", 1, This.RowCount())
//			ll_spcRow = This.Find("  wcitemgroup = '' Or IsNull(wcitemgroup)  or  itemcode = '' Or IsNull(itemcode)  ", 1, This.RowCount())
//			Do While ll_spcRow <> ll_selected_rows[I] 
//				If ll_spcRow >= This.RowCount() Then Exit 
//				li_spcSeq++ 
////				ll_spcRow = This.Find("( wcitemgroup = '' Or IsNull(wcitemgroup) ) And useflag = '3'", ll_spcRow + 1, This.RowCount())
//				ll_spcRow = This.Find("  wcitemgroup = '' Or IsNull(wcitemgroup)  or  itemcode = '' Or IsNull(itemcode)  ", ll_spcRow + 1, This.RowCount())
//			Loop 
//			
////			ll_delRow = dw_prwcitem_save.Find("( wcitemgroup = '' Or IsNull(wcitemgroup) ) And useflag = '3'", 1, dw_prwcitem_save.RowCount()) 
//			ll_delRow = dw_prwcitem_save.Find(" wcitemgroup = '' Or IsNull(wcitemgroup) or  itemcode = '' Or IsNull(itemcode) ", 1, dw_prwcitem_save.RowCount()) 
//			Do While li_spcSeq <> li_spcSeq_all 
//				If ll_delRow >= This.RowCount() Then Exit 
//				li_spcSeq_all++ 
////				ll_delRow = dw_prwcitem_save.Find("( wcitemgroup = '' Or IsNull(wcitemgroup) ) And useflag = '3'", ll_delRow + 1, dw_prwcitem_save.RowCount()) 
//				ll_delRow = dw_prwcitem_save.Find(" wcitemgroup = '' Or IsNull(wcitemgroup) or  itemcode = '' Or IsNull(itemcode) ", ll_delRow + 1, dw_prwcitem_save.RowCount()) 				
//			Loop 
//		Else
////			ll_delRow = dw_prwcitem_save.Find("wcitemgroup = '" + ls_wcGroup + "' And useflag = '3'", 1, dw_prwcitem_save.RowCount()) 
//			continue
//		End If 				
		
		This.DeleteRow(ll_selected_rows[I]) 
		dw_prwcitem_save.DeleteRow(ll_delRow) 
	Next 
	This.SetRedraw(True)
End If 

This.SelectRow(0, False)
This.SelectRow(This.GetRow(), True) 
Return 1 
end event

event retrieveend;call super::retrieveend;Integer li_spcLine, li_page2Cnt, I 
String ls_wcGroup 
Long ll_rowCnt 

This.SelectRow(0, False) 
For I = rowcount To 1 Step -1 
	If This.GetItemString(I, "useflag") = '3' Then
		ls_wcGroup = This.GetItemString(I, "wcitemgroup") 
		If IsNull(ls_wcGroup) or ls_wcGroup = '' Then This.SelectRow(I, True) 
	Else
		Exit 
	End If 
Next 

This.Event Delete_data(0) 

ll_rowCnt = This.RowCount() 
If ll_rowCnt <= ii_page1LineCnt Then 
	li_spcLine = ii_page1LineCnt - ll_rowCnt 
ElseIf ll_rowCnt <= ( ii_page1LineCnt + ii_page2LineCnt ) Then 
	li_spcLine = ii_page2LineCnt - ( ll_rowCnt - ii_page1LineCnt ) 
Else
	li_page2Cnt = Truncate( ( ll_rowCnt - ii_page1LineCnt ) / ii_page2LineCnt, 0 ) 
	li_spcLine = ii_page2LineCnt - ( ll_rowCnt - ( ii_page1LineCnt + ( ii_page2LineCnt * li_page2Cnt ) ) ) 
End If 

For I = 1 To li_spcLine 
	This.Event insert_data(0) 
Next 

cb_save.TriggerEvent(Clicked!) 

end event

type dw_prwcitem_save from u_pism_dw within tabpage_2
integer x = 2153
integer y = 308
integer width = 1015
integer height = 724
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_pism030u_02_save"
boolean vscrollbar = true
boolean resizable = true
end type

event save_data;call super::save_data;Integer I 

For I = 1 To This.RowCount()
	This.SetItem(I, "seq", I) 
Next 

Return f_pism_dwupdate(This, True) 

end event

type cb_prodlist from commandbutton within w_pism015u
integer x = 2862
integer y = 44
integer width = 649
integer height = 80
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생산품번선택"
end type

event clicked;String ls_retValue 

OpenWithParm(w_pism013u, istr_mh) 

ls_retValue = message.StringParm
If ls_retValue = '2' Then // 수정된 자료 존재 
	Parent.TriggerEvent("ue_retrieve") 
End If 
end event

type st_help from statictext within w_pism015u
integer x = 960
integer y = 176
integer width = 1582
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 12632256
string text = "생산품목 [ 갑지 : 26 라인, 을지 : 33 라인 ]"
boolean focusrectangle = false
end type

type st_7 from statictext within w_pism015u
integer x = 878
integer y = 172
integer width = 69
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "※"
boolean focusrectangle = false
end type

