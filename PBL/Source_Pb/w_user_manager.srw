$PBExportHeader$w_user_manager.srw
forward
global type w_user_manager from w_cmms_sheet01
end type
type tab_user from tab within w_user_manager
end type
type tp_list from userobject within tab_user
end type
type dw_user_list from uo_datawindow within tp_list
end type
type tp_list from userobject within tab_user
dw_user_list dw_user_list
end type
type tp_usergroup from userobject within tab_user
end type
type dw_not_belong from uo_datawindow within tp_usergroup
end type
type dw_belong from uo_datawindow within tp_usergroup
end type
type dw_groupid from uo_datawindow within tp_usergroup
end type
type cb_1 from commandbutton within tp_usergroup
end type
type cb_2 from commandbutton within tp_usergroup
end type
type st_1 from statictext within tp_usergroup
end type
type st_2 from statictext within tp_usergroup
end type
type tp_usergroup from userobject within tab_user
dw_not_belong dw_not_belong
dw_belong dw_belong
dw_groupid dw_groupid
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_2 st_2
end type
type tp_program_security from userobject within tab_user
end type
type dw_program_security from uo_datawindow within tp_program_security
end type
type dw_usergroup from uo_datawindow within tp_program_security
end type
type tp_program_security from userobject within tab_user
dw_program_security dw_program_security
dw_usergroup dw_usergroup
end type
type tab_user from tab within w_user_manager
tp_list tp_list
tp_usergroup tp_usergroup
tp_program_security tp_program_security
end type
end forward

global type w_user_manager from w_cmms_sheet01
string title = "사용자관리"
tab_user tab_user
end type
global w_user_manager w_user_manager

type variables
string is_userid

datawindow id_dw_usergroup 
datawindow id_dw_user_manage_info, id_dw_item_supply 
datawindow id_dw_service_supply ,id_dw_inv_info_hist 
datawindow id_dw_current
datawindow id_dw_mfg_part
datawindow id_dw_group_security

string is_original_sql_list 
string is_original_sql_property 
string is_original_sql_item_supply 
string is_original_sql_service_supply
string is_original_sql_part_mfg

end variables

forward prototypes
public subroutine wf_resize_dw_two (datawindow adw_one, datawindow adw_two)
public function long add_tree (treeview tv, datawindow dw, long lparent, string sparent)
public subroutine wf_resize_dw_one (datawindow adw_one)
end prototypes

public subroutine wf_resize_dw_two (datawindow adw_one, datawindow adw_two);adw_one.width = tab_user.width - 45
//adw_one.height = tab_user.height - 156

adw_two.width = tab_user.width - 45

adw_two.height = tab_user.height - 156 - adw_one.height
end subroutine

public function long add_tree (treeview tv, datawindow dw, long lparent, string sparent);long lFind = 1, lEnd
string sCode, sType, sSearch
long lTv

lEnd = dw.RowCount()
if lParent = 0 then
	sSearch = "isnull(parentcode)" 
else
	sSearch = "parentcode = '" + sParent + "'"
end if

lFind = dw.Find(sSearch, lFind, lEnd)

DO WHILE lFind > 0
	sCode = dw.GetItemString(lFind, "hircode")
	sType = dw.GetItemString(lFind, "codetype")
	if sType = "L" then
		lTv =	tv.InsertItemSort(lParent, sCode, 1)
	else
		lTv =	tv.InsertItemSort(lParent, sCode, 2)	
	end if
	lsLabel[lTv] = sCode
	if lTv > lnMax then lnMax = lTv
	add_tree(tv, dw, lTv, sCode)
	if lParent = 0 then tv.ExpandAll(lTv)
	lFind++
	// Prevent endless loop
	IF lFind > lEnd THEN EXIT
	lFind = dw.Find(sSearch, lFind, lEnd)
LOOP


return 1
end function

public subroutine wf_resize_dw_one (datawindow adw_one);adw_one.width = tab_user.width - 45
adw_one.height = tab_user.height - 140
end subroutine

on w_user_manager.create
int iCurrent
call super::create
this.tab_user=create tab_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_user
end on

on w_user_manager.destroy
call super::destroy
destroy(this.tab_user)
end on

event open;call super::open;datawindowchild ldwc

ib_saved = false
ib_data_changed = false
long i
for i = 1 to 7

	ib_refreshed_tab[i] = false
next

ii_old_tab = 1
ii_current_tab = 1

tab_user.tp_list.dw_user_list.settransobject(sqlcmms)   
tab_user.tp_usergroup.dw_groupid.SetTransObject(sqlcmms) 

id_dw_list = tab_user.tp_list.dw_user_list
id_dw_usergroup = tab_user.tp_usergroup.dw_groupid

is_original_sql_list = id_dw_list.object.datawindow.table.select
is_original_sql_property = id_dw_usergroup.object.datawindow.table.select


//id_dw_usergroup.GetChild('comptype', ldwc)
//f_dddw_width(id_dw_usergroup, 'comptype', ldwc, 'descript', 10)
//

end event

event resize;call super::resize;tab_user.width = this.width - tab_user.x - 47
tab_user.height = this.height - tab_user.y - 120

wf_resize_dw_one (tab_user.tp_list.dw_user_list)

tab_user.tp_usergroup.dw_groupid.height = tab_user.height - 120
tab_user.tp_usergroup.dw_belong.width = tab_user.width - 1243
tab_user.tp_usergroup.dw_not_belong.width = tab_user.width - 1243
tab_user.tp_usergroup.dw_not_belong.height = tab_user.height - 1200

tab_user.tp_program_security.dw_usergroup.height = tab_user.height - 120
tab_user.tp_program_security.dw_program_security.width = tab_user.width - 1239
tab_user.tp_program_security.dw_program_security.height = tab_user.height - 120
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
string ls_compcode

choose case tab_user.selectedTab
	case 1 
//		ld_dw = id_dw_list
//
//		ll_Row = ld_dw.InsertRow(0)
//		ld_dw.SetRow(ll_Row)
//		ld_dw.ScrollToRow(ll_Row)
//		//ld_dw.Post Event Rowfocuschanged (ll_row)
//		ld_dw.SetFocus()	
	case 2
		ld_dw = id_dw_usergroup

		ll_Row = ld_dw.InsertRow(0)
		ld_dw.SetRow(ll_Row)
		ld_dw.ScrollToRow(ll_Row)
		//ld_dw.Post Event Rowfocuschanged (ll_row)
		ld_dw.SetFocus()
		tab_user.tp_usergroup.dw_belong.reset()
end choose



end event

event ue_print;call super::ue_print;long Job
integer li_return

li_return = MessageBox("알림", '현재 페이지를 인쇄하겠습니까?', Exclamation!, OKCancel!, 2)
IF li_return = 1 THEN
	// process ok
	Job = PrintOpen( )
	tab_user.Print(Job, tab_user.x,tab_user.y)
	PrintClose(Job)
ELSE
   // Process CANCEL.
END IF


end event

event ue_retrieve_each_tab();call super::ue_retrieve_each_tab;string ls_where, ls_and
string ls_code, ls_decript
long li_current_tab_page, ll_row

li_current_tab_page = tab_user.SelectedTab

choose case li_current_tab_page
	case 1  							
		id_dw_list.retrieve()
	case 2  							
		id_dw_usergroup.retrieve()
		tab_user.tp_usergroup.dw_not_belong.SetTransObject(sqlcmms)
		tab_user.tp_usergroup.dw_not_belong.Retrieve()
	case 3  							
		tab_user.tp_program_security.dw_usergroup.SetTransObject(sqlcmms)
		tab_user.tp_program_security.dw_program_security.SetTransObject(sqlcmms)

		tab_user.tp_program_security.dw_usergroup.retrieve()
		ll_row = tab_user.tp_program_security.dw_usergroup.GetRow()
		if ll_row <= 0 then
			tab_user.tp_program_security.dw_program_security.reset()
		else
			tab_user.tp_program_security.dw_program_security.retrieve(tab_user.tp_program_security.dw_usergroup.GetItemString(ll_row, 'groupid'))
		end if			
end choose


ib_refreshed_tab[li_current_tab_page] = true

end event

event ue_retrieve;call super::ue_retrieve;this.triggerevent('ue_retrieve_each_tab')





end event

event type integer ue_save;call super::ue_save;long ll_row, i
datawindow ld_dw
long ll_find
string ls_groupid, ls_empcode, ls_pgmid, ls_exist
long ll_visible, ll_readonly

ii_tab_save = ii_current_tab

choose case ii_tab_save
	case 1 
		ld_dw = id_dw_list
		wf_update_datawindow_tab(ld_dw,9)
	case 2	
		ld_dw = id_dw_usergroup
		ll_row = ld_dw.find("IsNull(GROUPID) or GROUPID = ''", 1, ld_dw.RowCount()) 		// 키컬럼에 데이터가 입력이 안돼있으면 지운다.
		DO WHILE ll_row > 0	
			if ll_row > 0 then
				ld_dw.DeleteRow(ll_row)
			end if
			ll_row = ld_dw.find("IsNull(GROUPID) or GROUPID = ''", 1, ld_dw.RowCount())
		LOOP
		ld_dw.AcceptText()
		ls_groupid = id_dw_usergroup.GetItemString(id_dw_usergroup.GetRow(), 'groupid')
		
		wf_update_datawindow_tab(ld_dw,9)
		
		for i = 1 to tab_user.tp_usergroup.dw_belong.RowCount()
			ls_empcode = tab_user.tp_usergroup.dw_belong.GetItemString(i, 'empcode')
			UPDATE TMSTEMP SET GROUPID = :ls_groupid
			WHERE EMPCODE = :ls_empcode;
			commit;
		next
		
				
		for i = 1 to tab_user.tp_usergroup.dw_not_belong.RowCount()
			ls_empcode = tab_user.tp_usergroup.dw_not_belong.GetItemString(i, 'empcode')
			UPDATE TMSTEMP SET GROUPID = NULL
			WHERE EMPCODE = :ls_empcode;
			commit;
		next
				
		tab_user.tp_usergroup.dw_not_belong.Retrieve()
		
		if id_dw_usergroup.rowcount() > 0 then
			ll_find = id_dw_usergroup.find('groupid = ' + "'" + ls_groupid + "'", 1, id_dw_usergroup.RowCount())
			if ll_find > 0 then
				id_dw_usergroup.selectrow(0, false)
				id_dw_usergroup.setrow(ll_find)
				id_dw_usergroup.scrolltorow(ll_find)
				id_dw_usergroup.selectrow(ll_find, true)
			end if
		end if
		
	case 3
		ll_row = tab_user.tp_program_security.dw_usergroup.GetRow()
		if ll_row > 0 then
			ls_groupid = tab_user.tp_program_security.dw_usergroup.GetItemString(ll_row, 'groupid')
			ll_row = tab_user.tp_program_security.dw_program_security.RowCount()
			for i = 1 to ll_row
				ll_visible = tab_user.tp_program_security.dw_program_security.GetItemNumber(i, 'visible')
				ll_readonly = tab_user.tp_program_security.dw_program_security.GetItemNumber(i, 'readonly')
				ls_pgmid = tab_user.tp_program_security.dw_program_security.GetItemString(i, 'pgmid')
				SetNull(ls_exist)
				SELECT GROUPID INTO :ls_exist 
				  FROM TSECURITY 
				 WHERE GROUPID = :ls_groupid 
				   AND PGMID = :ls_pgmid;
				if ls_exist = '' or isnull(ls_exist) then
					// insert
					INSERT INTO TSECURITY (GROUPID, PGMID, VISIBLE, READONLY, LASTDATE)
						VALUES(:ls_groupid, :ls_pgmid, :ll_visible, :ll_readonly, Getdate());
				else
					// update
					UPDATE TSECURITY SET 
								VISIBLE = :ll_visible,
								READONLY = :ll_readonly,
								LASTDATE = GETDATE()
					 WHERE GROUPID = :ls_groupid
					   AND PGMID = :ls_pgmid;
				end if
				commit;
//				Messagebox('', string(ll_visible) + ' ' + string(ll_readonly) + ' ' + ls_pgmid + ' ' + ls_groupid)				
			next
		end if
end choose

Return 1

end event

event ue_set_data_changed();call super::ue_set_data_changed;ib_data_changed = true
end event

event ue_set_not_refreshed();call super::ue_set_not_refreshed;int li_count

for li_count = 1 to 7
	ib_refreshed_tab[li_count] = false
next
	
end event

type tab_user from tab within w_user_manager
event create ( )
event destroy ( )
integer x = 9
integer y = 16
integer width = 3543
integer height = 1884
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 79741120
boolean raggedright = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tp_list tp_list
tp_usergroup tp_usergroup
tp_program_security tp_program_security
end type

on tab_user.create
this.tp_list=create tp_list
this.tp_usergroup=create tp_usergroup
this.tp_program_security=create tp_program_security
this.Control[]={this.tp_list,&
this.tp_usergroup,&
this.tp_program_security}
end on

on tab_user.destroy
destroy(this.tp_list)
destroy(this.tp_usergroup)
destroy(this.tp_program_security)
end on

event selectionchanged;ii_old_tab = oldindex
ii_current_tab = newindex

if ib_readonly then return

parent.postevent('ue_set_buttons')

//if ib_data_changed then
//	parent.triggerevent('ue_save_old_tab')
//end if


// 이미 최신 데이터를 조회중이면 다시 조회하지 않는다.
if ib_refreshed_tab[newindex] then
	return
else
	parent.triggerevent('ue_retrieve_each_tab')	
end if

SetNull(id_dw_current)
end event

type tp_list from userobject within tab_user
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 3506
integer height = 1772
long backcolor = 79741120
string text = "암호설정"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_user_list dw_user_list
end type

on tp_list.create
this.dw_user_list=create dw_user_list
this.Control[]={this.dw_user_list}
end on

on tp_list.destroy
destroy(this.dw_user_list)
end on

type dw_user_list from uo_datawindow within tp_list
integer y = 12
integer width = 3497
integer height = 1756
integer taborder = 110
string dataobject = "d_user_list"
end type

event rowfocuschanged;call super::rowfocuschanged;iw_This.triggerevent('ue_set_not_refreshed')

if currentrow > 0 then
	is_userid = this.GetItemString(currentrow, 'EMPCODE')
	is_descript = this.GetItemString(currentrow,'EMPNAME')
end if
end event

event clicked;call super::clicked;id_dw_current = this
end event

event getfocus;call super::getfocus;id_dw_current = this
end event

event editchanged;call super::editchanged;iw_This.TriggerEvent('ue_set_data_changed')
end event

event itemchanged;call super::itemchanged;iw_This.TriggerEvent('ue_set_data_changed')
end event

type tp_usergroup from userobject within tab_user
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 3506
integer height = 1772
long backcolor = 79741120
string text = "사용자 그룹"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_not_belong dw_not_belong
dw_belong dw_belong
dw_groupid dw_groupid
cb_1 cb_1
cb_2 cb_2
st_1 st_1
st_2 st_2
end type

on tp_usergroup.create
this.dw_not_belong=create dw_not_belong
this.dw_belong=create dw_belong
this.dw_groupid=create dw_groupid
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.dw_not_belong,&
this.dw_belong,&
this.dw_groupid,&
this.cb_1,&
this.cb_2,&
this.st_1,&
this.st_2}
end on

on tp_usergroup.destroy
destroy(this.dw_not_belong)
destroy(this.dw_belong)
destroy(this.dw_groupid)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.st_2)
end on

type dw_not_belong from uo_datawindow within tp_usergroup
integer x = 1202
integer y = 1176
integer width = 2286
integer height = 588
integer taborder = 11
string dataobject = "d_user_group_not_belong"
end type

event clicked;call super::clicked;id_dw_current = This
end event

event getfocus;call super::getfocus;id_dw_current = This
end event

type dw_belong from uo_datawindow within tp_usergroup
integer x = 1202
integer y = 96
integer width = 2286
integer height = 904
integer taborder = 11
string dataobject = "d_user_group_belong"
end type

event retrieveend;call super::retrieveend;This.Event Trigger RowFocusChanged(1)
end event

event clicked;call super::clicked;id_dw_current = This
end event

event getfocus;call super::getfocus;id_dw_current = This
end event

type dw_groupid from uo_datawindow within tp_usergroup
integer y = 8
integer width = 1184
integer height = 1760
integer taborder = 11
string dataobject = "d_user_group"
end type

event rowfocuschanged;call super::rowfocuschanged;if currentrow <= 0 then return

string ls_groupid
long i, ll_count

ls_groupid = this.GetItemString(currentrow, 'groupid')

if ls_groupid = '' or isnull(ls_groupid) then return

dw_belong.SetTransObject(sqlcmms)
dw_belong.Retrieve(ls_groupid)


end event

event clicked;call super::clicked;id_dw_current = this

if row <= 0 then return

string ls_groupid

ls_groupid = this.GetItemString(row, 'groupid')

if ls_groupid = '' or isnull(ls_groupid) then return


dw_belong.SetTransObject(sqlcmms)
dw_belong.Retrieve(ls_groupid)


end event

event editchanged;call super::editchanged;iw_This.TriggerEvent('ue_set_data_changed')
end event

event itemchanged;call super::itemchanged;iw_This.TriggerEvent('ue_set_data_changed')
end event

event getfocus;call super::getfocus;id_dw_current = This
end event

type cb_1 from commandbutton within tp_usergroup
integer x = 2039
integer y = 1016
integer width = 448
integer height = 88
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "↑ 선  택"
end type

event clicked;if ib_readonly then return

long ll_row

ll_row = dw_not_belong.GetRow()

if ll_row <= 0 then 
	MessageBox("알림", '그룹에 추가할 사용자를 선택하십시오.')
	return
end if

dw_not_belong.RowsMove(ll_row, ll_row, Primary!, dw_belong, 1, Primary!)
ib_data_changed = true

dw_belong.SelectRow(0,False)
dw_belong.SetRow(1)
dw_belong.SelectRow(1,True)
// dw_1.RowsMove(1, dw_1.DeletedCount(), Delete!, dw_1, 1, Primary!)

end event

type cb_2 from commandbutton within tp_usergroup
integer x = 2487
integer y = 1016
integer width = 448
integer height = 88
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "↓ 제  거"
end type

event clicked;if ib_readonly then return

long ll_row

ll_row = dw_belong.GetRow()

if ll_row <= 0 then 
	MessageBox("알림", '그룹에서 삭제할 사용자를 선택하십시오.')
	return
end if

dw_belong.RowsMove(ll_row, ll_row, Primary!, dw_not_belong, 1, Primary!)

ib_data_changed = true

// dw_1.RowsMove(1, dw_1.DeletedCount(), Delete!, dw_1, 1, Primary!)

end event

type st_1 from statictext within tp_usergroup
integer x = 1216
integer y = 24
integer width = 672
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 80269524
boolean enabled = false
string text = "선택된 그룹에 속한사용자"
boolean focusrectangle = false
end type

type st_2 from statictext within tp_usergroup
integer x = 1211
integer y = 1104
integer width = 471
integer height = 48
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "선택가능한 사용자"
boolean focusrectangle = false
end type

type tp_program_security from userobject within tab_user
event create ( )
event destroy ( )
integer x = 18
integer y = 96
integer width = 3506
integer height = 1772
long backcolor = 79741120
string text = "화면 사용 권한설정"
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_program_security dw_program_security
dw_usergroup dw_usergroup
end type

on tp_program_security.create
this.dw_program_security=create dw_program_security
this.dw_usergroup=create dw_usergroup
this.Control[]={this.dw_program_security,&
this.dw_usergroup}
end on

on tp_program_security.destroy
destroy(this.dw_program_security)
destroy(this.dw_usergroup)
end on

type dw_program_security from uo_datawindow within tp_program_security
integer x = 1207
integer y = 8
integer width = 2290
integer height = 1760
integer taborder = 11
string dataobject = "d_group_security"
end type

event retrieveend;call super::retrieveend;This.Event Trigger RowFocusChanged(1)
end event

event clicked;call super::clicked;id_dw_current = This

If Row <= 0 then Return

This.SelectRow(0,False)
This.SetRow(row)
This.SelectRow(row,True)
//This.Setfocus()
end event

event getfocus;call super::getfocus;id_dw_current = This
end event

type dw_usergroup from uo_datawindow within tp_program_security
integer y = 8
integer width = 1189
integer height = 1760
integer taborder = 11
string dataobject = "d_user_group"
end type

event rowfocuschanged;call super::rowfocuschanged;string ls_groupid

ls_groupid = this.GetItemString(currentrow, 'groupid')

dw_program_security.Retrieve(ls_groupid)

end event

event clicked;call super::clicked;id_dw_current = This

if row <= 0 then return

this.Event Trigger RowFocusChanged(row)


end event

event retrieveend;call super::retrieveend;f_set_tabsequence(this,0)

if this.RowCount() > 0 then
	this.Event Trigger RowFocusChanged(1)
end if
end event

event getfocus;call super::getfocus;id_dw_current = This
end event

