$PBExportHeader$u_piss_select_labelcustomer.sru
$PBExportComments$label용 거래처마스터 선택 - is_uo_customercode, is_uo_customername
forward
global type u_piss_select_labelcustomer from userobject
end type
type dw_1 from datawindow within u_piss_select_labelcustomer
end type
type st_1 from statictext within u_piss_select_labelcustomer
end type
end forward

global type u_piss_select_labelcustomer from userobject
integer width = 1001
integer height = 72
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_select ( )
event ue_post_constructor ( )
dw_1 dw_1
st_1 st_1
end type
global u_piss_select_labelcustomer u_piss_select_labelcustomer

type variables
string	is_uo_customercode, is_uo_customername
boolean	ib_allflag
end variables

on u_piss_select_labelcustomer.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_piss_select_labelcustomer.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

type dw_1 from datawindow within u_piss_select_labelcustomer
integer x = 261
integer width = 736
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_piss_dddw_labelcustomer"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_customercode
Long ll_find
DatawindowChild ldwc_1

ls_customercode = Data

If is_uo_customercode <> ls_customercode Then
	If ls_customercode = 'ALL' Then
		is_uo_customercode = '%'
		is_uo_customername = '전체'
		
	Else
		is_uo_customercode = ls_customercode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("customercode ='"+is_uo_customercode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_customername	 = Trim(ldwc_1.GetitemString(ll_find, 'customername'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_piss_select_labelcustomer
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
long backcolor = 67108864
string text = "거래처:"
alignment alignment = right!
boolean focusrectangle = false
end type

