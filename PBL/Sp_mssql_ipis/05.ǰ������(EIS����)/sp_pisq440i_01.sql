/************************************************************************************************/
/*	File Name	: sp_pisq440i_01.SQL                                                            */
/*	SYSTEM		: 품질관리(고객품질)                                                            */
/*	Description	: RRPPM율 추이그래프															*/
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQRRPPMCLAIMQTY																*/
/*				  TMSTCUSTOMER																	*/   
/*				  TMSTPRODUCTGROUP																*/
/*  Parameter   : @ps_AreaCode          char(01)    => 지역구분                                 */
/*                @ps_divisioncode      char(01)    => 공장코드                                 */
/*                @ps_customer          char(06)    => 고객                                     */
/*                @ps_RaiseDate       	char(10)    => 발생월	                                */
/*	Notes		: RRPPM율 추이그래프를 화면에 표시한다                                      		*/
/*	Made Date	: 2002. 10. 03                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq440i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq440i_01
GO
/*
Exec sp_pisq440i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_customer        = '%' ,
		@ps_RaiseDate       = '2002.01.01'

*/


/****** Object:  Stored Procedure dbo.sp_pisq440i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq440i_01
        @ps_AreaCode          char(01)      ,   -- 지역구분
        @ps_DivisionCode      char(01)      ,   -- 공장코드
		@ps_customer          varchar(06)   ,   -- 고객
		@ps_RaiseDate         char(10)          -- 발생월

AS

BEGIN

	SELECT	A.CUSTOMERCODE,
			B.CUSTNAME,   
         	A.PRODUCTGROUP,   
			C.PRODUCTGROUPNAME,   
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S11,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -10, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S10,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -09, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S09,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -08, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S08,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -07, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S07,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -06, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S06,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -05, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S05,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -04, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S04,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -03, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S03,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -02, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S02,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -01, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S01,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS M_S00,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_STOT,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C11,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -10, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C10,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -09, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C09,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -08, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C08,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -07, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C07,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -06, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C06,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -05, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C05,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -04, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C04,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -03, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C03,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -02, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C02,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -01, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C01,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS M_C00,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) THEN A.CLAIMQTY ELSE 0 END), 0) AS M_CTOT
	  FROM	TQRRPPMCLAIMQTY		A,
			TMSTCUSTOMER		B,   
			TMSTPRODUCTGROUP	C 
	 WHERE	A.CUSTOMERCODE	=		B.CUSTCODE
	   AND	A.AREACODE		= 		C.AREACODE
	   AND	A.DIVISIONCODE	=		C.DIVISIONCODE
	   AND	A.PRODUCTGROUP	=		C.PRODUCTGROUP
	   AND	A.AREACODE		=		@ps_AreaCode
	   AND	A.DIVISIONCODE	=		@ps_DivisionCode
	   AND	A.RAISEDATE		>=		CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102)
	   AND	A.RAISEDATE		<=		SUBSTRING(@ps_RaiseDate, 1, 7)
       AND	A.CUSTOMERCODE	LIKE	@ps_customer
  	  GROUP BY	A.CUSTOMERCODE	,
				B.CUSTNAME		,   
				A.PRODUCTGROUP	,   
				C.PRODUCTGROUPNAME
	 ORDER BY	A.CUSTOMERCODE	,
				A.PRODUCTGROUP
   
END 

go
