$PBExportHeader$w_pism_finditem.srw
$PBExportComments$품번 찾기(품명으로) Response Window
forward
global type w_pism_finditem from window
end type
type dw_find from u_vi_std_datawindow within w_pism_finditem
end type
type pb_find from picturebutton within w_pism_finditem
end type
type sle_itemname from singlelineedit within w_pism_finditem
end type
type cb_close from commandbutton within w_pism_finditem
end type
type cb_enter from commandbutton within w_pism_finditem
end type
type st_1 from statictext within w_pism_finditem
end type
type sle_itemcode from singlelineedit within w_pism_finditem
end type
type st_2 from statictext within w_pism_finditem
end type
type gb_1 from groupbox within w_pism_finditem
end type
end forward

global type w_pism_finditem from window
integer width = 1961
integer height = 1176
boolean titlebar = true
string title = "품번검색"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 67108864
dw_find dw_find
pb_find pb_find
sle_itemname sle_itemname
cb_close cb_close
cb_enter cb_enter
st_1 st_1
sle_itemcode sle_itemcode
st_2 st_2
gb_1 gb_1
end type
global w_pism_finditem w_pism_finditem

type variables
str_pism_daily istr_mh 
DataWindow idw_source 
end variables

on w_pism_finditem.create
this.dw_find=create dw_find
this.pb_find=create pb_find
this.sle_itemname=create sle_itemname
this.cb_close=create cb_close
this.cb_enter=create cb_enter
this.st_1=create st_1
this.sle_itemcode=create sle_itemcode
this.st_2=create st_2
this.gb_1=create gb_1
this.Control[]={this.dw_find,&
this.pb_find,&
this.sle_itemname,&
this.cb_close,&
this.cb_enter,&
this.st_1,&
this.sle_itemcode,&
this.st_2,&
this.gb_1}
end on

on w_pism_finditem.destroy
destroy(this.dw_find)
destroy(this.pb_find)
destroy(this.sle_itemname)
destroy(this.cb_close)
destroy(this.cb_enter)
destroy(this.st_1)
destroy(this.sle_itemcode)
destroy(this.st_2)
destroy(this.gb_1)
end on

event open;idw_source = message.PowerObjectParm 
If Not IsValid(idw_source) Then 
	f_pism_MessageBox(StopSign!, -1, "검색오류", "검색쏘스 DataWindow를 알 수 없습니다.") 
	Close(This) 
	Return 
End If 

istr_mh = w_frame.GetActiveSheet(). Dynamic wf_getistr() 
If Not IsValid(istr_mh) Then 
	f_pism_MessageBox(StopSign!, -1, "검색오류", "지역 및 공장을 알 수 없습니다.") 
	Close(This) 
	Return 
End If

environment env
long ll_x, ll_y

GetEnvironment(env)

ll_x = 30 //(PixelsToUnits(env.ScreenWidth, XPixelsToUnits!) - This.Width) / 2
ll_y = (PixelsToUnits(env.ScreenHeight, YPixelsToUnits!) - ( This.Height + 100) ) /// 2

This.Move(ll_x, ll_y)

end event

event activate;sle_itemcode.SetFocus() 
end event

event resize;dw_find.Height = newheight - ( dw_find.y + cb_enter.Height + 10 ) 
dw_find.Width = newwidth - ( dw_find.x + 10 ) 

cb_enter.y = dw_find.y + dw_find.Height + 5 
cb_close.y = cb_enter.y 
end event

type dw_find from u_vi_std_datawindow within w_pism_finditem
integer x = 18
integer y = 228
integer width = 1883
integer height = 724
integer taborder = 30
string dataobject = "d_pism_finditem"
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

type pb_find from picturebutton within w_pism_finditem
integer x = 1632
integer y = 96
integer width = 238
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "bmp\search.gif"
alignment htextalign = left!
end type

event clicked;String	ls_ItemCode, ls_ItemName 
Long		ll_Row

dw_find.Reset()

ls_ItemCode = Trim(sle_itemcode.text)
ls_ItemName = Trim(sle_itemname.Text) 

If ls_ItemCode = '' Then 
	If ls_ItemName = ''  Or isNull(ls_ItemName) Then
		ls_ItemName = '%'
	Else 
		ls_ItemName = '%' + Upper(ls_ItemName) + '%' 
	End If
End If 

dw_find.SetTransObject(sqlpis)

If ls_ItemCode = '' And ls_ItemName = '%' Then 
	MessageBox("확인","검색어를 입력하세요", Information!)
	Return
End If
ll_Row = dw_find.retrieve(istr_mh.area, istr_mh.div, ls_ItemCode, ls_ItemName)
If ll_Row < 1 Then
	MessageBox("확인","해당자료가 없습니다", Information!)
End If

dw_find.SetFocus()
dw_find.SelectRow(1,True)

If ll_Row = 1 Then cb_enter.TriggerEvent(Clicked!) 
end event

type sle_itemname from singlelineedit within w_pism_finditem
integer x = 827
integer y = 108
integer width = 777
integer height = 92
integer taborder = 20
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
sle_itemcode.Text = '' 

pb_find.TriggerEvent( "Clicked" )
end event

type cb_close from commandbutton within w_pism_finditem
integer x = 1467
integer y = 960
integer width = 434
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;close(parent)
end event

type cb_enter from commandbutton within w_pism_finditem
integer x = 1033
integer y = 960
integer width = 434
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;Long		ll_Row, ll_findRow 
String ls_ItemCode  
str_pisr_return 	lstr_Rtn

ll_Row		= dw_find.GetRow()
If ll_Row < 1 Then
	MessageBox("확인","품번을 선택하세요", Information!)
	Return
End If

ls_ItemCode = dw_find.GetItemString(ll_Row,"itemcode")

ll_findRow = idw_source.Find("ItemCode = '" + ls_ItemCode + "'", 1, idw_source.RowCount()) 
If ll_findRow = 0 Then 
	f_pism_MessageBox(Information!, 999, "품번검색실패", ls_ItemCode + " 해당 품번을 찾을 수 없습니다.") 
Else
	idw_source.SelectRow(0, False); idw_source.SelectRow(ll_findRow, True)
//	idw_source.Dynamic uf_key(ll_findRow)
	idw_source.ScrollToRow(ll_findRow); idw_source.SetFocus() 
End If 


end event

type st_1 from statictext within w_pism_finditem
integer x = 41
integer y = 128
integer width = 142
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "품번"
boolean focusrectangle = false
end type

type sle_itemcode from singlelineedit within w_pism_finditem
integer x = 183
integer y = 108
integer width = 443
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

event modified;String	ls_data

ls_data = this.Text

If isNull(ls_data) Or Trim(ls_data) = '' Then return

sle_itemname.Text = '' 
pb_find.TriggerEvent( "Clicked" )
end event

type st_2 from statictext within w_pism_finditem
integer x = 686
integer y = 128
integer width = 137
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "품명"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pism_finditem
integer x = 18
integer y = 32
integer width = 1879
integer height = 188
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "검색어"
end type

