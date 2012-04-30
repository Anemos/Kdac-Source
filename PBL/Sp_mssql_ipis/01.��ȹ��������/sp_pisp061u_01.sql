/*
	File Name	: sp_pisp061u_01.SQL
	SYSTEM		: KDAC ÅëÇÕ »ý»ê Á¤º¸ ½Ã½ºÅÛ
	Procedure Name	: sp_pisp061u_01
	Description	: ÀÏÀÏ »ý»ê °èÈ¹ - °èÈ¹Ãß°¡
			  ÀÏÀÏ »ý»ê °èÈ¹À» Ãß°¡ÇÒ ¼ö ÀÖ´Â Á¦Ç° Á¶È¸
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp061u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp061u_01]
GO

/*
Execute sp_pisp061u_01
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
	@ps_plandate16		= '2002.11.16',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_workcenter		= '731J',
	@ps_linecode		= 'A'

select * from vmstkb_line
select distinct itemcode from tplanday
*/

Create Procedure sp_pisp061u_01
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
	@ps_plandate16		char(10),	-- °èÈ¹ÀÏ ('YYYY.MM,DD')
	@ps_areacode		Char(1),		-- Áö¿ª ÄÚµå
	@ps_divisioncode	Char(1),		-- °øÀå ÄÚµå
	@ps_workcenter		varchar(5),	-- Á¶
	@ps_linecode		varchar(1)
As
Begin

Select	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '°èÈ¹»ý»ê'
					When A.ProductGubun = 'R'	Then 'ÈÄº¸Ãæ»ý»ê'
					Else 'OEM»ý»ê'
				   End,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= IsNull(B.InvQty, 0),
	SortOrder		= A.SortOrder
Into	#tmp_item
From	(Select	AreaCode		= A.AreaCode,
		DivisionCode		= A.DivisionCode,
		ItemCode		= A.ItemCode,
		ItemName		= B.ItemName,
		ModelID			= A.ModelID,
		ProductGubun		= A.ProductGubun,
		RackQty			= A.RackQty,
		SafetyInvQty		= A.SafetyInvQty,
		SortOrder		= A.SortOrder
	From	tmstkb		A,
		tmstitem		B
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ItemCode	= B.ItemCode		And
		A.PrdStopGubun	= 'N')	A,
	tinv		B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun, A.RackQty, A.SafetyInvQty, B.InvQty, A.SortOrder

Delete	#tmp_item
From	#tmp_item	A,
	 (Select	A.ItemCode
	From	tplanday		A
	Where	(A.PlanDate	Between @ps_plandate01 And @ps_plandate16)	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode		And
		A.ChangeQty	> 0
	Group By A.ItemCode)	B
Where	A.ItemCode	= B.ItemCode

Delete	#tmp_item
From	#tmp_item	A,
	(Select	ItemCode	= A.ItemCode,
		SRQty		= Sum(IsNull(A.ShipRemainQty, 0))
	From	tsrorder		A
	Where	(A.ApplyFrom	Between @ps_plandate01 And @ps_plandate16)	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.ShipEndGubun		= 'N'		And
		A.SRCancelGubun	= 'N'		And
		A.ShipRemainQty		> 0	
	Group By A.ItemCode)	B
Where	A.ItemCode	= B.ItemCode

Delete	#tmp_item
From	#tmp_item	A,
	(Select	ItemCode	= A.ItemCode,
		DDRSQty	= Sum(IsNull(A.PlanQty, 0))
	From	tplanddrs	A
	Where	(A.PlanDate	Between @ps_plandate01 And @ps_plandate16)	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		(A.PlanQty	> 0 Or KDQty > 0 Or ASQty > 0 Or EtcQty01 > 0 Or EtcQty02 > 0 Or EtcQty03 > 0)
	Group By A.ItemCode)	B
Where	A.ItemCode	= B.ItemCode

Select	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	SRQty			= IsNull(B.SRQty, 0),
	DDRSQty		= IsNull(C.DDRSQty, 0)
From	#tmp_item	A,
	(Select	ItemCode	= A.ItemCode,
		SRQty		= Sum(IsNull(A.ShipRemainQty, 0))
	From	tsrorder		A
	Where	(A.ApplyFrom	Between @ps_plandate01 And @ps_plandate16)	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.ShipEndGubun		= 'N'		And
		A.SRCancelGubun	= 'N'
	Group By A.ItemCode)	B,
	(Select	ItemCode	= A.ItemCode,
		DDRSQty	= Sum(IsNull(A.PlanQty, 0))
	From	tplanddrs	A
	Where	(A.PlanDate	Between @ps_plandate01 And @ps_plandate16)	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode
	Group By A.ItemCode)	C
Where	A.ItemCode	*= B.ItemCode		And
	A.ItemCode	*= C.ItemCode

Group By A.SortOrder, A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty, B.SRQty, C.DDRSQty
Order By A.SortOrder


Drop Table #tmp_item

Return

End		-- Procedure End
Go
