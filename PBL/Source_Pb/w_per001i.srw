$PBExportHeader$w_per001i.srw
$PBExportComments$발령번호조회
forward
global type w_per001i from window
end type
type cb_2 from commandbutton within w_per001i
end type
type cb_1 from commandbutton within w_per001i
end type
type pb_1 from picturebutton within w_per001i
end type
type st_2 from statictext within w_per001i
end type
type dw_1 from datawindow within w_per001i
end type
type uo_1 from uo_inpdt_1 within w_per001i
end type
end forward

global type w_per001i from window
integer x = 201
integer y = 500
integer width = 1970
integer height = 1476
boolean titlebar = true
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 16777215
cb_2 cb_2
cb_1 cb_1
pb_1 pb_1
st_2 st_2
dw_1 dw_1
uo_1 uo_1
end type
global w_per001i w_per001i

on w_per001i.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_1=create pb_1
this.st_2=create st_2
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.pb_1,&
this.st_2,&
this.dw_1,&
this.uo_1}
end on

on w_per001i.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;

uo_1.em_1.setfocus()
uo_1.em_2.text = g_s_date

dw_1.settransobject(sqlcc)
dw_1.reset()






end event

event key;//if key = keyenter! then
//   pb_1.triggerevent(Clicked!)
//end if
end event

event activate;f_center_window(This)
end event

type cb_2 from commandbutton within w_per001i
integer x = 1550
integer y = 1264
integer width = 293
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
boolean cancel = true
end type

event clicked;string l_s_parm

l_s_parm = ""

CloseWithReturn( Parent , l_s_parm)
end event

type cb_1 from commandbutton within w_per001i
integer x = 1221
integer y = 1264
integer width = 293
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
end type

event clicked;string  l_s_parm, l_s_odno ,l_s_odorder
integer l_s_row

l_s_row = dw_1.getSelectedrow(0)
l_s_odno = dw_1.getitemstring(l_s_row, "odno")
l_s_odorder = dw_1.getitemstring(l_s_row, "odorder")
l_s_parm = trim(l_s_odno) +trim(l_s_odorder)

if f_spacechk(l_s_parm) = -1 then
	messagebox("확인","발령번호을 선택하세요")
	return
else
	closewithreturn(parent,l_s_parm)
	
end if
end event

type pb_1 from picturebutton within w_per001i
integer x = 1362
integer y = 40
integer width = 238
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean default = true
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = right!
end type

event clicked;string ls_fdt, ls_tdt
int    l_n_row
uo_1.em_1.getdata(ls_fdt)
uo_1.em_2.getdata(ls_tdt)

if f_spacechk(ls_fdt) = -1 then
	ls_fdt = g_s_date
end if

l_n_row = dw_1.retrieve(ls_fdt, ls_tdt)


if l_n_row < 1 then
	messagebox("확인","해당자료가 없습니다")
end if

end event

type st_2 from statictext within w_per001i
integer x = 32
integer y = 72
integer width = 293
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 16777215
string text = "발령일자"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_per001i
integer x = 41
integer y = 168
integer width = 1801
integer height = 1080
integer taborder = 10
string title = "none"
string dataobject = "d_per001i"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;//string  l_s_parm, l_s_odno ,l_s_odorder
//integer l_s_row
//
//this.selectrow(0,false)
//this.selectrow(row,true)
//
//l_s_row = dw_1.getrow()
//l_s_odno = dw_1.getitemstring(l_s_row, "odno")
//l_s_odorder = dw_1.getitemstring(l_s_row, "odorder")
//l_s_parm = trim(l_s_odno) +trim(l_s_odorder)
//
//if f_spacechk(l_s_parm) = -1 then
//	messagebox("확인","발령번호을 선택하세요")
//	return
//else
//	closewithreturn(parent,l_s_parm)
//	
//end if
end event

event constructor;this.settransobject(sqlcc)
end event

event clicked;this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
end event

type uo_1 from uo_inpdt_1 within w_per001i
integer x = 329
integer y = 44
integer width = 997
integer height = 120
integer taborder = 30
long backcolor = 16777215
end type

on uo_1.destroy
call uo_inpdt_1::destroy
end on

