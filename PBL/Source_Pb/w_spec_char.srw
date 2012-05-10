$PBExportHeader$w_spec_char.srw
$PBExportComments$특수문자 검색
forward
global type w_spec_char from window
end type
type cb_2 from commandbutton within w_spec_char
end type
type st_7 from statictext within w_spec_char
end type
type st_6 from statictext within w_spec_char
end type
type st_3 from statictext within w_spec_char
end type
type st_1 from statictext within w_spec_char
end type
type cb_1 from commandbutton within w_spec_char
end type
type sle_1 from singlelineedit within w_spec_char
end type
type dw_1 from datawindow within w_spec_char
end type
type ddlb_1 from dropdownlistbox within w_spec_char
end type
type pb_exit from picturebutton within w_spec_char
end type
type gb_1 from groupbox within w_spec_char
end type
end forward

global type w_spec_char from window
integer x = 887
integer y = 464
integer width = 1915
integer height = 1668
boolean titlebar = true
string title = "특수문자 입력"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "Rectangle!"
cb_2 cb_2
st_7 st_7
st_6 st_6
st_3 st_3
st_1 st_1
cb_1 cb_1
sle_1 sle_1
dw_1 dw_1
ddlb_1 ddlb_1
pb_exit pb_exit
gb_1 gb_1
end type
global w_spec_char w_spec_char

type variables
int Hi , ddlb_index

end variables

on w_spec_char.create
this.cb_2=create cb_2
this.st_7=create st_7
this.st_6=create st_6
this.st_3=create st_3
this.st_1=create st_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.dw_1=create dw_1
this.ddlb_1=create ddlb_1
this.pb_exit=create pb_exit
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.st_7,&
this.st_6,&
this.st_3,&
this.st_1,&
this.cb_1,&
this.sle_1,&
this.dw_1,&
this.ddlb_1,&
this.pb_exit,&
this.gb_1}
end on

on w_spec_char.destroy
destroy(this.cb_2)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.dw_1)
destroy(this.ddlb_1)
destroy(this.pb_exit)
destroy(this.gb_1)
end on

event open;//this.title = ""

long Low

ddlb_1.additem("기호문자                               161")
ddlb_1.additem("도형문자                               162")
ddlb_1.additem("전각영문자                             163")
ddlb_1.additem("한글자모                               164")
ddlb_1.additem("그리스문자                             165")
ddlb_1.additem("기호문자                               166")
ddlb_1.additem("도량형                                 167")
ddlb_1.additem("원문자                                 168")
ddlb_1.additem("발음기호,괄호문자,첨자                 169")
ddlb_1.additem("히라가나                               170")
ddlb_1.additem("가따가나                               171")
ddlb_1.additem("러시아어                               172")

ddlb_1.selectitem(1)
dw_1.reset()
dw_1.insertrow(0)

Hi = integer(right(ddlb_1.text , 3))

for Low = 161  to 254
	 dw_1.setitem(1, Low - 160, char(Hi) + char(Low))
next

// 161  "~ha1" 기호문자
// 162  "~ha2" 도형문자
// 163  "~ha3" 전각영문자
// 164  "~ha4" 한글자모
// 165  "~ha5" 그리스문자
// 166  "~ha6" 기호문자
// 167  "~ha7" 도량형
// 168  "~ha8" 원문자
// 169  "~ha9" 발음기호
// 170  "~haa" 히라가나
// 171  "~hab" 가따가나
// 172  "~hac" 러시아어

end event

type cb_2 from commandbutton within w_spec_char
integer x = 1170
integer y = 44
integer width = 320
integer height = 116
integer taborder = 50
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "복사"
end type

event clicked;clipboard(sle_1.text)
close(parent)
end event

type st_7 from statictext within w_spec_char
integer x = 535
integer y = 1460
integer width = 1298
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "로 원하는 위치에 붙여넣기를 하세요."
boolean focusrectangle = false
end type

type st_6 from statictext within w_spec_char
integer x = 265
integer y = 1460
integer width = 297
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = " CTRL-V"
boolean focusrectangle = false
end type

type st_3 from statictext within w_spec_char
integer x = 55
integer y = 1460
integer width = 256
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "누른후"
boolean focusrectangle = false
end type

type st_1 from statictext within w_spec_char
integer x = 55
integer y = 1376
integer width = 1810
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16711680
long backcolor = 12632256
boolean enabled = false
string text = "특수문자를 마우스로 (연속)선택하신후 ~"복사~"버튼을"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_spec_char
boolean visible = false
integer x = 745
integer y = 128
integer width = 329
integer height = 84
integer taborder = 30
integer textsize = -12
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;//integer li_FileNum
//
//li_FileNum = FileOpen("C:\dw.txt",  StreamMode!, Write!, LockWrite!, Replace!)

dw_1.SaveAs("c:\dw" + string(ddlb_index) + ".txt", Text!, FALSE)

//FileClose(li_FileNum)
end event

type sle_1 from singlelineedit within w_spec_char
integer x = 91
integer y = 1184
integer width = 1719
integer height = 144
integer taborder = 10
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12639424
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_spec_char
integer x = 64
integer y = 212
integer width = 1778
integer height = 884
integer taborder = 40
string dataobject = "d_spec_char"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;string col_nm
long i
col_nm = trim(dw_1.GetObjectAtPointer())
i = len(col_nm)
if i > 0 then
//   messagebox("", col_nm)
   sle_1.text = sle_1.text + trim(dw_1.getitemstring(1,col_nm))
end if


end event

type ddlb_1 from dropdownlistbox within w_spec_char
integer x = 64
integer y = 44
integer width = 1074
integer height = 1360
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
end type

event selectionchanged;string tmp
int Low

ddlb_index = index

dw_1.reset()
dw_1.insertrow(0)

Hi = integer(right(ddlb_1.text , 3))

for Low = 161  to 254
    tmp = char(Hi) + char(Low)
	 dw_1.setitem(1, Low - 160, tmp)
next

end event

type pb_exit from picturebutton within w_spec_char
integer x = 1518
integer y = 44
integer width = 320
integer height = 116
integer taborder = 70
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "취소"
string picturename = "c:\bmp\pb_exit.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;close(parent)
end event

type gb_1 from groupbox within w_spec_char
integer x = 59
integer y = 1116
integer width = 1783
integer height = 244
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "선택된 특수문자"
end type

