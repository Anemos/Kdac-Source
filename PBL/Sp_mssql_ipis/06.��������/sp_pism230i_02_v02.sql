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
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN 0 ELSE B.STDIN END AS STDIN,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN B.STDIN ELSE B.STDOUT END AS STDOUT,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN 0 ELSE B.ACTIN END AS ACTIN,
  CASE WHEN B.ZPLANT IN ('B','K','Y') THEN B.ACTIN ELSE B.ACTOUT END ACTOUT,
  B.BASEPOWER,
  B.BASEMACTIME,
  B.SUBLINECODE,
  B.SUBLINENO,
  B.WORKCENTER,
  ( SELECT DEPTNAME4 FROM TMSTDEPT WHERE DEPTCODE = B.WORKCENTER ) AS WORKCENTERNAME
FROM ( SELECT A.ZCMCD AS ZCMCD, A.ZPLANT AS ZPLANT, A.ZDIV AS ZDIV, 
    A.ZMDNO AS ZMDNO, A.ZITNO AS ZITNO, A.ZLEVEL AS ZLEVEL,
    A.ZUNITQTY AS ZUNITQTY,A.ZSERIAL AS ZSERIAL,A.ZWHLCODE AS ZWHLCODE,
    A.ZSRCE AS ZSRCE,A.ZGRAD AS ZGRAD,
    B.SUBLINECODE AS SUBLINECODE, B.SUBLINENO AS SUBLINENO,
    B.WORKCENTER AS WORKCENTER,
  CAST(( A.ZUNITQTY * CASE WHEN A.ZWHLCODE = '50' OR ( A.ZSERIAL <> 1 AND ISNULL(C.RITNO,'N') <> 'N' ) THEN 0 ELSE ISNULL(B.AVGSTDSUM,0) END ) AS DECIMAL(15,6)) STDIN,
  CAST(( A.ZUNITQTY * CASE WHEN A.ZWHLCODE <> '50' OR ( A.ZSERIAL <> 1 AND ISNULL(C.RITNO,'N') <> 'N' ) THEN 0 ELSE ISNULL(B.AVGSTDSUM,0) END ) AS DECIMAL(15,6)) STDOUT,
  CAST(( A.ZUNITQTY * CASE WHEN A.ZWHLCODE = '50' OR ( A.ZSERIAL <> 1 AND ISNULL(C.RITNO,'N') <> 'N' ) THEN 0 ELSE ISNULL(B.AVGACTSUM,0) END ) AS DECIMAL(15,6)) ACTIN,
  CAST(( A.ZUNITQTY * CASE WHEN A.ZWHLCODE <> '50' OR ( A.ZSERIAL <> 1 AND ISNULL(C.RITNO,'N') <> 'N' ) THEN 0 ELSE ISNULL(B.AVGACTSUM,0) END ) AS DECIMAL(15,6)) ACTOUT,
  CAST(( A.ZUNITQTY * CASE WHEN ( A.ZSERIAL <> 1 AND ISNULL(C.RITNO,'N') <> 'N' ) THEN 0 ELSE ISNULL(B.AVGPOWERSUM,0) END ) AS DECIMAL(15,6)) BASEPOWER,
  CAST(( A.ZUNITQTY * CASE WHEN ( A.ZSERIAL <> 1 AND ISNULL(C.RITNO,'N') <> 'N' ) THEN 0 ELSE ISNULL(B.AVGMACTIMESUM,0) END ) AS DECIMAL(15,6)) BASEMACTIME
  FROM TMHBASEBOM A LEFT OUTER JOIN TMHBASEWORKCENTER B
    ON A.ZCMCD = B.ZCMCD AND A.ZDATE = B.ZDATE AND A.ZPLANT = B.AREACODE AND
      A.ZDIV = B.DIVISIONCODE AND ZITNO = B.ITEMCODE
    LEFT OUTER JOIN TMSTROUTINGSUB C
    ON B.ZCMCD = C.RCMCD AND B.AREACODE = C.RPLANT AND
      B.DIVISIONCODE = C.RDVSN AND B.ITEMCODE = C.RITNO
  WHERE A.ZCMCD = '01' AND A.ZDATE = convert(char(8), cast(@ps_ToDate as datetime), 112) 
    AND A.ZPLANT = @ps_AreaCode AND A.ZDIV = @ps_DivisionCode AND A.ZMDNO = @ps_modItem 
    AND ( A.zstdin_s <> 0 or A.zstdout_s <> 0 or A.zactin_s <> 0 or A.zactout_s <> 0 or A.zbasepower_s <> 0 )) B
  INNER JOIN TMSTITEM D
  ON ( B.ZITNO = D.ItemCode )
  INNER JOIN TMSTMODEL E
  ON ( B.ZPLANT = E.AreaCode ) And
   ( B.ZDIV = E.DivisionCode ) And
   ( B.ZITNO = E.ItemCode )
  LEFT OUTER JOIN TMSTPRODUCTGROUP F
  ON ( E.AreaCode = F.AreaCode ) And
   ( E.DivisionCode = F.DivisionCode ) And
   ( E.ProductGroup = F.ProductGroup )
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

