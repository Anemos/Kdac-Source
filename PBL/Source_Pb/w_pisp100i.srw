$PBExportHeader$w_pisp100i.srw
$PBExportComments$미준수간판 회수 이력
forward
global type w_pisp100i from w_ipis_sheet01
end type
type dw_1 from u_vi_std_datawindow within w_pisp100i
end type
type uo_area from u_pisc_select_area within w_pisp100i
end type
type uo_division from u_pisc_select_division within w_pisp100i
end type
type uo_workcenter from u_pisc_select_workcenter within w_pisp100i
end type
type uo_line from u_pisc_select_line within w_pisp100i
end type
type uo_code from u_pisc_select_code within w_pisp100i
end type
type st_2 from statictext within w_pisp100i
end type
type uo_fromdate from u_pisc_date_firstday within w_pisp100i
end type
type uo_todate from u_pisc_date_applydate_1 within w_pisp100i
end type
type dw_print from datawindow within w_pisp100i
end type
type cb_1 from commandbutton within w_pisp100i
end type
type gb_1 from groupbox within w_pisp100i
end type
type gb_2 from groupbox within w_pisp100i
end type
type gb_3 from groupbox within w_pisp100i
end type
type gb_4 from groupbox within w_pisp100i
end type
end forward

global type w_pisp100i from w_ipis_sheet01
integer width = 4736
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
dw_print dw_print
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_pisp100i w_pisp100i

type variables
Boolean	ib_open
end variables

on w_pisp100i.create
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
this.dw_print=create dw_print
this.cb_1=create cb_1
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
this.Control[iCurrent+10]=this.dw_print
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.gb_4
end on

on w_pisp100i.destroy
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
destroy(this.dw_print)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_1, FULL)

of_resize()

end event

event ue_postopen;dw_1.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)

dw_1.ShareData(dw_print)

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

f_pisc_retrieve_dddw_code(uo_code.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										'PUNOBSERVE', &
										'%', &
										True, &
										uo_code.is_uo_codegroup, &
										uo_code.is_uo_codeid, &
										uo_code.is_uo_codegroupname, &
										uo_code.is_uo_codename)

ib_open = True
end event

event ue_retrieve;iw_this.TriggerEvent("ue_reset")

If dw_1.Retrieve(uo_fromdate.is_uo_date, 				uo_todate.is_uo_date, &
						uo_area.is_uo_areacode,				uo_division.is_uo_divisioncode, &
						uo_workcenter.is_uo_workcenter,	uo_line.is_uo_linecode, &
						uo_code.is_uo_codegroup,			uo_code.is_uo_codeid) > 0 Then
	uo_status.st_message.text =  "미준수 간판 이력" //+ f_message("변경된 데이타가 없습니다.")
Else
	uo_status.st_message.text =  "미준수 간판 이력 정보가 존재하지 않습니다" //+ f_message("변경된 데이타가 없습니다.")
	MessageBox("미준수 간판 이력", "미준수 간판 이력 정보가 존재하지 않습니다")
End If

end event

event ue_reset;call super::ue_reset;dw_1.ReSet()
dw_print.ReSet()
end event

event ue_print;call super::ue_print;String	ls_mod, ls_date
str_easy	lstr_prt

ls_date	= uo_fromdate.is_uo_date + " ~ " + uo_todate.is_uo_date

ls_mod	= "st_msg.Text = '" + "기준일 : " + ls_date + "' "

lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '미준수 간판 회수 이력'
lstr_prt.tag			= '미준수 간판 회수 이력'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_1.SetTransObject(SQLPIS)
dw_print.SetTransObject(SQLPIS)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pisp100i
end type

type dw_1 from u_vi_std_datawindow within w_pisp100i
event ue_mousemove pbm_mousemove
event ue_vscroll pbm_vscroll
integer x = 14
integer y = 344
integer width = 1893
integer height = 872
integer taborder = 0
string dragicon = "DataPipeline!"
boolean bringtotop = true
string dataobject = "d_pisp100i_01"
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

type uo_area from u_pisc_select_area within w_pisp100i
integer x = 1298
integer y = 68
integer height = 68
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;If ib_open Then
	dw_1.SetTransObject(SQLPIS)
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

	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PUNOBSERVE', &
											'%', &
											True, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
End If

end event

type uo_division from u_pisc_select_division within w_pisp100i
integer x = 1806
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
											
	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PUNOBSERVE', &
											'%', &
											True, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
End If

end event

type uo_workcenter from u_pisc_select_workcenter within w_pisp100i
integer x = 2432
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

type uo_line from u_pisc_select_line within w_pisp100i
integer x = 3122
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

type uo_code from u_pisc_select_code within w_pisp100i
integer x = 416
integer y = 228
boolean bringtotop = true
end type

on uo_code.destroy
call u_pisc_select_code::destroy
end on

type st_2 from statictext within w_pisp100i
integer x = 55
integer y = 240
integer width = 352
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
string text = "미준수원인:"
boolean focusrectangle = false
end type

type uo_fromdate from u_pisc_date_firstday within w_pisp100i
integer x = 55
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

type uo_todate from u_pisc_date_applydate_1 within w_pisp100i
integer x = 759
integer y = 68
boolean bringtotop = true
end type

event ue_select;call super::ue_select;If ib_open Then
	iw_this.TriggerEvent("ue_reset")
End If
end event

on uo_todate.destroy
call u_pisc_date_applydate_1::destroy
end on

type dw_print from datawindow within w_pisp100i
integer x = 1650
integer y = 612
integer width = 649
integer height = 420
boolean bringtotop = true
boolean titlebar = true
string title = "인쇄"
string dataobject = "d_pisp100i_01_print"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event constructor;visible = False
end event

type cb_1 from commandbutton within w_pisp100i
integer x = 1143
integer y = 220
integer width = 704
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "미준수원인 등록(&I)"
end type

event clicked;istr_parms.string_arg[1] = is_size
istr_parms.string_arg[2] = "PUNOBSERVE"
istr_parms.string_arg[3] = "미준수간판원인"

OpenWithParm(w_pisp007u, istr_parms)
If Upper(Message.StringParm) = "CHANGE" Then
	f_pisc_retrieve_dddw_code(uo_code.dw_1, &
											uo_area.is_uo_areacode, &
											uo_division.is_uo_divisioncode, &
											'PUNOBSERVE', &
											'%', &
											True, &
											uo_code.is_uo_codegroup, &
											uo_code.is_uo_codeid, &
											uo_code.is_uo_codegroupname, &
											uo_code.is_uo_codename)
	iw_this.TriggerEvent("ue_retrieve")
End If
end event

type gb_1 from groupbox within w_pisp100i
integer x = 14
integer width = 1239
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

type gb_2 from groupbox within w_pisp100i
integer x = 1257
integer width = 1138
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

type gb_3 from groupbox within w_pisp100i
integer x = 2400
integer width = 1312
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

type gb_4 from groupbox within w_pisp100i
integer x = 14
integer y = 160
integer width = 1893
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

