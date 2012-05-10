$PBExportHeader$u_piss_select_custcode.sru
$PBExportComments$거래처마스터 선택 - is_uo_custcode, is_uo_custname
forward
global type u_piss_select_custcode from userobject
end type
type dw_1 from datawindow within u_piss_select_custcode
end type
type st_1 from statictext within u_piss_select_custcode
end type
end forward

global type u_piss_select_custcode from userobject
integer width = 1001
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
global u_piss_select_custcode u_piss_select_custcode

type variables
string	is_uo_custcode, is_uo_custname
boolean	ib_allflag
end variables

on u_piss_select_custcode.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_piss_select_custcode.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

type dw_1 from datawindow within u_piss_select_custcode
integer x = 261
integer width = 736
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_piss_dddw_custcode"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_custcode
Long ll_find
DatawindowChild ldwc_1

ls_custcode = Data

If is_uo_custcode <> ls_custcode Then
	If ls_custcode = 'ALL' Then
		is_uo_custcode = '%'
		is_uo_custname = '전체'
		
	Else
		is_uo_custcode = ls_custcode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("custcode ='"+is_uo_custcode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_custname	 = Trim(ldwc_1.GetitemString(ll_find, 'custName'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_piss_select_custcode
integer y = 8
integer width = 256
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "거래처:"
alignment alignment = right!
boolean focusrectangle = false
end type

