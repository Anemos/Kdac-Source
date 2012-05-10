$PBExportHeader$w_origin_sheet09.srw
$PBExportComments$(��ȸ, �Է�, ����, ����, �μ�, �ݱ�, ����ȸ, ȭ���μ�, �ڷ����, Ư������)
forward
global type w_origin_sheet09 from window
end type
type uo_status from uo_commonstatus within w_origin_sheet09
end type
end forward

global type w_origin_sheet09 from window
integer x = 5
integer y = 212
integer width = 4663
integer height = 2688
boolean titlebar = true
string title = "OriginSheet08"
boolean controlmenu = true
boolean minbox = true
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
event ue_bcreate pbm_custom12
uo_status uo_status
end type
global w_origin_sheet09 w_origin_sheet09

type variables
// Icon�� Enabled ����
boolean i_b_retrieve,  i_b_insert,  i_b_save,     i_b_print,  i_b_delete
boolean i_b_dretrieve, i_b_dprint,  i_b_bcreate,  i_b_dchar

//Open���� Activate Event Skip ����
boolean i_b_first_open

//Security Level Check
string i_s_level

//�۾��� Error Check
int  i_n_erreturn
end variables

forward prototypes
public subroutine wf_icon_onoff (boolean ag_retrieve, boolean ag_insert, boolean ag_save, boolean ag_delete, boolean ag_print, boolean ag_bcreate, boolean ag_dretrieve, boolean ag_dprint, boolean ag_dchar)
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

event ue_bcreate;this.uo_status.st_message.text = ""
end event

public subroutine wf_icon_onoff (boolean ag_retrieve, boolean ag_insert, boolean ag_save, boolean ag_delete, boolean ag_print, boolean ag_bcreate, boolean ag_dretrieve, boolean ag_dprint, boolean ag_dchar);////////////////////////////////////////////////////////////////////////////////////////////////
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
else
	m_frame.m_action.m_insert.enabled  = ag_insert
	m_frame.m_action.m_save.enabled    = ag_save
	m_frame.m_action.m_delete.enabled  = ag_delete
end if

m_frame.m_action.m_dretrieve.enabled  	= ag_dretrieve
m_frame.m_action.m_dprint.enabled     	= ag_dprint
m_frame.m_action.m_print.enabled   		= ag_print
m_frame.m_action.m_dchar.enabled      	= ag_dchar
m_frame.m_action.m_bcreate.enabled 		= ag_bcreate

end subroutine

on w_origin_sheet09.create
this.uo_status=create uo_status
this.Control[]={this.uo_status}
end on

on w_origin_sheet09.destroy
destroy(this.uo_status)
end on

event open;// Sheet title & Status Line Setting
i_s_level	=	mid(Message.StringParm, 1, 1)
this.title 	= 	f_title_name(mid(Message.StringParm, 2, len(Message.StringParm) - 1))
this.uo_status.st_winid.text   		=	This.ClassName()
this.uo_status.st_message.text 	= 	""
this.uo_status.st_kornm.text   		= 	g_s_kornm
this.uo_status.st_date.text    		= 	String(g_s_date, "@@@@-@@-@@")

// Action Menu Off
m_frame.m_action.visible 	= 	false

// Seperate Setting
m_frame.m_action.m_sep21.visible 	= 	true
m_frame.m_action.m_sep22.visible 	= 	true

////////////////////////////////////////////////////////////////////////////////////////////
// ag_01 : ��ȸ,     ag_02 : �Է�,     ag_03 : ����,     ag_04 : ����,     ag_05 : �μ�
// ag_06 : ó��,     ag_07 : ����,     ag_08 : ����,     ag_09 : ��,       ag_10 : �̸�����
// ag_11 : �����ȸ, ag_12 : �ڷ����, ag_13 : ����ȸ, ag_14 : ȭ���μ�, ag_15 : Ư������ 
// ag_16 : None1,    ag_17 : None2
////////////////////////////////////////////////////////////////////////////////////////////
f_icon_set(true,  true,  true,  true,  true,  false,  false,  false,  false,  false, &
		  	  false, true,  true,  true,  true,  false, false)

/////////////////////////////////////////////////////////
// Default Button Status Setting
/////////////////////////////////////////////////////////
// m_retrieve
i_b_retrieve   = true
// m_insert
i_b_insert     = true
// m_save
i_b_save       = false
// m_delete
i_b_delete     = false
// m_print
i_b_print      = true
// m_bcreate
i_b_bcreate    = false
// m_dretrieve
i_b_dretrieve  = false
// m_dprint
i_b_dprint     = false
// m_dchar
i_b_dchar      = false

// Current Button Status Buffering
// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(i_b_retrieve, i_b_insert,    i_b_save,   i_b_delete,  i_b_print,  &
				  i_b_bcreate,  i_b_dretrieve, i_b_dprint, i_b_dchar)

// Action Menu On
m_frame.m_action.visible = true

// ToolBar 2 Setting  (��ü����)
w_frame.SetToolbar(2, true)
w_frame.SetToolbarPos(2, 2, 150, false)
end event

event activate;SetPointer(HourGlass!)

if	i_b_first_open	=	false then
	i_b_first_open 	= 	true
	return
else
	// Action Menu Off
	m_frame.m_action.visible	=	false
	// Seperate Setting
	m_frame.m_action.m_sep21.visible	= 	true
	m_frame.m_action.m_sep22.visible	=	true
	////////////////////////////////////////////////////////////////////////////////////////////
	// ag_01 : ��ȸ,     ag_02 : �Է�,     ag_03 : ����,     ag_04 : ����,     ag_05 : �μ�
	// ag_06 : ó��,     ag_07 : ����,     ag_08 : ����,     ag_09 : ��,       ag_10 : �̸�����
	// ag_11 : �����ȸ, ag_12 : �ڷ����, ag_13 : ����ȸ, ag_14 : ȭ���μ�, ag_15 : Ư������ 
	// ag_16 : None1,    ag_17 : None2
	////////////////////////////////////////////////////////////////////////////////////////////
	f_icon_set(	true,  true,  true,  true,  true,  false,  false,  false,  false,  false, &
				  	false, true,  true,  true,  true,  false, false)
	// ToolBar 2 Setting  (��ü����)
	w_frame.SetToolbar(2, true)
	w_frame.SetToolbarPos(2, 2, 150, false)
	/////////////////////////////////////////////////////////
	// Buffered Button Status Setting
	/////////////////////////////////////////////////////////
	// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff(i_b_retrieve, i_b_insert,    i_b_save,   i_b_delete,  i_b_print,  &
					  	i_b_bcreate,  i_b_dretrieve, i_b_dprint, i_b_dchar)
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
// m_bcreate
i_b_bcreate    = m_frame.m_action.m_bcreate.enabled
// m_dretrieve
i_b_dretrieve  = m_frame.m_action.m_dretrieve.enabled
// m_dprint
i_b_dprint     = m_frame.m_action.m_dprint.enabled
// m_dchar
i_b_dchar      = m_frame.m_action.m_dchar.enabled

end event

event timer;f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
end event

type uo_status from uo_commonstatus within w_origin_sheet09
integer x = 9
integer y = 2496
boolean enabled = false
end type

on uo_status.destroy
call uo_commonstatus::destroy
end on

