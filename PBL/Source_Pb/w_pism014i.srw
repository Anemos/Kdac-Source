$PBExportHeader$w_pism014i.srw
$PBExportComments$¹ýÁ¤ÈÞ°Ô½Ã°£ °è»ê³»¿ª Á¶È¸
forward
global type w_pism014i from w_pism_resp01
end type
type cb_close from commandbutton within w_pism014i
end type
type dw_suppresttime from u_pism_dw within w_pism014i
end type
type dw_resttime from u_pism_dw within w_pism014i
end type
type st_wday from statictext within w_pism014i
end type
type st_wccode from statictext within w_pism014i
end type
type st_wcname from statictext within w_pism014i
end type
type st_2 from statictext within w_pism014i
end type
type st_1 from statictext within w_pism014i
end type
type gb_2 from groupbox within w_pism014i
end type
type gb_1 from groupbox within w_pism014i
end type
end forward

global type w_pism014i from w_pism_resp01
integer width = 2606
integer height = 2148
string title = "¹ýÁ¤ÈÞ°Ô½Ã°£ °è»ê³»¿ª"
cb_close cb_close
dw_suppresttime dw_suppresttime
dw_resttime dw_resttime
st_wday st_wday
st_wccode st_wccode
st_wcname st_wcname
st_2 st_2
st_1 st_1
gb_2 gb_2
gb_1 gb_1
end type
global w_pism014i w_pism014i

on w_pism014i.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.dw_suppresttime=create dw_suppresttime
this.dw_resttime=create dw_resttime
this.st_wday=create st_wday
this.st_wccode=create st_wccode
this.st_wcname=create st_wcname
this.st_2=create st_2
this.st_1=create st_1
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.dw_suppresttime
this.Control[iCurrent+3]=this.dw_resttime
this.Control[iCurrent+4]=this.st_wday
this.Control[iCurrent+5]=this.st_wccode
this.Control[iCurrent+6]=this.st_wcname
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_1
end on

on w_pism014i.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.dw_suppresttime)
destroy(this.dw_resttime)
destroy(this.st_wday)
destroy(this.st_wccode)
destroy(this.st_wcname)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;call super::open;st_wday.Text = istr_mh.wday 
st_wccode.Text = istr_mh.wc; st_wcname.Text = f_pism_getwcname(istr_mh) 

This.TriggerEvent("ue_retrieve")

end event

event ue_retrieve;call super::ue_retrieve;Decimal{1} ld_calcRestTime 

dw_resttime.SetTransObject(SqlPIS); dw_suppresttime.SetTransObject(SqlPIS) 
dw_resttime.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday, '%', ld_calcRestTime) 
dw_suppresttime.Retrieve(istr_mh.area, istr_mh.div, istr_mh.wc, istr_mh.wday) 

end event

type cb_close from commandbutton within w_pism014i
integer x = 2062
integer y = 40
integer width = 503
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
string text = "´Ý±â"
end type

event clicked;Close(Parent) 
end event

type dw_suppresttime from u_pism_dw within w_pism014i
integer x = 18
integer y = 1236
integer width = 2546
integer height = 800
integer taborder = 30
string dataobject = "d_pism010u_calcsuppresttime"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

type dw_resttime from u_pism_dw within w_pism014i
integer x = 18
integer y = 156
integer width = 2546
integer height = 1072
integer taborder = 20
string dataobject = "d_pism010u_calcresttime"
boolean hscrollbar = true
boolean vscrollbar = true
integer ii_selection = 1
end type

type st_wday from statictext within w_pism014i
integer x = 1591
integer y = 48
integer width = 421
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_wccode from statictext within w_pism014i
integer x = 197
integer y = 48
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_wcname from statictext within w_pism014i
integer x = 457
integer y = 48
integer width = 709
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pism014i
integer x = 64
integer y = 60
integer width = 142
integer height = 48
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
string text = "Á¶:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pism014i
integer x = 1262
integer y = 60
integer width = 338
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
string text = "ÀÛ¾÷ÀÏÀÚ:"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_pism014i
integer x = 14
integer width = 1211
integer height = 140
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pism014i
integer x = 1230
integer width = 809
integer height = 140
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

