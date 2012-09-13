$PBExportHeader$w_pisr161i.srw
$PBExportComments$개별간판이력조회
forward
global type w_pisr161i from window
end type
type pb_2 from picturebutton within w_pisr161i
end type
type pb_1 from picturebutton within w_pisr161i
end type
type dw_2 from u_vi_std_datawindow within w_pisr161i
end type
type gb_1 from groupbox within w_pisr161i
end type
type dw_1 from datawindow within w_pisr161i
end type
end forward

global type w_pisr161i from window
integer width = 4512
integer height = 2572
boolean titlebar = true
string title = "개별간판 이력현황조회"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
pb_2 pb_2
pb_1 pb_1
dw_2 dw_2
gb_1 gb_1
dw_1 dw_1
end type
global w_pisr161i w_pisr161i

on w_pisr161i.create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_2=create dw_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.Control[]={this.pb_2,&
this.pb_1,&
this.dw_2,&
this.gb_1,&
this.dw_1}
end on

on w_pisr161i.destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_2)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event open;
f_pisc_win_center_move(This)

String	ls_arg
String	ls_partkbno, ls_from, ls_to

ls_arg 		= Message.StringParm // ls_partkbno(11) + '@' + ls_from(10) + '@' + ls_to(10)
ls_partkbno	= left(ls_arg, 11)
ls_from		= mid(ls_arg, 13, 10)
ls_to			= mid(ls_arg, 24, 10)

dw_1.SetTransObject(sqlpis)
dw_1.Retrieve(ls_partkbno)

dw_2.SetTransObject(sqlpis)
dw_2.Retrieve(ls_partkbno,ls_from,ls_to)


end event

type pb_2 from picturebutton within w_pisr161i
integer x = 4101
integer y = 64
integer width = 329
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
boolean originalsize = true
end type

event clicked;
CloseWithReturn(parent, 'Close')
end event

type pb_1 from picturebutton within w_pisr161i
integer x = 3753
integer y = 64
integer width = 329
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "출력"
boolean originalsize = true
end type

event clicked;
CloseWithReturn(parent, 'Print')
end event

type dw_2 from u_vi_std_datawindow within w_pisr161i
integer x = 9
integer y = 540
integer width = 4480
integer height = 1940
integer taborder = 10
string dataobject = "d_pisr161i_02"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type gb_1 from groupbox within w_pisr161i
integer x = 3712
integer y = 8
integer width = 754
integer height = 196
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_pisr161i
integer x = 14
integer y = 32
integer width = 3410
integer height = 508
integer taborder = 10
string title = "none"
string dataobject = "d_pisr161i_01"
boolean border = false
boolean livescroll = true
end type

