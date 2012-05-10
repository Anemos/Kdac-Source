$PBExportHeader$w_pisp120u.srw
$PBExportComments$간판 마스터
forward
global type w_pisp120u from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp120u
end type
type uo_area from u_pisc_select_area within w_pisp120u
end type
type uo_division from u_pisc_select_division within w_pisp120u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp120u
end type
type uo_line from u_pisc_select_line within w_pisp120u
end type
type uo_code from u_pisc_select_code within w_pisp120u
end type
type st_2 from statictext within w_pisp120u
end type
type uo_fromdate from u_pisc_date_firstday within w_pisp120u
end type
type uo_todate from u_pisc_date_applydate_1 within w_pisp120u
end type
type dw_2 from datawindow within w_pisp120u
end type
type st_v_bar from uo_xc_splitbar within w_pisp120u
end type
type st_h_bar from uo_xc_splitbar within w_pisp120u
end type
type dw_3 from datawindow within w_pisp120u
end type
type gb_1 from groupbox within w_pisp120u
end type
type gb_2 from groupbox within w_pisp120u
end type
type gb_3 from groupbox within w_pisp120u
end type
type gb_4 from groupbox within w_pisp120u
end type
end forward

global type w_pisp120u from w_ipis_sheet01
integer width = 4672
string title = ""
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
uo_code uo_code
st_2 st_2
uo_fromdate uo_fromdate
uo_todate uo_todate
dw_2 dw_2
st_v_bar st_v_bar
st_h_bar st_h_bar
dw_3 dw_3
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_pisp120u w_pisp120u

type variables
Boolean	ib_open, ib_drag

// il_drag_row	=> Drag 하기위해 처음에 선택한 Row
// il_old_row	=> Drag 하여 Drop 시킨 곳의 Row
Long		il_drag_row, il_old_row

// 스캐닝한 간판에 관련된 변수
String	is_kb_areacode, is_kb_divisioncode, is_kb_workcenter, is_kb_linecode, &
			is_kb_itemcode, is_kb_tempgubun, is_kb_kbstatuscode, is_kb_kbactivegubun
Int		ii_kb_rackqty, &
			ii_kb_cycleorder // 이건 wf_kbno_item_find() 에서 찾는다.
end variables

on w_pisp120u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.uo_code=create uo_code
this.st_2=create st_2
this.uo_fromdate=create uo_fromdate
this.uo_todate=create uo_todate
this.dw_2=create dw_2
this.st_v_bar=create st_v_bar
this.st_h_bar=create st_h_bar
this.dw_3=create dw_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_line
this.Control[iCurrent+6]=this.uo_code
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.uo_fromdate
this.Control[iCurrent+9]=this.uo_todate
this.Control[iCurrent+10]=this.dw_2
this.Control[iCurrent+11]=this.st_v_bar
this.Control[iCurrent+12]=this.st_h_bar
this.Control[iCurrent+13]=this.dw_3
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.gb_3
this.Control[iCurrent+17]=this.gb_4
end on

on w_pisp120u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.uo_code)
destroy(this.st_2)
destroy(this.uo_fromdate)
destroy(this.uo_todate)
destroy(this.dw_2)
destroy(this.st_v_bar)
destroy(this.st_h_bar)
destroy(this.dw_3)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event resize;call super::resize;//il_resize_count ++
//
//of_resize_register(dw_1, FULL)
//
//of_resize()
//
//dw_2.Move(st_v_bar.X, st_v_bar.Y + st_v_bar.Height + 15)
//dw_2.Resize(dw_1.Width, newheight - dw_1.Y - dw_1.Height - 30)

il_resize_count ++

of_resize_register(dw_1, LEFT)
of_resize_register(st_v_bar, SPLIT)
of_resize_register(dw_2, RIGHT_ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_3, RIGHT_BELOW)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)

f_pisc_retrieve_dddw_division(uo_division.dw_1, &
										g_s_empno, &
										uo_area.is_uo_areacode, &
										'%', &
										True, &
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

f_pisc_retrieve_dddw_code(uo_code.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'PNOKB', &
										'%', &
										True, &
										uo_code.is_uo_codegroup, &
										uo_code.is_uo_codeid, &
										uo_code.is_uo_codegroupname, &
										uo_code.is_uo_codename)

ib_open = True
end event

event ue_retrieve;//iw_this.TriggerEvent("ue_reset")
//
//If dw_1.Retrieve(uo_fromdate.is_uo_date, 				uo_todate.is_uo_date, &
//						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
//						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
//						uo_code.is_uo_codegroup,			uo_code.is_uo_codeid) > 0 Then
//	uo_status.st_message.text =  "무간판 생산/입고 이력" //+ f_message("변경된 데이타가 없습니다.")
//Else
//	uo_status.st_message.text =  "무간판 생산/입고 이력 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
//	MessageBox("무간판 생산/입고 이력", "무간판 생산/입고 이력 정보가 존재하지 않습니다")
//End If
//
end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp120u
end type

type dw_1 from u_vi_std_datawindow within w_pisp120u
event ue_mousemove pbm_mousemove
integer x = 14
integer y = 232
integer width = 736
integer height = 880
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = false
end type

event clicked;//
end event

event rowfocuschanged;//
If CurrentRow > 0 Then
	SelectRow(0,FALSE)
	SelectRow(currentrow,TRUE)
End If
end event

event ue_lbuttonup;//

end event

type uo_area from u_pisc_select_area within w_pisp120u
integer x = 1234
integer y = 88
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											True, &
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

	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PNOKB', &
											'%', &
											True, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
End If

end event

type uo_division from u_pisc_select_division within w_pisp120u
integer x = 1719
integer y = 88
integer width = 539
integer height = 68
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;If ib_open Then
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
											
	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PNOKB', &
											'%', &
											True, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp120u
integer x = 2295
integer y = 88
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

type uo_line from u_pisc_select_line within w_pisp120u
integer x = 2958
integer y = 88
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type uo_code from u_pisc_select_code within w_pisp120u
integer x = 3909
integer y = 88
boolean bringtotop = true
end type

on uo_code.destroy
call u_pisc_select_code::destroy
end on

type st_2 from statictext within w_pisp120u
integer x = 3547
integer y = 96
integer width = 366
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "무간판원인:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_fromdate from u_pisc_date_firstday within w_pisp120u
integer x = 41
integer y = 88
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

on uo_fromdate.destroy
call u_pisc_date_firstday::destroy
end on

type uo_todate from u_pisc_date_applydate_1 within w_pisp120u
integer x = 736
integer y = 88
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

type dw_2 from datawindow within w_pisp120u
integer x = 873
integer y = 256
integer width = 1093
integer height = 684
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_v_bar from uo_xc_splitbar within w_pisp120u
integer x = 795
integer y = 224
integer width = 14
integer height = 404
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_1,LEFT)
of_register(dw_2,RIGHT)
of_register(st_h_bar,RIGHT)
of_register(dw_3,RIGHT)
end event

type st_h_bar from uo_xc_splitbar within w_pisp120u
integer x = 873
integer y = 964
integer width = 1138
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_2,ABOVE)
of_register(dw_3,BELOW)
end event

type dw_3 from datawindow within w_pisp120u
integer x = 878
integer y = 1004
integer width = 1093
integer height = 452
integer taborder = 40
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisp120u
integer x = 14
integer width = 1193
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_pisp120u
integer x = 1211
integer width = 1070
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_pisp120u
integer x = 2286
integer width = 1243
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_pisp120u
integer x = 3534
integer width = 1093
integer height = 224
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

