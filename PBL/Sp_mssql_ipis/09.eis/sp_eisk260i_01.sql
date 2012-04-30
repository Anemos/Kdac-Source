/*
	File Name	: sp_eisk260i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_eisk260i_01
	Description	: 월별 조립간판 평준화율(공장별)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: 
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eisk260i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisk260i_01]
GO

/*
Execute sp_eisk260i_01 '2002', 'D', 'A'

select * from tmstarea

Select	sum(releasecount), sum(prdcount)
From	tprdratekb	A
Where	A.AreaCode	= 'D'			And
	A.DivisionCode	Like 'A'	and
	a.workcenter = '421E'
311
168	
select * from tprdkb
Where	A.AreaCode	= 'D'			And
	A.DivisionCode	Like 'A'	and
	a.workcenter = '421E'

Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

Create Procedure sp_eisk260i_01
	@ps_prdyear		char(4),
	@ps_areacode		char(1),
	@ps_divisioncode	char(1)

As
Begin

Declare	@ls_todate		char(10),
	@ldt_nowtime		datetime

-- 일단 기준일을 구하자
Select	@ldt_nowtime	= GetDate()
Select	@ls_todate	= Convert(Char(10), @ldt_nowtime, 102)


-- 일단 품번별로 지시수량 및 준수수량을 구하자
Select	PrdDate			= Left(A.PrdDate, 7),
	AreaCode		= A.AreaCode,		-- 지역코드
	DivisionCode		= A.DivisionCode,		-- 공장
	WorkCenter		= A.WorkCenter,		-- Work Center
	LineCode		= A.LineCode,		-- 라인
	ItemCode		= A.ItemCode,
	ReleaseCount		= A.ReleaseCount,
	HitCount			= A.HitCount
Into	#tmp_item
From	tprdratecycle	A
Where	A.PrdDate	Like @ps_prdyear + '.__.__'	And
	A.PrdDate	<= @ls_todate			And
	A.AreaCode	= @ps_areacode			And
	A.DivisionCode	Like @ps_divisioncode

-- 조별로 지시수량 및 준수수량을 구하자
Select	PrdDate			= A.PrdDate,
	AreaCode		= A.AreaCode,		-- 지역코드
	DivisionCode		= A.DivisionCode,		-- 공장
	WorkCenter		= A.WorkCenter,		-- Work Center
	ReleaseCount		= Sum(A.ReleaseCount),
	HitCount			= Sum(A.HitCount)
Into	#tmp_count
From	#tmp_item	A
Group By A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter

-- 
Select	AreaCode	= A.AreaCode,		-- 지역코드
	DivisionCode	= A.DivisionCode,		-- 공장
	WorkCenter	= A.WorkCenter,		-- Work Center

	ReleaseCount	= Sum(A.ReleaseCount),
	ReleaseCount01	= Sum(Case When A.PrdDate = @ps_prdyear + '.01'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount02	= Sum(Case When A.PrdDate = @ps_prdyear + '.02'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount03	= Sum(Case When A.PrdDate = @ps_prdyear + '.03'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount04	= Sum(Case When A.PrdDate = @ps_prdyear + '.04'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount05	= Sum(Case When A.PrdDate = @ps_prdyear + '.05'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount06	= Sum(Case When A.PrdDate = @ps_prdyear + '.06'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount07	= Sum(Case When A.PrdDate = @ps_prdyear + '.07'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount08	= Sum(Case When A.PrdDate = @ps_prdyear + '.08'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount09	= Sum(Case When A.PrdDate = @ps_prdyear + '.09'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount10	= Sum(Case When A.PrdDate = @ps_prdyear + '.10'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount11	= Sum(Case When A.PrdDate = @ps_prdyear + '.11'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount12	= Sum(Case When A.PrdDate = @ps_prdyear + '.12'  Then IsNull(A.ReleaseCount, 0) Else 0 End),

	HitCount		= Sum(A.HitCount),
	HitCount01	= Sum(Case When A.PrdDate = @ps_prdyear + '.01'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount02	= Sum(Case When A.PrdDate = @ps_prdyear + '.02'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount03	= Sum(Case When A.PrdDate = @ps_prdyear + '.03'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount04	= Sum(Case When A.PrdDate = @ps_prdyear + '.04'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount05	= Sum(Case When A.PrdDate = @ps_prdyear + '.05'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount06	= Sum(Case When A.PrdDate = @ps_prdyear + '.06'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount07	= Sum(Case When A.PrdDate = @ps_prdyear + '.07'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount08	= Sum(Case When A.PrdDate = @ps_prdyear + '.08'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount09	= Sum(Case When A.PrdDate = @ps_prdyear + '.09'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount10	= Sum(Case When A.PrdDate = @ps_prdyear + '.10'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount11	= Sum(Case When A.PrdDate = @ps_prdyear + '.11'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount12	= Sum(Case When A.PrdDate = @ps_prdyear + '.12'  Then IsNull(A.HitCount, 0) Else 0 End)
Into	#tmp_result
From	#tmp_count	A
Group By A.AreaCode, A.DivisionCode, A.WorkCenter

Select	AreaCode	= A.AreaCode,		-- 지역코드
	AreaName	= D.AreaName,
	DivisionCode	= A.DivisionCode,		-- 공장
	DivisionName	= C.DivisionName,
	WorkCenter	= A.WorkCenter,		-- Work Center
	WorkCenterName	= B.WorkCenterName,
	ReleaseCount	= A.ReleaseCount,
	ReleaseCount01	= Sum(A.ReleaseCount01),
	ReleaseCount02	= Sum(A.ReleaseCount02),
	ReleaseCount03	= Sum(A.ReleaseCount03),
	ReleaseCount04	= Sum(A.ReleaseCount04),
	ReleaseCount05	= Sum(A.ReleaseCount05),
	ReleaseCount06	= Sum(A.ReleaseCount06),
	ReleaseCount07	= Sum(A.ReleaseCount07),
	ReleaseCount08	= Sum(A.ReleaseCount08),
	ReleaseCount09	= Sum(A.ReleaseCount09),
	ReleaseCount10	= Sum(A.ReleaseCount10),
	ReleaseCount11	= Sum(A.ReleaseCount11),
	ReleaseCount12	= Sum(A.ReleaseCount12),
	HitCount		= A.HitCount,
	HitCount01	= Sum(A.HitCount01),
	HitCount02	= Sum(A.HitCount02),
	HitCount03	= Sum(A.HitCount03),
	HitCount04	= Sum(A.HitCount04),
	HitCount05	= Sum(A.HitCount05),
	HitCount06	= Sum(A.HitCount06),
	HitCount07	= Sum(A.HitCount07),
	HitCount08	= Sum(A.HitCount08),
	HitCount09	= Sum(A.HitCount09),
	HitCount10	= Sum(A.HitCount10),
	HitCount11	= Sum(A.HitCount11),
	HitCount12	= Sum(A.HitCount12)
From	#tmp_result	A,
	tmstworkcenter	B,
	tmstdivision	C,
	tmstarea		D
Where	A.AreaCode	= B.AreaCode		And
	A.AreaCode	= C.AreaCode		And
	A.AreaCode	= D.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.DivisionCode	= C.DivisionCode		And
	A.WorkCenter	= B.WorkCenter
Group By A.AreaCode, D.AreaName, C.SortOrder, A.DivisionCode, C.DivisionName, A.WorkCenter, B.WorkCenterName,
	A.ReleaseCount, A.HitCount
Order By A.AreaCode, C.SortOrder

drop table #tmp_item
drop table #tmp_count
drop table #tmp_result


Return

End		-- Procedure End

Go