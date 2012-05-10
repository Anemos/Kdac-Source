$PBExportHeader$w_piss190i.srw
$PBExportComments$생산/출하/재고현황
forward
global type w_piss190i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss190i
end type
type uo_area from u_pisc_select_area within w_piss190i
end type
type uo_division from u_pisc_select_division within w_piss190i
end type
type dw_print from datawindow within w_piss190i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss190i
end type
type ddlb_1 from dropdownlistbox within w_piss190i
end type
type st_2 from statictext within w_piss190i
end type
type st_3 from statictext within w_piss190i
end type
type em_1 from editmask within w_piss190i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss190i
end type
type uo_date from u_pisc_date_firstday within w_piss190i
end type
type gb_1 from groupbox within w_piss190i
end type
end forward

global type w_piss190i from w_ipis_sheet01
integer width = 4585
string title = "생산/출하/재고현황"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
dw_print dw_print
uo_productgroup uo_productgroup
ddlb_1 ddlb_1
st_2 st_2
st_3 st_3
em_1 em_1
uo_1 uo_1
uo_date uo_date
gb_1 gb_1
end type
global w_piss190i w_piss190i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
string is_custgubun,is_custcode,is_shipoemgubun
boolean ib_open
end variables

on w_piss190i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_print=create dw_print
this.uo_productgroup=create uo_productgroup
this.ddlb_1=create ddlb_1
this.st_2=create st_2
this.st_3=create st_3
this.em_1=create em_1
this.uo_1=create uo_1
this.uo_date=create uo_date
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.dw_print
this.Control[iCurrent+5]=this.uo_productgroup
this.Control[iCurrent+6]=this.ddlb_1
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_3
this.Control[iCurrent+9]=this.em_1
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.uo_date
this.Control[iCurrent+12]=this.gb_1
end on

on w_piss190i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_print)
destroy(this.uo_productgroup)
destroy(this.ddlb_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.uo_1)
destroy(this.uo_date)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;long ll_rowcount
string ls_itemtype,ls_itemcode
ls_itemtype = left(ddlb_1.text,1)
ls_itemcode = trim(em_1.text)
if ls_itemcode = '' or isnull(ls_itemcode) then
	ls_itemcode = '%'
end if
ll_rowcount =  dw_sheet.retrieve(is_areacode,is_divisioncode,is_shipdate1,is_shipdate2,is_productgroup,ls_itemtype,ls_itemcode)

if ll_rowcount = 0  then 
	MessageBox('확인','조회할 자료가 없읍니다.')
   return
end if

end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname
string ls_codegroup,ls_codegroupname,ls_codename
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
ib_open = true
ddlb_1.text = '%. 전체'
end event

event ue_print;call super::ue_print;dw_sheet.sharedata(dw_print)
String	ls_mod
str_easy	lstr_prt

ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '생산출하재고현황'
lstr_prt.tag			= '생산출하재고현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss190i
end type

type dw_sheet from u_vi_std_datawindow within w_piss190i
integer x = 18
integer y = 216
integer width = 3575
integer height = 1572
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss190i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_area from u_pisc_select_area within w_piss190i
integer x = 1239
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname

is_areacode = is_uo_areacode
if ib_open = true then
	f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
   f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
end if
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_areacode = is_uo_areacode
end event

type uo_division from u_pisc_select_division within w_piss190i
integer x = 1733
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_productgroupname,ls_modelgroupname,ls_itemname
is_divisioncode = is_uo_divisioncode
dw_sheet.reset()
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)

end event

type dw_print from datawindow within w_piss190i
boolean visible = false
integer x = 2103
integer y = 784
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss190i_02"
boolean minbox = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_productgroup from u_pisc_select_productgroup within w_piss190i
integer x = 2309
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;call super::ue_select;string ls_productgroupname,ls_modelgroupname,ls_itemname
is_productgroup = is_uo_productgroup

end event

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

type ddlb_1 from dropdownlistbox within w_piss190i
integer x = 3365
integer y = 92
integer width = 443
integer height = 588
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"%. 전체","1. 원재료","2.단품","3.반제품","4.상품","5.완제품","6.기타"}
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_piss190i
integer x = 3214
integer y = 112
integer width = 146
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
string text = "구분"
boolean focusrectangle = false
end type

type st_3 from statictext within w_piss190i
integer x = 3886
integer y = 108
integer width = 146
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
string text = "품번"
boolean focusrectangle = false
end type

type em_1 from editmask within w_piss190i
integer x = 4023
integer y = 92
integer width = 489
integer height = 88
integer taborder = 50
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
end type

type uo_1 from u_pisc_date_applydate_1 within w_piss190i
integer x = 754
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event constructor;call super::constructor;is_shipdate2 = is_uo_date
end event

event ue_select;call super::ue_select;if is_shipdate2 <> is_uo_date then
	dw_sheet.reset()
end if	
is_shipdate2 = is_uo_date

end event

event ue_losefocus;is_shipdate2 = is_uo_date
end event

type uo_date from u_pisc_date_firstday within w_piss190i
event destroy ( )
integer x = 59
integer y = 96
integer taborder = 20
boolean bringtotop = true
end type

on uo_date.destroy
call u_pisc_date_firstday::destroy
end on

event constructor;call super::constructor;is_shipdate1 = is_uo_date
end event

event ue_select;call super::ue_select;if is_shipdate1 <> is_uo_date then
	dw_sheet.reset()
end if	
is_shipdate1 = is_uo_date

end event

event ue_losefocus;call super::ue_losefocus;is_shipdate1 = is_uo_date

end event

type gb_1 from groupbox within w_piss190i
integer x = 23
integer y = 28
integer width = 4517
integer height = 176
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

