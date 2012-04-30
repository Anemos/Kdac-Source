/*
	File Name	: sp_pisp060u_01_print.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp060u_01_print
	Description	: 일일 생산 계획 - 인쇄
			  생산계획이 있는 것만 인쇄
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp060u_01_print]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp060u_01_print]
GO

/*
Execute sp_pisp060u_01_print
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
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'
*/

Create Procedure sp_pisp060u_01_print
	@ps_todate		char(10),
	@ps_plandate01		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate02		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate03		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate04		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate05		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate06		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate07		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate08		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate09		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate10		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate11		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate12		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate13		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate14		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate15		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_plandate16		char(10),	-- 계획일 ('YYYY.MM,DD')
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),	-- 제품군
	@ps_linecode		varchar(1),	-- 모델군
	@ps_itemcode		varchar(12)
As
Begin

Declare	@li_date		int,
	@ls_plandate	char(10)

Create Table #tmp_date
(
	PlanDate		char(10),
	AreaCode		char(1),
	AreaName		varchar(50),
	DivisionCode		char(1),
	DivisionName		varchar(50),
	WorkCenter		varchar(5),
	WorkCenterName		varchar(50),
	LineCode		char(1),
	LineShortName		varchar(50),
	LineFullName		varchar(100),
	SortOrder		int,
	ItemCode		varchar(12),
	ItemName		varchar(100),
	ModelID			varchar(4),
	ProductGubun		char(1),
	ProductGubunName	varchar(20),
	RackQty			int,
	SafetyInvQty		int,
	InvQty			int
)


Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산'
					When A.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= IsNull(B.InvQty, 0)
Into	#tmp_item
From	vmstkb_line	A,
	tinv		B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
	A.PrdStopGubun	= 'N'			And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty, A.SafetyInvQty, B.InvQty

-- 생산계획은 없는데..SR / DDRS / 소요량 등이 있는 것들이 있음...
-- 이런 것들 땜시 미리 일자를 미리 Setting 해야 함.
Select	@li_date = 0
While	@li_date < 15
Begin
	Select	@li_date		= @li_date + 1
	Select	@ls_plandate	= Case @li_date	When 1 Then @ps_plandate01
						When 2 Then @ps_plandate02
						When 3 Then @ps_plandate03
						When 4 Then @ps_plandate04
						When 5 Then @ps_plandate05
						When 6 Then @ps_plandate06
						When 7 Then @ps_plandate07
						When 8 Then @ps_plandate08
						When 9 Then @ps_plandate09
						When 10 Then @ps_plandate10
						When 11 Then @ps_plandate11
						When 12 Then @ps_plandate12
						When 13 Then @ps_plandate13
						When 14 Then @ps_plandate14
						When 15 Then @ps_plandate15
--						When 16 Then @ps_plandate16
						Else ''
				   End

	Insert	#tmp_date
	Select	PlanDate		= @ls_plandate,
		AreaCode		= A.AreaCode,
		AreaName		= A.AreaName,
		DivisionCode		= A.DivisionCode,
		DivisionName		= A.DivisionName,
		WorkCenter		= A.WorkCenter,
		WorkCenterName		= A.WorkCenterName,
		LineCode		= A.LineCode,
		LineShortName		= A.LineShortName,	-- 라인 약명
		LineFullName		= A.LineFullName,		-- 라인 전명
		SortOrder		= A.SortOrder,
		ItemCode		= A.ItemCode,
		ItemName		= A.ItemName,
		ModelID			= A.ModelID,
		ProductGubun		= A.ProductGubun,
		ProductGubunName	= A.ProductGubunName,
		RackQty			= A.RackQty,
		SafetyInvQty		= A.SafetyInvQty,
		InvQty			= A.InvQty
	From	#tmp_item	A
End


Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	PlanQty			= Sum(IsNull(B.PlanQty, 0)),
	ChangeQty		= Sum(IsNull(B.ChangeQty, 0))
Into	#tmp_planqty
From	#tmp_date	A,
	tplanday		B
Where	A.PlanDate	*= B.PlanDate		And
--	(B.PlanDate	Between @ps_plandate01 and @ps_plandate16)	And
	A.AreaCode	*= B.AreaCode			And
	A.DivisionCode	*= B.DivisionCode			And
	A.WorkCenter	*= B.WorkCenter			And
	A.LineCode	*= B.LineCode			And
	A.ItemCode	*= B.ItemCode			And
	B.ChangeQty	> 0
Group By A.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty
/*
-- SR 조회
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	PlanQty			= A.PlanQty,
	ChangeQty		= A.ChangeQty,
	SRQty			= Sum(IsNull(B.SRQty, 0))
Into	#tmp_srqty
From	#tmp_planqty	A,
	(Select	PlanDate	= A.ApplyFrom,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode,
		SRQty		= Sum(IsNull(A.ShipRemainQty, 0))
	From	tsrorder		A
	Where	(A.ApplyFrom	Between @ps_plandate01 and @ps_plandate16)	And
		A.AreaCode	= @ps_areacode			And
		A.DivisionCode	= @ps_divisioncode		And
		A.ItemCode	Like @ps_itemcode		And
		A.ShipEndGubun	= 'N'				And
		A.SRCancelGubun= 'N'
	Group By A.ApplyFrom, A.AreaCode, A.DivisionCode, A.ItemCode)	B
Where	A.PlanDate	*= B.PlanDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty,
	A.PlanQty, A.ChangeQty

-- DDRS 및 소요량 조회
Select	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	PlanDate		= A.PlanDate,
	PlanQty			= A.PlanQty,
	ChangeQty		= A.ChangeQty,
	SRQty			= A.SRQty,
	DDRSQty		= Sum(IsNull(B.PlanQty, 0)),
	KDQty			= Sum(IsNull(B.KDQty, 0)),
	ASQty			= Sum(IsNull(B.ASQty, 0)),
	EtcQty01			= Sum(IsNull(B.EtcQty01, 0)),
	EtcQty02			= Sum(IsNull(B.EtcQty02, 0)),
	EtcQty03			= Sum(IsNull(B.EtcQty03, 0))
Into	#tmp_ddrsqty
From	#tmp_srqty	A,
	tplanddrs	B	
Where	A.PlanDate	*= B.PlanDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.SortOrder, A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun, A.ProductGubunName,
	A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.RackQty, A.SafetyInvQty, A.InvQty,
	A.PlanDate, A.PlanQty, A.ChangeQty, A.SRQty
*/

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	SortOrder		= A.SortOrder,
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
	ChangeQty15		= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty16		= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.ChangeQty, 0) Else 0 End
Into	#tmp_result
From	#tmp_planqty	A
Where	A.ChangeQty	> 0-- Or
--	A.SRQty		> 0 Or
--	A.DDRSQty	> 0 Or
--	A.KDQty		> 0 Or
--	A.ASQty		> 0 Or
--	A.EtcQty01	> 0 Or
--	A.EtcQty02	> 0 Or
--	A.EtcQty03	> 0

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
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
	ChangeQty15		= Sum(A.ChangeQty15),
	ChangeQty16		= Sum(A.ChangeQty16),

	OldQtySum		= Sum(A.ChangeQty01) +  Sum(A.ChangeQty02) + Sum(A.ChangeQty03) +
				Sum(A.ChangeQty04) +  Sum(A.ChangeQty05) + Sum(A.ChangeQty06) +
				Sum(A.ChangeQty07) +  Sum(A.ChangeQty08) + Sum(A.ChangeQty09) +
				Sum(A.ChangeQty10) +  Sum(A.ChangeQty11) + Sum(A.ChangeQty12) +
				Sum(A.ChangeQty13) +  Sum(A.ChangeQty14) + Sum(A.ChangeQty15),
	OldQty01			= Sum(A.ChangeQty01),
	OldQty02			= Sum(A.ChangeQty02),
	OldQty03			= Sum(A.ChangeQty03),
	OldQty04			= Sum(A.ChangeQty04),
	OldQty05			= Sum(A.ChangeQty05),
	OldQty06			= Sum(A.ChangeQty06),
	OldQty07			= Sum(A.ChangeQty07),
	OldQty08			= Sum(A.ChangeQty08),
	OldQty09			= Sum(A.ChangeQty09),
	OldQty10			= Sum(A.ChangeQty10),
	OldQty11			= Sum(A.ChangeQty11),
	OldQty12			= Sum(A.ChangeQty12),
	OldQty13			= Sum(A.ChangeQty13),
	OldQty14			= Sum(A.ChangeQty14),
	OldQty15			= Sum(A.ChangeQty15),
	OldQty16			= Sum(A.ChangeQty16),

	InvQty01			= 0,
	InvQty02			= 0,
	InvQty03			= 0,
	InvQty04			= 0,
	InvQty05			= 0,
	InvQty06			= 0,
	InvQty07			= 0,
	InvQty08			= 0,
	InvQty09			= 0,
	InvQty10			= 0,
	InvQty11			= 0,
	InvQty12			= 0,
	InvQty13			= 0,
	InvQty14			= 0,
	InvQty15			= 0,
	InvQty16			= 0,

	DummyQty01		= 0,
	DummyQty02		= 0,
	DummyQty03		= 0,
	DummyQty04		= 0,
	DummyQty05		= 0,
	DummyQty06		= 0,
	DummyQty07		= 0,
	DummyQty08		= 0,
	DummyQty09		= 0,
	DummyQty10		= 0,
	DummyQty11		= 0,
	DummyQty12		= 0,
	DummyQty13		= 0,
	DummyQty14		= 0,
	DummyQty15		= 0,
	DummyQty16		= 0,
	ChangeFlag		= 'N',
	ChangeFlag01		= 'N',
	ChangeFlag02		= 'N',
	ChangeFlag03		= 'N',
	ChangeFlag04		= 'N',
	ChangeFlag05		= 'N',
	ChangeFlag06		= 'N',
	ChangeFlag07		= 'N',
	ChangeFlag08		= 'N',
	ChangeFlag09		= 'N',
	ChangeFlag10		= 'N',
	ChangeFlag11		= 'N',
	ChangeFlag12		= 'N',
	ChangeFlag13		= 'N',
	ChangeFlag14		= 'N',
	ChangeFlag15		= 'N',
	ChangeFlag16		= 'N'
From	#tmp_result	A
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty


Drop Table #tmp_date
Drop Table #tmp_item
Drop Table #tmp_planqty
--Drop Table #tmp_srqty
--Drop Table #tmp_ddrsqty
Drop Table #tmp_result


Return

End		-- Procedure End
Go
