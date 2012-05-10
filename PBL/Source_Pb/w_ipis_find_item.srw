$PBExportHeader$w_ipis_find_item.srw
$PBExportComments$Routin 품번 찾기(품명으로) Response Window
forward
global type w_ipis_find_item from window
end type
type cb_3 from commandbutton within w_ipis_find_item
end type
type sle_1 from singlelineedit within w_ipis_find_item
end type
type cb_2 from commandbutton within w_ipis_find_item
end type
type cb_1 from commandbutton within w_ipis_find_item
end type
type dw_1 from datawindow within w_ipis_find_item
end type
type gb_1 from groupbox within w_ipis_find_item
end type
end forward

global type w_ipis_find_item from window
integer x = 901
integer y = 600
integer width = 2478
integer height = 1432
boolean titlebar = true
string title = "품번 찾기"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 12632256
cb_3 cb_3
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ipis_find_item w_ipis_find_item

on w_ipis_find_item.create
this.cb_3=create cb_3
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.cb_3,&
this.sle_1,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_ipis_find_item.destroy
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;string l_s_pdcd, l_s_parm

l_s_parm = message.stringparm

dw_1.settransobject(sqlpis)
dw_1.reset() 

end event

type cb_3 from commandbutton within w_ipis_find_item
integer x = 2098
integer y = 184
integer width = 261
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검 색"
boolean default = true
end type

event clicked;string l_s_itnm

dw_1.reset()

if f_spacechk(sle_1.text) = -1 then
	messagebox("확인","검색어를 입력하세요")
   return
end if

l_s_itnm = "%" + upper(trim(sle_1.text)) + "%"

if dw_1.retrieve(l_s_itnm) < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type sle_1 from singlelineedit within w_ipis_find_item
integer x = 87
integer y = 120
integer width = 1221
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_ipis_find_item
integer x = 2071
integer y = 1192
integer width = 288
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취 소"
end type

event clicked;string l_s_itno
l_s_itno = ""
closewithreturn(parent,l_s_itno)
end event

type cb_1 from commandbutton within w_ipis_find_item
integer x = 1746
integer y = 1192
integer width = 288
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;string l_s_itno,l_s_itnm
int    l_s_row

l_s_row = dw_1.getselectedrow(0)
if l_s_row <= 0 then
	return
end if
l_s_itno = string(dw_1.getitemstring(l_s_row,"itemcode"),"@@@@@@@@@@@@")
l_s_itnm = mid(dw_1.getitemstring(l_s_row,"itemname"),1,30)
if f_spacechk(l_s_itno) = -1 then
	messagebox("확인","품번을 선택하세요")
	return
else
	closewithreturn(parent,l_s_itno + l_s_itnm)
end if



end event

type dw_1 from datawindow within w_ipis_find_item
integer x = 46
integer y = 336
integer width = 2313
integer height = 824
string title = "none"
string dataobject = "d_pisc_find_item"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string l_s_itno,l_s_itnm

this.selectrow(0,false)
this.selectrow(row,true)
l_s_itno = string(dw_1.getitemstring(row,"itemcode"),"@@@@@@@@@@@@")
l_s_itnm = mid(dw_1.getitemstring(row,"itemname"),1,30)
if f_spacechk(l_s_itno) = -1 then
	messagebox("확인","품번을 선택하세요")
	return
else
	closewithreturn(parent,l_s_itno + l_s_itnm)
end if



end event

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

type gb_1 from groupbox within w_ipis_find_item
integer x = 50
integer y = 32
integer width = 1294
integer height = 252
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "검색어( 품명으로 검색 )"
end type

