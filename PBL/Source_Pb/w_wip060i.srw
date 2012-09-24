$PBExportHeader$w_wip060i.srw
$PBExportComments$재공 시스템 수작업화면
forward
global type w_wip060i from w_origin_sheet01
end type
type dw_1 from datawindow within w_wip060i
end type
type dw_2 from datawindow within w_wip060i
end type
type cb_14 from commandbutton within w_wip060i
end type
type st_1 from statictext within w_wip060i
end type
type em_1 from editmask within w_wip060i
end type
type uo_area from u_pisc_select_area within w_wip060i
end type
type uo_division from u_pisc_select_division within w_wip060i
end type
type cb_17 from commandbutton within w_wip060i
end type
type cb_4 from commandbutton within w_wip060i
end type
type dw_3 from datawindow within w_wip060i
end type
type dw_4 from datawindow within w_wip060i
end type
type cb_1 from commandbutton within w_wip060i
end type
type cb_2 from commandbutton within w_wip060i
end type
type st_3 from statictext within w_wip060i
end type
type sle_plant from singlelineedit within w_wip060i
end type
type st_4 from statictext within w_wip060i
end type
type sle_dvsn from singlelineedit within w_wip060i
end type
type st_5 from statictext within w_wip060i
end type
type sle_itno from singlelineedit within w_wip060i
end type
type st_2 from statictext within w_wip060i
end type
type st_daesang from statictext within w_wip060i
end type
type st_55 from statictext within w_wip060i
end type
type st_saeng from statictext within w_wip060i
end type
type sle_1 from singlelineedit within w_wip060i
end type
type cb_3 from commandbutton within w_wip060i
end type
type cb_5 from commandbutton within w_wip060i
end type
type pb_1 from picturebutton within w_wip060i
end type
type st_6 from statictext within w_wip060i
end type
type sle_fromdt from singlelineedit within w_wip060i
end type
type sle_todt from singlelineedit within w_wip060i
end type
type cb_6 from commandbutton within w_wip060i
end type
type cb_7 from commandbutton within w_wip060i
end type
type cb_8 from commandbutton within w_wip060i
end type
type gb_2 from groupbox within w_wip060i
end type
type gb_1 from groupbox within w_wip060i
end type
type gb_3 from groupbox within w_wip060i
end type
type gb_4 from groupbox within w_wip060i
end type
end forward

global type w_wip060i from w_origin_sheet01
event ue_postevent ( )
dw_1 dw_1
dw_2 dw_2
cb_14 cb_14
st_1 st_1
em_1 em_1
uo_area uo_area
uo_division uo_division
cb_17 cb_17
cb_4 cb_4
dw_3 dw_3
dw_4 dw_4
cb_1 cb_1
cb_2 cb_2
st_3 st_3
sle_plant sle_plant
st_4 st_4
sle_dvsn sle_dvsn
st_5 st_5
sle_itno sle_itno
st_2 st_2
st_daesang st_daesang
st_55 st_55
st_saeng st_saeng
sle_1 sle_1
cb_3 cb_3
cb_5 cb_5
pb_1 pb_1
st_6 st_6
sle_fromdt sle_fromdt
sle_todt sle_todt
cb_6 cb_6
cb_7 cb_7
cb_8 cb_8
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
gb_4 gb_4
end type
global w_wip060i w_wip060i

forward prototypes
public function integer wf_wip001_vndr (string ag_div)
public function integer wf_wip002_vndr (string ag_div, string ag_yyyy, string ag_mm)
public function integer wf_wip002_line (string ag_div, string ag_yyyy, string ag_mm)
public function integer wf_wip001_line (string ag_div)
public function integer wf_update_orct (string ag_cmcd, string ag_plant, string ag_dvsn, string ag_yyyymm)
public function integer wf_wip001_orct (string ag_cmcd, string ag_plant, string ag_dvsn)
end prototypes

event ue_postevent();// 조회, 입력, 저장, 삭제, 상세조회, 화면인쇄, 특수문자
wf_icon_onoff(true, true, true, true, false, false,  false)
				  
f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
end event

public function integer wf_wip001_vndr (string ag_div);INSERT INTO "PBWIP"."WIP001"  
     ( "WACMCD","WAPLANT","WADVSN","WAORCT","WAITNO","WAIOCD","WAAVRG1","WAAVRG2",   
       "WABGQT","WABGAT1","WABGAT2","WAINQT","WAINAT1","WAINAT2","WAINAT3","WAINAT4",   
       "WAUSQT1","WAUSAT1","WAUSQT2","WAUSAT2","WAUSQT3","WAUSAT3","WAUSQT4","WAUSAT4",   
       "WAUSQT5","WAUSAT5","WAUSQT6","WAUSAT6","WAUSQT7","WAUSAT7","WAUSQT8","WAUSAT8",   
       "WAUSAT9","WAOHQT","WAOHAT1","WAOHAT2","WASCRP","WARETN","WAPLAN",   
       "WAIPADDR","WAMACADDR","WAINPTDT","WAUPDTDT" )  
SELECT '01',         'D',  "WDIV", "WORCT",  "WITNO",  "WIOCD",   "WAVRG",     0,  
       "WBGQT",  "WBGAT",       0,  "WINQT1", "WINAT1",     0,   "WINAT2",      0,
       0,             0,  "WUSQT1","WUSAT1",         0,        0,         0,       0,
		 "WUSQT2","WUSAT2", "WUSQT3","WUSAT3",   "WUSQT4", "WUSAT4", "WUSQT5", "WUSAT5",
		        0, "WOHQT", "WOHAT",        0,  "WSCRP",   "WRETN", "WPLAN",     
       :g_s_ipaddr, :g_s_macaddr,"WDATEC"||"WDATEY"||"WDATEM"||"WDATED","WLUDTC"||"WLUDTY"||"WLUDTM"||"WLUDTD"
    
   FROM "DEINVO"."WIPDAV"  
   WHERE "DEINVO"."WIPDAV"."WDIV" = :ag_div  AND
		   "DEINVO"."WIPDAV"."WIOCD" = '2' 
			using sqlca;

if sqlca.sqlcode <> 0 then
	return -1
else
	return 0
end if

end function

public function integer wf_wip002_vndr (string ag_div, string ag_yyyy, string ag_mm);//업체데이타 인서트(wipdaw -> wip002)
choose case ag_mm
	case '01'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )  
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG1",    0,  "WCBQT1", "WCBAT1",   0,  "WCINQTA1","WCINATA1",  0, "WCINATB1", 0,  
				   0 ,          0,"WCUSQTA1","WCUSATA1",  0,      0,        0,        0, 
				 "WCUSQTB1","WCUSATB1","WCUSQTC1","WCUSATC1",  "WCUSQTD1","WCUSATD1","WCUSQTE1","WCUSATE1",  0, 
				 "WCUSQTF1","WCUSATF1", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' ) 
			using sqlca;
	case '02'	
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG2",    0,  "WCBQT2", "WCBAT2",   0,  "WCINQTA2","WCINATA2",  0, "WCINATB2", 0,  
				 0,0,"WCUSQTA2","WCUSATA2",  0,      0,        0,        0, 
				 "WCUSQTB2","WCUSATB2","WCUSQTC2","WCUSATC2",  "WCUSQTD2","WCUSATD2","WCUSQTE2","WCUSATE2",  0, 
				 "WCUSQTF2","WCUSATF2", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' ) 
			using sqlca;
	case '03'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG3",    0,  "WCBQT3", "WCBAT3",   0,  "WCINQTA3","WCINATA3",  0, "WCINATB3", 0,  
				 0,0,"WCUSQTA3","WCUSATA3",  0,      0,        0,        0, 
				 "WCUSQTB3","WCUSATB3","WCUSQTC3","WCUSATC3",  "WCUSQTD3","WCUSATD3","WCUSQTE3","WCUSATE3",  0, 
				 "WCUSQTF3","WCUSATF3", ' ', :g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' )  
			using sqlca;
	case '04'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG4",    0,  "WCBQT4", "WCBAT4",   0,  "WCINQTA4","WCINATA4",  0, "WCINATB4", 0,  
				 0,0,"WCUSQTA4","WCUSATA4",  0,      0,        0,        0, 
				 "WCUSQTB4","WCUSATB4","WCUSQTC4","WCUSATC4",  "WCUSQTD4","WCUSATD4","WCUSQTE4","WCUSATE4",  0, 
				 "WCUSQTF4","WCUSATF4", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' ) 
			using sqlca;
	case '05'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG5",    0,  "WCBQT5", "WCBAT5",   0,  "WCINQTA5","WCINATA5",  0, "WCINATB5", 0,  
				 0,0,"WCUSQTA5","WCUSATA5",  0,      0,        0,        0, 
				 "WCUSQTB5","WCUSATB5","WCUSQTC5","WCUSATC5",  "WCUSQTD5","WCUSATD5","WCUSQTE5","WCUSATE5",  0, 
				 "WCUSQTF5","WCUSATF5", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' ) 
			using sqlca;
	case '06'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG6",    0,  "WCBQT6", "WCBAT6",   0,  "WCINQTA6","WCINATA6",  0, "WCINATB6", 0,  
				 0,0,"WCUSQTA6","WCUSATA6",  0,      0,        0,        0, 
				 "WCUSQTB6","WCUSATB6","WCUSQTC6","WCUSATC6",  "WCUSQTD6","WCUSATD6","WCUSQTE6","WCUSATE6",  0, 
				 "WCUSQTF6","WCUSATF6", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' ) 
			using sqlca;
	case '07'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG7",    0,  "WCBQT7", "WCBAT7",   0,  "WCINQTA7","WCINATA7",  0, "WCINATB7", 0,  
				 0,0,"WCUSQTA7","WCUSATA7",  0,      0,        0,        0, 
				 "WCUSQTB7","WCUSATB7","WCUSQTC7","WCUSATC7",  "WCUSQTD7","WCUSATD7","WCUSQTE7","WCUSATE7",  0, 
				 "WCUSQTF7","WCUSATF7", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' ) 
			using sqlca;
	case '08'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG8",    0,  "WCBQT8", "WCBAT8",   0,  "WCINQTA8","WCINATA8",  0, "WCINATB8", 0,  
				 0,0,"WCUSQTA8","WCUSATA8",  0,      0,        0,        0, 
				 "WCUSQTB8","WCUSATB8","WCUSQTC8","WCUSATC8",  "WCUSQTD8","WCUSATD8","WCUSQTE8","WCUSATE8",  0, 
				 "WCUSQTF8","WCUSATF8", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' )  
			using sqlca;
	case '09'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG9",    0,  "WCBQT9", "WCBAT9",   0,  "WCINQTA9","WCINATA9",  0, "WCINATB9", 0,  
				 0,0,"WCUSQTA9","WCUSATA9",  0,      0,        0,        0, 
				 "WCUSQTB9","WCUSATB9","WCUSQTC9","WCUSATC9",  "WCUSQTD9","WCUSATD9","WCUSQTE9","WCUSATE9",  0, 
				 "WCUSQTF9","WCUSATF9", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' )   
			using sqlca;
	case '10'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG10",    0,  "WCBQT10", "WCBAT10",   0,  "WCINQTA10","WCINATA10",  0, "WCINATB10", 0,  
				 0,0,"WCUSQTA10","WCUSATA10",  0,      0,        0,        0, 
				 "WCUSQTB10","WCUSATB10","WCUSQTC10","WCUSATC10",  "WCUSQTD10","WCUSATD10","WCUSQTE10","WCUSATE10",  0, 
				 "WCUSQTF10","WCUSATF10", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' )  
			using sqlca;
	case '11'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG11",    0,  "WCBQT11", "WCBAT11",   0,  "WCINQTA11","WCINATA11",  0, "WCINATB11", 0,  
				 0,0,"WCUSQTA11","WCUSATA11",  0,      0,        0,        0, 
				 "WCUSQTB11","WCUSATB11","WCUSQTC11","WCUSATC11",  "WCUSQTD11","WCUSATD11","WCUSQTE11","WCUSATE11",  0, 
				 "WCUSQTF11","WCUSATF11", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' ) 
			using sqlca;
	case '12'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG12",    0,  "WCBQT12", "WCBAT12",   0,  "WCINQTA12","WCINATA12",  0, "WCINATB12", 0,  
				 0,0,"WCUSQTA12","WCUSATA12",  0,      0,        0,        0, 
				 "WCUSQTB12","WCUSATB12","WCUSQTC12","WCUSATC12",  "WCUSQTD12","WCUSATD12","WCUSQTE12","WCUSATE12",  0, 
				 "WCUSQTF12","WCUSATF12", ' ', :g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '2' )   
			using sqlca;
end choose

if sqlca.sqlcode <> 0 then
	messagebox("check",sqlca.sqlerrtext)
	return -1
else
	return 0
end if
end function

public function integer wf_wip002_line (string ag_div, string ag_yyyy, string ag_mm);//라인데이타 인서트(wipdaw -> wip002)

choose case ag_mm
	case '01'
		//라인
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )  
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG1",    0,  "WCBQT1", "WCBAT1",   0,  "WCINQTA1","WCINATA1",  0, "WCINATB1", 0,  
				 "WCUSQTA1","WCUSATA1","WCUSQTC1","WCUSATC1",  0,      0,        0,        0, 
				     0,        0,"WCUSQTB1","WCUSATB1",  "WCUSQTD1","WCUSATD1","WCUSQTE1","WCUSATE1",  0, 
				 "WCUSQTF1","WCUSATF1", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW" 
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )
			using sqlca;
	case '02'	
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG2",    0,  "WCBQT2", "WCBAT2",   0,  "WCINQTA2","WCINATA2",  0, "WCINATB2", 0,  
				 "WCUSQTA2","WCUSATA2","WCUSQTC2","WCUSATC2",  0,      0,        0,        0, 
				         0,      0,"WCUSQTB2","WCUSATB2",  "WCUSQTD2","WCUSATD2","WCUSQTE2","WCUSATE2",  0, 
				 "WCUSQTF2","WCUSATF2", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' ) 
			using sqlca;
	case '03'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG3",    0,  "WCBQT3", "WCBAT3",   0,  "WCINQTA3","WCINATA3",  0, "WCINATB3", 0,  
				 "WCUSQTA3","WCUSATA3","WCUSQTC3","WCUSATC3",  0,      0,        0,        0, 
				      0,     0,"WCUSQTB3","WCUSATB3",  "WCUSQTD3","WCUSATD3","WCUSQTE3","WCUSATE3",  0, 
				 "WCUSQTF3","WCUSATF3", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )  
			using sqlca;
	case '04'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG4",    0,  "WCBQT4", "WCBAT4",   0,  "WCINQTA4","WCINATA4",  0, "WCINATB4", 0,  
				 "WCUSQTA4","WCUSATA4","WCUSQTC4","WCUSATC4",  0,      0,        0,        0, 
				 0,0,"WCUSQTB4","WCUSATB4",  "WCUSQTD4","WCUSATD4","WCUSQTE4","WCUSATE4",  0, 
				 "WCUSQTF4","WCUSATF4", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' ) 
			using sqlca;
	case '05'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG5",    0,  "WCBQT5", "WCBAT5",   0,  "WCINQTA5","WCINATA5",  0, "WCINATB5", 0,  
				 "WCUSQTA5","WCUSATA5","WCUSQTC5","WCUSATC5",  0,      0,        0,        0, 
				 0,0,"WCUSQTB5","WCUSATB5",  "WCUSQTD5","WCUSATD5","WCUSQTE5","WCUSATE5",  0, 
				 "WCUSQTF5","WCUSATF5", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )  
			using sqlca;
	case '06'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG6",    0,  "WCBQT6", "WCBAT6",   0,  "WCINQTA6","WCINATA6",  0, "WCINATB6", 0,  
				 "WCUSQTA6","WCUSATA6","WCUSQTC6","WCUSATC6",  0,      0,        0,        0, 
				 0,0,"WCUSQTB6","WCUSATB6",  "WCUSQTD6","WCUSATD6","WCUSQTE6","WCUSATE6",  0, 
				 "WCUSQTF6","WCUSATF6", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )  
			using sqlca;
	case '07'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG7",    0,  "WCBQT7", "WCBAT7",   0,  "WCINQTA7","WCINATA7",  0, "WCINATB7", 0,  
				 "WCUSQTA7","WCUSATA7","WCUSQTC7","WCUSATC7",  0,      0,        0,        0, 
				 0,0,"WCUSQTB7","WCUSATB7",  "WCUSQTD7","WCUSATD7","WCUSQTE7","WCUSATE7",  0, 
				 "WCUSQTF7","WCUSATF7", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' ) 
			using sqlca;
	case '08'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG8",    0,  "WCBQT8", "WCBAT8",   0,  "WCINQTA8","WCINATA8",  0, "WCINATB8", 0,  
				 "WCUSQTA8","WCUSATA8","WCUSQTC8","WCUSATC8",  0,      0,        0,        0, 
				 0,0,"WCUSQTB8","WCUSATB8",  "WCUSQTD8","WCUSATD8","WCUSQTE8","WCUSATE8",  0, 
				 "WCUSQTF8","WCUSATF8", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )  
			using sqlca;
	case '09'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG9",    0,  "WCBQT9", "WCBAT9",   0,  "WCINQTA9","WCINATA9",  0, "WCINATB9", 0,  
				 "WCUSQTA9","WCUSATA9","WCUSQTC9","WCUSATC9",  0,      0,        0,        0, 
				 0,0,"WCUSQTB9","WCUSATB9",  "WCUSQTD9","WCUSATD9","WCUSQTE9","WCUSATE9",  0, 
				 "WCUSQTF9","WCUSATF9", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )  
			using sqlca;
	case '10'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG10",    0,  "WCBQT10", "WCBAT10",   0,  "WCINQTA10","WCINATA10",  0, "WCINATB10", 0,  
				 "WCUSQTA10","WCUSATA10","WCUSQTC10","WCUSATC10",  0,      0,        0,        0, 
				 0,0,"WCUSQTB10","WCUSATB10",  "WCUSQTD10","WCUSATD10","WCUSQTE10","WCUSATE10",  0, 
				 "WCUSQTF10","WCUSATF10", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )  
			using sqlca;
	case '11'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG11",    0,  "WCBQT11", "WCBAT11",   0,  "WCINQTA11","WCINATA11",  0, "WCINATB11", 0,  
				 "WCUSQTA11","WCUSATA11","WCUSQTC11","WCUSATC11",  0,      0,        0,        0, 
				 0,0,"WCUSQTB11","WCUSATB11",  "WCUSQTD11","WCUSATD11","WCUSQTE11","WCUSATE11",  0, 
				 "WCUSQTF11","WCUSATF11", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy )  AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )  
			using sqlca;
	case '12'
		INSERT INTO "PBWIP"."WIP002"  
			( "WBCMCD","WBPLANT","WBDVSN","WBORCT","WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD","WBITCL",   
			  "WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP","WBRETN",   
			  "WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2","WBINAT3","WBINAT4",   
			  "WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3","WBUSQT4","WBUSAT4",   
			  "WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7","WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9",   
			  "WBUSQTA","WBUSATA","WBPLAN","WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )
		SELECT '01',    'D' ,    "WCDIV","WCORCT","WCITNO","WCYEARC"||"WCYEARY", :ag_mm ,"WCREV","WCIOCD","WCCLAS",   
				 "WCSRC",SUBSTR("WCPDCD",1,2),"WCUM", "WCTYP", "WCDSP", "WCSPC", "WCSCRP", "WCRETN",   
				 "WCAVG12",    0,  "WCBQT12", "WCBAT12",   0,  "WCINQTA12","WCINATA12",  0, "WCINATB12", 0,  
				 "WCUSQTA12","WCUSATA12","WCUSQTC12","WCUSATC12",  0,      0,        0,        0, 
				 0,0,"WCUSQTB12","WCUSATB12",  "WCUSQTD12","WCUSATD12","WCUSQTE12","WCUSATE12",  0, 
				 "WCUSQTF12","WCUSATF12", ' ',:g_s_ipaddr,:g_s_macaddr,"WCCIDTC"||"WCCIDTY"||"WCCIDTM"||"WCCIDTD","WCUPDTC"||"WCUPDTY"||"WCUPDTM"||"WCUPDTD"
			FROM "DEINVO"."WIPDAW"  
			WHERE ( "DEINVO"."WIPDAW"."WCDIV" = :ag_div ) AND  
					( "DEINVO"."WIPDAW"."WCYEARC"||"DEINVO"."WIPDAW"."WCYEARY" = :ag_yyyy ) AND
					( "DEINVO"."WIPDAW"."WCIOCD" = '1' )   
			using sqlca;
end choose

if sqlca.sqlcode <> 0 then
	messagebox("error check",sqlca.sqlerrtext)
	return -1
else
	return 0
end if
end function

public function integer wf_wip001_line (string ag_div);
INSERT INTO "PBWIP"."WIP001"  
     ( "WACMCD","WAPLANT","WADVSN","WAORCT","WAITNO","WAIOCD","WAAVRG1","WAAVRG2",   
       "WABGQT","WABGAT1","WABGAT2","WAINQT","WAINAT1","WAINAT2","WAINAT3","WAINAT4",   
       "WAUSQT1","WAUSAT1","WAUSQT2","WAUSAT2","WAUSQT3","WAUSAT3","WAUSQT4","WAUSAT4",   
       "WAUSQT5","WAUSAT5","WAUSQT6","WAUSAT6","WAUSQT7","WAUSAT7","WAUSQT8","WAUSAT8",   
       "WAUSAT9","WAOHQT","WAOHAT1","WAOHAT2","WASCRP","WARETN","WAPLAN",   
       "WAIPADDR","WAMACADDR","WAINPTDT","WAUPDTDT" )  
SELECT '01',         'D',  "WDIV", "WORCT",  "WITNO",  "WIOCD",   "WAVRG",     0,  
       "WBGQT",  "WBGAT",       0,  "WINQT1", "WINAT1",     0,   "WINAT2",      0,
       0,             0,          0,       0,       0,         0,        0,         0,
		 0,             0,          0,       0,       0,         0,        0,         0,
		        0, ("WBGQT" + "WINQT1"), ("WBGAT" + "WINAT1" + "WINAT2"),        0,  "WSCRP",   "WRETN", "WPLAN",     
       :g_s_ipaddr, :g_s_macaddr,"WDATEC"||"WDATEY"||"WDATEM"||"WDATED","WLUDTC"||"WLUDTY"||"WLUDTM"||"WLUDTD"
    
   FROM "DEINVO"."WIPDAV"  
   WHERE "DEINVO"."WIPDAV"."WDIV" = :ag_div  AND
		   "DEINVO"."WIPDAV"."WIOCD" = '1' 
			using sqlca;

if sqlca.sqlcode <> 0 then
	return -1
else
	return 0
end if
end function

public function integer wf_update_orct (string ag_cmcd, string ag_plant, string ag_dvsn, string ag_yyyymm);string ls_itno,ls_itno01, ls_orct, ls_mm
dec{4} lc_bgqt, lc_inqt, lc_usqt1, lc_usqt2,lc_usqt5,lc_usqt7, lc_usqt8, lc_usqta
dec{0} lc_bgamt, lc_inamt1, lc_inamt2,lc_usamt1, lc_usamt2, lc_usamt5, lc_usamt7, lc_usamt8, lc_usamta
long ll_rowcnt,ll_cnt

ls_mm = mid(ag_yyyymm,5)

declare upitem_cur cursor for  
	SELECT "WBITNO","WBORCT" FROM "PBWIP"."WIP002"  
	WHERE ( "PBWIP"."WIP002"."WBCMCD" = '01' ) AND  
			( "PBWIP"."WIP002"."WBPLANT" = :ag_plant ) AND  
			( "PBWIP"."WIP002"."WBDVSN" = :ag_dvsn ) AND 
			( "PBWIP"."WIP002"."WBORCT" <> '9999' ) AND
			( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ag_yyyymm ) AND  
			( "PBWIP"."WIP002"."WBIOCD" = '1' )   
			using sqlca;
	
open upitem_cur;	
	do while true
		fetch upitem_cur into :ls_itno,:ls_orct ;
			if sqlca.sqlcode <> 0 then
				exit
			end if
		
		SELECT COUNT(*) INTO :ll_cnt
			FROM "PBWIP"."WIP002"
			WHERE ( "PBWIP"."WIP002"."WBCMCD" = '01' ) AND  
						( "PBWIP"."WIP002"."WBPLANT" = :ag_plant ) AND  
						( "PBWIP"."WIP002"."WBDVSN" = :ag_dvsn ) AND
						( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND 
						( "PBWIP"."WIP002"."WBORCT" = '9999' ) AND 
						( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ag_yyyymm ) AND  
						( "PBWIP"."WIP002"."WBIOCD" = '1' )   
						using sqlca;
		if ll_cnt < 1 then
			  INSERT INTO "PBWIP"."WIP002"  
         	( "WBCMCD", "WBPLANT", "WBDVSN","WBORCT", "WBITNO","WBYEAR","WBMONTH","WBREV","WBIOCD",   
           		"WBITCL","WBSRCE","WBPDCD","WBUNIT","WBTYPE","WBDESC","WBSPEC","WBSCRP", "WBRETN",   
           		"WBAVRG1","WBAVRG2","WBBGQT","WBBGAT1","WBBGAT2","WBINQT","WBINAT1","WBINAT2",   
           		"WBINAT3","WBINAT4","WBUSQT1","WBUSAT1","WBUSQT2","WBUSAT2","WBUSQT3","WBUSAT3",   
           		"WBUSQT4", "WBUSAT4","WBUSQT5","WBUSAT5","WBUSQT6","WBUSAT6","WBUSQT7",   
           		"WBUSAT7","WBUSQT8","WBUSAT8","WBUSAT9","WBUSQTA","WBUSATA","WBPLAN",   
           		"WBIPADDR","WBMACADDR","WBINPTDT","WBUPDTDT" )  
  				  SELECT "PBWIP"."WIP002"."WBCMCD",   
							"PBWIP"."WIP002"."WBPLANT",   
							"PBWIP"."WIP002"."WBDVSN",   
							'9999',   
							"PBWIP"."WIP002"."WBITNO",   
							"PBWIP"."WIP002"."WBYEAR",   
							"PBWIP"."WIP002"."WBMONTH",   
							"PBWIP"."WIP002"."WBREV",   
							"PBWIP"."WIP002"."WBIOCD",   
							"PBWIP"."WIP002"."WBITCL",   
							"PBWIP"."WIP002"."WBSRCE",   
							"PBWIP"."WIP002"."WBPDCD",   
							"PBWIP"."WIP002"."WBUNIT",   
							"PBWIP"."WIP002"."WBTYPE",   
							"PBWIP"."WIP002"."WBDESC",   
							"PBWIP"."WIP002"."WBSPEC",   
							"PBWIP"."WIP002"."WBSCRP",   
							"PBWIP"."WIP002"."WBRETN",   
							"PBWIP"."WIP002"."WBAVRG1",   
							"PBWIP"."WIP002"."WBAVRG2",   
							"PBWIP"."WIP002"."WBBGQT",   
							"PBWIP"."WIP002"."WBBGAT1",   
							"PBWIP"."WIP002"."WBBGAT2",   
							"PBWIP"."WIP002"."WBINQT",   
							"PBWIP"."WIP002"."WBINAT1",   
							"PBWIP"."WIP002"."WBINAT2",   
							"PBWIP"."WIP002"."WBINAT3",   
							"PBWIP"."WIP002"."WBINAT4",   
							"PBWIP"."WIP002"."WBUSQT1",   
							"PBWIP"."WIP002"."WBUSAT1",   
							"PBWIP"."WIP002"."WBUSQT2",   
							"PBWIP"."WIP002"."WBUSAT2",   
							"PBWIP"."WIP002"."WBUSQT3",   
							"PBWIP"."WIP002"."WBUSAT3",   
							"PBWIP"."WIP002"."WBUSQT4",   
							"PBWIP"."WIP002"."WBUSAT4",   
							"PBWIP"."WIP002"."WBUSQT5",   
							"PBWIP"."WIP002"."WBUSAT5",   
							"PBWIP"."WIP002"."WBUSQT6",   
							"PBWIP"."WIP002"."WBUSAT6",   
							"PBWIP"."WIP002"."WBUSQT7",   
							"PBWIP"."WIP002"."WBUSAT7",   
							"PBWIP"."WIP002"."WBUSQT8",   
							"PBWIP"."WIP002"."WBUSAT8",   
							"PBWIP"."WIP002"."WBUSAT9",   
							"PBWIP"."WIP002"."WBUSQTA",   
							"PBWIP"."WIP002"."WBUSATA",   
							"PBWIP"."WIP002"."WBPLAN",   
							"PBWIP"."WIP002"."WBIPADDR",   
							"PBWIP"."WIP002"."WBMACADDR",   
							"PBWIP"."WIP002"."WBINPTDT",   
							"PBWIP"."WIP002"."WBUPDTDT"  
							 FROM "PBWIP"."WIP002"  
							WHERE ( "PBWIP"."WIP002"."WBCMCD" = '01' ) AND  
									( "PBWIP"."WIP002"."WBPLANT" = :ag_plant ) AND  
									( "PBWIP"."WIP002"."WBDVSN" = :ag_dvsn ) AND  
									( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
									( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND 
									( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ag_yyyymm ) AND  
									( "PBWIP"."WIP002"."WBIOCD" = '1' )   
									using sqlca;	

			DELETE FROM "PBWIP"."WIP002"   
				WHERE ( "PBWIP"."WIP002"."WBCMCD" = '01' ) AND  
						( "PBWIP"."WIP002"."WBPLANT" = :ag_plant ) AND  
						( "PBWIP"."WIP002"."WBDVSN" = :ag_dvsn ) AND
						( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND 
						( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND 
						( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ag_yyyymm ) AND  
						( "PBWIP"."WIP002"."WBIOCD" = '1' )   
						using sqlca;	
		else
			SELECT "PBWIP"."WIP002"."WBBGQT", "PBWIP"."WIP002"."WBBGAT1", "PBWIP"."WIP002"."WBINQT",   
					"PBWIP"."WIP002"."WBINAT1", "PBWIP"."WIP002"."WBINAT3", 
					"PBWIP"."WIP002"."WBUSQT1", "PBWIP"."WIP002"."WBUSAT1",
					"PBWIP"."WIP002"."WBUSQT2","PBWIP"."WIP002"."WBUSAT2",
					"PBWIP"."WIP002"."WBUSQT5","PBWIP"."WIP002"."WBUSAT5",   
					"PBWIP"."WIP002"."WBUSQT7","PBWIP"."WIP002"."WBUSAT7", 
					"PBWIP"."WIP002"."WBUSQT8","PBWIP"."WIP002"."WBUSAT8", 
					"PBWIP"."WIP002"."WBUSQTA","PBWIP"."WIP002"."WBUSATA"  
			 INTO :lc_bgqt, :lc_bgamt, :lc_inqt,:lc_inamt1,:lc_inamt2,
					:lc_usqt1,:lc_usamt1,:lc_usqt2,:lc_usamt2,
					:lc_usqt5,:lc_usamt5,:lc_usqt7,:lc_usamt7,
					:lc_usqt8,:lc_usamt8,:lc_usqta,:lc_usamta  
				FROM "PBWIP"."WIP002"  
				WHERE ( "PBWIP"."WIP002"."WBCMCD" = '01' ) AND  
					( "PBWIP"."WIP002"."WBPLANT" = :ag_plant ) AND  
					( "PBWIP"."WIP002"."WBDVSN" = :ag_dvsn ) AND  
					( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
					( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
					( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ag_yyyymm )   using sqlca;

			  UPDATE "PBWIP"."WIP002"  
				  SET "WBBGQT" = WBBGQT  + :lc_bgqt,   
						"WBBGAT1" = WBBGAT1  + :lc_bgamt,   
						"WBINQT" = WBINQT  + :lc_inqt,   
						"WBINAT1" = WBINAT1  + :lc_inamt1,   
						"WBINAT3" = WBINAT3  + :lc_inamt2,   
						"WBUSQT1" = WBUSQT1  + :lc_usqt1,
						"WBUSAT1" = WBUSAT1  + :lc_usamt1,
						"WBUSQT2" = WBUSQT2  + :lc_usqt2, 
						"WBUSAT2" = WBUSAT2  + :lc_usamt2,
						"WBUSQT5" = WBUSQT5  + :lc_usqt5,   
						"WBUSAT5" = WBUSAT5  + :lc_usamt5,   
						"WBUSQT7" = WBUSQT7  + :lc_usqt7,   
						"WBUSAT7" = WBUSAT7  + :lc_usamt7,   
						"WBUSQT8" = WBUSQT8  + :lc_usqt8,   
						"WBUSAT8" = WBUSAT8  + :lc_usamt8,   
						"WBUSQTA" = WBUSQTA  + :lc_usqta,   
						"WBUSATA" = WBUSATA  + :lc_usamta  
				WHERE ( "PBWIP"."WIP002"."WBCMCD" = '01' ) AND  
						( "PBWIP"."WIP002"."WBPLANT" = :ag_plant ) AND  
						( "PBWIP"."WIP002"."WBDVSN" = :ag_dvsn ) AND  
						( "PBWIP"."WIP002"."WBORCT" = '9999' ) AND  
						( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
						( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ag_yyyymm )   
						using sqlca;
			if sqlca.sqlcode <> 0 then
				uo_status.st_message.text = ls_itno + "품번 업데이트시 에러가 발생했음"
			else
				DELETE FROM "PBWIP"."WIP002"  
					WHERE ( "PBWIP"."WIP002"."WBCMCD" = '01' ) AND  
						( "PBWIP"."WIP002"."WBPLANT" = :ag_plant ) AND  
						( "PBWIP"."WIP002"."WBDVSN" = :ag_dvsn ) AND  
						( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
						( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
						( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ag_yyyymm )   using sqlca;
			end if
		end if
	loop		
close upitem_cur;
	
return 0
end function

public function integer wf_wip001_orct (string ag_cmcd, string ag_plant, string ag_dvsn);string ls_itno, ls_orct
dec{4} lc_bgqt, lc_inqt, lc_usqt1, lc_usqt2,lc_usqt5,lc_usqt7, lc_usqt8, lc_usqta
dec{0} lc_bgamt, lc_inamt1, lc_inamt2,lc_usamt1, lc_usamt2, lc_usamt5, lc_usamt7, lc_usamt8, lc_usamt9


declare upitem_cur cursor for  
	SELECT "WAITNO","WAORCT" FROM "PBWIP"."WIP001"  
   WHERE ( "PBWIP"."WIP001"."WACMCD" = '01' ) AND  
         ( "PBWIP"."WIP001"."WAPLANT" = :ag_plant ) AND  
         ( "PBWIP"."WIP001"."WADVSN" = :ag_dvsn ) AND   
         ( "PBWIP"."WIP001"."WAIOCD" = '1' )   
         using sqlca;
	
open upitem_cur;	
	do while true
		fetch upitem_cur into :ls_itno,:ls_orct ;
			if sqlca.sqlcode <> 0 then
				exit
			end if
		
		UPDATE "PBWIP"."WIP001"  
   		SET "WAORCT" = '9999'  
   		WHERE ( "PBWIP"."WIP001"."WACMCD" = '01' ) AND  
         		( "PBWIP"."WIP001"."WAPLANT" = :ag_plant ) AND  
         		( "PBWIP"."WIP001"."WADVSN" = :ag_dvsn ) AND
					( "PBWIP"."WIP001"."WAITNO" = :ls_itno ) AND 
					( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND   
         		( "PBWIP"."WIP001"."WAIOCD" = '1' )   
         		using sqlca;
					
		if sqlca.sqlcode <> 0  then
		  	SELECT "PBWIP"."WIP001"."WABGQT", "PBWIP"."WIP001"."WABGAT1", "PBWIP"."WIP001"."WAINQT",   
					"PBWIP"."WIP001"."WAINAT1", "PBWIP"."WIP001"."WAINAT3", 
					"PBWIP"."WIP001"."WAUSQT1", "PBWIP"."WIP001"."WAUSAT1",
					"PBWIP"."WIP001"."WAUSQT2","PBWIP"."WIP001"."WAUSAT2",
					"PBWIP"."WIP001"."WAUSQT5","PBWIP"."WIP001"."WAUSAT5",   
					"PBWIP"."WIP001"."WAUSQT7","PBWIP"."WIP001"."WAUSAT7", 
					"PBWIP"."WIP001"."WAUSQT8","PBWIP"."WIP001"."WAUSAT8", 
					"PBWIP"."WIP001"."WAUSAT9"
			 INTO :lc_bgqt, :lc_bgamt, :lc_inqt,:lc_inamt1,:lc_inamt2,
			 		:lc_usqt1,:lc_usamt1,:lc_usqt2,:lc_usamt2,
					:lc_usqt5,:lc_usamt5,:lc_usqt7,:lc_usamt7,
					:lc_usqt8,:lc_usamt8,:lc_usamt9 
			 	FROM "PBWIP"."WIP001"  
				WHERE ( "PBWIP"."WIP001"."WACMCD" = '01' ) AND  
					( "PBWIP"."WIP001"."WAPLANT" = :ag_plant ) AND  
					( "PBWIP"."WIP001"."WADVSN" = :ag_dvsn ) AND  
					( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
					( "PBWIP"."WIP001"."WAITNO" = :ls_itno )  
				   using sqlca;

			  UPDATE "PBWIP"."WIP001"  
				  SET "WABGQT" = WABGQT  + :lc_bgqt,   
						"WABGAT1" = WABGAT1  + :lc_bgamt,   
						"WAINQT" = WAINQT  + :lc_inqt,   
						"WAINAT1" = WAINAT1  + :lc_inamt1,   
						"WAINAT3" = WAINAT3  + :lc_inamt2,   
						"WAUSQT1" = WAUSQT1  + :lc_usqt1,
						"WAUSAT1" = WAUSAT1  + :lc_usamt1,
						"WAUSQT2" = WAUSQT2  + :lc_usqt2, 
						"WAUSAT2" = WAUSAT2  + :lc_usamt2,
						"WAUSQT5" = WAUSQT5  + :lc_usqt5,   
						"WAUSAT5" = WAUSAT5  + :lc_usamt5,   
						"WAUSQT7" = WAUSQT7  + :lc_usqt7,   
						"WAUSAT7" = WAUSAT7  + :lc_usamt7,   
						"WAUSQT8" = WAUSQT8  + :lc_usqt8,   
						"WAUSAT8" = WAUSAT8  + :lc_usamt8,   
						"WAUSAT9" = WAUSAT9  + :lc_usamt9 
				WHERE ( "PBWIP"."WIP001"."WACMCD" = '01' ) AND  
						( "PBWIP"."WIP001"."WAPLANT" = :ag_plant ) AND  
						( "PBWIP"."WIP001"."WADVSN" = :ag_dvsn ) AND  
						( "PBWIP"."WIP001"."WAORCT" = '9999' ) AND  
						( "PBWIP"."WIP001"."WAITNO" = :ls_itno )    
						using sqlca;
			if sqlca.sqlcode <> 0 then
				messagebox("Error", "라인에러 : " + ls_itno + " , " + sqlca.sqlerrtext)
			else
				DELETE FROM "PBWIP"."WIP001"  
					WHERE ( "PBWIP"."WIP001"."WACMCD" = '01' ) AND  
						( "PBWIP"."WIP001"."WAPLANT" = :ag_plant ) AND  
						( "PBWIP"."WIP001"."WADVSN" = :ag_dvsn ) AND  
						( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
						( "PBWIP"."WIP001"."WAITNO" = :ls_itno )   
						using sqlca;
			end if
		end if
	loop		
close upitem_cur;

return 0

end function

on w_wip060i.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_14=create cb_14
this.st_1=create st_1
this.em_1=create em_1
this.uo_area=create uo_area
this.uo_division=create uo_division
this.cb_17=create cb_17
this.cb_4=create cb_4
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_3=create st_3
this.sle_plant=create sle_plant
this.st_4=create st_4
this.sle_dvsn=create sle_dvsn
this.st_5=create st_5
this.sle_itno=create sle_itno
this.st_2=create st_2
this.st_daesang=create st_daesang
this.st_55=create st_55
this.st_saeng=create st_saeng
this.sle_1=create sle_1
this.cb_3=create cb_3
this.cb_5=create cb_5
this.pb_1=create pb_1
this.st_6=create st_6
this.sle_fromdt=create sle_fromdt
this.sle_todt=create sle_todt
this.cb_6=create cb_6
this.cb_7=create cb_7
this.cb_8=create cb_8
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_14
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.uo_area
this.Control[iCurrent+7]=this.uo_division
this.Control[iCurrent+8]=this.cb_17
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.dw_3
this.Control[iCurrent+11]=this.dw_4
this.Control[iCurrent+12]=this.cb_1
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.sle_plant
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.sle_dvsn
this.Control[iCurrent+18]=this.st_5
this.Control[iCurrent+19]=this.sle_itno
this.Control[iCurrent+20]=this.st_2
this.Control[iCurrent+21]=this.st_daesang
this.Control[iCurrent+22]=this.st_55
this.Control[iCurrent+23]=this.st_saeng
this.Control[iCurrent+24]=this.sle_1
this.Control[iCurrent+25]=this.cb_3
this.Control[iCurrent+26]=this.cb_5
this.Control[iCurrent+27]=this.pb_1
this.Control[iCurrent+28]=this.st_6
this.Control[iCurrent+29]=this.sle_fromdt
this.Control[iCurrent+30]=this.sle_todt
this.Control[iCurrent+31]=this.cb_6
this.Control[iCurrent+32]=this.cb_7
this.Control[iCurrent+33]=this.cb_8
this.Control[iCurrent+34]=this.gb_2
this.Control[iCurrent+35]=this.gb_1
this.Control[iCurrent+36]=this.gb_3
this.Control[iCurrent+37]=this.gb_4
end on

on w_wip060i.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_14)
destroy(this.st_1)
destroy(this.em_1)
destroy(this.uo_area)
destroy(this.uo_division)
destroy(this.cb_17)
destroy(this.cb_4)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.sle_plant)
destroy(this.st_4)
destroy(this.sle_dvsn)
destroy(this.st_5)
destroy(this.sle_itno)
destroy(this.st_2)
destroy(this.st_daesang)
destroy(this.st_55)
destroy(this.st_saeng)
destroy(this.sle_1)
destroy(this.cb_3)
destroy(this.cb_5)
destroy(this.pb_1)
destroy(this.st_6)
destroy(this.sle_fromdt)
destroy(this.sle_todt)
destroy(this.cb_6)
destroy(this.cb_7)
destroy(this.cb_8)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;datawindowchild dwc_01, dwc_02, dwc_03

dw_1.settransobject(sqlca)
dw_2.settransobject(sqlca)

dw_1.getchild("wip001_waplant",dwc_01)
dwc_01.settransobject(sqlca)
dwc_01.retrieve('SLE220')
dw_1.getchild("wip001_wadvsn",dwc_02)
dwc_02.settransobject(sqlca)
dwc_02.retrieve('D')

dw_1.insertrow(0)

This.triggerevent('ue_postevent')
end event

event ue_save;call super::ue_save;if f_spacechk("itno") = -1 then
	messagebox("ok","ok")
else
	messagebox("fail","fail")
end if
end event

event ue_retrieve;call super::ue_retrieve;string ls_plant, ls_dvsn, ls_date, ls_yyyy, ls_mm
dw_1.accepttext()

em_1.getdata(ls_date)
ls_yyyy = mid(ls_date,1,4)
ls_mm = string(integer(mid(ls_date,5,2)))
ls_plant = dw_1.getitemstring(1,"wip001_waplant")
ls_dvsn = dw_1.getitemstring(1,"wip001_wadvsn")

dw_2.retrieve(ls_yyyy,ls_mm,ls_plant,ls_dvsn)
end event

type uo_status from w_origin_sheet01`uo_status within w_wip060i
end type

type dw_1 from datawindow within w_wip060i
integer x = 69
integer y = 40
integer width = 1326
integer height = 136
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip060i_01"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;string ls_colname, ls_plant, ls_null
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
end event

type dw_2 from datawindow within w_wip060i
integer x = 1810
integer y = 1668
integer width = 2761
integer height = 788
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_bom_xplan_bom017"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_14 from commandbutton within w_wip060i
integer x = 2021
integer y = 356
integer width = 1157
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "BOM LowLevel Creation"
end type

event clicked;string ls_cmcd,ls_plant, ls_dvsn, ls_orct, ls_itno, ls_xplant, ls_xdvsn,ls_mysql
long ll_cnt,ll_cntx, ll_rowcnt,ll_count
string ls_fromdt, ls_todt, ls_errchk

datastore lds_01
setpointer(hourglass!)

em_1.getdata(ls_todt)

if f_dateedit(ls_todt) = space(8) then
	uo_status.st_message.text = "날짜를 입력하십시요"
	return 0
end if

ls_fromdt = mid(ls_todt,1,6) + '01'
if MessageBox("작업실행", "기준날짜 : " + ls_fromdt + " ~ " + ls_todt &
		+ " 로 BOM LowLevel Creation " &
		+ " 작업을 실행하시겠읍니까? ", Exclamation!, OKCancel!, 2) = 2 then
	return 0
end if

// ITEM MASTER( PBINV/INV002 ) -> LOLEVEL 필드초기화
UPDATE "PBINV"."INV002"  
     SET "LOLEVEL" = 0  
   WHERE "PBINV"."INV002"."COMLTD" = '01'   
   using sqlca;
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "inv002 lolevel 초기화 에러"
	return 0
end if

lds_01 = create datastore
lds_01.dataobject = 'd_sp_wip_15'
lds_01.settransobject(sqlca)
	 
for ll_cnt = 1 to 12
	choose case ll_cnt
		case 1
			ls_xplant = 'D'
			ls_xdvsn = 'A%'
		case 2
			ls_xplant = 'D'
			ls_xdvsn = 'H%'
		case 3
			ls_xplant = 'D'
			ls_xdvsn = 'M%'
		case 4
			ls_xplant = 'D'
			ls_xdvsn = 'S%'
		case 5
			ls_xplant = 'D'
			ls_xdvsn = 'V%'
		case 6
			ls_xplant = 'J'
			ls_xdvsn = 'M%'
		case 7
			ls_xplant = 'J'
			ls_xdvsn = 'S%'
		case 8
			ls_xplant = 'J'
			ls_xdvsn = 'H%'
		case 9
			ls_xplant = 'K'
			ls_xdvsn = 'S%'
		case 10
			ls_xplant = 'K'
			ls_xdvsn = 'H%'
		case 11
			ls_xplant = 'K'
			ls_xdvsn = 'M%'
		case 12
			ls_xplant = 'B'
			ls_xdvsn = '%'
	end choose
	
	lds_01.reset()
	ll_rowcnt = lds_01.retrieve(ls_xplant,ls_xdvsn,ls_fromdt,ls_todt)
	for ll_cntx = 1 to ll_rowcnt
		ls_cmcd = '01'
		ls_plant = lds_01.getitemstring(ll_cntx,"xplant")
		ls_dvsn = lds_01.getitemstring(ll_cntx,"div")
		ls_itno = lds_01.getitemstring(ll_cntx,"itno")
		
		select count(*) into :ll_count from pbpdm.bom001
		where pcmcd = :ls_cmcd AND plant = :ls_plant AND
				pdvsn = :ls_dvsn AND ppitn = :ls_itno AND
				(( pedte = ' '  and pedtm <= :ls_todt ) or
				( pedte <> ' ' and pedtm <= :ls_todt and pedte >= :ls_todt ));
		if sqlca.sqlcode <> 0 or ll_count < 1 then
  			continue
		end if
		
		DECLARE up_wip_15 PROCEDURE FOR PBWIP.SP_WIP_15  
			A_COMLTD = :ls_cmcd,   
			A_PLANT = :ls_plant,   
			A_DVSN = :ls_dvsn,   
			A_PITNO = :ls_itno,
			A_FROMDATE = :ls_fromdt,
			A_TODATE = :ls_todt,   
			A_CHK = 'A'  using sqlca;
		execute up_wip_15;
		if sqlca.sqlcode = 0 or sqlca.sqlcode = 100 then
			select count(*) into :ll_count from qtemp.bomtemp01
			using sqlca;
		else
			lds_01.setitem(ll_cntx,"errchk",'Y')
			ll_count = 0
		end if
		//DELETE TEMP TABLE
		ls_mysql = " DROP TABLE QTEMP.BOMTEMP01"
		Execute Immediate :ls_mysql using sqlca;
	   
		uo_status.st_message.text = "공장 : " + ls_plant + " : " + ls_dvsn + " : " + ls_itno + " | " + string(ll_count)	
	next
	
	for ll_cntx = 1 to ll_rowcnt
		ls_cmcd = '01'
		ls_plant = lds_01.getitemstring(ll_cntx,"xplant")
		ls_dvsn = lds_01.getitemstring(ll_cntx,"div")
		ls_itno = lds_01.getitemstring(ll_cntx,"itno")
		ls_fromdt = ls_todt
		
		select count(*) into :ll_count from pbpdm.bom001
		where pcmcd = :ls_cmcd AND plant = :ls_plant AND
				pdvsn = :ls_dvsn AND ppitn = :ls_itno AND
				(( pedte = ' '  and pedtm <= :ls_todt ) or
				( pedte <> ' ' and pedtm <= :ls_todt and pedte >= :ls_todt ));
			
		if sqlca.sqlcode <> 0 or ll_count < 1 or ls_errchk = 'N' then
  			continue
		end if
		
		DECLARE up_wip_16 PROCEDURE FOR PBWIP.SP_WIP_15  
			A_COMLTD = :ls_cmcd,   
			A_PLANT = :ls_plant,   
			A_DVSN = :ls_dvsn,   
			A_PITNO = :ls_itno,
			A_FROMDATE = :ls_fromdt,
			A_TODATE = :ls_todt,   
			A_CHK = 'A'  using sqlca;
		execute up_wip_16;
		if sqlca.sqlcode = 0 or sqlca.sqlcode = 100 then
			select count(*) into :ll_count from qtemp.bomtemp01
			using sqlca;
		else
			messagebox("확인","품번 : " + ls_itno + " " + sqlca.sqlerrtext + string(sqlca.sqlcode))
			ll_count = 0
		end if
		//DELETE TEMP TABLE
		ls_mysql = " DROP TABLE QTEMP.BOMTEMP01"
		Execute Immediate :ls_mysql using sqlca;
	   
		uo_status.st_message.text = "공장 : " + ls_plant + " : " + ls_dvsn + " : " + ls_itno + " | " + string(ll_count)	
	next
next
uo_status.st_message.text = "완료되었습니다."
end event

type st_1 from statictext within w_wip060i
integer x = 1440
integer y = 76
integer width = 375
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "기준날짜"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_1 from editmask within w_wip060i
integer x = 1801
integer y = 64
integer width = 530
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
string text = "none"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "####.##.##"
end type

type uo_area from u_pisc_select_area within w_wip060i
integer x = 2427
integer y = 72
integer taborder = 70
boolean bringtotop = true
end type

on uo_area.destroy
call u_pisc_select_area::destroy
end on

event ue_select;call super::ue_select;f_pisc_retrieve_dddw_division(uo_division.dw_1, &
											g_s_empno, &
											uo_area.is_uo_areacode, &
											'%', &
											False, &
											uo_division.is_uo_divisioncode, &
											uo_division.is_uo_divisionname, &
											uo_division.is_uo_divisionnameeng)
end event

type uo_division from u_pisc_select_division within w_wip060i
integer x = 2935
integer y = 72
integer taborder = 80
boolean bringtotop = true
end type

on uo_division.destroy
call u_pisc_select_division::destroy
end on

type cb_17 from commandbutton within w_wip060i
integer x = 1879
integer y = 980
integer width = 1458
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "변경차이분 조정금액으로 일괄반영(2009년12월)"
end type

event clicked;string ls_plant, ls_dvsn, ls_orct, ls_itno
string ls_pbdiv, ls_pdcd, ls_xplant, ls_div, ls_keydiv
integer li_cnt, li_rowcnt
dec{0} lc_pbmatw, lc_wbusat8, lc_wbusata, lc_usat, lc_bkusata
dec{4} lc_wbusqt8, lc_wbusqta, lc_usqt, lc_bkusqta
datastore ds_cost_pcc950

//원가계산관리 기말재공금액 생성 : 2007.06.20
ds_cost_pcc950 = create datastore                  			              
ds_cost_pcc950.dataobject = "d_2010_wip002"
ds_cost_pcc950.settransobject(sqlca)

ls_keydiv = ''

DO WHILE TRUE
	select a.xplant,a.div,concat(a.xplant,a.div)
	into :ls_xplant, :ls_div, :ls_keydiv
	 from pbinv.inv902 a inner join pbcommon.dac002 b
	  on a.div = b.cocode and b.cogubun = 'DAC030' and
	  a.inptid = 'A' and concat(a.xplant,a.div) > :ls_keydiv
	order by concat(a.xplant,a.div)
	fetch first 1 row only
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		exit
	end if

//	if ls_xplant = 'Y' then continue

	ds_cost_pcc950.reset()
	li_rowcnt = ds_cost_pcc950.retrieve(ls_xplant,ls_div)
	if li_rowcnt > 0 then
		for li_cnt = 1 to li_rowcnt
			ls_plant = ds_cost_pcc950.getitemstring(li_cnt,"wip002_wbplant")
			ls_dvsn = ds_cost_pcc950.getitemstring(li_cnt,"wip002_wbdvsn")
			ls_itno = ds_cost_pcc950.getitemstring(li_cnt,"wip002_wbitno")
			ls_orct = ds_cost_pcc950.getitemstring(li_cnt,"wip002_wborct")
			lc_wbusqt8 = ds_cost_pcc950.getitemnumber(li_cnt,"wip002_wbusqt8")
			lc_wbusat8 = ds_cost_pcc950.getitemnumber(li_cnt,"wip002_wbusat8")
			lc_bkusqta = ds_cost_pcc950.getitemnumber(li_cnt,"wip002bk_wbusqta")
			lc_bkusata = ds_cost_pcc950.getitemnumber(li_cnt,"wip002bk_wbusata")
			lc_usqt = lc_wbusqt8 - ds_cost_pcc950.getitemnumber(li_cnt,"usqt8")
			lc_usat = lc_wbusat8 - ds_cost_pcc950.getitemnumber(li_cnt,"usat8")
			
			
			UPDATE PBWIP.WIP002
			SET WBUSQT8 = :lc_usqt, WBUSAT8 = :lc_usat, WBUSQTA = :lc_bkusqta, WBUSATA = :lc_bkusata
			WHERE WBCMCD = '01' AND WBPLANT = :ls_plant AND WBDVSN = :ls_dvsn AND
				WBYEAR = '2009' AND WBMONTH = '12' AND
				WBORCT = :ls_orct AND WBITNO = :ls_itno AND WBIOCD <> '3'
			using sqlca;
			
			if sqlca.sqlnrows < 1 then
				messagebox("chk", sqlca.sqlerrtext)
			end if
		next
	end if
LOOP
uo_status.st_message.text = "완료되었습니다." + STRING(li_rowcnt)
return 0
end event

type cb_4 from commandbutton within w_wip060i
integer x = 105
integer y = 1628
integer width = 704
integer height = 112
integer taborder = 120
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "재공단가업데이트"
end type

event clicked;//dec{5} lc_avgcost, lc_chk_cost
//dec{4} lc_convqty
//dec{4} lc_bgqt
//dec{0} lc_bgat, lc_usat9
//long ll_cnt, ll_rowcnt
//string ls_plant, ls_dvsn, ls_itno
//
//setpointer(hourglass!)
//
//ll_rowcnt = dw_3.rowcount()
//for ll_cnt = 1 to ll_rowcnt
//	ls_plant = dw_3.getitemstring(ll_cnt,"wbplant")
//	ls_dvsn = dw_3.getitemstring(ll_cnt,"wbdvsn")
//	ls_itno = dw_3.getitemstring(ll_cnt,"wbitno")
//	lc_avgcost = dw_3.getitemdecimal(ll_cnt,"wbavrg1")
//	lc_bgqt = dw_3.getitemdecimal(ll_cnt,"wbbgqt")
//	lc_bgat = dw_3.getitemdecimal(ll_cnt,"wbbgat1")
//	
//	select convqty into :lc_convqty
//	from pbinv.inv101
//	where comltd = '01' and xplant = :ls_plant and
//			div = :ls_dvsn and itno = :ls_itno
//	using sqlca;
//	
//	lc_avgcost = lc_avgcost / lc_convqty
//	
//	if lc_avgcost = 0 then
//		messagebox("에러1", "품번 : " + ls_itno)
//		return -1
//	end if
//	
//	select wbavrg1, wbusat9 into :lc_chk_cost, :lc_usat9
//	from pbwip.wip002
//	where wbcmcd = '01' and wbplant = :ls_plant and
//			wbdvsn = :ls_dvsn and wbitno = :ls_itno and
//			wbyear = '2011' and wbmonth = '12' and
//			wbiocd = '1'
//	using sqlca;
//	
//	if lc_usat9 <> 0 or lc_chk_cost <> 0 then
//		messagebox("에러 금액, 단가가 있음", "품번 : " + ls_itno)
//	end if
//	
//	select wbbgqt into :lc_bgqt
//	from pbwip.wip002
//	where wbcmcd = '01' and wbplant = :ls_plant and
//			wbdvsn = :ls_dvsn and wbitno = :ls_itno and
//			wbyear = '2012' and wbmonth = '01' and
//			wbiocd = '1'
//	using sqlca;
//	
//	lc_usat9 = lc_bgqt * lc_avgcost
//	update pbwip.wip002
//	set wbavrg1 = :lc_avgcost, wbbgat1 = :lc_usat9, wbupdtdt = '20120113'
//	where wbcmcd = '01' and wbplant = :ls_plant and
//			wbdvsn = :ls_dvsn and wbitno = :ls_itno and
//			wbyear = '2012' and wbmonth = '01' and
//			wbiocd = '1'
//	using sqlca;
//	if sqlca.sqlnrows < 1 then
//		messagebox("에러3", "품번 : " + ls_itno)
//		return -1
//	end if
//	
//	lc_usat9 = (-1) * lc_usat9
//	
//	update pbwip.wip002
//	set wbavrg1 = :lc_avgcost, wbusat9 = :lc_usat9, wbupdtdt = '20120113'
//	where wbcmcd = '01' and wbplant = :ls_plant and
//			wbdvsn = :ls_dvsn and wbitno = :ls_itno and
//			wbyear = '2011' and wbmonth = '12' and
//			wbiocd = '1'
//	using sqlca;
//	if sqlca.sqlnrows < 1 then
//		messagebox("에러4", "품번 : " + ls_itno)
//		return -1
//	end if
//	
//next
end event

type dw_3 from datawindow within w_wip060i
integer x = 82
integer y = 696
integer width = 1650
integer height = 588
boolean bringtotop = true
string dataobject = "d_wip060i_05"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_wip060i
integer x = 3525
integer y = 1204
integer width = 933
integer height = 400
integer taborder = 110
boolean bringtotop = true
string title = "none"
string dataobject = "d_test_wip002"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_wip060i
integer x = 91
integer y = 516
integer width = 590
integer height = 112
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "엑셀파일 찾기"
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
dw_3.ReSet()

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
ll_rtn = dw_3.ImportFile(ls_name, 2) 
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

st_daesang.text = string(dw_3.rowcount())
end event

type cb_2 from commandbutton within w_wip060i
integer x = 3671
integer y = 652
integer width = 567
integer height = 112
integer taborder = 170
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "LowLevel실행"
end type

event clicked;string ls_cmcd,ls_plant, ls_dvsn, ls_itno, ls_todt, ls_fromdt, ls_mysql
integer ll_count

ls_cmcd = '01'
ls_plant = sle_plant.text
ls_dvsn = sle_dvsn.text
ls_itno = sle_itno.text
em_1.getdata(ls_todt)

if f_dateedit(ls_todt) = space(8) then
	uo_status.st_message.text = "날짜를 입력하십시요"
	return 0
end if

ls_fromdt = mid(ls_todt,1,6) + '01'

if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 or f_spacechk(ls_itno) = -1 then
	uo_status.st_message.text = "지역,공장,품번을 확인바랍니다."
	return 0
end if

setpointer(hourglass!)

select count(*) into :ll_count from pbpdm.bom001
where pcmcd = :ls_cmcd AND plant = :ls_plant AND
		pdvsn = :ls_dvsn AND ppitn = :ls_itno AND
		(( pedte = ' '  and pedtm <= :ls_todt ) or
		( pedte <> ' ' and pedtm <= :ls_todt and pedte >= :ls_todt ));
if sqlca.sqlcode <> 0 or ll_count < 1 then
	uo_status.st_message.text = "BOM을 확인바랍니다."
	return -1
end if

DECLARE up_wip_15 PROCEDURE FOR PBWIP.SP_WIP_15  
	A_COMLTD = :ls_cmcd,   
	A_PLANT = :ls_plant,   
	A_DVSN = :ls_dvsn,   
	A_PITNO = :ls_itno,
	A_FROMDATE = :ls_fromdt,
	A_TODATE = :ls_todt,   
	A_CHK = 'A'  using sqlca;
execute up_wip_15;

if sqlca.sqlcode = 0 or sqlca.sqlcode = 100 then
	select count(*) into :ll_count from qtemp.bomtemp01
	using sqlca;
end if
//DELETE TEMP TABLE
ls_mysql = " DROP TABLE QTEMP.BOMTEMP01"
Execute Immediate :ls_mysql using sqlca;

uo_status.st_message.text = "공장 : " + ls_plant + " : " + ls_dvsn + " : " + ls_itno + " | " + string(ll_count)
end event

type st_3 from statictext within w_wip060i
integer x = 1952
integer y = 652
integer width = 197
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "지역:"
boolean focusrectangle = false
end type

type sle_plant from singlelineedit within w_wip060i
integer x = 2149
integer y = 652
integer width = 146
integer height = 112
integer taborder = 70
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_wip060i
integer x = 2345
integer y = 652
integer width = 215
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공장:"
boolean focusrectangle = false
end type

type sle_dvsn from singlelineedit within w_wip060i
integer x = 2537
integer y = 652
integer width = 146
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_wip060i
integer x = 2697
integer y = 652
integer width = 215
integer height = 64
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "공장:"
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within w_wip060i
integer x = 2889
integer y = 652
integer width = 736
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_wip060i
integer x = 146
integer y = 1456
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

type st_daesang from statictext within w_wip060i
integer x = 471
integer y = 1440
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

type st_55 from statictext within w_wip060i
integer x = 960
integer y = 1452
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

type st_saeng from statictext within w_wip060i
integer x = 1280
integer y = 1436
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

type sle_1 from singlelineedit within w_wip060i
integer x = 699
integer y = 528
integer width = 1042
integer height = 92
integer taborder = 40
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

type cb_3 from commandbutton within w_wip060i
integer x = 1911
integer y = 1104
integer width = 1385
integer height = 104
integer taborder = 120
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "업체전품목 재공 이관작업"
end type

event clicked;//string l_s_unit, l_s_cls, l_s_srce, l_s_pdcd, l_s_itnm, l_s_spec, l_s_rvno
//string ls_plant, ls_dvsn, ls_orct, ls_itno, ls_remk, ls_srno
//dec{4} ld_qty, ld_amt
//
//setpointer(hourglass!)
//
//ls_itno = ''
//ls_remk = "업체변경건(D0502에서D4243)"
//DO WHILE TRUE
//	select a.wbplant,a.wbdvsn,a.wborct,a.wbitno,a.wbbgqt,a.wbbgat1
//	into :ls_plant, :ls_dvsn, :ls_orct, :ls_itno, :ld_qty, :ld_amt
//	 from pbwip.wip002 a
//	 where a.wbcmcd = '01' and a.wbplant = 'D' and a.wbdvsn = 'A' and
//	 	a.wborct = 'D0502' and a.wbiocd = '2' and wbyear = '2012' and wbmonth = '01' and
//		a.wbbgqt <> 0 and a.wbitno > :ls_itno
//	order by a.wbitno
//	fetch first 1 row only
//	using sqlca;
//	
//	if sqlca.sqlcode <> 0 then
//		exit
//	end if
//	
//	select a.itnm, a.spec, a.rvno, b.cls, b.srce, substring(b.pdcd,1,2), b.xunit
//	into :l_s_itnm, :l_s_spec, :l_s_rvno, :l_s_cls,:l_s_srce,:l_s_pdcd,:l_s_unit
//	from pbinv.inv002 a inner join pbinv.inv101 b
//		on a.comltd = b.comltd and a.itno = b.itno
//	where b.comltd = '01' and b.xplant = :ls_plant and
//			b.div = :ls_dvsn and b.itno = :ls_itno
//	using sqlca;
//	
//	ls_srno = f_wip_get_serialno(g_s_company)
//	
//	if ls_srno = '0' then
//		uo_status.st_message.text = "전산번호가져오기 실패!"
//		return -1
//	end if
//	
//	// 우신실업 생관수량조정
//	//조정(기타)수량 Update
//	update pbwip.wip002 
//		set wbusqt8 = wbusqt8 + :ld_qty
//	where wbcmcd = '01' and wbplant = :ls_plant and 
//		wbdvsn = :ls_dvsn and wborct = 'D0502' and wbiocd = '2' and
//		wbitno = :ls_itno and wbyear = '2012' and wbmonth = '01'
//	using sqlca;
//	 
//	//기말 재공 Update
//	update pbwip.wip002 
//		set wbbgqt  = wbbgqt - :ld_qty
//	where wbcmcd = '01' and wbplant = :ls_plant and 
//		wbdvsn = :ls_dvsn and wborct = 'D0502' and wbiocd = '2' and
//		wbitno = :ls_itno and wbyear = '2012' and wbmonth = '02'
//	using sqlca;	 
//
//	insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, wddesc, wdspec,   
//	wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, 
//	wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   
//	wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
//	values ('01', 'WX', :ls_srno, :ls_plant, :ls_dvsn, '2', :ls_itno, :l_s_rvno, :l_s_itnm, :l_s_spec, 
//	:l_s_unit, :l_s_cls, :l_s_srce, '08',   :l_s_pdcd, ' ',    ' ',      ' ',      ' ',       ' ',       ' ',    
//	' ', 'D0502', '20120131', 0,      :ld_qty, 
//	:g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, :g_s_datetime, ' ') 
//	using sqlca;
//	
//	if sqlca.sqlcode <> 0 then
//		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
//		return -1
//	end if
//	
//	insert into pbwip.wip005 (wecmcd, weslty, wesrno,    weremk)
//	values (:g_s_company, 'WX',   :ls_srno, :ls_remk) 
//	using sqlca;
//	
//	if sqlca.sqlcode <> 0 then
//		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
//		return -1
//	end if
//	
//	// 범일산업 생관수량조정
//	ls_srno = f_wip_get_serialno(g_s_company)
//	
//	if ls_srno = '0' then
//		uo_status.st_message.text = "전산번호가져오기 실패!"
//		return -1
//	end if
//	
//	ld_qty = -1 * ld_qty
//	//조정(기타)수량 Update
//	update pbwip.wip002 
//		set wbusqt8 = wbusqt8 + :ld_qty
//	where wbcmcd = '01' and wbplant = :ls_plant and 
//		wbdvsn = :ls_dvsn and wborct = 'D4243' and wbiocd = '2' and
//		wbitno = :ls_itno and wbyear = '2012' and wbmonth = '01'
//	using sqlca;
//	
//	if sqlca.sqlnrows < 1 then
//		insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
//       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
//       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
//       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
//       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
//       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
//       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
//       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
//       wbmacaddr,wbinptdt,wbupdtdt)
//		select wbcmcd,wbplant,wbdvsn,'D4243',wbitno,
//       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
//       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
//       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
//       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
//       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
//       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
//       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
//       wbmacaddr,wbinptdt,wbupdtdt
//		from pbwip.wip002
//		where wbcmcd = '01' and wbplant = :ls_plant and 
//		wbdvsn = :ls_dvsn and wborct = 'D0502' and wbiocd = '2' and
//		wbitno = :ls_itno and wbyear = '2012' and wbmonth = '01'
//		using sqlca;
//		
//		update pbwip.wip002 
//		set wbusqt8 = wbusqt8 + :ld_qty
//		where wbcmcd = '01' and wbplant = :ls_plant and 
//			wbdvsn = :ls_dvsn and wborct = 'D4243' and wbiocd = '2' and
//			wbitno = :ls_itno and wbyear = '2012' and wbmonth = '01'
//		using sqlca;
//	end if
//	 
//	//기말 재공 Update
//	update pbwip.wip002 
//		set wbbgqt  = wbbgqt - :ld_qty
//	where wbcmcd = '01' and wbplant = :ls_plant and 
//		wbdvsn = :ls_dvsn and wborct = 'D4243' and wbiocd = '2' and
//		wbitno = :ls_itno and wbyear = '2012' and wbmonth = '02'
//	using sqlca;	 
//	
//	if sqlca.sqlnrows < 1 then
//		insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
//       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
//       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
//       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
//       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
//       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
//       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
//       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
//       wbmacaddr,wbinptdt,wbupdtdt)
//		select wbcmcd,wbplant,wbdvsn,'D4243',wbitno,
//       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
//       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
//       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
//       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
//       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
//       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
//       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
//       wbmacaddr,wbinptdt,wbupdtdt
//		from pbwip.wip002
//		where wbcmcd = '01' and wbplant = :ls_plant and 
//		wbdvsn = :ls_dvsn and wborct = 'D0502' and wbiocd = '2' and
//		wbitno = :ls_itno and wbyear = '2012' and wbmonth = '02'
//		using sqlca;
//		
//		update pbwip.wip002 
//			set wbbgqt  = wbbgqt - :ld_qty
//		where wbcmcd = '01' and wbplant = :ls_plant and 
//			wbdvsn = :ls_dvsn and wborct = 'D4243' and wbiocd = '2' and
//			wbitno = :ls_itno and wbyear = '2012' and wbmonth = '02'
//		using sqlca;	 
//	end if
//	
//	insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, wddesc, wdspec,   
//	wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, 
//	wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   
//	wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
//	values ('01', 'WX', :ls_srno, :ls_plant, :ls_dvsn, '2', :ls_itno, :l_s_rvno, :l_s_itnm, :l_s_spec, 
//	:l_s_unit, :l_s_cls, :l_s_srce, '08',   :l_s_pdcd, ' ',    ' ',      ' ',      ' ',       ' ',       ' ',    
//	' ', 'D4243', '20120131', 0,      :ld_qty, 
//	:g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, :g_s_datetime, ' ') 
//	using sqlca;
//	
//	if sqlca.sqlcode <> 0 then
//		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
//		return -1
//	end if
//	
//	insert into pbwip.wip005 (wecmcd, weslty, wesrno,    weremk)
//	values (:g_s_company, 'WX',   :ls_srno, :ls_remk) 
//	using sqlca;
//	
//	if sqlca.sqlcode <> 0 then
//		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
//		return -1
//	end if
//LOOP
//
//uo_status.st_message.text = "처리되었습니다."
//return 0
end event

type cb_5 from commandbutton within w_wip060i
integer x = 955
integer y = 1628
integer width = 704
integer height = 112
integer taborder = 130
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "유상재공업데이트"
end type

event clicked;dec{5} lc_avgcost, lc_costav
dec{4} lc_convqty
dec{4} lc_bgqt, lc_inqt, lc_usqt, lc_bgqt2
dec{0} lc_bgat, lc_usat9, lc_inat, lc_usat, lc_bgat2
long ll_cnt, ll_rowcnt
string ls_plant, ls_dvsn, ls_itno, ls_year, ls_month, ls_iocd, ls_orct, ls_addmonth, ls_year2, ls_month2

setpointer(hourglass!)

ll_rowcnt = dw_3.rowcount()

//if ll_rowcnt > 0 then
//	ls_year = dw_3.getitemstring(1,"wbyear")
//	ls_month = dw_3.getitemstring(1,"wbmonth")
//	ls_plant = dw_3.getitemstring(1,"wbplant")
//	ls_dvsn = dw_3.getitemstring(1,"wbdvsn")
//	
//	update pbwip.wip014
//	set wbbgqt = 0, wbbgat1 = 0, wbupdtdt = '20120207'
//	where wbcmcd = '01' and wbplant = :ls_plant and
//			wbdvsn = :ls_dvsn and wbyear = :ls_year and 
//			wbmonth = :ls_month and wbiocd = '3'	
// 	using sqlca;
//end if

for ll_cnt = 1 to ll_rowcnt
	ls_year = dw_3.getitemstring(ll_cnt,"wbyear")
	ls_month = dw_3.getitemstring(ll_cnt,"wbmonth")
	ls_plant = dw_3.getitemstring(ll_cnt,"wbplant")
	ls_dvsn = dw_3.getitemstring(ll_cnt,"wbdvsn")
	ls_itno = dw_3.getitemstring(ll_cnt,"wbitno")
	ls_orct = dw_3.getitemstring(ll_cnt,"wbspec") + '%'
	lc_bgqt = dw_3.getitemdecimal(ll_cnt,"wbbgqt")
	lc_bgat = dw_3.getitemdecimal(ll_cnt,"wbbgat1")
	
	select vsrno into :ls_orct
	from pbpur.pur101
	where comltd = '01' and vndnm like :ls_orct
	ORDER BY VNDNM ASC
	FETCH FIRST 1 ROW ONLY
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		dw_3.setitem(ll_cnt,"wbdesc","업체정보 미등록 ")
		continue
	end if
	
	select convqty, costav into :lc_convqty, :lc_costav
	from pbinv.inv101
	where comltd = '01' and xplant = :ls_plant and
			div = :ls_dvsn and itno = :ls_itno
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		lc_convqty = 1
		dw_3.setitem(ll_cnt,"wbdesc","품목상세 미존재 품번")
		continue
	else
		if lc_convqty = 0 then lc_convqty = 1
	end if
	
	select wbavrg1, wbinqt, (wbusqt1 + wbusqt2 + wbusqt3 + wbusqt4 + wbusqt5 +
			wbusqt6 + wbusqt7 + wbusqt8 + wbusqta),
			(wbinat1 + wbinat2 + wbinat3),
			(wbusat1 + wbusat2 + wbusat3 + wbusat4 + wbusat5 +
			wbusat6 + wbusat7 + wbusat8 + wbusata)
	into :lc_avgcost, :lc_inqt, :lc_usqt, :lc_inat, :lc_usat
	from pbwip.wip002
	where wbcmcd = '01' and wbplant = :ls_plant and
			wbdvsn = :ls_dvsn and wbitno = :ls_itno and
			wbyear = :ls_year and wbmonth = :ls_month and
			wborct = :ls_orct and wbiocd = '3'
	using sqlca;
	
	lc_bgqt = lc_bgqt * lc_convqty
	lc_bgqt2 = lc_bgqt + lc_inqt - lc_usqt
	lc_bgat2 = lc_bgqt2 * lc_avgcost
	lc_usat9 = lc_bgat + lc_inat - (lc_usat + lc_bgat2)
	
	update pbwip.wip002
	set wbbgqt = :lc_bgqt, wbbgat1 = :lc_bgat, wbusat9 = :lc_usat9, wbupdtdt = '20120207'
	where wbcmcd = '01' and wbplant = :ls_plant and
			wbdvsn = :ls_dvsn and wbitno = :ls_itno and
			wbyear = :ls_year and wbmonth = :ls_month and
			wborct = :ls_orct and wbiocd = '3'
	using sqlca;
	if sqlca.sqlnrows < 1 then
		insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
			 wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
			 wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
			 wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
			 wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
			 wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
			 wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
			 wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
			 wbmacaddr,wbinptdt,wbupdtdt)
		select aa.comltd,aa.xplant,aa.div,:ls_orct,aa.itno,
			 :ls_year,:ls_month,bb.rvno,'3',aa.cls,aa.srce,substring(aa.pdcd,1,2),
			 aa.xunit,bb.xtype,bb.itnm,bb.spec,0,0,:lc_costav,
			 0,:lc_bgqt, :lc_bgat,
			 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
			 0,0,0,0,0,' ','','','20120207',''
		from pbinv.inv101 aa inner join pbinv.inv002 bb
			on aa.comltd = bb.comltd and aa.itno = bb.itno
		where aa.comltd = '01' and aa.xplant = :ls_plant and
			aa.div = :ls_dvsn and aa.itno = :ls_itno
		using sqlca;
		if sqlca.sqlcode <> 0 then
			dw_3.setitem(ll_cnt,"wbdesc","유상사급재공 입력 에러 품번")
		end if
	end if
	
//	ls_addmonth = f_relative_month(ls_year + ls_month,1)
//	ls_year2 = mid(ls_addmonth,1,4)
//	ls_month2 = mid(ls_addmonth,5,2)
//	update pbwip.wip002
//	set wbbgqt = :lc_bgqt2, wbbgat1 = :lc_bgat2, wbupdtdt = '20120207'
//	where wbcmcd = '01' and wbplant = :ls_plant and
//			wbdvsn = :ls_dvsn and wbitno = :ls_itno and
//			wbyear = :ls_year2 and wbmonth = :ls_month2 and
//			wborct = :ls_orct and wbiocd = '3'
//	using sqlca;
//	if sqlca.sqlnrows < 1 then
//		dw_3.setitem(ll_cnt,"wbdesc","WIP002 이월 업데이트 에러")
//	end if
next

uo_status.st_message.text = "정상적으로 처리되었습니다."

return 0
end event

type pb_1 from picturebutton within w_wip060i
integer x = 923
integer y = 1292
integer width = 251
integer height = 120
integer taborder = 120
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string text = "DOWN"
boolean originalsize = true
alignment htextalign = left!
end type

event clicked;f_save_to_excel(dw_3)
end event

type st_6 from statictext within w_wip060i
integer x = 87
integer y = 1952
integer width = 338
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "작업시간:"
boolean focusrectangle = false
end type

type sle_fromdt from singlelineedit within w_wip060i
integer x = 485
integer y = 1940
integer width = 809
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_todt from singlelineedit within w_wip060i
integer x = 485
integer y = 2064
integer width = 809
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_6 from commandbutton within w_wip060i
integer x = 297
integer y = 2240
integer width = 901
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "일일결산 표준재료비 계산"
end type

event clicked;string ls_curtime

setpointer(hourglass!)

SELECT CAST(CURRENT TIME AS VARCHAR(10)) 
into :ls_curtime
FROM PBCOMMON.COMM000
using sqlca;
sle_fromdt.text = ls_curtime

//일일결산용 전공장 재료비계산 호출
DECLARE SP_BOM_002 PROCEDURE FOR PBPDM.SP_BOM_002  
         A_COMLTD = '01',   
         A_APPLYDATE = :g_s_date,   
         A_CREATEDATE = :g_s_date,   
         A_CHK = 'C'  
			using sqlca;

execute SP_BOM_002;
//
// 일일결산용 공장별 재료비계산 호출
// DECLARE SP_BOM_001 PROCEDURE FOR PBPDM.SP_BOM_001  
//         A_COMLTD = '01',   
//         A_PLANT = 'D',   
//         A_DVSN = 'V',   
//         A_APPLYDATE = '20120321',   
//         A_CREATEDATE = '20120321',   
//         A_CHK = 'C'  
//		using sqlca;
//
//execute SP_BOM_001;

SELECT CAST(CURRENT TIME AS VARCHAR(10))
into :ls_curtime
FROM PBCOMMON.COMM000
using sqlca;
sle_todt.text = ls_curtime

end event

type cb_7 from commandbutton within w_wip060i
integer x = 1911
integer y = 1232
integer width = 1385
integer height = 104
integer taborder = 130
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "업체품목(dw_3) 재공이관작업_wip002"
end type

event clicked;string l_s_unit, l_s_cls, l_s_srce, l_s_pdcd, l_s_itnm, l_s_spec, l_s_rvno, ls_applydate
string ls_plant, ls_dvsn, ls_orct, ls_new_orct, ls_itno, ls_remk, ls_srno, ls_year, ls_month
dec{4} ld_qty, ld_amt
long ll_cnt, ll_rowcnt

setpointer(hourglass!)

ls_itno = ''
ls_remk = "업체변경건(D0502에서D4243)"

setpointer(hourglass!)

ll_rowcnt = dw_3.rowcount()

ls_applydate = '20120131'
ls_new_orct = 'D4243'
for ll_cnt = 1 to ll_rowcnt
	ls_year = dw_3.getitemstring(ll_cnt,"wbyear")
	ls_month = dw_3.getitemstring(ll_cnt,"wbmonth")
	ls_plant = dw_3.getitemstring(ll_cnt,"wbplant")
	ls_dvsn = dw_3.getitemstring(ll_cnt,"wbdvsn")
	ls_itno = dw_3.getitemstring(ll_cnt,"wbitno")
	ls_orct = trim(dw_3.getitemstring(ll_cnt,"wbspec"))
	
	ld_qty = 0
	ld_amt = 0
	
	select a.wbplant,a.wbdvsn,a.wborct,a.wbitno,a.wbbgqt,a.wbbgat1
	into :ls_plant, :ls_dvsn, :ls_orct, :ls_itno, :ld_qty, :ld_amt
	 from pbwip.wip002 a
	 where a.wbcmcd = '01' and a.wbplant = :ls_plant and a.wbdvsn = :ls_dvsn and
	 	a.wborct = :ls_orct and a.wbiocd = '2' and wbyear = :ls_year and wbmonth = :ls_month and
		a.wbbgqt <> 0 and a.wbitno = :ls_itno
	using sqlca;
	
	
	select a.itnm, a.spec, a.rvno, b.cls, b.srce, substring(b.pdcd,1,2), b.xunit
	into :l_s_itnm, :l_s_spec, :l_s_rvno, :l_s_cls,:l_s_srce,:l_s_pdcd,:l_s_unit
	from pbinv.inv002 a inner join pbinv.inv101 b
		on a.comltd = b.comltd and a.itno = b.itno
	where b.comltd = '01' and b.xplant = :ls_plant and
			b.div = :ls_dvsn and b.itno = :ls_itno
	using sqlca;
	
	ls_srno = f_wip_get_serialno(g_s_company)
	
	if ls_srno = '0' then
		uo_status.st_message.text = "전산번호가져오기 실패!"
		return -1
	end if
	
	// 변경전업체 생관수량조정
	//조정(기타)수량 Update
	update pbwip.wip002 
		set wbusqt8 = wbusqt8 + :ld_qty
	where wbcmcd = '01' and wbplant = :ls_plant and 
		wbdvsn = :ls_dvsn and wborct = :ls_orct and wbiocd = '2' and
		wbitno = :ls_itno and wbyear = :ls_year and wbmonth = :ls_month
	using sqlca;
	 
	//기말 재공 Update
	update pbwip.wip002 
		set wbbgqt  = wbbgqt - :ld_qty
	where wbcmcd = '01' and wbplant = :ls_plant and 
		wbdvsn = :ls_dvsn and wborct = :ls_orct and wbiocd = '2' and
		wbitno = :ls_itno and wbyear = :ls_year and wbmonth = :ls_month
	using sqlca;	 

	insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, wddesc, wdspec,   
	wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, 
	wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   
	wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
	values ('01', 'WX', :ls_srno, :ls_plant, :ls_dvsn, '2', :ls_itno, :l_s_rvno, :l_s_itnm, :l_s_spec, 
	:l_s_unit, :l_s_cls, :l_s_srce, '08',   :l_s_pdcd, ' ',    ' ',      ' ',      ' ',       ' ',       ' ',    
	' ', :ls_orct, :ls_applydate, 0,      :ld_qty, 
	:g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, :g_s_datetime, ' ') 
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
		return -1
	end if
	
	insert into pbwip.wip005 (wecmcd, weslty, wesrno,    weremk)
	values (:g_s_company, 'WX',   :ls_srno, :ls_remk) 
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
		return -1
	end if
	
	// 이동후 업체 생관수량조정
	ls_srno = f_wip_get_serialno(g_s_company)
	
	if ls_srno = '0' then
		uo_status.st_message.text = "전산번호가져오기 실패!"
		return -1
	end if
	
	ld_qty = -1 * ld_qty
	//조정(기타)수량 Update
	update pbwip.wip002 
		set wbusqt8 = wbusqt8 + :ld_qty
	where wbcmcd = '01' and wbplant = :ls_plant and 
		wbdvsn = :ls_dvsn and wborct = :ls_new_orct and wbiocd = '2' and
		wbitno = :ls_itno and wbyear = :ls_year and wbmonth = :ls_month
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
       wbmacaddr,wbinptdt,wbupdtdt)
		select wbcmcd,wbplant,wbdvsn,:ls_new_orct,wbitno,
       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
       wbmacaddr,wbinptdt,wbupdtdt
		from pbwip.wip002
		where wbcmcd = '01' and wbplant = :ls_plant and 
		wbdvsn = :ls_dvsn and wborct = :ls_orct and wbiocd = '2' and
		wbitno = :ls_itno and wbyear = :ls_year and wbmonth = :ls_month
		using sqlca;
		
		update pbwip.wip002 
		set wbusqt8 = wbusqt8 + :ld_qty
		where wbcmcd = '01' and wbplant = :ls_plant and 
			wbdvsn = :ls_dvsn and wborct = :ls_new_orct and wbiocd = '2' and
			wbitno = :ls_itno and wbyear = :ls_year and wbmonth = :ls_month
		using sqlca;
	end if
	 
	//기말 재공 Update
	update pbwip.wip002 
		set wbbgqt  = wbbgqt - :ld_qty
	where wbcmcd = '01' and wbplant = :ls_plant and 
		wbdvsn = :ls_dvsn and wborct = :ls_new_orct and wbiocd = '2' and
		wbitno = :ls_itno and wbyear = :ls_year and wbmonth = :ls_month
	using sqlca;	 
	
	if sqlca.sqlnrows < 1 then
		insert into pbwip.wip002(wbcmcd,wbplant,wbdvsn,wborct,wbitno,
       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
       wbmacaddr,wbinptdt,wbupdtdt)
		select wbcmcd,wbplant,wbdvsn,:ls_new_orct,wbitno,
       wbyear,wbmonth,wbrev,wbiocd,wbitcl,wbsrce,wbpdcd,
       wbunit,wbtype,wbdesc,wbspec,wbscrp,wbretn,wbavrg1,
       wbavrg2,wbbgqt,wbbgat1,wbbgat2,wbinqt,wbinat1,
       wbinat2,wbinat3,wbinat4,wbusqt1,wbusat1,wbusqt2,
       wbusat2,wbusqt3,wbusat3,wbusqt4,wbusat4,wbusqt5,
       wbusat5,wbusqt6,wbusat6,wbusqt7,wbusat7,wbusqt8,
       wbusat8,wbusat9,wbusqta,wbusata,wbplan,wbipaddr,
       wbmacaddr,wbinptdt,wbupdtdt
		from pbwip.wip002
		where wbcmcd = '01' and wbplant = :ls_plant and 
		wbdvsn = :ls_dvsn and wborct = :ls_orct and wbiocd = '2' and
		wbitno = :ls_itno and wbyear = :ls_year and wbmonth = :ls_month
		using sqlca;
		
		update pbwip.wip002 
			set wbbgqt  = wbbgqt - :ld_qty
		where wbcmcd = '01' and wbplant = :ls_plant and 
			wbdvsn = :ls_dvsn and wborct = :ls_new_orct and wbiocd = '2' and
			wbitno = :ls_itno and wbyear = :ls_year and wbmonth = :ls_month
		using sqlca;	 
	end if
	
	insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, wddesc, wdspec,   
	wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, 
	wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   
	wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
	values ('01', 'WX', :ls_srno, :ls_plant, :ls_dvsn, '2', :ls_itno, :l_s_rvno, :l_s_itnm, :l_s_spec, 
	:l_s_unit, :l_s_cls, :l_s_srce, '08',   :l_s_pdcd, ' ',    ' ',      ' ',      ' ',       ' ',       ' ',    
	' ', :ls_new_orct, :ls_applydate, 0,      :ld_qty, 
	:g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, :g_s_datetime, ' ') 
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
		return -1
	end if
	
	insert into pbwip.wip005 (wecmcd, weslty, wesrno,    weremk)
	values (:g_s_company, 'WX',   :ls_srno, :ls_remk) 
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
		return -1
	end if
next

uo_status.st_message.text = "처리되었습니다."
return 0
end event

type cb_8 from commandbutton within w_wip060i
integer x = 1911
integer y = 1376
integer width = 1385
integer height = 104
integer taborder = 140
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "업체품목(dw_3) 재공이관작업_wip001"
end type

event clicked;string l_s_unit, l_s_cls, l_s_srce, l_s_pdcd, l_s_itnm, l_s_spec, l_s_rvno, ls_applydate
string ls_plant, ls_dvsn, ls_orct, ls_new_orct, ls_itno, ls_remk, ls_srno, ls_year, ls_month
dec{4} ld_qty, ld_amt
long ll_cnt, ll_rowcnt

setpointer(hourglass!)

ls_itno = ''
ls_remk = "업체변경건(대현정기 D0494에서 다인DS D4314)"

setpointer(hourglass!)

ll_rowcnt = dw_3.rowcount()

ls_applydate = '20120920'
ls_new_orct = 'D4314'
for ll_cnt = 1 to ll_rowcnt
	ls_year = dw_3.getitemstring(ll_cnt,"wbyear")
	ls_month = dw_3.getitemstring(ll_cnt,"wbmonth")
	ls_plant = dw_3.getitemstring(ll_cnt,"wbplant")
	ls_dvsn = dw_3.getitemstring(ll_cnt,"wbdvsn")
	ls_itno = dw_3.getitemstring(ll_cnt,"wbitno")
	ls_orct = trim(dw_3.getitemstring(ll_cnt,"wbspec"))
	ld_qty = 0
	ld_amt = 0

	select a.waplant,a.wadvsn,a.waorct,a.waitno,a.waohqt,a.waohat1
	into :ls_plant, :ls_dvsn, :ls_orct, :ls_itno, :ld_qty, :ld_amt
	 from pbwip.wip001 a
	 where a.wacmcd = '01' and a.waplant = :ls_plant and a.wadvsn = :ls_dvsn and
	 	a.waorct = :ls_orct and a.waiocd = '2' and
		a.waitno = :ls_itno
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		continue
	end if;
	
	select a.itnm, a.spec, a.rvno, b.cls, b.srce, substring(b.pdcd,1,2), b.xunit
	into :l_s_itnm, :l_s_spec, :l_s_rvno, :l_s_cls,:l_s_srce,:l_s_pdcd,:l_s_unit
	from pbinv.inv002 a inner join pbinv.inv101 b
		on a.comltd = b.comltd and a.itno = b.itno
	where b.comltd = '01' and b.xplant = :ls_plant and
			b.div = :ls_dvsn and b.itno = :ls_itno
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		messagebox("품번에러", "미등록 품번 : " + ls_itno)
		continue
	end if
	
	ls_srno = f_wip_get_serialno(g_s_company)
	
	if ls_srno = '0' then
		uo_status.st_message.text = "전산번호가져오기 실패!"
		return -1
	end if
	
	// 변경전업체 생관수량조정
	//조정(기타)수량 Update
	update pbwip.wip001 
		set wausqt8 = wausqt8 + :ld_qty
	where wacmcd = '01' and waplant = :ls_plant and 
		wadvsn = :ls_dvsn and waorct = :ls_orct and waiocd = '2' and
		waitno = :ls_itno
	using sqlca;
	
	//기말 재공 Update
	update pbwip.wip001 
		set waohqt  = waohqt - :ld_qty
	where wacmcd = '01' and waplant = :ls_plant and 
		wadvsn = :ls_dvsn and waorct = :ls_orct and waiocd = '2' and
		waitno = :ls_itno
	using sqlca;	 

	insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, wddesc, wdspec,   
	wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, 
	wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   
	wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
	values ('01', 'WX', :ls_srno, :ls_plant, :ls_dvsn, '2', :ls_itno, :l_s_rvno, :l_s_itnm, :l_s_spec, 
	:l_s_unit, :l_s_cls, :l_s_srce, '08',   :l_s_pdcd, ' ',    ' ',      ' ',      ' ',       ' ',       ' ',    
	' ', :ls_orct, :ls_applydate, 0,      :ld_qty, 
	:g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, :g_s_datetime, ' ') 
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
		return -1
	end if
	
	insert into pbwip.wip005 (wecmcd, weslty, wesrno,    weremk)
	values (:g_s_company, 'WX',   :ls_srno, :ls_remk) 
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
		return -1
	end if
	
	// 이동후 업체 생관수량조정
	ls_srno = f_wip_get_serialno(g_s_company)
	
	if ls_srno = '0' then
		uo_status.st_message.text = "전산번호가져오기 실패!"
		return -1
	end if
	
	ld_qty = -1 * ld_qty
	//조정(기타)수량 Update
	update pbwip.wip001 
		set wausqt8 = wausqt8 + :ld_qty
	where wacmcd = '01' and waplant = :ls_plant and 
		wadvsn = :ls_dvsn and waorct = :ls_new_orct and waiocd = '2' and
		waitno = :ls_itno
	using sqlca;
	
	if sqlca.sqlnrows < 1 then
		insert into pbwip.wip001(wacmcd,waplant,wadvsn,waorct,
		  waitno,waiocd,waavrg1,waavrg2,wabgqt,wabgat1,wabgat2,
		  wainqt,wainat1,wainat2,wainat3,wainat4,wausqt1,wausat1,
		  wausqt2,wausat2,wausqt3,wausat3,wausqt4,wausat4,
		  wausqt5,wausat5,wausqt6,wausat6,wausqt7,wausat7,
		  wausqt8,wausat8,wausat9,waohqt,waohat1,waohat2,wascrp,
		  waretn,waplan,waipaddr,wamacaddr,wainptdt,waupdtdt)
		select wacmcd,waplant,wadvsn,:ls_new_orct,
		  waitno,waiocd,waavrg1,waavrg2,wabgqt,wabgat1,wabgat2,
		  wainqt,wainat1,wainat2,wainat3,wainat4,wausqt1,wausat1,
		  wausqt2,wausat2,wausqt3,wausat3,wausqt4,wausat4,
		  wausqt5,wausat5,wausqt6,wausat6,wausqt7,wausat7,
		  :ld_qty,wausat8,wausat9,0,0,0,wascrp,
        waretn,waplan,waipaddr,wamacaddr,wainptdt,waupdtdt
		from pbwip.wip001
		where wacmcd = '01' and waplant = :ls_plant and 
		wadvsn = :ls_dvsn and waorct = :ls_orct and waiocd = '2' and
		waitno = :ls_itno
		using sqlca;
	end if
	 
	//기말 재공 Update
	update pbwip.wip001 
		set waohqt  = waohqt - :ld_qty
	where wacmcd = '01' and waplant = :ls_plant and 
		wadvsn = :ls_dvsn and waorct = :ls_new_orct and waiocd = '2' and
		waitno = :ls_itno
	using sqlca;	 
	
	insert into pbwip.wip004 (wdcmcd, wdslty, wdsrno, wdplant, wddvsn, wdiocd, wditno, wdrvno, wddesc, wdspec,   
	wdunit,    wditcl,   wdsrce,    wdusge, wdpdcd,    wdslno, wdprsrty, wdprsrno, wdprsrno1, wdprsrno2, 
	wdprno, wdprdpt, wdchdpt,   wddate,    wdprqt, wdchqt,   
	wdipaddr,    wdmacaddr,     wdinptid,  wdupdtid, wdinptdt,  wdinpttm,  wdupdtdt)
	values ('01', 'WX', :ls_srno, :ls_plant, :ls_dvsn, '2', :ls_itno, :l_s_rvno, :l_s_itnm, :l_s_spec, 
	:l_s_unit, :l_s_cls, :l_s_srce, '08',   :l_s_pdcd, ' ',    ' ',      ' ',      ' ',       ' ',       ' ',    
	' ', :ls_new_orct, :ls_applydate, 0,      :ld_qty, 
	:g_s_ipaddr, :g_s_macaddr, :g_s_empno, ' ',      :g_s_date, :g_s_datetime, ' ') 
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
		return -1
	end if
	
	insert into pbwip.wip005 (wecmcd, weslty, wesrno,    weremk)
	values (:g_s_company, 'WX',   :ls_srno, :ls_remk) 
	using sqlca;
	
	if sqlca.sqlcode <> 0 then
		uo_status.st_message.text = "입력시에 에러가 발생하였습니다."
		return -1
	end if
next

uo_status.st_message.text = "처리되었습니다."
return 0
end event

type gb_2 from groupbox within w_wip060i
integer x = 41
integer y = 388
integer width = 1723
integer height = 1408
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "엑셀데이타 업로드"
end type

type gb_1 from groupbox within w_wip060i
integer x = 1856
integer y = 212
integer width = 2427
integer height = 600
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "INV002 LOWLEVEL 생성작업[월말작업]"
end type

type gb_3 from groupbox within w_wip060i
integer x = 41
integer width = 4530
integer height = 192
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within w_wip060i
integer x = 1856
integer y = 888
integer width = 1518
integer height = 636
integer textsize = -12
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "재공수불 BATCH 처리"
end type

