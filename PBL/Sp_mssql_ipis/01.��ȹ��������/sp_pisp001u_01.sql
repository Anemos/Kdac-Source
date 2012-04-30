/*
	File Name	: sp_pisp001u_01.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp001u_01
	Description	: 계획분배율을 위한 제품 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 09. 10
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp001u_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp001u_01]
GO


/*
Execute sp_pisp001u_01 'D', 'A', '%'
select * from tmstmodelgroup

*/


Create Procedure sp_pisp001u_01
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),		-- 공장
--	@ps_workcenter		varchar(5),	-- 제품군
--	@ps_linecode		varchar(1),	-- 모델군
	@ps_itemcode		varchar(12)	-- 품번
	
As
Begin

Select	AreaCode		= A.AreaCode,			-- 지역코드
	AreaName		= A.AreaName,			-- 지역명
	DivisionCode		= A.DivisionCode,			-- 공장코드
	DivisionName		= A.DivisionName,			-- 공장명
	WorkCenter		= A.WorkCenter,		-- Work Center
	WorkCenterName		= A.WorkCenterName,	-- Work Center 명
	LineCode		= A.LineCode,		-- 라인
	LineShortName		= A.LineShortName,	-- 라인 약명
	LineFullName		= A.LineFullName,		-- 라인 전명
	ItemCode		= A.ItemCode,			-- 품번
	ItemName		= A.ItemName,			-- 품명
	ModelID			= A.ModelID,			-- 식별 ID
	MainLineGubun		= Case When A.MainLineGubun = 'M' Then '주라인' Else '부라인' End,	-- 주라인 구분
	DivideRate		= A.DivideRate
  From	vmstkb_line	A
 Where	A.AreaCode		= @ps_areacode			And
	A.DivisionCode		Like @ps_divisioncode		And
--	A.WorkCenter		Like @ps_workcenter		And
--	A.LineCode		Like @ps_linecode		And
	A.ItemCode		Like @ps_itemcode		And
	A.PrdStopGubun		= 'N'
Group By A.AreaCode, A.AreaName, A.DivisionCode, A.DivisionName, A.WorkCenter, A.WorkCenterName,
	A.LineCode, A.LineShortName, A.LineFullName, A.ItemCode, A.ItemName, A.ModelID,A.MainLineGubun, A.DivideRate

Return

End		-- Procedure End
Go
