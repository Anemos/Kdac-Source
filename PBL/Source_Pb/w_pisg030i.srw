$PBExportHeader$w_pisg030i.srw
$PBExportComments$현장관리_생산실적순서 조회
forward
global type w_pisg030i from window
end type
type st_2 from statictext within w_pisg030i
end type
type p_6 from picture within w_pisg030i
end type
type st_1 from statictext within w_pisg030i
end type
type p_5 from picture within w_pisg030i
end type
type st_page_dn from statictext within w_pisg030i
end type
type st_row_dn from statictext within w_pisg030i
end type
type st_row_up from statictext within w_pisg030i
end type
type st_page_up from statictext within w_pisg030i
end type
type p_4 from picture within w_pisg030i
end type
type p_3 from picture within w_pisg030i
end type
type p_2 from picture within w_pisg030i
end type
type p_1 from picture within w_pisg030i
end type
type pb_page_up from picturebutton within w_pisg030i
end type
type pb_row_up from picturebutton within w_pisg030i
end type
type pb_row_dn from picturebutton within w_pisg030i
end type
type pb_page_dn from picturebutton within w_pisg030i
end type
type st_5 from statictext within w_pisg030i
end type
type dw_title from datawindow within w_pisg030i
end type
type dw_pisg030i_01 from datawindow within w_pisg030i
end type
type tab_line_select from tab within w_pisg030i
end type
type tabpage_line1 from userobject within tab_line_select
end type
type tabpage_line1 from userobject within tab_line_select
end type
type tabpage_line2 from userobject within tab_line_select
end type
type tabpage_line2 from userobject within tab_line_select
end type
type tabpage_line3 from userobject within tab_line_select
end type
type tabpage_line3 from userobject within tab_line_select
end type
type tabpage_line4 from userobject within tab_line_select
end type
type tabpage_line4 from userobject within tab_line_select
end type
type tabpage_line5 from userobject within tab_line_select
end type
type tabpage_line5 from userobject within tab_line_select
end type
type tabpage_line6 from userobject within tab_line_select
end type
type tabpage_line6 from userobject within tab_line_select
end type
type tabpage_line7 from userobject within tab_line_select
end type
type tabpage_line7 from userobject within tab_line_select
end type
type tabpage_line8 from userobject within tab_line_select
end type
type tabpage_line8 from userobject within tab_line_select
end type
type tabpage_line9 from userobject within tab_line_select
end type
type tabpage_line9 from userobject within tab_line_select
end type
type tabpage_line10 from userobject within tab_line_select
end type
type tabpage_line10 from userobject within tab_line_select
end type
type tab_line_select from tab within w_pisg030i
tabpage_line1 tabpage_line1
tabpage_line2 tabpage_line2
tabpage_line3 tabpage_line3
tabpage_line4 tabpage_line4
tabpage_line5 tabpage_line5
tabpage_line6 tabpage_line6
tabpage_line7 tabpage_line7
tabpage_line8 tabpage_line8
tabpage_line9 tabpage_line9
tabpage_line10 tabpage_line10
end type
type dw_area_info from datawindow within w_pisg030i
end type
type em_kb_no from editmask within w_pisg030i
end type
end forward

global type w_pisg030i from window
integer width = 3625
integer height = 1952
boolean border = false
windowtype windowtype = child!
long backcolor = 32241141
event ue_line_select ( )
st_2 st_2
p_6 p_6
st_1 st_1
p_5 p_5
st_page_dn st_page_dn
st_row_dn st_row_dn
st_row_up st_row_up
st_page_up st_page_up
p_4 p_4
p_3 p_3
p_2 p_2
p_1 p_1
pb_page_up pb_page_up
pb_row_up pb_row_up
pb_row_dn pb_row_dn
pb_page_dn pb_page_dn
st_5 st_5
dw_title dw_title
dw_pisg030i_01 dw_pisg030i_01
tab_line_select tab_line_select
dw_area_info dw_area_info
em_kb_no em_kb_no
end type
global w_pisg030i w_pisg030i

type variables
LONG		il_rowcount			// Rows 체크

end variables

forward prototypes
public function boolean wf_transaction_select ()
end prototypes

event ue_line_select();STRING	ls_applydate_close		// 마감을 고려한 DATE
INTEGER	li_row_count				// 레코드 카운
INTEGER	li_loop_count				// Loop 변수

DATETIME	ldt_server_datetime		// SERVER DATETIME

/*######################################################################
#####		선택된 조 표시															 #####
######################################################################*/

tab_line_select.SelectTab(gi_tab_index)

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ldt_server_datetime	= DATETIME(TODAY(),NOW())

ls_applydate_close	= f_pisc_get_date_applydate(gs_area_code,	&
									gs_division_code,ldt_server_datetime)

/*######################################################################
#####		DISPLAY COUNT															 #####
######################################################################*/

// 각 라인의 정보
FOR li_loop_count = 1 TO gi_tot_tab_count

	// 라인명및 조회 수량
	SELECT	DisplayCount
	  INTO	:gi_show_count[li_loop_count]
	  FROM	TMSTLINE
	 WHERE	AreaCode			= :gs_area_code
		AND	DivisionCode	= :gs_division_code
		AND	WorkCenter		= :gs_workcenter_code[li_loop_count]
		AND	LineCode			= :gs_line_code[li_loop_count] ;
NEXT

/*######################################################################
#####		조립순서 조회															 #####
######################################################################*/

dw_pisg030i_01.settransobject(sqlca)
dw_pisg030i_01.Retrieve(ls_applydate_close, gs_area_code, gs_division_code, &
				gs_workcenter_code[gi_tab_index], gs_line_code[gi_tab_index])

/*######################################################################
#####		dw_pisg030i_01의 하일라이트										 #####
######################################################################*/

// COUNT
SELECT	COUNT(ItemCode)
  INTO	:li_row_count
  FROM	TPLANRELEASE
 WHERE	PlanDate			= :ls_applydate_close
	AND	AreaCode			= :gs_area_code
	AND	DivisionCode	= :gs_division_code
	AND	WorkCenter		= :gs_workcenter_code[gi_tab_index]
	AND	LineCode			= :gs_line_code[gi_tab_index]
	AND 	PrdFlag			= 'E' ;

// 완료한 건이 없을경우 1행에 하일라이트
IF li_row_count = 0 THEN
	li_row_count = 1
END IF

// 화면 스크롤
dw_pisg030i_01.ScrollToRow(li_row_count + gi_show_count[gi_tab_index])

dw_pisg030i_01.SelectRow(0, FALSE)
dw_pisg030i_01.SelectRow(li_row_count, TRUE)

// 간판 입력창에 FOCUS
em_kb_no.SetFocus()

end event

public function boolean wf_transaction_select ();STRING	ls_kbno						// 간판 번호
STRING	ls_applydate_close		// 마감을 고려한 DATE

INTEGER	li_loop_count				// LOOP COUNT
INTEGER	li_order_rowcount			// 지시 COUNT

DATETIME	ldt_system_datetime		// 현재 시스템 시간

BOOLEAN	lb_line_chk					// 조립지시 체크 FLAG

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ldt_system_datetime	= DATETIME(TODAY(),NOW())

ls_applydate_close	= f_pisc_get_date_applydate(gs_area_code,	&
									gs_division_code, ldt_system_datetime)
// 체크 FLAG 초기화
lb_line_chk = FALSE

// 간판번호
ls_kbno	= trim(em_kb_no.text)

/*######################################################################
#####		간판정보 체크															 #####
######################################################################*/

FOR li_loop_count = 1 TO gi_tot_tab_count

/*
// 2002.12.16	간판 초기화에 대한 대응 
// 간판 정보에서 KBStatusCode가 A가 아닌 간판 처리 안함.

	SELECT	COUNT(KBNo)
	  INTO	:li_order_rowcount
	  FROM	TPLANRELEASE
	 WHERE	PlanDate			= :ls_applydate_close
		AND	AreaCode			= :gs_area_code
		AND	DivisionCode	= :gs_division_code
		AND	WorkCenter		= :gs_workcenter_code[li_loop_count]
		AND	LineCode			= :gs_line_code[li_loop_count]
		AND	KBNo				= :ls_kbno
		AND	ReleaseGubun	IN('T','Y')
		AND	PrdFlag			= 'N' ;
*/

	SELECT	COUNT(*)
	  INTO	:li_order_rowcount
	  FROM	TPLANRELEASE, TKB
	 WHERE	TPLANRELEASE.AreaCode		= TKB.AreaCode
		AND	TPLANRELEASE.DivisionCode	= TKB.DivisionCode
		AND	TPLANRELEASE.WorkCenter		= TKB.WorkCenter
		AND	TPLANRELEASE.LineCode		= TKB.LineCode
		AND	TPLANRELEASE.KBNo				= TKB.KBNo
		AND	TPLANRELEASE.PlanDate		= :ls_applydate_close
		AND	TPLANRELEASE.AreaCode		= :gs_area_code
		AND	TPLANRELEASE.DivisionCode	= :gs_division_code
		AND	TPLANRELEASE.WorkCenter		= :gs_workcenter_code[li_loop_count]
		AND	TPLANRELEASE.LineCode		= :gs_line_code[li_loop_count]
		AND	TPLANRELEASE.KBNo				= :ls_kbno
		AND	TPLANRELEASE.ReleaseGubun	IN('T','Y')
		AND	TPLANRELEASE.PrdFlag			= 'N'
		AND	TKB.KBStatusCode				= 'A' ;

	IF li_order_rowcount > 0 THEN

		//라인선택
		gi_tab_index	= li_loop_count

		// 조립지시 FLAG 셋팅
		lb_line_chk		= TRUE

		// 해당 라인 표시
		tab_line_select.SelectTab(gi_tab_index)

		// FOR문 종료
		EXIT
	END IF
NEXT

// RETURN
RETURN lb_line_chk

end function

on w_pisg030i.create
this.st_2=create st_2
this.p_6=create p_6
this.st_1=create st_1
this.p_5=create p_5
this.st_page_dn=create st_page_dn
this.st_row_dn=create st_row_dn
this.st_row_up=create st_row_up
this.st_page_up=create st_page_up
this.p_4=create p_4
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.pb_page_up=create pb_page_up
this.pb_row_up=create pb_row_up
this.pb_row_dn=create pb_row_dn
this.pb_page_dn=create pb_page_dn
this.st_5=create st_5
this.dw_title=create dw_title
this.dw_pisg030i_01=create dw_pisg030i_01
this.tab_line_select=create tab_line_select
this.dw_area_info=create dw_area_info
this.em_kb_no=create em_kb_no
this.Control[]={this.st_2,&
this.p_6,&
this.st_1,&
this.p_5,&
this.st_page_dn,&
this.st_row_dn,&
this.st_row_up,&
this.st_page_up,&
this.p_4,&
this.p_3,&
this.p_2,&
this.p_1,&
this.pb_page_up,&
this.pb_row_up,&
this.pb_row_dn,&
this.pb_page_dn,&
this.st_5,&
this.dw_title,&
this.dw_pisg030i_01,&
this.tab_line_select,&
this.dw_area_info,&
this.em_kb_no}
end on

on w_pisg030i.destroy
destroy(this.st_2)
destroy(this.p_6)
destroy(this.st_1)
destroy(this.p_5)
destroy(this.st_page_dn)
destroy(this.st_row_dn)
destroy(this.st_row_up)
destroy(this.st_page_up)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.pb_page_up)
destroy(this.pb_row_up)
destroy(this.pb_row_dn)
destroy(this.pb_page_dn)
destroy(this.st_5)
destroy(this.dw_title)
destroy(this.dw_pisg030i_01)
destroy(this.tab_line_select)
destroy(this.dw_area_info)
destroy(this.em_kb_no)
end on

event open;/*######################################################################
#####		타이틀명 셋팅															 #####
######################################################################*/

dw_title.setitem(1, "title_name", "생산실적등록")

/*######################################################################
#####		지역, 공장 명 셋팅													 #####
######################################################################*/

dw_area_info.setitem(1, "area_name", gs_area_name)
dw_area_info.setitem(1, "workcenter_name", gs_division_name)

/*######################################################################
#####		라인 선택																 #####
######################################################################*/

THIS.PostEvent("ue_line_select")

/*######################################################################
#####		라인수가 5라인이 넘는 경우											 #####
######################################################################*/

IF gi_tot_tab_count > 5 THEN

	// 데이타 윈도우
	dw_pisg030i_01.y			= 848
	dw_pisg030i_01.Height	= 1124

	// BUTTON BACK
	st_5.y						= 848
	st_5.Height					= 1124

	// BUTTON
	pb_page_up.y				= 856
	pb_page_up.Height			= 268

	pb_row_up.y					= 1124
	pb_row_up.Height			= 268

	pb_row_dn.y					= 1428
	pb_row_dn.Height			= 268

	pb_page_dn.y				= 1696
	pb_page_dn.Height			= 268

	p_1.y							= 896
	p_2.y							= 1164
	p_3.y							= 1468
	p_4.y							= 1736

	st_page_up.y	= 1032
	st_row_up.y		= 1296
	st_row_dn.y		= 1600
//	st_page_dn.y

END IF

/*######################################################################
#####		조, 라인명 셋팅														 #####
######################################################################*/

CHOOSE CASE gi_tot_tab_count
CASE 1
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]

	tab_line_select.tabpage_line2.visible = FALSE
	tab_line_select.tabpage_line3.visible = FALSE
	tab_line_select.tabpage_line4.visible = FALSE
	tab_line_select.tabpage_line5.visible = FALSE
	tab_line_select.tabpage_line6.visible = FALSE
	tab_line_select.tabpage_line7.visible = FALSE
	tab_line_select.tabpage_line8.visible = FALSE
	tab_line_select.tabpage_line9.visible = FALSE
	tab_line_select.tabpage_line10.visible = FALSE
CASE 2
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]

	tab_line_select.tabpage_line3.visible = FALSE
	tab_line_select.tabpage_line4.visible = FALSE
	tab_line_select.tabpage_line5.visible = FALSE
	tab_line_select.tabpage_line6.visible = FALSE
	tab_line_select.tabpage_line7.visible = FALSE
	tab_line_select.tabpage_line8.visible = FALSE
	tab_line_select.tabpage_line9.visible = FALSE
	tab_line_select.tabpage_line10.visible = FALSE
CASE 3
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]
	tab_line_select.tabpage_line3.text = gs_workcenter_name[3] + &
													"~r~n" + gs_line_name[3]

	tab_line_select.tabpage_line4.visible = FALSE
	tab_line_select.tabpage_line5.visible = FALSE
	tab_line_select.tabpage_line6.visible = FALSE
	tab_line_select.tabpage_line7.visible = FALSE
	tab_line_select.tabpage_line8.visible = FALSE
	tab_line_select.tabpage_line9.visible = FALSE
	tab_line_select.tabpage_line10.visible = FALSE
CASE 4
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]
	tab_line_select.tabpage_line3.text = gs_workcenter_name[3] + &
													"~r~n" + gs_line_name[3]
	tab_line_select.tabpage_line4.text = gs_workcenter_name[4] + &
													"~r~n" + gs_line_name[4]

	tab_line_select.tabpage_line5.visible = FALSE
	tab_line_select.tabpage_line6.visible = FALSE
	tab_line_select.tabpage_line7.visible = FALSE
	tab_line_select.tabpage_line8.visible = FALSE
	tab_line_select.tabpage_line9.visible = FALSE
	tab_line_select.tabpage_line10.visible = FALSE
CASE 5
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]
	tab_line_select.tabpage_line3.text = gs_workcenter_name[3] + &
													"~r~n" + gs_line_name[3]
	tab_line_select.tabpage_line4.text = gs_workcenter_name[4] + &
													"~r~n" + gs_line_name[4]
	tab_line_select.tabpage_line5.text = gs_workcenter_name[5] + &
													"~r~n" + gs_line_name[5]

	tab_line_select.tabpage_line6.visible = FALSE
	tab_line_select.tabpage_line7.visible = FALSE
	tab_line_select.tabpage_line8.visible = FALSE
	tab_line_select.tabpage_line9.visible = FALSE
	tab_line_select.tabpage_line10.visible = FALSE
CASE 6
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]
	tab_line_select.tabpage_line3.text = gs_workcenter_name[3] + &
													"~r~n" + gs_line_name[3]
	tab_line_select.tabpage_line4.text = gs_workcenter_name[4] + &
													"~r~n" + gs_line_name[4]
	tab_line_select.tabpage_line5.text = gs_workcenter_name[5] + &
													"~r~n" + gs_line_name[5]
	tab_line_select.tabpage_line6.text = gs_workcenter_name[6] + &
													"~r~n" + gs_line_name[6]

	tab_line_select.tabpage_line7.visible = FALSE
	tab_line_select.tabpage_line8.visible = FALSE
	tab_line_select.tabpage_line9.visible = FALSE
	tab_line_select.tabpage_line10.visible = FALSE
CASE 7
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]
	tab_line_select.tabpage_line3.text = gs_workcenter_name[3] + &
													"~r~n" + gs_line_name[3]
	tab_line_select.tabpage_line4.text = gs_workcenter_name[4] + &
													"~r~n" + gs_line_name[4]
	tab_line_select.tabpage_line5.text = gs_workcenter_name[5] + &
													"~r~n" + gs_line_name[5]
	tab_line_select.tabpage_line6.text = gs_workcenter_name[6] + &
													"~r~n" + gs_line_name[6]
	tab_line_select.tabpage_line7.text = gs_workcenter_name[7] + &
													"~r~n" + gs_line_name[7]

	tab_line_select.tabpage_line8.visible = FALSE
	tab_line_select.tabpage_line9.visible = FALSE
	tab_line_select.tabpage_line10.visible = FALSE
CASE 8
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]
	tab_line_select.tabpage_line3.text = gs_workcenter_name[3] + &
													"~r~n" + gs_line_name[3]
	tab_line_select.tabpage_line4.text = gs_workcenter_name[4] + &
													"~r~n" + gs_line_name[4]
	tab_line_select.tabpage_line5.text = gs_workcenter_name[5] + &
													"~r~n" + gs_line_name[5]
	tab_line_select.tabpage_line6.text = gs_workcenter_name[6] + &
													"~r~n" + gs_line_name[6]
	tab_line_select.tabpage_line7.text = gs_workcenter_name[7] + &
													"~r~n" + gs_line_name[7]
	tab_line_select.tabpage_line8.text = gs_workcenter_name[8] + &
													"~r~n" + gs_line_name[8]

	tab_line_select.tabpage_line9.visible = FALSE
	tab_line_select.tabpage_line10.visible = FALSE
CASE 9
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]
	tab_line_select.tabpage_line3.text = gs_workcenter_name[3] + &
													"~r~n" + gs_line_name[3]
	tab_line_select.tabpage_line4.text = gs_workcenter_name[4] + &
													"~r~n" + gs_line_name[4]
	tab_line_select.tabpage_line5.text = gs_workcenter_name[5] + &
													"~r~n" + gs_line_name[5]
	tab_line_select.tabpage_line6.text = gs_workcenter_name[6] + &
													"~r~n" + gs_line_name[6]
	tab_line_select.tabpage_line7.text = gs_workcenter_name[7] + &
													"~r~n" + gs_line_name[7]
	tab_line_select.tabpage_line8.text = gs_workcenter_name[8] + &
													"~r~n" + gs_line_name[8]
	tab_line_select.tabpage_line9.text = gs_workcenter_name[9] + &
													"~r~n" + gs_line_name[9]
	
	tab_line_select.tabpage_line10.visible = FALSE
CASE 10
	tab_line_select.tabpage_line1.text = gs_workcenter_name[1] + &
													"~r~n" + gs_line_name[1]
	tab_line_select.tabpage_line2.text = gs_workcenter_name[2] + &
													"~r~n" + gs_line_name[2]
	tab_line_select.tabpage_line3.text = gs_workcenter_name[3] + &
													"~r~n" + gs_line_name[3]
	tab_line_select.tabpage_line4.text = gs_workcenter_name[4] + &
													"~r~n" + gs_line_name[4]
	tab_line_select.tabpage_line5.text = gs_workcenter_name[5] + &
													"~r~n" + gs_line_name[5]
	tab_line_select.tabpage_line6.text = gs_workcenter_name[6] + &
													"~r~n" + gs_line_name[6]
	tab_line_select.tabpage_line7.text = gs_workcenter_name[7] + &
													"~r~n" + gs_line_name[7]
	tab_line_select.tabpage_line8.text = gs_workcenter_name[8] + &
													"~r~n" + gs_line_name[8]
	tab_line_select.tabpage_line9.text = gs_workcenter_name[9] + &
													"~r~n" + gs_line_name[9]
	tab_line_select.tabpage_line10.text = gs_workcenter_name[10] + &
													"~r~n" + gs_line_name[10]
END CHOOSE

/*######################################################################
#####		1분마다 시간 업데이트												 #####
######################################################################*/

timer(60)

end event

event timer;/*######################################################################
#####		1분마다 정보를 갱신한다.											 #####
######################################################################*/

IF gi_page_index = 2 THEN
	// 실적등록의 LINE선택 이벤트
	THIS.TriggerEvent("ue_line_select")
END IF

end event

type st_2 from statictext within w_pisg030i
integer x = 1417
integer y = 320
integer width = 343
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 22099723
long backcolor = 32827087
string text = "간판번호"
boolean focusrectangle = false
end type

type p_6 from picture within w_pisg030i
integer x = 1330
integer y = 348
integer width = 41
integer height = 36
string picturename = "bmp\bullet1.gif"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisg030i
integer x = 1317
integer y = 204
integer width = 398
integer height = 92
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 22099723
long backcolor = 32827087
string text = "간판정보"
boolean focusrectangle = false
end type

type p_5 from picture within w_pisg030i
integer x = 1207
integer y = 224
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "bmp\bullet.gif"
boolean focusrectangle = false
end type

type st_page_dn from statictext within w_pisg030i
integer x = 3246
integer y = 1868
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "PAGE"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_row_dn from statictext within w_pisg030i
integer x = 3246
integer y = 1572
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "ROW"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_row_up from statictext within w_pisg030i
integer x = 3246
integer y = 1196
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "ROW"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_page_up from statictext within w_pisg030i
integer x = 3246
integer y = 900
integer width = 306
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "PAGE"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_4 from picture within w_pisg030i
integer x = 3328
integer y = 1720
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pagedown.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_pisg030i
integer x = 3328
integer y = 1424
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowdown.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_pisg030i
integer x = 3328
integer y = 1048
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowup.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_pisg030i
integer x = 3328
integer y = 752
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pageup.gif"
boolean focusrectangle = false
end type

type pb_page_up from picturebutton within w_pisg030i
integer x = 3205
integer y = 696
integer width = 384
integer height = 300
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		PAGE UP																	 #####
######################################################################*/

// ROW 이동
dw_pisg030i_01.ScrollPriorPage ()
dw_pisg030i_01.SetRow(dw_pisg030i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg030i_01.SelectRow(0, FALSE)
dw_pisg030i_01.SelectRow(dw_pisg030i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type pb_row_up from picturebutton within w_pisg030i
integer x = 3205
integer y = 992
integer width = 384
integer height = 300
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		ROW UP																	 #####
######################################################################*/

// ROW 이동
dw_pisg030i_01.ScrollPriorRow()
dw_pisg030i_01.SetRow(dw_pisg030i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg030i_01.SelectRow(0, FALSE)
dw_pisg030i_01.SelectRow(dw_pisg030i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type pb_row_dn from picturebutton within w_pisg030i
integer x = 3205
integer y = 1368
integer width = 384
integer height = 300
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		ROW DOWN																	 #####
######################################################################*/

// ROW 이동
dw_pisg030i_01.ScrollNextRow()
dw_pisg030i_01.SetRow(dw_pisg030i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg030i_01.SelectRow(0, FALSE)
dw_pisg030i_01.SelectRow(dw_pisg030i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type pb_page_dn from picturebutton within w_pisg030i
integer x = 3205
integer y = 1664
integer width = 384
integer height = 300
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		PAGE DOWN																 #####
######################################################################*/

// ROW 이동
dw_pisg030i_01.ScrollNextPage()
dw_pisg030i_01.SetRow(dw_pisg030i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg030i_01.SelectRow(0, FALSE)
dw_pisg030i_01.SelectRow(dw_pisg030i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type st_5 from statictext within w_pisg030i
integer x = 3195
integer y = 688
integer width = 402
integer height = 1284
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 31516896
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_title from datawindow within w_pisg030i
integer width = 3625
integer height = 200
integer taborder = 30
string dataobject = "d_title_bar"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

type dw_pisg030i_01 from datawindow within w_pisg030i
event ue_keydown pbm_keydown
event us_system_exit ( )
integer x = 18
integer y = 688
integer width = 3173
integer height = 1284
integer taborder = 20
string dataobject = "d_pisg030i_01"
borderstyle borderstyle = stylelowered!
end type

event us_system_exit;CLOSE(w_pisg010b)

end event

event clicked;/*######################################################################
#####		선택되어진 ROW 값 체크												 #####
######################################################################*/

IF ROW > 0 THEN

	/*###################################################################
	#####		하일라이트															 #####
	###################################################################*/

	This.SelectRow(0, FALSE)
	This.SelectRow(row, TRUE)
END IF

/*######################################################################
#####		간판번호 입력창에 FOCUS												 #####
######################################################################*/

em_kb_no.SetFocus()


end event

event retrieverow;STRING	ls_prdflag_chk

/*######################################################################
#####		미완료된 3개의 실적만 보여준다.									 #####
######################################################################*/

IF il_rowcount <> 0 THEN

	ls_prdflag_chk = THIS.GetItemString(row,"as_prdflag")

	// 조립완료 체크
	IF ls_prdflag_chk = 'E' THEN
		il_rowcount = ROW + gi_show_count[gi_tab_index]
	END IF

	// 각 조별 조회 수
	IF row = il_rowcount THEN
		RETURN 1
	END IF
END IF

end event

event retrievestart;// 각 라인별 보여주는 지시 개수
il_rowcount = gi_show_count[gi_tab_index]

end event

event dberror;IF sqldbcode = 10005 THEN
	IF gs_SerialFlag = "2" THEN
		// 통신 포트 CLOSE
		w_pisg010b.ole_comm.object.portopen	= FALSE
	END IF

	this.PostEvent("us_system_exit")
	run("ipis_down.exe	"  + gs_appname)
END IF

RETURN 1



end event

type tab_line_select from tab within w_pisg030i
integer x = 5
integer y = 504
integer width = 3607
integer height = 1484
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 32241141
boolean multiline = true
boolean raggedright = true
integer selectedtab = 1
tabpage_line1 tabpage_line1
tabpage_line2 tabpage_line2
tabpage_line3 tabpage_line3
tabpage_line4 tabpage_line4
tabpage_line5 tabpage_line5
tabpage_line6 tabpage_line6
tabpage_line7 tabpage_line7
tabpage_line8 tabpage_line8
tabpage_line9 tabpage_line9
tabpage_line10 tabpage_line10
end type

on tab_line_select.create
this.tabpage_line1=create tabpage_line1
this.tabpage_line2=create tabpage_line2
this.tabpage_line3=create tabpage_line3
this.tabpage_line4=create tabpage_line4
this.tabpage_line5=create tabpage_line5
this.tabpage_line6=create tabpage_line6
this.tabpage_line7=create tabpage_line7
this.tabpage_line8=create tabpage_line8
this.tabpage_line9=create tabpage_line9
this.tabpage_line10=create tabpage_line10
this.Control[]={this.tabpage_line1,&
this.tabpage_line2,&
this.tabpage_line3,&
this.tabpage_line4,&
this.tabpage_line5,&
this.tabpage_line6,&
this.tabpage_line7,&
this.tabpage_line8,&
this.tabpage_line9,&
this.tabpage_line10}
end on

on tab_line_select.destroy
destroy(this.tabpage_line1)
destroy(this.tabpage_line2)
destroy(this.tabpage_line3)
destroy(this.tabpage_line4)
destroy(this.tabpage_line5)
destroy(this.tabpage_line6)
destroy(this.tabpage_line7)
destroy(this.tabpage_line8)
destroy(this.tabpage_line9)
destroy(this.tabpage_line10)
end on

event clicked;STRING	ls_applydate_close		// 마감을 고려한 DATE
INTEGER	li_row_count
DATETIME	ld_server_datetime		// 마감을 고려한 DATETIME

/*######################################################################
#####		INDEX 값 체크하여 정보 갱신										 #####
######################################################################*/

IF selectedtab > 0 THEN

	// 현재 INDEX 저장
	gi_tab_index = selectedtab

	// 기준일
	ld_server_datetime	= DATETIME(TODAY(),NOW())

	ls_applydate_close	= f_pisc_get_date_applydate(gs_area_code,	&
									gs_division_code,ld_server_datetime)

	// 정보갱신
	dw_pisg030i_01.settransobject(sqlca)
	dw_pisg030i_01.Retrieve(ls_applydate_close, gs_area_code,		&
				gs_division_code,	gs_workcenter_code[gi_tab_index],	&
				gs_line_code[gi_tab_index])

	/*###################################################################
	#####		dw_pisg030i_01의 하일라이트									 #####
	###################################################################*/

	// COUNT
	SELECT	COUNT(ItemCode)
	  INTO	:li_row_count
	  FROM	TPLANRELEASE
	 WHERE	PlanDate			= :ls_applydate_close
		AND	AreaCode			= :gs_area_code
		AND	DivisionCode	= :gs_division_code
		AND	WorkCenter		= :gs_workcenter_code[gi_tab_index]
		AND	LineCode			= :gs_line_code[gi_tab_index]
		AND 	PrdFlag			= 'E' ;

	// 완료한 건이 없을경우 1행에 하일라이트
	IF li_row_count = 0 THEN
		li_row_count = 1
	END IF

	// 화면 스크롤
	dw_pisg030i_01.ScrollToRow(li_row_count + gi_show_count[gi_tab_index])

	dw_pisg030i_01.SelectRow(0, FALSE)
	dw_pisg030i_01.SelectRow(li_row_count, TRUE)

END IF

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type tabpage_line1 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line2 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line3 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line4 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line5 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line6 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line7 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line8 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line9 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line10 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 3570
integer height = 1292
long backcolor = 32241141
string text = "ABS ~r~nA Line"
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type dw_area_info from datawindow within w_pisg030i
integer y = 200
integer width = 3625
integer height = 248
integer taborder = 20
string title = "none"
string dataobject = "d_area_info"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

type em_kb_no from editmask within w_pisg030i
event ue_keyup pbm_keydown
integer x = 1778
integer y = 288
integer width = 923
integer height = 144
integer taborder = 10
boolean bringtotop = true
integer textsize = -22
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "aaaaaaaaaaa"
end type

event ue_keyup;/*######################################################################
#####		간판번호입력 시														 #####
######################################################################*/

IF KEY	= KeyEnter! THEN
//	MESSAGEBOX('START','START')
	IF wf_transaction_select() THEN
		// 해당간판 등록
		Open(w_pisg050u)
	ELSE
		// 해당간판 오류 표시
		Open(w_pisg060b)

		// 갱신
		em_kb_no.text = ''
		em_kb_no.SetFocus()
	END IF
END IF

end event

