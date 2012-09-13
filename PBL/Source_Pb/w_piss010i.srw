$PBExportHeader$w_piss010i.srw
$PBExportComments$입고대기상태조회
forward
global type w_piss010i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss010i
end type
type uo_area from u_pisc_select_area within w_piss010i
end type
type uo_division from u_pisc_select_division within w_piss010i
end type
type dw_print from datawindow within w_piss010i
end type
type uo_workcenter from u_pisc_select_workcenter within w_piss010i
end type
type uo_linecode from u_pisc_select_line within w_piss010i
end type
type gb_1 from groupbox within w_piss010i
end type
end forward

global type w_piss010i from w_ipis_sheet01
string title = "입고대기상태조회"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
dw_print dw_print
uo_workcenter uo_workcenter
uo_linecode uo_linecode
gb_1 gb_1
end type
global w_piss010i w_piss010i

type variables
string is_prddate,is_areacode,is_divisioncode,is_workcenter,is_linecode
end variables

on w_piss010i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_print=create dw_print
this.uo_workcenter=create uo_workcenter
this.uo_linecode=create uo_linecode
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_print
this.Control[iCurrent+5]=this.uo_workcenter
this.Control[iCurrent+6]=this.uo_linecode
this.Control[iCurrent+7]=this.gb_1
end on

on w_piss010i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_print)
destroy(this.uo_workcenter)
destroy(this.uo_linecode)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;call super::ue_retrieve;string ls_prddate,ls_areacode,ls_divisioncode
long ll_count

ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,uo_workcenter.is_uo_workcenter,uo_linecode.is_uo_linecode)

if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	return
end if	
end event

event ue_postopen;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
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
										  true, &
										  uo_workcenter.is_uo_workcenter, &
										  uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
								  uo_area.is_uo_areacode, &
								  uo_division.is_uo_divisioncode, &
								  uo_workcenter.is_uo_workcenter, &
								  '%', &
								  true, &
								  uo_linecode.is_uo_linecode, &
								  uo_linecode.is_uo_lineshortname, &
								  uo_linecode.is_uo_linefullname)



end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt
dw_sheet.sharedata(dw_print)
//
//ls_mod	= "t_msg.Text = '" + "기준일 : " + is_date + "' "
//ls_mod	= ls_mod + is_mod1
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '입고대기상태'
lstr_prt.tag			= '입고대기상태'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
//
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss010i
end type

type dw_sheet from u_vi_std_datawindow within w_piss010i
integer x = 18
integer y = 256
integer width = 3575
integer height = 1636
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss010i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_pisc_select_area within w_piss010i
integer x = 82
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										  uo_area.is_uo_areacode, &
										  uo_division.is_uo_divisioncode, &
										  '%', &
										  true, &
										  uo_workcenter.is_uo_workcenter, &
										  uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
								  uo_area.is_uo_areacode, &
								  uo_division.is_uo_divisioncode, &
								  uo_workcenter.is_uo_workcenter, &
								  '%', &
								  true, &
								  uo_linecode.is_uo_linecode, &
								  uo_linecode.is_uo_lineshortname, &
								  uo_linecode.is_uo_linefullname)


dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										  uo_area.is_uo_areacode, &
										  uo_division.is_uo_divisioncode, &
										  '%', &
										  true, &
										  uo_workcenter.is_uo_workcenter, &
										  uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
								  uo_area.is_uo_areacode, &
								  uo_division.is_uo_divisioncode, &
								  uo_workcenter.is_uo_workcenter, &
								  '%', &
								  true, &
								  uo_linecode.is_uo_linecode, &
								  uo_linecode.is_uo_lineshortname, &
								  uo_linecode.is_uo_linefullname)


end event

type uo_division from u_pisc_select_division within w_piss010i
integer x = 654
integer y = 100
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode

end event

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										  uo_area.is_uo_areacode, &
										  uo_division.is_uo_divisioncode, &
										  '%', &
										  true, &
										  uo_workcenter.is_uo_workcenter, &
										  uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
								  uo_area.is_uo_areacode, &
								  uo_division.is_uo_divisioncode, &
								  uo_workcenter.is_uo_workcenter, &
								  '%', &
								  true, &
								  uo_linecode.is_uo_linecode, &
								  uo_linecode.is_uo_lineshortname, &
								  uo_linecode.is_uo_linefullname)


end event

event constructor;call super::constructor;is_divisioncode = is_uo_divisioncode

end event

type dw_print from datawindow within w_piss010i
boolean visible = false
integer x = 686
integer y = 592
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss010i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_workcenter from u_pisc_select_workcenter within w_piss010i
event destroy ( )
integer x = 1243
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_select;call super::ue_select;is_workcenter = is_uo_workcenter
string ls_linefullname,ls_lineshortname

f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
										uo_area.is_uo_areacode, &
										uo_division.is_uo_divisioncode, &
										uo_workcenter.is_uo_workcenter, &
										'%', &
										true, &
										uo_linecode.is_uo_linecode, &
										uo_linecode.is_uo_lineshortname, &
										uo_linecode.is_uo_linefullname)

end event

event ue_post_constructor;call super::ue_post_constructor;is_workcenter = is_uo_workcenter
f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
								  uo_area.is_uo_areacode, &
								  uo_division.is_uo_divisioncode, &
								  uo_workcenter.is_uo_workcenter, &
								  '%', &
								  true, &
								  uo_linecode.is_uo_linecode, &
								  uo_linecode.is_uo_lineshortname, &
								  uo_linecode.is_uo_linefullname)


end event

type uo_linecode from u_pisc_select_line within w_piss010i
event destroy ( )
integer x = 1961
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

on uo_linecode.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;is_linecode = is_uo_linecode
end event

event ue_post_constructor;call super::ue_post_constructor;is_linecode = is_uo_linecode
end event

type gb_1 from groupbox within w_piss010i
integer x = 23
integer y = 28
integer width = 2542
integer height = 172
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "조회조건"
borderstyle borderstyle = stylelowered!
end type

