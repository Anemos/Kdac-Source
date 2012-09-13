$PBExportHeader$w_piss090u.srw
$PBExportComments$상차계획
forward
global type w_piss090u from w_ipis_sheet01
end type
type cbx_1 from checkbox within w_piss090u
end type
type cb_srview from commandbutton within w_piss090u
end type
type cb_split from commandbutton within w_piss090u
end type
type cb_print from commandbutton within w_piss090u
end type
type tab_1 from tab within w_piss090u
end type
type tabpage_1 from userobject within tab_1
end type
type dw_normal from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_normal dw_normal
end type
type tabpage_2 from userobject within tab_1
end type
type dw_minap from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_minap dw_minap
end type
type tabpage_3 from userobject within tab_1
end type
type dw_sennap from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
dw_sennap dw_sennap
end type
type tabpage_4 from userobject within tab_1
end type
type dw_move from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_move dw_move
end type
type tab_1 from tab within w_piss090u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type cb_trucknew from commandbutton within w_piss090u
end type
type dw_plancancel from datawindow within w_piss090u
end type
type st_4 from statictext within w_piss090u
end type
type st_invqty from statictext within w_piss090u
end type
type dw_id from datawindow within w_piss090u
end type
type dw_truckorder from datawindow within w_piss090u
end type
type dw_print from datawindow within w_piss090u
end type
type sle_checksrno from singlelineedit within w_piss090u
end type
type em_shipeditno from editmask within w_piss090u
end type
type sle_custcode from singlelineedit within w_piss090u
end type
type st_5 from statictext within w_piss090u
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss090u
end type
type em_applyfrom from editmask within w_piss090u
end type
type uo_date from u_pisc_date_applydate within w_piss090u
end type
type uo_area from u_pisc_select_area within w_piss090u
end type
type uo_division from u_pisc_select_division within w_piss090u
end type
type dw_truck from datawindow within w_piss090u
end type
type cb_1 from commandbutton within w_piss090u
end type
type gb_1 from groupbox within w_piss090u
end type
type gb_2 from groupbox within w_piss090u
end type
type gb_4 from groupbox within w_piss090u
end type
type gb_5 from groupbox within w_piss090u
end type
type gb_6 from groupbox within w_piss090u
end type
type gb_8 from groupbox within w_piss090u
end type
type gb_7 from groupbox within w_piss090u
end type
type gb_9 from groupbox within w_piss090u
end type
type gb_10 from groupbox within w_piss090u
end type
type gb_50 from groupbox within w_piss090u
end type
type gb_truck from groupbox within w_piss090u
end type
end forward

global type w_piss090u from w_ipis_sheet01
integer width = 4617
integer height = 2772
string title = "상차계획"
event type long ue_postopen ( unsignedlong wparam,  long lparam )
event ue_split pbm_custom57
event ue_srview ( )
cbx_1 cbx_1
cb_srview cb_srview
cb_split cb_split
cb_print cb_print
tab_1 tab_1
cb_trucknew cb_trucknew
dw_plancancel dw_plancancel
st_4 st_4
st_invqty st_invqty
dw_id dw_id
dw_truckorder dw_truckorder
dw_print dw_print
sle_checksrno sle_checksrno
em_shipeditno em_shipeditno
sle_custcode sle_custcode
st_5 st_5
uo_shipoemgubun uo_shipoemgubun
em_applyfrom em_applyfrom
uo_date uo_date
uo_area uo_area
uo_division uo_division
dw_truck dw_truck
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
gb_8 gb_8
gb_7 gb_7
gb_9 gb_9
gb_10 gb_10
gb_50 gb_50
gb_truck gb_truck
end type
global w_piss090u w_piss090u

type variables
string is_areacode,is_divisioncode,is_date, is_today, is_filter[]
int ii_window_border = 10, ii_maxtruck = 0, ii_mintruck,il_delete_truckorder
boolean ib_open, ib_exit
string is_security, is_pgmid, is_pgmname
datawindow idw_normal, idw_minap, idw_sennap,&
                    idw_move, idw_current
string is_modelid = '%',is_checksrno = '%'
string is_shipeditno = '%'
string is_shipoemgubun = '%'
string is_shipcount, is_custcode = '%',  is_sort

// last click row find
long il_lastclicked[],il_truck_lastclicked
boolean ib_ldown[],ib_truck_ldown
boolean ib_truckldown
boolean   ib_already_selected, ib_change,ib_truck_already_selected
long   il_selected_clicked, il_truckrow, il_old_row,il_truck_selected_clicked

integer ii_index
end variables

forward prototypes
protected subroutine wf_resize (integer fi_h, integer fi_w)
public function integer wf_shift_highlight (datawindow adw_current, integer al_clickedrow)
public subroutine wf_truck_dw_mousemove (unsignedlong flags, integer xpos, integer ypos)
public subroutine wf_return_buffer (datawindow adw_source)
public subroutine wf_filter ()
public subroutine wf_dw_doubleclicked (integer xpos, integer ypos, long row, dwobject dwo)
public subroutine wf_dw_lmouse_down (unsignedlong flags, integer xpos, integer ypos)
public subroutine wf_dw_losefocus ()
protected subroutine wf_split (string fs_split, integer fi_truckorder, integer fi_loadqty, integer fi_dansuqty)
public subroutine wf_dw_lmouse_up (unsignedlong flags, integer xpos, integer ypos)
public subroutine wf_truckloadview (integer xpos, integer ypos, long row, dwobject dwo)
public subroutine wf_dw_mousemove (unsignedlong flags, integer xpos, integer ypos)
public subroutine wf_truck_dw_lmouse_down (unsignedlong flags, integer xpos, integer ypos)
public subroutine wf_truck_dw_lmouse_up (unsignedlong flags, integer xpos, integer ypos)
public subroutine wf_truck_return_buffer (integer fi_truckorder)
public subroutine wf_truck_dw_clicked (integer xpos, integer ypos, long row, dwobject dwo)
public subroutine wf_change_buffer (datawindow adw_source, integer fi_truckorder)
public subroutine wf_ship_count ()
public subroutine wf_dw_clicked (integer xpos, integer ypos, long row, dwobject dwo)
public function boolean wf_update_loadplan ()
public function boolean wf_update_tloadplan_child (string fs_shipplandate, long fl_truckorder, string fs_srno, string fs_areacode, string fs_divisioncode, long fl_truckplan, string fs_truckmodifyflag)
end prototypes

event ue_postopen;cb_split.enabled = m_frame.m_action.m_save.enabled
//cb_confirm.enabled = m_frame.m_action.m_save.enabled
Int i

SetPointer(HourGlass!)

dw_print.Visible			= False
dw_truckorder.Visible	= False

dw_id.InsertRow(1)
dw_id.SetItem(1, 1, '')
dw_plancancel.InsertRow(1)


For i = 1 To 4
	is_filter[i] = ''
	il_lastclicked[i]	= 0
	ib_ldown[i]			= False
Next

Show()

idw_normal 	= tab_1.tabpage_1.dw_normal
idw_minap 	= tab_1.tabpage_2.dw_minap
idw_sennap 	= tab_1.tabpage_3.dw_sennap
idw_move		= tab_1.tabpage_4.dw_move
idw_current	= idw_normal


Window lw_frame

lw_frame	= ParentWindow()
lw_frame.ArrangeSheets (Layer!)

idw_normal.SetTransObject(SQLPIS)
idw_minap.SetTransObject(SQLPIS)
idw_sennap.SetTransObject(SQLPIS)
idw_move.SetTransObject(SQLPIS)
dw_truckorder.SetTransObject(SQLPIS)

string ls_codegroup,ls_codegroupname,ls_codename
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',TRUE,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)

ib_open	= True


end event

event ue_split;long   	li_truckorder, li_rackqty, li_remainqty, li_rtn,li_shipeditno
Long		ll_selected_count, ll_selected_row[]
string	ls_parm, ls_rtn, ls_change, ls_srno, ls_itemcode, ls_srgubun, ls_shipcount, ls_custcode, ls_size
string   ls_divisioncode,ls_shipgubun,ls_areacode
ll_selected_count	= f_sreturn_selected(idw_current, ll_selected_row[])
If ib_change Then //아직 저장되지 않은 Data가 잇다면
	li_rtn	= MessageBox('수량 분할', '저장되지 상차계획이 있습니다.~r~n상차계획을 저장 하시겠습니까?', Question!, YesNoCancel!)
	CHOOSE CASE li_rtn
		CASE 1
			ib_exit	= True
			TriggerEvent('ue_save') 
			ib_exit	= False
		CASE 3
			Return
	END CHOOSE
End If

If ll_selected_count > 1 Then
	MessageBox("수량 분할", "수량 분할을 수행할 제품을 하나만 선택하세요")
	Return
End If

If ll_selected_count = 0 Then
	MessageBox("수량 분할", "수량 분할을 수행할 제품을 선택하세요")
	Return
End If

If ll_selected_count = 1 Then
 // 모두 저장이 되어 있다면 상차계획 변경 윈도우를 연다.
		il_selected_clicked	= ll_selected_row[1]
		ls_divisioncode = idw_current.GetItemString (il_selected_clicked,  "divisioncode")
		li_truckorder	 = idw_current.GetItemNumber (il_selected_clicked,  "truckorder")
		li_remainqty	 = idw_current.GetItemNumber (il_selected_clicked,  "shipRemainqty1")
		ls_itemcode	    = idw_current.GetItemString (il_selected_clicked,  "itemcode")
		ls_srno	       = idw_current.GetItemString (il_selected_clicked,  "srno")
		li_Rackqty		 = idw_current.GetItemNumber (il_selected_clicked,  "RackQty")
		ls_srgubun		 = idw_current.GetItemString (il_selected_clicked,  "SRGubun")
		li_shipeditno   = idw_current.GetItemNumber (il_selected_clicked,  "shipeditno")
		ls_custcode		 = idw_current.GetItemString (il_selected_clicked,  "custcode")
      ls_shipgubun	 = idw_current.GetItemString (il_selected_clicked,  "shipgubun")
		ls_size	= Left(String(WorkSpaceX()) + Space(10), 10)	+ &
					  Left(String(WorkSpaceY()) + Space(10), 10)	+ &
					  Left(String(WorkSpaceWidth()) + Space(10), 10) + &
					  Left(String(WorkSpaceHeight()) + Space(10), 10)

//		if ls_shipgubun = 'M' then //이체
//			ls_areacode = is_areacode		
////		   ls_areacode = idw_current.GetItemString (il_selected_clicked,  "custname")
//		   ls_divisioncode = idw_current.GetItemString (il_selected_clicked,  "divisioncode")
//		else
			ls_areacode = is_areacode
//		end if
		ls_parm			= ls_areacode + &
		                 ls_divisioncode	+ &		
		                 is_date + &
							  Left(string(li_truckorder)	+ Space(5), 5)	+ &		
							  Left(ls_itemcode				+ Space(15), 15)	+ &		
							  Left(string(li_rackqty)		+ Space(10), 10)	+ &		
							  Left(is_date						+ Space(10), 10)	+ &		
							  Left(ls_srno 			      + Space(11), 11)	+ &
							  Left(ls_srgubun					+ Space(10), 10)  + &
							  Left(string(li_remainqty)	+ Space(5), 5)    + &
							  Left(string(li_shipeditno)	+ Space(5), 5)  	+ &
							  Left(ls_custcode				+ Space(10), 10) + &
							  Left(ls_shipgubun				+ Space(10), 10) + ls_size
		sqlpis.autocommit = true							  
		OpenWithParm(w_piss100u, ls_parm)
		ls_rtn		 	= Message.StringParm
		ls_change		= Trim(Mid(ls_rtn, 1, 5))
		sqlpis.autocommit = true
		If ls_change = 'YES' Then
 		   TriggerEvent('ue_retrieve')			
			ib_change	= False
		End If
//		TriggerEvent('ue_retrieve')
End If
end event

event ue_srview;string ls_srno, ls_parm, ls_size,ls_areacode,ls_divisioncode
long ll_selected_row[], ll_selected_count

ll_selected_count	= f_sreturn_selected(idw_current,ll_selected_row[])

ls_size	= Left(String(WorkSpaceX()) + Space(10), 10)	+ &
			  Left(String(WorkSpaceY()) + Space(10), 10)	+ &
			  Left(String(WorkSpaceWidth()) + Space(10), 10) + &
			  Left(String(WorkSpaceHeight()) + Space(10), 10)

If ll_selected_count = 1 Then
	il_selected_clicked	= ll_selected_row[1]
	ls_srno	= left(idw_current.GetItemString (il_selected_clicked,  "checksrno") + space(11),11)
	ls_divisioncode	= idw_current.GetItemString (il_selected_clicked,  "divisioncode")
	ls_parm 			= ls_srno + is_date + is_areacode + ls_divisioncode
Else
	ls_parm 			= 'NO' + ls_size 
End If

OpenWithParm(w_piss110i, ls_parm)
end event

protected subroutine wf_resize (integer fi_h, integer fi_w);int li_dw_x, li_dw_y, li_dw_w, li_dw_h

gb_truck.Move(fi_w - gb_truck.width - (2 * ii_window_border), gb_truck.Y)
//gb_Truck.Resize(gb_truck.Width,  fi_h - uo_status_bar.height - (ii_Window_Border * 4) - gb_truck.Y - dw_plancancel.height)

dw_plancancel.Move(gb_truck.X, gb_truck.Y + gb_truck.height + ii_Window_Border)
dw_plancancel.Resize(gb_truck.Width, dw_plancancel.Height)

cb_trucknew.Move(gb_truck.X + (3 * ii_window_border), cb_trucknew.Y)
cb_trucknew.resize(gb_truck.Width - (6 * ii_window_border), cb_trucknew.height)

dw_truck.Move(gb_truck.X + (2 * ii_window_border), dw_truck.Y)
dw_truck.Resize(gb_truck.Width - (4 * ii_window_border),	&
			gb_Truck.height - ( 8 * ii_window_border) - cb_trucknew.height)

tab_1.Move(ii_window_border, tab_1.Y)
tab_1.resize(fi_w - gb_truck.width - (4 * ii_window_border), &
					fi_h - tab_1.Y - (uo_status.Height ) - (ii_Window_Border * 2))

li_dw_x	= idw_normal.X
li_dw_y	= idw_normal.Y
li_dw_w	= tab_1.Width - 40
li_dw_h	= tab_1.Height - 120
idw_normal.Resize(li_dw_w, li_dw_h)

idw_sennap.Move(li_dw_x, li_dw_y)
idw_sennap.Resize(li_dw_w, li_dw_h)
idw_minap.Move(li_dw_x, li_dw_y)
idw_minap.Resize(li_dw_w, li_dw_h)
idw_move.Move(li_dw_x, li_dw_y)
idw_move.Resize(li_dw_w, li_dw_h)
end subroutine

public function integer wf_shift_highlight (datawindow adw_current, integer al_clickedrow);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: wf_shift_highlight
//
// Purpose:	This function will verify that there is a prior selected row and
//			then highlight all Rows between the two.  If there is no previously
//			selected row then it will highlight only the row clicked.  
//			This function will not unhighlight any other rows to allow for a 
//			mix of shift and Control key inter-mingling. 
//
//			The argument passed will be the currently clicked row.  This 
//			function will use the existing DataWindow and the instance variable
//			il_LastClickedRow to perform it's scrolling.		
//
// Scope: protected
//
// Arguments: adw_current - Current datawidnow
//				al_clickedrow - Current clicked row on datawindow
//		
// Returns: integer		the number of rows selected
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

integer		li_Idx
long			ll_count

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Check to make sure the row is valid
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If al_clickedrow <= 0 Then Return 0

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If there is no previous clicked row, then only select the row that was clicked
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If il_lastclicked[ii_index] = 0 Then
	adw_current.SelectRow (al_clickedrow, True)
	Return 1
End If

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Select all rows in between last clicked row and clicked row
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If il_lastclicked[ii_index] > al_clickedrow Then
	For li_Idx = il_lastclicked[ii_index] To al_clickedrow Step -1
		adw_current.selectrow (li_Idx, True)	
		ll_count++
	Next
Else
	For li_Idx = il_lastclicked[ii_index] To al_clickedrow
		adw_current.selectrow (li_Idx, True)	
		ll_count++
	Next	
End If

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Multiple rows are now selected in the DataWindow, so change its drag icon to the 
// multiple rows icon.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//adw_current.DragIcon = "rows.ico"

Return ll_count
end function

public subroutine wf_truck_dw_mousemove (unsignedlong flags, integer xpos, integer ypos);//   uo_status.st_message.text = string(ii_index)
If ib_truck_ldown And dw_truck.RowCount() > 0 then
	dw_truck.Drag (Begin!)
End If


end subroutine

public subroutine wf_return_buffer (datawindow adw_source);////////////////////////////////////////////////////////////////////////////////////////////
//																														//
//	Function Name	: wf_return_buffer																		//
//			Porpose	: 기존에 상차계획된 내용(상차계획 Datawindow)을 DragDrop 하여				//
//						  상차할 내용의 Datawindow(S/R내용의 DataWidow) 로 되 돌릴 경우 사용		//
//			Argument	: adw_source	- 상차계획 Datawindow												//
//			  return	: None																						//
////////////////////////////////////////////////////////////////////////////////////////////

graphicobject	lgo_focus
DataWindow		ldw_control
long		ll_selected_rows[], 	ll_selected_count, ll_rowcount, ll_i
long		ll_normal, ll_minap, ll_sennap, ll_move, ll_found, ll_sourcefind
string	ls_shipendgubun, ls_shipcount, ls_srno, ls_srgubun, ls_shipgubun, ls_find
integer	li_loadqty, li_dansuqty, li_rackqty, li_remainqty, li_shipendflag, li_truckorder, li_remainqty1

// 현재 Focus가 있는 control이 DataWindow가 아니라면
lgo_focus = GetFocus()
if TypeOf (lgo_focus) <> DataWindow! then
	return
else
	ldw_control = lgo_focus
end if

// 현재 DataWindow에 선택되어진 row 갯수를 결정한다.
ll_selected_count = f_sreturn_selected (ldw_control, ll_selected_rows)
if ll_selected_count = 0 then
	return
end if

// 선택된 row 갯수를 알아낸다.
ll_selected_count = f_sreturn_selected (adw_source, ll_selected_rows)
if ll_selected_count = 0 then return

adw_source.setredraw(False)

FOR ll_i = ll_selected_count TO 1 STEP -1
	li_truckorder = adw_source.GetitemNumber(ll_selected_rows[ll_i], "truckorder")
	//Truckorder 가 0 이면 아직 상차계획을 한 제품이 아니므로
	if li_truckorder <> 0 then
		ls_srno	= adw_source.GetitemString(ll_selected_rows[ll_i], "srno")		
		li_remainqty	= adw_source.GetitemNumber(ll_selected_rows[ll_i], "remainqty") 	
		li_remainqty1	= adw_source.GetitemNumber(ll_selected_rows[ll_i], "shipremainqty1")
		li_remainqty1	= adw_source.GetitemNumber(ll_selected_rows[ll_i], "ss")
		li_loadqty		= adw_source.GetitemNumber(ll_selected_rows[ll_i], "truckloadqty") 	
		li_shipendflag	= adw_source.GetitemNumber(ll_selected_rows[ll_i], "shipendflag") 	
		li_rackqty		= adw_source.GetitemNumber(ll_selected_rows[ll_i], "rackqty") 	
		ll_rowcount		= adw_source.rowcount()
		ls_find  = "srno = '" + ls_srno + "' and  Truckorder <> " + String(li_truckorder)
		ll_found = adw_source.Find(ls_find, 1, ll_rowcount)
//			
		if ll_found > 0 then //여러차량에 분할되어 상차되었다면, 선택된 row를 삭제한다.
			adw_source.RowsMove (ll_selected_rows[ll_i], ll_selected_rows[ll_i], &
									primary!, adw_source, adw_source.RowCount() + 1, delete!)
			adw_source.setredraw(true)
			return
		end if
		//잔량이 없이 모두 상차되었다면
		if li_remainqty1 = 0 then
			ls_find  = "srno = '" + ls_srno + "' and  Truckorder <> " + String(li_truckorder)
			ll_found = adw_source.Find(ls_find, 1, ll_rowcount)
			
//			if ll_found > 0 then //잔량없이 모두 상차되고, 여러차량에 분할되어 상차되었다면, 선택된 row를 삭제한다.
//				adw_source.RowsMove (ll_selected_rows[ll_i], ll_selected_rows[ll_i], &
//										primary!, adw_source, adw_source.RowCount() + 1, delete!)
//			else // 여러차량에 분할된 것이 아니라면 현재row 만을 0 으로  setting한다.
				adw_source.setitem(ll_selected_rows[ll_i], "Truckorder", 0)
				adw_source.setitem(ll_selected_rows[ll_i], "truckLoadqty", 0)
				adw_source.setitem(ll_selected_rows[ll_i], "truckDansuQty", 0)
//			end if
		Else //잔량이 남아 있다면
			ls_find  = "srno = '" + ls_srno + "' and  Truckorder <> " + String(li_truckorder)
			ll_found = adw_source.Find(ls_find, 1, ll_rowcount)
			if ll_found > 0 then //잔량이 남아 잇고 여러차에 분할되었다면
				li_loadqty = 0
				li_dansuqty = 0
				DO WHILE ll_found > 0 
					li_loadqty	= li_loadqty + adw_source.GetitemNumber(ll_found, "truckloadqty")
					li_dansuqty	= li_dansuqty + adw_source.GetitemNumber(ll_found, "truckdansuqty")
					If ll_found + 1 > ll_rowcount then
						Exit
					else
						ll_found 	= adw_source.Find(ls_find, ll_found + 1, ll_rowcount)
					end if
				LOOP
				adw_source.setitem(ll_selected_rows[ll_i], "Truckorder", 0)
				adw_source.setitem(ll_selected_rows[ll_i], "truckloadqty", 0)
				adw_source.setitem(ll_selected_rows[ll_i], "truckdansuqty", 0)

			Else//잔량이 남아 있고 여러 차에 분할 된것이 아니라면, 즉 한 차량에서 분할되었다면 
			adw_source.setitem(ll_selected_rows[ll_i], "Truckorder", 0)
			adw_source.setitem(ll_selected_rows[ll_i], "truckloadqty", 0)
			adw_source.setitem(ll_selected_rows[ll_i], "truckdansuqty", 0)
			End if
		End if
	End if
NEXT

adw_source.setredraw(true)

adw_source.SetFocus()
ll_rowcount = adw_source.RowCount()
adw_source.ScrollToRow(ll_selected_rows[ll_selected_count])
ib_change = true
//이명재막음
//cb_save.enabled = true

end subroutine

public subroutine wf_filter ();string ls_applyfrom
ls_applyfrom = trim(em_applyfrom.text)
setpointer(hourglass!)
tab_1.tabpage_1.dw_normal.setfilter('')
tab_1.tabpage_1.dw_normal.filter()
tab_1.tabpage_2.dw_minap.setfilter('')
tab_1.tabpage_2.dw_minap.filter()
tab_1.tabpage_3.dw_sennap.setfilter('')
tab_1.tabpage_3.dw_sennap.filter()
tab_1.tabpage_4.dw_move.setfilter('')
tab_1.tabpage_4.dw_move.filter()
tab_1.tabpage_1.dw_normal.SetRedraw(False)
tab_1.tabpage_2.dw_minap.SetRedraw(False)
tab_1.tabpage_3.dw_sennap.SetRedraw(False)
string ls_filter
integer li_count,i
i = 0
if is_modelid = '' or is_modelid = '' then
	is_modelid = '%'
end if	
ls_filter = ''
if is_modelid <> '%' then
   i = i + 1
   ls_filter = ls_filter + "ModelID = '" + is_modelid + "'"
end if
if is_checksrno <> '%' then
   i = i + 1
	if i > 1 then
		ls_filter = ls_filter + ' and '
	end if
   ls_filter = ls_filter + "checksrno = '" + is_checksrno + "'"
end if
if is_shipeditno <> '%' then
   i = i + 1
	if i > 1 then
		ls_filter = ls_filter + ' and '
	end if
   ls_filter = ls_filter + "shipeditno = " + is_shipeditno
end if
if is_custcode <> '%' then
   i = i + 1
	if i > 1 then
		ls_filter = ls_filter + ' and '
	end if
   ls_filter = ls_filter + "custcode = '" + is_custcode + "'"
end if
if is_shipoemgubun <> '%' then
   i = i + 1
	if i > 1 then
		ls_filter = ls_filter + ' and '
	end if
   ls_filter = ls_filter + "shipoemgubun = '" + is_shipoemgubun + "'"
end if
if ls_applyfrom = '' or isnull(ls_applyfrom) or (len(ls_applyfrom) = 4) then
else
   i = i + 1
	if i > 1 then
		ls_filter = ls_filter + ' and '
	end if
   ls_filter = ls_filter + "applyfrom = '" + ls_applyfrom + "'"
end if

//messagebox("",ls_filter)
tab_1.tabpage_1.dw_normal.setfilter(ls_filter)
tab_1.tabpage_2.dw_minap.setfilter(ls_filter)
tab_1.tabpage_3.dw_sennap.setfilter(ls_filter)
tab_1.tabpage_4.dw_move.setfilter(ls_filter)

tab_1.tabpage_1.dw_normal.filter()
tab_1.tabpage_2.dw_minap.filter()
tab_1.tabpage_3.dw_sennap.filter()
tab_1.tabpage_4.dw_move.filter()

//wf_ship_count()

tab_1.tabpage_1.dw_normal.SetRedraw(true)
tab_1.tabpage_2.dw_minap.SetRedraw(true)
tab_1.tabpage_3.dw_sennap.SetRedraw(true)
tab_1.tabpage_4.dw_move.SetRedraw(true)
setpointer(arrow!)
return

end subroutine

public subroutine wf_dw_doubleclicked (integer xpos, integer ypos, long row, dwobject dwo);If row > 0 Then
	TriggerEvent('ue_srview')
End If
end subroutine

public subroutine wf_dw_lmouse_down (unsignedlong flags, integer xpos, integer ypos);ib_ldown[ii_index] = True
end subroutine

public subroutine wf_dw_losefocus ();il_lastclicked[ii_index] = 0
end subroutine

protected subroutine wf_split (string fs_split, integer fi_truckorder, integer fi_loadqty, integer fi_dansuqty);////////////////////////////////////////////////////////////////////////////////////////////
//																														//
//	Function Name	: wf_split																					//
//			Porpose	: 기존에 상차계획된 내용(상차계획 Datawindow)중 수량을 트럭에 분할하여	//
//						  상차하는 경우 																			//
//			Argument	: fs_split 	- 분할 내용																	//
//			  			: fi_Truckorder- 기존 상차계획 Truck순번											//
//			  			: fi_loadqty 	- 기존 상차계획 Rack수량											//
//			  			: fi_dansuQty	- 기존 상차계획 짜투리수량											//
//			  return	: None																						//
////////////////////////////////////////////////////////////////////////////////////////////
long		ll_normal, ll_minap, ll_sennap, ll_move, ll_found, ll_sourcefind, ll_rowcount
integer	li_loadqty, li_dansuqty, li_rackqty, li_shipendflag, li_truckorder, li_remainqty, li_oldtruck
string	ls_find, ls_srno

li_TruckOrder	= integer(Trim(Mid(fs_split, 6, 5)))
li_loadqty		= integer(Trim(Mid(fs_split, 11, 5)))
li_dansuqty		= integer(Trim(Mid(fs_split, 16, 5)))

idw_current.Setredraw(false)

ll_rowcount 	= idw_current.rowcount()
ls_srno 	= idw_current.GetItemString(il_selected_clicked, 'srno')
li_remainqty	= idw_current.GetItemNumber(il_selected_clicked, 'shipremainqty1')
li_oldtruck		= idw_current.GetItemNumber(il_selected_clicked, 'truckorder')
li_rackqty		= idw_current.GetItemNumber(il_selected_clicked, 'rackqty')
//li_oldtruckorder = idw_current.GetItemNumber(il_selected_clicked, 'truckorder')

ls_find = "srno = '" + ls_srno + "' and  Truckorder = " + String(li_truckorder)
ll_found	= idw_current.find(ls_find, 1, ll_rowcount)

//만일 변경하고자 하는 트럭순번에 이미 같은 pcserialno의 제품이 상차계획되어 있다면

if ll_found > 0 then
	idw_current.setitem(ll_found, 'truckloadqty', idw_current.GetItemNumber(ll_found, 'truckloadqty') + fi_loadqty)
	idw_current.setitem(ll_found, 'truckdansuqty', idw_current.GetItemNumber(ll_found, 'truckdansuqty') + fi_dansuqty)
	idw_current.setitem(il_selected_clicked, 'truckloadqty', fi_loadqty - li_loadqty)
	idw_current.setitem(il_selected_clicked, 'truckdansuqty', fi_dansuqty - li_dansuqty)
else
	idw_current.rowscopy(il_selected_clicked, il_selected_clicked, Primary!, &
								idw_current, il_selected_clicked + 1, Primary!)
	if li_oldtruck = 0 then
		idw_current.setitem(il_selected_clicked, 'truckloadqty',  li_loadqty)
		idw_current.setitem(il_selected_clicked, 'truckdansuqty', li_dansuqty)
	else
		idw_current.setitem(il_selected_clicked, 'truckloadqty', (li_remainqty / li_rackqty) - li_loadqty)
		idw_current.setitem(il_selected_clicked, 'truckdansuqty', fi_dansuqty - li_dansuqty)
	end if
	idw_current.setitem(il_selected_clicked + 1, 'truckorder', li_truckorder)
	idw_current.setitem(il_selected_clicked + 1, 'truckloadqty', li_loadqty)
	idw_current.setitem(il_selected_clicked + 1, 'truckdansuqty', li_dansuqty)
end if
idw_current.Setredraw(true)
ib_change = true
//이명재막음
//cb_save.enabled = true


end subroutine

public subroutine wf_dw_lmouse_up (unsignedlong flags, integer xpos, integer ypos);ib_ldown[ii_index] = False

If ib_already_selected Then
	idw_current.TriggerEvent(Clicked!)
End If
end subroutine

public subroutine wf_truckloadview (integer xpos, integer ypos, long row, dwobject dwo);
//string ls_date, ls_truckorder, ls_parm, ls_size
////ls_date = f_pisc_get_date_applydate(is_date)
//ls_date = is_date
//If row > 0 Then
//	ls_size	= Left(String(WorkSpaceX()) + Space(10), 10)	+ &
//				  Left(String(WorkSpaceY()) + Space(10), 10)	+ &
//				  Left(String(WorkSpaceWidth()) + Space(10), 10) + &
//				  Left(String(WorkSpaceHeight()) + Space(10), 10)
//			  
//	ls_truckorder	= string(dw_truck.GetitemNumber(row, 'truck'))
//	ls_parm 			= Left(ls_date + Space(10), 10 ) + &
//						  Left(string(ls_truckorder) + Space(10), 10 ) + ls_size
////이명재막음					  
////	OpenWithParm(w_ipis_s_0120, ls_parm)
//end if
//
end subroutine

public subroutine wf_dw_mousemove (unsignedlong flags, integer xpos, integer ypos);//   uo_status.st_message.text = string(ii_index)
If ib_ldown[ii_index] And idw_current.RowCount() > 0 then

	idw_current.Drag (Begin!)
End If


end subroutine

public subroutine wf_truck_dw_lmouse_down (unsignedlong flags, integer xpos, integer ypos);ib_truck_ldown = True
end subroutine

public subroutine wf_truck_dw_lmouse_up (unsignedlong flags, integer xpos, integer ypos);ib_truck_ldown = False

If ib_truck_already_selected Then
	dw_truck.TriggerEvent(Clicked!)
End If
end subroutine

public subroutine wf_truck_return_buffer (integer fi_truckorder);////////////////////////////////////////////////////////////////////////////////////////////
//																														//
//	Function Name	: wf_truck_return_buffer	   														//
//			Porpose	: 기존에 상차계획된 내용(차량 Datawindow)을 DragDrop 하여				   //
//						  상차할 내용의 Datawindow(S/R내용의 DataWidow) 로 되 돌릴 경우 사용		//
//			Argument	: fi_truckorder	- 차량순번        												//
//			  return	: None																						//
////////////////////////////////////////////////////////////////////////////////////////////

graphicobject	lgo_focus
DataWindow		ldw_control
long ll_selected_rows[], 	ll_selected_count, ll_rowcount, ll_i
long ll_normal_count,ll_minap_count,ll_sennap_count,ll_move_count
long ll_normal, ll_minap, ll_sennap, ll_move, ll_found, ll_sourcefind
string	ls_shipendgubun, ls_shipcount, ls_srno, ls_srgubun, ls_shipgubun, ls_find
integer	li_loadqty, li_dansuqty, li_rackqty, li_remainqty, li_shipendflag, li_truckorder, li_remainqty1

// 현재 Focus가 있는 control이 DataWindow가 아니라면
lgo_focus = GetFocus()
if TypeOf (lgo_focus) <> DataWindow! then
	return
else
	ldw_control = lgo_focus
end if

// 정상,미납,선납,이체의 row 갯수를 구한다.
ll_normal_count = tab_1.tabpage_1.dw_normal.rowcount()
ll_minap_count = tab_1.tabpage_2.dw_minap.rowcount()
ll_sennap_count = tab_1.tabpage_3.dw_sennap.rowcount()
ll_move_count = tab_1.tabpage_4.dw_move.rowcount()
if ll_normal_count + ll_sennap_count + ll_minap_count + ll_move_count = 0 then
	return
end if


tab_1.tabpage_1.dw_normal.setredraw(False)

FOR ll_i = ll_normal_count TO 1 STEP -1
	li_truckorder = tab_1.tabpage_1.dw_normal.GetitemNumber(ll_i, "truckorder")
	//Truckorder 가 0 이면 아직 상차계획을 한 제품이 아니므로
	if li_truckorder = fi_truckorder then
		ls_srno	= tab_1.tabpage_1.dw_normal.GetitemString(ll_i, "srno")		
		li_remainqty	= tab_1.tabpage_1.dw_normal.GetitemNumber(ll_i, "remainqty") 	
		li_remainqty1	= tab_1.tabpage_1.dw_normal.GetitemNumber(ll_i, "shipremainqty1")
		li_loadqty		= tab_1.tabpage_1.dw_normal.GetitemNumber(ll_i, "truckloadqty") 	
		li_shipendflag	= tab_1.tabpage_1.dw_normal.GetitemNumber(ll_i, "shipendflag") 	
		li_rackqty		= tab_1.tabpage_1.dw_normal.GetitemNumber(ll_i, "rackqty") 	
		ll_rowcount		= tab_1.tabpage_1.dw_normal.rowcount()
		ls_find  = "srno = '" + ls_srno + "' and  Truckorder <> " + String(li_truckorder)
		ll_found = tab_1.tabpage_1.dw_normal.Find(ls_find, 1, ll_rowcount)
			
		if ll_found > 0 then //여러차량에 분할되어 상차되었다면 선택된 row를 삭제한다.
			tab_1.tabpage_1.dw_normal.RowsMove (ll_i, ll_i, &
										primary!, tab_1.tabpage_1.dw_normal, tab_1.tabpage_1.dw_normal.RowCount() + 1, delete!)
	   else 
			tab_1.tabpage_1.dw_normal.setitem(ll_i, "Truckorder", 0)
			tab_1.tabpage_1.dw_normal.setitem(ll_i, "truckLoadqty", 0)
			tab_1.tabpage_1.dw_normal.setitem(ll_i, "truckDansuQty", 0)
		end if
	End if
NEXT

tab_1.tabpage_1.dw_normal.setredraw(true)

tab_1.tabpage_2.dw_minap.setredraw(False)

FOR ll_i = ll_minap_count TO 1 STEP -1
	li_truckorder = tab_1.tabpage_2.dw_minap.GetitemNumber(ll_i, "truckorder")
	//Truckorder 가 0 이면 아직 상차계획을 한 제품이 아니므로
	if li_truckorder = fi_truckorder then
		ls_srno	= tab_1.tabpage_2.dw_minap.GetitemString(ll_i, "srno")		
		li_remainqty	= tab_1.tabpage_2.dw_minap.GetitemNumber(ll_i, "remainqty") 	
		li_remainqty1	= tab_1.tabpage_2.dw_minap.GetitemNumber(ll_i, "shipremainqty1")
		li_loadqty		= tab_1.tabpage_2.dw_minap.GetitemNumber(ll_i, "truckloadqty") 	
		li_shipendflag	= tab_1.tabpage_2.dw_minap.GetitemNumber(ll_i, "shipendflag") 	
		li_rackqty		= tab_1.tabpage_2.dw_minap.GetitemNumber(ll_i, "rackqty") 	
		ll_rowcount		= tab_1.tabpage_2.dw_minap.rowcount()
		ls_find  = "srno = '" + ls_srno + "' and  Truckorder <> " + String(li_truckorder)
		ll_found = tab_1.tabpage_2.dw_minap.Find(ls_find, 1, ll_rowcount)
			
		if ll_found > 0 then //여러차량에 분할되어 상차되었다면 선택된 row를 삭제한다.
			tab_1.tabpage_2.dw_minap.RowsMove (ll_i, ll_i, &
										primary!, tab_1.tabpage_2.dw_minap, tab_1.tabpage_2.dw_minap.RowCount() + 1, delete!)
	   else 
			tab_1.tabpage_2.dw_minap.setitem(ll_i, "Truckorder", 0)
			tab_1.tabpage_2.dw_minap.setitem(ll_i, "truckLoadqty", 0)
			tab_1.tabpage_2.dw_minap.setitem(ll_i, "truckDansuQty", 0)
		end if
	End if
NEXT

tab_1.tabpage_2.dw_minap.setredraw(true)

tab_1.tabpage_3.dw_sennap.setredraw(False)

FOR ll_i = ll_sennap_count TO 1 STEP -1
	li_truckorder = tab_1.tabpage_3.dw_sennap.GetitemNumber(ll_i, "truckorder")
	//Truckorder 가 0 이면 아직 상차계획을 한 제품이 아니므로
	if li_truckorder = fi_truckorder then
		ls_srno	= tab_1.tabpage_3.dw_sennap.GetitemString(ll_i, "srno")		
		li_remainqty	= tab_1.tabpage_3.dw_sennap.GetitemNumber(ll_i, "remainqty") 	
		li_remainqty1	= tab_1.tabpage_3.dw_sennap.GetitemNumber(ll_i, "shipremainqty1")
		li_loadqty		= tab_1.tabpage_3.dw_sennap.GetitemNumber(ll_i, "truckloadqty") 	
		li_shipendflag	= tab_1.tabpage_3.dw_sennap.GetitemNumber(ll_i, "shipendflag") 	
		li_rackqty		= tab_1.tabpage_3.dw_sennap.GetitemNumber(ll_i, "rackqty") 	
		ll_rowcount		= tab_1.tabpage_3.dw_sennap.rowcount()
		ls_find  = "srno = '" + ls_srno + "' and  Truckorder <> " + String(li_truckorder)
		ll_found = tab_1.tabpage_3.dw_sennap.Find(ls_find, 1, ll_rowcount)
			
		if ll_found > 0 then //여러차량에 분할되어 상차되었다면 선택된 row를 삭제한다.
			tab_1.tabpage_3.dw_sennap.RowsMove (ll_i, ll_i, &
										primary!, tab_1.tabpage_3.dw_sennap, tab_1.tabpage_3.dw_sennap.RowCount() + 1, delete!)
	   else 
			tab_1.tabpage_3.dw_sennap.setitem(ll_i, "Truckorder", 0)
			tab_1.tabpage_3.dw_sennap.setitem(ll_i, "truckLoadqty", 0)
			tab_1.tabpage_3.dw_sennap.setitem(ll_i, "truckDansuQty", 0)
		end if
	End if
NEXT

tab_1.tabpage_3.dw_sennap.setredraw(true)

tab_1.tabpage_4.dw_move.setredraw(False)

FOR ll_i = ll_move_count TO 1 STEP -1
	li_truckorder = tab_1.tabpage_4.dw_move.GetitemNumber(ll_i, "truckorder")
	//Truckorder 가 0 이면 아직 상차계획을 한 제품이 아니므로
	if li_truckorder = fi_truckorder then
		ls_srno	= tab_1.tabpage_4.dw_move.GetitemString(ll_i, "srno")		
		li_remainqty	= tab_1.tabpage_4.dw_move.GetitemNumber(ll_i, "remainqty") 	
		li_remainqty1	= tab_1.tabpage_4.dw_move.GetitemNumber(ll_i, "shipremainqty1")
		li_loadqty		= tab_1.tabpage_4.dw_move.GetitemNumber(ll_i, "truckloadqty") 	
		li_shipendflag	= tab_1.tabpage_4.dw_move.GetitemNumber(ll_i, "shipendflag") 	
		li_rackqty		= tab_1.tabpage_4.dw_move.GetitemNumber(ll_i, "rackqty") 	
		ll_rowcount		= tab_1.tabpage_4.dw_move.rowcount()
		ls_find  = "srno = '" + ls_srno + "' and  Truckorder <> " + String(li_truckorder)
		ll_found = tab_1.tabpage_4.dw_move.Find(ls_find, 1, ll_rowcount)
			
		if ll_found > 0 then //여러차량에 분할되어 상차되었다면 선택된 row를 삭제한다.
			tab_1.tabpage_4.dw_move.RowsMove (ll_i, ll_i, &
										primary!, tab_1.tabpage_4.dw_move, tab_1.tabpage_4.dw_move.RowCount() + 1, delete!)
	   else 
			tab_1.tabpage_4.dw_move.setitem(ll_i, "Truckorder", 0)
			tab_1.tabpage_4.dw_move.setitem(ll_i, "truckLoadqty", 0)
			tab_1.tabpage_4.dw_move.setitem(ll_i, "truckDansuQty", 0)
		end if
	End if
NEXT

tab_1.tabpage_4.dw_move.setredraw(true)

//adw_source.SetFocus()
//ll_rowcount = adw_source.RowCount()
//adw_source.ScrollToRow(ll_selected_rows[ll_selected_count])
ib_change = true

end subroutine

public subroutine wf_truck_dw_clicked (integer xpos, integer ypos, long row, dwobject dwo);long	ll_clicked
uo_status.st_message.text = '차량 click'
If row <= 0 Then 
	Return 
end if

// Click한 row가 선택되어 있지 않고 현재 Row라면
If dw_truck.GetSelectedRow (row - 1) = row And ib_truck_already_selected = False Then
	ib_truck_already_selected = True
	il_truck_selected_clicked = row
Else //
	If ib_truck_already_selected then
		ll_clicked = il_truck_selected_clicked
	Else
		ll_clicked = row
	End If
	// Shift Key를 누른상태에서 선택되어진 row를 Click 하였다면
//	If Keydown (KeyShift!) And Not ib_already_selected Then
//		wf_shift_highlight (dw_truck, ll_clicked)
//	Else
		dw_truck.SelectRow (0, false)
		dw_truck.SelectRow (ll_clicked, true)
//		idw_current.DragIcon = "row.ico"
//	End If

	ib_truck_already_selected = false
//	il_lastclicked[ii_index] = ll_clicked
	il_truck_selected_clicked = row
End if
uo_status.st_message.text = '차량 click end'
end subroutine

public subroutine wf_change_buffer (datawindow adw_source, integer fi_truckorder);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: wf_change_buffer
//
// Purpose: 상차 계획을 세우기 위해 트럭의 Ico으로 DragDrop 하면
//				실행된다.
//
// Scope: protected
//
// Arguments: 	adw_source		상차할 DataWidow(S/R의 Data)
//			   	adw_target		상차계획된 DataWindow (상차계획 table의 Data)
//					fi_truckorder  상차할 Truck의 순번
// Returns: 	none
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long		ll_selected_rows[], 	ll_selected_count, 	ll_rowcount, ll_i, ll_find, ll_targetrow
long  	li_remainqty, li_rackqty, li_loadqty, li_shipplanqty, li_dansuqty, li_load, li_truckorder, li_remainqty1
string	ls_srno, ls_find, ls_shipgubun
string   ls_divisioncode,ls_itemcode,ls_itemclass,ls_itembuysource
// 선택된 row 갯수를 알아낸다.

ll_selected_count = f_sreturn_selected (adw_source, ll_selected_rows)
if ll_selected_count = 0 then return

adw_source.setredraw(False)
if adw_source = dw_truck then
	return
end if
	
//
//IF adw_source = idw_sennap Then
//	ls_shipgubun = 'S'
//Elseif adw_source = idw_minap Then
//	ls_shipgubun = 'M' 
//Elseif adw_source = idw_normal then 
//	ls_shipgubun = 'N'
//End if
//if adw_target = dw_load_plan then

FOR ll_i = ll_selected_count TO 1 STEP -1
	li_truckorder   = adw_source.getitemnumber(ll_selected_rows[ll_i], "truckorder") 
	// 이동 된 트럭번호가 다르거나 truck 순번이 0(처음 상차하는 경우) 즉, 상차할 트럭순번을 바꾸었다면
//	if (li_truckorder <> fi_truckorder) or (li_truckorder = 0) then
	if li_truckorder = 0 then		
		ls_divisioncode = adw_source.getitemstring(ll_selected_rows[ll_i], "divisioncode")
		ls_itemcode     = adw_source.getitemstring(ll_selected_rows[ll_i], "itemcode")
		select top 1 itemclass,itembuysource
		  into :ls_itemclass,:ls_itembuysource
		  from tmstmodel
		 where areacode = :is_areacode
		   and divisioncode = :ls_divisioncode
			and itemcode     = :ls_itemcode
			using sqlpis;
		if ls_itemclass ='' or isnull(ls_itemclass) then
			ls_itemclass = ''
		end if
		if ls_itembuysource ='' or isnull(ls_itembuysource) then
			ls_itembuysource = ''
		end if
		if ls_itemclass = '10' and (ls_itembuysource = '05' or ls_itembuysource = '06' ) then
			messagebox("확인",ls_itemcode + '는 출하할 수 없는 품번입니다.')
		else
			li_shipplanqty = adw_source.getitemnumber(ll_selected_rows[ll_i], "shipendflag") 
			ls_srno	      = adw_source.getitemstring(ll_selected_rows[ll_i], "srno") 
			li_remainqty 	= adw_source.getitemNumber(ll_selected_rows[ll_i], "RemainQty")
			li_remainqty1 	= adw_source.getitemNumber(ll_selected_rows[ll_i], "shipRemainQty1")
			li_loadqty	 	= adw_source.getitemNumber(ll_selected_rows[ll_i], "truckLoadQty")	
			li_dansuqty	 	= adw_source.getitemNumber(ll_selected_rows[ll_i], "truckDansuQty")							
			li_rackqty	 	= adw_source.getitemNumber(ll_selected_rows[ll_i], "RackQty")				
			if isnull(li_rackqty) or li_rackqty = 0 then
				li_rackqty = 9999999
			end if
			li_load		 = li_remainqty / li_rackqty
			IF li_remainqty = li_remainqty1 Then 	// 출하잔량이 요구량과 같은 경우 즉, 상차계획이 한개도 세워지지 않은 경우
				adw_source.SetItem(ll_selected_rows[ll_i], "truckorder", fi_truckorder)
				adw_source.SetItem(ll_selected_rows[ll_i], "truckloadqty", li_load)
				adw_source.SetItem(ll_selected_rows[ll_i], "truckDansuQty", li_remainqty - (li_load * li_rackqty))
	
			else //출하잔량이 요구량과 다른 경우 즉, 여러 차량에 상차되어진 경우
				ls_find = "SRNo = '" + ls_srno + "' and  Truckorder = " + String(fi_truckorder)
				ll_find = adw_source.find(ls_find, 1, adw_source.RowCount())
				
				IF ll_find > 0	Then //Drop Drap 한 차량에 같은 serial이 있다면
					adw_source.SetItem(ll_selected_rows[ll_i], "truckorder", fi_truckorder)
					adw_source.SetItem(ll_selected_rows[ll_i], "truckloadqty", &
									(li_shipplanqty / li_rackqty) + adw_source.GetItemNumber(ll_find, "truckloadqty") )
					adw_source.SetItem(ll_selected_rows[ll_i], "truckDansuQty", &
									(li_shipplanqty - (truncate((li_shipplanqty / li_rackqty), 0) * li_rackqty)) + adw_source.GetitemNumber(ll_find, "trcukdansuqty") )
					adw_source.RowsMove (ll_find, ll_find, primary!, adw_source, adw_source.RowCount() + 1, delete!)
						
				Else //Drop Drap 한 차량에 같은 serial이 없다면 트럭 번호만 바꾼다.
						adw_source.SetItem(ll_selected_rows[ll_i], "truckorder", fi_truckorder)				
				End if
			End if
		end if
	End if
	
NEXT
//end if

//For ll_i = 1 To dw_load_plan.Rowcount()							
//	adw_target.SetItem(ll_i, "ShipCount", is_shipcount)		
//Next

adw_source.setredraw(True)
adw_source.SetFocus()
adw_source.ScrollToRow(ll_selected_rows[1])
ib_change = true
//이명재 막음
//cb_save.enabled = true


end subroutine

public subroutine wf_ship_count ();//long		li_shipqty = 0, li_invqty = 0, li_minapqty = 0, li_count = 0, li_index_exist = 0
//String	ls_modelcode
//setpointer(hourglass!)
//Select Sum(a.ShipRemainQty) 
//  Into :li_shipqty
//  From tsrorder a,vmstmodel b
// Where a.shipendgubun  = 'N'
//   And a.SRCancelGubun = 'N'
//   and a.ApplyFrom	  = :is_date
//   and a.areacode      *= b.areacode
//	and a.divisioncode  *= b.divisioncode
//	and a.custcode      like :is_custcode
//	and a.shipeditno    like :is_shipeditno
//	and a.itemcode      *= b.itemcode
//   And b.modelid		  =  :is_modelid
//	AND a.checksrno     like :is_checksrno
//	and a.shipgubun     <> 'M'
//	and (a.kitgubun     = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
//	and SRAreaCode      = :is_areacode
//	and SRDivisionCode  like :is_divisioncode
//	and a.stcd = 'Y'
// using sqlpis;
//
////st_shipqty.text	= String(li_shipqty,		'##,##0')
//st_shipqty.text	= String(li_shipqty,'#,##0')
//Select Sum(a.ShipRemainQty) 
//  Into :li_minapqty
//  From tsrorder a,vmstmodel b
// Where a.shipendgubun  = 'N'
//   And a.SRCancelGubun = 'N'
//   and a.ApplyFrom	  < :is_date
//   and a.areacode      *= b.areacode
//	and a.divisioncode  *= b.divisioncode
//	and a.itemcode      *= b.itemcode
//	and a.custcode      like :is_custcode
//	and a.shipeditno    like :is_shipeditno
//   And b.modelid		  =    :is_modelid
//	and a.checksrno     like :is_checksrno
//	and a.shipgubun     <> 'M'
//	and (a.kitgubun     = 'N' or (a.kitgubun = 'Y' and a.pcgubun = 'P'))
//	and SRAreaCode      = :is_areacode
//	and SRDivisionCode  like :is_divisioncode
// using sqlpis;
//
//st_minapqty.text	= String(li_minapqty,'#,##0')
//
//Select Sum(Invqty + repairqty)
//  Into :li_invQty
//  From tinv
// Where Itemcode	=  :is_modelid
//	and AreaCode   =  :is_areacode
//	and divisionCode like :is_divisioncode
//	using sqlpis;
//
//st_invqty.text		= String(li_invqty,'#,##0')
//setpointer(arrow!)
Return
end subroutine

public subroutine wf_dw_clicked (integer xpos, integer ypos, long row, dwobject dwo);long	ll_clicked,ln_invqty
string ls_itemcode

If row <= 0 Then 
	st_invqty.text = ''
	Return
end if

ls_itemcode = idw_current.object.itemcode[row]

select isnull(invqty,0) into :ln_invqty from tinv
	where areacode = :is_Areacode and divisioncode = :is_divisioncode
		and	itemcode = :ls_itemcode
using sqlpis ;

st_invqty.text = string(ln_invqty,"#,###,###")

// Click한 row가 선택되어 있지 않고 현재 Row라면
If idw_current.GetSelectedRow (row - 1) = row And ib_already_selected = False Then
	ib_already_selected = True
	il_selected_clicked = row
Else 
	If ib_already_selected then
		ll_clicked = il_selected_clicked
	Else
		ll_clicked = row
	End If
	If Keydown (KeyShift!)  Then
		wf_shift_highlight (idw_current, ll_clicked)
	ElseIf Keydown (KeyControl!)  Then
		if idw_current.IsSelected(ll_clicked) Then
			idw_current.SelectRow(ll_clicked,FALSE)
		else
			idw_current.SelectRow(ll_clicked,TRUE)
		end if
	Else
		idw_current.SelectRow (0, false)
		idw_current.SelectRow (ll_clicked, true)
	End If

	ib_already_selected = false
	il_lastclicked[ii_index] = ll_clicked
	il_selected_clicked = row
End if
end subroutine

public function boolean wf_update_loadplan ();uo_status.st_message.text = 'tloadplan delete 중(wf_update_tloadplan)'	
long   	ll_truckorder, ll_loadqty, ll_dansuqty,ll_truckplan
Long		i, ll_rowcount,ll_shipeditno,ll_count
string	ls_srno, ls_custcode, ls_srgubun, ls_itemcode,ls_divisioncode,ls_shipgubun,ls_kitgubun,ls_custname,ls_truckmodifyflag
string   ls_modicheck
boolean	lb_commit = True
//is_date = f_pisc_get_date_applyday()
ll_count = dw_truck.rowcount()
lb_commit = true
for i = 1 to ll_count step 1
	ll_truckorder = long(dw_truck.object.truck[i])
	ls_modicheck  = dw_truck.object.modicheck[i]
	if ls_modicheck = 'Y' then
		Delete tloadplan
		 where shipplandate = :is_date 
			and truckno is Null
			and areacode     = :is_areacode
			and divisioncode like :is_divisioncode
			and truckorder = :ll_truckorder
			using sqlpis;
	//	
		Delete tloadplanhis
		 where shipplandate = :is_date 
			and truckno is Null
			and areacode     = :is_areacode
			and divisioncode like :is_divisioncode
			and truckorder = :ll_truckorder		
			using sqlpis;
	end if
next
uo_status.st_message.text = 'tloadplan delete 완료(wf_update_tloadplan)'	
//
//If sqlpis.sqlcode = 0 Then
	// 정상 출하 상차 계획 저장
	idw_normal.SetFilter('TruckOrder > 0')
	idw_normal.Filter()
	uo_status.st_message.text = 'tloadplan 정상 저장 중(wf_update_tloadplan)'	
	ll_rowcount	= idw_normal.RowCount()
	If ll_rowcount > 0 Then
		For i = 1 To ll_rowcount
			ls_divisioncode = idw_normal.GetItemString(i, 'divisioncode')
			ls_srno = idw_normal.GetItemString(i, 'srno')
			ll_truckorder = idw_normal.GetItemNumber(i, 'truckorder')
			ls_shipgubun  = idw_normal.GetItemString(i, 'shipgubun')
			ls_custcode   = idw_normal.GetItemString(i, 'custcode')
			ll_shipeditno = idw_normal.GetItemNumber(i, 'shipeditno')
			ls_srgubun	  = idw_normal.GetItemString(i, 'srgubun')			
			ls_itemcode   = idw_normal.GetItemString(i, 'itemcode')			
			ll_truckplan  = idw_normal.GetItemNumber(i, 'truckplan')
			ll_loadqty	  = idw_normal.GetItemNumber(i, 'truckloadqty')
			ll_dansuqty	  = idw_normal.GetItemNumber(i,'truckdansuqty')
         ls_kitgubun   = idw_normal.GetItemString(i,'kitgubun')
			ls_truckmodifyflag = idw_normal.GetItemString(i,'truckmodifyflag')
			INSERT INTO tloadplan (shipplandate,areacode,divisioncode,srno,truckorder,itemcode,custcode,shipeditno,
						applyfrom,Truckno, truckloadqty, truckdansuqty,truckmodifyflag, lastemp, lastdate)
			VALUES ( :is_date,:is_areacode,:ls_divisioncode,:ls_srno,:ll_truckorder,:ls_itemcode,:ls_custcode,:ll_shipeditno,
					  :is_date,Null,:ll_truckplan,0,:ls_truckmodifyflag,:g_s_empno,GetDate())
					  using sqlpis;
				
			If sqlpis.sqlcode <> 0 Then
//				SQLPIS.AUTOCOMMIT = TRUE
//				messagebox("",'tlaodplan 정상 error : ' +sqlpis.sqlerrtext)
            uo_status.st_message.text = 'tlaodplan 정상 저장 error : ' +sqlpis.sqlerrtext
				lb_commit = False
				exit
			End if			
			INSERT INTO TLOADPLANHIS  
                   ( ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,TruckNo,ShipDate,ShipGubun,ItemCode,CustCode,   
                     ShipEditNo,ApplyFrom,TruckLoadQty,TruckDansuQty,TruckModifyFlag,ShipConfirmFlag,ShipCancelFlag,   
                     ShipScanTime,LastEmp,LastDate)  
            VALUES ( :is_date,:is_areacode,:ls_divisioncode,:ls_srno,:ll_truckorder,null,null,:ls_shipgubun,   
                     :ls_itemcode,:ls_custcode,:ll_shipeditno,:is_date,:ll_truckplan,0,:ls_truckmodifyflag,'N','N',null,
                     :g_s_empno,getdate())
				using sqlpis;

			If sqlpis.sqlcode <> 0 Then
            uo_status.st_message.text = 'tlaodplanhis 정상 저장 error : ' +sqlpis.sqlerrtext
				lb_commit = False
				exit
			End if			
			if ls_kitgubun = 'Y' then //KIT제품은 자품번도 tloadplan에 저장
			   if not wf_update_tloadplan_child(is_date,ll_truckorder,ls_srno,is_areacode,ls_divisioncode,ll_truckplan,ls_truckmodifyflag) then
//				   SQLPIS.AUTOCOMMIT = TRUE					
//					messagebox("",'tlaodplanhis 자품번 error : ' +sqlpis.sqlerrtext)
               uo_status.st_message.text = 'tlaodplan_child 정상 저장 error : ' +sqlpis.sqlerrtext
					lb_commit = False
					exit
				end if
			end if
		Next
	End If
   IF lb_commit = false then
		return lb_commit
	end if
   
	// 미납 출하 상차 계획 저장
	ll_rowcount = 0
	idw_minap.SetFilter('TruckOrder > 0')
	idw_minap.Filter()
	
	ll_rowcount	= idw_minap.RowCount()
	If ll_rowcount > 0 Then
		For i = 1 To ll_rowcount
			ls_divisioncode = idw_minap.GetItemString(i, 'divisioncode')
			ls_srno = idw_minap.GetItemString(i, 'srno')
			ll_truckorder = idw_minap.GetItemNumber(i, 'truckorder')
			ls_custcode   = idw_minap.GetItemString(i, 'custcode')
			ls_shipgubun  = idw_minap.GetItemString(i, 'shipgubun')
			ll_shipeditno = idw_minap.GetItemnumber(i, 'shipeditno')
			ls_srgubun	  = idw_minap.GetItemString(i, 'srgubun')			
			ls_itemcode   = idw_minap.GetItemString(i, 'itemcode')			
			ll_truckplan  = idw_minap.GetItemNumber(i, 'truckplan')			
			ll_loadqty	  = idw_minap.GetItemNumber(i, 'truckloadqty')
			ll_dansuqty	  = idw_minap.GetItemNumber(i, 'truckdansuqty')
			ls_kitgubun	  = idw_minap.GetItemString(i, 'kitgubun')
			ls_truckmodifyflag = idw_minap.GetItemString(i,'truckmodifyflag')			
			INSERT INTO tloadplan (areacode,divisioncode,srno, truckorder,itemcode, custcode, shipplandate, shipeditno,
						applyfrom,Truckno,truckloadqty, truckdansuqty,truckmodifyflag, lastemp, lastdate)
			VALUES (:is_areacode,:ls_divisioncode,:ls_srno, :ll_truckorder,:ls_itemcode, :ls_custcode, :is_date, :ll_shipeditno,
					:is_date,Null,:ll_truckplan,0,:ls_truckmodifyflag,:g_s_empno, GetDate())
			using sqlpis;
							  
			If sqlpis.sqlcode <> 0 Then
            uo_status.st_message.text = 'tlaodplan 미납 저장 error : ' +sqlpis.sqlerrtext
				lb_commit = False
				exit
			End if			
			INSERT INTO TLOADPLANHIS  
                   ( ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,TruckNo,ShipDate,ShipGubun,ItemCode,CustCode,   
                     ShipEditNo,ApplyFrom,TruckLoadQty,TruckDansuQty,TruckModifyFlag,ShipConfirmFlag,ShipCancelFlag,   
                     ShipScanTime,LastEmp,LastDate)  
            VALUES ( :is_date,:is_areacode,:ls_divisioncode,:ls_srno,:ll_truckorder,null,null,:ls_shipgubun,   
                     :ls_itemcode,:ls_custcode,:ll_shipeditno,:is_date,:ll_truckplan,0,:ls_truckmodifyflag,'N','N',null,
                     :g_s_empno,getdate()) using sqlpis;

			If sqlpis.sqlcode <> 0 Then
            uo_status.st_message.text = 'tlaodplanhis 미납 저장 error : ' +sqlpis.sqlerrtext
				lb_commit = False
            exit
			End if			
			if ls_kitgubun = 'Y' then //KIT제품은 자품번도 tloadplan에 저장
			   if not wf_update_tloadplan_child(is_date,ll_truckorder,ls_srno,is_areacode,ls_divisioncode,ll_truckplan,ls_truckmodifyflag) then
               uo_status.st_message.text = 'tlaodplanchild 미납 저장 error : ' +sqlpis.sqlerrtext
					lb_commit = False
               exit
				end if
			end if
		Next
	End If
   IF lb_commit = false then
		return lb_commit
	end if

	// 선납 출하 상차 계획 저장
	ll_rowcount = 0
	idw_sennap.SetFilter('TruckOrder > 0')
	idw_sennap.Filter()
	
	ll_rowcount	= idw_sennap.RowCount()
	If ll_rowcount > 0 Then
		For i = 1 To ll_rowcount
         ls_divisioncode = idw_sennap.GetItemString(i, 'divisioncode')
			ls_srno = idw_sennap.GetItemString(i, 'srno')
			ll_truckorder = idw_sennap.GetItemNumber(i, 'truckorder')
			ls_custcode   = idw_sennap.GetItemString(i, 'custcode')
			ls_shipgubun  = idw_sennap.GetItemString(i, 'shipgubun')
			ll_shipeditno = idw_sennap.GetItemNumber(i, 'shipeditno')
			ls_srgubun	  = idw_sennap.GetItemString(i, 'srgubun')			
			ls_itemcode   = idw_sennap.GetItemString(i, 'itemcode')			
			ll_loadqty	  = idw_sennap.GetItemNumber(i, 'truckloadqty')
			ll_truckplan  = idw_sennap.GetItemNumber(i, 'truckplan')			
			ll_dansuqty	  = idw_sennap.GetItemNumber(i, 'truckdansuqty')
			ls_kitgubun	  = idw_sennap.GetItemString(i, 'kitgubun')
			ls_truckmodifyflag = idw_sennap.GetItemString(i,'truckmodifyflag')			
			INSERT INTO tloadplan (areacode,divisioncode,srno, truckorder, itemcode, custcode, shipplandate, shipeditno,
						applyfrom,Truckno,truckloadqty, truckdansuqty,truckmodifyflag, lastemp, lastdate)
			VALUES (:is_areacode,:ls_divisioncode,:ls_srno, :ll_truckorder,:ls_itemcode, :ls_custcode, :is_date, :ll_shipeditno,
					  :is_date,Null, :ll_truckplan,0,:ls_truckmodifyflag,:g_s_empno, GetDate())
					  using sqlpis;			

			If sqlpis.sqlcode <> 0 Then
            uo_status.st_message.text = 'tlaodplan 선납 저장 error : ' +sqlpis.sqlerrtext				
				lb_commit = false
				exit
			End if			
			INSERT INTO TLOADPLANHIS  
                   ( ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,TruckNo,ShipDate,ShipGubun,ItemCode,CustCode,   
                     ShipEditNo,ApplyFrom,TruckLoadQty,TruckDansuQty,TruckModifyFlag,ShipConfirmFlag,ShipCancelFlag,   
                     ShipScanTime,LastEmp,LastDate)  
            VALUES ( :is_date,:is_areacode,:ls_divisioncode,:ls_srno,:ll_truckorder,null,null,:ls_shipgubun,   
                     :ls_itemcode,:ls_custcode,:ll_shipeditno,:is_date,:ll_truckplan,0,:ls_truckmodifyflag,'N','N',null,
                     :g_s_empno,getdate()) using sqlpis;

			If sqlpis.sqlcode <> 0 Then
            uo_status.st_message.text = 'tlaodplanhis 선납 저장 error : ' +sqlpis.sqlerrtext
				lb_commit = False
				exit
			End if			
			if ls_kitgubun = 'Y' then //KIT제품은 자품번도 tloadplan에 저장
			   if not wf_update_tloadplan_child(is_date,ll_truckorder,ls_srno,is_areacode,ls_divisioncode,ll_truckplan,ls_truckmodifyflag) then
               uo_status.st_message.text = 'tlaodplan_child 선납 저장 error : ' +sqlpis.sqlerrtext
					lb_commit = False
					exit
				end if
			end if
		Next
	End If
   IF lb_commit = false then
		return lb_commit
	end if

	// 이체 출하 상차 계획 저장
	ll_rowcount = 0
	idw_move.SetFilter('TruckOrder > 0')
	idw_move.Filter()
	
	ll_rowcount	= idw_move.RowCount()
	If ll_rowcount > 0 Then
		For i = 1 To ll_rowcount
			ls_divisioncode  = idw_move.GetItemString(i,'divisioncode')  //불출공장
			ls_custname   = idw_move.getitemstring(i,'custname')  //의뢰지역
			ls_custcode   = idw_move.getitemstring(i,'custcode')  //의뢰공장
			ls_srno       = idw_move.GetItemString(i, 'srno')
			ll_truckorder = idw_move.GetItemNumber(i, 'truckorder')
         ls_custcode   = ls_custname + ls_custcode
			ls_shipgubun  = idw_move.GetItemString(i, 'shipgubun')
			ll_shipeditno = idw_move.GetItemnumber(i, 'shipeditno')
			ls_srgubun	  = idw_move.GetItemString(i, 'srgubun')			
			ls_itemcode   = idw_move.GetItemString(i, 'itemcode')			
			ll_loadqty	  = idw_move.GetItemNumber(i, 'truckloadqty')
			ll_truckplan  = idw_move.GetItemNumber(i,'truckplan')
			ll_dansuqty	  = idw_move.GetItemNumber(i, 'truckdansuqty')
			ls_kitgubun	  = idw_move.GetItemString(i, 'kitgubun')
			ls_truckmodifyflag = idw_move.GetItemString(i,'truckmodifyflag')				
			INSERT INTO tloadplan (areacode,divisioncode,srno, truckorder, itemcode,custcode, shipplandate, shipeditno,
						applyfrom,Truckno, truckloadqty, truckdansuqty,truckmodifyflag, lastemp, lastdate)
			VALUES (:is_areacode,:ls_divisioncode,:ls_srno, :ll_truckorder, :ls_itemcode,:ls_custcode, :is_date, :ll_shipeditno,
					  :is_date,Null, :ll_truckplan,0,:ls_truckmodifyflag,:g_s_empno,GetDate())
					  using sqlpis;			
	
			If sqlpis.sqlcode <> 0 Then
            uo_status.st_message.text = 'tlaodplan 이체 저장 error : ' +sqlpis.sqlerrtext
				lb_commit = False
				exit
			End if			
			if ls_kitgubun = 'Y' then //KIT제품은 자품번도 tloadplan에 저장
			   if not wf_update_tloadplan_child(is_date,ll_truckorder,ls_srno,is_areacode,ls_divisioncode,ll_truckplan,ls_truckmodifyflag) then
               uo_status.st_message.text = 'tlaodplan_child 이체 저장 error : ' +sqlpis.sqlerrtext
					lb_commit = False
					exit
				end if
			end if

			INSERT INTO TLOADPLANHIS  
                   ( ShipPlanDate,AreaCode,DivisionCode,SRNo,TruckOrder,TruckNo,ShipDate,ShipGubun,ItemCode,CustCode,   
                     ShipEditNo,ApplyFrom,TruckLoadQty,TruckDansuQty,TruckModifyFlag,ShipConfirmFlag,ShipCancelFlag,   
                     ShipScanTime,LastEmp,LastDate)  
            VALUES ( :is_date,:is_areacode,:ls_divisioncode,:ls_srno,:ll_truckorder,null,null,:ls_shipgubun,   
                     :ls_itemcode,:ls_custcode,:ll_shipeditno,:is_date,:ll_truckplan,0,:ls_truckmodifyflag,'N','N',null,
                     :g_s_empno,getdate()) using sqlpis;

			If sqlpis.sqlcode <> 0 Then
            uo_status.st_message.text = 'tlaodplanhis 이체 저장 error : ' +sqlpis.sqlerrtext
				lb_commit = False
				exit
			End if			
		Next
	End If
//	return false
//Else
//	Return False
//End If
wf_filter()
Return lb_commit
end function

public function boolean wf_update_tloadplan_child (string fs_shipplandate, long fl_truckorder, string fs_srno, string fs_areacode, string fs_divisioncode, long fl_truckplan, string fs_truckmodifyflag);long ll_parent_qty,ll_child_qty,ll_count,ll_shipeditno,ll_cnt
string ls_srno,ls_itemcode,ls_custcode,ls_shipgubun
boolean lb_commit
//lb_commit = TRUE
select shiporderqty
  into :ll_parent_qty
  from tsrorder
 where areacode = :fs_areacode
   and divisioncode = :fs_divisioncode
	and srno = :fs_srno
	using sqlpis;

DECLARE tsroder_cur CURSOR FOR
 SELECT srno,shiporderqty,itemcode,shipeditno,custcode,shipgubun
	FROM tsrorder
  WHERE areacode = :fs_areacode
    and divisioncode = :fs_divisioncode
	 and psrno   = :fs_srno
	 and pcgubun = 'C'
	 using sqlpis;
open tsroder_cur;	 
fetch tsroder_cur into :ls_srno,:ll_child_qty,:ls_itemcode,:ll_shipeditno,:ls_custcode,:ls_shipgubun;

DO WHILE sqlpis.sqlcode <> 100 
	ll_count = ll_child_qty / ll_parent_qty 
	ll_child_qty = fl_truckplan * ll_count
	ll_cnt = ll_cnt + 1
   INSERT INTO TLOADPLAN  
         ( ShipPlanDate,   
           AreaCode,   
           DivisionCode,   
           SRNo,   
           TruckOrder,   
           TruckNo,   
           ItemCode,   
           CustCode,   
           ShipEditNo,   
           ApplyFrom,   
           TruckLoadQty,   
           TruckDansuQty,   
           TruckModifyFlag,   
           LastEmp,   
           LastDate )  
   VALUES (:fs_shipplandate,   
           :fs_areacode,   
           :fs_divisioncode,   
           :ls_srno,   
           :fl_truckorder,   
           null,   
           :ls_itemcode,   
           :ls_custcode,   
           :ll_shipeditno,   
           :fs_shipplandate,   
           :ll_child_qty,   
           0,   
           :fs_truckmodifyflag,   
           :g_s_empno,   
           getdate() )
			  using sqlpis;
	if sqlpis.sqlcode <> 0 then
		lb_commit = false
		exit
   else
		lb_commit = true
	end if
   INSERT INTO TLOADPLANHIS  
         ( ShipPlanDate,   
           AreaCode,   
           DivisionCode,   
           SRNo,   
           TruckOrder,   
           TruckNo,   
           ShipDate,   
           ShipGubun,   
           ItemCode,   
           CustCode,   
           ShipEditNo,   
           ApplyFrom,   
           TruckLoadQty,   
           TruckDansuQty,   
           TruckModifyFlag,   
           ShipConfirmFlag,   
           ShipCancelFlag,   
           ShipScanTime,   
           LastEmp,   
           LastDate )  
   VALUES ( :fs_shipplandate,   
           :fs_areacode,   
           :fs_divisioncode,   
           :ls_srno,   
           :fl_truckorder,   
           null,   
           null,   
           :ls_shipgubun,   
           :ls_itemcode,   
           :ls_custcode,   
           :ll_shipeditno,   
           :fs_shipplandate,   
           :ll_child_qty,   
           0,   
           :fs_truckmodifyflag,      
           'N',   
           'N',   
           null,   
           :g_s_empno,   
           getdate() )
			  USING SQLPIS;
	if sqlpis.sqlcode <> 0 then
		lb_commit = false
		exit
   else
		lb_commit = true
	end if

   fetch tsroder_cur into :ls_srno,:ll_child_qty,:ls_itemcode,:ll_shipeditno,:ls_custcode,:ls_shipgubun;

LOOP
close tsroder_cur;	 

if ll_cnt = 0 then
	lb_commit = false
end if
return lb_commit
end function

on w_piss090u.create
int iCurrent
call super::create
this.cbx_1=create cbx_1
this.cb_srview=create cb_srview
this.cb_split=create cb_split
this.cb_print=create cb_print
this.tab_1=create tab_1
this.cb_trucknew=create cb_trucknew
this.dw_plancancel=create dw_plancancel
this.st_4=create st_4
this.st_invqty=create st_invqty
this.dw_id=create dw_id
this.dw_truckorder=create dw_truckorder
this.dw_print=create dw_print
this.sle_checksrno=create sle_checksrno
this.em_shipeditno=create em_shipeditno
this.sle_custcode=create sle_custcode
this.st_5=create st_5
this.uo_shipoemgubun=create uo_shipoemgubun
this.em_applyfrom=create em_applyfrom
this.uo_date=create uo_date
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_truck=create dw_truck
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_8=create gb_8
this.gb_7=create gb_7
this.gb_9=create gb_9
this.gb_10=create gb_10
this.gb_50=create gb_50
this.gb_truck=create gb_truck
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_1
this.Control[iCurrent+2]=this.cb_srview
this.Control[iCurrent+3]=this.cb_split
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.tab_1
this.Control[iCurrent+6]=this.cb_trucknew
this.Control[iCurrent+7]=this.dw_plancancel
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.st_invqty
this.Control[iCurrent+10]=this.dw_id
this.Control[iCurrent+11]=this.dw_truckorder
this.Control[iCurrent+12]=this.dw_print
this.Control[iCurrent+13]=this.sle_checksrno
this.Control[iCurrent+14]=this.em_shipeditno
this.Control[iCurrent+15]=this.sle_custcode
this.Control[iCurrent+16]=this.st_5
this.Control[iCurrent+17]=this.uo_shipoemgubun
this.Control[iCurrent+18]=this.em_applyfrom
this.Control[iCurrent+19]=this.uo_date
this.Control[iCurrent+20]=this.uo_area
this.Control[iCurrent+21]=this.uo_division
this.Control[iCurrent+22]=this.dw_truck
this.Control[iCurrent+23]=this.cb_1
this.Control[iCurrent+24]=this.gb_1
this.Control[iCurrent+25]=this.gb_2
this.Control[iCurrent+26]=this.gb_4
this.Control[iCurrent+27]=this.gb_5
this.Control[iCurrent+28]=this.gb_6
this.Control[iCurrent+29]=this.gb_8
this.Control[iCurrent+30]=this.gb_7
this.Control[iCurrent+31]=this.gb_9
this.Control[iCurrent+32]=this.gb_10
this.Control[iCurrent+33]=this.gb_50
this.Control[iCurrent+34]=this.gb_truck
end on

on w_piss090u.destroy
call super::destroy
destroy(this.cbx_1)
destroy(this.cb_srview)
destroy(this.cb_split)
destroy(this.cb_print)
destroy(this.tab_1)
destroy(this.cb_trucknew)
destroy(this.dw_plancancel)
destroy(this.st_4)
destroy(this.st_invqty)
destroy(this.dw_id)
destroy(this.dw_truckorder)
destroy(this.dw_print)
destroy(this.sle_checksrno)
destroy(this.em_shipeditno)
destroy(this.sle_custcode)
destroy(this.st_5)
destroy(this.uo_shipoemgubun)
destroy(this.em_applyfrom)
destroy(this.uo_date)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_truck)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_8)
destroy(this.gb_7)
destroy(this.gb_9)
destroy(this.gb_10)
destroy(this.gb_50)
destroy(this.gb_truck)
end on

event open;call super::open;//Int i
//
//SetPointer(HourGlass!)
//
//dw_print.Visible			= False
//dw_truckorder.Visible	= False
//
//dw_id.InsertRow(1)
//dw_id.SetItem(1, 1, '')
//dw_plancancel.InsertRow(1)
//
//
//For i = 1 To 4
//	is_filter[i] = ''
//	il_lastclicked[i]	= 0
//	ib_ldown[i]			= False
//Next
//
//Show()
//
//idw_normal 	= tab_1.tabpage_1.dw_normal
//idw_minap 	= tab_1.tabpage_2.dw_minap
//idw_sennap 	= tab_1.tabpage_3.dw_sennap
//idw_move		= tab_1.tabpage_4.dw_move
//idw_current	= idw_normal
//
//
end event

event ue_save;idw_normal.SetRedraw(False)
idw_minap.SetRedraw(False)
idw_sennap.SetRedraw(False)
idw_move.setredraw(false)
SQLpis.AutoCommit = False
If wf_update_loadplan() then
	Commit using sqlpis;
	SQLpis.AutoCommit = True
	If ib_exit Then
		ib_change = False
	Else
		messagebox("확인","상차계획이 저장 되었습니다.")
		ib_change = False
		triggerEvent('ue_retrieve')
	End If
Else
	Rollback using sqlpis;
	SQLpis.AutoCommit = True	
	Messagebox('저장 오류', '상차계획 저장에 실패하였습니다.')
	If ib_exit Then
		ib_exit	= False
	End If
	ib_change = True
End If
idw_normal.SetRedraw(True)
idw_minap.SetRedraw(True)
idw_sennap.SetRedraw(True)
idw_move.SetRedraw(True)


end event

event ue_retrieve;integer 	li_insert = 1, li_rtn, li_i
Long		ll_rowcount, ll_truckcount
dwobject ldo_object

If ib_change then
	li_rtn =	MessageBox('조 회', '저장되지 않은 상차계획이 있습니다.~r~n저장 하시겠습니까?~r~n', Question!, YesNoCancel!)
	CHOOSE CASE li_rtn
		CASE 1
			postEvent('ue_save')
			return
		CASE 3
			Return
	END CHOOSE
End If
uo_status.st_message.text = '정상 조회 중'
If idw_normal.Retrieve(is_areacode,is_divisioncode,is_date) > 0 Then
	idw_normal.Post Event Clicked(1,1,1,ldo_object)
End If
uo_status.st_message.text = '미납 조회 중'
If idw_minap.Retrieve(is_areacode,is_divisioncode,is_date) > 0 Then
	idw_minap.Post Event Clicked(1,1,1,ldo_object)
End If
uo_status.st_message.text = '선납 조회 중'
If idw_sennap.Retrieve(is_areacode,is_divisioncode,is_date) > 0 Then
	idw_sennap.Post Event Clicked(1,1,1,ldo_object)
End If
uo_status.st_message.text = '이체 조회 중'
If idw_move.Retrieve(is_areacode,is_divisioncode,is_date) > 0 Then
	idw_move.Post Event Clicked(1,1,1,ldo_object)
End If
uo_status.st_message.text = '차량 조회 중'
ll_rowcount = dw_truckorder.Retrieve(is_date,is_areacode,is_divisioncode)
uo_status.st_message.text = '수량 조회 중'
if is_modelid <> '%' and is_modelid <> '' then
	wf_ship_count()
end if
uo_status.st_message.text = '수량 조회 완료'
dw_truck.SetRedraw(False)
dw_truck.reset()
//기존에 상차계획된 차량이 있다면 
If ll_rowcount > 0 Then
	cb_srview.Enabled = True
	ll_truckcount	= dw_truckorder.GetitemNumber(1, 'lasttruck')
	ii_maxtruck		= ll_truckcount
	// 상차계획된 차량이 있고 출하된 차량이 있다면
	If dw_truckorder.Find('TruckFlag = 0', 1, ll_rowcount) > 0 Then
		//상차된 마지막 차량 순번까지 루프를 돌면서 출하되지 않은 차량만 표시한다.
		For li_i = 1 To ii_maxtruck
			//상차된 차량이 있고 이 순번의 차량이 출하된 차량이 아니라면
			If dw_truckorder.Find("TruckFlag = 1 And TruckOrder = " + String(li_i), 1, ll_rowcount) > 0 Then
				dw_truck.InsertRow(li_insert)
				dw_truck.SetItem(li_insert, 1, li_i)
				dw_truck.object.modicheck[li_insert] = 'Y'
				li_insert = li_insert + 1
			End if
		Next
		
		If li_insert = 1 Then //만일 모두가 다 출하된 것이라면 
			dw_truck.InsertRow(li_insert)
			dw_truck.SetItem(li_insert, 1, li_i)
			dw_truck.object.modicheck[li_insert] = 'N'			
			ii_maxtruck = li_i
		End If
	Else// 상차된 차량은 있으나 출하된 차량이 없다면 
		For li_i = 1 To ll_rowcount
			dw_truck.InsertRow(li_i)
			dw_truck.SetItem(li_i, 1, dw_truckorder.GetitemNumber(li_i, 'truckorder'))
			dw_truck.object.modicheck[li_i] = 'Y'			
		Next
	End If
Else
// 기존에 상차계획된 차량이 한개도 없다면 무조건 1번 차량 부터
	ii_maxtruck = 1
	dw_truck.InsertRow(1)
	dw_truck.SetItem(1, 1, 1)
End If

dw_truck.Sort()
dw_truck.Post Event RowFocusChanged(1)
dw_truck.SetRedraw(True)

ib_change = False

wf_filter()
dw_id.SetRow(1)
dw_id.SetColumn(1)
dw_id.SetFocus()
end event

event close;call super::close;Close(This)
end event

event closequery;call super::closequery;integer li_rtn

if ib_change Then
	li_rtn = messagebox('확인', '저장되지 않은 상차계획이 있습니다.~r~n저장 하시겠습니까?', Question!, YesNoCancel!)
	CHOOSE CASE li_rtn
		CASE 1			// 저장후 종료
			ib_exit	= True
			TriggerEvent('ue_save')
			If ib_change Then
				Return 1
			Else
				Return 0
			End If
		CASE 2			// 그냥 종료
			Return 0
		CASE 3			// No Action
			Return 1
	END CHOOSE
Else
	Return 0
End If
end event

event ue_print;call super::ue_print;string ls_date, ls_truckorder, ls_parm, ls_size
//ls_date = f_pisc_get_date_applyday()
ls_date = is_date

if il_truckrow > 0 then
//If row > 0 Then
	ls_truckorder	= string(dw_truck.GetitemNumber(il_old_row, 'truck'))
//	ls_size	= Left(String(WorkSpaceX()) + Space(10), 10)	+ &
//				  Left(String(WorkSpaceY()) + Space(10), 10)	+ &
//				  Left(String(WorkSpaceWidth()) + Space(10), 10) + &
//				  Left(String(WorkSpaceHeight()) + Space(10), 10)

	ls_size	= Space(40)		  
	ls_parm 			= is_areacode + is_divisioncode + Left(ls_date + Space(10), 10 ) + &
						  Left(string(ls_truckorder) + Space(10), 10 ) + ls_size
						  
	OpenWithParm(w_piss120i, ls_parm)
	dw_truck.setredraw(True)
end if

end event

event ue_reset;call super::ue_reset;If ib_open Then
	idw_normal.Reset()
	idw_minap.Reset()
	idw_sennap.Reset()
	idw_move.Reset()
	
	ib_change 			= False
//	cb_save.Enabled 	= False
End If
end event

event activate;call super::activate;idw_normal 	= tab_1.tabpage_1.dw_normal
idw_minap 	= tab_1.tabpage_2.dw_minap
idw_sennap 	= tab_1.tabpage_3.dw_sennap
idw_move		= tab_1.tabpage_4.dw_move


idw_normal.SetTransObject(SQLPIS)
idw_minap.SetTransObject(SQLPIS)
idw_sennap.SetTransObject(SQLPIS)
idw_move.SetTransObject(SQLPIS)
dw_truckorder.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss090u
integer x = 18
integer y = 2404
end type

type cbx_1 from checkbox within w_piss090u
integer x = 1975
integer y = 104
integer width = 512
integer height = 64
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "출하잔량0포함"
boolean checked = true
end type

event clicked;if cbx_1.checked then
   tab_1.tabpage_1.dw_normal.setfilter('shipremainqty1 >= 0')
   tab_1.tabpage_2.dw_minap.setfilter('shipremainqty1 >= 0')
   tab_1.tabpage_3.dw_sennap.setfilter('shipremainqty1 >= 0')
   tab_1.tabpage_4.dw_move.setfilter('shipremainqty1 >= 0')
else	
   tab_1.tabpage_1.dw_normal.setfilter('shipremainqty1 > 0')
   tab_1.tabpage_2.dw_minap.setfilter('shipremainqty1 > 0')
   tab_1.tabpage_3.dw_sennap.setfilter('shipremainqty1 > 0')
   tab_1.tabpage_4.dw_move.setfilter('shipremainqty1 > 0')
end if	
tab_1.tabpage_1.dw_normal.filter()
tab_1.tabpage_2.dw_minap.filter()
tab_1.tabpage_3.dw_sennap.filter()
tab_1.tabpage_4.dw_move.filter()

//
end event

type cb_srview from commandbutton within w_piss090u
integer x = 3621
integer y = 80
integer width = 302
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "SR보기"
end type

event clicked;Parent.TriggerEvent('ue_srview')
end event

type cb_split from commandbutton within w_piss090u
integer x = 3922
integer y = 80
integer width = 302
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "수량분할"
end type

event clicked;parent.triggerevent('ue_split')
end event

type cb_print from commandbutton within w_piss090u
integer x = 4224
integer y = 80
integer width = 302
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "상차보기"
end type

event clicked;Parent.triggerEvent('ue_print')
end event

type tab_1 from tab within w_piss090u
integer x = 27
integer y = 440
integer width = 4037
integer height = 1948
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

event selectionchanged;ii_index	= newindex

If ib_open Then
	CHOOSE CASE newindex
		CASE 1
			idw_current = idw_normal
		CASE 2
			idw_current = idw_minap
		CASE 3		
			idw_current = idw_sennap
		CASE 4
			idw_current = idw_move
	END CHOOSE

//	If is_filter[newindex] = '' Then
//		dw_id.SetItem(1,1,'ALL')
//		idw_current.SetFilter('')
//		If is_filter[newindex] <> is_filter[oldindex] Then
//			wf_ship_count('ALL')
//		End If
//	Else
//		dw_id.SetItem(1,1,is_filter[newindex])
//		idw_current.SetFilter("ModelID = '" + is_filter[newindex] + "'")
//		If is_filter[newindex] <> is_filter[oldindex] Then
//			wf_ship_count(is_filter[newindex])
//		End If
//	End If
//	dw_id.SetColumn(1)
//	dw_id.SetRow(1)
//	dw_id.SetFocus()
  idw_current.setfocus()
End If
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4000
integer height = 1832
long backcolor = 12632256
string text = "정상출하"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_normal dw_normal
end type

on tabpage_1.create
this.dw_normal=create dw_normal
this.Control[]={this.dw_normal}
end on

on tabpage_1.destroy
destroy(this.dw_normal)
end on

type dw_normal from datawindow within tabpage_1
event ue_mousemove pbm_mousemove
event ue_lmouse_up pbm_lbuttonup
event ue_lmouse_down pbm_lbuttondown
integer y = 8
integer width = 3995
integer height = 1816
integer taborder = 80
string dragicon = "WinLogo!"
string title = "none"
string dataobject = "d_piss090u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;wf_dw_mousemove(flags, xpos, ypos)
end event

event ue_lmouse_up;wf_dw_lmouse_up(flags, xpos, ypos)
end event

event ue_lmouse_down;wf_dw_lmouse_down(flags, xpos, ypos)

end event

event clicked;wf_dw_clicked(xpos, ypos, row, dwo)
string ls_column
ls_column 	=	trim(dwo.name)
if right(ls_column,2) = '_s' then
	ls_column	=	Left(ls_column,Len(ls_column) - 2)
	IF this.setsort(ls_column) <> 1 THEN 
		messagebox("확인","정렬을 수행할수 없는 내용입니다. " + ls_column)
		RETURN
	END IF
	IF this.sort() <> 1 THEN 
		messagebox("확인","정렬을 수행할수 없습니다. " + ls_column)
		RETURN
	END IF
end if
end event
event doubleclicked;wf_dw_doubleclicked(xpos, ypos, row, dwo)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4000
integer height = 1832
long backcolor = 12632256
string text = "미납"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_minap dw_minap
end type

on tabpage_2.create
this.dw_minap=create dw_minap
this.Control[]={this.dw_minap}
end on

on tabpage_2.destroy
destroy(this.dw_minap)
end on

type dw_minap from datawindow within tabpage_2
event ue_mousemove pbm_mousemove
event ue_lmouse_up pbm_lbuttonup
event ue_lmouse_down pbm_lbuttondown
integer y = 8
integer width = 3995
integer height = 1816
integer taborder = 90
string dragicon = "WinLogo!"
string title = "none"
string dataobject = "d_piss090u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;wf_dw_mousemove(flags, xpos, ypos)
end event

event ue_lmouse_up;wf_dw_lmouse_up(flags, xpos, ypos)
end event

event ue_lmouse_down;wf_dw_lmouse_down(flags, xpos, ypos)

end event

event clicked;wf_dw_clicked(xpos, ypos, row, dwo)
string ls_column
ls_column 	=	trim(dwo.name)
if right(ls_column,2) = '_t' then
	ls_column	=	Left(ls_column,Len(ls_column) - 2)
	IF this.setsort(ls_column) <> 1 THEN 
		messagebox("확인","정렬을 수행할수 없는 내용입니다. " + ls_column)
		RETURN
	END IF
	IF this.sort() <> 1 THEN 
		messagebox("확인","정렬을 수행할수 없습니다. " + ls_column)
		RETURN
	END IF
end if
end event

event doubleclicked;wf_dw_doubleclicked(xpos, ypos, row, dwo)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4000
integer height = 1832
long backcolor = 12632256
string text = "선납"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_sennap dw_sennap
end type

on tabpage_3.create
this.dw_sennap=create dw_sennap
this.Control[]={this.dw_sennap}
end on

on tabpage_3.destroy
destroy(this.dw_sennap)
end on

type dw_sennap from datawindow within tabpage_3
event ue_mousemove pbm_mousemove
event ue_lmouse_up pbm_lbuttonup
event ue_lmouse_down pbm_lbuttondown
integer y = 8
integer width = 3995
integer height = 1828
integer taborder = 90
string dragicon = "WinLogo!"
string title = "none"
string dataobject = "d_piss090u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;wf_dw_mousemove(flags, xpos, ypos)
end event

event ue_lmouse_up;wf_dw_lmouse_up(flags, xpos, ypos)
end event

event ue_lmouse_down;wf_dw_lmouse_down(flags, xpos, ypos)

end event

event clicked;wf_dw_clicked(xpos, ypos, row, dwo)
string ls_column
ls_column 	=	trim(dwo.name)
if right(ls_column,2) = '_t' then
	ls_column	=	Left(ls_column,Len(ls_column) - 2)
	IF this.setsort(ls_column) <> 1 THEN 
		messagebox("확인","정렬을 수행할수 없는 내용입니다. " + ls_column)
		RETURN
	END IF
	IF this.sort() <> 1 THEN 
		messagebox("확인","정렬을 수행할수 없습니다. " + ls_column)
		RETURN
	END IF
end if
end event

event doubleclicked;wf_dw_doubleclicked(xpos, ypos, row, dwo)
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4000
integer height = 1832
long backcolor = 12632256
string text = "이체"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_move dw_move
end type

on tabpage_4.create
this.dw_move=create dw_move
this.Control[]={this.dw_move}
end on

on tabpage_4.destroy
destroy(this.dw_move)
end on

type dw_move from datawindow within tabpage_4
event ue_mousemove pbm_mousemove
event ue_lmouse_up pbm_lbuttonup
event ue_lmouse_down pbm_lbuttondown
integer y = 8
integer width = 3995
integer height = 1820
integer taborder = 90
string dragicon = "WinLogo!"
string title = "none"
string dataobject = "d_piss090u_04"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;wf_dw_mousemove(flags, xpos, ypos)
end event

event ue_lmouse_up;wf_dw_lmouse_up(flags, xpos, ypos)
end event

event ue_lmouse_down;wf_dw_lmouse_down(flags, xpos, ypos)

end event

event clicked;wf_dw_clicked(xpos, ypos, row, dwo)
string ls_column
ls_column 	=	trim(dwo.name)
if right(ls_column,2) = '_t' then
	ls_column	=	Left(ls_column,Len(ls_column) - 2)
	IF this.setsort(ls_column) <> 1 THEN 
		messagebox("확인","정렬을 수행할수 없는 내용입니다. " + ls_column)
		RETURN
	END IF
	IF this.sort() <> 1 THEN 
		messagebox("확인","정렬을 수행할수 없습니다. " + ls_column)
		RETURN
	END IF
end if
end event

event doubleclicked;wf_dw_doubleclicked(xpos, ypos, row, dwo)
end event

type cb_trucknew from commandbutton within w_piss090u
integer x = 4114
integer y = 260
integer width = 421
integer height = 92
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "차량추가"
end type

event clicked;Int	i
Long	ll_rowcount, ll_find, ll_searchtruck, ll_truck_rowcount

ll_rowcount = dw_truck.RowCount()
ll_truck_rowcount = dw_truckorder.rowcount()

dw_truck.SetRedraw(False)
For i = 1 To ii_maxtruck + 1
	ll_find = dw_truck.Find("Truck = " + String(i), 1, ll_rowcount)
	//현재 표시되어 있는 트럭이있다면 No Action
	//현재 표시 되어 있는 트럭중에서 없다면 트럭순번이 이미 출하된 버린 트럭순번이지 checking
	If ll_find = 0 Then
		ll_find = dw_truckorder.Find("TruckFlag = 0 And TruckOrder = " + String(i), 1, ll_truck_rowcount)	
		If ll_find = 0 Then 
			dw_truck.InsertRow(0)
			dw_truck.Setitem(ll_rowcount + 1, 1, i)
			If i > ii_maxtruck Then
				ii_maxtruck = i
			End if
			Exit
		End If
	End if
Next
dw_truck.Sort()

ll_searchtruck = dw_truck.Find("Truck = " + String(i), 1, ll_rowcount + 1)
dw_truck.Post Event RowFocusChanged(ll_searchtruck)
dw_truck.ScrollToRow(ll_searchtruck)

dw_truck.SetRedraw(True)
end event

type dw_plancancel from datawindow within w_piss090u
integer x = 4119
integer y = 2076
integer width = 411
integer height = 284
integer taborder = 220
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss090u_06"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dragdrop;long        ll_truckorder,ll_find
string ls_find
DragObject	ldo_object
DataWindow	ldw_control

ldo_object = DraggedObject()
if TypeOf (ldo_object) = DataWindow! and ldo_object <> dw_truck then
	ldw_control = ldo_object
	wf_return_buffer(ldw_control)
end if
if TypeOf (ldo_object) = DataWindow! and ldo_object = dw_truck then
	ldw_control = ldo_object
	ll_truckorder = il_delete_truckorder
	ls_find = 'truck = ' + string(ll_truckorder)
	ll_find = dw_truck.find(ls_find,1,dw_truck.rowcount())
	if ll_find > 0 then
		dw_truck.object.modicheck[ll_find] = 'Y'
   end if
	wf_truck_return_buffer(ll_truckorder)
end if
end event

type st_4 from statictext within w_piss090u
integer x = 2693
integer y = 308
integer width = 215
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "현재고"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_invqty from statictext within w_piss090u
integer x = 2917
integer y = 288
integer width = 311
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_id from datawindow within w_piss090u
integer x = 37
integer y = 272
integer width = 274
integer height = 144
integer taborder = 140
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss090u_07"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_modelid = data
if is_modelid = '' or is_modelid = '' then
	is_modelid = '%'
end if	
wf_filter()
end event

type dw_truckorder from datawindow within w_piss090u
integer x = 2373
integer y = 1012
integer width = 411
integer height = 432
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss090u_08"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_print from datawindow within w_piss090u
boolean visible = false
integer x = 3287
integer y = 1052
integer width = 411
integer height = 432
integer taborder = 60
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type sle_checksrno from singlelineedit within w_piss090u
integer x = 407
integer y = 288
integer width = 389
integer height = 92
integer taborder = 150
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 11
borderstyle borderstyle = stylelowered!
end type

event modified;is_checksrno = trim(sle_checksrno.text)
if isnull(is_checksrno) or is_checksrno = '' then
   is_checksrno = '%'
end if	
wf_filter()
end event

type em_shipeditno from editmask within w_piss090u
integer x = 891
integer y = 288
integer width = 160
integer height = 92
integer taborder = 160
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "0"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

event modified;is_shipeditno = trim(em_shipeditno.text)
if isnull(is_shipeditno) or is_shipeditno = ''then
   is_shipeditno = '%'
end if	
wf_filter()
end event

type sle_custcode from singlelineedit within w_piss090u
integer x = 1143
integer y = 288
integer width = 238
integer height = 92
integer taborder = 170
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

event modified;is_custcode = trim(sle_custcode.text)
if is_custcode = '' or isnull(is_custcode) then
   is_custcode = '%'
end if	
wf_filter()
end event

type st_5 from statictext within w_piss090u
integer x = 1559
integer y = 316
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type uo_shipoemgubun from u_pisc_select_code within w_piss090u
event destroy ( )
integer x = 1458
integer y = 296
integer width = 709
integer taborder = 70
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;is_shipoemgubun = is_uo_codeid
if is_shipoemgubun = '' or isnull(is_shipoemgubun) then
	is_shipoemgubun = '%'
end if	
wf_filter()



end event

event ue_post_constructor;call super::ue_post_constructor;//is_shipoemgubun = is_uo_codeid
//if is_shipoemgubun = 'X' then //이체
//   dw_srorder.dataobject = 'd_piss050i_02'
//   dw_print.dataobject = 'd_piss050i_03'
//else
//	dw_srorder.dataobject = 'd_piss050i_01'
//   dw_print.dataobject = 'd_piss050i_04'
//	
//end if	
//
//idw_srorder 	= dw_srorder
//idw_current		= idw_srorder
//
//dw_srorder.settransobject(sqlpis)
//dw_print.settransobject(sqlpis)
end event

type em_applyfrom from editmask within w_piss090u
integer x = 2208
integer y = 288
integer width = 389
integer height = 92
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "XXXX.XX.XX"
end type

event modified;wf_filter()
end event

type uo_date from u_pisc_date_applydate within w_piss090u
integer x = 87
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

event constructor;call super::constructor;is_date = is_uo_date
end event

event ue_select;call super::ue_select;is_date = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_date = is_uo_date
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type uo_area from u_pisc_select_area within w_piss090u
integer x = 846
integer y = 92
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;idw_normal.SetTransObject(SQLPIS)
idw_minap.SetTransObject(SQLPIS)
idw_sennap.SetTransObject(SQLPIS)
idw_move.SetTransObject(SQLPIS)
dw_truckorder.SetTransObject(SQLPIS)
idw_normal.reset()
idw_minap.reset()
idw_sennap.reset()
idw_move.reset()
dw_truckorder.reset()

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)


end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)



end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_piss090u
integer x = 1385
integer y = 92
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;call super::ue_select;idw_normal.SetTransObject(SQLPIS)
idw_minap.SetTransObject(SQLPIS)
idw_sennap.SetTransObject(SQLPIS)
idw_move.SetTransObject(SQLPIS)
dw_truckorder.SetTransObject(SQLPIS)
idw_normal.reset()
idw_minap.reset()
idw_sennap.reset()
idw_move.reset()
dw_truckorder.reset()
is_divisioncode = is_uo_divisioncode
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode

end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type dw_truck from datawindow within w_piss090u
event ue_lmousedown pbm_lbuttondown
event ue_lmouseup pbm_lbuttonup
event ue_mousemove pbm_mousemove
integer x = 4119
integer y = 364
integer width = 407
integer height = 1624
integer taborder = 210
string dragicon = "WinLogo!"
boolean bringtotop = true
string title = "dw_truck"
string dataobject = "d_piss090u_05"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lmousedown;wf_truck_dw_lmouse_down(flags, xpos, ypos)


end event

event ue_lmouseup;wf_truck_dw_lmouse_up(flags, xpos, ypos)
end event

event ue_mousemove;wf_truck_dw_mousemove(flags, xpos, ypos)
end event

event clicked;if row > 0 then
	il_delete_truckorder = dw_truck.object.truck[row]
   wf_truck_dw_clicked(xpos, ypos, row, dwo)
end if
end event

event dragdrop;DragObject	ldo_object
DataWindow	ldw_control

ldo_object = DraggedObject()
if TypeOf (ldo_object) = DataWindow! and ldo_object <> dw_truck then
	ldw_control = ldo_object
	wf_change_buffer (ldw_control, il_truckrow)
end if
end event

event dragwithin;Long	ll_first_row, ll_header, ll_detail, ll_last_row
DragObject	ldo_object
DataWindow	ldw_control

If row > 0 Then
	If il_old_row <> row Then
		ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
		ll_header		= Long(Describe("DataWindow.Header.Height"))
		ll_detail		= Long(Describe("DataWindow.Detail.Height"))
		dw_truck.Post Event RowFocusChanged(row)
	End If
Else
	ll_last_row 	= Long(Object.DataWindow.LastRowOnPage)
	ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
	ll_header		= Long(Describe("DataWindow.Header.Height"))
	ll_detail		= Long(Describe("DataWindow.Detail.Height"))
	If PointerY() > ll_header Then
		If ll_last_row < RowCount() Then
			ScrollNextRow()
		Else
			il_old_row = ll_last_row + 1
		End If
	Else
		ScrollPriorRow()
	End If
End If
end event

event rowfocuschanged;If currentrow > 0 then
//	SelectRow (0, False)
//	SelectRow (currentrow, True)
	il_truckrow = dw_truck.GetitemNumber(currentrow, 'Truck')
	il_old_row	= currentrow
End If
end event

type cb_1 from commandbutton within w_piss090u
integer x = 3319
integer y = 80
integer width = 302
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "정  렬"
end type

event clicked;STR_SORT	lstr_sort
lstr_sort.dw = idw_current
lstr_sort.title = parent.Title
OpenWithParm(w_dw_sort_r, lstr_sort )
end event
type gb_1 from groupbox within w_piss090u
integer x = 23
integer y = 28
integer width = 2473
integer height = 172
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
end type

type gb_2 from groupbox within w_piss090u
integer x = 3278
integer y = 20
integer width = 1280
integer height = 172
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "버튼정보"
end type

type gb_4 from groupbox within w_piss090u
integer x = 4082
integer y = 2016
integer width = 485
integer height = 368
integer taborder = 260
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_5 from groupbox within w_piss090u
integer x = 2633
integer y = 212
integer width = 617
integer height = 212
integer taborder = 190
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "수량정보"
end type

type gb_6 from groupbox within w_piss090u
integer x = 366
integer y = 216
integer width = 471
integer height = 208
integer taborder = 210
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "SR번호"
end type

type gb_8 from groupbox within w_piss090u
integer x = 27
integer y = 216
integer width = 306
integer height = 208
integer taborder = 230
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "식별ID"
end type

type gb_7 from groupbox within w_piss090u
integer x = 2190
integer y = 212
integer width = 430
integer height = 212
integer taborder = 240
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "납품요구일"
end type

type gb_9 from groupbox within w_piss090u
integer x = 869
integer y = 216
integer width = 206
integer height = 208
integer taborder = 250
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "편수"
end type

type gb_10 from groupbox within w_piss090u
integer x = 1102
integer y = 212
integer width = 311
integer height = 212
integer taborder = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "거래처"
end type

type gb_50 from groupbox within w_piss090u
integer x = 1431
integer y = 212
integer width = 745
integer height = 212
integer taborder = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "출하구분"
end type

type gb_truck from groupbox within w_piss090u
integer x = 4082
integer y = 208
integer width = 480
integer height = 1808
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

