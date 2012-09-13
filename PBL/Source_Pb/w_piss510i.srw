$PBExportHeader$w_piss510i.srw
$PBExportComments$영업현장확인현황
forward
global type w_piss510i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss510i
end type
type uo_division from u_pisc_select_division within w_piss510i
end type
type uo_date from u_pisc_date_applydate within w_piss510i
end type
type dw_3 from datawindow within w_piss510i
end type
type st_h_bar from uo_xc_splitbar within w_piss510i
end type
type st_2 from statictext within w_piss510i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss510i
end type
type dw_2 from u_vi_std_datawindow within w_piss510i
end type
type ddlb_saleconfirm from dropdownlistbox within w_piss510i
end type
type st_3 from statictext within w_piss510i
end type
type st_4 from statictext within w_piss510i
end type
type ddlb_confirm from dropdownlistbox within w_piss510i
end type
type gb_1 from groupbox within w_piss510i
end type
end forward

global type w_piss510i from w_ipis_sheet01
integer width = 4599
string title = "영업현장확인"
boolean minbox = true
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_3 dw_3
st_h_bar st_h_bar
st_2 st_2
uo_1 uo_1
dw_2 dw_2
ddlb_saleconfirm ddlb_saleconfirm
st_3 st_3
st_4 st_4
ddlb_confirm ddlb_confirm
gb_1 gb_1
end type
global w_piss510i w_piss510i

type variables
boolean ib_open, ib_change = false
string is_shipsheetno,  is_change = 'NO', is_applydate,is_areacode,is_divisioncode
string is_prddate,is_itemcode,is_shipdate,is_shipdate1
string is_security, is_modelcode, is_kbno, is_asgubun, &
         is_plantcode, is_workcenter, is_shift, is_linecode, &
         is_enddate, is_invdate, is_lotno
integer ii_window_border = 10,il_qty
integer ii_rackqty, ii_cancelqty, ii_oldcancelqty,  il_kbloopsn


end variables

on w_piss510i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.dw_3=create dw_3
this.st_h_bar=create st_h_bar
this.st_2=create st_2
this.uo_1=create uo_1
this.dw_2=create dw_2
this.ddlb_saleconfirm=create ddlb_saleconfirm
this.st_3=create st_3
this.st_4=create st_4
this.ddlb_confirm=create ddlb_confirm
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.st_h_bar
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_1
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.ddlb_saleconfirm
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.ddlb_confirm
this.Control[iCurrent+13]=this.gb_1
end on

on w_piss510i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_3)
destroy(this.st_h_bar)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.dw_2)
destroy(this.ddlb_saleconfirm)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.ddlb_confirm)
destroy(this.gb_1)
end on

event open;call super::open;ddlb_saleconfirm.text 	= '전체'
ddlb_confirm.text 		= '전체'
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_2, ABOVE)
of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_3, BELOW)

of_resize()
end event

event ue_retrieve;long ll_count
string ls_saleconfirmflag,ls_confirmflag
if ddlb_saleconfirm.text = '전체' then
	ls_saleconfirmflag = '%'
elseif ddlb_saleconfirm.text = '확인' then
	ls_saleconfirmflag = 'Y'
else
	ls_saleconfirmflag = 'N'
end if		
if ddlb_confirm.text = '전체' then
	ls_confirmflag = '%'
elseif ddlb_confirm.text = '확인' then
	ls_confirmflag = 'Y'
else
	ls_confirmflag = 'N'
end if		
setpointer(hourglass!)
ll_count = dw_2.retrieve(is_areacode,is_divisioncode,is_shipdate,is_shipdate1,ls_saleconfirmflag,ls_confirmflag)
dw_3.reset()
setpointer(arrow!)
if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
end if	

end event

event activate;call super::activate;dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss510i
end type

type uo_area from u_pisc_select_area within w_piss510i
integer x = 1371
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
if is_areacode = 'D' then
	f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
else
	f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)	
end if	
dw_2.reset()
dw_3.reset()
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
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_piss510i
integer x = 1920
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)

dw_2.reset()
dw_3.reset()
is_divisioncode = is_uo_divisioncode

end event

type uo_date from u_pisc_date_applydate within w_piss510i
integer x = 73
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

event constructor;call super::constructor;is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;call super::ue_select;if is_shipdate <> is_uo_date then
	dw_2.reset()
	dw_3.reset()
end if	
is_shipdate = is_uo_date

end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type dw_3 from datawindow within w_piss510i
integer x = 50
integer y = 1136
integer width = 411
integer height = 712
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss400u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_piss510i
integer x = 64
integer y = 1428
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_2,ABOVE)
of_register(dw_3,BELOW)
end event

type st_2 from statictext within w_piss510i
integer x = 750
integer y = 108
integer width = 78
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
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_1 from u_pisc_date_applydate_1 within w_piss510i
event destroy ( )
integer x = 832
integer y = 100
integer taborder = 50
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_date
dw_2.reset()
dw_3.reset()
end event

type dw_2 from u_vi_std_datawindow within w_piss510i
integer x = 41
integer y = 220
integer height = 836
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_piss510i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then 
	return
end if	
string ls_divisioncode,ls_shipsheetno,ls_shipdate
ls_divisioncode = dw_2.object.divisioncode[row]
ls_shipsheetno  = dw_2.object.shipsheetno[row]
ls_shipdate     = dw_2.object.shipdate[row]
dw_3.retrieve(is_areacode,ls_divisioncode,ls_shipsheetno,ls_shipdate)

end event

event rowfocuschanged;call super::rowfocuschanged;//uo_status.st_message.text = string(currentrow)
if currentrow < 1 then 
	return
end if	
string ls_divisioncode,ls_shipsheetno,ls_shipdate
ls_divisioncode = dw_2.object.divisioncode[currentrow]
ls_shipsheetno  = dw_2.object.shipsheetno[currentrow]
ls_shipdate     = dw_2.object.shipdate[currentrow]
dw_3.retrieve(is_areacode,ls_divisioncode,ls_shipsheetno,ls_shipdate)

end event

type ddlb_saleconfirm from dropdownlistbox within w_piss510i
integer x = 2807
integer y = 92
integer width = 384
integer height = 324
integer taborder = 50
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
boolean sorted = false
string item[] = {"전체","확인","미확인"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_piss510i
integer x = 2510
integer y = 104
integer width = 302
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "영업확인:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss510i
integer x = 3291
integer y = 104
integer width = 302
integer height = 56
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "정문확인:"
boolean focusrectangle = false
end type

type ddlb_confirm from dropdownlistbox within w_piss510i
integer x = 3611
integer y = 92
integer width = 384
integer height = 324
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15780518
boolean sorted = false
string item[] = {"전체","확인","미확인"}
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss510i
integer x = 23
integer y = 28
integer width = 4050
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
end type

