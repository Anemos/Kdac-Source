/*
	File Name	: sp_eiss050i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_eiss050i_01
	Description	: �Ϻ����Ͻ���(���庰)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: 
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eiss050i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eiss050i_01]
GO

/*
Execute sp_eiss050i_01 '2002.12', 'J', '%'

select * from tmstarea


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'

*/

Create Procedure sp_eiss050i_01
	@ps_prdmonth		char(7),
	@ps_areacode		char(1),
	@ps_divisioncode	char(1)

As
Begin

Create Table #tmp_prd
(	PlanDate	char(10),
	AreaCode	char(1),
	DivisionCode	char(1),
	ItemCode	varchar(12),

	PlanQty01	int,
	PrdQty01	int,
	PlanCost01	float,
	PrdCost01	float,
)

Create Table #tmp_qty
(	PlanDate		char(10),
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


-- �鸸 ������ ������ �Կ� ����..
-- �ϴ����� �ݾ��� ���� ����ϰ�, �� ������ ���� �ݾ��� ���̰� ����....
-- ����, ���⼭�� ���� �������� Sum �� ������ ó���ϱ� ���� �ƹ� �ʿ䵵 ����
-- #tmp_item_sub �� ������ �Ѵ�..
Create Table #tmp_item_sub
(	PlanDate		char(10),
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


-- �����ȹ ����
Insert	#tmp_prd
Select	Plandate                = @ps_prdmonth + '.00',
        AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(IsNull(A.PlanInQty, 0) + IsNull(A.PlanOutQty, 0)),
	PrdQty01		= 0,
	PlanCost01		= Sum(IsNull(A.PlanInCost, 0) + IsNull(A.PlanOutCost, 0)),
	PrdCost01		= 0.0
From	tshipplanmonth	A
Where	A.Planmonth	= @ps_prdmonth 	And
	A.AreaCode	Like @ps_areacode and
        a.divisioncode  Like @ps_divisioncode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- ����
Insert	#tmp_prd
Select	PlanDate		= A.TraceDate,
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	PrdQty01		= Sum(IsNull(A.ShipQty, 0)),
	PlanCost01		= 0.0,
	PrdCost01		= Sum(IsNull(A.ShipQty, 0)) * 1.0
From	tlotno		A
Where	A.TraceDate	Like @ps_prdmonth + '.__'		And
	A.AreaCode	Like @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode
Group By A.TraceDate, A.AreaCode, A.DivisionCode, A.ItemCode

-- ��ǰ���� Sum ����
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(A.PlanQty01),
	PrdQty01		= Sum(A.PrdQty01),
	PlanCost01		= Sum(A.PlanCost01),
	PrdCost01		= Sum(A.PrdCost01) * IsNull(B.UnitCost, 0)
Into	#tmp_item
From	#tmp_prd	A,
	(Select	AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode,
		UnitCost		= A.UnitCost
	From	tmstitemcosthis	A
	Where	A.ApplyMonth	= @ps_prdmonth		And
		A.AreaCode	Like @ps_areacode
	Group By A.AreaCode, A.DivisionCode, A.ItemCode, A.UnitCost)	B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.ItemCode, B.UnitCost

-- ������ ���� ProductGroup �� �ƴ϶�
-- ModelGroup ���� ó���� �ؾ��Ѵ�.
If Exists(	Select	AreaCode	= A.AreaCode
	From	#tmp_item	A
	Where	A.AreaCode	= 'D'
	And	A.DivisionCode	= 'V')
Begin
	-- �ϴ� ���� �����͸� ��������
	Select	PlanDate		= A.PlanDate,
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
	Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.ItemCode

	-- #tmp_item ���� ���� �����͸� ��������
	Delete	#tmp_item
	From	#tmp_item	A,
		#tmp_item_hvac	B
	Where	A.PlanDate	= B.PlanDate
	And	A.AreaCode	= B.AreaCode
	And	A.DivisionCode	= B.DivisionCode
	And	A.ItemCode	= B.ItemCode

	-- ������ �����Ƿ� ProductGroup / ModelGroup ���� Sum ����
	-- ModelGroup���� Sum ����
	Insert	#tmp_item_sub
	Select	PlanDate		= A.PlanDate,
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
	Group By A.PlanDate, A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName

	-- ProductGroup���� Sum ����
	Insert	#tmp_item_sub
	Select	PlanDate		= A.PlanDate,
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
	Group By A.PlanDate, A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName

	-- ���� ����� ������
	Insert	#tmp_qty
	Select	PlanDate		= A.PlanDate,
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
	Group By A.PlanDate, A.AreaCode, A.SortOrder, A.DivisionCode, A.DivisionName,
		A.ProductGroup, A.ProductGroupName

	Drop Table #tmp_item_hvac
End
Else
Begin
	-- ProductGroup���� Sum ����
	Insert	#tmp_item_sub
	Select	PlanDate		= A.PlanDate,
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
	Group By A.PlanDate, A.AreaCode, B.SortOrder, A.DivisionCode, B.DivisionName,
		B.ProductGroup, B.ProductGroupName

	-- ProductGroup���� Sum ����
	Insert	#tmp_qty
	Select	PlanDate		= A.PlanDate,
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
	Group By A.PlanDate, A.AreaCode, A.SortOrder, A.DivisionCode, A.DivisionName,
		A.ProductGroup, A.ProductGroupName
End

-- ���� ������ ó������
Select	AreaCode	= A.AreaCode,
	SortOrder	= A.SortOrder,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,

	PlanCost	= Sum(A.PlanCost01),
	PrdCost		= Sum(A.PrdCost01),

	PrdCost01	= Sum(Case When A.PlanDate like @ps_prdmonth + '.01'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost02	= Sum(Case When A.PlanDate like @ps_prdmonth + '.02'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost03	= Sum(Case When A.PlanDate like @ps_prdmonth + '.03'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost04	= Sum(Case When A.PlanDate like @ps_prdmonth + '.04'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost05	= Sum(Case When A.PlanDate like @ps_prdmonth + '.05'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost06	= Sum(Case When A.PlanDate like @ps_prdmonth + '.06'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost07	= Sum(Case When A.PlanDate like @ps_prdmonth + '.07'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost08	= Sum(Case When A.PlanDate like @ps_prdmonth + '.08'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost09	= Sum(Case When A.PlanDate like @ps_prdmonth + '.09'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost10	= Sum(Case When A.PlanDate like @ps_prdmonth + '.10'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost11	= Sum(Case When A.PlanDate like @ps_prdmonth + '.11'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost12	= Sum(Case When A.PlanDate like @ps_prdmonth + '.12'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost13	= Sum(Case When A.PlanDate like @ps_prdmonth + '.13'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost14	= Sum(Case When A.PlanDate like @ps_prdmonth + '.14'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost15	= Sum(Case When A.PlanDate like @ps_prdmonth + '.15'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost16	= Sum(Case When A.PlanDate like @ps_prdmonth + '.16'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost17	= Sum(Case When A.PlanDate like @ps_prdmonth + '.17'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost18	= Sum(Case When A.PlanDate like @ps_prdmonth + '.18'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost19	= Sum(Case When A.PlanDate like @ps_prdmonth + '.19'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost20	= Sum(Case When A.PlanDate like @ps_prdmonth + '.20'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost21	= Sum(Case When A.PlanDate like @ps_prdmonth + '.21'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost22	= Sum(Case When A.PlanDate like @ps_prdmonth + '.22'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost23	= Sum(Case When A.PlanDate like @ps_prdmonth + '.23'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost24	= Sum(Case When A.PlanDate like @ps_prdmonth + '.24'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost25	= Sum(Case When A.PlanDate like @ps_prdmonth + '.25'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost26	= Sum(Case When A.PlanDate like @ps_prdmonth + '.26'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost27	= Sum(Case When A.PlanDate like @ps_prdmonth + '.27'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost28	= Sum(Case When A.PlanDate like @ps_prdmonth + '.28'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost29	= Sum(Case When A.PlanDate like @ps_prdmonth + '.29'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost30	= Sum(Case When A.PlanDate like @ps_prdmonth + '.30'  Then IsNull(A.PrdCost01, 0) Else 0 End),
	PrdCost31	= Sum(Case When A.PlanDate like @ps_prdmonth + '.31'  Then IsNull(A.PrdCost01, 0) Else 0 End)
Into	#tmp_result
From	#tmp_qty		A
Group By A.AreaCode, A.SortOrder, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName

-- ���� ����� ������
-- �鸸 ������ ������ �Կ� ����..
-- �ϴ����� �ݾ��� ���� ����ϰ�, �� ������ ���� �ݾ��� ���̰� ����....
-- ����, ���⼭�� ���� �������� Sum �� ������ ó��...
Select	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,

--	PlanCost	= Sum(A.PlanCost01) + Sum(A.PlanCost02) + Sum(A.PlanCost03) + Sum(A.PlanCost04) +
--				Sum(A.PlanCost05) + Sum(A.PlanCost06) + Sum(A.PlanCost07) + Sum(A.PlanCost08) +
--				Sum(A.PlanCost09) + Sum(A.PlanCost10) + Sum(A.PlanCost11) + Sum(A.PlanCost12) + 
--				Sum(A.PlanCost13) + Sum(A.PlanCost14) + Sum(A.PlanCost15) + Sum(A.PlanCost16) +
--				Sum(A.PlanCost17) + Sum(A.PlanCost18) + Sum(A.PlanCost19) + Sum(A.PlanCost20) + 
--				Sum(A.PlanCost21) + Sum(A.PlanCost22) + Sum(A.PlanCost23) + Sum(A.PlanCost24) +
--				Sum(A.PlanCost25) + Sum(A.PlanCost26) + Sum(A.PlanCost27) + Sum(A.PlanCost28) + 
--				Sum(A.PlanCost29) + Sum(A.PlanCost30) + Sum(A.PlanCost31),
	PlanCost	= Sum(B.PlanCost),


--	PrdCost		= Sum(A.PrdCost01) + Sum(A.PrdCost02) + Sum(A.PrdCost03) + Sum(A.PrdCost04) +
--				Sum(A.PrdCost05) + Sum(A.PrdCost06) + Sum(A.PrdCost07) + Sum(A.PrdCost08) +
--				Sum(A.PrdCost09) + Sum(A.PrdCost10) + Sum(A.PrdCost11) + Sum(A.PrdCost12) +
--				Sum(A.PrdCost13) + Sum(A.PrdCost14) + Sum(A.PrdCost15) + Sum(A.PrdCost16) +
--				Sum(A.PrdCost17) + Sum(A.PrdCost18) + Sum(A.PrdCost19) + Sum(A.PrdCost20) + 
--				Sum(A.PrdCost21) + Sum(A.PrdCost22) + Sum(A.PrdCost23) + Sum(A.PrdCost24) +
--				Sum(A.PrdCost25) + Sum(A.PrdCost26) + Sum(A.PrdCost27) + Sum(A.PrdCost28) + 
--				Sum(A.PrdCost29) + Sum(A.PrdCost30) + Sum(A.PrdCost31),
	PrdCost		= Sum(B.PrdCost),

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
	PrdCost12	= Sum(A.PrdCost12),
	PrdCost13	= Sum(A.PrdCost13),
	PrdCost14	= Sum(A.PrdCost14),
	PrdCost15	= Sum(A.PrdCost15),
	PrdCost16	= Sum(A.PrdCost16),
	PrdCost17	= Sum(A.PrdCost17),
	PrdCost18	= Sum(A.PrdCost18),
	PrdCost19	= Sum(A.PrdCost19),
	PrdCost20	= Sum(A.PrdCost20),
	PrdCost21	= Sum(A.PrdCost21),
	PrdCost22	= Sum(A.PrdCost22),
	PrdCost23	= Sum(A.PrdCost23),
	PrdCost24	= Sum(A.PrdCost24),
	PrdCost25	= Sum(A.PrdCost25),
	PrdCost26	= Sum(A.PrdCost26),
	PrdCost27	= Sum(A.PrdCost27),
	PrdCost28	= Sum(A.PrdCost28),
	PrdCost29	= Sum(A.PrdCost29),
	PrdCost30	= Sum(A.PrdCost30),
	PrdCost31	= Sum(A.PrdCost31)
From	#tmp_result	A,
	(Select	AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ProductGroup	= A.ProductGroup,
		PlanCost	= Ceiling(Sum(A.PlanCost01) / 1000000),
		PrdCost		= Ceiling(Sum(A.PrdCost01) / 1000000)
	From	#tmp_item_sub	A
	Group By A.AreaCode, A.DivisionCode, A.ProductGroup)	B
Where	A.AreaCode	*= B.AreaCode
And	A.DivisionCode	*= B.DivisionCode
And	A.ProductGroup	*= B.ProductGroup
Group By A.AreaCode, A.SortOrder, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName
Order By A.AreaCode, A.SortOrder, A.DivisionCode


Drop Table #tmp_prd
Drop Table #tmp_item
Drop Table #tmp_item_sub
Drop Table #tmp_qty
Drop Table #tmp_result

Return

End		-- Procedure End

Go