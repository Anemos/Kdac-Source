/*
	File Name	: sp_pisp062u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp062u_01
	Description	: 일일 생산 계획
			  DDRS 및 S/R 현황을 조회한다.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp062u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp062u_01]
GO

/*
Execute sp_pisp062u_01
	@ps_todate		= '2002.10.30',
	@ps_plandate01		= '2002.10.31',
	@ps_plandate02		= '2002.11.01',
	@ps_plandate03		= '2002.11.02',
	@ps_plandate04		= '2002.11.03',
	@ps_plandate05		= '2002.11.04',
	@ps_plandate06		= '2002.11.05',
	@ps_plandate07		= '2002.11.06',
	@ps_plandate08		= '2002.11.07',
	@ps_plandate09		= '2002.11.08',
	@ps_plandate10		= '2002.11.09',
	@ps_plandate11		= '2002.11.10',
	@ps_plandate12		= '2002.11.11',
	@ps_plandate13		= '2002.11.12',
	@ps_plandate14		= '2002.11.13',
	@ps_plandate15		= '2002.11.14',
	@ps_plandate16		= '2002.11.15',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_workcenter		= '731J',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tplanday

update tplanday
set changeqty = 100
where itemcode in ('10456266A', '10456267A')

select *
from tsrorder
where itemcode in ('10456266A',
'10456267A',
'511513',
'511514',
'511517')
*/

Create Procedure sp_pisp062u_01
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
	SortOrder		int,
	ItemCode		varchar(12),
	ItemName		varchar(100),
	ModelID			varchar(4),
	ProductGubun		char(1),
	ProductGubunName	varchar(20),
	RackQty			int,
	SafetyInvQty		int,
	InvQty			int,
	InvCompute		char(1)
)

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
--	SortOrder		= A.SortOrder,
	SortOrder		= 0,
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
	InvQty			= IsNull(B.InvQty, 0),
	InvCompute		= IsNull(B.InvCompute, '1')
Into	#tmp_item
From	vmstkb_line	A,
	tinv		B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
--	A.WorkCenter	Like @ps_workcenter	And
--	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
	A.PrdStopGubun	= 'N'			And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.SortOrder, 
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty, A.SafetyInvQty, B.InvQty, B.InvCompute

-- 생산계획은 없는데..SR / DDRS / 소요량 등이 있는 것들이 있음...
-- 이런 것들 땜시 미리 일자를 미리 Setting 해야 함.
Select	@li_date = 0
While	@li_date < 16
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
						When 16 Then @ps_plandate16
						Else ''
				   End

	Insert	#tmp_date
	Select	PlanDate		= @ls_plandate,
		AreaCode		= A.AreaCode,
		AreaName		= A.AreaName,
		DivisionCode		= A.DivisionCode,
		DivisionName		= A.DivisionName,
		SortOrder		= A.SortOrder,
		ItemCode		= A.ItemCode,
		ItemName		= A.ItemName,
		ModelID			= A.ModelID,
		ProductGubun		= A.ProductGubun,
		ProductGubunName	= A.ProductGubunName,
		RackQty			= A.RackQty,
		SafetyInvQty		= A.SafetyInvQty,
		InvQty			= A.InvQty,
		InvCompute		= A.InvCompute
	From	#tmp_item	A
End

-- 생산계획 조회
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	PlanQty			= Sum(IsNull(B.PlanQty, 0)),
	ChangeQty		= Sum(IsNull(B.ChangeQty, 0))
Into	#tmp_planqty
From	#tmp_date	A,
	tplanday		B
Where	A.PlanDate	*= B.PlanDate		And
--	(B.PlanDate	Between @ps_plandate01 and @ps_plandate16)	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
	A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty, A.InvCompute

-- 금일 지시 잔량 조회
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	ReleaseQty		= Sum(IsNull(B.CurrentQty, 0)),
	PrdQty			= 0,
	PlanQty			= A.PlanQty,
	ChangeQty		= A.ChangeQty
Into	#tmp_releaseqty
From	#tmp_planqty	A,
--	(Select	PlanDate	= A.PlanDate,
--		AreaCode	= A.AreaCode,
--		DivisionCode	= A.DivisionCode,
--		ItemCode	= A.ItemCode,
--		ReleaseQty	= Sum(IsNull(A.ReleaseKBQty, 0))
--	From	tplanrelease	A
--	Where	A.PlanDate		= @ps_todate		And
--		A.AreaCode		= @ps_areacode		And
--		A.DivisionCode		= @ps_divisioncode	And
--		A.WorkCenter		Like @ps_workcenter	And
--		A.LineCode		Like @ps_linecode	And
--		A.ItemCode		Like @ps_itemcode	And
--		A.ReleaseGubun		In ('Y', 'T')		And
--		A.PrdFlag		= 'N'
--	Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.ItemCode)	B
	(Select	PlanDate	= @ps_todate,--.PlanDate,
		AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode,
		CurrentQty	= Sum(IsNull(A.CurrentQty, 0))
	From	tkb		A
	Where	A.PlanDate		<= @ps_todate		And
		A.AreaCode		= @ps_areacode		And
		A.DivisionCode		= @ps_divisioncode	And
		A.ItemCode		Like @ps_itemcode	And
		A.KBStatusCode		In ('A', 'C')		And
		A.StockGubun		<> 'B'
	Group By A.AreaCode, A.DivisionCode, A.ItemCode)	B
Where	A.PlanDate	*= B.PlanDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty, A.InvCompute,
	A.PlanQty, A.ChangeQty

--select * from #tmp_releaseqty

-- SR 조회
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	ReleaseQty		= A.ReleaseQty,
	PrdQty			= A.PrdQty,
	PlanQty			= A.PlanQty,
	ChangeQty		= A.ChangeQty,
	SRQty			= Sum(IsNull(B.SRQty, 0))
Into	#tmp_srqty
From	#tmp_releaseqty	A,
	(Select	PlanDate	= A.ApplyFrom,
		AreaCode	= A.SRAreaCode,
		DivisionCode	= A.SRDivisionCode,
		ItemCode	= A.ItemCode,
		SRQty		= Sum(IsNull(A.ShipRemainQty, 0))
	From	tsrorder		A
	Where	A.SRAreaCode	= @ps_areacode			And
		A.SRDivisionCode	= @ps_divisioncode		And
		A.ShipEndGubun	= 'N'				And
		(A.ApplyFrom	Between @ps_plandate01 and @ps_plandate16)	And
		A.ItemCode	Like @ps_itemcode		And
		A.SRCancelGubun= 'N'
	Group By A.ApplyFrom, A.SRAreaCode, A.SRDivisionCode, A.ItemCode)	B
Where	A.PlanDate	*= B.PlanDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty, A.InvCompute,
	A.ReleaseQty, A.PrdQty, A.PlanQty, A.ChangeQty

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
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	ReleaseQty		= A.ReleaseQty,
	PrdQty			= A.PrdQty,
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
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.RackQty, A.SafetyInvQty, A.InvQty, A.InvCompute,
	A.ReleaseQty, A.PrdQty, A.PlanDate, A.PlanQty, A.ChangeQty, A.SRQty

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
---	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	ReleaseQty		= A.ReleaseQty,
	PrdQty			= A.PrdQty,
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
	ChangeQty16		= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.ChangeQty, 0) Else 0 End,

	SRQty01		= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty02		= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty03		= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty04		= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty05		= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty06		= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty07		= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty08		= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty09		= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty10		= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty11		= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty12		= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty13		= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty14		= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty15		= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty16		= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.SRQty, 0) Else 0 End,

	DDRSQty01		= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty02		= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty03		= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty04		= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty05		= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty06		= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty07		= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty08		= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty09		= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty10		= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty11		= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty12		= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty13		= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty14		= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty15		= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty16		= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.DDRSQty, 0) Else 0 End,

	KDQty01		= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty02		= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty03		= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty04		= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty05		= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty06		= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty07		= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty08		= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty09		= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty10		= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty11		= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty12		= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty13		= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty14		= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty15		= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty16		= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.KDQty, 0) Else 0 End,

	ASQty01		= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty02		= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty03		= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty04		= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty05		= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty06		= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty07		= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty08		= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty09		= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty10		= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty11		= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty12		= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty13		= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty14		= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty15		= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty16		= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.ASQty, 0) Else 0 End,

	EtcQty0101	= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0102	= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0103	= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0104	= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0105	= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0106	= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0107	= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0108	= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0109	= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0110	= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0111	= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0112	= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0113	= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0114	= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0115	= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0116	= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.EtcQty01, 0) Else 0 End,

	EtcQty0201	= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0202	= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0203	= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0204	= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0205	= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0206	= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0207	= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0208	= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0209	= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0210	= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0211	= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0212	= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0213	= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0214	= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0215	= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0216	= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.EtcQty02, 0) Else 0 End,

	EtcQty0301	= Case When A.PlanDate = @ps_plandate01  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0302	= Case When A.PlanDate = @ps_plandate02  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0303	= Case When A.PlanDate = @ps_plandate03  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0304	= Case When A.PlanDate = @ps_plandate04  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0305	= Case When A.PlanDate = @ps_plandate05  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0306	= Case When A.PlanDate = @ps_plandate06  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0307	= Case When A.PlanDate = @ps_plandate07  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0308	= Case When A.PlanDate = @ps_plandate08  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0309	= Case When A.PlanDate = @ps_plandate09  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0310	= Case When A.PlanDate = @ps_plandate10  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0311	= Case When A.PlanDate = @ps_plandate11  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0312	= Case When A.PlanDate = @ps_plandate12  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0313	= Case When A.PlanDate = @ps_plandate13  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0314	= Case When A.PlanDate = @ps_plandate14  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0315	= Case When A.PlanDate = @ps_plandate15  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0316	= Case When A.PlanDate = @ps_plandate16  Then IsNull(A.EtcQty03, 0) Else 0 End

Into	#tmp_result
From	#tmp_ddrsqty	A
Where	A.ReleaseQty	> 0 Or
--	A.PrdQty		> 0 Or
--	A.PlanQty	> 0 Or
	A.ChangeQty	> 0 Or
	A.SRQty		> 0 Or
	A.DDRSQty	> 0 Or
	A.KDQty		> 0 Or
	A.ASQty		> 0 Or
	A.EtcQty01	> 0 Or
	A.EtcQty02	> 0 Or
	A.EtcQty03	> 0


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
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	ReleaseQty		= Sum(A.ReleaseQty),
	PrdQty			= Sum(A.PrdQty),
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

	SRQtySum		= Sum(A.SRQty01) +  Sum(A.SRQty02) + Sum(A.SRQty03) +
				Sum(A.SRQty04) +  Sum(A.SRQty05) + Sum(A.SRQty06) +
				Sum(A.SRQty07) +  Sum(A.SRQty08) + Sum(A.SRQty09) +
				Sum(A.SRQty10) +  Sum(A.SRQty11) + Sum(A.SRQty12) +
				Sum(A.SRQty13) +  Sum(A.SRQty14) + Sum(A.SRQty15),
	SRQty01		= Sum(A.SRQty01),
	SRQty02		= Sum(A.SRQty02),
	SRQty03		= Sum(A.SRQty03),
	SRQty04		= Sum(A.SRQty04),
	SRQty05		= Sum(A.SRQty05),
	SRQty06		= Sum(A.SRQty06),
	SRQty07		= Sum(A.SRQty07),
	SRQty08		= Sum(A.SRQty08),
	SRQty09		= Sum(A.SRQty09),
	SRQty10		= Sum(A.SRQty10),
	SRQty11		= Sum(A.SRQty11),
	SRQty12		= Sum(A.SRQty12),
	SRQty13		= Sum(A.SRQty13),
	SRQty14		= Sum(A.SRQty14),
	SRQty15		= Sum(A.SRQty15),
	SRQty16		= Sum(A.SRQty16),

	DDRSQtySum		= Sum(A.DDRSQty01) +  Sum(A.DDRSQty02) + Sum(A.DDRSQty03) +
				Sum(A.DDRSQty04) +  Sum(A.DDRSQty05) + Sum(A.DDRSQty06) +
				Sum(A.DDRSQty07) +  Sum(A.DDRSQty08) + Sum(A.DDRSQty09) +
				Sum(A.DDRSQty10) +  Sum(A.DDRSQty11) + Sum(A.DDRSQty12) +
				Sum(A.DDRSQty13) +  Sum(A.DDRSQty14) + Sum(A.DDRSQty15),
	DDRSQty01		= Sum(A.DDRSQty01),
	DDRSQty02		= Sum(A.DDRSQty02),
	DDRSQty03		= Sum(A.DDRSQty03),
	DDRSQty04		= Sum(A.DDRSQty04),
	DDRSQty05		= Sum(A.DDRSQty05),
	DDRSQty06		= Sum(A.DDRSQty06),
	DDRSQty07		= Sum(A.DDRSQty07),
	DDRSQty08		= Sum(A.DDRSQty08),
	DDRSQty09		= Sum(A.DDRSQty09),
	DDRSQty10		= Sum(A.DDRSQty10),
	DDRSQty11		= Sum(A.DDRSQty11),
	DDRSQty12		= Sum(A.DDRSQty12),
	DDRSQty13		= Sum(A.DDRSQty13),
	DDRSQty14		= Sum(A.DDRSQty14),
	DDRSQty15		= Sum(A.DDRSQty15),
	DDRSQty16		= Sum(A.DDRSQty16),

	DummyQtySum		= Sum(A.KDQty01) +  Sum(A.KDQty02) + Sum(A.KDQty03) +
				Sum(A.KDQty04) +  Sum(A.KDQty05) + Sum(A.KDQty06) +
				Sum(A.KDQty07) +  Sum(A.KDQty08) + Sum(A.KDQty09) +
				Sum(A.KDQty10) +  Sum(A.KDQty11) + Sum(A.KDQty12) +
				Sum(A.KDQty13) +  Sum(A.KDQty14) + Sum(A.KDQty15) +

				Sum(A.ASQty01) +  Sum(A.ASQty02) + Sum(A.ASQty03) +
				Sum(A.ASQty04) +  Sum(A.ASQty05) + Sum(A.ASQty06) +
				Sum(A.ASQty07) +  Sum(A.ASQty08) + Sum(A.ASQty09) +
				Sum(A.ASQty10) +  Sum(A.ASQty11) + Sum(A.ASQty12) +
				Sum(A.ASQty13) +  Sum(A.ASQty14) + Sum(A.ASQty15) +

				Sum(A.EtcQty0101) +  Sum(A.EtcQty0102) + Sum(A.EtcQty0103) +
				Sum(A.EtcQty0104) +  Sum(A.EtcQty0105) + Sum(A.EtcQty0106) +
				Sum(A.EtcQty0107) +  Sum(A.EtcQty0108) + Sum(A.EtcQty0109) +
				Sum(A.EtcQty0110) +  Sum(A.EtcQty0111) + Sum(A.EtcQty0112) +
				Sum(A.EtcQty0113) +  Sum(A.EtcQty0114) + Sum(A.EtcQty0115) +

				Sum(A.EtcQty0201) +  Sum(A.EtcQty0202) + Sum(A.EtcQty0203) +
				Sum(A.EtcQty0204) +  Sum(A.EtcQty0205) + Sum(A.EtcQty0206) +
				Sum(A.EtcQty0207) +  Sum(A.EtcQty0208) + Sum(A.EtcQty0209) +
				Sum(A.EtcQty0210) +  Sum(A.EtcQty0211) + Sum(A.EtcQty0212) +
				Sum(A.EtcQty0213) +  Sum(A.EtcQty0214) + Sum(A.EtcQty0215) +

				Sum(A.EtcQty0301) +  Sum(A.EtcQty0302) + Sum(A.EtcQty0303) +
				Sum(A.EtcQty0304) +  Sum(A.EtcQty0305) + Sum(A.EtcQty0306) +
				Sum(A.EtcQty0307) +  Sum(A.EtcQty0308) + Sum(A.EtcQty0309) +
				Sum(A.EtcQty0310) +  Sum(A.EtcQty0311) + Sum(A.EtcQty0312) +
				Sum(A.EtcQty0313) +  Sum(A.EtcQty0314) + Sum(A.EtcQty0315),

	KDQtySum		= Sum(A.KDQty01) +  Sum(A.KDQty02) + Sum(A.KDQty03) +
				Sum(A.KDQty04) +  Sum(A.KDQty05) + Sum(A.KDQty06) +
				Sum(A.KDQty07) +  Sum(A.KDQty08) + Sum(A.KDQty09) +
				Sum(A.KDQty10) +  Sum(A.KDQty11) + Sum(A.KDQty12) +
				Sum(A.KDQty13) +  Sum(A.KDQty14) + Sum(A.KDQty15),
	KDQty01			= Sum(A.KDQty01),
	KDQty02			= Sum(A.KDQty02),
	KDQty03			= Sum(A.KDQty03),
	KDQty04			= Sum(A.KDQty04),
	KDQty05			= Sum(A.KDQty05),
	KDQty06			= Sum(A.KDQty06),
	KDQty07			= Sum(A.KDQty07),
	KDQty08			= Sum(A.KDQty08),
	KDQty09			= Sum(A.KDQty09),
	KDQty10			= Sum(A.KDQty10),
	KDQty11			= Sum(A.KDQty11),
	KDQty12			= Sum(A.KDQty12),
	KDQty13			= Sum(A.KDQty13),
	KDQty14			= Sum(A.KDQty14),
	KDQty15			= Sum(A.KDQty15),
	KDQty16			= Sum(A.KDQty16),

	ASQtySum		= Sum(A.ASQty01) +  Sum(A.ASQty02) + Sum(A.ASQty03) +
				Sum(A.ASQty04) +  Sum(A.ASQty05) + Sum(A.ASQty06) +
				Sum(A.ASQty07) +  Sum(A.ASQty08) + Sum(A.ASQty09) +
				Sum(A.ASQty10) +  Sum(A.ASQty11) + Sum(A.ASQty12) +
				Sum(A.ASQty13) +  Sum(A.ASQty14) + Sum(A.ASQty15),
	ASQty01			= Sum(A.ASQty01),
	ASQty02			= Sum(A.ASQty02),
	ASQty03			= Sum(A.ASQty03),
	ASQty04			= Sum(A.ASQty04),
	ASQty05			= Sum(A.ASQty05),
	ASQty06			= Sum(A.ASQty06),
	ASQty07			= Sum(A.ASQty07),
	ASQty08			= Sum(A.ASQty08),
	ASQty09			= Sum(A.ASQty09),
	ASQty10			= Sum(A.ASQty10),
	ASQty11			= Sum(A.ASQty11),
	ASQty12			= Sum(A.ASQty12),
	ASQty13			= Sum(A.ASQty13),
	ASQty14			= Sum(A.ASQty14),
	ASQty15			= Sum(A.ASQty15),
	ASQty16			= Sum(A.ASQty16),

	EtcQty01Sum		= Sum(A.EtcQty0101) +  Sum(A.EtcQty0102) + Sum(A.EtcQty0103) +
				Sum(A.EtcQty0104) +  Sum(A.EtcQty0105) + Sum(A.EtcQty0106) +
				Sum(A.EtcQty0107) +  Sum(A.EtcQty0108) + Sum(A.EtcQty0109) +
				Sum(A.EtcQty0110) +  Sum(A.EtcQty0111) + Sum(A.EtcQty0112) +
				Sum(A.EtcQty0113) +  Sum(A.EtcQty0114) + Sum(A.EtcQty0115),
	EtcQty0101		= Sum(A.EtcQty0101),
	EtcQty0102		= Sum(A.EtcQty0102),
	EtcQty0103		= Sum(A.EtcQty0103),
	EtcQty0104		= Sum(A.EtcQty0104),
	EtcQty0105		= Sum(A.EtcQty0105),
	EtcQty0106		= Sum(A.EtcQty0106),
	EtcQty0107		= Sum(A.EtcQty0107),
	EtcQty0108		= Sum(A.EtcQty0108),
	EtcQty0109		= Sum(A.EtcQty0109),
	EtcQty0110		= Sum(A.EtcQty0110),
	EtcQty0111		= Sum(A.EtcQty0111),
	EtcQty0112		= Sum(A.EtcQty0112),
	EtcQty0113		= Sum(A.EtcQty0113),
	EtcQty0114		= Sum(A.EtcQty0114),
	EtcQty0115		= Sum(A.EtcQty0115),
	EtcQty0116		= Sum(A.EtcQty0116),

	EtcQty02Sum		= Sum(A.EtcQty0201) +  Sum(A.EtcQty0202) + Sum(A.EtcQty0203) +
				Sum(A.EtcQty0204) +  Sum(A.EtcQty0205) + Sum(A.EtcQty0206) +
				Sum(A.EtcQty0207) +  Sum(A.EtcQty0208) + Sum(A.EtcQty0209) +
				Sum(A.EtcQty0210) +  Sum(A.EtcQty0211) + Sum(A.EtcQty0212) +
				Sum(A.EtcQty0213) +  Sum(A.EtcQty0214) + Sum(A.EtcQty0215),
	EtcQty0201		= Sum(A.EtcQty0201),
	EtcQty0202		= Sum(A.EtcQty0202),
	EtcQty0203		= Sum(A.EtcQty0203),
	EtcQty0204		= Sum(A.EtcQty0204),
	EtcQty0205		= Sum(A.EtcQty0205),
	EtcQty0206		= Sum(A.EtcQty0206),
	EtcQty0207		= Sum(A.EtcQty0207),
	EtcQty0208		= Sum(A.EtcQty0208),
	EtcQty0209		= Sum(A.EtcQty0209),
	EtcQty0210		= Sum(A.EtcQty0210),
	EtcQty0211		= Sum(A.EtcQty0211),
	EtcQty0212		= Sum(A.EtcQty0212),
	EtcQty0213		= Sum(A.EtcQty0213),
	EtcQty0214		= Sum(A.EtcQty0214),
	EtcQty0215		= Sum(A.EtcQty0215),
	EtcQty0216		= Sum(A.EtcQty0216),

	EtcQty03Sum		= Sum(A.EtcQty0301) +  Sum(A.EtcQty0302) + Sum(A.EtcQty0303) +
				Sum(A.EtcQty0304) +  Sum(A.EtcQty0305) + Sum(A.EtcQty0306) +
				Sum(A.EtcQty0307) +  Sum(A.EtcQty0308) + Sum(A.EtcQty0309) +
				Sum(A.EtcQty0310) +  Sum(A.EtcQty0311) + Sum(A.EtcQty0312) +
				Sum(A.EtcQty0313) +  Sum(A.EtcQty0314) + Sum(A.EtcQty0315),
	EtcQty0301		= Sum(A.EtcQty0301),
	EtcQty0302		= Sum(A.EtcQty0302),
	EtcQty0303		= Sum(A.EtcQty0303),
	EtcQty0304		= Sum(A.EtcQty0304),
	EtcQty0305		= Sum(A.EtcQty0305),
	EtcQty0306		= Sum(A.EtcQty0306),
	EtcQty0307		= Sum(A.EtcQty0307),
	EtcQty0308		= Sum(A.EtcQty0308),
	EtcQty0309		= Sum(A.EtcQty0309),
	EtcQty0310		= Sum(A.EtcQty0310),
	EtcQty0311		= Sum(A.EtcQty0311),
	EtcQty0312		= Sum(A.EtcQty0312),
	EtcQty0313		= Sum(A.EtcQty0313),
	EtcQty0314		= Sum(A.EtcQty0314),
	EtcQty0315		= Sum(A.EtcQty0315),
	EtcQty0316		= Sum(A.EtcQty0316),

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
Group By A.SortOrder, A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun, A.ProductGubunName,
	A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.RackQty, A.SafetyInvQty, A.InvQty,
	A.InvCompute--, A.ReleaseQty, A.PrdQty


Drop Table #tmp_date
Drop Table #tmp_item
Drop Table #tmp_planqty
Drop Table #tmp_releaseqty
Drop Table #tmp_srqty
Drop Table #tmp_ddrsqty
Drop Table #tmp_result

/*
Select	AreaCode		= '',
	DivisionCode		=  '',
	ItemCode		=  '',
	ItemName		=  '',
	ModelID			=  '',
	ProductGubun		=  '',
	ProductGubunName	=  '',
	RackQty			=  0,
	SafetyInvQty		=  0,
	InvQty			=  0,
	InvComputeGubun	=  '1',
	ChangeQtySum		= 0,
	ChangeQty01		= 0,
	ChangeQty02		= 0,
	ChangeQty03		= 0,
	ChangeQty04		= 0,
	ChangeQty05		= 0,
	ChangeQty06		= 0,
	ChangeQty07		= 0,
	ChangeQty08		= 0,
	ChangeQty09		= 0,
	ChangeQty10		= 0,
	ChangeQty11		= 0,
	ChangeQty12		= 0,
	ChangeQty13		= 0,
	ChangeQty14		= 0,
	ChangeQty15		= 0,
	ChangeQty16		= 0,
	ChangeQty17		= 0,
	ChangeQty18		= 0,
	ChangeQty19		= 0,
	ChangeQty20		= 0,
	ChangeQty21		= 0,
	ChangeQty22		= 0,
	ChangeQty23		= 0,
	ChangeQty24		= 0,
	ChangeQty25		= 0,
	ChangeQty26		= 0,
	ChangeQty27		= 0,
	ChangeQty28		= 0,
	ChangeQty29		= 0,
	ChangeQty30		= 0,
	ChangeQty31		= 0

	SRQtySum		= 0,
	SRQty01		= 0,
	SRQty02		= 0,
	SRQty03		= 0,
	SRQty04		= 0,
	SRQty05		= 0,
	SRQty06		= 0,
	SRQty07		= 0,
	SRQty08		= 0,
	SRQty09		= 0,
	SRQty10		= 0,
	SRQty11		= 0,
	SRQty12		= 0,
	SRQty13		= 0,
	SRQty14		= 0,
	SRQty15		= 0,
	SRQty16		= 0,
	SRQty17		= 0,
	SRQty18		= 0,
	SRQty19		= 0,
	SRQty20		= 0,
	SRQty21		= 0,
	SRQty22		= 0,
	SRQty23		= 0,
	SRQty24		= 0,
	SRQty25		= 0,
	SRQty26		= 0,
	SRQty27		= 0,
	SRQty28		= 0,
	SRQty29		= 0,
	SRQty30		= 0,
	SRQty31		= 0,

	DDRSQtySum		= 0,
	DDRSQty01		= 0,
	DDRSQty02		= 0,
	DDRSQty03		= 0,
	DDRSQty04		= 0,
	DDRSQty05		= 0,
	DDRSQty06		= 0,
	DDRSQty07		= 0,
	DDRSQty08		= 0,
	DDRSQty09		= 0,
	DDRSQty10		= 0,
	DDRSQty11		= 0,
	DDRSQty12		= 0,
	DDRSQty13		= 0,
	DDRSQty14		= 0,
	DDRSQty15		= 0,
	DDRSQty16		= 0,
	DDRSQty17		= 0,
	DDRSQty18		= 0,
	DDRSQty19		= 0,
	DDRSQty20		= 0,
	DDRSQty21		= 0,
	DDRSQty22		= 0,
	DDRSQty23		= 0,
	DDRSQty24		= 0,
	DDRSQty25		= 0,
	DDRSQty26		= 0,
	DDRSQty27		= 0,
	DDRSQty28		= 0,
	DDRSQty29		= 0,
	DDRSQty30		= 0,
	DDRSQty31		= 0

	DummyQtySum		= 0,
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
	DummyQty17		= 0,
	DummyQty18		= 0,
	DummyQty19		= 0,
	DummyQty20		= 0,
	DummyQty21		= 0,
	DummyQty22		= 0,
	DummyQty23		= 0,
	DummyQty24		= 0,
	DummyQty25		= 0,
	DummyQty26		= 0,
	DummyQty27		= 0,
	DummyQty28		= 0,
	DummyQty29		= 0,
	DummyQty30		= 0,
	DummyQty31		= 0
*/
Return

End		-- Procedure End
Go
