$PBExportHeader$w_piss611s.srw
$PBExportComments$INVOICE NO 선택화면
forward
global type w_piss611s from window
end type
type cb_close from commandbutton within w_piss611s
end type
type cb_select from commandbutton within w_piss611s
end type
type dw_piss611s_01 from datawindow within w_piss611s
end type
type gb_1 from groupbox within w_piss611s
end type
end forward

global type w_piss611s from window
integer width = 2555
integer height = 1132
boolean titlebar = true
string title = "Ship Request 선택"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_select cb_select
dw_piss611s_01 dw_piss611s_01
gb_1 gb_1
end type
global w_piss611s w_piss611s

type variables
str_parms istr_parm
end variables

on w_piss611s.create
this.cb_close=create cb_close
this.cb_select=create cb_select
this.dw_piss611s_01=create dw_piss611s_01
this.gb_1=create gb_1
this.Control[]={this.cb_close,&
this.cb_select,&
this.dw_piss611s_01,&
this.gb_1}
end on

on w_piss611s.destroy
destroy(this.cb_close)
destroy(this.cb_select)
destroy(this.dw_piss611s_01)
destroy(this.gb_1)
end on

event open;string ls_area, ls_division, ls_invoiceno

dw_piss611s_01.settransobject(sqlpis)

istr_parm = message.Powerobjectparm
ls_area = istr_parm.string_arg[1]
ls_division = istr_parm.string_arg[2]
ls_invoiceno = istr_parm.string_arg[3]

if dw_piss611s_01.retrieve(ls_area, ls_division, ls_invoiceno) < 1 then
	istr_parm.integer_arg[1] = -1
	closewithreturn( this, istr_parm)
end if

end event

type cb_close from commandbutton within w_piss611s
integer x = 2103
integer y = 884
integer width = 347
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;istr_parm.integer_arg[1] = -1
closewithreturn(w_piss611s,istr_parm)
end event

type cb_select from commandbutton within w_piss611s
integer x = 1664
integer y = 884
integer width = 347
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "선택"
end type

event clicked;long ll_selrow

ll_selrow = dw_piss611s_01.getselectedrow(0)

if ll_selrow < 1 then
	messagebox("확인","선택된 데이타가 없습니다.")
	return 0
end if

istr_parm.string_arg[4] = dw_piss611s_01.getitemstring(ll_selrow,"customercode")
istr_parm.string_arg[5] = dw_piss611s_01.getitemstring(ll_selrow,"customeritemcode")
istr_parm.string_arg[6] = dw_piss611s_01.getitemstring(ll_selrow,"itemcode")
istr_parm.string_arg[7] = dw_piss611s_01.getitemstring(ll_selrow,"srno")
istr_parm.string_arg[8] = dw_piss611s_01.getitemstring(ll_selrow,"customername")
istr_parm.long_arg[1] = dw_piss611s_01.getitemnumber(ll_selrow,"shiporderqty")
istr_parm.integer_arg[1] = 0

closewithreturn(w_piss611s, istr_parm)


end event

type dw_piss611s_01 from datawindow within w_piss611s
integer x = 9
integer y = 16
integer width = 2514
integer height = 828
integer taborder = 10
string title = "none"
string dataobject = "d_piss611s_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if currentrow < 1 then
	return -1
end if

This.Selectrow( 0, False )
This.Selectrow( currentrow, True )
end event

type gb_1 from groupbox within w_piss611s
integer x = 14
integer y = 844
integer width = 2505
integer height = 152
integer taborder = 20
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

