/*
	File Name	: sp_eisc_select_custgubun.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_eisc_select_custgubun
	Description	: �ŷ�ó ���� �ڵ� DDDW�� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: EIS
	Use Program	: 
	Parameter	: @ps_empno, @ps_areacode
	Use Table	: tmstarea
	Initial		: 2002. 12. 05
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eisc_select_custgubun]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisc_select_custgubun]
GO

/*
Execute sp_eisc_select_custgubun

select * from tmstcode
*/

Create Procedure sp_eisc_select_custgubun

As
Begin

Select	CodeID		= A.CodeID,
	CodeName	= A.CodeName,
	DisplayName	= A.CodeName + '(' + A.CodeID + ')'
From	tmstcode		A
Where	A.CodeGroup	Like 'SCUSTGUBUN'
Group By A.CodeID, A.CodeName

Return

End		-- Procedure End

Go