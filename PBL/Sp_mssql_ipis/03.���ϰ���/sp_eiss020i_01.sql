/*
	File Name	: sp_eiss020i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_eiss020i_01
	Description	: ��� ��ȹ �� ���� (���庰)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: 
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eiss020i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eiss020i_01]
GO

/*
Execute sp_eiss020i_01 '2002.12', 'D', 'V'

select * from tmstarea


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

Create Procedure sp_eiss020i_01
	@ps_prd1		char(7),
	@ps_prdmonth		char(7),
	@ps_areacode		char(1),
	@ps_divisioncode	char(1)

As
Begin

Declare	@ls_prdyear	char(4)

Select	@ls_prdyear	= Left(@ps_prdmonth, 4)

Create Table #tmp_prd
(	AreaCode	char(1),
	DivisionCode	char(1),
	ItemCode	varchar(12),

	PlanQty01		int,
	ChangeQty01		int,
	PrdQty01		int,
	PlanCost01		float,
	ChangeCost01		float,
	PrdCost01		float,

	PlanQty02		int,
	ChangeQty02		int,
	PrdQty02		int,
	PlanCost02		float,
	ChangeCost02		float,
	PrdCost02		float
)

-- ��� ���� ��ȹ
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(IsNull(A.PlanInQty, 0) + IsNull(A.PlanOutQty, 0)),
	ChangeQty01		= 0,
	PrdQty01		= 0,
	PlanCost01		= Sum(IsNull(A.PlanInCost, 0) + IsNull(A.PlanOutCost, 0)),
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,

	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0
From	tshipplanyear	A
Where	A.PlanMonth	= @ps_prdmonth		And
	A.AreaCode	= @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- ���� ���� ��ȹ
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,

	PlanQty02		= Sum(IsNull(A.PlanInQty, 0) + IsNull(A.PlanOutQty, 0)),
	ChangeQty02		= 0,
	PrdQty02		= 0,
	PlanCost02		= Sum(IsNull(A.PlanInCost, 0) + IsNull(A.PlanOutCost, 0)),
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0
From	tshipplanyear	A
Where	A.PlanMonth	>= @ps_prd1		And
	A.PlanMonth	<= @ps_prdmonth		And
	A.AreaCode	= @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- ��� � ��ȹ
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= Sum(IsNull(A.PlanInQty, 0) + IsNull(A.PlanOutQty, 0)),
	PrdQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= Sum(IsNull(A.PlanInCost, 0) + IsNull(A.PlanOutCost, 0)),
	PrdCost01		= 0.0,

	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0
From	tshipplanmonth	A
Where	A.PlanMonth	= @ps_prdmonth		And
	A.AreaCode	= @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- ���� � ��ȹ
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,

	PlanQty02		= 0,
	ChangeQty02		= Sum(IsNull(A.PlanInQty, 0) + IsNull(A.PlanOutQty, 0)),
	PrdQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= Sum(IsNull(A.PlanInCost, 0) + IsNull(A.PlanOutCost, 0)),
	PrdCost02		= 0.0
From	tshipplanmonth	A
Where	A.PlanMonth	>= @ps_prd1		And
	A.PlanMonth	<= @ps_prdmonth		And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode
Group By A.AreaCode, A.DivisionCode, A.ItemCode


-- ��� ����
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= Sum(IsNull(A.ShipQty, 0)),
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= Sum(IsNull(A.ShipQty, 0)) * 1.0,

	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0
From	tlotno		A
Where	A.TraceDate	Like @ps_prdmonth + '.__'	And
	A.AreaCode	= @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- ���� ����
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,

	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= Sum(IsNull(A.ShipQty, 0)),
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= Sum(IsNull(A.ShipQty, 0)) * 1.0
From	tlotno		A
Where	A.TraceDate	>= @ps_prd1 + '.01'	And
	A.TraceDate	<= @ps_prdmonth	 + '.31'	And
	A.AreaCode	= @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- ��ǰ���� Sum ����
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(A.PlanQty01),
	ChangeQty01		= Sum(A.ChangeQty01),
	PrdQty01		= Sum(A.PrdQty01),
	PlanCost01		= Sum(A.PlanCost01),
	ChangeCost01		= Sum(A.ChangeCost01),
	PrdCost01		= Sum(A.PrdCost01) * IsNull(B.UnitCost, 0),

	PlanQty02		= Sum(A.PlanQty02),
	ChangeQty02		= Sum(A.ChangeQty02),
	PrdQty02		= Sum(A.PrdQty02),
	PlanCost02		= Sum(A.PlanCost02),
	ChangeCost02		= Sum(A.ChangeCost02),
	PrdCost02		= Sum(A.PrdCost02) * IsNull(B.UnitCost, 0)
Into	#tmp_item
From	#tmp_prd	A,
	(Select	AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode,
		UnitCost		= A.UnitCost
	From	tmstitemcosthis	A
	Where	A.ApplyMonth	= @ps_prdmonth		And
		A.AreaCode	= @ps_areacode	And
		A.DivisionCode	Like @ps_divisioncode
	Group By A.AreaCode, A.DivisionCode, A.ItemCode, A.UnitCost)	B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.DivisionCode, A.ItemCode, B.UnitCost

-- ������ ���� ProductGroup �� �ƴ϶�
-- ModelGroup ���� ó���� �ؾ��Ѵ�.
If Exists(	Select	AreaCode	= A.AreaCode
	From	#tmp_item	A
	Where	A.AreaCode	= 'D'
	And	A.DivisionCode	= 'V')
Begin
	-- �ϴ� ���� �����͸� ��������
	Select	AreaCode		= A.AreaCode,
		DivisionCode		= A.DivisionCode,
		ItemCode		= A.ItemCode,
		PlanQty01		= Sum(A.PlanQty01),
		ChangeQty01		= Sum(A.ChangeQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Sum(A.PlanCost01),
		ChangeCost01		= Sum(A.ChangeCost01),
		PrdCost01		= Sum(A.PrdCost01),
	
		PlanQty02		= Sum(A.PlanQty02),
		ChangeQty02		= Sum(A.ChangeQty02),
		PrdQty02		= Sum(A.PrdQty02),
		PlanCost02		= Sum(A.PlanCost02),
		ChangeCost02		= Sum(A.ChangeCost02),
		PrdCost02		= Sum(A.PrdCost02)
	Into	#tmp_item_hvac
	From	#tmp_item	A
	Where	A.AreaCode	= 'D'
	And	A.DivisionCode	= 'V'
	Group By A.AreaCode, A.DivisionCode, A.ItemCode

	-- #tmp_item ���� ���� �����͸� ��������
	Delete	#tmp_item
	From	#tmp_item	A,
		#tmp_item_hvac	B
	Where	A.AreaCode	= B.AreaCode
	And	A.DivisionCode	= B.DivisionCode
	And	A.ItemCode	= B.ItemCode

	-- ������ �����Ƿ� ProductGroup / ModelGroup ���� Sum ����
	-- ModelGroup���� Sum ����
	Select	AreaCode		= A.AreaCode,
		SortOrder		= B.SortOrder,
		DivisionCode		= A.DivisionCode,
		DivisionName		= B.DivisionName,
		ProductGroup		= B.ProductGroup,		-- ��ǰ��
		ProductGroupName	= B.ProductGroupName,		-- ��ǰ����
		PlanQty01		= Sum(A.PlanQty01),
		ChangeQty01		= Sum(A.ChangeQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Sum(A.PlanCost01),
		ChangeCost01		= Sum(A.ChangeCost01),
		PrdCost01		= Sum(A.PrdCost01),
	
		PlanQty02		= Sum(A.PlanQty02),
		ChangeQty02		= Sum(A.ChangeQty02),
		PrdQty02		= Sum(A.PrdQty02),
		PlanCost02		= Sum(A.PlanCost02),
		ChangeCost02		= Sum(A.ChangeCost02),
		PrdCost02		= Sum(A.PrdCost02)
	Into	#tmp_result
	From	#tmp_item_hvac	A,
		(
		Select	AreaCode		= A.AreaCode,			-- �����ڵ�
			SortOrder		= C.SortOrder,
			DivisionCode		= A.DivisionCode,			-- �����ڵ�
			DivisionName		= C.DivisionName,		-- �����
			ProductGroup		= B.ModelGroup,			-- ��ǰ��
			ProductGroupName	= B.ModelGroupName,		-- ��ǰ����
			ItemCode		= A.ItemCode
		From	tmstmodel	A,
			tmstmodelgroup	B,
			tmstdivision	C
		 Where	A.AreaCode		= @ps_areacode		And
			A.DivisionCode		Like @ps_divisioncode	And
			A.AreaCode		= B.AreaCode		And
			A.AreaCode		= C.AreaCode		And
			A.DivisionCode		= B.DivisionCode		And
			A.DivisionCode		= C.DivisionCode		And
			A.ModelGroup		= B.ModelGroup
		Group By A.AreaCode, C.SortOrder, A.DivisionCode, C.DivisionName,
			B.ModelGroup, B.ModelGroupName, A.ItemCode
		)	B			
	Where	A.AreaCode	= B.AreaCode
	And	A.DivisionCode	= B.DivisionCode
	And	A.ItemCode	= B.ItemCode
	Group By A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName

	-- ProductGroup���� Sum ����
	Insert	#tmp_result
	Select	AreaCode		= A.AreaCode,
		SortOrder		= B.SortOrder,
		DivisionCode		= A.DivisionCode,
		DivisionName		= B.DivisionName,
		ProductGroup		= B.ProductGroup,		-- ��ǰ��
		ProductGroupName	= B.ProductGroupName,		-- ��ǰ����
		PlanQty01		= Sum(A.PlanQty01),
		ChangeQty01		= Sum(A.ChangeQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Sum(A.PlanCost01),
		ChangeCost01		= Sum(A.ChangeCost01),
		PrdCost01		= Sum(A.PrdCost01),
	
		PlanQty02		= Sum(A.PlanQty02),
		ChangeQty02		= Sum(A.ChangeQty02),
		PrdQty02		= Sum(A.PrdQty02),
		PlanCost02		= Sum(A.PlanCost02),
		ChangeCost02		= Sum(A.ChangeCost02),
		PrdCost02		= Sum(A.PrdCost02)
	From	#tmp_item	A,
		(
		Select	AreaCode		= A.AreaCode,			-- �����ڵ�
			SortOrder		= C.SortOrder,
			DivisionCode		= A.DivisionCode,			-- �����ڵ�
			DivisionName		= C.DivisionName,		-- �����
			ProductGroup		= B.ProductGroup,		-- ��ǰ��
			ProductGroupName	= B.ProductGroupName,		-- ��ǰ����
			ItemCode		= A.ItemCode
		From	tmstmodel	A,
			tmstproductgroup	B,
			tmstdivision	C
		 Where	A.AreaCode		= @ps_areacode		And
			A.DivisionCode		Like @ps_divisioncode	And
			A.AreaCode		= B.AreaCode		And
			A.AreaCode		= C.AreaCode		And
			A.DivisionCode		= B.DivisionCode		And
			A.DivisionCode		= C.DivisionCode		And
			A.ProductGroup		= B.ProductGroup
		Group By A.AreaCode, C.SortOrder, A.DivisionCode, C.DivisionName,
			B.ProductGroup, B.ProductGroupName, A.ItemCode
		)	B			
	Where	A.AreaCode	= B.AreaCode
	And	A.DivisionCode	= B.DivisionCode
	And	A.ItemCode	= B.ItemCode
	Group By A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName

	-- ���� ����� ������
	Select	AreaCode		= A.AreaCode,
		DivisionCode		= A.DivisionCode,
		DivisionName		= A.DivisionName,
		ProductGroup		= A.ProductGroup,		-- ��ǰ��
		ProductGroupName	= A.ProductGroupName,		-- ��ǰ����
		PlanQty01		= Sum(A.PlanQty01),
		ChangeQty01		= Sum(A.ChangeQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Ceiling(Sum(A.PlanCost01) / 1000000),
		ChangeCost01		= Ceiling(Sum(A.ChangeCost01) / 1000000),
		PrdCost01		= Ceiling(Sum(A.PrdCost01) / 1000000),
	
		PlanQty02		= Sum(A.PlanQty02),
		ChangeQty02		= Sum(A.ChangeQty02),
		PrdQty02		= Sum(A.PrdQty02),
		PlanCost02		= Ceiling(Sum(A.PlanCost02) / 1000000),
		ChangeCost02		= Ceiling(Sum(A.ChangeCost02) / 1000000),
		PrdCost02		= Ceiling(Sum(A.PrdCost02) / 1000000)
	From	#tmp_result	A
	Group By A.AreaCode, A.SortOrder, A.DivisionCode, A.DivisionName,
		A.ProductGroup, A.ProductGroupName
	Order By A.AreaCode, A.SortOrder

	Drop Table #tmp_item_hvac
	Drop Table #tmp_result
End
Else
Begin
	-- ProductGroup���� Sum ����
	Select	AreaCode		= A.AreaCode,
		DivisionCode		= A.DivisionCode,
		DivisionName		= B.DivisionName,
		ProductGroup		= B.ProductGroup,		-- ��ǰ��
		ProductGroupName	= B.ProductGroupName,		-- ��ǰ����
		PlanQty01		= Sum(A.PlanQty01),
		ChangeQty01		= Sum(A.ChangeQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Ceiling(Sum(A.PlanCost01) / 1000000),
		ChangeCost01		= Ceiling(Sum(A.ChangeCost01) / 1000000),
		PrdCost01		= Ceiling(Sum(A.PrdCost01) / 1000000),
	
		PlanQty02		= Sum(A.PlanQty02),
		ChangeQty02		= Sum(A.ChangeQty02),
		PrdQty02		= Sum(A.PrdQty02),
		PlanCost02		= Ceiling(Sum(A.PlanCost02) / 1000000),
		ChangeCost02		= Ceiling(Sum(A.ChangeCost02) / 1000000),
		PrdCost02		= Ceiling(Sum(A.PrdCost02) / 1000000)
	From	#tmp_item	A,
		(
		Select	AreaCode		= A.AreaCode,			-- �����ڵ�
			SortOrder		= C.SortOrder,
			DivisionCode		= A.DivisionCode,			-- �����ڵ�
			DivisionName		= C.DivisionName,		-- �����
			ProductGroup		= B.ProductGroup,		-- ��ǰ��
			ProductGroupName	= B.ProductGroupName,		-- ��ǰ����
			ItemCode		= A.ItemCode
		From	tmstmodel	A,
			tmstproductgroup	B,
			tmstdivision	C
		 Where	A.AreaCode		= @ps_areacode		And
			A.DivisionCode		Like @ps_divisioncode	And
			A.AreaCode		= B.AreaCode		And
			A.AreaCode		= C.AreaCode		And
			A.DivisionCode		= B.DivisionCode		And
			A.DivisionCode		= C.DivisionCode		And
			A.ProductGroup		= B.ProductGroup
		Group By A.AreaCode, C.SortOrder, A.DivisionCode, C.DivisionName,
			B.ProductGroup, B.ProductGroupName, A.ItemCode
		)	B			
	Where	A.AreaCode	= B.AreaCode
	And	A.DivisionCode	= B.DivisionCode
	And	A.ItemCode	= B.ItemCode
	Group By A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName
	Order By A.AreaCode, B.SortOrder
End

Drop Table #tmp_prd
Drop Table #tmp_item

Return

End		-- Procedure End

Go