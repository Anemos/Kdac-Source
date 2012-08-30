$PBExportHeader$w_pisf022.srw
$PBExportComments$작명일정관리
forward
global type w_pisf022 from w_cmms_sheet01
end type
type cb_4 from commandbutton within w_pisf022
end type
type cb_1 from commandbutton within w_pisf022
end type
type dw_1 from datawindow within w_pisf022
end type
type cb_2 from commandbutton within w_pisf022
end type
type cb_3 from commandbutton within w_pisf022
end type
type st_currentdate from statictext within w_pisf022
end type
type dw_mon_sum from datawindow within w_pisf022
end type
type dw_gr_mon_sum from datawindow within w_pisf022
end type
type st_tip from statictext within w_pisf022
end type
type dw_monsum_source from datawindow within w_pisf022
end type
type gb_1 from groupbox within w_pisf022
end type
type st_1 from statictext within w_pisf022
end type
type tab_wo_delay from tab within w_pisf022
end type
type tp_delay_list from userobject within tab_wo_delay
end type
type dw_wo_delay_01 from uo_datawindow within tp_delay_list
end type
type dw_wo_delay from uo_datawindow within tp_delay_list
end type
type tp_delay_list from userobject within tab_wo_delay
dw_wo_delay_01 dw_wo_delay_01
dw_wo_delay dw_wo_delay
end type
type tab_wo_delay from tab within w_pisf022
tp_delay_list tp_delay_list
end type
type tab_plan from tab within w_pisf022
end type
type tp_list from userobject within tab_plan
end type
type dw_task_list from uo_datawindow within tp_list
end type
type dw_wo_list from uo_datawindow within tp_list
end type
type tp_list from userobject within tab_plan
dw_task_list dw_task_list
dw_wo_list dw_wo_list
end type
type tp_working from userobject within tab_plan
end type
type dw_working_list_01 from uo_datawindow within tp_working
end type
type dw_working_list from uo_datawindow within tp_working
end type
type tp_working from userobject within tab_plan
dw_working_list_01 dw_working_list_01
dw_working_list dw_working_list
end type
type tab_plan from tab within w_pisf022
tp_list tp_list
tp_working tp_working
end type
type uo_area from u_cmms_select_area within w_pisf022
end type
type uo_division from u_cmms_select_division within w_pisf022
end type
type gb_2 from groupbox within w_pisf022
end type
end forward

global type w_pisf022 from w_cmms_sheet01
integer width = 4448
integer height = 2508
string title = "작업일정관리"
event ue_retrieve_calendar ( )
event ue_retrieve_delay_list ( )
event ue_retrieve_multi_dates ( )
event ue_retrieve_wo_working ( )
cb_4 cb_4
cb_1 cb_1
dw_1 dw_1
cb_2 cb_2
cb_3 cb_3
st_currentdate st_currentdate
dw_mon_sum dw_mon_sum
dw_gr_mon_sum dw_gr_mon_sum
st_tip st_tip
dw_monsum_source dw_monsum_source
gb_1 gb_1
st_1 st_1
tab_wo_delay tab_wo_delay
tab_plan tab_plan
uo_area uo_area
uo_division uo_division
gb_2 gb_2
end type
global w_pisf022 w_pisf022

type variables
date is_currentdate

long il_row_begin
long il_mousemove_row
long il_clicked_row
long il_first_selected_row = 0
long il_last_selected_row = 0

boolean ib_button_down
boolean ib_drag_button_down

datawindow id_dw_list_02
datawindow id_dw_list_01

datawindow id_dw_delay_list
datawindow id_dw_delay_list_01

datawindow id_dw_working_list
datawindow id_dw_working_list_01

string is_sql_list
string is_sql_list_01

string is_sql_delay_list
string is_sql_delay_list_01

string is_wono_delay
string is_taskno_delay

string is_wono
string is_taskno

string is_sql_working_list
string is_sql_working_list_01

string is_sql_calendar
string is_sql_calendar_01

boolean ib_opened = false
end variables

forward prototypes
public function date wf_get_lastdate (date pd_currentdate)
public subroutine wf_set_calendar_week (date pd_date)
public function date wf_get_first_date (date pd_currentdate)
end prototypes

event ue_retrieve_calendar();string ls_yyyymm
date ld_firstdate
date ld_lastdate
string ls_from, ls_to
string ls_wostatcode
long ll_rowcount, i
long ll_count,ll_count1
long ll_find
string ls_where
datawindowchild ldwc

dw_1.SetRedraw(false)
dw_1.reset()

if isnull(is_currentdate) or is_currentdate <= 1900-01-01 then is_currentdate = date(string(g_s_date,"@@@@-@@-@@"))

ls_yyyymm = string(is_currentdate, 'yyyymm')

dw_1.settransobject(sqlcmms)

id_dw_list_01.GetChild('emp_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if
choose case tab_plan.SelectedTab
	case 1
		dw_1.retrieve(ls_yyyymm, '계획', gs_kmarea, gs_kmdivision)
		st_currentdate.text = string(is_currentdate, 'yyyy-mm') + ' (계획)'
	case 2
		dw_1.retrieve(ls_yyyymm, '진행중', gs_kmarea, gs_kmdivision)
		st_currentdate.text = string(is_currentdate, 'yyyy-mm') + ' (진행중)'
end choose

ld_firstdate = wf_get_first_date(is_currentdate)
wf_set_calendar_week(ld_firstdate)
dw_1.SetRedraw(true)

// goto today's date
ll_find = dw_1.find(" string(ddate, 'yyyymmdd') = " + "'" + g_s_date + "'", 1, dw_1.rowcount())
if ll_find > 0 then
	dw_1.SelectRow(0, false)
	dw_1.SetRow(ll_find)
	dw_1.SelectRow(ll_find, true)
	il_first_selected_row = ll_find
	il_last_selected_row = ll_find
	this.TriggerEvent('ue_retrieve_multi_dates')
else
	id_dw_list_01.reset()
	id_dw_list_02.reset()
	id_dw_working_list.reset()
	id_dw_working_list_01.reset()
end if

//if string(is_currentdate, 'yyyy-mm') = mid(string(dw_gr_mon_sum.title),1,7) then  // 한번 조회한 월의 데이터는 다시 조회하지 않는다.
//	return
//end if

dw_gr_mon_sum.title = string(is_currentdate, 'yyyy-mm') + ' 작업현황'

ld_lastdate = wf_get_lastdate(ld_firstdate)
ls_from = string(ld_firstdate, 'yyyymmdd')
ls_to = string(ld_lastdate, 'yyyymmdd')

dw_mon_sum.SetTransObject(sqlcmms)
dw_mon_sum.reset()
dw_mon_sum.InsertRow(0)

dw_mon_sum.SetItem(1, 'll_plan', 0)
dw_mon_sum.SetItem(1, 'll_done', 0)
dw_mon_sum.SetItem(1, 'll_working', 0)
dw_mon_sum.SetItem(1, 'll_delay', 0)
dw_mon_sum.SetItem(1, 'll_closed', 0)

dw_monsum_source.reset()  // test
dw_monsum_source.Retrieve(ls_from, ls_to, gs_kmarea, gs_kmdivision)
ll_rowcount = dw_monsum_source.RowCount()
if ll_rowcount > 0 then
	dw_mon_sum.SetItem(1, 'ls_title', string(ld_firstdate, 'yyyy년mm월 작업현황'))
	for i=1 to ll_rowcount
		ls_wostatcode = dw_monsum_source.GetItemString(i, 'wostatcode')
		ll_count = dw_monsum_source.GetItemNumber(i, 'wocount')
		choose case ls_wostatcode
			case 'd계획'
				dw_mon_sum.SetItem(1, 'll_plan', ll_count)
				ll_count1=ll_count1+ll_count
			case 'c진행중'
				dw_mon_sum.SetItem(1, 'll_working', ll_count)
				ll_count1=ll_count1+ll_count
			case 'b마감'
				dw_mon_sum.SetItem(1, 'll_closed', ll_count)
				ll_count1=ll_count1+ll_count
			case '완료'
				//dw_mon_sum.SetItem(1, 'll_done', ll_count)
			case 'a지연'
				dw_mon_sum.SetItem(1, 'll_delay', ll_count)
		end choose
		
	next
	dw_mon_sum.SetItem(1, 'll_done', ll_count1)
end if

dw_gr_mon_sum.reset()
dw_gr_mon_sum.Retrieve(ls_from, ls_to, gs_kmarea, gs_kmdivision)
end event

event ue_retrieve_delay_list();string ls_and, ls_and1
ls_and1 = "where wo.area_code = '"+gs_kmarea+ "' and wo.factory_code='"+gs_kmdivision +"' and CONVERT(VARCHAR(8), wo_estend_date, 112) < CONVERT(VARCHAR(8),GETDATE(), 112) AND wo_state_code IN ('계획', '진행중') order by wo.wo_estend_date desc "
ls_and = "where task.area_code = '"+gs_kmarea+ "' and task.factory_code='"+gs_kmdivision +"' and CONVERT(VARCHAR(8), exam_date, 112) < CONVERT(VARCHAR(8),GETDATE(), 112) AND status_code IN ('계획', '진행중') order by task.exam_date desc "
 
id_dw_delay_list.object.datawindow.table.select = is_sql_delay_list + ls_and1
id_dw_delay_list.retrieve()

id_dw_delay_list_01.object.datawindow.table.select = is_sql_delay_list_01 + ls_and
id_dw_delay_list_01.retrieve()
end event

event ue_retrieve_multi_dates();string ls_from_ymd
string ls_to_ymd
datetime ldt_from, ldt_to
string ls_and, ls_and1

id_dw_working_list.reset()
if il_first_selected_row <= 0 or il_last_selected_row <=0 then return

ldt_from = dw_1.GetItemDateTime(il_first_selected_row, 'ddate')
ldt_to = dw_1.GetItemDateTime(il_last_selected_row, 'ddate')

ls_from_ymd = string(ldt_from, 'yyyymmdd')
ls_to_ymd = string(ldt_to, 'yyyymmdd')

choose case tab_plan.selectedtab
	case 1
		ls_and = "where wo.area_code = '"+gs_kmarea+ "' and wo.factory_code='"+gs_kmdivision +"' and convert(varchar(8),wo.wo_float_date,112) between '"+ls_from_ymd+"' and '"+ls_to_ymd+"'" + &
		         " and wo.wo_state_code ='계획' order by wo.wo_float_date desc"

		id_dw_list_02.object.datawindow.table.select = is_sql_list + ls_and
		id_dw_list_02.retrieve()
				
		ls_and1 = "where task.area_code = '"+gs_kmarea+ "' and task.factory_code='"+gs_kmdivision +"' and convert(varchar(8),task.exam_date,112) between '"+ls_from_ymd+"' and '"+ls_to_ymd+"'" + &
		         " and task.status_code ='계획' order by task.exam_date desc"
				
		id_dw_list_01.object.datawindow.table.select = is_sql_list_01 + ls_and1
		id_dw_list_01.retrieve()
		
	case 2
		this.TriggerEvent('ue_retrieve_wo_working')
end choose
		

end event

event ue_retrieve_wo_working();string ls_and, ls_from, ls_to, ls_and1
datetime ldt_from, ldt_to

if il_first_selected_row <= 0 or il_last_selected_row <= 0 then return

ldt_from = dw_1.GetItemDateTime(il_first_selected_row, 'ddate')
ldt_to = dw_1.GetItemDateTime(il_last_selected_row, 'ddate')

ls_from = string(ldt_from, 'yyyymmdd')
ls_to = string(ldt_to, 'yyyymmdd')

ls_and ="where wo.area_code = '"+gs_kmarea+ "' and wo.factory_code='"+gs_kmdivision +"'"+ ' and ' + & 
	" (((( '" + ls_from + "' BETWEEN CONVERT(VARCHAR(8),isnull(wo.wo_START_DATE,'1900-01-01'), 112) AND CONVERT(VARCHAR(8), isnull(wo.wo_ESTEND_DATE,'9999-12-31'), 112) ) " + & 
   "  OR ( '" + ls_to + "' BETWEEN CONVERT(VARCHAR(8), isnull(wo.wo_START_DATE,'1900-01-01'), 112) AND CONVERT(VARCHAR(8), isnull(wo.wo_ESTEND_DATE,'9999-12-31'), 112) ) ) " + & 
	" OR (( CONVERT(VARCHAR(8), isnull(wo.wo_START_DATE,'1900-01-01'), 112) BETWEEN '" +  ls_from + "' AND '" + ls_to + "' ) " + & 
	"   OR ( CONVERT(VARCHAR(8), isnull(wo.wo_ESTEND_DATE,'9999-12-31'), 112) BETWEEN '" + ls_from + "' AND '" + ls_to + "' ) )) )" + &
	" AND wo.wo_STATe_CODE = '진행중' order by wo.wo_float_date desc"
id_dw_working_list.object.datawindow.table.select = is_sql_working_list + ls_and
id_dw_working_list.retrieve()
 
ls_and1 = "where task.area_code = '"+gs_kmarea+ "' and task.factory_code='"+gs_kmdivision +"' and convert(varchar(8),task.exam_date,112) between '"+ls_from+"' and '"+ls_to+"'" + &
		         " and task.status_code ='진행중' order by task.exam_date desc"
					
id_dw_working_list_01.object.datawindow.table.select = is_sql_working_list_01 + ls_and1
id_dw_working_list_01.retrieve()

end event

public function date wf_get_lastdate (date pd_currentdate);date		ld_current_date
integer 	li_date
integer	li_month
integer	li_year
integer	li_current_month

li_date = 26
li_month = month(pd_currentdate)
li_year = year(pd_currentdate)

if li_month <> 12 then
	li_month = li_month + 1
else
	li_month = 1
	li_year = li_year + 1
end if

ld_current_date = date(li_year, li_month, 1)

ld_current_date = RelativeDate(ld_current_date, -1)
return ld_current_date

end function

public subroutine wf_set_calendar_week (date pd_date);choose case daynumber(pd_date)
	case 1   // 일요일
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
	case 2  // 월요일
		// do nothing
	case 3  // 화요일
		dw_1.insertrow(1)
	case 4  //수요일
		dw_1.insertrow(1)
		dw_1.insertrow(1)
	case 5  //목요일
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
	case 6  // 금요일
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
	case 7  // 토요일
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
		dw_1.insertrow(1)
end choose

return
end subroutine

public function date wf_get_first_date (date pd_currentdate);date		ld_current_date
integer 	li_date
integer	li_month
integer	li_year
integer	li_current_month

li_date = 1
li_month = month(pd_currentdate)
li_year = year(pd_currentdate)

ld_current_date = date(li_year, li_month, 1)

return ld_current_date
return ld_current_date
end function

on w_pisf022.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_currentdate=create st_currentdate
this.dw_mon_sum=create dw_mon_sum
this.dw_gr_mon_sum=create dw_gr_mon_sum
this.st_tip=create st_tip
this.dw_monsum_source=create dw_monsum_source
this.gb_1=create gb_1
this.st_1=create st_1
this.tab_wo_delay=create tab_wo_delay
this.tab_plan=create tab_plan
this.uo_area=create uo_area
this.uo_division=create uo_division
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.st_currentdate
this.Control[iCurrent+7]=this.dw_mon_sum
this.Control[iCurrent+8]=this.dw_gr_mon_sum
this.Control[iCurrent+9]=this.st_tip
this.Control[iCurrent+10]=this.dw_monsum_source
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.tab_wo_delay
this.Control[iCurrent+14]=this.tab_plan
this.Control[iCurrent+15]=this.uo_area
this.Control[iCurrent+16]=this.uo_division
this.Control[iCurrent+17]=this.gb_2
end on

on w_pisf022.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_currentdate)
destroy(this.dw_mon_sum)
destroy(this.dw_gr_mon_sum)
destroy(this.st_tip)
destroy(this.dw_monsum_source)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.tab_wo_delay)
destroy(this.tab_plan)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.gb_2)
end on

event open;call super::open;datawindowchild ldwc

id_dw_list_02 = tab_plan.tp_list.dw_wo_list
id_dw_list_02.SetTransObject(sqlcmms)
is_sql_list = id_dw_list_02.GetSqlSelect()

id_dw_list_01 = tab_plan.tp_list.dw_task_list
id_dw_list_01.SetTransObject(sqlcmms)
is_sql_list_01 = id_dw_list_01.GetSqlSelect()

id_dw_working_list = tab_plan.tp_working.dw_working_list
id_dw_working_list.SetTransObject(sqlcmms)
is_sql_working_list = id_dw_working_list.GetSqlSelect()

id_dw_working_list_01 = tab_plan.tp_working.dw_working_list_01
id_dw_working_list_01.SetTransObject(sqlcmms)
is_sql_working_list_01 = id_dw_working_list_01.GetSqlSelect()

id_dw_delay_list = tab_wo_delay.tp_delay_list.dw_wo_delay
id_dw_delay_list.SetTransObject(sqlcmms)
is_sql_delay_list = id_dw_delay_list.GetSqlSelect()

id_dw_delay_list_01 = tab_wo_delay.tp_delay_list.dw_wo_delay_01

id_dw_delay_list_01.SetTransObject(sqlcmms)
is_sql_delay_list_01 = id_dw_delay_list_01.GetSqlSelect()

dw_monsum_source.SetTransObject(sqlcmms)
dw_gr_mon_sum.SetTransObject(sqlcmms)

dw_1.SetTransObject(sqlcmms)
is_sql_calendar = dw_1.GetSqlSelect()

is_sql_calendar = mid(is_sql_calendar, 1, pos(is_sql_calendar, 'group') -1)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false,  false, false, false, false)
end event

event resize;call super::resize;tab_plan.width = this.width - 1194

tab_plan.tp_list.dw_wo_list.width = tab_plan.width - 36
tab_plan.tp_list.dw_task_list.width = tab_plan.tp_list.dw_wo_list.width

tab_plan.tp_working.dw_working_list.width = tab_plan.tp_list.dw_wo_list.width
tab_plan.tp_working.dw_working_list_01.width = tab_plan.tp_list.dw_wo_list.width

tab_wo_delay.width = this.width - 1184
tab_wo_delay.height = this.height - tab_plan.Height - 230

tab_wo_delay.tp_delay_list.dw_wo_delay.width = tab_wo_delay.width - 36
tab_wo_delay.tp_delay_list.dw_wo_delay_01.width = tab_wo_delay.width - 36

tab_wo_delay.tp_delay_list.dw_wo_delay.height = (tab_wo_delay.height - 140)/2

tab_wo_delay.tp_delay_list.dw_wo_delay_01.y = tab_wo_delay.tp_delay_list.dw_wo_delay.height+10
tab_wo_delay.tp_delay_list.dw_wo_delay_01.height = (tab_wo_delay.height - 140)/2

dw_gr_mon_sum.height = tab_wo_delay.height - dw_mon_sum.height - 5

end event

event ue_retrieve;call super::ue_retrieve;
This.triggerEvent('ue_retrieve_calendar')
This.triggerEvent('ue_retrieve_multi_dates')
This.triggerEvent('ue_retrieve_delay_list')



end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

id_dw_list_02.SetTransObject(sqlcmms)
id_dw_list_01.SetTransObject(sqlcmms)
id_dw_working_list.SetTransObject(sqlcmms)
id_dw_working_list_01.SetTransObject(sqlcmms)
id_dw_delay_list.SetTransObject(sqlcmms)
id_dw_delay_list_01.SetTransObject(sqlcmms)
dw_monsum_source.SetTransObject(sqlcmms)
dw_gr_mon_sum.SetTransObject(sqlcmms)
dw_1.SetTransObject(sqlcmms)

id_dw_list_01.GetChild('emp_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if	

id_dw_list_02.GetChild('wo_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_list_02.GetChild('wo_state_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_working_list_01.GetChild('emp_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_working_list.GetChild('wo_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_working_list.GetChild('wo_state_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_delay_list_01.GetChild('emp_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_delay_list.GetChild('wo_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

id_dw_delay_list.GetChild('wo_state_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

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

id_dw_list_02.SetTransObject(sqlcmms)
id_dw_list_01.SetTransObject(sqlcmms)
id_dw_working_list.SetTransObject(sqlcmms)
id_dw_working_list_01.SetTransObject(sqlcmms)
id_dw_delay_list.SetTransObject(sqlcmms)
id_dw_delay_list_01.SetTransObject(sqlcmms)
dw_monsum_source.SetTransObject(sqlcmms)
dw_gr_mon_sum.SetTransObject(sqlcmms)
dw_1.SetTransObject(sqlcmms)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 다음, 끝, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false,  false, false, false, false)
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf022
integer x = 0
integer y = 2288
end type

type cb_4 from commandbutton within w_pisf022
integer x = 649
integer y = 1756
integer width = 457
integer height = 84
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "작업지시서 인쇄"
end type

event clicked;if is_wono='' or isnull(is_wono) then return
OpenSheet(w_report_preview, w_frame, 0, Layered!)

w_report_preview.dw_report.dataobject = 'dr_wo_report'
w_report_preview.dw_report.SetTransObject(sqlcmms)
w_report_preview.dw_report.retrieve(is_wono)

w_report_preview.TriggerEvent('ue_preview_mode')
end event

type cb_1 from commandbutton within w_pisf022
integer x = 37
integer y = 1756
integer width = 402
integer height = 84
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "작업지시 발행"
end type

event clicked; OpenSheet(w_pisf020, w_frame, 0, Layered!)

end event

type dw_1 from datawindow within w_pisf022
event ue_lbutton_down pbm_lbuttondown
event ue_lbutton_up pbm_lbuttonup
event ue_mousemove pbm_mousemove
integer x = 27
integer y = 300
integer width = 1079
integer height = 860
integer taborder = 40
string dataobject = "d_wo_schdule_calendar"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lbutton_down;String ls_dwo
long ll_row

ls_dwo = this.GetObjectAtPointer()
il_row_begin = long ( mid(ls_dwo, pos(ls_dwo, '~t') + 1, len(ls_dwo) - pos(ls_dwo, '~t') + 1) )

if il_row_begin <= 0 then return

ib_button_down = true

end event

event ue_lbutton_up;String ls_dwo
long ll_row

ls_dwo = this.GetObjectAtPointer()
il_row_begin = long ( mid(ls_dwo, pos(ls_dwo, '~t') + 1, len(ls_dwo) - pos(ls_dwo, '~t') + 1) )

if il_row_begin <= 0 then return

ib_button_down = false

parent.TriggerEvent('ue_retrieve_multi_dates')
end event

event ue_mousemove;String ls_dwo
long ll_row, ll_rowcount
long ll_from, ll_to, i

ll_rowcount = this.Rowcount()
if ib_button_down = false or not KeyDown(KeyLeftButton!) then return // left 버튼이 눌러진 상태가 아니면 return
if il_row_begin <= 0 then return

ls_dwo = this.GetObjectAtPointer()
// 현재 마우스가 이동하고 있는 row값을 구한다.
ll_row = long ( mid(ls_dwo, pos(ls_dwo, '~t') + 1, len(ls_dwo) - pos(ls_dwo, '~t') + 1) ) 
if ll_row <= 0 or ll_row > ll_rowcount then return

if isnull(GetItemDateTime(ll_row, 'ddate')) then return

if ll_row = il_row_begin then // 만약 마우스가 이동을 시작하는 row와 이동중인 row의 값이 같으면 
	if keydown(KeySHIFT!) then return  // shift 키가 눌러진 상태이면 return
	if isnull(GetItemDateTime(ll_row, 'ddate')) then return // 마우스가 이동중인 row의 날짜가 없으면 return
	this.SetRedraw(false)
	this.selectrow(0,false) // select된 모든 row를 해제
	this.setrow(ll_row)
	this.selectrow(ll_row, true)	// 현재 row를 highlight
	this.SetRedraw(true)
	return
end if
	
if il_mousemove_row <> ll_row then
	il_mousemove_row = ll_row

	ll_from = min(il_row_begin, ll_row)
	ll_to = max(il_row_begin, ll_row)
	if ll_to > this.RowCount() then ll_to = this.RowCount()

	il_first_selected_row = ll_from
	il_last_selected_row = ll_to
	
	this.SetRedraw(false)	
	selectrow(0, false)
	for i = ll_from to ll_to
		if not isnull(this.GetItemDatetime(i, 'ddate')) then
			this.SetRow(i)
			this.SelectRow(i, true)
		end if
	next
	this.SetRedraw(true)	
end if
end event

event clicked;datetime ld_datetime
string ls_code
string ls_where

if row <= 0 then return
if isnull(GetItemDateTime(row, 'ddate')) then return


IF KeyDown(KeySHIFT!) THEN
	f_shift_highlight(this, row, il_clicked_row)
	il_first_selected_row = min(row, il_clicked_row)
	il_last_selected_row = max(row,il_clicked_row)
else
	if not isnull(GetItemDateTime(row, 'ddate')) then
		selectrow(0, false)
		setrow(row)
		selectrow(row, true)
		il_clicked_row = row
		il_first_selected_row = row
		il_last_selected_row = row

	end if
end if


end event

event dragdrop;//if row <= 0 then return
//if isnull(GetItemDateTime(row, 'ddate')) then return
//
//datetime ldt_newdate
//datawindow ld_dw
//long ll_row
//string ls_code
//
//
//ldt_newdate = GetItemDateTime(row, 'ddate')
//
//if TypeOf(source) = DataWindow! then
//	ld_dw = source
//
//	choose case ld_dw.classname()
//		case 'dw_wo_list'
//			ll_row = ld_dw.GetRow()
//			if ll_row > 0 then
//				ld_dw.SetItem(ll_row, 'PLANDATE', this.GetItemDateTime(row, 'ddate'))
//				ld_dw.SetItem(ll_row, 'ESTENDDATE', this.GetItemDateTime(row, 'ddate'))
//				if ld_dw.update() <> 1 then
//					// 실패
//					MessageBox('SQL Error', '데이터 저장중 에러 발생, 시스템 관리자에게 문의하십시오.')
//				else
//					commit;					
//				end if
//			end if
//		case 'dw_wo_delay'
//			ll_row = ld_dw.GetRow()
//			if ll_row > 0 then
//				ld_dw.SetItem(ll_row, 'PLANDATE', this.GetItemDateTime(row, 'ddate'))
//				ld_dw.SetItem(ll_row, 'ESTENDDATE', this.GetItemDateTime(row, 'ddate'))
//				if ld_dw.update() <> 1 then
//					// 실패
//					MessageBox('SQL Error', '데이터 저장중 에러 발생, 시스템 관리자에게 문의하십시오.')
//				else
//					commit;					
//				end if
//			end if
//	end choose
//end if
//			
//parent.TriggerEvent('ue_retrieve_calendar')
//parent.TriggerEvent('ue_retrieve_multi_dates')
//parent.TriggerEvent('ue_retrieve_delay_list')
end event

type cb_2 from commandbutton within w_pisf022
integer x = 878
integer y = 228
integer width = 229
integer height = 76
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = ">>"
end type

event clicked;date ld_firstdate
date ld_date
string ls_yyyymm

ld_date = wf_get_lastdate(is_currentdate)

ld_date = RelativeDate ( ld_date, 1 )

is_currentdate = ld_date


parent.triggerevent('ue_retrieve_calendar')


end event

type cb_3 from commandbutton within w_pisf022
integer x = 27
integer y = 228
integer width = 229
integer height = 76
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
string text = "<<"
end type

event clicked;date ld_firstdate
date ld_date
string ls_yyyymm

ld_date = wf_get_first_date(is_currentdate)
ld_date = RelativeDate ( ld_date, -1 )
is_currentdate = ld_date
ls_yyyymm = string(ld_date, 'yyyymm')
st_currentdate.text = string(ld_date, 'yyyy-mm-dd')

parent.triggerevent('ue_retrieve_calendar')	
	
end event

type st_currentdate from statictext within w_pisf022
integer x = 256
integer y = 228
integer width = 626
integer height = 80
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 32567536
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_mon_sum from datawindow within w_pisf022
integer x = 14
integer y = 1180
integer width = 1111
integer height = 548
integer taborder = 20
string dataobject = "d_wo_monsum"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_gr_mon_sum from datawindow within w_pisf022
event ue_lbuttonup pbm_lbuttonup
integer x = 5
integer y = 1868
integer width = 1120
integer height = 360
integer taborder = 20
boolean titlebar = true
string dataobject = "dg_mon_sum_wo_stat"
boolean maxbox = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_lbuttonup;st_tip.visible = false
end event

event clicked;//f_graph_value_popup(this, st_value, string(dwo.name), '건')
grObjectType currobj
String ls_graph , ls_tip
Int li_series , li_datapoint , li_posx , li_posy

ls_graph = GetObjectAtPointer()
ls_graph = Left(ls_graph, Pos(ls_graph, '~t') -1)

currobj = ObjectAtPointer(ls_graph , li_series , li_datapoint)

CHOOSE CASE currobj
 CASE TypeData!
   ls_tip = String( GetData(ls_graph , li_series , li_datapoint) , "#,##0.000")
	st_tip.text = " " + ls_tip
	st_tip.Move(iw_This.PointerX() , iw_This.PointerY() - st_tip.height) 
	st_tip.width = len(st_tip.text) * 30
	st_tip.visible = TRUE

 CASE ELSE
   st_tip.visible = FALSE
END CHOOSE
end event

event resize;st_tip.visible = false

end event

type st_tip from statictext within w_pisf022
boolean visible = false
integer x = 635
integer y = 1948
integer width = 247
integer height = 76
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 32502767
boolean enabled = false
string text = "none"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_monsum_source from datawindow within w_pisf022
boolean visible = false
integer x = 1874
integer y = 912
integer width = 1458
integer height = 272
integer taborder = 10
string dataobject = "d_wo_schedule_mon_sum_stat"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_pisf022
integer x = 14
integer y = 192
integer width = 1115
integer height = 984
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_pisf022
integer x = 14
integer y = 1732
integer width = 1111
integer height = 128
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long textcolor = 33554432
long backcolor = 12632256
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type tab_wo_delay from tab within w_pisf022
event create ( )
event destroy ( )
integer x = 1134
integer y = 1356
integer width = 2418
integer height = 900
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 12632256
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_delay_list tp_delay_list
end type

on tab_wo_delay.create
this.tp_delay_list=create tp_delay_list
this.Control[]={this.tp_delay_list}
end on

on tab_wo_delay.destroy
destroy(this.tp_delay_list)
end on

event selectionchanged;parent.TriggerEvent('ue_retrieve_wo_property_delay')

end event

type tp_delay_list from userobject within tab_wo_delay
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2382
integer height = 772
long backcolor = 79741120
string text = "지연된 작업지시"
long tabtextcolor = 255
long tabbackcolor = 79741120
string picturename = "Custom015!"
long picturemaskcolor = 553648127
dw_wo_delay_01 dw_wo_delay_01
dw_wo_delay dw_wo_delay
end type

on tp_delay_list.create
this.dw_wo_delay_01=create dw_wo_delay_01
this.dw_wo_delay=create dw_wo_delay
this.Control[]={this.dw_wo_delay_01,&
this.dw_wo_delay}
end on

on tp_delay_list.destroy
destroy(this.dw_wo_delay_01)
destroy(this.dw_wo_delay)
end on

type dw_wo_delay_01 from uo_datawindow within tp_delay_list
integer y = 420
integer width = 2377
integer height = 396
integer taborder = 50
string dragicon = "pic\TARGET.ICO"
string dataobject = "d_sched_task"
end type

event doubleclicked;call super::doubleclicked;if row <= 0 then return

string ls_wono

ls_wono = this.GetItemString(row, 'task_code')

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '작업지시를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[설비관리]-[예방정비]'
lstr.s_parm[3] = ls_wono

OpenSheetwithparm(lw_win,lstr,'w_pisf023',iw_this,0,Layered!)
end event

type dw_wo_delay from uo_datawindow within tp_delay_list
event ue_lbuttondown pbm_lbuttondown
integer y = 8
integer width = 2377
integer height = 396
integer taborder = 50
string dragicon = "pic\TARGET.ICO"
string dataobject = "d_sched_wo1"
end type

event doubleclicked;call super::doubleclicked;if row <= 0 then return

string ls_wono

ls_wono = this.GetItemString(row, 'wo_code')

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '작업지시를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[설비관리]-[작명]'
lstr.s_parm[3] = ls_wono

OpenSheetwithparm(lw_win,lstr,'w_pisf020',iw_this,0,Layered!)


end event

type tab_plan from tab within w_pisf022
event create ( )
event destroy ( )
integer x = 1134
integer y = 20
integer width = 2418
integer height = 1328
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "굴림"
long backcolor = 12632256
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_list tp_list
tp_working tp_working
end type

on tab_plan.create
this.tp_list=create tp_list
this.tp_working=create tp_working
this.Control[]={this.tp_list,&
this.tp_working}
end on

on tab_plan.destroy
destroy(this.tp_list)
destroy(this.tp_working)
end on

event selectionchanged;parent.postevent('ue_retrieve_calendar')

choose case newindex
	case 2
		id_dw_list_02.reset()
	case 1
		id_dw_working_list.reset()
end choose

end event

type tp_list from userobject within tab_plan
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2382
integer height = 1200
long backcolor = 79741120
string text = "작업계획 목록"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "CreateTable5!"
long picturemaskcolor = 553648127
dw_task_list dw_task_list
dw_wo_list dw_wo_list
end type

on tp_list.create
this.dw_task_list=create dw_task_list
this.dw_wo_list=create dw_wo_list
this.Control[]={this.dw_task_list,&
this.dw_wo_list}
end on

on tp_list.destroy
destroy(this.dw_task_list)
destroy(this.dw_wo_list)
end on

type dw_task_list from uo_datawindow within tp_list
integer y = 608
integer width = 2377
integer height = 592
integer taborder = 21
string dragicon = "pic\TARGET.ICO"
string dataobject = "d_sched_task"
end type

event doubleclicked;call super::doubleclicked;if row <= 0 then return

string ls_wono

ls_wono = this.GetItemString(row, 'task_code')

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '작업지시를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[설비관리]-[예방정비]'
lstr.s_parm[3] = ls_wono

OpenSheetwithparm(lw_win,lstr,'w_pisf023',iw_this,0,Layered!)
end event

type dw_wo_list from uo_datawindow within tp_list
event ue_lbuttondown pbm_lbuttondown
integer width = 2377
integer height = 604
integer taborder = 11
string dragicon = "pic\TARGET.ICO"
string dataobject = "d_sched_wo1"
end type

event doubleclicked;call super::doubleclicked;if row <= 0 then return

string ls_wono

ls_wono = this.GetItemString(row, 'wo_code')

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '작업지시를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[설비관리]-[작명]'
lstr.s_parm[3] = ls_wono

OpenSheetwithparm(lw_win,lstr,'w_pisf020',iw_this,0,Layered!)


end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then
	is_wono = this.GetItemString(currentrow, 'wo_code')
end if
end event

event ue_lbuttonup;call super::ue_lbuttonup;//ib_drag_button_down = false
end event

type tp_working from userobject within tab_plan
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 2382
integer height = 1200
long backcolor = 79741120
string text = "진행중인 작업목록"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Continue!"
long picturemaskcolor = 553648127
dw_working_list_01 dw_working_list_01
dw_working_list dw_working_list
end type

on tp_working.create
this.dw_working_list_01=create dw_working_list_01
this.dw_working_list=create dw_working_list
this.Control[]={this.dw_working_list_01,&
this.dw_working_list}
end on

on tp_working.destroy
destroy(this.dw_working_list_01)
destroy(this.dw_working_list)
end on

type dw_working_list_01 from uo_datawindow within tp_working
integer y = 604
integer width = 2418
integer height = 600
integer taborder = 21
string dataobject = "d_sched_task"
end type

event doubleclicked;call super::doubleclicked;if row <= 0 then return

string ls_wono

ls_wono = this.GetItemString(row, 'task_code')

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '작업지시를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[설비관리]-[예방정비]'
lstr.s_parm[3] = ls_wono

OpenSheetwithparm(lw_win,lstr,'w_pisf023',iw_this,0,Layered!)
end event

type dw_working_list from uo_datawindow within tp_working
integer width = 2418
integer height = 604
integer taborder = 11
string dataobject = "d_sched_wo1"
end type

event doubleclicked;call super::doubleclicked;if row <= 0 then return

string ls_wono

ls_wono = this.GetItemString(row, 'wo_code')

if ls_wono = '' or isnull(ls_wono) then
	MessageBox("알림", '작업지시를 선택하고 다시한번 시도해보십시오.')
	return
end if

// 작업지시 화면을 열고 해당 작업지시의 등록정보 화면으로 이동한다

window lw_win
str_parm lstr

lstr.s_parm[1] = '5'
lstr.s_parm[2] = '[설비관리]-[작명]'
lstr.s_parm[3] = ls_wono

OpenSheetwithparm(lw_win,lstr,'w_pisf020',iw_this,0,Layered!)


end event

event rowfocuschanged;call super::rowfocuschanged;if currentrow > 0 then
	is_wono = this.GetItemString(currentrow, 'wo_code')
end if
end event

type uo_area from u_cmms_select_area within w_pisf022
event destroy ( )
integer x = 64
integer y = 64
integer taborder = 60
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

type uo_division from u_cmms_select_division within w_pisf022
event destroy ( )
integer x = 558
integer y = 68
integer taborder = 60
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type gb_2 from groupbox within w_pisf022
integer x = 27
integer width = 1088
integer height = 172
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

