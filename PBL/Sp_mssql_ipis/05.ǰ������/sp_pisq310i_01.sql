/************************************************************************************************/
/*	File Name	: sp_pisq310i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: Containment 불량현황(월별불량율)                                              */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQCONTAINQCENTRY                                                              */
/*  			  TQCONTAINQCENTRYDETAIL                                                        */
/*  			  TMSTITEM                                                                      */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_ProductGroup      char(02)    => 제품군                                   */
/*                @ps_ModelGroup        char(03)    => 모델군                                   */
/*                @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*	Notes		: Containment 월별불량율을 화면에 표시한다                                      */
/*	Made Date	: 2002. 10. 01                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq310i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq310i_01
GO
/*
Exec sp_pisq310i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
        @ps_ProductGroup    = '%'   ,
        @ps_ModelGroup      = '%'   ,
        @ps_QCDateFm        = '2002.12.01'     ,
        @ps_QCDateTo        = '2002.12.31'      

*/


/****** Object:  Stored Procedure dbo.sp_pisq310i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq310i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_ProductGroup      varchar(02)   ,   -- 제품군
        @ps_ModelGroup        varchar(03)   ,   -- 모델군
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO

AS

BEGIN

	SELECT AS_ITEM	AS AS_ITEMCODE,
	       AS_NAME	AS AS_ITEMNAME,
		   CASE WHEN SUM(D_B11)  = 0 THEN 0 ELSE ISNULL(SUM(D_B11)  / CAST(SUM(M_S11)  AS FLOAT) * 100, 0) END AS AS_RATE11,
		   CASE WHEN SUM(D_B10)  = 0 THEN 0 ELSE ISNULL(SUM(D_B10)  / CAST(SUM(M_S10)  AS FLOAT) * 100, 0) END AS AS_RATE10,
		   CASE WHEN SUM(D_B09)  = 0 THEN 0 ELSE ISNULL(SUM(D_B09)  / CAST(SUM(M_S09)  AS FLOAT) * 100, 0) END AS AS_RATE09,
		   CASE WHEN SUM(D_B08)  = 0 THEN 0 ELSE ISNULL(SUM(D_B08)  / CAST(SUM(M_S08)  AS FLOAT) * 100, 0) END AS AS_RATE08,
		   CASE WHEN SUM(D_B07)  = 0 THEN 0 ELSE ISNULL(SUM(D_B07)  / CAST(SUM(M_S07)  AS FLOAT) * 100, 0) END AS AS_RATE07,
		   CASE WHEN SUM(D_B06)  = 0 THEN 0 ELSE ISNULL(SUM(D_B06)  / CAST(SUM(M_S06)  AS FLOAT) * 100, 0) END AS AS_RATE06,
		   CASE WHEN SUM(D_B05)  = 0 THEN 0 ELSE ISNULL(SUM(D_B05)  / CAST(SUM(M_S05)  AS FLOAT) * 100, 0) END AS AS_RATE05,
		   CASE WHEN SUM(D_B04)  = 0 THEN 0 ELSE ISNULL(SUM(D_B04)  / CAST(SUM(M_S04)  AS FLOAT) * 100, 0) END AS AS_RATE04,
		   CASE WHEN SUM(D_B03)  = 0 THEN 0 ELSE ISNULL(SUM(D_B03)  / CAST(SUM(M_S03)  AS FLOAT) * 100, 0) END AS AS_RATE03,
		   CASE WHEN SUM(D_B02)  = 0 THEN 0 ELSE ISNULL(SUM(D_B02)  / CAST(SUM(M_S02)  AS FLOAT) * 100, 0) END AS AS_RATE02,
		   CASE WHEN SUM(D_B01)  = 0 THEN 0 ELSE ISNULL(SUM(D_B01)  / CAST(SUM(M_S01)  AS FLOAT) * 100, 0) END AS AS_RATE01,
		   CASE WHEN SUM(D_B00)  = 0 THEN 0 ELSE ISNULL(SUM(D_B00)  / CAST(SUM(M_S00)  AS FLOAT) * 100, 0) END AS AS_RATE00,
		   CASE WHEN SUM(D_BTOT) = 0 THEN 0 ELSE ISNULL(SUM(D_BTOT) / CAST(SUM(M_STOT) AS FLOAT) * 100, 0) END AS AS_RATETOT
	  FROM (SELECT ' '     AS AS_ITEM,
	               '합  계' AS AS_NAME,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S11,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S10,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S09,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S08,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S07,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S06,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S04,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S03,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S02,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S01,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S00,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_STOT,
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
			  FROM TQCONTAINQCENTRY  A
			 WHERE A.AREACODE			=	 @ps_areacode
			   AND A.DIVISIONCODE		=	 @ps_divisioncode
			   AND A.PRODUCTGROUP		LIKE @ps_ProductGroup
			   AND A.MODELGROUP			LIKE @ps_ModelGroup
			   AND A.QCDATE				>=   CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102)
			   AND A.QCDATE				<=   @ps_QCDateTo
			   AND A.QCFLAG				=	 '0'
			 GROUP BY SUBSTRING(A.QCDATE, 1, 7)
		
			UNION ALL
		
	        SELECT ' '     AS AS_ITEM,
	               '합  계' AS AS_NAME,
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
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B11,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B10,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B09,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B08,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B07,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B00,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_BTOT
			  FROM TQCONTAINQCENTRY  		A,
			       TQCONTAINQCENTRYDETAIL   B
			 WHERE A.AREACODE			=	 B.AREACODE
			   AND A.DIVISIONCODE		=	 B.DIVISIONCODE
			   AND A.PRDENDDATE			=	 B.PRDENDDATE
			   AND A.KBNO				=	 B.KBNO
			   AND A.AREACODE		 	=    @ps_AreaCode
			   AND A.DIVISIONCODE		=	 @ps_divisioncode
			   AND A.PRODUCTGROUP		LIKE @ps_ProductGroup
			   AND A.MODELGROUP			LIKE @ps_ModelGroup
			   AND A.QCDATE				>=   CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102)
			   AND A.QCDATE				<=   @ps_QCDateTo
			   AND A.QCFLAG				=	 '0'
			 GROUP BY SUBSTRING(A.QCDATE, 1, 7)
	  
	        UNION ALL
	  
	        SELECT A.ITEMCODE	AS AS_ITEM,
	               B.ITEMNAME	AS AS_NAME,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S11,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S10,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S09,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S08,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S07,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S06,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S04,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S03,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S02,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S01,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_S00,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN A.QCQTY ELSE 0 END) AS M_STOT,
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
			  FROM TQCONTAINQCENTRY  A,
			       TMSTITEM          B
			 WHERE A.ITEMCODE		 	=  B.ITEMCODE
			   AND A.AREACODE		 	=    @ps_AreaCode
			   AND A.DIVISIONCODE		=	 @ps_divisioncode
			   AND A.PRODUCTGROUP		LIKE @ps_ProductGroup
			   AND A.MODELGROUP			LIKE @ps_ModelGroup
			   AND A.QCDATE				>=   CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102)
			   AND A.QCDATE				<=   @ps_QCDateTo
			   AND A.QCFLAG				=	 '0'
			 GROUP BY A.ITEMCODE, B.ITEMNAME
		
			UNION ALL
		
	        SELECT A.ITEMCODE	AS AS_ITEM,
	               C.ITEMNAME	AS AS_NAME,
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
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B11,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -10, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B10,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -09, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B09,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -08, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B08,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -07, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B07,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -06, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -05, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -04, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -03, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -02, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -01, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_B00,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102) <= A.QCDATE AND A.QCDATE <= CONVERT(CHAR(10), DATEADD(month, -00, @ps_QCDateTo), 102) THEN B.BADQTY ELSE 0 END) AS D_BTOT
			  FROM TQCONTAINQCENTRY  		A,
			       TQCONTAINQCENTRYDETAIL   B,
			       TMSTITEM          		C
			 WHERE A.AREACODE			=	 B.AREACODE
			   AND A.DIVISIONCODE		=	 B.DIVISIONCODE
			   AND A.PRDENDDATE			=	 B.PRDENDDATE
			   AND A.KBNO				=	 B.KBNO
			   AND A.ITEMCODE		 	=  	 C.ITEMCODE
			   AND A.AREACODE		 	=    @ps_AreaCode
			   AND A.DIVISIONCODE		=	 @ps_divisioncode
			   AND A.PRODUCTGROUP		LIKE @ps_ProductGroup
			   AND A.MODELGROUP			LIKE @ps_ModelGroup
			   AND A.QCDATE				>=   CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102)
			   AND A.QCDATE				<=   @ps_QCDateTo
			   AND A.QCFLAG				=	 '0'
			 GROUP BY A.ITEMCODE, C.ITEMNAME
	       ) TMP
	 GROUP BY AS_ITEM, AS_NAME
	 ORDER BY AS_ITEM, AS_NAME
    
END 

go
