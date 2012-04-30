/*
	File Name	: sp_pisp220i_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp220i_01
	Description	: 간판 마스터 이력 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 02
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp220i_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp220i_01]
GO

/*
Execute sp_pisp220i_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tqcontainqcitem

dbcc opentran

*/

Create Procedure sp_pisp220i_01
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

Declare	@ldt_nowtime		datetime,	-- 지준일을 구하기 위한 현재 일시
	@ls_applydate_close	char(10)	-- 마감일을 고려한 기준일자

-- 일단 기준일을 구하자
Select	@ldt_nowtime	= GetDate()

Exec	sp_pisc_get_applydate_close
	@ps_areacode		= @ps_areacode,
	@ps_divisioncode	= @ps_divisioncode,
	@pdt_sourcedate		= @ldt_nowtime,
	@rs_applydate		= @ls_applydate_close	output


Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	InspectGubun		= Case	When B.ItemCode Is Null	Then 'N'
					Else 'Y'
				   End
Into	#tmp_kb
From	vmstkb_line	A,
	tqcontainqcitem	B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
--	A.PrdStopGubun	Like @ps_prdstopgubun	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode		And
	B.ApplyDateFrom	<= @ls_applydate_close	And
	B.ApplyDateTo	> @ls_applydate_close
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, B.ItemCode


Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ApplyFrom		= B.ApplyFrom,
	ApplyTo			= B.ApplyTo,
	ModelID			= B.ModelID,
	ProductGubun		= B.ProductGubun,
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '계획생산'
					When B.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	RackQty			= B.RackQty,
	PrdStopGubun		= B.PrdStopGubun,	-- 생산 중단 구분
	PrdStopGubunName	= Case	When B.PrdStopGubun = 'N'	Then '생산중'
					Else '생산중단'
				   End,
	MainLineGubun		= B.MainLineGubun,	-- 주라인 구분
	MainLineGubunName	= Case	When B.MainLineGubun = 'M'	Then '주라인'
					Else '부라인'
				   End,
	DivideRate		= B.DivideRate,		-- 계획분배율
	SafetyInvQty		= B.SafetyInvQty,		-- 안전재고
	InspectGubun		= A.InspectGubun,
	InspectGubunName	= Case	When A.InspectGubun = 'N' Then '무검사입고품'
					Else '입고검사품'
				   End,
	StockGubun		= B.StockGubun,		-- 입고 등록 구분
	StockGubunName	= Case	When B.StockGubun = 'Y'	Then '창고입고등록'
					When B.StockGubun = 'N'	Then '현장입고등록'
					When B.StockGubun = 'B'	Then '공정회수'
					Else ''
				   End,
	SortOrder		= B.SortOrder
From	#tmp_kb		A,
	tmstkbhis	B
Where	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.LineCode	= B.LineCode		And
	A.ItemCode	= B.ItemCode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, B.SortOrder, A.ItemCode, A.ItemName,
	B.ApplyFrom, B.ApplyTo, B.ModelID,
	B.ProductGubun, B.RackQty, B.PrdStopGubun, B.MainLineGubun, B.DivideRate,
	B.SafetyInvQty, A.InspectGubun, B.StockGubun
Order By A.AreaCode, A.DivisionCode, A.WorkCenter,	A.LineCode, A.ItemCode, B.ApplyTo Desc


Drop Table #tmp_kb

Return

End		-- Procedure End
Go
