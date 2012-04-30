/*
	File Name	: sp_pisc_select_line.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisc_select_line
	Description	: ���� �ڵ� DDDW�� ���� ��ȸ
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_workcenter, @ps_linecode
	Use Table	: tmstworkcenter
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_line]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_line]
GO

/*
Execute sp_pisc_select_line 'J', '%', '%', '%'
select * from tmstline

*/

Create Procedure sp_pisc_select_line
	@ps_areacode		char(1),		-- ����
	@ps_divisioncode	char(1),		-- ����
	@ps_workcenter		varchar(5),	-- ��
	@ps_linecode		varchar(1)	-- ����
	
As
Begin


Select	AreaCode		= A.AreaCode,		-- ���� �ڵ�
	AreaName		= A.AreaName,		-- ���� ��
	DivisionCode		= A.DivisionCode,		-- �����ڵ�
	DivisionName		= A.DivisionName,	-- �����
	DivisionNameEng		= A.DivisionNameEng,	-- ���� ������
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center ��
	LineCode		= A.LineCode,		-- �����ڵ�
	LineShortName		= A.LineShortName,	-- ���� ���
	LineFullName		= A.LineFullName,		-- ���� ����
	DisplayName		= A.LineShortName + '(' + A.AreaCode + A.DivisionCode + A.WorkCenter + A.LineCode + ')'
From	vmstline	A
Where	A.AreaCode		= @ps_areacode		And
	A.DivisionCode		Like @ps_divisioncode	And
	A.WorkCenter		Like @ps_workcenter	And
	A.LineCode		Like @ps_linecode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.DivisionNameEng, A.WorkCenter, A.WorkCenterName,
		A.LineCode, A.LineShortName, A.LineFullName

Return

End		-- Procedure End
Go
