$PBExportHeader$w_preview2.srw
$PBExportComments$프린트 프리뷰(Retrieve)
forward
global type w_preview2 from window
end type
type st_2 from statictext within w_preview2
end type
type ddlb_1 from dropdownlistbox within w_preview2
end type
type rb_2 from radiobutton within w_preview2
end type
type rb_1 from radiobutton within w_preview2
end type
type ddlb_zoom from dropdownlistbox within w_preview2
end type
type cbx_1 from checkbox within w_preview2
end type
type st_1 from statictext within w_preview2
end type
type pb_last from picturebutton within w_preview2
end type
type pb_next from picturebutton within w_preview2
end type
type pb_prior from picturebutton within w_preview2
end type
type pb_first from picturebutton within w_preview2
end type
type st_zoom from statictext within w_preview2
end type
type cb_prt2 from commandbutton within w_preview2
end type
type cb_close from commandbutton within w_preview2
end type
type dw_preview from datawindow within w_preview2
end type
type st_printer from statictext within w_preview2
end type
type cb_printer from commandbutton within w_preview2
end type
type gb_2 from groupbox within w_preview2
end type
type gb_1 from groupbox within w_preview2
end type
end forward

global type w_preview2 from window
integer x = 110
integer y = 172
integer width = 3602
integer height = 2012
boolean titlebar = true
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
event ue_postopen ( )
st_2 st_2
ddlb_1 ddlb_1
rb_2 rb_2
rb_1 rb_1
ddlb_zoom ddlb_zoom
cbx_1 cbx_1
st_1 st_1
pb_last pb_last
pb_next pb_next
pb_prior pb_prior
pb_first pb_first
st_zoom st_zoom
cb_prt2 cb_prt2
cb_close cb_close
dw_preview dw_preview
st_printer st_printer
cb_printer cb_printer
gb_2 gb_2
gb_1 gb_1
end type
global w_preview2 w_preview2

type variables
datawindowchild dw1, dw2
boolean	 ib_new_fg
int	ii_size = 1
end variables

forward prototypes
public subroutine wf_set_position ()
end prototypes

event ue_postopen;string  ls_arg[10]
string ls_orient
int i,li_num

datawindow ldw_temp
str_parm   lstr_parm

ls_arg[] = {'*','*','*','*','*','*','*','*','*','*'}

dw_preview.setredraw(false)

// get message parameter 
lstr_parm = message.PowerObjectParm
ib_new_fg =  lstr_parm.check 
//Preview datawindow
ldw_temp = lstr_parm.dw_parm[1]
//용지 방향
ls_orient = ldw_temp.Describe("DataWindow.Print.Orientation")
//기본 Printer 표시
st_printer.text = ldw_temp.Object.DataWindow.Printer

this.title = '출력 미리보기'   // set window title
dw_preview.dataobject = ldw_temp.dataobject
dw_preview.settransobject(sqlcmms);

li_num = Upperbound(lstr_parm.s_parm[])
for i = 1 to li_num
	ls_arg[i] = lstr_parm.s_parm[i]
next

dw_preview.retrieve(ls_arg[1],ls_arg[2],ls_arg[3],ls_arg[4],ls_arg[5],ls_arg[6],ls_arg[7],ls_arg[8],ls_arg[9],ls_arg[10])
dw_preview.Modify('datawindow.Print.Preview = Yes');   // set preview mode
//setting Orient
if ls_orient = '1' then 
	rb_1.checked = true
	rb_1.triggerevent(clicked!)
elseif ls_orient = '2' then 
	rb_2.checked = true
	rb_2.triggerevent(clicked!)
end if
//Title
wf_set_position()
dw_preview.setredraw(true)

end event

public subroutine wf_set_position ();dw_preview.setredraw(false)
//세로
If rb_2.checked = true Then		
	// set report orientation landscape
	dw_preview.Modify('datawindow.Print.Orientation = 2');
	Choose Case ii_size
		Case 1
			dw_preview.Modify("DataWindow.Print.Paper.Size='9'")
			dw_preview.Modify("title.Width='3400'")			//제목 가로길이
			dw_preview.Modify("page.Width='3400'")				//Page 가로길이
		Case 2
			dw_preview.Modify("DataWindow.Print.Paper.Size='12'")
			dw_preview.Modify("title.Width='5000'")			//제목 가로길이
			dw_preview.Modify("page.Width='5000'")				//Page 가로길이
	End Choose		
//가로
Else
	// set report orientation landscape
	dw_preview.Modify('datawindow.Print.Orientation = 1');
	Choose Case ii_size
		Case 1
			dw_preview.Modify("DataWindow.Print.Paper.Size='9'")
			dw_preview.Modify("title.Width='4900'")			//제목 가로길이
			dw_preview.Modify("page.Width='4900'")				//Page 가로길이
		Case 2
			dw_preview.Modify("DataWindow.Print.Paper.Size='12'")
			dw_preview.Modify("title.Width='6500'")			//제목 가로길이
			dw_preview.Modify("page.Width='6500'")				//Page 가로길이
	End Choose		
end if
dw_preview.setredraw(true)


end subroutine

on w_preview2.create
this.st_2=create st_2
this.ddlb_1=create ddlb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.ddlb_zoom=create ddlb_zoom
this.cbx_1=create cbx_1
this.st_1=create st_1
this.pb_last=create pb_last
this.pb_next=create pb_next
this.pb_prior=create pb_prior
this.pb_first=create pb_first
this.st_zoom=create st_zoom
this.cb_prt2=create cb_prt2
this.cb_close=create cb_close
this.dw_preview=create dw_preview
this.st_printer=create st_printer
this.cb_printer=create cb_printer
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.ddlb_1,&
this.rb_2,&
this.rb_1,&
this.ddlb_zoom,&
this.cbx_1,&
this.st_1,&
this.pb_last,&
this.pb_next,&
this.pb_prior,&
this.pb_first,&
this.st_zoom,&
this.cb_prt2,&
this.cb_close,&
this.dw_preview,&
this.st_printer,&
this.cb_printer,&
this.gb_2,&
this.gb_1}
end on

on w_preview2.destroy
destroy(this.st_2)
destroy(this.ddlb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.ddlb_zoom)
destroy(this.cbx_1)
destroy(this.st_1)
destroy(this.pb_last)
destroy(this.pb_next)
destroy(this.pb_prior)
destroy(this.pb_first)
destroy(this.st_zoom)
destroy(this.cb_prt2)
destroy(this.cb_close)
destroy(this.dw_preview)
destroy(this.st_printer)
destroy(this.cb_printer)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;//기본용지 Size
ddlb_1.text = '일반용지(A4)'
ii_size = 1
f_win_center(this)
this.triggerevent("ue_postopen")
end event

type st_2 from statictext within w_preview2
integer x = 3072
integer y = 44
integer width = 357
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "용     지"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_preview2
integer x = 3017
integer y = 108
integer width = 521
integer height = 396
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "System"
long backcolor = 16777215
boolean sorted = false
boolean vscrollbar = true
string item[] = {"일반용지(A4)","일반용지(B4)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index > 0 then
	ii_size = index
end if

wf_set_position()			
end event

type rb_2 from radiobutton within w_preview2
integer x = 2761
integer y = 124
integer width = 242
integer height = 72
integer taborder = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 79216776
string text = "세로"
boolean checked = true
end type

event clicked;wf_set_position();
end event

type rb_1 from radiobutton within w_preview2
integer x = 2537
integer y = 128
integer width = 238
integer height = 72
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 79216776
string text = "가로"
end type

event clicked;wf_set_position();
end event

type ddlb_zoom from dropdownlistbox within w_preview2
integer x = 526
integer y = 108
integer width = 274
integer height = 536
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "System"
long backcolor = 16777215
string text = "100"
boolean allowedit = true
boolean sorted = false
boolean vscrollbar = true
string item[] = {"50","60","70","80","90","100","110","120","130","140","150","160","170","180","190","200"}
end type

event selectionchanged;// set zoom rate
dw_preview.Modify("datawindow.zoom = " + this.text )
dw_preview.Modify("datawindow.print.zoom = " + this.text )


end event

event modified;dw_preview.Modify("datawindow.preview.zoom = " + this.text )
dw_preview.Modify("datawindow.zoom = " + this.text )


end event

type cbx_1 from checkbox within w_preview2
integer x = 809
integer y = 112
integer width = 283
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 79741120
string text = "눈금자"
boolean lefttext = true
end type

event clicked;if this.checked then
	dw_preview.Modify('datawindow.Print.Preview.Rulers = Yes'); // set ruler on
else
	dw_preview.Modify('datawindow.Print.Preview.Rulers = No'); // set ruler off
end if
end event

type st_1 from statictext within w_preview2
integer x = 119
integer y = 40
integer width = 357
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "페이지이동"
boolean focusrectangle = false
end type

type pb_last from picturebutton within w_preview2
integer x = 393
integer y = 104
integer width = 114
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = ".\bmp\arrowlast.bmp"
string disabledname = ".\bmp\arrowlast_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_preview.scrolltorow(999999)

end event

type pb_next from picturebutton within w_preview2
integer x = 279
integer y = 104
integer width = 114
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = ".\bmp\arrowri.bmp"
string disabledname = ".\bmp\arrowri_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_preview.scrollnextpage()

end event

type pb_prior from picturebutton within w_preview2
integer x = 165
integer y = 104
integer width = 114
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = ".\bmp\arrowle.bmp"
string disabledname = ".\bmp\arrowle_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_preview.scrollpriorpage()

end event

type pb_first from picturebutton within w_preview2
integer x = 50
integer y = 104
integer width = 114
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean originalsize = true
string picturename = ".\bmp\arrowfirst.bmp"
string disabledname = ".\bmp\arrowfirst_dis.bmp"
alignment htextalign = left!
end type

event clicked;dw_preview.scrolltorow(1)

end event

type st_zoom from statictext within w_preview2
integer x = 544
integer y = 36
integer width = 242
integer height = 56
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "Zoom"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_prt2 from commandbutton within w_preview2
event clicked pbm_bnclicked
integer x = 1390
integer y = 28
integer width = 288
integer height = 100
integer taborder = 100
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "인쇄"
end type

event clicked;// default 1 Copies
dw_preview.object.datawindow.print.copies = '1'   

// Orientation
if rb_1.checked then
	dw_preview.object.datawindow.print.orientation = 1
end if
if rb_2.checked then
	dw_preview.object.datawindow.print.orientation = 2
end if	

// Page Range
dw_preview.object.datawindow.print.page.range = ''	  // 전체

dw_preview.object.datawindow.print.documentname = 'Datawindow'	  // 제목
//프린트 후 상태를 Return 
dw_preview.print()
closewithreturn(parent,'1')
end event

type cb_close from commandbutton within w_preview2
integer x = 1966
integer y = 28
integer width = 288
integer height = 100
integer taborder = 120
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "닫기"
end type

event clicked;closewithreturn(parent,0)
end event

type dw_preview from datawindow within w_preview2
integer x = 5
integer y = 232
integer width = 3570
integer height = 1688
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_printer from statictext within w_preview2
integer x = 1179
integer y = 140
integer width = 1243
integer height = 84
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_printer from commandbutton within w_preview2
event clicked pbm_bnclicked
integer x = 1678
integer y = 28
integer width = 288
integer height = 100
integer taborder = 110
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "설정"
end type

event clicked;string ls_orient,ls_paper
long li_cur
str_print lstr_print

//set instance variable lstr_print(structure)
lstr_print.dw_prt = dw_preview 	// assign DW
lstr_print.s_success = '0' // initialize success flag
lstr_print.s_document = 'datawindow' // assign window title to document name

// open w_print and send message to w_print
openwithparm(w_set_print,lstr_print)

st_printer.text = dw_preview.Object.DataWindow.Printer
//출력방향 초기화
ls_orient = dw_preview.Describe('datawindow.Print.Orientation')
If ls_orient = '1' Then
	rb_1.checked = true
Else
	rb_2.checked = true
End if

ls_paper = dw_preview.Describe("DataWindow.Print.Paper.Size")
Choose Case ls_paper
	Case '12'
		ddlb_1.selectitem(2)
	Case Else
		ddlb_1.selectitem(1)
End Choose		



end event

type gb_2 from groupbox within w_preview2
integer x = 2505
integer width = 1065
integer height = 224
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 79216776
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_preview2
integer x = 27
integer width = 1093
integer height = 224
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 79216776
borderstyle borderstyle = styleraised!
end type

