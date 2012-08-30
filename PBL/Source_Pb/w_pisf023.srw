$PBExportHeader$w_pisf023.srw
$PBExportComments$예방정비
forward
global type w_pisf023 from w_cmms_sheet01
end type
type cb_1 from commandbutton within w_pisf023
end type
type ddlb_filter from dropdownlistbox within w_pisf023
end type
type dw_group from datawindow within w_pisf023
end type
type dw_list from uo_datawindow within w_pisf023
end type
type cb_2 from commandbutton within w_pisf023
end type
type gb_1 from groupbox within w_pisf023
end type
type tab_1 from tab within w_pisf023
end type
type tp_1 from userobject within tab_1
end type
type dw_1_2 from uo_datawindow within tp_1
end type
type dw_close from datawindow within tp_1
end type
type dw_1_1 from uo_datawindow within tp_1
end type
type dw_1 from uo_datawindow within tp_1
end type
type dw_property from datawindow within tp_1
end type
type tp_1 from userobject within tab_1
dw_1_2 dw_1_2
dw_close dw_close
dw_1_1 dw_1_1
dw_1 dw_1
dw_property dw_property
end type
type tp_2 from userobject within tab_1
end type
type dw_2 from uo_datawindow within tp_2
end type
type dw_2_1 from datawindow within tp_2
end type
type tp_2 from userobject within tab_1
dw_2 dw_2
dw_2_1 dw_2_1
end type
type tp_3 from userobject within tab_1
end type
type dw_3 from uo_datawindow within tp_3
end type
type tp_3 from userobject within tab_1
dw_3 dw_3
end type
type tab_1 from tab within w_pisf023
tp_1 tp_1
tp_2 tp_2
tp_3 tp_3
end type
type uo_area from u_cmms_select_area within w_pisf023
end type
type uo_division from u_cmms_select_division within w_pisf023
end type
type st_2 from statictext within w_pisf023
end type
type gb_2 from groupbox within w_pisf023
end type
end forward

global type w_pisf023 from w_cmms_sheet01
integer width = 4654
integer height = 2852
string title = "예방정비"
cb_1 cb_1
ddlb_filter ddlb_filter
dw_group dw_group
dw_list dw_list
cb_2 cb_2
gb_1 gb_1
tab_1 tab_1
uo_area uo_area
uo_division uo_division
st_2 st_2
gb_2 gb_2
end type
global w_pisf023 w_pisf023

type variables
datawindow id_dw_current
datawindow id_dw_property 
datawindow id_dw_1 
datawindow id_dw_1_1 
datawindow id_dw_1_2 
datawindow id_dw_2 
datawindow id_dw_3 

string is_original_sql_list 
string is_original_sql_property 
string is_original_sql_1 
string is_original_sql_1_1 
string is_original_sql_1_2 
string is_original_sql_2 
string is_original_sql_3 

long il_row

string is_task_code

// FTP 관련 
boolean ib_upOpened = FALSE	//업로드시 파일폴더열면 이전의 파일폴더 open
Long il_FtpScrollPos

u_cmms_ftp u_ftp

boolean ib_opened = false
end variables

on w_pisf023.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.ddlb_filter=create ddlb_filter
this.dw_group=create dw_group
this.dw_list=create dw_list
this.cb_2=create cb_2
this.gb_1=create gb_1
this.tab_1=create tab_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.ddlb_filter
this.Control[iCurrent+3]=this.dw_group
this.Control[iCurrent+4]=this.dw_list
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.uo_area
this.Control[iCurrent+9]=this.uo_division
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.gb_2
end on

on w_pisf023.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.ddlb_filter)
destroy(this.dw_group)
destroy(this.dw_list)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.tab_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.gb_2)
end on

event resize;call super::resize;dw_list.width = newwidth - ddlb_filter.WIDTH

tab_1.width = newwidth
//tab_1.height = newheight - 1090

tab_1.tp_1.dw_property.width = tab_1.width - 40
tab_1.tp_1.dw_1.width = tab_1.width - tab_1.tp_1.dw_1_1.width - 40
tab_1.tp_1.dw_1.height = tab_1.height - tab_1.tp_1.dw_property.height - 215
tab_1.tp_1.dw_1_1.height = (tab_1.height - tab_1.tp_1.dw_property.height - 215) /2
tab_1.tp_1.dw_1_2.y = tab_1.tp_1.dw_1_1.height + tab_1.tp_1.dw_property.height
tab_1.tp_1.dw_1_2.height = tab_1.height - tab_1.tp_1.dw_property.height - 215 - tab_1.tp_1.dw_1_1.height
tab_1.tp_1.dw_1_1.x=tab_1.tp_1.dw_1.width
tab_1.tp_1.dw_1_2.x=tab_1.tp_1.dw_1.width

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
tab_1.tp_1.dw_1_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms)   


id_dw_property = tab_1.tp_1.dw_property 
id_dw_1 = tab_1.tp_1.dw_1
id_dw_1_1 = tab_1.tp_1.dw_1_1
id_dw_1_2 = tab_1.tp_1.dw_1_2
id_dw_2 = tab_1.tp_2.dw_2
id_dw_3 = tab_1.tp_3.dw_3

is_original_sql_list = dw_list.object.datawindow.table.select
is_original_sql_property = id_dw_property.object.datawindow.table.select
is_original_sql_1 = id_dw_1.object.datawindow.table.select
is_original_sql_1_1 = id_dw_1_1.object.datawindow.table.select
is_original_sql_1_2 = id_dw_1_2.object.datawindow.table.select
is_original_sql_2 = id_dw_2.object.datawindow.table.select
is_original_sql_3 = id_dw_3.object.datawindow.table.select
//st_vertical.PostEvent('ue_mouseup')

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  true,  true,  true,  false, false, false, false)
end event

event ue_delete;call super::ue_delete;long ll_row

if not IsNull(id_dw_current) then
	ll_row = id_dw_current.GetRow()
	if ll_row > 0 then
		id_dw_current.DeleteRow(ll_row)
	end if
end if
ib_data_changed = true



end event

event ue_insert;call super::ue_insert;long ll_row
datawindow ld_dw

if dw_list.getrow() < 1 then return 0
choose case tab_1.selectedTab
	case 1
		if isnull(id_dw_current) or id_dw_current = id_dw_property then return 0
		ld_dw = id_dw_current
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))
		if ld_dw = id_dw_1 then
			ld_dw.setitem(ld_dw.getrow(),"area_code",gs_kmarea)
			ld_dw.setitem(ld_dw.getrow(),"factory_code",gs_kmdivision)
		elseif ld_dw = id_dw_1_1 then
			ld_dw.setitem(ld_dw.getrow(),"task_part_area_code",gs_kmarea)
			ld_dw.setitem(ld_dw.getrow(),"task_part_factory_code",gs_kmdivision)
		elseif ld_dw = id_dw_1_2 then
			ld_dw.setitem(ld_dw.getrow(),"task_emp_area_code",gs_kmarea)
			ld_dw.setitem(ld_dw.getrow(),"task_emp_factory_code",gs_kmdivision)
		end if
	case 2
		if isnull(id_dw_current) then return 0
		if dw_list.getitemstring(dw_list.getrow(),2) = '' or isnull(dw_list.getitemstring(dw_list.getrow(),2))then return 0
		ld_dw = tab_1.tp_2.dw_2
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),2))
		ld_dw.setitem(ld_dw.getrow(),"equip_guide_area_code",gs_kmarea)
		ld_dw.setitem(ld_dw.getrow(),"equip_guide_factory_code",gs_kmdivision)
		tab_1.tp_2.dw_2_1.insertrow(0)
	case 3
		if isnull(id_dw_current) then return 0
		if dw_list.getitemstring(dw_list.getrow(),2) = '' or isnull(dw_list.getitemstring(dw_list.getrow(),2))then return 0
		ld_dw = id_dw_current
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),2))
		ld_dw.setitem(ld_dw.getrow(),"area_code",gs_kmarea)
		ld_dw.setitem(ld_dw.getrow(),"factory_code",gs_kmdivision)
end choose
end event

event ue_retrieve;call super::ue_retrieve;int li_current_tab_page
string ls_where, ls_and, ls_code
long ll_row
string ls_factory, ls_area

ls_area=gs_kmarea
ls_factory=gs_kmdivision

li_current_tab_page = tab_1.SelectedTab

ll_row = dw_group.GetRow()
if (ll_row > 0) then
	ls_code = dw_group.GetItemString(ll_row, 'code')
end if

CHOOSE CASE ddlb_filter.text
	CASE '전체목록',''
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' and task.area_code = ' +"'"+ls_area+ "' and task.factory_code='"+ls_factory+"' ORDER BY task.task_code"
	case '투입인원별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' and task.area_code = ' +"'"+ls_area+ "' and task.factory_code='"+ls_factory+ "' and task.emp_code='"+ls_code+"' ORDER BY task.task_code"
	case '작업상태별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' and task.area_code = ' +"'"+ls_area+ "' and task.factory_code='"+ls_factory+ "' and task.status_code='"+ls_code+"' ORDER BY task.task_code"
	case '라인별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' and task.area_code = ' +"'"+ls_area+ "' and task.factory_code='"+ls_factory+ "' and equip_master.line_code='"+ls_code+"' ORDER BY task.task_code"
end choose
		
dw_list.object.datawindow.table.select = is_original_sql_list + ls_where 

dw_list.retrieve()  

dw_list.selectrow(0, false)
dw_list.SetRow(1)
dw_list.selectrow(1, true)

this.triggerevent('ue_retrieve_each_tab')

ib_refreshed_tab[li_current_tab_page] = true





end event

event ue_retrieve_each_tab;call super::ue_retrieve_each_tab;string ls_where, ls_and,ls_where1, ls_where2
long li_current_tab_page

li_current_tab_page = tab_1.SelectedTab

if dw_list.getrow() < 1 then 
	id_dw_property.reset()		
	id_dw_1.reset()		
	id_dw_1_1.reset()
	id_dw_1_2.reset()	
	id_dw_2.reset()		
	id_dw_3.reset()		
	return
end if
ls_where = ' where task_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'"
ls_and = ' and task_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'"
ls_where1 = ' and equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),2) + "'"
ls_where2 = ' where equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),2) + "'"
choose case li_current_tab_page
	case 1  
		id_dw_property.object.datawindow.table.select = is_original_sql_property + ls_and &
			+ " and task.area_code='"+gs_kmarea+"' and task.factory_code='"+gs_kmdivision+"'"
		id_dw_1.object.datawindow.table.select = is_original_sql_1 + ls_where &
			+ " and task_class.area_code='"+gs_kmarea+"' and task_class.factory_code='"+gs_kmdivision+"'"
		id_dw_1_1.object.datawindow.table.select = is_original_sql_1_1 + ls_and &
			+ " and task_part.area_code='"+gs_kmarea+"' and task_part.factory_code='"+gs_kmdivision+"'"
		id_dw_1_2.object.datawindow.table.select = is_original_sql_1_2 + ls_and &
			+ " and task_emp.area_code='"+gs_kmarea+"' and task_emp.factory_code='"+gs_kmdivision+"'"
		
		id_dw_property.retrieve()
		id_dw_1.retrieve()
		id_dw_1_1.retrieve()
		id_dw_1_2.retrieve()
	case 2  						
		id_dw_2.object.datawindow.table.select = is_original_sql_2 &
		   + ' and equip_guide.equip_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),2) + "'" &
			+ " and equip_guide.area_code='"+gs_kmarea+"' and equip_guide.factory_code='"+gs_kmdivision+"'"
		id_dw_2.retrieve()
	case 3  						
		id_dw_3.retrieve(gs_kmArea, gs_kmdivision, dw_list.getitemstring(dw_list.getrow(),2))
//		id_dw_3.object.datawindow.table.select = is_original_sql_3 + ls_where2
//		id_dw_3.retrieve()	
end choose

ib_refreshed_tab[li_current_tab_page] = true

end event

event ue_save;call super::ue_save;long ll_row , i
string ls_serial, ls_serial1,ls_serial2, ls_now
datawindow ld_dw

choose case tab_1.selectedTab
	case 1
		//예방정비 기본정보 업데이트
		if id_dw_property.update() = -1 then
			return 0
		else
			if id_dw_property.getrow() > 0 then
				ls_now=id_dw_property.getitemstring(id_dw_property.getrow(),'task_task_code')
			end if
			
		end if
		//장비검사항목 업데이트
		if id_dw_1.update() = -1 then
			return 0
		else
			id_dw_property.accepttext()
			if id_dw_property.getrow() > 0 then
				if id_dw_property.getitemstring(id_dw_property.getrow(),'status_code') = '완료' then
					cb_2.postevent(clicked!)
				end if
			end if
			if id_dw_1.getrow() < 1 then 
				ib_data_changed = FALSE
				this.triggerevent('ue_retrieve')
				return 1
			end if
		end if
		if id_dw_1_1.update() = -1 then
			return 0
		end if
		if id_dw_1_2.update() = -1 then
			return 0
		end if
	case 2
		
		if id_dw_2.update() = - 1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'task_code')
			end if
		end if
		if id_dw_2.getrow() < 1 then return 0

		if id_dw_2.getitemstring(id_dw_2.getrow(),2) = '' or isnull(id_dw_2.getitemstring(id_dw_2.getrow(),2)) then
		else
			id_dw_2.accepttext()
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
				ls_now=dw_list.getitemstring(dw_list.getrow(),'task_code')
			end if
			
		end if
end choose
ib_data_changed = FALSE
this.triggerevent('ue_retrieve')
dw_list.scrolltorow(dw_list.find("task_code='"+ls_now+"'",1,dw_list.rowcount()))
return 1
end event

event ue_postopen;call super::ue_postopen;str_parm str_get_parm
string ls_return[]
long ii, ll_find
datawindowchild  ldwc

ddlb_filter.selectitem(1)
dw_group.reset()

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_1.dw_1.settransobject(sqlcmms)   
tab_1.tp_1.dw_1_1.settransobject(sqlcmms)   
tab_1.tp_1.dw_1_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms)   

id_dw_1.GetChild('task_class_class_div', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)

id_dw_1.GetChild('task_class_class_process', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)

id_dw_1_2.GetChild('emp_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_1_2, 'emp_code', ldwc, 'emp_name', 10)

id_dw_1_1.GetChild('part_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
f_dddw_width(id_dw_1_1, 'part_code', ldwc, 'part_spec', 10)

id_dw_property.GetChild('status_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
f_dddw_width(id_dw_property, 'status_code', ldwc, 'status_name', 10)

//id_dw_2.GetChild('guide_code', ldwc)
//f_dddw_width(id_dw_2, 'guide_code', ldwc, 'guide_name', 10)

str_get_parm = Message.PowerObjectParm

if Isvalid(str_get_parm) then
	For ii = 1 To UpperBound(str_get_parm.s_parm[])
		ls_return[ii] = str_get_parm.s_parm[ii]
	Next

	if UpperBound(ls_return[]) > 0 then
		is_task_code = ls_return[3]
		this.triggerevent('ue_retrieve')
		
		ll_find = dw_list.find(" task_code = '"+is_task_code+"'" , 1, dw_list.RowCount())					
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

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  true,  true,  true,  false, false, false, false)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf023
integer x = 23
end type

type cb_1 from commandbutton within w_pisf023
integer x = 137
integer y = 968
integer width = 421
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "인쇄미리보기"
end type

event clicked;if dw_list.getrow() < 1 then return

string ls_task,ls_div

ls_task=dw_list.getitemstring(dw_list.getrow(),1)
OpenSheet(w_report_preview, w_frame, 0, Layered!)

w_report_preview.dw_report.dataobject = 'dr_task_report'
w_report_preview.dw_report.SetTransObject(sqlcmms)
datawindowchild ldwc

w_report_preview.dw_report.GetChild('task_emp_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)

w_report_preview.dw_report.GetChild('task_class_class_div', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)

w_report_preview.dw_report.GetChild('task_class_class_spot', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)

w_report_preview.dw_report.GetChild('task_class_class_process', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)

w_report_preview.dw_report.retrieve(gs_kmarea, gs_kmdivision,ls_task)

w_report_preview.TriggerEvent('ue_preview_mode')
end event

type ddlb_filter from dropdownlistbox within w_pisf023
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
string item[] = {"전체목록","투입인원별","작업상태별","라인별"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE this.text
	CASE '라인별'
		dw_group.dataobject = 'd_group_line'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea, gs_kmdivision)
	CASE '투입인원별'
		dw_group.dataobject = 'd_group_emp'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea, gs_kmdivision)		
	CASE '작업상태별'
		dw_group.dataobject = 'd_group_status'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea, gs_kmdivision)		
	CASE '전체목록'
		dw_group.reset()		
		parent.triggerevent('ue_retrieve')
END CHOOSE
end event

type dw_group from datawindow within w_pisf023
integer y = 88
integer width = 690
integer height = 644
integer taborder = 50
string title = "none"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;selectrow(0, false)
setrow(currentrow)
selectrow(currentrow, true)

parent.triggerevent('ue_retrieve')
end event

type dw_list from uo_datawindow within w_pisf023
integer x = 699
integer width = 3342
integer height = 1076
integer taborder = 20
string dataobject = "d_task_list"
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

type cb_2 from commandbutton within w_pisf023
boolean visible = false
integer x = 448
integer y = 968
integer width = 224
integer height = 84
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "마감"
end type

event clicked;if dw_list.getrow() < 1 then return

long ll_row, ll_count

do while dw_list.find("status_code = '완료'", ll_row, dw_list.RowCount()) > 0
		ll_row=dw_list.find("status_code = '완료'", ll_row, dw_list.RowCount())
		tab_1.tp_1.dw_close.SetTransObject(sqlcmms)
		ll_row=tab_1.tp_1.dw_close.Retrieve(gs_kmarea,gs_kmdivision,dw_list.getitemstring(ll_row,'task_code'))		
		parent.triggerevent('ue_retrieve_each_tab')
		parent.triggerevent('ue_retrieve')
		ll_count = ll_count+1
LOOP

messagebox("알림",string(ll_count)+'개의 예방정비가 마감되었습니다.')


end event

type gb_1 from groupbox within w_pisf023
integer x = 14
integer y = 928
integer width = 681
integer height = 148
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
end type

type tab_1 from tab within w_pisf023
integer y = 1088
integer width = 4613
integer height = 1520
integer taborder = 30
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
integer width = 4576
integer height = 1408
long backcolor = 79741120
string text = "등록정보"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1_2 dw_1_2
dw_close dw_close
dw_1_1 dw_1_1
dw_1 dw_1
dw_property dw_property
end type

on tp_1.create
this.dw_1_2=create dw_1_2
this.dw_close=create dw_close
this.dw_1_1=create dw_1_1
this.dw_1=create dw_1
this.dw_property=create dw_property
this.Control[]={this.dw_1_2,&
this.dw_close,&
this.dw_1_1,&
this.dw_1,&
this.dw_property}
end on

on tp_1.destroy
destroy(this.dw_1_2)
destroy(this.dw_close)
destroy(this.dw_1_1)
destroy(this.dw_1)
destroy(this.dw_property)
end on

type dw_1_2 from uo_datawindow within tp_1
integer x = 2903
integer y = 872
integer width = 1673
integer height = 492
integer taborder = 40
string dataobject = "d_task_mh"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
//check_data=3
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

	end if
end if
end event

type dw_close from datawindow within tp_1
boolean visible = false
integer x = 1289
integer y = 500
integer width = 686
integer height = 400
integer taborder = 20
string dataobject = "sp_task_close"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1_1 from uo_datawindow within tp_1
integer x = 2903
integer y = 396
integer width = 1673
integer height = 488
integer taborder = 20
string dataobject = "d_task_part"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this

long aaa

if dwo.name = 'qty' then
	if this.getitemnumber(row,4) > 0 then return
	aaa=messagebox("알림",'자재를 불출하시겠습니까?',Exclamation!, OKCancel!, 2)
	if aaa=1 then
		if row <= 0 then return

			string ls_part,ls_wo,ls_equip

			ls_part = this.GetItemString(row, 'part_code')
			ls_wo = id_dw_property.GetItemString(id_dw_property.getrow(), 'task_task_code')
			ls_equip=id_dw_property.GetItemString(id_dw_property.getrow(), 'task_equip_code')
			if ls_part = '' or isnull(ls_part) then
				MessageBox("알림", '자재를 선택하고 다시한번 시도해보십시오.')
			return
		end if

		window lw_win
		str_parm lstr
		
		lstr.s_parm[1] = '5'
		lstr.s_parm[2] = '[설비관리]-[자재불출]'
		lstr.s_parm[3] = ls_part
		lstr.s_parm[4] = ls_wo
		lstr.s_parm[5] = ls_equip
		lstr.s_parm[6] = 'task'
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
string ls_part_name, ls_part_spec
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
		ls_part_spec = ldwc.GetItemstring(ll_row, 'part_spec')

		this.SetItem(row, 'part_name', ls_part_name)
		this.SetItem(row, 'part_spec', ls_part_spec)


	end if
end if

ib_data_changed = true
end event

type dw_1 from uo_datawindow within tp_1
integer y = 400
integer width = 2875
integer height = 976
integer taborder = 10
string dataobject = "d_task_class"
boolean ib_select_row = false
end type

event retrieveend;call super::retrieveend;long ll_cnt

for ll_cnt = 1 to rowcount
	This.setitem( ll_cnt, 'task_class_class_time_hour', &
		This.getitemnumber( ll_cnt, 'task_class_class_est_time_hour') )
	This.setitem( ll_cnt, 'task_class_class_time_min', &
		This.getitemnumber( ll_cnt, 'task_class_class_est_time_min') )
next
end event

event itemchanged;call super::itemchanged;long ll_rowcnt, ll_cnt
real lr_hour, lr_min

uo_status.st_message.text = ""
if dwo.name = 'task_class_class_end' then
	ll_rowcnt = dw_1_2.rowcount()
	if data = '1' then
		if ll_rowcnt > 0 then
			lr_hour = This.getitemnumber( row, 'task_class_class_time_hour')
			lr_min  = This.getitemnumber( row, 'task_class_class_time_min')
			for ll_cnt = 1 to ll_rowcnt
				dw_1_2.setitem( ll_cnt, 'manhour_hour', &
					dw_1_2.getitemnumber( ll_cnt, 'manhour_hour' ) + ( lr_hour / ll_rowcnt ) ) 
				dw_1_2.setitem( ll_cnt, 'manhour_second', &
					dw_1_2.getitemnumber( ll_cnt, 'manhour_second' ) + ( lr_min / ll_rowcnt ) )
			next
		end if
	else
		if ll_rowcnt > 0 then
		   lr_hour = This.getitemnumber( row, 'task_class_class_time_hour')
			lr_min  = This.getitemnumber( row, 'task_class_class_time_min')
			for ll_cnt = 1 to ll_rowcnt
				dw_1_2.setitem( ll_cnt, 'manhour_hour', &
					dw_1_2.getitemnumber( ll_cnt, 'manhour_hour' ) - ( lr_hour / ll_rowcnt ) ) 
				dw_1_2.setitem( ll_cnt, 'manhour_second', &
					dw_1_2.getitemnumber( ll_cnt, 'manhour_second' ) - ( lr_min / ll_rowcnt ) )
			next
		end if
	end if
end if

return 0
end event

type dw_property from datawindow within tp_1
event ue_aaa ( )
integer width = 4571
integer height = 392
integer taborder = 30
string title = "none"
string dataobject = "d_task_property"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_aaa();this.setitem(this.getrow(),'status_code','진행중')
end event

event doubleclicked;int	nValue
string sPath, sFile

string ls_data[]

if row <= 0 then return

Choose Case dwo.name 
	Case 'status_code'
		IF f_code_search('d_lookup_status', '', ls_data[]) THEN
			This.SetItem(row, 'status_code', ls_data[1])
			
			string ls_colname
			long ll_find
			datawindowchild ldwc

			ls_colname = dwo.name

			if ls_colname = 'status_code' then
	
				if dw_1.getrow() < 1 then return

				if ls_data[1]='완료' then
					ll_find = dw_1.find(' task_class_class_end = 0' , 1, dw_1.RowCount())					
					if ll_find > 0 then
						messagebox("알림",'현재 작업을 완료할 수 없습니다.')
						this.postevent('ue_aaa')
					end if
				end if

			end if
			
			
		END IF
	Case 'emp_code'
		IF f_code_search('d_lookup_emp', '', ls_data[]) THEN
			This.SetItem(row, 'emp_code', ls_data[1])
		END IF
End Choose		
ib_data_changed = true
end event

event buttonclicked;string ls_return_dt
str_xy str_lxy

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
		this.SetItem(row, 'exam_date', date(ls_return_dt))
		
end choose
end event

event clicked;id_dw_current = this

end event

event dberror;f_show_dberror(sqldbcode)

return 1
end event

event itemchanged;iw_this.TriggerEvent('ue_set_data_changed')

if row <= 0 then return

string ls_colname
long ll_find
datawindowchild ldwc

ls_colname = dwo.name

if ls_colname = 'status_code' then
	
	if dw_1.getrow() < 1 then return

	if data='완료' then
		ll_find = dw_1.find(' task_class_class_end = 0' , 1, dw_1.RowCount())					
		if ll_find > 0 then
			messagebox("알림",'현재 작업을 완료할 수 없습니다.')

			//this.GetChild('status_code', ldwc)
			//this.setcolumn('start_date')
			this.postevent('ue_aaa')
		end if
	end if

end if

if ls_colname='start_date' then

	if isnull(data) or data = '' then
		else
			this.setitem(row,'status_code','진행중')
		end if
end if

if ls_colname='end_date' then

	if isnull(data) or data = '' then
		else
			this.setitem(row,'status_code','완료')
		end if
end if
end event

event rowfocuschanged;if currentrow < 1 then
	id_dw_1.reset()
end if
end event

event getfocus;uo_status.st_message.text = '[등록정보 탭] - 기본정보'
end event

event losefocus;uo_status.st_message.text = ''
end event

type tp_2 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1408
long backcolor = 79741120
string text = "작업지침"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
dw_2_1 dw_2_1
end type

on tp_2.create
this.dw_2=create dw_2
this.dw_2_1=create dw_2_1
this.Control[]={this.dw_2,&
this.dw_2_1}
end on

on tp_2.destroy
destroy(this.dw_2)
destroy(this.dw_2_1)
end on

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

type dw_2_1 from datawindow within tp_2
integer x = 1824
integer width = 1545
integer height = 1396
integer taborder = 50
string title = "none"
string dataobject = "d_equip_guide_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tp_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 4576
integer height = 1408
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
integer width = 4576
integer height = 1412
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

type uo_area from u_cmms_select_area within w_pisf023
event destroy ( )
integer x = 96
integer y = 768
integer taborder = 90
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

type uo_division from u_cmms_select_division within w_pisf023
event destroy ( )
integer x = 96
integer y = 844
integer taborder = 100
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type st_2 from statictext within w_pisf023
integer x = 887
integer y = 1108
integer width = 1632
integer height = 56
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 255
long backcolor = 67108864
string text = "완료는 모든데이타( 품번, 사번 등)를 입력한 뒤에 체크하십시요."
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_pisf023
integer x = 9
integer y = 716
integer width = 681
integer height = 212
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

