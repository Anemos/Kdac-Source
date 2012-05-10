$PBExportHeader$w_psnl001i.srw
$PBExportComments$동명이인조회
forward
global type w_psnl001i from window
end type
type pb_2 from picturebutton within w_psnl001i
end type
type st_2 from statictext within w_psnl001i
end type
type pb_1 from picturebutton within w_psnl001i
end type
type dw_1 from datawindow within w_psnl001i
end type
type gb_1 from groupbox within w_psnl001i
end type
end forward

global type w_psnl001i from window
integer x = 110
integer y = 268
integer width = 2496
integer height = 1248
boolean titlebar = true
string title = "동명이인조회"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
pb_2 pb_2
st_2 st_2
pb_1 pb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_psnl001i w_psnl001i

event open;string  	l_s_sql, l_s_gubn, l_s_name, l_s_empno
int		l_n_rcnt, l_n_ret

dw_1.SetTransObject(sqlca)
if f_spacechk(trim(Message.StringParm)) = -1 then
	closewithreturn(this, '')
	return
end if

l_s_name	=	Message.StringParm
l_n_rcnt	= 	dw_1.retrieve(l_s_name)

if l_n_rcnt			< 	1	then
	closewithreturn(this, '')
elseif l_n_rcnt	=	1	then
	l_s_empno = dw_1.object.peempno[1]
	closewithreturn(this, l_s_empno)
else
	dw_1.SelectRow(0, FALSE)
	dw_1.SelectRow(1, TRUE)
end if

end event

on w_psnl001i.create
this.pb_2=create pb_2
this.st_2=create st_2
this.pb_1=create pb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.pb_2,&
this.st_2,&
this.pb_1,&
this.dw_1,&
this.gb_1}
end on

on w_psnl001i.destroy
destroy(this.pb_2)
destroy(this.st_2)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type pb_2 from picturebutton within w_psnl001i
integer x = 2162
integer y = 1008
integer width = 265
integer height = 124
integer taborder = 20
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
vtextalign vtextalign = vcenter!
end type

event clicked;
closewithreturn(parent, '')
end event

type st_2 from statictext within w_psnl001i
integer x = 32
integer y = 1060
integer width = 1783
integer height = 76
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "⊙ 해당자료를 선택한 후 ~'확인~'을 누르십시오."
boolean focusrectangle = false
end type

type pb_1 from picturebutton within w_psnl001i
integer x = 1883
integer y = 1004
integer width = 265
integer height = 124
integer taborder = 20
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
boolean default = true
vtextalign vtextalign = vcenter!
end type

event clicked;int	l_n_row

l_n_row		= 	dw_1.getrow()

if l_n_row	<	1 then
	messagebox("확 인","해당 자료를 선택 하신 후 확인을 누르십시오")
   Return
else	
	closewithreturn(parent, string(dw_1.object.peempno[l_n_row]))
end if	

	
end event

type dw_1 from datawindow within w_psnl001i
integer x = 32
integer y = 28
integer width = 2418
integer height = 916
integer taborder = 10
string dataobject = "d_psnl001i_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
//l_s_emp_no		=	this.getitemstring(row, "emp_no")	

end event

event clicked;
if row			< 	1 then
	return
end if

this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)

end event

type gb_1 from groupbox within w_psnl001i
integer x = 1865
integer y = 984
integer width = 581
integer height = 164
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

