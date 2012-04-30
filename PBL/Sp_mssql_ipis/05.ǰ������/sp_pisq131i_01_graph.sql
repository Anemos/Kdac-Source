/************************************************************************************************/
/*	File Name	: sp_pisq131i_01_graph.SQL                                                      */
/*	SYSTEM		: 품질관리(부품품질)                                                            */
/*	Description	: 수입검사 불량율(업체별 WORST 그래프-수량별)                                   */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQQCRESULT                                                                    */
/*	              TMSTSUPPLIER                                                                  */
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(1)     => 공장코드                                 */
/*                @ps_QCDateFm          char(10)    => 조회일자FROM                             */
/*                @ps_QCDateTo          char(10)    => 조회일자TO                               */
/*	Notes		: 수입검사 불량율 현황중 업체별 WORST 10의 자료를 조회한다(그래프).             */
/*	Made Date	: 2002. 09. 12                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq131i_01_graph') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq131i_01_graph
GO
/*
Exec sp_pisq131i_01_graph
		@ps_AreaCode        = 'D'               ,
		@ps_DivisionCode    = 'H'               ,
        @ps_QCDateFm        = '2002.01.01'      ,
        @ps_QCDateTo        = '2002.12.31'
*/


/****** Object:  Stored Procedure dbo.sp_pisq131i_01_graph    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq131i_01_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
        @ps_QCDateFm          char(10)      ,   -- 조회일자FROM
        @ps_QCDateTo          char(10)          -- 조회일자TO
AS

BEGIN

	SELECT TOP 10
		   A.AREACODE                 AS AS_AREACODE	    ,
		   A.SUPPLIERCODE             AS AS_SUPPLIERCODE    ,
           B.SUPPLIERKORNAME          AS AS_SUPPLIERKORNAME ,   
		   sum(A.SUPPLIERDELIVERYQTY) AS AS_IN			    ,
		   sum(A.BADQTY)              AS AS_BAD		    	,
		   (cast(SUM(A.BADQTY) as float) / cast(sum(A.SUPPLIERDELIVERYQTY) as float)) * 100 AS AS_RATE
	  FROM TQQCRESULT    A,
           TMSTSUPPLIER  B
     WHERE A.SUPPLIERCODE  *= B.SUPPLIERCODE 
       AND A.AREACODE      =  @ps_AreaCode
       AND A.DIVISIONCODE  =  @ps_DivisionCode
       AND A.QCDATE        >= @ps_QCDateFm
       AND A.QCDATE        <= @ps_QCDateTo
	   AND A.BADQTY			> 0
     GROUP BY A.AREACODE, A.SUPPLIERCODE, B.SUPPLIERKORNAME
     ORDER BY AS_RATE DESC , A.SUPPLIERCODE
    
END 

go
