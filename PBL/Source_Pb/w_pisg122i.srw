$PBExportHeader$w_pisg122i.srw
$PBExportComments$현장관리_회수간판 회수 완료
forward
global type w_pisg122i from window
end type
type st_3 from statictext within w_pisg122i
end type
type st_2 from statictext within w_pisg122i
end type
type st_1 from statictext within w_pisg122i
end type
end forward

global type w_pisg122i from window
integer x = 302
integer y = 760
integer width = 2834
integer height = 748
boolean titlebar = true
string title = "회수 간판 완료"
windowtype windowtype = response!
long backcolor = 79219928
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_pisg122i w_pisg122i

type variables
INTEGER	ii_time_count
end variables

on w_pisg122i.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.st_3,&
this.st_2,&
this.st_1}
end on

on w_pisg122i.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

event open;f_centerwindow(this)

ii_time_count = 0

timer(0.5)

end event

event timer;ii_time_count ++

IF MOD(ii_time_count, 2) = 1 THEN
	st_2.text = ''
	st_3.text = ''
ELSE
	st_2.text = '간판회수완료'
	st_3.text = '간판회수를 완료하였습니다.'
END IF

IF ii_time_count = 10 THEN

	w_pisg120i.em_kb_no.text	= ''
	w_pisg120i.em_kb_no.setfocus()

	CLOSE(THIS)
END IF

end event

type st_3 from statictext within w_pisg122i
integer x = 169
integer y = 340
integer width = 2482
integer height = 196
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "간판회수를 완료하였습니다."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisg122i
integer x = 741
integer y = 104
integer width = 1339
integer height = 164
integer textsize = -30
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "돋움"
long textcolor = 65535
long backcolor = 0
string text = "간판회수완료"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisg122i
integer x = 55
integer y = 56
integer width = 2711
integer height = 564
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 0
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

