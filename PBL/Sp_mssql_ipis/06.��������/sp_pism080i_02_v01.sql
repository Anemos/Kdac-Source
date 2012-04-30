SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism080i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism080i_02]
GO




/**************************************/
/*     품번별 LPI 및 작업효율 조회    */
/**************************************/

CREATE PROCEDURE sp_pism080i_02
  @ps_area  Char(1),    -- 지역
  @ps_div   Char(1),    -- 공장
  @ps_wc    VarChar(5),   -- 조
  @ps_stMonth Char(7)     -- 기준년월
AS
BEGIN

Declare @lastYear Char(4)
Declare @workmonth  Char(8)

Set @lastYear   =   Cast ( Cast( substring(@ps_stMonth, 1, 4) as Numeric(4) ) - 1 as Char(4) )
Set @workmonth  = @ps_stMonth  + '%'

select areacode,divisioncode,workcenter,itemcode,sublinecode,sublineno,sum(basictime)/count(workday) as basictime
  into #tmp_realprod
from tmhrealprod
where    AreaCode = @ps_area  And
   DivisionCode = @ps_div  And
   WorkCenter like @ps_wc  And
   workday like @workmonth
group by areacode,divisioncode,workcenter,itemcode,sublinecode,sublineno


  SELECT A.sMonth,
   A.AreaCode,
         A.DivisionCode,
         A.WorkCenter,
         E.WorkCenterName,
         B.ProductGroup,
         D.ProductGroupName,
   A.subLineCode,
   A.subLineNo,
         A.ItemCode,
         C.ItemName,
--       F.wcItemGroup,
   A.pQty,
   A.unuseMH,
   A.ActMH,
   A.ActInMH,
   A.BasicMH,
   G.tarMH,
   H.stMH,
   I.tarLPI,
   I.divtarLPI,
   J.BasicTime / 3600
    FROM TMHMONTHPRODLINE_S A,
         TMSTMODEL B,
         TMSTITEM C,
         TMSTPRODUCTGROUP D,
         TMSTWORKCENTER E,
--       TMHWCITEM F,
  ( SELECT WorkCenter,
     ItemCode,
     subLineCode,
     subLineNo,
           tarMH
      FROM TMHMONTHTARGET
     WHERE ( AreaCode = @ps_area ) AND
     ( DivisionCode = @ps_div ) AND
     ( WorkCenter like @ps_wc ) AND
     ( tarMonth = @ps_stMonth ) ) G,
  ( SELECT WorkCenter,
     ItemCode,
     subLineCode,
     subLineNo,
           CASE SUBSTRING(@ps_stMonth,6,2)
      WHEN '01' THEN STMH01
      WHEN '02' THEN STMH02
      WHEN '03' THEN STMH03
      WHEN '04' THEN STMH04
      WHEN '05' THEN STMH05
      WHEN '06' THEN STMH06
      WHEN '07' THEN STMH07
      WHEN '08' THEN STMH08
      WHEN '09' THEN STMH09
      WHEN '10' THEN STMH10
      WHEN '11' THEN STMH11
      WHEN '12' THEN STMH12 END AS stMH
      FROM tmhstandard
     WHERE ( AreaCode = @ps_area ) AND
     ( DivisionCode = @ps_div ) AND
     ( WorkCenter like @ps_wc ) AND
     ( stYear = @lastYear ) ) H,
   TMHVALUETARGET I,
   #tmp_realprod J
   WHERE ( A.AreaCode = B.AreaCode ) and
         ( A.DivisionCode = B.DivisionCode ) and
         ( A.ItemCode = C.ItemCode ) and
         ( A.ItemCode = B.ItemCode ) and
         ( B.ProductGroup = D.ProductGroup ) and
         ( A.AreaCode = D.AreaCode ) and
         ( A.DivisionCode = D.DivisionCode ) and
         ( A.AreaCode = E.AreaCode ) and
         ( A.DivisionCode = E.DivisionCode ) and
         ( A.WorkCenter = E.WorkCenter ) and
--       ( A.AreaCode *= F.AreaCode ) and
--       ( A.DivisionCode *= F.DivisionCode ) and
--       ( A.WorkCenter *= F.WorkCenter ) and
--       ( A.ItemCode *= F.ItemCode ) And
   ( A.AreaCode *= I.AreaCode ) and
         ( A.DivisionCode *= I.DivisionCode ) and
         ( A.WorkCenter *= I.WorkCenter ) And
   ( A.sMonth *= I.tarMonth ) And
   ( A.WorkCenter *= G.WorkCenter ) And
   ( A.ItemCode *= G.ItemCode ) And
   ( A.subLineCode *= G.subLineCode ) And
   ( A.subLineNo *= G.subLineNo ) And
   ( A.WorkCenter *= H.WorkCenter ) And
   ( A.ItemCode *= H.ItemCode ) And
   ( A.subLineCode *= H.subLineCode ) And
   ( A.subLineNo *= H.subLineNo ) And
   ( A.AreaCode *= J.AreaCode ) And
   ( A.DivisionCode *= J.DivisionCode ) And
   ( A.WorkCenter *= J.WorkCenter ) And
   ( A.ItemCode *= J.ItemCode ) and
         ( A.subLineCode *= J.subLineCode ) and
   ( A.subLineNo *= J.subLineNo ) And
   ( ( A.AreaCode = @ps_area ) And
     ( A.DivisionCode = @ps_div ) And
     ( A.WorkCenter like @ps_wc ) And
     ( A.sMonth = @ps_stMonth ) )

drop table #tmp_realprod

END



GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

