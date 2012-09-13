$PBExportHeader$w_piss9032.srw
$PBExportComments$상차보기
forward
global type w_piss9032 from window
end type
type dw_print from datawindow within w_piss9032
end type
type dw_srview from datawindow within w_piss9032
end type
type cb_3 from commandbutton within w_piss9032
end type
type cb_2 from commandbutton within w_piss9032
end type
type cb_1 from commandbutton within w_piss9032
end type
type em_1 from editmask within w_piss9032
end type
type gb_1 from groupbox within w_piss9032
end type
type gb_2 from groupbox within w_piss9032
end type
end forward

global type w_piss9032 from window
integer width = 3941
integer height = 2152
boolean titlebar = true
string title = "SR보기"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
event ue_reset ( )
dw_print dw_print
dw_srview dw_srview
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
em_1 em_1
gb_1 gb_1
gb_2 gb_2
end type
global w_piss9032 w_piss9032

type variables
string is_srno,is_areacode,is_divisioncode,is_date
boolean ib_open
end variables

event ue_reset;dw_srview.reset()
end event

on w_piss9032.create
this.dw_print=create dw_print
this.dw_srview=create dw_srview
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.em_1=create em_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_print,&
this.dw_srview,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.em_1,&
this.gb_1,&
this.gb_2}
end on

on w_piss9032.destroy
destroy(this.dw_print)
destroy(this.dw_srview)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;String ls_parm, ls_size, ls_srno

SetPointer(HourGlass!)

ls_parm 		= Message.StringParm
ls_size	= Left(ls_parm, 50)

//f_win_move(This, ls_size)
is_srno	= Trim(Mid(ls_parm, 1,11))
is_date = Trim(Mid(ls_parm, 12,10))
is_areacode = Trim(Mid(ls_parm,22,1))
is_divisioncode = Trim(Mid(ls_parm,23,1))
em_1.text = is_srno
dw_srview.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
dw_srview.sharedata(dw_print)


If Upper(ls_srno) = 'NO' Then
	em_1.setfocus()
else
    dw_srview.Retrieve(is_srno,is_date,is_areacode,is_divisioncode)
 	if dw_srview.rowcount() = 0 Then
		messagebox("확인","조회하고자 하는 SR번호가 없습니다.")
	end if

end if

ib_open= true

end event

type dw_print from datawindow within w_piss9032
boolean visible = false
integer x = 1307
integer y = 600
integer width = 411
integer height = 432
integer taborder = 50
string title = "none"
string dataobject = "d_piss110i_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_srview from datawindow within w_piss9032
integer x = 32
integer y = 244
integer width = 3863
integer height = 1804
integer taborder = 40
string title = "none"
string dataobject = "d_piss9032_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_piss9032
integer x = 2080
integer y = 96
integer width = 320
integer height = 92
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종료"
end type

event clicked;Close(Parent)
end event

type cb_2 from commandbutton within w_piss9032
integer x = 1760
integer y = 96
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "출력"
end type

event clicked;String	ls_mod
str_easy	lstr_prt

//ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
//ls_mod	= ls_mod + is_mod1
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= 'SR보기'
lstr_prt.tag			= 'SR보기'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

type cb_1 from commandbutton within w_piss9032
integer x = 1440
integer y = 96
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "조회"
end type

event clicked;//If Len(is_srno) = 11 Then
	dw_srview.retrieve(is_srno,is_date,is_areacode,is_divisioncode)
	dw_srview.setfocus()
//End If


end event

type em_1 from editmask within w_piss9032
integer x = 82
integer y = 96
integer width = 608
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

event modified;is_srno = this.text
end event

type gb_1 from groupbox within w_piss9032
integer x = 37
integer y = 32
integer width = 695
integer height = 200
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "SR번호"
end type

type gb_2 from groupbox within w_piss9032
integer x = 1403
integer y = 24
integer width = 1038
integer height = 208
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "버튼정보"
end type

