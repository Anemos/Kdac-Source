/*
	File Name	: sp_pisc_select_area.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_select_area
	Description	: ���� �ڵ� DDDW�� ���� ��ȸ
			  ����� ���� ������ �ִ� ������ ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_empno, @ps_areacode
	Use Table	: tmstarea
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_area]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_area]
GO

/*
Execute sp_pisc_select_area '896106', '%'

select * from tmstarea


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

Create Procedure sp_pisc_select_area
	@ps_empno		varchar(6),	-- ���
	@ps_areacode		char(1)		-- ����

As
Begin

Declare	@ls_areacode	char(1)

Select	@ls_areacode	= LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= @ps_empno

If @ls_areacode = '' Or @ls_areacode = ' ' Or Len(@ls_areacode) = 0 Or @ls_areacode is null
Begin
	Select	@ls_areacode = '%'
End


Select	AreaCode	= A.AreaCode,
	AreaName	= A.AreaName,
	DisplayName	= A.AreaName + '(' + A.AreaCode + ')'
From	tmstarea		A
Where	A.AreaCode	Like @ls_areacode
Group By A.AreaCode, A.AreaName, A.SortOrder
Order By A.SortOrder

Return

End		-- Procedure End

Go