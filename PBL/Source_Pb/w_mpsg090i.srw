$PBExportHeader$w_mpsg090i.srw
$PBExportComments$현장관리_생산실적 조회
forward
global type w_mpsg090i from window
end type
type em_search_date from editmask within w_mpsg090i
end type
type uo_select_date from uo_today within w_mpsg090i
end type
type st_base_date from statictext within w_mpsg090i
end type
type p_5 from picture within w_mpsg090i
end type
type st_page_dn from statictext within w_mpsg090i
end type
type st_row_dn from statictext within w_mpsg090i
end type
type st_row_up from statictext within w_mpsg090i
end type
type st_page_up from statictext within w_mpsg090i
end type
type p_4 from picture within w_mpsg090i
end type
type p_3 from picture within w_mpsg090i
end type
type p_2 from picture within w_mpsg090i
end type
type p_1 from picture within w_mpsg090i
end type
type pb_page_up from picturebutton within w_mpsg090i
end type
type pb_row_up from picturebutton within w_mpsg090i
end type
type pb_row_dn from picturebutton within w_mpsg090i
end type
type pb_page_dn from picturebutton within w_mpsg090i
end type
type st_5 from statictext within w_mpsg090i
end type
type dw_title from datawindow within w_mpsg090i
end type
type dw_mpsg090i_01 from datawindow within w_mpsg090i
end type
type tab_line_select from tab within w_mpsg090i
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
type tabpage_line11 from userobject within tab_line_select
end type
type tabpage_line11 from userobject within tab_line_select
end type
type tabpage_line12 from userobject within tab_line_select
end type
type tabpage_line12 from userobject within tab_line_select
end type
type tabpage_line13 from userobject within tab_line_select
end type
type tabpage_line13 from userobject within tab_line_select
end type
type tab_line_select from tab within w_mpsg090i
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
tabpage_line11 tabpage_line11
tabpage_line12 tabpage_line12
tabpage_line13 tabpage_line13
end type
type dw_area_info from datawindow within w_mpsg090i
end type
end forward

global type w_mpsg090i from window
integer width = 4649
integer height = 2600
boolean border = false
windowtype windowtype = child!
long backcolor = 32241141
event ue_line_select ( )
em_search_date em_search_date
uo_select_date uo_select_date
st_base_date st_base_date
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
dw_mpsg090i_01 dw_mpsg090i_01
tab_line_select tab_line_select
dw_area_info dw_area_info
end type
global w_mpsg090i w_mpsg090i

type variables
LONG		il_rowcount			// Rows 체크

end variables

event ue_line_select();STRING	ls_applydate_close		// 마감을 고려한 DATE

INTEGER	li_total_kb_num			// 총 지시간판 수량
INTEGER	li_finish_kb_num			// 완료 간판 수량

DATETIME	ld_server_datetime		// SERVER DATETIME

/*######################################################################
#####		선택된 조 표시															 #####
######################################################################*/

THIS.tab_line_select.selecttab(gi_tab_index)

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ld_server_datetime	= DATETIME(TODAY(),NOW())

ls_applydate_close	= f_mpms_get_applydate(ld_server_datetime)

em_search_date.text	= String(today(), "yyyy년 mm월 dd일")

/*######################################################################
#####		간판매수 조회															 #####
######################################################################*/

//SELECT	COUNT(KBNo)
//  INTO	:li_total_kb_num
//  FROM	TPLANRELEASE
// WHERE	PlanDate			=	:ls_applydate_close
//   AND	AreaCode			=	:gs_area_code
//   AND	DivisionCode	=	:gs_division_code
//   AND	WorkCenter		=	:gs_workcenter_code[gi_tab_index]
//   AND	LineCode			=	:gs_line_code[gi_tab_index]
//   AND	ReleaseGubun	IN('Y','T','U') ;
//
//SELECT	COUNT(KBNo)
//  INTO	:li_finish_kb_num
//  FROM	TPLANRELEASE
// WHERE	PlanDate			=	:ls_applydate_close
//   AND	AreaCode			=	:gs_area_code
//   AND	DivisionCode	=	:gs_division_code
//   AND	WorkCenter		=	:gs_workcenter_code[gi_tab_index]
//   AND	LineCode			=	:gs_line_code[gi_tab_index]
//   AND	ReleaseGubun	IN('Y','T','U')
//   AND	PrdFlag			=	'E' ;
//
//st_total_kb_num.text = STRING(li_total_kb_num)
//st_kb_num.text = STRING(li_finish_kb_num) + '/' + STRING(li_total_kb_num) + ' '

/*######################################################################
#####		계획대비 실적조회														 #####
######################################################################*/

dw_mpsg090i_01.settransobject(sqlca)
dw_mpsg090i_01.Retrieve(ls_applydate_close, gs_workcenter_code[gi_tab_index],	&
			gs_line_code[gi_tab_index])

/*######################################################################
#####		dw_pisg030i_01의 첫행을 선택										 #####
######################################################################*/

dw_mpsg090i_01.SelectRow(0, FALSE)
dw_mpsg090i_01.SelectRow(1, TRUE)

end event

on w_mpsg090i.create
this.em_search_date=create em_search_date
this.uo_select_date=create uo_select_date
this.st_base_date=create st_base_date
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
this.dw_mpsg090i_01=create dw_mpsg090i_01
this.tab_line_select=create tab_line_select
this.dw_area_info=create dw_area_info
this.Control[]={this.em_search_date,&
this.uo_select_date,&
this.st_base_date,&
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
this.dw_mpsg090i_01,&
this.tab_line_select,&
this.dw_area_info}
end on

on w_mpsg090i.destroy
destroy(this.em_search_date)
destroy(this.uo_select_date)
destroy(this.st_base_date)
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
destroy(this.dw_mpsg090i_01)
destroy(this.tab_line_select)
destroy(this.dw_area_info)
end on

event open;/*######################################################################
#####		타이틀명 셋팅															 #####
######################################################################*/

dw_title.setitem(1, "title_name", "생산실적조회")

/*######################################################################
#####		지역, 공장 명 셋팅													 #####
######################################################################*/

//dw_area_info.setitem(1, "area_name", gs_area_name)
//dw_area_info.setitem(1, "workcenter_name", gs_division_name)

/*######################################################################
#####		라인 선택																 #####
######################################################################*/

THIS.PostEvent("ue_line_select")

/*######################################################################
#####		라인수가 5라인이 넘는 경우											 #####
######################################################################*/

IF gi_tot_tab_count > 5 THEN

	// 데이타 윈도우
	dw_mpsg090i_01.y			= 848
	dw_mpsg090i_01.Height	= 1698

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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
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
	tab_line_select.tabpage_line11.visible = FALSE
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
CASE 11
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
	tab_line_select.tabpage_line11.text = gs_workcenter_name[11] + &
													"~r~n" + gs_line_name[11]												
	tab_line_select.tabpage_line12.visible = FALSE
	tab_line_select.tabpage_line13.visible = FALSE
CASE 12
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
	tab_line_select.tabpage_line11.text = gs_workcenter_name[11] + &
													"~r~n" + gs_line_name[11]
	tab_line_select.tabpage_line12.text = gs_workcenter_name[12] + &
													"~r~n" + gs_line_name[12]												
	tab_line_select.tabpage_line13.visible = FALSE
CASE 13
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
	tab_line_select.tabpage_line11.text = gs_workcenter_name[11] + &
													"~r~n" + gs_line_name[11]
	tab_line_select.tabpage_line12.text = gs_workcenter_name[12] + &
													"~r~n" + gs_line_name[12]
	tab_line_select.tabpage_line13.text = gs_workcenter_name[13] + &
													"~r~n" + gs_line_name[13]												
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

type em_search_date from editmask within w_mpsg090i
event ue_keydown pbm_keydown
event ue_date_change ( )
integer x = 3040
integer y = 292
integer width = 1147
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy년 mm월 dd일"
end type

event ue_keydown;IF KEY = KeyEnter! THEN
	w_mpsg090i.em_search_date.TriggerEvent("ue_date_change")
END IF
end event

event ue_date_change();STRING	ls_select_date

INTEGER	li_total_kb_num
INTEGER	li_finish_kb_num

/*######################################################################
#####		기준일																	 #####
######################################################################*/

this.text = string(date(uo_select_date.sle_date.text))

ls_select_date = uo_select_date.sle_date.text

dw_mpsg090i_01.settransobject(sqlca)
dw_mpsg090i_01.Retrieve(ls_select_date, &
				gs_workcenter_code[gi_tab_index], gs_line_code[gi_tab_index])

/*######################################################################
#####		간판매수 조회															 #####
######################################################################*/

//SELECT	COUNT(KBNo)
//  INTO	:li_total_kb_num
//  FROM	TPLANRELEASE
// WHERE	PlanDate			=	:ls_select_date
//   AND	AreaCode			=	:gs_area_code
//   AND	DivisionCode	=	:gs_division_code
//   AND	WorkCenter		=	:gs_workcenter_code[gi_tab_index]
//   AND	LineCode			=	:gs_line_code[gi_tab_index]
//   AND	ReleaseGubun	IN('Y','T','U') ;
//
//SELECT	COUNT(KBNo)
//  INTO	:li_finish_kb_num
//  FROM	TPLANRELEASE
// WHERE	PlanDate			=	:ls_select_date
//   AND	AreaCode			=	:gs_area_code
//   AND	DivisionCode	=	:gs_division_code
//   AND	WorkCenter		=	:gs_workcenter_code[gi_tab_index]
//   AND	LineCode			=	:gs_line_code[gi_tab_index]
//   AND	PrdFlag			=	'E'
//   AND	ReleaseGubun	IN('Y','T','U') ;
//
//st_total_kb_num.text = STRING(li_total_kb_num)
//st_kb_num.text = STRING(li_finish_kb_num) + '/' + STRING(li_total_kb_num)
//
end event

type uo_select_date from uo_today within w_mpsg090i
event destroy ( )
integer x = 2757
integer y = 284
integer height = 148
integer taborder = 30
end type

on uo_select_date.destroy
call uo_today::destroy
end on

event ue_variable_set;call super::ue_variable_set;em_search_date.TriggerEvent("ue_date_change")
end event

type st_base_date from statictext within w_mpsg090i
integer x = 2427
integer y = 292
integer width = 288
integer height = 92
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 22099723
long backcolor = 32827087
string text = "기준일"
boolean focusrectangle = false
end type

type p_5 from picture within w_mpsg090i
integer x = 2318
integer y = 316
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "bmp\bullet.gif"
boolean focusrectangle = false
end type

type st_page_dn from statictext within w_mpsg090i
integer x = 4247
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

type st_row_dn from statictext within w_mpsg090i
integer x = 4247
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

type st_row_up from statictext within w_mpsg090i
integer x = 4247
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

type st_page_up from statictext within w_mpsg090i
integer x = 4247
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

type p_4 from picture within w_mpsg090i
integer x = 4329
integer y = 1720
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pagedown.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_mpsg090i
integer x = 4329
integer y = 1424
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowdown.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_mpsg090i
integer x = 4329
integer y = 1048
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowup.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_mpsg090i
integer x = 4329
integer y = 752
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pageup.gif"
boolean focusrectangle = false
end type

type pb_page_up from picturebutton within w_mpsg090i
integer x = 4201
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
dw_mpsg090i_01.ScrollPriorPage ()
dw_mpsg090i_01.SetRow(dw_mpsg090i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_mpsg090i_01.SelectRow(0, FALSE)
dw_mpsg090i_01.SelectRow(dw_mpsg090i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/


end event

type pb_row_up from picturebutton within w_mpsg090i
integer x = 4201
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
dw_mpsg090i_01.ScrollPriorRow()
dw_mpsg090i_01.SetRow(dw_mpsg090i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_mpsg090i_01.SelectRow(0, FALSE)
dw_mpsg090i_01.SelectRow(dw_mpsg090i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/


end event

type pb_row_dn from picturebutton within w_mpsg090i
integer x = 4201
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
dw_mpsg090i_01.ScrollNextRow()
dw_mpsg090i_01.SetRow(dw_mpsg090i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_mpsg090i_01.SelectRow(0, FALSE)
dw_mpsg090i_01.SelectRow(dw_mpsg090i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

end event

type pb_page_dn from picturebutton within w_mpsg090i
integer x = 4201
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
dw_mpsg090i_01.ScrollNextPage()
dw_mpsg090i_01.SetRow(dw_mpsg090i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_mpsg090i_01.SelectRow(0, FALSE)
dw_mpsg090i_01.SelectRow(dw_mpsg090i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

end event

type st_5 from statictext within w_mpsg090i
integer x = 4197
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

type dw_title from datawindow within w_mpsg090i
integer width = 4617
integer height = 200
integer taborder = 30
string dataobject = "d_title_bar"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

type dw_mpsg090i_01 from datawindow within w_mpsg090i
event ue_keydown pbm_keydown
event us_system_exit ( )
integer x = 18
integer y = 688
integer width = 4160
integer height = 1868
integer taborder = 20
string dataobject = "d_mpsg090i_01"
borderstyle borderstyle = stylelowered!
end type

event us_system_exit();CLOSE(w_mpsg010b)

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


end event

event retrieverow;STRING	ls_prdflag_chk

/*######################################################################
#####		미완료된 3개의 실적만 보여준다.									 #####
######################################################################*/

IF il_rowcount <> 0 THEN

	ls_prdflag_chk = THIS.GetItemString(row,"as_resultflag")

	// 조립완료 체크
	IF ls_prdflag_chk = 'A' THEN
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

event dberror;//IF sqldbcode = 10005 THEN
//	IF gs_SerialFlag = "2" THEN
//		// 통신 포트 CLOSE
//		w_mpsg010b.ole_comm.object.portopen	= FALSE
//	END IF
//
//	this.PostEvent("us_system_exit")
//	run("ipis_down.exe	"  + gs_appname)
//END IF
//
//RETURN 1



end event

event rowfocuschanged;// Tool명, Part 명 셋팅, 공정순서 가져오기

if currentrow < 1 then
	return 0
end if

String ls_orderno, ls_partno, ls_toolname, ls_partname
ls_orderno = This.getitemstring(currentrow,"as_orderno")
ls_partno = This.getitemstring(currentrow,"as_partno")

SELECT TOP 1 aa.ToolName, bb.PartName
INTO :ls_toolname, :ls_partname
FROM TORDER aa INNER JOIN TPARTLIST bb
	ON aa.OrderNo = bb.OrderNo
WHERE bb.Orderno = :ls_orderno AND bb.partno = :ls_partno ;

dw_area_info.setitem(1, "area_name", ls_toolname)
dw_area_info.setitem(1, "workcenter_name", ls_partname)

return 0
end event

type tab_line_select from tab within w_mpsg090i
integer x = 5
integer y = 504
integer width = 4617
integer height = 2076
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
tabpage_line11 tabpage_line11
tabpage_line12 tabpage_line12
tabpage_line13 tabpage_line13
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
this.tabpage_line11=create tabpage_line11
this.tabpage_line12=create tabpage_line12
this.tabpage_line13=create tabpage_line13
this.Control[]={this.tabpage_line1,&
this.tabpage_line2,&
this.tabpage_line3,&
this.tabpage_line4,&
this.tabpage_line5,&
this.tabpage_line6,&
this.tabpage_line7,&
this.tabpage_line8,&
this.tabpage_line9,&
this.tabpage_line10,&
this.tabpage_line11,&
this.tabpage_line12,&
this.tabpage_line13}
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
destroy(this.tabpage_line11)
destroy(this.tabpage_line12)
destroy(this.tabpage_line13)
end on

event clicked;STRING	ls_applydate_close		// 마감을 고려한 DATE

INTEGER	li_total_kb_num
INTEGER	li_finish_kb_num

DATETIME	ld_server_datetime		// 기준일(DATETIME)
DATE		ld_date						// 

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ld_date = date(LEFT(em_search_date.text,4) + '-' +		&
				MID(em_search_date.text,8,2) + '-' +		&
				MID(em_search_date.text,13,2))

ld_server_datetime	= DATETIME(ld_date, NOW())

ls_applydate_close	= f_mpms_get_applydate(ld_server_datetime)

/*######################################################################
#####		선택되어진 라인에 대한 정보.										 #####
######################################################################*/

IF selectedtab > 0 THEN

	// 현재 INDEX 저장
	gi_tab_index = selectedtab

	// 갱신
	dw_mpsg090i_01.settransobject(sqlca)
	dw_mpsg090i_01.Retrieve(ls_applydate_close, &
				gs_workcenter_code[gi_tab_index], gs_line_code[gi_tab_index])

	// 하일라이트
	dw_mpsg090i_01.SelectRow(0, FALSE)
	dw_mpsg090i_01.SelectRow(1, TRUE)

	/*###################################################################
	#####		간판매수 조회														 #####
	###################################################################*/

//	SELECT	COUNT(KBNo)
//	  INTO	:li_total_kb_num
//	  FROM	TPLANRELEASE
//	 WHERE	PlanDate			=	:ls_applydate_close
//		AND	AreaCode			=	:gs_area_code
//		AND	DivisionCode	=	:gs_division_code
//		AND	WorkCenter		=	:gs_workcenter_code[gi_tab_index]
//		AND	LineCode			=	:gs_line_code[gi_tab_index]
//		AND	ReleaseGubun	IN('Y','T','U') ;
//
//	SELECT	COUNT(KBNo)
//	  INTO	:li_finish_kb_num
//	  FROM	TPLANRELEASE
//	 WHERE	PlanDate			=	:ls_applydate_close
//		AND	AreaCode			=	:gs_area_code
//		AND	DivisionCode	=	:gs_division_code
//		AND	WorkCenter		=	:gs_workcenter_code[gi_tab_index]
//		AND	LineCode			=	:gs_line_code[gi_tab_index]
//		AND	ReleaseGubun	IN('Y','T','U')
//		AND	PrdFlag			=	'E' ;
//
//	st_total_kb_num.text = STRING(li_total_kb_num)
//	st_kb_num.text = STRING(li_finish_kb_num) + '/' + STRING(li_total_kb_num) + ' '
END IF
end event

type tabpage_line1 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line2 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line3 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line4 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line5 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line6 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line7 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line8 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line9 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line10 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long tabbackcolor = 79219928
long picturemaskcolor = 536870912
end type

type tabpage_line11 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_line12 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_line13 from userobject within tab_line_select
integer x = 18
integer y = 176
integer width = 4581
integer height = 1884
long backcolor = 32241141
string text = "ABS ~r~nA Line"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type dw_area_info from datawindow within w_mpsg090i
integer y = 200
integer width = 4617
integer height = 248
integer taborder = 20
string title = "none"
string dataobject = "d_area_info"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

