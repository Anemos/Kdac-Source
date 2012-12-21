$PBExportHeader$w_pisf032.srw
$PBExportComments$자재 반납
forward
global type w_pisf032 from w_cmms_sheet01
end type
type dw_3 from uo_datawindow within w_pisf032
end type
type st_2 from statictext within w_pisf032
end type
type em_2 from editmask within w_pisf032
end type
type cb_3 from commandbutton within w_pisf032
end type
type st_1 from statictext within w_pisf032
end type
type em_1 from editmask within w_pisf032
end type
type cb_2 from commandbutton within w_pisf032
end type
type dw_2 from uo_datawindow within w_pisf032
end type
type dw_1 from datawindow within w_pisf032
end type
type cb_1 from commandbutton within w_pisf032
end type
type uo_area from u_cmms_select_area within w_pisf032
end type
type uo_division from u_cmms_select_division within w_pisf032
end type
type dw_as400 from datawindow within w_pisf032
end type
end forward

global type w_pisf032 from w_cmms_sheet01
integer height = 2400
string title = "자재 -반납"
dw_3 dw_3
st_2 st_2
em_2 em_2
cb_3 cb_3
st_1 st_1
em_1 em_1
cb_2 cb_2
dw_2 dw_2
dw_1 dw_1
cb_1 cb_1
uo_area uo_area
uo_division uo_division
dw_as400 dw_as400
end type
global w_pisf032 w_pisf032

type variables
string is_part , is_sql, is_sqldw3

boolean ib_opened = false
end variables

on w_pisf032.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.st_2=create st_2
this.em_2=create em_2
this.cb_3=create cb_3
this.st_1=create st_1
this.em_1=create em_1
this.cb_2=create cb_2
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_as400=create dw_as400
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_1
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.dw_2
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.uo_area
this.Control[iCurrent+12]=this.uo_division
this.Control[iCurrent+13]=this.dw_as400
end on

on w_pisf032.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.st_2)
destroy(this.em_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_as400)
end on

event open;call super::open;dw_1.settransobject(sqlcmms)
dw_2.settransobject(sqlcmms)
dw_3.settransobject(sqlcmms)

is_sql = dw_2.object.datawindow.table.select 
is_sqldw3 = dw_3.object.datawindow.table.select

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false,  false, false, false, false)

end event

event resize;call super::resize;//dw_1.width = newwidth
//dw_2.width = newwidth
//dw_2.height = newheight -940
dw_1.width = newwidth

dw_2.width = newwidth
dw_2.height = newheight -1500

dw_3.width = newwidth
dw_3.y = dw_1.height+dw_2.height+130
dw_3.height = newheight -dw_1.height -dw_2.height - 240


end event

event ue_retrieve;call super::ue_retrieve;string sql

dw_1.reset()
dw_1.insertrow(0)

sql = " and part_out.area_code = '"+gs_kmarea+"' and part_out.factory_code = '"+gs_kmdivision+"' and convert(varchar(10),out_date,120) between '"+em_2.text+"' and '"+em_1.text+"'" 
dw_2.object.datawindow.table.select = is_sql +sql
sql = " and part_return.area_code = '"+gs_kmarea+"' and part_return.factory_code = '"+gs_kmdivision+"' and convert(varchar(10),return_date,120) between '"+em_2.text+"' and '"+em_1.text+"'" 
dw_3.object.datawindow.table.select = is_sqldw3 + sql

dw_2.retrieve()
dw_3.retrieve()

return 0
end event

event ue_postopen;call super::ue_postopen;datetime ldt
datawindowchild ldwc
string sql, ls_relativedate

em_2.text = string(relativedate(Date(string(g_s_date,"@@@@-@@-@@")),-30) )
ls_relativedate = string(relativedate(Date(string(g_s_date,"@@@@-@@-@@")),-30))

dw_2.settransobject(sqlcmms)
dw_1.settransobject(sqlcmms)
dw_3.settransobject(sqlcmms)

dw_1.GetChild('part_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_1.GetChild('equip_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_1.GetChild('equip_code_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_1.GetChild('part_used', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_2.GetChild('part_used', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_3.GetChild('part_return_part_used', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_1.GetChild('part_code', ldwc)
f_dddw_width(dw_1, 'part_code', ldwc, 'part_spec', 10)

dw_1.GetChild('part_used', ldwc)
f_dddw_width(dw_1, 'part_used', ldwc, 'used_name', 10)

dw_1.GetChild('equip_code', ldwc)
f_dddw_width(dw_1, 'equip_code', ldwc, 'equip_name', 10)

ldt = DateTime(string(g_s_date,"@@@@-@@-@@"))
dw_1.SetItem(1, 'return_date', ldt)

this.triggerevent('ue_retrieve')
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
dw_1.settransobject(sqlcmms)
dw_3.settransobject(sqlcmms)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf032
end type

type dw_3 from uo_datawindow within w_pisf032
integer y = 1616
integer width = 2770
integer height = 656
integer taborder = 30
string dataobject = "d_part_dummy1"
boolean ib_select_row = false
boolean ib_enter = false
boolean ib_copy = false
boolean ib_filter = false
boolean ib_sort = false
boolean ib_toggle = false
boolean ib_date = false
end type

type st_2 from statictext within w_pisf032
integer x = 1714
integer y = 820
integer width = 251
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "적용일자:"
boolean focusrectangle = false
end type

type em_2 from editmask within w_pisf032
integer x = 1966
integer y = 804
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

event constructor;this.text= string(g_s_date,"@@@@-@@-@@")
end event

type cb_3 from commandbutton within w_pisf032
integer x = 2377
integer y = 808
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

type st_1 from statictext within w_pisf032
integer x = 2491
integer y = 820
integer width = 82
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
string text = "~~"
boolean focusrectangle = false
end type

type em_1 from editmask within w_pisf032
integer x = 2574
integer y = 804
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

event constructor;this.text= string(g_s_date,"@@@@-@@-@@")
end event

type cb_2 from commandbutton within w_pisf032
integer x = 2985
integer y = 808
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

type dw_2 from uo_datawindow within w_pisf032
integer y = 944
integer width = 2775
integer height = 656
integer taborder = 20
string dataobject = "d_part_out_hist_01"
boolean ib_enter = false
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_serial
if currentrow < 1 then return

dw_1.setitem(dw_1.getrow(),'wo_code',this.getitemstring(currentrow,'wo_code') )
dw_1.setitem(dw_1.getrow(),'equip_code',this.getitemstring(currentrow,'equip_code') )
dw_1.setitem(dw_1.getrow(),'dept_code',this.getitemstring(currentrow,'dept_code') )
dw_1.setitem(dw_1.getrow(),'invy_state',this.getitemstring(currentrow,'invy_state') )
dw_1.setitem(dw_1.getrow(),'part_used',this.getitemstring(currentrow,'part_used') )
dw_1.setitem(dw_1.getrow(),'return_qty',this.getitemnumber(currentrow,'out_qty') )
dw_1.setitem(dw_1.getrow(),'return_date',f_cmms_sysdate())
is_part = this.getitemstring(currentrow,'part_code')
dw_1.triggerevent('ue_part_set')
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

event retrieveend;call super::retrieveend;if rowcount > 0 then this.event post rowfocuschanged(1)
end event

type dw_1 from datawindow within w_pisf032
event ue_part_set ( )
integer y = 116
integer width = 3429
integer height = 812
integer taborder = 10
string title = "none"
string dataobject = "d_part_return"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_part_set();if this.getrow() <= 0 then return

string ls_colname
datawindowchild ldwc
long ll_row
string ls_part_name
string ls_part_code, ls_part_spec, ls_part_unit
dec{1} ls_normal_qty,ls_repair_qty, ls_etc_qty, ls_part_cost, ls_scram_qty
//ls_colname = dwo.name

	this.GetChild('part_code', ldwc)
	This.AcceptText()
	ls_part_code = is_part
	If isnull(ls_part_code) or ls_part_code = '' then Return

	ll_row = f_dddw_getrow(This,this.getrow(),'part_code',ls_part_code)
	//ll_row = ldwc.GetRow()
	if ll_row > 0 then
		ls_part_name = ldwc.GetItemString(ll_row, 'part_name')
		ls_part_spec = ldwc.GetItemString(ll_row, 'part_spec')
		ls_part_unit = ldwc.GetItemString(ll_row, 'part_unit')
		ls_normal_qty = ldwc.GetItemnumber(ll_row, 'normal_qty')
		ls_repair_qty = ldwc.GetItemnumber(ll_row, 'repair_qty')
		ls_etc_qty = ldwc.GetItemnumber(ll_row, 'etc_qty')
		ls_part_cost = ldwc.GetItemnumber(ll_row, 'part_cost')
		ls_scram_qty = ldwc.GetItemnumber(ll_row, 'scram_qty')
		this.SetItem(this.getrow(), 'part_code', ls_part_code)
		this.SetItem(this.getrow(), 'part_name', ls_part_name)
		this.SetItem(this.getrow(), 'part_spec', ls_part_spec)
		this.SetItem(this.getrow(), 'part_unit', ls_part_unit)
		this.SetItem(this.getrow(), 'normal_qty', ls_normal_qty)
		this.SetItem(this.getrow(), 'repair_qty', ls_repair_qty)
		this.SetItem(this.getrow(), 'etc_qty', ls_etc_qty)
		this.SetItem(this.getrow(), 'part_cost', ls_part_cost)
		this.SetItem(this.getrow(), 'scram_qty', ls_scram_qty)
	end if


end event

event doubleclicked;str_parm lstr
long ll_upper_bound, i, ll_insert
string ls_data[]
datawindowchild ldwc

if lower(string(dwo.name)) = 'part_code' then

	lstr.s_parm[1] = 'd_lookup_part'
	lstr.s_parm[2] = ''	
	lstr.s_parm[3] = '1'	
	lstr.Check = true
	
	OpenWithParm(w_cd_search_multi,lstr)
	
	lstr = Message.PowerObjectParm
	
	ll_upper_bound = UpperBound(lstr.s_array, 1)
	
	if ll_upper_bound < 1 then return
	
	for i = 1 to ll_upper_bound
		if IsNull(lstr.s_array[i, 1]) or lstr.s_array[i, 1] = '' then exit
		
		if i = 1 then
			this.SetItem(row, 'part_code', lstr.s_array[i, 1])
			ll_insert = row
		else
			ll_insert = this.InsertRow(0)
			this.SetItem(ll_insert, 'part_code', lstr.s_array[i, 1])
		end if

		dw_1.GetChild('part_code', ldwc)
		ldwc.settransobject(sqlcmms)
		ldwc.retrieve(gs_kmarea, gs_kmdivision)
		f_dddw_width(dw_1, 'part_code', ldwc, 'part_spec', 10)
		
		this.Event ItemChanged(ll_insert, dwo, lstr.s_array[i, 1])
	next
end if

Choose Case dwo.name 
	Case 'equip_code'
		IF f_code_search('d_lookup_equip', '', ls_data[]) THEN
			This.SetItem(row, 'equip_code', ls_data[1])
		END IF
//	case 'dept_code'
//		IF f_code_search('d_lookup_cc', '', ls_data[]) THEN
//			This.SetItem(row, 'dept_code', ls_data[1])
//		END IF
	Case 'dept_code'
		if isnull(dw_1.getitemstring(row,'part_used')) or dw_1.getitemstring(row,'part_used')='' then
			messagebox("알림",'용도를 입력하지 않으면 부서(업체)를 입력할 수 없습니다.')
			dw_1.setcolumn('part_used')
		else
			if dw_1.getitemstring(row,'part_used')='04' or dw_1.getitemstring(row,'part_used')='07'then
				IF f_code_search('d_lookup_comp', '', ls_data[]) THEN
					This.SetItem(row, 'dept_code', ls_data[1])
				END IF
//			elseif dw_1.getitemstring(row,'part_used')='06' then
//				IF f_code_search('d_lookup_cc_a', '', ls_data[]) THEN
//					This.SetItem(row, 'dept_code', ls_data[1])
//				END IF
			else
				if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then
					IF f_code_search('d_lookup_cc_inv', '', ls_data[]) THEN
						This.SetItem(row, 'dept_code', ls_data[1])
					END IF
				else
					IF f_code_search('d_lookup_cc_a', '', ls_data[]) THEN
						This.SetItem(row, 'dept_code', ls_data[1])
					END IF
				end if
			end if
		end if
	case 'part_used'
		IF f_code_search('d_lookup_used', '', ls_data[]) THEN
			This.SetItem(row, 'part_used', ls_data[1])
		END IF
End Choose		
end event

event itemchanged;if row <= 0 then return

string ls_colname,ls_serial
datawindowchild ldwc
long ll_row
string ls_part_name
string ls_part_code, ls_part_spec, ls_part_unit
long ls_normal_qty,ls_repair_qty, ls_etc_qty, ls_part_cost,ls_scram_qty
ls_colname = dwo.name

if ls_colname = 'part_code' then
	this.GetChild('part_code', ldwc)
	This.AcceptText()
	ls_part_code = This.GetItemString(row,'part_code')
	If isnull(ls_part_code) or ls_part_code = '' then Return

	ll_row = f_dddw_getrow(This,row,'part_code',ls_part_code)
	//ll_row = ldwc.GetRow()
	if ll_row > 0 then
		ls_part_name = ldwc.GetItemString(ll_row, 'part_name')
		ls_part_spec = ldwc.GetItemString(ll_row, 'part_spec')
		ls_part_unit = ldwc.GetItemString(ll_row, 'part_unit')
		ls_normal_qty = ldwc.GetItemnumber(ll_row, 'normal_qty')
		ls_repair_qty = ldwc.GetItemnumber(ll_row, 'repair_qty')
		ls_etc_qty = ldwc.GetItemnumber(ll_row, 'etc_qty')
		ls_part_cost = ldwc.GetItemnumber(ll_row, 'part_cost')
		ls_scram_qty = ldwc.GetItemnumber(ll_row, 'scram_qty')
		this.SetItem(row, 'part_name', ls_part_name)
		this.SetItem(row, 'part_spec', ls_part_spec)
		this.SetItem(row, 'part_unit', ls_part_unit)
		this.SetItem(row, 'normal_qty', ls_normal_qty)
		this.SetItem(row, 'repair_qty', ls_repair_qty)
		this.SetItem(row, 'etc_qty', ls_etc_qty)
		this.SetItem(row, 'part_cost', ls_part_cost)
		this.SetItem(this.getrow(), 'scram_qty', ls_scram_qty)
		dw_1.setitem(dw_1.getrow(),'return_date',f_cmms_sysdate())
	end if
end if
if ls_colname = 'equip_code' then
	string ls_equip, ls_cc_code
	ls_equip = data
	
	SELECT equip_master.cc_code  
    	INTO :ls_cc_code
    	FROM equip_master  
   	WHERE equip_master.equip_code = :ls_equip and area_code =:gs_kmarea and factory_code = :gs_kmdivision 
		using sqlcmms;
	
	dw_1.setitem(row,'dept_code',ls_cc_code)
end if
//if ls_colname = 'part_tag' then
//	SELECT serial.serlal_no  
//    INTO :ls_serial
//    FROM serial  
//   WHERE serial.serial_div = 'return'   
//		using sqlcmms;
//	dw_1.setitem(dw_1.getrow(),'part_tag',data+right(mid(g_s_date,1,6),3)+right(ls_serial,5))
//end if
//
end event

event buttonclicked;string ls_return_dt
str_xy str_lxy
long ll_upper_bound
string ls_data[]
str_parm lstr

if lower(string(dwo.name)) = 'part_code' then

	lstr.s_parm[1] = 'd_lookup_part'
	lstr.s_parm[2] = ''	
	lstr.s_parm[3] = '1'	
	lstr.Check = true
	
	OpenWithParm(w_cd_search_multi,lstr)
	
	lstr = Message.PowerObjectParm
	
	ll_upper_bound = UpperBound(lstr.s_array, 1)
	
	if ll_upper_bound < 1 then return

	OpenWithParm(w_cd_search_multi,lstr)
	end if
choose case dwo.name
	case 'b_1'
		str_lxy.lx = iw_This.PointerX()
		str_lxy.ly = iw_This.PointerY() + 350
		openwithparm(w_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return
		Else
			ls_return_dt = Message.StringParm   // powerobject
		End If	
		this.SetItem(row, 'return_date', date(ls_return_dt))
		
		case 'b_2'
		if isnull(dw_1.getitemstring(row,'part_used')) or dw_1.getitemstring(row,'part_used')='' then
			messagebox("알림",'용도를 입력하지 않으면 부서(업체)를 입력할 수 없습니다.')
			dw_1.setcolumn('part_used')
		else
			if dw_1.getitemstring(row,'part_used')='04' or dw_1.getitemstring(row,'part_used')='07'then
				IF f_code_search('d_lookup_comp', '', ls_data[]) THEN
					This.SetItem(row, 'dept_code', ls_data[1])
				END IF
//			elseif dw_1.getitemstring(row,'part_used')='06' then
//				IF f_code_search('d_lookup_cc_a', '', ls_data[]) THEN
//					This.SetItem(row, 'dept_code', ls_data[1])
//				END IF
			else
				if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then
					IF f_code_search('d_lookup_cc_inv', '', ls_data[]) THEN
						This.SetItem(row, 'dept_code', ls_data[1])
					END IF
				else
					IF f_code_search('d_lookup_cc_a', '', ls_data[]) THEN
						This.SetItem(row, 'dept_code', ls_data[1])
					END IF
				end if
			end if
		end if
		
	case 'b_3'		
//			string ls_colname, ls_serial
//			string ls_data1
//	
//			ls_data1 =dw_1.getitemstring(row,'dept_code')
//			
//			if isnull(ls_data1) or ls_data1='' then
//				messagebox("알림",'불출전표 발행하기전에 부서(업체)코드를 먼저 입력하셔야 합니다!!')
//				return
//			end if
//			
//		//	messagebox('1',ls_data1)			
//				SELECT serial.serlal_no  
//				 INTO :ls_serial
//				 FROM serial  
//				WHERE serial.serial_div = 'return'   
//				using sqlcmms;
////				dw_1.setitem(dw_1.getrow(),'part_tag',ls_data1+right(mid(g_s_date,1,6),3)+right(ls_serial,5))
//				
//				string ls_end_date, ls_endday
//
//				ls_end_date=f_date_end(string(g_s_date,"@@@@-@@-@@"))
//				ls_endday = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date
//
//				if string(g_s_date,"@@@@-@@-@@") = ls_endday and string(f_cmms_sysdate(),'yyyy-mm-dd hh:mm') > ls_endday + ' 19:50'  then
//					dw_1.setitem(dw_1.getrow(),'part_tag',ls_data1+right(string(relativedate(date(string(g_s_date,"@@@@-@@-@@")),1),"yyyymm"),3)+right(ls_serial,5))
//				else
//					dw_1.setitem(dw_1.getrow(),'part_tag',ls_data1+right(string(dw_1.getitemdatetime(dw_1.getrow(),'out_date'),"yyyymm"),3)+right(ls_serial,5))
//				end if
end choose


end event

event dberror;f_show_dberror(sqldbcode)

return 1
end event

event clicked;string ls_colname, ls_serial

ls_colname = dwo.name
choose case dwo.name
	case 'dept_code'
		if isnull(dw_1.getitemstring(row,'part_used')) or dw_1.getitemstring(row,'part_used')='' then
			messagebox("알림",'용도를 입력하지 않으면 부서(업체)를 입력할 수 없습니다.')
			dw_1.setcolumn('part_used')
		end if
end choose
end event

type cb_1 from commandbutton within w_pisf032
integer x = 9
integer y = 8
integer width = 521
integer height = 96
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "반    납"
end type

event clicked;datawindowchild ld_aa
string wo_code, part_code, ls_as, ls_serial, ls_serial1,ls_serial2
string ls_equip_code, ls_equip,  ls_cc_code, ls_cc, ls_state, ls_message
long qty, ll_check, i, qty_1, ln_CurRow, ln_RtnCode
dec{1} lc_partcost
str_ipis_server lstr_As400[]
String ls_areadivision[1]

string ls_end_date, ls_endday

ls_end_date=f_date_end(string(g_s_date,"@@@@-@@-@@"))
ls_endday = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date

if dw_1.getitemstring(dw_1.getrow(),'part_code') ='' or isnull(dw_1.getitemstring(dw_1.getrow(),'part_code')) or dw_1.getitemstring(dw_1.getrow(),'dept_code') ='' or isnull(dw_1.getitemstring(dw_1.getrow(),'dept_code')) then
	uo_status.st_message.text = "품번, 부서코드는 반드시 입력하십시오."
	return 0
end if

if dw_1.getitemstring(dw_1.getrow(),'part_used') = '' or isnull( dw_1.getitemstring(dw_1.getrow(),'part_used')) then
	uo_status.st_message.text = "용도를 선택해 주십시요."
	return 0
end if

dw_1.accepttext()
part_code= dw_1.getitemstring(dw_1.getrow(),'part_code')
lc_partcost = dw_1.getitemdecimal(dw_1.getrow(),'part_cost')
ls_state = dw_1.getitemstring( dw_1.getrow(),'invy_state')

if f_spacechk(part_code) = -1 then
	uo_status.st_message.text = "품번을 입력하십시요"
	return 0
else
	select count(*) into :ll_check from part_master
	where area_code = :gs_kmarea and
			factory_code = :gs_kmdivision and
			part_code = :part_code  using sqlcmms;
			
	if ll_check < 1 or sqlcmms.sqlcode <> 0 then
		uo_status.st_message.text = '품번을 다시 확인해 주십시요'
		return 0
	end if
end if

// 자재시스템 직접 연결하므로 필요없음
//if ls_state <> 'X' and (lc_partcost = 0 or isnull(lc_partcost)) then
//	messagebox("알림",'부외재고이외의 반납은 단가가 결정되어있어야 합니다.')
//	return 
//end if

if dw_1.getitemnumber(dw_1.getrow(),'return_qty') <=0  then
 	uo_status.st_message.text = "반납수량이 0이거나 0보다 작기때문에 반납하실 수 없습니다."
	return
end if

if string(dw_1.getitemdatetime(dw_1.getrow(),'return_date'),'yyyy-mm-dd') > string(g_s_date,"@@@@-@@-@@")  then
	uo_status.st_message.text = "반납일자가 오늘일자보다 큽니다. 다시입력하세요."
	return
end if
if string(dw_1.getitemdatetime(dw_1.getrow(),'return_date'),'yyyy-mm-dd') < string(relativedate(date(string(g_s_date,"@@@@-@@-@@")),-30),'yyyy-mm-dd')  then
	uo_status.st_message.text = "반납일자가 범위를 넘었습니다. 다시입력하세요."
	return
end if

if string(g_s_date,"@@@@-@@-@@") = ls_endday and string(f_cmms_sysdate(),'yyyy-mm-dd hh:mm') > ls_endday + ' 19:50'  then
	dw_1.setitem(dw_1.getrow(),'return_date',relativedate(date(string(g_s_date,"@@@@-@@-@@")),1))
end if	

ls_equip = dw_1.getitemstring(dw_1.getrow(),'equip_code')
ls_cc = dw_1.getitemstring(dw_1.getrow(),'dept_code')

SELECT equip_code INTO :ls_equip_code
	FROM equip_master  
	WHERE equip_code = :ls_equip and area_code =:gs_kmarea and 
			factory_code = :gs_kmdivision 
			using sqlcmms;

if (ls_equip_code ='' or isnull(ls_equip_code)) &
		and (ls_equip <> '') and (Not IsNull(ls_equip)) then
	uo_status.st_message.text = "장비번호가 존재하지 않습니다."
	return
end if

if gs_kmArea = 'D' And gs_kmDivision = 'R' then
	SELECT cc_code INTO :ls_cc_code
		FROM cc_master  
		WHERE cc_code = :ls_cc
		using sqlcmms;
else
	SELECT cc_code INTO :ls_cc_code
		FROM cc_inv  
		WHERE cc_code = :ls_cc
				AND AREA_CODE = :gs_kmArea 
				AND FACTORY_CODE = :gs_kmDivision
		using sqlcmms;
end if

if  dw_1.getitemstring(dw_1.getrow(),'part_used')='04' or dw_1.getitemstring(dw_1.getrow(),'part_used')='07' then
	if mid(ls_cc,1,1) <> 'D' then
		uo_status.st_message.text = "부서에 업체코드가 들어가야 합니다."
		return 0
	end if
	
	SELECT comp_master.comp_code  
		INTO :ls_cc_code
		FROM comp_master  
		WHERE comp_master.comp_code = :ls_cc and comp_master.comp_div_code1 ='외주업체' 
		using sqlcmms;
	if (ls_cc_code ='' or isnull(ls_cc_code)) then 
		uo_status.st_message.text = "업체가 존재하지 않습니다."
		return 0
	end if	
else
	if (ls_cc_code ='' or isnull(ls_cc_code)) then 
		uo_status.st_message.text = "부서가 존재하지 않습니다."
		return
	end if
end if

ll_check= messagebox("알림",'반납 하시겠습니까?', Exclamation!, OKCancel!, 2)
if ll_check <> 1 then
	uo_status.st_message.text = '반납이 취소되었습니다.'
	return 0
end if

string ls_colname // ls_serial
string ls_data1

ls_data1 =dw_1.getitemstring(dw_1.getrow(),'dept_code')
		
if isnull(ls_data1) or ls_data1='' then
	uo_status.st_message.text = "반납전표 발행하기전에 부서(업체)코드를 먼저 입력하셔야 합니다!!"
	return 0
end if

sqlcmms.AutoCommit = False
SetPointer(HourGlass!)

SELECT serial.serlal_no  
	INTO :ls_serial
	FROM serial  
	WHERE serial.area_code = :gs_kmarea and
			serial.factory_code = :gs_kmdivision and 
			serial.serial_div = 'return'   
	using sqlcmms;
			
string ls_end_date1, ls_endday1
ls_end_date1=f_date_end(string(g_s_date,"@@@@-@@-@@"))
ls_endday1 = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date1

if string(g_s_date,"@@@@-@@-@@") = ls_endday1 and string(f_cmms_sysdate(),'yyyy-mm-dd hh:mm') > ls_endday1 + ' 19:50'  then
	dw_1.setitem(dw_1.getrow(),'part_tag',ls_data1+right(string(relativedate(date(string(g_s_date,"@@@@-@@-@@")),1),"yyyymm"),3)+right(ls_serial,5))
else
	dw_1.setitem(dw_1.getrow(),'part_tag',ls_data1+right(string(dw_1.getitemdatetime(dw_1.getrow(),'return_date'),"yyyymm"),3)+right(ls_serial,5))
end if

SELECT serial.serlal_no  
 INTO :ls_serial
 FROM serial  
WHERE serial.area_code = :gs_kmarea and
			serial.factory_code = :gs_kmdivision and
			serial.serial_div = 'return'   
using sqlcmms;
			
ls_serial1=string(long(ls_serial)+1)
for i= 1 to 8 - len(ls_serial1)
	ls_serial2 = ls_serial2+'0'
next

ls_serial1 =ls_serial2+ls_serial1
UPDATE serial  
	SET serlal_no = :ls_serial1  
	WHERE serial.area_code = :gs_kmarea and
			serial.factory_code = :gs_kmdivision and
			serial.serial_div = 'return'   
	using sqlcmms;

if sqlcmms.sqlcode <> 0 then
	ls_message = "SERIAL_NO UPDATE중 오류가 발생하였습니다."
	Goto RollBack_	
end if

dw_1.setitem(dw_1.getrow(),'part_return_area_code',uo_area.is_uo_areacode)
dw_1.setitem(dw_1.getrow(),'part_return_factory_code',uo_division.is_uo_divisioncode)
dw_1.setitem(dw_1.getrow(),'part_return_return_serial',ls_serial)
dw_1.setitem(dw_1.getrow(),'part_return_up_div', 'Y')

wo_code=dw_1.getitemstring(dw_1.getrow(),'wo_code')
part_code=dw_1.getitemstring(dw_1.getrow(),'part_code')
qty=dw_1.getitemnumber(dw_1.getrow(),'return_qty')

//연구소는 자재 재고관리를 하지 않는다
if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then 
//	if lc_partcost = 0 or isnull(lc_partcost) then
//		qty_1= dw_1.getitemnumber( dw_1.getrow(),'etc_qty') + qty
//		UPDATE part_master  
//			SET etc_qty = :qty_1 
//			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
//					part_master.part_code = :part_code    
//			using sqlcmms;		
//	else
	if dw_1.getitemstring( dw_1.getrow(),'invy_state')='U' then	
		qty_1= dw_1.getitemnumber( dw_1.getrow(),'normal_qty') + qty
	  UPDATE part_master  
			SET normal_qty = :qty_1 
			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
					part_master.part_code = :part_code    
			using sqlcmms;
	elseif dw_1.getitemstring( dw_1.getrow(),'invy_state')='R'then
		qty_1= dw_1.getitemnumber( dw_1.getrow(),'repair_qty') + qty
	  UPDATE part_master  
			SET repair_qty = :qty_1 
			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
					part_master.part_code = :part_code    
			using sqlcmms;
	elseif dw_1.getitemstring( dw_1.getrow(),'invy_state')='S'then
		qty_1= dw_1.getitemnumber( dw_1.getrow(),'scram_qty') + qty
	  UPDATE part_master  
			SET scram_qty = :qty_1 
			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
					part_master.part_code = :part_code    
			using sqlcmms;	
	elseif dw_1.getitemstring( dw_1.getrow(),'invy_state')='X'then
		qty_1= dw_1.getitemnumber( dw_1.getrow(),'etc_qty') + qty
	  UPDATE part_master  
			SET etc_qty = :qty_1 
			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
					part_master.part_code = :part_code    
			using sqlcmms;
	else 
		ls_message = "재고상태를 선택하세요!!"
		Goto RollBack_	
	end if
		
//	end if
	
	if sqlcmms.sqlcode <> 0 then
		ls_message = "PART_MASTER UPDATE중 오류가 발생하였습니다."
		Goto RollBack_	
	end if
	
	//PART_RETURN 업데이트
	dw_1.Accepttext()
	if dw_1.update() = - 1 then
		ls_message = "데이타윈도우 UPDATE중 오류가 발생했읍니다."
		Goto RollBack_	
	end if
	
	//AS400 INV401 업데이트
	dw_as400.Reset()
	ln_CurRow = dw_as400.InsertRow(0)
	
	// 매개변수 dw에 데이터 넣기
	dw_as400.setitem(ln_CurRow, "AREACODE", dw_1.GetItemString(dw_1.GetRow(), "part_return_area_code"))
	dw_as400.setitem(ln_CurRow, "DIVISIONCODE", dw_1.GetItemString(dw_1.GetRow(), "part_return_factory_code"))
	dw_as400.setitem(ln_CurRow, "returndate", String(dw_1.GetItemDateTime(dw_1.GetRow(), "return_date"), "yyyymmdd"))
	dw_as400.setitem(ln_CurRow, "serialno", dw_1.GetItemString(dw_1.GetRow(), "part_return_return_serial"))
	dw_as400.setitem(ln_CurRow, "itemcode", Upper(dw_1.GetItemString(dw_1.GetRow(), "part_code")))
	dw_as400.setitem(ln_CurRow, "slipno", Left(dw_1.GetItemString(dw_1.GetRow(), "part_tag"), 12))
	if IsNull(dw_1.GetItemString(dw_1.GetRow(), "wo_code")) then
		dw_as400.setitem(ln_CurRow, "orderno", " ")
	else
		dw_as400.setitem(ln_CurRow, "orderno", Left(dw_1.GetItemString(dw_1.GetRow(), "wo_code"), 16))
	end if
	dw_as400.setitem(ln_CurRow, "deptcode", dw_1.GetItemString(dw_1.GetRow(), "dept_code"))
	dw_as400.setitem(ln_CurRow, "usage", dw_1.GetItemString(dw_1.GetRow(), "part_used"))
	if IsNull(dw_1.GetItemString(dw_1.GetRow(), "equip_code")) then
		dw_as400.setitem(ln_CurRow, "mcno", " ")
	else
		dw_as400.setitem(ln_CurRow, "mcno", dw_1.GetItemString(dw_1.GetRow(), "equip_code"))
	end if
	dw_as400.setitem(ln_CurRow, "stockstatus", dw_1.GetItemString(dw_1.GetRow(), "invy_state"))
	dw_as400.setitem(ln_CurRow, "returnqty", dw_1.GetItemNumber(dw_1.GetRow(), "return_qty"))
	dw_as400.setitem(ln_CurRow, "datastatus", "C")
	dw_as400.setitem(ln_CurRow, "uploadflag", "Y")
	dw_as400.setitem(ln_CurRow, "lastemp", g_s_empno)
	dw_as400.setitem(ln_CurRow, "lastdate", Now())

	// AS400 CONN 생성
	ls_areadivision[1] = "XZ"
	lstr_As400 = f_ipis_server_set_transaction('EACH', ls_areadivision)
	if UpperBound(lstr_As400) = 0 or f_ipis_server_get_transaction(lstr_As400,'X','Z') = -1 then
		ls_message = "DB CONN 생성실패!!"
	  	goto Rollback_
	End if
	lstr_As400[f_ipis_server_get_transaction(lstr_As400,'X','Z')].t_sqlpis.AutoCommit = False
	
	//인터페이스함수로 전달하기 위한 DWO 생성
	ln_RtnCode = f_up_ipis_mis_tmcpartreturn(ls_message, dw_as400, lstr_As400)
	If ln_RtnCode = -1 then goto RollBack_
end if
	
//	성공
Commit Using sqlcmms;
sqlcmms.AutoCommit = True

//AS400 COMMIT
if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then 
	f_ipis_server_commit_transaction(lstr_As400)
end if
	
SetPointer(Arrow!)
uo_status.st_message.text = "정상적으로 자재가 반납되었습니다."

dw_1.rowscopy(dw_1.getrow(),dw_1.getrow(),Primary!,dw_3,1,Primary!)

dw_1.getchild('part_code', ld_aa)
ld_aa.settransobject(sqlcmms)
ld_aa.retrieve(gs_kmarea, gs_kmdivision)

long asdf
dw_1.reset()
asdf=dw_1.insertrow(0)
dw_1.setrow(asdf)
dw_1.scrolltorow(asdf)

RETURN 1

//	실패
RollBack_:
RollBack Using sqlcmms;
sqlcmms.AutoCommit = True

//AS400 ROLLBACK
if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then
	f_ipis_server_rollback_transaction(lstr_As400)
end if

SetPointer(Arrow!)
uo_status.st_message.text = "반납오류" + ls_message

Parent.triggerevent('ue_retrieve')

return 0

end event

type uo_area from u_cmms_select_area within w_pisf032
event destroy ( )
integer x = 709
integer y = 20
integer taborder = 80
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

uo_division.triggerevent('ue_select')
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

type uo_division from u_cmms_select_division within w_pisf032
event destroy ( )
integer x = 1275
integer y = 20
integer taborder = 90
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type dw_as400 from datawindow within w_pisf032
boolean visible = false
integer x = 3058
integer y = 1068
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_up_ipis_mis_tmcpartreturn"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

