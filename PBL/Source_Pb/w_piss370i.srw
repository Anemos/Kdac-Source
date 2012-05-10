$PBExportHeader$w_piss370i.srw
$PBExportComments$입고현황
forward
global type w_piss370i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss370i
end type
type uo_area from u_pisc_select_area within w_piss370i
end type
type uo_division from u_pisc_select_division within w_piss370i
end type
type uo_date from u_pisc_date_applydate within w_piss370i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss370i
end type
type st_2 from statictext within w_piss370i
end type
type dw_print from datawindow within w_piss370i
end type
type uo_workcenter from u_pisc_select_workcenter within w_piss370i
end type
type uo_linecode from u_pisc_select_line within w_piss370i
end type
type gb_1 from groupbox within w_piss370i
end type
end forward

global type w_piss370i from w_ipis_sheet01
integer width = 4375
string title = "입고현황"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_date uo_date
uo_1 uo_1
st_2 st_2
dw_print dw_print
uo_workcenter uo_workcenter
uo_linecode uo_linecode
gb_1 gb_1
end type
global w_piss370i w_piss370i

type variables
string is_prddate,is_prddate1,is_areacode,is_divisioncode,is_workcenter,is_linecode
end variables

on w_piss370i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.uo_1=create uo_1
this.st_2=create st_2
this.dw_print=create dw_print
this.uo_workcenter=create uo_workcenter
this.uo_linecode=create uo_linecode
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_date
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.uo_workcenter
this.Control[iCurrent+9]=this.uo_linecode
this.Control[iCurrent+10]=this.gb_1
end on

on w_piss370i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.uo_1)
destroy(this.st_2)
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

event ue_retrieve;call super::ue_retrieve;string ls_prddate,ls_areacode,ls_divisioncode,ls_time
long ll_count

ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,is_prddate,is_prddate1,uo_workcenter.is_uo_workcenter,uo_linecode.is_uo_linecode)

if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
	uo_date.setfocus()
	return
end if	


end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
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

event ue_print;call super::ue_print;String	ls_mod,ls_date
str_easy	lstr_prt
dw_sheet.sharedata(dw_print)
ls_date = is_prddate + ' - ' + is_prddate1
//
ls_mod	= "t_msg.Text = '" + "기준일 : " + ls_date + "' "
//ls_mod	= ls_mod + is_mod1
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '입고현황'
lstr_prt.tag			= '입고현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
//
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss370i
end type

type dw_sheet from u_vi_std_datawindow within w_piss370i
integer x = 18
integer y = 252
integer width = 3575
integer height = 1636
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss370i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_pisc_select_area within w_piss370i
integer x = 1367
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
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//	Function		:	f_pisc_retrieve_dddw_division
//	Access		:	public
//	Arguments	:	DataWindow		fdw_1						조회하고자 하는 DDDW Object
//						string			fs_empno					조회하고자 하는 사번 (지역별/공장별 권한에 따른 조회를 위하여)
//						string			fs_areacode				조회하고자 하는 지역
//						string			fs_divisioncode		조회하고자 하는 공장 코드 (일반적으로 '%' 을 사용하도록)
//						boolean			fb_allflag				조회된 공장 정보가 2개 이상의 Record 일 경우
//																		True : '전체' 항목 삽입 (공장코드는 '%', 공장명은 '전체')
//																		False : '전체' 항목 미 삽입
//						string			rs_divisioncode		선택된 공장 코드 (reference)
//						string			rs_divisionname		선택된 공장 명 (reference)
//						string			rs_divisionnameeng	선택된 공장 영문 명 (reference)
//	Returns		: none
//	Description	: 공장을 선택하기 위한 DDDW 을 조회하기 위하여
// Company		: DAEWOO Information System Co., Ltd. IAS
// Author		: Kim Jin-Su
// Coded Date	: 2002.09.04
///////////////////////////////////////////////////////////////////////////////////////////////////////////
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss370i
integer x = 1938
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

type uo_date from u_pisc_date_applydate within w_piss370i
integer x = 73
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_losefocus;call super::ue_losefocus;is_prddate = is_uo_date
end event

event constructor;call super::constructor;is_prddate = is_uo_date
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;if is_prddate <> is_uo_date then
	dw_sheet.reset()
end if	
is_prddate = is_uo_date

end event

type uo_1 from u_pisc_date_applydate_1 within w_piss370i
integer x = 859
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;is_prddate1 = is_uo_date
end event

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

type st_2 from statictext within w_piss370i
integer x = 763
integer y = 108
integer width = 101
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

type dw_print from datawindow within w_piss370i
boolean visible = false
integer x = 946
integer y = 568
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss370i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_workcenter from u_pisc_select_workcenter within w_piss370i
event destroy ( )
integer x = 2523
integer y = 100
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

event constructor;call super::constructor;is_workcenter = is_uo_workcenter
end event

type uo_linecode from u_pisc_select_line within w_piss370i
event destroy ( )
integer x = 3241
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_linecode.destroy
call u_pisc_select_line::destroy
end on

event ue_select;call super::ue_select;is_linecode = is_uo_linecode
end event

event ue_post_constructor;call super::ue_post_constructor;is_linecode = is_uo_linecode
end event

event constructor;call super::constructor;is_linecode = is_uo_linecode
end event

type gb_1 from groupbox within w_piss370i
integer x = 23
integer y = 28
integer width = 3790
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

