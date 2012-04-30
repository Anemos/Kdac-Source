/*
	File Name	: sp_pisp220i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp220i_02
	Description	: 간판 마스터 이력 조회 - 상세정보
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 07
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp220i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp220i_02]
GO

/*
Execute sp_pisp220i_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_workcenter		= '731J',
	@ps_linecode		= 'A',
	@ps_itemcode		= '512464',
	@ps_applyfrom		= '2002.10.01',
	@ps_applyto		= '9999.12.31'

select * from tplanrelease
where prdflag = 'E'

dbcc opentran

*/

Create Procedure sp_pisp220i_02
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12),
	@ps_applyfrom		char(10),
	@ps_applyto		char(10)

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
	AreaName		= B.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= C.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= D.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= E.LineShortName,	-- 라인 약명
	LineFullName		= E.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= F.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ApplyFrom		= A.ApplyFrom,
	ApplyTo			= A.ApplyTo,
	LineID			= A.LineID,
	KBID			= A.KBID,
	NormalKBSN		= A.NormalKBSN,
	TempKBSN		= A.TempKBSN,
	InspectGubun		=  Case	When G.ItemCode Is Null	Then 'N'
					Else 'Y'
				   End,	-- 입고 검사 구분
	StockGubun		= A.StockGubun,
	PrdStopGubun		= A.PrdStopGubun,
	RackCode		= A.RackCode,
	RackQty			= A.RackQty,
	LotSize			= A.LotSize,
	CarName		= A.CarName,
	MainLineGubun		= A.MainLineGubun,
	DivideRate		= A.DivideRate,
	PCSPerHour		= A.PCSPerHour,
	SafetyInvQty		= A.SafetyInvQty,
	KBFactor		= A.KBFactor,
	SafetyFactor		= A.SafetyFactor,
	StockLocation		= A.StockLocation,
	SortOrder		= A.SortOrder,
	LastEmp			= A.LastEmp,
	LastDate			= A.LastDate
From	tmstkbhis	A,
	tmstarea		B,
	tmstdivision	C,
	tmstworkcenter	D,
	tmstline		E,
	tmstitem		F,
	tqcontainqcitem	G
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	= @ps_workcenter	And
	A.LineCode	= @ps_linecode		And
	A.ItemCode	= @ps_itemcode		And
	A.ApplyFrom	= @ps_applyfrom		And
	A.ApplyTo	= @ps_applyto		And

	A.AreaCode	= B.AreaCode		And

	A.AreaCode	= C.AreaCode		And
	A.DivisionCode	= C.DivisionCode		And

	A.AreaCode	= D.AreaCode		And
	A.DivisionCode	= D.DivisionCode		And
	A.WorkCenter	= D.WorkCenter		And

	A.AreaCode	= E.AreaCode		And
	A.DivisionCode	= E.DivisionCode		And
	A.WorkCenter	= E.WorkCenter		And
	A.LineCode	= E.LineCode		And

	A.ItemCode	= F.ItemCode		And

	A.AreaCode	*= G.AreaCode		And
	A.DivisionCode	*= G.DivisionCode	And
	A.ItemCode	*= G.ItemCode		And
	G.ApplyDateFrom	<= @ls_applydate_close	And
	G.ApplyDateTo	> @ls_applydate_close

/*
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.SortOrder, A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty, A.ApplyFrom, A.PrdStopGubun, A.MainLineGubun, A.DivideRate,
	A.SafetyInvQty, A.InspectGubun, A.StockGubun
*/

Return

End		-- Procedure End
Go
