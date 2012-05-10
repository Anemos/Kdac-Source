$PBExportHeader$w_wip053u_02.srw
$PBExportComments$취합자료내역확인
forward
global type w_wip053u_02 from window
end type
type cb_close from commandbutton within w_wip053u_02
end type
type pb_down from picturebutton within w_wip053u_02
end type
type dw_wip053u_02_01 from datawindow within w_wip053u_02
end type
end forward

global type w_wip053u_02 from window
integer width = 4032
integer height = 2248
boolean titlebar = true
string title = "공장별 KncokDown 및 실사수량 취합 내역"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
pb_down pb_down
dw_wip053u_02_01 dw_wip053u_02_01
end type
global w_wip053u_02 w_wip053u_02

type variables
string is_year, is_month, is_plant, is_dvsn
end variables

on w_wip053u_02.create
this.cb_close=create cb_close
this.pb_down=create pb_down
this.dw_wip053u_02_01=create dw_wip053u_02_01
this.Control[]={this.cb_close,&
this.pb_down,&
this.dw_wip053u_02_01}
end on

on w_wip053u_02.destroy
destroy(this.cb_close)
destroy(this.pb_down)
destroy(this.dw_wip053u_02_01)
end on

event open;string ls_parm

dw_wip053u_02_01.settransobject(sqlca)
ls_parm = message.stringparm

is_year = mid(ls_parm,1,4)
is_month = mid(ls_parm,5,2)
is_plant = mid(ls_parm,7,1)
is_dvsn = mid(ls_parm,8,1)

dw_wip053u_02_01.retrieve(is_year,is_month,g_s_company,is_plant,is_dvsn)

end event

type cb_close from commandbutton within w_wip053u_02
integer x = 3529
integer y = 24
integer width = 457
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "화면 닫기"
end type

event clicked;close(w_wip053u_02)
end event

type pb_down from picturebutton within w_wip053u_02
integer x = 2990
integer y = 24
integer width = 416
integer height = 108
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

event clicked;if dw_wip053u_02_01.rowcount() > 0 then
	f_save_to_excel(dw_wip053u_02_01)
end if
end event

type dw_wip053u_02_01 from datawindow within w_wip053u_02
integer x = 27
integer y = 152
integer width = 3959
integer height = 1984
integer taborder = 10
string title = "none"
string dataobject = "d_wip053u_02_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

