/*
	File Name	: sp_pisi_eis_tqprogressbadmaster.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tqprogressbadmaster
	Description	: EIS Upload tqprogressbadmaster
			  tqprogressbadmaster
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 12. 23
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tqprogressbadmaster]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tqprogressbadmaster]
GO

/*
Execute sp_pisi_eis_tqprogressbadmaster
*/

Create Procedure sp_pisi_eis_tqprogressbadmaster

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AREACODE			char(1),
	@ls_DIVISIONCODE		char(1),
	@ls_ORIGINATIONDATE		char(10),
	@ls_LARGEGROUPCODE		char(2),
	@ls_MIDDLEGROUPCODE		char(2),
	@ls_SMALLGROUPCODE		char(2),
	@li_PRODUCTQTY		int,
	@li_PROCESSCOST		int,
	@ls_LastEmp			varchar(6),
	@ldt_LastDate			datetime,
	@ls_today			char(10)

create table #tmp_tqprogressbadmaster
(	checkId				int IDENTITY(1,1),
	AREACODE			char(1),   
	DIVISIONCODE			char(1),   
	ORIGINATIONDATE		char(10),  
	LARGEGROUPCODE		char(2),     
	MIDDLEGROUPCODE		char(2),   
	SMALLGROUPCODE		char(2),     
	PRODUCTQTY			int,
	PROCESSCOST			int,         
	LastEmp				varchar(6),
	LastDate				datetime)

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tqprogressbadmaster
select	*
from	[ipisele_svr\ipis].ipis.dbo.tqprogressbadmaster_temp
where	ORIGINATIONDATE 	<= @ls_today
and	lastemp 			= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AREACODE			= AREACODE,
		@ls_DIVISIONCODE		= DIVISIONCODE,
		@ls_ORIGINATIONDATE		= ORIGINATIONDATE,
		@ls_LARGEGROUPCODE		= LARGEGROUPCODE,
		@ls_MIDDLEGROUPCODE		= MIDDLEGROUPCODE,
		@ls_SMALLGROUPCODE		= SMALLGROUPCODE,
		@li_PRODUCTQTY		= PRODUCTQTY,
		@li_PROCESSCOST		= PROCESSCOST,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tqprogressbadmaster
	Where	checkid 				> @li_id

	-- key chk
	If not exists (	select * from tqprogressbadmaster
			where	AREACODE		= @ls_AREACODE			
			and	DIVISIONCODE		= @ls_DIVISIONCODE		
			and	ORIGINATIONDATE	= @ls_ORIGINATIONDATE		
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE		
			and	MIDDLEGROUPCODE	= @ls_MIDDLEGROUPCODE		
			and	SMALLGROUPCODE	= @ls_SMALLGROUPCODE     )

		insert into tqprogressbadmaster
			(AREACODE,		DIVISIONCODE,		ORIGINATIONDATE,		LARGEGROUPCODE,
			MIDDLEGROUPCODE,	SMALLGROUPCODE,	PRODUCTQTY,			PROCESSCOST,
			LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_ORIGINATIONDATE,		@ls_LARGEGROUPCODE,	
		        	@ls_MIDDLEGROUPCODE,	@ls_SMALLGROUPCODE,	@li_PRODUCTQTY,		@li_PROCESSCOST,
			@ls_LastEmp)
	Else
		update	tqprogressbadmaster
		set	PRODUCTQTY			= @li_PRODUCTQTY,
			PROCESSCOST			= @li_PROCESSCOST
		where	AREACODE			= @ls_AREACODE
		and	DIVISIONCODE			= @ls_DIVISIONCODE
		and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE
		and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE
		and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE
		and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE

	update	[ipisele_svr\ipis].ipis.dbo.tqprogressbadmaster_temp
	set	lastemp 				= 'N'
	where	AREACODE			= @ls_AREACODE
	and	DIVISIONCODE			= @ls_DIVISIONCODE
	and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE
	and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE
	and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE
	and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tqprogressbadmaster


-- 대구기계

Insert	into	#tmp_tqprogressbadmaster
select	*
from	[ipismac_svr\ipis].ipis.dbo.tqprogressbadmaster_temp
where	ORIGINATIONDATE <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AREACODE			= AREACODE,
		@ls_DIVISIONCODE		= DIVISIONCODE,
		@ls_ORIGINATIONDATE		= ORIGINATIONDATE,
		@ls_LARGEGROUPCODE		= LARGEGROUPCODE,
		@ls_MIDDLEGROUPCODE		= MIDDLEGROUPCODE,
		@ls_SMALLGROUPCODE		= SMALLGROUPCODE,
		@li_PRODUCTQTY		= PRODUCTQTY,
		@li_PROCESSCOST		= PROCESSCOST,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tqprogressbadmaster
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tqprogressbadmaster
			where	AREACODE			= @ls_AREACODE			
			and	DIVISIONCODE			= @ls_DIVISIONCODE		
			and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE		
			and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE		
			and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE		
			and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE     )

		insert into tqprogressbadmaster
			(AREACODE,		DIVISIONCODE,		ORIGINATIONDATE,		LARGEGROUPCODE,
			MIDDLEGROUPCODE,	SMALLGROUPCODE,	PRODUCTQTY,			PROCESSCOST,
			LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_ORIGINATIONDATE,		@ls_LARGEGROUPCODE,	
			@ls_MIDDLEGROUPCODE,	@ls_SMALLGROUPCODE,	@li_PRODUCTQTY,		@li_PROCESSCOST,
			@ls_LastEmp)
	Else
		update	tqprogressbadmaster
		set	PRODUCTQTY			= @li_PRODUCTQTY,
			PROCESSCOST			= @li_PROCESSCOST
		where	AREACODE			= @ls_AREACODE
		and	DIVISIONCODE			= @ls_DIVISIONCODE
		and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE
		and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE
		and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE
		and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE

	update	[ipisele_svr\ipis].ipis.dbo.tqprogressbadmaster_temp
	set	lastemp 				= 'N'
	where	AREACODE			= @ls_AREACODE
	and	DIVISIONCODE			= @ls_DIVISIONCODE
	and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE
	and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE
	and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE
	and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tqprogressbadmaster


-- 대구압축

Insert	into	#tmp_tqprogressbadmaster
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tqprogressbadmaster_temp
where	ORIGINATIONDATE 	<= @ls_today
and	lastemp 			= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AREACODE			= AREACODE,
		@ls_DIVISIONCODE		= DIVISIONCODE,
		@ls_ORIGINATIONDATE		= ORIGINATIONDATE,
		@ls_LARGEGROUPCODE		= LARGEGROUPCODE,
		@ls_MIDDLEGROUPCODE		= MIDDLEGROUPCODE,
		@ls_SMALLGROUPCODE		= SMALLGROUPCODE,
		@li_PRODUCTQTY		= PRODUCTQTY,
		@li_PROCESSCOST		= PROCESSCOST,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tqprogressbadmaster
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tqprogressbadmaster
			where	AREACODE			= @ls_AREACODE			
			and	DIVISIONCODE			= @ls_DIVISIONCODE		
			and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE		
			and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE		
			and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE		
			and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE     )

		insert into tqprogressbadmaster
			(AREACODE,		DIVISIONCODE,		ORIGINATIONDATE,		LARGEGROUPCODE,
			MIDDLEGROUPCODE,	SMALLGROUPCODE,	PRODUCTQTY,			PROCESSCOST,
			LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_ORIGINATIONDATE,		@ls_LARGEGROUPCODE,	
		        	@ls_MIDDLEGROUPCODE,	@ls_SMALLGROUPCODE,	@li_PRODUCTQTY,		@li_PROCESSCOST,
			@ls_LastEmp)
	Else
		update	tqprogressbadmaster
		set	PRODUCTQTY			= @li_PRODUCTQTY,
			PROCESSCOST			= @li_PROCESSCOST
		where	AREACODE			= @ls_AREACODE
		and	DIVISIONCODE			= @ls_DIVISIONCODE
		and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE
		and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE
		and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE
		and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE

	update	[ipishvac_svr\ipis].ipis.dbo.tqprogressbadmaster_temp
	set	lastemp 				= 'N'
	where	AREACODE			= @ls_AREACODE
	and	DIVISIONCODE			= @ls_DIVISIONCODE
	and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE
	and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE
	and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE
	and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tqprogressbadmaster


-- 진천

Insert	into	#tmp_tqprogressbadmaster
select	*
from	[ipisjin_svr].ipis.dbo.tqprogressbadmaster
where	ORIGINATIONDATE 	<= @ls_today
and	lastemp 			= 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AREACODE			= AREACODE,
		@ls_DIVISIONCODE		= DIVISIONCODE,
		@ls_ORIGINATIONDATE		= ORIGINATIONDATE,
		@ls_LARGEGROUPCODE		= LARGEGROUPCODE,
		@ls_MIDDLEGROUPCODE		= MIDDLEGROUPCODE,
		@ls_SMALLGROUPCODE		= SMALLGROUPCODE,
		@li_PRODUCTQTY		= PRODUCTQTY,
		@li_PROCESSCOST		= PROCESSCOST,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tqprogressbadmaster
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tqprogressbadmaster
			where	AREACODE			= @ls_AREACODE			
			and	DIVISIONCODE			= @ls_DIVISIONCODE		
			and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE		
			and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE		
			and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE		
			and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE     )

		insert into tqprogressbadmaster
			(AREACODE,		DIVISIONCODE,		ORIGINATIONDATE,		LARGEGROUPCODE,
			MIDDLEGROUPCODE,	SMALLGROUPCODE,	PRODUCTQTY,			PROCESSCOST,
			LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_ORIGINATIONDATE,		@ls_LARGEGROUPCODE,	
		        	@ls_MIDDLEGROUPCODE,	@ls_SMALLGROUPCODE,	@li_PRODUCTQTY,		@li_PROCESSCOST,
			@ls_LastEmp)
	Else
		update	tqprogressbadmaster
		set	PRODUCTQTY			= @li_PRODUCTQTY,
			PROCESSCOST			= @li_PROCESSCOST
		where	AREACODE			= @ls_AREACODE
		and	DIVISIONCODE			= @ls_DIVISIONCODE
		and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE
		and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE
		and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE
		and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE
		
	update	[ipisjin_svr].ipis.dbo.tqprogressbadmaster_temp
	set	lastemp 				= 'N'
	where	AREACODE			= @ls_AREACODE
	and	DIVISIONCODE			= @ls_DIVISIONCODE
	and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE
	and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE
	and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE
	and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tqprogressbadmaster
 
End		-- Procedure End
Go
