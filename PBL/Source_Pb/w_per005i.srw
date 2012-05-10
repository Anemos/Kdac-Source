$PBExportHeader$w_per005i.srw
$PBExportComments$공지사항 DISPLAY
forward
global type w_per005i from window
end type
type st_title from statictext within w_per005i
end type
type pb_1 from picturebutton within w_per005i
end type
type st_2 from statictext within w_per005i
end type
type st_user from statictext within w_per005i
end type
type mle_1 from multilineedit within w_per005i
end type
type rr_1 from roundrectangle within w_per005i
end type
end forward

global type w_per005i from window
integer x = 201
integer y = 500
integer width = 2482
integer height = 1348
boolean titlebar = true
string title = "공지사항"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "Information!"
boolean center = true
st_title st_title
pb_1 pb_1
st_2 st_2
st_user st_user
mle_1 mle_1
rr_1 rr_1
end type
global w_per005i w_per005i

forward prototypes
public subroutine wf_act ()
end prototypes

public subroutine wf_act ();//integer l_n_row
//string l_s_parm,l_s_name, l_s_out ,l_s_penamek
//
//dw_1.reset()
//
////l_s_parm = message.stringparm
////if l_s_parm = '' then
//	l_s_parm = sle_1.text
////end if
//
//
//if f_spacechk(sle_1.text) = -1 then
//	messagebox("확인","검색어를 입력하세요")
//   return
//end if
//
//l_s_name = trim(l_s_parm) + '%'
//l_n_row = dw_1.retrieve('%', l_s_name)
//
//if l_n_row < 1 then
//	messagebox("확인","해당자료가 없습니다")
//	return
//end if
//if l_n_row >= 1 then
//	dw_1.selectrow(1,true)
//	l_s_penamek = dw_1.getItemString(1,"penamek")
//	sle_1.text = l_s_penamek
//end if
end subroutine

on w_per005i.create
this.st_title=create st_title
this.pb_1=create pb_1
this.st_2=create st_2
this.st_user=create st_user
this.mle_1=create mle_1
this.rr_1=create rr_1
this.Control[]={this.st_title,&
this.pb_1,&
this.st_2,&
this.st_user,&
this.mle_1,&
this.rr_1}
end on

on w_per005i.destroy
destroy(this.st_title)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_user)
destroy(this.mle_1)
destroy(this.rr_1)
end on

event open;string ls_parm, ls_title, ls_text, ls_user

ls_parm = message.stringparm

select aa.title, aa.text, bb.penamek || ' '|| aa.updtdt
	into :ls_title, :ls_text, :ls_user
from pbper.perdsp aa, pbper.per001 bb
where aa.updtid = bb.peempno 
		and aa.win_id = :ls_parm
		and aa.frdt <= :g_s_date
		and aa.todt >= :g_s_date
		using sqlcc;
if sqlcc.sqlcode <> 0 then
	closewithreturn(this,'')
End if
st_title.text = ls_title
mle_1.text = ls_text
st_user.text = ls_user

pb_1.setfocus()
end event

event key;//if key = keyenter! then
//   pb_1.triggerevent(Clicked!)
//end if
end event

event activate;f_center_window(This)
end event

type st_title from statictext within w_per005i
integer x = 128
integer y = 12
integer width = 2149
integer height = 64
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean underline = true
long textcolor = 8388736
long backcolor = 16777215
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_per005i
integer x = 2098
integer y = 1148
integer width = 293
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
boolean default = true
boolean originalsize = true
string picturename = "C:\KDAC\bmp\cl_topBtn_close.gif"
alignment htextalign = left!
end type

event clicked;CloseWithReturn(Parent, "")
end event

type st_2 from statictext within w_per005i
integer x = 101
integer y = 1164
integer width = 233
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 16777215
string text = "작성자 :"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_user from statictext within w_per005i
integer x = 357
integer y = 1164
integer width = 1623
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 16777215
string text = "작성자"
boolean focusrectangle = false
end type

type mle_1 from multilineedit within w_per005i
integer x = 59
integer y = 136
integer width = 2299
integer height = 960
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "Arrow!"
long textcolor = 16711680
long backcolor = 32435434
string text = "공지사항"
boolean border = false
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type rr_1 from roundrectangle within w_per005i
long linecolor = 29992855
integer linethickness = 4
long fillcolor = 32435434
integer x = 27
integer y = 96
integer width = 2363
integer height = 1044
integer cornerheight = 40
integer cornerwidth = 55
end type

