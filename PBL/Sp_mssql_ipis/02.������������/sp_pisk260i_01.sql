/*
	File Name	: sp_pisk260i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk260i_01
	Description	: 월별 생산 추이 (모델군별)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk260i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk260i_01]
GO

/*
Execute sp_pisk260i_01
	@ps_prdyear		= '2002',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_productgroup	= '%',
	@ps_modelgroup		= '%',
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

Create Procedure sp_pisk260i_01
	@ps_prdyear		char(4),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_productgroup	varchar(2),
	@ps_modelgroup		varchar(3),
	@ps_itemcode		varchar(12)

As
Begin

Select	PrdDate		= A.PlanDate,
	AreaCode	= A.AreaCode,		-- 지역코드
	DivisionCode	= A.DivisionCode,		-- 공장
--	WorkCenter	= A.WorkCenter,		-- Work Center
--	LineCode	= A.LineCode,		-- 라인
	ItemCode	= A.ItemCode,
	PlanQty		= Sum(A.PlanQty),
	PrdQty		= IsNull(Sum(IsNull(B.PrdQty, 0)), 0)
Into	#tmp_prd
From	(Select	PlanDate		= A.PlanDate,
		AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
--		WorkCenter		= A.WorkCenter,		-- Work Center
--		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PlanQty			= Sum(A.ReleaseKBQty)
	From	tplanrelease	A,
		tmstmodel	B
	Where	B.AreaCode	= @ps_areacode		And
		B.DivisionCode	= @ps_divisioncode	And
		B.ProductGroup	Like @ps_productgroup	And
		B.ModelGroup	Like @ps_modelgroup	And
		B.ItemCode	Like @ps_itemcode	And
		B.AreaCode	= A.AreaCode		And
		B.DivisionCode	= A.DivisionCode		And
		B.ItemCode	= A.ItemCode		And
		A.PlanDate	Like @ps_prdyear + '.__.__'	And
	--	A.ReleaseGubun	In ('Y', 'T', 'U', 'N')
		A.ReleaseGubun	> 'C'
	Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.ItemCode)	A,	
	(Select	PrdDate			= A.PrdDate,
		AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
--		WorkCenter		= A.WorkCenter,		-- Work Center
--		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PrdQty			= Sum(A.PrdQty)
	From	tprd		A
	Where	A.PrdDate	Like @ps_prdyear + '.__.__'	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
--		A.WorkCenter	Like @ps_workcenter	And
--		A.LineCode	Like @ps_linecode	And
		A.ItemCode	Like @ps_itemcode
	Group By A.PrdDate, A.AreaCode, A.DivisionCode, A.ItemCode)	B
Where	A.PlanDate	*= B.PrdDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
--	A.WorkCenter	*= B.WorkCenter		And
--	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.ItemCode

Select	PrdYear		= @ps_prdyear,
	AreaCode	= A.AreaCode,		-- 지역코드
	DivisionCode	= A.DivisionCode,		-- 공장
--	WorkCenter	= A.WorkCenter,		-- Work Center
--	LineCode	= A.LineCode,		-- 라인
	ItemCode	= A.ItemCode,
	PlanQty01	= Sum(Case When A.PrdDate like @ps_prdyear + '.01.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty02	= Sum(Case When A.PrdDate like @ps_prdyear + '.02.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty03	= Sum(Case When A.PrdDate like @ps_prdyear + '.03.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty04	= Sum(Case When A.PrdDate like @ps_prdyear + '.04.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty05	= Sum(Case When A.PrdDate like @ps_prdyear + '.05.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty06	= Sum(Case When A.PrdDate like @ps_prdyear + '.06.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty07	= Sum(Case When A.PrdDate like @ps_prdyear + '.07.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty08	= Sum(Case When A.PrdDate like @ps_prdyear + '.08.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty09	= Sum(Case When A.PrdDate like @ps_prdyear + '.09.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty10	= Sum(Case When A.PrdDate like @ps_prdyear + '.10.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty11	= Sum(Case When A.PrdDate like @ps_prdyear + '.11.__'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty12	= Sum(Case When A.PrdDate like @ps_prdyear + '.12.__'  Then IsNull(A.PlanQty, 0) Else 0 End),

	PrdQty01	= Sum(Case When A.PrdDate like @ps_prdyear + '.01.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty02	= Sum(Case When A.PrdDate like @ps_prdyear + '.02.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty03	= Sum(Case When A.PrdDate like @ps_prdyear + '.03.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty04	= Sum(Case When A.PrdDate like @ps_prdyear + '.04.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty05	= Sum(Case When A.PrdDate like @ps_prdyear + '.05.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty06	= Sum(Case When A.PrdDate like @ps_prdyear + '.06.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty07	= Sum(Case When A.PrdDate like @ps_prdyear + '.07.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty08	= Sum(Case When A.PrdDate like @ps_prdyear + '.08.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty09	= Sum(Case When A.PrdDate like @ps_prdyear + '.09.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty10	= Sum(Case When A.PrdDate like @ps_prdyear + '.10.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty11	= Sum(Case When A.PrdDate like @ps_prdyear + '.11.__'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty12	= Sum(Case When A.PrdDate like @ps_prdyear + '.12.__'  Then IsNull(A.PrdQty, 0) Else 0 End)
Into	#tmp_result
From	#tmp_prd	A
Group By A.AreaCode, A.DivisionCode, A.ItemCode


Select	PrdMonth		= A.PrdYear,
	AreaCode		= A.AreaCode,		-- 지역코드
	AreaName		= B.AreaName,
	DivisionCode		= A.DivisionCode,		-- 공장
	DivisionName		= B.DivisionName,
	ProductGroup		= B.ProductGroup,
	ProductGroupName	= B.ProductGroupName,
	ModelGroup		= B.ModelGroup,
	ModelGroupName	= B.ModelGroupName,
	ItemCode		= A.ItemCode,
	ItemName		= B.ItemName,
	ModelID			= B.ModelID,
	PlanQty		= Sum(A.PlanQty01) + Sum(A.PlanQty02) + Sum(A.PlanQty03) + Sum(A.PlanQty04) +
				Sum(A.PlanQty05) + Sum(A.PlanQty06) + Sum(A.PlanQty07) + Sum(A.PlanQty08) +
				Sum(A.PlanQty09) + Sum(A.PlanQty10) + Sum(A.PlanQty11) + Sum(A.PlanQty12),
	PlanQty01	= Sum(A.PlanQty01),
	PlanQty02	= Sum(A.PlanQty02),
	PlanQty03	= Sum(A.PlanQty03),
	PlanQty04	= Sum(A.PlanQty04),
	PlanQty05	= Sum(A.PlanQty05),
	PlanQty06	= Sum(A.PlanQty06),
	PlanQty07	= Sum(A.PlanQty07),
	PlanQty08	= Sum(A.PlanQty08),
	PlanQty09	= Sum(A.PlanQty09),
	PlanQty10	= Sum(A.PlanQty10),
	PlanQty11	= Sum(A.PlanQty11),
	PlanQty12	= Sum(A.PlanQty12),

	PrdQty		= Sum(A.PrdQty01) + Sum(A.PrdQty02) + Sum(A.PrdQty03) + Sum(A.PrdQty04) +
				Sum(A.PrdQty05) + Sum(A.PrdQty06) + Sum(A.PrdQty07) + Sum(A.PrdQty08) +
				Sum(A.PrdQty09) + Sum(A.PrdQty10) + Sum(A.PrdQty11) + Sum(A.PrdQty12),
	PrdQty01	= Sum(A.PrdQty01),
	PrdQty02	= Sum(A.PrdQty02),
	PrdQty03	= Sum(A.PrdQty03),
	PrdQty04	= Sum(A.PrdQty04),
	PrdQty05	= Sum(A.PrdQty05),
	PrdQty06	= Sum(A.PrdQty06),
	PrdQty07	= Sum(A.PrdQty07),
	PrdQty08	= Sum(A.PrdQty08),
	PrdQty09	= Sum(A.PrdQty09),
	PrdQty10	= Sum(A.PrdQty10),
	PrdQty11	= Sum(A.PrdQty11),
	PrdQty12	= Sum(A.PrdQty12)
From	#tmp_result	A,
	vmstkb_model	B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.ItemCode	= B.ItemCode
Group By A.PrdYear, A.AreaCode, B.AreaName, A.DivisionCode, B.DivisionName, B.ProductGroup, B.ProductGroupName,
	B.ModelGroup, B.ModelGroupName, A.ItemCode, B.ItemName, B.ModelID


drop table #tmp_prd
drop table #tmp_result

Return

End		-- Procedure End
Go
