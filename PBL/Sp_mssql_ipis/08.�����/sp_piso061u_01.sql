/*
	File Name	: sp_piso060u_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso060u_02
	Description	: 단말기/라인 관리 마스터 조회 - 추가 가능 라인 코드
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 18
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso060u_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso060u_02]
GO

/*
Execute sp_piso060u_02
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'M',
	@ps_terminalcode	= '%'

select * from tmstterminal

select * from tmstworkcenter where workcenter = '731E'

*/

Create Procedure sp_piso060u_02
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),
	@ps_terminalcode	varchar(15)

As
Begin

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,
	LineFullName		= A.LineFullName
Into	#tmp_line
From	vmstline		A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName,
	A.WorkCenter, A.WorkCenterName, A.LineCode, A.LineShortName, A.LineFullName

Delete	#tmp_line
From	#tmp_line	A,
	(Select	AreaCode		= A.AreaCode,
		DivisionCode		= A.DivisionCode,
		WorkCenter		= A.WorkCenter,
		LineCode		= A.LineCode
	From	tmstterminalline	A
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.TerminalCode	Like @ps_terminalcode
	Group By A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode)	B
Where	A.AreaCode	= B.AreaCode	And
	A.DivisionCode	= B.DivisionCode	And
	A.WorkCenter	= B.WorkCenter	And
	A.LineCode	= B.LineCode

Select	AreaCode		= A.AreaCode,
	AreaName		= A.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= A.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,
	LineFullName		= A.LineFullName
From	#tmp_line	A

Drop Table #tmp_line

Return

End		-- Procedure End

Go