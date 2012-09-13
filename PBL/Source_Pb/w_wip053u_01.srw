$PBExportHeader$w_wip053u_01.srw
$PBExportComments$출력구분 및 실사일 입력
forward
global type w_wip053u_01 from window
end type
type cb_cancel from commandbutton within w_wip053u_01
end type
type em_date from editmask within w_wip053u_01
end type
type st_2 from statictext within w_wip053u_01
end type
type cb_ok from commandbutton within w_wip053u_01
end type
type rb_tag from radiobutton within w_wip053u_01
end type
type rb_list from radiobutton within w_wip053u_01
end type
type st_1 from statictext within w_wip053u_01
end type
type gb_1 from groupbox within w_wip053u_01
end type
end forward

global type w_wip053u_01 from window
integer width = 1829
integer height = 428
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
em_date em_date
st_2 st_2
cb_ok cb_ok
rb_tag rb_tag
rb_list rb_list
st_1 st_1
gb_1 gb_1
end type
global w_wip053u_01 w_wip053u_01

on w_wip053u_01.create
this.cb_cancel=create cb_cancel
this.em_date=create em_date
this.st_2=create st_2
this.cb_ok=create cb_ok
this.rb_tag=create rb_tag
this.rb_list=create rb_list
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_cancel,&
this.em_date,&
this.st_2,&
this.cb_ok,&
this.rb_tag,&
this.rb_list,&
this.st_1,&
this.gb_1}
end on

on w_wip053u_01.destroy
destroy(this.cb_cancel)
destroy(this.em_date)
destroy(this.st_2)
destroy(this.cb_ok)
destroy(this.rb_tag)
destroy(this.rb_list)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;rb_list.checked = true
em_date.text = g_s_date
end event

type cb_cancel from commandbutton within w_wip053u_01
integer x = 1472
integer y = 204
integer width = 288
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
end type

event clicked;CloseWithReturn ( w_wip053u_01, ' ' )
end event

type em_date from editmask within w_wip053u_01
integer x = 503
integer y = 204
integer width = 507
integer height = 88
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

type st_2 from statictext within w_wip053u_01
integer x = 59
integer y = 224
integer width = 434
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "재공실사일자:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_wip053u_01
integer x = 1129
integer y = 204
integer width = 288
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "확인"
end type

event clicked;string ls_gubun, ls_printdate

if rb_list.checked then
	ls_gubun = '1'
else
	ls_gubun = '2'
end if

em_date.getdata(ls_printdate)

CloseWithReturn ( w_wip053u_01, ls_gubun + ls_printdate )
end event

type rb_tag from radiobutton within w_wip053u_01
integer x = 1051
integer y = 60
integer width = 590
integer height = 80
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "재공실사조사표"
end type

type rb_list from radiobutton within w_wip053u_01
integer x = 489
integer y = 60
integer width = 549
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "재공실사대장"
end type

type st_1 from statictext within w_wip053u_01
integer x = 87
integer y = 72
integer width = 352
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "출력구분:"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_wip053u_01
integer x = 27
integer width = 1755
integer height = 168
integer textsize = -6
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

