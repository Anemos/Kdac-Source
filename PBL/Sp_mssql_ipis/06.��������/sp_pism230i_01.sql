SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_01]
GO


/*********************************************/ 
/*     완제품 단위당 표준 및 실투입MH조회   */ 
/* exec sp_pism230i_01 'D','A','2012.10.22' */
/*********************************************/ 

CREATE PROCEDURE sp_pism230i_01
	@ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_ToDate	Char(10)

AS
BEGIN

-- 해당일자 MH Summary
exec sp_pism230i_summary @ps_AreaCode,@ps_DivisionCode,@ps_ToDate
-- 호환품 Summary
exec sp_pism230i_summary_option @ps_AreaCode,@ps_DivisionCode,@ps_ToDate

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
  CASE WHEN E.ItemClass = '50' THEN 0 ELSE B.STDIN END STDIN,
  CASE WHEN E.ItemClass <> '50' THEN 0 ELSE B.STDOUT END STDOUT,
  CASE WHEN E.ItemClass = '50' THEN 0 ELSE B.ACTIN END ACTIN,
  CASE WHEN E.ItemClass <> '50' THEN 0 ELSE B.ACTOUT END ACTOUT,
  B.BASEPOWER
  FROM ( SELECT ZCMCD , ZPLANT, ZDIV, ZMDNO , 
	CAST(SUM( ZUNITQTY * ZSTDIN_S ) AS DECIMAL(15,5)) STDIN,
	CAST(SUM( ZUNITQTY * ZSTDOUT_S ) AS DECIMAL(15,5)) STDOUT,
	CAST(SUM( ZUNITQTY * ZACTIN_S ) AS DECIMAL(15,5)) ACTIN,
	CAST(SUM( ZUNITQTY * ZACTOUT_S ) AS DECIMAL(15,5)) ACTOUT,
	CAST(SUM(ZUNITQTY * ZBASEPOWER_S) AS DECIMAL(15,5)) BASEPOWER
	FROM TMHBASEBOM
	WHERE ZCMCD = '01' AND ZDATE = convert(char(8), cast(@ps_ToDate as datetime), 112) 
	  AND ZPLANT = @ps_AreaCode AND ZDIV = @ps_DivisionCode
		AND ( ZSTDIN_S <> 0 OR ZSTDOUT_S <> 0 OR ZACTIN_S <> 0 OR ZACTOUT <> 0 )
		GROUP BY ZCMCD, ZPLANT, ZDIV, ZMDNO) B,  
	 TMSTITEM D, 
	 TMSTMODEL E, 
	 TMSTPRODUCTGROUP F 
   WHERE ( B.ZPLANT = E.AreaCode ) And 
	 ( B.ZDIV = E.DivisionCode ) And 
	 ( B.ZMDNO = E.ItemCode ) And 
	 ( B.ZPLANT = F.AreaCode ) And 
	 ( B.ZDIV *= F.DivisionCode ) And 
	 ( E.ProductGroup = F.ProductGroup ) And  
	 ( B.ZMDNO = D.ItemCode )
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

