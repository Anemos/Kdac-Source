$PBExportHeader$w_pisr016i.srw
$PBExportComments$부서찾기
forward
global type w_pisr016i from window
end type
type dw_find from u_vi_std_datawindow within w_pisr016i
end type
type pb_find from picturebutton within w_pisr016i
end type
type sle_1 from singlelineedit within w_pisr016i
end type
type cb_2 from commandbutton within w_pisr016i
end type
type cb_enter from commandbutton within w_pisr016i
end type
type gb_1 from groupbox within w_pisr016i
end type
end forward

global type w_pisr016i from window
integer x = 201
integer y = 500
integer width = 1664
integer height = 1428
boolean titlebar = true
string title = "부서코드찾기"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 12632256
dw_find dw_find
pb_find pb_find
sle_1 sle_1
cb_2 cb_2
cb_enter cb_enter
gb_1 gb_1
end type
global w_pisr016i w_pisr016i

type variables
str_pisr_partkb istr_partkb
end variables

on w_pisr016i.create
this.dw_find=create dw_find
this.pb_find=create pb_find
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_enter=create cb_enter
this.gb_1=create gb_1
this.Control[]={this.dw_find,&
this.pb_find,&
this.sle_1,&
this.cb_2,&
this.cb_enter,&
this.gb_1}
end on

on w_pisr016i.destroy
destroy(this.dw_find)
destroy(this.pb_find)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_enter)
destroy(this.gb_1)
end on

event open;
istr_partkb = Message.PowerObjectParm

f_pisc_win_center_move(This)

dw_find.settransobject(sqlpis)
dw_find.reset()

end event

type dw_find from u_vi_std_datawindow within w_pisr016i
integer x = 18
integer y = 252
integer width = 1545
integer height = 916
integer taborder = 40
string dataobject = "d_pisr016i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ib_multiselection = false
integer ii_selection = 1
end type

event doubleclicked;call super::doubleclicked;
If row < 1 Then Return

cb_enter.TriggerEvent( "Clicked" )


end event

event ue_key;call super::ue_key;If key = KeyEnter! Then 
	cb_enter.TriggerEvent( "Clicked" )
End If 

Return 1

end event

type pb_find from picturebutton within w_pisr016i
integer x = 1225
integer y = 44
integer width = 329
integer height = 196
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;String	ls_Key

dw_find.Reset()

ls_Key = Trim(sle_1.text)

If ls_Key = ''  Or isNull(ls_Key) Then
	MessageBox("확인","검색어를 입력하세요", Information!)
   Return
End If

ls_Key = '%' + Upper(ls_Key) + '%'

dw_find.SetTransObject(sqlpis)

If dw_find.retrieve(istr_partkb.areacode, istr_partkb.divcode, ls_Key) < 1 Then
	MessageBox("확인","해당자료가 없습니다", Information!)
End If

dw_find.SetFocus()
dw_find.SelectRow(1,True)


end event

type sle_1 from singlelineedit within w_pisr016i
integer x = 55
integer y = 120
integer width = 786
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

event modified;
String	ls_data

ls_data = this.Text

If isNull(ls_data) Or Trim(ls_data) = '' Then return

pb_find.TriggerEvent( "Clicked" )
end event

type cb_2 from commandbutton within w_pisr016i
integer x = 1234
integer y = 1192
integer width = 329
integer height = 148
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취 소"
end type

event clicked;str_pisr_return	lstr_Rtn

lstr_Rtn.code 		= ''
lstr_Rtn.name 		= ''
lstr_Rtn.nicname 	= ''

closewithreturn(parent,lstr_Rtn)
end event

type cb_enter from commandbutton within w_pisr016i
integer x = 896
integer y = 1192
integer width = 329
integer height = 148
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;Long		ll_Row
str_pisr_return	lstr_Rtn

ll_Row		= dw_find.GetRow()
If ll_Row < 1 Then
	MessageBox("확인","품번을 선택하세요", Information!)
	Return
End If

lstr_Rtn.code 		= dw_find.GetItemString(ll_Row,"deptcode")
lstr_Rtn.name 		= dw_find.GetItemString(ll_Row,"deptname")
lstr_Rtn.nicname 	= ''

CloseWithReturn(Parent, lstr_Rtn)

end event

type gb_1 from groupbox within w_pisr016i
integer x = 18
integer y = 32
integer width = 896
integer height = 208
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "검색어( 부서명으로 검색 )"
end type

