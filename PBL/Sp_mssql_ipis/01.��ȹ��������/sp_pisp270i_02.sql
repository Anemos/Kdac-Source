/*
	File Name	: sp_pisp270i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp270i_02
	Description	: 간판 번호 List - 간판번호 상세 내역
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp270i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp270i_02]
GO

/*
Execute sp_pisp270i_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= 'A',
	@ps_itemcode		= '511513'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp270i_02
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

-- vmstkb_line 에서 시작한 것
-- 조회조건의 제품을 구하자.
Select	KBNo			= A.KBNo,
	KBActiveGubun		= A.KBActiveGubun,
	KBActiveGubunName	= Case	When A.KBActiveGubun = 'A'	Then 'Active'
					Else 'Sleeping'
				   End,
	KBStatusCode		= A.KBStatusCode,
	KBStatusCodeName	= Case	When A.KBActiveGubun = 'A'	Then
						Case	When A.KBStatusCode = 'A'	Then '지시'
							When A.KBStatusCode = 'B'	Then '착수'
							When A.KBStatusCode = 'C'	Then '완료'
							When A.KBStatusCode = 'D'	Then '입고'
							When A.KBStatusCode = 'E'	Then '출하'
							When A.KBStatusCode = 'F'	Then '회수'
						Else ''
						End
				   Else ''
				   End,
	TempGubun		= A.TempGubun,
	TempGubunName	= Case	When A.TempGubun = 'N'	Then '정규'
					Else '임시'
				   End,
	RackQty			= A.RackQty,
	CurrentQty		= A.CurrentQty,
	KBReleaseTime		= A.KBReleaseTime,
	KBStartTime		= A.KBStartTime,
	KBEndTime		= A.KBEndTime,
	KBInspectTime		= A.KBInspectTime,
	KBStockTime		= A.KBStockTime,
	KBShipTime		= A.KBShipTime,
	KBBackTime		= A.KBBackTime,
	KBCreateTime		= A.KBCreateTime,
	KBPrintTime		= A.KBPrintTime,
	PrintCount		= A.PrintCount,
	ReleaseGubun		= A.ReleaseGubun,
	ReleaseGubunName	= Case	When A.ReleaseGubun	= 'N'	Then '무간판생산'
					When A.ReleaseGubun	= 'Y'	Then '정상지시'
					When A.ReleaseGubun	= 'T'	Then '긴급지시'
					When A.ReleaseGubun	= 'U'	Then '미준수'
					Else ''
				   End,
	ReleaseCancel		= A.ReleaseCancel,
	ReleaseCancelName	= Case	When A.ReleaseCancel	= 'Y'	Then '지시취소'
					Else ''
				   End,
	PrdFlag			= A.PrdFlag,
	PrdFlagName		= Case	When A.PrdFlag		= 'E'	Then '생산완료'
					When A.PrdFlag		= 'N'	Then '지시상태'
					Else ''
				   End,
--	InspectGubun		= A.InspectGubun,
--	InspectGubunName	= Case	When B.ItemCode Is Null	Then '무검사입고품'
--					Else '입고검사품'
--				   End,
	InspectFlag		= A.InspectFlag,
	InspectFlagName		= Case	When A.InspectFlag	= 'Y'	Then '입고검사완료'
					Else ''
				   End,
	StockGubun		= A.StockGubun,
	StockGubunName	= Case	When A.StockGubun = 'Y'	Then '입고등록품'
					When A.StockGubun = 'N'	Then '무등록입고품'
					When A.StockGubun = 'B'	Then '후공정회수품'
					Else ''
				   End,
	StockCancel		= A.StockCancel,
	StockCancelName	= Case	When A.StockCancel	= 'Y'	Then '입고취소'
					Else ''
				   End,
	PlanDate		= A.PlanDate,
	PrdDate			= A.PrdDate,
	PrdAreaCode		= A.PrdAreaCode,
	PrdAreaName		= '', --C.AreaName,
	PrdDivisionCode		= A.PrdDivisionCode,
	PrdDivisionName		= '', --C.DivisionName,
	PrdWorkCenter		= A.PrdWorkCenter,
	PrdWorkCenterName	= '', --C.WorkCenterName,
	PrdLineCode		= A.PrdLineCode,
	PrdLineShortName	= '', --C.LineShortName,
	PrdLineFullName		= '', --C.LineFullName,
	TimeApplyFrom		= A.TimeApplyFrom,
	TimeCode		= A.TimeCode,
	PrdQty			= A.PrdQty,
	LotNo			= A.LotNo,
	StockDate		= A.StockDate,
	StockQty			= A.StockQty,
	ShipDate		= A.ShipDate,
	ShipQty			= A.ShipQty
From	tkb		A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ItemCode	= @ps_itemcode

Return

End		-- Procedure End
Go
