$PBExportHeader$w_piss520u.srw
$PBExportComments$차량번호변경
forward
global type w_piss520u from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss520u
end type
type uo_division from u_pisc_select_division within w_piss520u
end type
type uo_date from u_pisc_date_applydate within w_piss520u
end type
type dw_2 from u_vi_std_datawindow within w_piss520u
end type
type st_2 from statictext within w_piss520u
end type
type em_1 from editmask within w_piss520u
end type
type st_3 from statictext within w_piss520u
end type
type st_4 from statictext within w_piss520u
end type
type em_2 from editmask within w_piss520u
end type
type em_3 from editmask within w_piss520u
end type
type gb_1 from groupbox within w_piss520u
end type
end forward

global type w_piss520u from w_ipis_sheet01
integer width = 4535
string title = "차량번호변경"
boolean minbox = true
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_2 dw_2
st_2 st_2
em_1 em_1
st_3 st_3
st_4 st_4
em_2 em_2
em_3 em_3
gb_1 gb_1
end type
global w_piss520u w_piss520u

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

on w_piss520u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.dw_2=create dw_2
this.st_2=create st_2
this.em_1=create em_1
this.st_3=create st_3
this.st_4=create st_4
this.em_2=create em_2
this.em_3=create em_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.em_1
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.em_2
this.Control[iCurrent+10]=this.em_3
this.Control[iCurrent+11]=this.gb_1
end on

on w_piss520u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.em_1)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.em_2)
destroy(this.em_3)
destroy(this.gb_1)
end on

event open;call super::open;dw_2.settransobject(sqlpis)

end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_2, full)

of_resize()
end event

event ue_retrieve;long ll_count,ll_truckorder
string ls_truckno
ll_truckorder = long(em_1.text)
ls_truckno    = trim(em_2.text)

setpointer(hourglass!)
ll_count = dw_2.retrieve(is_areacode,is_divisioncode,is_shipdate,ll_truckorder,ls_truckno)
setpointer(arrow!)
if ll_count = 0 then
	messagebox("확인","조회된 자료가 없습니다.")
end if	

end event

event activate;call super::activate;dw_2.settransobject(sqlpis)

end event

event ue_save;call super::ue_save;string ls_new_truckno,ls_truckno
long ll_truckorder

ll_truckorder = long(em_1.text)
ls_truckno    = trim(em_2.text)
ls_new_truckno = trim(em_3.text)


ls_new_truckno = trim(em_3.text)
if ls_new_truckno = '' or isnull(ls_new_truckno) then
	messagebox("확인","변경 차량번호를 입력하세요.")
	em_3.setfocus()
	return
end if

if dw_2.rowcount() = 0 then
	messagebox("확인","조회 후 작업하세요.")
	em_2.setfocus()
	return
end if
integer Net
Net = messagebox("확인",ls_truckno + '를 ' + ls_new_truckno + '로 변경하시겠읍니까?',Exclamation!, OKCancel!, 1)
if net = 2 then
	return 
end if	
sqlpis.autocommit = true
update tloadplan
   set truckno = :ls_new_truckno
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and shipplandate = :is_shipdate
	and truckorder   = :ll_truckorder
	and truckno      = :ls_truckno
using sqlpis;

update tloadplanhis
   set truckno = :ls_new_truckno
 where areacode = :is_areacode
   and divisioncode = :is_divisioncode
	and shipplandate = :is_shipdate
	and truckorder   = :ll_truckorder
	and truckno      = :ls_truckno
using sqlpis;

update tshipsheet
   set truckno = :ls_new_truckno
 where areacode     = :is_areacode
   and divisioncode = :is_divisioncode
	and shipdate     = :is_shipdate
	and truckorder   = :ll_truckorder
	and truckno      = :ls_truckno
using sqlpis;
commit using sqlpis;
sqlpis.autocommit = true

em_3.text = ''
postevent('ue_retireve')
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss520u
end type

type uo_area from u_pisc_select_area within w_piss520u
integer x = 827
integer y = 96
integer taborder = 20
boolean bringtotop = true
end type

event ue_select;dw_2.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
dw_2.reset()

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

type uo_division from u_pisc_select_division within w_piss520u
integer x = 1367
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;dw_2.settransobject(sqlpis)

dw_2.reset()
is_divisioncode = is_uo_divisioncode

end event

type uo_date from u_pisc_date_applydate within w_piss520u
integer x = 73
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event constructor;call super::constructor;is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;call super::ue_select;if is_shipdate <> is_uo_date then
	dw_2.reset()
end if	
is_shipdate = is_uo_date

end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type dw_2 from u_vi_std_datawindow within w_piss520u
integer x = 41
integer y = 220
integer width = 3246
integer height = 836
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss520u_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;call super::clicked;//if row < 1 then 
//	return
//end if	
//string ls_divisioncode,ls_shipsheetno,ls_shipdate
//ls_divisioncode = dw_2.object.divisioncode[row]
//ls_shipsheetno  = dw_2.object.shipsheetno[row]
//ls_shipdate     = dw_2.object.shipdate[row]
//dw_3.retrieve(is_areacode,ls_divisioncode,ls_shipsheetno,ls_shipdate)
//
end event

type st_2 from statictext within w_piss520u
integer x = 1979
integer y = 104
integer width = 288
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
string text = "차량순번"
boolean focusrectangle = false
end type

type em_1 from editmask within w_piss520u
integer x = 2249
integer y = 92
integer width = 174
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "1"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "##0"
end type

event modified;dw_2.reset()
end event

type st_3 from statictext within w_piss520u
integer x = 2514
integer y = 104
integer width = 398
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
string text = "기존차량번호"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss520u
integer x = 3479
integer y = 108
integer width = 398
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
string text = "변경차량번호"
boolean focusrectangle = false
end type

type em_2 from editmask within w_piss520u
integer x = 2907
integer y = 84
integer width = 539
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxx"
end type

event modified;dw_2.reset()
end event

type em_3 from editmask within w_piss520u
integer x = 3872
integer y = 80
integer width = 539
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxx"
end type

type gb_1 from groupbox within w_piss520u
integer x = 23
integer y = 28
integer width = 4411
integer height = 172
integer taborder = 80
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

