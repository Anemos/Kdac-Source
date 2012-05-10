$PBExportHeader$w_mpsg070u.srw
$PBExportComments$현장관리_생산실적등록 삭제
forward
global type w_mpsg070u from window
end type
type sle_kbno from singlelineedit within w_mpsg070u
end type
type pb_cancel from picturebutton within w_mpsg070u
end type
type pb_result_del from picturebutton within w_mpsg070u
end type
type pb_12 from picturebutton within w_mpsg070u
end type
type pb_11 from picturebutton within w_mpsg070u
end type
type pb_z from picturebutton within w_mpsg070u
end type
type pb_y from picturebutton within w_mpsg070u
end type
type pb_x from picturebutton within w_mpsg070u
end type
type pb_w from picturebutton within w_mpsg070u
end type
type pb_u from picturebutton within w_mpsg070u
end type
type pb_t from picturebutton within w_mpsg070u
end type
type pb_s from picturebutton within w_mpsg070u
end type
type pb_r from picturebutton within w_mpsg070u
end type
type pb_q from picturebutton within w_mpsg070u
end type
type pb_p from picturebutton within w_mpsg070u
end type
type pb_n from picturebutton within w_mpsg070u
end type
type pb_m from picturebutton within w_mpsg070u
end type
type pb_l from picturebutton within w_mpsg070u
end type
type pb_k from picturebutton within w_mpsg070u
end type
type pb_j from picturebutton within w_mpsg070u
end type
type pb_i from picturebutton within w_mpsg070u
end type
type pb_g from picturebutton within w_mpsg070u
end type
type pb_f from picturebutton within w_mpsg070u
end type
type pb_e from picturebutton within w_mpsg070u
end type
type pb_d from picturebutton within w_mpsg070u
end type
type pb_c from picturebutton within w_mpsg070u
end type
type pb_b from picturebutton within w_mpsg070u
end type
type pb_enter from picturebutton within w_mpsg070u
end type
type pb_10 from picturebutton within w_mpsg070u
end type
type pb_9 from picturebutton within w_mpsg070u
end type
type pb_8 from picturebutton within w_mpsg070u
end type
type pb_7 from picturebutton within w_mpsg070u
end type
type pb_back from picturebutton within w_mpsg070u
end type
type pb_5 from picturebutton within w_mpsg070u
end type
type pb_4 from picturebutton within w_mpsg070u
end type
type pb_3 from picturebutton within w_mpsg070u
end type
type pb_2 from picturebutton within w_mpsg070u
end type
type pb_v from picturebutton within w_mpsg070u
end type
type pb_o from picturebutton within w_mpsg070u
end type
type pb_h from picturebutton within w_mpsg070u
end type
type pb_a from picturebutton within w_mpsg070u
end type
type pb_6 from picturebutton within w_mpsg070u
end type
type pb_1 from picturebutton within w_mpsg070u
end type
type gb_4 from groupbox within w_mpsg070u
end type
type gb_1 from groupbox within w_mpsg070u
end type
type mle_2 from multilineedit within w_mpsg070u
end type
type gb_3 from groupbox within w_mpsg070u
end type
type gb_5 from groupbox within w_mpsg070u
end type
type dw_mpsg070u_01 from datawindow within w_mpsg070u
end type
type gb_2 from groupbox within w_mpsg070u
end type
type dw_prdorder from datawindow within w_mpsg070u
end type
type dw_cycleorder from datawindow within w_mpsg070u
end type
type dw_result from datawindow within w_mpsg070u
end type
type dw_order from datawindow within w_mpsg070u
end type
end forward

global type w_mpsg070u from window
integer x = 46
integer y = 480
integer width = 3899
integer height = 1724
boolean titlebar = true
string title = "등록실적삭제"
windowtype windowtype = response!
long backcolor = 32241141
sle_kbno sle_kbno
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
dw_mpsg070u_01 dw_mpsg070u_01
gb_2 gb_2
dw_prdorder dw_prdorder
dw_cycleorder dw_cycleorder
dw_result dw_result
dw_order dw_order
end type
global w_mpsg070u w_mpsg070u

type variables
INTEGER	ii_time_chk				//	시간 체크

end variables

forward prototypes
private function integer wf_record_delete ()
public function boolean wf_kbinfo_select ()
end prototypes

private function integer wf_record_delete ();INTEGER	li_error_code
STRING	ls_stype, ls_srno

ls_stype = dw_mpsg070u_01.getitemstring(1,"stype")
ls_srno = dw_mpsg070u_01.getitemstring(1,"srno")

DECLARE actual_recording procedure for sp_mpsg070u_delete
@ps_stype		= :ls_stype,
@ps_srno			= :ls_srno,
@pi_err_code		= :li_error_code	output
USING	SQLCA ;

EXECUTE actual_recording ;

FETCH actual_recording
	INTO :li_error_code ;
CLOSE	actual_recording ;

RETURN li_error_code
end function

public function boolean wf_kbinfo_select ();string ls_kbno, ls_ptype, ls_orderno, ls_partno, ls_stype, ls_srno

ls_kbno = trim(sle_kbno.text)

choose case mid(ls_kbno,1,1)
	case 'A','C'
		ls_orderno = mid(ls_kbno,2,8)
		ls_partno = mid(ls_kbno,10,6)
		
	case 'B'
		ls_stype = mid(ls_kbno,2,2)
		ls_srno = mid(ls_kbno,4,10)
		
	case else
		return false
end choose

return true
end function
on w_mpsg070u.create
this.sle_kbno=create sle_kbno
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
this.dw_mpsg070u_01=create dw_mpsg070u_01
this.gb_2=create gb_2
this.dw_prdorder=create dw_prdorder
this.dw_cycleorder=create dw_cycleorder
this.dw_result=create dw_result
this.dw_order=create dw_order
this.Control[]={this.sle_kbno,&
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
this.dw_mpsg070u_01,&
this.gb_2,&
this.dw_prdorder,&
this.dw_cycleorder,&
this.dw_result,&
this.dw_order}
end on

on w_mpsg070u.destroy
destroy(this.sle_kbno)
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
destroy(this.dw_mpsg070u_01)
destroy(this.gb_2)
destroy(this.dw_prdorder)
destroy(this.dw_cycleorder)
destroy(this.dw_result)
destroy(this.dw_order)
end on

event open;STRING ls_message, ls_stype, ls_srno, ls_kbno
STRING ls_orderno, ls_partno
DATAWINDOWCHILD ldwc

f_centerwindow(this)

dw_mpsg070u_01.GetChild('resultflag', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve('MPM008')

// 실적데이타 가져오기
ls_message = Message.StringParm
ls_stype = Mid(ls_message,1,2)
ls_srno = Mid(ls_message,3)

SELECT OrderNo, PartNo INTO :ls_orderno, :ls_partno
FROM TWORKJOB
WHERE Stype = :ls_stype AND Srno = :ls_srno AND
	WcCode = :gs_line_code[gi_tab_index] ;

If f_mpsg_spacechk(ls_orderno) = -1 Then
	sle_kbno.text = ""
	sle_kbno.setfocus()
	return 0
End If
// 간판번호
ls_kbno			= "D" + ls_orderno + ls_partno
sle_kbno.text	= ls_kbno

// 시간 셋팅
//ldt_now_datetime		= DATETIME(TODAY(), NOW())

//ls_applydate_close	= f_mpms_get_applydate(ldt_now_datetime)

// 단말기 코드
//ls_terminalcode	= ProfileString(gs_inifile, "Com_Info", "Comcode", "")
		
// 정보조회
dw_mpsg070u_01.settransobject(sqlca)
dw_mpsg070u_01.Retrieve( ls_stype, ls_srno, gs_line_code[gi_tab_index])

end event

event timer;/*######################################################################
#####		시간을 체크하여	데이타윈도우 COLOR 변경						 #####
######################################################################*/

ii_time_chk = ii_time_chk + 1

IF MOD(ii_time_chk, 2) = 1 THEN
	dw_mpsg070u_01.Object.datawindow.color = RGB(203, 203, 203)
ELSE
	dw_mpsg070u_01.Object.datawindow.color = RGB(255, 255, 255)
END IF

IF ii_time_chk > 8 or isnull(ii_time_chk) THEN
	// 삭제 버튼 활성
	pb_result_del.enabled = TRUE

	// 윈도우 종료
	pb_cancel.TriggerEvent(Clicked!)
END IF

end event

type sle_kbno from singlelineedit within w_mpsg070u
integer x = 59
integer y = 104
integer width = 1527
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
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type pb_cancel from picturebutton within w_mpsg070u
integer x = 942
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

event clicked;Close(w_mpsg070u)

Choose case gi_page_index
	case 3
		// 실적조회
		w_mpsg090i.TriggerEvent("ue_line_select")
	case 4
		// 작업일보
		w_mpsg080i.TriggerEvent("ue_line_select")
	case else
		// 간판 입력창에 Focus
		w_mpsg030i.triggerevent("Activate!")
		w_mpsg030i.em_kb_no.SetFocus()
		
		IF IsValid(w_mpsg030i) THEN
		
			// 실적등록화면 최상위로
			w_mpsg030i.BringToTop = TRUE
		
			// 실적등록의 LINE선택 이벤트
			w_mpsg030i.TriggerEvent("ue_line_select")
		
			// 간판번호 입력창의 초기화및 FOCUS
			w_mpsg030i.em_kb_no.text = ''
			w_mpsg030i.em_kb_no.SetFocus()
		ELSE
			// 실적등록 Open
			Open(w_mpsg030i)
		END IF
end choose
end event

type pb_result_del from picturebutton within w_mpsg070u
integer x = 256
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
STRING	ls_stype, ls_srno

STRING	ls_applydate_close	// 마감 적용 시간

INTEGER	li_error_code			// ERROR CODE
INTEGER	li_record_count		// RECORD COUNT

DATETIME	ldt_system_datetime	// 시스템 시간

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ldt_system_datetime	= DATETIME(TODAY(),NOW())

ls_applydate_close	= f_mpms_get_applydate(ldt_system_datetime)
// 간판번호
ls_kbno					= trim(sle_kbno.text)

// 단말기 코드
ls_terminalcode		= ProfileString(gs_inifile, "Com_Info", "Comcode", "")

// 실행
li_error_code		= wf_record_delete()

// ERROR 체크
IF li_error_code = 0 THEN
	// TIMER
	timer(0.5)
ELSE
	// ERROR
	Open(w_mpsg072u)
END IF

end event

type pb_12 from picturebutton within w_mpsg070u
integer x = 3543
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

type pb_11 from picturebutton within w_mpsg070u
integer x = 3232
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

type pb_z from picturebutton within w_mpsg070u
integer x = 2921
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'Z'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_y from picturebutton within w_mpsg070u
integer x = 2610
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'Y'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_x from picturebutton within w_mpsg070u
integer x = 2299
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'X'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_w from picturebutton within w_mpsg070u
integer x = 1989
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'W'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_u from picturebutton within w_mpsg070u
integer x = 3543
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'U'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_t from picturebutton within w_mpsg070u
integer x = 3232
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'T'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_s from picturebutton within w_mpsg070u
integer x = 2921
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'S'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_r from picturebutton within w_mpsg070u
integer x = 2610
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'R'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_q from picturebutton within w_mpsg070u
integer x = 2299
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'Q'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_p from picturebutton within w_mpsg070u
integer x = 1989
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'P'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_n from picturebutton within w_mpsg070u
integer x = 3543
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'N'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_m from picturebutton within w_mpsg070u
integer x = 3232
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'M'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_l from picturebutton within w_mpsg070u
integer x = 2921
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'L'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_k from picturebutton within w_mpsg070u
integer x = 2610
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'K'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_j from picturebutton within w_mpsg070u
integer x = 2299
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'J'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_i from picturebutton within w_mpsg070u
integer x = 1989
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'I'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_g from picturebutton within w_mpsg070u
integer x = 3543
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'G'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_f from picturebutton within w_mpsg070u
integer x = 3232
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'F'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_e from picturebutton within w_mpsg070u
integer x = 2921
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'E'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_d from picturebutton within w_mpsg070u
integer x = 2610
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'D'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_c from picturebutton within w_mpsg070u
integer x = 2299
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'C'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_b from picturebutton within w_mpsg070u
integer x = 1989
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'B'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_enter from picturebutton within w_mpsg070u
integer x = 3232
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

event clicked;sle_kbno.TriggerEvent(losefocus!)

end event

type pb_10 from picturebutton within w_mpsg070u
integer x = 2921
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '0'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_9 from picturebutton within w_mpsg070u
integer x = 2610
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '9'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_8 from picturebutton within w_mpsg070u
integer x = 2299
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '8'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_7 from picturebutton within w_mpsg070u
integer x = 1989
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '7'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_back from picturebutton within w_mpsg070u
integer x = 3232
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

event clicked;sle_kbno.text = MID(trim(sle_kbno.text), 1, len(trim(sle_kbno.text)) - 1)

end event

type pb_5 from picturebutton within w_mpsg070u
integer x = 2921
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '5'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_4 from picturebutton within w_mpsg070u
integer x = 2610
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '4'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_3 from picturebutton within w_mpsg070u
integer x = 2299
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '3'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_2 from picturebutton within w_mpsg070u
integer x = 1989
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '2'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_v from picturebutton within w_mpsg070u
integer x = 1678
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'V'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_o from picturebutton within w_mpsg070u
integer x = 1678
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'O'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_h from picturebutton within w_mpsg070u
integer x = 1678
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'H'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_a from picturebutton within w_mpsg070u
integer x = 1678
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + 'A'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_6 from picturebutton within w_mpsg070u
integer x = 1678
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '6'

// 삭제버튼에 포커스
sle_kbno.setfocus()

end event

type pb_1 from picturebutton within w_mpsg070u
integer x = 1678
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

event clicked;if len(sle_kbno.text) < 1 then
	sle_kbno.text = 'D'
end if
sle_kbno.text = sle_kbno.text + '1'

// 삭제버튼에 포커스
sle_kbno.setfocus()


end event

type gb_4 from groupbox within w_mpsg070u
integer x = 1664
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

type gb_1 from groupbox within w_mpsg070u
integer x = 18
integer y = 8
integer width = 1614
integer height = 312
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 128
long backcolor = 32241141
string text = "작업지시서번호"
end type

type mle_2 from multilineedit within w_mpsg070u
integer x = 256
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
string text = "상기 작업지시서의 생산실적을          삭제 하시겠습니까?"
boolean border = false
end type

type gb_3 from groupbox within w_mpsg070u
integer x = 18
integer y = 1068
integer width = 1614
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

type gb_5 from groupbox within w_mpsg070u
integer x = 1664
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

type dw_mpsg070u_01 from datawindow within w_mpsg070u
integer x = 50
integer y = 328
integer width = 1550
integer height = 736
string dataobject = "d_mpsg070u_01"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_mpsg070u
integer x = 18
integer y = 304
integer width = 1614
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

type dw_prdorder from datawindow within w_mpsg070u
integer x = 402
integer y = 328
integer width = 73
integer height = 68
string title = "none"
string dataobject = "d_pisg070u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_cycleorder from datawindow within w_mpsg070u
integer x = 315
integer y = 336
integer width = 73
integer height = 80
string dataobject = "d_pisg070u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_result from datawindow within w_mpsg070u
integer x = 219
integer y = 336
integer width = 69
integer height = 80
string dataobject = "d_pisg050u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_order from datawindow within w_mpsg070u
integer x = 101
integer y = 340
integer width = 96
integer height = 68
string dataobject = "d_pisg050u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

