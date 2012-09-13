$PBExportHeader$w_piss540i.srw
$PBExportComments$SR현황
forward
global type w_piss540i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_piss540i
end type
type uo_division from u_pisc_select_division within w_piss540i
end type
type uo_date from u_pisc_date_applydate within w_piss540i
end type
type dw_3 from datawindow within w_piss540i
end type
type st_h_bar from uo_xc_splitbar within w_piss540i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss540i
end type
type dw_2 from u_vi_std_datawindow within w_piss540i
end type
type uo_scustgubun from u_pisc_select_code within w_piss540i
end type
type st_8 from statictext within w_piss540i
end type
type uo_custcode from u_piss_select_custcode within w_piss540i
end type
type st_5 from statictext within w_piss540i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss540i
end type
type st_3 from statictext within w_piss540i
end type
type st_4 from statictext within w_piss540i
end type
type st_6 from statictext within w_piss540i
end type
type sle_checksrno from singlelineedit within w_piss540i
end type
type sle_itemcode from singlelineedit within w_piss540i
end type
type sle_customeritemno from singlelineedit within w_piss540i
end type
type ddlb_1 from dropdownlistbox within w_piss540i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss540i
end type
type dw_4 from datawindow within w_piss540i
end type
type pb_excel from picturebutton within w_piss540i
end type
type gb_1 from groupbox within w_piss540i
end type
end forward

global type w_piss540i from w_ipis_sheet01
integer width = 4553
string title = "SR별출하현황"
boolean minbox = true
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_3 dw_3
st_h_bar st_h_bar
uo_1 uo_1
dw_2 dw_2
uo_scustgubun uo_scustgubun
st_8 st_8
uo_custcode uo_custcode
st_5 st_5
uo_shipoemgubun uo_shipoemgubun
st_3 st_3
st_4 st_4
st_6 st_6
sle_checksrno sle_checksrno
sle_itemcode sle_itemcode
sle_customeritemno sle_customeritemno
ddlb_1 ddlb_1
uo_productgroup uo_productgroup
dw_4 dw_4
pb_excel pb_excel
gb_1 gb_1
end type
global w_piss540i w_piss540i

type variables
boolean ib_open, ib_change = false
string is_shipsheetno,  is_change = 'NO', is_applydate,is_areacode,is_divisioncode,is_productgroup
string is_prddate,is_itemcode,is_shipdate,is_shipdate1
string is_security, is_modelcode, is_kbno, is_asgubun, &
         is_plantcode, is_workcenter, is_shift, is_linecode, &
         is_enddate, is_invdate, is_lotno
integer ii_window_border = 10,il_qty
integer ii_rackqty, ii_cancelqty, ii_oldcancelqty,  il_kbloopsn

string is_custcode,is_shipoemgubun,is_custgubun
end variables

on w_piss540i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.dw_3=create dw_3
this.st_h_bar=create st_h_bar
this.uo_1=create uo_1
this.dw_2=create dw_2
this.uo_scustgubun=create uo_scustgubun
this.st_8=create st_8
this.uo_custcode=create uo_custcode
this.st_5=create st_5
this.uo_shipoemgubun=create uo_shipoemgubun
this.st_3=create st_3
this.st_4=create st_4
this.st_6=create st_6
this.sle_checksrno=create sle_checksrno
this.sle_itemcode=create sle_itemcode
this.sle_customeritemno=create sle_customeritemno
this.ddlb_1=create ddlb_1
this.uo_productgroup=create uo_productgroup
this.dw_4=create dw_4
this.pb_excel=create pb_excel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.st_h_bar
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.uo_scustgubun
this.Control[iCurrent+9]=this.st_8
this.Control[iCurrent+10]=this.uo_custcode
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.uo_shipoemgubun
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.st_4
this.Control[iCurrent+15]=this.st_6
this.Control[iCurrent+16]=this.sle_checksrno
this.Control[iCurrent+17]=this.sle_itemcode
this.Control[iCurrent+18]=this.sle_customeritemno
this.Control[iCurrent+19]=this.ddlb_1
this.Control[iCurrent+20]=this.uo_productgroup
this.Control[iCurrent+21]=this.dw_4
this.Control[iCurrent+22]=this.pb_excel
this.Control[iCurrent+23]=this.gb_1
end on

on w_piss540i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_3)
destroy(this.st_h_bar)
destroy(this.uo_1)
destroy(this.dw_2)
destroy(this.uo_scustgubun)
destroy(this.st_8)
destroy(this.uo_custcode)
destroy(this.st_5)
destroy(this.uo_shipoemgubun)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.sle_checksrno)
destroy(this.sle_itemcode)
destroy(this.sle_customeritemno)
destroy(this.ddlb_1)
destroy(this.uo_productgroup)
destroy(this.dw_4)
destroy(this.pb_excel)
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
string ls_custcode,ls_itemcode,ls_checksrno,ls_customeritemno,ls_gubun
if is_shipoemgubun = 'X' then //이체면
   ls_custcode = '%'
else
	ls_custcode = is_custcode
end if	
ls_gubun = left(ddlb_1.text,1)
ls_checksrno = trim(sle_checksrno.text)
ls_itemcode = trim(sle_itemcode.text)
ls_customeritemno = trim(sle_customeritemno.text)
if ls_checksrno = '' or isnull(ls_checksrno) then
	ls_checksrno = '%'
end if	
if ls_itemcode = '' or isnull(ls_itemcode) then
	ls_itemcode = '%'
end if	
if ls_customeritemno = '' or isnull(ls_customeritemno) then
	ls_customeritemno = '%'
end if	


setpointer(hourglass!)
ll_count = dw_2.retrieve(ls_gubun,is_areacode,is_divisioncode,is_shipdate,is_shipdate1,ls_custcode,is_shipoemgubun,ls_checksrno,ls_itemcode,ls_customeritemno,is_productgroup)
dw_3.reset()
dw_4.reset()
setpointer(arrow!)
if ll_count = 0 then
	pb_excel.visible = false
	pb_excel.enabled = false	
	messagebox("확인","조회된 자료가 없습니다.")
else
	pb_excel.visible = true
	pb_excel.enabled = true	
	dw_4.retrieve(ls_gubun,is_areacode,is_divisioncode,is_shipdate,is_shipdate1,ls_custcode,is_shipoemgubun,ls_checksrno,ls_itemcode,ls_customeritemno,is_productgroup)
end if	

end event

event activate;call super::activate;dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_4.settransobject(sqlpis)
end event

event ue_postopen;call super::ue_postopen;string ls_codegroup,ls_codegroupname,ls_codename,ls_custname
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',TRUE,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',true,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',true,is_custcode,ls_custname)
ddlb_1.text = '1.납품일기준'
end event

event ue_print;call super::ue_print;if dw_4.getrow() > 0 then
	string mod_costring = ""
	mod_costring = "gs_date_t.text = '" + f_get_systemdate(sqlpis) +"'"
	dw_4.modify(mod_costring)
	dw_4.print()
else
	messagebox("확인","출력할 정보가 없습니다")
end if
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss540i
end type

type uo_area from u_pisc_select_area within w_piss540i
integer x = 1710
integer y = 100
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
if is_areacode = 'D' then
	f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
else
	f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)	
end if	
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
pb_excel.visible = false
pb_excel.enabled = false
dw_2.reset()
dw_3.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng,ls_productgroupname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_piss540i
integer x = 2199
integer y = 104
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

event ue_select;call super::ue_select;string ls_productgroupname
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)

pb_excel.visible = false
pb_excel.enabled = false
dw_2.reset()
dw_3.reset()
is_divisioncode = is_uo_divisioncode
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)

end event

type uo_date from u_pisc_date_applydate within w_piss540i
integer x = 585
integer y = 100
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

type dw_3 from datawindow within w_piss540i
integer x = 50
integer y = 1136
integer width = 2587
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

type st_h_bar from uo_xc_splitbar within w_piss540i
integer x = 64
integer y = 1428
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_2,ABOVE)
of_register(dw_3,BELOW)
end event

type uo_1 from u_pisc_date_applydate_1 within w_piss540i
event destroy ( )
integer x = 1266
integer y = 100
integer taborder = 50
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_date
pb_excel.visible = false
pb_excel.enabled = false
dw_2.reset()
dw_3.reset()
end event

type dw_2 from u_vi_std_datawindow within w_piss540i
integer x = 41
integer y = 316
integer width = 3497
integer height = 712
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_piss540i_01"
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

type uo_scustgubun from u_pisc_select_code within w_piss540i
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
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
pb_excel.visible = false
pb_excel.enabled = false
dw_2.reset()
dw_3.reset()


end event

event ue_post_constructor;string ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

type st_8 from statictext within w_piss540i
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

type uo_custcode from u_piss_select_custcode within w_piss540i
event destroy ( )
integer x = 1161
integer y = 196
integer taborder = 90
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
pb_excel.visible = false
pb_excel.enabled = false
dw_2.reset()
dw_3.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

type st_5 from statictext within w_piss540i
integer x = 2757
integer y = 112
integer width = 155
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
string text = "구분"
boolean focusrectangle = false
end type

type uo_shipoemgubun from u_pisc_select_code within w_piss540i
event destroy ( )
integer x = 2903
integer y = 104
integer width = 709
integer taborder = 70
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;call super::ue_select;is_shipoemgubun = is_uo_codeid
pb_excel.visible = false
pb_excel.enabled = false
dw_2.reset()
dw_3.reset()
end event

event ue_post_constructor;is_shipoemgubun = is_uo_codeid

end event

type st_3 from statictext within w_piss540i
integer x = 2194
integer y = 208
integer width = 206
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
string text = "SR번호"
boolean focusrectangle = false
end type

type st_4 from statictext within w_piss540i
integer x = 2857
integer y = 204
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

type st_6 from statictext within w_piss540i
integer x = 3525
integer y = 208
integer width = 329
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
string text = "거래처품번"
boolean focusrectangle = false
end type

type sle_checksrno from singlelineedit within w_piss540i
integer x = 2405
integer y = 192
integer width = 389
integer height = 76
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_itemcode from singlelineedit within w_piss540i
integer x = 2999
integer y = 192
integer width = 457
integer height = 76
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type sle_customeritemno from singlelineedit within w_piss540i
integer x = 3858
integer y = 192
integer width = 443
integer height = 76
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type ddlb_1 from dropdownlistbox within w_piss540i
integer x = 59
integer y = 92
integer width = 512
integer height = 324
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
string item[] = {"1.납품일기준","2.입력일기준"}
borderstyle borderstyle = stylelowered!
end type

type uo_productgroup from u_pisc_select_productgroup within w_piss540i
event destroy ( )
integer x = 3611
integer y = 104
integer taborder = 90
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;string ls_productgroupname,ls_modelgroupname,ls_itemname
is_productgroup = is_uo_productgroup

end event

type dw_4 from datawindow within w_piss540i
boolean visible = false
integer x = 1234
integer y = 280
integer width = 686
integer height = 400
integer taborder = 100
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_piss540i_01_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_piss540i
boolean visible = false
integer x = 4325
integer y = 180
integer width = 155
integer height = 132
integer taborder = 100
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

event clicked;f_save_to_excel(dw_2)
end event

type gb_1 from groupbox within w_piss540i
integer x = 23
integer y = 28
integer width = 4480
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
end type

