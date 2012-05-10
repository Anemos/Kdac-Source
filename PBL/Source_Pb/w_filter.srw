$PBExportHeader$w_filter.srw
$PBExportComments$필터 윈도우
forward
global type w_filter from window
end type
type sle_2 from singlelineedit within w_filter
end type
type st_2 from statictext within w_filter
end type
type st_1 from statictext within w_filter
end type
type cb_unfilter from commandbutton within w_filter
end type
type cb_exit from commandbutton within w_filter
end type
type ddlb_filtercol from dropdownlistbox within w_filter
end type
type cb_filter from commandbutton within w_filter
end type
type sle_1 from singlelineedit within w_filter
end type
type gb_1 from groupbox within w_filter
end type
end forward

global type w_filter from window
integer x = 832
integer y = 360
integer width = 1211
integer height = 748
boolean titlebar = true
string title = "필터윈도우"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79216776
string icon = "bmp\km2000.ico"
boolean clientedge = true
sle_2 sle_2
st_2 st_2
st_1 st_1
cb_unfilter cb_unfilter
cb_exit cb_exit
ddlb_filtercol ddlb_filtercol
cb_filter cb_filter
sle_1 sle_1
gb_1 gb_1
end type
global w_filter w_filter

type variables
datawindow dw1
int ii_col_seq[]
end variables

forward prototypes
public subroutine wf_reset_ddlb ()
end prototypes

public subroutine wf_reset_ddlb ();int	li_column_count,li_counter,m=0,k=0,li_col_seq[],i
string  ls_column_name

//ddlb_data.reset()
ddlb_filtercol.reset()

//Get the number of columns on this datawindow.

li_column_count = Integer(dw1.Object.DataWindow.Column.Count)

For li_counter =  li_column_count to 1 step -1
	ls_column_name = dw1.Describe("#"+string(li_counter)+".Tag")
	
	if ls_column_name = '?' or ls_column_name = '' or isnull(ls_column_name) then
	else
		m++
		li_col_seq[m] = li_counter 
		ddlb_filtercol.InsertItem(ls_column_name,1)
	end if
Next

for i = m to 1 step -1
	k++
	ii_col_seq[k] = li_col_seq[i]
next

if ls_column_name = '?' or ls_column_name = '' or isnull(ls_column_name) then

else
	ddlb_filtercol.selectitem(1)

	ls_column_name = dw1.Describe("#"+string(ii_col_seq[1])+".Name")
	sle_2.text =ls_column_name
end if
end subroutine

on w_filter.create
this.sle_2=create sle_2
this.st_2=create st_2
this.st_1=create st_1
this.cb_unfilter=create cb_unfilter
this.cb_exit=create cb_exit
this.ddlb_filtercol=create ddlb_filtercol
this.cb_filter=create cb_filter
this.sle_1=create sle_1
this.gb_1=create gb_1
this.Control[]={this.sle_2,&
this.st_2,&
this.st_1,&
this.cb_unfilter,&
this.cb_exit,&
this.ddlb_filtercol,&
this.cb_filter,&
this.sle_1,&
this.gb_1}
end on

on w_filter.destroy
destroy(this.sle_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_unfilter)
destroy(this.cb_exit)
destroy(this.ddlb_filtercol)
destroy(this.cb_filter)
destroy(this.sle_1)
destroy(this.gb_1)
end on

event open;f_win_center(this)
dw1 = Message.PowerObjectParm
wf_reset_ddlb()
end event

type sle_2 from singlelineedit within w_filter
boolean visible = false
integer x = 1225
integer y = 80
integer width = 402
integer height = 120
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 41943040
string text = "none"
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_filter
integer x = 119
integer y = 276
integer width = 270
integer height = 68
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 41943040
long backcolor = 74481808
string text = "검색명 :"
boolean focusrectangle = false
end type

type st_1 from statictext within w_filter
integer x = 119
integer y = 112
integer width = 215
integer height = 68
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 41943040
long backcolor = 74481808
string text = "선택 :"
boolean focusrectangle = false
end type

type cb_unfilter from commandbutton within w_filter
event clicked pbm_bnclicked
boolean visible = false
integer x = 1230
integer y = 316
integer width = 334
integer height = 96
integer taborder = 100
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Unfilter"
end type

event clicked;string ls_filter

ls_filter = 'unfilter'

closewithreturn(parent, ls_filter)

end event

type cb_exit from commandbutton within w_filter
event clicked pbm_bnclicked
integer x = 754
integer y = 488
integer width = 334
integer height = 96
integer taborder = 110
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "종 료"
end type

event clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////
//clicked script for cb_close
////////////////////////////////////////////////////////////////////////////////////////////////////////

//close main window
close(parent)
end event

type ddlb_filtercol from dropdownlistbox within w_filter
event selectionchanged pbm_cbnselchange
integer x = 421
integer y = 96
integer width = 622
integer height = 508
integer taborder = 10
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 41943040
boolean autohscroll = true
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_column_name
ls_column_name = dw1.Describe("#"+string(ii_col_seq[index])+".Name")
sle_2.text =ls_column_name
//////////////////////////////////////////////////////////////////////////////////////////////////////////
////selectionchanged script for ddlb_filtercol
//////////////////////////////////////////////////////////////////////////////////////////////////////////
//
////This script will load the ddlb.data with unique values for the column that was selected.
//
//dwBuffer	le_buffertype
//Int			li_buffers, li_items, li_index
//Long 		ll_row_counter, ll_rows_buffer
//String 		ls_column_name,ls_col_type,ls_insert_item
//String		ls_buffertype, ls_fil_column_name, ls_filter_string
//
//
//if index < 1 then return
//
//SetPointer(Hourglass!)
//
////get column name from the datawindow that was selected
////ls_column_name = ddlb_filtercol.text
//
////clear out the data drop down list box
////ddlb_data.Reset()
////ddlb_data.allowedit = true
////ddlb_data.text = ""
////ddlb_data.allowedit = false
////ddlb_op.allowedit = true
////ddlb_op.text = ""
////ddlb_op.allowedit = false
//
//ls_column_name = dw1.Describe("#"+string(ii_col_seq[index])+".Name")
////determine if the column selected is numeric or strings
//ls_col_type = dw1.Describe(ls_column_name+".ColType")
//le_buffertype = Primary!
//ll_rows_buffer = dw1.RowCount()
//
//For li_buffers = 1 to 2
//	For ll_row_counter = 1 to ll_rows_buffer
//		If left(ls_col_type,4) = "char" then
//			ls_insert_item = Trim(dw1.GetItemString(ll_row_counter, ls_column_name, &
//									le_buffertype, False))
//			ls_fil_column_name = "upper("+ls_column_name+")"
//		ElseIf ls_col_type = "number" or ls_col_type = "long" or left(ls_col_type,7) = "decimal" then
//			ls_insert_item = String(dw1.GetItemnumber(ll_row_counter, ls_column_name, &
//									le_buffertype, False))
//			ls_fil_column_name = ls_column_name
//		elseif ls_col_type = "datetime" then
//			ls_insert_item = String(dw1.GetItemdatetime(ll_row_counter, ls_column_name, &
//									le_buffertype, False))
//			ls_fil_column_name = ls_column_name
//		End If
//
//		ddlb_data.InsertItem(ls_insert_item,1)
//	Next
//	le_buffertype=Filter!
//	ll_rows_buffer=dw1.FilteredCount()
//Next
//
////Resort the data in listbox
//ddlb_data.Sorted=True
//ddlb_data.Visible=True
//
////After all of the rows have been added to the listbox, this will go through the sorted listbox
////and remove all duplicate row. This is more efficient than preventing a duplicate inserted 
////row.
//li_items = ddlb_data.TotalItems()
//li_index = 1
//Do While li_index <= li_items - 1
//	If ddlb_data.text(li_index) = ddlb_data.text(li_index+1) Then
//		li_items = ddlb_data.DeleteItem ( li_index )
//	Else
//		li_index ++
//	End If
//Loop
//
//ls_filter_string = trim(mle_1.text)
//mle_1.text = ls_filter_string + ' ' + ls_fil_column_name
//
//
end event

type cb_filter from commandbutton within w_filter
event clicked pbm_bnclicked
integer x = 402
integer y = 488
integer width = 334
integer height = 96
integer taborder = 90
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "검색"
end type

event clicked;string ls_filter,ls_column_name

ls_filter =  sle_2.text + " = '"+upper(sle_1.text)+"'"

closewithreturn(parent,ls_filter)

end event

type sle_1 from singlelineedit within w_filter
event keydwn pbm_keydown
integer x = 421
integer y = 268
integer width = 622
integer height = 100
integer taborder = 40
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 41943040
borderstyle borderstyle = stylelowered!
end type

event keydwn;if key = keyenter! then
	cb_filter.triggerevent(clicked!)
end if
end event

type gb_1 from groupbox within w_filter
integer x = 41
integer y = 12
integer width = 1088
integer height = 424
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 41943040
long backcolor = 74481808
end type

