SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/*
Exec sp_pisq132i_01_graph
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
        @ps_QCDateFm        = '2002.01.01'      ,
        @ps_QCDateTo        = '2002.12.31'
*/


/****** Object:  Stored Procedure dbo.sp_pisq132i_01_graph    Script Date: 02-09-01  ******/
ALTER  PROCEDURE sp_pisq132i_01_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO
AS

BEGIN

	SELECT TOP 10
		   A.AREACODE                 AS AS_AREACODE	,
		   A.ITEMCODE                 AS AS_ITEMCODE    ,
           B.ITEMNAME          		  AS AS_ITEMNAME    ,   
		   sum(A.SUPPLIERDELIVERYQTY) AS AS_IN			,
		   sum(A.BADQTY)              AS AS_BAD		    ,
		   isnull((cast(SUM(A.BADQTY) as float) / cast(sum(A.SUPPLIERDELIVERYQTY) as float)) * 100, 0) AS AS_RATE
	  FROM TQQCRESULT    A,
		   TMSTITEM B
     WHERE A.ITEMCODE     *=  B.ITEMCODE 
       AND A.AREACODE      =  @ps_AreaCode
       AND A.DIVISIONCODE  =  @ps_DivisionCode
       AND A.QCDATE        >= @ps_QCDateFm
       AND A.QCDATE        <= @ps_QCDateTo
     GROUP BY A.AREACODE, A.ITEMCODE, B.ITEMNAME
	 HAVING sum(A.BADQTY) > 0
   ORDER BY AS_RATE DESC 
    
END 


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

