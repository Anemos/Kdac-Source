$PBExportHeader$w_itno_search_res.srw
$PBExportComments$품번검색
forward
global type w_itno_search_res from window
end type
type st_msg from statictext within w_itno_search_res
end type
type sle_1 from singlelineedit within w_itno_search_res
end type
type dw_1 from datawindow within w_itno_search_res
end type
type cb_1 from commandbutton within w_itno_search_res
end type
type st_1 from statictext within w_itno_search_res
end type
type cb_ok from commandbutton within w_itno_search_res
end type
type cb_cancel from commandbutton within w_itno_search_res
end type
type rb_3 from radiobutton within w_itno_search_res
end type
type rb_2 from radiobutton within w_itno_search_res
end type
type rb_1 from radiobutton within w_itno_search_res
end type
type pb_1 from picturebutton within w_itno_search_res
end type
type gb_1 from groupbox within w_itno_search_res
end type
type gb_2 from groupbox within w_itno_search_res
end type
end forward

global type w_itno_search_res from window
integer width = 2821
integer height = 1368
boolean titlebar = true
string title = "품번검색"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "C:\KDAC\kdac.ico"
st_msg st_msg
sle_1 sle_1
dw_1 dw_1
cb_1 cb_1
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
pb_1 pb_1
gb_1 gb_1
gb_2 gb_2
end type
global w_itno_search_res w_itno_search_res

type variables
String is_xplant, is_div, is_cls[]

// DataWindow Sort용~
String  is_PreColNm
Boolean ib_Sort_Desc
end variables

on w_itno_search_res.create
this.st_msg=create st_msg
this.sle_1=create sle_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.pb_1=create pb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_msg,&
this.sle_1,&
this.dw_1,&
this.cb_1,&
this.st_1,&
this.cb_ok,&
this.cb_cancel,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.pb_1,&
this.gb_1,&
this.gb_2}
end on

on w_itno_search_res.destroy
destroy(this.st_msg)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.pb_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event activate;f_center_window(This)
end event

event open;Str_Open_Parm	lStr_Parm
String ls_itno

lStr_Parm = Message.PowerObjectParm

is_xplant = lStr_Parm.Xplant
is_div	 = lStr_Parm.Div
is_cls    = lStr_Parm.Cls
ls_itno	 = lStr_Parm.Itno



sle_1.Text = ls_itno
sle_1.SetFocus()

If f_spacechk(ls_itno) <> -1 Then
	cb_1.PostEvent(Clicked!)
End If
end event

type st_msg from statictext within w_itno_search_res
boolean visible = false
integer x = 389
integer y = 1168
integer width = 1253
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean enabled = false
string text = "조건에 맞는 품번이 없습니다."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_itno_search_res
integer x = 110
integer y = 128
integer width = 1033
integer height = 92
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
end type

event getfocus;
This.SelectText(1, Len(This.Text))
end event

type dw_1 from datawindow within w_itno_search_res
integer x = 27
integer y = 264
integer width = 2738
integer height = 876
integer taborder = 30
string title = "none"
string dataobject = "d_it_search01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If Upper(dwo.Type) = 'TEXT' Then  // 칼럼명으로 DW Sort.
	String ls_ColNm
	
	ls_ColNm = f_Get_Sort_ColNm( This)
	f_Sorting_Dw(This, ls_ColNm, is_PreColNm, ib_Sort_Desc)
	is_PreColNm = ls_ColNm
   Return
End If

This.SelectRow( 0, False )
This.SelectRow( Row, True )

If dwo.Type = 'column' Then	
	cb_ok.Enabled = True
End If
end event

event constructor;This.SetTransObject( SQLCA )
end event

event doubleclicked;
If dwo.Type = 'column' Then
	cb_ok.TriggerEvent(Clicked!)
End If
end event

type cb_1 from commandbutton within w_itno_search_res
integer x = 1883
integer y = 144
integer width = 302
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "검색"
boolean default = true
end type

event clicked;String ls_search
Integer li_cnt


st_Msg.Visible = False

SetPointer( HourGlass! ) 

If f_spacechk(sle_1.Text) = -1 Then	
	
	ls_search = "%"
	li_cnt = dw_1.Retrieve( g_s_company, is_xplant, is_div, is_cls, ls_search)	
Else
	ls_search = "%" + Trim(sle_1.Text) + "%"
	li_cnt = dw_1.Retrieve( g_s_company, is_xplant, is_div, is_cls, ls_search)
		
	If li_cnt = 0 Then
		st_Msg.Visible = True
	ElseIf li_cnt = 1 Then
		dw_1.SelectRow(1, TRUE)
		cb_ok.Enabled = True
	Else
		cb_ok.Enabled = False
	End If
End If

end event

type st_1 from statictext within w_itno_search_res
integer x = 1513
integer y = 164
integer width = 110
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
string text = "<<"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_itno_search_res
integer x = 2030
integer y = 1164
integer width = 279
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
boolean enabled = false
string text = "확인"
end type

event clicked;String ls_rtn
Long lL_row


lL_row = dw_1.GetSelectedRow(0)
ls_rtn = dw_1.GetItemString(lL_row, 'itno')

CloseWithReturn(parent, ls_rtn)

end event

type cb_cancel from commandbutton within w_itno_search_res
integer x = 2341
integer y = 1164
integer width = 283
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
string text = "취소"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "")
end event

type rb_3 from radiobutton within w_itno_search_res
integer x = 1527
integer y = 44
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 67108864
string text = "품번"
boolean checked = true
end type

event clicked;
Parent.Title = '품번 검색'
gb_1.Text = '[품번]'
dw_1.DataObject = 'd_it_search01'
dw_1.SetTransObject( SQLCA )

st_Msg.Text = '조건에 맞는 품번이 없습니다.'
st_Msg.Visible = False

sle_1.Text = ""
sle_1.SetFocus()
end event

type rb_2 from radiobutton within w_itno_search_res
integer x = 1893
integer y = 44
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 67108864
string text = "품명"
end type

event clicked;
Parent.Title = '품명 검색'
gb_1.Text = '[품명]'
dw_1.DataObject = 'd_it_search02'
dw_1.SetTransObject( SQLCA )

st_Msg.Text = '조건에 맞는 품명이 없습니다.'
st_Msg.Visible = False
sle_1.Text = ""
sle_1.SetFocus()
end event

type rb_1 from radiobutton within w_itno_search_res
integer x = 2245
integer y = 44
integer width = 229
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 67108864
string text = "규격"
end type

event clicked;
Parent.Title = '규격 검색'
gb_1.Text = '[규격]'
dw_1.DataObject = 'd_it_search03'
dw_1.SetTransObject( SQLCA )

st_Msg.Text = '조건에 맞는 규격이 없습니다.'
st_Msg.Visible = False

sle_1.Text = ""
sle_1.SetFocus()
end event

type pb_1 from picturebutton within w_itno_search_res
integer x = 2587
integer y = 104
integer width = 155
integer height = 132
integer taborder = 10
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;
If dw_1.RowCount( ) = 0 Then
	MessageBox('확인!', "엑셀로 저장할 정보가 없습니다.", Exclamation!)
	Return
End If

f_Save_To_Excel( dw_1 )
end event

type gb_1 from groupbox within w_itno_search_res
integer x = 78
integer y = 60
integer width = 1097
integer height = 180
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "[품번]"
end type

type gb_2 from groupbox within w_itno_search_res
integer x = 1481
integer width = 1015
integer height = 116
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

