/*
	File Name	: sp_pisi_eis_tplanday.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tplanday
	Description	: EIS Upload tplanday
			  tplanday
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tplanday]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tplanday]
GO

/*
Execute sp_pisi_eis_tplanday
*/

Create Procedure sp_pisi_eis_tplanday

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_plandate		char(10),
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_itemcode		varchar(13),
	@ls_planqty		int,
	@ls_changeqty		int,
	@ls_normalkbcount	int,
	@ls_normalkbqty		int,
	@ls_tempkbcount		int,
	@ls_tempkbqty		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_today		char(10)

create table #tmp_tplanday
(	checkId		int IDENTITY(1,1),
	PlanDate	char (10),
	AreaCode	char (1),
	DivisionCode	char (1),
	WorkCenter	varchar (5),
	LineCode	char (1),
	ItemCode	varchar (12),
	PlanQty		int,
	ChangeQty	int,
	NormalKBCount	int,
	NormalKBQty	int,
	TempKBCount	int,
	TempKBQty	int,
	LastEmp		varchar(6),
	LastDate	datetime	)


select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tplanday
select	*
from	[ipisele_svr\ipis].ipis.dbo.tplanday
where	plandate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_plandate		= plandate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_planqty		= planqty,
		@ls_changeqty		= changeqty,
		@ls_normalkbcount	= normalkbcount,
		@ls_normalkbqty		= normalkbqty,
		@ls_tempkbcount		= tempkbcount,
		@ls_tempkbqty		= tempkbqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tplanday
	Where	checkid > @ls_id

	If not exists (select * from tplanday 
			where	PlanDate	= @ls_plandate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tplanday
			(PlanDate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	PlanQty,	ChangeQty,		NormalKBCount,		NormalKBQty,
			TempKBCount,	TempKBQty,	LastEmp)
		values	(@ls_PlanDate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_PlanQty,	@ls_ChangeQty,		@ls_NormalKBCount,	@ls_NormalKBQty,
			@ls_TempKBCount,@ls_TempKBQty,	@ls_LastEmp)

	Else
		update	tplanday
		set	PlanQty		= @ls_PlanQty,
			ChangeQty	= @ls_ChangeQty,
			NormalKBCount	= @ls_NormalKBCount,
			NormalKBQty	= @ls_NormalKBQty,
			TempKBCount	= @ls_TempKBCount,
			TempKBQty	= @ls_TempKBQty
		where	PlanDate	= @ls_plandate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipisele_svr\ipis].ipis.dbo.tplanday
	set	lastemp 	= 'N'
	where	PlanDate	= @ls_plandate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tplanday


-- 대구기계

Insert	into	#tmp_tplanday
select	*
from	[ipismac_svr\ipis].ipis.dbo.tplanday
where	plandate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_plandate		= plandate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_planqty		= planqty,
		@ls_changeqty		= changeqty,
		@ls_normalkbcount	= normalkbcount,
		@ls_normalkbqty		= normalkbqty,
		@ls_tempkbcount		= tempkbcount,
		@ls_tempkbqty		= tempkbqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tplanday
	Where	checkid > @ls_id

	If not exists (select * from tplanday 
			where	PlanDate	= @ls_plandate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tplanday
			(PlanDate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	PlanQty,	ChangeQty,		NormalKBCount,		NormalKBQty,
			TempKBCount,	TempKBQty,	LastEmp)
		values	(@ls_PlanDate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_PlanQty,	@ls_ChangeQty,		@ls_NormalKBCount,	@ls_NormalKBQty,
			@ls_TempKBCount,@ls_TempKBQty,	@ls_LastEmp)

	Else
		update	tplanday
		set	PlanQty		= @ls_PlanQty,
			ChangeQty	= @ls_ChangeQty,
			NormalKBCount	= @ls_NormalKBCount,
			NormalKBQty	= @ls_NormalKBQty,
			TempKBCount	= @ls_TempKBCount,
			TempKBQty	= @ls_TempKBQty
		where	PlanDate	= @ls_plandate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipismac_svr\ipis].ipis.dbo.tplanday
	set	lastemp 	= 'N'
	where	PlanDate	= @ls_plandate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tplanday


-- 대구압축

Insert	into	#tmp_tplanday
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tplanday
where	plandate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_plandate		= plandate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_planqty		= planqty,
		@ls_changeqty		= changeqty,
		@ls_normalkbcount	= normalkbcount,
		@ls_normalkbqty		= normalkbqty,
		@ls_tempkbcount		= tempkbcount,
		@ls_tempkbqty		= tempkbqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tplanday
	Where	checkid > @ls_id

	If not exists (select * from tplanday 
			where	PlanDate	= @ls_plandate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tplanday
			(PlanDate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	PlanQty,	ChangeQty,		NormalKBCount,		NormalKBQty,
			TempKBCount,	TempKBQty,	LastEmp)
		values	(@ls_PlanDate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_PlanQty,	@ls_ChangeQty,		@ls_NormalKBCount,	@ls_NormalKBQty,
			@ls_TempKBCount,@ls_TempKBQty,	@ls_LastEmp)

	Else
		update	tplanday
		set	PlanQty		= @ls_PlanQty,
			ChangeQty	= @ls_ChangeQty,
			NormalKBCount	= @ls_NormalKBCount,
			NormalKBQty	= @ls_NormalKBQty,
			TempKBCount	= @ls_TempKBCount,
			TempKBQty	= @ls_TempKBQty
		where	PlanDate	= @ls_plandate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipishvac_svr\ipis].ipis.dbo.tplanday
	set	lastemp 	= 'N'
	where	PlanDate	= @ls_plandate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tplanday


-- 진천

Insert	into	#tmp_tplanday
select	*
from	[ipisjin_svr].ipis.dbo.tplanday
where	plandate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_plandate		= plandate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_planqty		= planqty,
		@ls_changeqty		= changeqty,
		@ls_normalkbcount	= normalkbcount,
		@ls_normalkbqty		= normalkbqty,
		@ls_tempkbcount		= tempkbcount,
		@ls_tempkbqty		= tempkbqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tplanday
	Where	checkid > @ls_id

	If not exists (select * from tplanday 
			where	PlanDate	= @ls_plandate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tplanday
			(PlanDate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	PlanQty,	ChangeQty,		NormalKBCount,		NormalKBQty,
			TempKBCount,	TempKBQty,	LastEmp)
		values	(@ls_PlanDate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_PlanQty,	@ls_ChangeQty,		@ls_NormalKBCount,	@ls_NormalKBQty,
			@ls_TempKBCount,@ls_TempKBQty,	@ls_LastEmp)

	Else
		update	tplanday
		set	PlanQty		= @ls_PlanQty,
			ChangeQty	= @ls_ChangeQty,
			NormalKBCount	= @ls_NormalKBCount,
			NormalKBQty	= @ls_NormalKBQty,
			TempKBCount	= @ls_TempKBCount,
			TempKBQty	= @ls_TempKBQty
		where	PlanDate	= @ls_plandate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipisjin_svr].ipis.dbo.tplanday
	set	lastemp 	= 'N'
	where	PlanDate	= @ls_plandate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tplanday
 
End		-- Procedure End

GO
