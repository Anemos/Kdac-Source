/************************************************************************************************/
/*	File Name	: sp_pisq440i_01_graph.SQL                                                      */
/*	SYSTEM		: 품질관리(고객품질)                                                            */
/*	Description	: RRPPM율 추이그래프															*/
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQRRPPMCLAIMQTY																*/
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_customer          char(06)    => 고객                                     */
/*                @ps_RaiseDate       	char(10)    => 발생월	                                */
/*	Notes		: RRPPM율 추이그래프를 화면에 표시한다                                    		*/
/*	Made Date	: 2002. 10. 03                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq440i_01_graph') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq440i_01_graph
GO
/*
Exec sp_pisq440i_01_graph
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_customer        = '%' ,
		@ps_RaiseDate       = '2002.12.01'

*/


/****** Object:  Stored Procedure dbo.sp_pisq440i_01_graph    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq440i_01_graph
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_customer          varchar(06)   ,   -- 고객
		@ps_RaiseDate         char(10)          -- 발생월

AS

BEGIN


	SELECT	A.RAISEDATE AS AS_RAISEDATE,
		    CASE WHEN isnull(SUM(A.SHIPQTY ), 0) = 0 
		    	 THEN 0 
		         ELSE ISNULL(SUM(A.CLAIMQTY) / (CAST(SUM(A.SHIPQTY ) AS FLOAT)) * 1000000, 0) END AS AS_RATE
	  FROM	TQRRPPMCLAIMQTY	A
	 WHERE	A.AREACODE		=		@ps_AreaCode
	   AND	A.DIVISIONCODE	=		@ps_DivisionCode
	   AND	A.RAISEDATE		>=		CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102)
	   AND	A.RAISEDATE		<=		SUBSTRING(@ps_RaiseDate, 1, 7)
       AND	A.CUSTOMERCODE	LIKE	@ps_customer
  	  GROUP BY	A.RAISEDATE
   
END 

go
