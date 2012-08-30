$PBExportHeader$w_cmms_sheet01.srw
$PBExportComments$CMMS sheet ������ü (��ȸ, �Է�, ����, ����, �μ�, �ݱ�, ����ȸ, ȭ���μ�, Ư������)
forward
global type w_cmms_sheet01 from window
end type
type uo_status from uo_commonstatus within w_cmms_sheet01
end type
end forward

global type w_cmms_sheet01 from window
integer x = 5
integer y = 212
integer width = 3959
integer height = 2100
boolean titlebar = true
string title = "Cmms OriginSheet"
boolean controlmenu = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
event ue_retrieve pbm_custom01
event ue_insert pbm_custom02
event ue_save pbm_custom03
event ue_delete pbm_custom04
event ue_print pbm_custom05
event ue_dretrieve pbm_custom16
event ue_dprint pbm_custom17
event ue_filter pbm_custom31
event ue_graph_change pbm_custom32
event ue_search pbm_custom33
event ue_set_focus pbm_custom34
event ue_sort pbm_custom35
event ue_postopen ( )
event ue_reset pbm_custom06
event ue_copy ( )
event ue_first ( )
event ue_last ( )
event ue_prev ( )
event ue_next ( )
event ue_retrieve_each_tab ( )
event ue_save_old_tab ( )
event ue_set_buttons ( )
event ue_set_data_changed ( )
event ue_set_not_refreshed ( )
event ue_preview ( )
event ue_retrieve_check ( )
uo_status uo_status
end type
global w_cmms_sheet01 w_cmms_sheet01

type variables
// Icon�� Enabled ����
boolean i_b_retrieve,  i_b_insert,  i_b_save,  i_b_print, i_b_delete
boolean i_b_dretrieve, i_b_dprint, i_b_dchar

//Open���� Activate Event Skip ����
boolean i_b_first_open

//Security Level Check
string i_s_level

//�۾��� Error Check
int  i_n_erreturn


/////////////////////////////////
// for IPIS
/////////////////////////////////

//���� ����̳� ���ĵ ���� datawindow
DATAWINDOW	idw_focused

/* ���� ���õ� graph */
GRAPH			igrp_focused

/* ���� ���õ� ListView Control */
ListView		ilv_focused

/* timer */
INTEGER		ii_timer = 1

/* iw_this */
WINDOW		iw_this

//���� �޴��� �������� ���� ����
WINDOW		iw_frame
MENU			im_menu

//Resizing�� ���� ���� ����
long			il_resize_count

/* resize�ϱ�  ���� */
Long			il_win_width, il_win_height, il_win_border = 15, &
				il_obj_left_x, il_obj_left_width, il_obj_left_y, il_obj_left_height, &
				il_obj_above_x, il_obj_above_width, il_obj_above_y, il_obj_above_height, &
				il_obj_split_v_x, il_obj_split_v_width, il_obj_split_v_y, il_obj_split_v_height, &
				il_obj_split_h_x, il_obj_split_h_width, il_obj_split_h_y, il_obj_split_h_height

//-- Define the "Register" type. --
constant integer FULL=0
constant integer LEFT=1
constant integer RIGHT=2
constant integer RIGHT_ABOVE=3
constant integer RIGHT_BELOW=4
constant integer ABOVE=5
constant integer BELOW=6
constant integer BELOW_LEFT=7
constant integer BELOW_RIGHT=8
constant integer SPLIT=9

integer		ii_bound, ii_position[]
dragobject	idrg[]
str_parms	istr_parms
string		is_size

//-> ���� �߰�
boolean ib_btn[12]		//��ư����
string	is_bmp[6]		//�߰���ư
string	is_win_id		//win id

int lnDragFrom
ListViewItem lListDrag		

string lsLabel[10000]
int lnMax

string is_descript

int ii_old_tab 
int ii_current_tab = 1
int ii_windowborder
int ii_tab_save

int lnInit = 0

boolean lbDrag
boolean ib_readonly = false
string is_filter

boolean ib_fix = true
boolean ib_debug
integer ii_BarThickness
long il_HiddenColor

boolean ib_refreshed_tab[]
boolean ib_data_changed
boolean ib_saved

Datawindow id_dw_list

end variables

forward prototypes
public function integer of_resize_register (dragobject adrg_object, integer ai_position)
public function integer of_resize ()
public subroutine wf_icon_onoff (boolean ag_retrieve, boolean ag_insert, boolean ag_save, boolean ag_delete, boolean ag_print, boolean ag_dretrieve, boolean ag_dprint, boolean ag_dchar)
public function integer wf_update_datawindow_tab (datawindow pdw, integer li_index)
public subroutine wf_set_button (string as_button1, string as_button2, string as_button3, string as_button4, string as_button5, string as_button6)
public subroutine wf_auth_button (integer ai_num, boolean ab_yn)
public subroutine wf_init_button ()
public subroutine wf_button ()
public function integer wf_close_query (datawindow adw)
public subroutine wf_message_line (string as_message)
end prototypes

event ue_retrieve;this.uo_status.st_message.text = ""

end event

event ue_insert;this.uo_status.st_message.text = ""
end event

event ue_save;this.uo_status.st_message.text = ""

i_n_erreturn = 0
end event

event ue_delete;this.uo_status.st_message.text = ""
end event

event ue_print;this.uo_status.st_message.text = ""
end event

event ue_dretrieve;this.uo_status.st_message.text = ""
end event

event ue_dprint;this.uo_status.st_message.text = ""
end event

event ue_filter;// Datawindow �ɷ�����(filter)

STR_FILTER	lstr_filter

IF NOT IsValid( idw_focused ) THEN
	MessageBox("���� ����","���õ� DataWindow�� �����ϴ�")
	RETURN
END IF

lstr_filter.dw = idw_focused
lstr_filter.title = this.Title

OpenWithParm(w_dw_filter_r, lstr_filter )
end event

event ue_graph_change;// Graph Datawindow �׷�����缱��(graph type)

IF NOT IsValid( igrp_focused ) THEN
	IF NOT IsValid( idw_focused ) THEN
		MessageBox("���� ����","���õ� �׷���(Graph)�� �����ϴ�")
		Return -1
	ELSE
		OpenWithParm( w_graph_change_r, idw_focused) 
	END IF
ELSE
	IF NOT IsValid( igrp_focused ) THEN
		MessageBox("���� ����","���õ� �׷���(Graph)�� �����ϴ�")
		Return -1
	ELSE
		OpenWithParm( w_graph_change_r, igrp_focused) 
	END IF
END IF	
	
Return 0	
end event

event ue_search;// Datawindow ã��(Search)
STR_SEARCH	lstr_search

IF NOT IsValid( idw_focused ) THEN
	MessageBox("���� ����","���õ� DataWindow�� �����ϴ�")
	RETURN
END IF

lstr_search.dw = idw_focused
lstr_search.title = this.Title

OpenWithParm(w_dw_search_r, lstr_search )
end event

event ue_set_focus;// ���� focus�� ������ �ִ� object�� ã��
// dw�̸� idw_focused�� ����
// graph�̸� igrp_focused�� ���� 
GRAPHICOBJECT	lgo_focused
STRING			ls_graphtype

SetNull( lgo_focused )
lgo_focused = GetFocus()

IF IsNull(lgo_focused) THEN
	RETURN -1
END IF

IF NOT IsValid( lgo_focused ) THEN
	RETURN -1
END IF

CHOOSE CASE TypeOf(lgo_focused)
	CASE Graph!
		igrp_focused = lgo_focused
	CASE DataWindow!
		idw_focused = lgo_focused
	CASE ListView!
		ilv_focused = lgo_focused
		
	CASE ELSE
END CHOOSE

Return 0
end event

event ue_sort;// Datawindow ����(sort)
STR_SORT	lstr_sort

IF NOT IsValid( idw_focused ) THEN
	MessageBox("���� ����","���õ� DataWindow�� �����ϴ�")
	RETURN
END IF

lstr_sort.dw = idw_focused
lstr_sort.title = this.Title

OpenWithParm(w_dw_sort_r, lstr_sort )
end event

event ue_reset;this.uo_status.st_message.text = ""
end event

event ue_first();long lRow, lRowCount

If isvalid(id_dw_list) then	

	if ib_data_changed then
		this.TriggerEvent('ue_save')
	end if
	
	lRowCount = id_dw_list.RowCount()
	
	if lRowCount <= 0 then
		return
	end if
	
	id_dw_list.SetRow(1)
	id_dw_list.ScrollToRow(1)
	
	this.TriggerEvent('ue_retrieve_each_tab')
End If	
end event

event ue_last();long lRow, lRowCount

If isvalid(id_dw_list) then	

	if ib_data_changed then
		this.TriggerEvent('ue_save')
	end if
	
	lRowCount = id_dw_list.RowCount()
	
	if lRowCount <= 0 then
		return
	end if
	
	id_dw_list.SetRow(lRowCount)
	id_dw_list.ScrollToRow(lRowCount)
	
	this.TriggerEvent('ue_retrieve_each_tab')
End IF	
end event

event ue_prev();long lRow, lRowCount

If isvalid(id_dw_list) then	
	
	if ib_data_changed then
		this.TriggerEvent('ue_save')
	end if
	
	lRowCount = id_dw_list.RowCount()
	
	if lRowCount <= 0 then
		return
	end if
	
	lRow = id_dw_list.GetRow()
	if lRow <> 1 then
		lRow -= 1
	end if
	id_dw_list.SetRow(lRow)
	id_dw_list.ScrollToRow(lRow)
	
	this.TriggerEvent('ue_retrieve_each_tab')
End IF	
end event

event ue_next();long lRow, lRowCount

If isvalid(id_dw_list) then	

	if ib_data_changed then
		this.TriggerEvent('ue_save')
	end if
	
	lRowCount = id_dw_list.RowCount()
	
	if lRowCount <= 0 then
		return
	end if
	
	lRow = id_dw_list.GetRow()
	if lRow <> lRowCount then
		lRow += 1
	end if
	id_dw_list.SetRow(lRow)
	id_dw_list.ScrollToRow(lRow)
	
	this.TriggerEvent('ue_retrieve_each_tab')
End If	
end event

event ue_retrieve_check();if ii_current_tab = 1 then
	This.TriggerEvent('ue_retrieve')
else
	if check_conn = '1' then
		This.TriggerEvent('ue_retrieve')
	
	else
		This.TriggerEvent('ue_retrieve_each_tab')
	end if
end if
check_conn = '2'
wf_message_line('��ȸ�Ϸ�')
end event

public function integer of_resize_register (dragobject adrg_object, integer ai_position);////////////////////////////////////////////////////////////
//
//  Resize �ϰ��� �ϴ� ��� ��ü ���
//
//  Argument : adrg_object : Resizing target Object Name
//             ai_position : Resizing ���� ��ġ
//
//  ex)of_resize_register(adrg_object,ai_position)
//
//  �ش� Object�� Resizing ��ġ�� of_resize_register���� ���
////////////////////////////////////////////////////////////

Integer	li_rc
Integer	li_upperbound
Integer	li_obj

// resize ����� �ѹ��� ..
if il_resize_count <> 1 then
	return 1
end if

// Validate the dragobject.
If IsNull(adrg_object) Or Not IsValid(adrg_object) Then 
	Return -1
End If

// Validate the position parameter.
If IsNull(ai_position) Or ai_position < 0 Or ai_position > 9 Then 
	Return -1
End If

// Make sure this object is not already registered on array.
li_upperbound = UpperBound (idrg)
For li_obj = 1 to li_upperbound
	If IsValid(idrg[li_obj]) Then
		If adrg_object = idrg[li_obj] Then
			Return -1
		End If
	End If
Next

// Register the new object.
li_upperbound = UpperBound (idrg) + 1
idrg[li_upperbound] = adrg_object
ii_position[li_upperbound] = ai_position

Return 1

end function

public function integer of_resize ();////////////////////////////////////////////////////////////
//
//  Resize ��� ��ü�� ���Ͽ� Resizing �۾�
//
//  ex)of_resize()
//
//  �ش� Object�� Resizing ��ġ�� of_resize_register���� ���
//
////////////////////////////////////////////////////////////

long 				li_differenceW_half, li_differenceH_half
integer  		li_count, li_upperbound, li_position
dragobject		ld_obj

//if il_differenceH = 0 then
//	li_differenceH_half = 0
//else
//	li_differenceH_half = il_differenceH / 2
//end if
//
//if il_differenceW = 0 then
//	li_differenceW_half = 0
//else
//	li_differenceW_half = il_differenceW / 2
//end if

li_upperbound = UpperBound (idrg)
For li_count = 1 to li_upperbound
	ld_obj = idrg[li_count] 
	li_position = ii_position[li_count]
	choose case li_position
		case FULL
			ld_obj.Move(ld_obj.X, ld_obj.Y)
			ld_obj.Resize(il_win_width - (3.5 * il_win_border), il_win_height - ld_obj.Y - il_win_border)
		case LEFT
			ld_obj.Move(ld_obj.X, ld_obj.Y)
			ld_obj.Resize(ld_obj.width, il_win_height - ld_obj.Y - il_win_border)
			il_obj_left_x			= ld_obj.X
			il_obj_left_y			= ld_obj.Y
			il_obj_left_width		= ld_obj.Width
			il_obj_left_height	= ld_obj.Height
		case RIGHT
			ld_obj.Move(il_obj_split_v_x + il_obj_split_v_width, il_obj_left_y)
			ld_obj.Resize(il_win_width - il_obj_split_v_x - il_obj_split_v_width - (2 * il_win_border), il_obj_left_height)
		case RIGHT_ABOVE
			ld_obj.Move(il_obj_split_v_x + il_obj_split_v_width, il_obj_left_y)
			ld_obj.Resize(il_win_width - il_obj_split_v_x - il_obj_split_v_width - (2 * il_win_border), ld_obj.Height)
			il_obj_above_x			= ld_obj.X
			il_obj_above_y			= ld_obj.Y
			il_obj_above_width	= ld_obj.Width
			il_obj_above_height	= ld_obj.Height
		case RIGHT_BELOW
			ld_obj.Move(il_obj_split_v_x + il_obj_split_v_width, il_obj_split_h_y + il_obj_split_h_height)
			ld_obj.Resize(il_win_width - il_obj_split_v_x - il_obj_split_v_width - (2 * il_win_border), il_win_height - il_obj_split_h_y - il_obj_split_h_height - (1 * il_win_border))
		case ABOVE
			ld_obj.Move(ld_obj.X, ld_obj.Y)
			ld_obj.Resize(il_win_width - (3.5 * il_win_border), ld_obj.height)
			il_obj_above_x			= ld_obj.X
			il_obj_above_y			= ld_obj.Y
			il_obj_above_width	= ld_obj.Width
			il_obj_above_height	= ld_obj.Height
		case BELOW
			ld_obj.move(il_obj_above_x, il_obj_split_h_y + il_obj_split_h_height)
			ld_obj.Resize(il_obj_above_width, il_win_height - il_obj_split_h_y - il_obj_split_h_height - (1 * il_win_border))
		case BELOW_LEFT
			ld_obj.move(ld_obj.X, il_obj_split_h_y + il_obj_split_h_height)
			ld_obj.Resize(ld_obj.width, il_win_height - il_obj_split_h_y - il_obj_split_h_height - (1 * il_win_border))
			il_obj_left_x			= ld_obj.X
			il_obj_left_y			= ld_obj.Y
			il_obj_left_width		= ld_obj.Width
			il_obj_left_height	= ld_obj.Height
		case BELOW_RIGHT
			ld_obj.move(il_obj_above_x, il_obj_split_h_y + il_obj_split_h_height)
			ld_obj.Resize(il_win_width - il_obj_split_v_x - il_obj_split_v_width - (2 * il_win_border), il_win_height - il_obj_split_h_y - il_obj_split_h_height - (1 * il_win_border))
		case SPLIT
			IF ld_obj.height >= ld_obj.width then	// ���� bar => st_v_bar
				ld_obj.move(il_obj_left_x + il_obj_left_width + 5, il_obj_left_y)
				ld_obj.Resize(15, il_obj_left_height)
				il_obj_split_v_x			= ld_obj.X
				il_obj_split_v_y			= ld_obj.Y
				il_obj_split_v_width	= ld_obj.Width
				il_obj_split_v_height	= ld_obj.Height
			else		// ���� bar => st_h_bar
				ld_obj.move(il_obj_above_x, il_obj_above_y + il_obj_above_height + 5)
				ld_obj.Resize(il_obj_above_width, 15)
				il_obj_split_h_x			= ld_obj.X
				il_obj_split_h_y			= ld_obj.Y
				il_obj_split_h_width	= ld_obj.Width
				il_obj_split_h_height	= ld_obj.Height
			end if
	end choose
next

return 1

//////////////////////////////////////////////////////////////
////
////  Resize ��� ��ü�� ���Ͽ� Resizing �۾�
////
////  ex)of_resize()
////
////  �ش� Object�� Resizing ��ġ�� of_resize_register���� ���
////
//////////////////////////////////////////////////////////////
//
//long 				li_differenceW_half, li_differenceH_half
//integer  		li_count, li_upperbound, li_position
//dragobject		ld_obj
//
//if il_differenceH = 0 then
//	li_differenceH_half = 0
//else
//	li_differenceH_half = il_differenceH / 2
//end if
//
//if il_differenceW = 0 then
//	li_differenceW_half = 0
//else
//	li_differenceW_half = il_differenceW / 2
//end if
//
//li_upperbound = UpperBound (idrg)
//For li_count = 1 to li_upperbound
//	ld_obj = idrg[li_count] 
//	li_position = ii_position[li_count]
//	choose case li_position
//		case FULL
//			ld_obj.width = ld_obj.width + il_differenceW 
//			ld_obj.height = ld_obj.height + il_differenceH 
//		case LEFT
//			ld_obj.width = ld_obj.width + li_differenceW_half 
//			ld_obj.height = ld_obj.height + il_differenceH  
//		case RIGHT
//			ld_obj.move(ld_obj.x + li_differenceW_half, ld_obj.y )
//			ld_obj.width = ld_obj.width + li_differenceW_half 
//			ld_obj.height = ld_obj.height + il_differenceH 
//		case ABOVE
//			ld_obj.width = ld_obj.width + il_differenceW
//			ld_obj.height = ld_obj.height + li_differenceH_half 
//		case BELOW
//			ld_obj.move(ld_obj.x, ld_obj.y + li_differenceH_half)
//			ld_obj.width = ld_obj.width + il_differenceW
//			ld_obj.height = ld_obj.height + li_differenceH_half 
//		case SPLIT
//			IF ld_obj.height >= ld_obj.width then
//				ld_obj.move(ld_obj.x + li_differenceW_half, ld_obj.y )
//				ld_obj.height = ld_obj.height + il_differenceH 
//			else
//				ld_obj.move(ld_obj.x, ld_obj.y + li_differenceH_half)
//				ld_obj.width = ld_obj.width + il_differenceW 
//			end if
//	end choose
//next
//
//return 1
end function

public subroutine wf_icon_onoff (boolean ag_retrieve, boolean ag_insert, boolean ag_save, boolean ag_delete, boolean ag_print, boolean ag_dretrieve, boolean ag_dprint, boolean ag_dchar);////////////////////////////////////////////////////////////////////////////////////////////////
//       wf_button(��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������)
//                 input  value true/false
//                 return value none
////////////////////////////////////////////////////////////////////////////////////////////////

// m_retrieve
m_frame.m_action.m_retrieve.enabled   = ag_retrieve

// m_insert, m_save, m_delete, m_print
if i_s_level = "1" then
	m_frame.m_action.m_insert.enabled  = false
	m_frame.m_action.m_save.enabled    = false
	m_frame.m_action.m_delete.enabled  = false
	m_frame.m_action.m_print.enabled   = ag_print
else
	m_frame.m_action.m_insert.enabled  = ag_insert
	m_frame.m_action.m_save.enabled    = ag_save
	m_frame.m_action.m_delete.enabled  = ag_delete
	m_frame.m_action.m_print.enabled   = ag_print
end if

// m_dretrieve
m_frame.m_action.m_dretrieve.enabled  = ag_dretrieve
// m_dprint
m_frame.m_action.m_dprint.enabled     = ag_dprint
// m_dchar
m_frame.m_action.m_dchar.enabled      = ag_dchar

end subroutine

public function integer wf_update_datawindow_tab (datawindow pdw, integer li_index);long ll_i
if pdw.update() <> 1 then
	// sql error 
	for ll_i = 1 to li_index // ������ ���忡 ���� �ϸ� �ٸ� tab���� �̵��ϴ��� retrieve���� �ʴ´�. �ֳ��ϸ� �ٽ� ���� tab���� �ð��̴ϱ�
		ib_refreshed_tab[ll_i] = true 
	next
	ib_data_changed = false
	return -1  // ����
else
	commit;
	
	ib_saved = true
	ib_data_changed = false
	for ll_i = 1 to li_index
		ib_refreshed_tab[ll_i] = false
	next
	wf_message_line('���强��!')	
	return 1  // ����
end if






end function

public subroutine wf_set_button (string as_button1, string as_button2, string as_button3, string as_button4, string as_button5, string as_button6);is_bmp[1] = as_button1
is_bmp[2] = as_button2
is_bmp[3] = as_button3
is_bmp[4] = as_button4
is_bmp[5] = as_button5
is_bmp[6] = as_button6

end subroutine

public subroutine wf_auth_button (integer ai_num, boolean ab_yn);//boolean lb_auth
//
//Choose Case ai_num
//	Case 1
//		IF ab_yn = true Then
//			//������ ���� ��쿡�� �׳� ����
//			lb_auth = f_security(is_win_id,gs_empcode,gs_group,'_RETRIEVE_')
//			If lb_auth = false Then
//				ab_yn = false
//			End if
//		End if
//	Case 2
//		IF ab_yn = true Then
//			//������ ���� ��쿡�� �׳� ����
//			lb_auth = f_security(is_win_id,gs_empcode,gs_group,'_INSERT_')
//			If lb_auth = false Then
//				ab_yn = false
//			End if
//		End if
//	Case 3
//		IF ab_yn = true Then
//			//������ ���� ��쿡�� �׳� ����
//			lb_auth = f_security(is_win_id,gs_empcode,gs_group,'_DELETE_')
//			If lb_auth = false Then
//				ab_yn = false
//			End if
//		End if
//	Case 4
//		IF ab_yn = true Then
//			//������ ���� ��쿡�� �׳� ����
//			lb_auth = f_security(is_win_id,gs_empcode,gs_group,'_SAVE_')
//			If lb_auth = false Then
//				ab_yn = false
//			End if
//		End if
//	Case 5
//		IF ab_yn = true Then
//			//������ ���� ��쿡�� �׳� ����
//			lb_auth = f_security(is_win_id,gs_empcode,gs_group,'_PRINT_')
//			If lb_auth = false Then
//				ab_yn = false
//			End if
//		End if
//End Choose
//
//ib_btn[ai_num] = ab_yn

							 
end subroutine

public subroutine wf_init_button ();//BOOLEAN lb_auth1,lb_auth2,lb_auth3,lb_auth4,lb_auth5
//
//IF isnull(gs_tag) or trim(gs_tag) = "" Then
//	is_win_id = this.ClassName()
//Else
//	is_win_id = gs_tag
//	gs_tag = ""
//End if
//
////�� ����(��ư)�� ���� ���ѹ迭�� �ʱ�ȭ
//lb_auth1 = f_security(is_win_id,gs_empcode,gs_group,'_RETRIEVE_')
//lb_auth2 = f_security(is_win_id,gs_empcode,gs_group,'_INSERT_')
//lb_auth3 = f_security(is_win_id,gs_empcode,gs_group,'_DELETE_')
//lb_auth4 = f_security(is_win_id,gs_empcode,gs_group,'_SAVE_')
//lb_auth5 = f_security(is_win_id,gs_empcode,gs_group,'_PRINT_')
//
////
//ib_btn[] = {lb_auth1,lb_auth2,lb_auth3,lb_auth4,lb_auth5}
////ib_btn[] = {true,true,true,true,true,true,&
////				true,true,true,true,true,true}


end subroutine

public subroutine wf_button ();
menu lm_temp
int ii,li_index
string ls_WindowName,ls_path,ls_bmp[6]

//ls_path = gs_path + 'bmp\'
//ls_path = 'bmp\'
//�۾��޴� ����
//lm_temp = gw_frame.menuid

//�ڷ� Menu ã��
li_index = 2

//�߰���ư ����
//For ii = 1 To 5
//	ls_bmp[ii] = ls_path + is_bmp[ii] + '.bmp'
//Next

//If trim(is_bmp[1]) = '' Then
	//������ Ȱ��ȭ
//	lm_temp.item[li_index].item[6].visible = true
//Else
	//������ ���̱�
//	lm_temp.item[li_index].item[6].visible = false
//End if

//�ʿ��� Toolbar�� ���̵��� �Ѵ�.
//For ii = 1 To 5
//	If is_bmp[ii] > "" Then
//		lm_temp.item[li_index].item[ii+6].ToolbarItemtext	 = is_bmp[ii]	//��ư��
//		lm_temp.item[li_index].item[ii+6].ToolbarItemName	 = ls_bmp[ii]		//��ư�׸�
//		lm_temp.item[li_index].item[ii+6].ToolbarItemVisible	 = true			

//		lm_temp.item[li_index].item[ii+6].text = is_bmp[ii] + "~t" + 'F' + string(ii)
//		lm_temp.item[li_index].item[ii+6].visible = true
//	Else
//		lm_temp.item[li_index].item[ii+6].ToolbarItemVisible	 = false
//		lm_temp.item[li_index].item[ii+6].visible = false
//	End if
//Next

//�����ư ���� ����
//For ii = 1 To 5
//	lm_temp.item[li_index].item[ii].enabled	 = ib_btn[ii]
//Next

//�߰���ư ���� ����
//For ii = 7 To 12
//	lm_temp.item[li_index].item[ii].enabled	 = ib_btn[ii - 1]
//Next
end subroutine

public function integer wf_close_query (datawindow adw);integer	li_rc
boolean lb_auth

//return 0 : �׳� ����
//return 1 : ���� �Ұ�
adw.AcceptText()
If isvalid(w_frame) = false Then return 0
// ������� ���� ������ ������ ��
// success : return 0,  error : return 1
if adw.modifiedCount() + adw.DeletedCount() > 0 then
	//���������� ���� ��쿡�� �׳� ����
	this.setfocus()
	li_rc = MessageBox("Ȯ��", "������� ���� Data�� �����Ͻðڽ��ϱ�?",  &
	                    Question!, YesNoCancel!, 3)
	// ���� �� ����
	IF li_rc = 1 THEN  
		this.triggerevent("ue_save")
			if adw.modifiedCount() + adw.DeletedCount() > 0 then
				//gw_frame.ib_close = false
				return 1
			Else
				RETURN 0
			End if
	// �׳� ����
	ELSEIF li_rc = 2 THEN
		RETURN 0
	// ���
	ELSE
		//gw_frame.ib_close = false
		RETURN 1  
	END IF
else
	return 0
end if

end function

public subroutine wf_message_line (string as_message);uo_status.st_message.text = ' ' + as_message
end subroutine

on w_cmms_sheet01.create
this.uo_status=create uo_status
this.Control[]={this.uo_status}
end on

on w_cmms_sheet01.destroy
destroy(this.uo_status)
end on

event open;str_parm str_get_parm

str_get_parm = Message.PowerObjectParm

if Isvalid(str_get_parm) then
	i_s_level = str_get_parm.s_parm[1]
	iw_this = This
	this.title = str_get_parm.s_parm[2]
else
	// Sheet title & Status Line Setting
	i_s_level  = mid(Message.StringParm, 1, 1)
	//set iw_this
	iw_this = THIS
	this.title = f_title_name(mid(Message.StringParm, 2, len(Message.StringParm) - 1))
end if

//if g_s_kornm = "" then
//	g_s_kornm = "IPIS2000"
//end if

this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = g_s_date
this.uo_status.st_time.text    = g_s_time

// Action Menu Off
//m_frame.m_action.visible = false

// Seperate Setting
m_frame.m_action.m_sep21.visible = true
m_frame.m_action.m_sep22.visible = true

////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : ��ȸ,     ag_02 : �Է�,     ag_03 : ����,     ag_04 : ����,     ag_05 : �μ�
// ag_06 : ó��,     ag_07 : ����,     ag_08 : ����,     ag_09 : ��,       ag_10 : �̸�����
// ag_11 : �����ȸ, ag_12 : �ڷ����, ag_13 : ����ȸ, ag_14 : ȭ���μ�, ag_15 : Ư������ 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
f_icon_set(	true,		true,		true,		true,		true, &
				false,	false,	false,	false,	false, &
				false,	false,	false,	false,	false, &
				false,	false)

/////////////////////////////////////////////////////////
// Default Button Status Setting
/////////////////////////////////////////////////////////
// m_retrieve
i_b_retrieve   = true
// m_insert
i_b_insert     = true
// m_save
i_b_save       = true
// m_delete
i_b_delete     = true
// m_print
i_b_print      = true
// m_dretrieve
i_b_dretrieve = false
// m_dprint
i_b_dprint    = false
// m_dchar
i_b_dchar     = false

// Current Button Status Buffering
// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
			     i_b_dretrieve,  i_b_dprint,    i_b_dchar)

// Action Menu On
m_frame.m_action.visible = true

// ToolBar 2 Setting  (��ü����)
w_frame.SetToolbar(2, true)
w_frame.SetToolbarPos(2, 2, 150, false)

// Post Open Event
THIS.PostEvent('ue_postopen')

// for resize
//THIS.PostEvent( Resize! )

end event

event activate;SetPointer(HourGlass!)

this.uo_status.st_message.text = ""
if i_b_first_open = false then
	i_b_first_open = true
	return
else
	// Action Menu Off
	m_frame.m_action.visible = false
	
	// Seperate Setting
	m_frame.m_action.m_sep21.visible = true
	m_frame.m_action.m_sep22.visible = true
	
	////////////////////////////////////////////////////////////////////////////////////////////
	// ag_01 : ��ȸ,     ag_02 : �Է�,     ag_03 : ����,     ag_04 : ����,     ag_05 : �μ�
	// ag_06 : ó��,     ag_07 : ����,     ag_08 : ����,     ag_09 : ��,       ag_10 : �̸�����
	// ag_11 : �����ȸ, ag_12 : �ڷ����, ag_13 : ����ȸ, ag_14 : ȭ���μ�, ag_15 : Ư������ 
	// ag_16 : None1,    ag_17 : None2
	////////////////////////////////////////////////////////////////////////////////////////////
	f_icon_set(	true,		true,		true,		true,		true, &
					false,	false,	false,	false,	false, &
					false,	false,	false,	false,	false, &
					false,	false)
	
	// ToolBar 2 Setting  (��ü����)
	w_frame.SetToolbar(2, true)
	w_frame.SetToolbarPos(2, 2, 150, false)
	
	/////////////////////////////////////////////////////////
	// Buffered Button Status Setting
	/////////////////////////////////////////////////////////
	// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_dretrieve,  i_b_dprint,    i_b_dchar)
	
	// Action Menu On
	m_frame.m_action.visible = true
	
	// -> cmms add logic
	
	//��ư���� �ʱ�ȭ
	wf_init_button()
	//wf_size_it()
	
	//��ư���� ����
	wf_button()
	
	// MDI Frame�� Window ID�� setting�Ѵ�. 
	//gw_frame.sle_win_id.text = this.Classname()
	
	//SetCurrentDirectory(gs_path + "BMP")
	
	// Message Line Clear
	wf_message_line(' ')
	
	//m_main_frame.mf_set_module_menu()
	// <- cmms end logic
	
end if

//timer(3000)
end event

event deactivate;/////////////////////////////////////////////////////////
// Current Button Status Buffering
/////////////////////////////////////////////////////////
// m_retrieve
i_b_retrieve   = m_frame.m_action.m_retrieve.enabled
// m_insert
i_b_insert     = m_frame.m_action.m_insert.enabled
// m_save
i_b_save       = m_frame.m_action.m_save.enabled
// m_delete
i_b_delete     = m_frame.m_action.m_delete.enabled
// m_print
i_b_print      = m_frame.m_action.m_print.enabled
// m_dretrieve
i_b_dretrieve  = m_frame.m_action.m_dretrieve.enabled
// m_dprint
i_b_dprint     = m_frame.m_action.m_dprint.enabled
// m_dchar
i_b_dchar      = m_frame.m_action.m_dchar.enabled

end event

event timer;select current time into :g_s_time from pbcommon.comm000 using sqlca;
uo_status.st_time.text = mid(g_s_time,1,5)
end event

event resize;//messagebox("", "resize")

is_size	= Left(String(WorkSpaceX()) + Space(10), 10)	+ &
			  Left(String(WorkSpaceY()) + Space(10), 10)	+ &
			  Left(String(WorkSpaceWidth()) + Space(10), 10) + &
			  Left(String(WorkSpaceHeight()) + Space(10), 10)

// status bar ��ġ ����
uo_status.Move(il_win_border, This.height - uo_status.height - 150)
uo_status.Resize(This.width - (2 * il_win_border), uo_status.height)

uo_status.st_message.width = uo_status.width - uo_status.st_winid.width - &
	uo_status.st_kornm.width - uo_status.st_date.width - 20
uo_status.st_kornm.x = uo_status.st_message.x + uo_status.st_message.width
uo_status.st_date.x = uo_status.st_kornm.x + uo_status.st_kornm.width
uo_status.st_time.x = uo_status.st_date.x + 375

il_win_width = This.width //- (3 * il_win_border) //- il_old_workspacewidth
il_win_height = This.Height - uo_status.height - 110

//// �ϴ� �����찡 ���� �Ǹ� ó������ setting�� ����
//IF il_old_workspaceheight < 0 OR il_old_workspacewidth < 0 THEN
//	il_old_workspaceWidth = uo_status.width
//	il_old_workspaceHeight = uo_status.y + uo_status.height
//
//	//window�� ũ�Ⱑ ���ϸ� �Բ� ����
//	// status bar ��ġ ����
//	uo_status.y = This.height - uo_status.height - 110
//	uo_status.width = This.width - 30
//	
//	uo_status.st_message.width = uo_status.width - uo_status.st_winid.width - &
//		uo_status.st_kornm.width - uo_status.st_date.width - 20
//	uo_status.st_kornm.x = uo_status.st_message.x + uo_status.st_message.width
//	uo_status.st_date.x = uo_status.st_kornm.x + uo_status.st_kornm.width
//	uo_status.st_time.x = uo_status.st_date.x + 375
//
//	//��ӹ��� ��ü(uo_status)�� ��ġ�� �ٲ ���� �����ϱ� ����
////	IF si_instance_count > 1 THEN
////		il_old_workspaceHeight -= 84
////		il_old_workspaceWidth += 10
////	END IF
//	RETURN
//END IF
//
//// ���� ���ʹ� �����찡 ���� �� �Ŀ� Size �� ����Ǵ� ����̴�.
////���� ���
//il_differenceW = THIS.WorkSpaceWidth() - il_old_workspacewidth
//il_differenceH = THIS.WorkSpaceHeight() - il_old_workspaceheight
//
//IF il_differenceW = 0 AND il_differenceH = 0 THEN RETURN
//
////window�� ũ�Ⱑ ���ϸ� �Բ� ����
//// status bar ��ġ ����
//uo_status.Move(uo_status.X, This.height - uo_status.height - 110)
//uo_status.Resize(This.width - 30, uo_status.height)
//
//uo_status.st_message.width = uo_status.width - uo_status.st_winid.width - &
//	uo_status.st_kornm.width - uo_status.st_date.width - 20
//uo_status.st_kornm.x = uo_status.st_message.x + uo_status.st_message.width
//uo_status.st_date.x = uo_status.st_kornm.x + uo_status.st_kornm.width
//uo_status.st_time.x = uo_status.st_date.x + 375
//
////����ũ�� ����
//il_old_workspaceWidth = THIS.WorkSpaceWidth()
//il_old_workspaceHeight = THIS.WorkSpaceHeight()
//
////window�� ũ�Ⱑ maximize�� ���°� �ƴϸ� scroll bar�� ���̰�
////
////IF this.width < 3004 THEN
////	this.HScrollBar = TRUE
////ELSE
////	this.HScrollBar = FALSE
////END IF
////
////IF this.height < 2112 THEN
////	this.VScrollBar = TRUE
////ELSE
////	this.VScrollBar = FALSE
////END IF
////
////Resize���� - �������� ũ�⺯ȭ�� ���� control���� ��ġ ��ȭ ����
////	Type:1 - ��ġ�� ������ä�� �¿�ũ�⺯��
//
end event

event closequery;//integer li_return
//long aaa
//
//if ib_data_changed then
//	li_return = MessageBox(gs_sys_name, '���� �������� ���� �����Ͱ� �ֽ��ϴ�. ' + '~r~r' + &
//					'�����Ͻðڽ��ϱ�?', Question!, YesNoCancel!, 2)
//	if li_return = 1 then
//		
//		aaa = this.event ue_save()
//		if aaa = 0 then
//			Return 1
//		else
//			Return 0
//		end if
//	elseif li_return = 2 then
//		Return 0
//	else
//		Return 1
//	end if
//else
//		Return 0	
//end if
end event

type uo_status from uo_commonstatus within w_cmms_sheet01
integer x = 14
integer y = 1896
integer width = 3927
integer height = 88
boolean enabled = false
end type

on uo_status.destroy
call uo_commonstatus::destroy
end on

