/*
	File Name	: sp_pisi_eis_tmhcode.sql
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhcode
	Description	: EIS Upload tmhcode
			  tmhcode
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 12. 24
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhcode]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhcode]
GO

/*
Execute sp_pisi_eis_tmhcode
*/

Create Procedure sp_pisi_eis_tmhcode

As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@li_id			int,
	@ls_mhGubun		char(1),
	@ls_mhCode		varchar(2),
	@ls_mhName		varchar(20),
	@li_mhLevel		numeric,
	@li_printSq		int,
	@ls_printName		varchar(200),
	@ls_UseFlag		char(1),
	@ls_inputFlag		char(1),
	@ls_LastEmp		varchar(6),
	@ldt_LastDate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tmhcode
(	checkId			int IDENTITY(1,1),
	mhGubun	        	char(1),     
	mhCode	        		varchar(2),  
	mhName	        		varchar(20), 
	mhLevel	        		numeric,     
	printSq	        		int,         
	printName		varchar(200),
	UseFlag	        		char(1),     
	inputFlag		char(1),     
	LastEmp			varchar(6),
	LastDate			datetime		)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmhcode
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhcode

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_mhGubun		= mhGubun,
		@ls_mhCode		= mhCode,
		@ls_mhName		= mhName,
		@li_mhLevel		= mhLevel,
		@li_printSq		= printSq,
		@ls_printName		= printName,
		@ls_UseFlag		= UseFlag,
		@ls_inputFlag		= inputFlag,
		@ls_LastEmp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tmhcode
	Where	checkid 			> @li_id

	-- key chk
	If not exists (	select * from tmhcode
			where	mhGubun	= @ls_mhGubun
			and	mhCode		= @ls_mhCode	)

		insert into tmhcode
			(mhGubun,		mhCode,		mhName,		mhLevel,		printSq,
			printName,		UseFlag,			inputFlag,		LastEmp)
		values	(@ls_mhGubun,		@ls_mhCode,		@ls_mhName,		@li_mhLevel,	@li_printSq,
			@ls_printName,		@ls_UseFlag,		@ls_inputFlag,		@ls_LastEmp)
	Else
		update	tmhcode
		set	mhName			= @ls_mhName,
			mhLevel                 	= @li_mhLevel,
		        	printSq                 	= @li_printSq,
		        	printName               	= @ls_printName,
		        	UseFlag                 	= @ls_UseFlag,
		        	inputFlag               	= @ls_inputFlag
		where	mhGubun		= @ls_mhGubun
		and	mhCode			= @ls_mhCode

	update	[ipisele_svr\ipis].ipis.dbo.tmhcode
	set	lastemp 				= 'N'
	where	mhGubun			= @ls_mhGubun
	and	mhCode				= @ls_mhCode
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhcode


-- 대구기계

Insert	into	#tmp_tmhcode
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhcode

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_mhGubun		= mhGubun,
		@ls_mhCode		= mhCode,
		@ls_mhName		= mhName,
		@li_mhLevel		= mhLevel,
		@li_printSq		= printSq,
		@ls_printName		= printName,
		@ls_UseFlag		= UseFlag,
		@ls_inputFlag		= inputFlag,
		@ls_LastEmp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tmhcode
	Where	checkid 			> @li_id

	-- key chk
	If not exists (	select * from tmhcode
			where	mhGubun	= @ls_mhGubun
			and	mhCode		= @ls_mhCode	)

		insert into tmhcode
			(mhGubun,		mhCode,		mhName,		mhLevel,		printSq,
			printName,		UseFlag,			inputFlag,		LastEmp)
		values	(@ls_mhGubun,		@ls_mhCode,		@ls_mhName,		@li_mhLevel,	@li_printSq,
			@ls_printName,		@ls_UseFlag,		@ls_inputFlag,		@ls_LastEmp)
	Else
		update	tmhcode
		set	mhName			= @ls_mhName,
			mhLevel                 	= @li_mhLevel,
		        	printSq                 	= @li_printSq,
		        	printName               	= @ls_printName,
		        	UseFlag                 	= @ls_UseFlag,
		        	inputFlag               	= @ls_inputFlag
		where	mhGubun		= @ls_mhGubun
		and	mhCode			= @ls_mhCode

	update	[ipismac_svr\ipis].ipis.dbo.tmhcode
	set	lastemp 				= 'N'
	where	mhGubun			= @ls_mhGubun
	and	mhCode				= @ls_mhCode
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhcode


-- 대구압축

Insert	into	#tmp_tmhcode
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhcode

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_mhGubun		= mhGubun,
		@ls_mhCode		= mhCode,
		@ls_mhName		= mhName,
		@li_mhLevel		= mhLevel,
		@li_printSq		= printSq,
		@ls_printName		= printName,
		@ls_UseFlag		= UseFlag,
		@ls_inputFlag		= inputFlag,
		@ls_LastEmp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tmhcode
	Where	checkid 			> @li_id

	-- key chk
	If not exists (	select * from tmhcode
			where	mhGubun	= @ls_mhGubun
			and	mhCode		= @ls_mhCode	)

		insert into tmhcode
			(mhGubun,		mhCode,		mhName,		mhLevel,		printSq,
			printName,		UseFlag,			inputFlag,		LastEmp)
		values	(@ls_mhGubun,		@ls_mhCode,		@ls_mhName,		@li_mhLevel,	@li_printSq,
			@ls_printName,		@ls_UseFlag,		@ls_inputFlag,		@ls_LastEmp)
	Else
		update	tmhcode
		set	mhName			= @ls_mhName,
			mhLevel                 	= @li_mhLevel,
		        	printSq                 	= @li_printSq,
		        	printName               	= @ls_printName,
		        	UseFlag                 	= @ls_UseFlag,
		        	inputFlag               	= @ls_inputFlag
		where	mhGubun		= @ls_mhGubun
		and	mhCode			= @ls_mhCode

	update	[ipishvac_svr\ipis].ipis.dbo.tmhcode
	set	lastemp 				= 'N'
	where	mhGubun			= @ls_mhGubun
	and	mhCode				= @ls_mhCode
	and	LastEmp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhcode


-- 진천

Insert	into	#tmp_tmhcode
select	*
from	[ipisjin_svr].ipis.dbo.tmhcode

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_mhGubun		= mhGubun,
		@ls_mhCode		= mhCode,
		@ls_mhName		= mhName,
		@li_mhLevel		= mhLevel,
		@li_printSq		= printSq,
		@ls_printName		= printName,
		@ls_UseFlag		= UseFlag,
		@ls_inputFlag		= inputFlag,
		@ls_LastEmp		= LastEmp,
		@li_id			= checkid
	From	#tmp_tmhcode
	Where	checkid 			> @li_id

	-- key chk
	If not exists (	select * from tmhcode
			where	mhGubun	= @ls_mhGubun
			and	mhCode		= @ls_mhCode	)

		insert into tmhcode
			(mhGubun,		mhCode,		mhName,		mhLevel,		printSq,
			printName,		UseFlag,			inputFlag,		LastEmp)
		values	(@ls_mhGubun,		@ls_mhCode,		@ls_mhName,		@li_mhLevel,	@li_printSq,
			@ls_printName,		@ls_UseFlag,		@ls_inputFlag,		@ls_LastEmp)
	Else
		update	tmhcode
		set	mhName			= @ls_mhName,
			mhLevel                 	= @li_mhLevel,
		        	printSq                 	= @li_printSq,
		        	printName               	= @ls_printName,
		        	UseFlag                 	= @ls_UseFlag,
		        	inputFlag               	= @ls_inputFlag
		where	mhGubun		= @ls_mhGubun
		and	mhCode			= @ls_mhCode
		
	update	[ipisjin_svr].ipis.dbo.tmhcode
	set	lastemp 				= 'N'
	where	mhGubun			= @ls_mhGubun
	and	mhCode				= @ls_mhCode
	and	LastEmp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhcode
 
End		-- Procedure End
Go
