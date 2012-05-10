$PBExportHeader$w_pisg070u.srw
$PBExportComments$현장관리_생산실적등록 삭제
forward
global type w_pisg070u from window
end type
type em_kbno from editmask within w_pisg070u
end type
type pb_cancel from picturebutton within w_pisg070u
end type
type pb_result_del from picturebutton within w_pisg070u
end type
type pb_12 from picturebutton within w_pisg070u
end type
type pb_11 from picturebutton within w_pisg070u
end type
type pb_z from picturebutton within w_pisg070u
end type
type pb_y from picturebutton within w_pisg070u
end type
type pb_x from picturebutton within w_pisg070u
end type
type pb_w from picturebutton within w_pisg070u
end type
type pb_u from picturebutton within w_pisg070u
end type
type pb_t from picturebutton within w_pisg070u
end type
type pb_s from picturebutton within w_pisg070u
end type
type pb_r from picturebutton within w_pisg070u
end type
type pb_q from picturebutton within w_pisg070u
end type
type pb_p from picturebutton within w_pisg070u
end type
type pb_n from picturebutton within w_pisg070u
end type
type pb_m from picturebutton within w_pisg070u
end type
type pb_l from picturebutton within w_pisg070u
end type
type pb_k from picturebutton within w_pisg070u
end type
type pb_j from picturebutton within w_pisg070u
end type
type pb_i from picturebutton within w_pisg070u
end type
type pb_g from picturebutton within w_pisg070u
end type
type pb_f from picturebutton within w_pisg070u
end type
type pb_e from picturebutton within w_pisg070u
end type
type pb_d from picturebutton within w_pisg070u
end type
type pb_c from picturebutton within w_pisg070u
end type
type pb_b from picturebutton within w_pisg070u
end type
type pb_enter from picturebutton within w_pisg070u
end type
type pb_10 from picturebutton within w_pisg070u
end type
type pb_9 from picturebutton within w_pisg070u
end type
type pb_8 from picturebutton within w_pisg070u
end type
type pb_7 from picturebutton within w_pisg070u
end type
type pb_back from picturebutton within w_pisg070u
end type
type pb_5 from picturebutton within w_pisg070u
end type
type pb_4 from picturebutton within w_pisg070u
end type
type pb_3 from picturebutton within w_pisg070u
end type
type pb_2 from picturebutton within w_pisg070u
end type
type pb_v from picturebutton within w_pisg070u
end type
type pb_o from picturebutton within w_pisg070u
end type
type pb_h from picturebutton within w_pisg070u
end type
type pb_a from picturebutton within w_pisg070u
end type
type pb_6 from picturebutton within w_pisg070u
end type
type pb_1 from picturebutton within w_pisg070u
end type
type gb_4 from groupbox within w_pisg070u
end type
type gb_1 from groupbox within w_pisg070u
end type
type mle_2 from multilineedit within w_pisg070u
end type
type gb_3 from groupbox within w_pisg070u
end type
type gb_5 from groupbox within w_pisg070u
end type
type dw_pisg070u_01 from datawindow within w_pisg070u
end type
type gb_2 from groupbox within w_pisg070u
end type
type dw_prdorder from datawindow within w_pisg070u
end type
type dw_cycleorder from datawindow within w_pisg070u
end type
type dw_result from datawindow within w_pisg070u
end type
type dw_order from datawindow within w_pisg070u
end type
end forward

global type w_pisg070u from window
integer x = 46
integer y = 480
integer width = 3474
integer height = 1688
boolean titlebar = true
string title = "등록실적삭제"
windowtype windowtype = response!
long backcolor = 32241141
em_kbno em_kbno
pb_cancel pb_cancel
pb_result_del pb_result_del
pb_12 pb_12
pb_11 pb_11
pb_z pb_z
pb_y pb_y
pb_x pb_x
pb_w pb_w
pb_u pb_u
pb_t pb_t
pb_s pb_s
pb_r pb_r
pb_q pb_q
pb_p pb_p
pb_n pb_n
pb_m pb_m
pb_l pb_l
pb_k pb_k
pb_j pb_j
pb_i pb_i
pb_g pb_g
pb_f pb_f
pb_e pb_e
pb_d pb_d
pb_c pb_c
pb_b pb_b
pb_enter pb_enter
pb_10 pb_10
pb_9 pb_9
pb_8 pb_8
pb_7 pb_7
pb_back pb_back
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_v pb_v
pb_o pb_o
pb_h pb_h
pb_a pb_a
pb_6 pb_6
pb_1 pb_1
gb_4 gb_4
gb_1 gb_1
mle_2 mle_2
gb_3 gb_3
gb_5 gb_5
dw_pisg070u_01 dw_pisg070u_01
gb_2 gb_2
dw_prdorder dw_prdorder
dw_cycleorder dw_cycleorder
dw_result dw_result
dw_order dw_order
end type
global w_pisg070u w_pisg070u

type variables
INTEGER	ii_time_chk				//	시간 체크

end variables

forward prototypes
private function integer wf_record_delete (string fs_kbno, string fs_com_code)
private function boolean wf_kbinfo_select ()
end prototypes

private function integer wf_record_delete (string fs_kbno, string fs_com_code);INTEGER	li_error_code

DECLARE actual_delete	procedure for sp_pisg070u_02
@ps_areacode		= :gs_area_code,
@ps_divisioncode	= :gs_division_code,
@ps_workcenter		= :gs_workcenter_code[gi_tab_index],
@ps_linecode		= :gs_line_code[gi_tab_index],
@ps_kbno				= :fs_kbno,
@ps_com_code		= :fs_com_code,
@pi_err_code		= :li_error_code	output
USING	SQLCA ;

EXECUTE actual_delete ;

FETCH actual_delete
	INTO :li_error_code ;
CLOSE	actual_delete ;

RETURN li_error_code

end function

private function boolean wf_kbinfo_select ();STRING	ls_kbno
STRING	ls_applydate_close

INTEGER	li_loop_count
INTEGER	li_row_count

DATETIME ldt_system_datetime

BOOLEAN	lb_select_chk

/*######################################################################
#####		기본정보																	 #####
######################################################################*/

// 간판번호 입력
ls_kbno					= trim(em_kbno.text)

// 시스템 시간
ldt_system_datetime	= DATETIME(TODAY(),NOW())

// 마감고려한 시간
ls_applydate_close	= f_pisc_get_date_applydate(gs_area_code,	&
									gs_division_code,ldt_system_datetime)
// 레코드 카운터 초기화
li_row_count			= 0
lb_select_chk			= FALSE

// 라인 체크
FOR li_loop_count = 1 TO gi_tot_tab_count

	SELECT	COUNT(KBNo)
	  INTO	:li_row_count
	  FROM	TPLANRELEASE
	 WHERE	PlanDate			= :ls_applydate_close
		AND	AreaCode			= :gs_area_code
		AND	DivisionCode	= :gs_division_code
		AND	WorkCenter		= :gs_workcenter_code[li_loop_count]
		AND	LineCode			= :gs_line_code[li_loop_count]
		AND	KBNo				= :ls_kbno
		AND	PrdFlag			= 'E' ;

	IF li_row_count > 0 THEN

		gi_tab_index		= li_loop_count
		lb_select_chk		= TRUE

		// 라인 선택
		w_pisg030i.tab_line_select.SelectTab(gi_tab_index)

		// 정보 갱신
		dw_pisg070u_01.settransobject(sqlca)
		dw_pisg070u_01.Retrieve(ls_kbno, gs_area_code, gs_division_code,	& 
											gs_workcenter_code[gi_tab_index],		&
											gs_line_code[gi_tab_index])
		EXIT
	END IF
NEXT

RETURN	lb_select_chk

end function

on w_pisg070u.create
this.em_kbno=create em_kbno
this.pb_cancel=create pb_cancel
this.pb_result_del=create pb_result_del
this.pb_12=create pb_12
this.pb_11=create pb_11
this.pb_z=create pb_z
this.pb_y=create pb_y
this.pb_x=create pb_x
this.pb_w=create pb_w
this.pb_u=create pb_u
this.pb_t=create pb_t
this.pb_s=create pb_s
this.pb_r=create pb_r
this.pb_q=create pb_q
this.pb_p=create pb_p
this.pb_n=create pb_n
this.pb_m=create pb_m
this.pb_l=create pb_l
this.pb_k=create pb_k
this.pb_j=create pb_j
this.pb_i=create pb_i
this.pb_g=create pb_g
this.pb_f=create pb_f
this.pb_e=create pb_e
this.pb_d=create pb_d
this.pb_c=create pb_c
this.pb_b=create pb_b
this.pb_enter=create pb_enter
this.pb_10=create pb_10
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_7=create pb_7
this.pb_back=create pb_back
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_v=create pb_v
this.pb_o=create pb_o
this.pb_h=create pb_h
this.pb_a=create pb_a
this.pb_6=create pb_6
this.pb_1=create pb_1
this.gb_4=create gb_4
this.gb_1=create gb_1
this.mle_2=create mle_2
this.gb_3=create gb_3
this.gb_5=create gb_5
this.dw_pisg070u_01=create dw_pisg070u_01
this.gb_2=create gb_2
this.dw_prdorder=create dw_prdorder
this.dw_cycleorder=create dw_cycleorder
this.dw_result=create dw_result
this.dw_order=create dw_order
this.Control[]={this.em_kbno,&
this.pb_cancel,&
this.pb_result_del,&
this.pb_12,&
this.pb_11,&
this.pb_z,&
this.pb_y,&
this.pb_x,&
this.pb_w,&
this.pb_u,&
this.pb_t,&
this.pb_s,&
this.pb_r,&
this.pb_q,&
this.pb_p,&
this.pb_n,&
this.pb_m,&
this.pb_l,&
this.pb_k,&
this.pb_j,&
this.pb_i,&
this.pb_g,&
this.pb_f,&
this.pb_e,&
this.pb_d,&
this.pb_c,&
this.pb_b,&
this.pb_enter,&
this.pb_10,&
this.pb_9,&
this.pb_8,&
this.pb_7,&
this.pb_back,&
this.pb_5,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_v,&
this.pb_o,&
this.pb_h,&
this.pb_a,&
this.pb_6,&
this.pb_1,&
this.gb_4,&
this.gb_1,&
this.mle_2,&
this.gb_3,&
this.gb_5,&
this.dw_pisg070u_01,&
this.gb_2,&
this.dw_prdorder,&
this.dw_cycleorder,&
this.dw_result,&
this.dw_order}
end on

on w_pisg070u.destroy
destroy(this.em_kbno)
destroy(this.pb_cancel)
destroy(this.pb_result_del)
destroy(this.pb_12)
destroy(this.pb_11)
destroy(this.pb_z)
destroy(this.pb_y)
destroy(this.pb_x)
destroy(this.pb_w)
destroy(this.pb_u)
destroy(this.pb_t)
destroy(this.pb_s)
destroy(this.pb_r)
destroy(this.pb_q)
destroy(this.pb_p)
destroy(this.pb_n)
destroy(this.pb_m)
destroy(this.pb_l)
destroy(this.pb_k)
destroy(this.pb_j)
destroy(this.pb_i)
destroy(this.pb_g)
destroy(this.pb_f)
destroy(this.pb_e)
destroy(this.pb_d)
destroy(this.pb_c)
destroy(this.pb_b)
destroy(this.pb_enter)
destroy(this.pb_10)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_7)
destroy(this.pb_back)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_v)
destroy(this.pb_o)
destroy(this.pb_h)
destroy(this.pb_a)
destroy(this.pb_6)
destroy(this.pb_1)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.mle_2)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.dw_pisg070u_01)
destroy(this.gb_2)
destroy(this.dw_prdorder)
destroy(this.dw_cycleorder)
destroy(this.dw_result)
destroy(this.dw_order)
end on

event open;f_centerwindow(this)

// 간판입력창에 FOCUS
em_kbno.setfocus()

end event

event timer;/*######################################################################
#####		시간을 체크하여	데이타윈도우 COLOR 변경						 #####
######################################################################*/

ii_time_chk = ii_time_chk + 1

IF MOD(ii_time_chk, 2) = 1 THEN
	dw_pisg070u_01.Object.datawindow.color = RGB(203, 203, 203)
ELSE
	dw_pisg070u_01.Object.datawindow.color = RGB(255, 255, 255)
END IF

IF ii_time_chk > 8 THEN

	// 삭제 버튼 활성
	pb_result_del.enabled = TRUE

	// 윈도우 종료
	pb_cancel.TriggerEvent(Clicked!)
END IF

end event

event close;// 간판 입력창에 Focus
w_pisg030i.em_kb_no.SetFocus()


end event

type em_kbno from editmask within w_pisg070u
event ue_kendown pbm_keydown
integer x = 59
integer y = 104
integer width = 1157
integer height = 188
integer taborder = 10
integer textsize = -30
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

event ue_kendown;// 엔터 키
IF KEY	= KeyEnter! THEN
	IF wf_kbinfo_select() = FALSE THEN

		// ERROR
		Open(w_pisg071u)

		this.text 	= ''
		this.SetFocus()
	ELSE
		pb_result_del.SetFocus()
	END IF
END IF

end event

type pb_cancel from picturebutton within w_pisg070u
integer x = 745
integer y = 1292
integer width = 471
integer height = 256
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "취소"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;Close(w_pisg070u)
end event

type pb_result_del from picturebutton within w_pisg070u
integer x = 59
integer y = 1292
integer width = 471
integer height = 256
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "실적삭제"
string picturename = "bmp\background.gif"
string disabledname = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;STRING	ls_kbno					// 간판번호
STRING	ls_terminalcode		// 단말기명
STRING	ls_com_send				// 씨리얼 프래그

STRING	ls_applydate_close	// 마감 적용 시간

INTEGER	li_error_code			// ERROR CODE
INTEGER	li_record_count		// RECORD COUNT

DATETIME	ldt_system_datetime	// 시스템 시간

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ldt_system_datetime	= DATETIME(TODAY(),NOW())

ls_applydate_close	= f_pisc_get_date_applydate(gs_area_code,	&
									gs_division_code, ldt_system_datetime)
// 간판번호
ls_kbno					= trim(em_kbno.text)

// 단말기 코드
ls_terminalcode		= ProfileString(gs_inifile, "Com_Info", "Comcode", "")

// 해당간판번호의 COUNT 체크
SELECT	COUNT(KBNo)
  INTO	:li_record_count
  FROM	TPLANRELEASE
 WHERE	PlanDate			= :ls_applydate_close
	AND	AreaCode			= :gs_area_code
	AND	DivisionCode	= :gs_division_code
	AND	WorkCenter		= :gs_workcenter_code[gi_tab_index]
	AND	LineCode			= :gs_line_code[gi_tab_index]
	AND	KBNo				= :ls_kbno
	AND	ReleaseGubun	IN('T','Y')
	AND	PrdFlag			= 'E' ;

IF li_record_count > 0 THEN

	// 실행
	li_error_code		= wf_record_delete(ls_kbno, ls_terminalcode)

	// ERROR 체크
	IF li_error_code = 0 THEN

		// 삭제 버튼 비활성
		pb_result_del.enabled = FALSE

		// 조립순서 조회
		w_pisg030i.PostEvent("ue_line_select")

		IF gs_SerialFlag = "2" THEN
			// 씨리얼 통신
			ls_com_send		= f_comm()
			w_pisg010b.ole_comm.Object.Output	= ls_com_send
		END IF

		// TIMER
		timer(0.5)
	ELSE
		// ERROR
		Open(w_pisg072u)
	END IF
ELSE
	// ERROR
	Open(w_pisg071u)
END IF

end event

type pb_12 from picturebutton within w_pisg070u
integer x = 3127
integer y = 1320
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string disabledname = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

type pb_11 from picturebutton within w_pisg070u
integer x = 2816
integer y = 1320
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string disabledname = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

type pb_z from picturebutton within w_pisg070u
integer x = 2505
integer y = 1320
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Z"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'Z'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_y from picturebutton within w_pisg070u
integer x = 2194
integer y = 1320
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Y"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'Y'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_x from picturebutton within w_pisg070u
integer x = 1883
integer y = 1320
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "X"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'X'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_w from picturebutton within w_pisg070u
integer x = 1573
integer y = 1320
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "W"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'W'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_u from picturebutton within w_pisg070u
integer x = 3127
integer y = 1072
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "U"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'U'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_t from picturebutton within w_pisg070u
integer x = 2816
integer y = 1072
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "T"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'T'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_s from picturebutton within w_pisg070u
integer x = 2505
integer y = 1072
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "S"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'S'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_r from picturebutton within w_pisg070u
integer x = 2194
integer y = 1072
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "R"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'R'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_q from picturebutton within w_pisg070u
integer x = 1883
integer y = 1072
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Q"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'Q'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_p from picturebutton within w_pisg070u
integer x = 1573
integer y = 1072
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "P"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'P'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_n from picturebutton within w_pisg070u
integer x = 3127
integer y = 824
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "N"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'N'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_m from picturebutton within w_pisg070u
integer x = 2816
integer y = 824
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "M"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'M'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_l from picturebutton within w_pisg070u
integer x = 2505
integer y = 824
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "L"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'L'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_k from picturebutton within w_pisg070u
integer x = 2194
integer y = 824
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "K"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'K'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_j from picturebutton within w_pisg070u
integer x = 1883
integer y = 824
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "J"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'J'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_i from picturebutton within w_pisg070u
integer x = 1573
integer y = 824
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "I"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'I'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_g from picturebutton within w_pisg070u
integer x = 3127
integer y = 576
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "G"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'G'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_f from picturebutton within w_pisg070u
integer x = 2816
integer y = 576
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "F"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'F'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_e from picturebutton within w_pisg070u
integer x = 2505
integer y = 576
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "E"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'E'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_d from picturebutton within w_pisg070u
integer x = 2194
integer y = 576
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "D"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'D'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_c from picturebutton within w_pisg070u
integer x = 1883
integer y = 576
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "C"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'C'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_b from picturebutton within w_pisg070u
integer x = 1573
integer y = 576
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "B"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'B'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_enter from picturebutton within w_pisg070u
integer x = 2816
integer y = 304
integer width = 622
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Enter"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.TriggerEvent(losefocus!)

end event

type pb_10 from picturebutton within w_pisg070u
integer x = 2505
integer y = 304
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "0"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '0'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_9 from picturebutton within w_pisg070u
integer x = 2194
integer y = 304
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "9"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '9'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_8 from picturebutton within w_pisg070u
integer x = 1883
integer y = 304
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "8"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '8'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_7 from picturebutton within w_pisg070u
integer x = 1573
integer y = 304
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "7"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '7'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_back from picturebutton within w_pisg070u
integer x = 2816
integer y = 56
integer width = 622
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "<---"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = MID(trim(em_kbno.text), 1, len(trim(em_kbno.text)) - 1)

end event

type pb_5 from picturebutton within w_pisg070u
integer x = 2505
integer y = 56
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "5"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '5'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_4 from picturebutton within w_pisg070u
integer x = 2194
integer y = 56
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "4"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '4'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_3 from picturebutton within w_pisg070u
integer x = 1883
integer y = 56
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "3"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '3'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_2 from picturebutton within w_pisg070u
integer x = 1573
integer y = 56
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "2"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '2'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_v from picturebutton within w_pisg070u
integer x = 1262
integer y = 1320
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "V"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'V'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_o from picturebutton within w_pisg070u
integer x = 1262
integer y = 1072
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "O"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'O'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_h from picturebutton within w_pisg070u
integer x = 1262
integer y = 824
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "H"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'H'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_a from picturebutton within w_pisg070u
integer x = 1262
integer y = 576
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "A"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + 'A'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_6 from picturebutton within w_pisg070u
integer x = 1262
integer y = 304
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "6"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '6'

// 삭제버튼에 포커스
em_kbno.setfocus()

end event

type pb_1 from picturebutton within w_pisg070u
integer x = 1262
integer y = 56
integer width = 311
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "1"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;em_kbno.text = em_kbno.text + '1'

// 삭제버튼에 포커스
em_kbno.setfocus()


end event

type gb_4 from groupbox within w_pisg070u
integer x = 1248
integer y = 36
integer width = 2208
integer height = 532
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_pisg070u
integer x = 18
integer y = 8
integer width = 1239
integer height = 312
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 128
long backcolor = 32241141
string text = "간판번호"
end type

type mle_2 from multilineedit within w_pisg070u
integer x = 59
integer y = 1120
integer width = 1157
integer height = 144
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 128
long backcolor = 32241141
string text = "상기 간판의 생산실적을          삭제 하시겠습니까?"
boolean border = false
end type

type gb_3 from groupbox within w_pisg070u
integer x = 18
integer y = 1068
integer width = 1239
integer height = 516
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32241141
end type

type gb_5 from groupbox within w_pisg070u
integer x = 1248
integer y = 556
integer width = 2208
integer height = 1028
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_pisg070u_01 from datawindow within w_pisg070u
integer x = 59
integer y = 348
integer width = 1157
integer height = 700
string dataobject = "d_pisg070u_01"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisg070u
integer x = 18
integer y = 304
integer width = 1239
integer height = 780
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32241141
end type

type dw_prdorder from datawindow within w_pisg070u
integer x = 402
integer y = 328
integer width = 73
integer height = 68
string title = "none"
string dataobject = "d_pisg070u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_cycleorder from datawindow within w_pisg070u
integer x = 315
integer y = 336
integer width = 73
integer height = 80
string dataobject = "d_pisg070u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_result from datawindow within w_pisg070u
integer x = 219
integer y = 336
integer width = 69
integer height = 80
string dataobject = "d_pisg050u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_order from datawindow within w_pisg070u
integer x = 101
integer y = 340
integer width = 96
integer height = 68
string dataobject = "d_pisg050u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

