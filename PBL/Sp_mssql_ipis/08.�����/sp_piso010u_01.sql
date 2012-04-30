/*
	File Name	: sp_piso010u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piso010u_01
	Description	: 지역 마스터 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 04
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piso010u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piso010u_01]
GO

/*
Execute sp_piso010u_01
	@ps_areacode	= '%'
*/

Create Procedure sp_piso010u_01
	@ps_areacode		char(1)		-- 지역

As
Begin

Select	AreaCode	= A.AreaCode,
	AreaName	= A.AreaName,
	AreaNameEng	= A.AreaNameEng,
	SortOrder	= A.SortOrder,
	LastEmp		= A.LastEmp,
	LastDate		= A.LastDate
From	tmstarea		A
Where	A.AreaCode	Like @ps_areacode

Return

End		-- Procedure End

Go