$PBExportHeader$u_pisc_select_line.sru
$PBExportComments$라인 선택 - is_uo_linecode, is_uo_linename
forward
global type u_pisc_select_line from userobject
end type
type dw_1 from datawindow within u_pisc_select_line
end type
type st_1 from statictext within u_pisc_select_line
end type
end forward

global type u_pisc_select_line from userobject
integer width = 539
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
global u_pisc_select_line u_pisc_select_line

type variables
string	is_uo_linecode, is_uo_lineshortname, is_uo_linefullname
boolean	ib_allflag
end variables

on u_pisc_select_line.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_pisc_select_line.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;dw_1.InsertRow(0)
end event

type dw_1 from datawindow within u_pisc_select_line
event ue_keydown pbm_dwnkey
integer x = 169
integer width = 366
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_pisc_dddw_line"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;if key = keyenter!	then
	window ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event itemchanged;String ls_linecode
Long ll_find
DatawindowChild ldwc_1

ls_linecode = Data

If is_uo_linecode <> ls_linecode Then
	If ls_linecode = 'ALL' Then
		is_uo_linecode = '%'
		is_uo_lineshortname = '전체'
		is_uo_linefullname = '전체'		
	Else
		is_uo_linecode = ls_linecode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("lineCode ='"+is_uo_linecode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_lineshortname	= Trim(ldwc_1.GetitemString(ll_find, 'lineshortName'))
				is_uo_linefullname 	= Trim(ldwc_1.GetitemString(ll_find, 'linefullName'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_pisc_select_line
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
string text = "라인:"
alignment alignment = right!
boolean focusrectangle = false
end type

