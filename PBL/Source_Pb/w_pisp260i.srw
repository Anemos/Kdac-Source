$PBExportHeader$w_pisp260i.srw
$PBExportComments$간판 번호 정보
forward
global type w_pisp260i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp260i
end type
type dw_kbno from u_pisp_kbno_scan within w_pisp260i
end type
type cb_1 from commandbutton within w_pisp260i
end type
type dw_save from datawindow within w_pisp260i
end type
type gb_1 from groupbox within w_pisp260i
end type
type gb_2 from groupbox within w_pisp260i
end type
end forward

global type w_pisp260i from w_ipis_sheet01
integer width = 3675
string title = ""
dw_1 dw_1
dw_kbno dw_kbno
cb_1 cb_1
dw_save dw_save
gb_1 gb_1
gb_2 gb_2
end type
global w_pisp260i w_pisp260i

type variables
Boolean	ib_open
String	is_kbno

end variables

on w_pisp260i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_kbno=create dw_kbno
this.cb_1=create cb_1
this.dw_save=create dw_save
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_kbno
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_save
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
end on

on w_pisp260i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_kbno)
destroy(this.cb_1)
destroy(this.dw_save)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_1, FULL)
//
//of_resize()
//
//dw_2.Move(st_v_bar.X, st_v_bar.Y + st_v_bar.Height + 15)
//dw_2.Resize(dw_1.Width, newheight - dw_1.Y - dw_1.Height - 30)
il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_save.SetTransObject(SQLPIS)

cb_1.Enabled	= m_frame.m_action.m_save.Enabled

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()

ib_open = True
end event

event ue_retrieve;
iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(is_kbno) > 0 Then
	uo_status.st_message.text =  "간판 번호 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "간판 번호 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 번호 정보", "간판 상태 정보가 존재하지 않습니다")
End If

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_save.ReSet()

//dw_kbno.Reset()
//dw_kbno.InsertRow(1)
//dw_kbno.SetColumn(1)
//dw_kbno.SetRow(1)
//dw_kbno.SetFocus()
end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp260i
end type

type dw_1 from u_vi_std_datawindow within w_pisp260i
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 296
integer width = 1458
integer height = 1488
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp260i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;//

end event

event rowfocuschanged;//

end event

event ue_lbuttonup;//

end event

type dw_kbno from u_pisp_kbno_scan within w_pisp260i
integer x = 69
integer y = 104
integer taborder = 0
boolean bringtotop = true
end type

event ue_enter;call super::ue_enter;String	ls_kbno, ls_kbno_check
dwobject ldwo_this

ls_kbno_check	= Trim(GetItemString(1,1))
AcceptText()
ls_kbno			= Trim(GetItemString(1,1))

If ls_kbno_check <> ls_kbno Then
	Post Event ItemChanged(1, ldwo_this, ls_kbno)
End If
end event

event itemchanged;call super::itemchanged;Int	li_count

is_kbno	= Data

If Len(is_kbno) <> 11 Then
	f_pisc_beep()
	MessageBox("간판 번호 정보","간판번호는 11자리 입니다.~r~n정확한 간판 번호를 입력하십시오.")
	Return
End If

//li_count	= 0
//Select	Count(A.KBNo)
//Into		:li_count
//From		tkb		A
//Where		A.KBNo	= :is_kbno
//Using	SQLPIS;
//
//If li_count > 0 Then
//	//
//Else
//	f_pisc_beep()
//	MessageBox("간판 번호 정보", "입력하신 간판은 시스템에서 관리하지 않는 간판입니다." + &
//									"~r~n~r~n간판번호를 다시 한번 확인하여 주십시오.")
//	Return
//End If

iw_this.PostEvent("ue_retrieve")
end event

type cb_1 from commandbutton within w_pisp260i
integer x = 1275
integer y = 116
integer width = 704
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "간판정보 초기화(I)"
end type

event clicked;Int		li_count
String	ls_kbstatuscode, ls_error, ls_errortext
Boolean	lb_error

If Len(is_kbno) = 11 Then
	//
Else
	MessageBox("간판정보 초기화", "정확한 간판번호를 입력하십시오.", StopSign!)
	Return
End If

li_count	= 0
Select	Count(A.KBNo),
			A.KBStatusCode
Into		:li_count,
			:ls_kbstatuscode
From		tkb		A
Where		A.KBNo				= :is_kbno
Group By A.KBStatusCode
Using	SQLPIS;

If li_count > 0 Then
	//
Else
	f_pisc_beep()
	MessageBox("간판정보 초기화", "입력하신 간판은 간판번호 초기화를 수행할 수 없습니다." + &
									"~r~n~r~n간판번호 및 간판마스터를 다시 한번 확인하여 주십시오.")
	Return
End If

If ls_kbstatuscode = 'A' Then
	f_pisc_beep()
	MessageBox("간판정보 초기화", "입력하신 간판은 간판번호 초기화를 수행할 수 없습니다." + &
									"~r~n~r~n입력하신 간판은 지시 상태입니다.")
	Return
End If

If MessageBox("간판정보 초기화", "간판정보를 초기화하시려고 합니다." + &
										"~r~n~r~n입력하신 간판번호의 정보를 지시대기 상태로 초기화합니다." + &
										"~r~n~r~n간판정보를 초기화하시겠습니까?", &
											Question!, YesNo!, 2) = 2 Then
	Return
End If

SQLPIS.AutoCommit = False

dw_save.ReSet()
If dw_save.Retrieve(	is_kbno,		g_s_empno) > 0 Then
	If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
		lb_error	= False
		ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
	Else
		lb_error = True
		ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
	End If
Else
	lb_error = True
	ls_errortext	= "간판정보 초기화를 시도하였지만 오류가 발생했습니다."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("간판정보 초기화","간판정보 초기화를 저장하는 중에 오류 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("간판정보 초기화", "간판정보 초기화를 저장하였습니다.", Information!)
	iw_this.TriggerEvent("ue_retrieve")
End If
end event

type dw_save from datawindow within w_pisp260i
integer x = 1769
integer y = 544
integer width = 677
integer height = 388
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "저장"
string dataobject = "d_pisp260i_02_u"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type gb_1 from groupbox within w_pisp260i
integer x = 14
integer y = 28
integer width = 1175
integer height = 264
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "간판 입력"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp260i
integer x = 1193
integer y = 28
integer width = 864
integer height = 264
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

