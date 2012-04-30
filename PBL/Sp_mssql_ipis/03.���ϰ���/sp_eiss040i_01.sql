/*
	File Name	: sp_eiss040i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_eiss040i_01
	Description	: �������Ͻ���(���庰)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: 
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eiss040i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eiss040i_01]
GO

/*
Execute sp_eiss040i_01 '2002', 'D', '%'

select * from tmstarea


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

Create Procedure sp_eiss040i_01
	@ps_prdyear		char(4),
	@ps_areacode		char(1),
	@ps_divisioncode	char(1)

As
Begin

Create Table #tmp_prd
(	PlanMonth	char(7),
	AreaCode	char(1),
	DivisionCode	char(1),
	ItemCode	varchar(12),

	PlanQty01		int,
	PrdQty01		int,
	PlanCost01		float,
	PrdCost01		float,
)

Create Table #tmp_qty
(	PlanMonth		char(7),
	AreaCode		char(1),
	SortOrder		int,
	DivisionCode		char(1),
	DivisionName		varchar(100),
	ProductGroup		varchar(5),
	ProductGroupName	varchar(100),
	PlanQty01		int,
	PrdQty01		int,
	PlanCost01		float,
	PrdCost01		float,
)

-- ���� ��ȹ
Insert	#tmp_prd
Select	PlanMonth		= A.PlanMonth,
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(IsNull(A.PlanInQty, 0) + IsNull(A.PlanOutQty, 0)),
	PrdQty01		= 0,
	PlanCost01		= Sum(IsNull(A.PlanInCost, 0) + IsNull(A.PlanOutCost, 0)),
	PrdCost01		= 0.0
From	tshipplanyear	A
Where	A.PlanMonth	Like @ps_prdyear + '.__'	And
	A.AreaCode	Like @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode
Group By A.PlanMonth, A.AreaCode, A.DivisionCode, A.ItemCode

-- ����
Insert	#tmp_prd
Select	PlanMonth		= Left(A.TraceDate, 7),
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	PrdQty01		= Sum(IsNull(A.ShipQty, 0)),
	PlanCost01		= 0.0,
	PrdCost01		= Sum(IsNull(A.ShipQty, 0)) * 1.0
From	tlotno		A
Where	A.TraceDate	Like @ps_prdyear	 + '.__.__'	And
	A.AreaCode	Like @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode
Group By A.TraceDate, A.AreaCode, A.DivisionCode, A.ItemCode

-- ��ǰ���� Sum ����
Select	PlanMonth		= A.PlanMonth,
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(A.PlanQty01),
	PrdQty01		= Sum(A.PrdQty01),
	PlanCost01		= Sum(A.PlanCost01),
	PrdCost01		= Sum(A.PrdCost01) * IsNull(B.UnitCost, 0)
Into	#tmp_item
From	#tmp_prd	A,
	(Select	ApplyMonth	= A.ApplyMonth,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode,
		UnitCost		= A.UnitCost
	From	tmstitemcosthis	A
	Where	A.AreaCode	Like @ps_areacode
	Group By A.ApplyMonth, A.AreaCode, A.DivisionCode, A.ItemCode, A.UnitCost)	B
Where	A.PlanMonth	*= B.ApplyMonth		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.PlanMonth, A.AreaCode, A.DivisionCode, A.ItemCode, B.UnitCost

-- ������ ���� ProductGroup �� �ƴ϶�
-- ModelGroup ���� ó���� �ؾ��Ѵ�.
If Exists(	Select	AreaCode	= A.AreaCode
	From	#tmp_item	A
	Where	A.AreaCode	= 'D'
	And	A.DivisionCode	= 'V')
Begin
	-- �ϴ� ���� �����͸� ��������
	Select	PlanMonth		= A.PlanMonth,
		AreaCode		= A.AreaCode,
		DivisionCode		= A.DivisionCode,
		ItemCode		= A.ItemCode,
		PlanQty01		= Sum(A.PlanQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Sum(A.PlanCost01),
		PrdCost01		= Sum(A.PrdCost01)
	Into	#tmp_item_hvac
	From	#tmp_item	A
	Where	A.AreaCode	= 'D'
	And	A.DivisionCode	= 'V'
	Group By A.PlanMonth, A.AreaCode, A.DivisionCode, A.ItemCode

	-- #tmp_item ���� ���� �����͸� ��������
	Delete	#tmp_item
	From	#tmp_item	A,
		#tmp_item_hvac	B
	Where	A.PlanMonth	= B.PlanMonth
	And	A.AreaCode	= B.AreaCode
	And	A.DivisionCode	= B.DivisionCode
	And	A.ItemCode	= B.ItemCode

	-- ������ �����Ƿ� ProductGroup / ModelGroup ���� Sum ����
	-- ModelGroup���� Sum ����
	Select	PlanMonth		= A.PlanMonth,
		AreaCode		= A.AreaCode,
		SortOrder		= B.SortOrder,
		DivisionCode		= A.DivisionCode,
		DivisionName		= B.DivisionName,
		ProductGroup		= B.ProductGroup,		-- ��ǰ��
		ProductGroupName	= B.ProductGroupName,		-- ��ǰ����
		PlanQty01		= Sum(A.PlanQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Sum(A.PlanCost01),
		PrdCost01		= Sum(A.PrdCost01)
	Into	#tmp_item_sub
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
	Group By A.PlanMonth, A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName

	-- ProductGroup���� Sum ����
	Insert	#tmp_item_sub
	Select	PlanMonth		= A.PlanMonth,
		AreaCode		= A.AreaCode,
		SortOrder		= B.SortOrder,
		DivisionCode		= A.DivisionCode,
		DivisionName		= B.DivisionName,
		ProductGroup		= B.ProductGroup,		-- ��ǰ��
		ProductGroupName	= B.ProductGroupName,		-- ��ǰ����
		PlanQty01		= Sum(A.PlanQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Sum(A.PlanCost01),
		PrdCost01		= Sum(A.PrdCost01)
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
	Group By A.PlanMonth, A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName

	-- ���� ����� ������
	Insert	#tmp_qty
	Select	PlanMonth		= A.PlanMonth,
		AreaCode		= A.AreaCode,
		SortOrder		= A.SortOrder,
		DivisionCode		= A.DivisionCode,
		DivisionName		= A.DivisionName,
		ProductGroup		= A.ProductGroup,		-- ��ǰ��
		ProductGroupName	= A.ProductGroupName,		-- ��ǰ����
		PlanQty01		= Sum(A.PlanQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Ceiling(Sum(A.PlanCost01) / 1000000),
		PrdCost01		= Ceiling(Sum(A.PrdCost01) / 1000000)
	From	#tmp_item_sub	A
	Group By A.PlanMonth, A.AreaCode, A.SortOrder, A.DivisionCode, A.DivisionName,
		A.ProductGroup, A.ProductGroupName

	Drop Table #tmp_item_hvac
	Drop Table #tmp_item_sub
End
Else
Begin
	-- ProductGroup���� Sum ����
	Insert	#tmp_qty
	Select	PlanMonth		= A.PlanMonth,
		AreaCode		= A.AreaCode,
		SortOrder		= B.SortOrder,
		DivisionCode		= A.DivisionCode,
		DivisionName		= B.DivisionName,
		ProductGroup		= B.ProductGroup,		-- ��ǰ��
		ProductGroupName	= B.ProductGroupName,		-- ��ǰ����
		PlanQty01		= Sum(A.PlanQty01),
		PrdQty01		= Sum(A.PrdQty01),
		PlanCost01		= Ceiling(Sum(A.PlanCost01) / 1000000),
		PrdCost01		= Ceiling(Sum(A.PrdCost01) / 1000000)
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
	Group By A.PlanMonth, A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName
End

-- ���� ������ ó������
Select	AreaCode	= A.AreaCode,
	SortOrder	= A.SortOrder,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,
	PlanCost01	= Sum(Case When A.PlanMonth like @ps_prdyear + '.01'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost02	= Sum(Case When A.PlanMonth like @ps_prdyear + '.02'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost03	= Sum(Case When A.PlanMonth like @ps_prdyear + '.03'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost04	= Sum(Case When A.PlanMonth like @ps_prdyear + '.04'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost05	= Sum(Case When A.PlanMonth like @ps_prdyear + '.05'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost06	= Sum(Case When A.PlanMonth like @ps_prdyear + '.06'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost07	= Sum(Case When A.PlanMonth like @ps_prdyear + '.07'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost08	= Sum(Case When A.PlanMonth like @ps_prdyear + '.08'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost09	= Sum(Case When A.PlanMonth like @ps_prdyear + '.09'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost10	= Sum(Case When A.PlanMonth like @ps_prdyear + '.10'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost11	= Sum(Case When A.PlanMonth like @ps_prdyear + '.11'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost12	= Sum(Case When A.PlanMonth like @ps_prdyear + '.12'  Then IsNull(A.PlanCost01, 0) Else 0 End),

	PrdCost01	= Sum(Case When A.PlanMonth like @ps_prdyear + '.01'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost02	= Sum(Case When A.PlanMonth like @ps_prdyear + '.02'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost03	= Sum(Case When A.PlanMonth like @ps_prdyear + '.03'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost04	= Sum(Case When A.PlanMonth like @ps_prdyear + '.04'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost05	= Sum(Case When A.PlanMonth like @ps_prdyear + '.05'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost06	= Sum(Case When A.PlanMonth like @ps_prdyear + '.06'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost07	= Sum(Case When A.PlanMonth like @ps_prdyear + '.07'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost08	= Sum(Case When A.PlanMonth like @ps_prdyear + '.08'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost09	= Sum(Case When A.PlanMonth like @ps_prdyear + '.09'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost10	= Sum(Case When A.PlanMonth like @ps_prdyear + '.10'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost11	= Sum(Case When A.PlanMonth like @ps_prdyear + '.11'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost12	= Sum(Case When A.PlanMonth like @ps_prdyear + '.12'  Then IsNull(A.PrdCost01, 0) Else 0 End)
Into	#tmp_result
From	#tmp_qty		A
Group By A.AreaCode, A.SortOrder, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName

-- ���� ����� ������
Select	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,

	PlanCost	= Sum(A.PlanCost01) + Sum(A.PlanCost02) + Sum(A.PlanCost03) + Sum(A.PlanCost04) +
				Sum(A.PlanCost05) + Sum(A.PlanCost06) + Sum(A.PlanCost07) + Sum(A.PlanCost08) +
				Sum(A.PlanCost09) + Sum(A.PlanCost10) + Sum(A.PlanCost11) + Sum(A.PlanCost12),
	PlanCost01	= Sum(A.PlanCost01),
	PlanCost02	= Sum(A.PlanCost02),
	PlanCost03	= Sum(A.PlanCost03),
	PlanCost04	= Sum(A.PlanCost04),
	PlanCost05	= Sum(A.PlanCost05),
	PlanCost06	= Sum(A.PlanCost06),
	PlanCost07	= Sum(A.PlanCost07),
	PlanCost08	= Sum(A.PlanCost08),
	PlanCost09	= Sum(A.PlanCost09),
	PlanCost10	= Sum(A.PlanCost10),
	PlanCost11	= Sum(A.PlanCost11),
	PlanCost12	= Sum(A.PlanCost12),

	PrdCost		= Sum(A.PrdCost01) + Sum(A.PrdCost02) + Sum(A.PrdCost03) + Sum(A.PrdCost04) +
				Sum(A.PrdCost05) + Sum(A.PrdCost06) + Sum(A.PrdCost07) + Sum(A.PrdCost08) +
				Sum(A.PrdCost09) + Sum(A.PrdCost10) + Sum(A.PrdCost11) + Sum(A.PrdCost12),
	PrdCost01	= Sum(A.PrdCost01),
	PrdCost02	= Sum(A.PrdCost02),
	PrdCost03	= Sum(A.PrdCost03),
	PrdCost04	= Sum(A.PrdCost04),
	PrdCost05	= Sum(A.PrdCost05),
	PrdCost06	= Sum(A.PrdCost06),
	PrdCost07	= Sum(A.PrdCost07),
	PrdCost08	= Sum(A.PrdCost08),
	PrdCost09	= Sum(A.PrdCost09),
	PrdCost10	= Sum(A.PrdCost10),
	PrdCost11	= Sum(A.PrdCost11),
	PrdCost12	= Sum(A.PrdCost12)
From	#tmp_result	A
Group By A.AreaCode, A.SortOrder, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName
Order By A.AreaCode, A.SortOrder, A.DivisionCode


Drop Table #tmp_prd
Drop Table #tmp_item
Drop Table #tmp_qty
Drop Table #tmp_result

Return

End		-- Procedure End

Go