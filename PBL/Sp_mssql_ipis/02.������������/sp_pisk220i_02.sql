/*
	File Name	: sp_pisk220i_02.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisk220i_02
	Description	: 시간대별 생산 현황 - 그래프
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisk220i_02]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisk220i_02]
GO

/*
Execute sp_pisk220i_02
	@ps_prddate		= '2002.10.15',
	@ps_areacode		= 'D',
	@ps_divisioncode	= 'A',
	@ps_workcenter		= '%',
	@ps_linecode		= '%',
	@ps_itemcode		= '%'

select * from tplanrelease
 where itemcode = '0000001'
select * from tplanday

select linecode, itemcode, sum(releasekbcount)
from tplanrelease
where plandate = '2002.10.14'
group by linecode, itemcode

dbcc opentran

*/

Create Procedure sp_pisk220i_02
	@ps_prddate		char(10),
	@ps_areacode		char(1),		-- 지역 코드
	@ps_divisioncode	char(1),		-- 공장 코드
	@ps_workcenter		varchar(5),
	@ps_linecode		varchar(1),
	@ps_itemcode		varchar(12)

As
Begin

Select	ApplyFrom	= A.ApplyFrom,
	TimeCode	= A.TimeCode,
	TimeOrder	= A.TimeOrder
Into	#tmp_time
From	tmsttime	A
 Where	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.ApplyFrom	<= @ps_prddate		And
	A.ApplyTo	> @ps_prddate

Select	ApplyFrom	= A.ApplyFrom,
	TimeCode	= A.TimeCode,
	PrdQty		= Sum(IsNull(A.PrdQty, 0))
Into	#tmp_prd
From	tprdtime		A
Where	A.PrdDate	= @ps_prddate		And
	A.AreaCode	= @ps_areacode		And
	A.DivisionCode	= @ps_divisioncode	And
	A.WorkCenter	Like @ps_workcenter	And
	A.LineCode	Like @ps_linecode	And
	A.ItemCode	Like @ps_itemcode
Group by A.ApplyFrom, A.TimeCode

Select	ApplyFrom	= A.ApplyFrom,
	TimeCode	= Left(A.TimeCode, 2),
	TimeOrder	= A.TimeOrder,
	PrdQty		= Sum(IsNull(B.PrdQty, 0))
  From	#tmp_time	A,
	#tmp_prd	B
 Where	A.ApplyFrom	*= B.ApplyFrom		And
	A.TimeCode	*= B.TimeCode
Group By A.ApplyFrom, A.TimeCode, A.TimeOrder
Order By A.TimeOrder

drop table #tmp_time
drop table #tmp_prd

Return

End		-- Procedure End
Go
