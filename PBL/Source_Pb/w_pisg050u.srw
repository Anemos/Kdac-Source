$PBExportHeader$w_pisg050u.srw
$PBExportComments$현장관리_생산실적등록및 확인
forward
global type w_pisg050u from window
end type
type sle_kbno from singlelineedit within w_pisg050u
end type
type gb_1 from groupbox within w_pisg050u
end type
type mle_2 from multilineedit within w_pisg050u
end type
type gb_2 from groupbox within w_pisg050u
end type
type gb_3 from groupbox within w_pisg050u
end type
type dw_pisg050u_01 from datawindow within w_pisg050u
end type
end forward

global type w_pisg050u from window
integer x = 800
integer y = 552
integer width = 1307
integer height = 1344
boolean titlebar = true
string title = "생산실적등록 확인"
windowtype windowtype = response!
long backcolor = 79219928
sle_kbno sle_kbno
gb_1 gb_1
mle_2 mle_2
gb_2 gb_2
gb_3 gb_3
dw_pisg050u_01 dw_pisg050u_01
end type
global w_pisg050u w_pisg050u

type variables
INTEGER	ii_time_chk				//	시간 체크

end variables

forward prototypes
private function integer wf_actual_recording (string fs_kbno, string fs_com_code)
end prototypes

private function integer wf_actual_recording (string fs_kbno, string fs_com_code);INTEGER	li_error_code

DECLARE actual_recording procedure for sp_pisg050u_02
@ps_areacode		= :gs_area_code,
@ps_divisioncode	= :gs_division_code,
@ps_workcenter		= :gs_workcenter_code[gi_tab_index],
@ps_linecode		= :gs_line_code[gi_tab_index],
@ps_kbno				= :fs_kbno,
@ps_com_code		= :fs_com_code,
@pi_err_code		= :li_error_code	output
USING	SQLCA ;

EXECUTE actual_recording ;

FETCH actual_recording
	INTO :li_error_code ;
CLOSE	actual_recording ;

RETURN li_error_code

end function

on w_pisg050u.create
this.sle_kbno=create sle_kbno
this.gb_1=create gb_1
this.mle_2=create mle_2
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_pisg050u_01=create dw_pisg050u_01
this.Control[]={this.sle_kbno,&
this.gb_1,&
this.mle_2,&
this.gb_2,&
this.gb_3,&
this.dw_pisg050u_01}
end on

on w_pisg050u.destroy
destroy(this.sle_kbno)
destroy(this.gb_1)
destroy(this.mle_2)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_pisg050u_01)
end on

event open;STRING	ls_kbno						// 간판번호
STRING	ls_comcode					// 단말기 코드
STRING	ls_applydate_close		// 마감을 고려한 DATE
STRING	ls_terminalcode			// 단말기 코드
STRING	ls_com_send

INTEGER	li_row_count				// 레코드 카운
INTEGER	li_error_code				// ERROR CODE

DATETIME	ldt_now_datetime			// 현재 DATETIME

// 화면 중심
f_centerwindow(this)

// 간판번호
ls_kbno			= trim(w_pisg030i.em_kb_no.text)
sle_kbno.text	= ls_kbno

// 시간 셋팅
ldt_now_datetime		= DATETIME(TODAY(), NOW())

ls_applydate_close	= f_pisc_get_date_applydate(gs_area_code,	&
									gs_division_code,ldt_now_datetime)

// 단말기 코드
ls_terminalcode	= ProfileString(gs_inifile, "Com_Info", "Comcode", "")

// 정보 갱신
dw_pisg050u_01.settransobject(sqlca)
dw_pisg050u_01.Retrieve(ls_kbno,										&
								gs_area_code,								&
								gs_division_code,							& 
								gs_workcenter_code[gi_tab_index],	&
								gs_line_code[gi_tab_index])

//**************
//* 조향공장 TAG 라벨 이력데이타 추가
//**************
//Open(w_pisg050u_01)

// 실행
li_error_code		= wf_actual_recording(ls_kbno, ls_terminalcode)

IF li_error_code = 0 THEN

	// TIMER
	timer(0.5)
	
	// 데이타 갱신.
	w_pisg030i.dw_pisg030i_01.Retrieve(ls_applydate_close,					&
												gs_area_code,								&
												gs_division_code,							&
												gs_workcenter_code[gi_tab_index],	&
												gs_line_code[gi_tab_index])
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

	IF gs_SerialFlag = "2" THEN
		// 씨리얼 통신
		ls_com_send		= f_comm()

//		messagebox('ls_com_send', ls_com_send)
		w_pisg010b.ole_comm.Object.Output	= ls_com_send
	END IF

	// 화면 스크롤
	w_pisg030i.dw_pisg030i_01.ScrollToRow(li_row_count + gi_show_count[gi_tab_index])

	// dw_pisg030i_01의 선택되어진 ROW
	w_pisg030i.dw_pisg030i_01.SelectRow(0, FALSE)
	w_pisg030i.dw_pisg030i_01.SelectRow(li_row_count, TRUE)

ELSE
	Open(w_pisg051u)
	Close(w_pisg050u)
END IF
end event

event timer;/*######################################################################
#####		시간을 체크하여	데이타윈도우 COLOR 변경						 #####
######################################################################*/

ii_time_chk = ii_time_chk + 1

IF MOD(ii_time_chk, 2) = 1 THEN
	dw_pisg050u_01.Object.datawindow.color = RGB(203, 203, 203)
ELSE
	dw_pisg050u_01.Object.datawindow.color = RGB(255, 255, 255)
END IF

// 4초간 정보 표시
IF ii_time_chk > 6 THEN

	// 간판 입력 에디터 정리
	w_pisg030i.em_kb_no.text = ''
	w_pisg030i.em_kb_no.SetFocus()

	// 윈도우 종료
	Close(w_pisg050u)
END IF


end event

event wf_make_lotno;STRING	ls_kbno
STRING	ls_comcode

// 실적 등록

DECLARE actual_record PROCEDURE for sp_pisg050u_04
@ps_areacode		= :gs_area_code,
@ps_divisioncode	= :gs_division_code,
@ps_workcenter		= :gs_workcenter_code[gi_tab_index],
@ps_linecode		= :gs_line_code[gi_tab_index],
@ps_kbno				= :ls_kbno,
@ps_com_code		= :ls_comcode
Using SQLCA;


//exactly the parameters in the sp.
EXECUTE actual_record;

CLOSE actual_record;


end event

type sle_kbno from singlelineedit within w_pisg050u
integer x = 59
integer y = 104
integer width = 1157
integer height = 168
integer taborder = 10
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
boolean autohscroll = false
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisg050u
integer x = 18
integer y = 8
integer width = 1248
integer height = 304
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 67108864
string text = "간판번호확인"
end type

type mle_2 from multilineedit within w_pisg050u
integer x = 59
integer y = 1088
integer width = 1157
integer height = 144
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 79219928
string text = "상기 간판의 생산실적을          완료등록 하였습니다."
boolean border = false
end type

type gb_2 from groupbox within w_pisg050u
integer x = 18
integer y = 296
integer width = 1248
integer height = 768
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_pisg050u
integer x = 18
integer y = 1048
integer width = 1248
integer height = 200
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_pisg050u_01 from datawindow within w_pisg050u
integer x = 59
integer y = 340
integer width = 1157
integer height = 692
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_pisg050u_01"
borderstyle borderstyle = stylelowered!
end type

