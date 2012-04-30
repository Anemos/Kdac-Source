/*
	File Name	: sp_pisi_eis_tqprogressbaddetail.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tqprogressbaddetail
	Description	: EIS Upload tqprogressbaddetail
			  tqprogressbaddetail
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tqprogressbaddetail]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tqprogressbaddetail]
GO

/*
Execute sp_pisi_eis_tqprogressbaddetail
*/

Create Procedure sp_pisi_eis_tqprogressbaddetail

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
	@ls_PROCESSCODE		char(4),
	@ls_BADREASONCODE		char(1),
	@li_BADTYPECODE		char(2),
	@li_MEMO			varchar(30),
	@li_REPAIRQTY			int,
	@ls_DISUSEQTY			int,
	@ls_TOTALQTY			int,
	@ls_PROCESSCOST		int,
	@ls_LastEmp			varchar(6),
	@ldt_LastDate			datetime,
	@ls_today			char(10)

create table #tmp_tqprogressbaddetail
(	checkId				int IDENTITY(1,1),
	AREACODE			char(1),    
	DIVISIONCODE	        		char(1),    
	ORIGINATIONDATE	        	char(10),   
	LARGEGROUPCODE	        	char(2),    
	MIDDLEGROUPCODE	        	char(2),    
	SMALLGROUPCODE	        	char(2),    
	PROCESSCODE			char(4),    
	BADREASONCODE	        	char(1),    
	BADTYPECODE			char(2),    
	MEMO		        		varchar(30),
	REPAIRQTY			int,        
	DISUSEQTY			int,        
	TOTALQTY			int,        
	PROCESSCOST			int,        
	LastEmp				varchar(6), 
	LastDate				datetime,   )

select	@ls_today = convert(char(10), getdate(), 102)
                                                        
-- 대구전장	

Insert	into	#tmp_tqprogressbaddetail
select	*
from	[ipisele_svr\ipis].ipis.dbo.tqprogressbaddetail_temp
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
		@ls_PROCESSCODE		= PROCESSCODE,
		@ls_BADREASONCODE		= BADREASONCODE,
		@li_BADTYPECODE		= BADTYPECODE,
		@li_MEMO			= MEMO,
		@li_REPAIRQTY			= REPAIRQTY,
		@ls_DISUSEQTY			= DISUSEQTY,
		@ls_TOTALQTY			= TOTALQTY,
		@ls_PROCESSCOST		= PROCESSCOST,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tqprogressbaddetail
	Where	checkid > @li_id

	-- key chk
	If not exists (	select * from tqprogressbaddetail
			where	AREACODE		= @ls_AREACODE		
			and	DIVISIONCODE		= @ls_DIVISIONCODE	
			and	ORIGINATIONDATE	= @ls_ORIGINATIONDATE	
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE	
			and	MIDDLEGROUPCODE	= @ls_MIDDLEGROUPCODE	
			and	SMALLGROUPCODE	= @ls_SMALLGROUPCODE	
			and	PROCESSCODE		= @ls_PROCESSCODE		
			and	BADREASONCODE	= @ls_BADREASONCODE	
			and	BADTYPECODE		= @li_BADTYPECODE	)

		insert into tqprogressbaddetail
			(AREACODE,		DIVISIONCODE,		ORIGINATIONDATE,		LARGEGROUPCODE,
			MIDDLEGROUPCODE,	SMALLGROUPCODE,	PROCESSCODE,			BADREASONCODE,
			BADTYPECODE,		MEMO,			REPAIRQTY,			DISUSEQTY,
			TOTALQTY,		PROCESSCOST,		LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_ORIGINATIONDATE,		@ls_LARGEGROUPCODE,
			@ls_MIDDLEGROUPCODE,	@ls_SMALLGROUPCODE,	@ls_PROCESSCODE,		@ls_BADREASONCODE,
			@li_BADTYPECODE,	@li_MEMO,		@li_REPAIRQTY,			@ls_DISUSEQTY,
			@ls_TOTALQTY,		@ls_PROCESSCOST,	@ls_lastemp)
	Else
		update	tqprogressbaddetail
		set	MEMO       			= @li_MEMO,
			REPAIRQTY  			= @li_REPAIRQTY,
			DISUSEQTY  			= @ls_DISUSEQTY,
			TOTALQTY   			= @ls_TOTALQTY,
			PROCESSCOST			= @ls_PROCESSCOST
		where	AREACODE			= @ls_AREACODE		
		and	DIVISIONCODE			= @ls_DIVISIONCODE	
		and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE	
		and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE	
		and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE	
		and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE	
		and	PROCESSCODE			= @ls_PROCESSCODE		
		and	BADREASONCODE		= @ls_BADREASONCODE	
		and	BADTYPECODE			= @li_BADTYPECODE

	update	[ipisele_svr\ipis].ipis.dbo.tqprogressbaddetail_temp
	set	lastemp 			= 'N'
	where	AREACODE		= @ls_AREACODE		
	and	DIVISIONCODE		= @ls_DIVISIONCODE	
	and	ORIGINATIONDATE	= @ls_ORIGINATIONDATE	
	and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE	
	and	MIDDLEGROUPCODE	= @ls_MIDDLEGROUPCODE	
	and	SMALLGROUPCODE	= @ls_SMALLGROUPCODE	
	and	PROCESSCODE		= @ls_PROCESSCODE		
	and	BADREASONCODE	= @ls_BADREASONCODE	
	and	BADTYPECODE		= @li_BADTYPECODE
	and	LastEmp 		= 'Y'

End	-- while loop end

truncate table #tmp_tqprogressbaddetail


-- 대구기계

Insert	into	#tmp_tqprogressbaddetail
select	*
from	[ipismac_svr\ipis].ipis.dbo.tqprogressbaddetail_temp
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
		@ls_PROCESSCODE		= PROCESSCODE,
		@ls_BADREASONCODE		= BADREASONCODE,
		@li_BADTYPECODE		= BADTYPECODE,
		@li_MEMO			= MEMO,
		@li_REPAIRQTY			= REPAIRQTY,
		@ls_DISUSEQTY			= DISUSEQTY,
		@ls_TOTALQTY			= TOTALQTY,
		@ls_PROCESSCOST		= PROCESSCOST,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tqprogressbaddetail
	Where	checkid 				> @li_id

	-- key chk
	If not exists (	select * from tqprogressbaddetail
			where	AREACODE		= @ls_AREACODE		
			and	DIVISIONCODE		= @ls_DIVISIONCODE	
			and	ORIGINATIONDATE	= @ls_ORIGINATIONDATE	
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE	
			and	MIDDLEGROUPCODE	= @ls_MIDDLEGROUPCODE	
			and	SMALLGROUPCODE	= @ls_SMALLGROUPCODE	
			and	PROCESSCODE		= @ls_PROCESSCODE		
			and	BADREASONCODE	= @ls_BADREASONCODE	
			and	BADTYPECODE		= @li_BADTYPECODE	)

		insert into tqprogressbaddetail
			(AREACODE,		DIVISIONCODE,		ORIGINATIONDATE,		LARGEGROUPCODE,
			MIDDLEGROUPCODE,	SMALLGROUPCODE,	PROCESSCODE,			BADREASONCODE,
			BADTYPECODE,		MEMO,			REPAIRQTY,			DISUSEQTY,
			TOTALQTY,		PROCESSCOST,		LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_ORIGINATIONDATE,		@ls_LARGEGROUPCODE,
			@ls_MIDDLEGROUPCODE,	@ls_SMALLGROUPCODE,	@ls_PROCESSCODE,		@ls_BADREASONCODE,
			@li_BADTYPECODE,	@li_MEMO,		@li_REPAIRQTY,			@ls_DISUSEQTY,
			@ls_TOTALQTY,		@ls_PROCESSCOST,	@ls_lastemp)
	Else
		update	tqprogressbaddetail
		set	MEMO       			= @li_MEMO,
			REPAIRQTY  			= @li_REPAIRQTY,
			DISUSEQTY  			= @ls_DISUSEQTY,
			TOTALQTY   			= @ls_TOTALQTY,
			PROCESSCOST			= @ls_PROCESSCOST
		where	AREACODE			= @ls_AREACODE		
		and	DIVISIONCODE			= @ls_DIVISIONCODE	
		and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE	
		and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE	
		and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE	
		and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE	
		and	PROCESSCODE			= @ls_PROCESSCODE		
		and	BADREASONCODE		= @ls_BADREASONCODE	
		and	BADTYPECODE			= @li_BADTYPECODE

	update	[ipismac_svr\ipis].ipis.dbo.tqprogressbaddetail_temp
	set	lastemp 				= 'N'
	where	AREACODE			= @ls_AREACODE		
	and	DIVISIONCODE			= @ls_DIVISIONCODE	
	and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE	
	and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE	
	and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE	
	and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE	
	and	PROCESSCODE			= @ls_PROCESSCODE		
	and	BADREASONCODE		= @ls_BADREASONCODE	
	and	BADTYPECODE			= @li_BADTYPECODE
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tqprogressbaddetail


-- 대구압축

Insert	into	#tmp_tqprogressbaddetail
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tqprogressbaddetail_temp
where	ORIGINATIONDATE 	<= @ls_today
and	lastemp 		= 'Y'

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
		@ls_PROCESSCODE		= PROCESSCODE,
		@ls_BADREASONCODE		= BADREASONCODE,
		@li_BADTYPECODE		= BADTYPECODE,
		@li_MEMO			= MEMO,
		@li_REPAIRQTY			= REPAIRQTY,
		@ls_DISUSEQTY			= DISUSEQTY,
		@ls_TOTALQTY			= TOTALQTY,
		@ls_PROCESSCOST		= PROCESSCOST,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tqprogressbaddetail
	Where	checkid 				> @li_id

	-- key chk
	If not exists (	select * from tqprogressbaddetail
			where	AREACODE		= @ls_AREACODE		
			and	DIVISIONCODE		= @ls_DIVISIONCODE	
			and	ORIGINATIONDATE	= @ls_ORIGINATIONDATE	
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE	
			and	MIDDLEGROUPCODE	= @ls_MIDDLEGROUPCODE	
			and	SMALLGROUPCODE	= @ls_SMALLGROUPCODE	
			and	PROCESSCODE		= @ls_PROCESSCODE		
			and	BADREASONCODE	= @ls_BADREASONCODE	
			and	BADTYPECODE		= @li_BADTYPECODE	)

		insert into tqprogressbaddetail
			(AREACODE,		DIVISIONCODE,		ORIGINATIONDATE,		LARGEGROUPCODE,
			MIDDLEGROUPCODE,	SMALLGROUPCODE,	PROCESSCODE,			BADREASONCODE,
			BADTYPECODE,		MEMO,			REPAIRQTY,			DISUSEQTY,
			TOTALQTY,		PROCESSCOST,		LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_ORIGINATIONDATE,		@ls_LARGEGROUPCODE,
			@ls_MIDDLEGROUPCODE,	@ls_SMALLGROUPCODE,	@ls_PROCESSCODE,		@ls_BADREASONCODE,
			@li_BADTYPECODE,	@li_MEMO,		@li_REPAIRQTY,			@ls_DISUSEQTY,
			@ls_TOTALQTY,		@ls_PROCESSCOST,	@ls_lastemp)
	Else
		update	tqprogressbaddetail
		set	MEMO       			= @li_MEMO,
			REPAIRQTY  			= @li_REPAIRQTY,
			DISUSEQTY  			= @ls_DISUSEQTY,
			TOTALQTY   			= @ls_TOTALQTY,
			PROCESSCOST			= @ls_PROCESSCOST
		where	AREACODE			= @ls_AREACODE		
		and	DIVISIONCODE			= @ls_DIVISIONCODE	
		and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE	
		and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE	
		and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE	
		and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE	
		and	PROCESSCODE			= @ls_PROCESSCODE		
		and	BADREASONCODE		= @ls_BADREASONCODE	
		and	BADTYPECODE			= @li_BADTYPECODE

	update	[ipishvac_svr\ipis].ipis.dbo.tqprogressbaddetail_temp
	set	lastemp 				= 'N'
	where	AREACODE			= @ls_AREACODE		
	and	DIVISIONCODE			= @ls_DIVISIONCODE	
	and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE	
	and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE	
	and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE	
	and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE	
	and	PROCESSCODE			= @ls_PROCESSCODE		
	and	BADREASONCODE		= @ls_BADREASONCODE	
	and	BADTYPECODE			= @li_BADTYPECODE
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tqprogressbaddetail


-- 진천

Insert	into	#tmp_tqprogressbaddetail
select	*
from	[ipisjin_svr].ipis.dbo.tqprogressbaddetail_temp
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
		@ls_PROCESSCODE		= PROCESSCODE,
		@ls_BADREASONCODE		= BADREASONCODE,
		@li_BADTYPECODE		= BADTYPECODE,
		@li_MEMO			= MEMO,
		@li_REPAIRQTY			= REPAIRQTY,
		@ls_DISUSEQTY			= DISUSEQTY,
		@ls_TOTALQTY			= TOTALQTY,
		@ls_PROCESSCOST		= PROCESSCOST,
		@ls_LastEmp			= LastEmp,
		@li_id				= checkid
	From	#tmp_tqprogressbaddetail
	Where	checkid 				> @li_id

	-- key chk
	If not exists (	select * from tqprogressbaddetail
			where	AREACODE		= @ls_AREACODE		
			and	DIVISIONCODE		= @ls_DIVISIONCODE	
			and	ORIGINATIONDATE	= @ls_ORIGINATIONDATE	
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE	
			and	MIDDLEGROUPCODE	= @ls_MIDDLEGROUPCODE	
			and	SMALLGROUPCODE	= @ls_SMALLGROUPCODE	
			and	PROCESSCODE		= @ls_PROCESSCODE		
			and	BADREASONCODE	= @ls_BADREASONCODE	
			and	BADTYPECODE		= @li_BADTYPECODE	)

		insert into tqprogressbaddetail
			(AREACODE,		DIVISIONCODE,		ORIGINATIONDATE,		LARGEGROUPCODE,
			MIDDLEGROUPCODE,	SMALLGROUPCODE,	PROCESSCODE,			BADREASONCODE,
			BADTYPECODE,		MEMO,			REPAIRQTY,			DISUSEQTY,
			TOTALQTY,		PROCESSCOST,		LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_ORIGINATIONDATE,		@ls_LARGEGROUPCODE,
			@ls_MIDDLEGROUPCODE,	@ls_SMALLGROUPCODE,	@ls_PROCESSCODE,		@ls_BADREASONCODE,
			@li_BADTYPECODE,	@li_MEMO,		@li_REPAIRQTY,			@ls_DISUSEQTY,
			@ls_TOTALQTY,		@ls_PROCESSCOST,	@ls_lastemp)
	Else
		update	tqprogressbaddetail
		set	MEMO       			= @li_MEMO,
			REPAIRQTY  			= @li_REPAIRQTY,
			DISUSEQTY  			= @ls_DISUSEQTY,
			TOTALQTY   			= @ls_TOTALQTY,
			PROCESSCOST			= @ls_PROCESSCOST
		where	AREACODE			= @ls_AREACODE		
		and	DIVISIONCODE			= @ls_DIVISIONCODE	
		and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE	
		and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE	
		and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE	
		and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE	
		and	PROCESSCODE			= @ls_PROCESSCODE		
		and	BADREASONCODE		= @ls_BADREASONCODE	
		and	BADTYPECODE			= @li_BADTYPECODE
		
	update	[ipisjin_svr].ipis.dbo.tqprogressbaddetail_temp
	set	lastemp 				= 'N'
	where	AREACODE			= @ls_AREACODE		
	and	DIVISIONCODE			= @ls_DIVISIONCODE	
	and	ORIGINATIONDATE		= @ls_ORIGINATIONDATE	
	and	LARGEGROUPCODE		= @ls_LARGEGROUPCODE	
	and	MIDDLEGROUPCODE		= @ls_MIDDLEGROUPCODE	
	and	SMALLGROUPCODE		= @ls_SMALLGROUPCODE	
	and	PROCESSCODE			= @ls_PROCESSCODE		
	and	BADREASONCODE		= @ls_BADREASONCODE	
	and	BADTYPECODE			= @li_BADTYPECODE
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tqprogressbaddetail
 
End		-- Procedure End
Go
