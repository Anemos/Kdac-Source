/*
	File Name	: sp_pisp260i_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp260i_01
	Description	: ���� ��ȣ ����
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

-- vmstkb_line ���� ������ ��
-- ��ȸ������ ��ǰ�� ������.
Select	AreaCode		= B.AreaCode,		-- �����ڵ�
	AreaName		= B.AreaName,		-- ���� ��
	DivisionCode		= B.DivisionCode,		-- ����
	DivisionName		= B.DivisionName,	-- �����
	WorkCenter		= B.WorkCenter,		-- Work Center
	WorkCenterName		= B.WorkCenterName,	-- Work Center ��
	LineCode		= B.LineCode,		-- ����
	LineShortName		= B.LineShortName,	-- ���� ���
	LineFullName		= B.LineFullName,		-- ���� ����
	ItemCode		= B.ItemCode,		-- ǰ��
	ItemName		= B.ItemName,		-- ǰ��
	ModelID			= B.ModelID,		-- ���ȣ
	ProductGubun		= B.ProductGubun,
	ProductGubunName	= Case	When B.ProductGubun = 'P'	Then '��ȹ����ǰ'
					When B.ProductGubun = 'R'	Then '�ĺ������ǰ'
					Else 'OEM����ǰ'
				   End,

	ApplyFrom		= A.ApplyFrom,
	KBStatusCode		= A.KBStatusCode,
	KBStatusCodeName	= Case	When A.KBActiveGubun = 'A'	Then
						Case	When A.KBStatusCode = 'A'	Then '����'
							When A.KBStatusCode = 'B'	Then '����'
							When A.KBStatusCode = 'C'	Then '�Ϸ�'
							When A.KBStatusCode = 'D'	Then '�԰�'
							When A.KBStatusCode = 'E'	Then '����'
							When A.KBStatusCode = 'F'	Then 'ȸ��'
						Else ''
						End
				   Else ''
				   End,
	TempGubun		= A.TempGubun,
	TempGubunName	= Case	When A.TempGubun = 'N'	Then '����'
					Else '�ӽ�'
				   End,
	ASGubun		= A.ASGubun,
	ASGubunName		= Case	When A.ASGubun = 'N'	Then '����ǰ'
					Else 'A/Sǰ'
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
	ReleaseGubunName	= Case	When A.ReleaseGubun	= 'N'	Then '�����ǻ���'
					When A.ReleaseGubun	= 'Y'	Then '��������'
					When A.ReleaseGubun	= 'T'	Then '�������'
					When A.ReleaseGubun	= 'U'	Then '���ؼ�'
					Else ''
				   End,
	ReleaseCancel		= A.ReleaseCancel,
	ReleaseCancelName	= Case	When A.ReleaseCancel	= 'Y'	Then '�������'
					Else ''
				   End,
	PrdFlag			= A.PrdFlag,
	PrdFlagName		= Case	When A.PrdFlag		= 'E'	Then '����Ϸ�'
					When A.PrdFlag		= 'N'	Then '���û���'
					Else ''
				   End,
--	InspectGubun		= A.InspectGubun,
--	InspectGubunName	= Case	When B.ItemCode Is Null	Then '���˻��԰�ǰ'
--					Else '�԰�˻�ǰ'
--				   End,
	InspectFlag		= A.InspectFlag,
	InspectFlagName		= Case	When A.InspectFlag	= 'Y'	Then '�԰�˻�Ϸ�'
					Else ''
				   End,
	StockGubun		= A.StockGubun,
	StockGubunName	= Case	When A.StockGubun = 'Y'	Then 'â���԰���'
					When A.StockGubun = 'N'	Then '�����԰���'
					When A.StockGubun = 'B'	Then '����ȸ��'
					Else ''
				   End,
	StockCancel		= A.StockCancel,
	StockCancelName	= Case	When A.StockCancel	= 'Y'	Then '�԰����'
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
