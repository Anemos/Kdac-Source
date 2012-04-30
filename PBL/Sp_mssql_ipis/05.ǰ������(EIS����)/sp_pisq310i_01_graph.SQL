/************************************************************************************************/
/*	File Name	: sp_pisq310i_01_graph.SQL                                                      */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: Containment 불량현황 그래프(월별불량율)                                       */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQCONTAINQCENTRY                                                              */
/*  			  TQCONTAINQCENTRYDETAIL                                                        */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_ProductGroup      char(02)    => 제품군                                   */
/*                @ps_ModelGroup        char(03)    => 모델군                                   */
/*                @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*	Notes		: Containment 월별불량율을 그래프를 화면에 표시한다                             */
/*	Made Date	: 2002. 10. 01                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq310i_01_graph') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq310i_01_graph
GO
/*
Exec sp_pisq310i_01_graph
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
        @ps_ProductGroup    = '%'   ,
        @ps_ModelGroup      = '%'   ,
        @ps_QCDateFm        = '2002.12.01'     ,
        @ps_QCDateTo        = '2002.12.31'      

*/


/****** Object:  Stored Procedure dbo.sp_pisq310i_01_graph    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq310i_01_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_ProductGroup      varchar(02)   ,   -- 제품군
        @ps_ModelGroup        varchar(03)   ,   -- 모델군
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO

AS

BEGIN
	SELECT AS_DATE AS AS_YYYYMM,
		   CASE WHEN SUM(AS_BQTY) = 0 THEN 0 ELSE ISNULL(SUM(AS_BQTY) / (CAST(SUM(AS_SQTY) AS FLOAT)) * 100, 0) END AS AS_RATE
	  FROM (SELECT SUBSTRING(A.QCDATE, 1, 7) AS AS_DATE,
			       SUM(A.QCQTY)              AS AS_SQTY,
			       0                         AS AS_BQTY
			  FROM TQCONTAINQCENTRY  A
			 WHERE A.AREACODE		=	 @ps_areacode
			   AND A.DIVISIONCODE	=	 @ps_divisioncode
			   AND A.PRODUCTGROUP	LIKE @ps_ProductGroup
			   AND A.MODELGROUP		LIKE @ps_ModelGroup
			   AND A.QCDATE			>=   CONVERT(CHAR(10), DATEADD(month, -11, @ps_QCDateFm), 102)
			   AND A.QCDATE			<=   @ps_QCDateTo
			   AND A.QCFLAG			=	 '0'
			 GROUP BY SUBSTRING(A.QCDATE, 1, 7)
			
			UNION ALL
			
		    SELECT SUBSTRING(A.QCDATE, 1, 7) AS AS_DATE,
			       0                         AS AS_SQTY,
			       SUM(B.BADQTY)             AS AS_BQTY
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
			   AND A.QCFLAG				 =	 '0'
			 GROUP BY SUBSTRING(A.QCDATE, 1, 7)
	      ) TMP
	  GROUP BY AS_DATE
    
END 

go
