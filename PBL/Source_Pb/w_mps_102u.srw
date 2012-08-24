$PBExportHeader$w_mps_102u.srw
$PBExportComments$생산계획 수립
forward
global type w_mps_102u from w_origin_sheet02
end type
type uo_2 from uo_ccyymm_mps within w_mps_102u
end type
type st_1 from statictext within w_mps_102u
end type
type tab_1 from tab within w_mps_102u
end type
type tb_1 from userobject within tab_1
end type
type st_3 from statictext within tb_1
end type
type cb_sort1 from commandbutton within tb_1
end type
type sle_1 from singlelineedit within tb_1
end type
type cb_1 from commandbutton within tb_1
end type
type dw_2 from datawindow within tb_1
end type
type tb_1 from userobject within tab_1
st_3 st_3
cb_sort1 cb_sort1
sle_1 sle_1
cb_1 cb_1
dw_2 dw_2
end type
type tb_2 from userobject within tab_1
end type
type st_dexpst from statictext within tb_2
end type
type st_10 from statictext within tb_2
end type
type st_dsfst from statictext within tb_2
end type
type st_8 from statictext within tb_2
end type
type st_dltsz from statictext within tb_2
end type
type st_6 from statictext within tb_2
end type
type st_ohqty from statictext within tb_2
end type
type st_9 from statictext within tb_2
end type
type st_itsrce from statictext within tb_2
end type
type st_7 from statictext within tb_2
end type
type st_pdcd from statictext within tb_2
end type
type st_4 from statictext within tb_2
end type
type pb_item from picturebutton within tb_2
end type
type st_spec from statictext within tb_2
end type
type sle_itno from singlelineedit within tb_2
end type
type st_2 from statictext within tb_2
end type
type dw_3 from datawindow within tb_2
end type
type tb_2 from userobject within tab_1
st_dexpst st_dexpst
st_10 st_10
st_dsfst st_dsfst
st_8 st_8
st_dltsz st_dltsz
st_6 st_6
st_ohqty st_ohqty
st_9 st_9
st_itsrce st_itsrce
st_7 st_7
st_pdcd st_pdcd
st_4 st_4
pb_item pb_item
st_spec st_spec
sle_itno sle_itno
st_2 st_2
dw_3 dw_3
end type
type tab_1 from tab within w_mps_102u
tb_1 tb_1
tb_2 tb_2
end type
type uo_1 from uo_plandiv_pdcd_rtn within w_mps_102u
end type
end forward

global type w_mps_102u from w_origin_sheet02
string title = "w_mps_102u"
uo_2 uo_2
st_1 st_1
tab_1 tab_1
uo_1 uo_1
end type
global w_mps_102u w_mps_102u

type variables
string i_s_xplant,i_s_dvsn,i_s_pdcd,i_s_date,i_s_select
datastore ids_1,ids_2
integer i_n_tabindex,i_n_count,i_n_clickedrow
dec{0} l_s_altsz,l_s_aohqt
string l_s_cls,l_s_srce,l_s_pdcd,l_s_spec,l_s_linenm,l_s_itsrce
dec{1} l_s_ohuqty,l_s_asfsd
end variables

forward prototypes
public subroutine wf_return ()
public function decimal wf_firstdata (string a_itno)
public function integer wf_errorchk (datawindow ag_this)
public subroutine wf_mps004_update (string a_year, string a_month, string a_xplant, string a_dvsn, string a_itno, string a_type, string a_check)
end prototypes

public subroutine wf_return ();string l_s_parm

l_s_parm    = uo_1.uf_return()
i_s_xplant  = mid(l_s_parm,1,1)
i_s_dvsn    = mid(l_s_parm,2,1)
i_s_pdcd    = mid(l_s_parm,3,4)
i_s_date    = uo_2.uf_yyyymm()




end subroutine

public function decimal wf_firstdata (string a_itno);//if i_n_tabindex <> 2 then
//	return 0
//end if
select itnm into :l_s_spec from pbinv.inv002
	where itno = :a_itno using sqlca ;

if sqlca.sqlcode <> 0 then
	tab_1.tb_2.st_spec.text = ''
else
	tab_1.tb_2.st_spec.text = mid(l_s_spec,1,30)
end if

select cls,srce,pdcd,ohuqty into :l_s_cls,:l_s_srce,:l_s_pdcd,:l_s_ohuqty from pbinv.inv101
	where comltd = :g_s_company and xplant = :i_s_xplant and div = :i_s_dvsn and itno = :a_itno using sqlca ;
	
if sqlca.sqlcode <> 0 then
	tab_1.tb_2.st_pdcd.text    =  ''
	tab_1.tb_2.st_itsrce.text  =  ''	
	tab_1.tb_2.st_ohqty.text   =  ''		
else
	if f_spacechk(l_s_srce) = -1 then
		l_s_itsrce = l_s_cls
	else
		l_s_itsrce = l_s_cls + ' / ' + l_s_srce
	end if
	tab_1.tb_2.st_pdcd.text    =  l_s_pdcd + ' ' + f_get_coflname('01','DAC160',trim(l_s_pdcd))
	tab_1.tb_2.st_itsrce.text  =  l_s_itsrce	
	tab_1.tb_2.st_ohqty.text   =  string(l_s_ohuqty)
end if

select asfsd,altsz,aohqt into :l_s_asfsd,:l_s_altsz,:l_s_aohqt from pbmps.mps001
	where acmcd = :g_s_company and aplant = :i_s_xplant and advsn = :i_s_dvsn and
	      aitno = :a_itno
using sqlca ;

if sqlca.sqlcode <> 0 then
	tab_1.tb_2.st_dsfst.text    =  ''
	tab_1.tb_2.st_dltsz.text    =  ''	
	tab_1.tb_2.st_dexpst.text   =  ''
else
	tab_1.tb_2.st_dsfst.text    =  string(l_s_asfsd)
	tab_1.tb_2.st_dltsz.text    =  string(l_s_altsz)	
	tab_1.tb_2.st_dexpst.text   =  string(l_s_aohqt)
end if

//if l_s_cls = '30' then
return l_s_aohqt
//else
//	return l_s_ohuqty
//end if

end function

public function integer wf_errorchk (datawindow ag_this);string l_s_column

ag_this.object.davcst.background.color  = rgb(255,250,239)
//ag_this.object.toline.background.color  = rgb(255,255,255)
ag_this.object.dplnq01.background.color = rgb(255,255,255)
ag_this.object.dplnq02.background.color = rgb(255,255,255)
ag_this.object.dplnq03.background.color = rgb(255,255,255)
ag_this.object.dplnq04.background.color = rgb(255,255,255)
ag_this.object.dplnq05.background.color = rgb(255,255,255)
ag_this.object.dplnq06.background.color = rgb(255,255,255)
//ag_this.object.jin1.background.color    = rgb(255,255,255)
//ag_this.object.jin2.background.color    = rgb(255,255,255)
//ag_this.object.jin3.background.color    = rgb(255,255,255)
//ag_this.object.jin4.background.color    = rgb(255,255,255)
//ag_this.object.jin5.background.color    = rgb(255,255,255)
//ag_this.object.jin6.background.color    = rgb(255,255,255)

if ag_this.object.davcst[1] <= 0 then
	ag_this.object.davcst.background.color  = rgb(255,255,0)
	l_s_column = 'davcst'
end if

//if f_spacechk(ag_this.object.toline[1]) <> -1 then
//	if f_spacechk(f_get_Deptnm(trim(ag_this.object.toline[1]),'5')) = -1 then
//		ag_this.object.toline.background.color  = rgb(255,255,0)
//		if len(l_s_column) = 0 then
//			l_s_column = 'toline'
//		end if
//	end if
//elseif  f_spacechk(ag_this.object.toline[1]) = -1 then
//	if (ag_this.object.jin1[1] + ag_this.object.jin2[1] + ag_this.object.jin3[1] + &
//	    ag_this.object.jin4[1] + ag_this.object.jin5[1] + ag_this.object.jin6[1] ) > 0 then
//		ag_this.object.toline.background.color  = rgb(255,255,0)
//		if len(l_s_column) = 0 then
//			l_s_column = 'toline'
//		end if
//	end if
//end if

if l_s_altsz <> 0 then
	if mod(ag_this.object.dplnq01[1] , l_s_altsz ) <> 0 then
		ag_this.object.dplnq01.background.color  = rgb(255,255,0)
		if len(l_s_column) = 0 then
			l_s_column = 'dplnq01'
		end if
	end if
	if mod(ag_this.object.dplnq02[1] , l_s_altsz ) <> 0 then
		ag_this.object.dplnq02.background.color  = rgb(255,255,0)
		if len(l_s_column) = 0 then
			l_s_column = 'dplnq02'
		end if
	end if
	if mod(ag_this.object.dplnq03[1] , l_s_altsz ) <> 0 then
		ag_this.object.dplnq03.background.color  = rgb(255,255,0)
		if len(l_s_column) = 0 then
			l_s_column = 'dplnq03'
		end if
	end if
	if mod(ag_this.object.dplnq04[1] , l_s_altsz ) <> 0 then
		ag_this.object.dplnq04.background.color  = rgb(255,255,0)
		if len(l_s_column) = 0 then
			l_s_column = 'dplnq04'
		end if
	end if
	if mod(ag_this.object.dplnq05[1] , l_s_altsz ) <> 0 then
		ag_this.object.dplnq05.background.color  = rgb(255,255,0)
		if len(l_s_column) = 0 then
			l_s_column = 'dplnq05'
		end if
	end if
	if mod(ag_this.object.dplnq06[1] , l_s_altsz ) <> 0 then
		ag_this.object.dplnq06.background.color  = rgb(255,255,0)
		if len(l_s_column) = 0 then
			l_s_column = 'dplnq06'
		end if
	end if
end if
//if f_spacechk(ag_this.object.toline[1]) <> -1 then
//	if l_s_altsz <> 0 then
//		if mod(ag_this.object.jin1[1] , l_s_altsz ) <> 0 then
//			ag_this.object.jin1.background.color  = rgb(255,255,0)
//			if len(l_s_column) = 0 then
//				l_s_column = 'jin1'
//			end if
//		end if
//		if mod(ag_this.object.jin2[1] , l_s_altsz ) <> 0 then
//			ag_this.object.jin2.background.color  = rgb(255,255,0)
//			if len(l_s_column) = 0 then
//				l_s_column = 'jin2'
//			end if
//		end if
//		if mod(ag_this.object.jin3[1] , l_s_altsz ) <> 0 then
//			ag_this.object.jin3.background.color  = rgb(255,255,0)
//			if len(l_s_column) = 0 then
//				l_s_column = 'jin3'
//			end if
//		end if
//		if mod(ag_this.object.jin4[1] , l_s_altsz ) <> 0 then
//			ag_this.object.jin4.background.color  = rgb(255,255,0)
//			if len(l_s_column) = 0 then
//				l_s_column = 'jin4'
//			end if
//		end if
//		if mod(ag_this.object.jin5[1] , l_s_altsz ) <> 0 then
//			ag_this.object.jin5.background.color  = rgb(255,255,0)
//			if len(l_s_column) = 0 then
//				l_s_column = 'jin5'
//			end if
//		end if
//		if mod(ag_this.object.jin6[1] , l_s_altsz ) <> 0 then
//			ag_this.object.jin6.background.color  = rgb(255,255,0)
//			if len(l_s_column) = 0 then
//				l_s_column = 'jin6'
//			end if
//		end if
//	end if
//	if (ag_this.object.jin1[1] + ag_this.object.jin2[1] + ag_this.object.jin3[1] + &
//	    ag_this.object.jin4[1] + ag_this.object.jin5[1] + ag_this.object.jin6[1] ) = 0 then
//		ag_this.object.jin1.background.color    = rgb(255,255,0)
//		ag_this.object.jin2.background.color    = rgb(255,255,0)
//		ag_this.object.jin3.background.color    = rgb(255,255,0)
//		ag_this.object.jin4.background.color    = rgb(255,255,0)
//		ag_this.object.jin5.background.color    = rgb(255,255,0)
//		ag_this.object.jin6.background.color    = rgb(255,255,0)
//		if len(l_s_column) = 0 then
//			l_s_column = 'jin1'
//		end if
//	end if
//end if

if len(l_s_column) > 0 then
	ag_this.setcolumn(l_s_column)
	ag_This.setfocus()
   	uo_status.st_message.text = f_message("E010")
	return 1
end if
return 0
end function

public subroutine wf_mps004_update (string a_year, string a_month, string a_xplant, string a_dvsn, string a_itno, string a_type, string a_check);int l_n_count , i
dec{2} l_d_davcst
dec{4} l_d_mrat
dec{0} l_d_bqtyd[],l_d_bqtye[],l_d_dplnq[],l_d_ddplnq[],l_d_deplnq[],l_d_fdplnq[],&
       l_d_altsz,l_d_aohqt
		 
datawindow dw_kew

dw_kew = tab_1.tb_2.dw_3

l_d_davcst = dw_kew.object.davcst[1]

//if f_spacechk(a_check) = -1 then
//	select dplnq01,dplnq02,dplnq03,dplnq04,dplnq05,dplnq06 into :l_d_dplnq[1],:l_d_dplnq[2],:l_d_dplnq[3],:l_d_dplnq[4],
//	                                                            :l_d_dplnq[4],:l_d_dplnq[6]  from pbmps.mps004
//	where dcmcd = :g_s_company and dyear = :a_year and dmonth = :a_month and dplant = :a_xplant and
//	      ddvsn = :a_dvsn      and ditno = :a_itno
//	using sqlca ;
//	l_d_dplnq[1] += dw_kew.object.jin1[1]
//	l_d_dplnq[2] += dw_kew.object.jin2[1]
//	l_d_dplnq[3] += dw_kew.object.jin3[1]
//	l_d_dplnq[4] += dw_kew.object.jin4[1]
//	l_d_dplnq[5] += dw_kew.object.jin5[1]
//	l_d_dplnq[6] += dw_kew.object.jin6[1]
//else
	l_d_dplnq[1] = dw_kew.object.dplnq01[1] 
	l_d_dplnq[2] = dw_kew.object.dplnq02[1] 
	l_d_dplnq[3] = dw_kew.object.dplnq03[1] 
	l_d_dplnq[4] = dw_kew.object.dplnq04[1] 
	l_d_dplnq[5] = dw_kew.object.dplnq05[1] 
	l_d_dplnq[6] = dw_kew.object.dplnq06[1] 
	
	l_d_dplnq[7] = dw_kew.object.dplnq07[1]
	l_d_dplnq[8] = dw_kew.object.dplnq08[1]
	l_d_dplnq[9] = dw_kew.object.dplnq09[1]
	l_d_dplnq[10] = dw_kew.object.dplnq10[1]
	l_d_dplnq[11] = dw_kew.object.dplnq11[1]
	l_d_dplnq[12] = dw_kew.object.dplnq12[1]
//end if

select bqtyd01,bqtye01,bqtyd02,bqtye02,bqtyd03,bqtye03,bqtyd04,bqtye04,bqtyd05,bqtye05,bqtyd06,bqtye06,
	bqtyd07,bqtye07,bqtyd08,bqtye08,bqtyd09,bqtye09,bqtyd10,bqtye10,bqtyd11,bqtye11,bqtyd12,bqtye12
   into :l_d_bqtyd[1],:l_d_bqtye[1],:l_d_bqtyd[2],:l_d_bqtye[2],:l_d_bqtyd[3],:l_d_bqtye[3], 
	     :l_d_bqtyd[4],:l_d_bqtye[4],:l_d_bqtyd[5],:l_d_bqtye[5],:l_d_bqtyd[6],:l_d_bqtye[6],
		  :l_d_bqtyd[7],:l_d_bqtye[7],:l_d_bqtyd[8],:l_d_bqtye[8],:l_d_bqtyd[9],:l_d_bqtye[9], 
	     :l_d_bqtyd[10],:l_d_bqtye[10],:l_d_bqtyd[11],:l_d_bqtye[11],:l_d_bqtyd[12],:l_d_bqtye[12]
from pbmps.mps002 
	where bcmcd = :g_s_company and byear = :a_year and bmonth = :a_month and
	      bplant = :a_xplant   and bdvsn = :a_dvsn   and bitno = :a_itno 
using sqlca ;
if sqlca.sqlcode = 0 then
	for i = 1 to 12 
		if ( l_d_bqtyd[i] + l_d_bqtye[i] ) = 0 then
			l_d_mrat = 0
		else
			l_d_mrat = l_d_bqtyd[i] / ( l_d_bqtyd[i] + l_d_bqtye[i] )
		end if
		l_d_ddplnq[i] = l_d_mrat * l_d_dplnq[i]
		l_d_deplnq[i] = l_d_dplnq[i] - l_d_ddplnq[i]
	next
else
	for i = 1 to 12 
		l_d_ddplnq[i] = l_d_dplnq[i]
		l_d_deplnq[i] = l_d_dplnq[i] - l_d_ddplnq[i]
	next
end if
l_d_fdplnq[1] = l_d_ddplnq[1] / 2   // M월 상반기 내수계획
l_d_fdplnq[2] = l_d_ddplnq[1] - l_d_fdplnq[1] // M+1 월 상반기 내수계획
l_d_fdplnq[3] = l_d_ddplnq[2] / 2   // M월 하반기 내수계획
l_d_fdplnq[4] = l_d_ddplnq[2] - l_d_fdplnq[3] // M+1 월 하반기 내수계획
l_d_fdplnq[5] = l_d_deplnq[1] / 2   // M월 상반기 수출계획
l_d_fdplnq[6] = l_d_deplnq[1] - l_d_fdplnq[5] // M+1 월 상반기 수출계획
l_d_fdplnq[7] = l_d_deplnq[2] / 2   // M월 하반기 수출계획
l_d_fdplnq[8] = l_d_deplnq[2] - l_d_fdplnq[7] // M+1 월 하반기 수출계획

if a_check <> 'A' then
	update pbmps.mps004
		set dplnq01 = :l_d_dplnq[1],ddplnq01 = :l_d_ddplnq[1],deplnq01 = :l_d_deplnq[1], dtype = :a_type,
			 dplnq02 = :l_d_dplnq[2],ddplnq02 = :l_d_ddplnq[2],deplnq02 = :l_d_deplnq[2], 
			 dplnq03 = :l_d_dplnq[3],ddplnq03 = :l_d_ddplnq[3],deplnq03 = :l_d_deplnq[3], 
			 dplnq04 = :l_d_dplnq[4],ddplnq04 = :l_d_ddplnq[4],deplnq04 = :l_d_deplnq[4],
			 dplnq05 = :l_d_dplnq[5],ddplnq05 = :l_d_ddplnq[5],deplnq05 = :l_d_deplnq[5], 
			 dplnq06 = :l_d_dplnq[6],ddplnq06 = :l_d_ddplnq[6],deplnq06 = :l_d_deplnq[6],
			 dplnq07 = :l_d_dplnq[7],ddplnq07 = :l_d_ddplnq[7],deplnq07 = :l_d_deplnq[7],
			 dplnq08 = :l_d_dplnq[8],ddplnq08 = :l_d_ddplnq[8],deplnq08 = :l_d_deplnq[8],
			 dplnq09 = :l_d_dplnq[9],ddplnq09 = :l_d_ddplnq[9],deplnq09 = :l_d_deplnq[9],
			 dplnq10 = :l_d_dplnq[10],ddplnq10 = :l_d_ddplnq[10],deplnq10 = :l_d_deplnq[10],
			 dplnq11 = :l_d_dplnq[11],ddplnq11 = :l_d_ddplnq[11],deplnq11 = :l_d_deplnq[11],
			 dplnq12 = :l_d_dplnq[12],ddplnq12 = :l_d_ddplnq[12],deplnq12 = :l_d_deplnq[12],
			 dfdplnq1 = :l_d_fdplnq[1],dfdplnq2 = :l_d_fdplnq[2],dsdplnq1 = :l_d_fdplnq[3],dsdplnq2 = :l_d_fdplnq[4],
			 dfeplnq1 = :l_d_fdplnq[5],dfeplnq2 = :l_d_fdplnq[6],dseplnq1 = :l_d_fdplnq[7],dseplnq2 = :l_d_fdplnq[8],
		    dupdt = :g_s_date ,dempno = :g_s_empno , dmacaddr = :g_s_macaddr,dipaddr = :g_s_ipaddr,davcst = :l_d_davcst
	where dcmcd = :g_s_company and dyear = :a_year and dmonth = :a_month and dplant = :a_xplant and
			ddvsn = :a_dvsn      and ditno  = :a_itno  
	using sqlca ;
	if sqlca.sqlcode <> 0 then
		messagebox("확인",sqlca.sqlerrtext)
	end if
else
	select altsz,aohqt into :l_d_altsz,:l_d_aohqt from pbmps.mps001
		where acmcd = :g_s_company and aplant = :a_xplant and advsn = :a_dvsn and aitno = :a_itno
	using sqlca ;
	if sqlca.sqlcode <> 0 then
		l_d_altsz = 0 
		l_d_aohqt = 0
	end if
	dw_kew.object.dcmcd[1]    = g_s_company
	dw_kew.object.dyear[1]    = a_year
	dw_kew.object.dmonth[1]   = a_month
	dw_kew.object.dltsz[1]    = l_d_altsz
	dw_kew.object.mps004_dexpst[1]   = l_d_aohqt
	dw_kew.object.dplant[1]   = a_xplant
	dw_kew.object.ddvsn[1]    = a_dvsn
	dw_kew.object.dline[1]    = ' '
	dw_kew.object.ditno[1]    = a_itno
	dw_kew.object.dtype[1]    = a_type
	dw_kew.object.dplnq01[1]  = l_d_dplnq[1]
	dw_kew.object.dplnq02[1]  = l_d_dplnq[2]
	dw_kew.object.dplnq03[1]  = l_d_dplnq[3]
	dw_kew.object.dplnq04[1]  = l_d_dplnq[4]
	dw_kew.object.dplnq05[1]  = l_d_dplnq[5]
	dw_kew.object.dplnq06[1]  = l_d_dplnq[6]
	dw_kew.object.dplnq07[1]  = l_d_dplnq[7]
	dw_kew.object.dplnq08[1]  = l_d_dplnq[8]
	dw_kew.object.dplnq09[1]  = l_d_dplnq[9]
	dw_kew.object.dplnq10[1]  = l_d_dplnq[10]
	dw_kew.object.dplnq11[1]  = l_d_dplnq[11]
	dw_kew.object.dplnq12[1]  = l_d_dplnq[12]
	dw_kew.object.ddplnq01[1] = l_d_ddplnq[1]
	dw_kew.object.ddplnq02[1] = l_d_ddplnq[2]
	dw_kew.object.ddplnq03[1] = l_d_ddplnq[3]
	dw_kew.object.ddplnq04[1] = l_d_ddplnq[4]
	dw_kew.object.ddplnq05[1] = l_d_ddplnq[5]
	dw_kew.object.ddplnq06[1] = l_d_ddplnq[6]
	dw_kew.object.ddplnq07[1] = l_d_ddplnq[7]
	dw_kew.object.ddplnq08[1] = l_d_ddplnq[8]
	dw_kew.object.ddplnq09[1] = l_d_ddplnq[9]
	dw_kew.object.ddplnq10[1] = l_d_ddplnq[10]
	dw_kew.object.ddplnq11[1] = l_d_ddplnq[11]
	dw_kew.object.ddplnq12[1] = l_d_ddplnq[12]
	dw_kew.object.deplnq01[1] = l_d_deplnq[1]
	dw_kew.object.deplnq02[1] = l_d_deplnq[2]
	dw_kew.object.deplnq03[1] = l_d_deplnq[3]
	dw_kew.object.deplnq04[1] = l_d_deplnq[4]
	dw_kew.object.deplnq05[1] = l_d_deplnq[5]
	dw_kew.object.deplnq06[1] = l_d_deplnq[6]
	dw_kew.object.deplnq07[1] = l_d_deplnq[7]
	dw_kew.object.deplnq08[1] = l_d_deplnq[8]
	dw_kew.object.deplnq09[1] = l_d_deplnq[9]
	dw_kew.object.deplnq10[1] = l_d_deplnq[10]
	dw_kew.object.deplnq11[1] = l_d_deplnq[11]
	dw_kew.object.deplnq12[1] = l_d_deplnq[12]
	dw_kew.object.mps004_dfdplnq1[1] = l_d_fdplnq[1]
	dw_kew.object.mps004_dfdplnq2[1] = l_d_fdplnq[2]
	dw_kew.object.mps004_dsdplnq1[1] = l_d_fdplnq[3]
	dw_kew.object.mps004_dsdplnq2[1] = l_d_fdplnq[4]
	dw_kew.object.mps004_dfeplnq1[1] = l_d_fdplnq[5]
	dw_kew.object.mps004_dfeplnq2[1] = l_d_fdplnq[6]
	dw_kew.object.mps004_dseplnq1[1] = l_d_fdplnq[7]
	dw_kew.object.mps004_dseplnq2[1] = l_d_fdplnq[8]
	dw_kew.object.dupdt[1]    = g_s_date 
	dw_kew.object.dcrdt[1]    = g_s_date 
	dw_kew.object.dempno[1]   = g_s_empno 
	dw_kew.object.dmacaddr[1] = g_s_macaddr
	dw_kew.object.dipaddr[1]  = g_s_ipaddr 
	if dw_kew.update() <> 1 then
		messagebox("확인",sqlca.sqlerrtext)
	end if
end if



end subroutine

on w_mps_102u.create
int iCurrent
call super::create
this.uo_2=create uo_2
this.st_1=create st_1
this.tab_1=create tab_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.uo_1
end on

on w_mps_102u.destroy
call super::destroy
destroy(this.uo_2)
destroy(this.st_1)
destroy(this.tab_1)
destroy(this.uo_1)
end on

event ue_retrieve;call super::ue_retrieve;integer l_n_count
dec{3}  l_s_qty

setpointer(Hourglass!)
uo_status.st_message.text = ''
i_s_Select = ''
wf_Return()

if i_n_tabindex = 1 then
	tab_1.tb_1.dw_2.reset()
	i_n_count = tab_1.tb_1.dw_2.retrieve(g_s_company,i_s_xplant,i_s_dvsn, trim(i_s_pdcd) + '%' , i_s_date )
	if i_n_count > 0 then
		tab_1.tb_1.cb_sort1.enabled = true
	else
		tab_1.tb_1.cb_sort1.enabled = false
	end if
	l_n_count = i_n_count
else
	l_s_qty   = wf_firstdata(trim(tab_1.tb_2.sle_itno.text))
	tab_1.tb_2.dw_3.reset()
	l_n_count = tab_1.tb_2.dw_3.retrieve(g_s_company,i_s_xplant,i_s_dvsn,trim(tab_1.tb_2.sle_itno.text),& 
	                                     i_s_date,l_s_qty)
end if			

if l_n_count > 0 then 
	if i_n_tabindex = 2 then
		i_s_Select = 'R'
	end if
	uo_status.st_message.text = f_message("I010")
else
	uo_status.st_message.text = f_message("I020")
end if


end event

event open;call super::open;i_b_retrieve  = true
i_b_insert    = true
i_b_save      = true
i_b_delete    = true
wf_icon_onoff(i_b_retrieve,  i_b_insert,  i_b_save,  i_b_delete,  i_b_print,      & 
					  i_b_first,     i_b_prev, i_b_next,  i_b_last,    i_b_dretrieve,  & 
					  i_b_dprint,    i_b_dchar)
end event

event ue_insert;call super::ue_insert;string l_s_itno 
int    l_s_count
dec{0} l_d_bqty[],l_d_davcst

i_s_select = ''
uo_status.st_message.text = ''
setpointer(HourGlass!)
if i_n_tabindex <> 2 then
	messagebox("확인","모델별 생산계획 에서 입력 바랍니다")
	return
end if
wf_return()

l_s_itno = trim(tab_1.tb_2.sle_itno.text)
wf_firstdata(l_s_itno)

if f_spacechk(l_s_itno) = -1 then
	messagebox("확인","품번을 확인하신 후 입력 바랍니다 ")
	return
end if

select count(*) into :l_s_count from pbmps.mps004
	where dcmcd = :g_s_company and dyear || dmonth = :i_s_date and
	      dplant = :i_s_xplant and ddvsn = :i_s_dvsn and ditno = :l_s_itno using sqlca ;
if l_s_count > 0 then
	messagebox("확인","이미 입력된 품번입니다.")
	return 
end if

if mid(tab_1.tb_2.st_itsrce.text,6,2) = '03' then
	
elseif mid(tab_1.tb_2.st_itsrce.text,1,2) = '30' then
	select count(*) into :l_s_count from pbmps.mps001
		where acmcd = :g_s_company and aplant = :i_s_xplant and advsn = :i_s_dvsn and aitno = :l_s_itno 
	using sqlca ;
	if l_s_count < 1 then
		messagebox("확인","기준 Data 에 등록 후 입력 가능 합니다")
		return 
	end if
else	
	messagebox("확인","단품은 입력할 수 없습니다")
	return 
end if

tab_1.tb_2.dw_3.reset()
tab_1.tb_2.dw_3.insertrow(0)
tab_1.tb_2.dw_3.object.dline[1]  = ' '
select avgprc into :l_d_davcst from pbsle.sle213
	where comltd = :g_s_company and cym = :i_s_date and xplant = :i_s_xplant and div = :i_s_dvsn 
using sqlca ;
if sqlca.sqlcode <> 0 then
	select saud into :l_d_davcst from pbinv.inv101
		where comltd = :g_s_company and xplant = :i_s_xplant and div = :i_s_dvsn and itno = :l_s_itno 
	using sqlca ;
	if sqlca.sqlcode <> 0 then
		l_d_davcst = 0
	end if
end if 

tab_1.tb_2.dw_3.object.davcst[1] = l_d_davcst

select bqtyd01,bqtye01,bqtyd02,bqtye02,bqtyd03,bqtye03,
       bqtyd04,bqtye04,bqtyd05,bqtye05,bqtyd06,bqtye06 into :l_d_bqty[1],:l_d_bqty[2],:l_d_bqty[3],
                                                            :l_d_bqty[4],:l_d_bqty[5],:l_d_bqty[6],
                                                            :l_d_bqty[7],:l_d_bqty[8],:l_d_bqty[9],
                                                            :l_d_bqty[10],:l_d_bqty[11],:l_d_bqty[12] from pbmps.mps002
where bcmcd = :g_s_company and bplant = :i_s_xplant and bdvsn = :i_s_dvsn and bitno = :l_s_itno and byear || bmonth = :i_s_date
using sqlca ;
if sqlca.sqlcode <> 0 then
	tab_1.tb_2.dw_3.object.mps002_bqtyd01[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye01[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd02[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye02[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd03[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye03[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd04[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye04[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd05[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye05[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd06[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye06[1] = 0
else
	tab_1.tb_2.dw_3.object.mps002_bqtyd01[1] = l_d_bqty[1]
	tab_1.tb_2.dw_3.object.mps002_bqtye01[1] = l_d_bqty[2]
	tab_1.tb_2.dw_3.object.mps002_bqtyd02[1] = l_d_bqty[3]
	tab_1.tb_2.dw_3.object.mps002_bqtye02[1] = l_d_bqty[4]
	tab_1.tb_2.dw_3.object.mps002_bqtyd03[1] = l_d_bqty[5]
	tab_1.tb_2.dw_3.object.mps002_bqtye03[1] = l_d_bqty[6]
	tab_1.tb_2.dw_3.object.mps002_bqtyd04[1] = l_d_bqty[7]
	tab_1.tb_2.dw_3.object.mps002_bqtye04[1] = l_d_bqty[8]
	tab_1.tb_2.dw_3.object.mps002_bqtyd05[1] = l_d_bqty[9]
	tab_1.tb_2.dw_3.object.mps002_bqtye05[1] = l_d_bqty[10]
	tab_1.tb_2.dw_3.object.mps002_bqtyd06[1] = l_d_bqty[11]
	tab_1.tb_2.dw_3.object.mps002_bqtye06[1] = l_d_bqty[12]
end if
tab_1.tb_2.dw_3.setfocus()
i_s_select = 'A'
uo_status.st_message.text = f_message("A070") 



end event

event ue_save;call super::ue_save;datawindow dw_kew
string l_s_year,l_s_month,l_s_type,l_s_line,l_s_itno
int    l_n_count
dec{0} l_d_asfsq,l_d_altsz,l_d_aohqt

setpointer(Hourglass!)
uo_status.st_message.text = ''
if i_n_tabindex <> 2 then
		messagebox("확인","모델별 생산계획 에서만 저장이 가능합니다")
	return
end if
dw_kew = tab_1.tb_2.dw_3
dw_kew.accepttext()
if wf_errorchk(dw_kew) = 1 then
	return
end if
l_s_year    = mid(i_s_date,1,4)
l_s_month   = mid(i_s_date,5,2)
l_s_itno    = trim(tab_1.tb_2.sle_itno.text)

if mid(tab_1.tb_2.st_itsrce.text,6,2) = '03' then
	l_s_type    = 'A'
elseif mid(tab_1.tb_2.st_itsrce.text,1,2) = '30' then
	l_s_type    = ' '
else
	l_s_type    = 'B'
end if

wf_mps004_update(l_s_year,l_s_month,i_s_xplant,i_s_dvsn,trim(l_s_itno),trim(l_s_type),i_s_select )

dw_kew.reset()

dec{3} l_s_qty

if i_n_clickedrow > 0 and i_n_clickedrow < i_n_count and i_s_select = 'R' then
	i_n_clickedrow += 1
	tab_1.tb_2.sle_itno.text  = tab_1.tb_1.dw_2.object.mps004_ditno[i_n_clickedrow]
	uo_status.st_message.text = '품번 ' + l_s_itno + ' 수정 완료.  다음 품번 수정 작업하시기 바랍니다.'
else	
   uo_status.st_message.text = f_message("U010")	
end if

l_s_qty   = wf_firstdata(trim(tab_1.tb_2.sle_itno.text))
dw_kew.retrieve(g_s_company,i_s_xplant,i_s_dvsn,trim(tab_1.tb_2.sle_itno.text),& 
      						 i_s_date,l_s_qty)	 


end event

event ue_delete;call super::ue_delete;integer l_n_yesno
string  l_s_year,l_s_month,l_s_itno,l_s_type

if i_n_tabindex <> 2 then
		messagebox("확인","모델별 생산계획에서 삭제 바랍니다")
	return
end if
l_s_year = mid(i_s_date,1,4)
l_s_month = mid(i_s_date,5,2)
l_s_itno  = trim(tab_1.tb_2.sle_itno.text)
if mid(tab_1.tb_2.st_itsrce.text,6,2) = '03' then
	l_s_type    = 'A'
elseif f_spacechk(mid(tab_1.tb_2.st_itsrce.text,6,2)) = -1 then
	l_s_type    = ' '
else
	l_s_type    = 'B'
end if
l_n_yesno = messagebox("삭제확인", "현재 품번 " + l_S_itno + " 을 생산계획에서 삭제하시겠습니까 ?",Question!,OkCancel!,2)
if l_n_yesno <> 1 then
	uo_status.st_message.text = f_message("D030")
	return 0
end if

delete from pbmps.mps004
where dcmcd = :g_s_company and dyear = :l_s_year and dmonth = :l_s_month and dplant = :i_s_xplant and
      ddvsn = :i_s_dvsn    and ditno = :l_s_itno  and dtype  = :l_s_type
using sqlca ;

tab_1.tb_2.dw_3.reset()
uo_status.st_message.text = f_message('D010')

end event

type uo_status from w_origin_sheet02`uo_status within w_mps_102u
end type

type uo_2 from uo_ccyymm_mps within w_mps_102u
integer x = 2875
integer y = 24
integer taborder = 20
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyymm_mps::destroy
end on

type st_1 from statictext within w_mps_102u
integer x = 2583
integer y = 36
integer width = 270
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
string text = "적용년월"
boolean focusrectangle = false
end type

type tab_1 from tab within w_mps_102u
integer x = 23
integer y = 136
integer width = 4558
integer height = 2356
integer taborder = 30
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

on tab_1.create
this.tb_1=create tb_1
this.tb_2=create tb_2
this.Control[]={this.tb_1,&
this.tb_2}
end on

on tab_1.destroy
destroy(this.tb_1)
destroy(this.tb_2)
end on

event selectionchanged;i_n_tabindex = newindex
wf_return()

			 
end event

type tb_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4521
integer height = 2240
long backcolor = 12632256
string text = "제품별 생산계획 "
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_3 st_3
cb_sort1 cb_sort1
sle_1 sle_1
cb_1 cb_1
dw_2 dw_2
end type

on tb_1.create
this.st_3=create st_3
this.cb_sort1=create cb_sort1
this.sle_1=create sle_1
this.cb_1=create cb_1
this.dw_2=create dw_2
this.Control[]={this.st_3,&
this.cb_sort1,&
this.sle_1,&
this.cb_1,&
this.dw_2}
end on

on tb_1.destroy
destroy(this.st_3)
destroy(this.cb_sort1)
destroy(this.sle_1)
destroy(this.cb_1)
destroy(this.dw_2)
end on

type st_3 from statictext within tb_1
integer x = 3255
integer y = 2172
integer width = 1239
integer height = 72
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 255
long backcolor = 12632256
string text = "생산금액,재고금액 단위는 만원입니다"
boolean focusrectangle = false
end type

type cb_sort1 from commandbutton within tb_1
integer x = 2501
integer y = 16
integer width = 192
integer height = 92
integer taborder = 30
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

openwithparm(w_gms_setsort , tab_1.tb_1.dw_2)
l_str_rtn = message.powerobjectparm

if f_spacechk(l_str_rtn.rtnsort) = -1 then
	uo_status.st_message.text = "취소되었습니다."
	return 0
else
	uo_status.st_message.text = "정열중입니다..."
end if

tab_1.tb_1.sle_1.text = l_str_rtn.dspsort
tab_1.tb_1.dw_2.setsort(l_str_rtn.rtnsort)
tab_1.tb_1.dw_2.setredraw(false)
tab_1.tb_1.dw_2.sort()
tab_1.tb_1.dw_2.setredraw(true)
uo_status.st_message.text = "정열되었습니다."
end event

type sle_1 from singlelineedit within tb_1
integer x = 18
integer y = 16
integer width = 2459
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
integer x = 4128
integer y = 24
integer width = 352
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "계 산"
end type

event clicked;int l_n_count,l_n_row,i,j
dec{0} l_s_texpm[12],l_s_tpplnm[12]
dec{3} l_s_avgcst
string l_s_itno,l_s_chkpdcd,l_s_return,ls_dtype

setpointer(Hourglass!)

wf_return()
l_s_return = f_get_mps007(g_s_company,i_s_xplant,i_s_dvsn,i_s_date)
if mid(l_s_return,1,8) <= g_s_date and ( mid(l_s_return,9,1) = 'I' OR mid(l_s_return,9,1) = 'N' ) then
else
	messagebox("확인","생산계획 계산을 위한 상태가 아닙니다.")
	return 0
end if

// 품목별 출하계획수량
ids_1 = create datastore 
ids_1.dataobject = 'd_mpsu02_02'
ids_1.settransobject(Sqlca)
// 생산계획수량
ids_2 = create datastore
ids_2.dataobject = 'd_mpsu02_03'
ids_2.settransobject(Sqlca)
//
l_s_chkpdcd  = trim(i_s_pdcd) + '%'
l_n_count = ids_1.retrieve(g_s_company,i_s_xplant,i_s_dvsn,l_s_chkpdcd,i_s_date)
delete from pbmps.mps004
	where dcmcd = :g_s_company and dplant = :i_s_xplant and ddvsn = :i_s_dvsn and dyear || dmonth = :i_s_date and
	 	  ditno in ( select itno from pbinv.inv101 where comltd = :g_S_company and xplant = :i_s_xplant and 
		             div = :i_s_dvsn and pdcd like :l_s_chkpdcd ) 
using sqlca ;

for i = 1 to l_n_count
	l_n_row   =  ids_2.insertrow(0)
	l_s_itno  =  trim(ids_1.object.mps002_bitno[i])
	ids_2.object.dcmcd[l_n_row]    = g_s_company
	ids_2.object.dyear[l_n_row]    = mid(i_s_date,1,4)
	ids_2.object.dmonth[l_n_row]   = mid(i_s_date,5,2)
	ids_2.object.dplant[l_n_row]   = i_s_xplant
	ids_2.object.ddvsn[l_n_row]    = i_s_dvsn
	ids_2.object.dtype[l_n_row]    = ids_1.object.mps002_btype[i]
	ids_2.object.ditno[l_n_row]    = l_s_itno
	ids_2.object.dline[l_n_row]    = ' '
	ids_2.object.dsfst[l_n_row]    = ids_1.object.mps001_asfsd[i]
	ids_2.object.dltsz[l_n_row]    = ids_1.object.mps001_altsz[i]
   ids_2.object.dexpst[l_n_row]   = ids_1.object.mps001_aohqt[i]
   if f_spacechk(ids_2.object.dtype[l_n_row]) = -1 then
		if ids_1.object.mps001_aohqt[i] < 0 then
			l_s_texpm[1] = 0 - ( ids_1.object.qty01[i] + ids_1.object.mps001_asfsq[i] )
		else
			l_s_texpm[1] = ids_1.object.mps001_aohqt[i] - ( ids_1.object.qty01[i] + ids_1.object.mps001_asfsq[i] )
		end if
//		if l_s_texpm[1] >=  0 then
//			l_s_tpplnm[1] =  0
//		end if

		// 기말예상재고량을 기준으로 생산계획수량을 누적으로 차감해서 12개월치를 계산함
		//* l_s_texpm > 0 보다 크다는 것은 재고가 존재한다는 것을 의미함. 따라서 생산을 할 필요가 없다는 뜻
		l_s_texpm[2]    = l_s_texpm[1] - ids_1.object.qty02[i]
		l_s_texpm[3]    = l_s_texpm[2] - ids_1.object.qty03[i]		
		l_s_texpm[4]    = l_s_texpm[3] - ids_1.object.qty04[i]		
		l_s_texpm[5]    = l_s_texpm[4] - ids_1.object.qty05[i]		
		l_s_texpm[6]    = l_s_texpm[5] - ids_1.object.qty06[i]	
		
		l_s_texpm[7]    = l_s_texpm[6] - ids_1.object.qty07[i]
		l_s_texpm[8]    = l_s_texpm[7] - ids_1.object.qty08[i]
		l_s_texpm[9]    = l_s_texpm[8] - ids_1.object.qty09[i]
		l_s_texpm[10]    = l_s_texpm[9] - ids_1.object.qty10[i]
		l_s_texpm[11]    = l_s_texpm[10] - ids_1.object.qty11[i]
		l_s_texpm[12]    = l_s_texpm[11] - ids_1.object.qty12[i]
		

		if ids_1.object.qty01[i] = 0 or l_s_texpm[1] >= 0 then
			l_s_tpplnm[1] = 0
		else
			l_s_tpplnm[1] = l_s_texpm[1] * -1
		end if
		if ids_1.object.qty02[i] = 0 or l_s_texpm[2] >= 0 then
			l_s_tpplnm[2] = 0
		else
			l_s_tpplnm[2] = l_s_texpm[2] * -1
		end if
		if ids_1.object.qty03[i] = 0 or l_s_texpm[3] >= 0 then
			l_s_tpplnm[3] = 0
		else
			l_s_tpplnm[3] = l_s_texpm[3] * -1
		end if		
		if ids_1.object.qty04[i] = 0 or l_s_texpm[4] >= 0 then
			l_s_tpplnm[4] = 0
		else
			l_s_tpplnm[4] = l_s_texpm[4] * -1
		end if
		if ids_1.object.qty05[i] = 0 or l_s_texpm[5] >= 0 then
			l_s_tpplnm[5] = 0
		else
			l_s_tpplnm[5] = l_s_texpm[5] * -1
		end if
		if ids_1.object.qty06[i] = 0 or l_s_texpm[6] >= 0 then
			l_s_tpplnm[6] = 0
		else
			l_s_tpplnm[6] = l_s_texpm[6] * -1
		end if		
		
		if ids_1.object.qty07[i] = 0 or l_s_texpm[7] >= 0 then
			l_s_tpplnm[7] = 0
		else
			l_s_tpplnm[7] = l_s_texpm[7] * -1
		end if
		if ids_1.object.qty08[i] = 0 or l_s_texpm[8] >= 0 then
			l_s_tpplnm[8] = 0
		else
			l_s_tpplnm[8] = l_s_texpm[8] * -1
		end if
		if ids_1.object.qty09[i] = 0 or l_s_texpm[9] >= 0 then
			l_s_tpplnm[9] = 0
		else
			l_s_tpplnm[9] = l_s_texpm[9] * -1
		end if
		if ids_1.object.qty10[i] = 0 or l_s_texpm[10] >= 0 then
			l_s_tpplnm[10] = 0
		else
			l_s_tpplnm[10] = l_s_texpm[10] * -1
		end if
		if ids_1.object.qty11[i] = 0 or l_s_texpm[11] >= 0 then
			l_s_tpplnm[11] = 0
		else
			l_s_tpplnm[11] = l_s_texpm[11] * -1
		end if
		if ids_1.object.qty12[i] = 0 or l_s_texpm[12] >= 0 then
			l_s_tpplnm[12] = 0
		else
			l_s_tpplnm[12] = l_s_texpm[12] * -1
		end if
		
		// Lot-Size 에 맞는 생산수량으로 재계산
		if ids_1.object.mps001_altsz[i] <> 0 then
			for j = 1 to 12
				if l_s_tpplnm[j] <> 0 then
					l_s_tpplnm[j] = ids_1.object.mps001_altsz[i] *  ceiling( l_s_tpplnm[j] / ids_1.object.mps001_altsz[i] )
				end if
			next
		end if
		
		// tpplnm 의 누적생산계획수량을 전월 생산계획수량을 빼서 순수 해당월 생산계획수량으로 변환
		ids_2.object.dplnq01[l_n_row] = l_s_tpplnm[1]
		if l_s_tpplnm[2] = 0 then
			ids_2.object.dplnq02[l_n_row] = 0
		else
			ids_2.object.dplnq02[l_n_row] = l_s_tpplnm[2] - ids_2.object.dplnq01[l_n_row]
		end if
		if l_s_tpplnm[3] = 0 then
			ids_2.object.dplnq03[l_n_row] = 0
		else
			ids_2.object.dplnq03[l_n_row] = l_s_tpplnm[3] - ( ids_2.object.dplnq01[l_n_row] +  ids_2.object.dplnq02[l_n_row] )
		end if
		if l_s_tpplnm[4] = 0 then
			ids_2.object.dplnq04[l_n_row] = 0
		else
			ids_2.object.dplnq04[l_n_row] = l_s_tpplnm[4] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] )
		end if
		if l_s_tpplnm[5] = 0 then
			ids_2.object.dplnq05[l_n_row] = 0
		else
			ids_2.object.dplnq05[l_n_row] = l_s_tpplnm[5] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] + ids_2.object.dplnq04[l_n_row] )
		end if
		if l_s_tpplnm[6] = 0 then
			ids_2.object.dplnq06[l_n_row] = 0
		else
			ids_2.object.dplnq06[l_n_row] = l_s_tpplnm[6] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] + ids_2.object.dplnq04[l_n_row] + & 
														 ids_2.object.dplnq05[l_n_row] )
		end if
		
		if l_s_tpplnm[7] = 0 then
			ids_2.object.dplnq07[l_n_row] = 0
		else
			ids_2.object.dplnq07[l_n_row] = l_s_tpplnm[7] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] + ids_2.object.dplnq04[l_n_row] + & 
														 ids_2.object.dplnq05[l_n_row] + ids_2.object.dplnq06[l_n_row])
		end if
		if l_s_tpplnm[8] = 0 then
			ids_2.object.dplnq08[l_n_row] = 0
		else
			ids_2.object.dplnq08[l_n_row] = l_s_tpplnm[8] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] + ids_2.object.dplnq04[l_n_row] + & 
														 ids_2.object.dplnq05[l_n_row] + ids_2.object.dplnq06[l_n_row] + &
														 ids_2.object.dplnq07[l_n_row] )
		end if
		if l_s_tpplnm[9] = 0 then
			ids_2.object.dplnq09[l_n_row] = 0
		else
			ids_2.object.dplnq09[l_n_row] = l_s_tpplnm[9] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] + ids_2.object.dplnq04[l_n_row] + & 
														 ids_2.object.dplnq05[l_n_row] + ids_2.object.dplnq06[l_n_row] + &
														 ids_2.object.dplnq07[l_n_row] + ids_2.object.dplnq08[l_n_row])
		end if
		if l_s_tpplnm[10] = 0 then
			ids_2.object.dplnq10[l_n_row] = 0
		else
			ids_2.object.dplnq10[l_n_row] = l_s_tpplnm[10] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] + ids_2.object.dplnq04[l_n_row] + & 
														 ids_2.object.dplnq05[l_n_row] + ids_2.object.dplnq06[l_n_row] + &
														 ids_2.object.dplnq07[l_n_row] + ids_2.object.dplnq08[l_n_row] + &
														 ids_2.object.dplnq09[l_n_row] )
		end if
		if l_s_tpplnm[11] = 0 then
			ids_2.object.dplnq11[l_n_row] = 0
		else
			ids_2.object.dplnq11[l_n_row] = l_s_tpplnm[11] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] + ids_2.object.dplnq04[l_n_row] + & 
														 ids_2.object.dplnq05[l_n_row] + ids_2.object.dplnq06[l_n_row] + &
														 ids_2.object.dplnq07[l_n_row] + ids_2.object.dplnq08[l_n_row] + &
														 ids_2.object.dplnq09[l_n_row] + ids_2.object.dplnq10[l_n_row])
		end if
		if l_s_tpplnm[12] = 0 then
			ids_2.object.dplnq12[l_n_row] = 0
		else
			ids_2.object.dplnq12[l_n_row] = l_s_tpplnm[12] - &
			                                ( ids_2.object.dplnq01[l_n_row] + ids_2.object.dplnq02[l_n_row] + & 
													    ids_2.object.dplnq03[l_n_row] + ids_2.object.dplnq04[l_n_row] + & 
														 ids_2.object.dplnq05[l_n_row] + ids_2.object.dplnq06[l_n_row] + &
														 ids_2.object.dplnq07[l_n_row] + ids_2.object.dplnq08[l_n_row] + &
														 ids_2.object.dplnq09[l_n_row] + ids_2.object.dplnq10[l_n_row] + &
														 ids_2.object.dplnq11[l_n_row] )
		end if
	// 반제품,단품 동일하게 생산수량 계산 (2003.04.29)
	else 
		ids_2.object.dplnq01[l_n_row] = ids_1.object.qty01[i]
		ids_2.object.dplnq02[l_n_row] = ids_1.object.qty02[i]
		ids_2.object.dplnq03[l_n_row] = ids_1.object.qty03[i]	
		ids_2.object.dplnq04[l_n_row] = ids_1.object.qty04[i]		
		ids_2.object.dplnq05[l_n_row] = ids_1.object.qty05[i]		
		ids_2.object.dplnq06[l_n_row] = ids_1.object.qty06[i]		
		
		ids_2.object.dplnq07[l_n_row] = ids_1.object.qty07[i]	
		ids_2.object.dplnq08[l_n_row] = ids_1.object.qty08[i]	
		ids_2.object.dplnq09[l_n_row] = ids_1.object.qty09[i]	
		ids_2.object.dplnq10[l_n_row] = ids_1.object.qty10[i]	
		ids_2.object.dplnq11[l_n_row] = ids_1.object.qty11[i]	
		ids_2.object.dplnq12[l_n_row] = ids_1.object.qty12[i]	
	end if
//	elseif ids_2.object.dtype[l_n_row] = 'A' then
//		ids_2.object.dplnq01[l_n_row] = ids_1.object.qty01[i]
//		ids_2.object.dplnq02[l_n_row] = ids_1.object.qty02[i]
//		ids_2.object.dplnq03[l_n_row] = ids_1.object.qty03[i]	
//		ids_2.object.dplnq04[l_n_row] = ids_1.object.qty04[i]		
//		ids_2.object.dplnq05[l_n_row] = ids_1.object.qty05[i]		
//		ids_2.object.dplnq06[l_n_row] = ids_1.object.qty06[i]		
//	elseif ids_2.object.dtype[l_n_row] = 'B' then
//		ids_2.object.dplnq01[l_n_row] = 0
//		ids_2.object.dplnq02[l_n_row] = 0
//		ids_2.object.dplnq03[l_n_row] = 0
//		ids_2.object.dplnq04[l_n_row] = 0
//		ids_2.object.dplnq05[l_n_row] = 0
//		ids_2.object.dplnq06[l_n_row] = 0
//	end if

	// 내수용 생산계획량 계산
	if ids_1.object.qty01[i] <> 0 then
		ids_2.object.ddplnq01[l_n_row] = ( ids_1.object.mps002_bqtyd01[i] / ids_1.object.qty01[i]) * ids_2.object.dplnq01[l_n_row]
	end if
	if ids_1.object.qty02[i] <> 0 then
		ids_2.object.ddplnq02[l_n_row] = ( ids_1.object.mps002_bqtyd02[i] / ids_1.object.qty02[i]) * ids_2.object.dplnq02[l_n_row]
	end if
	if ids_1.object.qty03[i] <> 0 then
		ids_2.object.ddplnq03[l_n_row] = ( ids_1.object.mps002_bqtyd03[i] / ids_1.object.qty03[i]) * ids_2.object.dplnq03[l_n_row]
	end if
	if ids_1.object.qty04[i] <> 0 then
		ids_2.object.ddplnq04[l_n_row] = ( ids_1.object.mps002_bqtyd04[i] / ids_1.object.qty04[i]) * ids_2.object.dplnq04[l_n_row]
	end if
	if ids_1.object.qty05[i] <> 0 then
		ids_2.object.ddplnq05[l_n_row] = ( ids_1.object.mps002_bqtyd05[i] / ids_1.object.qty05[i]) * ids_2.object.dplnq05[l_n_row]
	end if
	if ids_1.object.qty06[i] <> 0 then
		ids_2.object.ddplnq06[l_n_row] = ( ids_1.object.mps002_bqtyd06[i] / ids_1.object.qty06[i]) * ids_2.object.dplnq06[l_n_row]
	end if
	
	if ids_1.object.qty07[i] <> 0 then
		ids_2.object.ddplnq07[l_n_row] = ( ids_1.object.mps002_bqtyd07[i] / ids_1.object.qty07[i]) * ids_2.object.dplnq07[l_n_row]
	end if
	if ids_1.object.qty08[i] <> 0 then
		ids_2.object.ddplnq08[l_n_row] = ( ids_1.object.mps002_bqtyd08[i] / ids_1.object.qty08[i]) * ids_2.object.dplnq08[l_n_row]
	end if
	if ids_1.object.qty09[i] <> 0 then
		ids_2.object.ddplnq09[l_n_row] = ( ids_1.object.mps002_bqtyd09[i] / ids_1.object.qty09[i]) * ids_2.object.dplnq09[l_n_row]
	end if
	if ids_1.object.qty10[i] <> 0 then
		ids_2.object.ddplnq10[l_n_row] = ( ids_1.object.mps002_bqtyd10[i] / ids_1.object.qty10[i]) * ids_2.object.dplnq10[l_n_row]
	end if
	if ids_1.object.qty11[i] <> 0 then
		ids_2.object.ddplnq11[l_n_row] = ( ids_1.object.mps002_bqtyd11[i] / ids_1.object.qty11[i]) * ids_2.object.dplnq11[l_n_row]
	end if
	if ids_1.object.qty12[i] <> 0 then
		ids_2.object.ddplnq12[l_n_row] = ( ids_1.object.mps002_bqtyd12[i] / ids_1.object.qty12[i]) * ids_2.object.dplnq12[l_n_row]
	end if
	
	// 수출용 생산계획량 계산
	ids_2.object.deplnq01[l_n_row] = ids_2.object.dplnq01[l_n_row] - ids_2.object.ddplnq01[l_n_row]
	ids_2.object.deplnq02[l_n_row] = ids_2.object.dplnq02[l_n_row] - ids_2.object.ddplnq02[l_n_row]
	ids_2.object.deplnq03[l_n_row] = ids_2.object.dplnq03[l_n_row] - ids_2.object.ddplnq03[l_n_row]
	ids_2.object.deplnq04[l_n_row] = ids_2.object.dplnq04[l_n_row] - ids_2.object.ddplnq04[l_n_row]
	ids_2.object.deplnq05[l_n_row] = ids_2.object.dplnq05[l_n_row] - ids_2.object.ddplnq05[l_n_row]
	ids_2.object.deplnq06[l_n_row] = ids_2.object.dplnq06[l_n_row] - ids_2.object.ddplnq06[l_n_row]
	
	ids_2.object.deplnq07[l_n_row] = ids_2.object.dplnq07[l_n_row] - ids_2.object.ddplnq07[l_n_row]
	ids_2.object.deplnq08[l_n_row] = ids_2.object.dplnq08[l_n_row] - ids_2.object.ddplnq08[l_n_row]
	ids_2.object.deplnq09[l_n_row] = ids_2.object.dplnq09[l_n_row] - ids_2.object.ddplnq09[l_n_row]
	ids_2.object.deplnq10[l_n_row] = ids_2.object.dplnq10[l_n_row] - ids_2.object.ddplnq10[l_n_row]
	ids_2.object.deplnq11[l_n_row] = ids_2.object.dplnq11[l_n_row] - ids_2.object.ddplnq11[l_n_row]
	ids_2.object.deplnq12[l_n_row] = ids_2.object.dplnq12[l_n_row] - ids_2.object.ddplnq12[l_n_row]
	
	ids_2.object.dfdplnq1[l_n_row]  = ids_2.object.ddplnq01[l_n_row] / 2
	ids_2.object.dsdplnq1[l_n_row]  = ids_2.object.ddplnq01[l_n_row] - ids_2.object.dfdplnq1[l_n_row]
	ids_2.object.dfeplnq1[l_n_row]  = ids_2.object.deplnq01[l_n_row] / 2
	ids_2.object.dseplnq1[l_n_row]  = ids_2.object.deplnq01[l_n_row] - ids_2.object.dfeplnq1[l_n_row]
	ids_2.object.dfdplnq2[l_n_row]  = ids_2.object.ddplnq02[l_n_row] / 2
	ids_2.object.dsdplnq2[l_n_row]  = ids_2.object.ddplnq02[l_n_row] - ids_2.object.dfdplnq2[l_n_row]
	ids_2.object.dfeplnq2[l_n_row]  = ids_2.object.deplnq02[l_n_row] / 2
	ids_2.object.dseplnq2[l_n_row]  = ids_2.object.deplnq02[l_n_row] - ids_2.object.dfeplnq2[l_n_row]
	
	select avgprc into :l_s_avgcst from pbsle.sle213
		where comltd = :g_s_company and cym  = :i_s_date and xplant = :i_s_xplant and
		      div    = :i_s_dvsn    and itno = :l_s_itno
	using sqlca ;
	if sqlca.sqlcode <> 0 then 
		l_s_avgcst = 0 
	end if
	ids_2.object.davcst[l_n_row]     = l_s_avgcst
	ids_2.object.dmacaddr[l_n_row]   = g_s_macaddr
	ids_2.object.dipaddr[l_n_row]    = g_s_ipaddr
	ids_2.object.dempno[l_n_row]     = g_s_empno
	ids_2.object.dupdt[l_n_row]      = g_s_date
	ids_2.object.dcrdt[l_n_row]      = g_s_date
next

if ids_2.update() = 1 then
	uo_status.st_message.text = f_message("U010")
	tab_1.tb_1.dw_2.retrieve(g_s_company,i_s_xplant,i_s_dvsn, trim(i_s_pdcd) + '%' , i_s_date )
	f_mps007_update(i_s_xplant,i_s_dvsn,i_s_date,'N')
end if
destroy ids_1
destroy ids_2

end event

type dw_2 from datawindow within tb_1
integer x = 18
integer y = 168
integer width = 4462
integer height = 1996
integer taborder = 30
string title = "none"
string dataobject = "d_mpsu02_01"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

event clicked;this.SelectRow(0, FALSE)
if row < 1 then
	return
end if
this.SelectRow(row, TRUE)
end event

event doubleclicked;dec{0} l_s_qty

if row < 1 then
	return
end if
setpointer(Hourglass!)
i_s_select = ''
i_n_clickedrow = row
tab_1.tb_2.dw_3.reset()
l_s_qty   = wf_firstdata(trim(this.object.mps004_ditno[row]))
tab_1.tb_2.sle_itno.text = trim(this.object.mps004_ditno[row])

									 
if tab_1.tb_2.dw_3.retrieve(g_s_company,i_s_xplant,i_s_dvsn,trim(this.object.mps004_ditno[row]),& 
									 i_s_date,l_s_qty) > 0 then
	tab_1.selecttab(2)
	uo_status.st_message.text = f_message("A070")	
	i_s_select = 'R'
end if


end event

type tb_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4521
integer height = 2240
long backcolor = 12632256
string text = "모델별 생산계획"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
st_dexpst st_dexpst
st_10 st_10
st_dsfst st_dsfst
st_8 st_8
st_dltsz st_dltsz
st_6 st_6
st_ohqty st_ohqty
st_9 st_9
st_itsrce st_itsrce
st_7 st_7
st_pdcd st_pdcd
st_4 st_4
pb_item pb_item
st_spec st_spec
sle_itno sle_itno
st_2 st_2
dw_3 dw_3
end type

on tb_2.create
this.st_dexpst=create st_dexpst
this.st_10=create st_10
this.st_dsfst=create st_dsfst
this.st_8=create st_8
this.st_dltsz=create st_dltsz
this.st_6=create st_6
this.st_ohqty=create st_ohqty
this.st_9=create st_9
this.st_itsrce=create st_itsrce
this.st_7=create st_7
this.st_pdcd=create st_pdcd
this.st_4=create st_4
this.pb_item=create pb_item
this.st_spec=create st_spec
this.sle_itno=create sle_itno
this.st_2=create st_2
this.dw_3=create dw_3
this.Control[]={this.st_dexpst,&
this.st_10,&
this.st_dsfst,&
this.st_8,&
this.st_dltsz,&
this.st_6,&
this.st_ohqty,&
this.st_9,&
this.st_itsrce,&
this.st_7,&
this.st_pdcd,&
this.st_4,&
this.pb_item,&
this.st_spec,&
this.sle_itno,&
this.st_2,&
this.dw_3}
end on

on tb_2.destroy
destroy(this.st_dexpst)
destroy(this.st_10)
destroy(this.st_dsfst)
destroy(this.st_8)
destroy(this.st_dltsz)
destroy(this.st_6)
destroy(this.st_ohqty)
destroy(this.st_9)
destroy(this.st_itsrce)
destroy(this.st_7)
destroy(this.st_pdcd)
destroy(this.st_4)
destroy(this.pb_item)
destroy(this.st_spec)
destroy(this.sle_itno)
destroy(this.st_2)
destroy(this.dw_3)
end on

type st_dexpst from statictext within tb_2
integer x = 2350
integer y = 312
integer width = 489
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_10 from statictext within tb_2
integer x = 1929
integer y = 324
integer width = 398
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "기말예상재고"
boolean focusrectangle = false
end type

type st_dsfst from statictext within tb_2
integer x = 1138
integer y = 312
integer width = 489
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within tb_2
integer x = 795
integer y = 324
integer width = 334
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "운영재고일"
boolean focusrectangle = false
end type

type st_dltsz from statictext within tb_2
integer x = 251
integer y = 312
integer width = 489
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within tb_2
integer x = 18
integer y = 324
integer width = 215
integer height = 76
integer textsize = -11
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "L / S"
boolean focusrectangle = false
end type

type st_ohqty from statictext within tb_2
integer x = 2350
integer y = 168
integer width = 489
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_9 from statictext within tb_2
integer x = 2117
integer y = 184
integer width = 219
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "현재고"
boolean focusrectangle = false
end type

type st_itsrce from statictext within tb_2
integer x = 1765
integer y = 168
integer width = 293
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_7 from statictext within tb_2
integer x = 1312
integer y = 184
integer width = 430
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "계정 / 구입선"
boolean focusrectangle = false
end type

type st_pdcd from statictext within tb_2
integer x = 251
integer y = 168
integer width = 1015
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within tb_2
integer x = 18
integer y = 184
integer width = 224
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "제품군"
boolean focusrectangle = false
end type

type pb_item from picturebutton within tb_2
integer x = 1829
integer y = 28
integer width = 238
integer height = 108
integer textsize = -11
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string picturename = "C:\kdac\bmp\search.gif"
alignment htextalign = left!
end type

event clicked;string l_s_parm
openwithparm(w_find_002 , i_s_xplant + i_s_dvsn)
l_s_parm = message.stringparm
if f_spacechk(l_s_parm) <> -1 then
	tab_1.tb_2.sle_itno.text = mid(l_s_parm,1,15)
	tab_1.tb_2.st_spec.text  = ''
end if
end event

type st_spec from statictext within tb_2
integer x = 795
integer y = 40
integer width = 1015
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type sle_itno from singlelineedit within tb_2
integer x = 251
integer y = 40
integer width = 489
integer height = 80
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 15793151
textcase textcase = upper!
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within tb_2
integer x = 18
integer y = 56
integer width = 224
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
long textcolor = 33554432
long backcolor = 12632256
string text = "품  번"
boolean focusrectangle = false
end type

type dw_3 from datawindow within tb_2
event ue_keydown pbm_keydown
event ue_keyin pbm_dwnkey
event ue_dwnkey pbm_dwnkey
integer x = 18
integer y = 428
integer width = 4462
integer height = 1756
integer taborder = 60
string title = "none"
string dataobject = "d_mpsu02_04"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_dwnkey;dec{3} l_s_qty
uo_status.st_message.text = ""
setpointer(hourglass!)
if KeyDown(KeyPagedown!) = true then
	if i_n_clickedrow > 1 and i_n_clickedrow < i_n_count then
		i_n_clickedrow -= 1
		tab_1.tb_2.sle_itno.text  = tab_1.tb_1.dw_2.object.mps004_ditno[i_n_clickedrow]
		l_s_qty   = wf_firstdata(trim(tab_1.tb_2.sle_itno.text))
		this.retrieve(g_s_company,i_s_xplant,i_s_dvsn,trim(tab_1.tb_2.sle_itno.text),& 
									 i_s_date,l_s_qty)	 
	elseif i_n_clickedrow = 1 then
		uo_status.st_message.text = "가장 처음 품번입니다 "							
	end if
elseif KeyDown(KeyPageup!) = true then
	if i_n_clickedrow > 0 and i_n_clickedrow < i_n_count then
		i_n_clickedrow += 1
		tab_1.tb_2.sle_itno.text  = tab_1.tb_1.dw_2.object.mps004_ditno[i_n_clickedrow]
		l_s_qty   = wf_firstdata(trim(tab_1.tb_2.sle_itno.text))
		this.retrieve(g_s_company,i_s_xplant,i_s_dvsn,trim(tab_1.tb_2.sle_itno.text),& 
									 i_s_date,l_s_qty)	 
	elseif i_n_clickedrow = i_n_count then
		uo_status.st_message.text = "가장 마지막 품번입니다 "							
	end if
	
end if

end event

event constructor;this.settransobject(Sqlca)

end event

event buttonclicked;//if dwo.name = "b_search" then
//	string l_s_parm
//	openwithparm(w_find_001 , ' I')
//	l_s_parm = message.stringparm
//	if f_spacechk(l_s_parm) <> -1 then
//		this.object.toline[1]  = mid(l_s_parm,1,4)
//	end if
//end if


end event

event itemchanged;window l_s_wsheet

if KeyDown(KeyEnter!) = true then
	l_s_wsheet = w_frame.GetActiveSheet()
	l_s_wsheet.TriggerEvent("ue_save")
end if
end event

event retrieveend;dec{0} l_d_bqty[]
string l_s_itno

if rowcount = 0 then return 0

l_s_itno = trim(tab_1.tb_2.sle_itno.text )

select bqtyd01,bqtye01,bqtyd02,bqtye02,bqtyd03,bqtye03,
       bqtyd04,bqtye04,bqtyd05,bqtye05,bqtyd06,bqtye06,
		 bqtyd07,bqtye07,bqtyd08,bqtye08,bqtyd09,bqtye09,
       bqtyd10,bqtye10,bqtyd11,bqtye11,bqtyd12,bqtye12
into :l_d_bqty[1],:l_d_bqty[2],:l_d_bqty[3],:l_d_bqty[4],:l_d_bqty[5],:l_d_bqty[6],
     :l_d_bqty[7],:l_d_bqty[8],:l_d_bqty[9],:l_d_bqty[10],:l_d_bqty[11],:l_d_bqty[12], 
	  :l_d_bqty[13],:l_d_bqty[14],:l_d_bqty[15],:l_d_bqty[16],:l_d_bqty[17],:l_d_bqty[18],
     :l_d_bqty[19],:l_d_bqty[20],:l_d_bqty[21],:l_d_bqty[22],:l_d_bqty[23],:l_d_bqty[24]
from pbmps.mps002
where bcmcd = :g_s_company and bplant = :i_s_xplant and 
		bdvsn = :i_s_dvsn and bitno = :l_s_itno and 
		byear || bmonth = :i_s_date
using sqlca ;
if sqlca.sqlcode <> 0 then
	tab_1.tb_2.dw_3.object.mps002_bqtyd01[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye01[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd02[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye02[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd03[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye03[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd04[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye04[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd05[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye05[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd06[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye06[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd07[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye07[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd08[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye08[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd09[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye09[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd10[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye10[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd11[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye11[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtyd12[1] = 0
	tab_1.tb_2.dw_3.object.mps002_bqtye12[1] = 0
else
	tab_1.tb_2.dw_3.object.mps002_bqtyd01[1] = l_d_bqty[1]
	tab_1.tb_2.dw_3.object.mps002_bqtye01[1] = l_d_bqty[2]
	tab_1.tb_2.dw_3.object.mps002_bqtyd02[1] = l_d_bqty[3]
	tab_1.tb_2.dw_3.object.mps002_bqtye02[1] = l_d_bqty[4]
	tab_1.tb_2.dw_3.object.mps002_bqtyd03[1] = l_d_bqty[5]
	tab_1.tb_2.dw_3.object.mps002_bqtye03[1] = l_d_bqty[6]
	tab_1.tb_2.dw_3.object.mps002_bqtyd04[1] = l_d_bqty[7]
	tab_1.tb_2.dw_3.object.mps002_bqtye04[1] = l_d_bqty[8]
	tab_1.tb_2.dw_3.object.mps002_bqtyd05[1] = l_d_bqty[9]
	tab_1.tb_2.dw_3.object.mps002_bqtye05[1] = l_d_bqty[10]
	tab_1.tb_2.dw_3.object.mps002_bqtyd06[1] = l_d_bqty[11]
	tab_1.tb_2.dw_3.object.mps002_bqtye06[1] = l_d_bqty[12]
	tab_1.tb_2.dw_3.object.mps002_bqtyd07[1] = l_d_bqty[13]
	tab_1.tb_2.dw_3.object.mps002_bqtye07[1] = l_d_bqty[14]
	tab_1.tb_2.dw_3.object.mps002_bqtyd08[1] = l_d_bqty[15]
	tab_1.tb_2.dw_3.object.mps002_bqtye08[1] = l_d_bqty[16]
	tab_1.tb_2.dw_3.object.mps002_bqtyd09[1] = l_d_bqty[17]
	tab_1.tb_2.dw_3.object.mps002_bqtye09[1] = l_d_bqty[18]
	tab_1.tb_2.dw_3.object.mps002_bqtyd10[1] = l_d_bqty[19]
	tab_1.tb_2.dw_3.object.mps002_bqtye10[1] = l_d_bqty[20]
	tab_1.tb_2.dw_3.object.mps002_bqtyd11[1] = l_d_bqty[21]
	tab_1.tb_2.dw_3.object.mps002_bqtye11[1] = l_d_bqty[22]
	tab_1.tb_2.dw_3.object.mps002_bqtyd12[1] = l_d_bqty[23]
	tab_1.tb_2.dw_3.object.mps002_bqtye12[1] = l_d_bqty[24]
end if
end event

type uo_1 from uo_plandiv_pdcd_rtn within w_mps_102u
integer x = 32
integer y = 8
integer height = 120
integer taborder = 30
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_pdcd_rtn::destroy
end on

