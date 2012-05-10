$PBExportHeader$u_piss_select_labelgubun.sru
$PBExportComments$출하 Shipping 라벨 종류
forward
global type u_piss_select_labelgubun from userobject
end type
type dw_1 from datawindow within u_piss_select_labelgubun
end type
type st_1 from statictext within u_piss_select_labelgubun
end type
end forward

global type u_piss_select_labelgubun from userobject
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
global u_piss_select_labelgubun u_piss_select_labelgubun

type variables
string	is_uo_labelcode, is_uo_labelname
boolean	ib_allflag
end variables

on u_piss_select_labelgubun.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_piss_select_labelgubun.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;is_uo_labelcode = '%'
is_uo_labelname = '전체'
end event
type dw_1 from datawindow within u_piss_select_labelgubun
integer x = 320
integer width = 658
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_piss_dddw_labelgubun"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_labelcode
Long ll_find
DatawindowChild ldwc_1

ls_labelcode = Data

If is_uo_labelcode <> ls_labelcode Then
	If ls_labelcode = 'ALL' Then
		is_uo_labelcode = '%'
		is_uo_labelname = '전체'
		
	Else
		is_uo_labelcode = ls_labelcode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("labelcode ='"+is_uo_labelcode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_labelname	 = Trim(ldwc_1.GetitemString(ll_find, 'labelname'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_piss_select_labelgubun
integer y = 8
integer width = 302
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "라벨구분:"
alignment alignment = right!
boolean focusrectangle = false
end type

