$PBExportHeader$w_pist020i.srw
$PBExportComments$lot관리대장
forward
global type w_pist020i from w_ipis_sheet01
end type
type uo_date1 from u_pisc_date_applydate_1 within w_pist020i
end type
type uo_date111 from u_pisc_date_applydate within w_pist020i
end type
type uo_area1 from u_pisc_select_area within w_pist020i
end type
type uo_division1 from u_pisc_select_division within w_pist020i
end type
type uo_workcenter from u_pisc_select_workcenter within w_pist020i
end type
type uo_linecode from u_pisc_select_line within w_pist020i
end type
type st_2 from statictext within w_pist020i
end type
type dw_2 from datawindow within w_pist020i
end type
type uo_itemcode from u_pisc_select_item_kb_line within w_pist020i
end type
type gb_1 from groupbox within w_pist020i
end type
type dw_sheet from u_vi_std_datawindow within w_pist020i
end type
type uo_1 from u_pisc_date_applydate within w_pist020i
end type
type uo_area from u_pisc_select_area within w_pist020i
end type
type uo_division from u_pisc_select_division within w_pist020i
end type
type pb_excel from picturebutton within w_pist020i
end type
end forward

global type w_pist020i from w_ipis_sheet01
integer width = 4663
string title = "lot관리대장"
uo_date1 uo_date1
uo_date111 uo_date111
uo_area1 uo_area1
uo_division1 uo_division1
uo_workcenter uo_workcenter
uo_linecode uo_linecode
st_2 st_2
dw_2 dw_2
uo_itemcode uo_itemcode
gb_1 gb_1
dw_sheet dw_sheet
uo_1 uo_1
uo_area uo_area
uo_division uo_division
pb_excel pb_excel
end type
global w_pist020i w_pist020i

type variables
string is_applydate1,is_applydate2,is_areacode,is_divisioncode,is_workcenter,is_linecode,is_itemcode
end variables

forward prototypes
public subroutine wf_import ()
end prototypes

public subroutine wf_import ();Long	i, ll_rowcount,ll_gubun,ll_compare_gubun,ln_invqty
string ls_divisioncode,ls_lotno,ls_stockdate,ls_itemcode,ls_kbno
string ls_compare_divisioncode,ls_compare_lotno,ls_compare_stockdate,ls_stockqty,ls_shipqty,ls_shipdate
String ls_import,ls_invqty
ls_import = ''
ls_divisioncode = ''
ls_stockdate = ''
ls_lotno = ''
ls_kbno  = ''
ls_shipdate = ''
dw_sheet.reset()
ll_rowcount = dw_2.rowcount()

for i = 1 to ll_rowcount step 1
	ll_gubun        = dw_2.object.gubun[i]
	ls_divisioncode = dw_2.object.divisioncode[i]
	ls_itemcode     = dw_2.object.itemcode[i]
	ls_lotno        = dw_2.object.lotno[i]
	ls_kbno         = dw_2.object.kbno[i]
	ls_stockqty  = string(dw_2.object.stockqty[i])
	ls_invqty    = string(dw_2.object.invqty[i]) 
	ls_stockdate = dw_2.object.stockdate[i]
//	if ls_stockdate <> ls_compare_stockdate ll_gubun <> ll_compare_gubun  &
	if ls_divisioncode <> ls_compare_divisioncode or ls_lotno <> ls_compare_lotno then
		if i <> 1 then
			ls_import = ls_import + '~r~n'
			dw_sheet.ImportString(ls_import)
			ls_import = ''
		end if
		if ll_gubun = 1 then
			ls_import = ls_divisioncode +'~t' + ls_itemcode + '~t' + ls_invqty + '~t'
			ls_import = ls_import + ls_stockdate +'~t'
			ls_import = ls_import + ls_kbno +'~t' 
			ls_import = ls_import + ls_lotno +'~t'
			ls_import = ls_import + ls_stockqty + '~t'
		else
			if ls_import = '' then
				ls_import = ls_divisioncode +'~t' + ls_itemcode + '~t' + ls_invqty + '~t'
				ls_import = ls_import + ' ' + +'~t'
				ls_import = ls_import + ls_kbno +'~t'
				ls_import = ls_import + ls_lotno +'~t'
				ls_import = ls_import + '0' + '~t'
			end if
			ls_import = ls_import + ls_stockdate + '~t' + ls_stockqty +'~t'
		end if	
	else
		ls_import = ls_import + ls_stockdate + '~t' + ls_stockqty +'~t'
	end if
	ll_compare_gubun        = ll_gubun
	ls_compare_divisioncode = ls_divisioncode
	ls_compare_lotno        = ls_lotno
next
ls_import = ls_import + '~r~n'
dw_sheet.ImportString(ls_import)

end subroutine

on w_pist020i.create
int iCurrent
call super::create
this.uo_date1=create uo_date1
this.uo_date111=create uo_date111
this.uo_area1=create uo_area1
this.uo_division1=create uo_division1
this.uo_workcenter=create uo_workcenter
this.uo_linecode=create uo_linecode
this.st_2=create st_2
this.dw_2=create dw_2
this.uo_itemcode=create uo_itemcode
this.gb_1=create gb_1
this.dw_sheet=create dw_sheet
this.uo_1=create uo_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_date1
this.Control[iCurrent+2]=this.uo_date111
this.Control[iCurrent+3]=this.uo_area1
this.Control[iCurrent+4]=this.uo_division1
this.Control[iCurrent+5]=this.uo_workcenter
this.Control[iCurrent+6]=this.uo_linecode
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.uo_itemcode
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.dw_sheet
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.uo_area
this.Control[iCurrent+14]=this.uo_division
this.Control[iCurrent+15]=this.pb_excel
end on

on w_pist020i.destroy
call super::destroy
destroy(this.uo_date1)
destroy(this.uo_date111)
destroy(this.uo_area1)
destroy(this.uo_division1)
destroy(this.uo_workcenter)
destroy(this.uo_linecode)
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.uo_itemcode)
destroy(this.gb_1)
destroy(this.dw_sheet)
destroy(this.uo_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.pb_excel)
end on

event ue_retrieve;call super::ue_retrieve;setpointer(hourglass!)
dw_2.reset()
dw_sheet.reset()

is_areacode = uo_area.is_uo_areacode
is_divisioncode = uo_division.is_uo_divisioncode
is_workcenter = uo_workcenter.is_uo_workcenter
is_linecode = uo_linecode.is_uo_linecode
is_itemcode = uo_itemcode.is_uo_itemcode

dw_2.retrieve(is_areacode,is_divisioncode,is_itemcode,is_applydate1,is_applydate2)
if dw_2.rowcount() = 0 then
	pb_excel.visible = false
	pb_excel.enabled = false
	setpointer(arrow!)
	messagebox("확인","조회할 자료가 없습니다.")
	return
end if	
pb_excel.visible = true
pb_excel.enabled = true
wf_import()
setpointer(arrow!)
end event

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_postopen;call super::ue_postopen;string ls_itemname
dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
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
										  false, &
										  uo_workcenter.is_uo_workcenter, &
										  uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
								  uo_area.is_uo_areacode, &
								  uo_division.is_uo_divisioncode, &
								  uo_workcenter.is_uo_workcenter, &
								  '%', &
								  false, &
								  uo_linecode.is_uo_linecode, &
								  uo_linecode.is_uo_lineshortname, &
								  uo_linecode.is_uo_linefullname)
f_pisc_retrieve_dddw_item_kb_line(uo_itemcode.dw_1,&
                                  uo_area.is_uo_areacode, &
											 uo_division.is_uo_divisioncode, &
											 uo_workcenter.is_uo_workcenter, &
											 uo_linecode.is_uo_linecode,'%',false,is_itemcode,ls_itemname)
end event

type uo_status from w_ipis_sheet01`uo_status within w_pist020i
end type

type uo_date1 from u_pisc_date_applydate_1 within w_pist020i
integer x = 814
integer y = 100
integer taborder = 130
boolean bringtotop = true
end type

on uo_date1.destroy
call u_pisc_date_applydate_1::destroy
end on

event ue_select;call super::ue_select;IS_APPLYDATE2 = IS_UO_DATE
end event

type uo_date111 from u_pisc_date_applydate within w_pist020i
event destroy ( )
boolean visible = false
integer x = 256
integer y = 460
integer taborder = 110
boolean bringtotop = true
long backcolor = 80269524
end type

on uo_date111.destroy
call u_pisc_date_applydate::destroy
end on

event constructor;call super::constructor;//is_applydate1 = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;//is_applydate1 = is_uo_date
end event

event ue_select;call super::ue_select;//is_applydate1 = is_uo_date
end event

type uo_area1 from u_pisc_select_area within w_pist020i
event destroy ( )
boolean visible = false
integer x = 1271
integer y = 568
integer taborder = 120
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_area1.destroy
call u_pisc_select_area::destroy
end on

event ue_select;//string ls_itemname
//dw_sheet.settransobject(sqlpis)
//dw_2.settransobject(sqlpis)
//
//string ls_divisionname,ls_divisionnameeng
//datawindow ldw_division
//ldw_division = uo_division.dw_1
//is_areacode = is_uo_areacode
//f_pisc_retrieve_dddw_division(uo_division.dw_1, &
//										g_s_empno, &
//										uo_area.is_uo_areacode, &
//										'%', &
//										False, &
//										uo_division.is_uo_divisioncode, &
//										uo_division.is_uo_divisionname, &
//										uo_division.is_uo_divisionnameeng)
//
//f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
//										  uo_area.is_uo_areacode, &
//										  uo_division.is_uo_divisioncode, &
//										  '%', &
//										  false, &
//										  uo_workcenter.is_uo_workcenter, &
//										  uo_workcenter.is_uo_workcentername)
//
//f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
//								  uo_area.is_uo_areacode, &
//								  uo_division.is_uo_divisioncode, &
//								  uo_workcenter.is_uo_workcenter, &
//								  '%', &
//								  false, &
//								  uo_linecode.is_uo_linecode, &
//								  uo_linecode.is_uo_lineshortname, &
//								  uo_linecode.is_uo_linefullname)
//f_pisc_retrieve_dddw_item_kb_line(uo_itemcode.dw_1,&
//                                  uo_area.is_uo_areacode, &
//											 uo_division.is_uo_divisioncode, &
//											 uo_workcenter.is_uo_workcenter, &
//											 uo_linecode.is_uo_linecode,'%',false,is_itemcode,ls_itemname)
end event

event ue_post_constructor;call super::ue_post_constructor;//string ls_divisionname,ls_divisionnameeng
//datawindow ldw_division
//ldw_division = uo_division.dw_1
//is_areacode = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//
//
end event

type uo_division1 from u_pisc_select_division within w_pist020i
event destroy ( )
boolean visible = false
integer x = 1806
integer y = 580
integer taborder = 130
boolean bringtotop = true
long backcolor = 67108864
end type

on uo_division1.destroy
call u_pisc_select_division::destroy
end on

event constructor;call super::constructor;//postevent('ue_post_constructor')
end event

event ue_select;call super::ue_select;//dw_sheet.settransobject(sqlpis)
//dw_2.settransobject(sqlpis)
//string ls_workcentername,ls_itemname
//datawindow ldw_workcenter
//ldw_workcenter = uo_workcenter.dw_1
//
//is_divisioncode = is_uo_divisioncode
//f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
//										  uo_area.is_uo_areacode, &
//										  uo_division.is_uo_divisioncode, &
//										  '%', &
//										  false, &
//										  uo_workcenter.is_uo_workcenter, &
//										  uo_workcenter.is_uo_workcentername)
//
//f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
//								  uo_area.is_uo_areacode, &
//								  uo_division.is_uo_divisioncode, &
//								  uo_workcenter.is_uo_workcenter, &
//								  '%', &
//								  false, &
//								  uo_linecode.is_uo_linecode, &
//								  uo_linecode.is_uo_lineshortname, &
//								  uo_linecode.is_uo_linefullname)
//f_pisc_retrieve_dddw_item_kb_line(uo_itemcode.dw_1,&
//                                  uo_area.is_uo_areacode, &
//											 uo_division.is_uo_divisioncode, &
//											 uo_workcenter.is_uo_workcenter, &
//											 uo_linecode.is_uo_linecode,'%',false,is_itemcode,ls_itemname)
end event

event ue_post_constructor;call super::ue_post_constructor;//string ls_workcentername
//datawindow ldw_workcenter
//ldw_workcenter = uo_workcenter.dw_1
//
//f_pisc_retrieve_dddw_workcenter(ldw_workcenter,is_areacode,is_divisioncode,'%',true,is_workcenter,ls_workcentername)
end event

type uo_workcenter from u_pisc_select_workcenter within w_pist020i
integer x = 2290
integer y = 100
integer taborder = 140
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_workcenter = is_uo_workcenter
string ls_linefullname,ls_lineshortname,ls_itemname
datawindow ldw_linecode
ldw_linecode = uo_linecode.dw_1

f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
								  uo_area.is_uo_areacode, &
								  uo_division.is_uo_divisioncode, &
								  uo_workcenter.is_uo_workcenter, &
								  '%', &
								  false, &
								  uo_linecode.is_uo_linecode, &
								  uo_linecode.is_uo_lineshortname, &
								  uo_linecode.is_uo_linefullname)
f_pisc_retrieve_dddw_item_kb_line(uo_itemcode.dw_1,&
                                  uo_area.is_uo_areacode, &
											 uo_division.is_uo_divisioncode, &
											 uo_workcenter.is_uo_workcenter, &
											 uo_linecode.is_uo_linecode,'%',false,is_itemcode,ls_itemname)
end event

on uo_workcenter.destroy
call u_pisc_select_workcenter::destroy
end on

type uo_linecode from u_pisc_select_line within w_pist020i
integer x = 2953
integer y = 100
integer taborder = 150
boolean bringtotop = true
end type

event ue_select;string ls_itemname
is_linecode = is_uo_linecode
f_pisc_retrieve_dddw_item_kb_line(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_workcenter,is_linecode,'%',false,is_itemcode,ls_itemname)

end event

on uo_linecode.destroy
call u_pisc_select_line::destroy
end on

type st_2 from statictext within w_pist020i
integer x = 731
integer y = 108
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

type dw_2 from datawindow within w_pist020i
boolean visible = false
integer x = 1125
integer y = 1148
integer width = 2089
integer height = 616
integer taborder = 21
boolean bringtotop = true
string title = "none"
string dataobject = "d_pist020i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//this.settransobject(sqlpis)
end event

type uo_itemcode from u_pisc_select_item_kb_line within w_pist020i
integer x = 3497
integer y = 100
integer taborder = 160
boolean bringtotop = true
end type

on uo_itemcode.destroy
call u_pisc_select_item_kb_line::destroy
end on

event ue_select;call super::ue_select;is_itemcode = is_uo_itemcode
end event

type gb_1 from groupbox within w_pist020i
integer x = 23
integer y = 28
integer width = 4594
integer height = 184
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
end type

type dw_sheet from u_vi_std_datawindow within w_pist020i
integer x = 27
integer y = 232
integer width = 4370
integer height = 1648
integer taborder = 11
string dataobject = "d_pist020i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;//this.settransobject(sqlpis)

end event

type uo_1 from u_pisc_date_applydate within w_pist020i
integer x = 46
integer y = 100
integer taborder = 140
boolean bringtotop = true
end type

event constructor;call super::constructor;is_applydate1 = is_uo_date
end event

event ue_select;call super::ue_select;is_applydate1 = is_uo_date
end event

on uo_1.destroy
call u_pisc_date_applydate::destroy
end on

type uo_area from u_pisc_select_area within w_pist020i
event destroy ( )
integer x = 1266
integer y = 100
integer taborder = 140
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
string ls_divisionname,ls_divisionnameeng,ls_itemname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_workcenter(uo_workcenter.dw_1, &
										  uo_area.is_uo_areacode, &
										  uo_division.is_uo_divisioncode, &
										  '%', &
										  FALSE, &
										  uo_workcenter.is_uo_workcenter, &
										  uo_workcenter.is_uo_workcentername)

f_pisc_retrieve_dddw_line(uo_linecode.dw_1, &
								  uo_area.is_uo_areacode, &
								  uo_division.is_uo_divisioncode, &
								  uo_workcenter.is_uo_workcenter, &
								  '%', &
								  FALSE, &
								  uo_linecode.is_uo_linecode, &
								  uo_linecode.is_uo_lineshortname, &
								  uo_linecode.is_uo_linefullname)

f_pisc_retrieve_dddw_item_kb_line(uo_itemcode.dw_1,&
                                  uo_area.is_uo_areacode, &
											 uo_division.is_uo_divisioncode, &
											 uo_workcenter.is_uo_workcenter, &
											 uo_linecode.is_uo_linecode,'%',false,is_itemcode,ls_itemname)
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

type uo_division from u_pisc_select_division within w_pist020i
integer x = 1751
integer y = 100
integer taborder = 150
boolean bringtotop = true
end type

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_2.settransobject(sqlpis)
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

end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type pb_excel from picturebutton within w_pist020i
boolean visible = false
integer x = 4425
integer y = 72
integer width = 155
integer height = 132
integer taborder = 70
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

event clicked;f_save_to_excel(dw_sheet)
end event

