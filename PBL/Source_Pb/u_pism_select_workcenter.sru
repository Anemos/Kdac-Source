$PBExportHeader$u_pism_select_workcenter.sru
$PBExportComments$조 선택 - is_uo_workcenter, is_uo_workcentername
forward
global type u_pism_select_workcenter from userobject
end type
type dw_1 from datawindow within u_pism_select_workcenter
end type
type st_1 from statictext within u_pism_select_workcenter
end type
end forward

global type u_pism_select_workcenter from userobject
integer width = 1143
integer height = 96
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_select ( )
event ue_post_constructor ( )
dw_1 dw_1
st_1 st_1
end type
global u_pism_select_workcenter u_pism_select_workcenter

type variables
string	is_uo_workcenter, is_uo_workcentername
boolean	ib_allflag
end variables

forward prototypes
public function string us_setfilter (string as_filter)
public subroutine uf_dispexcworkcenter (boolean ab_dispchk)
public subroutine uf_setworkcenter (string as_area, string as_div, string as_wc)
end prototypes

public function string us_setfilter (string as_filter);DataWindowChild ldwc 
String ls_wc, ls_filter 
Long ll_find 

If dw_1.GetChild('dddwcode', ldwc) = -1 Then Return '' 
ls_filter =  "if( isnull( workcentergubun2 ), '',  workcentergubun2 ) <> ''"
If as_filter <> '' Then ls_filter += " And "

ls_filter += as_filter 
ldwc.SetFilter(ls_filter); ldwc.Filter(); ldwc.Sort() 

If ldwc.Rowcount() > 0 Then ls_wc = ldwc.GetItemString(1, "workcenter") 
If ls_wc <> '' Then 
	is_uo_workcenter = ls_wc
	ll_find = ldwc.Find("workcenter ='"+is_uo_workcenter+"'", 1, ldwc.RowCount())
	If ll_find > 0 Then is_uo_workcentername	 = Trim(ldwc.GetitemString(ll_find, 'workcenterName'))
End If

Return ls_wc 
end function

public subroutine uf_dispexcworkcenter (boolean ab_dispchk);DataWindowChild ldwc 

If dw_1.GetChild('dddwcode', ldwc) = -1 Then Return 

If ab_dispchk Then 	// 간접조 포함 
	ldwc.SetFilter(""); ldwc.Filter() 
Else						// 직접조 만 
	// DataWindow 내에 직접조만 Filter된 상태 
End If 
end subroutine

public subroutine uf_setworkcenter (string as_area, string as_div, string as_wc);DataWindowChild ldwc 
Long ll_find 

dw_1.SetItem(dw_1.GetRow(), "dddwcode", as_wc) 

is_uo_workcenter = as_wc 

If dw_1.GetChild('DDDWCode', ldwc) = 1 Then
	ll_find = ldwc.Find("workcenter ='"+is_uo_workcenter+"'", 1, ldwc.RowCount())
	If ll_find > 0 Then
		is_uo_workcentername	 = Trim(ldwc.GetitemString(ll_find, 'workcenterName'))
	End If			
End If

end subroutine

on u_pism_select_workcenter.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_pism_select_workcenter.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;dw_1.InsertRow(0)
end event

type dw_1 from datawindow within u_pism_select_workcenter
integer x = 142
integer width = 928
integer height = 80
integer taborder = 10
string title = "none"
string dataobject = "d_pism_dddw_workcenter"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_workcenter
Long ll_find
DatawindowChild ldwc_1

ls_workcenter = Data

If is_uo_workcenter <> ls_workcenter Then
	If ls_workcenter = 'ALL' Then
		is_uo_workcenter = '%'
		is_uo_workcentername = '전체'
	Else
		is_uo_workcenter = ls_workcenter
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("workcenter ='"+is_uo_workcenter+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_workcentername	 = Trim(ldwc_1.GetitemString(ll_find, 'workcenterName'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_pism_select_workcenter
integer x = 5
integer y = 16
integer width = 128
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "조:"
boolean focusrectangle = false
end type

