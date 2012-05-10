$PBExportHeader$w_dw_print.srw
$PBExportComments$dw를 그대로 출력
forward
global type w_dw_print from window
end type
type ddlb_1 from dropdownlistbox within w_dw_print
end type
type cb_printer from commandbutton within w_dw_print
end type
type st_printer from statictext within w_dw_print
end type
type rb_2 from radiobutton within w_dw_print
end type
type rb_1 from radiobutton within w_dw_print
end type
type ddlb_zoom from dropdownlistbox within w_dw_print
end type
type pb_last from picturebutton within w_dw_print
end type
type pb_next from picturebutton within w_dw_print
end type
type pb_prior from picturebutton within w_dw_print
end type
type pb_first from picturebutton within w_dw_print
end type
type cb_prt2 from commandbutton within w_dw_print
end type
type cb_close from commandbutton within w_dw_print
end type
type gb_1 from groupbox within w_dw_print
end type
end forward

global type w_dw_print from window
integer x = 1074
integer y = 484
integer width = 1536
integer height = 496
boolean titlebar = true
string title = "프린트 콘트롤"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 79741120
ddlb_1 ddlb_1
cb_printer cb_printer
st_printer st_printer
rb_2 rb_2
rb_1 rb_1
ddlb_zoom ddlb_zoom
pb_last pb_last
pb_next pb_next
pb_prior pb_prior
pb_first pb_first
cb_prt2 cb_prt2
cb_close cb_close
gb_1 gb_1
end type
global w_dw_print w_dw_print

type variables
datawindow	dw_1
end variables

event open;string		ls_max_row,ls_size,ls_orient
int			i

f_win_center(this)

dw_1 = Message.PowerObjectParm

st_printer.text = dw_1.Object.DataWindow.Printer

dw_1.SetRedraw(False)
dw_1.SelectRow(0,False)
//dw_1.objectdf_select_row(false)
dw_1.Modify('DataWindow.Print.Preview = Yes')  // set preview mode
dw_1.Modify('datawindow.Print.Preview.Rulers = Yes')
ls_size = dw_1.Describe("DataWindow.Print.Paper.Size")
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
ls_orient = dw_1.Describe('datawindow.Print.Orientation')
If ls_orient = '1' Then
	rb_1.checked = true
Else
	rb_2.checked = true
End if

//ls_max_row = string(dw_1.rowcount())
//if dw_1.Describe("evaluate('pagecount()'," + ls_max_row + ")") = '1' then // if last page is '1'
//	pb_next.Enabled = FALSE
//	pb_last.Enabled = FALSE
//	pb_first.Enabled = FALSE 
//	pb_prior.Enabled = FALSE
//end if

dw_1.SetRedraw(True)

end event

on w_dw_print.create
this.ddlb_1=create ddlb_1
this.cb_printer=create cb_printer
this.st_printer=create st_printer
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_zoom=create ddlb_zoom
this.pb_last=create pb_last
this.pb_next=create pb_next
this.pb_prior=create pb_prior
this.pb_first=create pb_first
this.cb_prt2=create cb_prt2
this.cb_close=create cb_close
this.gb_1=create gb_1
this.Control[]={this.ddlb_1,&
this.cb_printer,&
this.st_printer,&
this.rb_2,&
this.rb_1,&
this.ddlb_zoom,&
this.pb_last,&
this.pb_next,&
this.pb_prior,&
this.pb_first,&
this.cb_prt2,&
this.cb_close,&
this.gb_1}
end on

on w_dw_print.destroy
destroy(this.ddlb_1)
destroy(this.cb_printer)
destroy(this.st_printer)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_zoom)
destroy(this.pb_last)
destroy(this.pb_next)
destroy(this.pb_prior)
destroy(this.pb_first)
destroy(this.cb_prt2)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event close;dw_1.Modify('DataWindow.Print.Preview = No')  // set preview mode
dw_1.Modify('datawindow.Print.Preview.Rulers = No')
end event

type ddlb_1 from dropdownlistbox within w_dw_print
integer x = 87
integer y = 60
integer width = 585
integer height = 464
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Default","Letter 8.5x11","Letter Small 8.5x11","Legal 8.5x14","A3 297x420mm","A4 210x297mm","A5 148x210mm","B4 250x354mm","B5 182x257mm"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Choose Case index
	Case 1
		dw_1.Modify("DataWindow.Print.Paper.Size='0'")
	Case 2
		dw_1.Modify("DataWindow.Print.Paper.Size='1'")
	Case 3
		dw_1.Modify("DataWindow.Print.Paper.Size='2'")
	Case 4
		dw_1.Modify("DataWindow.Print.Paper.Size='5'")
	Case 5
		dw_1.Modify("DataWindow.Print.Paper.Size='8'")
	Case 6
		dw_1.Modify("DataWindow.Print.Paper.Size='9'")
	Case 7
		dw_1.Modify("DataWindow.Print.Paper.Size='11'")
	Case 8
		dw_1.Modify("DataWindow.Print.Paper.Size='12'")
	Case 9
		dw_1.Modify("DataWindow.Print.Paper.Size='13'")
End Choose		

end event

type cb_printer from commandbutton within w_dw_print
event clicked pbm_bnclicked
integer x = 942
integer y = 48
integer width = 247
integer height = 100
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "설정"
end type

event clicked;string ls_orient,ls_paper
long li_cur
str_print lstr_print

//set instance variable lstr_print(structure)
lstr_print.dw_prt = dw_1 	// assign DW
lstr_print.s_success = '0' // initialize success flag
lstr_print.s_document = 'datawindow' // assign window title to document name

// open w_print and send message to w_print
openwithparm(w_set_print,lstr_print)

st_printer.text = dw_1.Object.DataWindow.Printer
//출력방향 초기화
ls_orient = dw_1.Describe('datawindow.Print.Orientation')
If ls_orient = '1' Then
	rb_1.checked = true
Else
	rb_2.checked = true
End if

ls_paper = dw_1.Describe("DataWindow.Print.Paper.Size")
Choose Case ls_paper
	Case '0'
		ddlb_1.selectitem(1)
	Case '1'
		ddlb_1.selectitem(2)
	Case '2'
		ddlb_1.selectitem(3)
	Case '5'
		ddlb_1.selectitem(4)
	Case '8'
		ddlb_1.selectitem(5)
	Case '9'
		ddlb_1.selectitem(6)
	Case '11'
		ddlb_1.selectitem(7)
	Case '12'
		ddlb_1.selectitem(8)
	Case '13'
		ddlb_1.selectitem(9)
End Choose		



end event

type st_printer from statictext within w_dw_print
integer x = 87
integer y = 160
integer width = 1353
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type rb_2 from radiobutton within w_dw_print
event clicked pbm_bnclicked
integer x = 695
integer y = 268
integer width = 229
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 8388608
long backcolor = 80263328
string text = "세로"
boolean checked = true
end type

event clicked;dw_1.Modify('datawindow.Print.Orientation = 2')
end event

type rb_1 from radiobutton within w_dw_print
event clicked pbm_bnclicked
integer x = 430
integer y = 268
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long textcolor = 8388608
long backcolor = 80263328
string text = "가로"
end type

event clicked;dw_1.Modify('datawindow.Print.Orientation = 1')
end event

type ddlb_zoom from dropdownlistbox within w_dw_print
event modified pbm_cbnmodified
event selectionchanged pbm_cbnselchange
integer x = 87
integer y = 256
integer width = 279
integer height = 468
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
long backcolor = 16777215
string text = "100"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"50","60","70","80","90","100","110","120","130","140","150","160","170","180","190","200"}
borderstyle borderstyle = stylelowered!
end type

event modified;dw_1.Modify("datawindow.zoom = " + this.text );
end event

event selectionchanged;dw_1.Modify("datawindow.zoom = " + this.text );
end event

type pb_last from picturebutton within w_dw_print
event clicked pbm_bnclicked
integer x = 1321
integer y = 252
integer width = 114
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\pic\Last.bmp"
string disabledname = ".\bmp\arrowlast_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_1.scrolltorow(999999)
end event

type pb_next from picturebutton within w_dw_print
event clicked pbm_bnclicked
integer x = 1207
integer y = 252
integer width = 114
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\pic\Next.bmp"
string disabledname = ".\bmp\arrowri_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_1.scrollnextpage()
end event

type pb_prior from picturebutton within w_dw_print
event clicked pbm_bnclicked
integer x = 1093
integer y = 252
integer width = 114
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\pic\Prev.bmp"
string disabledname = ".\bmp\arrowle_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_1.scrollpriorpage()
end event

type pb_first from picturebutton within w_dw_print
event clicked pbm_bnclicked
integer x = 978
integer y = 252
integer width = 114
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\pic\First.bmp"
string disabledname = ".\\bmp\arrowfirst_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_1.scrolltorow(1)

end event

type cb_prt2 from commandbutton within w_dw_print
event clicked pbm_bnclicked
integer x = 695
integer y = 48
integer width = 247
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "인쇄"
end type

event clicked;// default 1 Copies
dw_1.object.datawindow.print.copies = '1'   

// Orientation
if rb_1.checked then
	dw_1.object.datawindow.print.orientation = 1
end if
if rb_2.checked then
	dw_1.object.datawindow.print.orientation = 2
end if	

// Page Range
dw_1.object.datawindow.print.page.range = ''	  // 전체

dw_1.object.datawindow.print.documentname = 'Datawindow'	  // 제목
//프린트 후 상태를 Return 
dw_1.print()
closewithreturn(parent,'1')
end event

type cb_close from commandbutton within w_dw_print
event clicked pbm_bnclicked
integer x = 1189
integer y = 48
integer width = 247
integer height = 100
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "돋움체"
string text = "닫기"
end type

event clicked;dw_1.Modify("datawindow.zoom = 100");
close(Parent)
end event

type gb_1 from groupbox within w_dw_print
integer x = 37
integer y = 8
integer width = 1449
integer height = 376
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 12632256
long backcolor = 80263328
borderstyle borderstyle = styleraised!
end type

