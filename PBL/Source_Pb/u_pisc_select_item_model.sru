$PBExportHeader$u_pisc_select_item_model.sru
$PBExportComments$제품 선택(모델군에 속한) - is_uo_itemcode, is_uo_itemname
forward
global type u_pisc_select_item_model from userobject
end type
type dw_1 from datawindow within u_pisc_select_item_model
end type
type st_1 from statictext within u_pisc_select_item_model
end type
end forward

global type u_pisc_select_item_model from userobject
integer width = 869
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
global u_pisc_select_item_model u_pisc_select_item_model

type variables
string	is_uo_itemcode, is_uo_itemname
boolean	ib_allflag
end variables

on u_pisc_select_item_model.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_pisc_select_item_model.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;dw_1.InsertRow(0)
end event

type dw_1 from datawindow within u_pisc_select_item_model
event ue_keydown pbm_dwnkey
integer x = 169
integer width = 695
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_pisc_dddw_item_model"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;if key = keyenter!	then
	window ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event itemchanged;String ls_itemcode
Long ll_find
DatawindowChild ldwc_1

ls_itemcode = Data

If is_uo_itemcode <> ls_itemcode Then
	If ls_itemcode = 'ALL' Then
		is_uo_itemcode = '%'
		is_uo_itemname = '전체'
	Else
		is_uo_itemcode = ls_itemcode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("itemCode ='"+is_uo_itemcode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_itemname	 = Trim(ldwc_1.GetitemString(ll_find, 'itemName'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_pisc_select_item_model
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
string text = "품명:"
alignment alignment = right!
boolean focusrectangle = false
end type

