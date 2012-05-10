$PBExportHeader$w_seq116i.srw
$PBExportComments$품목별재공현황
forward
global type w_seq116i from w_origin_sheet09
end type
type uo_1 from u_pisc_select_area within w_seq116i
end type
type uo_2 from u_pisc_select_division within w_seq116i
end type
type uo_3 from u_pisc_select_productgroup within w_seq116i
end type
type uo_6 from u_pisc_select_item_model_kdac within w_seq116i
end type
type uo_4 from u_pisc_date_scroll_month within w_seq116i
end type
type dw_2 from datawindow within w_seq116i
end type
type pb_excel from picturebutton within w_seq116i
end type
end forward

global type w_seq116i from w_origin_sheet09
integer height = 2724
string title = "품목별재공현황"
uo_1 uo_1
uo_2 uo_2
uo_3 uo_3
uo_6 uo_6
uo_4 uo_4
dw_2 dw_2
pb_excel pb_excel
end type
global w_seq116i w_seq116i

on w_seq116i.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.uo_2=create uo_2
this.uo_3=create uo_3
this.uo_6=create uo_6
this.uo_4=create uo_4
this.dw_2=create dw_2
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.uo_3
this.Control[iCurrent+4]=this.uo_6
this.Control[iCurrent+5]=this.uo_4
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.pb_excel
end on

on w_seq116i.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.uo_2)
destroy(this.uo_3)
destroy(this.uo_6)
destroy(this.uo_4)
destroy(this.dw_2)
destroy(this.pb_excel)
end on

event activate;call super::activate;dw_2.settransobject(sqlpis)
end event

type uo_status from w_origin_sheet09`uo_status within w_seq116i
end type

type uo_1 from u_pisc_select_area within w_seq116i
event destroy ( )
integer x = 667
integer y = 40
integer taborder = 90
boolean bringtotop = true
end type

on uo_1.destroy
call u_pisc_select_area::destroy
end on

event ue_select;//idw_normal.SetTransObject(SQLPIS)
//idw_minap.SetTransObject(SQLPIS)
//idw_sennap.SetTransObject(SQLPIS)
//idw_move.SetTransObject(SQLPIS)
//dw_truckorder.SetTransObject(SQLPIS)
//idw_normal.reset()
//idw_minap.reset()
//idw_sennap.reset()
//idw_move.reset()
//dw_truckorder.reset()
//
//string ls_divisionname,ls_divisionnameeng
//datawindow ldw_division
//ldw_division = uo_division.dw_1
//is_areacode  = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//
//
end event

event ue_post_constructor;call super::ue_post_constructor;//string ls_divisionname,ls_divisionnameeng
//datawindow ldw_division
//ldw_division = uo_division.dw_1
//is_areacode = is_uo_areacode
//f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
//


end event

type uo_2 from u_pisc_select_division within w_seq116i
event destroy ( )
integer x = 1207
integer y = 40
integer taborder = 100
boolean bringtotop = true
end type

on uo_2.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;//idw_normal.SetTransObject(SQLPIS)
//idw_minap.SetTransObject(SQLPIS)
//idw_sennap.SetTransObject(SQLPIS)
//idw_move.SetTransObject(SQLPIS)
//dw_truckorder.SetTransObject(SQLPIS)
//idw_normal.reset()
//idw_minap.reset()
//idw_sennap.reset()
//idw_move.reset()
//dw_truckorder.reset()
//is_divisioncode = is_uo_divisioncode
end event

event ue_post_constructor;call super::ue_post_constructor;//is_divisioncode = is_uo_divisioncode

end event

type uo_3 from u_pisc_select_productgroup within w_seq116i
event destroy ( )
integer x = 1829
integer y = 40
integer taborder = 110
boolean bringtotop = true
end type

on uo_3.destroy
call u_pisc_select_productgroup::destroy
end on

event ue_select;call super::ue_select;//string ls_productgroupname,ls_modelgroupname,ls_itemname
//is_productgroup = is_uo_productgroup
//if ib_open = true then
//	f_pisc_retrieve_dddw_modelgroup(uo_modelgroup.dw_1,is_areacode,is_divisioncode,is_productgroup,'%',true,is_modelgroup,ls_modelgroupname)
////	f_pisc_retrieve_dddw_item_model(uo_itemcode.dw_1,is_areacode,is_divisioncode,is_productgroup,is_modelgroup,'%',true,is_itemcode,ls_itemname)
//end if
//
end event

type uo_6 from u_pisc_select_item_model_kdac within w_seq116i
event destroy ( )
integer x = 2747
integer y = 20
integer taborder = 80
boolean bringtotop = true
end type

on uo_6.destroy
call u_pisc_select_item_model_kdac::destroy
end on

event ue_select;call super::ue_select;//is_itemcode = is_uo_itemcode
end event

type uo_4 from u_pisc_date_scroll_month within w_seq116i
integer x = 32
integer y = 40
integer height = 88
integer taborder = 21
boolean bringtotop = true
end type

event ue_select;call super::ue_select;//If ib_open Then
//	iw_this.TriggerEvent("ue_reset")
//End If
//
end event

on uo_4.destroy
call u_pisc_date_scroll_month::destroy
end on

type dw_2 from datawindow within w_seq116i
integer x = 37
integer y = 136
integer width = 4567
integer height = 2328
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_tseqiwip_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_excel from picturebutton within w_seq116i
integer x = 4439
integer y = 4
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
