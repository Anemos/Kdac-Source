/************************************************************************************************/
/*	File Name	: sp_pisq390i_01.SQL                                                            */
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
/*	Made Date	: 2002. 10. 07                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq390i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq390i_01
GO
/*
Exec sp_pisq390i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_DateFm          = '2002.12.01' ,
		@ps_DateTo          = '2002.12.31'

*/


/****** Object:  Stored Procedure dbo.sp_pisq390i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq390i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_DateFm            char(10)      ,   -- 조회일자FROM
		@ps_DateTo            char(10)          -- 조회일자TO
AS

BEGIN


	SELECT	AS_PRODUCT		,
			AS_PRODUCTNAME	,
			-- 24개월 평균출하수량
			SUM(M_24A11) / 24 AS AS_24A11,
			SUM(M_24A10) / 24 AS AS_24A10,
			SUM(M_24A09) / 24 AS AS_24A09,
			SUM(M_24A08) / 24 AS AS_24A08,
			SUM(M_24A07) / 24 AS AS_24A07,
			SUM(M_24A06) / 24 AS AS_24A06,
			SUM(M_24A05) / 24 AS AS_24A05,
			SUM(M_24A04) / 24 AS AS_24A04,
			SUM(M_24A03) / 24 AS AS_24A03,
			SUM(M_24A02) / 24 AS AS_24A02,
			SUM(M_24A01) / 24 AS AS_24A01,
			SUM(M_24A00) / 24 AS AS_24A00,
			SUM(M_24ATOT) / 24 AS AS_24ATOT,
			-- 당월 정산수량
			SUM(M_C11) AS AS_C11,
			SUM(M_C10) AS AS_C10,
			SUM(M_C09) AS AS_C09,
			SUM(M_C08) AS AS_C08,
			SUM(M_C07) AS AS_C07,
			SUM(M_C06) AS AS_C06,
			SUM(M_C05) AS AS_C05,
			SUM(M_C04) AS AS_C04,
			SUM(M_C03) AS AS_C03,
			SUM(M_C02) AS AS_C02,
			SUM(M_C01) AS AS_C01,
			SUM(M_C00) AS AS_C00,
			SUM(M_CTOT) AS AS_CTOT
	  FROM  (
			SELECT	B.PRODUCTGROUP 		AS AS_PRODUCT		,
					B.PRODUCTGROUPNAME	AS AS_PRODUCTNAME	,
					-- 24개월 평균출하수량
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A11,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -34, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A10,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -33, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A09,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -32, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A08,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -31, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A07,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -30, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A06,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -29, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A05,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -28, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A04,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -27, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A03,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -26, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A02,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -25, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A01,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -24, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A00,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24ATOT,

--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A11,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -34, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A10,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -33, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A09,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -32, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A08,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -31, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A07,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -30, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A06,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -29, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A05,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -28, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A04,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -27, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A03,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -26, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A02,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -25, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A01,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -24, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24A00,
--					isnull(AVG(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_24ATOT,
					-- 당월 정산수량
					0 M_C11,
					0 M_C10,
					0 M_C09,
					0 M_C08,
					0 M_C07,
					0 M_C06,
					0 M_C05,
					0 M_C04,
					0 M_C03,
					0 M_C02,
					0 M_C01,
					0 M_C00,
					0 M_CTOT
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
			   			 AND A.TRACEDATE		<= @ps_DateTo
			   			 AND A.SHIPGUBUN	=  'A'
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
			   AND  A.TRACEDATE		<= @ps_DateTo
			   AND  A.SHIPGUBUN		=  'A'
			 GROUP  BY B.PRODUCTGROUP, B.PRODUCTGROUPNAME
			
			UNION ALL
			
			SELECT	A.PRODUCTGROUP		AS AS_PRODUCT		,
					B.PRODUCTGROUPNAME	AS AS_PRODUCTNAME	,
					-- 24개월 평균출하수량
					0 M_24A11,
					0 M_24A10,
					0 M_24A09,
					0 M_24A08,
					0 M_24A07,
					0 M_24A06,
					0 M_24A05,
					0 M_24A04,
					0 M_24A03,
					0 M_24A02,
					0 M_24A01,
					0 M_24A00,
					0 M_24ATOT,
					-- 당월 정산수량
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C11,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -10, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C10,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -09, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C09,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -08, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C08,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -07, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C07,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -06, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C06,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -05, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C05,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -04, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C04,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -03, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C03,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -02, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C02,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -01, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C01,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -00, @ps_DateFm), 102) = A.ACCOUNTDATE THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_C00,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFm), 102) <= A.ACCOUNTDATE AND A.ACCOUNTDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_DateFm), 102) THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_CTOT
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
			 GROUP  BY A.PRODUCTGROUP, B.PRODUCTGROUPNAME
			) TMP
      GROUP BY AS_PRODUCT, AS_PRODUCTNAME	
   
END 

go
