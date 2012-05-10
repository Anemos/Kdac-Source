$PBExportHeader$w_mpsg040b.srw
$PBExportComments$현장관리_터치스크린 입력
forward
global type w_mpsg040b from window
end type
type pb_exit from picturebutton within w_mpsg040b
end type
type pb_z from picturebutton within w_mpsg040b
end type
type pb_y from picturebutton within w_mpsg040b
end type
type pb_x from picturebutton within w_mpsg040b
end type
type pb_w from picturebutton within w_mpsg040b
end type
type pb_u from picturebutton within w_mpsg040b
end type
type pb_t from picturebutton within w_mpsg040b
end type
type pb_s from picturebutton within w_mpsg040b
end type
type pb_r from picturebutton within w_mpsg040b
end type
type pb_q from picturebutton within w_mpsg040b
end type
type pb_p from picturebutton within w_mpsg040b
end type
type pb_n from picturebutton within w_mpsg040b
end type
type pb_m from picturebutton within w_mpsg040b
end type
type pb_l from picturebutton within w_mpsg040b
end type
type pb_k from picturebutton within w_mpsg040b
end type
type pb_j from picturebutton within w_mpsg040b
end type
type pb_i from picturebutton within w_mpsg040b
end type
type pb_g from picturebutton within w_mpsg040b
end type
type pb_f from picturebutton within w_mpsg040b
end type
type pb_e from picturebutton within w_mpsg040b
end type
type pb_d from picturebutton within w_mpsg040b
end type
type pb_c from picturebutton within w_mpsg040b
end type
type pb_b from picturebutton within w_mpsg040b
end type
type pb_enter from picturebutton within w_mpsg040b
end type
type pb_10 from picturebutton within w_mpsg040b
end type
type pb_9 from picturebutton within w_mpsg040b
end type
type pb_8 from picturebutton within w_mpsg040b
end type
type pb_back from picturebutton within w_mpsg040b
end type
type pb_5 from picturebutton within w_mpsg040b
end type
type pb_4 from picturebutton within w_mpsg040b
end type
type pb_3 from picturebutton within w_mpsg040b
end type
type pb_2 from picturebutton within w_mpsg040b
end type
type pb_v from picturebutton within w_mpsg040b
end type
type pb_o from picturebutton within w_mpsg040b
end type
type pb_h from picturebutton within w_mpsg040b
end type
type pb_a from picturebutton within w_mpsg040b
end type
type pb_6 from picturebutton within w_mpsg040b
end type
type pb_1 from picturebutton within w_mpsg040b
end type
type gb_2 from groupbox within w_mpsg040b
end type
type pb_7 from picturebutton within w_mpsg040b
end type
type gb_1 from groupbox within w_mpsg040b
end type
end forward

global type w_mpsg040b from window
integer x = 315
integer y = 600
integer width = 3323
integer height = 1288
windowtype windowtype = response!
long backcolor = 32241141
pb_exit pb_exit
pb_z pb_z
pb_y pb_y
pb_x pb_x
pb_w pb_w
pb_u pb_u
pb_t pb_t
pb_s pb_s
pb_r pb_r
pb_q pb_q
pb_p pb_p
pb_n pb_n
pb_m pb_m
pb_l pb_l
pb_k pb_k
pb_j pb_j
pb_i pb_i
pb_g pb_g
pb_f pb_f
pb_e pb_e
pb_d pb_d
pb_c pb_c
pb_b pb_b
pb_enter pb_enter
pb_10 pb_10
pb_9 pb_9
pb_8 pb_8
pb_back pb_back
pb_5 pb_5
pb_4 pb_4
pb_3 pb_3
pb_2 pb_2
pb_v pb_v
pb_o pb_o
pb_h pb_h
pb_a pb_a
pb_6 pb_6
pb_1 pb_1
gb_2 gb_2
pb_7 pb_7
gb_1 gb_1
end type
global w_mpsg040b w_mpsg040b

type variables
integer ii_time_chk
end variables

on w_mpsg040b.create
this.pb_exit=create pb_exit
this.pb_z=create pb_z
this.pb_y=create pb_y
this.pb_x=create pb_x
this.pb_w=create pb_w
this.pb_u=create pb_u
this.pb_t=create pb_t
this.pb_s=create pb_s
this.pb_r=create pb_r
this.pb_q=create pb_q
this.pb_p=create pb_p
this.pb_n=create pb_n
this.pb_m=create pb_m
this.pb_l=create pb_l
this.pb_k=create pb_k
this.pb_j=create pb_j
this.pb_i=create pb_i
this.pb_g=create pb_g
this.pb_f=create pb_f
this.pb_e=create pb_e
this.pb_d=create pb_d
this.pb_c=create pb_c
this.pb_b=create pb_b
this.pb_enter=create pb_enter
this.pb_10=create pb_10
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_back=create pb_back
this.pb_5=create pb_5
this.pb_4=create pb_4
this.pb_3=create pb_3
this.pb_2=create pb_2
this.pb_v=create pb_v
this.pb_o=create pb_o
this.pb_h=create pb_h
this.pb_a=create pb_a
this.pb_6=create pb_6
this.pb_1=create pb_1
this.gb_2=create gb_2
this.pb_7=create pb_7
this.gb_1=create gb_1
this.Control[]={this.pb_exit,&
this.pb_z,&
this.pb_y,&
this.pb_x,&
this.pb_w,&
this.pb_u,&
this.pb_t,&
this.pb_s,&
this.pb_r,&
this.pb_q,&
this.pb_p,&
this.pb_n,&
this.pb_m,&
this.pb_l,&
this.pb_k,&
this.pb_j,&
this.pb_i,&
this.pb_g,&
this.pb_f,&
this.pb_e,&
this.pb_d,&
this.pb_c,&
this.pb_b,&
this.pb_enter,&
this.pb_10,&
this.pb_9,&
this.pb_8,&
this.pb_back,&
this.pb_5,&
this.pb_4,&
this.pb_3,&
this.pb_2,&
this.pb_v,&
this.pb_o,&
this.pb_h,&
this.pb_a,&
this.pb_6,&
this.pb_1,&
this.gb_2,&
this.pb_7,&
this.gb_1}
end on

on w_mpsg040b.destroy
destroy(this.pb_exit)
destroy(this.pb_z)
destroy(this.pb_y)
destroy(this.pb_x)
destroy(this.pb_w)
destroy(this.pb_u)
destroy(this.pb_t)
destroy(this.pb_s)
destroy(this.pb_r)
destroy(this.pb_q)
destroy(this.pb_p)
destroy(this.pb_n)
destroy(this.pb_m)
destroy(this.pb_l)
destroy(this.pb_k)
destroy(this.pb_j)
destroy(this.pb_i)
destroy(this.pb_g)
destroy(this.pb_f)
destroy(this.pb_e)
destroy(this.pb_d)
destroy(this.pb_c)
destroy(this.pb_b)
destroy(this.pb_enter)
destroy(this.pb_10)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_back)
destroy(this.pb_5)
destroy(this.pb_4)
destroy(this.pb_3)
destroy(this.pb_2)
destroy(this.pb_v)
destroy(this.pb_o)
destroy(this.pb_h)
destroy(this.pb_a)
destroy(this.pb_6)
destroy(this.pb_1)
destroy(this.gb_2)
destroy(this.pb_7)
destroy(this.gb_1)
end on

event open;f_centerwindow(this)

this.y = this.y + 100

// 입력간판 초기화
w_mpsg030i.em_kb_no.text = ''
end event

type pb_exit from picturebutton within w_mpsg040b
integer x = 2610
integer y = 824
integer width = 640
integer height = 160
integer taborder = 390
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 클리어
w_mpsg030i.em_kb_no.text = ''

// KEY 종료
Close(w_mpsg040b)

end event

type pb_z from picturebutton within w_mpsg040b
integer x = 2930
integer y = 984
integer width = 320
integer height = 248
integer taborder = 360
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Z"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'Z'
end event

type pb_y from picturebutton within w_mpsg040b
integer x = 2610
integer y = 984
integer width = 320
integer height = 248
integer taborder = 350
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Y"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'Y'
end event

type pb_x from picturebutton within w_mpsg040b
integer x = 2290
integer y = 984
integer width = 320
integer height = 248
integer taborder = 340
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "X"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'X'
end event

type pb_w from picturebutton within w_mpsg040b
integer x = 1970
integer y = 984
integer width = 320
integer height = 248
integer taborder = 330
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "W"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'W'
end event

type pb_u from picturebutton within w_mpsg040b
integer x = 1330
integer y = 984
integer width = 320
integer height = 248
integer taborder = 310
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "U"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'U'
end event

type pb_t from picturebutton within w_mpsg040b
integer x = 1010
integer y = 984
integer width = 320
integer height = 248
integer taborder = 300
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "T"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'T'
end event

type pb_s from picturebutton within w_mpsg040b
integer x = 690
integer y = 984
integer width = 320
integer height = 248
integer taborder = 290
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "S"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'S'
end event

type pb_r from picturebutton within w_mpsg040b
integer x = 370
integer y = 984
integer width = 320
integer height = 248
integer taborder = 280
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "R"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'R'
end event

type pb_q from picturebutton within w_mpsg040b
integer x = 50
integer y = 984
integer width = 320
integer height = 248
integer taborder = 270
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Q"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'Q'
end event

type pb_p from picturebutton within w_mpsg040b
integer x = 2290
integer y = 736
integer width = 320
integer height = 248
integer taborder = 260
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "P"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'P'
end event

type pb_n from picturebutton within w_mpsg040b
integer x = 1650
integer y = 736
integer width = 320
integer height = 248
integer taborder = 240
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "N"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'N'
end event

type pb_m from picturebutton within w_mpsg040b
integer x = 1330
integer y = 736
integer width = 320
integer height = 248
integer taborder = 230
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "M"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'M'
end event

type pb_l from picturebutton within w_mpsg040b
integer x = 1010
integer y = 736
integer width = 320
integer height = 248
integer taborder = 220
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "L"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'L'
end event

type pb_k from picturebutton within w_mpsg040b
integer x = 690
integer y = 736
integer width = 320
integer height = 248
integer taborder = 210
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "K"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'K'
end event

type pb_j from picturebutton within w_mpsg040b
integer x = 370
integer y = 736
integer width = 320
integer height = 248
integer taborder = 200
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "J"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'J'
end event

type pb_i from picturebutton within w_mpsg040b
integer x = 50
integer y = 736
integer width = 320
integer height = 248
integer taborder = 190
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "I"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'I'
end event

type pb_g from picturebutton within w_mpsg040b
integer x = 1970
integer y = 488
integer width = 320
integer height = 248
integer taborder = 170
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "G"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'G'
end event

type pb_f from picturebutton within w_mpsg040b
integer x = 1650
integer y = 488
integer width = 320
integer height = 248
integer taborder = 160
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "F"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'F'
end event

type pb_e from picturebutton within w_mpsg040b
integer x = 1330
integer y = 488
integer width = 320
integer height = 248
integer taborder = 150
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "E"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'E'
end event

type pb_d from picturebutton within w_mpsg040b
integer x = 1010
integer y = 488
integer width = 320
integer height = 248
integer taborder = 140
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "D"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'D'
end event

type pb_c from picturebutton within w_mpsg040b
integer x = 690
integer y = 488
integer width = 320
integer height = 248
integer taborder = 130
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "C"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'C'
end event

type pb_b from picturebutton within w_mpsg040b
integer x = 370
integer y = 488
integer width = 320
integer height = 248
integer taborder = 120
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "B"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'B'
end event

type pb_enter from picturebutton within w_mpsg040b
integer x = 2610
integer y = 656
integer width = 640
integer height = 160
integer taborder = 380
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Enter"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;/*######################################################################
#####		간판번호입력 시														 #####
######################################################################*/

IF w_mpsg030i.wf_transaction_select() THEN
	// 해당간판 등록
	Open(w_mpsg050u)
ELSE
	// 해당간판 오류 표시
	Open(w_mpsg060b)
END IF

// KEY 입력창 종료
Close(w_mpsg040b)

end event

type pb_10 from picturebutton within w_mpsg040b
integer x = 2930
integer y = 100
integer width = 320
integer height = 248
integer taborder = 100
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "0"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '0'
end event

type pb_9 from picturebutton within w_mpsg040b
integer x = 2610
integer y = 100
integer width = 320
integer height = 248
integer taborder = 90
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "9"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '9'
end event

type pb_8 from picturebutton within w_mpsg040b
integer x = 2290
integer y = 100
integer width = 320
integer height = 248
integer taborder = 80
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "8"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '8'
end event

type pb_back from picturebutton within w_mpsg040b
integer x = 2610
integer y = 488
integer width = 640
integer height = 160
integer taborder = 370
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "<---"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// BACK SPEACE
w_mpsg030i.em_kb_no.text	=	&
	MID(w_mpsg030i.em_kb_no.text, 1, len(w_mpsg030i.em_kb_no.text) - 1)
end event

type pb_5 from picturebutton within w_mpsg040b
integer x = 1330
integer y = 100
integer width = 320
integer height = 248
integer taborder = 50
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "5"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '5'
end event

type pb_4 from picturebutton within w_mpsg040b
integer x = 1010
integer y = 100
integer width = 320
integer height = 248
integer taborder = 40
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "4"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '4'
end event

type pb_3 from picturebutton within w_mpsg040b
integer x = 690
integer y = 100
integer width = 320
integer height = 248
integer taborder = 30
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "3"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '3'
end event

type pb_2 from picturebutton within w_mpsg040b
integer x = 370
integer y = 100
integer width = 320
integer height = 248
integer taborder = 20
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "2"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '2'
end event

type pb_v from picturebutton within w_mpsg040b
integer x = 1650
integer y = 984
integer width = 320
integer height = 248
integer taborder = 320
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "V"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'V'
end event

type pb_o from picturebutton within w_mpsg040b
integer x = 1970
integer y = 736
integer width = 320
integer height = 248
integer taborder = 250
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "O"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'O'
end event

type pb_h from picturebutton within w_mpsg040b
integer x = 2290
integer y = 488
integer width = 320
integer height = 248
integer taborder = 180
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "H"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'H'
end event

type pb_a from picturebutton within w_mpsg040b
integer x = 50
integer y = 488
integer width = 320
integer height = 248
integer taborder = 110
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "A"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + 'A'
end event

type pb_6 from picturebutton within w_mpsg040b
integer x = 1650
integer y = 100
integer width = 320
integer height = 248
integer taborder = 60
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "6"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '6'
end event

type pb_1 from picturebutton within w_mpsg040b
integer x = 50
integer y = 100
integer width = 320
integer height = 248
integer taborder = 10
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "1"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '1'
end event

type gb_2 from groupbox within w_mpsg040b
integer x = 23
integer y = 396
integer width = 3259
integer height = 864
integer taborder = 10
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 32241141
string text = "영문"
end type

type pb_7 from picturebutton within w_mpsg040b
integer x = 1970
integer y = 100
integer width = 320
integer height = 244
integer taborder = 70
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "7"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;// 간판번호 입력
w_mpsg030i.em_kb_no.text = w_mpsg030i.em_kb_no.text + '7'
end event

type gb_1 from groupbox within w_mpsg040b
integer x = 23
integer width = 3259
integer height = 372
integer taborder = 390
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 128
long backcolor = 32241141
string text = "번호"
end type

