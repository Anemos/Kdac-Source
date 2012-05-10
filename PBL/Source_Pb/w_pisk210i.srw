$PBExportHeader$w_pisk210i.srw
$PBExportComments$������Ȳ
forward
global type w_pisk210i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisk210i
end type
type uo_area from u_pisc_select_area within w_pisk210i
end type
type uo_division from u_pisc_select_division within w_pisk210i
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisk210i
end type
type uo_line from u_pisc_select_line within w_pisk210i
end type
type dw_detail from datawindow within w_pisk210i
end type
type st_h_bar from uo_xc_splitbar within w_pisk210i
end type
type gb_1 from groupbox within w_pisk210i
end type
type gb_2 from groupbox within w_pisk210i
end type
type uo_fromdate from u_pisc_date_firstday within w_pisk210i
end type
type gb_3 from groupbox within w_pisk210i
end type
type uo_todate from u_pisc_date_applydate_1 within w_pisk210i
end type
type dw_print from datawindow within w_pisk210i
end type
end forward

global type w_pisk210i from w_ipis_sheet01
integer width = 4110
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
dw_detail dw_detail
st_h_bar st_h_bar
gb_1 gb_1
gb_2 gb_2
uo_fromdate uo_fromdate
gb_3 gb_3
uo_todate uo_todate
dw_print dw_print
end type
global w_pisk210i w_pisk210i

type variables
Boolean	ib_open
end variables

on w_pisk210i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.dw_detail=create dw_detail
this.st_h_bar=create st_h_bar
this.gb_1=create gb_1
this.gb_2=create gb_2
this.uo_fromdate=create uo_fromdate
this.gb_3=create gb_3
this.uo_todate=create uo_todate
this.dw_print=create dw_print
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.st_h_bar
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.uo_fromdate
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.uo_todate
this.Control[iCurrent+13]=this.dw_print
end on

on w_pisk210i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.dw_detail)
destroy(this.st_h_bar)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.uo_fromdate)
destroy(this.gb_3)
destroy(this.uo_todate)
destroy(this.dw_print)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_detail, BELOW)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)

dw_print.SetTransObject(SQLPIS)

dw_1.ShareData(dw_print)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										False, &
										uo_division.is_uo_divisioncode, &
										uo_division.is_uo_divisionname, &
										uo_division.is_uo_divisionnameeng)
										
f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'%', &
										True, &
										uo_workcenter.is_uo_workcenter, &
										uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_line.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										True, &
										uo_line.is_uo_linecode, &
										uo_line.is_uo_lineshortname, &
										uo_line.is_uo_linefullname)
										
ib_open = True
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_fromdate.is_uo_date, 			uo_todate.is_uo_date, &
						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
						'%') > 0 Then
	uo_status.st_message.text =  "���� ��Ȳ ����" //+ f_message("����� ����Ÿ�� �����ϴ�.")
Else
	uo_status.st_message.text =  "���� ��Ȳ ������ �������� �ʽ��ϴ�" //+ f_message("����� ����Ÿ�� �����ϴ�.")
	MessageBox("���� ��Ȳ", "���� ��Ȳ ������ �������� �ʽ��ϴ�")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_detail.ReSet()
dw_print.ReSet()
end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_detail.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
end event

event ue_print;call super::ue_print;String	ls_mod, ls_date
str_easy	lstr_prt

ls_date	= "������ : " + uo_fromdate.is_uo_date + ' - ' + uo_todate.is_uo_date

ls_mod	= "st_msg.Text = '" + ls_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '������Ȳ'
lstr_prt.tag			= '������Ȳ'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

type uo_status from w_ipis_sheet01`uo_status within w_pisk210i
end type

type dw_1 from u_vi_std_datawindow within w_pisk210i
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 184
integer width = 645
integer height = 1496
integer taborder = 10
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisk210i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_vscroll;//// DataWindow Event_ID pbm_vscroll 
//
//Long ll_scrollPos, ll_detail
//String ls_Row, ls_vScrollPos, ls_Chk 
//
////ll_header		= Long(Describe("DataWindow.Header.Height"))
//ll_detail		= Long(Describe("DataWindow.Detail.Height"))
//
//If scrollcode = 0 Then 		// �� 
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> �ణ���� 
//	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//
//	Return 1 
//ElseIf scrollcode = 1 Then 	// ��
//	
//	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
//	ll_scrollPos = Long(ls_vScrollPos) + ll_detail 
//	
//	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
//	If ls_Chk <> '' Then MessageBox("", ls_Chk)
//	Return 1 
//End If 
//
end event

event clicked;//

end event

event rowfocuschanged;String	ls_prddate, ls_areacode, ls_divisioncode, ls_workcenter, ls_linecode, &
			ls_itemcode

If GetRow() > 0 Then
	SelectRow(0, False)
	SelectRow(CurrentRow, True)
	ls_prddate			= Trim(GetItemString(CurrentRow, "PrdDate"))
	ls_areacode			= Trim(GetItemString(CurrentRow, "AreaCode"))
	ls_divisioncode	= Trim(GetItemString(CurrentRow, "DivisionCode"))
	ls_workcenter		= Trim(GetItemString(CurrentRow, "WorkCenter"))
	ls_linecode			= Trim(GetItemString(CurrentRow, "LineCode"))
	ls_itemcode			= Trim(GetItemString(CurrentRow, "ItemCode"))

	dw_detail.ReSet()
	dw_detail.Retrieve(uo_fromdate.is_uo_date,	uo_todate.is_uo_date, &
							ls_areacode,					ls_divisioncode, &
							ls_workcenter,					ls_linecode, &
							ls_itemcode)
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_pisk210i
integer x = 1257
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
	dw_print.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
	
	
	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If

end event

type uo_division from u_pisc_select_division within w_pisk210i
integer x = 1755
integer y = 68
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
	dw_detail.SetTransObject(SQLPIS)
	dw_print.SetTransObject(SQLPIS)
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'%', &
											True, &
											uo_workcenter.is_uo_workcenter, &
											uo_workcenter.is_uo_workcentername)
	
	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisk210i
integer x = 2354
integer y = 68
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_line(uo_line.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											'%', &
											True, &
											uo_line.is_uo_linecode, &
											uo_line.is_uo_lineshortname, &
											uo_line.is_uo_linefullname)
End If

end event

type uo_line from u_pisc_select_line within w_pisk210i
integer x = 3031
integer y = 68
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type dw_detail from datawindow within w_pisk210i
integer x = 965
integer y = 700
integer width = 1947
integer height = 724
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisk210i_02"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_pisk210i
integer x = 14
integer y = 1612
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,ABOVE)
of_register(dw_detail,BELOW)
end event

type gb_1 from groupbox within w_pisk210i
integer x = 1221
integer width = 1111
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisk210i
integer x = 2336
integer width = 1280
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_fromdate from u_pisc_date_firstday within w_pisk210i
integer x = 37
integer y = 68
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

on uo_fromdate.destroy
call u_pisc_date_firstday::destroy
end on

type gb_3 from groupbox within w_pisk210i
integer x = 14
integer width = 1202
integer height = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type uo_todate from u_pisc_date_applydate_1 within w_pisk210i
integer x = 731
integer y = 68
boolean bringtotop = true
end type

event ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

type dw_print from datawindow within w_pisk210i
integer x = 1285
integer y = 232
integer width = 562
integer height = 496
boolean bringtotop = true
boolean titlebar = true
string title = "�μ�"
string dataobject = "d_pisk210i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Visible	= False
end event

