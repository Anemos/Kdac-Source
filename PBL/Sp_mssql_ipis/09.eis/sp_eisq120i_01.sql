/************************************************************************************************/
/*	File Name	: sp_eisq120i_01.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 월간 제품별 Warranty 현황(공장별-수량)                                        */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQMANAGEMASTER																*/
/*  			  TMSTPRODUCTGROUP																*/
/*  			  TLOTNO																		*/
/*  			  VMSTKB_MODEL																	*/
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_DateFmb           char(10)    => 전년조회일자FROM                         */
/*                @ps_DateTob           char(10)    => 전년조회일자TO                           */
/*                @ps_DateFm            char(10)    => 조회일자FROM                             */
/*                @ps_DateTo            char(10)    => 조회일자TO                               */
/*	Notes		: 월간 제품별 Warranty 현황을 표시한다    		                                */
/*	Made Date	: 2002. 12. 10                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq120i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq120i_01
GO
/*
Exec sp_eisq120i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'S' ,
		@ps_DateFmb         = '2001.12.01' ,
		@ps_DateTob         = '2001.12.31' ,
		@ps_DateFm          = '2002.12.01' ,
		@ps_DateTo          = '2002.12.31'

*/


/****** Object:  Stored Procedure dbo.sp_eisq120i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq120i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_DateFmb           char(10)      ,   -- 전년조회일자FROM
		@ps_DateTob           char(10)      ,   -- 전년조회일자TO
		@ps_DateFm            char(10)      ,   -- 조회일자FROM
		@ps_DateTo            char(10)          -- 조회일자TO
AS

BEGIN

	SELECT	AS_AREA, 
			B.AREANAME,
			AS_DIVISION,
			C.DIVISIONNAME,
			AS_PRODUCT		,
			AS_PRODUCTNAME	,
         	MAX(A.QTYYEARGOAL) AS AS_QTYYEARGOAL,
			-- 당월 출하수량
			SUM(M_BSTOT) AS AS_SBTOT,
			SUM(M_S11) AS AS_S11,
			SUM(M_S10) AS AS_S10,
			SUM(M_S09) AS AS_S09,
			SUM(M_S08) AS AS_S08,
			SUM(M_S07) AS AS_S07,
			SUM(M_S06) AS AS_S06,
			SUM(M_S05) AS AS_S05,
			SUM(M_S04) AS AS_S04,
			SUM(M_S03) AS AS_S03,
			SUM(M_S02) AS AS_S02,
			SUM(M_S01) AS AS_S01,
			SUM(M_S00) AS AS_S00,
			SUM(M_STOT) AS AS_STOT,
			-- 24개월 평균출하수량
			SUM(M_B24ATOT)/24 AS AS_B24TOT,
			SUM(M_24A11) /24 AS AS_24A11,
			SUM(M_24A10) /24 AS AS_24A10,
			SUM(M_24A09) /24 AS AS_24A09,
			SUM(M_24A08) /24 AS AS_24A08,
			SUM(M_24A07) /24 AS AS_24A07,
			SUM(M_24A06) /24 AS AS_24A06,
			SUM(M_24A05) /24 AS AS_24A05,
			SUM(M_24A04) /24 AS AS_24A04,
			SUM(M_24A03) /24 AS AS_24A03,
			SUM(M_24A02) /24 AS AS_24A02,
			SUM(M_24A01) /24 AS AS_24A01,
			SUM(M_24A00) /24 AS AS_24A00,
			SUM(M_24ATOT) /24 AS AS_24ATOT,
			-- 12개월 평균출하수량
			SUM(M_B12ATOT)/12 AS AS_B12TOT,
			SUM(M_12A11) /12 AS AS_12A11,
			SUM(M_12A10) /12 AS AS_12A10,
			SUM(M_12A09) /12 AS AS_12A09,
			SUM(M_12A08) /12 AS AS_12A08,
			SUM(M_12A07) /12 AS AS_12A07,
			SUM(M_12A06) /12 AS AS_12A06,
			SUM(M_12A05) /12 AS AS_12A05,
			SUM(M_12A04) /12 AS AS_12A04,
			SUM(M_12A03) /12 AS AS_12A03,
			SUM(M_12A02) /12 AS AS_12A02,
			SUM(M_12A01) /12 AS AS_12A01,
			SUM(M_12A00) /12 AS AS_12A00,
			SUM(M_12ATOT) /12 AS AS_12ATOT,

			-- 당월 정산수량
			SUM(M_BTOT)AS AS_BTOT,
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
			SELECT	A.AREACODE			AS AS_AREA, 
					A.DIVISIONCODE		AS AS_DIVISION,
					B.PRODUCTGROUP 		AS AS_PRODUCT		,
					B.PRODUCTGROUPNAME	AS AS_PRODUCTNAME	,
					-- 당월 출하수량
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateFmb), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTob), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_BSTOT,

					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S11,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S10,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S09,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S08,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S07,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S06,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S05,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S04,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S03,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S02,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S01,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_S00,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_STOT,

					-- 24개월 평균출하수량
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFmb), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTob), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_B24ATOT,

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

					-- 12개월 평균출하수량
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -23, @ps_DateFmb), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTob), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_B12ATOT,

					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -23, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A11,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -22, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A10,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -21, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A09,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -20, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A08,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -19, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A07,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -18, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A06,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -17, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A05,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -16, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A04,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -15, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A03,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -14, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A02,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -13, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A01,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -12, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12A00,
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -23, @ps_DateFm), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_DateTo), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_12ATOT,

					-- 당월 정산수량
					0 M_BTOT,
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
					 		 C.PRODUCTGROUPNAME	AS PRODUCTGROUPNAME	
			  			FROM TLOTNO    A,
							 TMSTMODEL B,
							 TMSTPRODUCTGROUP C
			 		   WHERE A.AREACODE		=  B.AREACODE		
			   			 AND A.DIVISIONCODE	=  B.DIVISIONCODE
			   			 AND A.ITEMCODE		=  B.ITEMCODE
			   			 AND A.AREACODE		=  C.AREACODE		
			   			 AND A.DIVISIONCODE	=  C.DIVISIONCODE
			   			 AND B.PRODUCTGROUP	=  C.PRODUCTGROUP
			   			 AND A.AREACODE		=  @ps_AreaCode
			   			 AND A.DIVISIONCODE	=  @ps_DivisionCode
			   			 AND A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFmb), 102)
			   			 AND A.TRACEDATE		<= @ps_DateTo
			   			 AND A.SHIPGUBUN	=  'A'
					   GROUP BY B.AREACODE		,
					 			B.DIVISIONCODE	,
			   	 				B.ITEMCODE		,
					 			B.PRODUCTGROUP	,
					 			C.PRODUCTGROUPNAME
					) B
			 WHERE	A.AREACODE		=  B.AREACODE		
			   AND  A.DIVISIONCODE	=  B.DIVISIONCODE
			   AND  A.ITEMCODE		=  B.ITEMCODE
			   AND  A.AREACODE		=  @ps_AreaCode
			   AND  A.DIVISIONCODE	=  @ps_DivisionCode
			   AND  A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFmb), 102)
			   AND  A.TRACEDATE		<= @ps_DateTo
			   AND  A.SHIPGUBUN		=  'A'
			 GROUP  BY A.AREACODE, A.DIVISIONCODE, B.PRODUCTGROUP, B.PRODUCTGROUPNAME
			
			UNION ALL
			
			SELECT	A.AREACODE			AS AS_AREA, 
					A.DIVISIONCODE		AS AS_DIVISION,
					A.PRODUCTGROUP		AS AS_PRODUCT		,
					B.PRODUCTGROUPNAME	AS AS_PRODUCTNAME	,
					-- 당월 출하수량
					0 M_BSTOT,
					0 M_S11,
					0 M_S10,
					0 M_S09,
					0 M_S08,
					0 M_S07,
					0 M_S06,
					0 M_S05,
					0 M_S04,
					0 M_S03,
					0 M_S02,
					0 M_S01,
					0 M_S00,
					0 M_STOT,
					-- 24개월 평균출하수량
					0 M_B24ATOT,
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
					-- 12개월 평균출하수량
					0 M_B12ATOT,
					0 M_12A11,
					0 M_12A10,
					0 M_12A09,
					0 M_12A08,
					0 M_12A07,
					0 M_12A06,
					0 M_12A05,
					0 M_12A04,
					0 M_12A03,
					0 M_12A02,
					0 M_12A01,
					0 M_12A00,
					0 M_12ATOT,
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFmb),  102) <= A.ACCOUNTDATE AND A.ACCOUNTDATE  <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_DateFmb),  102) THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_BTOT,
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
			   AND  A.ACCOUNTDATE	>= CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFmb), 102)
			   AND  A.ACCOUNTDATE	<= SUBSTRING(@ps_DateFm, 1, 7)
			   AND  A.EXPORTGUBUN	=  'D'
			 GROUP  BY A.AREACODE, A.DIVISIONCODE, A.PRODUCTGROUP, B.PRODUCTGROUPNAME
			) TMP, 
			  TQWARRANTYGOALREJECT A, 
			  TMSTAREA			   B, 
			  TMSTDIVISION		   C 
		    WHERE  B.AREACODE	  = @ps_AreaCode
			  AND  C.AREACODE	  = @ps_AreaCode
			  AND  C.DIVISIONCODE = @ps_DivisionCode
			  AND  A.AREACODE	  = @ps_AreaCode
			  AND  A.DIVISIONCODE = @ps_DivisionCode
			  AND  A.STANDARDYEAR = SUBSTRING(@ps_DateFm, 1, 4)
			  AND  A.PRODUCTGROUP =* AS_PRODUCT
      GROUP BY AS_AREA, B.AREANAME, AS_DIVISION, C.DIVISIONNAME, AS_PRODUCT, AS_PRODUCTNAME
      ORDER BY AS_AREA, AS_DIVISION, AS_PRODUCT
   
END 

go
