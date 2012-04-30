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
		@ps_empno = '1'
*/


/****** Object:  Stored Procedure dbo.sp_pisq031u_01    Script Date: 02-09-01  ******/
CREATE PROCEDURE sp_pisq031u_01
         @ps_empno           varchar(06)       -- ���

AS

BEGIN

	SELECT TMSTEMP.EmpNo,   
         TMSTEMP.EmpName,   
         TMSTEMP.EmpNameEng,   
         TMSTEMP.DeptCode,   
         TMSTEMP.EmpGubun,   
         TMSTEMP.EmpJikchek,   
		 B.CODENAME,
         TMSTEMP.EmpClass,   
         TMSTEMP.EmpExtd,   
         TMSTEMP.ChangeEmp,   
         TMSTEMP.ChangeDate,   
         TMSTEMP.RetireGubun,   
         TMSTEMP.EmpBonbu,   
         TMSTEMP.EmpIntDept,   
         TMSTEMP.EmpLevel,   
         TMSTEMP.EmpEnterDate,   
         TMSTEMP.EmpClassDate,   
         TMSTEMP.EmpBirthDate,   
         TMSTEMP.LastEmp,   
         TMSTEMP.LastDate  
    FROM TMSTEMP ,
		 TMSTCODE B
   WHERE B.CODEGROUP		 = 'OJIKCHEK'
	 AND TMSTEMP.EmpJikchek	*= B.CODEID AND TMSTEMP.RetireGubun = 'N'
	 AND SUBSTRING(TMSTEMP.DeptCode, 1, 2)	 = (SELECT SUBSTRING(A.DeptCode, 1, 2)
						    	  FROM TMSTEMP A
								 WHERE A.EmpNo = @ps_empno)

END 

go
