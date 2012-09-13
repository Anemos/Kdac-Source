$PBExportHeader$u_pisc_select_shift_1.sru
$PBExportComments$주/야 선택 - is_uo_shiftcode, is_uo_shiftname
forward
global type u_pisc_select_shift_1 from userobject
end type
type dw_1 from datawindow within u_pisc_select_shift_1
end type
end forward

global type u_pisc_select_shift_1 from userobject
integer width = 242
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
global u_pisc_select_shift_1 u_pisc_select_shift_1

type variables
string	is_uo_shiftcode, is_uo_shiftname
boolean	ib_allflag
end variables

event ue_post_constructor;//Long ll_rowcount
//Datawindowchild ldwc_1
//
//dw_1.InsertRow(0)
//
//If dw_1.GetChild('DDDWCode', ldwc_1) = 1 Then
//	ldwc_1.SetTransObject(sqlpis)
//	ldwc_1.Retrieve(g_s_empno, '%')
//	ll_rowcount = ldwc_1.RowCount()
//	If ll_rowcount < 1 Then
//		dw_1.ReSet()
//		dw_1.InsertRow(0)
//		is_uo_shiftcode = ''
//		is_uo_shiftname = ''
//	ElseIf ll_rowcount	= 1 Then
//		is_uo_shiftcode	= Trim(ldwc_1.GetItemString(1, 'ShiftCode'))
//		is_uo_shiftname	= Trim(ldwc_1.GetItemString(1, 'ShiftName'))
//		dw_1.Setitem(1, 'DDDWCode', is_uo_shiftcode)
//		f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'ShiftName', 10)
//	ElseIf ll_rowcount > 1 Then
//		If ib_allflag = False Then
//			is_uo_shiftcode	= Trim(ldwc_1.GetItemString(1, 'ShiftCode'))
//			is_uo_shiftname	= Trim(ldwc_1.GetItemString(1, 'ShiftName'))
//			dw_1.Setitem(1, 'DDDWCode', is_uo_shiftcode)
//			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'ShiftName', 10)			
//		Else
//			dw_1.GetChild('DDDWCode', ldwc_1)
//			ldwc_1.InsertRow(1)
//			ldwc_1.Setitem(1, 'ShiftCode', 'ALL')
//			ldwc_1.Setitem(1, 'ShiftName', '전체')
//			is_uo_shiftcode = '%'
//			is_uo_shiftname = '전체'
//			dw_1.Setitem(1, 'DDDWCode', 'ALL')
//			f_pisc_set_dddw_width(dw_1, 'DDDWCode', ldwc_1, 'ShiftName', 10)
//		End If
//	End If
//End If
end event

on u_pisc_select_shift_1.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on u_pisc_select_shift_1.destroy
destroy(this.dw_1)
end on

event constructor;//PostEvent("ue_post_constructor")
//ib_allflag = False

dw_1.InsertRow(0)
end event

type dw_1 from datawindow within u_pisc_select_shift_1
event ue_keydown pbm_dwnkey
integer width = 242
integer height = 68
integer taborder = 10
string title = "none"
string dataobject = "d_pisc_dddw_shift"
boolean border = false
boolean livescroll = true
end type

event ue_keydown;if key = keyenter!	then
	window ls_wsheet
	ls_wsheet = w_frame.GetActiveSheet()
	ls_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event itemchanged;String ls_shiftcode
Long ll_find
DatawindowChild ldwc_1

ls_shiftcode = Data

If is_uo_shiftcode <> ls_shiftcode Then
	If ls_shiftcode = 'ALL' Then
		is_uo_shiftcode = '%'
		is_uo_shiftname = '전체'
	Else
		is_uo_shiftcode = ls_shiftcode
		If GetChild('DDDWCode', ldwc_1) = 1 Then
			ll_find = ldwc_1.Find("ShiftCode ='"+is_uo_shiftcode+"'", 1, ldwc_1.RowCount())
			If ll_find > 0 Then
				is_uo_shiftname = Trim(ldwc_1.GetitemString(ll_find, 'ShiftName'))
			End If			
		End If
	End If
	Parent.PostEvent("ue_select")
End If
end event

