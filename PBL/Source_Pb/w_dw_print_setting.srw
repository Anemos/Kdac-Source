$PBExportHeader$w_dw_print_setting.srw
$PBExportComments$print setting response-window
forward
global type w_dw_print_setting from window
end type
type cb_2 from commandbutton within w_dw_print_setting
end type
type sle_printer from singlelineedit within w_dw_print_setting
end type
type st_4_1 from statictext within w_dw_print_setting
end type
type em_1 from editmask within w_dw_print_setting
end type
type ddlb_range from dropdownlistbox within w_dw_print_setting
end type
type st_4 from statictext within w_dw_print_setting
end type
type cb_printer from commandbutton within w_dw_print_setting
end type
type cb_cancel from commandbutton within w_dw_print_setting
end type
type cbx_collate from checkbox within w_dw_print_setting
end type
type st_3 from statictext within w_dw_print_setting
end type
type sle_page_range from singlelineedit within w_dw_print_setting
end type
type rb_pages from radiobutton within w_dw_print_setting
end type
type rb_current_page from radiobutton within w_dw_print_setting
end type
type rb_all from radiobutton within w_dw_print_setting
end type
type st_2 from statictext within w_dw_print_setting
end type
type st_1 from statictext within w_dw_print_setting
end type
type cb_ok from commandbutton within w_dw_print_setting
end type
type gb_1 from groupbox within w_dw_print_setting
end type
type gb_4 from groupbox within w_dw_print_setting
end type
type gb_3 from groupbox within w_dw_print_setting
end type
type gb_2 from groupbox within w_dw_print_setting
end type
end forward

global type w_dw_print_setting from window
integer x = 663
integer y = 472
integer width = 2025
integer height = 1324
boolean titlebar = true
string title = "ÀÎ   ¼â"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
cb_2 cb_2
sle_printer sle_printer
st_4_1 st_4_1
em_1 em_1
ddlb_range ddlb_range
st_4 st_4
cb_printer cb_printer
cb_cancel cb_cancel
cbx_collate cbx_collate
st_3 st_3
sle_page_range sle_page_range
rb_pages rb_pages
rb_current_page rb_current_page
rb_all rb_all
st_2 st_2
st_1 st_1
cb_ok cb_ok
gb_1 gb_1
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
end type
global w_dw_print_setting w_dw_print_setting

type variables
string is_page_range
datawindow idw_dw
end variables

forward prototypes
private subroutine wf_page_range (radiobutton who)
end prototypes

private subroutine wf_page_range (radiobutton who);CHOOSE CASE who
CASE rb_all
	 sle_page_range.text = ''
    sle_page_range.enabled = false
	 is_page_range = 'a'
CASE rb_current_page
	 sle_page_range.text = ''
	 sle_page_range.enabled = false
	 is_page_range = 'c'
CASE rb_pages		
 	 sle_page_range.enabled = true
	 is_page_range = 'p'
	 sle_page_range.SetFocus()
END CHOOSE
end subroutine

event open;// openwitparm ===> a datawindow control : Openwithparm(W_dw_print_setting,dw_name)
String  ls_printer, ls_printer1
Integer li_length

idw_dw = message.powerobjectparm

ls_printer = idw_dw.Describe("datawindow.printer")
li_length  = Len(ls_printer)

ls_printer1 = Mid(ls_printer, 1, li_length - 1)

sle_printer.text = ls_printer1

is_page_range = 'a'

em_1.text = '1'

end event

on w_dw_print_setting.create
this.cb_2=create cb_2
this.sle_printer=create sle_printer
this.st_4_1=create st_4_1
this.em_1=create em_1
this.ddlb_range=create ddlb_range
this.st_4=create st_4
this.cb_printer=create cb_printer
this.cb_cancel=create cb_cancel
this.cbx_collate=create cbx_collate
this.st_3=create st_3
this.sle_page_range=create sle_page_range
this.rb_pages=create rb_pages
this.rb_current_page=create rb_current_page
this.rb_all=create rb_all
this.st_2=create st_2
this.st_1=create st_1
this.cb_ok=create cb_ok
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.Control[]={this.cb_2,&
this.sle_printer,&
this.st_4_1,&
this.em_1,&
this.ddlb_range,&
this.st_4,&
this.cb_printer,&
this.cb_cancel,&
this.cbx_collate,&
this.st_3,&
this.sle_page_range,&
this.rb_pages,&
this.rb_current_page,&
this.rb_all,&
this.st_2,&
this.st_1,&
this.cb_ok,&
this.gb_1,&
this.gb_4,&
this.gb_3,&
this.gb_2}
end on

on w_dw_print_setting.destroy
destroy(this.cb_2)
destroy(this.sle_printer)
destroy(this.st_4_1)
destroy(this.em_1)
destroy(this.ddlb_range)
destroy(this.st_4)
destroy(this.cb_printer)
destroy(this.cb_cancel)
destroy(this.cbx_collate)
destroy(this.st_3)
destroy(this.sle_page_range)
destroy(this.rb_pages)
destroy(this.rb_current_page)
destroy(this.rb_all)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event closequery;Return 
end event

type cb_2 from commandbutton within w_dw_print_setting
integer x = 1518
integer y = 1004
integer width = 480
integer height = 164
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = "ÆÄÀÏ·Î ÀúÀå(&F)"
end type

event clicked;idw_dw.SaveAs()
end event

type sle_printer from singlelineedit within w_dw_print_setting
integer x = 494
integer y = 72
integer width = 910
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 8388608
long backcolor = 80269524
boolean border = false
boolean autohscroll = false
boolean displayonly = true
end type

type st_4_1 from statictext within w_dw_print_setting
integer x = 462
integer y = 740
integer width = 576
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = " ¿¹)  1, 3, 5-12"
boolean focusrectangle = false
end type

type em_1 from editmask within w_dw_print_setting
integer x = 343
integer y = 180
integer width = 251
integer height = 88
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
string displaydata = "œ""
double increment = 1
string minmax = "1~~99"
end type

event losefocus;If This.text = "" Or Trim(This.text) = "0" Then
	This.Setredraw(False)
	This.text = "1"
	This.Setredraw(True)	
End if	

If Integer(This.text) > 99  OR Integer(This.text) < 1 Then
	This.Setredraw(False)
	This.text = "1"
	This.Setredraw(True)	
End if
end event

type ddlb_range from dropdownlistbox within w_dw_print_setting
integer x = 329
integer y = 848
integer width = 1093
integer height = 288
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
string text = "All Pages In Range"
boolean sorted = false
string item[] = {"All Pages in Range","Even Numbered Pages","Odd Numbered Pages"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_dw_print_setting
integer x = 87
integer y = 864
integer width = 233
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "ÀÎ¼â(&R)"
boolean focusrectangle = false
end type

type cb_printer from commandbutton within w_dw_print_setting
integer x = 1550
integer y = 404
integer width = 393
integer height = 108
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = "Prin&ter..."
end type

event clicked;PrintSetup()
sle_printer.text = idw_dw.Describe('datawindow.printer')
end event

type cb_cancel from commandbutton within w_dw_print_setting
integer x = 1550
integer y = 200
integer width = 393
integer height = 108
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = " ´Ý   ±â "
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, 1)
//Close(parent)
end event

type cbx_collate from checkbox within w_dw_print_setting
integer x = 142
integer y = 1052
integer width = 462
integer height = 68
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
string text = "ÇÑºÎ¾¿ ÀÎ¼â(&I)"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_dw_print_setting
integer x = 471
integer y = 668
integer width = 914
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "ÂÊ¹øÈ£, ¶Ç´Â ÂÊ¹üÀ§¸¦ ÀÔ·ÂÇÏ¼¼¿ä"
boolean focusrectangle = false
end type

type sle_page_range from singlelineedit within w_dw_print_setting
integer x = 457
integer y = 540
integer width = 887
integer height = 84
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event modified;rb_pages.checked = true
end event

type rb_pages from radiobutton within w_dw_print_setting
integer x = 96
integer y = 548
integer width = 352
integer height = 68
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
string text = "ÂÊ ¹øÈ£(&G)"
borderstyle borderstyle = stylelowered!
end type

on clicked;wf_page_range(this)
end on

type rb_current_page from radiobutton within w_dw_print_setting
integer x = 96
integer y = 464
integer width = 352
integer height = 68
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
string text = "ÇöÀçÂÊ(&E)"
borderstyle borderstyle = stylelowered!
end type

on clicked;wf_page_range(this)
end on

type rb_all from radiobutton within w_dw_print_setting
integer x = 96
integer y = 380
integer width = 293
integer height = 68
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
string text = "ÀüÃ¼(&A)"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

on clicked;wf_page_range(this)
end on

type st_2 from statictext within w_dw_print_setting
integer x = 78
integer y = 188
integer width = 242
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "ÀÎ¼â¸Å¼ö "
boolean focusrectangle = false
end type

type st_1 from statictext within w_dw_print_setting
integer x = 78
integer y = 80
integer width = 407
integer height = 68
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
boolean enabled = false
string text = "¼³Á¤µÈ Printer:"
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_dw_print_setting
integer x = 1550
integer y = 96
integer width = 393
integer height = 108
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
string text = " ÀÎ   ¼â "
boolean default = true
end type

event clicked;String  tmp, command
Long 	  row 
String  docname, named, ls_scale
Integer value, li_return

tmp = ""

If(rb_pages.checked) Then
    If(sle_page_range.text = "") Then
		  beep(2)
		  MessageBox(" È®   ÀÎ ", "ÂÊ¹øÈ£/ÂÊ¹üÀ§¸¦ ÁöÁ¤ÇÏÁö ¾Ê¾Ò½À´Ï´Ù.!!! ~r~n" + &
			                       "ÂÊ¹øÈ£ È¤Àº ÂÊ¹üÀ§¸¦ ÀÔ·ÂÇÏ¼¼¿ä")
		  sle_page_range.setfocus()
		  Return
	End If
End If

CHOOSE CASE lower(left(ddlb_range.text,1)) // determine rangeinclude (all,even,odd)
CASE 'a' // all
	 tmp = '0'
CASE 'e' // even
	 tmp = '1'
CASE 'o' //odd
	 tmp = '2'
END CHOOSE

command = 'datawindow.print.page.rangeinclude = ' + tmp

If(cbx_collate.checked) Then // collate output ?
	command = command + " datawindow.print.collate = yes"
Else
	command = command + " datawindow.print.collate = no"
End If

CHOOSE CASE is_page_range // did they pick a page range?
CASE 'a'  // all
	 tmp = ''
CASE 'c' // current page?
	 row = idw_dw.GetRow()
    tmp = idw_dw.Describe("evaluate('page()'," + string(row) + ")")
CASE 'p' // a range?
	 tmp = sle_page_range.text
END CHOOSE


If(len(tmp) > 0) Then 
	command = command + " datawindow.print.page.range = '" + tmp + "'"
End If

If(len(em_1.text) > 0) Then 
	 command = command + " datawindow.print.copies = " + em_1.text
End If


// now alter the datawindow
tmp = idw_dw.Modify(command)

If(len(tmp) > 0) Then // if error the display the 
	 MessageBox('Error Setting Print Options', 'Error message = ' + tmp + '~r~nCommand = ' + command)
	 Return
End If

li_return = idw_dw.Print()

If li_return = 1 Then
	
	CloseWithReturn(Parent, 1)
	//Close(Parent)
Else 
	SetPointer(HourGlass!)
	CloseWithReturn(Parent, 1)
	SetPointer(Arrow!)
End if
	
end event

type gb_1 from groupbox within w_dw_print_setting
integer x = 32
integer y = 308
integer width = 1394
integer height = 524
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
string text = "ÀÎ¼â¹üÀ§"
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_dw_print_setting
integer x = 27
integer y = 4
integer width = 1399
integer height = 300
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_dw_print_setting
integer x = 55
integer y = 980
integer width = 1381
integer height = 184
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_dw_print_setting
integer x = 1518
integer y = 28
integer width = 457
integer height = 524
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "±¼¸²"
long textcolor = 33554432
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

