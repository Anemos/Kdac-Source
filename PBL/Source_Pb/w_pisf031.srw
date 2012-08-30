$PBExportHeader$w_pisf031.srw
$PBExportComments$자재 불출
forward
global type w_pisf031 from w_cmms_sheet01
end type
type dw_3 from uo_datawindow within w_pisf031
end type
type dw_2 from uo_datawindow within w_pisf031
end type
type dw_1 from datawindow within w_pisf031
end type
type cb_1 from commandbutton within w_pisf031
end type
type uo_area from u_cmms_select_area within w_pisf031
end type
type uo_division from u_cmms_select_division within w_pisf031
end type
type dw_as400 from datawindow within w_pisf031
end type
type cb_tlm from commandbutton within w_pisf031
end type
type gb_2 from groupbox within w_pisf031
end type
end forward

global type w_pisf031 from w_cmms_sheet01
integer width = 4585
integer height = 2580
string title = "자재 -불출"
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
cb_1 cb_1
uo_area uo_area
uo_division uo_division
dw_as400 dw_as400
cb_tlm cb_tlm
gb_2 gb_2
end type
global w_pisf031 w_pisf031

type variables
string is_check_wo
boolean ib_opened = false
end variables

on w_pisf031.create
int iCurrent
call super::create
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.dw_as400=create dw_as400
this.cb_tlm=create cb_tlm
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_3
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.dw_as400
this.Control[iCurrent+8]=this.cb_tlm
this.Control[iCurrent+9]=this.gb_2
end on

on w_pisf031.destroy
call super::destroy
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.dw_as400)
destroy(this.cb_tlm)
destroy(this.gb_2)
end on

event resize;call super::resize;dw_1.width = newwidth

dw_2.width = newwidth
dw_2.height = newheight -1500

dw_3.width = newwidth
dw_3.y = dw_1.height+dw_2.height+130
dw_3.height = newheight -dw_1.height -dw_2.height - 230
end event

event ue_postopen;call super::ue_postopen;str_parm str_get_parm
string ls_return[],ls_wo_code, ls_part, ls_equip_code
long ii, ll_find
datawindowchild ldwc
datetime ldt

dw_1.settransobject(sqlcmms)
ldt = f_cmms_sysdate()
dw_1.SetItem(1, 'out_date', ldt)
dw_2.settransobject(sqlcmms)
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

dw_1.GetChild('part_used', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_2.GetChild('wo_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_2.GetChild('wo_state_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_3.GetChild('part_out_part_used', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

//dw_1.GetChild('equip_code_1', ldwc)
//ldwc.settransobject(sqlcmms)
//ldwc.retrieve(gs_kmarea, gs_kmdivision)
//if ldwc.RowCount() < 1 then
//	ldwc.InsertRow(0)
//end if

//dw_1.GetChild('dept_code', ldwc)
//ldwc.settransobject(sqlcmms)
//ldwc.retrieve(gs_kmarea, gs_kmdivision)
//if ldwc.RowCount() < 1 then
//	ldwc.InsertRow(0)
//end if

dw_1.GetChild('part_code', ldwc)
f_dddw_width(dw_1, 'part_code', ldwc, 'part_spec', 10)

dw_1.GetChild('part_used', ldwc)
f_dddw_width(dw_1, 'part_used', ldwc, 'used_name', 10)

dw_1.GetChild('equip_code', ldwc)
f_dddw_width(dw_1, 'equip_code', ldwc, 'equip_name', 10)

//dw_1.GetChild('dept_code', ldwc)
//f_dddw_width(dw_1, 'dept_code', ldwc, 'cc_name', 10)

this.triggerevent('ue_retrieve')

str_get_parm = Message.PowerObjectParm

if Isvalid(str_get_parm) then
	For ii = 1 To UpperBound(str_get_parm.s_parm[])
		ls_return[ii] = str_get_parm.s_parm[ii]
	Next

	if UpperBound(ls_return[]) > 0 then
		ls_wo_code = ls_return[4]
		ls_part = ls_return[3]
		ls_equip_code = ls_return[5]
		is_check_wo =ls_return[6]
		ll_find = dw_2.find(" wo_code = '"+ls_wo_code+"'" , 1, dw_2.RowCount())					
		if ll_find < 1 then 
			dw_2.selectrow(dw_2.getrow(),false)
		else	
			dw_2.SetRow(ll_find)
			dw_2.ScrollToRow(ll_find)
			dw_2.SetFocus()
		end if
		
		dw_1.setitem(dw_1.getrow(),'part_code',trim(ls_part))
		dw_1.setitem(dw_1.getrow(),'equip_code',trim(ls_equip_code))
		dw_1.setitem(dw_1.getrow(),'wo_code',trim(ls_wo_code))
			
		dw_1.triggerevent('ue_part_set')
		dw_1.triggerevent('ue_equip_set')
	end if
end if

end event

event ue_retrieve;call super::ue_retrieve;datetime ldt

dw_1.reset()
dw_1.insertrow(0)

ldt = f_cmms_sysdate()
dw_1.SetItem(1, 'out_date', ldt)

dw_2.retrieve(gs_kmarea,gs_kmdivision)

dw_1.setcolumn('part_code')
dw_1.setfocus()
return 0
end event

event open;call super::open;// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  false,  false,  false,  false, false, false, false)
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

dw_1.settransobject(sqlcmms)
dw_2.settransobject(sqlcmms)
dw_3.settransobject(sqlcmms)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf031
end type

type dw_3 from uo_datawindow within w_pisf031
integer y = 1616
integer width = 3712
integer height = 656
integer taborder = 0
string dataobject = "d_part_dummy"
boolean ib_select_row = false
boolean ib_enter = false
boolean ib_copy = false
boolean ib_filter = false
boolean ib_sort = false
boolean ib_toggle = false
boolean ib_date = false
end type

type dw_2 from uo_datawindow within w_pisf031
integer y = 1060
integer width = 3712
integer height = 556
integer taborder = 50
string dataobject = "d_part_wo"
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_wocode, ls_equipcode

if currentrow < 1 then return 0

ls_wocode = This.getitemstring(currentrow,'wo_code')
ls_equipcode = This.getitemstring(currentrow,'equip_code')

dw_3.retrieve(gs_kmarea,gs_kmdivision,ls_wocode)

dw_1.setitem(1,'wo_code',ls_wocode)
dw_1.setitem(1,'equip_code',ls_equipcode)
dw_1.TriggerEvent('ue_part_set')

dw_1.setcolumn('part_code')
dw_1.setfocus()

return 0

end event

event retrieveend;call super::retrieveend;//if rowcount > 0 then this.event post rowfocuschanged(1)
end event

event clicked;call super::clicked;dw_1.setcolumn('part_code')
dw_1.setfocus()
end event

type dw_1 from datawindow within w_pisf031
event ue_part_set ( )
event us_equip_set ( )
event ue_equip_set ( )
integer y = 156
integer width = 4059
integer height = 896
integer taborder = 30
string title = "none"
string dataobject = "d_part_out"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_part_set();if this.getrow() <= 0 then return

string ls_colname
datawindowchild ldwc
long ll_row
string ls_part_name
string ls_part_code, ls_part_spec, ls_part_unit, ls_location
string ls_exequip_code, ls_unOrder, ls_unStock, ls_recent, ls_tel
dec{1} ls_normal_qty,ls_repair_qty, ls_etc_qty, ls_part_cost, ls_scram_qty
decimal ln_maxqty, ln_minqty
//ls_colname = dwo.name

this.GetChild('part_code', ldwc)
This.AcceptText()
ls_part_code = this.GetItemString(this.getrow(), "part_code")
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
	ls_location = ldwc.GetItemstring(ll_row, 'part_location')
	ln_maxqty = ldwc.GetItemDecimal(ll_row, 'part_maxq')
	ln_minqty = ldwc.GetItemDecimal(ll_row, 'part_minq')
	this.SetItem(this.getrow(), 'part_code', ls_part_code)
	this.SetItem(this.getrow(), 'part_name', ls_part_name)
	this.SetItem(this.getrow(), 'part_spec', ls_part_spec)
	this.SetItem(this.getrow(), 'part_unit', ls_part_unit)
	this.SetItem(this.getrow(), 'normal_qty', ls_normal_qty)
	this.SetItem(this.getrow(), 'repair_qty', ls_repair_qty)
	this.SetItem(this.getrow(), 'etc_qty', ls_etc_qty)
	this.SetItem(this.getrow(), 'part_cost', ls_part_cost)
	this.SetItem(this.getrow(), 'scram_qty', ls_scram_qty)
	this.SetItem(this.getrow(), 'part_location', ls_location)
	this.SetItem(this.getrow(), 'part_maxq', ln_maxqty)
	this.SetItem(this.getrow(), 'part_minq', ln_minqty)

	//전용장비
	SELECT TOP 1 EQUIP_CODE
	INTO :ls_exequip_code
	FROM EQUIP_SPARE
	WHERE AREA_CODE = :gs_kmarea AND FACTORY_CODE = :gs_kmdivision
			AND PART_CODE = :ls_part_code AND PART_FLAG = 'D'
	USING SQLCMMS;

	if SQLCMMS.sqlcode = 0 then
		this.Object.exequip.Text = ls_exequip_code
	else
		this.Object.exequip.Text = ''
	end if
	
	//미발주,미입고,최근발주업체,전화번호
	SELECT PBINV.F_UNPQTY(XPLANT, DIV, ITNO, CLS),
			PBINV.F_UNINQTY4(XPLANT, DIV, ITNO, CLS),
			PBINV.F_VSRNM3(XPLANT, DIV, ITNO),
			PBINV.F_VSRTEL1(XPLANT, DIV, ITNO)
	INTO :ls_unOrder, :ls_unStock, :ls_recent, :ls_tel
	FROM PBINV.INV101
	WHERE COMLTD = '01' AND XPLANT = :gs_kmarea AND DIV = :gs_kmdivision
			AND ITNO = :ls_part_code AND CLS in ('23', '43')
	USING sqlca ;
	
	if sqlca.sqlcode = 0 then
		this.Object.unorder.Text = ls_unOrder
		this.Object.unstock.Text = ls_unStock
		this.Object.recentbusiness.Text = ls_recent
		this.Object.telnumber.Text = ls_tel
	else
		uo_status.st_message.text = "품번 상세정보 조회 실패!!"
	end if
		
else
	this.SetItem(this.getrow(), 'part_code', '')
	this.SetItem(this.getrow(), 'part_name', '')
	this.SetItem(this.getrow(), 'part_spec', '')
	this.SetItem(this.getrow(), 'part_unit', '')
	this.SetItem(this.getrow(), 'normal_qty', 0)
	this.SetItem(this.getrow(), 'repair_qty', 0)
	this.SetItem(this.getrow(), 'etc_qty', 0)
	this.SetItem(this.getrow(), 'part_cost', 0)
	this.SetItem(this.getrow(), 'scram_qty', 0)
	this.SetItem(this.getrow(), 'part_location', '')
	this.SetItem(this.getrow(), 'part_maxq', 0)
	this.SetItem(this.getrow(), 'part_minq', 0)	
	this.Object.exequip.Text = ''
	this.Object.unorder.Text = ''
	this.Object.unstock.Text = ''
	this.Object.recentbusiness.Text = ''
	this.Object.telnumber.Text = ''
end if


end event

event ue_equip_set();string ls_equip, ls_cc_code

this.AcceptText()
ls_equip = this.GetItemString(this.getrow(), "equip_code")

SELECT equip_master.cc_code  
	INTO :ls_cc_code
	FROM equip_master  
	WHERE equip_master.equip_code = :ls_equip 
			and area_code =:gs_kmarea 
			and factory_code = :gs_kmdivision 
	using sqlcmms;

this.setitem(this.getrow(),'dept_code',ls_cc_code)
end event

event doubleclicked;str_parm lstr
long ll_upper_bound, i, ll_insert, ll_row
string ls_data[], ls_msg
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
//	case 'dept_code'
//		IF f_code_search('d_lookup_cc', '', ls_data[]) THEN
//			This.SetItem(row, 'dept_code', ls_data[1])
//		END IF
	case 'part_used'
		IF f_code_search('d_lookup_used', '', ls_data[]) THEN
			This.SetItem(row, 'part_used', ls_data[1])
			
			if trim(ls_data[1]) = '05' or trim(ls_data[1]) = '07' then
				this.GetChild('part_used', ldwc)
				ll_row = ldwc.find("used_code = '" + trim(ls_data[1]) + "'", 1, ldwc.RowCount())
				ls_msg = '불출코드[' + trim(ls_data[1]) + '] 불출용도명['+ldwc.getitemstring(ll_row, 'used_name') + &
							']이 선택되었읍니다.'					
				MessageBox ('확인', ls_msg)
			end if
			
		END IF
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
	
End Choose
end event

event itemchanged;if row <= 0 then return

string ls_colname, ls_serial
string ls_data, ls_msg
datawindowchild ldwc
long ll_row, ll_cnt
string ls_part_name, ls_exequip_code
string ls_part_code, ls_part_spec, ls_part_unit, ls_location
string ls_unOrder, ls_unStock, ls_recent, ls_tel
long ls_normal_qty,ls_repair_qty, ls_etc_qty, ls_part_cost,ls_scram_qty
long ll_maxq, ll_minq
ls_colname = dwo.name
ls_data = This.getitemstring(row,'part_used')

if ls_colname = 'part_tag' then

	SELECT serial.serlal_no  
    INTO :ls_serial
    FROM serial  
   WHERE serial.serial_div = 'out'   
	using sqlcmms;
	
	string ls_end_date, ls_endday

	ls_end_date=f_date_end(string(g_s_date,"@@@@-@@-@@"))
	ls_endday = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date
	
	if string(g_s_date,"@@@@-@@-@@") = ls_endday and mid(string(f_cmms_sysdate()),1,16) > ls_endday + ' 19:50'  then
		dw_1.setitem(dw_1.getrow(),'part_tag',data+right(string(relativedate(date(string(g_s_date,"@@@@-@@-@@")),1),"yyyymm"),3)+right(ls_serial,5))
	else
		dw_1.setitem(dw_1.getrow(),'part_tag',data+right(string(dw_1.getitemdatetime(dw_1.getrow(),'out_date'),"yyyymm"),3)+right(ls_serial,5))
	end if
	
	//dw_1.setitem(dw_1.getrow(),'part_tag',data+right(mid(g_s_date,1,6),3)+right(ls_serial,5))
end if

if ls_colname = 'part_code' then

	TriggerEvent('ue_part_set')
	
end if

if ls_colname = 'equip_code' then

	TriggerEvent('ue_equip_set')
end if

if ls_colname = 'part_used' then
	ls_data = This.getitemstring(row,'dept_code')
	if trim(data) = '04' or trim(data) = '07' then
		this.object.buybackflag.protect = 0
		if mid(ls_data,1,1) <> 'D' then
			This.setitem(row,'dept_code',' ')
		end if
	else
		this.setitem(row,"buybackflag",'N')
		this.object.buybackflag.protect = 1
	end if
	
	if trim(data) = '05' or trim(data) = '07' then
		this.GetChild('part_used', ldwc)
		ll_row = ldwc.find("used_code = '" + trim(data) + "'", 1, ldwc.RowCount())
		ls_msg = '불출코드[' + trim(data) + '] 불출용도명['+ldwc.getitemstring(ll_row, 'used_name') + &
					']이 선택되었읍니다.'					
		MessageBox ('확인', ls_msg)
	end if
end if

if ls_colname = 'dept_code' then
	if ls_data = '04' or ls_data = '07' then
		select count(*) into :ll_cnt
		from comp_master
		where comp_code = :data
		using sqlcmms;
		
		if ll_cnt < 1 then
			This.setitem(row,'dept_code','')
		end if
	else
		if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then
			select count(*) into :ll_cnt
			from cc_master
			where cc_code = :data
			using sqlcmms;
		else
			select count(*) into :ll_cnt
			from cc_inv
			where cc_code = :data
					AND AREA_CODE = :gs_kmArea 
					AND FACTORY_CODE = :gs_kmDivision
			using sqlcmms;			
		end if
		
		if ll_cnt < 1 then
			This.setitem(row,'dept_code','')
		end if
	end if
end if

return 0
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
		this.SetItem(row, 'out_date', date(ls_return_dt))
		
	case 'b_2'
		if isnull(dw_1.getitemstring(row,'part_used')) or dw_1.getitemstring(row,'part_used')='' then
			messagebox("알림",'용도를 입력하지 않으면 부서(업체)를 입력할 수 없습니다.')
			dw_1.setcolumn('part_used')
		else
			//외주사급
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
//				WHERE serial.serial_div = 'out'   ;
//				
//				string ls_end_date, ls_endday
//
//				ls_end_date=f_date_end(string(g_s_date,"@@@@-@@-@@"))
//				ls_endday = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date
//
//				if string(g_s_date,"@@@@-@@-@@") = ls_endday and mid(string(f_cmms_sysdate())),1,16) > ls_endday + ' 19:50'  then
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

type cb_1 from commandbutton within w_pisf031
integer x = 9
integer y = 8
integer width = 521
integer height = 96
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "불     출"
end type

event clicked;datawindowchild ld_aa
string wo_code, part_code, ls_as, ls_serial, ls_serial1,ls_serial2, ls_part_code
string ls_message
long qty, ll_check, i, qty_1, ln_CurRow, ln_RtnCode
string ls_end_date, ls_endday
str_ipis_server lstr_As400[]
string ls_areadivision[1]

ls_end_date = f_date_end(string(g_s_date,"@@@@-@@-@@"))
ls_endday = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date

dw_1.accepttext()

if dw_1.getitemstring(dw_1.getrow(),'invy_state') ='' &
		or isnull(dw_1.getitemstring(dw_1.getrow(),'invy_state')) &
		or dw_1.getitemstring(dw_1.getrow(),'part_code') ='' &
		or isnull(dw_1.getitemstring(dw_1.getrow(),'part_code')) &
		or dw_1.getitemstring(dw_1.getrow(),'dept_code') ='' &
		or isnull(dw_1.getitemstring(dw_1.getrow(),'dept_code'))  then
	messagebox("알림",'품번, 부서코드, 불출전표번호, 재고상태는 반드시 입력하십시오.')
	return 0
end if

if dw_1.getitemstring(dw_1.getrow(),'part_used') = '' &
		or isnull(dw_1.getitemstring(dw_1.getrow(),'part_used')) then
	messagebox("알림",'용도를 선택해 주십시요')
	return 0
end if

dw_1.accepttext()
ls_part_code= dw_1.getitemstring(dw_1.getrow(),'part_code')

If isnull(ls_part_code) or ls_part_code = '' then 
	messagebox("알림",'품번을 입력하십시요')
	Return 0
end if

ll_check = f_dddw_getrow(dw_1, dw_1.getrow(), 'part_code', ls_part_code)
if ll_check = 0 then
	messagebox("알림",'해당공장의 품번이 아닙니다.')
	return 0
end if

if upper(ls_part_code) = ls_part_code then
else
	messagebox("알림",'품번은 대문자로 입력하십시오.')
	return 0
end if
//if dw_1.getitemstring(dw_1.getrow(),'invy_state') ='U'THEN messagebox('','1')

//연구소는 자재 재고관리를 하지 않는다
if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then 
	if isnull(dw_1.getitemnumber(dw_1.getrow(),'normal_qty')) then 
		messagebox("알림",'재고량이 존재하지 않습니다.')
		return 0
	end if 
	
	if dw_1.getitemstring(dw_1.getrow(),'invy_state') ='U' &
			and ( dw_1.getitemnumber(dw_1.getrow(),'out_qty') <=0 &
			or dw_1.getitemnumber(dw_1.getrow(),'normal_qty') &
			< dw_1.getitemnumber(dw_1.getrow(),'out_qty')) then
		messagebox("알림",'불출수량이 0이하거나 사용가능한 개수보다 크기때문에 불출하실 수 없습니다.')
		RETURN 0
	end if
	
	if dw_1.getitemstring(dw_1.getrow(),'invy_state') ='R' &
			and ( dw_1.getitemnumber(dw_1.getrow(),'out_qty') <=0 &
			or dw_1.getitemnumber(dw_1.getrow(),'repair_qty') &
			< dw_1.getitemnumber(dw_1.getrow(),'out_qty')) then
		messagebox("알림",'불출수량이 0이하거나 요수리 개수보다 크기때문에 불출하실 수 없습니다.')	
		RETURN 0
	end if
	
	if dw_1.getitemstring(dw_1.getrow(),'invy_state') ='S' &
			and ( dw_1.getitemnumber(dw_1.getrow(),'out_qty') <=0 &
			or dw_1.getitemnumber(dw_1.getrow(),'scram_qty') &
			< dw_1.getitemnumber(dw_1.getrow(),'out_qty')) then
		messagebox("알림",'불출수량이 0이하거나 폐품 개수보다 크기때문에 불출하실 수 없습니다.')			
		RETURN 0	
	end if
	
	if dw_1.getitemstring(dw_1.getrow(),'invy_state') ='X' &
			and ( dw_1.getitemnumber(dw_1.getrow(),'out_qty') <=0 &
			or dw_1.getitemnumber(dw_1.getrow(),'etc_qty') &
			< dw_1.getitemnumber(dw_1.getrow(),'out_qty')) then
		messagebox("알림",'불출수량이 0이하거나 부외 개수보다 크기때문에 불출하실 수 없습니다.')
		RETURN 0
	end if
end if

if string(dw_1.getitemdatetime(dw_1.getrow(),'out_date'),'yyyy-mm-dd') &
		> string(g_s_date,"@@@@-@@-@@")  then
	messagebox("알림",'불출일자가 오늘일자보다 큽니다. 다시입력하세요..')
	return 0
end if
if string(dw_1.getitemdatetime(dw_1.getrow(),'out_date'),'yyyy-mm') &
		<> string(mid(g_s_date,1,6),"@@@@-@@")  then
	messagebox("알림",'불출일자가 범위를 넘었습니다. 다시입력하세요..')
	return 0
end if

if string(g_s_date,"@@@@-@@-@@") = ls_endday &
		and mid(string(f_cmms_sysdate()),1,16) > ls_endday + ' 19:50'  then
	dw_1.setitem(dw_1.getrow(),'out_date',relativedate(date(string(g_s_date,"@@@@-@@-@@")),1))
end if	

string ls_equip_code, ls_equip,  ls_cc_code, ls_cc
	
ls_equip = trim(dw_1.getitemstring(dw_1.getrow(),'equip_code'))
ls_cc = dw_1.getitemstring(dw_1.getrow(),'dept_code')
	
SELECT equip_master.equip_code  
	INTO :ls_equip_code
	FROM equip_master  
	WHERE equip_master.equip_code = :ls_equip and area_code =:gs_kmarea and 
			factory_code = :gs_kmdivision 
	using sqlcmms;

if (ls_equip <>'') and (Not IsNull(ls_equip)) &
		and (ls_equip_code = '' or isnull(ls_equip_code)) then
	messagebox("알림",'장비번호가 존재하지 않습니다.')
	return 0
end if

if gs_kmArea = 'D' And gs_kmDivision = 'R' then 
	SELECT cc_master.cc_code
	  INTO :ls_cc_code
	  FROM cc_master
	 WHERE cc_master.cc_code = :ls_cc 
	 using sqlcmms;
else
	SELECT cc_inv.cc_code  
	  INTO :ls_cc_code
	  FROM cc_inv  
	 WHERE cc_inv.cc_code = :ls_cc 
	 			AND AREA_CODE = :gs_kmArea 
				AND FACTORY_CODE = :gs_kmDivision
	 using sqlcmms;
end if

if  dw_1.getitemstring(dw_1.getrow(),'part_used')='04' &
		or dw_1.getitemstring(dw_1.getrow(),'part_used')='07' then
	if mid(ls_cc,1,1) <> 'D' then
		messagebox("알림","부서에 업체코드가 들어가야 합니다.")
		return 0
	end if
	
	SELECT comp_master.comp_code  
		INTO :ls_cc_code
		FROM comp_master  
		WHERE comp_master.comp_code = :ls_cc and comp_master.comp_div_code1 ='외주업체' 
		using sqlcmms;
	if (ls_cc_code ='' or isnull(ls_cc_code)) then 
		messagebox("알림",'업체가 존재하지 않습니다.')
		return 0
	end if
//elseif  dw_1.getitemstring(dw_1.getrow(),'part_used')='06' then
//	SELECT cc_master.cc_code  
//		INTO :ls_cc_code
//		FROM cc_master  
//		WHERE cc_master.cc_code = :ls_cc 
//		using sqlcmms;
//	if (ls_cc_code ='' or isnull(ls_cc_code)) then 
//		messagebox("알림",'부서가 존재하지 않습니다.')
//		return 0
//	end if
else
	if (ls_cc_code ='' or isnull(ls_cc_code)) then 
		messagebox("알림",'부서가 존재하지 않습니다.')
		return 0
	end if
end if

ll_check= messagebox("알림",'불출하시겠습니까?', Exclamation!, OKCancel!, 2)

sqlcmms.AutoCommit = False
SetPointer(HourGlass!)

if ll_check = 1 then
	string ls_colname //ls_serial
	string ls_data1
	
	ls_data1 =dw_1.getitemstring(dw_1.getrow(),'dept_code')
			
	if isnull(ls_data1) or ls_data1='' then
		messagebox("알림",'부서(업체)코드를 입력하십시오!!')
		return 0
	end if
			
	SELECT serial.serlal_no  
		INTO :ls_serial
		FROM serial  
		WHERE serial.area_code = :gs_kmarea and
			serial.factory_code = :gs_kmdivision and
			serial.serial_div = 'out'   
		using sqlcmms;
				
	string ls_end_date1, ls_endday1

	ls_end_date1=f_date_end(string(g_s_date,"@@@@-@@-@@"))
	ls_endday1 = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date1

	if string(g_s_date,"@@@@-@@-@@") = ls_endday1 &
			and string(f_cmms_sysdate(),'yyyy-mm-dd hh:mm') > ls_endday1 + ' 19:50'  then
		dw_1.setitem(dw_1.getrow(),'part_tag', &
						ls_data1+right(string(relativedate(date(string(g_s_date,"@@@@-@@-@@")),1),"yyyymm"),3) &
			+right(ls_serial,5))
	else
		dw_1.setitem(dw_1.getrow(), 'part_tag', &
						ls_data1+right(string(dw_1.getitemdatetime(dw_1.getrow(),'out_date'),"yyyymm"),3) &
						+right(ls_serial,5))
	end if

	ls_serial1=string(long(ls_serial)+1)
	for i= 1 to 8 - len(ls_serial1)
		ls_serial2 = ls_serial2+'0'
	next
	ls_serial1 =ls_serial2+ls_serial1

	UPDATE serial  
   	SET serlal_no = :ls_serial1  
   	WHERE serial.area_code = :gs_kmarea and
			serial.factory_code = :gs_kmdivision and
			serial.serial_div = 'out'   
		using sqlcmms;

	if sqlcmms.sqlcode <> 0 then
		ls_message = "SERIAL_NO UPDATE중 오류가 발생하였습니다."
		Goto RollBack_	
	end if
	
//	dw_1.setitem(dw_1.getrow(),1,uo_area.is_uo_areacode)
//	dw_1.setitem(dw_1.getrow(),2,uo_division.is_uo_divisioncode)
	dw_1.setitem(dw_1.getrow(),1,gs_kmarea)
	dw_1.setitem(dw_1.getrow(),2,gs_kmdivision)
	dw_1.setitem(dw_1.getrow(),'part_out_out_serial',ls_serial)
	dw_1.setitem(dw_1.getrow(),'part_out_up_div', 'Y')
	dw_1.AcceptText()
	
	if dw_1.update() = -1 then
		ls_message = '데이타윈도우 UPDATE중 오류가 발생했읍니다.' 
		Goto RollBack_	
	end if

	dw_1.rowscopy(dw_1.getrow(),dw_1.getrow(),Primary!,dw_3,1,Primary!)
	
	wo_code = trim(dw_1.getitemstring(dw_1.getrow(),'wo_code'))
	part_code = dw_1.getitemstring(dw_1.getrow(),'part_code')
	qty = dw_1.getitemnumber(dw_1.getrow(),'out_qty')
	
	if is_check_wo ='wo' then
   
		SELECT wo_part.wo_code  
			INTO :ls_as 
			FROM wo_part
			where  wo_code=:wo_code and part_code=:part_code and 
					 area_code = :gs_kmarea and factory_code = :gs_kmdivision and 
					 qty is not null
			using sqlcmms; 

		if ls_as='' or isnull(ls_as) then
			INSERT INTO wo_part  
				( wo_code,   
				  part_code,   
				  qty,
				  area_code,
				  factory_code)  
			VALUES ( :wo_code,   
				  :part_code,   
				  :qty,
				  :gs_kmarea,
				  :gs_kmdivision)  
			using sqlcmms;
			
			if sqlcmms.sqlcode <> 0 then
				ls_message = "WO_PART INSERT중 오류가 발생하였습니다."
				Goto RollBack_	
			end if
			
		else
	  
			UPDATE wo_part  
			SET qty = isnull(qty,0) + :qty
			where  wo_code=:wo_code and part_code=:part_code and 
					area_code = :gs_kmarea and factory_code = :gs_kmdivision
			using sqlcmms; 
			
			if sqlcmms.sqlcode <> 0 then
				ls_message = "WO_PART UPDATE중 오류가 발생하였습니다."
				Goto RollBack_	
			end if
		end if		
	elseif is_check_wo ='task' then
		SELECT task_part.task_code  
			INTO :ls_as 
			FROM task_part
			where  task_code=:wo_code and part_code=:part_code and 
					 qty is not null
			using sqlcmms; 

		if ls_as='' or isnull(ls_as) then
			INSERT INTO task_part  
				( task_code,   
				  part_code,   
				  qty,
				  area_code,
				  factory_code)  
			VALUES ( :wo_code,   
				  :part_code,   
				  :qty,
				  :gs_kmarea,
				  :gs_kmdivision )  
			using sqlcmms;
			
			if sqlcmms.sqlcode <> 0 then
				ls_message = "TASK_PART INSERT중 오류가 발생하였습니다."
				Goto RollBack_	
			end if
			
		else
		  
			UPDATE task_part  
			SET qty = isnull(qty,0) + :qty
			where task_code=:wo_code and part_code=:part_code and
				area_code = :gs_kmarea and factory_code = :gs_kmdivision
			using sqlcmms;
	
			if sqlcmms.sqlcode <> 0 then
				ls_message = "TASK_PART UPDATE중 오류가 발생하였습니다."
				Goto RollBack_	
			end if
		end if		
	else
		if wo_code <>'' and isnull(wo_code) then
			SELECT wo_part.wo_code  
			 INTO :ls_as 
			 FROM wo_part
			 where  wo_code=:wo_code and part_code=:part_code and 
					  area_code = :gs_kmarea and factory_code = :gs_kmdivision and 
					  qty is not null
			using sqlcmms; 
	
			if ls_as='' or isnull(ls_as) then
				INSERT INTO wo_part  
					( wo_code,   
					  part_code,   
					  qty,
					  area_code,
					  factory_code)  
				VALUES ( :wo_code,   
					  :part_code,   
					  :qty,
					  :gs_kmarea,
					  :gs_kmdivision)  
				using sqlcmms;
		
				if sqlcmms.sqlcode <> 0 then
					ls_message = "WO_PART INSERT중 오류가 발생하였습니다."
					Goto RollBack_	
				end if
			else
		  
				UPDATE wo_part  
				SET qty = isnull(qty,0) + :qty
				where  wo_code=:wo_code and part_code=:part_code and 
						area_code = :gs_kmarea and factory_code = :gs_kmdivision
				using sqlcmms; 
	
				if sqlcmms.sqlcode <> 0 then
					ls_message = "WO_PART UPDATE중 오류가 발생하였습니다."
					Goto RollBack_	
				end if
			end if
		end if
	end if

	//연구소는 자재 재고관리를 하지 않는다
	if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then 
		if dw_1.getitemstring( dw_1.getrow(),'invy_state')='U' then	
		  UPDATE part_master  
			  SET normal_qty = ISNULL(normal_qty, 0) - :qty
			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
					part_master.part_code = :part_code    
			using sqlcmms;		
		elseif dw_1.getitemstring( dw_1.getrow(),'invy_state')='R'then
		  UPDATE part_master  
			  SET repair_qty = ISNULL(repair_qty, 0) - :qty
			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
					part_master.part_code = :part_code    
			using sqlcmms;
		elseif dw_1.getitemstring( dw_1.getrow(),'invy_state')='S'then
		  UPDATE part_master  
			  SET scram_qty = ISNULL(scram_qty, 0) - :qty 
			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
					part_master.part_code = :part_code    
			using sqlcmms;	
		elseif dw_1.getitemstring( dw_1.getrow(),'invy_state')='X'then
		  UPDATE part_master  
			  SET etc_qty = ISNULL(etc_qty, 0) - :qty
			WHERE AREA_CODE=:gs_kmarea AND FACTORY_CODE=:gs_kmdivision AND 
					part_master.part_code = :part_code    
			using sqlcmms;	
		end if
		
		if sqlcmms.sqlcode <> 0 Or sqlcmms.sqlnrows <> 1 then
			ls_message = "PART_MASTER UPDATE중 오류가 발생하였습니다."
			Goto RollBack_	
		end if

		//AS400 INV401 업데이트
		dw_as400.Reset()
		ln_CurRow = dw_as400.InsertRow(0)
				
		// 매개변수 dw에 데이터 넣기
		dw_as400.setitem(ln_CurRow, "AREACODE", dw_1.GetItemString(dw_1.GetRow(), "part_out_area_code"))
		dw_as400.setitem(ln_CurRow, "DIVISIONCODE", dw_1.GetItemString(dw_1.GetRow(), "part_out_factory_code"))
		dw_as400.setitem(ln_CurRow, "releasedate", String(dw_1.GetItemDateTime(dw_1.GetRow(), "out_date"), "yyyymmdd"))
		dw_as400.setitem(ln_CurRow, "serialno", dw_1.GetItemString(dw_1.GetRow(), "part_out_out_serial"))
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
		dw_as400.setitem(ln_CurRow, "releaseqty", dw_1.GetItemNumber(dw_1.GetRow(), "out_qty"))
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
		ln_RtnCode = f_up_ipis_mis_tmcpartrelease(ls_message, dw_as400, lstr_As400)
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
	uo_status.st_message.text = "정상적으로 불출처리되었습니다."
	
	dw_1.getchild('part_code', ld_aa)
	ld_aa.settransobject(sqlcmms)
	ld_aa.retrieve(gs_kmarea, gs_kmdivision)

	long asdf
	datetime ldt
	dw_1.reset()
	asdf=dw_1.insertrow(0)
	ldt = f_cmms_sysdate()
	dw_1.SetItem(asdf, 'out_date', ldt)
	dw_1.setrow(asdf)
	dw_1.scrolltorow(asdf)
	dw_1.setcolumn('part_code')
	dw_1.setfocus()
end if

Return 1

//	실패
RollBack_:
RollBack Using sqlcmms;
sqlcmms.AutoCommit = True

//AS400 ROLLBACK
if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then
	f_ipis_server_rollback_transaction(lstr_As400)
end if

SetPointer(Arrow!)
uo_status.st_message.text = ls_message
MessageBox("불출오류", ls_message, StopSign!)

return 0
end event

type uo_area from u_cmms_select_area within w_pisf031
event destroy ( )
integer x = 686
integer y = 24
integer taborder = 10
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

type uo_division from u_cmms_select_division within w_pisf031
event destroy ( )
integer x = 1262
integer y = 24
integer taborder = 20
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type dw_as400 from datawindow within w_pisf031
boolean visible = false
integer x = 3145
integer y = 12
integer width = 686
integer height = 400
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_up_ipis_mis_tmcpartrelease"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_tlm from commandbutton within w_pisf031
integer x = 4123
integer y = 60
integer width = 398
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "이체관리"
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//입고만처리
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110
   WHERE WIN_ID = 'w_tlm601u' AND WIN_RPT = 'M'
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

type gb_2 from groupbox within w_pisf031
integer x = 4087
integer y = 4
integer width = 457
integer height = 156
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217730
long backcolor = 12632256
string text = "화면전환"
end type

