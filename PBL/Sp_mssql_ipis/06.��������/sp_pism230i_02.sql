SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_02]
GO


/************************************************/
/*     완제품 단위당 세부내역 표준 및 실투입MH조회     */
/*   exec sp_pism230i_02 'D','A','2012.10.22','211302V' */
/************************************************/

CREATE PROCEDURE sp_pism230i_02
  @ps_AreaCode Char(1),
  @ps_DivisionCode Char(1),
  @ps_ToDate  Char(10),
  @ps_modItem Varchar(12)   -- 완제품 코드

AS
BEGIN

SELECT B.ZPLANT,
  B.ZDIV,
  B.ZMDNO,
  ( Select ItemClass From TMSTMODEL WHERE AreaCode = B.ZPLANT AND DivisionCode = B.ZDIV AND ItemCode = B.ZMDNO ) ItemClass,
  B.ZLEVEL,
  E.ProductGroup,
  F.ProductGroupName,
  E.ModelGroup,
  ( Select ModelGroupName From TMSTMODELGROUP
    Where ( Areacode = B.ZPLANT ) And
    ( DivisionCode = B.ZDIV ) And
    ( ProductGroup = E.ProductGroup ) And
    ( ModelGroup = E.ModelGroup ) ) ModelGroupName,
  B.ZITNO,
  D.ItemName,
  B.ZWHLCODE,
  B.ZSRCE,
  B.ZUNITQTY,
  B.ZGRAD,
  B.STDIN,
  B.STDOUT,
  B.ACTIN,
  B.ACTOUT,
  B.BASEPOWER
  FROM ( SELECT ZCMCD , ZPLANT, ZDIV, ZMDNO , ZITNO, ZLEVEL,
    ZUNITQTY,ZSERIAL,ZWHLCODE,ZSRCE,ZGRAD,
  CAST(( ZUNITQTY * ZSTDIN_S ) AS DECIMAL(15,5)) STDIN,
  CAST(( ZUNITQTY * ZSTDOUT_S ) AS DECIMAL(15,5)) STDOUT,
  CAST(( ZUNITQTY * ZACTIN_S ) AS DECIMAL(15,5)) ACTIN,
  CAST(( ZUNITQTY * ZACTOUT_S ) AS DECIMAL(15,5)) ACTOUT,
  CAST(( ZUNITQTY * ZBASEPOWER_S ) AS DECIMAL(15,5)) BASEPOWER
  FROM TMHBASEBOM
  WHERE ZCMCD = '01' AND ZDATE = convert(char(8), cast(@ps_ToDate as datetime), 112) 
    AND ZPLANT = @ps_AreaCode AND ZDIV = @ps_DivisionCode AND ZMDNO = @ps_modItem ) B,
   TMSTITEM D,
   TMSTMODEL E,
   TMSTPRODUCTGROUP F
   WHERE ( B.ZPLANT = E.AreaCode ) And
   ( B.ZDIV = E.DivisionCode ) And
   ( B.ZITNO = E.ItemCode ) And
   ( B.ZPLANT = F.AreaCode ) And
   ( B.ZDIV *= F.DivisionCode ) And
   ( E.ProductGroup = F.ProductGroup ) And
   ( B.ZITNO = D.ItemCode )
ORDER By B.ZPLANT,
         B.ZDIV,
   B.ZMDNO,
   B.ZSERIAL

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

