/*
	File Name	: sp_eiss060i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_eiss060i_01
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
	    Where id = object_id(N'[dbo].[sp_eiss060i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eiss060i_01]
GO

/*
Execute sp_eiss060i_01 '2002.12.31', '%'

*/

Create Procedure sp_eiss060i_01
	@ps_prd1		char(10),
	@ps_prddate		char(10),
	@ps_areacode		char(1)

As
Begin

Declare	@ls_prdmonth	char(7),
        @ls_jaego_month char(7)

Select	@ls_prdmonth	= Left(@ps_prddate, 7)

select @ls_jaego_month =  convert(char(7),DATEADD(month, -1,@ps_prddate),102) 

Create Table #tmp_calendar
(	AreaCode	char(1),
	DivisionCode	char(1),
	ilsu		int
)
Create Table #tmp_calendar_total
(	AreaCode	char(1),
	DivisionCode	char(1),
	ilsu		int
)

Create Table #tmp_prd
(	AreaCode	char(1),
	DivisionCode	char(1),
	ItemCode	varchar(12),
	PlanQty01		int,
	ChangeQty01		int,
	PrdQty01		int,
	ShipQty01		int,
	PlanCost01		float,
	ChangeCost01		float,
	PrdCost01		float,
	ShipCost01		float,
	PlanQty02		int,
	ChangeQty02		int,
	PrdQty02		int,
	ShipQty02		int,
	PlanCost02		float,
	ChangeCost02		float,
	PrdCost02		float,
	ShipCost02		float,
        jaegoqty                int,
        jaegocost               float,
        stockqty_total          int,
        shipqty_total           int
)
-- 당월 작업일수
Insert	#tmp_calendar
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ilsu                    = count(*)
From	tcalendarshop A
Where	A.Applymonth	= @ls_prdmonth And
        A.Applydate     >= @ps_prd1    and
        A.Applydate     <= @ps_prddate and
	A.AreaCode	Like @ps_areacode and
        A.WorkGubun     = 'W'
Group By A.AreaCode,A.DivisionCode
-- 당월 작업일수
Insert	#tmp_calendar_total
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ilsu                    = count(*)
From	tcalendarshop A
Where	A.Applymonth	= @ls_prdmonth And
	A.AreaCode	Like @ps_areacode and
        A.WorkGubun     = 'W'
Group By A.AreaCode,A.DivisionCode

-- 당일 입고운영 계획
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(IsNull(A.ChangeQty, 0)),
	ChangeQty01		= 0,
	PrdQty01		= 0,
	ShipQty01		= 0,
	PlanCost01		= Sum(IsNull(A.ChangeQty, 0)) * 1.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,
	ShipCost01		= 0.0,
	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	shipQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0,
	ShipCost02		= 0.0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tplanday	A
Where	A.PlanDate	= @ps_prddate		And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 누계 입고운영 계획
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	ShipQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,
	ShipCost01		= 0.0,
	PlanQty02		= Sum(IsNull(A.ChangeQty, 0)),
	ChangeQty02		= 0,
	PrdQty02		= 0,
	ShipQty02		= 0,
	PlanCost02		= Sum(IsNull(A.ChangeQty, 0)) * 1.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0,
	ShipCost02		= 0.0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tplanday		A
Where	A.PlanDate	>= @ps_prd1	And
	A.PlanDate	<= @ps_prddate		And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 당일 출하계획
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= Sum(IsNull(A.PlanInQty, 0) + IsNull(A.PlanOutQty, 0)),
	PrdQty01		= 0,
	ShipQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= Sum(IsNull(A.PlanInCost, 0) + IsNull(A.PlanOutCost, 0)),
	PrdCost01		= 0.0,
	ShipCost01		= 0.0,

	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	ShipQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0,
	ShipCost02		= 0.0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tshipplanmonth	A
Where	A.PlanMonth	= @ls_prdmonth	And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 누계 출하계획
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	ShipQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,
	ShipCost01		= 0.0,
	PlanQty02		= 0,
	ChangeQty02		= Sum(IsNull(A.PlanInQty, 0) + IsNull(A.PlanOutQty, 0)),
	PrdQty02		= 0,
	ShipQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= Sum(IsNull(A.PlanInCost, 0) + IsNull(A.PlanOuTCost, 0)),
	PrdCost02		= 0.0,
	ShipCost02		= 0.0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tshipplanmonth	A
Where	A.PlanMonth	=  @ls_prdmonth	And
	A.AreaCode	Like @ps_areacode	
Group By A.AreaCode, A.DivisionCode, A.ItemCode


-- 당일 입고실적
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= Sum(IsNull(A.StockQty, 0)),
	ShipQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= Sum(IsNull(A.StockQty, 0)) * 1.0,
	ShipCost01		= 0.0,
	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	ShipQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0,
	ShipCost02		= 0.0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tlotno		A
Where	A.TraceDate	= @ps_prddate		And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 누계 입고실적
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	ShipQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,
	ShipCost01		= 0.0,
	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= Sum(IsNull(A.StockQty, 0)),
	shipQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= Sum(IsNull(A.StockQty, 0)) * 1.0,
	ShipCost02		= 0.0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tlotno		A
Where	A.TraceDate	>= @ps_prd1	And
	A.TraceDate	<= @ps_prddate		And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 당일 출고실적
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	ShipQty01		= Sum(IsNull(A.ShipQty, 0)),
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,
	ShipCost01		= Sum(IsNull(A.ShipQty, 0)) * 1.0,
	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	ShipQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0.0,
	ShipCost02		= 0.0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tlotno		A
Where	A.TraceDate	= @ps_prddate		And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 누계 출고실적
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	ShipQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,
	ShipCost01		= 0.0,
	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	shipQty02		= Sum(IsNull(A.ShipQty, 0)),
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0,
	ShipCost02		= Sum(IsNull(A.ShipQty, 0)) * 1.0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tlotno		A
Where	A.TraceDate	>= @ps_prd1	And
	A.TraceDate	<= @ps_prddate		And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 당월 입고 출고실적
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	ShipQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,
	ShipCost01		= 0.0,
	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	shipQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0,
	ShipCost02		= 0,
        jaegoqty                = 0,
        jaegocost               = 0.0,
        stockqty_total          = sum(isnull(a.stockqty,0)),
        shipqty_total           = sum(isnull(a.shipqty,0))
From	tlotno		A
Where	A.TraceDate	like @ls_prdmonth + '.--'	And
        A.TraceDate	> @ps_prddate	And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 재고
Insert	#tmp_prd
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	ChangeQty01		= 0,
	PrdQty01		= 0,
	ShipQty01		= 0,
	PlanCost01		= 0.0,
	ChangeCost01		= 0.0,
	PrdCost01		= 0.0,
	ShipCost01		= 0.0,
	PlanQty02		= 0,
	ChangeQty02		= 0,
	PrdQty02		= 0,
	shipQty02		= 0,
	PlanCost02		= 0.0,
	ChangeCost02		= 0.0,
	PrdCost02		= 0,
	ShipCost02		= 0,
        jaegoqty                = Sum(IsNull(A.InvQty, 0)),
        jaegocost               = Sum(IsNull(A.InvQty, 0)) * 1.0,
        stockqty_total          = 0,
        shipqty_total           = 0
From	tinvhis		A
Where	A.applymonth	= @ls_prdmonth	And
	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.DivisionCode, A.ItemCode

-- 단가를 고려한 금액을 구하자
Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(A.PlanQty01),
	ChangeQty01		= Sum(A.ChangeQty01),
	PrdQty01		= Sum(A.PrdQty01),
	ShipQty01		= Sum(A.ShipQty01),
	PlanCost01		= Sum(A.PlanCost01) * IsNull(B.UnitCost, 0),
	ChangeCost01		= Sum(A.ChangeCost01) / isnull(d.ilsu,1),
	PrdCost01		= Sum(A.PrdCost01) *  IsNull(B.UnitCost, 0),
	ShipCost01		= Sum(A.ShipCost01) * IsNull(B.UnitCost, 0),

	PlanQty02		= Sum(A.PlanQty02),
	ChangeQty02		= Sum(A.ChangeQty02),
	PrdQty02		= Sum(A.PrdQty02),
	ShipQty02		= Sum(A.ShipQty02),
	PlanCost02		= Sum(A.PlanCost02) * IsNull(B.UnitCost, 0),
	ChangeCost02		= Sum(A.ChangeCost02) * isnull(c.ilsu,1) / isnull(d.ilsu,1),
	PrdCost02		= Sum(A.PrdCost02) * IsNull(B.UnitCost, 0),
	ShipCost02		= Sum(A.ShipCost02) * IsNull(B.UnitCost, 0),
        jaegoqty                = Sum(A.jaegoqty) + Sum(A.stockQty_total) - Sum(A.Shipqty_total),
        jaegocost               = (Sum(A.jaegocost) + Sum(A.stockqty_total) - Sum(A.shipqty_total)) * IsNull(B.UnitCost, 0)
Into	#tmp_item
From	#tmp_prd	A,
	(Select	AreaCode	= A.AreaCode,
		DivisionCode	= A.DivisionCode,
		ItemCode	= A.ItemCode,
		UnitCost		= A.UnitCost
	From	tmstitemcosthis	A
	Where	A.ApplyMonth	= @ls_prdmonth		And
		A.AreaCode	Like @ps_areacode
	Group By A.AreaCode, A.DivisionCode, A.ItemCode, A.UnitCost)	B,
        #tmp_calendar C,#tmp_calendar_total d
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode           and
        a.areacode      *= C.areacode           and
        a.divisioncode  *= C.divisioncode       and
        a.areacode      *= d.areacode           and
        a.divisioncode  *= d.divisioncode       

Group By A.AreaCode, A.DivisionCode, A.ItemCode, B.UnitCost,c.ilsu,d.ilsu

-- 공장별로 Sum 하자
Select	AreaCode		= A.AreaCode,
	AreaName		= C.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= B.DivisionName,
	PlanQty01		= Sum(A.PlanQty01),
	ChangeQty01		= Sum(A.ChangeQty01),
	PrdQty01		= Sum(A.PrdQty01),
	ShipQty01		= Sum(A.ShipQty01),
	PlanCost01		= Ceiling(Sum(A.PlanCost01) / 1000000),
	ChangeCost01		= Ceiling(Sum(A.ChangeCost01) / 1000000),
	PrdCost01		= Ceiling(Sum(A.PrdCost01) / 1000000),
	ShipCost01		= Ceiling(Sum(A.ShipCost01) / 1000000),
	PlanQty02		= Sum(A.PlanQty02),
	ChangeQty02		= Sum(A.ChangeQty02),
	PrdQty02		= Sum(A.PrdQty02),
	ShipQty02		= Sum(A.ShipQty02),
	PlanCost02		= Ceiling(Sum(A.PlanCost02) / 1000000),
	ChangeCost02		= Ceiling(Sum(A.ChangeCost02) / 1000000),
	PrdCost02		= Ceiling(Sum(A.PrdCost02) / 1000000),
	ShipCost02		= Ceiling(Sum(A.ShipCost02) / 1000000),
        JaegoQty		= Sum(A.JaegoQty),
        JaegoCost		= Ceiling(Sum(A.JaegoCost) / 1000000)
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
Drop Table #tmp_calendar
Drop Table #tmp_calendar_total

Return

End		-- Procedure End

Go