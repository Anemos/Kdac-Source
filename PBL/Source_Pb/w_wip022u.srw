$PBExportHeader$w_wip022u.srw
$PBExportComments$������뷮 ����
forward
global type w_wip022u from w_origin_sheet02
end type
type tab_1 from tab within w_wip022u
end type
type tabpage_1 from userobject within tab_1
end type
type dw_5 from datawindow within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_replist from datawindow within tabpage_1
end type
type dw_2 from datawindow within tabpage_1
end type
type pb_1 from picturebutton within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_5 dw_5
gb_4 gb_4
dw_replist dw_replist
dw_2 dw_2
pb_1 pb_1
end type
type tabpage_2 from userobject within tab_1
end type
type cb_2 from commandbutton within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type gb_5 from groupbox within tabpage_2
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
type dw_3 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_2 cb_2
cb_1 cb_1
gb_5 gb_5
cb_optcancel cb_optcancel
cb_option cb_option
dw_repentry dw_repentry
dw_history dw_history
dw_rephead dw_rephead
dw_3 dw_3
end type
type tabpage_3 from userobject within tab_1
end type
type uo_1 from uo_wip_plandiv within tabpage_3
end type
type dw_4 from datawindow within tabpage_3
end type
type gb_2 from groupbox within tabpage_3
end type
type gb_3 from groupbox within tabpage_3
end type
type gb_1 from groupbox within tabpage_3
end type
type lb_1 from listbox within tabpage_3
end type
type st_7 from statictext within tabpage_3
end type
type st_6 from statictext within tabpage_3
end type
type rb_1 from radiobutton within tabpage_3
end type
type rb_2 from radiobutton within tabpage_3
end type
type st_8 from statictext within tabpage_3
end type
type cb_exec from commandbutton within tabpage_3
end type
type cb_ok from commandbutton within tabpage_3
end type
type st_1 from statictext within tabpage_3
end type
type st_2 from statictext within tabpage_3
end type
type cb_modify from commandbutton within tabpage_3
end type
type tabpage_3 from userobject within tab_1
uo_1 uo_1
dw_4 dw_4
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
lb_1 lb_1
st_7 st_7
st_6 st_6
rb_1 rb_1
rb_2 rb_2
st_8 st_8
cb_exec cb_exec
cb_ok cb_ok
st_1 st_1
st_2 st_2
cb_modify cb_modify
end type
type tab_1 from tab within w_wip022u
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type st_4 from statictext within w_wip022u
end type
type st_5 from statictext within w_wip022u
end type
type uo_pbar from uo_progress_bar within w_wip022u
end type
type st_3 from statictext within w_wip022u
end type
type dw_report from datawindow within w_wip022u
end type
end forward

global type w_wip022u from w_origin_sheet02
integer height = 2668
event ue_incbar ( )
tab_1 tab_1
st_4 st_4
st_5 st_5
uo_pbar uo_pbar
st_3 st_3
dw_report dw_report
end type
global w_wip022u w_wip022u

type variables
integer i_n_tabindex, net, i_n_job
string i_s_plant,i_s_cttp, i_s_dvsn

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

event ue_incbar();long ll_inc

ll_inc = message.longparm
if ll_inc = 99 then
	uo_status.st_message.text = "����Ÿ Uploading..."
end if
uo_pbar.uf_set_position(ll_inc)
end event

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
		case '2'		 //Parent Not Found => ���Ʈ���� ���ڵ� ����
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
					//������ ����(WIP002)
					SELECT WBAVRG1,WBAVRG2,WBUSQT1,WBUSAT1,WBUSQT2,WBUSAT2,WBUSQT3,WBUSAT3,WBUSQT4,WBUSAT4,WBUSQT5,WBUSAT5,
       					 WBUSQT6,WBUSAT6,WBUSQT7,WBUSAT7,WBUSQT8,WBUSAT8,WBUSAT9,WBUSQTA,WBUSATA INTO
							:l_n_wbavrg1,:l_n_wbavrg2,:l_n_wbusqt1,:l_n_wbusat1,:l_n_wbusqt2,:l_n_wbusat2,:l_n_wbusqt3,
							:l_n_wbusat3,:l_n_wbusqt4,:l_n_wbusat4,:l_n_wbusqt5,:l_n_wbusat5,:l_n_wbusqt6,:l_n_wbusat6,
							:l_n_wbusqt7,:l_n_wbusat7,:l_n_wbusqt8,:l_n_wbusat8,:l_n_wbusat9,:l_n_wbusqta,:l_n_wbusata 
						FROM "PBWIP"."WIP002" 
						WHERE WBCMCD = :G_S_COMPANY AND WBPLANT = :ls_plant AND WBDVSN = :ls_dvsn AND 
								WBORCT = :ls_vsrno AND WBITNO = :ls_itno AND WBYEAR||WBMONTH = :ls_adjdate
								USING SQLCA;
					//����� ��������
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
					//������ UPDATE
					update "PBWIP"."WIP002"
						set WBUSQT1 = :l_n_wbusqt1,WBUSAT1 = :l_n_wbusat1,WBUSQT2 = :l_n_wbusqt2,WBUSAT2 = :l_n_wbusat2,
							WBUSQT3 = :l_n_wbusqt3,WBUSAT3 = :l_n_wbusat3,WBUSQT4 = :l_n_wbusqt4,WBUSAT4 = :l_n_wbusat4,
							WBUSQT5 = :l_n_wbusqt5,WBUSAT5 = :l_n_wbusat5,WBUSQT6 = :l_n_wbusqt6,WBUSAT6 = :l_n_wbusat6,
							WBUSQT7 = :l_n_wbusqt7,WBUSAT7 = :l_n_wbusat7,WBUSQT8 = :l_n_wbusqt8,WBUSAT8 = :l_n_wbusat8,
							WBUSAT9 = :l_n_wbusat9,WBUSQTA = :l_n_wbusqta,WBUSATA = :l_n_wbusata
						where WBCMCD = :G_S_COMPANY AND WBPLANT = :ls_plant AND WBDVSN = :ls_dvsn AND 
								WBORCT = :ls_vsrno AND WBITNO = :ls_itno AND WBYEAR||WBMONTH = :ls_adjdate
								using sqlca;
					
					//����� UPDATE
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
			ls_date = arg_dw.getitemstring(li_cntx,"inv401_tdte4")	//������ ��¥
			ls_date2 = arg_dw.getitemstring(li_cntx,"chgdate")     
			lc_qty = arg_dw.getitemdecimal(li_cntx,"inv401_tqty4")	//������ ����
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

public function integer wf_selectcheck (string a_comltd, string a_plant, string a_dvsn, string a_code);//�̿����̰ų� �����Ϸ��� ��쿡�� ��뷮 ������ �Ұ���
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

//����ø����ȣ ��������
ls_serial = f_wip_get_serialno(g_s_company)
if ls_serial = '0' then
	return -1
end if

ls_prsrno1 = ''
ls_prsrno2 = ''
//���Ʈ������ ��뷮���̷��� �ݿ�
lc_diffqty = (arg_dw.getitemdecimal(a_currow,"repqt") - arg_dw.getitemdecimal(a_currow,"chqt")) * arg_convqty
//������ ���� ��¥ ��������
ls_adjdate = f_relativedate(uf_wip_addmonth(st_5.text,1) + '01', -1)

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
		//�����Է� - ����ڵ�Ϲ�ȣ�� �Էµ� ���
		ls_plant = arg_dw.getitemstring(1,"wip001_waplant")
		ls_dvsn = arg_dw.getitemstring(1,"wip001_wadvsn")
		ls_vndr = arg_dw.getitemstring(1,"vndr")
		ls_iocd = arg_dw.getitemstring(1,"wip001_waiocd")
		ls_orct = arg_dw.getitemstring(1,"wip001_waorct")
		if ls_iocd = '2' and f_spacechk(ls_vndr) <> -1 then
			if f_spacechk(ls_orct) = -1 then
				ls_rtnvalue = f_get_vendor01(g_s_company, ls_vndr)
				if ls_rtnvalue <> '' then		//����ڹ�ȣ�� �ԷµȰ��
					arg_dw.setitem(1,"vndnm",mid(ls_rtnvalue,6))
					arg_dw.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
				else
					uo_status.st_message.text = "����ڹ�ȣ�� �ش��ϴ� ��ü�� �����ϴ�."
					return -1
				end if
			end if
		end if
		
		//�̿����̰ų� �����Ϸ��� ��쿡�� ��뷮 ������ �Ұ���
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
			uo_status.st_message.text = "����� �Ϸ�Ǿ����ϴ�."
			return -1
		end if
	case 2
		
	case 3
		
End choose

return 0
end function

public function integer wf_option_update (datawindow arg_dw);string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_adjdate, ls_ohdate, ls_usage, ls_iocd
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
	ls_iocd = arg_dw.getitemstring(li_cntx, "wdiocd")
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
						( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
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
						( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
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
						( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
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
						( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
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
						( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
         			( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
           			using sqlca;
	end choose
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return -1
	end if	
	//�⸻ ��� UPDATE
	UPDATE "PBWIP"."WIP002"  
		SET "WBBGQT" = "WBBGQT" - :lc_qty,
			 "WBBGAT1" = ("WBBGQT" - :lc_qty) * :lc_costav  
		WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
				( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
				( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
				( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
				( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND 
				( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
				( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_ohdate )   
				using sqlca;
	if sqlca.sqlcode <> 0 then
		rollback using sqlca;
		return -1
	end if
next
return 0
end function

public function integer wf_authority_chk ();string ls_cttp, ls_plant, ls_dvsn, ls_rundate, ls_stscd
if i_n_tabindex = 1 then
	ls_plant = tab_1.tabpage_1.dw_2.getitemstring(1,"wip001_waplant")
	ls_dvsn = tab_1.tabpage_1.dw_2.getitemstring(1,"wip001_wadvsn")
	ls_cttp = 'WIP' + ls_dvsn + '050'
end if

if i_n_tabindex = 2 then
	ls_plant = tab_1.tabpage_2.dw_3.getitemstring(1,"wip001_waplant")
	ls_dvsn = tab_1.tabpage_2.dw_3.getitemstring(1,"wip001_wadvsn")
	ls_cttp = 'WIP' + ls_dvsn + '050'
end if

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
	uo_status.st_message.text = f_message("I100")
	return -1
end if

if (mid(g_s_date,1,6) = mid(ls_rundate,1,6)) and ls_stscd = '2' then
	return 0
else
	uo_status.st_message.text = "��뷮������ �Ϸ�� �����Դϴ�."
	return -1
end if
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
		uo_status.st_message.text = "ǰ���̳� ������ �Էµ��� �ʾҽ��ϴ�"
		return -1
	end if
	//���縶��Ÿ���� �������� �������� 
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
		uo_status.st_message.text = ls_itno + " : ��ϵ� ǰ���� �ƴմϴ�"
		return -1
	end if		
	
	//��ǰ�� �˻�
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
		uo_status.st_message.text = ls_itno + " ǰ����  BOM level�� ��ǰ������ ������ �ֽ��ϴ�."
		return -1
	end if
	//���Լ� Check
	if ls_chksrce = '01' or ls_chksrce = '02' then
		uo_status.st_message.text = ls_itno + " ǰ���� ������� ��ǰ���� �ɼ� �����ϴ�."
		return -1
	end if
	
	
	//���ǰ�� �ش��ϴ� ������ ���Լ� Ȯ���ϱ�
   if ls_iocd = '1' then
		if (ls_cls  = "10" or ls_cls  = "40" or ls_cls  = "50") and &
		   (ls_srce = "01" or ls_srce = "02" or ls_srce = "04" or ls_srce = "05" or ls_srce = "06") then
			//PASS
		else
			uo_status.st_message.text = ls_itno + " : ���ǰ�� �ƴմϴ�."
			return -1
		end if
	else
		if (ls_cls = "10" or ls_cls = "20" or ls_cls = "40" or ls_cls = "50") then 
			//PASS
		else
			uo_status.st_message.text = ls_itno + " : ���ǰ�� �ƴմϴ�"
			return -1 
		end if
	end if
	//����̿� DB�� ��������
	 SELECT count(*)  
    INTO :li_cnt  
    FROM "PBWIP"."WIP002"  
   WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         ( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         ( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND 
			( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
         ( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )  using sqlca;

	if sqlca.sqlcode <> 0 or li_cnt < 1 then
		uo_status.st_message.text = ls_itno + " : ����� ��ϵ� ǰ���� �ƴմϴ�."
		return -1
	end if
	//����ǰ�� �ɼ�ǰ�� ��ġ����
	if ls_itno = ls_preitno then
		uo_status.st_message.text = "ǰ��Ȯ�� �ٶ��ϴ�"
		return -1
	end if
	//�������� üũ
	if (lc_qty = 0) or (lc_preqty < 0 and lc_qty > 0) or (lc_preqty > 0 and lc_qty < 0) then
		uo_status.st_message.text = "����Ȯ�� �ٶ��ϴ�."
		return -1
	end if
	//�������� arg_dw�� �����ϱ�
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

on w_wip022u.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_4=create st_4
this.st_5=create st_5
this.uo_pbar=create uo_pbar
this.st_3=create st_3
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_4
this.Control[iCurrent+3]=this.st_5
this.Control[iCurrent+4]=this.uo_pbar
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.dw_report
end on

on w_wip022u.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.uo_pbar)
destroy(this.st_3)
destroy(this.dw_report)
end on

event open;call super::open;datawindow ldw_01, ldw_02, ldw_03, ldw_04, ldw_05, ldw_06
datawindowchild dwc_01, dwc_02, dwc_03, dwc_04, dwc_05

st_5.text = uf_wip_addmonth(mid(g_s_date,1,6),-1)
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
tab_1.tabpage_1.dw_5.settransobject(sqlca)

ldw_01.getchild("wip001_waplant",dwc_01)
	dwc_01.settransobject(sqlca)
	dwc_01.retrieve('SLE220')
ldw_01.getchild("wip001_wadvsn",dwc_02)
	dwc_02.settransobject(sqlca)
	dwc_02.retrieve('D')
ldw_01.getchild("inv101_pdcd",dwc_05)
	dwc_05.settransobject(sqlca)
	dwc_05.retrieve('A')
	
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

tab_1.tabpage_1.dw_replist.dataobject = "d_wip022u_vndlist"
tab_1.tabpage_1.dw_replist.settransobject(sqlca)
dw_report.dataobject = "d_wip022u_vndreport"
dw_report.settransobject(sqlca)
// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ����, ��, �ݱ�, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(true, false, false, false, false, false, false, false, false, false, false, false)
end event

event ue_retrieve;datawindow ldw_01, ldw_02, ldw_03, ldw_04, ldw_05, ldw_06
string ls_plant, ls_dvsn, ls_itno, ls_orct, ls_iocd, ls_adjdate, ls_rtnvalue, ls_pdcd
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
		//�ʼ��Է� üũ
		ldw_02.reset()
		tab_1.tabpage_1.dw_5.reset()
	 	if f_wip_mandantory_chk(ldw_01) = -1 then							
		 	uo_status.st_message.text = f_message("E010")
			return 0
		end if
		
		//��곯¥ ��������
		ls_adjdate = st_5.text
		
		//��ȸ�뵥��Ÿ ��������
		ldw_01.accepttext()
		ls_plant = ldw_01.getitemstring(1,"wip001_waplant")
		ls_dvsn  = ldw_01.getitemstring(1, "wip001_wadvsn")
	 	ls_iocd = ldw_01.getitemstring(1,"wip001_waiocd")
		ls_orct = ldw_01.getitemstring(1,"wip001_waorct")
		ls_pdcd = trim(ldw_01.getitemstring(1,"inv101_pdcd"))
		if f_spacechk(ls_pdcd) = -1 then
			ls_pdcd = '%'
		else
			ls_pdcd = ls_pdcd + '%'
		end if
		
		if ls_iocd = '1' then
			li_rowcnt = ldw_02.retrieve(g_s_company, ls_plant, ls_dvsn, ls_pdcd ,ls_iocd, '9999%', mid(ls_adjdate,1,4),mid(ls_adjdate,5,2)) //����
	   else
			if f_spacechk(ls_orct) = -1 then
				li_rowcnt = ldw_02.retrieve(g_s_company, ls_plant, ls_dvsn,ls_pdcd, ls_iocd, '%', mid(ls_adjdate,1,4),mid(ls_adjdate,5,2))  //����ü
			else
				
				ls_rtnvalue = f_get_vendor01(g_s_company, ldw_01.getitemstring(1,"vndr"))
				if f_spacechk(ls_rtnvalue) <> -1 then		//����ڹ�ȣ�� �ԷµȰ��
					ldw_03.setitem(1,"vndnm",mid(ls_rtnvalue,6))
					ldw_03.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
					ldw_03.accepttext()
					ls_orct = mid(ls_rtnvalue,1,5)
				else
					uo_status.st_message.text = "����ڹ�ȣ�� �ش��ϴ� ��ü�� �����ϴ�."
					return 0
				end if
				li_rowcnt = ldw_02.retrieve(g_s_company, ls_plant, ls_dvsn,ls_pdcd, ls_iocd, ls_orct + '%', mid(ls_adjdate,1,4),mid(ls_adjdate,5,2))  //�ش��ü
			end if
		end if
		
		if li_rowcnt > 0 then
			uo_status.st_message.text = f_message("I010")
      else
         uo_status.st_message.text = f_message("I020")
	   end if
		// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ����, ��, �ݱ�, ����ȸ, ȭ���μ�, Ư������
		wf_icon_onoff(true, false, false, false, true, false, false, false, false, false, false, false)
	case 2
		//��������Ȯ��
		if wf_authority_chk() = -1 then
			return 0
		end if
	  	ldw_04.reset()
	  	ldw_05.reset()
		ldw_06.reset()
		ldw_03.accepttext()
		ls_plant = ldw_03.getitemstring(1,"wip001_waplant")
		ls_dvsn  = ldw_03.getitemstring(1,"wip001_wadvsn")
		ls_itno  = ldw_03.getitemstring(1,"wip001_waitno")
	  	ls_iocd = ldw_03.getitemstring(1,"wip001_waiocd")
		ls_orct = ldw_03.getitemstring(1,"wip001_waorct")

		if f_wip_mandantory_chk(ldw_03) = -1 then return 0
		
		if ls_iocd = '2' then
			tab_1.tabpage_2.cb_1.enabled = false
			if f_spacechk(ls_orct) = -1 then
				ls_rtnvalue = f_get_vendor01(g_s_company, ldw_01.getitemstring(1,"vndr"))
				if f_spacechk(ls_rtnvalue) <> -1 then		//����ڹ�ȣ�� �ԷµȰ��
					ldw_03.setitem(1,"vndnm",mid(ls_rtnvalue,6))
					ldw_03.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
					ldw_03.accepttext()
					ls_orct = mid(ls_rtnvalue,1,5)
				else
					uo_status.st_message.text = "����ڹ�ȣ�� �ش��ϴ� ��ü�� �����ϴ�."
					return 0
				end if
			end if
		else
			tab_1.tabpage_2.cb_1.enabled = true
		end if
		
		if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, ls_itno, ldw_03) = -1 then
			uo_status.st_message.text = "���ǵ��� ���� ǰ���Դϴ�."
			return 0
		end if
		
//		if wf_selectcheck(g_s_company, ls_plant, ls_dvsn,'050') = -1 then
//			uo_status.st_message.text = "�̿����̰ų� �����۾��� �Ϸ� �Ǿ����ϴ�"
//			return 0
//		end if
		
		ls_adjdate = st_5.text

		li_rowcnt = ldw_04.retrieve(g_s_company, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd, ls_adjdate)	
		if li_rowcnt <= 0 then
			uo_status.st_message.text = f_message("I020")
			return 0
		else
			uo_status.st_message.text = f_message("I010")
			//��������� ����
			lc_convqty = ldw_04.getitemdecimal(1,"inv101_convqty")
			//ldw_04.setitem(1,"preohqt", f_get_onhand('qty',ls_adjdate, g_s_company, ls_plant, ls_dvsn, ls_orct, ls_itno) / lc_convqty)
			ldw_04.setitem(1,"postohqt",0);
		end if

		// ��ȸ, �Է�, ����, ����, �μ�, ó��, ����, ����, ��, �ݱ�, ����ȸ, ȭ���μ�, Ư������
		wf_icon_onoff(true, false, true, false, false, false, false, false, false, false, false, false)
end choose	

return 0				
    
end event

event ue_save;datawindow ldw_01, ldw_02, ldw_03
dwitemstatus ldws_01
datastore lds_01
string ls_usage, ls_adjdate, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd
integer li_rowcnt, li_cntx, li_rtncode
dec{4} lc_totalqty, lc_originqty, lc_diffqty, lc_optionsum, lc_postohqt
dec{4} lc_convqty
dec{2} lc_costav

lds_01 = create datastore
lds_01.dataobject = "d_wip_option_wip004"
lds_01.settransobject(sqlca)

setpointer(hourglass!)
uo_status.st_message.text = ""
lds_01.reset()
ldw_01 = tab_1.tabpage_2.dw_rephead
ldw_02 = tab_1.tabpage_2.dw_history
ldw_03 = tab_1.tabpage_2.dw_repentry

ls_plant = ldw_01.getitemstring(1,"wip002_wbplant")
ls_dvsn = ldw_01.getitemstring(1,"wip002_wbdvsn")
ls_orct = ldw_01.getitemstring(1,"wip002_wborct")
ls_itno = ldw_01.getitemstring(1,"wip002_wbitno")
ls_iocd = ldw_01.getitemstring(1,"wip002_wbiocd")

//Optionǰ üũ
ldw_03.accepttext()
li_rowcnt = ldw_03.rowcount()
if li_rowcnt > 0 then
	if wf_option_datachk(ldw_03) = -1 then return 0
end if
//�߰��� Optionǰ�� ������ wip004 dwo�� �Է�, dw_rephead�� ���������ݿ�
lc_totalqty = 0
ldw_03.accepttext()
if li_rowcnt > 0 then
	for li_cntx = 1 to li_rowcnt
		lc_totalqty = lc_totalqty + ldw_03.getitemdecimal(li_cntx,"repqt")
		lc_convqty = ldw_03.getitemdecimal(li_cntx,"convqty")
		ls_usage = ldw_03.getitemstring(li_cntx,"wdusge")
		if wf_set_wip004(lds_01, ldw_03, lc_convqty, li_cntx) = -1 then
			uo_status.st_message.text = "���Ʈ������������ : �����ý������� �����ٶ��ϴ�."
			return 0
		end if
	next
end if
lc_optionsum = lc_totalqty

select costav into :lc_costav from pbinv.inv101
	where comltd = :g_s_company and xplant = :ls_plant and div = :ls_dvsn and
			itno = :ls_itno using sqlca;

//��ȯ���
lc_convqty = ldw_01.getitemdecimal(1,"inv101_convqty")
lc_costav = lc_costav / lc_convqty

//��뷮 ����üũ
//������ ǰ���� ������ wip004 dwo�� �Է�, dw_rephead�� �ݿ�
//�����Ļ�뷮�� �����丮, ���̼����� �̿�DB
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
			if wf_set_wip004(lds_01, ldw_02, lc_convqty, li_cntx) = -1 then
				uo_status.st_message.text = "����������� : �����ý������� �����ٶ��ϴ�."
				return 0
			end if
		end if
	next
	
//	if lc_optionsum <> lc_totalqty then
//		uo_status.st_message.text = "���̼����� �ɼ�ǰ�� �߰��� ������ ��ġ���� �ʽ��ϴ�."
//		return 0
//	end if
	
	lc_originqty = ldw_01.getitemdecimal(1,"postohqt")
	if lc_originqty = 0 then
		lc_originqty = ldw_01.getitemdecimal(1,"preohqt")
	end if
	lc_postohqt = lc_originqty + lc_totalqty
	ldw_01.setitem(1,"postohqt",lc_originqty + lc_totalqty)

	choose case ls_usage
		case '01'
			lc_originqty = ldw_01.getitemdecimal(1,"wip002_wbusqt1")
			ldw_01.setitem(1,"wip002_wbusqt1", lc_originqty - (lc_totalqty * lc_convqty))
			ldw_01.setitem(1,"wip002_wbusat1", (lc_originqty - (lc_totalqty * lc_convqty)) * lc_costav )
		case '02'
			lc_originqty = ldw_01.getitemdecimal(1,"wip002_wbusqt2")
			ldw_01.setitem(1,"wip002_wbusqt2", lc_originqty - (lc_totalqty * lc_convqty))
			ldw_01.setitem(1,"wip002_wbusat2", (lc_originqty - (lc_totalqty * lc_convqty)) * lc_costav )
		case '03'
			lc_originqty = ldw_01.getitemdecimal(1,"wip002_wbusqt3")
			ldw_01.setitem(1,"wip002_wbusqt3", lc_originqty - (lc_totalqty * lc_convqty))
			ldw_01.setitem(1,"wip002_wbusat3", (lc_originqty - (lc_totalqty * lc_convqty)) * lc_costav )
		case '05'
			lc_originqty = ldw_01.getitemdecimal(1,"wip002_wbusqt5")
			ldw_01.setitem(1,"wip002_wbusqt5", lc_originqty - (lc_totalqty * lc_convqty))
			ldw_01.setitem(1,"wip002_wbusat5", (lc_originqty - (lc_totalqty * lc_convqty)) * lc_costav )
		case '06'
			lc_originqty = ldw_01.getitemdecimal(1,"wip002_wbusqt6")
			ldw_01.setitem(1,"wip002_wbusqt6", lc_originqty - (lc_totalqty * lc_convqty))
			ldw_01.setitem(1,"wip002_wbusat6", (lc_originqty - (lc_totalqty * lc_convqty)) * lc_costav )
	end choose
	
else
	uo_status.st_message.text = "���������� �����ϴ�"
end if
//¥���� ���� Ȯ��
//if lc_postohqt 
//wip004 update
lds_01.accepttext()
f_wip_null_chk2(lds_01)
li_rowcnt = lds_01.rowcount()
li_rtncode = lds_01.update()

if li_rtncode = 1 then
	uo_status.st_message.text = ""
else
	uo_status.st_message.text = "ERR1 : ��������ÿ� ������ �߻��Ͽ����ϴ�."
	return 0
end if

//Optionǰ ��뷮 �̿�DB UDATE
if wf_option_update(ldw_03) = -1 then
	uo_status.st_message.text = "ERR2 : ��������ÿ� ������ �߻��Ͽ����ϴ�."
	return 0
end if
//���� ���� �̿�DB UPDATE
f_wip_inptid(ldw_01)
ldw_01.accepttext()
if ldw_01.update() <> 1 then
	uo_status.st_message.text = "ERR2 : ��������ÿ� ������ �߻��Ͽ����ϴ�."
	return 0
end if

//�̿� �⸻��� UPDATE
ls_adjdate = uf_wip_addmonth(st_5.text,1)
lc_postohqt = lc_postohqt * lc_convqty
  
  UPDATE "PBWIP"."WIP002"  
     SET "WBBGQT" = :lc_postohqt 
   WHERE ( "PBWIP"."WIP002"."WBCMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP002"."WBPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP002"."WBDVSN" = :ls_dvsn ) AND  
         ( "PBWIP"."WIP002"."WBORCT" = :ls_orct ) AND  
         ( "PBWIP"."WIP002"."WBITNO" = :ls_itno ) AND  
			( "PBWIP"."WIP002"."WBIOCD" = :ls_iocd ) AND
         ( "PBWIP"."WIP002"."WBYEAR"||"PBWIP"."WIP002"."WBMONTH" = :ls_adjdate )   
         using sqlca;
//����� ������� Update

  UPDATE "PBWIP"."WIP001"  
     SET "WABGQT" = :lc_postohqt,   
         "WAOHQT" = :lc_postohqt + WAINQT - ( WAUSQT1 + WAUSQT2 + WAUSQT3 + WAUSQT4 
					+ WAUSQT5 + WAUSQT6 + WAUSQT7 + WAUSQT8 )  
	WHERE ( "PBWIP"."WIP001"."WACMCD" = :g_s_company ) AND  
         ( "PBWIP"."WIP001"."WAPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP001"."WADVSN" = :ls_dvsn ) AND  
         ( "PBWIP"."WIP001"."WAORCT" = :ls_orct ) AND  
         ( "PBWIP"."WIP001"."WAITNO" = :ls_itno ) AND
			( "PBWIP"."WIP001"."WAIOCD" = :ls_iocd )
			using sqlca;

window l_s_wsheet
l_s_wsheet = w_frame.GetActiveSheet()
i_n_tabindex = 2
l_s_wsheet.TriggerEvent("ue_retrieve")

uo_status.st_message.text = "�������� ������Ʈ�� �Ϸ�Ǿ����ϴ�."
// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
wf_icon_onoff(true, false, false, false, false, false, false, false, false, false, false, false)
return 0				
    
end event

event ue_print;call super::ue_print;integer l_n_rowcnt, i
string mod_string,l_s_plant,l_s_dvsn, ls_iocd

window 	l_to_open
str_easy l_str_prt

								
//��� �����쿡 Data ����, ��� ������ Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "��� �غ��� �Դϴ�..."
//this.TriggerEvent("ue_retrieve")
if tab_1.tabpage_1.dw_replist.rowcount() < 1 then
	uo_status.st_message.text = f_message("P020")
	return 0
end if

if i_n_tabindex <> 1 then	
	uo_status.st_message.text = "�μ⿵���� ������ ���� �ʽ��ϴ�."
	return 0
end if

tab_1.tabpage_1.dw_replist.sharedata(dw_report)

//�μ� DataWindow ����
//w_easy_prt�� dwsyntax�� ���� modify()���� �߰���
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
l_str_prt.dwsyntax = mod_string
//l_str_prt.title = "�ϼ�ǰ�� ������"
l_str_prt.tag			  = This.ClassName()
	
f_close_report("1", l_str_prt.title)			 //Open�� ���Window �ݱ�
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		
	
uo_status.st_message.Text = ""
return 0

end event

type uo_status from w_origin_sheet02`uo_status within w_wip022u
end type

type tab_1 from tab within w_wip022u
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
string facename = "����ü"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
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

event selectionchanged;i_n_tabindex = newindex

if i_n_tabindex = 3 then
	st_3.visible = true
	uo_pbar.visible = true
	tab_1.tabpage_3.cb_ok.enabled = false
	tab_1.tabpage_3.cb_exec.enabled = false
	tab_1.tabpage_3.cb_modify.enabled = false
elseif i_n_tabindex = 2 then
	st_3.visible = false
	uo_pbar.visible = false
	// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff(true, false, true, false, false, false, false, false, false, false, false, false)
else
	st_3.visible = false
	uo_pbar.visible = false
	// ��ȸ, �Է�, ����, ����, ����ȸ, ȭ���μ�, Ư������
	wf_icon_onoff(true, false, false, false, false, true, false, false, false, false, false, false)
end if	
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 108
integer width = 4571
integer height = 2324
long backcolor = 12632256
string text = "��� ��Ȳ"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_5 dw_5
gb_4 gb_4
dw_replist dw_replist
dw_2 dw_2
pb_1 pb_1
end type

on tabpage_1.create
this.dw_5=create dw_5
this.gb_4=create gb_4
this.dw_replist=create dw_replist
this.dw_2=create dw_2
this.pb_1=create pb_1
this.Control[]={this.dw_5,&
this.gb_4,&
this.dw_replist,&
this.dw_2,&
this.pb_1}
end on

on tabpage_1.destroy
destroy(this.dw_5)
destroy(this.gb_4)
destroy(this.dw_replist)
destroy(this.dw_2)
destroy(this.pb_1)
end on

type dw_5 from datawindow within tabpage_1
integer x = 2523
integer y = 364
integer width = 2034
integer height = 1948
integer taborder = 40
string title = "none"
string dataobject = "d_wip022u_detail"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within tabpage_1
integer x = 9
integer width = 4544
integer height = 348
integer taborder = 160
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_replist from datawindow within tabpage_1
integer x = 5
integer y = 368
integer width = 2505
integer height = 1944
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip022u_linelist"
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

//�ش�ǰ���� ���� ���󼼳���
tab_1.tabpage_1.dw_5.reset()
ls_plant = This.getitemstring(row,"wip002_wbplant")
ls_dvsn = This.getitemstring(row,"wip002_wbdvsn")
ls_iocd = This.getitemstring(row,"wip002_wbiocd")
ls_orct = This.getitemstring(row,"wip002_wborct")
ls_itno = This.getitemstring(row,"wip002_wbitno")
ls_date = st_5.text
lc_convqty = This.getitemdecimal(row,"inv101_convqty")
ls_fromdt = ls_date + '01'
ls_todt = f_relativedate(uf_wip_addmonth(ls_date,1) + '01',-1)

tab_1.tabpage_1.dw_5.retrieve(g_s_company, ls_plant, ls_dvsn, ls_iocd, ls_orct,ls_itno, ls_fromdt, ls_todt, lc_convqty)
end event

event doubleclicked;datawindow ldw_01,ldw_02
string ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd, ls_rtnvalue
window l_s_wsheet

//��������Ȯ��
if wf_authority_chk() = -1 then
	return 0
end if

l_s_wsheet = w_frame.GetActiveSheet()
ldw_01 = tab_1.tabpage_2.dw_3
ldw_02 = tab_1.tabpage_1.dw_replist
ldw_01.setitem(1,"wip001_waplant",ldw_02.getitemstring(row,"wip002_wbplant"))
ldw_01.setitem(1,"wip001_wadvsn",ldw_02.getitemstring(row,"wip002_wbdvsn"))
ldw_01.setitem(1,"wip001_waorct",ldw_02.getitemstring(row,"wip002_wborct"))
ldw_01.setitem(1,"wip001_waiocd",ldw_02.getitemstring(row,"wip002_wbiocd"))
ldw_01.setitem(1,"wip001_waitno",ldw_02.getitemstring(row,"wip002_wbitno"))

if ldw_02.getitemstring(row,"wip002_wbiocd") = '2' then
	ldw_01.modify("vndr.visible = true")
	ldw_01.modify("vsrno_t.visible = true")
	ldw_01.modify("vndnm.visible = true")
	ldw_01.modify("b_search.visible = true")
	ldw_01.modify("vndr.background.color = 15780518")
	ls_rtnvalue = f_get_vendor02(g_s_company, ldw_02.getitemstring(row,"wip002_wborct"))
	if f_spacechk(ls_rtnvalue) = -1 then
		uo_status.st_message.text = "�ش��ü�ڵ尡 �������� �ʽ��ϴ�."
		return 0
	else
		ldw_01.setitem(1,"vndr",mid(ls_rtnvalue,1,10))
		ldw_01.setitem(1,"vndnm",mid(ls_rtnvalue,11))
	end if
else
	ldw_01.setitem(1,"wip001_waorct",'9999')
	ldw_01.modify("vndr_t.visible = false")
	ldw_01.modify("vndr.visible = false")
	ldw_01.modify("vsrno_t.visible = false")
	ldw_01.modify("vndnm.visible = false")
	ldw_01.modify("b_search.visible = false")
	ldw_01.modify("vndr.background.color = 1090519039")
end if

tab_1.selecttab(2)
i_n_tabindex = 2
l_s_wsheet.TriggerEvent("ue_retrieve")




end event

type dw_2 from datawindow within tabpage_1
event ue_enterkey pbm_keydown
integer x = 27
integer y = 44
integer width = 3314
integer height = 284
integer taborder = 100
boolean bringtotop = true
string title = "none"
string dataobject = "d_wip022u_04"
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

if ls_colname = "wip001_waiocd" then
	if data = '2' then
		tab_1.tabpage_1.dw_replist.dataobject = "d_wip022u_vndlist"
		tab_1.tabpage_1.dw_replist.settransobject(sqlca)
		dw_report.dataobject = "d_wip022u_vndreport"
		dw_report.settransobject(sqlca)
		This.modify("vndr_t.visible = true")
		This.modify("vndr.visible = true")
		This.modify("vsrno_t.visible = true")
		This.modify("vndnm.visible = true")
		This.modify("b_search.visible = true")
		This.setitem(1,"wip001_waorct",'')
	else
		tab_1.tabpage_1.dw_replist.dataobject = "d_wip022u_linelist"
		tab_1.tabpage_1.dw_replist.settransobject(sqlca)
		dw_report.dataobject = "d_wip022u_linereport"
		dw_report.settransobject(sqlca)
		This.setitem(1,"wip001_waorct",'9999')
		This.modify("vndr_t.visible = false")
		This.modify("vndr.visible = false")
		This.modify("vsrno_t.visible = false")
		This.modify("vndnm.visible = false")
		This.modify("b_search.visible = false")
	end if
end if

if ls_colname = "vndr" then
	string ls_rtnvalue
	ls_rtnvalue = f_get_vendor01(g_s_company, data)
	if ls_rtnvalue <> '' then		//����ڹ�ȣ�� �ԷµȰ��
		This.setitem(1,"vndnm",mid(ls_rtnvalue,6))
		This.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
	else
		uo_status.st_message.text = "����ڹ�ȣ�� �ش��ϴ� ��ü�� �����ϴ�."
		return 0
	end if
end if


end event

type pb_1 from picturebutton within tabpage_1
integer x = 3515
integer y = 48
integer width = 155
integer height = 132
integer taborder = 120
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

event clicked;f_save_to_excel(tab_1.tabpage_1.dw_replist)
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 4571
integer height = 2324
long backcolor = 12632256
string text = "��� ����"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_2 cb_2
cb_1 cb_1
gb_5 gb_5
cb_optcancel cb_optcancel
cb_option cb_option
dw_repentry dw_repentry
dw_history dw_history
dw_rephead dw_rephead
dw_3 dw_3
end type

on tabpage_2.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_5=create gb_5
this.cb_optcancel=create cb_optcancel
this.cb_option=create cb_option
this.dw_repentry=create dw_repentry
this.dw_history=create dw_history
this.dw_rephead=create dw_rephead
this.dw_3=create dw_3
this.Control[]={this.cb_2,&
this.cb_1,&
this.gb_5,&
this.cb_optcancel,&
this.cb_option,&
this.dw_repentry,&
this.dw_history,&
this.dw_rephead,&
this.dw_3}
end on

on tabpage_2.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_5)
destroy(this.cb_optcancel)
destroy(this.cb_option)
destroy(this.dw_repentry)
destroy(this.dw_history)
destroy(this.dw_rephead)
destroy(this.dw_3)
end on

type cb_2 from commandbutton within tabpage_2
integer x = 2112
integer y = 952
integer width = 777
integer height = 104
integer taborder = 130
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "�������/�԰� �߰�"
end type

event clicked;string ls_itno, ls_parm
uo_status.st_message.text = " "

ls_itno = dw_rephead.getitemstring(1,"wip002_wbitno")
if f_spacechk(ls_itno) = -1 then
	uo_status.st_message.text = "ǰ���� ��ȸ�� �ֽʽÿ�"
	return 0
else
	dw_rephead.setitem(1,"usge_chk",'02')
	openwithparm(w_wip022u_additem , dw_rephead)
	ls_parm = message.stringparm
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	i_n_tabindex = 2
	l_s_wsheet.TriggerEvent("ue_retrieve")
	uo_status.st_message.text = f_message(ls_parm)
end if



end event

type cb_1 from commandbutton within tabpage_2
integer x = 1490
integer y = 952
integer width = 567
integer height = 104
integer taborder = 120
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "��ǰ�԰��߰�"
end type

event clicked;string ls_itno, ls_parm
uo_status.st_message.text = " "

ls_itno = dw_rephead.getitemstring(1,"wip002_wbitno")
if f_spacechk(ls_itno) = -1 then
	uo_status.st_message.text = "ǰ���� ��ȸ�� �ֽʽÿ�"
	return 0
else
	dw_rephead.setitem(1,"usge_chk",'01')
	openwithparm(w_wip022u_additem , dw_rephead)
	ls_parm = message.stringparm
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	i_n_tabindex = 2
	l_s_wsheet.TriggerEvent("ue_retrieve")
	uo_status.st_message.text = f_message(ls_parm)
end if



end event

type gb_5 from groupbox within tabpage_2
integer x = 9
integer width = 4549
integer height = 312
integer taborder = 30
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
end type

type cb_optcancel from commandbutton within tabpage_2
integer x = 3849
integer y = 952
integer width = 507
integer height = 104
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Optionǰ ���"
end type

event clicked;datawindow ldw_01
string ls_itno
integer li_selrow

ldw_01 = tab_1.tabpage_2.dw_repentry
ldw_01.accepttext()
li_selrow = ldw_01.getselectedrow(0)
if li_selrow < 0 then
	uo_status.st_message.text = "����� ���� �����Ͻʽÿ�"
   return 0
end if
ls_itno = ldw_01.getitemstring(li_selrow,"wditno") 

net=messagebox("Ȯ��","������ "+string(li_selrow)+"��°�� "+ ls_itno+ " ǰ���� ���� �Ͻðڽ��ϱ�?",question!,okcancel!,2)
if net=2 then
   return 0
end if
ldw_01.deleterow(li_selrow)
end event

type cb_option from commandbutton within tabpage_2
integer x = 3282
integer y = 952
integer width = 539
integer height = 104
integer taborder = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Optionǰ �߰�"
end type

event clicked;datawindow ldw_01, ldw_02, ldw_03
integer li_selrow, li_currow
dec{2} lc_diffqt

ldw_01 = tab_1.tabpage_2.dw_history
ldw_02 = tab_1.tabpage_2.dw_repentry
ldw_03 = tab_1.tabpage_2.dw_rephead

ldw_01.accepttext()
li_selrow = ldw_01.getselectedrow(0)
if li_selrow < 1 then
	uo_status.st_message.text = "Optionǰ�� �߰��� ��ǰ���� �����Ͻʽÿ�"
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
ldw_02.setitem(li_currow,"repqt", lc_diffqt)
ldw_02.setitem(li_currow,"chqt", 0)
ldw_02.setitem(li_currow,"wdinpttm", g_s_datetime)


end event

type dw_repentry from datawindow within tabpage_2
integer x = 2917
integer y = 1076
integer width = 1650
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
integer width = 2898
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

return 0
end event

event itemchanged;dec{4} lc_chqt, lc_repqt, lc_diffqt
lc_chqt = This.getitemdecimal(row,"chqt")

choose case dwo.name
	case 'repqt'
		This.setitem(row,"diffqt", lc_chqt - DEC(data))
	case 'diffqt'
		This.setitem(row,"repqt", lc_chqt - DEC(data))
end choose

return 0
end event

type dw_rephead from datawindow within tabpage_2
integer x = 5
integer y = 344
integer width = 4558
integer height = 484
string title = "none"
string dataobject = "d_wip022u_01"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;datawindow ldw_01, ldw_02, ldw_03
string ls_usage, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd, ls_adjdate, ls_text
dec{4} lc_convqty
integer li_rtnrow, li_currow

uo_status.st_message.text = ""
ldw_01 = tab_1.tabpage_2.dw_rephead
ldw_02 = tab_1.tabpage_2.dw_history
ldw_03 = tab_1.tabpage_2.dw_repentry

ldw_02.reset()
ldw_03.reset()

ls_plant = ldw_01.getitemstring(1,"wip002_wbplant")
ls_dvsn = ldw_01.getitemstring(1,"wip002_wbdvsn")
ls_orct = ldw_01.getitemstring(1,"wip002_wborct")
ls_itno = ldw_01.getitemstring(1,"wip002_wbitno")
ls_iocd = ldw_01.getitemstring(1,"wip002_wbiocd")
lc_convqty = ldw_01.getitemdecimal(1,"inv101_convqty")
ls_adjdate = st_5.text

choose case dwo.name
	case 'b_usqt1'
		ls_usage = '01'
	case 'b_usqt2'
		ls_usage = '02'
//	case 'b_usqt3'
//		ls_usage = '03'
//	case 'b_usqt5'
//		ls_usage = '05'
//	case 'b_usqt6'
//		ls_usage = '06'
	case else
		return 0
end choose

li_rtnrow = ldw_02.retrieve(g_s_company, ls_plant, ls_dvsn, ls_orct, ls_itno, ls_iocd, ls_adjdate, ls_usage, lc_convqty)
if li_rtnrow < 1 then
	uo_status.st_message.text = "��ǰ���� ���� �ش�ǰ���� �����볻���� �����ϴ�"
	return 0
//	choose case ls_usage
//		case '01'
//			ls_text = '��ǰ�԰���'
//		case '02'
//			ls_text = '������ǰ���'
//		case '03'
//			ls_text = '���������'
//		case '05'
//			ls_text = 'Ÿ����������'
//		case '06'
//			ls_text = 'Ÿ�μ�������'
//	end choose
//	net=messagebox("Ȯ��","������ ǰ���� " + ls_text + "�뵵�� ������� �߰��Ͻðڽ��ϱ�?",question!,okcancel!,2)
//	if net=2 then
//		return 0
//	end if
//	ldw_02.insertrow(1)
//	ldw_02.setitem(1,"wdplant",ldw_01.getitemstring(1,"wip002_wbplant"))
//	ldw_02.setitem(1,"wddvsn", ldw_01.getitemstring(1,"wip002_wbdvsn"))
//	ldw_02.setitem(1,"wdiocd", ldw_01.getitemstring(1,"wip002_wbiocd"))
//	ldw_02.setitem(1,"wdrvno", ldw_01.getitemstring(1,"wip002_wbrev"))
//	ldw_02.setitem(1,"wddesc", trim(ldw_01.getitemstring(1,"inv002_itnm")))
//	ldw_02.setitem(1,"wdspec", trim(ldw_01.getitemstring(1,"inv002_spec")))
//	ldw_02.setitem(1,"wdunit", ldw_01.getitemstring(1,"inv101_xunit"))
//	ldw_02.setitem(1,"wditcl", ldw_01.getitemstring(1,"inv101_cls"))
//	ldw_02.setitem(1,"wdsrce", ldw_01.getitemstring(1,"inv101_srce"))
//	ldw_02.setitem(1,"wdpdcd", ldw_01.getitemstring(1,"wip002_wbpdcd"))
//	ldw_02.setitem(1,"wdchdpt",ldw_01.getitemstring(1,"wip002_wborct"))
//	ldw_02.setitem(1,"wditno", ldw_01.getitemstring(1,"wip002_wbitno"))
//	ldw_02.setitem(1,"wdusge", ls_usage)
//	ldw_02.setitem(1,"wdprdpt",' ')
//	ldw_02.setitem(1,"wdprno", ' ')
//	ldw_02.setitem(1,"prdpnm", ' ')
//	ldw_02.setitem(1,"prnm", ' ')
//	ldw_02.setitem(1,"chqt",  0)
//	ldw_02.setitem(1,"repqt", ldw_01.getitemdecimal(1,"preohqt"))
//	ldw_02.setitem(1,"diffqt", (-1) * ldw_01.getitemdecimal(1,"preohqt"))
else
	uo_status.st_message.text = "��ȸ�Ǿ����ϴ�"
	ldw_02.selectrow(1,true)
	ldw_02.setcolumn("repqt")
	ldw_02.setfocus()
end if
end event

type dw_3 from datawindow within tabpage_2
event ue_enterkey pbm_keydown
integer x = 41
integer y = 36
integer width = 4352
integer height = 268
integer taborder = 150
boolean bringtotop = true
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
		uo_status.st_message.text = "�����̳� ������ ���� �����Ͻʽÿ�"
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
	if ls_rtnvalue <> '' then		//����ڹ�ȣ�� �ԷµȰ��
		This.setitem(1,"vndnm",mid(ls_rtnvalue,6))
		This.setitem(1,"wip001_waorct",mid(ls_rtnvalue,1,5))
	else
		uo_status.st_message.text = "����ڹ�ȣ�� �ش��ϴ� ��ü�� �����ϴ�."
		return 0
	end if
end if

if ls_colname = 'wip001_waitno' then
	This.AcceptText()
	ls_plant = this.getitemstring(1,"wip001_waplant")
	ls_dvsn = this.getitemstring(1,"wip001_wadvsn")
   if f_get_itemproperty(g_s_company, ls_plant, ls_dvsn, data, this) = -1 then
		uo_status.st_message.text = "���ǵ��� ���� ǰ���Դϴ�."
		return 0
	end if
end if

end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 108
integer width = 4571
integer height = 2324
boolean enabled = false
long backcolor = 12632256
string text = "���� Ȯ��"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
uo_1 uo_1
dw_4 dw_4
gb_2 gb_2
gb_3 gb_3
gb_1 gb_1
lb_1 lb_1
st_7 st_7
st_6 st_6
rb_1 rb_1
rb_2 rb_2
st_8 st_8
cb_exec cb_exec
cb_ok cb_ok
st_1 st_1
st_2 st_2
cb_modify cb_modify
end type

on tabpage_3.create
this.uo_1=create uo_1
this.dw_4=create dw_4
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_1=create gb_1
this.lb_1=create lb_1
this.st_7=create st_7
this.st_6=create st_6
this.rb_1=create rb_1
this.rb_2=create rb_2
this.st_8=create st_8
this.cb_exec=create cb_exec
this.cb_ok=create cb_ok
this.st_1=create st_1
this.st_2=create st_2
this.cb_modify=create cb_modify
this.Control[]={this.uo_1,&
this.dw_4,&
this.gb_2,&
this.gb_3,&
this.gb_1,&
this.lb_1,&
this.st_7,&
this.st_6,&
this.rb_1,&
this.rb_2,&
this.st_8,&
this.cb_exec,&
this.cb_ok,&
this.st_1,&
this.st_2,&
this.cb_modify}
end on

on tabpage_3.destroy
destroy(this.uo_1)
destroy(this.dw_4)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.lb_1)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.st_8)
destroy(this.cb_exec)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_modify)
end on

type uo_1 from uo_wip_plandiv within tabpage_3
integer x = 837
integer y = 64
integer taborder = 110
end type

on uo_1.destroy
call uo_wip_plandiv::destroy
end on

type dw_4 from datawindow within tabpage_3
boolean visible = false
integer x = 2775
integer y = 1168
integer width = 411
integer height = 432
integer taborder = 80
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within tabpage_3
integer x = 859
integer y = 1132
integer width = 1893
integer height = 612
integer taborder = 110
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 67108864
string text = "[�� ��]"
end type

type gb_3 from groupbox within tabpage_3
integer x = 2857
integer y = 224
integer width = 425
integer height = 660
integer taborder = 120
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_1 from groupbox within tabpage_3
integer x = 859
integer y = 224
integer width = 1893
integer height = 788
integer taborder = 110
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 8388608
long backcolor = 67108864
string text = "[�۾� ����]"
end type

type lb_1 from listbox within tabpage_3
integer x = 978
integer y = 352
integer width = 1659
integer height = 600
integer taborder = 140
boolean bringtotop = true
integer textsize = -13
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
boolean underline = true
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
string item[] = {"1. ����  �Է� Ȯ�� �� ���","2. ��ǰ�԰�� ��� Ȯ��","3. ���� Ȯ��","4. �ܰ� ��� �� �ݾ� ����","5. ���� �۾� Ȯ��(�渮 �ڷ� �߼�)"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;string ls_adjdate, ls_stscd, ls_cttp
string ls_plant, ls_dvsn, ls_rtncd

uo_status.st_message.text = ""
st_2.text = " "
ls_rtncd = uo_1.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_dvsn = mid(ls_rtncd,2,1)
if f_spacechk(ls_plant) = -1 or f_spacechk(ls_dvsn) = -1 then
	uo_status.st_message.text = "������ ������ �����Ͻʽÿ�."
	return 0
end if
		
choose case index
	case 1
		ls_cttp = 'WIP' + ls_dvsn + '050'
		rb_2.enabled = true
	case 2
		ls_cttp = 'WIP' + ls_dvsn + '060'
		rb_2.enabled = true
		dw_4.dataobject = 'd_wip_cross_error'
		dw_4.settransobject(sqlca)
	case 3
		ls_cttp = 'WIP' + ls_dvsn + '070'
		rb_2.enabled = true
		dw_4.dataobject = 'd_wip_inout_wip002error'
		dw_4.settransobject(sqlca)
	case 4
		ls_cttp = 'WIP' + ls_dvsn + '080'
		rb_2.enabled = true
		dw_4.dataobject = "d_wip_cost_error"
		dw_4.settransobject(sqlca)
	case 5
		ls_cttp = 'WIP' + ls_dvsn + '090'
		rb_2.enabled = false
end choose

SELECT "PBWIP"."WIP090"."WZEDDT",   
        "PBWIP"."WIP090"."WZSTSCD"  
   INTO :ls_adjdate,   
         :ls_stscd  
   FROM "PBWIP"."WIP090"  
   WHERE ( "PBWIP"."WIP090"."WZCMCD" = '01' ) AND  
         ( "PBWIP"."WIP090"."WZPLANT" = :ls_plant ) AND  
         ( "PBWIP"."WIP090"."WZCTTP" = :ls_cttp )   
			using sqlca;

i_s_cttp = ls_cttp
i_s_plant = ls_plant
i_s_dvsn = ls_dvsn
i_n_job = index
//�ش��۾��� ���� ������� ǥ��
if ls_stscd = 'C' then
	tab_1.tabpage_3.rb_1.checked = true
	tab_1.tabpage_3.cb_ok.enabled = true
	tab_1.tabpage_3.cb_exec.enabled = false
	tab_1.tabpage_3.cb_modify.enabled = false
else
	tab_1.tabpage_3.rb_2.checked = true
	tab_1.tabpage_3.cb_ok.enabled = true
	if index = 1 or index = 5 then
		tab_1.tabpage_3.cb_exec.enabled = false
		tab_1.tabpage_3.cb_modify.enabled = false
	else
		tab_1.tabpage_3.cb_exec.enabled = true
		tab_1.tabpage_3.cb_modify.enabled = false
	end if
end if	
end event

type st_7 from statictext within tabpage_3
integer x = 1061
integer y = 1272
integer width = 489
integer height = 72
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "�����������"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_3
integer x = 1065
integer y = 1420
integer width = 512
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "�����۾�����"
boolean focusrectangle = false
end type

type rb_1 from radiobutton within tabpage_3
integer x = 1618
integer y = 1420
integer width = 251
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ȯ��"
boolean checked = true
end type

type rb_2 from radiobutton within tabpage_3
integer x = 1993
integer y = 1420
integer width = 265
integer height = 64
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "����"
end type

type st_8 from statictext within tabpage_3
integer x = 1568
integer y = 1264
integer width = 1120
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_exec from commandbutton within tabpage_3
integer x = 2917
integer y = 500
integer width = 306
integer height = 140
integer taborder = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;//******************************************
// ���������۾� �Լ� ȣ��
//******************************************
//long ll_rowcnt
//string ls_errcnt
//
//uo_status.st_message.text = ""
//ls_errcnt = st_2.text
//choose case i_n_job
//	case 2
//		//�̿��� ũ�ν�üũ(����)
//		if wf_selectcheck(g_s_company,i_s_plant,i_s_dvsn,'050') = -1 then
//			uo_status.st_message.text = "�����Է��۾��� ��Ȯ�������Դϴ�."
//			return 0
//		end if
//		f_wip_cross_check(g_s_company,i_s_plant,i_s_dvsn,st_5.text,dw_4) 
//		ll_rowcnt = dw_4.rowcount()
//		if f_spacechk(ls_errcnt) <> -1 and ll_rowcnt > 0 then
//			uo_status.st_message.text = "�����ý������� �����ٶ��ϴ�."
//			return 0
//		else
//			st_2.text = string(ll_rowcnt)
//			if ll_rowcnt > 0 then
//				tab_1.tabpage_3.cb_ok.enabled = false
//				tab_1.tabpage_3.cb_exec.enabled = false
//				tab_1.tabpage_3.cb_modify.enabled = true
//				uo_status.st_message.text = "������ư�� �����ֽʽÿ�"
//				return 0
//			else
//				tab_1.tabpage_3.cb_exec.enabled = false
//				tab_1.tabpage_3.cb_modify.enabled = false
//				uo_status.st_message.text = "���������� �Ϸ�Ǿ����ϴ�."
//			end if
//		end if
//	case 3
//		//�̿��� ����Ȯ��(����)
//		if wf_selectcheck(g_s_company,i_s_plant,i_s_dvsn,'060') = -1 then
//			uo_status.st_message.text = "��ǰ�԰�� ���Ȯ���۾��� ��Ȯ�������Դϴ�."
//			return 0
//		end if
//		f_wip_inout_wip002(g_s_company,i_s_plant,i_s_dvsn,st_5.text,dw_4)
//		ll_rowcnt = dw_4.rowcount()
//		if f_spacechk(ls_errcnt) <> -1 and ll_rowcnt > 0 then
//			uo_status.st_message.text = "�����ý������� �����ٶ��ϴ�."
//			return 0
//		else
//			st_2.text = string(ll_rowcnt)
//			if ll_rowcnt > 0 then
//				tab_1.tabpage_3.cb_ok.enabled = false
//				tab_1.tabpage_3.cb_exec.enabled = false
//				tab_1.tabpage_3.cb_modify.enabled = true
//				uo_status.st_message.text = "������ư�� �����ֽʽÿ�"
//				return 0
//			else
//				tab_1.tabpage_3.cb_exec.enabled = false
//				tab_1.tabpage_3.cb_modify.enabled = false
//				uo_status.st_message.text = "���������� �Ϸ�Ǿ����ϴ�."
//				return 0
//			end if
//		end if
//	case 4
//		//�̿��� �ܰ����(����)
//		if wf_selectcheck(g_s_company,i_s_plant,i_s_dvsn,'070') = -1 then
//			uo_status.st_message.text = "����Ȯ���۾��� ��Ȯ�������Դϴ�."
//			return 0
//		end if
//		//â����� ���� ���
//		uo_status.st_message.text = "â����� ���� �����..."
//		if Not f_wip_calc_qtyinv(g_s_company,i_s_plant,i_s_dvsn,st_5.text) then
//			uo_status.st_message.text = "�����ý������� �����ٶ��ϴ�."
//			return 0
//		end if
//		//����ܰ� ���
//		uo_status.st_message.text = "����ܰ� �����..."
//		f_wip_cost_calc(g_s_company,i_s_plant,i_s_dvsn,st_5.text,dw_4)
//		if i_s_plant = 'D' and i_s_dvsn = 'A' then
//			if f_wip_cost_asitem(st_5.text) = -1 then
//				uo_status.st_message.text = "ASǰ ����߿� ������ �߻��߽��ϴ�."
//				return 0
//			end if
//		end if
//		uo_status.st_message.text = "�ܰ������ ���������� �Ϸ�Ǿ����ϴ�."
//end choose
//
//return 0
//
//
end event

type cb_ok from commandbutton within tabpage_3
integer x = 2917
integer y = 300
integer width = 306
integer height = 140
integer taborder = 90
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "Ȯ��"
end type

event clicked;//*************************************************
// �����ڵ� ������Ʈ
//*************************************************
string ls_stscd, ls_control

ls_control = 'WIP' + i_s_dvsn + '090'

SELECT   "PBWIP"."WIP090"."WZSTSCD"  
   INTO  :ls_stscd  
   FROM "PBWIP"."WIP090"  
   WHERE ( "PBWIP"."WIP090"."WZCMCD" = '01' ) AND  
         ( "PBWIP"."WIP090"."WZPLANT" = :i_s_plant ) AND  
         ( "PBWIP"."WIP090"."WZCTTP" = :ls_control )   
			using sqlca;
			
if ls_stscd = 'C' then
	uo_status.st_message.text = "�渮�� ������ �����Դϴ�."
	return 0
end if

if rb_1.checked = true then
	ls_stscd = 'C'
else
	ls_stscd = '2'
end if

UPDATE "PBWIP"."WIP090"  
   SET "WZSTSCD" = :ls_stscd  
   WHERE ( "PBWIP"."WIP090"."WZCMCD" = '01' ) AND  
         ( "PBWIP"."WIP090"."WZPLANT" = :i_s_plant ) AND  
         ( "PBWIP"."WIP090"."WZCTTP" = :i_s_cttp )   
         using sqlca;
			
if sqlca.sqlcode = 0 then
	COMMIT USING SQLCA;
	if i_n_job = 5 then
		if f_wip090_update(i_s_plant,i_s_dvsn,'090','C') = -1 then
			uo_status.st_message.text = f_message("U020")
		end if
	end if
	//�ش��۾��� ���� ������� ǥ��
	if ls_stscd = 'C' then
		tab_1.tabpage_3.rb_1.checked = true
		tab_1.tabpage_3.cb_ok.enabled = true
		tab_1.tabpage_3.cb_exec.enabled = false
		tab_1.tabpage_3.cb_modify.enabled = false
	else
		tab_1.tabpage_3.rb_2.checked = true
		if i_n_job = 1 or i_n_job = 5 then
			tab_1.tabpage_3.cb_exec.enabled = false
			tab_1.tabpage_3.cb_modify.enabled = false
		else
			tab_1.tabpage_3.cb_exec.enabled = true
			tab_1.tabpage_3.cb_modify.enabled = false
		end if
	end if
	uo_status.st_message.text = f_message("U010")
else
	ROLLBACK USING SQLCA;
	uo_status.st_message.text = f_message("U020")
end if



end event

type st_1 from statictext within tabpage_3
integer x = 1079
integer y = 1584
integer width = 448
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
string text = "���� �߻���"
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_3
integer x = 1568
integer y = 1576
integer width = 686
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_modify from commandbutton within tabpage_3
integer x = 2917
integer y = 700
integer width = 306
integer height = 140
integer taborder = 110
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
string text = "����"
end type

event clicked;//******************************************
// ���������۾� ��������Ÿ ����
//******************************************
integer li_rtncd
uo_status.st_message.text = ""
choose case i_n_job
	case 2
		//�̿��� ũ�ν�üũ(����)
		if wf_modify_cross(dw_4) = -1 then
			uo_status.st_message.text = "�����ý������� �����ٶ��ϴ�."
			return 0
		else
			tab_1.tabpage_3.cb_exec.enabled = true
			tab_1.tabpage_3.cb_modify.enabled = false
			uo_status.st_message.text = "�۾��� �� ����ٶ��ϴ�."
		end if
	case 3
		//�̿��� ����Ȯ��(����)
		dw_4.accepttext()
		//NULL CHECK
		f_wip_null_chk(dw_4)
		//�⺻���� ����
		f_wip_inptid(dw_4)
		if dw_4.update() = 1 then
			tab_1.tabpage_3.cb_exec.enabled = true
			tab_1.tabpage_3.cb_modify.enabled = false
			uo_status.st_message.text = "�۾��� ����� �ٶ��ϴ�."
		else
			uo_status.st_message.text = "�����ý������� �����ٶ��ϴ�."
		end if
end choose

return 0
end event

type st_4 from statictext within w_wip022u
integer x = 1399
integer y = 32
integer width = 384
integer height = 68
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "������:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_wip022u
integer x = 1792
integer y = 24
integer width = 526
integer height = 84
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type uo_pbar from uo_progress_bar within w_wip022u
integer x = 2912
integer y = 12
integer taborder = 20
boolean bringtotop = true
end type

on uo_pbar.destroy
call uo_progress_bar::destroy
end on

type st_3 from statictext within w_wip022u
integer x = 2482
integer y = 28
integer width = 402
integer height = 60
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "����ü"
long textcolor = 33554432
long backcolor = 12632256
string text = "�������:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_report from datawindow within w_wip022u
boolean visible = false
integer x = 4416
integer y = 8
integer width = 146
integer height = 108
integer taborder = 30
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

