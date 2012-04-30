/*
	File Name	: sp_pisp052i_01.SQL
	SYSTEM		: KDAC ÅëÇÕ »ý»ê Á¤º¸ ½Ã½ºÅÛ
	Procedure Name	: sp_pisp052i_01
	Description	: DDRS ÇöÈ²
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp052i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp052i_01]
GO

/*
Execute sp_pisp052i_01
	@ps_todate		= '2002.10.30',
	@ps_plandate01		= '2002.11.01',
	@ps_plandate02		= '2002.11.02',
	@ps_plandate03		= '2002.11.03',
	@ps_plandate04		= '2002.11.04',
	@ps_plandate05		= '2002.11.05',
	@ps_plandate06		= '2002.11.06',
	@ps_plandate07		= '2002.11.07',
	@ps_plandate08		= '2002.11.08',
	@ps_plandate09		= '2002.11.09',
	@ps_plandate10		= '2002.11.10',
	@ps_plandate11		= '2002.11.11',
	@ps_plandate12		= '2002.11.12',
	@ps_plandate13		= '2002.11.13',
	@ps_plandate14		= '2002.11.14',
	@ps_plandate15		= '2002.11.15',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%'
*/

Create Procedure sp_pisp052i_01
	@ps_todate		char(10),
	@ps_plandate01		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate02		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate03		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate04		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate05		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate06		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate07		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate08		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate09		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate10		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate11		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate12		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate13		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate14		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_plandate15		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')

	@ps_areacode		Char(1),		-- Áö¿ª ÄÚµå
	@ps_divisioncode	Char(1),		-- °øÀå ÄÚµå
	@ps_productgroup	varchar(2),	-- Á¦Ç°±º
	@ps_modelgroup		varchar(3)	-- ¸ðµ¨±º
As
Begin

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,
	ModelGroup		= A.ModelGroup,
	ModelGroupName	= A.ModelGroupName,
	SortOrder		= 0,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '°èÈ¹»ý»ê'
					When A.ProductGubun = 'R'	Then 'ÈÄº¸Ãæ»ý»ê'
					Else 'OEM»ý»ê'
				   End
Into	#tmp_item
From	vmstkb_model	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.ProductGroup	Like @ps_productgroup	And
	A.ModelGroup	Like @ps_modelgroup
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName,
	A.ModelGroup, A.ModelGroupName, --A.SortOrder,
	A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun


Select	PlanDate		= B.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,
	ModelGroup		= A.ModelGroup,
	ModelGroupName	= A.ModelGroupName,
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	ChangeQty		= Sum(IsNull(B.PlanQty, 0))
Into	#tmp_qty
From	#tmp_item	A,
	tplanddrs	B
Where	(B.PlanDate	Between @ps_plandate01 and @ps_plandate15)	And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.ItemCode	= B.ItemCode
Group By B.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName,
	A.ModelGroup, A.ModelGroupName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName
/*
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,
	ModelGroup		= A.ModelGroup,
	ModelGroupName	= A.ModelGroupName,
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	PlanQty			= Sum(IsNull(A.PlanQty, 0)),
	ChangeQty		= Sum(IsNull(A.ChangeQty, 0))
Into	#tmp_planqty
From	#tmp_qty		A
Group By A.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName,
	A.ModelGroup, A.ModelGroupName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName
*/

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,
	ModelGroup		= A.ModelGroup,
	ModelGroupName	= A.ModelGroupName,
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	ChangeQty01		= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty02		= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty03		= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty04		= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty05		= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty06		= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty07		= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty08		= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty09		= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty10		= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty11		= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty12		= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty13		= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty14		= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty15		= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.ChangeQty, 0) Else 0 End
Into	#tmp_result
--From	#tmp_planqty	A
From	#tmp_qty		A
Where	A.ChangeQty	> 0

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	ProductGroup		= A.ProductGroup,
	ProductGroupName	= A.ProductGroupName,
	ModelGroup		= A.ModelGroup,
	ModelGroupName	= A.ModelGroupName,
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	ChangeQtySum		= Sum(A.ChangeQty01) +  Sum(A.ChangeQty02) + Sum(A.ChangeQty03) +
				Sum(A.ChangeQty04) +  Sum(A.ChangeQty05) + Sum(A.ChangeQty06) +
				Sum(A.ChangeQty07) +  Sum(A.ChangeQty08) + Sum(A.ChangeQty09) +
				Sum(A.ChangeQty10) +  Sum(A.ChangeQty11) + Sum(A.ChangeQty12) +
				Sum(A.ChangeQty13) +  Sum(A.ChangeQty14) + Sum(A.ChangeQty15),
	ChangeQty01		= Sum(A.ChangeQty01),
	ChangeQty02		= Sum(A.ChangeQty02),
	ChangeQty03		= Sum(A.ChangeQty03),
	ChangeQty04		= Sum(A.ChangeQty04),
	ChangeQty05		= Sum(A.ChangeQty05),
	ChangeQty06		= Sum(A.ChangeQty06),
	ChangeQty07		= Sum(A.ChangeQty07),
	ChangeQty08		= Sum(A.ChangeQty08),
	ChangeQty09		= Sum(A.ChangeQty09),
	ChangeQty10		= Sum(A.ChangeQty10),
	ChangeQty11		= Sum(A.ChangeQty11),
	ChangeQty12		= Sum(A.ChangeQty12),
	ChangeQty13		= Sum(A.ChangeQty13),
	ChangeQty14		= Sum(A.ChangeQty14),
	ChangeQty15		= Sum(A.ChangeQty15)
From	#tmp_result	A
Group By AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.ProductGroup, A.ProductGroupName,
	A.ModelGroup, A.ModelGroupName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName

Drop Table #tmp_item
Drop Table #tmp_qty
--Drop Table #tmp_planqty
Drop Table #tmp_result

Return

End		-- Procedure End
Go
