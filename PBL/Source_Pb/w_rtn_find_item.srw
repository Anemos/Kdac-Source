$PBExportHeader$w_rtn_find_item.srw
$PBExportComments$Routin 품번 찾기(품명으로) Response Window
forward
global type w_rtn_find_item from window
end type
type cb_3 from commandbutton within w_rtn_find_item
end type
type sle_1 from singlelineedit within w_rtn_find_item
end type
type cb_2 from commandbutton within w_rtn_find_item
end type
type cb_1 from commandbutton within w_rtn_find_item
end type
type dw_1 from datawindow within w_rtn_find_item
end type
type gb_1 from groupbox within w_rtn_find_item
end type
end forward

global type w_rtn_find_item from window
integer x = 901
integer y = 600
integer width = 1929
integer height = 1448
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
global w_rtn_find_item w_rtn_find_item

on w_rtn_find_item.create
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

on w_rtn_find_item.destroy
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;string ls_pdcd, ls_parm,ls_prname

dw_1.settransobject(sqlca)
dw_1.reset() 
ls_parm 		= message.stringparm
ls_pdcd 		= mid(ls_parm,11,2)
select prname into:ls_prname from pbcommon.dac007
	where prprcd = :ls_pdcd 
using sqlca;
sle_1.text 	= ls_prname

end event

type cb_3 from commandbutton within w_rtn_find_item
integer x = 1554
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

event clicked;string 	ls_parm,ls_plant,ls_div,ls_pdcd,ls_itno,ls_date
integer 	ln_row

dw_1.reset()
ls_parm 		= message.stringparm
ls_plant 	= mid(ls_parm,9,1)
ls_div   	= mid(ls_parm,10,1)
ls_pdcd  	= mid(ls_parm,11,2) + "%"
ls_date  	= mid(ls_parm,1,8)

if f_spacechk(sle_1.text) = -1 then
	messagebox("확인","검색어를 입력하세요")
   return
end if

ls_itno 	= "%" + upper(trim(sle_1.text)) + "%"
ln_row 	= dw_1.retrieve(ls_plant,ls_div,ls_pdcd,ls_itno,ls_date)
if ln_row < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type sle_1 from singlelineedit within w_rtn_find_item
integer x = 87
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
long backcolor = 15780518
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_rtn_find_item
integer x = 1527
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

event clicked;string ls_itno

ls_itno = ""
closewithreturn(parent,ls_itno)
end event

type cb_1 from commandbutton within w_rtn_find_item
integer x = 1202
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

event clicked;string 	ls_itno
integer 	ls_row

ls_row 	= dw_1.getrow()
ls_itno 	= dw_1.getitemstring(ls_row, "itno")
if f_spacechk(ls_itno) = -1 then
	messagebox("확인","품번을 선택하세요")
	return
else
	closewithreturn(parent,ls_itno)
end if
end event

type dw_1 from datawindow within w_rtn_find_item
integer x = 46
integer y = 336
integer width = 1783
integer height = 824
string title = "none"
string dataobject = "d_rtn_dw_finditem"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string 	ls_itno
this.selectrow(0,false)
this.selectrow(row,true)
ls_itno 	= dw_1.getitemstring(row,"itno")
if f_spacechk(ls_itno) = -1 then
	messagebox("확인","품번을 선택하세요")
	return
else
	closewithreturn(parent,ls_itno)
end if



end event

type gb_1 from groupbox within w_rtn_find_item
integer x = 50
integer y = 32
integer width = 859
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

