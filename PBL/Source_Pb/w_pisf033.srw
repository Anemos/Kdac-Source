$PBExportHeader$w_pisf033.srw
$PBExportComments$자재불출이력
forward
global type w_pisf033 from w_cmms_sheet01
end type
type st_2 from statictext within w_pisf033
end type
type em_2 from editmask within w_pisf033
end type
type cb_3 from commandbutton within w_pisf033
end type
type st_1 from statictext within w_pisf033
end type
type em_1 from editmask within w_pisf033
end type
type cb_2 from commandbutton within w_pisf033
end type
type dw_2 from uo_datawindow within w_pisf033
end type
type uo_area from u_cmms_select_area within w_pisf033
end type
type uo_division from u_cmms_select_division within w_pisf033
end type
end forward

global type w_pisf033 from w_cmms_sheet01
integer height = 2400
string title = "자재 - 불출이력"
st_2 st_2
em_2 em_2
cb_3 cb_3
st_1 st_1
em_1 em_1
cb_2 cb_2
dw_2 dw_2
uo_area uo_area
uo_division uo_division
end type
global w_pisf033 w_pisf033

type variables
string is_part , is_sql
boolean ib_opened = false
end variables

on w_pisf033.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_2=create em_2
this.cb_3=create cb_3
this.st_1=create st_1
this.em_1=create em_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.uo_area=create uo_area
this.uo_division=create uo_division
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.dw_2
this.Control[iCurrent+8]=this.uo_area
this.Control[iCurrent+9]=this.uo_division
end on

on w_pisf033.destroy
call super::destroy
destroy(this.st_2)
destroy(this.em_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.uo_area)
destroy(this.uo_division)
end on

event open;call super::open;datawindowchild ldwc
datetime ldt

is_sql=dw_2.object.datawindow.table.select 

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  false,  false, false,  false, false, false, false)


end event

event resize;call super::resize;////dw_1.width = newwidth
////dw_2.width = newwidth
////dw_2.height = newheight -940
//dw_1.width = newwidth
//
//dw_2.width = newwidth
//dw_2.height = newheight -1400
//
//dw_3.width = newwidth
//dw_3.y = dw_1.height+dw_2.height+130
//dw_3.height = newheight -dw_1.height -dw_2.height - 130 
//
//
dw_2.width= newwidth
dw_2.height = newheight - 230
end event

event ue_retrieve;call super::ue_retrieve;string sql
//sql=" and part_out.area_code = '"+gs_kmarea+"' and part_out.factory_code = '"+gs_kmdivision+"' and convert(varchar(10),out_date,120) between '"+em_2.text+"' and '"+em_1.text+"'" 
//dw_2.object.datawindow.table.select = is_sql +sql

dw_2.settransobject(sqlcmms)
dw_2.retrieve(gs_kmarea,gs_kmdivision,em_2.text,em_1.text)
end event

event ue_postopen;call super::ue_postopen;datetime ldt
string sql, ls_relativedate
datawindowchild ldwc

dw_2.GetChild('part_used', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_2.GetChild('part_used', ldwc)
f_dddw_width(dw_2, 'part_used', ldwc, 'used_name', 10)

em_2.text = string(relativedate(date(string(g_s_date,"@@@@-@@-@@")),-30) )

dw_2.settransobject(sqlcmms)
dw_2.retrieve(gs_kmarea,gs_kmdivision,em_2.text,em_1.text)
end event

event activate;call super::activate;if ib_opened then
	if uo_area.is_uo_areacode <> gs_kmarea then
		uo_area.is_uo_areacode = gs_kmarea
		uo_area.dw_1.setitem(1,"DDDWCode",gs_kmarea)
		uo_area.triggerevent('ue_select')
	end if
	uo_division.is_uo_divisioncode = gs_kmdivision
	uo_division.dw_1.setitem(1,"DDDWCode",gs_kmdivision)
end if
ib_opened = true

dw_2.settransobject(sqlcmms)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf033
end type

type st_2 from statictext within w_pisf033
integer x = 1362
integer y = 44
integer width = 251
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "불출일자:"
boolean focusrectangle = false
end type

type em_2 from editmask within w_pisf033
integer x = 1614
integer y = 28
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean spin = true
end type

event constructor;this.text=string(g_s_date,"@@@@-@@-@@")
end event

type cb_3 from commandbutton within w_pisf033
integer x = 2025
integer y = 32
integer width = 87
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "▽"
end type

event clicked;str_xy str_lxy
string ls_return_dt
str_lxy.lx = iw_This.PointerX()
str_lxy.ly = iw_This.PointerY() + 350
openwithparm(w_today,str_lxy)
If isnull(message.Stringparm) Or message.Stringparm = '' then
	return
Else
	ls_return_dt = Message.StringParm   // powerobject
End If	
em_2.text = ls_return_dt

end event

type st_1 from statictext within w_pisf033
integer x = 2139
integer y = 44
integer width = 82
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type em_1 from editmask within w_pisf033
integer x = 2222
integer y = 28
integer width = 402
integer height = 84
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean spin = true
end type

event constructor;this.text=string(g_s_date,"@@@@-@@-@@")
end event

type cb_2 from commandbutton within w_pisf033
integer x = 2633
integer y = 32
integer width = 87
integer height = 76
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "▽"
end type

event clicked;str_xy str_lxy
string ls_return_dt
str_lxy.lx = iw_This.PointerX()
str_lxy.ly = iw_This.PointerY() + 350
openwithparm(w_today,str_lxy)
If isnull(message.Stringparm) Or message.Stringparm = '' then
	return
Else
	ls_return_dt = Message.StringParm   // powerobject
End If	
em_1.text = ls_return_dt

end event

type dw_2 from uo_datawindow within w_pisf033
integer y = 140
integer width = 3497
integer height = 1984
integer taborder = 20
string dataobject = "d_part_out_hist111"
boolean ib_enter = false
end type

event rowfocuschanged;call super::rowfocuschanged;//string ls_serial
//if currentrow < 1 then return
//
//dw_1.setitem(dw_1.getrow(),'wo_code',this.getitemstring(currentrow,'wo_code') )
//dw_1.setitem(dw_1.getrow(),'equip_code',this.getitemstring(currentrow,'equip_code') )
//dw_1.setitem(dw_1.getrow(),'dept_code',this.getitemstring(currentrow,'dept_code') )
//dw_1.setitem(dw_1.getrow(),'invy_state',this.getitemstring(currentrow,'invy_state') )
//dw_1.setitem(dw_1.getrow(),'part_used',this.getitemstring(currentrow,'part_used') )
//dw_1.setitem(dw_1.getrow(),'return_qty',this.getitemnumber(currentrow,'out_qty') )
//dw_1.setitem(dw_1.getrow(),'return_date',f_cmms_sysdate())
//is_part = this.getitemstring(currentrow,'part_code')
//dw_1.triggerevent('ue_part_set')
//SELECT serial.serlal_no  
//    INTO :ls_serial
//    FROM serial  
//   WHERE serial.serial_div = 'return'   ;
//		
//	string ls_end_date, ls_endday
//
//	ls_end_date=f_date_end(string(g_s_date,"@@@@-@@-@@"))
//	ls_endday = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date
//
//	if string(g_s_date,"@@@@-@@-@@") = ls_endday and string(f_cmms_sysdate(),'yyyy-mm-dd hh:mm') > ls_endday + ' 19:50'  then
//		dw_1.setitem(dw_1.getrow(),'part_tag',this.getitemstring(currentrow,'dept_code')+right(string(relativedate(date(string(g_s_date,"@@@@-@@-@@")),1),"yyyymm"),3)+right(ls_serial,5))
//	else
//		dw_1.setitem(dw_1.getrow(),'part_tag',this.getitemstring(currentrow,'dept_code')+right(mid(g_s_date,1,6),3)+right(ls_serial,5))
//	end if
	//dw_1.setitem(dw_1.getrow(),'part_tag',this.getitemstring(currentrow,'dept_code')+right(mid(g_s_date,1,6),3)+right(ls_serial,5))
end event

event retrieveend;call super::retrieveend;if rowcount>0 then this.event post rowfocuschanged(1)
end event

type uo_area from u_cmms_select_area within w_pisf033
integer x = 105
integer y = 28
integer taborder = 30
boolean bringtotop = true
end type

on uo_area.destroy
call u_cmms_select_area::destroy
end on

event ue_select;call super::ue_select;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode

if f_spacechk(gs_kmdivision) = -1 then
	ls_divisioncode = '%'
else
	ls_divisioncode = gs_kmdivision
end if
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,ls_divisioncode,false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
end event

type uo_division from u_cmms_select_division within w_pisf033
integer x = 681
integer y = 32
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

