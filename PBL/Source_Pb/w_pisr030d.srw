$PBExportHeader$w_pisr030d.srw
forward
global type w_pisr030d from w_ipis_sheet01
end type
type uo_area from u_pisc_select_area within w_pisr030d
end type
type uo_division from u_pisc_select_division within w_pisr030d
end type
type uo_product from u_pisc_select_productgroup within w_pisr030d
end type
type uo_month from u_pisc_date_scroll_month within w_pisr030d
end type
type dw_pisr030b_01 from datawindow within w_pisr030d
end type
type gb_1 from groupbox within w_pisr030d
end type
type gb_2 from groupbox within w_pisr030d
end type
end forward

global type w_pisr030d from w_ipis_sheet01
uo_area uo_area
uo_division uo_division
uo_product uo_product
uo_month uo_month
dw_pisr030b_01 dw_pisr030b_01
gb_1 gb_1
gb_2 gb_2
end type
global w_pisr030d w_pisr030d

on w_pisr030d.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_product=create uo_product
this.uo_month=create uo_month
this.dw_pisr030b_01=create dw_pisr030b_01
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_product
this.Control[iCurrent+4]=this.uo_month
this.Control[iCurrent+5]=this.dw_pisr030b_01
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_pisr030d.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_product)
destroy(this.uo_month)
destroy(this.dw_pisr030b_01)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type uo_status from w_ipis_sheet01`uo_status within w_pisr030d
end type

type uo_area from u_pisc_select_area within w_pisr030d
integer x = 814
integer y = 52
integer taborder = 30
boolean bringtotop = true
end type

event ue_select;call super::ue_select;
	f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)

end event

on uo_area.destroy
call u_pisc_select_area::destroy
end on

type uo_division from u_pisc_select_division within w_pisr030d
integer x = 1362
integer y = 52
integer taborder = 40
boolean bringtotop = true
end type

event ue_select;call super::ue_select;f_pisc_retrieve_dddw_productgroup(uo_product.dw_1,uo_area.is_uo_areacode, &
		uo_division.is_uo_divisioncode,'%',true,uo_product.is_uo_productgroup, &
		uo_product.is_uo_productgroupname)
end event

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type uo_product from u_pisc_select_productgroup within w_pisr030d
integer x = 1979
integer y = 52
integer taborder = 50
boolean bringtotop = true
end type

on uo_product.destroy
call u_pisc_select_productgroup::destroy
end on

type uo_month from u_pisc_date_scroll_month within w_pisr030d
integer x = 73
integer y = 52
integer height = 80
integer taborder = 40
boolean bringtotop = true
end type

on uo_month.destroy
call u_pisc_date_scroll_month::destroy
end on

type dw_pisr030b_01 from datawindow within w_pisr030d
integer x = 27
integer y = 176
integer width = 3017
integer height = 1564
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_pisr030b_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisr030d
integer x = 754
integer width = 2176
integer height = 156
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisr030d
integer x = 27
integer width = 690
integer height = 156
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "±¼¸²Ã¼"
long textcolor = 33554432
long backcolor = 12632256
end type

