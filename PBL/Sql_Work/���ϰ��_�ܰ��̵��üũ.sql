select distinct zplant,zdiv,zmdcd, zmdno, zitno, zdesc, zsrce, zygchk, 
zmovcost, zrcpcost, zoutcost, zscmovcost, zscrcpcost, zscoutcost from pbpdm.bom113d
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 ))
order by zplant,zdiv,zmdcd, zmdno, zitno;



select distinct zplant,zdiv,zmdcd, zmdno, zitno, zdesc, zsrce, zygchk, 
zmovcost, zrcpcost, zoutcost, zscmovcost, zscrcpcost, zscoutcost,
case when zygchk = 'Y' then 
	( select max(coalesce(sum(a.gcost + a.mcost),0))
     from pbpur.pur103a a  inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
        where a.comltd = '01' and  a.itno = zitno
        and  b.xstop = 'O' and  a.gcost <> 0) )
else 
	case when zsrce = '01' then
		select max(ecost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O'
	else
		select max(dcost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O'
	end 
end as pur_cost 
from pbpdm.bom113d
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 ))
order by zplant,zdiv,zmdcd, zmdno, zitno;



select distinct zplant, zdiv, zmdcd, zmdno,zitno, zdesc, zsrce, zygchk, 
zmovcost, zrcpcost, zoutcost, zscmovcost, zscrcpcost, zscoutcost,
case when zygchk = 'Y' then 
	 ( select decimal(
      (select coalesce(sum(a.gcost + a.mcost),0)
     from pbpur.pur103a a  inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
        where a.comltd = '01' and  a.itno = zitno
        and  b.xstop = 'O' and  a.gcost <> 0)
      / case when
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
        on a.comltd = b.comltd and a.dept = b.dept and
          a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0) = 0 then 1
        else
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0)
        end,15,6)
    from pbcommon.comm000 )
else 
	case when zsrce = '01' then
		( select max(ecost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	else
		( select max(dcost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	end 
end as pur_cost 
from pbpdm.bom113d, ( SELECT PCDIV,//회계사업부
     SUBSTR(A.PCDIV,1,1)  as area ,//지역
     CASE  WHEN SUBSTR(A.PCDIV,1,1) ='Y' THEN 'Y'
     ELSE CASE  SUBSTR(A.PCDIV,2,1)  WHEN 'E' THEN 'A' 
          WHEN 'D' THEN 'Y' 
          ELSE CASE WHEN  IFNULL(B.DIV,'')=''  THEN SUBSTR(A.PCDIV,2,1) ELSE B.DIV END END END  AS PLANT,//공장
         	PCPRCD1, //제품군
         	PCITNO ,// 품번 
         	PCMATS  // 유상출고재료비
			 FROM PBACC.PCC140 A LEFT OUTER JOIN PBACC.ACC060 B
                       ON  A.COMLTD = B.COMLTD AND 
                           A.PCDIV = B.ACCDIV AND 
                           A.PCPRCD1 = B.PDCD AND 
                           B.PDCD <>'' 
			WHERE A.COMLTD = :g_s_company and //회사코드 
      		A.PCGUBUN = '2' AND 
      		A.PCYY||A.PCMM= '201204' ) tmp_acc
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 ))
order by zplant, zdiv, zmdcd, zmdno, zitno;


***
select distinct tmp_bom.zplant, tmp_bom.zdiv, tmp_bom.zmdcd, tmp_bom.zmdno,tmp_bom.zitno, 
tmp_109d.ftmcst, tmp_109d.ftrcst, tmp_109d.ftacst,
tmp_acc.pcmats,
tmp_bom.zdesc, tmp_bom.zsrce, tmp_bom.zygchk, 
tmp_bom.zmovcost, tmp_bom.zrcpcost, tmp_bom.zoutcost, 
tmp_bom.zscmovcost, tmp_bom.zscrcpcost, tmp_bom.zscoutcost,
case when tmp_bom.zygchk = 'Y' then 
	 ( select decimal(
      (select coalesce(sum(a.gcost + a.mcost),0)
     from pbpur.pur103a a  inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
        where a.comltd = '01' and  a.itno = zitno
        and  b.xstop = 'O' and  a.gcost <> 0)
      / case when
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
        on a.comltd = b.comltd and a.dept = b.dept and
          a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0) = 0 then 1
        else
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0)
        end,15,6)
    from pbcommon.comm000 )
else 
	case when zsrce = '01' then
		( select max(ecost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	else
		( select max(dcost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	end 
end as pur_cost 
from pbpdm.bom113d tmp_bom inner join pbpdm.bom109d tmp_109d
	on tmp_bom.zcmcd = tmp_109d.fcmcd and tmp_109d.fgubun = 'B' and
		tmp_bom.zdate = tmp_109d.fdate and tmp_bom.zplant = tmp_109d.fplant and
		tmp_bom.zdiv = tmp_109d.fdvsn and tmp_bom.zmdno = tmp_109d.fmdno
	left outer join ( SELECT PCDIV,//회계사업부
     SUBSTR(A.PCDIV,1,1)  as PCAREA ,//지역
     CASE  WHEN SUBSTR(A.PCDIV,1,1) ='Y' THEN 'Y'
     ELSE CASE  SUBSTR(A.PCDIV,2,1)  WHEN 'E' THEN 'A' 
          WHEN 'D' THEN 'Y' 
          ELSE CASE WHEN  IFNULL(B.DIV,'')=''  THEN SUBSTR(A.PCDIV,2,1) ELSE B.DIV END END END  AS PCPLANT,//공장
         	PCPRCD1, //제품군
         	PCITNO ,// 품번 
         	PCMATS  // 유상출고재료비
			 FROM PBACC.PCC140 A LEFT OUTER JOIN PBACC.ACC060 B
                       ON  A.COMLTD = B.COMLTD AND 
                           A.PCDIV = B.ACCDIV AND 
                           A.PCPRCD1 = B.PDCD AND 
                           B.PDCD <>'' 
			WHERE A.COMLTD = '01' and //회사코드 
      		A.PCGUBUN = '2' AND 
      		A.PCYY||A.PCMM= '201204' ) tmp_acc
	on tmp_bom.zplant = tmp_acc.pcarea and tmp_bom.zdiv = tmp_acc.pcplant and
		tmp_bom.zmdno = tmp_acc.pcitno
where tmp_bom.zcmcd = '01' and tmp_bom.zdate = '20120517' and tmp_bom.zsrce in ('01','02','04') and 
(( tmp_bom.zygchk = 'Y' and (tmp_bom.zscmovcost + tmp_bom.zscrcpcost + tmp_bom.zscoutcost) = 0 ) or 
( tmp_bom.zygchk <> 'Y' and (tmp_bom.zmovcost + tmp_bom.zrcpcost + tmp_bom.zoutcost) = 0 ))
order by tmp_bom.zplant, tmp_bom.zdiv, tmp_bom.zmdcd, tmp_bom.zmdno, tmp_bom.zitno;


-- 완제품 내역 재료비, 실적재료비 가져오기
select tmp_113d.zcmcd,tmp_113d.zdate,tmp_113d.zplant,tmp_113d.zdiv,tmp_113d.zmdcd,tmp_113d.zmdno,
tmp_109d.ftmcst, tmp_109d.ftrcst, tmp_109d.ftacst,tmp_acc.pcmats
from 
( select distinct zcmcd,zdate,zplant,zdiv,zmdcd, zmdno from pbpdm.bom113d
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 )) ) tmp_113d
inner join pbpdm.bom109d tmp_109d
on tmp_113d.zcmcd = tmp_109d.fcmcd and tmp_109d.fgubun = 'B' and
		tmp_113d.zdate = tmp_109d.fdate and tmp_113d.zplant = tmp_109d.fplant and
		tmp_113d.zdiv = tmp_109d.fdvsn and tmp_113d.zmdcd = tmp_109d.fpdcd and 
		tmp_113d.zmdno = tmp_109d.fmdno
left outer join ( SELECT PCDIV,--회계사업부
     SUBSTR(A.PCDIV,1,1)  as PCAREA ,--지역
     CASE  WHEN SUBSTR(A.PCDIV,1,1) ='Y' THEN 'Y'
     ELSE CASE  SUBSTR(A.PCDIV,2,1)  WHEN 'E' THEN 'A' 
          WHEN 'D' THEN 'Y' 
          ELSE CASE WHEN  IFNULL(B.DIV,'')=''  THEN SUBSTR(A.PCDIV,2,1) ELSE B.DIV END END END  AS PCPLANT,--공장
         	PCPRCD1, --제품군
         	PCITNO ,-- 품번 
         	PCMATS  -- 유상출고재료비
			 FROM PBACC.PCC140 A LEFT OUTER JOIN PBACC.ACC060 B
                       ON  A.COMLTD = B.COMLTD AND 
                           A.PCDIV = B.ACCDIV AND 
                           A.PCPRCD1 = B.PDCD AND 
                           B.PDCD <>'' 
			WHERE A.COMLTD = '01' and --회사코드 
      		A.PCGUBUN = '2' AND 
      		A.PCYY||A.PCMM= '201204' ) tmp_acc
	on tmp_113d.zplant = tmp_acc.pcarea and tmp_113d.zdiv = tmp_acc.pcplant and
		tmp_113d.zmdno = tmp_acc.pcitno;
		
-- final 
select tmp_bom.zplant, tmp_bom.zdiv, tmp_bom.zmdcd, tmp_bom.zmdno,tmp_bom.zitno, 
tmp_mcost.ftmcst, tmp_mcost.ftrcst, tmp_mcost.ftacst,
tmp_mcost.pcmats,
tmp_bom.zdesc, tmp_bom.zsrce, tmp_bom.zygchk, 
tmp_bom.zmovcost, tmp_bom.zrcpcost, tmp_bom.zoutcost, 
tmp_bom.zscmovcost, tmp_bom.zscrcpcost, tmp_bom.zscoutcost,
tmp_bom.pur_cost 
from ( select distinct zcmcd, zdate, zplant, zdiv, zmdcd, zmdno,zitno, 
zdesc, zsrce, zygchk, zmovcost, zrcpcost, zoutcost, 
zscmovcost, zscrcpcost, zscoutcost,
case when zygchk = 'Y' then 
	 ( select decimal(
      (select coalesce(sum(a.gcost + a.mcost),0)
     from pbpur.pur103a a  inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
        where a.comltd = '01' and  a.itno = zitno
        and  b.xstop = 'O' and  a.gcost <> 0)
      / case when
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
        on a.comltd = b.comltd and a.dept = b.dept and
          a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0) = 0 then 1
        else
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0)
        end,15,6)
    from pbcommon.comm000 )
else 
	case when zsrce = '01' then
		( select max(ecost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	else
		( select max(dcost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	end 
end as pur_cost  
from pbpdm.bom113d
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 ))) tmp_bom,

( select tmp_113d.zcmcd as zcmcd,tmp_113d.zdate as zdate,tmp_113d.zplant as zplant,
tmp_113d.zdiv as zdiv,tmp_113d.zmdcd as zmdcd,tmp_113d.zmdno as zmdno,
tmp_109d.ftmcst as ftmcst, tmp_109d.ftrcst as ftrcst, tmp_109d.ftacst as ftacst,tmp_acc.pcmats as pcmats
from 
( select distinct zcmcd,zdate,zplant,zdiv,zmdcd, zmdno from pbpdm.bom113d
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 )) ) tmp_113d
inner join pbpdm.bom109d tmp_109d
on tmp_113d.zcmcd = tmp_109d.fcmcd and tmp_109d.fgubun = 'B' and
		tmp_113d.zdate = tmp_109d.fdate and tmp_113d.zplant = tmp_109d.fplant and
		tmp_113d.zdiv = tmp_109d.fdvsn and tmp_113d.zmdcd = tmp_109d.fpdcd and 
		tmp_113d.zmdno = tmp_109d.fmdno
left outer join ( SELECT PCDIV,--회계사업부
     SUBSTR(A.PCDIV,1,1)  as PCAREA ,--지역
     CASE  WHEN SUBSTR(A.PCDIV,1,1) ='Y' THEN 'Y'
     ELSE CASE  SUBSTR(A.PCDIV,2,1)  WHEN 'E' THEN 'A' 
          WHEN 'D' THEN 'Y' 
     ELSE CASE WHEN  IFNULL(B.DIV,'')=''  THEN SUBSTR(A.PCDIV,2,1) ELSE B.DIV END END END  AS PCPLANT,--공장
         	PCPRCD1, --제품군
         	PCITNO ,-- 품번 
         	PCMATS  -- 유상출고재료비
			 FROM PBACC.PCC140 A LEFT OUTER JOIN PBACC.ACC060 B
                       ON  A.COMLTD = B.COMLTD AND 
                           A.PCDIV = B.ACCDIV AND 
                           A.PCPRCD1 = B.PDCD AND 
                           B.PDCD <>'' 
			WHERE A.COMLTD = '01' and --회사코드 
      		A.PCGUBUN = '2' AND 
      		A.PCYY||A.PCMM= '201204' ) tmp_acc
	on tmp_113d.zplant = tmp_acc.pcarea and tmp_113d.zdiv = tmp_acc.pcplant and
		tmp_113d.zmdno = tmp_acc.pcitno ) tmp_mcost
where tmp_bom.zcmcd = tmp_mcost.zcmcd and tmp_bom.zdate = tmp_mcost.zdate and 
	 tmp_bom.zplant = tmp_mcost.zplant and tmp_bom.zdiv = tmp_mcost.zdiv and 
    tmp_bom.zmdcd = tmp_mcost.zmdcd and tmp_bom.zmdno = tmp_mcost.zmdno
order by tmp_bom.zplant, tmp_bom.zdiv, tmp_bom.zmdcd, tmp_bom.zmdno, tmp_bom.zitno;



-- final MODIFIED 01
select tmp_bom.zplant, tmp_bom.zdiv, tmp_bom.zmdcd, tmp_bom.zmdno,tmp_bom.zitno, 
tmp_109d.ftmcst, tmp_109d.ftrcst, tmp_109d.ftacst,
tmp_acc.pcmats,
tmp_bom.zdesc, tmp_bom.zsrce, tmp_bom.zygchk, 
tmp_bom.zmovcost, tmp_bom.zrcpcost, tmp_bom.zoutcost, 
tmp_bom.zscmovcost, tmp_bom.zscrcpcost, tmp_bom.zscoutcost,
tmp_bom.pur_cost 
from ( select distinct zcmcd, zdate, zplant, zdiv, PBINV.SF_ACCDIV(zplant,zdiv,zmdcd) as accdiv,zmdcd, zmdno,zitno, 
zdesc, zsrce, zygchk, zmovcost, zrcpcost, zoutcost, 
zscmovcost, zscrcpcost, zscoutcost,
case when zygchk = 'Y' then 
	 ( select decimal(
      (select coalesce(sum(a.gcost + a.mcost),0)
     from pbpur.pur103a a  inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
        where a.comltd = '01' and  a.itno = zitno
        and  b.xstop = 'O' and  a.gcost <> 0)
      / case when
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
        on a.comltd = b.comltd and a.dept = b.dept and
          a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0) = 0 then 1
        else
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0)
        end,15,6)
    from pbcommon.comm000 )
else 
	case when zsrce = '01' then
		( select max(ecost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	else
		( select max(dcost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	end 
end as pur_cost  
from pbpdm.bom113d
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 ))) tmp_bom inner join pbpdm.bom109d tmp_109d
on tmp_bom.zcmcd = tmp_109d.fcmcd and tmp_109d.fgubun = 'B' and tmp_109d.fdate = '20120517' and 
   tmp_bom.zplant = tmp_109d.fplant and tmp_bom.zdiv = tmp_109d.fdvsn and 
   tmp_bom.zmdcd = tmp_109d.fpdcd and tmp_bom.zmdno = tmp_109d.fmdno
left outer join ( SELECT PCDIV, --회계사업부
     SUBSTR(A.PCDIV,1,1)  as PCAREA , --지역
     CASE  WHEN SUBSTR(A.PCDIV,1,1) ='Y' THEN 'Y'
     ELSE CASE  SUBSTR(A.PCDIV,2,1)  WHEN 'E' THEN 'A' 
          WHEN 'D' THEN 'Y' 
     ELSE CASE WHEN  IFNULL(B.DIV,'')=''  THEN SUBSTR(A.PCDIV,2,1) ELSE B.DIV END END END  AS PCPLANT,--공장
         	PCPRCD1, --제품군
         	PCITNO , -- 품번 
         	PCMATS   -- 유상출고재료비
			 FROM PBACC.PCC140 A LEFT OUTER JOIN PBACC.ACC060 B
                       ON  A.COMLTD = B.COMLTD AND 
                           A.PCDIV = B.ACCDIV AND 
                           A.PCPRCD1 = B.PDCD AND 
                           B.PDCD <>'' 
			WHERE A.COMLTD = '01' and --회사코드 
      		A.PCGUBUN = '2' AND 
      		A.PCYY||A.PCMM= '201204' ) tmp_acc
	on tmp_bom.zplant = tmp_acc.pcarea and tmp_bom.zdiv = tmp_acc.pcplant and
		tmp_bom.zmdno = tmp_acc.pcitno
order by tmp_bom.zplant, tmp_bom.zdiv, tmp_bom.zmdcd, tmp_bom.zmdno, tmp_bom.zitno;



-- final MODIFIED 02
select tmp_bom.zplant, tmp_bom.zdiv, tmp_bom.zmdcd, tmp_bom.zmdno,tmp_bom.zitno, 
tmp_109d.ftmcst, tmp_109d.ftrcst, tmp_109d.ftacst,
(select A.PCMATS from PBACC.PCC140 A where A.COMLTD = '01' and A.PCDIV = tmp_bom.accdiv and
      		A.PCGUBUN = '2' AND A.PCITNO = tmp_bom.zmdno and
      		A.PCYY||A.PCMM= '201204' ) pcmats,
tmp_bom.zdesc, tmp_bom.zsrce, tmp_bom.zygchk, 
tmp_bom.zmovcost, tmp_bom.zrcpcost, tmp_bom.zoutcost, 
tmp_bom.zscmovcost, tmp_bom.zscrcpcost, tmp_bom.zscoutcost,
tmp_bom.pur_cost 
from ( select distinct zcmcd, zdate, zplant, zdiv, PBINV.SF_ACCDIV(zplant,zdiv,zmdcd) as accdiv,zmdcd, zmdno,zitno, 
zdesc, zsrce, zygchk, zmovcost, zrcpcost, zoutcost, 
zscmovcost, zscrcpcost, zscoutcost,
case when zygchk = 'Y' then 
	 ( select decimal(
      (select coalesce(sum(a.gcost + a.mcost),0)
     from pbpur.pur103a a  inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
        where a.comltd = '01' and  a.itno = zitno
        and  b.xstop = 'O' and  a.gcost <> 0)
      / case when
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
        on a.comltd = b.comltd and a.dept = b.dept and
          a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0) = 0 then 1
        else
          (select count(*)
      from pbpur.pur103a a inner join pbpur.pur103 b
      on a.comltd = b.comltd and a.dept = b.dept and
        a.vsrno = b.vsrno and a.itno = b.itno
            where a.comltd = '01' and a.itno = zitno
              and b.xstop = 'O' and a.gcost <> 0)
        end,15,6)
    from pbcommon.comm000 )
else 
	case when zsrce = '01' then
		( select max(ecost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	else
		( select max(dcost) from pbpur.pur103 where comltd = '01' and itno = zitno and xstop = 'O' )
	end 
end as pur_cost  
from pbpdm.bom113d
where zcmcd = '01' and zdate = '20120517' and zsrce in ('01','02','04') and 
(( zygchk = 'Y' and (zscmovcost + zscrcpcost + zscoutcost) = 0 ) or 
( zygchk <> 'Y' and (zmovcost + zrcpcost + zoutcost) = 0 ))) tmp_bom inner join pbpdm.bom109d tmp_109d
on tmp_bom.zcmcd = tmp_109d.fcmcd and tmp_109d.fgubun = 'B' and tmp_109d.fdate = '20120517' and 
   tmp_bom.zplant = tmp_109d.fplant and tmp_bom.zdiv = tmp_109d.fdvsn and 
   tmp_bom.zmdcd = tmp_109d.fpdcd and tmp_bom.zmdno = tmp_109d.fmdno
order by tmp_bom.zplant, tmp_bom.zdiv, tmp_bom.zmdcd, tmp_bom.zmdno, tmp_bom.zitno;