$PBExportHeader$w_rate_daily.srw
$PBExportComments$최근 일주일 가동율 조회화면
forward
global type w_rate_daily from window
end type
type pb_close from picturebutton within w_rate_daily
end type
type dw_1 from datawindow within w_rate_daily
end type
type st_1 from statictext within w_rate_daily
end type
end forward

global type w_rate_daily from window
integer width = 2738
integer height = 2596
boolean titlebar = true
string title = "일자별 가동율 (최근 1주일)"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 67108864
string icon = "Form!"
boolean center = true
pb_close pb_close
dw_1 dw_1
st_1 st_1
end type
global w_rate_daily w_rate_daily

forward prototypes
public subroutine wf_sum_current_rate ()
end prototypes

public subroutine wf_sum_current_rate ();// 금일 가동율 집계처리
// 
String	ls_DAY_START_TIME, ls_YMD, ls_errortext 
Long 		ll_errorcode


SetPointer(HourGlass!)

// 주간 SHIFT 시작시간을 조회 
// 
SELECT LEFT(REMARK,5)
  INTO :ls_DAY_START_TIME
  FROM TM_CODE
 WHERE MCD = '10'
  AND  SCD = '1';


// 주간시작 이전은 전일 날짜로 처리 
// 
If String(Now(), 'hh:mm') <= ls_DAY_START_TIME Then
	ls_YMD = String(RelativeDate(today(), -1), 'yyyymmdd')
Else
	ls_YMD = String(today(), 'yyyymmdd')
End if

// 가동율 집계처리 
// 
DECLARE SP_JOB_DATA_SUM PROCEDURE FOR SP_JOB_DATA_SUM
		@parm_YMD	= :ls_YMD,
		@parm_TYPE	= 'T';						
		
EXECUTE SP_JOB_DATA_SUM;
		
ll_errorcode = SQLCA.SQLCode
ls_errortext = SQLCA.SQLErrText

CLOSE SP_JOB_DATA_SUM;

SetPointer(Arrow!)
end subroutine

on w_rate_daily.create
this.pb_close=create pb_close
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.pb_close,&
this.dw_1,&
this.st_1}
end on

on w_rate_daily.destroy
destroy(this.pb_close)
destroy(this.dw_1)
destroy(this.st_1)
end on

event open;
// 현재시간까지의 금일 가동율 집계처리 
wf_sum_current_rate()

// 1주일간 일자별 가동율을 조회 
dw_1.SetTransObject(SQLCA)
dw_1.SetRedraw(False)
dw_1.Reset()
dw_1.Retrieve()
dw_1.SetRedraw(True)

end event

type pb_close from picturebutton within w_rate_daily
integer x = 5
integer y = 2320
integer width = 2715
integer height = 188
integer taborder = 20
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string pointer = "HyperLink!"
string text = "닫기"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 닫기 
Close(Parent) 
end event

type dw_1 from datawindow within w_rate_daily
integer x = 14
integer y = 20
integer width = 2688
integer height = 2288
integer taborder = 10
string title = "none"
string dataobject = "d_rate_daily"
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_rate_daily
integer y = 2308
integer width = 2734
integer height = 208
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 0
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

