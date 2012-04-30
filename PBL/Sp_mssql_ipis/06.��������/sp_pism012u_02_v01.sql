SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism012u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism012u_02]
GO




/**************************************/
/*     작업일보작성용 품번리스트      */
/* 라우팅 이력관리시스템 적용( 2008.11.12 )  */
/**************************************/

CREATE PROCEDURE sp_pism012u_02
  @ps_area  Char(1),    -- 지역
  @ps_div   Char(1),    -- 공장
  @ps_wc    Varchar(5),   -- 조
  @ps_dispDay Char(10),
  @ps_useFlag Char(1)

AS
BEGIN

  SELECT A.AreaCode,
    A.DivisionCode,
    A.WorkCenter,
    C.ApplyDate,
    A.wcItemGroup,
    A.ItemCode,
    B.ItemName,
    B.ItemSpec,
    A.subLineCode,
    A.subLineNo,
    C.BasicTime,
    A.Seq,
    A.UseFlag,
    '0',
    A.LastEmp,
    A.LastDate
  FROM TMHWCITEM A,
    TMSTITEM B,
    ( SELECT AreaCode = aa.AreaCode,
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
        GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) C
  WHERE ( A.AreaCode = C.AreaCode ) And
   ( A.DivisionCode = C.DivisionCode ) And
   ( A.WorkCenter = C.WorkCenter ) And
   ( A.ItemCode = C.ItemCode ) And
   ( A.subLineCode = C.subLineCode ) And
   ( A.subLineNo = C.subLineNo ) And
   ( A.ItemCode = B.ItemCode ) and
   ( ( A.AreaCode = @ps_area ) AND
   ( A.DivisionCode = @ps_div ) AND
   ( A.WorkCenter = @ps_wc ) And
   ( IsNull(A.UseFlag, '0') like @ps_useFlag ) )

END




GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

