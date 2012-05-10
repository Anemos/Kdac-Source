$PBExportHeader$w_origin_sheet06.srw
$PBExportComments$(대상조회, 자료생성, 닫기, 상세조회, 화면인쇄, 특수문자)
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
// Icon의 Enabled 상태
boolean i_b_bretrieve,  i_b_bcreate, i_b_dretrieve
boolean i_b_dprint, i_b_dchar

//Open시의 Activate Event Skip 여부
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
//       wf_button(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
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
// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
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
// 대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)

// Action Menu On
m_frame.m_action.visible = true

// ToolBar 2 Setting  (전체공통)
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
	// ag_01 : 조회,     ag_02 : 입력,     ag_03 : 저장,     ag_04 : 삭제,     ag_05 : 인쇄
	// ag_06 : 처음,     ag_07 : 이전,     ag_08 : 다음,     ag_09 : 끝,       ag_10 : 미리보기
	// ag_11 : 대상조회, ag_12 : 자료생성, ag_13 : 상세조회, ag_14 : 화면인쇄, ag_15 : 특수문자 
	// ag_16 : None1,    ag_17 : None2
	////////////////////////////////////////////////////////////////////////////////////////////
	f_icon_set(true, false, false, false, true, false, false, false, false, false, &
				  true,  true,  true,  true,  true,  false, false)
	
	// ToolBar 2 Setting  (전체공통)
	w_frame.SetToolbar(2, true)
	w_frame.SetToolbarPos(2, 2, 150, false)
	
	/////////////////////////////////////////////////////////
	// Buffered Button Status Setting
	/////////////////////////////////////////////////////////
	// 대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자
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

