$PBExportHeader$w_bom112u_detail.srw
$PBExportComments$호환품번의 상위품번 상세정보윈도우
forward
global type w_bom112u_detail from window
end type
type pb_down_ofitn from picturebutton within w_bom112u_detail
end type
type pb_down_opitn from picturebutton within w_bom112u_detail
end type
type st_5 from statictext within w_bom112u_detail
end type
type sle_ofitn_cnt from singlelineedit within w_bom112u_detail
end type
type st_4 from statictext within w_bom112u_detail
end type
type sle_opitn_cnt from singlelineedit within w_bom112u_detail
end type
type st_3 from statictext within w_bom112u_detail
end type
type st_2 from statictext within w_bom112u_detail
end type
type st_1 from statictext within w_bom112u_detail
end type
type cb_3 from commandbutton within w_bom112u_detail
end type
type dw_1 from datawindow within w_bom112u_detail
end type
type dw_2 from datawindow within w_bom112u_detail
end type
end forward

global type w_bom112u_detail from window
integer x = 498
integer y = 800
integer width = 2793
integer height = 1372
boolean titlebar = true
string title = "상위품번 상세정보윈도우"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
pb_down_ofitn pb_down_ofitn
pb_down_opitn pb_down_opitn
st_5 st_5
sle_ofitn_cnt sle_ofitn_cnt
st_4 st_4
sle_opitn_cnt sle_opitn_cnt
st_3 st_3
st_2 st_2
st_1 st_1
cb_3 cb_3
dw_1 dw_1
dw_2 dw_2
end type
global w_bom112u_detail w_bom112u_detail

on w_bom112u_detail.create
this.pb_down_ofitn=create pb_down_ofitn
this.pb_down_opitn=create pb_down_opitn
this.st_5=create st_5
this.sle_ofitn_cnt=create sle_ofitn_cnt
this.st_4=create st_4
this.sle_opitn_cnt=create sle_opitn_cnt
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_3=create cb_3
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.pb_down_ofitn,&
this.pb_down_opitn,&
this.st_5,&
this.sle_ofitn_cnt,&
this.st_4,&
this.sle_opitn_cnt,&
this.st_3,&
this.st_2,&
this.st_1,&
this.cb_3,&
this.dw_1,&
this.dw_2}
end on

on w_bom112u_detail.destroy
destroy(this.pb_down_ofitn)
destroy(this.pb_down_opitn)
destroy(this.st_5)
destroy(this.sle_ofitn_cnt)
destroy(this.st_4)
destroy(this.sle_opitn_cnt)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;setpointer(hourglass!)

string 	ls_parm,ls_div,ls_plant,ls_opitn,ls_ofitn,ls_applydate
long 		ln_slen
integer 	ln_width, ln_height
str_option_data lstr_option

ln_width		=	3657 - this.width
ln_height 		= 	2100 - this.height
this.x 			= 	ln_width/2
this.y 			= 	ln_height/2

lstr_option = Message.PowerObjectParm
ls_plant 		= lstr_option.str_plant
ls_div 			= lstr_option.str_dvsn
ls_opitn			= lstr_option.str_opitn
ls_ofitn			= lstr_option.str_ofitn
ls_applydate   = lstr_option.str_applydate

dw_1.reset()
dw_2.reset()
sle_opitn_cnt.text = string(dw_1.retrieve(ls_plant,ls_div,ls_opitn,ls_applydate))
sle_ofitn_cnt.text = string(dw_2.retrieve(ls_plant,ls_div,ls_ofitn,ls_applydate))

end event

type pb_down_ofitn from picturebutton within w_bom112u_detail
integer x = 2263
integer y = 28
integer width = 192
integer height = 100
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_Save_to_Excel_number(dw_2)
end event

type pb_down_opitn from picturebutton within w_bom112u_detail
integer x = 887
integer y = 28
integer width = 192
integer height = 100
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_Save_to_Excel_number(dw_1)
end event

type st_5 from statictext within w_bom112u_detail
integer x = 23
integer y = 1196
integer width = 2574
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
string text = "호환주품번과 호환부품번의 상위품번는 동일해야 호환으로 등록할수 있습니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_ofitn_cnt from singlelineedit within w_bom112u_detail
integer x = 1705
integer y = 1064
integer width = 306
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_bom112u_detail
integer x = 1390
integer y = 1076
integer width = 315
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회수 : "
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type sle_opitn_cnt from singlelineedit within w_bom112u_detail
integer x = 343
integer y = 1064
integer width = 306
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_bom112u_detail
integer x = 27
integer y = 1076
integer width = 315
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회수 : "
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_2 from statictext within w_bom112u_detail
integer x = 1394
integer y = 28
integer width = 818
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "호환 부품번 : 상위품번 내역"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_1 from statictext within w_bom112u_detail
integer x = 32
integer y = 28
integer width = 818
integer height = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
long textcolor = 33554432
long backcolor = 12632256
string text = "호환 주품번 : 상위품번 내역"
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_bom112u_detail
integer x = 2523
integer y = 1068
integer width = 219
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
end type

event clicked;closewithreturn(parent,' ')
end event

type dw_1 from datawindow within w_bom112u_detail
integer x = 27
integer y = 132
integer width = 1353
integer height = 920
integer taborder = 10
string title = "none"
string dataobject = "d_bom001_112u_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_2 from datawindow within w_bom112u_detail
integer x = 1394
integer y = 132
integer width = 1353
integer height = 920
integer taborder = 20
string title = "none"
string dataobject = "d_bom001_112u_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

