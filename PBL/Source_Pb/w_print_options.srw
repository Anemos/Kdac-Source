$PBExportHeader$w_print_options.srw
$PBExportComments$¿Œº‚¡∂∞« Setting
forward
global type w_print_options from window
end type
type dw_dddw from datawindow within w_print_options
end type
type st_6 from statictext within w_print_options
end type
type rb_file from radiobutton within w_print_options
end type
type rb_print from radiobutton within w_print_options
end type
type cb_printer from commandbutton within w_print_options
end type
type cb_cancle from commandbutton within w_print_options
end type
type cb_ok from commandbutton within w_print_options
end type
type rb_sero from radiobutton within w_print_options
end type
type p_sero from picture within w_print_options
end type
type rb_garo from radiobutton within w_print_options
end type
type p_garo from picture within w_print_options
end type
type st_5 from statictext within w_print_options
end type
type sle_page_range from singlelineedit within w_print_options
end type
type rb_range_user from radiobutton within w_print_options
end type
type rb_range_cur from radiobutton within w_print_options
end type
type rb_range_all from radiobutton within w_print_options
end type
type ddlb_scale from dropdownlistbox within w_print_options
end type
type st_4 from statictext within w_print_options
end type
type em_copies from editmask within w_print_options
end type
type st_3 from statictext within w_print_options
end type
type ddlb_size from dropdownlistbox within w_print_options
end type
type st_2 from statictext within w_print_options
end type
type p_printer from picture within w_print_options
end type
type gb_4 from groupbox within w_print_options
end type
type gb_2 from groupbox within w_print_options
end type
type gb_3 from groupbox within w_print_options
end type
type gb_1 from groupbox within w_print_options
end type
type rb_excel from radiobutton within w_print_options
end type
type rb_pdf from radiobutton within w_print_options
end type
type rb_text from radiobutton within w_print_options
end type
type st_printer from statictext within w_print_options
end type
type st_1 from statictext within w_print_options
end type
type gb_5 from groupbox within w_print_options
end type
end forward

global type w_print_options from window
integer x = 750
integer y = 592
integer width = 2537
integer height = 1632
boolean titlebar = true
string title = "¿Œº‚º≥¡§"
windowtype windowtype = response!
long backcolor = 12632256
dw_dddw dw_dddw
st_6 st_6
rb_file rb_file
rb_print rb_print
cb_printer cb_printer
cb_cancle cb_cancle
cb_ok cb_ok
rb_sero rb_sero
p_sero p_sero
rb_garo rb_garo
p_garo p_garo
st_5 st_5
sle_page_range sle_page_range
rb_range_user rb_range_user
rb_range_cur rb_range_cur
rb_range_all rb_range_all
ddlb_scale ddlb_scale
st_4 st_4
em_copies em_copies
st_3 st_3
ddlb_size ddlb_size
st_2 st_2
p_printer p_printer
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
rb_excel rb_excel
rb_pdf rb_pdf
rb_text rb_text
st_printer st_printer
st_1 st_1
gb_5 gb_5
end type
global w_print_options w_print_options

type variables
int    i_n_paper_size
string i_s_page_range,  i_s_orient, i_s_page, i_s_filetype
datawindow  i_dw
transaction i_s_transaction
end variables

on w_print_options.create
this.dw_dddw=create dw_dddw
this.st_6=create st_6
this.rb_file=create rb_file
this.rb_print=create rb_print
this.cb_printer=create cb_printer
this.cb_cancle=create cb_cancle
this.cb_ok=create cb_ok
this.rb_sero=create rb_sero
this.p_sero=create p_sero
this.rb_garo=create rb_garo
this.p_garo=create p_garo
this.st_5=create st_5
this.sle_page_range=create sle_page_range
this.rb_range_user=create rb_range_user
this.rb_range_cur=create rb_range_cur
this.rb_range_all=create rb_range_all
this.ddlb_scale=create ddlb_scale
this.st_4=create st_4
this.em_copies=create em_copies
this.st_3=create st_3
this.ddlb_size=create ddlb_size
this.st_2=create st_2
this.p_printer=create p_printer
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.rb_excel=create rb_excel
this.rb_pdf=create rb_pdf
this.rb_text=create rb_text
this.st_printer=create st_printer
this.st_1=create st_1
this.gb_5=create gb_5
this.Control[]={this.dw_dddw,&
this.st_6,&
this.rb_file,&
this.rb_print,&
this.cb_printer,&
this.cb_cancle,&
this.cb_ok,&
this.rb_sero,&
this.p_sero,&
this.rb_garo,&
this.p_garo,&
this.st_5,&
this.sle_page_range,&
this.rb_range_user,&
this.rb_range_cur,&
this.rb_range_all,&
this.ddlb_scale,&
this.st_4,&
this.em_copies,&
this.st_3,&
this.ddlb_size,&
this.st_2,&
this.p_printer,&
this.gb_4,&
this.gb_2,&
this.gb_3,&
this.gb_1,&
this.rb_excel,&
this.rb_pdf,&
this.rb_text,&
this.st_printer,&
this.st_1,&
this.gb_5}
end on

on w_print_options.destroy
destroy(this.dw_dddw)
destroy(this.st_6)
destroy(this.rb_file)
destroy(this.rb_print)
destroy(this.cb_printer)
destroy(this.cb_cancle)
destroy(this.cb_ok)
destroy(this.rb_sero)
destroy(this.p_sero)
destroy(this.rb_garo)
destroy(this.p_garo)
destroy(this.st_5)
destroy(this.sle_page_range)
destroy(this.rb_range_user)
destroy(this.rb_range_cur)
destroy(this.rb_range_all)
destroy(this.ddlb_scale)
destroy(this.st_4)
destroy(this.em_copies)
destroy(this.st_3)
destroy(this.ddlb_size)
destroy(this.st_2)
destroy(this.p_printer)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.rb_excel)
destroy(this.rb_pdf)
destroy(this.rb_text)
destroy(this.st_printer)
destroy(this.st_1)
destroy(this.gb_5)
end on

event open;Str_prtoption	l_prt_option
Integer	ln_forcnt
String 	ls_paper
String 	ls_paper_size[]	=	{ 	"A3 297X420mm", "A4 210X297mm", "A4 Small 210X297mm", &
							  		 		"A5 148X210mm", "B4 250X354mm", "B5 182X257mm", &
							  		 		"Letter 8.5X11" }
/*  0 - Default, 								1 - Letter 8.5x11, 					2 - Letter Small 8.5x11,
	 3 - Tabloid 11x17, 						4 - Ledger 17x11, 					5 - Legal 8.5x14,
	 6 - Statement 5.5x8.5, 				7 - Executive 7.25x10.5, 			8 - A3 297x420mm,
	 9 - A4 210x297mm, 					10 - A4 Small 210x297mm, 		11 - A5 148x210mm,
	12 - B4 250x354, 						13 - B5 182x257mm, 				14 - Folio 8.5x13,
	15 - Quarto 215x275mm, 				16 - 10x14, 	 17 - 11x17, 		18 - Note 8.5x11,
	19 - Envelope #9 3.88x8.88, 			20 - Envelope #10 4.13x9.5, 		21 - Envelope #11 4.5x10.38,
	22 - Envelope #12 4\276x11, 		23 - Envelope #14 5x11.5, 		24 - C Size Sheet,
	25 - D Size Sheet, 						26 - E Size Sheet, 					27 - Envelope DL 110x220mm,
	28 - Envelope C5 162x229mm, 		29 - Envelope C3 324x458mm, 	30 - Envelope C4 229x324mm,
	31 - Envelope C6 114x162mm, 		32 - Envelope C65 114x229mm, 33 - Envelope B4 250x353mm,
	34 - Envelope B5 176x250mm, 		35 - Envelope B6 176x125mm, 	36 - Envelope 110x230mm,
	37 - Envelope Monarch 3.875x7.5, 38 - 6.75 Envelope 3.63x6.5, 	39 - US Std Fanfold 14.88x11,
	40 - German Std Fanfold 8.5x12,	41 - German Legal Fanfold 8.5x13
*/

for	ln_forcnt = 1 to UpperBound(ls_paper_size)
		ddlb_size.AddItem(ls_paper_size[ln_forcnt])
next

l_prt_option    		= 	message.powerobjectparm
i_dw			    		= 	l_prt_option.datawindow
i_s_page		    		= 	l_prt_option.page
i_s_transaction	=	l_prt_option.transaction

ls_paper		=	i_dw.Describe("DataWindow.Print.Paper.Size")
Choose case	ls_paper
	case	"8"
		i_n_paper_size = 1
	case	"0", "9"
		i_n_paper_size = 2
	case	"12"
		i_n_paper_size = 5
	case 	"13"
		i_n_paper_size = 6
	case 	"1"
		i_n_paper_size = 7
	case 	else
		i_n_paper_size = 2
end Choose
ddlb_size.Text		=	ls_paper_size[i_n_paper_size]

i_s_orient	=	i_dw.Describe("DataWindow.Print.Orientation")
if 	i_s_orient	=	"0" then			//Default
	i_s_orient 	= 	"1"
elseif	i_s_orient	=	"1" then		//Landscape
	rb_garo.checked	=	True
elseif i_s_orient 	= 	"2" then		//Portrait
	rb_sero.checked 	= 	True
end if

st_printer.text	=	i_dw.describe('datawindow.printer')
i_s_page_range  	= 	"a"

st_1.show()
p_printer.show()
st_printer.show()
gb_5.hide()
rb_excel.hide()
rb_pdf.hide()
rb_text.hide()
st_6.hide()
end event

type dw_dddw from datawindow within w_print_options
boolean visible = false
integer x = 165
integer y = 1392
integer width = 197
integer height = 84
integer taborder = 110
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_6 from statictext within w_print_options
integer x = 215
integer y = 460
integer width = 1353
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "°ÿ∆ƒ¿œª˝º∫¿∫ πÃ∏Æ∫∏±‚ ≥ªøÎ∞˙ ¥Ÿ∏ß."
boolean focusrectangle = false
end type

type rb_file from radiobutton within w_print_options
integer x = 1248
integer y = 60
integer width = 457
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "∆ƒ¿œª˝º∫"
end type

event clicked;cb_ok.text = "¿˙¿Â"

i_s_filetype = "1"
ddlb_scale.enabled	 = false
ddlb_size.enabled		 = false
em_copies.enabled		 = false
rb_garo.enabled		 = false
rb_sero.enabled		 = false
rb_range_all.enabled  = false
rb_range_cur.enabled  = false
rb_range_user.enabled = false

gb_5.show()
rb_excel.show()
rb_pdf.show()
rb_text.show()
st_1.hide()
p_printer.hide()
st_printer.hide()
st_6.show()
end event

type rb_print from radiobutton within w_print_options
integer x = 654
integer y = 64
integer width = 274
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "¿Œº‚"
boolean checked = true
end type

event clicked;cb_ok.text = "¿Œº‚"

ddlb_scale.enabled	 = true
ddlb_size.enabled		 = true
em_copies.enabled		 = true
rb_garo.enabled		 = true
rb_sero.enabled		 = true
rb_range_all.enabled  = true
rb_range_cur.enabled  = true
rb_range_user.enabled = true

st_1.show()
p_printer.show()
st_printer.show()
gb_5.hide()
rb_excel.hide()
rb_pdf.hide()
rb_text.hide()
st_6.hide()

end event

type cb_printer from commandbutton within w_print_options
integer x = 1856
integer y = 1392
integer width = 558
integer height = 108
integer taborder = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
string text = "«¡∏∞≈Õº≥¡§"
end type

event clicked;printsetup()
st_printer.text = i_dw.describe('datawindow.printer')
end event

type cb_cancle from commandbutton within w_print_options
integer x = 1248
integer y = 1392
integer width = 558
integer height = 108
integer taborder = 110
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
string text = "√Îº“"
boolean cancel = true
end type

event clicked;closewithreturn(parent,-1)
end event

type cb_ok from commandbutton within w_print_options
integer x = 635
integer y = 1392
integer width = 558
integer height = 108
integer taborder = 90
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
string text = "¿Œº‚"
boolean default = true
end type

event clicked;
Setpointer(hourglass!)

string l_s_tmp, l_s_command, l_s_page, l_s_docname, l_s_named
int    l_n_scale, l_n_value, l_n_paper
long 	 l_n_row,   l_i_rtn

i_dw.Setredraw(true)

//√‚∑¬ Data -> ∆ƒ¿œª˝º∫
if rb_file.checked then
	string l_s_grid_column
	string l_s_dddw_nm, l_s_dddw_data, l_s_dddw_disp, l_s_col_nm
	long   i,j,p,q=1,r
	
	l_s_grid_column = i_dw.Object.DataWindow.Table.GridColumns
	FOR i = 1 TO Integer(i_dw.Object.DataWindow.Column.Count)
		l_s_col_nm  = i_dw.Describe('#'+String(i)+'.Name')
		l_s_dddw_nm = i_dw.DesCribe(l_s_col_nm+'.DDDW.Name')
		IF l_s_dddw_nm <> '?' THEN
			l_s_dddw_data = i_dw.Describe(l_s_col_nm + '.DDDW.DataColumn')
			l_s_dddw_disp = i_dw.Describe(l_s_col_nm + '.DDDW.DisplayColumn')
			dw_dddw.dataObject = l_s_dddw_nm
			dw_dddw.SetTransObject(i_s_transaction)
			l_n_row = dw_dddw.Retrieve() //row count of dddw
			for j=1 TO i_dw.RowCount()
				r = dw_dddw.Find(l_s_dddw_data+"='"+i_dw.GetItemString(j,i)+"'",1,l_n_row)
				IF r > 0 THEN i_dw.SetItem(j,i,dw_dddw.GetItemString(r,l_s_dddw_disp))
			next
		end if
	next	
	Choose case i_s_filetype
		case "1"		//Excel
			l_n_value = GetFileSaveName("¿˙¿Â «œ±‚", l_s_docname, l_s_named, "xls", "Excel files (*.xls), *.xls")
			if l_n_value = 1 then
				i_dw.saveas(l_s_docname, Excel!, true)
			else
				messagebox("»Æ ¿Œ", "∆ƒ¿œ¿˙¿Â ø¿∑˘ ¿‘¥œ¥Ÿ.")
				i_dw.Setredraw(false)
				closewithreturn(parent,-1)
			end if
		case "2"		//PDF
			l_n_value = GetFileSaveName("¿˙¿Â «œ±‚", l_s_docname, l_s_named, "pdf", "PDF files (*.pdf), *.pdf")
			if l_n_value = 1 then
				i_dw.saveas(l_s_docname, pdf!, true)
			else
				messagebox("»Æ ¿Œ", "∆ƒ¿œ¿˙¿Â ø¿∑˘ ¿‘¥œ¥Ÿ.")
				i_dw.Setredraw(false)
				closewithreturn(parent,-1)
			end if
		case "3"		//Text
			l_n_value = GetFileSaveName("¿˙¿Â «œ±‚", l_s_docname, l_s_named, "txt", "Text files (*.txt), *.txt")
			if l_n_value = 1 then
				i_dw.saveas(l_s_docname, text!, true)
			else
				messagebox("»Æ ¿Œ", "∆ƒ¿œ¿˙¿Â ø¿∑˘ ¿‘¥œ¥Ÿ.")
				i_dw.Setredraw(false)
				closewithreturn(parent,-1)
			end if
	end Choose
	i_dw.Setredraw(false)
	closewithreturn(parent,-1)
end if

////////////////////
//√‚∑¬ Data -> √‚∑¬
////////////////////

//√‚∑¬¿¸ √ ±‚πË¿≤
 i_dw.Object.Datawindow.Zoom = "100"

//√‚∑¬«“ Page º±≈√
choose case i_s_page_range
	case 'a'				//¿¸√º
		l_s_tmp  = ''
	case 'c' 			//«ˆ¿Á∏È
		l_s_tmp  = i_s_page
	case 'p' 			//¿œ∫Œ∫–
		l_s_tmp  = sle_page_range.text
end choose		
l_s_command = " datawindow.Print.Page.Range = '" + l_s_tmp + "'"
l_s_command = l_s_command + " datawindow.print.collate = yes"

// øÎ¡ˆ
Choose Case i_n_paper_size
	case 2 //A4
		l_n_paper = 9
	case 1 //A3
		l_n_paper = 8
	case 5 //B4
		l_n_paper = 12
	case else
		l_n_paper = 0
End Choose
l_s_command = l_s_command + " datawindow.Print.Paper.Size = " + string(l_n_paper)

// πË¿≤
if len(ddlb_scale.text) > 0 then
	l_s_command = l_s_command + " datawindow.Zoom = " + ddlb_scale.text
end if

// orientation (1.Landscape(∞°∑Œ)  2.Portrait (ºº∑Œ)
l_s_command = l_s_command + " datawindow.Print.Orientation = " + i_s_orient

// number of copies
if len(em_copies.text) > 0 then
	l_s_command = l_s_command + " datawindow.Print.Copies = " + em_copies.text
end if

// now alter the datawindow
l_s_tmp = i_dw.modify(l_s_command)

if len(l_s_tmp) > 0 then // if error the display the 
	messagebox("»Æ ¿Œ", "Error message = " + l_s_tmp + "~r~nCommand = " + l_s_command)
	i_dw.Setredraw(false)
	closewithreturn(parent,-1)
	return
end if
i_dw.print()
i_dw.Setredraw(false)

closewithreturn(parent,1)

end event

type rb_sero from radiobutton within w_print_options
integer x = 1019
integer y = 1208
integer width = 274
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "ºº∑Œ"
end type

event clicked;i_s_orient = "2"		// Portrait
end event

type p_sero from picture within w_print_options
integer x = 855
integer y = 1164
integer width = 155
integer height = 164
boolean enabled = false
string picturename = "c:\kdac\bmp\p_sero.bmp"
boolean focusrectangle = false
end type

type rb_garo from radiobutton within w_print_options
integer x = 521
integer y = 1208
integer width = 265
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "∞°∑Œ"
boolean checked = true
end type

event clicked;i_s_orient = "1"		// Landscape
end event

type p_garo from picture within w_print_options
integer x = 265
integer y = 1192
integer width = 233
integer height = 112
boolean enabled = false
string picturename = "c:\kdac\bmp\p_garo.bmp"
boolean focusrectangle = false
end type

type st_5 from statictext within w_print_options
integer x = 1696
integer y = 1192
integer width = 507
integer height = 104
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
string text = "(øπ) 3, 5-8"
boolean focusrectangle = false
end type

type sle_page_range from singlelineedit within w_print_options
integer x = 1696
integer y = 1052
integer width = 654
integer height = 92
integer taborder = 70
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 16777215
boolean enabled = false
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type rb_range_user from radiobutton within w_print_options
integer x = 1696
integer y = 928
integer width = 398
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "¿œ∫Œ∫–"
end type

event clicked;//¿œ∫Œ∫– ¿Œº‚
sle_page_range.enabled = true
sle_page_range.setfocus()
i_s_page_range = 'p'

end event

type rb_range_cur from radiobutton within w_print_options
integer x = 1696
integer y = 804
integer width = 398
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "«ˆ¿Á∏È"
end type

event clicked;// «ˆ¿Á∏È ¿Œº‚
sle_page_range.enabled = false
i_s_page_range = 'c'

end event

type rb_range_all from radiobutton within w_print_options
integer x = 1696
integer y = 680
integer width = 398
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "¿¸√º"
boolean checked = true
end type

event clicked;// ¿¸√º ¿Œº‚
sle_page_range.enabled = false
i_s_page_range = 'a'

end event

type ddlb_scale from dropdownlistbox within w_print_options
integer x = 480
integer y = 928
integer width = 352
integer height = 448
integer taborder = 80
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 16777215
string text = "100"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"50","60","70","80","90","100","150","200"}
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_print_options
integer x = 165
integer y = 936
integer width = 398
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
string text = "¿Œº‚πË¿≤"
boolean focusrectangle = false
end type

type em_copies from editmask within w_print_options
integer x = 480
integer y = 800
integer width = 352
integer height = 96
integer taborder = 50
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 16777215
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##"
boolean spin = true
double increment = 1
string minmax = "1~~99"
end type

type st_3 from statictext within w_print_options
integer x = 165
integer y = 812
integer width = 398
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
string text = "¿Œº‚∏≈ºˆ"
boolean focusrectangle = false
end type

type ddlb_size from dropdownlistbox within w_print_options
integer x = 480
integer y = 684
integer width = 791
integer height = 444
integer taborder = 40
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 16777215
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;i_n_paper_size = index
end event

type st_2 from statictext within w_print_options
integer x = 165
integer y = 688
integer width = 398
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
string text = "øÎ¡ˆ≈©±‚"
boolean focusrectangle = false
end type

type p_printer from picture within w_print_options
integer x = 293
integer y = 216
integer width = 233
integer height = 144
string picturename = "c:\kdac\bmp\printer.bmp"
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_print_options
integer x = 201
integer width = 1897
integer height = 168
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long textcolor = 8388608
long backcolor = 12632256
end type

type gb_2 from groupbox within w_print_options
integer x = 128
integer y = 1108
integer width = 1193
integer height = 232
integer taborder = 120
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long textcolor = 8388608
long backcolor = 12632256
string text = "¿Œº‚πÊ«‚"
end type

type gb_3 from groupbox within w_print_options
integer x = 1632
integer y = 572
integer width = 773
integer height = 760
integer taborder = 60
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long textcolor = 8388608
long backcolor = 12632256
string text = "¿Œº‚π¸¿ß"
end type

type gb_1 from groupbox within w_print_options
integer x = 128
integer y = 580
integer width = 1193
integer height = 504
integer taborder = 30
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long textcolor = 8388608
long backcolor = 12632256
string text = "¿Œº‚º≥¡§"
end type

type rb_excel from radiobutton within w_print_options
integer x = 690
integer y = 260
integer width = 320
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "Excel"
boolean checked = true
end type

event clicked;i_s_filetype = "1"
end event

type rb_pdf from radiobutton within w_print_options
integer x = 1166
integer y = 260
integer width = 320
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "PDF"
end type

event clicked;i_s_filetype = "2"
end event

type rb_text from radiobutton within w_print_options
integer x = 1641
integer y = 260
integer width = 320
integer height = 76
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
string text = "Text"
end type

event clicked;i_s_filetype = "3"
end event

type st_printer from statictext within w_print_options
integer x = 494
integer y = 240
integer width = 1568
integer height = 112
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_1 from statictext within w_print_options
integer x = 201
integer y = 192
integer width = 1897
integer height = 212
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_5 from groupbox within w_print_options
integer x = 201
integer y = 188
integer width = 1897
integer height = 188
integer taborder = 20
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "∏º¿∫ ∞ÌµÒ"
long textcolor = 8388608
long backcolor = 12632256
string text = "∆ƒ¿œ¡æ∑˘"
end type

