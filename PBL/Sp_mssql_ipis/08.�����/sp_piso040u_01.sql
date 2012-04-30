/*
	File Name	: sp_piso040u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso040u_01
	Description	: 라인 마스터 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 04
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso040u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso040u_01]
GO

/*
Execute sp_piso040u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'S',
	@ps_workcenter		= '%',
	@ps_linecode		= '%'

select * from tmstline

select * from tmstworkcenter where workcenter = '731E'

*/

Create Procedure sp_piso040u_01
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),
	@ps_workcenter		varchar(5),
	@ps_linecode		char(1)

As
Begin

Select	AreaCode		= A.AreaCode,
	AreaName		= D.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= C.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= B.WorkCenterName,
	LineCode		= A.LineCode,
	LineShortName		= A.LineShortName,
	LineFullName		= A.LineFullName,
	LineID			= A.LineID,
	LineGubun		= A.LineGubun,
	KBUseFlag		= A.KBUseFlag,
	NextRouting		= A.NextRouting,
	SupplyGubun		= A.SupplyGubun,
	HostWorkCenter		= A.HostWorkCenter,
	HostLineCode		= A.HostLineCode,
	CapaQty			= A.CapaQty,
	ShiftCount		= A.ShiftCount,
	ShiftTime		= A.ShiftTime,
	CycleTime		= A.CycleTime,
	JPHQty			= A.JPHQty,
	DisplayCount		= A.DisplayCount,
	MaxCycleGubun		= A.MaxCycleGubun,
	CycleCount		= A.CycleCount,
	LastEmp			= A.LastEmp,
	LastDate			= A.LastDate
From	tmstline		A,
	tmstworkcenter	B,
	tmstdivision	C,
	tmstarea		D
Where	A.AreaCode	Like @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.WorkCenter	= B.WorkCenter		And
	A.AreaCode	= C.AreaCode		And
	A.DivisionCode	= C.DivisionCode		And
	A.AreaCode	= D.AreaCode

Return

End		-- Procedure End

Go