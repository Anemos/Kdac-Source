$PBExportHeader$w_suppress.srw
$PBExportComments$SORT WINDOW
forward
global type w_suppress from Window
end type
type cb_cancel from commandbutton within w_suppress
end type
type cb_ok from commandbutton within w_suppress
end type
type st_left from statictext within w_suppress
end type
type st_bar from statictext within w_suppress
end type
type st_right from statictext within w_suppress
end type
type dw_sort_right from datawindow within w_suppress
end type
type dw_sort_left from datawindow within w_suppress
end type
type gb_sort from groupbox within w_suppress
end type
end forward

global type w_suppress from Window
int X=1074
int Y=484
int Width=1879
int Height=884
boolean TitleBar=true
string Title="동일한 필드 숨기기 (Suppression)"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
cb_cancel cb_cancel
cb_ok cb_ok
st_left st_left
st_bar st_bar
st_right st_right
dw_sort_right dw_sort_right
dw_sort_left dw_sort_left
gb_sort gb_sort
end type
global w_suppress w_suppress

type variables
Long il_drag_row, il_old_row
datawindow idw_sort
end variables

forward prototypes
public subroutine wf_bar_visible (long fl_row)
public function string wf_sort (long fl_rowcount)
public function string wf_suppress (long fl_rowcount)
public subroutine wf_dw_insert (datawindow fdw_1)
end prototypes

public subroutine wf_bar_visible (long fl_row);Long	ll_first_row, ll_header, ll_detail

If Not st_left.Visible Then
	ll_first_row	= Long(dw_sort_right.Object.DataWindow.FirstRowOnPage)
	ll_header		= Long(dw_sort_right.Describe("DataWindow.Header.Height"))
	ll_detail		= Long(dw_sort_right.Describe("DataWindow.Detail.Height"))
	
	st_bar.Move(dw_sort_right.X, dw_sort_right.Y + ll_header + (ll_detail * (fl_row - ll_first_row)))
	st_bar.Resize(dw_sort_right.Width, st_bar.Height)
		
	st_left.Move(dw_sort_right.X - st_left.Width + 4, &
				 dw_sort_right.Y + ll_header + (ll_detail * (fl_row - ll_first_row)) - ((st_left.Height - st_bar.Height) / 2))
	
	st_right.Move(dw_sort_right.X + dw_sort_right.Width, &
				 dw_sort_right.Y + ll_header + (ll_detail * (fl_row - ll_first_row)) - ((st_right.Height - st_bar.Height) / 2))
	
	st_left.Visible	= True
	st_bar.Visible		= True
	st_right.Visible	= True
End If
end subroutine

public function string wf_sort (long fl_rowcount);Long 		i
String	ls_colname, ls_ascending, ls_sort = ''

For i = 1 To fl_rowcount
	ls_colname	= dw_sort_right.GetItemString(i, 'columnname')
	ls_ascending	= dw_sort_right.GetItemString(i, 'ascgubun')
	If i = fl_rowcount Then
		ls_sort	= ls_sort + ls_colname + Space(1) + ls_ascending
	Else
		ls_sort	= ls_sort + ls_colname + Space(1) + ls_ascending + ', '
	End If
Next

Return ls_sort
end function

public function string wf_suppress (long fl_rowcount);Long 		i
String	ls_colname, ls_suppress = ''

For i = 1 To fl_rowcount
	ls_colname	= dw_sort_right.GetItemString(i, 'columnname')
	If i = fl_rowcount Then
		ls_suppress	= ls_suppress + ls_colname
	Else
		ls_suppress	= ls_suppress + ls_colname + '~t'
	End If
Next

Return ls_suppress
end function

public subroutine wf_dw_insert (datawindow fdw_1);//Sort 대상 Column과 Text의 이름은 column/column_t 가 되어야 한다.
//Detail Band 내에 존재하는 Column만을 Sort/Suppress 한다.

Long		i, ll_detail, ll_len, ll_pos, ll_y, ll_text_len, ll_rowcount
String 	ls_describe, ls_object, ls_id, ls_band, ls_visible, ls_text, ls_mid, ls_column_display = ''

ls_describe	= fdw_1.Describe("DataWindow.Objects")

If ls_describe <> '!' Then
	ll_detail	= Long(fdw_1.Describe("DataWindow.Detail.Height"))
	ll_len		= Len(Trim(ls_describe))
	ll_pos		= Pos(ls_describe, '~t')
	DO 
		ls_object	= Left(ls_describe, ll_pos - 1)
		ls_id			= fdw_1.Describe(ls_object + ".ID")
		ls_band		= fdw_1.Describe(ls_object + ".Band")
		ll_y			= Long(fdw_1.Describe(ls_object + ".Y"))
		ls_visible	= fdw_1.Describe(ls_object + ".Visible")

		// Column Object인지 Check한다.(Column또는 Table Blob Object만이 ID를 가지고 있다)
		// Detail Band 안에 존재해야 한다.
		// Column의 Y Value가 Detail Band의 Height보다 작아야 한다.
		// Visible 상태의 Column만을 대상으로 한다.
		
		// Column Object인지 Check한다.
		If ls_id <> '!' And Upper(ls_band) = 'DETAIL' And ll_y < ll_detail And ls_visible = '1' Then
			ls_text	= fdw_1.Describe(ls_object + "_t.Text")
			ll_text_len	= Len(ls_text)
			For i = 1 To ll_text_len
				ls_mid		= Mid(ls_text, i, 1)
				If Asc(ls_mid) >= 33 Then
					ls_column_display	= ls_column_display + ls_mid
				End If
			Next
			
			// Text가 "~r~n"을 포함하고 있는 경우에 String 앞뒤에 " 를 붙여서 Return 한다. 
			// 앞뒤의 " 를 제외시킨다.
			If Left(ls_column_display, 1) = '"' And Right(ls_column_display, 1) = '"' Then
				ls_column_display = Mid(ls_column_display, 2, Len(ls_column_display) - 2 )
			End If
			
			
			ll_rowcount	= dw_sort_left.RowCount()
			dw_sort_left.InsertRow(ll_rowcount + 1)
			
			// User에게 Test의 내용을 Display한다.
			dw_sort_left.SetItem(ll_rowcount + 1, 'columndisplay',ls_column_display)

			// 실제 Sort/Suppress는 Column Object를 이용한다.
			dw_sort_left.SetItem(ll_rowcount + 1, 'columnname',	ls_object)
			dw_sort_left.SetItem(ll_rowcount + 1, 'columnid', 		Integer(ls_id))
			ls_column_display = ''
		End If

		ls_describe			= Trim(Mid(ls_describe, ll_pos + 1, ll_len))
		ll_len				= Len(ls_describe)
		ll_pos				= Pos(ls_describe, "~t")

		// DataWindow Objects 중 마지막 Object
		If ll_pos = 0 Then
			ls_object	= ls_describe
			ls_id			= fdw_1.Describe(ls_object + ".ID")
			ls_band		= fdw_1.Describe(ls_object + ".Band")
			ll_y			= Long(fdw_1.Describe(ls_object + ".Y"))
			ls_visible	= fdw_1.Describe(ls_object + ".Visible")

			// Column Object인지 Check한다.
			If ls_id <> '!' And Upper(ls_band) = 'DETAIL' And ll_y < ll_detail And ls_visible = '1' Then
				ls_text	= fdw_1.Describe(ls_object + "_t.Text")
				ll_text_len	= Len(ls_text)
				// Describe("Text")시 Return Value가 String 앞뒤에 " 를 붙여서 Return 한다. 
				// 앞뒤의 " 제외하고 계산
				For i = 1 To ll_text_len
					ls_mid		= Mid(ls_text, i, 1)
					If Asc(ls_mid) >= 33 Then
						ls_column_display	= ls_column_display + ls_mid
					End If
				Next

				// Text가 "~r~n"을 포함하고 있는 경우에 String 앞뒤에 " 를 붙여서 Return 한다. 
				// 앞뒤의 " 를 제외시킨다.
				If Left(ls_column_display, 1) = '"' And Right(ls_column_display, 1) = '"' Then
					ls_column_display = Mid(ls_column_display, 2, Len(ls_column_display) - 2 )
				End If

				ll_rowcount	= dw_sort_left.RowCount()
				dw_sort_left.InsertRow(ll_rowcount + 1)
				
				// User에게 Test의 내용을 Display한다.
				dw_sort_left.SetItem(ll_rowcount + 1, 'columndisplay', 	ls_column_display)
				// 실제 Sort/Suppress는 Column Object를 이용한다.
				dw_sort_left.SetItem(ll_rowcount + 1, 'columnname', 	ls_object)
				dw_sort_left.SetItem(ll_rowcount + 1, 'columnid', 		Integer(ls_id))
			End If
		End If
	LOOP UNTIL ll_pos = 0
	
	dw_sort_left.SetSort("columnid A")
	dw_sort_left.Sort()
End If
end subroutine

on w_suppress.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_left=create st_left
this.st_bar=create st_bar
this.st_right=create st_right
this.dw_sort_right=create dw_sort_right
this.dw_sort_left=create dw_sort_left
this.gb_sort=create gb_sort
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.st_left,&
this.st_bar,&
this.st_right,&
this.dw_sort_right,&
this.dw_sort_left,&
this.gb_sort}
end on

on w_suppress.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_left)
destroy(this.st_bar)
destroy(this.st_right)
destroy(this.dw_sort_right)
destroy(this.dw_sort_left)
destroy(this.gb_sort)
end on

event open;String ls_modstring
//str_sort str_param
//
//gb_sort.Text	= ''
//ls_modstring	= "header_columns.Text = '선택한 필드' header_ascending.Text = '' " + &
//						  "columnname.Width = '" + String(dw_sort_right.Width) + "' ascgubun.visible = '0' "
//dw_sort_right.Modify(ls_modstring)
//
//
//str_param = Message.PowerObjectParm
//idw_sort = str_param.ldw
//
//this.move(str_param.ll_x, str_param.ll_y)
//wf_dw_insert(str_param.ldw)



end event

type cb_cancel from commandbutton within w_suppress
int X=1559
int Y=140
int Width=270
int Height=88
int TabOrder=12
string Text="&Cancel"
boolean Cancel=true
int TextSize=-9
int Weight=400
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, 'CANCEL')
end event

type cb_ok from commandbutton within w_suppress
int X=1559
int Y=40
int Width=270
int Height=88
int TabOrder=20
string Text="&OK"
boolean Default=true
int TextSize=-9
int Weight=400
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

event clicked;Long ll_rowcount
string ls_modstring

ll_rowcount	= dw_sort_right.RowCount()

ls_modstring = wf_suppress(ll_rowcount)

idw_sort.Modify("DataWindow.Sparse = '" + ls_modstring + "'")

close(parent)


end event

type st_left from statictext within w_suppress
int X=142
int Y=812
int Width=18
int Height=80
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_bar from statictext within w_suppress
int X=160
int Y=844
int Width=745
int Height=16
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type st_right from statictext within w_suppress
int X=901
int Y=812
int Width=18
int Height=80
boolean Enabled=false
boolean FocusRectangle=false
long BackColor=0
int TextSize=-10
int Weight=400
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

type dw_sort_right from datawindow within w_suppress
event clicked pbm_dwnlbuttonclk
event dragdrop pbm_dwndragdrop
event dragwithin pbm_dwndragwithin
int X=713
int Y=76
int Width=782
int Height=672
int TabOrder=10
string DragIcon="row.ico"
string DataObject="d_sort_right"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;If row > 0 Then
	SelectRow(0, False)
	SelectRow(row, True)
	
	il_drag_row	= row
	wf_bar_visible(il_drag_row)
	Drag(Begin!)
End If
end event

event dragdrop;Long			ll_find
String		ls_column
DragObject	ldo_object
DataWindow	ldw_control

// Dragged중인 Object를 알아낸다.
ldo_object = DraggedObject()
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
	If ldw_control = This Then
		RowsMove(il_drag_row, il_drag_row, Primary!, This, il_old_row, Primary!)
		SelectRow(0, False)
	ElseIf ldw_control = dw_sort_left Then
		dw_sort_left.SelectRow(0, False)
		ls_column	= dw_sort_left.GetItemString(il_drag_row, 'columnname')
		ll_find	= Find("columnname  = '" + ls_column + "'", 1, RowCount())
		If ll_Find > 0 Then
			RowsMove(ll_find, ll_find, Primary!, This, il_old_row, Primary!)
		Else
			InsertRow(il_old_row)
			SetItem(il_old_row, 'columndisplay', dw_sort_left.GetItemString(il_drag_row, 'columndisplay'))
			SetItem(il_old_row, 'columnname', ls_column)
			SetItem(il_old_row, 'columnid', dw_sort_left.GetItemNumber(il_drag_row, 'columnid'))
			SetItem(il_old_row, 'ascgubun', 'A')
		End If
	End If
End If
st_left.Visible	= False
st_right.Visible	= False
st_bar.Visible		= False

end event

event dragwithin;Long	ll_first_row, ll_header, ll_detail, ll_last_row
DragObject	ldo_object
DataWindow	ldw_control

If row > 0 Then
	If il_old_row <> row Then
		ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
		ll_header		= Long(Describe("DataWindow.Header.Height"))
		ll_detail		= Long(Describe("DataWindow.Detail.Height"))
		
		st_bar.Move(X, Y + ll_header + (ll_detail * (row - ll_first_row)))
		st_left.Move(X - st_left.Width + 4, &
						 Y + ll_header + (ll_detail * (row - ll_first_row)) - ((st_left.Height - st_bar.Height) / 2))
		st_right.Move(X + Width, &
						 Y + ll_header + (ll_detail * (row - ll_first_row)) - ((st_right.Height - st_bar.Height) / 2))
	
		il_old_row = row
	End If
Else
	ll_last_row 	= Long(Object.DataWindow.LastRowOnPage)
	ll_first_row	= Long(Object.DataWindow.FirstRowOnPage)
	ll_header		= Long(Describe("DataWindow.Header.Height"))
	ll_detail		= Long(Describe("DataWindow.Detail.Height"))
	If PointerY() > ll_header Then
		If ll_last_row < RowCount() Then
			ScrollNextRow()
		Else
			st_bar.Move(X, Y + ll_header + (ll_detail * (ll_last_row - ll_first_row + 1)))
			st_left.Move(X - st_left.Width + 4, &
							 Y + ll_header + (ll_detail * (ll_last_row - ll_first_row + 1)) - ((st_left.Height - st_bar.Height) / 2))
			st_right.Move(X + Width, &
							 Y + ll_header + (ll_detail * (ll_last_row - ll_first_row + 1)) - ((st_right.Height - st_bar.Height) / 2))
					
			il_old_row = ll_last_row + 1
		End If
	Else
		ScrollPriorRow()
	End If
End If

// Dragged중인 Object를 알아낸다.
ldo_object = DraggedObject()
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
	If ldw_control = dw_sort_left Then
		wf_bar_visible(il_old_row)
	End If
End If	
end event

type dw_sort_left from datawindow within w_suppress
event clicked pbm_dwnlbuttonclk
event constructor pbm_constructor
event dragdrop pbm_dwndragdrop
event dragwithin pbm_dwndragwithin
int X=50
int Y=76
int Width=626
int Height=672
int TabOrder=30
string DragIcon="row.ico"
string DataObject="d_sort_left"
BorderStyle BorderStyle=StyleLowered!
boolean HScrollBar=true
boolean VScrollBar=true
boolean LiveScroll=true
end type

event clicked;If row > 0 Then
	SelectRow(0, False)
	SelectRow(row, True)
	
	il_drag_row	= row
	
	Drag(Begin!)
End If
end event

event dragdrop;Long	ll_first_row, ll_header, ll_detail, ll_last_row
DragObject	ldo_object
DataWindow	ldw_control

// Dragged중인 Object를 알아낸다.
ldo_object = DraggedObject()
If TypeOf (ldo_object) = DataWindow! Then
	ldw_control = ldo_object
	If ldw_control = dw_sort_right Then
		dw_sort_right.SelectRow(0, False)
		dw_sort_right.DeleteRow(il_drag_row)
	End If
End If

If st_bar.Visible Then
	st_bar.Visible		= False
	st_left.Visible	= False
	st_right.Visible	= False
End If
end event

event dragwithin;If st_bar.Visible Then
	st_bar.Visible		= False
	st_left.Visible	= False
	st_right.Visible	= False
End If
end event

type gb_sort from groupbox within w_suppress
int X=27
int Width=1495
int Height=768
int TabOrder=40
string Text=" Sort "
long TextColor=8388608
long BackColor=79741120
int TextSize=-10
int Weight=700
string FaceName="굴림"
FontCharSet FontCharSet=Hangeul!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Variable!
end type

