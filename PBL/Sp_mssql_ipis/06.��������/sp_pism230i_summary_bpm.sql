SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_summary_bpm]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_summary_bpm]
GO


/*****************************************/ 
/*    공장별 대당 표준 및 실투입MH Summary    */ 
/* exec sp_pism230i_summary_bpm 'D','A','2012.10.23','2013','0A'  */
/*****************************************/ 

CREATE PROCEDURE sp_pism230i_summary_bpm
  @ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_ToDate	Char(10),
	@ps_xyear	Char(4),
	@ps_revno Char(2)

AS
BEGIN

declare @ls_bomdate char(8)

set @ls_bomdate = convert(char(8), cast(@ps_ToDate as datetime), 112)

-- 데이타 초기화
update tmhbasebombpm
set zstdin = 0, zstdout = 0, zactin = 0, zactout = 0,
  zstdin_s = 0, zstdout_s = 0, zactin_s = 0, zactout_s = 0
where zcmcd = '01' and xyear = @ps_xyear and revno = @ps_revno and
  zdiv = @ps_DivisionCode and xyear = @ps_xyear and revno = @ps_revno

-- 대당 표준MH 업데이트 (tmstrouting)
-- 같은 대체라인에 조코드가 다를 경우에 표준시간은 더한다.
-- 같은 품번에 대체라인 다를 경우에는 평균값을 적용한다.
  update tmhbasebombpm
  set zstdin = case when a.zwhlcode <> '50' then b.StdSum else 0 end, 
    zstdout = case when a.zwhlcode = '50' then b.StdSum else 0 end
  from tmhbasebombpm a inner join (
SELECT AA.AreaCode as AreaCode, AA.DivisionCode as DivisionCode,
AA.ItemCode as ItemCode,
CAST((SUM(AA.BasicTime) / 3600) / CC.cnt AS NUMERIC(12,5)) AS StdSum, 0 as ActSum
FROM ( SELECT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  ItemCode = aa.ItemCode,
--BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) / CASE WHEN IsNull(aa.EmpCount,1) = 0 THEN 1 ELSE IsNull(aa.EmpCount,1) END ) as Numeric(9,4) )
  BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) ) as Numeric(9,4) )
FROM TMSTROUTING aa
WHERE isnull(aa.ApplyDate,'1900.01.01') <= @ps_ToDate AND isnull(aa.EndDate,'9999.12.31') >= @ps_ToDate
GROUP BY aa.AreaCode, aa.DivisionCode, aa.ItemCode ) AA
INNER JOIN 
( SELECT BB.AreaCode as AreaCode, BB.DivisionCode as DivisionCode, 
	BB.ItemCode as ItemCode, count(*) as cnt
FROM (SELECT DISTINCT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  BasicTime = Cast ( Sum ( (IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0)) / CASE WHEN IsNull(aa.EmpCount,1) = 0 THEN 1 ELSE IsNull(aa.EmpCount,1) END ) as Numeric(9,4) )
FROM TMSTROUTING aa
WHERE isnull(aa.ApplyDate,'1900.01.01') <= @ps_ToDate AND isnull(aa.EndDate,'9999.12.31') >= @ps_ToDate
GROUP BY aa.AreaCode, aa.DivisionCode, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) BB
WHERE BB.BasicTime <> 0
GROUP BY BB.AreaCode, BB.DivisionCode, BB.ItemCode ) CC
ON AA.AreaCode = CC.AreaCode AND AA.DivisionCode = CC.DivisionCode AND
   AA.ItemCode = CC.ItemCode
WHERE AA.BasicTime <> 0
GROUP BY AA.AreaCode, AA.DivisionCode, AA.ItemCode, CC.cnt ) b
  on a.zplant = b.AreaCode and a.zdiv = b.DivisionCode and
    a.zitno = b.ItemCode
where a.zcmcd = '01' and a.zplant = @ps_AreaCode and 
  a.zdiv = @ps_DivisionCode and a.xyear = @ps_xyear and a.revno = @ps_revno

-- 대당 실투입 MH 업데이트 (tmhprodline)
-- 같은 대체라인에 조코드가 다를 경우에 표준시간은 더한다.
-- 같은 품번에 대체라인이 다를 경우에는 평균값을 적용한다.
  update tmhbasebombpm
  set zactin = case when a.zwhlcode <> '50' then b.ActSum else 0 end, 
    zactout = case when a.zwhlcode = '50' then a.zstdout else 0 end
  from tmhbasebombpm a inner join 
( SELECT AA.AreaCode as AreaCode, AA.DivisionCode as DivisionCode, AA.ItemCode as ItemCode, 
0 as StdSum, CAST (SUM(AA.ACTINMH) / CC.cnt AS NUMERIC(12,5)) AS ActSum
FROM
( SELECT AreaCode, DivisionCode, ItemCode,
  CAST ( SUM( isnull(ActInMH,0) / 
  case when (isnull(daypQty,0) + isnull(nightpQty,0)) = 0 then 1 else (isnull(daypQty,0) + isnull(nightpQty,0)) end) AS NUMERIC(12,5))
  AS ACTINMH
FROM TMHREALPROD
WHERE AreaCode = @ps_AreaCode AND DivisionCode = @ps_DivisionCode AND WorkDay = @ps_ToDate
AND (daypQty <> 0 or nightpQty <> 0 ) and ActInMH <> 0
GROUP BY AreaCode, DivisionCode, ItemCode
 ) AA
INNER JOIN 
( SELECT BB.AreaCode as AreaCode, BB.DivisionCode as DivisionCode, 
	BB.ItemCode as ItemCode, count(*) as cnt
FROM (SELECT DISTINCT AreaCode = aa.AreaCode,
  DivisionCode = aa.DivisionCode,
  ItemCode = aa.ItemCode,
  SubLineCode = aa.SubLineCode,
  SubLineNo = aa.SubLineNo,
  ActInMH = CAST ( SUM( isnull(ActInMH,0) / 
  case when (isnull(daypQty,0) + isnull(nightpQty,0)) = 0 then 1 else (isnull(daypQty,0) + isnull(nightpQty,0)) end) AS NUMERIC(12,5))
FROM TMHREALPROD aa
WHERE aa.AreaCode = @ps_AreaCode AND aa.DivisionCode = @ps_DivisionCode AND aa.WorkDay = @ps_ToDate
AND (aa.daypQty <> 0 or aa.nightpQty <> 0 ) and aa.ActInMH <> 0
GROUP BY aa.AreaCode, aa.DivisionCode, aa.ItemCode, aa.SubLineCode, aa.SubLineNo  ) BB
WHERE BB.ActInMH <> 0
GROUP BY BB.AreaCode, BB.DivisionCode, BB.ItemCode ) CC
ON AA.AreaCode = CC.AreaCode AND AA.DivisionCode = CC.DivisionCode AND
   AA.ItemCode = CC.ItemCode
GROUP BY AA.AreaCode, AA.DivisionCode, AA.ItemCode, CC.cnt ) b
on a.zplant = b.AreaCode and a.zdiv = b.DivisionCode and
    a.zitno = b.ItemCode
where a.zcmcd = '01' and a.zplant = @ps_AreaCode and 
  a.zdiv = @ps_DivisionCode and a.xyear = @ps_xyear and a.revno = @ps_revno

-- 비호환품 / 호환주품번 처리
update tmhbasebombpm
set zstdin_s = zstdin, zstdout_s = zstdout, zactin_s = zactin, zactout_s = zactout, zbasepower_s = zbasepower
where zcmcd = '01' and zplant = @ps_AreaCode and
  zdiv = @ps_DivisionCode and xyear = @ps_xyear and revno = @ps_revno and
  zcomcd <> '2'

-- 실투입MH 호환품 합계로 이동처리
update tmhbasebombpm
set zstdin_s = a.zstdin, zstdout_s = a.zstdout, zactin_s = a.zactin, zactout_s = a.zactout, zbasepower_s = a.zbasepower
from tmhbasebombpm a
where a.zcmcd = '01' and zplant = @ps_AreaCode and
  zdiv = @ps_DivisionCode and xyear = @ps_xyear and revno = @ps_revno and
  zcomcd = '2' and not exists ( select b.zitno from tmhbasebombpm b
    where a.zcmcd = b.zcmcd and a.zplant = b.zplant and a.zdiv = b.zdiv and
      a.xyear = b.xyear and a.revno = b.revno and b.zcomcd <> '2' )

exec sp_pism230i_summary_workcenter_bpm @ps_AreaCode,@ps_DivisionCode,@ps_ToDate,@ps_xyear,@ps_revno
  
END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

