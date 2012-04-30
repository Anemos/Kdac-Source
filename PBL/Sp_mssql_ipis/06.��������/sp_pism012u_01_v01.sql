SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism012u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism012u_01]
GO




/******************************************************/
/*     Routing Sheet vs 작업일보작성용 품번리스트     */
/* 라우팅 이력관리시스템 적용 ( 2008.11.12 ) */
/******************************************************/

CREATE PROCEDURE sp_pism012u_01
  @ps_area  Char(1),    -- 지역
  @ps_div Char(1),    -- 공장
  @ps_wc  Varchar(5), -- 조
  @ps_dispday Char(10)  -- 작성일자

AS
BEGIN

    SELECT B.AreaCode,
         B.DivisionCode,
         B.WorkCenter,
         B.ApplyDate,
         A.wcItemGroup,
         B.ItemCode,
         TMSTITEM.ItemName,
         TMSTITEM.ItemSpec,
         B.SubLineCode,
         B.SubLineNo,
         B.BasicTime,
         A.Seq,
         A.UseFlag,
         '0' wcItemGroupChk,
         A.LastEmp,
         A.LastDate
    FROM TMHWCITEM A,
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
        GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) B,
      TMSTITEM
    WHERE ( A.AreaCode = B.AreaCode ) and
         ( A.DivisionCode = B.DivisionCode ) and
         ( A.WorkCenter = B.WorkCenter ) and
         ( A.ItemCode = B.ItemCode ) and
         ( A.subLineCode = B.SubLineCode ) and
         ( A.subLineNo = B.SubLineNo ) and
         ( A.ItemCode = TMSTITEM.ItemCode ) And
         ( ( A.AreaCode = @ps_area ) AND
           ( A.DivisionCode = @ps_div ) AND
           ( A.WorkCenter = @ps_wc ) And
          ( IsNull(A.UseFlag,'0') = '0' ) )
    Union

    SELECT B.AreaCode,
               B.DivisionCode,
         B.WorkCenter,
         B.ApplyDate,
         NULL,
         B.ItemCode,
         TMSTITEM.ItemName,
         TMSTITEM.ItemSpec,
         B.SubLineCode,
         B.SubLineNo,
         B.BasicTime,
         0,
         '0',
         '1',
         Cast ( '' as VarChar(6) ),
         Cast ( NULL as DateTime )
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
        GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) B, TMSTITEM
    WHERE ( B.ItemCode =  TMSTITEM.ItemCode ) And
      Not Exists ( SELECT A.AreaCode, A.DivisionCode, A.WorkCenter, A.ItemCode,
            A.subLineCode, A.subLineNo From TMHWCITEM A
      WHERE ( A.AreaCode = B.AreaCode ) and
      ( A.DivisionCode = B.DivisionCode ) and
            ( A.WorkCenter = B.WorkCenter ) and
            ( A.ItemCode = B.ItemCode ) and
      ( A.subLineCode = B.SubLineCode ) and
      ( A.subLineNo = B.SubLineNo ) ) And
         ( ( B.AreaCode = @ps_area ) AND
           ( B.DivisionCode = @ps_div ) AND
           ( B.WorkCenter = @ps_wc ) )

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

