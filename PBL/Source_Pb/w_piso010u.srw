$PBExportHeader$w_piso010u.srw
$PBExportComments$����������
forward
global type w_piso010u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_piso010u
end type
type uo_area from u_pisc_select_area within w_piso010u
end type
type dw_detail from datawindow within w_piso010u
end type
type st_h_bar from uo_xc_splitbar within w_piso010u
end type
type gb_3 from groupbox within w_piso010u
end type
end forward

global type w_piso010u from w_ipis_sheet01
integer width = 4110
string title = ""
dw_1 dw_1
uo_area uo_area
dw_detail dw_detail
st_h_bar st_h_bar
gb_3 gb_3
end type
global w_piso010u w_piso010u

type variables
Boolean	ib_open
end variables

on w_piso010u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.dw_detail
this.Control[iCurrent+4]=this.st_h_bar
this.Control[iCurrent+5]=this.gb_3
end on

on w_piso010u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.gb_3)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_detail, BELOW)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
										
ib_open = True
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_area.is_uo_areacode) > 0 Then
	uo_status.st_message.text =  "���������� ����" //+ f_message("����� ����Ÿ�� �����ϴ�.")
Else
	uo_status.st_message.text =  "���������� ������ �������� �ʽ��ϴ�" //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("����������", "���������� ������ �������� �ʽ��ϴ�")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piso010u
end type

type dw_1 from u_vi_std_datawindow within w_piso010u
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 184
integer width = 645
integer height = 1772
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_piso010u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;//

end event

event rowfocuschanged;String	ls_areacode

If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
	dw_detail.ReSet()
	dw_detail.Retrieve(ls_areacode)
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_piso010u
integer x = 46
integer y = 68
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_detail from datawindow within w_piso010u
integer x = 965
integer y = 700
integer width = 1947
integer height = 724
boolean bringtotop = true
string title = "none"
string dataobject = "d_piso010u_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_piso010u
integer x = 905
integer y = 1520
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type gb_3 from groupbox within w_piso010u
integer x = 14
integer width = 544
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

