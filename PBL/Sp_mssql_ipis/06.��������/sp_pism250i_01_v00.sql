SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism250i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism250i_01]
GO


/*********************************************/ 
/*   사업계획용 완제품 단위당 표준 및 실투입MH조회   */ 
/* exec sp_pism250i_01 'D','A','2013','0A' */
/*********************************************/ 

CREATE PROCEDURE sp_pism250i_01
	@ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_xyear	Char(4),
	@ps_revno Char(2)

AS
BEGIN

-- 해당일자 MH Summary : 회계작업시에 생성함
--exec sp_pism230i_summary_bpm @ps_AreaCode,@ps_DivisionCode,@ps_ToDate

SELECT B.ZPLANT, 
  B.ZDIV,   
  E.ProductGroup,
  F.ProductGroupName, 
  E.ModelGroup, 
  ( Select ModelGroupName From TMSTMODELGROUP 
	  Where ( Areacode = B.ZPLANT ) And 
		( DivisionCode = B.ZDIV ) And 
		( ProductGroup = E.ProductGroup ) And 
		( ModelGroup = E.ModelGroup ) ) ModelGroupName, 
  B.ZMDNO,
  D.ItemName,
  D.ItemSpec,
  E.ItemClass,
  E.ItemBuySource,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN 0 ELSE B.ZSTDIN END AS STDIN,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN B.ZSTDIN ELSE B.ZSTDOUT END AS STDOUT,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN 0 ELSE B.ZACTIN END AS ACTIN,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN B.ZACTIN ELSE B.ZACTOUT END AS ACTOUT,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN 0 ELSE B.ZBASEPOWERIN END AS BASEPOWERIN,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN B.ZBASEPOWERIN ELSE B.ZBASEPOWEROUT END AS BASEPOWEROUT,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN 0 ELSE B.ZBASEMACTIMEIN END AS BASEMACTIMEIN,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN B.ZBASEMACTIMEIN ELSE B.ZBASEMACTIMEOUT END AS BASEMACTIMEOUT
  FROM TMHBASESUMMARYBPM B LEFT OUTER JOIN TMSTITEM D
    ON ( B.ZMDNO = D.ItemCode )
	 LEFT OUTER JOIN TMSTMODEL E
	  ON ( B.ZPLANT = E.AreaCode ) And 
	    ( B.ZDIV = E.DivisionCode ) And 
	    ( B.ZMDNO = E.ItemCode )
	 LEFT OUTER JOIN TMSTPRODUCTGROUP F
	  ON ( E.AREACODE = F.AreaCode ) And 
	    ( E.DIVISIONCODE = F.DivisionCode ) And
	    ( E.ProductGroup = F.ProductGroup )
   WHERE  ( B.ZCMCD = '01' ) AND
	 ( B.ZPLANT = @ps_AreaCode ) AND
	 ( B.ZDIV = @ps_DivisionCode ) AND
	 ( B.XYEAR = @ps_xyear ) AND ( B.REVNO = @ps_revno )
ORDER By B.ZPLANT,   
         B.ZDIV,   
     E.ProductGroup, 
	 F.ProductGroupName, 
	 E.ModelGroup, 
	 B.ZMDNO,
	 D.ItemName,
	 D.ItemSpec

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

