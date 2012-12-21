SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_summary_workcenter]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_summary_workcenter]
GO


/*****************************************/ 
/*    공장별 대당 표준 및 실투입MH Summary    */ 
/*  같은품번에 대체라인별로 생산율 적용, 완제품MH에서 sub출하품제외 */
/* exec sp_pism230i_summary_workcenter 'D','A','2012.10.23'  */
/*****************************************/ 

CREATE PROCEDURE sp_pism230i_summary_workcenter
  @ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_ToDate	Char(10)

AS
BEGIN

declare @ls_bomdate char(8)

set @ls_bomdate = convert(char(8), cast(@ps_ToDate as datetime), 112)

DELETE FROM TMHBASEWORKCENTER
WHERE ZCMCD = '01' AND ZDATE = @ls_bomdate AND
 AREACODE = @ps_AreaCode AND DIVISIONCODE = @ps_DivisionCode
 

-- 대당 표준MH 업데이트 (tmstrouting)
-- 같은 대체라인에 조코드가 다를 경우에 표준시간은 더한다.
-- 같은 품번에 대체라인 다를 경우에는 평균값을 적용한다.
INSERT INTO TMHBASEWORKCENTER
( ZCMCD,ZDATE,AREACODE,DIVISIONCODE,ITEMCODE,SUBLINECODE,SUBLINENO,
WORKCENTER,PRODUCTQTY,STDSUM,ACTSUM,POWERSUM,MACTIMESUM,AVGSTDSUM,AVGACTSUM,
AVGPOWERSUM,AVGMACTIMESUM)
SELECT '01', @ls_bomdate, tmp.AreaCode, tmp.DivisionCode, tmp.ItemCode, tmp.Sublinecode, tmp.sublineno, tmp.WorkCenter,
  sum(tmp.ProductQty) AS ProductQty,
  CAST((SUM(tmp.BasicTime) / 3600) AS NUMERIC(12,6)) AS StdSum, 
  sum(tmp.Actmh) as ActSum, 
  sum(tmp.BasePower) as PowerSum, 
  sum(tmp.BaseMacTime) as MacTimeSum,
  CAST((SUM(tmp.BasicTime) / 3600) AS NUMERIC(12,6)) AS avgStdSum, 
  sum(tmp.Actmh) as avgActSum, 
  sum(tmp.BasePower) as avgPowerSum, 
  sum(tmp.BaseMacTime) as avgMacTimeSum
FROM ( SELECT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  WorkCenter = aa.WorkCenter,
  BasicTime = Cast ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) as Numeric(12,6) ),
  Actmh = 0,
  BasePower = Cast ( (IsNull(aa.BasePower,0)) as Numeric(15,6) ),
  BaseMacTime = Cast ( (IsNull(aa.BaseMCWorkTime,0) + IsNull(aa.SideMCWorkTime,0)) as Numeric(15,6) ),
  ProductQty = 0
FROM TMSTROUTING aa
WHERE aa.AreaCode = @ps_AreaCode AND aa.DivisionCode = @ps_DivisionCode AND 
  isnull(aa.ApplyDate,'1900.01.01') <= @ps_ToDate AND isnull(aa.EndDate,'9999.12.31') >= @ps_ToDate

Union all
-- 대당 실투입 MH 업데이트 (tmhprodline)
SELECT AreaCode, DivisionCode, ItemCode,SubLineCode,
  SubLineNo, WorkCenter,
  0 as BasicTime,
  CAST ( isnull(ActInMH,0) / 
  case when (isnull(daypQty,0) + isnull(nightpQty,0)) = 0 then 1 else (isnull(daypQty,0) + isnull(nightpQty,0)) end AS NUMERIC(12,6)) AS Actmh,
  0 AS BasePower,
  0 AS BaseMacTime,
  case when (isnull(daypQty,0) + isnull(nightpQty,0)) = 0 then 0 else (isnull(daypQty,0) + isnull(nightpQty,0)) end as ProductQty
FROM TMHREALPROD
WHERE AreaCode = @ps_AreaCode AND DivisionCode = @ps_DivisionCode AND WorkDay = @ps_ToDate
AND (isnull(daypQty,0) <> 0 or isnull(nightpQty,0) <> 0 ) and ActInMH <> 0 ) tmp
GROUP BY tmp.AreaCode, tmp.DivisionCode, tmp.ItemCode, tmp.Sublinecode, tmp.sublineno, tmp.WorkCenter

-- WORKCENTER별로 생산율적용
update TMHBASEWORKCENTER
set stdsum = cast( b.stdsum * c.rboption / 100 as Numeric(12,6) ),
  powersum = cast( b.powersum * c.rboption / 100 as Numeric(12,6) ),
  mactimesum = cast( b.mactimesum * c.rboption / 100 as Numeric(12,6) )
from TMHBASEWORKCENTER b inner join TMSTROUTINGLINE c
  on c.rbcmcd = b.zcmcd and b.zdate = @ls_bomdate and 
    c.rbplant = b.areacode and c.rbdvsn = b.divisioncode and
    c.rbline1 = b.sublinecode and c.rbline2 = b.sublineno
where b.ZCMCD = '01' AND b.ZDATE = @ls_bomdate AND
  b.AREACODE = @ps_AreaCode AND b.DIVISIONCODE = @ps_DivisionCode AND b.avgstdsum <> 0
    
-- 표준MH 같은 품번에 차수가 다를 경우에는 가중평균값을 적용한다
update TMHBASEWORKCENTER
set avgstdsum = Cast ( (((a.std / a.cnt) * (b.stdsum / c.std)) / (c.cnt))  as Numeric(12,6) ),
  avgpowersum = Cast ( ((a.power / a.cnt) * (b.stdsum / c.std)) / (c.cnt)  as Numeric(12,6) ),
  avgmactimesum = Cast ( ((a.mactime / a.cnt) * (b.stdsum / c.std)) / (c.cnt)  as Numeric(12,6) )
from TMHBASEWORKCENTER b inner join
-- 라인코드별 차수
( select b.zcmcd as zcmcd, b.zdate as zdate, b.areacode as areacode, 
  b.divisioncode as divisioncode, b.itemcode as itemcode, b.sublinecode as sublinecode,
    sum(b.avgstdsum * c.rboption / 100) as std, 
    sum(b.avgpowersum * c.rboption / 100) as power, 
    sum(b.avgmactimesum * c.rboption / 100) as mactime, 
    count(*) as cnt
  from TMHBASEWORKCENTER b inner join TMSTROUTINGLINE c
  on c.rbcmcd = b.zcmcd and b.zdate = @ls_bomdate and 
    c.rbplant = b.areacode and c.rbdvsn = b.divisioncode and
    c.rbline1 = b.sublinecode and c.rbline2 = b.sublineno
  where b.ZCMCD = '01' AND b.ZDATE = @ls_bomdate AND
    b.AREACODE = @ps_AreaCode AND b.DIVISIONCODE = @ps_DivisionCode AND b.avgstdsum <> 0
  group by b.zcmcd, b.zdate, b.areacode, b.divisioncode, b.itemcode, b.sublinecode
  having count(*) > 1 ) a 
on a.zcmcd = b.zcmcd and a.zdate = b.zdate and 
  a.areacode = b.areacode and a.divisioncode = b.divisioncode and
  a.itemcode = b.itemcode and a.sublinecode = b.sublinecode
inner join
-- 라인코드별 조코드 시간 합계
( select b.zcmcd as zcmcd, b.zdate as zdate, b.areacode as areacode, 
  b.divisioncode as divisioncode, b.itemcode as itemcode, b.sublinecode as sublinecode,
  b.sublineno as sublineno,
    sum(b.avgstdsum * c.rboption / 100) as std, 
    sum(b.avgpowersum * c.rboption / 100) as power, 
    sum(b.avgmactimesum * c.rboption / 100) as mactime,
    count(*) as cnt
  from TMHBASEWORKCENTER b inner join TMSTROUTINGLINE c
  on c.rbcmcd = b.zcmcd and b.zdate = @ls_bomdate and 
    c.rbplant = b.areacode and c.rbdvsn = b.divisioncode and
    c.rbline1 = b.sublinecode and c.rbline2 = b.sublineno
  where b.ZCMCD = '01' AND b.ZDATE = @ls_bomdate AND
    b.AREACODE = @ps_AreaCode AND b.DIVISIONCODE = @ps_DivisionCode AND b.avgstdsum <> 0
  group by b.zcmcd, b.zdate, b.areacode, b.divisioncode, b.itemcode, b.sublinecode, b.sublineno ) c
on b.zcmcd = c.zcmcd and b.zdate = c.zdate and 
  b.areacode = c.areacode and b.divisioncode = c.divisioncode and
  b.itemcode = c.itemcode and b.sublinecode = c.sublinecode and b.sublineno = c.sublineno

delete from tmhbasesummary
where zcmcd = '01' and zdate = convert(char(8), cast(@ps_todate as datetime), 112) and
  zplant = @ps_areacode and zdiv = @ps_divisioncode

-- 완제품별 표준MH산정시에 SUB출하품 제외
insert into tmhbasesummary(zcmcd, zdate,zplant,zdiv,zmdcd,
zmdno,zstdin,zstdout,zactin,zactout,zbasepowerin,zbasepowerout,zbasemactimein,zbasemactimeout)
select a.zcmcd , a.zdate, a.zplant, a.zdiv, a.zmdcd, a.zmdno,
	cast(sum( a.zunitqty * case when a.zwhlcode <> '50' then b.avgstdsum else 0 end ) as decimal(15,6)) stdin,
	cast(sum( a.zunitqty * case when a.zwhlcode = '50' then b.avgstdsum else 0 end ) as decimal(15,6)) stdout,
	cast(sum( a.zunitqty * case when a.zwhlcode <> '50' then b.avgactsum else 0 end ) as decimal(15,6)) actin,
	cast(sum( a.zunitqty * case when a.zwhlcode = '50' then b.avgactsum else 0 end ) as decimal(15,6)) actout,
	cast(sum( a.zunitqty * case when a.zwhlcode <> '50' then b.avgpowersum else 0 end ) as decimal(15,6)) basepowerin,
	cast(sum( a.zunitqty * case when a.zwhlcode = '50' then b.avgpowersum else 0 end ) as decimal(15,6)) basepowerout,
	cast(sum( a.zunitqty * case when a.zwhlcode <> '50' then b.avgmactimesum else 0 end ) as decimal(15,6)) mactimein,
	cast(sum( a.zunitqty * case when a.zwhlcode = '50' then b.avgmactimesum else 0 end ) as decimal(15,6)) mactimeout
from tmhbasebom a inner join TMHBASEWORKCENTER b
  on a.zcmcd = b.zcmcd and a.zdate = b.zdate and a.zplant = b.areacode and
    a.zdiv = b.divisioncode and a.zitno = b.itemcode
  inner join TMSTROUTINGLINE c
  on b.zcmcd = c.rbcmcd and b.areacode = c.rbplant and
    b.divisioncode = c.rbdvsn and b.sublinecode = c.rbline1 and
    b.sublineno = c.rbline2 and c.rbsubchk <> 'Y'
where a.zcmcd = '01' and a.zdate = convert(char(8), cast(@ps_todate as datetime), 112) 
	and a.zplant = @ps_areacode and a.zdiv = @ps_divisioncode
	and ( b.avgstdsum <> 0 or b.avgactsum <> 0 or b.avgpowersum <> 0 or b.avgmactimesum <> 0 )
group by a.zcmcd , a.zdate, a.zplant, a.zdiv, a.zmdcd, a.zmdno
  
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

