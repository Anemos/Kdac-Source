/*
	File Name	: sp_pisp021u_01_u.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp021u_01_u
	Description	: Work Calendar 복사를 수행하는 프로시저
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
	@ps_applymonth		char(7),		-- 계획월 ('YYYY.MM')
	@ps_applydate		char(10),	-- 일자 ('YYYY.MM.DD')
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),	-- 조 코드
	@ps_linecode		varchar(1),	-- 라인 코드
	@pi_julianday		int,
	@ps_workgubun		char(1),
	@ps_empno		varchar(6)
As
Begin

Declare	@li_julianday	int

-- 복사하려는 라인을 전부 구한다
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

-- 복사하려는 라인 중에 이미 Work Calendar 에 해당 일자 정보가 있는 것만 구한다.
-- Update 하려는 라인
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


-- 복사하려는 라인 중에 Work Calendar 에 없는 것만 구한다
-- Insert 하려는 라인
Delete	#tmp_line
From	#tmp_line	A,
	#tmp_calendar	B
Where	A.AreaCode	= B.AreaCode
And	A.DivisionCode	= B.DivisionCode
And	A.WorkCenter	= B.WorkCenter
And	A.LineCode	= B.LineCode

-- Update 하자
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

-- Insert 하자
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
