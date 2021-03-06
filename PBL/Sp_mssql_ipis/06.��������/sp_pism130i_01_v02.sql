SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism130i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism130i_01]
GO

/*
Execute sp_pism130i_01
  @ps_area  = 'D',
  @ps_div   = 'H',
  @ps_stFromDate  = '2008.02.01',
  @ps_stToDate  = '2008.03.31',
  @ps_retGubun  = '1'

Execute sp_pism130i_01_test
  @ps_area  = 'D',
  @ps_div   = 'H',
  @ps_stFromDate  = '2008.02.01',
  @ps_stToDate  = '2008.03.31',
  @ps_retGubun  = '1'
*/

/*****************************/
/*     조별 공수투입 현황    */
/* tmhstandard 지역,공장 left outer join 으로 연결(2011.02.10) */
/*****************************/

CREATE PROCEDURE [dbo].[sp_pism130i_01]
  @ps_area  Char(1),    -- 지역
  @ps_div   Char(1),    -- 공장
  @ps_stFromDate  Char(10),   -- 기준일From
  @ps_stToDate  Char(10),   -- 기준일To
  @ps_retGubun  Char(1)
AS
BEGIN

Declare @lastYear_From  Char(4) ,
  @lastYear_To  Char(4)

Set   @lastYear_From  = Cast ( Cast( substring(@ps_stFromDate,1,4) as Numeric(4) ) - 1 as Char(4) )
Set   @lastYear_To  =   Cast ( Cast( substring(@ps_stToDate,1,4) as Numeric(4) ) - 1 as Char(4) )

Create Table #Temp_MHList
  ( WorkCenter    VarChar(5)  not null,
    WorkCenterName  VarChar(30) null,
    jungsiMH    Numeric(8,1)  null,
    etcMH     Numeric(8,1)  null,
    totMH     Numeric(8,1)  null,
    excunpaidMH   Numeric(8,1)  null,
    excpaidMH   Numeric(8,1)  null,
    totInMH     Numeric(8,1)  null,
    gunteMH   Numeric(8,1)  null,
    ilboMH      Numeric(8,1)  null,
    bugaMH    Numeric(8,1)  null,
    ActInMH   Numeric(8,1)  null,
    ActMH     Numeric(8,1)  null,
    UnuseMH   Numeric(8,1)  null,
    effDownMH   Numeric(8,1)  null,
    basicMH   Numeric(8,1)  null,
    lpi     Numeric(8,1)  null,
    dispRate_bunmo  Numeric(8,1)  null )

Insert Into #Temp_MHList
Select  A.WorkCenter,
  E.WorkCenterName,
  jungsiMH  = sum(IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) ),
  etcMH     = sum(IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) ),
  totMH     = sum(IsNull(A.totMH,0)),
  excunpaidMH   = sum(IsNull(A.excunpaidMH,0)),
  excpaidMH   = sum(IsNull(A.excpaidMH,0)),
  totInMH     = sum(IsNull(A.totInMH,0)),
  gunteMH   = sum(IsNull(A.gunteMH,0)),
  ilboMH    = sum(IsNull(A.ilboMH,0)),
  bugaMH  = sum(IsNull(A.bugaMH,0)),
  ActInMH     = sum(IsNull(A.ActInMH,0)),
  ActMH     = IsNull(D.actMH,0),
  UnuseMH   = IsNull(D.unuseMH,0),
  effDownMH   = IsNull(F.effDownMH,0),
  basicMH   = IsNull(D.basicMH,0),
  lpi     = Case  sum(IsNull(A.ActInMH,0)) When 0 Then 0 Else
              round( IsNull(D.lpi_bunja,0) / sum(IsNull(A.ActInMH,0)) * 100, 1) End,
  NULL
FROM  TMHDAILY A,
             (select  b.workcenter,sum(b.actMH) actmh,sum(b.unuseMH) unusemh,round(sum(b.basicmh) / 3600 ,1 ) basicMH,
    SUM(CASE SUBSTRING(B.WORKMONTH,6,2)
    WHEN '01' THEN A.STMH01
    WHEN '02' THEN a.STMH02
    WHEN '03' THEN A.STMH03
    WHEN '04' THEN A.STMH04
    WHEN '05' THEN A.STMH05
    WHEN '06' THEN A.STMH06
    WHEN '07' THEN A.STMH07
    WHEN '08' THEN A.STMH08
    WHEN '09' THEN A.STMH09
    WHEN '10' THEN A.STMH10
    WHEN '11' THEN A.STMH11
    WHEN '12' THEN A.STMH12 END  * B.PRDQTY ) lpi_bunja
  from  tmhstandard a,
    (Select B.AreaCode,B.DivisionCode,B.WorkCenter,B.ITEMCODE,B.SUBLINECODE,B.SUBLINENO,substring(b.workday,1,7) as workmonth,
          sum(IsNull(B.ActMH,0)) actMH,
          sum(IsNull(B.UnuseMH,0)) unuseMH,
          sum( (IsNull(B.daypQty,0) + IsNull(nightpQty,0)) * IsNull(B.basicTime,0) )  basicMH,
          sum( IsNull(B.daypQty,0) + IsNull(B.nightpQty,0) ) as prdqty
    From  TMHDAILYSTATUS A, TMHREALPROD B
    Where ( A.AreaCode = B.AreaCode ) And
      ( A.DivisionCode = B.DivisionCode ) And
      ( A.WorkCenter = B.WorkCenter ) And
      ( A.WorkDay = B.WorkDay ) And
      ( B.AreaCode = @ps_area ) And
        ( B.DivisionCode = @ps_div ) And
      ( B.WorkDay between @ps_stFromDate And @ps_stToDate ) And
      ( A.DailyStatus = '1' )
    Group By B.AreaCode,B.DivisionCode,B.WorkCenter,B.ITEMCODE,B.SUBLINECODE,B.SUBLINENO,substring(b.workday,1,7)
    ) b
  where B.AreaCode *= A.AreaCode And
    B.DivisionCode *= A.DivisionCode And
    B.WorkCenter  *=  A.WorkCenter  And
    B.ItemCode  *=  A.ItemCode    And
    B.subLineCode   *=  A.subLineCode   And
    B.subLineNo   *=  A.subLineNo   And
    cast(cast(substring(B.WORKMONTH,1,4) as integer) - 1 as char) *= a.styear  and
    A.styear    between @lastYear_from and @lastYear_to
  GROUP BY b.workcenter ) D,
  ( SELECT B.WorkCenter,
           sum(IsNull(B.subMH,0)) effDownMH
      FROM TMHDAILYSTATUS A, TMHDAILYSUB B
     WHERE ( A.AreaCode = B.AreaCode ) And
     ( A.DivisionCode = B.DivisionCode ) And
     ( A.WorkCenter = B.WorkCenter ) And
     ( A.WorkDay = B.Workday ) And
     ( ( A.AreaCode = @ps_area ) AND
             ( A.DivisionCode = @ps_div ) AND
             ( B.mhGubun = 'Z' ) And
       ( B.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
       ( A.DailyStatus = '1' ) )
  Group By B.WorkCenter ) F,TMSTWORKCENTER E,TMHDAILYSTATUS G
WHERE ( A.Areacode = G.AreaCode ) And
  ( A.DivisionCode = G.DivisionCode ) And
  ( A.WorkCenter = G.WorkCenter ) And
  ( A.WorkDay = G.WorkDay ) And
  ( A.WorkCenter *= D.WorkCenter ) And
  ( A.WorkCenter *= F.WorkCenter ) And
  ( A.AreaCode = E.AreaCode ) And
  ( A.DivisionCode = E.DivisionCode ) And
  ( A.WorkCenter = E.WorkCenter ) And
  ( ( A.AreaCode = @ps_area ) AND
  ( A.DivisionCode = @ps_div ) AND
  ( A.WorkDay between @ps_stFromDate And @ps_stToDate ) And
  ( G.DailyStatus = '1' ) )
Group By A.WorkCenter,E.WorkCenterName,D.actMH, D.unuseMH, F.effDownMH, D.basicMH, D.lpi_bunja
Union
Select  'XXXXX','누계',
  jungsiMH  = sum(IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) ),
  etcMH     = sum(IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) ),
  totMH     = sum(IsNull(A.totMH,0)),
  excunpaidMH   = sum(IsNull(A.excunpaidMH,0)),
  excpaidMH   = sum(IsNull(A.excpaidMH,0)),
  totInMH     = sum(IsNull(A.totInMH,0)),
  gunteMH   = sum(IsNull(A.gunteMH,0)),
  ilboMH    = sum(IsNull(A.ilboMH,0)),
  bugaMH  = sum(IsNull(A.bugaMH,0)),
  ActInMH     = sum(IsNull(A.ActInMH,0)),
  ActMH     = IsNull(D.actMH,0),
  UnuseMH   = IsNull(D.unuseMH,0),
  effDownMH   = IsNull(F.effDownMH,0),
  basicMH   = IsNull(D.basicMH,0),
  lpi     = Case  sum(IsNull(A.ActInMH,0)) When 0 Then 0 Else
              round( IsNull(D.lpi_bunja,0) / sum(IsNull(A.ActInMH,0)) * 100, 1) End,
  NULL
FROM  TMHDAILY A,
             (select  sum(b.actMH) actmh,sum(b.unuseMH) unusemh,round(sum(b.basicmh) / 3600 ,1 ) basicMH,
    SUM(CASE SUBSTRING(B.WORKMONTH,6,2)
    WHEN '01' THEN A.STMH01
    WHEN '02' THEN a.STMH02
    WHEN '03' THEN A.STMH03
    WHEN '04' THEN A.STMH04
    WHEN '05' THEN A.STMH05
    WHEN '06' THEN A.STMH06
    WHEN '07' THEN A.STMH07
    WHEN '08' THEN A.STMH08
    WHEN '09' THEN A.STMH09
    WHEN '10' THEN A.STMH10
    WHEN '11' THEN A.STMH11
    WHEN '12' THEN A.STMH12 END  * B.PRDQTY ) lpi_bunja
  from  tmhstandard a,
    (Select B.AreaCode,B.DivisionCode,B.WorkCenter,B.ITEMCODE,B.SUBLINECODE,B.SUBLINENO,substring(b.workday,1,7) as workmonth,
          sum(IsNull(B.ActMH,0)) actMH,
          sum(IsNull(B.UnuseMH,0)) unuseMH,
          sum( (IsNull(B.daypQty,0) + IsNull(nightpQty,0)) * IsNull(B.basicTime,0) )  basicMH,
          sum( IsNull(B.daypQty,0) + IsNull(B.nightpQty,0) ) as prdqty
    From  TMHDAILYSTATUS A, TMHREALPROD B
    Where ( A.AreaCode = B.AreaCode ) And
      ( A.DivisionCode = B.DivisionCode ) And
      ( A.WorkCenter = B.WorkCenter ) And
      ( A.WorkDay = B.WorkDay ) And
      ( B.AreaCode = @ps_area ) And
        ( B.DivisionCode = @ps_div ) And
      ( B.WorkDay between @ps_stFromDate And @ps_stToDate ) And
      ( A.DailyStatus = '1' )
    Group By B.AreaCode,B.DivisionCode,B.WorkCenter,B.ITEMCODE,B.SUBLINECODE,B.SUBLINENO,substring(b.workday,1,7)
    ) b
  where B.AreaCode *= A.AreaCode And
    B.DivisionCode *= A.DivisionCode And
    B.WorkCenter  *=  A.WorkCenter  And
    B.ItemCode  *=  A.ItemCode    And
    B.subLineCode   *=  A.subLineCode   And
    B.subLineNo   *=  A.subLineNo   And
    cast(cast(substring(B.WORKMONTH,1,4) as integer) - 1 as char) *= a.styear  and
    A.styear    between @lastYear_from and @lastYear_to
  ) D,
  ( SELECT sum(IsNull(B.subMH,0)) effDownMH
    FROM TMHDAILYSTATUS A, TMHDAILYSUB B
    WHERE ( A.AreaCode = B.AreaCode ) And
      ( A.DivisionCode = B.DivisionCode ) And
    ( A.WorkCenter = B.WorkCenter ) And
    ( A.WorkDay = B.Workday ) And
    ( ( A.AreaCode = @ps_area ) AND
      ( A.DivisionCode = @ps_div ) AND
      ( B.mhGubun = 'Z' ) And
      ( B.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( A.DailyStatus = '1' ) ) ) F,
  TMHDAILYSTATUS G
WHERE   ( A.Areacode = G.AreaCode ) And
  ( A.DivisionCode = G.DivisionCode ) And
  ( A.WorkCenter = G.WorkCenter ) And
  ( A.WorkDay = G.WorkDay ) And
  ( ( A.AreaCode = @ps_area ) AND
  ( A.DivisionCode = @ps_div ) AND
  ( A.WorkDay between @ps_stFromDate And @ps_stToDate ) And
  ( G.DailyStatus = '1' ) )
Group By D.actMH, D.unuseMH, F.effDownMH, D.basicMH, D.lpi_bunja


Update #Temp_MHList
   Set dispRate_bunmo = IsNull(( Select totMH From #Temp_MHList A Where A.WorkCenter = #Temp_MHList.WorkCenter ), 0)

 Create Table #Temp_dispName
  ( WorkCenter   VarChar(5) not null,
    WorkCenterName VarChar(30)  null,
    Seq1    int,
    Seq2    int   null,
    dispLevel Char(1),
    dispName  VarChar(100)  null,
    dispMH  Numeric(8,1)  null,
    dispRate  Numeric(5,1)  null )

   If @ps_retGubun = '1'
  Begin
  Insert #Temp_dispName
    SELECT WorkCenter,
     WorkCenterName,
     1 Seq1,
     0 Seq2,
    '1' dispLevel,

    '   정시공수 (B)' dispName,
     jungsiMH dispMH,
     Case dispRate_bunmo When 0 Then 0 Else
          round( jungsiMH / dispRate_bunmo * 100, 1 ) End dispRate
      From #Temp_MHList
   Union
    SELECT WorkCenter, WorkCenterName,  2, 0, '1', '   정시외공수 (C)',     etcMH,
     Case dispRate_bunmo When 0 Then 0 Else round( etcMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName,  3, 0, '0', '총보유공수 (A=B+C)',    totMH,
     Case dispRate_bunmo When 0 Then 0 Else round( totMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
  -- 상세조회일 경우 ( 평가제외 무급공수 'K' )
    SELECT WorkCenter, WorkCenterName,  5, 0, '1', '   무급공수 (E)',     excunpaidMH,
     Case dispRate_bunmo When 0 Then 0 Else round( excunpaidMH / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
  -- 평가제외 유급공수 'S'
    SELECT WorkCenter, WorkCenterName,  7, 0, '1', '   유급공수 (F)',     excpaidMH,
     Case dispRate_bunmo When 0 Then 0 Else round( excpaidMH / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName,  8, 0, '0', '평가제외공수 (D=E+F)',  excunpaidMH + excpaidMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ( excunpaidMH + excpaidMH ) / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName,  9, 0, '0', '총투입공수 (G=A-D)',    totInMH,
     Case dispRate_bunmo When 0 Then 0 Else round( totInMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
  -- 유급근태사고공수 'B'
    SELECT WorkCenter, WorkCenterName, 11, 0, '1', '   유급근태사고공수 (H)', gunteMH,
     Case dispRate_bunmo When 0 Then 0 Else round( gunteMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
  -- 일보사고공수 'G'
    SELECT WorkCenter, WorkCenterName, 13, 0, '1', '   일보사고공수 (I)',   ilboMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ilboMH / dispRate_bunmo * 100, 1 ) End   From #Temp_MHList Union
  -- 부가작업공수 'F'
    SELECT WorkCenter, WorkCenterName, 15, 0, '1', '   부가작업공수 (J)',   bugaMH,
     Case dispRate_bunmo When 0 Then 0 Else round( bugaMH / dispRate_bunmo * 100, 1 ) End   From #Temp_MHList Union
  -- 유휴공수 'U'
    SELECT WorkCenter, WorkCenterName, 17, 0, '1', '   유휴공수 (K)',   UnuseMH,
     Case dispRate_bunmo When 0 Then 0 Else round( UnuseMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 18, 0, '0', '비가동공수 계 (L=H+I+J+K)', gunteMH + ilboMH + bugaMH + UnuseMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ( gunteMH + ilboMH + bugaMH + UnuseMH ) / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 19, 0, '0', '실투입공수 {M=G-(H+I+J)}',  ActInMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ActInMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 20, 0, '0', '실동공수 (N=G-L)',    ActMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ActMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
  -- 능률저하 'Z'
  --SELECT WorkCenter, WorkCenterName, 22, 0, '1', '   능률저하공수', effDownMH   From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 23, 0, '0', '표준생산공수 (O)',    basicMH,
     Case dispRate_bunmo When 0 Then 0 Else round( basicMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 24, 0, '0', '실동율 (P=N/G)',   Case totInMH When 0 Then 0 Else
                      round( ActMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 25, 0, '0', '작업효율 (Q=O/N)', Case ActMH When 0 Then 0 Else
                      round( basicMH / ActMH * 100, 1 ) End, NULL From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 26, 0, '0', '종합효율 (R=P*Q)', Case totInMH When 0 Then 0 Else
                      round( basicMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 27, 0, '0', 'LPI',        lpi, NULL      From #Temp_MHList
  End
   Else
  Begin
  Insert Into #Temp_dispName
    SELECT WorkCenter,
     WorkCenterName,
     1 Seq1,
     0 Seq2,
    '1' dispLevel,
    '   정시공수 (B)' dispName,
     jungsiMH dispMH,
     Case dispRate_bunmo When 0 Then 0 Else
          round( jungsiMH / dispRate_bunmo * 100, 1 ) End dispRate
      From #Temp_MHList
   Union
    SELECT WorkCenter, WorkCenterName, 2, 0, '1', '   정시외공수 (C)',    etcMH,
     Case dispRate_bunmo When 0 Then 0 Else round( etcMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 3, 0, '0', '총보유공수 (A=B+C)',     totMH,
     Case dispRate_bunmo When 0 Then 0 Else round( totMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
  -- 상세조회일 경우 ( 평가제외 무급공수 'K' )
  Select D.WorkCenter, D.WorkCenterName, 4, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
         Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
    From #Temp_MHList D,
         TMHCODE B,
       ( Select D.WorkCenter, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'K' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.WorkCenter, D.mhGubun, D.mhCode
       Union All
         Select 'XXXXX', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'K' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.mhGubun, D.mhCode ) C
   Where ( D.WorkCenter *= C.WorkCenter ) And
         ( B.mhGubun *= C.mhGubun ) And
         ( B.mhCode *= C.mhCode ) And
         ( B.mhGubun = 'K' ) And
         ( IsNull(B.useFlag,'0') = '1' )
      Group By D.WorkCenter, D.WorkCenterName, B.printSq, B.mhName, D.dispRate_bunmo
  Union
    SELECT WorkCenter, WorkCenterName, 5, 0, '1', '   무급공수 (E)',    excunpaidMH,
     Case dispRate_bunmo When 0 Then 0 Else round( excunpaidMH / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
  -- 평가제외 유급공수 'S'
  Select D.WorkCenter, D.WorkCenterName, 6, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
         Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
    From #Temp_MHList D,
         TMHCODE B,
       ( Select D.WorkCenter, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'S' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.WorkCenter, D.mhGubun, D.mhCode
     Union all
               Select 'XXXXX', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'S' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.mhGubun, D.mhCode ) C
   Where ( D.WorkCenter *= C.WorkCenter ) And
         ( B.mhGubun *= C.mhGubun ) And
         ( B.mhCode *= C.mhCode ) And
         ( B.mhGubun = 'S' ) And
         ( IsNull(B.useFlag,'0') = '1' )
  Group By D.WorkCenter, D.WorkCenterName, B.printSq, B.mhName, D.dispRate_bunmo
  Union
    SELECT WorkCenter, WorkCenterName, 7, 0, '1', '   유급공수 (F)',    excpaidMH,
     Case dispRate_bunmo When 0 Then 0 Else round( excpaidMH / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 8, 0, '0', '평가제외공수 (D=E+F)',   excunpaidMH + excpaidMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ( excunpaidMH + excpaidMH ) / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 9, 0, '0', '총투입공수 (G=A-D)',     totInMH,
     Case dispRate_bunmo When 0 Then 0 Else round( totInMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
  -- 유급근태사고공수 'B'
  Select D.WorkCenter, D.WorkCenterName, 10, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
         Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
    From #Temp_MHList D,
         TMHCODE B,
       ( Select D.WorkCenter, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'B' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.WorkCenter, D.mhGubun, D.mhCode
       Union all
         Select 'XXXXX', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'B' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.mhGubun, D.mhCode ) C
   Where ( D.WorkCenter *= C.WorkCenter ) And
         ( B.mhGubun *= C.mhGubun ) And
         ( B.mhCode *= C.mhCode ) And
         ( B.mhGubun = 'B' ) And
         ( IsNull(B.useFlag,'0') = '1' )
  Group By D.WorkCenter, D.WorkCenterName, B.printSq, B.mhName, D.dispRate_bunmo
  Union
    SELECT WorkCenter, WorkCenterName, 11, 0, '1', '   유급근태사고공수 (H)', gunteMH,
     Case dispRate_bunmo When 0 Then 0 Else round( gunteMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
  -- 일보사고공수 'G'
  Select D.WorkCenter, D.WorkCenterName, 12, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
         Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
    From #Temp_MHList D,
         TMHCODE B,
       ( Select D.WorkCenter, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'G' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.WorkCenter, D.mhGubun, D.mhCode
       Union all
         Select 'XXXXX', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYDETAIL D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'G' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.mhGubun, D.mhCode ) C
   Where ( D.WorkCenter *= C.WorkCenter ) And
         ( B.mhGubun *= C.mhGubun ) And
         ( B.mhCode *= C.mhCode ) And
         ( B.mhGubun = 'G' ) And
         ( IsNull(B.useFlag,'0') = '1' )
  Group By D.WorkCenter, D.WorkCenterName, B.printSq, B.mhName, D.dispRate_bunmo
  Union
    SELECT WorkCenter, WorkCenterName, 13, 0, '1', '   일보사고공수 (I)',   ilboMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ilboMH / dispRate_bunmo * 100, 1 ) End   From #Temp_MHList Union
  -- 부가작업공수 'F'
  Select D.WorkCenter, D.WorkCenterName, 14, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
         Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
    From #Temp_MHList D,
         TMHCODE B,
       ( Select D.WorkCenter, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'F' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.WorkCenter, D.mhGubun, D.mhCode
       Union all
         Select 'XXXXX', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'F' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.WorkCenter, D.mhGubun, D.mhCode ) C
   Where ( D.WorkCenter *= C.WorkCenter ) And
         ( B.mhGubun *= C.mhGubun ) And
         ( B.mhCode *= C.mhCode ) And
         ( B.mhGubun = 'F' ) And
         ( IsNull(B.useFlag,'0') = '1' )
  Group By D.WorkCenter, D.WorkCenterName, B.printSq, B.mhName, D.dispRate_bunmo
  Union
    SELECT WorkCenter, WorkCenterName, 15, 0, '1', '   부가작업공수 (J)',   bugaMH,
     Case dispRate_bunmo When 0 Then 0 Else round( bugaMH / dispRate_bunmo * 100, 1 ) End   From #Temp_MHList Union
  -- 유휴공수 'U'
  Select D.WorkCenter, D.WorkCenterName, 16, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
         Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
    From #Temp_MHList D,
         TMHCODE B,
       ( Select D.WorkCenter, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'U' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.WorkCenter, D.mhGubun, D.mhCode
       Union all
         Select 'XXXXX', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'U' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.mhGubun, D.mhCode ) C
   Where ( D.WorkCenter *= C.WorkCenter ) And
         ( B.mhGubun *= C.mhGubun ) And
         ( B.mhCode *= C.mhCode ) And
         ( B.mhGubun = 'U' ) And
         ( IsNull(B.useFlag,'0') = '1' )
  Group By D.WorkCenter, D.WorkCenterName, B.printSq, B.mhName, D.dispRate_bunmo
  Union
    SELECT WorkCenter, WorkCenterName, 17, 0, '1', '   유휴공수 (K)',   UnuseMH,
     Case dispRate_bunmo When 0 Then 0 Else round( UnuseMH / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 18, 0, '0', '비가동공수 계 (L=H+I+J+K)', gunteMH + ilboMH + bugaMH + UnuseMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ( gunteMH + ilboMH + bugaMH + UnuseMH ) / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 19, 0, '0', '실투입공수 {M=G-(H+I+J)}',  ActInMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ActInMH / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 20, 0, '0', '실동공수 (N=G-L)',    ActMH,
     Case dispRate_bunmo When 0 Then 0 Else round( ActMH / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
  -- 능률저하 'Z'
  Select D.WorkCenter, D.WorkCenterName, 21, B.printSq, '2', space(6) + B.mhName, sum(IsNull(C.subMH,0)),
         Case D.dispRate_bunmo When 0 Then 0 Else round( sum(IsNull(C.subMH,0)) / D.dispRate_bunmo * 100, 1 ) End
    From #Temp_MHList D,
         TMHCODE B,
       ( Select D.WorkCenter, D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'Z' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.WorkCenter, D.mhGubun, D.mhCode
       Union all
         Select 'XXXXX', D.mhGubun, D.mhCode, sum(IsNull(D.subMH,0)) subMH
     From TMHDAILYSUB D, TMHCODE E, TMHDAILYSTATUS F
    Where ( F.AreaCode = D.AreaCode ) And
          ( F.DivisionCode = D.DivisionCode ) And
          ( F.WorkCenter = D.WorkCenter ) And
          ( F.WorkDay = D.WorkDay ) And
          ( D.mhGubun = E.mhGubun ) And
          ( D.mhCode = E.mhCode ) And
          ( ( D.AreaCode = @ps_area ) And
            ( D.DivisionCode = @ps_div ) And
      ( D.WorkDay Between @ps_stFromDate And @ps_stToDate ) And
      ( D.mhGubun = 'Z' ) And
      ( IsNull(E.UseFlag,'0') = '1' ) And
      ( F.DailyStatus = '1' ) )
       Group By D.mhGubun, D.mhCode ) C
   Where ( D.WorkCenter *= C.WorkCenter ) And
         ( B.mhGubun *= C.mhGubun ) And
         ( B.mhCode *= C.mhCode ) And
         ( B.mhGubun = 'Z' ) And
         ( IsNull(B.useFlag,'0') = '1' )
  Group By D.WorkCenter, D.WorkCenterName, B.printSq, B.mhName, D.dispRate_bunmo
  Union
    SELECT WorkCenter, WorkCenterName, 22, 0, '1', '   능률저하공수', effDownMH,
     Case dispRate_bunmo When 0 Then 0 Else round( effDownMH / dispRate_bunmo * 100, 1 ) End  From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 23, 0, '0', '표준생산공수 (O)',  basicMH,
     Case dispRate_bunmo When 0 Then 0 Else round( basicMH / dispRate_bunmo * 100, 1 ) End    From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 24, 0, '0', '실동율 (P=N/G)',  Case totInMH When 0 Then 0 Else
                         round( ActMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 25, 0, '0', '작업효율 (Q=O/N)',  Case ActMH When 0 Then 0 Else
                         round( basicMH / ActMH * 100, 1 ) End, NULL From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 26, 0, '0', '종합효율 (R=P*Q)',  Case totInMH When 0 Then 0 Else
                         round( basicMH / totInMH * 100, 1 ) End, NULL From #Temp_MHList Union
    SELECT WorkCenter, WorkCenterName, 27, 0, '0', 'LPI',     lpi, NULL     From #Temp_MHList

  End

Select * From #Temp_dispName Order By WorkCenter, Seq1, Seq2

Drop Table #Temp_dispName
Drop Table #Temp_MHList
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

