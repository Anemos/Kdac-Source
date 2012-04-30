/*
	File Name	: sp_pisk210i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk210i_02
	Description	: 생산 현황 -  그래프
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk210i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk210i_02]
GO

/*
Execute sp_pisk210i_02
	@ps_prddate		= '2002.10.15',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tplanrelease
 where itemcode = '0000001'
select * from tplanday

select linecode, itemcode, sum(releasekbcount)
from tplanrelease
where plandate = '2002.10.14'
group by linecode, itemcode

dbcc opentran

*/

Create Procedure sp_pisk210i_02
	@ps_fromdate		char(10),
	@ps_todate		char(10),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin


Create Table #tmp_prd
(	DayPlanQty	int,
	DayPrdQty	int,
	DayRate		int,
	MonthPlanQty	int,
	MonthPrdQty	int,
	MonthRate	int
)

Insert	#tmp_prd
Select	DayPlanQty	= Sum(A.PlanQty),
	DayPrdQty	= IsNull(Sum(IsNull(B.PrdQty, 0)), 0),
	DayRate		= Ceiling(Case	When	Sum(A.PlanQty) = 0	Then
					Case	When	IsNull(Sum(IsNull(B.PrdQty, 0)), 0) > 0 Then 100.00
						Else	0
						End
				Else	IsNull(Sum(IsNull(B.PrdQty, 0)), 0) * 1.0 / Sum(A.PlanQty)
			   End * 100.00),
	MonthPlanQty	= 0,
	MonthPrdQty	= 0,
	MonthRate	= 0.0
From	(Select	AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
		WorkCenter		= A.WorkCenter,		-- Work Center
		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PlanQty			= Sum(A.ReleaseKBQty)
	From	tplanrelease	A
	Where	A.PlanDate	= @ps_todate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	Like @ps_workcenter	And
		A.LineCode	Like @ps_linecode	And
		A.ItemCode	Like @ps_itemcode	And
	--	A.ReleaseGubun	In ('Y', 'T', 'U', 'N')
		A.ReleaseGubun	> 'C'
	Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode)	A,	
	(Select	AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
		WorkCenter		= A.WorkCenter,		-- Work Center
		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PrdQty			= Sum(A.PrdQty)
	From	tprd		A
	Where	A.PrdDate	= @ps_todate		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	Like @ps_workcenter	And
		A.LineCode	Like @ps_linecode	And
		A.ItemCode	Like @ps_itemcode
	Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode)	B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode


Insert	#tmp_prd
Select	DayPlanQty	= 0,
	DayPrdQty	= 0,
	DayRate		= 0.0,
	MonthPlanQty	= Sum(A.PlanQty),
	MonthPrdQty	= IsNull(Sum(IsNull(B.PrdQty, 0)), 0),
	MonthRate	= Ceiling(Case	When	Sum(A.PlanQty) = 0	Then
					Case	When	IsNull(Sum(IsNull(B.PrdQty, 0)), 0) > 0 Then 100.00
						Else	0
						End
				Else	IsNull(Sum(IsNull(B.PrdQty, 0)), 0) * 1.0 / Sum(A.PlanQty)
			   End * 100.00)
From	(Select	AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
		WorkCenter		= A.WorkCenter,		-- Work Center
		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PlanQty			= Sum(A.ReleaseKBQty)
	From	tplanrelease	A
	Where	(A.PlanDate	Between @ps_fromdate And @ps_todate)		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	Like @ps_workcenter	And
		A.LineCode	Like @ps_linecode	And
		A.ItemCode	Like @ps_itemcode	And
	--	A.ReleaseGubun	In ('Y', 'T', 'U', 'N')
		A.ReleaseGubun	> 'C'
	Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode)	A,	
	(Select	AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
		WorkCenter		= A.WorkCenter,		-- Work Center
		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PrdQty			= Sum(A.PrdQty)
	From	tprd		A
	Where	(A.PrdDate	Between @ps_fromdate And @ps_todate)		And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	Like @ps_workcenter	And
		A.LineCode	Like @ps_linecode	And
		A.ItemCode	Like @ps_itemcode
	Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode)	B
Where	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode


Select	Gubun		= '',
	DayPlanQty	= Sum(A.DayPlanQty),
	DayPrdQty	= Sum(A.DayPrdQty),
	DayRate		= Sum(A.DayRate),
	MonthPlanQty	= Sum(A.MonthPlanQty),
	MonthPrdQty	= Sum(A.MonthPrdQty),
	MonthRate	= Sum(A.MonthRate)
From	#tmp_prd	A

drop table #tmp_prd

Return

End		-- Procedure End
Go
