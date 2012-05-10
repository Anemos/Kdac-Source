$PBExportHeader$uo_commonstatus.sru
$PBExportComments$Window«œ¥‹ Status
forward
global type uo_commonstatus from userobject
end type
type st_time from statictext within uo_commonstatus
end type
type st_winid from statictext within uo_commonstatus
end type
type st_message from statictext within uo_commonstatus
end type
type st_kornm from statictext within uo_commonstatus
end type
type st_date from statictext within uo_commonstatus
end type
end forward

global type uo_commonstatus from userobject
integer width = 4608
integer height = 100
long backcolor = 12632256
long tabtextcolor = 33554432
long tabbackcolor = 16777215
long picturemaskcolor = 536870912
event wf_timer pbm_timer
st_time st_time
st_winid st_winid
st_message st_message
st_kornm st_kornm
st_date st_date
end type
global uo_commonstatus uo_commonstatus

on uo_commonstatus.create
this.st_time=create st_time
this.st_winid=create st_winid
this.st_message=create st_message
this.st_kornm=create st_kornm
this.st_date=create st_date
this.Control[]={this.st_time,&
this.st_winid,&
this.st_message,&
this.st_kornm,&
this.st_date}
end on

on uo_commonstatus.destroy
destroy(this.st_time)
destroy(this.st_winid)
destroy(this.st_message)
destroy(this.st_kornm)
destroy(this.st_date)
end on

event constructor;select	current	time	into	:g_s_time from pbcommon.comm000 
Using 	sqlca;

st_time.text	=	mid(g_s_time,1,5)
//timer(60)

end event

type st_time from statictext within uo_commonstatus
integer x = 4379
integer y = 8
integer width = 206
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

type st_winid from statictext within uo_commonstatus
integer width = 379
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
long bordercolor = 12632256
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_message from statictext within uo_commonstatus
integer x = 379
integer width = 3136
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_kornm from statictext within uo_commonstatus
integer x = 3520
integer width = 370
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_date from statictext within uo_commonstatus
integer x = 3899
integer width = 699
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

