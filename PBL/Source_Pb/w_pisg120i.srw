$PBExportHeader$w_pisg120i.srw
$PBExportComments$현장관리_현장라인 회수처리
forward
global type w_pisg120i from window
end type
type st_page_dn from statictext within w_pisg120i
end type
type st_row_dn from statictext within w_pisg120i
end type
type st_row_up from statictext within w_pisg120i
end type
type st_page_up from statictext within w_pisg120i
end type
type em_kb_no from editmask within w_pisg120i
end type
type p_4 from picture within w_pisg120i
end type
type p_3 from picture within w_pisg120i
end type
type p_2 from picture within w_pisg120i
end type
type p_1 from picture within w_pisg120i
end type
type dw_pisg120i_01 from datawindow within w_pisg120i
end type
type pb_page_up from picturebutton within w_pisg120i
end type
type pb_row_up from picturebutton within w_pisg120i
end type
type pb_row_dn from picturebutton within w_pisg120i
end type
type pb_page_dn from picturebutton within w_pisg120i
end type
type st_5 from statictext within w_pisg120i
end type
type dw_title from datawindow within w_pisg120i
end type
type st_1 from statictext within w_pisg120i
end type
type p_5 from picture within w_pisg120i
end type
type p_6 from picture within w_pisg120i
end type
type st_2 from statictext within w_pisg120i
end type
type dw_area_info from datawindow within w_pisg120i
end type
end forward

global type w_pisg120i from window
integer width = 3625
integer height = 1950
boolean border = false
windowtype windowtype = child!
long backcolor = 32241141
event ue_info_renew ( )
st_page_dn st_page_dn
st_row_dn st_row_dn
st_row_up st_row_up
st_page_up st_page_up
em_kb_no em_kb_no
p_4 p_4
p_3 p_3
p_2 p_2
p_1 p_1
dw_pisg120i_01 dw_pisg120i_01
pb_page_up pb_page_up
pb_row_up pb_row_up
pb_row_dn pb_row_dn
pb_page_dn pb_page_dn
st_5 st_5
dw_title dw_title
st_1 st_1
p_5 p_5
p_6 p_6
st_2 st_2
dw_area_info dw_area_info
end type
global w_pisg120i w_pisg120i

type variables
LONG		il_rowcount			// Rows 체크
LONG		il_ordercount		// 보여지는 지시순서

end variables

forward prototypes
public function integer wf_recovery_kbno ()
end prototypes

event ue_info_renew();STRING	ls_applydate_close		// 마감을 고려한 DATE
INTEGER	li_rowcount					// 하일라이트 COUNT

DATETIME	ldt_server_datetime		// SERVER DATETIME

/*######################################################################
#####		기준일																	 #####
######################################################################*/

ldt_server_datetime	= DATETIME(TODAY(),NOW())

ls_applydate_close	= f_pisc_get_date_applydate(gs_area_code,	&
									gs_division_code,ldt_server_datetime)

/*######################################################################
#####		회수간판 조회															 #####
######################################################################*/

dw_pisg120i_01.settransobject(sqlca)
dw_pisg120i_01.Retrieve(gs_area_code, gs_division_code, ls_applydate_close)

/*######################################################################
#####		하일라이트																 #####
######################################################################*/

/*
SELECT	COUNT(*)
  INTO	:li_rowcount
  FROM	TPLANRELEASE, TKB
 WHERE	TPLANRELEASE.AreaCode						= TKB.AreaCode
   AND	TPLANRELEASE.DivisionCode					= TKB.DivisionCode
   AND	TPLANRELEASE.KBNo								= TKB.KBNo
   AND	TPLANRELEASE.PrdFlag							= TKB.PrdFlag
   AND	TPLANRELEASE.AreaCode						= :gs_area_code
   AND	TPLANRELEASE.DivisionCode					= :gs_division_code
	AND	CONVERT(CHAR(10),TKB.KBBackTime,102)	= :ls_applydate_close
   AND	TPLANRELEASE.PrdFlag							= 'E'
   AND	TKB.StockGubun									= 'B'
   AND	TKB.KBStatusCode								= 'F' ;
*/

SELECT	COUNT(*)
  INTO	:li_rowcount
  FROM	TKB
 WHERE	AreaCode									= :gs_area_code
   AND	DivisionCode							= :gs_division_code
	AND	CONVERT(CHAR(10),KBBackTime,102)	= :ls_applydate_close
   AND	PrdFlag									= 'E'
   AND	TKB.StockGubun							= 'B'
   AND	TKB.KBStatusCode						= 'F' ;

IF li_rowcount < 1 THEN
	li_rowcount = 1
END IF

// 화면 스크롤
dw_pisg120i_01.ScrollToRow(li_rowcount)

// 하일라이트
IF dw_pisg120i_01.rowcount() > 0 THEN
	dw_pisg120i_01.SelectRow(0, FALSE)
	dw_pisg120i_01.SelectRow(li_rowcount, TRUE)
END IF

/*######################################################################
#####		간판번호 입력창에 FOCUS												 #####
######################################################################*/

em_kb_no.text	= ''
em_kb_no.setfocus()

end event

public function integer wf_recovery_kbno ();STRING	ls_kbno						// 간판 번호
STRING	ls_terminalcode			// 단말기 코드
INTEGER	li_error_code				// ERROR CODE

// 간판번호
ls_kbno				= TRIM(em_kb_no.text)

// 단말기 코드
ls_terminalcode	= ProfileString(gs_inifile, "Com_Info", "Comcode", "")

DECLARE recovery_kb procedure for sp_pisg120i_02
@ps_kbno				= :ls_kbno,
@ps_com_code		= :ls_terminalcode,
@pi_err_code		= :li_error_code	output
USING	SQLCA ;

EXECUTE recovery_kb ;

FETCH recovery_kb
	INTO :li_error_code ;
CLOSE	recovery_kb ;

return li_error_code

end function

on w_pisg120i.create
this.st_page_dn=create st_page_dn
this.st_row_dn=create st_row_dn
this.st_row_up=create st_row_up
this.st_page_up=create st_page_up
this.em_kb_no=create em_kb_no
this.p_4=create p_4
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.dw_pisg120i_01=create dw_pisg120i_01
this.pb_page_up=create pb_page_up
this.pb_row_up=create pb_row_up
this.pb_row_dn=create pb_row_dn
this.pb_page_dn=create pb_page_dn
this.st_5=create st_5
this.dw_title=create dw_title
this.st_1=create st_1
this.p_5=create p_5
this.p_6=create p_6
this.st_2=create st_2
this.dw_area_info=create dw_area_info
this.Control[]={this.st_page_dn,&
this.st_row_dn,&
this.st_row_up,&
this.st_page_up,&
this.em_kb_no,&
this.p_4,&
this.p_3,&
this.p_2,&
this.p_1,&
this.dw_pisg120i_01,&
this.pb_page_up,&
this.pb_row_up,&
this.pb_row_dn,&
this.pb_page_dn,&
this.st_5,&
this.dw_title,&
this.st_1,&
this.p_5,&
this.p_6,&
this.st_2,&
this.dw_area_info}
end on

on w_pisg120i.destroy
destroy(this.st_page_dn)
destroy(this.st_row_dn)
destroy(this.st_row_up)
destroy(this.st_page_up)
destroy(this.em_kb_no)
destroy(this.p_4)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.dw_pisg120i_01)
destroy(this.pb_page_up)
destroy(this.pb_row_up)
destroy(this.pb_row_dn)
destroy(this.pb_page_dn)
destroy(this.st_5)
destroy(this.dw_title)
destroy(this.st_1)
destroy(this.p_5)
destroy(this.p_6)
destroy(this.st_2)
destroy(this.dw_area_info)
end on

event open;/*######################################################################
#####		타이틀명 셋팅															 #####
######################################################################*/

dw_title.setitem(1, "title_name", "회수간판처리")

/*######################################################################
#####		지역, 공장 명 셋팅													 #####
######################################################################*/

dw_area_info.setitem(1, "area_name", gs_area_name)
dw_area_info.setitem(1, "workcenter_name", gs_division_name)

/*######################################################################
#####		정보 갱신																 #####
######################################################################*/

THIS.PostEvent("ue_info_renew")

/*######################################################################
#####		1분 마다 시간 업데이트												 #####
######################################################################*/

timer(60)
end event

event timer;IF gi_page_index = 6 THEN
	// 실적등록의 LINE선택 이벤트
	THIS.TriggerEvent("ue_info_renew")
END IF

end event

type st_page_dn from statictext within w_pisg120i
integer x = 3264
integer y = 1884
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

type st_row_dn from statictext within w_pisg120i
integer x = 3264
integer y = 1584
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

type st_row_up from statictext within w_pisg120i
integer x = 3264
integer y = 1012
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

type st_page_up from statictext within w_pisg120i
integer x = 3264
integer y = 712
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

type em_kb_no from editmask within w_pisg120i
event ue_keyup pbm_keydown
integer x = 1778
integer y = 288
integer width = 923
integer height = 144
integer taborder = 10
integer textsize = -22
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16776960
long backcolor = 0
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "aaaaaaaaaaa"
end type

event ue_keyup;STRING	ls_kbno
STRING	ls_max_plandate

INTEGER	li_count
INTEGER	li_error_code				// ERROR CODE

/*######################################################################
#####		간판번호입력 시														 #####
######################################################################*/

IF KEY	= KeyEnter! THEN

	// 간판번호
	ls_kbno					= TRIM(em_kb_no.text)

	// COUNT 체크

	SELECT	MAX(PlanDate)
	  INTO	:ls_max_plandate
	  FROM	TPLANRELEASE
	 WHERE	AreaCode			= :gs_area_code
		AND	DivisionCode	= :gs_division_code
		AND	KBNo				= :ls_kbno ;

	SELECT	COUNT(*)
	  INTO	:li_count
	  FROM	TPLANRELEASE, TKB
	 WHERE	TPLANRELEASE.AreaCode		= TKB.AreaCode
		AND	TPLANRELEASE.DivisionCode	= TKB.DivisionCode
		AND	TPLANRELEASE.KBNo				= TKB.KBNo
		AND	TPLANRELEASE.PrdFlag			= TKB.PrdFlag
		AND	TPLANRELEASE.PlanDate		= :ls_max_plandate
		AND	TPLANRELEASE.AreaCode		= :gs_area_code
		AND	TPLANRELEASE.DivisionCode	= :gs_division_code
		AND	TPLANRELEASE.KBNo				= :ls_kbno
		AND	TPLANRELEASE.PrdFlag			= 'E'
		AND	TKB.StockGubun					= 'B'
		AND	TKB.KBStatusCode				= 'C' ;

	IF li_count = 1 THEN

		// 해당간판 등록
		li_error_code = wf_recovery_kbno()

		IF li_error_code = 0 THEN
			// 갱신
			w_pisg120i.PostEvent("ue_info_renew")

			Open(w_pisg122i)
		END IF

		// 입력창 초기화
		THIS.text = ''
		THIS.SetFocus()
	ELSE
		// 해당간판 오류 표시
		Open(w_pisg121i)
	END IF
END IF

end event

type p_4 from picture within w_pisg120i
integer x = 3346
integer y = 1736
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pagedown.gif"
boolean focusrectangle = false
end type

type p_3 from picture within w_pisg120i
integer x = 3346
integer y = 1428
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowdown.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_pisg120i
integer x = 3346
integer y = 856
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_rowup.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_pisg120i
integer x = 3346
integer y = 564
integer width = 142
integer height = 128
boolean enabled = false
string picturename = "bmp\icon_pageup.gif"
boolean focusrectangle = false
end type

type dw_pisg120i_01 from datawindow within w_pisg120i
event ue_keydown pbm_keydown
event us_system_exit ( )
integer x = 14
integer y = 500
integer width = 3200
integer height = 1488
integer taborder = 20
string dataobject = "d_pisg120i_01"
boolean hscrollbar = true
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

type pb_page_up from picturebutton within w_pisg120i
integer x = 3223
integer y = 508
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
dw_pisg120i_01.ScrollPriorPage ()
dw_pisg120i_01.SetRow(dw_pisg120i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg120i_01.SelectRow(0, FALSE)
dw_pisg120i_01.SelectRow(dw_pisg120i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type pb_row_up from picturebutton within w_pisg120i
integer x = 3223
integer y = 808
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
dw_pisg120i_01.ScrollPriorRow()
dw_pisg120i_01.SetRow(dw_pisg120i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg120i_01.SelectRow(0, FALSE)
dw_pisg120i_01.SelectRow(dw_pisg120i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type pb_row_dn from picturebutton within w_pisg120i
integer x = 3223
integer y = 1380
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
dw_pisg120i_01.ScrollNextRow()
dw_pisg120i_01.SetRow(dw_pisg120i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg120i_01.SelectRow(0, FALSE)
dw_pisg120i_01.SelectRow(dw_pisg120i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type pb_page_dn from picturebutton within w_pisg120i
integer x = 3223
integer y = 1680
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
dw_pisg120i_01.ScrollNextPage()
dw_pisg120i_01.SetRow(dw_pisg120i_01.GETROW())

// 선택된 ROW 에 포커스를 준다.
dw_pisg120i_01.SelectRow(0, FALSE)
dw_pisg120i_01.SelectRow(dw_pisg120i_01.getrow(), TRUE)

/*######################################################################
#####		간판 입력부분에 FOCUS 이동											 #####
######################################################################*/

em_kb_no.SetFocus()

end event

type st_5 from statictext within w_pisg120i
integer x = 3214
integer y = 500
integer width = 402
integer height = 1488
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

type dw_title from datawindow within w_pisg120i
integer width = 3625
integer height = 200
integer taborder = 10
string dataobject = "d_title_bar"
boolean border = false
boolean livescroll = true
end type

event constructor;InsertRow(0)
end event

type st_1 from statictext within w_pisg120i
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

type p_5 from picture within w_pisg120i
integer x = 1207
integer y = 224
integer width = 59
integer height = 52
boolean originalsize = true
string picturename = "bmp\bullet.gif"
boolean focusrectangle = false
end type

type p_6 from picture within w_pisg120i
integer x = 1330
integer y = 348
integer width = 41
integer height = 36
string picturename = "bmp\bullet1.gif"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisg120i
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

type dw_area_info from datawindow within w_pisg120i
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

