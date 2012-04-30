/************************************************************************************************/
/*	File Name	: sp_pisq230i_04.SQL                                                            */
/*	SYSTEM		: ǰ������(����ǰ��)                                                            */
/*	Description	: �ְ��� SCRAP ��Ȳ(��ǰ�Һз���������)                                         */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROGRESSBADMASTER                                                           */
/*                TQPROGRESSBADDETAIL                                                           */
/*                TQLARGEGROUP                                                                  */
/*                TQLARGEGROUPTOGOALREJECT                                                      */
/*                TQSMALLGROUP          														*/
/*                TQSMALLGROUPTOPROCESS 														*/
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(01)    => �����ڵ�                                 */
/*                @ps_maflag            char(01)    => ����/���� ����							*/
/*                @ps_QCDate            char(10)    => ��ȸ����                                 */
/*                @ps_QCDateb1          char(10)    => ��ȸ����(�������� 1����)                 */
/*                @ps_largegroupcode    char(02)    => ��ǰ��з��ڵ�                           */
/*                @ps_middlegroupcode   char(02)    => ��ǰ�ߺз��ڵ�                           */
/*                @ps_smallgroupcode    char(02)    => ��ǰ�Һз��ڵ�                           */
/*	Notes		: �ְ��� SCRAP��Ȳ�� �Һз��������� �ڷḦ ��ȸ�Ѵ�.                            */
/*	Made Date	: 2002. 09. 27                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq230i_04') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq230i_04
GO
/*
Exec sp_pisq230i_04
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_maflag          = '%' ,
        @ps_QCDate          = '2002.09.25' ,
        @ps_QCDateb1        = '2001.09.25' ,
        @ps_largegroupcode  = '01'         ,
        @ps_middlegroupcode = '01'         ,
        @ps_smallgroupcode  = '01'

*/


/****** Object:  Stored Procedure dbo.sp_pisq230i_04    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq230i_04
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
        @ps_maflag            char(01)      ,   -- ����/���� ����
        @ps_QCDate            char(10)      ,   -- ��ȸ����
        @ps_QCDateb1          char(10)      ,   -- ��ȸ����(�������� 1����)
        @ps_largegroupcode    char(02)      ,   -- ��ǰ��з��ڵ�
        @ps_middlegroupcode   char(02)      ,   -- ��ǰ�ߺз��ڵ�
        @ps_smallgroupcode    char(02)          -- ��ǰ�Һз��ڵ�

AS

BEGIN

	SELECT AS_PROCESS                                                                   AS AS_PROCESSCODE,
	       AS_NAME                                                                      AS AS_PROCESSNAME,
		   CASE WHEN SUM(D_BSTOT) - SUM(D_BBTOT) = 0 THEN 0 ELSE
			    ISNULL(SUM(D_BBTOT) / (CAST(SUM(D_BSTOT) - SUM(D_BBTOT) AS FLOAT)) * 100, 0) END AS AS_BSCRAP,
		   CASE WHEN SUM(D_S06) - SUM(D_B06) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B06)   / (CAST(SUM(D_S06)   - SUM(D_B06) AS FLOAT))   * 100, 0) END AS AS_SCRAP06,
		   CASE WHEN SUM(D_S05) - SUM(D_B05) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B05)   / (CAST(SUM(D_S05)   - SUM(D_B05) AS FLOAT))   * 100, 0) END AS AS_SCRAP05,
		   CASE WHEN SUM(D_S04) - SUM(D_B04) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B04)   / (CAST(SUM(D_S04)   - SUM(D_B04) AS FLOAT))   * 100, 0) END AS AS_SCRAP04,
		   CASE WHEN SUM(D_S03) - SUM(D_B03) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B03)   / (CAST(SUM(D_S03)   - SUM(D_B03) AS FLOAT))   * 100, 0) END AS AS_SCRAP03,
		   CASE WHEN SUM(D_S02) - SUM(D_B02) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B02)   / (CAST(SUM(D_S02)   - SUM(D_B02) AS FLOAT))   * 100, 0) END AS AS_SCRAP02,
		   CASE WHEN SUM(D_S01) - SUM(D_B01) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B01)   / (CAST(SUM(D_S01)   - SUM(D_B01) AS FLOAT))   * 100, 0) END AS AS_SCRAP01,
		   CASE WHEN SUM(D_S00) - SUM(D_B00) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_B00)   / (CAST(SUM(D_S00)   - SUM(D_B00) AS FLOAT))   * 100, 0) END AS AS_SCRAP00,
		   CASE WHEN SUM(D_STOT) - SUM(D_BTOT) = 0 THEN 0 ELSE
		   		ISNULL(SUM(D_BTOT)  / (CAST(SUM(D_STOT)  - SUM(D_BTOT) AS FLOAT))  * 100, 0) END AS AS_SCRAPTOT,
	       MAX(AS_YEARGOAL)                                                             AS AS_YEAR
	  FROM (SELECT '#00'    AS AS_PROCESS,
	               '��  ��' AS AS_NAME,
	               AVG(C.YEARGOAL)    AS AS_YEARGOAL,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_BSTOT,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S06,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -5, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -4, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S04,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -3, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S03,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -2, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S02,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -1, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S01,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -0, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S00,
				   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDate THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_STOT,
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
			   AND C.FSFLAG          =  'S'
			   AND A.LARGEGROUPCODE  *= C.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND A.SMALLGROUPCODE  =  @ps_smallgroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.ORIGINATIONDATE
		
			UNION ALL
		
	        SELECT '#00'    AS AS_PROCESS,
	               '��  ��' AS AS_NAME,
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
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_BBTOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -5, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -4, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -3, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -2, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -1, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -0, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B00,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDate THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_BTOT
			  FROM TQPROGRESSBADDETAIL  A,
			       TQLARGEGROUP         B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND A.SMALLGROUPCODE  =  @ps_smallgroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.ORIGINATIONDATE
	  
	        UNION ALL
	  
		    SELECT A.PROCESSCODE       AS AS_PROCESSCODE,
	               D.PROCESSNAME       AS AS_PROCESSNAME,
	               AS_YEARGOAL,
			 	   D_BSTOT,
			 	   D_S06,
			 	   D_S05,
			 	   D_S04,
			 	   D_S03,
			 	   D_S02,
			 	   D_S01,
			 	   D_S00,
			 	   D_STOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_BBTOT,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B06,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -5, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B05,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -4, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B04,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -3, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B03,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -2, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B02,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -1, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B01,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -0, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_B00,
			 	   SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDate THEN A.DISUSEQTY * A.PROCESSCOST ELSE 0 END) AS D_BTOT
			  FROM TQPROGRESSBADDETAIL   A,
			       TQLARGEGROUP          B,
			       TQSMALLGROUP          C,
			       TQSMALLGROUPTOPROCESS D,
                   ( SELECT A.SMALLGROUPCODE  AS AS_SMALL,
							D.SMALLGROUPNAME  AS AS_NAME,
							MAX(C.YEARGOAL)   AS AS_YEARGOAL,
						    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDateb1 THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_BSTOT,
						    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S06,
						    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -5, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S05,
					 	    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -4, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S04,
						    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -3, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S03,
						    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -2, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S02,
						    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -1, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S01,
						    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -0, @ps_QCDate)  , 102)  = A.ORIGINATIONDATE THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_S00,
						    SUM(CASE WHEN CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDate)  , 102) <= A.ORIGINATIONDATE AND A.ORIGINATIONDATE <= @ps_QCDate THEN A.PRODUCTQTY * A.PROCESSCOST ELSE 0 END) AS D_STOT
					   FROM TQPROGRESSBADMASTER      A,
							TQLARGEGROUP             B,
							TQLARGEGROUPTOGOALREJECT C,
							TQSMALLGROUP             D
					  WHERE A.AREACODE		  =   B.AREACODE
						AND A.DIVISIONCODE 	  =   B.DIVISIONCODE
						AND A.LARGEGROUPCODE  =   B.LARGEGROUPCODE 
						AND A.AREACODE		  *=  C.AREACODE
						AND A.DIVISIONCODE 	  *=  C.DIVISIONCODE
						AND C.STANDARDYEAR    =   SUBSTRING(@ps_QCDate, 1, 4)
						AND C.FSFLAG          =   'S'
						AND A.LARGEGROUPCODE  *=  C.LARGEGROUPCODE 
						AND A.AREACODE		  =   D.AREACODE
						AND A.DIVISIONCODE 	  =   D.DIVISIONCODE
						AND A.LARGEGROUPCODE  =   D.LARGEGROUPCODE 
						AND A.MIDDLEGROUPCODE =   D.MIDDLEGROUPCODE 
						AND A.SMALLGROUPCODE  =   D.SMALLGROUPCODE 
						AND A.AREACODE		  =   @ps_areacode
						AND A.DIVISIONCODE 	  =   @ps_divisioncode
						AND A.ORIGINATIONDATE >=  CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102)
						AND A.ORIGINATIONDATE <=  @ps_QCDate
						AND A.LARGEGROUPCODE  =   @ps_largegroupcode
						AND A.MIDDLEGROUPCODE =   @ps_middlegroupcode
						AND A.SMALLGROUPCODE  =   @ps_smallgroupcode
						AND B.MAFLAG          LIKE @ps_maflag
					 GROUP BY A.SMALLGROUPCODE, D.SMALLGROUPNAME ) TEMP
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  C.AREACODE
			   AND A.DIVISIONCODE 	 =  C.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  C.LARGEGROUPCODE 
			   AND A.MIDDLEGROUPCODE =  C.MIDDLEGROUPCODE 
			   AND A.SMALLGROUPCODE  =  C.SMALLGROUPCODE 
			   AND A.AREACODE		 =  D.AREACODE
			   AND A.DIVISIONCODE 	 =  D.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  D.LARGEGROUPCODE 
			   AND A.MIDDLEGROUPCODE =  D.MIDDLEGROUPCODE 
			   AND A.SMALLGROUPCODE  =  D.SMALLGROUPCODE 
			   AND A.PROCESSCODE     =  D.PROCESSCODE
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(day, -6, @ps_QCDateb1), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND A.SMALLGROUPCODE  =  @ps_smallgroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.PROCESSCODE, D.PROCESSNAME, AS_YEARGOAL, D_BSTOT, D_S06, D_S05, D_S04, D_S03, D_S02, D_S01, D_S00,D_STOT
	       ) TMP
	 GROUP BY AS_PROCESS, AS_NAME
	 ORDER BY AS_PROCESS, AS_NAME
    
END 

go
