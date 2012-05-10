$PBExportHeader$w_mpsg001b.srw
$PBExportComments$현장관리_DB CONNECTING ERROR
forward
global type w_mpsg001b from window
end type
type st_2 from statictext within w_mpsg001b
end type
type st_1 from statictext within w_mpsg001b
end type
type pb_exit from picturebutton within w_mpsg001b
end type
type mle_3 from multilineedit within w_mpsg001b
end type
type gb_2 from groupbox within w_mpsg001b
end type
end forward

global type w_mpsg001b from window
string tag = "연결실패"
integer x = 1298
integer y = 760
integer width = 2583
integer height = 1008
boolean titlebar = true
string title = "DB 연결 오류"
windowtype windowtype = response!
long backcolor = 80269524
st_2 st_2
st_1 st_1
pb_exit pb_exit
mle_3 mle_3
gb_2 gb_2
end type
global w_mpsg001b w_mpsg001b

type variables
INTEGER	ii_time_count
end variables

on w_mpsg001b.create
this.st_2=create st_2
this.st_1=create st_1
this.pb_exit=create pb_exit
this.mle_3=create mle_3
this.gb_2=create gb_2
this.Control[]={this.st_2,&
this.st_1,&
this.pb_exit,&
this.mle_3,&
this.gb_2}
end on

on w_mpsg001b.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_exit)
destroy(this.mle_3)
destroy(this.gb_2)
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
	st_1.text = ''
	st_2.text = ''
else
	st_1.text = '연결실패'
	st_2.text = '정보파일을 확인 하십시요.'
end if

pb_exit.SetFocus()

end event

type st_2 from statictext within w_mpsg001b
integer x = 123
integer y = 320
integer width = 2309
integer height = 196
integer textsize = -28
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "정보파일을 확인 하십시요."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_mpsg001b
integer x = 709
integer y = 92
integer width = 1138
integer height = 168
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "연결실패"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_exit from picturebutton within w_mpsg001b
integer x = 1010
integer y = 608
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
#####		w_pisg001b 윈도우 종료												 #####
######################################################################*/

Close(w_mpsg001b)
end event
type mle_3 from multilineedit within w_mpsg001b
integer x = 55
integer y = 52
integer width = 2446
integer height = 480
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 65535
long backcolor = 0
alignment alignment = center!
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_mpsg001b
integer x = 55
integer y = 572
integer width = 2446
integer height = 300
integer taborder = 10
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 80269524
end type

