$PBExportHeader$w_pisp005u.srw
$PBExportComments$조립지시 순서 변경
forward
global type w_pisp005u from window
end type
type dw_save from datawindow within w_pisp005u
end type
type em_changecount from editmask within w_pisp005u
end type
type ddlb_changeorder from dropdownlistbox within w_pisp005u
end type
type st_14 from statictext within w_pisp005u
end type
type st_13 from statictext within w_pisp005u
end type
type st_12 from statictext within w_pisp005u
end type
type st_kbcount from statictext within w_pisp005u
end type
type st_8 from statictext within w_pisp005u
end type
type st_11 from statictext within w_pisp005u
end type
type st_10 from statictext within w_pisp005u
end type
type st_cycleorder from statictext within w_pisp005u
end type
type st_modelid from statictext within w_pisp005u
end type
type st_7 from statictext within w_pisp005u
end type
type st_rackqty from statictext within w_pisp005u
end type
type st_productgubun from statictext within w_pisp005u
end type
type st_item from statictext within w_pisp005u
end type
type st_line from statictext within w_pisp005u
end type
type st_5 from statictext within w_pisp005u
end type
type st_4 from statictext within w_pisp005u
end type
type st_3 from statictext within w_pisp005u
end type
type st_2 from statictext within w_pisp005u
end type
type st_1 from statictext within w_pisp005u
end type
type st_workcenter from statictext within w_pisp005u
end type
type cb_1 from commandbutton within w_pisp005u
end type
type cb_2 from commandbutton within w_pisp005u
end type
type gb_1 from groupbox within w_pisp005u
end type
type gb_2 from groupbox within w_pisp005u
end type
type st_9 from statictext within w_pisp005u
end type
type gb_3 from groupbox within w_pisp005u
end type
end forward

global type w_pisp005u from window
integer width = 2661
integer height = 1552
boolean titlebar = true
string title = "지시순서 변경"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
dw_save dw_save
em_changecount em_changecount
ddlb_changeorder ddlb_changeorder
st_14 st_14
st_13 st_13
st_12 st_12
st_kbcount st_kbcount
st_8 st_8
st_11 st_11
st_10 st_10
st_cycleorder st_cycleorder
st_modelid st_modelid
st_7 st_7
st_rackqty st_rackqty
st_productgubun st_productgubun
st_item st_item
st_line st_line
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
st_workcenter st_workcenter
cb_1 cb_1
cb_2 cb_2
gb_1 gb_1
gb_2 gb_2
st_9 st_9
gb_3 gb_3
end type
global w_pisp005u w_pisp005u

type variables
Boolean		ib_open, ib_save
str_parms	istr_parms
end variables

event ue_postopen;Int	i

dw_save.SetTransObject(SQLPIS)

st_workcenter.Text	= Left(istr_parms.string_arg[5] + Space(12), 12) + istr_parms.string_arg[6]
st_line.Text			= Left(istr_parms.string_arg[7] + Space(12), 12) + istr_parms.string_arg[8]
st_item.Text			= Left(istr_parms.string_arg[9] + Space(12), 12) + istr_parms.string_arg[10]
st_modelid.Text		= istr_parms.string_arg[11]
st_productgubun.Text	= istr_parms.string_arg[12]
st_rackqty.Text		= istr_parms.string_arg[13] + " 개"
//st_planqty.Text		= istr_parms.string_arg[14] + " 개"

st_cycleorder.Text	= istr_parms.string_arg[15]
st_kbcount.Text		= istr_parms.string_arg[16]	//이동 가능 매수


em_changecount.Text		= istr_parms.string_arg[16]

For i = 1 To Integer(istr_parms.string_arg[17])
	ddlb_changeorder.InsertItem(String(i), i)
Next

ddlb_changeorder.Text = "1"

ib_open = True
end event

on w_pisp005u.create
this.dw_save=create dw_save
this.em_changecount=create em_changecount
this.ddlb_changeorder=create ddlb_changeorder
this.st_14=create st_14
this.st_13=create st_13
this.st_12=create st_12
this.st_kbcount=create st_kbcount
this.st_8=create st_8
this.st_11=create st_11
this.st_10=create st_10
this.st_cycleorder=create st_cycleorder
this.st_modelid=create st_modelid
this.st_7=create st_7
this.st_rackqty=create st_rackqty
this.st_productgubun=create st_productgubun
this.st_item=create st_item
this.st_line=create st_line
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.st_workcenter=create st_workcenter
this.cb_1=create cb_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.st_9=create st_9
this.gb_3=create gb_3
this.Control[]={this.dw_save,&
this.em_changecount,&
this.ddlb_changeorder,&
this.st_14,&
this.st_13,&
this.st_12,&
this.st_kbcount,&
this.st_8,&
this.st_11,&
this.st_10,&
this.st_cycleorder,&
this.st_modelid,&
this.st_7,&
this.st_rackqty,&
this.st_productgubun,&
this.st_item,&
this.st_line,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.st_workcenter,&
this.cb_1,&
this.cb_2,&
this.gb_1,&
this.gb_2,&
this.st_9,&
this.gb_3}
end on

on w_pisp005u.destroy
destroy(this.dw_save)
destroy(this.em_changecount)
destroy(this.ddlb_changeorder)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_kbcount)
destroy(this.st_8)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_cycleorder)
destroy(this.st_modelid)
destroy(this.st_7)
destroy(this.st_rackqty)
destroy(this.st_productgubun)
destroy(this.st_item)
destroy(this.st_line)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_workcenter)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.st_9)
destroy(this.gb_3)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type dw_save from datawindow within w_pisp005u
integer x = 1353
integer y = 92
integer width = 1129
integer height = 496
boolean titlebar = true
string title = "none"
string dataobject = "d_pisp005u_01_u"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type em_changecount from editmask within w_pisp005u
integer x = 1801
integer y = 976
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type ddlb_changeorder from dropdownlistbox within w_pisp005u
integer x = 1801
integer y = 828
integer width = 297
integer height = 492
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_14 from statictext within w_pisp005u
integer x = 1495
integer y = 988
integer width = 293
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "변경매수:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_13 from statictext within w_pisp005u
integer x = 1495
integer y = 844
integer width = 293
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "지시순서:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_12 from statictext within w_pisp005u
integer x = 1157
integer y = 912
integer width = 251
integer height = 200
integer textsize = -36
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "=>"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_kbcount from statictext within w_pisp005u
integer x = 654
integer y = 936
integer width = 343
integer height = 200
integer textsize = -36
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 16777215
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_8 from statictext within w_pisp005u
integer x = 626
integer y = 896
integer width = 379
integer height = 280
integer textsize = -36
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 16777215
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_11 from statictext within w_pisp005u
integer x = 626
integer y = 820
integer width = 398
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "이동가능매수"
boolean focusrectangle = false
end type

type st_10 from statictext within w_pisp005u
integer x = 183
integer y = 820
integer width = 283
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "지시순서"
boolean focusrectangle = false
end type

type st_cycleorder from statictext within w_pisp005u
integer x = 133
integer y = 940
integer width = 343
integer height = 200
integer textsize = -36
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 16777215
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_modelid from statictext within w_pisp005u
integer x = 384
integer y = 388
integer width = 2103
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "식별ID"
boolean focusrectangle = false
end type

type st_7 from statictext within w_pisp005u
integer x = 59
integer y = 388
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "식별ID:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_rackqty from statictext within w_pisp005u
integer x = 384
integer y = 572
integer width = 2103
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "수용수"
boolean focusrectangle = false
end type

type st_productgubun from statictext within w_pisp005u
integer x = 379
integer y = 480
integer width = 2103
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "제품구분"
boolean focusrectangle = false
end type

type st_item from statictext within w_pisp005u
integer x = 384
integer y = 296
integer width = 2103
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "제품"
boolean focusrectangle = false
end type

type st_line from statictext within w_pisp005u
integer x = 384
integer y = 204
integer width = 2103
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "라인"
boolean focusrectangle = false
end type

type st_5 from statictext within w_pisp005u
integer x = 59
integer y = 572
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "수용수:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_pisp005u
integer x = 59
integer y = 480
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "제품구분:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_pisp005u
integer x = 59
integer y = 296
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "제품:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisp005u
integer x = 59
integer y = 204
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "라인:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisp005u
integer x = 59
integer y = 112
integer width = 302
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "조:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_workcenter from statictext within w_pisp005u
integer x = 384
integer y = 112
integer width = 2103
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "조"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_pisp005u
integer x = 1810
integer y = 1308
integer width = 384
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저  장(&S)"
end type

event clicked;Int		li_count, li_cycleorder, li_plankbcount, li_changeorder, li_changekbcount
Boolean	lb_error
String	ls_errortext

li_cycleorder		= Integer(istr_parms.string_arg[15])
li_plankbcount		= Integer(istr_parms.string_arg[16])
li_changeorder		= Integer(Trim(ddlb_changeorder.Text))
li_changekbcount	= Integer(Trim(em_changecount.Text))

If li_cycleorder = li_changeorder Then
	MessageBox("지시순서 변경", "동일한 지시 순서로 변경할 수 없습니다.")
	Return
End If

If li_changekbcount > li_plankbcount Then
	MessageBox("지시순서 변경", "지시 매수보다 많은 간판매수를 변경할 수 없습니다.")
	Return
End If

// 지시를 앞으로 이동시킬 경우
// 만약 그 사이에 이미 조립완료된 간판이 하나라도 있으면
// 이동 불가능..
If li_cycleorder > li_changeorder Then
	li_count = 0
	Select	Count(PlanDate)
	Into		:li_count
	From		tplanrelease
	Where		PlanDate			= :istr_parms.string_arg[2]	And
				AreaCode			= :istr_parms.string_arg[3]	And
				DivisionCode	= :istr_parms.string_arg[4]	And
				WorkCenter		= :istr_parms.string_arg[5]	And
				LineCode			= :istr_parms.string_arg[7]	And
				(CycleOrder		Between :li_changeorder	And (:li_cycleorder - 1)) And
				PrdFlag			In ('E')
	Using SQLPIS;
	
	If li_count > 0 Then
		MessageBox("지시순서 변경", "변경하려는 지시 순번 사이에 이미 조립완료된 간판이 존재합니다." + &
											"~r~n~r~n조립완료된 간판의 지시순서는 변경이 불가능 합니다.")
		Return
	End If
Else
	li_count = 0
	Select	Count(PlanDate)
	Into		:li_count
	From		tplanrelease
	Where		PlanDate			= :istr_parms.string_arg[2]	And
				AreaCode			= :istr_parms.string_arg[3]	And
				DivisionCode	= :istr_parms.string_arg[4]	And
				WorkCenter		= :istr_parms.string_arg[5]	And
				LineCode			= :istr_parms.string_arg[7]	And
				(CycleOrder		Between :li_cycleorder	And :li_changeorder) And
				ReleaseGubun	In ('U')
	Using SQLPIS;
	
	If li_count > 0 Then
		MessageBox("지시순서 변경", "변경하려는 지시 순번 사이에 무간판 생산/입고 등록된 간판이 존재합니다." + &
											"~r~n~r~n무간판 생산/입고 등록된 간판의 지시순서는 변경이 불가능 합니다.")
		Return
	End If
End If

// 이미 조립완료된 간판이 있는 경우
// 조립완료 되지 않은 지시상태의 간판 매수만 이동할 수 있다.
li_count = 0
Select	Count(PlanDate)
Into		:li_count
From		tplanrelease
Where		PlanDate			= :istr_parms.string_arg[2]	And
			AreaCode			= :istr_parms.string_arg[3]	And
			DivisionCode	= :istr_parms.string_arg[4]	And
			WorkCenter		= :istr_parms.string_arg[5]	And
			LineCode			= :istr_parms.string_arg[7]	And
			CycleOrder		= :li_cycleorder	And
			PrdFlag			In ('E')
Using SQLPIS;

If li_count > 0 Then
	If li_changekbcount > li_count Then
		MessageBox("지시순서 변경", "선택하신 지시는" + String(li_count) + " 매의 간판이 조립완료된 상태입니다." + &
										"~r~n~r~n최대 " + &
										String(li_plankbcount - li_count) + &
										" 매의 간판만 지시 순서를 변경할 수 있습니다.")
		Return
	End If
End If

//
If MessageBox("지시순서 변경", "지시순서를 변경하시겠습니까?", &
							Question!, YesNo!, 2) = 2 Then
	Return
End If

dw_save.ReSet()

SQLPIS.AutoCommit = False

If dw_save.Retrieve(istr_parms.string_arg[2], &
					istr_parms.string_arg[3],					istr_parms.string_arg[4], &
					istr_parms.string_arg[5],					istr_parms.string_arg[7], &
					li_cycleorder,									li_plankbcount, &
					li_changeorder,								li_changekbcount, &
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
	ls_errortext	= "지시순서 변경을 시도하였지만 오류가 발생했습니다."
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("지시순서 변경","지시순서를 변경하는 중에 오류가 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	MessageBox("지시순서 변경", "지시순서를 변경하였습니다.", Information!)
	cb_2.TriggerEvent(Clicked!)
End If
end event

type cb_2 from commandbutton within w_pisp005u
integer x = 2203
integer y = 1308
integer width = 384
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종  료(&C)"
end type

event clicked;If ib_save Then
	CloseWithReturn(Parent, "CHANGE")
Else
	CloseWithReturn(Parent, "CANCEL")
End If
end event

type gb_1 from groupbox within w_pisp005u
integer x = 23
integer y = 16
integer width = 2560
integer height = 672
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "선택 제품 정보"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp005u
integer x = 1458
integer y = 720
integer width = 1125
integer height = 548
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "변경 정보"
borderstyle borderstyle = stylelowered!
end type

type st_9 from statictext within w_pisp005u
integer x = 119
integer y = 896
integer width = 379
integer height = 280
integer textsize = -36
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 16777215
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_pisp005u
integer x = 23
integer y = 720
integer width = 1111
integer height = 548
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "지시 정보"
borderstyle borderstyle = stylelowered!
end type

