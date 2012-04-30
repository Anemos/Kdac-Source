/************************************************************************************************/
/*	File Name	: sp_eisq110i_01.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 월간 Warranty 추이(전사)                                             			*/
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQMANAGEMASTER																*/
/*  			  TMSTPRODUCTGROUP																*/
/*  			  TLOTNO																		*/
/*  			  VMSTKB_MODEL																	*/
/*  Parameter   : @ps_DateFmb           char(10)    => 전년조회일자FROM                         */
/*                @ps_DateTob           char(10)    => 전년조회일자TO                           */
/*                @ps_DateFm            char(10)    => 조회일자FROM                             */
/*                @ps_DateTo            char(10)    => 조회일자TO                               */
/*	Notes		: 월간 Warranty 추이 현황을 표시한다    		                                */
/*	Made Date	: 2002. 12. 11                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq110i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq110i_01
GO
/*
Exec sp_eisq110i_01
		@ps_DateFmb         = '2001.12.01' ,
		@ps_DateTob         = '2001.12.31' ,
		@ps_DateFm          = '2002.12.01' ,
		@ps_DateTo          = '2002.12.31'

*/


/****** Object:  Stored Procedure dbo.sp_eisq110i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq110i_01
		@ps_DateFmb           char(10)      ,   -- 전년조회일자FROM
		@ps_DateTob           char(10)      ,   -- 전년조회일자TO
		@ps_DateFm            char(10)      ,   -- 조회일자FROM
		@ps_DateTo            char(10)          -- 조회일자TO
AS

BEGIN

	SELECT	AS_AREA, 
			A.AREANAME AS AS_AREANAME,
			AS_DIVISION,
			B.DIVISIONNAME AS AS_DIVISIONNAME,
         	MAX(AS_QTYYEARGOAL) AS AS_YEARGOAL,
			-- 당월 출하수량
			SUM(M_BSTOT) AS S_00,
			SUM(M_S11) 	 AS S_01,
			SUM(M_S10)   AS S_02,
			SUM(M_S09)   AS S_03,
			SUM(M_S08)   AS S_04,
			SUM(M_S07)   AS S_05,
			SUM(M_S06)   AS S_06,
			SUM(M_S05)   AS S_07,
			SUM(M_S04)   AS S_08,
			SUM(M_S03)   AS S_09,
			SUM(M_S02)   AS S_10,
			SUM(M_S01)   AS S_11,
			SUM(M_S00)   AS S_12,
			SUM(M_STOT)  AS S_13,
			-- 24개월 평균출하수량
			SUM(M_B24A11)/24  AS S24_00,
			SUM(M_24A11) /24  AS S24_01,
			SUM(M_24A10) /24  AS S24_02,
			SUM(M_24A09) /24  AS S24_03,
			SUM(M_24A08) /24  AS S24_04,
			SUM(M_24A07) /24  AS S24_05,
			SUM(M_24A06) /24  AS S24_06,
			SUM(M_24A05) /24  AS S24_07,
			SUM(M_24A04) /24  AS S24_08,
			SUM(M_24A03) /24  AS S24_09,
			SUM(M_24A02) /24  AS S24_10,
			SUM(M_24A01) /24  AS S24_11,
			SUM(M_24A00) /24  AS S24_12,
			SUM(M_24ATOT) /24 AS S24_13,
			-- 12개월 평균출하수량
			SUM(M_B12A11)/12  AS S12_00,
			SUM(M_12A11) /12  AS S12_01,
			SUM(M_12A10) /12  AS S12_02,
			SUM(M_12A09) /12  AS S12_03,
			SUM(M_12A08) /12  AS S12_04,
			SUM(M_12A07) /12  AS S12_05,
			SUM(M_12A06) /12  AS S12_06,
			SUM(M_12A05) /12  AS S12_07,
			SUM(M_12A04) /12  AS S12_08,
			SUM(M_12A03) /12  AS S12_09,
			SUM(M_12A02) /12  AS S12_10,
			SUM(M_12A01) /12  AS S12_11,
			SUM(M_12A00) /12  AS S12_12,
			SUM(M_12ATOT) /12 AS S12_13,

			-- 당월 정산수량
			SUM(M_BTOT) AS A_00,
			SUM(M_C11)  AS A_01,
			SUM(M_C10)  AS A_02,
			SUM(M_C09)  AS A_03,
			SUM(M_C08)  AS A_04,
			SUM(M_C07)  AS A_05,
			SUM(M_C06)  AS A_06,
			SUM(M_C05)  AS A_07,
			SUM(M_C04)  AS A_08,
			SUM(M_C03)  AS A_09,
			SUM(M_C02)  AS A_10,
			SUM(M_C01)  AS A_11,
			SUM(M_C00)  AS A_12,
			SUM(M_CTOT) AS A_13
	  FROM  (
			SELECT	A.AREACODE			AS AS_AREA, 
					A.DIVISIONCODE		AS AS_DIVISION,
         			0					AS AS_QTYYEARGOAL,
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
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFmb), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTob), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_B24A11,

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
					isnull(SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -23, @ps_DateFmb), 102) <= A.TRACEDATE AND A.TRACEDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_DateTob), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_B12A11,

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
			  FROM	TLOTNO  A
			 WHERE	A.TRACEDATE		>= CONVERT(CHAR(10), DATEADD(month, -35, @ps_DateFmb), 102)
			   AND  A.TRACEDATE		<= @ps_DateTo
			   AND  A.SHIPGUBUN		=  'A'
			 GROUP  BY A.AREACODE, A.DIVISIONCODE
			
			UNION ALL
			
			SELECT	A.AREACODE			AS AS_AREA, 
					A.DIVISIONCODE		AS AS_DIVISION,
         			0					AS AS_QTYYEARGOAL,
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
					0 M_B24A11,
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
					0 M_B12A11,
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
					-- 당월 정산수량
					isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFmb),  102) <= A.ACCOUNTDATE AND A.ACCOUNTDATE  <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_DateFmb),  102) THEN A.CONFIRMQTY ELSE 0 END), 0) AS M_BTOT,

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
			 WHERE	A.ACCOUNTDATE	>= CONVERT(CHAR(07), DATEADD(month, -11, @ps_DateFmb), 102)
			   AND  A.ACCOUNTDATE	<= SUBSTRING(@ps_DateFm, 1, 7)
			   AND  A.EXPORTGUBUN	=  'D'
			 GROUP  BY A.AREACODE, A.DIVISIONCODE


			UNION ALL
			
			SELECT	A.AREACODE			AS AS_AREA, 
					A.DIVISIONCODE		AS AS_DIVISION,
		         	A.QTYYEARGOAL		AS AS_QTYYEARGOAL,
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
					0 M_B24A11,
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
					0 M_B12A11,
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
			  FROM	TQWARRANTYGOALREJECT A
		    WHERE  A.PRODUCTGROUP = 'ZZ'
		      AND  A.STANDARDYEAR =  SUBSTRING(@ps_DateFm, 1, 4)
			) TMP, TMSTAREA A, TMSTDIVISION B
      WHERE	AS_AREA		= A.AREACODE
        AND AS_AREA		= B.AREACODE
        AND AS_DIVISION	= B.DIVISIONCODE
      GROUP BY AS_AREA, A.AREANAME, AS_DIVISION, B.DIVISIONNAME, B.SORTORDER
      ORDER BY AS_AREA, B.SORTORDER
   
END 

go
