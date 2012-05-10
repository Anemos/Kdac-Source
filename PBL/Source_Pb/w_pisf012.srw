$PBExportHeader$w_pisf012.srw
$PBExportComments$인원기본정보
forward
global type w_pisf012 from w_cmms_sheet01
end type
type ddlb_filter from dropdownlistbox within w_pisf012
end type
type tab_1 from tab within w_pisf012
end type
type tp_1 from userobject within tab_1
end type
type dw_property from datawindow within tp_1
end type
type tp_1 from userobject within tab_1
dw_property dw_property
end type
type tp_2 from userobject within tab_1
end type
type dw_2 from uo_datawindow within tp_2
end type
type dw_1 from uo_datawindow within tp_2
end type
type tp_2 from userobject within tab_1
dw_2 dw_2
dw_1 dw_1
end type
type tab_1 from tab within w_pisf012
tp_1 tp_1
tp_2 tp_2
end type
type dw_list from uo_datawindow within w_pisf012
end type
type dw_group from datawindow within w_pisf012
end type
type uo_area from u_cmms_select_area within w_pisf012
end type
type uo_division from u_cmms_select_division within w_pisf012
end type
type gb_1 from groupbox within w_pisf012
end type
end forward

global type w_pisf012 from w_cmms_sheet01
integer width = 4649
integer height = 2744
string title = "인원"
ddlb_filter ddlb_filter
tab_1 tab_1
dw_list dw_list
dw_group dw_group
uo_area uo_area
uo_division uo_division
gb_1 gb_1
end type
global w_pisf012 w_pisf012

type variables
datawindow id_dw_current
datawindow id_dw_property 
datawindow id_dw_1 
datawindow id_dw_2 

string is_original_sql_list 
string is_original_sql_property 
string is_original_sql_1 
string is_original_sql_2 

boolean ib_opened = false
end variables

on w_pisf012.create
int iCurrent
call super::create
this.ddlb_filter=create ddlb_filter
this.tab_1=create tab_1
this.dw_list=create dw_list
this.dw_group=create dw_group
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_filter
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.dw_group
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.gb_1
end on

on w_pisf012.destroy
call super::destroy
destroy(this.ddlb_filter)
destroy(this.tab_1)
destroy(this.dw_list)
destroy(this.dw_group)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_1)
end on

event resize;call super::resize;dw_list.width = newwidth - ddlb_filter.WIDTH

tab_1.width = newwidth
//tab_1.height = newheight - 1090
//
tab_1.tp_1.dw_property.width = tab_1.width - 40
tab_1.tp_1.dw_property.height = tab_1.height - 150

tab_1.tp_2.dw_1.width = tab_1.width - 40
tab_1.tp_2.dw_2.width = tab_1.width - 40 
tab_1.tp_2.dw_2.height = tab_1.height - 150 - tab_1.tp_2.dw_1.height

end event

event open;call super::open;datawindowchild ldwc

ib_saved = false
ib_data_changed = false
long i, ll_row

for i = 1 to 2
	ib_refreshed_tab[i] = false
next

ii_old_tab = 1
ii_current_tab = 1

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_2.dw_1.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)

id_dw_property = tab_1.tp_1.dw_property
id_dw_1 = tab_1.tp_2.dw_1
id_dw_2 = tab_1.tp_2.dw_2

is_original_sql_list = dw_list.object.datawindow.table.select
is_original_sql_property = id_dw_property.object.datawindow.table.select
is_original_sql_1 = id_dw_1.object.datawindow.table.select
is_original_sql_2 = id_dw_2.object.datawindow.table.select

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  true,  true,  true,  false, false, false, false)
end event

event ue_retrieve_each_tab;call super::ue_retrieve_each_tab;string ls_where, ls_and
long li_current_tab_page

li_current_tab_page = tab_1.SelectedTab

if dw_list.getrow() < 1 then 
	id_dw_property.reset()
	id_dw_1.reset()	
	id_dw_2.reset()		
	return
end if
ls_where = ' where emp_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'" &
			+ ' and area_code = ' + "'" + gs_kmarea + "' and factory_code = '" + gs_kmdivision + "'" 

choose case li_current_tab_page
	case 1  	
		id_dw_property.object.datawindow.table.select = is_original_sql_property + ls_where
		id_dw_property.retrieve()
		id_dw_current = id_dw_property
		if id_dw_property.getrow() > 0 then
			id_dw_property.object.p_image.filename=id_dw_property.getitemstring(id_dw_property.getrow(),'pic_path')
		end if
	case 2  						
		id_dw_1.object.datawindow.table.select = is_original_sql_1 + ls_where
		id_dw_1.retrieve()
		id_dw_2.object.datawindow.table.select = is_original_sql_2 + ls_where
		id_dw_2.retrieve()
end choose

ib_refreshed_tab[li_current_tab_page] = true

end event

event ue_insert;call super::ue_insert;long ll_row
datawindow ld_dw

choose case tab_1.selectedTab
	case 1
		ld_dw = id_dw_property
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		id_dw_property.setitem(id_dw_property.getrow(),18,gs_kmarea)
		id_dw_property.setitem(id_dw_property.getrow(),4,gs_kmdivision)
		id_dw_property.object.p_image.filename=''

	case 2
		if dw_list.getrow()<1 then return
		if isnull(id_dw_current) then return
		ld_dw = id_dw_current
		
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
		ld_dw.setitem(ld_dw.getrow(),1,dw_list.getitemstring(dw_list.getrow(),1))

end choose


end event

event ue_save;call super::ue_save;long ll_row
datawindow ld_dw
string ls_now

choose case tab_1.selectedTab
	case 1
		if id_dw_property.update() = -1 then
			return 0
		else
			if id_dw_property.getrow() > 0 then
				ls_now=id_dw_property.getitemstring(id_dw_property.getrow(),'emp_code')
			end if
		end if

	case 2
		if id_dw_1.update() = -1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'emp_code')
			end if
		end if
		if id_dw_2.update() = -1 then
			return 0
		end if		
end choose
ib_data_changed = FALSE
this.triggerevent('ue_retrieve')
dw_list.scrolltorow(dw_list.find("emp_code='"+ls_now+"'",1,dw_list.rowcount()))
return 1
end event

event ue_delete;call super::ue_delete;long ll_row

//ll_row = dw_list.getselectedrow(0)
//if ll_row < 1 then
//	uo_status.st_message.text = "삭제할 데이타를 선택하십시요"
//	return 0
//end if

if not IsNull(id_dw_current) then
	ll_row = id_dw_current.GetRow()
	if ll_row > 0 then
		id_dw_current.DeleteRow(ll_row)
	end if
else
	id_dw_current = tab_1.tp_1.dw_property
	id_dw_current.DeleteRow(1)
end if
ib_data_changed = true
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
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+"' ORDER BY emp_master.emp_code"
	case '부서별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and dept_code='"+ls_code+"' ORDER BY emp_master.emp_code"
	case '과별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and section_code='"+ls_code+"' ORDER BY emp_master.emp_code"
	case '조별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and team_code='"+ls_code+"' ORDER BY emp_master.emp_code"
	case '직급별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and title_code='"+ls_code+"' ORDER BY emp_master.emp_code"
	case '기술별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+ "' and skill_code='"+ls_code+"' ORDER BY emp_master.emp_code"

end choose

dw_list.object.datawindow.table.select = is_original_sql_list + ls_where 
dw_list.retrieve()

dw_list.selectrow(0, false)
dw_list.SetRow(1)
dw_list.selectrow(1, true)

this.triggerevent('ue_retrieve_each_tab')

ib_refreshed_tab[li_current_tab_page] = true





end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_2.dw_1.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)   

// 리스트 dddw 설정
dw_list.GetChild('section_code',ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_list.GetChild('team_code',ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_list.GetChild('title_code',ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_list.GetChild('skill_code',ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

// 개인정보 dddw 설정
id_dw_property.GetChild('team_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('section_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('dept_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('team_code_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('section_code_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('dept_code_1', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve()
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('title_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('skill_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('dept_code', ldwc)
f_dddw_width(id_dw_property, 'dept_code', ldwc, 'dept_name', 10)

id_dw_property.GetChild('section_code', ldwc)
f_dddw_width(id_dw_property, 'section_code', ldwc, 'section_name', 10)

id_dw_property.GetChild('team_code', ldwc)
f_dddw_width(id_dw_property, 'team_code', ldwc, 'team_name', 10)

id_dw_property.GetChild('title_code', ldwc)
f_dddw_width(id_dw_property, 'title_code', ldwc, 'title_name', 10)

id_dw_property.GetChild('skill_code', ldwc)
f_dddw_width(id_dw_property, 'skill_code', ldwc, 'skill_name', 10)

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

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_2.dw_1.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)   

end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf012
end type

type ddlb_filter from dropdownlistbox within w_pisf012
integer width = 690
integer height = 484
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
boolean sorted = false
string item[] = {"전체목록","부서별","과별","조별","직급별","기술별"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE this.text
	CASE '부서별'
		dw_group.dataobject = 'd_group_dept'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve()		
	CASE '과별'
		dw_group.dataobject = 'd_group_section'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea,gs_kmdivision)		
	CASE '조별'
		dw_group.dataobject = 'd_group_cc'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea,gs_kmdivision)		
	CASE '직급별'
		dw_group.dataobject = 'd_group_title'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea,gs_kmdivision)		
	CASE '기술별'
		dw_group.dataobject = 'd_group_skill'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea,gs_kmdivision)		
	CASE '전체목록'
		dw_group.reset()		
		parent.triggerevent('ue_retrieve')
END CHOOSE
end event

type tab_1 from tab within w_pisf012
integer y = 1088
integer width = 4613
integer height = 1524
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tp_1 tp_1
tp_2 tp_2
end type

on tab_1.create
this.tp_1=create tp_1
this.tp_2=create tp_2
this.Control[]={this.tp_1,&
this.tp_2}
end on

on tab_1.destroy
destroy(this.tp_1)
destroy(this.tp_2)
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
integer height = 1412
long backcolor = 79741120
string text = "등록정보"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_property dw_property
end type

on tp_1.create
this.dw_property=create dw_property
this.Control[]={this.dw_property}
end on

on tp_1.destroy
destroy(this.dw_property)
end on

type dw_property from datawindow within tp_1
integer width = 4571
integer height = 1408
integer taborder = 30
string title = "none"
string dataobject = "d_emp_property"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_return_dt
str_xy str_lxy

choose case dwo.name
	case 'b_enter_date'
		str_lxy.lx = iw_This.PointerX()
		str_lxy.ly = iw_This.PointerY() + 350
		openwithparm(w_today,str_lxy)
		If isnull(message.Stringparm) Or message.Stringparm = '' then
			return
		Else
			ls_return_dt = Message.StringParm   // powerobject
		End If	
		this.SetItem(row, 'emp_enter_date', date(ls_return_dt))
		
end choose

ib_data_changed = true
end event

event doubleclicked;int	nValue
string sPath, sFile
string ls_path
string ls_data[]

if row <= 0 then return

Choose Case dwo.name 
	Case 'dept_code'
		IF f_code_search('d_lookup_dept', '', ls_data[]) THEN
			This.SetItem(row, 'dept_code', ls_data[1])
		END IF
	Case 'section_code'
		IF f_code_search('d_lookup_section', '', ls_data[]) THEN
			This.SetItem(row, 'section_code', ls_data[1])
		END IF
	Case 'team_code'
		IF f_code_search('d_lookup_cc', '', ls_data[]) THEN
			This.SetItem(row, 'team_code', ls_data[1])
		END IF
	Case 'title_code'
		IF f_code_search('d_lookup_title', '', ls_data[]) THEN
			This.SetItem(row, 'title_code', ls_data[1])
		END IF		
	Case 'skill_code'
		IF f_code_search('d_lookup_skill', '', ls_data[]) THEN
			This.SetItem(row, 'skill_code', ls_data[1])
		END IF		
	Case 'p_image'

		
//		if gs_kmarea = 'D' and gs_kmdivision = 'A' then
//			ls_path = ProfileString(gs_inifile,"Option","AppPathda",         " ")
//		elseif gs_kmarea = 'D' and gs_kmdivision = 'H' then
//			ls_path = ProfileString(gs_inifile,"Option","AppPathdh",         " ")
//		elseif gs_kmarea = 'D' and gs_kmdivision = 'V' then
//			ls_path = ProfileString(gs_inifile,"Option","AppPathdv",         " ")
//		elseif gs_kmarea = 'D' and gs_kmdivision = 'S' then
//			ls_path = ProfileString(gs_inifile,"Option","AppPathds",         " ")
//		elseif gs_kmarea = 'D' and gs_kmdivision = 'M' then
//			ls_path = ProfileString(gs_inifile,"Option","AppPathdm",         " ")
//		elseif gs_kmarea = 'J'  then
//			ls_path = ProfileString(gs_inifile,"Option","AppPathj",         " ")
//		end if

		ls_path = ProfileString(gs_inifile,"PARAMETER","AppPath", " ")
		nValue = GetFileOpenName("파일 열기", sPath, sFile,"jpg","jpg Files (*.jpg),*.jpg," + "gif Files (*.gif),*.gif,"+"bmp Files (*.bmp),*.bmp")
		
		if nvalue= 1 then

			//if upper(spath) = upper(gs_path+'\'+sfile) then
			//	dw_property.object.p_image.filename = gs_path+'\'+sfile
			//	this.setitem(this.getrow(),17,gs_path+'\'+sfile)
			//end if
			
			nvalue = FileCopy(spath ,ls_path+sfile, true)

			if nvalue= 1 then
				
				dw_property.object.p_image.filename = ls_path+sfile
				
				this.setitem(this.getrow(),'pic_path',ls_path+sfile)

			end if
		end if

End Choose		
ib_data_changed = true
end event

event dberror;f_show_dberror(sqldbcode)

return 1
end event

event clicked;id_dw_current = this
end event

event itemchanged;ib_data_changed = true
end event

event editchanged;ib_data_changed = true
end event

type tp_2 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
long backcolor = 79741120
string text = "교육훈련/ 자격증"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_2 dw_2
dw_1 dw_1
end type

on tp_2.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.dw_1}
end on

on tp_2.destroy
destroy(this.dw_2)
destroy(this.dw_1)
end on

type dw_2 from uo_datawindow within tp_2
integer y = 672
integer width = 2514
integer height = 744
integer taborder = 10
string dataobject = "d_emp_certif"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

event itemchanged;call super::itemchanged;ib_data_changed = true
end event

event editchanged;call super::editchanged;ib_data_changed = true
end event

type dw_1 from uo_datawindow within tp_2
integer width = 4535
integer height = 668
integer taborder = 30
string dataobject = "d_emp_edu"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

event itemchanged;call super::itemchanged;ib_data_changed = true
end event

event editchanged;call super::editchanged;ib_data_changed = true
end event

type dw_list from uo_datawindow within w_pisf012
integer x = 699
integer width = 3342
integer height = 1076
integer taborder = 10
string dataobject = "d_emp_list"
end type

event rowfocuschanged;call super::rowfocuschanged;
parent.triggerevent('ue_retrieve_each_tab')


int li_count

for li_count = 1 to 2
	ib_refreshed_tab[li_count] = false
next
end event

type dw_group from datawindow within w_pisf012
integer y = 84
integer width = 690
integer height = 796
integer taborder = 40
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;selectrow(0, false)
setrow(currentrow)
selectrow(currentrow, true)

parent.triggerevent('ue_retrieve')
end event

type uo_area from u_cmms_select_area within w_pisf012
event destroy ( )
integer x = 87
integer y = 912
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
if f_spacechk(gs_kmdivision) = -1 then
	ls_divisioncode = '%'
else
	ls_divisioncode = gs_kmdivision
end if
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,ls_divisioncode,false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)
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

type uo_division from u_cmms_select_division within w_pisf012
event destroy ( )
integer x = 87
integer y = 988
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

event ue_select;call super::ue_select;parent.triggerevent('ue_postopen')
end event

type gb_1 from groupbox within w_pisf012
integer x = 9
integer y = 860
integer width = 681
integer height = 216
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

