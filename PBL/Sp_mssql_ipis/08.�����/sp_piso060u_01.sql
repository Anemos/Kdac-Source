/*
	File Name	: sp_piso060u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso060u_01
	Description	: 단말기/라인 관리 마스터 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 18
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso060u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso060u_01]
GO

/*
Execute sp_piso060u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'M',
	@ps_terminalcode	= '%'

select * from tmstterminal

select * from tmstworkcenter where workcenter = '731E'

*/

Create Procedure sp_piso060u_01
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),
	@ps_terminalcode	varchar(15)

As
Begin

Select	TerminalCode		= A.TerminalCode,
	AreaCode		= B.AreaCode,
	AreaName		= B.AreaName,
	DivisionCode		= B.DivisionCode,
	DivisionName		= B.DivisionName,
	WorkCenter		= B.WorkCenter,
	WorkCenterName		= B.WorkCenterName,
	LineCode		= B.LineCode,
	LineShortName		= B.LineShortName,
	LineFullName		= B.LineFullName,
	MainLineGubun		= B.MainLineGubun,
	PrdGatherGubun		= B.PrdGatherGubun,
	LastEmp			= B.LastEmp,
	LastDate			= B.LastDate
From	tmstterminal	A,
	(Select	TerminalCode		= A.TerminalCode,
		AreaCode		= B.AreaCode,
		AreaName		= B.AreaName,
		DivisionCode		= B.DivisionCode,
		DivisionName		= B.DivisionName,
		WorkCenter		= B.WorkCenter,
		WorkCenterName		= B.WorkCenterName,
		LineCode		= B.LineCode,
		LineShortName		= B.LineShortName,
		LineFullName		= B.LineFullName,
		MainLineGubun		= A.MainLineGubun,
		PrdGatherGubun		= A.PrdGatherGubun,
		LastEmp			= A.LastEmp,
		LastDate			= A.LastDate
	From	tmstterminalline	A,
		vmstline		B
	Where	A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.TerminalCode	Like @ps_terminalcode	And
		A.AreaCode	*= B.AreaCode		And
		A.DivisionCode	*= B.DivisionCode	And
		A.WorkCenter	*= B.WorkCenter		And
		A.LineCode	*= B.LineCode
	Group By A.TerminalCode, B.AreaCode, B.AreaName, B.DivisionCode, B.DivisionName,
		B.WorkCenter, B.WorkCenterName, B.LineCode, B.LineShortName, B.LineFullName,
		A.MainLineGubun, A.PrdGatherGubun, A.LastEmp, A.LastDate)	B
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.TerminalCode	Like @ps_terminalcode	And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.TerminalCode	*= B.TerminalCode
Group By A.TerminalCode, B.AreaCode, B.AreaName, B.DivisionCode, B.DivisionName,
	B.WorkCenter, B.WorkCenterName, B.LineCode, B.LineShortName, B.LineFullName,
	B.MainLineGubun, B.PrdGatherGubun, B.LastEmp, B.LastDate
	

Return

End		-- Procedure End

Go