/************************************************************************************************/
/*	File Name	: sp_eisq130i_01.SQL                                                            */
/*	SYSTEM		: 경영자용 통합정보	                                                            */
/*	Description	: 월간 RRPPM 추이(전사)															*/
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQRRPPMCLAIMQTY																*/
/*				  TMSTCUSTOMER																	*/   
/*				  TMSTPRODUCTGROUP																*/
/*  Parameter   : @ps_customer          char(06)    => 고객                                     */
/*                @ps_RaiseDate       	char(10)    => 발생일	                                */
/*	Notes		: 월간 RRPPM 추이를 표시한다                                  					*/
/*	Made Date	: 2002. 12. 12                                                                  */
/*	Author		: 대우정보-유종희                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq130i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq130i_01
GO
/*
Exec sp_eisq130i_01
		@ps_customer        = '%' ,
		@ps_RaiseDate       = '2002.12.31'

*/


/****** Object:  Stored Procedure dbo.sp_eisq130i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq130i_01
		@ps_customer          varchar(06)   ,   -- 고객
		@ps_RaiseDate         char(10)          -- 발생일

AS

BEGIN

	SELECT	A.AREACODE,
			D.AREANAME,
			A.DIVISIONCODE,
			E.DIVISIONNAME,
			A.CUSTOMERCODE,
			B.CUSTNAME,   
-- 출하수량
			-- 전년실적
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -23, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -12, @ps_RaiseDate), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS S_00,
			-- 월별실적
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_01,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -10, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_02,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -09, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_03,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -08, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_04,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -07, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_05,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -06, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_06,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -05, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_07,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -04, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_08,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -03, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_09,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -02, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_10,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -01, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_11,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.SHIPQTY ELSE 0 END), 0) AS S_12,
			-- 누계
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS S_13,
-- RRPPM
			-- 전년실적
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -23, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -12, @ps_RaiseDate), 102) THEN A.CLAIMQTY ELSE 0 END), 0) AS C_00,
			-- 월별실적
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_01,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -10, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_02,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -09, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_03,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -08, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_04,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -07, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_05,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -06, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_06,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -05, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_07,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -04, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_08,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -03, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_09,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -02, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_10,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -01, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_11,
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) = A.RAISEDATE THEN A.CLAIMQTY ELSE 0 END), 0) AS C_12,
			-- 누계
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) THEN A.CLAIMQTY ELSE 0 END), 0) AS C_13,
			-- 목표
			isnull(AVG(F.QTYYEARGOAL), 0)		AS M_YEARGOAL
	  FROM	TQRRPPMCLAIMQTY		A,
			TMSTCUSTOMER		B,   
			TMSTAREA			D,
			TMSTDIVISION		E,
			TQRRPPMGOALREJECT   F
	 WHERE	A.CUSTOMERCODE	=		B.CUSTCODE
	   AND	A.AREACODE		= 		D.AREACODE
	   AND	A.AREACODE		= 		E.AREACODE
	   AND	A.DIVISIONCODE	=		E.DIVISIONCODE
	   AND	A.AREACODE		*= 		F.AREACODE
	   AND	A.DIVISIONCODE	*=		F.DIVISIONCODE
	   AND	F.STANDARDYEAR	 =		SUBSTRING(@ps_RaiseDate, 1, 4)
	   AND	A.CUSTOMERCODE	*=		F.CUSTOMERCODE
	   AND	F.PRODUCTGROUP	 =		'ZZ'
	   AND	A.RAISEDATE		>=		CONVERT(CHAR(07), DATEADD(month, -23, @ps_RaiseDate), 102)
	   AND	A.RAISEDATE		<=		SUBSTRING(@ps_RaiseDate, 1, 7)
       AND	A.CUSTOMERCODE	LIKE	@ps_customer
  	  GROUP BY	A.AREACODE,
				D.AREANAME,
				A.DIVISIONCODE,
				E.DIVISIONNAME,
				A.CUSTOMERCODE	,
				B.CUSTNAME		,
	  			E.SORTORDER
	  ORDER BY	A.AREACODE,
	  			E.SORTORDER,
				A.CUSTOMERCODE	
END 

go
