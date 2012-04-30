/*
	File Name	: sp_pisp003u_01.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp003u_01
	Description	: ����ȭ Cycle ������ ���� ���κ� ����ȭ Cycle ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 17
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp003u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp003u_01]
GO

/*
Execute sp_pisp003u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%'

Update	tmstline
Set	MaxCycleGubun	= 'N',
	CycleCount	= 1
*/

Create Procedure sp_pisp003u_01
	@ps_areacode		Char(1),		-- ���� �ڵ�
	@ps_divisioncode	Char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5)
As
Begin


Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	MaxCycleGubun		= A.MaxCycleGubun,
	CycleCount		= Case When A.MaxCycleGubun = 'Y'	Then 0
					Else A.CycleCount
				   End
From	vmstline		A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.MaxCycleGubun, A.CycleCount

Return

End		-- Procedure End
Go
