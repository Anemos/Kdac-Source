/*
	File Name	: sp_pisc_select_line.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_select_line
	Description	: 라인 코드 DDDW을 위한 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_areacode, @ps_divisioncode, @ps_workcenter, @ps_linecode
	Use Table	: tmstworkcenter
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_line]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_line]
GO

/*
Execute sp_pisc_select_line 'J', '%', '%', '%'
select * from tmstline

*/

Create Procedure sp_pisc_select_line
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),		-- 공장
	@ps_workcenter		varchar(5),	-- 조
	@ps_linecode		varchar(1)	-- 라인
	
As
Begin


Select	AreaCode		= A.AreaCode,		-- 지역 코드
	AreaName		= A.AreaName,		-- 지역 명
	DivisionCode		= A.DivisionCode,		-- 공장코드
	DivisionName		= A.DivisionName,	-- 공장명
	DivisionNameEng		= A.DivisionNameEng,	-- 공장 영문명
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center 명
	LineCode		= A.LineCode,		-- 라인코드
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	DisplayName		= A.LineShortName + '(' + A.AreaCode + A.DivisionCode + A.WorkCenter + A.LineCode + ')'
From	vmstline	A
Where	A.AreaCode		= @ps_areacode		And
	A.DivisionCode		Like @ps_divisioncode	And
	A.WorkCenter		Like @ps_workcenter	And
	A.LineCode		Like @ps_linecode
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.DivisionNameEng, A.WorkCenter, A.WorkCenterName,
		A.LineCode, A.LineShortName, A.LineFullName

Return

End		-- Procedure End
Go
