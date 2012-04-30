/*
	File Name	: sp_eisc_select_customer.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_eisc_select_customer
	Description	: 거래처 코드 DDDW을 위한 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: EIS
	Use Program	: 
	Parameter	: @ps_empno, @ps_areacode
	Use Table	: tmstarea
	Initial		: 2002. 12. 05
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eisc_select_customer]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisc_select_customer]
GO

/*
Execute sp_eisc_select_customer 'D'

select * from tmstcustomer


Select	LTrim(RTrim(A.custname))
From	tmstcustomer	A
Where	A.EMP_NO	= 'IPIS'

update	tmstcustomer
Set	custcode = LTrim(RTrim(custcode))
*/

Create Procedure sp_eisc_select_customer
	@ps_custgubun		char(1)

As
Begin

Select	CustCode	= A.CustCode,
	CustName	= A.CustName,
	CustShortName	= A.CustShortName,
	CustGubun	= A.CustGubun,
	DisplayName	= A.CustName + '(' + A.CustCode + ')'
From	tmstcustomer	A
Where	A.CustGubun	= @ps_custgubun
Group By A.CustCode, A.CustName, A.CustShortName, A.CustGubun

Return

End		-- Procedure End

Go