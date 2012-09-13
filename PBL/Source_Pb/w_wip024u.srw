$PBExportHeader$w_wip024u.srw
$PBExportComments$기타사용 정보 입력
forward
global type w_wip024u from w_origin_sheet01
end type
type dw_1 from datawindow within w_wip024u
end type
type tab_1 from tab within w_wip024u
end type
type tabpage_1 from userobject within tab_1
end type
type dw_2 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
end type
type tab_1 from tab within w_wip024u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type dw_4 from datawindow within w_wip024u
end type
type gb_1 from groupbox within w_wip024u
end type
end forward

global type w_wip024u from w_origin_sheet01
string title = "기타사용정보등록"
dw_1 dw_1
tab_1 tab_1
dw_4 dw_4
gb_1 gb_1
end type
global w_wip024u w_wip024u

type variables
string i_s_return, i_s_plant, i_s_dvsn, i_s_wccd, i_s_itno, i_s_iocd, i_s_vndr, i_s_stscd, i_s_time, i_s_date
integer i_n_cryindex, i_n_tabindex
//기타사용수정시 사용
dec{2} i_n_befqty
//결산구분코드
string i_s_gubun
//결산년월
string i_s_offdate
end variables

forward prototypes
public subroutine wf_initsetup (datawindow arg_dw)
public function integer wf_save_modify (datawindow arg_dw)
public function integer wf_authority_chk ()
public function integer wf_find_datachk (datawindow arg_dw)
public function integer wf_save_datachk (ref datawindow arg_dw)
public function integer wf_save_insert (ref datawindow arg_dw)
end prototypes

public subroutine wf_initsetup (datawindow arg_dw);string ls_rtn
//필수입력 : 하늘색
ls_rtn = arg_dw.modify("wip001_waplant.background.color = 15780518")
ls_rtn = arg_dw.modify("wip001_wadvsn.background.color = 15780518")
//선택입력 : 흰색
ls_rtn = arg_dw.modify("vndr.background.color = 1090519039")
ls_rtn = arg_dw.modify("wip001_waitno.background.color = 1090519039")

end subroutine

public function integer wf_save_modify (datawindow arg_dw);string l_s_srno, l_s_date, l_s_remk, l_s_itno, l_s_unit, l_s_cls, l_s_srce, l_s_pdcd, l_s_itnm, l_s_spec, l_s_rvno
string ls_plant, ls_dvsn, ls_orct, ls_time, ls_iocd, ls_slty, ls_srno
dec{4} l_n_qty, l_n_qty1, l_n_convqty
string l_s_datenext

//저장정보 가져오기
ls_slty = mid(arg_dw.getitemstring(1,"asrno"),1,2)
ls_srno = mid(arg_dw.getitemstring(1,"asrno"),3)
l_s_itno = arg_dw.getitemstring(1,"aitno")
l_s_unit = arg_dw.getitemstring(1,"aunit")
l_s_cls  = arg_dw.getitemstring(1,"acls")
l_s_srce = arg_dw.getitemstring(1,"asrce")
l_s_pdcd = arg_dw.getitemstring(1,"apdcd")
l_s_date = arg_dw.getitemstring(1,"adate")
l_n_qty  = arg_dw.getitemdecimal(1,"aqty")
l_s_remk = arg_dw.getitemstring(1,"aremk")
ls_plant = arg_dw.getitemstring(1,"plant")
ls_dvsn = arg_dw.getitemstring(1,"dvsn")
ls_orct = arg_dw.getitemstring(1,"orct")
ls_iocd = arg_dw.getitemstring(1,"iocd")
ls_time = mid(g_s_time,1,2) + mid(g_s_time,4,2) + mid(g_s_time,7,2)

l_s_datenext = uf_wip_addmonth(i_s_offdate,1)
//기본정보 및 변환계수 가져오기	 
	select itnm, spec, rvno into :l_s_itnm, :l_s_spec, :l_s_rvno 
	from pbinv.inv002 
	where comltd = :g_s_company and itno = :l_s_itno using sqlca;
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "데이타베이스 에러"
		return -1
	end if
	select convqty into :l_n_convqty 
	from pbinv.inv101
	where comltd = :g_s_company and xplant = :ls_plant and div = :ls_dvsn and itno = :l_s_itno using sqlca;
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "데이타베이스 에러"
		return -1
	end if
//수량에 변환계수 적용
l_n_qty1 = (l_n_qty - i_n_befqty) * l_n_convqty
l_n_qty = l_n_qty * l_n_convqty

if i_s_gubun = '1' then
	update pbwip.wip001 set wausqt8 = wausqt8 + :l_n_qty1, waohqt = waohqt - :l_n_qty1
	 where wacmcd = :g_s_company and waplant = :ls_plant and wadvsn = :ls_dvsn 
	 	and waorct = :ls_orct and waitno = :l_s_itno and waiocd = :ls_iocd
	using sqlca;
else
	//조정(기타)수량 Update
	update pbwip.wip002 set wbusqt8 = wbusqt8 + :l_n_qty1
	 where wbcmcd = :g_s_company and wbplant = :ls_plant and wbdvsn = :ls_dvsn and wborct = :ls_orct 
	 and wbitno = :l_s_itno and wbiocd = :ls_iocd and wbyear||wbmonth = :i_s_offdate 
	using sqlca;
	 
	//기말 재공 Update
	update pbwip.wip002 set wbbgqt  = wbbgqt - :l_n_qty1
	 where wbcmcd = :g_s_company and wbplant = :ls_plant and wbdvsn = :ls_dvsn and wborct = :ls_orct 
	 and wbitno = :l_s_itno and wbiocd = :ls_iocd and wbyear||wbmonth = :l_s_datenext 
	using sqlca;
	 
end if

if sqlca.sqlcode <> 0 then
//	rollback using sqlca;
   uo_status.st_message.text = "에러가 발생하였습니다."
	return -1
else
	commit using sqlca; 
	//uo_status.st_message.text = f_message("A010")
end if

//Update WIP004
  UPDATE "PBWIP"."WIP004"  
     SET "WDCHQT" = :l_n_qty,   
         "WDDATE" = :l_s_date  
   WHERE ( "PBWIP"."WIP004"."WDCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP004"."WDSLTY" = :ls_slty ) AND  
         ( "PBWIP"."WIP004"."WDSRNO" = :ls_srno )   
         using sqlca;

if sqlca.sqlcode <> 0 then
	messagebox('a', sqlca.sqlerrtext)
//	rollback using sqlca;
   uo_status.st_message.text = "에러가 발생하였습니다."
	return -1
else
	commit using sqlca; 
	//uo_status.st_message.text = f_message("A010")
end if
//기타사용 DB WIP005 UPDATE
  UPDATE "PBWIP"."WIP005"  
     SET "WEREMK" = :l_s_remk  
   WHERE ( "PBWIP"."WIP005"."WECMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP005"."WESLTY" = :ls_slty ) AND  
         ( "PBWIP"."WIP005"."WESRNO" = :ls_srno )   
         using sqlca;

if sqlca.sqlcode <> 0 then
//	rollback using sqlca;
   uo_status.st_message.text = "수정 업데이트 실패"
	return -1
else
//	commit using sqlca; 
	uo_status.st_message.text = "수정 업데이트 성공"
end if

return 0
end function

public function integer wf_authority_chk ();string ls_cttp, ls_plant, ls_dvsn, ls_rundate, ls_stscd, ls_gubun

ls_plant = dw_4.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_4.getitemstring(1,"wip001_wadvsn")

ls_cttp = 'WIP' + ls_dvsn + '050'

  SELECT "PBWIP"."WIP090"."WZDATE",     
			"PBWIP"."WIP090"."WZSTSCD"  
	 INTO :ls_rundate,      
			:ls_stscd  
		FROM "PBWIP"."WIP090"  
		WHERE ( "PBWIP"."WIP090"."WZCMCD" = :g_s_company ) AND  
				( "PBWIP"."WIP090"."WZPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP090"."WZCTTP" = :ls_cttp )   
				using sqlca;
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "에러가 발생하였습니다."
	return -1
end if

if i_s_gubun = '2' then
	if ls_stscd = 'C' then
		// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true, false, false, false, false, false, false)
	else
		// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true, false, true, true, false, false, false)
	end if
else
	// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
	wf_icon_onoff(true, false, true, true, false, false, false)
end if
	
return 0

end function

public function integer wf_find_datachk (datawindow arg_dw);string ls_plant, ls_dvsn, ls_iocd, ls_vndr, ls_itno, ls_cttp, ls_gubun,ls_rtnvalue
string ls_rtn

ls_vndr = arg_dw.getitemstring(1,"vndr")
ls_plant = arg_dw.getitemstring(1,"wip001_waplant")
ls_dvsn = arg_dw.getitemstring(1,"wip001_wadvsn")
ls_iocd = arg_dw.getitemstring(1,"wip001_waiocd")
ls_itno = arg_dw.getitemstring(1,"wip001_waitno")
ls_gubun = arg_dw.getitemstring(1,"wip001_gubun")

//재공구분 체크
if ls_iocd = '1' then
	if f_spacechk(ls_itno) = -1 then
		arg_dw.setitem(1,"wip001_waorct",'9999%')
	else
		if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, arg_dw) = -1 then
			ls_rtn = arg_dw.modify("wip001_waitno.background.color = 65535")
			return -1
		else
			ls_rtn = arg_dw.modify("wip001_waitno.background.color = 1090519039")
			arg_dw.setitem(1,"wip001_waitno",ls_itno)
			arg_dw.setitem(1,"wip001_waorct",'9999%')
		end if
	end if
else
	if f_spacechk(ls_itno) = -1 then
		//pass
	else
		if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, arg_dw) = -1 then
			ls_rtn = arg_dw.modify("wip001_waitno.background.color = 65535")
			return -1
		else
			ls_rtn = arg_dw.modify("wip001_waitno.background.color = 1090519039")
			arg_dw.setitem(1,"wip001_waitno",ls_itno)
		end if
	end if
	
	if f_spacechk(ls_vndr) <> -1 then
		ls_rtnvalue = f_get_vendor01(g_s_company, ls_vndr)
		if f_spacechk(ls_rtnvalue) <> -1 then		//사업자번호가 입력된경우
			ls_rtn = arg_dw.modify("vndr.background.color = 15780518")
			arg_dw.setitem(1,"vndnm",mid(ls_rtnvalue,6))
			arg_dw.setitem(1,"wip001_waorct",trim(mid(ls_rtnvalue,1,5)) + '%')
		else
			ls_rtn = arg_dw.modify("vndr.background.color = 65535")
			return -1
		end if
	end if
end if
return 0
end function

public function integer wf_save_datachk (ref datawindow arg_dw);string ls_date, ls_errcolumn, ls_rtn

ls_date = trim(arg_dw.getitemstring(1,"adate"))

ls_errcolumn = " "
if f_dateedit(ls_date) = space(8) then
//	ls_rtn = arg_dw.modify("adate.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "일자가 잘못 입력되었습니다."
	end if
//else
//	ls_rtn = arg_dw.modify("adate.Background.Color = 15780518")
end if

if i_s_gubun = '1' then
	//당월 수정
	if mid(ls_date,1,6) <> mid(g_s_date,1,6) then
//		ls_rtn = arg_dw.modify("adate.background.color = 65535")
		if f_spacechk(ls_errcolumn) = -1 then
			ls_errcolumn = "일자가 잘못 입력되었습니다."
		end if
//	else
//		ls_rtn = arg_dw.modify("adate.background.color = 15780518")
	end if
else
	//전월 수정
	if mid(ls_date,1,6) <> mid(i_s_offdate,1,6) then
//		ls_rtn = arg_dw.modify("adate.background.color = 65535")
		if f_spacechk(ls_errcolumn) = -1 then
			ls_errcolumn = "일자가 잘못 입력되었습니다."
		end if
//	else
//		ls_rtn = arg_dw.modify("adate.background.color = 15780518")
	end if
end if

if arg_dw.getitemdecimal(1,"aqty") = 0 then
//	ls_rtn = arg_dw.modify("aqty.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "수량이 입력되지 않았습니다."
	end if
//else
//	ls_rtn = arg_dw.modify("aqty.background.color = 15780518")
end if

if f_spacechk(trim(arg_dw.getitemstring(1,"aremk"))) = -1 then
//	ls_rtn = arg_dw.modify("adate.background.color = 65535")
	if f_spacechk(ls_errcolumn) = -1 then
		ls_errcolumn = "사유가 입력되지 않았습니다."
	end if
//else
//	ls_rtn = arg_dw.modify("adate.Background.Color = 15780518")
end if

if f_spacechk(ls_errcolumn) <> -1 then
	uo_status.st_message.text = ls_errcolumn
	arg_dw.setcolumn(ls_errcolumn)
	arg_dw.setfocus()
	return -1
else
	return 0
end if
end function

public function integer wf_save_insert (ref datawindow arg_dw);string l_s_srno, l_s_date, l_s_remk, l_s_itno, l_s_unit, l_s_cls, l_s_srce, l_s_pdcd, l_s_itnm, l_s_spec, l_s_rvno
string ls_plant, ls_dvsn, ls_orct, ls_time, ls_iocd, ls_srno
dec{4} l_n_qty, l_n_qty1, l_n_convqty
string l_s_datenext

//저장정보 가져오기
l_s_itno = arg_dw.getitemstring(1,"aitno")
l_s_unit = arg_dw.getitemstring(1,"aunit")
l_s_cls  = arg_dw.getitemstring(1,"acls")
l_s_srce = arg_dw.getitemstring(1,"asrce")
l_s_pdcd = arg_dw.getitemstring(1,"apdcd")
l_s_date = arg_dw.getitemstring(1,"adate")
l_n_qty  = arg_dw.getitemdecimal(1,"aqty")
l_s_remk = arg_dw.getitemstring(1,"aremk")
ls_plant = arg_dw.getitemstring(1,"plant")
ls_dvsn = arg_dw.getitemstring(1,"dvsn")
ls_orct = arg_dw.getitemstring(1,"orct")
ls_iocd = arg_dw.getitemstring(1,"iocd")
ls_time = g_s_datetime

l_s_srno = f_wip_get_serialno(g_s_company)

if l_s_srno = '0' then
	uo_status.st_message.text = "전산번호가져오기 실패!"
	return -1
end if
l_s_datenext = uf_wip_addmonth(i_s_offdate,1)
//기본정보 및 변환계수 가져오기	 
select itnm, spec, rvno into :l_s_itnm, :l_s_spec, :l_s_rvno 
	from pbinv.inv002 
	where comltd = :g_s_company and itno = :l_s_itno 
	using sqlca;
	
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "데이타베이스 에러 : " + sqlca.sqlerrtext
	return -1
end if
	
select convqty into :l_n_convqty 
	from pbinv.inv101
	where comltd = :g_s_company and xplant = :ls_plant 
			and div = :ls_dvsn and itno = :l_s_itno
			using sqlca;
	
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "데이타베이스 에러 : " + sqlca.sqlerrtext
	return -1
end if
//수량에 변환계수 적용
l_n_qty1 = l_n_qty * l_n_convqty

if i_s_gubun = '1' then
	update pbwip.wip001 
		set wausqt8 = wausqt8 + :l_n_qty1, 
			waohqt = waohqt - :l_n_qty1
	where wacmcd = :g_s_company and waplant = :ls_plant and 
		wadvsn = :ls_dvsn and waorct = :ls_orct and
		waitno = :l_s_itno and waiocd = :ls_iocd
	using sqlca;
else
	//조정(기타)수량 Update
	update pbwip.wip002 
		set wbusqt8 = wbusqt8 + :l_n_qty1
	where wbcmcd = :g_s_company and wbplant = :ls_plant and 
		wbdvsn = :ls_dvsn and wborct = :ls_orct and wbiocd = :ls_iocd and
		wbitno = :l_s_itno and wbyear||wbmonth = :i_s_offdate 
	using sqlca;
	 
	//기말 재공 Update
	update pbwip.wip002 
		set wbbgqt  = wbbgqt - :l_n_qty1
	where wbcmcd = :g_s_company and wbplant = :ls_plant and 
		wbdvsn = :ls_dvsn and wborct = :ls_orct and wbiocd = :ls_iocd and
		wbitno = :l_s_itno and wbyear||wbmonth = :l_s_datenext 
	using sqlca;	 
end if

if sqlca.sqlcode <> 0 then
   uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
	return -1
end if

insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, wddesc, wdspec,    wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
values (:g_s_company, 'WX', :l_s_srno, :ls_plant, :ls_dvsn, :ls_iocd, :l_s_itno, :l_s_rvno, :l_s_itnm, :l_s_spec, :l_s_unit, :l_s_cls, :l_s_srce, '08',   :l_s_pdcd, ' ',    ' ',      ' ',      ' ',       ' ',       ' ',    ' ',     :ls_orct, :l_s_date, 0,      :l_n_qty1, :g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, :ls_time, ' ') 
using sqlca;

if sqlca.sqlcode <> 0 then
   uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
	return -1
end if

insert into pbwip.wip005 (wecmcd,       weslty, wesrno,    weremk)
values (:g_s_company, 'WX',   :l_s_srno, :l_s_remk) 
using sqlca;

if sqlca.sqlcode <> 0 then
   uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
	return -1
else
	uo_status.st_message.text = "정상적으로 입력되었습니다."
end if

arg_dw.object.asrno[1] = 'WX'+l_s_srno

return 0
end function

on w_wip024u.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.tab_1=create tab_1
this.dw_4=create dw_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.gb_1
end on

on w_wip024u.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.tab_1)
destroy(this.dw_4)
destroy(this.gb_1)
end on

event open;call super::open;datawindow ldw_01,ldw_02
datawindowchild dwc_01, dwc_02

ldw_01 = tab_1.tabpage_1.dw_2
ldw_02 = tab_1.tabpage_2.dw_3

dw_4.settransobject(sqlca)
ldw_01.settransobject(sqlca)
ldw_02.settransobject(sqlca)

dw_4.getchild("wip001_waplant",dwc_01)
	dwc_01.settransobject(sqlca)
	dwc_01.retrieve('SLE220')
dw_4.getchild("wip001_wadvsn",dwc_02)
	dwc_02.settransobject(sqlca)
	dwc_02.retrieve('D')
dw_4.insertrow(0)
dw_4.setitem(1,"wip001_waiocd",'2')

//오픈시 결산전으로 셋팅
i_s_gubun = '2'
dw_4.setitem(1,"wip001_gubun",'2')
dw_4.setitem(1,"wip001_wainptdt",mid(uf_wip_addmonth(g_s_date,-1),1,6))
dw_1.dataobject = 'd_wip024u_carry_list'
dw_1.settransobject(sqlca)

i_n_cryindex = 1
// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false, false, false, false)
end event

event ue_retrieve;string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_iocd, ls_yyyymm, ls_year, ls_month
integer li_rowcnt

dw_4.accepttext()
dw_1.reset()
tab_1.tabpage_1.dw_2.reset()
tab_1.tabpage_2.dw_3.reset()

//필수입력 공백,Null 체크
if f_wip_mandantory_chk(dw_4) = -1 then return 0
//조건 데이타 체크
if wf_find_datachk(dw_4) = -1 then return 0
//이월 체크
if wf_authority_chk() = -1 then return 0
//조건데이타 가져오기
ls_plant = dw_4.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_4.getitemstring(1,"wip001_wadvsn")
ls_iocd = dw_4.getitemstring(1,"wip001_waiocd")
ls_orct = dw_4.getitemstring(1,"wip001_waorct")
ls_itno = dw_4.getitemstring(1,"wip001_waitno")
ls_yyyymm = dw_4.getitemstring(1,"wip001_wainptdt")
ls_year = mid(ls_yyyymm,1,4)
ls_month = mid(ls_yyyymm,5,2)

if f_spacechk(ls_itno) = -1 then
	ls_itno = '%'
else
	ls_itno = ls_itno + '%'
end if

if f_spacechk(ls_orct) = -1 then
	ls_orct = '%'
else
	ls_orct = ls_orct + '%'
end if

//데이타 조회
if i_s_gubun = '1' then
	i_s_offdate = ls_yyyymm
	li_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd)
else
	i_s_offdate = ls_yyyymm
	li_rowcnt = dw_1.retrieve(g_s_company, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd, ls_year, ls_month)
end if

if f_spacechk(i_s_itno) <> -1 then
	if dw_1.rowcount() <> 0 then
	   dw_1.selectrow(li_rowcnt, true)
      dw_1.triggerevent(doubleclicked!)
	end if
end if
end event

event ue_save;string ls_plant, ls_dvsn, ls_srno

setpointer(hourglass!)
tab_1.tabpage_1.dw_2.accepttext()
////필수입력 체크
//if f_wip_mandantory_chk(tab_1.tabpage_1.dw_2) = -1 then
//	return -1
//end if

//입력데이타 체크
if wf_save_datachk(tab_1.tabpage_1.dw_2) = -1 then 
	return -1
end if

ls_srno = tab_1.tabpage_1.dw_2.getitemstring(1,"asrno")
if f_spacechk(ls_srno) = -1 then
	//입력인 경우
	if wf_save_insert(tab_1.tabpage_1.dw_2) = -1 then 
		return -1
	end if
else
	//수정인 경우
	if wf_save_modify(tab_1.tabpage_1.dw_2) = -1 then 
		return -1
	end if
end if

this.triggerevent("ue_retrieve")

return 0

end event

event ue_delete;string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_slty, ls_srno, ls_date, ls_nextdt
datawindow ldw_03
integer li_selrow, li_rtn
dec{4} lc_qty, lc_convqty

uo_status.st_message.text = ""
ldw_03 = tab_1.tabpage_2.dw_3
li_selrow = ldw_03.getselectedrow(0)
ls_itno = ldw_03.getitemstring(li_selrow,"wip004_wditno")

if li_selrow < 1 then
	uo_status.st_message.text = "삭제할 데이타를 선택하십시요"
	return 0
else
	li_rtn = messagebox("알림",ls_itno + " 품번의 기타사용내역을 삭제하시겠습니까?",question!,yesno!,1)
	if li_rtn = 2 then
		uo_status.st_message.text = "취소되었습니다."
		return 0
	end if
end if

ls_plant = ldw_03.getitemstring(li_selrow,"wip004_wdplant")
ls_dvsn = ldw_03.getitemstring(li_selrow,"wip004_wddvsn")
ls_orct = ldw_03.getitemstring(li_selrow,"wip004_wdchdpt")
ls_slty = ldw_03.getitemstring(li_selrow,"wip004_wdslty")
ls_srno = ldw_03.getitemstring(li_selrow,"wip004_wdsrno")
ls_date = ldw_03.getitemstring(li_selrow,"wip004_wddate")
lc_convqty = ldw_03.getitemdecimal(li_selrow,"inv101_convqty")
lc_qty = ldw_03.getitemdecimal(li_selrow,"chqt") * lc_convqty

if i_s_gubun = '1' then
	//WIP001에서 수량계산
	UPDATE "PBWIP"."WIP001"  
     SET "WAUSQT8" = WAUSQT8  - :lc_qty,   
         "WAOHQT" = WAOHQT  + :lc_qty  
   	WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
         	( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         	( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         	( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         	( "PBWIP"."WIP001"."WAITNO" = :ls_itno )   
         	using sqlca;
	if sqlca.sqlcode <> 0 and sqlca.sqlnrows < 1 then
//		rollback using sqlca;
		uo_status.st_message.text = "에러가 발생하였습니다."
		return 0
	else
//		commit using sqlca;
	end if
else
	//WIP002에서 수량계산
	ls_nextdt = uf_wip_addmonth(ls_date,1)
	UPDATE "PBWIP"."WIP002"  
     SET "WBUSQT8" = WBUSQT8  - :lc_qty  
   	WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         	( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         	( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         	( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         	( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
         	( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_date )   
           	using sqlca;
	if sqlca.sqlcode <> 0 and sqlca.sqlnrows < 1 then
//		rollback using sqlca;
		uo_status.st_message.text = "에러가 발생하였습니다."
		return 0
	else
		UPDATE "PBWIP"."WIP002"  
		  SET "WBBGQT" = WBBGQT  + :lc_qty  
			WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
					( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
					( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
					( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
					( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
					( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_nextdt )   
					using sqlca;
		if sqlca.sqlcode <> 0 and sqlca.sqlnrows < 1 then
//			rollback using sqlca;
			uo_status.st_message.text = "에러가 발생하였습니다."
			return 0
		else
//			commit using sqlca;
		end if
	end if
end if

// WIP004, WIP005에서 내역 삭제
DELETE FROM "PBWIP"."WIP004"  
   WHERE ( "PBWIP"."WIP004"."WDCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP004"."WDSLTY" = :ls_slty ) AND  
         ( "PBWIP"."WIP004"."WDSRNO" = :ls_srno )   
         using sqlca;
if sqlca.sqlcode <> 0 then
//	rollback using sqlca;
	uo_status.st_message.text = "에러가 발생하였습니다."
	return 0
else
//	commit using sqlca;
end if

DELETE FROM "PBWIP"."WIP005"  
   WHERE ( "PBWIP"."WIP005"."WECMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP005"."WESLTY" = :ls_slty ) AND  
         ( "PBWIP"."WIP005"."WESRNO" = :ls_srno )   
         using sqlca;
if sqlca.sqlcode <> 0 then
//	rollback using sqlca;
	uo_status.st_message.text = "에러가 발생하였습니다."
	return 0
else
//	commit using sqlca;
	uo_status.st_message.text = "완료되었습니다."
end if

return 0

end event

type uo_status from w_origin_sheet01`uo_status within w_wip024u
end type

type dw_1 from datawindow within w_wip024u
integer x = 23
integer y = 376
integer width = 4576
integer height = 1188
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip024u_carry_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt
string  ls_adjdate, ls_firstdate, ls_lastdate
li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
else
	return 0
end if

datawindow ldw_02
integer l_n_row
dec{2} l_n_scrp, l_n_retn, l_n_bgqt, l_n_inqt, l_n_usqt1, l_n_usqt2, l_n_usqt3, l_n_usqt4, l_n_usqt5, l_n_usqt6, l_n_usqt7, l_n_usqt8, l_n_ohqt
string l_s_itno, l_s_clss, l_s_srce, l_s_pdcd, l_s_unit, ls_iocd
string ls_plant, ls_dvsn, ls_itno, ls_orct

uo_status.st_message.text = ""
ldw_02 = tab_1.tabpage_1.dw_2
l_n_row = dw_1.getselectedrow(0)
if l_n_row < 1 then
	uo_status.st_message.text = "선택된 데이타가 없습니다."
	return 0
end if

if i_s_gubun = '1' then
	ls_firstdate = mid(g_s_date,1,6) + '01'
	ls_lastdate = f_relativedate(uf_wip_addmonth(mid(g_s_date,1,6),1) + '01', -1)
	ls_plant = dw_1.getitemstring(l_n_row, "wip001_waplant")
	ls_dvsn = dw_1.getitemstring(l_n_row, "wip001_wadvsn")
	ls_orct = dw_1.getitemstring(l_n_row, "wip001_waorct")
	ls_iocd = dw_1.getitemstring(l_n_row, "wip001_waiocd")
   l_s_itno  = dw_1.getitemstring(l_n_row, "wip001_waitno")
	l_n_scrp  = dw_1.getitemdecimal(l_n_row, "wip001_wascrp")
	l_n_retn  = dw_1.getitemdecimal(l_n_row, "wip001_waretn")
	l_s_clss  = dw_1.getitemstring(l_n_row, "inv101_cls")
	l_s_srce  = dw_1.getitemstring(l_n_row, "inv101_srce")
	l_s_pdcd  = mid(dw_1.getitemstring(l_n_row, "inv101_pdcd"),1,2)
	l_s_unit  = dw_1.getitemstring(l_n_row, "inv101_xunit")
	l_n_bgqt  = dw_1.getitemdecimal(l_n_row, "bgqt")
	l_n_inqt  = dw_1.getitemdecimal(l_n_row, "inqt")
	l_n_usqt1 = dw_1.getitemdecimal(l_n_row, "usqt1")
	l_n_usqt2 = dw_1.getitemdecimal(l_n_row, "usqt2")
	l_n_usqt3 = dw_1.getitemdecimal(l_n_row, "usqt3")
	l_n_usqt4 = dw_1.getitemdecimal(l_n_row, "usqt4")
	l_n_usqt5 = dw_1.getitemdecimal(l_n_row, "usqt5")
	l_n_usqt6 = dw_1.getitemdecimal(l_n_row, "usqt6")
   l_n_usqt7 = dw_1.getitemdecimal(l_n_row, "usqt7")
	l_n_usqt8 = dw_1.getitemdecimal(l_n_row, "usqt8")
	l_n_ohqt  = dw_1.getitemdecimal(l_n_row, "ohqt")
else
	ls_firstdate = dw_4.getitemstring(1,"wip001_wainptdt") + '01'
	ls_lastdate = f_relativedate(uf_wip_addmonth(dw_4.getitemstring(1,"wip001_wainptdt"),1) + '01', -1)
	ls_adjdate = f_relativedate(uf_wip_addmonth(dw_4.getitemstring(1,"wip001_wainptdt"),1) + '01', -1)
	ls_plant = dw_1.getitemstring(l_n_row, "wip002_wbplant")
	ls_dvsn = dw_1.getitemstring(l_n_row, "wip002_wbdvsn")
	ls_orct = dw_1.getitemstring(l_n_row, "wip002_wborct")
	ls_iocd = dw_1.getitemstring(l_n_row,"wip002_wbiocd")
	l_s_itno  = dw_1.getitemstring(l_n_row, "wip002_wbitno")
	l_n_scrp  = dw_1.getitemdecimal(l_n_row, "wip002_wbscrp")
	l_n_retn  = dw_1.getitemdecimal(l_n_row, "wip002_wbretn")
	l_s_clss  = dw_1.getitemstring(l_n_row, "inv101_cls")
	l_s_srce  = dw_1.getitemstring(l_n_row, "inv101_srce")
	l_s_pdcd  = mid(dw_1.getitemstring(l_n_row, "inv101_pdcd"),1,2)
	l_s_unit  = dw_1.getitemstring(l_n_row, "inv101_xunit")
	l_n_bgqt  = dw_1.getitemdecimal(l_n_row, "bgqt")
	l_n_inqt  = dw_1.getitemdecimal(l_n_row, "inqt")
	l_n_usqt1 = dw_1.getitemdecimal(l_n_row, "usqt1")
	l_n_usqt2 = dw_1.getitemdecimal(l_n_row, "usqt2")
	l_n_usqt3 = dw_1.getitemdecimal(l_n_row, "usqt3")
	l_n_usqt4 = dw_1.getitemdecimal(l_n_row, "usqt4")
	l_n_usqt5 = dw_1.getitemdecimal(l_n_row, "usqt5")
	l_n_usqt6 = dw_1.getitemdecimal(l_n_row, "usqt6")
   l_n_usqt7 = dw_1.getitemdecimal(l_n_row, "usqt7")
	l_n_usqt8 = dw_1.getitemdecimal(l_n_row, "usqt8")
	l_n_ohqt  = dw_1.getitemdecimal(l_n_row, "ohqt")
end if

ldw_02.reset()
ldw_02.insertrow(0)
ldw_02.setitem(1,"plant", ls_plant)
ldw_02.setitem(1,"dvsn", ls_dvsn)
ldw_02.setitem(1,"orct", ls_orct)
ldw_02.setitem(1,"iocd", ls_iocd)
ldw_02.object.asrno[1]  = ' '
ldw_02.object.aitno[1]  = l_s_itno
ldw_02.object.ascrp[1]  = l_n_scrp
ldw_02.object.aretn[1]  = l_n_retn
ldw_02.object.acls[1]   = l_s_clss
ldw_02.object.asrce[1]  = l_s_srce
ldw_02.object.apdcd[1]  = l_s_pdcd
ldw_02.object.aunit[1]  = l_s_unit
ldw_02.object.abgqt[1]  = l_n_bgqt
ldw_02.object.ainqt[1]  = l_n_inqt
ldw_02.object.ausqt1[1] = l_n_usqt1
ldw_02.object.ausqt2[1] = l_n_usqt2
ldw_02.object.ausqt3[1] = l_n_usqt3
ldw_02.object.ausqt4[1] = l_n_usqt4
ldw_02.object.ausqt5[1] = l_n_usqt5
ldw_02.object.ausqt6[1] = l_n_usqt6
ldw_02.object.ausqt7[1] = l_n_usqt7
ldw_02.object.ausqt8[1] = l_n_usqt8
ldw_02.object.aohqt[1] = l_n_ohqt
if i_s_gubun = '1' then
	ldw_02.object.adate[1] = g_s_date
else
	ldw_02.object.adate[1] = ls_adjdate
end if
ldw_02.object.aqty[1] = 0
ldw_02.object.aremk[1] = ' '
ldw_02.setfocus()

tab_1.selecttab(1)
tab_1.tabpage_2.dw_3.reset()
tab_1.tabpage_2.dw_3.retrieve(g_s_company, ls_plant, ls_dvsn, ls_orct, l_s_itno, ls_firstdate, ls_lastdate)

return 0

end event

type tab_1 from tab within w_wip024u
integer x = 23
integer y = 1596
integer width = 4571
integer height = 864
integer taborder = 20
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
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;i_n_tabindex = newindex
//if newindex = 1 then
//	// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
//	wf_icon_onoff(true, false, true, false, false, false, false)
//else
//	// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
//	wf_icon_onoff(true, false, false, true, false, false, false)
//end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4535
integer height = 748
long backcolor = 12632256
string text = "기타사용 정보"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_1.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_1.destroy
destroy(this.dw_2)
end on

type dw_2 from datawindow within tabpage_1
integer x = 18
integer y = 12
integer width = 4503
integer height = 732
integer taborder = 10
string title = "none"
string dataobject = "d_wip024u_insert"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4535
integer height = 748
long backcolor = 12632256
string text = "내역"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_2.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_2.destroy
destroy(this.dw_3)
end on

type dw_3 from datawindow within tabpage_2
integer x = 14
integer y = 16
integer width = 4503
integer height = 728
integer taborder = 20
string dataobject = "d_wip024u_history"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt
li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if
end event

event doubleclicked;integer l_n_row
//해당 기타사용전표에 대한 내역을 수정한다.
dec{2} l_n_scrp, l_n_retn, l_n_bgqt, l_n_inqt, l_n_usqt1, l_n_usqt2, l_n_usqt3, l_n_usqt4, l_n_usqt5, l_n_usqt6, l_n_usqt7, l_n_usqt8, l_n_ohqt, l_n_qty
string l_s_itno, l_s_clss, l_s_srce, l_s_pdcd, l_s_unit, l_s_slty, l_s_srno, l_s_date, l_s_remk 
string ls_yyyymm, ls_plant, ls_dvsn, ls_orct, ls_iocd
l_n_row = dw_1.getselectedrow(0)
if i_s_gubun = '1' then
	ls_yyyymm = mid(g_s_date,1,6)       //해당월의 기타사용내역을 조회
	ls_plant = dw_1.getitemstring(l_n_row, "wip001_waplant")
	ls_dvsn = dw_1.getitemstring(l_n_row, "wip001_wadvsn")
	ls_orct = dw_1.getitemstring(l_n_row, "wip001_waorct")
	ls_iocd = dw_1.getitemstring(l_n_row, "wip001_waiocd")
   l_s_itno  = dw_1.getitemstring(l_n_row, "wip001_waitno")
	l_n_scrp  = dw_1.getitemdecimal(l_n_row, "wip001_wascrp")
	l_n_retn  = dw_1.getitemdecimal(l_n_row, "wip001_waretn")
	l_s_clss  = dw_1.getitemstring(l_n_row, "inv101_cls")
	l_s_srce  = dw_1.getitemstring(l_n_row, "inv101_srce")
	l_s_pdcd  = dw_1.getitemstring(l_n_row, "inv101_pdcd")
	l_s_unit  = dw_1.getitemstring(l_n_row, "inv101_xunit")
	l_n_bgqt  = dw_1.getitemdecimal(l_n_row, "bgqt")
	l_n_inqt  = dw_1.getitemdecimal(l_n_row, "inqt")
	l_n_usqt1 = dw_1.getitemdecimal(l_n_row, "usqt1")
	l_n_usqt2 = dw_1.getitemdecimal(l_n_row, "usqt2")
	l_n_usqt3 = dw_1.getitemdecimal(l_n_row, "usqt3")
	l_n_usqt4 = dw_1.getitemdecimal(l_n_row, "usqt4")
	l_n_usqt5 = dw_1.getitemdecimal(l_n_row, "usqt5")
	l_n_usqt6 = dw_1.getitemdecimal(l_n_row, "usqt6")
   l_n_usqt7 = dw_1.getitemdecimal(l_n_row, "usqt7")
	l_n_usqt8 = dw_1.getitemdecimal(l_n_row, "usqt8")
	l_n_ohqt  = dw_1.getitemdecimal(l_n_row, "ohqt")
else
	ls_yyyymm = mid(i_s_offdate,1,6)   //이월년월의 기타사용내역을 조회
	ls_plant = dw_1.getitemstring(l_n_row, "wip002_wbplant")
	ls_dvsn = dw_1.getitemstring(l_n_row, "wip002_wbdvsn")
	ls_orct = dw_1.getitemstring(l_n_row, "wip002_wborct")
	ls_iocd = dw_1.getitemstring(l_n_row,"wip002_wbiocd")
	l_s_itno  = dw_1.getitemstring(l_n_row, "wip002_wbitno")
	l_n_scrp  = dw_1.getitemdecimal(l_n_row, "wip002_wbscrp")
	l_n_retn  = dw_1.getitemdecimal(l_n_row, "wip002_wbretn")
	l_s_clss  = dw_1.getitemstring(l_n_row, "inv101_cls")
	l_s_srce  = dw_1.getitemstring(l_n_row, "inv101_srce")
	l_s_pdcd  = dw_1.getitemstring(l_n_row, "inv101_pdcd")
	l_s_unit  = dw_1.getitemstring(l_n_row, "inv101_xunit")
	l_n_bgqt  = dw_1.getitemdecimal(l_n_row, "bgqt")
	l_n_inqt  = dw_1.getitemdecimal(l_n_row, "inqt")
	l_n_usqt1 = dw_1.getitemdecimal(l_n_row, "usqt1")
	l_n_usqt2 = dw_1.getitemdecimal(l_n_row, "usqt2")
	l_n_usqt3 = dw_1.getitemdecimal(l_n_row, "usqt3")
	l_n_usqt4 = dw_1.getitemdecimal(l_n_row, "usqt4")
	l_n_usqt5 = dw_1.getitemdecimal(l_n_row, "usqt5")
	l_n_usqt6 = dw_1.getitemdecimal(l_n_row, "usqt6")
   l_n_usqt7 = dw_1.getitemdecimal(l_n_row, "usqt7")
	l_n_usqt8 = dw_1.getitemdecimal(l_n_row, "usqt8")
	l_n_ohqt  = dw_1.getitemdecimal(l_n_row, "ohqt")
end if
l_n_row  = tab_1.tabpage_2.dw_3.getselectedrow(0)
l_s_slty = tab_1.tabpage_2.dw_3.getitemstring(l_n_row, "wip004_wdslty")
l_s_srno = tab_1.tabpage_2.dw_3.getitemstring(l_n_row, "wip004_wdsrno")
l_s_date = tab_1.tabpage_2.dw_3.getitemstring(l_n_row, "wip004_wddate")
l_n_qty  = tab_1.tabpage_2.dw_3.getitemdecimal(l_n_row, "chqt")
l_s_remk = tab_1.tabpage_2.dw_3.getitemstring(l_n_row, "wip005_weremk")
tab_1.tabpage_1.dw_2.reset()
tab_1.tabpage_1.dw_2.insertrow(0)
tab_1.tabpage_1.dw_2.object.asrno[1]  = l_s_slty + l_s_srno
tab_1.tabpage_1.dw_2.setitem(1,"plant", ls_plant)
tab_1.tabpage_1.dw_2.setitem(1,"dvsn", ls_dvsn)
tab_1.tabpage_1.dw_2.setitem(1,"orct", ls_orct)
tab_1.tabpage_1.dw_2.setitem(1,"iocd", ls_iocd)
tab_1.tabpage_1.dw_2.object.aitno[1]  = l_s_itno
tab_1.tabpage_1.dw_2.object.ascrp[1]  = l_n_scrp
tab_1.tabpage_1.dw_2.object.aretn[1]  = l_n_retn
tab_1.tabpage_1.dw_2.object.acls[1]   = l_s_clss
tab_1.tabpage_1.dw_2.object.asrce[1]  = l_s_srce
tab_1.tabpage_1.dw_2.object.apdcd[1]  = l_s_pdcd
tab_1.tabpage_1.dw_2.object.aunit[1]  = l_s_unit
tab_1.tabpage_1.dw_2.object.abgqt[1]  = l_n_bgqt
tab_1.tabpage_1.dw_2.object.ainqt[1]  = l_n_inqt
tab_1.tabpage_1.dw_2.object.ausqt1[1] = l_n_usqt1
tab_1.tabpage_1.dw_2.object.ausqt2[1] = l_n_usqt2
tab_1.tabpage_1.dw_2.object.ausqt3[1] = l_n_usqt3
tab_1.tabpage_1.dw_2.object.ausqt4[1] = l_n_usqt4
tab_1.tabpage_1.dw_2.object.ausqt5[1] = l_n_usqt5
tab_1.tabpage_1.dw_2.object.ausqt6[1] = l_n_usqt6
tab_1.tabpage_1.dw_2.object.ausqt7[1] = l_n_usqt7
tab_1.tabpage_1.dw_2.object.ausqt8[1] = l_n_usqt8
tab_1.tabpage_1.dw_2.object.aohqt[1] = l_n_ohqt
tab_1.tabpage_1.dw_2.object.adate[1] = l_s_date
tab_1.tabpage_1.dw_2.object.aqty[1] = l_n_qty
tab_1.tabpage_1.dw_2.object.aremk[1] = l_s_remk

i_n_befqty = l_n_qty
tab_1.selecttab(1)
tab_1.tabpage_1.dw_2.setfocus()
end event

type dw_4 from datawindow within w_wip024u
event ue_enterkey pbm_keydown
integer x = 55
integer y = 52
integer width = 4430
integer height = 264
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip024u_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enterkey;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if
end event

event buttonclicked;string ls_parm

if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' O')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		This.setitem(1,"vndnm",trim(mid(ls_parm,16)))
		This.setitem(1,"vndr",trim(mid(ls_parm,6,10)))
		This.setitem(1,"wip001_waorct",trim(mid(ls_parm,1,5)))
	end if
end if

if dwo.name = 'b_itemfind' then
	string ls_plant, ls_dvsn
	ls_plant = This.getitemstring(1,"wip001_waplant")
	ls_dvsn = This.getitemstring(1,"wip001_wadvsn")
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
		uo_status.st_message.text = "지역이나 공장을 먼저 선택하십시요"
		return 0
	end if
	openwithparm(w_find_002 , ls_plant + ls_dvsn)
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
   	This.setitem(1,"wip001_waitno", mid(ls_parm,1,15))
	end if
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
string ls_rtn
datawindowchild cdw_1

uo_status.st_message.text = ""
This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

if ls_colname = 'wip001_gubun' then
	if data = '1' then
		//당월수정 경우
		i_s_gubun = data
		dw_1.dataobject = 'd_wip024u_inv_list'
		dw_1.settransobject(sqlca)
		This.setitem(1,"wip001_wainptdt",mid(g_s_date,1,6))
	else
		//전월수정 경우
		i_s_gubun = data
		dw_1.dataobject = 'd_wip024u_carry_list'
		dw_1.settransobject(sqlca)
		This.setitem(1,"wip001_wainptdt",mid(uf_wip_addmonth(g_s_date,-1),1,6))
	end if
end if

if ls_colname = 'wip001_waiocd' then
	if data = '2' then
		ls_rtn = This.modify("vndr_t.visible = true")
		ls_rtn = This.modify("vndr.visible = true")
		ls_rtn = This.modify("vsrno_t.visible = true")
		ls_rtn = This.modify("vndnm.visible = true")
		ls_rtn = This.modify("b_search.visible = true")
		This.setitem(1,"wip001_waorct",' ')
		//ls_rtn = This.modify("vndr.background.color = 15780518")
		ls_rtn = This.modify("vndr.background.color = 1090519039")
	else
		ls_rtn = This.modify("vndr_t.visible = false")
		ls_rtn = This.modify("vndr.visible = false")
		ls_rtn = This.modify("vsrno_t.visible = false")
		ls_rtn = This.modify("vndnm.visible = false")
		ls_rtn = This.modify("b_search.visible = false")
		This.setitem(1,"wip001_waorct",'9999')
		ls_rtn = This.modify("vndr.background.color = 1090519039")
	end if
end if

if ls_colname = "vndr" then
	string ls_rtnvalue
	ls_rtnvalue = f_get_vendor01(g_s_company, data)
	if ls_rtnvalue <> '' then		//사업자번호가 입력된경우
		This.setitem(1,"vndnm",mid(ls_rtnvalue,6))
		This.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
	else
		uo_status.st_message.text = "사업자번호에 해당하는 업체가 없습니다."
		return 0
	end if
end if

if ls_colname = 'wip001_waitno' then
	This.AcceptText()
	ls_plant = this.getitemstring(1,"wip001_waplant")
	ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
   if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, data, this) = -1 then
		uo_status.st_message.text = "정의되지 않은 품번입니다."
		return 0
	end if
end if

end event

type gb_1 from groupbox within w_wip024u
integer x = 23
integer width = 4571
integer height = 348
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

