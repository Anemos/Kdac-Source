/*
	File Name	: sp_pisc_select_division.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_select_division
	Description	: ���� �ڵ� DDDW�� ���� ��ȸ
			  ����� ���� ������ �ִ� ���常 ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_empno, @ps_areacode, @ps_divisioncode
	Use Table	: tmstarea
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_division]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_division]
GO

/*
Execute sp_pisc_select_division 'admin', 'J', '%'
*/


Create Procedure sp_pisc_select_division
	@ps_empno		varchar(6),	-- ���
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1)		-- ����
	
As
Begin

Declare	@ls_plantcode	char(1),		-- ���� ��� ����
	@ls_divisioncode	char(1)		-- ����

Select	@ls_plantcode	= LTrim(RTrim(A.AUTPLNT)),
	@ls_divisioncode	= LTrim(RTrim(A.AUTDIV))
From	tmstpassword	A
Where	A.EMP_NO	= @ps_empno

If @ls_plantcode is null Or @ls_plantcode = '' Or @ls_plantcode = ' ' Or Len(@ls_plantcode) = 0
Begin
	Select	@ls_plantcode = '%'
End

If @ls_divisioncode is null Or @ls_divisioncode = '' Or @ls_divisioncode = ' ' Or Len(@ls_divisioncode) = 0
Begin
	Select	@ls_divisioncode = '%'
End

Select	AreaCode	= A.AreaCode,
	AreaName	= B.AreaName,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,
	DivisionNameEng	= A.DivisionNameEng,
	ServerName	= A.ServerName,
	DisplayName	= A.DivisionName + '(' + A.AreaCode + A.DivisionCode + ')'
From	tmstdivision	A,
	tmstarea		B
Where	A.AreaCode	Like @ps_areacode		And
	A.DivisionGubun	Like @ls_plantcode	And
	A.DivisionCode	Like @ls_divisioncode	And
	A.AreaCode	= B.AreaCode
Group By A.AreaCode, B.AreaName, A.DivisionCode, A.DivisionName, A.DivisionNameEng, B.SortOrder, A.SortOrder, A.ServerName
Order By B.SortOrder, A.SortOrder


Return

End		-- Procedure End
Go
