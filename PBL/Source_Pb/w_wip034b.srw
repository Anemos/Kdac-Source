$PBExportHeader$w_wip034b.srw
$PBExportComments$유상사급재공 실사수량 Upload
forward
global type w_wip034b from w_origin_sheet06
end type
type gb_2 from groupbox within w_wip034b
end type
type gb_1 from groupbox within w_wip034b
end type
type st_1 from statictext within w_wip034b
end type
type st_a1 from statictext within w_wip034b
end type
type st_a2 from statictext within w_wip034b
end type
type st_3 from statictext within w_wip034b
end type
type st_daesang from statictext within w_wip034b
end type
type st_55 from statictext within w_wip034b
end type
type st_saeng from statictext within w_wip034b
end type
type uo_1 from uo_progress_bar within w_wip034b
end type
type dw_1 from datawindow within w_wip034b
end type
type cb_1 from commandbutton within w_wip034b
end type
type sle_1 from singlelineedit within w_wip034b
end type
type dw_2 from datawindow within w_wip034b
end type
type st_2 from statictext within w_wip034b
end type
type pb_down from picturebutton within w_wip034b
end type
end forward

global type w_wip034b from w_origin_sheet06
gb_2 gb_2
gb_1 gb_1
st_1 st_1
st_a1 st_a1
st_a2 st_a2
st_3 st_3
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
uo_1 uo_1
dw_1 dw_1
cb_1 cb_1
sle_1 sle_1
dw_2 dw_2
st_2 st_2
pb_down pb_down
end type
global w_wip034b w_wip034b

type variables
dec i_n_complete
end variables

on w_wip034b.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.st_1=create st_1
this.st_a1=create st_a1
this.st_a2=create st_a2
this.st_3=create st_3
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.uo_1=create uo_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.sle_1=create sle_1
this.dw_2=create dw_2
this.st_2=create st_2
this.pb_down=create pb_down
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_a1
this.Control[iCurrent+5]=this.st_a2
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_daesang
this.Control[iCurrent+8]=this.st_55
this.Control[iCurrent+9]=this.st_saeng
this.Control[iCurrent+10]=this.uo_1
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.sle_1
this.Control[iCurrent+14]=this.dw_2
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.pb_down
end on

on w_wip034b.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.st_a1)
destroy(this.st_a2)
destroy(this.st_3)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.uo_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.dw_2)
destroy(this.st_2)
destroy(this.pb_down)
end on

event ue_bcreate;integer    Net,l_n_chkcount, l_n_totalcnt, l_n_loopcnt
string 	ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd, ls_rtn, ls_year, ls_month, ls_spec
string 	ls_itnm, ls_cls, ls_srce, ls_pdcd, ls_xunit, ls_srno, ls_nextyear, ls_nextmonth
string 	ls_error, ls_adjdate, ls_postdate, ls_closedate
integer 	li_rowcnt, li_cnt, li_rtncode
dec{4} 	lc_ohqt, lc_phohqt, lc_diffqt
dec{0} 	lc_ohamt, lc_phohamt, lc_diffamt
dec{4} 	lc_convqty
dec{5} 	lc_costav

Net = messagebox("확 인", "자료생성 작업을 수행 하겠습니까?",Question!, OkCancel!, 1)
if Net <> 1 then
	return 0
end if

setpointer(HourGlass!)
//dw_1.accepttext()

ls_error = ' '
l_n_totalcnt = dec(st_daesang.text)
uo_status.st_message.text = "자료 처리중(오류 확인중)..."

l_n_chkcount = 0
//for l_n_loopcnt = 1 to l_n_totalcnt
//	ls_itno   = trim(dw_1.object.wbitno[l_n_loopcnt])
//	ls_orct	 = trim(dw_1.object.wborct[l_n_loopcnt])
//	ls_plant  = trim(dw_1.object.wbplant[l_n_loopcnt])
//	ls_dvsn   = trim(dw_1.object.wbdvsn[l_n_loopcnt])
//	ls_year   = trim(dw_1.object.wbyear[l_n_loopcnt])
//	ls_month  = trim(dw_1.object.wbmonth[l_n_loopcnt])
//	if l_n_loopcnt <> l_n_totalcnt then
//		if dw_1.find("wbitno = '" + ls_itno + "' and wborct = '" + ls_orct + "'", l_n_loopcnt + 1, dw_1.rowcount()) > 0 then
//			messagebox("자료 오류",string(l_n_loopcnt) + "Row의 " +"품번일치 오류 =  " + ls_itno)
//			return 0
//		end if
//	end if
//next

ls_adjdate = trim(dw_1.object.wbyear[1]) + trim(dw_1.object.wbmonth[1])
ls_postdate = uf_wip_addmonth(ls_adjdate,1)
ls_nextyear = mid(ls_postdate,1,4)
ls_nextmonth = mid(ls_postdate,5,2)
ls_closedate = f_relativedate(uf_wip_addmonth(ls_adjdate,1) + '01', -1)
ls_iocd	 = '3'

//UPDATE "PBWIP"."WIP014"  
//	SET "WBBGQT" = 0,
//		"WBBGAT1" = 0
//WHERE ( "PBWIP"."WIP014"."WBCMCD" = '01' ) AND  
//		( "PBWIP"."WIP014"."WBIOCD" = :ls_iocd ) AND
//		( "PBWIP"."WIP014"."WBYEAR"||"PBWIP"."WIP014"."WBMONTH" = :ls_postdate )   
//using sqlca;

l_n_loopcnt = 0
do while true
	if l_n_loopcnt = l_n_totalcnt  then exit
	l_n_loopcnt ++
   dw_1.scrolltorow(l_n_loopcnt)
	dw_1.selectrow(0,false)
	dw_1.selectrow(l_n_loopcnt,true)
	ls_year   = trim(dw_1.object.wbyear[l_n_loopcnt])
	ls_month  = trim(dw_1.object.wbmonth[l_n_loopcnt])
	ls_orct   = trim(dw_1.object.wborct[l_n_loopcnt])
	ls_plant  = trim(dw_1.object.wbplant[l_n_loopcnt])
	ls_dvsn   = trim(dw_1.object.wbdvsn[l_n_loopcnt])
	ls_itno   = trim(dw_1.object.wbitno[l_n_loopcnt])
	lc_phohqt   = dw_1.object.wbbgqt[l_n_loopcnt]

//	if l_n_loopcnt = l_n_totalcnt then
//		//pass
//	else
//		if dw_1.find("wbitno = '" + ls_itno + "' and wborct = '" + ls_orct + "'",(l_n_loopcnt + 1),l_n_totalcnt) > 0 then
//			ls_error = 'E01 : 품번일치 오류'
//		end if
//	end if
	if f_spacechk(ls_year) = -1 or mid(g_s_date,1,4) < ls_year then
		ls_error = 'E02 : 해당년도 오류'
	end if
	if ls_month <> '12'  then
		ls_error = 'E03 : 해당월 오류'
	end if
	if f_spacechk(f_get_coflname('01','SLE220', ls_plant)) = -1 then	
		ls_error = 'E05 : 지역코드 오류'
	end if
	if f_spacechk(f_get_coflname('01','DAC030', ls_dvsn)) = -1 then
		ls_error = 'E06 :공장코드 오류'
	end if
	
	SELECT AA.ITNM, AA.SPEC, BB.XUNIT, BB.CONVQTY, BB.SRCE, BB.CLS, BB.PDCD 
		INTO :ls_itnm, :ls_spec, :ls_xunit, :lc_convqty, :ls_srce, :ls_cls, :ls_pdcd
		FROM PBINV.INV002 AA, PBINV.INV101 BB
		WHERE AA.COMLTD = BB.COMLTD AND AA.ITNO = BB.ITNO AND
				BB.COMLTD = :g_s_company AND BB.XPLANT = :ls_plant AND
				BB.DIV = :ls_dvsn AND BB.ITNO = :ls_itno
		using sqlca;

	if sqlca.sqlcode <> 0 then
		ls_error = 'E07 : 품번상세정보 에러'
	else
		ls_pdcd = mid(ls_pdcd,1,2)
		
		SELECT PBINV.F_XCOST1(:ls_plant, :ls_dvsn, :ls_itno, :ls_closedate) INTO :lc_costav
		FROM PBCOMMON.COMM000
		using sqlca;
		
		lc_phohqt = lc_phohqt * lc_convqty
		lc_phohamt = lc_phohqt * lc_costav / lc_convqty
		
		select count(*) into :li_rtncode
		from pbwip.wip014
		where wbcmcd = :g_s_company and wbplant = :ls_plant and 
					wbdvsn = :ls_dvsn and wbitno = :ls_itno and
					wbyear = :ls_year and wbmonth = :ls_month and 
					wborct = :ls_orct and wbiocd = :ls_iocd
			using sqlca;
		if li_rtncode = 0 then
			lc_ohqt = 0
			
			insert into pbwip.wip014(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
					 wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
					 wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
					 wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
					 wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
					 wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
					 wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
					 wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
					 wbmacaddr,wbinptdt,wbupdtdt)
				select aa.comltd,aa.xplant,aa.div,:ls_orct,aa.itno,
					 :ls_year,:ls_month,bb.rvno,:ls_iocd,aa.cls,aa.srce,:ls_pdcd,
					 aa.xunit,bb.xtype,bb.itnm,bb.spec,0,0,:lc_costav,
					 0,0, 0,
					 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
					 0,0,0,0,0,' ',:g_s_ipaddr,:g_s_macaddr,:g_s_date,:g_s_date
				from pbinv.inv101 aa inner join pbinv.inv002 bb
					on aa.comltd = bb.comltd and aa.itno = bb.itno
				where aa.comltd = '01' and aa.xplant = :ls_plant and
					aa.div = :ls_dvsn and aa.itno = :ls_itno
				using sqlca;
				
				if sqlca.sqlcode <> 0 then
					messagebox("chk", sqlca.sqlerrtext)
					return -1
				end if
		else
			select wbitno, ( wbbgqt + wbinqt - (wbusqt1 + wbusqt2 + wbusqt3 + wbusqt4
					+ wbusqt5 + wbusqt6 + wbusqt7 + wbusqt8 )) into :ls_rtn, :lc_ohqt from pbwip.wip014
				where wbcmcd = :g_s_company and wbplant = :ls_plant and 
						wbdvsn = :ls_dvsn and wbitno = :ls_itno and
						wbyear = :ls_year and wbmonth = :ls_month and 
						wborct = :ls_orct and wbiocd = :ls_iocd
				using sqlca;
		end if
		
		SELECT COUNT(*) INTO :li_rtncode
		FROM "PBWIP"."WIP014"
			WHERE ( "PBWIP"."WIP014"."WBCMCD" = '01' ) AND  
				( "PBWIP"."WIP014"."WBPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP014"."WBDVSN" = :ls_dvsn ) AND  
				( "PBWIP"."WIP014"."WBORCT" = :ls_orct ) AND  
				( "PBWIP"."WIP014"."WBITNO" = :ls_itno ) AND
				( "PBWIP"."WIP014"."WBIOCD" = :ls_iocd ) AND
				( "PBWIP"."WIP014"."WBYEAR"||"PBWIP"."WIP014"."WBMONTH" = :ls_postdate )   
			using sqlca;
		
		if li_rtncode = 0 then
			insert into pbwip.wip014(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
				 wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
				 wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
				 wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
				 wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
				 wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
				 wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
				 wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
				 wbmacaddr,wbinptdt,wbupdtdt)
			select aa.comltd,aa.xplant,aa.div,:ls_orct,aa.itno,
				 :ls_nextyear,:ls_nextmonth,bb.rvno,:ls_iocd,aa.cls,aa.srce,:ls_pdcd,
				 aa.xunit,bb.xtype,bb.itnm,bb.spec,0,0,:lc_costav,
				 0,:lc_phohqt, :lc_phohamt,
				 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
				 0,0,0,0,0,' ',:g_s_ipaddr,:g_s_macaddr,:g_s_date,:g_s_date
			from pbinv.inv101 aa inner join pbinv.inv002 bb
				on aa.comltd = bb.comltd and aa.itno = bb.itno
			where aa.comltd = '01' and aa.xplant = :ls_plant and
				aa.div = :ls_dvsn and aa.itno = :ls_itno
			using sqlca;	
			
			if sqlca.sqlcode <> 0 then
					messagebox("chk2", sqlca.sqlerrtext)
					return -1
				end if
		end if
	end if
	
	if isnull(lc_phohqt)  or lc_phohqt < 0 then 
		ls_error = 'E10 : 실사수량 에러'
	end if
   
	if f_spacechk(ls_error) <> -1 then
		// 에러가 발생한 품번
		dw_1.RowsCopy(l_n_loopcnt, l_n_loopcnt, primary!,dw_2, (dw_2.rowcount() + 1), Primary!)
		dw_2.setitem(dw_2.rowcount(),"error_msg",ls_error)
	else
		// 실사수량 업데이트
		lc_diffqt = lc_ohqt - lc_phohqt
		
		//재공시리얼번호 가져오기
//		ls_srno = f_wip_get_serialno(g_s_company)
//		if ls_srno = '0' then
//			uo_status.st_message.text = "시리얼번호 생성시에 오류가 발생하였습니다."
//			return -1
//		end if
		
		lc_ohamt = lc_ohqt * lc_costav / lc_convqty
		lc_diffamt = lc_ohamt - lc_phohamt
		// 마감월 업데이트
		UPDATE "PBWIP"."WIP014"  
			SET "WBUSQTA" = :lc_diffqt,
				"WBUSATA" = :lc_diffamt
		WHERE ( "PBWIP"."WIP014"."WBCMCD" = '01' ) AND  
				( "PBWIP"."WIP014"."WBPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP014"."WBDVSN" = :ls_dvsn ) AND  
				( "PBWIP"."WIP014"."WBORCT" = :ls_orct ) AND  
				( "PBWIP"."WIP014"."WBITNO" = :ls_itno ) AND 
				( "PBWIP"."WIP014"."WBIOCD" = :ls_iocd ) AND
				( "PBWIP"."WIP014"."WBYEAR"||"PBWIP"."WIP014"."WBMONTH" = :ls_adjdate )   
		using sqlca;
		if sqlca.sqlcode <> 0 or sqlca.sqlnrows < 1 then
			uo_status.st_message.text = "111저장시에 오류가 발생하였습니다. : " + sqlca.sqlerrtext
			return 0
		end if
		// 이월 업데이트
		UPDATE "PBWIP"."WIP014"  
			SET "WBBGQT" = :lc_phohqt,
				"WBBGAT1" = :lc_phohamt
		WHERE ( "PBWIP"."WIP014"."WBCMCD" = '01' ) AND  
				( "PBWIP"."WIP014"."WBPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP014"."WBDVSN" = :ls_dvsn ) AND  
				( "PBWIP"."WIP014"."WBORCT" = :ls_orct ) AND  
				( "PBWIP"."WIP014"."WBITNO" = :ls_itno ) AND
				( "PBWIP"."WIP014"."WBIOCD" = :ls_iocd ) AND
				( "PBWIP"."WIP014"."WBYEAR"||"PBWIP"."WIP014"."WBMONTH" = :ls_postdate )   
		using sqlca;
		if sqlca.sqlcode <> 0 or sqlca.sqlnrows < 1 then
			uo_status.st_message.text = "222저장시에 오류가 발생하였습니다. : " + sqlca.sqlerrtext
			return 0
		end if
		// 밸런스 업데이트
//		UPDATE "PBWIP"."WIP001"  
//		  SET "WABGQT" = :lc_phohqt,
//				"WABGAT1" = :lc_phohamt,
//				"WAOHQT" = :lc_phohqt + WAINQT - ( WAUSQT1 + WAUSQT2 + WAUSQT3 + WAUSQT4 
//						+ WAUSQT5 + WAUSQT6 + WAUSQT7 + WAUSQT8 )  
//		WHERE ( "PBWIP"."WIP001"."WACMCD" = '01' ) AND  
//				( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
//				( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
//				( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
//				( "PBWIP"."WIP001"."WAIOCD" = :ls_iocd ) AND
//				( "PBWIP"."WIP001"."WAITNO" = :ls_itno )			
//		using sqlca;
//		if sqlca.sqlcode <> 0 or sqlca.sqlnrows < 1 then
//			uo_status.st_message.text = "저장시에 오류가 발생하였습니다."
//			return 0
//		end if
		// 히스토리 삭제
//		delete from pbwip.wip004
//		where wdcmcd = '01' adn wdslty = 'WR' and 
//		// 히스토리 생성
//		insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, 
//		wddesc, wdspec,    wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, 
//		wdprsrno, wdprsrno1, wdprsrno2, wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   
//		wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
//		values ('01', 'WR', :ls_srno, :ls_plant, :ls_dvsn, :ls_iocd, :ls_itno, '', 
//		:ls_itnm, 	'', :ls_xunit, :ls_cls, :ls_srce, '08',   :ls_pdcd, ' ',    'WR',      
//		' ',      ' ',       ' ',       ' ',    ' ',     :ls_orct, :ls_closedate, 0,      :lc_diffqt, 
//		:g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, '', ' ') 
//		using sqlca;
//		
//		if sqlca.sqlcode <> 0 then
//			uo_status.st_message.text = "저장시에 에러가 발생하였습니다. 시스템개발팀으로 연락바랍니다."
//			return -1
//		end if
	end if
	ls_error = ' '
	i_n_complete = l_n_loopcnt * 100 / l_n_totalcnt
	if mod(l_n_loopcnt,5) = 0 then
		uo_1.uf_set_position (i_n_complete)
		st_saeng.text = string(l_n_loopcnt,"###,### ")
	end if
loop

uo_1.uf_set_position (i_n_complete)
st_saeng.text = string(l_n_loopcnt,"###,### ")
uo_status.st_message.text = f_message("U010")		//저장이 되었습니다.

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(i_b_bretrieve, i_b_bcreate, i_b_dretrieve, i_b_dprint, i_b_dchar)
setpointer(Arrow!)
end event

event open;call super::open;dw_1.settransobject(sqlca)

//Icon 제어(대상조회, 자료생성, 상세조회, 화면인쇄, 특수문자)
wf_icon_onoff(false, true, false, false, false)
end event

type uo_status from w_origin_sheet06`uo_status within w_wip034b
end type

type gb_2 from groupbox within w_wip034b
integer x = 2185
integer y = 1020
integer width = 2011
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 8388608
long backcolor = 12632256
string text = "[처리상태]"
end type

type gb_1 from groupbox within w_wip034b
integer x = 2185
integer y = 820
integer width = 2011
integer height = 188
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
end type

type st_1 from statictext within w_wip034b
integer x = 91
integer y = 28
integer width = 3456
integer height = 92
integer textsize = -16
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "◎  EXCEL 자료 LOAD  ◎"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_a1 from statictext within w_wip034b
integer x = 101
integer y = 860
integer width = 1998
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "1.~'자료경로~'를 눌러 대상엑셀파일을 선택바랍니다."
boolean focusrectangle = false
end type

type st_a2 from statictext within w_wip034b
integer x = 101
integer y = 928
integer width = 2007
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "2. 대상건수에 이상이 없으면 ~'자료생성~'을 누르십시오."
boolean focusrectangle = false
end type

type st_3 from statictext within w_wip034b
integer x = 2354
integer y = 900
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "대상건수"
boolean focusrectangle = false
end type

type st_daesang from statictext within w_wip034b
integer x = 2679
integer y = 884
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_55 from statictext within w_wip034b
integer x = 3305
integer y = 900
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
string text = "생성건수"
boolean focusrectangle = false
end type

type st_saeng from statictext within w_wip034b
integer x = 3625
integer y = 884
integer width = 389
integer height = 92
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
boolean enabled = false
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_1 from uo_progress_bar within w_wip034b
event destroy ( )
integer x = 2450
integer y = 1080
boolean bringtotop = true
end type

on uo_1.destroy
call uo_progress_bar::destroy
end on

type dw_1 from datawindow within w_wip034b
event ue_validation pbm_dwnitemvalidationerror
integer x = 91
integer y = 156
integer width = 4123
integer height = 648
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_wip034b_upload"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event dberror;return 1
end event

event itemerror;return 1
end event

type cb_1 from commandbutton within w_wip034b
integer x = 224
integer y = 1076
integer width = 302
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "자료경로"
end type

event clicked;//string ls_pathname,ls_filename
//GetFileOpenName("Select File", ls_pathname, ls_filename, "txt","Text Files (*.txt),*.txt,")
//sle_1.text = ls_pathname


string	ls_docname, ls_named, ls_name
Long		ll_rtn
OLEObject lole_UploadObject

// UPLOAD할 엑셀파일을 선택한다
//
GetFileOpenName("Select File", + ls_docname, ls_named, "xls", &
				  + "Excle Files (*.xls),*.xls," + "All Files (*.*),*.*")

setpointer(hourglass!)
sle_1.text = ls_docname
// 선택한 엑셀파일을 텍스트 파일로 명을 바꾼다.(test.xls => test.txt)
//
ls_name = Mid(ls_docname, 1, Len(Trim(ls_docname)) -3) + 'txt'

// 선택한 엑셀파일명과 동일한 텍스트 파일명의 존재여부를 체크한다
//
IF FileExists(ls_name) = TRUE THEN
	MessageBox('확 인', '해당변환 파일이 존재합니다')
	RETURN
END IF

// 데이타위도우 초기화
//
dw_1.ReSet()

// 신규 오브젝트 생성
//
lole_UploadObject = CREATE OLEObject

// 엑셀 오브젝트를 연결한다
//
ll_rtn = lole_UploadObject.ConnectToNewObject("excel.application") 

IF ll_rtn = 0 THEN
	// 엑셀에서 선택된 엑셀파일을 오픈한다
	//
	lole_UploadObject.workbooks.Open(ls_docname)
	// 오픈된 엑셀파일을 텍스트 파일로 저장한다(3:text 형태의 저장)
	//
	lole_UploadObject.application.workbooks(1).saveas(ls_name, 3)
	// 오픈된 엑셀파일을 닫는다(저장유무를 확인하지 않는다Close(0))
	//
	lole_UploadObject.application.workbooks(1).close(0)
	// 엑셀 오브젝트의 연결을 해제한다
	//
	lole_UploadObject.DisConnectObject()   
ELSE
	// 엑셀 오브젝트의 연결을 해제한다
	//
	lole_UploadObject.DisConnectObject()   
	//Excel에 연결 실패!
	//
	MessageBox("ConnectToNewObject Error!",string(ll_rtn))
END IF

// 신규 오브젝트를 메모리에서 해제
//
DESTROY lole_UploadObject

// 텍스트 파일로 저장된 대상을 데이타윈도우에 임포트시킨다(타이틀을 제외한 2라인부터)
// 임포트가 완료되면 텍스트 파일을 삭제한다
//
ll_rtn = dw_1.ImportFile(ls_name, 2) 
IF ll_rtn > 0 THEN
	filedelete(ls_name)
ELSE
	// 임포트 ERROR
	//
	CHOOSE CASE ll_rtn
		CASE 0
			MessageBox("확 인", 'End of file; too many rows')
		CASE -1
			MessageBox("확 인", 'No rows')
		CASE -2
			MessageBox("확 인", 'Empty file')
		CASE -3
			MessageBox("확 인", 'Invalid argument')
		CASE -4
			MessageBox("확 인", 'Invalid input')
		CASE -5
			MessageBox("확 인", 'Could not open the file')
		CASE -6
			MessageBox("확 인", 'Could not close the file')
		CASE -7
			MessageBox("확 인", 'Error reading the text')
		CASE -8
			MessageBox("확 인", 'Not a TXT file')
	END CHOOSE
END IF

st_daesang.text = string(dw_1.rowcount())
end event

type sle_1 from singlelineedit within w_wip034b
integer x = 544
integer y = 1072
integer width = 1266
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_wip034b
integer x = 91
integer y = 1372
integer width = 4123
integer height = 1092
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_wip034b_upload"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_wip034b
integer x = 91
integer y = 1280
integer width = 791
integer height = 72
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12639424
string text = "에러가 발생한 품번"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type pb_down from picturebutton within w_wip034b
integer x = 1061
integer y = 1232
integer width = 155
integer height = 132
integer taborder = 30
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_2)
end event

