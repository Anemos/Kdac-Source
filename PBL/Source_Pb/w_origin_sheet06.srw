$PBExportHeader$w_origin_sheet06.srw
$PBExportComments$(�����ȸ, �ڷ����, �ݱ�, ����ȸ, ȭ���μ�, Ư������)
forward
global type w_origin_sheet06 from window
end type
type uo_status from uo_commonstatus within w_origin_sheet06
end type
end forward

global type w_origin_sheet06 from window
integer x = 5
integer y = 212
integer width = 4663
integer height = 2688
boolean titlebar = true
string title = "OriginSheet06"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
event ue_bretrieve pbm_custom11
event ue_bcreate pbm_custom12
event ue_dretrieve pbm_custom16
event ue_dprint pbm_custom17
uo_status uo_status
end type
global w_origin_sheet06 w_origin_sheet06

type variables
// Icon�� Enabled ����
boolean i_b_bretrieve,  i_b_bcreate, i_b_dretrieve
boolean i_b_dprint, i_b_dchar

//Open���� Activate Event Skip ����
boolean i_b_first_open

//Security Level Check
string i_s_level
end variables

forward prototypes
public subroutine wf_icon_onoff (boolean ag_bretrieve, boolean ag_bcreate, boolean ag_dretrieve, boolean ag_dprint, boolean ag_dchar)
end prototypes

event ue_bretrieve;this.uo_status.st_message.text = ""
end event

event ue_bcreate;this.uo_status.st_message.text = ""
end event

event ue_dretrieve;this.uo_status.st_message.text = ""
end event

event ue_dprint;this.uo_status.st_message.text = ""
end event

public subroutine wf_icon_onoff (boolean ag_bretrieve, boolean ag_bcreate, boolean ag_dretrieve, boolean ag_dprint, boolean ag_dchar);//////////////////////////////////////////////////////////////////////////
//       wf_button(�����ȸ, �ڷ����, ����ȸ, ȭ���μ�, Ư������)
//                 input  value true/false
//                 return value none
//////////////////////////////////////////////////////////////////////////

// m_bretrieve
m_frame.m_action.m_bretrieve.enabled  = ag_bretrieve

// m_bcreate
//if i_s_level = "1" then
//	m_frame.m_action.m_bcreate.enabled = false
//else
m_frame.m_action.m_bcreate.enabled = ag_bcreate
//end if

// m_dretrieve
m_frame.m_action.m_dretrieve.enabled  = ag_dretrieve
// m_dprint
m_frame.m_action.m_dprint.enabled     = ag_dprint
// m_dchar
m_frame.m_action.m_dchar.enabled      = ag_dchar

end subroutine

on w_origin_sheet06.create
this.uo_status=create uo_status
this.Control[]={this.uo_status}
end on

on w_origin_sheet06.destroy
destroy(this.uo_status)
end on

event open;// Sheet title & Status Line Setting
i_s_level  		= 	mid(Message.StringParm, 1, 1)
this.title 			= 	f_title_name(mid(Message.StringParm, 2, len(Message.StringParm) - 1))
this.uo_status.st_winid.text   		= 	This.ClassName()
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
f_icon_set(false, false, false, false, false, false, false, false, false, false, &
			  true,  true,  true,  true,  true,  false, false)

/////////////////////////////////////////////////////////
// Default Button Status Setting
/////////////////////////////////////////////////////////
// m_bretrieve
i_b_bretrieve = true
// m_bcreate
i_b_bcreate   = false
// m_dretrieve
i_b_dretrieve = false
// m_dprint
i_b_dprint    = false
// m_dchar
i_b_dchar     = false

// Current Button Status Buffering
// �����ȸ, �ڷ����, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)

// Action Menu On
m_frame.m_action.visible = true

// ToolBar 2 Setting  (��ü����)
w_frame.SetToolbar(2, true)
w_frame.SetToolbarPos(2, 2, 150, false)
end event

event activate;SetPointer(HourGlass!)

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
	f_icon_set(true, false, false, false, true, false, false, false, false, false, &
				  true,  true,  true,  true,  true,  false, false)
	
	// ToolBar 2 Setting  (��ü����)
	w_frame.SetToolbar(2, true)
	w_frame.SetToolbarPos(2, 2, 150, false)
	
	/////////////////////////////////////////////////////////
	// Buffered Button Status Setting
	/////////////////////////////////////////////////////////
	// �����ȸ, �ڷ����, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
	
	// Action Menu On
	m_frame.m_action.visible = true
end if

timer(30)
end event

event deactivate;/////////////////////////////////////////////////////////
// Current Button Status Buffering
/////////////////////////////////////////////////////////
// m_bretrieve
i_b_bretrieve = m_frame.m_action.m_bretrieve.enabled
// m_bcreate
i_b_bcreate   = m_frame.m_action.m_bcreate.enabled
// m_dretrieve
i_b_dretrieve = m_frame.m_action.m_dretrieve.enabled
// m_dprint
i_b_dprint    = m_frame.m_action.m_dprint.enabled
// m_dchar
i_b_dchar     = m_frame.m_action.m_dchar.enabled

end event

event timer;f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
end event

type uo_status from uo_commonstatus within w_origin_sheet06
integer x = 9
integer y = 2496
boolean enabled = false
end type

on uo_status.destroy
call uo_commonstatus::destroy
end on

