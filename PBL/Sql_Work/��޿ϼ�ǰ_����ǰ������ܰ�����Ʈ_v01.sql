-- 사급완성품에 대한 하위유상자재의 현유상사급단가 내역
select tmp_sum.xplant, tmp_sum.div, tmp_sum.pdcd, tmp_sum.itno,
tmp_sum.itnm, tmp_sum.cls, tmp_sum.srce, tmp_sum.xunit,
tmp_sum.a01, tmp_sum.a02, tmp_sum.a03, tmp_sum.a04, tmp_sum.a05, tmp_sum.a06,
sum(case when tmp_sum.zdate = '201001' then truncate(tmp_sum.zunitqty * tmp_sum.xcost / tmp_sum.convqty,3)
	else 0 end),
sum(case when tmp_sum.zdate = '201002' then truncate(tmp_sum.zunitqty * tmp_sum.xcost / tmp_sum.convqty,3)
	else 0 end),
sum(case when tmp_sum.zdate = '201003' then truncate(tmp_sum.zunitqty * tmp_sum.xcost / tmp_sum.convqty,3)
	else 0 end),
sum(case when tmp_sum.zdate = '201004' then truncate(tmp_sum.zunitqty * tmp_sum.xcost / tmp_sum.convqty,3)
	else 0 end),
sum(case when tmp_sum.zdate = '201005' then truncate(tmp_sum.zunitqty * tmp_sum.xcost / tmp_sum.convqty,3)
	else 0 end),
sum(case when tmp_sum.zdate = '201006' then truncate(tmp_sum.zunitqty * tmp_sum.xcost / tmp_sum.convqty,3)
	else 0 end)
from
(select distinct tmp_inv.xplant, tmp_inv.div, tmp_inv.pdcd, tmp_inv.itno,
tmp_inv.itnm, tmp_inv.cls, tmp_inv.srce, tmp_inv.xunit,
tmp_inv.a01, tmp_inv.a02, tmp_inv.a03, tmp_inv.a04, tmp_inv.a05, tmp_inv.a06,
a.zdate,a.zpitno,a.zitno,a.zunitqty,a.zrcpcost,b.xcost,c.convqty,truncate(a.zunitqty * a.zrcpcost,3)
from ( SELECT
    I.XPLANT, I.DIV,I.PDCD, I.ITNO, I.ITNM, I.CLS, I.SRCE, I.XUNIT,
    SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201001' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A01,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201002' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A02,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201003' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A03,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201004' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A04,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201005' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A05,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201006' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A06
FROM PBINV.INV401 I
WHERE I.COMLTD = '01'
AND I.TDTE4 BETWEEN '20100101' AND '20100630'
AND I.SLIPTYPE IN ('RP','DP','SS')
AND I.CLS = '10'
AND I.SRCE = '04'
GROUP BY I.XPLANT, I.DIV,I.PDCD, I.ITNO, I.ITNM, I.CLS, I.SRCE, I.XUNIT
) tmp_inv,pbpdm.bomt13 a, pbinv.inv304 b, pbinv.inv101 c
where a.zcmcd = b.comltd and a.zplant = b.xplant and
      a.zdiv = b.div and a.zitno = b.itno and
      b.comltd = c.comltd and b.xplant = c.xplant and
      b.div = c.div and b.itno = c.itno and
      a.zcmcd = '01' and a.zdate >= '201001' and a.zdate <= '201006' and
			a.zplant = tmp_inv.xplant and a.zdiv = tmp_inv.div and
			a.zpitno = tmp_inv.itno and a.zwkct = '8888') tmp_sum
group by tmp_sum.xplant, tmp_sum.div, tmp_sum.pdcd, tmp_sum.itno,
tmp_sum.itnm, tmp_sum.cls, tmp_sum.srce, tmp_sum.xunit,
tmp_sum.a01, tmp_sum.a02, tmp_sum.a03, tmp_sum.a04, tmp_sum.a05, tmp_sum.a06
order by tmp_sum.xplant, tmp_sum.div, tmp_sum.pdcd, tmp_sum.itno;

-- 사급완성품에 대한 하위유상자재의 현유상사급단가 세부내역
select distinct tmp_inv.xplant, tmp_inv.div, tmp_inv.pdcd, tmp_inv.itno,
tmp_inv.itnm, tmp_inv.cls, tmp_inv.srce, tmp_inv.xunit,
tmp_inv.a01, tmp_inv.a02, tmp_inv.a03, tmp_inv.a04, tmp_inv.a05, tmp_inv.a06,
a.zdate,a.zpitno,a.zitno,a.zunitqty,a.zrcpcost,truncate(b.xcost/c.convqty,6),truncate(a.zunitqty * b.xcost / c.convqty,3)
from ( SELECT
    I.XPLANT, I.DIV,I.PDCD, I.ITNO, I.ITNM, I.CLS, I.SRCE, I.XUNIT,
    SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201001' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A01,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201002' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A02,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201003' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A03,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201004' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A04,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201005' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A05,
   SUM(CASE WHEN SUBSTR(I.TDTE4,1,6) = '201006' THEN
                 CASE WHEN I.SLIPTYPE = 'SS' THEN -I.TQTY4 ELSE I.TQTY4 END
            ELSE 0 END) A06
FROM PBINV.INV401 I
WHERE I.COMLTD = '01'
AND I.TDTE4 BETWEEN '20100101' AND '20100630'
AND I.SLIPTYPE IN ('RP','DP','SS')
AND I.CLS = '10'
AND I.SRCE = '04'
GROUP BY I.XPLANT, I.DIV,I.PDCD, I.ITNO, I.ITNM, I.CLS, I.SRCE, I.XUNIT
) tmp_inv,pbpdm.bomt13 a,pbinv.inv304 b, pbinv.inv101 c
where a.zcmcd = b.comltd and a.zplant = b.xplant and
      a.zdiv = b.div and a.zitno = b.itno and
      b.comltd = c.comltd and b.xplant = c.xplant and
      b.div = c.div and b.itno = c.itno and
      a.zcmcd = '01' and a.zdate >= '201001' and a.zdate <= '201006' and
			a.zplant = tmp_inv.xplant and a.zdiv = tmp_inv.div and
			a.zpitno = tmp_inv.itno and a.zwkct = '8888'
order by tmp_inv.xplant, tmp_inv.div, tmp_inv.pdcd, tmp_inv.itno,a.zdate,a.zitno;