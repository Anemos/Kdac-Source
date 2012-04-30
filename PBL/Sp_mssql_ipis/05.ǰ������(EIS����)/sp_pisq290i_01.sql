/************************************************************************************************/
/*	File Name	: sp_pisq290i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(공정품질)                                                            */
/*	Description	: Containment 불량현황(품번별)                                                  */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQCONTAINQCENTRY																*/
/*	              TQCONTAINQCENTRYDETAIL														*/
/*  Parameter   : @ps_areacode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_ProductGroup      char(02)    => 제품군                                   */
/*                @ps_ModelGroup        char(03)    => 모델군                                   */
/*                @ps_datefm            char(10)    => 일자FROM                                 */
/*                @ps_dateto            char(10)    => 일자TO                                   */
/*	Notes		: Containment 불량현황을 화면에 표시한다                                        */
/*	Made Date	: 2002. 09. 30                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq290i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq290i_01
GO
/*
Exec sp_pisq290i_01
		@ps_areacode        = 'D'   ,
		@ps_divisioncode    = 'A'   ,
        @ps_ProductGroup    = '%'   ,
        @ps_ModelGroup      = '%'   ,
        @ps_datefm          = '2000.01.01' ,
        @ps_dateto          = '2002.12.31'
*/


/****** Object:  Stored Procedure dbo.sp_pisq290i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq290i_01
        @ps_areacode          char(01)      ,   -- 지역구분
        @ps_divisioncode      char(01)      ,   -- 공장코드
        @ps_ProductGroup      varchar(02)   ,   -- 제품군
        @ps_ModelGroup        varchar(03)   ,   -- 모델군
        @ps_datefm            char(10)      ,   -- 일자FROM
        @ps_dateto            char(10)          -- 일자TO

AS

BEGIN

	SELECT AS_ITEMCODE	 	AS AS_CODE ,   
	       B.ITEMNAME		AS AS_NAME ,
		   SUM(AS_RACKQTY)	AS AS_RACK ,
		   SUM(AS_QCQTY)  	AS AS_QCQTY,
		   SUM(AS_BADQTY) 	AS AS_BAD  ,
	       CAST(SUM(AS_BADQTY) AS FLOAT) / CAST(SUM(AS_RACKQTY) AS FLOAT) * 100 AS AS_RATE,
	       5 AS AS_CNT
	  FROM ( SELECT A.ITEMCODE		AS AS_ITEMCODE	,   
			        SUM(A.RACKQTY)	AS AS_RACKQTY	,
			        SUM(A.QCQTY)	AS AS_QCQTY		,   
			        0				AS AS_BADQTY  
			    FROM TQCONTAINQCENTRY A
			   WHERE A.AREACODE		=	 @ps_areacode
       			 AND A.DIVISIONCODE	=	 @ps_divisioncode
       			 AND A.PRODUCTGROUP	LIKE @ps_ProductGroup
       			 AND A.MODELGROUP	LIKE @ps_ModelGroup
       			 AND A.QCDATE		>=   @ps_datefm
       			 AND A.QCDATE		<=   @ps_dateto
			     AND A.QCFLAG		=	 '0'
			   GROUP BY A.ITEMCODE
			
			 UNION ALL
			
			 SELECT A.ITEMCODE		AS AS_ITEMCODE	,   
			        0				AS AS_RACKQTY	,
			        0				AS AS_QCQTY		,   
			        SUM(B.BADQTY)	AS AS_BADQTY  
			   FROM TQCONTAINQCENTRY		A,	
					TQCONTAINQCENTRYDETAIL	B
			  WHERE A.AREACODE		=	 B.AREACODE
			    AND A.DIVISIONCODE	=	 B.DIVISIONCODE
				AND A.PRDENDDATE	=	 B.PRDENDDATE
				AND A.KBNO			=	 B.KBNO
				AND A.AREACODE		=	 @ps_areacode
       			AND A.DIVISIONCODE	=	 @ps_divisioncode
       			AND A.PRODUCTGROUP	LIKE @ps_ProductGroup
       			AND A.MODELGROUP	LIKE @ps_ModelGroup
       			AND A.QCDATE		>=   @ps_datefm
       			AND A.QCDATE		<=   @ps_dateto
				AND A.QCFLAG		=	 '0'
			  GROUP BY A.ITEMCODE ) TMP ,
	       TMSTITEM B
	 WHERE AS_ITEMCODE = B.ITEMCODE
	 GROUP BY AS_ITEMCODE, B.ITEMNAME
	 
END 

go
