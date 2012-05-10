$PBExportHeader$w_mpsg010b.srw
$PBExportComments$현장관리_메인화면
forward
global type w_mpsg010b from window
end type
type ole_comscanner from olecustomcontrol within w_mpsg010b
end type
type st_lotno_record from statictext within w_mpsg010b
end type
type p_lotno_record from picture within w_mpsg010b
end type
type pb_2 from picturebutton within w_mpsg010b
end type
type pb_1 from picturebutton within w_mpsg010b
end type
type st_exit from statictext within w_mpsg010b
end type
type st_actual_record_cancel from statictext within w_mpsg010b
end type
type st_keycode from statictext within w_mpsg010b
end type
type st_recovery from statictext within w_mpsg010b
end type
type st_plan_actual_condition from statictext within w_mpsg010b
end type
type st_actual_record from statictext within w_mpsg010b
end type
type st_main from statictext within w_mpsg010b
end type
type p_recovery from picture within w_mpsg010b
end type
type p_main from picture within w_mpsg010b
end type
type st_2 from statictext within w_mpsg010b
end type
type st_1 from statictext within w_mpsg010b
end type
type dw_tomessage from datawindow within w_mpsg010b
end type
type pb_send_message from picturebutton within w_mpsg010b
end type
type p_actual_record_cancel from picture within w_mpsg010b
end type
type p_plan_actual_condition from picture within w_mpsg010b
end type
type p_actual_record from picture within w_mpsg010b
end type
type pb_lotno_record from picturebutton within w_mpsg010b
end type
type pb_plan_actual_condition from picturebutton within w_mpsg010b
end type
type pb_actual_record from picturebutton within w_mpsg010b
end type
type p_exit from picture within w_mpsg010b
end type
type pb_exit from picturebutton within w_mpsg010b
end type
type pb_actual_record_cancel from picturebutton within w_mpsg010b
end type
type pb_main from picturebutton within w_mpsg010b
end type
type pb_recovery from picturebutton within w_mpsg010b
end type
type dw_mpsg010b_01 from datawindow within w_mpsg010b
end type
type p_keycode from picture within w_mpsg010b
end type
type p_message from picture within w_mpsg010b
end type
type pb_keycode from picturebutton within w_mpsg010b
end type
end forward

shared variables

end variables

global type w_mpsg010b from window
integer width = 4681
integer height = 3072
boolean titlebar = true
string title = "금형생산 현장관리"
long backcolor = 79219928
toolbaralignment toolbaralignment = alignatbottom!
boolean clientedge = true
event ue_line_select ( )
ole_comscanner ole_comscanner
st_lotno_record st_lotno_record
p_lotno_record p_lotno_record
pb_2 pb_2
pb_1 pb_1
st_exit st_exit
st_actual_record_cancel st_actual_record_cancel
st_keycode st_keycode
st_recovery st_recovery
st_plan_actual_condition st_plan_actual_condition
st_actual_record st_actual_record
st_main st_main
p_recovery p_recovery
p_main p_main
st_2 st_2
st_1 st_1
dw_tomessage dw_tomessage
pb_send_message pb_send_message
p_actual_record_cancel p_actual_record_cancel
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
dw_mpsg010b_01 dw_mpsg010b_01
p_keycode p_keycode
p_message p_message
pb_keycode pb_keycode
end type
global w_mpsg010b w_mpsg010b

type prototypes

end prototypes

type variables
connection myconnection

end variables

on w_mpsg010b.create
this.ole_comscanner=create ole_comscanner
this.st_lotno_record=create st_lotno_record
this.p_lotno_record=create p_lotno_record
this.pb_2=create pb_2
this.pb_1=create pb_1
this.st_exit=create st_exit
this.st_actual_record_cancel=create st_actual_record_cancel
this.st_keycode=create st_keycode
this.st_recovery=create st_recovery
this.st_plan_actual_condition=create st_plan_actual_condition
this.st_actual_record=create st_actual_record
this.st_main=create st_main
this.p_recovery=create p_recovery
this.p_main=create p_main
this.st_2=create st_2
this.st_1=create st_1
this.dw_tomessage=create dw_tomessage
this.pb_send_message=create pb_send_message
this.p_actual_record_cancel=create p_actual_record_cancel
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
this.dw_mpsg010b_01=create dw_mpsg010b_01
this.p_keycode=create p_keycode
this.p_message=create p_message
this.pb_keycode=create pb_keycode
this.Control[]={this.ole_comscanner,&
this.st_lotno_record,&
this.p_lotno_record,&
this.pb_2,&
this.pb_1,&
this.st_exit,&
this.st_actual_record_cancel,&
this.st_keycode,&
this.st_recovery,&
this.st_plan_actual_condition,&
this.st_actual_record,&
this.st_main,&
this.p_recovery,&
this.p_main,&
this.st_2,&
this.st_1,&
this.dw_tomessage,&
this.pb_send_message,&
this.p_actual_record_cancel,&
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
this.dw_mpsg010b_01,&
this.p_keycode,&
this.p_message,&
this.pb_keycode}
end on

on w_mpsg010b.destroy
destroy(this.ole_comscanner)
destroy(this.st_lotno_record)
destroy(this.p_lotno_record)
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.st_exit)
destroy(this.st_actual_record_cancel)
destroy(this.st_keycode)
destroy(this.st_recovery)
destroy(this.st_plan_actual_condition)
destroy(this.st_actual_record)
destroy(this.st_main)
destroy(this.p_recovery)
destroy(this.p_main)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_tomessage)
destroy(this.pb_send_message)
destroy(this.p_actual_record_cancel)
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
destroy(this.dw_mpsg010b_01)
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

//messagebox("chk",string(PixelsToUnits (1024, XPixelsToUnits!  )))
//messagebox("chk1",string(PixelsToUnits (768, YPixelsToUnits!  )))
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

pb_recovery.enabled	= FALSE
st_recovery.text		= ""
p_recovery.visible	= FALSE

/*######################################################################
#####		지역,공장,단말기명 													 #####
######################################################################*/

ls_terminalcode	= TRIM(ProfileString(gs_inifile, "Com_Info", "Comcode", ""))

// 지역 CODE
//SELECT	AreaCode, DivisionCode
//  INTO	:gs_area_code, :gs_division_code
//  FROM	TMSTTERMINAL
// WHERE	TerminalCode	= :ls_terminalcode ;

/*######################################################################
#####		지역명, 공장명															 #####
######################################################################*/

//// 지역명
//SELECT	AreaName
//  INTO	:gs_area_name
//  FROM	TMSTAREA
// WHERE	AreaCode			= :gs_area_code ;
//
//// 공장명
//SELECT	DivisionName
//  INTO	:gs_division_name
//  FROM	TMSTDIVISION
// WHERE	AreaCode			= :gs_area_code
//   AND	DivisionCode	= :gs_division_code ;

SELECT	aa.wgcode,
	bb.wgname
INTO :gs_area_name, :gs_division_name
  FROM	tterminalworkgroup aa INNER JOIN tworkgroup bb
    ON aa.wgcode = bb.wgcode
 WHERE	aa.trmcode	= :ls_terminalcode ;

/*######################################################################
#####		단말기명으로 조와 라인정보를 가져옴								 #####
######################################################################*/

// 조와 라인코드
dw_mpsg010b_01.settransobject(sqlca)
dw_mpsg010b_01.Retrieve(ls_terminalcode)

// 단말기에 물려있는 라인수 
gi_tot_tab_count = dw_mpsg010b_01.rowcount()

// 해당 정보가 없는 경우 프로그램 종료
IF gi_tot_tab_count	<	1	THEN 

	// 종료 정보
	Open(w_mpsg011b)

	// 종료
	CLOSE(this)
//	pb_exit.TriggerEvent(Clicked!)
END IF

// 각 라인의 정보
FOR li_loop_count = 1 TO gi_tot_tab_count
	gs_workcenter_code[li_loop_count]	=	&
		dw_mpsg010b_01.GetItemString(li_loop_count, "as_workcenter")
	gs_line_code[li_loop_count]			= &
		dw_mpsg010b_01.GetItemString(li_loop_count, "as_linecode")
	
	// 조 명
	SELECT	LTRIM(RTRIM(WgName))
	  INTO	:gs_workcenter_name[li_loop_count]
	  FROM	TWORKGROUP
	 WHERE	WgCode		= :gs_workcenter_code[li_loop_count] ;

	IF gs_workcenter_name[li_loop_count] <> '' THEN
		gs_workcenter_name[li_loop_count] = gs_workcenter_name[li_loop_count] &
			+ "(" + gs_line_code[li_loop_count] + ")"
	END IF
	// 라인명및 조회 수량
	SELECT	DisplayCount,
				LTRIM(RTRIM(WcName))
	  INTO	:gi_show_count[li_loop_count], 
	  			:gs_line_name[li_loop_count]
	  FROM	TWORKCENTER
	 WHERE	WgCode		= :gs_workcenter_code[li_loop_count]
		AND	WcCode		= :gs_line_code[li_loop_count] ;
	
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
//gs_SerialFlag		= ProfileString(gs_inifile, "Com_Info", "SerialFlag", "1")

// '2' --> 씨리얼 통신
//IF gs_SerialFlag = "2" THEN
//	// 통신 포트 OPEN
//	ole_comm.object.portopen	= True
//END IF

/*######################################################################
#####		1분마다 시간 업데이트												 #####
######################################################################*/

timer(60)

/*######################################################################
#####		단말기 정보 조회 Open												 #####
######################################################################*/

Open(w_mpsg020i)

end event

event timer;/*######################################################################
#####		7:59에 프로그램 DownLoad											#####
######################################################################*/

IF String(Now(), "hh:mm") = "07:59" THEN
	// DownLoad
	String ls_Restart_Exe
	SQLPIS = CREATE TRANSACTION
	SQLPIS.DBMS			= ProfileString(gs_inifile, "ELE", "DBMS", "")
	SQLPIS.Database		= ProfileString(gs_inifile, "ELE", "DataBase", "")
	SQLPIS.ServerName	= ProfileString(gs_inifile, "ELE", "ServerName", "")
	SQLPIS.LogId			= ProfileString(gs_inifile, "ELE", "LogId", "")
	SQLPIS.LogPass		= ProfileString(gs_inifile, "ELE", "LogPass", "")
	SQLPIS.AutoCommit	= TRUE
	
	connect Using sqlpis;
	If SQLPIS.SQLCode <> 0 Then
		disconnect Using sqlpis;
		Open(w_mpsg001b)
		Halt
	END IF
	
	If f_download_count() > 0 Then
		Close(This)
		ls_Restart_Exe = 'mpms_down.exe'
		If Run(ls_Restart_Exe) <> 1 Then
			Beep(1)
			If FileExists(ls_Restart_Exe) = FALSE Then
				MessageBox("Help", ls_Restart_Exe + " can not be found!")
			End if
		End If
	End If
	disconnect Using sqlpis;
END IF

/*######################################################################
#####		서버의 시간과 동기화													 #####
######################################################################*/

f_system_time()

end event

event activate;If ole_ComScanner.object.PortOpen = True Then
	ole_ComScanner.object.PortOpen = False
End If

ole_ComScanner.object.CommPort = 1
ole_ComScanner.object.Settings = "9600,n,8,1"
ole_ComScanner.object.RThreshold = 1
ole_ComScanner.object.PortOpen = True
end event
type ole_comscanner from olecustomcontrol within w_mpsg010b
event oncomm ( )
integer x = 759
integer y = 416
integer width = 174
integer height = 152
integer taborder = 10
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_mpsg010b.win"
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
end type

event oncomm();string barcode
GraphicObject which_control

sleep(0.5)
barcode = ole_comscanner.object.input

Choose case gi_page_index
	case 3
		// 실적조회
		//w_mpsg090i.TriggerEvent("ue_line_select")
	case 4
		// 작업일보
		//w_mpsg080i.TriggerEvent("ue_line_select")
	case else
		// 간판 입력창에 Focus	
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
		
		which_control = GetFocus()
		IF TypeOf(which_control) = EditMask! THEN
			w_mpsg030i.em_kb_no.text = barcode
			IF w_mpsg030i.wf_transaction_select() THEN
				// 해당간판 등록
				Open(w_mpsg050u)
			ELSE
				// 해당간판 오류 표시
				OpenWithParm(w_mpsg013b,"작업장을 확인하십시요")
		
				// 갱신
				w_mpsg030i.em_kb_no.text = ''
				w_mpsg030i.em_kb_no.SetFocus()
			END IF
		END IF
end choose
end event

type st_lotno_record from statictext within w_mpsg010b
integer x = 2066
integer y = 2788
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
string text = "작업일보"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_lotno_record from picture within w_mpsg010b
integer x = 2158
integer y = 2664
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_lotdivision.gif"
boolean focusrectangle = false
end type

type pb_2 from picturebutton within w_mpsg010b
integer x = 3227
integer y = 2608
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

type pb_1 from picturebutton within w_mpsg010b
integer x = 3630
integer y = 2608
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

type st_exit from statictext within w_mpsg010b
integer x = 4082
integer y = 2784
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

type st_actual_record_cancel from statictext within w_mpsg010b
integer x = 1262
integer y = 2788
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

type st_keycode from statictext within w_mpsg010b
integer x = 2464
integer y = 2788
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

type st_recovery from statictext within w_mpsg010b
integer x = 855
integer y = 2788
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

type st_plan_actual_condition from statictext within w_mpsg010b
integer x = 1664
integer y = 2788
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

type st_actual_record from statictext within w_mpsg010b
integer x = 453
integer y = 2784
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

type st_main from statictext within w_mpsg010b
integer x = 46
integer y = 2784
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

type p_recovery from picture within w_mpsg010b
integer x = 937
integer y = 2664
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_recovery.gif"
boolean focusrectangle = false
end type

type p_main from picture within w_mpsg010b
integer x = 128
integer y = 2660
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_main.gif"
boolean focusrectangle = false
end type

type st_2 from statictext within w_mpsg010b
integer x = 2418
integer y = 2884
integer width = 2021
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

type st_1 from statictext within w_mpsg010b
integer x = 5
integer y = 2884
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

type dw_tomessage from datawindow within w_mpsg010b
integer x = 1600
integer y = 476
integer width = 137
integer height = 108
integer taborder = 10
string dataobject = "d_pisg110b_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_send_message from picturebutton within w_mpsg010b
integer x = 2830
integer y = 2608
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
string disabledname = "bmp\background.gif"
end type

type p_actual_record_cancel from picture within w_mpsg010b
integer x = 1344
integer y = 2664
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_RegCancel.gif"
boolean focusrectangle = false
end type

type p_plan_actual_condition from picture within w_mpsg010b
integer x = 1755
integer y = 2664
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_ResultsInquiry.gif"
boolean focusrectangle = false
end type

type p_actual_record from picture within w_mpsg010b
integer x = 544
integer y = 2660
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_ResultsRegistration.gif"
boolean focusrectangle = false
end type

type pb_lotno_record from picturebutton within w_mpsg010b
integer x = 2025
integer y = 2608
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
string disabledname = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

gi_page_index							= 4

pb_keycode.enabled					= FALSE
st_keycode.text						= ""
p_keycode.visible						= FALSE

p_message.visible						= FALSE

pb_actual_record_cancel.enabled	= TRUE
st_actual_record_cancel.text		= "등록취소"
p_actual_record_cancel.visible	= TRUE

pb_recovery.enabled	= TRUE
st_recovery.text		= "등록수정"
p_recovery.visible	= TRUE

/*######################################################################
#####		윈도우 체크																 #####
######################################################################*/

IF IsValid(w_mpsg080i) THEN

	/*###################################################################
	#####		정보갱신																 #####
	###################################################################*/

	// 윈도우 최상위로
	w_mpsg080i.BringToTop = TRUE

	// 갱신
	w_mpsg080i.TriggerEvent("ue_line_select")

ELSE
	/*###################################################################
	#####		계획대비실적 Open													 #####
	###################################################################*/

	Open(w_mpsg080i)
END IF
end event

type pb_plan_actual_condition from picturebutton within w_mpsg010b
integer x = 1618
integer y = 2608
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
string disabledname = "bmp\background.gif"
end type

event clicked;/*######################################################################
#####		버튼 셋팅																 #####
######################################################################*/

gi_page_index							= 3

pb_keycode.enabled					= FALSE
st_keycode.text						= ""
p_keycode.visible						= FALSE

p_message.visible						= FALSE

pb_actual_record_cancel.enabled	= TRUE
st_actual_record_cancel.text		= "등록취소"
p_actual_record_cancel.visible	= TRUE

pb_recovery.enabled	= TRUE
st_recovery.text		= "등록수정"
p_recovery.visible	= TRUE

/*######################################################################
#####		윈도우 체크																 #####
######################################################################*/

IF IsValid(w_mpsg090i) THEN

	/*###################################################################
	#####		정보갱신																 #####
	###################################################################*/

	// 윈도우 최상위로
	w_mpsg090i.BringToTop = TRUE

	// 갱신
	w_mpsg090i.TriggerEvent("ue_line_select")

ELSE
	/*###################################################################
	#####		계획대비실적 Open													 #####
	###################################################################*/

	Open(w_mpsg090i)
END IF

end event

type pb_actual_record from picturebutton within w_mpsg010b
integer x = 407
integer y = 2608
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

pb_recovery.enabled	= TRUE
st_recovery.text		= "등록수정"
p_recovery.visible	= TRUE

/*######################################################################
#####		윈도우 체크																 #####
######################################################################*/

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

end event

type p_exit from picture within w_mpsg010b
integer x = 4165
integer y = 2660
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_close.gif"
boolean focusrectangle = false
end type

type pb_exit from picturebutton within w_mpsg010b
event ue_system_end_chk ( )
integer x = 4037
integer y = 2608
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

event clicked;STRING	ls_exit_flag, ls_Restart_Exe
/*######################################################################
#####		시스템 종료 체크														 #####
######################################################################*/

// Exit_flag가 1:시스템종료, 2:프로그램종료
ls_exit_flag	= ProfileString(gs_inifile, "Com_Info", "Exit_flag", "2")

IF ls_exit_flag = '1' THEN

	Open(w_mpsg012b)
ELSE
	// 프로그램 종료
	Close(w_mpsg010b)
END IF

end event

type pb_actual_record_cancel from picturebutton within w_mpsg010b
integer x = 1216
integer y = 2608
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

event clicked;String ls_stype, ls_srno, ls_resultflag
Long ll_selrow

Choose case gi_page_index
	case 2
		ll_selrow = w_mpsg030i.dw_mpsg030i_01.getselectedrow(0)
		if ll_selrow < 1 then
			return -1
		else
			ls_stype = w_mpsg030i.dw_mpsg030i_01.getitemstring(ll_selrow,"as_stype")
			ls_srno = w_mpsg030i.dw_mpsg030i_01.getitemstring(ll_selrow,"as_srno")
			ls_resultflag = w_mpsg030i.dw_mpsg030i_01.getitemstring(ll_selrow,"as_resultflag")
		end if
	case 3
		ll_selrow = w_mpsg090i.dw_mpsg090i_01.getselectedrow(0)
		if ll_selrow < 1 then
			return -1
		else
			ls_stype = w_mpsg090i.dw_mpsg090i_01.getitemstring(ll_selrow,"as_stype")
			ls_srno = w_mpsg090i.dw_mpsg090i_01.getitemstring(ll_selrow,"as_srno")
			ls_resultflag = w_mpsg090i.dw_mpsg090i_01.getitemstring(ll_selrow,"as_resultflag")
		end if
	case 4
		ll_selrow = w_mpsg080i.dw_mpsg080i_01.getselectedrow(0)
		if ll_selrow < 1 then
			return -1
		else
			ls_stype = w_mpsg080i.dw_mpsg080i_01.getitemstring(ll_selrow,"stype")
			ls_srno = w_mpsg080i.dw_mpsg080i_01.getitemstring(ll_selrow,"srno")
			ls_resultflag = w_mpsg080i.dw_mpsg080i_01.getitemstring(ll_selrow,"resultflag")
		end if
	case else
		ls_resultflag = ''
end choose

if f_mpsg_spacechk(ls_resultflag) = -1 then
	/*######################################################################
	#####		윈도우 체크																 #####
	######################################################################*/
	
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
	RETURN -1
end if

///*######################################################################
//#####		윈도우 체크																 #####
//######################################################################*/
//
IF IsValid(w_mpsg070u) THEN

	/*###################################################################
	#####		정보갱신																 #####
	###################################################################*/

	// 윈도우 최상위로
	w_mpsg070u.BringToTop = TRUE

//	// 갱신
//	w_mpsg120i.TriggerEvent("ue_info_renew")
//
ELSE
	/*###################################################################
	#####		실적삭제 Open													 #####
	###################################################################*/

	Openwithparm(w_mpsg070u, ls_stype + ls_srno)
END IF

end event

type pb_main from picturebutton within w_mpsg010b
integer y = 2608
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

pb_recovery.enabled	= FALSE
st_recovery.text		= ""
p_recovery.visible	= FALSE
/*######################################################################
#####		단말기 정보 조회 Open												 #####
######################################################################*/

IF IsValid(w_mpsg020i) THEN

	// 정보조회화면 최상위로
	w_mpsg020i.BringToTop = TRUE
ELSE
	// 실적등록 Open
	Open(w_mpsg020i)
END IF

end event

type pb_recovery from picturebutton within w_mpsg010b
integer x = 809
integer y = 2608
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
string disabledname = "bmp\background.gif"
end type

event clicked;String ls_stype, ls_srno, ls_resultflag
Long ll_selrow

Choose case gi_page_index
	case 2
		ll_selrow = w_mpsg030i.dw_mpsg030i_01.getselectedrow(0)
		if ll_selrow < 1 then
			return -1
		else
			ls_stype = w_mpsg030i.dw_mpsg030i_01.getitemstring(ll_selrow,"as_stype")
			ls_srno = w_mpsg030i.dw_mpsg030i_01.getitemstring(ll_selrow,"as_srno")
			ls_resultflag = w_mpsg030i.dw_mpsg030i_01.getitemstring(ll_selrow,"as_resultflag")
		end if
	case 3
		ll_selrow = w_mpsg090i.dw_mpsg090i_01.getselectedrow(0)
		if ll_selrow < 1 then
			return -1
		else
			ls_stype = w_mpsg090i.dw_mpsg090i_01.getitemstring(ll_selrow,"as_stype")
			ls_srno = w_mpsg090i.dw_mpsg090i_01.getitemstring(ll_selrow,"as_srno")
			ls_resultflag = w_mpsg090i.dw_mpsg090i_01.getitemstring(ll_selrow,"as_resultflag")
		end if
	case 4
		ll_selrow = w_mpsg080i.dw_mpsg080i_01.getselectedrow(0)
		if ll_selrow < 1 then
			return -1
		else
			ls_stype = w_mpsg080i.dw_mpsg080i_01.getitemstring(ll_selrow,"stype")
			ls_srno = w_mpsg080i.dw_mpsg080i_01.getitemstring(ll_selrow,"srno")
			ls_resultflag = w_mpsg080i.dw_mpsg080i_01.getitemstring(ll_selrow,"resultflag")
		end if
	case else
		ls_resultflag = ''
end choose

if f_mpsg_spacechk(ls_resultflag) = -1 then
	/*######################################################################
	#####		윈도우 체크																 #####
	######################################################################*/
	
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
	RETURN -1
end if
///*######################################################################
//#####		버튼 셋팅																 #####
//######################################################################*/
//
//gi_page_index							= 6
//
//pb_keycode.enabled					= FALSE
//st_keycode.text						= ""
//p_keycode.visible						= FALSE
//
//p_message.visible						= FALSE
//
//pb_actual_record_cancel.enabled	= FALSE
//st_actual_record_cancel.text		= ""
//p_actual_record_cancel.visible	= FALSE
//

/*###################################################################
#####		실적수정 Open													 #####
###################################################################*/

Openwithparm(w_mpsg060u, ls_stype + ls_srno)

end event

type dw_mpsg010b_01 from datawindow within w_mpsg010b
integer x = 1147
integer y = 480
integer width = 151
integer height = 108
string title = "none"
string dataobject = "d_mpsg010b_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type p_keycode from picture within w_mpsg010b
integer x = 2546
integer y = 2664
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_keyboard.gif"
boolean focusrectangle = false
end type

type p_message from picture within w_mpsg010b
integer x = 2546
integer y = 2664
integer width = 142
integer height = 108
boolean enabled = false
string picturename = "bmp\icon_transport.gif"
boolean focusrectangle = false
end type

type pb_keycode from picturebutton within w_mpsg010b
integer x = 2427
integer y = 2608
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

event clicked;Open(w_mpsg040b)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
07w_mpsg010b.bin 3076 1164590501
2000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000649ee11001c711c200000003000000800000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000260000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe0000000000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004648a5600101b2c6e0000b6821400000000000000649ee11001c711c2649ee11001c711c2000000000000000000000000fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00430079007000690072006800670020007400630028002000290039003100340039000000200000000000000000000000000000000000000000000000001234432100000008000003ed000003ed648a560100060000000100000000040000000200000025800008000000000000000000000000003f0000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000003c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17w_mpsg010b.bin 3076 1164590501
End of PowerBuilder Binary Data Section : No Source Expected After This Point
