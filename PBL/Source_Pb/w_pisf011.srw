$PBExportHeader$w_pisf011.srw
$PBExportComments$업체기본정보윈도우
forward
global type w_pisf011 from w_cmms_sheet01
end type
type dw_group from datawindow within w_pisf011
end type
type ddlb_filter from dropdownlistbox within w_pisf011
end type
type dw_list from uo_datawindow within w_pisf011
end type
type tab_1 from tab within w_pisf011
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
type tab_1 from tab within w_pisf011
tp_1 tp_1
tp_2 tp_2
end type
type uo_area from u_cmms_select_area within w_pisf011
end type
type uo_division from u_cmms_select_division within w_pisf011
end type
type st_2 from statictext within w_pisf011
end type
type gb_1 from groupbox within w_pisf011
end type
end forward

global type w_pisf011 from w_cmms_sheet01
integer width = 4713
integer height = 2736
string title = "업체"
long il_obj_left_y = 58464648
long il_obj_left_height = 58459428
long il_obj_above_x = 58465188
long il_obj_above_width = 58459248
long il_obj_above_y = 58462548
dw_group dw_group
ddlb_filter ddlb_filter
dw_list dw_list
tab_1 tab_1
uo_area uo_area
uo_division uo_division
st_2 st_2
gb_1 gb_1
end type
global w_pisf011 w_pisf011

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

on w_pisf011.create
int iCurrent
call super::create
this.dw_group=create dw_group
this.ddlb_filter=create ddlb_filter
this.dw_list=create dw_list
this.tab_1=create tab_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_group
this.Control[iCurrent+2]=this.ddlb_filter
this.Control[iCurrent+3]=this.dw_list
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.uo_area
this.Control[iCurrent+6]=this.uo_division
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.gb_1
end on

on w_pisf011.destroy
call super::destroy
destroy(this.dw_group)
destroy(this.ddlb_filter)
destroy(this.dw_list)
destroy(this.tab_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.st_2)
destroy(this.gb_1)
end on

event resize;call super::resize;dw_list.width = newwidth - ddlb_filter.WIDTH

tab_1.width = newwidth
//tab_1.height = newheight - 1090
//
tab_1.tp_1.dw_property.width = tab_1.width - 40
tab_1.tp_1.dw_property.height = tab_1.height - 150

tab_1.tp_2.dw_1.height = tab_1.height - 150
tab_1.tp_2.dw_2.width = tab_1.width - 40 - tab_1.tp_2.dw_1.width
tab_1.tp_2.dw_2.height = tab_1.height - 150 

end event

event open;call super::open;ib_saved = false
ib_data_changed = false
long i, ll_row

for i = 1 to 2
	ib_refreshed_tab[i] = false
next

ii_old_tab = 1
ii_current_tab = 1   

id_dw_property = tab_1.tp_1.dw_property
id_dw_1 = tab_1.tp_2.dw_1
id_dw_2 = tab_1.tp_2.dw_2

is_original_sql_list = dw_list.object.datawindow.table.select
is_original_sql_property = id_dw_property.object.datawindow.table.select
is_original_sql_1 = id_dw_1.object.datawindow.table.select
is_original_sql_2 = id_dw_2.object.datawindow.table.select

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  true,  true,  true,  false, false, false, false)
//st_vertical.PostEvent('ue_mouseup')

return 0

end event

event ue_delete;call super::ue_delete;long ll_row
if id_dw_property.getitemstring(id_dw_property.getrow(),'comp_div_code1') = '외주업체' then return
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
id_dw_property.enabled=true
choose case tab_1.selectedTab
	case 1
		ld_dw = id_dw_property
		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		ld_dw.SetFocus()
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
		ls_where = ' ORDER BY comp_master.comp_code'
	case '유형별'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = " where (comp_div_code1='"+ls_code+ "' or comp_div_code2='"+ls_code+ "' or comp_div_code3='"+ls_code+"') ORDER BY comp_master.comp_code"
end choose
		
dw_list.object.datawindow.table.select = is_original_sql_list + ls_where 

dw_list.retrieve()  

dw_list.selectrow(0, false)
dw_list.SetRow(1)
dw_list.selectrow(1, true)

this.triggerevent('ue_retrieve_each_tab')

ib_refreshed_tab[li_current_tab_page] = true





end event

event ue_retrieve_each_tab;call super::ue_retrieve_each_tab;string ls_where, ls_and
long li_current_tab_page

li_current_tab_page = tab_1.SelectedTab

if dw_list.getrow()<1 then
	id_dw_property.reset()
	id_dw_1.reset()
	id_dw_2.reset()
	return
end if
ls_where = ' where comp_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'"
ls_and = ' and comp_part.comp_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),1) + "'"

choose case li_current_tab_page
	case 1  							
		id_dw_property.object.datawindow.table.select = is_original_sql_property + ls_where
		id_dw_property.retrieve()
		id_dw_current = id_dw_property
	case 2  						
		id_dw_1.object.datawindow.table.select = is_original_sql_1 + ls_and
		id_dw_1.retrieve()
		id_dw_2.object.datawindow.table.select = is_original_sql_2 + ls_where
		id_dw_2.retrieve()
end choose

ib_refreshed_tab[li_current_tab_page] = true

end event

event ue_save;call super::ue_save;long ll_row
datawindow ld_dw

string ls_now
//if dw_list.getitemstring(dw_list.getrow(),'comp_div_code1') = '외주업체' then return 1
choose case tab_1.selectedTab
	case 1
		
		if id_dw_property.update() = - 1 then
			return 0
		else
			if id_dw_property.getrow() > 0 then
				ls_now=id_dw_property.getitemstring(id_dw_property.getrow(),'comp_code')
			end if
		end if

	case 2
		
		if id_dw_1.update() = - 1 then
			return 0
		else
			if dw_list.getrow() > 0 then
				ls_now=dw_list.getitemstring(dw_list.getrow(),'comp_code')
			end if
		end if
		if id_dw_2.update() = - 1 then
			return 0
		end if
		
end choose
ib_data_changed = FALSE
this.triggerevent('ue_retrieve')
dw_list.scrolltorow(dw_list.find("comp_code='"+ls_now+"'",1,dw_list.rowcount()))
return 1
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_2.dw_1.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)

id_dw_1.GetChild('part_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
id_dw_1.GetChild('part_code', ldwc)
f_dddw_width(id_dw_1, 'part_code', ldwc, 'part_SPEC', 10)

id_dw_property.GetChild('comp_div_code1', ldwc)
f_dddw_width(id_dw_property, 'comp_div_code1', ldwc, 'comp_div_name', 10)

id_dw_property.GetChild('comp_div_code2', ldwc)
f_dddw_width(id_dw_property, 'comp_div_code2', ldwc, 'comp_div_name', 10)

id_dw_property.GetChild('comp_div_code3', ldwc)
f_dddw_width(id_dw_property, 'comp_div_code3', ldwc, 'comp_div_name', 10)

//uo_1.dw_area.setitem(uo_1.dw_area.getrow(),1,gs_kmarea)
//uo_1.dw_factory.setitem(uo_1.dw_factory.getrow(),1,gs_kmdivision)
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

type uo_status from w_cmms_sheet01`uo_status within w_pisf011
end type

type dw_group from datawindow within w_pisf011
integer y = 88
integer width = 690
integer height = 788
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if currentrow < 1 then
	return 0
end if

This.selectrow(0, false)
This.setrow(currentrow)
This.selectrow(currentrow, true)

parent.triggerevent('ue_retrieve')
end event

type ddlb_filter from dropdownlistbox within w_pisf011
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
string item[] = {"전체목록","유형별"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE this.text
	CASE '유형별'
		dw_group.dataobject = 'd_group_comp_div'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve()		
	CASE '전체목록'
		dw_group.reset()		
		parent.triggerevent('ue_retrieve')
END CHOOSE
end event

type dw_list from uo_datawindow within w_pisf011
integer x = 699
integer width = 3342
integer height = 1076
integer taborder = 10
string dataobject = "d_comp_list"
end type

event rowfocuschanged;call super::rowfocuschanged;
parent.triggerevent('ue_retrieve_each_tab')

int li_count

for li_count = 1 to 2
	ib_refreshed_tab[li_count] = false
next

if this.getrow() < 1 then
	return 0
end if

if this.getitemstring(this.getrow(),'comp_div_code1') ='외주업체' then
	id_dw_property.enabled=false
else
	id_dw_property.enabled=true
end if

return 0
end event

type tab_1 from tab within w_pisf011
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
string dataobject = "d_comp_property"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;id_dw_current = this
end event

event dberror;f_show_dberror(sqldbcode)

return 1
end event

event doubleclicked;int	nValue
string sPath, sFile

string ls_data[]

if row <= 0 then return

Choose Case dwo.name 
	Case 'comp_div_code1'
		IF f_code_search('d_lookup_comp_div', '', ls_data[]) THEN
			This.SetItem(row, 'comp_div_code1', ls_data[1])
		END IF
	Case 'comp_div_code2'
		IF f_code_search('d_lookup_comp_div', '', ls_data[]) THEN
			This.SetItem(row, 'comp_div_code2', ls_data[1])
		END IF
	Case 'comp_div_code3'
		IF f_code_search('d_lookup_comp_div', '', ls_data[]) THEN
			This.SetItem(row, 'comp_div_code3', ls_data[1])
		END IF
End Choose		
ib_data_changed = true
end event

event editchanged;ib_data_changed = true
end event

event itemchanged;ib_data_changed = true

if dwo.name = 'comp_div_code1' then
	if data = '외주업체' then
		messagebox("경고", "업체유형1에 외주업체로 하여 업체를 입력할 수 없습니다.")
		return 1
	end if
end if
end event

type tp_2 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1412
boolean enabled = false
long backcolor = 79741120
string text = "공급물품"
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
integer x = 1947
integer width = 2514
integer height = 1076
integer taborder = 10
string dataobject = "d_comp_02"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

type dw_1 from uo_datawindow within tp_2
integer width = 1938
integer height = 1076
integer taborder = 30
string dataobject = "d_comp_01"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this
end event

event doubleclicked;call super::doubleclicked;str_parm lstr
long ll_upper_bound, i, ll_insert

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
		this.Event ItemChanged(ll_insert, dwo, lstr.s_array[i, 1])
	next
end if
end event

event itemchanged;call super::itemchanged;iw_this.TriggerEvent('ue_set_data_changed')

if row <= 0 then return 0

string ls_colname
datawindowchild ldwc
long ll_row
string ls_part_name
string ls_part_code
long ls_part_value
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
		ls_part_value = ldwc.GetItemnumber(ll_row, 'part_cost')
		this.SetItem(row, 'part_name', ls_part_name)
		this.SetItem(row, 'part_cost', ls_part_value)

	end if
end if

return 0
end event

type uo_area from u_cmms_select_area within w_pisf011
event destroy ( )
integer x = 73
integer y = 904
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

type uo_division from u_cmms_select_division within w_pisf011
event destroy ( )
integer x = 69
integer y = 988
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type st_2 from statictext within w_pisf011
integer x = 635
integer y = 1108
integer width = 1797
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 67108864
string text = "업체유형1에 외주업체인것은 업체를 등록하거나 수정하지 마십시요!"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_pisf011
integer x = 14
integer y = 872
integer width = 677
integer height = 204
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
end type

