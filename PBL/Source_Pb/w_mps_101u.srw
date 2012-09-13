$PBExportHeader$w_mps_101u.srw
$PBExportComments$기준데이터 정보
forward
global type w_mps_101u from w_origin_sheet02
end type
type uo_2 from uo_ccyymm_mps within w_mps_101u
end type
type st_2 from statictext within w_mps_101u
end type
type st_3 from statictext within w_mps_101u
end type
type sle_1 from singlelineedit within w_mps_101u
end type
type st_4 from statictext within w_mps_101u
end type
type sle_2 from singlelineedit within w_mps_101u
end type
type st_5 from statictext within w_mps_101u
end type
type sle_3 from singlelineedit within w_mps_101u
end type
type tb from tab within w_mps_101u
end type
type tb_1 from userobject within tb
end type
type cb_sort from commandbutton within tb_1
end type
type sle_4 from singlelineedit within tb_1
end type
type cb_1 from commandbutton within tb_1
end type
type dw_2 from datawindow within tb_1
end type
type tb_1 from userobject within tb
cb_sort cb_sort
sle_4 sle_4
cb_1 cb_1
dw_2 dw_2
end type
type tb_2 from userobject within tb
end type
type sle_5 from singlelineedit within tb_2
end type
type cb_sort1 from commandbutton within tb_2
end type
type dw_3 from datawindow within tb_2
end type
type tb_2 from userobject within tb
sle_5 sle_5
cb_sort1 cb_sort1
dw_3 dw_3
end type
type tb from tab within w_mps_101u
tb_1 tb_1
tb_2 tb_2
end type
type uo_1 from uo_plandiv_pdcd_rtn within w_mps_101u
end type
end forward

global type w_mps_101u from w_origin_sheet02
uo_2 uo_2
st_2 st_2
st_3 st_3
sle_1 sle_1
st_4 st_4
sle_2 sle_2
st_5 st_5
sle_3 sle_3
tb tb
uo_1 uo_1
end type
global w_mps_101u w_mps_101u

type prototypes

end prototypes

type variables
string i_s_xplant,i_s_dvsn,i_s_pdcd,i_s_ccyymm,i_s_retrieve,i_s_chk_date,i_s_stscd
integer i_n_tabindex,i_i_LastRow,i_s_retrieve_count
end variables

forward prototypes
public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw)
public subroutine wf_mps001_insert (datawindow dw, integer dw_row)
public function string wf_return ()
public function decimal wf_asfsq (string a_xplant, string a_dvsn, string a_itno, string a_date, decimal a_sfsd)
public subroutine wf_get_pcs (datawindow dw, integer dw_row, string a_pdcd, string a_date, integer a_yesno)
end prototypes

public function integer wf_shift_highlight (integer al_aclickedrow, datawindow dw);integer	l_i_Idx, l_i_last_row

 l_i_last_row = i_i_LastRow

dw.setredraw(false)
dw.selectrow(0,false)

If l_i_last_row = 0 then
	dw.setredraw(true)
	Return 1
end if

if l_i_last_row > al_aclickedrow then
	For l_i_Idx = l_i_last_row to al_aclickedrow STEP -1
		dw.selectrow(l_i_Idx,TRUE)	
	end for	
else
	For l_i_Idx = l_i_last_row to al_aclickedrow 
		dw.selectrow(l_i_Idx,TRUE)	
	next	
end if

dw.setredraw(true)
Return 1

end function

public subroutine wf_mps001_insert (datawindow dw, integer dw_row);string l_s_aitno,l_s_sle_date
dec{1} l_s_asfsd
dec{0} l_s_asfsq,l_s_altsz

l_s_sle_date = f_get_mps_sle105('RSPDBALL')
l_s_aitno  = trim(dw.object.inv101_itno[dw_row])
//l_s_alnmn  = trim(dw.object.linecode[dw_row])
l_s_altsz  = dw.object.lotsize[dw_row]
l_s_asfsd  = dw.object.safeday[dw_row]
l_s_asfsq  = wf_asfsq(i_s_xplant,i_s_dvsn,l_s_aitno,i_s_ccyymm,l_s_asfsd)
dw.object.safeqty[dw_row] = l_s_asfsq
insert into pbmps.mps001
values
( :g_s_company,:i_s_xplant,:i_s_dvsn,:l_s_aitno,' ',:l_s_asfsd,:l_s_asfsq,:l_s_altsz,0,0,0,0,0,0,
  ' ', ' ' ,  ' ', :g_s_macaddr,:g_s_ipaddr,:l_s_sle_date,:g_s_date,:g_s_date )
using sqlca ;

	





end subroutine

public function string wf_return ();string l_s_parm,l_s_stscd,l_s_date,l_s_dvsn
l_s_parm    = uo_1.uf_return()
i_s_xplant  = mid(l_s_parm,1,1)
i_s_dvsn    = mid(l_s_parm,2,1)
i_s_pdcd    = mid(l_s_parm,3,4)
i_s_ccyymm  = uo_2.uf_yyyymm()

l_s_stscd = f_get_mps007(g_s_company,i_s_xplant,i_s_dvsn,i_s_ccyymm)
//if mid(l_s_stscd,1,6) <= i_s_ccyymm and ( mid(l_s_stscd,9,1) <> 'N' and mid(l_s_stscd,9,1) <> 'C' ) then 
if mid(l_s_stscd,1,6) <= i_s_ccyymm and mid(l_s_stscd,9,1) <> 'C'  then 
	l_s_stscd = ''
else
	l_s_stscd = '1'
end if
l_s_date = f_relativedate(g_s_date,-1)
if mid(l_s_date,1,6) >= i_s_ccyymm then
	l_s_date = f_relativedate(mid(l_s_date,1,6) + '01', -1)
end if
sle_1.text = string(l_s_date,'@@@@@@@@')
if i_s_xplant = 'K' or i_s_xplant = 'J' then
	l_s_dvsn = i_s_xplant 
else
	l_s_dvsn = i_s_dvsn
end if
l_s_date   = f_get_workday_mps(l_s_date,l_s_dvsn)
sle_2.text = string(integer(mid(l_s_date,3,2)))
sle_3.text = string(integer(mid(l_s_date,1,2)))
return l_s_stscd

end function

public function decimal wf_asfsq (string a_xplant, string a_dvsn, string a_itno, string a_date, decimal a_sfsd);dec{0} l_s_asfsq,l_s_qty[13]
int    l_n_count,i,wrkday

select bqtyd01 + bqtye01 ,bqtyd02 + bqtye02 ,bqtyd03 + bqtye03 ,
       bqtyd04 + bqtye04 ,bqtyd05 + bqtye05 ,bqtyd06 + bqtye06 ,
		 bqtyd07 + bqtye07 ,bqtyd08 + bqtye08 ,bqtyd09 + bqtye09 ,
       bqtyd10 + bqtye10 ,bqtyd11 + bqtye11 ,bqtyd12 + bqtye12
	   into :l_s_qty[1],:l_s_qty[2],:l_s_qty[3],:l_s_qty[4],:l_s_qty[5],:l_s_qty[6],
		 :l_s_qty[7],:l_s_qty[8],:l_s_qty[9],:l_s_qty[10],:l_s_qty[11],:l_s_qty[12]
	from pbmps.mps002
where bcmcd = :g_s_company and bplant = :a_xplant and bdvsn = :a_dvsn and
      bitno = :a_itno      and byear  = substring(:a_date,1,4)  and  bmonth = substring(:a_date,5,2) 
using sqlca ;

l_s_qty[13] = 0

for i = 1 to 12
	if l_s_qty[i] > 0 then
		l_n_count ++
	end if
	l_s_qty[13] += l_s_qty[i]
next
wrkday = integer(sle_2.text)

if l_n_count = 0 or a_sfsd = 0 or wrkday = 0 then
	return 0
end if

l_s_asfsq = (( l_s_qty[13] / l_n_count ) / ( wrkday )) * a_sfsd 
return l_s_asfsq
end function

public subroutine wf_get_pcs (datawindow dw, integer dw_row, string a_pdcd, string a_date, integer a_yesno);dec{0} sdqt[31],l_s_return,l_s_pcs101,l_s_pcs102,l_s_rpmq,l_s_ohuqty,wrkday1,wrkday2
string l_s_date,a_xplant,a_dvsn,a_itno,l_s_chkdate
integer l_s_day,i

a_xplant = dw.object.mps001_aplant[dw_row]
a_dvsn   = dw.object.mps001_advsn[dw_row]
a_itno   = dw.object.mps001_aitno[dw_row]

l_s_date = sle_1.text
l_s_chkdate = mid(l_s_date,1,6) + '01'

select sum(dplnq01) into :l_s_rpmq from pbmps.mps004
	where dcmcd = :g_s_company and dplant = :a_xplant and ddvsn = :a_dvsn and ditno = :a_itno and
	      dyear || dmonth = :a_date 
using sqlca ;

if sqlca.sqlcode <> 0 or isnull(l_s_rpmq) then
	l_s_rpmq	  = 0
end if
	      
//// 선출하량 필드 체크
//select sum(tqty3) into :l_s_isrqm from pbinv.inv401
//	where comltd = :g_s_company and xplant = :a_xplant and div = :a_Dvsn and sliptype = 'SA' and 
//	      tdte4 >= :l_s_chkdate and tdte4 <= :l_s_date and itno = :a_itno
//using sqlca ;
//
//if sqlca.sqlcode <> 0 then
//	l_s_isrqm = 0
//end if
//if isnull(l_s_isrqm) then
//	l_s_isrqm = 0
//end if
//

if i_s_ccyymm = mid(g_s_date,1,6) then
	select ohuqty,intqty,outqty into :l_s_ohuqty,:l_s_pcs101,:l_s_pcs102 from pbinv.inv402
		where comltd = :g_s_company and xplant = :a_xplant and div = :a_dvsn and itno = :a_itno and
		      xyear  = :i_s_ccyymm 
	using sqlca ;
elseif i_s_ccyymm > mid(g_s_date,1,6) then
	select ohuqty,intqty,outqty into :l_s_ohuqty,:l_s_pcs101,:l_s_pcs102 from pbinv.inv101
		where comltd = :g_s_company and xplant = :a_xplant and div = :a_dvsn and itno = :a_itno using sqlca ;
end if
if sqlca.sqlcode <> 0 then
	l_s_ohuqty = 0
	l_s_pcs101 = 0
	l_s_pcs102 = 0	
end if


//select sdqt1 ,sdqt2 ,sdqt3 ,sdqt4 ,sdqt5 ,sdqt6 ,sdqt7 ,sdqt8 ,sdqt9 ,sdqt10,sdqt11,
//	    sdqt12,sdqt13,sdqt14,sdqt15,sdqt16,sdqt17,sdqt18,sdqt19,sdqt20,sdqt21,sdqt22,
//	    sdqt23,sdqt24,sdqt25,sdqt26,sdqt27,sdqt28,sdqt29,sdqt30,sdqt31,updtdt into 
//	   :sdqt[1],:sdqt[2],:sdqt[3],:sdqt[4],:sdqt[5],:sdqt[6],:sdqt[7],:sdqt[8],:sdqt[9],:sdqt[10],:sdqt[11],
//	   :sdqt[12],:sdqt[13],:sdqt[14],:sdqt[15],:sdqt[16],:sdqt[17],:sdqt[18],:sdqt[19],:sdqt[20],:sdqt[21],:sdqt[22],
//	   :sdqt[23],:sdqt[24],:sdqt[25],:sdqt[26],:sdqt[27],:sdqt[28],:sdqt[29],:sdqt[30],:sdqt[31] from pbinv.pcs102
//where comltd = :g_s_company and xplant = :a_xplant and div = :a_dvsn and pdcd = :a_pdcd and itno = :a_itno 
//	  and xyear = :a_date and cust = '******'
//using sqlca ;

wrkday1 = integer(sle_2.text) 
wrkday2 = integer(sle_3.text)

//if sqlca.sqlcode = 0 then
//	l_s_day = integer(mid(l_s_date,7,2))
//	if l_s_day <> 0 then
//		for i = 1 to l_s_day
//			l_s_pcs102 += sdqt[i]
//		next 
//	end if
   //** 잔여출하량 계산
	dw.object.mps001_aslqa[dw_row] = l_s_pcs102
	if ( ( dw.object.mps001_aslqa[dw_row] - l_s_rpmq ) >= 0 ) or dw.object.mps001_aslqa[dw_row] <= 0 then
		dw.object.mps001_aslqr[dw_row] = 0
	else
		dw.object.mps001_aslqr[dw_row] = ( dw.object.mps001_aslqa[dw_row] / wrkday1 ) * wrkday2
	end if
//else
//	dw.object.mps001_aslqa[dw_row] = 0
//	dw.object.mps001_aslqr[dw_row] = 0
//end if
//
if dw.object.mps001_atype[dw_row] <> 'B' then
//	select sdqt1 ,sdqt2 ,sdqt3 ,sdqt4 ,sdqt5 ,sdqt6 ,sdqt7 ,sdqt8 ,sdqt9 ,sdqt10,sdqt11,
//		    sdqt12,sdqt13,sdqt14,sdqt15,sdqt16,sdqt17,sdqt18,sdqt19,sdqt20,sdqt21,sdqt22,
//		    sdqt23,sdqt24,sdqt25,sdqt26,sdqt27,sdqt28,sdqt29,sdqt30,sdqt31 into 
//		   :sdqt[1],:sdqt[2],:sdqt[3],:sdqt[4],:sdqt[5],:sdqt[6],:sdqt[7],:sdqt[8],:sdqt[9],:sdqt[10],:sdqt[11],
//		   :sdqt[12],:sdqt[13],:sdqt[14],:sdqt[15],:sdqt[16],:sdqt[17],:sdqt[18],:sdqt[19],:sdqt[20],:sdqt[21],:sdqt[22],
//		   :sdqt[23],:sdqt[24],:sdqt[25],:sdqt[26],:sdqt[27],:sdqt[28],:sdqt[29],:sdqt[30],:sdqt[31] from pbinv.pcs101
//	where comltd = :g_s_company and xplant = :a_xplant and div = :a_dvsn and pdcd = :a_pdcd and itno = :a_itno 
//		   and xyear = :a_date and cust = ''
//	using sqlca ;
	
//	if sqlca.sqlcode = 0 then
//		l_s_day = integer(mid(l_s_date,7,2))
//		if l_s_day <> 0 then
//			for i = 1 to l_s_day
//				l_s_pcs101 += sdqt[i]
//			next 
// 	end if
		//** 잔여생산량 계산
		dw.object.mps001_apdqa[dw_row] = l_s_pcs101 
		if ( ( dw.object.mps001_apdqa[dw_row] - l_s_rpmq ) >= 0 ) or dw.object.mps001_apdqa[dw_row] <= 0 then
			dw.object.mps001_apdqr[dw_row] = 0
		else
		  	dw.object.mps001_apdqr[dw_row] = ( dw.object.mps001_apdqa[dw_row] / wrkday1 ) * wrkday2
		end if
//	else
//		dw.object.mps001_apdqa[dw_row] = 0
//		dw.object.mps001_apdqr[dw_row] = 0
//	end if
	if	a_yesno	=	1	then
		dw.object.mps001_apdqr[dw_row] = 0
		dw.object.mps001_aslqr[dw_row] = 0
	end if
	dw.object.mps001_aohqt[dw_row] = dw.object.mps001_abmbq[dw_row] +	dw.object.mps001_apdqa[dw_row] + dw.object.mps001_apdqr[dw_row] - &
									         dw.object.mps001_aslqa[dw_row] - dw.object.mps001_aslqr[dw_row]  

elseif dw.object.mps001_atype[dw_row] 	= 'B' then
		 dw.object.mps001_aohqt[dw_row] 	= 0
		 dw.object.mps001_apdqa[dw_row] 	= 0
		 dw.object.mps001_apdqr[dw_row] 	= 0
		 dw.object.mps001_aslqa[dw_row] 	= 0
		 dw.object.mps001_aslqr[dw_row] 	= 0
end if

end subroutine

on w_mps_101u.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.st_2=create st_2
this.st_3=create st_3
this.sle_1=create sle_1
this.st_4=create st_4
this.sle_2=create sle_2
this.st_5=create st_5
this.sle_3=create sle_3
this.tb=create tb
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.st_4
this.Control[iCurrent+6]=this.sle_2
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.sle_3
this.Control[iCurrent+9]=this.tb
this.Control[iCurrent+10]=this.uo_1
end on

on w_mps_101u.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.sle_1)
destroy(this.st_4)
destroy(this.sle_2)
destroy(this.st_5)
destroy(this.sle_3)
destroy(this.tb)
destroy(this.uo_1)
end on

event open;call super::open;i_b_retrieve = true
i_b_insert   = true
i_b_save     = true
i_b_delete   = true
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_first,     i_b_prev, i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  i_b_dprint,    i_b_dchar)
end event

event ue_retrieve;call super::ue_retrieve;string l_s_stscd
uo_status.st_message.text = ''
l_s_stscd = wf_return()
tb.tb_2.dw_3.dataobject = 'd_mpsu01_02'
tb.tb_2.dw_3.settransobject(sqlca)
tb.tb_2.dw_3.reset()
tb.tb_1.dw_2.reset()

if i_n_tabindex = 2 then
	i_s_retrieve_count = tb.tb_2.dw_3.retrieve(g_s_company,i_s_xplant,i_s_dvsn,i_s_pdcd + '%',l_s_stscd)
	if i_s_retrieve_count > 0 then 
		tb.tb_2.cb_Sort1.enabled = true
	else
		tb.tb_2.cb_Sort1.enabled = false
	end if
elseif i_n_tabindex = 1 then
	i_s_retrieve_count = tb.tb_1.dw_2.retrieve(g_s_company,i_s_xplant,i_s_dvsn,i_s_pdcd + '%',i_s_ccyymm,l_s_stscd)
	if i_s_retrieve_count > 0 then 
		tb.tb_1.cb_Sort.enabled = true
	else
		tb.tb_1.cb_Sort.enabled = false
	end if
end if

if i_s_retrieve_count > 0 then
	uo_status.st_message.text = f_message("I010")
	i_s_retrieve = 'I'
else
	uo_status.st_message.text = f_message("I020")
end if

//if l_s_stscd = '1' then
//	i_b_save     = false
//	i_b_delete   = false
//   wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
//					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
//					  i_b_dprint,    i_b_dchar)
//else
//	i_b_save     = true
//	i_b_delete   = true
//   wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
//					  i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
//					  i_b_dprint,    i_b_dchar)				
//					
//end if


end event

event ue_insert;call super::ue_insert;
uo_status.st_message.text = ''
tb.tb_2.dw_3.dataobject = 'd_mpsu01_03'
tb.tb_2.dw_3.settransobject(sqlca)
wf_Return() 
i_s_retrieve_count = tb.tb_2.dw_3.retrieve(g_s_company,i_s_xplant,i_s_dvsn,i_s_pdcd + '%')
uo_status.st_message.text = f_message("A070")
i_s_retrieve = 'A'

end event

event ue_save;call super::ue_save;datawindow gk2,gk3
int i = 0
string l_s_sle_date
 
if i_s_retrieve <> 'I' and i_s_retrieve <> 'A' then
	return 1
end if

l_s_sle_Date = f_get_mps_sle105('RSPDBALL')

gk2 = tb.tb_1.dw_2
gk3 = tb.tb_2.dw_3

gk2.accepttext()
gk3.accepttext()
setpointer(hourglass!)
if i_n_tabindex = 1 then
	for i = 1 to i_s_retrieve_count
		if gk2.getitemstatus(i,0,primary!) <> NotModified! then
			gk2.object.mps001_aohqt[i] = gk2.object.onhand_qty[i] 	
			if gk2.object.mps001_aohqt[i] < 0 then
				messagebox("확인", "품번 " + trim(gk2.object.mps001_aitno[i]) + "의 잔여 생산량과 잔여 출하량을 확인 바랍니다 " )
				return 1
			end if
			gk2.object.mps001_achyn[i]    = ''
			gk2.object.mps001_alsdt[i]    = l_s_sle_date
			gk2.object.mps001_aupdt[i]    = g_s_date
			gk2.object.mps001_amacaddr[i] = g_s_macaddr
			gk2.object.mps001_aipaddr[i]  = g_s_ipaddr		
		end if
	next
	if gk2.update() = 1 then
		
	else
		uo_status.st_message.text = f_message("U020")
		return 
	end if
elseif i_n_tabindex = 2 then
	if i_s_retrieve = 'A' then
		for i = 1 to i_s_retrieve_count
//			l_s_linecode = trim(gk3.object.linecode[i])
			if gk3.object.check[i] = 'Y' then
//				if f_spacechk(f_get_deptnm(l_s_linecode ,'5')) = -1 and f_spacechk(l_s_linecode ) <> -1 then 			
//					messagebox("확인", "품번 " + trim(gk3.object.inv101_itno[i]) + "의 Line Code를 확인 바랍니다 " )
//					return 1
//				end if
				wf_mps001_insert(gk3,i)
			end if
		next
		uo_status.st_message.text = f_message("U010")
	elseif i_s_retrieve = 'I' then
		for i = 1 to i_s_retrieve_count
			if gk3.getitemstatus(i,0,primary!) <> NotModified! then
//				l_s_linecode = gk3.object.mps001_alnmn[i]
//				if f_spacechk(f_get_deptnm(l_s_linecode,'5')) = -1 and f_spacechk(l_s_linecode) <> -1 then 			
//					messagebox("확인", string(i) +  "열의 품번 " + trim(gk3.object.mps001_aitno[i]) + "의 Line Code ( " + trim(gk3.object.mps001_alnmn[i]) + " ) 를 확인 바랍니다 " )
//					return 1
//				end if
				gk3.object.mps001_asfsq[i]    = wf_asfsq(i_s_xplant,i_s_dvsn,gk3.object.mps001_aitno[i],&
				                                        					  i_s_ccyymm,gk3.object.mps001_asfsd[i] )
				gk3.object.mps001_achyn[i]    = ''
				gk3.object.mps001_aupdt[i]    = g_s_date
				gk3.object.mps001_alsdt[i]    = l_s_sle_date
				gk3.object.mps001_amacaddr[i] = g_s_macaddr
				gk3.object.mps001_aipaddr[i]  = g_s_ipaddr		
			end if
		next
		if gk3.update() = 1 then
			
		else
			uo_status.st_message.text = f_message("U020")
			return
		end if
	end if
	
end if

window l_s_wsheet
l_s_wsheet = w_frame.GetActiveSheet()
l_s_wsheet.TriggerEvent("ue_retrieve")
uo_status.st_message.text = f_message("U010")


end event

event ue_delete;call super::ue_delete;string l_s_xplant,l_s_dvsn,l_s_itno
int i,l_n_row
datawindow gk

gk = tb.tb_2.dw_3

l_n_row = gk.getselectedrow(0)

do until l_n_row = 0
	i++
	l_s_xplant = gk.object.mps001_aplant[l_n_row]
	l_s_dvsn   = gk.object.mps001_advsn[l_n_row]
	l_s_itno   = gk.object.mps001_aitno[l_n_row]	
	delete from pbmps.mps001
		where acmcd = :g_s_company and aplant = :l_s_xplant and
		      advsn = :l_s_dvsn    and aitno   = :l_s_itno
	using sqlca ;
	l_n_row = gk.getselectedrow(l_n_row)
loop

if i = 0 then
	uo_status.st_message.text = f_message("E030")
else
	window l_s_wsheet
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_retrieve")	
	uo_status.st_message.text = f_message("D010")
end if
	
	




end event

type uo_status from w_origin_sheet02`uo_status within w_mps_101u
end type

type uo_2 from uo_ccyymm_mps within w_mps_101u
integer x = 2816
integer y = 24
integer width = 512
integer height = 92
integer taborder = 10
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyymm_mps::destroy
end on

type st_2 from statictext within w_mps_101u
integer x = 2537
integer y = 36
integer width = 274
integer height = 72
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

type st_3 from statictext within w_mps_101u
integer x = 3355
integer y = 36
integer width = 219
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기준일"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_mps_101u
integer x = 3575
integer y = 24
integer width = 320
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type st_4 from statictext within w_mps_101u
integer x = 3899
integer y = 36
integer width = 210
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "작업일"
boolean focusrectangle = false
end type

type sle_2 from singlelineedit within w_mps_101u
integer x = 4096
integer y = 24
integer width = 133
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type st_5 from statictext within w_mps_101u
integer x = 4256
integer y = 36
integer width = 201
integer height = 52
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "잔여일"
boolean focusrectangle = false
end type

type sle_3 from singlelineedit within w_mps_101u
integer x = 4457
integer y = 24
integer width = 133
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
boolean righttoleft = true
end type

type tb from tab within w_mps_101u
integer x = 32
integer y = 152
integer width = 4567
integer height = 2324
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
tb_1 tb_1
tb_2 tb_2
end type

on tb.create
this.tb_1=create tb_1
this.tb_2=create tb_2
this.Control[]={this.tb_1,&
this.tb_2}
end on

on tb.destroy
destroy(this.tb_1)
destroy(this.tb_2)
end on

event selectionchanged;i_n_tabindex = newindex
//if i_n_tabindex = 1 then
//	i_b_insert   = false
//	i_b_delete   = false
//	i_b_save     = false
//elseif i_n_tabindex = 2 then
//	i_b_insert   = true
//	i_b_delete   = true
//	i_b_save     = true
//end if
//wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
//			     i_b_first,     i_b_prev,    i_b_next,  i_b_last,    i_b_dretrieve,  & 
//			     i_b_dprint,    i_b_dchar)
end event

type tb_1 from userobject within tb
integer x = 18
integer y = 100
integer width = 4530
integer height = 2208
long backcolor = 12632256
string text = "기말예상재고량계산"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
cb_sort cb_sort
sle_4 sle_4
cb_1 cb_1
dw_2 dw_2
end type

on tb_1.create
this.cb_sort=create cb_sort
this.sle_4=create sle_4
this.cb_1=create cb_1
this.dw_2=create dw_2
this.Control[]={this.cb_sort,&
this.sle_4,&
this.cb_1,&
this.dw_2}
end on

on tb_1.destroy
destroy(this.cb_sort)
destroy(this.sle_4)
destroy(this.cb_1)
destroy(this.dw_2)
end on

type cb_sort from commandbutton within tb_1
integer x = 2459
integer y = 8
integer width = 206
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "정열"
end type

event clicked;s_gms_rtnsort l_str_rtn

openwithparm(w_gms_setsort , tb.tb_1.dw_2)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	uo_status.st_message.text = "취소되었습니다."
	return 0
else
	uo_status.st_message.text = "정열중입니다..."
end if

tb.tb_1.sle_4.text = l_str_rtn.dspsort
tb.tb_1.dw_2.setsort(l_str_rtn.rtnsort)
tb.tb_1.dw_2.setredraw(false)
tb.tb_1.dw_2.sort()
tb.tb_1.dw_2.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type sle_4 from singlelineedit within tb_1
integer x = 18
integer y = 8
integer width = 2414
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within tb_1
integer x = 3648
integer y = 8
integer width = 302
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "계산"
end type

event clicked;string l_s_date,l_s_itno,l_s_pdcd
dec{0} l_s_abmbq
integer i,l_n_count,l_n_yesno
datawindow gk

setpointer(Hourglass!)

if wf_return() = '1' then
	messagebox("확인","현재 계산을 수행할 수 있는 상태가 아닙니다")
	return 
end if

l_n_yesno = messagebox("확인","잔여생산량과 잔여출하량을 0 로 초기화 하시겠습니까 ?",question!,yesno!,2)	
gk = tb.tb_1.dw_2
gk.reset()
l_n_count = gk.retrieve(g_s_company,i_s_xplant,i_s_dvsn,'%',i_s_ccyymm,'1')

l_s_date = uf_add_month_mps(i_s_ccyymm,-1)

for i = 1 to l_n_count
	l_s_itno = gk.object.mps001_aitno[i]	
	l_s_pdcd = gk.object.inv101_pdcd[i]
	if l_s_pdcd = '604' then
		l_s_pdcd = '61'
	end if
	l_s_pdcd = mid(l_s_pdcd,1,2)
	
	select bguqty into :l_s_abmbq from pbinv.inv402
	where comltd = :g_s_company and xplant = :i_s_xplant and div = :i_s_dvsn and
		  itno   = :l_s_itno    and xyear  = :l_s_date using sqlca;
	if sqlca.sqlcode <> 0 then
		l_s_abmbq = 0
	end if
	gk.object.mps001_abmbq[i] = l_s_abmbq
//	if l_n_yesno = 1 then
//		gk.object.mps001_apdqr[i] = 0
//		gk.object.mps001_aslqr[i] = 0
//	end if	
	wf_get_pcs(gk,i,l_s_pdcd,l_s_date,l_n_yesno)
next
if gk.update() = 1 then
	uo_status.st_message.text = '계산 완료'	
	gk.retrieve(g_s_company,i_s_xplant,i_s_dvsn,'%',i_s_ccyymm,' ')
	i_s_retrieve = 'I'
	tb.tb_1.cb_sort.enabled = true
else
	uo_status.st_message.text = '계산 불가'
end if


end event

type dw_2 from datawindow within tb_1
integer y = 128
integer width = 3945
integer height = 2072
integer taborder = 20
string title = "none"
string dataobject = "d_mpsu01_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)

end event

type tb_2 from userobject within tb
integer x = 18
integer y = 100
integer width = 4530
integer height = 2208
long backcolor = 12632256
string text = "기준정보수정"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
sle_5 sle_5
cb_sort1 cb_sort1
dw_3 dw_3
end type

on tb_2.create
this.sle_5=create sle_5
this.cb_sort1=create cb_sort1
this.dw_3=create dw_3
this.Control[]={this.sle_5,&
this.cb_sort1,&
this.dw_3}
end on

on tb_2.destroy
destroy(this.sle_5)
destroy(this.cb_sort1)
destroy(this.dw_3)
end on

type sle_5 from singlelineedit within tb_2
integer x = 32
integer y = 16
integer width = 2752
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type cb_sort1 from commandbutton within tb_2
integer x = 2811
integer y = 16
integer width = 192
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
boolean enabled = false
string text = "정열"
end type

event clicked;s_gms_rtnsort l_str_rtn

openwithparm(w_gms_setsort , tb.tb_2.dw_3)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	return 0
	uo_status.st_message.text = "취소되었습니다."
else
	uo_status.st_message.text = "정열중입니다..."
end if

tb.tb_2.sle_5.text = l_str_rtn.dspsort
tb.tb_2.dw_3.setsort(l_str_rtn.rtnsort)
tb.tb_2.dw_3.setredraw(false)
tb.tb_2.dw_3.sort()
tb.tb_2.dw_3.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type dw_3 from datawindow within tb_2
integer x = 23
integer y = 124
integer width = 4480
integer height = 2080
integer taborder = 30
string title = "none"
string dataobject = "d_mpsu01_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event clicked;if row <= 0 then
	return
end if

If Keydown(KeyShift!) then
	wf_Shift_Highlight(row, this)
ElseIf Keydown(KeyControl!) then
	i_i_LastRow = row
	if this.IsSelected(row) Then
		this.SelectRow(row,FALSE)
	else
		this.SelectRow(row,TRUE)
	end if	
Else
	i_i_LastRow = row
	this.SelectRow(0, FALSE)
	this.SelectRow(row, TRUE)
End If
if dwo.name	= 	'check'	then
	Post(handle(This),256,9,long(0,0)) 
end if
end event

event retrieveend;if this.dataobject = 'd_mpsu01_02' then
	int i
	setpointer(hourglass!)
	for i = 1 to rowcount
		this.object.mps001_asfsq[i]    = wf_asfsq( i_s_xplant,i_s_dvsn,this.object.mps001_aitno[i],&
																 i_s_ccyymm,this.object.mps001_asfsd[i] )
	next																						
end if
end event

type uo_1 from uo_plandiv_pdcd_rtn within w_mps_101u
integer x = 46
integer y = 8
integer width = 2478
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_rtn::destroy
end on

