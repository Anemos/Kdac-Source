$PBExportHeader$w_download.srw
$PBExportComments$자료내려받기 상태 표시
forward
global type w_download from window
end type
type st_2 from statictext within w_download
end type
type st_appname from statictext within w_download
end type
type st_66 from statictext within w_download
end type
type st_55 from statictext within w_download
end type
type st_44 from statictext within w_download
end type
type st_28 from statictext within w_download
end type
type st_27 from statictext within w_download
end type
type uo_total from u_progress_bar within w_download
end type
type st_11 from statictext within w_download
end type
type st_10 from statictext within w_download
end type
type st_9 from statictext within w_download
end type
type st_8 from statictext within w_download
end type
type st_16 from statictext within w_download
end type
type st_15 from statictext within w_download
end type
type st_13 from statictext within w_download
end type
type st_12 from statictext within w_download
end type
type st_7 from statictext within w_download
end type
type st_4 from statictext within w_download
end type
type st_14 from statictext within w_download
end type
type uo_progress from u_progress_bar within w_download
end type
type gb_22 from groupbox within w_download
end type
type gb_1 from groupbox within w_download
end type
type gb_2 from groupbox within w_download
end type
end forward

global type w_download from window
integer x = 965
integer y = 1112
integer width = 2619
integer height = 940
windowtype windowtype = popup!
long backcolor = 79741120
st_2 st_2
st_appname st_appname
st_66 st_66
st_55 st_55
st_44 st_44
st_28 st_28
st_27 st_27
uo_total uo_total
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_16 st_16
st_15 st_15
st_13 st_13
st_12 st_12
st_7 st_7
st_4 st_4
st_14 st_14
uo_progress uo_progress
gb_22 gb_22
gb_1 gb_1
gb_2 gb_2
end type
global w_download w_download

on w_download.create
this.st_2=create st_2
this.st_appname=create st_appname
this.st_66=create st_66
this.st_55=create st_55
this.st_44=create st_44
this.st_28=create st_28
this.st_27=create st_27
this.uo_total=create uo_total
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_16=create st_16
this.st_15=create st_15
this.st_13=create st_13
this.st_12=create st_12
this.st_7=create st_7
this.st_4=create st_4
this.st_14=create st_14
this.uo_progress=create uo_progress
this.gb_22=create gb_22
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_2,&
this.st_appname,&
this.st_66,&
this.st_55,&
this.st_44,&
this.st_28,&
this.st_27,&
this.uo_total,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_16,&
this.st_15,&
this.st_13,&
this.st_12,&
this.st_7,&
this.st_4,&
this.st_14,&
this.uo_progress,&
this.gb_22,&
this.gb_1,&
this.gb_2}
end on

on w_download.destroy
destroy(this.st_2)
destroy(this.st_appname)
destroy(this.st_66)
destroy(this.st_55)
destroy(this.st_44)
destroy(this.st_28)
destroy(this.st_27)
destroy(this.uo_total)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_7)
destroy(this.st_4)
destroy(this.st_14)
destroy(this.uo_progress)
destroy(this.gb_22)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;f_centerWindow ( This )

st_appname.Text	= gs_appname

end event

type st_2 from statictext within w_download
integer x = 64
integer y = 228
integer width = 805
integer height = 120
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
string text = "DownLoad"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_appname from statictext within w_download
integer x = 64
integer y = 108
integer width = 805
integer height = 120
integer textsize = -18
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "KDAC"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_66 from statictext within w_download
integer x = 1353
integer y = 800
integer width = 398
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Remain Time:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_55 from statictext within w_download
integer x = 1353
integer y = 688
integer width = 398
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "File Number:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_44 from statictext within w_download
integer x = 1417
integer y = 572
integer width = 334
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "File Size:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_28 from statictext within w_download
integer x = 919
integer y = 84
integer width = 398
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Current File"
boolean focusrectangle = false
end type

type st_27 from statictext within w_download
integer x = 910
integer y = 252
integer width = 293
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "All File"
boolean focusrectangle = false
end type

type uo_total from u_progress_bar within w_download
integer x = 914
integer y = 316
integer width = 1591
integer height = 76
integer taborder = 10
borderstyle borderstyle = stylelowered!
end type

on uo_total.destroy
call u_progress_bar::destroy
end on

type st_11 from statictext within w_download
integer x = 1778
integer y = 800
integer width = 745
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_10 from statictext within w_download
integer x = 1778
integer y = 2088
integer width = 425
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_9 from statictext within w_download
integer x = 1778
integer y = 688
integer width = 745
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_8 from statictext within w_download
integer x = 1778
integer y = 572
integer width = 745
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_16 from statictext within w_download
integer x = 489
integer y = 800
integer width = 763
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_15 from statictext within w_download
integer x = 489
integer y = 688
integer width = 763
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_13 from statictext within w_download
integer x = 1312
integer y = 84
integer width = 1157
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type st_12 from statictext within w_download
integer x = 59
integer y = 688
integer width = 398
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "File Number:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_7 from statictext within w_download
integer x = 59
integer y = 800
integer width = 398
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "Remain Time:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_download
integer x = 123
integer y = 572
integer width = 334
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
string text = "File Size:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_14 from statictext within w_download
integer x = 489
integer y = 572
integer width = 763
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type uo_progress from u_progress_bar within w_download
integer x = 914
integer y = 152
integer width = 1591
integer height = 76
integer taborder = 40
borderstyle borderstyle = stylelowered!
end type

on uo_progress.destroy
call u_progress_bar::destroy
end on

type gb_22 from groupbox within w_download
integer x = 1326
integer y = 472
integer width = 1243
integer height = 436
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "All"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_download
integer x = 41
integer y = 472
integer width = 1243
integer height = 436
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Current"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_download
integer x = 41
integer y = 8
integer width = 2523
integer height = 432
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 67108864
borderstyle borderstyle = stylelowered!
end type

