$PBExportHeader$u_seq_select_rackgroup.sru
$PBExportComments$랙그룹 선택 - is_uo_rackgroup, is_uo_rackgroupname
forward
global type u_seq_select_rackgroup from userobject
end type
type dw_1 from datawindow within u_seq_select_rackgroup
end type
type st_1 from statictext within u_seq_select_rackgroup
end type
end forward

global type u_seq_select_rackgroup from userobject
integer width = 923
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
global u_seq_select_rackgroup u_seq_select_rackgroup

type variables
string	is_uo_rackgroup, is_uo_rackgroupname
boolean	ib_allflag
end variables

on u_seq_select_rackgroup.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_seq_select_rackgroup.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;dw_1.InsertRow(0)
end event

type dw_1 from datawindow within u_seq_select_rackgroup
integer x = 233
integer width = 686
integer height = 68
integer taborder = 10
string dataobject = "d_seq_dddw_rackgroup"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_rackgroup
Long ll_find
DatawindowChild ldwc_1

ls_rackgroup = Data

If is_uo_rackgroup <> ls_rackgroup Then
	If ls_rackgroup = 'ALL' Then
		is_uo_rackgroup = '%'
		is_uo_rackgroupname = '전체'
	Else
		is_uo_rackgroup = ls_rackgroup
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("rackgroup ='"+is_uo_rackgroup+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_rackgroupname	 = Trim(ldwc_1.GetitemString(ll_find, 'rackgroupname'))
			End If			
		End If
	End If
	
	Parent.PostEvent("ue_select")
End If
end event
type st_1 from statictext within u_seq_select_rackgroup
integer y = 8
integer width = 238
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "랙그룹:"
alignment alignment = right!
boolean focusrectangle = false
end type

