SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*
Exec sp_pisq132i_02_graph
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
        @ps_QCDateFm        = '2002.01.01'      ,
        @ps_QCDateTo        = '2002.12.31'
*/


/****** Object:  Stored Procedure dbo.sp_pisq132i_02_graph    Script Date: 02-09-01  ******/
ALTER  PROCEDURE sp_pisq132i_02_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO
AS

BEGIN

	SELECT TOP 10
		   AS_AREA                     AS AS_AREACODE	,
		   AS_ITEM                     AS AS_ITEMCODE   ,
           AS_ITEMNAME 		           AS AS_ITEMNAME 	,   
		   sum(AS_SUPPLIERDELIVERYQTY) AS AS_IN			,
		   sum(AS_BADQTY)              AS AS_BAD		,
		   (cast(SUM(AS_BADQTY) as float) / cast(sum(AS_SUPPLIERDELIVERYQTY) as float)) * 100 AS AS_RATE
	  FROM (
			SELECT A.AREACODE 		             AS AS_AREA,
				   A.ITEMCODE	                 AS AS_ITEM,
                   B.ITEMNAME             		 AS AS_ITEMNAME ,   
				   count(A.SUPPLIERDELIVERYQTY)  AS AS_SUPPLIERDELIVERYQTY,
				   0                             AS AS_BADQTY
			  FROM TQQCRESULT    A,
		           TMSTITEM      B
		     WHERE A.ITEMCODE      *= B.ITEMCODE 
		       AND A.AREACODE      =  @ps_AreaCode
		       AND A.DIVISIONCODE  =  @ps_DivisionCode
		       AND A.QCDATE        >= @ps_QCDateFm
		       AND A.QCDATE        <= @ps_QCDateTo
		     GROUP BY A.AREACODE, A.ITEMCODE, B.ITEMNAME
	
			UNION ALL
	
			SELECT A.AREACODE 		             AS AS_AREA,
				   A.ITEMCODE	                 AS AS_ITEM,
                   B.ITEMNAME                    AS AS_ITEMNAME ,   
				   0                             AS AS_SUPPLIERDELIVERYQTY,
				   count(A.BADQTY)	             AS AS_BADQTY
			  FROM TQQCRESULT    A,
		           TMSTITEM      B
		     WHERE A.ITEMCODE     *=  B.ITEMCODE 
		       AND A.AREACODE      =  @ps_AreaCode
		       AND A.DIVISIONCODE  =  @ps_DivisionCode
		       AND A.QCDATE        >= @ps_QCDateFm
		       AND A.QCDATE        <= @ps_QCDateTo
	           AND A.JUDGEFLAG     IN ('2', '3')
		     GROUP BY A.AREACODE, A.ITEMCODE, B.ITEMNAME
		) TMP
		GROUP BY AS_AREA,
		         AS_ITEM,
                 AS_ITEMNAME 
	 	HAVING   sum(AS_BADQTY) > 0
		ORDER BY (cast(SUM(AS_BADQTY) as float) / cast(sum(AS_SUPPLIERDELIVERYQTY) as float)) * 100  DESC
    
END 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

