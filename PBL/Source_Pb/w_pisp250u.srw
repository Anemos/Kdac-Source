$PBExportHeader$w_pisp250u.srw
$PBExportComments$간판 상태 정보
forward
global type w_pisp250u from w_ipis_sheet01
end type
type gb_6 from groupbox within w_pisp250u
end type
type dw_1 from u_vi_std_datawindow within w_pisp250u
end type
type uo_area from u_pisc_select_area within w_pisp250u
end type
type uo_division from u_pisc_select_division within w_pisp250u
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp250u
end type
type uo_line from u_pisc_select_line within w_pisp250u
end type
type rb_1 from radiobutton within w_pisp250u
end type
type rb_2 from radiobutton within w_pisp250u
end type
type uo_item from u_pisc_select_item_kb_line within w_pisp250u
end type
type rb_3 from radiobutton within w_pisp250u
end type
type cb_1 from commandbutton within w_pisp250u
end type
type gb_1 from groupbox within w_pisp250u
end type
type gb_2 from groupbox within w_pisp250u
end type
type gb_4 from groupbox within w_pisp250u
end type
type gb_3 from groupbox within w_pisp250u
end type
end forward

global type w_pisp250u from w_ipis_sheet01
integer width = 4690
string title = ""
gb_6 gb_6
dw_1 dw_1
uo_area uo_area
uo_division uo_division
uo_workcenter uo_workcenter
uo_line uo_line
rb_1 rb_1
rb_2 rb_2
uo_item uo_item
rb_3 rb_3
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
gb_3 gb_3
end type
global w_pisp250u w_pisp250u

type variables
Boolean	ib_open
String	is_kbactivegubun	= "%"	// "UPDATE" 이미 등록된 간판마스터를 변경 저장

end variables

on w_pisp250u.create
int iCurrent
call super::create
this.gb_6=create gb_6
this.dw_1=create dw_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_workcenter=create uo_workcenter
this.uo_line=create uo_line
this.rb_1=create rb_1
this.rb_2=create rb_2
this.uo_item=create uo_item
this.rb_3=create rb_3
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.uo_workcenter
this.Control[iCurrent+6]=this.uo_line
this.Control[iCurrent+7]=this.rb_1
this.Control[iCurrent+8]=this.rb_2
this.Control[iCurrent+9]=this.uo_item
this.Control[iCurrent+10]=this.rb_3
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.gb_3
end on

on w_pisp250u.destroy
call super::destroy
destroy(this.gb_6)
destroy(this.dw_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_workcenter)
destroy(this.uo_line)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.uo_item)
destroy(this.rb_3)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_3)
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

of_resize_register(dw_1, FULL)

of_resize()
end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)

cb_1.Enabled	= m_frame.m_action.m_save.Enabled

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

f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										uo_line.is_uo_linecode, &
										'%', &
										True, &
										uo_item.is_uo_itemcode, &
										uo_item.is_uo_itemname)

ib_open = True
end event

event ue_retrieve;
iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(	uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
						uo_item.is_uo_itemcode,				is_kbactivegubun) > 0 Then
	uo_status.st_message.text =  "간판 상태 정보" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "간판 상태 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("간판 상태 정보", "간판 상태 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp250u
end type

type gb_6 from groupbox within w_pisp250u
integer x = 3282
integer width = 933
integer height = 180
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

type dw_1 from u_vi_std_datawindow within w_pisp250u
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 184
integer width = 1458
integer height = 1604
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp250u_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_vscroll;//// DataWindow Event_ID pbm_vscroll 

Long ll_scrollPos, ll_detail
String ls_Row, ls_vScrollPos, ls_Chk 

//ll_header		= Long(Describe("DataWindow.Header.Height"))
ll_detail		= Long(Describe("DataWindow.Detail.Height"))

If scrollcode = 0 Then 		// ▲ 
	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
	ll_scrollPos = Long(ls_vScrollPos) - ll_detail 	// ll_detail -> 행간높이 
	This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 

	Return 1 
ElseIf scrollcode = 1 Then 	// ▼
	
	ls_vScrollPos = This.Describe("DataWindow.VerticalScrollPosition") 
	ll_scrollPos = Long(ls_vScrollPos) + ll_detail 
	
	ls_Chk = This.Modify("DataWindow.VerticalScrollPosition=" + String(ll_scrollPos)) 
	If ls_Chk <> '' Then MessageBox("", ls_Chk)
	Return 1 
End If 

end event

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

type uo_area from u_pisc_select_area within w_pisp250u
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

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
End If

end event

type uo_division from u_pisc_select_division within w_pisp250u
integer x = 530
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

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp250u
integer x = 1111
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

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
End If

end event

type uo_line from u_pisc_select_line within w_pisp250u
integer x = 1778
integer y = 68
boolean bringtotop = true
end type

on uo_line.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")

	f_pisc_retrieve_dddw_item_kb_line(uo_item.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											uo_workcenter.is_uo_workcenter, &
											uo_line.is_uo_linecode, &
											'%', &
											True, &
											uo_item.is_uo_itemcode, &
											uo_item.is_uo_itemname)
End If

end event

type rb_1 from radiobutton within w_pisp250u
integer x = 3310
integer y = 72
integer width = 215
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "전체"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;If Checked Then
	is_kbactivegubun = "%"
	iw_this.TriggerEvent("ue_reset")
Else
	rb_2.Checked	= False
	rb_3.Checked	= False
End If
end event

type rb_2 from radiobutton within w_pisp250u
integer x = 3529
integer y = 72
integer width = 361
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sleeping"
borderstyle borderstyle = stylelowered!
end type

event clicked;If Checked Then
	is_kbactivegubun = "S"
	iw_this.TriggerEvent("ue_reset")
Else
	rb_1.Checked	= False
	rb_3.Checked	= False
End If
end event

type uo_item from u_pisc_select_item_kb_line within w_pisp250u
integer x = 2377
integer y = 68
boolean bringtotop = true
end type

on uo_item.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If

end event

type rb_3 from radiobutton within w_pisp250u
integer x = 3895
integer y = 72
integer width = 293
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "Active"
borderstyle borderstyle = stylelowered!
end type

event clicked;If Checked Then
	is_kbactivegubun = "A"
	iw_this.TriggerEvent("ue_reset")
Else
	rb_1.Checked	= False
	rb_2.Checked	= False
End If
end event

type cb_1 from commandbutton within w_pisp250u
integer x = 4251
integer y = 56
integer width = 338
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "상태전환"
end type

event clicked;Int	li_row

li_row	= dw_1.GetRow()

If li_row > 0 Then
	//
Else
	MessageBox("간판상태관리", "제품을 선택하여 주십시오.", StopSign!)
	Return
End If

istr_parms.string_arg[1] = is_size
//istr_parms.string_arg[2] = uo_date.is_uo_date

istr_parms.string_arg[3] = Trim(dw_1.GetItemString(li_row, 'AreaCode'))
istr_parms.string_arg[4] = Trim(dw_1.GetItemString(li_row, 'DivisionCode'))
istr_parms.string_arg[5] = Trim(dw_1.GetItemString(li_row, 'WorkCenter'))
istr_parms.string_arg[6] = Trim(dw_1.GetItemString(li_row, 'LineCode'))
istr_parms.string_arg[7] = Trim(dw_1.GetItemString(li_row, 'ItemCode'))
	
OpenWithParm(w_pisp251u, istr_parms)

If Upper(Message.StringParm) = "CHANGE" Then
	iw_this.TriggerEvent("ue_retrieve")
End If
end event

type gb_1 from groupbox within w_pisp250u
integer x = 18
integer width = 1083
integer height = 180
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

type gb_2 from groupbox within w_pisp250u
integer x = 1102
integer width = 1253
integer height = 180
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

type gb_4 from groupbox within w_pisp250u
integer x = 2354
integer width = 928
integer height = 180
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

type gb_3 from groupbox within w_pisp250u
integer x = 4215
integer width = 411
integer height = 180
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

