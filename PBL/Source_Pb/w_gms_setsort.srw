$PBExportHeader$w_gms_setsort.srw
$PBExportComments$정열조건 윈도우(정열문과 정열명을 Structure로 리턴)
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
string title = "정열윈도우"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
event ue_mousemove pbm_mousemove
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
dw_post dw_post
dw_pre dw_pre
end type
global w_gms_setsort w_gms_setsort

type variables
long   	in_prim_lastclicked, &
       	in_del_lastclicked, &
       	in_fin_lastclicked
boolean  ib_post_ldown, &
         ib_pre_ldown, &
         ib_fin_ldown

boolean  ib_already_selected
long   	in_selected_clicked

// Determine whether user is copying or moving rows.
string   is_action

end variables

forward prototypes
public subroutine wf_change_buffer (datawindow adw_source, datawindow adw_target)
end prototypes

event ue_mousemove;ib_pre_ldown 	= false
ib_post_ldown 	= false
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

long		ln_selected_rows[], &
			ln_selected_count, &
			ln_rowcount,ln_chk
dwbuffer	lb_source_buffer, &
			lb_target_buffer


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Store the row numbers of the selected rows in an array
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ln_selected_count = f_return_selected (adw_source, ln_selected_rows)
if ln_selected_count = 0 then return


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// External action
// Copy the rows from the source datawindow to the target datawindow.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//if adw_target <> dw_post then
//	adw_source.RowsCopy (ln_selected_rows[1], ln_selected_rows[ln_selected_count], &
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
		ln_chk = dw_pre.RowsMove (in_prim_lastclicked, in_prim_lastclicked, &
								lb_source_buffer, dw_post, dw_post.RowCount() + 1, lb_target_buffer)

	case dw_pre
		lb_target_buffer = primary!
		ln_chk = dw_post.RowsMove (in_del_lastclicked, in_del_lastclicked, &
								lb_source_buffer, dw_pre, dw_pre.RowCount() + 1, lb_target_buffer)
end choose

//if is_action = "copy" then
//	dw_pre.RowsCopy (ln_selected_rows[1], ln_selected_rows[ln_selected_count], &
//								lb_source_buffer, dw_post, dw_post.RowCount() + 1, lb_target_buffer)	
//else
//	ln_chk = dw_pre.RowsMove (ln_selected_rows[1], ln_selected_rows[ln_selected_count], &
//								lb_source_buffer, dw_post, dw_post.RowCount() + 1, lb_target_buffer)	
//end if


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// External action
// If moving from the deleted or filtered DataWindows, then discard the rows that were moved
// from the source DataWindow.
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//if (is_action = "move")  and lb_target_buffer = delete! then //and (adw_source = dw_deleted or adw_source = dw_filtered) then
//	adw_source.RowsDiscard (ln_selected_rows[1], ln_selected_rows[ln_selected_count], primary!)
//end if
//
//wf_set_rowcounts()
adw_target.SetFocus()
ln_rowcount = adw_target.RowCount()
adw_target.ScrollToRow(ln_rowcount)
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

event open;//인수로 넘겨진 데이타컨트롤의 텍스트와 column name의 관계는 텍스트 = "column name"_t여야 함
//데이타윈도우오브젝트작성시 db layout에서 computed column을 만들것
//인수는 데이타윈도우 컨트롤
//리턴값은 display와 sorting을 위한 2개의 string(1 structure)
datawindow 	dw_parm
string 		ls_colcnt,ls_colnm,ls_dbnm
integer 		ln_cntnum,ln_currow,ln_rowcnt

dw_parm 		= message.PowerObjectParm	
ls_colcnt 	= dw_parm.describe("datawindow.column.count")
for ln_cntnum = 1 to integer(ls_colcnt)
	ls_dbnm 	= dw_parm.Describe("#" + string(ln_cntnum) + ".name")
	ls_colnm = dw_parm.Describe(ls_dbnm + "_t" + ".text")
	if trim(ls_colnm) = "!" or trim(ls_colnm) = "?" then
		//nothing
	else
		ln_currow = dw_pre.insertrow(0)
		dw_pre.setitem(ln_currow,"dsptext",ls_colnm)
		dw_pre.setitem(ln_currow,"colnm",ls_dbnm)
		dw_pre.setitem(ln_currow,"ordchk",'A')
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
string facename = "굴림체"
string text = "취소"
end type

event clicked;s_gms_rtnsort 	lstr_rsult
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
string facename = "굴림체"
string text = "확인"
end type

event clicked;long 		ln_cntnum,ln_rowcnt
string 	ls_dsptext,ls_colnm,ls_ordchk,ls_rtnsort,ls_dspsort
s_gms_rtnsort lstr_rsult

ln_rowcnt 	= dw_post.rowcount()
ls_rtnsort 	= ""
ls_dspsort 	= ""
for ln_cntnum = 1 to ln_rowcnt
	ls_dsptext 	= dw_post.getitemstring(ln_cntnum,"dsptext")
	ls_colnm 	= dw_post.getitemstring(ln_cntnum,"colnm")
	ls_ordchk 	= dw_post.getitemstring(ln_cntnum,"ordchk")
	if ln_cntnum 	= ln_rowcnt then
		ls_rtnsort 	= ls_rtnsort + ls_colnm + " " + ls_ordchk
		ls_dspsort 	= ls_dspsort + ls_dsptext + " " + ls_ordchk
	else
		ls_rtnsort 	= ls_rtnsort + ls_colnm + " " + ls_ordchk + ","
		ls_dspsort 	= ls_dspsort + ls_dsptext + " " + ls_ordchk + ","
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
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
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

event clicked;long	ln_clicked

If row = 0 then return
ln_clicked = row
if Keydown (KeyShift!) and not ib_already_selected then
	//wf_shift_highlight (this, ln_clicked)
else
	this.SelectRow (0, false)
	this.SelectRow (ln_clicked, true)
	// A single row is now selected in the DataWindow, so change its drag icon to the 
	// single rows icon.
	this.DragIcon = "C:\kdac\bmp\row.ico"
end if
in_del_lastclicked = ln_clicked


end event

event dragdrop;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Move or copy the DataWindow rows that were dropped on this datawindow to the 
// primary buffer.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DragObject	ldo_object
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
in_del_lastclicked = 0
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

event clicked;long	ln_clicked

If row = 0 then return

ln_clicked = row
if Keydown (KeyShift!) and not ib_already_selected then
	//wf_shift_highlight (this, ln_clicked)
else
	this.SelectRow (0, false)
	this.SelectRow (ln_clicked, true)
	this.DragIcon = "C:\kdac\bmp\row.ico"
end if

in_prim_lastclicked = ln_clicked


end event

event dragdrop;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Move or copy the DataWindow rows that were dropped on this datawindow to the 
// primary buffer.
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

DragObject	ldo_object
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
in_prim_lastclicked = 0
end event

