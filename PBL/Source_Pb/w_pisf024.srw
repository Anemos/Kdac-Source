$PBExportHeader$w_pisf024.srw
$PBExportComments$���������̷�
forward
global type w_pisf024 from w_cmms_sheet01
end type
type em_1 from editmask within w_pisf024
end type
type cb_3 from commandbutton within w_pisf024
end type
type cb_2 from commandbutton within w_pisf024
end type
type em_2 from editmask within w_pisf024
end type
type st_2 from statictext within w_pisf024
end type
type st_1 from statictext within w_pisf024
end type
type cb_1 from commandbutton within w_pisf024
end type
type ddlb_filter from dropdownlistbox within w_pisf024
end type
type dw_group from datawindow within w_pisf024
end type
type dw_list from uo_datawindow within w_pisf024
end type
type tab_1 from tab within w_pisf024
end type
type tp_1 from userobject within tab_1
end type
type dw_1_2 from uo_datawindow within tp_1
end type
type dw_1_1 from uo_datawindow within tp_1
end type
type dw_1 from uo_datawindow within tp_1
end type
type dw_property from datawindow within tp_1
end type
type tp_1 from userobject within tab_1
dw_1_2 dw_1_2
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
type tab_1 from tab within w_pisf024
tp_1 tp_1
tp_2 tp_2
tp_3 tp_3
end type
type uo_area from u_cmms_select_area within w_pisf024
end type
type uo_division from u_cmms_select_division within w_pisf024
end type
type gb_1 from groupbox within w_pisf024
end type
type gb_2 from groupbox within w_pisf024
end type
end forward

global type w_pisf024 from w_cmms_sheet01
integer width = 4654
integer height = 2856
string title = "���������̷�"
em_1 em_1
cb_3 cb_3
cb_2 cb_2
em_2 em_2
st_2 st_2
st_1 st_1
cb_1 cb_1
ddlb_filter ddlb_filter
dw_group dw_group
dw_list dw_list
tab_1 tab_1
uo_area uo_area
uo_division uo_division
gb_1 gb_1
gb_2 gb_2
end type
global w_pisf024 w_pisf024

type variables
string is_task_code
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

// FTP ���� 
boolean ib_upOpened = FALSE	//���ε�� ������������ ������ �������� open
Long il_FtpScrollPos

u_cmms_ftp u_ftp

boolean ib_opened = false
end variables

on w_pisf024.create
int iCurrent
call super::create
this.em_1=create em_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.em_2=create em_2
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.ddlb_filter=create ddlb_filter
this.dw_group=create dw_group
this.dw_list=create dw_list
this.tab_1=create tab_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_1
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.em_2
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.ddlb_filter
this.Control[iCurrent+9]=this.dw_group
this.Control[iCurrent+10]=this.dw_list
this.Control[iCurrent+11]=this.tab_1
this.Control[iCurrent+12]=this.uo_area
this.Control[iCurrent+13]=this.uo_division
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
end on

on w_pisf024.destroy
call super::destroy
destroy(this.em_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.em_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.ddlb_filter)
destroy(this.dw_group)
destroy(this.dw_list)
destroy(this.tab_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event resize;call super::resize;dw_list.width = newwidth - ddlb_filter.WIDTH

tab_1.width = newwidth
//tab_1.height = newheight - 1090

tab_1.tp_1.dw_property.width = tab_1.width - 40
tab_1.tp_1.dw_1.width = tab_1.width - tab_1.tp_1.dw_1_1.width - 40
tab_1.tp_1.dw_1.height = tab_1.height - tab_1.tp_1.dw_property.height - 215
tab_1.tp_1.dw_1_1.x=tab_1.tp_1.dw_1.width
tab_1.tp_1.dw_1_2.x=tab_1.tp_1.dw_1.width
tab_1.tp_1.dw_1_1.height = (tab_1.height - tab_1.tp_1.dw_property.height - 215) /2
tab_1.tp_1.dw_1_2.y = tab_1.tp_1.dw_1_1.height + tab_1.tp_1.dw_property.height
tab_1.tp_1.dw_1_2.height = tab_1.height - tab_1.tp_1.dw_property.height - 215 - tab_1.tp_1.dw_1_1.height

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

// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(true,  false,  true,  false,  false, false, false, false)
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
	CASE '��ü���',''
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' and task_hist.area_code = ' +"'"+ls_area+ "' and task_hist.factory_code='"+ls_factory+"' and convert(varchar(10),exam_date,120) between '"+em_1.text+"' and '"+em_2.text +"' ORDER BY task_hist.task_code"
	case '�����ο���'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' and task_hist.area_code = ' +"'"+ls_area+ "' and task_hist.factory_code='"+ls_factory+"' and convert(varchar(10),exam_date,120) between '"+em_1.text+"' and '"+em_2.text + "' and task_hist.emp_code='"+ls_code+"' ORDER BY task_hist.task_code"
	case '�۾����º�'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' and task_hist.area_code = ' +"'"+ls_area+ "' and task_hist.factory_code='"+ls_factory+ "' and task_hist.status_code='"+ls_code+"' and convert(varchar(10),exam_date,120) between '"+em_1.text+"' and '"+em_2.text +"' ORDER BY task_hist.task_code"
	case '���κ�'
		dw_list.object.datawindow.table.select = is_original_sql_list 
		ls_where = ' and task_hist.area_code = ' +"'"+ls_area+ "' and task_hist.factory_code='"+ls_factory+ "' and equip_master.line_code='"+ls_code+"' ORDER BY task_hist.task_code"
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

if dw_list.getrow()<1 then 
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
			+ " and task_hist.area_code='"+gs_kmarea+"' and task_hist.factory_code='"+gs_kmdivision+"'"
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
		id_dw_3.retrieve(gs_kmarea, gs_kmdivision, dw_list.getitemstring(dw_list.getrow(),2))	
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
				ls_now=id_dw_property.getitemstring(id_dw_property.getrow(),'task_hist_task_code')
			end if
		end if
		if id_dw_1.update() = - 1 then
			return 0
		end if
		if id_dw_1_1.update() = - 1 then
			return 0
		end if
		if id_dw_1_2.update() = - 1 then
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
datawindowchild ldwc

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

id_dw_1_1.GetChild('part_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_list.GetChild('status_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_property.GetChild('status_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_1_1.GetChild('part_code', ldwc)
f_dddw_width(id_dw_1_1, 'part_code', ldwc, 'part_spec', 10)

id_dw_1_2.GetChild('emp_code', ldwc)
f_dddw_width(id_dw_1_2, 'emp_code', ldwc, 'emp_name', 10)

id_dw_property.GetChild('status_code', ldwc)
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

		em_1.text=left(ls_return[4],10)
		em_2.text=left(ls_return[4],10)
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

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   
tab_1.tp_1.dw_1.settransobject(sqlcmms) 
tab_1.tp_1.dw_1_1.settransobject(sqlcmms)   
tab_1.tp_1.dw_1_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2.settransobject(sqlcmms)   
tab_1.tp_2.dw_2_1.settransobject(sqlcmms)   
tab_1.tp_3.dw_3.settransobject(sqlcmms) 

// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ��, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(true,  false,  true,  false,  false, false, false, false)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf024
integer x = 0
integer y = 2632
end type

type em_1 from editmask within w_pisf024
integer x = 192
integer width = 402
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean spin = true
end type

event constructor;this.text=string(g_s_date,"@@@@-@@-@@")
end event

type cb_3 from commandbutton within w_pisf024
integer x = 599
integer y = 4
integer width = 87
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
string text = "��"
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

type cb_2 from commandbutton within w_pisf024
integer x = 599
integer y = 96
integer width = 87
integer height = 76
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
string text = "��"
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

type em_2 from editmask within w_pisf024
integer x = 192
integer y = 92
integer width = 402
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy-mm-dd"
boolean spin = true
end type

event constructor;this.text=string(g_s_date,"@@@@-@@-@@")
end event

type st_2 from statictext within w_pisf024
integer x = 105
integer y = 108
integer width = 82
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 33554432
long backcolor = 12632256
string text = "~~"
boolean focusrectangle = false
end type

type st_1 from statictext within w_pisf024
integer x = 23
integer y = 16
integer width = 160
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 33554432
long backcolor = 12632256
string text = "�Ⱓ:"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_pisf024
integer x = 133
integer y = 968
integer width = 421
integer height = 84
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�μ�̸�����"
end type

event clicked;if dw_list.getrow() < 1 then return

string ls_task,ls_div

ls_task=dw_list.getitemstring(dw_list.getrow(),1)
OpenSheet(w_report_preview, w_frame, 0, Layered!)

w_report_preview.dw_report.dataobject = 'dr_task_report_01'
w_report_preview.dw_report.SetTransObject(sqlcmms)

datawindowchild ldwc

//w_report_preview.dw_report.GetChild('task_emp_code', ldwc)
//ldwc.settransobject(sqlcmms)
//ldwc.retrieve(gs_kmarea, gs_kmdivision)
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

type ddlb_filter from dropdownlistbox within w_pisf024
integer y = 184
integer width = 690
integer height = 484
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 33554432
boolean sorted = false
string item[] = {"��ü���","�����ο���","���κ�"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;CHOOSE CASE this.text
	CASE '���κ�'
		dw_group.dataobject = 'd_group_line'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea, gs_kmdivision)
	CASE '�����ο���'
		dw_group.dataobject = 'd_group_emp'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve(gs_kmarea, gs_kmdivision)		
	CASE '�۾����º�'
		dw_group.dataobject = 'd_group_status'
		dw_group.SetTransObject(sqlcmms)
		dw_group.Retrieve()		
	CASE '��ü���'
		dw_group.reset()		
		parent.triggerevent('ue_retrieve')
END CHOOSE
end event

type dw_group from datawindow within w_pisf024
integer y = 268
integer width = 690
integer height = 460
integer taborder = 20
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

type dw_list from uo_datawindow within w_pisf024
integer x = 699
integer width = 3342
integer height = 1076
integer taborder = 10
string dataobject = "d_task_list_01"
end type

event rowfocuschanged;call super::rowfocuschanged;parent.triggerevent('ue_retrieve_each_tab')

int li_count

for li_count = 1 to 3
	ib_refreshed_tab[li_count] = false
next
end event

type tab_1 from tab within w_pisf024
integer y = 1088
integer width = 4613
integer height = 1516
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
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

// �̹� �ֽ� �����͸� ��ȸ���̸� �ٽ� ��ȸ���� �ʴ´�.
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
integer height = 1404
long backcolor = 12632256
string text = "�������"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_1_2 dw_1_2
dw_1_1 dw_1_1
dw_1 dw_1
dw_property dw_property
end type

on tp_1.create
this.dw_1_2=create dw_1_2
this.dw_1_1=create dw_1_1
this.dw_1=create dw_1
this.dw_property=create dw_property
this.Control[]={this.dw_1_2,&
this.dw_1_1,&
this.dw_1,&
this.dw_property}
end on

on tp_1.destroy
destroy(this.dw_1_2)
destroy(this.dw_1_1)
destroy(this.dw_1)
destroy(this.dw_property)
end on

type dw_1_2 from uo_datawindow within tp_1
integer x = 2898
integer y = 872
integer width = 1678
integer height = 492
integer taborder = 50
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

type dw_1_1 from uo_datawindow within tp_1
integer x = 2898
integer y = 396
integer width = 1678
integer height = 488
integer taborder = 30
string dataobject = "d_task_part"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this

long aaa

if dwo.name = 'qty' then
//	if this.getitemnumber(row,4) > 0 then return
//	aaa=messagebox("�˸�",'���縦 �����Ͻðڽ��ϱ�?',Exclamation!, OKCancel!, 2)
//	if aaa=1 then
//		if row <= 0 then return
//
//			string ls_part,ls_wo, ls_equip
//
//			ls_part = this.GetItemString(row, 'part_code')
//			ls_wo = id_dw_property.GetItemString(id_dw_property.getrow(), 'task_hist_task_code')
//			ls_equip=id_dw_property.GetItemString(id_dw_property.getrow(), 'task_hist_equip_code')
//			if ls_part = '' or isnull(ls_part) then
//				MessageBox("�˸�", '���縦 �����ϰ� �ٽ��ѹ� �õ��غ��ʽÿ�.')
//			return
//		end if
//
//		window lw_win
//		str_parm lstr
//		lstr.s_parm[1] = '5'
//		lstr.s_parm[2] = '[�������]-[�������]'
//		lstr.s_parm[3] = ls_part
//		lstr.s_parm[4] = ls_wo
//		lstr.s_parm[5] = ls_equip
//		lstr.s_parm[6] = 'task'
//		OpenSheetwithparm(lw_win,lstr,'w_pisf031',iw_this,0,Layered!)
//	end if
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
integer width = 2880
integer height = 888
integer taborder = 10
string dataobject = "d_task_class"
boolean ib_select_row = false
end type

type dw_property from datawindow within tp_1
event ue_aaa ( )
integer width = 4571
integer height = 392
integer taborder = 30
string title = "none"
string dataobject = "d_task_property_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_aaa();this.setitem(this.getrow(),'status_code','������')
end event

event doubleclicked;int	nValue
string sPath, sFile

string ls_data[]

if row <= 0 then return

Choose Case dwo.name 
	Case 'status_code'
		IF f_code_search('d_lookup_status', '', ls_data[]) THEN
			This.SetItem(row, 'status_code', ls_data[1])
		END IF
	Case 'emp_code'
		IF f_code_search('d_lookup_emp', '', ls_data[]) THEN
			This.SetItem(row, 'comp_emp', ls_data[1])
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

	if data='�Ϸ�' then
		ll_find = dw_1.find(' task_class_class_end = 0' , 1, dw_1.RowCount())					
		if ll_find > 0 then
			messagebox("�˸�",'���� �۾��� �Ϸ��� �� �����ϴ�.')

			//this.GetChild('status_code', ldwc)
			//this.setcolumn('start_date')
			this.postevent('ue_aaa')
		end if
	end if

end if
end event

type tp_2 from userobject within tab_1
integer x = 18
integer y = 96
integer width = 4576
integer height = 1404
long backcolor = 79741120
string text = "�۾���ħ"
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
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tp_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 4576
integer height = 1404
long backcolor = 79741120
string text = "÷������"
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
integer height = 1400
integer taborder = 10
boolean bringtotop = true
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
		MessageBox("Ȯ��", "����Ʈ���� ������ �����ϼ���!!")
		return
	end if
else 
	ls_equip = dw_list.getitemstring(dw_list.getrow(), 'equip_code')
	if isNull(ls_equip) Or ls_equip = '' Then 
		MessageBox("Ȯ��", "����Ʈ���� ��� �����ϼ���!!")
		return
	end if
end if

//FTP ��ü ����
u_ftp = create u_cmms_ftp
If isvalid(u_ftp) = FALSE then 
	ls_msg = "FTP ��ü������ ���������ϴ�.~r~n ��õ��ϼ���!!"
	goto ERR_CLOSE
END IF

// FTP ���� GET
if u_ftp.uf_GetFtpInfo(ls_msg) <> 1 then goto ERR_CLOSE

// FTP ����
if u_ftp.uf_connect(ls_msg) <> 1 then goto ERR_CLOSE

SetPointer(HourGlass!)
Choose Case ls_btnName
	Case 'b_exe'

		uo_status.st_message.text	=	'���� �ٿ�ε� ��.....'
		if u_ftp.uf_exe(ls_fileId, ls_fileNam, ls_msg) <> 1 then goto ERR_CLOSE
		uo_status.st_message.text = '���� �ٿ�ε� �Ϸ�'

	Case 'b_down'

		uo_status.st_message.text	=	'���� �ٿ�ε� ��.....'
		if u_ftp.uf_download(ls_fileId, ls_fileNam, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '���� �ٿ�ε� �Ϸ�'
		
	Case 'b_upload'
			
		uo_status.st_message.text	=	'���� ���� ��.....'
		if u_ftp.uf_Upload(ls_equip, ib_upOpened, ls_fileId, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '���� ���� �Ϸ�'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		// hiright
		this.ScrollToRow(this.Find("File_Id = '" + ls_fileId + "'", 1, this.RowCount()))

	Case 'b_chg'
		uo_status.st_message.text = '���ϸ� ���� ��.....'
		//���ϸ� ����
		if u_ftp.uf_chg(ls_fileId, ls_fileNam, ls_fileDesc, ls_msg) = -1 then goto ERR_CLOSE
		uo_status.st_message.text = '���� �Ϸ�..'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		// hiright
		this.ScrollToRow(this.Find("File_Id = '" + ls_fileId + "'", 1, this.RowCount()))
	Case 'b_del'
		uo_status.st_message.text = '���� ���� ��.....'
		// ���� ����
		if u_ftp.uf_Del(ls_fileId, ls_fileNam, ls_msg) = -1 Then goto ERR_CLOSE
		uo_status.st_message.text = '���� ���� �Ϸ�'
		// REFRISH
		dw_list.Triggerevent('rowfocuschanged')
		
End Choose

SetPointer(Arrow!)
u_ftp.uf_disconnect()
DESTROY u_ftp
SetNull(u_ftp)
return

ERR_CLOSE:
	MessageBox("Ȯ��", ls_msg)
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
//		nValue = GetFileSaveName("÷������ ����", sPath, sFile)
//		if nvalue= 1 then
//
//			nvalue = FileCopy (spath ,ls_path+sfile, false)
//
//			if nvalue= 1 then
//				this.setitem(this.getrow(),2,ls_path+sfile)
//			else
//				
//				messagebox("�˸�","���� ������ �����մϴ�. �ٸ� �̸����� �����մϴ�.") 
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

type uo_area from u_cmms_select_area within w_pisf024
integer x = 87
integer y = 760
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

type uo_division from u_cmms_select_division within w_pisf024
integer x = 87
integer y = 840
integer taborder = 40
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type gb_1 from groupbox within w_pisf024
integer y = 928
integer width = 690
integer height = 148
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "����"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisf024
integer x = 9
integer y = 712
integer width = 677
integer height = 216
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

