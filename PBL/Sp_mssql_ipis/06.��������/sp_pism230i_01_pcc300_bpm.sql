SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_01_pcc300_bpm]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_01_pcc300_bpm]
GO


/*********************************************/ 
/*     완제품 단위당 월별 표준 및 실투입MH조회   */ 
/* exec sp_pism230i_01_pcc300_bpm 'D','A','2012.11.29','2013','0A' */
/*********************************************/ 

CREATE PROCEDURE sp_pism230i_01_pcc300_bpm
	@ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
	@ps_ToDate	Char(10),
	@ps_xyear	Char(4),
	@ps_revno Char(2)

AS
BEGIN

exec sp_pism230i_summary_bpm @ps_AreaCode,@ps_DivisionCode,@ps_ToDate,@ps_xyear,@ps_revno


SELECT B.ZPLANT, 
  B.ZDIV,
  E.ProductGroup,
  B.ZMDNO,
  B.ZSTDIN  AS STDIN,
  B.ZSTDOUT AS STDOUT,
  B.ZACTIN AS ACTIN,
  B.ZACTOUT AS ACTOUT,
  (B.ZBASEPOWERIN + B.ZBASEPOWEROUT ) AS BASEPOWER,
  (B.ZBASEMACTIMEIN + B.ZBASEMACTIMEOUT ) AS BASEMACTIME,
  0  AS PRODUCTQTY
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

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

