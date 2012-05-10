$PBExportHeader$w_pisg010b.srw
$PBExportComments$현장관리_메인화면
forward
global type w_pisg010b from window
end type
type st_exit from statictext within w_pisg010b
end type
type st_actual_record_cancel from statictext within w_pisg010b
end type
type st_keycode from statictext within w_pisg010b
end type
type st_recovery from statictext within w_pisg010b
end type
type st_send_message from statictext within w_pisg010b
end type
type st_lotno_record from statictext within w_pisg010b
end type
type st_plan_actual_condition from statictext within w_pisg010b
end type
type st_actual_record from statictext within w_pisg010b
end type
type st_main from statictext within w_pisg010b
end type
type p_recovery from picture within w_pisg010b
end type
type p_main from picture within w_pisg010b
end type
type ole_comm from olecustomcontrol within w_pisg010b
end type
type st_2 from statictext within w_pisg010b
end type
type st_1 from statictext within w_pisg010b
end type
type p_send_message from picture within w_pisg010b
end type
type dw_tomessage from datawindow within w_pisg010b
end type
type pb_send_message from picturebutton within w_pisg010b
end type
type p_actual_record_cancel from picture within w_pisg010b
end type
type p_lot_record from picture within w_pisg010b
end type
type p_plan_actual_condition from picture within w_pisg010b
end type
type p_actual_record from picture within w_pisg010b
end type
type pb_lotno_record from picturebutton within w_pisg010b
end type
type pb_plan_actual_condition from picturebutton within w_pisg010b
end type
type pb_actual_record from picturebutton within w_pisg010b
end type
type p_exit from picture within w_pisg010b
end type
type pb_exit from picturebutton within w_pisg010b
end type
type pb_actual_record_cancel from picturebutton within w_pisg010b
end type
type pb_main from picturebutton within w_pisg010b
end type
type pb_recovery from picturebutton within w_pisg010b
end type
type dw_pisg010b_01 from datawindow within w_pisg010b
end type
type p_keycode from picture within w_pisg010b
end type
type p_message from picture within w_pisg010b
end type
type pb_keycode from picturebutton within w_pisg010b
end type
end forward

shared variables

end variables

global type w_pisg010b from window
integer width = 3653
integer height = 2396
boolean titlebar = true
string title = "IPIS 2000 통합생산정보시스템 현장관리"
long backcolor = 79219928
toolbaralignment toolbaralignment = alignatbottom!
boolean clientedge = true
event ue_line_select ( )
st_exit st_exit
st_actual_record_cancel st_actual_record_cancel
st_keycode st_keycode
st_recovery st_recovery
st_send_message st_send_message
st_lotno_record st_lotno_record
st_plan_actual_condition st_plan_actual_condition
st_actual_record st_actual_record
st_main st_main
p_recovery p_recovery
p_main p_main
ole_comm ole_comm
st_2 st_2
st_1 st_1
p_send_message p_send_message
dw_tomessage dw_tomessage
pb_send_message pb_send_message
p_actual_record_cancel p_actual_record_cancel
p_lot_record p_lot_record
p_plan_actual_condition p_plan_actual_condition
p_actual_record p_actual_record
pb_lotno_record pb_lotno_record
pb_plan_actual_condition pb_plan_actual_condition
pb_actual_record pb_actual_record
p_exit p_exit
pb_exit pb_exit
pb_actual_record_cancel pb_actual_record_cancel
pb_main pb_main
pb_recovery pb_recovery
dw_pisg010b_01 dw_pisg010b_01
p_keycode p_keycode
p_message p_message
pb_keycode pb_keycode
end type
global w_pisg010b w_pisg010b

type prototypes

end prototypes

type variables
connection myconnection
n_remote in_proxy

end variables

on w_pisg010b.create
this.st_exit=create st_exit
this.st_actual_record_cancel=create st_actual_record_cancel
this.st_keycode=create st_keycode
this.st_recovery=create st_recovery
this.st_send_message=create st_send_message
this.st_lotno_record=create st_lotno_record
this.st_plan_actual_condition=create st_plan_actual_condition
this.st_actual_record=create st_actual_record
this.st_main=create st_main
this.p_recovery=create p_recovery
this.p_main=create p_main
this.ole_comm=create ole_comm
this.st_2=create st_2
this.st_1=create st_1
this.p_send_message=create p_send_message
this.dw_tomessage=create dw_tomessage
this.pb_send_message=create pb_send_message
this.p_actual_record_cancel=create p_actual_record_cancel
this.p_lot_record=create p_lot_record
this.p_plan_actual_condition=create p_plan_actual_condition
this.p_actual_record=create p_actual_record
this.pb_lotno_record=create pb_lotno_record
this.pb_plan_actual_condition=create pb_plan_actual_condition
this.pb_actual_record=create pb_actual_record
this.p_exit=create p_exit
this.pb_exit=create pb_exit
this.pb_actual_record_cancel=create pb_actual_record_cancel
this.pb_main=create pb_main
this.pb_recovery=create pb_recovery
this.dw_pisg010b_01=create dw_pisg010b_01
this.p_keycode=create p_keycode
this.p_message=create p_message
this.pb_keycode=create pb_keycode
this.Control[]={this.st_exit,&
this.st_actual_record_cancel,&
this.st_keycode,&
this.st_recovery,&
this.st_send_message,&
this.st_lotno_record,&
this.st_plan_actual_condition,&
this.st_actual_record,&
this.st_main,&
this.p_recovery,&
this.p_main,&
this.ole_comm,&
this.st_2,&
this.st_1,&
this.p_send_message,&
this.dw_tomessage,&
this.pb_send_message,&
this.p_actual_record_cancel,&
this.p_lot_record,&
this.p_plan_actual_condition,&
this.p_actual_record,&
this.pb_lotno_record,&
this.pb_plan_actual_condition,&
this.pb_actual_record,&
this.p_exit,&
this.pb_exit,&
this.pb_actual_record_cancel,&
this.pb_main,&
this.pb_recovery,&
this.dw_pisg010b_01,&
this.p_keycode,&
this.p_message,&
this.pb_keycode}
end on

on w_pisg010b.destroy
destroy(this.st_exit)
destroy(this.st_actual_record_cancel)
destroy(this.st_keycode)
destroy(this.st_recovery)
destroy(this.st_send_message)
destroy(this.st_lotno_record)
destroy(this.st_plan_actual_condition)
destroy(this.st_actual_record)
destroy(this.st_main)
destroy(this.p_recovery)
destroy(this.p_main)
destroy(this.ole_comm)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_send_message)
destroy(this.dw_tomessage)
destroy(this.pb_send_message)
destroy(this.p_actual_record_cancel)
destroy(this.p_lot_record)
destroy(this.p_plan_actual_condition)
destroy(this.p_actual_record)
destroy(this.pb_lotno_record)
destroy(this.pb_plan_actual_condition)
destroy(this.pb_actual_record)
destroy(this.p_exit)
destroy(this.pb_exit)
destroy(this.pb_actual_record_cancel)
destroy(this.pb_main)
destroy(this.pb_recovery)
destroy(this.dw_pisg010b_01)
destroy(this.p_keycode)
destroy(this.p_message)
destroy(this.pb_keycode)
end on

event open;STRING	ls_terminalcode			// 단말기명
INTEGER	li_loop_count				// Loop 변수

/*######################################################################
#####		화면의 중심																 #####
######################################################################*/

f_centerwindow( this )

/*######################################################################
#####		선택라인 초기화														 #####
######################################################################*/

gi_tab_index		= 1
gi_page_index		= 1

/*######################################################################
#####		서버의 시간과 동기화													 #####
######################################################################*/

f_system_time()

/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

pb_keycode.enabled					= FALSE
st_keycode.text						= ''
p_keycode.visible						= FALSE

p_message.visible						= FALSE

pb_actual_record_cancel.enabled	= FALSE
st_actual_record_cancel.text		= ""
p_actual_record_cancel.visible	= FALSE

/*######################################################################
#####		지역,공장,단말기명 													 #####
######################################################################*/

ls_terminalcode	= TRIM(ProfileString(gs_inifile, "Com_Info", "Comcode", ""))

// 지역 CODE
SELECT	AreaCode, DivisionCode
  INTO	:gs_area_code, :gs_division_code
  FROM	TMSTTERMINAL
 WHERE	TerminalCode	= :ls_terminalcode ;

/*######################################################################
#####		지역명, 공장명															 #####
######################################################################*/

// 지역명
SELECT	AreaName
  INTO	:gs_area_name
  FROM	TMSTAREA
 WHERE	AreaCode			= :gs_area_code ;

// 공장명
SELECT	DivisionName
  INTO	:gs_division_name
  FROM	TMSTDIVISION
 WHERE	AreaCode			= :gs_area_code
   AND	DivisionCode	= :gs_division_code ;

/*######################################################################
#####		단말기명으로 조와 라인정보를 가져옴								 #####
######################################################################*/

// 조와 라인코드
dw_pisg010b_01.settransobject(sqlca)
dw_pisg010b_01.Retrieve(gs_area_code, gs_division_code, ls_terminalcode)

// 단말기에 물려있는 라인수 
gi_tot_tab_count = dw_pisg010b_01.rowcount()

// 해당 정보가 없는 경우 프로그램 종료
IF gi_tot_tab_count	<	1	THEN 

	// 종료 정보
	Open(w_pisg011b)

	// 종료
	CLOSE(this)
//	pb_exit.TriggerEvent(Clicked!)
END IF

// 각 라인의 정보
FOR li_loop_count = 1 TO gi_tot_tab_count
	gs_workcenter_code[li_loop_count]	=	&
		dw_pisg010b_01.GetItemString(li_loop_count, "as_workcenter")
	gs_line_code[li_loop_count]			= &
		dw_pisg010b_01.GetItemString(li_loop_count, "as_linecode")

	// 조 명
	SELECT	LTRIM(RTRIM(WorkCenterName))
	  INTO	:gs_workcenter_name[li_loop_count]
	  FROM	TMSTWORKCENTER
	 WHERE	AreaCode			= :gs_area_code
		AND	DivisionCode	= :gs_division_code
		AND	WorkCenter		= :gs_workcenter_code[li_loop_count] ;

	// 라인명및 조회 수량
	SELECT	DisplayCount,
				LTRIM(RTRIM(LineFullName))
	  INTO	:gi_show_count[li_loop_count], 
	  			:gs_line_name[li_loop_count]
	  FROM	TMSTLINE
	 WHERE	AreaCode			= :gs_area_code
		AND	DivisionCode	= :gs_division_code
		AND	WorkCenter		= :gs_workcenter_code[li_loop_count]
		AND	LineCode			= :gs_line_code[li_loop_count] ;

	// 값이 NULL 인경우 스페이스
	IF gs_workcenter_name[li_loop_count] = '' THEN
		gs_workcenter_name[li_loop_count] = ' '
	END IF

	IF gs_line_name[li_loop_count] = '' THEN
		gs_line_name[li_loop_count] = ' '
	END IF
NEXT

/*######################################################################
#####		SERIAL 통신 포트 OPEN												 #####
######################################################################*/

gs_SerialFlag		= ProfileString(gs_inifile, "Com_Info", "SerialFlag", "1")

// '2' --> 씨리얼 통신
IF gs_SerialFlag = "2" THEN
	// 통신 포트 OPEN
	ole_comm.object.portopen	= True
END IF

/*######################################################################
#####		1분마다 시간 업데이트												 #####
######################################################################*/

timer(600)

/*######################################################################
#####		단말기 정보 조회 Open												 #####
######################################################################*/

Open(w_pisg020i)

end event

event timer;/*######################################################################
#####		7:59에 프로그램 DownLoad											#####
######################################################################*/
DateTime ldt_now
String ls_Restart_Exe

Select Top 1 GetDate() Into :ldt_now From sysusers;

//IF String(ldt_now,"hh:mm") = "07:59" THEN
	// DownLoad
	If f_ipis_check_download() = 0 Then
		IF gs_SerialFlag = "2" THEN
			// 통신 포트 CLOSE
			ole_comm.object.portopen	= FALSE
		END IF
		
		Close(This)
		ls_Restart_Exe = 'auto_down.exe'
		If Run(ls_Restart_Exe) <> 1 Then
			Beep(1)
			If FileExists(ls_Restart_Exe) = FALSE Then
				MessageBox("Help", ls_Restart_Exe + " can not be found!")
			End if
		End If
	End If
//END IF


/*######################################################################
#####		서버의 시간과 동기화													 #####
######################################################################*/

f_system_time()

end event

type st_exit from statictext within w_pisg010b
integer x = 3269
integer y = 2168
integer width = 306
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "종료"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_actual_record_cancel from statictext within w_pisg010b
integer x = 2866
integer y = 2168
integer width = 306
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_keycode from statictext within w_pisg010b
integer x = 2464
integer y = 2168
integer width = 306
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_recovery from statictext within w_pisg010b
integer x = 2062
integer y = 2168
integer width = 306
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "회수처리"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_send_message from statictext within w_pisg010b
integer x = 1641
integer y = 2168
integer width = 338
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "메세지전송"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_lotno_record from statictext within w_pisg010b
integer x = 1257
integer y = 2168
integer width = 306
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "LOT분할"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_plan_actual_condition from statictext within w_pisg010b
integer x = 855
integer y = 2168
integer width = 306
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "실적조회"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_actual_record from statictext within w_pisg010b
integer x = 453
integer y = 2168
integer width = 306
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "실적등록"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_main from statictext within w_pisg010b
integer x = 50
integer y = 2168
integer width = 306
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 33554432
long backcolor = 32764915
boolean enabled = false
string text = "MAIN"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_recovery from picture within w_pisg010b
integer x = 2144
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_recovery.gif"
boolean focusrectangle = false
end type

type p_main from picture within w_pisg010b
integer x = 133
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_main.gif"
boolean focusrectangle = false
end type

type ole_comm from olecustomcontrol within w_pisg010b
event oncomm ( )
integer x = 763
integer y = 16
integer width = 174
integer height = 152
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_pisg010b.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

type st_2 from statictext within w_pisg010b
integer x = 2418
integer y = 2260
integer width = 1202
integer height = 36
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 255
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisg010b
integer x = 5
integer y = 2260
integer width = 2409
integer height = 36
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 16711680
alignment alignment = center!
boolean focusrectangle = false
end type

type p_send_message from picture within w_pisg010b
integer x = 1742
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_MessageTransmission.gif"
boolean focusrectangle = false
end type

type dw_tomessage from datawindow within w_pisg010b
integer x = 1600
integer y = 476
integer width = 137
integer height = 108
integer taborder = 10
string dataobject = "d_pisg110b_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_send_message from picturebutton within w_pisg010b
integer x = 1614
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

gi_page_index							= 5

pb_keycode.enabled					= TRUE
st_keycode.text						= "전송"
p_keycode.visible						= FALSE

p_message.visible						= TRUE

pb_actual_record_cancel.enabled	= FALSE
st_actual_record_cancel.text		= ""
p_actual_record_cancel.visible	= FALSE

/*######################################################################
#####		윈도우 체크																 #####
######################################################################*/

IF IsValid(w_pisg110b) THEN

	// 메세지 전송화면 최상위로
	w_pisg110b.BringToTop = TRUE

	// 메세지 전송화면 갱신
	w_pisg110b.TriggerEvent("ue_info_renewal")
ELSE
	// 실적등록 Open
	Open(w_pisg110b)
END IF

end event

type p_actual_record_cancel from picture within w_pisg010b
integer x = 2949
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_RegCancel.gif"
boolean focusrectangle = false
end type

type p_lot_record from picture within w_pisg010b
integer x = 1339
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_LotDivision.gif"
boolean focusrectangle = false
end type

type p_plan_actual_condition from picture within w_pisg010b
integer x = 946
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_ResultsInquiry.gif"
boolean focusrectangle = false
end type

type p_actual_record from picture within w_pisg010b
integer x = 544
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_ResultsRegistration.gif"
boolean focusrectangle = false
end type

type pb_lotno_record from picturebutton within w_pisg010b
integer x = 1211
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

gi_page_index							= 4

pb_keycode.enabled					= TRUE
st_keycode.text						= "신규등록"
p_keycode.visible						= TRUE

p_message.visible						= FALSE

pb_actual_record_cancel.enabled	= FALSE
st_actual_record_cancel.text		= ""
p_actual_record_cancel.visible	= FALSE

/*######################################################################
#####		윈도우 체크																 #####
######################################################################*/

IF IsValid(w_pisg090i) THEN

	/*###################################################################
	#####		분할 LOT등록을 상위로											 #####
	###################################################################*/

	w_pisg090i.BringToTop = TRUE

	w_pisg090i.TriggerEvent("ue_info_renew")

ELSE
	/*###################################################################
	#####		분할 LOT등록 Open													 #####
	###################################################################*/

	Open(w_pisg090i)

END IF

end event

type pb_plan_actual_condition from picturebutton within w_pisg010b
integer x = 809
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

gi_page_index							= 3

pb_keycode.enabled					= FALSE
st_keycode.text						= ""
p_keycode.visible						= FALSE

p_message.visible						= FALSE

pb_actual_record_cancel.enabled	= FALSE
st_actual_record_cancel.text		= ""
p_actual_record_cancel.visible	= FALSE

/*######################################################################
#####		윈도우 체크																 #####
######################################################################*/

IF IsValid(w_pisg080i) THEN

	/*###################################################################
	#####		정보갱신																 #####
	###################################################################*/

	// 윈도우 최상위로
	w_pisg080i.BringToTop = TRUE

	// 갱신
	w_pisg080i.TriggerEvent("ue_line_select")

ELSE
	/*###################################################################
	#####		계획대비실적 Open													 #####
	###################################################################*/

	Open(w_pisg080i)
END IF

end event

type pb_actual_record from picturebutton within w_pisg010b
integer x = 407
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

gi_page_index							= 2

pb_keycode.enabled					= TRUE
st_keycode.text						= "자판"
p_keycode.visible						= TRUE

p_message.visible						= FALSE

pb_actual_record_cancel.enabled	= TRUE
st_actual_record_cancel.text		= "등록취소"
p_actual_record_cancel.visible	= TRUE

/*######################################################################
#####		윈도우 체크																 #####
######################################################################*/

IF IsValid(w_pisg030i) THEN

	// 실적등록화면 최상위로
	w_pisg030i.BringToTop = TRUE

	// 실적등록의 LINE선택 이벤트
	w_pisg030i.TriggerEvent("ue_line_select")

	// 간판번호 입력창의 초기화및 FOCUS
	w_pisg030i.em_kb_no.text = ''
	w_pisg030i.em_kb_no.SetFocus()
ELSE
	// 실적등록 Open
	Open(w_pisg030i)
END IF

end event

type p_exit from picture within w_pisg010b
integer x = 3351
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_close.gif"
boolean focusrectangle = false
end type

type pb_exit from picturebutton within w_pisg010b
event ue_system_end_chk ( )
integer x = 3223
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
end type

event ue_system_end_chk;INTEGER	li_system_flag
BOOLEAN lb_rtn

/*######################################################################
#####		시스템 종료 체크														 #####
######################################################################*/

// 시스템 FLAG
li_system_flag = INTEGER(ProfileString(gs_inifile, "Com_Info", "Exit_flag", "2"))


// 시스템 FLAG 체크
IF li_system_flag = 1 THEN

	// 시스템 종료
	messagebox('EXIT','SYSTEM EXIT')
//	lb_rtn = ExitWindowsEx(0,0)
END IF



end event

event clicked;STRING	ls_exit_flag
/*######################################################################
#####		시스템 종료 체크														 #####
######################################################################*/

// Exit_flag가 1:시스템종료, 2:프로그램종료
ls_exit_flag	= ProfileString(gs_inifile, "Com_Info", "Exit_flag", "2")

IF ls_exit_flag = '1' THEN

	Open(w_pisg012b)
ELSE
	IF gs_SerialFlag = "2" THEN
		// 통신 포트 CLOSE
		ole_comm.object.portopen	= FALSE
	END IF

	// 프로그램 종료
	Close(w_pisg010b)
END IF

end event

type pb_actual_record_cancel from picturebutton within w_pisg010b
integer x = 2821
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
string disabledname = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		실적등록취소 Open														 #####
######################################################################*/

Open(w_pisg070u)

end event

type pb_main from picturebutton within w_pisg010b
integer x = 5
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

gi_page_index							= 1

pb_keycode.enabled					= FALSE
st_keycode.text						= ''
p_keycode.visible						= FALSE

p_message.visible						= FALSE

pb_actual_record_cancel.enabled	= FALSE
st_actual_record_cancel.text		= ""
p_actual_record_cancel.visible	= FALSE

/*######################################################################
#####		단말기 정보 조회 Open												 #####
######################################################################*/

IF IsValid(w_pisg020i) THEN

	// 정보조회화면 최상위로
	w_pisg020i.BringToTop = TRUE
ELSE
	// 실적등록 Open
	Open(w_pisg020i)
END IF

end event

type pb_recovery from picturebutton within w_pisg010b
integer x = 2016
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

gi_page_index							= 6

pb_keycode.enabled					= FALSE
st_keycode.text						= ""
p_keycode.visible						= FALSE

p_message.visible						= FALSE

pb_actual_record_cancel.enabled	= FALSE
st_actual_record_cancel.text		= ""
p_actual_record_cancel.visible	= FALSE

/*######################################################################
#####		윈도우 체크																 #####
######################################################################*/

IF IsValid(w_pisg120i) THEN

	/*###################################################################
	#####		정보갱신																 #####
	###################################################################*/

	// 윈도우 최상위로
	w_pisg120i.BringToTop = TRUE

	// 갱신
	w_pisg120i.TriggerEvent("ue_info_renew")

ELSE
	/*###################################################################
	#####		계획대비실적 Open													 #####
	###################################################################*/

	Open(w_pisg120i)
END IF

end event

type dw_pisg010b_01 from datawindow within w_pisg010b
integer x = 1147
integer y = 480
integer width = 151
integer height = 108
string title = "none"
string dataobject = "d_pisg010b_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type p_keycode from picture within w_pisg010b
integer x = 2546
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_keyboard.gif"
boolean focusrectangle = false
end type

type p_message from picture within w_pisg010b
integer x = 2546
integer y = 2044
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_transport.gif"
boolean focusrectangle = false
end type

type pb_keycode from picturebutton within w_pisg010b
integer x = 2418
integer y = 1992
integer width = 398
integer height = 264
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
string picturename = "bmp\background.gif"
string disabledname = "bmp\background.gif"
end type

event clicked;STRING	ls_SendMsg
STRING	ls_LineName
STRING	ls_MsgInfo
STRING	ls_Time
STRING	ls_Message

INTEGER	li_loop_count
INTEGER	li_Send_count

BOOLEAN	lb_send_chk

/*######################################################################
#####		실적과 LOT분할 구분													 #####
######################################################################*/

CHOOSE CASE gi_page_index
	CASE 2
		Open(w_pisg040b)
	CASE 4
		Open(w_pisg100u)
	CASE 5
		// 메세지 체크 초기화
		lb_send_chk = FALSE

		// 메세지 구분
		ls_Message = w_pisg110b.st_select_msg.text

		// 메세지 전송지 갱신
		dw_tomessage.settransobject(sqlca)
		dw_tomessage.Retrieve(gs_area_code, gs_division_code, ls_Message)

		// 전송지 카운터
		li_Send_count	= dw_tomessage.rowcount()

		// 연결 생성
		myconnection = CREATE connection

		myconnection.application = "10099"
		myconnection.driver      = "winsock"

		// 각각의 연결지에 메세지 전송
		FOR li_loop_count = 1 TO li_Send_count

			// 컴퓨터 Addr
			myconnection.location	= TRIM(dw_tomessage.GetItemString(li_loop_count, "pcip"))

			// 연결
			myconnection.ConnectToServer()

			// 연결 체크
			IF myconnection.ErrCode = 0 THEN

				// 전송할 메세지
				ls_LineName		= w_pisg110b.st_linename.text
				ls_MsgInfo		= w_pisg110b.st_select_msg.text
				ls_Time			= STRING(NOW())

				// 메세지를 '//' 구분자로 합성
				ls_SendMsg	= ls_LineName + '//' +		&
									ls_MsgInfo + '//' +		&
									ls_Time

				// 메세지 전송
				myconnection.CreateInstance(in_proxy)
				in_proxy.of_ref_n_main_in_shared(ls_SendMsg)

				// 전송 성공
				lb_send_chk = TRUE

				// 연결 종료
				//myconnection.DisconnectServer()
			END IF
			myconnection.DisconnectServer()
		NEXT

		IF li_Send_count = 0 THEN
			// 전송할 PC가 없읍니다.
			OPEN(w_pisg111b)
		ELSE
			IF lb_send_chk = FALSE THEN
				// 전송 실패
				OPEN(w_pisg112b)
			ELSE
				// 전송 성공
				OPEN(w_pisg113b)
			END IF
		END IF
END CHOOSE

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
07w_pisg010b.bin 3076 1175588659
2000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000030000000000000000000000000000000000000000000000000000000079fdc92001c775c900000003000000800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000260000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004648a5600101b2c6e0000b682140000000000000079f90e3001c775c979fdc92001c775c9000000000000000000000000fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00430079007000690072006800670020007400630028002000290039003100340039000000200000001d000001310000003300000000001a4250000000001234432100000008000003ed000003ed648a560100060000000200000000040000000200000025800008000000000000000000000000003f00000001000001370000001d0000014e0000003300000000001c480000000000000000280000020000240338000004f40000015b0000001d000001720000003300000000001a68c0000000000000002800000200002403380000ffff000001720000001d000001720000001d00000000001b278800000000000000280000020000240338000004f6000001780000001d0000018f000000330000000000188b9800000000000000280000020000240338000004f80000018f0000001d000001a60000003300000000001a5718000000000000002800000200002403380000ffff000001a60000001d000001a60000001d00000000001aae98000000000000002800000200002403380000052c000001ac0000001d000001c300000033000000000019ba48000000000000002800000200002403380000052e000001c30000001d000001da0000003300000000001bc5d80000000000000028000002000024033800000530000001da0000001d000001f10000003300000000001bdc38000000000000002800000200006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000003c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17w_pisg010b.bin 3076 1175588659
End of PowerBuilder Binary Data Section : No Source Expected After This Point
