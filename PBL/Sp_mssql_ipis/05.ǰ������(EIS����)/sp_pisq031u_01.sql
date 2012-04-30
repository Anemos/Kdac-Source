/************************************************************************************************/
/*	File Name	: sp_pisq031u_01.SQL                                                            */
/*	SYSTEM		: ǰ������(��ǰǰ��)                                                            */
/*	Description	: ������ ���ÿ� ��ȸ                                                            */
/*	Supply		: DAEWOO Information Systems Co., LTD IAS Dept                                  */
/*	Use DataBase: IPIS2000                                                                      */
/*	Use Table	: TMSTEMP                                                                       */
/*  Parameter   : @ps_empno             varchar(06)    => ���                                  */
/*	Notes		: �˻���ؼ� ������ ���ÿ� ��� �ڷḦ ��ȸ�Ѵ�.                                */
/*	Made Date	: 2002. 09. 04                                                                  */
/*	Author		: �������-������                                                               */
/************************************************************************************************/
if exists (select * from sysobjects where id = object_id('dbo.sp_pisq031u_01') and sysstat & 0xf = 4)
	drop procedure dbo.sp_pisq031u_01
GO
/*
Exec sp_pisq031u_01
		@ps_areacode        = 'D'       ,
		@ps_divisioncode    = '%
*/


/****** Object:  Stored Procedure dbo.sp_pisq031u_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq031u_01
        @ps_areacode          char(01)      ,   -- ��������
        @ps_divisioncode      char(01)      ,   -- �����ڵ�

AS

BEGIN

	SELECT	A.AREACODE,   
			A.DIVISIONCODE,   
			A.EMPNO,   
			B.EMPNAME,   
			C.CODENAME,
			A.CONSERTFLAG,   
			A.JOBGUBUN
	  FROM	TQCONSERTEMP	A,
			TMSTEMP			B,
			TMSTCODE		C
	 WHERE	A.EMPNO			  = B.EMPNO
	   AND	C.CODEGROUP		  = 'OJIKCHEK'
	   AND	B.EmpJikchek	 *= C.CODEID			
	   AND	A.AREACODE		  = @ps_areacode
	   AND	A.DIVISIONCODE LIKE @ps_divisioncode
	   AND	A.CONSERTFLAG	  = '1'   

END 

go
