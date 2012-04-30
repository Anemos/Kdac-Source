SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism030u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism030u_02]
GO





/********************************/
/*    조별 생산모델 유사그룹    */
/* 라우팅이력관리시스템 적용 ( 2008.11.11 ) */
/*  execute sp_pism030u_02 'D','A','421C','%', '2008.11.10' */
/********************************/

CREATE PROCEDURE sp_pism030u_02
  @ps_area  Char(1),    -- 지역
  @ps_div   Char(1),    -- 공장
  @ps_wc    Varchar(5),   -- 조
  @ps_wcGroup VarChar(30),    -- 유사군
  @ps_dispday Char(10)

AS
BEGIN

SELECT
  A.AreaCode,
  A.DivisionCode,
  A.WorkCenter,
  C.WorkCenterName,
  A.ItemCode,
  B.ItemName,
  B.ItemSpec,
  A.subLineCode,
  A.subLineNo,
  A.wcItemGroup,
  A.Seq,
  A.UseFlag,
  BasicTime = isnull(D.BasicTime,0),
  A.LastEmp,
  A.LastDate
FROM TMHWCITEM A INNER JOIN TMSTITEM B
  ON ( A.ItemCode = B.ItemCode )
  INNER JOIN TMSTWORKCENTER C
  ON ( A.AreaCode = C.AreaCode ) And
   ( A.DivisionCode = C.DivisionCode ) And
   ( A.WorkCenter = C.WorkCenter )
  LEFT OUTER JOIN ( SELECT AreaCode = aa.AreaCode,
      DivisionCode = aa.DivisionCode,
      WorkCenter = aa.WorkCenter,
      ApplyDate = Min(aa.ApplyDate),
      EndDate = Max(aa.EndDate),
      ItemCode = aa.ItemCode,
      SubLineCode = aa.SubLineCode,
      SubLineNo = aa.SubLineNo,
      BasicTime = Cast ( Sum ( IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0) ) as Numeric(9,4) )
    FROM TMSTROUTING aa
    WHERE isnull(aa.ApplyDate,'1900.01.01') <= @ps_dispday AND isnull(aa.EndDate,'9999.12.31') >= @ps_dispday
    GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) D
  ON  ( A.AreaCode = D.AreaCode ) And
   ( A.DivisionCode = D.DivisionCode ) And
   ( A.WorkCenter = D.WorkCenter ) And
   ( A.ItemCode = D.ItemCode ) And
   ( A.subLineCode = D.subLineCode ) And
   ( A.subLineNo = D.subLineNo )
WHERE  ( A.AreaCode = @ps_area ) AND
   ( A.DivisionCode = @ps_div ) AND
   ( A.WorkCenter like @ps_wc ) AND
   ( IsNull(A.wcItemGroup, '') like @ps_wcGroup ) And
   ( IsNull(A.useFlag,'0') <> '3' )

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

