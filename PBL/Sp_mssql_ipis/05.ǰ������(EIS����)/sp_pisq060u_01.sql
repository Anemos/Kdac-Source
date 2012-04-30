SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO






/*
Exec sp_pisq060u_01
		@ps_areacode        = 'D'   ,
		@ps_divisioncode    = 'H'   ,
        @ps_ProductGroup    = '%'   ,
        @ps_ModelGroup      = '%'
*/


/****** Object:  Stored Procedure dbo.sp_pisq060u_01    Script Date: 03-06-19  ******/
ALTER       PROCEDURE sp_pisq060u_01
        @ps_areacode          char(01)      ,   -- 지역구분
        @ps_divisioncode      char(01)      ,   -- 공장코드
        @ps_ProductGroup      varchar(02)   ,   -- 제품군
        @ps_ModelGroup        varchar(03)       -- 모델군

AS

BEGIN
    SELECT AS_AREACODE       ,   
       AS_DIVISIONCODE   ,   
       B.ITEMCODE       ,   
       C.ITEMNAME       ,   
       B.SUPPLIERCODE   ,
       D.SUPPLIERKORNAME,   
		 AS_PRODUCTGROUP  ,
       AS_MODELGROUP    ,
		 AS_CLASS	,
		 AS_SOURCE	,
       ' '   DEL_CHK       
FROM TMSTPARTCOST B, 
     (SELECT A.AREACODE       AS_AREACODE     ,   
            A.DIVISIONCODE   AS_DIVISIONCODE ,   
            A.ITEMCODE       AS_ITEMCODE     ,
				A.PRODUCTGROUP   AS_PRODUCTGROUP ,
            A.MODELGROUP     AS_MODELGROUP,
				A.ITEMCLASS AS_CLASS,
				A.ITEMBUYSOURCE AS_SOURCE
      FROM TMSTMODEL  A
            WHERE A.AREACODE       = @ps_AreaCode
               AND A.DIVISIONCODE   = @ps_DivisionCode
               AND A.PRODUCTGROUP   LIKE @ps_ProductGroup
               AND A.MODELGROUP     LIKE @ps_ModelGroup
               AND A.ITEMCLASS	IN ('10', '20', '35', '40', '50') ) AS TEMP,
TMSTITEM        C,
TMSTSUPPLIER    D
WHERE B.ITEMCODE = AS_ITEMCODE 
	AND NOT EXISTS ( SELECT * FROM TMSTPARTKB F
		WHERE  AS_AREACODE = F.AREACODE
	 		AND AS_DIVISIONCODE = F.DIVISIONCODE 
	 		AND B.ITEMCODE = F.ITEMCODE
	 		AND B.SUPPLIERCODE = F.SUPPLIERCODE
			AND ( F.USEFLAG = 'N'
				OR ( F.USEFLAG = 'Y' AND F.APPLYFROM > CONVERT(CHAR(10),GETDATE(),102) ) ) )
    AND B.ITEMCODE      *= C.ITEMCODE
    AND B.SUPPLIERCODE  *= D.SUPPLIERCODE
    AND AS_AREACODE + AS_DIVISIONCODE + B.ITEMCODE + B.SUPPLIERCODE  NOT IN
    ( SELECT E.AREACODE + E.DIVISIONCODE + E.ITEMCODE + E.SUPPLIERCODE 
		FROM TQQCITEM01 E )
END 







GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

