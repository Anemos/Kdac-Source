/************************************************************************************************/
/*	File Name	: sp_eisq090i_01.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 전사 월별 SCRAP 현황			                                                */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROGRESSBADMASTER                                                           */
/*                TQPROGRESSBADDETAIL                                                           */
/*                TQLARGEGROUPTOGOALREJECT                                                      */
/*  Parameter   : @ps_QCDateFmb         char(10)    => 전년조회일자FROM                         */
/*                @ps_QCDateTob         char(10)    => 전년조회일자TO                           */
/*  			  @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*	Notes		: 전사 월별 SCRAP현황 자료를 조회한다.  		                                */
/*	Made Date	: 2002. 12. 03                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq090i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq090i_01
GO
/*
Exec sp_eisq090i_01
        @ps_QCDateFmb       = '2001.12.01',
        @ps_QCDateTob       = '2001.12.31',
        @ps_QCDateFm        = '2002.12.01',
        @ps_QCDateTo        = '2002.12.31'

*/

/****** Object:  Stored Procedure dbo.sp_eisq090i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq090i_01
        @ps_QCDateFmb         char(10)      ,   -- 전년조회일자FROM
        @ps_QCDateTob         char(10)		,   -- 전년조회일자TO
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO

AS

BEGIN

	SELECT AS_AREACODE,
           AS_DIVISIONCODE,
		   A.AREANAME		AS AS_AREANAME,
		   B.DIVISIONNAME	AS AS_DIVISIONNAME,
		   SUM(ISNULL(M_BSTOT, 0)) AS I_00,
		   SUM(ISNULL(M_S11, 0))   AS I_01,
		   SUM(ISNULL(M_S10, 0))   AS I_02,
		   SUM(ISNULL(M_S09, 0))   AS I_03,
		   SUM(ISNULL(M_S08, 0))   AS I_04,
		   SUM(ISNULL(M_S07, 0))   AS I_05,
		   SUM(ISNULL(M_S06, 0))   AS I_06,
		   SUM(ISNULL(M_S05, 0))   AS I_07,
	 	   SUM(ISNULL(M_S04, 0))   AS I_08,
		   SUM(ISNULL(M_S03, 0))   AS I_09,
		   SUM(ISNULL(M_S02, 0))   AS I_10,
		   SUM(ISNULL(M_S01, 0))   AS I_11,
		   SUM(ISNULL(M_S00, 0))   AS I_12,
		   SUM(ISNULL(M_STOT, 0))  AS I_13,
		   SUM(ISNULL(D_BBTOT, 0)) AS B_00,
		   SUM(ISNULL(D_B11, 0))   AS B_01,
		   SUM(ISNULL(D_B10, 0))   AS B_02,
		   SUM(ISNULL(D_B09, 0))   AS B_03,
		   SUM(ISNULL(D_B08, 0))   AS B_04,
		   SUM(ISNULL(D_B07, 0))   AS B_05,
		   SUM(ISNULL(D_B06, 0))   AS B_06,
		   SUM(ISNULL(D_B05, 0))   AS B_07,
		   SUM(ISNULL(D_B04, 0))   AS B_08,
		   SUM(ISNULL(D_B03, 0))   AS B_09,
		   SUM(ISNULL(D_B02, 0))   AS B_10,
		   SUM(ISNULL(D_B01, 0))   AS B_11,
		   SUM(ISNULL(D_B00, 0))   AS B_12,
		   SUM(ISNULL(D_BTOT, 0))  AS B_13, 
           MAX(AS_YEARGOAL)        AS G_14
	  FROM (
			-- 년목표
			--
	  		SELECT A.AREACODE					AS AS_AREACODE,
	               A.DIVISIONCODE				AS AS_DIVISIONCODE,
	               AVG(ISNULL(A.YEARGOAL, 0))	AS AS_YEARGOAL,
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
			  FROM TQLARGEGROUPTOGOALREJECT  A
			 WHERE A.STANDARDYEAR    =  SUBSTRING(@ps_QCDateFm, 1, 4)
			   AND A.FSFLAG          =  'S'
			 GROUP BY A.AREACODE, A.DIVISIONCODE

			UNION ALL

			-- 공정불량마스타
			--
	  		SELECT A.AREACODE					AS AS_AREACODE,
	               A.DIVISIONCODE				AS AS_DIVISIONCODE,
	               0							AS AS_YEARGOAL,
				   CASE WHEN SUBSTRING(@ps_QCDateFmb,1,4) 		=  SUBSTRING(A.ORIGINATIONDATE,1,4) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_BSTOT,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.01'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S11,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.02'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S10,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.03'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S09,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.04'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S08,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.05'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S07,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.06'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S06,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.07'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S05,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.08'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S04,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.09'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S03,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.10'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S02,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.11'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S01,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.12'=  SUBSTRING(A.ORIGINATIONDATE,1,7) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_S00,
				   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4)        =  SUBSTRING(A.ORIGINATIONDATE,1,4) THEN SUM(A.PRODUCTQTY * A.PROCESSCOST) ELSE 0 END AS M_STOT,
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
			  FROM TQPROGRESSBADMASTER  A
			 WHERE A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDateTo
			 GROUP BY A.AREACODE, A.DIVISIONCODE, A.ORIGINATIONDATE
		
			UNION ALL
		
			-- 공정불량디테일
			--
			SELECT A.AREACODE			AS AS_AREACODE,
	               A.DIVISIONCODE		AS AS_DIVISIONCODE,
	               0					AS AS_YEARGOAL,
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
			 	   CASE WHEN SUBSTRING(@ps_QCDateFmb,1,4) 		=  SUBSTRING(A.ORIGINATIONDATE,1,4)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_BBTOT,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.01'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B11,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.02'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B10,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.03'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B09,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.04'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B08,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.05'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B07,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.06'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B06,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.07'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B05,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.08'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B04,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.09'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B03,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.10'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B02,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.11'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B01,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4) + '.12'=  SUBSTRING(A.ORIGINATIONDATE,1,7)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_B00,
			 	   CASE WHEN SUBSTRING(@ps_QCDateFm,1,4)        =  SUBSTRING(A.ORIGINATIONDATE,1,4)   THEN SUM(A.DISUSEQTY * A.PROCESSCOST) ELSE 0 END AS D_BTOT
			  FROM TQPROGRESSBADDETAIL  A                                                                                                                                                           
			 WHERE A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFmb), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDateTo
			 GROUP BY A.AREACODE, A.DIVISIONCODE, A.ORIGINATIONDATE
		   ) TMP, TMSTAREA A, TMSTDIVISION B
	 WHERE RTRIM(AS_AREACODE)		= A.AREACODE
	   AND RTRIM(AS_AREACODE)		= B.AREACODE
	   AND RTRIM(AS_DIVISIONCODE)	= B.DIVISIONCODE
	 GROUP BY AS_AREACODE, AS_DIVISIONCODE, A.AREANAME, B.DIVISIONNAME, B.SORTORDER
	 ORDER BY AS_AREACODE, B.SORTORDER

END 

go
