/*
	File Name	: sp_pisp060u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp060u_02
	Description	: 일일 생산 계획
			  DDRS 및 S/R 현황을 조회한다.
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 11
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp060u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp060u_02]
GO

/*
Execute sp_pisp060u_02
	@ps_today		= '2002.10.10',
	@ps_planmonth		= '2002.10',
	@ps_plandate		= '2002.10.10',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '4201',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tplanday

update tplanday
set changeqty = 100
where itemcode in ('10456266A', '10456267A')

select *
from tsrorder
where itemcode in ('10456266A',
'10456267A',
'511513',
'511514',
'511517')
*/

Create Procedure sp_pisp060u_02
	@ps_today		char(10),	-- 오늘 일자 (procedure 에서는 사용하지 않음.
						-- 데이터윈도우에서 예상재고를 계산하기 위하여 사용
	@ps_planmonth		char(8),		-- 조회 월 ('YYYY.MM.') (procedure 에서는 사용하지 않음.
						-- 데이터윈도우에서 예상재고를 계산하기 위하여 사용
	@ps_plandate		char(10),	
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)
As
Begin

Declare	@ls_planmonth	char(7)

Select	@ls_planmonth	= Left(@ps_plandate, 7)

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= Case	When A.ProductGubun = 'P'	Then '계획생산'
					When A.ProductGubun = 'R'	Then '후보충생산'
					Else 'OEM생산'
				   End,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= IsNull(B.InvQty, 0),
	InvCompute		= IsNull(B.InvCompute, 1),
	SortOrder		= A.SortOrder
Into	#tmp_item
From	vmstkb_line	A,
	tinv		B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.RackQty, A.SafetyInvQty, B.InvQty, B.InvCompute, A.SortOrder


Select	PlanDate		= B.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	PlanQty			= Sum(IsNull(B.PlanQty, 0)),
	ChangeQty		= Sum(IsNull(B.ChangeQty, 0)),
	SortOrder		= A.SortOrder
Into	#tmp_planqty
From	#tmp_item	A,
	tplanday		B
Where	B.PlanDate	Like @ls_planmonth + '.__'	And
	B.AreaCode	= A.AreaCode			And
	B.DivisionCode	= A.DivisionCode			And
--	B.WorkCenter	= A.WorkCenter			And
--	B.LineCode	= A.LineCode			And
	B.ItemCode	= A.ItemCode
Group By B.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty, A.InvCompute, A.SortOrder


Select	PlanDate		= A.PlanDate,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	PlanQty			= A.PlanQty,
	ChangeQty		= A.ChangeQty,
	SRQty			= Sum(IsNull(B.SRQty, 0)),
	SortOrder		= A.SortOrder
Into	#tmp_srqty
From	#tmp_planqty	A,
	(Select	PlanDate	= A.ShipDate,
		AreaCode	= A.SRAreaCode,
		DivisionCode	= A.SRDivisionCode,
		ItemCode	= A.ItemCode,
		SRQty		= Sum(IsNull(A.ShipRemainQty, 0))
	From	tsrorder		A
	Where	A.ApplyFrom		Like @ls_planmonth + '.__'	And
		A.AreaCode		= @ps_areacode			And
		A.DivisionCode		Like @ps_divisioncode		And
		A.ItemCode		Like @ps_itemcode		And
		A.ShipEndGubun		= 'N'				And
		A.SRCancelGubun	= 'N'
	Group By A.ShipDate, A.SRAreaCode, A.SRDivisionCode, A.ItemCode)	B
Where	A.PlanDate	*= B.PlanDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.ItemCode, A.ItemName, A.ModelID,
	A.ProductGubun, A.ProductGubunName, A.RackQty, A.SafetyInvQty, A.InvQty, A.InvCompute,
	A.PlanQty, A.ChangeQty, A.SortOrder


Select	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	PlanDate		= A.PlanDate,
	PlanQty			= A.PlanQty,
	ChangeQty		= A.ChangeQty,
	SRQty			= A.SRQty,
	DDRSQty		= Sum(IsNull(B.PlanQty, 0)),
	KDQty			= Sum(IsNull(B.KDQty, 0)),
	ASQty			= Sum(IsNull(B.ASQty, 0)),
	EtcQty01			= Sum(IsNull(B.EtcQty01, 0)),
	EtcQty02			= Sum(IsNull(B.EtcQty02, 0)),
	EtcQty03			= Sum(IsNull(B.EtcQty03, 0))
Into	#tmp_ddrsqty
From	#tmp_srqty	A,
	tplanddrs	B	
Where	A.PlanDate	*= B.PlanDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode		And
	A.ItemCode	*= B.ItemCode
Group By A.SortOrder, A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun, A.ProductGubunName,
	A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.RackQty, A.SafetyInvQty, A.InvQty, A.InvCompute,
	A.PlanDate, A.PlanQty, A.ChangeQty, A.SRQty

Select	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
---	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	ChangeQty01		= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty02		= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty03		= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty04		= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty05		= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty06		= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty07		= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty08		= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty09		= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty10		= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty11		= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty12		= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty13		= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty14		= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty15		= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty16		= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty17		= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty18		= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty19		= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty20		= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty21		= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty22		= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty23		= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty24		= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty25		= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty26		= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty27		= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty28		= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty29		= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty30		= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.ChangeQty, 0) Else 0 End,
	ChangeQty31		= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.ChangeQty, 0) Else 0 End,

	SRQty01		= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty02		= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty03		= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty04		= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty05		= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty06		= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty07		= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty08		= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty09		= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty10		= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty11		= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty12		= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty13		= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty14		= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty15		= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty16		= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty17		= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty18		= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty19		= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty20		= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty21		= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty22		= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty23		= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty24		= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty25		= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty26		= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty27		= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty28		= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty29		= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty30		= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.SRQty, 0) Else 0 End,
	SRQty31		= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.SRQty, 0) Else 0 End,

	DDRSQty01		= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty02		= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty03		= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty04		= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty05		= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty06		= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty07		= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty08		= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty09		= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty10		= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty11		= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty12		= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty13		= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty14		= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty15		= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty16		= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty17		= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty18		= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty19		= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty20		= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty21		= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty22		= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty23		= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty24		= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty25		= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty26		= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty27		= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty28		= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty29		= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty30		= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.DDRSQty, 0) Else 0 End,
	DDRSQty31		= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.DDRSQty, 0) Else 0 End,

	KDQty01		= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty02		= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty03		= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty04		= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty05		= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty06		= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty07		= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty08		= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty09		= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty10		= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty11		= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty12		= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty13		= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty14		= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty15		= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty16		= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty17		= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty18		= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty19		= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty20		= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty21		= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty22		= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty23		= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty24		= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty25		= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty26		= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty27		= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty28		= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty29		= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty30		= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.KDQty, 0) Else 0 End,
	KDQty31		= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.KDQty, 0) Else 0 End,

	ASQty01		= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty02		= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty03		= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty04		= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty05		= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty06		= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty07		= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty08		= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty09		= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty10		= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty11		= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty12		= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty13		= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty14		= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty15		= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty16		= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty17		= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty18		= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty19		= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty20		= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty21		= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty22		= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty23		= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty24		= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty25		= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty26		= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty27		= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty28		= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty29		= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty30		= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.ASQty, 0) Else 0 End,
	ASQty31		= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.ASQty, 0) Else 0 End,

	EtcQty0101	= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0102	= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0103	= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0104	= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0105	= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0106	= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0107	= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0108	= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0109	= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0110	= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0111	= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0112	= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0113	= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0114	= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0115	= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0116	= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0117	= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0118	= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0119	= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0120	= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0121	= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0122	= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0123	= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0124	= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0125	= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0126	= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0127	= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0128	= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0129	= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0130	= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.EtcQty01, 0) Else 0 End,
	EtcQty0131	= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.EtcQty01, 0) Else 0 End,

	EtcQty0201	= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0202	= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0203	= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0204	= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0205	= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0206	= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0207	= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0208	= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0209	= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0210	= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0211	= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0212	= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0213	= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0214	= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0215	= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0216	= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0217	= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0218	= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0219	= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0220	= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0221	= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0222	= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0223	= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0224	= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0225	= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0226	= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0227	= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0228	= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0229	= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0230	= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.EtcQty02, 0) Else 0 End,
	EtcQty0231	= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.EtcQty02, 0) Else 0 End,

	EtcQty0301	= Case When A.PlanDate = @ls_planmonth + '.01'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0302	= Case When A.PlanDate = @ls_planmonth + '.02'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0303	= Case When A.PlanDate = @ls_planmonth + '.03'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0304	= Case When A.PlanDate = @ls_planmonth + '.04'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0305	= Case When A.PlanDate = @ls_planmonth + '.05'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0306	= Case When A.PlanDate = @ls_planmonth + '.06'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0307	= Case When A.PlanDate = @ls_planmonth + '.07'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0308	= Case When A.PlanDate = @ls_planmonth + '.08'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0309	= Case When A.PlanDate = @ls_planmonth + '.09'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0310	= Case When A.PlanDate = @ls_planmonth + '.10'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0311	= Case When A.PlanDate = @ls_planmonth + '.11'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0312	= Case When A.PlanDate = @ls_planmonth + '.12'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0313	= Case When A.PlanDate = @ls_planmonth + '.13'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0314	= Case When A.PlanDate = @ls_planmonth + '.14'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0315	= Case When A.PlanDate = @ls_planmonth + '.15'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0316	= Case When A.PlanDate = @ls_planmonth + '.16'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0317	= Case When A.PlanDate = @ls_planmonth + '.17'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0318	= Case When A.PlanDate = @ls_planmonth + '.18'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0319	= Case When A.PlanDate = @ls_planmonth + '.19'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0320	= Case When A.PlanDate = @ls_planmonth + '.20'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0321	= Case When A.PlanDate = @ls_planmonth + '.21'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0322	= Case When A.PlanDate = @ls_planmonth + '.22'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0323	= Case When A.PlanDate = @ls_planmonth + '.23'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0324	= Case When A.PlanDate = @ls_planmonth + '.24'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0325	= Case When A.PlanDate = @ls_planmonth + '.25'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0326	= Case When A.PlanDate = @ls_planmonth + '.26'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0327	= Case When A.PlanDate = @ls_planmonth + '.27'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0328	= Case When A.PlanDate = @ls_planmonth + '.28'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0329	= Case When A.PlanDate = @ls_planmonth + '.29'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0330	= Case When A.PlanDate = @ls_planmonth + '.30'  Then IsNull(A.EtcQty03, 0) Else 0 End,
	EtcQty0331	= Case When A.PlanDate = @ls_planmonth + '.31'  Then IsNull(A.EtcQty03, 0) Else 0 End

Into	#tmp_result
From	#tmp_ddrsqty	A

Select	SortOrder		= A.SortOrder,
	ItemCode		= A.ItemCode,
	ItemName		= A.ItemName,
	ModelID			= A.ModelID,
	ProductGubun		= A.ProductGubun,
	ProductGubunName	= A.ProductGubunName,
	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
--	WorkCenter		= A.WorkCenter,
--	WorkCenterName		= A.WorkCenterName,
--	LineCode		= A.LineCode,
--	LineShortName		= A.LineShortName,	-- 라인 약명
--	LineFullName		= A.LineFullName,		-- 라인 전명
	RackQty			= A.RackQty,
	SafetyInvQty		= A.SafetyInvQty,
	InvQty			= A.InvQty,
	InvCompute		= A.InvCompute,
	ChangeQtySum		= Sum(A.ChangeQty01) +  Sum(A.ChangeQty02) + Sum(A.ChangeQty03) +
				Sum(A.ChangeQty04) +  Sum(A.ChangeQty05) + Sum(A.ChangeQty06) +
				Sum(A.ChangeQty07) +  Sum(A.ChangeQty08) + Sum(A.ChangeQty09) +
				Sum(A.ChangeQty10) +  Sum(A.ChangeQty11) + Sum(A.ChangeQty12) +
				Sum(A.ChangeQty13) +  Sum(A.ChangeQty14) + Sum(A.ChangeQty15) +
				Sum(A.ChangeQty16) +  Sum(A.ChangeQty17) + Sum(A.ChangeQty18) +
				Sum(A.ChangeQty19) +  Sum(A.ChangeQty20) + Sum(A.ChangeQty21) +
				Sum(A.ChangeQty22) +  Sum(A.ChangeQty23) + Sum(A.ChangeQty24) +
				Sum(A.ChangeQty25) +  Sum(A.ChangeQty26) + Sum(A.ChangeQty27) +
				Sum(A.ChangeQty28) +  Sum(A.ChangeQty29) + Sum(A.ChangeQty30) +
				Sum(A.ChangeQty31),
	ChangeQty01		= Sum(A.ChangeQty01),
	ChangeQty02		= Sum(A.ChangeQty02),
	ChangeQty03		= Sum(A.ChangeQty03),
	ChangeQty04		= Sum(A.ChangeQty04),
	ChangeQty05		= Sum(A.ChangeQty05),
	ChangeQty06		= Sum(A.ChangeQty06),
	ChangeQty07		= Sum(A.ChangeQty07),
	ChangeQty08		= Sum(A.ChangeQty08),
	ChangeQty09		= Sum(A.ChangeQty09),
	ChangeQty10		= Sum(A.ChangeQty10),
	ChangeQty11		= Sum(A.ChangeQty11),
	ChangeQty12		= Sum(A.ChangeQty12),
	ChangeQty13		= Sum(A.ChangeQty13),
	ChangeQty14		= Sum(A.ChangeQty14),
	ChangeQty15		= Sum(A.ChangeQty15),
	ChangeQty16		= Sum(A.ChangeQty16),
	ChangeQty17		= Sum(A.ChangeQty17),
	ChangeQty18		= Sum(A.ChangeQty18),
	ChangeQty19		= Sum(A.ChangeQty19),
	ChangeQty20		= Sum(A.ChangeQty20),
	ChangeQty21		= Sum(A.ChangeQty21),
	ChangeQty22		= Sum(A.ChangeQty22),
	ChangeQty23		= Sum(A.ChangeQty23),
	ChangeQty24		= Sum(A.ChangeQty24),
	ChangeQty25		= Sum(A.ChangeQty25),
	ChangeQty26		= Sum(A.ChangeQty26),
	ChangeQty27		= Sum(A.ChangeQty27),
	ChangeQty28		= Sum(A.ChangeQty28),
	ChangeQty29		= Sum(A.ChangeQty29),
	ChangeQty30		= Sum(A.ChangeQty30),
	ChangeQty31		= Sum(A.ChangeQty31),

	SRQtySum		= Sum(A.SRQty01) +  Sum(A.SRQty02) + Sum(A.SRQty03) +
				Sum(A.SRQty04) +  Sum(A.SRQty05) + Sum(A.SRQty06) +
				Sum(A.SRQty07) +  Sum(A.SRQty08) + Sum(A.SRQty09) +
				Sum(A.SRQty10) +  Sum(A.SRQty11) + Sum(A.SRQty12) +
				Sum(A.SRQty13) +  Sum(A.SRQty14) + Sum(A.SRQty15) +
				Sum(A.SRQty16) +  Sum(A.SRQty17) + Sum(A.SRQty18) +
				Sum(A.SRQty19) +  Sum(A.SRQty20) + Sum(A.SRQty21) +
				Sum(A.SRQty22) +  Sum(A.SRQty23) + Sum(A.SRQty24) +
				Sum(A.SRQty25) +  Sum(A.SRQty26) + Sum(A.SRQty27) +
				Sum(A.SRQty28) +  Sum(A.SRQty29) + Sum(A.SRQty30) +
				Sum(A.SRQty31),
	SRQty01		= Sum(A.SRQty01),
	SRQty02		= Sum(A.SRQty02),
	SRQty03		= Sum(A.SRQty03),
	SRQty04		= Sum(A.SRQty04),
	SRQty05		= Sum(A.SRQty05),
	SRQty06		= Sum(A.SRQty06),
	SRQty07		= Sum(A.SRQty07),
	SRQty08		= Sum(A.SRQty08),
	SRQty09		= Sum(A.SRQty09),
	SRQty10		= Sum(A.SRQty10),
	SRQty11		= Sum(A.SRQty11),
	SRQty12		= Sum(A.SRQty12),
	SRQty13		= Sum(A.SRQty13),
	SRQty14		= Sum(A.SRQty14),
	SRQty15		= Sum(A.SRQty15),
	SRQty16		= Sum(A.SRQty16),
	SRQty17		= Sum(A.SRQty17),
	SRQty18		= Sum(A.SRQty18),
	SRQty19		= Sum(A.SRQty19),
	SRQty20		= Sum(A.SRQty20),
	SRQty21		= Sum(A.SRQty21),
	SRQty22		= Sum(A.SRQty22),
	SRQty23		= Sum(A.SRQty23),
	SRQty24		= Sum(A.SRQty24),
	SRQty25		= Sum(A.SRQty25),
	SRQty26		= Sum(A.SRQty26),
	SRQty27		= Sum(A.SRQty27),
	SRQty28		= Sum(A.SRQty28),
	SRQty29		= Sum(A.SRQty29),
	SRQty30		= Sum(A.SRQty30),
	SRQty31		= Sum(A.SRQty31),

	DDRSQtySum		= Sum(A.DDRSQty01) +  Sum(A.DDRSQty02) + Sum(A.DDRSQty03) +
				Sum(A.DDRSQty04) +  Sum(A.DDRSQty05) + Sum(A.DDRSQty06) +
				Sum(A.DDRSQty07) +  Sum(A.DDRSQty08) + Sum(A.DDRSQty09) +
				Sum(A.DDRSQty10) +  Sum(A.DDRSQty11) + Sum(A.DDRSQty12) +
				Sum(A.DDRSQty13) +  Sum(A.DDRSQty14) + Sum(A.DDRSQty15) +
				Sum(A.DDRSQty16) +  Sum(A.DDRSQty17) + Sum(A.DDRSQty18) +
				Sum(A.DDRSQty19) +  Sum(A.DDRSQty20) + Sum(A.DDRSQty21) +
				Sum(A.DDRSQty22) +  Sum(A.DDRSQty23) + Sum(A.DDRSQty24) +
				Sum(A.DDRSQty25) +  Sum(A.DDRSQty26) + Sum(A.DDRSQty27) +
				Sum(A.DDRSQty28) +  Sum(A.DDRSQty29) + Sum(A.DDRSQty30) +
				Sum(A.DDRSQty31),
	DDRSQty01		= Sum(A.DDRSQty01),
	DDRSQty02		= Sum(A.DDRSQty02),
	DDRSQty03		= Sum(A.DDRSQty03),
	DDRSQty04		= Sum(A.DDRSQty04),
	DDRSQty05		= Sum(A.DDRSQty05),
	DDRSQty06		= Sum(A.DDRSQty06),
	DDRSQty07		= Sum(A.DDRSQty07),
	DDRSQty08		= Sum(A.DDRSQty08),
	DDRSQty09		= Sum(A.DDRSQty09),
	DDRSQty10		= Sum(A.DDRSQty10),
	DDRSQty11		= Sum(A.DDRSQty11),
	DDRSQty12		= Sum(A.DDRSQty12),
	DDRSQty13		= Sum(A.DDRSQty13),
	DDRSQty14		= Sum(A.DDRSQty14),
	DDRSQty15		= Sum(A.DDRSQty15),
	DDRSQty16		= Sum(A.DDRSQty16),
	DDRSQty17		= Sum(A.DDRSQty17),
	DDRSQty18		= Sum(A.DDRSQty18),
	DDRSQty19		= Sum(A.DDRSQty19),
	DDRSQty20		= Sum(A.DDRSQty20),
	DDRSQty21		= Sum(A.DDRSQty21),
	DDRSQty22		= Sum(A.DDRSQty22),
	DDRSQty23		= Sum(A.DDRSQty23),
	DDRSQty24		= Sum(A.DDRSQty24),
	DDRSQty25		= Sum(A.DDRSQty25),
	DDRSQty26		= Sum(A.DDRSQty26),
	DDRSQty27		= Sum(A.DDRSQty27),
	DDRSQty28		= Sum(A.DDRSQty28),
	DDRSQty29		= Sum(A.DDRSQty29),
	DDRSQty30		= Sum(A.DDRSQty30),
	DDRSQty31		= Sum(A.DDRSQty31),


	DummyQtySum		= Sum(A.KDQty01) +  Sum(A.KDQty02) + Sum(A.KDQty03) +
				Sum(A.KDQty04) +  Sum(A.KDQty05) + Sum(A.KDQty06) +
				Sum(A.KDQty07) +  Sum(A.KDQty08) + Sum(A.KDQty09) +
				Sum(A.KDQty10) +  Sum(A.KDQty11) + Sum(A.KDQty12) +
				Sum(A.KDQty13) +  Sum(A.KDQty14) + Sum(A.KDQty15) +
				Sum(A.KDQty16) +  Sum(A.KDQty17) + Sum(A.KDQty18) +
				Sum(A.KDQty19) +  Sum(A.KDQty20) + Sum(A.KDQty21) +
				Sum(A.KDQty22) +  Sum(A.KDQty23) + Sum(A.KDQty24) +
				Sum(A.KDQty25) +  Sum(A.KDQty26) + Sum(A.KDQty27) +
				Sum(A.KDQty28) +  Sum(A.KDQty29) + Sum(A.KDQty30) +
				Sum(A.KDQty31) + 
				Sum(A.ASQty01) +  Sum(A.ASQty02) + Sum(A.ASQty03) +
				Sum(A.ASQty04) +  Sum(A.ASQty05) + Sum(A.ASQty06) +
				Sum(A.ASQty07) +  Sum(A.ASQty08) + Sum(A.ASQty09) +
				Sum(A.ASQty10) +  Sum(A.ASQty11) + Sum(A.ASQty12) +
				Sum(A.ASQty13) +  Sum(A.ASQty14) + Sum(A.ASQty15) +
				Sum(A.ASQty16) +  Sum(A.ASQty17) + Sum(A.ASQty18) +
				Sum(A.ASQty19) +  Sum(A.ASQty20) + Sum(A.ASQty21) +
				Sum(A.ASQty22) +  Sum(A.ASQty23) + Sum(A.ASQty24) +
				Sum(A.ASQty25) +  Sum(A.ASQty26) + Sum(A.ASQty27) +
				Sum(A.ASQty28) +  Sum(A.ASQty29) + Sum(A.ASQty30) +
				Sum(A.ASQty31) +
				Sum(A.EtcQty0101) +  Sum(A.EtcQty0102) + Sum(A.EtcQty0103) +
				Sum(A.EtcQty0104) +  Sum(A.EtcQty0105) + Sum(A.EtcQty0106) +
				Sum(A.EtcQty0107) +  Sum(A.EtcQty0108) + Sum(A.EtcQty0109) +
				Sum(A.EtcQty0110) +  Sum(A.EtcQty0111) + Sum(A.EtcQty0112) +
				Sum(A.EtcQty0113) +  Sum(A.EtcQty0114) + Sum(A.EtcQty0115) +
				Sum(A.EtcQty0116) +  Sum(A.EtcQty0117) + Sum(A.EtcQty0118) +
				Sum(A.EtcQty0119) +  Sum(A.EtcQty0120) + Sum(A.EtcQty0121) +
				Sum(A.EtcQty0122) +  Sum(A.EtcQty0123) + Sum(A.EtcQty0124) +
				Sum(A.EtcQty0125) +  Sum(A.EtcQty0126) + Sum(A.EtcQty0127) +
				Sum(A.EtcQty0128) +  Sum(A.EtcQty0129) + Sum(A.EtcQty0130) +
				Sum(A.EtcQty0131) +
				Sum(A.EtcQty0201) +  Sum(A.EtcQty0202) + Sum(A.EtcQty0203) +
				Sum(A.EtcQty0204) +  Sum(A.EtcQty0205) + Sum(A.EtcQty0206) +
				Sum(A.EtcQty0207) +  Sum(A.EtcQty0208) + Sum(A.EtcQty0209) +
				Sum(A.EtcQty0210) +  Sum(A.EtcQty0211) + Sum(A.EtcQty0212) +
				Sum(A.EtcQty0213) +  Sum(A.EtcQty0214) + Sum(A.EtcQty0215) +
				Sum(A.EtcQty0216) +  Sum(A.EtcQty0217) + Sum(A.EtcQty0218) +
				Sum(A.EtcQty0219) +  Sum(A.EtcQty0220) + Sum(A.EtcQty0221) +
				Sum(A.EtcQty0222) +  Sum(A.EtcQty0223) + Sum(A.EtcQty0224) +
				Sum(A.EtcQty0225) +  Sum(A.EtcQty0226) + Sum(A.EtcQty0227) +
				Sum(A.EtcQty0228) +  Sum(A.EtcQty0229) + Sum(A.EtcQty0230) +
				Sum(A.EtcQty0231) +
				Sum(A.EtcQty0301) +  Sum(A.EtcQty0302) + Sum(A.EtcQty0303) +
				Sum(A.EtcQty0304) +  Sum(A.EtcQty0305) + Sum(A.EtcQty0306) +
				Sum(A.EtcQty0307) +  Sum(A.EtcQty0308) + Sum(A.EtcQty0309) +
				Sum(A.EtcQty0310) +  Sum(A.EtcQty0311) + Sum(A.EtcQty0312) +
				Sum(A.EtcQty0313) +  Sum(A.EtcQty0314) + Sum(A.EtcQty0315) +
				Sum(A.EtcQty0316) +  Sum(A.EtcQty0317) + Sum(A.EtcQty0318) +
				Sum(A.EtcQty0319) +  Sum(A.EtcQty0320) + Sum(A.EtcQty0321) +
				Sum(A.EtcQty0322) +  Sum(A.EtcQty0323) + Sum(A.EtcQty0324) +
				Sum(A.EtcQty0325) +  Sum(A.EtcQty0326) + Sum(A.EtcQty0327) +
				Sum(A.EtcQty0328) +  Sum(A.EtcQty0329) + Sum(A.EtcQty0330) +
				Sum(A.EtcQty0331),

	KDQtySum		= Sum(A.KDQty01) +  Sum(A.KDQty02) + Sum(A.KDQty03) +
				Sum(A.KDQty04) +  Sum(A.KDQty05) + Sum(A.KDQty06) +
				Sum(A.KDQty07) +  Sum(A.KDQty08) + Sum(A.KDQty09) +
				Sum(A.KDQty10) +  Sum(A.KDQty11) + Sum(A.KDQty12) +
				Sum(A.KDQty13) +  Sum(A.KDQty14) + Sum(A.KDQty15) +
				Sum(A.KDQty16) +  Sum(A.KDQty17) + Sum(A.KDQty18) +
				Sum(A.KDQty19) +  Sum(A.KDQty20) + Sum(A.KDQty21) +
				Sum(A.KDQty22) +  Sum(A.KDQty23) + Sum(A.KDQty24) +
				Sum(A.KDQty25) +  Sum(A.KDQty26) + Sum(A.KDQty27) +
				Sum(A.KDQty28) +  Sum(A.KDQty29) + Sum(A.KDQty30) +
				Sum(A.KDQty31),
	KDQty01			= Sum(A.KDQty01),
	KDQty02			= Sum(A.KDQty02),
	KDQty03			= Sum(A.KDQty03),
	KDQty04			= Sum(A.KDQty04),
	KDQty05			= Sum(A.KDQty05),
	KDQty06			= Sum(A.KDQty06),
	KDQty07			= Sum(A.KDQty07),
	KDQty08			= Sum(A.KDQty08),
	KDQty09			= Sum(A.KDQty09),
	KDQty10			= Sum(A.KDQty10),
	KDQty11			= Sum(A.KDQty11),
	KDQty12			= Sum(A.KDQty12),
	KDQty13			= Sum(A.KDQty13),
	KDQty14			= Sum(A.KDQty14),
	KDQty15			= Sum(A.KDQty15),
	KDQty16			= Sum(A.KDQty16),
	KDQty17			= Sum(A.KDQty17),
	KDQty18			= Sum(A.KDQty18),
	KDQty19			= Sum(A.KDQty19),
	KDQty20			= Sum(A.KDQty20),
	KDQty21			= Sum(A.KDQty21),
	KDQty22			= Sum(A.KDQty22),
	KDQty23			= Sum(A.KDQty23),
	KDQty24			= Sum(A.KDQty24),
	KDQty25			= Sum(A.KDQty25),
	KDQty26			= Sum(A.KDQty26),
	KDQty27			= Sum(A.KDQty27),
	KDQty28			= Sum(A.KDQty28),
	KDQty29			= Sum(A.KDQty29),
	KDQty30			= Sum(A.KDQty30),
	KDQty31			= Sum(A.KDQty31),

	ASQtySum		= Sum(A.ASQty01) +  Sum(A.ASQty02) + Sum(A.ASQty03) +
				Sum(A.ASQty04) +  Sum(A.ASQty05) + Sum(A.ASQty06) +
				Sum(A.ASQty07) +  Sum(A.ASQty08) + Sum(A.ASQty09) +
				Sum(A.ASQty10) +  Sum(A.ASQty11) + Sum(A.ASQty12) +
				Sum(A.ASQty13) +  Sum(A.ASQty14) + Sum(A.ASQty15) +
				Sum(A.ASQty16) +  Sum(A.ASQty17) + Sum(A.ASQty18) +
				Sum(A.ASQty19) +  Sum(A.ASQty20) + Sum(A.ASQty21) +
				Sum(A.ASQty22) +  Sum(A.ASQty23) + Sum(A.ASQty24) +
				Sum(A.ASQty25) +  Sum(A.ASQty26) + Sum(A.ASQty27) +
				Sum(A.ASQty28) +  Sum(A.ASQty29) + Sum(A.ASQty30) +
				Sum(A.ASQty31),
	ASQty01			= Sum(A.ASQty01),
	ASQty02			= Sum(A.ASQty02),
	ASQty03			= Sum(A.ASQty03),
	ASQty04			= Sum(A.ASQty04),
	ASQty05			= Sum(A.ASQty05),
	ASQty06			= Sum(A.ASQty06),
	ASQty07			= Sum(A.ASQty07),
	ASQty08			= Sum(A.ASQty08),
	ASQty09			= Sum(A.ASQty09),
	ASQty10			= Sum(A.ASQty10),
	ASQty11			= Sum(A.ASQty11),
	ASQty12			= Sum(A.ASQty12),
	ASQty13			= Sum(A.ASQty13),
	ASQty14			= Sum(A.ASQty14),
	ASQty15			= Sum(A.ASQty15),
	ASQty16			= Sum(A.ASQty16),
	ASQty17			= Sum(A.ASQty17),
	ASQty18			= Sum(A.ASQty18),
	ASQty19			= Sum(A.ASQty19),
	ASQty20			= Sum(A.ASQty20),
	ASQty21			= Sum(A.ASQty21),
	ASQty22			= Sum(A.ASQty22),
	ASQty23			= Sum(A.ASQty23),
	ASQty24			= Sum(A.ASQty24),
	ASQty25			= Sum(A.ASQty25),
	ASQty26			= Sum(A.ASQty26),
	ASQty27			= Sum(A.ASQty27),
	ASQty28			= Sum(A.ASQty28),
	ASQty29			= Sum(A.ASQty29),
	ASQty30			= Sum(A.ASQty30),
	ASQty31			= Sum(A.ASQty31),

	EtcQty01Sum		= Sum(A.EtcQty0101) +  Sum(A.EtcQty0102) + Sum(A.EtcQty0103) +
				Sum(A.EtcQty0104) +  Sum(A.EtcQty0105) + Sum(A.EtcQty0106) +
				Sum(A.EtcQty0107) +  Sum(A.EtcQty0108) + Sum(A.EtcQty0109) +
				Sum(A.EtcQty0110) +  Sum(A.EtcQty0111) + Sum(A.EtcQty0112) +
				Sum(A.EtcQty0113) +  Sum(A.EtcQty0114) + Sum(A.EtcQty0115) +
				Sum(A.EtcQty0116) +  Sum(A.EtcQty0117) + Sum(A.EtcQty0118) +
				Sum(A.EtcQty0119) +  Sum(A.EtcQty0120) + Sum(A.EtcQty0121) +
				Sum(A.EtcQty0122) +  Sum(A.EtcQty0123) + Sum(A.EtcQty0124) +
				Sum(A.EtcQty0125) +  Sum(A.EtcQty0126) + Sum(A.EtcQty0127) +
				Sum(A.EtcQty0128) +  Sum(A.EtcQty0129) + Sum(A.EtcQty0130) +
				Sum(A.EtcQty0131),
	EtcQty0101		= Sum(A.EtcQty0101),
	EtcQty0102		= Sum(A.EtcQty0102),
	EtcQty0103		= Sum(A.EtcQty0103),
	EtcQty0104		= Sum(A.EtcQty0104),
	EtcQty0105		= Sum(A.EtcQty0105),
	EtcQty0106		= Sum(A.EtcQty0106),
	EtcQty0107		= Sum(A.EtcQty0107),
	EtcQty0108		= Sum(A.EtcQty0108),
	EtcQty0109		= Sum(A.EtcQty0109),
	EtcQty0110		= Sum(A.EtcQty0110),
	EtcQty0111		= Sum(A.EtcQty0111),
	EtcQty0112		= Sum(A.EtcQty0112),
	EtcQty0113		= Sum(A.EtcQty0113),
	EtcQty0114		= Sum(A.EtcQty0114),
	EtcQty0115		= Sum(A.EtcQty0115),
	EtcQty0116		= Sum(A.EtcQty0116),
	EtcQty0117		= Sum(A.EtcQty0117),
	EtcQty0118		= Sum(A.EtcQty0118),
	EtcQty0119		= Sum(A.EtcQty0119),
	EtcQty0120		= Sum(A.EtcQty0120),
	EtcQty0121		= Sum(A.EtcQty0121),
	EtcQty0122		= Sum(A.EtcQty0122),
	EtcQty0123		= Sum(A.EtcQty0123),
	EtcQty0124		= Sum(A.EtcQty0124),
	EtcQty0125		= Sum(A.EtcQty0125),
	EtcQty0126		= Sum(A.EtcQty0126),
	EtcQty0127		= Sum(A.EtcQty0127),
	EtcQty0128		= Sum(A.EtcQty0128),
	EtcQty0129		= Sum(A.EtcQty0129),
	EtcQty0130		= Sum(A.EtcQty0130),
	EtcQty0131		= Sum(A.EtcQty0131),

	EtcQty02Sum		= Sum(A.EtcQty0201) +  Sum(A.EtcQty0202) + Sum(A.EtcQty0203) +
				Sum(A.EtcQty0204) +  Sum(A.EtcQty0205) + Sum(A.EtcQty0206) +
				Sum(A.EtcQty0207) +  Sum(A.EtcQty0208) + Sum(A.EtcQty0209) +
				Sum(A.EtcQty0210) +  Sum(A.EtcQty0211) + Sum(A.EtcQty0212) +
				Sum(A.EtcQty0213) +  Sum(A.EtcQty0214) + Sum(A.EtcQty0215) +
				Sum(A.EtcQty0216) +  Sum(A.EtcQty0217) + Sum(A.EtcQty0218) +
				Sum(A.EtcQty0219) +  Sum(A.EtcQty0220) + Sum(A.EtcQty0221) +
				Sum(A.EtcQty0222) +  Sum(A.EtcQty0223) + Sum(A.EtcQty0224) +
				Sum(A.EtcQty0225) +  Sum(A.EtcQty0226) + Sum(A.EtcQty0227) +
				Sum(A.EtcQty0228) +  Sum(A.EtcQty0229) + Sum(A.EtcQty0230) +
				Sum(A.EtcQty0231),
	EtcQty0201		= Sum(A.EtcQty0201),
	EtcQty0202		= Sum(A.EtcQty0202),
	EtcQty0203		= Sum(A.EtcQty0203),
	EtcQty0204		= Sum(A.EtcQty0204),
	EtcQty0205		= Sum(A.EtcQty0205),
	EtcQty0206		= Sum(A.EtcQty0206),
	EtcQty0207		= Sum(A.EtcQty0207),
	EtcQty0208		= Sum(A.EtcQty0208),
	EtcQty0209		= Sum(A.EtcQty0209),
	EtcQty0210		= Sum(A.EtcQty0210),
	EtcQty0211		= Sum(A.EtcQty0211),
	EtcQty0212		= Sum(A.EtcQty0212),
	EtcQty0213		= Sum(A.EtcQty0213),
	EtcQty0214		= Sum(A.EtcQty0214),
	EtcQty0215		= Sum(A.EtcQty0215),
	EtcQty0216		= Sum(A.EtcQty0216),
	EtcQty0217		= Sum(A.EtcQty0217),
	EtcQty0218		= Sum(A.EtcQty0218),
	EtcQty0219		= Sum(A.EtcQty0219),
	EtcQty0220		= Sum(A.EtcQty0220),
	EtcQty0221		= Sum(A.EtcQty0221),
	EtcQty0222		= Sum(A.EtcQty0222),
	EtcQty0223		= Sum(A.EtcQty0223),
	EtcQty0224		= Sum(A.EtcQty0224),
	EtcQty0225		= Sum(A.EtcQty0225),
	EtcQty0226		= Sum(A.EtcQty0226),
	EtcQty0227		= Sum(A.EtcQty0227),
	EtcQty0228		= Sum(A.EtcQty0228),
	EtcQty0229		= Sum(A.EtcQty0229),
	EtcQty0230		= Sum(A.EtcQty0230),
	EtcQty0231		= Sum(A.EtcQty0231),

	EtcQty03Sum		= Sum(A.EtcQty0301) +  Sum(A.EtcQty0302) + Sum(A.EtcQty0303) +
				Sum(A.EtcQty0304) +  Sum(A.EtcQty0305) + Sum(A.EtcQty0306) +
				Sum(A.EtcQty0307) +  Sum(A.EtcQty0308) + Sum(A.EtcQty0309) +
				Sum(A.EtcQty0310) +  Sum(A.EtcQty0311) + Sum(A.EtcQty0312) +
				Sum(A.EtcQty0313) +  Sum(A.EtcQty0314) + Sum(A.EtcQty0315) +
				Sum(A.EtcQty0316) +  Sum(A.EtcQty0317) + Sum(A.EtcQty0318) +
				Sum(A.EtcQty0319) +  Sum(A.EtcQty0320) + Sum(A.EtcQty0321) +
				Sum(A.EtcQty0322) +  Sum(A.EtcQty0323) + Sum(A.EtcQty0324) +
				Sum(A.EtcQty0325) +  Sum(A.EtcQty0326) + Sum(A.EtcQty0327) +
				Sum(A.EtcQty0328) +  Sum(A.EtcQty0329) + Sum(A.EtcQty0330) +
				Sum(A.EtcQty0331),
	EtcQty0301		= Sum(A.EtcQty0301),
	EtcQty0302		= Sum(A.EtcQty0302),
	EtcQty0303		= Sum(A.EtcQty0303),
	EtcQty0304		= Sum(A.EtcQty0304),
	EtcQty0305		= Sum(A.EtcQty0305),
	EtcQty0306		= Sum(A.EtcQty0306),
	EtcQty0307		= Sum(A.EtcQty0307),
	EtcQty0308		= Sum(A.EtcQty0308),
	EtcQty0309		= Sum(A.EtcQty0309),
	EtcQty0310		= Sum(A.EtcQty0310),
	EtcQty0311		= Sum(A.EtcQty0311),
	EtcQty0312		= Sum(A.EtcQty0312),
	EtcQty0313		= Sum(A.EtcQty0313),
	EtcQty0314		= Sum(A.EtcQty0314),
	EtcQty0315		= Sum(A.EtcQty0315),
	EtcQty0316		= Sum(A.EtcQty0316),
	EtcQty0317		= Sum(A.EtcQty0317),
	EtcQty0318		= Sum(A.EtcQty0318),
	EtcQty0319		= Sum(A.EtcQty0319),
	EtcQty0320		= Sum(A.EtcQty0320),
	EtcQty0321		= Sum(A.EtcQty0321),
	EtcQty0322		= Sum(A.EtcQty0322),
	EtcQty0323		= Sum(A.EtcQty0323),
	EtcQty0324		= Sum(A.EtcQty0324),
	EtcQty0325		= Sum(A.EtcQty0325),
	EtcQty0326		= Sum(A.EtcQty0326),
	EtcQty0327		= Sum(A.EtcQty0327),
	EtcQty0328		= Sum(A.EtcQty0328),
	EtcQty0329		= Sum(A.EtcQty0329),
	EtcQty0330		= Sum(A.EtcQty0330),
	EtcQty0331		= Sum(A.EtcQty0331),

	ChangeFlag		= 'N',
	ChangeFlag01		= 'N',
	ChangeFlag02		= 'N',
	ChangeFlag03		= 'N',
	ChangeFlag04		= 'N',
	ChangeFlag05		= 'N',
	ChangeFlag06		= 'N',
	ChangeFlag07		= 'N',
	ChangeFlag08		= 'N',
	ChangeFlag09		= 'N',
	ChangeFlag10		= 'N',
	ChangeFlag11		= 'N',
	ChangeFlag12		= 'N',
	ChangeFlag13		= 'N',
	ChangeFlag14		= 'N',
	ChangeFlag15		= 'N',
	ChangeFlag16		= 'N',
	ChangeFlag17		= 'N',
	ChangeFlag18		= 'N',
	ChangeFlag19		= 'N',
	ChangeFlag20		= 'N',
	ChangeFlag21		= 'N',
	ChangeFlag22		= 'N',
	ChangeFlag23		= 'N',
	ChangeFlag24		= 'N',
	ChangeFlag25		= 'N',
	ChangeFlag26		= 'N',
	ChangeFlag27		= 'N',
	ChangeFlag28		= 'N',
	ChangeFlag29		= 'N',
	ChangeFlag30		= 'N',
	ChangeFlag31		= 'N'

From	#tmp_result	A
Group By A.SortOrder, A.ItemCode, A.ItemName, A.ModelID, A.ProductGubun, A.ProductGubunName,
	A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
--	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName,
	A.RackQty, A.SafetyInvQty, A.InvQty, A.InvCompute


Drop Table #tmp_item
Drop Table #tmp_planqty
Drop Table #tmp_ddrsqty
Drop Table #tmp_srqty
Drop Table #tmp_result

/*
Select	AreaCode		= '',
	DivisionCode		=  '',
	ItemCode		=  '',
	ItemName		=  '',
	ModelID			=  '',
	ProductGubun		=  '',
	ProductGubunName	=  '',
	RackQty			=  0,
	SafetyInvQty		=  0,
	InvQty			=  0,
	InvComputeGubun	=  '1',
	ChangeQtySum		= 0,
	ChangeQty01		= 0,
	ChangeQty02		= 0,
	ChangeQty03		= 0,
	ChangeQty04		= 0,
	ChangeQty05		= 0,
	ChangeQty06		= 0,
	ChangeQty07		= 0,
	ChangeQty08		= 0,
	ChangeQty09		= 0,
	ChangeQty10		= 0,
	ChangeQty11		= 0,
	ChangeQty12		= 0,
	ChangeQty13		= 0,
	ChangeQty14		= 0,
	ChangeQty15		= 0,
	ChangeQty16		= 0,
	ChangeQty17		= 0,
	ChangeQty18		= 0,
	ChangeQty19		= 0,
	ChangeQty20		= 0,
	ChangeQty21		= 0,
	ChangeQty22		= 0,
	ChangeQty23		= 0,
	ChangeQty24		= 0,
	ChangeQty25		= 0,
	ChangeQty26		= 0,
	ChangeQty27		= 0,
	ChangeQty28		= 0,
	ChangeQty29		= 0,
	ChangeQty30		= 0,
	ChangeQty31		= 0

	SRQtySum		= 0,
	SRQty01		= 0,
	SRQty02		= 0,
	SRQty03		= 0,
	SRQty04		= 0,
	SRQty05		= 0,
	SRQty06		= 0,
	SRQty07		= 0,
	SRQty08		= 0,
	SRQty09		= 0,
	SRQty10		= 0,
	SRQty11		= 0,
	SRQty12		= 0,
	SRQty13		= 0,
	SRQty14		= 0,
	SRQty15		= 0,
	SRQty16		= 0,
	SRQty17		= 0,
	SRQty18		= 0,
	SRQty19		= 0,
	SRQty20		= 0,
	SRQty21		= 0,
	SRQty22		= 0,
	SRQty23		= 0,
	SRQty24		= 0,
	SRQty25		= 0,
	SRQty26		= 0,
	SRQty27		= 0,
	SRQty28		= 0,
	SRQty29		= 0,
	SRQty30		= 0,
	SRQty31		= 0,

	DDRSQtySum		= 0,
	DDRSQty01		= 0,
	DDRSQty02		= 0,
	DDRSQty03		= 0,
	DDRSQty04		= 0,
	DDRSQty05		= 0,
	DDRSQty06		= 0,
	DDRSQty07		= 0,
	DDRSQty08		= 0,
	DDRSQty09		= 0,
	DDRSQty10		= 0,
	DDRSQty11		= 0,
	DDRSQty12		= 0,
	DDRSQty13		= 0,
	DDRSQty14		= 0,
	DDRSQty15		= 0,
	DDRSQty16		= 0,
	DDRSQty17		= 0,
	DDRSQty18		= 0,
	DDRSQty19		= 0,
	DDRSQty20		= 0,
	DDRSQty21		= 0,
	DDRSQty22		= 0,
	DDRSQty23		= 0,
	DDRSQty24		= 0,
	DDRSQty25		= 0,
	DDRSQty26		= 0,
	DDRSQty27		= 0,
	DDRSQty28		= 0,
	DDRSQty29		= 0,
	DDRSQty30		= 0,
	DDRSQty31		= 0

	DummyQtySum		= 0,
	DummyQty01		= 0,
	DummyQty02		= 0,
	DummyQty03		= 0,
	DummyQty04		= 0,
	DummyQty05		= 0,
	DummyQty06		= 0,
	DummyQty07		= 0,
	DummyQty08		= 0,
	DummyQty09		= 0,
	DummyQty10		= 0,
	DummyQty11		= 0,
	DummyQty12		= 0,
	DummyQty13		= 0,
	DummyQty14		= 0,
	DummyQty15		= 0,
	DummyQty16		= 0,
	DummyQty17		= 0,
	DummyQty18		= 0,
	DummyQty19		= 0,
	DummyQty20		= 0,
	DummyQty21		= 0,
	DummyQty22		= 0,
	DummyQty23		= 0,
	DummyQty24		= 0,
	DummyQty25		= 0,
	DummyQty26		= 0,
	DummyQty27		= 0,
	DummyQty28		= 0,
	DummyQty29		= 0,
	DummyQty30		= 0,
	DummyQty31		= 0
*/
Return

End		-- Procedure End
Go
