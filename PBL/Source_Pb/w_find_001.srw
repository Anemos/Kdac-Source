$PBExportHeader$w_find_001.srw
$PBExportComments$업체,부서코드 검색
forward
global type w_find_001 from window
end type
type rb_2 from radiobutton within w_find_001
end type
type rb_1 from radiobutton within w_find_001
end type
type cb_3 from commandbutton within w_find_001
end type
type sle_1 from singlelineedit within w_find_001
end type
type cb_2 from commandbutton within w_find_001
end type
type cb_1 from commandbutton within w_find_001
end type
type dw_1 from datawindow within w_find_001
end type
type gb_1 from groupbox within w_find_001
end type
end forward

global type w_find_001 from window
integer x = 599
integer y = 900
integer width = 1710
integer height = 1416
boolean titlebar = true
string title = "사용처 찾기"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 12632256
rb_2 rb_2
rb_1 rb_1
cb_3 cb_3
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_find_001 w_find_001

on w_find_001.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_3=create cb_3
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.cb_3,&
this.sle_1,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_1}
end on

on w_find_001.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;string l_s_parm , l_s_rbdvsn, l_s_rbvend
l_s_parm = message.stringparm
l_s_rbdvsn = mid(l_s_parm,1,1)
l_s_rbvend = mid(l_s_parm,2,1)
rb_1.checked = false
rb_2.checked = false
rb_1.enabled = true
rb_2.enabled = true
if l_s_rbvend = ' ' then
//	rb_2.checked = false
//	rb_1.checked = true	
//	rb_2.enabled = false
elseif l_s_rbvend = 'O' then
	rb_1.checked = false
	rb_2.checked = true
	rb_1.enabled = false
elseif l_s_rbvend = 'I' then
	rb_2.checked = false
	rb_1.checked = true	
	rb_2.enabled = false
end if
RETURN


end event

type rb_2 from radiobutton within w_find_001
integer x = 50
integer y = 208
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "외부 업체"
end type

type rb_1 from radiobutton within w_find_001
integer x = 50
integer y = 108
integer width = 457
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "사내 Line"
end type

type cb_3 from commandbutton within w_find_001
integer x = 1335
integer y = 192
integer width = 261
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "검 색"
boolean default = true
end type

event clicked;string l_s_parm, l_s_rbdvsn , l_s_rbvend, l_s_find_word
integer l_n_row
l_s_parm = message.stringparm
l_s_rbdvsn = mid(l_s_parm,1,1)
l_s_rbvend = mid(l_s_parm,2,1)

if f_spacechk(sle_1.text) = -1 then
	messagebox("확인","검색어를 입력하세요")
   return
end if
if rb_1.checked = false and rb_2.checked = false then 
	messagebox("확인","구분코드를 Check 하세요")
   return
end if
if rb_1.checked = true then
	dw_1.dataobject = 'd_find001_dac002'
else
	dw_1.dataobject = 'd_find001_pur101'
end if
dw_1.settransobject(sqlca)
dw_1.reset()
	
l_s_find_word = "%" + upper(trim(sle_1.text)) + "%"
if rb_1.checked = true then
	l_n_row = dw_1.retrieve(l_s_find_word)
elseif rb_2.checked = true then
	l_n_row = dw_1.retrieve(l_s_find_word)
end if
if l_n_row < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type sle_1 from singlelineedit within w_find_001
integer x = 635
integer y = 152
integer width = 645
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

type cb_2 from commandbutton within w_find_001
integer x = 1303
integer y = 1192
integer width = 288
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 700
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

type cb_1 from commandbutton within w_find_001
integer x = 978
integer y = 1192
integer width = 288
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;string l_s_return_code
integer l_s_row

l_s_row = dw_1.getrow()

l_s_return_code =  string(dw_1.object.returncode[l_s_row],"@@@@@") &
						+ string(dw_1.object.returncode2[l_s_row],"@@@@@@@@@@") &
						+ string(dw_1.object.returncode1[l_s_row],"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
if f_spacechk(l_s_return_code) = -1 then
	messagebox("확인","코드를 선택하세요")
	return
else
	closewithreturn(parent,l_s_return_code)
end if
end event

type dw_1 from datawindow within w_find_001
integer x = 46
integer y = 336
integer width = 1550
integer height = 824
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string l_s_return_code
l_s_return_code =  string(this.object.returncode[row],"@@@@@") &
						+ string(this.object.returncode2[row],"@@@@@@@@@@") &
						+ string(this.object.returncode1[row],"@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@")
if f_spacechk(l_s_return_code) = -1 then
	messagebox("확인","코드를 선택하세요")
	return
else
	closewithreturn(parent,l_s_return_code)
end if


end event

event clicked;this.selectrow(0,false)
this.selectrow(row,true)
end event

type gb_1 from groupbox within w_find_001
integer x = 599
integer y = 64
integer width = 722
integer height = 252
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "검색어"
end type

