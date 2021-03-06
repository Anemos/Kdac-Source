SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_01_pcc300]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_01_pcc300]
GO


/*********************************************/ 
/*     완제품 단위당 월별 표준 및 실투입MH조회   */ 
/* exec sp_pism230i_01_pcc300 '','D','A','201211' */
/*********************************************/ 

CREATE PROCEDURE sp_pism230i_01_pcc300
	@ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_tomonth	Char(6)

AS
BEGIN

declare @ls_applymm char(7),
  @ls_bomdate char(8),
  @ls_todate char(10),
  @li_chkcnt      int

set @ls_applymm = @ps_tomonth + '%'
set @ls_bomdate = ''
set @li_chkcnt = 0

while @li_chkcnt = 0
BEGIN
  
  select distinct top 1 @ls_bomdate = zdate
  from tmhbasebom
  where zcmcd = '01' and zplant = @ps_AreaCode and
    zdiv = @ps_DivisionCode and zdate like @ls_applymm and
    zdate > @ls_bomdate
  order by zdate

  if @@rowcount = 0
    break
  
  -- 해당일자 MH Summary
  set @ls_todate = convert(char(10), cast(@ls_bomdate as datetime), 102)
  exec sp_pism230i_summary @ps_AreaCode,@ps_DivisionCode,@ls_todate
  
END


SELECT B.ZPLANT, 
  B.ZDIV,
  E.ProductGroup,
  B.ZMDNO,
  G.STDINCNT,
  G.STDOUTCNT,
  G.ACTINCNT,
  G.ACTOUTCNT,
  G.POWERCNT,
  G.MACCNT,
  CAST(SUM(B.ZSTDIN) / case when G.STDINCNT = 0 then 1 else G.STDINCNT end AS DECIMAL(12,6))  AS STDIN,
  CAST(SUM(B.ZSTDOUT) / case when G.STDOUTCNT = 0 then 1 else G.STDOUTCNT end AS DECIMAL(12,6)) AS STDOUT,
  CAST(SUM(B.ZACTIN) / case when G.ACTINCNT = 0 then 1 else G.ACTINCNT end AS DECIMAL(12,6)) AS ACTIN,
  CAST(SUM(B.ZACTOUT) / case when G.ACTOUTCNT = 0 then 1 else G.ACTOUTCNT end AS DECIMAL(12,6)) AS ACTOUT,
  CAST(SUM(B.ZBASEPOWERIN + B.ZBASEPOWEROUT ) / case when G.POWERCNT = 0 then 1 else G.POWERCNT end AS DECIMAL(12,6)) AS BASEPOWER,
  CAST(SUM(B.ZBASEMACTIMEIN + B.ZBASEMACTIMEOUT ) / case when G.MACCNT = 0 then 1 else G.MACCNT end AS DECIMAL(12,6)) AS BASEMACTIME,
  SUM( 0 ) AS PRODUCTQTY
  FROM TMHBASESUMMARY B LEFT OUTER JOIN TMSTITEM D
    ON ( B.ZMDNO = D.ItemCode )
	 LEFT OUTER JOIN TMSTMODEL E
	  ON ( B.ZPLANT = E.AreaCode ) And 
	    ( B.ZDIV = E.DivisionCode ) And 
	    ( B.ZMDNO = E.ItemCode )
	 INNER JOIN ( select zplant as areacode,
	    zdiv as divisioncode,
	    zmdno as itemcode,
	    sum(case when isnull(zstdin,0) = 0 then 0 else 1 end) as stdincnt, 
	    sum(case when isnull(zstdout,0) = 0 then 0 else 1 end) as stdoutcnt,
	    sum(case when isnull(zactin,0) = 0 then 0 else 1 end) as actincnt, 
	    sum(case when isnull(zactout,0) = 0 then 0 else 1 end) as actoutcnt,
	    sum(case when isnull(zbasepowerin + zbasepowerout,0) = 0 then 0 else 1 end) as powercnt,
	    sum(case when isnull(zbasemactimein + zbasemactimeout,0) = 0 then 0 else 1 end) as maccnt
	  from TMHBASESUMMARY 
    where zcmcd = '01' and zdate like @ls_applymm and
	    zplant = @ps_AreaCode and zdiv = @ps_DivisionCode
	   group by zplant,zdiv,zmdno ) G
	  ON  ( B.ZPLANT = G.AreaCode ) And 
	    ( B.ZDIV = G.DivisionCode ) And 
	    ( B.ZMDNO = G.ItemCode )
	 LEFT OUTER JOIN TMSTPRODUCTGROUP F 
	  ON ( E.AREACODE = F.AreaCode ) And 
	    ( E.DIVISIONCODE = F.DivisionCode ) And
	    ( E.ProductGroup = F.ProductGroup )
   WHERE  ( B.ZCMCD = '01' ) AND
	 ( B.ZPLANT = @ps_AreaCode ) AND
	 ( B.ZDIV = @ps_DivisionCode ) AND
	 ( B.ZDATE like @ls_applymm )
  GROUP BY B.ZPLANT, 
    B.ZDIV,
    E.ProductGroup,
    B.ZMDNO,
    G.STDINCNT,
    G.STDOUTCNT,
    G.ACTINCNT,
    G.ACTOUTCNT,
    G.POWERCNT,
    G.MACCNT

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

