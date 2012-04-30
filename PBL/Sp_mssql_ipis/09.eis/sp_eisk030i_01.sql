/*
	File Name	: sp_eisk030i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_eisk030i_01
	Description	: 당일 계획 및 실적(전사)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: 
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eisk030i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisk030i_01]
GO

/*
Execute sp_eisk030i_01 '2002.12.31', '%'

select * from tlotno where areacode = 'D' and divisioncode = 'H'

31.0
181.0
217.0
179.0
230.0
195.0
129.0
55.0

truncate table tplanday

insert tplanday
select * from ipis.dbo.tplanday

insert tplanday
select * from [ipisjin_svr].ipis.dbo.tplanday


select * from tplanrelease
select * from tplanday

insert tplanday
select * from [ipisjin_svr].ipis.dbo.tplanday

Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

Create Procedure sp_eisk030i_01
	@ps_fromdate		char(10),
	@ps_todate		char(10),
	@ps_areacode		char(1)

As
Begin

Declare	@ls_month	char(7)

Select	@ls_month	= Left(@ps_todate, 7)

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

-- 당일 운영 계획
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(IsNull(A.ChangeQty, 0)),
	ChangeQty01		= 0,
	PrdQty01		= 0,
	PlanCost01		= Sum(IsNull(A.ChangeQty, 0)) * 1.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,

	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0
From	tplanday		A
Where	A.PlanDate	= @ps_todate		And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 누계 운영 계획
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

	PlanQty02		= Sum(IsNull(A.ChangeQty, 0)),
	ChangeQty02		= 0,
	PrdQty02		= 0,
	PlanCost02		= Sum(IsNull(A.ChangeQty, 0)) * 1.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0
From	tplanday		A
Where	(A.PlanDate	Between @ps_fromdate and @ps_todate)	And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 당일 지시
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= Sum(IsNull(A.ReleaseKBQty, 0)),
	PrdQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= Sum(IsNull(A.ReleaseKBQty, 0)) * 1.0,
	PrdCost01		= 0.0,

	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0
From	tplanrelease	A
Where	A.PlanDate	= @ps_todate		And
	A.AreaCode	Like @ps_areacode	And
	A.ReleaseGubun	> 'C'
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 누계 지시
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
	ChangeQty02		= Sum(IsNull(A.ReleaseKBQty, 0)),
	PrdQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= Sum(IsNull(A.ReleaseKBQty, 0)) * 1.0,
	PrdCost02		= 0.0
From	tplanrelease	A
Where	(A.PlanDate	Between @ps_fromdate and @ps_todate)	And
	A.AreaCode	Like @ps_areacode	And
	A.ReleaseGubun	> 'C'
Group By A.AreaCode, A.DivisionCode, A.ItemCode


-- 당일 실적
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= Sum(IsNull(A.StockQty, 0)),
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= Sum(IsNull(A.StockQty, 0)) * 1.0,

	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0
From	tlotno		A
Where	A.TraceDate	= @ps_todate		And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 누계 실적
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
	PrdQty02		= Sum(IsNull(A.StockQty, 0)),
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= Sum(IsNull(A.StockQty, 0)) * 1.0
From	tlotno		A
Where	(A.TraceDate	Between @ps_fromdate and @ps_todate)	And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 단가를 고려한 금액을 구하자
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(A.PlanQty01),
	ChangeQty01		= Sum(A.ChangeQty01),
	PrdQty01		= Sum(A.PrdQty01),
	PlanCost01		= Sum(A.PlanCost01) * IsNull(B.UnitCost, 0),
	ChangeCost01		= Sum(A.ChangeCost01) * IsNull(B.UnitCost, 0),
	PrdCost01		= Sum(A.PrdCost01) * IsNull(B.UnitCost, 0),

	PlanQty02		= Sum(A.PlanQty02),
	ChangeQty02		= Sum(A.ChangeQty02),
	PrdQty02		= Sum(A.PrdQty02),
	PlanCost02		= Sum(A.PlanCost02) * IsNull(B.UnitCost, 0),
	ChangeCost02		= Sum(A.ChangeCost02) * IsNull(B.UnitCost, 0),
	PrdCost02		= Sum(A.PrdCost02) * IsNull(B.UnitCost, 0)
Into	#tmp_item
From	#tmp_prd	A,
	(Select	AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode,
		UnitCost		= A.UnitCost
	From	tmstitemcosthis	A
	Where	A.ApplyMonth	= @ls_month		And
		A.AreaCode	Like @ps_areacode
	Group By A.AreaCode, A.DivisionCode, A.ItemCode, A.UnitCost)	B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.DivisionCode, A.ItemCode, B.UnitCost

-- 공장별로 Sum 하자
Select	AreaCode		= A.AreaCode,
	AreaName		= C.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= B.DivisionName,
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
	tmstdivision	B,
	tmstarea		C
Where	A.AreaCode	= B.AreaCode	And
	A.AreaCode	= C.AreaCode	And
	A.DivisionCode	= B.DivisionCode
Group By A.AreaCode, C.AreaName, B.SortOrder, A.DivisionCode, B.DivisionName
Order By A.AreaCode, B.SortOrder

Drop Table #tmp_prd
Drop Table #tmp_item
--Drop Table #tmp_result

Return

End		-- Procedure End

Go