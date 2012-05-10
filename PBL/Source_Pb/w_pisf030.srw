$PBExportHeader$w_pisf030.srw
$PBExportComments$자재마스타
forward
global type w_pisf030 from w_cmms_sheet01
end type
type dw_list from uo_datawindow within w_pisf030
end type
type tab_1 from tab within w_pisf030
end type
type tp_1 from userobject within tab_1
end type
type dw_property from datawindow within tp_1
end type
type tp_1 from userobject within tab_1
dw_property dw_property
end type
type tab_1 from tab within w_pisf030
tp_1 tp_1
end type
type uo_area from u_cmms_select_area within w_pisf030
end type
type uo_division from u_cmms_select_division within w_pisf030
end type
type cb_1 from commandbutton within w_pisf030
end type
type gb_1 from groupbox within w_pisf030
end type
end forward

global type w_pisf030 from w_cmms_sheet01
integer height = 2284
string title = "자재"
dw_list dw_list
tab_1 tab_1
uo_area uo_area
uo_division uo_division
cb_1 cb_1
gb_1 gb_1
end type
global w_pisf030 w_pisf030

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

on w_pisf030.create
int iCurrent
call super::create
this.dw_list=create dw_list
this.tab_1=create tab_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_list
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.uo_area
this.Control[iCurrent+4]=this.uo_division
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.gb_1
end on

on w_pisf030.destroy
call super::destroy
destroy(this.dw_list)
destroy(this.tab_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event resize;call super::resize;dw_list.width = newwidth - 690

tab_1.width = dw_list.width
//tab_1.height = newheight - 1850

tab_1.tp_1.dw_property.width = tab_1.width - 40
tab_1.tp_1.dw_property.height = tab_1.height - 110


end event

event open;call super::open;datawindowchild ldwc

ib_saved = false
ib_data_changed = false
long i, ll_row

for i = 1 to 1
	ib_refreshed_tab[i] = false
next

ii_old_tab = 1
ii_current_tab = 1

dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)   

id_dw_property = tab_1.tp_1.dw_property

is_original_sql_list = dw_list.object.datawindow.table.select
is_original_sql_property = id_dw_property.object.datawindow.table.select

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true,  false,  false,  false,  false, false, false, false)

end event

event ue_retrieve;call super::ue_retrieve;int li_current_tab_page
string ls_where, ls_and, ls_code
long ll_row
string ls_factory, ls_area

ls_area=gs_kmarea
ls_factory=gs_kmdivision

li_current_tab_page = tab_1.SelectedTab

dw_list.object.datawindow.table.select = is_original_sql_list 
ls_where = ' where area_code = ' +"'"+ls_area+ "' and factory_code='"+ls_factory+"' ORDER BY part_code"
	
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

if dw_list.getrow()<1 then return
ls_where = ' where part_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),'part_code') + "'"
ls_and = ' and part_code = ' + "'" + dw_list.getitemstring(dw_list.getrow(),'part_code') + "'"

choose case li_current_tab_page
	case 1  							
		id_dw_property.object.datawindow.table.select = is_original_sql_property + ls_where
		id_dw_property.retrieve()
		id_dw_current = id_dw_property
end choose

ib_refreshed_tab[li_current_tab_page] = true

end event

event ue_save;call super::ue_save;//long ll_row
//datawindow ld_dw
//string ls_now
//
//choose case tab_1.selectedtab
//	case 1
//		
//		if id_dw_property.update() = - 1 then
//			return 0
//		end if
//		
//		if id_dw_property.getrow() > 0 then 
//		ls_now=id_dw_property.getitemstring(id_dw_property.getrow(),'part_code')
//		end if
//end choose
//this.triggerevent('ue_retrieve')
//dw_list.scrolltorow(dw_list.find("part_code='"+ls_now+"'",1,dw_list.rowcount()))
return 1
//
//
//
end event

event ue_postopen;call super::ue_postopen;
dw_list.settransobject(sqlcmms)
tab_1.tp_1.dw_property.settransobject(sqlcmms)

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
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf030
end type

type dw_list from uo_datawindow within w_pisf030
integer x = 699
integer y = 28
integer width = 3342
integer height = 1788
integer taborder = 10
string dataobject = "d_part_list"
end type

event clicked;call super::clicked;//parent.triggerevent('ue_retrieve_each_tab')
//
//int li_count
//
//for li_count = 1 to 2
//	ib_refreshed_tab[li_count] = false
//next
end event

event rowfocuschanged;call super::rowfocuschanged;parent.triggerevent('ue_retrieve_each_tab')

int li_count

for li_count = 1 to 2
	ib_refreshed_tab[li_count] = false
next
end event

type tab_1 from tab within w_pisf030
integer x = 699
integer y = 1836
integer width = 4613
integer height = 756
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
end type

on tab_1.create
this.tp_1=create tp_1
this.Control[]={this.tp_1}
end on

on tab_1.destroy
destroy(this.tp_1)
end on

event selectionchanged;if dw_list.getrow() < 1 then return

ii_old_tab = oldindex
ii_current_tab = newindex

setnull(id_dw_current)

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
integer height = 644
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
integer height = 632
integer taborder = 30
string title = "none"
string dataobject = "d_part_01"
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
			This.SetItem(row, 'comp_div_code', ls_data[1])
		END IF
	Case 'comp_div_code2'
		IF f_code_search('d_lookup_comp_div', '', ls_data[]) THEN
			This.SetItem(row, 'comp_div_code', ls_data[1])
		END IF
	Case 'comp_div_code3'
		IF f_code_search('d_lookup_comp_div', '', ls_data[]) THEN
			This.SetItem(row, 'comp_div_code', ls_data[1])
		END IF
End Choose		
ib_data_changed = true
end event

type uo_area from u_cmms_select_area within w_pisf030
event destroy ( )
integer x = 91
integer y = 68
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_cmms_select_area::destroy
end on

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

event ue_select;call super::ue_select;string ls_divisionname, ls_divisionnameeng, ls_areacode, ls_divisioncode
datawindow 	ldw_division
ldw_division = uo_division.dw_1
ls_areacode  = is_uo_areacode
f_cmms_retrieve_dddw_division(ldw_division,g_s_empno,ls_areacode,'%',false,ls_divisioncode,ls_divisionname,ls_divisionnameeng)

uo_division.triggerevent('ue_select')
end event

type uo_division from u_cmms_select_division within w_pisf030
event destroy ( )
integer x = 91
integer y = 180
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type cb_1 from commandbutton within w_pisf030
boolean visible = false
integer x = 9
integer y = 792
integer width = 795
integer height = 128
integer taborder = 40
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "자재마스터크로스체크"
end type

event clicked;decimal ld_maxq, ld_minq
string ls_part_code, ls_location
int i

for i = 1 to dw_list.RowCount() 
	SETNULL(ld_maxq)
	SETNULL(ld_minq)
	SETNULL(ls_location)
	ls_part_code = dw_list.getitemstring(i, 'part_code')
	
	SELECT maxq, minq, wloc
	INTO :ld_maxq, :ld_minq, :ls_location
	FROM PBINV.INV101
	WHERE COMLTD = '01' AND XPLANT = :gs_kmarea AND DIV = :gs_kmdivision
			AND ITNO = :ls_part_code AND CLS in ('23', '43')
	USING sqlca ;
	
	if sqlca.sqlcode = 0 then
		if isnull(ld_maxq) then ld_maxq = 0
		if isnull(ld_minq) then ld_minq = 0
		if isnull(ls_location) OR Trim(ls_location) = '' then ls_location = ''
		
		UPDATE PART_MASTER
		SET MAXQ = :ld_maxq, MINQ = :ld_minq, PART_LOCATION = :ls_location
		WHERE AREA_CODE = :gs_kmarea AND FACTORY_CODE = :gs_kmdivision 
				AND PART_CODE = :ls_part_code
		USING sqlCMMS;
	ELSE
		messagebox("에러", ls_part_code)
	end iF
next

messagebox("aa", "끝")
end event

type gb_1 from groupbox within w_pisf030
integer x = 32
integer width = 654
integer height = 292
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

