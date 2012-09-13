$PBExportHeader$w_per002i.srw
$PBExportComments$우편번호검색
forward
global type w_per002i from window
end type
type cb_2 from commandbutton within w_per002i
end type
type cb_1 from commandbutton within w_per002i
end type
type pb_1 from picturebutton within w_per002i
end type
type st_1 from statictext within w_per002i
end type
type em_1 from editmask within w_per002i
end type
type dw_1 from datawindow within w_per002i
end type
end forward

global type w_per002i from window
integer width = 2153
integer height = 1828
boolean titlebar = true
string title = "우편번호검색"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
cb_2 cb_2
cb_1 cb_1
pb_1 pb_1
st_1 st_1
em_1 em_1
dw_1 dw_1
end type
global w_per002i w_per002i

type variables
string  i_s_parm
end variables

on w_per002i.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_1=create pb_1
this.st_1=create st_1
this.em_1=create em_1
this.dw_1=create dw_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.pb_1,&
this.st_1,&
this.em_1,&
this.dw_1}
end on

on w_per002i.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.dw_1)
end on

event key;//if key = keyenter! then
//   pb_1.triggerevent(Clicked!)
//end if
end event

event open;
em_1.setfocus()
dw_1.settransobject(sqlcc)
dw_1.reset()


end event

event close;string l_s_parm


l_s_parm = i_s_parm

CloseWithReturn( this , l_s_parm)
end event

event activate;f_center_window(This)
end event

type cb_2 from commandbutton within w_per002i
integer x = 1829
integer y = 1640
integer width = 288
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취 소"
boolean cancel = true
end type

event clicked;string l_s_parm

l_s_parm = "CANCEL"
i_s_parm = l_s_parm
CloseWithReturn( Parent , i_s_parm)
end event

type cb_1 from commandbutton within w_per002i
integer x = 1527
integer y = 1640
integer width = 288
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;string  l_s_post, l_s_parm, l_s_area,l_s_gu, l_s_addr
integer l_s_row , l_n_rtn

l_s_row   = dw_1.getSelectedrow(0)
l_s_post  = dw_1.getitemstring(l_s_row, "post")
l_s_area  = trim(dw_1.getitemstring(l_s_row, "coitname"))
l_s_gu    = trim(dw_1.getitemstring(l_s_row, "coitnamee"))
l_s_addr  = trim(dw_1.getitemstring(l_s_row, "coflname"))
l_s_parm = trim(l_s_post) + trim(l_s_area) + '  ' + trim(l_s_gu) +'  '+ trim(l_s_addr)
i_s_parm = l_s_parm
//messagebox('l_s_parm',i_s_parm)
if f_spacechk(i_s_parm) = -1 then
	messagebox("확인","우편번호을 선택하세요")
	return
else
	CloseWithReturn( Parent , i_s_parm)
end if
end event

type pb_1 from picturebutton within w_per002i
integer x = 1445
integer y = 12
integer width = 238
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string pointer = "HyperLink!"
boolean default = true
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_dong
int    l_n_row
em_1.getdata(l_s_dong)


if f_spacechk(l_s_dong) = -1 then
	messagebox("확인","동,면을 입력하시오")
	em_1.setfocus()
	return
end if
l_s_dong = '%' + trim(l_s_dong) + '%'
l_n_row = dw_1.retrieve(l_s_dong)


if l_n_row < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type st_1 from statictext within w_per002i
integer x = 50
integer y = 56
integer width = 613
integer height = 52
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 16777215
string text = "동,면 을입력하시오 "
boolean focusrectangle = false
end type

type em_1 from editmask within w_per002i
integer x = 709
integer y = 24
integer width = 722
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event getfocus;
f_toggle_per( handle( Parent ), 'KOR' )

end event

event losefocus;
f_toggle_per( handle( Parent ), 'ENG' )
end event

type dw_1 from datawindow within w_per002i
integer x = 18
integer y = 124
integer width = 2117
integer height = 1512
integer taborder = 10
string title = "none"
string dataobject = "d_per002i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
end event

event constructor;this.settransobject(sqlcc)
end event

event doubleclicked;string  l_s_post, l_s_parm, l_s_area,l_s_gu, l_s_addr
integer l_s_row , l_n_rtn

l_s_row   = dw_1.getSelectedrow(0)
l_s_post  = dw_1.getitemstring(l_s_row, "post")
l_s_area  = trim(dw_1.getitemstring(l_s_row, "coitname"))
l_s_gu    = trim(dw_1.getitemstring(l_s_row, "coitnamee"))
l_s_addr  = trim(dw_1.getitemstring(l_s_row, "coflname"))
l_s_parm = trim(l_s_post) + trim(l_s_area) + ' ' + trim(l_s_gu) +' '+ trim(l_s_addr)
i_s_parm = l_s_parm
//messagebox('l_s_parm',i_s_parm)
if f_spacechk(i_s_parm) = -1 then
	messagebox("확인","우편번호을 선택하세요")
	return
else
	CloseWithReturn( Parent , i_s_parm)
end if
end event

