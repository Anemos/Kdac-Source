$PBExportHeader$w_rate_daily.srw
$PBExportComments$�ֱ� ������ ������ ��ȸȭ��
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
string title = "���ں� ������ (�ֱ� 1����)"
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

public subroutine wf_sum_current_rate ();// ���� ������ ����ó��
// 
String	ls_DAY_START_TIME, ls_YMD, ls_errortext 
Long 		ll_errorcode


SetPointer(HourGlass!)

// �ְ� SHIFT ���۽ð��� ��ȸ 
// 
SELECT LEFT(REMARK,5)
  INTO :ls_DAY_START_TIME
  FROM TM_CODE
 WHERE MCD = '10'
  AND  SCD = '1';


// �ְ����� ������ ���� ��¥�� ó�� 
// 
If String(Now(), 'hh:mm') <= ls_DAY_START_TIME Then
	ls_YMD = String(RelativeDate(today(), -1), 'yyyymmdd')
Else
	ls_YMD = String(today(), 'yyyymmdd')
End if

// ������ ����ó�� 
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
// ����ð������� ���� ������ ����ó�� 
wf_sum_current_rate()

// 1���ϰ� ���ں� �������� ��ȸ 
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
string facename = "����"
string pointer = "HyperLink!"
string text = "�ݱ�"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// �ݱ� 
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
string facename = "����"
long textcolor = 33554432
long backcolor = 0
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

