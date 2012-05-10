$PBExportHeader$w_seq115i.srw
$PBExportComments$품목별재고현황
forward
global type w_seq115i from w_origin_sheet09
end type
type uo_area from u_pisc_select_area within w_seq115i
end type
type uo_division from u_pisc_select_division within w_seq115i
end type
type dw_2 from datawindow within w_seq115i
end type
type uo_productgroup from u_seq_select_productgroup within w_seq115i
end type
type pb_excel from picturebutton within w_seq115i
end type
type uo_1 from u_pisc_select_custitem_kdac within w_seq115i
end type
type gb_1 from groupbox within w_seq115i
end type
end forward

global type w_seq115i from w_origin_sheet09
integer height = 2716
string title = "품목별재고현황"
uo_area uo_area
uo_division uo_division
dw_2 dw_2
uo_productgroup uo_productgroup
pb_excel pb_excel
uo_1 uo_1
gb_1 gb_1
end type
global w_seq115i w_seq115i

type variables
string is_areacode,is_divisioncode,is_productgroup
string is_itemcode
end variables

on w_seq115i.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_2=create dw_2
this.uo_productgroup=create uo_productgroup
this.pb_excel=create pb_excel
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.uo_productgroup
this.Control[iCurrent+5]=this.pb_excel
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.gb_1
end on

on w_seq115i.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_2)
destroy(this.uo_productgroup)
destroy(this.pb_excel)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event ue_retrieve;call super::ue_retrieve;long ln_row 
string ls_currentdate

ls_currentdate = mid(g_s_date,1,4) + '.' + mid(g_s_date,5,2) + '%'
ln_row = dw_2.retrieve(ls_currentdate,is_Areacode,is_divisioncode,is_productgroup,is_itemcode)
//messagebox("",ls_currentdate + is_productgroup + is_itemcode )
if ln_row < 1 then
	uo_status.st_message.text = '조회할 정보가 없습니다'
else
	uo_status.st_message.text = '  ' + string(ln_row) + ' 건 조회완료'
end if
end event

event activate;call super::activate;dw_2.settransobject(sqlpis)
end event

type uo_status from w_origin_sheet09`uo_status within w_seq115i
end type

type uo_area from u_pisc_select_area within w_seq115i
event destroy ( )
integer x = 78
integer y = 72
integer taborder = 90
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng,ls_productname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)



end event

event ue_select;call super::ue_select;string ls_divisionname,ls_divisionnameeng,ls_productname
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode  = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',false,is_divisioncode,ls_divisionname,ls_divisionnameeng)
f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',false,is_productgroup,ls_productname)


end event

type uo_division from u_pisc_select_division within w_seq115i
event destroy ( )
integer x = 617
integer y = 72
integer taborder = 100
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;string ls_productname
is_divisioncode = is_uo_divisioncode
//if ib_open = true then
	f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',false,is_productgroup,ls_productname)
//end if
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_productname
is_divisioncode = is_uo_divisioncode
if is_areacode = 'B' or is_areacode = 'K' then
	f_seq_retrieve_dddw_productgroup(uo_productgroup.dw_1,is_areacode,is_divisioncode,'%',false,is_productgroup,ls_productname)
end if
end event

type dw_2 from datawindow within w_seq115i
integer x = 50
integer y = 192
integer width = 4119
integer height = 2276
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_seq_inventory_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_2.settransobject(sqlpis)
end event

type uo_productgroup from u_seq_select_productgroup within w_seq115i
integer x = 1216
integer y = 72
integer taborder = 90
boolean bringtotop = true
end type

event ue_select;call super::ue_select;is_productgroup = is_uo_productgroup
end event

on uo_productgroup.destroy
call u_seq_select_productgroup::destroy
end on

type pb_excel from picturebutton within w_seq115i
integer x = 3973
integer y = 36
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

type uo_1 from u_pisc_select_custitem_kdac within w_seq115i
integer x = 2153
integer y = 52
integer taborder = 120
boolean bringtotop = true
end type

event destructor;call super::destructor;call u_pisc_select_custitem_kdac::destroy
end event

event ue_select;call super::ue_select;is_itemcode = is_uo_itemcode
end event

on uo_1.destroy
call u_pisc_select_custitem_kdac::destroy
end on

type gb_1 from groupbox within w_seq115i
integer x = 50
integer width = 3845
integer height = 176
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

