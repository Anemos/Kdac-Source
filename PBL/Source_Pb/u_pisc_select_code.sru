$PBExportHeader$u_pisc_select_code.sru
$PBExportComments$코드마스터 선택 - is_uo_codegroup, is_uo_codeid, is_uo_codegroupname, is_uo_codename
forward
global type u_pisc_select_code from userobject
end type
type dw_1 from datawindow within u_pisc_select_code
end type
end forward

global type u_pisc_select_code from userobject
integer width = 699
integer height = 72
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_select ( )
event ue_post_constructor ( )
event ue_keydown pbm_keydown
dw_1 dw_1
end type
global u_pisc_select_code u_pisc_select_code

type variables
string	is_uo_codegroup, is_uo_codeid, is_uo_codegroupname, is_uo_codename
boolean	ib_allflag
end variables

on u_pisc_select_code.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on u_pisc_select_code.destroy
destroy(this.dw_1)
end on

event constructor;dw_1.InsertRow(0)
end event

type dw_1 from datawindow within u_pisc_select_code
event ue_keydown pbm_dwnkey
integer width = 699
integer height = 64
integer taborder = 10
string title = "none"
string dataobject = "d_pisc_dddw_code"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;if key = keyenter!	then
	window ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event itemchanged;String ls_codeid
Long ll_find
DatawindowChild ldwc_1

ls_codeid = Data

If is_uo_codeid <> ls_codeid Then
	If ls_codeid = 'ALL' Then
		is_uo_codeid = '%'
		is_uo_codename = '전체'
	Else
		is_uo_codeid = ls_codeid
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("CodeID ='"+is_uo_codeid+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_codegroup		= Trim(ldwc_1.GetitemString(ll_find, 'CodeGroup'))
				is_uo_codegroupname	= Trim(ldwc_1.GetitemString(ll_find, 'CodeGroupName'))
				is_uo_codename			= Trim(ldwc_1.GetitemString(ll_find, 'CodeName'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

