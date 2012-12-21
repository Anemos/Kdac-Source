$PBExportHeader$w_piss611r.srw
$PBExportComments$라벨구분관리윈도우
forward
global type w_piss611r from window
end type
type cb_delete from commandbutton within w_piss611r
end type
type cb_save from commandbutton within w_piss611r
end type
type cb_insert from commandbutton within w_piss611r
end type
type dw_piss611r_01 from datawindow within w_piss611r
end type
type gb_1 from groupbox within w_piss611r
end type
end forward

global type w_piss611r from window
integer width = 2555
integer height = 1132
boolean titlebar = true
string title = "라벨구분관리"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_delete cb_delete
cb_save cb_save
cb_insert cb_insert
dw_piss611r_01 dw_piss611r_01
gb_1 gb_1
end type
global w_piss611r w_piss611r

type variables
string is_area, is_division
end variables

on w_piss611r.create
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_insert=create cb_insert
this.dw_piss611r_01=create dw_piss611r_01
this.gb_1=create gb_1
this.Control[]={this.cb_delete,&
this.cb_save,&
this.cb_insert,&
this.dw_piss611r_01,&
this.gb_1}
end on

on w_piss611r.destroy
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_insert)
destroy(this.dw_piss611r_01)
destroy(this.gb_1)
end on

event open;str_parms lstr_parm

dw_piss611r_01.settransobject(sqlpis)

lstr_parm = message.PowerObjectparm
is_area = lstr_parm.string_arg[1]
is_division = lstr_parm.string_arg[2]

dw_piss611r_01.retrieve(is_area, is_division)

end event

type cb_delete from commandbutton within w_piss611r
integer x = 1577
integer y = 884
integer width = 347
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "삭제"
end type

event clicked;long ll_selrow

ll_selrow = dw_piss611r_01.getselectedrow(0)
if ll_selrow < 1 then
	messagebox("알림","삭제할 데이타를 선택해 주십시요")
	return 0
end if
dw_piss611r_01.deleterow(ll_selrow)
end event

type cb_save from commandbutton within w_piss611r
integer x = 2043
integer y = 884
integer width = 347
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "저장"
end type

event clicked;dw_piss611r_01.accepttext()

if dw_piss611r_01.update() = 1 then
	messagebox("알림","정상적으로 저장되었습니다.")
else
	messagebox("알림","저장시에 에러가 발생하였습니다.")
end if
end event

type cb_insert from commandbutton within w_piss611r
integer x = 1111
integer y = 884
integer width = 347
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "입력"
end type

event clicked;long ll_currow

ll_currow = dw_piss611r_01.insertrow(0)
dw_piss611r_01.setitem(ll_currow, "areacode", is_area)
dw_piss611r_01.setitem(ll_currow, "divisioncode", is_division)

end event

type dw_piss611r_01 from datawindow within w_piss611r
integer x = 9
integer y = 16
integer width = 2514
integer height = 828
integer taborder = 10
string title = "none"
string dataobject = "d_piss611r_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;This.setitem(row, "lastemp", g_s_empno)
end event

type gb_1 from groupbox within w_piss611r
integer x = 14
integer y = 844
integer width = 2505
integer height = 152
integer taborder = 20
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

