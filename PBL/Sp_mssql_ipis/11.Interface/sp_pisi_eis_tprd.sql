/*
	File Name	: sp_pisi_eis_tprd.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tprd
	Description	: EIS Upload tprd
			  tprd
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tprd]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tprd]
GO

/*
Execute sp_pisi_eis_tprd
*/

Create Procedure sp_pisi_eis_tprd

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_prddate		char(10),
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_itemcode		varchar(13),
	@ls_planqty		int,
	@ls_prdqty		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_today		char(10)

create table #tmp_tprd
(	checkId		int IDENTITY(1,1),
	PrdDate		char (10),
	AreaCode	char (1),
	DivisionCode	char (1),
	WorkCenter	varchar (5),
	LineCode	char (1),
	ItemCode	varchar (12),
	PlanQty		int,
	PrdQty		int,
	LastEmp		varchar(6),
	LastDate	datetime	)

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tprd
select	*
from	[ipisele_svr\ipis].ipis.dbo.tprd
where	prddate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_prddate		= prddate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_planqty		= planqty,
		@ls_prdqty		= prdqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprd
	Where	checkid > @ls_id

	If not exists (select * from tprd 
			where	prddate	= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tprd
			(prddate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	PlanQty,	prdqty,			LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_PlanQty,	@ls_prdqty,		@ls_LastEmp)

	Else
		update	tprd
		set	PlanQty		= @ls_PlanQty,
			prdqty		= @ls_prdqty
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipisele_svr\ipis].ipis.dbo.tprd
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprd


-- 대구기계

Insert	into	#tmp_tprd
select	*
from	[ipismac_svr\ipis].ipis.dbo.tprd
where	prddate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_prddate		= prddate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_planqty		= planqty,
		@ls_prdqty		= prdqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprd
	Where	checkid > @ls_id

	If not exists (select * from tprd 
			where	prddate	= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tprd
			(prddate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	PlanQty,	prdqty,			LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_PlanQty,	@ls_prdqty,		@ls_LastEmp)

	Else
		update	tprd
		set	PlanQty		= @ls_PlanQty,
			prdqty		= @ls_prdqty
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipismac_svr\ipis].ipis.dbo.tprd
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprd


-- 대구압축

Insert	into	#tmp_tprd
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tprd
where	prddate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_prddate		= prddate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_planqty		= planqty,
		@ls_prdqty		= prdqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprd
	Where	checkid > @ls_id

	If not exists (select * from tprd 
			where	prddate	= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tprd
			(prddate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	PlanQty,	prdqty,			LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_PlanQty,	@ls_prdqty,		@ls_LastEmp)

	Else
		update	tprd
		set	PlanQty		= @ls_PlanQty,
			prdqty		= @ls_prdqty
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipishvac_svr\ipis].ipis.dbo.tprd
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tprd


-- 진천

Insert	into	#tmp_tprd
select	*
from	[ipisjin_svr].ipis.dbo.tprd
where	prddate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_prddate		= prddate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_itemcode		= itemcode,
		@ls_planqty		= planqty,
		@ls_prdqty		= prdqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tprd
	Where	checkid > @ls_id

	If not exists (select * from tprd 
			where	prddate	= @ls_prddate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tprd
			(prddate,	AreaCode,	DivisionCode,		WorkCenter,		LineCode,
			ItemCode,	PlanQty,	prdqty,			LastEmp)
		values	(@ls_prddate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_WorkCenter,		@ls_LineCode,
			@ls_ItemCode,	@ls_PlanQty,	@ls_prdqty,		@ls_LastEmp)

	Else
		update	tprd
		set	PlanQty		= @ls_PlanQty,
			prdqty		= @ls_prdqty
		where	prddate		= @ls_prddate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipisjin_svr].ipis.dbo.tprd
	set	lastemp 	= 'N'
	where	prddate		= @ls_prddate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tprd
 
End		-- Procedure End
Go
