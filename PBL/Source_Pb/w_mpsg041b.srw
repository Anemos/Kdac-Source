$PBExportHeader$w_mpsg041b.srw
$PBExportComments$사각형 터치스크린
forward
global type w_mpsg041b from window
end type
type pb_cancel from picturebutton within w_mpsg041b
end type
type pb_ok from picturebutton within w_mpsg041b
end type
type em_qty from editmask within w_mpsg041b
end type
type pb_exit from picturebutton within w_mpsg041b
end type
type pb_z from picturebutton within w_mpsg041b
end type
type pb_y from picturebutton within w_mpsg041b
end type
type pb_x from picturebutton within w_mpsg041b
end type
type pb_w from picturebutton within w_mpsg041b
end type
type pb_u from picturebutton within w_mpsg041b
end type
type pb_t from picturebutton within w_mpsg041b
end type
type pb_s from picturebutton within w_mpsg041b
end type
type pb_r from picturebutton within w_mpsg041b
end type
type pb_q from picturebutton within w_mpsg041b
end type
type pb_p from picturebutton within w_mpsg041b
end type
type pb_n from picturebutton within w_mpsg041b
end type
type pb_m from picturebutton within w_mpsg041b
end type
type pb_l from picturebutton within w_mpsg041b
end type
type pb_k from picturebutton within w_mpsg041b
end type
type pb_j from picturebutton within w_mpsg041b
end type
type pb_i from picturebutton within w_mpsg041b
end type
type pb_g from picturebutton within w_mpsg041b
end type
type pb_f from picturebutton within w_mpsg041b
end type
type pb_e from picturebutton within w_mpsg041b
end type
type pb_d from picturebutton within w_mpsg041b
end type
type pb_c from picturebutton within w_mpsg041b
end type
type pb_b from picturebutton within w_mpsg041b
end type
type pb_tab from picturebutton within w_mpsg041b
end type
type pb_10 from picturebutton within w_mpsg041b
end type
type pb_9 from picturebutton within w_mpsg041b
end type
type pb_8 from picturebutton within w_mpsg041b
end type
type pb_7 from picturebutton within w_mpsg041b
end type
type pb_back from picturebutton within w_mpsg041b
end type
type pb_5 from picturebutton within w_mpsg041b
end type
type pb_4 from picturebutton within w_mpsg041b
end type
type pb_3 from picturebutton within w_mpsg041b
end type
type pb_2 from picturebutton within w_mpsg041b
end type
type pb_v from picturebutton within w_mpsg041b
end type
type pb_o from picturebutton within w_mpsg041b
end type
type pb_h from picturebutton within w_mpsg041b
end type
type pb_a from picturebutton within w_mpsg041b
end type
type pb_6 from picturebutton within w_mpsg041b
end type
type pb_1 from picturebutton within w_mpsg041b
end type
type gb_4 from groupbox within w_mpsg041b
end type
type gb_5 from groupbox within w_mpsg041b
end type
type gb_3 from groupbox within w_mpsg041b
end type
type em_kb_no from editmask within w_mpsg041b
end type
type gb_1 from groupbox within w_mpsg041b
end type
type gb_7 from groupbox within w_mpsg041b
end type
end forward

global type w_mpsg041b from window
integer x = 46
integer y = 480
integer width = 2258
integer height = 2160
boolean titlebar = true
string title = "문자,수량 등록"
windowtype windowtype = response!
long backcolor = 32241141
pb_cancel pb_cancel
pb_ok pb_ok
em_qty em_qty
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
pb_tab pb_tab
pb_10 pb_10
pb_9 pb_9
pb_8 pb_8
pb_7 pb_7
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
gb_4 gb_4
gb_5 gb_5
gb_3 gb_3
em_kb_no em_kb_no
gb_1 gb_1
gb_7 gb_7
end type
global w_mpsg041b w_mpsg041b

type variables
integer ii_time_chk, ii_focus_chk
end variables

on w_mpsg041b.create
this.pb_cancel=create pb_cancel
this.pb_ok=create pb_ok
this.em_qty=create em_qty
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
this.pb_tab=create pb_tab
this.pb_10=create pb_10
this.pb_9=create pb_9
this.pb_8=create pb_8
this.pb_7=create pb_7
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
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_3=create gb_3
this.em_kb_no=create em_kb_no
this.gb_1=create gb_1
this.gb_7=create gb_7
this.Control[]={this.pb_cancel,&
this.pb_ok,&
this.em_qty,&
this.pb_exit,&
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
this.pb_tab,&
this.pb_10,&
this.pb_9,&
this.pb_8,&
this.pb_7,&
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
this.gb_4,&
this.gb_5,&
this.gb_3,&
this.em_kb_no,&
this.gb_1,&
this.gb_7}
end on

on w_mpsg041b.destroy
destroy(this.pb_cancel)
destroy(this.pb_ok)
destroy(this.em_qty)
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
destroy(this.pb_tab)
destroy(this.pb_10)
destroy(this.pb_9)
destroy(this.pb_8)
destroy(this.pb_7)
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
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.em_kb_no)
destroy(this.gb_1)
destroy(this.gb_7)
end on

event open;str_mpsg_parm l_parm

l_parm = message.PowerObjectParm
if l_parm.s_parm[1] = 'N' then	// 좌표지정여부
	f_centerwindow(this)
else
	This.x = l_parm.i_parm[1]
	This.y = l_parm.i_parm[2]
end if

if l_parm.s_parm[2] = 'Y' then	// 문자입력여부
	ii_focus_chk = 1
	em_qty.enabled = False
	em_kb_no.enabled = True
	em_kb_no.setfocus()
else
	ii_focus_chk = 3
	em_qty.enabled = True
	em_kb_no.enabled = False
	em_qty.setfocus()
end if

em_kb_no.text			= ""
em_qty.text	= ""


end event

type pb_cancel from picturebutton within w_mpsg041b
integer x = 1650
integer y = 1628
integer width = 494
integer height = 348
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

event clicked;close(w_mpsg041b)
end event

type pb_ok from picturebutton within w_mpsg041b
integer x = 1042
integer y = 1628
integer width = 494
integer height = 348
integer taborder = 50
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입력"
string picturename = "bmp\background.gif"
string disabledname = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;string rtn_parm

if ii_focus_chk = 1 then
	rtn_parm = em_kb_no.text
else
	rtn_parm = em_qty.text
end if

closewithreturn(w_mpsg041b,rtn_parm)
end event

type em_qty from editmask within w_mpsg041b
event ue_keyup pbm_keyup
integer x = 69
integer y = 1880
integer width = 434
integer height = 128
integer taborder = 40
integer textsize = -18
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 15780518
string text = "234"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

event losefocus;/*
STRING	ls_divide_lotno1, ls_divide_lotno2
INTEGER	li_divide_qty

li_divide_qty = dw_lotno_info.GetItemNumber(1, "as_rackqty") -	&
						INTEGER(TRIM(em_divide_qty.text))

ls_divide_lotno1		= dw_lotno_info.GetItemString(1, "as_lotno")
ls_divide_lotno2		= trim(em_divide_lotno.text)

/*######################################################################
#####		분할된 LOTNO의 수량													 #####
######################################################################*/

IF	LEN(THIS.TEXT) > 0						AND	&
	dw_lotno_info.rowcount() > 0			AND	&
	LEN(em_divide_lotno.text) > 0			AND	&
	li_divide_qty > 0							AND	&
	ls_divide_lotno1 > ls_divide_lotno2	THEN

	dw_lotno_info.SetItem(1, "as_divideqty", li_divide_qty)
ELSE
	// 오류
	pb_ok.enabled = FALSE

	Open(w_pisg101u)
END IF

ii_focus_chk = 3
*/
end event

type pb_exit from picturebutton within w_mpsg041b
integer x = 1582
integer y = 1300
integer width = 622
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string disabledname = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

type pb_z from picturebutton within w_mpsg041b
integer x = 1271
integer y = 1300
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "Z"
		
END CHOOSE

end event

type pb_y from picturebutton within w_mpsg041b
integer x = 960
integer y = 1300
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "Y"

END CHOOSE

end event

type pb_x from picturebutton within w_mpsg041b
integer x = 649
integer y = 1300
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "X"

END CHOOSE

end event

type pb_w from picturebutton within w_mpsg041b
integer x = 338
integer y = 1300
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "W"

END CHOOSE

end event

type pb_u from picturebutton within w_mpsg041b
integer x = 1893
integer y = 1052
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "U"

END CHOOSE

end event

type pb_t from picturebutton within w_mpsg041b
integer x = 1582
integer y = 1052
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "T"

END CHOOSE

end event

type pb_s from picturebutton within w_mpsg041b
integer x = 1271
integer y = 1052
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "S"

END CHOOSE

end event

type pb_r from picturebutton within w_mpsg041b
integer x = 960
integer y = 1052
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "R"

END CHOOSE

end event

type pb_q from picturebutton within w_mpsg041b
integer x = 649
integer y = 1052
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "Q"

END CHOOSE

end event

type pb_p from picturebutton within w_mpsg041b
integer x = 338
integer y = 1052
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "P"

END CHOOSE

end event

type pb_n from picturebutton within w_mpsg041b
integer x = 1893
integer y = 804
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "N"

END CHOOSE

end event

type pb_m from picturebutton within w_mpsg041b
integer x = 1582
integer y = 804
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "M"

END CHOOSE

end event

type pb_l from picturebutton within w_mpsg041b
integer x = 1271
integer y = 804
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "L"

END CHOOSE

end event

type pb_k from picturebutton within w_mpsg041b
integer x = 960
integer y = 804
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "K"

END CHOOSE

end event

type pb_j from picturebutton within w_mpsg041b
integer x = 649
integer y = 804
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "J"

END CHOOSE

end event

type pb_i from picturebutton within w_mpsg041b
integer x = 338
integer y = 804
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "I"

END CHOOSE

end event

type pb_g from picturebutton within w_mpsg041b
integer x = 1893
integer y = 556
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "G"

END CHOOSE

end event

type pb_f from picturebutton within w_mpsg041b
integer x = 1582
integer y = 556
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "F"

END CHOOSE

end event

type pb_e from picturebutton within w_mpsg041b
integer x = 1271
integer y = 556
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "E"

END CHOOSE

end event

type pb_d from picturebutton within w_mpsg041b
integer x = 960
integer y = 556
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "D"

END CHOOSE

end event

type pb_c from picturebutton within w_mpsg041b
integer x = 649
integer y = 556
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "C"

END CHOOSE

end event

type pb_b from picturebutton within w_mpsg041b
integer x = 338
integer y = 556
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "B"

END CHOOSE

end event

type pb_tab from picturebutton within w_mpsg041b
integer x = 1582
integer y = 284
integer width = 622
integer height = 248
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

event clicked;//INTEGER li_back_len_chk
//
//CHOOSE CASE ii_focus_chk
//	CASE 1
//		em_lotno_1.setfocus()
//	CASE 2
//		em_divideqty_1.setfocus()
//	CASE 3
//		em_lotno_2.setfocus()
//	CASE 4
//		em_divideqty_2.setfocus()
//	CASE 5
//		ii_focus_chk = 6
//		pb_ok.setfocus()
//	CASE 6
//		ii_focus_chk = 0
//		pb_cancel.setfocus()
//	CASE ELSE
//		em_kb_no.setfocus()
//END CHOOSE
//
end event

type pb_10 from picturebutton within w_mpsg041b
integer x = 1271
integer y = 284
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "0"
	CASE 3
		em_qty.text	= em_qty.text + "0"
END CHOOSE

end event

type pb_9 from picturebutton within w_mpsg041b
integer x = 960
integer y = 284
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "9"
	CASE 3
		em_qty.text	= em_qty.text + "9"
END CHOOSE

end event

type pb_8 from picturebutton within w_mpsg041b
integer x = 649
integer y = 284
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "8"
	CASE 3
		em_qty.text	= em_qty.text + "8"
END CHOOSE

end event

type pb_7 from picturebutton within w_mpsg041b
integer x = 338
integer y = 284
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "7"
	CASE 3
		em_qty.text	= em_qty.text + "7"
END CHOOSE

end event

type pb_back from picturebutton within w_mpsg041b
integer x = 1582
integer y = 36
integer width = 622
integer height = 248
integer textsize = -24
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "◀--"
string picturename = "bmp\background.gif"
vtextalign vtextalign = vcenter!
end type

event clicked;INTEGER li_back_len_chk
// BACK SPEACE

CHOOSE CASE ii_focus_chk
	CASE 1
		li_back_len_chk = len(em_kb_no.text)
		em_kb_no.text = MID(em_kb_no.text, 1, li_back_len_chk - 1)
		em_kb_no.setfocus()
	CASE 3
		li_back_len_chk = len(em_qty.text)
		em_qty.text = MID(em_qty.text, 1, li_back_len_chk - 1)
		em_qty.setfocus()
END CHOOSE

end event

type pb_5 from picturebutton within w_mpsg041b
integer x = 1271
integer y = 36
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "5"
	CASE 3
		em_qty.text	= em_qty.text + "5"
END CHOOSE

end event

type pb_4 from picturebutton within w_mpsg041b
integer x = 960
integer y = 36
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "4"
	CASE 3
		em_qty.text	= em_qty.text + "4"
END CHOOSE

end event

type pb_3 from picturebutton within w_mpsg041b
integer x = 649
integer y = 36
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "3"
	CASE 3
		em_qty.text	= em_qty.text + "3"
END CHOOSE

end event

type pb_2 from picturebutton within w_mpsg041b
integer x = 338
integer y = 36
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "2"
	CASE 3
		em_qty.text	= em_qty.text + "2"
END CHOOSE

end event

type pb_v from picturebutton within w_mpsg041b
integer x = 27
integer y = 1300
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "V"

END CHOOSE

end event

type pb_o from picturebutton within w_mpsg041b
integer x = 27
integer y = 1052
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "O"

END CHOOSE

end event

type pb_h from picturebutton within w_mpsg041b
integer x = 27
integer y = 804
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "H"

END CHOOSE

end event

type pb_a from picturebutton within w_mpsg041b
integer x = 27
integer y = 556
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "A"

END CHOOSE

end event

type pb_6 from picturebutton within w_mpsg041b
integer x = 27
integer y = 284
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "6"
	CASE 3
		em_qty.text	= em_qty.text + "6"
END CHOOSE

end event

type pb_1 from picturebutton within w_mpsg041b
integer x = 27
integer y = 36
integer width = 311
integer height = 248
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

event clicked;/*######################################################################
#####		입력항목 선택															 #####
######################################################################*/

CHOOSE CASE ii_focus_chk
	CASE 1
		em_kb_no.text			= em_kb_no.text + "1"
	CASE 3
		em_qty.text	= em_qty.text + "1"
END CHOOSE

end event

type gb_4 from groupbox within w_mpsg041b
integer x = 14
integer y = 16
integer width = 2208
integer height = 532
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_5 from groupbox within w_mpsg041b
integer x = 14
integer y = 536
integer width = 2208
integer height = 1028
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_3 from groupbox within w_mpsg041b
integer x = 1001
integer y = 1604
integer width = 1189
integer height = 404
integer taborder = 60
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 32241141
end type

type em_kb_no from editmask within w_mpsg041b
event ue_keyup pbm_keydown
integer x = 64
integer y = 1648
integer width = 869
integer height = 128
integer taborder = 10
integer textsize = -18
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
string text = "R34"
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "aaaaaaaaaaaaaa"
end type

event ue_keyup;///*######################################################################
//#####		간판번호입력 시														 #####
//######################################################################*/
//
//// ENTER KEY 입력시
//IF KEY	= KeyEnter! THEN
//	wf_divide_lotno_record()
//
//	IF dw_lotno_info.rowcount() < 1 THEN
//
//		// 해당간판 오류 표시
//		Open(w_pisg102u)
//
//		// 간판번호 클리어
//		THIS.TEXT = ''
//	ELSE
//		// LotNo 입력창에 Focus
//		em_divide_lotno.SetFocus()
//	END IF
//END IF
//
end event

event losefocus;ii_focus_chk = 1

end event

type gb_1 from groupbox within w_mpsg041b
integer x = 23
integer y = 1576
integer width = 946
integer height = 224
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 32241141
string text = "문자입력"
end type

type gb_7 from groupbox within w_mpsg041b
integer x = 27
integer y = 1808
integer width = 512
integer height = 224
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 32241141
string text = "수량입력"
end type

