/*
	File Name	: sp_pisi_eis_tdelete_ipismac.sql
	SYSTEM		: KDAC 烹钦 积魂 沥焊 矫胶袍
	Procedure Name	: sp_pisi_eis_tdelete_ipismac
	Description	: EIS Upload tdelete
			  tdelete
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2003. 01. 15
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tdelete_ipismac]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tdelete_ipismac]
GO

/*
Execute sp_pisi_eis_tdelete_ipismac
*/

Create Procedure sp_pisi_eis_tdelete_ipismac

As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@li_id			int,
	@ls_TableName		varchar(50),
	@ls_DeleteData		varchar(200),
	@ldt_DeleteTime		datetime

create table #tmp_tdelete
(	checkId			int IDENTITY(1,1),
	TableName		varchar(50),     
	DeleteData		varchar(200),  
	DeleteTime		datetime,
	LastEmp			varchar(6),
	LastDate			datetime	)


--###################################################################

--	措备扁拌

--from	[ipismac_svr\ipis].ipis.dbo.tdelete

--###################################################################

-- TMSTKB 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstkb'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstkb
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(WorkCenter)	+ '/' +
		RTRIM(LineCode)		+ '/' +
		RTRIM(ItemCode)		= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(WorkCenter)	+
		RTRIM(LineCode)		+
		RTRIM(ItemCode)		= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMSTKBHIS 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstkbhis'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstkbhis
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(WorkCenter)	+ '/' +
		RTRIM(LineCode)		+ '/' +
		RTRIM(ItemCode)		+ '/' +
		RTRIM(ApplyFrom)	+ '/' +
		RTRIM(ApplyTo)		= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(WorkCenter)	+
		RTRIM(LineCode)		+
		RTRIM(ItemCode)		+
		RTRIM(ApplyFrom)	+
		RTRIM(ApplyTo)		= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMSTWORKCENTER 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstworkcenter'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstworkcenter
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(WorkCenter)	= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(WorkCenter)	= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMSTLINE 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstline'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstline
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(WorkCenter)	+ '/' +
		RTRIM(LineCode)		= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(WorkCenter)	+
		RTRIM(LineCode)		= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMSTPARTKBHIS 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstpartkbhis'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstpartkbhis
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(SupplierCode)	+ '/' +
		RTRIM(ItemCode)		+ '/' +
		RTRIM(ApplyFrom)	= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(SupplierCode)	+
		RTRIM(ItemCode)		+
		RTRIM(ApplyFrom)	= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMSTPARTCYCLE 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstpartcycle'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstpartcycle
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(SupplierCode)	+ '/' +
		RTRIM(ApplyFrom)	= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(SupplierCode)	+
		RTRIM(ApplyFrom)	= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMSTORDERRATE 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstorderrate'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstorderrate
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(ItemCode)		+ '/' +
		RTRIM(SupplierCode)	= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(ItemCode)		+
		RTRIM(SupplierCode)	= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMSTPARTKB 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstpartkb'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstpartkb
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(SupplierCode)	+ '/' +
		RTRIM(ItemCode)		= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(SupplierCode)	+
		RTRIM(ItemCode)		= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMSTPARTEDIT 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmstpartedit'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmstpartedit
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(SupplierCode)	+ '/' +
		RTRIM(ApplyFrom)	+ '/' +
		RTRIM(PartEditNo)	= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(SupplierCode)	+
		RTRIM(ApplyFrom)	+
		RTRIM(PartEditNo)	= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMHDAILY 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmhdaily'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmhdaily
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(WorkCenter)	+ '/' +
		RTRIM(WorkDay)		+ '/' +
		RTRIM(EmpGubun)	= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(WorkCenter)	+
		RTRIM(WorkDay)		+
		RTRIM(EmpGubun)	= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMHDAILYSUB 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmhdailysub'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmhdailysub
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(WorkCenter)	+ '/' +
		RTRIM(WorkDay)		+ '/' +
		RTRIM(mhGubun)		+ '/' +
		RTRIM(mhCode)		+ '/' +
		RTRIM(seqNo)		= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(WorkCenter)	+
		RTRIM(WorkDay)		+
		RTRIM(mhGubun)		+
		RTRIM(mhCode)		+
		RTRIM(seqNo)		= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMHDAILYSTATUS 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmhdailystatus'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmhdailystatus
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(WorkCenter)	+ '/' +
		RTRIM(WorkDay)		= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(WorkCenter)	+
		RTRIM(WorkDay)		= @ls_DeleteData	

End	-- while loop end

truncate table #tmp_tdelete

-- TMHDAILYDETAIL 贸府
Insert	into	#tmp_tdelete
select	*
  from	[ipismac_svr\ipis].ipis.dbo.tdelete
where	tablename	= 'tmhdailydetail'
and	LastEmp		<> 'N'

Select	@i = 0, @li_loop_count = @@RowCount, @li_id = 0

While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i			= @i + 1,
		@ls_TableName		= TableName,
		@ls_DeleteData		= DeleteData,
		@ldt_DeleteTime		= DeleteTime,
		@li_id			= checkid
	From	#tmp_tdelete
	Where	checkid 			> @li_id

	update	[ipismac_svr\ipis].ipis.dbo.tdelete
	  set	LastEmp			= 'N'
	where	TableName		= @ls_TableName
	  and	DeleteData		= @ls_DeleteData
	  and	DeleteTime		= @ldt_DeleteTime

	delete
	  from	tmhdailydetail
	where	RTRIM(AreaCode)		+ '/' +
		RTRIM(DivisionCode)	+ '/' +
		RTRIM(WorkCenter)	+ '/' +
		RTRIM(WorkDay)		+ '/' +
		RTRIM(EmpGubun)		+ '/' +
		RTRIM(mhGubun)		+ '/' +
		RTRIM(mhCode)		= @ls_DeleteData
	or	RTRIM(AreaCode)		+
		RTRIM(DivisionCode)	+
		RTRIM(WorkCenter)	+
		RTRIM(WorkDay)		+
		RTRIM(EmpGubun)		+
		RTRIM(mhGubun)		+
		RTRIM(mhCode)		= @ls_DeleteData

End	-- while loop end

truncate table #tmp_tdelete


drop table #tmp_tdelete
 
End		-- Procedure End
Go
