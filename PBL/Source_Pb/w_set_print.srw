$PBExportHeader$w_set_print.srw
$PBExportComments$출력 설정 윈도
forward
global type w_set_print from window
end type
type ddlb_1 from dropdownlistbox within w_set_print
end type
type st_4 from statictext within w_set_print
end type
type cb_cancel from commandbutton within w_set_print
end type
type cb_print from commandbutton within w_set_print
end type
type rb_5 from radiobutton within w_set_print
end type
type rb_4 from radiobutton within w_set_print
end type
type em_copies from editmask within w_set_print
end type
type st_3 from statictext within w_set_print
end type
type st_2 from statictext within w_set_print
end type
type st_1 from statictext within w_set_print
end type
type sle_1 from singlelineedit within w_set_print
end type
type rb_3 from radiobutton within w_set_print
end type
type rb_2 from radiobutton within w_set_print
end type
type rb_1 from radiobutton within w_set_print
end type
type cb_printer from commandbutton within w_set_print
end type
type st_printer from statictext within w_set_print
end type
type gb_3 from groupbox within w_set_print
end type
type gb_2 from groupbox within w_set_print
end type
type gb_1 from groupbox within w_set_print
end type
end forward

global type w_set_print from window
integer x = 1010
integer y = 496
integer width = 1824
integer height = 992
boolean titlebar = true
string title = "인쇄"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "Exclamation!"
ddlb_1 ddlb_1
st_4 st_4
cb_cancel cb_cancel
cb_print cb_print
rb_5 rb_5
rb_4 rb_4
em_copies em_copies
st_3 st_3
st_2 st_2
st_1 st_1
sle_1 sle_1
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
cb_printer cb_printer
st_printer st_printer
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_set_print w_set_print

type variables
datawindow idw_prt
str_print lstr_print
end variables

on w_set_print.create
this.ddlb_1=create ddlb_1
this.st_4=create st_4
this.cb_cancel=create cb_cancel
this.cb_print=create cb_print
this.rb_5=create rb_5
this.rb_4=create rb_4
this.em_copies=create em_copies
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_1=create sle_1
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_printer=create cb_printer
this.st_printer=create st_printer
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.ddlb_1,&
this.st_4,&
this.cb_cancel,&
this.cb_print,&
this.rb_5,&
this.rb_4,&
this.em_copies,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_1,&
this.rb_3,&
this.rb_2,&
this.rb_1,&
this.cb_printer,&
this.st_printer,&
this.gb_3,&
this.gb_2,&
this.gb_1}
end on

on w_set_print.destroy
destroy(this.ddlb_1)
destroy(this.st_4)
destroy(this.cb_cancel)
destroy(this.cb_print)
destroy(this.rb_5)
destroy(this.rb_4)
destroy(this.em_copies)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_printer)
destroy(this.st_printer)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;string ls_orient,ls_size

f_win_center(This)
lstr_print = message.powerobjectparm
idw_prt = lstr_print.dw_prt

st_printer.text = idw_prt.Object.DataWindow.Printer

ls_size = idw_prt.Describe("DataWindow.Print.Paper.Size")
//용지선택을 Default
Choose Case ls_size
	Case '0'
		ddlb_1.SelectItem(1)
	Case '1'
		ddlb_1.SelectItem(2)
	Case '2'
		ddlb_1.SelectItem(3)
	Case '5'
		ddlb_1.SelectItem(4)
	Case '8'
		ddlb_1.SelectItem(5)
	Case '9'
		ddlb_1.SelectItem(6)
	Case '11'
		ddlb_1.SelectItem(7)
	Case '12'
		ddlb_1.SelectItem(8)
	Case '13'
		ddlb_1.SelectItem(9)
End Choose
//출력방향 초기화
ls_orient = idw_prt.Describe('datawindow.Print.Orientation')
If ls_orient = '1' Then
	rb_5.checked = true
Else
	rb_4.checked = true
End if


end event

type ddlb_1 from dropdownlistbox within w_set_print
integer x = 1166
integer y = 540
integer width = 622
integer height = 360
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Default","Letter 8.5x11","Letter Small 8.5x11","Legal 8.5x14","A3 297x420mm","A4 210x297mm","A5 148x210mm","B4 250x354mm","B5 182x257mm"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Choose Case index
	Case 1
		idw_prt.Modify("DataWindow.Print.Paper.Size='0'")
	Case 2
		idw_prt.Modify("DataWindow.Print.Paper.Size='1'")
	Case 3
		idw_prt.Modify("DataWindow.Print.Paper.Size='2'")
	Case 4
		idw_prt.Modify("DataWindow.Print.Paper.Size='5'")
	Case 5
		idw_prt.Modify("DataWindow.Print.Paper.Size='8'")
	Case 6
		idw_prt.Modify("DataWindow.Print.Paper.Size='9'")
	Case 7
		idw_prt.Modify("DataWindow.Print.Paper.Size='11'")
	Case 8
		idw_prt.Modify("DataWindow.Print.Paper.Size='12'")
	Case 9
		idw_prt.Modify("DataWindow.Print.Paper.Size='13'")
End Choose		

end event

type st_4 from statictext within w_set_print
integer x = 1134
integer y = 480
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
boolean enabled = false
string text = "용지선택"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_set_print
integer x = 1463
integer y = 784
integer width = 329
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "닫기(&C)"
boolean cancel = true
end type

event clicked;string ls_firstrow,ls_range

//idw_prt.object.datawindow.printer = trim(st_printer.text)   // Printer
idw_prt.object.datawindow.print.copies = trim(em_copies.text)   // Copies

// Orientation
if rb_4.checked then
	idw_prt.object.datawindow.print.orientation = 2
end if
if rb_5.checked then
	idw_prt.object.datawindow.print.orientation = 1
end if	

// Page Range
if rb_1.checked then  
	idw_prt.object.datawindow.print.page.range = ''	  // 전체
elseif rb_2.checked then
	ls_firstrow = idw_prt.object.datawindow.firstrowonpage
	ls_range = idw_prt.describe("evaluate('page()',"+ls_firstrow+")")
	idw_prt.object.datawindow.print.page.range = ls_range	  // 현재쪽
else
	idw_prt.object.datawindow.print.page.range = trim(sle_1.text)	  // 일부분
end if

lstr_print.s_success = '0'     // Print flag
closewithreturn(parent,lstr_print)
end event

type cb_print from commandbutton within w_set_print
integer x = 1134
integer y = 784
integer width = 329
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "출력(&O)"
boolean default = true
end type

event clicked;string ls_firstrow, ls_range

parent.setredraw(false)

//idw_prt.object.datawindow.printer = trim(st_printer.text)   // Printer
idw_prt.object.datawindow.print.copies = trim(em_copies.text)   // Copies

// Orientation
if rb_4.checked then
	idw_prt.object.datawindow.print.orientation = 2
end if
if rb_5.checked then
	idw_prt.object.datawindow.print.orientation = 1
end if	

// Page Range
if rb_1.checked then  
	idw_prt.object.datawindow.print.page.range = ''	  // 전체
elseif rb_2.checked then
	ls_firstrow = idw_prt.object.datawindow.firstrowonpage
	ls_range = idw_prt.describe("evaluate('page()',"+ls_firstrow+")")
	idw_prt.object.datawindow.print.page.range = ls_range	  // 현재쪽
else
	idw_prt.object.datawindow.print.page.range = trim(sle_1.text)	  // 일부분
end if

idw_prt.object.datawindow.print.documentname = lstr_print.s_document	  // 현재쪽
idw_prt.print()
lstr_print.s_success = '1'
closewithreturn(parent,lstr_print)
end event

type rb_5 from radiobutton within w_set_print
integer x = 1481
integer y = 332
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
string text = "가로"
end type

type rb_4 from radiobutton within w_set_print
integer x = 1234
integer y = 332
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
string text = "세로"
end type

type em_copies from editmask within w_set_print
integer x = 1435
integer y = 664
integer width = 357
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "###"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "1~~100"
end type

event constructor;this.text = '1'
end event

type st_3 from statictext within w_set_print
integer x = 1134
integer y = 688
integer width = 302
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
boolean enabled = false
string text = "인쇄매수"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_set_print
integer x = 347
integer y = 764
integer width = 480
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
boolean enabled = false
string text = "( 1, 3, 5-8, 10 )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_set_print
integer x = 178
integer y = 688
integer width = 882
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
boolean enabled = false
string text = "쪽번호 또는 범위를 입력하세요. "
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_set_print
integer x = 366
integer y = 516
integer width = 489
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;rb_3.checked = true
end event

type rb_3 from radiobutton within w_set_print
integer x = 114
integer y = 528
integer width = 384
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
string text = "일부"
end type

type rb_2 from radiobutton within w_set_print
integer x = 114
integer y = 436
integer width = 288
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
string text = "현재쪽"
end type

type rb_1 from radiobutton within w_set_print
integer x = 114
integer y = 344
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
string text = "전체"
boolean checked = true
end type

type cb_printer from commandbutton within w_set_print
integer x = 1440
integer y = 104
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "프린터..."
end type

event clicked;if printsetup()=1 then st_printer.text = idw_prt.Object.DataWindow.Printer
end event

type st_printer from statictext within w_set_print
integer x = 82
integer y = 112
integer width = 1490
integer height = 96
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type gb_3 from groupbox within w_set_print
integer x = 1166
integer y = 264
integer width = 622
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
string text = "출력방향"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_set_print
integer x = 41
integer y = 264
integer width = 1070
integer height = 608
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
string text = "인쇄범위"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_set_print
integer x = 41
integer y = 36
integer width = 1746
integer height = 200
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
string text = "프린터"
borderstyle borderstyle = styleraised!
end type

