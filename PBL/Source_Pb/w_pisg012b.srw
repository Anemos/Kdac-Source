$PBExportHeader$w_pisg012b.srw
$PBExportComments$현장관리_시스템종료 확인
forward
global type w_pisg012b from window
end type
type st_2 from statictext within w_pisg012b
end type
type st_1 from statictext within w_pisg012b
end type
type pb_exit from picturebutton within w_pisg012b
end type
type pb_ok from picturebutton within w_pisg012b
end type
type gb_1 from groupbox within w_pisg012b
end type
type gb_2 from groupbox within w_pisg012b
end type
end forward

global type w_pisg012b from window
integer x = 302
integer y = 760
integer width = 2345
integer height = 848
boolean titlebar = true
string title = "시스템 종료"
windowtype windowtype = response!
long backcolor = 79219928
st_2 st_2
st_1 st_1
pb_exit pb_exit
pb_ok pb_ok
gb_1 gb_1
gb_2 gb_2
end type
global w_pisg012b w_pisg012b

type prototypes
FUNCTION boolean ExitWindowsEx(uint dwReserved, uint uReserved) LIBRARY "User32.dll"
end prototypes

type variables
INTEGER	ii_time_count
end variables

on w_pisg012b.create
this.st_2=create st_2
this.st_1=create st_1
this.pb_exit=create pb_exit
this.pb_ok=create pb_ok
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_2,&
this.st_1,&
this.pb_exit,&
this.pb_ok,&
this.gb_1,&
this.gb_2}
end on

on w_pisg012b.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_exit)
destroy(this.pb_ok)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;f_centerwindow(this)

pb_exit.SetFocus()
end event

type st_2 from statictext within w_pisg012b
integer x = 178
integer y = 220
integer width = 1957
integer height = 156
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "시스템을 종료합니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisg012b
integer x = 50
integer y = 152
integer width = 2213
integer height = 292
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 0
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type pb_exit from picturebutton within w_pisg012b
integer x = 1710
integer y = 496
integer width = 553
integer height = 224
integer taborder = 40
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
vtextalign vtextalign = vcenter!
end type

event clicked;/*######################################################################
#####		w_pisg012b 윈도우 종료												 #####
######################################################################*/

Close(w_pisg012b)


end event

type pb_ok from picturebutton within w_pisg012b
integer x = 50
integer y = 496
integer width = 553
integer height = 224
integer taborder = 30
integer textsize = -20
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
vtextalign vtextalign = vcenter!
end type

event clicked;/*######################################################################
#####		씨리얼 통신																 #####
######################################################################*/

IF gs_SerialFlag = "2" THEN
	// 통신 포트 OPEN
	w_pisg010b.ole_comm.object.portopen	= FALSE
END IF

/*######################################################################
#####		시스템종료 종료														 #####
######################################################################*/

ExitWindowsEx(1, 4)

end event

type gb_1 from groupbox within w_pisg012b
integer x = 18
integer y = 40
integer width = 2277
integer height = 444
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 128
long backcolor = 79219928
string text = "시스템 종료"
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisg012b
integer x = 18
integer y = 472
integer width = 2277
integer height = 276
integer taborder = 20
integer textsize = -2
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 79219928
borderstyle borderstyle = stylelowered!
end type

