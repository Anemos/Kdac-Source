$PBExportHeader$w_pism030u.srw
$PBExportComments$조별생산품목 유사종류별 그룹화
forward
global type w_pism030u from w_pism_sheet01
end type
type st_2 from statictext within w_pism030u
end type
type dw_routing from u_pism_dw within w_pism030u
end type
type cb_add from commandbutton within w_pism030u
end type
type cb_del from commandbutton within w_pism030u
end type
type dw_wcitemgroup_ctrl from datawindow within w_pism030u
end type
type dw_wcitem from u_pism_dw within w_pism030u
end type
type dw_wcitemgroup_dd from datawindow within w_pism030u
end type
type dw_wcitem_save from u_pism_dw within w_pism030u
end type
type st_vbar from u_pism_splitbar within w_pism030u
end type
type dw_routing_p from datawindow within w_pism030u
end type
type cb_seqreset from commandbutton within w_pism030u
end type
type dw_kdac_routing from datawindow within w_pism030u
end type
type st_3 from statictext within w_pism030u
end type
type uo_workday from u_pism_date_wday within w_pism030u
end type
end forward

global type w_pism030u from w_pism_sheet01
integer width = 4658
integer height = 2416
st_2 st_2
dw_routing dw_routing
cb_add cb_add
cb_del cb_del
dw_wcitemgroup_ctrl dw_wcitemgroup_ctrl
dw_wcitem dw_wcitem
dw_wcitemgroup_dd dw_wcitemgroup_dd
dw_wcitem_save dw_wcitem_save
st_vbar st_vbar
dw_routing_p dw_routing_p
cb_seqreset cb_seqreset
dw_kdac_routing dw_kdac_routing
st_3 st_3
uo_workday uo_workday
end type
global w_pism030u w_pism030u

type variables
Long il_seqChg_tarRow, il_seqChg_sourceRow 
end variables

forward prototypes
public function string wf_getwcitemuseflag (string as_item, string as_line, string as_lineno)
public subroutine wf_butenabled (boolean ab_enabled)
end prototypes

public function string wf_getwcitemuseflag (string as_item, string as_line, string as_lineno);String ls_useFlag 

  SELECT UseFlag INTO :ls_useFlag  
    FROM TMHWCITEM  
   WHERE ( AreaCode = :istr_retrievemh.area ) AND  
         ( DivisionCode = :istr_retrievemh.div ) AND  
         ( WorkCenter = :istr_retrievemh.wc ) AND  
         ( ItemCode = :as_item ) AND  
         ( subLineCode = :as_line ) AND  
         ( subLineNo = :as_lineno ) Using SqlPIS ;
If IsNull(ls_useFlag) or ls_useFlag = '' Then ls_useFlag = '0' 

Return ls_useFlag 
end function

public subroutine wf_butenabled (boolean ab_enabled);Boolean lb_addEnabled, lb_delEnabled

If ab_Enabled Then 
	If dw_routing.RowCount() > 0 Then lb_addEnabled = m_frame.m_action.m_save.Enabled 
	If dw_wcitem.RowCount() > 0 Then lb_delEnabled = m_frame.m_action.m_save.Enabled 
End If 
cb_add.Enabled = lb_addEnabled
cb_del.Enabled = lb_delEnabled 
dw_wcitemgroup_ctrl.Enabled = m_frame.m_action.m_save.Enabled 
end subroutine

on w_pism030u.create
int iCurrent
call super::create
this.st_2=create st_2
this.dw_routing=create dw_routing
this.cb_add=create cb_add
this.cb_del=create cb_del
this.dw_wcitemgroup_ctrl=create dw_wcitemgroup_ctrl
this.dw_wcitem=create dw_wcitem
this.dw_wcitemgroup_dd=create dw_wcitemgroup_dd
this.dw_wcitem_save=create dw_wcitem_save
this.st_vbar=create st_vbar
this.dw_routing_p=create dw_routing_p
this.cb_seqreset=create cb_seqreset
this.dw_kdac_routing=create dw_kdac_routing
this.st_3=create st_3
this.uo_workday=create uo_workday
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.dw_routing
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.cb_del
this.Control[iCurrent+5]=this.dw_wcitemgroup_ctrl
this.Control[iCurrent+6]=this.dw_wcitem
this.Control[iCurrent+7]=this.dw_wcitemgroup_dd
this.Control[iCurrent+8]=this.dw_wcitem_save
this.Control[iCurrent+9]=this.st_vbar
this.Control[iCurrent+10]=this.dw_routing_p
this.Control[iCurrent+11]=this.cb_seqreset
this.Control[iCurrent+12]=this.dw_kdac_routing
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.uo_workday
end on

on w_pism030u.destroy
call super::destroy
destroy(this.st_2)
destroy(this.dw_routing)
destroy(this.cb_add)
destroy(this.cb_del)
destroy(this.dw_wcitemgroup_ctrl)
destroy(this.dw_wcitem)
destroy(this.dw_wcitemgroup_dd)
destroy(this.dw_wcitem_save)
destroy(this.st_vbar)
destroy(this.dw_routing_p)
destroy(this.cb_seqreset)
destroy(this.dw_kdac_routing)
destroy(this.st_3)
destroy(this.uo_workday)
end on

event resize;call super::resize;Long ll_width 

ll_width = newwidth / 2 - ( dw_routing.x + ( cb_add.Width / 2 ) ) 
dw_routing.Width = ll_width 
st_vbar.x = dw_routing.x + dw_routing.Width 

cb_add.x = dw_routing.x + dw_routing.Width + st_vbar.Width 
cb_del.x = cb_add.x 

dw_wcitem.x = cb_add.x + cb_add.Width + st_vbar.Width 
dw_wcitem.Width = newwidth - ( dw_wcitem.x + 10 ) 

dw_routing.Height = newheight - ( dw_routing.y + uo_status.Height + 10 )
dw_wcitem.Height = dw_routing.Height; st_vbar.Height = dw_routing.Height 

dw_wcitemgroup_ctrl.x = dw_wcitem.x 
end event

event ue_retrieve;call super::ue_retrieve;String ls_curr 
If IsNull(lparam) Then lparam = 0 

This.SetRedraw(True)

If lparam <> 1 Then 
	If dw_wcitem_save.ModifiedCount() > 0 Or dw_wcitem_save.deletedCount() > 0 Then 
		If f_pism_MessageBox(Question!, 999, '조내 유사군별 생산모델', f_pism_getwcname(istr_retrieveMH) + "조의 수정된 자료가 있습니다. 저장하시겠습니까?") = 1 Then &
			This.TriggerEvent("ue_save") 
	End If 
End If

f_pism_working_msg(uo_wc.is_uo_workcentername + " 조", "조내 Routing Sheet 및 유사군별 생산모델을 조회중입니다.") 

SetNull(ls_curr); dw_wcitemgroup_ctrl.SetItem(1, "wcitemgroup", ls_curr) 

ls_curr = uo_workday.is_uo_date
//ls_curr = String(f_pisc_get_date_nowtime(), 'YYYY.MM.DD') 
dw_wcitem.SetFilter(""); dw_wcitem.SetTransObject(SqlPIS); dw_wcitem.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, '%', ls_curr) 
dw_wcitem_save.SetTransObject(SqlPIS); dw_wcitem_save.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, ls_curr) 
dw_wcitemgroup_dd.SetTransObject(SqlPIS); dw_wcitemgroup_dd.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc) 
If dw_wcitemgroup_dd.Find("IsNull(wcitemgroup) or wcitemgroup = ''", 1, dw_wcitemgroup_dd.RowCount()) <= 0 Then dw_wcitemgroup_dd.InsertRow(1)

dw_routing.SetTransObject(SqlPIS) 
If dw_routing.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, ls_curr) = 0 And dw_wcitem.RowCount() = 0 Then 
	If IsValid(w_pism_working) Then Close(w_pism_working) 

		f_pism_MessageBox(Information!, 999, "Routing Sheet", uo_wc.is_uo_workcentername + " 조~n~n" + &
												  "의 Routing Data가 존재하지 않습니다.")
End If 

istr_retrievemh = istr_mh 
wf_butenabled(True) 
This.Event ue_retresult(dw_routing.RowCount() + dw_wcitem.RowCount()) 

If IsValid(w_pism_working) Then Close(w_pism_working) 
dw_routing.SetFocus() 
end event

event ue_postopen;call super::ue_postopen;st_vbar.of_register(dw_routing, LEFT); st_vbar.of_register(dw_wcitem, RIGHT)
If cb_wcfilter.Text = '담당조 FILTER 취소' Then wf_autworkcenter(True) 

cb_seqreset.Enabled = m_frame.m_action.m_save.Enabled 
end event

event ue_save;call super::ue_save;dw_wcitem_save.Event save_data()
//This.Event ue_retrieve(0,1)

end event

event close;call super::close;If IsValid(w_pism031u) Then Close(w_pism031u)
end event

event open;call super::open;dw_wcitem_save.Visible = False 
dw_routing_p.Visible = False 
dw_wcitemgroup_dd.Visible = False 

end event

event closequery;call super::closequery;If dw_wcitem_save.ModifiedCount() > 0 Or dw_wcitem_save.DeletedCount() > 0 Then 
	If f_pism_MessageBox(Question!, 999, '조내 유사군별 생산모델', uo_wc.is_uo_workcentername + " 조~n~n" + &
        											 "의 수정된 자료가 있습니다. 저장하시겠습니까?") = 1 Then &
		This.TriggerEvent("ue_save") 
End If 

end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건
String ls_curr 

ls_curr = String(f_pisc_get_date_nowtime(), 'YYYY.MM.DD') 

dw_routing_p.SetTransObject(sqlPIS)
dw_routing_p.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, ls_curr) 

lstr_prt.Transaction = SqlPIS 
lstr_prt.datawindow = dw_routing_p 
lstr_prt.DataObject = "d_pism030u_01_p" 
lstr_prt.dwsyntax = "t_divwc.Text = '" + uo_area.is_uo_areaName + " " + uo_div.is_uo_divisionName + & 
						  " " + uo_wc.is_uo_workcenterName + " 조'	t_prdate.Text = '기준일자 : " + ls_curr + "'" 
lstr_prt.title = idw_focused.Title 

OpenSheetWithParm(w_pism_prt, lstr_prt, w_frame, 0, Layered! )

end event

event clicked;call super::clicked;dw_kdac_routing.visible 	= false
dw_kdac_routing.enabled	 	= false
 
end event

type uo_status from w_pism_sheet01`uo_status within w_pism030u
end type

type uo_wc from w_pism_sheet01`uo_wc within w_pism030u
integer taborder = 120
end type

event uo_wc::ue_select;call super::ue_select;DataWindowChild ldwc 

Parent.TriggerEvent("ue_retrieve") 

dw_wcitemgroup_ctrl.Reset(); 
dw_wcitemgroup_ctrl.SetTransObject(SqlPIS) 
If dw_wcitemgroup_ctrl.GetChild("wcitemgroup", ldwc) <> -1 Then 
	ldwc.SetTransObject(SqlPIS)
	ldwc.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc)
	If ldwc.Find("IsNull(wcitemgroup) or wcitemgroup = ''", 1, ldwc.RowCount()) <= 0 Then ldwc.InsertRow(1) 
End If 
dw_wcitemgroup_ctrl.InsertRow(0) 
If IsValid(w_pism031u) Then Close(w_pism031u)

end event

type uo_area from w_pism_sheet01`uo_area within w_pism030u
integer taborder = 140
end type

type uo_div from w_pism_sheet01`uo_div within w_pism030u
integer taborder = 160
end type

type cb_wcfilter from w_pism_sheet01`cb_wcfilter within w_pism030u
integer x = 2240
integer taborder = 50
end type

type gb_1 from w_pism_sheet01`gb_1 within w_pism030u
integer width = 2203
integer height = 228
end type

type st_2 from statictext within w_pism030u
integer x = 23
integer y = 284
integer width = 645
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "[ Routing Sheet ]"
boolean focusrectangle = false
end type

type dw_routing from u_pism_dw within w_pism030u
integer x = 23
integer y = 380
integer width = 1888
integer height = 1272
integer taborder = 20
boolean bringtotop = true
string title = "Routing Sheet"
string dataobject = "d_pism030u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event doubleclicked;call super::doubleclicked;if row > 0 then
	string ls_itno,ls_plant,ls_div,ls_line1,ls_line2,ls_raitno,ls_wkct,ls_applydate
	ls_plant		=	this.object.areacode[row]
	ls_div		=	this.object.divisioncode[row]
	ls_itno		=	this.object.itemcode[row]
	ls_wkct		=	this.object.workcenter[row]
	ls_line1		=	trim(this.object.sublinecode[row])
	ls_line2 = trim(this.object.sublineno[row])
	ls_applydate = string(date(uo_workday.is_uo_date),"yyyymmdd")

	dw_kdac_routing.reset()
	ls_raitno	=	f_rtn_conv_itno(ls_plant,ls_div,ls_itno,ls_applydate)
	if	ls_raitno	<>	ls_itno	then
		messagebox("확인", trim(ls_itno) + "  품번은 유사 품번입니다. 대표품번 " + trim(ls_raitno) + &
			                   "의 Routing 정보가 조회 됩니다 " )
		ls_itno	=	ls_raitno
	end if
	if dw_kdac_routing.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_line1,ls_line2,ls_wkct,ls_applydate) > 0	then
		dw_kdac_routing.visible = true
		dw_kdac_routing.enabled = true
	else
		messagebox("확인","생산기술 Routing 정보가 없는 품번입니다")
	end if
	
end if
end event

event clicked;call super::clicked;dw_kdac_routing.visible 		= false
dw_kdac_routing.enabled 		= false

end event

type cb_add from commandbutton within w_pism030u
integer x = 1943
integer y = 756
integer width = 151
integer height = 120
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "▶"
end type

event clicked;Integer I 
Long ll_rowCnt, ll_insRow, ll_wcitemselRow[], ll_selRow[], ll_findRow, ll_orginsRow, ll_alltarRow, ll_tarinsRow 
String ls_wcGName, ls_ItemCode, ls_ItemName, ls_ItemSpec, ls_LineCode, ls_LineNo 
Decimal{4} ld_basicTime

ll_rowCnt = f_pism_return_selected(dw_wcitem, ll_wcitemselRow[])
If ll_rowCnt > 0 Then 
	ll_orginsRow = ll_wcitemselRow[UpperBound(ll_wcitemselRow[])] 
	If ll_rowCnt > 1 Then 
		If ll_orginsRow = dw_wcitem.RowCount() Then 
			ll_orginsRow = 0 
		Else
			ll_orginsRow += 1 
		End If 
	End If 
End If 

ls_wcGName = dw_wcitemgroup_ctrl.GetItemString(dw_wcitemgroup_ctrl.Getrow(), "wcitemgroup")
If ls_wcGName = '' Or IsNull(ls_wcGName) Then 
	If dw_wcitem.RowCount() > 0 And ll_orginsRow <= 0 Then 
		ls_wcGName = dw_wcitem.GetItemString(dw_wcitem.RowCount(), "wcitemgroup") 
		If IsNull(ls_wcGName) Or ls_wcGName = '' Then 
			If f_pism_messagebox(Question!, 999, "생산품번추가", "삽입할 위치가 명확하지 않으므로 최하단으로 추가됩니다.~n~n" + & 
																 "계속하시겠습니까?") <> 1 Then Return 
		Else
			If f_pism_messagebox(Question!, 999, "생산품번추가", "삽입할 위치가 명확하지 않으므로 최하단으로 추가됩니다.~n~n" + & 
																 "'" + ls_wcGName + "' 명칭으로 그룹화하시겠습니까?") <> 1 Then Return 
		End If 
		ll_orginsRow = 0
	Else 
		ls_wcGName  = dw_wcitem.GetItemString(ll_orginsRow, "wcitemgroup") 
		If IsNull(ls_wcGName) Or ls_wcGName = '' Then 
			If f_pism_messagebox(Question!, 999, "생산품번추가", "그룹명칭이 지정되지 않았습니다. 계속하시겠습니까?") <> 1 Then Return 
		Else
			If f_pism_messagebox(Question!, 999, "생산품번추가", "'" + ls_wcGName + "' 명칭으로 그룹화하시겠습니까?") <> 1 Then Return 
		End If 
	End If 
End If 

//If IsNull(ls_wcGName) Or ls_wcGName = '' Then 
//	ll_alltarRow = 0
//Else
	ll_tarinsRow = ll_orginsRow 
	If ll_tarinsRow = 0 Then ll_tarinsRow = dw_wcitem.RowCount() 

	If ll_tarinsRow > 0 Then 
		ls_ItemCode = dw_wcitem.GetItemString(ll_tarinsRow, "itemcode")		
		ls_LineCode = dw_wcitem.GetItemString(ll_tarinsRow, "sublinecode")
		ls_LineNo   = dw_wcitem.GetItemString(ll_tarinsRow, "sublineno") 
		
		ll_alltarRow = dw_wcitem_save.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
													  "sublineno = '" + ls_LineNo + "'", 1, dw_wcitem_save.RowCount()) 
		If ll_alltarRow = 0 Then 
			f_pism_MessageBox(StopSign!, -1, "추가 실패", "원본데이터에서 삽입위치의 품번을 찾지 못했습니다.")
			Return 
		Else
			If ll_orginsRow = 0 Then ll_alltarRow += 1 
		End If 
	Else
		ll_alltarRow = dw_wcitem_save.Find("useflag = '3'", 1, dw_wcitem_save.RowCount()) 
		If ll_alltarRow = 0 Then ll_alltarRow = dw_wcitem_save.RowCount() + 1 
	End If 
//End If 

If ll_alltarRow = 0 Then 
	ll_alltarRow = dw_wcitem_save.Find("useflag = '3'", 1, dw_wcitem_save.RowCount()) 
	If ll_alltarRow = 0 Then ll_alltarRow = dw_wcitem_save.RowCount() 
	If ll_alltarRow = 0 Then ll_alltarRow = 1 
End If 

ll_rowCnt = f_pism_return_selected(dw_routing, ll_selRow[])
If ll_rowCnt > 0 Then 
	dw_wcitem.SetRedraw(False)
	dw_wcitem.SelectRow(0, False); dw_routing.SelectRow(0, False)
	ll_insRow = ll_orginsRow 
	For I = ll_rowCnt To 1 Step -1 
		// 유사품번 적용유무 체크 - 2008.11.14
		
		// 체크완료
		ls_ItemCode = dw_routing.GetItemString(ll_selRow[I], "itemcode")		
		ls_ItemName = dw_routing.GetItemString(ll_selRow[I], "itemname")
		ls_ItemSpec = dw_routing.GetItemString(ll_selRow[I], "itemspec")
		ls_LineCode = dw_routing.GetItemString(ll_selRow[I], "sublinecode")
		ls_LineNo   = dw_routing.GetItemString(ll_selRow[I], "sublineno") 
		ld_basicTime = dw_routing.GetItemDecimal(ll_selRow[I], "basictime") 
		
		ll_insRow = dw_wcitem.InsertRow(ll_insRow)
		dw_wcitem.SetItem(ll_insRow, "areacode", istr_retrievemh.area) 
		dw_wcitem.SetItem(ll_insRow, "divisioncode", istr_retrievemh.div) 
		dw_wcitem.SetItem(ll_insRow, "workcenter", istr_retrievemh.wc) 
		
		dw_wcitem.SetItem(ll_insRow, "wcitemgroup", ls_wcGName)
		dw_wcitem.SetItem(ll_insRow, "itemcode", ls_ItemCode)
		dw_wcitem.SetItem(ll_insRow, "itemname", ls_ItemName)
		dw_wcitem.SetItem(ll_insRow, "itemspec", ls_ItemSpec)
		dw_wcitem.SetItem(ll_insRow, "sublinecode", ls_LineCode)
		dw_wcitem.SetItem(ll_insRow, "sublineno", ls_LineNo) 
		dw_wcitem.SetItem(ll_insRow, "seq", 0) 
		dw_wcitem.SetItem(ll_insRow, "basictime", ld_basicTime) 
		
		dw_wcitem.SetItem(ll_insRow, "useflag", wf_getwcItemUseFlag(ls_ItemCode, ls_LineCode, ls_LineNo)) 
		dw_wcitem.SelectRow(ll_insRow, True) 
		
		ll_findRow = dw_wcitem_save.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
													"sublineno = '" + ls_LineNo + "'", 1, dw_wcitem_save.RowCount()) 
		If ll_findRow > 0 Then dw_wcitem_save.DeleteRow(ll_findRow)	

		If dw_wcitem.RowsCopy(ll_insRow, ll_insRow, Primary!, dw_wcitem_save, ll_alltarRow, Primary!) = -1 Then 
			dw_wcitem.DeleteRow(ll_insRow) 
		Else
			dw_wcitem_save.SelectRow(ll_alltarRow, True) 
			dw_wcitem.ScrollToRow(ll_alltarRow) 
			dw_routing.DeleteRow(ll_selRow[I]) 			
		End If 
		
	Next 
//	dw_wcitem.Sort() 
	dw_wcitem.SetRedraw(True)	
	
	wf_butEnabled(True) 
End If

end event

type cb_del from commandbutton within w_pism030u
integer x = 1943
integer y = 876
integer width = 151
integer height = 120
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "◀"
end type

event clicked;Long ll_rowCnt, ll_insRow, ll_selRow[], ll_findRow 
Integer I 
String ls_LineCode, ls_LineNo, ls_ItemCode, ls_ItemName, ls_ItemSpec, &
		 ls_modGruop, ls_modGroupName, ls_prodGroup, ls_prodGroupName 
Decimal{4} ld_basicTime 		 

ll_rowCnt = f_pism_return_selected(dw_wcitem, ll_selRow[])
//ib_modified = True 
If ll_rowCnt > 0 Then 
	
	f_pism_working_msg("유사그룹 취소", "해당 유사그룹의 품번을 취소중입니다.") 
	
	dw_routing.SetRedraw(False); dw_wcitem.SetRedraw(False) 
	dw_wcitem.SelectRow(0, False) 
	For I = ll_rowCnt To 1 Step -1 
		ls_ItemCode = dw_wcitem.GetItemString(ll_selRow[I], "itemcode")
		
		If f_pism_getiteminfo(istr_retrievemh.area, istr_retrievemh.div, ls_ItemCode, ls_ItemName, ls_ItemSpec, &
									 ls_modGruop, ls_modGroupName, ls_prodGroup, ls_prodGroupName) = '' Then Continue 

		ls_LineCode = dw_wcitem.GetItemString(ll_selRow[I], "sublinecode")
		ls_LineNo   = dw_wcitem.GetItemString(ll_selRow[I], "sublineno") 
		ld_basicTime = dw_wcitem.GetItemDecimal(ll_selRow[I], "basictime") 

		ll_insRow = dw_routing.InsertRow(0) 
		dw_routing.SetItem(ll_insRow, "productgroup", ls_prodGroup) 
		dw_routing.SetItem(ll_insRow, "productgroupname", ls_prodGroupName) 
		dw_routing.SetItem(ll_insRow, "itemcode", ls_ItemCode) 
		dw_routing.SetItem(ll_insRow, "itemname", ls_ItemName) 
		dw_routing.SetItem(ll_insRow, "itemspec", ls_ItemSpec) 
		dw_routing.SetItem(ll_insRow, "sublinecode", ls_LineCode) 
		dw_routing.SetItem(ll_insRow, "sublineno", ls_LineNo) 
		dw_routing.SetItem(ll_insRow, "basictime", ld_basicTime) 
		
		dw_routing.SelectRow(ll_insRow, True) 
		
		ll_findRow = dw_wcitem_save.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
													"sublineno = '" + ls_LineNo + "'", 1, dw_wcitem_save.RowCount()) 
		If ll_findRow > 0 Then dw_wcitem_save.DeleteRow(ll_findRow)	
		dw_wcitem.DeleteRow(ll_selRow[I]) 
	Next 
	dw_routing.Sort(); dw_routing.GroupCalc() 
	dw_routing.SetRedraw(True); dw_wcitem.SetRedraw(True)
	
	If IsValid(w_pism_working) Then Close(w_pism_working)

	wf_butEnabled(True) 
End If

end event

type dw_wcitemgroup_ctrl from datawindow within w_pism030u
integer x = 2231
integer y = 236
integer width = 1458
integer height = 116
integer taborder = 130
boolean bringtotop = true
string title = "none"
string dataobject = "d_pism_wcitemgroup_ctrl"
boolean border = false
boolean livescroll = true
end type

event buttonclicked;str_pism_wcgroup lstr_wcGroup 

lstr_wcGroup.dw_wcgroup = dw_wcitemgroup_dd
lstr_wcGroup.dw_wcitem = dw_wcitem_save 

OpenWithParm(w_pism031u, lstr_wcGroup)

DataWindowChild ldwc 
Integer li_Chk, I 
Long ll_findRow, ll_rowCnt 
String ls_inputGroup, ls_orgWCGroup 

ll_rowCnt = dw_wcitemgroup_dd.RowCount() 
For I = 1 To ll_rowCnt 
	ls_inputGroup = dw_wcitemgroup_dd.GetItemString(I, "inputname") 
	ls_orgWCGroup = dw_wcitemgroup_dd.GetItemString(I, "wcitemgroup") 
	If ls_inputGroup <> ls_orgWCGroup Then 
		
		ll_findRow = dw_wcitem_save.Find("wcitemgroup = '" + ls_orgWCGroup + "'", 1, dw_wcitem_save.RowCount()) 
		Do While ll_findRow > 0 
			dw_wcitem_save.SetItem(ll_findRow, "wcitemgroup", ls_inputGroup)
			ll_findRow = dw_wcitem_save.Find("wcitemgroup = '" + ls_orgWCGroup + "'", ll_findRow + 1, dw_wcitem_save.RowCount()) 
		Loop 
	End If 
	dw_wcitemgroup_dd.SetItem(I, "wcitemgroup", ls_inputGroup) 
Next 
If dw_wcitemgroup_ctrl.GetChild("wcitemgroup", ldwc) <> -1 Then dw_wcitemgroup_dd.ShareData(ldwc)
If ll_rowCnt > 0 Then ls_inputGroup = dw_wcitemgroup_dd.GetItemString(1, "wcitemgroup") 
If IsNull(ls_inputGroup) Then ls_inputGroup = '' 
This.Event ItemChanged(This.GetRow(), This.Object.wcitemgroup, ls_inputGroup) 
This.SetItem(This.GetRow(), "wcitemgroup", ls_inputGroup) 
dw_routing.Sort(); dw_routing.GroupCalc() 
wf_butEnabled(True) 

end event

event itemchanged;String ls_filter 
Integer I
Long ll_rowCnt 

dw_wcitem.Reset() 
If IsNull(data) Then data = '' 
ls_filter = "wcitemgroup = '" + data + "' And useflag <> '3'"
If data = '' Then 
	ls_filter = "useflag <> '3'" 
	dw_wcitem.ib_dragdrop = m_frame.m_action.m_save.Enabled 
Else
	dw_wcitem.ib_dragdrop = False 
End If 

ll_rowCnt = dw_wcitem_save.RowCount()
For I = 1 To ll_rowCnt 
	dw_wcitem_save.SetItem(I, "seq", I) 
Next 
dw_wcitem_save.SetFilter(ls_filter) 
dw_wcitem_save.Filter() 
dw_wcitem_save.RowsCopy(1, dw_wcitem_save.RowCount(), Primary!, dw_wcitem, 1, Primary!)
dw_wcitem_save.SetFilter("")
dw_wcitem_save.Filter() 
dw_wcitem.SelectRow(0, False) 

wf_butEnabled(True) 

end event

type dw_wcitem from u_pism_dw within w_pism030u
integer x = 2235
integer y = 380
integer width = 1239
integer height = 1272
integer taborder = 30
string dragicon = "bmp\row.ico"
string title = "조내 유사군별 생산모델"
string dataobject = "d_pism030u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean ib_dragdrop = true
string is_dragicon = "bmp\row.ico"
end type

event dragwithin;call super::dragwithin;This.Modify("dragwithin_row.Expression = '" + String(row) + "'") 
il_seqChg_tarRow = row 
This.SetRedraw(True) 
end event

event dragdrop;call super::dragdrop;Integer li_Chk 
String ls_tarwcGroup, ls_wcGroup, ls_ItemCode, ls_LineCode, ls_LineNo 
Long ll_tarRow, ll_sourcetarRow, ll_findRow, ll_selected[] 
DragObject	ldo_object
DataWindow	ldw_control

If KeyDown(KeyControl!) Or KeyDown(KeyShift!) Then Goto Exit_pr 
If il_seqChg_sourceRow = 0 Then Goto Exit_pr 
If f_pism_return_selected(This, ll_selected[]) > 1 Then Goto Exit_pr 

If il_seqChg_tarRow = 0 or & 
	il_seqChg_tarRow = il_LastClickedRow Then Goto Exit_pr 

ldo_object = DraggedObject()
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
	If ldw_control <> This Then Goto Exit_pr 
Else
	Goto Exit_pr 
End If 		

If il_seqChg_tarRow > il_LastClickedRow Then 
	ll_tarRow = il_seqChg_tarRow - 1
Else
	ll_tarRow = il_seqChg_tarRow 
End If 

ls_wcGroup = This.GetItemString(il_LastClickedRow, "wcitemgroup"); If IsNull(ls_wcGroup) Then ls_wcGroup = '' 
ls_tarwcGroup = This.GetItemString(il_seqChg_tarRow, "wcitemgroup"); If IsNull(ls_tarwcGroup) Then ls_tarwcGroup = '' 
If ls_wcGroup <> ls_tarwcGroup Then 
	ls_ItemCode = This.GetItemString(il_LastClickedRow, "itemCode")
	If f_pism_MessageBox(Question!, 999, "유사군 변경", ls_ItemCode + " 해당 품번의 유사군이 다릅니다. 변경하시겠습니까?") <> 1 Then Goto Exit_pr 
End If 

ls_ItemCode = This.GetItemString(il_seqChg_tarRow, "itemcode")
ls_LineCode = This.GetItemString(il_seqChg_tarRow, "sublinecode")
ls_LineNo   = This.GetItemString(il_seqChg_tarRow, "sublineno") 

ll_sourcetarRow = dw_wcitem_save.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + &
												  "' And sublineno = '" + ls_LineNo + "'", 1, dw_wcitem_save.RowCount() ) 
If ll_sourcetarRow = 0 Then Goto Exit_pr 

li_Chk = This.rowsMove(il_LastClickedRow, il_LastClickedRow, Primary!, This, il_seqChg_tarRow, Primary!) 
If li_Chk = 1 Then 
	If ls_wcGroup <> ls_tarwcGroup Then This.SetItem(ll_tarRow, "wcitemgroup", ls_tarwcGroup) 

	dw_wcitem_save.rowsMove(il_seqChg_sourceRow, il_seqChg_sourceRow, Primary!, dw_wcitem_save, ll_sourcetarRow, Primary!) 
	If il_seqChg_tarRow > il_LastClickedRow Then ll_sourcetarRow = ll_sourcetarRow - 1
	
	If ls_wcGroup <> ls_tarwcGroup Then dw_wcitem_save.SetItem(ll_sourcetarRow, "wcitemgroup", ls_tarwcGroup) 
	dw_wcitem_save.SetItem(ll_sourcetarRow, "seq", 0); dw_wcitem_save.SelectRow(ll_sourcetarRow, True) 
End If 

Exit_pr:
This.Drag (End!); il_seqChg_tarRow = 0
This.Modify("dragwithin_row.Expression = '0'") 
This.SetRedraw(True) 
end event

event ue_lbuttonup;Integer I 
end event

event doubleclicked;if row > 0 then
	string ls_itno,ls_plant,ls_div,ls_line1,ls_line2,ls_raitno,ls_wkct,ls_applydate
	ls_plant		=	this.object.areacode[row]
	ls_div		=	this.object.divisioncode[row]
	ls_itno		=	this.object.itemcode[row]
	ls_wkct		=	this.object.workcenter[row] 
	ls_line1		=	trim(this.object.sublinecode[row])
	ls_line2		=  trim(this.object.sublineno[row])
	ls_applydate = string(date(uo_workday.is_uo_date),"yyyymmdd")
	dw_kdac_routing.reset()
	ls_raitno	=	f_rtn_conv_itno(ls_plant,ls_div,ls_itno,ls_applydate)
	if	ls_raitno	<>	ls_itno	then
		messagebox("확인", trim(ls_itno) + "  품번은 유사 품번입니다. 대표품번 " + trim(ls_raitno) + &
			                   "의 Routing 정보가 조회 됩니다 " )
		ls_itno	=	ls_raitno
	end if
	if	dw_kdac_routing.retrieve(g_s_company,ls_plant,ls_div,ls_itno,ls_line1,ls_line2,ls_wkct,g_s_date) > 0	then
		dw_kdac_routing.visible = true
		dw_kdac_routing.enabled = true
	else
		messagebox("확인","생산기술 Routing 정보가 없는 품번입니다")
	end if	
end if
//STRING		ls_object, ls_header
//INT			li_tab, li_row
//BOOLEAN		lb_sort = False
//
//// 2001.09.20
//// header sort => clicked event에서 이동
//
//IF left(This.GetBandAtPointer(), 6) = 'header' THEN
//	SetPointer(HourGlass!)
//	
//	ls_object = This.GetObjectAtpointer()
//
//	IF Len(ls_object) = 0 THEN Return 	Grid type에서 header사이 누를때 오동작처리
//	
//	li_tab = Pos(ls_object,"_s~t",1)
//	IF li_tab > 0 THEN
//		ls_header = Mid(ls_object,1,(li_tab - 1))
//		lb_sort = True
//	Else
//		li_tab = Pos(ls_object,"_s_f~t",1)
//		IF li_tab > 0 THEN
//			ls_header = Mid(ls_object,1,(li_tab - 1))
//			lb_sort = True
//		End IF
//	End If	
//
//// 2001.09.24
//// _s, _s_f 일 경우에만 sort
//	IF lb_sort = True THEN
//		IF is_sort_ad = ' A' THEN
//			is_sort_ad = ' D'
//		ELSE
//			is_sort_ad = ' A'
//		END IF
//		
//		This.SetRedraw(False)
//		ls_header = ls_header + is_sort_ad
//		This.SetSort(ls_header); This.Sort() 
//		dw_wcitem_save.SetSort(ls_header); dw_wcitem_save.Sort() 
//		
//		This.SetRedraw(True)
//	END IF	
//	SetPointer(Arrow!)
//END IF
end event

event clicked;call super::clicked;dw_kdac_routing.visible 		= false
dw_kdac_routing.enabled 		= false

If row <= 0 Then Return 

String ls_ItemCode, ls_LineCode, ls_LineNo 

ls_ItemCode = This.GetItemString(row, "itemcode")
ls_LineCode = This.GetItemString(row, "sublinecode")
ls_LineNo   = This.GetItemString(row, "sublineno") 

il_seqChg_sourceRow = dw_wcitem_save.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + &
														"' And sublineno = '" + ls_LineNo + "'", 1, dw_wcitem_save.RowCount() )
														
end event

event retrieveend;call super::retrieveend;This.ib_dragdrop = m_frame.m_action.m_save.Enabled 
//integer 		i
//string		ls_itemcode,ls_workcenter,ls_sublinecode,ls_sublineno
//decimal{4}	ln_basictimeold
//
//for i = 1 to rowcount
//	ls_workcenter		=	this.object.workcenter[i]
//	ls_itemcode			=	this.object.itemcode[i]	
//	ls_sublinecode		=	this.object.sublinecode[i]	
//	ls_sublineno		=	this.object.sublineno[i]	
//	select	isnull(basictime,0)	into	:ln_basictimeold	from vroutbasictime_test
//		where itemcode		=	:ls_itemcode		and	workcenter	=	:ls_workcenter	and
//				sublinecode	=	:ls_sublinecode	and	sublineno	=	:ls_sublineno	
//	using	sqlpis ;
//	if	sqlpis.sqlcode	<>	0	then
//		ln_basictimeold	=	0
//	end if
//	this.object.basictimeold[i]	=	ln_basictimeold
//next
//
end event

type dw_wcitemgroup_dd from datawindow within w_pism030u
integer x = 2981
integer y = 512
integer width = 878
integer height = 808
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pism_wcitemgroup_dd"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_wcitem_save from u_pism_dw within w_pism030u
event type integer delete_row ( long al_delrow )
integer x = 667
integer y = 932
integer width = 2647
integer height = 892
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string dataobject = "d_pism030u_02_save"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

event type integer delete_row(long al_delrow);String ls_ItemCode, ls_ItemName, ls_ItemSpec, ls_modGruop, ls_modGroupName, ls_prodGroup, ls_prodGroupName, & 
		 ls_LineCode, ls_LineNo
Long ll_insRow, ll_findRow 
Decimal{4} ld_basicTime 

ls_ItemCode = This.GetItemString(al_delrow, "itemcode")
If IsNull(ls_ItemCode) Then ls_ItemCode = '' 

If ls_ItemCode <> '' Then 
	If f_pism_getiteminfo(istr_retrievemh.area, istr_retrievemh.div, ls_ItemCode, ls_ItemName, ls_ItemSpec, &
								 ls_modGruop, ls_modGroupName, ls_prodGroup, ls_prodGroupName) = '' Then Return 0 
	
	ls_LineCode = This.GetItemString(al_delrow, "sublinecode")
	ls_LineNo   = This.GetItemString(al_delrow, "sublineno") 
	
	ll_insRow = dw_routing.InsertRow(0) 
	dw_routing.SetItem(ll_insRow, "productgroup", ls_prodGroup) 
	dw_routing.SetItem(ll_insRow, "productgroupname", ls_prodGroupName) 
	dw_routing.SetItem(ll_insRow, "itemcode", ls_ItemCode) 
	dw_routing.SetItem(ll_insRow, "itemname", ls_ItemName) 
	dw_routing.SetItem(ll_insRow, "itemspec", ls_ItemSpec) 
	dw_routing.SetItem(ll_insRow, "sublinecode", ls_LineCode) 
	dw_routing.SetItem(ll_insRow, "sublineno", ls_LineNo) 
	
	ld_basicTime = f_pism_getitemroutbasictime(istr_retrievemh, ls_ItemCode, ls_LineCode, ls_LineNo, uo_workday.is_uo_date)
	dw_routing.SetItem(ll_insRow, "basictime", ld_basicTime) 
	
	dw_routing.SelectRow(ll_insRow, True) 
	
	ll_findRow = dw_wcitem.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
												"sublineno = '" + ls_LineNo + "'", 1, dw_wcitem.RowCount()) 
	If ll_findRow > 0 Then dw_wcitem.DeleteRow(ll_findRow)	
End If 
This.DeleteRow(al_delrow) 

Return 1 
end event

event save_data;call super::save_data;Long ll_rowCnt 
Integer I 

ll_rowCnt = This.RowCount() 
For I = 1 To ll_rowCnt 
	This.SetItem(I, "seq", I) 
Next 

Return f_pism_dwupdate(This, True) 

//Long ll_findRow, ll_rowCnt, ll_seq, ll_seqRow, ll_tarRow 
//String ls_ItemCode, ls_LineCode, ls_LineNo, ls_wcGroup, ls_tarwcGroup, ls_oldwcGroup 
//Integer I 
//
//ll_rowCnt = dw_wcitem.RowCount() 
//For I = 1 To ll_rowCnt 
//	ls_ItemCode = dw_wcitem.GetItemString(I, "itemcode") 
//	ls_LineCode = dw_wcitem.GetItemString(I, "sublinecode") 
//	ls_LineNo = dw_wcitem.GetItemString(I, "sublineno") 
//	ls_wcGroup = dw_wcitem.GetItemString(I, "wcitemgroup") 
//	
//	ll_findRow = This.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + "' And " + &
//												"sublineno = '" + ls_LineNo + "'", 1, This.RowCount()) 
//	If ll_findRow > 0 Then 
//		ls_tarwcGroup = This.GeTitemString(ll_findRow, "wcitemgroup") 
//		This.SetItem(ll_findRow, "seq", I) 
//		If ls_wcGroup <> ls_tarwcGroup Then This.SetItem(ll_findRow, "wcitemgroup", ls_tarwcGroup) 
//	End If 
//Next 
//
//For I = 1 To ll_rowCnt 
//	ls_wcGroup = dw_wcitem.GetitemString(I, "wcitemgroup") 
//	If ls_oldwcGroup = ls_wcGroup Then Continue 
//	ll_seq = 0 
//	ll_seqRow = This.Find("wcitemgroup = '" + ls_wcGroup + "' And useflag = '3'", 1, This.RowCount())
//	Do While ll_seqRow > 0 
//		ll_tarRow = I 
//		Do While ll_tarRow < ll_rowCnt 
//			ls_tarwcGroup = dw_wcitem.GetItemString(ll_tarRow + 1, "wcitemgroup") 
//			If ls_tarwcGroup <> ls_wcGroup Then Exit 
//			ll_tarRow++
//		Loop 
//		
//		If ll_seq = 0 Then ll_seq = ll_tarRow 
//		This.SetItem(ll_seqRow, "seq", ll_seq) 
//		If ll_seqRow = This.RowCount() Then Exit 
//		ll_seqRow = This.Find("wcitemgroup = '" + ls_wcGroup + "' And useflag = '3'", ll_seqRow + 1, This.RowCount()) 
//	Loop 
//	ls_oldwcGroup = ls_wcGroup 
//Next 
//
//ll_findRow = This.Find("( IsNull(wcitemgroup) or wcitemgroup = '' ) And useflag = '3'", 1, This.RowCount()) 
//Do While ll_findRow > 0 
//	ll_rowCnt++ 
//	This.SetItem(ll_findRow, "seq", ll_rowCnt) 
//	
//	If ll_findRow = This.RowCount() Then Exit 
//	ll_findRow = This.Find("( IsNull(wcitemgroup) or wcitemgroup = '' ) And useflag = '3'", ll_findRow + 1, This.RowCount()) 
//Loop 

end event

type st_vbar from u_pism_splitbar within w_pism030u
integer x = 1915
integer y = 376
integer width = 18
integer height = 656
boolean bringtotop = true
end type

event lbuttonup;call super::lbuttonup;cb_add.x = dw_routing.x + dw_routing.Width + This.Width 
cb_del.x = cb_add.x 
dw_wcitemgroup_ctrl.x = dw_wcitem.x 
end event

type dw_routing_p from datawindow within w_pism030u
integer x = 3109
integer y = 1336
integer width = 411
integer height = 432
integer taborder = 150
boolean bringtotop = true
string title = "none"
string dataobject = "d_pism030u_01_p"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_seqreset from commandbutton within w_pism030u
integer x = 2894
integer y = 40
integer width = 782
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "유사군별 품목 순번초기화"
end type

event clicked;If f_pism_MessageBox(Question!, 999, "순번초기화", "해당 조의 유사군 내역의 순번을 초기화하시겠습니까?~n~n" + & 
												 "(그룹->품번->라인코드 순)") <> 1 Then Return 

dw_wcitem.SetSort("wcitemgroup , ItemCode , subLineCode , subLineNo "); dw_wcitem.Sort()
dw_wcitem_save.SetSort("seq_wcitemgroup , seq_itemcode , subLineCode , subLineNo "); dw_wcitem_save.Sort() 

dw_wcitem.SetSort("Seq , wcitemgroup , ItemCode , subLineCode , subLineNo ")
dw_wcitem_save.SetSort("Seq , wcitemgroup , ItemCode , subLineCode , subLineNo ") 
end event

type dw_kdac_routing from datawindow within w_pism030u
boolean visible = false
integer x = 329
integer y = 192
integer width = 4169
integer height = 2112
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
boolean titlebar = true
string title = "Routing 정보 (현재)"
string dataobject = "d_pism030u_routing"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
string icon = "C:\KDAC\kdac.ico"
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca) ;

end event

event clicked;if row <= 0 then return
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)
end event

type st_3 from statictext within w_pism030u
integer x = 658
integer y = 284
integer width = 1573
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "새굴림"
long textcolor = 8388736
long backcolor = 12632256
string text = "더블클릭하시면 품번별 Routing 상세정보 조회됩니다"
boolean focusrectangle = false
end type

type uo_workday from u_pism_date_wday within w_pism030u
integer x = 1115
integer y = 144
integer taborder = 30
boolean bringtotop = true
end type

on uo_workday.destroy
call u_pism_date_wday::destroy
end on

event ue_select;call super::ue_select;dw_routing.reset()
dw_wcitem.reset()
end event

