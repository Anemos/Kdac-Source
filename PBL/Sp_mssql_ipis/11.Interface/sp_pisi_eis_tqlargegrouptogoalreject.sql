/*
	File Name	: sp_pisi_eis_tqlargegrouptogoalreject.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tqlargegrouptogoalreject
	Description	: EIS Upload tqlargegrouptogoalreject
			  tqlargegrouptogoalreject
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tqlargegrouptogoalreject]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tqlargegrouptogoalreject]
GO

/*
Execute sp_pisi_eis_tqlargegrouptogoalreject
*/

Create Procedure sp_pisi_eis_tqlargegrouptogoalreject

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_AREACODE			char(1),
	@ls_DIVISIONCODE		char(1),
	@ls_STANDARDYEAR		char(4),
	@ls_FSFLAG			char(1),
	@ls_LARGEGROUPCODE		char(2),
	@lf_MONTH1			float,
	@lf_MONTH2			float,
	@lf_MONTH3			float,
	@lf_MONTH4			float,
	@lf_MONTH5			float,
	@lf_MONTH6			float,
	@lf_MONTH7			float,
	@lf_MONTH8			float,
	@lf_MONTH9			float,
	@lf_MONTH10			float,
	@lf_MONTH11			float,
	@lf_MONTH12			float,
	@lf_YEARGOAL			float,
	@ls_LastEmp			varchar(6),
	@ldt_LastDate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tqlargegrouptogoalreject
(	checkId				int IDENTITY(1,1),
	AREACODE			char(1),   
	DIVISIONCODE			char(1),   
	STANDARDYEAR			char(4),   
	FSFLAG				char(1),   
	LARGEGROUPCODE		char(2),   
	MONTH1				float,     
	MONTH2				float,     
	MONTH3				float,     
	MONTH4				float,     
	MONTH5				float,     
	MONTH6				float,     
	MONTH7				float,     
	MONTH8				float,     
	MONTH9				float,     
	MONTH10			float,     
	MONTH11			float,     
	MONTH12			float,     
	YEARGOAL			float,     
	LastEmp				varchar(6),
	LastDate				datetime,  )

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tqlargegrouptogoalreject
select	*
from	[ipisele_svr\ipis].ipis.dbo.tqlargegrouptogoalreject

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AREACODE			= AREACODE,
		@ls_DIVISIONCODE		= DIVISIONCODE,
		@ls_STANDARDYEAR		= STANDARDYEAR,
		@ls_FSFLAG			= FSFLAG,
		@ls_LARGEGROUPCODE		= LARGEGROUPCODE,
		@lf_MONTH1			= MONTH1,
		@lf_MONTH2			= MONTH2,
		@lf_MONTH3			= MONTH3,
		@lf_MONTH4			= MONTH4,
		@lf_MONTH5			= MONTH5,
		@lf_MONTH6			= MONTH6,
		@lf_MONTH7			= MONTH7,
		@lf_MONTH8			= MONTH8,
		@lf_MONTH9			= MONTH9,
		@lf_MONTH10			= MONTH10,
		@lf_MONTH11			= MONTH11,
		@lf_MONTH12			= MONTH12,
		@lf_YEARGOAL			= YEARGOAL,
		@ls_LastEmp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tqlargegrouptogoalreject
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tqlargegrouptogoalreject
			where	AREACODE		= @ls_AREACODE
			and	DIVISIONCODE		= @ls_DIVISIONCODE
			and	STANDARDYEAR		= @ls_STANDARDYEAR
			and	FSFLAG			= @ls_FSFLAG
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE      )

		insert into tqlargegrouptogoalreject
			(AREACODE,		DIVISIONCODE,		STANDARDYEAR,		FSFLAG,
			LARGEGROUPCODE,	MONTH1,		MONTH2,		MONTH3,
			MONTH4,		MONTH5,		MONTH6,		MONTH7,
			MONTH8,		MONTH9,		MONTH10,		MONTH11,
			MONTH12,		YEARGOAL,		LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_STANDARDYEAR,	@ls_FSFLAG,
			@ls_LARGEGROUPCODE,	@lf_MONTH1,		@lf_MONTH2,		@lf_MONTH3,
			@lf_MONTH4,		@lf_MONTH5,		@lf_MONTH6,		@lf_MONTH7,
			@lf_MONTH8,		@lf_MONTH9,		@lf_MONTH10,		@lf_MONTH11,
			@lf_MONTH12,		@lf_YEARGOAL,		@ls_LastEmp)
	Else
		update	tqlargegrouptogoalreject
		set	MONTH1			= @lf_MONTH1,
			MONTH2			= @lf_MONTH2,
			MONTH3			= @lf_MONTH3,
			MONTH4			= @lf_MONTH4,
			MONTH5			= @lf_MONTH5,
			MONTH6			= @lf_MONTH6,
			MONTH7			= @lf_MONTH7,
			MONTH8			= @lf_MONTH8,
			MONTH9			= @lf_MONTH9,
			MONTH10		= @lf_MONTH10,
			MONTH11		= @lf_MONTH11,
			MONTH12		= @lf_MONTH12,
			YEARGOAL		= @lf_YEARGOAL
		where	AREACODE		= @ls_AREACODE
		and	DIVISIONCODE		= @ls_DIVISIONCODE
		and	STANDARDYEAR		= @ls_STANDARDYEAR
		and	FSFLAG			= @ls_FSFLAG
		and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE

	update	[ipisele_svr\ipis].ipis.dbo.tqlargegrouptogoalreject
	set	lastemp 			= 'N'
	where	AREACODE		= @ls_AREACODE
	and	DIVISIONCODE		= @ls_DIVISIONCODE
	and	STANDARDYEAR		= @ls_STANDARDYEAR
	and	FSFLAG			= @ls_FSFLAG
	and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE
	and	LastEmp 		= 'Y'

End	-- while loop end

truncate table #tmp_tqlargegrouptogoalreject


-- 대구기계

Insert	into	#tmp_tqlargegrouptogoalreject
select	*
from	[ipismac_svr\ipis].ipis.dbo.tqlargegrouptogoalreject
	
Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AREACODE			= AREACODE,
		@ls_DIVISIONCODE		= DIVISIONCODE,
		@ls_STANDARDYEAR		= STANDARDYEAR,
		@ls_FSFLAG			= FSFLAG,
		@ls_LARGEGROUPCODE		= LARGEGROUPCODE,
		@lf_MONTH1			= MONTH1,
		@lf_MONTH2			= MONTH2,
		@lf_MONTH3			= MONTH3,
		@lf_MONTH4			= MONTH4,
		@lf_MONTH5			= MONTH5,
		@lf_MONTH6			= MONTH6,
		@lf_MONTH7			= MONTH7,
		@lf_MONTH8			= MONTH8,
		@lf_MONTH9			= MONTH9,
		@lf_MONTH10			= MONTH10,
		@lf_MONTH11			= MONTH11,
		@lf_MONTH12			= MONTH12,
		@lf_YEARGOAL			= YEARGOAL,
		@ls_LastEmp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tqlargegrouptogoalreject
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tqlargegrouptogoalreject
			where	AREACODE	= @ls_AREACODE
			and	DIVISIONCODE	= @ls_DIVISIONCODE
			and	STANDARDYEAR	= @ls_STANDARDYEAR
			and	FSFLAG		= @ls_FSFLAG
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE      )

		insert into tqlargegrouptogoalreject
			(AREACODE,		DIVISIONCODE,		STANDARDYEAR,		FSFLAG,
			LARGEGROUPCODE,	MONTH1,		MONTH2,		MONTH3,
			MONTH4,		MONTH5,		MONTH6,		MONTH7,
			MONTH8,		MONTH9,		MONTH10,		MONTH11,
			MONTH12,		YEARGOAL,		LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_STANDARDYEAR,	@ls_FSFLAG,
			@ls_LARGEGROUPCODE,	@lf_MONTH1,		@lf_MONTH2,		@lf_MONTH3,
			@lf_MONTH4,		@lf_MONTH5,		@lf_MONTH6,		@lf_MONTH7,
			@lf_MONTH8,		@lf_MONTH9,		@lf_MONTH10,		@lf_MONTH11,
			@lf_MONTH12,		@lf_YEARGOAL,		@ls_LastEmp)
	Else
		update	tqlargegrouptogoalreject
		set	MONTH1			= @lf_MONTH1,
			MONTH2			= @lf_MONTH2,
			MONTH3			= @lf_MONTH3,
			MONTH4			= @lf_MONTH4,
			MONTH5			= @lf_MONTH5,
			MONTH6			= @lf_MONTH6,
			MONTH7			= @lf_MONTH7,
			MONTH8			= @lf_MONTH8,
			MONTH9			= @lf_MONTH9,
			MONTH10		= @lf_MONTH10,
			MONTH11		= @lf_MONTH11,
			MONTH12		= @lf_MONTH12,
			YEARGOAL		= @lf_YEARGOAL
		where	AREACODE		= @ls_AREACODE
		and	DIVISIONCODE		= @ls_DIVISIONCODE
		and	STANDARDYEAR		= @ls_STANDARDYEAR
		and	FSFLAG			= @ls_FSFLAG
		and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE

	update	[ipismac_svr\ipis].ipis.dbo.tqlargegrouptogoalreject
	set	lastemp 			= 'N'
	where	AREACODE		= @ls_AREACODE
	and	DIVISIONCODE		= @ls_DIVISIONCODE
	and	STANDARDYEAR		= @ls_STANDARDYEAR
	and	FSFLAG			= @ls_FSFLAG
	and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE
	and	LastEmp 		= 'Y'

End	-- while loop end

truncate table #tmp_tqlargegrouptogoalreject


-- 대구압축

Insert	into	#tmp_tqlargegrouptogoalreject
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tqlargegrouptogoalreject

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AREACODE			= AREACODE,
		@ls_DIVISIONCODE		= DIVISIONCODE,
		@ls_STANDARDYEAR		= STANDARDYEAR,
		@ls_FSFLAG			= FSFLAG,
		@ls_LARGEGROUPCODE		= LARGEGROUPCODE,
		@lf_MONTH1			= MONTH1,
		@lf_MONTH2			= MONTH2,
		@lf_MONTH3			= MONTH3,
		@lf_MONTH4			= MONTH4,
		@lf_MONTH5			= MONTH5,
		@lf_MONTH6			= MONTH6,
		@lf_MONTH7			= MONTH7,
		@lf_MONTH8			= MONTH8,
		@lf_MONTH9			= MONTH9,
		@lf_MONTH10			= MONTH10,
		@lf_MONTH11			= MONTH11,
		@lf_MONTH12			= MONTH12,
		@lf_YEARGOAL			= YEARGOAL,
		@ls_LastEmp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tqlargegrouptogoalreject
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tqlargegrouptogoalreject
			where	AREACODE		= @ls_AREACODE
			and	DIVISIONCODE		= @ls_DIVISIONCODE
			and	STANDARDYEAR		= @ls_STANDARDYEAR
			and	FSFLAG			= @ls_FSFLAG
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE      )

		insert into tqlargegrouptogoalreject
			(AREACODE,		DIVISIONCODE,		STANDARDYEAR,		FSFLAG,
			LARGEGROUPCODE,	MONTH1,		MONTH2,		MONTH3,
			MONTH4,		MONTH5,		MONTH6,		MONTH7,
			MONTH8,		MONTH9,		MONTH10,		MONTH11,
			MONTH12,		YEARGOAL,		LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_STANDARDYEAR,	@ls_FSFLAG,
			@ls_LARGEGROUPCODE,	@lf_MONTH1,		@lf_MONTH2,		@lf_MONTH3,
			@lf_MONTH4,		@lf_MONTH5,		@lf_MONTH6,		@lf_MONTH7,
			@lf_MONTH8,		@lf_MONTH9,		@lf_MONTH10,		@lf_MONTH11,
			@lf_MONTH12,		@lf_YEARGOAL,		@ls_LastEmp)
	Else
		update	tqlargegrouptogoalreject
		set	MONTH1			= @lf_MONTH1,
			MONTH2			= @lf_MONTH2,
			MONTH3			= @lf_MONTH3,
			MONTH4			= @lf_MONTH4,
			MONTH5			= @lf_MONTH5,
			MONTH6			= @lf_MONTH6,
			MONTH7			= @lf_MONTH7,
			MONTH8			= @lf_MONTH8,
			MONTH9			= @lf_MONTH9,
			MONTH10		= @lf_MONTH10,
			MONTH11		= @lf_MONTH11,
			MONTH12		= @lf_MONTH12,
			YEARGOAL		= @lf_YEARGOAL
		where	AREACODE		= @ls_AREACODE
		and	DIVISIONCODE		= @ls_DIVISIONCODE
		and	STANDARDYEAR		= @ls_STANDARDYEAR
		and	FSFLAG			= @ls_FSFLAG
		and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE

	update	[ipishvac_svr\ipis].ipis.dbo.tqlargegrouptogoalreject
	set	lastemp 			= 'N'
	where	AREACODE		= @ls_AREACODE
	and	DIVISIONCODE		= @ls_DIVISIONCODE
	and	STANDARDYEAR		= @ls_STANDARDYEAR
	and	FSFLAG			= @ls_FSFLAG
	and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE
	and	LastEmp 		= 'Y'

End	-- while loop end

truncate table #tmp_tqlargegrouptogoalreject


-- 진천

Insert	into	#tmp_tqlargegrouptogoalreject
select	*
from	[ipisjin_svr].ipis.dbo.tqlargegrouptogoalreject

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_AREACODE			= AREACODE,
		@ls_DIVISIONCODE		= DIVISIONCODE,
		@ls_STANDARDYEAR		= STANDARDYEAR,
		@ls_FSFLAG			= FSFLAG,
		@ls_LARGEGROUPCODE		= LARGEGROUPCODE,
		@lf_MONTH1			= MONTH1,
		@lf_MONTH2			= MONTH2,
		@lf_MONTH3			= MONTH3,
		@lf_MONTH4			= MONTH4,
		@lf_MONTH5			= MONTH5,
		@lf_MONTH6			= MONTH6,
		@lf_MONTH7			= MONTH7,
		@lf_MONTH8			= MONTH8,
		@lf_MONTH9			= MONTH9,
		@lf_MONTH10			= MONTH10,
		@lf_MONTH11			= MONTH11,
		@lf_MONTH12			= MONTH12,
		@lf_YEARGOAL			= YEARGOAL,
		@ls_LastEmp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tqlargegrouptogoalreject
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tqlargegrouptogoalreject
			where	AREACODE		= @ls_AREACODE
			and	DIVISIONCODE		= @ls_DIVISIONCODE
			and	STANDARDYEAR		= @ls_STANDARDYEAR
			and	FSFLAG			= @ls_FSFLAG
			and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE      )

		insert into tqlargegrouptogoalreject
			(AREACODE,		DIVISIONCODE,		STANDARDYEAR,		FSFLAG,
			LARGEGROUPCODE,	MONTH1,		MONTH2,		MONTH3,
			MONTH4,		MONTH5,		MONTH6,		MONTH7,
			MONTH8,		MONTH9,		MONTH10,		MONTH11,
			MONTH12,		YEARGOAL,		LastEmp)
		values	(@ls_AREACODE,		@ls_DIVISIONCODE,	@ls_STANDARDYEAR,	@ls_FSFLAG,
			@ls_LARGEGROUPCODE,	@lf_MONTH1,		@lf_MONTH2,		@lf_MONTH3,
			@lf_MONTH4,		@lf_MONTH5,		@lf_MONTH6,		@lf_MONTH7,
			@lf_MONTH8,		@lf_MONTH9,		@lf_MONTH10,		@lf_MONTH11,
			@lf_MONTH12,		@lf_YEARGOAL,		@ls_LastEmp)
	Else
		update	tqlargegrouptogoalreject
		set	MONTH1			= @lf_MONTH1,
			MONTH2			= @lf_MONTH2,
			MONTH3			= @lf_MONTH3,
			MONTH4			= @lf_MONTH4,
			MONTH5			= @lf_MONTH5,
			MONTH6			= @lf_MONTH6,
			MONTH7			= @lf_MONTH7,
			MONTH8			= @lf_MONTH8,
			MONTH9			= @lf_MONTH9,
			MONTH10		= @lf_MONTH10,
			MONTH11		= @lf_MONTH11,
			MONTH12		= @lf_MONTH12,
			YEARGOAL		= @lf_YEARGOAL
		where	AREACODE		= @ls_AREACODE
		and	DIVISIONCODE		= @ls_DIVISIONCODE
		and	STANDARDYEAR		= @ls_STANDARDYEAR
		and	FSFLAG			= @ls_FSFLAG
		and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE
		
	update	[ipisjin_svr].ipis.dbo.tqlargegrouptogoalreject
	set	lastemp 			= 'N'
	where	AREACODE		= @ls_AREACODE
	and	DIVISIONCODE		= @ls_DIVISIONCODE
	and	STANDARDYEAR		= @ls_STANDARDYEAR
	and	FSFLAG			= @ls_FSFLAG
	and	LARGEGROUPCODE	= @ls_LARGEGROUPCODE
	and	LastEmp 		= 'Y'

End	-- while loop end

drop table #tmp_tqlargegrouptogoalreject
 
End		-- Procedure End
Go
