$PBExportHeader$u_pism_select_area.sru
$PBExportComments$���� ���� - is_uo_areacode, is_uo_areaname
forward
global type u_pism_select_area from userobject
end type
type dw_1 from datawindow within u_pism_select_area
end type
type st_1 from statictext within u_pism_select_area
end type
end forward

global type u_pism_select_area from userobject
integer width = 475
integer height = 72
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_select ( )
event ue_post_constructor ( )
dw_1 dw_1
st_1 st_1
end type
global u_pism_select_area u_pism_select_area

type variables
string	is_uo_areacode, is_uo_areaname
boolean	ib_allflag
end variables

forward prototypes
public subroutine uf_setarea (string as_areacode)
end prototypes

event ue_post_constructor;Long ll_rowcount
Datawindowchild ldwc_1

dw_1.InsertRow(0)

If dw_1.GetChild('DDDWCode', ldwc_1) = 1 Then
	ldwc_1.SetTransObject(sqlpis)
	ldwc_1.Retrieve(g_s_empno, '%')
	ll_rowcount = ldwc_1.RowCount()
	If ll_rowcount < 1 Then
		dw_1.ReSet()
		dw_1.InsertRow(0)
		is_uo_areacode = ''
		is_uo_areaname = ''
	ElseIf ll_rowcount	= 1 Then
		is_uo_areacode	= Trim(ldwc_1.GetItemString(1, 'AreaCode'))
		is_uo_areaname	= Trim(ldwc_1.GetItemString(1, 'AreaName'))
		dw_1.Setitem(1, 'DDDWCode', is_uo_areacode)
		f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'AreaName', 10)
	ElseIf ll_rowcount > 1 Then
		If ib_allflag = False Then
			is_uo_areacode	= Trim(ldwc_1.GetItemString(1, 'AreaCode'))
			is_uo_areaname	= Trim(ldwc_1.GetItemString(1, 'AreaName'))
			dw_1.Setitem(1, 'DDDWCode', is_uo_areacode)
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'AreaName', 10)			
		Else
			dw_1.GetChild('DDDWCode', ldwc_1)
			ldwc_1.InsertRow(1)
			ldwc_1.Setitem(1, 'AreaCode', 'ALL')
			ldwc_1.Setitem(1, 'AreaName', '��ü')
			is_uo_areacode = '%'
			is_uo_areaname = '��ü'
			dw_1.Setitem(1, 'DDDWCode', 'ALL')
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'AreaName', 10)
		End If
	End If
End If
end event

public subroutine uf_setarea (string as_areacode);
dw_1.SetItem(dw_1.Getrow(), "dddwcode", as_areacode) 
end subroutine

on u_pism_select_area.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_pism_select_area.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;PostEvent("ue_post_constructor")
ib_allflag = False
end event

type dw_1 from datawindow within u_pism_select_area
integer x = 169
integer width = 302
integer height = 72
integer taborder = 10
string title = "none"
string dataobject = "d_pisc_dddw_area"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_areacode
Long ll_find
DatawindowChild ldwc_1

ls_areacode = Data

If is_uo_areacode <> ls_areacode Then
	If ls_areacode = 'ALL' Then
		is_uo_areacode = '%'
		is_uo_areaname = '��ü'
	Else
		is_uo_areacode = ls_areacode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("AreaCode ='"+is_uo_areacode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_areaname = Trim(ldwc_1.GetitemString(ll_find, 'AreaName'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_pism_select_area
integer y = 8
integer width = 160
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 12632256
string text = "����:"
alignment alignment = right!
boolean focusrectangle = false
end type

