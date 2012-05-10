$PBExportHeader$w_dacmaq_find.srw
$PBExportComments$이름찾기
forward
global type w_dacmaq_find from window
end type
type cb_2 from commandbutton within w_dacmaq_find
end type
type cb_1 from commandbutton within w_dacmaq_find
end type
type cb_3 from commandbutton within w_dacmaq_find
end type
type sle_name from singlelineedit within w_dacmaq_find
end type
type dw_find from datawindow within w_dacmaq_find
end type
type gb_1 from groupbox within w_dacmaq_find
end type
end forward

global type w_dacmaq_find from window
integer x = 599
integer y = 900
integer width = 2249
integer height = 1436
boolean titlebar = true
string title = "이름찾기"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_2 cb_2
cb_1 cb_1
cb_3 cb_3
sle_name sle_name
dw_find dw_find
gb_1 gb_1
end type
global w_dacmaq_find w_dacmaq_find

on w_dacmaq_find.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_3=create cb_3
this.sle_name=create sle_name
this.dw_find=create dw_find
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.cb_3,&
this.sle_name,&
this.dw_find,&
this.gb_1}
end on

on w_dacmaq_find.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_3)
destroy(this.sle_name)
destroy(this.dw_find)
destroy(this.gb_1)
end on

event open;dw_find.settransobject(Sqlca)
dw_find.reset()
end event

type cb_2 from commandbutton within w_dacmaq_find
integer x = 1915
integer y = 1224
integer width = 288
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "취 소"
end type

event clicked;String	ls_itno

ls_itno = ""
closewithreturn(parent,ls_itno)
end event

type cb_1 from commandbutton within w_dacmaq_find
integer x = 1600
integer y = 1224
integer width = 288
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "확 인"
end type

event clicked;String		ls_return_code
Integer 	ls_row

ls_row = dw_find.getrow()

ls_return_code = dw_find.object.dac003_peempno[ls_row] + string(dw_find.object.dac003_penamek[ls_row],"@@@@@@@@@@@@@@@@@@@@") 
						
if 	f_spacechk(ls_return_code) = -1 then
	messagebox("확인","코드를 선택하세요")
	return
else
	closewithreturn(parent,ls_return_code)
end if
end event

type cb_3 from commandbutton within w_dacmaq_find
integer x = 1925
integer y = 120
integer width = 261
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "검 색"
boolean default = true
end type

event clicked;String		ls_parm, ls_rbdvsn , ls_rbvend, ls_find_word
Integer 	ln_row

ls_parm = message.stringparm

if 	f_spacechk(sle_name.text) = -1 then
	messagebox("확인","검색어를 입력하세요")
   	return
end if
dw_find.reset()
ls_find_word = "%" + upper(trim(sle_name.text)) + "%"
if 	dw_find.retrieve(ls_find_word) < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type sle_name from singlelineedit within w_dacmaq_find
integer x = 50
integer y = 108
integer width = 645
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 15780518
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type dw_find from datawindow within w_dacmaq_find
integer y = 272
integer width = 2194
integer height = 916
string dataobject = "d_dacmaq_find"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

event doubleclicked;String		ls_return_code

ls_return_code = dw_find.object.dac003_peempno[row] + string(dw_find.object.dac003_penamek[row],"@@@@@@@@@@") 
if 	f_spacechk(ls_return_code) = -1 then
	messagebox("확인","코드를 선택하세요")
	return
else
	closewithreturn(parent,ls_return_code)
end if
end event

type gb_1 from groupbox within w_dacmaq_find
integer x = 9
integer y = 12
integer width = 722
integer height = 252
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "검색어"
end type

