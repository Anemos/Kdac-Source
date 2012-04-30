/*
	File Name	: sp_pisc_select_modelgroup.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_select_modelgroup
	Description	: �𵨱� �ڵ� DDDW�� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_productgroup, @ps_modelgroup
	Use Table	: tmstmodelgroup
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_modelgroup]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_modelgroup]
GO


/*
Execute sp_pisc_select_modelgroup 'J', '%', '%', '%'
select * from tmstmodelgroup

*/

Create Procedure sp_pisc_select_modelgroup
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1),		-- ����
	@ps_productgroup	varchar(2),		-- ��ǰ��
	@ps_modelgroup		varchar(3)		-- �𵨱�
	
As
Begin

Select	ProductGroup		= A.ProductGroup,
	ProductGroupName	= B.ProductGroupName,
	ModelGroup		= A.ModelGroup,
	ModelGroupName	= A.ModelGroupName,
	DisplayName		= A.ModelGroupName + '(' + A.ProductGroup + A.ModelGroup + ')'
From	tmstmodelgroup		A,
	tmstproductgroup		B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.ProductGroup	Like @ps_productgroup	And
	A.ModelGroup	Like @ps_modelgroup	And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.ProductGroup	= B.ProductGroup
Group By A.AreaCode, A.DivisionCode, A.ProductGroup, B.ProductGroupName, A.ModelGroup, A.ModelGroupName



Return

End		-- Procedure End
Go
