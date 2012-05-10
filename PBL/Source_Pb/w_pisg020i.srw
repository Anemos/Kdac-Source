$PBExportHeader$w_pisg020i.srw
$PBExportComments$현장관리_라인 정보 조회
forward
global type w_pisg020i from window
end type
type st_1 from statictext within w_pisg020i
end type
type p_3 from picture within w_pisg020i
end type
type p_2 from picture within w_pisg020i
end type
type p_1 from picture within w_pisg020i
end type
type st_2 from statictext within w_pisg020i
end type
type st_area_name from statictext within w_pisg020i
end type
type st_4 from statictext within w_pisg020i
end type
type st_division_name from statictext within w_pisg020i
end type
type st_8 from statictext within w_pisg020i
end type
type st_computer_name from statictext within w_pisg020i
end type
type st_10 from statictext within w_pisg020i
end type
type p_7 from picture within w_pisg020i
end type
end forward

global type w_pisg020i from window
integer width = 3625
integer height = 1952
windowtype windowtype = child!
long backcolor = 15780518
st_1 st_1
p_3 p_3
p_2 p_2
p_1 p_1
st_2 st_2
st_area_name st_area_name
st_4 st_4
st_division_name st_division_name
st_8 st_8
st_computer_name st_computer_name
st_10 st_10
p_7 p_7
end type
global w_pisg020i w_pisg020i

type prototypes

end prototypes

type variables


end variables

on w_pisg020i.create
this.st_1=create st_1
this.p_3=create p_3
this.p_2=create p_2
this.p_1=create p_1
this.st_2=create st_2
this.st_area_name=create st_area_name
this.st_4=create st_4
this.st_division_name=create st_division_name
this.st_8=create st_8
this.st_computer_name=create st_computer_name
this.st_10=create st_10
this.p_7=create p_7
this.Control[]={this.st_1,&
this.p_3,&
this.p_2,&
this.p_1,&
this.st_2,&
this.st_area_name,&
this.st_4,&
this.st_division_name,&
this.st_8,&
this.st_computer_name,&
this.st_10,&
this.p_7}
end on

on w_pisg020i.destroy
destroy(this.st_1)
destroy(this.p_3)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.st_2)
destroy(this.st_area_name)
destroy(this.st_4)
destroy(this.st_division_name)
destroy(this.st_8)
destroy(this.st_computer_name)
destroy(this.st_10)
destroy(this.p_7)
end on

event open;/*######################################################################
#####		지역, 공장, 단말기명을 보여준다.									 #####
######################################################################*/

// 지역, 공장, 단말기 명을 표시.
st_area_name.text			= gs_area_name
st_division_name.text	= gs_division_name
st_computer_name.text	= ProfileString(gs_inifile, "Com_Info", "Comcode", "")

//open(w_pisqchk)

end event

type st_1 from statictext within w_pisg020i
integer x = 1179
integer y = 44
integer width = 512
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 255
string text = "파워빌더 V9.3"
alignment alignment = center!
boolean focusrectangle = false
end type

type p_3 from picture within w_pisg020i
integer x = 2126
integer y = 1844
integer width = 59
integer height = 52
string picturename = "bmp\bullet.gif"
boolean focusrectangle = false
end type

type p_2 from picture within w_pisg020i
integer x = 1024
integer y = 1844
integer width = 59
integer height = 52
string picturename = "bmp\bullet.gif"
boolean focusrectangle = false
end type

type p_1 from picture within w_pisg020i
integer x = 155
integer y = 1844
integer width = 59
integer height = 52
string picturename = "bmp\bullet.gif"
boolean focusrectangle = false
end type

type st_2 from statictext within w_pisg020i
integer x = 242
integer y = 1816
integer width = 297
integer height = 116
integer textsize = -17
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 22099723
long backcolor = 31381463
boolean enabled = false
string text = "지역 :"
boolean focusrectangle = false
end type

type st_area_name from statictext within w_pisg020i
integer x = 539
integer y = 1816
integer width = 343
integer height = 116
integer textsize = -17
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 128
long backcolor = 31381463
boolean enabled = false
string text = "대구"
long bordercolor = 1090519039
boolean focusrectangle = false
end type

type st_4 from statictext within w_pisg020i
integer x = 1115
integer y = 1816
integer width = 297
integer height = 116
integer textsize = -17
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 22099723
long backcolor = 31381463
boolean enabled = false
string text = "공장 :"
boolean focusrectangle = false
end type

type st_division_name from statictext within w_pisg020i
integer x = 1422
integer y = 1816
integer width = 567
integer height = 116
integer textsize = -17
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 128
long backcolor = 31381463
boolean enabled = false
string text = "전장"
boolean focusrectangle = false
end type

type st_8 from statictext within w_pisg020i
integer x = 2226
integer y = 1816
integer width = 521
integer height = 116
integer textsize = -17
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 22099723
long backcolor = 31381463
boolean enabled = false
string text = "단말기명 :"
boolean focusrectangle = false
end type

type st_computer_name from statictext within w_pisg020i
integer x = 2752
integer y = 1816
integer width = 786
integer height = 116
integer textsize = -17
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Century Gothic"
long textcolor = 8388736
long backcolor = 31381463
boolean enabled = false
string text = "DAA01"
boolean focusrectangle = false
end type

type st_10 from statictext within w_pisg020i
integer y = 1764
integer width = 3611
integer height = 212
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 31381463
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type p_7 from picture within w_pisg020i
integer width = 3611
integer height = 1760
string picturename = "bmp\main.jpg"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

