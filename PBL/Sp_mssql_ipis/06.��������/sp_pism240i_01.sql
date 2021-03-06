SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism240i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism240i_01]
GO


/*********************************************/ 
/*     조코드/품목 단위당 표준 및 실투입MH조회   */ 
/* exec sp_pism240i_01 'D','A','2012.10.22' */
/*********************************************/ 

CREATE PROCEDURE sp_pism240i_01
	@ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_ToDate	Char(10)

AS
BEGIN

-- 해당일자 MH Summary
-- sp_pism230i_summary_batchjob에서 수행하도록 수정 2012.11.26
--exec sp_pism230i_summary @ps_AreaCode,@ps_DivisionCode,@ps_ToDate

SELECT B.AREACODE, 
  B.DIVISIONCODE,
  B.WORKCENTER,
  ( SELECT DEPTNAME4 FROM TMSTDEPT WHERE DEPTCODE = B.WORKCENTER ) AS WORKCENTERNAME,
  E.ProductGroup,
  F.ProductGroupName, 
  E.ModelGroup, 
  ( Select ModelGroupName From TMSTMODELGROUP 
	  Where ( Areacode = B.AREACODE ) And 
		( DivisionCode = B.DIVISIONCODE ) And 
		( ProductGroup = E.ProductGroup ) And 
		( ModelGroup = E.ModelGroup ) ) ModelGroupName, 
  B.ITEMCODE,
  D.ItemName,
  D.ItemSpec,
  E.ItemClass,
  E.ItemBuySource,
  SUM(CASE WHEN E.ITEMCLASS = '50' THEN 0 ELSE B.AVGSTDSUM END ) AS STDIN,
  SUM(CASE WHEN E.ITEMCLASS <> '50' THEN 0 ELSE B.AVGSTDSUM END ) AS STDOUT,
  SUM(CASE WHEN E.ITEMCLASS = '50' THEN 0 ELSE B.AVGACTSUM END ) AS ACTIN,
  SUM(CASE WHEN E.ITEMCLASS <> '50' THEN 0 ELSE B.AVGACTSUM END ) AS ACTOUT,
  SUM(B.AVGPOWERSUM ) AS BASEPOWER,
  SUM(B.AVGMACTIMESUM ) AS BASEMACTIME,
  SUM(B.PRODUCTQTY ) AS PRODUCTQTY
  FROM TMHBASEWORKCENTER B INNER JOIN TMSTITEM D
    ON ( B.ITEMCODE = D.ItemCode )
	 INNER JOIN TMSTMODEL E
	  ON ( B.AREACODE = E.AreaCode ) And 
	    ( B.DIVISIONCODE = E.DivisionCode ) And 
	    ( B.ITEMCODE = E.ItemCode )
	 LEFT OUTER JOIN TMSTPRODUCTGROUP F 
	  ON ( E.AREACODE = F.AreaCode ) And 
	    ( E.DIVISIONCODE = F.DivisionCode ) And
	    ( E.ProductGroup = F.ProductGroup )
   WHERE  ( B.ZCMCD = '01' ) AND
	 ( B.AREACODE = @ps_AreaCode ) AND
	 ( B.DIVISIONCODE = @ps_DivisionCode ) AND
	 ( B.ZDATE = convert(char(8), cast(@ps_ToDate as datetime), 112) )
GROUP BY B.AREACODE,   
   B.DIVISIONCODE,   
   B.WORKCENTER,
   E.ProductGroup, 
	 F.ProductGroupName, 
	 E.ModelGroup, 
	 B.ITEMCODE,
	 D.ItemName,
	 D.ItemSpec,
	 E.ItemClass,
   E.ItemBuySource
ORDER By B.AREACODE,   
   B.DIVISIONCODE,   
   B.WORKCENTER,
   E.ProductGroup, 
	 F.ProductGroupName, 
	 E.ModelGroup, 
	 B.ITEMCODE,
	 D.ItemName,
	 D.ItemSpec

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

