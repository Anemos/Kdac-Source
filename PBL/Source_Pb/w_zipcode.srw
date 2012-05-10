$PBExportHeader$w_zipcode.srw
$PBExportComments$우편번호찾기
forward
global type w_zipcode from window
end type
type cb_2 from commandbutton within w_zipcode
end type
type st_7 from statictext within w_zipcode
end type
type st_6 from statictext within w_zipcode
end type
type st_4 from statictext within w_zipcode
end type
type cb_1 from commandbutton within w_zipcode
end type
type st_3 from statictext within w_zipcode
end type
type sle_1 from singlelineedit within w_zipcode
end type
type st_2 from statictext within w_zipcode
end type
type st_1 from statictext within w_zipcode
end type
type dw_4 from datawindow within w_zipcode
end type
type dw_3 from datawindow within w_zipcode
end type
type dw_2 from datawindow within w_zipcode
end type
type dw_1 from datawindow within w_zipcode
end type
type gb_1 from groupbox within w_zipcode
end type
type gb_2 from groupbox within w_zipcode
end type
end forward

global type w_zipcode from window
integer width = 1678
integer height = 900
boolean titlebar = true
string title = "우편번호검색"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
boolean clientedge = true
event ue_selectcond ( )
cb_2 cb_2
st_7 st_7
st_6 st_6
st_4 st_4
cb_1 cb_1
st_3 st_3
sle_1 sle_1
st_2 st_2
st_1 st_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_zipcode w_zipcode

type variables
string is_sido,is_gugun,is_dong
end variables

event ue_selectcond;string ls_sido,ls_gugun,ls_dong,ls_note1
string ls_zipcode

dw_1.accepttext()
dw_2.accepttext()
dw_3.accepttext()
dw_4.accepttext()

ls_sido = Trim(dw_1.GetItemString(1,1))
ls_gugun = Trim(dw_2.GetItemString(1,1))
ls_dong = Trim(dw_3.GetItemString(1,1))
ls_note1 = Trim(dw_4.GetItemString(1,1))

If isnull(ls_note1) or ls_note1 = '' Then
	Select zipcode into :ls_zipcode from tmstzipcode 
	where sido = :ls_sido and gugun = :ls_gugun and dong = :ls_dong and note1 is null;
	ls_note1 = ''
else
	Select zipcode into :ls_zipcode from tmstzipcode 
	where sido = :ls_sido and gugun = :ls_gugun and dong = :ls_dong and note1 = :ls_note1;
End If

sle_1.text = trim(ls_zipcode)
st_3.text = ls_sido + '  ' + ls_gugun + '  ' + ls_dong + '  ' + ls_note1

cb_1.Setfocus()

end event

on w_zipcode.create
this.cb_2=create cb_2
this.st_7=create st_7
this.st_6=create st_6
this.st_4=create st_4
this.cb_1=create cb_1
this.st_3=create st_3
this.sle_1=create sle_1
this.st_2=create st_2
this.st_1=create st_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_2,&
this.st_7,&
this.st_6,&
this.st_4,&
this.cb_1,&
this.st_3,&
this.sle_1,&
this.st_2,&
this.st_1,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.gb_1,&
this.gb_2}
end on

on w_zipcode.destroy
destroy(this.cb_2)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;dw_1.SetTransObject(sqlcmms)
//dw_2.SetTransObject(sqlcmms)
//dw_3.SetTransObject(sqlcmms)
//dw_4.SetTransObject(sqlcmms)

dw_1.InsertRow(0)
dw_2.InsertRow(0)
dw_3.InsertRow(0)
dw_4.InsertRow(0)

cb_2.setfocus()
f_win_center(w_zipcode)

end event

type cb_2 from commandbutton within w_zipcode
integer x = 1298
integer y = 52
integer width = 288
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취 소"
end type

event clicked;close(parent)

end event

type st_7 from statictext within w_zipcode
integer x = 978
integer y = 564
integer width = 229
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "번지/호"
boolean focusrectangle = false
end type

type st_6 from statictext within w_zipcode
integer x = 1175
integer y = 424
integer width = 169
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "읍/면"
boolean focusrectangle = false
end type

type st_4 from statictext within w_zipcode
integer x = 1445
integer y = 292
integer width = 165
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "구/군"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_zipcode
integer x = 1006
integer y = 52
integer width = 288
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;string ls_zipcode

If sle_1.text = '' then
	ls_zipcode = ''
Else	
	ls_zipcode = sle_1.text + st_3.text	
End if	

closewithreturn(parent,ls_zipcode)
end event

type st_3 from statictext within w_zipcode
integer x = 37
integer y = 696
integer width = 1586
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 16776960
long backcolor = 0
string text = " ☞  해당하는 지역을 선택한 후 확인 버튼을 누르십시오!"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_zipcode
integer x = 471
integer y = 60
integer width = 293
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 33277894
string text = "   -"
boolean autohscroll = false
integer limit = 7
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_zipcode
integer x = 87
integer y = 76
integer width = 334
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "우편번호:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_zipcode
integer x = 677
integer y = 292
integer width = 169
integer height = 56
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "시/도"
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_zipcode
integer x = 73
integer y = 540
integer width = 891
integer height = 104
integer taborder = 60
string title = "none"
string dataobject = "d_zip_note1"
boolean border = false
boolean livescroll = true
end type

event itemchanged;Parent.TriggerEvent('ue_selectcond')
end event

type dw_3 from datawindow within w_zipcode
integer x = 73
integer y = 408
integer width = 1083
integer height = 104

integer taborder = 50
string title = "none"
string dataobject = "d_zip_dong"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long ll_row, ll_child
DataWindowChild state_child

dw_3.AcceptText()
is_dong = dw_3.GetItemString(1,1)

dw_4.GetChild('note1', state_child)
state_child.SetTransObject(sqlcmms)
ll_child	=	state_child.Retrieve(is_sido,is_gugun,is_dong)

dw_4.reset()
dw_4.insertrow(0)
if ll_child > 0 then
	dw_4.setitem(1, 'note1', state_child.getitemstring(1, 'note1'))	
end if

Parent.TriggerEvent('ue_selectcond')
end event

type dw_2 from datawindow within w_zipcode
integer x = 841
integer y = 272
integer width = 603
integer height = 120
integer taborder = 40
string title = "none"
string dataobject = "d_zip_gugun"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long ll_row, ll_child, ll_child1
string ls_dong
DataWindowChild state_child,state_Child1

dw_2.AcceptText()
is_gugun = dw_2.GetItemString(1,1)

dw_3.GetChild('dong', state_child)
state_child.SetTransObject(sqlcmms)
ll_child	=	state_child.Retrieve(is_sido,is_gugun)

dw_3.reset()
dw_3.insertrow(0)
if ll_child > 0 then
	ls_dong = state_child.getitemstring(1, 'dong')
	is_dong = ls_dong
	dw_3.setitem(1, 'dong', ls_dong)
end if

dw_4.GetChild('note1',state_child1)
state_child1.SetTransObject(sqlcmms)
ll_child1 = state_child1.Retrieve(is_sido,is_gugun,is_dong)

dw_4.reset()
dw_4.insertrow(0)
If ll_Child1 > 0 then
	dw_4.SetItem(1,'note1',state_child1.GetItemString(1,'note1'))
End If	

Parent.TriggerEvent('ue_selectcond')
end event

type dw_1 from datawindow within w_zipcode
integer x = 73
integer y = 272
integer width = 608
integer height = 104
integer taborder = 30
string title = "none"
string dataobject = "d_zip_sido"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long ll_row, ll_child, ll_child1, ll_Child2
String ls_sido,ls_gugun,ls_dong
DataWindowChild state_child 
DatawindowChild state_child1
DatawindowChild state_child2

dw_1.AcceptText()
ls_sido = dw_1.GetItemString(1,1)
is_sido = ls_sido

//해당 구/군
dw_2.GetChild('gugun', state_child)
state_child.SetTransObject(sqlcmms)
ll_child	=	state_child.Retrieve(data)

dw_2.reset()
dw_2.insertrow(0)
if ll_child > 0 then	
	ls_gugun = state_child.getitemstring(1, 'gugun')
	is_gugun = ls_gugun
	dw_2.setitem(1, 'gugun', ls_gugun)	
end if

//해당 동
dw_3.Getchild('dong',state_child1)
state_child1.SetTransObject(sqlcmms)
ll_child1 = state_child1.Retrieve(ls_sido,ls_gugun)

dw_3.reset()
dw_3.insertrow(0)
If ll_child1 > 0 then
	ls_dong = state_child1.GetItemString(1,'dong')
	is_dong = ls_dong
	dw_3.SetItem(1,'dong',ls_dong)
End if	

//해당 세부주소
dw_4.Getchild('note1',state_child2)
state_child2.SetTransObject(sqlcmms)
ll_Child2 = state_child2.Retrieve(ls_sido,ls_gugun,ls_dong)

dw_4.reset()
dw_4.insertrow(0)
If ll_Child2 > 0 then
	dw_4.SetItem(1,'note1',state_Child2.GetItemString(1,'note1'))
End If	

Parent.TriggerEvent('ue_selectcond')
end event

type gb_1 from groupbox within w_zipcode
integer x = 37
integer y = 200
integer width = 1577
integer height = 472
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
string text = "주소"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_zipcode
integer x = 37
integer width = 1577
integer height = 184
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

