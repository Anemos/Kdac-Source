/*
	File Name	: sp_piso050u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso050u_01
	Description	: 단말기 마스터 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 18
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso050u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso050u_01]
GO

/*
Execute sp_piso050u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= '%',
	@ps_terminalcode	= '%'

select * from tmstterminal

select * from tmstworkcenter where workcenter = '731E'

*/

Create Procedure sp_piso050u_01
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),
	@ps_terminalcode	varchar(15)

As
Begin

Select	AreaCode		= A.AreaCode,
	DivisionCode		= A.DivisionCode,
	TerminalCode		= A.TerminalCode,
	TerminalName		= A.TerminalName,
	TerminalIP		= A.TerminalIP,
	TerminalGubun		= A.TerminalGubun,
	ScannerGubun		= A.ScannerGubun,
	ScannerPort		= A.ScannerPort,
	DIOUseFlag		= A.DIOUseFlag,
	DIOAddress		= A.DIOAddress,
	LastEmp			= A.LastEmp,
	LastDate			= A.LastDate
From	tmstterminal	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	Like @ps_divisioncode	And
	A.TerminalCode	Like @ps_terminalcode

Return

End		-- Procedure End

Go