$PBExportHeader$u_mpms_select_wccode.sru
$PBExportComments$W/C 가져오기
forward
global type u_mpms_select_wccode from userobject
end type
type dw_1 from datawindow within u_mpms_select_wccode
end type
type st_1 from statictext within u_mpms_select_wccode
end type
end forward

global type u_mpms_select_wccode from userobject
integer width = 704
integer height = 100
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_select ( )
event ue_post_constructor ( )
dw_1 dw_1
st_1 st_1
end type
global u_mpms_select_wccode u_mpms_select_wccode

type variables
string	is_uo_wccode, is_uo_wcname
boolean	ib_allflag
end variables

event ue_post_constructor();Long ll_rowcount
Datawindowchild ldwc_1

dw_1.InsertRow(0)

If dw_1.GetChild('DDDWCode', ldwc_1) = 1 Then
	ldwc_1.SetTransObject(sqlmpms)
	ldwc_1.Retrieve()
	ll_rowcount = ldwc_1.RowCount()
	If ll_rowcount < 1 Then
		dw_1.ReSet()
		dw_1.InsertRow(0)
		is_uo_wccode = ''
		is_uo_wcname = ''
	ElseIf ll_rowcount	= 1 Then
		If ib_allflag = False Then
			is_uo_wccode	= Trim(ldwc_1.GetItemString(1, 'WcCode'))
			is_uo_wcname	= Trim(ldwc_1.GetItemString(1, 'WcName'))
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'WcName', 10)
		Else
			dw_1.GetChild('DDDWCode', ldwc_1)
			ldwc_1.InsertRow(1)
			ldwc_1.Setitem(1, 'WcCode', 'ALL')
			ldwc_1.Setitem(1, 'WcName', '전체')
			ldwc_1.Setitem(1, 'DisplayName', '전체')
			is_uo_wccode = '%'
			is_uo_wcname = '전체'
			dw_1.Setitem(1, 'DDDWCode', 'ALL')
		End if
	ElseIf ll_rowcount > 1 Then
		If ib_allflag = False Then
			is_uo_wccode	= Trim(ldwc_1.GetItemString(1, 'WcCode'))
			is_uo_wcname	= Trim(ldwc_1.GetItemString(1, 'WcName'))
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'WcName', 10)			
		Else
			dw_1.GetChild('DDDWCode', ldwc_1)
			ldwc_1.InsertRow(1)
			ldwc_1.Setitem(1, 'WcCode', 'ALL')
			ldwc_1.Setitem(1, 'WcName', '전체')
			ldwc_1.Setitem(1, 'DisplayName', '전체')
			is_uo_wccode = '%'
			is_uo_wcname = '전체'
			dw_1.Setitem(1, 'DDDWCode', 'ALL')
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'WcName', 10)
		End If
	End If
End If
end event

on u_mpms_select_wccode.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_mpms_select_wccode.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;PostEvent("ue_post_constructor")
ib_allflag = True
end event

type dw_1 from datawindow within u_mpms_select_wccode
integer x = 238
integer width = 448
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_mpms_dddw_workcenter"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_wccode
Long ll_find
DatawindowChild ldwc_1

ls_wccode = Data

If is_uo_wccode <> ls_wccode Then
	If ls_wccode = 'ALL' Then
		is_uo_wccode = '%'
		is_uo_wcname = '전체'
	Else
		is_uo_wccode = ls_wccode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("WcCode ='"+is_uo_wccode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_wcname	 = Trim(ldwc_1.GetitemString(ll_find, 'wcname'))
			End If
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_mpms_select_wccode
integer x = 9
integer y = 8
integer width = 229
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "W/C :"
alignment alignment = right!
boolean focusrectangle = false
end type

