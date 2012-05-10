$PBExportHeader$u_tmm_select_tmgubun.sru
$PBExportComments$시험/측정 구분 가져오기
forward
global type u_tmm_select_tmgubun from userobject
end type
type dw_1 from datawindow within u_tmm_select_tmgubun
end type
type st_1 from statictext within u_tmm_select_tmgubun
end type
end forward

global type u_tmm_select_tmgubun from userobject
integer width = 832
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
global u_tmm_select_tmgubun u_tmm_select_tmgubun

type variables
string	is_uo_cocode, is_uo_coname
boolean	ib_allflag
end variables

forward prototypes
public subroutine wf_select_item (string ag_tmgubun)
end prototypes

event ue_post_constructor();Long ll_rowcount
Datawindowchild ldwc_1

dw_1.InsertRow(0)

If dw_1.GetChild('DDDWCode', ldwc_1) = 1 Then
	ldwc_1.SetTransObject(sqlca)
	ldwc_1.Retrieve('TMM001')
	ll_rowcount = ldwc_1.RowCount()
	If ll_rowcount < 1 Then
		dw_1.ReSet()
		dw_1.InsertRow(0)
		is_uo_cocode = ''
		is_uo_coname = ''
	ElseIf ll_rowcount	= 1 Then
		If ib_allflag = False Then
			is_uo_cocode	= Trim(ldwc_1.GetItemString(1, 'CoCode'))
			is_uo_coname	= Trim(ldwc_1.GetItemString(1, 'CodeName'))
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'CodeName', 10)
		Else
			dw_1.GetChild('DDDWCode', ldwc_1)
			ldwc_1.InsertRow(1)
			ldwc_1.Setitem(1, 'CoCode', 'ALL')
			ldwc_1.Setitem(1, 'CodeName', '전체')
			ldwc_1.Setitem(1, 'DisplayName', '전체')
			is_uo_cocode = '%'
			is_uo_coname = '전체'
			dw_1.Setitem(1, 'DDDWCode', 'ALL')
		End if
	ElseIf ll_rowcount > 1 Then
		If ib_allflag = False Then
			is_uo_cocode	= Trim(ldwc_1.GetItemString(1, 'CoCode'))
			is_uo_coname	= Trim(ldwc_1.GetItemString(1, 'CodeName'))
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'CodeName', 10)			
		Else
			dw_1.GetChild('DDDWCode', ldwc_1)
			ldwc_1.InsertRow(1)
			ldwc_1.Setitem(1, 'CoCode', 'ALL')
			ldwc_1.Setitem(1, 'CodeName', '전체')
			ldwc_1.Setitem(1, 'DisplayName', '전체')
			is_uo_cocode = '%'
			is_uo_coname = '전체'
			dw_1.Setitem(1, 'DDDWCode', 'ALL')
			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'CodeName', 10)
		End If
	End If
End If
end event

public subroutine wf_select_item (string ag_tmgubun);String ls_cocode
Long ll_find
DatawindowChild ldwc_1

If is_uo_cocode <> ag_tmgubun Then
	is_uo_cocode = ag_tmgubun
	If dw_1.GetChild('DDDWCode', ldwc_1) = 1 Then
		ll_find = ldwc_1.Find("CoCode ='"+is_uo_cocode+"'", 1, ldwc_1.RowCount())
		If ll_find > 0 Then
			is_uo_coname	 = Trim(ldwc_1.GetitemString(ll_find, 'codename'))
		End If
		ldwc_1.Selectrow( 0, False )
		ldwc_1.selectrow(ll_find,true)
		ldwc_1.scrolltorow(ll_find)
		ldwc_1.setrow(ll_find)
		dw_1.Setitem(1, 'DDDWCode', is_uo_cocode)
	End If
End If
end subroutine

on u_tmm_select_tmgubun.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_tmm_select_tmgubun.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;PostEvent("ue_post_constructor")
ib_allflag = True
end event

type dw_1 from datawindow within u_tmm_select_tmgubun
integer x = 370
integer y = 4
integer width = 443
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_tmm_dddw_tmgubun"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_cocode
Long ll_find
DatawindowChild ldwc_1

ls_cocode = Data

If is_uo_cocode <> ls_cocode Then
	If ls_cocode = 'ALL' Then
		is_uo_cocode = '%'
		is_uo_coname = '전체'
	Else
		is_uo_cocode = ls_cocode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("CoCode ='"+is_uo_cocode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_coname	 = Trim(ldwc_1.GetitemString(ll_find, 'codename'))
			End If
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_tmm_select_tmgubun
integer x = 14
integer y = 12
integer width = 357
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "시/측구분:"
boolean focusrectangle = false
end type

