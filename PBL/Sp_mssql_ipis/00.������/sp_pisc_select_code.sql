/*
	File Name	: sp_pisc_select_code.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_select_code
	Description	: 코드그룹 DDDW을 위한 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_codegroup, @ps_codeid
	Use Table	: tmstworkcenter
	Initial		: 2002. 09. 03
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_code]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_code]
GO

/*
Execute sp_pisc_select_code '%', '%', '%', '%'
select * from tmstline

*/


Create Procedure sp_pisc_select_code
	@ps_areacode		char(1),		-- 지역
	@ps_divisioncode	char(1),		-- 공장
	@ps_codegroup		varchar(10),	-- 코드 그룹
	@ps_codeid		varchar(10)	-- 코드 마스터
	
As
Begin


Select	CodeGroup		= A.CodeGroup,
	CodeGroupName		= A.CodeGroupName,
	CodeID			= A.CodeID,
	CodeName		= A.CodeName,
	CodeRef01		= A.CodeRef01,
	CodeRef02		= A.CodeRef02,
	CodeRef03		= A.CodeRef03,
	DisplayName		= A.CodeName + '(' + A.CodeID + ')'
  From	tmstcode	A
 Where	A.CodeGroup	Like @ps_codegroup	And
	A.CodeID	Like @ps_codeid
Group By A.CodeGroup, A.CodeGroupName, A.CodeID, A.CodeName, A.CodeRef01, A.CodeRef02, A.CodeRef03

Return

End		-- Procedure End
Go
