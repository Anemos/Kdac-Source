$PBExportHeader$w_pisg051u.srw
$PBExportComments$현장관리_생산실적등록 실패
forward
global type w_pisg051u from window
end type
type st_3 from statictext within w_pisg051u
end type
type st_2 from statictext within w_pisg051u
end type
type pb_exit from picturebutton within w_pisg051u
end type
type gb_2 from groupbox within w_pisg051u
end type
type st_1 from statictext within w_pisg051u
end type
end forward

global type w_pisg051u from window
integer x = 1298
integer y = 760
integer width = 2757
integer height = 1148
boolean titlebar = true
string title = "실적등록 실패"
windowtype windowtype = response!
long backcolor = 80269524
st_3 st_3
st_2 st_2
pb_exit pb_exit
gb_2 gb_2
st_1 st_1
end type
global w_pisg051u w_pisg051u

type variables
INTEGER	ii_time_count
end variables

on w_pisg051u.create
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

on w_pisg051u.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.pb_exit)
destroy(this.gb_2)
destroy(this.st_1)
end on

event timer;/*######################################################################
#####		시간을 체크하여	COLOR 변경										 #####
######################################################################*/

ii_time_count = ii_time_count + 1

if MOD(ii_time_count, 2) = 1 then
	st_2.text	= ''
	st_3.text	= ''
else
	st_2.text	= '실적등록 실패'
	st_3.text	= '실적등록에 실패 하였습니다.'
end if

pb_exit.SetFocus()

end event

event open;f_centerwindow(this)

timer(0.5)

pb_exit.SetFocus()

end event

type st_3 from statictext within w_pisg051u
integer x = 119
integer y = 412
integer width = 2496
integer height = 200
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "실적등록에 실패 하였습니다."
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisg051u
integer x = 215
integer y = 116
integer width = 2309
integer height = 200
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "실적등록 실패"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_exit from picturebutton within w_pisg051u
integer x = 1102
integer y = 748
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
vtextalign vtextalign = vcenter!
end type

event clicked;/*######################################################################
#####		w_pisg051u 윈도우 종료												 #####
######################################################################*/

// 실적등록화면 최상위로
w_pisg030i.BringToTop = TRUE

// 간판번호 입력창의 초기화및 FOCUS
w_pisg030i.em_kb_no.text = ''
w_pisg030i.em_kb_no.SetFocus()

Close(w_pisg051u)

end event

type gb_2 from groupbox within w_pisg051u
integer x = 55
integer y = 704
integer width = 2629
integer height = 316
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

type st_1 from statictext within w_pisg051u
integer x = 55
integer y = 44
integer width = 2629
integer height = 620
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

