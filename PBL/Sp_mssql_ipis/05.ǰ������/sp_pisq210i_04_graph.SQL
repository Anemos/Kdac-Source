/************************************************************************************************/
/*	File Name	: sp_pisq210i_04_graph.SQL                                                      */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: 일별 FTTQ 현황 그래프(제품소분류별공정별)                                     */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQPROGRESSBADMASTER                                                           */
/*                TQPROGRESSBADDETAIL                                                           */
/*                TQLARGEGROUP                                                                  */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_maflag            char(01)    => 가공/조립 구분							*/
/*                @ps_QCDate            char(10)    => 조회일자                                 */
/*                @ps_largegroupcode    char(02)    => 제품대분류코드                           */
/*                @ps_middlegroupcode   char(02)    => 제품중분류코드                           */
/*                @ps_smallgroupcode    char(02)    => 제품소분류코드                           */
/*	Notes		: 일별 FTTQ현황중 소분류별공정별 자료를 조회한다.                               */
/*	Made Date	: 2002. 09. 26                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq210i_04_graph') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq210i_04_graph
GO
/*
Exec sp_pisq210i_04_graph
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_maflag          = '%' ,
        @ps_QCDate          = '2002.09.25',
        @ps_largegroupcode  = '01'         ,
        @ps_middlegroupcode = '01'         ,
        @ps_smallgroupcode  = '01'

*/


/****** Object:  Stored Procedure dbo.sp_pisq210i_04_graph    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq210i_04_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_maflag            char(01)      ,   -- 가공/조립 구분
        @ps_QCDate            char(10)      ,   -- 조회일자
        @ps_largegroupcode    char(02)      ,   -- 제품대분류코드
        @ps_middlegroupcode   char(02)      ,   -- 제품중분류코드
        @ps_smallgroupcode    char(02)          -- 제품소분류코드

AS

BEGIN
	SELECT AS_DATE AS AS_YYYYMM,
		   CASE WHEN SUM(AS_SQTY) - SUM(AS_BQTY) = 0 
		        THEN 0 
		        ELSE ISNULL(SUM(AS_BQTY) / (CAST(SUM(AS_SQTY) - SUM(AS_BQTY) AS FLOAT)) * 100, 0) END AS AS_FTTQ
	  FROM (SELECT A.ORIGINATIONDATE                  AS AS_DATE,
			       SUM(A.PRODUCTQTY)                  AS AS_SQTY,
			       0                                  AS AS_BQTY
			  FROM TQPROGRESSBADMASTER A,
			 	   TQLARGEGROUP        B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= SUBSTRING(@ps_QCDate, 1, 8) + '01'
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND A.SMALLGROUPCODE  =  @ps_smallgroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.ORIGINATIONDATE
			
			UNION ALL
			
		    SELECT A.ORIGINATIONDATE                  AS AS_DATE,
			       0                                  AS AS_SQTY,
			       SUM(A.TOTALQTY)                    AS AS_BQTY
			  FROM TQPROGRESSBADDETAIL A,
				   TQLARGEGROUP        B
			 WHERE A.AREACODE		 =  B.AREACODE
			   AND A.DIVISIONCODE 	 =  B.DIVISIONCODE
			   AND A.LARGEGROUPCODE  =  B.LARGEGROUPCODE 
			   AND A.AREACODE		 =  @ps_AreaCode
			   AND A.DIVISIONCODE 	 =  @ps_DivisionCode
			   AND A.ORIGINATIONDATE >= SUBSTRING(@ps_QCDate, 1, 8) + '01'
			   AND A.ORIGINATIONDATE <= @ps_QCDate
			   AND A.LARGEGROUPCODE  =  @ps_largegroupcode
			   AND A.MIDDLEGROUPCODE =  @ps_middlegroupcode
			   AND A.SMALLGROUPCODE  =  @ps_smallgroupcode
			   AND B.MAFLAG          LIKE @ps_maflag
			 GROUP BY A.ORIGINATIONDATE
	      ) TMP
	  GROUP BY AS_DATE
    
END 

go
