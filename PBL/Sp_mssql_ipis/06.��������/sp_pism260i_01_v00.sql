SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism260i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism260i_01]
GO


/*********************************************/ 
/*     사업계획용 조코드/품목 단위당 표준 및 실투입MH조회   */ 
/* exec sp_pism260i_01 'D','A','2013','0A' */
/*********************************************/ 

CREATE PROCEDURE sp_pism260i_01
	@ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_xyear	Char(4),
	@ps_revno Char(2)

AS
BEGIN

-- 해당일자 MH Summary : 회계작업생성시에 수행
-- exec sp_pism230i_summary_bpm @ps_AreaCode,@ps_DivisionCode,@ps_xyear,@ps_revno

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
  SUM(CASE WHEN B.AREACODE IN ('B','Y','K') THEN  0 ELSE 
        CASE WHEN E.ITEMCLASS = '50' THEN 0 ELSE B.AVGSTDSUM END
      END ) AS STDIN,
  SUM(CASE WHEN B.AREACODE IN ('B','Y','K') THEN B.AVGSTDSUM ELSE
        CASE WHEN E.ITEMCLASS <> '50' THEN 0 ELSE B.AVGSTDSUM END
      END ) AS STDOUT,
  SUM(CASE WHEN B.AREACODE IN ('B','Y','K') THEN  0 ELSE
        CASE WHEN E.ITEMCLASS = '50' THEN 0 ELSE B.AVGACTSUM END
      END ) AS ACTIN,
  SUM(CASE WHEN B.AREACODE IN ('B','Y','K') THEN B.AVGACTSUM ELSE
        CASE WHEN E.ITEMCLASS <> '50' THEN 0 ELSE B.AVGACTSUM END
      END ) AS ACTOUT,
  SUM(B.AVGPOWERSUM ) AS BASEPOWER,
  SUM(B.AVGMACTIMESUM ) AS BASEMACTIME,
  SUM(B.PRODUCTQTY ) AS PRODUCTQTY
  FROM TMHBASEWORKCENTERBPM B LEFT OUTER JOIN TMSTITEM D
    ON ( B.ITEMCODE = D.ItemCode )
	 LEFT OUTER JOIN TMSTMODEL E
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
	 ( B.XYEAR = @ps_xyear ) AND ( B.REVNO = @ps_revno )
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

