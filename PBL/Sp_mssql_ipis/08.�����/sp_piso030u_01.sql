/*
	File Name	: sp_piso030u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso030u_01
	Description	: 조 마스터 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 04
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso030u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso030u_01]
GO

/*
Execute sp_piso030u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'M',
	@ps_workcenter		= '%'

select * from tmstworkcenter

*/

Create Procedure sp_piso030u_01
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),
	@ps_workcenter		varchar(5)

As
Begin

Select	AreaCode		= A.AreaCode,
	AreaName		= C.AreaName,
	DivisionCode		= A.DivisionCode,
	DivisionName		= B.DivisionName,
	WorkCenter		= A.WorkCenter,
	WorkCenterName		= A.WorkCenterName,
	WorkCenterGubun1	= A.WorkCenterGubun1,
	WorkCenterGubun2	= A.WorkCenterGubun2,
	LastEmp			= A.LastEmp,
	LastDate			= A.LastDate
From	tmstworkcenter	A,
	tmstdivision	B,
	tmstarea		C
Where	A.AreaCode	Like @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.AreaCode	= B.AreaCode		And
	A.DivisionCode	= B.DivisionCode		And
	A.AreaCode	= C.AreaCode

Return

End		-- Procedure End

Go