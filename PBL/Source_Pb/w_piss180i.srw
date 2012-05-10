$PBExportHeader$w_piss180i.srw
$PBExportComments$미납현황
forward
global type w_piss180i from w_ipis_sheet01
end type
type dw_sheet from u_vi_std_datawindow within w_piss180i
end type
type uo_area from u_pisc_select_area within w_piss180i
end type
type uo_division from u_pisc_select_division within w_piss180i
end type
type uo_date from u_pisc_date_applydate within w_piss180i
end type
type uo_productgroup from u_pisc_select_productgroup within w_piss180i
end type
type uo_modelgroup from u_pisc_select_modelgroup within w_piss180i
end type
type dw_print from datawindow within w_piss180i
end type
type cb_1 from commandbutton within w_piss180i
end type
type uo_scustgubun from u_pisc_select_code within w_piss180i
end type
type uo_custcode from u_piss_select_custcode within w_piss180i
end type
type st_8 from statictext within w_piss180i
end type
type st_5 from statictext within w_piss180i
end type
type uo_shipoemgubun from u_pisc_select_code within w_piss180i
end type
type dw_shiporder from datawindow within w_piss180i
end type
type gb_1 from groupbox within w_piss180i
end type
end forward

global type w_piss180i from w_ipis_sheet01
integer width = 4498
string title = "미납현황"
dw_sheet dw_sheet
uo_area uo_area
uo_division uo_division
uo_date uo_date
uo_productgroup uo_productgroup
uo_modelgroup uo_modelgroup
dw_print dw_print
cb_1 cb_1
uo_scustgubun uo_scustgubun
uo_custcode uo_custcode
st_8 st_8
st_5 st_5
uo_shipoemgubun uo_shipoemgubun
dw_shiporder dw_shiporder
gb_1 gb_1
end type
global w_piss180i w_piss180i

type variables
string is_shipdate1,is_shipdate2,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,is_itemcode
string is_custgubun,is_custcode,is_shipoemgubun
boolean ib_open
string is_mod1
end variables

on w_piss180i.create
int iCurrent
call super::create
this.dw_sheet=create dw_sheet
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_date=create uo_date
this.uo_productgroup=create uo_productgroup
this.uo_modelgroup=create uo_modelgroup
this.dw_print=create dw_print
this.cb_1=create cb_1
this.uo_scustgubun=create uo_scustgubun
this.uo_custcode=create uo_custcode
this.st_8=create st_8
this.st_5=create st_5
this.uo_shipoemgubun=create uo_shipoemgubun
this.dw_shiporder=create dw_shiporder
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sheet
this.Control[iCurrent+2]=this.uo_area
this.Control[iCurrent+3]=this.uo_division
this.Control[iCurrent+4]=this.uo_date
this.Control[iCurrent+5]=this.uo_productgroup
this.Control[iCurrent+6]=this.uo_modelgroup
this.Control[iCurrent+7]=this.dw_print
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.uo_scustgubun
this.Control[iCurrent+10]=this.uo_custcode
this.Control[iCurrent+11]=this.st_8
this.Control[iCurrent+12]=this.st_5
this.Control[iCurrent+13]=this.uo_shipoemgubun
this.Control[iCurrent+14]=this.dw_shiporder
this.Control[iCurrent+15]=this.gb_1
end on

on w_piss180i.destroy
call super::destroy
destroy(this.dw_sheet)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_date)
destroy(this.uo_productgroup)
destroy(this.uo_modelgroup)
destroy(this.dw_print)
destroy(this.cb_1)
destroy(this.uo_scustgubun)
destroy(this.uo_custcode)
destroy(this.st_8)
destroy(this.st_5)
destroy(this.uo_shipoemgubun)
destroy(this.dw_shiporder)
destroy(this.gb_1)
end on

event resize;call super::resize;
il_resize_count ++

of_resize_register(dw_sheet, FULL)

of_resize()

end event

event ue_retrieve;call super::ue_retrieve;Integer	li_no[], li_i , li_count, li_loop, li_j
String 	ls_shipcount[], ls_visible[], ls_shipcounttemp, ls_modstring, ls_shipcountstring, ls_time[], ls_timetemp
Long 		ll_rowcount, ll_shipcount

ls_modstring = ''
li_i = 1
li_j = 1
li_count = 1
li_loop	= 1

FOR li_loop= 1 TO 25
	ls_shipcount[li_loop]	= ' '
	ls_time[li_loop] = '_____'
	ls_visible[li_loop]	= '0'
	li_count++
NEXT

ll_rowcount =  dw_sheet.retrieve(is_areacode,is_divisioncode,is_shipdate1,is_custcode,is_productgroup,is_modelgroup,is_shipoemgubun)
ll_shipcount = dw_shiporder.retrieve( is_areacode,is_divisioncode,is_shipdate1, is_custcode)

if ll_rowcount = 0  then 
	MessageBox('조 회' , mid(is_shipdate1, 1, 4) + '년 ' + mid(is_shipdate1, 6, 2) + '월 ' + mid(is_shipdate1, 9, 2) + '일 ' +&
								'~r~n 미납된 제품이 없습니다.')
Else
		
	For li_i = 1 To 25
		IF li_i <= ll_shipcount Then
				li_no[li_i]			= dw_shiporder.getitemnumber(li_i, 'ShipNo')
				ls_shipcountstring = dw_shiporder.getitemstring(li_i, 'sendtime')			
				ls_visible[li_i]		= '1'
				ls_modstring	= 	ls_modstring + &
									"qty"+String(li_i)+"_t.Text = '" + ls_shipcountstring + " ' " + &
									"qty"+String(li_i)+".Visible = '" + ls_visible[li_i] + "' " + & 								
									"qty"+String(li_i)+"_t.Visible = '" + ls_visible[li_i] + "' " 								
				li_j = li_j +1										
			Else
				ls_modstring	= 	ls_modstring + &
										"qty"+String(li_i)+".Visible = '" + ls_visible[li_i] + "' " + &
										"qty"+String(li_i)+"_t.Visible = '" + ls_visible[li_i] + "' " 
			End if
	Next						
	is_mod1 = ls_modstring
	dw_sheet.Modify(ls_modstring)
//	dw_print.Modify(ls_modstring)	
//	is_mod[1] = ls_modstring + wf_print_modify(920, 3600, 930, li_j)	
	dw_sheet.Post Event RowFocusChanged(1)			


end if

end event

event ue_postopen;call super::ue_postopen;dw_sheet.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname,ls_itemname
string ls_codegroup,ls_codegroupname,ls_codename,ls_custname
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,uo_area.is_uo_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_pisc_retrieve_dddw_productgroup(uo_productgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,'%',true,is_productgroup,ls_productgroupname)
f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,uo_area.is_uo_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
f_pisc_retrieve_dddw_code(uo_shipoemgubun.dw_1,'%','%','SOEMGUBUN','%',true,ls_codegroup,is_shipoemgubun,ls_codegroupname,ls_codename)
f_pisc_retrieve_dddw_code(uo_scustgubun.dw_1,'%','%','SCUSTGUBUN','%',false,ls_codegroup,is_custgubun,ls_codegroupname,ls_codename)
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)
dw_sheet.reset()

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
//lstr_prt.dwsyntax		= ls_mod
lstr_prt.dwsyntax		= is_mod1
OpenSheetWithParm(w_prt, lstr_prt, w_frame, 0, Layered!)

end event

event activate;call super::activate;dw_sheet.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)
dw_print.settransobject(sqlpis)

end event

type uo_status from w_ipis_sheet01`uo_status within w_piss180i
end type

type dw_sheet from u_vi_std_datawindow within w_piss180i
integer x = 18
integer y = 324
integer width = 3575
integer height = 1572
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_piss180i_01"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type uo_area from u_pisc_select_area within w_piss180i
integer x = 946
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;dw_sheet.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)
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

type uo_division from u_pisc_select_division within w_piss180i
integer x = 1979
integer y = 96
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;dw_sheet.settransobject(sqlpis)
dw_shiporder.settransobject(sqlpis)
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

type uo_date from u_pisc_date_applydate within w_piss180i
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

type uo_productgroup from u_pisc_select_productgroup within w_piss180i
integer x = 2295
integer y = 196
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

type uo_modelgroup from u_pisc_select_modelgroup within w_piss180i
integer x = 3237
integer y = 196
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

type dw_print from datawindow within w_piss180i
boolean visible = false
integer x = 2103
integer y = 784
integer width = 411
integer height = 432
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss180i_02"
boolean minbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_piss180i
integer x = 4215
integer y = 40
integer width = 206
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "출력"
end type

event clicked;parent.triggerevent('ue_print')
end event

type uo_scustgubun from u_pisc_select_code within w_piss180i
event destroy ( )
integer x = 398
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
dw_sheet.reset()

end event

event ue_post_constructor;string ls_custname
is_custgubun = is_uo_codeid
f_piss_retrieve_dddw_custcode(uo_custcode.dw_1,is_custgubun,'%',false,is_custcode,ls_custname)


end event

type uo_custcode from u_piss_select_custcode within w_piss180i
event destroy ( )
integer x = 1166
integer y = 196
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

type st_8 from statictext within w_piss180i
integer x = 64
integer y = 212
integer width = 325
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

type st_5 from statictext within w_piss180i
integer x = 3200
integer y = 108
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

type uo_shipoemgubun from u_pisc_select_code within w_piss180i
event destroy ( )
integer x = 3465
integer y = 96
integer width = 709
integer taborder = 100
boolean bringtotop = true
end type

on uo_shipoemgubun.destroy
call u_pisc_select_code::destroy
end on

event ue_select;is_shipoemgubun = is_uo_codeid
dw_sheet.reset()


end event

type dw_shiporder from datawindow within w_piss180i
boolean visible = false
integer x = 791
integer y = 796
integer width = 411
integer height = 432
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss180i_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_piss180i
integer x = 23
integer y = 28
integer width = 4174
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

