/*
	File Name	: sp_pisp270i_02.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp270i_02
	Description	: ���� ��ȣ List - ���ǹ�ȣ �� ����
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
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

-- vmstkb_line ���� ������ ��
-- ��ȸ������ ��ǰ�� ������.
Select	KBNo			= A.KBNo,
	KBActiveGubun		= A.KBActiveGubun,
	KBActiveGubunName	= Case	When A.KBActiveGubun = 'A'	Then 'Active'
					Else 'Sleeping'
				   End,
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
	StockGubunName	= Case	When A.StockGubun = 'Y'	Then '�԰���ǰ'
					When A.StockGubun = 'N'	Then '������԰�ǰ'
					When A.StockGubun = 'B'	Then '�İ���ȸ��ǰ'
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
