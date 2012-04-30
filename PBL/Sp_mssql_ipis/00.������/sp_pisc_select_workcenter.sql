/*
	File Name	: sp_pisc_select_workcenter.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_select_workcenter
	Description	: �� �ڵ� DDDW�� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_workcenter
	Use Table	: tmstworkcenter
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_workcenter]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_workcenter]
GO

/*
Execute sp_pisc_select_workcenter 'J', '%', '%'
select * from tmstworkcenter

*/

Create Procedure sp_pisc_select_workcenter
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1),		-- ����
	@ps_workcenter		varchar(5)	-- ��ǰ��
	
As
Begin

Select	DivisionCode		= A.DivisionCode,
	DivisionName		= B.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	DisplayName		= A.WorkCenterName + '(' + A.WorkCenter + ')'
From	tmstworkcenter		A,
	tmstdivision		B
Where	A.AreaCode		= @ps_areacode		And
	A.DivisionCode		Like @ps_divisioncode	And
	A.WorkCenter		Like @ps_workcenter	And
	A.AreaCode		= B.AreaCode		And
	A.DivisionCode		= B.DivisionCode
Group By A.AreaCode, A.DivisionCode, B.DivisionName, A.WorkCenter, A.WorkCenterName


Return

End		-- Procedure End
Go
