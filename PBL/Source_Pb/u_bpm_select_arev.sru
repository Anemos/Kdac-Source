$PBExportHeader$u_bpm_select_arev.sru
$PBExportComments$order 에 대한 부품번호 가져오기
forward
global type u_bpm_select_arev from userobject
end type
type dw_1 from datawindow within u_bpm_select_arev
end type
type st_1 from statictext within u_bpm_select_arev
end type
end forward

global type u_bpm_select_arev from userobject
integer width = 887
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
global u_bpm_select_arev u_bpm_select_arev

type variables
string	is_uo_revno, is_uo_refyear
boolean	ib_allflag
end variables

event ue_post_constructor();Long ll_rowcount
Datawindowchild ldwc_1

dw_1.InsertRow(0)

dw_1.GetChild('DDDWCode', ldwc_1)
ldwc_1.InsertRow(1)
ldwc_1.Setitem(1, 'revno', 'ALL')
ldwc_1.Setitem(1, 'ref_year', '전체')
ldwc_1.Setitem(1, 'DisplayName', '전체')
is_uo_revno = '%'
is_uo_refyear = '전체'
dw_1.Setitem(1, 'DDDWCode', 'ALL')


end event

on u_bpm_select_arev.create
this.dw_1=create dw_1
this.st_1=create st_1
this.Control[]={this.dw_1,&
this.st_1}
end on

on u_bpm_select_arev.destroy
destroy(this.dw_1)
destroy(this.st_1)
end on

event constructor;PostEvent("ue_post_constructor")
ib_allflag = True
end event

type dw_1 from datawindow within u_bpm_select_arev
integer x = 416
integer width = 448
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_bpm_dddw_arev"
boolean border = false
boolean livescroll = true
end type

event itemchanged;String ls_partno
Long ll_find
DatawindowChild ldwc_1

ls_partno = Data

If is_uo_revno <> ls_partno Then
	If ls_partno = 'ALL' Then
		is_uo_revno = '%'
		is_uo_refyear = '전체'
	Else
		is_uo_revno = ls_partno
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("revno ='"+is_uo_revno+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_refyear	 = Trim(ldwc_1.GetitemString(ll_find, 'ref_year'))
			End If
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

type st_1 from statictext within u_bpm_select_arev
integer x = 23
integer y = 8
integer width = 370
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "Rev No :"
alignment alignment = right!
boolean focusrectangle = false
end type

