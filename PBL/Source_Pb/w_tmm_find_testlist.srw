$PBExportHeader$w_tmm_find_testlist.srw
$PBExportComments$의뢰내용선택윈도우
forward
global type w_tmm_find_testlist from window
end type
type st_2 from statictext within w_tmm_find_testlist
end type
type st_1 from statictext within w_tmm_find_testlist
end type
type dw_tmm_find_testlist_02 from datawindow within w_tmm_find_testlist
end type
type cb_close from commandbutton within w_tmm_find_testlist
end type
type dw_tmm_find_testlist_01 from datawindow within w_tmm_find_testlist
end type
end forward

global type w_tmm_find_testlist from window
integer width = 3099
integer height = 1588
boolean titlebar = true
string title = "금형의뢰번호 찾기"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
dw_tmm_find_testlist_02 dw_tmm_find_testlist_02
cb_close cb_close
dw_tmm_find_testlist_01 dw_tmm_find_testlist_01
end type
global w_tmm_find_testlist w_tmm_find_testlist

on w_tmm_find_testlist.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_tmm_find_testlist_02=create dw_tmm_find_testlist_02
this.cb_close=create cb_close
this.dw_tmm_find_testlist_01=create dw_tmm_find_testlist_01
this.Control[]={this.st_2,&
this.st_1,&
this.dw_tmm_find_testlist_02,&
this.cb_close,&
this.dw_tmm_find_testlist_01}
end on

on w_tmm_find_testlist.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_tmm_find_testlist_02)
destroy(this.cb_close)
destroy(this.dw_tmm_find_testlist_01)
end on

event open;dw_tmm_find_testlist_01.settransobject(sqlca)
dw_tmm_find_testlist_02.settransobject(sqlca)

dw_tmm_find_testlist_01.retrieve()
dw_tmm_find_testlist_02.retrieve()

end event

type st_2 from statictext within w_tmm_find_testlist
integer x = 1527
integer y = 36
integer width = 599
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16777215
long backcolor = 128
string text = "시험방식 : @@"
alignment alignment = center!
boolean border = true
long bordercolor = 15780518
borderstyle borderstyle = StyleShadowBox!
boolean focusrectangle = false
end type

type st_1 from statictext within w_tmm_find_testlist
integer x = 37
integer y = 36
integer width = 599
integer height = 84
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16777215
long backcolor = 128
string text = "시험방식 : @"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = StyleShadowBox!
boolean focusrectangle = false
end type

type dw_tmm_find_testlist_02 from datawindow within w_tmm_find_testlist
integer x = 1541
integer y = 164
integer width = 1509
integer height = 1308
integer taborder = 70
string dataobject = "d_tmm_find_testlist_02"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_tmm_find_testlist
integer x = 2651
integer y = 28
integer width = 389
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "선택저장"
end type

event clicked;string ls_rtnparm
long ll_rowcnt, ll_cnt

ll_rowcnt = dw_tmm_find_testlist_01.rowcount()
for ll_cnt = 1 to ll_rowcnt
	if dw_tmm_find_testlist_01.getitemnumber(ll_cnt,"chk_code") = 1 then
		ls_rtnparm = ls_rtnparm + dw_tmm_find_testlist_01.getitemstring(ll_cnt,"codename") + " ,"
	end if
next

ll_rowcnt = dw_tmm_find_testlist_02.rowcount()
for ll_cnt = 1 to ll_rowcnt
	if dw_tmm_find_testlist_02.getitemnumber(ll_cnt,"chk_code") = 1 then
		ls_rtnparm = ls_rtnparm + dw_tmm_find_testlist_02.getitemstring(ll_cnt,"codename") + " ,"
	end if
next

closewithreturn(w_tmm_find_testlist,ls_rtnparm)
end event

type dw_tmm_find_testlist_01 from datawindow within w_tmm_find_testlist
event ue_key pbm_keydown
integer x = 23
integer y = 164
integer width = 1499
integer height = 1308
integer taborder = 60
string dataobject = "d_tmm_find_testlist_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

