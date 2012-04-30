/*
	File Name	: sp_pisk240i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk240i_02
	Description	: 일별 생산 추이 (라인별) - 그래프
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 15
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk240i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk240i_02]
GO

/*
Execute sp_pisk240i_02
	@ps_prdyear		= '2002',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '421E',
	@ps_linecode		= 'A',
	@ps_itemcode		= '1104047'

select * from tplanrelease
 where itemcode = '0000001'
select * from tplanday

select linecode, itemcode, sum(releasekbcount)
from tplanrelease
where plandate = '2002.10.14'
group by linecode, itemcode

dbcc opentran

*/

Create Procedure sp_pisk240i_02
	@ps_prdyear		char(4),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

Declare	@i		int,
	@ls_prdmonth	char(7)

Create Table #tmp_month
(	PrdMonth		char(7)
)


Select	@i = 1
While @i <= 12
Begin
	Select	@ls_prdmonth	= @ps_prdyear + '.' +Right('00' + Convert(varchar(2), @i), 2)

	Insert	#tmp_month
	Select	PrdMonth	= @ls_prdmonth

	Select	@i	= @i + 1
End




Select	PrdDate		= Left(A.PlanDate, 7),
	PlanQty		= Sum(A.PlanQty),
	PrdQty		= IsNull(Sum(IsNull(B.PrdQty, 0)), 0)
Into	#tmp_prd
From	(Select	PlanDate		= A.PlanDate,
		AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
		WorkCenter		= A.WorkCenter,		-- Work Center
		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PlanQty			= Sum(A.ReleaseKBQty)
	From	tplanrelease	A
	Where	A.PlanDate	Like @ps_prdyear + '.__.__'	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode	And
		A.ItemCode	= @ps_itemcode	And
	--	A.ReleaseGubun	In ('Y', 'T', 'U', 'N')
		A.ReleaseGubun	> 'C'
	Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode)	A,	
	(Select	PrdDate			= A.PrdDate,
		AreaCode		= A.AreaCode,		-- 지역코드
		DivisionCode		= A.DivisionCode,		-- 공장
		WorkCenter		= A.WorkCenter,		-- Work Center
		LineCode		= A.LineCode,		-- 라인
		ItemCode		= A.ItemCode,
		PrdQty			= Sum(A.PrdQty)
	From	tprd		A
	Where	A.PrdDate	Like @ps_prdyear + '.__.__'	And
		A.AreaCode	= @ps_areacode		And
		A.DivisionCode	= @ps_divisioncode	And
		A.WorkCenter	= @ps_workcenter	And
		A.LineCode	= @ps_linecode	And
		A.ItemCode	= @ps_itemcode
	Group By A.PrdDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode)	B
Where	A.PlanDate	*= B.PrdDate		And
	A.AreaCode	*= B.AreaCode		And
	A.DivisionCode	*= B.DivisionCode	And
	A.WorkCenter	*= B.WorkCenter		And
	A.LineCode	*= B.LineCode		And
	A.ItemCode	*= B.ItemCode
Group By A.PlanDate, A.AreaCode, A.DivisionCode, A.WorkCenter, A.LineCode, A.ItemCode


Select	PrdDate		= B.PrdMonth,
	PlanQty		= IsNull(Sum(IsNull(A.PlanQty, 0)), 0),
	PrdQty		= IsNull(Sum(IsNull(A.PrdQty, 0)), 0)
Into	#tmp_result
From	#tmp_prd	A,
	#tmp_month	B
Where	A.PrdDate	=* B.PrdMonth
Group By B.PrdMonth


Select	PrdDate		= Right(A.PrdDate, 2),
	PlanQty		= Sum(B.PlanQty),
	PrdQty		= Sum(B.PrdQty)
  From	#tmp_result	A,
	#tmp_result	B
 Where	A.PrdDate	>= B.PrdDate
Group By A.PrdDate

drop table #tmp_month
drop table #tmp_prd
drop table #tmp_result

Return

End		-- Procedure End
Go
