$PBExportHeader$w_per000i.srw
$PBExportComments$성명순조회-seleclt
forward
global type w_per000i from window
end type
type rb_2 from radiobutton within w_per000i
end type
type rb_1 from radiobutton within w_per000i
end type
type pb_1 from picturebutton within w_per000i
end type
type st_1 from statictext within w_per000i
end type
type sle_1 from singlelineedit within w_per000i
end type
type cb_2 from commandbutton within w_per000i
end type
type cb_1 from commandbutton within w_per000i
end type
type dw_1 from datawindow within w_per000i
end type
type gb_2 from groupbox within w_per000i
end type
end forward

global type w_per000i from window
integer x = 201
integer y = 500
integer width = 2176
integer height = 1388
boolean titlebar = true
string title = "이름 찾기"
boolean controlmenu = true
boolean vscrollbar = true
windowtype windowtype = response!
long backcolor = 16777215
rb_2 rb_2
rb_1 rb_1
pb_1 pb_1
st_1 st_1
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_2 gb_2
end type
global w_per000i w_per000i

forward prototypes
public subroutine wf_act ()
end prototypes

public subroutine wf_act ();integer l_n_row
string l_s_parm,l_s_name, l_s_out ,l_s_penamek

dw_1.reset()

//l_s_parm = message.stringparm
//if l_s_parm = '' then
	l_s_parm = sle_1.text
//end if
if rb_1.checked = true then
	l_s_out = '1'
elseif rb_2.checked = true then
	l_s_out = '*'
end if

if f_spacechk(sle_1.text) = -1 then
	messagebox("확인","검색어를 입력하세요")
   return
end if

l_s_name = trim(l_s_parm) + '%'
l_n_row = dw_1.retrieve(l_s_out, l_s_name)

if l_n_row < 1 then
	messagebox("확인","해당자료가 없습니다")
	return
end if
if l_n_row >= 1 then
	dw_1.selectrow(1,true)
	l_s_penamek = dw_1.getItemString(1,"penamek")
	sle_1.text = l_s_penamek
end if
end subroutine

on w_per000i.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.pb_1=create pb_1
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_2=create gb_2
this.Control[]={this.rb_2,&
this.rb_1,&
this.pb_1,&
this.st_1,&
this.sle_1,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_2}
end on

on w_per000i.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_2)
end on

event open;string l_s_parm,l_s_name, l_s_empno
int l_n_cnt
sle_1.setfocus()
rb_1.checked = true

dw_1.settransobject(sqlcc)
dw_1.reset()

l_s_parm = message.stringparm
sle_1.text = trim(l_s_parm)

l_s_name = trim(l_s_parm) + '%'

l_n_cnt = 0
select count(*) into :l_n_cnt
from pbper.per001 
where penamek like :l_s_name and peout <> '*'
using sqlcc;

if l_n_cnt = 1 then
  select peempno into :l_s_empno
  from pbper.per001 
  where penamek like :l_s_name and peout <> '*'
  using sqlcc;  
  closewithreturn(this,trim(l_s_empno)+trim(l_s_parm))
else
	wf_act()
end if
end event

event key;//if key = keyenter! then
//   pb_1.triggerevent(Clicked!)
//end if
end event

event activate;f_center_window(This)
end event

type rb_2 from radiobutton within w_per000i
integer x = 1728
integer y = 40
integer width = 261
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 16777215
string text = "퇴사"
end type

event clicked;wf_act()
end event

type rb_1 from radiobutton within w_per000i
integer x = 1413
integer y = 40
integer width = 293
integer height = 104
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 16777215
string text = "재직"
end type

event clicked;wf_act()
end event

type pb_1 from picturebutton within w_per000i
integer x = 1015
integer y = 40
integer width = 238
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean default = true
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;wf_act()
end event

type st_1 from statictext within w_per000i
integer x = 64
integer y = 68
integer width = 315
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 16777215
string text = "성   명 "
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_per000i
integer x = 393
integer y = 44
integer width = 594
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
end type

event losefocus;f_toggle_per( handle( Parent ), 'ENG' )
end event

event getfocus;f_toggle_per( handle( Parent ), 'KOR' )
end event

type cb_2 from commandbutton within w_per000i
integer x = 1765
integer y = 1196
integer width = 288
integer height = 104
integer taborder = 40
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
l_s_parm = ""
closewithreturn(parent,l_s_parm)
end event

type cb_1 from commandbutton within w_per000i
integer x = 1472
integer y = 1196
integer width = 288
integer height = 104
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확 인"
end type

event clicked;string  l_s_name, l_s_parm, l_s_empno
integer l_s_row

l_s_row = dw_1.getrow()
l_s_empno = dw_1.getitemstring(l_s_row, "peempno")
l_s_name  = dw_1.getitemstring(l_s_row, "penamek")

l_s_parm = trim(l_s_empno) + trim(l_s_name)
//messagebox('l_s_parm' ,mid(l_s_parm,1,6) + ' ' + mid(l_s_parm,7,10)  )
if f_spacechk(l_s_parm) = -1 then
	//messagebox("확인","이름을 선택하세요")
	return
else
	closewithreturn(parent,l_s_parm)
end if
end event

type dw_1 from datawindow within w_per000i
integer x = 41
integer y = 160
integer width = 2016
integer height = 1032
string title = "none"
string dataobject = "d_per000i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;string  l_s_name, l_s_parm, l_s_empno
integer l_s_row

this.selectrow(0,false)
this.selectrow(row,true)

l_s_row = dw_1.getrow()
l_s_empno = dw_1.getitemstring(l_s_row, "peempno")
l_s_name  = dw_1.getitemstring(l_s_row, "penamek")

l_s_parm = trim(l_s_empno) + trim(l_s_name)

if f_spacechk(l_s_parm) = -1 then
	messagebox("확인","성명을 선택하세요")
	return
else
	closewithreturn(parent,l_s_parm)	
end if
end event

event clicked;string l_s_penamek
this.SelectRow(0, FALSE)
this.SelectRow(row, TRUE)
	
	
//l_s_penamek = dw_1.getItemString(row,"penamek")
//sle_1.text = l_s_penamek
end event

type gb_2 from groupbox within w_per000i
integer x = 1385
integer width = 663
integer height = 152
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
end type

