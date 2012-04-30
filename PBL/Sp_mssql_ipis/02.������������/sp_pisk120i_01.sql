/*
	File Name	: sp_pisk120i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk120i_01
	Description	: 월별 간판 준수율
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk120i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk120i_01]
GO

/*
Execute sp_pisk120i_01
	@ps_prdyear		= '2002',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'

select * from tprdratekb
 where itemcode = '0000001'
select * from tplanday

select linecode, itemcode, sum(releasekbcount)
from tplanrelease
where plandate = '2002.10.14'
group by linecode, itemcode

dbcc opentran

*/

Create Procedure sp_pisk120i_01
	@ps_prdyear		char(4),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1)

As
Begin

Declare	@ls_applydate_close	char(10),
	@ldt_nowtime		datetime

-- 일단 기준일을 구하자
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ps_areacode,
	@ps_divisioncode	= @ps_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate_close	output

-- 일단 품번별로 지시수량 및 준수수량을 구하자
Select	PrdDate			= Left(A.PrdDate, 7),
	AreaCode		= A.AreaCode,		-- 지역코드
	DivisionCode		= A.DivisionCode,		-- 공장
	WorkCenter		= A.WorkCenter,		-- Work Center
	LineCode		= A.LineCode,		-- 라인
	ItemCode		= A.ItemCode,
	ReleaseCount		= A.ReleaseCount,
	PrdCount		= A.PrdCount,
	DifferentCount		= ABS(A.PrdCount - A.ReleaseCount)
Into	#tmp_item
From	tprdratekb	A
Where	A.PrdDate	Like @ps_prdyear + '.__.__'	And
	A.PrdDate	<= @ls_applydate_close		And
	A.AreaCode	= @ps_areacode			And
	A.DivisionCode	= @ps_divisioncode		And
	A.WorkCenter	Like @ps_workcenter		And
	A.LineCode	Like @ps_linecode

-- 조별로 지시수량 및 준수수량을 구하자
Select	PrdDate			= A.PrdDate,
	AreaCode		= A.AreaCode,		-- 지역코드
	DivisionCode		= A.DivisionCode,		-- 공장
	WorkCenter		= A.WorkCenter,		-- Work Center
	LineCode		= A.LineCode,
	ReleaseCount		= Sum(A.ReleaseCount),
	PrdCount		= Sum(A.PrdCount),
	DifferentCount		= Sum(A.DifferentCount)
Into	#tmp_count
From	#tmp_item	A
Group By A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode

-- 
Select	AreaCode	= A.AreaCode,		-- 지역코드
	DivisionCode	= A.DivisionCode,		-- 공장
	WorkCenter	= A.WorkCenter,		-- Work Center
	LineCode	= A.LineCode,

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

	PrdCount	= Sum(A.PrdCount),
	PrdCount01	= Sum(Case When A.PrdDate = @ps_prdyear + '.01'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount02	= Sum(Case When A.PrdDate = @ps_prdyear + '.02'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount03	= Sum(Case When A.PrdDate = @ps_prdyear + '.03'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount04	= Sum(Case When A.PrdDate = @ps_prdyear + '.04'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount05	= Sum(Case When A.PrdDate = @ps_prdyear + '.05'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount06	= Sum(Case When A.PrdDate = @ps_prdyear + '.06'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount07	= Sum(Case When A.PrdDate = @ps_prdyear + '.07'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount08	= Sum(Case When A.PrdDate = @ps_prdyear + '.08'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount09	= Sum(Case When A.PrdDate = @ps_prdyear + '.09'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount10	= Sum(Case When A.PrdDate = @ps_prdyear + '.10'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount11	= Sum(Case When A.PrdDate = @ps_prdyear + '.11'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount12	= Sum(Case When A.PrdDate = @ps_prdyear + '.12'  Then IsNull(A.PrdCount, 0) Else 0 End),

	DifferentCount	= Sum(A.DifferentCount),
	DifferentCount01	= Sum(Case When A.PrdDate = @ps_prdyear + '.01'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount02	= Sum(Case When A.PrdDate = @ps_prdyear + '.02'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount03	= Sum(Case When A.PrdDate = @ps_prdyear + '.03'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount04	= Sum(Case When A.PrdDate = @ps_prdyear + '.04'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount05	= Sum(Case When A.PrdDate = @ps_prdyear + '.05'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount06	= Sum(Case When A.PrdDate = @ps_prdyear + '.06'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount07	= Sum(Case When A.PrdDate = @ps_prdyear + '.07'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount08	= Sum(Case When A.PrdDate = @ps_prdyear + '.08'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount09	= Sum(Case When A.PrdDate = @ps_prdyear + '.09'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount10	= Sum(Case When A.PrdDate = @ps_prdyear + '.10'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount11	= Sum(Case When A.PrdDate = @ps_prdyear + '.11'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount12	= Sum(Case When A.PrdDate = @ps_prdyear + '.12'  Then IsNull(A.DifferentCount, 0) Else 0 End)
Into	#tmp_result
From	#tmp_count	A
Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode

Select	AreaCode	= A.AreaCode,		-- 지역코드
	AreaName	= B.AreaName,
	DivisionCode	= A.DivisionCode,		-- 공장
	DivisionName	= B.DivisionName,
	WorkCenter	= A.WorkCenter,		-- Work Center
	WorkCenterName	= B.WorkCenterName,
	LineCode	= A.LineCode,
	LineShortName	= B.LineShortName,
	LineFullName	= B.LineFullName,
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
	PrdCount	= A.PrdCount,
	PrdCount01	= Sum(A.PrdCount01),
	PrdCount02	= Sum(A.PrdCount02),
	PrdCount03	= Sum(A.PrdCount03),
	PrdCount04	= Sum(A.PrdCount04),
	PrdCount05	= Sum(A.PrdCount05),
	PrdCount06	= Sum(A.PrdCount06),
	PrdCount07	= Sum(A.PrdCount07),
	PrdCount08	= Sum(A.PrdCount08),
	PrdCount09	= Sum(A.PrdCount09),
	PrdCount10	= Sum(A.PrdCount10),
	PrdCount11	= Sum(A.PrdCount11),
	PrdCount12	= Sum(A.PrdCount12),
	DifferentCount	= A.DifferentCount,
	DifferentCount01	= Sum(A.DifferentCount01),
	DifferentCount02	= Sum(A.DifferentCount02),
	DifferentCount03	= Sum(A.DifferentCount03),
	DifferentCount04	= Sum(A.DifferentCount04),
	DifferentCount05	= Sum(A.DifferentCount05),
	DifferentCount06	= Sum(A.DifferentCount06),
	DifferentCount07	= Sum(A.DifferentCount07),
	DifferentCount08	= Sum(A.DifferentCount08),
	DifferentCount09	= Sum(A.DifferentCount09),
	DifferentCount10	= Sum(A.DifferentCount10),
	DifferentCount11	= Sum(A.DifferentCount11),
	DifferentCount12	= Sum(A.DifferentCount12)
From	#tmp_result	A,
	vmstline		B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode
Group By A.AreaCode, B.AreaName, A.DivisionCode, B.DivisionName, A.WorkCenter, B.WorkCenterName,
	A.LineCode, B.LineShortName, B.LineFullName, A.ReleaseCount, A.PrdCount, A.DifferentCount

drop table #tmp_item
drop table #tmp_count
drop table #tmp_result


Return

End		-- Procedure End

Go