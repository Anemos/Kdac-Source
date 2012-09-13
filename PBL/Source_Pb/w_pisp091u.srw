$PBExportHeader$w_pisp091u.srw
$PBExportComments$조립지시 - 조립지시 취소
forward
global type w_pisp091u from window
end type
type st_cancelcount from statictext within w_pisp091u
end type
type st_plancount from statictext within w_pisp091u
end type
type cbx_1 from checkbox within w_pisp091u
end type
type dw_kbno from u_pisp_kbno_scan within w_pisp091u
end type
type dw_kbno_info from datawindow within w_pisp091u
end type
type dw_save from datawindow within w_pisp091u
end type
type st_possiblecount from statictext within w_pisp091u
end type
type st_releasecount from statictext within w_pisp091u
end type
type st_modelid from statictext within w_pisp091u
end type
type st_7 from statictext within w_pisp091u
end type
type st_rackqty from statictext within w_pisp091u
end type
type st_productgubun from statictext within w_pisp091u
end type
type st_item from statictext within w_pisp091u
end type
type st_line from statictext within w_pisp091u
end type
type st_5 from statictext within w_pisp091u
end type
type st_4 from statictext within w_pisp091u
end type
type st_3 from statictext within w_pisp091u
end type
type st_2 from statictext within w_pisp091u
end type
type st_1 from statictext within w_pisp091u
end type
type st_workcenter from statictext within w_pisp091u
end type
type cb_1 from commandbutton within w_pisp091u
end type
type cb_2 from commandbutton within w_pisp091u
end type
type gb_1 from groupbox within w_pisp091u
end type
type gb_2 from groupbox within w_pisp091u
end type
type gb_3 from groupbox within w_pisp091u
end type
type gb_4 from groupbox within w_pisp091u
end type
type gb_5 from groupbox within w_pisp091u
end type
end forward

global type w_pisp091u from window
integer width = 2962
integer height = 1932
boolean titlebar = true
string title = "조립지시 취소"
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
event ue_postopen ( )
st_cancelcount st_cancelcount
st_plancount st_plancount
cbx_1 cbx_1
dw_kbno dw_kbno
dw_kbno_info dw_kbno_info
dw_save dw_save
st_possiblecount st_possiblecount
st_releasecount st_releasecount
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
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
end type
global w_pisp091u w_pisp091u

type variables
Boolean		ib_open, ib_save
str_parms	istr_parms
Int			ii_cycleorder, ii_possiblecount
end variables

forward prototypes
public subroutine wf_dw_retrieve ()
end prototypes

event ue_postopen;
dw_save.SetTransObject(SQLPIS)
dw_kbno_info.SetTransObject(SQLPIS)

st_workcenter.Text	= Left(istr_parms.string_arg[5] + Space(12), 12) + istr_parms.string_arg[6]
st_line.Text			= Left(istr_parms.string_arg[7] + Space(12), 12) + istr_parms.string_arg[8]
st_item.Text			= Left(istr_parms.string_arg[9] + Space(12), 12) + istr_parms.string_arg[10]
st_modelid.Text		= istr_parms.string_arg[11]
st_productgubun.Text	= istr_parms.string_arg[12]
st_rackqty.Text		= istr_parms.string_arg[13] + " 개"

ii_cycleorder			= Integer(istr_parms.string_arg[14])

//	istr_parms.string_arg[1] = is_size
//	istr_parms.string_arg[2] = uo_date.is_uo_date
//	istr_parms.string_arg[3] = Trim(dw_1.GetItemString(li_row, "AreaCode"))
//	istr_parms.string_arg[4] = Trim(dw_1.GetItemString(li_row, "DivisionCode"))
//	istr_parms.string_arg[5] = Trim(dw_1.GetItemString(li_row, "WorkCenter"))
//	istr_parms.string_arg[6] = Trim(dw_1.GetItemString(li_row, "WorkCenterName"))
//	istr_parms.string_arg[7] = Trim(dw_1.GetItemString(li_row, "LineCode"))
//	istr_parms.string_arg[8] = Trim(dw_1.GetItemString(li_row, "LineFullName"))
//	istr_parms.string_arg[9] = Trim(dw_1.GetItemString(li_row, "ItemCode"))
//	istr_parms.string_arg[10] = Trim(dw_1.GetItemString(li_row, "ItemName"))
//	istr_parms.string_arg[11] = Trim(dw_1.GetItemString(li_row, "ModelID"))
//	istr_parms.string_arg[12] = Trim(dw_1.GetItemString(li_row, "ProductGubunName"))
//	istr_parms.string_arg[13] = String(dw_1.GetItemNumber(li_row, "RackQty"))
//	istr_parms.string_arg[14] = String(dw_1.GetItemNumber(li_row, "CycleOrder"))
//	istr_parms.string_arg[15] = String(li_plankbcount)
wf_dw_retrieve()

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()

ib_open = True
end event

public subroutine wf_dw_retrieve ();Int	i

cb_1.Enabled	= False
cbx_1.Checked	= False

dw_save.ReSet()
dw_kbno_info.ReSet()
ii_possiblecount	= 0

dw_kbno_info.Retrieve(istr_parms.string_arg[2], &
							istr_parms.string_arg[3],		istr_parms.string_arg[4], &
							istr_parms.string_arg[5],		istr_parms.string_arg[7], &
							ii_cycleorder)

If dw_kbno_info.RowCount() > 0 Then
	For i = 1 To dw_kbno_info.RowCount()
//		If Trim(dw_kbno_info.GetItemString(i, "PrdFlag")) = "N" And + &
//				((Trim(dw_kbno_info.GetItemString(i, "ReleaseGubun")) = "Y") Or (Trim(dw_kbno_info.GetItemString(i, "ReleaseGubun"))) = "T") Then
//			ii_possiblecount	= ii_possiblecount + 1
//		End If
//	미준수 간판도 취소하자.
		If Trim(dw_kbno_info.GetItemString(i, "PrdFlag")) = "N" Then
			ii_possiblecount	= ii_possiblecount + 1
		End If
	Next
End If

st_plancount.Text		= "     계획 매수:  " + istr_parms.string_arg[15] + " 매"
st_releasecount.Text	= "     지시 매수:  " + String(dw_kbno_info.RowCount()) + " 매"
st_possiblecount.Text	= "취소 가능 매수:  " + String(ii_possiblecount) + " 매"
st_cancelcount.Text		= "지시 취소 매수:  " + String(0) + " 매"
end subroutine

on w_pisp091u.create
this.st_cancelcount=create st_cancelcount
this.st_plancount=create st_plancount
this.cbx_1=create cbx_1
this.dw_kbno=create dw_kbno
this.dw_kbno_info=create dw_kbno_info
this.dw_save=create dw_save
this.st_possiblecount=create st_possiblecount
this.st_releasecount=create st_releasecount
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
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.Control[]={this.st_cancelcount,&
this.st_plancount,&
this.cbx_1,&
this.dw_kbno,&
this.dw_kbno_info,&
this.dw_save,&
this.st_possiblecount,&
this.st_releasecount,&
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
this.gb_3,&
this.gb_4,&
this.gb_5}
end on

on w_pisp091u.destroy
destroy(this.st_cancelcount)
destroy(this.st_plancount)
destroy(this.cbx_1)
destroy(this.dw_kbno)
destroy(this.dw_kbno_info)
destroy(this.dw_save)
destroy(this.st_possiblecount)
destroy(this.st_releasecount)
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
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
end on

event open;String		ls_size

//Pareant Window의 중앙으로 Window를 이동시키기 위하여 Parent Window의 X,Y,Width,Height 값을 구한다.
istr_parms	= Message.PowerObjectParm

ls_size				= istr_parms.string_arg[1]

f_pisc_win_move(This, ls_size)

Show()

PostEvent("ue_postopen")
end event

type st_cancelcount from statictext within w_pisp091u
integer x = 1874
integer y = 1400
integer width = 914
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "지시 취소 매수:"
boolean focusrectangle = false
end type

type st_plancount from statictext within w_pisp091u
integer x = 1874
integer y = 1136
integer width = 914
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "     계획 매수:"
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_pisp091u
integer x = 1883
integer y = 944
integer width = 786
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388736
long backcolor = 12632256
string text = "간판 전체 지시 취소"
borderstyle borderstyle = stylelowered!
end type

event clicked;Int		i, li_checkcount

If dw_kbno_info.RowCount() > 0 Then
	If cbx_1.Checked = False Then
		li_checkcount		= 0
		For i = 1 To dw_kbno_info.RowCount()
			If Trim(dw_kbno_info.GetItemString(i, "PrdFlag")) = "N" And + &
					((Trim(dw_kbno_info.GetItemString(i, "ReleaseGubun")) = "Y") Or (Trim(dw_kbno_info.GetItemString(i, "ReleaseGubun"))) = "T") Then
				dw_kbno_info.SetItem(i, "CheckFlag", "N")
			End If
		Next
	Else
		For i = 1 To dw_kbno_info.RowCount()
			If Trim(dw_kbno_info.GetItemString(i, "PrdFlag")) = "N" And + &
					((Trim(dw_kbno_info.GetItemString(i, "ReleaseGubun")) = "Y") Or (Trim(dw_kbno_info.GetItemString(i, "ReleaseGubun"))) = "T") Then
				dw_kbno_info.SetItem(i, "CheckFlag", "Y")
				li_checkcount		= li_checkcount + 1
			End If
		Next
	End If
End If

If li_checkcount > 0 Then
	cbx_1.Checked	= True
	cb_1.Enabled	= True
Else
	cbx_1.Checked	= False
	cb_1.Enabled	= False
End If

st_cancelcount.Text		= "지시 취소 매수:  " + String(li_checkcount) + " 매"

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()

end event

type dw_kbno from u_pisp_kbno_scan within w_pisp091u
integer x = 1801
integer y = 672
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

event itemchanged;call super::itemchanged;Int		i, li_checkcount
String	ls_kbno

If Len(Data) <> 11 Then
	f_pisc_beep()
	MessageBox("조립지시 취소","간판번호는 12자리 입니다.~r~n정확한 간판 번호를 입력하십시오.")
	Return
End If

For i = 1 To dw_kbno_info.RowCount()
	If Trim(dw_kbno_info.GetItemString(i, "CheckFlag")) = "Y" Then
		li_checkcount	= li_checkcount + 1
	End If

//	If Trim(GetItemString(i, "PrdFlag")) = "N" And + &
//			((Trim(GetItemString(i, "ReleaseGubun")) = "Y") Or (Trim(GetItemString(i, "ReleaseGubun"))) = "T") Then
//		li_possiblecount	= li_possiblecount + 1
//	End If

	ls_kbno	= Trim(dw_kbno_info.GetItemString(i, "KBNo"))

	If ls_kbno	= Data Then
		If Trim(dw_kbno_info.GetItemString(i, "CheckFlag")) = "N" Then
			dw_kbno_info.SetItem(i, "CheckFlag", "Y")
			li_checkcount = li_checkcount + 1
		Else
			dw_kbno_info.SetItem(i, "CheckFlag", "N")
			li_checkcount = li_checkcount - 1
		End If
	End If
Next

//li_checkcount	= li_totalcount + li_checkcount

If li_checkcount > 0 Then
//	ib_change		= True
	cb_1.Enabled	= True
	If li_checkcount = ii_possiblecount Then
		cbx_1.Checked	= True
	Else
		cbx_1.Checked	= False
	End If
Else	
//	ib_change		= False
	cb_1.Enabled	= False
	cbx_1.Checked	= False
End If

st_cancelcount.Text		= "지시 취소 매수:  " + String(li_checkcount) + " 매"

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()
end event

type dw_kbno_info from datawindow within w_pisp091u
event ue_check ( integer fi_row )
integer x = 23
integer y = 628
integer width = 1733
integer height = 1184
string title = "none"
string dataobject = "d_pisp091u_01"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event ue_check;Int		i, li_checkcount
String	ls_checkflag

AcceptText()

If Trim(GetItemString(fi_row, "PrdFlag")) = "N" Then
	//
Else
	SetItem(fi_row, "CheckFlag", "N")
	Return
End If

For i = 1 To RowCount()
	ls_checkflag	= Trim(GetItemString(i, "CheckFlag"))
	If ls_checkflag = "Y" Then
		li_checkcount = li_checkcount + 1
	End If
Next

If li_checkcount > 0 Then
//	ib_change		= True
	cb_1.Enabled	= True
	If li_checkcount = ii_possiblecount Then
		cbx_1.Checked	= True
	Else
		cbx_1.Checked	= False
	End If
Else	
//	ib_change		= False
	cb_1.Enabled	= False
	cbx_1.Checked	= False
End If

st_cancelcount.Text		= "지시 취소 매수:  " + String(li_checkcount) + " 매"

dw_kbno.Reset()
dw_kbno.InsertRow(1)
dw_kbno.SetColumn(1)
dw_kbno.SetRow(1)
dw_kbno.SetFocus()

end event

event rowfocuschanged;If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
End If
end event

event itemchanged;AcceptText()

If row > 0 Then
	If Upper(string(dwo.name)) = "CHECKFLAG" Then
		Post Event ue_check(row)
	End If
End If
end event

type dw_save from datawindow within w_pisp091u
integer x = 1353
integer y = 92
integer width = 1129
integer height = 496
boolean titlebar = true
string title = "none"
string dataobject = "d_pisp091u_02_u"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

type st_possiblecount from statictext within w_pisp091u
integer x = 1874
integer y = 1312
integer width = 914
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8421504
long backcolor = 12632256
string text = "취소 가능 매수:"
boolean focusrectangle = false
end type

type st_releasecount from statictext within w_pisp091u
integer x = 1874
integer y = 1224
integer width = 914
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "     지시 매수:"
boolean focusrectangle = false
end type

type st_modelid from statictext within w_pisp091u
integer x = 384
integer y = 364
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

type st_7 from statictext within w_pisp091u
integer x = 59
integer y = 364
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

type st_rackqty from statictext within w_pisp091u
integer x = 384
integer y = 532
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

type st_productgubun from statictext within w_pisp091u
integer x = 379
integer y = 448
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

type st_item from statictext within w_pisp091u
integer x = 384
integer y = 280
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

type st_line from statictext within w_pisp091u
integer x = 384
integer y = 196
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

type st_5 from statictext within w_pisp091u
integer x = 59
integer y = 532
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

type st_4 from statictext within w_pisp091u
integer x = 59
integer y = 448
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

type st_3 from statictext within w_pisp091u
integer x = 59
integer y = 280
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

type st_2 from statictext within w_pisp091u
integer x = 59
integer y = 196
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

type st_1 from statictext within w_pisp091u
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

type st_workcenter from statictext within w_pisp091u
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

type cb_1 from commandbutton within w_pisp091u
integer x = 1883
integer y = 1608
integer width = 398
integer height = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "저 장(&S)"
end type

event clicked;Int		i, li_cycleorder, li_releaseorder, li_kbreleaseseq
String	ls_releasedate, ls_kbno, ls_kbreleasedate, ls_errortext
Boolean	lb_error

If MessageBox("조립지시 취소", "선택한 간판의 조립지시를 취소하시겠습니까?", &
							Question!, YesNo!, 2) = 2 Then
	Return
End If

ls_releasedate	= istr_parms.string_arg[2]

SQLPIS.AutoCommit = False

If dw_kbno_info.RowCount() > 0 Then
	For i = 1 To dw_kbno_info.RowCount()
		// 미준수 간판도 취소 하자.
		If Trim(dw_kbno_info.GetItemString(i, "PrdFlag")) = "N" Then
//		If Trim(dw_kbno_info.GetItemString(i, "PrdFlag")) = "N" And + &
//				((Trim(dw_kbno_info.GetItemString(i, "ReleaseGubun")) = "Y") Or (Trim(dw_kbno_info.GetItemString(i, "ReleaseGubun"))) = "T") Then
			If Trim(dw_kbno_info.GetItemString(i, "CheckFlag")) = "Y" Then
//				li_cycleorder		= dw_kbno_info.GetItemNumber(i, "CycleOrder")
//				li_releaseorder	= dw_kbno_info.GetItemNumber(i, "ReleaseOrder")
				ls_kbno				= Trim(dw_kbno_info.GetItemString(i, "KBNo"))
				ls_kbreleasedate	= Trim(dw_kbno_info.GetItemString(i, "KBReleaseDate"))
				li_kbreleaseseq	= dw_kbno_info.GetItemNumber(i, "KBReleaseSeq")
				
				// 만약 2개 이상을 선택하구 동시에 취소를 수행하면
				// 앞에 있는 것을 취소하면서 지시순서를 변경하게 된다.
				// 이경우 뒤에 있는 간판의 경우 조회되어 있는 지시 순서가...
				// 앞에 있는 것을 취소하면서 변경한 지시 순서와 다르게 되어 에러가 난다.
				// 따라서 바로 바로 DB 에서 순서를 가져오자...ㅅㅂ
				Select	CycleOrder,
							ReleaseOrder
				Into		:li_cycleorder,
							:li_releaseorder
				From		tplanrelease
				Where		KBNo				= :ls_kbno
				And		KBReleaseDate	= :ls_kbreleasedate
				And		KBReleaseSeq	= :li_kbreleaseseq
				Using	SQLPIS;
				
				dw_save.ReSet()
				If dw_save.Retrieve(ls_releasedate, &
										li_cycleorder, 		li_releaseorder,	&
										ls_kbno,					ls_kbreleasedate, &
										li_kbreleaseseq, 		g_s_empno) > 0 Then
					If Upper(dw_save.GetItemString(1, "Error")) = "00" Then
						lb_error	= False
						ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
					Else
						lb_error = True
						ls_errortext	= Trim(dw_save.GetItemString(1, "ErrorText"))
						Exit
					End If
				Else
					lb_error = True
					ls_errortext	= "조립지시 취소를 시도하였지만 오류가 발생했습니다."
					Exit
				End If
			End If
		End If	
	Next
End If

If lb_error Then
	RollBack Using SQLPIS;
	SQLPIS.AutoCommit = True
	MessageBox("조립지시 취소","간판번호 : " + ls_kbno + " 을 처리하는 중에 오류 발생하였습니다." + &
											"~r~n~r~n(참고)" + &
											"~r~n1. " + ls_errortext, StopSign!)
Else
	Commit Using SQLPIS;
	SQLPIS.AutoCommit = True
	ib_save	= True
	MessageBox("조립지시 취소", "조립지시 취소를 저장하였습니다.", Information!)
	wf_dw_retrieve()
End If
end event

type cb_2 from commandbutton within w_pisp091u
integer x = 2382
integer y = 1608
integer width = 398
integer height = 120
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

type gb_1 from groupbox within w_pisp091u
integer x = 23
integer y = 16
integer width = 2885
integer height = 600
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

type gb_2 from groupbox within w_pisp091u
integer x = 1765
integer y = 600
integer width = 1143
integer height = 260
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp091u
integer x = 1765
integer y = 848
integer width = 1143
integer height = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pisp091u
integer x = 1765
integer y = 1056
integer width = 1143
integer height = 452
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_5 from groupbox within w_pisp091u
integer x = 1765
integer y = 1496
integer width = 1143
integer height = 316
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

