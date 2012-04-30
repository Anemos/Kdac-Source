/*
	File Name	: sp_pisp260i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp260i_01
	Description	: 간판 번호 정보
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 10
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp260i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp260i_01]
GO

/*
Execute sp_pisp260i_01
	@ps_kbno	= 'DA010001001'

select * from tcalendarwork
select * from tplanday


dbcc opentran

*/

Create Procedure sp_pisp260i_01
	@ps_kbno	varchar(11)

As
Begin

-- vmstkb_line 에서 시작한 것
-- 조회조건의 제품을 구하자.
Select	AreaCode		= B.AreaCode,		-- 지역코드
	AreaName		= B.AreaName,		-- 지역 명
	DivisionCode		= B.DivisionCode,		-- 공장
	DivisionName		= B.DivisionName,	-- 공장명
	WorkCenter		= B.WorkCenter,		-- Work Center
	WorkCenterName		= B.WorkCenterName,	-- Work Center 명
	LineCode		= B.LineCode,		-- 라인
	LineShortName		= B.LineShortName,	-- 라인 약명
	LineFullName		= B.LineFullName,		-- 라인 전명
	ItemCode		= B.ItemCode,		-- 품번
	ItemName		= B.ItemName,		-- 품명
	ModelID			= B.ModelID,		-- 배번호
	ProductGubun		= B.ProductGubun,
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '계획생산품'
					When B.ProductGubun = 'R'	Then '후보충생산품'
					Else 'OEM생산품'
				   End,

	ApplyFrom		= A.ApplyFrom,
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
	ASGubun		= A.ASGubun,
	ASGubunName		= Case	When A.ASGubun = 'N'	Then '정상품'
					Else 'A/S품'
				   End,	
	KBActiveGubun		= A.KBActiveGubun,
	KBActiveGubunName	= Case	When A.KBActiveGubun = 'A'	Then 'Active'
					Else 'Sleeping'
				   End,
	KBCreateTime		= A.KBCreateTime,
	KBPrintTime		= A.KBPrintTime,
	PrintCount		= A.PrintCount,
	RackQty			= A.RackQty,
	CurrentQty		= A.CurrentQty,
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
	StockGubunName	= Case	When A.StockGubun = 'Y'	Then '창고입고등록'
					When A.StockGubun = 'N'	Then '현장입고등록'
					When A.StockGubun = 'B'	Then '공정회수'
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
	ShipQty			= A.ShipQty,
	KBReleaseTime		= A.KBReleaseTime,
	KBStartTime		= A.KBStartTime,
	KBEndTime		= A.KBEndTime,
	KBInspectTime		= A.KBInspectTime,
	KBStockTime		= A.KBStockTime,
	KBShipTime		= A.KBShipTime,
	KBBackTime		= A.KBBackTime,
	LastEmp			= A.LastEmp,
	LastDate			= A.LastDate
From	tkb		A,
	vmstkb_line	B--,
--	vmstline		C
Where	A.KBNo		= @ps_kbno		And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode	--	And
--	A.PrdAreaCode		*= C.AreaCode		And
--	A.PrdDivisionCode	*= C.DivisionCode	And
--	A.PrdWorkCenter		*= C.WorkCenter		And
--	A.PrdLineCode		*= C.LineCode

Return

End		-- Procedure End
Go
