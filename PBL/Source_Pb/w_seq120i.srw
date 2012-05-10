$PBExportHeader$w_seq120i.srw
$PBExportComments$S/R별 출하현황(Sequence)
forward
global type w_seq120i from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_seq120i
end type
type uo_division from u_pisc_select_division within w_seq120i
end type
type uo_date from u_pisc_date_applydate within w_seq120i
end type
type dw_3 from datawindow within w_seq120i
end type
type st_h_bar from uo_xc_splitbar within w_seq120i
end type
type uo_1 from u_pisc_date_applydate_1 within w_seq120i
end type
type dw_2 from u_vi_std_datawindow within w_seq120i
end type
type st_5 from statictext within w_seq120i
end type
type uo_shipoemgubun from u_pisc_select_code within w_seq120i
end type
type st_3 from statictext within w_seq120i
end type
type st_4 from statictext within w_seq120i
end type
type st_6 from statictext within w_seq120i
end type
type sle_checksrno from singlelineedit within w_seq120i
end type
type sle_itemcode from singlelineedit within w_seq120i
end type
type sle_customeritemno from singlelineedit within w_seq120i
end type
type ddlb_1 from dropdownlistbox within w_seq120i
end type
type uo_productgroup from u_pisc_select_productgroup within w_seq120i
end type
type st_2 from statictext within w_seq120i
end type
type ddlb_2 from dropdownlistbox within w_seq120i
end type
type st_7 from statictext within w_seq120i
end type
type sle_1 from singlelineedit within w_seq120i
end type
type st_8 from statictext within w_seq120i
end type
type ddlb_stock from dropdownlistbox within w_seq120i
end type
type pb_1 from picturebutton within w_seq120i
end type
type gb_1 from groupbox within w_seq120i
end type
end forward

global type w_seq120i from w_ipis_sheet01
integer width = 4553
integer height = 2120
string title = "SR별출하현황"
boolean minbox = true
uo_area uo_area
uo_division uo_division
uo_date uo_date
dw_3 dw_3
st_h_bar st_h_bar
uo_1 uo_1
dw_2 dw_2
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
st_2 st_2
ddlb_2 ddlb_2
st_7 st_7
sle_1 sle_1
st_8 st_8
ddlb_stock ddlb_stock
pb_1 pb_1
gb_1 gb_1
end type
global w_seq120i w_seq120i

type variables
boolean ib_open, ib_change = false
string is_change = 'NO', is_areacode,is_divisioncode,is_productgroup
string is_itemcode,is_shipdate,is_shipdate1
integer ii_window_border = 10 
string is_custcode,is_shipoemgubun
end variables

on w_seq120i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.dw_3=create dw_3
this.st_h_bar=create st_h_bar
this.uo_1=create uo_1
this.dw_2=create dw_2
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
this.st_2=create st_2
this.ddlb_2=create ddlb_2
this.st_7=create st_7
this.sle_1=create sle_1
this.st_8=create st_8
this.ddlb_stock=create ddlb_stock
this.pb_1=create pb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_date
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.st_h_bar
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.st_5
this.Control[iCurrent+9]=this.uo_shipoemgubun
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.st_4
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.sle_checksrno
this.Control[iCurrent+14]=this.sle_itemcode
this.Control[iCurrent+15]=this.sle_customeritemno
this.Control[iCurrent+16]=this.ddlb_1
this.Control[iCurrent+17]=this.uo_productgroup
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.ddlb_2
this.Control[iCurrent+20]=this.st_7
this.Control[iCurrent+21]=this.sle_1
this.Control[iCurrent+22]=this.st_8
this.Control[iCurrent+23]=this.ddlb_stock
this.Control[iCurrent+24]=this.pb_1
this.Control[iCurrent+25]=this.gb_1
end on

on w_seq120i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.dw_3)
destroy(this.st_h_bar)
destroy(this.uo_1)
destroy(this.dw_2)
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
destroy(this.st_2)
destroy(this.ddlb_2)
destroy(this.st_7)
destroy(this.sle_1)
destroy(this.st_8)
destroy(this.ddlb_stock)
destroy(this.pb_1)
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
string ls_custcode,ls_itemcode,ls_checksrno,ls_customeritemno,ls_gubun,ls_shipeditno,ls_saleconfirm
if is_shipoemgubun = 'X' then //이체면
   ls_custcode = '%'
else
	ls_custcode = is_custcode
end if	
ls_gubun = left(ddlb_1.text,1)
if ddlb_stock.text = '전체' then
	ls_saleconfirm	= '%'
elseif ddlb_stock.text = '확인' then
	ls_saleconfirm	= 'Y'	
elseif ddlb_stock.text = '미확인' then
	ls_saleconfirm	= 'N'	
else
	ls_saleconfirm	= ' '
end if
ls_shipeditno		= trim(sle_1.text)
ls_checksrno 		= trim(sle_checksrno.text)
ls_itemcode 		= trim(sle_itemcode.text)
ls_customeritemno = trim(sle_customeritemno.text)
if ls_shipeditno 	= '' or isnull(ls_shipeditno) then
	ls_shipeditno 	= '%'
end if
if ls_checksrno 	= '' or isnull(ls_checksrno) then
	ls_checksrno 	= '%'
end if	
if ls_itemcode 	= '' or isnull(ls_itemcode) then
	ls_itemcode 	= '%'
end if	
if ls_customeritemno = '' or isnull(ls_customeritemno) then
	ls_customeritemno = '%'
end if	
setpointer(hourglass!)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
dw_2.reset()
ll_count = dw_2.retrieve(ls_gubun,is_areacode,is_divisioncode,is_shipdate,is_shipdate1,ls_custcode,is_shipoemgubun,ls_checksrno,ls_itemcode,ls_customeritemno,is_productgroup,ls_shipeditno,ls_saleconfirm)
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
ddlb_1.text = '1.납품일기준'
ddlb_stock.text = '전체'
ddlb_2.text = "대우자동차(군산)"
is_custcode = 'L10502'

end event

type uo_status from w_ipis_sheet01`uo_status within w_seq120i
end type

type uo_area from u_pisc_select_area within w_seq120i
integer x = 1710
integer y = 80
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;string ls_divisionname,ls_divisionnameeng,ls_productgroupname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
if is_areacode = 'D' then
	f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
else
	f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)	
end if	
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
dw_2.settransobject(sqlpis)
dw_3.settransobject(sqlpis)
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

type uo_division from u_pisc_select_division within w_seq120i
integer x = 2199
integer y = 80
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

dw_2.reset()
dw_3.reset()
is_divisioncode = is_uo_divisioncode
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)

end event

type uo_date from u_pisc_date_applydate within w_seq120i
integer x = 585
integer y = 80
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

type dw_3 from datawindow within w_seq120i
integer x = 96
integer y = 1592
integer width = 411
integer height = 712
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq_srinquiry_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_h_bar from uo_xc_splitbar within w_seq120i
integer x = 64
integer y = 1716
integer width = 901
integer height = 16
boolean bringtotop = true
end type

event constructor;call super::constructor;of_register(dw_2,ABOVE)
of_register(dw_3,BELOW)
end event

type uo_1 from u_pisc_date_applydate_1 within w_seq120i
event destroy ( )
integer x = 1266
integer y = 80
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

type dw_2 from u_vi_std_datawindow within w_seq120i
integer x = 41
integer y = 316
integer width = 3497
integer height = 1472
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_seq_srinquiry_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event clicked;call super::clicked;if row < 1 then 
	return
end if	
string ls_srno
ls_srno = dw_2.object.srno[row]
dw_3.retrieve(ls_srno)

end event

type st_5 from statictext within w_seq120i
integer x = 3634
integer y = 88
integer width = 174
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
string text = "구분:"
boolean focusrectangle = false
end type

type uo_shipoemgubun from u_pisc_select_code within w_seq120i
event destroy ( )
integer x = 3794
integer y = 76
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

type st_3 from statictext within w_seq120i
integer x = 2080
integer y = 212
integer width = 238
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
string text = "SR번호:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_seq120i
integer x = 2807
integer y = 212
integer width = 174
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
boolean focusrectangle = false
end type

type st_6 from statictext within w_seq120i
integer x = 3447
integer y = 212
integer width = 366
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
string text = "거래처품번:"
boolean focusrectangle = false
end type

type sle_checksrno from singlelineedit within w_seq120i
integer x = 2313
integer y = 196
integer width = 448
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

type sle_itemcode from singlelineedit within w_seq120i
integer x = 2976
integer y = 196
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

type sle_customeritemno from singlelineedit within w_seq120i
integer x = 3794
integer y = 196
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

type ddlb_1 from dropdownlistbox within w_seq120i
integer x = 59
integer y = 76
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

type uo_productgroup from u_pisc_select_productgroup within w_seq120i
event destroy ( )
integer x = 2743
integer y = 80
integer taborder = 90
boolean bringtotop = true
end type

on uo_productgroup.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;string ls_productgroupname,ls_modelgroupname,ls_itemname
is_productgroup = is_uo_productgroup

end event

type st_2 from statictext within w_seq120i
integer x = 59
integer y = 212
integer width = 238
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
string text = "거래처:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_2 from dropdownlistbox within w_seq120i
integer x = 302
integer y = 196
integer width = 677
integer height = 324
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 15780518
boolean sorted = false
string item[] = {"대우자동차(부평)","대우자동차(군산)"}
borderstyle borderstyle = stylelowered!
end type

event constructor;is_custcode = 'L10500'
end event

event selectionchanged;if index = 1 then
	is_custcode = 'L10500'
elseif index = 2 then
	is_custcode = 'L10502'
end if

end event

type st_7 from statictext within w_seq120i
integer x = 1710
integer y = 212
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
string text = "편수:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_seq120i
integer x = 1879
integer y = 196
integer width = 123
integer height = 76
integer taborder = 110
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
textcase textcase = upper!
integer limit = 1
borderstyle borderstyle = stylelowered!
end type

type st_8 from statictext within w_seq120i
integer x = 1001
integer y = 212
integer width = 302
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
string text = "영업확인:"
boolean focusrectangle = false
end type

type ddlb_stock from dropdownlistbox within w_seq120i
integer x = 1303
integer y = 196
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

type pb_1 from picturebutton within w_seq120i
integer x = 4334
integer y = 160
integer width = 155
integer height = 132
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_2)



end event

type gb_1 from groupbox within w_seq120i
integer x = 23
integer y = 28
integer width = 4489
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

