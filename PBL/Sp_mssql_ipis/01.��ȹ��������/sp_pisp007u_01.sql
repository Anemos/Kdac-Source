/*
	File Name	: sp_pisp007u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp007u_01
	Description	: �ڵ� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_codegroup, @ps_codeid
	Use Table	: tmstworkcenter
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp007u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp007u_01]
GO

/*
Execute sp_pisp007u_01 'PUNOBSERVE', '%'
select * from tmstline

*/


Create Procedure sp_pisp007u_01
	@ps_codegroup		varchar(10),	-- �ڵ� �׷�
	@ps_codeid		varchar(10)	-- �ڵ� ������
	
As
Begin


Select	CodeGroup		= A.CodeGroup,
	CodeGroupName		= A.CodeGroupName,
	CodeID			= A.CodeID,
	CodeName		= A.CodeName,
	CodeRef01		= A.CodeRef01,
	CodeRef02		= A.CodeRef02,
	CodeRef03		= A.CodeRef03
  From	tmstcode	A
 Where	A.CodeGroup	Like @ps_codegroup	And
	A.CodeID	Like @ps_codeid
Group By A.CodeGroup, A.CodeGroupName, A.CodeID, A.CodeName, A.CodeRef01, A.CodeRef02, A.CodeRef03

Return

End		-- Procedure End
Go
