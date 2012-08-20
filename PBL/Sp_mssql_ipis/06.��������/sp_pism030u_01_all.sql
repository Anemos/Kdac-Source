SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism030u_01_all]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism030u_01_all]
GO


/**************************/
/*     Routing Sheet      */
/*  라우팅 이력관리시스템 적용  */
/*  execute sp_pism030u_01_all 'D','A','421C','2008.11.10' */
/**************************/

CREATE PROCEDURE sp_pism030u_01_all
  @ps_area  Char(1),    -- 지역
  @ps_div   Char(1),    -- 공장
  @ps_wc    Varchar(5),   -- 조
  @ps_dispday Char(10)    -- Disp일자

AS
BEGIN

SELECT A.AreaCode,
   A.DivisionCode,
   A.WorkCenter,
   E.WorkCenterName,
   A.ApplyDate,
   B.ProductGroup,
   D.ProductGroupName,
   A.ItemCode,
   C.ItemName,
   C.ItemSpec,
   A.SubLineCode,
   A.SubLineNo,
   A.BasicTime,
   EndDate = isnull(A.EndDate,'9999.12.31')
FROM ( SELECT AreaCode = aa.AreaCode,
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
GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) A,
  TMSTMODEL B,
  TMSTITEM C,
  TMSTPRODUCTGROUP D,
  TMSTWORKCENTER E
WHERE ( A.AreaCode = E.AreaCode ) And
  ( A.DivisionCode = E.DivisionCode ) And
  ( A.WorkCenter = E.WorkCenter ) And
  ( A.AreaCode = B.AreaCode ) and
  ( A.DivisionCode = B.DivisionCode ) and
  ( A.ItemCode = B.ItemCode ) And
  ( B.ItemCode = C.ItemCode ) and
  ( A.AreaCode = D.AreaCode ) and
  ( A.DivisionCode = D.DivisionCode ) and
  ( B.ProductGroup = D.ProductGroup ) and
  ( A.AreaCode =  @ps_area) AND
  ( A.DivisionCode = @ps_div ) AND
  ( A.WorkCenter like @ps_wc )

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

