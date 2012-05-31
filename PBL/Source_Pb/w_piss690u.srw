$PBExportHeader$w_piss690u.srw
forward
global type w_piss690u from w_origin_sheet01
end type
type uo_area from u_pisc_select_area within w_piss690u
end type
type uo_division from u_pisc_select_division within w_piss690u
end type
type uo_itemcode from u_pisc_select_item_model_kdac within w_piss690u
end type
type tab_1 from tab within w_piss690u
end type
type tabpage_1 from userobject within tab_1
end type
type dw_tabpage_1 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_tabpage_1 dw_tabpage_1
end type
type tabpage_2 from userobject within tab_1
end type
type dw_tabpage_2 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_tabpage_2 dw_tabpage_2
end type
type tabpage_3 from userobject within tab_1
end type
type uo_to from u_pisc_date_applydate_1 within tabpage_3
end type
type uo_from from u_pisc_date_firstday within tabpage_3
end type
type dw_tabpage_3 from datawindow within tabpage_3
end type
type dw_detail from datawindow within tabpage_3
end type
type gb_3 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
uo_to uo_to
uo_from uo_from
dw_tabpage_3 dw_tabpage_3
dw_detail dw_detail
gb_3 gb_3
end type
type tab_1 from tab within w_piss690u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type gb_1 from groupbox within w_piss690u
end type
type gb_2 from groupbox within w_piss690u
end type
end forward

global type w_piss690u from w_origin_sheet01
integer height = 2696
uo_area uo_area
uo_division uo_division
uo_itemcode uo_itemcode
tab_1 tab_1
gb_1 gb_1
gb_2 gb_2
end type
global w_piss690u w_piss690u

type variables
string is_areacode,is_divisioncode,is_itemtype,is_itemcode,is_shipdate1,is_shipdate2
boolean ib_open
integer in_index=1,in_rowcount=0
end variables

forward prototypes
public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1)
end prototypes

public subroutine wf_protect (string ag_s_column, integer ag_n_number, datawindow ag_dw_1);string l_s_command
long 	 l_l_color = 15780518
//--	Argument	=> ag_s_column = column 명, 
//---             ag_n_number = column 순서,
ag_dw_1.setredraw(False)
l_s_command	=	ag_s_column + ".Protect = '1" &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) = " + "~~'1~~'," &
					+  " 1, 0 )'"
					
ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)
l_s_command = ' '
l_s_command	=	ag_s_column + ".Background.Color = '" + String(l_l_color) &            
					+	"~tIf(mid(pt_chk," + string(ag_n_number) + ", 1) =" + "~~'1~~'," & 
					+ 	" rgb(192,192,192), 15780518)'"			

ag_dw_1.Modify(l_s_command)
ag_dw_1.setredraw(True)


end subroutine

on w_piss690u.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.uo_itemcode=create uo_itemcode
this.tab_1=create tab_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.uo_itemcode
this.Control[iCurrent+4]=this.tab_1
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_2
end on

on w_piss690u.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.uo_itemcode)
destroy(this.tab_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_retrieve;call super::ue_retrieve;long ln_rowcount
if isnull(is_itemcode) or is_itemcode = '' then
	is_itemcode = '%'
end if
if in_index = 1 then
	tab_1.tabpage_1.dw_tabpage_1.settransobject(sqlpis) 
	tab_1.tabpage_1.dw_tabpage_1.reset()
	tab_1.tabpage_1.dw_tabpage_1.object.tmstpacking_itemcode.protect = true
	tab_1.tabpage_1.dw_tabpage_1.object.tmstpacking_itemcode.background.color = rgb(192,192,192)
	in_rowcount = tab_1.tabpage_1.dw_tabpage_1.retrieve(is_Areacode,is_divisioncode,is_itemcode)	
	if in_rowcount < 1 then
		messagebox("확인", "조회할 정보가 없습니다")
		is_itemcode = ''
	end if
elseif in_index = 2 then
	tab_1.tabpage_2.dw_tabpage_2.settransobject(sqlpis) 
	tab_1.tabpage_2.dw_tabpage_2.reset()
	ln_rowcount = tab_1.tabpage_2.dw_tabpage_2.retrieve(is_Areacode,is_divisioncode,is_itemcode)
	if ln_rowcount < 1 then
		messagebox("확인", "조회할 정보가 없습니다")
		is_itemcode = ''
	end if
elseif in_index = 3 then
	tab_1.tabpage_3.dw_tabpage_3.settransobject(sqlpis) 
	tab_1.tabpage_3.dw_tabpage_3.reset()
	ln_rowcount = tab_1.tabpage_3.dw_tabpage_3.retrieve(is_Areacode,is_divisioncode,is_itemcode,is_shipdate1,is_shipdate2)	
	if ln_rowcount < 1 then
		messagebox("확인", "조회할 정보가 없습니다")
		is_itemcode = ''
	end if
end if

end event

event ue_insert;call super::ue_insert;if in_index = 1 then
	long i 
//	ln_rows = tab_1.tabpage_1.dw_tabpage_1.rowcount()
	tab_1.tabpage_1.dw_tabpage_1.insertrow(0)
	for i = 1 to in_rowcount
			tab_1.tabpage_1.dw_tabpage_1.object.pt_chk[i] = '1'
	next
	tab_1.tabpage_1.dw_tabpage_1.object.pt_chk[in_rowcount + 1] = ' '
	tab_1.tabpage_1.dw_tabpage_1.setfocus()
	tab_1.tabpage_1.dw_tabpage_1.setrow(tab_1.tabpage_1.dw_tabpage_1.rowcount())
	tab_1.tabpage_1.dw_tabpage_1.setcolumn("tmstpacking_itemcode")
//	tab_1.tabpage_1.dw_tabpage_1.setcolumn(4)
	wf_protect("tmstpacking_itemcode",1,tab_1.tabpage_1.dw_tabpage_1)
elseif in_index = 3 then
	tab_1.tabpage_3.dw_detail.visible = true
	tab_1.tabpage_3.dw_detail.reset()
	tab_1.tabpage_3.dw_detail.insertrow(0)
	tab_1.tabpage_3.dw_detail.setfocus()
	tab_1.tabpage_3.dw_detail.setcolumn(1)
	tab_1.tabpage_3.dw_detail.object.outdate.protect  	= false
	tab_1.tabpage_3.dw_detail.object.itemcode.protect 	= false
	tab_1.tabpage_3.dw_detail.object.outqty.protect 	= false
	tab_1.tabpage_3.dw_detail.object.outdate.background.color  	= 15780518
	tab_1.tabpage_3.dw_detail.object.itemcode.background.color  = 15780518
	tab_1.tabpage_3.dw_detail.object.outqty.background.color  	= 15780518

end if

end event

event ue_save;call super::ue_save;long ln_rowcount,i,ln_rackqty,ln_standardqty,ln_savecount,ln_count
string ls_kbno,ls_itemcode,ls_linecode,ls_productgroupname,ls_itemname
dwItemStatus ls_status
//datetime ld_nowtime
 
//ld_nowtime = f_pisc_get_date_nowtime()
//ls_datecym = mid(string(ld_nowtime,'YYYY.MM.DD HH:MM:SS'),1,10)
if in_index = 1 then
	tab_1.tabpage_1.dw_tabpage_1.settransobject(sqlpis)
	ln_rowcount = tab_1.tabpage_1.dw_tabpage_1.rowcount()
	if ln_rowcount < 1 then
		messagebox("확인","저장할 정보가 없습니다")
		return 1
	end if
	tab_1.tabpage_1.dw_tabpage_1.accepttext()
	sqlpis.autocommit = false
	for i = 1 to ln_rowcount
		ls_itemcode		= trim(tab_1.tabpage_1.dw_tabpage_1.object.tmstpacking_itemcode[i])
		if isnull(ls_itemcode) or ls_itemcode = '' then
			tab_1.tabpage_1.dw_tabpage_1.deleterow(i)
			ln_rowcount = ln_rowcount - 1
			i = i - 1
			continue
		end if
		ls_status =  tab_1.tabpage_1.dw_tabpage_1.GetItemStatus(i, 0,Primary!)
		if ls_status = newmodified! then
			select count(*) into :ln_count from tmstmodel
				where	areacode = :is_areacode and divisioncode = :is_divisioncode and itemcode = :ls_itemcode
			using sqlpis ;
			if ln_count = 0 then
				messagebox("확인",ls_itemcode + " 은 품목 상세 정보 미등록품입니다.")
				tab_1.tabpage_1.dw_tabpage_1.deleterow(i)
				sqlpis.autocommit = true
				return 1
			end if
			select count(*) into :ln_count from tmstpacking
				where areacode = :is_areacode and divisioncode = :is_divisioncode and itemcode = :ls_itemcode
			using sqlpis ;
			if ln_count > 0 then
				messagebox("확인",ls_itemcode + " 은 이미 등록된 품번입니다")
				tab_1.tabpage_1.dw_tabpage_1.deleterow(i)
				sqlpis.autocommit = true
				return 1
			end if
			tab_1.tabpage_1.dw_tabpage_1.setitem(i,"tmstpacking_areacode",is_areacode)
			tab_1.tabpage_1.dw_tabpage_1.setitem(i,"tmstpacking_divisioncode",is_divisioncode)	
			tab_1.tabpage_1.dw_tabpage_1.setitem(i,"tmstpacking_lastemp",g_s_empno)	
			tab_1.tabpage_1.dw_tabpage_1.setitem(i,"tmstpacking_lastdate",g_s_datetime)	
			ln_savecount 	= 1
		end if
	next
	if ln_savecount = 1 then
		if tab_1.tabpage_1.dw_tabpage_1.update() <> 1 then
			messagebox("확인2","시스템개발팀에 문의바랍니다")
			rollback using sqlpis;
		else
			commit using sqlpis;
			messagebox("확인","저장성공")
			this.triggerevent("ue_retrieve")
		end if
	end if
end if
sqlpis.autocommit = true




end event

event ue_delete;call super::ue_delete;long ln_rowcount,i,ln_deletecount,ln_count
string ls_itemcode
tab_1.tabpage_1.dw_tabpage_1.settransobject(sqlpis)
ln_rowcount = tab_1.tabpage_1.dw_tabpage_1.rowcount()
sqlpis.autocommit = false
for i = 1 to ln_rowcount
	if	tab_1.tabpage_1.dw_tabpage_1.object.sel[i] = '1' then
		ls_itemcode = tab_1.tabpage_1.dw_tabpage_1.object.tmstpacking_itemcode[i]
		select isnull(count(*),0) into :ln_count from tpackingdetail
			where areacode = :is_areacode and divisioncode = :is_divisioncode and itemcode = :ls_itemcode  
		using sqlpis ;
		if ln_count <> 0 then
			messagebox("확인","품번 " + ls_itemcode + " 는 포장 수불 정보가 존재하는 품번입니다")
			return
		end if
		ln_deletecount = 1
		tab_1.tabpage_1.dw_tabpage_1.deleterow(i)
		ln_rowcount = ln_rowcount - 1
		i = i - 1
	end if
next
if ln_deletecount = 1 then
	if tab_1.tabpage_1.dw_tabpage_1.update() <> 1 then
		messagebox("확인2","시스템개발팀에 문의바랍니다")
		rollback using sqlpis ;
		sqlpis.autocommit = true
		return 
	else
		commit using sqlpis ;
		sqlpis.autocommit = true
	end if
	messagebox("확인","삭제성공")
else
	messagebox("확인","삭제할 정보가 없습니다")
end if
end event

event open;call super::open;tab_1.tabpage_1.dw_tabpage_1.settransobject(sqlpis)
i_b_retrieve = true
i_b_insert = true
i_b_save = true
i_b_delete = true
i_b_dretrieve = false
i_b_dprint = false
i_b_dchar = false
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_dretrieve, &
  	              i_b_dprint,   i_b_dchar)
end event

type uo_status from w_origin_sheet01`uo_status within w_piss690u
integer x = 0
integer y = 2480
end type

type uo_area from u_pisc_select_area within w_piss690u
integer x = 37
integer y = 76
integer taborder = 20
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;string ls_divisionname,ls_divisionnameeng,ls_productgroupname,ls_modelgroupname
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(uo_division.dw_1,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)
tab_1.tabpage_1.dw_tabpage_1.reset()
end event

event ue_post_constructor;call super::ue_post_constructor;string ls_divisionname,ls_divisionnameeng
datawindow ldw_division
ldw_division = uo_division.dw_1
is_areacode = is_uo_areacode
f_pisc_retrieve_dddw_division(ldw_division,g_s_empno,is_areacode,'%',true,is_divisioncode,ls_divisionname,ls_divisionnameeng)

end event

type uo_division from u_pisc_select_division within w_piss690u
integer x = 549
integer y = 76
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

event ue_select;call super::ue_select;is_divisioncode = is_uo_divisioncode
tab_1.tabpage_1.dw_tabpage_1.reset()


end event

type uo_itemcode from u_pisc_select_item_model_kdac within w_piss690u
integer x = 1115
integer y = 56
integer taborder = 50
boolean bringtotop = true
end type

on uo_itemcode.destroy
call u_pisc_select_item_model_kdac::destroy
end on

event ue_select;call super::ue_select;is_itemcode = is_uo_itemcode
end event

type tab_1 from tab within w_piss690u
integer y = 192
integer width = 4571
integer height = 2272
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanged;in_index = newindex
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4535
integer height = 2156
long backcolor = 12632256
string text = "외주포장품번관리"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage_1 dw_tabpage_1
end type

on tabpage_1.create
this.dw_tabpage_1=create dw_tabpage_1
this.Control[]={this.dw_tabpage_1}
end on

on tabpage_1.destroy
destroy(this.dw_tabpage_1)
end on

type dw_tabpage_1 from datawindow within tabpage_1
integer x = 18
integer y = 28
integer width = 3145
integer height = 2112
integer taborder = 20
string title = "none"
string dataobject = "d_piss690u_01"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string 	ls_itemcode,ls_itemname,ls_itemspec,ls_itembuysource,ls_itemclass,ls_itemunit
long		ln_row,ln_findrow,ln_averageunitcost
if dwo.name = 'tmstpacking_itemcode' then
	if isnull(data) or trim(data)= '' then
		return
	end if
	ln_row = this.rowcount()
	ln_findrow = this.find("tmstpacking_itemcode = '" + data +"'",0,row - 1)
	if ln_findrow = 0 then
//		select itemclass,itembuysource,itemunit,averageunitcost into 
//				:ls_itemclass,:ls_itembuysource,:ls_itemunit,:ln_averageunitcost from tmstmodel
//      where areacode = :is_Areacode and divisioncode = :is_divisioncode and
//				itemcode = :data
//		using sqlpis ;
//		if sqlpis.sqlcode <> 0 then
//			this.setitem(row,'tmstmodel_itembuysource','')	
//			this.setitem(row,'tmstitem_itemclass','')	
//			this.setitem(row,'tmstmodel_itemunit','')	
//			this.setitem(row,'tmstmodel_averageunitcost',0)				
//		else
//			this.setitem(row,'tmstmodel_itembuysource',ls_itembuysource)	
//			this.setitem(row,'tmstitem_itemclass',ls_itemclass)	
//			this.setitem(row,'tmstmodel_itemunit',ls_itemunit)	
//			this.setitem(row,'tmstmodel_averageunitcost',ln_averageunitcost)			
//		end if
		select distinct c.itemspec,c.itemname into :ls_itemspec , :ls_itemname 
		from tmstitem c
		where c.itemcode = :data
		using sqlpis ;
		if sqlpis.sqlcode <> 0 then
			this.setitem(row,'tmstitem_itemname','')	
			this.setitem(row,'tmstitem_itemspec','')
		else
			this.setitem(row,'tmstitem_itemname',ls_itemname)	
			this.setitem(row,'tmstitem_itemspec',ls_itemspec)
		end if
	else
		return 1
	end if
end if
end event

event constructor;tab_1.tabpage_1.dw_tabpage_1.settransobject(sqlpis)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4535
integer height = 2156
long backcolor = 12632256
string text = "현품표 조회"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_tabpage_2 dw_tabpage_2
end type

on tabpage_2.create
this.dw_tabpage_2=create dw_tabpage_2
this.Control[]={this.dw_tabpage_2}
end on

on tabpage_2.destroy
destroy(this.dw_tabpage_2)
end on

type dw_tabpage_2 from datawindow within tabpage_2
integer x = 18
integer y = 28
integer width = 4498
integer height = 2112
integer taborder = 60
string title = "none"
string dataobject = "d_piss690u_02"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlpis)
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4535
integer height = 2156
long backcolor = 12632256
string text = "외주포장수불정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
uo_to uo_to
uo_from uo_from
dw_tabpage_3 dw_tabpage_3
dw_detail dw_detail
gb_3 gb_3
end type

on tabpage_3.create
this.uo_to=create uo_to
this.uo_from=create uo_from
this.dw_tabpage_3=create dw_tabpage_3
this.dw_detail=create dw_detail
this.gb_3=create gb_3
this.Control[]={this.uo_to,&
this.uo_from,&
this.dw_tabpage_3,&
this.dw_detail,&
this.gb_3}
end on

on tabpage_3.destroy
destroy(this.uo_to)
destroy(this.uo_from)
destroy(this.dw_tabpage_3)
destroy(this.dw_detail)
destroy(this.gb_3)
end on

type uo_to from u_pisc_date_applydate_1 within tabpage_3
event destroy ( )
integer x = 818
integer y = 68
integer taborder = 50
boolean bringtotop = true
end type

on uo_to.destroy
call u_pisc_date_applydate_1::destroy
end on

event constructor;call super::constructor;is_shipdate2 = is_uo_date
end event

event ue_losefocus;is_shipdate2 = is_uo_date
end event

event ue_select;call super::ue_select;if is_shipdate2 <> is_uo_date then
//	dw_sheet.reset()
end if	
is_shipdate2 = is_uo_date

end event

type uo_from from u_pisc_date_firstday within tabpage_3
event destroy ( )
integer x = 87
integer y = 68
integer taborder = 30
boolean bringtotop = true
end type

on uo_from.destroy
call u_pisc_date_firstday::destroy
end on

event constructor;call super::constructor;is_shipdate1 = is_uo_date
end event

event ue_losefocus;call super::ue_losefocus;is_shipdate1 = is_uo_date

end event

event ue_select;call super::ue_select;if is_shipdate1 <> is_uo_date then
//	dw_sheet.reset()
end if	
is_shipdate1 = is_uo_date

end event

type dw_tabpage_3 from datawindow within tabpage_3
integer x = 18
integer y = 200
integer width = 4462
integer height = 1952
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_piss690u_03"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;if row > 0 then
	string 	ls_itemcode,ls_outdate,ls_areacode,ls_divisioncode
	long		ln_outqty,ln_inqty
	ls_itemcode 	 	= this.object.tpackingdetail_itemcode[row]
	ls_outdate 		 	= this.object.tpackingdetail_outdate[row]	
	ls_areacode 	 	= this.object.tpackingdetail_areacode[row]
	ls_divisioncode 	= this.object.tpackingdetail_divisioncode[row]	
		
		
	if this.object.tpackingdetail_outqty[row] = this.object.tpackingdetail_inqty[row] then
		messagebox("확인","이미 포장 입고가 완료된 항목입니다")
		return
	end if
	tab_1.tabpage_3.dw_detail.object.tpackingdetail_outdate.protect  	= true
	tab_1.tabpage_3.dw_detail.object.tpackingdetail_itemcode.protect 	= true
	tab_1.tabpage_3.dw_detail.object.tpackingdetail_outqty.protect 	= true
	tab_1.tabpage_3.dw_detail.object.tpackingdetail_outdate.background.color  	= rgb(192,192,192)
	tab_1.tabpage_3.dw_detail.object.tpackingdetail_itemcode.background.color  = rgb(192,192,192)
	tab_1.tabpage_3.dw_detail.object.tpackingdetail_outqty.background.color  	= rgb(192,192,192)
	tab_1.tabpage_3.dw_detail.retrieve(ls_areacode,ls_divisioncode,ls_itemcode,ls_outdate)
end if
end event

type dw_detail from datawindow within tabpage_3
boolean visible = false
integer x = 1042
integer y = 220
integer width = 1317
integer height = 800
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "외주포장수불"
string dataobject = "d_piss690u_03_1"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;this.settransobject(sqlpis)
end event

event buttonclicked;if dwo.name = 'b_exit' then
	tab_1.tabpage_3.dw_detail.visible = false
end if
if dwo.name = 'b_save' then
	this.accepttext()
	string ls_areacode,ls_divisioncode,ls_itemcode,ls_outdate,ls_indate
	long 	 ln_outqty,ln_inqty,ln_count
	ls_areacode 		=	this.object.areacode[1]
	ls_divisioncode 	=	this.object.divisioncode[1]	
	ls_itemcode		 	=	this.object.itemcode[1]	
	ls_outdate		 	=	this.object.outdate[1]	
	ln_outqty		 	=	this.object.outqty[1]	
	ls_indate		 	=	this.object.indate[1]	
	ln_inqty			 	=	this.object.inqty[1]
	select count(*) into :ln_count from tmstpacking
		where	areacode = :ls_areacode and divisioncode = :ls_divisioncode and itemcode = :ls_itemcode
	using sqlpis ;
	if ln_count <> 1 then
		messagebox("확인","해당품번은 외주포장대상 품번이 아닙니다.")
		return
	end if		
	if ls_outdate < ls_indate then
		messagebox("확인","일자를 확인하십시오")
		return
	end if
	if ln_outqty < ln_inqty or ln_outqty < 0 or ln_inqty < 0 then
		messagebox("확인","수량을 확인하십시오")
		return
	end if	
	select count(*) into :ln_count from tpackingdetail
		where	outdate = :ls_outdate and areacode = :ls_areacode and divisioncode = :ls_divisioncode and itemcode = :ls_itemcode
	using sqlpis ;
	sqlpis.autocommit = false
	if ln_count = 0 then
		insert into tpackingdetail
		values ( :ls_outdate,:ls_areacode,:ls_divisioncode,:ls_itemcode,:ln_outqty,:ls_indate,:ln_inqty,:g_s_empno,:g_s_datetime)
		using sqlpis ;	
	else
		update	tpackingdetail
			set	outqty = :ln_outqty,indate = :ls_indate,inqty = :ln_inqty,lastemp = :g_s_empno,lastdate = :g_s_datetime
		where	outdate = :ls_outdate and areacode = :ls_areacode and divisioncode = :ls_divisioncode and itemcode = :ls_itemcode
		using sqlpis ;
	end if
	if sqlpis.sqlcode <> 0 then
		messagebox("저장실패","시스템개발팀으로 연락바랍니다")
		rollback using sqlpis ;
	else
		commit using sqlpis ;
	end if
	sqlpis.autocommit = false	
end if
end event

type gb_3 from groupbox within tabpage_3
integer x = 18
integer y = -4
integer width = 1280
integer height = 192
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_piss690u
integer width = 4571
integer height = 180
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_piss690u
integer x = 37
integer y = 288
integer width = 549
integer height = 324
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "none"
end type

