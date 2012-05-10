$PBExportHeader$w_mpsg060u.srw
$PBExportComments$�������_�����������
forward
global type w_mpsg060u from window
end type
type pb_close from picturebutton within w_mpsg060u
end type
type pb_reset from picturebutton within w_mpsg060u
end type
type pb_save from picturebutton within w_mpsg060u
end type
type pb_bad from picturebutton within w_mpsg060u
end type
type pb_good from picturebutton within w_mpsg060u
end type
type dw_mpsg060u_02 from datawindow within w_mpsg060u
end type
type sle_kbno from singlelineedit within w_mpsg060u
end type
type gb_1 from groupbox within w_mpsg060u
end type
type gb_2 from groupbox within w_mpsg060u
end type
type dw_mpsg060u_01 from datawindow within w_mpsg060u
end type
type gb_3 from groupbox within w_mpsg060u
end type
type uo_select_date from uo_today within w_mpsg060u
end type
end forward

global type w_mpsg060u from window
integer x = 18
integer y = 580
integer width = 4640
integer height = 2460
boolean titlebar = true
string title = "����������� Ȯ��"
windowtype windowtype = response!
long backcolor = 79219928
pb_close pb_close
pb_reset pb_reset
pb_save pb_save
pb_bad pb_bad
pb_good pb_good
dw_mpsg060u_02 dw_mpsg060u_02
sle_kbno sle_kbno
gb_1 gb_1
gb_2 gb_2
dw_mpsg060u_01 dw_mpsg060u_01
gb_3 gb_3
uo_select_date uo_select_date
end type
global w_mpsg060u w_mpsg060u

type variables
INTEGER	ii_time_chk				//	�ð� üũ

end variables

forward prototypes
public function integer wf_save_check ()
private function integer wf_actual_recording ()
end prototypes

public function integer wf_save_check ();// arg_dw.modify(ls_colname + ".Background.Color = 65535")
// IF Long(arg_dw.Describe(ls_colname + ".Background.Color")) = 15780518
// �����: 65535, ȸ��:12632256, ���:16777215
// ��ȯ�� : ����(-1), ����(0)
String ls_data, ls_check
integer li_data

// WorkCenter Check
if Long(dw_mpsg060u_01.Describe("wccode.Background.Color")) <> 12632256 then
	ls_data = dw_mpsg060u_01.getitemstring(1,"wccode")
	if f_mpsg_spacechk(ls_data) = -1 then
		dw_mpsg060u_01.modify("wccode.Background.Color = 65535")
		return -1
	else
		dw_mpsg060u_01.modify("wccode.Background.Color = 16777215")
	end if
end if
// WorkDate Check
// ldt_now_datetime		= DATETIME(TODAY(), NOW())
// ls_applydate_close	= f_mpms_get_applydate(ldt_now_datetime)
if Long(dw_mpsg060u_01.Describe("workdate.Background.Color")) <> 12632256 then
	ls_data = dw_mpsg060u_01.getitemstring(1,"workdate")
	ls_check = f_mpms_get_applydate(DATETIME(TODAY(), NOW()))
	if f_mpsg_spacechk(ls_data) = -1 or &
		ls_data > ls_check or mid(ls_data,1,7) < mid(ls_check,1,7) then
		dw_mpsg060u_01.modify("workdate.Background.Color = 65535")
		return -1
	else
		dw_mpsg060u_01.modify("workdate.Background.Color = 16777215")
	end if
end if
// WorkEmp Check
if Long(dw_mpsg060u_01.Describe("workemp.Background.Color")) <> 12632256 then
	ls_data = dw_mpsg060u_01.getitemstring(1,"workemp")
	if f_mpsg_spacechk(ls_data) = -1 then
		dw_mpsg060u_01.modify("workemp.Background.Color = 65535")
		return -1
	else
		dw_mpsg060u_01.modify("workemp.Background.Color = 16777215")
	end if
end if
// MchNo Check
if Long(dw_mpsg060u_01.Describe("mchno.Background.Color")) <> 12632256 then
	ls_data = dw_mpsg060u_01.getitemstring(1,"mchno")
	if f_mpsg_spacechk(ls_data) = -1 then
		dw_mpsg060u_01.modify("mchno.Background.Color = 65535")
		return -1
	else
		dw_mpsg060u_01.modify("mchno.Background.Color = 16777215")
	end if
end if
//**** ProcessRatio Check
//* �Էµ� ����Ÿ�� �ش������ ���� ���������� 100���� ���ų� ����� �Ѵ�.
if Long(dw_mpsg060u_01.Describe("processratio.Background.Color")) <> 12632256 then
	li_data = dw_mpsg060u_01.getitemnumber(1,"processratio")
	if li_data > 100 then
		dw_mpsg060u_01.modify("processratio.Background.Color = 65535")
		return -1
	else
		dw_mpsg060u_01.modify("processratio.Background.Color = 16777215")
	end if
end if
// Job Time Check
if Long(dw_mpsg060u_01.Describe("jobtime.Background.Color")) <> 12632256 then
	li_data = dw_mpsg060u_01.getitemnumber(1,"jobtime")
	if li_data > 100 then
		dw_mpsg060u_01.modify("jobtime.Background.Color = 65535")
		return -1
	else
		dw_mpsg060u_01.modify("jobtime.Background.Color = 16777215")
	end if
end if
return 0
end function

private function integer wf_actual_recording ();INTEGER	li_error_code
STRING	ls_orderno, ls_partno, ls_operno, ls_wccode, ls_workdate
STRING	ls_workemp, ls_mchno, ls_resultflag, ls_stype, ls_srno, ls_badstype, ls_badsrno
INTEGER	li_jobtime, li_processratio

ls_orderno = dw_mpsg060u_01.getitemstring(1,"orderno")
ls_partno  = dw_mpsg060u_01.getitemstring(1,"partno")
ls_operno = dw_mpsg060u_01.getitemstring(1,"operno")
ls_wccode = dw_mpsg060u_01.getitemstring(1,"wccode")
ls_workdate = dw_mpsg060u_01.getitemstring(1,"workdate")
ls_workemp = dw_mpsg060u_01.getitemstring(1,"workemp")
ls_mchno = dw_mpsg060u_01.getitemstring(1,"mchno")
li_jobtime = dw_mpsg060u_01.getitemnumber(1,"jobtime")
li_processratio = dw_mpsg060u_01.getitemnumber(1,"processratio")
ls_resultflag = dw_mpsg060u_01.getitemstring(1,"resultflag")
ls_stype = dw_mpsg060u_01.getitemstring(1,"stype")
ls_srno = dw_mpsg060u_01.getitemstring(1,"srno")
ls_badstype = dw_mpsg060u_01.getitemstring(1,"badstype")
ls_badsrno = dw_mpsg060u_01.getitemstring(1,"badsrno")

DECLARE actual_recording procedure for sp_mpsg060u_update
@ps_stype		= :ls_stype,
@ps_srno			= :ls_srno,
@ps_orderno  	= :ls_orderno,
@ps_partno 		= :ls_partno,
@ps_operno 		= :ls_operno,
@ps_wccode 		= :ls_wccode,
@ps_workdate 	= :ls_workdate,
@ps_workemp 	= :ls_workemp,
@ps_mchno 		= :ls_mchno,
@ps_jobtime 	= :li_jobtime,
@ps_processratio = :li_processratio,
@ps_resultflag = :ls_resultflag,
@ps_badstype	= :ls_badstype,
@ps_badsrno		= :ls_badsrno,
@pi_err_code		= :li_error_code	output
USING	SQLCA ;

EXECUTE actual_recording ;

FETCH actual_recording
	INTO :li_error_code ;
CLOSE	actual_recording ;

RETURN li_error_code

end function

on w_mpsg060u.create
this.pb_close=create pb_close
this.pb_reset=create pb_reset
this.pb_save=create pb_save
this.pb_bad=create pb_bad
this.pb_good=create pb_good
this.dw_mpsg060u_02=create dw_mpsg060u_02
this.sle_kbno=create sle_kbno
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_mpsg060u_01=create dw_mpsg060u_01
this.gb_3=create gb_3
this.uo_select_date=create uo_select_date
this.Control[]={this.pb_close,&
this.pb_reset,&
this.pb_save,&
this.pb_bad,&
this.pb_good,&
this.dw_mpsg060u_02,&
this.sle_kbno,&
this.gb_1,&
this.gb_2,&
this.dw_mpsg060u_01,&
this.gb_3,&
this.uo_select_date}
end on

on w_mpsg060u.destroy
destroy(this.pb_close)
destroy(this.pb_reset)
destroy(this.pb_save)
destroy(this.pb_bad)
destroy(this.pb_good)
destroy(this.dw_mpsg060u_02)
destroy(this.sle_kbno)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_mpsg060u_01)
destroy(this.gb_3)
destroy(this.uo_select_date)
end on

event open;STRING	ls_kbno, ls_orderno, ls_partno	// ���ǹ�ȣ
STRING	ls_message, ls_stype, ls_srno    // ���õ� ��������Ÿ
STRING	ls_comcode					// �ܸ��� �ڵ�
STRING	ls_applydate_close		// ������ ������ DATE
STRING	ls_terminalcode			// �ܸ��� �ڵ�
STRING	ls_com_send

INTEGER	li_row_count				// ���ڵ� ī��
INTEGER	li_error_code				// ERROR CODE

DATETIME	ldt_now_datetime			// ���� DATETIME
DATAWINDOWCHILD ldwc

// ȭ�� �߽�
//f_centerwindow(this)
uo_select_date.visible = false
pb_good.visible = false
pb_bad.visible = false
dw_mpsg060u_02.dataobject = "d_mpsg050u_bg"
dw_mpsg060u_01.GetChild('resultflag', ldwc)
ldwc.settransobject(sqlca)
ldwc.retrieve('MPM008')

// ��������Ÿ ��������
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
// ���ǹ�ȣ
ls_kbno			= "R" + ls_orderno + ls_partno
sle_kbno.text	= ls_kbno

// �ð� ����
ldt_now_datetime		= DATETIME(TODAY(), NOW())

ls_applydate_close	= f_mpms_get_applydate(ldt_now_datetime)

// �ܸ��� �ڵ�
ls_terminalcode	= ProfileString(gs_inifile, "Com_Info", "Comcode", "")
		
// ������ȸ
dw_mpsg060u_01.settransobject(sqlca)
dw_mpsg060u_01.Retrieve( ls_stype, ls_srno, gs_line_code[gi_tab_index])

end event

event timer;/*######################################################################
#####		�ð��� üũ�Ͽ�	����Ÿ������ COLOR ����						 #####
######################################################################*/

ii_time_chk = ii_time_chk + 1

IF MOD(ii_time_chk, 2) = 1 THEN
	dw_mpsg060u_01.Object.datawindow.color = RGB(203, 203, 203)
ELSE
	dw_mpsg060u_01.Object.datawindow.color = RGB(255, 255, 255)
END IF

// 4�ʰ� ���� ǥ��
IF ii_time_chk > 6 THEN
	// ������ ����
	Close(w_mpsg060u)
END IF

end event

type pb_close from picturebutton within w_mpsg060u
integer x = 1134
integer y = 1960
integer width = 425
integer height = 328
integer taborder = 40
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�ݱ�"
string picturename = "C:\kdac\mpms_gather\bmp\background.gif"
string disabledname = "C:\kdac\mpms_gather\bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;Close(w_mpsg060u)

Choose case gi_page_index
	case 3
		// ������ȸ
		w_mpsg090i.TriggerEvent("ue_line_select")
	case 4
		// �۾��Ϻ�
		w_mpsg080i.TriggerEvent("ue_line_select")
	case else
		// ���� �Է�â�� Focus
		w_mpsg030i.triggerevent("Activate!")
		w_mpsg030i.em_kb_no.SetFocus()
		
		IF IsValid(w_mpsg030i) THEN
		
			// �������ȭ�� �ֻ�����
			w_mpsg030i.BringToTop = TRUE
		
			// ��������� LINE���� �̺�Ʈ
			w_mpsg030i.TriggerEvent("ue_line_select")
		
			// ���ǹ�ȣ �Է�â�� �ʱ�ȭ�� FOCUS
			w_mpsg030i.em_kb_no.text = ''
			w_mpsg030i.em_kb_no.SetFocus()
		ELSE
			// ������� Open
			Open(w_mpsg030i)
		END IF
end choose
end event
type pb_reset from picturebutton within w_mpsg060u
integer x = 617
integer y = 1960
integer width = 425
integer height = 328
integer taborder = 40
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
string picturename = "C:\kdac\mpms_gather\bmp\background.gif"
string disabledname = "C:\kdac\mpms_gather\bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;string ls_stype, ls_srno

ls_stype = dw_mpsg060u_01.getitemstring(1,"stype")
ls_srno = dw_mpsg060u_01.getitemstring(1,"srno")

dw_mpsg060u_01.reset()
dw_mpsg060u_01.Retrieve( ls_stype, ls_srno, gs_line_code[gi_tab_index])

return 0
end event

type pb_save from picturebutton within w_mpsg060u
integer x = 101
integer y = 1960
integer width = 425
integer height = 328
integer taborder = 30
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "���"
string picturename = "C:\kdac\mpms_gather\bmp\background.gif"
string disabledname = "C:\kdac\mpms_gather\bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;string ls_applydate_close, ls_applydate
integer li_error_code, li_row_count

ls_applydate_close = f_mpms_get_applydate(DATETIME(TODAY(), NOW()))
ls_applydate = mid(ls_applydate_close,1,4) + mid(ls_applydate_close,6,2) + mid(ls_applydate_close,9,2)

//** ���� �Ǵ� Null Check
if wf_save_check() = -1 then
	return -1
end if

// ����
li_error_code		= wf_actual_recording()

IF li_error_code = 0 THEN
	// TIMER
	timer(0.5)
	Choose case gi_page_index
		case 3
			// ������ȸ
			w_mpsg090i.TriggerEvent("ue_line_select")
		case 4
			// �۾��Ϻ�
			w_mpsg080i.TriggerEvent("ue_line_select")
		case else
			// COUNT
			SELECT	COUNT(OperNo)
			  INTO	:li_row_count
			  FROM	TWORKCENTER aa INNER JOIN TWORKJOB bb
					ON aa.WcCode = bb.WcCode
			 WHERE	bb.WorkDate		= :ls_applydate
				AND	aa.WgCode		= :gs_workcenter_code[gi_tab_index]
				AND	aa.WcCode		= :gs_line_code[gi_tab_index]
				;
			
			// ����Ÿ ����.
			w_mpsg030i.dw_mpsg030i_01.Retrieve(ls_applydate_close,			&
												gs_workcenter_code[gi_tab_index],	&
												gs_line_code[gi_tab_index])
			// ȭ�� ��ũ��
			w_mpsg030i.dw_mpsg030i_01.ScrollToRow(li_row_count + gi_show_count[gi_tab_index])
			
			// dw_pisg030i_01�� ���õǾ��� ROW
			w_mpsg030i.dw_mpsg030i_01.SelectRow(0, FALSE)
			w_mpsg030i.dw_mpsg030i_01.SelectRow(li_row_count, TRUE)
	
			// ���ǹ�ȣ �Է�â�� �ʱ�ȭ�� FOCUS
			w_mpsg030i.em_kb_no.text = ''
			w_mpsg030i.em_kb_no.SetFocus()
	end choose
else
	Open(w_mpsg060b)
end if

return 0
end event

type pb_bad from picturebutton within w_mpsg060u
integer x = 2373
integer y = 1556
integer width = 425
integer height = 328
integer taborder = 30
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�ҷ�"
string picturename = "C:\kdac\mpms_gather\bmp\background.gif"
string disabledname = "C:\kdac\mpms_gather\bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;dw_mpsg060u_01.setitem(1,'resultflag','E')
end event

type pb_good from picturebutton within w_mpsg060u
integer x = 1787
integer y = 1556
integer width = 425
integer height = 328
integer taborder = 30
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
boolean originalsize = true
string picturename = "C:\kdac\mpms_gather\bmp\background.gif"
string disabledname = "C:\kdac\mpms_gather\bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;dw_mpsg060u_01.setitem(1,'resultflag','A')
end event

type dw_mpsg060u_02 from datawindow within w_mpsg060u
integer x = 1687
integer y = 72
integer width = 2889
integer height = 2224
integer taborder = 30
string dataobject = "d_mpsg050u_04"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;/*######################################################################
#####		���õǾ��� ROW �� üũ												 #####
######################################################################*/
IF ROW > 0 THEN

	/*###################################################################
	#####		���϶���Ʈ															 #####
	###################################################################*/

	This.SelectRow(0, FALSE)
	This.SelectRow(row, TRUE)
ELSE
	return 0
END IF

choose case dw_mpsg060u_02.dataobject
	case 'd_mpsg050u_02'  // workcenter
		dw_mpsg060u_01.setitem(1,'wccode', This.getitemstring(row,'wccode'))
	case 'd_mpsg050u_03'  // �۾���
		dw_mpsg060u_01.setitem(1,'workemp',This.getitemstring(row,'empno'))
	case 'd_mpsg050u_04'  // ����ȣ
		dw_mpsg060u_01.setitem(1,'mchno',This.getitemstring(row,'mchno'))
		
end choose

return 0
end event

event buttonclicked;choose case dw_mpsg060u_02.dataobject
	case 'd_mpsg050u_02'  // workcenter
		
	case 'd_mpsg050u_03'  // �۾���
		if dwo.name = 'b_search' then
			dw_mpsg060u_02.reset()
			dw_mpsg060u_02.retrieve('%')
		end if
	case 'd_mpsg050u_04'  // ����ȣ
		
end choose
end event

type sle_kbno from singlelineedit within w_mpsg060u
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
string facename = "����ü"
long textcolor = 65535
long backcolor = 0
boolean autohscroll = false
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_mpsg060u
integer x = 18
integer y = 8
integer width = 1618
integer height = 304
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 255
long backcolor = 67108864
string text = "�۾����ü���ȣȮ��"
end type

type gb_2 from groupbox within w_mpsg060u
integer x = 18
integer y = 296
integer width = 1618
integer height = 2032
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_mpsg060u_01 from datawindow within w_mpsg060u
integer x = 59
integer y = 336
integer width = 1531
integer height = 1596
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_mpsg060u_01"
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_colname, ls_wccode, ls_rtn
datawindowchild ldwc
str_mpsg_parm lstr_parm

ls_colname = dwo.name

choose case ls_colname
//	case 'wccode'
//		uo_select_date.visible = false
//		pb_good.visible = false
//		pb_bad.visible = false
//		if mid(sle_kbno.text,1,1) = 'A' then
//			dw_mpsg060u_02.dataobject = "d_mpsg050u_bg"
//			return 0
//		end if
//		dw_mpsg060u_02.dataobject = "d_mpsg050u_02"
//		dw_mpsg060u_02.settransobject(sqlca)
//		dw_mpsg060u_02.GetChild('wcgubun', ldwc)
//		ldwc.settransobject(sqlca)
//		ldwc.retrieve('MPM001')
//		dw_mpsg060u_02.retrieve()
	case 'workdate'
		uo_select_date.visible = true
		pb_good.visible = false
		pb_bad.visible = false
		dw_mpsg060u_02.dataobject = "d_mpsg050u_bg"
		uo_select_date.triggerevent("ue_test")
	case 'workemp'
		uo_select_date.visible = false
		pb_good.visible = false
		pb_bad.visible = false
		ls_wccode = This.getitemstring(1,"wccode")
		if isnull(ls_wccode) then
			return 0
		end if
		dw_mpsg060u_02.dataobject = "d_mpsg050u_03"
		dw_mpsg060u_02.settransobject(sqlca)
		dw_mpsg060u_02.retrieve(ls_wccode)
	case 'mchno'
		uo_select_date.visible = false
		pb_good.visible = false
		pb_bad.visible = false
		ls_wccode = This.getitemstring(1,"wccode")
		if isnull(ls_wccode) then
			return 0
		end if
		dw_mpsg060u_02.dataobject = "d_mpsg050u_04"
		dw_mpsg060u_02.settransobject(sqlca)
		dw_mpsg060u_02.retrieve(ls_wccode)
	case 'processratio'
		uo_select_date.visible = false
		pb_good.visible = false
		pb_bad.visible = false
		dw_mpsg060u_02.dataobject = "d_mpsg050u_bg"
		lstr_parm.s_parm[1] = 'Y'	//��ǥ��������
		lstr_parm.s_parm[2] = 'N'	//�����Է¿���
		lstr_parm.i_parm[1] = dw_mpsg060u_02.x + 32
		lstr_parm.i_parm[2] = dw_mpsg060u_02.y + 694
		OpenWithParm(w_mpsg041b,lstr_parm)
		ls_rtn = message.stringparm
		if Not isnull(ls_rtn) and integer(ls_rtn) <> 0 then
			dw_mpsg060u_01.setitem(1,'processratio',integer(ls_rtn))
		end if
	case 'jobtime'
		uo_select_date.visible = false
		pb_good.visible = false
		pb_bad.visible = false
		dw_mpsg060u_02.dataobject = "d_mpsg050u_bg"
		lstr_parm.s_parm[1] = 'Y'	//��ǥ��������
		lstr_parm.s_parm[2] = 'N'	//�����Է¿���
		lstr_parm.i_parm[1] = dw_mpsg060u_02.x + 32
		lstr_parm.i_parm[2] = dw_mpsg060u_02.y + 694
		OpenWithParm(w_mpsg041b,lstr_parm)
		ls_rtn = message.stringparm
		if Not isnull(ls_rtn) and integer(ls_rtn) <> 0 then
			dw_mpsg060u_01.setitem(1,'jobtime',integer(ls_rtn))
		end if
	case 'resultflag'
		uo_select_date.visible = false
		pb_good.visible = false
		pb_bad.visible = false
		dw_mpsg060u_02.dataobject = "d_mpsg050u_bg"
	case else
		uo_select_date.visible = false
		pb_good.visible = false
		pb_bad.visible = false
		dw_mpsg060u_02.dataobject = "d_mpsg050u_bg"
end choose

return 0
end event

type gb_3 from groupbox within w_mpsg060u
integer x = 1650
integer y = 36
integer width = 2962
integer height = 2292
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 31975399
end type

type uo_select_date from uo_today within w_mpsg060u
integer x = 1733
integer y = 272
integer taborder = 30
boolean bringtotop = true
end type

on uo_select_date.destroy
call uo_today::destroy
end on

event ue_variable_set;call super::ue_variable_set;dw_mpsg060u_01.setitem(1,"workdate",string(id_date_selected,"yyyy.mm.dd"))
end event
