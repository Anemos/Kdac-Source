/*
	File Name	: sp_pisi_eis_tmhtarget.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhtarget
	Description	: EIS Upload tmhmonthtarget
			  tmhmonthtarget
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2003. 01. 16
	Author		: Gary Kim
*/

use EIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhtarget]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhtarget]
GO

/*
Execute sp_pisi_eis_tmhtarget
*/

Create Procedure sp_pisi_eis_tmhtarget
	
As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@ls_id				int,
	@ls_AreaCode			char (1),
	@ls_DivisionCode			char (1),
	@ls_WorkCenter			varchar (5),
	@ls_ItemCode			varchar(12),
	@ls_subLineCode		varchar(7),
	@ls_subLineNo			char(1),
	@ls_tarMonth			char(7),
	@ls_tarMH			numeric(6,4),
	@ls_modifyFlag			char(1),
	@ls_lastemp			varchar(6),
	@ls_lastdate			datetime,
	@ls_today			char(10)

create table #tmp_tmhmonthtarget
(	checkId				int IDENTITY(1,1),
	AreaCode			char (1),
	DivisionCode			char (1),
	WorkCenter			varchar (5),
	ItemCode			varchar(12),
	subLineCode			varchar(7),
	subLineNo			char(1),
	tarMonth				char(7),
	tarMH				numeric(6,4),
	modifyFlag			char(1),
	LastEmp				varchar(6),
	LastDate				datetime		)

-- 각 서버 tdelete에서 tablename이 tmhmonthtarget인 놈 정리하고...

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tmhmonthtarget
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmhmonthtarget
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= areacode,
		@ls_DivisionCode		= divisioncode,
		@ls_WorkCenter		= workcenter,
		@ls_ItemCode		= itemcode,
		@ls_subLineCode	= subLineCode,
		@ls_subLineNo		= subLineNo,
		@ls_tarMonth		= tarMonth,
		@ls_tarMH		= tarMH,
		@ls_modifyFlag		= modifyflag,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhmonthtarget
	Where	checkid > @ls_id

	If not exists (select * from tmhmonthtarget 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	ItemCode	= @ls_itemcode
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo
			and	tarMonth	= @ls_tarMonth	)

		insert into tmhmonthtarget
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		tarMonth,		tarMH,
			modifyFlag,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_tarMonth,		@ls_tarMH,
			@ls_modifyFlag,		@ls_LastEmp)

	Else
		begin
		
		delete	from tmhmonthtarget		
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	ItemCode	= @ls_itemcode
		and	subLineCode	= @ls_subLineCode
		and	subLineNo	= @ls_subLineNo
		and	tarMonth	= @ls_tarMonth
		
		insert into tmhmonthtarget
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		tarMonth,		tarMH,
			modifyFlag,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_tarMonth,		@ls_tarMH,
			@ls_modifyFlag,		@ls_LastEmp)
		
		end
		                        
	update	[ipisele_svr\ipis].ipis.dbo.tmhmonthtarget
	set	lastemp 	= 'N'
	where	AreaCode		= @ls_areacode	
	and	DivisionCode		= @ls_divisioncode
	and	WorkCenter		= @ls_workcenter
	and	ItemCode		= @ls_itemcode
	and	subLineCode		= @ls_subLineCode
	and	subLineNo		= @ls_subLineNo
	and	tarMonth			= @ls_tarMonth
	and	lastemp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthtarget


-- 대구기계

Insert	into	#tmp_tmhmonthtarget
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmhmonthtarget
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= areacode,
		@ls_DivisionCode		= divisioncode,
		@ls_WorkCenter		= workcenter,
		@ls_ItemCode		= itemcode,
		@ls_subLineCode	= subLineCode,
		@ls_subLineNo		= subLineNo,
		@ls_tarMonth		= tarMonth,
		@ls_tarMH		= tarMH,
		@ls_modifyFlag		= modifyflag,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhmonthtarget
	Where	checkid > @ls_id

	If not exists (select * from tmhmonthtarget 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	ItemCode	= @ls_itemcode
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo
			and	tarMonth	= @ls_tarMonth		)

		insert into tmhmonthtarget
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		tarMonth,		tarMH,
			modifyFlag,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_tarMonth,		@ls_tarMH,
			@ls_modifyFlag,		@ls_LastEmp)

	Else
		begin
		
		delete	from tmhmonthtarget		
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	ItemCode	= @ls_itemcode
		and	subLineCode	= @ls_subLineCode
		and	subLineNo	= @ls_subLineNo
		and	tarMonth	= @ls_tarMonth
		
		insert into tmhmonthtarget
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		tarMonth,		tarMH,
			modifyFlag,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_tarMonth,		@ls_tarMH,
			@ls_modifyFlag,		@ls_LastEmp)
		
		end

		                        
	update	[ipismac_svr\ipis].ipis.dbo.tmhmonthtarget
	set	lastemp 	= 'N'
	where	AreaCode		= @ls_areacode	
	and	DivisionCode		= @ls_divisioncode
	and	WorkCenter		= @ls_workcenter
	and	ItemCode		= @ls_itemcode
	and	subLineCode		= @ls_subLineCode
	and	subLineNo		= @ls_subLineNo
	and	tarMonth			= @ls_tarMonth
	and	lastemp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthtarget


-- 대구압축

Insert	into	#tmp_tmhmonthtarget
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmhmonthtarget
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= areacode,
		@ls_DivisionCode		= divisioncode,
		@ls_WorkCenter		= workcenter,
		@ls_ItemCode		= itemcode,
		@ls_subLineCode	= subLineCode,
		@ls_subLineNo		= subLineNo,
		@ls_tarMonth		= tarMonth,
		@ls_tarMH		= tarMH,
		@ls_modifyFlag		= modifyflag,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhmonthtarget
	Where	checkid > @ls_id

	If not exists (select * from tmhmonthtarget 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	ItemCode	= @ls_itemcode
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo
			and	tarMonth	= @ls_tarMonth		)

		insert into tmhmonthtarget
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		tarMonth,		tarMH,
			modifyFlag,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_tarMonth,		@ls_tarMH,
			@ls_modifyFlag,		@ls_LastEmp)

	Else
		begin
		
		delete	from tmhmonthtarget		
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	ItemCode	= @ls_itemcode
		and	subLineCode	= @ls_subLineCode
		and	subLineNo	= @ls_subLineNo
		and	tarMonth	= @ls_tarMonth
		
		insert into tmhmonthtarget
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		tarMonth,		tarMH,
			modifyFlag,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_tarMonth,		@ls_tarMH,
			@ls_modifyFlag,		@ls_LastEmp)
		
		end

	update	[ipishvac_svr\ipis].ipis.dbo.tmhmonthtarget
	set	lastemp 	= 'N'
	where	AreaCode		= @ls_areacode	
	and	DivisionCode		= @ls_divisioncode
	and	WorkCenter		= @ls_workcenter
	and	ItemCode		= @ls_itemcode
	and	subLineCode		= @ls_subLineCode
	and	subLineNo		= @ls_subLineNo
	and	tarMonth			= @ls_tarMonth
	and	lastemp 			= 'Y'

End	-- while loop end

truncate table #tmp_tmhmonthtarget


-- 진천

Insert	into	#tmp_tmhmonthtarget
select	*
from	[ipisjin_svr].ipis.dbo.tmhmonthtarget
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_AreaCode		= areacode,
		@ls_DivisionCode		= divisioncode,
		@ls_WorkCenter		= workcenter,
		@ls_ItemCode		= itemcode,
		@ls_subLineCode	= subLineCode,
		@ls_subLineNo		= subLineNo,
		@ls_tarMonth		= tarMonth,
		@ls_tarMH		= tarMH,
		@ls_modifyFlag		= modifyflag,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmhmonthtarget
	Where	checkid > @ls_id

	If not exists (select * from tmhmonthtarget 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	ItemCode	= @ls_itemcode
			and	subLineCode	= @ls_subLineCode
			and	subLineNo	= @ls_subLineNo
			and	tarMonth	= @ls_tarMonth		)

		insert into tmhmonthtarget
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		tarMonth,		tarMH,
			modifyFlag,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_tarMonth,		@ls_tarMH,
			@ls_modifyFlag,		@ls_LastEmp)

	Else
		begin
		
		delete	from tmhmonthtarget		
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	ItemCode	= @ls_itemcode
		and	subLineCode	= @ls_subLineCode
		and	subLineNo	= @ls_subLineNo
		and	tarMonth	= @ls_tarMonth
		
		insert into tmhmonthtarget
			(AreaCode,		DivisionCode,		WorkCenter,		ItemCode,
			subLineCode,		subLineNo,		tarMonth,		tarMH,
			modifyFlag,		lastemp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,		@ls_ItemCode,
			@ls_subLineCode,	@ls_subLineNo,		@ls_tarMonth,		@ls_tarMH,
			@ls_modifyFlag,		@ls_LastEmp)
		
		end

	update	[ipisjin_svr].ipis.dbo.tmhmonthtarget
	set	lastemp 	= 'N'
	where	AreaCode		= @ls_areacode	
	and	DivisionCode		= @ls_divisioncode
	and	WorkCenter		= @ls_workcenter
	and	ItemCode		= @ls_itemcode
	and	subLineCode		= @ls_subLineCode
	and	subLineNo		= @ls_subLineNo
	and	tarMonth			= @ls_tarMonth
	and	lastemp 			= 'Y'

End	-- while loop end

drop table #tmp_tmhmonthtarget
 
End		-- Procedure End
Go
