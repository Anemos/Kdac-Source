/*
	File Name	: sp_pisi_eis_tinvhis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tinvhis
	Description	: EIS Upload tinvhis
			  tinvhis
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tinvhis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tinvhis]
GO

/*
Execute sp_pisi_eis_tinvhis
*/

Create Procedure sp_pisi_eis_tinvhis

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_applymonth		char(7),
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_itemcode		varchar(12),
	@ls_invqty		int,
	@ls_repairqty		int,
	@ls_defectqty		int,
	@ls_moveinvqty		int,
	@ls_shipinvqty		int,
	@ls_invcompute		char(1),
	@ls_closeflag		char(1),
	@ls_closedate		datetime,	
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tinvhis
(	checkId		int IDENTITY(1,1),
	applymonth	char (7),
	AreaCode	char (1),
	DivisionCode	char (1),
	ItemCode	varchar (12),
	InvQty		int,
	RepairQty	int,
	DefectQty	int,
	MoveInvQty	int,
	ShipInvQty	int,
	InvCompute	char(1),
	CloseFlag	char(1),
	CloseDate	datetime,
	LastEmp		varchar(6),
	LastDate	datetime	)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tinvhis
select	*
from	[ipisele_svr\ipis].ipis.dbo.tinvhis
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_applymonth		= applymonth,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_itemcode		= itemcode,
		@ls_invqty		= invqty,
		@ls_repairqty		= repairqty,
		@ls_defectqty		= defectqty,
		@ls_moveinvqty		= moveinvqty,
		@ls_shipinvqty		= shipinvqty,
		@ls_invcompute		= invcompute,
		@ls_closeflag		= closeflag,
		@ls_closedate		= closedate,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tinvhis
	Where	checkid > @ls_id

	If not exists (select * from tinvhis 
			where	applymonth	= @ls_applymonth
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	ItemCode	= @ls_itemcode)

		insert into tinvhis
			(applymonth,		AreaCode,	DivisionCode,		ItemCode,	invqty,
			repairqty,		defectqty,	moveinvqty,		shipinvqty,	invcompute,
			closeflag,		closedate,	LastEmp)
		values	(@ls_applymonth,	@ls_AreaCode,	@ls_DivisionCode,	@ls_ItemCode,	@ls_invqty,
			@ls_repairqty,		@ls_defectqty,	@ls_moveinvqty,		@ls_shipinvqty,	@ls_invcompute,
			@ls_closeflag,		@ls_closedate,	@ls_LastEmp)

	Else
		update	tinvhis
		set	invqty		= @ls_invqty,
			repairqty	= @ls_repairqty,
			defectqty	= @ls_defectqty,
			moveinvqty	= @ls_moveinvqty,
			shipinvqty	= @ls_shipinvqty,
			invcompute	= @ls_invcompute,
			closeflag	= @ls_closeflag,
			closedate	= @ls_closedate
		where	applymonth	= @ls_applymonth
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	ItemCode	= @ls_itemcode
		
	update	[ipisele_svr\ipis].ipis.dbo.tinvhis
	set	lastemp 	= 'N'
	where	applymonth	= @ls_applymonth
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	ItemCode	= @ls_itemcode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tinvhis


-- 대구기계

Insert	into	#tmp_tinvhis
select	*
from	[ipismac_svr\ipis].ipis.dbo.tinvhis
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_applymonth		= applymonth,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_itemcode		= itemcode,
		@ls_invqty		= invqty,
		@ls_repairqty		= repairqty,
		@ls_defectqty		= defectqty,
		@ls_moveinvqty		= moveinvqty,
		@ls_shipinvqty		= shipinvqty,
		@ls_invcompute		= invcompute,
		@ls_closeflag		= closeflag,
		@ls_closedate		= closedate,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tinvhis
	Where	checkid > @ls_id

	If not exists (select * from tinvhis 
			where	applymonth	= @ls_applymonth
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	ItemCode	= @ls_itemcode)

		insert into tinvhis
			(applymonth,		AreaCode,	DivisionCode,		ItemCode,	invqty,
			repairqty,		defectqty,	moveinvqty,		shipinvqty,	invcompute,
			closeflag,		closedate,	LastEmp)
		values	(@ls_applymonth,	@ls_AreaCode,	@ls_DivisionCode,	@ls_ItemCode,	@ls_invqty,
			@ls_repairqty,		@ls_defectqty,	@ls_moveinvqty,		@ls_shipinvqty,	@ls_invcompute,
			@ls_closeflag,		@ls_closedate,	@ls_LastEmp)

	Else
		update	tinvhis
		set	invqty		= @ls_invqty,
			repairqty	= @ls_repairqty,
			defectqty	= @ls_defectqty,
			moveinvqty	= @ls_moveinvqty,
			shipinvqty	= @ls_shipinvqty,
			invcompute	= @ls_invcompute,
			closeflag	= @ls_closeflag,
			closedate	= @ls_closedate
		where	applymonth	= @ls_applymonth
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	ItemCode	= @ls_itemcode
		
	update	[ipismac_svr\ipis].ipis.dbo.tinvhis
	set	lastemp 	= 'N'
	where	applymonth	= @ls_applymonth
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	ItemCode	= @ls_itemcode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tinvhis


-- 대구압축

Insert	into	#tmp_tinvhis
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tinvhis
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_applymonth		= applymonth,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_itemcode		= itemcode,
		@ls_invqty		= invqty,
		@ls_repairqty		= repairqty,
		@ls_defectqty		= defectqty,
		@ls_moveinvqty		= moveinvqty,
		@ls_shipinvqty		= shipinvqty,
		@ls_invcompute		= invcompute,
		@ls_closeflag		= closeflag,
		@ls_closedate		= closedate,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tinvhis
	Where	checkid > @ls_id

	If not exists (select * from tinvhis 
			where	applymonth	= @ls_applymonth
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	ItemCode	= @ls_itemcode)

		insert into tinvhis
			(applymonth,		AreaCode,	DivisionCode,		ItemCode,	invqty,
			repairqty,		defectqty,	moveinvqty,		shipinvqty,	invcompute,
			closeflag,		closedate,	LastEmp)
		values	(@ls_applymonth,	@ls_AreaCode,	@ls_DivisionCode,	@ls_ItemCode,	@ls_invqty,
			@ls_repairqty,		@ls_defectqty,	@ls_moveinvqty,		@ls_shipinvqty,	@ls_invcompute,
			@ls_closeflag,		@ls_closedate,	@ls_LastEmp)

	Else
		update	tinvhis
		set	invqty		= @ls_invqty,
			repairqty	= @ls_repairqty,
			defectqty	= @ls_defectqty,
			moveinvqty	= @ls_moveinvqty,
			shipinvqty	= @ls_shipinvqty,
			invcompute	= @ls_invcompute,
			closeflag	= @ls_closeflag,
			closedate	= @ls_closedate
		where	applymonth	= @ls_applymonth
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	ItemCode	= @ls_itemcode
		
	update	[ipishvac_svr\ipis].ipis.dbo.tinvhis
	set	lastemp 	= 'N'
	where	applymonth	= @ls_applymonth
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	ItemCode	= @ls_itemcode
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tinvhis


-- 진천

Insert	into	#tmp_tinvhis
select	*
from	[ipisjin_svr].ipis.dbo.tinvhis
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_applymonth		= applymonth,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_itemcode		= itemcode,
		@ls_invqty		= invqty,
		@ls_repairqty		= repairqty,
		@ls_defectqty		= defectqty,
		@ls_moveinvqty		= moveinvqty,
		@ls_shipinvqty		= shipinvqty,
		@ls_invcompute		= invcompute,
		@ls_closeflag		= closeflag,
		@ls_closedate		= closedate,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tinvhis
	Where	checkid > @ls_id

	If not exists (select * from tinvhis 
			where	applymonth	= @ls_applymonth
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	ItemCode	= @ls_itemcode)

		insert into tinvhis
			(applymonth,		AreaCode,	DivisionCode,		ItemCode,	invqty,
			repairqty,		defectqty,	moveinvqty,		shipinvqty,	invcompute,
			closeflag,		closedate,	LastEmp)
		values	(@ls_applymonth,	@ls_AreaCode,	@ls_DivisionCode,	@ls_ItemCode,	@ls_invqty,
			@ls_repairqty,		@ls_defectqty,	@ls_moveinvqty,		@ls_shipinvqty,	@ls_invcompute,
			@ls_closeflag,		@ls_closedate,	@ls_LastEmp)

	Else
		update	tinvhis
		set	invqty		= @ls_invqty,
			repairqty	= @ls_repairqty,
			defectqty	= @ls_defectqty,
			moveinvqty	= @ls_moveinvqty,
			shipinvqty	= @ls_shipinvqty,
			invcompute	= @ls_invcompute,
			closeflag	= @ls_closeflag,
			closedate	= @ls_closedate
		where	applymonth	= @ls_applymonth
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	ItemCode	= @ls_itemcode
		
	update	[ipisjin_svr].ipis.dbo.tinvhis
	set	lastemp 	= 'N'
	where	applymonth	= @ls_applymonth
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	ItemCode	= @ls_itemcode
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tinvhis
 
End		-- Procedure End
Go
