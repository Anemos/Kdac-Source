/************************************************************************************************/
/*	File Name	: sp_pisq200i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: 주간별 FTTQ 현황(제품대분류별)                                                */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROGRESSBADMASTER                                                           */
/*                TQPROGRESSBADDETAIL                                                           */
/*                TQLARGEGROUP                                                                  */
/*                TQLARGEGROUPTOGOALREJECT                                                      */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_maflag            char(01)    => 가공/조립 구분							*/
/*                @ps_QCDate            char(10)    => 조회일자                                 */
/*                @ps_QCDateb1          char(10)    => 조회일자(기준일의 1년전)                 */
/*	Notes		: 주간별 FTTQ현황중 대분류별 자료를 조회한다.                                   */
/*	Made Date	: 2002. 09. 25                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq200i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq200i_01
GO
/*
Exec sp_pisq200i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_maflag          = '%' ,
        @ps_QCDate          = '2002.09.25'     ,
        @ps_QCDateb1      = '2001.09.25'

*/


/****** Object:  Stored Procedure dbo.sp_pisq200i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq200i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_maflag            char(01)      ,   -- 가공/조립 구분
        @ps_QCDate            char(10)      ,   -- 조회일자
        @ps_QCDateb1          char(10)          -- 조회일자(기준일의 1년전)

AS

BEGIN

	SELECT AS_LARGE         AS AS_LARGECODE,
	       AS_NAME          AS AS_LARGENAME,
		   CASE WHEN SUM(D_BSTOT) - SUM(D_BBTOT) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_BBTOT) / (CAST(SUM(D_BSTOT) - SUM(D_BBTOT) AS FLOAT)) * 100, 0) END AS AS_BFTTQ,
		   CASE WHEN SUM(D_S06) - SUM(D_B06) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B06)   / (CAST(SUM(D_S06)   - SUM(D_B06) AS FLOAT))   * 100, 0) END AS AS_FTTQ06,
		   CASE WHEN SUM(D_S05) - SUM(D_B05) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B05)   / (CAST(SUM(D_S05)   - SUM(D_B05) AS FLOAT))   * 100, 0) END AS AS_FTTQ05,
		   CASE WHEN SUM(D_S04) - SUM(D_B04) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B04)   / (CAST(SUM(D_S04)   - SUM(D_B04) AS FLOAT))   * 100, 0) END AS AS_FTTQ04,
		   CASE WHEN SUM(D_S03) - SUM(D_B03) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B03)   / (CAST(SUM(D_S03)   - SUM(D_B03) AS FLOAT))   * 100, 0) END AS AS_FTTQ03,
		   CASE WHEN SUM(D_S02) - SUM(D_B02) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B02)   / (CAST(SUM(D_S02)   - SUM(D_B02) AS FLOAT))   * 100, 0) END AS AS_FTTQ02,
		   CASE WHEN SUM(D_S01) - SUM(D_B01) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B01)   / (CAST(SUM(D_S01)   - SUM(D_B01) AS FLOAT))   * 100, 0) END AS AS_FTTQ01,
		   CASE WHEN SUM(D_S00) - SUM(D_B00) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B00)   / (CAST(SUM(D_S00)   - SUM(D_B00) AS FLOAT))   * 100, 0) END AS AS_FTTQ00,
		   CASE WHEN SUM(D_STOT) - SUM(D_BTOT) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_BTOT)  / (CAST(SUM(D_STOT)  - SUM(D_BTOT) AS FLOAT))  * 100, 0) END AS AS_FTTQTOT,
	       MAX(AS_YEARGOAL)	AS AS_YEAR
	  FROM (SELECT '00'     AS AS_LARGE,
	               '합  계' AS AS_NAME,
	               AVG(C.YEARGOAL)    AS AS_YEARGOAL,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.PRODUCTQTY ELSE 0 END) AS D_BSTOT,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S06,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -5, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -4, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S04,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -3, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S03,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -2, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S02,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -1, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S01,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -0, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S00,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDate THEN A.PRODUCTQTY ELSE 0 END) AS D_STOT,
				   0 AS D_BBTOT,
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
			   AND A.AREACODE		 *= C.AREACODE
			   AND A.DIVISIONCODE 	 *= C.DIVISIONCODE
			   AND C.STANDARDYEAR    =  SUBSTRING(@ps_QCDate, 1, 4)
			   AND C.FSFLAG          =  'F'
			   AND A.LARGEGROUPCODE  *= C.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.ORIGINATIONDATE
		
			UNION ALL
		
	        SELECT '00'     AS AS_LARGE,
	               '합  계' AS AS_NAME,
	               0        AS AS_YEARGOAL,
			 	   0 AS D_BSTOT,
			 	   0 AS D_S06,
			 	   0 AS D_S05,
			 	   0 AS D_S04,
			 	   0 AS D_S03,
			 	   0 AS D_S02,
			 	   0 AS D_S01,
			 	   0 AS D_S00,
			 	   0 AS D_STOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.TOTALQTY ELSE 0 END) AS D_BBTOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -5, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -4, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -3, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -2, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -1, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -0, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B00,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDate THEN A.TOTALQTY ELSE 0 END) AS D_BTOT
			  FROM TQPROGRESSBADDETAIL  A,
			       TQLARGEGROUP         B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.ORIGINATIONDATE
	  
	        UNION ALL
	  
	        SELECT A.LARGEGROUPCODE  AS AS_LARGE,
	               B.LARGEGROUPNAME  AS AS_NAME,
	               MAX(C.YEARGOAL)   AS AS_YEARGOAL,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.PRODUCTQTY ELSE 0 END) AS D_BSTOT,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S06,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -5, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -4, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S04,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -3, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S03,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -2, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S02,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -1, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S01,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -0, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY ELSE 0 END) AS D_S00,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDate THEN A.PRODUCTQTY ELSE 0 END) AS D_STOT,
				   0 AS D_BBTOT,
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
			   AND A.AREACODE		 *= C.AREACODE
			   AND A.DIVISIONCODE 	 *= C.DIVISIONCODE
			   AND C.STANDARDYEAR    =  SUBSTRING(@ps_QCDate, 1, 4)
			   AND C.FSFLAG          =  'F'
			   AND A.LARGEGROUPCODE  *= C.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_areacode
			   AND A.DIVISIONCODE 	 =  @ps_divisioncode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.LARGEGROUPCODE, B.LARGEGROUPNAME
		
			UNION ALL
		
			  SELECT A.LARGEGROUPCODE  AS AS_LARGE,
	               B.LARGEGROUPNAME    AS AS_NAME,
	               0                   AS AS_YEARGOAL,
			 	   0 AS D_BSTOT,
			 	   0 AS D_S06,
			 	   0 AS D_S05,
			 	   0 AS D_S04,
			 	   0 AS D_S03,
			 	   0 AS D_S02,
			 	   0 AS D_S01,
			 	   0 AS D_S00,
			 	   0 AS D_STOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.TOTALQTY ELSE 0 END) AS D_BBTOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -5, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -4, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -3, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -2, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -1, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -0, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.TOTALQTY ELSE 0 END) AS D_B00,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDate THEN A.TOTALQTY ELSE 0 END) AS D_BTOT
			  FROM TQPROGRESSBADDETAIL  A,
			       TQLARGEGROUP         B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_areacode
			   AND A.DIVISIONCODE 	 =  @ps_divisioncode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.LARGEGROUPCODE, B.LARGEGROUPNAME
	       ) TMP
	 GROUP BY AS_LARGE, AS_NAME
	 ORDER BY AS_LARGE, AS_NAME
    
END 

go
