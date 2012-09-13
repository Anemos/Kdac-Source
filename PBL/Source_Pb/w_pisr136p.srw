$PBExportHeader$w_pisr136p.srw
$PBExportComments$사급품반출증출력
forward
global type w_pisr136p from w_prt
end type
end forward

global type w_pisr136p from w_prt
end type
global w_pisr136p w_pisr136p

on w_pisr136p.create
int iCurrent
call super::create
end on

on w_pisr136p.destroy
call super::destroy
end on

event ue_print;str_prtoption	l_prt_option

dw_preview.Setredraw(false)

l_prt_option.datawindow = dw_preview
l_prt_option.page			= em_scrollpage.text
l_prt_option.transaction= i_str_prt.transaction
//상속후 수정처리부분/////////////////////
//OpenWithParm(w_print_options, l_prt_option)
OpenWithParm(w_pisr136p_opt, l_prt_option)
//상속후 수정처리부분/////////////////////

If Message.DoubleParm = -1 Then
	dw_preview.Setredraw(true)
	Return
end if

dw_preview.Setredraw(true)

dw_preview.Object.Datawindow.Zoom = ddlb_scale.text
cb_scroll.TriggerEvent(Clicked!)

if dw_preview.Describe("Evaluate('PageCount()',1)") = "1" then
	cb_scroll.enabled = false
	// m_next
	i_b_next   = false
	// m_last
	i_b_last   = false
end if

// Current Button Status Buffering
// 인쇄, 처음, 이전, 다음, 끝
wf_icon_onoff(i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last)

end event

type cb_scroll from w_prt`cb_scroll within w_pisr136p
end type

type em_scrollpage from w_prt`em_scrollpage within w_pisr136p
end type

type cbx_rulers from w_prt`cbx_rulers within w_pisr136p
end type

type st_6 from w_prt`st_6 within w_pisr136p
end type

type ddlb_scale from w_prt`ddlb_scale within w_pisr136p
end type

type st_1 from w_prt`st_1 within w_pisr136p
end type

type dw_preview from w_prt`dw_preview within w_pisr136p
end type

type uo_status from w_prt`uo_status within w_pisr136p
end type

type gb_2 from w_prt`gb_2 within w_pisr136p
end type

type gb_1 from w_prt`gb_1 within w_pisr136p
end type

