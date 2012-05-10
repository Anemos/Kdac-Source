$PBExportHeader$w_ipis_sheet01.srw
$PBExportComments$IPIS sheet ������ü (��ȸ, �Է�, ����, ����, �μ�, �ݱ�, ����ȸ, ȭ���μ�, Ư������)
forward
global type w_ipis_sheet01 from window
end type
type uo_status from uo_commonstatus within w_ipis_sheet01
end type
end forward

global type w_ipis_sheet01 from window
integer x = 5
integer y = 212
integer width = 3657
integer height = 2100
boolean titlebar = true
string title = "OriginSheet08"
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
uo_status uo_status
end type
global w_ipis_sheet01 w_ipis_sheet01

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
end variables

forward prototypes
public function integer of_resize_register (dragobject adrg_object, integer ai_position)
public function integer of_resize ()
public subroutine wf_icon_onoff (boolean ag_retrieve, boolean ag_insert, boolean ag_save, boolean ag_delete, boolean ag_print, boolean ag_dretrieve, boolean ag_dprint, boolean ag_dchar)
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

on w_ipis_sheet01.create
this.uo_status=create uo_status
this.Control[]={this.uo_status}
end on

on w_ipis_sheet01.destroy
destroy(this.uo_status)
end on

event open;// Sheet title & Status Line Setting
i_s_level  = mid(Message.StringParm, 1, 1)

//messagebox("", "open")

//set iw_this
iw_this = THIS

this.title = f_title_name(mid(Message.StringParm, 2, len(Message.StringParm) - 1))

//if g_s_kornm = "" then
//	g_s_kornm = "IPIS2000"
//end if

this.uo_status.st_winid.text   = This.ClassName()
this.uo_status.st_message.text = ""
this.uo_status.st_kornm.text   = g_s_kornm
this.uo_status.st_date.text    = string(g_s_date, "@@@@-@@-@@")

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

if 	i_b_first_open = false then
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
	f_icon_set(	true,	true,	true,	true,	true, &
					false,	false,	false,	false,	false, &
					false,	false,	false,	false,	false, &
					false,	false	)
	
	// ToolBar 2 Setting  (��ü����)
	w_frame.SetToolbar(2, true)
	w_frame.SetToolbarPos(2, 2, 150, false)
	
	/////////////////////////////////////////////////////////
	// Buffered Button Status Setting
	/////////////////////////////////////////////////////////
	// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff(	i_b_retrieve,	i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  	i_b_dretrieve,	i_b_dprint,	i_b_dchar)
	
	// Action Menu On
	m_frame.m_action.visible	=	true
end if

timer(30)
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

uo_status.st_message.width = 	uo_status.width - uo_status.st_winid.width - &
										uo_status.st_kornm.width - uo_status.st_date.width - 20
uo_status.st_kornm.x = uo_status.st_message.x + uo_status.st_message.width
uo_status.st_date.x 	= uo_status.st_kornm.x + uo_status.st_kornm.width
uo_status.st_time.x 	= uo_status.st_date.x + 375

il_win_width 	= This.width //- (3 * il_win_border) //- il_old_workspacewidth
il_win_height 	= This.Height - uo_status.height - 150

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

event key;//if key = keyenter!	then
//	this.TriggerEvent("ue_retrieve")
//end if
end event

type uo_status from uo_commonstatus within w_ipis_sheet01
integer x = 14
integer y = 1872
integer width = 3589
integer height = 76
boolean enabled = false
end type

on uo_status.destroy
call uo_commonstatus::destroy
end on

