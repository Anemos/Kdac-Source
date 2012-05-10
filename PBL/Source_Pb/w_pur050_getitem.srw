$PBExportHeader$w_pur050_getitem.srw
$PBExportComments$품번 찾기(품명및품번) Response Window
forward
global type w_pur050_getitem from window
end type
type dw_10 from datawindow within w_pur050_getitem
end type
type cb_4 from commandbutton within w_pur050_getitem
end type
type cb_3 from commandbutton within w_pur050_getitem
end type
type cb_2 from commandbutton within w_pur050_getitem
end type
type cb_1 from commandbutton within w_pur050_getitem
end type
type dw_1 from datawindow within w_pur050_getitem
end type
end forward

global type w_pur050_getitem from window
integer x = 201
integer y = 500
integer width = 2249
integer height = 1552
boolean titlebar = true
string title = "품번 찾기"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 12632256
dw_10 dw_10
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_pur050_getitem w_pur050_getitem

on w_pur050_getitem.create
this.dw_10=create dw_10
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.dw_10,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_pur050_getitem.destroy
destroy(this.dw_10)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;if message.stringparm = 'D' then
	dw_10.dataobject = 'd_pur050_getitem_11'
else
	dw_10.dataobject = 'd_pur050_getitem_10'
end if
dw_10.settransobject(sqlca)
dw_10.insertrow(0)
end event

type dw_10 from datawindow within w_pur050_getitem
integer x = 32
integer y = 36
integer width = 1605
integer height = 268
integer taborder = 70
string title = "none"
string dataobject = "d_pur050_getitem_10"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.insertrow(0)
end event

type cb_4 from commandbutton within w_pur050_getitem
integer x = 1742
integer y = 160
integer width = 361
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "품명검색"
end type

event clicked;string ls_xplan, ls_gubun, ls_itno, ls_rrogb
long ll_row

dw_10.accepttext()
ls_xplan = dw_10.getitemstring(1,'xplan')
if f_spacechk(ls_xplan) = -1 then
	messagebox("확인","담당을 선택하세요")
   return
end if
ls_gubun = dw_10.getitemstring(1,'gubun')
if f_spacechk(ls_gubun) = -1 then
	messagebox("확인","품목구분을 선택하세요")
   return
end if
ls_itno = dw_10.getitemstring(1,'itno')
if f_spacechk(ls_itno) = -1 then
	messagebox("확인","검색어를 입력하세요")
   return
end if
if message.stringparm = 'D' then
	ls_rrogb = 'D'
else
	ls_rrogb = 'I'
end if
ls_itno = upper(trim(ls_itno))
dw_1.dataobject = 'd_pur050_getitem_02'
dw_1.settransobject(sqlca)

ll_row = dw_1.retrieve(ls_xplan, ls_gubun, ls_itno,ls_rrogb)
if ll_row < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type cb_3 from commandbutton within w_pur050_getitem
integer x = 1742
integer y = 56
integer width = 361
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "품번검색"
boolean default = true
end type

event clicked;string ls_xplan, ls_gubun, ls_itno, ls_rrogb
long ll_row

dw_10.accepttext()
ls_xplan = dw_10.getitemstring(1,'xplan')
if f_spacechk(ls_xplan) = -1 then
	messagebox("확인","담당을 선택하세요")
   return
end if
ls_gubun = dw_10.getitemstring(1,'gubun')
if f_spacechk(ls_gubun) = -1 then
	messagebox("확인","품목구분을 선택하세요")
   return
end if
ls_itno = dw_10.getitemstring(1,'itno')
if f_spacechk(ls_itno) = -1 then
	messagebox("확인","검색어를 입력하세요")
   return
end if
if message.stringparm = 'D' then
	ls_rrogb = 'D'
else
	ls_rrogb = 'I'
end if

ls_itno = upper(trim(ls_itno))
dw_1.dataobject = 'd_pur050_getitem_01'
dw_1.settransobject(sqlca)

ll_row = dw_1.retrieve(ls_xplan, ls_gubun, ls_itno, ls_rrogb)
if ll_row < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type cb_2 from commandbutton within w_pur050_getitem
integer x = 1829
integer y = 1316
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

type cb_1 from commandbutton within w_pur050_getitem
integer x = 1518
integer y = 1316
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

event clicked;string ls_itno
integer ln_row

ln_row = dw_1.getrow()
ls_itno = dw_1.getitemstring(ln_row, "itno")
if f_spacechk(ls_itno) = -1 then
	messagebox("확인","품번을 선택하세요")
	return
else
	closewithreturn(parent,ls_itno)
end if
end event

type dw_1 from datawindow within w_pur050_getitem
integer x = 32
integer y = 316
integer width = 2098
integer height = 984
string title = "none"
string dataobject = "d_pur050_getitem_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string ls_itno
this.selectrow(0,false)
this.selectrow(row,true)
ls_itno = dw_1.getitemstring(row,"itno")
if f_spacechk(ls_itno) = -1 then
	messagebox("확인","품번을 선택하세요")
	return
else
	closewithreturn(parent,ls_itno)
end if



end event

