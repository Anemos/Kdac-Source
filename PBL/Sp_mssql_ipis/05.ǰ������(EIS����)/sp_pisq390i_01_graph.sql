/************************************************************************************************/
/*	File Name	: sp_pisq390i_01_graph.SQL                                                      */
/*	SYSTEM		: 품질관리(고객품질)                                                            */
/*	Description	: Warranty율 추이그래프	                                                        */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQMANAGEMASTER																*/
/*  			  TMSTPRODUCTGROUP																*/
/*  			  TLOTNO  																		*/
/*  			  VMSTKB_MODEL 																	*/
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_DateFm            char(10)    => 조회일자FROM                             */
/*                @ps_DateTo            char(10)    => 조회일자TO                               */
/*	Notes		: Warranty율 추이그래프를 화면에 표시한다                                       */
/*	Made Date	: 2002. 10. 31                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq390i_01_graph') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq390i_01_graph
GO
/*
Exec sp_pisq390i_01_graph
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_DateFm          = '2002.12.01',
		@ps_DateTo          = '2002.12.31'

*/


/****** Object:  Stored Procedure dbo.sp_pisq390i_01_graph    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq390i_01_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_DateFm            char(10)      ,   -- 조회일자FROM
		@ps_DateTo            char(10)          -- 조회일자TO
AS

BEGIN

	SELECT	AS_YYYYMM			AS AS_DATE		,
			SUM(M_SHIPQTY) / 24	AS AS_SHIPQTY	, 
			SUM(M_QTY)			AS AS_QTY		,
			CASE WHEN (SUM(M_SHIPQTY) / 24) = 0 
			     THEN 0 
			     ELSE ISNULL(SUM(M_QTY) / (CAST(SUM(M_SHIPQTY) / 24 AS FLOAT)) * 100, 0) END AS AS_RATE
	  FROM	(
			SELECT	CONVERT(CHAR(7), DATEADD(month, -11, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode

			UNION ALL

			SELECT	CONVERT(CHAR(7), DATEADD(month, -10, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -34, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -10, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -34, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -10, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -09, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -33, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -09, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -33, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -09, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -08, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -32, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -08, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -32, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -08, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -07, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -31, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -31, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -06, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -30, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -30, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -05, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -29, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -05, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -29, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -05, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -04, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -28, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -04, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -28, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -04, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -03, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -27, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -03, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -27, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -03, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -02, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -26, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -02, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -26, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -02, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -01, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -25, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -01, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -25, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -01, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			   
			UNION ALL
			
			SELECT	CONVERT(CHAR(7), DATEADD(month, -00, @ps_DateTo), 102)	AS AS_YYYYMM,
					isnull(SUM(A.SHIPQTY), 0)								AS M_SHIPQTY,
					0														AS M_QTY
			  FROM	TLOTNO  A,
					( SELECT B.AREACODE			AS AREACODE		,
					 		 B.DIVISIONCODE		AS DIVISIONCODE	,
			   	 			 B.ITEMCODE			AS ITEMCODE		,
					 		 B.PRODUCTGROUP 	AS PRODUCTGROUP	,
					 		 B.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO  A,
							 VMSTKB_MODEL B
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -24, @ps_DateFm), 102)
			   			 AND A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102)
			   			 AND A.SHIPGUBUN	=  @ps_DivisionCode
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			B.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -24, @ps_DateFm), 102)
			   AND  A.TRACEDATE		<= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102)
			   AND  A.SHIPGUBUN		=  @ps_DivisionCode
			
			UNION ALL
			
			SELECT	SUBSTRING(A.ACCOUNTDATE,1,7)							AS AS_yyyymm,
					0														AS M_SHIPQTY,
					isnull(SUM(A.CONFIRMQTY), 0)							AS M_qty
			  FROM	TQMANAGEMASTER	   A,
					TMSTPRODUCTGROUP   B 
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.PRODUCTGROUP	=  B.PRODUCTGROUP
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.ACCOUNTDATE	>= CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFm), 102)
			   AND  A.ACCOUNTDATE	<= SUBSTRING(@ps_DateFm, 1, 7)
			   AND  A.EXPORTGUBUN	=  'D'
			 GROUP  BY SUBSTRING(A.ACCOUNTDATE,1,7)
	) TMP
	GROUP BY AS_YYYYMM

END 

go
