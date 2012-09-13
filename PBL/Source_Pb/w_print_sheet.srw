$PBExportHeader$w_print_sheet.srw
forward
global type w_print_sheet from w_cmms_sheet01
end type
type dw_1 from datawindow within w_print_sheet
end type
end forward

global type w_print_sheet from w_cmms_sheet01
string title = "프린트 상속원본"
dw_1 dw_1
end type
global w_print_sheet w_print_sheet

type variables
boolean ib_down = false
string	is_zoom = '100'
boolean ib_preview = true
end variables

on w_print_sheet.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_print_sheet.destroy
call super::destroy
destroy(this.dw_1)
end on

event open;call super::open;//wf_set_button('First','Prior','Next','Last','Ruler','Zoom')
//wf_auth_button(2,false)
//wf_auth_button(3,false)
//wf_auth_button(4,false)
//wf_auth_button(5,false)
//
end event

event ue_print;call super::ue_print;string ls_orient,ls_paper
long li_cur
str_print lstr_print

//set instance variable lstr_print(structure)
lstr_print.dw_prt = dw_1 	// assign DW
lstr_print.s_success = '0' // initialize success flag
lstr_print.s_document = 'datawindow' // assign window title to document name

// open w_print and send message to w_print
openwithparm(w_set_print,lstr_print)

end event

type dw_1 from datawindow within w_print_sheet
integer x = 5
integer y = 116
integer width = 3552
integer height = 1784
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//pb_plus.triggerevent(clicked!)
end event

event constructor;dw_1.settransobject(sqlcmms);
end event

event rbuttondown;//pb_minus.triggerevent(clicked!)
end event

event retrieveend;If ib_preview Then
	this.Modify('DataWindow.Print.Preview = Yes')  // set preview mode
	this.Modify('datawindow.Print.Preview.Rulers = Yes'); // set ruler on
End if

end event

