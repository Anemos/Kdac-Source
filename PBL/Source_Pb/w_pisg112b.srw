$PBExportHeader$w_pisg112b.srw
$PBExportComments$수신지 컴퓨터 오류
forward
global type w_pisg112b from window
end type
type st_2 from statictext within w_pisg112b
end type
type st_1 from statictext within w_pisg112b
end type
type pb_exit from picturebutton within w_pisg112b
end type
type mle_3 from multilineedit within w_pisg112b
end type
type gb_2 from groupbox within w_pisg112b
end type
end forward

global type w_pisg112b from window
integer x = 1298
integer y = 760
integer width = 2779
integer height = 1008
boolean titlebar = true
string title = "전송 오류"
windowtype windowtype = response!
long backcolor = 80269524
st_2 st_2
st_1 st_1
pb_exit pb_exit
mle_3 mle_3
gb_2 gb_2
end type
global w_pisg112b w_pisg112b

type variables
INTEGER	ii_time_count
end variables

on w_pisg112b.create
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

on w_pisg112b.destroy
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
	st_1.text		= ''
	st_2.text		= ''
else
	st_1.text		= '전송오류'
	st_2.text		= '메세지 전송을 실패하였습니다.'
end if

pb_exit.SetFocus()

end event

type st_2 from statictext within w_pisg112b
integer x = 133
integer y = 320
integer width = 2491
integer height = 196
integer textsize = -28
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "메세지 전송을 실패하였습니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisg112b
integer x = 809
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
string text = "전송오류"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_exit from picturebutton within w_pisg112b
integer x = 1111
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
#####		w_pisg112b 윈도우 종료												 #####
######################################################################*/

Close(w_pisg112b)
end event

type mle_3 from multilineedit within w_pisg112b
integer x = 55
integer y = 52
integer width = 2647
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

type gb_2 from groupbox within w_pisg112b
integer x = 55
integer y = 572
integer width = 2647
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
borderstyle borderstyle = stylelowered!
end type

