$PBExportHeader$w_piss530i.srw
$PBExportComments$SR별출하현황
forward
global type w_piss530i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss530i
end type
type uo_division from u_pisc_select_division within w_piss530i
end type
type uo_date from u_pisc_date_applydate within w_piss530i
end type
type dw_3 from datawindow within w_piss530i
end type
type st_h_bar from uo_xc_splitbar within w_piss530i
end type
type st_2 from statictext within w_piss530i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss530i
end type
type dw_2 from u_vi_std_datawindow within w_piss530i
end type
type uo_scustgubun from u_pisc_select_code within w_piss530i
end type
type st_8 from statictext within w_piss530i
end type
type uo_custcode from u_piss_select_custcode within w_piss530i
end type
type st_5 from statictext within w_piss530i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss530i
end type
type st_9 from statictext within w_piss530i
end type
type gb_1 from groupbox within w_piss530i
end type
end forward

global type w_piss530i from w_ipis_sheet01
integer width = 4128
string title = "SR별출하현황"
boolean minbox = true
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_3 dw_3
st_h_bar st_h_bar
st_2 st_2
uo_1 uo_1
dw_2 dw_2
uo_scustgubun uo_scustgubun
st_8 st_8
uo_custcode uo_custcode
st_5 st_5
uo_shipoemgubun uo_shipoemgubun
st_9 st_9
gb_1 gb_1
end type
global w_piss530i w_piss530i

type variables
boolean ib_open, ib_change = false
string is_shipsheetno,  is_change = 'NO', is_applydate,is_areacode,is_divisioncode
string is_prddate,is_itemcode,is_shipdate,is_shipdate1
string is_security, is_modelcode, is_kbno, is_asgubun, &
         is_plantcode, is_workcenter, is_shift, is_linecode, &
         is_enddate, is_invdate, is_lotno
integer ii_window_border = 10,il_qty
integer ii_rackqty, ii_cancelqty, ii_oldcancelqty,  il_kbloopsn

string is_custcode,is_shipoemgubun,is_custgubun
end variables

on w_piss530i.create
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
this.uo_scustgubun=create uo_scustgubun
this.st_8=create st_8
this.uo_custcode=create uo_custcode
this.st_5=create st_5
this.uo_shipoemgubun=create uo_shipoemgubun
this.st_9=create st_9
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
this.Control[iCurrent+9]=this.uo_scustgubun
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.uo_custcode
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.uo_shipoemgubun
this.Control[iCurrent+14]=this.st_9
this.Control[iCurrent+15]=this.gb_1
end on

on w_piss530i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_3)
destroy(this.st_h_bar)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.dw_2)
destroy(this.uo_scustgubun)
destroy(this.st_8)
destroy(this.uo_custcode)
destroy(this.st_5)
destroy(this.uo_shipoemgubun)
destroy(this.st_9)
destroy(this.gb_1)
end on

event open;call super::open;dw_2.settransobject(sqlpis)
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
string ls_custcode
if is_shipoemgubun = 'X' then //이체면
   ls_custcode = '%'
else
	ls_custcode = is_custcode
end if	

setpointer(hourglass!)
ll_count = dw_2.retrieve(is_areacode,is_divisioncode,is_shipdate,is_shipdate1,ls_custcode,is_shipoemgubun)
dw_3.reset()
setpointer(arrow!)
if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
end if	

end event

event activate;call super::activate;dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
end event

event ue_postopen;call super::ue_postopen;string ls_codegroup,ls_codegroupname,ls_codename,ls_custname
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',TRUE,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',true,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',true,is_custcode,ls_custname)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss530i
end type

type uo_area from u_pisc_select_area within w_piss530i
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

type uo_division from u_pisc_select_division within w_piss530i
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

type uo_date from u_pisc_date_applydate within w_piss530i
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

type dw_3 from datawindow within w_piss530i
integer x = 50
integer y = 1136
integer width = 411
integer height = 712
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss530i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_piss530i
integer x = 64
integer y = 1428
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_2,ABOVE)
of_register(dw_3,BELOW)
end event

type st_2 from statictext within w_piss530i
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

type uo_1 from u_pisc_date_applydate_1 within w_piss530i
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

type dw_2 from u_vi_std_datawindow within w_piss530i
integer x = 41
integer y = 316
integer height = 712
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_piss530i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;if row < 1 then 
	return
end if	
string ls_srno
ls_srno = dw_2.object.srno[row]
dw_3.retrieve(ls_srno)

end event

type uo_scustgubun from u_pisc_select_code within w_piss530i
event destroy ( )
integer x = 411
integer y = 196
integer width = 709
integer taborder = 80
boolean bringtotop = true
end type

on uo_scustgubun.destroy
call u_pisc_select_code::destroy
end on

event constructor;call super::constructor;//postevent("ue_post_constructor")
end event

event ue_select;string ls_custgubun,ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',true,is_custcode,ls_custname)
dw_2.reset()
dw_3.reset()


end event

event ue_post_constructor;string ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

type st_8 from statictext within w_piss530i
integer x = 64
integer y = 204
integer width = 338
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "거래처구분"
boolean focusrectangle = false
end type

type uo_custcode from u_piss_select_custcode within w_piss530i
event destroy ( )
integer x = 1399
integer y = 196
integer taborder = 90
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
dw_2.reset()
dw_3.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

type st_5 from statictext within w_piss530i
integer x = 2610
integer y = 96
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "출하구분"
boolean focusrectangle = false
end type

type uo_shipoemgubun from u_pisc_select_code within w_piss530i
event destroy ( )
integer x = 2880
integer y = 88
integer width = 709
integer taborder = 70
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;call super::ue_select;is_shipoemgubun = is_uo_codeid
dw_2.reset()
dw_3.reset()
end event

event ue_post_constructor;is_shipoemgubun = is_uo_codeid

end event

type st_9 from statictext within w_piss530i
integer x = 2683
integer y = 196
integer width = 869
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "(이체는 거래처에 관계없음)"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss530i
integer x = 23
integer y = 28
integer width = 3616
integer height = 272
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

