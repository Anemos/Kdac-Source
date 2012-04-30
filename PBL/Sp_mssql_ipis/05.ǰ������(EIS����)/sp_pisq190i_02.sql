/************************************************************************************************/
/*	File Name	: sp_pisq190i_02.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: 월별 FTTQ 현황(제품중분류별)                                                  */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROGRESSBADMASTER                                                           */
/*                TQPROGRESSBADDETAIL                                                           */
/*                TQLARGEGROUP                                                                  */
/*                TQLARGEGROUPTOGOALREJECT                                                      */
/*                TQMIDDLEGROUP          														*/
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_maflag            char(01)    => 가공/조립 구분							*/
/*                @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*                @ps_QCDateFmb1        char(10)    => 조회일자FROM(기준월의 1년전)             */
/*                @ps_QCDateTob1        char(10)    => 조회일자TO(기준월의 1년전)               */
/*                @ps_largegroupcode    char(02)    => 제품대분류코드                           */
/*	Notes		: 월간 FTTQ현황중 중분류별 자료를 조회한다.                                     */
/*	Made Date	: 2002. 09. 24                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq190i_02') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq190i_02
GO
/*
Exec sp_pisq190i_02
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_maflag          = '%' ,
        @ps_QCDateFm        = '2002.12.01'     ,
        @ps_QCDateTo        = '2002.12.31'      ,
        @ps_QCDateFmb1      = '2001.12.01'      ,
        @ps_QCDateTob1      = '2001.12.31'      ,
        @ps_largegroupcode  = '01'

*/


/****** Object:  Stored Procedure dbo.sp_pisq190i_02    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq190i_02
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_maflag            char(01)      ,   -- 가공/조립 구분
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)      ,   -- 조회일자TO
        @ps_QCDateFmb1        char(10)      ,   -- 조회일자FROM(기준월의 1년전)
        @ps_QCDateTob1        char(10)      ,   -- 조회일자TO(기준월의 1년전)
        @ps_largegroupcode    char(02)          -- 제품대분류코드

AS

BEGIN

	SELECT AS_MIDDLE                                                                    AS AS_MIDDLECODE,
	       AS_NAME                                                                      AS AS_MIDDLENAME,
		   CASE WHEN SUM(M_BSTOT) - SUM(D_BBTOT) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_BBTOT) / (CAST(SUM(M_BSTOT) - SUM(D_BBTOT) AS FLOAT)) * 100, 0) END AS AS_BFTTQ,
		   CASE WHEN SUM(M_S11) - SUM(D_B11) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B11)   / (CAST(SUM(M_S11)   - SUM(D_B11) AS FLOAT))   * 100, 0) END AS AS_FTTQ11,
		   CASE WHEN SUM(M_S10) - SUM(D_B10) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B10)   / (CAST(SUM(M_S10)   - SUM(D_B10) AS FLOAT))   * 100, 0) END AS AS_FTTQ10,
		   CASE WHEN SUM(M_S09) - SUM(D_B09) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B09)   / (CAST(SUM(M_S09)   - SUM(D_B09) AS FLOAT))   * 100, 0) END AS AS_FTTQ09,
		   CASE WHEN SUM(M_S08) - SUM(D_B08) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B08)   / (CAST(SUM(M_S08)   - SUM(D_B08) AS FLOAT))   * 100, 0) END AS AS_FTTQ08,
		   CASE WHEN SUM(M_S07) - SUM(D_B07) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B07)   / (CAST(SUM(M_S07)   - SUM(D_B07) AS FLOAT))   * 100, 0) END AS AS_FTTQ07,
		   CASE WHEN SUM(M_S06) - SUM(D_B06) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B06)   / (CAST(SUM(M_S06)   - SUM(D_B06) AS FLOAT))   * 100, 0) END AS AS_FTTQ06,
		   CASE WHEN SUM(M_S05) - SUM(D_B05) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B05)   / (CAST(SUM(M_S05)   - SUM(D_B05) AS FLOAT))   * 100, 0) END AS AS_FTTQ05,
		   CASE WHEN SUM(M_S04) - SUM(D_B04) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B04)   / (CAST(SUM(M_S04)   - SUM(D_B04) AS FLOAT))   * 100, 0) END AS AS_FTTQ04,
		   CASE WHEN SUM(M_S03) - SUM(D_B03) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B03)   / (CAST(SUM(M_S03)   - SUM(D_B03) AS FLOAT))   * 100, 0) END AS AS_FTTQ03,
		   CASE WHEN SUM(M_S02) - SUM(D_B02) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B02)   / (CAST(SUM(M_S02)   - SUM(D_B02) AS FLOAT))   * 100, 0) END AS AS_FTTQ02,
		   CASE WHEN SUM(M_S01) - SUM(D_B01) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B01)   / (CAST(SUM(M_S01)   - SUM(D_B01) AS FLOAT))   * 100, 0) END AS AS_FTTQ01,
		   CASE WHEN SUM(M_S00) - SUM(D_B00) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_B00)   / (CAST(SUM(M_S00)   - SUM(D_B00) AS FLOAT))   * 100, 0) END AS AS_FTTQ00,
		   CASE WHEN SUM(M_STOT) - SUM(D_BTOT) = 0 THEN 0 ELSE
		   ISNULL(SUM(D_BTOT)  / (CAST(SUM(M_STOT)  - SUM(D_BTOT) AS FLOAT))  * 100, 0) END AS AS_FTTQTOT,
	       MAX(AS_YEARGOAL)                                                             AS AS_YEAR
	  FROM (SELECT '00'     AS AS_MIDDLE,
	               '합  계' AS AS_NAME,
	               AVG(C.YEARGOAL)    AS AS_YEARGOAL,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTob1), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_BSTOT,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S11,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S10,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S09,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S08,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S07,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S06,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S04,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S03,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S02,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S01,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S00,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_STOT,
				   0 AS D_BBTOT,
				   0 AS D_B11,
				   0 AS D_B10,
				   0 AS D_B09,
				   0 AS D_B08,
				   0 AS D_B07,
				   0 AS D_B06,
				   0 AS D_B05,
				   0 AS D_B04,
				   0 AS D_B03,
				   0 AS D_B02,
				   0 AS D_B01,
				   0 AS D_B00,
				   0 AS D_BTOT
			  FROM TQPROGRESSBADMASTER  A,
			       TQLARGEGROUP         B,
				   TQLARGEGROUPTOGOALREJECT  C
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 *=  C.AREACODE
			   AND A.DIVISIONCODE 	 *=  C.DIVISIONCODE
			   AND C.STANDARDYEAR    =  SUBSTRING(@ps_QCDateFm, 1, 4)
			   AND C.FSFLAG          =  'F'
			   AND A.LARGEGROUPCODE  *=  C.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDateTo
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY SUBSTRING(A.ORIGINATIONDATE, 1, 7)
		
			UNION ALL
		
	        SELECT '00'     AS AS_MIDDLE,
	               '합  계' AS AS_NAME,
	               0        AS AS_YEARGOAL,
			 	   0 AS M_BSTOT,
			 	   0 AS M_S11,
			 	   0 AS M_S10,
			 	   0 AS M_S09,
			 	   0 AS M_S08,
			 	   0 AS M_S07,
			 	   0 AS M_S06,
			 	   0 AS M_S05,
			 	   0 AS M_S04,
			 	   0 AS M_S03,
			 	   0 AS M_S02,
			 	   0 AS M_S01,
			 	   0 AS M_S00,
			 	   0 AS M_STOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTob1), 102) THEN A.TOTALQTY ELSE 0 END) AS D_BBTOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B11,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B10,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B09,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B08,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B07,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B00,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_BTOT
			  FROM TQPROGRESSBADDETAIL  A,
			       TQLARGEGROUP         B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDateTo
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY SUBSTRING(A.ORIGINATIONDATE, 1, 7)
	  
	        UNION ALL
	  
	        SELECT A.MIDDLEGROUPCODE AS AS_MIDDLE,
	               D.MIDDLEGROUPNAME AS AS_NAME,
	               MAX(C.YEARGOAL)   AS AS_YEARGOAL,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTob1), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_BSTOT,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S11,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S10,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S09,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S08,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S07,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S06,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S04,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S03,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S02,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S01,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_S00,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.PRODUCTQTY ELSE 0 END) AS M_STOT,
				   0 AS D_BBTOT,
				   0 AS D_B11,
				   0 AS D_B10,
				   0 AS D_B09,
				   0 AS D_B08,
				   0 AS D_B07,
				   0 AS D_B06,
				   0 AS D_B05,
				   0 AS D_B04,
				   0 AS D_B03,
				   0 AS D_B02,
				   0 AS D_B01,
				   0 AS D_B00,
				   0 AS D_BTOT
			  FROM TQPROGRESSBADMASTER  A,
			       TQLARGEGROUP         B,
				   TQLARGEGROUPTOGOALREJECT C,
                   TQMIDDLEGROUP        D
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 *=  C.AREACODE
			   AND A.DIVISIONCODE 	 *=  C.DIVISIONCODE
			   AND C.STANDARDYEAR    =  SUBSTRING(@ps_QCDateFm, 1, 4)
			   AND C.FSFLAG          =  'F'
			   AND A.LARGEGROUPCODE  *=  C.LARGEGROUPCODE 
			   AND A.AREACODE		 =  D.AREACODE
			   AND A.DIVISIONCODE 	 =  D.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  D.LARGEGROUPCODE 
			   AND A.MIDDLEGROUPCODE =  D.MIDDLEGROUPCODE 
			   AND A.AREACODE		 =  @ps_areacode
			   AND A.DIVISIONCODE 	 =  @ps_divisioncode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDateTo
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.MIDDLEGROUPCODE, D.MIDDLEGROUPNAME
		
			UNION ALL
		
		    SELECT A.MIDDLEGROUPCODE   AS AS_MIDDLE,
	               C.MIDDLEGROUPNAME   AS AS_NAME,
	               0                   AS AS_YEARGOAL,
			 	   0 AS M_BSTOT,
			 	   0 AS M_S11,
			 	   0 AS M_S10,
			 	   0 AS M_S09,
			 	   0 AS M_S08,
			 	   0 AS M_S07,
			 	   0 AS M_S06,
			 	   0 AS M_S05,
			 	   0 AS M_S04,
			 	   0 AS M_S03,
			 	   0 AS M_S02,
			 	   0 AS M_S01,
			 	   0 AS M_S00,
			 	   0 AS M_STOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTob1), 102) THEN A.TOTALQTY ELSE 0 END) AS D_BBTOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B11,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B10,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B09,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B08,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B07,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_B00,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.TOTALQTY ELSE 0 END) AS D_BTOT
			  FROM TQPROGRESSBADDETAIL  A,
			       TQLARGEGROUP         B,
			       TQMIDDLEGROUP        C
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  C.AREACODE
			   AND A.DIVISIONCODE 	 =  C.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  C.LARGEGROUPCODE 
			   AND A.MIDDLEGROUPCODE =  C.MIDDLEGROUPCODE 
			   AND A.AREACODE		 =  @ps_areacode
			   AND A.DIVISIONCODE 	 =  @ps_divisioncode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDateTo
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.MIDDLEGROUPCODE, C.MIDDLEGROUPNAME
	       ) TMP
	 GROUP BY AS_MIDDLE, AS_NAME
	 ORDER BY AS_MIDDLE, AS_NAME
    
END 

go
