$PBExportHeader$w_mps_103i.srw
$PBExportComments$생산계획 확정
forward
global type w_mps_103i from w_origin_sheet01
end type
type uo_1 from uo_plandiv_bom within w_mps_103i
end type
type dw_2 from datawindow within w_mps_103i
end type
type uo_2 from uo_ccyymm_mps within w_mps_103i
end type
type st_1 from statictext within w_mps_103i
end type
type cb_1 from commandbutton within w_mps_103i
end type
end forward

global type w_mps_103i from w_origin_sheet01
uo_1 uo_1
dw_2 dw_2
uo_2 uo_2
st_1 st_1
cb_1 cb_1
end type
global w_mps_103i w_mps_103i

type variables
string is_xplant,is_div,is_date
end variables

forward prototypes
public subroutine wf_return ()
public subroutine wf_modify_dw ()
public function integer wf_create_mpst03 (string ag_yyyymm, string ag_plant, string ag_dvsn)
end prototypes

public subroutine wf_return ();string ls_parm

ls_parm   = uo_1.uf_return()
is_xplant 	= mid(ls_parm,1,1)
is_div    	= mid(ls_parm,2,1)
is_date    	= uo_2.uf_yyyymm()

end subroutine

public subroutine wf_modify_dw ();string ls_mod,ls_title,ls_pqty_title[7],ls_pamt_title[7],ls_sqty_title[7],ls_samt_title[7],ls_oqty_title[7],ls_oamt_title[7]
string	ls_pdqa,ls_pdqr,ls_slqa,ls_slqr
int		i

for i = 1 to 7
	ls_title =  f_relative_month(is_date + '01' , i - 2)
	if i = 1 then
		ls_pqty_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 생산예상수량'
		ls_sqty_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 출하예상수량'
		ls_oqty_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 재고예상수량'
		ls_pamt_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 생산예상금액'
		ls_samt_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 출하예상금액'
		ls_oamt_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 재고예상금액'
		ls_pdqa			= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 기존생산수량'	
		ls_pdqr			= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 잔여생산수량'
		ls_slqa			= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 기존출하수량'
		ls_slqr			= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 잔여출하수량'
	else
		ls_pqty_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 생산계획수량'
		ls_sqty_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 출하계획수량'
		ls_oqty_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 재고계획수량'
		ls_pamt_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 생산계획금액'
		ls_samt_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 출하계획금액'
		ls_oamt_title[i] 	= mid(ls_title,1,4) + '년' + mid(ls_title,5,2) + '월 재고계획금액'
	end if
next
ls_mod	=   	"t_1.Text 		= '" + ls_pdqa		   	+  "'" + &
                     "t_2.Text 		= '" + ls_slqa			   	+  "'" + &
				"t_3.Text 		= '" + ls_pdqr		  		+  "'" + &
                     "t_4.Text 		= '" + ls_slqr			   	+  "'" + &
				"m_pq0.Text 	= '" + ls_pqty_title[1]   	+  "'" + &
				"m_pq1.Text 	= '" + ls_pqty_title[2]   	+  "'" + &
				"m_pq2.Text 	= '" + ls_pqty_title[3]   	+  "'" + &
				"m_pq3.Text 	= '" + ls_pqty_title[4]   	+  "'" + &
				"m_pq4.Text 	= '" + ls_pqty_title[5]   	+  "'" + &
				"m_pq5.Text 	= '" + ls_pqty_title[6]   	+  "'" + &
				"m_pq6.Text 	= '" + ls_pqty_title[7]   	+  "'" + &
				"m_sq0.Text 	= '" + ls_sqty_title[1]   	+  "'" + &
				"m_sq1.Text 	= '" + ls_sqty_title[2]   	+  "'" + &
				"m_sq2.Text 	= '" + ls_sqty_title[3]   	+  "'" + &
				"m_sq3.Text 	= '" + ls_sqty_title[4]   	+  "'" + &
				"m_sq4.Text 	= '" + ls_sqty_title[5]   	+  "'" + &
				"m_sq5.Text 	= '" + ls_sqty_title[6]   	+  "'" + &
				"m_sq6.Text 	= '" + ls_sqty_title[7]   	+  "'" + &
				"m_oq0.Text 	= '" + ls_oqty_title[1]   	+  "'" + &
				"m_oq1.Text 	= '" + ls_oqty_title[2]   	+  "'" + &
				"m_oq2.Text 	= '" + ls_oqty_title[3]   	+  "'" + &
				"m_oq3.Text 	= '" + ls_oqty_title[4]   	+  "'" + &
				"m_oq4.Text 	= '" + ls_oqty_title[5]   	+  "'" + &
				"m_oq5.Text 	= '" + ls_oqty_title[6]   	+  "'" + &
				"m_oq6.Text 	= '" + ls_oqty_title[7]   	+  "'" + &
				"m_pm0.Text 	= '" + ls_pamt_title[1]   	+  "'" + &
				"m_pm1.Text 	= '" + ls_pamt_title[2]   	+  "'" + &
				"m_pm2.Text 	= '" + ls_pamt_title[3]   	+  "'" + &
				"m_pm3.Text 	= '" + ls_pamt_title[4]   	+  "'" + &
				"m_pm4.Text 	= '" + ls_pamt_title[5]   	+  "'" + &
				"m_pm5.Text 	= '" + ls_pamt_title[6]   	+  "'" + &
				"m_pm6.Text 	= '" + ls_pamt_title[7]   	+  "'" + &
				"m_sm0.Text 	= '" + ls_samt_title[1]   	+  "'" + &
				"m_sm1.Text 	= '" + ls_samt_title[2]   	+  "'" + &
				"m_sm2.Text 	= '" + ls_samt_title[3]   	+  "'" + &
				"m_sm3.Text 	= '" + ls_samt_title[4]   	+  "'" + &
				"m_sm4.Text 	= '" + ls_samt_title[5]   	+  "'" + &
				"m_sm5.Text 	= '" + ls_samt_title[6]   	+  "'" + &
				"m_sm6.Text 	= '" + ls_samt_title[7]   	+  "'" + &
				"m_om0.Text 	= '" + ls_oamt_title[1]   	+  "'" + &
				"m_om1.Text 	= '" + ls_oamt_title[2]   	+  "'" + &
				"m_om2.Text 	= '" + ls_oamt_title[3]   	+  "'" + &
				"m_om3.Text 	= '" + ls_oamt_title[4]   	+  "'" + &
				"m_om4.Text 	= '" + ls_oamt_title[5]   	+  "'" + &
				"m_om5.Text 	= '" + ls_oamt_title[6]   	+  "'" + &
				"m_om6.Text 	= '" + ls_oamt_title[7]   	+  "'" 
				
dw_2.Modify(ls_mod)
end subroutine

public function integer wf_create_mpst03 (string ag_yyyymm, string ag_plant, string ag_dvsn);string ls_that_month, ls_last_month, ls_last_twomonth, ls_chk_string
string ls_that_yyyy, ls_that_mm, ls_last_yyyy, ls_last_mm

ls_that_yyyy = mid(ag_yyyymm,1,4)
ls_that_mm = mid(ag_yyyymm,5,2)
ls_last_month = mid(f_relative_month(ag_yyyymm,-1),1,6)
ls_last_yyyy = mid(ls_last_month,1,4)
ls_last_mm = mid(ls_last_month,5,2)
ls_last_twomonth = mid(f_relative_month(ag_yyyymm,-2),1,6)

DELETE FROM PBMPS.MPST03
WHERE hplant = :ag_plant AND hdiv = :ag_dvsn
using sqlca;

INSERT INTO PBMPS.MPST03
 ( HPLANT,HDIV,HITNO,HPDCD,HSPEC,
   HGUBUN,
   HCOST,HYPPLNQ,HYPPLNM,HYPRSTQ,HYPRSTM,
	HMPPLNQ0,HMPPLNM0,
	HMSPLNQ0,
	HMSPLNM0,
	HMPRSTQ0,HMPRSTM0,HMSRSTQ0,HMSRSTM0,HMORSTQ0,HMORSTM0,HMORSTM00,
	HMPPLNQ1,HMPPLNM1,HMSPLNQ1,HMSPLNM1,HMOPLNQ1,HMOPLNM1,
	HMPPLNQ2,HMPPLNM2,HMSPLNQ2,HMSPLNM2,HMOPLNQ2,HMOPLNM2,
	HMPPLNQ3,HMPPLNM3,HMSPLNQ3,HMSPLNM3,HMOPLNQ3,HMOPLNM3,
	HMPPLNQ4,HMPPLNM4,HMSPLNQ4,HMSPLNM4,HMOPLNQ4,HMOPLNM4,
	HMPPLNQ5,HMPPLNM5,HMSPLNQ5,HMSPLNM5,HMOPLNQ5,HMOPLNM5,
	HMPPLNQ6,HMPPLNM6,HMSPLNQ6,HMSPLNM6,HMOPLNQ6,HMOPLNM6,
	HMPPLNQ7,HMPPLNM7,HMSPLNQ7,HMSPLNM7,HMOPLNQ7,HMOPLNM7,
	HMPPLNQ8,HMPPLNM8,HMSPLNQ8,HMSPLNM8,HMOPLNQ8,HMOPLNM8,
	HMPPLNQ9,HMPPLNM9,HMSPLNQ9,HMSPLNM9,HMOPLNQ9,HMOPLNM9,
	HMPPLNQ10,HMPPLNM10,HMSPLNQ10,HMSPLNM10,HMOPLNQ10,HMOPLNM10,
	HMPPLNQ11,HMPPLNM11,HMSPLNQ11,HMSPLNM11,HMOPLNQ11,HMOPLNM11,
	HMPPLNQ12,HMPPLNM12,HMSPLNQ12,HMSPLNM12,HMOPLNQ12,HMOPLNM12 )
SELECT b.xplant, b.div, b.itno, b.pdcd, a.itnm, 
	case when b.cls = '30' then ' ' when b.srce = '03' then 'A' else 'B' end,
	ifnull(f.davcst,ifnull(c.hcost,0)),ifnull(c.hypplnq,0),ifnull(c.hypplnm,0),ifnull(c.hyprstq,0)+d.apdqa+d.apdqr,ifnull(c.hyprstm,0),
	ifnull(c.hmpplnq0,0),ifnull(c.hmpplnm0,0),
//	ifnull((select bqtyd01 + bqtye01 from pbmps.mps002 where bcmcd = '01' and bplant = b.xplant and
//		bdvsn = b.div and bitno = b.itno and byear||bmonth = :ls_last_month),0),
//	ifnull((select bamtd01 + bamte01 from pbmps.mps002 where bcmcd = '01' and bplant = b.xplant and
//		bdvsn = b.div and bitno = b.itno and byear||bmonth = :ls_last_month),0),
   ifnull(g.bqtyd01 + g.bqtye01,0),
	ifnull(g.bamtd01 + g.bamte01,0),
	(d.apdqa+d.apdqr),(d.apdqa+d.apdqr)*ifnull(c.hcost,b.saud),(d.aslqa+d.aslqr),(d.aslqa+d.aslqr)*ifnull(c.hcost,b.saud),d.aohqt,d.aohqt*ifnull(c.hcost,b.saud),d.aohqt*ifnull(f.davcst,0),
	ifnull(f.dplnq01,0),ifnull(f.dplnq01*f.davcst,0),ifnull((e.bqtyd01+e.bqtye01),0),ifnull((e.bqtyd01+e.bqtye01)*f.davcst,0), 0, 0,
	ifnull(f.dplnq02,0),ifnull(f.dplnq02*f.davcst,0),ifnull((e.bqtyd02+e.bqtye02),0),ifnull((e.bqtyd02+e.bqtye02)*f.davcst,0), 0, 0,
	ifnull(f.dplnq03,0),ifnull(f.dplnq03*f.davcst,0),ifnull((e.bqtyd03+e.bqtye03),0),ifnull((e.bqtyd03+e.bqtye03)*f.davcst,0), 0, 0,
	ifnull(f.dplnq04,0),ifnull(f.dplnq04*f.davcst,0),ifnull((e.bqtyd04+e.bqtye04),0),ifnull((e.bqtyd04+e.bqtye04)*f.davcst,0), 0, 0,
	ifnull(f.dplnq05,0),ifnull(f.dplnq05*f.davcst,0),ifnull((e.bqtyd05+e.bqtye05),0),ifnull((e.bqtyd05+e.bqtye05)*f.davcst,0), 0, 0,
	ifnull(f.dplnq06,0),ifnull(f.dplnq06*f.davcst,0),ifnull((e.bqtyd06+e.bqtye06),0),ifnull((e.bqtyd06+e.bqtye06)*f.davcst,0), 0, 0,
	ifnull(f.dplnq07,0),ifnull(f.dplnq07*f.davcst,0),ifnull((e.bqtyd07+e.bqtye07),0),ifnull((e.bqtyd07+e.bqtye07)*f.davcst,0), 0, 0,
	ifnull(f.dplnq08,0),ifnull(f.dplnq08*f.davcst,0),ifnull((e.bqtyd08+e.bqtye08),0),ifnull((e.bqtyd08+e.bqtye08)*f.davcst,0), 0, 0,
	ifnull(f.dplnq09,0),ifnull(f.dplnq09*f.davcst,0),ifnull((e.bqtyd09+e.bqtye09),0),ifnull((e.bqtyd09+e.bqtye09)*f.davcst,0), 0, 0,
	ifnull(f.dplnq10,0),ifnull(f.dplnq10*f.davcst,0),ifnull((e.bqtyd10+e.bqtye10),0),ifnull((e.bqtyd10+e.bqtye10)*f.davcst,0), 0, 0,
	ifnull(f.dplnq11,0),ifnull(f.dplnq11*f.davcst,0),ifnull((e.bqtyd11+e.bqtye11),0),ifnull((e.bqtyd11+e.bqtye11)*f.davcst,0), 0, 0,
	ifnull(f.dplnq12,0),ifnull(f.dplnq12*f.davcst,0),ifnull((e.bqtyd12+e.bqtye12),0),ifnull((e.bqtyd12+e.bqtye12)*f.davcst,0), 0, 0
FROM PBINV.INV002 a INNER JOIN PBINV.INV101 b
	ON a.comltd = b.comltd AND a.itno = b.itno
// ** 모델별 생산출하
	LEFT OUTER JOIN (SELECT comltd, xplant, div, itno, 
		sum(case when xyear = :ls_last_month then costp else 0 end) as hcost,
		sum(case when xyear = :ls_last_month then rpyq else 0 end) as hypplnq,
		sum(case when xyear = :ls_last_month then rpya else 0 end) as hypplnm,
		sum(case when xyear = :ls_last_twomonth then syqt else 0 end) as hyprstq,
		sum(case when xyear = :ls_last_twomonth then syat else 0 end) as hyprstm,
		sum(case when xyear = :ls_last_month then rpmq else 0 end) as hmpplnq0,
		sum(case when xyear = :ls_last_month then rpma else 0 end) as hmpplnm0
		FROM PBINV.PCS101
		WHERE comltd = :g_s_company AND xplant = :ag_plant AND div = :ag_dvsn AND 
			cust = '' and xyear >= :ls_last_twomonth AND xyear <= :ls_last_month 
		GROUP BY comltd, xplant, div, itno) c
	ON b.comltd = c.comltd AND b.xplant = c.xplant AND
		b.div = c.div AND b.itno = c.itno
// ** 생산계획기준정보
	INNER JOIN PBMPS.MPS001 d
	ON b.comltd = d.acmcd AND b.xplant = d.aplant AND
		b.div = d.advsn AND b.itno = d.aitno
// ** 품목별 판매계획
	LEFT OUTER JOIN PBMPS.MPS002 e
	ON d.acmcd = e.bcmcd AND d.aplant = e.bplant AND
		d.advsn = e.bdvsn AND d.aitno = e.bitno AND
		e.byear = :ls_that_yyyy AND e.bmonth = :ls_that_mm
// ** 월간생산계획
	LEFT OUTER JOIN PBMPS.MPS004 f
	ON d.acmcd = f.dcmcd AND d.aplant = f.dplant AND
		d.advsn = f.ddvsn AND d.aitno = f.ditno AND
		f.dyear = :ls_that_yyyy AND f.dmonth = :ls_that_mm
	LEFT OUTER JOIN PBMPS.MPS002 g
	ON d.acmcd = g.bcmcd AND d.aplant = g.bplant AND
		d.advsn = g.bdvsn AND d.aitno = g.bitno AND
		g.byear = :ls_last_yyyy AND g.bmonth = :ls_last_mm
WHERE b.comltd = '01' and b.xplant = :ag_plant and
		b.div = :ag_dvsn and b.cls <> '35'
using sqlca;

// ** M+ 월재고 계획수량 업데이트
UPDATE PBMPS.MPST03
SET Hyprstm = Hyprstm + Hmprstm0,
    Hmoplnq1 = CASE WHEN (Hmorstq0 + Hmpplnq1 - Hmsplnq1) < 0 THEN 0 ELSE (Hmorstq0 + Hmpplnq1 - Hmsplnq1) END,
    Hmoplnm1 = CASE WHEN (Hmorstm0 + Hmpplnm1 - Hmsplnm1) < 0 THEN 0 ELSE
	 					(Hmorstm0 + Hmpplnm1 - Hmsplnm1) END,
	 Hmoplnq2 = CASE WHEN ((Hmorstq0 + Hmpplnq1 - Hmsplnq1) + Hmpplnq2 - Hmsplnq2) < 0 THEN 0 ELSE
	 	((Hmorstq0 + Hmpplnq1 - Hmsplnq1) + Hmpplnq2 - Hmsplnq2) END,
    Hmoplnm2 = CASE WHEN ((Hmorstm0 + Hmpplnm1 - Hmsplnm1) + Hmpplnm2 - Hmsplnm2) < 0 THEN 0 ELSE
	 	((Hmorstm0 + Hmpplnm1 - Hmsplnm1) + Hmpplnm2 - Hmsplnm2) END,
	 Hmoplnq3 = CASE WHEN (((Hmorstq0 + Hmpplnq1 - Hmsplnq1) + Hmpplnq2 - Hmsplnq2) + Hmpplnq3 - Hmsplnq3) < 0 THEN 0 ELSE
	 	(((Hmorstq0 + Hmpplnq1 - Hmsplnq1) + Hmpplnq2 - Hmsplnq2) + Hmpplnq3 - Hmsplnq3) END,
    Hmoplnm3 = CASE WHEN (((Hmorstm0 + Hmpplnm1 - Hmsplnm1) + Hmpplnm2 - Hmsplnm2) + Hmpplnm3 - Hmsplnm3) < 0 THEN 0 ELSE
	 	(((Hmorstm0 + Hmpplnm1 - Hmsplnm1) + Hmpplnm2 - Hmsplnm2) + Hmpplnm3 - Hmsplnm3) END
WHERE Hplant = :ag_plant AND Hdiv = :ag_dvsn
using sqlca;

UPDATE PBMPS.MPST03
SET Hmoplnq4 = CASE WHEN (Hmoplnq3 + Hmpplnq4 - Hmsplnq4) < 0 THEN 0 ELSE
		(Hmoplnq3 + Hmpplnq4 - Hmsplnq4) END,
    Hmoplnm4 = CASE WHEN (Hmoplnm3 + Hmpplnm4 - Hmsplnm4) < 0 THEN 0 ELSE
	 	(Hmoplnm3 + Hmpplnm4 - Hmsplnm4) END,
	 Hmoplnq5 = CASE WHEN ((Hmoplnq3 + Hmpplnq4 - Hmsplnq4) + Hmpplnq5 - Hmsplnq5) < 0 THEN 0 ELSE
	 	((Hmoplnq3 + Hmpplnq4 - Hmsplnq4) + Hmpplnq5 - Hmsplnq5) END,
    Hmoplnm5 = CASE WHEN ((Hmoplnm3 + Hmpplnm4 - Hmsplnm4) + Hmpplnm5 - Hmsplnm5) < 0 THEN 0 ELSE
	 	((Hmoplnm3 + Hmpplnm4 - Hmsplnm4) + Hmpplnm5 - Hmsplnm5) END,
	 Hmoplnq6 = CASE WHEN (((Hmoplnq3 + Hmpplnq4 - Hmsplnq4) + Hmpplnq5 - Hmsplnq5) + Hmpplnq6 - Hmsplnq6) < 0 THEN 0 ELSE
	 	(((Hmoplnq3 + Hmpplnq4 - Hmsplnq4) + Hmpplnq5 - Hmsplnq5) + Hmpplnq6 - Hmsplnq6) END,
    Hmoplnm6 = CASE WHEN (((Hmoplnm3 + Hmpplnm4 - Hmsplnm4) + Hmpplnm5 - Hmsplnm5) + Hmpplnm6 - Hmsplnm6) < 0 THEN 0 ELSE
	 	(((Hmoplnm3 + Hmpplnm4 - Hmsplnm4) + Hmpplnm5 - Hmsplnm5) + Hmpplnm6 - Hmsplnm6) END
WHERE Hplant = :ag_plant AND Hdiv = :ag_dvsn
using sqlca;

UPDATE PBMPS.MPST03
SET Hmoplnq7 = CASE WHEN (Hmoplnq6 + Hmpplnq7 - Hmsplnq7) < 0 THEN 0 ELSE
		(Hmoplnq6 + Hmpplnq7 - Hmsplnq7) END,
    Hmoplnm7 = CASE WHEN (Hmoplnm6 + Hmpplnm7 - Hmsplnm7) < 0 THEN 0 ELSE
	 	(Hmoplnm6 + Hmpplnm7 - Hmsplnm7) END,
	 Hmoplnq8 = CASE WHEN ((Hmoplnq6 + Hmpplnq7 - Hmsplnq7) + Hmpplnq8 - Hmsplnq8) < 0 THEN 0 ELSE
	 	((Hmoplnq6 + Hmpplnq7 - Hmsplnq7) + Hmpplnq8 - Hmsplnq8) END,
    Hmoplnm8 = CASE WHEN ((Hmoplnm6 + Hmpplnm7 - Hmsplnm7) + Hmpplnm8 - Hmsplnm8) < 0 THEN 0 ELSE
	 	((Hmoplnm6 + Hmpplnm7 - Hmsplnm7) + Hmpplnm8 - Hmsplnm8) END,
	 Hmoplnq9 = CASE WHEN (((Hmoplnq6 + Hmpplnq7 - Hmsplnq7) + Hmpplnq8 - Hmsplnq8) + Hmpplnq9 - Hmsplnq9) < 0 THEN 0 ELSE
	 	(((Hmoplnq6 + Hmpplnq7 - Hmsplnq7) + Hmpplnq8 - Hmsplnq8) + Hmpplnq9 - Hmsplnq9) END,
    Hmoplnm9 = CASE WHEN (((Hmoplnm6 + Hmpplnm7 - Hmsplnm7) + Hmpplnm8 - Hmsplnm8) + Hmpplnm9 - Hmsplnm9) < 0 THEN 0 ELSE
	 	(((Hmoplnm6 + Hmpplnm7 - Hmsplnm7) + Hmpplnm8 - Hmsplnm8) + Hmpplnm9 - Hmsplnm9) END
WHERE Hplant = :ag_plant AND Hdiv = :ag_dvsn
using sqlca;

UPDATE PBMPS.MPST03
SET Hmoplnq10 = CASE WHEN (Hmoplnq9 + Hmpplnq10 - Hmsplnq10) < 0 THEN 0 ELSE
		(Hmoplnq9 + Hmpplnq10 - Hmsplnq10) END,
    Hmoplnm10 = CASE WHEN (Hmoplnm9 + Hmpplnm10 - Hmsplnm10) < 0 THEN 0 ELSE
	 	(Hmoplnm9 + Hmpplnm10 - Hmsplnm10) END,
	 Hmoplnq11 = CASE WHEN ((Hmoplnm9 + Hmpplnm10 - Hmsplnm10) + Hmpplnq11 - Hmsplnq11) < 0 THEN 0 ELSE
	 	((Hmoplnm9 + Hmpplnm10 - Hmsplnm10) + Hmpplnq11 - Hmsplnq11) END,
    Hmoplnm11 = CASE WHEN ((Hmoplnm9 + Hmpplnm10 - Hmsplnm10) + Hmpplnm11 - Hmsplnm11) < 0 THEN 0 ELSE
	 	((Hmoplnm9 + Hmpplnm10 - Hmsplnm10) + Hmpplnm11 - Hmsplnm11) END,
	 Hmoplnq12 = CASE WHEN (((Hmoplnm9 + Hmpplnm10 - Hmsplnm10) + Hmpplnq11 - Hmsplnq11) + Hmpplnq12 - Hmsplnq12) < 0 THEN 0 ELSE
	 	(((Hmoplnm9 + Hmpplnm10 - Hmsplnm10) + Hmpplnq11 - Hmsplnq11) + Hmpplnq12 - Hmsplnq12) END,
    Hmoplnm12 = CASE WHEN (((Hmoplnm9 + Hmpplnm10 - Hmsplnm10) + Hmpplnm11 - Hmsplnm11) + Hmpplnm12 - Hmsplnm12) < 0 THEN 0 ELSE
	 	(((Hmoplnm9 + Hmpplnm10 - Hmsplnm10) + Hmpplnm11 - Hmsplnm11) + Hmpplnm12 - Hmsplnm12) END
WHERE Hplant = :ag_plant AND Hdiv = :ag_dvsn
using sqlca;


return 0
end function

on w_mps_103i.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.dw_2=create dw_2
this.uo_2=create uo_2
this.st_1=create st_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.uo_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_1
end on

on w_mps_103i.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.dw_2)
destroy(this.uo_2)
destroy(this.st_1)
destroy(this.cb_1)
end on

event ue_retrieve;call super::ue_retrieve;string mysql,l_s_docname,l_s_named,l_s_parm
integer ln_count,l_n_yesno

setpointer(hourglass!)

wf_return()
//if mid(f_get_mps007(g_s_company,is_xplant,is_div,i_s_date),9,1) <> 'C' then
//	messagebox("확인","생산계획 확정 후 조회 & Download 가능" )
//	cb_1.enabled = true
//	return 0
//end if

//delete from pbmps.mpst03
//	where hplant = :is_xplant and hdiv = :is_div 
//using sqlca ;
//
//l_s_parm  = is_date + is_xplant + is_div + '1'
//declare mps_crt procedure for pbmps.f_mps_01 ('PBMPS','W_MPS004',:l_s_parm) ;
//execute mps_crt ;  

wf_create_mpst03(is_date,is_xplant,is_div)

ln_count	=	dw_2.retrieve(is_xplant,is_div)
if  ln_count	<= 0 then
	uo_status.st_message.text = f_message("I020")
else
	wf_modify_dw()
	uo_status.st_message.text = string(ln_count) + ' 개의 정보가 조회되었습니다'
   	l_n_yesno = messagebox("확인","Excel 파일로 저장 하시겠습니까 ?",question!, yesno!,2 )
	if l_n_yesno = 1 then
		f_save_to_Excel_execute(dw_2,'1')
	end if
end if



end event

type uo_status from w_origin_sheet01`uo_status within w_mps_103i
end type

type uo_1 from uo_plandiv_bom within w_mps_103i
integer x = 32
integer y = 8
integer taborder = 20
boolean bringtotop = true
end type

on uo_1.destroy
call uo_plandiv_bom::destroy
end on

type dw_2 from datawindow within w_mps_103i
integer x = 50
integer y = 144
integer width = 4553
integer height = 2328
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_mpst03_new"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(Sqlca)
end event

type uo_2 from uo_ccyymm_mps within w_mps_103i
integer x = 1605
integer y = 28
integer taborder = 30
boolean bringtotop = true
end type

on uo_2.destroy
call uo_ccyymm_mps::destroy
end on

type st_1 from statictext within w_mps_103i
integer x = 1317
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

type cb_1 from commandbutton within w_mps_103i
integer x = 3794
integer y = 36
integer width = 805
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = hangeul!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "굴림체"
string text = "생산계획 확정 및 취소"
end type

event clicked;setpointer(hourglass!)
wf_return()
long l_n_count
integer ln_yesno
string ls_status

ls_status = f_get_mps007(g_s_company,is_xplant,is_div,is_date)
if f_spacechk(ls_status) = -1 then
	messagebox("확인","현재 생산계획 확정 및 취소가 불가능한 상태입니다.")
	return 0
end if
if mid(ls_status,9,1) = 'C' then
	ln_yesno = messagebox("확인","생산계획이 이미 확정됐습니다.확정취소하시겠습니까 ?",question!, yesno!,1 )
   if ln_yesno = 1 then
		f_mps007_update(is_xplant,is_div,is_date,'N')
		messagebox("확인","생산계획 확정취소 완료")
	end if
	return 0
end if
f_mps007_update(is_xplant,is_div,is_date,'C')
messagebox("확인","생산계획 확정 완료")
select count(*) into :l_n_count from pbmps.mps007
	where zstscd <> 'C' and zcmcd = :g_s_company and zyear = :is_date and zpgmid = 'MPSU06' 
using sqlca ;
if l_n_count = 0 or isnull(l_n_count) then
	select count(*) into :l_n_count from pbipis.jit002
		where edate = :is_date
	using sqlca ;
	if l_n_count = 0 or isnull(l_n_count) then
		insert into pbipis.jit002
		  ( select dcmcd,dplant,ddvsn,ditno,:is_date,dplnq01,dplnq01 from pbmps.mps004
		  		where dyear || dmonth = :is_date and dplant <> 'K' and dcmcd = :g_s_company )
		using sqlca ;
		if sqlca.sqlcode <> 0 then
			messagebox("확인",sqlca.sqlerrtext)
		else
			messagebox("확인","JIT002 Insert 성공")
		end if
	end if
end if

end event

