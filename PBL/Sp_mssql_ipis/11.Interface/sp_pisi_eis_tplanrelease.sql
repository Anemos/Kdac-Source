/*
	File Name	: sp_pisi_eis_tplanrelease.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tplanrelease
	Description	: EIS Upload tplanrelease
			  tplanrelease
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tplanrelease]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tplanrelease]
GO

/*
Execute sp_pisi_eis_tplanrelease
*/

Create Procedure sp_pisi_eis_tplanrelease

	
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
	@ls_cycleorder		int,
	@ls_releaseorder	int,
	@ls_itemcode		varchar(12),
	@ls_kbno		varchar(11),
	@ls_kbreleasedate	char(10),
	@ls_kbreleaseseq	int,
	@ls_tempgubun		char(1),
	@ls_releasegubun	char(1),
	@ls_prdflag		char(1),
	@ls_plankbcount		int,
	@ls_plankbqty		int,
	@ls_releasekbcount	int,
	@ls_releasekbqty	int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_today		char(10)

create table #tmp_tplanrelease
(	checkId		int IDENTITY(1,1),
	PlanDate	char (10),
	AreaCode	char (1),
	DivisionCode	char (1),
	WorkCenter	varchar (5),
	LineCode	char (1),
	CycleOrder	int,
	ReleaseOrder	int,
	ItemCode	varchar	(12),
	KBNo		char (11),
	KBReleaseDate	char (10),
	KBReleaseSeq	int,
	TempGubun	char (1),
	ReleaseGubun	char (1),
	PrdFlag		char (1),
	PlanKBCount	int,
	PlanKBQty	int,
	ReleaseKBCount	int,
	ReleaseKBQty	int,
	LastEmp		varchar(6),
	LastDate	datetime	)


select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tplanrelease
select	*
from	[ipisele_svr\ipis].ipis.dbo.tplanrelease
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
		@ls_cycleorder		= cycleorder,
		@ls_releaseorder	= releaseorder,
		@ls_itemcode		= itemcode,
		@ls_kbno		= kbno,
		@ls_kbreleasedate	= kbreleasedate,
		@ls_kbreleaseseq	= kbreleaseseq,
		@ls_tempgubun		= tempgubun,
		@ls_releasegubun	= releasegubun,
		@ls_prdflag		= prdflag,
		@ls_plankbcount		= plankbcount,
		@ls_plankbqty		= plankbqty,
		@ls_releasekbcount	= releasekbcount,
		@ls_releasekbqty	= releasekbqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tplanrelease
	Where	checkid > @ls_id

	If not exists (select * from tplanrelease 
			where	PlanDate	= @ls_plandate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	CycleOrder	= @ls_cycleorder
			and	ReleaseOrder	= @ls_releaseorder)

		insert into tplanrelease
			(PlanDate,		AreaCode,		DivisionCode,		WorkCenter,	
			LineCode,		CycleOrder,		ReleaseOrder,		ItemCode,	
			KBNo,			KBReleaseDate,		KBReleaseSeq,		TempGubun,
			ReleaseGubun,		PrdFlag,		PlanKBCount,		PlanKBQty,	
			ReleaseKBCount,		ReleaseKBQty,		LastEmp)
		values	(@ls_PlanDate,		@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	
			@ls_LineCode,		@ls_cycleorder,		@ls_releaseorder,	@ls_ItemCode,
			@ls_kbno,		@ls_kbreleasedate,	@ls_kbreleaseseq,	@ls_tempgubun,
			@ls_releasegubun,	@ls_prdflag,		@ls_plankbcount,	@ls_plankbqty,
			@ls_releasekbcount,	@ls_releasekbqty,	@ls_LastEmp)

	Else
		update	tplanrelease
		set	ItemCode	= @ls_itemcode,
			KBNO		= @ls_kbno,
			KBReleaseDate	= @ls_kbreleasedate,
			KBReleaseSeq	= @ls_kbreleaseseq,
			TempGubun	= @ls_tempgubun,
			ReleaseGubun	= @ls_releasegubun,
			PrdFlag		= @ls_prdflag,
			PlanKBCount	= @ls_plankbcount,
			PlanKBQty	= @ls_plankbqty,
			ReleaseKBCount	= @ls_releasekbcount,
			ReleaseKBQty	= @ls_releasekbqty
		where	PlanDate	= @ls_plandate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	CycleOrder	= @ls_cycleorder
		and	ReleaseOrder	= @ls_releaseorder
		
	update	[ipisele_svr\ipis].ipis.dbo.tplanrelease
	set	lastemp 	= 'N'
	where	PlanDate	= @ls_plandate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tplanrelease


-- 대구기계

Insert	into	#tmp_tplanrelease
select	*
from	[ipismac_svr\ipis].ipis.dbo.tplanrelease
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
		@ls_cycleorder		= cycleorder,
		@ls_releaseorder	= releaseorder,
		@ls_itemcode		= itemcode,
		@ls_kbno		= kbno,
		@ls_kbreleasedate	= kbreleasedate,
		@ls_kbreleaseseq	= kbreleaseseq,
		@ls_tempgubun		= tempgubun,
		@ls_releasegubun	= releasegubun,
		@ls_prdflag		= prdflag,
		@ls_plankbcount		= plankbcount,
		@ls_plankbqty		= plankbqty,
		@ls_releasekbcount	= releasekbcount,
		@ls_releasekbqty	= releasekbqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tplanrelease
	Where	checkid > @ls_id

	If not exists (select * from tplanrelease 
			where	PlanDate	= @ls_plandate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	CycleOrder	= @ls_cycleorder
			and	ReleaseOrder	= @ls_releaseorder)

		insert into tplanrelease
			(PlanDate,		AreaCode,		DivisionCode,		WorkCenter,	
			LineCode,		CycleOrder,		ReleaseOrder,		ItemCode,	
			KBNo,			KBReleaseDate,		KBReleaseSeq,		TempGubun,
			ReleaseGubun,		PrdFlag,		PlanKBCount,		PlanKBQty,	
			ReleaseKBCount,		ReleaseKBQty,		LastEmp)
		values	(@ls_PlanDate,		@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	
			@ls_LineCode,		@ls_cycleorder,		@ls_releaseorder,	@ls_ItemCode,
			@ls_kbno,		@ls_kbreleasedate,	@ls_kbreleaseseq,	@ls_tempgubun,
			@ls_releasegubun,	@ls_prdflag,		@ls_plankbcount,	@ls_plankbqty,
			@ls_releasekbcount,	@ls_releasekbqty,	@ls_LastEmp)

	Else
		update	tplanrelease
		set	ItemCode	= @ls_itemcode,
			KBNO		= @ls_kbno,
			KBReleaseDate	= @ls_kbreleasedate,
			KBReleaseSeq	= @ls_kbreleaseseq,
			TempGubun	= @ls_tempgubun,
			ReleaseGubun	= @ls_releasegubun,
			PrdFlag		= @ls_prdflag,
			PlanKBCount	= @ls_plankbcount,
			PlanKBQty	= @ls_plankbqty,
			ReleaseKBCount	= @ls_releasekbcount,
			ReleaseKBQty	= @ls_releasekbqty
		where	PlanDate	= @ls_plandate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	CycleOrder	= @ls_cycleorder
		and	ReleaseOrder	= @ls_releaseorder
		
	update	[ipismac_svr\ipis].ipis.dbo.tplanrelease
	set	lastemp 	= 'N'
	where	PlanDate	= @ls_plandate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tplanrelease


-- 대구압축

Insert	into	#tmp_tplanrelease
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tplanrelease
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
		@ls_cycleorder		= cycleorder,
		@ls_releaseorder	= releaseorder,
		@ls_itemcode		= itemcode,
		@ls_kbno		= kbno,
		@ls_kbreleasedate	= kbreleasedate,
		@ls_kbreleaseseq	= kbreleaseseq,
		@ls_tempgubun		= tempgubun,
		@ls_releasegubun	= releasegubun,
		@ls_prdflag		= prdflag,
		@ls_plankbcount		= plankbcount,
		@ls_plankbqty		= plankbqty,
		@ls_releasekbcount	= releasekbcount,
		@ls_releasekbqty	= releasekbqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tplanrelease
	Where	checkid > @ls_id

	If not exists (select * from tplanrelease 
			where	PlanDate	= @ls_plandate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	CycleOrder	= @ls_cycleorder
			and	ReleaseOrder	= @ls_releaseorder)

		insert into tplanrelease
			(PlanDate,		AreaCode,		DivisionCode,		WorkCenter,	
			LineCode,		CycleOrder,		ReleaseOrder,		ItemCode,	
			KBNo,			KBReleaseDate,		KBReleaseSeq,		TempGubun,
			ReleaseGubun,		PrdFlag,		PlanKBCount,		PlanKBQty,	
			ReleaseKBCount,		ReleaseKBQty,		LastEmp)
		values	(@ls_PlanDate,		@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	
			@ls_LineCode,		@ls_cycleorder,		@ls_releaseorder,	@ls_ItemCode,
			@ls_kbno,		@ls_kbreleasedate,	@ls_kbreleaseseq,	@ls_tempgubun,
			@ls_releasegubun,	@ls_prdflag,		@ls_plankbcount,	@ls_plankbqty,
			@ls_releasekbcount,	@ls_releasekbqty,	@ls_LastEmp)

	Else
		update	tplanrelease
		set	ItemCode	= @ls_itemcode,
			KBNO		= @ls_kbno,
			KBReleaseDate	= @ls_kbreleasedate,
			KBReleaseSeq	= @ls_kbreleaseseq,
			TempGubun	= @ls_tempgubun,
			ReleaseGubun	= @ls_releasegubun,
			PrdFlag		= @ls_prdflag,
			PlanKBCount	= @ls_plankbcount,
			PlanKBQty	= @ls_plankbqty,
			ReleaseKBCount	= @ls_releasekbcount,
			ReleaseKBQty	= @ls_releasekbqty
		where	PlanDate	= @ls_plandate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	CycleOrder	= @ls_cycleorder
		and	ReleaseOrder	= @ls_releaseorder
		
	update	[ipishvac_svr\ipis].ipis.dbo.tplanrelease
	set	lastemp 	= 'N'
	where	PlanDate	= @ls_plandate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tplanrelease


-- 진천

Insert	into	#tmp_tplanrelease
select	*
from	[ipisjin_svr].ipis.dbo.tplanrelease
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
		@ls_cycleorder		= cycleorder,
		@ls_releaseorder	= releaseorder,
		@ls_itemcode		= itemcode,
		@ls_kbno		= kbno,
		@ls_kbreleasedate	= kbreleasedate,
		@ls_kbreleaseseq	= kbreleaseseq,
		@ls_tempgubun		= tempgubun,
		@ls_releasegubun	= releasegubun,
		@ls_prdflag		= prdflag,
		@ls_plankbcount		= plankbcount,
		@ls_plankbqty		= plankbqty,
		@ls_releasekbcount	= releasekbcount,
		@ls_releasekbqty	= releasekbqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tplanrelease
	Where	checkid > @ls_id

	If not exists (select * from tplanrelease 
			where	PlanDate	= @ls_plandate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	CycleOrder	= @ls_cycleorder
			and	ReleaseOrder	= @ls_releaseorder)

		insert into tplanrelease
			(PlanDate,		AreaCode,		DivisionCode,		WorkCenter,	
			LineCode,		CycleOrder,		ReleaseOrder,		ItemCode,	
			KBNo,			KBReleaseDate,		KBReleaseSeq,		TempGubun,
			ReleaseGubun,		PrdFlag,		PlanKBCount,		PlanKBQty,	
			ReleaseKBCount,		ReleaseKBQty,		LastEmp)
		values	(@ls_PlanDate,		@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	
			@ls_LineCode,		@ls_cycleorder,		@ls_releaseorder,	@ls_ItemCode,
			@ls_kbno,		@ls_kbreleasedate,	@ls_kbreleaseseq,	@ls_tempgubun,
			@ls_releasegubun,	@ls_prdflag,		@ls_plankbcount,	@ls_plankbqty,
			@ls_releasekbcount,	@ls_releasekbqty,	@ls_LastEmp)

	Else
		update	tplanrelease
		set	ItemCode	= @ls_itemcode,
			KBNO		= @ls_kbno,
			KBReleaseDate	= @ls_kbreleasedate,
			KBReleaseSeq	= @ls_kbreleaseseq,
			TempGubun	= @ls_tempgubun,
			ReleaseGubun	= @ls_releasegubun,
			PrdFlag		= @ls_prdflag,
			PlanKBCount	= @ls_plankbcount,
			PlanKBQty	= @ls_plankbqty,
			ReleaseKBCount	= @ls_releasekbcount,
			ReleaseKBQty	= @ls_releasekbqty
		where	PlanDate	= @ls_plandate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	CycleOrder	= @ls_cycleorder
		and	ReleaseOrder	= @ls_releaseorder
		
	update	[ipisjin_svr].ipis.dbo.tplanrelease
	set	lastemp 	= 'N'
	where	PlanDate	= @ls_plandate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tplanrelease
 
End		-- Procedure End

GO
