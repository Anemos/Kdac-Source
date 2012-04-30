/************************************************************************************************/
/*	File Name	: sp_pisq240i_03.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: 일별 SCRAP 현황(제품소분류별)                                                */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROGRESSBADMASTER                                                           */
/*                TQPROGRESSBADDETAIL                                                           */
/*                TQLARGEGROUP                                                                  */
/*                TQLARGEGROUPTOGOALREJECT                                                      */
/*                TQSMALLGROUP          														*/
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_maflag            char(01)    => 가공/조립 구분							*/
/*                @ps_QCDate            char(10)    => 조회일자                                 */
/*                @ps_QCDateb1          char(10)    => 조회일자(기준일의 1년전)                 */
/*                @ps_largegroupcode    char(02)    => 제품대분류코드                           */
/*                @ps_middlegroupcode   char(02)    => 제품중분류코드                           */
/*	Notes		: 일별 SCRAP현황중 소분류별 자료를 조회한다.                                   */
/*	Made Date	: 2002. 09. 25                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq240i_03') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq240i_03
GO
/*
Exec sp_pisq240i_03
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_maflag          = '%' ,
        @ps_QCDate          = '2002.09.25' ,
        @ps_QCDateb1        = '2001.09.25' ,
        @ps_largegroupcode  = '01'              ,
        @ps_middlegroupcode = '01'

*/


/****** Object:  Stored Procedure dbo.sp_pisq240i_03    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq240i_03
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_maflag            char(01)      ,   -- 가공/조립 구분
        @ps_QCDate            char(10)      ,   -- 조회일자
        @ps_QCDateb1          char(10)      ,   -- 조회일자(기준일의 1년전)
        @ps_largegroupcode    char(02)      ,   -- 제품대분류코드
        @ps_middlegroupcode   char(02)          -- 제품중분류코드

AS

BEGIN

	SELECT AS_SMALL         AS AS_SMALLCODE,
	       AS_NAME          AS AS_SMALLNAME,
		   CASE WHEN SUM(D_BSTOT) - SUM(D_BBTOT) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_BBTOT) / (CAST(SUM(D_BSTOT) - SUM(D_BBTOT) AS FLOAT)) * 100, 0) END AS AS_BSCRAP,
		   CASE WHEN SUM(D_S01) - SUM(D_B01) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B01)   / (CAST(SUM(D_S01)   - SUM(D_B01)   AS FLOAT)) * 100, 0) END AS AS_SCRAP01,
		   CASE WHEN SUM(D_S02) - SUM(D_B02) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B02)   / (CAST(SUM(D_S02)   - SUM(D_B02)   AS FLOAT)) * 100, 0) END AS AS_SCRAP02,
		   CASE WHEN SUM(D_S03) - SUM(D_B03) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B03)   / (CAST(SUM(D_S03)   - SUM(D_B03)   AS FLOAT)) * 100, 0) END AS AS_SCRAP03,
		   CASE WHEN SUM(D_S04) - SUM(D_B04) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B04)   / (CAST(SUM(D_S04)   - SUM(D_B04)   AS FLOAT)) * 100, 0) END AS AS_SCRAP04,
		   CASE WHEN SUM(D_S05) - SUM(D_B05) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B05)   / (CAST(SUM(D_S05)   - SUM(D_B05)   AS FLOAT)) * 100, 0) END AS AS_SCRAP05,
		   CASE WHEN SUM(D_S06) - SUM(D_B06) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B06)   / (CAST(SUM(D_S06)   - SUM(D_B06)   AS FLOAT)) * 100, 0) END AS AS_SCRAP06,
		   CASE WHEN SUM(D_S07) - SUM(D_B07) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B07)   / (CAST(SUM(D_S07)   - SUM(D_B07)   AS FLOAT)) * 100, 0) END AS AS_SCRAP07,
		   CASE WHEN SUM(D_S08) - SUM(D_B08) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B08)   / (CAST(SUM(D_S08)   - SUM(D_B08)   AS FLOAT)) * 100, 0) END AS AS_SCRAP08,
		   CASE WHEN SUM(D_S09) - SUM(D_B09) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B09)   / (CAST(SUM(D_S09)   - SUM(D_B09)   AS FLOAT)) * 100, 0) END AS AS_SCRAP09,
		   CASE WHEN SUM(D_S10) - SUM(D_B10) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B10)   / (CAST(SUM(D_S10)   - SUM(D_B10)   AS FLOAT)) * 100, 0) END AS AS_SCRAP10,
		   CASE WHEN SUM(D_S11) - SUM(D_B11) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B11)   / (CAST(SUM(D_S11)   - SUM(D_B11)   AS FLOAT)) * 100, 0) END AS AS_SCRAP11,
		   CASE WHEN SUM(D_S12) - SUM(D_B12) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B12)   / (CAST(SUM(D_S12)   - SUM(D_B12)   AS FLOAT)) * 100, 0) END AS AS_SCRAP12,
		   CASE WHEN SUM(D_S13) - SUM(D_B13) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B13)   / (CAST(SUM(D_S13)   - SUM(D_B13)   AS FLOAT)) * 100, 0) END AS AS_SCRAP13,
		   CASE WHEN SUM(D_S14) - SUM(D_B14) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B14)   / (CAST(SUM(D_S14)   - SUM(D_B14)   AS FLOAT)) * 100, 0) END AS AS_SCRAP14,
		   CASE WHEN SUM(D_S15) - SUM(D_B15) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B15)   / (CAST(SUM(D_S15)   - SUM(D_B15)   AS FLOAT)) * 100, 0) END AS AS_SCRAP15,
		   CASE WHEN SUM(D_S16) - SUM(D_B16) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B16)   / (CAST(SUM(D_S16)   - SUM(D_B16)   AS FLOAT)) * 100, 0) END AS AS_SCRAP16,
		   CASE WHEN SUM(D_S17) - SUM(D_B17) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B17)   / (CAST(SUM(D_S17)   - SUM(D_B17)   AS FLOAT)) * 100, 0) END AS AS_SCRAP17,
		   CASE WHEN SUM(D_S18) - SUM(D_B18) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B18)   / (CAST(SUM(D_S18)   - SUM(D_B18)   AS FLOAT)) * 100, 0) END AS AS_SCRAP18,
		   CASE WHEN SUM(D_S19) - SUM(D_B19) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B19)   / (CAST(SUM(D_S19)   - SUM(D_B19)   AS FLOAT)) * 100, 0) END AS AS_SCRAP19,
		   CASE WHEN SUM(D_S20) - SUM(D_B20) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B20)   / (CAST(SUM(D_S20)   - SUM(D_B20)   AS FLOAT)) * 100, 0) END AS AS_SCRAP20,
		   CASE WHEN SUM(D_S21) - SUM(D_B21) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B21)   / (CAST(SUM(D_S21)   - SUM(D_B21)   AS FLOAT)) * 100, 0) END AS AS_SCRAP21,
		   CASE WHEN SUM(D_S22) - SUM(D_B22) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B22)   / (CAST(SUM(D_S22)   - SUM(D_B22)   AS FLOAT)) * 100, 0) END AS AS_SCRAP22,
		   CASE WHEN SUM(D_S23) - SUM(D_B23) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B23)   / (CAST(SUM(D_S23)   - SUM(D_B23)   AS FLOAT)) * 100, 0) END AS AS_SCRAP23,
		   CASE WHEN SUM(D_S24) - SUM(D_B24) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B24)   / (CAST(SUM(D_S24)   - SUM(D_B24)   AS FLOAT)) * 100, 0) END AS AS_SCRAP24,
		   CASE WHEN SUM(D_S25) - SUM(D_B25) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B25)   / (CAST(SUM(D_S25)   - SUM(D_B25)   AS FLOAT)) * 100, 0) END AS AS_SCRAP25,
		   CASE WHEN SUM(D_S26) - SUM(D_B26) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B26)   / (CAST(SUM(D_S26)   - SUM(D_B26)   AS FLOAT)) * 100, 0) END AS AS_SCRAP26,
		   CASE WHEN SUM(D_S27) - SUM(D_B27) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B27)   / (CAST(SUM(D_S27)   - SUM(D_B27)   AS FLOAT)) * 100, 0) END AS AS_SCRAP27,
		   CASE WHEN SUM(D_S28) - SUM(D_B28) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B28)   / (CAST(SUM(D_S28)   - SUM(D_B28)   AS FLOAT)) * 100, 0) END AS AS_SCRAP28,
		   CASE WHEN SUM(D_S29) - SUM(D_B29) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B29)   / (CAST(SUM(D_S29)   - SUM(D_B29)   AS FLOAT)) * 100, 0) END AS AS_SCRAP29,
		   CASE WHEN SUM(D_S30) - SUM(D_B30) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B30)   / (CAST(SUM(D_S30)   - SUM(D_B30)   AS FLOAT)) * 100, 0) END AS AS_SCRAP30,
		   CASE WHEN SUM(D_S31) - SUM(D_B31) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B31)   / (CAST(SUM(D_S31)   - SUM(D_B31)   AS FLOAT)) * 100, 0) END AS AS_SCRAP31,
		   CASE WHEN SUM(D_STOT) - SUM(D_BTOT) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_BTOT)  / (CAST(SUM(D_STOT)  - SUM(D_BTOT) AS FLOAT))  * 100, 0) END AS AS_SCRAPTOT,
	       MAX(AS_YEARGOAL)	AS AS_YEAR
	  FROM (SELECT '00'     AS AS_SMALL,
	               '합  계' AS AS_NAME,
	               AVG(C.YEARGOAL)    AS AS_YEARGOAL,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDateb1, 1, 8) + '01' <= A.ORIGINATIONDATE AND  A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_BSTOT,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '01'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S01,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '02'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S02,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '03'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S03,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '04'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S04,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '05'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S05,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '06'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S06,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '07'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S07,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '08'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S08,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '09'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S09,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '10'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S10,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '11'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S11,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '12'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S12,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '13'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S13,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '14'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S14,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '15'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S15,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '16'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S16,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '17'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S17,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '18'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S18,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '19'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S19,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '20'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S20,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '21'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S21,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '22'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S22,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '23'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S23,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '24'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S24,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '25'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S25,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '26'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S26,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '27'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S27,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '28'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S28,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '29'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S29,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '30'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S30,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '31'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S31,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '01' <= A.ORIGINATIONDATE AND  A.ORIGINATIONDATE <= @ps_QCDate THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_STOT,
			 	   0 AS D_BBTOT,
			 	   0 AS D_B01,
			 	   0 AS D_B02,
			 	   0 AS D_B03,
			 	   0 AS D_B04,
			 	   0 AS D_B05,
			 	   0 AS D_B06,
			 	   0 AS D_B07,
			 	   0 AS D_B08,
			 	   0 AS D_B09,
			 	   0 AS D_B10,
			 	   0 AS D_B11,
			 	   0 AS D_B12,
			 	   0 AS D_B13,
			 	   0 AS D_B14,
			 	   0 AS D_B15,
			 	   0 AS D_B16,
			 	   0 AS D_B17,
			 	   0 AS D_B18,
			 	   0 AS D_B19,
			 	   0 AS D_B20,
			 	   0 AS D_B21,
			 	   0 AS D_B22,
			 	   0 AS D_B23,
			 	   0 AS D_B24,
			 	   0 AS D_B25,
			 	   0 AS D_B26,
			 	   0 AS D_B27,
			 	   0 AS D_B28,
			 	   0 AS D_B29,
			 	   0 AS D_B30,
			 	   0 AS D_B31,
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
			   AND C.FSFLAG          =  'S'
			   AND A.LARGEGROUPCODE  *= C.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= SUBSTRING(@ps_QCDateb1, 1, 8) + '01'
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.ORIGINATIONDATE
		
			UNION ALL
		
	        SELECT '00'     AS AS_SMALL,
	               '합  계' AS AS_NAME,
	               0        AS AS_YEARGOAL,
			 	   0 AS D_BSTOT,
			 	   0 AS D_S01,
			 	   0 AS D_S02,
			 	   0 AS D_S03,
			 	   0 AS D_S04,
			 	   0 AS D_S05,
			 	   0 AS D_S06,
			 	   0 AS D_S07,
			 	   0 AS D_S08,
			 	   0 AS D_S09,
			 	   0 AS D_S10,
			 	   0 AS D_S11,
			 	   0 AS D_S12,
			 	   0 AS D_S13,
			 	   0 AS D_S14,
			 	   0 AS D_S15,
			 	   0 AS D_S16,
			 	   0 AS D_S17,
			 	   0 AS D_S18,
			 	   0 AS D_S19,
			 	   0 AS D_S20,
			 	   0 AS D_S21,
			 	   0 AS D_S22,
			 	   0 AS D_S23,
			 	   0 AS D_S24,
			 	   0 AS D_S25,
			 	   0 AS D_S26,
			 	   0 AS D_S27,
			 	   0 AS D_S28,
			 	   0 AS D_S29,
			 	   0 AS D_S30,
			 	   0 AS D_S31,
			 	   0 AS D_STOT,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDateb1, 1, 8) + '01' <= A.ORIGINATIONDATE AND  A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_BBTOT,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '01'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '02'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '03'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '04'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '05'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '06'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '07'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B07,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '08'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B08,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '09'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B09,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '10'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B10,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '11'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B11,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '12'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B12,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '13'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B13,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '14'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B14,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '15'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B15,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '16'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B16,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '17'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B17,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '18'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B18,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '19'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B19,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '20'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B20,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '21'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B21,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '22'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B22,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '23'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B23,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '24'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B24,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '25'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B25,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '26'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B26,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '27'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B27,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '28'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B28,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '29'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B29,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '30'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B30,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '31'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B31,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '01' <= A.ORIGINATIONDATE AND  A.ORIGINATIONDATE <= @ps_QCDate THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_BTOT
			  FROM TQPROGRESSBADDETAIL  A,
			       TQLARGEGROUP         B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= SUBSTRING(@ps_QCDateb1, 1, 8) + '01'
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.ORIGINATIONDATE
	  
	        UNION ALL
	  
	        SELECT A.SMALLGROUPCODE  AS AS_SMALL,
	               D.SMALLGROUPNAME  AS AS_NAME,
	               MAX(C.YEARGOAL)    AS AS_YEARGOAL,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDateb1, 1, 8) + '01' <= A.ORIGINATIONDATE AND  A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_BSTOT,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '01'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S01,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '02'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S02,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '03'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S03,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '04'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S04,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '05'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S05,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '06'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S06,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '07'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S07,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '08'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S08,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '09'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S09,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '10'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S10,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '11'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S11,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '12'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S12,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '13'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S13,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '14'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S14,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '15'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S15,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '16'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S16,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '17'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S17,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '18'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S18,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '19'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S19,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '20'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S20,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '21'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S21,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '22'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S22,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '23'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S23,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '24'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S24,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '25'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S25,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '26'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S26,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '27'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S27,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '28'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S28,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '29'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S29,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '30'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S30,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '31'  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S31,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '01' <= A.ORIGINATIONDATE AND  A.ORIGINATIONDATE <= @ps_QCDate THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_STOT,
			 	   0 AS D_BBTOT,
			 	   0 AS D_B01,
			 	   0 AS D_B02,
			 	   0 AS D_B03,
			 	   0 AS D_B04,
			 	   0 AS D_B05,
			 	   0 AS D_B06,
			 	   0 AS D_B07,
			 	   0 AS D_B08,
			 	   0 AS D_B09,
			 	   0 AS D_B10,
			 	   0 AS D_B11,
			 	   0 AS D_B12,
			 	   0 AS D_B13,
			 	   0 AS D_B14,
			 	   0 AS D_B15,
			 	   0 AS D_B16,
			 	   0 AS D_B17,
			 	   0 AS D_B18,
			 	   0 AS D_B19,
			 	   0 AS D_B20,
			 	   0 AS D_B21,
			 	   0 AS D_B22,
			 	   0 AS D_B23,
			 	   0 AS D_B24,
			 	   0 AS D_B25,
			 	   0 AS D_B26,
			 	   0 AS D_B27,
			 	   0 AS D_B28,
			 	   0 AS D_B29,
			 	   0 AS D_B30,
			 	   0 AS D_B31,
			 	   0 AS D_BTOT
			  FROM TQPROGRESSBADMASTER  A,
			       TQLARGEGROUP         B,
				   TQLARGEGROUPTOGOALREJECT  C,
                   TQSMALLGROUP        D
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 *= C.AREACODE
			   AND A.DIVISIONCODE 	 *= C.DIVISIONCODE
			   AND C.STANDARDYEAR    =  SUBSTRING(@ps_QCDate, 1, 4)
			   AND C.FSFLAG          =  'S'
			   AND A.LARGEGROUPCODE  *= C.LARGEGROUPCODE 
			   AND A.AREACODE		 =  D.AREACODE
			   AND A.DIVISIONCODE 	 =  D.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  D.LARGEGROUPCODE 
			   AND A.MIDDLEGROUPCODE =  D.MIDDLEGROUPCODE 
			   AND A.SMALLGROUPCODE  =  D.SMALLGROUPCODE 
			   AND A.AREACODE		 =  @ps_areacode
			   AND A.DIVISIONCODE 	 =  @ps_divisioncode
			   AND A.ORIGINATIONDATE >= SUBSTRING(@ps_QCDateb1, 1, 8) + '01'
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.SMALLGROUPCODE, D.SMALLGROUPNAME
		
			UNION ALL
		
	        SELECT A.SMALLGROUPCODE     AS AS_SMALL,
	               C.SMALLGROUPNAME     AS AS_NAME,
	               0                    AS AS_YEARGOAL,
			 	   0 AS D_BSTOT,
			 	   0 AS D_S01,
			 	   0 AS D_S02,
			 	   0 AS D_S03,
			 	   0 AS D_S04,
			 	   0 AS D_S05,
			 	   0 AS D_S06,
			 	   0 AS D_S07,
			 	   0 AS D_S08,
			 	   0 AS D_S09,
			 	   0 AS D_S10,
			 	   0 AS D_S11,
			 	   0 AS D_S12,
			 	   0 AS D_S13,
			 	   0 AS D_S14,
			 	   0 AS D_S15,
			 	   0 AS D_S16,
			 	   0 AS D_S17,
			 	   0 AS D_S18,
			 	   0 AS D_S19,
			 	   0 AS D_S20,
			 	   0 AS D_S21,
			 	   0 AS D_S22,
			 	   0 AS D_S23,
			 	   0 AS D_S24,
			 	   0 AS D_S25,
			 	   0 AS D_S26,
			 	   0 AS D_S27,
			 	   0 AS D_S28,
			 	   0 AS D_S29,
			 	   0 AS D_S30,
			 	   0 AS D_S31,
			 	   0 AS D_STOT,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDateb1, 1, 8) + '01' <= A.ORIGINATIONDATE AND  A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_BBTOT,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '01'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '02'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '03'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '04'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '05'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '06'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '07'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B07,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '08'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B08,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '09'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B09,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '10'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B10,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '11'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B11,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '12'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B12,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '13'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B13,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '14'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B14,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '15'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B15,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '16'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B16,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '17'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B17,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '18'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B18,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '19'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B19,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '20'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B20,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '21'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B21,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '22'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B22,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '23'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B23,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '24'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B24,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '25'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B25,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '26'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B26,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '27'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B27,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '28'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B28,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '29'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B29,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '30'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B30,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '31'  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B31,
			 	   SUM(CASE WHEN SUBSTRING(@ps_QCDate  , 1, 8) + '01' <= A.ORIGINATIONDATE AND  A.ORIGINATIONDATE <= @ps_QCDate THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_BTOT
			  FROM TQPROGRESSBADDETAIL  A,
			       TQLARGEGROUP         B,
			       TQSMALLGROUP         C
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  C.AREACODE
			   AND A.DIVISIONCODE 	 =  C.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  C.LARGEGROUPCODE 
			   AND A.MIDDLEGROUPCODE =  C.MIDDLEGROUPCODE 
			   AND A.SMALLGROUPCODE  =  C.SMALLGROUPCODE 
			   AND A.AREACODE		 =  @ps_areacode
			   AND A.DIVISIONCODE 	 =  @ps_divisioncode
			   AND A.ORIGINATIONDATE >= SUBSTRING(@ps_QCDateb1, 1, 8) + '01'
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.SMALLGROUPCODE, C.SMALLGROUPNAME
	       ) TMP
	 GROUP BY AS_SMALL, AS_NAME
	 ORDER BY AS_SMALL, AS_NAME
    
END 

go
