/*
	File Name	: sp_pisp002u_03.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp002u_03
	Description	: ���� �����ȹ ��� - ��ȹ�й����� ���� ��ǰ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 10
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp002u_03]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp002u_03]
GO


/*
Execute sp_pisp002u_03
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%',
	@ps_itemcode		= '%'

select * from tmstmodelgroup

*/


Create Procedure sp_pisp002u_03
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1),		-- ����
	@ps_productgroup	varchar(2),	-- ��ǰ��
	@ps_modelgroup		varchar(3),	-- �𵨱�
	@ps_itemcode		varchar(12)	-- ǰ��
	
As
Begin

Select	AreaCode		= A.AreaCode,			-- �����ڵ�
	DivisionCode		= A.DivisionCode,			-- �����ڵ�
	ItemCode		= A.ItemCode
  From	vmstkb_line	A,
	tmstmodel	B
 Where	B.AreaCode		= @ps_areacode		And
	B.DivisionCode		= @ps_divisioncode	And
	B.ProductGroup		Like @ps_productgroup	And
	B.ModelGroup		Like @ps_modelgroup	And
	B.ItemCode		Like @ps_itemcode	And
	B.AreaCode		= A.AreaCode		And
	B.DivisionCode		= A.DivisionCode		And
	B.ItemCode		= A.ItemCode		And
	A.PrdStopGubun		= 'N'
Group By A.AreaCode, A.DivisionCode, A.ItemCode
Order By A.AreaCode, A.DivisionCode, A.ItemCode

Return

End		-- Procedure End
Go
