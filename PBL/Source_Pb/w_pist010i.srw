$PBExportHeader$w_pist010i.srw
$PBExportComments$제품이력조회
forward
global type w_pist010i from w_ipis_sheet01
end type
type uo_date1 from u_pisc_date_applydate_1 within w_pist010i
end type
type uo_area1 from u_pisc_select_area within w_pist010i
end type
type uo_division1 from u_pisc_select_division within w_pist010i
end type
type uo_workcenter from u_pisc_select_workcenter within w_pist010i
end type
type uo_linecode from u_pisc_select_line within w_pist010i
end type
type st_2 from statictext within w_pist010i
end type
type uo_1 from u_pisc_date_applydate within w_pist010i
end type
type gb_1 from groupbox within w_pist010i
end type
type uo_date from u_pisc_date_applydate within w_pist010i
end type
type uo_division from u_pisc_select_division within w_pist010i
end type
type uo_area from u_pisc_select_area within w_pist010i
end type
type dw_sheet from u_vi_std_datawindow within w_pist010i
end type
end forward

global type w_pist010i from w_ipis_sheet01
integer width = 4215
uo_date1 uo_date1
uo_area1 uo_area1
uo_division1 uo_division1
uo_workcenter uo_workcenter
uo_linecode uo_linecode
st_2 st_2
uo_1 uo_1
gb_1 gb_1
uo_date uo_date
uo_division uo_division
uo_area uo_area
dw_sheet dw_sheet
end type
global w_pist010i w_pist010i

type variables
string is_applydate1,is_applydate2,is_areacode,is_divisioncode,is_workcenter,is_linecode
end variables

on w_pist010i.create
int iCurrent
call super::create
this.uo_date1=create uo_date1
this.uo_area1=create uo_area1
this.uo_division1=create uo_division1
this.uo_workcenter=create uo_workcenter
this.uo_linecode=create uo_linecode
this.st_2=create st_2
this.uo_1=create uo_1
this.gb_1=create gb_1
this.uo_date=create uo_date
this.uo_division=create uo_division
this.uo_area=create uo_area
this.dw_sheet=create dw_sheet
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_date1
this.Control[iCurrent+2]=this.uo_area1
this.Control[iCurrent+3]=this.uo_division1
this.Control[iCurrent+4]=this.uo_workcenter
this.Control[iCurrent+5]=this.uo_linecode
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.uo_date
this.Control[iCurrent+10]=this.uo_division
this.Control[iCurrent+11]=this.uo_area
this.Control[iCurrent+12]=this.dw_sheet
end on

on w_pist010i.destroy
call super::destroy
destroy(this.uo_date1)
destroy(this.uo_area1)
destroy(this.uo_division1)
destroy(this.uo_workcenter)
destroy(this.uo_linecode)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.gb_1)
destroy(this.uo_date)
destroy(this.uo_division)
destroy(this.uo_area)
destroy(this.dw_sheet)
end on

event open;call super::open;dw_sheet.settransobject(sqlpis)
end event

event ue_retrieve;call super::ue_retrieve;is_areacode = uo_area.is_uo_areacode
is_divisioncode = uo_division.is_uo_divisioncode
is_workcenter = uo_workcenter.is_uo_workcenter
is_linecode = uo_linecode.is_uo_linecode

dw_sheet.retrieve(is_areacode,is_divisioncode,is_workcenter,is_linecode,is_applydate1,is_applydate2)
if dw_sheet.rowcount() = 0 then
	messagebox("확인","조회할 자료가 없습니다.")
end if	
end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
end event

event ue_postopen;call super::ue_postopen;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
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

type uo_status from w_ipis_sheet01`uo_status within w_pist010i
end type

type uo_date1 from u_pisc_date_applydate_1 within w_pist010i
integer x = 814
integer y = 96
integer taborder = 130
boolean bringtotop = true
end type

on uo_date1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_applydate1 = is_uo_date
end event

event constructor;call super::constructor;is_applydate2 = is_uo_date
end event

type uo_area1 from u_pisc_select_area within w_pist010i
event destroy ( )
boolean visible = false
integer x = 1202
integer y = 764
integer taborder = 120
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_area1.destroy
call u_pisc_select_area::destroy
end on

event ue_select;//dw_sheet.settransobject(sqlpis)
//string ls_divisionname,ls_divisionnameeng
//datawindow ldw_division
//ldw_division = uo_division.dw_1
//is_areacode = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//
//
end event

event ue_post_constructor;call super::ue_post_constructor;//string ls_divisionname,ls_divisionnameeng
//datawindow ldw_division
//ldw_division = uo_division.dw_1
//is_areacode = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//
//
end event

type uo_division1 from u_pisc_select_division within w_pist010i
event destroy ( )
boolean visible = false
integer x = 1861
integer y = 752
integer taborder = 130
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_division1.destroy
call u_pisc_select_division::destroy
end on

event constructor;call super::constructor;//postevent('ue_post_constructor')
end event

event ue_select;call super::ue_select;//is_divisioncode = is_uo_divisioncode
//f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
//										  uo_area.is_uo_areacode, &
//										  uo_division.is_uo_divisioncode, &
//										  '%', &
//										  true, &
//										  uo_workcenter.is_uo_workcenter, &
//										  uo_workcenter.is_uo_workcentername)
//
//f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
//								  uo_area.is_uo_areacode, &
//								  uo_division.is_uo_divisioncode, &
//								  uo_workcenter.is_uo_workcenter, &
//								  '%', &
//								  true, &
//								  uo_linecode.is_uo_linecode, &
//								  uo_linecode.is_uo_lineshortname, &
//								  uo_linecode.is_uo_linefullname)
//
end event

event ue_post_constructor;call super::ue_post_constructor;//is_divisioncode = is_uo_divisioncode
end event

type uo_workcenter from u_pisc_select_workcenter within w_pist010i
integer x = 2455
integer y = 96
integer taborder = 140
boolean bringtotop = true
end type

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

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_workcenter = is_uo_workcenter
end event

type uo_linecode from u_pisc_select_line within w_pist010i
integer x = 3173
integer y = 96
integer taborder = 150
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_linecode = is_uo_linecode
end event

on uo_linecode.destroy
call u_pisc_select_line::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_linecode = is_uo_linecode
end event

type st_2 from statictext within w_pist010i
integer x = 741
integer y = 104
integer width = 73
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "->"
boolean focusrectangle = false
end type

type uo_1 from u_pisc_date_applydate within w_pist010i
integer x = 46
integer y = 96
integer taborder = 21
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;is_applydate1 = is_uo_date
end event

event constructor;call super::constructor;is_applydate1 = is_uo_date
end event

type gb_1 from groupbox within w_pist010i
integer x = 23
integer y = 28
integer width = 3730
integer height = 172
integer taborder = 60
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

type uo_date from u_pisc_date_applydate within w_pist010i
event destroy ( )
boolean visible = false
integer x = 311
integer y = 708
integer taborder = 110
long backcolor = 80269524
end type

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event constructor;call super::constructor;//is_applydate1 = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;//is_applydate1 = is_uo_date
end event

event ue_select;call super::ue_select;//is_applydate1 = is_uo_date
end event

type uo_division from u_pisc_select_division within w_pist010i
integer x = 1870
integer y = 96
integer taborder = 140
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;is_divisioncode = is_uo_divisioncode
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

type uo_area from u_pisc_select_area within w_pist010i
event destroy ( )
integer x = 1330
integer y = 96
integer taborder = 140
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
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

type dw_sheet from u_vi_std_datawindow within w_pist010i
integer x = 27
integer y = 220
integer width = 4096
integer height = 1660
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pist010i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

