/************************************************************************************************/
/*	File Name	: sp_eisq140i_01.SQL                                                            */
/*	SYSTEM		: �濵�ڿ� ��������	                                                            */
/*	Description	: ���� ��ǰ�� RRPPM��Ȳ(���庰)													*/
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQRRPPMCLAIMQTY																*/
/*				  TMSTCUSTOMER																	*/   
/*				  TMSTPRODUCTGROUP																*/
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(01)    => �����ڵ�                                 */
/*                @ps_customer          char(06)    => ��                                     */
/*                @ps_RaiseDate       	char(10)    => �߻���	                                */
/*	Notes		: ���� ��ǰ�� RRPPM��Ȳ�� ȭ�鿡 ǥ���Ѵ�                                  		*/
/*	Made Date	: 2002. 12. 12                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_eisq140i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_eisq140i_01
GO
/*
Exec sp_eisq140i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = 'A' ,
		@ps_customer        = '%' ,
		@ps_RaiseDate       = '2002.12.31'

*/


/****** Object:  Stored Procedure dbo.sp_eisq140i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_eisq140i_01
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
		@ps_customer          varchar(06)   ,   -- ��
		@ps_RaiseDate         char(10)          -- �߻���

AS

BEGIN

	SELECT	A.AREACODE,
			D.AREANAME,
			A.DIVISIONCODE,
			E.DIVISIONNAME,
			A.CUSTOMERCODE,
			B.CUSTNAME,   
         	A.PRODUCTGROUP,   
			C.PRODUCTGROUPNAME,   
			-- �������
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -23, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -12, @ps_RaiseDate), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_BSTOT,
			-- ��������
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
			-- ����
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) THEN A.SHIPQTY ELSE 0 END), 0) AS M_STOT,
			-- �������
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -23, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -12, @ps_RaiseDate), 102) THEN A.CLAIMQTY ELSE 0 END), 0) AS M_BCTOT,
			-- ��������
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
			-- ����
			isnull(SUM(CASE WHEN CONVERT(CHAR(07), DATEADD(month, -11, @ps_RaiseDate), 102) <= A.RAISEDATE AND A.RAISEDATE <= CONVERT(CHAR(07), DATEADD(month, -00, @ps_RaiseDate), 102) THEN A.CLAIMQTY ELSE 0 END), 0) AS M_CTOT,
			-- ��ǥ
			isnull(AVG(F.QTYYEARGOAL), 0)		AS M_YEARGOAL
	  FROM	TQRRPPMCLAIMQTY		A,
			TMSTCUSTOMER		B,   
			TMSTPRODUCTGROUP	C,
			TMSTAREA			D,
			TMSTDIVISION		E,
			TQRRPPMGOALREJECT   F
	 WHERE	A.CUSTOMERCODE	=		B.CUSTCODE
	   AND	A.AREACODE		= 		C.AREACODE
	   AND	A.DIVISIONCODE	=		C.DIVISIONCODE
	   AND	A.PRODUCTGROUP	=		C.PRODUCTGROUP
	   AND	A.AREACODE		= 		D.AREACODE
	   AND	A.AREACODE		= 		E.AREACODE
	   AND	A.DIVISIONCODE	=		E.DIVISIONCODE

	   AND	A.AREACODE		*= 		F.AREACODE
	   AND	A.DIVISIONCODE	*=		F.DIVISIONCODE
	   AND	F.STANDARDYEAR	=		SUBSTRING(@ps_RaiseDate, 1, 4)
	   AND	A.CUSTOMERCODE	*=		F.CUSTOMERCODE
	   AND	A.PRODUCTGROUP	*=		F.PRODUCTGROUP

	   AND	A.AREACODE		=		@ps_AreaCode
	   AND	A.DIVISIONCODE	=		@ps_DivisionCode
	   AND	A.RAISEDATE		>=		CONVERT(CHAR(07), DATEADD(month, -23, @ps_RaiseDate), 102)
	   AND	A.RAISEDATE		<=		SUBSTRING(@ps_RaiseDate, 1, 7)
       AND	A.CUSTOMERCODE	LIKE	@ps_customer
  	  GROUP BY	A.AREACODE,
				D.AREANAME,
				A.DIVISIONCODE,
				E.DIVISIONNAME,
				A.CUSTOMERCODE	,
				B.CUSTNAME		,   
				A.PRODUCTGROUP	,   
				C.PRODUCTGROUPNAME
	  ORDER BY	A.AREACODE,
				A.DIVISIONCODE,
				A.CUSTOMERCODE	,
				A.PRODUCTGROUP
END 

go
