$PBExportHeader$w_bpm403u_detail.srw
$PBExportComments$호환품번의 상위품번 상세정보윈도우
forward
global type w_bpm403u_detail from window
end type
type cb_3 from commandbutton within w_bpm403u_detail
end type
type sle_1 from singlelineedit within w_bpm403u_detail
end type
type cb_1 from commandbutton within w_bpm403u_detail
end type
type dw_1 from datawindow within w_bpm403u_detail
end type
type dw_2 from datawindow within w_bpm403u_detail
end type
end forward

global type w_bpm403u_detail from window
integer x = 498
integer y = 800
integer width = 3035
integer height = 1276
boolean titlebar = true
string title = "상위품번 상세정보윈도우"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
cb_3 cb_3
sle_1 sle_1
cb_1 cb_1
dw_1 dw_1
dw_2 dw_2
end type
global w_bpm403u_detail w_bpm403u_detail

type variables
string i_s_applyyear, i_s_revno
end variables
on w_bpm403u_detail.create
this.cb_3=create cb_3
this.sle_1=create sle_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.cb_3,&
this.sle_1,&
this.cb_1,&
this.dw_1,&
this.dw_2}
end on

on w_bpm403u_detail.destroy
destroy(this.cb_3)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

event open;string l_s_parm,ls_div,ls_plant,ls_itno
long ll_slen

integer li_width, li_height
li_width=3657 - this.width
li_height = 2100 - this.height
this.x = li_width/2
this.y = li_height/2

setpointer(hourglass!)
dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)
l_s_parm = message.stringparm
i_s_applyyear = mid(l_s_parm,1,4)
i_s_revno = mid(l_s_parm,5,2)
ls_plant = mid(l_s_parm,7,1)
ls_div = mid(l_s_parm,8,1)
ls_itno = trim(mid(l_s_parm,9,20))
sle_1.text=ls_itno
dw_1.reset()
dw_2.reset()
dw_1.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_itno,g_s_date)
dw_2.retrieve(i_s_applyyear,i_s_revno,ls_plant,ls_div,ls_itno,g_s_date)

end event

type cb_3 from commandbutton within w_bpm403u_detail
integer x = 946
integer y = 20
integer width = 219
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
end type

event clicked;closewithreturn(parent,' ')
end event

type sle_1 from singlelineedit within w_bpm403u_detail
integer x = 32
integer y = 12
integer width = 635
integer height = 104
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_bpm403u_detail
integer x = 699
integer y = 20
integer width = 219
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;string ls_itemnbr,ls_div,ls_plant

ls_plant = mid(message.stringparm,1,1)
ls_div = mid(message.stringparm,2,1)
if sle_1.text = " " then
	messagebox("확인","품번을 입력하십시요")
else
	ls_itemnbr = upper(sle_1.text)
end if
dw_1.reset()
dw_2.reset()
dw_1.retrieve(i_s_applyyear,ls_plant,ls_div,ls_itemnbr,g_s_date)
dw_2.retrieve(i_s_applyyear,ls_plant,ls_div,ls_itemnbr,g_s_date)

end event

type dw_1 from datawindow within w_bpm403u_detail
integer x = 27
integer y = 128
integer width = 1253
integer height = 988
integer taborder = 10
string dataobject = "d_bpm504_106u_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_bpm403u_detail
integer x = 1298
integer y = 128
integer width = 1682
integer height = 988
integer taborder = 20
string dataobject = "d_bpm504_106u_detail1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

