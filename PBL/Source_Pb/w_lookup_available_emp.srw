$PBExportHeader$w_lookup_available_emp.srw
forward
global type w_lookup_available_emp from window
end type
type uo_date from u_today within w_lookup_available_emp
end type
type cb_1 from commandbutton within w_lookup_available_emp
end type
type st_2 from statictext within w_lookup_available_emp
end type
type cb_3 from commandbutton within w_lookup_available_emp
end type
type cb_ok from commandbutton within w_lookup_available_emp
end type
type dw_code from datawindow within w_lookup_available_emp
end type
type gb_2 from groupbox within w_lookup_available_emp
end type
type gb_1 from groupbox within w_lookup_available_emp
end type
end forward

global type w_lookup_available_emp from window
integer x = 233
integer y = 176
integer width = 2683
integer height = 1808
boolean titlebar = true
string title = "¿€æ˜¿⁄∫∞ ø©¿ØΩ√∞£"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
event ue_set_lookup_datawindow ( )
event ue_show_date ( )
event ue_hide_date ( )
uo_date uo_date
cb_1 cb_1
st_2 st_2
cb_3 cb_3
cb_ok cb_ok
dw_code dw_code
gb_2 gb_2
gb_1 gb_1
end type
global w_lookup_available_emp w_lookup_available_emp

type variables
string is_original_sql
string is_filter
long il_selectedrow

end variables

on w_lookup_available_emp.create
this.uo_date=create uo_date
this.cb_1=create cb_1
this.st_2=create st_2
this.cb_3=create cb_3
this.cb_ok=create cb_ok
this.dw_code=create dw_code
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.uo_date,&
this.cb_1,&
this.st_2,&
this.cb_3,&
this.cb_ok,&
this.dw_code,&
this.gb_2,&
this.gb_1}
end on

on w_lookup_available_emp.destroy
destroy(this.uo_date)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.cb_3)
destroy(this.cb_ok)
destroy(this.dw_code)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;string ls_dw
str_lookup str_param
long ll_row
datetime ldt

str_param = Message.PowerObjectParm

if isnull(str_param.ldt) then
	uo_date.sle_date.text = string(g_s_date,"@@@@-@@-@@")
else
	uo_date.sle_date.text = string(str_param.ldt, 'yyyy-mm-dd')	
end if

dw_code.SetTransobject(sqlcmms)

ldt = datetime(date(uo_date.sle_date.text), time('00:00:00'))

dw_code.Retrieve(ldt)

if dw_code.RowCount() > 0 then
	ll_row = dw_code.find(' #1 = ' + "'" + str_param.ls_value + "'", 1, dw_code.RowCount())
	if ll_row > 0 then
		dw_code.SelectRow(0, false)
		dw_code.SetRow(ll_row)
		dw_code.SelectRow(ll_row, true)
		dw_code.ScrollToRow(ll_row)
	end if
end if
		
this.move(str_param.ll_x, str_param.ll_y)


end event

type uo_date from u_today within w_lookup_available_emp
event destroy ( )
integer x = 247
integer y = 92
integer taborder = 70
end type

on uo_date.destroy
call u_today::destroy
end on

type cb_1 from commandbutton within w_lookup_available_emp
integer x = 1358
integer y = 84
integer width = 384
integer height = 108
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±º∏≤"
string text = "ªı∑Œ∞Ìƒß"
end type

event clicked;datetime ldt

dw_code.SetTransObject(sqlcmms)

ldt = datetime(date(uo_date.sle_date.text), time('00:00:00'))
dw_code.Retrieve(ldt)
end event

type st_2 from statictext within w_lookup_available_emp
integer x = 64
integer y = 108
integer width = 151
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±º∏≤"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "¿œ¿⁄:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_lookup_available_emp
integer x = 2194
integer y = 80
integer width = 416
integer height = 116
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±º∏≤"
string text = "√Î º“"
boolean cancel = true
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_lookup_available_emp
integer x = 1760
integer y = 80
integer width = 416
integer height = 116
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±º∏≤"
string text = "»Æ ¿Œ"
boolean default = true
end type

event clicked;string ls_code
long ll_row

ll_row = dw_code.GetRow()
ls_code = dw_code.GetItemString(ll_row, 'empcode')
closewithreturn(parent, ls_code)
end event

type dw_code from datawindow within w_lookup_available_emp
event uo_lbuttondown pbm_lbuttondown
event uo_mousemove pbm_mousemove
event uo_lbuttonup pbm_lbuttonup
integer x = 18
integer y = 240
integer width = 2619
integer height = 1452
integer taborder = 10
string dragicon = "lookup.ico"
string dataobject = "d_lookup_emp_labor_available"
boolean hscrollbar = true
boolean vscrollbar = true
string icon = "lookup.ico"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if currentrow <= 0 then return

selectrow(0, false)
setrow(currentrow)
selectrow(currentrow, true)


end event

event clicked;this.Post Event RowFocusChanged(row)
end event

event doubleclicked;if row <= 0 then return

cb_ok.triggerevent('clicked')
end event

event rbuttondown;
m_sort_pop	lm_popmenu
lm_popmenu = CREATE m_sort_pop

lm_popmenu.m_action.m_suppression.visible = false
lm_popmenu.m_action.m_mode.visible = false
lm_popmenu.m_action.m_free.visible = false

lm_popmenu.m_action.popmenu(parent.PointerX(), parent.PointerY())




end event

type gb_2 from groupbox within w_lookup_available_emp
integer x = 1298
integer y = 12
integer width = 1339
integer height = 212
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±º∏≤"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within w_lookup_available_emp
integer x = 23
integer y = 12
integer width = 1285
integer height = 212
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±º∏≤"
long textcolor = 33554432
long backcolor = 67108864
end type

