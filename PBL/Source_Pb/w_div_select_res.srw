$PBExportHeader$w_div_select_res.srw
$PBExportComments$공장선택 Response Window(MRP용)
forward
global type w_div_select_res from window
end type
type st_7 from statictext within w_div_select_res
end type
type st_6 from statictext within w_div_select_res
end type
type cb_2 from commandbutton within w_div_select_res
end type
type cb_1 from commandbutton within w_div_select_res
end type
type st_1 from statictext within w_div_select_res
end type
type dw_2 from datawindow within w_div_select_res
end type
type dw_1 from datawindow within w_div_select_res
end type
type gb_1 from groupbox within w_div_select_res
end type
type st_8 from statictext within w_div_select_res
end type
end forward

global type w_div_select_res from window
integer width = 1929
integer height = 1532
boolean titlebar = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "Information!"
event open_after ( )
st_7 st_7
st_6 st_6
cb_2 cb_2
cb_1 cb_1
st_1 st_1
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
st_8 st_8
end type
global w_div_select_res w_div_select_res

type variables
Int	ii_Drag_Row
Str_Div	iStr_Div, iStr_AcceptDiv
String	is_RunCd
end variables

forward prototypes
public subroutine wf_delete_kunsan ()
public function string wf_getdivname (string as_xdiv[])
public subroutine wf_delete_nodiv (string as_xdiv[])
end prototypes

event open_after();String	ls_ConDivName

ls_ConDivName = wf_GetDivName( iStr_AcceptDiv.Xdiv )

String	ls_Message


Choose Case iStr_AcceptDiv.RunCd
	Case	'1'
		ls_Message = "생산계획확정이 안된 { " + ls_ConDivName + " }은 선택란에서 삭제됩니다."
		MessageBox("<확인>", ls_Message )
	Case	'2'
		ls_Message = "MRP 순소요량 계산이 안된 { " + ls_ConDivName + " }은 선택란에서 삭제됩니다."
		MessageBox("<확인>", ls_Message )
End Choose


wf_Delete_NoDiv( iStr_AcceptDiv.Xdiv )
end event

public subroutine wf_delete_kunsan ();Int	li_RowCnt, i

For i = 1 To 2
	li_RowCnt = dw_1.RowCount( )
	dw_1.DeleteRow(li_RowCnt)
Next
end subroutine

public function string wf_getdivname (string as_xdiv[]);Int	li_DivLimit

li_DivLimit = UpperBound( as_Xdiv )

String	ls_Xplant, ls_Div, ls_Compare, ls_ConDivName
Int	Row, i

For Row = 1 To dw_1.RowCount( )
	ls_Xplant =	dw_1.GetItemString( Row, "xplant" )
	ls_Div	 =	dw_1.GetItemString( Row, "div" )
	ls_Compare = ls_Xplant + ls_Div
	
	For i = 1 To li_DivLimit
		If as_Xdiv[i] = ls_Compare Then
			ls_ConDivName = ls_ConDivName + dw_1.GetItemString( Row, "divname" ) + ', ' 
			Exit
		End If
	Next
	
Next

Return	Left( ls_ConDivName, Len(ls_ConDivName) - 2 )
end function

public subroutine wf_delete_nodiv (string as_xdiv[]);Int	li_DivLimit

li_DivLimit = UpperBound( as_Xdiv )

Int	RowCount

RowCount = dw_1.RowCount( )

String	ls_Xplant, ls_Div, ls_Compare
Int	Row, i

For Row = 1 To RowCount 
	ls_Xplant =	dw_1.GetItemString( Row, "xplant" )
	ls_Div	 =	dw_1.GetItemString( Row, "div" )
	ls_Compare = ls_Xplant + ls_Div
	
	For i = 1 To li_DivLimit
		If as_Xdiv[i] = ls_Compare Then
			dw_1.DeleteRow( Row )
			Row --
			RowCount --
			Exit
		End If
	Next
	
Next
end subroutine

on w_div_select_res.create
this.st_7=create st_7
this.st_6=create st_6
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.st_8=create st_8
this.Control[]={this.st_7,&
this.st_6,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.dw_2,&
this.dw_1,&
this.gb_1,&
this.st_8}
end on

on w_div_select_res.destroy
destroy(this.st_7)
destroy(this.st_6)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.st_8)
end on

event activate;
f_Center_Window(This)
end event

event open;
iStr_AcceptDiv = Message.PowerObjectParm

If iStr_AcceptDiv.RunCD = '2' Then       // MRP 확정시 군산공장코드 불필요...
	wf_Delete_Kunsan( )
End If

Int	li_NoDivCnt

li_NoDivCnt = UpperBound( iStr_AcceptDiv.Xdiv )
If li_NoDivCnt <> 0 Then
	This.PostEvent( 'open_after' )
End If
end event

type st_7 from statictext within w_div_select_res
integer x = 265
integer y = 1204
integer width = 425
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long backcolor = 12639424
string text = "모두 취소"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;Integer	li_RowCnt, li_TargetRowCnt

li_RowCnt = dw_2.RowCount()
li_TargetRowCnt = dw_1.RowCount()

Integer i

For i = 1 To li_RowCnt
	dw_2.RowsMove( i, li_RowCnt, Primary!, dw_1, li_TargetRowCnt + 1, Primary!)
Next

cb_1.Enabled = False
			
end event

type st_6 from statictext within w_div_select_res
integer x = 1216
integer y = 332
integer width = 425
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long backcolor = 12639424
string text = "모두 선택"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
end type

event clicked;Integer	li_RowCnt, li_TargetRowCnt

li_RowCnt = dw_1.RowCount()
li_TargetRowCnt = dw_2.RowCount()

Integer i

For i = 1 To li_RowCnt
	dw_1.RowsMove( i, li_RowCnt, Primary!, dw_2, li_TargetRowCnt + 1, Primary!)
Next

cb_1.Enabled = True
			
end event

type cb_2 from commandbutton within w_div_select_res
integer x = 1568
integer y = 1304
integer width = 297
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "취소"
boolean cancel = true
end type

event clicked;
CloseWithReturn(Parent, -1)
end event

type cb_1 from commandbutton within w_div_select_res
integer x = 1234
integer y = 1304
integer width = 297
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
boolean enabled = false
string text = "확인"
boolean default = true
end type

event clicked;Str_div lStr_div
Int i, li_RowCnt
String ls_div[]

li_RowCnt = dw_2.RowCount()

For i = 1 To li_RowCnt
	lStr_div.Xdiv[i] = dw_2.Object.Xplant[i] + dw_2.Object.Div[i]
Next

CloseWithReturn(Parent, lStr_div)
end event

type st_1 from statictext within w_div_select_res
integer x = 192
integer y = 72
integer width = 1518
integer height = 152
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event constructor;This.SetFocus()
end event

type dw_2 from datawindow within w_div_select_res
event ue_mouse pbm_mousemove
event lbuttonclk pbm_dwnlbuttonclk
event lbuttonup pbm_dwnlbuttonup
integer x = 965
integer y = 424
integer width = 910
integer height = 756
integer taborder = 20
string dragicon = "Rectangle!"
string title = "none"
string dataobject = "d_div_select02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mouse;
If This.GetSelectedRow(0) <> 0 Then  // 선택된 Row가 있는경우만 Drag & Drop.

	If Message.WordParm = 1 Then  // 클릭 상태를 유지하는 동안만...
		ii_Drag_Row = This.GetSelectedRow(0)
		This.Drag(Begin!)
	End If
	
End If
end event

event lbuttonclk;
If dwo.Type = 'column' Then
	This.SelectRow( 0, False)
	This.SelectRow(Row, True)
End If
end event

event lbuttonup;
This.SelectRow( 0, False)
end event

event dragdrop;
If source = This Then Return

Int li_Drop_Row

li_Drop_Row = This.RowCount() + 1
dw_1.RowsMove( ii_Drag_Row, ii_Drag_Row, Primary!, This, li_Drop_Row, Primary!)

cb_1.Enabled = True
end event

type dw_1 from datawindow within w_div_select_res
event ue_mousemove pbm_mousemove
event lbuttonclk pbm_dwnlbuttonclk
event lbuttonup pbm_lbuttonup
integer x = 27
integer y = 424
integer width = 910
integer height = 756
integer taborder = 10
string dragicon = "Rectangle!"
string title = "none"
string dataobject = "d_div_select01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_mousemove;
If This.GetSelectedRow(0) <> 0 Then  // 선택된 Row가 있는경우만 Drag & Drop.

	If Message.WordParm = 1 Then  // 클릭 상태를 유지하는 동안만...
		ii_Drag_Row = This.GetSelectedRow(0)
		This.Drag(Begin!)
	End If
	
End If
end event

event lbuttonclk;
If dwo.Type = 'column' Then
	This.SelectRow( 0, False)
	This.SelectRow(Row, True)
End If
end event

event lbuttonup;
This.SelectRow( 0, False)
end event

event dragdrop;
If source = This Then Return

Int li_Drop_Row

li_Drop_Row = This.RowCount() + 1
dw_2.RowsMove( ii_Drag_Row, ii_Drag_Row, Primary!, This, li_Drop_Row, Primary!)

If dw_2.RowCount() = 0 Then cb_1.Enabled = False
end event

type gb_1 from groupbox within w_div_select_res
integer x = 165
integer y = 16
integer width = 1573
integer height = 232
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_div_select_res
integer x = 229
integer y = 112
integer width = 1463
integer height = 80
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "휴먼옛체"
long backcolor = 15780518
string text = "선택할 공장을 끌어서 넣으십시요."
alignment alignment = center!
boolean focusrectangle = false
end type

