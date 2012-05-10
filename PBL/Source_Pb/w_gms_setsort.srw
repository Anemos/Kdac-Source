$PBExportHeader$w_gms_setsort.srw
$PBExportComments$�������� ������(�������� �������� Structure�� ����)
forward
global type w_gms_setsort from window
end type
type cb_cancel from commandbutton within w_gms_setsort
end type
type cb_ok from commandbutton within w_gms_setsort
end type
type st_1 from statictext within w_gms_setsort
end type
type dw_post from datawindow within w_gms_setsort
end type
type dw_pre from datawindow within w_gms_setsort
end type
end forward

global type w_gms_setsort from window
integer x = 297
integer y = 500
integer width = 2615
integer height = 1188
boolean titlebar = true
string title = "����������"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
event ue_mousemove pbm_mousemove
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
dw_post dw_post
dw_pre dw_pre
end type
global w_gms_setsort w_gms_setsort

type variables
// Keeps track of the last row that was clicked in the
// three datawindows
long   il_prim_lastclicked, &
         il_del_lastclicked, &
         il_fil_lastclicked

// Determines if left mouse button is down in the 3 DataWindows
boolean   ib_post_ldown, &
              ib_pre_ldown, &
              ib_fil_ldown

// Used when rows that are clicked have already been
// selected.  This is necessary to drag a group of rows.
boolean   ib_already_selected
long   il_selected_clicked

// Determine whether user is copying or moving rows.
string   is_action

end variables

forward prototypes
public subroutine wf_change_buffer (datawindow adw_source, datawindow adw_target)
end prototypes

event ue_mousemove;ib_pre_ldown = false
ib_post_ldown = false
end event

public subroutine wf_change_buffer (datawindow adw_source, datawindow adw_target);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Function: wf_change_buffer
//
// Purpose: Performs RowsCopy or RowsMove from the source DataWindow
//		     to the target DataWindow.
// (Because this example is visually "showing" the three buffers for one DataWindow, there
//  are two operations that must be performed on any action:  the actual movement between
//  buffers of the rows in dw_1 (referred to in this example as "Internal operation"), and the visual 
//  representation of the movement which is moving rows from one DataWindow to another
//  (referred to in this example as "External operation"))
//
// Scope: protected
//
// Arguments: adw_source		the source datawindow
//			   adw_target		the target datawindow
//		
// Returns: none
//
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long		ll_selected_rows[], &
			ll_selected_count, &
			ll_rowcount,ll_chk
dwbuffer		lb_source_buffer, &
			lb_target_buffer



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Store the row numbers of the selected rows in an array
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ll_selected_count = f_return_selected (adw_source, ll_selected_rows)
if ll_selected_count = 0 then return


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// External action
// Copy the rows from the source datawindow to the target datawindow.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//if adw_target <> dw_post then
//	adw_source.RowsCopy (ll_selected_rows[1], ll_selected_rows[ll_selected_count], &
//								primary!, adw_target, adw_target.RowCount() + 1, primary!)	
//end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Internal action
// Depending upon the action (move or copy), move or copy the rows from the buffer specified
// by the source DataWindow to the buffer specified by the target DataWindow.  
// Example - if moving from the "deleted buffer" DataWindow to the "primary buffer" DataWindow,
//			 then a RowsMove will be issued from the deleted buffer of dw_1 to the
//			 primary buffer of dw_1.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
choose case adw_source
	case dw_post
		lb_source_buffer = primary!

	case dw_pre
		lb_source_buffer = primary!
end choose

choose case adw_target
	case dw_post
		lb_target_buffer = primary!
		ll_chk = dw_pre.RowsMove (il_prim_lastclicked, il_prim_lastclicked, &
								lb_source_buffer, dw_post, dw_post.RowCount() + 1, lb_target_buffer)

	case dw_pre
		lb_target_buffer = primary!
		ll_chk = dw_post.RowsMove (il_del_lastclicked, il_del_lastclicked, &
								lb_source_buffer, dw_pre, dw_pre.RowCount() + 1, lb_target_buffer)
end choose

//if is_action = "copy" then
//	dw_pre.RowsCopy (ll_selected_rows[1], ll_selected_rows[ll_selected_count], &
//								lb_source_buffer, dw_post, dw_post.RowCount() + 1, lb_target_buffer)	
//else
//	ll_chk = dw_pre.RowsMove (ll_selected_rows[1], ll_selected_rows[ll_selected_count], &
//								lb_source_buffer, dw_post, dw_post.RowCount() + 1, lb_target_buffer)	
//end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// External action
// If moving from the deleted or filtered DataWindows, then discard the rows that were moved
// from the source DataWindow.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//if (is_action = "move")  and lb_target_buffer = delete! then //and (adw_source = dw_deleted or adw_source = dw_filtered) then
//	adw_source.RowsDiscard (ll_selected_rows[1], ll_selected_rows[ll_selected_count], primary!)
//end if
//
//wf_set_rowcounts()
adw_target.SetFocus()
ll_rowcount = adw_target.RowCount()
adw_target.ScrollToRow(ll_rowcount)
end subroutine

on w_gms_setsort.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.dw_post=create dw_post
this.dw_pre=create dw_pre
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.st_1,&
this.dw_post,&
this.dw_pre}
end on

on w_gms_setsort.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.dw_post)
destroy(this.dw_pre)
end on

event open;//�μ��� �Ѱ��� ����Ÿ��Ʈ���� �ؽ�Ʈ�� column name�� ����� �ؽ�Ʈ = "column name"_t���� ��
//����Ÿ�����������Ʈ�ۼ��� db layout���� computed column�� �����
//�μ��� ����Ÿ������ ��Ʈ��
//���ϰ��� display�� sorting�� ���� 2���� string(1 structure)
datawindow dw_parm
string ls_colcnt,ls_colnm,ls_dbnm
integer li_cntnum,li_currow,li_rowcnt
dw_parm = message.PowerObjectParm	

ls_colcnt = dw_parm.describe("datawindow.column.count")
for li_cntnum = 1 to integer(ls_colcnt)
	ls_dbnm = dw_parm.Describe("#" + string(li_cntnum) + ".name")
	ls_colnm = dw_parm.Describe(ls_dbnm + "_t" + ".text")
	if trim(ls_colnm) = "!" or trim(ls_colnm) = "?" then
		//nothing
	else
		li_currow = dw_pre.insertrow(0)
		dw_pre.setitem(li_currow,"dsptext",ls_colnm)
		dw_pre.setitem(li_currow,"colnm",ls_dbnm)
		dw_pre.setitem(li_currow,"ordchk",'A')
	end if
next

end event

type cb_cancel from commandbutton within w_gms_setsort
integer x = 2313
integer y = 24
integer width = 233
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���"
end type

event clicked;s_gms_rtnsort lstr_rsult
lstr_rsult.rtnsort = ''
lstr_rsult.dspsort = ''
closewithreturn(parent,lstr_rsult)
end event

type cb_ok from commandbutton within w_gms_setsort
integer x = 2043
integer y = 24
integer width = 233
integer height = 88
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Ȯ��"
end type

event clicked;long ll_cntnum,ll_rowcnt
string ls_dsptext,ls_colnm,ls_ordchk,ls_rtnsort,ls_dspsort
s_gms_rtnsort lstr_rsult

ll_rowcnt = dw_post.rowcount()
ls_rtnsort = ""
ls_dspsort = ""
for ll_cntnum = 1 to ll_rowcnt
	ls_dsptext = dw_post.getitemstring(ll_cntnum,"dsptext")
	ls_colnm = dw_post.getitemstring(ll_cntnum,"colnm")
	ls_ordchk = dw_post.getitemstring(ll_cntnum,"ordchk")
	if ll_cntnum = ll_rowcnt then
		ls_rtnsort = ls_rtnsort + ls_colnm + " " + ls_ordchk
		ls_dspsort = ls_dspsort + ls_dsptext + " " + ls_ordchk
	else
		ls_rtnsort = ls_rtnsort + ls_colnm + " " + ls_ordchk + ","
		ls_dspsort = ls_dspsort + ls_dsptext + " " + ls_ordchk + ","
	end if
next
lstr_rsult.rtnsort = ls_rtnsort
lstr_rsult.dspsort = ls_dspsort
closewithreturn(parent,lstr_rsult)
end event

type st_1 from statictext within w_gms_setsort
integer x = 64
integer y = 32
integer width = 795
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "Drag and Drop items"
boolean focusrectangle = false
end type

type dw_post from datawindow within w_gms_setsort
event ue_mousemove pbm_mousemove
event ue_lmouse_down pbm_lbuttondown
event ue_lmouse_up pbm_lbuttonup
integer x = 731
integer y = 128
integer width = 1819
integer height = 912
integer taborder = 20
string title = "none"
string dataobject = "d_gmssort_post"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If left mouse button is down and user moves the mouse, initiate drag mode.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ib_post_ldown and this.RowCount() > 0 then

	// If the Control key is held down, then the rows will be copied with dwRowsCopy
	if KeyDown (keyControl!) then
		//is_action = "copy"
	else
		is_action = "move"
	end if

	this.Drag (begin!)
end if
end event

event ue_lmouse_down;ib_post_ldown = true
end event

event ue_lmouse_up;ib_post_ldown = false
end event

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Allow user to use Shift-click to highlight all rows betwen first clicked row and the
// row that was Shift-clicked.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


long	ll_clicked

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// First make sure the user clicked on a Row.  Clicking on WhiteSpace or in the header 
// will return a clicked row value of 0.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If row = 0 then return

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If the clicked row is already selected, handle highlite processing for it in the left mouse
// button up event.  This is necessary so groups of selected rows can be dragged.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//if this.GetSelectedRow (row - 1) = row and ib_already_selected = false then
//	ib_already_selected = true
//	il_selected_clicked = row
//	return
//else
//
//	if ib_already_selected then
//		ll_clicked = il_selected_clicked
//	else
		ll_clicked = row
//	end if
//
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// case of select multiple rows range using the shift key
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if Keydown (KeyShift!) and not ib_already_selected then
		//wf_shift_highlight (this, ll_clicked)
	else
		this.SelectRow (0, false)
		this.SelectRow (ll_clicked, true)

		// A single row is now selected in the DataWindow, so change its drag icon to the 
		// single rows icon.
		this.DragIcon = "C:\kdac\bmp\row.ico"
	end if

//	ib_already_selected = false
	il_del_lastclicked = ll_clicked
//end if

end event

event dragdrop;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Move or copy the DataWindow rows that were dropped on this datawindow to the 
// primary buffer.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DragObject		ldo_object
DataWindow	ldw_control


ldo_object = DraggedObject()
if TypeOf (ldo_object) = DataWindow! then
	ldw_control = ldo_object
	if ldw_control <> this then
		wf_change_buffer (ldw_control, this)
	end if
end if
end event

event losefocus;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Deselect all rows and reset the last clicked instance variable
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
this.SelectRow (0, false)
il_del_lastclicked = 0
end event

type dw_pre from datawindow within w_gms_setsort
event ue_mousemove pbm_mousemove
event ue_lmouse_down pbm_lbuttondown
event ue_lmouse_up pbm_lbuttonup
integer x = 41
integer y = 128
integer width = 672
integer height = 912
integer taborder = 10
string title = "none"
string dataobject = "d_gmssort_pre"
boolean vscrollbar = true
string icon = "C:\kdac\bmp\row.ico"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If left mouse button is down and user moves the mouse, initiate drag mode.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ib_pre_ldown and this.RowCount() > 0 then

	// If the Control key is held down, then the rows will be copied with dwRowsCopy
	if KeyDown (keyControl!) then
		//is_action = "copy"
	else
		is_action = "move"
	end if

	this.Drag (begin!)
end if
end event

event ue_lmouse_down;ib_pre_ldown = true
end event

event ue_lmouse_up;ib_pre_ldown = false
end event

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
// Allow user to use Shift-click to highlight all rows betwen first clicked row and the
// row that was Shift-clicked.
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


long	ll_clicked

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// First make sure the user clicked on a Row.  Clicking on WhiteSpace or in the header 
// will return a clicked row value of 0.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
If row = 0 then return

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// If the clicked row is already selected, handle highlite processing for it in the left mouse
// button up event.  This is necessary so groups of selected rows can be dragged.
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//if this.GetSelectedRow (row - 1) = row and ib_already_selected = false then
//	ib_already_selected = true
//	il_selected_clicked = row
//	return
//else
//
//	if ib_already_selected then
//		ll_clicked = il_selected_clicked
//	else
		ll_clicked = row
//	end if
//
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	// case of select multiple rows range using the shift key
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	if Keydown (KeyShift!) and not ib_already_selected then
		//wf_shift_highlight (this, ll_clicked)
	else
		this.SelectRow (0, false)
		this.SelectRow (ll_clicked, true)

		// A single row is now selected in the DataWindow, so change its drag icon to the 
		// single rows icon.
		this.DragIcon = "C:\kdac\bmp\row.ico"
	end if

//	ib_already_selected = false
	il_prim_lastclicked = ll_clicked
//end if

end event

event dragdrop;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Move or copy the DataWindow rows that were dropped on this datawindow to the 
// primary buffer.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DragObject		ldo_object
DataWindow	ldw_control


ldo_object = DraggedObject()
if TypeOf (ldo_object) = DataWindow! then
	ldw_control = ldo_object
	if ldw_control <> this then
		wf_change_buffer (ldw_control, this)
	end if
end if
end event

event losefocus;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Deselect all rows and reset the last clicked instance variable
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
this.SelectRow (0, false)
il_prim_lastclicked = 0
end event
