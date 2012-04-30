SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO



/*
Exec sp_pisq133i_02_graph
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
		@ps_suppliercode    = '%'				,
		@ps_itemcode		= '%'				,
        @ps_QCDateFm        = '2002.01.01'      ,
        @ps_QCDateTo        = '2002.12.31'		

*/


/****** Object:  Stored Procedure dbo.sp_pisq133i_02_graph    Script Date: 02-09-01  ******/
ALTER  PROCEDURE sp_pisq133i_02_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_suppliercode      varchar(05)	,	-- 협력업체코드
		@ps_itemcode 		  varchar(12) 	,	-- 품번코드
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO

AS

BEGIN

	SELECT A.BADREASON					AS AS_BADREASON	,
		   CASE A.BADREASON
				WHEN '1' THEN '외관불량'
				WHEN '2' THEN '치수불량'
				WHEN '3' THEN '성능불량'
				WHEN '4' THEN '형상불량'
				WHEN '5' THEN '재질불량'
				WHEN '6' THEN '기타불량'
			END 			AS AS_INAME		,
		   AS_INQTY			AS AS_IN		,
		   count(A.BADQTY)	AS AS_BAD	    ,
		   (cast(count(A.BADQTY) as float) / cast(AS_INQTY as float)) * 100 AS AS_RATE
	  FROM TQQCRESULT A,
		   ( SELECT count(A.SUPPLIERDELIVERYQTY)	AS AS_INQTY
			   FROM TQQCRESULT A
     		  WHERE A.AREACODE      =	@ps_AreaCode
       		    AND A.DIVISIONCODE  =	@ps_DivisionCode
	   			AND A.SUPPLIERCODE  LIKE @ps_suppliercode
	   			AND A.ITEMCODE	    LIKE @ps_itemcode
       			AND A.QCDATE        >=	@ps_QCDateFm
       			AND A.QCDATE        <=	@ps_QCDateTo ) TMP
     WHERE A.AREACODE      =	@ps_AreaCode
       AND A.DIVISIONCODE  =	@ps_DivisionCode
	   AND A.SUPPLIERCODE  LIKE @ps_suppliercode
	   AND A.ITEMCODE	   LIKE @ps_itemcode
       AND A.QCDATE        >=	@ps_QCDateFm
       AND A.QCDATE        <=	@ps_QCDateTo
       AND A.BADREASON     IN	('1','2','3','4','5','6')
     GROUP BY A.BADREASON, AS_INQTY

END 




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

