$PBExportHeader$w_pisf021.srw
$PBExportComments$작명이력
forward
global type w_pisf021 from w_cmms_sheet01
end type
type dw_except from datawindow within w_pisf021
end type
type st_2 from statictext within w_pisf021
end type
type st_1 from statictext within w_pisf021
end type
type em_2 from editmask within w_pisf021
end type
type cb_3 from commandbutton within w_pisf021
end type
type cb_2 from commandbutton within w_pisf021
end type
type cb_1 from commandbutton within w_pisf021
end type
type dw_time from datawindow within w_pisf021
end type
type tab_1 from tab within w_pisf021
end type
type tp_1 from userobject within tab_1
end type
type st_5 from statictext within tp_1
end type
type st_4 from statictext within tp_1
end type
type dw_1_1 from uo_datawindow within tp_1
end type
type dw_1 from uo_datawindow within tp_1
end type
type dw_property from datawindow within tp_1
end type
type tp_1 from userobject within tab_1
st_5 st_5
st_4 st_4
dw_1_1 dw_1_1
dw_1 dw_1
dw_property dw_property
end type
type tp_2 from userobject within tab_1
end type
type dw_2_1 from datawindow within tp_2
end type
type dw_2 from uo_datawindow within tp_2
end type
type tp_2 from userobject within tab_1
dw_2_1 dw_2_1
dw_2 dw_2
end type
type tp_3 from userobject within tab_1
end type
type dw_3 from uo_datawindow within tp_3
end type
type tp_3 from userobject within tab_1
dw_3 dw_3
end type
type tab_1 from tab within w_pisf021
tp_1 tp_1
tp_2 tp_2
tp_3 tp_3
end type
type dw_list from uo_datawindow within w_pisf021
end type
type ddlb_filter from dropdownlistbox within w_pisf021
end type
type em_1 from editmask within w_pisf021
end type
type dw_group from datawindow within w_pisf021
end type
type uo_area from u_cmms_select_area within w_pisf021
end type
type uo_division from u_cmms_select_division within w_pisf021
end type
type gb_2 from groupbox within w_pisf021
end type
type gb_1 from groupbox within w_pisf021
end type
end forward

global type w_pisf021 from w_cmms_sheet01
integer width = 4617
integer height = 2784
string title = "작명이력"
dw_except dw_except
st_2 st_2
st_1 st_1
em_2 em_2
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_time dw_time
tab_1 tab_1
dw_list dw_list
ddlb_filter ddlb_filter
em_1 em_1
dw_group dw_group
uo_area uo_area
uo_division uo_division
gb_2 gb_2
gb_1 gb_1
end type
global w_pisf021 w_pisf021

type variables
long il_row
string is_equip_code, is_wo_code
string is_area, is_factory

datawindow id_dw_current

datawindow id_dw_property 
datawindow id_dw_1 
datawindow id_dw_1_1
datawindow id_dw_2
datawindow id_dw_2_1
datawindow id_dw_3 
string is_original_sql_list 
string is_original_sql_property 
string is_original_sql_1 
string is_original_sql_1_1 
string is_original_sql_2 
string is_original_sql_2_1 
string is_original_sql_3 
long check_data

// FTP 관련 
boolean ib_upOpened = FALSE	//업로드시 파일폴더열면 이전의 파일폴더 open
Long il_FtpScrollPos

u_cmms_ftp u_ftp

boolean ib_opened = false
end variables

on w_pisf021.create
int iCurrent
call super::create
this.dw_except=create dw_except
this.st_2=create st_2
this.st_1=create st_1
this.em_2=create em_2
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_time=create dw_time
this.tab_1=create tab_1
this.dw_list=create dw_list
this.ddlb_filter=create ddlb_filter
this.em_1=create em_1
this.dw_group=create dw_group
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_except
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.dw_time
this.Control[iCurrent+9]=this.tab_1
this.Control[iCurrent+10]=this.dw_list
this.Control[iCurrent+11]=this.ddlb_filter
this.Control[iCurrent+12]=this.em_1
this.Control[iCurrent+13]=this.dw_group
this.Control[iCurrent+14]=this.uo_area
this.Control[iCurrent+15]=this.uo_division
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_1
end on

on w_pisf021.destroy
call super::destroy
destroy(this.dw_except)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_2)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_time)
destroy(this.tab_1)
destroy(this.dw_list)
destroy(this.ddlb_filter)
destroy(this.em_1)
destroy(this.dw_group)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event resize;call super::resize;dw_list.width = newwidth - ddlb_filter.width

tab_1.width = newwidth
//tab_1.height = newheight - 1090

tab_1.tp_1.dw_1.height = tab_1.height -id_dw_property.height - 315
tab_1.tp_1.dw_1_1.width = tab_1.width - tab_1.tp_1.dw_1.width - 40
tab_1.tp_1.dw_1_1.height = tab_1.height -id_dw_property.height - 315

tab_1.tp_2.dw_2.height = tab_1.height - 115
tab_1.tp_2.dw_2_1.width = tab_1.width - 40 -tab_1.tp_2.dw_2.width
tab_1.tp_2.dw_2_1.height = tab_1.height - 115

tab_1.tp_3.dw_3.height = tab_1.height - 115
tab_1.tp_3.dw_3.width = tab_1.width - 40 
end event

event open;call super::open;ib_saved = false
ib_data_changed = false
long i, ll_row

for i = 1 to 3
	ib_refreshed_tab[i] = false
next

ii_old_tab = 1
ii_current_tab = 1

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_1.dw_1.settransobject(sqlcmms)   
tab_1.tp_1.dw_1_1.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms)   

id_dw_property = tab_1.tp_1.dw_property 
id_dw_1 = tab_1.tp_1.dw_1
id_dw_1_1 = tab_1.tp_1.dw_1_1
id_dw_2 = tab_1.tp_2.dw_2
id_dw_2_1 = tab_1.tp_2.dw_2_1
id_dw_3 = tab_1.tp_3.dw_3

is_original_sql_list = dw_list.object.datawindow.table.select
is_original_sql_property = id_dw_property.object.datawindow.table.select
is_original_sql_1 = id_dw_1.object.datawindow.table.select
is_original_sql_1_1 = id_dw_1_1.object.datawindow.table.select
is_original_sql_2 = id_dw_2.object.datawindow.table.select
is_original_sql_2_1 = id_dw_2_1.object.datawindow.table.select
is_original_sql_3 = id_dw_3.object.datawindow.table.select

id_dw_current = id_dw_property

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  true,  true,  true,  false, false, false, false)
end event

event ue_delete;call super::ue_delete;long ll_row

if not IsNull(id_dw_current) then
	if id_dw_current.classname() = 'dw_property' then
		return 0
	end if
	ll_row = id_dw_current.GetRow()
	if ll_row > 0 then	
		id_dw_current.DeleteRow(ll_row)
	end if
end if
ib_data_changed = true



end event

event ue_insert;call super::ue_insert;long ll_row
datawindow ld_dw

choose case tab_1.selectedTab
	case 1
		if dw_list.getrow() < 1 then return
		if isnull(id_dw_current) then return
		if check_data = 1 then
			ld_dw = id_dw_property
			ll_Row = ld_dw.InsertRow(0)
			ld_dw.SetRow(ll_Row)
			ld_dw.ScrollToRow(ll_Row)
			ld_dw.SetFocus()
			id_dw_property.setitem(id_dw_property.getrow(),26,gs_kmarea)
			id_dw_property.setitem(id_dw_property.getrow(),27,gs_kmdivision)
		else

			ld_dw = id_dw_current
			if isnull(ld_dw) then return
		//if id_dw_current = id_dw_1 then
			//if id_dw_1.rowcount() > 4 then return
		//end if 
		//if id_dw_current = id_dw_1_1 then
		//	if id_dw_1_1.rowcount() > 2 then return
		//end if 
			ll_Row = ld_dw.InsertRow(0)
			ld_dw.SetRow(ll_Row)
			ld_dw.ScrollToRow(ll_Row)
			ld_dw.SetFocus()
		
			id_dw_1.setitem(id_dw_1.getrow(),'wo_part_area_code',gs_kmarea)
			id_dw_1_1.setitem(id_dw_1_1.getrow(),'wo_emp_area_code',gs_kmarea)	
			id_dw_1.setitem(id_dw_1.getrow(),'wo_part_factory_code',gs_kmdivision)
			id_dw_1_1.setitem(id_dw_1_1.getrow(),'wo_emp_factory_code',gs_kmdivision)	
			id_dw_1.setitem(id_dw_1.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
			id_dw_1_1.setitem(id_dw_1_1.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
		
		end if 
	case 3
		if isnull(id_dw_current) then return
		if dw_list.getitemstring(dw_list.getrow(),11) = '' or isnull(dw_list.getitemstring(dw_list.getrow(),11))then return
		ld_dw = id_dw_current
		if isnull(ld_dw) then return
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),11))
	case 2
		if isnull(id_dw_current) then return
		if dw_list.getitemstring(dw_list.getrow(),11) = '' or isnull(dw_list.getitemstring(dw_list.getrow(),11))then return
		ld_dw = tab_1.tp_2.dw_2
		if isnull(ld_dw) then return
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),11))
		tab_1.tp_2.dw_2_1.insertrow(0)
	end choose
end event

event ue_retrieve;call super::ue_retrieve;int li_current_tab_page
string ls_where, ls_and, ls_code, ls_code2
long ll_row
string ls_factory, ls_area

ls_area=gs_kmarea
ls_factory=gs_kmdivision

li_current_tab_page = tab_1.SelectedTab

dw_group.AcceptText()
ll_row = dw_group.GetRow()
if (ll_row > 0) then
	
	ls_code = dw_group.GetItemString(ll_row, 'code')
//	if dw_group.dataobject = 'd_group_cause' then
	if dw_group.dataobject = 'd_group_cause_sp' then
		ls_code2 = dw_group.GetItemString(ll_row, 'code1')
	end if
end if

CHOOSE CASE ddlb_filter.text
	CASE '전체목록',''
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where wo_hist.area_code = ' +"'"+ls_area+ "' and wo_hist.factory_code='"+ &
						ls_factory+	"' and convert(varchar(10),wo_hist.wo_float_date,120) between '" &
						+em_1.text+"' and '"+em_2.text +	"' ORDER BY wo_hist.wo_code"
	case '작명유형별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where wo_hist.area_code = ' +"'"+ls_area+ "' and wo_hist.factory_code='"+ &
						ls_factory+ "' and wo_hist.wo_div_code='"+ls_code+ &
						"' and convert(varchar(10),wo_hist.wo_float_date,120) between '"+ em_1.text+ &
						"' and '"+em_2.text + "' ORDER BY wo_hist.wo_code"
	case '대상장비별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where wo_hist.area_code = ' +"'"+ls_area+ "' and wo_hist.factory_code='" &
						+ls_factory+ "' and wo_hist.equip_code='"+ls_code+ &
						"' and convert(varchar(10),wo_float_date,120) between '"+ em_1.text+ &
						"' and '"+em_2.text + "' ORDER BY wo_code"
	case '고장원인별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where wo_hist.area_code = ' +"'"+ls_area+ "' and wo_hist.factory_code='"+ &
					ls_factory+ "' and wo_hist.cause_code_a='"+ls_code+"' and wo_hist.cause_code_b='"+&
					ls_code2+ "' and convert(varchar(10),wo_hist.wo_float_date,120) between '"+em_1.text+ &
					"' and '"+em_2.text + &
					"' ORDER BY wo_hist.wo_code"
	case '라인별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where wo_hist.area_code = ' +"'"+ls_area+ "' and wo_hist.factory_code='"+ls_factory+ &
						"' and equip_master.line_code = '"+ls_code+ &
						"' and convert(varchar(10),wo_hist.wo_float_date,120) between '" &
						+em_1.text+ "' and '"+em_2.text +"' ORDER BY wo_hist.wo_code"
end choose

dw_list.object.datawindow.table.select = is_original_sql_list + ls_where 

dw_list.retrieve()  

dw_list.selectrow(0, false)
dw_list.SetRow(1)
dw_list.selectrow(1, true)

this.triggerevent('ue_retrieve_each_tab')

ib_refreshed_tab[li_current_tab_page] = true





end event

event ue_retrieve_each_tab;call super::ue_retrieve_each_tab;string ls_where, ls_and, ls_and1, ls_and2, ls_and3,ls_where1,ls_where2
string ls_code, ls_decript
long li_current_tab_page, ll_row
string ls_womanual
string ls_manualcode
string ls_equipcode

li_current_tab_page = tab_1.SelectedTab

if dw_list.getrow() < 1 then 
	id_dw_property.reset()
	id_dw_1.reset()
	id_dw_1_1.reset()
	id_dw_2.reset()	
	id_dw_3.reset()
	return
end if

ls_where = " where wo_code = '" +dw_list.getitemstring(dw_list.getrow(),1) +"' and area_code= '"+gs_kmarea+"' and factory_code= '"+gs_kmdivision+"'"
ls_and  = " and wo_part.wo_code='" + dw_list.getitemstring(dw_list.getrow(),1) + "' and  wo_part.area_code='"+gs_kmarea+"'  and wo_part.factory_code='"+gs_kmdivision+ "'"
ls_and1  = " and wo_emp.wo_code='" + dw_list.getitemstring(dw_list.getrow(),1) + "' and  wo_emp.area_code='"+gs_kmarea+"'  and wo_emp.factory_code='"+gs_kmdivision+ "'"


choose case li_current_tab_page
	case 1  							
		id_dw_property.object.datawindow.table.select = is_original_sql_property + ls_where
		id_dw_property.retrieve()
	
		id_dw_1.object.datawindow.table.select = is_original_sql_1 + ls_and
		id_dw_1.retrieve()
		
		id_dw_1_1.object.datawindow.table.select = is_original_sql_1_1 + ls_and1
		id_dw_1_1.retrieve()
	case 2 
		ls_where1 = ' and equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),11) + "'" &
			+ " and equip_guide.area_code='"+gs_kmarea+"' and equip_guide.factory_code='"+gs_kmdivision+"'"
		id_dw_2.object.datawindow.table.select = is_original_sql_2 + ls_where1
		id_dw_2.retrieve()
	case 3
		id_dw_3.retrieve(gs_kmarea, gs_kmdivision, dw_list.getitemstring(dw_list.getrow(),11))
//		ls_where2 = ' where equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),11) + "'"
//		id_dw_3.object.datawindow.table.select = is_original_sql_3 + ls_where2
//		id_dw_3.retrieve()	
end choose

ib_refreshed_tab[li_current_tab_page] = true

end event

event ue_save;call super::ue_save;long ll_row
datawindow ld_dw
string ls_now

choose case tab_1.selectedTab
	case 1
		
		if id_dw_property.update() = - 1 then
			return 0
		else
			if id_dw_property.getrow() > 0 then
				ls_now=id_dw_property.getitemstring(id_dw_property.getrow(),'wo_code')
			end if
		end if
		if id_dw_1.update() = - 1 then
			return 0
		end if
		if id_dw_1_1.update() = - 1 then
			return 0
		end if
		
	case 2
		
		if id_dw_2.update() = - 1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'wo_code')
			end if
		end if
		
		if id_dw_2.getrow() < 1 then return 0

		if id_dw_2.getitemstring(id_dw_2.getrow(),2) = '' or isnull(id_dw_2.getitemstring(id_dw_2.getrow(),2)) then
		else
			id_dw_2.gettext()
			tab_1.tp_2.dw_2_1.setitem(tab_1.tp_2.dw_2_1.getrow(),1,id_dw_2.getitemstring(id_dw_2.getrow(),2))
			tab_1.tp_2.dw_2_1.setitem(tab_1.tp_2.dw_2_1.getrow(),3,id_dw_2.getitemstring(id_dw_2.getrow(),3))
		end if

		if tab_1.tp_2.dw_2_1.update() = - 1 then
			return 0
		end if		

	case 3
		
		if id_dw_3.update() = - 1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'wo_code')
			end if
		end if
end choose
ib_data_changed = FALSE
this.triggerevent('ue_retrieve')
dw_list.scrolltorow(dw_list.find("wo_code='"+ls_now+"'",1,dw_list.rowcount()))
return 1
end event

event ue_postopen;call super::ue_postopen;str_parm str_get_parm
string ls_return[]
long ii, ll_find
datawindowchild ldwc

ddlb_filter.selectitem(1)
dw_group.reset()

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_1.dw_1.settransobject(sqlcmms)   
tab_1.tp_1.dw_1_1.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms) 

id_dw_property.GetChild('equip_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('equip_code_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('wo_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('wo_state_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_1.GetChild('part_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_1_1.GetChild('emp_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('wo_div_code', ldwc)
f_dddw_width(id_dw_property, 'wo_div_code', ldwc, 'wo_div_name', 10)

id_dw_property.GetChild('wo_state_code', ldwc)
f_dddw_width(id_dw_property, 'wo_state_code', ldwc, 'status_name', 10)

id_dw_property.GetChild('equip_code', ldwc)
f_dddw_width(id_dw_property, 'equip_code', ldwc, 'equip_name', 10)

id_dw_property.GetChild('comp_code', ldwc)
f_dddw_width(id_dw_property, 'comp_code', ldwc, 'comp_name', 10)

id_dw_1.GetChild('part_code', ldwc)
f_dddw_width(id_dw_1, 'part_code', ldwc, 'part_name', 10)

id_dw_1_1.GetChild('emp_code', ldwc)
f_dddw_width(id_dw_1_1, 'emp_code', ldwc, 'emp_name', 10)

str_get_parm = Message.PowerObjectParm

if Isvalid(str_get_parm) then

	For ii = 1 To UpperBound(str_get_parm.s_parm[])
		ls_return[ii] = str_get_parm.s_parm[ii]
	Next

	if UpperBound(ls_return[]) > 0 then
		is_wo_code = ls_return[3]
		em_1.text=left(ls_return[4],10)
		em_2.text=left(ls_return[4],10)
		this.triggerevent('ue_retrieve')
		
		ll_find = dw_list.find(" wo_code = '"+is_wo_code+"'" , 1, dw_list.RowCount())					
		dw_list.SetRow(ll_find)
		dw_list.ScrollToRow(ll_find)
		dw_list.SetFocus()	
	end if
else
	this.triggerevent('ue_retrieve')
end if	

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

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_1.dw_1.settransobject(sqlcmms)   
tab_1.tp_1.dw_1_1.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms) 

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  true,  true,  true,  false, false, false, false)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf021
end type

type dw_except from datawindow within w_pisf021
boolean visible = false
integer x = 2249
integer y = 424
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "d_sys_code_except_time1"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_pisf021
integer x = 23
integer y = 16
integer width = 160
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "기간:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisf021
integer x = 105
integer y = 108
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

type em_2 from editmask within w_pisf021
integer x = 192
integer y = 92
integer width = 402
integer height = 84
integer taborder = 50
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

type cb_3 from commandbutton within w_pisf021
integer x = 599
integer y = 96
integer width = 87
integer height = 76
integer taborder = 40
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

type cb_2 from commandbutton within w_pisf021
integer x = 599
integer y = 4
integer width = 87
integer height = 76
integer taborder = 30
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

type cb_1 from commandbutton within w_pisf021
integer x = 69
integer y = 972
integer width = 549
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "작업완료보고서발행"
end type

event clicked;if dw_list.getrow()<1 then return

if id_dw_property.getitemstring(id_dw_property.getrow(),'wo_code') = '' or isnull(id_dw_property.getitemstring(id_dw_property.getrow(),'wo_code')) then return

string ls_task,ls_div
datawindowchild ldwc

ls_task=id_dw_property.getitemstring(id_dw_property.getrow(),'wo_code')
OpenSheet(w_report_preview, w_frame, 0, Layered!)

w_report_preview.dw_report.dataobject = 'dr_wo_report_01'
w_report_preview.dw_report.SetTransObject(sqlcmms)

w_report_preview.dw_report.GetChild('wo_hist_wo_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)

w_report_preview.dw_report.GetChild('wo_hist_wo_state_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)

w_report_preview.dw_report.retrieve(ls_task,gs_kmarea,gs_kmdivision)

w_report_preview.TriggerEvent('ue_preview_mode')

end event

type dw_time from datawindow within w_pisf021
boolean visible = false
integer x = 1467
integer y = 704
integer width = 686
integer height = 400
integer taborder = 30
string title = "none"
string dataobject = "sp_wo_time"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tab_1 from tab within w_pisf021
integer y = 1088
integer width = 4567
integer height = 1524
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tp_1 tp_1
tp_2 tp_2
tp_3 tp_3
end type

on tab_1.create
this.tp_1=create tp_1
this.tp_2=create tp_2
this.tp_3=create tp_3
this.Control[]={this.tp_1,&
this.tp_2,&
this.tp_3}
end on

on tab_1.destroy
destroy(this.tp_1)
destroy(this.tp_2)
destroy(this.tp_3)
end on

event selectionchanged;setnull(id_dw_current)

if dw_list.getrow() < 1 then return

ii_old_tab = oldindex
ii_current_tab = newindex



if not ib_readonly then
	parent.triggerevent('ue_set_buttons')
end if

// 이미 최신 데이터를 조회중이면 다시 조회하지 않는다.
if ib_refreshed_tab[newindex] then
	return
else
	parent.triggerevent('ue_retrieve_each_tab')	
end if
end event

type tp_1 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4530
integer height = 1412
long backcolor = 12632256
string text = "등록정보"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_5 st_5
st_4 st_4
dw_1_1 dw_1_1
dw_1 dw_1
dw_property dw_property
end type

on tp_1.create
this.st_5=create st_5
this.st_4=create st_4
this.dw_1_1=create dw_1_1
this.dw_1=create dw_1
this.dw_property=create dw_property
this.Control[]={this.st_5,&
this.st_4,&
this.dw_1_1,&
this.dw_1,&
this.dw_property}
end on

on tp_1.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_1_1)
destroy(this.dw_1)
destroy(this.dw_property)
end on

type st_5 from statictext within tp_1
integer x = 2720
integer y = 936
integer width = 439
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "장비별 투입 M/H"
boolean focusrectangle = false
end type

type st_4 from statictext within tp_1
integer y = 936
integer width = 453
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
string text = "장비별 소요자재 :"
boolean focusrectangle = false
end type

type dw_1_1 from uo_datawindow within tp_1
integer x = 2715
integer y = 996
integer width = 1861
integer height = 412
integer taborder = 30
string dataobject = "d_wo_mh"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
check_data=3
end event

event doubleclicked;call super::doubleclicked;str_parm lstr
long ll_upper_bound, i, ll_insert

if lower(string(dwo.name)) = 'emp_code' then

	lstr.s_parm[1] = 'd_lookup_emp'
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
			this.SetItem(row, 'emp_code', lstr.s_array[i, 1])
			ll_insert = row
		else
			ll_insert = this.InsertRow(0)
			this.SetItem(ll_insert, 'emp_code', lstr.s_array[i, 1])
		end if
		this.Event ItemChanged(ll_insert, dwo, lstr.s_array[i, 1])
	next
end if
end event

event itemchanged;call super::itemchanged;iw_this.TriggerEvent('ue_set_data_changed')

if row <= 0 then return

string ls_colname
datawindowchild ldwc
long ll_row
string ls_emp_name
string ls_emp_code

long ls_part_invy
ls_colname = dwo.name

if ls_colname = 'emp_code' then
	this.GetChild('emp_code', ldwc)
	This.AcceptText()
	ls_emp_code = This.GetItemString(row,'emp_code')
	If isnull(ls_emp_code) or ls_emp_code = '' then Return

	ll_row = f_dddw_getrow(This,row,'emp_code',ls_emp_code)
	//ll_row = ldwc.GetRow()
	if ll_row > 0 then
		ls_emp_name = ldwc.GetItemString(ll_row, 'emp_name')

		this.SetItem(row, 'emp_name', ls_emp_name)
		this.SetItem(row, 4, id_dw_property.getitemnumber(id_dw_property.getrow(),17))
		this.SetItem(row, 5, id_dw_property.getitemnumber(id_dw_property.getrow(),18))
	end if
end if
end event

type dw_1 from uo_datawindow within tp_1
integer y = 996
integer width = 2706
integer height = 412
integer taborder = 20
string dataobject = "d_wo_part"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
check_data=2

long aaa

id_dw_current = this

if dwo.name = 'wo_part_qty' then
	if row <= 0 then return
	if this.getitemnumber(row,5) > 0 then return
	aaa=messagebox("알림",'자재를 불출하시겠습니까?',Exclamation!, OKCancel!, 2)
	if aaa=1 then
			string ls_part,ls_wo, ls_equip

			ls_part = this.GetItemString(row, 'part_code')
			ls_wo = id_dw_property.GetItemString(id_dw_property.getrow(), 'wo_code')
			ls_equip = id_dw_property.GetItemString(id_dw_property.getrow(), 'equip_code')
			
			if ls_part = '' or isnull(ls_part) then
				MessageBox("알림", '자재를 선택하고 다시한번 시도해보십시오.')
				return
			end if
		IW_THIS.TRIGGEREVENT('UE_SAVE')
		window lw_win
		str_parm lstr

		lstr.s_parm[1] = '5'
		lstr.s_parm[2] = '[설비관리]-[자재불출]'
		lstr.s_parm[3] = ls_part
		lstr.s_parm[4] = ls_wo
		lstr.s_parm[5] = ls_equip
		lstr.s_parm[6] = 'wo'
		
		OpenSheetwithparm(lw_win,lstr,'w_pisf031',iw_this,0,Layered!)
	end if
end if

end event

event doubleclicked;call super::doubleclicked;str_parm lstr
long ll_upper_bound, i, ll_insert
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

end event

event itemchanged;call super::itemchanged;iw_this.TriggerEvent('ue_set_data_changed')

if row <= 0 then return

string ls_colname
datawindowchild ldwc
long ll_row
string ls_part_name
string ls_part_code
long ll_normal_qty, ll_part_cost

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
		ll_normal_qty = ldwc.GetItemnumber(ll_row, 'normal_qty')
		ll_part_cost = ldwc.GetItemnumber(ll_row, 'part_cost')
		this.SetItem(row, 'part_name', ls_part_name)
		this.SetItem(row, 'normal_qty', ll_normal_qty)
		this.SetItem(row, 'part_cost', ll_part_cost)

	end if
end if


end event

type dw_property from datawindow within tp_1
integer width = 4571
integer height = 916
integer taborder = 30
string title = "none"
string dataobject = "d_wo2_property"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;id_dw_current = this
 check_data=1
end event

event buttonclicked;string ls_dwoname
string ls_wono
integer li_return
string ls_new_wo
string ls_return_dt
str_xy str_lxy
str_parm str_get_parm

id_dw_current = this

if row <= 0 then return

ls_dwoname = dwo.name

if ls_dwoname = 'b_1' then
	ls_wono = this.GetItemString(row, 'wo_code')
	if ls_wono <> '' and not isnull(ls_wono) then
		li_return = MessageBox("알림", '이미 작업지시번호가 설정돼 있습니다. ~r~r 현재 작업지지번호을 바꾸시겠습니까?', Question!, OKCancel!, 2)
		if li_return <> 1 then return  // ok process
	end if
	
	open(w_wo_auto)

	ls_new_wo = Message.StringParm

	if (not IsNull(ls_new_wo)) and (ls_new_wo <> '') then
		this.SetItem(row, 'wo_code', ls_new_wo)
	end if
end if

choose case ls_dwoname
	case 'b_2'
		str_lxy.lx = iw_This.PointerX()
		str_lxy.ly = iw_This.PointerY() + 350
		openwithparm(w_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return
		Else
			ls_return_dt = Message.StringParm   // powerobject
		End If	
		this.SetItem(row, 'wo_float_date', date(ls_return_dt))
	case 'b_3'
		str_lxy.lx = iw_This.PointerX()
		str_lxy.ly = iw_This.PointerY() + 350
		openwithparm(w_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return
		Else
			ls_return_dt = Message.StringParm   // powerobject
		End If	
		this.SetItem(row, 'wo_estend_date', date(ls_return_dt))
	case 'b_4'
		open(w_wo_cause)
		str_get_parm = message.powerobjectparm
		if Not Isvalid(str_get_parm)  then 
		else
			this.setitem(row,'cause_code_a',string(str_get_parm.s_parm[1]))
			this.setitem(row,'cause_code_b',string(str_get_parm.s_parm[2]))
		end if
	case 'b_5'
		str_lxy.lx = iw_This.PointerX()
		str_lxy.ly = iw_This.PointerY() + 350
		openwithparm(w_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return
		Else
			ls_return_dt = Message.StringParm   // powerobject
		End If	
		this.SetItem(row, 'wo_acc_date', date(ls_return_dt))
		this.SetItem(row, 'wo_float_date', date(ls_return_dt))
		this.SetItem(row, 'wo_estend_date', date(ls_return_dt))
	case 'b_6'
		str_lxy.lx = iw_This.PointerX()
		str_lxy.ly = iw_This.PointerY() + 350
		openwithparm(w_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return
		Else
			ls_return_dt = Message.StringParm   // powerobject
		End If	
		this.SetItem(row, 'wo_start_date', date(ls_return_dt))
	case 'b_7'

		str_lxy.lx = iw_This.PointerX()
		str_lxy.ly = iw_This.PointerY() + 350
		openwithparm(w_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return
		Else
			ls_return_dt = Message.StringParm   // powerobject
		End If	
		this.SetItem(row, 'wo_end_date', date(ls_return_dt))	
end choose
end event

event doubleclicked;int	nValue
string sPath, sFile

string ls_data[]

if row <= 0 then return

Choose Case dwo.name 
	Case 'wo_div_code'
		IF f_code_search('d_lookup_wo_div', '', ls_data[]) THEN
			This.SetItem(row, 'wo_div_code', ls_data[1])
		END IF
	Case 'wo_state_code'
		IF f_code_search('d_lookup_status', '', ls_data[]) THEN
			This.SetItem(row, 'wo_state_code', ls_data[1])
		END IF
	Case 'equip_code'
		IF f_code_search('d_lookup_equip', '', ls_data[]) THEN
			This.SetItem(row, 'equip_code', ls_data[1])
		END IF
	Case 'cause_code'
		IF f_code_search('d_lookup_cause', '', ls_data[]) THEN
			This.SetItem(row, 'wo_cause_code', ls_data[1])
		END IF
	Case 'comp_code'
		IF f_code_search('d_lookup_comp', '', ls_data[]) THEN
			This.SetItem(row, 'wo_comp_code', ls_data[1])
		END IF		
	
End Choose		
ib_data_changed = true
end event

event retrieveend;
if this.getrow() <1 then return
this.gettext()
	if this.getitemnumber(this.getrow(),4) = 1 then
		this.object.t_24.visible=true
		this.object.t_25.visible=true
		this.object.comp_code.visible=true
		this.object.wo_value.visible=true
	else
		this.object.t_24.visible=false
		this.object.t_25.visible=false
		this.object.comp_code.visible=false
		this.object.wo_value.visible=false
	end if
end event

event itemchanged;int ll_hour, ll_second
string ls_check
time a, b, c, d
long result, result_1,total, day, day_1

if dwo.name = 'wo_outorder' then

	if data='1' then
		this.object.t_24.visible=true
		this.object.t_25.visible=true
		this.object.comp_code.visible=true
		this.object.wo_value.visible=true
	else
		this.object.t_24.visible=false
		this.object.t_25.visible=false
		this.object.comp_code.visible=false
		this.object.wo_value.visible=false
	end if
end if

choose case dwo.name
	case 'wo_end_date'
				
		this.accepttext()
		if this.getitemdatetime(row,'wo_acc_date') > datetime(date(left(data,10)),time(mid(data,11,10)))  then
		// datetime(date(left(data,10)),time(mid(data,11,10))) ----- 작업완료일시
			this.postevent('ue_ccc')
			ls_check="aaa"
		else

		end if

		if this.getitemdatetime(row,'wo_start_date') > datetime(date(left(data,10)),time(mid(data,11,10)))  then
			this.postevent('ue_ddd')
			ls_check="aaa"
		else
	
		end if
		//////////////////////////////////////////////////
	// 고장발생일시와 작업완료일시(wo_end_date) 사이의 장비부동시간 구하기
	// wo_acc_date(고장발생일시) --- this.getitemdatetime(row,12)
		if not isnull(this.getitemdatetime(row,12)) and ls_check<>"aaa" then
			dw_time.settransobject(sqlcmms)
			dw_time.retrieve(this.getitemdatetime(row,12),datetime(date(left(data,10)),time(right(data,15)))  )

		string ls_ex_start_time
		string ls_ex_end_time
		int aaa, i , ii
		dw_except.settransobject(sqlcmms)
		dw_except.setfilter(' check_box = "1"')
		dw_except.filter()
		dw_except.retrieve()
		aaa = dw_except.rowcount()
		i = 1
		ii = 1
		total = 0 //total은 총제외시간
		do until ii = aaa+1
			ls_ex_start_time = dw_except.getitemstring(i,'except_time_start_time')
			ls_ex_end_time = dw_except.getitemstring(i,'except_time_end_time')
			total = total + secondsafter(time(ls_ex_start_time),time(ls_ex_end_time))
		ii = ii+1
 	loop

		// day는 날짜차이	 
		dw_property.accepttext()
	   day = abs(daysafter(date(this.getitemdatetime(row,'wo_acc_date')),date(this.getitemdatetime(row,'wo_end_date'))))
		
		result = 0
				dw_property.accepttext( )
		a = time(this.getitemdatetime(row,'wo_acc_date'))
		b = time(this.getitemdatetime(row,'wo_end_date'))
		
		//날짜차이가 없는경우, 하루일 경우와 그 이외의 경우로 나눈다 - 세가지
		//첫번째 : 날짜 차이가 없는경우
	if abs(daysafter(date(this.getitemdatetime(row,'wo_acc_date')),date(this.getitemdatetime(row,'wo_end_date')))) < 1   then
		do until i=aaa+1
		
		ls_ex_start_time = dw_except.getitemstring(i,'except_time_start_time')
		ls_ex_end_time = dw_except.getitemstring(i,'except_time_end_time')		
		
		c = time(ls_ex_start_time)
		d = time(ls_ex_end_time)
		dw_property.accepttext( )

		
				if c>=a and b>=d then 
					result = result + long(secondsafter(c,d))
	
				elseif a>c and d>=a and b>d then
					result = result + long(secondsafter(a,d))

				elseif c>=a and b>=c and d>b then
					result = result + long(secondsafter(c,b))

				end if
		
		i=i+1
		loop
		
		// 날짜 차이가 하루일 경우	
	elseif abs(daysafter(date(this.getitemdatetime(row,'wo_acc_date')),date(this.getitemdatetime(row,'wo_end_date')))) = 1 then
			do until i=aaa+1
		
		ls_ex_start_time = dw_except.getitemstring(i,'except_time_start_time')
		ls_ex_end_time = dw_except.getitemstring(i,'except_time_end_time')		
		
		c = time(ls_ex_start_time)
		d = time(ls_ex_end_time)
		dw_property.accepttext( )

				if c>=a and 23:59:59>=d then 
					result = result + long(secondsafter(c,d))
				elseif a>c and d>=a and 23:59:59>d then
					result = result + long(secondsafter(a,d))
				elseif c>=a and 23:59:59>=c and d>23:59:59 then
					result = result + long(secondsafter(c,23:59:59))
				end if

				if c>=00:00:01 and b>=d then 
					result = result + long(secondsafter(c,d))
				elseif 00:00:01>c and d>=00:00:01 and b>d then
					result = result + long(secondsafter(00:00:01,d))
				elseif c>=00:00:01 and b>=c and d>b then
					result = result + long(secondsafter(c,b))
				end if
		
		i=i+1
		loop
		
		// 날짜 차이가 하루 초과하여 이틀이상일때... 
	else
		do until i=aaa+1
		
		ls_ex_start_time = dw_except.getitemstring(i,'except_time_start_time')
		ls_ex_end_time = dw_except.getitemstring(i,'except_time_end_time')		
		
		c = time(ls_ex_start_time)
		d = time(ls_ex_end_time)
		dw_property.accepttext( )

				if c>=a and 23:59:59>=d then 
					result = result + long(secondsafter(c,d))
				elseif a>c and d>=a and 23:59:59>d then
					result = result + long(secondsafter(a,d))
				elseif c>=a and 23:59:59>=c and d>23:59:59 then
					result = result + long(secondsafter(c,23:59:59))
				end if

				if c>=00:00:01 and b>=d then 
					result = result + long(secondsafter(c,d))
				elseif 00:00:01>c and d>=00:00:01 and b>d then
					result = result + long(secondsafter(00:00:01,d))
				elseif c>=00:00:01 and b>=c and d>b then
					result = result + long(secondsafter(c,b))
				end if
		
		i=i+1
		loop
	end if
		 
if abs(daysafter(date(this.getitemdatetime(row,'wo_acc_date')),date(this.getitemdatetime(row,'wo_end_date')))) < 1   then
			result_1 = secondsafter(a,b) - result // 날짜 차이 없을때 계산


elseif abs(daysafter(date(this.getitemdatetime(row,'wo_acc_date')),date(this.getitemdatetime(row,'wo_end_date')))) = 1 then		
			result_1 = secondsafter(a,23:59:59) + secondsafter(00:00:01,b) - result // 날짜차이하루일때 계산

else
			result_1 = secondsafter(a,23:59:59) + secondsafter(00:00:01,b) - result
			result_1 = result_1 + (86400 - total)*(day - 1)
			
		end if
			
			ll_hour=((result_1)/(3600))
	
			ll_second=long((result_1 - ll_hour * 3600)/60)
			
			this.setitem(row,15,ll_hour)
			this.setitem(row,16,ll_second)
			
		end if
		
		/////////////////////////////////////////////////////
		// 작업시작일시와 작업완료일시 사이의 장비부동시간 구하기
		// 장비투입일시(wo_start_date) --- this.getitemdatetime(row,13)
		if not isnull(this.getitemdatetime(row,13)) and ls_check<>"aaa" then
			dw_time.settransobject(sqlcmms)
			dw_time.retrieve(this.getitemdatetime(row,13),datetime(date(left(data,10)),time(right(data,15)))  )
			
		dw_except.settransobject(sqlcmms)
		dw_except.setfilter(' check_box = "1"')
		dw_except.filter()
		dw_except.retrieve()
		aaa = dw_except.rowcount()
		i = 1
		ii = 1
		total = 0 //total은 총제외시간
		do until ii = aaa+1
			ls_ex_start_time = dw_except.getitemstring(i,'except_time_start_time')
			ls_ex_end_time = dw_except.getitemstring(i,'except_time_end_time')
			total = total + secondsafter(time(ls_ex_start_time),time(ls_ex_end_time))
		ii = ii+1
 	loop

		// day_1는 날짜차이	 
		dw_property.accepttext()
		day_1 = abs(daysafter(date(this.getitemdatetime(row,'wo_start_date')),date(this.getitemdatetime(row,'wo_end_date'))))
		result = 0

				dw_property.accepttext( )
		a = time(this.getitemdatetime(row,'wo_start_date'))
		b = time(this.getitemdatetime(row,'wo_end_date'))
		
		//날짜차이가 없는경우, 하루일 경우와 그 이외의 경우로 나눈다 - 세가지
		//첫번째 : 날짜 차이가 없는경우
	if abs(daysafter(date(this.getitemdatetime(row,'wo_start_date')),date(this.getitemdatetime(row,'wo_end_date')))) < 1   then
		do until i=aaa+1
		
		ls_ex_start_time = dw_except.getitemstring(i,'except_time_start_time')
		ls_ex_end_time = dw_except.getitemstring(i,'except_time_end_time')		
		
		c = time(ls_ex_start_time)
		d = time(ls_ex_end_time)
		dw_property.accepttext( )

		
				if c>=a and b>=d then 
					result = result + long(secondsafter(c,d))

				elseif a>c and d>=a and b>d then
					result = result + long(secondsafter(a,d))
	
				elseif c>=a and b>=c and d>b then
					result = result + long(secondsafter(c,b))

				end if
		
		i=i+1
		loop
		
		// 날짜 차이가 하루일 경우	
	elseif abs(daysafter(date(this.getitemdatetime(row,'wo_start_date')),date(this.getitemdatetime(row,'wo_end_date')))) = 1 then
				do until i=aaa+1
		
		ls_ex_start_time = dw_except.getitemstring(i,'except_time_start_time')
		ls_ex_end_time = dw_except.getitemstring(i,'except_time_end_time')		
		
		c = time(ls_ex_start_time)
		d = time(ls_ex_end_time)
		dw_property.accepttext( )

				if c>=a and 23:59:59>=d then 
					result = result + long(secondsafter(c,d))
				elseif a>c and d>=a and 23:59:59>d then
					result = result + long(secondsafter(a,d))
				elseif c>=a and 23:59:59>=c and d>23:59:59 then
					result = result + long(secondsafter(c,23:59:59))
				end if

				if c>=00:00:01 and b>=d then 
					result = result + long(secondsafter(c,d))
				elseif 00:00:01>c and d>=00:00:01 and b>d then
					result = result + long(secondsafter(00:00:01,d))
				elseif c>=00:00:01 and b>=c and d>b then
					result = result + long(secondsafter(c,b))
				end if
		
		i=i+1
		loop
			
		// 날짜 차이가 하루 초과하여 이틀이상일때... 
	else
		do until i=aaa+1
		
		ls_ex_start_time = dw_except.getitemstring(i,'except_time_start_time')
		ls_ex_end_time = dw_except.getitemstring(i,'except_time_end_time')		
		
		c = time(ls_ex_start_time)
		d = time(ls_ex_end_time)
		dw_property.accepttext( )

				if c>=a and 23:59:59>=d then 
					result = result + long(secondsafter(c,d))
				elseif a>c and d>=a and 23:59:59>d then
					result = result + long(secondsafter(a,d))
				elseif c>=a and 23:59:59>=c and d>23:59:59 then
					result = result + long(secondsafter(c,23:59:59))
				end if

				if c>=00:00:01 and b>=d then 
					result = result + long(secondsafter(c,d))
				elseif 00:00:01>c and d>=00:00:01 and b>d then
					result = result + long(secondsafter(00:00:01,d))
				elseif c>=00:00:01 and b>=c and d>b then
					result = result + long(secondsafter(c,b))
				end if
		
		i=i+1
		loop
		
	end if
	////
	if abs(daysafter(date(this.getitemdatetime(row,'wo_start_date')),date(this.getitemdatetime(row,'wo_end_date')))) < 1   then
			result_1 = secondsafter(a,b) - result // 날짜 차이 없을때 계산

elseif abs(daysafter(date(this.getitemdatetime(row,'wo_start_date')),date(this.getitemdatetime(row,'wo_end_date')))) = 1 then		
			result_1 = secondsafter(a,23:59:59) + secondsafter(00:00:01,b) - result // 날짜차이하루일때 계산
		else
			result_1 = secondsafter(a,23:59:59) + secondsafter(00:00:01,b) - result
			result_1 = result_1 + (86400 - total)*(day_1 - 1)
		end if
			ll_hour=((result_1)/(3600))
			ll_second=long((result_1 - ll_hour * 3600)/60)
			
			this.setitem(row,17,ll_hour)
			this.setitem(row,18,ll_second)
		end if
		
		if isnull(data) or data = '' then
		else
			this.setitem(row,'wo_state_code','완료')
		end if
		
end choose

ib_data_changed = true
end event

event dberror;f_show_dberror(sqldbcode)

return 1
end event

event editchanged;ib_data_changed = true
end event

type tp_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 4530
integer height = 1412
long backcolor = 79741120
string text = "작업지침"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2_1 dw_2_1
dw_2 dw_2
end type

on tp_2.create
this.dw_2_1=create dw_2_1
this.dw_2=create dw_2
this.Control[]={this.dw_2_1,&
this.dw_2}
end on

on tp_2.destroy
destroy(this.dw_2_1)
destroy(this.dw_2)
end on

type dw_2_1 from datawindow within tp_2
integer x = 1824
integer width = 1545
integer height = 1396
integer taborder = 20
string title = "none"
string dataobject = "d_equip_guide_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from uo_datawindow within tp_2
integer width = 1819
integer height = 1076
integer taborder = 10
string dataobject = "d_equip_guide"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

event doubleclicked;call super::doubleclicked;//str_parm lstr
//long ll_upper_bound, i, ll_insert
//
//if lower(string(dwo.name)) = 'guide_code' then
//
//	lstr.s_parm[1] = 'd_lookup_guide'
//	lstr.s_parm[2] = ''	
//	lstr.s_parm[3] = '1'	
//	lstr.Check = true
//	
//	OpenWithParm(w_cd_search_multi,lstr)
//	
//	lstr = Message.PowerObjectParm
//	
//	ll_upper_bound = UpperBound(lstr.s_array, 1)
//	
//	if ll_upper_bound < 1 then return
//	
//	for i = 1 to ll_upper_bound
//		if IsNull(lstr.s_array[i, 1]) or lstr.s_array[i, 1] = '' then exit
//		
//		if i = 1 then
//			this.SetItem(row, 'guide_code', lstr.s_array[i, 1])
//			ll_insert = row
//		else
//			ll_insert = this.InsertRow(0)
//			this.SetItem(ll_insert, 'guide_code', lstr.s_array[i, 1])
//		end if
//		this.Event ItemChanged(ll_insert, dwo, lstr.s_array[i, 1])
//	next
//end if
end event

event itemchanged;call super::itemchanged;//iw_this.TriggerEvent('ue_set_data_changed')
//
//if row <= 0 then return
//
//string ls_colname
//datawindowchild ldwc
//long ll_row
//string ls_guide_code, ls_guide_name
//ls_colname = dwo.name
//
//if ls_colname = 'guide_code' then
//	this.GetChild('guide_code', ldwc)
//	This.AcceptText()
//	ls_guide_code = This.GetItemString(row,'guide_code')
//	If isnull(ls_guide_code) or ls_guide_code = '' then Return
//
//	ll_row = f_dddw_getrow(This,row,'guide_code',ls_guide_code)
//	//ll_row = ldwc.GetRow()
//	if ll_row > 0 then
//		ls_guide_name = ldwc.GetItemString(ll_row, 'guide_name')
//		
//		this.SetItem(row, 'guide_name', ls_guide_name)
//		
//	end if
//	this.triggerevent('rowfocuschanged')
//end if
ib_data_changed = true
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow < 1 then 
	dw_2_1.reset()
return
end if
string sql
string origin_sql

origin_sql = dw_2_1.object.datawindow.table.select

sql = " where guide_code='"+dw_2.getitemstring(dw_2.getrow(),'guide_code')+"'"

dw_2_1.object.datawindow.table.select = dw_2_1.object.datawindow.table.select + sql

if dw_2_1.getrow() > 0 then
	if dw_2_1.retrieve() < 1 then
		tab_1.tp_2.dw_2_1.insertrow(0)
	end if
else
	tab_1.tp_2.dw_2_1.insertrow(0)
end if
dw_2_1.object.datawindow.table.select =origin_sql
end event

event editchanged;call super::editchanged;ib_data_changed = true
end event

type tp_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 4530
integer height = 1412
long backcolor = 79741120
string text = "첨부파일"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tp_3.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tp_3.destroy
destroy(this.dw_3)
end on

type dw_3 from uo_datawindow within tp_3
integer width = 4512
integer height = 1404
integer taborder = 10
string dataobject = "d_equip_ftpfile"
end type

event buttonclicked;call super::buttonclicked;String ls_fileNam, ls_fileId, ls_fileDesc, ls_equip, ls_btnName, ls_msg

ls_btnName = dwo.name

if this.getrow() <= 0 And ls_btnName <> 'b_upload' then return

if ls_btnName <> 'b_upload' then
	ls_fileId = this.getitemstring(this.getrow(),1)
	ls_fileNam = this.getitemstring(this.getrow(),5)
	ls_fileDesc = this.getitemstring(this.getrow(),6)
	trim(ls_fileId); trim(ls_fileNam);
	if isNull(ls_fileId) Or ls_fileId = '' then
		MessageBox("확인", "리스트에서 파일을 선택하세요!!")
		return
	end if
else 
	ls_equip = dw_list.getitemstring(dw_list.getrow(), 'equip_code')
	if isNull(ls_equip) Or ls_equip = '' Then 
		MessageBox("확인", "리스트에서 장비를 선택하세요!!")
		return
	end if
end if

//FTP 객체 생성
u_ftp = create u_cmms_ftp
If isvalid(u_ftp) = FALSE then 
	ls_msg = "FTP 객체생성을 실패했읍니다.~r~n 재시도하세요!!"
	goto ERR_CLOSE
END IF

// FTP 정보 GET
if u_ftp.uf_GetFtpInfo(ls_msg) <> 1 then goto ERR_CLOSE

// FTP 연결
if u_ftp.uf_connect(ls_msg) <> 1 then goto ERR_CLOSE

SetPointer(HourGlass!)
Choose Case ls_btnName
	Case 'b_exe'

		uo_status.st_message.text	=	'파일 다운로드 중.....'
		if u_ftp.uf_exe(ls_fileId, ls_fileNam, ls_msg) <> 1 then goto ERR_CLOSE
		uo_status.st_message.text = '파일 다운로드 완료'

	Case 'b_down'

		uo_status.st_message.text	=	'파일 다운로드 중.....'
		if u_ftp.uf_download(ls_fileId, ls_fileNam, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '파일 다운로드 완료'
		
	Case 'b_upload'
			
		uo_status.st_message.text	=	'파일 전송 중.....'
		if u_ftp.uf_Upload(ls_equip, ib_upOpened, ls_fileId, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '파일 전송 완료'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		// hiright
		this.ScrollToRow(this.Find("File_Id = '" + ls_fileId + "'", 1, this.RowCount()))

	Case 'b_chg'
		uo_status.st_message.text = '파일명 변경 중.....'
		//파일명 변경
		if u_ftp.uf_chg(ls_fileId, ls_fileNam, ls_fileDesc, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '변경 완료..'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		// hiright
		this.ScrollToRow(this.Find("File_Id = '" + ls_fileId + "'", 1, this.RowCount()))
	Case 'b_del'
		uo_status.st_message.text = '파일 삭제 중.....'
		// 파일 삭제
		if u_ftp.uf_Del(ls_fileId, ls_fileNam, ls_msg) = -1 Then goto ERR_CLOSE
		uo_status.st_message.text = '파일 삭제 완료'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		
End Choose

SetPointer(Arrow!)
u_ftp.uf_disconnect()
DESTROY u_ftp
SetNull(u_ftp)
return

ERR_CLOSE:
	MessageBox("확인", ls_msg)
	SetPointer(Arrow!)
	u_ftp.uf_disconnect()
	DESTROY u_ftp
	SetNull(u_ftp)
	return
end event

event clicked;call super::clicked;//id_dw_current = this
//
//if row > 0 then 
//	il_row = row
//end if
end event

event doubleclicked;call super::doubleclicked;//long 	lCol
//int	nValue
//string sPath, sFile
//
//lCol = GetColumn()
//
//if row < 1 then
//	return
//else
//	if lCol = 2 then
//		sPath = Trim(GetItemString(row, lCol))
//		if IsNull(sPath) then 
//			sPath = ""
//		end if
//		string ls_path
////		if gs_kmarea = 'D' and gs_kmdivision = 'A' then
////			ls_path = ProfileString(gs_ini,"Option","AppPathda",         " ")
////		elseif gs_kmarea = 'D' and gs_kmdivision = 'H' then
////			ls_path = ProfileString(gs_ini,"Option","AppPathdh",         " ")
////		elseif gs_kmarea = 'D' and gs_kmdivision = 'V' then
////			ls_path = ProfileString(gs_ini,"Option","AppPathdv",         " ")
////		elseif gs_kmarea = 'D' and gs_kmdivision = 'S' then
////			ls_path = ProfileString(gs_ini,"Option","AppPathds",         " ")
////		elseif gs_kmarea = 'D' and gs_kmdivision = 'M' then
////			ls_path = ProfileString(gs_ini,"Option","AppPathdm",         " ")
////		elseif gs_kmarea = 'J'  then
////			ls_path = ProfileString(gs_ini,"Option","AppPathj",         " ")
////		end if
//		ls_path = ProfileString(gs_inifile,"PARAMETER","AppPath",         " ")
//		nValue = GetFileSaveName("첨부파일 저장", sPath, sFile)
//		if nvalue= 1 then
//
//			nvalue = FileCopy (spath ,ls_path+sfile, false)
//
//			if nvalue= 1 then
//				this.setitem(this.getrow(),2,ls_path+sfile)
//			else
//				
//				messagebox("알림","같은 파일이 존재합니다. 다른 이름으로 저장합니다.") 
//				sfile='New_'+sfile
//				nvalue = FileCopy (spath ,ls_path+sfile, false)
//				if nvalue = 1 then
//						this.setitem(this.getrow(),2,ls_path+sfile)
//				end if	
//				do until nvalue = 1
//					nvalue = FileCopy (spath ,ls_path+sfile, false)
//					if nvalue = 1 then
//						this.setitem(this.getrow(),2,ls_path+sfile)
//					end if	
//					sfile='New_'+sfile
//				loop
//				
//			end if
//		end if
//	end if
//end if 
//
//iw_this.TriggerEvent('ue_set_data_changed')
end event

event editchanged;call super::editchanged;//ib_data_changed = true
end event

event itemchanged;call super::itemchanged;//ib_data_changed = true
end event

event scrollhorizontal;call super::scrollhorizontal;
if il_FtpScrollPos < scrollpos then
	this.object.b_exe.X = String(Long(this.object.b_exe.X) + scrollpos - il_FtpScrollPos)
	this.object.b_down.X = String(Long(this.object.b_down.X) + scrollpos - il_FtpScrollPos)
	this.object.b_upload.X = String(Long(this.object.b_upload.X) + scrollpos - il_FtpScrollPos)
	this.object.b_chg.X = String(Long(this.object.b_chg.X) + scrollpos - il_FtpScrollPos)
	this.object.b_del.X = String(Long(this.object.b_del.X) + scrollpos - il_FtpScrollPos)
else
	this.object.b_exe.X = String(Long(this.object.b_exe.X) - (il_FtpScrollPos - scrollpos))
	this.object.b_down.X = String(Long(this.object.b_down.X) - (il_FtpScrollPos - scrollpos))
	this.object.b_upload.X = String(Long(this.object.b_upload.X) - (il_FtpScrollPos - scrollpos))
	this.object.b_chg.X = String(Long(this.object.b_chg.X) - (il_FtpScrollPos - scrollpos))
	this.object.b_del.X = String(Long(this.object.b_del.X) - (il_FtpScrollPos - scrollpos))
end if

il_FtpScrollPos = scrollpos
end event

type dw_list from uo_datawindow within w_pisf021
integer x = 704
integer width = 3337
integer height = 1076
integer taborder = 10
string dataobject = "d_wo2_list"
end type

event rowfocuschanged;call super::rowfocuschanged;parent.triggerevent('ue_retrieve_each_tab')

if currentrow < 1 then
	id_dw_1.reset()
end if
int li_count

for li_count = 1 to 3
	ib_refreshed_tab[li_count] = false
next
end event

type ddlb_filter from dropdownlistbox within w_pisf021
integer y = 188
integer width = 690
integer height = 484
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
boolean sorted = false
string item[] = {"전체목록","작명유형별","대상장비별","고장원인별","라인별"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;
CHOOSE CASE this.text
	CASE '라인별'
		dw_group.dataobject = 'd_group_line'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea, gs_kmdivision)	
		
	CASE '작명유형별'
		dw_group.dataobject = 'd_group_wo_div'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea, gs_kmdivision)		
		
	CASE '대상장비별'
		
		datawindowchild ldwc
		String equip_code
		
		dw_group.dataobject = 'd_group_equip'
		dw_group.SetTransObject(sqlcmms)
		
		dw_group.GetChild('equip_code_1', ldwc)
		ldwc.settransobject(sqlcmms)
		ldwc.retrieve(gs_kmarea, gs_kmdivision)
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		end if
		
		dw_group.GetChild('code', ldwc)
		ldwc.settransobject(sqlcmms)
		ldwc.retrieve(gs_kmarea, gs_kmdivision)
		if ldwc.RowCount() < 1 then
			ldwc.InsertRow(0)
		else 
			equip_code = ldwc.getItemString(1, 'equip_code')
			ldwc.setitem(1, 'equip_code', equip_code)
		end if
		f_dddw_width(dw_group, 'code', ldwc, 'equip_name', 10)

		dw_group.insertrow(0)
		
	CASE '고장원인별'
		dw_group.dataobject = 'd_group_cause_sp'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea,gs_kmdivision,em_1.text,em_2.text)		
	CASE '전체목록'
		dw_group.reset()
		parent.triggerevent('ue_retrieve')
END CHOOSE
end event

type em_1 from editmask within w_pisf021
integer x = 192
integer width = 402
integer height = 84
integer taborder = 20
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

type dw_group from datawindow within w_pisf021
integer y = 276
integer width = 690
integer height = 504
integer taborder = 20
boolean bringtotop = true
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;
if dw_group.dataobject = 'd_group_equip' then return
	
selectrow(0, false)
setrow(currentrow)
selectrow(currentrow, true)

parent.triggerevent('ue_retrieve')
end event

event itemchanged;
if dw_group.dataobject <> 'd_group_equip' then return

selectrow(0, false)
setrow(row)

parent.triggerevent('ue_retrieve')
end event

event doubleclicked;
if dw_group.dataobject <> 'd_group_equip' then return

string ls_data[]
if f_code_search('d_lookup_equip', '', ls_data[]) THEN
	this.SetItem(row, 'code', ls_data[1])
	
	if trim(ls_data[1]) <> '' then
		parent.triggerevent('ue_retrieve')
	end if
end if
end event

type uo_area from u_cmms_select_area within w_pisf021
integer x = 101
integer y = 796
integer taborder = 50
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

type uo_division from u_cmms_select_division within w_pisf021
integer x = 101
integer y = 868
integer taborder = 60
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type gb_2 from groupbox within w_pisf021
integer x = 14
integer y = 760
integer width = 677
integer height = 192
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_pisf021
integer y = 928
integer width = 699
integer height = 140
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
end type

