/*
	File Name	: sp_pisi_eis_tmstline.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmstline
	Description	: EIS Upload tmstline
			  tmstline
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmstline]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmstline]
GO

/*
Execute sp_pisi_eis_tmstline
*/

Create Procedure sp_pisi_eis_tmstline

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_lineshortname	varchar(10),
	@ls_linefullname	varchar(30),
	@ls_lineid		char(2),
	@ls_linegubun		char(1),
	@ls_kbuseflag		char(1),
	@ls_nextrouting		char(1),
	@ls_supplygubun		char(1),
	@ls_hostworkcenter	varchar(5),
	@ls_hostlinecode	char(1),
	@ls_capaqty		int,
	@ls_shiftcount		int,
	@ls_shifttime		int,
	@ls_cycletime		numeric(5,1),
	@ls_jphqty		int,
	@ls_displaycount	int,
	@ls_maxcyclegubun	char(1),
	@ls_cyclecount		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

-- 각 서버 tdelete에서 tablename이 tmstline인 놈 정리하고...

create table #tmp_tmstline
(	checkId			int IDENTITY(1,1),
	AreaCode		char (1),
	DivisionCode		char (1),
	WorkCenter		varchar(5),
	LineCode		char (1),
	LineShortName		varchar (10),
	LineFullName		varchar (30),
	LineID			char (2),
	LineGubun		char (1),
	KBUseFlag		char (1),
	NextRouting		char (1),
	SupplyGubun		char (1),
	HostWorkCenter		varchar (5),
	HostLineCode		char (1),
	CapaQty			int,
	ShiftCount		int,
	ShiftTime		int,
	CycleTime		numeric(5, 1),
	JPHQty			int,
	DisplayCount		int,
	MaxCycleGubun		char(1),
	CycleCount		int,
	Lastemp			varchar(6),
	LastDate	datetime	)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmstline
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstline
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_lineshortname	= lineshortname,
		@ls_linefullname	= linefullname,
		@ls_lineid		= lineid,
		@ls_linegubun		= linegubun,
		@ls_kbuseflag		= kbuseflag,
		@ls_nextrouting		= nextrouting,
		@ls_supplygubun		= supplygubun,
		@ls_hostworkcenter	= hostworkcenter,
		@ls_hostlinecode	= hostlinecode,
		@ls_capaqty		= capaqty,
		@ls_shiftcount		= shiftcount,
		@ls_shifttime		= shifttime,
		@ls_cycletime		= cycletime,
		@ls_jphqty		= jphqty,
		@ls_displaycount	= displaycount,
		@ls_maxcyclegubun	= maxcyclegubun,
		@ls_cyclecount		= cyclecount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstline
	Where	checkid > @ls_id

	If not exists (select * from tmstline 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	workcenter	= @ls_workcenter
			and	linecode	= @ls_linecode)

		insert into tmstline
			(AreaCode,		DivisionCode,		Workcenter,		LineCode, 
			LineShortName,		LineFullName,		LineID,			LineGubun,
			KBUseFlag,		NextRouting,		SupplyGubun,		HostWorkCenter,
			HostLineCode,		CapaQty,		ShiftCount,		ShiftTime,
			CycleTime,		JPHQty,			DisplayCount,		MaxCycleGubun,
			CycleCount,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_workcenter,		@ls_LineCode, 
			@ls_LineShortName,	@ls_LineFullName,	@ls_LineID,		@ls_LineGubun,
			@ls_KBUseFlag,		@ls_NextRouting,	@ls_SupplyGubun,	@ls_HostWorkCenter,
			@ls_HostLineCode,	@ls_CapaQty,		@ls_ShiftCount,		@ls_ShiftTime,
			@ls_CycleTime,		@ls_JPHQty,		@ls_DisplayCount,	@ls_MaxCycleGubun,
			@ls_CycleCount,		@ls_LastEmp)

	Else
		update	tmstline
		set	LineShortName	= @ls_lineshortname,
			LineFullName	= @ls_linefullname,
			LineID		= @ls_lineid,
			LineGubun	= @ls_linegubun,
			KBUseFlag	= @ls_kbuseflag,
			NextRouting	= @ls_nextrouting,
			SupplyGubun	= @ls_supplygubun,
			HostWorkCenter	= @ls_hostworkcenter,
			HostLineCode	= @ls_hostlinecode,
			CapaQty		= @ls_capaqty,
			ShiftCount	= @ls_shiftcount,
			ShiftTime	= @ls_shifttime,
			CycleTime	= @ls_cycletime,
			JPHQty		= @ls_jphqty,
			DisplayCount	= @ls_displaycount,
			MaxCycleGubun	= @ls_maxcyclegubun,
			CycleCount	= @ls_cyclecount
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	workcenter	= @ls_workcenter
		and	linecode	= @ls_linecode
		
	update	[ipisele_svr\ipis].ipis.dbo.tmstline
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	workcenter	= @ls_workcenter
	and	linecode	= @ls_linecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstline


-- 대구기계

Insert	into	#tmp_tmstline
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstline
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_lineshortname	= lineshortname,
		@ls_linefullname	= linefullname,
		@ls_lineid		= lineid,
		@ls_linegubun		= linegubun,
		@ls_kbuseflag		= kbuseflag,
		@ls_nextrouting		= nextrouting,
		@ls_supplygubun		= supplygubun,
		@ls_hostworkcenter	= hostworkcenter,
		@ls_hostlinecode	= hostlinecode,
		@ls_capaqty		= capaqty,
		@ls_shiftcount		= shiftcount,
		@ls_shifttime		= shifttime,
		@ls_cycletime		= cycletime,
		@ls_jphqty		= jphqty,
		@ls_displaycount	= displaycount,
		@ls_maxcyclegubun	= maxcyclegubun,
		@ls_cyclecount		= cyclecount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstline
	Where	checkid > @ls_id

	If not exists (select * from tmstline 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	workcenter	= @ls_workcenter
			and	linecode	= @ls_linecode)

		insert into tmstline
			(AreaCode,		DivisionCode,		Workcenter,		LineCode, 
			LineShortName,		LineFullName,		LineID,			LineGubun,
			KBUseFlag,		NextRouting,		SupplyGubun,		HostWorkCenter,
			HostLineCode,		CapaQty,		ShiftCount,		ShiftTime,
			CycleTime,		JPHQty,			DisplayCount,		MaxCycleGubun,
			CycleCount,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_workcenter,		@ls_LineCode, 
			@ls_LineShortName,	@ls_LineFullName,	@ls_LineID,		@ls_LineGubun,
			@ls_KBUseFlag,		@ls_NextRouting,	@ls_SupplyGubun,	@ls_HostWorkCenter,
			@ls_HostLineCode,	@ls_CapaQty,		@ls_ShiftCount,		@ls_ShiftTime,
			@ls_CycleTime,		@ls_JPHQty,		@ls_DisplayCount,	@ls_MaxCycleGubun,
			@ls_CycleCount,		@ls_LastEmp)

	Else
		update	tmstline
		set	LineShortName	= @ls_lineshortname,
			LineFullName	= @ls_linefullname,
			LineID		= @ls_lineid,
			LineGubun	= @ls_linegubun,
			KBUseFlag	= @ls_kbuseflag,
			NextRouting	= @ls_nextrouting,
			SupplyGubun	= @ls_supplygubun,
			HostWorkCenter	= @ls_hostworkcenter,
			HostLineCode	= @ls_hostlinecode,
			CapaQty		= @ls_capaqty,
			ShiftCount	= @ls_shiftcount,
			ShiftTime	= @ls_shifttime,
			CycleTime	= @ls_cycletime,
			JPHQty		= @ls_jphqty,
			DisplayCount	= @ls_displaycount,
			MaxCycleGubun	= @ls_maxcyclegubun,
			CycleCount	= @ls_cyclecount
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	workcenter	= @ls_workcenter
		and	linecode	= @ls_linecode
		
	update	[ipismac_svr\ipis].ipis.dbo.tmstline
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	workcenter	= @ls_workcenter
	and	linecode	= @ls_linecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstline


-- 대구압축

Insert	into	#tmp_tmstline
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstline
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_lineshortname	= lineshortname,
		@ls_linefullname	= linefullname,
		@ls_lineid		= lineid,
		@ls_linegubun		= linegubun,
		@ls_kbuseflag		= kbuseflag,
		@ls_nextrouting		= nextrouting,
		@ls_supplygubun		= supplygubun,
		@ls_hostworkcenter	= hostworkcenter,
		@ls_hostlinecode	= hostlinecode,
		@ls_capaqty		= capaqty,
		@ls_shiftcount		= shiftcount,
		@ls_shifttime		= shifttime,
		@ls_cycletime		= cycletime,
		@ls_jphqty		= jphqty,
		@ls_displaycount	= displaycount,
		@ls_maxcyclegubun	= maxcyclegubun,
		@ls_cyclecount		= cyclecount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstline
	Where	checkid > @ls_id

	If not exists (select * from tmstline 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	workcenter	= @ls_workcenter
			and	linecode	= @ls_linecode)

		insert into tmstline
			(AreaCode,		DivisionCode,		Workcenter,		LineCode, 
			LineShortName,		LineFullName,		LineID,			LineGubun,
			KBUseFlag,		NextRouting,		SupplyGubun,		HostWorkCenter,
			HostLineCode,		CapaQty,		ShiftCount,		ShiftTime,
			CycleTime,		JPHQty,			DisplayCount,		MaxCycleGubun,
			CycleCount,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_workcenter,		@ls_LineCode, 
			@ls_LineShortName,	@ls_LineFullName,	@ls_LineID,		@ls_LineGubun,
			@ls_KBUseFlag,		@ls_NextRouting,	@ls_SupplyGubun,	@ls_HostWorkCenter,
			@ls_HostLineCode,	@ls_CapaQty,		@ls_ShiftCount,		@ls_ShiftTime,
			@ls_CycleTime,		@ls_JPHQty,		@ls_DisplayCount,	@ls_MaxCycleGubun,
			@ls_CycleCount,		@ls_LastEmp)

	Else
		update	tmstline
		set	LineShortName	= @ls_lineshortname,
			LineFullName	= @ls_linefullname,
			LineID		= @ls_lineid,
			LineGubun	= @ls_linegubun,
			KBUseFlag	= @ls_kbuseflag,
			NextRouting	= @ls_nextrouting,
			SupplyGubun	= @ls_supplygubun,
			HostWorkCenter	= @ls_hostworkcenter,
			HostLineCode	= @ls_hostlinecode,
			CapaQty		= @ls_capaqty,
			ShiftCount	= @ls_shiftcount,
			ShiftTime	= @ls_shifttime,
			CycleTime	= @ls_cycletime,
			JPHQty		= @ls_jphqty,
			DisplayCount	= @ls_displaycount,
			MaxCycleGubun	= @ls_maxcyclegubun,
			CycleCount	= @ls_cyclecount
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	workcenter	= @ls_workcenter
		and	linecode	= @ls_linecode
		
	update	[ipishvac_svr\ipis].ipis.dbo.tmstline
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	workcenter	= @ls_workcenter
	and	linecode	= @ls_linecode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstline


-- 진천

Insert	into	#tmp_tmstline
select	*
from	[ipisjin_svr].ipis.dbo.tmstline
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_workcenter		= workcenter,
		@ls_linecode		= linecode,
		@ls_lineshortname	= lineshortname,
		@ls_linefullname	= linefullname,
		@ls_lineid		= lineid,
		@ls_linegubun		= linegubun,
		@ls_kbuseflag		= kbuseflag,
		@ls_nextrouting		= nextrouting,
		@ls_supplygubun		= supplygubun,
		@ls_hostworkcenter	= hostworkcenter,
		@ls_hostlinecode	= hostlinecode,
		@ls_capaqty		= capaqty,
		@ls_shiftcount		= shiftcount,
		@ls_shifttime		= shifttime,
		@ls_cycletime		= cycletime,
		@ls_jphqty		= jphqty,
		@ls_displaycount	= displaycount,
		@ls_maxcyclegubun	= maxcyclegubun,
		@ls_cyclecount		= cyclecount,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstline
	Where	checkid > @ls_id

	If not exists (select * from tmstline 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	workcenter	= @ls_workcenter
			and	linecode	= @ls_linecode)

		insert into tmstline
			(AreaCode,		DivisionCode,		Workcenter,		LineCode, 
			LineShortName,		LineFullName,		LineID,			LineGubun,
			KBUseFlag,		NextRouting,		SupplyGubun,		HostWorkCenter,
			HostLineCode,		CapaQty,		ShiftCount,		ShiftTime,
			CycleTime,		JPHQty,			DisplayCount,		MaxCycleGubun,
			CycleCount,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_workcenter,		@ls_LineCode, 
			@ls_LineShortName,	@ls_LineFullName,	@ls_LineID,		@ls_LineGubun,
			@ls_KBUseFlag,		@ls_NextRouting,	@ls_SupplyGubun,	@ls_HostWorkCenter,
			@ls_HostLineCode,	@ls_CapaQty,		@ls_ShiftCount,		@ls_ShiftTime,
			@ls_CycleTime,		@ls_JPHQty,		@ls_DisplayCount,	@ls_MaxCycleGubun,
			@ls_CycleCount,		@ls_LastEmp)

	Else
		update	tmstline
		set	LineShortName	= @ls_lineshortname,
			LineFullName	= @ls_linefullname,
			LineID		= @ls_lineid,
			LineGubun	= @ls_linegubun,
			KBUseFlag	= @ls_kbuseflag,
			NextRouting	= @ls_nextrouting,
			SupplyGubun	= @ls_supplygubun,
			HostWorkCenter	= @ls_hostworkcenter,
			HostLineCode	= @ls_hostlinecode,
			CapaQty		= @ls_capaqty,
			ShiftCount	= @ls_shiftcount,
			ShiftTime	= @ls_shifttime,
			CycleTime	= @ls_cycletime,
			JPHQty		= @ls_jphqty,
			DisplayCount	= @ls_displaycount,
			MaxCycleGubun	= @ls_maxcyclegubun,
			CycleCount	= @ls_cyclecount
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	workcenter	= @ls_workcenter
		and	linecode	= @ls_linecode
		
	update	[ipisjin_svr].ipis.dbo.tmstline
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	workcenter	= @ls_workcenter
	and	linecode	= @ls_linecode
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmstline
 
End		-- Procedure End
Go
