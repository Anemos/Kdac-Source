SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_01_pcc320_bpm]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_01_pcc320_bpm]
GO


/*********************************************/ 
/*    CC별 단위당 월별 표준 및 실투입MH조회   */ 
/* cc별 표준MH를 그대로 적용하고 완제품 합계에는 평균값MH을 적용함 */
/* exec sp_pism230i_01_pcc320_bpm 'D','A','2012.11.29','2013','0A' */
/*********************************************/ 

CREATE PROCEDURE sp_pism230i_01_pcc320_bpm
	@ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_ToDate	Char(10),
	@ps_xyear	Char(4),
	@ps_revno Char(2)

AS
BEGIN


SELECT B.AREACODE, 
  B.DIVISIONCODE,
  B.WORKCENTER,
  E.ProductGroup,
  B.ITEMCODE,
  G.STDCNT,
  G.ACTCNT,
  G.POWERCNT,
  G.MACCNT,
  E.ITEMCLASS,
  CAST(SUM(CASE WHEN E.ITEMCLASS = '50' THEN 0 ELSE B.AVGSTDSUM END ) / case when G.STDCNT = 0 then 1 else G.STDCNT end AS DECIMAL(12,6))  AS STDIN,
  CAST(SUM(CASE WHEN E.ITEMCLASS <> '50' THEN 0 ELSE B.AVGSTDSUM END ) / case when G.STDCNT = 0 then 1 else G.STDCNT end AS DECIMAL(12,6)) AS STDOUT,
  CAST(SUM(CASE WHEN E.ITEMCLASS = '50' THEN 0 ELSE B.AVGACTSUM END ) / case when G.ACTCNT = 0 then 1 else G.ACTCNT end AS DECIMAL(12,6)) AS ACTIN,
  CAST(SUM(CASE WHEN E.ITEMCLASS <> '50' THEN 0 ELSE B.AVGACTSUM END ) / case when G.ACTCNT = 0 then 1 else G.ACTCNT end  AS DECIMAL(12,6)) AS ACTOUT,
  CAST(SUM(B.AVGPOWERSUM ) / case when G.POWERCNT = 0 then 1 else G.POWERCNT end AS DECIMAL(12,6)) AS BASEPOWER,
  CAST(SUM(B.AVGMACTIMESUM ) / case when G.MACCNT = 0 then 1 else G.MACCNT end AS DECIMAL(12,6)) AS BASEMACTIME,
  SUM(B.PRODUCTQTY ) AS PRODUCTQTY
  FROM TMHBASEWORKCENTERBPM B LEFT OUTER JOIN TMSTITEM D
    ON ( B.ITEMCODE = D.ItemCode )
	 LEFT OUTER JOIN TMSTMODEL E
	  ON ( B.AREACODE = E.AreaCode ) And 
	    ( B.DIVISIONCODE = E.DivisionCode ) And 
	    ( B.ITEMCODE = E.ItemCode )
	 INNER JOIN ( select tmp.areacode as areacode,
	    tmp.divisioncode as divisioncode,
	    tmp.workcenter as workcenter,
	    tmp.itemcode as itemcode,
	    sum(case when isnull(tmp.std,0) = 0 then 0 else 1 end) as stdcnt, 
	    sum(case when isnull(tmp.act,0) = 0 then 0 else 1 end) as actcnt,
	    sum(case when isnull(tmp.power,0) = 0 then 0 else 1 end) as powercnt,
	    sum(case when isnull(tmp.mac,0) = 0 then 0 else 1 end) as maccnt
	  from ( select xyear,revno,areacode, divisioncode, workcenter, itemcode, 
	    sum(AVGSTDSUM) as std, 
	    sum(AVGACTSUM) as act,
	    sum(AVGPOWERSUM) as power,
	    sum(AVGMACTIMESUM) as mac
     from TMHBASEWORKCENTERBPM
     where zcmcd = '01' and xyear = @ps_xyear and revno = @ps_revno and
	    areacode = @ps_AreaCode and divisioncode = @ps_DivisionCode
	   group by xyear,revno,areacode, divisioncode, workcenter, itemcode ) tmp
	  group by tmp.areacode,
	    tmp.divisioncode,
	    tmp.workcenter,
	    tmp.itemcode ) G
	  ON  ( B.AREACODE = G.AreaCode ) And 
	    ( B.DIVISIONCODE = G.DivisionCode ) And 
	    ( B.WORKCENTER = G.WORKCENTER ) And
	    ( B.ITEMCODE = G.ItemCode )
	 LEFT OUTER JOIN TMSTPRODUCTGROUP F 
	  ON ( E.AREACODE = F.AreaCode ) And 
	    ( E.DIVISIONCODE = F.DivisionCode ) And
	    ( E.ProductGroup = F.ProductGroup )
   WHERE  ( B.ZCMCD = '01' ) AND
	 ( B.AREACODE = @ps_AreaCode ) AND
	 ( B.DIVISIONCODE = @ps_DivisionCode ) AND
	 ( B.XYEAR = @ps_xyear ) AND (B.REVNO = @ps_revno)
  GROUP BY B.AREACODE, 
    B.DIVISIONCODE,
    B.WORKCENTER,
    E.ProductGroup,
    B.ITEMCODE,
    G.STDCNT,
    G.ACTCNT,
    G.POWERCNT,
    G.MACCNT,
    E.ITEMCLASS

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

