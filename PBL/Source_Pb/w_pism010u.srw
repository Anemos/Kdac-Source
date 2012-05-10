$PBExportHeader$w_pism010u.srw
$PBExportComments$작업일보 작성 및 조회
forward
global type w_pism010u from w_pism_sheet01
end type
type gb_2 from groupbox within w_pism010u
end type
type cb_labtac from commandbutton within w_pism010u
end type
type cb_prodlist from commandbutton within w_pism010u
end type
type st_vbar from u_pism_splitbar within w_pism010u
end type
type st_4 from statictext within w_pism010u
end type
type uo_workday from u_pism_date_wday within w_pism010u
end type
type gb_4 from groupbox within w_pism010u
end type
type dw_g from datawindow within w_pism010u
end type
type dw_f from datawindow within w_pism010u
end type
type dw_u from datawindow within w_pism010u
end type
type dw_z from datawindow within w_pism010u
end type
type dw_supp from datawindow within w_pism010u
end type
type dw_dailystatus from datawindow within w_pism010u
end type
type cb_resttime from commandbutton within w_pism010u
end type
type dw_prod from u_pism_dw within w_pism010u
end type
type cb_dailystatus from commandbutton within w_pism010u
end type
type cb_nodailylist from commandbutton within w_pism010u
end type
type st_dailystatus from statictext within w_pism010u
end type
type st_2 from statictext within w_pism010u
end type
type st_5 from statictext within w_pism010u
end type
type dw_mhdaily_free from datawindow within w_pism010u
end type
type cb_mhcodehelp from commandbutton within w_pism010u
end type
type dw_etcmhdetail from datawindow within w_pism010u
end type
type dw_s from datawindow within w_pism010u
end type
type st_3 from statictext within w_pism010u
end type
end forward

global type w_pism010u from w_pism_sheet01
integer width = 4722
integer height = 2676
string title = "작업일보작성"
long il_obj_above_y = 38748808
long il_obj_above_height = 38750024
long il_obj_split_v_x = 38745672
long il_obj_split_v_width = 24091640
gb_2 gb_2
cb_labtac cb_labtac
cb_prodlist cb_prodlist
st_vbar st_vbar
st_4 st_4
uo_workday uo_workday
gb_4 gb_4
dw_g dw_g
dw_f dw_f
dw_u dw_u
dw_z dw_z
dw_supp dw_supp
dw_dailystatus dw_dailystatus
cb_resttime cb_resttime
dw_prod dw_prod
cb_dailystatus cb_dailystatus
cb_nodailylist cb_nodailylist
st_dailystatus st_dailystatus
st_2 st_2
st_5 st_5
dw_mhdaily_free dw_mhdaily_free
cb_mhcodehelp cb_mhcodehelp
dw_etcmhdetail dw_etcmhdetail
dw_s dw_s
st_3 st_3
end type
global w_pism010u w_pism010u

type variables
DataStore ids_detailmh_save, ids_autoRev 

// 작업일보 확정여부 
String is_dailyStatus 

// 작업일보 작성상태 값 
Constant String MKLABTACOK = '1', MKDAILYOK = '2', MKLABTACNOT = '3', MKDAILYNOT = '4' 

// 작업일보 마감에 필요한 Action 값 
Constant Integer ACT_INSERT = 1, & 
					  ACT_EDIT 	 = 2, & 
					  ACT_DELETE = 3 

Decimal{2} id_autRevRange = 0.5 

end variables

forward prototypes
public function boolean wf_dailyinputchk (integer as_actid)
public function decimal wf_getcalcactmh ()
public function integer wf_savechk (boolean ab_msg)
public function integer wf_setunusemh (long al_row, decimal ad_inputmh)
public subroutine wf_splitinit ()
public function integer wf_selectdaily (str_pism_daily astr_mh)
public subroutine wf_setactinmh (long al_row, string as_column, decimal ad_mh)
public function string wf_getdailystatus ()
public function integer wf_setautorevision (string as_wcgroup, string as_revcolumn, decimal ad_revvalue)
public function integer wf_setactmh ()
public function integer wf_setactmh (long al_row, decimal ad_inputmh)
public function integer wf_saveprodqty (boolean ab_commitopt)
public subroutine wf_prdatawindowretrieve (datawindow prt_adw)
public subroutine wf_dailyinit ()
public function integer wf_setprodgrmh (boolean ab_inschk)
public subroutine wf_workenabled (boolean ab_enabled)
public function integer wf_nodailyview ()
public subroutine wf_mkdailychk (ref str_pism_daily astr_mh)
public function integer wf_setautorevision ()
public subroutine wf_setcalcmh ()
public function integer wf_setsuppmh ()
public function integer wf_setidssubmh (string as_empgbn, string as_mhgbn, string as_mhcode, decimal ad_submh)
public subroutine wf_opendailysub (long al_getrow)
public subroutine wf_opendailysub ()
end prototypes

public function boolean wf_dailyinputchk (integer as_actid);// 작업일보 마감관련 -> 불필요 

String ls_applyDate 

ls_applyDate = f_pisc_get_date_applydate( istr_mh.area, istr_mh.div, f_pisc_get_date_nowtime()) 
Choose Case as_actID
	Case ACT_INSERT 
		If istr_mh.wday <> ls_applyDate Then 
			f_pism_MessageBox(StopSign!, -1, "작업일보 작성실패",  "해당일자 외의 작업일보는 등록할 수 없습니다.") 
			Return False 
		End If 
	Case ACT_EDIT 
		If is_dailystatus = '1' Then Return False 
	Case ACT_DELETE 
		If is_dailystatus = '1' Then Return False 
		
		If istr_mh.wday <> ls_applyDate Then 
			f_pism_MessageBox(StopSign!, -1, "작업일보 삭제실패",  "해당일자 외의 작업일보는 삭제할 수 없습니다.") 
			Return False 
		End If 
End Choose 

Return True 
		
end function

public function decimal wf_getcalcactmh ();Decimal{1} ld_actInMH, ld_calcActMH, ld_unuseMH 

// 계산된 실동공수 
ld_actInMH = dw_mhdaily_free.GetItemNumber(dw_mhdaily_free.RowCount(), "actinmh_s")
If IsNull(ld_actInMH) Then ld_actInMH = 0 
If dw_u.RowCount() > 0 Then ld_unuseMH = dw_u.GetItemNumber(dw_u.RowCount(), "sum_submh") 
If IsNull(ld_unuseMH) Then ld_unuseMH = 0 

ld_calcActMH = ld_actInMH - ld_unuseMH 

Return ld_calcActMH 
end function

public function integer wf_savechk (boolean ab_msg);
If dw_mhdaily_free.ModifiedCount() > 0 Then Goto saveChk_proc
If dw_prod.ModifiedCount() > 0 Then Goto saveChk_proc
//dw_f, dw_u, dw_z, dw_supp 
If dw_dailystatus.ModifiedCount() > 0 Then Goto saveChk_proc 

Return 0

saveChk_proc:

If Not ab_msg Then Return 1 

If f_pism_messagebox(Question!, 999, "저장알림", String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + &
							f_pism_getwcname(istr_retrieveMH) + " 조~n~n작업일보의 저장되지 않은 자료가 있습니다." + &
							"~n~n 저장 하시겠습니까?") = 1 Then 
	Return This.Event ue_save(0,1) 
End If 

Return 0
end function

public function integer wf_setunusemh (long al_row, decimal ad_inputmh);String ls_wcGroup, ls_grBasicSecond, ls_revwcGroup 
Long ll_grBasicSecond, ll_basicSecond
Decimal{1} ld_calcUnuseMH, ld_actMH, ld_exceptInput, ld_grUnuse, ld_revInputMH, ld_revValue 
Integer I
Long ll_rowCnt 

ls_wcGroup = dw_prod.GetItemString(al_row, "wcitemgroup") 
// 유휴공수가 입력되지 않은 품목의 생산수량계 
ls_grBasicSecond = dw_prod.Describe("Evaluate('unuseexcept_pqty'," + String(al_row) + ")"); If ls_grBasicSecond = '!' Then ls_grBasicSecond = '0' 
ll_grBasicSecond = Long(ls_grBasicSecond); If ll_grBasicSecond = 0 Then Return 0 
ll_rowCnt = dw_prod.RowCount() 

// 유휴공수가 입력된 항목의 유휴공수 합을 제외 
ld_exceptInput = Double(dw_prod.Describe("Evaluate('exceptinput_unuse'," + String(al_row) + ")"))
If ld_exceptInput > ad_inputmh Then
	f_pism_MessageBox(StopSign!, -1, "입력오류", "그룹별 합계치가 기존 유휴공수 합계보다 작습니다.")
	Return -1 
End If 

ld_revInputMH = ad_inputmh - ld_exceptInput 

For I = 1 To ll_rowCnt 
	ls_revwcGroup = dw_prod.GetItemString(I, "wcitemgroup"); If IsNull(ls_revwcGroup) Then ls_revwcGroup = '' 
	If ls_revwcGroup <> ls_wcGroup Then Continue 
	If dw_prod.GetItemString(I, "unuse_inputchk") = '1' Then Continue 
	
	ll_basicSecond = dw_prod.GetItemNumber(I, "pqty"); If IsNull(ll_basicSecond) Then ll_basicSecond = 0 
	
	ld_calcUnuseMH = Round(ll_basicSecond / ll_grBasicSecond * ld_revInputMH, 1) 
	dw_prod.SetItem(I, "unusemh", ld_calcUnuseMH)
	wf_setActInMH(I, 'unusemh', ld_calcUnuseMH) 
Next 

ld_grUnuse = Double(dw_prod.Describe("Evaluate('grsum_unuse', " + String(al_row) + ")"))
ld_revValue = ad_inputmh - ld_grUnuse 
If ld_revValue <> 0 Then wf_setAutoRevision(ls_wcGroup, "unusemh", ld_revValue) 

Return 1 
end function

public subroutine wf_splitinit ();Event resize(1, WorkSpaceWidth(), WorkSpaceHeight()) 

st_vbar.of_register(dw_prod, LEFT); st_vbar.of_register(dw_f, RIGHT)
												st_vbar.of_register(dw_u, RIGHT)
												st_vbar.of_register(dw_z, RIGHT)
												st_vbar.of_register(dw_supp, RIGHT)
												st_vbar.of_register(dw_dailystatus, RIGHT)

end subroutine

public function integer wf_selectdaily (str_pism_daily astr_mh);This.SetRedraw(False)

wf_setistrMH(astr_mh) 
uo_workday.uf_set_date(astr_mh.wday) 
istr_mh = astr_mh; wf_mkdailychk(istr_mh) 

If is_dailystatus = '0' Then 				// 조회 - 미확정 
	This.TriggerEvent("ue_retrieve") 
ElseIf is_dailystatus = '1' Then			// 조회 - 확정 
	This.TriggerEvent("ue_retrieve") 
Else												// 작성 - 미작성 
	This.TriggerEvent("ue_insert") 	
End If 

This.SetRedraw(True)
Return 1 
end function

public subroutine wf_setactinmh (long al_row, string as_column, decimal ad_mh);Decimal{1} ld_tarMH 

Choose Case Upper(as_column)
	Case 'UNUSEMH'
		ld_tarMH = dw_prod.GetItemNumber(al_row, "actmh"); If IsNull(ld_tarMH) Then ld_tarMH = 0 
	Case 'ACTMH'
		ld_tarMH = dw_prod.GetItemNumber(al_row, "unusemh"); If IsNull(ld_tarMH) Then ld_tarMH = 0 		
End Choose 

dw_prod.SetItem(al_row, "actinmh", ad_MH + ld_tarMH)

end subroutine

public function string wf_getdailystatus ();Decimal{1} ld_org_ActInMH, ld_input_ActInMH 
String ls_dailyStatus = '0' 

If dw_mhdaily_free.RowCount() > 0 Then ld_org_ActInMH = dw_mhdaily_free.GetItemNumber(dw_mhdaily_free.RowCount(), "actinmh_s")
If dw_prod.RowCount() > 0 Then ld_input_ActInMH = dw_prod.GetItemNumber(dw_prod.RowCount(), "sum_actin") 

If ( ld_org_ActInMH - ld_input_ActInMH ) = 0 Then ls_dailyStatus = '1' 

Return ls_dailyStatus 
end function

public function integer wf_setautorevision (string as_wcgroup, string as_revcolumn, decimal ad_revvalue);String ls_tarColumn, ls_ItemCode, ls_LineCode, ls_LineNo, ls_Message 
Decimal{1} ld_plusValue, ld_revValue, ld_revMH, ld_tarMH 
Long ll_rowCnt, ll_findRow 
Integer li_dQty, li_nQty 

If as_revColumn = 'unusemh' Then ls_tarColumn = "actmh" 
If as_revColumn = 'actmh' Then ls_tarColumn = "unusemh" 

If Not IsValid(ids_autoRev) Then 
	ids_autoRev = Create DataStore
	ids_autoRev.DataObject = dw_prod.DataObject 
	ids_autoRev.SetTransObject(SqlPIS) 
Else
	ids_autoRev.Reset() 
End If 

If dw_prod.RowsCopy(1, dw_prod.RowCount(), Primary!, ids_autoRev, 1, Primary!) = -1 Then goto Exit_pr 

ids_autoRev.SetFilter("wcitemgroup = '" + as_wcgroup + "' And pqty > 0 ")
If ids_autoRev.Filter() = -1 Then 
	Goto Exit_pr 
Else
	Do While True
		ll_rowCnt++
		If ll_rowCnt > ids_autoRev.RowCount() Then Exit 
		If IsNull(ids_autoRev.GetItemNumber(ll_rowCnt, "actmh")) Then ids_autoRev.SetItem(ll_rowCnt, "actmh", 0) 
	Loop 
	ll_rowCnt = 0 	
End If 

ids_autoRev.SetSort("actmh D"); If ids_autoRev.Sort() = -1 Then Goto Exit_pr 

ld_revValue = ad_revValue 

Do While abs(ld_revValue) > 0
	ll_rowCnt++
	If ld_revValue > 0 Then
		ld_plusValue = 0.1 
	Else
		ld_plusValue = -0.1 
	End If 
	
	li_dQty = ids_autoRev.GetItemNumber(ll_rowCnt, "daypqty"); If IsNull(li_dQty) Then li_dQty = 0
	li_nQty = ids_autoRev.GetItemNumber(ll_rowCnt, "nightpqty"); If IsNull(li_nQty) Then li_nQty = 0 
	If li_dQty + li_nQty = 0 Then 
		ls_Message = "생산수량이 입력되지 않았습니다." 
		Goto Exit_pr 
	End If 
	
	If ll_rowCnt > ids_autoRev.RowCount() Then ll_rowCnt = 1 
	ls_ItemCode = ids_autoRev.GetItemString(ll_rowCnt, "itemcode")
	ls_LineCode = ids_autoRev.GetItemString(ll_rowCnt, "sublinecode")
	ls_LineNo   = ids_autoRev.GetItemString(ll_rowCnt, "sublineno")
	ld_revMH		= ids_autoRev.GetItemNumber(ll_rowCnt, as_revColumn) 
	If IsNull(ld_revMH) Then ld_revMH = 0 
	
	ll_findRow = dw_prod.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + &
									  "' And sublineno = '" + ls_LineNo + "'", 1, dw_prod.RowCount())
	If ll_findRow > 0 Then 
		ld_revMH += ld_plusValue
		dw_prod.SetItem(ll_findRow, as_revColumn, ld_revMH)
		ld_tarMH = dw_prod.GetItemNumber(ll_findRow, ls_tarColumn); If IsNull(ld_tarMH) Then ld_tarMH = 0 
		dw_prod.SetItem(ll_findRow, "actinMH", ld_revMH + ld_tarMH)
	End If 
	
	ld_revValue = ld_revValue - ld_plusValue 
Loop 

Return 1 

Exit_pr:
If ls_Message <> '' Then ls_Message += '~n' 
f_pism_MessageBox(StopSign!, -1, "자동보정실패", "입력값에 대한 자동보정에 실패했습니다.")

Return -1 
end function

public function integer wf_setactmh ();Long ll_rowCnt, ll_basicSecond, ll_s_basicSecond 
Decimal{1} ld_revInputMH, ld_calcActMH, ld_s_exceptInput 
Integer I 

ll_rowCnt = dw_prod.RowCount() 

// 실동공수가 입력되지 않은 품목의 표준생산공수(초단위)계 
ll_s_basicSecond = dw_prod.GetItemNumber(ll_rowCnt, "s_actexcept_basicsecond") 
If IsNull(ll_s_basicSecond) Then ll_s_basicSecond = 0; If ll_s_basicSecond = 0 Then Return 0 

// 실동공수가 입력된 항목의 실동공수 합 
ld_s_exceptInput = dw_prod.GetItemNumber(ll_rowCnt, "s_exceptinput_act") 
ld_calcActMH = wf_getcalcActMH() 
If IsNull(ld_s_exceptInput) Then ld_s_exceptInput = 0 
If ld_s_exceptInput > ld_calcActMH Then
	f_pism_MessageBox(StopSign!, -1, "입력오류", "계산된 실동공수(실투입공수-유휴공수) 합계치가 기존 실동공수 합계보다 작습니다.")
	Return -1 
End If 

// 실동공수가 입력된 항목의 실동공수 합을 제외 
ld_revInputMH = ld_calcActMH - ld_s_exceptInput 

For I = 1 To ll_rowCnt 
	If dw_prod.GetItemString(I, "act_inputchk") = '1' Then Continue 
	
	ll_basicSecond = dw_prod.GetItemNumber(I, "basicsecond"); If IsNull(ll_basicSecond) Then ll_basicSecond = 0 
	
	ld_calcActMH = ll_basicSecond / ll_s_basicSecond * ld_revInputMH 
	
	dw_prod.SetItem(I, "actmh", ld_calcActMH)
	wf_setActInMH(I, 'actmh', ld_calcActMH) 
Next 

Return 1 

end function

public function integer wf_setactmh (long al_row, decimal ad_inputmh);String ls_wcGroup, ls_grbasicSecond, ls_revwcGroup 
Decimal{1} ld_calcActMH, ld_grAct, ld_exceptInput, ld_revInputMH, ld_revValue
Integer I
Long ll_grbasicSecond, ll_basicSecond, ll_rowCnt 

ls_wcGroup = dw_prod.GetItemString(al_row, "wcitemgroup") 
// 실동공수가 입력되지 않은 품목의 생산수량계 
ls_grbasicSecond = dw_prod.Describe("Evaluate('actexcept_basicsecond'," + String(al_row) + ")"); If ls_grbasicSecond = '!' Then ls_grbasicSecond = '0' 
ll_grbasicSecond = Long(ls_grbasicSecond); If ll_grbasicSecond = 0 Then Return 0 
ll_rowCnt = dw_prod.RowCount() 

// 실동공수가 입력된 항목의 실동공수 합을 제외 
ld_exceptInput = Double(dw_prod.Describe("Evaluate('exceptinput_act'," + String(al_row) + ")"))
If ld_exceptInput > ad_inputmh Then
	f_pism_MessageBox(StopSign!, -1, "입력오류", "그룹별 합계치가 기존 실동공수 합계보다 작습니다.")
	Return -1 
End If 

ld_revInputMH = ad_inputmh - ld_exceptInput 

For I = 1 To ll_rowCnt 
	ls_revwcGroup = dw_prod.GetItemString(I, "wcitemgroup"); If IsNull(ls_revwcGroup) Then ls_revwcGroup = '' 
	If ls_revwcGroup <> ls_wcGroup Then Continue 
	If dw_prod.GetItemString(I, "act_inputchk") = '1' Then Continue 
	
	ll_basicSecond = dw_prod.GetItemNumber(I, "basicsecond"); If IsNull(ll_basicSecond) Then ll_basicSecond = 0 
	
	ld_calcActMH = ll_basicSecond / ll_grbasicSecond * ld_revInputMH 
	
	dw_prod.SetItem(I, "actmh", ld_calcActMH)
	wf_setActInMH(I, 'actmh', ld_calcActMH) 
Next 

ld_grAct = Double(dw_prod.Describe("Evaluate('grsum_act', " + String(al_row) + ")"))
ld_revValue = ad_inputmh - ld_grAct 
If ld_revValue <> 0 Then wf_setAutoRevision(ls_wcGroup, "actmh", ld_revValue) 

Return 1 

end function

public function integer wf_saveprodqty (boolean ab_commitopt);Long ll_findRow 

ll_findRow = dw_prod.Find("IsNull(workday)", 1, dw_prod.RowCount()) 
Do While ll_findRow > 0 
	dw_prod.setitemstatus(ll_findRow,0,Primary!,NotModified!)
	ll_findRow = dw_prod.Find("IsNull(workday)", ll_findRow + 1, dw_prod.RowCount()) 
	If ll_findRow > dw_prod.RowCount() Then Exit 
Loop 

Return f_pism_dwupdate(dw_prod, ab_commitopt) 
end function

public subroutine wf_prdatawindowretrieve (datawindow prt_adw);prt_adw.SetTransObject(SqlPIS)
prt_adw.retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday) 
end subroutine

public subroutine wf_dailyinit ();
dw_mhdaily_free.Reset() 
If Not IsValid(ids_detailmh_save) Then
	ids_detailmh_save = Create DataStore 
	ids_detailmh_save.DataObject = 'd_pism010u_02'
End If 
ids_detailmh_save.Reset() 

dw_s.DataObject = f_pism_getDataObject_detailmh(dw_s.Tag)
dw_g.DataObject = f_pism_getDataObject_detailmh(dw_g.Tag)

dw_s.Reset(); dw_g.Reset(); 
dw_prod.Reset()
dw_f.Reset(); dw_u.Reset(); dw_z.Reset(); dw_supp.Reset(); dw_dailystatus.Reset() 

dw_mhdaily_free.SetTransObject(SqlPIS) 
dw_s.SetTransObject(SqlPIS); dw_g.SetTransObject(SqlPIS)

dw_prod.SetTransObject(SqlPIS); dw_f.SetTransObject(SqlPIS)
dw_u.SetTransObject(SqlPIS); dw_z.SetTransObject(SqlPIS)

dw_prod.Modify("gr_dayqty.Width = 0") 
dw_prod.Modify("gr_nightqty.Width = 0") 
dw_prod.Modify("pqty.Width = 0") 
dw_prod.Modify("gr_row.Width = 0")
dw_prod.Modify("grsum_pqty.Width = 0")
dw_prod.Modify("unuseexcept_pqty.Width = 0")
dw_prod.Modify("grsum_unuse.Width = 0")
dw_prod.Modify("exceptinput_unuse.Width = 0")
dw_prod.Modify("actexcept_basicsecond.Width = 0")
dw_prod.Modify("grsum_act.Width = 0")
dw_prod.Modify("exceptinput_act.Width = 0")
dw_prod.Modify("basictime.Width = 0") 
dw_prod.Modify("basicsecond.Width = 0") 
dw_prod.Modify("basicmh.Width = 0") 
dw_prod.Modify("calc_basicmh.Width = 0") 

dw_f.Modify("b_submh.Text = '부가작업 공수발생내역'") 
dw_u.Modify("b_submh.Text = '유휴 공수발생내역'") 
dw_z.Modify("b_submh.Text = '능률저하 공수발생내역'") 

dw_supp.SetTransObject(SqlPIS)  
dw_dailystatus.SetTransObject(SqlPIS); dw_dailystatus.InsertRow(0) 
ids_detailmh_save.SetTransObject(SqlPIS) 

dw_etcmhdetail.Reset(); dw_etcmhdetail.SetTransObject(SqlPIS) 

uo_status.st_message.Text = '' 

wf_workEnabled(False) 
end subroutine

public function integer wf_setprodgrmh (boolean ab_inschk);Long ll_Gr_Row = 1, ll_Next_Gr_Row, ll_insrow, ll_rowCnt 
String ls_wcGroup 
Integer li_Cnt, li_insCnt 
Decimal{1} ld_grMH 

//dw_prod.SetRedraw(False)

ll_rowCnt = dw_prod.RowCount() 
Do While ll_Gr_Row <> 0
	li_Cnt++
	
	ll_Next_Gr_Row = dw_prod.FindGroupChange(ll_Gr_Row + 1, 1)
	If ll_Next_Gr_Row = 0 Then 
		ls_wcGroup = dw_prod.GetItemString(dw_prod.RowCount(), "wcitemgroup") 
		If IsNull(ls_wcGroup) Then Exit 
		If ab_insChk Then 
			ll_insrow = dw_prod.InsertRow(0) 
			li_insCnt++ 
			dw_prod.SetItem(ll_insrow, "wcitemgroup", ls_wcGroup)	
		Else
			ll_insrow = ll_rowCnt 
		End If 
		dw_prod.GroupCalc() 
		
		ld_grMH = Double(dw_prod.Describe("Evaluate('grsum_unuse', " + String(ll_insrow) + ")"))
		dw_prod.SetItem(ll_insrow, "unusemh", ld_grMH); dw_prod.SetItem(ll_insrow, "unuse_inputchk", '1')
		
		ld_grMH = Double(dw_prod.Describe("Evaluate('grsum_act', " + String(ll_insrow) + ")"))
		dw_prod.SetItem(ll_insrow, "actmh", ld_grMH); dw_prod.SetItem(ll_insrow, "act_inputchk", '1')

		dw_prod.SetItemStatus(ll_insrow, 0, Primary!, NotModified!)
		
		Exit 
	End If 
	If ab_insChk Then 
		ls_wcGroup = dw_prod.GetItemString(ll_Next_Gr_Row - 1, "wcitemgroup") 
		If IsNull(ls_wcGroup) Then Goto proc_Next
		ll_insrow = dw_prod.InsertRow(ll_Next_Gr_Row) 
		li_insCnt++ 
		dw_prod.SetItem(ll_insrow, "wcitemgroup", ls_wcGroup); dw_prod.GroupCalc() 
	Else
		ll_insrow = ll_Next_Gr_Row - 1 
		ls_wcGroup = dw_prod.GetItemString(ll_insrow, "wcitemgroup") 
		If IsNull(ls_wcGroup) Then Goto proc_Next
	End If 
	
	ld_grMH = Double(dw_prod.Describe("Evaluate('grsum_unuse', " + String(ll_insrow) + ")"))
	dw_prod.SetItem(ll_insrow, "unusemh", ld_grMH); dw_prod.SetItem(ll_insrow, "unuse_inputchk", '1')
	
	ld_grMH = Double(dw_prod.Describe("Evaluate('grsum_act', " + String(ll_insrow) + ")"))
	dw_prod.SetItem(ll_insrow, "actmh", ld_grMH); dw_prod.SetItem(ll_insrow, "act_inputchk", '1')
	
	dw_prod.SetItemStatus(ll_insrow, 0, Primary!, NotModified!)
	
	ll_Next_Gr_Row += 1 
	proc_Next:
	
	If ( ll_rowCnt + li_insCnt ) < ll_Next_Gr_Row Then Exit 
	
	ll_Gr_Row = ll_Next_Gr_Row 
Loop

//dw_prod.SetItemStatus(0, 0, Primary!, NotModified!)
dw_prod.uf_setHSplitScroll(dw_prod.Tag) 

Return 1 
end function

public subroutine wf_workenabled (boolean ab_enabled);Boolean lb_Enabled 

dw_mhdaily_free.Enabled = ab_enabled 
dw_s.Enabled = ab_enabled 
dw_g.Enabled = ab_enabled 
dw_prod.Enabled = ab_enabled 
If ab_enabled Then lb_Enabled = m_frame.m_action.m_save.Enabled  
dw_f.Enabled = ab_Enabled
dw_u.Enabled = ab_Enabled
dw_z.Enabled = ab_Enabled
dw_supp.Enabled = ab_enabled 
dw_dailystatus.Enabled = lb_Enabled
cb_dailystatus.Enabled = lb_Enabled
cb_resttime.Enabled = ab_enabled 

//cb_labtac.Enabled = ab_enabled 
//cb_prodlist.Enabled = ab_enabled 
end subroutine

public function integer wf_nodailyview ();String ls_stMonth 
Integer li_Cnt1, li_Cnt2, li_Cnt3 
str_pism_daily lstr_daily 

setpointer(hourglass!)
ls_stMonth = Left(istr_mh.wday, 7) 

  SELECT Count(A.WorkDay) Into :li_Cnt1 
    FROM TMHDAILYSTATUS A
   WHERE ( A.AreaCode = :istr_mh.area ) AND  
         ( A.DivisionCode = :istr_mh.div ) AND  
	      ( A.WorkCenter = :istr_mh.wc ) And 
	      ( A.DailyStatus = '0' ) Using SqlPIS ;
//       ( substring(A.WorkDay,1,7) = :ls_stMonth ) Using SqlPIS ;

   SELECT Count( distinct A.DGDAY ) Into :li_Cnt2 
     FROM TMHLABTAC A, TMSTWORKCENTER B 
    WHERE ( B.AreaCode = :istr_mh.area ) And 
		    ( B.DivisionCode = :istr_mh.div ) And 
		    ( B.WorkCenter = A.DGDEPTE ) And 
		    ( A.DGDEPTE = :istr_mh.wc ) AND 
		    ( A.DGDAY In ( SELECT ApplyDate FROM TCALENDARSHOP 
								  WHERE ( AreaCode = :istr_mh.area ) AND  
										  ( DivisionCode = :istr_mh.div ) AND 
										  ( WorkGubun = 'W' ) ) ) And 
		    ( ( SELECT Count(dgempno) FROM TMHLABTAC  
				   WHERE ( DGDAY = A.DGDAY ) AND ( DGDEPTE = A.DGDEPTE ) AND 
						   ( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) > 0 ) ) = 0 ) And 
			 ( IsNull(A.DGCD2R,'') + IsNull(A.DGCD3R,'') in ( '', '21' ) ) And 
			 ( IsNull(A.excFlag,'') = '' ) And 
			 ( IsNull(A.DGTIMER, 0) > 0 ) And 
			 ( IsNull(B.WorkCenterGubun1,'') = 'K' ) And 
			 ( IsNull(B.WorkCenterGubun2,'') <> '' ) And 
Not Exists ( Select WorkDay From TMHDAILYSTATUS 
				  Where ( AreaCode = :istr_mh.area ) And 
						  ( DivisionCode = :istr_mh.div ) And 
						  ( WorkCenter = A.DGDEPTE ) And 
						  ( WorkDay = A.DGDAY ) ) Using SqlPIS ; 
	
   SELECT Count( distinct A.DGDAY ) Into :li_Cnt3 
     FROM TMHLABTAC A, TMSTWORKCENTER B 
    WHERE ( B.AreaCode = :istr_mh.area ) And 
		    ( B.DivisionCode = :istr_mh.div ) And 
		    ( B.WorkCenter = A.DGDEPTE ) And 
		    ( A.DGDEPTE = :istr_mh.wc ) AND 
		    ( ( SELECT Count(dgempno) FROM TMHLABTAC  
				   WHERE ( DGDAY = A.DGDAY ) AND ( DGDEPTE = A.DGDEPTE ) AND 
						   ( ( IsNull(dgjuhur, 0) + IsNull(dghumur, 0) ) > 0 ) And ( IsNull(excFlag,'') = '' ) And 
							( IsNull(DGCD2R,'') + IsNull(DGCD3R,'') in ( '', '21' ) ) ) > 0 ) And  
		    ( IsNull(B.WorkCenterGubun1,'') = 'K' ) And 
		    ( IsNull(B.WorkCenterGubun2,'') <> '' ) And 
	Not Exists ( Select WorkDay From TMHDAILYSTATUS 
					 Where ( AreaCode = :istr_mh.area ) And 
							 ( DivisionCode = :istr_mh.div ) And 
							 ( WorkCenter = A.DGDEPTE ) And 
							 ( WorkDay = A.DGDAY ) ) Using SqlPIS ; 

If li_Cnt1 + li_Cnt2 + li_Cnt3 = 0 Then Return 0 

OpenWithParm(w_pism019i, istr_mh) 

lstr_daily = message.PowerObjectParm 
If IsValid(lstr_daily) Then 
	uo_workday.uf_set_date(lstr_daily.wday) 
	istr_mh = lstr_daily; wf_mkdailychk(istr_mh) 
	If lstr_daily.longparm = 1 Then 			// 작성 
		This.TriggerEvent("ue_insert") 
	ElseIf lstr_daily.longparm = 2 Then 	// 수정 
		This.TriggerEvent("ue_retrieve") 
	End If 
End If 

Return 1 
end function

public subroutine wf_mkdailychk (ref str_pism_daily astr_mh);Integer li_dailyChk
Boolean lb_insChk 
String ls_dailyStatus  

ls_dailyStatus = '' 

// 작업일보 작성 Chk 	
  SELECT count(*) INTO :li_dailyChk  
    FROM TMHDAILY  
   WHERE ( AreaCode = :astr_mh.area ) AND  
         ( DivisionCode = :astr_mh.div ) AND  
         ( WorkCenter = :astr_mh.wc ) AND  
         ( WorkDay = :astr_mh.wday ) Using SqlPIS ; 
If li_dailyChk > 0 Then 
	ls_dailyStatus = MKDAILYOK 
	lb_insChk = True 
Else
	// 근태내역 작성 Chk ( 근무시각이 입력된 사원이 있으면 근태가 작성된 것으로 봄 )
	If f_pism_check_labtac(astr_mh.wday,astr_mh.wc) > 0 Then 
		ls_dailyStatus = MKLABTACOK 	
	Else
	//	ls_dailyStatus = MKLABTACNOT 
	End If 
End If

astr_mh.dailyStatus = ls_dailyStatus

// 작업일보 확정여부 
is_dailystatus = f_pism_getdailystatus(astr_mh.area, astr_mh.div, astr_mh.wc, astr_mh.wday) 
If is_dailystatus = '1' Then 
	st_dailystatus.Text = '확정'
	cb_dailystatus.Text = '작업일보확정취소'
	
	cb_dailystatus.Enabled = m_frame.m_action.m_save.Enabled 
ElseIf is_dailystatus = '0' Then 
	st_dailystatus.Text = '미확정'
	cb_dailystatus.Text = '작업일보확정' 
	cb_dailystatus.Enabled = m_frame.m_action.m_save.Enabled 
Else
	st_dailystatus.Text = '미작성' 
	cb_dailystatus.Text = '작업일보확정'
	cb_dailystatus.Enabled = False 
End If 

astr_mh.workGbn = f_pism_getdayworkgbn( astr_mh.area, astr_mh.div, astr_mh.wc, astr_mh.wDay ) 
end subroutine

public function integer wf_setautorevision ();Long ll_orgChk_Row, ll_rowCnt, ll_findRow 
Decimal{1} ld_org_ActInMH, ld_org_bugaMH, ld_org_unuseMH, &
			  ld_input_ActInMH, ld_input_bugaMH, ld_input_unuseMH, ld_autoRevMH, & 
			  ld_revActInMH, ld_revBugaMH, ld_revUnuseMH, ld_plusValue, ld_revMH, ld_tarMH 
Integer li_dQty, li_nQty			  
String ls_Message, ls_ItemCode, ls_lineCode, ls_LineNo 

ll_orgChk_Row  = dw_mhdaily_free.RowCount() 
ld_org_ActInMH = dw_mhdaily_free.GetItemNumber(ll_orgChk_Row, "actinmh_s")
ld_org_bugaMH  = dw_mhdaily_free.GetItemNumber(ll_orgChk_Row, "bugamh_s") 
If dw_u.RowCount() > 0 Then 		ld_org_unuseMH = dw_u.GetItemNumber(dw_u.RowCount(), "sum_submh") 

If dw_prod.RowCount() > 0 Then ld_input_ActInMH = dw_prod.GetItemNumber(dw_prod.RowCount(), "sum_actin") 
If dw_f.RowCount() > 0 Then 	 ld_input_bugaMH  = dw_f.GetItemNumber(dw_f.RowCount(), "sum_submh") 
If dw_prod.RowCount() > 0 Then ld_input_unuseMH = dw_prod.GetItemNumber(dw_prod.RowCount(), "sum_unuse") 

// 실투입공수 Chk ( id_autRevRange % 이내면 자동보정 ) 
ld_revActInMH = ld_org_ActInMH - ld_input_ActInMH 
If ld_revActInMH = 0 Or abs(ld_revActInMH) > ( ld_org_ActInMH * ( id_autRevRange / 100 ) ) Then Goto ErrorChk_proc
ld_autoRevMH = ld_revActInMH 

If Not IsValid(ids_autoRev) Then 
	ids_autoRev = Create DataStore
	ids_autoRev.DataObject = dw_prod.DataObject 
	ids_autoRev.SetTransObject(SqlPIS) 
Else
	ids_autoRev.Reset() 
End If 

If dw_prod.RowsCopy(1, dw_prod.RowCount(), Primary!, ids_autoRev, 1, Primary!) = -1 Then 
	ls_Message = "실투입공수 자동보정 실패 : 보정용 DataStore Copy 실패" 
	goto ErrorChk_proc 
End If 

ids_autoRev.SetFilter("pqty > 0 ")
If ids_autoRev.Filter() = -1 Then 
	ls_Message = "실투입공수 자동보정 실패 : 보정용 DataStore Filter 실패" 
	Goto ErrorChk_proc 
Else
	Do While True
		ll_rowCnt++
		If ll_rowCnt > ids_autoRev.RowCount() Then Exit 
		If IsNull(ids_autoRev.GetItemNumber(ll_rowCnt, "actmh")) Then ids_autoRev.SetItem(ll_rowCnt, "actmh", 0) 
	Loop 
	ll_rowCnt = 0 
End If 

ids_autoRev.SetSort("actmh D"); ids_autoRev.Sort() 

Do While abs(ld_revActInMH) > 0
	ll_rowCnt++
	If ld_revActInMH > 0 Then
		ld_plusValue = 0.1 
	Else
		ld_plusValue = -0.1 
	End If 
	
	li_dQty = ids_autoRev.GetItemNumber(ll_rowCnt, "daypqty"); If IsNull(li_dQty) Then li_dQty = 0
	li_nQty = ids_autoRev.GetItemNumber(ll_rowCnt, "nightpqty"); If IsNull(li_nQty) Then li_nQty = 0 
	If li_dQty + li_nQty = 0 Then 
		ls_Message = "실투입공수 자동보정 실패 : 생산수량이 입력되지 않았습니다." 
		Goto ErrorChk_proc 
	End If 
	
	If ll_rowCnt > ids_autoRev.RowCount() Then ll_rowCnt = 1 
	ls_ItemCode = ids_autoRev.GetItemString(ll_rowCnt, "itemcode")
	ls_LineCode = ids_autoRev.GetItemString(ll_rowCnt, "sublinecode")
	ls_LineNo   = ids_autoRev.GetItemString(ll_rowCnt, "sublineno")
	ld_revMH		= ids_autoRev.GetItemNumber(ll_rowCnt, "actmh") 
	If IsNull(ld_revMH) Then ld_revMH = 0 
	
	ll_findRow = dw_prod.Find("itemcode = '" + ls_ItemCode + "' And sublinecode = '" + ls_LineCode + &
									  "' And sublineno = '" + ls_LineNo + "'", 1, dw_prod.RowCount())
	If ll_findRow > 0 Then 
		ld_revMH += ld_plusValue
		ids_autoRev.SetItem(ll_rowCnt, "actmh", ld_revMH) 
		dw_prod.SetItem(ll_findRow, "actmh", ld_revMH)
		
		ld_tarMH = dw_prod.GetItemNumber(ll_findRow, "unusemh"); If IsNull(ld_tarMH) Then ld_tarMH = 0 
		dw_prod.SetItem(ll_findRow, "actinMH", ld_revMH + ld_tarMH)		
	End If 
	
	ld_revActInMH -= ld_plusValue 
Loop 

wf_setprodgrmh(False) 

ErrorChk_proc: 
// 실투입공수 Chk 

If abs(ld_revActInMH) > 0 Then ls_Message +=     "실 투입 공수 오차발생 : " + String(ld_revActInMH) 

// 부가작업공수 Chk 
ld_revBugaMH  = ld_org_bugaMH - ld_input_bugaMH 
If abs(ld_revBugaMH) > 0 Then  
	If abs(ld_autoRevMH) > 0 Then  &
	ls_Message =      "실투입 공수 자동 보정 : " + String(id_autRevRange, "#0.0#") + "% 이내 오차발생분(" + String(ld_autoRevMH, "0.0") + ")" 
	ls_Message += "~n~n부가작업공수 오차발생 : " + String(ld_revBugaMH) 
End If 
// 유휴작업공수 Chk 
ld_revUnuseMH = ld_org_unuseMH - ld_input_unuseMH 
If abs(ld_revUnuseMH) > 0 Then 
	If ls_Message = '' And abs(ld_autoRevMH) > 0 Then & 
	ls_Message =      "실투입 공수 자동 보정 : " + String(id_autRevRange, "#0.0#") + "% 이내 오차발생분(" + String(ld_autoRevMH, "0.0") + ")" 
	ls_Message += "~n~n유휴작업공수 오차발생 : " + String(ld_revUnuseMH) 
End If 
If ls_Message <> '' Then 
	f_pism_MessageBox(Information!, -1, "작업일보확정 실패", ls_Message)
	Return 0 
End If 

If abs(ld_autoRevMH) > 0 Then &
	f_pism_MessageBox(Information!, 1, "실투입공수 자동보정", String(id_autRevRange, "#0.0#") + "% 이내 오차발생분(" + String(ld_autoRevMH, "0.0") + ")을 자동보정하였습니다.")

Return 1 

end function

public subroutine wf_setcalcmh ();Integer I 
Decimal{1} ld_totMH, ld_calctotMH, ld_totInMH, ld_actInMH, ld_calcTotInMH, ld_calcActInMH 

For I = 1 To 2 
	ld_calctotMH = dw_mhdaily_free.GetItemNumber(I, "calc_totmh") 
	ld_calctotInMH = dw_mhdaily_free.GetItemNumber(I, "calc_totinmh")
	ld_totMH = dw_mhdaily_free.GetItemNumber(I, "totmh"); If IsNull(ld_totMH) Then ld_totMH = 0 
	If ld_totMH <> ld_calctotMH Then dw_mhdaily_free.SetItem(I, "totmh", ld_calctotMH)
	
	ld_totInMH = dw_mhdaily_free.GetItemNumber(I, "totinmh"); If IsNull(ld_totInMH) Then ld_totInMH = 0 
	If ld_totInMH <> ld_calctotInMH Then dw_mhdaily_free.SetItem(I, "totinmh", ld_calctotInMH)
	ld_calcactInMH = dw_mhdaily_free.GetItemNumber(I, "calc_actinmh")
	ld_actInMH = dw_mhdaily_free.GetItemNumber(I, "actinmh"); If IsNull(ld_actInMH) Then ld_actInMH = 0 
	If ld_actInMH <> ld_calcactInMH Then dw_mhdaily_free.SetItem(I, "actinmh", ld_calcactInMH)
Next 	
end subroutine

public function integer wf_setsuppmh ();Long ll_rowCnt, ll_setrow 
String ls_empGbn, ls_supGbn, ls_pTarget, ls_mTarget 
Decimal{1} ld_supMH, ld_etcsupMH, ld_orgMH, ld_pSupMH[], ld_mSupMH[], ld_pEtcSupMH[], ld_mEtcSupMH[], &
			  ld_nRestTime, ld_eRestTime, ld_totInMH, ld_psuppmh_s, ld_A0MH, ld_A1MH, ld_A2MH, ld_pSupMH_s[] 
Integer I, li_nRestTime, li_eRestTime 

dw_supp.SetRedraw(False)
dw_supp.TriggerEvent("ue_retrieve") 
dw_supp.SetRedraw(True)

ld_pSupMH[1] = 0; ld_pSupMH[2] = 0; ld_mSupMH[1] = 0; ld_mSupMH[2] = 0 

ll_rowCnt = dw_supp.RowCount() 

For I = 1 To ll_rowCnt 
	ls_empGbn = dw_supp.GetItemString(I, "empgbn")
	ls_supGbn = dw_supp.GetItemString(I, "suppgubun")
	
	ld_supMH  = dw_supp.GetItemNumber(I, "supmh") 
	ld_etcsupMH  = dw_supp.GetItemNumber(I, "etcsupmh") 
	If ls_empGbn <> '2' Then 		 		// 정규 
		If ls_supGbn = '+' Then     		// 받음 
			ld_pSupMH[1] += ld_supMH  		// 정시
			ld_pEtcSupMH[1] += ld_etcsupMH // 정시외 
		ElseIf ls_supGbn = '-' Then 		// 해줌 
			ld_mSupMH[1] += ld_supMH 
			ld_mEtcSupMH[1] += ld_etcsupMH 
		End If 
	Else									 		// 기타 
		If ls_supGbn = '+' Then     		// 받음 
			ld_pSupMH[2] += ld_supMH 
			ld_pEtcSupMH[2] += ld_etcsupMH 
		ElseIf ls_supGbn = '-' Then 		// 해줌 
			ld_mSupMH[2] += ld_supMH 
			ld_mEtcSupMH[2] += ld_etcsupMH 
		End If 		
	End If 
Next 

For I = 1 To 2 
	If UpperBound(ld_pSupMH[]) < I Then ld_pSupMH[I] = 0 
	If UpperBound(ld_mSupMH[]) < I Then ld_mSupMH[I] = 0 
	
	ls_pTarget = 'psuppmh' 
	ls_mTarget = 'msuppmh' 
	
	ld_orgMH = dw_mhdaily_free.GetItemNumber(I, ls_pTarget); If IsNull(ld_orgMH) Then ld_orgMH = 0 
	If ld_orgMH <> ld_pSupMH[I] Then & 
		dw_mhdaily_free.SetItem(I, ls_pTarget, ld_pSupMH[I])
	ld_pSupMH_s[I] += ld_pSupMH[I] 
	
	ld_orgMH = dw_mhdaily_free.GetItemNumber(I, ls_mTarget); If IsNull(ld_orgMH) Then ld_orgMH = 0 
	If ld_orgMH <> ld_mSupMH[I] Then 
		dw_mhdaily_free.SetItem(I, ls_mTarget, ld_mSupMH[I])
	End If 

	If UpperBound(ld_pEtcSupMH[]) < I Then ld_pEtcSupMH[I] = 0 
	If UpperBound(ld_mEtcSupMH[]) < I Then ld_mEtcSupMH[I] = 0 

	ls_pTarget = 'etcpsuppmh' 
	ls_mTarget = 'etcmsuppmh' 

	ld_orgMH = dw_mhdaily_free.GetItemNumber(I, ls_pTarget); If IsNull(ld_orgMH) Then ld_orgMH = 0 
	If ld_orgMH <> ld_pEtcSupMH[I] Then 
		dw_mhdaily_free.SetItem(I, ls_pTarget, ld_pEtcSupMH[I])
	End If 
	ld_pSupMH_s[I] += ld_pEtcSupMH[I] 
	
	ld_orgMH = dw_mhdaily_free.GetItemNumber(I, ls_mTarget); If IsNull(ld_orgMH) Then ld_orgMH = 0 
	If ld_orgMH <> ld_mEtcSupMH[I] Then 
		dw_mhdaily_free.SetItem(I, ls_mTarget, ld_mEtcSupMH[I])
	End If 
Next 

wf_setcalcmh()

ld_totInMH = dw_mhdaily_free.GetItemNumber(2, "totinmh_s")
If IsNull(ld_totInMH) Then ld_totInMH = 0
If ld_totInMH = 0 Then Return 1 

ld_A0MH = 0; ld_A1MH = 0; ld_A2MH = 0 
If ll_rowCnt > 0 Then f_pism_calcsuppresttime(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, li_nRestTime, li_eRestTime) 
If li_nRestTime <> 0 Then ld_A2MH = Round( li_nRestTime / 60, 1 ) 

  Select subMH Into :ld_A1MH From TMHDAILYDETAIL  
WHERE ( AreaCode = :istr_retrievemh.area ) AND  
		( DivisionCode = :istr_retrievemh.div ) AND  
		( WorkCenter = :istr_retrievemh.wc ) AND  
		( WorkDay = :istr_retrievemh.wday ) AND  
		( EmpGubun = '1' ) AND ( mhGubun = 'S' ) AND  
		( mhCode = 'A1' ) Using SqlPIS ; 
If IsNull(ld_A1MH) Then ld_A1MH = 0 
ld_A0MH = ld_A1MH + ld_A2MH 
ll_setrow = dw_s.Find( "mhcode = 'A0' And empgbn = '1'", 1, dw_s.RowCount())		
If ll_setrow > 0 Then dw_s.SetItem(ll_setrow, "submh", ld_A0MH) 
wf_setidssubmh('1', 'S', 'A2', ld_A2MH ) 
wf_setidssubmh('1', 'S', 'A0', ld_A0MH ) 

ld_A0MH = 0; ld_A1MH = 0; ld_A2MH = 0 
If li_eRestTime <> 0 Then ld_A2MH = Round( li_eRestTime / 60, 1 ) 

  Select subMH Into :ld_A1MH From TMHDAILYDETAIL  
WHERE ( AreaCode = :istr_retrievemh.area ) AND  
		( DivisionCode = :istr_retrievemh.div ) AND  
		( WorkCenter = :istr_retrievemh.wc ) AND  
		( WorkDay = :istr_retrievemh.wday ) AND  
		( EmpGubun = '2' ) AND ( mhGubun = 'S' ) AND  
		( mhCode = 'A1' ) Using SqlPIS ; 
If IsNull(ld_A1MH) Then ld_A1MH = 0 
ld_A0MH = ld_A1MH + ld_A2MH 

ll_setrow = dw_s.Find( "mhcode = 'A0' And empgbn = '2'", 1, dw_s.RowCount())		
If ll_setrow > 0 Then dw_s.SetItem(ll_setrow, "submh", ld_A0MH) 
wf_setidssubmh('2', 'S', 'A2', ld_A2MH ) 
wf_setidssubmh('2', 'S', 'A0', ld_A0MH ) 

REturn 1 

end function

public function integer wf_setidssubmh (string as_empgbn, string as_mhgbn, string as_mhcode, decimal ad_submh);Long ll_getRow, ll_findrow, ll_tarRow = 1 
String ls_mhGbn, ls_sumColName 
Decimal{1} ld_grSumMH, ld_totInMH, ld_actInMH, ld_orgMH
Integer li_mhLevel 

ls_mhGbn = as_mhGbn; If ls_mhGbn = '' Then Return -1 

ll_findrow = ids_detailmh_save.Find("empgubun = '" + as_empGbn + "' And mhgubun = '" + as_mhGbn + "' And mhcode = '" + &
									  as_mhcode + "'", 1, ids_detailmh_save.RowCount()) 
If ll_findRow = 0 Then 
	ll_findRow = ids_detailmh_save.Insertrow(0)
	
	ids_detailmh_save.SetItem(ll_findrow, "areacode", istr_mh.area)
	ids_detailmh_save.SetItem(ll_findrow, "divisioncode", istr_mh.div)
	ids_detailmh_save.SetItem(ll_findrow, "workcenter", istr_mh.wc)
	ids_detailmh_save.SetItem(ll_findrow, "workday", istr_mh.wday)
	ids_detailmh_save.SetItem(ll_findrow, "empgubun", as_empGbn)
	ids_detailmh_save.SetItem(ll_findrow, "mhgubun", ls_mhGbn) 
	
	Select IsNull(mhlevel,'') Into :li_mhLevel From TMHCODE 
	 Where mhGubun = :ls_mhGbn And mhCode = :as_mhcode Using SqlPIS ;
	ids_detailmh_save.SetItem(ll_findrow, "mhlevel", li_mhLevel) 
End If 

ids_detailmh_save.SetItem(ll_findrow, "mhcode", as_mhcode) 
ids_detailmh_save.SetItem(ll_findrow, "submh", ad_submh) 

ids_detailmh_save.Sort(); ids_detailmh_save.GroupCalc()
ll_findrow = ids_detailmh_save.Find("empgubun = '" + as_empGbn + "' And mhgubun = '" + as_mhGbn + "' And mhcode = '" + &
									  as_mhcode + "'", 1, ids_detailmh_save.RowCount()) 
ld_grSumMH = ids_detailmh_save.GetItemNumber(ll_findrow, "grsum_submh")

If ls_mhGbn = 'S' Then 
	ls_sumColName = "excpaidmh"
ElseIf ls_mhGbn = 'G' Then 
	ls_sumColName = "ilbomh"
End If 

If as_empGbn = '2' Then ll_tarRow = 2 

ld_orgMH = dw_mhdaily_free.GetItemNumber(ll_tarRow, ls_sumColName)
If IsNull(ld_orgMH) Then ld_orgMH = 0 
If ld_orgMH <> ld_grSumMH Then dw_mhdaily_free.SetItem(ll_tarRow, ls_sumColName, ld_grSumMH) 
wf_setcalcmh() 
Return ll_findrow 
end function

public subroutine wf_opendailysub (long al_getrow);String ls_modChk, ls_dailyStatus 

istr_mh.longParm = al_getrow
// 설비 강제 Connection 용
f_cmms_set_server_ipis(istr_mh.area, istr_mh.div)
// 
OpenWithParm(w_pism011u, istr_mh) 

ls_modChk = message.StringParm
If ls_modChk = '1' Then 
	dw_f.Event ue_Retrieve() 
	dw_u.Event ue_Retrieve() 
	dw_z.Event ue_Retrieve() 
	
	ls_dailyStatus = wf_getdailystatus()
	
	dw_dailystatus.SetItem(dw_dailystatus.GeTrow(), "dailystatus", ls_dailyStatus) 
	If ls_dailyStatus = '0' Then dw_dailystatus.Event Save_data() 
End If 

end subroutine

public subroutine wf_opendailysub ();Long ll_getRow 
SetNull(ll_getRow)

wf_opendailysub(ll_getRow) 
end subroutine

event resize;call super::resize;Long ll_Height 

dw_prod.Width = newwidth - ( dw_prod.x + dw_f.Width + st_vbar.Width + 10 ) 
dw_f.x = dw_prod.x + dw_prod.Width + st_vbar.Width 
dw_u.x = dw_f.x; dw_z.x = dw_f.x; dw_supp.x = dw_f.x; 
dw_prod.Height = newheight - ( dw_prod.y + uo_status.Height ) 

st_vbar.x = dw_prod.x + dw_prod.Width 

ll_Height = newheight - ( dw_f.y + 340 + uo_status.Height ) //+ 10 ) 
dw_f.Height = ll_Height / 3 
dw_u.y = dw_f.y + dw_f.Height 
dw_u.Height = dw_f.Height

dw_z.y = dw_u.y + dw_u.Height 
dw_z.Height = dw_f.Height

dw_supp.y = dw_z.y + dw_z.Height 
dw_dailystatus.y = dw_supp.y + dw_supp.Height 

st_vbar.Height = dw_prod.Height 

dw_u.x = dw_f.x; dw_z.x = dw_f.x; dw_supp.x = dw_f.x; dw_dailystatus.x = dw_f.x
end event

on w_pism010u.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.cb_labtac=create cb_labtac
this.cb_prodlist=create cb_prodlist
this.st_vbar=create st_vbar
this.st_4=create st_4
this.uo_workday=create uo_workday
this.gb_4=create gb_4
this.dw_g=create dw_g
this.dw_f=create dw_f
this.dw_u=create dw_u
this.dw_z=create dw_z
this.dw_supp=create dw_supp
this.dw_dailystatus=create dw_dailystatus
this.cb_resttime=create cb_resttime
this.dw_prod=create dw_prod
this.cb_dailystatus=create cb_dailystatus
this.cb_nodailylist=create cb_nodailylist
this.st_dailystatus=create st_dailystatus
this.st_2=create st_2
this.st_5=create st_5
this.dw_mhdaily_free=create dw_mhdaily_free
this.cb_mhcodehelp=create cb_mhcodehelp
this.dw_etcmhdetail=create dw_etcmhdetail
this.dw_s=create dw_s
this.st_3=create st_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.cb_labtac
this.Control[iCurrent+3]=this.cb_prodlist
this.Control[iCurrent+4]=this.st_vbar
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.uo_workday
this.Control[iCurrent+7]=this.gb_4
this.Control[iCurrent+8]=this.dw_g
this.Control[iCurrent+9]=this.dw_f
this.Control[iCurrent+10]=this.dw_u
this.Control[iCurrent+11]=this.dw_z
this.Control[iCurrent+12]=this.dw_supp
this.Control[iCurrent+13]=this.dw_dailystatus
this.Control[iCurrent+14]=this.cb_resttime
this.Control[iCurrent+15]=this.dw_prod
this.Control[iCurrent+16]=this.cb_dailystatus
this.Control[iCurrent+17]=this.cb_nodailylist
this.Control[iCurrent+18]=this.st_dailystatus
this.Control[iCurrent+19]=this.st_2
this.Control[iCurrent+20]=this.st_5
this.Control[iCurrent+21]=this.dw_mhdaily_free
this.Control[iCurrent+22]=this.cb_mhcodehelp
this.Control[iCurrent+23]=this.dw_etcmhdetail
this.Control[iCurrent+24]=this.dw_s
this.Control[iCurrent+25]=this.st_3
end on

on w_pism010u.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.cb_labtac)
destroy(this.cb_prodlist)
destroy(this.st_vbar)
destroy(this.st_4)
destroy(this.uo_workday)
destroy(this.gb_4)
destroy(this.dw_g)
destroy(this.dw_f)
destroy(this.dw_u)
destroy(this.dw_z)
destroy(this.dw_supp)
destroy(this.dw_dailystatus)
destroy(this.cb_resttime)
destroy(this.dw_prod)
destroy(this.cb_dailystatus)
destroy(this.cb_nodailylist)
destroy(this.st_dailystatus)
destroy(this.st_2)
destroy(this.st_5)
destroy(this.dw_mhdaily_free)
destroy(this.cb_mhcodehelp)
destroy(this.dw_etcmhdetail)
destroy(this.dw_s)
destroy(this.st_3)
end on

event ue_postopen;call super::ue_postopen;istr_mh.wday = uo_workday.is_uo_date

Post wf_splitinit()

If istr_mh.longparm = 0 Then 
	uo_area.PostEvent("ue_select") 
ElseIf istr_mh.longparm = 1 Then 	// 작성 
	This.PostEvent("ue_insert") 
ElseIf istr_mh.longparm = 2 Then 	// 조회 
	This.PostEvent("ue_retrieve") 
End If 
If cb_wcfilter.Text = '담당조 FILTER 취소' Then wf_autworkcenter(True) 
end event

event ue_retrieve;call super::ue_retrieve;Boolean lb_Enabled 
String ls_retChk = '0', ls_dailyValue 
Decimal{1} ld_actRate, ld_workRate, ld_alloverRate, ld_lpi 

dw_s.AcceptText(); dw_g.AcceptText(); dw_prod.AcceptText() 
This.SetRedraw(False) 
If IsNull(lparam) Then lparam = 0 

//작업일보 저장여부 Checking 
If lparam <> 1 Then 
	If wf_saveChk(True) = -1 Then Goto Exit_pr 
End If 
wf_DailyInit(); wf_mkdailychk(istr_mh) 

If istr_mh.dailyStatus = '' or istr_mh.dailyStatus = MKLABTACOK Then
	f_pism_messagebox(Information!, -1, "작업일보조회 실패", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + &
						 uo_wc.is_uo_workcentername + " 조~n~n" + "의 작업일보가 작성되지 않았습니다.") 
	Goto Exit_pr 
End If 

If IsValid(w_pism_working) Then 
	w_pism_working.wf_setMsg( String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조", & 
									  "작업일보를 조회중입니다. 잠시만 기다려 주십시오." )
Else
	f_pism_working_msg(String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + &
							 uo_wc.is_uo_workcentername + " 조", "작업일보를 조회중입니다. 잠시만 기다려 주십시오.") 
End If

If dw_mhdaily_free.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday) = 0 Then Goto Exit_pr 
istr_retrieveMH = istr_mh 

dw_s.Retrieve(istr_retrieveMH.area, istr_retrieveMH.div, istr_retrieveMH.wc, istr_retrieveMH.wday, dw_s.Tag) 
dw_g.Retrieve(istr_retrieveMH.area, istr_retrieveMH.div, istr_retrieveMH.wc, istr_retrieveMH.wday, dw_g.Tag) 

If lparam = 1 Then ls_retChk = '1' 
dw_prod.Retrieve(istr_retrieveMH.area, istr_retrieveMH.div, istr_retrieveMH.wc, istr_retrieveMH.wday, ls_retChk)
dw_f.Event ue_Retrieve()
dw_u.Event ue_Retrieve()
dw_z.Event ue_Retrieve()
dw_supp.Event ue_Retrieve() 
dw_dailystatus.Event ue_Retrieve() 
If ls_retChk = '1' Then dw_dailystatus.SetItem(dw_dailystatus.GetRow(), "dailystatus", '0') 

ids_detailmh_save.Retrieve(istr_retrieveMH.area, istr_retrieveMH.div, istr_retrieveMH.wc, istr_retrieveMH.wday)

If is_dailystatus = '1' Then 
	If f_pism_getalloverrate(istr_retrieveMH, ld_actRate, ld_workRate, ld_alloverRate, ld_lpi) = 1 Then 
		ls_dailyValue = "실동율 : " + String( ld_actRate, "###.0" ) + "%   작업효율 : " + String( ld_workRate, "###.0" ) + & 
							 "%   종합효율 : " + String( ld_alloverRate, "###.0" ) + "%   L P I : " + String( ld_lpi, "###.0" ) 
							 
		uo_status.st_message.Text = ls_dailyValue 
	End If 
Else
	Post wf_setsuppmh() 	
End If

//lb_Enabled = wf_dailyinputchk(ACT_EDIT) 
lb_Enabled = True 
Exit_pr: 

This.SetRedraw(True) 
If IsValid(w_pism_working) Then Close(w_pism_working)

wf_workEnabled(lb_Enabled); dw_prod.SetFocus() 
end event

event ue_save;Integer li_err, li_DailyStatusChk, ri_err , i
String ls_dailyStatus, ls_Month, ls_dailyValue 
Decimal{1} ld_actRate, ld_workRate, ld_alloverRate, ld_lpi 

If dw_mhdaily_free.RowCount() = 0 Then Return 

dw_s.AcceptText(); dw_g.AcceptText(); dw_prod.AcceptText() 
If IsNull(lparam) Then lparam = 0 

//If lparam <> 1 Then 
//	If f_pism_messagebox(Question!, 999, "작업일보 저장", String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + &
//								f_pism_getwcname(istr_retrieveMH) + " 조~n~n의 작업일보를 저장하시겠습니까?") <> 1 Then Return 
//End If

dw_supp.Event ue_Retrieve(); wf_setsuppmh() 

li_DailyStatusChk = wf_setautorevision() 
If li_DailyStatusChk = 0 Then 
	ls_dailyStatus = '0'  			 // 미확정 
ElseIf li_DailyStatusChk = 1 Then 
	ls_dailyStatus = '1' 			 // 확정 

	If f_pism_getalloverrate(istr_retrieveMH, ld_actRate, ld_workRate, ld_alloverRate, ld_lpi) = 1 Then 
		ls_dailyValue = "실동율 : " + String( ld_actRate, "###.0" ) + "%   작업효율 : " + String( ld_workRate, "###.0" ) + & 
							 "%   종합효율 : " + String( ld_alloverRate, "###.0" ) + "%   L P I : " + String( ld_lpi, "###.0" ) 
							 
		uo_status.st_message.Text = ls_dailyValue 
	End If 
Else
	Return 
End If 

dw_dailystatus.SetItem(1, "dailystatus", ls_dailyStatus) 

f_pism_working_msg(String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + &
						 f_pism_getwcname(istr_retrieveMH) + " 조", "작업일보를 저장중입니다. 잠시만 기다려 주십시오.") 
// 진천 속도 문제로 save 전 connection check
for i = 1 to 5 
	if isnull(sqlpis.dbhandle()) or sqlpis.dbhandle() <= 0 then
		connect using sqlpis ;
	else
		exit 
	end if
next

if isnull(sqlpis.dbhandle()) or sqlpis.dbhandle() <= 0 then 
	messagebox("확인","현재 IPIS 서버와 접속이 끊어진 상태입니다. 잠시 후 작업하시기 바랍니다 ")
	return 
end if

If dw_mhdaily_free.Event save_data() = -1 Then Goto Exit_pr
If dw_prod.Event save_data() = -1 Then Goto Exit_pr 
If dw_dailystatus.Event save_data() = -1 Then Goto Exit_pr


If IsValid(w_pism_working) Then Close(w_pism_working) 
If ls_dailyStatus = '0' Then f_pism_MessageBox(Information!, 999, "작업일보저장", String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + &
						 			  f_pism_getwcname(istr_retrieveMH) + " 조~n~n 의 작업일보가 미확정된 상태로 저장되었습니다.")
Return 

Exit_pr:

If IsValid(w_pism_working) Then Close(w_pism_working) 
//wf_workEnabled(False)

ROLLBACK USING  sqlPIS;
sqlPIS.AutoCommit = True 

f_pism_MessageBox(Information!, 999, "작업일보저장 실패", String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + &
						 f_pism_getwcname(istr_retrieveMH) + " 조~n 의 작업일보 저장에 실패하였습니다." ) 
return 
end event

event ue_insert;
If wf_saveChk(True) = -1 Then Return 

If istr_mh.dailyStatus = MKDAILYOK Then 
	f_pism_messagebox(Information!, 999, "작업일보작성 실패", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조~n~n" + & 
												 "의 작업일보가 이미 작성되어 있습니다.") 
	This.TriggerEvent("ue_retrieve")
	Return 
End If 

//작업일보 마감관련 제어(불필요) 
//If Not wf_dailyinputchk(ACT_INSERT) Then Return 

// 2005.05.18 수정 ( 이지은 )
//If istr_mh.dailyStatus <> MKLABTACOK Then 
//	f_pism_messagebox(Information!, 999, "작업일보작성 실패", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조~n~n" + & 
//												 "의 근태내역이 입력되지 않았습니다.") 
//	Return 
//End If 

f_pism_working_msg(String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + &
						 uo_wc.is_uo_workcentername + " 조", "근태내역을 호출중입니다. 잠시만 기다려 주십시오.") 

//향후 퍼포먼스가 떨어질 경우 SP사용(SP검토할것!!) 
//sqlPIS.sp_pism010u_loadLabTac(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday) 
//디버깅을 위해 외부함수를 사용 
If f_pism_loadlabtac(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, g_s_empno) = -1 Then 
	f_pism_messagebox(StopSign!, 999, "작업일보작성 실패", String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조~n~n" + & 
												 "의 작업일보 작성에 실패했습니다.") 
	If IsValid(w_pism_working) Then Close(w_pism_working) 											 
	Return 	
End If 

wf_workEnabled(True); wf_mkdailychk(istr_mh) 
This.Event ue_retrieve(0,1) 

end event

event ue_delete;call super::ue_delete;// 작업일보 삭제(불필요) 
//Return 

If istr_retrieveMH.dailyStatus <> MKDAILYOK Then 
	f_pism_messagebox(Question!, 999, "작업일보삭제 오류", String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조~n~n" + & 
												 "의 작업된 작업일보가 없습니다.")
End If 

If wf_saveChk(True) = -1 Then Return 

//작업일보 마감관련 제어(불필요) 
//If Not wf_dailyinputchk(ACT_DELETE) Then Return 

If f_pism_messagebox(Question!, 999, "작업일보삭제", String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조~n~n" + & 
												 "의 작업일보를 삭제하시겠습니까?") <> 1 Then Return 

f_pism_working_msg(String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + &
						 uo_wc.is_uo_workcentername + " 조", "작업일보를 삭제중입니다. 잠시만 기다려 주십시오.") 

SqlPIS.AutoCommit = False 
If f_pism_deletedaily(istr_retrieveMH.area, istr_retrieveMH.div, istr_retrieveMH.wc, istr_retrieveMH.wday) = -1 Then 
	RollBack Using SqlPIS;
	f_pism_messagebox(Question!, 999, "작업일보삭제 실패", String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조~n~n" + & 
												 "의 작업일보 삭제에 실패했습니다.")
	Goto Exit_pr 
Else
	Commit Using SqlPIS;
End If 
wf_mkdailychk(istr_retrieveMH)
wf_DailyInit() 

istr_mh = istr_retrieveMH 

Exit_pr:

sqlPIS.AutoCommit = True 

If IsValid(w_pism_working) Then Close(w_pism_working) 

end event

event close;call super::close;If IsValid(ids_autorev) Then Destroy ids_autorev 
end event

event closequery;call super::closequery;wf_saveChk(True) 
end event

event ue_print;call super::ue_print;str_pism_prt lstr_prt		//출력조건

lstr_prt.Transaction = SqlPIS 

lstr_prt.DataObject = 'd_pism010u_01_p' 
lstr_prt.title =  String(Date(istr_mh.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조 작업일보 출력" 
lstr_prt.parent_win = This 
lstr_prt.prscale = '85'

OpenSheetWithParm(w_pism_prt01, lstr_prt, w_frame, 0, Layered! )

end event

event open;call super::open;st_dailystatus.Text = '' 

dw_mhdaily_free.Modify("b_etcmh.Pointer = 'c:\kdac\bmp\harrow.cur'")
dw_mhdaily_free.Modify("b_unpaid.Pointer = 'c:\kdac\bmp\harrow.cur'")
dw_mhdaily_free.Modify("b_gunte.Pointer = 'c:\kdac\bmp\harrow.cur'")

dw_f.Modify("b_submh.Pointer = 'c:\kdac\bmp\harrow.cur'")
dw_u.Modify("b_submh.Pointer = 'c:\kdac\bmp\harrow.cur'")
dw_z.Modify("b_submh.Pointer = 'c:\kdac\bmp\harrow.cur'")
dw_supp.Modify("b_supp.Pointer = 'c:\kdac\bmp\harrow.cur'") 

dw_etcmhdetail.Visible = False 
If IsValid(istr_mh) Then uo_workday.uf_set_date(istr_mh.wday) 


end event

type uo_status from w_pism_sheet01`uo_status within w_pism010u
integer y = 2472
end type

type uo_wc from w_pism_sheet01`uo_wc within w_pism010u
integer x = 1189
integer y = 44
integer taborder = 30
end type

event uo_wc::ue_select;call super::ue_select;If ib_chgArea or ib_chgDiv Then Goto Exit_pr 

wf_mkdailychk(istr_mh) 
wf_saveChk(True); wf_DailyInit() 

If istr_mh.wc = '' Or IsNull(istr_mh.wc) Then Goto Exit_pr 

Time lt_Now 
lt_Now = Time(f_pisc_get_date_nowtime()) 
//wf_nodailyview() 

Exit_pr:

ib_chgWC = False 
uo_workday.SetFocus() 

end event

type uo_area from w_pism_sheet01`uo_area within w_pism010u
integer taborder = 10
end type

event uo_area::ue_select;call super::ue_select;
wf_mkdailychk(istr_mh) 
wf_saveChk(True); wf_DailyInit() 

If istr_mh.div = '' Or IsNull(istr_mh.div) Then Goto Exit_pr 
If cb_wcfilter.Text = '담당조 FILTER 취소' Then wf_autworkcenter(True) 

If istr_mh.wc = '' Or IsNull(istr_mh.wc) Then Goto Exit_pr 

Time lt_Now 
lt_Now = Time(f_pisc_get_date_nowtime()) 
//wf_nodailyview() 

Exit_pr:

ib_chgArea = False 
end event

type uo_div from w_pism_sheet01`uo_div within w_pism010u
integer x = 581
integer taborder = 20
end type

event uo_div::ue_select;call super::ue_select;If ib_chgArea Then Goto Exit_pr 

wf_mkdailychk(istr_mh) 
wf_saveChk(True); wf_DailyInit() 
If istr_mh.div = '' Or IsNull(istr_mh.div) Then Goto Exit_pr 
If cb_wcfilter.Text = '담당조 FILTER 취소' Then wf_autworkcenter(True) 

If istr_mh.wc = '' Or IsNull(istr_mh.wc) Then Goto Exit_pr 

Time lt_Now 
lt_Now = Time(f_pisc_get_date_nowtime()) 
//wf_nodailyview() 

Exit_pr:

ib_chgDiv = False 
end event

type cb_wcfilter from w_pism_sheet01`cb_wcfilter within w_pism010u
integer x = 3259
integer y = 148
integer height = 80
integer taborder = 0
end type

type gb_1 from w_pism_sheet01`gb_1 within w_pism010u
integer width = 2249
integer taborder = 0
end type

type gb_2 from groupbox within w_pism010u
integer x = 14
integer y = 808
integer width = 4608
integer height = 8
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
end type

type cb_labtac from commandbutton within w_pism010u
integer x = 663
integer y = 148
integer width = 649
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일일근태내역"
end type

event clicked;String ls_modChk 

OpenWithParm(w_pism012u, istr_mh) 

ls_modChk = message.StringParm 
If ls_modChk = '1' Then Parent.Event ue_retrieve(0,1) 

end event

type cb_prodlist from commandbutton within w_pism010u
integer x = 1312
integer y = 148
integer width = 649
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생산품번선택"
end type

event clicked;String ls_retValue, ls_dailyStatus 

OpenWithParm(w_pism013u, istr_mh) 

ls_retValue = message.StringParm
If ls_retValue = '1' Then 
	If dw_mhdaily_free.Event save_data() = -1 Then Goto Exit_pr 
	If dw_prod.Event save_data() = -1 Then Goto Exit_pr 
	
	ls_dailyStatus = wf_getdailystatus()
	
	dw_dailystatus.SetItem(dw_dailystatus.GeTrow(), "dailystatus", ls_dailyStatus) 
	If ls_dailyStatus = '0' Then dw_dailystatus.Event Save_data() 
	
	dw_prod.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, '1') 
End If 

Return 

Exit_pr:
f_pism_MessageBox(StopSign!, -1, "갱신오류", "작업입보 생산품번 갱신에 실패했습니다.") 
end event

type st_vbar from u_pism_splitbar within w_pism010u
integer x = 2825
integer y = 820
integer width = 14
integer height = 472
boolean bringtotop = true
end type

type st_4 from statictext within w_pism010u
integer x = 3122
integer y = 240
integer width = 1175
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "일보사고M/H"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_workday from u_pism_date_wday within w_pism010u
integer x = 2299
integer y = 52
integer width = 777
integer taborder = 40
boolean bringtotop = true
end type

on uo_workday.destroy
call u_pism_date_wday::destroy
end on

event ue_select;call super::ue_select;
istr_mh.wday = is_uo_date

If ib_chgWC Then Return 

wf_mkdailychk(istr_mh)
wf_saveChk(True); wf_DailyInit() 
end event

type gb_4 from groupbox within w_pism010u
integer x = 2263
integer y = 4
integer width = 841
integer height = 132
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_g from datawindow within w_pism010u
string tag = "G"
integer x = 3122
integer y = 308
integer width = 1029
integer height = 436
integer taborder = 70
string title = "none"
string dataobject = "d_pism010u_08_8"
boolean border = false
boolean livescroll = true
end type

event itemfocuschanged;This.SelectText(1, 10)
end event

event itemchanged;String ls_colName, ls_colNo, ls_mhCode, ls_empGbn 
Decimal{1} ld_inputMH 

ls_mhCode = This.GetItemString(row, "mhcode") 
If ls_mhCode = '' Or IsNull(ls_mhCode) Then Return 
If IsNull(data) Then data = '0'

ld_inputMH = Double(data) 
ls_empGbn = This.GetItemString(row, "empgbn") 
wf_setidssubmh(ls_empGbn, This.Tag, ls_mhCode, ld_inputMH) 

end event

event losefocus;This.AcceptText() 
end event

type dw_f from datawindow within w_pism010u
event type long ue_retrieve ( )
string tag = "F"
integer x = 3003
integer y = 820
integer width = 1627
integer height = 300
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_pism010u_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_retrieve();
This.SetTransObject(SqlPIS)
Return This.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, This.Tag) 
end event

event buttonclicked;if m_frame.m_action.m_save.Enabled = true then
	wf_openDailySub()
end if
end event

event clicked;if m_frame.m_action.m_save.Enabled = true then
	istr_mh.mhgbn = This.Tag
end if

end event

event doubleclicked;if m_frame.m_action.m_save.Enabled = true then
	wf_opendailysub(row) 
end if
end event

event retrieveend;Decimal{1} ld_Fmh_s, ld_org_fMH 

If rowcount > 0 Then ld_Fmh_s = This.GetItemNumber(rowcount, "sum_submh") 
If IsNull(ld_Fmh_s) Then ld_Fmh_s = 0 

ld_org_fMH = dw_mhdaily_free.GetItemNumber(1, "bugamh_s"); If IsNull(ld_org_fMH) Then ld_org_fMH = 0 
If ld_org_fMH <> ld_Fmh_s Then 
	dw_mhdaily_free.SetItem(1, "bugamh", ld_Fmh_s) 
	wf_setcalcmh() 
End If 
end event

type dw_u from datawindow within w_pism010u
event type long ue_retrieve ( )
string tag = "U"
integer x = 3003
integer y = 1136
integer width = 1627
integer height = 504
integer taborder = 110
string title = "none"
string dataobject = "d_pism010u_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_retrieve();This.SetTransObject(SqlPIS)
Return This.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, This.Tag) 
end event

event clicked;if m_frame.m_action.m_save.Enabled = true then
	istr_mh.mhgbn = This.Tag
end if

end event

event buttonclicked;if m_frame.m_action.m_save.Enabled = true then
	wf_opendailysub()
end if
end event

event doubleclicked;if m_frame.m_action.m_save.Enabled = true then
	wf_opendailysub(row) 
end if
end event

type dw_z from datawindow within w_pism010u
event type long ue_retrieve ( )
string tag = "Z"
integer x = 3003
integer y = 1644
integer width = 1627
integer height = 408
integer taborder = 120
string title = "none"
string dataobject = "d_pism010u_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type long ue_retrieve();This.SetTransObject(SqlPIS)
Return This.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, This.Tag) 
end event

event clicked;if m_frame.m_action.m_save.Enabled = true then
	istr_mh.mhgbn = This.Tag
end if

end event

event buttonclicked;if m_frame.m_action.m_save.Enabled = true then
	wf_opendailysub() 
end if
end event

event doubleclicked;if m_frame.m_action.m_save.Enabled = true then
	wf_opendailysub(row) 
end if
end event

type dw_supp from datawindow within w_pism010u
event ue_retrieve ( )
integer x = 3003
integer y = 2128
integer width = 1627
integer height = 180
integer taborder = 130
string title = "none"
string dataobject = "d_pism010u_05"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_retrieve;dw_supp.SetTransObject(SqlPIS) 
dw_supp.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday)

end event

event buttonclicked;String ls_modChk, ls_dailyStatus 

OpenWithParm(w_pism020u, istr_mh)

ls_modChk = message.StringParm 
If ls_modChk = '1' Then 
	wf_setsuppmh()  
	
	ls_dailyStatus = wf_getdailystatus()
	dw_dailystatus.SetItem(dw_dailystatus.GeTrow(), "dailystatus", ls_dailyStatus) 
	If ls_dailyStatus = '0' Then dw_dailystatus.Event Save_data() 

	This.TriggerEvent("ue_retrieve") 
End If

end event

type dw_dailystatus from datawindow within w_pism010u
event type integer save_data ( )
event ue_retrieve ( )
integer x = 3003
integer y = 2312
integer width = 1637
integer height = 160
integer taborder = 140
string title = "none"
string dataobject = "d_pism010u_04"
boolean border = false
boolean livescroll = true
end type

event type integer save_data();String ls_Month 
Integer ri_err 

This.SetItem(1, "inputemp", g_s_empno) 
If f_pism_dwupdate(This, False) = -1 Then Goto Exit_pr 

ls_Month = Mid(istr_retrieveMH.wday, 1, 7) 
Declare proc_sumMonth Procedure For sp_pism010u_sumMonth &
		 :istr_retrieveMH.area, :istr_retrieveMH.div, :istr_retrieveMH.wc, :ls_Month, @ri_err = 0 Output 
USING sqlPIS ;
Execute proc_sumMonth ;
If SqlPIS.SqlCode = 0 Then 
	Fetch proc_sumMonth Into :ri_err ;
	If SqlPIS.SqlCode <> 0 Then
		f_pism_Messagebox(StopSign!, -1, "집계오류", "해당월 공수 및 생산수량 집계에 실패했습니다.") 
		Close proc_sumMonth ;
		Goto Exit_pr 			
	End If
Else
	Close proc_sumMonth ;
	Goto Exit_pr 			
End If
Close proc_sumMonth ;

COMMIT USING  sqlPIS;
sqlPIS.AutoCommit = True 

wf_mkdailychk(istr_retrievemh)

Return 1 

Exit_pr:

ROLLBACK USING  sqlPIS; 
sqlPIS.AutoCommit = True 

Return -1 
end event

event ue_retrieve;This.SetTransObject(SqlPIS)
This.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday) 
end event

type cb_resttime from commandbutton within w_pism010u
integer x = 1961
integer y = 148
integer width = 649
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "법정휴게시간"
end type

event clicked;OpenWithParm(w_pism014i, istr_retrievemh) 
end event

type dw_prod from u_pism_dw within w_pism010u
event syscommand pbm_syscommand
event resize pbm_dwnresize
event ue_vscroll pbm_vscroll
string tag = "itemspec,actinmh"
integer x = 27
integer y = 824
integer width = 2816
integer height = 1336
integer taborder = 90
boolean titlebar = true
string dataobject = "d_pism010u_03"
boolean controlmenu = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = false
integer ii_selection = 0
end type

event syscommand;if message.wordparm	  = 61536 then		//window close
	message.processed   = true
	message.returnvalue = 1
end if
if message.wordparm	  = 61488 then		//window max 
	This.uf_setHSplitScroll('') 
end if
if message.wordparm	  = 61728 then		//이전 크기대로 
	This.Post uf_setHSplitScroll(This.Tag) 
end if

end event

event resize;//If This.RowCount() > 0 Then This.uf_setHSplitScroll(This.Tag) 

end event

event ue_vscroll;//Long ll_scrollPos 
//String ls_Row, ls_vScrollPos, ls_Chk 
//
//If scrollcode = 0 Then 
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) - 84 
//	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//
//	Return 1 
//ElseIf scrollcode = 1 Then 
//	
//	ls_Row = Describe("DataWindow.FirstRowOnPage") 
////	Parent.uo_status.st_message.text = ls_Row + " " + This.GetItemString(Long(ls_row), "itemcode") 
////	If This.GetItemString(Long(ls_row), "itemcode") = '219131' Then 
////		ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
////		ls_Row = ls_Row 
////	End If 
////	ll_scrollPos = Long(ls_Row) * 84 
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) + 84 
//	
//	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//	If ls_Chk <> '' Then MessageBox("", ls_Chk)
//	Return 1 
//End If 
//
//
end event

event retrieveend;String ls_col, ls_ColX, ls_colList 

If rowcount > 0 Then 
	This.uf_setHSplitScroll(This.Tag) 
	Post wf_setprodgrmh(True)
End If 
This.Title = String(Date(istr_retrieveMH.wday), 'yyyy년MM월dd일') + " " + f_pism_getwcname(istr_retrieveMH) + " 생산수량 내역" 

end event

event itemchanged;Decimal{1} ld_inputMH, ld_grunuseMH, ld_orgMH, ld_basicMH 
String ls_inputChk = '0', ls_wcItemGroup 
Long ll_grRow 

Choose Case dwo.Name 
	Case 'daypqty', 'nightpqty' 
		This.AcceptText() 
		ld_basicMH = This.GetItemNumber(row, "calc_basicmh") 
		If IsNull(ld_basicMH) Then ld_basicMH = 0 
		
		This.SetItem(row, "basicmh", ld_basicMH) 
		
	Case 'unusemh', 'actmh'		// 유휴공수, 실동공수 
		
		ls_wcItemGroup = This.GeTItemString(row, "wcitemgroup")
		
		If Not IsNull(data) Then ls_inputChk = '1' 
		If IsNull(data) Then data = '0'; ld_inputMH = Double(data) 
		
		ld_orgMH = This.GetItemNumber(row, String(dwo.Name))
		
		This.AcceptText()
		
		If dwo.Name = 'unusemh' Then 		
			If IsNull(ls_wcItemGroup) Then 
				wf_setActInMH(row, 'unusemh', ld_inputMH) 
			Else
				ll_grRow = Long(This.Describe("Evaluate('gr_row'," + String(row) + ")"))
				If row <> ll_grRow Then 
					This.SetItem(row, "unuse_inputchk", ls_inputChk) 
					ld_grunuseMH = Double(This.Describe("Evaluate('grsum_unuse'," + String(row) + ")"))
					This.SetItem(ll_grRow, "unusemh", ld_grunuseMH)
					wf_setActInMH(row, 'unusemh', ld_inputMH) 
				Else
					If wf_setUnuseMH(row, ld_inputMH) = -1 Then 
						This.SetItem(row, "unusemh", ld_orgMH); This.SelectText(1, 5)
						Return 1 
					End If 
				End If 
			End If 
		ElseIf dwo.Name = 'actmh' Then 
			
			If IsNull(ls_wcItemGroup) Then 
				wf_setActInMH(row, 'actmh', ld_inputMH) 
			Else				
				ll_grRow = Long(This.Describe("Evaluate('gr_row'," + String(row) + ")"))
				If row <> ll_grRow Then 
					This.SetItem(row, "act_inputchk", ls_inputChk) 
					ld_grunuseMH = Double(This.Describe("Evaluate('grsum_act'," + String(row) + ")"))
					This.SetItem(ll_grRow, "actmh", ld_grunuseMH)
					wf_setActInMH(row, 'actmh', ld_inputMH) 
				Else
					If wf_setActMH(row, ld_inputMH) = -1 Then 
						This.SetItem(row, "actmh", ld_orgMH); This.SelectText(1, 5)
						Return 1 
					End If 
				End If 
			End If 
		End If
				
End Choose 

dw_mhdaily_free.SetItem(dw_mhdaily_free.RowCount(), "input_actinmh", dw_prod.GetItemNumber(dw_prod.RowCount(), "sum_actin")) 

This.SetRedraw(True) 
end event

event save_data;call super::save_data;Long ll_findRow 

ll_findRow = This.Find("IsNull(workday)", 1, This.RowCount()) 
Do While ll_findRow > 0 
	This.setitemstatus(ll_findRow,0,Primary!,NotModified!)
	ll_findRow = This.Find("IsNull(workday)", ll_findRow + 1, This.RowCount()) 
	If ll_findRow > This.RowCount() Then Exit 
Loop 

Return f_pism_dwupdate(This, False) 


end event

event clicked;call super::clicked;//If row <= 0 Then Return 1 
end event

event losefocus;call super::losefocus;This.AcceptText() 
This.Modify("cur_col.Expression = ''"); This.SetRedraw(True) 
end event

event itemfocuschanged;call super::itemfocuschanged;This.SelectText(1, 10) 
This.Modify("cur_col.Expression = '" + String(dwo.Name) + "'") 
This.SetRedraw(True) 
end event

event ue_key;Integer li_ColNo 
// 10~13
If Key = KeyLeftArrow! Then 
	li_ColNo = This.GetColumn()
	
	li_ColNo -- 
	If li_ColNo = 9 Then li_ColNo = 13

	This.SetColumn(li_ColNo); This.SetFocus()
ElseIf Key = KeyRightArrow! Then 
	li_ColNo = This.GetColumn()
	
	li_ColNo ++ 
	If li_ColNo = 14 Then li_ColNo = 10

	This.SetColumn(li_ColNo); This.SetFocus()
End If

end event

event rowfocuschanged;call super::rowfocuschanged;//Integer li_scrollPos 
//
//If currentrow <= 17 Then Return 1 
//li_scrollPos = currentrow - 17 
//Parent.SetRedraw(False); This.SetRedraw(False) 
//This.Modify("DataWindow.VerticalScrollPosition=" + String(li_scrollPos*84))
//This.SetRedraw(True); Parent.SetRedraw(True) 
end event

type cb_dailystatus from commandbutton within w_pism010u
integer x = 14
integer y = 148
integer width = 649
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "작업일보확정"
end type

event clicked;If istr_retrievemh.dailyStatus <> MKDAILYOK Then Return 

If This.Text = '작업일보확정취소' Then 
	If f_pism_messagebox(Question!, 999, "작업일보확정취소", String(Date(istr_retrievemh.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조~n~n" + & 
													 "작업일보 확정취소를 하시겠습니까?") <> 1 Then Return 
	  UPDATE TMHDAILYSTATUS  
        SET DailyStatus = '0',
		   	LastEmp = 'Y' 
   WHERE ( AreaCode = :istr_retrievemh.area ) AND  
         ( DivisionCode = :istr_retrievemh.div ) AND  
         ( WorkCenter = :istr_retrievemh.wc ) AND  
         ( WorkDay = :istr_retrievemh.wday ) Using SqlPIS ;
	If f_pism_sqlchkopt(True) Then wf_mkDailyChk(istr_retrievemh) 
	
ElseIf This.Text = '작업일보확정' Then 
	
	If wf_setsuppmh() <> 1 Then Return 
	If wf_setautorevision()  <= 0 Then 
		f_pism_messagebox(Information!, -1, "작업일보확정 실패", String(Date(istr_retrievemh.wday), 'yyyy년MM월dd일') + " " + uo_wc.is_uo_workcentername + " 조~n~n" + & 
												 "의 작업일보확정에 실패했습니다.")
		Return 
	End If
	
	Parent.Event ue_save(0,1) 
End IF 

end event

type cb_nodailylist from commandbutton within w_pism010u
integer x = 2610
integer y = 148
integer width = 649
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "미작성작업일보현황"
end type

event clicked;If wf_nodailyview() = 0 Then f_pism_MessageBox(Information!, 999, "작업일보작성현황", "미작성(미확정)된 작업일보가 없습니다.")


end event

type st_dailystatus from statictext within w_pism010u
integer x = 4210
integer y = 40
integer width = 366
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 29935871
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pism010u
integer x = 3831
integer y = 36
integer width = 425
integer height = 72
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 29935871
string text = "Status :"
boolean focusrectangle = false
end type

type st_5 from statictext within w_pism010u
integer x = 3767
integer y = 28
integer width = 814
integer height = 84
integer textsize = -20
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 29935871
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_mhdaily_free from datawindow within w_pism010u
event type integer save_data ( )
integer x = 5
integer y = 232
integer width = 4635
integer height = 616
integer taborder = 80
string title = "none"
string dataobject = "d_pism010u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event type integer save_data();//If wf_setEtcMH() <> 1 Then Return -1 

If f_pism_dwupdate(This, False) <> 1 Then Return -1 
If f_pism_dsupdate(ids_detailmh_save, False) <> 1 Then Return -1 

Return 1 
end event

event itemfocuschanged;This.SelectText(1, 10)
end event

event retrieveend;Boolean lb_Enabled 
If rowcount > 0 Then lb_Enabled = True 
dw_s.Enabled = lb_Enabled; dw_g.Enabled = lb_Enabled

end event

event buttonclicked;
If dwo.Name = 'b_etcmh' Then 
	If This.ShareData(dw_etcmhdetail) = 1 Then 
		dw_etcmhdetail.Visible = True 
	End If 
ElseIf dwo.Name = 'b_unpaid' Then 
	dw_s.DataObject = f_pism_getDataObject_detailmh('K') 
	dw_s.SetTransObject(SqlPIS); st_3.Text = '평가제외 무급M/H'
	dw_s.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, 'K') 
ElseIf dwo.Name = 'b_gunte' Then 
	dw_g.DataObject = f_pism_getDataObject_detailmh('B') 
	dw_g.SetTransObject(SqlPIS); st_4.Text = '유급근태사고M/H'
	dw_g.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, 'B') 
End If 

end event

event losefocus;If st_3.Text <> '평가제외 유급M/H' Then 
	dw_s.DataObject = f_pism_getDataObject_detailmh(dw_s.Tag) 
	dw_s.SetTransObject(SqlPIS); st_3.Text = '평가제외 유급M/H'
	dw_s.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, dw_s.Tag) 
End If
If st_4.Text <> '일보사고M/H' Then 
	dw_g.DataObject = f_pism_getDataObject_detailmh(dw_g.Tag) 
	dw_g.SetTransObject(SqlPIS); st_4.Text = '일보사고M/H' 
	dw_g.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, dw_g.Tag) 
End If 
If dw_etcmhdetail.Visible Then dw_etcmhdetail.Visible = False 
end event

event itemchanged;This.AcceptText(); wf_setcalcmh() 

end event

event itemerror;Return 1 
end event

type cb_mhcodehelp from commandbutton within w_pism010u
integer x = 3909
integer y = 148
integer width = 649
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "공수항목 HELP"
end type

event clicked;OpenWithParm(w_pism010u_01, istr_mh) 
end event

type dw_etcmhdetail from datawindow within w_pism010u
integer x = 846
integer y = 240
integer width = 389
integer height = 504
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_pism010u_01_etcmh"
boolean border = false
boolean livescroll = true
end type

type dw_s from datawindow within w_pism010u
event type string ue_getitemmhcode ( long row )
string tag = "S"
integer x = 1157
integer y = 324
integer width = 1486
integer height = 420
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_pism010u_08_12"
boolean border = false
boolean livescroll = true
end type

event itemfocuschanged;This.SelectText(1, 10)

end event

event itemchanged;String ls_colName, ls_colNo, ls_mhCode, ls_empGbn 
Decimal{1} ld_inputMH 

ls_mhCode = This.GetItemString(row, "mhcode") 
If ls_mhCode = '' Or IsNull(ls_mhCode) Then Return 
If IsNull(data) Then data = '0'

ld_inputMH = Double(data) 
ls_empGbn = This.GetItemString(row, "empgbn") 
wf_setidssubmh(ls_empGbn, This.Tag, ls_mhCode, ld_inputMH) 

end event

event losefocus;This.AcceptText() 

end event

event clicked;this.setredraw(true)

end event

type st_3 from statictext within w_pism010u
integer x = 1170
integer y = 240
integer width = 1632
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "평가제외 유급M/H"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

