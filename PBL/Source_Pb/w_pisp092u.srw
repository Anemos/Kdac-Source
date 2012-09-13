$PBExportHeader$w_pisp092u.srw
$PBExportComments$조립지시 - 미준수 간판 등록
forward
global type w_pisp092u from window
end type
type st_msg from statictext within w_pisp092u
end type
type uo_date from u_pisc_date_applydate within w_pisp092u
end type
type dw_kbno_info from datawindow within w_pisp092u
end type
type cb_3 from commandbutton within w_pisp092u
end type
type uo_code from u_pisc_select_code within w_pisp092u
end type
type dw_kbno from u_pisp_kbno_scan within w_pisp092u
end type
type uo_line from u_pisc_select_line within w_pisp092u
end type
type cb_1 from commandbutton within w_pisp092u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp092u
end type
type uo_division from u_pisc_select_division within w_pisp092u
end type
type uo_area from u_pisc_select_area within w_pisp092u
end type
type gb_1 from groupbox within w_pisp092u
end type
type dw_save from datawindow within w_pisp092u
end type
type gb_2 from groupbox within w_pisp092u
end type
type dw_unobserve from datawindow within w_pisp092u
end type
type gb_4 from groupbox within w_pisp092u
end type
type gb_5 from groupbox within w_pisp092u
end type
type gb_6 from groupbox within w_pisp092u
end type
type gb_8 from groupbox within w_pisp092u
end type
type gb_7 from groupbox within w_pisp092u
end type
type gb_9 from groupbox within w_pisp092u
end type
type gb_3 from groupbox within w_pisp092u
end type
end forward

global type w_pisp092u from window
integer width = 4338
integer height = 2312
boolean titlebar = true
string title = "미준수간판 회수"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
st_msg st_msg
uo_date uo_date
dw_kbno_info dw_kbno_info
cb_3 cb_3
uo_code uo_code
dw_kbno dw_kbno
uo_line uo_line
cb_1 cb_1
uo_workcenter uo_workcenter
uo_division uo_division
uo_area uo_area
gb_1 gb_1
dw_save dw_save
gb_2 gb_2
dw_unobserve dw_unobserve
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
gb_8 gb_8
gb_7 gb_7
gb_9 gb_9
gb_3 gb_3
end type
global w_pisp092u w_pisp092u

type variables
Boolean		ib_open, ib_save
String		is_plandate
str_parms	istr_parms
end variables

forward prototypes
public subroutine wf_retrieve ()
end prototypes

event ue_postopen;dw_kbno_info.SetTransObject(SQLPIS)
dw_unobserve.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)

f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										False, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										False, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)

f_pisc_retrieve_dddw_code(uo_code.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'PUNOBSERVE', &
										'%', &
										False, &
										uo_code.is_uo_codegroup, &
										uo_code.is_uo_codeid, &
										uo_code.is_uo_codegroupname, &
										uo_code.is_uo_codename)

// 한번 조회해 주자..
// 근디 처음 오픈하는 경우에는 메세지를 띄우지 말자..히히
If dw_unobserve.Retrieve(	uo_date.is_uo_date, &
									uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
									uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
									uo_code.is_uo_codegroup,			uo_code.is_uo_codeid) > 0 Then
Else
	st_msg.Text = "미준수 간판 등록 이력이 존재하지 않습니다."
End If

If dw_kbno_info.Retrieve(	uo_date.is_uo_date, &
									uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
									uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
	st_msg.Text = "미준수등록을 수행할 간판을 입력하십시오."
Else
	st_msg.Text = "미준수 간판을 등록할 수 있는 지시상태의 간판이 없습니다."
End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()

ib_open = True
end event

public subroutine wf_retrieve ();dw_kbno_info.ReSet()
dw_unobserve.ReSet()
dw_save.ReSet()

If dw_unobserve.Retrieve(	uo_date.is_uo_date, &
									uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
									uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
									uo_code.is_uo_codegroup,			uo_code.is_uo_codeid) > 0 Then
Else
	st_msg.Text = "미준수 간판 등록 이력이 존재하지 않습니다."
End If

If dw_kbno_info.Retrieve(	uo_date.is_uo_date, &
								uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode) > 0 Then
	st_msg.Text = "미준수등록을 수행할 간판을 입력하십시오."
Else
	st_msg.Text = "미준수간판을 등록할 수 있는 지시상태의 간판이 없습니다."
End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end subroutine

on w_pisp092u.create
this.st_msg=create st_msg
this.uo_date=create uo_date
this.dw_kbno_info=create dw_kbno_info
this.cb_3=create cb_3
this.uo_code=create uo_code
this.dw_kbno=create dw_kbno
this.uo_line=create uo_line
this.cb_1=create cb_1
this.uo_workcenter=create uo_workcenter
this.uo_division=create uo_division
this.uo_area=create uo_area
this.gb_1=create gb_1
this.dw_save=create dw_save
this.gb_2=create gb_2
this.dw_unobserve=create dw_unobserve
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_8=create gb_8
this.gb_7=create gb_7
this.gb_9=create gb_9
this.gb_3=create gb_3
this.Control[]={this.st_msg,&
this.uo_date,&
this.dw_kbno_info,&
this.cb_3,&
this.uo_code,&
this.dw_kbno,&
this.uo_line,&
this.cb_1,&
this.uo_workcenter,&
this.uo_division,&
this.uo_area,&
this.gb_1,&
this.dw_save,&
this.gb_2,&
this.dw_unobserve,&
this.gb_4,&
this.gb_5,&
this.gb_6,&
this.gb_8,&
this.gb_7,&
this.gb_9,&
this.gb_3}
end on

on w_pisp092u.destroy
destroy(this.st_msg)
destroy(this.uo_date)
destroy(this.dw_kbno_info)
destroy(this.cb_3)
destroy(this.uo_code)
destroy(this.dw_kbno)
destroy(this.uo_line)
destroy(this.cb_1)
destroy(this.uo_workcenter)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.gb_1)
destroy(this.dw_save)
destroy(this.gb_2)
destroy(this.dw_unobserve)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_8)
destroy(this.gb_7)
destroy(this.gb_9)
destroy(this.gb_3)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]
is_plandate			= istr_parms.string_arg[2]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type st_msg from statictext within w_pisp092u
integer x = 2085
integer y = 296
integer width = 2176
integer height = 64
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
boolean focusrectangle = false
end type

type uo_date from u_pisc_date_applydate within w_pisp092u
integer x = 50
integer y = 64
end type

event ue_select;If ib_open Then
	wf_retrieve()
End If
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type dw_kbno_info from datawindow within w_pisp092u
integer x = 46
integer y = 544
integer width = 1970
integer height = 1604
string title = "none"
string dataobject = "d_pisp092u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

type cb_3 from commandbutton within w_pisp092u
integer x = 3826
integer y = 56
integer width = 402
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료(&C)"
end type

event clicked;If ib_save Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type uo_code from u_pisc_select_code within w_pisp092u
integer x = 55
integer y = 308
end type

on uo_code.destroy
call u_pisc_select_code::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
//	wf_retrieve()
	dw_kbno.Reset()
	dw_kbno.InsertRow(1)
	dw_kbno.SetColumn(1)
	dw_kbno.SetRow(1)
	dw_kbno.SetFocus()
End If
end event

type dw_kbno from u_pisp_kbno_scan within w_pisp092u
integer x = 873
integer y = 272
integer taborder = 0
end type

event ue_enter;call super::ue_enter;String	ls_kbno, ls_kbno_check
dwobject ldwo_this

ls_kbno_check	= Trim(GetItemString(1,1))
AcceptText()
ls_kbno			= Trim(GetItemString(1,1))

If ls_kbno_check = ls_kbno Then
	Post Event ItemChanged(1, ldwo_this, ls_kbno)
End If
end event

event itemchanged;call super::itemchanged;String	ls_applydate_close, ls_kbno, ls_kbreleasedate, ls_errortext
Int		i, li_find, li_kbreleaseseq
Boolean	lb_error
//			li_releasetempkbcount, li_releasetempkbqty
//Int		li_cycleorder
//String	ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, ls_itemcode

If Len(Data) <> 11 Then
	f_pisc_beep()
	MessageBox("미준수간판 등록","간판번호는 11자리 입니다.~r~n정확한 간판 번호를 입력하십시오.")
	GoTo Scrip_Out
End If

If dw_kbno_info.RowCount() > 0 Then
	//
Else
	f_pisc_beep()
	MessageBox("미준수간판 등록", "선택하신 라인에는 지시 상태인 간판이 없습니다." + &
								"~r~n~r~n미준수간판 등록이 불가능 합니다." + &
								"~r~n~r~n다른 라인을 선택하신 후에 미준수간판 등록을 수행하십시오.", &
								StopSign!)
		// 조립지시 하자...헤헤
	GoTo Scrip_Out
End If

ls_applydate_close	= f_pisc_get_date_applydate_close(uo_area.is_uo_areacode, &
																		uo_division.is_uo_divisioncode, &
																		f_pisc_get_date_nowtime())
																		
//If Left(uo_date.is_uo_date, 7) < Left(ls_applydate_close, 7) Then
//	MessageBox("미준수간판 등록", "지난달의 미준수간판 등록은 불가능합니다.", StopSign!)
//	GoTo Scrip_Out
//End If

If uo_date.is_uo_date > ls_applydate_close Then
	f_pisc_beep()
	MessageBox("미준수간판 등록", "기준일 이후 일자의 미준수 간판 등록은 불가능합니다.", StopSign!)
	GoTo Scrip_Out
End If

li_find = 0
For i = 1 To dw_kbno_info.RowCount()
	ls_kbno	= Trim(dw_kbno_info.GetItemString(i, "KBNo"))
	If ls_kbno	= Data Then
		li_find	= 1
		ls_kbreleasedate	= Trim(dw_kbno_info.GetItemString(i, "KBReleaseDate"))
		li_kbreleaseseq	= dw_kbno_info.GetItemNumber(i, "KBReleaseSeq")
		Exit
	Else
		li_find	= 0
	End If
Next

If li_find = 1 Then
	//
Else
	MessageBox("미준수간판 등록", "입력하신 간판번호는 조회된 지시내역에 존재하지 않습니다." + &
								"~r~n~r~n다른 간판을 입력하십시오.", &
								StopSign!)
	GoTo Scrip_Out
End If

If MessageBox("미준수간판 등록", "입력하신 간판을 미준수처리 하시겠습니까?", &
					Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False
dw_save.ReSet()
If dw_save.Retrieve(	uo_date.is_uo_date, &
							ls_kbno,							ls_kbreleasedate, &
							li_kbreleaseseq, &
							uo_code.is_uo_codegroup,	uo_code.is_uo_codeid, &
							g_s_empno) > 0 Then
	If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
		lb_error	= False
		ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
	Else
		lb_error = True
		ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
	End If
Else
	lb_error = True
	ls_errortext	= "미준수간판 등록을 시도하였지만 오류가 발생했습니다."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	st_msg.Text = "미준수간판을 저장하는 중에 오류 발생하였습니다."
	MessageBox("미준수간판 등록","미준수간판을 저장하는 중에 오류 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	st_msg.Text = "미준수간판을 저장하였습니다."
	MessageBox("미준수간판 등록", "미준수간판을 저장하였습니다.", Information!)
	wf_retrieve()
End If

Scrip_Out:

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type uo_line from u_pisc_select_line within w_pisp092u
integer x = 2619
integer y = 64
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	wf_retrieve()
End If
end event

type cb_1 from commandbutton within w_pisp092u
integer x = 3278
integer y = 56
integer width = 544
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "미준수이력(&R)"
end type

event clicked;wf_retrieve()
end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp092u
integer x = 1929
integer y = 64
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
	wf_retrieve()
End If
end event

type uo_division from u_pisc_select_division within w_pisp092u
integer x = 1307
integer y = 64
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_kbno_info.SetTransObject(SQLPIS)
	dw_unobserve.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											False, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
	
	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PUNOBSERVE', &
											'%', &
											False, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
	wf_retrieve()
End If

end event

type uo_area from u_pisc_select_area within w_pisp092u
integer x = 814
integer y = 64
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_kbno_info.SetTransObject(SQLPIS)
	dw_unobserve.SetTransObject(SQLPIS)
	dw_save.SetTransObject(SQLPIS)
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											False, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											False, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
	
	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PUNOBSERVE', &
											'%', &
											False, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
	wf_retrieve()
End If
end event

type gb_1 from groupbox within w_pisp092u
integer x = 14
integer width = 759
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_save from datawindow within w_pisp092u
integer x = 2162
integer y = 1084
integer width = 823
integer height = 368
boolean bringtotop = true
boolean titlebar = true
string title = "미준수 간판 등록"
string dataobject = "d_pisp092u_03_u"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_2 from groupbox within w_pisp092u
integer x = 3223
integer width = 1070
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_unobserve from datawindow within w_pisp092u
event ue_check pbm_custom01
integer x = 2080
integer y = 544
integer width = 2181
integer height = 1612
string title = "none"
string dataobject = "d_pisp092u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_check;//Int		i, li_checkcount
//String	ls_checkflag
//
//AcceptText()
//
//For i = 1 To RowCount()
//	ls_checkflag	= Trim(GetItemString(i, "CheckFlag"))
//	If ls_checkflag = "Y" Then
//		li_checkcount = li_checkcount + 1
//	End If
//Next
//
//If li_checkcount > 0 Then
//	ib_check		= True
//	cb_2.Enabled	= True
//	If li_checkcount = RowCount() Then
//		cbx_1.Checked	= True
//	Else
//		cbx_1.Checked	= False
//	End If
//Else	
//	ib_check		= False
//	cb_2.Enabled	= False
//	cbx_1.Checked	= False
//End If
end event

event constructor;//Visible	= False
end event

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

event itemchanged;
//AcceptText()
//
//If row > 0 Then
//	If Upper(string(dwo.name)) = "CHECKFLAG" Then
//		PostEvent("ue_check")
////		wf_set_check()
//	End If
//End If
end event

type gb_4 from groupbox within w_pisp092u
integer x = 777
integer width = 1115
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_5 from groupbox within w_pisp092u
integer x = 1897
integer width = 1321
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_6 from groupbox within w_pisp092u
integer x = 823
integer y = 200
integer width = 1221
integer height = 248
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "간판 Scanning"
borderstyle borderstyle = stylelowered!
end type

type gb_8 from groupbox within w_pisp092u
integer x = 14
integer y = 200
integer width = 805
integer height = 248
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "미준수 원인"
borderstyle borderstyle = stylelowered!
end type

type gb_7 from groupbox within w_pisp092u
integer x = 14
integer y = 472
integer width = 2030
integer height = 1712
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "지시 상태 간판 (미준수 회수 가능 간판 정보)"
borderstyle borderstyle = stylelowered!
end type

type gb_9 from groupbox within w_pisp092u
integer x = 2053
integer y = 472
integer width = 2240
integer height = 1712
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "미준수 간판"
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp092u
integer x = 2048
integer y = 200
integer width = 2245
integer height = 248
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

