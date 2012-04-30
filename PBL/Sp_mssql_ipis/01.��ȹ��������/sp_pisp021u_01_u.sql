/*
	File Name	: sp_pisp021u_01_u.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisp021u_01_u
	Description	: Work Calendar ���縦 �����ϴ� ���ν���
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 09
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp021u_01_u]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp021u_01_u]
GO

/*
Execute sp_pisp021u_01_u '2002.09', '2002.09.01', 'D', '%', '%', '%', 1, 'W', '33333'

select * from tcalendarwork
*/

Create Procedure sp_pisp021u_01_u
	@ps_applymonth		char(7),		-- ��ȹ�� ('YYYY.MM')
	@ps_applydate		char(10),	-- ���� ('YYYY.MM.DD')
	@ps_areacode		char(1),		-- ���� �ڵ�
	@ps_divisioncode	char(1),		-- ���� �ڵ�
	@ps_workcenter		varchar(5),	-- �� �ڵ�
	@ps_linecode		varchar(1),	-- ���� �ڵ�
	@pi_julianday		int,
	@ps_workgubun		char(1),
	@ps_empno		varchar(6)
As
Begin

Declare	@li_julianday	int

-- �����Ϸ��� ������ ���� ���Ѵ�
Select	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	WorkCenter	= A.WorkCenter,
	LineCode	= A.LineCode
Into	#tmp_line
From	tmstline		A
Where	A.AreaCode	Like @ps_areacode
And	A.DivisionCode	Like @ps_divisioncode
And	A.WorkCenter	Like @ps_workcenter
And	A.LineCode	Like @ps_linecode

-- �����Ϸ��� ���� �߿� �̹� Work Calendar �� �ش� ���� ������ �ִ� �͸� ���Ѵ�.
-- Update �Ϸ��� ����
Select	AreaCode	= B.AreaCode,
	DivisionCode	= B.DivisionCode,
	WorkCenter	= B.WorkCenter,
	LineCode	= B.LineCode
Into	#tmp_calendar
From	#tmp_line	A,
	tcalendarwork	B
Where	A.AreaCode	= B.AreaCode
And	A.DivisionCode	= B.DivisionCode
And	A.WorkCenter	= B.WorkCenter
And	A.LineCode	= B.LineCode
And	B.ApplyMonth	= @ps_applymonth
And	B.ApplyDate	= @ps_applydate


-- �����Ϸ��� ���� �߿� Work Calendar �� ���� �͸� ���Ѵ�
-- Insert �Ϸ��� ����
Delete	#tmp_line
From	#tmp_line	A,
	#tmp_calendar	B
Where	A.AreaCode	= B.AreaCode
And	A.DivisionCode	= B.DivisionCode
And	A.WorkCenter	= B.WorkCenter
And	A.LineCode	= B.LineCode

-- Update ����
Update	tcalendarwork
Set	WorkGubun	= @ps_workgubun,
	LastEmp		= 'Y', --@ps_empno,
	LastDate		= GetDate()
From	#tmp_calendar	A,
	tcalendarwork	B		
Where	A.AreaCode	= B.AreaCode
And	A.DivisionCode	= B.DivisionCode
And	A.WorkCenter	= B.WorkCenter
And	A.LineCode	= B.LineCode
And	B.ApplyMonth	= @ps_applymonth
And	B.ApplyDate	= @ps_applydate

If @@Error = 0
Begin
	Select	Error		= '00',
		ErrorText	= 'SUCCESS'
End
Else
Begin
	Select	Error		= '11',
		ErrorText	= 'FAIL'

	Drop Table #tmp_line
	Drop Table #tmp_calendar

	Return
End

-- Insert ����
Insert	tcalendarwork
Select	AreaCode	= A.AreaCode,
	DivisionCode	= A.DivisionCode,
	WorkCenter	= A.WorkCenter,
	LineCode	= A.LineCode,
	ApplyMonth	= @ps_applymonth,
	ApplyDate	= @ps_applydate,
	DayNo		= @pi_julianday,
	WorkGubun	= @ps_workgubun,
	Remark		= Null,
	LastEmp		= 'Y', --@ps_empno,
	LastDate		= GetDate()
From	#tmp_line	A


If @@Error = 0
Begin
	Select	Error		= '00',
		ErrorText	= 'SUCCESS'
End
Else
Begin
	Select	Error		= '11',
		ErrorText	= 'FAIL'
End

Drop Table #tmp_line
Drop Table #tmp_calendar

Return

End		-- Procedure End
Go
