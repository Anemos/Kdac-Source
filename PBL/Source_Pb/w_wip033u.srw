$PBExportHeader$w_wip033u.srw
$PBExportComments$당월재공 유상사급품 수정
forward
global type w_wip033u from w_origin_sheet02
end type
type st_4 from statictext within w_wip033u
end type
type st_5 from statictext within w_wip033u
end type
type dw_report from datawindow within w_wip033u
end type
type dw_wip033u_01 from datawindow within w_wip033u
end type
type dw_wip033u_02 from datawindow within w_wip033u
end type
type dw_wip033u_03 from datawindow within w_wip033u
end type
type pb_down from picturebutton within w_wip033u
end type
type gb_1 from groupbox within w_wip033u
end type
end forward

global type w_wip033u from w_origin_sheet02
integer height = 2668
st_4 st_4
st_5 st_5
dw_report dw_report
dw_wip033u_01 dw_wip033u_01
dw_wip033u_02 dw_wip033u_02
dw_wip033u_03 dw_wip033u_03
pb_down pb_down
gb_1 gb_1
end type
global w_wip033u w_wip033u

type variables


end variables

forward prototypes
public function integer wf_modify_cross (datawindow arg_dw)
public function integer wf_selectcheck (string a_comltd, string a_plant, string a_dvsn, string a_code)
public function integer wf_set_wip004 (datastore arg_ds, datawindow arg_dw, decimal arg_convqty, integer a_currow)
public function integer wf_finddata_chk (integer a_tabindex, ref datawindow arg_dw)
public function integer wf_option_update (datawindow arg_dw)
public function integer wf_authority_chk ()
public function integer wf_option_datachk (datawindow arg_dw)
end prototypes

public function integer wf_modify_cross (datawindow arg_dw);integer li_cntx, li_rowcnt
string ls_errorcd, ls_cmcd, ls_srty, ls_srno, ls_srno1, ls_srno2, ls_plant, ls_dvsn, ls_xuse, ls_rtngubun
string ls_slno, ls_itno, ls_usge, ls_vsrno, ls_date, ls_date2
dec{4} lc_qty, lc_qty2
decimal{4} l_n_wdchqt,l_n_wbusqt1,l_n_wbusqt2,l_n_wbusqt3,l_n_wbusqt4,l_n_wbusqt5,l_n_wbusqt6,l_n_wbusqt7,&
			  l_n_wbusqt8,l_n_wbusqt9,l_n_wbusqta,l_n_wbohqt,l_n_chkqty
decimal{5} l_n_wbavrg1,l_n_wbavrg2,l_n_costav
decimal{0} l_n_wbusat1,l_n_wbusat2,l_n_wbusat3,l_n_wbusat4,l_n_wbusat5,l_n_wbusat6,l_n_wbusat7, &
           l_n_wbusat8,l_n_wbusat9,l_n_wbusata,l_n_wbohat1,l_n_wbohat2
string ls_wdslty, ls_wdsrno, ls_adjdate, ls_rundate
arg_dw.accepttext()
li_rowcnt = arg_dw.rowcount()

for li_cntx = 1 to li_rowcnt
	ls_errorcd = arg_dw.getitemstring(li_cntx,"errorcode")
	choose case ls_errorcd
		case '1'     //Child Not Found
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			ls_slno = arg_dw.getitemstring(li_cntx,"inv401_slno")
			ls_itno = arg_dw.getitemstring(li_cntx,"inv401_itno")
			ls_usge = arg_dw.getitemstring(li_cntx,"inv401_xuse")
			ls_rtngubun = arg_dw.getitemstring(li_cntx,"inv401_rtngub")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")
			lc_qty = arg_dw.getitemdecimal(li_cntx,"inv401_tqty4")
			if ls_srty = 'RP' then
				ls_vsrno = arg_dw.getitemstring(li_cntx,"inv401_vsrno")
				if f_wip_vendor_use_update02(' ', ls_cmcd, ls_srty, ls_srno, ls_srno1, ls_srno2, ls_plant, ls_dvsn , &
						ls_slno, ls_itno, ls_usge, ls_rtngubun, ls_vsrno, ls_date, lc_qty) = 'N' then
					return -1
				else
					
				end if
			else
				ls_vsrno = arg_dw.getitemstring(li_cntx,"inv401_dept")
				if f_wip_line_use_update02(' ', ls_cmcd, ls_srty, ls_srno, ls_srno1, ls_srno2, ls_plant, ls_dvsn , &
						ls_slno, ls_itno, ls_usge, ls_rtngubun, ls_vsrno, ls_date, lc_qty) = 'N' then
					return -1
				else

				end if
			end if		
		case '2'		 //Parent Not Found => 재공트랜스 레코드 삭제
			ls_rundate = mid(g_s_date,1,6)
			ls_adjdate = uf_wip_addmonth(ls_rundate,-1)
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")
			
			declare wip004_cur cursor for 
  				SELECT "PBWIP"."WIP004"."WDSLTY","PBWIP"."WIP004"."WDSRNO","PBWIP"."WIP004"."WDITNO",   
         			 "PBWIP"."WIP004"."WDCHDPT","PBWIP"."WIP004"."WDCHQT","PBWIP"."WIP004"."WDUSGE"  
    				FROM "PBWIP"."WIP004"  
					WHERE ( "PBWIP"."WIP004"."WDCMCD" = :ls_cmcd ) AND  
							( "PBWIP"."WIP004"."WDPLANT" = :ls_plant ) AND  
							( "PBWIP"."WIP004"."WDDVSN" = :ls_dvsn ) AND  
							( "PBWIP"."WIP004"."WDPRSRTY" = :ls_srty ) AND  
							( "PBWIP"."WIP004"."WDPRSRNO" = :ls_srno ) AND  
							( "PBWIP"."WIP004"."WDPRSRNO1" = :ls_srno1 ) AND  
							( "PBWIP"."WIP004"."WDPRSRNO2" = :ls_srno2 ) AND
							( "PBWIP"."WIP004"."WDDATE" = :ls_date )
							using sqlca;
			open wip004_cur ;
  				do while true
					fetch wip004_cur into :ls_wdslty,:ls_wdsrno,:ls_itno,:ls_vsrno,:lc_qty,:ls_usge;
					if sqlca.sqlcode <> 0 then			  
						exit
					end if
					//사용수량 제거(WIP002)
					SELECT WBAVRG1,WBAVRG2,WBUSQT1,WBUSAT1,WBUSQT2,WBUSAT2,WBUSQT3,WBUSAT3,WBUSQT4,WBUSAT4,WBUSQT5,WBUSAT5,
       					 WBUSQT6,WBUSAT6,WBUSQT7,WBUSAT7,WBUSQT8,WBUSAT8,WBUSAT9,WBUSQTA,WBUSATA INTO
							:l_n_wbavrg1,:l_n_wbavrg2,:l_n_wbusqt1,:l_n_wbusat1,:l_n_wbusqt2,:l_n_wbusat2,:l_n_wbusqt3,
							:l_n_wbusat3,:l_n_wbusqt4,:l_n_wbusat4,:l_n_wbusqt5,:l_n_wbusat5,:l_n_wbusqt6,:l_n_wbusat6,
							:l_n_wbusqt7,:l_n_wbusat7,:l_n_wbusqt8,:l_n_wbusat8,:l_n_wbusat9,:l_n_wbusqta,:l_n_wbusata 
						FROM "PBWIP"."WIP002" 
						WHERE WBCMCD = :G_S_COMPANY AND WBPLANT = :ls_plant AND WBDVSN = :ls_dvsn AND 
								WBORCT = :ls_vsrno AND WBITNO = :ls_itno AND WBYEAR||WBMONTH = :ls_adjdate
								USING SQLCA;
					//현재공 가져오기
					SELECT WBBGQT, WBBGAT1 INTO :l_n_wbohqt, :l_n_wbohat1
						FROM "PBWIP"."WIP002" 
						WHERE WBCMCD = :G_S_COMPANY AND WBPLANT = :ls_plant AND WBDVSN = :ls_dvsn AND 
								WBORCT = :ls_vsrno AND WBITNO = :ls_itno AND WBYEAR||WBMONTH = :ls_rundate
								USING SQLCA;
					choose case ls_usge
						case '01'
							l_n_wbusqt1 = l_n_wbusqt1 - lc_qty
							l_n_wbusat1 = l_n_wbusat1 - ( lc_qty * l_n_wbavrg1 )
						case '02'
							l_n_wbusqt2 = l_n_wbusqt2 - lc_qty
							l_n_wbusat2 = l_n_wbusat2 - ( lc_qty * l_n_wbavrg1 )
						case '03'
							l_n_wbusqt3 = l_n_wbusqt3 - lc_qty
							l_n_wbusat3 = l_n_wbusat3 - ( lc_qty * l_n_wbavrg1 )
						case '04'
							l_n_wbusqt4 = l_n_wbusqt4 - lc_qty
							l_n_wbusat4 = l_n_wbusat4 - ( lc_qty * l_n_wbavrg1 )
						case '05'
							l_n_wbusqt5 = l_n_wbusqt5 - lc_qty
							l_n_wbusat5 = l_n_wbusat5 - ( lc_qty * l_n_wbavrg1 )
						case '06'
							l_n_wbusqt6 = l_n_wbusqt6 - lc_qty
							l_n_wbusat6 = l_n_wbusat6 - ( lc_qty * l_n_wbavrg1 )
						case '07'
							l_n_wbusqt7 = l_n_wbusqt7 - lc_qty
							l_n_wbusat7 = l_n_wbusat7 - ( lc_qty * l_n_wbavrg1 )
					end choose
					l_n_wbohqt = l_n_wbohqt - lc_qty
					l_n_wbohat1 = l_n_wbohat1 - ( lc_qty * l_n_wbavrg1 )
					//마감월 UPDATE
					update "PBWIP"."WIP002"
						set WBUSQT1 = :l_n_wbusqt1,WBUSAT1 = :l_n_wbusat1,WBUSQT2 = :l_n_wbusqt2,WBUSAT2 = :l_n_wbusat2,
							WBUSQT3 = :l_n_wbusqt3,WBUSAT3 = :l_n_wbusat3,WBUSQT4 = :l_n_wbusqt4,WBUSAT4 = :l_n_wbusat4,
							WBUSQT5 = :l_n_wbusqt5,WBUSAT5 = :l_n_wbusat5,WBUSQT6 = :l_n_wbusqt6,WBUSAT6 = :l_n_wbusat6,
							WBUSQT7 = :l_n_wbusqt7,WBUSAT7 = :l_n_wbusat7,WBUSQT8 = :l_n_wbusqt8,WBUSAT8 = :l_n_wbusat8,
							WBUSAT9 = :l_n_wbusat9,WBUSQTA = :l_n_wbusqta,WBUSATA = :l_n_wbusata
						where WBCMCD = :G_S_COMPANY AND WBPLANT = :ls_plant AND WBDVSN = :ls_dvsn AND 
								WBORCT = :ls_vsrno AND WBITNO = :ls_itno AND WBYEAR||WBMONTH = :ls_adjdate
								using sqlca;
					
					//현재공 UPDATE
					update "PBWIP"."WIP002"
						set WBBGQT = :l_n_wbohqt,WBBGAT1 = :l_n_wbohat1
						where WBCMCD = :G_S_COMPANY AND WBPLANT = :ls_plant AND WBDVSN = :ls_dvsn AND 
								WBORCT = :ls_vsrno AND WBITNO = :ls_itno AND WBYEAR||WBMONTH = :ls_rundate
								using sqlca;
					if sqlca.sqlcode <> 0 then
						return -1
					end if
					//WIP004 DELETE
					DELETE FROM "PBWIP"."WIP004"  
						WHERE ( "PBWIP"."WIP004"."WDCMCD" = :ls_cmcd ) AND  
								( "PBWIP"."WIP004"."WDSLTY" = :ls_wdslty ) AND  
								( "PBWIP"."WIP004"."WDSRNO" = :ls_wdsrno )   
								using sqlca;
					if sqlca.sqlcode <> 0 then
						return -1
					end if
			  loop
			close wip004_cur ;
		case '3'		 //QTY,Date Error
			ls_cmcd = arg_dw.getitemstring(li_cntx,"inv401_comltd")
			ls_srty = arg_dw.getitemstring(li_cntx,"inv401_sliptype")
			ls_srno = arg_dw.getitemstring(li_cntx,"inv401_srno")
			ls_srno1 = arg_dw.getitemstring(li_cntx,"inv401_srno1")
			ls_srno2 = arg_dw.getitemstring(li_cntx,"inv401_srno2")
			ls_plant = arg_dw.getitemstring(li_cntx,"inv401_xplant")
			ls_dvsn = arg_dw.getitemstring(li_cntx,"inv401_div")
			ls_slno = arg_dw.getitemstring(li_cntx,"inv401_slno")
			ls_itno = arg_dw.getitemstring(li_cntx,"inv401_itno")
			ls_usge = arg_dw.getitemstring(li_cntx,"inv401_xuse")
			ls_rtngubun = arg_dw.getitemstring(li_cntx,"inv401_rtngub")
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")	//변경전 날짜
			ls_date2 = arg_dw.getitemstring(li_cntx,"chgdate")     
			lc_qty = arg_dw.getitemdecimal(li_cntx,"inv401_tqty4")	//변경전 수량
			lc_qty2 = arg_dw.getitemdecimal(li_cntx,"chgqty")     
			
			if f_wip_use_replace02(ls_cmcd, ls_srty, ls_srno, ls_srno1, ls_srno2, ls_plant, ls_dvsn , &
					ls_slno, ls_itno, ls_usge, ls_rtngubun, ls_vsrno, ls_date, ls_date2, lc_qty, lc_qty2, ls_date2) = 'N' then

				return -1
			else
	
			end if		
	end choose
next

return 0
end function

public function integer wf_selectcheck (string a_comltd, string a_plant, string a_dvsn, string a_code);//이월전이거나 수정완료인 경우에는 사용량 수정이 불가능
string ls_cttp, ls_date, ls_stscd

ls_cttp = "WIP"+ a_dvsn + a_code 

  SELECT "PBWIP"."WIP090"."WZEDDT",   
         "PBWIP"."WIP090"."WZSTSCD"  
    INTO :ls_date,      
         :ls_stscd  
    FROM "PBWIP"."WIP090"  
   WHERE ( "PBWIP"."WIP090"."WZCMCD" = :a_comltd ) AND  
         ( "PBWIP"."WIP090"."WZPLANT" = :a_plant ) AND  
         ( "PBWIP"."WIP090"."WZCTTP" = :ls_cttp )   using sqlca;

if sqlca.sqlcode <> 0 then
   return -1
end if

if ls_stscd = "C" then
	return -1
else
	return 0
end if
    
end function

public function integer wf_set_wip004 (datastore arg_ds, datawindow arg_dw, decimal arg_convqty, integer a_currow);integer li_currow
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
lc_diffqty = (arg_dw.getitemdecimal(a_currow,"repqt") - arg_dw.getitemdecimal(a_currow,"chqt")) * arg_convqty
//마감월 말일 날짜 가져오기
ls_adjdate = f_relativedate(uf_wip_addmonth(st_5.text,1) + '01', -1)

li_currow = arg_ds.insertrow(0)
arg_ds.setitem(li_currow,"wdcmcd", g_s_company)
arg_ds.setitem(li_currow,"wdslty", 'WR')
arg_ds.setitem(li_currow,"wdsrno", ls_serial)
arg_ds.setitem(li_currow,"wdplant", arg_dw.getitemstring(a_currow,"wip002_wbplant"))
arg_ds.setitem(li_currow,"wddvsn", arg_dw.getitemstring(a_currow,"wdbdvsn"))
arg_ds.setitem(li_currow,"wdiocd", arg_dw.getitemstring(a_currow,"wbiocd"))
arg_ds.setitem(li_currow,"wditno", arg_dw.getitemstring(a_currow,"wbitno"))
arg_ds.setitem(li_currow,"wdrvno", arg_dw.getitemstring(a_currow,"wdrvno"))
arg_ds.setitem(li_currow,"wddesc", arg_dw.getitemstring(a_currow,"wbdesc"))
arg_ds.setitem(li_currow,"wdspec", arg_dw.getitemstring(a_currow,"wbspec"))
arg_ds.setitem(li_currow,"wdunit", arg_dw.getitemstring(a_currow,"wbunit"))
arg_ds.setitem(li_currow,"wditcl", arg_dw.getitemstring(a_currow,"wbitcl"))
arg_ds.setitem(li_currow,"wdsrce", arg_dw.getitemstring(a_currow,"wbsrce"))
arg_ds.setitem(li_currow,"wdusge", '08')
arg_ds.setitem(li_currow,"wdpdcd", arg_dw.getitemstring(a_currow,"wbpdcd"))
arg_ds.setitem(li_currow,"wdslno", ' ')
arg_ds.setitem(li_currow,"wdprsrty", 'WR')
arg_ds.setitem(li_currow,"wdprsrno", ' ')
arg_ds.setitem(li_currow,"wdprsrno1", ' ')
arg_ds.setitem(li_currow,"wdprsrno2", ' ')
arg_ds.setitem(li_currow,"wdprno", arg_dw.getitemstring(a_currow,"wdprno"))
arg_ds.setitem(li_currow,"wdprdpt", arg_dw.getitemstring(a_currow,"wdprdpt"))
arg_ds.setitem(li_currow,"wdchdpt", arg_dw.getitemstring(a_currow,"wdchdpt"))
arg_ds.setitem(li_currow,"wddate", ls_adjdate)
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

public function integer wf_finddata_chk (integer a_tabindex, ref datawindow arg_dw);string ls_plant, ls_dvsn, ls_vndr, ls_iocd, ls_rtnvalue, ls_orct
string ls_cttp, ls_date, ls_stscd

arg_dw.accepttext()
Choose case a_tabindex
	case 1
		//선택입력 - 사업자등록번호가 입력된 경우
		ls_plant = arg_dw.getitemstring(1,"wip001_waplant")
		ls_dvsn = arg_dw.getitemstring(1,"wip001_wadvsn")
		ls_vndr = arg_dw.getitemstring(1,"vndr")
		ls_iocd = arg_dw.getitemstring(1,"wip001_waiocd")
		ls_orct = arg_dw.getitemstring(1,"wip001_waorct")
		if ls_iocd = '2' and f_spacechk(ls_vndr) <> -1 then
			if f_spacechk(ls_orct) = -1 then
				ls_rtnvalue = f_get_vendor01(g_s_company, ls_vndr)
				if ls_rtnvalue <> '' then		//사업자번호가 입력된경우
					arg_dw.setitem(1,"vndnm",mid(ls_rtnvalue,6))
					arg_dw.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
				else
					uo_status.st_message.text = "사업자번호에 해당하는 업체가 없습니다."
					return -1
				end if
			end if
		end if
		
		//이월전이거나 수정완료인 경우에는 사용량 수정이 불가능
		ls_cttp = "WIP"+ ls_dvsn 

		  SELECT "PBWIP"."WIP090"."WZEDDT",   
					"PBWIP"."WIP090"."WZSTSCD"  
			 INTO :ls_date,      
					:ls_stscd  
			 FROM "PBWIP"."WIP090"  
			WHERE ( "PBWIP"."WIP090"."WZCMCD" = :g_s_company ) AND  
					( "PBWIP"."WIP090"."WZPLANT" = :ls_plant ) AND  
					( "PBWIP"."WIP090"."WZCTTP" = :ls_cttp )   using sqlca;

		if sqlca.sqlcode <> 0 then
   		return -1
		end if

		st_5.text = ls_date 

		if ls_stscd <> "2" then
			uo_status.st_message.text = "결산이 완료되었습니다."
			return -1
		end if
	case 2
		
	case 3
		
End choose

return 0
end function

public function integer wf_option_update (datawindow arg_dw);string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_adjdate, ls_ohdate, ls_usage
integer li_cntx, li_rowcnt
dec{4} lc_qty
dec{4} lc_convqty
dec{2} lc_costav

arg_dw.accepttext()
li_rowcnt = arg_dw.rowcount()

ls_adjdate = st_5.text
ls_ohdate = uf_wip_addmonth(ls_adjdate,1)
for li_cntx = 1 to li_rowcnt
	lc_convqty = arg_dw.getitemdecimal(li_cntx,"convqty")
	ls_plant = arg_dw.getitemstring(li_cntx, "wdplant")
	ls_dvsn = arg_dw.getitemstring(li_cntx, "wddvsn")
	ls_itno = arg_dw.getitemstring(li_cntx, "wditno")
	ls_orct = arg_dw.getitemstring(li_cntx, "wdchdpt")
	ls_usage = arg_dw.getitemstring(li_cntx, "wdusge")
	lc_qty = arg_dw.getitemdecimal(li_cntx,"repqt") * lc_convqty
	
	select costav into :lc_costav from pbinv.inv101
		where comltd = :g_s_company and xplant = :ls_plant and div = :ls_dvsn and itno = :ls_itno 
				using sqlca;
	lc_costav = lc_costav / lc_convqty
	choose case ls_usage
		case '01'
			UPDATE "PBWIP"."WIP002"  
     			SET "WBUSQT1" = "WBUSQT1" + :lc_qty,
				    "WBUSAT1" = ("WBUSQT1" + :lc_qty) * :lc_costav
   			WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
         			( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
           			using sqlca;

		case '02'
			UPDATE "PBWIP"."WIP002"  
     			SET "WBUSQT2" = "WBUSQT2" + :lc_qty,
				    "WBUSAT2" = ("WBUSQT2" + :lc_qty) * :lc_costav  
   			WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
         			( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
           			using sqlca;
		case '03'
			UPDATE "PBWIP"."WIP002"  
     			SET "WBUSQT3" = "WBUSQT3" + :lc_qty,
				    "WBUSAT3" = ("WBUSQT3" + :lc_qty) * :lc_costav  
   			WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
         			( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
           			using sqlca;
		case '05'
			UPDATE "PBWIP"."WIP002"  
     			SET "WBUSQT5" = "WBUSQT5" + :lc_qty,
				    "WBUSAT5" = ("WBUSQT5" + :lc_qty) * :lc_costav 
   			WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
         			( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
           			using sqlca;
		case '06'
			UPDATE "PBWIP"."WIP002"  
     			SET "WBUSQT6" = "WBUSQT6" + :lc_qty,
				    "WBUSAT6" = ("WBUSQT6" + :lc_qty) * :lc_costav  
   			WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         			( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         			( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         			( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         			( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
         			( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
           			using sqlca;
	end choose
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return -1
	end if	
	//기말 재공 UPDATE
	UPDATE "PBWIP"."WIP002"  
		SET "WBBGQT" = "WBBGQT" - :lc_qty,
			 "WBBGAT1" = ("WBBGQT" - :lc_qty) * :lc_costav  
		WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
				( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
				( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
				( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
				( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_ohdate )   
				using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return -1
	end if
next
return 0
end function

public function integer wf_authority_chk ();//string ls_cttp, ls_plant, ls_dvsn, ls_rundate, ls_stscd
//
//ls_plant = dw_wip032u_01.getitemstring(1,"wip001_waplant")
//ls_dvsn = dw_wip032u_01.getitemstring(1,"wip001_wadvsn")
//ls_cttp = 'WIP' + ls_dvsn + '050'
//
//
//  SELECT "PBWIP"."WIP090"."WZDATE",     
//         "PBWIP"."WIP090"."WZSTSCD"  
//    INTO :ls_rundate,      
//         :ls_stscd  
//    	FROM "PBWIP"."WIP090"  
//   	WHERE ( "PBWIP"."WIP090"."WZCMCD" = :g_s_company ) AND  
//         	( "PBWIP"."WIP090"."WZPLANT" = :ls_plant ) AND  
//         	( "PBWIP"."WIP090"."WZCTTP" = :ls_cttp )   
//				using sqlca;
//if sqlca.sqlcode <> 0 then
//	uo_status.st_message.text = f_message("I100")
//	return -1
//end if
//
//if (mid(g_s_date,1,6) = mid(ls_rundate,1,6)) and ls_stscd = '2' then
	return 0
//else
//	uo_status.st_message.text = "사용량수정이 완료된 상태입니다."
//	return -1
//end if
end function

public function integer wf_option_datachk (datawindow arg_dw);string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_adjdate, ls_err_column, ls_prno, ls_chksrce
string ls_cls, ls_srce, ls_pdcd, ls_xunit,ls_itnm, ls_spec, ls_rvno, ls_iocd, ls_preitno
integer li_rowcnt, li_cntx, li_cnt
dec{0} lc_lolev01, lc_lolev02
dec{2} lc_qty, lc_preqty
dec{4} lc_convqty

li_rowcnt = arg_dw.rowcount()
ls_adjdate = st_5.text
for li_cntx = 1 to li_rowcnt
	ls_plant = arg_dw.getitemstring(li_cntx,"wdplant")
	ls_dvsn = arg_dw.getitemstring(li_cntx,"wddvsn")
	ls_orct = arg_dw.getitemstring(li_cntx,"wdchdpt")
	ls_itno = arg_dw.getitemstring(li_cntx,"wditno")
	ls_prno = arg_dw.getitemstring(li_cntx,"wdprno")
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
         "PBINV"."INV002"."RVNO",
			"PBINV"."INV002"."LOLEVEL" 
    INTO :ls_cls,   
         :ls_srce,   
         :ls_pdcd,
			:lc_convqty,
         :ls_xunit,   
         :ls_itnm,   
         :ls_spec,   
         :ls_rvno,
			:lc_lolev01
    FROM "PBINV"."INV002",   
         "PBINV"."INV101"  
   WHERE ( "PBINV"."INV002"."COMLTD" = "PBINV"."INV101"."COMLTD" ) and  
         ( "PBINV"."INV002"."ITNO" = "PBINV"."INV101"."ITNO" ) and  
         ( ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
         ( "PBINV"."INV101"."XPLANT" = :ls_plant ) AND  
         ( "PBINV"."INV101"."DIV" = :ls_dvsn ) AND  
         ( "PBINV"."INV101"."ITNO" = :ls_itno ) )   using sqlca;
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = ls_itno + " : 등록된 품번이 아닙니다"
		return -1
	end if		
	
	//모품번 검사
	SELECT "PBINV"."INV101"."SRCE",
			"PBINV"."INV002"."LOLEVEL" 
    INTO :ls_chksrce,
			:lc_lolev02
    FROM "PBINV"."INV002",   
         "PBINV"."INV101"  
   WHERE ( "PBINV"."INV002"."COMLTD" = "PBINV"."INV101"."COMLTD" ) and  
         ( "PBINV"."INV002"."ITNO" = "PBINV"."INV101"."ITNO" ) and  
         ( ( "PBINV"."INV101"."COMLTD" = :g_s_company ) AND  
         ( "PBINV"."INV101"."XPLANT" = :ls_plant ) AND  
         ( "PBINV"."INV101"."DIV" = :ls_dvsn ) AND  
         ( "PBINV"."INV101"."ITNO" = :ls_prno ) )   using sqlca;
	//LowLevel Check
	if lc_lolev01 <= lc_lolev02 then
		uo_status.st_message.text = ls_itno + " 품번의  BOM level이 모품번보다 상위에 있습니다."
		return -1
	end if
	//구입선 Check
	if ls_chksrce = '01' or ls_chksrce = '02' then
		uo_status.st_message.text = ls_itno + " 품번은 원소재로 모품번이 될수 없습니다."
		return -1
	end if
	
	
	//재공품에 해당하는 계정과 구입선 확인하기
   if ls_iocd = '1' then
		if (ls_cls  = "10" or ls_cls  = "40" or ls_cls  = "50") and &
		   (ls_srce = "01" or ls_srce = "02" or ls_srce = "04" or ls_srce = "05" or ls_srce = "06") then
			//PASS
		else
			uo_status.st_message.text = ls_itno + " : 재공품이 아닙니다."
			return -1
		end if
	else
		if (ls_cls = "10" or ls_cls = "20" or ls_cls = "40" or ls_cls = "50") then 
			//PASS
		else
			uo_status.st_message.text = ls_itno + " : 재공품이 아닙니다"
			return -1 
		end if
	end if
	//재공이월 DB에 존재유무
	 SELECT count(*)  
    INTO :li_cnt  
    FROM "PBWIP"."WIP002"  
   WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         ( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         ( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
         ( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )  using sqlca;

	if sqlca.sqlcode <> 0 or li_cnt < 1 then
		uo_status.st_message.text = ls_itno + " : 재공에 등록된 품번이 아닙니다."
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

on w_wip033u.create
int iCurrent
call super::create
this.st_4=create st_4
this.st_5=create st_5
this.dw_report=create dw_report
this.dw_wip033u_01=create dw_wip033u_01
this.dw_wip033u_02=create dw_wip033u_02
this.dw_wip033u_03=create dw_wip033u_03
this.pb_down=create pb_down
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_4
this.Control[iCurrent+2]=this.st_5
this.Control[iCurrent+3]=this.dw_report
this.Control[iCurrent+4]=this.dw_wip033u_01
this.Control[iCurrent+5]=this.dw_wip033u_02
this.Control[iCurrent+6]=this.dw_wip033u_03
this.Control[iCurrent+7]=this.pb_down
this.Control[iCurrent+8]=this.gb_1
end on

on w_wip033u.destroy
call super::destroy
destroy(this.st_4)
destroy(this.st_5)
destroy(this.dw_report)
destroy(this.dw_wip033u_01)
destroy(this.dw_wip033u_02)
destroy(this.dw_wip033u_03)
destroy(this.pb_down)
destroy(this.gb_1)
end on

event open;call super::open;datawindow ldw_01, ldw_02, ldw_03, ldw_04, ldw_05, ldw_06
datawindowchild dwc_01, dwc_02, dwc_03, dwc_04, dwc_05

st_5.text = mid(g_s_date,1,6)


dw_wip033u_01.settransobject(sqlca)
dw_wip033u_02.settransobject(sqlca)
dw_wip033u_03.settransobject(sqlca)

dw_wip033u_01.getchild("wip001_waplant",dwc_01)
	dwc_01.settransobject(sqlca)
	dwc_01.retrieve('SLE220')
dw_wip033u_01.getchild("wip001_wadvsn",dwc_02)
	dwc_02.settransobject(sqlca)
	dwc_02.retrieve('D')
dw_wip033u_01.getchild("inv101_pdcd",dwc_05)
	dwc_05.settransobject(sqlca)
	dwc_05.retrieve('A')	

dw_wip033u_01.insertrow(0)
dw_wip033u_01.setitem(1,"inv101_srce",'01')

//dw_report.dataobject = "d_wip022u_vndreport"
//dw_report.settransobject(sqlca)
// 조회, 입력, 저장, 삭제, 인쇄, 처음, 이정, 다음, 끝, 닫기, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, false, false, false, false, false, false, false, false, false, false, false)
end event

event ue_retrieve;string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_iocd, ls_adjdate, ls_rtnvalue, ls_pdcd, ls_srce
integer li_rowcnt, li_rtncode
dec{4} lc_convqty

uo_status.st_message.text = ""
	
//필수입력 체크
dw_wip033u_01.accepttext()
dw_wip033u_02.reset()
dw_wip033u_03.reset()
if f_wip_mandantory_chk(dw_wip033u_01) = -1 then							
	uo_status.st_message.text = f_message("E010")
	return 0
end if

//날짜 가져오기
ls_adjdate = st_5.text

//조회용데이타 가져오기
ls_plant = dw_wip033u_01.getitemstring(1,"wip001_waplant")
ls_dvsn  = dw_wip033u_01.getitemstring(1, "wip001_wadvsn")
ls_iocd = '3'
ls_orct = dw_wip033u_01.getitemstring(1,"wip001_waorct")
ls_pdcd = trim(dw_wip033u_01.getitemstring(1,"inv101_pdcd"))
ls_srce = trim(dw_wip033u_01.getitemstring(1,"inv101_srce"))
if f_spacechk(ls_pdcd) = -1 then
	ls_pdcd = '%'
else
	ls_pdcd = ls_pdcd + '%'
end if

if f_spacechk(ls_orct) = -1 then
	li_rowcnt = dw_wip033u_02.retrieve(g_s_company, ls_plant, ls_dvsn,ls_pdcd, ls_iocd, '%', ls_srce)  //전업체
else
	
	ls_rtnvalue = f_get_vendor01(g_s_company, dw_wip033u_01.getitemstring(1,"vndr"))
	if f_spacechk(ls_rtnvalue) = -1 then		//사업자번호가 입력된경우
		uo_status.st_message.text = "사업자번호에 해당하는 업체가 없습니다."
		return 0
	end if
	li_rowcnt = dw_wip033u_02.retrieve(g_s_company, ls_plant, ls_dvsn,ls_pdcd, ls_iocd, ls_orct + '%', ls_srce)  //해당업체
end if

if li_rowcnt > 0 then
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
end if

//수정가능확인
//if wf_authority_chk() = -1 then
//	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 이정, 다음, 끝, 닫기, 상세조회, 화면인쇄, 특수문자
//	wf_icon_onoff(true, false, false, false, true, false, false, false, false, false, false, false)
//else
//	// 조회, 입력, 저장, 삭제, 인쇄, 처음, 이정, 다음, 끝, 닫기, 상세조회, 화면인쇄, 특수문자
//	wf_icon_onoff(true, false, true, false, true, false, false, false, false, false, false, false)	
//end if

return 0				
    
end event

event ue_save;//string ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd
//string ls_itnm, ls_cls, ls_srce, ls_pdcd, ls_xunit, ls_srno
//string ls_adjdate, ls_postdate, ls_closedate
//integer li_rowcnt, li_cnt, li_rtncode
//dec{4} lc_ohqt, lc_phohqt, lc_diffqt
//dec{0} lc_ohamt, lc_phohamt, lc_diffamt
//dec{4} lc_convqty
//dec{5} lc_costav
//datastore lds_01
//
//lds_01 = create datastore
//lds_01.dataobject = "d_wip_option_wip004"
//lds_01.settransobject(sqlca)
//
//setpointer(hourglass!)
//uo_status.st_message.text = ""
//lds_01.reset()
//
//dw_wip033u_02.accepttext()
//ls_adjdate = st_5.text
//ls_postdate = uf_wip_addmonth(st_5.text,1)
//ls_closedate = f_relativedate(uf_wip_addmonth(st_5.text,1) + '01', -1)
//li_rowcnt = dw_wip033u_02.rowcount()
//for li_cnt = 1 to li_rowcnt
//	ls_plant = dw_wip033u_02.getitemstring(li_cnt,"wip002_wbplant")
//	ls_dvsn = dw_wip033u_02.getitemstring(li_cnt,"wip002_wbdvsn")
//	ls_orct = dw_wip033u_02.getitemstring(li_cnt,"wip002_wborct")
//	ls_itno = dw_wip033u_02.getitemstring(li_cnt,"wip002_wbitno")
//	ls_iocd = dw_wip033u_02.getitemstring(li_cnt,"wip002_wbiocd")
//	ls_itnm = dw_wip033u_02.getitemstring(li_cnt,"inv002_itnm")
//	ls_cls = dw_wip033u_02.getitemstring(li_cnt,"inv101_cls")
//	ls_srce = dw_wip033u_02.getitemstring(li_cnt,"inv101_srce")
//	ls_pdcd = mid(dw_wip033u_02.getitemstring(li_cnt,"inv101_pdcd"),1,2)
//	ls_xunit = dw_wip033u_02.getitemstring(li_cnt,"inv101_xunit")
//	lc_convqty = dw_wip033u_02.getitemnumber(li_cnt,"inv101_convqty")
//	lc_ohqt = dw_wip033u_02.getitemnumber(li_cnt,"ohqt")
//	lc_phohqt = dw_wip033u_02.getitemnumber(li_cnt,"phohqt")
//	if lc_ohqt = lc_phohqt then
//		continue
//	end if
//	if lc_convqty <> 1 then
//		SELECT "PBWIP"."WIP002"."WBBGQT" INTO :lc_ohqt
//		FROM "PBWIP"."WIP002"  
//		WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
//         ( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
//         ( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
//         ( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
//         ( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND
//			( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
//         ( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_postdate )   
//   	using sqlca;
//	else
//		lc_ohqt = dw_wip033u_02.getitemnumber(li_cnt,"ohqt")
//	end if
//	lc_phohqt = dw_wip033u_02.getitemnumber(li_cnt,"phohqt") * lc_convqty
//	lc_diffqt = lc_ohqt - lc_phohqt
//	
//	//재공시리얼번호 가져오기
//	ls_srno = f_wip_get_serialno(g_s_company)
//	if ls_srno = '0' then
//		return -1
//	end if
//	
//	//lc_convqty = dw_wip033u_02.getitemdecimal(li_cnt,"inv101_convqty")
//	lc_costav = dw_wip033u_02.getitemdecimal(li_cnt,"wip002_wbavrg1")
//	lc_costav = lc_costav / lc_convqty
//	lc_ohamt = lc_ohqt * lc_costav
//	lc_phohamt = lc_phohqt * lc_costav
//	lc_diffamt = lc_ohamt - lc_phohamt
//	// 마감월 업데이트
//	UPDATE "PBWIP"."WIP002"  
//   	SET "WBUSQT8" = "WBUSQT8" + :lc_diffqt,
//			"WBUSAT8" = "WBUSAT8" + :lc_diffamt
//   WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
//         ( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
//         ( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
//         ( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
//         ( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND 
//			( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
//         ( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
//   using sqlca;
//	if sqlca.sqlcode <> 0 or sqlca.sqlnrows < 1 then
//		uo_status.st_message.text = "저장시에 오류가 발생하였습니다."
//		return 0
//	end if
//	// 이월 업데이트
//	UPDATE "PBWIP"."WIP002"  
//   	SET "WBBGQT" = :lc_phohqt,
//			"WBBGAT1" = :lc_phohamt
//   WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
//         ( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
//         ( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
//         ( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
//         ( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND
//			( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
//         ( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_postdate )   
//   using sqlca;
//	if sqlca.sqlcode <> 0 or sqlca.sqlnrows < 1 then
//		uo_status.st_message.text = "저장시에 오류가 발생하였습니다."
//		return 0
//	end if
//	// 밸런스 업데이트
//	UPDATE "PBWIP"."WIP001"  
//     SET "WABGQT" = :lc_phohqt,
//	  		"WABGAT1" = :lc_phohamt,
//         "WAOHQT" = :lc_phohqt + WAINQT - ( WAUSQT1 + WAUSQT2 + WAUSQT3 + WAUSQT4 
//					+ WAUSQT5 + WAUSQT6 + WAUSQT7 + WAUSQT8 )  
//	WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
//         ( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
//         ( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
//         ( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
//			( "PBWIP"."WIP001"."WAIOCD" = :ls_iocd ) AND
//         ( "PBWIP"."WIP001"."WAITNO" = :ls_itno )			
//	using sqlca;
//	if sqlca.sqlcode <> 0 or sqlca.sqlnrows < 1 then
//		uo_status.st_message.text = "저장시에 오류가 발생하였습니다."
//		return 0
//	end if
//	// 히스토리 생성
//	insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, 
//	wddesc, wdspec,    wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, 
//	wdprsrno, wdprsrno1, wdprsrno2, wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   
//	wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
//	values (:g_s_company, 'WR', :ls_srno, :ls_plant, :ls_dvsn, :ls_iocd, :ls_itno, '', 
//	:ls_itnm, 	'', :ls_xunit, :ls_cls, :ls_srce, '08',   :ls_pdcd, ' ',    'WR',      
//	' ',      ' ',       ' ',       ' ',    ' ',     :ls_orct, :ls_closedate, 0,      :lc_diffqt, 
//	:g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, '', ' ') 
//	using sqlca;
//	
//	if sqlca.sqlcode <> 0 then
//		uo_status.st_message.text = "저장시에 에러가 발생하였습니다. 시스템개발팀으로 연락바랍니다."
//		return -1
//	end if
//next
//
//window l_s_wsheet
//l_s_wsheet = w_frame.GetActiveSheet()
//l_s_wsheet.TriggerEvent("ue_retrieve")
//
//uo_status.st_message.text = "수량수정 업데이트가 완료되었습니다."
end event

event ue_print;call super::ue_print;//integer l_n_rowcnt, i
//string mod_string,l_s_plant,l_s_dvsn
//
//window 	l_to_open
//str_easy l_str_prt
//
//								
////출력 윈도우에 Data 전달, 출력 윈도우 Open 
//SetPointer(HourGlass!)
//uo_status.st_message.Text = "출력 준비중 입니다..."
////this.TriggerEvent("ue_retrieve")
//if tab_1.tabpage_1.dw_replist.rowcount() < 1 then
//	uo_status.st_message.text = f_message("P020")
//	return 0
//end if
//
//tab_1.tabpage_1.dw_replist.sharedata(dw_report)
//
////인쇄 DataWindow 저장
////w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
//l_str_prt.transaction  = sqlca
//l_str_prt.datawindow   = dw_report
//l_str_prt.dwsyntax = mod_string
////l_str_prt.title = "완성품별 사용실적"
//l_str_prt.tag			  = This.ClassName()
//	
//f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
//Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
//	
//uo_status.st_message.Text = ""
//return 0
//
end event

type uo_status from w_origin_sheet02`uo_status within w_wip033u
end type

type st_4 from statictext within w_wip033u
integer x = 41
integer y = 28
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
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_5 from statictext within w_wip033u
integer x = 448
integer y = 28
integer width = 526
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
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

type dw_report from datawindow within w_wip033u
boolean visible = false
integer x = 4416
integer y = 8
integer width = 146
integer height = 108
integer taborder = 10
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_wip033u_01 from datawindow within w_wip033u
integer x = 59
integer y = 136
integer width = 4101
integer height = 268
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip032u_01"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_null, ls_dvsn
datawindowchild cdw_1, cdw_2

This.AcceptText()
ls_colname = This.GetColumnName()
IF ls_colname = 'wip001_waplant' Then
   This.SetItem(1,'wip001_wadvsn', ' ')
   ls_plant = This.GetItemString(1,'wip001_waplant')
   This.GetChild("wip001_wadvsn",cdw_1)
   cdw_1.SetTransObject(Sqlca)
   cdw_1.Retrieve(ls_plant)
END IF

IF ls_colname = 'wip001_wadvsn' Then
   This.SetItem(1,'inv101_pdcd', ' ')
   ls_dvsn = This.GetItemString(1,'wip001_wadvsn')
   This.GetChild("inv101_pdcd",cdw_2)
   cdw_2.SetTransObject(Sqlca)
   cdw_2.Retrieve(ls_dvsn)
END IF

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

event buttonclicked;//string ls_parm
//
//if dwo.name = 'b_search' then
//	openwithparm(w_find_001 , ' O')
//	ls_parm = message.stringparm
//	if f_spacechk(ls_parm) <> -1 then
//		dw_2.setitem(1,"vndnm",trim(mid(ls_parm,16)))
//		dw_2.setitem(1,"vndr",trim(mid(ls_parm,6,10)))
//		dw_2.setitem(1,"wip001_waorct",trim(mid(ls_parm,1,5)))
//	end if
//end if
end event

type dw_wip033u_02 from datawindow within w_wip033u
integer x = 37
integer y = 456
integer width = 2802
integer height = 2016
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip033u_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;string ls_plant, ls_dvsn, ls_iocd, ls_orct, ls_date, ls_itno, ls_fromdt, ls_todt
dec{4} lc_convqty
integer li_rowcnt

li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if

//해당품번에 대한 사용상세내역
dw_wip033u_03.reset()
ls_plant = This.getitemstring(row,"wip001_waplant")
ls_dvsn = This.getitemstring(row,"wip001_wadvsn")
ls_iocd = This.getitemstring(row,"wip001_waiocd")
ls_orct = This.getitemstring(row,"wip001_waorct")
ls_itno = This.getitemstring(row,"wip001_waitno")
ls_date = st_5.text
lc_convqty = This.getitemdecimal(row,"inv101_convqty")
ls_fromdt = ls_date + '01'

dw_wip033u_03.retrieve(g_s_company, ls_plant, ls_dvsn, ls_iocd, ls_orct,ls_itno, ls_fromdt, lc_convqty)
end event

type dw_wip033u_03 from datawindow within w_wip033u
integer x = 2853
integer y = 456
integer width = 1733
integer height = 2016
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip033u_03"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_down from picturebutton within w_wip033u
integer x = 4064
integer y = 216
integer width = 155
integer height = 132
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\KDAC\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if dw_wip033u_02.rowcount() < 1 then
	return 0
end if

f_save_to_excel_number(dw_wip033u_02)
end event

type gb_1 from groupbox within w_wip033u
integer x = 23
integer y = 100
integer width = 4558
integer height = 324
integer taborder = 30
integer textsize = -6
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
end type

