/*
	File Name	: sp_pisc_select_productgroup.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_select_productgroup
	Description	: ��ǰ�� �ڵ� DDDW�� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_productgroup
	Use Table	: tmstproductgroup
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_productgroup]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_productgroup]
GO

/*
Execute sp_pisc_select_productgroup 'J', '%', '%'
select * from tmstproductgroup

*/

Create Procedure sp_pisc_select_productgroup
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1),		-- ����
	@ps_productgroup	varchar(2)	-- ��ǰ��
	
As
Begin

Select	DivisionCode		= A.DivisionCode,
	DivisionName		= B.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,
	DisplayName		= A.ProductGroupName + '(' + A.DivisionCode + A.ProductGroup + ')'
From	tmstproductgroup		A,
	tmstdivision		B
Where	A.AreaCode		= @ps_areacode		And
	A.DivisionCode		Like @ps_divisioncode	And
	A.ProductGroup		Like @ps_productgroup	And
	A.AreaCode		= B.AreaCode		And
	A.DivisionCode		= B.DivisionCode
Group By A.AreaCode, A.DivisionCode, B.DivisionName, A.ProductGroup, A.ProductGroupName

Return

End		-- Procedure End
Go
