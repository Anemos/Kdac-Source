$PBExportHeader$w_pisf013.srw
$PBExportComments$코드관리윈도우
forward
global type w_pisf013 from w_cmms_sheet01
end type
type st_vertical from statictext within w_pisf013
end type
type dw_equiptypetree from datawindow within w_pisf013
end type
type dw_locationtree from datawindow within w_pisf013
end type
type st_horizontal from statictext within w_pisf013
end type
type dw_module from datawindow within w_pisf013
end type
type dw_items from datawindow within w_pisf013
end type
type st_vertical_treeview from statictext within w_pisf013
end type
type dw_tv_source from datawindow within w_pisf013
end type
type tab_code from tab within w_pisf013
end type
type tp_list from userobject within tab_code
end type
type dw_div_b_code from uo_datawindow within tp_list
end type
type dw_list from uo_datawindow within tp_list
end type
type dw_div_a_code from uo_datawindow within tp_list
end type
type tp_list from userobject within tab_code
dw_div_b_code dw_div_b_code
dw_list dw_list
dw_div_a_code dw_div_a_code
end type
type tp_property from userobject within tab_code
end type
type mle_descript from multilineedit within tp_property
end type
type dw_property from datawindow within tp_property
end type
type sle_code from singlelineedit within tp_property
end type
type sle_descript from singlelineedit within tp_property
end type
type st_code from statictext within tp_property
end type
type tp_property from userobject within tab_code
mle_descript mle_descript
dw_property dw_property
sle_code sle_code
sle_descript sle_descript
st_code st_code
end type
type tab_code from tab within w_pisf013
tp_list tp_list
tp_property tp_property
end type
type tv_code from treeview within w_pisf013
end type
type uo_area from u_cmms_select_area within w_pisf013
end type
type uo_division from u_cmms_select_division within w_pisf013
end type
end forward

global type w_pisf013 from w_cmms_sheet01
string title = "코드관리"
event ue_first_retrieve_equiplocationtree ( )
event ue_first_retrieve_equiptypetree ( )
event ue_save_treecode ( )
st_vertical st_vertical
dw_equiptypetree dw_equiptypetree
dw_locationtree dw_locationtree
st_horizontal st_horizontal
dw_module dw_module
dw_items dw_items
st_vertical_treeview st_vertical_treeview
dw_tv_source dw_tv_source
tab_code tab_code
tv_code tv_code
uo_area uo_area
uo_division uo_division
end type
global w_pisf013 w_pisf013

type variables
long il_oldhandle

boolean ib_delete_from_database = true
boolean ib_lbuttondown

string is_dwname
string is_safemancode
string is_safeman
string is_manualcode
string is_manual
string is_sparepartcode

datawindow id_dw_property
datawindow id_dw_current

boolean ib_opened = false


end variables

forward prototypes
public subroutine wf_resize_dw_one (datawindow adw_one)
public subroutine wf_resize_dw_two (datawindow adw_one, datawindow adw_two)
end prototypes

event ue_first_retrieve_equiplocationtree();TreeViewItem ltvitem
long ll_find
long ll_rowcount
long ll_inserted
string ls_descript

dw_tv_source.dataobject = 'd_equiplocation_for_tree'
dw_tv_source.SetTransObject(sqlcmms)
dw_tv_source.Retrieve()

dw_locationtree.SetTransObject(sqlcmms)
dw_locationtree.retrieve()

ib_delete_from_database = false
tv_code.deleteitem(0)  // root 아이템을 지워 트리를 clear한다.
ib_delete_from_database = true

ll_rowcount = dw_locationtree.RowCount()

if ll_rowcount <= 0 then return

ll_find = dw_locationtree.find(" parentcode = '' or isnull(parentcode) ", 1, ll_rowcount)
DO WHILE ll_find > 0 
	ls_descript = dw_locationtree.GetItemString(ll_find, 'location_descript')
	ltvitem.pictureindex = 1
	ltvitem.label = ls_descript
	ltvitem.SelectedPictureIndex = 1
	ltvitem.children = true

	ll_inserted = tv_code.InsertItemLast(0, ltvitem) 
	tv_code.expandall(ll_inserted)
	
	ll_find = dw_locationtree.find(" parentcode = '' or isnull(parentcode) ", ll_find+1, ll_rowcount)
	if ll_find > ll_rowcount then exit
LOOP

end event

event ue_first_retrieve_equiptypetree();TreeViewItem ltvitem
long ll_find
long ll_rowcount
long ll_inserted
string ls_descript

dw_tv_source.dataobject = 'd_equiptype_for_tree'
dw_tv_source.SetTransObject(sqlcmms)
dw_tv_source.Retrieve()

dw_equiptypetree.SetTransObject(sqlcmms)
dw_equiptypetree.retrieve()

ib_delete_from_database = false
tv_code.deleteitem(0)  // root 아이템을 지워 트리를 clear한다.
ib_delete_from_database = true

ll_rowcount = dw_equiptypetree.RowCount()

if ll_rowcount <= 0 then return

ll_find = dw_equiptypetree.find(" parentcode = '' or isnull(parentcode) ", 1, ll_rowcount)
DO WHILE ll_find > 0 
	ls_descript = dw_equiptypetree.GetItemString(ll_find, 'equiptype_descript')
	ltvitem.pictureindex = 1
	ltvitem.label = ls_descript
	ltvitem.SelectedPictureIndex = 1
	ltvitem.children = true

	ll_inserted = tv_code.InsertItemLast(0, ltvitem) 
	tv_code.expandall(ll_inserted)
	
	ll_find = dw_equiptypetree.find(" parentcode = '' or isnull(parentcode) ", ll_find+1, ll_rowcount)
	if ll_find > ll_rowcount then exit
LOOP

end event

event ue_save_treecode();if dw_tv_source.dataobject = 'd_equiptype_for_tree' then
	wf_update_datawindow_tab(dw_equiptypetree,9)
elseif dw_tv_source.dataobject = 'd_equiplocation_for_tree' then
	wf_update_datawindow_tab(dw_locationtree,9)
end if


end event

public subroutine wf_resize_dw_one (datawindow adw_one);adw_one.width = tab_code.width - 45
adw_one.height = tab_code.height - 135
end subroutine

public subroutine wf_resize_dw_two (datawindow adw_one, datawindow adw_two);adw_one.width = tab_code.width - 45
//adw_one.height = tab_code.height - 156

adw_two.width = tab_code.width - 45

adw_two.height = tab_code.height - 156 - adw_one.height
end subroutine

on w_pisf013.create
int iCurrent
call super::create
this.st_vertical=create st_vertical
this.dw_equiptypetree=create dw_equiptypetree
this.dw_locationtree=create dw_locationtree
this.st_horizontal=create st_horizontal
this.dw_module=create dw_module
this.dw_items=create dw_items
this.st_vertical_treeview=create st_vertical_treeview
this.dw_tv_source=create dw_tv_source
this.tab_code=create tab_code
this.tv_code=create tv_code
this.uo_area=create uo_area
this.uo_division=create uo_division
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_vertical
this.Control[iCurrent+2]=this.dw_equiptypetree
this.Control[iCurrent+3]=this.dw_locationtree
this.Control[iCurrent+4]=this.st_horizontal
this.Control[iCurrent+5]=this.dw_module
this.Control[iCurrent+6]=this.dw_items
this.Control[iCurrent+7]=this.st_vertical_treeview
this.Control[iCurrent+8]=this.dw_tv_source
this.Control[iCurrent+9]=this.tab_code
this.Control[iCurrent+10]=this.tv_code
this.Control[iCurrent+11]=this.uo_area
this.Control[iCurrent+12]=this.uo_division
end on

on w_pisf013.destroy
call super::destroy
destroy(this.st_vertical)
destroy(this.dw_equiptypetree)
destroy(this.dw_locationtree)
destroy(this.st_horizontal)
destroy(this.dw_module)
destroy(this.dw_items)
destroy(this.st_vertical_treeview)
destroy(this.dw_tv_source)
destroy(this.tab_code)
destroy(this.tv_code)
destroy(this.uo_area)
destroy(this.uo_division)
end on

event open;call super::open;long ll_row
datawindowchild ldwc

ib_saved = false
ib_data_changed = false
long i
for i = 1 to 7
	ib_refreshed_tab[i] = false
next

ii_old_tab = 1
ii_current_tab = 1

tab_code.tp_list.dw_list.settransobject(sqlcmms)   // 계약목록 페이지 데이터 윈도우
tab_code.tp_property.dw_property.SetTransObject(sqlcmms) // 등록정보 페이지 데이터윈도우

id_dw_list = tab_code.tp_list.dw_list
id_dw_property = tab_code.tp_property.dw_property

st_vertical.triggerevent('ue_mouseup')
st_horizontal.triggerevent('ue_mouseup')

ll_row = dw_module.InsertRow(0)
dw_module.SetItem(ll_row, 'smodule', '조직')
ll_row = dw_module.InsertRow(0)
dw_module.SetItem(ll_row, 'smodule', '장비')
ll_row = dw_module.InsertRow(0)
dw_module.SetItem(ll_row, 'smodule', '업체')
ll_row = dw_module.InsertRow(0)
dw_module.SetItem(ll_row, 'smodule', '작업관리')
//ll_row = dw_module.InsertRow(0)
//dw_module.SetItem(ll_row, 'smodule', '자재')
//ll_row = dw_module.InsertRow(0)
//dw_module.SetItem(ll_row, 'smodule', '기타')
ll_row = dw_module.InsertRow(0)
dw_module.SetItem(ll_row, 'smodule', '전체목록')

dw_module.Post Event RowFocusChanged(1)

st_vertical.PostEvent('ue_mouseup')
st_horizontal.PostEvent('ue_mouseup')

//id_dw_property.GetChild('PARTCODE', ldwc)
//f_dddw_width(id_dw_property, 'PARTCODE', ldwc, 'descript', 10)
//
//id_dw_property.GetChild('LOCATION', ldwc)
//f_dddw_width(id_dw_property, 'LOCATION', ldwc, 'DESCRIPT', 10)
//

end event

event resize;call super::resize;tab_code.width = this.width - tab_code.x - 47
tab_code.height = this.height - tab_code.y - 230

tv_code.height = this.height - tv_code.y - 230
dw_tv_source.height = this.height - tv_code.y - 230
dw_tv_source.width = this.width - dw_tv_source.x - 47


dw_items.height = this.height - dw_items.y - 230
st_vertical.height = this.height - st_vertical.y - 230
st_vertical_treeview.height = this.height - st_vertical_treeview.y - 230

wf_resize_dw_one (tab_code.tp_list.dw_list)
wf_resize_dw_one (tab_code.tp_property.dw_property)

tab_code.tp_property.mle_descript.width = this.width - tab_code.x - 67
tab_code.tp_property.mle_descript.height = tab_code.height - 396

tab_code.tp_list.dw_div_b_code.width = tab_code.width -tab_code.tp_list.dw_div_a_code.width - 45

tab_code.tp_list.dw_div_a_code.height = tab_code.height - 135
tab_code.tp_list.dw_div_b_code.height = tab_code.height - 135
end event

event ue_delete;call super::ue_delete;long ll_row

if IsValid(id_dw_current) then
	ll_row = id_dw_current.GetRow()
	
	if ll_row > 0 then
		id_dw_current.DeleteRow(ll_row)
	end if
	
	ib_data_changed = true
end if
	
end event

event ue_insert;call super::ue_insert;long ll_row
datawindow ld_dw
string ls_lawname, ls_article

choose case tab_code.selectedTab
	case 1 
		id_dw_current = id_dw_list
		ll_row = id_dw_current.InsertRow(0)
		id_dw_current.SetRow(ll_row)
		id_dw_current.ScrollToRow(ll_row)
		id_dw_current.SetFocus()
		
		if is_dwname = 'd_sys_code_dept' or is_dwname = 'd_sys_code_comp_div' or &
			is_dwname = 'd_sys_code_equip_div_b' then
			// 지역,공장 설정안함
		else
			id_dw_list.SetItem(ll_row,'area_code', gs_kmarea)
			id_dw_list.SetItem(ll_row,'factory_code', gs_kmdivision)
		end if
		
		if is_dwname = 'd_sys_code_equip_div_b' then
			ll_row=tab_code.tp_list.dw_div_b_code.InsertRow(0)
			tab_code.tp_list.dw_div_b_code.SetRow(ll_row)
			tab_code.tp_list.dw_div_b_code.ScrollToRow(ll_row)
			tab_code.tp_list.dw_div_b_code.SetFocus()
			tab_code.tp_list.dw_div_b_code.SetItem(ll_row,'area_code',gs_kmarea)
			tab_code.tp_list.dw_div_b_code.SetItem(ll_row,'factory_code',gs_kmdivision)
			tab_code.tp_list.dw_div_b_code.SetItem(ll_row,'equip_div_a_code',tab_code.tp_list.dw_div_a_code.getitemstring(tab_code.tp_list.dw_div_a_code.getrow(),1))
		end if
		
	case 2
		if is_dwname = 'd_sys_code_sparepart' then
			id_dw_current = id_dw_property
			ll_row = id_dw_current.InsertRow(0)
			id_dw_current.SetItem(ll_row, 'spcode', is_sparepartcode)
			id_dw_current.SetRow(ll_row)
			id_dw_current.ScrollToRow(ll_row)
			id_dw_current.SetFocus()		
		end if

end choose



end event

event ue_print;call super::ue_print;long Job
integer li_return

li_return = MessageBox("알림", '현재 페이지를 인쇄하겠습니까?', Exclamation!, OKCancel!, 2)
IF li_return = 1 THEN
	// process ok
	OpenwithParm(w_dw_print,id_dw_current)
//	Job = PrintOpen( )
//
//	if is_dwname = 'd_equiplocation_for_tree' or is_dwname = 'd_equiptype_for_tree' then 
//		tv_code.Print(Job, tv_code.x, tv_code.y)
//	else
//		tab_code.Print(Job, tab_code.x,tab_code.y)
//	end if
//	
//	PrintClose(Job)
ELSE
   // Process CANCEL.
END IF






end event

event ue_retrieve_each_tab;call super::ue_retrieve_each_tab;long li_current_tab_page, ll_row
long ll_find
string ls_where, ls_orgsql, ls_where2
li_current_tab_page = tab_code.SelectedTab

if is_dwname = '' or isnull(is_dwname) then
	return // datawindow 이름이 없으면 return
end if

ls_where= " where area_code='"+gs_kmarea+"' and factory_code='"+gs_kmdivision+"'"
ls_where2= " where wo_autonumber.area_code='"+gs_kmarea+"' and wo_autonumber.factory_code='"+gs_kmdivision+"'"
// 설비유형 및 location 트리 구성관련 컨트롤 display
choose case is_dwname
	case 'd_equiplocation_for_tree'
		tab_code.visible = false
		if not tv_code.visible then tv_code.visible = true
		if not dw_tv_source.visible then dw_tv_source.visible = true
		dw_locationtree.SetTransObject(sqlcmms)
		dw_locationtree.Retrieve()
		this.TriggerEvent('ue_first_retrieve_equiplocationtree')
		st_vertical.visible = true // 수직 split바를 트리뷰 컨트롤보다 위에 나타내기 위해 
		st_vertical_treeview.visible = true
		st_vertical_treeview.TriggerEvent('ue_mouseup')
	
	case 'd_equiptype_for_tree'
		tab_code.visible = false
		if not tv_code.visible then tv_code.visible = true
		this.TriggerEvent('ue_first_retrieve_equiptypetree')
		if not dw_tv_source.visible then dw_tv_source.visible = true
		st_vertical.visible = true // 수직 split바를 트리뷰 컨트롤보다 위에 나타내기 위해 
		st_vertical_treeview.visible = true
		st_vertical_treeview.TriggerEvent('ue_mouseup')
	case else
		if not tab_code.visible then tab_code.visible = true
		if tv_code.visible then tv_code.visible = false
		if dw_tv_source.visible then dw_tv_source.visible = false
		st_vertical.visible = true // 수직 split바를 다른 컨트롤보다 위에 나타내기 위해 
		st_vertical_treeview.visible = false
end choose

if  is_dwname = 'd_sys_code_equip_div_b' then
	tab_code.tp_list.dw_list.visible = false
	tab_code.tp_list.dw_div_a_code.visible = true
	tab_code.tp_list.dw_div_b_code.visible = true
	tab_code.tp_list.dw_div_a_code.dataobject = 'd_sys_code_equip_div_aa'
	tab_code.tp_list.dw_div_b_code.dataobject = is_dwname
	tab_code.tp_list.dw_div_b_code.SetTransObject(sqlcmms)
	
	tab_code.tp_list.dw_div_a_code.settransobject(sqlcmms)
	ls_orgsql = tab_code.tp_list.dw_div_a_code.object.datawindow.table.select
	tab_code.tp_list.dw_div_a_code.object.datawindow.table.select = ls_orgsql + ls_where
	tab_code.tp_list.dw_div_a_code.retrieve()
	tab_code.tp_list.dw_div_a_code.object.datawindow.table.select = ls_orgsql
	
//	if tab_code.tp_list.dw_div_a_code.getrow()<1 then return
//		ls_where = ' and equip_div_b.equip_div_a_code = ' + "'" + tab_code.tp_list.dw_div_a_code.getitemstring(tab_code.tp_list.dw_div_a_code.getrow(),1) + "'"
//		tab_code.tp_list.dw_div_b_code.object.datawindow.table.select = tab_code.tp_list.dw_div_b_code.object.datawindow.table.select + ls_where
//		//ls_where2 = tab_code.tp_list.dw_div_b_code.object.datawindow.table.select
//	tab_code.tp_list.dw_div_b_code.retrieve()
//	id_dw_current=tab_code.tp_list.dw_div_a_code
//
// tab_code.tp_list.dw_div_b_code.object.datawindow.table.select = ''
// ls_where = ''
//
//		if id_dw_list.RowCount() > 0 then
//			id_dw_list.Post Event RowFocusChanged(1)
//			id_dw_list.Post Event GetFocus()
//		end if

elseif li_current_tab_page = 1 then
	
		if not tab_code.tp_list.dw_list.visible then tab_code.tp_list.dw_list.visible = true
		if tab_code.tp_list.dw_div_a_code.visible then tab_code.tp_list.dw_div_a_code.visible = false
		if tab_code.tp_list.dw_div_b_code.visible then tab_code.tp_list.dw_div_b_code.visible = false

	
	id_dw_list.dataobject = is_dwname

	if is_dwname='d_sys_code_wo_autono' then
		id_dw_list.settransobject(sqlcmms)
		ls_orgsql = id_dw_list.object.datawindow.table.select
		id_dw_list.object.datawindow.table.select = ls_orgsql + ls_where2
		id_dw_list.retrieve()
		id_dw_list.object.datawindow.table.select = ls_orgsql
//	elseif is_dwname='d_sys_code_except_time1' then
//		id_dw_list.settransobject(sqlcmms)
//		ls_orgsql = id_dw_list.object.datawindow.table.select
//		id_dw_list.object.datawindow.table.select = ls_orgsql + ls_where
//		id_dw_list.retrieve()
//		id_dw_list.object.datawindow.table.select = ls_orgsql
//	elseif is_dwname = 'd_sys_code_line' then
//		id_dw_list.settransobject(sqlcmms)
//		ls_orgsql = id_dw_list.object.datawindow.table.select
//		id_dw_list.object.datawindow.table.select = ls_orgsql + ls_where
//		id_dw_list.retrieve()
//		id_dw_list.object.datawindow.table.select = ls_orgsql
	elseif is_dwname = 'd_sys_code_dept' or is_dwname = 'd_sys_code_comp_div' &
			or is_dwname = 'd_sys_code_comp_div' then
		id_dw_list.SetTransObject(sqlcmms)
		id_dw_list.retrieve()
	else
		id_dw_list.settransobject(sqlcmms)
		ls_orgsql = id_dw_list.object.datawindow.table.select
		id_dw_list.object.datawindow.table.select = ls_orgsql + ls_where
		id_dw_list.retrieve()
		id_dw_list.object.datawindow.table.select = ls_orgsql
	end if
	
	
	if id_dw_list.RowCount() > 0 then
		id_dw_list.Post Event RowFocusChanged(1)
		id_dw_list.Post Event GetFocus()
	end if

	choose case is_dwname
//		case 'd_sys_code_sparepart'
//			tab_code.tp_property.visible = true
//			id_dw_property.visible = true
//		case 'd_sys_code_safeman'
//			tab_code.tp_property.visible = true
//			tab_code.tp_property.mle_descript.visible = true
//		case 'd_sys_code_manual'
//			tab_code.tp_property.visible = true
//			tab_code.tp_property.mle_descript.visible = true
		case 'd_sys_code_task_nextwono'
			if id_dw_list.RowCount() <= 0 then
				id_dw_list.InsertRow(0)
				id_dw_list.SetItem(1, 'notype', 'TASK')
				id_dw_list.SetItem(1, 'noname', 'NEXTWONO')
				id_dw_list.SetItem(1, 'descript', '예방정비에서 작업지시 생성시 사용')
				id_dw_list.SetItem(1, 'nextno', 'WO-PM-00001')
				id_dw_list.update()
			end if		
		case else
			tab_code.tp_property.visible = false
	end choose
//elseif li_current_tab_page = 2 then
//	choose case is_dwname
//		case 'd_sys_code_sparepart'
//			tab_code.tp_property.visible = true
//			tab_code.tp_property.st_code.Text = 'Spare Part:'
//			tab_code.tp_property.sle_code.Text = is_sparepartcode
//			tab_code.tp_property.sle_descript.Text = is_descript
//			tab_code.tp_property.mle_descript.visible = false
//			id_dw_property.visible = true
//			id_dw_property.Retrieve(is_sparepartcode)
//		case 'd_sys_code_safeman'
//			tab_code.tp_property.visible = true
//			tab_code.tp_property.st_code.Text = '안전지침:'
//			tab_code.tp_property.sle_code.Text = is_safemancode
//			tab_code.tp_property.sle_descript.Text = is_descript
//			tab_code.tp_property.mle_descript.Text = is_safeman
//			tab_code.tp_property.mle_descript.visible = true
//			id_dw_property.visible = false
//		case 'd_sys_code_manual'
//			tab_code.tp_property.visible = true
//			tab_code.tp_property.st_code.Text = '작업지침:'
//			tab_code.tp_property.sle_code.Text = is_manualcode
//			tab_code.tp_property.sle_descript.Text = is_descript
//			tab_code.tp_property.mle_descript.Text = is_manual
//			tab_code.tp_property.mle_descript.visible = true
//			id_dw_property.visible = false
//		case else
//			tab_code.tp_property.visible = false
//	end choose
end if
ib_refreshed_tab[li_current_tab_page] = true
ib_data_changed = false
this.TriggerEvent('ue_set_buttons')
end event

event ue_retrieve;call super::ue_retrieve;This.TriggerEvent('ue_Retrieve_each_tab')
end event

event ue_save;call super::ue_save;long 			ll_row 
long 			ll_i
long 			ll_find
datawindow 	ld_dw
string 		ls_dwname
string 		ls_safeman
string 		ls_safemancode

if tab_code.visible = true then

	choose case tab_code.SelectedTab
		case 1 
			ld_dw = id_dw_list
			ld_dw.AcceptText()
			wf_update_datawindow_tab(ld_dw,9)
			if id_dw_list.GetRow() > 0 then
				id_dw_list.Event Trigger RowFocusChanged(id_dw_list.GetRow())
			end if
			
			choose case is_dwname
				case 'd_sys_code_equip_div_b'
					wf_update_datawindow_tab(tab_code.tp_list.dw_div_b_code,9)
//					tab_code.tp_list.dw_div_b_code.update()
					
			end choose
			
		case 2
//			choose case is_dwname
//				case 'd_sys_code_safeman'
//					is_safeman = tab_code.tp_property.mle_descript.text
//					update TMSTSAFEMAN
//						set SAFEMAN = :is_safeman 
//					 where SAFEMANCODE = :is_safemancode;
//					commit;
//					id_dw_list.retrieve()
//					if id_dw_list.RowCount() > 0 then
//						ll_find = id_dw_list.find(' safemancode = ' + "'" + tab_code.tp_property.sle_code.text + "'", 1, id_dw_list.RowCount())					
//						if ll_find > 0 then
//							id_dw_list.Event Trigger RowFocusChanged(ll_find)
//						end if
//					end if
//				case 'd_sys_code_sparepart'
//					ld_dw = id_dw_property
//					ll_row = ld_dw.find("isnull(spcode) or spcode = '' or partcode = '' or isnull(partcode)", &
//											1, ld_dw.Rowcount() )
//					do while ll_row > 0 
//						ld_dw.deleterow(ll_row)
//						ll_row = ld_dw.find("isnull(spcode) or spcode = '' or partcode = '' or isnull(partcode)", &
//											1, ld_dw.Rowcount() )
//					loop
//					if ld_dw.update() <> 1 then	
//						tab_code.SelectedTab = ii_old_tab
//						messagebox("알림", '데이터 저장 에러. 시스템 관리자에게 문의 하십시오!')
//						ib_data_changed = false
//						return 0
//					end if
//					commit;				
//					id_dw_list.retrieve()
//					if id_dw_list.RowCount() > 0 then
//						ll_find = id_dw_list.find(' spcode = ' + "'" + tab_code.tp_property.sle_code.text + "'", 1, id_dw_list.RowCount())					
//						if ll_find > 0 then
//							id_dw_list.Event Trigger RowFocusChanged(ll_find)
//						end if
//					end if
//				case 'd_sys_code_manual'				
//					is_manual = tab_code.tp_property.mle_descript.text
//					update TMSTMANUAL
//						set TASKMANUAL = :is_manual
//					 where MANUALCODE = :is_manualcode;
//					commit;				
//					id_dw_list.retrieve()
//					if id_dw_list.RowCount() > 0 then
//						ll_find = id_dw_list.find(' manualcode = ' + "'" + tab_code.tp_property.sle_code.text + "'", 1, id_dw_list.RowCount())					
//						if ll_find > 0 then
//							id_dw_list.Event Trigger RowFocusChanged(ll_find)
//						end if
//					end if
//			end choose
	end choose
end if  // if tab_code is visible

if tv_code.visible = true then
	TriggerEvent('ue_save_treecode')
end if

for ll_i = 1 to 2
	ib_refreshed_tab[ll_i] = false
next
ib_data_changed = false

return 1


end event

event ue_set_not_refreshed();call super::ue_set_not_refreshed;int li_count

for li_count = 1 to 7
	ib_refreshed_tab[li_count] = false
next
	
end event

event ue_postopen;call super::ue_postopen;this.triggerevent('ue_retrieve')

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

tab_code.tp_list.dw_list.settransobject(sqlcmms)   // 계약목록 페이지 데이터 윈도우
tab_code.tp_property.dw_property.SetTransObject(sqlcmms) // 등록정보 페이지 데이터윈도우
dw_tv_source.SetTransObject(sqlcmms)
dw_locationtree.SetTransObject(sqlcmms)
dw_equiptypetree.SetTransObject(sqlcmms)

end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf013
end type

type st_vertical from statictext within w_pisf013
event ue_mousedown pbm_lbuttondown
event ue_mousemove pbm_mousemove
event ue_mouseup pbm_lbuttonup
integer x = 750
integer width = 18
integer height = 1928
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string pointer = "Ve_split.cur"
long textcolor = 12632256
long backcolor = 12632256
boolean focusrectangle = false
end type

event ue_mousemove;if KeyDown(keyLeftButton!) Then
		This.X = Parent.PointerX()
End If

end event

event ue_mouseup;dw_module.width = this.x - dw_module.x
dw_items.width = this.x - dw_items.x
st_horizontal.width = this.x - st_horizontal.x

tab_code.x = this.x + this.width

tv_code.x = this.x + this.width

st_vertical_treeview.TriggerEvent('ue_mouseup')
//parent.postevent('resize')

end event

type dw_equiptypetree from datawindow within w_pisf013
boolean visible = false
integer y = 1244
integer width = 297
integer height = 444
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_equiptypetree"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;f_show_dberror(sqldbcode)

return 1
end event

type dw_locationtree from datawindow within w_pisf013
boolean visible = false
integer x = 27
integer y = 1312
integer width = 2011
integer height = 560
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_locationtree"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;f_show_dberror(sqldbcode)

return 1
end event

type st_horizontal from statictext within w_pisf013
event ue_mousedown pbm_lbuttondown
event ue_mousemove pbm_mousemove
event ue_mouseup pbm_lbuttonup
integer y = 936
integer width = 526
integer height = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string pointer = "Ho_split.cur"
long textcolor = 33554432
long backcolor = 12632256
boolean focusrectangle = false
end type

event ue_mousemove;if KeyDown(keyLeftButton!) Then
		This.y = Parent.PointerY()
End If

end event

event ue_mouseup;dw_module.height = this.y - dw_module.y
dw_items.y = this.y + this.height
dw_items.height = parent.height - dw_items.y - 188



end event

type dw_module from datawindow within w_pisf013
integer x = 14
integer y = 216
integer width = 731
integer height = 724
integer taborder = 10
string dataobject = "d_lookup_module"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	this.SelectRow(0, false)
	this.SetRow(row)
	this.SelectRow(row, true)
end if
end event

event rowfocuschanged;string ls_module
long ll_row 

if CurrentRow > 0 then
	selectrow(0,false)
	setrow(CurrentRow)
	selectrow(CurrentRow, true)
	ls_module = GetItemString(CurrentRow, 'smodule')
end if

dw_items.SetRedraw(false)

choose case ls_module
	case '장비'
		dw_items.reset()
		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '설비유형 트리')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_equiptype_for_tree')

		//ll_row = dw_items.insertrow(0)
		//dw_items.SetItem(ll_row, 'sitems', '장비구분')
		//dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_div')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '점검개소')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_team')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', 'C/C코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_cc_code')
//
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '라인')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_line')
//		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '작업구분')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_class_div_master')
//		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '작업방법')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_process_master')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '장비 지침 코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_guide')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '첨부 파일 코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_file')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '미터 코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_meter')

	case '조직'
		dw_items.reset()

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '과코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_section')
//
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '직급코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_title_code')

		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '기술코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_skill')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '조코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_team')
		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '부서코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_dept')
				
		
	case '업체'
		dw_items.reset()
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '업체유형코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_comp_div')
		

	case '작업관리'
		dw_items.reset()
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '작명유형코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_wo_div')
	
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '작업상태코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_status_code')
		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '주기코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_task_cycle')
		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '고장원인')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_cause')
//		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '고장원인-대분류')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_div_a')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '고장원인-소분류')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_div_b')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '예방정비코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_task_autono')
//		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '작업지시코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_wo_autono')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '작업구분코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_class_div_master')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '작업방법코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_process_master')
	
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '제외시간코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_except_time1')
//		
	case '자재'
		dw_items.reset()
				
		//ll_row = dw_items.insertrow(0)
		//dw_items.SetItem(ll_row, 'sitems', '용도코드')
		//dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_used')
		

//	case '기타'
//		dw_items.reset()
//		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '부서코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_dept')
//					
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '공장코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_factory')
//		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '지역코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_area')

		
		
	

	case '전체목록'
		dw_items.reset()

		//ll_row = dw_items.insertrow(0)
		//dw_items.SetItem(ll_row, 'sitems', '장비구분코드')
		//dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_div')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '점검개소')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_team')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', 'C/C코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_cc_code')

		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '라인')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_line')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '부서코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_dept')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '장비 지침 코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_guide')
//
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '첨부 파일 코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_file')
//
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '미터 코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_meter')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '공장 코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_factory')
//		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '지역 코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_area')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '과코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_section')

		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '직급 코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_title_code')

		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '기술 코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_skill')

//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '조코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_team')

		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '작명유형코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_wo_div')
	
		//ll_row = dw_items.insertrow(0)
		//dw_items.SetItem(ll_row, 'sitems', '작업상태코드')
		//dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_status_code')
		
		//ll_row = dw_items.insertrow(0)
		//dw_items.SetItem(ll_row, 'sitems', '주기코드')
		//dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_task_cycle')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '업체 유형 코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_comp_div')

		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '고장원인-대분류')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_div_a')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '고장원인-분류')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_equip_div_b')		
		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '고장원인')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_cause')
////		
		
//		ll_row = dw_items.insertrow(0)
//		dw_items.SetItem(ll_row, 'sitems', '예방정비코드')
//		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_task_autono')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '작업지시코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_wo_autono')
		
		//ll_row = dw_items.insertrow(0)
		//dw_items.SetItem(ll_row, 'sitems', '용도코드')
		//dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_used')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '작업구분코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_class_div_master')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '작업방법코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_process_master')
		
		ll_row = dw_items.insertrow(0)
		dw_items.SetItem(ll_row, 'sitems', '제외시간코드')
		dw_items.SetItem(ll_row, 'sdwname', 'd_sys_code_except_time1')
		

		
		
end choose

dw_items.SetSort("sitems A")  
dw_items.Sort()

dw_items.SetRedraw(true)

ll_row = dw_items.RowCount()
if ll_row > 0 then
	dw_items.Post Event RowFocusChanged(1)
end if


end event

type dw_items from datawindow within w_pisf013
integer x = 5
integer y = 956
integer width = 741
integer height = 940
integer taborder = 10
string dataobject = "d_lookup_items"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;if row > 0 then
	selectrow(0,false)
	setrow(row)
	selectrow(row, true)
end if

end event

event rowfocuschanged;if currentrow > 0 then
	selectrow(0,false)
	setrow(currentrow)
	selectrow(currentrow, true)
	is_dwname = this.GetItemString(currentrow, 'sdwname')

	tab_code.SelectedTab = 1
	
   parent.TriggerEvent('ue_retrieve_each_tab')
end if
end event

type st_vertical_treeview from statictext within w_pisf013
event ue_mousedown pbm_lbuttondown
event ue_mousemove pbm_mousemove
event ue_mouseup pbm_lbuttonup
boolean visible = false
integer x = 2368
integer width = 18
integer height = 1928
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string pointer = "Ve_split.cur"
long textcolor = 12632256
long backcolor = 12632256
boolean focusrectangle = false
end type

event ue_mousemove;if KeyDown(keyLeftButton!) Then
		This.X = Parent.PointerX()
End If

end event

event ue_mouseup;tv_code.width = this.x - tv_code.x

dw_tv_source.x = this.x + this.width
dw_tv_source.width = parent.width - this.x - 60

parent.postevent('resize')

end event

type dw_tv_source from datawindow within w_pisf013
event ue_lburrondown pbm_lbuttondown
event ue_lbuttonup pbm_lbuttonup
event ue_mousemove pbm_mousemove
boolean visible = false
integer x = 2400
integer width = 1152
integer height = 1932
integer taborder = 120
string dragicon = "pic\LOOKUP.ICO"
string dataobject = "d_equiplocation_for_tree"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lburrondown;ib_lbuttondown = true
end event

event ue_lbuttonup;ib_lbuttondown = false
end event

event ue_mousemove;if ib_lbuttondown and Keydown(KeyLeftButton!) then
	this.Drag(begin!)
end if
end event

event clicked;id_dw_current = This

if row <= 0 then return

selectrow(0, false)
setrow(row)
selectrow(row, true)
end event

event rowfocuschanged;if currentrow <= 0 then return

selectrow(0, false)
setrow(currentrow)
selectrow(currentrow, true)
end event

event getfocus;id_dw_current = This
end event

type tab_code from tab within w_pisf013
event create ( )
event destroy ( )
integer x = 763
integer y = 4
integer width = 2789
integer height = 1900
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_list tp_list
tp_property tp_property
end type

on tab_code.create
this.tp_list=create tp_list
this.tp_property=create tp_property
this.Control[]={this.tp_list,&
this.tp_property}
end on

on tab_code.destroy
destroy(this.tp_list)
destroy(this.tp_property)
end on

event selectionchanged;choose case is_dwname
	case 'd_sys_code_safeman' 
		if tab_code.tp_property.sle_code.Text = is_safemancode then return
	case 'd_sys_code_manual'
		if tab_code.tp_property.sle_code.Text = is_manualcode then return
	case 'd_sys_code_sparepart'
		if tab_code.tp_property.sle_code.Text = is_sparepartcode then return
end choose

if newindex = 2 then
	parent.triggerevent('ue_retrieve_each_tab')
end if
	

end event

type tp_list from userobject within tab_code
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 2752
integer height = 1788
long backcolor = 79741120
string text = "목록"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_div_b_code dw_div_b_code
dw_list dw_list
dw_div_a_code dw_div_a_code
end type

on tp_list.create
this.dw_div_b_code=create dw_div_b_code
this.dw_list=create dw_list
this.dw_div_a_code=create dw_div_a_code
this.Control[]={this.dw_div_b_code,&
this.dw_list,&
this.dw_div_a_code}
end on

on tp_list.destroy
destroy(this.dw_div_b_code)
destroy(this.dw_list)
destroy(this.dw_div_a_code)
end on

type dw_div_b_code from uo_datawindow within tp_list
boolean visible = false
integer x = 1253
integer y = 8
integer width = 2226
integer height = 1760
integer taborder = 11
string dataobject = "d_sys_code_equip_div_b"
end type

event clicked;call super::clicked;id_dw_current = this
iw_this.TriggerEvent('ue_set_data_changed')
end event

type dw_list from uo_datawindow within tp_list
event ue_asd ( )
integer width = 2738
integer height = 1768
integer taborder = 120
string dataobject = "d_blank"
boolean ib_select_row = false
end type

event clicked;call super::clicked;id_dw_current = this

this.Event Trigger RowFocusChanged(row)

end event

event editchanged;call super::editchanged;iw_This.TriggerEvent('ue_set_data_changed')


end event

event itemchanged;call super::itemchanged;iw_This.TriggerEvent('ue_set_data_changed')

end event

event getfocus;call super::getfocus;id_dw_current = this
end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then
	choose case is_dwname
		case 'd_sys_code_safeman' 
			is_safemancode = this.GetItemString(currentrow, 'SAFEMANCODE')
			is_descript = this.GetItemString(currentrow, 'DESCRIPT')
			is_safeman = this.GetItemString(currentrow, 'SAFEMAN')
		case 'd_sys_code_manual'
			is_manualcode = this.GetItemString(currentrow, 'MANUALCODE')
			is_descript = this.GetItemString(currentrow, 'DESCRIPT')
			is_manual = this.GetItemString(currentrow, 'TASKMANUAL')
		case 'd_sys_code_sparepart'
			is_sparepartcode = this.GetItemString(currentrow, 'SPCODE')
			is_descript = this.GetItemString(currentrow, 'DESCRIPT')
	end choose
end if
end event

type dw_div_a_code from uo_datawindow within tp_list
integer x = 5
integer y = 8
integer width = 1248
integer height = 1756
integer taborder = 11
string dataobject = "d_sys_code_equip_div_aa"
boolean ib_enter = false
boolean ib_toggle = false
boolean ib_date = false
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_where, ls_basic
		
if tab_code.tp_list.dw_div_a_code.getrow() < 1 then return 0

ls_where = ' where equip_div_b.equip_div_a_code = ' + "'" + tab_code.tp_list.dw_div_a_code.getitemstring(tab_code.tp_list.dw_div_a_code.getrow(),1) + "'" &
			+ " and area_code='"+gs_kmarea+"' and factory_code='"+gs_kmdivision+"'"
ls_basic = tab_code.tp_list.dw_div_b_code.object.datawindow.table.select
tab_code.tp_list.dw_div_b_code.object.datawindow.table.select = tab_code.tp_list.dw_div_b_code.object.datawindow.table.select + ls_where
ls_where = tab_code.tp_list.dw_div_b_code.object.datawindow.table.select//
tab_code.tp_list.dw_div_b_code.retrieve()
//id_dw_current=tab_code.tp_list.dw_div_a_code
ls_where = ''//
tab_code.tp_list.dw_div_b_code.object.datawindow.table.select=''//
tab_code.tp_list.dw_div_b_code.object.datawindow.table.select=ls_basic

if id_dw_list.RowCount() > 0 then
	id_dw_list.Post Event RowFocusChanged(1)
	id_dw_list.Post Event GetFocus()
end if
end event

type tp_property from userobject within tab_code
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 96
integer width = 2752
integer height = 1788
long backcolor = 79741120
string text = "등록정보"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
mle_descript mle_descript
dw_property dw_property
sle_code sle_code
sle_descript sle_descript
st_code st_code
end type

on tp_property.create
this.mle_descript=create mle_descript
this.dw_property=create dw_property
this.sle_code=create sle_code
this.sle_descript=create sle_descript
this.st_code=create st_code
this.Control[]={this.mle_descript,&
this.dw_property,&
this.sle_code,&
this.sle_descript,&
this.st_code}
end on

on tp_property.destroy
destroy(this.mle_descript)
destroy(this.dw_property)
destroy(this.sle_code)
destroy(this.sle_descript)
destroy(this.st_code)
end on

type mle_descript from multilineedit within tp_property
integer y = 276
integer width = 2752
integer height = 1496
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event modified;iw_this.Triggerevent('ue_set_data_changed')
end event

type dw_property from datawindow within tp_property
boolean visible = false
integer y = 280
integer width = 2190
integer height = 1464
integer taborder = 70
string dataobject = "d_sys_code_sparepart_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;id_dw_current = this
end event

event doubleclicked;if row <= 0 then return

if String(dwo.type) <> 'column' then return

string str[]
DatawindowChild ldwc
long ll_row
string ls_descript, ls_invunit

choose case lower(string(dwo.name))
	case 'partcode'
		if f_code_search('d_lookup_partcode', '', str) = true then
			this.SetItem(row, 'partcode', str[1])			
			ib_data_changed = true
			
			this.GetChild('partcode', ldwc)
			ll_row = ldwc.GetRow()
			if ll_row > 0 then
				ls_descript = ldwc.GetItemString(ll_row, 'descript')
				ls_invunit = ldwc.GetItemString(ll_row, 'invunit')
				this.SetItem(row, 'descript', ls_descript)
				this.SetItem(row, 'invunit', ls_invunit)
				this.SetItem(row, 'partqty', 0)
			end if
			
		end if
end choose



end event

event editchanged;iw_this.TriggerEvent('ue_set_data_changed')

end event

event getfocus;id_dw_current = this
end event

event itemchanged;iw_this.TriggerEvent('ue_set_data_changed')


string ls_colname
DataWindowChild	ldwc
long ll_row
string ls_descript
string ls_invunit

ls_colname = dwo.name
		
if ls_colname = 'partcode' then
	this.GetChild('partcode', ldwc)
	ll_row = ldwc.GetRow()
	if ll_row > 0 then
		ls_descript = ldwc.GetItemString(ll_row, 'descript')
		ls_invunit = ldwc.GetItemString(ll_row, 'invunit')
		this.SetItem(row, 'descript', ls_descript)
		this.SetItem(row, 'invunit', ls_invunit)
		this.SetItem(row, 'partqty', 0)
	end if
end if		

end event

type sle_code from singlelineedit within tp_property
integer x = 480
integer y = 68
integer width = 832
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_descript from singlelineedit within tp_property
integer x = 480
integer y = 172
integer width = 1394
integer height = 92
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 80269524
boolean autohscroll = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_code from statictext within tp_property
integer x = 64
integer y = 88
integer width = 370
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "코드:"
alignment alignment = right!
boolean focusrectangle = false
end type

type tv_code from treeview within w_pisf013
boolean visible = false
integer x = 773
integer width = 1595
integer height = 1924
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 32567536
borderstyle borderstyle = stylelowered!
boolean deleteitems = true
boolean linesatroot = true
boolean hideselection = false
grsorttype sorttype = ascending!
string picturename[] = {"Application5!"}
long picturemaskcolor = 553648127
long statepicturemaskcolor = 536870912
end type

event deleteitem;datawindow ld_dw
long ll_row, ll_find
string ls_descript
long ll_tvitem
treeviewitem ltvitem

if not ib_delete_from_database then return

if dw_tv_source.dataobject = 'd_equiplocation_for_tree' then
	this.GetItem(handle, ltvitem)	
	ls_descript = ltvitem.label
	ll_find = dw_locationtree.find(' location_descript = ' + "'" + ls_descript + "'", 1, dw_locationtree.RowCount())
	if ll_find > 0 then dw_locationtree.DeleteRow(ll_find)
elseif dw_tv_source.dataobject = 'd_equiptype_for_tree' then
	this.GetItem(handle, ltvitem)	
	ls_descript = ltvitem.label
	ll_find = dw_equiptypetree.find(' equiptype_descript = ' + "'" + ls_descript + "'", 1, dw_equiptypetree.RowCount())
	if ll_find > 0 then dw_equiptypetree.DeleteRow(ll_find)
end if

end event

event dragdrop;datawindow ld_dw
long ll_row, ll_find
string ls_descript, ls_parent_code
string ls_parent_descript
string ls_equiptype_code
string ls_location_code
long ll_tvitem
treeviewitem ltvitem, lti_parent

parent.TriggerEvent('ue_set_data_changed')

if TypeOf(source) = DataWindow! then
	ld_dw = source
	choose case ld_dw.dataobject
		case 'd_equiplocation_for_tree'
			ll_row = ld_dw.GetRow()
			if ll_row > 0 then
				ls_descript = ld_dw.GetItemString(ll_row, 'descript')
				if ls_descript <> '' and not isnull(ls_descript) then
					//이미 ls_descript(location코드)가 treecode에 등록이 돼있는지 검사 
					// 만일 등록돼있으면 등록 못함 . 하나의 location은 하나의 parent만을 가질 수 있음
					ll_find = dw_locationtree.find(' location_descript = ' + "'" + ls_descript + "'", 1, dw_locationtree.RowCount())
					if ll_find > 0 then
						messagebox('EM2000', '선택한 Location은 이미 다른 Location의 하위 구성요소로 등록 돼있습니다.!')
						return
					end if
					ltvitem.label = ls_descript
					ltvitem.pictureindex = 1
					ltvitem.SelectedPictureindex = 1
					ltvitem.children = false

					if handle < 1 then
						ll_tvitem =	tv_code.InsertItemSort(0, ltvitem) // root 에 추가
					else
						ll_tvitem = tv_code.InsertItemSort(handle, ltvitem)
						if il_oldhandle <> handle then // 같은 수준에 아이템을 추가했으면 expand하지 않는다.
							tv_code.ExpandItem(handle)
						end if
					end if
					// 데이터저장을 위하여 datawindow에 현재 변경된 데이터를 입력한다.
					this.GetItem(handle, lti_parent)
					ls_parent_descript = lti_parent.label
					if handle = 0 then
						setnull(ls_parent_code)
					else
						ll_find = dw_tv_source.find(" descript = " + "'" + ls_parent_descript + "'", 1, dw_tv_source.RowCount())
						if ll_find <= 0 then
							MessageBox("알림", 'Location 내역이 없거나 코드상에 문제가 있습니다. ~r~r시스템관리자에게 문의 하십시오.')
							return
						end if
						ls_parent_code = dw_tv_source.GetItemString(ll_find, 'location')
					end if
					
					ll_find = dw_tv_source.find('descript = ' + "'" + ls_descript + "'", 1, dw_tv_source.RowCount())
					if ll_find <= 0 then
						MessageBox("알림", 'Location 내역이 없거나 코드상에 문제가 있습니다. ~r~r시스템관리자에게 문의 하십시오.')
						return
					end if
					ls_location_code = dw_tv_source.GetItemString(ll_find, 'location')
					
					ll_row = dw_locationtree.InsertRow(0)
					dw_locationtree.SetItem(ll_row, 'parentcode', ls_parent_code)			
					dw_locationtree.SetItem(ll_row, 'location', ls_location_code)
					dw_locationtree.SetItem(ll_row, 'parentcode_descript', ls_parent_descript)			
					dw_locationtree.SetItem(ll_row, 'location_descript', ls_descript)
					
				end if
			end if				
		case 'd_equiptype_for_tree'
			ll_row = ld_dw.GetRow()
			if ll_row > 0 then
				ls_descript = ld_dw.GetItemString(ll_row, 'descript')
				if ls_descript <> '' and not isnull(ls_descript) then
					//이미 ls_descript(설비유형코드)가 treecode에 등록이 돼있는지 검사 
					// 만일 등록돼있으면 등록 못함 . 하나의 설비유형은 하나의 parent만을 가질 수 있음
					ll_find = dw_equiptypetree.find(' equiptype_descript = ' + "'" + ls_descript + "'", 1, dw_equiptypetree.RowCount())
					if ll_find > 0 then
						messagebox('EM2000', '선택한 설비유형은 이미 다른 설비유형의 하위 컴포넌트로 등록 돼있습니다.!')
						return
					end if
					ltvitem.label = ls_descript
					ltvitem.pictureindex = 1
					ltvitem.SelectedPictureindex = 1
					ltvitem.children = false

					if handle < 1 then
						ll_tvitem =	tv_code.InsertItemSort(0, ltvitem) // root 에 추가
					else
						ll_tvitem = tv_code.InsertItemSort(handle, ltvitem)
						if il_oldhandle <> handle then // 같은 수준에 아이템을 추가했으면 expand하지 않는다.
							tv_code.ExpandItem(handle)
						end if
					end if
					// 데이터저장을 위하여 datawindow에 현재 변경된 데이터를 입력한다.
					this.GetItem(handle, lti_parent)
					ls_parent_descript = lti_parent.label

					ll_find = dw_tv_source.find(" descript = " + "'" + ls_parent_descript + "'", 1, dw_tv_source.RowCount())
					if handle = 0 then
						setnull(ls_parent_code)
					else
						if ll_find <= 0 then
							MessageBox('EM2000', '설비유형 내역이 없거나 코드상에 문제가 있습니다. ~r~r시스템관리자에게 문의 하십시오.')
							return
						end if
						ls_parent_code = dw_tv_source.GetItemString(ll_find, 'equiptype')
					end if
					
					ll_find = dw_tv_source.find('descript = ' + "'" + ls_descript + "'", 1, dw_tv_source.RowCount())
					if ll_find <= 0 then
						MessageBox('EM2000', '설비유형 내역이 없거나 코드상에 문제가 있습니다. ~r~r시스템관리자에게 문의 하십시오.')
						return
					end if
					ls_equiptype_code = dw_tv_source.GetItemString(ll_find, 'equiptype')
					
					ll_row = dw_equiptypetree.InsertRow(0)
					dw_equiptypetree.SetItem(ll_row, 'parentcode', ls_parent_code)			
					dw_equiptypetree.SetItem(ll_row, 'equiptype', ls_equiptype_code)
					dw_equiptypetree.SetItem(ll_row, 'parentcode_descript', ls_parent_descript)			
					dw_equiptypetree.SetItem(ll_row, 'equiptype_descript', ls_descript)
					
				end if
			end if				
	end choose
end if

il_oldhandle = handle
end event

event itempopulate;string ls_parentdescript
string ls_descript
treeviewitem ltvitem
long ll_find
long ll_rowcount

if dw_tv_source.dataobject = 'd_equiptype_for_tree' then
	tv_code.GetItem(handle, ltvitem)
	ls_parentdescript = ltvitem.label
	
	ll_rowcount = dw_equiptypetree.RowCount()
	if ll_rowcount <= 0 then return
	
	ll_find = dw_equiptypetree.find(" parentcode_descript = " + "'" + ls_parentdescript + "'", 1, ll_rowcount)
	do while ll_find > 0 
		ls_descript = dw_equiptypetree.GetItemString(ll_find, 'equiptype_descript')
	
		ltvitem.pictureindex = 1
		ltvitem.label = ls_descript
		ltvitem.children = true
		ltvitem.SelectedPictureIndex = 1
		tv_code.InsertItemLast(handle, ltvitem)  
		
		if ll_find >= ll_rowcount then exit
		
		ll_find = dw_equiptypetree.find(" parentcode_descript = " + "'" + ls_parentdescript + "'", ll_find+1, ll_rowcount)

	loop
elseif dw_tv_source.dataobject = 'd_equiplocation_for_tree' then
	tv_code.GetItem(handle, ltvitem)
	ls_parentdescript = ltvitem.label
	
	ll_rowcount = dw_locationtree.RowCount()
	if ll_rowcount <= 0 then return
	
	ll_find = dw_locationtree.find(" parentcode_descript = " + "'" + ls_parentdescript + "'", 1, ll_rowcount)
	do while ll_find > 0 
		ls_descript = dw_locationtree.GetItemString(ll_find, 'location_descript')
	
		ltvitem.pictureindex = 1
		ltvitem.label = ls_descript
		ltvitem.children = true
		ltvitem.SelectedPictureIndex = 1
		tv_code.InsertItemLast(handle, ltvitem)  

		if ll_find >= ll_rowcount then exit
		
		ll_find = dw_locationtree.find(" parentcode_descript = " + "'" + ls_parentdescript + "'", ll_find+1, ll_rowcount)
	loop
end if

end event

type uo_area from u_cmms_select_area within w_pisf013
integer x = 91
integer y = 32
integer taborder = 130
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

event destructor;call super::destructor;call u_cmms_select_area::destroy
end event

type uo_division from u_cmms_select_division within w_pisf013
integer x = 87
integer y = 120
integer taborder = 90
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

event destructor;call super::destructor;call u_cmms_select_division::destroy
end event

