/*
	File Name	: sp_pisp010i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisp010i_02
	Description	: Shop Calendar 을 구한 작업일자별 근무 구분 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 19. 03
	Author		: Kim Jin-Su
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisp010i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisp010i_02]
GO

/*
Execute sp_pisp010i_02 '2002.11', 'D', 'S'
*/

Create Procedure sp_pisp010i_02
	@ps_applymonth		Char(7),		-- 계획월 ('YYYY.MM')
	@ps_areacode		Char(1),		-- 지역 코드
	@ps_divisioncode	Char(1)
As
Begin

Select	ApplyDate	= A.ApplyDate,
	DayNo		= A.DayNo,
	WorkGubun	= A.WorkGubun
From	tcalendarshop	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.ApplyMonth	= @ps_applymonth
Group By A.ApplyDate, A.DayNo, A.WorkGubun
Order By A.ApplyDate


Return

End		-- Procedure End
Go
