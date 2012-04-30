/*
	File Name	: sp_piso020u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso020u_01
	Description	: 공장 마스터 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 04
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso020u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso020u_01]
GO

/*
Execute sp_piso020u_01
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'M'

select * from tmstdivision

*/

Create Procedure sp_piso020u_01
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1)

As
Begin

Select	AreaCode	= A.AreaCode,
	AreaName	= B.AreaName,
	DivisionCode	= A.DivisionCode,
	DivisionName	= A.DivisionName,
	DivisionNameEng	= A.DivisionNameEng,
	DivisionGubun	= A.DivisionGubun,
	LotAreaGubun	= A.LotAreaGubun,
	DisplayFlag	= A.DisplayFlag,
	SortOrder	= A.SortOrder,
	ServerName	= A.ServerName,
	LastEmp		= A.LastEmp,
	LastDate		= A.LastDate
From	tmstdivision	A,
	tmstarea		B
Where	A.AreaCode	Like @ps_areacode	And
	A.DivisionCode	Like @ps_divisioncode	And
	A.AreaCode	= B.AreaCode

Return

End		-- Procedure End

Go