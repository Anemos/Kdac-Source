/*
	File Name	: sp_eisk130i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_eisk130i_01
	Description	: 일별 생산진도(전사)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: 
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eisk130i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisk130i_01]
GO

/*
Execute sp_eisk130i_01 '2002.12', 'D'

select * from tmstarea


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

Create Procedure sp_eisk130i_01
	@ps_prdmonth		char(7),
	@ps_areacode		char(1)

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

-- 당일 지시
Insert	#tmp_prd
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(IsNull(A.ReleaseKBQty, 0)),
	PrdQty01		= 0,
	PlanCost01		= Sum(IsNull(A.ReleaseKBQty, 0)) * 1.0,
	PrdCost01		= 0.0
From	tplanrelease	A
Where	A.PlanDate	Like @ps_prdmonth + '.__'	And
	A.AreaCode	Like @ps_areacode	And
	A.ReleaseGubun	> 'C'
Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.ItemCode

-- 실적
Insert	#tmp_prd
Select	PlanDate		= A.TraceDate,
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= 0,
	PrdQty01		= Sum(IsNull(A.StockQty, 0)),
	PlanCost01		= 0.0,
	PrdCost01		= Sum(IsNull(A.StockQty, 0)) * 1.0
From	tlotno		A
Where	A.TraceDate	Like @ps_prdmonth	 + '.__'	And
	A.AreaCode	Like @ps_areacode
Group By A.TraceDate, A.AreaCode, A.DivisionCode, A.ItemCode

-- 제품별로 Sum 하자
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	ItemCode		= A.ItemCode,
	PlanQty01		= Sum(A.PlanQty01),
	PrdQty01		= Sum(A.PrdQty01),
	PlanCost01		= Sum(A.PlanCost01) * IsNull(B.UnitCost, 0),
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

-- 공장별로 Sum 하자
Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= C.AreaName,
	SortOrder		= B.SortOrder,
	DivisionCode		= A.DivisionCode,
	DivisionName		= B.DivisionName,
	PlanQty01		= Sum(A.PlanQty01),
	PrdQty01		= Sum(A.PrdQty01),
	PlanCost01		= Ceiling(Sum(A.PlanCost01) / 1000000),
	PrdCost01		= Ceiling(Sum(A.PrdCost01) / 1000000)
Into	#tmp_qty
From	#tmp_item	A,
	tmstdivision	B,
	tmstarea		C
Where	A.AreaCode	= B.AreaCode	And
	A.AreaCode	= C.AreaCode	And
	A.DivisionCode	= B.DivisionCode
Group By A.PlanDate, A.AreaCode, C.AreaName, B.SortOrder, A.DivisionCode, B.DivisionName


-- 이제 월별로 처리하자
Select	AreaCode	= A.AreaCode,
	AreaName	= A.AreaName,
	SortOrder	= A.SortOrder,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,

	PlanCost	= Sum(A.PlanCost01),
	PrdCost		= Sum(A.PrdCost01),

	PlanCost01	= Sum(Case When A.PlanDate like @ps_prdmonth + '.01'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost02	= Sum(Case When A.PlanDate like @ps_prdmonth + '.02'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost03	= Sum(Case When A.PlanDate like @ps_prdmonth + '.03'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost04	= Sum(Case When A.PlanDate like @ps_prdmonth + '.04'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost05	= Sum(Case When A.PlanDate like @ps_prdmonth + '.05'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost06	= Sum(Case When A.PlanDate like @ps_prdmonth + '.06'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost07	= Sum(Case When A.PlanDate like @ps_prdmonth + '.07'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost08	= Sum(Case When A.PlanDate like @ps_prdmonth + '.08'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost09	= Sum(Case When A.PlanDate like @ps_prdmonth + '.09'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost10	= Sum(Case When A.PlanDate like @ps_prdmonth + '.10'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost11	= Sum(Case When A.PlanDate like @ps_prdmonth + '.11'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost12	= Sum(Case When A.PlanDate like @ps_prdmonth + '.12'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost13	= Sum(Case When A.PlanDate like @ps_prdmonth + '.13'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost14	= Sum(Case When A.PlanDate like @ps_prdmonth + '.14'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost15	= Sum(Case When A.PlanDate like @ps_prdmonth + '.15'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost16	= Sum(Case When A.PlanDate like @ps_prdmonth + '.16'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost17	= Sum(Case When A.PlanDate like @ps_prdmonth + '.17'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost18	= Sum(Case When A.PlanDate like @ps_prdmonth + '.18'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost19	= Sum(Case When A.PlanDate like @ps_prdmonth + '.19'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost20	= Sum(Case When A.PlanDate like @ps_prdmonth + '.20'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost21	= Sum(Case When A.PlanDate like @ps_prdmonth + '.21'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost22	= Sum(Case When A.PlanDate like @ps_prdmonth + '.22'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost23	= Sum(Case When A.PlanDate like @ps_prdmonth + '.23'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost24	= Sum(Case When A.PlanDate like @ps_prdmonth + '.24'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost25	= Sum(Case When A.PlanDate like @ps_prdmonth + '.25'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost26	= Sum(Case When A.PlanDate like @ps_prdmonth + '.26'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost27	= Sum(Case When A.PlanDate like @ps_prdmonth + '.27'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost28	= Sum(Case When A.PlanDate like @ps_prdmonth + '.28'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost29	= Sum(Case When A.PlanDate like @ps_prdmonth + '.29'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost30	= Sum(Case When A.PlanDate like @ps_prdmonth + '.30'  Then IsNull(A.PlanCost01, 0) Else 0 End),
	PlanCost31	= Sum(Case When A.PlanDate like @ps_prdmonth + '.31'  Then IsNull(A.PlanCost01, 0) Else 0 End),

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
Group By A.AreaCode, A.AreaName, A.SortOrder, A.DivisionCode, A.DivisionName

-- 최종 결과를 구하자
-- 백만 단위로 절삭을 함에 따라..
-- 일단위로 금액을 구한 경우하고, 월 단위로 구한 금액이 차이가 난다....
-- 따라서, 여기서의 누계 월단위로 Sum 한 값으로 처리...
Select	AreaCode	= A.AreaCode,
	AreaName	= A.AreaName,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,

--	PlanCost	= Sum(A.PlanCost01) + Sum(A.PlanCost02) + Sum(A.PlanCost03) + Sum(A.PlanCost04) +
--				Sum(A.PlanCost05) + Sum(A.PlanCost06) + Sum(A.PlanCost07) + Sum(A.PlanCost08) +
--				Sum(A.PlanCost09) + Sum(A.PlanCost10) + Sum(A.PlanCost11) + Sum(A.PlanCost12) + 
--				Sum(A.PlanCost13) + Sum(A.PlanCost14) + Sum(A.PlanCost15) + Sum(A.PlanCost16) +
--				Sum(A.PlanCost17) + Sum(A.PlanCost18) + Sum(A.PlanCost19) + Sum(A.PlanCost20) + 
--				Sum(A.PlanCost21) + Sum(A.PlanCost22) + Sum(A.PlanCost23) + Sum(A.PlanCost24) +
--				Sum(A.PlanCost25) + Sum(A.PlanCost26) + Sum(A.PlanCost27) + Sum(A.PlanCost28) + 
--				Sum(A.PlanCost29) + Sum(A.PlanCost30) + Sum(A.PlanCost31),
	PlanCost	= Sum(B.PlanCost),

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
	PlanCost13	= Sum(A.PlanCost13),
	PlanCost14	= Sum(A.PlanCost14),
	PlanCost15	= Sum(A.PlanCost15),
	PlanCost16	= Sum(A.PlanCost16),
	PlanCost17	= Sum(A.PlanCost17),
	PlanCost18	= Sum(A.PlanCost18),
	PlanCost19	= Sum(A.PlanCost19),
	PlanCost20	= Sum(A.PlanCost20),
	PlanCost21	= Sum(A.PlanCost21),
	PlanCost22	= Sum(A.PlanCost22),
	PlanCost23	= Sum(A.PlanCost23),
	PlanCost24	= Sum(A.PlanCost24),
	PlanCost25	= Sum(A.PlanCost25),
	PlanCost26	= Sum(A.PlanCost26),
	PlanCost27	= Sum(A.PlanCost27),
	PlanCost28	= Sum(A.PlanCost28),
	PlanCost29	= Sum(A.PlanCost29),
	PlanCost30	= Sum(A.PlanCost30),
	PlanCost31	= Sum(A.PlanCost31),

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
		PlanCost	= Ceiling(Sum(A.PlanCost01) / 1000000),
		PrdCost		= Ceiling(Sum(A.PrdCost01) / 1000000)
	From	#tmp_item	A
	Group By A.AreaCode, A.DivisionCode)	B
Where	A.AreaCode	*= B.AreaCode
And	A.DivisionCode	*= B.DivisionCode
Group By A.AreaCode, A.AreaName, A.SortOrder, A.DivisionCode, A.DivisionName
Order By A.AreaCode, A.SortOrder, A.DivisionCode


Drop Table #tmp_prd
Drop Table #tmp_item
Drop Table #tmp_qty
Drop Table #tmp_result

Return

End		-- Procedure End

Go