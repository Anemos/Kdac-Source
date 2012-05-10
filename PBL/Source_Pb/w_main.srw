$PBExportHeader$w_main.srw
$PBExportComments$������ ����ȭ��
forward
global type w_main from window
end type
type st_4 from statictext within w_main
end type
type st_1 from statictext within w_main
end type
type st_10 from statictext within w_main
end type
type st_input_man from statictext within w_main
end type
type st_title_06 from statictext within w_main
end type
type st_2 from statictext within w_main
end type
type pb_close from picturebutton within w_main
end type
type pb_prev from picturebutton within w_main
end type
type st_rate_prev from statictext within w_main
end type
type st_rate_now from statictext within w_main
end type
type st_qty_prod from statictext within w_main
end type
type st_qty_plan from statictext within w_main
end type
type pb_menu from picturebutton within w_main
end type
type st_title_05 from statictext within w_main
end type
type st_title_04 from statictext within w_main
end type
type st_mng_no from statictext within w_main
end type
type st_ymd_time from statictext within w_main
end type
type st_3 from statictext within w_main
end type
type st_5 from statictext within w_main
end type
type p_1 from picture within w_main
end type
type st_refresh from statictext within w_main
end type
type st_title_02 from statictext within w_main
end type
type st_title_03 from statictext within w_main
end type
type st_model from statictext within w_main
end type
end forward

global type w_main from window
integer width = 4800
integer height = 3220
boolean titlebar = true
string title = "���������ð�-v2.0"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 15793151
string icon = "Form!"
boolean center = true
st_4 st_4
st_1 st_1
st_10 st_10
st_input_man st_input_man
st_title_06 st_title_06
st_2 st_2
pb_close pb_close
pb_prev pb_prev
st_rate_prev st_rate_prev
st_rate_now st_rate_now
st_qty_prod st_qty_prod
st_qty_plan st_qty_plan
pb_menu pb_menu
st_title_05 st_title_05
st_title_04 st_title_04
st_mng_no st_mng_no
st_ymd_time st_ymd_time
st_3 st_3
st_5 st_5
p_1 p_1
st_refresh st_refresh
st_title_02 st_title_02
st_title_03 st_title_03
st_model st_model
end type
global w_main w_main

forward prototypes
public subroutine wf_main_display ()
public subroutine wf_main_execute ()
public subroutine wf_get_config ()
end prototypes

public subroutine wf_main_display ();//-------------------------------------------------------------------------------
// ����ȭ�� �ڷḦ ��ȸ�Ѵ�.
//		Timer�� ���� Cycle Time �������� ��ȸ�Ѵ�. 
//						(���� ������ ������ ���� Cycle Time)
//-------------------------------------------------------------------------------

String 	ls_MODEL_CODE, ls_MODEL_NAME
Long		li_PLAN_QTY, li_PROD_QTY, li_INPUT_MAN, li_CYCLE_TIME
Double	li_WORK_RATE, li_BOF_RATE, li_TARGET_RATE

// ����ð� ���� ������ ������ ��ȸ
// 
DECLARE SP_GET_MAIN_DATA PROCEDURE FOR SP_GET_MAIN_DATA;
EXECUTE SP_GET_MAIN_DATA;
FETCH SP_GET_MAIN_DATA INTO :ls_MODEL_CODE, :ls_MODEL_NAME, :li_PLAN_QTY, :li_PROD_QTY, &
									 :li_WORK_RATE, :li_BOF_RATE, :li_TARGET_RATE, &
									 :li_INPUT_MAN, :li_CYCLE_TIME;
CLOSE SP_GET_MAIN_DATA ;

If (gs_ETC = 'Y') Then
	st_model.Text 		= gs_ETC_DATA										// ��ȹ����  
Else
	st_model.Text 		= ls_MODEL_NAME									// �𵨸� 
End If
st_qty_plan.Text 		= string(li_PLAN_QTY, '#,##0')				// ��ȹ���� 
st_qty_prod.Text 		= string(li_PROD_QTY, '#,##0')				// ��������
st_rate_now.Text 		= string(li_WORK_RATE, '##.0') 				// ���� ������
st_rate_prev.Text 	= string(li_BOF_RATE)  + ' %'					// ���� ������ 
st_input_man.Text 	= string(li_INPUT_MAN) + ' ��'				// �����ο� 
gs_model_code			= ls_MODEL_CODE									// �𵨸�

//*********************
//* �𵨺� ����ŬŸ���� Reflesh Time�� �ּ�ó����. 2011.12.20
//gi_CycleTime			= li_CYCLE_TIME + gi_CYCLE_OFFSET			// CYCLE TIME (���� ������ ������ ��)
//																					// 	DB ó���� DELAY TIME�� �߻��ϸ� OFFSET ���� -1, -2, ..�� ��� 
//
//// ������ �Ѱ��� ������ �⺻ 10�ʷ� ���� 
//If (li_CYCLE_TIME = 0) Then
//	gi_CycleTime = 10
//End If
//********************

// Reflesh Time�� 10�ʷ� ����, Offset �� ������
gi_CycleTime = 10 + gi_CYCLE_OFFSET

// �������� ��ǥ������ �ʰ��� �Ķ������� 
//							  �̴޽� ���������� 
// 
If li_WORK_RATE >= li_TARGET_RATE Then
		st_rate_now.TextColor = RGB(0,0,255)	// Blue
Else
		st_rate_now.TextColor = RGB(255,0,0)	// Red
End If




 


end subroutine

public subroutine wf_main_execute ();//-------------------------------------------------------------------------------
// Interface�� �ڷḦ ���� ó���Ѵ�.
//		Timer�� ���� Cycle Time �������� ��ȸ�Ѵ�. 
//						(���� ������ ������ ���� Cycle Time)
//-------------------------------------------------------------------------------

DECLARE SP_JOB_DATA_PROCESS PROCEDURE FOR SP_JOB_DATA_PROCESS;
EXECUTE SP_JOB_DATA_PROCESS;
CLOSE SP_JOB_DATA_PROCESS;




		

 


end subroutine

public subroutine wf_get_config ();//-------------------------------------------------------------------------------
// ȯ�漳�� �ڷḦ ��ȸ�Ѵ�.
//-------------------------------------------------------------------------------


// CYCLE OFFSET VALUE
//		DB ó���� ���Ϸ� ���� �ð����� CYCLE�� �þ�� ��쿡
//		-1, -2, ...�� �ð�(�ʴ���)�� �ٿ��ش�.
//
SELECT convert(int, isnull(CDNAME,'0'))
  INTO :gi_CYCLE_OFFSET
  FROM TM_CODE
 WHERE MCD	= '90'
   AND SCD	= '02';
	
// ���� Ư�̻��� DATA
SELECT isnull(CDNAME,'')
  INTO :gs_ETC_TEXT 
  FROM TM_CODE
 WHERE MCD	= '90'
   AND SCD	= '05';
	
// ���� Ư�̻��� ��뿩��
SELECT isnull(CDNAME,'')
  INTO :gs_ETC
  FROM TM_CODE
 WHERE MCD	= '90'
   AND SCD	= '03';
	
// ���� Ư�̻��� DATA
SELECT isnull(CDNAME,'')
  INTO :gs_ETC_DATA 
  FROM TM_CODE
 WHERE MCD	= '90'
   AND SCD	= '04';
	
If IsNumber(gs_ETC_DATA) Then
	gs_ETC_DATA = String(Long(gs_ETC_DATA), "0,000")
End If


	

	
end subroutine

on w_main.create
this.st_4=create st_4
this.st_1=create st_1
this.st_10=create st_10
this.st_input_man=create st_input_man
this.st_title_06=create st_title_06
this.st_2=create st_2
this.pb_close=create pb_close
this.pb_prev=create pb_prev
this.st_rate_prev=create st_rate_prev
this.st_rate_now=create st_rate_now
this.st_qty_prod=create st_qty_prod
this.st_qty_plan=create st_qty_plan
this.pb_menu=create pb_menu
this.st_title_05=create st_title_05
this.st_title_04=create st_title_04
this.st_mng_no=create st_mng_no
this.st_ymd_time=create st_ymd_time
this.st_3=create st_3
this.st_5=create st_5
this.p_1=create p_1
this.st_refresh=create st_refresh
this.st_title_02=create st_title_02
this.st_title_03=create st_title_03
this.st_model=create st_model
this.Control[]={this.st_4,&
this.st_1,&
this.st_10,&
this.st_input_man,&
this.st_title_06,&
this.st_2,&
this.pb_close,&
this.pb_prev,&
this.st_rate_prev,&
this.st_rate_now,&
this.st_qty_prod,&
this.st_qty_plan,&
this.pb_menu,&
this.st_title_05,&
this.st_title_04,&
this.st_mng_no,&
this.st_ymd_time,&
this.st_3,&
this.st_5,&
this.p_1,&
this.st_refresh,&
this.st_title_02,&
this.st_title_03,&
this.st_model}
end on

on w_main.destroy
destroy(this.st_4)
destroy(this.st_1)
destroy(this.st_10)
destroy(this.st_input_man)
destroy(this.st_title_06)
destroy(this.st_2)
destroy(this.pb_close)
destroy(this.pb_prev)
destroy(this.st_rate_prev)
destroy(this.st_rate_now)
destroy(this.st_qty_prod)
destroy(this.st_qty_plan)
destroy(this.pb_menu)
destroy(this.st_title_05)
destroy(this.st_title_04)
destroy(this.st_mng_no)
destroy(this.st_ymd_time)
destroy(this.st_3)
destroy(this.st_5)
destroy(this.p_1)
destroy(this.st_refresh)
destroy(this.st_title_02)
destroy(this.st_title_03)
destroy(this.st_model)
end on

event timer;
//--------------------------------------------------------
// ���� �ֱ�� �Ʒ� �۾��� �����Ѵ�.
//--------------------------------------------------------

Integer 	li_time

st_ymd_time.text 	= String(today(), 'yyyy-mm-dd') + ' ' + String(Now(), 'hh:mm:ss')
li_time 				= Integer(String(Now(), 'ss'))
st_refresh.Text 	= String(gi_CycleTime - gi_ProcTime)
 
// ������ ����� CYCLE TIME �������� 
// 
If (st_refresh.Text = '1') Then
	wf_main_execute()		// ����ó�� 
	wf_main_display()		// ����ȭ�� ���� Refresh 
	gi_ProcTime = 0
Else
	gi_ProcTime = gi_ProcTime + 1
End If

// 1�� �������� ȭ���� ���� ������ 
// 
If (gs_Screen_Top = 'Y') Then
	If (li_time = 0) Then
		SetPosition(TopMost!)
	ElseIf (li_time >= 2) And (li_time <= 3) Then
		SetPosition(NoTopMost!)
		SetPosition(ToTop!)
	End if
End If




end event

event open;
// ���θ�
st_mng_no.Text = gs_line_name

// �ʱ�ȭ�� �ڷ���ȸ 
wf_get_config()
wf_main_display()
st_refresh.Text = ""

// ���� Ư�̻��� ��뿩��
If (gs_ETC = 'Y') Then
	st_title_02.Width = st_title_03.Width
	//st_title_02.Text = "��ǥ���� :"
	st_title_02.Text = gs_ETC_TEXT
	
	st_model.x = st_qty_plan.x
	st_model.Width = st_qty_plan.Width
	st_model.Alignment = Right!
End If

// Timer �⵿
Timer(1)


end event

type st_4 from statictext within w_main
integer x = 1751
integer y = 1928
integer width = 992
integer height = 556
integer textsize = -90
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "�� :"
boolean focusrectangle = false
end type

type st_1 from statictext within w_main
integer x = 978
integer y = 1920
integer width = 521
integer height = 556
integer textsize = -90
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "��"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_10 from statictext within w_main
integer x = 14
integer y = 12
integer width = 750
integer height = 192
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 16777215
long backcolor = 16777215
boolean focusrectangle = false
end type

type st_input_man from statictext within w_main
integer x = 2377
integer y = 2720
integer width = 704
integer height = 200
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 65535
long backcolor = 0
string text = "99��"
boolean focusrectangle = false
end type

event clicked;// �����ο� ����ȭ�� Display
// 

Open(w_select_cycle)

end event

type st_title_06 from statictext within w_main
integer x = 1678
integer y = 2720
integer width = 704
integer height = 200
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
long textcolor = 65535
long backcolor = 0
string text = "�����ο�:"
boolean focusrectangle = false
end type

event clicked;// �����ο� ����ȭ�� Display
// 

Open(w_select_cycle)

end event

type st_2 from statictext within w_main
integer x = 4069
integer y = 2032
integer width = 535
integer height = 468
integer textsize = -72
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "%"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_close from picturebutton within w_main
integer x = 3954
integer y = 2652
integer width = 727
integer height = 292
integer taborder = 20
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "����"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;Halt Close
Return



end event

type pb_prev from picturebutton within w_main
integer x = 9
integer y = 2652
integer width = 727
integer height = 292
integer taborder = 10
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "����"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// ���Ϲ��� Ŭ���� ó��
//		- 7��ġ ���ں� ������ �ڵ� ��ȸ �˾�ȭ�� ������
//		- �ѹ� �� �����ų� 10���� �ڵ� �����

Open(w_rate_daily)


end event

type st_rate_prev from statictext within w_main
integer x = 878
integer y = 2720
integer width = 690
integer height = 200
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 0
string text = "99.9%"
boolean focusrectangle = false
end type

type st_rate_now from statictext within w_main
integer x = 2665
integer y = 2000
integer width = 1353
integer height = 492
integer textsize = -80
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "9999"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_qty_prod from statictext within w_main
integer x = 2665
integer y = 1436
integer width = 1353
integer height = 508
integer textsize = -80
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "9999"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_qty_plan from statictext within w_main
integer x = 2665
integer y = 848
integer width = 1353
integer height = 516
integer textsize = -80
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "9999"
alignment alignment = right!
boolean focusrectangle = false
end type

event doubleclicked;// ��ȹ���� ����
//		���α׷��� ����Ǿ� �ִ� ���� ��ȹ������ �������� ����.
// 	�׷��� �ʿ�� ��ȹ������ �����ϵ��� ������.
//
//Open(w_update_plan)

end event

type pb_menu from picturebutton within w_main
integer x = 3218
integer y = 2652
integer width = 727
integer height = 292
integer taborder = 10
integer textsize = -26
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "HyperLink!"
string text = "�޴�"
string picturename = ".\IMAGE\Button.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;Open(w_search)


end event

type st_title_05 from statictext within w_main
integer x = 155
integer y = 1924
integer width = 530
integer height = 556
integer textsize = -90
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "��"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_title_04 from statictext within w_main
integer x = 123
integer y = 1364
integer width = 2601
integer height = 624
integer textsize = -90
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "�������� :"
boolean focusrectangle = false
end type

type st_mng_no from statictext within w_main
integer x = 850
integer y = 40
integer width = 1682
integer height = 148
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 0
string text = "A-01"
long bordercolor = 16711680
boolean focusrectangle = false
end type

type st_ymd_time from statictext within w_main
integer x = 2967
integer y = 40
integer width = 1641
integer height = 168
integer textsize = -20
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 0
string text = "YYYY-MM-DD HH:MM"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_main
integer width = 6112
integer height = 220
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 0
boolean focusrectangle = false
end type

type st_5 from statictext within w_main
integer y = 2600
integer width = 5865
integer height = 564
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "���� ���"
long textcolor = 33554432
long backcolor = 0
boolean focusrectangle = false
end type

type p_1 from picture within w_main
integer x = 18
integer y = 16
integer width = 727
integer height = 180
boolean bringtotop = true
string picturename = ".\IMAGE\Kdac.jpg"
boolean focusrectangle = false
end type

type st_refresh from statictext within w_main
integer x = 667
integer y = 136
integer width = 87
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "9"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_title_02 from statictext within w_main
integer x = 133
integer y = 200
integer width = 1550
integer height = 536
integer textsize = -90
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "�� :"
boolean focusrectangle = false
end type

type st_title_03 from statictext within w_main
integer x = 123
integer y = 756
integer width = 2601
integer height = 624
integer textsize = -90
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
string text = "��ȹ���� :"
boolean focusrectangle = false
end type

type st_model from statictext within w_main
integer x = 1696
integer y = 308
integer width = 4101
integer height = 424
integer textsize = -80
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "T300"
boolean focusrectangle = false
end type

event clicked;// ��ǥ���� ����
//		(��������θ� ���)
If (gs_ETC = 'Y') Then
	Open(w_update_target)
End If
end event

