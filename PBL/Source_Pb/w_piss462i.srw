$PBExportHeader$w_piss462i.srw
$PBExportComments$품번별SR조회
forward
global type w_piss462i from w_ipis_sheet01
end type
type uo_division1 from u_pisc_select_division within w_piss462i
end type
type uo_area from u_pisc_select_area within w_piss462i
end type
type uo_date from u_pisc_date_applydate within w_piss462i
end type
type st_2 from statictext within w_piss462i
end type
type uo_1 from u_pisc_date_applydate_1 within w_piss462i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss462i
end type
type st_5 from statictext within w_piss462i
end type
type st_8 from statictext within w_piss462i
end type
type sle_itemcode from singlelineedit within w_piss462i
end type
type sle_itemname from singlelineedit within w_piss462i
end type
type st_3 from statictext within w_piss462i
end type
type em_1 from editmask within w_piss462i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss462i
end type
type dw_print from datawindow within w_piss462i
end type
type uo_division from u_pisc_select_division within w_piss462i
end type
type gb_1 from groupbox within w_piss462i
end type
type dw_sheet from u_vi_std_datawindow within w_piss462i
end type
type st_4 from statictext within w_piss462i
end type
type sle_custcode from singlelineedit within w_piss462i
end type
end forward

global type w_piss462i from w_ipis_sheet01
integer width = 4517
integer height = 2700
string title = "품번별SR조회"
event ue_postopen ( )
uo_division1 uo_division1
uo_area uo_area
uo_date uo_date
st_2 st_2
uo_1 uo_1
uo_shipoemgubun uo_shipoemgubun
st_5 st_5
st_8 st_8
sle_itemcode sle_itemcode
sle_itemname sle_itemname
st_3 st_3
em_1 em_1
uo_productgroup uo_productgroup
dw_print dw_print
uo_division uo_division
gb_1 gb_1
dw_sheet dw_sheet
st_4 st_4
sle_custcode sle_custcode
end type
global w_piss462i w_piss462i

type variables
string is_date, is_today
int ii_window_border = 10
boolean ib_open
string is_security, is_pgmid, is_pgmname,is_productgroup

datawindow idw_srorder, idw_public, idw_nodaewoo, &
                     idw_srorder1, idw_current
integer ii_selectrow
string is_modelcode, is_custcode, is_modelgubun,  is_mod[],is_custgubun
string is_shipoemgubun,is_areacode,is_divisioncode,is_shipdate,is_shipdate1
datawindowchild idwc_rpt1
Long il_purple = 8388736, il_text = 33554432
string is_itemcode
end variables

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_codegroup,ls_codegroupname,ls_codename,ls_productgroupname
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',true,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
end event

on w_piss462i.create
int iCurrent
call super::create
this.uo_division1=create uo_division1
this.uo_area=create uo_area
this.uo_date=create uo_date
this.st_2=create st_2
this.uo_1=create uo_1
this.uo_shipoemgubun=create uo_shipoemgubun
this.st_5=create st_5
this.st_8=create st_8
this.sle_itemcode=create sle_itemcode
this.sle_itemname=create sle_itemname
this.st_3=create st_3
this.em_1=create em_1
this.uo_productgroup=create uo_productgroup
this.dw_print=create dw_print
this.uo_division=create uo_division
this.gb_1=create gb_1
this.dw_sheet=create dw_sheet
this.st_4=create st_4
this.sle_custcode=create sle_custcode
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_division1
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.uo_1
this.Control[iCurrent+6]=this.uo_shipoemgubun
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.sle_itemcode
this.Control[iCurrent+10]=this.sle_itemname
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.em_1
this.Control[iCurrent+13]=this.uo_productgroup
this.Control[iCurrent+14]=this.dw_print
this.Control[iCurrent+15]=this.uo_division
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.dw_sheet
this.Control[iCurrent+18]=this.st_4
this.Control[iCurrent+19]=this.sle_custcode
end on

on w_piss462i.destroy
call super::destroy
destroy(this.uo_division1)
destroy(this.uo_area)
destroy(this.uo_date)
destroy(this.st_2)
destroy(this.uo_1)
destroy(this.uo_shipoemgubun)
destroy(this.st_5)
destroy(this.st_8)
destroy(this.sle_itemcode)
destroy(this.sle_itemname)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.uo_productgroup)
destroy(this.dw_print)
destroy(this.uo_division)
destroy(this.gb_1)
destroy(this.dw_sheet)
destroy(this.st_4)
destroy(this.sle_custcode)
end on

event resize;call super::resize;il_resize_count ++

of_resize_register(dw_sheet, full)
//of_resize_register(st_v_bar, SPLIT)
//of_resize_register(dw_2, RIGHT)

of_resize()
end event

event ue_retrieve;string ls_itemcode,ls_customeritemno,ls_custcode
ls_itemcode = trim(sle_itemcode.text)
ls_customeritemno = trim(em_1.text)
ls_custcode	= trim(sle_custcode.text)
if ls_custcode = '' or isnull(ls_custcode) then
   	ls_custcode = '%'
else
	ls_custcode = ls_custcode + '%'		
end if
if ls_itemcode = '' or isnull(ls_itemcode) then
	ls_itemcode = '%'
end if	
if ls_customeritemno = '' or isnull(ls_customeritemno) then
	ls_customeritemno = '%'
end if	
dw_sheet.sharedata(dw_print)
setpointer(hourglass!)
dw_sheet.reset()
dw_sheet.retrieve(is_areacode,is_divisioncode,is_shipdate,is_shipdate1,is_shipoemgubun,ls_itemcode,ls_custcode,ls_customeritemno,is_productgroup)
setpointer(arrow!)
if dw_sheet.rowcount() = 0 then
	messagebox("확인","조회할 자료가 없읍니다." )
	return
end if
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
end event

event ue_print;dw_print.settransobject(sqlpis)
dw_sheet.sharedata(dw_print)
String	ls_mod
str_easy	lstr_prt

//ls_mod	= "st_msg.Text = '" + "기준일 : " + uo_date.is_uo_date + "' "
//ls_mod	= ls_mod 
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '품번SR현황'
lstr_prt.tag			= '품번SR현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss462i
end type

type uo_division1 from u_pisc_select_division within w_piss462i
boolean visible = false
integer x = 1385
integer y = 1504
integer taborder = 50
boolean bringtotop = true
end type

on uo_division1.destroy
call u_pisc_select_division::destroy
end on

type uo_area from u_pisc_select_area within w_piss462i
integer x = 1294
integer y = 104
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng,ls_productgroupname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)

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

type uo_date from u_pisc_date_applydate within w_piss462i
integer x = 73
integer y = 96
integer taborder = 60
boolean bringtotop = true
end type

event constructor;call super::constructor;is_shipdate = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate = is_uo_date
end event

event ue_select;if is_shipdate <> is_uo_date then
	dw_sheet.reset()
end if	
is_shipdate = is_uo_date

end event

on uo_date.destroy
call u_pisc_date_applydate::destroy
end on

type st_2 from statictext within w_piss462i
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

type uo_1 from u_pisc_date_applydate_1 within w_piss462i
event destroy ( )
integer x = 832
integer y = 100
integer taborder = 60
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;is_shipdate1 = is_uo_date
dw_sheet.reset()
end event

type uo_shipoemgubun from u_pisc_select_code within w_piss462i
integer x = 2638
integer y = 104
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_shipoemgubun = is_uo_codeid

dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_shipoemgubun = is_uo_codeid

end event

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

type st_5 from statictext within w_piss462i
integer x = 2363
integer y = 116
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

type st_8 from statictext within w_piss462i
integer x = 974
integer y = 216
integer width = 178
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "품번:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_itemcode from singlelineedit within w_piss462i
integer x = 1161
integer y = 204
integer width = 425
integer height = 72
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_itemcode,ls_itemname
ls_itemcode = trim(sle_itemcode.Text)

select itemname 
  into :ls_itemname
  from tmstitem
 where itemcode = :ls_itemcode
 using sqlpis;
sle_itemname.text = ls_itemname

end event

type sle_itemname from singlelineedit within w_piss462i
integer x = 1591
integer y = 204
integer width = 873
integer height = 72
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_piss462i
integer x = 3209
integer y = 208
integer width = 343
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
string text = "거래처품번"
boolean focusrectangle = false
end type

type em_1 from editmask within w_piss462i
integer x = 3579
integer y = 200
integer width = 658
integer height = 72
integer taborder = 60
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
maskdatatype maskdatatype = stringmask!
end type

type uo_productgroup from u_pisc_select_productgroup within w_piss462i
integer x = 73
integer y = 204
integer taborder = 50
boolean bringtotop = true
end type

event ue_select;call super::ue_select;string ls_productgroupname,ls_modelgroupname,ls_itemname
is_productgroup = is_uo_productgroup

end event

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

type dw_print from datawindow within w_piss462i
boolean visible = false
integer x = 2880
integer y = 572
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss462i_02_rev1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_division from u_pisc_select_division within w_piss462i
event destroy ( )
integer x = 1806
integer y = 104
integer taborder = 70
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;string ls_productgroupname
dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
is_divisioncode = is_uo_divisioncode
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
end event

event ue_post_constructor;call super::ue_post_constructor;is_divisioncode = is_uo_divisioncode
end event

type gb_1 from groupbox within w_piss462i
integer x = 23
integer y = 28
integer width = 4421
integer height = 268
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

type dw_sheet from u_vi_std_datawindow within w_piss462i
integer x = 27
integer y = 308
integer width = 2048
integer height = 2088
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss462i_01_rev1"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type st_4 from statictext within w_piss462i
integer x = 2533
integer y = 208
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
string text = "거래처"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_custcode from singlelineedit within w_piss462i
integer x = 2821
integer y = 200
integer width = 320
integer height = 72
integer taborder = 200
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

