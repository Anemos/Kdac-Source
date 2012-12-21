create view pbrtn.vrouting

-- 대체라인/차수별 표준시간 합계
( select tmp.replant as replant, tmp.redvsn as redvsn, tmp.reitno as reitno, 
  tmp.reline1 as reline1, tmp.reline2 as reline2, tmp.reline3 as reline3,
  sum(tmp.capa_time) as capa_time, sum(tmp.hyoul_time) as hyoul_time, 
  sum(tmp.repower) as repower
from ( select replant as replant, redvsn as redvsn, reitno as reitno, 
  reline1 as reline1, reline2 as reline2, reline3 as reline3,
 (rebstm + renvmc) * rboption / 100 as capa_time,
 (rebltm + renvlb) * rboption / 100 as hyoul_time,
 (repower) * rboption / 100 as repower
from pbrtn.rtn015 inner join pbrtn.rtn012
  on recmcd = rbcmcd and replant = rbplant and
    redvsn = rbdvsn and reline1 = rbline1 and
    reline2 = rbline2
where reedfm  <= :a_date and reedto >= :a_date and 
      reedfm <= reedto  
union all
select a.replant as replant, a.redvsn as redvsn, b.rhitno1 as reitno,
  a.reline1 as reline1, a.reline2 as reline2, a.reline3 as reline3,
 (a.capa_time) as capa_time,
 (a.hyoul_time) as hyoul_time,
 (a.repower) as repower
from ( select replant, redvsn, reitno, 
   reline1, reline2, reline3,
  (rebstm + renvmc) * rboption / 100 as capa_time,
  (rebltm + renvlb) * rboption / 100 as hyoul_time,
  (repower) * rboption / 100 as repower
 from pbrtn.rtn015 inner join pbrtn.rtn012
  on recmcd = rbcmcd and replant = rbplant and
    redvsn = rbdvsn and reline1 = rbline1 and
    reline2 = rbline2
 where reedfm  <= :a_date and reedto >= :a_date and 
      reedfm <= reedto) a inner join 
 (select rhplant, rhdvsn, rhitno, rhitno1 from pbrtn.rtn018
  where rhedfm  <= :a_date and rhedto >= :a_date and 
      rhedfm <= rhedto) b
  on a.replant = b.rhplant and
    a.redvsn = b.rhdvsn and a.reitno = b.rhitno ) tmp
group by tmp.replant, tmp.redvsn, tmp.reitno, tmp.reline1, tmp.reline2, tmp.reline3 )

-- 대체라인별 차수갯수
selet aa.replant as replant, aa.redvsn as redvsn, aa.reitno as reitno, aa.reline1 as reline1, count(*) as cnt
from ( select tmp.replant as replant, tmp.redvsn as redvsn, tmp.reitno as reitno, 
  tmp.reline1 as reline1, tmp.reline2 as reline2, tmp.reline3 as reline3,
  sum(tmp.capa_time) as capa_time, sum(tmp.hyoul_time) as hyoul_time, 
  sum(tmp.repower) as repower
from ( select replant as replant, redvsn as redvsn, reitno as reitno, 
  reline1 as reline1, reline2 as reline2, reline3 as reline3,
 (rebstm + renvmc) * rboption / 100 as capa_time,
 (rebltm + renvlb) * rboption / 100 as hyoul_time,
 (repower) * rboption / 100 as repower
from pbrtn.rtn015 inner join pbrtn.rtn012
  on recmcd = rbcmcd and replant = rbplant and
    redvsn = rbdvsn and reline1 = rbline1 and
    reline2 = rbline2
where reedfm  <= :a_date and reedto >= :a_date and 
      reedfm <= reedto  
union all
select a.replant as replant, a.redvsn as redvsn, b.rhitno1 as reitno,
  a.reline1 as reline1, a.reline2 as reline2, a.reline3 as reline3,
 (a.capa_time) as capa_time,
 (a.hyoul_time) as hyoul_time,
 (a.repower) as repower
from ( select replant, redvsn, reitno, 
   reline1, reline2, reline3,
  (rebstm + renvmc) * rboption / 100 as capa_time,
  (rebltm + renvlb) * rboption / 100 as hyoul_time,
  (repower) * rboption / 100 as repower
 from pbrtn.rtn015 inner join pbrtn.rtn012
  on recmcd = rbcmcd and replant = rbplant and
    redvsn = rbdvsn and reline1 = rbline1 and
    reline2 = rbline2
 where reedfm  <= :a_date and reedto >= :a_date and 
      reedfm <= reedto) a inner join 
 (select rhplant, rhdvsn, rhitno, rhitno1 from pbrtn.rtn018
  where rhedfm  <= :a_date and rhedto >= :a_date and 
      rhedfm <= rhedto) b
  on a.replant = b.rhplant and
    a.redvsn = b.rhdvsn and a.reitno = b.rhitno ) tmp
group by tmp.replant, tmp.redvsn, tmp.reitno, tmp.reline1, tmp.reline2, tmp.reline3 ) aa
group by aa.replant, aa.redvsn, aa.reitno, aa.reline1

-- 조코드별 표준시간비율 적용


//SELECT C.RCPLANT, C.RCDVSN, C.RCLINE1, A.CNT, C.CNT
//FROM 
//( SELECT RBPLANT, RBDVSN, RBLINE1, COUNT(*) AS CNT
//FROM PBRTN.RTN012
//GROUP BY RBPLANT, RBDVSN, RBLINE1
//HAVING COUNT(*) > 1 ) A
//INNER JOIN 
//( SELECT B.RCPLANT AS RCPLANT, B.RCDVSN AS RCDVSN, B.RCLINE1 AS RCLINE1, COUNT(*) AS CNT
//  FROM 
//	( SELECT DISTINCT RCPLANT,RCDVSN, RCLINE1, RCLINE2
//		FROM PBRTN.RTN013 ) B
//  GROUP BY B.RCPLANT, B.RCDVSN, B.RCLINE1 ) C
//ON A.RBPLANT = C.RCPLANT AND A.RBDVSN = C.RCDVSN AND
//	A.RBLINE1 = C.RCLINE1 ;

SELECT TMP.RAPLANT, TMP.RADVSN, TMP.RAITNO, TMP.PCLS, TMP.RAITNO1, TMP.CCLS
FROM ( SELECT RAPLANT,RADVSN,RAITNO,
	(SELECT CLS FROM PBINV.INV101 WHERE 
	XPLANT = RAPLANT AND DIV = RADVSN AND ITNO = RAITNO ) AS PCLS,
 RAITNO1,
 (SELECT CLS FROM PBINV.INV101 WHERE 
	XPLANT = RAPLANT AND DIV = RADVSN AND ITNO = RAITNO1 ) AS CCLS
 FROM PBRTN.RTN011 ) TMP
WHERE (TMP.PCLS = '50' AND TMP.CCLS <> '50') OR (TMP.PCLS <> '50' AND TMP.CCLS = '50');


 select replant as replant, redvsn as redvsn, reitno as reitno, 
  reline1 as reline1, reline2 as reline2, reline3 as reline3,
 reopsq as reopsq, reopno as reopno,reopnm as reopnm,rebmtm as rebmtm,rebltm as rebltm,
 rebstm as rebstm,renvmc as renvmc,renvlb as renvlb,relbcnt as relbcnt,
 (rebstm + renvmc) as capa_time,
 (rebltm + renvlb) as hyoul_time,
 (repower) as repower
from pbrtn.rtn015
where reedfm  <= :a_date and reedto >= :a_date and 
      reedfm <= reedto  
union all
select a.replant as replant, a.redvsn as redvsn, b.rhitno1 as reitno,
  a.reline1 as reline1, a.reline2 as reline2, a.reline3 as reline3,
  a.reopsq as reopsq, a.reopno as reopno,a.reopnm as reopnm,a.rebmtm as rebmtm,a.rebltm as rebltm,
  a.rebstm as rebstm,a.renvmc as renvmc,a.renvlb as renvlb,a.relbcnt as relbcnt,
 (a.capa_time) as capa_time,
 (a.hyoul_time) as hyoul_time,
 (a.repower) as repower
from ( select replant, redvsn, reitno, 
   reline1, reline2, reline3,
  reopsq as reopsq, reopno as reopno,reopnm as reopnm,rebmtm as rebmtm,rebltm as rebltm,
 rebstm as rebstm,renvmc as renvmc,renvlb as renvlb,relbcnt as relbcnt,
  (rebstm + renvmc) as capa_time,
  (rebltm + renvlb) as hyoul_time,
  (repower) as repower
 from pbrtn.rtn015
 where reedfm  <= :a_date and reedto >= :a_date and 
      reedfm <= reedto) a inner join 
 (select rhplant, rhdvsn, rhitno, rhitno1 from pbrtn.rtn018
  where rhedfm  <= :a_date and rhedto >= :a_date and 
      rhedfm <= rhedto) b
  on a.replant = b.rhplant and
    a.redvsn = b.rhdvsn and a.reitno = b.rhitno