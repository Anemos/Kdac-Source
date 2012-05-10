$PBExportHeader$u_cmms_select_division.sru
$PBExportComments$공장 선택 - is_uo_divisioncode, is_uo_divisionname, is_uo_divisionnameeng
forward
global type u_cmms_select_division from userobject
end type
type dw_1 from datawindow within u_cmms_select_division
end type
type st_1 from statictext within u_cmms_select_division
end type
end forward

global type u_cmms_select_division from userobject
integer width = 535
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
global u_cmms_select_division u_cmms_select_division

type variables
string	is_uo_divisioncode, is_uo_divisionname, is_uo_divisionnameeng
boolean	ib_allflag
window iw_this
end variables

event ue_select();iw_This = w_frame.GetactiveSheet()
iw_this.triggerevent('ue_postopen')
end event

event ue_post_constructor();//iw_This = w_frame.GetactiveSheet()
//iw_this.triggerevent('ue_postopen')
end event

on u_cmms_select_division.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_cmms_select_division.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;dw_1.InsertRow(0)
end event

type dw_1 from datawindow within u_cmms_select_division
integer x = 169
integer width = 366
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_cmms_dddw_division"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_divisioncode
Long ll_find
DatawindowChild ldwc_1

ls_divisioncode = Data

If is_uo_divisioncode <> ls_divisioncode Then
	If ls_divisioncode = 'ALL' Then
		is_uo_divisioncode = '%'
		is_uo_divisionname = '전체'
		is_uo_divisionnameeng = 'ALL'
	Else
		is_uo_divisioncode = ls_divisioncode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("DivisionCode ='"+is_uo_divisioncode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_divisionname	 = Trim(ldwc_1.GetitemString(ll_find, 'divisionName'))
				is_uo_divisionnameeng = Trim(ldwc_1.GetitemString(ll_find, 'divisionNameEng'))
			End If
		End If
	End If
	gs_kmdivision	= is_uo_divisioncode
	f_cmms_set_server("DIVISION", gs_kmarea, is_uo_divisioncode)
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_cmms_select_division
integer y = 8
integer width = 160
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "공장:"
alignment alignment = right!
boolean focusrectangle = false
end type

