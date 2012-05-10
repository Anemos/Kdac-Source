$PBExportHeader$u_pism_rowskip.sru
$PBExportComments$Page 이동 ( 맨앞/다음/이전/맨뒤 )
forward
global type u_pism_rowskip from userobject
end type
type pb_bottom from picturebutton within u_pism_rowskip
end type
type pb_back from picturebutton within u_pism_rowskip
end type
type pb_next from picturebutton within u_pism_rowskip
end type
type pb_top from picturebutton within u_pism_rowskip
end type
end forward

global type u_pism_rowskip from userobject
integer width = 741
integer height = 168
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
pb_bottom pb_bottom
pb_back pb_back
pb_next pb_next
pb_top pb_top
end type
global u_pism_rowskip u_pism_rowskip

type variables
DataWindow idw_source 
end variables

forward prototypes
public subroutine uf_setdw (datawindow adw)
public subroutine uf_setbutton ()
end prototypes

public subroutine uf_setdw (datawindow adw);
idw_source = adw 
//uf_setbutton()
end subroutine

public subroutine uf_setbutton ();Long ll_getRow 
Boolean lb_top = True, lb_bottom = True, lb_next = True, lb_back = True 

ll_getRow = idw_source.GetRow()
If ll_getRow = 1 Then 
	lb_top = False; lb_back = False 
End If 
If ll_getRow = idw_source.RowCount() Then 
	lb_bottom = False; lb_next = False 
End If 

pb_top.Enabled = lb_top; pb_next.Enabled = lb_next
pb_back.Enabled = lb_back; pb_bottom.Enabled = lb_bottom 
end subroutine

on u_pism_rowskip.create
this.pb_bottom=create pb_bottom
this.pb_back=create pb_back
this.pb_next=create pb_next
this.pb_top=create pb_top
this.Control[]={this.pb_bottom,&
this.pb_back,&
this.pb_next,&
this.pb_top}
end on

on u_pism_rowskip.destroy
destroy(this.pb_bottom)
destroy(this.pb_back)
destroy(this.pb_next)
destroy(this.pb_top)
end on

event constructor;idw_source = Create DataWindow 
end event

type pb_bottom from picturebutton within u_pism_rowskip
integer x = 544
integer y = 12
integer width = 174
integer height = 152
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "bmp\맨뒤.bmp"
string disabledname = "bmp\맨뒤_.bmp"
alignment htextalign = left!
end type

event clicked;idw_source.ScrollToRow(idw_source.RowCount()) 
uf_setbutton()
end event

type pb_back from picturebutton within u_pism_rowskip
integer x = 370
integer y = 12
integer width = 174
integer height = 152
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "bmp\이전.bmp"
string disabledname = "bmp\이전_.bmp"
alignment htextalign = left!
end type

event clicked;idw_source.ScrollPriorPage()
uf_setbutton()
end event

type pb_next from picturebutton within u_pism_rowskip
integer x = 197
integer y = 12
integer width = 174
integer height = 152
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "bmp\다음.bmp"
string disabledname = "bmp\다음_.bmp"
alignment htextalign = left!
end type

event clicked;idw_source.ScrollNextRow()
uf_setbutton()
end event

type pb_top from picturebutton within u_pism_rowskip
integer x = 23
integer y = 12
integer width = 174
integer height = 152
integer taborder = 10
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "bmp\맨앞.bmp"
string disabledname = "bmp\맨앞_.bmp"
alignment htextalign = left!
end type

event clicked;idw_source.ScrollToRow(1) 
uf_setbutton()
end event

