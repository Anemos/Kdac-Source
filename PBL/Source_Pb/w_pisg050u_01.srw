$PBExportHeader$w_pisg050u_01.srw
$PBExportComments$tag용 바코드라벨 입력용 윈도우
forward
global type w_pisg050u_01 from window
end type
type em_label_tag from editmask within w_pisg050u_01
end type
type st_1 from statictext within w_pisg050u_01
end type
end forward

global type w_pisg050u_01 from window
integer width = 1426
integer height = 416
boolean titlebar = true
string title = "TAG용 라벨입력용"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
string icon = "AppIcon!"
boolean center = true
em_label_tag em_label_tag
st_1 st_1
end type
global w_pisg050u_01 w_pisg050u_01

on w_pisg050u_01.create
this.em_label_tag=create em_label_tag
this.st_1=create st_1
this.Control[]={this.em_label_tag,&
this.st_1}
end on

on w_pisg050u_01.destroy
destroy(this.em_label_tag)
destroy(this.st_1)
end on

type em_label_tag from editmask within w_pisg050u_01
integer x = 110
integer y = 152
integer width = 1070
integer height = 116
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 65535
long backcolor = 0
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "aaaaaaaaaaaa"
end type

type st_1 from statictext within w_pisg050u_01
integer x = 32
integer y = 32
integer width = 1317
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16777215
long backcolor = 8421376
string text = "TAG용 바코드라벨을 스켄 하십시요!"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = StyleShadowBox!
boolean focusrectangle = false
end type

