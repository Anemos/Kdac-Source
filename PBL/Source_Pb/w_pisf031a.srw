$PBExportHeader$w_pisf031a.srw
$PBExportComments$정상불출(바코드)
forward
global type w_pisf031a from w_cmms_sheet01
end type
type uo_area from u_cmms_select_area within w_pisf031a
end type
type uo_division from u_cmms_select_division within w_pisf031a
end type
type cb_normal from commandbutton within w_pisf031a
end type
type cb_temp from commandbutton within w_pisf031a
end type
type dw_scan from datawindow within w_pisf031a
end type
type dw_pisf031a_02 from uo_datawindow within w_pisf031a
end type
type dw_pisf031a_01 from datawindow within w_pisf031a
end type
type dw_pisf031a_03 from uo_datawindow within w_pisf031a
end type
type cb_return from commandbutton within w_pisf031a
end type
type dw_as400 from datawindow within w_pisf031a
end type
type gb_1 from groupbox within w_pisf031a
end type
type gb_2 from groupbox within w_pisf031a
end type
type gb_3 from groupbox within w_pisf031a
end type
end forward

global type w_pisf031a from w_cmms_sheet01
integer width = 4699
string title = "정상불출입력"
event ue_init ( )
event ue_process ( )
uo_area uo_area
uo_division uo_division
cb_normal cb_normal
cb_temp cb_temp
dw_scan dw_scan
dw_pisf031a_02 dw_pisf031a_02
dw_pisf031a_01 dw_pisf031a_01
dw_pisf031a_03 dw_pisf031a_03
cb_return cb_return
dw_as400 dw_as400
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_pisf031a w_pisf031a

type variables
String	is_partkbno
String	is_null
boolean ib_opened = false
end variables

forward prototypes
public function string wf_get_serial ()
public subroutine wf_insert_dw_pisf031a_02 ()
public function integer wf_save_setauto (integer as_currow)
end prototypes

event ue_init();is_partkbno = is_Null

dw_pisf031a_01.Setitem(1, 'out_date', Date(String(g_s_date,"@@@@-@@-@@")))
dw_pisf031a_01.Setitem(1, 'part_used', '01')
dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()

end event

event ue_process();//////////////////////////////////
//		자동불출 작업 Control
//////////////////////////////////
string ls_area, ls_plant, ls_itemcode
long ll_rowcnt

ls_area = mid(is_partkbno,1,1)
ls_plant = mid(is_partkbno,2,1)
ls_itemcode = mid(is_partkbno,3)

//품번체크
select count(*) into :ll_rowcnt
from part_master
where area_code = :ls_area and factory_code = :ls_plant and part_code = :ls_itemcode
using sqlcmms;

if ll_rowcnt < 1 then
	Messagebox("확인", "해당 공장으로 등록된 품번이 아닙니다.")
	return
end if

wf_insert_dw_pisf031a_02()

return
end event

public function string wf_get_serial ();String ls_serial

DECLARE up_get_serial PROCEDURE FOR sp_get_cmms_serial  
	 @ps_area = :gs_kmarea,   
    @ps_factory = :gs_kmdivision,
    @ps_codeid = 'out'  
	 using sqlcmms;

Execute up_get_serial;

if sqlcmms.sqlcode = 0 then
	fetch up_get_serial into :ls_serial;
	close up_get_serial;
end if

return ls_serial

end function

public subroutine wf_insert_dw_pisf031a_02 ();string ls_area, ls_plant, ls_part_code, ls_part_tag, ls_part_name
string ls_part_spec, ls_part_unit, ls_part_location
dec{1} lc_normal_qty, lc_repair_qty, lc_scram_qty, lc_etc_qty
dec{2} lc_part_cost
long ll_currow

ls_area = mid(is_partkbno,1,1)
ls_plant = mid(is_partkbno,2,1)
ls_part_code = mid(is_partkbno,3)

select part_name, part_spec, part_unit, part_location, normal_qty, repair_qty,
			scram_qty, etc_qty, part_cost
into :ls_part_name, :ls_part_spec, :ls_part_unit, :ls_part_location, :lc_normal_qty,
			:lc_repair_qty, :lc_scram_qty, :lc_etc_qty, :lc_part_cost
from part_master
where area_code = :ls_area and factory_code = :ls_plant and
	part_code = :ls_part_code
using sqlcmms;

ll_currow = dw_pisf031a_02.insertrow(0)
dw_pisf031a_02.setitem(ll_currow, 'area_code', ls_area)
dw_pisf031a_02.setitem(ll_currow, 'factory_code', ls_plant)
dw_pisf031a_02.setitem(ll_currow, 'part_code', ls_part_code)
dw_pisf031a_02.setitem(ll_currow, 'part_name', ls_part_name)
dw_pisf031a_02.setitem(ll_currow, 'out_qty', 1)
dw_pisf031a_02.setitem(ll_currow, 'part_spec', ls_part_spec)
dw_pisf031a_02.setitem(ll_currow, 'part_unit', ls_part_unit)
dw_pisf031a_02.setitem(ll_currow, 'part_location', ls_part_location)
dw_pisf031a_02.setitem(ll_currow, 'normal_qty', lc_normal_qty)
dw_pisf031a_02.setitem(ll_currow, 'repair_qty', lc_repair_qty)
dw_pisf031a_02.setitem(ll_currow, 'scram_qty', lc_scram_qty)
dw_pisf031a_02.setitem(ll_currow, 'etc_qty', lc_etc_qty)
dw_pisf031a_02.setitem(ll_currow, 'part_cost', lc_part_cost)
dw_pisf031a_02.setitem(ll_currow, 'invy_state', 'U')
dw_pisf031a_02.setitem(ll_currow, 'buybackflag', 'N')
dw_pisf031a_02.setitem(ll_currow, 'part_used', dw_pisf031a_01.getitemstring(1,'part_used'))
dw_pisf031a_02.setitem(ll_currow, 'out_date', dw_pisf031a_01.getitemdatetime(1,'out_date'))

return
end subroutine

public function integer wf_save_setauto (integer as_currow);integer i
string ls_wo_code, ls_part_code, ls_invy_state, ls_scandate
dec{1} lc_out_qty

// 작명 또는 예방정비 자재불출 로직
ls_wo_code = dw_pisf031a_02.getitemstring(as_currow,'wo_code')
ls_part_code = dw_pisf031a_02.getitemstring(as_currow,'part_code')
lc_out_qty = dw_pisf031a_02.getitemdecimal(as_currow,'out_qty')
if f_spacechk(ls_wo_code) <> -1 then
	if mid(ls_wo_code,1,2) = 'PM' then
		INSERT INTO task_part  
			( task_code, part_code, qty )  
		VALUES ( :ls_wo_code,  :ls_part_code,  :lc_out_qty )  
			using sqlcmms;
		if sqlcmms.sqlcode <> 0 then
		  UPDATE task_part  
		  SET qty = isnull(qty,0) + :lc_out_qty
		  where task_code=:ls_wo_code and part_code=:ls_part_code
		  using sqlcmms;
		end if
	else
		INSERT INTO wo_part 
			( wo_code, part_code, qty, area_code, factory_code)  
		VALUES ( :ls_wo_code, :ls_part_code, :lc_out_qty,
			  :gs_kmarea, :gs_kmdivision)  
		using sqlcmms;
		if sqlcmms.sqlcode <> 0 then
			UPDATE wo_part  
			SET qty = isnull(qty,0) + :lc_out_qty
			where  wo_code=:ls_wo_code and part_code=:ls_part_code and 
				area_code = :gs_kmarea and factory_code = :gs_kmdivision
			using sqlcmms; 
		end if
	end if
end if

// 임시불출테이블 완료처리
ls_scandate = dw_pisf031a_02.getitemstring(as_currow, 'scandate')
if f_spacechk(ls_scandate) <> -1 then
	update part_out_temp
	set stscd = 'C'
	where scandate = :ls_scandate
	using sqlcmms;
	
	if sqlcmms.sqlnrows <> 1 then
		MESSAGEBOX("CHK","TEMP UPDATE ERROR")
		return -1
	end if
end if

return 0
end function

on w_pisf031a.create
int iCurrent
call super::create
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cb_normal=create cb_normal
this.cb_temp=create cb_temp
this.dw_scan=create dw_scan
this.dw_pisf031a_02=create dw_pisf031a_02
this.dw_pisf031a_01=create dw_pisf031a_01
this.dw_pisf031a_03=create dw_pisf031a_03
this.cb_return=create cb_return
this.dw_as400=create dw_as400
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_area
this.Control[iCurrent+2]=this.uo_division
this.Control[iCurrent+3]=this.cb_normal
this.Control[iCurrent+4]=this.cb_temp
this.Control[iCurrent+5]=this.dw_scan
this.Control[iCurrent+6]=this.dw_pisf031a_02
this.Control[iCurrent+7]=this.dw_pisf031a_01
this.Control[iCurrent+8]=this.dw_pisf031a_03
this.Control[iCurrent+9]=this.cb_return
this.Control[iCurrent+10]=this.dw_as400
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
end on

on w_pisf031a.destroy
call super::destroy
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cb_normal)
destroy(this.cb_temp)
destroy(this.dw_scan)
destroy(this.dw_pisf031a_02)
destroy(this.dw_pisf031a_01)
destroy(this.dw_pisf031a_03)
destroy(this.cb_return)
destroy(this.dw_as400)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event resize;call super::resize;Integer ls_split = 20 	// splitbar 의 Height 또는 Width 는 20 
Integer ls_gap = 10 		// window 와 dw_control 의 Gap은 5
Integer ls_status = 100 // statusbar 의 높이는 120 ( Gap 포함 )

dw_pisf031a_02.Width = newwidth 	- ( ls_gap * 6 )
dw_pisf031a_02.Height = newheight * 3 / 6

dw_pisf031a_03.y = dw_pisf031a_02.y + dw_pisf031a_02.Height + ls_split
dw_pisf031a_03.Width = dw_pisf031a_02.Width
dw_pisf031a_03.Height= newheight - ( dw_pisf031a_03.y + ls_split * 3 )
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

dw_scan.SetTransObject(sqlcmms)
dw_pisf031a_01.settransobject(sqlcmms)
dw_pisf031a_02.settransobject(sqlcmms)
dw_pisf031a_03.settransobject(sqlcmms)
end event

event ue_postopen;call super::ue_postopen;datawindowchild ldwc

dw_scan.SetTransObject(sqlcmms)
dw_scan.InsertRow(1)

dw_pisf031a_01.settransobject(sqlcmms)
dw_pisf031a_01.insertrow(0)
dw_pisf031a_02.settransobject(sqlcmms)
dw_pisf031a_03.settransobject(sqlcmms)

dw_pisf031a_01.GetChild('part_used', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_pisf031a_02.GetChild('equip_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_pisf031a_02.GetChild('part_used', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_pisf031a_03.GetChild('wo_state_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_pisf031a_03.GetChild('wo_div_code', ldwc)
ldwc.settransobject(sqlcmms)
ldwc.retrieve(gs_kmarea, gs_kmdivision)
if ldwc.RowCount() < 1 then
	ldwc.InsertRow(0)
end if

dw_pisf031a_02.GetChild('equip_code', ldwc)
f_dddw_width(dw_pisf031a_02, 'equip_code', ldwc, 'equip_name', 10)

dw_pisf031a_01.GetChild('part_used', ldwc)
f_dddw_width(dw_pisf031a_01, 'part_used', ldwc, 'used_name', 10)

dw_pisf031a_02.GetChild('part_used', ldwc)
f_dddw_width(dw_pisf031a_02, 'part_used', ldwc, 'used_name', 10)

this.PostEvent ( "ue_init" )
this.PostEvent ('ue_retrieve')
end event

event ue_retrieve;call super::ue_retrieve;string ls_colcount
long ll_currow, ll_rowcnt, ll_cnty

dw_pisf031a_02.reset()
dw_pisf031a_03.reset()

ll_rowcnt = dw_pisf031a_02.retrieve(gs_kmarea,gs_kmdivision)
if ll_rowcnt > 0 then
	ls_colcount = dw_pisf031a_02.Object.DataWindow.Column.Count
	for ll_currow = 1 to ll_rowcnt
		FOR  ll_cnty = 1  TO Dec(ls_colcount)
			dw_pisf031a_02.setitemstatus(ll_currow, ll_cnty, primary!, DataModified! )
		NEXT
	next
end if
dw_pisf031a_03.retrieve(gs_kmarea,gs_kmdivision)

dw_scan.SetItem(1, 'scancode', is_Null )
dw_scan.SetColumn('scancode')
dw_scan.SetFocus()
end event

event ue_delete;call super::ue_delete;Int li_selrow, li_Cnt
String ls_scandate, ls_PartCode, ls_msg


li_selrow = dw_pisf031a_02.getselectedrow(0)
ls_scandate = dw_pisf031a_02.getitemstring(li_selrow, 'scandate')
ls_PartCode = dw_pisf031a_02.getitemstring(li_selrow, 'part_code')

if li_selrow < 1 then
	MessageBox("확인","삭제하기 위한 선택된 데이타가 없습니다.")
	return 0
end if

ls_msg = "[행:"+String(li_selrow)+"][품번:"+ls_PartCode+"]~r~n을 삭제하시겠읍니까?"
if messagebox("삭제", ls_msg, Question!, YesNo!) <> 1 then	return 0

Select Count(*)
  Into :li_Cnt
  From Part_Out_Temp
 Where scandate = :ls_scandate And Area_Code = :gs_kmarea And factory_code = :gs_kmdivision
 Using Sqlcmms;
 
if sqlcmms.SQLCode <> 0 then
	ls_msg = "[PATH:/정상불출/삭제/Select]~r~n[에러내용:"+sqlcmms.SQLErrText+"]"
	MESSAGEBOX("확인", ls_msg)
	return -1
end if

if li_cnt > 0 Then

	Update part_out_temp
		Set flag = 'D'
	 where scandate = :ls_scandate And Area_Code = :gs_kmarea And factory_code = :gs_kmdivision
	 using sqlcmms;
	 
	if sqlcmms.SQLCode <> 0 then
		ls_msg = "[PATH:/정상불출/삭제/Update]~r~n[에러내용:"+sqlcmms.SQLErrText+"]"
		MESSAGEBOX("확인", ls_msg)
		return -1
	end if
end if

dw_pisf031a_02.deleterow(li_selrow)

end event

event ue_save;call super::ue_save;dec{1} lc_out_qty
long i, ll_currow, ll_rowcnt, ll_mode, ln_CurRow, ln_RtnCode
string ls_message, ls_end_date, ls_endday
string ls_area, ls_factory, ls_part_code, ls_part_tag, ls_wo_code, ls_dept_code, ls_part_used  
string ls_equip_code, ls_out_date, ls_invy_state, ls_out_serial, ls_buybackflag
datetime ld_out_date
str_ipis_server lstr_As400[]
String ls_areadivision[1]

ls_message = "현재 선택되어진 행만 불출하시겠읍니까?~r~n~r~n"	 & 
				+ "예(YES) - 현재행만 불출~r~n아니요(NO) - 전체불출~r~n취소(Cancel) = 불출취소"
	
ll_mode = messagebox("불출모드선택", ls_message, Question!, YesNoCancel!)

dw_pisf031a_02.AcceptText()

//현재행만
if ll_mode = 1 then
	ll_currow = dw_pisf031a_02.GetRow()	
	ll_rowcnt = dw_pisf031a_02.GetRow()	
//데이타윈도우 전체
elseif ll_mode = 2 then
	ll_currow = 1
	ll_rowcnt = dw_pisf031a_02.rowcount()
else
	return 0
end if

SetPointer(HourGlass!)

// AS400 CONN 생성
ls_areadivision[1] = "XZ"
lstr_As400 = f_ipis_server_set_transaction('EACH', ls_areadivision)
if UpperBound(lstr_As400) = 0 or f_ipis_server_get_transaction(lstr_As400,'X','Z') = -1 then
	ls_message = "DB CONN 생성실패!!"
	goto Rollback_
End if
lstr_As400[f_ipis_server_get_transaction(lstr_As400,'X','Z')].t_sqlpis.AutoCommit = False
sqlcmms.AutoCommit = False

ls_end_date = f_date_end(string(g_s_date,"@@@@-@@-@@"))
ls_endday = left(string(g_s_date,"@@@@-@@-@@"),8) + ls_end_date
for i = ll_currow to ll_rowcnt
	if f_spacechk(dw_pisf031a_02.getitemstring(i,'invy_state')) = -1 then
		ls_message = string(i) + " 행에 재고상태가 누락되었습니다."
		Goto RollBack_	
	end if
	if f_spacechk(dw_pisf031a_02.getitemstring(i,'part_used')) = -1 then
		ls_message = string(i) + " 행에 불출용도가 누락되었습니다."
		Goto RollBack_	
	end if
	if f_spacechk(dw_pisf031a_02.getitemstring(i,'dept_code')) = -1 then
		ls_message = string(i) + " 행에 부서(업체)가 누락되었습니다."
		Goto RollBack_	
	end if
	if dw_pisf031a_02.getitemdecimal(i,'out_qty') <= 0 &
			or isnull(dw_pisf031a_02.getitemdecimal(i,'out_qty')) then
		ls_message = string(i) + " 행에 불출수량이 누락되었습니다."
		Goto RollBack_	
	end if

	ls_out_date = string(dw_pisf031a_02.getitemdatetime(i,'out_date'),'yyyy-mm-dd')
	if f_date_check(ls_out_date) = 0 then
		ls_message = string(i) + " 행에 불출일자가 올바르지 않습니다."
		Goto RollBack_	
	elseif ls_out_date > string(g_s_date,"@@@@-@@-@@") then
		ls_message = '불출일자가 오늘일자보다 큽니다. 다시입력하세요..'
		Goto RollBack_	
	elseif Left(ls_out_date, 7) <> string(mid(g_s_date,1,6),"@@@@-@@") then
		ls_message = '불출일자가 범위를 넘었습니다. 다시입력하세요..'
		Goto RollBack_	
	elseif ls_out_date = ls_endday and mid(string(f_cmms_sysdate()),12,5) > '19:59' then
		dw_pisf031a_02.setitem(i,'out_date',relativedate(date(string(g_s_date,"@@@@-@@-@@")),1))
	end if
	
	//연구소는 자재 재고관리를 하지 않는다
	if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then 
		//불출수량 체크 --2006.04.04(by 강치구)
		lc_out_qty = dw_pisf031a_02.GetItemDecimal(i,'out_qty')
		if dw_pisf031a_02.getitemstring(i,'invy_state') ='U' &
				And dw_pisf031a_02.getitemnumber(i,'normal_qty') < lc_out_qty then
			ls_message = string(i)+'행에 불출수량이 사용가능한 개수보다 크기 때문에 불출할수 없습니다.'
			Goto RollBack_	
		end if
		
		if dw_pisf031a_02.getitemstring(i,'invy_state') ='R' &
				and dw_pisf031a_02.getitemnumber(i,'repair_qty') < lc_out_qty then
			ls_message = string(i)+'행에 불출수량이 요수리 개수보다 크기때문에 불출할수 없습니다.'	
			Goto RollBack_	
		end if
		
		if dw_pisf031a_02.getitemstring(i,'invy_state') ='S' &
				and dw_pisf031a_02.getitemnumber(i,'scram_qty') < lc_out_qty then
			ls_message = string(i)+'행에 불출수량이 폐품 개수보다 크기때문에 불출할수 없습니다.'			
			Goto RollBack_	
		end if
		
		if dw_pisf031a_02.getitemstring(i,'invy_state') ='X' &
				and dw_pisf031a_02.getitemnumber(i,'etc_qty') < lc_out_qty then
			ls_message = string(i)+'행에 불출수량이 부외 개수보다 크기때문에 불출할수 없습니다.'
			Goto RollBack_	
		end if
		
		// 설비자재 재고 가감로직
		ls_invy_state = dw_pisf031a_02.getitemstring(i,'invy_state')
		choose case ls_invy_state
			case 'U'
				UPDATE part_master  
				SET normal_qty = normal_qty - :lc_out_qty 
				WHERE area_code = :gs_kmarea AND factory_code = :gs_kmdivision AND 
					part_code = :ls_part_code    
				using sqlcmms;
			case 'R'
				UPDATE part_master  
				SET repair_qty = repair_qty - :lc_out_qty 
				WHERE area_code = :gs_kmarea AND factory_code = :gs_kmdivision AND 
					part_code = :ls_part_code    
				using sqlcmms;
			case 'S'
				UPDATE part_master  
				SET scram_qty = scram_qty - :lc_out_qty 
				WHERE area_code = :gs_kmarea AND factory_code = :gs_kmdivision AND 
					part_code = :ls_part_code    
				using sqlcmms;
			case 'X'
				UPDATE part_master  
				SET etc_qty = etc_qty - :lc_out_qty 
				WHERE area_code = :gs_kmarea AND factory_code = :gs_kmdivision AND 
					part_code = :ls_part_code    
				using sqlcmms;
		end choose	
	
		if sqlcmms.sqlcode <> 0 then
			ls_message = "PART_MASTER UPDATE 오류가 발생하였습니다."
			Goto RollBack_	
		end if

	end if
	
	////////////////////////////////////////////////
	// 		불출 TAG, SERIAL 
	////////////////////////////////////////////////
	ls_out_serial = wf_get_serial()
	if f_spacechk(ls_out_serial) = -1 then
		ls_message = "Serial No생성시에 오류가 발생하였습니다."
		Goto RollBack_	
	end if
	
	ls_dept_code = dw_pisf031a_02.getitemstring(i,'dept_code')
	if string(g_s_date,"@@@@-@@-@@") = ls_endday and string(f_cmms_sysdate(),'yyyy-mm-dd hh:mm') > ls_endday + ' 19:59'  then
		dw_pisf031a_02.setitem(i,'part_tag',ls_dept_code+right(string(relativedate(date(string(g_s_date,"@@@@-@@-@@")),1),"yyyymm"),3)+right(ls_out_serial,5))
	else
		dw_pisf031a_02.setitem(i,'part_tag',ls_dept_code+right(string(dw_pisf031a_02.getitemdatetime(i,'out_date'),"yyyymm"),3)+right(ls_out_serial,5))
	end if
	// 불출 Serial
	dw_pisf031a_02.setitem(i,'out_serial',ls_out_serial)
	dw_pisf031a_02.setitemstatus(i, 0, primary!, NewModified!)
	dw_pisf031a_02.accepttext()
	
	If wf_save_setauto(i) = -1 Then
		ls_message = "불출 전처리 작업할때 에러가 발생하였습니다."
		Goto RollBack_	
	End If
	
	////////////////////////////////////////////////
	// 		불출 처리 
	////////////////////////////////////////////////
	ls_area = dw_pisf031a_02.getitemstring(i,'area_code')
	ls_factory = dw_pisf031a_02.getitemstring(i,'factory_code')
	ls_part_code = dw_pisf031a_02.getitemstring(i,'part_code')
	ls_part_tag = dw_pisf031a_02.getitemstring(i,'part_tag')
	ls_wo_code = dw_pisf031a_02.getitemstring(i,'wo_code') 
	ls_dept_code =dw_pisf031a_02.getitemstring(i,'dept_code')
	ls_part_used = dw_pisf031a_02.getitemstring(i,'part_used')
	ls_equip_code = dw_pisf031a_02.getitemstring(i,'equip_code')
	ld_out_date = dw_pisf031a_02.getitemdatetime(i,'out_date')
	ls_invy_state = dw_pisf031a_02.getitemstring(i,'invy_state')
	ls_buybackflag = dw_pisf031a_02.getitemstring(i,'buybackflag')
			
	INSERT INTO part_out  
			(area_code, factory_code, part_code, part_tag, wo_code, dept_code, part_used,   
         equip_code, out_date, invy_state, out_qty, out_serial, buybackflag, up_div)  
		VALUES (:ls_area, :ls_factory, :ls_part_code, :ls_part_tag, :ls_wo_code, :ls_dept_code,
					:ls_part_used, :ls_equip_code, :ld_out_date, :ls_invy_state, :lc_out_qty, 
					:ls_out_serial, :ls_buybackflag, 'Y')  
		using sqlcmms;
	
	if sqlcmms.sqlcode <> 0 then
		ls_message = "불출데이타 저장에서 오류가 발생하였습니다."
		Goto RollBack_	
	end if

	//AS400 INV401 업데이트
	dw_as400.Reset()
	ln_CurRow = dw_as400.InsertRow(0)
	
	// 매개변수 dw에 데이터 넣기
	dw_as400.setitem(ln_CurRow, "AREACODE", ls_area)
	dw_as400.setitem(ln_CurRow, "DIVISIONCODE", ls_factory)
	dw_as400.setitem(ln_CurRow, "releasedate", String(ld_out_date, "yyyymmdd"))
	dw_as400.setitem(ln_CurRow, "serialno", ls_out_serial)
	dw_as400.setitem(ln_CurRow, "itemcode", Upper(ls_part_code))
	if isnull(ls_part_tag) then ls_part_tag = " "
	dw_as400.setitem(ln_CurRow, "slipno", Left(ls_part_tag, 12))
	if isnull(ls_wo_code) then ls_wo_code = " "
	dw_as400.setitem(ln_CurRow, "orderno", Left(ls_wo_code, 16))
	dw_as400.setitem(ln_CurRow, "deptcode", ls_dept_code)
	dw_as400.setitem(ln_CurRow, "usage", ls_part_used)
	if isnull(ls_equip_code) then ls_equip_code = " "
	dw_as400.setitem(ln_CurRow, "mcno", ls_equip_code)
	dw_as400.setitem(ln_CurRow, "stockstatus", ls_invy_state)
	dw_as400.setitem(ln_CurRow, "releaseqty", lc_out_qty)
	dw_as400.setitem(ln_CurRow, "datastatus", "C")
	dw_as400.setitem(ln_CurRow, "uploadflag", "Y")
	dw_as400.setitem(ln_CurRow, "lastemp", g_s_empno)
	dw_as400.setitem(ln_CurRow, "lastdate", Now())
	
	//인터페이스함수로 전달하기 위한 DWO 생성
	ln_RtnCode = f_up_ipis_mis_tmcpartrelease(ls_message, dw_as400, lstr_As400)
	If ln_RtnCode = -1 then goto RollBack_

next

//	성공
Commit Using sqlcmms;
sqlcmms.AutoCommit = True

//AS400 COMMIT
if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then 
	f_ipis_server_commit_transaction(lstr_As400)
end if
	
this.PostEvent ('ue_retrieve')
SetPointer(Arrow!)
uo_status.st_message.text = "정상적으로 불출처리되었습니다."
Return 1

//	실패
RollBack_:
RollBack Using sqlcmms;
sqlcmms.AutoCommit = True

//AS400 ROLLBACK
if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then
	f_ipis_server_rollback_transaction(lstr_As400)
end if

SetPointer(Arrow!)

MessageBox("불출오류", ls_message, StopSign!)

return -1
end event

type uo_status from w_cmms_sheet01`uo_status within w_pisf031a
end type

type uo_area from u_cmms_select_area within w_pisf031a
integer x = 73
integer y = 84
integer taborder = 20
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

type uo_division from u_cmms_select_division within w_pisf031a
integer x = 571
integer y = 84
integer taborder = 30
boolean bringtotop = true
end type

on uo_division.destroy
call u_cmms_select_division::destroy
end on

type cb_normal from commandbutton within w_pisf031a
integer x = 3141
integer y = 84
integer width = 398
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "정상불출"
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//입고만처리
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110  
   WHERE WIN_ID = 'w_pisf031a' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

type cb_temp from commandbutton within w_pisf031a
integer x = 3566
integer y = 84
integer width = 398
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "임시불출"
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//입고만처리
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110
   WHERE WIN_ID = 'w_pisf031b' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

type dw_scan from datawindow within w_pisf031a
integer x = 55
integer y = 244
integer width = 1737
integer height = 148
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf_scan"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;This.SelectText(1,15)
this.SetFocus()
end event

event itemchanged;If Not m_frame.m_action.m_save.Enabled Then 
	MessageBox( "확인", "작업처리 권한이 부여되지 않았습니다.", Information! )
	This.SetItem(1, 'scancode', is_null )
	This.Object.scancode.SetFocus()
	Return
End If

//If len(data) <> 11 Then 
//	MessageBox( "입력오류", "올바른 바코드 품번이 아닙니다.", StopSign! )
//	This.SetItem(1, 'scancode', is_null )
//	This.Object.scancode.SetFocus()
//	Return
//End If

//idt_nowTime	= f_pisc_get_date_nowtime()									//현재 시스템시간
//is_nowTime 	= String(idt_nowTime, "yyyy.mm.dd hh:mm")
//is_jobDate	= f_pisc_get_date_applydate( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간고려함
//is_applyDate= f_pisc_get_date_applydate_close( istr_partkb.areacode, istr_partkb.divcode, idt_nowTime )	//기준일자 -8시간,마감일 고려함

is_partkbno = data
parent.TriggerEvent( "ue_process" )

this.reset()
this.InsertRow(0)

this.Event getfocus()
end event

type dw_pisf031a_02 from uo_datawindow within w_pisf031a
integer x = 27
integer y = 436
integer width = 3493
integer height = 724
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_pisf031a_02"
end type

event buttonclicked;call super::buttonclicked;string ls_data[], name
str_parm lstr

if dwo.name = 'b_1' then
	if f_spacechk(this.getitemstring(row,'part_used')) = -1 then
		messagebox("알림",'용도를 입력하지 않으면 부서(업체)를 입력할 수 없습니다.')
		this.setcolumn('part_used')
		this.setfocus()
	else
		if this.getitemstring(row,'part_used')='04' or this.getitemstring(row,'part_used')='07'then
			IF f_code_search('d_lookup_comp', '', ls_data[]) THEN
				This.SetItem(row, 'dept_code', ls_data[1])
			END IF
		else
			if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then
				IF f_code_search('d_lookup_cc_inv', '', ls_data[]) THEN
					This.SetItem(row, 'dept_code', ls_data[1])
				END IF
			else
				IF f_code_search('d_lookup_cc_a', '', ls_data[]) THEN
					This.SetItem(row, 'dept_code', ls_data[1])
				END IF
			end if
		end if
	end if
end if
end event

event itemchanged;call super::itemchanged;string ls_rtndata

this.accepttext()
choose case dwo.name
	case 'part_used'
		ls_rtndata = This.getitemstring(row,'dept_code')
		if trim(data) = '04' or trim(data) = '07' then
			if mid(ls_rtndata,1,1) <> 'D' then
				This.setitem(row,'dept_code',' ')
				return 1
			end if
		end if
	case 'dept_code'
		ls_rtndata = This.getitemstring(row,'part_used')
		if ls_rtndata = '04' or ls_rtndata = '07' then
			if mid(data,1,1) <> 'D' then
				Messagebox("확인","업체코드가 들어와야 합니다..")
				This.setitem(row,'dept_code',' ')
				return 1
			else
				select comp_code into :ls_rtndata
				from comp_master
				where comp_code = :data
				using sqlcmms;
				
				if sqlcmms.sqlcode <> 0 then
					Messagebox("확인","잘못된 업체코드입니다..")
					This.setitem(row,'dept_code',' ')
					return 1
				end if
			end if
		else
			if mid(data,1,1) = 'D' then
				Messagebox("확인","부서코드가 들어와야 합니다..")
				This.setitem(row,'dept_code',' ')
				return 1
			else
				if not(gs_kmArea = 'D' And gs_kmDivision = 'R') then
					select cc_code into :ls_rtndata
					from cc_master
					where cc_code = :data
					using sqlcmms;
				else
					select cc_code into :ls_rtndata
					from cc_inv
					where cc_code = :data
							AND AREA_CODE = :gs_kmArea 
							AND FACTORY_CODE = :gs_kmDivision
					using sqlcmms;
				end if
				
				if sqlcmms.sqlcode <> 0 then
					Messagebox("확인","잘못된 라인코드입니다..")
					This.setitem(row,'dept_code',' ')
					return 1
				end if
			end if
		end if
	case 'out_qty'
		ls_rtndata = This.getitemstring(row,'invy_state')
		if dec(data) <= 0 then
			Messagebox("확인","불출수량은 0보다 커야 합니다.")
			This.setitem(row,'out_qty',0)
			return 1
		end if
		choose case ls_rtndata
			case 'U'
				if dec(data) > This.getitemdecimal(row,'normal_qty') then
					Messagebox("확인","사용가 수량보다 불출수량이 많습니다.")
					This.setitem(row,'out_qty',0)
					return 1
				end if
			case 'R'
				if dec(data) > This.getitemdecimal(row,'repair_qty') then
					Messagebox("확인","요수리 수량보다 불출수량이 많습니다.")
					This.setitem(row,'out_qty',0)
					return 1
				end if
			case 'S'
				if dec(data) > This.getitemdecimal(row,'scram_qty') then
					Messagebox("확인","폐품 수량보다 불출수량이 많습니다.")
					This.setitem(row,'out_qty',0)
					return 1
				end if
			case 'X'
				if dec(data) > This.getitemdecimal(row,'etc_qty') then
					Messagebox("확인","부외 수량보다 불출수량이 많습니다.")
					This.setitem(row,'out_qty',0)
					return 1
				end if
		end choose
	case 'buybackflag'
		ls_rtndata = This.getitemstring(row,'part_used')
		if data = 'Y' then
			if ls_rtndata = '04' or ls_rtndata = '07' then
				//pass
			else
				This.setitem(row,'buybackflag','N')
				return 1
			end if
		end if
	case 'wo_code'
		select wo_code into :ls_rtndata
		from wo
		where wo_code = :data
		using sqlcmms;
		if sqlcmms.sqlcode <> 0 then
			select wo_code into :ls_rtndata
			from wo_hist
			where wo_code = :data and area_code =:gs_kmarea and factory_code = :gs_kmdivision 
			using sqlcmms;
			if sqlcmms.sqlcode <> 0 then
				Messagebox("확인","등록된 작명번호가 아닙니다.")
				This.setitem(row,'wo_code','')
				return 1
			end if
		end if	
	case 'equip_code'
		select equip_code into :ls_rtndata
		from equip_master
		where equip_code = :data
		using sqlcmms;
		if sqlcmms.sqlcode <> 0 then
			Messagebox("확인","등록된 장비번호가 아닙니다.")
			This.setitem(row,'equip_code','')
			return 1
		end if
		
		string ls_cc_code
			
		SELECT cc_code  
			INTO :ls_cc_code
			FROM equip_master  
			WHERE equip_code = :data and area_code =:gs_kmarea and factory_code = :gs_kmdivision 
			using sqlcmms;
		
		dw_pisf031a_02.setitem(row, 'dept_code', ls_cc_code)
		
end choose

return 0
end event

type dw_pisf031a_01 from datawindow within w_pisf031a
integer x = 1115
integer y = 76
integer width = 1938
integer height = 92
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_pisf031a_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;str_xy str_lxy
string ls_return_dt

if dwo.name = 'b_1' then
	str_lxy.lx = iw_This.PointerX()
	str_lxy.ly = iw_This.PointerY() + 350
	openwithparm(w_today,str_lxy)
	If isnull(message.Stringparm) Or message.Stringparm = '' then
		return
	Else
		ls_return_dt = Message.StringParm   // powerobject
	End If	
	this.SetItem(row, 'out_date', date(ls_return_dt))
end if
end event

type dw_pisf031a_03 from uo_datawindow within w_pisf031a
integer x = 27
integer y = 1180
integer width = 3493
integer height = 704
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_part_wo"
end type

event clicked;call super::clicked;long ll_selrow

ll_selrow = dw_pisf031a_02.getselectedrow(0)
if ll_selrow < 1 then
	return 0
end if

dw_pisf031a_02.setitem(ll_selrow,'wo_code', This.getitemstring(row,'wo_code'))
dw_pisf031a_02.setitem(ll_selrow,'equip_code', This.getitemstring(row,'equip_code'))
end event

type cb_return from commandbutton within w_pisf031a
integer x = 3991
integer y = 84
integer width = 398
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자재반납"
end type

event clicked;window		 l_to_open
string 		 l_s_menu_cd, l_s_winid, l_s_menucd, l_s_wingrd
string		 l_s_st, l_s_winnm

setpointer(hourglass!)

l_s_wingrd = ' '

//입고만처리
  SELECT WIN_ID,   
         WIN_NM,   
         WIN_RPT   
    INTO :l_s_winid,   
         :l_s_winnm,   
         :g_s_runparm   
    FROM COMM110
   WHERE WIN_ID = 'w_pisf032' 
	USING	sqlpis	;
	
if sqlpis.sqlcode <> 0 or isnull(g_s_runparm) then
	g_s_runparm = ' '
end if

this.setredraw(false)
if f_open_sheet(l_s_winid) = 0 then
	if Opensheetwithparm(l_to_open, l_s_wingrd + l_s_winnm, &
								l_s_winid, w_frame, 0, Layered!) = -1 then
		messagebox("확인","준비 않된 [화면]입니다.")
	end if
end if

this.setredraw(true)

end event

type dw_as400 from datawindow within w_pisf031a
boolean visible = false
integer x = 3881
integer y = 360
integer width = 686
integer height = 400
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_up_ipis_mis_tmcpartrelease"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_pisf031a
integer x = 27
integer y = 8
integer width = 3035
integer height = 188
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_2 from groupbox within w_pisf031a
integer x = 3109
integer y = 8
integer width = 1307
integer height = 188
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 134217730
long backcolor = 12632256
string text = "화면전환"
end type

type gb_3 from groupbox within w_pisf031a
integer x = 27
integer y = 200
integer width = 1838
integer height = 216
integer taborder = 30
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

