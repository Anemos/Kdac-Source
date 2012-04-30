/*
	File Name	: sp_pisi_eis_tmstworkcenter.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmstworkcenter
	Description	: EIS Upload tmstworkcenter
			  tmstworkcenter
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmstworkcenter]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmstworkcenter]
GO

/*
Execute sp_pisi_eis_tmstworkcenter
*/

Create Procedure sp_pisi_eis_tmstworkcenter

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_workcenter		varchar(5),
	@ls_workcentername	varchar(30),
	@ls_workcentergubun1	char(1),
	@ls_workcentergubun2	char(1),
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

-- 각 서버 tdelete에서 tablename이 tmstworkcenter인 놈 정리하고...

create table #tmp_tmstworkcenter
(	checkId			int IDENTITY(1,1),
	AreaCode		char (1),
	DivisionCode		char (1),
	WorkCenter		varchar(5),
	WorkCenterName		varchar(30),
	WorkCenterGubun1	char(1),
	WorkCenterGubun2	char(2),	
	LastEmp		varchar(6),
	LastDate	datetime	)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmstworkcenter
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstworkcenter
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_workcentername	= workcentername,
		@ls_workcentergubun1	= workcentergubun1,
		@ls_workcentergubun2	= workcentergubun2,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstworkcenter
	Where	checkid > @ls_id

	If not exists (select * from tmstworkcenter 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	workcenter	= @ls_workcenter)

		insert into tmstworkcenter
			(AreaCode,		DivisionCode,		workcenter,	workcentername,
			workcentergubun1,	workcentergubun2,	LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_workcenter,	@ls_workcentername,
			@ls_workcentergubun1,	@ls_workcentergubun2,	@ls_LastEmp)

	Else
		update	tmstworkcenter
		set	workcentername		= @ls_workcentername,
			workcentergubun1	= @ls_workcentergubun1,
			workcentergubun2	= @ls_workcentergubun2
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	workcenter	= @ls_workcenter
		
	update	[ipisele_svr\ipis].ipis.dbo.tmstworkcenter
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	workcenter	= @ls_workcenter
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstworkcenter


-- 대구기계

Insert	into	#tmp_tmstworkcenter
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstworkcenter
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_workcentername	= workcentername,
		@ls_workcentergubun1	= workcentergubun1,
		@ls_workcentergubun2	= workcentergubun2,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstworkcenter
	Where	checkid > @ls_id

	If not exists (select * from tmstworkcenter 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	workcenter	= @ls_workcenter)

		insert into tmstworkcenter
			(AreaCode,		DivisionCode,		workcenter,	workcentername,
			workcentergubun1,	workcentergubun2,	LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_workcenter,	@ls_workcentername,
			@ls_workcentergubun1,	@ls_workcentergubun2,	@ls_LastEmp)

	Else
		update	tmstworkcenter
		set	workcentername		= @ls_workcentername,
			workcentergubun1	= @ls_workcentergubun1,
			workcentergubun2	= @ls_workcentergubun2
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	workcenter	= @ls_workcenter
		
	update	[ipismac_svr\ipis].ipis.dbo.tmstworkcenter
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	workcenter	= @ls_workcenter
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstworkcenter


-- 대구압축

Insert	into	#tmp_tmstworkcenter
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstworkcenter
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_workcentername	= workcentername,
		@ls_workcentergubun1	= workcentergubun1,
		@ls_workcentergubun2	= workcentergubun2,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstworkcenter
	Where	checkid > @ls_id

	If not exists (select * from tmstworkcenter 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	workcenter	= @ls_workcenter)

		insert into tmstworkcenter
			(AreaCode,		DivisionCode,		workcenter,	workcentername,
			workcentergubun1,	workcentergubun2,	LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_workcenter,	@ls_workcentername,
			@ls_workcentergubun1,	@ls_workcentergubun2,	@ls_LastEmp)

	Else
		update	tmstworkcenter
		set	workcentername		= @ls_workcentername,
			workcentergubun1	= @ls_workcentergubun1,
			workcentergubun2	= @ls_workcentergubun2
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	workcenter	= @ls_workcenter
		
	update	[ipishvac_svr\ipis].ipis.dbo.tmstworkcenter
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	workcenter	= @ls_workcenter
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstworkcenter


-- 진천

Insert	into	#tmp_tmstworkcenter
select	*
from	[ipisjin_svr].ipis.dbo.tmstworkcenter
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_workcentername	= workcentername,
		@ls_workcentergubun1	= workcentergubun1,
		@ls_workcentergubun2	= workcentergubun2,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstworkcenter
	Where	checkid > @ls_id

	If not exists (select * from tmstworkcenter 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	workcenter	= @ls_workcenter)

		insert into tmstworkcenter
			(AreaCode,		DivisionCode,		workcenter,	workcentername,
			workcentergubun1,	workcentergubun2,	LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_workcenter,	@ls_workcentername,
			@ls_workcentergubun1,	@ls_workcentergubun2,	@ls_LastEmp)

	Else
		update	tmstworkcenter
		set	workcentername		= @ls_workcentername,
			workcentergubun1	= @ls_workcentergubun1,
			workcentergubun2	= @ls_workcentergubun2
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	workcenter	= @ls_workcenter
		
	update	[ipisjin_svr].ipis.dbo.tmstworkcenter
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	workcenter	= @ls_workcenter
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmstworkcenter
 
End		-- Procedure End
Go
