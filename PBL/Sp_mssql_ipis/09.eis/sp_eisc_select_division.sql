/*
	File Name	: sp_eisc_select_division.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_eisc_select_division
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
	    Where id = object_id(N'[dbo].[sp_eisc_select_division]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisc_select_division]
GO

/*
Execute sp_eisc_select_division '%', '%', '%'
*/


Create Procedure sp_eisc_select_division
	@ps_empcode		varchar(6),	-- ���
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1)		-- ����
	
As
Begin

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
	A.DivisionCode	Like @ps_divisioncode	And
	A.AreaCode	= B.AreaCode
Group By A.AreaCode, B.AreaName, A.DivisionCode, A.DivisionName, A.DivisionNameEng, B.SortOrder, A.SortOrder, A.ServerName
Order By B.SortOrder, A.SortOrder


Return

End		-- Procedure End
Go
