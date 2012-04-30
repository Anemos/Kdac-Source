/*
	File Name	: sp_pisp210u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp210u_01
	Description	: 간판 마스터 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 02
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp210u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp210u_01]
GO

/*
Execute sp_pisp210u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%',
	@ps_prdstopgubun	= '%'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp210u_01
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_prdstopgubun	char(1)

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
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산'
					When A.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	RackQty			= A.RackQty,
	ApplyFrom		= A.ApplyFrom,
	PrdStopGubun		= A.PrdStopGubun,	-- 생산 중단 구분
	PrdStopGubunName	= Case	When A.PrdStopGubun = 'N'	Then '생산중'
					Else '생산중단'
				   End,
	MainLineGubun		= A.MainLineGubun,	-- 주라인 구분
	MainLineGubunName	= Case	When A.MainLineGubun = 'M'	Then '주라인'
					Else '부라인'
				   End,
	DivideRate		= A.DivideRate,		-- 계획분배율
	SafetyInvQty		= A.SafetyInvQty,		-- 안전재고
	InspectGubun		=  Case	When B.ItemCode Is Null	Then 'N'
					Else 'Y'
				   End,	-- 입고 검사 구분
	InspectGubunName	= Case	When B.ItemCode Is Null	Then '무검사입고품'
					Else '입고검사품'
				   End,
	StockGubun		= A.StockGubun,		-- 입고 등록 구분
	StockGubunName	= Case	When A.StockGubun = 'Y'	Then '창고입고등록'
					When A.StockGubun = 'N'	Then '현장입고등록'
					When A.StockGubun = 'B'	Then '공정회수'
					Else ''
				   End,
	SortOrder		= A.SortOrder
From	vmstkb_line	A,
	tqcontainqcitem	B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
	A.PrdStopGubun	Like @ps_prdstopgubun	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode		And
	B.ApplyDateFrom	<= @ls_applydate_close	And
	B.ApplyDateTo	> @ls_applydate_close
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty, A.ApplyFrom, A.PrdStopGubun, A.MainLineGubun, A.DivideRate,
	A.SafetyInvQty, A.StockGubun, B.ItemCode
Order By A.AreaCode, A.DivisionCode, A.WorkCenter,	A.LineCode, A.SortOrder

Return

End		-- Procedure End
Go
