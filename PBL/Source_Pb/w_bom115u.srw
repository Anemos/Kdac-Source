$PBExportHeader$w_bom115u.srw
$PBExportComments$Royalty 계산관리 윈도우
forward
global type w_bom115u from w_origin_sheet02
end type
type dw_customer from datawindow within w_bom115u
end type
type st_1 from statictext within w_bom115u
end type
type st_2 from statictext within w_bom115u
end type
type tab_royalty from tab within w_bom115u
end type
type tabpage_cal from userobject within tab_royalty
end type
type dw_rythist from datawindow within tabpage_cal
end type
type st_detail from statictext within tabpage_cal
end type
type st_3 from statictext within tabpage_cal
end type
type dw_prelist from datawindow within tabpage_cal
end type
type tabpage_cal from userobject within tab_royalty
dw_rythist dw_rythist
st_detail st_detail
st_3 st_3
dw_prelist dw_prelist
end type
type tabpage_ryt from userobject within tab_royalty
end type
type st_5 from statictext within tabpage_ryt
end type
type st_4 from statictext within tabpage_ryt
end type
type dw_partlist from datawindow within tabpage_ryt
end type
type dw_modellist from datawindow within tabpage_ryt
end type
type tabpage_ryt from userobject within tab_royalty
st_5 st_5
st_4 st_4
dw_partlist dw_partlist
dw_modellist dw_modellist
end type
type tab_royalty from tab within w_bom115u
tabpage_cal tabpage_cal
tabpage_ryt tabpage_ryt
end type
type uo_refdate from uo_comm_yymm within w_bom115u
end type
type dw_report from datawindow within w_bom115u
end type
type uo_div from uo_plandiv_pdcd within w_bom115u
end type
type pb_down from picturebutton within w_bom115u
end type
type st_6 from statictext within w_bom115u
end type
type str_pccmaq_prname from structure within w_bom115u
end type
end forward

type str_pccmaq_prname from structure
	string		prprcd
	string		prname
	string		coname
end type

global type w_bom115u from w_origin_sheet02
string title = "Royalty 관리윈도우"
dw_customer dw_customer
st_1 st_1
st_2 st_2
tab_royalty tab_royalty
uo_refdate uo_refdate
dw_report dw_report
uo_div uo_div
pb_down pb_down
st_6 st_6
end type
global w_bom115u w_bom115u

type variables
integer i_i_tabindex
string i_s_refdate,i_s_cust,i_s_plant,i_s_div,i_s_modelno,i_s_modelnm,i_s_custnm
datastore i_ds_explo,i_ds_implo
end variables

forward prototypes
public subroutine wf_initset ()
public subroutine wf_setting_gubn (string a_refdate)
public function boolean wf_imp_oversea (decimal a_prelev, string a_refdate, string a_caldate)
public function boolean wf_imp_domestic (decimal a_prelev, string a_refdate, string a_caldate)
public function str_pccmaq_prname wf_get_prname (string a_div, string a_itno)
public function boolean wf_get_samechild (string a_date, string a_cust, string a_plant, string a_dvsn, string a_pcitn, decimal a_levl, string a_explant, string a_exdv)
public function integer wf_explo_royalty (string a_date, string a_cust, string a_div, string a_mdno, string a_chkcd, string a_custnm, string a_mdnm)
public function decimal wf_get_cost_multivendor (string ag_yyyymm, string ag_plant, string ag_dvsn, string ag_itno, decimal ag_cost, string ag_royalty)
public subroutine wf_get_cost_itemchange (string ag_yyyymm, string ag_plant, string ag_dvsn, string ag_itno, string ag_opitn, integer ag_lowlev, datastore lds_ds, integer ag_row)
end prototypes

public subroutine wf_initset ();integer li_currow,li_cntnum
long ll_rowcnt
string ls_refdate,ls_year,ls_month
string ls_preyear,ls_premonth,ls_modstring

tab_royalty.tabpage_cal.dw_rythist.reset()
//tab_royalty.tabpage_cal.dw_prelist.reset()
//현재월보다 한달적은 달을 기준월로 설정
if integer(mid(g_s_date,5,2)) = 1 then
	ls_preyear = string(integer(mid(g_s_date,1,4)) - 1)
	ls_premonth = '12'
else
	ls_preyear = mid(g_s_date,1,4)
	ls_premonth =string(integer(mid(g_s_date,5,2)) - 1)
	if len(ls_premonth) = 1 then
		ls_premonth = '0' + ls_premonth
	end if
end if

li_cntnum = 1
declare hisryt_cur cursor for
	select distinct ryear,rmonth
		from pbpdm.bomt02
		order by ryear desc,rmonth desc
		using sqlca;
		
open hisryt_cur;
	do while true
		fetch hisryt_cur into :ls_year,:ls_month;
			if sqlca.sqlcode <> 0 then
				exit
			end if
			
//			SELECT COUNT(*) INTO :ll_rowcnt
//			 FROM "PBPDM"."BOMT02" INNER JOIN "PBACC"."ACC300"
//				ON ( "PBPDM"."BOMT02"."RCMCD"  = "PBACC"."ACC300"."COMLTD" ) AND
//					( "PBPDM"."BOMT02"."RPLANT" || "PBPDM"."BOMT02"."RDIV"  = "PBACC"."ACC300"."SLDIV" ) AND
//					( "PBPDM"."BOMT02"."RMDNO" = "PBACC"."ACC300"."SLITNO" )   
//					LEFT OUTER JOIN "PBCOMMON"."DAC002"  
//				ON ( "PBPDM"."BOMT02"."RCMCD"  = "PBCOMMON"."DAC002"."COMLTD" ) AND
//					( "PBPDM"."BOMT02"."RCUST" = "PBCOMMON"."DAC002"."COCODE" )
//			WHERE ( "PBPDM"."BOMT02"."RCMCD" = '01' ) AND 
//					( "PBPDM"."BOMT02"."RYEAR" = :ls_year ) AND
//					( "PBPDM"."BOMT02"."RMONTH" = :ls_month ) AND  
//					( "PBCOMMON"."DAC002"."COGUBUN" = 'DAC170' )
//			using sqlca;

			SELECT COUNT(*) INTO :ll_rowcnt
			 FROM "PBPDM"."BOMT02"
			WHERE ( "PBPDM"."BOMT02"."RCMCD" = '01' ) AND 
					( "PBPDM"."BOMT02"."RYEAR" = :ls_year ) AND
					( "PBPDM"."BOMT02"."RMONTH" = :ls_month )
			using sqlca;

			
			if (ls_preyear + ls_premonth) <> (ls_year + ls_month) and li_cntnum = 1 then
				li_currow = tab_royalty.tabpage_cal.dw_rythist.insertrow(0)
				ls_refdate = ls_preyear + "." + ls_premonth
				tab_royalty.tabpage_cal.dw_rythist.setitem(li_currow,"yymm",ls_refdate)
				tab_royalty.tabpage_cal.dw_rythist.setitem(li_currow,"mdsum",0)
				tab_royalty.tabpage_cal.dw_rythist.setitem(li_currow,"chkcd",'미완료')
				ls_modstring = "chkcd.color = '0~tif(yymm = ~~'" + ls_refdate + "~~',rgb(255,0,0),0)'"
				tab_royalty.tabpage_cal.dw_rythist.modify(ls_modstring)
			end if
			li_currow = tab_royalty.tabpage_cal.dw_rythist.insertrow(0)
			ls_refdate = ls_year + "." + ls_month
			tab_royalty.tabpage_cal.dw_rythist.setitem(li_currow,"yymm",ls_refdate)
			tab_royalty.tabpage_cal.dw_rythist.setitem(li_currow,"mdsum",ll_rowcnt)
			tab_royalty.tabpage_cal.dw_rythist.setitem(li_currow,"chkcd",'완료')
			li_cntnum = li_cntnum + 1
	loop
close hisryt_cur;

end subroutine

public subroutine wf_setting_gubn (string a_refdate);integer li_first,li_second,li_third,li_temp
long ll_rowcnt,ll_rowcnt1,ll_rowcnt2,ll_cntloop,ll_cntnum,ll_currow
string ls_plant,ls_dvsn,ls_itno,ls_cust,ls_explant,ls_exdv,ls_gubnchild,ls_wkct,ls_gubn
string ls_fromdt
datastore ds_expdata[]
ds_expdata[1] = create datastore
ds_expdata[1].dataobject = "d_bom001_explo_03"
ds_expdata[2] = create datastore
ds_expdata[2].dataobject = "d_bom001_explo_03"
ds_expdata[3] = create datastore
ds_expdata[3].dataobject = "d_bom001_explo_03"

ds_expdata[1].settransobject(sqlca)
ds_expdata[2].settransobject(sqlca)
ds_expdata[3].settransobject(sqlca)

li_first = 1 
li_second = 2 
li_third = 3
ls_fromdt = a_refdate + '01'
declare gubn_cur cursor for 
  select kryplant,krydvsn,kryitno,krycust  
   	from pbpdm.bom007,pbpdm.bom006
   	where rfcmcd = :g_s_company and
		      rfyymm = :a_refdate and
				krycmcd = rfcmcd and
				kryplant = rfplant and
				krydvsn = rfdvsn  and  
         	kryitno = rfcitn   and
				krycust = rfcust   and
			 	(((kryfromdt <> '        ') AND
			  		(krytodt = '        ') AND
			  		(kryfromdt <= :ls_fromdt)) OR
			 	((kryfromdt <> '        ') AND
			  		(krytodt <> '        ') AND
			  		(kryfromdt <= :ls_fromdt) AND
			  		(krytodt >= :a_refdate)))
		//order by rfllcn asc  
    	using SQLCA ;

open gubn_cur;
	do while true
		fetch gubn_cur into :ls_plant,:ls_dvsn,:ls_itno,:ls_cust ;
			if sqlca.sqlcode <> 0 then
				exit
			end if 
		
		update pbpdm.bom006
			set rfgubn = 'Y' 
			where rfcmcd = :g_s_company and
					rfyymm = :a_refdate and
					rfcust = :ls_cust and
					rfplant = :ls_plant and
					rfdvsn = :ls_dvsn and
					rfcitn = :ls_itno using sqlca;
		
		ll_rowcnt = ds_expdata[li_first].retrieve(ls_plant,ls_dvsn,ls_itno,a_refdate)
		ll_cntloop = 1
		if ll_rowcnt > 0 then
			do while true
				do 
					ls_itno = ds_expdata[li_first].object.pcitn[ll_cntloop]
					ls_plant = ds_expdata[li_first].object.plant[ll_cntloop]
					ls_dvsn = ds_expdata[li_first].object.pdvsn[ll_cntloop]
					ls_explant = ds_expdata[li_first].object.pexplant[ll_cntloop]
					ls_exdv = ds_expdata[li_first].object.pexdv[ll_cntloop]
					ls_wkct = ds_expdata[li_first].object.pwkct[ll_cntloop]
					ls_gubn = trim(ds_expdata[li_first].object.pchdt[ll_cntloop])
					
					if ls_wkct = '8888' or ls_gubn = 'N' then
						ls_gubnchild = 'N'
					else
						ls_gubnchild = 'Y'
					end if
					
					update pbpdm.bom006
						set rfgubn = :ls_gubnchild
						where rfcmcd = :g_s_company and
								rfyymm = :a_refdate and
								rfcust = :ls_cust and
								rfplant = :ls_plant and
								rfdvsn = :ls_dvsn and
								rfcitn = :ls_itno using sqlca;
					
					ll_rowcnt1 = ds_expdata[li_second].retrieve(ls_plant,ls_dvsn,ls_itno,a_refdate)
					for ll_cntnum = 1 to ll_rowcnt1
						ll_currow = ds_expdata[li_third].insertrow(0)
						if f_spacechk(ls_exdv) = -1 then
							ds_expdata[li_third].object.plant[ll_currow] = ds_expdata[li_second].object.plant[ll_cntnum]
							ds_expdata[li_third].object.pdvsn[ll_currow] = ds_expdata[li_second].object.pdvsn[ll_cntnum]
						else
							ds_expdata[li_third].object.plant[ll_currow] = ls_explant
							ds_expdata[li_third].object.pdvsn[ll_currow] = ls_exdv
						end if
						ds_expdata[li_third].object.pcitn[ll_currow] = ds_expdata[li_second].object.pcitn[ll_cntnum]
						ds_expdata[li_third].object.pexplant[ll_currow] = ds_expdata[li_second].object.pexplant[ll_cntnum]
						ds_expdata[li_third].object.pexdv[ll_currow] = ds_expdata[li_second].object.pexdv[ll_cntnum]
						ds_expdata[li_third].object.pwkct[ll_currow] = ds_expdata[li_second].object.pwkct[ll_cntnum]
						ds_expdata[li_third].object.pchdt[ll_currow] = ls_gubnchild
					next					
					ll_cntloop = ll_cntloop + 1
				loop until ll_cntloop > ll_rowcnt
				ds_expdata[li_third].accepttext()
				ds_expdata[li_first].reset()
				ds_expdata[li_second].reset()
				li_temp = li_first
				li_first = li_third
				li_third = li_second
				li_second = li_temp
				ll_rowcnt = ds_expdata[li_first].rowcount()
				if ll_rowcnt < 1 then
					exit	
				end if
				ll_cntloop = 1
			loop
		end if
	loop
close gubn_cur;

destroy ds_expdata[1]
destroy ds_expdata[2]
destroy ds_expdata[3]

end subroutine

public function boolean wf_imp_oversea (decimal a_prelev, string a_refdate, string a_caldate);long ll_rowcnt,ll_cntnum,ll_cntsec,ll_holdrow
dec{0} lc_lev,lc_prelev,lc_cost,lc_costsum
dec{2} lc_costpre
dec{3} lc_pqtym
string ls_plant,ls_div,ls_dvsn,ls_plant01,ls_modelno,ls_itno,ls_pcitn,ls_cust,ls_exdv,ls_explant,ls_pdcd,ls_yymm
string ls_rtnitem

datastore ds_optionchk

ds_optionchk = create datastore
ds_optionchk.dataobject = "d_bom001_115u_optionchk"
ds_optionchk.settransobject(sqlca)

lc_prelev = a_prelev
do until lc_prelev < 1
	//호환주품번 check
	ds_optionchk.reset()
	ll_rowcnt = ds_optionchk.retrieve(a_refdate,lc_prelev)
	for ll_cntnum = 1 to ll_rowcnt
		if f_spacechk(ds_optionchk.object.rfexdv[ll_cntnum]) = -1 then
			ls_plant = ds_optionchk.object.rfplant[ll_cntnum]
			ls_div = ds_optionchk.object.rfdvsn[ll_cntnum]
		else
			ls_plant = ds_optionchk.object.rfplant[ll_cntnum]
			ls_div = ds_optionchk.object.rfexdv[ll_cntnum]
		end if
		ls_itno = ds_optionchk.object.rfcitn[ll_cntnum]
		ls_rtnitem = f_option_chk_after(ls_plant,ls_div,ls_itno, i_s_refdate + '31')
		if f_spacechk(ls_rtnitem) <> -1 then
			ll_holdrow = ll_cntnum
			for ll_cntsec = ll_cntnum + 1 to ll_rowcnt
				if ls_rtnitem = f_option_chk_after(ds_optionchk.object.rfplant[ll_cntsec],ds_optionchk.object.rfdvsn[ll_cntsec] &
														,ds_optionchk.object.rfcitn[ll_cntsec], i_s_refdate + '31') then
					if ds_optionchk.object.rfcost[ll_holdrow] >= ds_optionchk.object.rfcost[ll_cntsec] then
						ds_optionchk.object.rfselt[ll_cntsec] = ' '
						ds_optionchk.object.rfselt[ll_holdrow] = 'Y'
					else
						ds_optionchk.object.rfselt[ll_cntsec] = 'Y'
						ds_optionchk.object.rfselt[ll_holdrow] = ' '
						ll_holdrow = ll_cntsec
					end if
				end if
			next
		end if
	next
	
	if ds_optionchk.update() = 1  then
		//nothing
	else
		uo_status.st_message.text = f_message("B020")
		return false
	end if
	//END CHECK
	
	//외자와 연결된 상위 품번
	declare upitem_cur cursor for  
		select rfyymm,rfcust,rfplant,rfdvsn,rfcitn,rfcost,rfexdv,rfexplant   
			from pbpdm.bom006   
			where (rfyymm = :a_refdate ) and
					(rfllcn = :lc_prelev ) and
					(rfselt = 'Y' )
		using sqlca;
	
	open upitem_cur;	
		do while true
			fetch upitem_cur into :ls_yymm,:ls_cust,:ls_plant01,:ls_dvsn,:ls_pcitn,:lc_cost,:ls_exdv,:ls_explant ;
				if sqlca.sqlcode <> 0 then
					exit
				end if
				
				if f_spacechk(ls_exdv) <> -1 then
					ls_plant = ls_explant
					ls_div = ls_exdv
				else
					ls_plant = ls_plant01
					ls_div = ls_dvsn
				end if
				i_ds_implo.reset()
				ll_rowcnt = i_ds_implo.retrieve(ls_plant,ls_div,ls_pcitn,a_caldate)
				
				if ll_rowcnt < 1 then
					//nothing
				else
					for ll_cntnum = 1 to ll_rowcnt
						ls_itno = i_ds_implo.object.ppitn[ll_cntnum]
						select rfcost into :lc_cost
							from pbpdm.bom006
							where rfyymm = :ls_yymm and
									rfcust = :ls_cust and
									rfplant = :ls_plant and
									rfdvsn = :ls_div and
									rfcitn = :ls_itno using sqlca;
									
						if sqlca.sqlcode = 0 then
							lc_pqtym = i_ds_implo.object.pqtym[ll_cntnum]
							//insert data at BOM005
							select repitn into :ls_modelno
								from pbpdm.bom005
								where reyymm = :ls_yymm and
										recust = :ls_cust and
										replant = :ls_plant and
										redvsn = :ls_dvsn and
										repitn = :ls_itno and
										recitn = :ls_pcitn using sqlca;
							if sqlca.sqlcode <> 0 then
								insert into pbpdm.bom005 (reyymm,recust,redvsn,repitn,recitn,repqty,relevl,reexdv)
									values (:ls_yymm,:ls_cust,:ls_dvsn,:ls_itno,:ls_pcitn,:lc_pqtym,:lc_prelev,:ls_exdv) using sqlca;
								if sqlca.sqlcode <> 0 then
									uo_status.st_message.text = f_message("B020")
									return false
								end if
							end if
							//update cost in BOM006
							select rfcost into :lc_costpre
								from pbpdm.bom006
								where rfyymm = :ls_yymm and
										rfcust = :ls_cust and
										rfplant = :ls_plant and
										rfdvsn = :ls_div and
										rfcitn = :ls_pcitn using sqlca;
							//원단위량과 불출단가를 곱한뒤에 반올림
							lc_costsum = round((lc_costpre * lc_pqtym),0) + lc_cost
							update pbpdm.bom006 
								set rfcost = :lc_costsum , rfselt = 'Y' 
								where rfyymm = :ls_yymm and
										rfcust = :ls_cust and
										rfplant = :ls_plant and
										rfdvsn = :ls_dvsn and
										rfcitn = :ls_itno 
								using sqlca;
						end if
					next
				end if
		loop
	close upitem_cur;
	lc_prelev = lc_prelev - 1
loop

destroy ds_optionchk
return true
end function

public function boolean wf_imp_domestic (decimal a_prelev, string a_refdate, string a_caldate);long ll_rowcnt,ll_cntnum,ll_cntsec,ll_holdrow
dec{0} lc_lev,lc_prelev,lc_cost,lc_costsum
dec{2} lc_costpre
dec{3} lc_pqtym
string ls_plant,ls_div,ls_plant01,ls_dvsn,ls_modelno,ls_itno,ls_pcitn,ls_cust,ls_explant,ls_exdv,ls_pdcd,ls_yymm
string ls_rtnitem

datastore ds_optionchk

ds_optionchk = create datastore
ds_optionchk.dataobject = "d_bom001_115u_optionchk"
ds_optionchk.settransobject(sqlca)

lc_prelev = a_prelev
do until lc_prelev < 1
	//호환주품번 check
	ds_optionchk.reset()
	ll_rowcnt = ds_optionchk.retrieve(a_refdate,lc_prelev)
	for ll_cntnum = 1 to ll_rowcnt
		if ds_optionchk.object.rfexdv[ll_cntnum] = ' ' then
			ls_plant = ds_optionchk.object.rfplant[ll_cntnum]
			ls_div = ds_optionchk.object.rfdvsn[ll_cntnum]
		else
			ls_plant = ds_optionchk.object.rfexplant[ll_cntnum]
			ls_div = ds_optionchk.object.rfexdv[ll_cntnum]
		end if
		ls_itno = ds_optionchk.object.rfcitn[ll_cntnum]
		ls_rtnitem = f_option_chk_after(ls_plant,ls_div,ls_itno, i_s_refdate + '31')
		if f_spacechk(ls_rtnitem) <> -1 then
			ll_holdrow = ll_cntnum
			for ll_cntsec = ll_cntnum + 1 to ll_rowcnt
				if ls_rtnitem = f_option_chk_after(ds_optionchk.object.rfplant[ll_cntsec],ds_optionchk.object.rfdvsn[ll_cntsec] &
														  ,ds_optionchk.object.rfcitn[ll_cntsec], i_s_refdate + '31') then
					if ds_optionchk.object.rfcost[ll_holdrow] >= ds_optionchk.object.rfcost[ll_cntsec] then
						ds_optionchk.object.rfselt[ll_cntsec] = ' '
						ds_optionchk.object.rfselt[ll_holdrow] = 'Y'
					else
						ds_optionchk.object.rfselt[ll_cntsec] = 'Y'
						ds_optionchk.object.rfselt[ll_holdrow] = ' '
						ll_holdrow = ll_cntsec
					end if
				end if
			next
		end if
	next
	
	if ds_optionchk.update() = 1  then
		//nothing
	else
		uo_status.st_message.text = f_message("B020")
		return false
	end if
	//END CHECK
	
	//외자와 연결된 상위 품번
	declare upitem_cur cursor for  
		select rfyymm,rfcust,rfplant,rfdvsn,rfcitn,rfcost,rfexdv,rfexplant   
			from pbpdm.bom006   
			where (rfyymm = :a_refdate ) and
					(rfllcn = :lc_prelev ) and
					(rfselt = 'Y' )
		using sqlca;
	
	open upitem_cur;	
		do while true
			fetch upitem_cur into :ls_yymm,:ls_cust,:ls_plant01,:ls_dvsn,:ls_pcitn,:lc_cost,:ls_exdv,:ls_explant ;
				if sqlca.sqlcode <> 0 then
					exit
				end if
				
				if f_spacechk(ls_exdv) <> -1 then
					ls_div = ls_exdv
					ls_plant = ls_explant
				else
					ls_div = ls_dvsn
					ls_plant = ls_plant01
				end if
				i_ds_implo.reset()
				ll_rowcnt = i_ds_implo.retrieve(ls_plant,ls_div,ls_pcitn,a_caldate)
				
				if ll_rowcnt < 1 then
					//nothing
				else
					for ll_cntnum = 1 to ll_rowcnt
						ls_itno = i_ds_implo.object.ppitn[ll_cntnum]
						select rfcost into :lc_cost
							from pbpdm.bom006
							where rfyymm = :ls_yymm and
									rfcust = :ls_cust and
									rfplant = :ls_plant and
									rfdvsn = :ls_div and
									rfcitn = :ls_itno using sqlca;
									
						if sqlca.sqlcode = 0 then
							lc_pqtym = i_ds_implo.object.pqtym[ll_cntnum]
							//insert data at BOM005
							select repitn into :ls_modelno
								from pbpdm.bom005
								where reyymm = :ls_yymm and
										recust = :ls_cust and
										replant = :ls_plant01 and
										redvsn = :ls_dvsn and
										repitn = :ls_itno and
										recitn = :ls_pcitn using sqlca;
							if sqlca.sqlcode <> 0 then
								insert into pbpdm.bom005 (reyymm,recust,redvsn,repitn,recitn,repqty,relevl,reexdv)
									values (:ls_yymm,:ls_cust,:ls_dvsn,:ls_itno,:ls_pcitn,:lc_pqtym,:lc_prelev,:ls_exdv) using sqlca;
								if sqlca.sqlcode <> 0 then
									uo_status.st_message.text = f_message("B020")
									return false
								end if
							end if
							//update cost in BOM006
							select rfcost into :lc_costpre
								from pbpdm.bom006
								where rfyymm = :ls_yymm and
										rfcust = :ls_cust and
										rfplant = :ls_plant and
										rfdvsn = :ls_div and
										rfcitn = :ls_pcitn using sqlca;
							//원단위량과 불출단가를 곱한뒤에 반올림
							lc_costsum = round((lc_costpre * lc_pqtym),0) + lc_cost
							update pbpdm.bom006 
								set rfcost = :lc_costsum , rfselt = 'Y' 
								where rfyymm = :ls_yymm and
										rfcust = :ls_cust and
										rfplant = :ls_plant01 and
										rfdvsn = :ls_dvsn and
										rfcitn = :ls_itno 
								using sqlca;
						end if
					next
				end if
		loop
	close upitem_cur;
	lc_prelev = lc_prelev - 1
loop

destroy ds_optionchk
return true
end function

public function str_pccmaq_prname wf_get_prname (string a_div, string a_itno);str_pccmaq_prname rtn_prnm
string ls_prcd
 
select coitname
	into :rtn_prnm.coname
	from pbcommon.dac002  
	where ( cogubun = 'ACC001' ) and  
     	 	( cocode = :a_div )  using sqlca;
			
select a.slprcd, b.prname into :rtn_prnm.prprcd, :rtn_prnm.prname 
	from pbacc.acc300 a, pbcommon.dac007 b  
	where a.comltd = b.comltd and
			{fn substring(a.slprcd,1,2)} = b.prprcd and
			a.sldiv = :a_div and
			a.slitno = :a_itno using sqlca;
		  
return rtn_prnm
end function

public function boolean wf_get_samechild (string a_date, string a_cust, string a_plant, string a_dvsn, string a_pcitn, decimal a_levl, string a_explant, string a_exdv);boolean lb_rtn
long ll_cntsum
string ls_chgdiv,ls_chkitno
dec{2} lc_itcost
dec{0} lc_chklev

if f_spacechk(a_exdv) <> -1 then
	ls_chgdiv = a_dvsn
	a_dvsn = a_exdv
	a_exdv = ls_chgdiv
else
	//nothing
end if

select rfcitn into :ls_chkitno
	from pbpdm.bom006
	where rfcmcd = :g_s_company and
			rfyymm = :a_date and
			rfcust = :a_cust and
			rfplant = :a_plant and
			rfdvsn = :a_dvsn and
			rfcitn = :a_pcitn 	  
	using SQLCA ;

//bom006에 같은 레코드가 없는 경우
if len(ls_chkitno) < 1 then
		insert into pbpdm.bom006 (rfcmcd,rfyymm,rfcust,rfplant,rfdvsn,rfcitn,rfcost,rfcosd,rfllcn,rfselt,rfexplant,rfexdv,rfgubn)
			values (:g_s_company,:a_date,:a_cust,:a_plant,:a_dvsn,:a_pcitn,0,0,:a_levl,' ',:a_explant,:a_exdv,' ') using sqlca;
		if sqlca.sqlcode <> 0 then
			messagebox("chk1",sqlca.sqlerrtext)
			return false
		end if
//bom006에 같은 레코드가 있는 경우
else
	if lc_chklev = a_levl then
		//nothing
	else
		update pbpdm.bom006 
			set rfllcn = :a_levl
				where rfcmcd = :g_s_company and
						rfyymm = :a_date and
						rfcust = :a_cust and
						rfplant = :a_plant and
						rfdvsn = :a_dvsn and
						rfcitn = :a_pcitn 
				using sqlca;
		if sqlca.sqlcode <> 0 then
			messagebox("chk2",sqlca.sqlerrtext)
			return false
		end if
	end if
end if

return true
end function

public function integer wf_explo_royalty (string a_date, string a_cust, string a_div, string a_mdno, string a_chkcd, string a_custnm, string a_mdnm);// a_chkcd 가 'M'는 하나의 모델을 'A'일때는 업체별로 하위전개 함
integer 	li_first,li_second,li_third,li_temp,li_exitcnt
long 		ll_cntrow,ll_cntloop,ll_cntrow1,ll_cntx,ll_currow,ll_findrow,ll_findrowcnt
dec{3} 	lc_pqtymf,lc_pqtyms
dec{2} 	lc_coct, lc_rfcsto
dec{0} 	lc_cost, lc_rfqty, lc_rftqty
string   ls_rfopitn
string 	ls_plant,ls_div,ls_dvsn,ls_pcitn,ls_exdv,ls_explant,ls_chgdv,ls_chgplant,ls_gubn,ls_Selt
s_itemasa_data rtn_asa
s_invdata_info rtn_inv
str_pccmaq_prname rtn_maq
datastore ds_explo[3]

ds_explo[1] = create datastore
ds_explo[1].dataobject = "d_bom001_115u_explo"
ds_explo[1].settransobject(sqlca)

ds_explo[2] = create datastore
ds_explo[2].dataobject = "d_bom001_115u_explo"
ds_explo[2].settransobject(sqlca)

ds_explo[3] = create datastore
ds_explo[3].dataobject = "d_bom001_115u_explo"
ds_explo[3].settransobject(sqlca)

ll_cntx 		= 1
ll_cntloop 	= 1
li_exitcnt 	= 1
li_first 	= 1
li_second 	= 2
li_third 	= 3

ls_chgplant = mid(a_div,1,1)
ls_chgdv = mid(a_div,2,1)

rtn_maq 		= wf_get_prname(a_div,a_mdno)

SELECT	"PBPDM"."BOM011"."BDIV"  
   INTO 	:ls_chgdv  
FROM 		"PBPDM"."BOM011"  
WHERE ( 	"PBPDM"."BOM011"."CMCD" 	= :g_s_company ) AND  
      ( 	"PBPDM"."BOM011"."GUBUN" 	= 'C' ) AND  
      ( 	"PBPDM"."BOM011"."AREA" 	= :ls_chgdv )   
using sqlca;
			
ll_cntrow 	= ds_explo[li_first].retrieve(a_date,a_cust,ls_chgplant,ls_chgdv,a_mdno)

if ll_cntrow < 1 then 
	uo_status.st_message.text = f_message("E030")
	return 0
end if

// Finding Child_item
do while true
	do
		ls_pcitn 	= trim(ds_explo[li_first].object.recitn[ll_cntloop])
		lc_pqtymf 	= ds_explo[li_first].object.repqty[ll_cntloop]
		ls_explant 	= ds_explo[li_first].object.reexplant[ll_cntloop]
		ls_exdv 		= ds_explo[li_first].object.reexdv[ll_cntloop]
//		if f_spacechk(ls_exdv) = -1 then
			ls_plant = ds_explo[li_first].object.replant[ll_cntloop]
			ls_div 	= ds_explo[li_first].object.redvsn[ll_cntloop]
//		else
//			ls_plant = ls_explant
//			ls_div 	= ls_exdv
//		end if
		ll_cntrow1 = ds_explo[li_second].retrieve(a_date,a_cust,ls_plant,ls_div,ls_pcitn)
		select 	rfcost,rfgubn,rfqty,rftqty,rfcsto,rfopitn 
		into :lc_coct,:ls_gubn,:lc_rfqty,:lc_rftqty,:lc_rfcsto,:ls_rfopitn
		from pbpdm.bom006
		where 	rfyymm = :i_s_refdate and
					rfcust = :i_s_cust and
					rfplant = :ls_plant and
					rfdvsn = :ls_div and
					rfcitn = :ls_pcitn  using sqlca;
						
		if ll_cntrow1 < 1 and ls_gubn <> 'Y' then	
			rtn_asa = f_bom_get_itemasa(ls_pcitn)
			rtn_inv = f_bom_get_curinv(ls_plant,ls_div,ls_pcitn)
			lc_cost = round(lc_pqtymf * lc_coct,0)
			
			//external에 자재를 입력
			if a_chkcd = 'M' then
				ll_findrowcnt 	= tab_royalty.tabpage_ryt.dw_partlist.rowcount()
				ll_findrow 		= tab_royalty.tabpage_ryt.dw_partlist.find("itno = '" + ls_pcitn + "'",1,ll_findrowcnt)
				if ll_findrow 	<> 0 then
					lc_pqtymf 	= lc_pqtymf + tab_royalty.tabpage_ryt.dw_partlist.object.itpqtym[ll_findrow]
					lc_cost 		= round(lc_pqtymf * lc_coct,0)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_findrow,"itpqtym", lc_pqtymf)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_findrow,"itcost", lc_cost)
					
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_findrow,"rfqty", lc_rfqty)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_findrow,"rftqty", lc_rftqty)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_findrow,"rfcsto", lc_rfcsto)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_findrow,"rfopitn", ls_rfopitn)
				else
					ll_currow 	= tab_royalty.tabpage_ryt.dw_partlist.insertrow(0)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itno", ls_pcitn)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itnm", rtn_asa.itname)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itspec", rtn_asa.itspec)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itnmsr", rtn_asa.itunit)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itumcv", rtn_inv.it_iumcv)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itprum", rtn_inv.it_prum)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itpqtym", lc_pqtymf)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itcoct", lc_coct)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itcost", lc_cost)
					
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"rfqty", lc_rfqty)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"rftqty", lc_rftqty)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"rfcsto", lc_rfcsto)
					tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"rfopitn", ls_rfopitn)
				end if
			else
				ll_findrowcnt 	= dw_report.rowcount()
				ll_findrow 		= dw_report.find("mdno = '" + a_mdno +"'" + "and itno = '" + ls_pcitn + "'",1,ll_findrowcnt)
				if ll_findrow <> 0 then
					lc_pqtymf = lc_pqtymf + dw_report.object.itpqtym[ll_findrow]
					lc_cost = round(lc_pqtymf * lc_coct,0)
					dw_report.setitem(ll_findrow,"itpqtym", lc_pqtymf)
					dw_report.setitem(ll_findrow,"itcost", lc_cost)
					
//					dw_report.setitem( ll_findrow,"rfqty", lc_rfqty)
//					dw_report.setitem( ll_findrow,"rftqty", lc_rftqty)
//					dw_report.setitem( ll_findrow,"rfcsto", lc_rfcsto)
//					dw_report.setitem( ll_findrow,"rfopitn", ls_rfopitn)
				else
					ll_currow = dw_report.insertrow(0)
					dw_report.setitem(ll_currow,"cust",a_custnm)
					dw_report.setitem(ll_currow,"divnm",rtn_maq.coname)
					dw_report.setitem(ll_currow,"prcd",mid(rtn_maq.prprcd,1,2))
					dw_report.setitem(ll_currow,"prnm",rtn_maq.prname)
					dw_report.setitem(ll_currow,"mdno",a_mdno)
					dw_report.setitem(ll_currow,"mdnm",a_mdnm)
					dw_report.setitem(ll_currow,"refdate",a_date)
					dw_report.setitem(ll_currow,"itno",ls_pcitn)
					dw_report.setitem(ll_currow,"itnm",rtn_asa.itname)
					dw_report.setitem(ll_currow,"itspec",rtn_asa.itspec)
					dw_report.setitem(ll_currow,"itnmsr",rtn_asa.itunit)
					dw_report.setitem(ll_currow,"itumcv", rtn_inv.it_iumcv)
					dw_report.setitem(ll_currow,"itprum", rtn_inv.it_prum)
					dw_report.setitem(ll_currow,"itpqtym", lc_pqtymf)
					dw_report.setitem(ll_currow,"itcoct", lc_coct)
					dw_report.setitem(ll_currow,"itcost", lc_cost)
					
//					dw_report.setitem( ll_currow,"rfqty", lc_rfqty)
//					dw_report.setitem( ll_currow,"rftqty", lc_rftqty)
//					dw_report.setitem( ll_currow,"rfcsto", lc_rfcsto)
//					dw_report.setitem( ll_currow,"rfopitn", ls_rfopitn)
				end if
			end if
			li_exitcnt = li_exitcnt + 1
		else	
			//ls_gubn = ds_explo[li_second].object.bom006_rfgubn[ll_cntx]    //2001.07 추가로직(start)
			//ls_pcitn = ds_explo[li_second].object.recitn[ll_cntx]
			if ls_gubn = 'Y' then
				select 	rfcosd into :lc_coct	from pbpdm.bom006
				where 	rfyymm 	= :i_s_refdate and
							rfcust 	= :i_s_cust and
							rfplant 	= :ls_plant and
							rfdvsn 	= :ls_div and
							rfcitn 	= :ls_pcitn  
				using sqlca;	
				rtn_asa = f_bom_get_itemasa(ls_pcitn)
				rtn_inv = f_bom_get_curinv(ls_plant,ls_div,ls_pcitn)
				lc_cost = round(lc_pqtymf * lc_coct,0)
					
				//external에 자재를 입력
				if a_chkcd = 'M' then
					ll_findrowcnt 	= tab_royalty.tabpage_ryt.dw_partlist.rowcount()
					ll_findrow 		= tab_royalty.tabpage_ryt.dw_partlist.find("itno = '" + ls_pcitn + "'",1,ll_findrowcnt)
					if ll_findrow <> 0 then
						lc_pqtymf 	= lc_pqtymf + tab_royalty.tabpage_ryt.dw_partlist.object.itpqtym[ll_findrow]
						lc_cost 		= round(lc_pqtymf * lc_coct,0)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_findrow,"itpqtym", lc_pqtymf)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_findrow,"itcost", lc_cost)
					else
						ll_currow = tab_royalty.tabpage_ryt.dw_partlist.insertrow(0)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itno", ls_pcitn)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itnm", rtn_asa.itname)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itspec", rtn_asa.itspec)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itnmsr", rtn_asa.itunit)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itumcv", rtn_inv.it_iumcv)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itprum", rtn_inv.it_prum)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itpqtym", lc_pqtymf)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itcoct", lc_coct)
						tab_royalty.tabpage_ryt.dw_partlist.setitem( ll_currow,"itcost", lc_cost)
					end if
				else
					ll_findrowcnt 	= dw_report.rowcount()
					ll_findrow 		= dw_report.find("mdno = '" + a_mdno +"'" + "and itno = '" + ls_pcitn + "'",1,ll_findrowcnt)
					if ll_findrow <> 0 then
						lc_pqtymf 	= lc_pqtymf + dw_report.object.itpqtym[ll_findrow]
						lc_cost 		= round(lc_pqtymf * lc_coct,0)
						dw_report.setitem(ll_findrow,"itpqtym", lc_pqtymf)
						dw_report.setitem(ll_findrow,"itcost", lc_cost)
					else
						ll_currow = dw_report.insertrow(0)
						dw_report.setitem(ll_currow,"cust",a_custnm)
						dw_report.setitem(ll_currow,"divnm",rtn_maq.coname)
						dw_report.setitem(ll_currow,"prcd",mid(rtn_maq.prprcd,1,2))
						dw_report.setitem(ll_currow,"prnm",rtn_maq.prname)
						dw_report.setitem(ll_currow,"mdno",a_mdno)
						dw_report.setitem(ll_currow,"mdnm",a_mdnm)
						dw_report.setitem(ll_currow,"refdate",a_date)
						dw_report.setitem(ll_currow,"itno",ls_pcitn)
						dw_report.setitem(ll_currow,"itnm",rtn_asa.itname)
						dw_report.setitem(ll_currow,"itspec",rtn_asa.itspec)
						dw_report.setitem(ll_currow,"itnmsr",rtn_asa.itunit)
						dw_report.setitem(ll_currow,"itumcv", rtn_inv.it_iumcv)
						dw_report.setitem(ll_currow,"itprum", rtn_inv.it_prum)
						dw_report.setitem(ll_currow,"itpqtym", lc_pqtymf)
						dw_report.setitem(ll_currow,"itcoct", lc_coct)
						dw_report.setitem(ll_currow,"itcost", lc_cost)
					end if
				end if	
			end if																				//2001.07추가로직(stop) 
			if ll_cntrow1 > 0 then
				do
			
					ls_pcitn 	= ds_explo[li_second].object.recitn[ll_cntx]
					lc_pqtyms 	= lc_pqtymf * ds_explo[li_second].object.repqty[ll_cntx]
					ls_explant 	= ds_explo[li_second].object.reexplant[ll_cntx]
					ls_exdv 		= ds_explo[li_second].object.reexdv[ll_cntx]
					ls_plant		= ds_explo[li_second].object.rePlant[ll_cntx]
					ls_Dvsn		= ds_explo[li_second].object.redvsn[ll_cntx]
					ls_selt		= ds_explo[li_second].object.bom006_rfselt[ll_cntx]
					ls_gubn		= ds_explo[li_second].object.bom006_rfgubn[ll_cntx]
					
					ll_currow 	= ds_explo[li_third].insertrow(0)
					ds_explo[li_third].object.redvsn[ll_currow] 			= ls_div
					ds_explo[li_third].object.recitn[ll_currow] 			= ls_pcitn
					ds_explo[li_third].object.repqty[ll_currow] 			= lc_pqtyms
					ds_explo[li_third].object.reexplant[ll_currow] 		= ls_explant
					ds_explo[li_third].object.reexdv[ll_currow] 			= ls_exdv
					ds_explo[li_third].object.replant[ll_currow] 		= ls_plant
					ds_explo[li_third].object.redvsn[ll_currow] 			= ls_dvsn
					ds_explo[li_third].object.bom006_rfselt[ll_currow] = ls_selt
					ds_explo[li_third].object.bom006_rfgubn[ll_currow] = ls_gubn
															
					ll_cntx = ll_cntx + 1
				loop until ll_cntx > ll_cntrow1
			end if
		end if
		ll_cntx = 1
		ll_cntloop = ll_cntloop + 1
	loop until ll_cntloop > ll_cntrow
	ds_explo[li_third].accepttext()
	ds_explo[li_first].reset()
	ds_explo[li_second].reset()
	li_temp = li_first
	li_first = li_third
	li_third = li_second
	li_second = li_temp
	ll_cntrow = ds_explo[li_first].rowcount()
	if ll_cntrow < 1 then
		exit
	end if
	ll_cntloop = 1
	li_exitcnt = 1
loop
return 1
end function

public function decimal wf_get_cost_multivendor (string ag_yyyymm, string ag_plant, string ag_dvsn, string ag_itno, decimal ag_cost, string ag_royalty);dec{1} ld_royalty_qty, ld_total_qty
dec{2} ld_return_cost
string ls_from_dt, ls_to_dt, ls_royalty
long ll_count

ls_from_dt = f_relative_month(ag_yyyymm, -5)
ls_to_dt = f_relativedate(f_relative_month(ag_yyyymm,1),-1)

if ag_royalty = 'E' then
	ls_royalty = 'G'
else
	ls_royalty = ag_royalty
end if
// 이원화 품목에 대한 불출단가 계산
// 공제품번당월불출평균단가(ag_cost) * (공제대상업체품번최근6개월입고수량 / 공제품번최근6개월 총입고수량 )

//이원화 여부 판단
select count(*) into :ll_count
from pbpur.pur102 a inner join pbpur.pur103 b
	on a.comltd = b.comltd and a.vsrno = b.vsrno and
      a.dept = b.dept and b.vsrc = 'I'
   inner join pbinv.inv101 c
	on b.comltd = c.comltd and b.itno = c.itno
where c.comltd = '01'
and c.xplant = :ag_plant and c.div = :ag_dvsn and 
	c.itno = :ag_itno and trim(c.indus) = :ls_royalty
using sqlca;

if ll_count < 2 then
	return ag_cost
end if

//공제대상업체품번최근6개월입고수량
select sum(f.tqty4) into :ld_royalty_qty
from ( select c.comltd,c.xplant,c.div,c.itno,b.vsrno,a.royalty,c.indus
from pbpur.pur102 a inner join pbpur.pur103 b
	on a.comltd = b.comltd and a.vsrno = b.vsrno and
      a.dept = b.dept and b.vsrc = 'I'
   inner join pbinv.inv101 c
	on b.comltd = c.comltd and b.itno = c.itno
where a.comltd = '01'
and c.xplant = :ag_plant and c.div = :ag_dvsn and 
	b.itno = :ag_itno and a.royalty = :ls_royalty ) d,
	pbinv.inv401 f
where f.comltd = d.comltd and f.xplant = d.xplant and
		f.div = d.div and f.itno = d.itno and 
		f.vndr = d.vsrno and f.sliptype in ('RF','RP') and
		f.tdte4 >= :ls_from_dt and f.tdte4 <= :ls_to_dt
using sqlca;

if isnull(ld_royalty_qty) then ld_royalty_qty = 0
//공제품번최근6개월 총입고수량
select sum(tqty4) into :ld_total_qty
from pbinv.inv401
where comltd = '01' and xplant = :ag_plant and 
		div = :ag_dvsn and itno = :ag_itno and
		sliptype in ('RF','RP') and
		tdte4 >= :ls_from_dt and tdte4 <= :ls_to_dt
using sqlca;

if isnull(ld_total_qty) then ld_total_qty = 0
if ld_total_qty = 0 then
	ld_return_cost = 0
else
	ld_return_cost = ag_cost * ld_royalty_qty / ld_total_qty
end if

update PBPDM.bom006
set rfqty = :ld_royalty_qty, rftqty = :ld_total_qty, rfcsto = :ag_cost,
	 rfopitn = '', rfempno = :g_s_empno, rfdate = :g_s_date
where rfcmcd = :g_s_company and
		rfyymm = :ag_yyyymm and
		rfcust = :ag_royalty and
		rfplant = :ag_plant and
		rfdvsn = :ag_dvsn and
		rfcitn = :ag_itno  using sqlca;
		
return ld_return_cost
end function

public subroutine wf_get_cost_itemchange (string ag_yyyymm, string ag_plant, string ag_dvsn, string ag_itno, string ag_opitn, integer ag_lowlev, datastore lds_ds, integer ag_row);dec{2} ld_return_cost, ld_cost
dec{1} ld_total_qty, ld_each_qty
string ls_from_dt, ls_to_dt
long ll_count

ls_from_dt = f_relative_month(ag_yyyymm, -5)
ls_to_dt = f_relativedate(f_relative_month(ag_yyyymm,1),-1)
ld_cost = lds_ds.object.rfcost[ag_row]

select sum(tmp.sum_qty) into :ld_total_qty
from ( select f.itno,sum(f.tqty4) as sum_qty
from pbinv.inv401 f inner join (
select b.rfcmcd,b.rfplant,b.rfdvsn,b.rfcitn 
from pbpdm.bom003 a inner join pbpdm.bom006 b
  on a.ocmcd = b.rfcmcd and a.oplant = b.rfplant and
    a.odvsn = b.rfdvsn and a.ofitn = b.rfcitn
where b.rfcmcd = '01' and b.rfyymm = :ag_yyyymm and
  b.rfplant = :ag_plant and b.rfdvsn = :ag_dvsn and
  b.rfllcn = :ag_lowlev and 
//  b.rfselt = 'Y' and b.rfgubn = 'Y' and 
  a.opitn = :ag_opitn and
  (( trim(a.oedte) = '' and a.oedtm <= :ls_to_dt ) or
   ( trim(a.oedte) <> '' and a.oedtm <= :ls_to_dt and a.oedte >= :ls_to_dt ))) d
	on f.comltd = d.rfcmcd and f.xplant = d.rfplant and
		f.div = d.rfdvsn and f.itno = d.rfcitn
where f.sliptype in ('RF','RP') and
		f.tdte4 >= :ls_from_dt and f.tdte4 <= :ls_to_dt
group by f.itno
union
select f.itno,sum(f.tqty4)
from pbinv.inv401 f inner join pbpdm.bom006 d
	on f.comltd = d.rfcmcd and f.xplant = d.rfplant and
		f.div = d.rfdvsn and f.itno = d.rfcitn
where d.rfcmcd = '01' and d.rfyymm = :ag_yyyymm and
  d.rfplant = :ag_plant and d.rfdvsn = :ag_dvsn and
  d.rfllcn = :ag_lowlev and 
//  d.rfselt = 'Y' and d.rfgubn = 'Y' and 
  d.rfcitn = :ag_opitn and
  f.sliptype in ('RF','RP') and
	f.tdte4 >= :ls_from_dt and f.tdte4 <= :ls_to_dt
group by f.itno ) tmp
using sqlca;

if isnull(ld_total_qty) then ld_total_qty = 0
if ld_total_qty = 0 then 
	lds_ds.object.rfcost[ag_row] = 0
	lds_ds.object.rfqty[ag_row] = 0
	lds_ds.object.rftqty[ag_row] = 0
	lds_ds.object.rfcsto[ag_row] = ld_cost
	lds_ds.object.rfopitn[ag_row] = ag_opitn
	lds_ds.object.rfempno[ag_row] = g_s_empno
	lds_ds.object.rfdate[ag_row] = g_s_date
	
	return
end if

select sum(f.tqty4) into :ld_each_qty
from pbinv.inv401 f inner join pbpdm.bom006 d
	on f.comltd = d.rfcmcd and f.xplant = d.rfplant and
		f.div = d.rfdvsn and f.itno = d.rfcitn
where d.rfcmcd = '01' and d.rfyymm = :ag_yyyymm and
  d.rfplant = :ag_plant and d.rfdvsn = :ag_dvsn and
  d.rfllcn = :ag_lowlev and 
//  d.rfselt = 'Y' and d.rfgubn = 'Y' and 
  d.rfcitn = :ag_itno and
  f.sliptype in ('RF','RP') and
	f.tdte4 >= :ls_from_dt and f.tdte4 <= :ls_to_dt
using sqlca;

if isnull(ld_each_qty) then ld_each_qty = 0
if ld_each_qty = 0 then 
	lds_ds.object.rfcost[ag_row] = 0
	lds_ds.object.rfqty[ag_row] = 0
	lds_ds.object.rftqty[ag_row] = ld_total_qty
	lds_ds.object.rfcsto[ag_row] = ld_cost
	lds_ds.object.rfopitn[ag_row] = ag_opitn
	lds_ds.object.rfempno[ag_row] = g_s_empno
	lds_ds.object.rfdate[ag_row] = g_s_date
	
	return
end if

ld_return_cost = ld_cost * ld_each_qty / ld_total_qty
lds_ds.object.rfcost[ag_row] = ld_return_cost
lds_ds.object.rfqty[ag_row] = ld_each_qty
lds_ds.object.rftqty[ag_row] = ld_total_qty
lds_ds.object.rfcsto[ag_row] = ld_cost
lds_ds.object.rfopitn[ag_row] = ag_opitn
lds_ds.object.rfempno[ag_row] = g_s_empno
lds_ds.object.rfdate[ag_row] = g_s_date
return
end subroutine

on w_bom115u.create
int iCurrent
call super::create
this.dw_customer=create dw_customer
this.st_1=create st_1
this.st_2=create st_2
this.tab_royalty=create tab_royalty
this.uo_refdate=create uo_refdate
this.dw_report=create dw_report
this.uo_div=create uo_div
this.pb_down=create pb_down
this.st_6=create st_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_customer
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.tab_royalty
this.Control[iCurrent+5]=this.uo_refdate
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.uo_div
this.Control[iCurrent+8]=this.pb_down
this.Control[iCurrent+9]=this.st_6
end on

on w_bom115u.destroy
call super::destroy
destroy(this.dw_customer)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.tab_royalty)
destroy(this.uo_refdate)
destroy(this.dw_report)
destroy(this.uo_div)
destroy(this.pb_down)
destroy(this.st_6)
end on

event ue_retrieve;string ls_plant,ls_div,ls_newsql,ls_rtncd
integer li_rowcnt
datawindowchild child_cust,child_plant
uo_status.st_message.text = ""
i_s_refdate = string(uo_refdate.uf_yyyymm())
i_s_cust = dw_customer.gettext()
dw_customer.getchild("coitname",child_cust)
i_s_custnm = child_cust.getitemstring(child_cust.getrow(),"coitname")

ls_rtncd = uo_div.uf_return()
ls_plant = mid(ls_rtncd,1,1)
ls_div  = mid(ls_rtncd,2,1)

tab_royalty.tabpage_ryt.dw_modellist.reset()
tab_royalty.tabpage_ryt.dw_partlist.reset()
if i_i_tabindex = 1 then
	//nothing
elseif i_i_tabindex = 2 then
	li_rowcnt = tab_royalty.tabpage_ryt.dw_modellist.retrieve(i_s_refdate,i_s_cust,ls_plant,ls_div)
end if

if li_rowcnt < 1 then
	uo_status.st_message.text = f_message("I020")
else
	uo_status.st_message.text = f_message("I010")
end if
end event

event open;call super::open;i_ds_explo = create datastore
i_ds_explo.dataobject = "d_bom001_explo_03"
i_ds_implo = create datastore
i_ds_implo.dataobject = "d_bom001_implo_03"


i_ds_implo.settransobject(sqlca)
i_ds_explo.settransobject(sqlca)
tab_royalty.tabpage_cal.dw_prelist.settransobject(sqlca)
tab_royalty.tabpage_ryt.dw_modellist.settransobject(sqlca)

// 회계요청 : 접근담당자 진행상황 표시
uo_status.st_message.text   = f_get_accflow(g_s_company,'A','A20','','')

end event

event close;destroy i_ds_explo
destroy i_ds_implo



end event

event ue_save;call super::ue_save;string ls_year,ls_month
integer l_n_rcnt

ls_year = tab_royalty.tabpage_cal.dw_prelist.object.bomt02_ryear[1]
ls_month = tab_royalty.tabpage_cal.dw_prelist.object.bomt02_rmonth[1]

// delete all data being refdate from  bomt02 
delete from pbpdm.bomt02
	where ryear = :ls_year and
			rmonth = :ls_month using sqlca;

if tab_royalty.tabpage_cal.dw_prelist.update() = 1 then
	commit using sqlca;
	uo_status.st_message.text = f_message("U010")
	//Royalty정산 내역 Display
	wf_initset()
	i_b_retrieve = false
	i_b_insert = true
	i_b_save  = false
	i_b_delete = false
	i_b_print  = false
	wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  i_b_dprint,    i_b_dchar)
else 
	rollback using sqlca;
	uo_status.st_message.text = f_message("U020")
end if

l_n_rcnt = f_get_accflowupdate(g_s_company,'A','A20','','')
if l_n_rcnt <> 0 then
	uo_status.st_message.text   =  "결산진행FLOW ERROR " + string(l_n_rcnt,'0') 
end if 

return 0



end event

event ue_print;integer li_rowcnt,li_cntnum,li_currow,li_rtn,li_rtncode
string mod_string,ls_plant,ls_div,ls_modelno,ls_modelnm,ls_dvsn

window 	l_to_open
str_easy l_str_prt

dw_report.reset()
li_rtn = messagebox("확인", "공장의 전모델인쇄는 Yes,모델인쇄는 No," &
						+ "인쇄취소는 Cancel",question!,yesnocancel!,1)
//출력 윈도우에 Data 전달, 출력 윈도우 Open 
SetPointer(HourGlass!)
uo_status.st_message.Text = "출력 준비중 입니다..."
if li_rtn = 2 then
	li_rtncode = wf_explo_royalty(i_s_refdate,i_s_cust,i_s_div,i_s_modelno,'A',i_s_custnm,i_s_modelnm)
elseif li_rtn = 1 then
	//Data transfer from dw_2 to dw_cost_report
	li_rowcnt = tab_royalty.tabpage_ryt.dw_modellist.rowcount()
	for li_cntnum = 1 to li_rowcnt
		ls_div = tab_royalty.tabpage_ryt.dw_modellist.object.acc300_sldiv[li_cntnum]
		ls_modelno = tab_royalty.tabpage_ryt.dw_modellist.object.rmdno[li_cntnum]
		ls_modelnm = f_bom_get_itemname(ls_modelno)
		ls_modelnm = mid(ls_modelnm,1,len(ls_modelnm) - 2) 
		wf_explo_royalty(i_s_refdate,i_s_cust,ls_div,ls_modelno,'A',i_s_custnm,ls_modelnm)
	next
else
	uo_status.st_message.text = ""
	return
end if

dw_report.setredraw(false)
dw_report.setsort("prcd A,mdno A")
dw_report.sort()
dw_report.setredraw(true)

//인쇄 DataWindow 저장
//w_easy_prt에 dwsyntax에 의한 modify()항이 추가됨
l_str_prt.transaction  = sqlca
l_str_prt.datawindow   = dw_report
//l_str_prt.dwsyntax = mod_string
l_str_prt.title = "Royalty 공재 단가 화면"
l_str_prt.tag			  = This.ClassName()

f_close_report("1", l_str_prt.title)			 //Open된 출력Window 닫기
Opensheetwithparm(l_to_open, l_str_prt, "w_prt", w_frame, 0, Layered!)		

uo_status.st_message.Text = ""
end event

event ue_insert;integer li_rtn,li_arraycnt,li_loopcnt
long ll_rowcnt,ll_cntnum,ll_cntsec,ll_cntsum,ll_holdrow,ll_currow
dec{0} lc_lev,lc_prelev,lc_postlev,lc_cost,lc_costsum
dec{2} lc_umcv,lc_itcoct,lc_costpre
dec{3} lc_pqtym
long ll_rtnvar
string ls_div,ls_dvsn,ls_modelno,ls_itno,ls_pcitn,ls_cust,ls_exdv,ls_pdcd,ls_yymm,ls_srce
string ls_plant, ls_plant01, ls_explant
string ls_rtnitem,ls_gubn,ls_gubnchild,ls_wkct,ls_selt
string ls_caldate,ls_refdate
datastore ds_optionchk

uo_status.st_message.text = ""
//계산여부확인
ll_currow =tab_royalty.tabpage_cal.dw_rythist.getselectedrow(0)
if ll_currow = 0 then
	uo_status.st_message.text = "월별현황에서 계산할 기준년월을 선택해 주십시요"
	return
end if
ls_rtnitem = tab_royalty.tabpage_cal.dw_rythist.object.yymm[ll_currow]
ll_rtnvar = tab_royalty.tabpage_cal.dw_rythist.object.mdsum[ll_currow]
if ll_rtnvar > 0 then
	li_rtn = messagebox("확인",ls_rtnitem + " 월의 데이타가 존재합니다. ~r~n" &
						+ "기존데이타를 지우고 다시 계산하시겠습니까?",question!,yesno!,2)
else
	li_rtn = messagebox("확인",ls_rtnitem + " 월의 공재재료비를 계산하시겠습니까?",question!,yesno!,2)
end if
if li_rtn = 2 then
	return
end if
//월의 위치는 점다음에 있는 데이타
ls_refdate = mid(ls_rtnitem,1,4) + mid(ls_rtnitem,6,2)
tab_royalty.tabpage_cal.dw_prelist.reset()
uo_status.st_message.text = "계산중입니다......"
ds_optionchk = create datastore
ds_optionchk.dataobject = "d_bom001_115u_optionchk"
ds_optionchk.settransobject(sqlca)

setpointer(hourglass!)

//날짜를 말일로 입력
if mid(ls_refdate,5,2) = '12' then
	ls_caldate = string(integer(mid(ls_refdate,1,4)) + 1) + '0101'
else
	ls_caldate = string( uo_refdate.uf_yyyymm() + 1) + '01'
end if
ls_caldate = f_relativedate(ls_caldate,-1)
lc_lev = 0

//Delete the data
delete from pbpdm.bom005
		where recmcd = :g_s_company and reyymm = :ls_refdate using sqlca;
		
delete from pbpdm.bom006
		where rfcmcd = :g_s_company and rfyymm = :ls_refdate using sqlca;

//모델품번 가져오기
declare rytget_cur cursor for
	SELECT DISTINCT "PBPDM"."BOM011"."BPLANT",
   		 "PBPDM"."BOM011"."BDIV",
          "PBACC"."ACC300"."SLITNO",   
          "PBACC"."ACC300"."SLPRCD",
			 "PBACC"."ACC300"."RYCUST"
   FROM "PBACC"."ACC300", "PBPDM"."BOM011"  
   WHERE ( "PBACC"."ACC300"."COMLTD" = "PBPDM"."BOM011"."CMCD" ) AND
			( "PBACC"."ACC300"."SLDIV" = "PBPDM"."BOM011"."BPLANT" || "PBPDM"."BOM011"."ADIV" ) AND
			( "PBPDM"."BOM011"."GUBUN" = 'C' ) AND
			( "PBACC"."ACC300"."COMLTD" = :g_s_company ) AND  
         ( "PBACC"."ACC300"."RYFROMDT" <= :ls_caldate ) AND  
         ( "PBACC"."ACC300"."RYTODT" >= :ls_refdate )
//TEST		
//			and ( "PBACC"."ACC300"."SLITNO" = '485013' )
	ORDER BY "PBACC"."ACC300"."RYCUST","PBPDM"."BOM011"."BPLANT","PBPDM"."BOM011"."BDIV"
			using sqlca;

//0 Level Model을 Bom006에 입력
open rytget_cur;
	do while true
		fetch rytget_cur into :ls_plant,:ls_div,:ls_modelno,:ls_pdcd,:ls_cust ;
			if sqlca.sqlcode <> 0 then
				exit
			end if
		
		INSERT INTO "PBPDM"."BOM006"  
         ( "RFCMCD","RFYYMM","RFCUST","RFPLANT","RFDVSN","RFCITN","RFCOST","RFCOSD","RFLLCN",   
           "RFSELT","RFEXPLANT","RFEXDV","RFGUBN" )  
  		VALUES ( :g_s_company,:ls_refdate,:ls_cust,:ls_plant,:ls_div,:ls_modelno, 0, 0, 0,
		  		' ', ' ', ' ', ' ') using sqlca;
			
		if sqlca.sqlcode <> 0 then
			uo_status.st_message.text = f_message("B020")
			return
		end if
	loop
close rytget_cur;

//하위품번 Check Low-level,이체공장여부		 	
do while true
	lc_postlev = lc_lev
	lc_lev = lc_lev + 1
	
	select count(*) into :ll_cntsum
		from PBPDM.bom006
		where rfcmcd = :g_s_company and
				rfyymm = :ls_refdate and
				rfllcn = :lc_postlev
		using sqlca;

	if isnull(ll_cntsum) or ll_cntsum < 1 then
		exit
	end if
	
	declare rytgetchild_cur cursor for 
	  select rfyymm,rfcust,rfplant,rfdvsn,rfcitn from pbpdm.bom006
		  where rfcmcd = :g_s_company and rfyymm = :ls_refdate and
				  rfllcn = :lc_postlev 
		  using sqlca ;
	
	open rytgetchild_cur ;
		do while true
			fetch rytgetchild_cur into :ls_yymm,:ls_cust,:ls_plant,:ls_div,:ls_itno ;
			if sqlca.sqlcode <> 0 then
				exit
			end if
			ll_cntnum = 1
			
			i_ds_explo.reset()
			ll_rowcnt = i_ds_explo.retrieve(ls_plant,ls_div,ls_itno,ls_caldate)
			if ll_rowcnt < 1 then
				continue
			end if
			
			for ll_cntnum = 1 to ll_rowcnt
				//Check same child item about upper level
				ls_pcitn = i_ds_explo.object.pcitn[ll_cntnum]
				if f_spacechk(i_ds_explo.object.pexdv[ll_cntnum]) = -1 then
					ls_exdv = ' '
					ls_explant = ' '
				else
					ls_exdv = i_ds_explo.object.pexdv[ll_cntnum]
					ls_explant = i_ds_explo.object.pexplant[ll_cntnum]
				end if
			
				if wf_get_samechild(ls_refdate,ls_cust,ls_plant,ls_div,ls_pcitn,lc_lev,ls_explant,ls_exdv) then
					//nothing
				else
					uo_status.st_message.text = "1" + f_message("B020")
					return
				end if
			next
		loop
	close rytgetchild_cur ;
loop

//내자자재 setting- 2001.07 추가
wf_setting_gubn(ls_refdate)

//공제재료비 대상자재만을 Filtering, 호환품번과의 비교해서 (원단위량 * 단가)가 큰것
//외자품번에 단가입력
declare upitemf_cur cursor for
	
	select a.rfyymm,a.rfcust,a.rfplant,a.rfdvsn,a.rfcitn,a.rfgubn,b.convqty,b.srce
		from PBPDM.bom006 a, pbinv.inv101 b
		where a.rfcmcd = :g_s_company and a.rfyymm = :ls_refdate and
				a.rfcitn = b.itno and
				( ( a.rfgubn = 'Y' ) or
				  ( b.srce = '01' and substring(b.indus,1,1) = case a.rfcust when 'E' then 'G' else a.rfcust end ) ) using sqlca;

open upitemf_cur;
	do while true 
		fetch upitemf_cur into :ls_yymm,:ls_cust,:ls_plant,:ls_div,:ls_itno,:ls_gubn,:lc_umcv,:ls_srce ;
		if sqlca.sqlcode <> 0 then
			exit
		end if
		lc_itcoct = f_bom_get_itemcost(ls_plant,ls_div,ls_itno,ls_yymm,lc_umcv)
		if ls_gubn <> 'N' then    //외자이면서 내자대상의 유상사급인경우는 제외
		   lc_itcoct = wf_get_cost_multivendor(ls_yymm,ls_plant,ls_div,ls_itno,lc_itcoct,ls_cust)
			
			update PBPDM.bom006
				set rfselt = 'Y', rfcost = :lc_itcoct
				where rfcmcd = :g_s_company and
						rfyymm = :ls_yymm and
						rfcust = :ls_cust and
						rfplant = :ls_plant and
						rfdvsn = :ls_div and
						rfcitn = :ls_itno  using sqlca;
		end if
		if ls_gubn = 'Y' then
			update PBPDM.bom006
				set rfcosd = :lc_itcoct
				where rfcmcd = :g_s_company and
						rfyymm = :ls_yymm and
						rfcust = :ls_cust and
						rfplant = :ls_plant and
						rfdvsn = :ls_div and
						rfcitn = :ls_itno  using sqlca;
		end if
	loop
close upitemf_cur;

ls_modelno = ""
lc_prelev = lc_lev - 1

do until lc_prelev < 1
	//호환주품번 check
	ds_optionchk.reset()
	ll_rowcnt = ds_optionchk.retrieve(ls_refdate,lc_prelev)
	for ll_cntnum = 1 to ll_rowcnt
//		if f_spacechk(ds_optionchk.object.rfexdv[ll_cntnum]) = -1 then
			ls_plant = ds_optionchk.object.rfplant[ll_cntnum]
			ls_div = ds_optionchk.object.rfdvsn[ll_cntnum]
//		else
//			ls_plant = ds_optionchk.object.rfexplant[ll_cntnum]
//			ls_div = ds_optionchk.object.rfexdv[ll_cntnum]
//		end if
		ls_itno = ds_optionchk.object.rfcitn[ll_cntnum]
		ls_rtnitem = f_option_chk_after(ls_plant,ls_div,ls_itno,ls_refdate + '31')
		if ls_rtnitem <> "" then
			// 호환품번인 경우에 수행됨.
			ll_holdrow = ll_cntnum
			wf_get_cost_itemchange(ls_refdate,ls_plant,ls_div,ls_itno,ls_rtnitem,lc_prelev,ds_optionchk,ll_cntnum)
			
			for ll_cntsec = ll_cntnum + 1 to ll_rowcnt
				if ls_rtnitem = f_option_chk_after(ds_optionchk.object.rfplant[ll_cntsec],ds_optionchk.object.rfdvsn[ll_cntsec] &
														  ,ds_optionchk.object.rfcitn[ll_cntsec], ls_refdate + '31') then
					// 호환품번인 경우에 공제금액 계산함수 호출
					wf_get_cost_itemchange(ls_refdate,ds_optionchk.object.rfplant[ll_cntsec],ds_optionchk.object.rfdvsn[ll_cntsec], &
						ds_optionchk.object.rfcitn[ll_cntsec],ls_rtnitem,lc_prelev,ds_optionchk,ll_cntsec)
					// 함수호출끝
					if ds_optionchk.object.rfcost[ll_holdrow] >= ds_optionchk.object.rfcost[ll_cntsec] then
						ds_optionchk.object.rfselt[ll_cntsec] = ' '
						ds_optionchk.object.rfselt[ll_holdrow] = 'Y'
						ds_optionchk.object.rfgubn[ll_holdrow] = ds_optionchk.object.rfgubn[ll_cntsec]
					else
						ds_optionchk.object.rfselt[ll_cntsec] = 'Y'
						ds_optionchk.object.rfgubn[ll_cntsec] = ds_optionchk.object.rfgubn[ll_holdrow]
						ds_optionchk.object.rfselt[ll_holdrow] = ' '
						ll_holdrow = ll_cntsec
					end if
				end if
			next
		end if
	next
	
	if ds_optionchk.update() = 1  then
		//nothing
	else
		uo_status.st_message.text = f_message("B020")
		return
	end if
	//END CHECK
	
	//외자와 연결된 상위 품번
	declare upitem_cur cursor for  
		select rfyymm,rfcust,rfplant,rfdvsn,rfcitn,rfcost,rfexplant,rfexdv,rfgubn   
			from PBPDM.bom006   
			where (rfcmcd = :g_s_company) and
					(rfyymm = :ls_refdate ) and
					(rfllcn = :lc_prelev ) and
					((rfselt = 'Y'       )  or
					(rfgubn  = 'Y'      )) 
		using sqlca;
	
	open upitem_cur;	
		do while true
			fetch upitem_cur into :ls_yymm,:ls_cust,:ls_plant01,:ls_dvsn,:ls_pcitn,:lc_cost,:ls_explant,:ls_exdv,:ls_gubnchild ;
				if sqlca.sqlcode <> 0 then
					exit
				end if
				
				if f_spacechk(ls_exdv) <> -1 then
					ls_plant = ls_explant
					ls_div = ls_exdv
				else
					ls_plant = ls_plant01
					ls_div = ls_dvsn
				end if
				i_ds_implo.reset()
				ll_rowcnt = i_ds_implo.retrieve(ls_plant,ls_div,ls_pcitn,ls_caldate)
				
				if ll_rowcnt < 1 then
					//nothing
				else
					for ll_cntnum = 1 to ll_rowcnt
						ls_itno = i_ds_implo.object.ppitn[ll_cntnum]
						select rfcost,rfselt,rfgubn into :lc_cost,:ls_selt,:ls_gubn
							from PBPDM.bom006
							where rfcmcd = :g_s_company and
									rfyymm = :ls_yymm and
									rfcust = :ls_cust and
									rfplant = :ls_plant and
									rfdvsn = :ls_div and
									rfcitn = :ls_itno using sqlca;
									
						if sqlca.sqlcode = 0 then
							lc_pqtym = i_ds_implo.object.pqtym[ll_cntnum]
							
							//insert data at BOM005
							select repitn into :ls_modelno
								from PBPDM.bom005
								where recmcd = :g_s_company and
										reyymm = :ls_yymm and
										recust = :ls_cust and
										replant = :ls_plant and
										redvsn = :ls_dvsn and
										repitn = :ls_itno and
										recitn = :ls_pcitn using sqlca;
							if sqlca.sqlcode <> 0 then
								insert into PBPDM.bom005 (recmcd,reyymm,recust,replant,redvsn,repitn,recitn,repqty,relevl,reexplant,reexdv)
									values (:g_s_company,:ls_yymm,:ls_cust,:ls_plant01,:ls_dvsn,:ls_itno,:ls_pcitn,:lc_pqtym,:lc_prelev,:ls_explant,:ls_exdv) using sqlca;
								if sqlca.sqlcode <> 0 then
									uo_status.st_message.text = f_message("B020")
									return
								end if
							end if
								
							//update cost in BOM006
							select rfcost into :lc_costpre
								from PBPDM.bom006
								where rfcmcd = :g_s_company and
										rfyymm = :ls_yymm and
										rfcust = :ls_cust and
										rfplant = :ls_plant and
										rfdvsn = :ls_div and
										rfcitn = :ls_pcitn using sqlca;
							//원단위량과 불출단가를 곱한뒤에 반올림
							lc_costsum = round((lc_costpre * lc_pqtym),0) + lc_cost
									
							update PBPDM.bom006 
								set rfcost = :lc_costsum , rfselt = 'Y' 									
								where rfcmcd = :g_s_company and
										rfyymm = :ls_yymm and
										rfcust = :ls_cust and
										rfplant = :ls_plant01 and
										rfdvsn = :ls_dvsn and
										rfcitn = :ls_itno 
								using sqlca;
						end if
					next
				end if
		loop
	close upitem_cur;
	lc_prelev = lc_prelev - 1
loop

//display the result data at window
declare result_cur cursor for
	SELECT DISTINCT "PBPDM"."BOM006"."RFYYMM",
			 "PBPDM"."BOM006"."RFCUST",
			 "PBPDM"."BOM006"."RFCITN",
			 "PBPDM"."BOM006"."RFCOST",
			 "PBPDM"."BOM011"."ADIV",
			 "PBPDM"."BOM006"."RFPLANT"
   FROM "PBPDM"."BOM006","PBACC"."ACC300", "PBPDM"."BOM011"  
   WHERE ( "PBPDM"."BOM006"."RFCMCD" = "PBACC"."ACC300"."COMLTD" ) AND
			( "PBACC"."ACC300"."COMLTD" = "PBPDM"."BOM011"."CMCD" ) AND
			( "PBPDM"."BOM006"."RFPLANT" = "PBPDM"."BOM011"."BPLANT" ) AND
			( "PBPDM"."BOM006"."RFDVSN" = "PBPDM"."BOM011"."BDIV" ) AND
			( "PBACC"."ACC300"."SLDIV" = "PBPDM"."BOM011"."BPLANT" || "PBPDM"."BOM011"."ADIV" ) AND
			( "PBPDM"."BOM006"."RFCUST" = "PBACC"."ACC300"."RYCUST" ) AND
			( "PBPDM"."BOM006"."RFCITN" = "PBACC"."ACC300"."SLITNO" ) AND
			( "PBPDM"."BOM011"."GUBUN" = 'C' ) AND
			( "PBPDM"."BOM006"."RFCMCD" = :g_s_company ) AND 
			( "PBPDM"."BOM006"."RFYYMM" = :ls_refdate ) AND
			( "PBPDM"."BOM006"."RFSELT" = 'Y' ) 
//			AND ( "PBPDM"."BOM006"."RFCOST" <> 0 )
    ORDER BY "PBPDM"."BOM006"."RFCUST", "PBPDM"."BOM011"."ADIV", "PBPDM"."BOM006"."RFCITN"
	 USING SQLCA;
		
open result_cur;
	do while true 
		fetch result_cur into :ls_yymm,:ls_cust,:ls_itno,:lc_cost,:ls_div,:ls_plant ;
		if sqlca.sqlcode <> 0 then
			this.triggerevent("ue_save")
			exit
		end if
		
		select coitname into :ls_rtnitem
			from pbcommon.dac002
			where cocode = :ls_cust and
					cogubun = 'DAC170' using sqlca;
//		if ls_plant = 'J' then
//		   if ls_div = 'M' then
//				ls_div = 'B' 
//			elseif ls_div = 'S' then
//				ls_div = 'L'
//			elseif ls_div = 'H' then
//				ls_div = 'T'
//			end if
//		elseif ls_plant = 'K' then
//		   if ls_div = 'M' then
//				ls_div = 'P' 
//			elseif ls_div = 'S' then
//				ls_div = 'N'
//			elseif ls_div = 'H' then
//				ls_div = 'O'
//			end if
//		end if
		ll_currow = tab_royalty.tabpage_cal.dw_prelist.insertrow(0)
		tab_royalty.tabpage_cal.dw_prelist.object.bomt02_rcmcd[ll_currow] = g_s_company
		tab_royalty.tabpage_cal.dw_prelist.object.bomt02_ryear[ll_currow] = mid(ls_yymm,1,4)
		tab_royalty.tabpage_cal.dw_prelist.object.bomt02_rmonth[ll_currow] = mid(ls_yymm,5,2)
		tab_royalty.tabpage_cal.dw_prelist.object.bomt02_rcust[ll_currow] = ls_cust
		tab_royalty.tabpage_cal.dw_prelist.object.dac002_coitname[ll_currow] = ls_rtnitem
		tab_royalty.tabpage_cal.dw_prelist.object.bomt02_rplant[ll_currow] = ls_plant
		tab_royalty.tabpage_cal.dw_prelist.object.bomt02_rdiv[ll_currow] = ls_div
		tab_royalty.tabpage_cal.dw_prelist.object.bomt02_rmdno[ll_currow] = ls_itno
		tab_royalty.tabpage_cal.dw_prelist.object.bomt02_rcost[ll_currow] = lc_cost
	loop
close result_cur;

end event

event ue_delete;long ll_currow,ll_rtn
string ls_seldate,ls_year,ls_month

ll_currow = tab_royalty.tabpage_cal.dw_rythist.getselectedrow(0)

if ll_currow < 1 then
	uo_status.st_message.text = f_message("D100")
	return 0
end if

if ll_currow <> 1 or tab_royalty.tabpage_cal.dw_rythist.object.mdsum[1] = 0 then
	uo_status.st_message.text = f_message("D040")
	return 0
end if

ls_year = mid(tab_royalty.tabpage_cal.dw_rythist.object.yymm[1],1,4)
ls_month = mid(tab_royalty.tabpage_cal.dw_rythist.object.yymm[1],6,2)
ls_seldate = ls_year + ls_month

ll_rtn = messagebox("알림",ls_seldate + " 의 데이타를 삭제하시겠습니까?",question!,yesno!,1)
if ll_rtn = 2 then
	uo_status.st_message.text = f_message("D030")
	return 0
end if
				
delete from PBPDM.bom005
	where reyymm = :ls_seldate using sqlca;
	
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "d1_err: " + f_message("D020")
	return 0
end if
	
delete from PBPDM.bom006
	where rfyymm = :ls_seldate using sqlca;
	
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "d2_err: " + f_message("D020")
	return 0
end if
	
delete from PBPDM.bomt02
	where rcmcd = :g_s_company and
			ryear = :ls_year and
			rmonth = :ls_month using sqlca;
			
if sqlca.sqlcode <> 0 then
	uo_status.st_message.text = "d3_err: " + f_message("D020")
	return 0
else
	uo_status.st_message.text = f_message("D010")
end if

wf_initset()
tab_royalty.tabpage_cal.dw_prelist.reset()
				
	



end event

type uo_status from w_origin_sheet02`uo_status within w_bom115u
end type

type dw_customer from datawindow within w_bom115u
boolean visible = false
integer x = 1193
integer y = 28
integer width = 489
integer height = 104
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dddw_115u_coitname"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;long   l_n_rownum
datawindowchild child_cust
string l_s_uni_cd

//----------- 공장 선택 ----------
dw_customer.getchild("coitname",child_cust)
child_cust.settransobject(sqlca)
//i_l_plantrow = child_plant.getrow()
//i_l_pdcdrow = 1
l_s_uni_cd = trim(child_cust.getitemstring(child_cust.getrow(), "cocode"))

end event

event constructor;long   ll_cntnum,ll_cntrow,ll_currow
datawindowchild child_cust
string l_s_uni_cd

//i_l_plantrow = 1

//----------- 공장 ----------
dw_customer.getchild("coitname",child_cust)
child_cust.settransobject(sqlca)
ll_cntrow = child_cust.retrieve()
if ll_cntrow < 1 then
	messagebox("자료없슴!", "업체명이 한건도 없습니다.")
	return
end if
l_s_uni_cd  = trim(child_cust.getitemstring(1, "cocode"))

for ll_cntnum = 1 to ll_cntrow
	ll_currow = dw_customer.insertrow(0)
	dw_customer.setitem(ll_currow,"coitname",child_cust.getitemstring(ll_cntnum,"coitname"))
	dw_customer.setitem(ll_currow,"cocode",child_cust.getitemstring(ll_cntnum,"cocode"))
next
end event

type st_1 from statictext within w_bom115u
boolean visible = false
integer x = 974
integer y = 52
integer width = 201
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
string text = "업체명"
boolean focusrectangle = false
end type

type st_2 from statictext within w_bom115u
integer x = 69
integer y = 60
integer width = 297
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준년월"
boolean focusrectangle = false
end type

type tab_royalty from tab within w_bom115u
integer x = 32
integer y = 160
integer width = 4571
integer height = 2320
integer taborder = 40
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
integer selectedtab = 1
tabpage_cal tabpage_cal
tabpage_ryt tabpage_ryt
end type

on tab_royalty.create
this.tabpage_cal=create tabpage_cal
this.tabpage_ryt=create tabpage_ryt
this.Control[]={this.tabpage_cal,&
this.tabpage_ryt}
end on

on tab_royalty.destroy
destroy(this.tabpage_cal)
destroy(this.tabpage_ryt)
end on

event selectionchanged;i_i_tabindex = newindex

if newindex = 2 then
	tab_royalty.tabpage_ryt.dw_modellist.reset()
	tab_royalty.tabpage_ryt.dw_partlist.reset()
	uo_refdate.enabled = true
	st_1.visible = true
	dw_customer.visible = true
	uo_div.visible = true
	uo_refdate.st_yyyymm.backcolor = rgb(255,255,255)
	i_b_retrieve = true
	i_b_insert = false
	i_b_save  = false
	i_b_delete = false
	i_b_print  = true
elseif newindex = 1 then
	//Royalty정산 내역 Display
	wf_initset()
	tab_royalty.tabpage_cal.dw_prelist.reset()
	uo_refdate.enabled = false
	uo_refdate.st_yyyymm.backcolor = rgb(192,192,192)
	st_1.visible = false
	dw_customer.visible = false
	uo_div.visible = false
	i_b_retrieve = false
	i_b_insert = true
	i_b_save  = false
	i_b_delete = true
	i_b_print  = false
end if
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  i_b_dprint,    i_b_dchar)
					  
//f_icon_set(false,  false,  false, false,  false,  false,  false,  false,  false,  false, &
//				  false, false, false,  false,  false,  false, false)
end event

type tabpage_cal from userobject within tab_royalty
integer x = 18
integer y = 112
integer width = 4535
integer height = 2192
long backcolor = 12632256
string text = "계산"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Compute!"
long picturemaskcolor = 536870912
dw_rythist dw_rythist
st_detail st_detail
st_3 st_3
dw_prelist dw_prelist
end type

on tabpage_cal.create
this.dw_rythist=create dw_rythist
this.st_detail=create st_detail
this.st_3=create st_3
this.dw_prelist=create dw_prelist
this.Control[]={this.dw_rythist,&
this.st_detail,&
this.st_3,&
this.dw_prelist}
end on

on tabpage_cal.destroy
destroy(this.dw_rythist)
destroy(this.st_detail)
destroy(this.st_3)
destroy(this.dw_prelist)
end on

type dw_rythist from datawindow within tabpage_cal
integer x = 5
integer y = 120
integer width = 965
integer height = 2060
integer taborder = 60
string title = "none"
string dataobject = "d_bom001_115u_lv"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer li_rowcnt
long ll_rowcnt
string ls_yymm

uo_status.st_message.text = ""
li_rowcnt = this.rowcount()
if row > 0 and row <= li_rowcnt then
	this.selectrow(0, false)
	this.selectrow(row,true)
end if

tab_royalty.tabpage_cal.dw_prelist.reset()

ls_yymm = tab_royalty.tabpage_cal.dw_rythist.object.yymm[row]
ls_yymm = mid(ls_yymm,1,4) + mid(ls_yymm,6,2)
ll_rowcnt = tab_royalty.tabpage_cal.dw_prelist.retrieve(ls_yymm)
if ll_rowcnt < 1 then
	uo_status.st_message.text = f_message("I020")
end if

end event

type st_detail from statictext within tabpage_cal
integer x = 978
integer y = 48
integer width = 590
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "모델별 현황"
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_cal
integer x = 14
integer y = 44
integer width = 645
integer height = 68
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "월별 현황"
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_prelist from datawindow within tabpage_cal
integer x = 992
integer y = 120
integer width = 2542
integer height = 2064
integer taborder = 50
string title = "none"
string dataobject = "d_bom001_115u_preryt"
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_ryt from userobject within tab_royalty
integer x = 18
integer y = 112
integer width = 4535
integer height = 2192
long backcolor = 12632256
string text = "조회"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
string picturename = "Query5!"
long picturemaskcolor = 536870912
st_5 st_5
st_4 st_4
dw_partlist dw_partlist
dw_modellist dw_modellist
end type

on tabpage_ryt.create
this.st_5=create st_5
this.st_4=create st_4
this.dw_partlist=create dw_partlist
this.dw_modellist=create dw_modellist
this.Control[]={this.st_5,&
this.st_4,&
this.dw_partlist,&
this.dw_modellist}
end on

on tabpage_ryt.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.dw_partlist)
destroy(this.dw_modellist)
end on

type st_5 from statictext within tabpage_ryt
integer x = 1737
integer y = 48
integer width = 517
integer height = 52
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "대상자재"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_ryt
integer x = 9
integer y = 48
integer width = 590
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
string text = "대상모델"
boolean focusrectangle = false
end type

type dw_partlist from datawindow within tabpage_ryt
integer x = 1737
integer y = 116
integer width = 2775
integer height = 2060
integer taborder = 40
string title = "none"
string dataobject = "d_bom001_115u_rytrep"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_modellist from datawindow within tabpage_ryt
integer x = 5
integer y = 120
integer width = 1696
integer height = 2056
integer taborder = 30
string title = "none"
string dataobject = "d_bom001_115u_modellist"
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

event doubleclicked;string ls_rtn,ls_div
integer li_rtn

SetPointer(HourGlass!)
tab_royalty.tabpage_ryt.dw_partlist.reset()
uo_status.st_message.text = ""
//retrieve parent item about item dbclicked
ls_div = tab_royalty.tabpage_ryt.dw_modellist.object.acc300_sldiv[row]
i_s_div = ls_div
i_s_modelno = tab_royalty.tabpage_ryt.dw_modellist.object.rmdno[row]
ls_rtn = f_bom_get_itemname(i_s_modelno)
i_s_modelnm = mid(ls_rtn,1,len(ls_rtn) - 2) 
//'M'은 하나의 모델을 하위전개 한다는 뜻
li_rtn = wf_explo_royalty(i_s_refdate,i_s_cust,i_s_div,i_s_modelno,'M',i_s_custnm,i_s_modelnm)
if li_rtn = 0 then
	uo_status.st_message.text = f_message("I020")
else
	uo_status.st_message.text = f_message("I010")
end if



end event

type uo_refdate from uo_comm_yymm within w_bom115u
integer x = 379
integer y = 32
integer taborder = 30
boolean bringtotop = true
end type

on uo_refdate.destroy
call uo_comm_yymm::destroy
end on

event constructor;call super::constructor;//현재월보다 한달적은 달을 기준월로 설정
if integer(mid(g_s_date,5,2)) = 1 then
	uo_refdate.uf_reset(integer(mid(g_s_date,1,4)) - 1,12)
else
	uo_refdate.uf_reset(integer(mid(g_s_date,1,4)),integer(mid(g_s_date,5,2)) - 1)
end if
end event

type dw_report from datawindow within w_bom115u
boolean visible = false
integer x = 2405
integer y = 36
integer width = 192
integer height = 92
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_report_royaltylist"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_div from uo_plandiv_pdcd within w_bom115u
event destroy ( )
boolean visible = false
integer x = 1751
integer y = 12
integer width = 1266
integer taborder = 60
boolean bringtotop = true
end type

on uo_div.destroy
call uo_plandiv_pdcd::destroy
end on

type pb_down from picturebutton within w_bom115u
integer x = 1851
integer y = 24
integer width = 229
integer height = 116
integer taborder = 60
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = variable!
fontfamily fontfamily = modern!
string facename = "맑은 고딕"
string picturename = "C:\kdac\bmp\Excel.bmp"
alignment htextalign = left!
end type

event clicked;if tab_royalty.tabpage_cal.dw_prelist.rowcount() < 1 then
	uo_status.st_message.text = "다운로드할 데이타가 없습니다."
else
	f_save_to_excel_number(tab_royalty.tabpage_cal.dw_prelist)
end if

return 0
end event

type st_6 from statictext within w_bom115u
integer x = 1193
integer y = 44
integer width = 654
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "모델별현황 다운로드:"
alignment alignment = center!
boolean focusrectangle = false
end type

