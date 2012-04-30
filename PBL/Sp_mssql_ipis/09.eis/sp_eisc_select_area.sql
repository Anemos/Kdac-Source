/*
	File Name	: sp_eisc_select_area.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_eisc_select_area
	Description	: 지역 코드 DDDW을 위한 조회
			  사번에 따라 권한이 있는 지역만 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_empno, @ps_areacode
	Use Table	: tmstarea
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_eisc_select_area]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_eisc_select_area]
GO

/*
Execute sp_eisc_select_area '%', '%'

select * from tmstarea


Select	LTrim(RTrim(A.AUTAREA))
From	tmstpassword	A
Where	A.EMP_NO	= 'IPIS'
*/

Create Procedure sp_eisc_select_area
	@ps_empcode		varchar(6),	-- 사번
	@ps_areacode		char(1)		-- 지역

As
Begin

Select	AreaCode	= A.AreaCode,
	AreaName	= A.AreaName,
	DisplayName	= A.AreaName + '(' + A.AreaCode + ')'
From	tmstarea		A
Where	A.AreaCode	Like @ps_areacode
Group By A.AreaCode, A.AreaName, A.SortOrder
Order By A.SortOrder

Return

End		-- Procedure End

Go