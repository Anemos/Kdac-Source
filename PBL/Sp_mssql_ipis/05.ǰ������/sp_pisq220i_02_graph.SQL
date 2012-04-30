/************************************************************************************************/
/*	File Name	: sp_pisq220i_02_graph.SQL                                                      */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: 월별 SCRAP 현황 그래프(제품중분류별)                                          */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROGRESSBADMASTER                                                           */
/*                TQPROGRESSBADDETAIL                                                           */
/*                TQLARGEGROUP                                                                  */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_maflag            char(01)    => 가공/조립 구분							*/
/*                @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*                @ps_largegroupcode    char(02)    => 제품대분류코드                           */
/*	Notes		: 월간 SCRAP현황중 중분류별 그래프를 조회한다.                                  */
/*	Made Date	: 2002. 09. 25                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq220i_02_graph') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq220i_02_graph
GO
/*
Exec sp_pisq220i_02_graph
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_maflag          = '%' ,
        @ps_QCDateFm        = '2002.12.01'      ,
        @ps_QCDateTo        = '2002.12.31'      ,
        @ps_largegroupcode  = '01'

*/


/****** Object:  Stored Procedure dbo.sp_pisq220i_02_graph    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq220i_02_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_maflag            char(01)      ,   -- 가공/조립 구분
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)      ,   -- 조회일자TO
        @ps_largegroupcode    char(02)          -- 제품대분류코드

AS

BEGIN
	SELECT AS_DATE AS AS_YYYYMM,
		   CASE WHEN SUM(AS_SQTY) - SUM(AS_BQTY) = 0 
		        THEN 0 
		        ELSE ISNULL(SUM(AS_BQTY) / (CAST(SUM(AS_SQTY) - SUM(AS_BQTY) AS FLOAT)) * 100, 0) END AS AS_SCRAP
	  FROM (SELECT SUBSTRING(A.ORIGINATIONDATE, 1, 7) AS AS_DATE,
			       SUM(A.PRODUCTQTY * A.PROCESSCOST)  AS AS_SQTY,
			       0                                  AS AS_BQTY
			  FROM TQPROGRESSBADMASTER A,
			 	   TQLARGEGROUP        B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDateTo
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY SUBSTRING(A.ORIGINATIONDATE, 1, 7)
			
			UNION ALL
			
		    SELECT SUBSTRING(A.ORIGINATIONDATE, 1, 7) AS AS_DATE,
			       0                                  AS AS_SQTY,
			       SUM(A.DISUSEQTY * A.PROCESSCOST)   AS AS_BQTY
			  FROM TQPROGRESSBADDETAIL A,
				   TQLARGEGROUP        B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102)
			   AND A.ORIGINATIONDATE <= @ps_QCDateTo
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY SUBSTRING(A.ORIGINATIONDATE, 1, 7)
	      ) TMP
	  GROUP BY AS_DATE
    
END 

go
