$PBExportHeader$w_pisg011b.srw
$PBExportComments$현장관리_단말기정보오류
forward
global type w_pisg011b from window
end type
type st_3 from statictext within w_pisg011b
end type
type st_2 from statictext within w_pisg011b
end type
type pb_exit from picturebutton within w_pisg011b
end type
type gb_2 from groupbox within w_pisg011b
end type
type st_1 from statictext within w_pisg011b
end type
end forward

global type w_pisg011b from window
integer x = 302
integer y = 760
integer width = 2638
integer height = 1180
boolean titlebar = true
string title = "단말기 정보 오류"
windowtype windowtype = response!
long backcolor = 79219928
st_3 st_3
st_2 st_2
pb_exit pb_exit
gb_2 gb_2
st_1 st_1
end type
global w_pisg011b w_pisg011b

type variables
INTEGER	ii_time_count
end variables

on w_pisg011b.create
this.st_3=create st_3
this.st_2=create st_2
this.pb_exit=create pb_exit
this.gb_2=create gb_2
this.st_1=create st_1
this.Control[]={this.st_3,&
this.st_2,&
this.pb_exit,&
this.gb_2,&
this.st_1}
end on

on w_pisg011b.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.pb_exit)
destroy(this.gb_2)
destroy(this.st_1)
end on

event open;f_centerwindow(this)

timer(0.5)

pb_exit.SetFocus()
end event

event timer;/*######################################################################
#####		시간을 체크하여	COLOR 변경										 #####
######################################################################*/

ii_time_count = ii_time_count + 1

if MOD(ii_time_count, 2) = 1 then
	st_2.text = ''
	st_3.text = ''
else
	st_2.text = '단말기 정보 오류'
	st_3.text = '단말기명을 확인 하십시요.'
end if

pb_exit.SetFocus()

end event

type st_3 from statictext within w_pisg011b
integer x = 155
integer y = 384
integer width = 2309
integer height = 184
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "단말기명을 확인 하십시요."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisg011b
integer x = 581
integer y = 148
integer width = 1486
integer height = 184
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "단말기 정보 오류"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_exit from picturebutton within w_pisg011b
integer x = 1042
integer y = 772
integer width = 535
integer height = 224
integer taborder = 20
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
boolean default = true
vtextalign vtextalign = vcenter!
end type

event clicked;/*######################################################################
#####		w_pisg011b 윈도우 종료												 #####
######################################################################*/

Close(w_pisg011b)


end event

type gb_2 from groupbox within w_pisg011b
integer x = 69
integer y = 708
integer width = 2482
integer height = 352
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 79219928
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_pisg011b
integer x = 69
integer y = 44
integer width = 2482
integer height = 600
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 0
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

