SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pisr001u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pisr001u_02]
GO




/*
Execute sp_pisr001u_02 '2002.09', 'D', 'V', '4201', 'A'
*/

Create Procedure sp_pisr001u_02
	@ps_applymonth	char(7),		-- 계획월 ('YYYY.MM')
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1)		-- 공장 코드
As
Begin

Select	ApplyDate	= A.ApplyDate,
	DayNo		= A.DayNo,
	WorkGubun	= A.WorkGubun
From	tpartcalendar	A
Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.ApplyMonth	= @ps_applymonth
Group By A.ApplyDate, A.DayNo, A.WorkGubun


Return

End		-- Procedure End


GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

