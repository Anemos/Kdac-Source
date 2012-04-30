/*
	File Name	: sp_pisi_eis_tlotno.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tlotno
	Description	: EIS Upload tlotno
			  tlotno
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tlotno]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tlotno]
GO

/*
Execute sp_pisi_eis_tlotno
*/

Create Procedure sp_pisi_eis_tlotno

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_tracedate		char(10),
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_lotno		char(6),
	@ls_itemcode		varchar(12),
	@ls_custcode		char(6),
	@ls_shipgubun		char(1),
	@ls_shipusage		char(1),
	@ls_prdqty		int,
	@ls_stockqty		int,
	@ls_shipqty		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_today		char(10)

create table #tmp_tlotno
(	checkId		int IDENTITY(1,1),
	TraceDate	char (10),
	AreaCode	char (1),
	DivisionCode	char (1),
	LotNo		char(6),
	ItemCode	varchar (12),
	CustCode	char(6),
	ShipGubun	char(1),
	ShipUsage	char(1),
	PrdQty		int,
	StockQty	int,
	ShipQty		int,
	LastEmp		varchar(6),
	LastDate	datetime	)

select	@ls_today = convert(char(10), getdate(), 102)

-- 대구전장	

Insert	into	#tmp_tlotno
select	*
from	[ipisele_svr\ipis].ipis.dbo.tlotno
where	tracedate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_tracedate		= tracedate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_lotno		= lotno,
		@ls_itemcode		= itemcode,
		@ls_custcode		= custcode,
		@ls_shipgubun		= shipgubun,
		@ls_shipusage		= shipusage,
		@ls_prdqty		= prdqty,
		@ls_stockqty		= stockqty,
		@ls_shipqty		= shipqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tlotno
	Where	checkid > @ls_id

	If not exists (select * from tlotno 
			where	tracedate	= @ls_tracedate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	lotno		= @ls_lotno
			and	ItemCode	= @ls_itemcode
			and	custcode	= @ls_custcode
			and	shipgubun	= @ls_shipgubun)

		insert into tlotno
			(tracedate,	AreaCode,	DivisionCode,		LotNo,		ItemCode,
			custcode,	shipgubun,	shipusage,		prdqty,		stockqty,
			shipqty,	LastEmp)
		values	(@ls_tracedate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_lotno,	@ls_ItemCode,
			@ls_custcode,	@ls_shipgubun,	@ls_shipusage,		@ls_prdqty,	@ls_stockqty,
			@ls_shipqty,	@ls_LastEmp)

	Else
		update	tlotno
		set	shipusage	= @ls_shipusage,
			prdqty		= @ls_prdqty,
			stockqty	= @ls_stockqty,
			shipqty		= @ls_shipqty
		where	tracedate	= @ls_tracedate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	Lotno		= @ls_lotno
		and	ItemCode	= @ls_itemcode
		and	custcode	= @ls_custcode
		and	shipgubun	= @ls_shipgubun

	update	[ipisele_svr\ipis].ipis.dbo.tlotno
	set	lastemp 	= 'N'
	where	tracedate	= @ls_tracedate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	Lotno		= @ls_lotno
	and	ItemCode	= @ls_itemcode
	and	custcode	= @ls_custcode
	and	shipgubun	= @ls_shipgubun
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tlotno


-- 대구기계

Insert	into	#tmp_tlotno
select	*
from	[ipismac_svr\ipis].ipis.dbo.tlotno
where	tracedate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_tracedate		= tracedate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_lotno		= lotno,
		@ls_itemcode		= itemcode,
		@ls_custcode		= custcode,
		@ls_shipgubun		= shipgubun,
		@ls_shipusage		= shipusage,
		@ls_prdqty		= prdqty,
		@ls_stockqty		= stockqty,
		@ls_shipqty		= shipqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tlotno
	Where	checkid > @ls_id

	If not exists (select * from tlotno 
			where	tracedate	= @ls_tracedate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	lotno		= @ls_lotno
			and	ItemCode	= @ls_itemcode
			and	custcode	= @ls_custcode
			and	shipgubun	= @ls_shipgubun)

		insert into tlotno
			(tracedate,	AreaCode,	DivisionCode,		LotNo,		ItemCode,
			custcode,	shipgubun,	shipusage,		prdqty,		stockqty,
			shipqty,	LastEmp)
		values	(@ls_tracedate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_lotno,	@ls_ItemCode,
			@ls_custcode,	@ls_shipgubun,	@ls_shipusage,		@ls_prdqty,	@ls_stockqty,
			@ls_shipqty,	@ls_LastEmp)

	Else
		update	tlotno
		set	shipusage	= @ls_shipusage,
			prdqty		= @ls_prdqty,
			stockqty	= @ls_stockqty,
			shipqty		= @ls_shipqty
		where	tracedate	= @ls_tracedate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	Lotno		= @ls_lotno
		and	ItemCode	= @ls_itemcode
		and	custcode	= @ls_custcode
		and	shipgubun	= @ls_shipgubun

	update	[ipismac_svr\ipis].ipis.dbo.tlotno
	set	lastemp 	= 'N'
	where	tracedate	= @ls_tracedate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	Lotno		= @ls_lotno
	and	ItemCode	= @ls_itemcode
	and	custcode	= @ls_custcode
	and	shipgubun	= @ls_shipgubun
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tlotno


-- 대구압축

Insert	into	#tmp_tlotno
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tlotno
where	tracedate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_tracedate		= tracedate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_lotno		= lotno,
		@ls_itemcode		= itemcode,
		@ls_custcode		= custcode,
		@ls_shipgubun		= shipgubun,
		@ls_shipusage		= shipusage,
		@ls_prdqty		= prdqty,
		@ls_stockqty		= stockqty,
		@ls_shipqty		= shipqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tlotno
	Where	checkid > @ls_id

	If not exists (select * from tlotno 
			where	tracedate	= @ls_tracedate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	lotno		= @ls_lotno
			and	ItemCode	= @ls_itemcode
			and	custcode	= @ls_custcode
			and	shipgubun	= @ls_shipgubun)

		insert into tlotno
			(tracedate,	AreaCode,	DivisionCode,		LotNo,		ItemCode,
			custcode,	shipgubun,	shipusage,		prdqty,		stockqty,
			shipqty,	LastEmp)
		values	(@ls_tracedate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_lotno,	@ls_ItemCode,
			@ls_custcode,	@ls_shipgubun,	@ls_shipusage,		@ls_prdqty,	@ls_stockqty,
			@ls_shipqty,	@ls_LastEmp)

	Else
		update	tlotno
		set	shipusage	= @ls_shipusage,
			prdqty		= @ls_prdqty,
			stockqty	= @ls_stockqty,
			shipqty		= @ls_shipqty
		where	tracedate	= @ls_tracedate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	Lotno		= @ls_lotno
		and	ItemCode	= @ls_itemcode
		and	custcode	= @ls_custcode
		and	shipgubun	= @ls_shipgubun

	update	[ipishvac_svr\ipis].ipis.dbo.tlotno
	set	lastemp 	= 'N'
	where	tracedate	= @ls_tracedate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	Lotno		= @ls_lotno
	and	ItemCode	= @ls_itemcode
	and	custcode	= @ls_custcode
	and	shipgubun	= @ls_shipgubun
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tlotno


-- 진천

Insert	into	#tmp_tlotno
select	*
from	[ipisjin_svr].ipis.dbo.tlotno
where	tracedate <= @ls_today
and	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @ls_id = 0
	
While @i < @li_loop_count
Begin
	Select	Top 1
		@i			= @i + 1,
		@ls_tracedate		= tracedate,
		@ls_areacode		= areacode,
		@ls_divisioncode	= divisioncode,
		@ls_lotno		= lotno,
		@ls_itemcode		= itemcode,
		@ls_custcode		= custcode,
		@ls_shipgubun		= shipgubun,
		@ls_shipusage		= shipusage,
		@ls_prdqty		= prdqty,
		@ls_stockqty		= stockqty,
		@ls_shipqty		= shipqty,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tlotno
	Where	checkid > @ls_id

	If not exists (select * from tlotno 
			where	tracedate	= @ls_tracedate
			and	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	lotno		= @ls_lotno
			and	ItemCode	= @ls_itemcode
			and	custcode	= @ls_custcode
			and	shipgubun	= @ls_shipgubun)

		insert into tlotno
			(tracedate,	AreaCode,	DivisionCode,		LotNo,		ItemCode,
			custcode,	shipgubun,	shipusage,		prdqty,		stockqty,
			shipqty,	LastEmp)
		values	(@ls_tracedate,	@ls_AreaCode,	@ls_DivisionCode,	@ls_lotno,	@ls_ItemCode,
			@ls_custcode,	@ls_shipgubun,	@ls_shipusage,		@ls_prdqty,	@ls_stockqty,
			@ls_shipqty,	@ls_LastEmp)

	Else
		update	tlotno
		set	shipusage	= @ls_shipusage,
			prdqty		= @ls_prdqty,
			stockqty	= @ls_stockqty,
			shipqty		= @ls_shipqty
		where	tracedate	= @ls_tracedate
		and	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	Lotno		= @ls_lotno
		and	ItemCode	= @ls_itemcode
		and	custcode	= @ls_custcode
		and	shipgubun	= @ls_shipgubun

	update	[ipisjin_svr].ipis.dbo.tlotno
	set	lastemp 	= 'N'
	where	tracedate	= @ls_tracedate
	and	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	Lotno		= @ls_lotno
	and	ItemCode	= @ls_itemcode
	and	custcode	= @ls_custcode
	and	shipgubun	= @ls_shipgubun
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tlotno
 
End		-- Procedure End
Go
