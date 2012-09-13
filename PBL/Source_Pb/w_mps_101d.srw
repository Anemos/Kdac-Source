$PBExportHeader$w_mps_101d.srw
$PBExportComments$판매계획집계 Download
forward
global type w_mps_101d from w_origin_sheet02
end type
type cb_1 from commandbutton within w_mps_101d
end type
type uo_3 from uo_ccyymm_mps within w_mps_101d
end type
type ids_data1 from datawindow within w_mps_101d
end type
type ids_data2 from datawindow within w_mps_101d
end type
type ids_data3 from datawindow within w_mps_101d
end type
type ids_data4 from datawindow within w_mps_101d
end type
type ids_data5 from datawindow within w_mps_101d
end type
type st_1 from statictext within w_mps_101d
end type
type uo_2 from uo_plandiv_pdcd_rtn within w_mps_101d
end type
type dw_retrieve from datawindow within w_mps_101d
end type
type pb_excel from picturebutton within w_mps_101d
end type
end forward

global type w_mps_101d from w_origin_sheet02
cb_1 cb_1
uo_3 uo_3
ids_data1 ids_data1
ids_data2 ids_data2
ids_data3 ids_data3
ids_data4 ids_data4
ids_data5 ids_data5
st_1 st_1
uo_2 uo_2
dw_retrieve dw_retrieve
pb_excel pb_excel
end type
global w_mps_101d w_mps_101d

type variables
dec{0} crqty[12]
dec{2} cramt[12],amttbld1s[6],amttbld2s[6],amttble1s[6],amttble2s[6]
string kitflg,kitlop,kitmodf,i_s_citno,i_s_itno,i_s_xplant,i_s_dvsn,i_s_chkdvsn,i_s_chkxplant
string i_s_rxplant,i_s_rdvsn,i_s_rpdcd,i_s_rdate
long   i_s_workday
string i_s_sle105_date
end variables

forward prototypes
public subroutine wf_return ()
public function decimal wf_sle214 (string a_year, string a_curr)
public subroutine wf_kitmod (datawindow ds_1, long ds_row)
public subroutine wf_savset (datawindow ds_1, long ds_row)
public subroutine wf_rtnset (datawindow ds_1, long ds_row)
public subroutine wf_summary (datawindow ds_1, long ds_row)
public subroutine wf_kit01 (datawindow ds_1, long ds_row1, datawindow ds_2, long ds_row2)
public subroutine wf_movebf (datawindow ds_1, long ds_row)
public subroutine wf_move05 (datawindow ds_1, long ds_row)
public subroutine wf_mps02x (datawindow ds_1, long ds_row, datawindow ds_2, long ds_row2)
end prototypes

public subroutine wf_return ();string l_s_parm

l_s_parm     = uo_2.uf_return()
i_s_rxplant  = mid(l_s_parm,1,1)
i_s_rdvsn    = mid(l_s_parm,2,1)
i_s_rpdcd    = mid(l_s_parm,3,4)
i_s_rdate    = uo_3.uf_yyyymm()
end subroutine

public function decimal wf_sle214 (string a_year, string a_curr);dec{2} l_s_exc

select exc into :l_s_exc from pbsle.sle214
	where cym = :a_year and cur = :a_curr using sqlca;

if sqlca.sqlcode <> 0 then
	l_s_exc = 0
end if

return l_s_exc
end function

public subroutine wf_kitmod (datawindow ds_1, long ds_row);dec{2} amttbldst,amttblest

if ds_1.object.suse[ds_row] = 'D' then
	amttbldst = amttbld1s[1] + amttbld1s[2] + amttbld1s[3] + amttbld1s[4] + amttbld1s[5] + amttbld1s[6] + &
	            amttbld2s[1] + amttbld2s[2] + amttbld2s[3] + amttbld2s[4] + amttbld2s[5] + amttbld2s[6]
	if ( ds_1.object.ramt1[ds_row] + ds_1.object.ramt2[ds_row] + ds_1.object.ramt3[ds_row] + ds_1.object.ramt4[ds_row] + &		
		 ds_1.object.ramt5[ds_row] + ds_1.object.ramt6[ds_row] + ds_1.object.ramt7[ds_row] + ds_1.object.ramt8[ds_row] + &		
		 ds_1.object.ramt9[ds_row] + ds_1.object.ramt10[ds_row] + ds_1.object.ramt11[ds_row] + ds_1.object.ramt12[ds_row] ) <> amttbldst then
		kitmodf = '1'		 
		ds_1.object.ramt1[ds_row]  = ds_1.object.ramt1[ds_row]  - amttbld1s[1]
		ds_1.object.ramt2[ds_row]  = ds_1.object.ramt2[ds_row]  - amttbld1s[2]
		ds_1.object.ramt3[ds_row]  = ds_1.object.ramt3[ds_row]  - amttbld1s[3]
		ds_1.object.ramt4[ds_row]  = ds_1.object.ramt4[ds_row]  - amttbld1s[4]
		ds_1.object.ramt5[ds_row]  = ds_1.object.ramt5[ds_row]  - amttbld1s[5]
		ds_1.object.ramt6[ds_row]  = ds_1.object.ramt6[ds_row]  - amttbld1s[6]
		ds_1.object.ramt7[ds_row]  = ds_1.object.ramt7[ds_row]  - amttbld2s[1]
		ds_1.object.ramt8[ds_row]  = ds_1.object.ramt8[ds_row]  - amttbld2s[2]
		ds_1.object.ramt9[ds_row]  = ds_1.object.ramt9[ds_row]  - amttbld2s[3]
		ds_1.object.ramt10[ds_row] = ds_1.object.ramt10[ds_row] - amttbld2s[4]
		ds_1.object.ramt11[ds_row] = ds_1.object.ramt11[ds_row] - amttbld2s[5]
		ds_1.object.ramt12[ds_row] = ds_1.object.ramt12[ds_row] - amttbld2s[6]
	end if
else
	amttblest = amttble1s[1] + amttble1s[2] + amttble1s[3] + amttble1s[4] + amttble1s[5] + amttble1s[6] + &
	            amttble2s[1] + amttble2s[2] + amttble2s[3] + amttble2s[4] + amttble2s[5] + amttble2s[6]
	if ( ds_1.object.ramt1[ds_row] * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur1[ds_row])  + & 
	    ds_1.object.ramt2[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur2[ds_row])  + &
		 ds_1.object.ramt3[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur3[ds_row])  + &
		 ds_1.object.ramt4[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur4[ds_row])  + &		
		 ds_1.object.ramt5[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur5[ds_row])  + &
		 ds_1.object.ramt6[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur6[ds_row])  + & 
		 ds_1.object.ramt7[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur7[ds_row])  + &
		 ds_1.object.ramt8[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur8[ds_row])  + &		
		 ds_1.object.ramt9[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur9[ds_row])  + &
		 ds_1.object.ramt10[ds_row] * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur10[ds_row]) + & 
		 ds_1.object.ramt11[ds_row] * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur11[ds_row]) + &
		 ds_1.object.ramt12[ds_row] * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur12[ds_row]) ) <> amttblest then
		kitmodf = '1'		 
		ds_1.object.ramt1[ds_row]  = ds_1.object.ramt1[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur1[ds_row])  - amttble1s[1]
		ds_1.object.ramt2[ds_row]  = ds_1.object.ramt2[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur2[ds_row]) - amttble1s[2]
		ds_1.object.ramt3[ds_row]  = ds_1.object.ramt3[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur3[ds_row])  - amttble1s[3]
		ds_1.object.ramt4[ds_row]  = ds_1.object.ramt4[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur4[ds_row])  - amttble1s[4]
		ds_1.object.ramt5[ds_row]  = ds_1.object.ramt5[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur5[ds_row])   - amttble1s[5]
		ds_1.object.ramt6[ds_row]  = ds_1.object.ramt6[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur6[ds_row])  - amttble1s[6]
		ds_1.object.ramt7[ds_row]  = ds_1.object.ramt7[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur7[ds_row])  - amttble2s[1]
		ds_1.object.ramt8[ds_row]  = ds_1.object.ramt8[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur8[ds_row])  - amttble2s[2]
		ds_1.object.ramt9[ds_row]  = ds_1.object.ramt9[ds_row]  * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur9[ds_row])  - amttble2s[3]
		ds_1.object.ramt10[ds_row] = ds_1.object.ramt10[ds_row] * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur10[ds_row]) - amttble2s[4]
		ds_1.object.ramt11[ds_row] = ds_1.object.ramt11[ds_row] * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur11[ds_row]) - amttble2s[5]
		ds_1.object.ramt12[ds_row] = ds_1.object.ramt12[ds_row] * wf_sle214(ds_1.object.cym[ds_row],ds_1.object.rcur12[ds_row]) - amttble2s[6]
	end if
end if
if kitmodf = '1' then
	wf_movebf(ds_1,ds_row)
	wf_move05(ds_1,ds_row)
end if
kitmodf = ''
amttbldst  = 0
amttblest  = 0		
amttbld1s[] = {0,0,0,0,0,0}
amttbld2s[] = {0,0,0,0,0,0}
amttble1s[] = {0,0,0,0,0,0}
amttble2s[] = {0,0,0,0,0,0}


			
end subroutine

public subroutine wf_savset (datawindow ds_1, long ds_row);
crqty[1]  = ds_1.object.rqty1[ds_row]
crqty[2]  = ds_1.object.rqty2[ds_row]
crqty[3]  = ds_1.object.rqty3[ds_row]
crqty[4]  = ds_1.object.rqty4[ds_row]
crqty[5]  = ds_1.object.rqty5[ds_row]
crqty[6]  = ds_1.object.rqty6[ds_row]
crqty[7]  = ds_1.object.rqty7[ds_row]
crqty[8]  = ds_1.object.rqty8[ds_row]
crqty[9]  = ds_1.object.rqty9[ds_row]
crqty[10] = ds_1.object.rqty10[ds_row]
crqty[11] = ds_1.object.rqty11[ds_row]
crqty[12] = ds_1.object.rqty12[ds_row]

cramt[1]  = ds_1.object.ramt1[ds_row]
cramt[2]  = ds_1.object.ramt2[ds_row]
cramt[3]  = ds_1.object.ramt3[ds_row]
cramt[4]  = ds_1.object.ramt4[ds_row]
cramt[5]  = ds_1.object.ramt5[ds_row]
cramt[6]  = ds_1.object.ramt6[ds_row]
cramt[7]  = ds_1.object.ramt7[ds_row]
cramt[8]  = ds_1.object.ramt8[ds_row]
cramt[9]  = ds_1.object.ramt9[ds_row]
cramt[10] = ds_1.object.ramt10[ds_row]
cramt[11] = ds_1.object.ramt11[ds_row]
cramt[12] = ds_1.object.ramt12[ds_row]
end subroutine

public subroutine wf_rtnset (datawindow ds_1, long ds_row);ds_1.object.rqty1[ds_row]  = crqty[1]
ds_1.object.rqty2[ds_row]  = crqty[2]
ds_1.object.rqty3[ds_row]  = crqty[3]
ds_1.object.rqty4[ds_row]  = crqty[4]
ds_1.object.rqty5[ds_row]  = crqty[5]
ds_1.object.rqty6[ds_row]  = crqty[6]
ds_1.object.rqty7[ds_row]  = crqty[7]
ds_1.object.rqty8[ds_row]  = crqty[8]
ds_1.object.rqty9[ds_row]  = crqty[9]
ds_1.object.rqty10[ds_row] = crqty[10]
ds_1.object.rqty11[ds_row] = crqty[11]
ds_1.object.rqty12[ds_row] = crqty[12]

ds_1.object.ramt1[ds_row]  = cramt[1]
ds_1.object.ramt2[ds_row]  = cramt[2]
ds_1.object.ramt3[ds_row]  = cramt[3]
ds_1.object.ramt4[ds_row]  = cramt[4]
ds_1.object.ramt5[ds_row]  = cramt[5]
ds_1.object.ramt6[ds_row]  = cramt[6]
ds_1.object.ramt7[ds_row]  = cramt[7]
ds_1.object.ramt8[ds_row]  = cramt[8]
ds_1.object.ramt9[ds_row]  = cramt[9]
ds_1.object.ramt10[ds_row] = cramt[10]
ds_1.object.ramt11[ds_row] = cramt[11]
ds_1.object.ramt12[ds_row] = cramt[12]
end subroutine

public subroutine wf_summary (datawindow ds_1, long ds_row);string l_s_yearmonth,l_s_curr
dec{2} l_s_exc
if ds_1.object.suse[ds_row] = 'E' and f_spacechk(ds_1.object.rcur0[ds_row]) <> -1 then
	   l_s_yearmonth = ds_1.object.cym[ds_row]
  //	if sqlca.sqlcode = 0 then
		ds_1.object.ramt1[ds_row]  = ds_1.object.ramt1[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur1[ds_row])
		ds_1.object.ramt2[ds_row]  = ds_1.object.ramt2[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur2[ds_row])
		ds_1.object.ramt3[ds_row]  = ds_1.object.ramt3[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur3[ds_row])
		ds_1.object.ramt4[ds_row]  = ds_1.object.ramt4[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur4[ds_row])
		ds_1.object.ramt5[ds_row]  = ds_1.object.ramt5[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur5[ds_row])
		ds_1.object.ramt6[ds_row]  = ds_1.object.ramt6[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur6[ds_row])
		ds_1.object.ramt7[ds_row]  = ds_1.object.ramt7[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur7[ds_row])
		ds_1.object.ramt8[ds_row]  = ds_1.object.ramt8[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur8[ds_row])
		ds_1.object.ramt9[ds_row]  = ds_1.object.ramt9[ds_row]  * wf_sle214(l_s_yearmonth,ds_1.object.rcur9[ds_row])
		ds_1.object.ramt10[ds_row] = ds_1.object.ramt10[ds_row] * wf_sle214(l_s_yearmonth,ds_1.object.rcur10[ds_row])
		ds_1.object.ramt11[ds_row] = ds_1.object.ramt11[ds_row] * wf_sle214(l_s_yearmonth,ds_1.object.rcur11[ds_row])
		ds_1.object.ramt12[ds_row] = ds_1.object.ramt12[ds_row] * wf_sle214(l_s_yearmonth,ds_1.object.rcur12[ds_row])
	// end if
end if
if kitlop = '1' then
	if ds_1.object.suse[ds_row] = 'D' then
		amttbld1s[1] += ds_1.object.ramt1[ds_row] 
		amttbld1s[2] += ds_1.object.ramt2[ds_row]
		amttbld1s[3] += ds_1.object.ramt3[ds_row]
		amttbld1s[4] += ds_1.object.ramt4[ds_row]
		amttbld1s[5] += ds_1.object.ramt5[ds_row]
		amttbld1s[6] += ds_1.object.ramt6[ds_row]
      amttbld2s[1] += ds_1.object.ramt7[ds_row]
		amttbld2s[2] += ds_1.object.ramt8[ds_row]
		amttbld2s[3] += ds_1.object.ramt9[ds_row]
		amttbld2s[4] += ds_1.object.ramt10[ds_row]
		amttbld2s[5] += ds_1.object.ramt11[ds_row]
		amttbld2s[6] += ds_1.object.ramt12[ds_row]
	else
		amttble1s[1] += ds_1.object.ramt1[ds_row] 
		amttble1s[2] += ds_1.object.ramt2[ds_row]
		amttble1s[3] += ds_1.object.ramt3[ds_row]
		amttble1s[4] += ds_1.object.ramt4[ds_row]
		amttble1s[5] += ds_1.object.ramt5[ds_row]
		amttble1s[6] += ds_1.object.ramt6[ds_row]
      amttble2s[1] += ds_1.object.ramt7[ds_row]
		amttble2s[2] += ds_1.object.ramt8[ds_row]
		amttble2s[3] += ds_1.object.ramt9[ds_row]
		amttble2s[4] += ds_1.object.ramt10[ds_row]
		amttble2s[5] += ds_1.object.ramt11[ds_row]
		amttble2s[6] += ds_1.object.ramt12[ds_row]
	end if
end if
		
end subroutine

public subroutine wf_kit01 (datawindow ds_1, long ds_row1, datawindow ds_2, long ds_row2);// KIT품에 대한 수량, 금액 계산
// 수량 = 판매수량 * 소요수량, 금액 = 판매단가 * ( 판매수량 * 단가율 / 100 )
ds_1.object.rqty1[ds_row1]  = ds_1.object.rqty1[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty2[ds_row1]  = ds_1.object.rqty2[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty3[ds_row1]  = ds_1.object.rqty3[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty4[ds_row1]  = ds_1.object.rqty4[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty5[ds_row1]  = ds_1.object.rqty5[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty6[ds_row1]  = ds_1.object.rqty6[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty7[ds_row1]  = ds_1.object.rqty7[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty8[ds_row1]  = ds_1.object.rqty8[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty9[ds_row1]  = ds_1.object.rqty9[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty10[ds_row1] = ds_1.object.rqty10[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty11[ds_row1] = ds_1.object.rqty11[ds_row1] * ds_2.object.prqty[ds_row2]  
ds_1.object.rqty12[ds_row1] = ds_1.object.rqty12[ds_row1] * ds_2.object.prqty[ds_row2]  

ds_1.object.ramt1[ds_row1]   = ds_1.object.rupc1[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty1[ds_row1]  
ds_1.object.ramt2[ds_row1]   = ds_1.object.rupc2[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty2[ds_row1] 
ds_1.object.ramt3[ds_row1]   = ds_1.object.rupc3[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty3[ds_row1]  
ds_1.object.ramt4[ds_row1]   = ds_1.object.rupc4[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty4[ds_row1]  
ds_1.object.ramt5[ds_row1]   = ds_1.object.rupc5[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty5[ds_row1]  
ds_1.object.ramt6[ds_row1]   = ds_1.object.rupc6[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty6[ds_row1]  
ds_1.object.ramt7[ds_row1]   = ds_1.object.rupc7[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty7[ds_row1]  
ds_1.object.ramt8[ds_row1]   = ds_1.object.rupc8[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty8[ds_row1]  
ds_1.object.ramt9[ds_row1]   = ds_1.object.rupc9[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty9[ds_row1]  
ds_1.object.ramt10[ds_row1]  = ds_1.object.rupc10[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty10[ds_row1]  
ds_1.object.ramt11[ds_row1]  = ds_1.object.rupc11[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty11[ds_row1]  
ds_1.object.ramt12[ds_row1]  = ds_1.object.rupc12[ds_row1] * ds_2.object.ratio[ds_row2] / 100 * ds_1.object.rqty12[ds_row1]  

wf_summary(ds_1,ds_row1)
wf_movebf(ds_1,ds_row1)
wf_move05(ds_1,ds_row1)

end subroutine

public subroutine wf_movebf (datawindow ds_1, long ds_row);string l_s_year,l_s_month,l_s_type,l_s_xplant,l_s_dvsn,l_s_itno
long   l_s_count,l_s_find


l_s_year  = mid(ds_1.object.cym[ds_row],1,4)
l_s_month = mid(ds_1.object.cym[ds_row],5,2)

if ds_1.object.kitcd[ds_row] <> 'K' then
	l_s_xplant = ds_1.object.xplant[ds_row]
	l_s_dvsn   = ds_1.object.div[ds_row]  
	l_s_itno   = ds_1.object.itno[ds_row]
else
	l_s_xplant = i_s_xplant
	l_s_dvsn   = i_s_dvsn
	l_s_itno   = i_s_itno
end if
if ds_1.object.accd[ds_row] = '30' then
	l_s_type = ' '
elseif ds_1.object.srcd[ds_row] = '03' then
	l_s_type = 'A'
else
	l_s_type = 'B'
end if

select count(*) into :l_s_count from pbmps.mps002
	where bcmcd = :g_s_company and byear = :l_s_year and bmonth = :l_s_month and bplant = :l_s_xplant and
	      bdvsn = :l_s_dvsn    and bitno  = :l_s_itno using sqlca;

if l_s_count > 0 then
	if ds_1.object.kitcd[ds_row] ='K' then
		kitflg = '1'
	end if
end if

l_s_find = ids_data3.find(" bcmcd = '" + g_s_company + "'" + " and byear = '" + l_s_year + "'" & 
                        + " and bmonth = '" + l_s_month + "'" + " and bplant = '" + l_s_xplant + "'" &
						+ " and bdvsn  = '" + l_s_dvsn  + "'" + " and bitno  = '" + l_s_itno  + "'" ,1,ids_data3.rowcount()) 
if l_s_find = 0 then
	l_s_count = ids_Data3.insertrow(0)
	ids_data3.object.bcrdt[l_s_count]  = g_s_date
else
	l_s_count = l_s_find
end if

ids_data3.object.bcmcd[l_s_count]  = g_s_company
ids_data3.object.byear[l_s_count]  = l_s_year
ids_data3.object.bmonth[l_s_count] = l_s_month
ids_data3.object.bplant[l_s_count] = l_s_xplant
ids_data3.object.bdvsn[l_s_count]  = l_s_dvsn
ids_data3.object.bitno[l_s_count]  = l_s_itno
ids_data3.object.btype[l_s_count]  = l_s_type


if kitlop = '1' then
	ids_data3.object.bkitno[l_s_count] = i_s_citno
end if

if ds_1.object.suse[ds_row] = 'D' then
	if kitmodf <> '1' then
	   ids_data3.object.bqtyd01[l_s_count] = ids_data3.object.bqtyd01[l_s_count] + ds_1.object.rqty1[ds_row]  
	   ids_data3.object.bqtyd02[l_s_count] = ids_data3.object.bqtyd02[l_s_count] + ds_1.object.rqty2[ds_row]
	   ids_data3.object.bqtyd03[l_s_count] = ids_data3.object.bqtyd03[l_s_count] + ds_1.object.rqty3[ds_row]
	   ids_data3.object.bqtyd04[l_s_count] = ids_data3.object.bqtyd04[l_s_count] + ds_1.object.rqty4[ds_row]
	   ids_data3.object.bqtyd05[l_s_count] = ids_data3.object.bqtyd05[l_s_count] + ds_1.object.rqty5[ds_row]
	   ids_data3.object.bqtyd06[l_s_count] = ids_data3.object.bqtyd06[l_s_count] + ds_1.object.rqty6[ds_row]
	   ids_data3.object.bqtyd07[l_s_count] = ids_data3.object.bqtyd07[l_s_count] + ds_1.object.rqty7[ds_row]
	   ids_data3.object.bqtyd08[l_s_count] = ids_data3.object.bqtyd08[l_s_count] + ds_1.object.rqty8[ds_row]
	   ids_data3.object.bqtyd09[l_s_count] = ids_data3.object.bqtyd09[l_s_count] + ds_1.object.rqty9[ds_row]
	   ids_data3.object.bqtyd10[l_s_count] = ids_data3.object.bqtyd10[l_s_count] + ds_1.object.rqty10[ds_row]
	   ids_data3.object.bqtyd11[l_s_count] = ids_data3.object.bqtyd11[l_s_count] + ds_1.object.rqty11[ds_row]
	   ids_data3.object.bqtyd12[l_s_count] = ids_data3.object.bqtyd12[l_s_count] + ds_1.object.rqty12[ds_row]
	   ids_data3.object.bqtydh[l_s_count]  = ids_data3.object.bqtydh[l_s_count]  + ds_1.object.rqty1[ds_row]  + ds_1.object.rqty2[ds_row] + &
	                                 ds_1.object.rqty3[ds_row]   + ds_1.object.rqty4[ds_row]  + ds_1.object.rqty5[ds_row] + &
									 ds_1.object.rqty6[ds_row]
       ids_data3.object.bqtydt[l_s_count]  = ids_data3.object.bqtydt[l_s_count]  + ds_1.object.rqty1[ds_row]  + ds_1.object.rqty2[ds_row] + &
	                                 ds_1.object.rqty3[ds_row]   + ds_1.object.rqty4[ds_row]  + ds_1.object.rqty5[ds_row] + &
									 ds_1.object.rqty6[ds_row]   + ds_1.object.rqty7[ds_row]  + ds_1.object.rqty8[ds_row] + &
	                                 ds_1.object.rqty9[ds_row]   + ds_1.object.rqty10[ds_row] + ds_1.object.rqty11[ds_row] + &
									 ds_1.object.rqty12[ds_row]		
    end if
	 ids_data3.object.bamtd01[l_s_count] = ids_data3.object.bamtd01[l_s_count]  + ds_1.object.ramt1[ds_row]  
    ids_data3.object.bamtd02[l_s_count] = ids_data3.object.bamtd02[l_s_count]  + ds_1.object.ramt2[ds_row]
    ids_data3.object.bamtd03[l_s_count] = ids_data3.object.bamtd03[l_s_count]  + ds_1.object.ramt3[ds_row]
    ids_data3.object.bamtd04[l_s_count] = ids_data3.object.bamtd04[l_s_count]  + ds_1.object.ramt4[ds_row]
    ids_data3.object.bamtd05[l_s_count] = ids_data3.object.bamtd05[l_s_count]  + ds_1.object.ramt5[ds_row]
    ids_data3.object.bamtd06[l_s_count] = ids_data3.object.bamtd06[l_s_count]  + ds_1.object.ramt6[ds_row]
    ids_data3.object.bamtd07[l_s_count] = ids_data3.object.bamtd07[l_s_count]  + ds_1.object.ramt7[ds_row]
    ids_data3.object.bamtd08[l_s_count] = ids_data3.object.bamtd08[l_s_count]  + ds_1.object.ramt8[ds_row]
    ids_data3.object.bamtd09[l_s_count] = ids_data3.object.bamtd09[l_s_count]  + ds_1.object.ramt9[ds_row]
    ids_data3.object.bamtd10[l_s_count] = ids_data3.object.bamtd10[l_s_count]  + ds_1.object.ramt10[ds_row]
    ids_data3.object.bamtd11[l_s_count] = ids_data3.object.bamtd11[l_s_count]  + ds_1.object.ramt11[ds_row]
    ids_data3.object.bamtd12[l_s_count] = ids_data3.object.bamtd12[l_s_count]  + ds_1.object.ramt12[ds_row]
    ids_data3.object.bamtdh[l_s_count]  = ids_data3.object.bamtdh[l_s_count]   + ds_1.object.ramt1[ds_row]  + ds_1.object.ramt2[ds_row] + &
	    						  ds_1.object.ramt3[ds_row]   + ds_1.object.ramt4[ds_row]  + ds_1.object.ramt5[ds_row] + &
								  ds_1.object.ramt6[ds_row]
    ids_data3.object.bamtdt[l_s_count]  = ids_data3.object.bamtdt[l_s_count]  + ds_1.object.ramt1[ds_row]  + ds_1.object.ramt2[ds_row] + &
								  ds_1.object.ramt3[ds_row]   + ds_1.object.ramt4[ds_row]  + ds_1.object.ramt5[ds_row] + &
								  ds_1.object.ramt6[ds_row]   + ds_1.object.ramt7[ds_row]  + ds_1.object.ramt8[ds_row] + &
								  ds_1.object.ramt9[ds_row]   + ds_1.object.ramt10[ds_row] + ds_1.object.ramt11[ds_row] + &
								  ds_1.object.ramt12[ds_row]		
   if ids_data3.object.bqtyd01[l_s_count] <> 0 then
		ids_data3.object.bcstd01[l_s_count] = ids_data3.object.bamtd01[l_s_count] / ids_data3.object.bqtyd01[l_s_count]
	end if
	if ids_data3.object.bqtyd02[l_s_count] <> 0 then
		ids_data3.object.bcstd02[l_s_count] = ids_data3.object.bamtd02[l_s_count] / ids_data3.object.bqtyd02[l_s_count]
	end if
	if ids_data3.object.bqtyd03[l_s_count] <> 0 then
		ids_data3.object.bcstd03[l_s_count] = ids_data3.object.bamtd03[l_s_count] / ids_data3.object.bqtyd03[l_s_count]
	end if
	if ids_data3.object.bqtyd04[l_s_count] <> 0 then
		ids_data3.object.bcstd04[l_s_count] = ids_data3.object.bamtd04[l_s_count] / ids_data3.object.bqtyd04[l_s_count]
	end if
	if ids_data3.object.bqtyd05[l_s_count] <> 0 then
		ids_data3.object.bcstd05[l_s_count] = ids_data3.object.bamtd05[l_s_count] / ids_data3.object.bqtyd05[l_s_count]
	end if
	if ids_data3.object.bqtyd06[l_s_count] <> 0 then
		ids_data3.object.bcstd06[l_s_count] = ids_data3.object.bamtd06[l_s_count] / ids_data3.object.bqtyd06[l_s_count]
	end if
	if ids_data3.object.bqtyd07[l_s_count] <> 0 then
		ids_data3.object.bcstd07[l_s_count] = ids_data3.object.bamtd07[l_s_count] / ids_data3.object.bqtyd07[l_s_count]
	end if
	if ids_data3.object.bqtyd08[l_s_count] <> 0 then
		ids_data3.object.bcstd08[l_s_count] = ids_data3.object.bamtd08[l_s_count] / ids_data3.object.bqtyd08[l_s_count]
	end if
	if ids_data3.object.bqtyd09[l_s_count] <> 0 then
		ids_data3.object.bcstd09[l_s_count] = ids_data3.object.bamtd09[l_s_count] / ids_data3.object.bqtyd09[l_s_count]
	end if
	if ids_data3.object.bqtyd10[l_s_count] <> 0 then
		ids_data3.object.bcstd10[l_s_count] = ids_data3.object.bamtd10[l_s_count] / ids_data3.object.bqtyd10[l_s_count]
	end if
	if ids_data3.object.bqtyd11[l_s_count] <> 0 then
		ids_data3.object.bcstd11[l_s_count] = ids_data3.object.bamtd11[l_s_count] / ids_data3.object.bqtyd11[l_s_count]
	end if
	if ids_data3.object.bqtyd12[l_s_count] <> 0 then
		ids_data3.object.bcstd12[l_s_count] = ids_data3.object.bamtd12[l_s_count] / ids_data3.object.bqtyd12[l_s_count]
	end if
	if ids_data3.object.bqtydh[l_s_count] <> 0 then
		ids_data3.object.bcstdh[l_s_count] = ids_data3.object.bamtdh[l_s_count] / ids_data3.object.bqtydh[l_s_count]
	end if
	if ids_data3.object.bqtydt[l_s_count] <> 0 then
		ids_data3.object.bcstdt[l_s_count] = ids_data3.object.bamtdt[l_s_count] / ids_data3.object.bqtydt[l_s_count]
	end if
else
	if kitmodf <> '1' then
	   ids_data3.object.bqtye01[l_s_count] = ids_data3.object.bqtye01[l_s_count] + ds_1.object.rqty1[ds_row]  
	   ids_data3.object.bqtye02[l_s_count] = ids_data3.object.bqtye02[l_s_count] + ds_1.object.rqty2[ds_row]
	   ids_data3.object.bqtye03[l_s_count] = ids_data3.object.bqtye03[l_s_count] + ds_1.object.rqty3[ds_row]
	   ids_data3.object.bqtye04[l_s_count] = ids_data3.object.bqtye04[l_s_count] + ds_1.object.rqty4[ds_row]
	   ids_data3.object.bqtye05[l_s_count] = ids_data3.object.bqtye05[l_s_count] + ds_1.object.rqty5[ds_row]
	   ids_data3.object.bqtye06[l_s_count] = ids_data3.object.bqtye06[l_s_count] + ds_1.object.rqty6[ds_row]
	   ids_data3.object.bqtye07[l_s_count] = ids_data3.object.bqtye07[l_s_count] + ds_1.object.rqty7[ds_row]
	   ids_data3.object.bqtye08[l_s_count] = ids_data3.object.bqtye08[l_s_count] + ds_1.object.rqty8[ds_row]
	   ids_data3.object.bqtye09[l_s_count] = ids_data3.object.bqtye09[l_s_count] + ds_1.object.rqty9[ds_row]
	   ids_data3.object.bqtye10[l_s_count] = ids_data3.object.bqtye10[l_s_count] + ds_1.object.rqty10[ds_row]
	   ids_data3.object.bqtye11[l_s_count] = ids_data3.object.bqtye11[l_s_count] + ds_1.object.rqty11[ds_row]
	   ids_data3.object.bqtye12[l_s_count] = ids_data3.object.bqtye12[l_s_count] + ds_1.object.rqty12[ds_row]
	   ids_data3.object.bqtyeh[l_s_count]  = ids_data3.object.bqtyeh[l_s_count]  + ds_1.object.rqty1[ds_row]  + ds_1.object.rqty2[ds_row] + &
	                                 ds_1.object.rqty3[ds_row]   + ds_1.object.rqty4[ds_row]  + ds_1.object.rqty5[ds_row] + &
									 ds_1.object.rqty6[ds_row]
       ids_data3.object.bqtyet[l_s_count]  = ids_data3.object.bqtyet[l_s_count]  + ds_1.object.rqty1[ds_row]  + ds_1.object.rqty2[ds_row] + &
	                                 ds_1.object.rqty3[ds_row]   + ds_1.object.rqty4[ds_row]  + ds_1.object.rqty5[ds_row] + &
									 ds_1.object.rqty6[ds_row]   + ds_1.object.rqty7[ds_row]  + ds_1.object.rqty8[ds_row] + &
	                                 ds_1.object.rqty9[ds_row]   + ds_1.object.rqty10[ds_row] + ds_1.object.rqty11[ds_row] + &
									 ds_1.object.rqty12[ds_row]		
    end if
	 ids_data3.object.bamte01[l_s_count] = ids_data3.object.bamte01[l_s_count] + ds_1.object.ramt1[ds_row]  
    ids_data3.object.bamte02[l_s_count] = ids_data3.object.bamte02[l_s_count] + ds_1.object.ramt2[ds_row]
    ids_data3.object.bamte03[l_s_count] = ids_data3.object.bamte03[l_s_count] + ds_1.object.ramt3[ds_row]
    ids_data3.object.bamte04[l_s_count] = ids_data3.object.bamte04[l_s_count] + ds_1.object.ramt4[ds_row]
    ids_data3.object.bamte05[l_s_count] = ids_data3.object.bamte05[l_s_count] + ds_1.object.ramt5[ds_row]
    ids_data3.object.bamte06[l_s_count] = ids_data3.object.bamte06[l_s_count] + ds_1.object.ramt6[ds_row]
    ids_data3.object.bamte07[l_s_count] = ids_data3.object.bamte07[l_s_count] + ds_1.object.ramt7[ds_row]
    ids_data3.object.bamte08[l_s_count] = ids_data3.object.bamte08[l_s_count] + ds_1.object.ramt8[ds_row]
    ids_data3.object.bamte09[l_s_count] = ids_data3.object.bamte09[l_s_count] + ds_1.object.ramt9[ds_row]
    ids_data3.object.bamte10[l_s_count] = ids_data3.object.bamte10[l_s_count] + ds_1.object.ramt10[ds_row]
    ids_data3.object.bamte11[l_s_count] = ids_data3.object.bamte11[l_s_count] + ds_1.object.ramt11[ds_row]
    ids_data3.object.bamte12[l_s_count] = ids_data3.object.bamte12[l_s_count] + ds_1.object.ramt12[ds_row]
    ids_data3.object.bamteh[l_s_count]  = ids_data3.object.bamteh[l_s_count]  + ds_1.object.ramt1[ds_row]  + ds_1.object.ramt2[ds_row] + &
	    						  ds_1.object.ramt3[ds_row]   + ds_1.object.ramt4[ds_row]  + ds_1.object.ramt5[ds_row] + &
								  ds_1.object.ramt6[ds_row]
    ids_data3.object.bamtet[l_s_count]  = ids_data3.object.bamtet[l_s_count]  + ds_1.object.ramt1[ds_row]  + ds_1.object.ramt2[ds_row] + &
								  ds_1.object.ramt3[ds_row]   + ds_1.object.ramt4[ds_row]  + ds_1.object.ramt5[ds_row] + &
								  ds_1.object.ramt6[ds_row]   + ds_1.object.ramt7[ds_row]  + ds_1.object.ramt8[ds_row] + &
								  ds_1.object.ramt9[ds_row]   + ds_1.object.ramt10[ds_row] + ds_1.object.ramt11[ds_row] + &
								  ds_1.object.ramt12[ds_row]		
   if ids_data3.object.bqtye01[l_s_count] <> 0 then
		ids_data3.object.bcste01[l_s_count] = ids_data3.object.bamte01[l_s_count] / ids_data3.object.bqtye01[l_s_count]
	end if
	if ids_data3.object.bqtye02[l_s_count] <> 0 then
		ids_data3.object.bcste02[l_s_count] = ids_data3.object.bamte02[l_s_count] / ids_data3.object.bqtye02[l_s_count]
	end if
	if ids_data3.object.bqtye03[l_s_count] <> 0 then
		ids_data3.object.bcste03[l_s_count] = ids_data3.object.bamte03[l_s_count] / ids_data3.object.bqtye03[l_s_count]
	end if
	if ids_data3.object.bqtye04[l_s_count] <> 0 then
		ids_data3.object.bcste04[l_s_count] = ids_data3.object.bamte04[l_s_count] / ids_data3.object.bqtye04[l_s_count]
	end if
	if ids_data3.object.bqtye05[l_s_count] <> 0 then
		ids_data3.object.bcste05[l_s_count] = ids_data3.object.bamte05[l_s_count] / ids_data3.object.bqtye05[l_s_count]
	end if
	if ids_data3.object.bqtye06[l_s_count] <> 0 then
		ids_data3.object.bcste06[l_s_count] = ids_data3.object.bamte06[l_s_count] / ids_data3.object.bqtye06[l_s_count]
	end if
	if ids_data3.object.bqtye07[l_s_count] <> 0 then
		ids_data3.object.bcste07[l_s_count] = ids_data3.object.bamte07[l_s_count] / ids_data3.object.bqtye07[l_s_count]
	end if
	if ids_data3.object.bqtye08[l_s_count] <> 0 then
		ids_data3.object.bcste08[l_s_count] = ids_data3.object.bamte08[l_s_count] / ids_data3.object.bqtye08[l_s_count]
	end if
	if ids_data3.object.bqtye09[l_s_count] <> 0 then
		ids_data3.object.bcste09[l_s_count] = ids_data3.object.bamte09[l_s_count] / ids_data3.object.bqtye09[l_s_count]
	end if
	if ids_data3.object.bqtye10[l_s_count] <> 0 then
		ids_data3.object.bcste10[l_s_count] = ids_data3.object.bamte10[l_s_count] / ids_data3.object.bqtye10[l_s_count]
	end if
	if ids_data3.object.bqtye11[l_s_count] <> 0 then
		ids_data3.object.bcste11[l_s_count] = ids_data3.object.bamte11[l_s_count] / ids_data3.object.bqtye11[l_s_count]
	end if
	if ids_data3.object.bqtye12[l_s_count] <> 0 then
		ids_data3.object.bcste12[l_s_count] = ids_data3.object.bamte12[l_s_count] / ids_data3.object.bqtye12[l_s_count]
	end if
	if ids_data3.object.bqtyeh[l_s_count] <> 0 then
		ids_data3.object.bcsteh[l_s_count] = ids_data3.object.bamteh[l_s_count] / ids_data3.object.bqtyeh[l_s_count]
	end if
	if ids_data3.object.bqtyet[l_s_count] <> 0 then
		ids_data3.object.bcstet[l_s_count] = ids_data3.object.bamtet[l_s_count] / ids_data3.object.bqtyet[l_s_count]
	end if
//	if ids_data3.object.bitno[l_s_count] = '541007' then
//		messagebox("DD",string(ids_data3.object.bcste03[l_s_count]))
//	end if
end if

ids_data3.object.bmacaddr[l_s_count] = g_s_macaddr
ids_data3.object.bipaddr[l_s_count]  = g_s_ipaddr
ids_data3.object.bupdt[l_s_count]    = g_s_date

wf_mps02x(ds_1,ds_row,ids_data3,l_s_count)
end subroutine

public subroutine wf_move05 (datawindow ds_1, long ds_row);string l_s_year,l_s_month,l_s_type,l_s_xplant,l_s_dvsn,l_s_itno,l_s_custcd
long   l_s_count
integer l_s_find

l_s_year   = mid(ds_1.object.cym[ds_row],1,4)
l_s_month  = mid(ds_1.object.cym[ds_row],5,2)
l_s_custcd = ds_1.object.custcd[ds_row]

if ds_1.object.kitcd[ds_row] <> 'K' then
	l_s_xplant = ds_1.object.xplant[ds_row]
	l_s_dvsn = ds_1.object.div[ds_row]
	l_s_itno   = ds_1.object.itno[ds_row]
else
	l_s_xplant = i_s_xplant
	l_s_dvsn   = i_s_dvsn
	l_s_itno   = i_s_itno
end if

if ds_1.object.accd[ds_row] = '30' then
	l_s_type = ' '
elseif ds_1.object.srcd[ds_row] = '03' then
	l_s_type = 'A'
else
	l_s_type = 'B'
end if

select count(*) into :l_s_count from pbmps.mps003
	where ccmcd = :g_s_company and cyear = :l_s_year and cmonth = :l_s_month and cplant = :l_s_xplant and
	      cdvsn = :l_s_dvsn    and citno  = :l_s_itno  and ccust  = :l_s_custcd using sqlca;


if l_s_count > 0 then
	if ds_1.object.kitcd[ds_row] ='K' then
		kitflg = '1'
	end if
end if
l_s_find = ids_data4.find(" ccmcd = '" + g_s_company + "'" + " and cyear = '" + l_s_year + "'" & 
                        + " and cmonth = '" + l_s_month + "'" + " and cplant = '" + l_s_xplant + "'" + " and cdvsn = '" + l_s_dvsn + "'" &
						+ " and citno  = '" + l_s_itno  + "'" + " and ccust = '" + l_s_custcd + "'" ,1,ids_data4.rowcount()) 
if l_s_find = 0 then
	l_s_count = ids_Data4.insertrow(0)
	ids_data4.object.ccrdt[l_s_count]  = g_s_date
else
	l_s_count = l_s_find
end if
ids_data4.object.ccmcd[l_s_count]  = g_s_company
ids_data4.object.cyear[l_s_count]  = l_s_year
ids_data4.object.cmonth[l_s_count] = l_s_month
ids_data4.object.cplant[l_s_count] = l_s_xplant
ids_data4.object.cdvsn[l_s_count]  = l_s_dvsn
ids_data4.object.citno[l_s_count]  = l_s_itno
ids_data4.object.ctype[l_s_count]  = l_s_type
ids_data4.object.ccust[l_s_count]  = l_s_custcd


if kitlop = '1' then
	ids_data4.object.ckitno[l_s_count] = i_s_citno
end if

if ds_1.object.suse[ds_row] = 'D' then
	if kitmodf <> '1' then
	   ids_data4.object.cqtyd01[l_s_count] = ids_data4.object.cqtyd01[l_s_count] + ds_1.object.rqty1[ds_row]  
	   ids_data4.object.cqtyd02[l_s_count] = ids_data4.object.cqtyd02[l_s_count] + ds_1.object.rqty2[ds_row]
	   ids_data4.object.cqtyd03[l_s_count] = ids_data4.object.cqtyd03[l_s_count] + ds_1.object.rqty3[ds_row]
	   ids_data4.object.cqtyd04[l_s_count] = ids_data4.object.cqtyd04[l_s_count] + ds_1.object.rqty4[ds_row]
	   ids_data4.object.cqtyd05[l_s_count] = ids_data4.object.cqtyd05[l_s_count] + ds_1.object.rqty5[ds_row]
	   ids_data4.object.cqtyd06[l_s_count] = ids_data4.object.cqtyd06[l_s_count] + ds_1.object.rqty6[ds_row]
	   ids_data4.object.cqtyd07[l_s_count] = ids_data4.object.cqtyd07[l_s_count] + ds_1.object.rqty7[ds_row]
	   ids_data4.object.cqtyd08[l_s_count] = ids_data4.object.cqtyd08[l_s_count] + ds_1.object.rqty8[ds_row]
	   ids_data4.object.cqtyd09[l_s_count] = ids_data4.object.cqtyd09[l_s_count] + ds_1.object.rqty9[ds_row]
	   ids_data4.object.cqtyd10[l_s_count] = ids_data4.object.cqtyd10[l_s_count] + ds_1.object.rqty10[ds_row]
	   ids_data4.object.cqtyd11[l_s_count] = ids_data4.object.cqtyd11[l_s_count] + ds_1.object.rqty11[ds_row]
	   ids_data4.object.cqtyd12[l_s_count] = ids_data4.object.cqtyd12[l_s_count] + ds_1.object.rqty12[ds_row]
	   ids_data4.object.cqtydh[l_s_count]  = ids_data4.object.cqtydh[l_s_count]  + ds_1.object.rqty1[ds_row]  + ds_1.object.rqty2[ds_row] + &
	                                 ds_1.object.rqty3[ds_row]   + ds_1.object.rqty4[ds_row]  + ds_1.object.rqty5[ds_row] + &
									 ds_1.object.rqty6[ds_row]
       ids_data4.object.cqtydt[l_s_count]  = ids_data4.object.cqtydt[l_s_count]  + ds_1.object.rqty1[ds_row]  + ds_1.object.rqty2[ds_row] + &
	                                 ds_1.object.rqty3[ds_row]   + ds_1.object.rqty4[ds_row]  + ds_1.object.rqty5[ds_row] + &
									 ds_1.object.rqty6[ds_row]   + ds_1.object.rqty7[ds_row]  + ds_1.object.rqty8[ds_row] + &
	                                 ds_1.object.rqty9[ds_row]   + ds_1.object.rqty10[ds_row] + ds_1.object.rqty11[ds_row] + &
									 ds_1.object.rqty12[ds_row]		
    end if
	 ids_data4.object.camtd01[l_s_count] = ids_data4.object.camtd01[l_s_count] + ds_1.object.ramt1[ds_row]  
    ids_data4.object.camtd02[l_s_count] = ids_data4.object.camtd02[l_s_count] + ds_1.object.ramt2[ds_row]
    ids_data4.object.camtd03[l_s_count] = ids_data4.object.camtd03[l_s_count] + ds_1.object.ramt3[ds_row]
    ids_data4.object.camtd04[l_s_count] = ids_data4.object.camtd04[l_s_count] + ds_1.object.ramt4[ds_row]
    ids_data4.object.camtd05[l_s_count] = ids_data4.object.camtd05[l_s_count] + ds_1.object.ramt5[ds_row]
    ids_data4.object.camtd06[l_s_count] = ids_data4.object.camtd06[l_s_count] + ds_1.object.ramt6[ds_row]
    ids_data4.object.camtd07[l_s_count] = ids_data4.object.camtd07[l_s_count] + ds_1.object.ramt7[ds_row]
    ids_data4.object.camtd08[l_s_count] = ids_data4.object.camtd08[l_s_count] + ds_1.object.ramt8[ds_row]
    ids_data4.object.camtd09[l_s_count] = ids_data4.object.camtd09[l_s_count] + ds_1.object.ramt9[ds_row]
    ids_data4.object.camtd10[l_s_count] = ids_data4.object.camtd10[l_s_count] + ds_1.object.ramt10[ds_row]
    ids_data4.object.camtd11[l_s_count] = ids_data4.object.camtd11[l_s_count] + ds_1.object.ramt11[ds_row]
    ids_data4.object.camtd12[l_s_count] = ids_data4.object.camtd12[l_s_count] + ds_1.object.ramt12[ds_row]
    ids_data4.object.camtdh[l_s_count]  = ids_data4.object.camtdh[l_s_count]  + ds_1.object.ramt1[ds_row]  + ds_1.object.ramt2[ds_row] + &
	    						  ds_1.object.ramt3[ds_row]   + ds_1.object.ramt4[ds_row]  + ds_1.object.ramt5[ds_row] + &
								  ds_1.object.ramt6[ds_row]
    ids_data4.object.camtdt[l_s_count]  = ids_data4.object.camtdt[l_s_count]  + ds_1.object.ramt1[ds_row]  + ds_1.object.ramt2[ds_row] + &
								  ds_1.object.ramt3[ds_row]   + ds_1.object.ramt4[ds_row]  + ds_1.object.ramt5[ds_row] + &
								  ds_1.object.ramt6[ds_row]   + ds_1.object.ramt7[ds_row]  + ds_1.object.ramt8[ds_row] + &
								  ds_1.object.ramt9[ds_row]   + ds_1.object.ramt10[ds_row] + ds_1.object.ramt11[ds_row] + &
								  ds_1.object.ramt12[ds_row]		
   if ids_data4.object.cqtyd01[l_s_count] <> 0 then
		ids_data4.object.ccstd01[l_s_count] = ids_data4.object.camtd01[l_s_count] / ids_data4.object.cqtyd01[l_s_count]
	end if
	if ids_data4.object.cqtyd02[l_s_count] <> 0 then
		ids_data4.object.ccstd02[l_s_count] = ids_data4.object.camtd02[l_s_count] / ids_data4.object.cqtyd02[l_s_count]
	end if
	if ids_data4.object.cqtyd03[l_s_count] <> 0 then
		ids_data4.object.ccstd03[l_s_count] = ids_data4.object.camtd03[l_s_count] / ids_data4.object.cqtyd03[l_s_count]
	end if
	if ids_data4.object.cqtyd04[l_s_count] <> 0 then
		ids_data4.object.ccstd04[l_s_count] = ids_data4.object.camtd04[l_s_count] / ids_data4.object.cqtyd04[l_s_count]
	end if
	if ids_data4.object.cqtyd05[l_s_count] <> 0 then
		ids_data4.object.ccstd05[l_s_count] = ids_data4.object.camtd05[l_s_count] / ids_data4.object.cqtyd05[l_s_count]
	end if
	if ids_data4.object.cqtyd06[l_s_count] <> 0 then
		ids_data4.object.ccstd06[l_s_count] = ids_data4.object.camtd06[l_s_count] / ids_data4.object.cqtyd06[l_s_count]
	end if
	if ids_data4.object.cqtyd07[l_s_count] <> 0 then
		ids_data4.object.ccstd07[l_s_count] = ids_data4.object.camtd07[l_s_count] / ids_data4.object.cqtyd07[l_s_count]
	end if
	if ids_data4.object.cqtyd08[l_s_count] <> 0 then
		ids_data4.object.ccstd08[l_s_count] = ids_data4.object.camtd08[l_s_count] / ids_data4.object.cqtyd08[l_s_count]
	end if
	if ids_data4.object.cqtyd09[l_s_count] <> 0 then
		ids_data4.object.ccstd09[l_s_count] = ids_data4.object.camtd09[l_s_count] / ids_data4.object.cqtyd09[l_s_count]
	end if
	if ids_data4.object.cqtyd10[l_s_count] <> 0 then
		ids_data4.object.ccstd10[l_s_count] = ids_data4.object.camtd10[l_s_count] / ids_data4.object.cqtyd10[l_s_count]
	end if
	if ids_data4.object.cqtyd11[l_s_count] <> 0 then
		ids_data4.object.ccstd11[l_s_count] = ids_data4.object.camtd11[l_s_count] / ids_data4.object.cqtyd11[l_s_count]
	end if
	if ids_data4.object.cqtyd12[l_s_count] <> 0 then
		ids_data4.object.ccstd12[l_s_count] = ids_data4.object.camtd12[l_s_count] / ids_data4.object.cqtyd12[l_s_count]
	end if
	   	
	if ids_data4.object.cqtydh[l_s_count] <> 0 then
		ids_data4.object.ccstdh[l_s_count] = ids_data4.object.camtdh[l_s_count] / ids_data4.object.cqtydh[l_s_count]
	end if
	if ids_data4.object.cqtydt[l_s_count] <> 0 then
		ids_data4.object.ccstdt[l_s_count] = ids_data4.object.camtdt[l_s_count] / ids_data4.object.cqtydt[l_s_count]
	end if
else
	if kitmodf <> '1' then
	   ids_data4.object.cqtye01[l_s_count] = ids_data4.object.cqtye01[l_s_count] + ds_1.object.rqty1[ds_row]  
	   ids_data4.object.cqtye02[l_s_count] = ids_data4.object.cqtye02[l_s_count] + ds_1.object.rqty2[ds_row]
	   ids_data4.object.cqtye03[l_s_count] = ids_data4.object.cqtye03[l_s_count] + ds_1.object.rqty3[ds_row]
	   ids_data4.object.cqtye04[l_s_count] = ids_data4.object.cqtye04[l_s_count] + ds_1.object.rqty4[ds_row]
	   ids_data4.object.cqtye05[l_s_count] = ids_data4.object.cqtye05[l_s_count] + ds_1.object.rqty5[ds_row]
	   ids_data4.object.cqtye06[l_s_count] = ids_data4.object.cqtye06[l_s_count] + ds_1.object.rqty6[ds_row]
	   ids_data4.object.cqtye07[l_s_count] = ids_data4.object.cqtye07[l_s_count] + ds_1.object.rqty7[ds_row]
	   ids_data4.object.cqtye08[l_s_count] = ids_data4.object.cqtye08[l_s_count] + ds_1.object.rqty8[ds_row]
	   ids_data4.object.cqtye09[l_s_count] = ids_data4.object.cqtye09[l_s_count] + ds_1.object.rqty9[ds_row]
	   ids_data4.object.cqtye10[l_s_count] = ids_data4.object.cqtye10[l_s_count] + ds_1.object.rqty10[ds_row]
	   ids_data4.object.cqtye11[l_s_count] = ids_data4.object.cqtye11[l_s_count] + ds_1.object.rqty11[ds_row]
	   ids_data4.object.cqtye12[l_s_count] = ids_data4.object.cqtye12[l_s_count] + ds_1.object.rqty12[ds_row]
	   ids_data4.object.cqtyeh[l_s_count]  = ids_data4.object.cqtyeh[l_s_count]  + ds_1.object.rqty1[ds_row]  + ds_1.object.rqty2[ds_row] + &
	                                 ds_1.object.rqty3[ds_row]   + ds_1.object.rqty4[ds_row]  + ds_1.object.rqty5[ds_row] + &
									 ds_1.object.rqty6[ds_row]
       ids_data4.object.cqtyet[l_s_count]  = ids_data4.object.cqtyet[l_s_count]  + ds_1.object.rqty1[ds_row]  + ds_1.object.rqty2[ds_row] + &
	                                 ds_1.object.rqty3[ds_row]   + ds_1.object.rqty4[ds_row]  + ds_1.object.rqty5[ds_row] + &
									 ds_1.object.rqty6[ds_row]   + ds_1.object.rqty7[ds_row]  + ds_1.object.rqty8[ds_row] + &
	                                 ds_1.object.rqty9[ds_row]   + ds_1.object.rqty10[ds_row] + ds_1.object.rqty11[ds_row] + &
									 ds_1.object.rqty12[ds_row]		
    end if
	ids_data4.object.camte01[l_s_count] = ids_data4.object.camte01[l_s_count] + ds_1.object.ramt1[ds_row]  
    ids_data4.object.camte02[l_s_count] = ids_data4.object.camte02[l_s_count] + ds_1.object.ramt2[ds_row]
    ids_data4.object.camte03[l_s_count] = ids_data4.object.camte03[l_s_count] + ds_1.object.ramt3[ds_row]
    ids_data4.object.camte04[l_s_count] = ids_data4.object.camte04[l_s_count] + ds_1.object.ramt4[ds_row]
    ids_data4.object.camte05[l_s_count] = ids_data4.object.camte05[l_s_count] + ds_1.object.ramt5[ds_row]
    ids_data4.object.camte06[l_s_count] = ids_data4.object.camte06[l_s_count] + ds_1.object.ramt6[ds_row]
    ids_data4.object.camte07[l_s_count] = ids_data4.object.camte07[l_s_count] + ds_1.object.ramt7[ds_row]
    ids_data4.object.camte08[l_s_count] = ids_data4.object.camte08[l_s_count] + ds_1.object.ramt8[ds_row]
    ids_data4.object.camte09[l_s_count] = ids_data4.object.camte09[l_s_count] + ds_1.object.ramt9[ds_row]
    ids_data4.object.camte10[l_s_count] = ids_data4.object.camte10[l_s_count] + ds_1.object.ramt10[ds_row]
    ids_data4.object.camte11[l_s_count] = ids_data4.object.camte11[l_s_count] + ds_1.object.ramt11[ds_row]
    ids_data4.object.camte12[l_s_count] = ids_data4.object.camte12[l_s_count] + ds_1.object.ramt12[ds_row]
    ids_data4.object.camteh[l_s_count]  = ids_data4.object.camteh[l_s_count]  + ds_1.object.ramt1[ds_row]  + ds_1.object.ramt2[ds_row] + &
	    						  ds_1.object.ramt3[ds_row]   + ds_1.object.ramt4[ds_row]  + ds_1.object.ramt5[ds_row] + &
								  ds_1.object.ramt6[ds_row]
    ids_data4.object.camtet[l_s_count]  = ids_data4.object.camtet[l_s_count]  + ds_1.object.ramt1[ds_row]  + ds_1.object.ramt2[ds_row] + &
								  ds_1.object.ramt3[ds_row]   + ds_1.object.ramt4[ds_row]  + ds_1.object.ramt5[ds_row] + &
								  ds_1.object.ramt6[ds_row]   + ds_1.object.ramt7[ds_row]  + ds_1.object.ramt8[ds_row] + &
								  ds_1.object.ramt9[ds_row]   + ds_1.object.ramt10[ds_row] + ds_1.object.ramt11[ds_row] + &
								  ds_1.object.ramt12[ds_row]		
	if ids_data4.object.cqtye01[l_s_count] <> 0 then
		ids_data4.object.ccste01[l_s_count] = ids_data4.object.camte01[l_s_count] / ids_data4.object.cqtye01[l_s_count]
	end if
	if ids_data4.object.cqtye02[l_s_count] <> 0 then
		ids_data4.object.ccste02[l_s_count] = ids_data4.object.camte02[l_s_count] / ids_data4.object.cqtye02[l_s_count]
	end if
	if ids_data4.object.cqtye03[l_s_count] <> 0 then
		ids_data4.object.ccste03[l_s_count] = ids_data4.object.camte03[l_s_count] / ids_data4.object.cqtye03[l_s_count]
	end if
	if ids_data4.object.cqtye04[l_s_count] <> 0 then
		ids_data4.object.ccste04[l_s_count] = ids_data4.object.camte04[l_s_count] / ids_data4.object.cqtye04[l_s_count]
	end if
	if ids_data4.object.cqtye05[l_s_count] <> 0 then
		ids_data4.object.ccste05[l_s_count] = ids_data4.object.camte05[l_s_count] / ids_data4.object.cqtye05[l_s_count]
	end if
	if ids_data4.object.cqtye06[l_s_count] <> 0 then
		ids_data4.object.ccste06[l_s_count] = ids_data4.object.camte06[l_s_count] / ids_data4.object.cqtye06[l_s_count]
	end if
	if ids_data4.object.cqtye07[l_s_count] <> 0 then
		ids_data4.object.ccste07[l_s_count] = ids_data4.object.camte07[l_s_count] / ids_data4.object.cqtye07[l_s_count]
	end if
	if ids_data4.object.cqtye08[l_s_count] <> 0 then
		ids_data4.object.ccste08[l_s_count] = ids_data4.object.camte08[l_s_count] / ids_data4.object.cqtye08[l_s_count]
	end if
	if ids_data4.object.cqtye09[l_s_count] <> 0 then
		ids_data4.object.ccste09[l_s_count] = ids_data4.object.camte09[l_s_count] / ids_data4.object.cqtye09[l_s_count]
	end if
	if ids_data4.object.cqtye10[l_s_count] <> 0 then
		ids_data4.object.ccste10[l_s_count] = ids_data4.object.camte10[l_s_count] / ids_data4.object.cqtye10[l_s_count]
	end if
	if ids_data4.object.cqtye11[l_s_count] <> 0 then
		ids_data4.object.ccste11[l_s_count] = ids_data4.object.camte11[l_s_count] / ids_data4.object.cqtye11[l_s_count]
	end if
	if ids_data4.object.cqtye12[l_s_count] <> 0 then
		ids_data4.object.ccste12[l_s_count] = ids_data4.object.camte12[l_s_count] / ids_data4.object.cqtye12[l_s_count]
	end if								  
	
	if ids_data4.object.cqtyeh[l_s_count] <> 0 then
		ids_data4.object.ccsteh[l_s_count] = ids_data4.object.camteh[l_s_count] / ids_data4.object.cqtyeh[l_s_count]
	end if
	if ids_data4.object.cqtyet[l_s_count] <> 0 then
		ids_data4.object.ccstet[l_s_count] = ids_data4.object.camtet[l_s_count] / ids_data4.object.cqtyet[l_s_count]
	end if
end if
ids_data4.object.cmacaddr[l_s_count] = g_s_macaddr
ids_data4.object.cipaddr[l_s_count]  = g_s_ipaddr
ids_data4.object.cupdt[l_s_count]    = g_s_date



end subroutine

public subroutine wf_mps02x (datawindow ds_1, long ds_row, datawindow ds_2, long ds_row2);string  l_s_xplant,l_s_dvsn,l_s_itno,l_s_cls,l_s_srce,l_s_chk_dvsn
integer l_s_count,l_s_check,l_s_divide = 0,l_s_find
dec{0}  l_s_avgqty
dec{1}  l_s_asfsd

if kitlop = '1' then
	l_s_xplant = i_s_xplant
	l_s_dvsn   = i_s_dvsn
	l_s_itno   = i_s_itno
	select cls,srce into :l_s_cls,:l_s_srce from pbinv.inv101
		where xplant = :l_s_xplant and div = :l_s_dvsn and itno = :l_s_itno using sqlca;
else
	l_s_xplant  = ds_1.object.xplant[ds_row]
	l_s_dvsn    = ds_1.object.div[ds_row]	
	l_s_itno    = ds_1.object.itno[ds_row]	
	l_s_cls     = ds_1.object.accd[ds_row]
	l_s_srce    = ds_1.object.srcd[ds_row]
end if

if i_s_chkxplant <> l_s_xplant or i_s_chkdvsn <> l_s_dvsn then
	if l_s_xplant = 'K' or l_s_xplant = 'J' then
		l_s_chk_Dvsn = l_s_xplant 
	else
		l_s_chk_Dvsn = l_s_dvsn
	end if
	// 해당공장의 잔여 작업일 가져오기
	i_s_workday = long(mid(f_get_workday_mps(f_relativedate(g_s_date,-1),l_s_chk_dvsn),1,2))
end if

if l_s_srce = '03' then
	l_s_srce = 'A' 
elseif l_s_cls = '30' then
	l_s_srce = ' '
else
	l_s_srce = 'B'
end if
l_s_find = ids_data5.find(" acmcd = '" + g_s_company + "'"  + " and aplant = '" + l_s_xplant + "'" &
					  	+ " and advsn  = '"  + l_s_dvsn  + "'" + " and aitno  = '" + l_s_itno  + "'" ,1,ids_data5.rowcount()) 
if l_s_find = 0 then
	l_s_count = ids_data5.insertrow(0)
else
	l_s_count = l_s_find
end if
ids_data5.object.acmcd[l_s_count]   = g_s_company
ids_data5.object.aplant[l_s_count]  = l_s_xplant
ids_data5.object.advsn[l_s_count]   = l_s_dvsn
ids_data5.object.aitno[l_s_count]   = l_s_itno
ids_data5.object.atype[l_s_count]   = l_s_srce
ids_data5.object.acrdt[l_s_count]   = g_s_date
ids_data5.object.alsdt[l_s_count]   = g_s_date

select asfsd into :l_s_asfsd from pbmps.mps001
	where acmcd = :g_s_company and aplant = :l_s_xplant and advsn = :l_s_dvsn and 
	      aitno = :l_s_itno    
using sqlca;

if sqlca.sqlcode <> 0 then
	l_s_asfsd  = 0
//else
//	ids_Data5.setitemstatus(l_s_count,0,primary!,Datamodified!)
end if
ids_data5.object.asfsd[l_s_count]   = l_s_asfsd	

//if sqlca.sqlcode = 0 and l_s_asfsd <> 0 then
	if (ds_2.object.bqtyd01[ds_row2] + ds_2.object.bqtye01[ds_row2] ) > 0 then
		l_s_avgqty += ds_2.object.bqtyd01[ds_row2] + ds_2.object.bqtye01[ds_row2]
		l_s_divide  += 1
	end if
	if ( ds_2.object.bqtyd02[ds_row2] + ds_2.object.bqtye02[ds_row2] ) > 0 then
		l_s_avgqty += ds_2.object.bqtyd02[ds_row2] + ds_2.object.bqtye02[ds_row2]
		l_s_divide  += 1
	end if
	if ( ds_2.object.bqtyd03[ds_row2] + ds_2.object.bqtye03[ds_row2] ) > 0 then
		l_s_avgqty += ds_2.object.bqtyd03[ds_row2] + ds_2.object.bqtye03[ds_row2]
		l_s_divide  += 1
	end if
	if ( ds_2.object.bqtyd04[ds_row2] + ds_2.object.bqtye04[ds_row2] ) > 0 then
		l_s_avgqty += ds_2.object.bqtyd04[ds_row2] + ds_2.object.bqtye04[ds_row2]
		l_s_divide  += 1
	end if
	if ( ds_2.object.bqtyd05[ds_row2] + ds_2.object.bqtye05[ds_row2] ) > 0 then
		l_s_avgqty += ds_2.object.bqtyd05[ds_row2] + ds_2.object.bqtye05[ds_row2]
		l_s_divide  += 1
	end if
	if ( ds_2.object.bqtyd06[ds_row2] + ds_2.object.bqtye06[ds_row2] ) > 0 then
		l_s_avgqty += ds_2.object.bqtyd06[ds_row2] + ds_2.object.bqtye06[ds_row2]
		l_s_divide  += 1
	end if
	if l_s_divide = 0 then
		l_s_avgqty = 0
	else
		l_s_avgqty = l_s_avgqty / l_s_divide
	end if
	if i_s_workday = 0 then
		ids_data5.object.asfsq[l_s_count] = 0
	else
		if l_s_cls = '30' then
			if  ( i_s_workday * l_s_asfsd ) <> 0 then
				// 운영재고량 = 월평균출하계획량 / 기준년월작업일수 * 운영재고일 (?)
				// i_s_workday : 현재일의 전일 부터 말일까지 근무일수
				ids_data5.object.asfsq[l_s_count] =  l_s_avgqty / ( i_s_workday * l_s_asfsd )
			else
				ids_data5.object.asfsq[l_s_count] = 0
			end if
		else
			ids_data5.object.asfsq[l_s_count] = 0
		end if
   end if
	ids_data5.object.achyn[l_s_count] = '1'
//end if

end subroutine

on w_mps_101d.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.uo_3=create uo_3
this.ids_data1=create ids_data1
this.ids_data2=create ids_data2
this.ids_data3=create ids_data3
this.ids_data4=create ids_data4
this.ids_data5=create ids_data5
this.st_1=create st_1
this.uo_2=create uo_2
this.dw_retrieve=create dw_retrieve
this.pb_excel=create pb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.uo_3
this.Control[iCurrent+3]=this.ids_data1
this.Control[iCurrent+4]=this.ids_data2
this.Control[iCurrent+5]=this.ids_data3
this.Control[iCurrent+6]=this.ids_data4
this.Control[iCurrent+7]=this.ids_data5
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.uo_2
this.Control[iCurrent+10]=this.dw_retrieve
this.Control[iCurrent+11]=this.pb_excel
end on

on w_mps_101d.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.uo_3)
destroy(this.ids_data1)
destroy(this.ids_data2)
destroy(this.ids_data3)
destroy(this.ids_data4)
destroy(this.ids_data5)
destroy(this.st_1)
destroy(this.uo_2)
destroy(this.dw_retrieve)
destroy(this.pb_excel)
end on

event open;call super::open;wf_return()
i_s_sle105_date = f_get_mps_sle105('RSPDBALL')
ids_data1.settransobject(Sqlca)
ids_data2.settransobject(Sqlca)
ids_data3.settransobject(sqlca)
ids_data4.settransobject(sqlca)
ids_data5.settransobject(sqlca)

//if g_s_empno = 'ADMIN' then
//	cb_1.enabled = true
//end if
//


end event

event ue_retrieve;call super::ue_retrieve;string ls_stscd,ls_mod,ls_checkdate[12],ls_date
int i,ln_count

dw_retrieve.reset()
wf_return()
select coalesce(max(zstscd),'') into :ls_stscd from pbmps.mps007
where 	zcmcd = '01' and zpgmid = 'MPSU06' and 
			zplant = :i_s_rxplant and zdvsn = :i_s_rdvsn and zyear = :i_s_rdate 
using sqlca ;			

if ls_stscd = '' then
	messagebox("확인","판매계획집계가 완료되지 않았습니다.시스템개발팀으로 문의하세요")
	return
end if

ln_count	=	dw_retrieve.retrieve(i_s_rxplant,i_s_rdvsn,trim(i_s_rpdcd) + '%' ,i_s_rdate)
if  ln_count	< 1 then
	uo_status.st_message.text = f_message("I020")
	pb_Excel.visible = false
else
  	uo_status.st_message.text = string(ln_count) + ' 개의 정보가 조회 되었습니다'
	pb_Excel.visible = true  
end if
for i = 0 to 11
	ls_date =  f_relative_month(i_s_rdate + '01' , i)
	ls_checkdate[i+1] = mid(ls_date,1,4) + '년 ' + mid(ls_date,5,2) + '월'
next
ls_mod	=  "t_1.Text = '" + ls_checkdate[1]   +  "'" + &
				"t_2.Text = '" + ls_checkdate[2]   +  "'" + &
				"t_3.Text = '" + ls_checkdate[3]   +  "'" + &
				"t_4.Text = '" + ls_checkdate[4]   +  "'" + &
				"t_5.Text = '" + ls_checkdate[5]   +  "'" + &
				"t_6.Text = '" + ls_checkdate[6]   +  "'" + & 
				"t_7.Text = '" + ls_checkdate[7]   +  "'" + &
				"t_8.Text = '" + ls_checkdate[8]   +  "'" + &
				"t_9.Text = '" + ls_checkdate[9]   +  "'" + &
				"t_10.Text = '" + ls_checkdate[10]   +  "'" + &
				"t_11.Text = '" + ls_checkdate[11]   +  "'" + & 				
				"t_12.Text = '" + ls_checkdate[12]   +  "'" 
dw_retrieve.Modify(ls_mod)


end event

type uo_status from w_origin_sheet02`uo_status within w_mps_101d
integer y = 2464
end type

type cb_1 from commandbutton within w_mps_101d
integer x = 3429
integer y = 16
integer width = 503
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "판매계획집계"
end type

event clicked;long l_n_count,i,j,l_n_subcount
dec  totqty6
dec{3} cqty[12]
integer l_n_yesno
string l_s_xplant,l_s_dvsn,l_s_itno,l_s_pdcd,l_s_cls,l_s_srce,lc_yyyymm,l_s_return

ids_data1.reset()
ids_data2.reset()
ids_data3.reset()
ids_data4.reset()
ids_data5.reset()
dw_retrieve.reset()

uo_status.st_message.text = ''
setpointer(Hourglass!)
wf_return()

l_s_return = f_get_mps007(g_s_company,i_s_rxplant,i_s_rdvsn,i_s_rdate)
if f_spacechk(l_s_return) = -1 then
	l_n_yesno = 2	
else
	l_n_yesno = messagebox("확인",'판매계획 재집계를 원하시면 Yes, 판매계획 집계를 원하시면 No, 아니면 Cancel ',question!,YesNoCancel!)
end if
if l_n_yesno = 3 then
	uo_status.st_message.text = "취소되었습니다."
	return 0
end if

delete from pbmps.mps003
where ccmcd = :g_s_company and cyear = substring(:i_s_rdate,1,4) and cmonth = substring(:i_s_rdate,5,2) and 
		cdvsn = :i_s_rdvsn and cplant = :i_s_rxplant 
using sqlca ;

delete from pbmps.mps002
where bcmcd = :g_s_company and byear = substring(:i_s_rdate,1,4) and bmonth = substring(:i_s_rdate,5,2) and  
		bplant = :i_s_rxplant and bdvsn = :i_s_rdvsn
using sqlca ;

if i_s_sle105_date > mid(l_s_return,1,8) and l_n_yesno = 2 then
	// 판매계획집계이면서 생산계획계산뒤에 보다 판매계획이 수정된 경우 => 생산계획 6개월 롤링 및 기준정보 초기화
	delete from pbmps.mps004
	where dcmcd = :g_s_company and dyear = substring(:i_s_rdate,1,4) and dmonth = substring(:i_s_rdate,5,2) and 
			dplant = :i_s_rxplant and ddvsn = :i_s_rdvsn 
	using sqlca ;
	
	update pbmps.mps001
	set asfsq = 0,abmbq = 0,apdqa = 0,apdqr = 0,aslqa =0,aslqr =0,aohqt =0,
		alnal = '',alsdt = '',achyn = '',amacaddr = :g_S_macaddr,aipaddr = :g_s_ipaddr,aupdt = ''
	where acmcd = :g_s_company and aplant = :i_s_rxplant and advsn = :i_s_rdvsn
	using sqlca;
end if	
	
l_n_count = 0
l_n_count = ids_data1.retrieve(g_s_company,i_s_rxplant,i_s_rdvsn,i_s_rdate)
ids_data5.retrieve(g_s_company,i_s_rxplant,i_s_rdvsn)
for i=1 to l_n_count
//	yield()
	totqty6 = ids_Data1.object.rqty1[i] + ids_Data1.object.rqty2[i] + ids_Data1.object.rqty3[i] + &
	          ids_Data1.object.rqty4[i] + ids_Data1.object.rqty5[i] + ids_Data1.object.rqty6[i]
		  
	if totqty6 <= 0 then
	   continue 
	end if
  	l_s_xplant = ids_data1.object.xplant[i]
	l_s_dvsn   = ids_data1.object.div[i]
	l_s_itno   = ids_data1.object.itno[i]
	select pdcd,cls,srce into :l_s_pdcd,:l_s_cls,:l_s_srce from pbinv.inv101
		where xplant = :l_s_xplant and div = :l_s_dvsn and itno = :l_s_itno using sqlca;
	if sqlca.sqlcode = 0 then
		ids_data1.object.pdcd[i] = l_s_pdcd
		ids_data1.object.accd[i] = l_s_cls
		ids_data1.object.srcd[i] = l_s_srce
	else
		ids_data1.object.pdcd[i] = ''
		ids_data1.object.accd[i] = ''
		ids_data1.object.srcd[i] = ''
	end if
	
	if ids_Data1.object.kitcd[i] = 'K' then
		wf_savset(ids_data1,i)
		l_n_subcount = 0
		l_n_subcount = ids_data2.retrieve(g_s_company,l_s_xplant,l_s_dvsn,trim(ids_data1.object.custcd[i]),trim(ids_data1.object.citno[i]))
      wf_rtnset(ids_data1,i)
		for j=1 to l_n_subcount
			kitlop = '1'
			i_s_citno  = ids_data2.object.citno[j]
			i_s_itno   = ids_data2.object.itno[j]
			i_s_xplant = ids_data2.object.xplant[j]
			i_s_dvsn   = ids_data2.object.div[j]
			wf_kit01(ids_data1,i,ids_data2,j)
		next
//		wf_kitmod(ids_data1,i)
		kitlop = ''
	else
		wf_summary(ids_data1,i)
		wf_movebf(ids_data1,i)
		wf_move05(ids_data1,i)
	end if
next

ids_data3.accepttext()
ids_data4.accepttext()
ids_data3.update()
ids_data4.update()
if l_n_yesno = 2 then
	ids_data5.accepttext()
	ids_data5.update()
end if
f_mps007_update(i_s_rxplant,i_s_rdvsn,i_s_rdate,'I')
// 적정재고 계산 Routing 추가 --2006.09.20
int		ln_days
ln_days		=	integer(mid(f_relativedate(f_relative_month(i_s_rdate,1),-1),7,2))
update	pbmps.mps008
	set	gempno 		= 	:g_s_empno,gupdtdt = :g_s_date,
			gqtyperday	=	(select	coalesce(max(( bqtyd01 + bqtye01 ) / :ln_Days ),0) from pbmps.mps002
									where bcmcd = 	gcmcd	and 	bplant	=	gplant							and	bdvsn		=	gdvsn	and
											bitno	=	gitno	and	byear		=	substring(:i_s_rdate,1,4)	and	bmonth	=	substring(:i_s_rdate,5,2))
where 	gcmcd	=	:g_s_company	and	gplant	=	:i_s_rxplant	and	gdvsn	=	:i_s_rdvsn
using	sqlca ;												
//
parent.triggerevent("ue_retrieve")
uo_status.st_message.text = f_message("U010")
end event

type uo_3 from uo_ccyymm_mps within w_mps_101d
event destroy ( )
integer x = 2821
integer y = 24
integer taborder = 40
boolean bringtotop = true
end type

on uo_3.destroy
call uo_ccyymm_mps::destroy
end on

type ids_data1 from datawindow within w_mps_101d
boolean visible = false
integer x = 951
integer y = 128
integer width = 411
integer height = 432
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_mps_sle212"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ids_data2 from datawindow within w_mps_101d
boolean visible = false
integer x = 1445
integer y = 132
integer width = 411
integer height = 432
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_mps_sle103"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ids_data3 from datawindow within w_mps_101d
boolean visible = false
integer x = 2053
integer y = 128
integer width = 411
integer height = 432
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_mps_mps002"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ids_data4 from datawindow within w_mps_101d
boolean visible = false
integer x = 2651
integer y = 192
integer width = 411
integer height = 432
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "d_mps_mps003"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ids_data5 from datawindow within w_mps_101d
boolean visible = false
integer x = 3291
integer y = 200
integer width = 411
integer height = 432
integer taborder = 60
boolean bringtotop = true
string title = "none"
string dataobject = "d_mps_mps001"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_mps_101d
integer x = 2510
integer y = 40
integer width = 288
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

type uo_2 from uo_plandiv_pdcd_rtn within w_mps_101d
event aaa pbm_dwnsetfocus
integer x = 27
integer y = 8
integer width = 2482
integer taborder = 20
boolean bringtotop = true
end type

on uo_2.destroy
call uo_plandiv_pdcd_rtn::destroy
end on

type dw_retrieve from datawindow within w_mps_101d
integer x = 55
integer y = 140
integer width = 4576
integer height = 2284
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_upload_mps"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca) 
end event

event retrieveend;int i 


end event

type pb_excel from picturebutton within w_mps_101d
boolean visible = false
integer x = 4443
integer y = 8
integer width = 155
integer height = 132
integer taborder = 50
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

event clicked;if  dw_retrieve.rowcount() > 0 then
	//f_Save_to_excel_execute(dw_retrieve,'2')
	f_save_to_excel(dw_retrieve)
end if
end event

