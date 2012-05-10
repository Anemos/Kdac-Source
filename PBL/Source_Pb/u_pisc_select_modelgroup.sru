$PBExportHeader$u_pisc_select_modelgroup.sru
$PBExportComments$¸ðµ¨±º ¼±ÅÃ - is_uo_modelgroup, is_uo_modelgroupname
forward
global type u_pisc_select_modelgroup from userobject
end type
type dw_1 from datawindow within u_pisc_select_modelgroup
end type
type st_1 from statictext within u_pisc_select_modelgroup
end type
end forward

global type u_pisc_select_modelgroup from userobject
integer width = 891
integer height = 72
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_select ( )
event ue_post_constructor ( )
event ue_keydown pbm_keydown
dw_1 dw_1
st_1 st_1
end type
global u_pisc_select_modelgroup u_pisc_select_modelgroup

type variables
string	is_uo_modelgroup, is_uo_modelgroupname
boolean	ib_allflag
end variables

on u_pisc_select_modelgroup.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_pisc_select_modelgroup.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;dw_1.InsertRow(0)
end event

type dw_1 from datawindow within u_pisc_select_modelgroup
event ue_keydown pbm_dwnkey
integer x = 233
integer width = 658
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_pisc_dddw_modelgroup"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;if key = keyenter!	then
	window ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event itemchanged;String ls_modelgroup
Long ll_find
DatawindowChild ldwc_1

ls_modelgroup = Data

If is_uo_modelgroup <> ls_modelgroup Then
	If ls_modelgroup = 'ALL' Then
		is_uo_modelgroup = '%'
		is_uo_modelgroupname = 'ÀüÃ¼'
	Else
		is_uo_modelgroup = ls_modelgroup
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("modelgroup ='"+is_uo_modelgroup+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_modelgroupname	 = Trim(ldwc_1.GetitemString(ll_find, 'modelgroupName'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_pisc_select_modelgroup
integer y = 8
integer width = 224
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 8388608
long backcolor = 12632256
string text = "¸ðµ¨±º:"
alignment alignment = right!
boolean focusrectangle = false
end type

