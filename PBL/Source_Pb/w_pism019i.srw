$PBExportHeader$w_pism019i.srw
$PBExportComments$작업일보 작성 현황 - Response
forward
global type w_pism019i from w_pism_resp01
end type
type cb_close from commandbutton within w_pism019i
end type
type cb_edit from commandbutton within w_pism019i
end type
type cb_add from commandbutton within w_pism019i
end type
type st_wccode from statictext within w_pism019i
end type
type st_wcname from statictext within w_pism019i
end type
type dw_nodailylist from u_pism_dw within w_pism019i
end type
type st_2 from statictext within w_pism019i
end type
type gb_2 from groupbox within w_pism019i
end type
end forward

global type w_pism019i from w_pism_resp01
integer width = 1883
integer height = 2060
string title = "미확정&미작성 작업일보 현황"
cb_close cb_close
cb_edit cb_edit
cb_add cb_add
st_wccode st_wccode
st_wcname st_wcname
dw_nodailylist dw_nodailylist
st_2 st_2
gb_2 gb_2
end type
global w_pism019i w_pism019i

on w_pism019i.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_edit=create cb_edit
this.cb_add=create cb_add
this.st_wccode=create st_wccode
this.st_wcname=create st_wcname
this.dw_nodailylist=create dw_nodailylist
this.st_2=create st_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_edit
this.Control[iCurrent+3]=this.cb_add
this.Control[iCurrent+4]=this.st_wccode
this.Control[iCurrent+5]=this.st_wcname
this.Control[iCurrent+6]=this.dw_nodailylist
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.gb_2
end on

on w_pism019i.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_edit)
destroy(this.cb_add)
destroy(this.st_wccode)
destroy(this.st_wcname)
destroy(this.dw_nodailylist)
destroy(this.st_2)
destroy(this.gb_2)
end on

event open;call super::open;st_wccode.Text = istr_mh.wc; st_wcname.Text = f_pism_getwcname(istr_mh) 
//st_stmonth.Text = mid(istr_mh.wday,1,7) 

cb_add.Enabled = m_frame.m_action.m_save.Enabled 

This.TriggerEvent("ue_retrieve") 
end event

event ue_retrieve;call super::ue_retrieve;dw_nodailylist.SetTransObject(SqlPIS)
dw_nodailylist.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, '') 
end event

type cb_close from commandbutton within w_pism019i
integer x = 1390
integer y = 1864
integer width = 457
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;Close(Parent) 
end event

type cb_edit from commandbutton within w_pism019i
integer x = 933
integer y = 1864
integer width = 457
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;istr_mh.longparm = 2 

CloseWithReturn(Parent, istr_mh)
end event

type cb_add from commandbutton within w_pism019i
integer x = 475
integer y = 1864
integer width = 457
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "작성"
end type

event clicked;istr_mh.longparm = 1

CloseWithReturn(Parent, istr_mh)
end event

type st_wccode from statictext within w_pism019i
integer x = 197
integer y = 48
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_wcname from statictext within w_pism019i
integer x = 457
integer y = 48
integer width = 709
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_nodailylist from u_pism_dw within w_pism019i
integer y = 152
integer width = 1847
integer height = 1700
integer taborder = 10
string dataobject = "d_pism019i_01"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

event rowfocuschanged;call super::rowfocuschanged;Boolean lb_addEnabled 
String ls_dailyStatus 

If currentrow <= 0 Then Return 

ls_dailyStatus = This.GetItemString(currentrow, "dailystatus")
If ls_dailyStatus = 'X' Then lb_addEnabled = True 
cb_edit.Enabled = Not lb_addEnabled 

If lb_addEnabled Then lb_addEnabled = m_frame.m_action.m_save.Enabled 
cb_add.Enabled = lb_addEnabled 

istr_mh.wday = This.GetItemString(currentrow, "workday")
end event

event doubleclicked;call super::doubleclicked;If row <= 0 Then Return 

If cb_add.Enabled Then cb_add.TriggerEvent(Clicked!)
If cb_edit.Enabled Then cb_edit.TriggerEvent(Clicked!)
end event

type st_2 from statictext within w_pism019i
integer x = 64
integer y = 60
integer width = 142
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조:"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_pism019i
integer x = 14
integer width = 1211
integer height = 140
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

