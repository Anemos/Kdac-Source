/*
	File Name	: sp_pisk110i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk110i_01
	Description	: 일별 간판 준수율
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk110i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk110i_01]
GO

/*
Execute sp_pisk110i_01
	@ps_prdmonth		= '2002.12',
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

Create Procedure sp_pisk110i_01
	@ps_prdmonth		char(7),
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
Select	PrdDate			= A.PrdDate,
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
Where	A.PrdDate	Like @ps_prdmonth + '.__'		And
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
	ReleaseCount01	= Sum(Case When A.PrdDate = @ps_prdmonth + '.01'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount02	= Sum(Case When A.PrdDate = @ps_prdmonth + '.02'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount03	= Sum(Case When A.PrdDate = @ps_prdmonth + '.03'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount04	= Sum(Case When A.PrdDate = @ps_prdmonth + '.04'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount05	= Sum(Case When A.PrdDate = @ps_prdmonth + '.05'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount06	= Sum(Case When A.PrdDate = @ps_prdmonth + '.06'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount07	= Sum(Case When A.PrdDate = @ps_prdmonth + '.07'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount08	= Sum(Case When A.PrdDate = @ps_prdmonth + '.08'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount09	= Sum(Case When A.PrdDate = @ps_prdmonth + '.09'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount10	= Sum(Case When A.PrdDate = @ps_prdmonth + '.10'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount11	= Sum(Case When A.PrdDate = @ps_prdmonth + '.11'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount12	= Sum(Case When A.PrdDate = @ps_prdmonth + '.12'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount13	= Sum(Case When A.PrdDate = @ps_prdmonth + '.13'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount14	= Sum(Case When A.PrdDate = @ps_prdmonth + '.14'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount15	= Sum(Case When A.PrdDate = @ps_prdmonth + '.15'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount16	= Sum(Case When A.PrdDate = @ps_prdmonth + '.16'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount17	= Sum(Case When A.PrdDate = @ps_prdmonth + '.17'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount18	= Sum(Case When A.PrdDate = @ps_prdmonth + '.18'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount19	= Sum(Case When A.PrdDate = @ps_prdmonth + '.19'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount20	= Sum(Case When A.PrdDate = @ps_prdmonth + '.20'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount21	= Sum(Case When A.PrdDate = @ps_prdmonth + '.21'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount22	= Sum(Case When A.PrdDate = @ps_prdmonth + '.22'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount23	= Sum(Case When A.PrdDate = @ps_prdmonth + '.23'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount24	= Sum(Case When A.PrdDate = @ps_prdmonth + '.24'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount25	= Sum(Case When A.PrdDate = @ps_prdmonth + '.25'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount26	= Sum(Case When A.PrdDate = @ps_prdmonth + '.26'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount27	= Sum(Case When A.PrdDate = @ps_prdmonth + '.27'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount28	= Sum(Case When A.PrdDate = @ps_prdmonth + '.28'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount29	= Sum(Case When A.PrdDate = @ps_prdmonth + '.29'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount30	= Sum(Case When A.PrdDate = @ps_prdmonth + '.30'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	ReleaseCount31	= Sum(Case When A.PrdDate = @ps_prdmonth + '.31'  Then IsNull(A.ReleaseCount, 0) Else 0 End),
	PrdCount	= Sum(A.PrdCount),
	PrdCount01	= Sum(Case When A.PrdDate = @ps_prdmonth + '.01'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount02	= Sum(Case When A.PrdDate = @ps_prdmonth + '.02'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount03	= Sum(Case When A.PrdDate = @ps_prdmonth + '.03'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount04	= Sum(Case When A.PrdDate = @ps_prdmonth + '.04'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount05	= Sum(Case When A.PrdDate = @ps_prdmonth + '.05'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount06	= Sum(Case When A.PrdDate = @ps_prdmonth + '.06'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount07	= Sum(Case When A.PrdDate = @ps_prdmonth + '.07'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount08	= Sum(Case When A.PrdDate = @ps_prdmonth + '.08'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount09	= Sum(Case When A.PrdDate = @ps_prdmonth + '.09'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount10	= Sum(Case When A.PrdDate = @ps_prdmonth + '.10'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount11	= Sum(Case When A.PrdDate = @ps_prdmonth + '.11'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount12	= Sum(Case When A.PrdDate = @ps_prdmonth + '.12'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount13	= Sum(Case When A.PrdDate = @ps_prdmonth + '.13'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount14	= Sum(Case When A.PrdDate = @ps_prdmonth + '.14'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount15	= Sum(Case When A.PrdDate = @ps_prdmonth + '.15'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount16	= Sum(Case When A.PrdDate = @ps_prdmonth + '.16'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount17	= Sum(Case When A.PrdDate = @ps_prdmonth + '.17'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount18	= Sum(Case When A.PrdDate = @ps_prdmonth + '.18'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount19	= Sum(Case When A.PrdDate = @ps_prdmonth + '.19'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount20	= Sum(Case When A.PrdDate = @ps_prdmonth + '.20'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount21	= Sum(Case When A.PrdDate = @ps_prdmonth + '.21'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount22	= Sum(Case When A.PrdDate = @ps_prdmonth + '.22'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount23	= Sum(Case When A.PrdDate = @ps_prdmonth + '.23'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount24	= Sum(Case When A.PrdDate = @ps_prdmonth + '.24'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount25	= Sum(Case When A.PrdDate = @ps_prdmonth + '.25'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount26	= Sum(Case When A.PrdDate = @ps_prdmonth + '.26'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount27	= Sum(Case When A.PrdDate = @ps_prdmonth + '.27'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount28	= Sum(Case When A.PrdDate = @ps_prdmonth + '.28'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount29	= Sum(Case When A.PrdDate = @ps_prdmonth + '.29'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount30	= Sum(Case When A.PrdDate = @ps_prdmonth + '.30'  Then IsNull(A.PrdCount, 0) Else 0 End),
	PrdCount31	= Sum(Case When A.PrdDate = @ps_prdmonth + '.31'  Then IsNull(A.PrdCount, 0) Else 0 End),
	DifferentCount	= Sum(A.DifferentCount),
	DifferentCount01	= Sum(Case When A.PrdDate = @ps_prdmonth + '.01'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount02	= Sum(Case When A.PrdDate = @ps_prdmonth + '.02'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount03	= Sum(Case When A.PrdDate = @ps_prdmonth + '.03'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount04	= Sum(Case When A.PrdDate = @ps_prdmonth + '.04'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount05	= Sum(Case When A.PrdDate = @ps_prdmonth + '.05'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount06	= Sum(Case When A.PrdDate = @ps_prdmonth + '.06'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount07	= Sum(Case When A.PrdDate = @ps_prdmonth + '.07'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount08	= Sum(Case When A.PrdDate = @ps_prdmonth + '.08'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount09	= Sum(Case When A.PrdDate = @ps_prdmonth + '.09'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount10	= Sum(Case When A.PrdDate = @ps_prdmonth + '.10'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount11	= Sum(Case When A.PrdDate = @ps_prdmonth + '.11'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount12	= Sum(Case When A.PrdDate = @ps_prdmonth + '.12'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount13	= Sum(Case When A.PrdDate = @ps_prdmonth + '.13'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount14	= Sum(Case When A.PrdDate = @ps_prdmonth + '.14'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount15	= Sum(Case When A.PrdDate = @ps_prdmonth + '.15'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount16	= Sum(Case When A.PrdDate = @ps_prdmonth + '.16'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount17	= Sum(Case When A.PrdDate = @ps_prdmonth + '.17'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount18	= Sum(Case When A.PrdDate = @ps_prdmonth + '.18'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount19	= Sum(Case When A.PrdDate = @ps_prdmonth + '.19'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount20	= Sum(Case When A.PrdDate = @ps_prdmonth + '.20'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount21	= Sum(Case When A.PrdDate = @ps_prdmonth + '.21'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount22	= Sum(Case When A.PrdDate = @ps_prdmonth + '.22'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount23	= Sum(Case When A.PrdDate = @ps_prdmonth + '.23'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount24	= Sum(Case When A.PrdDate = @ps_prdmonth + '.24'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount25	= Sum(Case When A.PrdDate = @ps_prdmonth + '.25'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount26	= Sum(Case When A.PrdDate = @ps_prdmonth + '.26'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount27	= Sum(Case When A.PrdDate = @ps_prdmonth + '.27'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount28	= Sum(Case When A.PrdDate = @ps_prdmonth + '.28'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount29	= Sum(Case When A.PrdDate = @ps_prdmonth + '.29'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount30	= Sum(Case When A.PrdDate = @ps_prdmonth + '.30'  Then IsNull(A.DifferentCount, 0) Else 0 End),
	DifferentCount31	= Sum(Case When A.PrdDate = @ps_prdmonth + '.31'  Then IsNull(A.DifferentCount, 0) Else 0 End)

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
	ReleaseCount13	= Sum(A.ReleaseCount13),
	ReleaseCount14	= Sum(A.ReleaseCount14),
	ReleaseCount15	= Sum(A.ReleaseCount15),
	ReleaseCount16	= Sum(A.ReleaseCount16),
	ReleaseCount17	= Sum(A.ReleaseCount17),
	ReleaseCount18	= Sum(A.ReleaseCount18),
	ReleaseCount19	= Sum(A.ReleaseCount19),
	ReleaseCount20	= Sum(A.ReleaseCount20),
	ReleaseCount21	= Sum(A.ReleaseCount21),
	ReleaseCount22	= Sum(A.ReleaseCount22),
	ReleaseCount23	= Sum(A.ReleaseCount23),
	ReleaseCount24	= Sum(A.ReleaseCount24),
	ReleaseCount25	= Sum(A.ReleaseCount25),
	ReleaseCount26	= Sum(A.ReleaseCount26),
	ReleaseCount27	= Sum(A.ReleaseCount27),
	ReleaseCount28	= Sum(A.ReleaseCount28),
	ReleaseCount29	= Sum(A.ReleaseCount29),
	ReleaseCount30	= Sum(A.ReleaseCount30),
	ReleaseCount31	= Sum(A.ReleaseCount31),
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
	PrdCount13	= Sum(A.PrdCount13),
	PrdCount14	= Sum(A.PrdCount14),
	PrdCount15	= Sum(A.PrdCount15),
	PrdCount16	= Sum(A.PrdCount16),
	PrdCount17	= Sum(A.PrdCount17),
	PrdCount18	= Sum(A.PrdCount18),
	PrdCount19	= Sum(A.PrdCount19),
	PrdCount20	= Sum(A.PrdCount20),
	PrdCount21	= Sum(A.PrdCount21),
	PrdCount22	= Sum(A.PrdCount22),
	PrdCount23	= Sum(A.PrdCount23),
	PrdCount24	= Sum(A.PrdCount24),
	PrdCount25	= Sum(A.PrdCount25),
	PrdCount26	= Sum(A.PrdCount26),
	PrdCount27	= Sum(A.PrdCount27),
	PrdCount28	= Sum(A.PrdCount28),
	PrdCount29	= Sum(A.PrdCount29),
	PrdCount30	= Sum(A.PrdCount30),
	PrdCount31	= Sum(A.PrdCount31),
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
	DifferentCount12	= Sum(A.DifferentCount12),
	DifferentCount13	= Sum(A.DifferentCount13),
	DifferentCount14	= Sum(A.DifferentCount14),
	DifferentCount15	= Sum(A.DifferentCount15),
	DifferentCount16	= Sum(A.DifferentCount16),
	DifferentCount17	= Sum(A.DifferentCount17),
	DifferentCount18	= Sum(A.DifferentCount18),
	DifferentCount19	= Sum(A.DifferentCount19),
	DifferentCount20	= Sum(A.DifferentCount20),
	DifferentCount21	= Sum(A.DifferentCount21),
	DifferentCount22	= Sum(A.DifferentCount22),
	DifferentCount23	= Sum(A.DifferentCount23),
	DifferentCount24	= Sum(A.DifferentCount24),
	DifferentCount25	= Sum(A.DifferentCount25),
	DifferentCount26	= Sum(A.DifferentCount26),
	DifferentCount27	= Sum(A.DifferentCount27),
	DifferentCount28	= Sum(A.DifferentCount28),
	DifferentCount29	= Sum(A.DifferentCount29),
	DifferentCount30	= Sum(A.DifferentCount30),
	DifferentCount31	= Sum(A.DifferentCount31)
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