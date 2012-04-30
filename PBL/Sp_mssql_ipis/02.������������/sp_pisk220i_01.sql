/*
	File Name	: sp_pisk220i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk220i_01
	Description	: 시간대별 생산 현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk220i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk220i_01]
GO

/*
Execute sp_pisk220i_01
	@ps_prddate		= '2002.10.15',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tprdtime
 where itemcode = '0000001'
select * from tplanday

select linecode, itemcode, sum(releasekbcount)
from tplanrelease
where plandate = '2002.10.14'
group by linecode, itemcode

dbcc opentran

*/

Create Procedure sp_pisk220i_01
	@ps_prddate		char(10),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

Select	PrdDate		= A.PrdDate,
	AreaCode	= A.AreaCode,		-- 지역코드
	DivisionCode	= A.DivisionCode,		-- 공장
	WorkCenter	= A.WorkCenter,		-- Work Center
	LineCode	= A.LineCode,		-- 라인
	ItemCode	= A.ItemCode,
	ApplyFrom	= A.ApplyFrom,
	TimeCode	= A.TimeCode,
	PrdQty		= Sum(IsNull(A.PrdQty, 0))
Into	#tmp_prd
From	tprdtime		A
Where	A.PrdDate	= @ps_prddate		And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode
Group by A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode, A.ApplyFrom, A.TimeCode


Select	PrdDate		= A.PrdDate,
	AreaCode	= A.AreaCode,		-- 지역코드
	DivisionCode	= A.DivisionCode,		-- 공장
	WorkCenter	= A.WorkCenter,		-- Work Center
	LineCode	= A.LineCode,		-- 라인
	ItemCode	= A.ItemCode,
	PrdQty01	= Sum(Case When A.TimeCode = '08:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty02	= Sum(Case When A.TimeCode = '09:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty03	= Sum(Case When A.TimeCode = '10:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty04	= Sum(Case When A.TimeCode = '11:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty05	= Sum(Case When A.TimeCode = '12:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty06	= Sum(Case When A.TimeCode = '13:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty07	= Sum(Case When A.TimeCode = '14:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty08	= Sum(Case When A.TimeCode = '15:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty09	= Sum(Case When A.TimeCode = '16:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty10	= Sum(Case When A.TimeCode = '17:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty11	= Sum(Case When A.TimeCode = '18:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty12	= Sum(Case When A.TimeCode = '19:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty13	= Sum(Case When A.TimeCode = '20:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty14	= Sum(Case When A.TimeCode = '21:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty15	= Sum(Case When A.TimeCode = '22:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty16	= Sum(Case When A.TimeCode = '23:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty17	= Sum(Case When A.TimeCode = '24:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty18	= Sum(Case When A.TimeCode = '01:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty19	= Sum(Case When A.TimeCode = '02:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty20	= Sum(Case When A.TimeCode = '03:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty21	= Sum(Case When A.TimeCode = '04:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty22	= Sum(Case When A.TimeCode = '05:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty23	= Sum(Case When A.TimeCode = '06:00'  Then IsNull(A.PrdQty, 0) Else 0 End),
	PrdQty24	= Sum(Case When A.TimeCode = '07:00'  Then IsNull(A.PrdQty, 0) Else 0 End)
Into	#tmp_result
From	#tmp_prd	A
Group by A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode


Select	PrdDate		= A.PrdDate,
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
	PrdQty24	= Sum(A.PrdQty24)
From	#tmp_result	A,
	vmstkb_line	B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode
Group By A.PrdDate, A.AreaCode, B.AreaName, A.DivisionCode, B.DivisionName, A.WorkCenter, B.WorkCenterName,
	A.LineCode, B.LineShortName, B.LineFullName, A.ItemCode, B.ItemName, B.ModelID


drop table #tmp_prd

Return

End		-- Procedure End
Go
