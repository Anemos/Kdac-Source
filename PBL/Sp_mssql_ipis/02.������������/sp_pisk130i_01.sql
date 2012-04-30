/*
	File Name	: sp_pisk130i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk130i_01
	Description	: 일별 평준화 준수율
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk130i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk130i_01]
GO

/*
Execute sp_pisk130i_01
	@ps_prdmonth		= '2002.11',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'

select * from tprdratecycle
 where itemcode = '0000001'
select * from tplanday

select linecode, itemcode, sum(releasekbcount)
from tplanrelease
where plandate = '2002.10.14'
group by linecode, itemcode

dbcc opentran

*/

Create Procedure sp_pisk130i_01
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
	HitCount			= A.HitCount
Into	#tmp_item
From	tprdratecycle	A
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
	HitCount			= Sum(A.HitCount)
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
	HitCount		= Sum(A.HitCount),
	HitCount01	= Sum(Case When A.PrdDate = @ps_prdmonth + '.01'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount02	= Sum(Case When A.PrdDate = @ps_prdmonth + '.02'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount03	= Sum(Case When A.PrdDate = @ps_prdmonth + '.03'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount04	= Sum(Case When A.PrdDate = @ps_prdmonth + '.04'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount05	= Sum(Case When A.PrdDate = @ps_prdmonth + '.05'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount06	= Sum(Case When A.PrdDate = @ps_prdmonth + '.06'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount07	= Sum(Case When A.PrdDate = @ps_prdmonth + '.07'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount08	= Sum(Case When A.PrdDate = @ps_prdmonth + '.08'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount09	= Sum(Case When A.PrdDate = @ps_prdmonth + '.09'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount10	= Sum(Case When A.PrdDate = @ps_prdmonth + '.10'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount11	= Sum(Case When A.PrdDate = @ps_prdmonth + '.11'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount12	= Sum(Case When A.PrdDate = @ps_prdmonth + '.12'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount13	= Sum(Case When A.PrdDate = @ps_prdmonth + '.13'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount14	= Sum(Case When A.PrdDate = @ps_prdmonth + '.14'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount15	= Sum(Case When A.PrdDate = @ps_prdmonth + '.15'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount16	= Sum(Case When A.PrdDate = @ps_prdmonth + '.16'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount17	= Sum(Case When A.PrdDate = @ps_prdmonth + '.17'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount18	= Sum(Case When A.PrdDate = @ps_prdmonth + '.18'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount19	= Sum(Case When A.PrdDate = @ps_prdmonth + '.19'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount20	= Sum(Case When A.PrdDate = @ps_prdmonth + '.20'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount21	= Sum(Case When A.PrdDate = @ps_prdmonth + '.21'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount22	= Sum(Case When A.PrdDate = @ps_prdmonth + '.22'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount23	= Sum(Case When A.PrdDate = @ps_prdmonth + '.23'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount24	= Sum(Case When A.PrdDate = @ps_prdmonth + '.24'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount25	= Sum(Case When A.PrdDate = @ps_prdmonth + '.25'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount26	= Sum(Case When A.PrdDate = @ps_prdmonth + '.26'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount27	= Sum(Case When A.PrdDate = @ps_prdmonth + '.27'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount28	= Sum(Case When A.PrdDate = @ps_prdmonth + '.28'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount29	= Sum(Case When A.PrdDate = @ps_prdmonth + '.29'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount30	= Sum(Case When A.PrdDate = @ps_prdmonth + '.30'  Then IsNull(A.HitCount, 0) Else 0 End),
	HitCount31	= Sum(Case When A.PrdDate = @ps_prdmonth + '.31'  Then IsNull(A.HitCount, 0) Else 0 End)
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
	HitCount12	= Sum(A.HitCount12),
	HitCount13	= Sum(A.HitCount13),
	HitCount14	= Sum(A.HitCount14),
	HitCount15	= Sum(A.HitCount15),
	HitCount16	= Sum(A.HitCount16),
	HitCount17	= Sum(A.HitCount17),
	HitCount18	= Sum(A.HitCount18),
	HitCount19	= Sum(A.HitCount19),
	HitCount20	= Sum(A.HitCount20),
	HitCount21	= Sum(A.HitCount21),
	HitCount22	= Sum(A.HitCount22),
	HitCount23	= Sum(A.HitCount23),
	HitCount24	= Sum(A.HitCount24),
	HitCount25	= Sum(A.HitCount25),
	HitCount26	= Sum(A.HitCount26),
	HitCount27	= Sum(A.HitCount27),
	HitCount28	= Sum(A.HitCount28),
	HitCount29	= Sum(A.HitCount29),
	HitCount30	= Sum(A.HitCount30),
	HitCount31	= Sum(A.HitCount31)
From	#tmp_result	A,
	vmstline		B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode
Group By A.AreaCode, B.AreaName, A.DivisionCode, B.DivisionName, A.WorkCenter, B.WorkCenterName,
	A.LineCode, B.LineShortName, B.LineFullName, A.ReleaseCount, A.HitCount


drop table #tmp_item
drop table #tmp_count
drop table #tmp_result


Return

End		-- Procedure End

Go