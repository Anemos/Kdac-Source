$PBExportHeader$u_mpms_select_orderno.sru
$PBExportComments$order 선택 - 완료상태가 아닌 Order
forward
global type u_mpms_select_orderno from userobject
end type
type pb_1 from picturebutton within u_mpms_select_orderno
end type
type dw_1 from datawindow within u_mpms_select_orderno
end type
type st_1 from statictext within u_mpms_select_orderno
end type
end forward

global type u_mpms_select_orderno from userobject
integer width = 1129
integer height = 112
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_select ( )
event ue_post_constructor ( )
pb_1 pb_1
dw_1 dw_1
st_1 st_1
end type
global u_mpms_select_orderno u_mpms_select_orderno

type variables
// is_option '1' : 진행중, '2' : 제작완료, '3' : 불량발생
string	is_uo_orderno, is_option, is_uo_toolname
boolean	ib_allflag
end variables

event ue_post_constructor();Long ll_rowcount
Datawindowchild ldwc_1

dw_1.InsertRow(0)

If dw_1.GetChild('DDDWCode', ldwc_1) = 1 Then
	ldwc_1.SetTransObject(sqlmpms)
	ldwc_1.Retrieve(is_option)
	ll_rowcount = ldwc_1.RowCount()
	If ll_rowcount < 1 Then
		dw_1.ReSet()
		dw_1.InsertRow(0)
		is_uo_orderno = ''
		is_uo_toolname = ''
	ElseIf ll_rowcount	= 1 Then
		If ib_allflag = False Then
			is_uo_orderno	= Trim(ldwc_1.GetItemString(1, 'OrderNo'))
			is_uo_toolname	= Trim(ldwc_1.GetItemString(1, 'ToolName'))
	//		dw_1.Setitem(1, 'DDDWCode', is_uo_orderno)
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'ToolName', 10)
		Else
			dw_1.GetChild('DDDWCode', ldwc_1)
			ldwc_1.InsertRow(1)
			ldwc_1.Setitem(1, 'OrderNo', 'ALL')
			ldwc_1.Setitem(1, 'ToolName', '전체')
			ldwc_1.Setitem(1, 'DisplayName', '전체')
			is_uo_orderno = '%'
			is_uo_toolname = '전체'
			dw_1.Setitem(1, 'DDDWCode', 'ALL')
		End if
	ElseIf ll_rowcount > 1 Then
		If ib_allflag = False Then
			is_uo_orderno	= Trim(ldwc_1.GetItemString(1, 'OrderNo'))
			is_uo_toolname	= Trim(ldwc_1.GetItemString(1, 'ToolName'))
//			dw_1.Setitem(1, 'DDDWCode', is_uo_orderno)
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'ToolName', 10)			
		Else
			dw_1.GetChild('DDDWCode', ldwc_1)
			ldwc_1.InsertRow(1)
			ldwc_1.Setitem(1, 'OrderNo', 'ALL')
			ldwc_1.Setitem(1, 'ToolName', '전체')
			ldwc_1.Setitem(1, 'DisplayName', '전체')
			is_uo_orderno = '%'
			is_uo_toolname = '전체'
			dw_1.Setitem(1, 'DDDWCode', 'ALL')
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'ToolName', 10)
		End If
	End If
End If
end event

on u_mpms_select_orderno.create
this.pb_1=create pb_1
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.pb_1,&
this.dw_1,&
this.st_1}
end on

on u_mpms_select_orderno.destroy
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;is_option = '1'
ib_allflag = True
PostEvent("ue_post_constructor")
end event

type pb_1 from picturebutton within u_mpms_select_orderno
integer x = 869
integer width = 238
integer height = 108
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;dw_1.triggerevent('doubleclicked')
end event

type dw_1 from datawindow within u_mpms_select_orderno
integer x = 402
integer y = 20
integer width = 439
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_mpms_dddw_orderno"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_uo_orderno = Data

Parent.PostEvent("ue_select")

end event

event doubleclicked;string ls_parm
datawindowchild ldwc_1
long li_findrow

Openwithparm( w_mpms_find_orderno, ' ')
ls_parm = message.stringparm

if f_spacechk( ls_parm ) <> -1 then
	is_uo_orderno = mid(ls_parm,1,8)
	This.GetChild('DDDWCode', ldwc_1)
	li_findrow = ldwc_1.find("orderno = '" + is_uo_orderno + "'", 1, ldwc_1.rowcount())
	if li_findrow > 0 then
		ldwc_1.scrolltorow(li_findrow)
		ldwc_1.Selectrow( 0, False )
		ldwc_1.Selectrow( li_findrow, True )
		ldwc_1.setrow(li_findrow)
	else
		li_findrow = ldwc_1.insertrow(0)
		ldwc_1.setitem(li_findrow,'orderno',mid(ls_parm,1,8))
		ldwc_1.setitem(li_findrow,'toolname',mid(ls_parm,9))
		ldwc_1.scrolltorow(li_findrow)
		ldwc_1.Selectrow( 0, False )
		ldwc_1.Selectrow( li_findrow, True )
		ldwc_1.setrow(li_findrow)
	end if
	This.setitem(1, "dddwcode", is_uo_orderno)
	Parent.PostEvent("ue_select")
end if

return 0
end event

type st_1 from statictext within u_mpms_select_orderno
integer x = 9
integer y = 28
integer width = 379
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "Order No:"
alignment alignment = right!
boolean focusrectangle = false
end type

