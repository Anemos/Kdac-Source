$PBExportHeader$w_piss300i.srw
$PBExportComments$년월별출하현황
forward
global type w_piss300i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss300i
end type
type uo_area from u_pisc_select_area within w_piss300i
end type
type uo_division from u_pisc_select_division within w_piss300i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss300i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_piss300i
end type
type uo_scustgubun from u_pisc_select_code within w_piss300i
end type
type uo_custcode from u_piss_select_custcode within w_piss300i
end type
type st_8 from statictext within w_piss300i
end type
type gb_1 from groupbox within w_piss300i
end type
type uo_1 from u_pisc_date_scroll_year within w_piss300i
end type
type dw_print from datawindow within w_piss300i
end type
type uo_itemcode from u_pisc_select_item_model_kdac within w_piss300i
end type
type pb_print from picturebutton within w_piss300i
end type
type pb_excel from picturebutton within w_piss300i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss300i
end type
type st_2 from statictext within w_piss300i
end type
end forward

global type w_piss300i from w_ipis_sheet01
integer width = 4498
integer height = 2304
string title = "년월별출하현황"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
st_8 st_8
gb_1 gb_1
uo_1 uo_1
dw_print dw_print
uo_itemcode uo_itemcode
pb_print pb_print
pb_excel pb_excel
uo_shipoemgubun uo_shipoemgubun
st_2 st_2
end type
global w_piss300i w_piss300i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
string is_custgubun,is_custcode,is_shipoemgubun
boolean ib_open
end variables

on w_piss300i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.gb_1=create gb_1
this.uo_1=create uo_1
this.dw_print=create dw_print
this.uo_itemcode=create uo_itemcode
this.pb_print=create pb_print
this.pb_excel=create pb_excel
this.uo_shipoemgubun=create uo_shipoemgubun
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.uo_modelgroup
this.Control[iCurrent+6]=this.uo_scustgubun
this.Control[iCurrent+7]=this.uo_custcode
this.Control[iCurrent+8]=this.st_8
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.dw_print
this.Control[iCurrent+12]=this.uo_itemcode
this.Control[iCurrent+13]=this.pb_print
this.Control[iCurrent+14]=this.pb_excel
this.Control[iCurrent+15]=this.uo_shipoemgubun
this.Control[iCurrent+16]=this.st_2
end on

on w_piss300i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.gb_1)
destroy(this.uo_1)
destroy(this.dw_print)
destroy(this.uo_itemcode)
destroy(this.pb_print)
destroy(this.pb_excel)
destroy(this.uo_shipoemgubun)
destroy(this.st_2)
end on

event resize;call super::resize;
il_resize_count ++

//of_resize_register(dw_graph, ABOVE)
//of_resize_register(st_h_bar, SPLIT)
of_resize_register(dw_sheet, full)

of_resize()

end event

event ue_retrieve;long ll_rowcount
ll_rowcount =  dw_sheet.retrieve(is_shipdate1,is_areacode,is_divisioncode,is_custgubun,is_custcode,is_productgroup,is_modelgroup,is_itemcode,is_shipoemgubun)
if ll_rowcount = 0  then 
	pb_print.visible = false
	pb_print.enabled = false
	pb_excel.visible = false
	pb_excel.enabled = false
	MessageBox('확인' ,'조회할 자료가 없읍니다.')
	return
end if	

pb_print.visible = true
pb_print.enabled = true
pb_excel.visible = true
pb_excel.enabled = true
end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_sheet.sharedata(dw_print)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname
string ls_codegroup,ls_codegroupname,ls_codename,ls_custname
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',true,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',true,is_custcode,ls_custname)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',TRUE,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)

// f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,uo_area.is_uo_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
ib_open = true  
end event

event ue_print;call super::ue_print;String	ls_mod
str_easy	lstr_prt
dw_sheet.sharedata(dw_print)
//
ls_mod	= "t_msg.Text = '" + "기준일 : " + is_shipdate1 + "' "
//ls_mod	= ls_mod + is_mod1
lstr_prt.transaction = sqlpis
lstr_prt.datawindow	= dw_print
lstr_prt.title			= '년간출하요청현황'
lstr_prt.tag			= '년간출하요청현황'
lstr_prt.dwsyntax		= ls_mod
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)
//
end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_sheet.sharedata(dw_print)
end event

type uo_status from w_ipis_sheet01`uo_status within w_piss300i
integer y = 2052
end type

type dw_sheet from u_vi_std_datawindow within w_piss300i
integer x = 69
integer y = 328
integer width = 3575
integer height = 428
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss300i_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

type uo_area from u_pisc_select_area within w_piss300i
integer x = 585
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_sheet.sharedata(dw_print)
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

type uo_division from u_pisc_select_division within w_piss300i
integer x = 1111
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_print.settransobject(sqlpis)
dw_sheet.sharedata(dw_print)
string ls_productgroupname,ls_modelgroupname,ls_itemname
is_divisioncode = is_uo_divisioncode
if ib_open = true then
	f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if
dw_sheet.reset()

end event

type uo_productgroup from u_pisc_select_productgroup within w_piss300i
integer x = 1678
integer y = 96
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

type uo_modelgroup from u_pisc_select_modelgroup within w_piss300i
integer x = 2574
integer y = 96
integer taborder = 50
boolean bringtotop = true
end type

on uo_modelgroup.destroy
call u_pisc_select_modelgroup::destroy
end on

event ue_select;call super::ue_select;string ls_itemname
is_modelgroup = is_uo_modelgroup
if ib_open = true then
//	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
end if

end event

type uo_scustgubun from u_pisc_select_code within w_piss300i
event destroy ( )
integer x = 430
integer y = 200
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
dw_sheet.reset()

end event

event ue_post_constructor;string ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

type uo_custcode from u_piss_select_custcode within w_piss300i
event destroy ( )
integer x = 1147
integer y = 200
integer taborder = 90
boolean bringtotop = true
end type

on uo_custcode.destroy
call u_piss_select_custcode::destroy
end on

event ue_select;call super::ue_select;is_custcode = is_uo_custcode
dw_sheet.reset()

end event

event ue_post_constructor;call super::ue_post_constructor;is_custcode = is_uo_custcode
end event

type st_8 from statictext within w_piss300i
integer x = 50
integer y = 204
integer width = 375
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
string text = "거래처구분"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_piss300i
integer x = 23
integer y = 28
integer width = 4599
integer height = 280
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

type uo_1 from u_pisc_date_scroll_year within w_piss300i
integer x = 59
integer y = 96
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_shipdate1 = is_uo_year
end event

on uo_1.destroy
call u_pisc_date_scroll_year::destroy
end on

type dw_print from datawindow within w_piss300i
boolean visible = false
integer x = 393
integer y = 696
integer width = 1920
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss300i_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_itemcode from u_pisc_select_item_model_kdac within w_piss300i
event destroy ( )
integer x = 2217
integer y = 180
integer taborder = 60
boolean bringtotop = true
end type

on uo_itemcode.destroy
call u_pisc_select_item_model_kdac::destroy
end on

event ue_select;call super::ue_select;is_itemcode = is_uo_itemcode
end event

type pb_print from picturebutton within w_piss300i
boolean visible = false
integer x = 4137
integer y = 168
integer width = 155
integer height = 132
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string picturename = "Print!"
alignment htextalign = left!
end type

event clicked;parent.triggerevent('ue_print')
end event

type pb_excel from picturebutton within w_piss300i
boolean visible = false
integer x = 4302
integer y = 168
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
boolean enabled = false
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_sheet)
end event

type uo_shipoemgubun from u_pisc_select_code within w_piss300i
event destroy ( )
integer x = 3790
integer y = 96
integer width = 709
integer taborder = 80
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;is_shipoemgubun = is_uo_codeid
if is_shipoemgubun = '' or isnull(is_shipoemgubun) then
	is_shipoemgubun = '%'
end if	
dw_sheet.reset()




end event

event ue_post_constructor;call super::ue_post_constructor;is_shipoemgubun = is_uo_codeid

end event

type st_2 from statictext within w_piss300i
integer x = 3483
integer y = 104
integer width = 302
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "출하구분:"
boolean focusrectangle = false
end type

