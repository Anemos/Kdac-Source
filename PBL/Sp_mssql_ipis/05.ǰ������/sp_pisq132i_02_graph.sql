/************************************************************************************************/
/*	File Name	: sp_pisq132i_02_graph.SQL                                                      */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 수입검사 불량율(품번별 WORST 그래프-LOT별)                                    */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTITEM                                                                      */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(1)     => 공장코드                                 */
/*                @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*	Notes		: 수입검사 불량율 현황중 품번별 WORST 10의 자료를 조회한다(그래프).             */
/*	Made Date	: 2002. 09. 13                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq132i_02_graph') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq132i_02_graph
GO
/*
Exec sp_pisq132i_02_graph
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
        @ps_QCDateFm        = '2002.01.01'      ,
        @ps_QCDateTo        = '2002.12.31'
*/


/****** Object:  Stored Procedure dbo.sp_pisq132i_02_graph    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq132i_02_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO
AS

BEGIN

	SELECT TOP 10
		   AS_AREA                     AS AS_AREACODE	,
		   AS_ITEM                     AS AS_ITEMCODE   ,
           AS_ITEMNAME 		           AS AS_ITEMNAME 	,   
		   sum(AS_SUPPLIERDELIVERYQTY) AS AS_IN			,
		   sum(AS_BADQTY)              AS AS_BAD		,
		   (cast(SUM(AS_BADQTY) as float) / cast(sum(AS_SUPPLIERDELIVERYQTY) as float)) * 100 AS AS_RATE
	  FROM (
			SELECT A.AREACODE 		             AS AS_AREA,
				   A.ITEMCODE	                 AS AS_ITEM,
                   B.ITEMNAME             		 AS AS_ITEMNAME ,   
				   count(A.SUPPLIERDELIVERYQTY)  AS AS_SUPPLIERDELIVERYQTY,
				   0                             AS AS_BADQTY
			  FROM TQQCRESULT    A,
		           TMSTITEM      B
		     WHERE A.ITEMCODE      *= B.ITEMCODE 
		       AND A.AREACODE      =  @ps_AreaCode
		       AND A.DIVISIONCODE  =  @ps_DivisionCode
		       AND A.QCDATE        >= @ps_QCDateFm
		       AND A.QCDATE        <= @ps_QCDateTo
		     GROUP BY A.AREACODE, A.ITEMCODE, B.ITEMNAME
	
			UNION ALL
	
			SELECT A.AREACODE 		             AS AS_AREA,
				   A.ITEMCODE	                 AS AS_ITEM,
                   B.ITEMNAME                    AS AS_ITEMNAME ,   
				   0                             AS AS_SUPPLIERDELIVERYQTY,
				   count(A.BADQTY)	             AS AS_BADQTY
			  FROM TQQCRESULT    A,
		           TMSTITEM      B
		     WHERE A.ITEMCODE     *=  B.ITEMCODE 
		       AND A.AREACODE      =  @ps_AreaCode
		       AND A.DIVISIONCODE  =  @ps_DivisionCode
		       AND A.QCDATE        >= @ps_QCDateFm
		       AND A.QCDATE        <= @ps_QCDateTo
	           AND A.JUDGEFLAG     IN ('2', '3')
		     GROUP BY A.AREACODE, A.ITEMCODE, B.ITEMNAME
		) TMP
		GROUP BY AS_AREA,
		         AS_ITEM,
                 AS_ITEMNAME 
	 	HAVING   sum(AS_BADQTY) > 0
		ORDER BY (cast(SUM(AS_BADQTY) as float) / cast(sum(AS_SUPPLIERDELIVERYQTY) as float)) * 100  DESC
    
END 

go
