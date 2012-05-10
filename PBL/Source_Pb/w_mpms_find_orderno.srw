$PBExportHeader$w_mpms_find_orderno.srw
forward
global type w_mpms_find_orderno from window
end type
type rb_product from radiobutton within w_mpms_find_orderno
end type
type cb_close from commandbutton within w_mpms_find_orderno
end type
type cb_read from commandbutton within w_mpms_find_orderno
end type
type sle_query from singlelineedit within w_mpms_find_orderno
end type
type dw_mpms_find_orderno from datawindow within w_mpms_find_orderno
end type
type rb_tool from radiobutton within w_mpms_find_orderno
end type
type rb_order from radiobutton within w_mpms_find_orderno
end type
type gb_1 from groupbox within w_mpms_find_orderno
end type
type gb_2 from groupbox within w_mpms_find_orderno
end type
end forward

global type w_mpms_find_orderno from window
integer width = 3255
integer height = 1572
boolean titlebar = true
string title = "금형의뢰번호 찾기"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
rb_product rb_product
cb_close cb_close
cb_read cb_read
sle_query sle_query
dw_mpms_find_orderno dw_mpms_find_orderno
rb_tool rb_tool
rb_order rb_order
gb_1 gb_1
gb_2 gb_2
end type
global w_mpms_find_orderno w_mpms_find_orderno

on w_mpms_find_orderno.create
this.rb_product=create rb_product
this.cb_close=create cb_close
this.cb_read=create cb_read
this.sle_query=create sle_query
this.dw_mpms_find_orderno=create dw_mpms_find_orderno
this.rb_tool=create rb_tool
this.rb_order=create rb_order
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.rb_product,&
this.cb_close,&
this.cb_read,&
this.sle_query,&
this.dw_mpms_find_orderno,&
this.rb_tool,&
this.rb_order,&
this.gb_1,&
this.gb_2}
end on

on w_mpms_find_orderno.destroy
destroy(this.rb_product)
destroy(this.cb_close)
destroy(this.cb_read)
destroy(this.sle_query)
destroy(this.dw_mpms_find_orderno)
destroy(this.rb_tool)
destroy(this.rb_order)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;datawindowchild ldwc
dw_mpms_find_orderno.settransobject(sqlmpms)
rb_order.checked = True

dw_mpms_find_orderno.GetChild('ingstatus', ldwc)
ldwc.settransobject(sqlmpms)
ldwc.retrieve('MPM007')
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

f_pisc_set_dddw_width(dw_mpms_find_orderno,'ingstatus',ldwc,'codename',5)

sle_query.setfocus()
end event

type rb_product from radiobutton within w_mpms_find_orderno
integer x = 795
integer y = 112
integer width = 315
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "제품명"
end type

type cb_close from commandbutton within w_mpms_find_orderno
integer x = 2784
integer y = 84
integer width = 389
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;long ll_selrow
string ls_rtnparm

ll_selrow = dw_mpms_find_orderno.getselectedrow(0)

if ll_selrow > 0 then
	ls_rtnparm = dw_mpms_find_orderno.getitemstring(ll_selrow,'orderno')
	ls_rtnparm = ls_rtnparm + dw_mpms_find_orderno.getitemstring(ll_selrow,'toolname')
end if

closewithreturn(w_mpms_find_orderno,ls_rtnparm)
end event

type cb_read from commandbutton within w_mpms_find_orderno
integer x = 2359
integer y = 84
integer width = 389
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;string ls_orderno, ls_toolname, ls_productname, ls_query

ls_query = sle_query.text
if f_spacechk(ls_query) = -1 then
	messagebox("알림","조회할 내용을 입력하십시요")
	return 0
end if

if rb_order.checked then
	ls_orderno = '%' + trim(ls_query) + '%'
	ls_toolname = '%'
	ls_productname = '%'
elseif rb_tool.checked then
	ls_orderno = '%'
	ls_toolname = '%' + trim(ls_query) + '%'
	ls_productname = '%'
else
	ls_orderno = '%'
	ls_toolname = '%'
	ls_productname = '%' + trim(ls_query) + '%'
end if

If dw_mpms_find_orderno.retrieve( ls_orderno, ls_toolname, ls_productname ) < 1 then
	Messagebox("알림", "조회할 자료가 없습니다.")
end if



end event

type sle_query from singlelineedit within w_mpms_find_orderno
event ue_key pbm_keydown
integer x = 1166
integer y = 96
integer width = 1093
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event ue_key;IF Key = KeyEnter! THEN
	cb_read.triggerevent('clicked')
END IF
end event

type dw_mpms_find_orderno from datawindow within w_mpms_find_orderno
event ue_key pbm_keydown
integer x = 23
integer y = 232
integer width = 3191
integer height = 1200
integer taborder = 60
string title = "none"
string dataobject = "d_mpms_find_orderno"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_key;IF Key = KeyEnter! THEN
	cb_close.triggerevent('clicked')
END IF
end event

event rowfocuschanged;This.Selectrow( 0, False )
This.Selectrow( currentrow, True )
end event

event doubleclicked;string ls_rtnparm

if row > 0 then
	ls_rtnparm = dw_mpms_find_orderno.getitemstring(row,'orderno')
	ls_rtnparm = ls_rtnparm + dw_mpms_find_orderno.getitemstring(row,'toolname')
	closewithreturn(w_mpms_find_orderno,ls_rtnparm)
end if
end event

type rb_tool from radiobutton within w_mpms_find_orderno
integer x = 453
integer y = 112
integer width = 334
integer height = 64
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Tool명"
end type

type rb_order from radiobutton within w_mpms_find_orderno
integer x = 69
integer y = 112
integer width = 375
integer height = 64
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "OrderNo"
end type

type gb_1 from groupbox within w_mpms_find_orderno
integer x = 32
integer y = 28
integer width = 2263
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "조회조건"
end type

type gb_2 from groupbox within w_mpms_find_orderno
integer x = 2309
integer y = 28
integer width = 905
integer height = 188
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
end type

