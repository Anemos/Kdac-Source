$PBExportHeader$w_rtn_select_pl.srw
$PBExportComments$PL ÁöÁ¤(RTN019)
forward
global type w_rtn_select_pl from window
end type
type st_1 from statictext within w_rtn_select_pl
end type
type cb_close from commandbutton within w_rtn_select_pl
end type
type dw_dac003 from datawindow within w_rtn_select_pl
end type
end forward

global type w_rtn_select_pl from window
integer x = 302
integer y = 500
integer width = 1943
integer height = 1144
boolean titlebar = true
string title = "ºÎ¼­ Filter"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_close cb_close
dw_dac003 dw_dac003
end type
global w_rtn_select_pl w_rtn_select_pl

type variables

end variables

on w_rtn_select_pl.create
this.st_1=create st_1
this.cb_close=create cb_close
this.dw_dac003=create dw_dac003
this.Control[]={this.st_1,&
this.cb_close,&
this.dw_dac003}
end on

on w_rtn_select_pl.destroy
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.dw_dac003)
end on

event open;f_sysdate()
if dw_dac003.retrieve(g_s_deptcd)	<	1 then
	close(this)
end if

end event

type st_1 from statictext within w_rtn_select_pl
integer x = 5
integer y = 12
integer width = 453
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
string text = "[ÆÀ¿ø LIST]"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_rtn_select_pl
integer x = 1417
integer y = 948
integer width = 485
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
string text = "´Ý±â"
end type

event clicked;long ll_selrow
string ls_plemp

ll_selrow = dw_dac003.getselectedrow(0)

if ll_selrow > 0 then
	ls_plemp = dw_dac003.getitemstring(ll_selrow,"peempno")
	INSERT INTO PBRTN.RTN019( Xcmcd, Xinemp, Xplemp, Xmacaddr, Xipaddr, Xindt )
	VALUES(:g_s_company, :g_s_empno, :ls_plemp, :g_s_macaddr, :g_s_ipaddr, :g_s_date)
	using sqlca;
end if

Close(Parent) 
end event

type dw_dac003 from datawindow within w_rtn_select_pl
integer y = 92
integer width = 1902
integer height = 832
integer taborder = 10
string dataobject = "d_rtn_dac003"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca) ;
end event

event clicked;if row <= 0 then
	return
end if
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

