/************************************************************************************************/
/*	File Name	: sp_pisq410i_01.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰ��)                                                            */
/*	Description	: RRPPM ����(����, ���庰)                                                      */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TQRRPPMCLAIMFAULT																*/
/*				  TMSTDIVISION																	*/   
/*				  TMSTCUSTOMER																	*/   
/*				  TMSTPRODUCTGROUP																*/
/*  Parameter   : @ps_AreaCode          char(01)    => ��������                                 */
/*                @ps_divisioncode      char(01)    => �����ڵ�                                 */
/*                @ps_customer          char(06)    => ��                                     */
/*                @ps_RaiseDateFm       char(07)    => �߻���FROM                               */
/*                @ps_RaiseDateTo       char(07)    => �߻���TO                                 */
/*	Notes		: RRPPM ������ ȭ�鿡 ǥ���Ѵ�                                                  */
/*	Made Date	: 2002. 10. 03                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq410i_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq410i_01
GO
/*
Exec sp_pisq410i_01
		@ps_AreaCode        = 'D' ,
		@ps_DivisionCode    = '%' ,
		@ps_customer        = '%' ,
		@ps_RaiseDateFm     = '2002.01',
		@ps_RaiseDateTo     = '2002.12'

*/


/****** Object:  Stored Procedure dbo.sp_pisq410i_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq410i_01
        @ps_AreaCode          char(01)      ,   -- ��������
        @ps_DivisionCode      char(01)      ,   -- �����ڵ�
		@ps_customer          varchar(06)   ,   -- ��
		@ps_RaiseDateFm       char(07)      ,   -- �߻���FROM
		@ps_RaiseDateTo       char(07)          -- �߻���TO
AS

BEGIN

	SELECT	A.DIVISIONCODE,   
			B.DIVISIONNAME,   
			A.CUSTOMERCODE,   
			C.CUSTNAME,   
			A.PRODUCTGROUP,   
			D.PRODUCTGROUPNAME,   
			A.FAULTQTY,   
			A.FAULTSTATUS  
	  FROM	TQRRPPMCLAIMFAULT	A,
			TMSTDIVISION		B,   
			TMSTCUSTOMER		C,   
			TMSTPRODUCTGROUP	D 
	 WHERE	A.AREACODE		= 		B.AREACODE
	   AND  A.DIVISIONCODE	=		B.DIVISIONCODE
	   AND  A.CUSTOMERCODE  =		C.CUSTCODE
	   AND  A.AREACODE		= 		D.AREACODE
	   AND  A.DIVISIONCODE	=		D.DIVISIONCODE
	   AND  A.PRODUCTGROUP  =		D.PRODUCTGROUP
	   AND  A.AREACODE		=		@ps_AreaCode
	   AND  A.DIVISIONCODE	LIKE	@ps_DivisionCode
	   AND  A.RAISEDATE		>=		@ps_RaiseDateFm
	   AND  A.RAISEDATE		<=		@ps_RaiseDateTo
	   AND  A.CUSTOMERCODE	LIKE	@ps_customer
	 ORDER  BY	A.DIVISIONCODE,   
				A.CUSTOMERCODE,   
				A.PRODUCTGROUP

END 

go
