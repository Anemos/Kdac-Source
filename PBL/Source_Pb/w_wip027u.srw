$PBExportHeader$w_wip027u.srw
$PBExportComments$당월사용량 수정
forward
global type w_wip027u from w_origin_sheet02
end type
type tab_1 from tab within w_wip027u
end type
type tabpage_1 from userobject within tab_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_replist from datawindow within tabpage_1
end type
type dw_2 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_1 gb_1
dw_replist dw_replist
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from datawindow within tabpage_2
end type
type cb_optcancel from commandbutton within tabpage_2
end type
type cb_option from commandbutton within tabpage_2
end type
type dw_repentry from datawindow within tabpage_2
end type
type dw_history from datawindow within tabpage_2
end type
type dw_rephead from datawindow within tabpage_2
end type
type gb_2 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
cb_optcancel cb_optcancel
cb_option cb_option
dw_repentry dw_repentry
dw_history dw_history
dw_rephead dw_rephead
gb_2 gb_2
end type
type tab_1 from tab within w_wip027u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type st_4 from statictext within w_wip027u
end type
type st_5 from statictext within w_wip027u
end type
end forward

global type w_wip027u from w_origin_sheet02
integer height = 2668
tab_1 tab_1
st_4 st_4
st_5 st_5
end type
global w_wip027u w_wip027u

type variables
integer i_n_tabindex, net, i_n_job
string i_s_plant,i_s_cttp, i_s_dvsn

end variables

forward prototypes
public function integer wf_set_wip004 (datastore arg_ds, datawindow arg_dw, integer a_currow)
public function integer wf_option_datachk (datawindow arg_dw)
public function integer wf_option_update (datawindow arg_dw)
public function integer wf_finddata_chk (datawindow arg_dw)
end prototypes

public function integer wf_set_wip004 (datastore arg_ds, datawindow arg_dw, integer a_currow);integer li_currow
string ls_serial, ls_prsrno1, ls_prsrno2, ls_adjdate
dec{2} lc_diffqty

//재공시리얼번호 가져오기
ls_serial = f_wip_get_serialno(g_s_company)
if ls_serial = '0' then
	return -1
end if

ls_prsrno1 = ''
ls_prsrno2 = ''
//재공트렌스에 사용량차이량을 반영
lc_diffqty = arg_dw.getitemdecimal(a_currow,"repqt") - arg_dw.getitemdecimal(a_currow,"chqt")

li_currow = arg_ds.insertrow(0)
arg_ds.setitem(li_currow,"wdcmcd", g_s_company)
arg_ds.setitem(li_currow,"wdslty", 'WR')
arg_ds.setitem(li_currow,"wdsrno", ls_serial)
arg_ds.setitem(li_currow,"wdplant", arg_dw.getitemstring(a_currow,"wdplant"))
arg_ds.setitem(li_currow,"wddvsn", arg_dw.getitemstring(a_currow,"wddvsn"))
arg_ds.setitem(li_currow,"wdiocd", arg_dw.getitemstring(a_currow,"wdiocd"))
arg_ds.setitem(li_currow,"wditno", arg_dw.getitemstring(a_currow,"wditno"))
arg_ds.setitem(li_currow,"wdrvno", arg_dw.getitemstring(a_currow,"wdrvno"))
arg_ds.setitem(li_currow,"wddesc", arg_dw.getitemstring(a_currow,"wddesc"))
arg_ds.setitem(li_currow,"wdspec", arg_dw.getitemstring(a_currow,"wdspec"))
arg_ds.setitem(li_currow,"wdunit", arg_dw.getitemstring(a_currow,"wdunit"))
arg_ds.setitem(li_currow,"wditcl", arg_dw.getitemstring(a_currow,"wditcl"))
arg_ds.setitem(li_currow,"wdsrce", arg_dw.getitemstring(a_currow,"wdsrce"))
arg_ds.setitem(li_currow,"wdusge", arg_dw.getitemstring(a_currow,"wdusge"))
arg_ds.setitem(li_currow,"wdpdcd", arg_dw.getitemstring(a_currow,"wdpdcd"))
arg_ds.setitem(li_currow,"wdslno", ' ')
arg_ds.setitem(li_currow,"wdprsrty", 'WR')
arg_ds.setitem(li_currow,"wdprsrno", ' ')
arg_ds.setitem(li_currow,"wdprsrno1", ' ')
arg_ds.setitem(li_currow,"wdprsrno2", ' ')
arg_ds.setitem(li_currow,"wdprno", arg_dw.getitemstring(a_currow,"wdprno"))
arg_ds.setitem(li_currow,"wdprdpt", arg_dw.getitemstring(a_currow,"wdprdpt"))
arg_ds.setitem(li_currow,"wdchdpt", arg_dw.getitemstring(a_currow,"wdchdpt"))
arg_ds.setitem(li_currow,"wddate", g_s_date)
arg_ds.setitem(li_currow,"wdprqt", 0)
arg_ds.setitem(li_currow,"wdchqt", lc_diffqty)
arg_ds.setitem(li_currow,"wdipaddr", g_s_ipaddr)
arg_ds.setitem(li_currow,"wdmacaddr", g_s_macaddr)
arg_ds.setitem(li_currow,"wdinptid", g_s_empno)
arg_ds.setitem(li_currow,"wdupdtid", ' ')
arg_ds.setitem(li_currow,"wdinptdt", g_s_date)
arg_ds.setitem(li_currow,"wdinpttm", mid(g_s_time,1,2) + mid(g_s_time,4,2) + mid(g_s_time,7,2))
arg_ds.setitem(li_currow,"wdupdtdt", ' ')

return 0
end function

public function integer wf_option_datachk (datawindow arg_dw);string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_adjdate, ls_err_column
string ls_cls, ls_srce, ls_pdcd, ls_xunit,ls_itnm, ls_spec, ls_rvno, ls_iocd, ls_preitno
integer li_rowcnt, li_cntx, li_cnt
dec{2} lc_qty, lc_preqty
dec{4} lc_convqty

li_rowcnt = arg_dw.rowcount()
ls_adjdate = st_5.text
for li_cntx = 1 to li_rowcnt
	ls_plant = arg_dw.getitemstring(li_cntx,"wdplant")
	ls_dvsn = arg_dw.getitemstring(li_cntx,"wddvsn")
	ls_orct = arg_dw.getitemstring(li_cntx,"wdchdpt")
	ls_itno = arg_dw.getitemstring(li_cntx,"wditno")
	ls_preitno = arg_dw.getitemstring(li_cntx,"preitno")
	lc_qty = arg_dw.getitemdecimal(li_cntx,"repqt")
	lc_preqty = arg_dw.getitemdecimal(li_cntx, "preqty")
	ls_iocd = arg_dw.getitemstring(li_cntx,"wdiocd")
	
	if f_spacechk(ls_itno) = -1 or lc_qty = 0 then
		uo_status.st_message.text = "품번이나 수량이 입력되지 않았습니다"
		return -1
	end if
	//자재마스타에서 기존정보 가져오기 
	 SELECT "PBINV"."INV101"."CLS",   
         "PBINV"."INV101"."SRCE",   
         "PBINV"."INV101"."PDCD",
			"PBINV"."INV101"."CONVQTY",
         "PBINV"."INV101"."XUNIT",   
         "PBINV"."INV002"."ITNM",   
         "PBINV"."INV002"."SPEC",   
         "PBINV"."INV002"."RVNO"  
    INTO :ls_cls,   
         :ls_srce,   
         :ls_pdcd,
			:lc_convqty,
         :ls_xunit,   
         :ls_itnm,   
         :ls_spec,   
         :ls_rvno  
    FROM "PBINV"."INV002",   
         "PBINV"."INV101"  
   WHERE ( "PBINV"."INV002"."COMLTD" = "PBINV"."INV101"."COMLTD" ) and  
         ( "PBINV"."INV002"."ITNO" = "PBINV"."INV101"."ITNO" ) and  
         ( ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
         ( "PBINV"."INV101"."XPLANT" = :ls_plant ) AND  
         ( "PBINV"."INV101"."DIV" = :ls_dvsn ) AND  
         ( "PBINV"."INV101"."ITNO" = :ls_itno ) )   using sqlca;

	if sqlca.sqlcode <> 0 then
		return -1
	end if
	//재공품에 해당하는 계정과 구입선 확인하기
   if ls_iocd = '1' then
		if (ls_cls  = "10" or ls_cls  = "20" or ls_cls  = "40" or ls_cls  = "50") and &
		   (ls_srce = "01" or ls_srce = "02" or ls_srce = "04" or ls_srce = "05" or ls_srce = "06") then
		else
			uo_status.st_message.text = "재공품이 아닙니다."
			return -1
		end if
	else
		if (ls_cls = "10" or ls_cls = "20" or ls_cls = "40" or ls_cls = "50") then  
		else
			uo_status.st_message.text = "재공품이 아닙니다"
			return -1 
		end if
	end if
	//WIP001에  존재유무
	 SELECT count(*)  
    INTO :li_cnt  
    FROM "PBWIP"."WIP001"  
   WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         ( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         ( "PBWIP"."WIP001"."WAITNO" = :ls_itno )  
         using sqlca;

	if sqlca.sqlcode <> 0 then
		return -1
	end if
	//기존품과 옵션품의 일치여부
	if ls_itno = ls_preitno then
		uo_status.st_message.text = "품번확인 바랍니다"
		return -1
	end if
	//수정수량 체크
	if (lc_qty = 0) or (lc_preqty < 0 and lc_qty > 0) or (lc_preqty > 0 and lc_qty < 0) then
		uo_status.st_message.text = "수량확인 바랍니다."
		return -1
	end if
	//기존정보 arg_dw에 저장하기
	arg_dw.setitem(li_cntx,"wdrvno",ls_rvno)
	arg_dw.setitem(li_cntx,"wddesc",ls_itnm)
	arg_dw.setitem(li_cntx,"wdspec",ls_spec)
	arg_dw.setitem(li_cntx,"wdunit",ls_xunit)
	arg_dw.setitem(li_cntx,"wditcl",ls_cls)
	arg_dw.setitem(li_cntx,"wdsrce",ls_srce)
	arg_dw.setitem(li_cntx,"wdpdcd",mid(ls_pdcd,1,2))
	arg_dw.setitem(li_cntx,"convqty",lc_convqty)
next

return 0
end function

public function integer wf_option_update (datawindow arg_dw);string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_adjdate, ls_usage
integer li_cntx, li_rowcnt
dec{2} lc_qty
dec{4} lc_convqty

arg_dw.accepttext()
li_rowcnt = arg_dw.rowcount()

ls_adjdate = st_5.text

for li_cntx = 1 to li_rowcnt
	lc_convqty = arg_dw.getitemdecimal(li_cntx,"convqty")
	ls_plant = arg_dw.getitemstring(li_cntx, "wdplant")
	ls_dvsn = arg_dw.getitemstring(li_cntx, "wddvsn")
	ls_itno = arg_dw.getitemstring(li_cntx, "wditno")
	ls_orct = arg_dw.getitemstring(li_cntx, "wdchdpt")
	ls_usage = arg_dw.getitemstring(li_cntx, "wdusge")
	lc_qty = arg_dw.getitemdecimal(li_cntx,"repqt") * lc_convqty
	
	choose case ls_usage
		case '01'
			UPDATE "PBWIP"."WIP001"  
     			SET "WAUSQT1" = "WAUSQT1" + :lc_qty  
   			WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP001"."WAITNO" = :ls_itno )  
           			using sqlca;

		case '02'
			UPDATE "PBWIP"."WIP001"  
     			SET "WAUSQT2" = "WAUSQT2" + :lc_qty  
   			WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP001"."WAITNO" = :ls_itno )  
           			using sqlca;
		case '03'
			UPDATE "PBWIP"."WIP001"  
     			SET "WAUSQT3" = "WAUSQT3" + :lc_qty  
   			WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP001"."WAITNO" = :ls_itno )  
           			using sqlca;
		case '05'
			UPDATE "PBWIP"."WIP001"  
     			SET "WAUSQT5" = "WAUSQT5" + :lc_qty  
   			WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP001"."WAITNO" = :ls_itno )  
           			using sqlca;
	end choose
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return -1
	end if	
	//기말 재공 UPDATE
	UPDATE "PBWIP"."WIP001"  
		SET "WAOHQT" = "WAOHQT" - :lc_qty  
		WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
				( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
				( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
				( "PBWIP"."WIP001"."WAITNO" = :ls_itno )  
				using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return -1
	end if
next
return 0
end function

public function integer wf_finddata_chk (datawindow arg_dw);string ls_plant, ls_dvsn, ls_vndr, ls_iocd, ls_rtnvalue, ls_orct, ls_itno
string ls_cttp, ls_date, ls_stscd, ls_rtn

arg_dw.accepttext()
if i_n_tabindex = 1 then
	ls_plant = arg_dw.getitemstring(1,"wip001_waplant")
	ls_dvsn = arg_dw.getitemstring(1,"wip001_wadvsn")
	ls_vndr = arg_dw.getitemstring(1,"vndr")
	ls_iocd = arg_dw.getitemstring(1,"wip001_waiocd")
	ls_orct = arg_dw.getitemstring(1,"wip001_waorct")
	if ls_iocd = '2' then
		ls_rtnvalue = f_get_vendor01(g_s_company, ls_vndr)
		if f_spacechk(ls_rtnvalue) <> -1 then		//사업자번호가 입력된경우
			ls_rtn = arg_dw.modify("vndr.background.color = 15780518")
			arg_dw.setitem(1,"vndnm",mid(ls_rtnvalue,6))
			arg_dw.setitem(1,"wip001_waorct",trim(mid(ls_rtnvalue,1,5)) + '%')
		else
			uo_status.st_message.text = "사업자번호에 해당하는 업체가 없습니다."
			ls_rtn = arg_dw.modify("vndr.background.color = 65535")
			return -1
		end if
	else
		arg_dw.setitem(1,"wip001_waorct",'9999%')
	end if
else
	ls_plant = arg_dw.getitemstring(1,"wip001_waplant")
	ls_dvsn = arg_dw.getitemstring(1,"wip001_wadvsn")
	ls_vndr = arg_dw.getitemstring(1,"vndr")
	ls_iocd = arg_dw.getitemstring(1,"wip001_waiocd")
	ls_orct = arg_dw.getitemstring(1,"wip001_waorct")
	ls_itno = arg_dw.getitemstring(1,"wip001_waitno")
	if ls_iocd = '1' then
		if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, arg_dw) = -1 then
			uo_status.st_message.text = "정의되지 않은 품번입니다."
			ls_rtn = arg_dw.modify("wip001_waitno.background.color = 65535")
			return -1
		else
			ls_rtn = arg_dw.modify("wip001_waitno.background.color = 15780518")
			arg_dw.setitem(1,"wip001_waitno",ls_itno)
			arg_dw.setitem(1,"wip001_waorct",'9999%')
		end if
	else
		if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, arg_dw) = -1 then
			uo_status.st_message.text = "정의되지 않은 품번입니다."
			ls_rtn = arg_dw.modify("wip001_waitno.background.color = 65535")
			return -1
		else
			ls_rtn = arg_dw.modify("wip001_waitno.background.color = 15780518")
			arg_dw.setitem(1,"wip001_waitno",ls_itno)
		end if
		
		ls_rtnvalue = f_get_vendor01(g_s_company, ls_vndr)
		if f_spacechk(ls_rtnvalue) <> -1 then		//사업자번호가 입력된경우
			ls_rtn = arg_dw.modify("vndr.background.color = 15780518")
			arg_dw.setitem(1,"vndnm",mid(ls_rtnvalue,6))
			arg_dw.setitem(1,"wip001_waorct",trim(mid(ls_rtnvalue,1,5)) + '%')
		else
			uo_status.st_message.text = "사업자번호에 해당하는 업체가 없습니다."
			ls_rtn = arg_dw.modify("vndr.background.color = 65535")
			return -1
		end if
	end if
end if

return 0
end function

on w_wip027u.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_4=create st_4
this.st_5=create st_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
end on

on w_wip027u.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_4)
destroy(this.st_5)
end on

event open;call super::open;datawindow ldw_01, ldw_02, ldw_03, ldw_04, ldw_05, ldw_06
datawindowchild dwc_01, dwc_02, dwc_03, dwc_04

st_5.text = mid(g_s_date,1,6)
ldw_01 = tab_1.tabpage_1.dw_2
ldw_02 = tab_1.tabpage_1.dw_replist
ldw_03 = tab_1.tabpage_2.dw_3
ldw_04 = tab_1.tabpage_2.dw_rephead
ldw_05 = tab_1.tabpage_2.dw_history
ldw_06 = tab_1.tabpage_2.dw_repentry

ldw_01.settransobject(sqlca)
ldw_02.settransobject(sqlca)
ldw_03.settransobject(sqlca)
ldw_04.settransobject(sqlca)
ldw_05.settransobject(sqlca)
ldw_06.settransobject(sqlca)

ldw_01.getchild("wip001_waplant",dwc_01)
	dwc_01.settransobject(sqlca)
	dwc_01.retrieve('SLE220')
ldw_01.getchild("wip001_wadvsn",dwc_02)
	dwc_02.settransobject(sqlca)
	dwc_02.retrieve('D')
	
ldw_03.getchild("wip001_waplant",dwc_03)
dwc_03.settransobject(sqlca)
dwc_03.retrieve('SLE220')
ldw_03.getchild("wip001_wadvsn",dwc_04)
dwc_04.settransobject(sqlca)
dwc_04.retrieve('D')

ldw_03.insertrow(0)
ldw_03.setitem(1,"wip001_waiocd",'2')

ldw_01.insertrow(0)
ldw_01.setitem(1,"wip001_waiocd",'2')

ldw_04.insertrow(0)

// 조회, 입력, 저장, 삭제, 인쇄, 처음, 이정, 다음, 끝, 닫기, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false, false, false, false, false, false, false, false, false)
end event

event ue_retrieve;datawindow ldw_01, ldw_02, ldw_03, ldw_04, ldw_05, ldw_06
string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_iocd, ls_adjdate, ls_rtnvalue
integer li_rowcnt, li_rtncode
dec{4} lc_convqty

uo_status.st_message.text = ""
ldw_01 = tab_1.tabpage_1.dw_2
ldw_02 = tab_1.tabpage_1.dw_replist
ldw_03 = tab_1.tabpage_2.dw_3
ldw_04 = tab_1.tabpage_2.dw_rephead
ldw_05 = tab_1.tabpage_2.dw_history
ldw_06 = tab_1.tabpage_2.dw_repentry

choose case i_n_tabindex
	case 1	
		//필수입력 체크
		ldw_02.reset()
	 	if f_wip_mandantory_chk(ldw_01) = -1 then							
		 	uo_status.st_message.text = f_message("E010")
			return 0
		end if
		
		//선택입력 및 데이타체크 
		if wf_finddata_chk(ldw_01) = -1 then return 0
		
		//조회용데이타 가져오기
		ldw_01.accepttext()
		ls_plant = ldw_01.getitemstring(1,"wip001_waplant")
		ls_dvsn  = ldw_01.getitemstring(1, "wip001_wadvsn")
	 	ls_iocd = ldw_01.getitemstring(1,"wip001_waiocd")
		ls_orct = ldw_01.getitemstring(1,"wip001_waorct")
		
		li_rowcnt = ldw_02.retrieve(g_s_company, ls_plant, ls_dvsn,ls_iocd, ls_orct)
		
		if li_rowcnt > 0 then
			uo_status.st_message.text = f_message("I010")
      else
         uo_status.st_message.text = f_message("I020")
	   end if
		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 이정, 다음, 끝, 닫기, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true, false, false, false, true, false, false, false, false, false, false, false)
	case 2
	  	ldw_04.reset()
	  	ldw_05.reset()
		ldw_06.reset()
		ldw_03.accepttext()
		
		//필수입력 체크
		if f_wip_mandantory_chk(ldw_03) = -1 then return 0
		
		//선택입력 및 데이타체크 
		if wf_finddata_chk(ldw_03) = -1 then return 0
		
		//조회용데이타 가져오기
		ls_plant = ldw_03.getitemstring(1,"wip001_waplant")
		ls_dvsn  = ldw_03.getitemstring(1,"wip001_wadvsn")
		ls_itno  = ldw_03.getitemstring(1,"wip001_waitno")
	  	ls_iocd = ldw_03.getitemstring(1,"wip001_waiocd")
		ls_orct = ldw_03.getitemstring(1,"wip001_waorct")
		
		li_rowcnt = ldw_04.retrieve(g_s_company, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_adjdate)	
		if li_rowcnt <= 0 then
			uo_status.st_message.text = "조회할자료가 없음"
			return 0
		else
			//현재공수량 설정
			lc_convqty = ldw_04.getitemdecimal(1,"inv101_convqty")
			ldw_04.setitem(1,"preohqt", (ldw_04.getitemdecimal(1,"wip001_waohqt")) / lc_convqty)
			ldw_04.setitem(1,"postohqt",0);
		end if

		// 조회, 입력, 저장, 삭제, 인쇄, 처음, 이정, 다음, 끝, 닫기, 상세조회, 화면인쇄, 특수문자
		wf_icon_onoff(true, false, true, false, false, false, false, false, false, false, false, false)
end choose	

return 0				
    
end event

event ue_save;datawindow ldw_01, ldw_02, ldw_03
dwitemstatus ldws_01
datastore lds_01
string ls_usage, ls_adjdate, ls_plant, ls_dvsn, ls_orct, ls_itno
integer li_rowcnt, li_cntx, li_rtncode
dec{2} lc_totalqty, lc_originqty, lc_diffqty
dec{4} lc_convqty

lds_01 = create datastore
lds_01.dataobject = "d_wip_option_wip004"
lds_01.settransobject(sqlca)

lds_01.reset()
ldw_01 = tab_1.tabpage_2.dw_rephead
ldw_02 = tab_1.tabpage_2.dw_history
ldw_03 = tab_1.tabpage_2.dw_repentry

ls_plant = ldw_01.getitemstring(1,"wip001_waplant")
ls_dvsn = ldw_01.getitemstring(1,"wip001_wadvsn")
ls_orct = ldw_01.getitemstring(1,"wip001_waorct")
ls_itno = ldw_01.getitemstring(1,"wip001_waitno")

//Option품 체크
ldw_03.accepttext()
li_rowcnt = ldw_03.rowcount()
if li_rowcnt > 0 then
	if wf_option_datachk(ldw_03) = -1 then return 0
end if
//추가된 Option품이 있으면 wip004 dwo에 입력, dw_rephead에 수정수량반영
lc_totalqty = 0
ldw_03.accepttext()
if li_rowcnt > 0 then
	for li_cntx = 1 to li_rowcnt
		lc_totalqty = lc_totalqty + ldw_03.getitemdecimal(li_cntx,"repqt")
		ls_usage = ldw_03.getitemstring(li_cntx,"wdusge")
		if wf_set_wip004(lds_01, ldw_03, li_cntx) = -1 then
			return 0
		end if
	next
end if

//사용량 수정체크
//수정된 품번이 있으면 wip004 dwo에 입력, dw_rephead에 반영
//수정후사용량은 히스토리, 차이수량은 이월DB
ldw_02.accepttext()
li_rowcnt = ldw_02.rowcount()
lc_totalqty = 0
if li_rowcnt > 0 then
	for li_cntx = 1 to li_rowcnt
		ldws_01 = ldw_02.getitemstatus(li_cntx,"repqt",Primary!)
		ls_usage = ldw_02.getitemstring(li_cntx,"wdusge")
		lc_diffqty = ldw_02.getitemdecimal(li_cntx,"chqt") - ldw_02.getitemdecimal(li_cntx,"repqt")
		if ldws_01 = DataModified! and lc_diffqty <> 0 then
			lc_totalqty = lc_totalqty + lc_diffqty
			if wf_set_wip004(lds_01, ldw_02, li_cntx) = -1 then
				return 0
			end if
		end if
	next
	
	lc_originqty = ldw_01.getitemdecimal(1,"postohqt")
	if lc_originqty = 0 then
		lc_originqty = ldw_01.getitemdecimal(1,"preohqt")
	end if
	lc_convqty = ldw_01.getitemdecimal(1,"inv101_convqty")
	ldw_01.setitem(1,"postohqt",lc_originqty + (lc_totalqty / lc_convqty))
	choose case ls_usage
		case '01'
			lc_originqty = ldw_01.getitemdecimal(1,"wip001_wausqt1")
			ldw_01.setitem(1,"wip001_wausqt1", lc_originqty - (lc_totalqty * lc_convqty))
		case '02'
			lc_originqty = ldw_01.getitemdecimal(1,"wip001_wausqt2")
			ldw_01.setitem(1,"wip001_wausqt2", lc_originqty - (lc_totalqty * lc_convqty))
		case '03'
			lc_originqty = ldw_01.getitemdecimal(1,"wip001_wausqt3")
			ldw_01.setitem(1,"wip001_wausqt3", lc_originqty - (lc_totalqty * lc_convqty))
		case '05'
			lc_originqty = ldw_01.getitemdecimal(1,"wip001_wausqt5")
			ldw_01.setitem(1,"wip001_wausqt5", lc_originqty - (lc_totalqty * lc_convqty))
	end choose
	
else
	uo_status.st_message.text = "수정내역이 없습니다"
end if
	
//wip004 update
lds_01.accepttext()
f_wip_null_chk2(lds_01)
li_rowcnt = lds_01.rowcount()
li_rtncode = lds_01.update()

if li_rtncode = 1 then
	uo_status.st_message.text = "wip004 complete"
	commit using sqlca;
else
	messagebox("chk",string(li_rtncode) + " : " + sqlca.sqlerrtext + " : " + string(sqlca.sqldbcode))
	uo_status.st_message.text = "저장실패"
	Rollback using sqlca;
	return 0
end if

//Option품 사용량 이월DB UDATE
if wf_option_update(ldw_03) = -1 then
	uo_status.st_message.text = "Option품 Update에러"
	return 0
end if
//수량 수정 이월DB UPDATE
f_wip_inptid(ldw_01)
ldw_01.accepttext()
if ldw_01.update() = 1 then
	uo_status.st_message.text = "수량수정 업데이트 완료"
	commit using sqlca;
else
	uo_status.st_message.text = "수량수정 업데이트 실패"
	rollback using sqlca;
	return 0
end if

////이월 기말재공 UPDATE
//ls_adjdate = uf_wip_addmonth(st_5.text,1)
//lc_originqty = ldw_01.getitemdecimal(1,"postohqt") * lc_convqty
//  
//  UPDATE "PBWIP"."WIP002"  
//     SET "WBBGQT" = :lc_originqty  
//   WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
//         ( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
//         ( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
//         ( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
//         ( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
//         ( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
//         using sqlca;
//
//if sqlca.sqlcode <> 0 then
//	uo_status.st_message.text = "기말재공 UPDATE 에러"
//	return 0
//else
//	uo_status.st_message.text = "기말재공 완료"
//end if


i_b_retrieve  = true
i_b_insert    = false
i_b_save      = false
i_b_delete    = false
i_b_print     = false
i_b_first     = false
i_b_prev      = false
i_b_next      = false
i_b_last      = false
i_b_dretrieve = false
i_b_dprint    = false
i_b_dchar     = false
//// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(i_b_retrieve, i_b_insert, i_b_save, i_b_delete, i_b_print, i_b_first, i_b_prev, i_b_next, i_b_last, i_b_dretrieve, &
				  i_b_dprint,   i_b_dchar)
return 0				
    
end event

type uo_status from w_origin_sheet02`uo_status within w_wip027u
end type

type tab_1 from tab within w_wip027u
integer x = 9
integer y = 28
integer width = 4608
integer height = 2448
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
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

end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4571
integer height = 2324
long backcolor = 12632256
string text = "수정 List"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
gb_1 gb_1
dw_replist dw_replist
dw_2 dw_2
end type

on tabpage_1.create
this.gb_1=create gb_1
this.dw_replist=create dw_replist
this.dw_2=create dw_2
this.Control[]={this.gb_1,&
this.dw_replist,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.gb_1)
destroy(this.dw_replist)
destroy(this.dw_2)
end on

type gb_1 from groupbox within tabpage_1
integer x = 27
integer y = 20
integer width = 4530
integer height = 228
integer taborder = 10
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_replist from datawindow within tabpage_1
integer x = 5
integer y = 280
integer width = 4553
integer height = 2032
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip027u_linelist"
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

event doubleclicked;datawindow ldw_01,ldw_02
string ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd, ls_rtnvalue, ls_rtn
window l_s_wsheet

l_s_wsheet = w_frame.GetActiveSheet()
ldw_01 = tab_1.tabpage_2.dw_3
ldw_02 = tab_1.tabpage_1.dw_replist
ldw_01.setitem(1,"wip001_waplant",ldw_02.getitemstring(row,"wip001_waplant"))
ldw_01.setitem(1,"wip001_wadvsn",ldw_02.getitemstring(row,"wip001_wadvsn"))
ldw_01.setitem(1,"wip001_waorct",ldw_02.getitemstring(row,"wip001_waorct"))
ldw_01.setitem(1,"wip001_waiocd",ldw_02.getitemstring(row,"wip001_waiocd"))
ldw_01.setitem(1,"wip001_waitno",ldw_02.getitemstring(row,"wip001_waitno"))

if ldw_02.getitemstring(row,"wip001_waiocd") = '2' then
	ls_rtn = ldw_01.modify("vndr_t.visible = true")
	ls_rtn = ldw_01.modify("vndr.visible = true")
	ls_rtn = ldw_01.modify("vsrno_t.visible = true")
	ls_rtn = ldw_01.modify("vndnm.visible = true")
	ls_rtn = ldw_01.modify("b_search.visible = true")
	ls_rtn = ldw_01.modify("vndr.background.color = 15780518")
	ls_rtnvalue = f_get_vendor02(g_s_company, ldw_02.getitemstring(row,"wip001_waorct"))
	if f_spacechk(ls_rtnvalue) = -1 then
		uo_status.st_message.text = "해당업체코드가 존재하지 않습니다."
		return 0
	else
		ldw_01.setitem(1,"vndr",mid(ls_rtnvalue,1,10))
		ldw_01.setitem(1,"vndnm",mid(ls_rtnvalue,11))
	end if
else
	ldw_01.setitem(1,"wip001_waorct",'9999')
	ls_rtn = ldw_01.modify("vndr_t.visible = false")
	ls_rtn = ldw_01.modify("vndr.visible = false")
	ls_rtn = ldw_01.modify("vsrno_t.visible = false")
	ls_rtn = ldw_01.modify("vndnm.visible = false")
	ls_rtn = ldw_01.modify("b_search.visible = false")
	ls_rtn = ldw_01.modify("vndr.background.color = 1090519039")
end if

tab_1.selecttab(2)
i_n_tabindex = 2
l_s_wsheet.TriggerEvent("ue_retrieve")




end event

type dw_2 from datawindow within tabpage_1
event ue_enterkey pbm_keydown
integer x = 46
integer y = 72
integer width = 4425
integer height = 148
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip011u_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enterkey;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if

return 0
end event

event buttonclicked;string ls_parm

if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' O')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		dw_2.setitem(1,"vndnm",trim(mid(ls_parm,16)))
		dw_2.setitem(1,"vndr",trim(mid(ls_parm,6,10)))
		dw_2.setitem(1,"wip001_waorct",trim(mid(ls_parm,1,5)))
	end if
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_null, ls_rtn
datawindowchild cdw_1

This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

if ls_colname = "wip001_waiocd" then
	if data = '2' then
		ls_rtn = This.modify("vndr_t.visible = true")
		ls_rtn = This.modify("vndr.visible = true")
		ls_rtn = This.modify("vsrno_t.visible = true")
		ls_rtn = This.modify("vndnm.visible = true")
		ls_rtn = This.modify("b_search.visible = true")
		This.setitem(1,"wip001_waorct",'')
		ls_rtn = This.modify("vndr.background.color = 15780518")
	else
		This.setitem(1,"wip001_waorct",'9999%')
		ls_rtn = This.modify("vndr_t.visible = false")
		ls_rtn = This.modify("vndr.visible = false")
		ls_rtn = This.modify("vsrno_t.visible = false")
		ls_rtn = This.modify("vndnm.visible = false")
		ls_rtn = This.modify("b_search.visible = false")
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


end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 4571
integer height = 2324
long backcolor = 12632256
string text = "사용 수정"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_3 dw_3
cb_optcancel cb_optcancel
cb_option cb_option
dw_repentry dw_repentry
dw_history dw_history
dw_rephead dw_rephead
gb_2 gb_2
end type

on tabpage_2.create
this.dw_3=create dw_3
this.cb_optcancel=create cb_optcancel
this.cb_option=create cb_option
this.dw_repentry=create dw_repentry
this.dw_history=create dw_history
this.dw_rephead=create dw_rephead
this.gb_2=create gb_2
this.Control[]={this.dw_3,&
this.cb_optcancel,&
this.cb_option,&
this.dw_repentry,&
this.dw_history,&
this.dw_rephead,&
this.gb_2}
end on

on tabpage_2.destroy
destroy(this.dw_3)
destroy(this.cb_optcancel)
destroy(this.cb_option)
destroy(this.dw_repentry)
destroy(this.dw_history)
destroy(this.dw_rephead)
destroy(this.gb_2)
end on

type dw_3 from datawindow within tabpage_2
event ue_enterkey pbm_keydown
integer x = 82
integer y = 64
integer width = 4352
integer height = 284
integer taborder = 150
string title = "none"
string dataobject = "d_wip022u_02"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_enterkey;if key = keyenter! then
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")
end if

return 0
end event

event buttonclicked;datawindow ldw_01
string ls_parm

ldw_01 = tab_1.tabpage_2.dw_3
if dwo.name = 'b_search' then
	openwithparm(w_find_001 , ' O')
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
		ldw_01.setitem(1,"vndnm",trim(mid(ls_parm,16)))
		ldw_01.setitem(1,"vndr",trim(mid(ls_parm,6,10)))
		ldw_01.setitem(1,"waorct",trim(mid(ls_parm,1,5)))
	end if
end if

if dwo.name = 'b_itemfind' then
	string ls_plant, ls_dvsn
	ls_plant = ldw_01.getitemstring(1,"waplant")
	ls_dvsn = ldw_01.getitemstring(1,"wadvsn")
	if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
		uo_status.st_message.text = "지역이나 공장을 먼저 선택하십시요"
		return 0
	end if
	openwithparm(w_find_002 , ls_plant + ls_dvsn)
	ls_parm = message.stringparm
	if f_spacechk(ls_parm) <> -1 then
   	ldw_01.setitem(1,"waitno", mid(ls_parm,1,15))
	end if
end if
end event

event itemchanged;string ls_colname, ls_plant, ls_dvsn, ls_null
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

if ls_colname = "wip001_waiocd" then
	if data = '2' then
		This.modify("vndr_t.visible = true")
		This.modify("vndr.visible = true")
		This.modify("vsrno_t.visible = true")
		This.modify("vndnm.visible = true")
		This.modify("b_search.visible = true")
		This.setitem(1,"wip001_waorct",'')
		This.modify("vndr.background.color = 15780518")
	else
		This.setitem(1,"wip001_waorct",'9999')
		This.modify("vndr_t.visible = false")
		This.modify("vndr.visible = false")
		This.modify("vsrno_t.visible = false")
		This.modify("vndnm.visible = false")
		This.modify("b_search.visible = false")
		This.modify("vndr.background.color = 1090519039")
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

type cb_optcancel from commandbutton within tabpage_2
integer x = 3849
integer y = 948
integer width = 480
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Option품 취소"
end type

event clicked;datawindow ldw_01
string ls_itno
integer li_selrow

ldw_01 = tab_1.tabpage_2.dw_repentry
ldw_01.accepttext()
li_selrow = ldw_01.getselectedrow(0)
if li_selrow < 0 then
	uo_status.st_message.text = "취소할 행을 선택하십시요"
   return 0
end if
ls_itno = ldw_01.getitemstring(li_selrow,"wditno") 

net=messagebox("확인","선택한 "+string(li_selrow)+"번째의 "+ ls_itno+ " 품번을 삭제 하시겠습니까?",question!,okcancel!,2)
if net=2 then
   return 0
end if
ldw_01.deleterow(li_selrow)
end event

type cb_option from commandbutton within tabpage_2
integer x = 3282
integer y = 948
integer width = 539
integer height = 108
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "Option품 추가"
end type

event clicked;datawindow ldw_01, ldw_02
integer li_selrow, li_currow
dec{2} lc_diffqt

ldw_01 = tab_1.tabpage_2.dw_history
ldw_02 = tab_1.tabpage_2.dw_repentry

ldw_01.accepttext()
li_selrow = ldw_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "option품을 추가할 품번을 선택하십시요"
	return 0
end if

lc_diffqt = ldw_01.getitemdecimal(li_selrow,"chqt") - ldw_01.getitemdecimal(li_selrow,"repqt")
li_currow = ldw_02.insertrow(0)

ldw_02.setitem(li_currow,"wdplant",ldw_01.getitemstring(li_selrow,"wdplant"))
ldw_02.setitem(li_currow,"wddvsn",ldw_01.getitemstring(li_selrow,"wddvsn"))
ldw_02.setitem(li_currow,"wdiocd",ldw_01.getitemstring(li_selrow,"wdiocd"))
ldw_02.setitem(li_currow,"wdchdpt",ldw_01.getitemstring(li_selrow,"wdchdpt"))
ldw_02.setitem(li_currow,"wdprdpt",ldw_01.getitemstring(li_selrow,"wdprdpt"))
ldw_02.setitem(li_currow,"wdprno",ldw_01.getitemstring(li_selrow,"wdprno"))
ldw_02.setitem(li_currow,"wdusge",ldw_01.getitemstring(li_selrow,"wdusge"))
ldw_02.setitem(li_currow,"preitno",ldw_01.getitemstring(li_selrow,"wditno"))
ldw_02.setitem(li_currow,"preqty", lc_diffqt)
ldw_02.setitem(li_currow,"chqt", 0)


end event

type dw_repentry from datawindow within tabpage_2
integer x = 2830
integer y = 1076
integer width = 1733
integer height = 1240
integer taborder = 110
string title = "none"
string dataobject = "d_wip022u_03"
boolean hscrollbar = true
boolean vscrollbar = true
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

type dw_history from datawindow within tabpage_2
integer y = 1080
integer width = 2811
integer height = 1236
integer taborder = 70
string title = "none"
string dataobject = "d_wip022u_inq"
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

event rowfocuschanging;////사용량이 수정된 경우 : 차이수량을 계산
//dec{2} lc_diff
//
//if This.getitemdecimal(currentrow,"repqt") <> 0 then
//	lc_diff = This.getitemdecimal(currentrow,"chqt") - This.getitemdecimal(currentrow,"repqt")
//	This.setitem(currentrow,"diffqt",lc_diff)
//end if
end event

type dw_rephead from datawindow within tabpage_2
integer x = 5
integer y = 404
integer width = 4558
integer height = 484
string title = "none"
string dataobject = "d_wip027u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;datawindow ldw_01, ldw_02
string ls_usage, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_adjdate
integer li_rtnrow

uo_status.st_message.text = ""
ldw_01 = tab_1.tabpage_2.dw_rephead
ldw_02 = tab_1.tabpage_2.dw_history

ls_plant = ldw_01.getitemstring(1,"wip001_waplant")
ls_dvsn = ldw_01.getitemstring(1,"wip001_wadvsn")
ls_orct = ldw_01.getitemstring(1,"wip001_waorct")
ls_itno = ldw_01.getitemstring(1,"wip001_waitno")

ls_adjdate = st_5.text

choose case dwo.name
	case 'b_usqt1'
		ls_usage = '01'
	case 'b_usqt2'
		ls_usage = '02'
	case 'b_usqt3'
		ls_usage = '03'
	case 'b_usqt5'
		ls_usage = '05'
	case else
		return 0
end choose

li_rtnrow = ldw_02.retrieve(g_s_company, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_adjdate, ls_usage)
if li_rtnrow < 1 then
	uo_status.st_message.text = "조회된 데이타가 없습니다"
else
	uo_status.st_message.text = "조회되었습니다"
end if
end event

type gb_2 from groupbox within tabpage_2
integer x = 23
integer y = 4
integer width = 4535
integer height = 356
integer taborder = 20
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

type st_4 from statictext within w_wip027u
integer x = 1317
integer y = 32
integer width = 384
integer height = 68
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "적용년월:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_wip027u
integer x = 1714
integer y = 24
integer width = 526
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

