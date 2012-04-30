/*
	File Name	: sp_pisi_eis_tmstkb.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmstkb
	Description	: EIS Upload tmstkb
			  tmstkb
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmstkb]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmstkb]
GO

/*
Execute sp_pisi_eis_tmstkb
*/

Create Procedure sp_pisi_eis_tmstkb

	
As
Begin

Declare	@i			Int,
	@li_loop_count		Int,
	@ls_id			int,
	@ls_areacode		char(1),
	@ls_divisioncode	char(1),
	@ls_workcenter		varchar(5),
	@ls_linecode		char(1),
	@ls_itemcode		varchar(12),
	@ls_applyfrom		char(10),
	@ls_modelid		varchar(4),
	@ls_lineid		char(2),
	@ls_kbid		char(2),
	@ls_normalkbsn		char(11),
	@ls_tempkbsn		char(11),
	@ls_productgubun	char(1),
	@ls_stockgubun		char(1),
	@ls_prdstopgubun	char(1),
	@ls_rackcode		char(5),
	@ls_rackqty		int,
	@ls_lotsize		int,
	@ls_carname		varchar(50),
	@ls_mainlinegubun	char(1),
	@ls_dividerate		int,
	@ls_pcsperhour		int,
	@ls_safetyinvqty	int,
	@ls_kbfactor		numeric(3,1),
	@ls_safetyfactor	numeric(3,1),
	@ls_stocklocation	char(3),
	@ls_sortorder		int,
	@ls_lastemp		varchar(6),
	@ls_lastdate		datetime,
	@ls_yesterday		char(10)

create table #tmp_tmstkb
(	checkId		int IDENTITY(1,1),
	AreaCode	char (1),
	DivisionCode	char (1),
	WorkCenter	varchar (5),
	LineCode	char (1),
	ItemCode	varchar (12),
	ApplyFrom	char (10),
	ModelID		varchar (4),
	LineID		char (2),
	KBID		char (4),
	NormalKBSN	char (11),
	TempKBSN	char (11),
	ProductGubun	char (1),
	StockGubun	char(1),
	PrdStopGubun	char(1),
	RackCode	char (5),
	RackQty		int,
	LotSize		int,
	CarName		varchar (50),
	MainLineGubun	char (1),
	DivideRate	int,
	PCSPerHour	int,
	SafetyInvQty	int,
	KBFactor	numeric(3, 1),
	SafetyFactor	numeric(3, 1),
	StockLocation	char (3),
	SortOrder	int,
	LastEmp		varchar(6),
	LastDate	datetime	)

-- 각 서버 tdelete에서 tablename이 tmstkb인 놈 정리하고...

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tmstkb
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstkb
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
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_modelid		= modelid,
		@ls_lineid		= lineid,
		@ls_kbid		= kbid,
		@ls_normalkbsn		= normalkbsn,
		@ls_tempkbsn		= tempkbsn,
		@ls_productgubun	= productgubun,
		@ls_stockgubun		= stockgubun,
		@ls_prdstopgubun	= prdstopgubun,
		@ls_rackcode		= rackcode,
		@ls_rackqty		= rackqty,
		@ls_lotsize		= lotsize,
		@ls_carname		= carname,
		@ls_mainlinegubun	= mainlinegubun,
		@ls_dividerate		= dividerate,
		@ls_pcsperhour		= pcsperhour,
		@ls_safetyinvqty		= safetyinvqty,
		@ls_kbfactor		= kbfactor,
		@ls_safetyfactor	= safetyfactor,
		@ls_stocklocation	= stocklocation,
		@ls_sortorder		= sortorder,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstkb
	Where	checkid > @ls_id

	If not exists (select * from tmstkb 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tmstkb
			(AreaCode,		DivisionCode,		WorkCenter,	LineCode,	ItemCode,
			ApplyFrom,		ModelID,		LineID,		KBID,		NormalKBSN,
			TempKBSN,		ProductGubun,		StockGubun,	PrdStopGubun,	RackCode,
			RackQty,		LotSize,		CarName,	MainLineGubun,	
			DivideRate,		PCSPerHour,		SafetyInvQty,	
			KBFactor,		SafetyFactor,		StockLocation,	
			SortOrder,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	@ls_LineCode,	@ls_ItemCode,
			@ls_applyfrom,		@ls_modelid,		@ls_lineid,	@ls_kbid,	@ls_normalkbsn,
			@ls_tempkbsn,		@ls_productgubun,	@ls_stockgubun,	@ls_prdstopgubun,@ls_rackcode,
			@ls_rackqty,		@ls_lotsize,		@ls_carname,	@ls_mainlinegubun,
			@ls_dividerate,		@ls_pcsperhour,		@ls_safetyinvqty,
			@ls_kbfactor,		@ls_safetyfactor,	@ls_stocklocation,
			@ls_sortorder,		@ls_LastEmp)

	Else
		update	tmstkb
		set	ApplyFrom	= @ls_applyfrom,
			ModelID		= @ls_modelid,
			LineID		= @ls_lineid,
			KBID		= @ls_kbid,
			NormalKBSN	= @ls_normalkbsn,
			TempKBSN	= @ls_tempkbsn,
			ProductGubun	= @ls_productgubun,
			StockGubun	= @ls_stockgubun,
			PrdStopGubun	= @ls_prdstopgubun,
			RackCode	= @ls_rackcode,
			RackQty		= @ls_rackqty,
			LotSize		= @ls_lotsize,
			CarName		= @ls_carname,
			MainLineGubun	= @ls_mainlinegubun,	
			DivideRate	= @ls_dividerate,
			PCSPerHour	= @ls_pcsperhour,
			SafetyInvQty	= @ls_safetyinvqty,	
			KBFactor	= @ls_kbfactor,
			SafetyFactor	= @ls_safetyfactor,
			StockLocation	= @ls_stocklocation,	
			SortOrder	= @ls_sortorder
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipisele_svr\ipis].ipis.dbo.tmstkb
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstkb


-- 대구기계

Insert	into	#tmp_tmstkb
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstkb
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
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_modelid		= modelid,
		@ls_lineid		= lineid,
		@ls_kbid		= kbid,
		@ls_normalkbsn		= normalkbsn,
		@ls_tempkbsn		= tempkbsn,
		@ls_productgubun	= productgubun,
		@ls_stockgubun		= stockgubun,
		@ls_prdstopgubun	= prdstopgubun,
		@ls_rackcode		= rackcode,
		@ls_rackqty		= rackqty,
		@ls_lotsize		= lotsize,
		@ls_carname		= carname,
		@ls_mainlinegubun	= mainlinegubun,
		@ls_dividerate		= dividerate,
		@ls_pcsperhour		= pcsperhour,
		@ls_safetyinvqty		= safetyinvqty,
		@ls_kbfactor		= kbfactor,
		@ls_safetyfactor	= safetyfactor,
		@ls_stocklocation	= stocklocation,
		@ls_sortorder		= sortorder,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstkb
	Where	checkid > @ls_id

	If not exists (select * from tmstkb 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tmstkb
			(AreaCode,		DivisionCode,		WorkCenter,	LineCode,	ItemCode,
			ApplyFrom,		ModelID,		LineID,		KBID,		NormalKBSN,
			TempKBSN,		ProductGubun,		StockGubun,	PrdStopGubun,	RackCode,
			RackQty,		LotSize,		CarName,	MainLineGubun,	
			DivideRate,		PCSPerHour,		SafetyInvQty,	
			KBFactor,		SafetyFactor,		StockLocation,	
			SortOrder,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	@ls_LineCode,	@ls_ItemCode,
			@ls_applyfrom,		@ls_modelid,		@ls_lineid,	@ls_kbid,	@ls_normalkbsn,
			@ls_tempkbsn,		@ls_productgubun,	@ls_stockgubun,	@ls_prdstopgubun,@ls_rackcode,
			@ls_rackqty,		@ls_lotsize,		@ls_carname,	@ls_mainlinegubun,
			@ls_dividerate,		@ls_pcsperhour,		@ls_safetyinvqty,
			@ls_kbfactor,		@ls_safetyfactor,	@ls_stocklocation,
			@ls_sortorder,		@ls_LastEmp)

	Else
		update	tmstkb
		set	ApplyFrom	= @ls_applyfrom,
			ModelID		= @ls_modelid,
			LineID		= @ls_lineid,
			KBID		= @ls_kbid,
			NormalKBSN	= @ls_normalkbsn,
			TempKBSN	= @ls_tempkbsn,
			ProductGubun	= @ls_productgubun,
			StockGubun	= @ls_stockgubun,
			PrdStopGubun	= @ls_prdstopgubun,
			RackCode	= @ls_rackcode,
			RackQty		= @ls_rackqty,
			LotSize		= @ls_lotsize,
			CarName		= @ls_carname,
			MainLineGubun	= @ls_mainlinegubun,	
			DivideRate	= @ls_dividerate,
			PCSPerHour	= @ls_pcsperhour,
			SafetyInvQty	= @ls_safetyinvqty,	
			KBFactor	= @ls_kbfactor,
			SafetyFactor	= @ls_safetyfactor,
			StockLocation	= @ls_stocklocation,	
			SortOrder	= @ls_sortorder
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipismac_svr\ipis].ipis.dbo.tmstkb
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstkb


-- 대구압축

Insert	into	#tmp_tmstkb
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstkb
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
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_modelid		= modelid,
		@ls_lineid		= lineid,
		@ls_kbid		= kbid,
		@ls_normalkbsn		= normalkbsn,
		@ls_tempkbsn		= tempkbsn,
		@ls_productgubun	= productgubun,
		@ls_stockgubun		= stockgubun,
		@ls_prdstopgubun	= prdstopgubun,
		@ls_rackcode		= rackcode,
		@ls_rackqty		= rackqty,
		@ls_lotsize		= lotsize,
		@ls_carname		= carname,
		@ls_mainlinegubun	= mainlinegubun,
		@ls_dividerate		= dividerate,
		@ls_pcsperhour		= pcsperhour,
		@ls_safetyinvqty		= safetyinvqty,
		@ls_kbfactor		= kbfactor,
		@ls_safetyfactor	= safetyfactor,
		@ls_stocklocation	= stocklocation,
		@ls_sortorder		= sortorder,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstkb
	Where	checkid > @ls_id

	If not exists (select * from tmstkb 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tmstkb
			(AreaCode,		DivisionCode,		WorkCenter,	LineCode,	ItemCode,
			ApplyFrom,		ModelID,		LineID,		KBID,		NormalKBSN,
			TempKBSN,		ProductGubun,		StockGubun,	PrdStopGubun,	RackCode,
			RackQty,		LotSize,		CarName,	MainLineGubun,	
			DivideRate,		PCSPerHour,		SafetyInvQty,	
			KBFactor,		SafetyFactor,		StockLocation,	
			SortOrder,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	@ls_LineCode,	@ls_ItemCode,
			@ls_applyfrom,		@ls_modelid,		@ls_lineid,	@ls_kbid,	@ls_normalkbsn,
			@ls_tempkbsn,		@ls_productgubun,	@ls_stockgubun,	@ls_prdstopgubun,@ls_rackcode,
			@ls_rackqty,		@ls_lotsize,		@ls_carname,	@ls_mainlinegubun,
			@ls_dividerate,		@ls_pcsperhour,		@ls_safetyinvqty,
			@ls_kbfactor,		@ls_safetyfactor,	@ls_stocklocation,
			@ls_sortorder,		@ls_LastEmp)

	Else
		update	tmstkb
		set	ApplyFrom	= @ls_applyfrom,
			ModelID		= @ls_modelid,
			LineID		= @ls_lineid,
			KBID		= @ls_kbid,
			NormalKBSN	= @ls_normalkbsn,
			TempKBSN	= @ls_tempkbsn,
			ProductGubun	= @ls_productgubun,
			StockGubun	= @ls_stockgubun,
			PrdStopGubun	= @ls_prdstopgubun,
			RackCode	= @ls_rackcode,
			RackQty		= @ls_rackqty,
			LotSize		= @ls_lotsize,
			CarName		= @ls_carname,
			MainLineGubun	= @ls_mainlinegubun,	
			DivideRate	= @ls_dividerate,
			PCSPerHour	= @ls_pcsperhour,
			SafetyInvQty	= @ls_safetyinvqty,	
			KBFactor	= @ls_kbfactor,
			SafetyFactor	= @ls_safetyfactor,
			StockLocation	= @ls_stocklocation,	
			SortOrder	= @ls_sortorder
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipishvac_svr\ipis].ipis.dbo.tmstkb
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

truncate table #tmp_tmstkb


-- 진천

Insert	into	#tmp_tmstkb
select	*
from	[ipisjin_svr].ipis.dbo.tmstkb
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
		@ls_itemcode		= itemcode,
		@ls_applyfrom		= applyfrom,
		@ls_modelid		= modelid,
		@ls_lineid		= lineid,
		@ls_kbid		= kbid,
		@ls_normalkbsn		= normalkbsn,
		@ls_tempkbsn		= tempkbsn,
		@ls_productgubun	= productgubun,
		@ls_stockgubun		= stockgubun,
		@ls_prdstopgubun	= prdstopgubun,
		@ls_rackcode		= rackcode,
		@ls_rackqty		= rackqty,
		@ls_lotsize		= lotsize,
		@ls_carname		= carname,
		@ls_mainlinegubun	= mainlinegubun,
		@ls_dividerate		= dividerate,
		@ls_pcsperhour		= pcsperhour,
		@ls_safetyinvqty		= safetyinvqty,
		@ls_kbfactor		= kbfactor,
		@ls_safetyfactor	= safetyfactor,
		@ls_stocklocation	= stocklocation,
		@ls_sortorder		= sortorder,
		@ls_lastemp		= lastemp,
		@ls_id			= checkid
	From	#tmp_tmstkb
	Where	checkid > @ls_id

	If not exists (select * from tmstkb 
			where	AreaCode	= @ls_areacode
			and	DivisionCode	= @ls_divisioncode
			and	WorkCenter	= @ls_workcenter
			and	LineCode	= @ls_linecode
			and	ItemCode	= @ls_itemcode)

		insert into tmstkb
			(AreaCode,		DivisionCode,		WorkCenter,	LineCode,	ItemCode,
			ApplyFrom,		ModelID,		LineID,		KBID,		NormalKBSN,
			TempKBSN,		ProductGubun,		StockGubun,	PrdStopGubun,	RackCode,
			RackQty,		LotSize,		CarName,	MainLineGubun,	
			DivideRate,		PCSPerHour,		SafetyInvQty,	
			KBFactor,		SafetyFactor,		StockLocation,	
			SortOrder,		LastEmp)
		values	(@ls_AreaCode,		@ls_DivisionCode,	@ls_WorkCenter,	@ls_LineCode,	@ls_ItemCode,
			@ls_applyfrom,		@ls_modelid,		@ls_lineid,	@ls_kbid,	@ls_normalkbsn,
			@ls_tempkbsn,		@ls_productgubun,	@ls_stockgubun,	@ls_prdstopgubun,@ls_rackcode,
			@ls_rackqty,		@ls_lotsize,		@ls_carname,	@ls_mainlinegubun,
			@ls_dividerate,		@ls_pcsperhour,		@ls_safetyinvqty,
			@ls_kbfactor,		@ls_safetyfactor,	@ls_stocklocation,
			@ls_sortorder,		@ls_LastEmp)

	Else
		update	tmstkb
		set	ApplyFrom	= @ls_applyfrom,
			ModelID		= @ls_modelid,
			LineID		= @ls_lineid,
			KBID		= @ls_kbid,
			NormalKBSN	= @ls_normalkbsn,
			TempKBSN	= @ls_tempkbsn,
			ProductGubun	= @ls_productgubun,
			StockGubun	= @ls_stockgubun,
			PrdStopGubun	= @ls_prdstopgubun,
			RackCode	= @ls_rackcode,
			RackQty		= @ls_rackqty,
			LotSize		= @ls_lotsize,
			CarName		= @ls_carname,
			MainLineGubun	= @ls_mainlinegubun,	
			DivideRate	= @ls_dividerate,
			PCSPerHour	= @ls_pcsperhour,
			SafetyInvQty	= @ls_safetyinvqty,	
			KBFactor	= @ls_kbfactor,
			SafetyFactor	= @ls_safetyfactor,
			StockLocation	= @ls_stocklocation,	
			SortOrder	= @ls_sortorder
		where	AreaCode	= @ls_areacode
		and	DivisionCode	= @ls_divisioncode
		and	WorkCenter	= @ls_workcenter
		and	LineCode	= @ls_linecode
		and	ItemCode	= @ls_itemcode

	update	[ipisjin_svr].ipis.dbo.tmstkb
	set	lastemp 	= 'N'
	where	AreaCode	= @ls_areacode
	and	DivisionCode	= @ls_divisioncode
	and	WorkCenter	= @ls_workcenter
	and	LineCode	= @ls_linecode
	and	ItemCode	= @ls_itemcode		
	and	lastemp 	= 'Y'

End	-- while loop end

drop table #tmp_tmstkb
 
End		-- Procedure End
Go
