$PBExportHeader$w_piss170i.srw
$PBExportComments$출하현황
forward
global type w_piss170i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss170i
end type
type uo_area from u_pisc_select_area within w_piss170i
end type
type uo_division from u_pisc_select_division within w_piss170i
end type
type uo_date from u_pisc_date_applydate within w_piss170i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss170i
end type
type st_2 from statictext within w_piss170i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss170i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_piss170i
end type
type dw_print from datawindow within w_piss170i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss170i
end type
type st_5 from statictext within w_piss170i
end type
type uo_2 from u_pisc_select_item_model_kdac within w_piss170i
end type
type pb_excel from picturebutton within w_piss170i
end type
type gb_1 from groupbox within w_piss170i
end type
end forward

global type w_piss170i from w_ipis_sheet01
integer width = 4416
string title = "출하현황"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_date uo_date
uo_1 uo_1
st_2 st_2
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
dw_print dw_print
uo_shipoemgubun uo_shipoemgubun
st_5 st_5
uo_2 uo_2
pb_excel pb_excel
gb_1 gb_1
end type
global w_piss170i w_piss170i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
boolean ib_open
string is_shipgubun
end variables

on w_piss170i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.uo_1=create uo_1
this.st_2=create st_2
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.dw_print=create dw_print
this.uo_shipoemgubun=create uo_shipoemgubun
this.st_5=create st_5
this.uo_2=create uo_2
this.pb_excel=create pb_excel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_date
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_productgroup
this.Control[iCurrent+8]=this.uo_modelgroup
this.Control[iCurrent+9]=this.dw_print
this.Control[iCurrent+10]=this.uo_shipoemgubun
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.uo_2
this.Control[iCurrent+13]=this.pb_excel
this.Control[iCurrent+14]=this.gb_1
end on

on w_piss170i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.uo_1)
destroy(this.st_2)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.dw_print)
destroy(this.uo_shipoemgubun)
destroy(this.st_5)
destroy(this.uo_2)
destroy(this.pb_excel)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;call super::ue_retrieve;long ll_count
string ls_itemcode

dw_sheet.reset()

ll_count = dw_sheet.retrieve(is_areacode,is_divisioncode,is_shipdate1,is_shipdate2,is_productgroup,is_modelgroup,is_itemcode,is_shipgubun)

if ll_count = 0 then
	pb_Excel.visible = false
	pb_Excel.enabled = false	
	messagebox("확인","조회된 자료가 없습니다.")
	uo_date.setfocus()
	return
end if	
pb_Excel.visible = true
pb_Excel.enabled = true	
end event

event ue_postopen;STRING ls_shipgubun,ls_codegroup,ls_codegroupname,ls_codename
dw_sheet.settransobject(sqlpis)
//dw_print.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname

f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
// f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,uo_area.is_uo_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',true,ls_codegroup,is_shipgubun,ls_codegroupname,ls_codename)
ib_open = true
end event

event ue_print;call super::ue_print;dw_print.settransobject(sqlpis)
dw_sheet.sharedata(dw_print)
String	ls_mod
str_easy	lstr_prt

ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
//ls_mod	= ls_mod 
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '출하현황'
lstr_prt.tag			= '출하현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)


end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
//dw_print.settransobject(sqlpis)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss170i
end type

type dw_sheet from u_vi_std_datawindow within w_piss170i
integer x = 18
integer y = 292
integer width = 3575
integer height = 1596
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss170i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_pisc_select_area within w_piss170i
integer x = 1417
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
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_modelgroup,ls_modelgroupname)
end if
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_areacode = is_uo_areacode
end event

type uo_division from u_pisc_select_division within w_piss170i
integer x = 1989
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
if ib_open = true then
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if
dw_sheet.reset()

end event

type uo_date from u_pisc_date_applydate within w_piss170i
integer x = 73
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_losefocus;call super::ue_losefocus;is_shipdate1 = is_uo_date
end event

event constructor;call super::constructor;is_shipdate1 = is_uo_date
end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

event ue_select;call super::ue_select;if is_shipdate1 <> is_uo_date then
	dw_sheet.reset()
end if	
is_shipdate1 = is_uo_date

end event

type uo_1 from u_pisc_date_applydate_1 within w_piss170i
integer x = 850
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate2 = is_uo_date
end event

type st_2 from statictext within w_piss170i
integer x = 763
integer y = 104
integer width = 82
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

type uo_productgroup from u_pisc_select_productgroup within w_piss170i
integer x = 73
integer y = 176
integer taborder = 40
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;string ls_productgroupname,ls_modelgroupname,ls_itemname
is_productgroup = is_uo_productgroup
if ib_open = true then
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if

end event

type uo_modelgroup from u_pisc_select_modelgroup within w_piss170i
integer x = 1042
integer y = 176
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;//string ls_itemname
is_modelgroup = is_uo_modelgroup
//if ib_open = true then
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
//end if
//  
end event

type dw_print from datawindow within w_piss170i
boolean visible = false
integer x = 2103
integer y = 784
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss170i_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_shipoemgubun from u_pisc_select_code within w_piss170i
event destroy ( )
integer x = 3118
integer y = 88
integer taborder = 110
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;call super::ue_select;is_shipgubun = is_uo_codeid
dw_sheet.reset()
dw_sheet.settransobject(sqlpis)
end event

type st_5 from statictext within w_piss170i
integer x = 2843
integer y = 100
integer width = 270
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
string text = "출하구분"
boolean focusrectangle = false
end type

type uo_2 from u_pisc_select_item_model_kdac within w_piss170i
event destroy ( )
integer x = 1970
integer y = 160
integer taborder = 60
boolean bringtotop = true
end type

on uo_2.destroy
call u_pisc_select_item_model_kdac::destroy
end on

event ue_select;call super::ue_select;is_itemcode = is_uo_itemcode
end event

type pb_excel from picturebutton within w_piss170i
boolean visible = false
integer x = 4192
integer y = 132
integer width = 155
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;long ln_net
ln_net = messagebox("확인","엑셀파일로 저장 하시겠습니까 ?",Question!,yesno!,1)
if ln_net = 1 then
	f_save_to_excel_execute(dw_sheet,'2')
end if
end event

type gb_1 from groupbox within w_piss170i
integer x = 23
integer y = 28
integer width = 4343
integer height = 256
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

