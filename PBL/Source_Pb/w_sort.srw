$PBExportHeader$w_sort.srw
$PBExportComments$Sort Window
forward
global type w_sort from window
end type
type st_2 from statictext within w_sort
end type
type dw_sort from datawindow within w_sort
end type
type st_1 from statictext within w_sort
end type
type dw_source from datawindow within w_sort
end type
type cb_exit from commandbutton within w_sort
end type
type cb_sort from commandbutton within w_sort
end type
end forward

global type w_sort from window
integer x = 347
integer y = 336
integer width = 2295
integer height = 1388
boolean titlebar = true
string title = "데이타 정렬"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
string icon = "bmp\km2000.ico"
st_2 st_2
dw_sort dw_sort
st_1 st_1
dw_source dw_source
cb_exit cb_exit
cb_sort cb_sort
end type
global w_sort w_sort

type variables
datawindow dw1
int ii_drag_row
boolean ib_down,ib_down2
end variables

forward prototypes
public subroutine wf_reset_dw ()
end prototypes

public subroutine wf_reset_dw ();int	li_column_count, ii, li_row
string  ls_column_name, ls_column_text

dw_source.reset()

dw_source.SetRedraw(False)
//Get the number of columns on this datawindow.

li_column_count = Integer(dw1.Object.DataWindow.Column.Count)

For ii =  1 to li_column_count 
	ls_column_text = dw1.Describe("#"+string(ii)+".Tag")   
	ls_column_name = dw1.Describe("#"+string(ii)+".Name")
	
	if ls_column_text = '?' or ls_column_text = '' or isnull(ls_column_text) then
	else
		li_row = dw_source.InsertRow(0)
		dw_source.SetItem(li_row, "c_col", ls_column_name)
		dw_source.SetItem(li_row, "c_col_nm", ls_column_text)
	end if
	
Next

dw_source.SetRedraw(True)
dw_sort.Reset()

end subroutine

on w_sort.create
this.st_2=create st_2
this.dw_sort=create dw_sort
this.st_1=create st_1
this.dw_source=create dw_source
this.cb_exit=create cb_exit
this.cb_sort=create cb_sort
this.Control[]={this.st_2,&
this.dw_sort,&
this.st_1,&
this.dw_source,&
this.cb_exit,&
this.cb_sort}
end on

on w_sort.destroy
destroy(this.st_2)
destroy(this.dw_sort)
destroy(this.st_1)
destroy(this.dw_source)
destroy(this.cb_exit)
destroy(this.cb_sort)
end on

event open;f_win_center(this)
dw1 = Message.PowerObjectParm
wf_reset_dw()

end event

type st_2 from statictext within w_sort
integer x = 27
integer y = 108
integer width = 1646
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "* 정렬 칼럼의 순서에 따라 데이타가 정렬됩니다."
boolean focusrectangle = false
end type

type dw_sort from datawindow within w_sort
integer x = 1033
integer y = 204
integer width = 1225
integer height = 920
integer taborder = 10
string dragicon = "Rectangle!"
string dataobject = "d_sort_col"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dragdrop;
datawindow ldw_source
int li_row

IF source.TypeOf() <> DataWindow! THEN RETURN
IF source = THIS THEN 
	THIS.RowsMove( ii_drag_row, ii_drag_row, Primary!, THIS, row, Primary!)
	RETURN
END IF

ldw_source = source

li_row = THIS.InsertRow(row)
THIS.SetItem(li_row, "c_col", ldw_source.GetItemString(ii_drag_row, "c_col"))
THIS.SetItem(li_row, "c_col_nm", ldw_source.GetItemString(ii_drag_row, "c_col_nm"))

ldw_source.DeleteRow(ii_drag_row)

end event

event clicked;IF row < 1 THEN RETURN
IF dwo.name = 'c_asc' then return

ii_drag_row = row
//THIS.DragIcon = "Row.Ico"
THIS.Drag(Begin!)

end event

type st_1 from statictext within w_sort
integer x = 27
integer y = 36
integer width = 1152
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 8388608
long backcolor = 79741120
boolean enabled = false
string text = "* 드래그 앤 드롭을 이용하십시오."
boolean focusrectangle = false
end type

type dw_source from datawindow within w_sort
integer x = 27
integer y = 204
integer width = 974
integer height = 920
integer taborder = 20
string dragicon = "Rectangle!"
string dataobject = "d_sort_source"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;IF row < 1 THEN RETURN

ii_drag_row = row
THIS.DragIcon = "pic/Row.Ico"
THIS.Drag(Begin!)

end event

event dragdrop;datawindow  ldw_source
int li_row

IF source = THIS THEN RETURN
IF source.TypeOf() <> DataWindow! THEN RETURN

ldw_source = source

li_row = THIS.InsertRow(row)
THIS.SetItem(li_row, "c_col", ldw_source.GetItemString(ii_drag_row, "c_col"))
THIS.SetItem(li_row, "c_col_nm", ldw_source.GetItemString(ii_drag_row, "c_col_nm"))

ldw_source.DeleteRow(ii_drag_row)


end event

type cb_exit from commandbutton within w_sort
event clicked pbm_bnclicked
integer x = 357
integer y = 1164
integer width = 329
integer height = 108
integer taborder = 40
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "종 료"
end type

event clicked;CloseWithReturn(parent, "")
end event

type cb_sort from commandbutton within w_sort
event clicked pbm_bnclicked
integer x = 27
integer y = 1164
integer width = 329
integer height = 108
integer taborder = 30
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Sort"
end type

event clicked;string ls_column, ls_ad, ls_filter
int ii, li_end

ii = 1
li_end = dw_sort.RowCount()

ls_filter = ''
Do While ii <= li_end
	ls_column = Trim(dw_sort.GetItemString(ii, "c_col"))
	ls_ad = dw_sort.GetItemString(ii, "c_asc")
	IF ls_filter <> '' then ls_filter = ls_filter + ','
	ls_filter = ls_filter + ls_column + ' ' + ls_ad
	ii++
Loop

closewithreturn(parent,ls_filter)

end event

