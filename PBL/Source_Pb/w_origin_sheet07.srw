$PBExportHeader$w_origin_sheet07.srw
$PBExportComments$(출력물인쇄-조건화면)
forward
global type w_origin_sheet07 from window
end type
type r_1 from rectangle within w_origin_sheet07
end type
type uo_status from uo_commonstatus within w_origin_sheet07
end type
type lb_1 from listbox within w_origin_sheet07
end type
type cb_cancel from commandbutton within w_origin_sheet07
end type
type cb_ok from commandbutton within w_origin_sheet07
end type
type dw_1 from datawindow within w_origin_sheet07
end type
type gb_01 from groupbox within w_origin_sheet07
end type
type gb_00 from groupbox within w_origin_sheet07
end type
type ln_1 from line within w_origin_sheet07
end type
type ln_2 from line within w_origin_sheet07
end type
type ln_4 from line within w_origin_sheet07
end type
type ln_3 from line within w_origin_sheet07
end type
type st_0 from statictext within w_origin_sheet07
end type
end forward

global type w_origin_sheet07 from window
integer x = 5
integer y = 212
integer width = 4663
integer height = 2688
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
r_1 r_1
uo_status uo_status
lb_1 lb_1
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
gb_01 gb_01
gb_00 gb_00
ln_1 ln_1
ln_2 ln_2
ln_4 ln_4
ln_3 ln_3
st_0 st_0
end type
global w_origin_sheet07 w_origin_sheet07

type variables
//Open시의 Activate Event Skip 여부
boolean i_b_first_open

//Security Level Check
string i_s_level

//Report Select
string 	i_s_report

str_easy	i_str_prt
end variables

on w_origin_sheet07.create
this.r_1=create r_1
this.uo_status=create uo_status
this.lb_1=create lb_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.gb_01=create gb_01
this.gb_00=create gb_00
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_4=create ln_4
this.ln_3=create ln_3
this.st_0=create st_0
this.Control[]={this.r_1,&
this.uo_status,&
this.lb_1,&
this.cb_cancel,&
this.cb_ok,&
this.dw_1,&
this.gb_01,&
this.gb_00,&
this.ln_1,&
this.ln_2,&
this.ln_4,&
this.ln_3,&
this.st_0}
end on

on w_origin_sheet07.destroy
destroy(this.r_1)
destroy(this.uo_status)
destroy(this.lb_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.gb_01)
destroy(this.gb_00)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_4)
destroy(this.ln_3)
destroy(this.st_0)
end on

event open;// Sheet title & Status Line Setting
i_s_level  	= 	mid(Message.StringParm, 1, 1)
this.title 		= 	mid(Message.StringParm, 2, len(Message.StringParm) - 1)
this.uo_status.st_winid.text   		= 	This.ClassName()
this.uo_status.st_message.text 	= 	""
this.uo_status.st_kornm.text   		= 	g_s_kornm
this.uo_status.st_date.text    		= 	string(g_s_date, "@@@@-@@-@@")

i_s_report = ""

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
f_icon_set(false, false, false, false, false, false, false, false, false, false, &
			  false, false, false, false, false, false, false)

// Action Menu On
m_frame.m_action.visible = true

// ToolBar 2 Setting  (전체공통)
w_frame.SetToolbar(2, true)
w_frame.SetToolbarPos(2, 2, 150, false)
end event

event activate;SetPointer(HourGlass!)

if 	i_b_first_open 	= 	false then
	i_b_first_open 	= 	true
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
	f_icon_set(false, false, false, false, false, false, false, false, false, false, &
				  false, false, false, false, false, false, false)
	
	// ToolBar 2 Setting  (전체공통)
	w_frame.SetToolbar(2, true)
	w_frame.SetToolbarPos(2, 2, 150, false)

	// Action Menu On
	m_frame.m_action.visible = true
end if

timer(30)
end event

event closequery;f_close_report("2",This.ClassName())					//Open된 출력Window 닫기

end event

event timer;f_sysdate()
uo_status.st_date.text    = 	String(g_s_date, "@@@@-@@-@@")
uo_status.st_time.text 	=	mid(g_s_time,1,5)
end event

type r_1 from rectangle within w_origin_sheet07
long linecolor = 16777215
integer linethickness = 4
long fillcolor = 12632256
integer x = 878
integer y = 1224
integer width = 2455
integer height = 1116
end type

type uo_status from uo_commonstatus within w_origin_sheet07
integer x = 9
integer y = 2496
boolean enabled = false
end type

on uo_status.destroy
call uo_commonstatus::destroy
end on

type lb_1 from listbox within w_origin_sheet07
integer x = 992
integer y = 172
integer width = 2222
integer height = 880
integer taborder = 10
integer textsize = -14
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
boolean underline = true
long backcolor = 16777215
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_origin_sheet07
integer x = 3552
integer y = 280
integer width = 306
integer height = 140
integer taborder = 30
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "취소"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

type cb_ok from commandbutton within w_origin_sheet07
integer x = 3552
integer y = 120
integer width = 306
integer height = 140
integer taborder = 20
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "확인"
boolean default = true
end type

type dw_1 from datawindow within w_origin_sheet07
boolean visible = false
integer x = 128
integer y = 476
integer width = 617
integer height = 540
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type gb_01 from groupbox within w_origin_sheet07
integer x = 873
integer y = 44
integer width = 2455
integer height = 1068
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 8388608
long backcolor = 12632256
string text = "[출력물 선택]"
end type

type gb_00 from groupbox within w_origin_sheet07
integer x = 3493
integer y = 60
integer width = 425
integer height = 392
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type ln_1 from line within w_origin_sheet07
long linecolor = 8421504
integer linethickness = 4
integer beginx = 882
integer beginy = 2332
integer endx = 3314
integer endy = 2332
end type

type ln_2 from line within w_origin_sheet07
long linecolor = 8421504
integer linethickness = 4
integer beginx = 3323
integer beginy = 1224
integer endx = 3323
integer endy = 2332
end type

type ln_4 from line within w_origin_sheet07
long linecolor = 8421504
integer linethickness = 4
integer beginx = 882
integer beginy = 1228
integer endx = 882
integer endy = 2332
end type

type ln_3 from line within w_origin_sheet07
long linecolor = 8421504
integer linethickness = 4
integer beginx = 882
integer beginy = 1220
integer endx = 3310
integer endy = 1220
end type

type st_0 from statictext within w_origin_sheet07
integer x = 1102
integer y = 1180
integer width = 539
integer height = 104
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "[출력조건]"
alignment alignment = center!
boolean focusrectangle = false
end type

