/*
	File Name	: sp_pisk230i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk230i_01
	Description	: 일별 생산 추이 (라인별)
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk230i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk230i_01]
GO

/*
Execute sp_pisk230i_01
	@ps_prdmonth		= '2002.10',
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

Create Procedure sp_pisk230i_01
	@ps_prdmonth		char(7),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

Select	PrdDate		= A.PlanDate,
	AreaCode	= A.AreaCode,		-- 지역코드
	DivisionCode	= A.DivisionCode,		-- 공장
	WorkCenter	= A.WorkCenter,		-- Work Center
	LineCode	= A.LineCode,		-- 라인
	ItemCode	= A.ItemCode,
	PlanQty		= Sum(A.PlanQty),
	PrdQty		= IsNull(Sum(IsNull(B.PrdQty, 0)), 0)
Into	#tmp_prd
From	(Select	PlanDate		= A.PlanDate,
		AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
		WorkCenter		= A.WorkCenter,		-- Work Center
		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PlanQty			= Sum(A.ReleaseKBQty)
	From	tplanrelease	A
	Where	A.PlanDate	Like @ps_prdmonth + '.__'	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	Like @ps_workcenter	And
		A.LineCode	Like @ps_linecode	And
		A.ItemCode	Like @ps_itemcode	And
	--	A.ReleaseGubun	In ('Y', 'T', 'U', 'N')
		A.ReleaseGubun	> 'C'
	Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode)	A,	
	(Select	PrdDate			= A.PrdDate,
		AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
		WorkCenter		= A.WorkCenter,		-- Work Center
		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PrdQty			= Sum(A.PrdQty)
	From	tprd		A
	Where	A.PrdDate	Like @ps_prdmonth + '.__'	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	Like @ps_workcenter	And
		A.LineCode	Like @ps_linecode	And
		A.ItemCode	Like @ps_itemcode
	Group By A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode)	B
Where	A.PlanDate	*= B.PrdDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode

Select	PrdMonth	= @ps_prdmonth,
	AreaCode	= A.AreaCode,		-- 지역코드
	DivisionCode	= A.DivisionCode,		-- 공장
	WorkCenter	= A.WorkCenter,		-- Work Center
	LineCode	= A.LineCode,		-- 라인
	ItemCode	= A.ItemCode,
	PlanQty01	= Sum(Case When A.PrdDate = @ps_prdmonth + '.01'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty02	= Sum(Case When A.PrdDate = @ps_prdmonth + '.02'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty03	= Sum(Case When A.PrdDate = @ps_prdmonth + '.03'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty04	= Sum(Case When A.PrdDate = @ps_prdmonth + '.04'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty05	= Sum(Case When A.PrdDate = @ps_prdmonth + '.05'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty06	= Sum(Case When A.PrdDate = @ps_prdmonth + '.06'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty07	= Sum(Case When A.PrdDate = @ps_prdmonth + '.07'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty08	= Sum(Case When A.PrdDate = @ps_prdmonth + '.08'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty09	= Sum(Case When A.PrdDate = @ps_prdmonth + '.09'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty10	= Sum(Case When A.PrdDate = @ps_prdmonth + '.10'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty11	= Sum(Case When A.PrdDate = @ps_prdmonth + '.11'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty12	= Sum(Case When A.PrdDate = @ps_prdmonth + '.12'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty13	= Sum(Case When A.PrdDate = @ps_prdmonth + '.13'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty14	= Sum(Case When A.PrdDate = @ps_prdmonth + '.14'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty15	= Sum(Case When A.PrdDate = @ps_prdmonth + '.15'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty16	= Sum(Case When A.PrdDate = @ps_prdmonth + '.16'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty17	= Sum(Case When A.PrdDate = @ps_prdmonth + '.17'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty18	= Sum(Case When A.PrdDate = @ps_prdmonth + '.18'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty19	= Sum(Case When A.PrdDate = @ps_prdmonth + '.19'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty20	= Sum(Case When A.PrdDate = @ps_prdmonth + '.20'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty21	= Sum(Case When A.PrdDate = @ps_prdmonth + '.21'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty22	= Sum(Case When A.PrdDate = @ps_prdmonth + '.22'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty23	= Sum(Case When A.PrdDate = @ps_prdmonth + '.23'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty24	= Sum(Case When A.PrdDate = @ps_prdmonth + '.24'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty25	= Sum(Case When A.PrdDate = @ps_prdmonth + '.25'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty26	= Sum(Case When A.PrdDate = @ps_prdmonth + '.26'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty27	= Sum(Case When A.PrdDate = @ps_prdmonth + '.27'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty28	= Sum(Case When A.PrdDate = @ps_prdmonth + '.28'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty29	= Sum(Case When A.PrdDate = @ps_prdmonth + '.29'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty30	= Sum(Case When A.PrdDate = @ps_prdmonth + '.30'  Then IsNull(A.PlanQty, 0) Else 0 End),
	PlanQty31	= Sum(Case When A.PrdDate = @ps_prdmonth + '.31'  Then IsNull(A.PlanQty, 0) Else 0 End),

	PrdQty01	= Sum(Case When A.PrdDate = @ps_prdmonth + '.01'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty02	= Sum(Case When A.PrdDate = @ps_prdmonth + '.02'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty03	= Sum(Case When A.PrdDate = @ps_prdmonth + '.03'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty04	= Sum(Case When A.PrdDate = @ps_prdmonth + '.04'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty05	= Sum(Case When A.PrdDate = @ps_prdmonth + '.05'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty06	= Sum(Case When A.PrdDate = @ps_prdmonth + '.06'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty07	= Sum(Case When A.PrdDate = @ps_prdmonth + '.07'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty08	= Sum(Case When A.PrdDate = @ps_prdmonth + '.08'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty09	= Sum(Case When A.PrdDate = @ps_prdmonth + '.09'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty10	= Sum(Case When A.PrdDate = @ps_prdmonth + '.10'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty11	= Sum(Case When A.PrdDate = @ps_prdmonth + '.11'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty12	= Sum(Case When A.PrdDate = @ps_prdmonth + '.12'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty13	= Sum(Case When A.PrdDate = @ps_prdmonth + '.13'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty14	= Sum(Case When A.PrdDate = @ps_prdmonth + '.14'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty15	= Sum(Case When A.PrdDate = @ps_prdmonth + '.15'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty16	= Sum(Case When A.PrdDate = @ps_prdmonth + '.16'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty17	= Sum(Case When A.PrdDate = @ps_prdmonth + '.17'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty18	= Sum(Case When A.PrdDate = @ps_prdmonth + '.18'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty19	= Sum(Case When A.PrdDate = @ps_prdmonth + '.19'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty20	= Sum(Case When A.PrdDate = @ps_prdmonth + '.20'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty21	= Sum(Case When A.PrdDate = @ps_prdmonth + '.21'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty22	= Sum(Case When A.PrdDate = @ps_prdmonth + '.22'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty23	= Sum(Case When A.PrdDate = @ps_prdmonth + '.23'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty24	= Sum(Case When A.PrdDate = @ps_prdmonth + '.24'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty25	= Sum(Case When A.PrdDate = @ps_prdmonth + '.25'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty26	= Sum(Case When A.PrdDate = @ps_prdmonth + '.26'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty27	= Sum(Case When A.PrdDate = @ps_prdmonth + '.27'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty28	= Sum(Case When A.PrdDate = @ps_prdmonth + '.28'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty29	= Sum(Case When A.PrdDate = @ps_prdmonth + '.29'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty30	= Sum(Case When A.PrdDate = @ps_prdmonth + '.30'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty31	= Sum(Case When A.PrdDate = @ps_prdmonth + '.31'  Then IsNull(A.PrdQty, 0) Else 0 End)
Into	#tmp_result
From	#tmp_prd	A
Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode


Select	PrdMonth	= A.PrdMonth,
	AreaCode	= A.AreaCode,		-- 지역코드
	AreaName	= B.AreaName,
	DivisionCode	= A.DivisionCode,		-- 공장
	DivisionName	= B.DivisionName,
	WorkCenter	= A.WorkCenter,		-- Work Center
	WorkCenterName	= B.WorkCenterName,
	LineCode	= A.LineCode,		-- 라인
	LineShortName	= B.LineShortName,
	LineFullName	= B.LineFullName,
	ItemCode	= A.ItemCode,
	ItemName	= B.ItemName,
	ModelID		= B.ModelID,
	PlanQty		= Sum(A.PlanQty01) + Sum(A.PlanQty02) + Sum(A.PlanQty03) + Sum(A.PlanQty04) +
				Sum(A.PlanQty05) + Sum(A.PlanQty06) + Sum(A.PlanQty07) + Sum(A.PlanQty08) +
				Sum(A.PlanQty09) + Sum(A.PlanQty10) + Sum(A.PlanQty11) + Sum(A.PlanQty12) +
				Sum(A.PlanQty13) + Sum(A.PlanQty14) + Sum(A.PlanQty15) + Sum(A.PlanQty16) +
				Sum(A.PlanQty17) + Sum(A.PlanQty18) + Sum(A.PlanQty19) + Sum(A.PlanQty20) +
				Sum(A.PlanQty21) + Sum(A.PlanQty22) + Sum(A.PlanQty23) + Sum(A.PlanQty24) +
				Sum(A.PlanQty25) + Sum(A.PlanQty26) + Sum(A.PlanQty27) + Sum(A.PlanQty28) +
				Sum(A.PlanQty29) + Sum(A.PlanQty30) + Sum(A.PlanQty31),
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
	PlanQty13	= Sum(A.PlanQty13),
	PlanQty14	= Sum(A.PlanQty14),
	PlanQty15	= Sum(A.PlanQty15),
	PlanQty16	= Sum(A.PlanQty16),
	PlanQty17	= Sum(A.PlanQty17),
	PlanQty18	= Sum(A.PlanQty18),
	PlanQty19	= Sum(A.PlanQty19),
	PlanQty20	= Sum(A.PlanQty20),
	PlanQty21	= Sum(A.PlanQty21),
	PlanQty22	= Sum(A.PlanQty22),
	PlanQty23	= Sum(A.PlanQty23),
	PlanQty24	= Sum(A.PlanQty24),
	PlanQty25	= Sum(A.PlanQty25),
	PlanQty26	= Sum(A.PlanQty26),
	PlanQty27	= Sum(A.PlanQty27),
	PlanQty28	= Sum(A.PlanQty28),
	PlanQty29	= Sum(A.PlanQty29),
	PlanQty30	= Sum(A.PlanQty30),
	PlanQty31	= Sum(A.PlanQty31),

	PrdQty		= Sum(A.PrdQty01) + Sum(A.PrdQty02) + Sum(A.PrdQty03) + Sum(A.PrdQty04) +
				Sum(A.PrdQty05) + Sum(A.PrdQty06) + Sum(A.PrdQty07) + Sum(A.PrdQty08) +
				Sum(A.PrdQty09) + Sum(A.PrdQty10) + Sum(A.PrdQty11) + Sum(A.PrdQty12) +
				Sum(A.PrdQty13) + Sum(A.PrdQty14) + Sum(A.PrdQty15) + Sum(A.PrdQty16) +
				Sum(A.PrdQty17) + Sum(A.PrdQty18) + Sum(A.PrdQty19) + Sum(A.PrdQty20) +
				Sum(A.PrdQty21) + Sum(A.PrdQty22) + Sum(A.PrdQty23) + Sum(A.PrdQty24) +
				Sum(A.PrdQty25) + Sum(A.PrdQty26) + Sum(A.PrdQty27) + Sum(A.PrdQty28) +
				Sum(A.PrdQty29) + Sum(A.PrdQty30) + Sum(A.PrdQty31),
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
	PrdQty12	= Sum(A.PrdQty12),
	PrdQty13	= Sum(A.PrdQty13),
	PrdQty14	= Sum(A.PrdQty14),
	PrdQty15	= Sum(A.PrdQty15),
	PrdQty16	= Sum(A.PrdQty16),
	PrdQty17	= Sum(A.PrdQty17),
	PrdQty18	= Sum(A.PrdQty18),
	PrdQty19	= Sum(A.PrdQty19),
	PrdQty20	= Sum(A.PrdQty20),
	PrdQty21	= Sum(A.PrdQty21),
	PrdQty22	= Sum(A.PrdQty22),
	PrdQty23	= Sum(A.PrdQty23),
	PrdQty24	= Sum(A.PrdQty24),
	PrdQty25	= Sum(A.PrdQty25),
	PrdQty26	= Sum(A.PrdQty26),
	PrdQty27	= Sum(A.PrdQty27),
	PrdQty28	= Sum(A.PrdQty28),
	PrdQty29	= Sum(A.PrdQty29),
	PrdQty30	= Sum(A.PrdQty30),
	PrdQty31	= Sum(A.PrdQty31)
From	#tmp_result	A,
	vmstkb_line	B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode
Group By A.PrdMonth, A.AreaCode, B.AreaName, A.DivisionCode, B.DivisionName, A.WorkCenter, B.WorkCenterName,
	A.LineCode, B.LineShortName, B.LineFullName, A.ItemCode, B.ItemName, B.ModelID


drop table #tmp_prd
drop table #tmp_result

Return

End		-- Procedure End
Go
