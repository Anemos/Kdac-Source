/*
	File Name	: sp_pisi_eis_tqqcresult.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tqqcresult
	Description	: EIS Upload tqqcresult
			  tqqcresult
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tqqcresult]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tqqcresult]
GO

/*
Execute sp_pisi_eis_tqqcresult
*/

Create Procedure sp_pisi_eis_tqqcresult

As
Begin

Declare	@i				Int,
	@li_loop_count			Int,
	@li_id				int,
	@ls_areacode			char(1),
	@ls_divisioncode			char(1),
	@ls_suppliercode		char(5),
	@ls_deliveryno			varchar(12),
	@ls_itemcode			varchar(12),
	@ls_makedate			char(10),
	@ls_chargename			varchar(10),
	@ls_standardrevno		char(2),
	@li_supplierlotqty			int,
	@li_kbcount			int,
	@li_supplierdeliveryqty		int,
	@ls_qcmethod			char(1),
	@ls_remark			varchar(150),
	@ls_kdacremark			varchar(150),
	@ls_judgeflag			char(1),
	@li_goodqty			int,
	@li_badqty			int,
	@ls_badreason			char(1),
	@ls_badmemo			varchar(100),
	@ls_inspectorcode		varchar(6),
	@ls_confirmcode			varchar(6),
	@ls_confirmflag			char(1),
	@ls_printflag			char(1),
	@ls_qcdate			char(10),
	@ls_qctime			char(8),
	@ls_qcleadtime			char(8),
	@ls_qckbflag			char(1),
	@ls_slno			char(12),
	@ls_deliverydate			char(10),
	@ls_deliverytime			char(8),
	@ls_lastemp			varchar(6),
	@ldt_lastdate			datetime,
	@ls_yesterday			char(10)

create table #tmp_tqqcresult
(	checkId				int IDENTITY(1,1),
	AREACODE			char(1),
	DIVISIONCODE			char(1),
	SUPPLIERCODE			char(5),
	DELIVERYNO			varchar(12),
	ITEMCODE			varchar(12),
	MAKEDATE			char(10),
	CHARGENAME			varchar(10),
	STANDARDREVNO		char(2),
	SUPPLIERLOTQTY		int,
	KBCOUNT			int,
	SUPPLIERDELIVERYQTY		int,
	QCMETHOD			char(1),
	REMARK				varchar(150),
	KDACREMARK			varchar(150),
	JUDGEFLAG			char(1),
	GOODQTY			int,
	BADQTY				int,
	BADREASON			char(1),
	BADMEMO			varchar(100),
	INSPECTORCODE			varchar(6),
	CONFIRMCODE			varchar(6),
	CONFIRMFLAG			char(1),
	PRINTFLAG			char(1),
	QCDATE				char(10),
	QCTIME				char(8),
	QCLEADTIME			char(8),
	QCKBFLAG			char(1),
	SLNO				char(12),
	DELIVERYDATE			char(10),
	DELIVERYTIME			char(8),
	LastEmp				varchar(6),
	LastDate				datetime	)

select	@ls_yesterday = convert(char(10), getdate() - 1, 102)

-- 대구전장	

Insert	into	#tmp_tqqcresult
select	*
from	[ipisele_svr\ipis].ipis.dbo.tqqcresult
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_areacode			= AREACODE,
		@ls_divisioncode			= DIVISIONCODE,
		@ls_suppliercode		= SUPPLIERCODE,
		@ls_deliveryno			= DELIVERYNO,
		@ls_itemcode			= ITEMCODE,
		@ls_makedate			= MAKEDATE,
		@ls_chargename			= CHARGENAME,
		@ls_standardrevno		= STANDARDREVNO,
		@li_supplierlotqty			= SUPPLIERLOTQTY,
		@li_kbcount			= KBCOUNT,
		@li_supplierdeliveryqty		= SUPPLIERDELIVERYQTY,
		@ls_qcmethod			= QCMETHOD,
		@ls_remark			= REMARK,
		@ls_kdacremark			= KDACREMARK,
		@ls_judgeflag			= JUDGEFLAG,
		@li_goodqty			= GOODQTY,
		@li_badqty			= BADQTY,
		@ls_badreason			= BADREASON,
		@ls_badmemo			= BADMEMO,
		@ls_inspectorcode		= INSPECTORCODE,
		@ls_confirmcode			= CONFIRMCODE,
		@ls_confirmflag			= CONFIRMFLAG,
		@ls_printflag			= PRINTFLAG,
		@ls_qcdate			= QCDATE,
		@ls_qctime			= QCTIME,
		@ls_qcleadtime			= QCLEADTIME,
		@ls_qckbflag			= QCKBFLAG,
		@ls_slno			= SLNO,
		@ls_deliverydate			= DELIVERYDATE,
		@ls_deliverytime			= DELIVERYTIME,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tqqcresult
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tqqcresult
			where	AREACODE	= @ls_areacode
			and	DIVISIONCODE	= @ls_divisioncode
			and	SUPPLIERCODE	= @ls_suppliercode
			and	DELIVERYNO	= @ls_deliveryno	
			and	ITEMCODE	= @ls_itemcode	)

		insert into tqqcresult
			(AREACODE,		DIVISIONCODE,		SUPPLIERCODE,		DELIVERYNO,
			ITEMCODE,		MAKEDATE,		CHARGENAME,		STANDARDREVNO,
			SUPPLIERLOTQTY,	KBCOUNT,		SUPPLIERDELIVERYQTY,	QCMETHOD,
			REMARK,		KDACREMARK,		JUDGEFLAG,		GOODQTY,
			BADQTY,		BADREASON,		BADMEMO,		INSPECTORCODE,
			CONFIRMCODE,		CONFIRMFLAG,		PRINTFLAG,		QCDATE,
			QCTIME,			QCLEADTIME,		QCKBFLAG,		SLNO,
			DELIVERYDATE,		DELIVERYTIME,		LastEmp)
		values	(@ls_areacode,		@ls_divisioncode,	@ls_suppliercode,	@ls_deliveryno,
			@ls_itemcode,		@ls_makedate,		@ls_chargename,	@ls_standardrevno,	
			@li_supplierlotqty,		@li_kbcount,		@li_supplierdeliveryqty,	@ls_qcmethod,
			@ls_remark,		@ls_kdacremark,		@ls_judgeflag,		@li_goodqty,
			@li_badqty,		@ls_badreason,		@ls_badmemo,		@ls_inspectorcode,
			@ls_confirmcode,		@ls_confirmflag,		@ls_printflag,		@ls_qcdate,
			@ls_qctime,		@ls_qcleadtime,		@ls_qckbflag,		@ls_slno,
			@ls_deliverydate,		@ls_deliverytime,		@ls_lastemp)
	Else
		update	tqqcresult
		set	MAKEDATE		= @ls_makedate,
			CHARGENAME		= @ls_chargename,
			STANDARDREVNO	= @ls_standardrevno,
			SUPPLIERLOTQTY	= @li_supplierlotqty,
			KBCOUNT		= @li_kbcount,
			SUPPLIERDELIVERYQTY	= @li_supplierdeliveryqty,
			QCMETHOD		= @ls_qcmethod,
			REMARK			= @ls_remark,
			KDACREMARK		= @ls_kdacremark,
			JUDGEFLAG		= @ls_judgeflag,
			GOODQTY		= @li_goodqty,
			BADQTY			= @li_badqty,
			BADREASON		= @ls_badreason,
			BADMEMO		= @ls_badmemo,
			INSPECTORCODE		= @ls_inspectorcode,
			CONFIRMCODE		= @ls_confirmcode,
			CONFIRMFLAG		= @ls_confirmflag,
			PRINTFLAG		= @ls_printflag,
			QCDATE			= @ls_qcdate,
			QCTIME			= @ls_qctime,
			QCLEADTIME		= @ls_qcleadtime,
			QCKBFLAG		= @ls_qckbflag,
			SLNO			= @ls_slno,
			DELIVERYDATE		= @ls_deliverydate,
			DELIVERYTIME		= @ls_deliverytime
		where	AREACODE		= @ls_areacode
		and	DIVISIONCODE		= @ls_divisioncode
		and	SUPPLIERCODE		= @ls_suppliercode
		and	DELIVERYNO		= @ls_deliveryno
		and	ITEMCODE		= @ls_itemcode

	update	[ipisele_svr\ipis].ipis.dbo.tqqcresult
	set	lastemp 		= 'N'
	where	AREACODE	= @ls_areacode
	and	DIVISIONCODE	= @ls_divisioncode
	and	SUPPLIERCODE	= @ls_suppliercode
	and	DELIVERYNO	= @ls_deliveryno
	and	ITEMCODE	= @ls_itemcode
	and	LastEmp 	= 'Y'

End	-- while loop end

truncate table #tmp_tqqcresult


-- 대구기계

Insert	into	#tmp_tqqcresult
select	*
from	[ipismac_svr\ipis].ipis.dbo.tqqcresult
where	lastemp = 'Y'
	
Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_areacode			= AREACODE,
		@ls_divisioncode			= DIVISIONCODE,
		@ls_suppliercode		= SUPPLIERCODE,
		@ls_deliveryno			= DELIVERYNO,
		@ls_itemcode			= ITEMCODE,
		@ls_makedate			= MAKEDATE,
		@ls_chargename		= CHARGENAME,
		@ls_standardrevno		= STANDARDREVNO,
		@li_supplierlotqty			= SUPPLIERLOTQTY,
		@li_kbcount			= KBCOUNT,
		@li_supplierdeliveryqty		= SUPPLIERDELIVERYQTY,
		@ls_qcmethod			= QCMETHOD,
		@ls_remark			= REMARK,
		@ls_kdacremark			= KDACREMARK,
		@ls_judgeflag			= JUDGEFLAG,
		@li_goodqty			= GOODQTY,
		@li_badqty			= BADQTY,
		@ls_badreason			= BADREASON,
		@ls_badmemo			= BADMEMO,
		@ls_inspectorcode		= INSPECTORCODE,
		@ls_confirmcode			= CONFIRMCODE,
		@ls_confirmflag			= CONFIRMFLAG,
		@ls_printflag			= PRINTFLAG,
		@ls_qcdate			= QCDATE,
		@ls_qctime			= QCTIME,
		@ls_qcleadtime			= QCLEADTIME,
		@ls_qckbflag			= QCKBFLAG,
		@ls_slno			= SLNO,
		@ls_deliverydate			= DELIVERYDATE,
		@ls_deliverytime			= DELIVERYTIME,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tqqcresult
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tqqcresult
			where	AREACODE	= @ls_areacode
			and	DIVISIONCODE	= @ls_divisioncode
			and	SUPPLIERCODE	= @ls_suppliercode
			and	DELIVERYNO	= @ls_deliveryno	
			and	ITEMCODE	= @ls_itemcode	)

		insert into tqqcresult
			(AREACODE,		DIVISIONCODE,		SUPPLIERCODE,		DELIVERYNO,
			ITEMCODE,		MAKEDATE,		CHARGENAME,		STANDARDREVNO,
			SUPPLIERLOTQTY,	KBCOUNT,		SUPPLIERDELIVERYQTY,	QCMETHOD,
			REMARK,		KDACREMARK,		JUDGEFLAG,		GOODQTY,
			BADQTY,		BADREASON,		BADMEMO,		INSPECTORCODE,
			CONFIRMCODE,		CONFIRMFLAG,		PRINTFLAG,		QCDATE,
			QCTIME,			QCLEADTIME,		QCKBFLAG,		SLNO,
			DELIVERYDATE,		DELIVERYTIME,		LastEmp)
		values	(@ls_areacode,		@ls_divisioncode,	@ls_suppliercode,	@ls_deliveryno,
			@ls_itemcode,		@ls_makedate,		@ls_chargename,	@ls_standardrevno,	
			@li_supplierlotqty,		@li_kbcount,		@li_supplierdeliveryqty,	@ls_qcmethod,
			@ls_remark,		@ls_kdacremark,		@ls_judgeflag,		@li_goodqty,
			@li_badqty,		@ls_badreason,		@ls_badmemo,		@ls_inspectorcode,
			@ls_confirmcode,		@ls_confirmflag,		@ls_printflag,		@ls_qcdate,
			@ls_qctime,		@ls_qcleadtime,		@ls_qckbflag,		@ls_slno,
			@ls_deliverydate,		@ls_deliverytime,		@ls_lastemp)
	Else
		update	tqqcresult
		set	MAKEDATE		= @ls_makedate,
			CHARGENAME		= @ls_chargename,
			STANDARDREVNO	= @ls_standardrevno,
			SUPPLIERLOTQTY	= @li_supplierlotqty,
			KBCOUNT		= @li_kbcount,
			SUPPLIERDELIVERYQTY	= @li_supplierdeliveryqty,
			QCMETHOD		= @ls_qcmethod,
			REMARK			= @ls_remark,
			KDACREMARK		= @ls_kdacremark,
			JUDGEFLAG		= @ls_judgeflag,
			GOODQTY		= @li_goodqty,
			BADQTY			= @li_badqty,
			BADREASON		= @ls_badreason,
			BADMEMO		= @ls_badmemo,
			INSPECTORCODE		= @ls_inspectorcode,
			CONFIRMCODE		= @ls_confirmcode,
			CONFIRMFLAG		= @ls_confirmflag,
			PRINTFLAG		= @ls_printflag,
			QCDATE			= @ls_qcdate,
			QCTIME			= @ls_qctime,
			QCLEADTIME		= @ls_qcleadtime,
			QCKBFLAG		= @ls_qckbflag,
			SLNO			= @ls_slno,
			DELIVERYDATE		= @ls_deliverydate,
			DELIVERYTIME		= @ls_deliverytime
		where	AREACODE		= @ls_areacode
		and	DIVISIONCODE		= @ls_divisioncode
		and	SUPPLIERCODE		= @ls_suppliercode
		and	DELIVERYNO		= @ls_deliveryno
		and	ITEMCODE		= @ls_itemcode

		
	update	[ipismac_svr\ipis].ipis.dbo.tqqcresult
	set	lastemp 		= 'N'
	where	AREACODE	= @ls_areacode
	and	DIVISIONCODE	= @ls_divisioncode
	and	SUPPLIERCODE	= @ls_suppliercode
	and	DELIVERYNO	= @ls_deliveryno
	and	ITEMCODE	= @ls_itemcode
	and	LastEmp 	= 'Y'

End	-- while loop end

truncate table #tmp_tqqcresult


-- 대구압축

Insert	into	#tmp_tqqcresult
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tqqcresult
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_areacode			= AREACODE,
		@ls_divisioncode			= DIVISIONCODE,
		@ls_suppliercode		= SUPPLIERCODE,
		@ls_deliveryno			= DELIVERYNO,
		@ls_itemcode			= ITEMCODE,
		@ls_makedate			= MAKEDATE,
		@ls_chargename		= CHARGENAME,
		@ls_standardrevno		= STANDARDREVNO,
		@li_supplierlotqty			= SUPPLIERLOTQTY,
		@li_kbcount			= KBCOUNT,
		@li_supplierdeliveryqty		= SUPPLIERDELIVERYQTY,
		@ls_qcmethod			= QCMETHOD,
		@ls_remark			= REMARK,
		@ls_kdacremark			= KDACREMARK,
		@ls_judgeflag			= JUDGEFLAG,
		@li_goodqty			= GOODQTY,
		@li_badqty			= BADQTY,
		@ls_badreason			= BADREASON,
		@ls_badmemo			= BADMEMO,
		@ls_inspectorcode		= INSPECTORCODE,
		@ls_confirmcode			= CONFIRMCODE,
		@ls_confirmflag			= CONFIRMFLAG,
		@ls_printflag			= PRINTFLAG,
		@ls_qcdate			= QCDATE,
		@ls_qctime			= QCTIME,
		@ls_qcleadtime			= QCLEADTIME,
		@ls_qckbflag			= QCKBFLAG,
		@ls_slno			= SLNO,
		@ls_deliverydate			= DELIVERYDATE,
		@ls_deliverytime			= DELIVERYTIME,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tqqcresult
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tqqcresult
			where	AREACODE	= @ls_areacode
			and	DIVISIONCODE	= @ls_divisioncode
			and	SUPPLIERCODE	= @ls_suppliercode
			and	DELIVERYNO	= @ls_deliveryno	
			and	ITEMCODE	= @ls_itemcode	)

		insert into tqqcresult
			(AREACODE,		DIVISIONCODE,		SUPPLIERCODE,		DELIVERYNO,
			ITEMCODE,		MAKEDATE,		CHARGENAME,		STANDARDREVNO,
			SUPPLIERLOTQTY,	KBCOUNT,		SUPPLIERDELIVERYQTY,	QCMETHOD,
			REMARK,		KDACREMARK,		JUDGEFLAG,		GOODQTY,
			BADQTY,		BADREASON,		BADMEMO,		INSPECTORCODE,
			CONFIRMCODE,		CONFIRMFLAG,		PRINTFLAG,		QCDATE,
			QCTIME,			QCLEADTIME,		QCKBFLAG,		SLNO,
			DELIVERYDATE,		DELIVERYTIME,		LastEmp)
		values	(@ls_areacode,		@ls_divisioncode,	@ls_suppliercode,	@ls_deliveryno,
			@ls_itemcode,		@ls_makedate,		@ls_chargename,	@ls_standardrevno,	
			@li_supplierlotqty,		@li_kbcount,		@li_supplierdeliveryqty,	@ls_qcmethod,
			@ls_remark,		@ls_kdacremark,		@ls_judgeflag,		@li_goodqty,
			@li_badqty,		@ls_badreason,		@ls_badmemo,		@ls_inspectorcode,
			@ls_confirmcode,		@ls_confirmflag,		@ls_printflag,		@ls_qcdate,
			@ls_qctime,		@ls_qcleadtime,		@ls_qckbflag,		@ls_slno,
			@ls_deliverydate,		@ls_deliverytime,		@ls_lastemp)
	Else
		update	tqqcresult
		set	MAKEDATE		= @ls_makedate,
			CHARGENAME		= @ls_chargename,
			STANDARDREVNO	= @ls_standardrevno,
			SUPPLIERLOTQTY	= @li_supplierlotqty,
			KBCOUNT		= @li_kbcount,
			SUPPLIERDELIVERYQTY	= @li_supplierdeliveryqty,
			QCMETHOD		= @ls_qcmethod,
			REMARK			= @ls_remark,
			KDACREMARK		= @ls_kdacremark,
			JUDGEFLAG		= @ls_judgeflag,
			GOODQTY		= @li_goodqty,
			BADQTY			= @li_badqty,
			BADREASON		= @ls_badreason,
			BADMEMO		= @ls_badmemo,
			INSPECTORCODE		= @ls_inspectorcode,
			CONFIRMCODE		= @ls_confirmcode,
			CONFIRMFLAG		= @ls_confirmflag,
			PRINTFLAG		= @ls_printflag,
			QCDATE			= @ls_qcdate,
			QCTIME			= @ls_qctime,
			QCLEADTIME		= @ls_qcleadtime,
			QCKBFLAG		= @ls_qckbflag,
			SLNO			= @ls_slno,
			DELIVERYDATE		= @ls_deliverydate,
			DELIVERYTIME		= @ls_deliverytime
		where	AREACODE		= @ls_areacode
		and	DIVISIONCODE		= @ls_divisioncode
		and	SUPPLIERCODE		= @ls_suppliercode
		and	DELIVERYNO		= @ls_deliveryno
		and	ITEMCODE		= @ls_itemcode

	update	[ipishvac_svr\ipis].ipis.dbo.tqqcresult
	set	lastemp 		= 'N'
	where	AREACODE	= @ls_areacode
	and	DIVISIONCODE	= @ls_divisioncode
	and	SUPPLIERCODE	= @ls_suppliercode
	and	DELIVERYNO	= @ls_deliveryno
	and	ITEMCODE	= @ls_itemcode
	and	LastEmp 	= 'Y'

End	-- while loop end

truncate table #tmp_tqqcresult


-- 진천

Insert	into	#tmp_tqqcresult
select	*
from	[ipisjin_svr].ipis.dbo.tqqcresult
where	lastemp = 'Y'

Select	@i = 0, @li_loop_count = @@RowCount, @lI_id = 0
	
While @i < @li_loop_count
Begin
	-- id chk
	Select	Top 1
		@i				= @i + 1,
		@ls_areacode			= AREACODE,
		@ls_divisioncode			= DIVISIONCODE,
		@ls_suppliercode		= SUPPLIERCODE,
		@ls_deliveryno			= DELIVERYNO,
		@ls_itemcode			= ITEMCODE,
		@ls_makedate			= MAKEDATE,
		@ls_chargename		= CHARGENAME,
		@ls_standardrevno		= STANDARDREVNO,
		@li_supplierlotqty			= SUPPLIERLOTQTY,
		@li_kbcount			= KBCOUNT,
		@li_supplierdeliveryqty		= SUPPLIERDELIVERYQTY,
		@ls_qcmethod			= QCMETHOD,
		@ls_remark			= REMARK,
		@ls_kdacremark			= KDACREMARK,
		@ls_judgeflag			= JUDGEFLAG,
		@li_goodqty			= GOODQTY,
		@li_badqty			= BADQTY,
		@ls_badreason			= BADREASON,
		@ls_badmemo			= BADMEMO,
		@ls_inspectorcode		= INSPECTORCODE,
		@ls_confirmcode			= CONFIRMCODE,
		@ls_confirmflag			= CONFIRMFLAG,
		@ls_printflag			= PRINTFLAG,
		@ls_qcdate			= QCDATE,
		@ls_qctime			= QCTIME,
		@ls_qcleadtime			= QCLEADTIME,
		@ls_qckbflag			= QCKBFLAG,
		@ls_slno			= SLNO,
		@ls_deliverydate			= DELIVERYDATE,
		@ls_deliverytime			= DELIVERYTIME,
		@ls_lastemp			= LastEmp,
		@lI_id				= checkid
	From	#tmp_tqqcresult
	Where	checkid > @lI_id

	-- key chk
	If not exists (	select * from tqqcresult
			where	AREACODE	= @ls_areacode
			and	DIVISIONCODE	= @ls_divisioncode
			and	SUPPLIERCODE	= @ls_suppliercode
			and	DELIVERYNO	= @ls_deliveryno	
			and	ITEMCODE	= @ls_itemcode	)

		insert into tqqcresult
			(AREACODE,		DIVISIONCODE,		SUPPLIERCODE,		DELIVERYNO,
			ITEMCODE,		MAKEDATE,		CHARGENAME,		STANDARDREVNO,
			SUPPLIERLOTQTY,	KBCOUNT,		SUPPLIERDELIVERYQTY,	QCMETHOD,
			REMARK,		KDACREMARK,		JUDGEFLAG,		GOODQTY,
			BADQTY,		BADREASON,		BADMEMO,		INSPECTORCODE,
			CONFIRMCODE,		CONFIRMFLAG,		PRINTFLAG,		QCDATE,
			QCTIME,			QCLEADTIME,		QCKBFLAG,		SLNO,
			DELIVERYDATE,		DELIVERYTIME,		LastEmp)
		values	(@ls_areacode,		@ls_divisioncode,	@ls_suppliercode,	@ls_deliveryno,
			@ls_itemcode,		@ls_makedate,		@ls_chargename,	@ls_standardrevno,	
			@li_supplierlotqty,		@li_kbcount,		@li_supplierdeliveryqty,	@ls_qcmethod,
			@ls_remark,		@ls_kdacremark,		@ls_judgeflag,		@li_goodqty,
			@li_badqty,		@ls_badreason,		@ls_badmemo,		@ls_inspectorcode,
			@ls_confirmcode,		@ls_confirmflag,		@ls_printflag,		@ls_qcdate,
			@ls_qctime,		@ls_qcleadtime,		@ls_qckbflag,		@ls_slno,
			@ls_deliverydate,		@ls_deliverytime,		@ls_lastemp)
	Else
		update	tqqcresult
		set	MAKEDATE		= @ls_makedate,
			CHARGENAME		= @ls_chargename,
			STANDARDREVNO		= @ls_standardrevno,
			SUPPLIERLOTQTY		= @li_supplierlotqty,
			KBCOUNT			= @li_kbcount,
			SUPPLIERDELIVERYQTY	= @li_supplierdeliveryqty,
			QCMETHOD		= @ls_qcmethod,
			REMARK			= @ls_remark,
			KDACREMARK		= @ls_kdacremark,
			JUDGEFLAG		= @ls_judgeflag,
			GOODQTY			= @li_goodqty,
			BADQTY			= @li_badqty,
			BADREASON		= @ls_badreason,
			BADMEMO			= @ls_badmemo,
			INSPECTORCODE		= @ls_inspectorcode,
			CONFIRMCODE		= @ls_confirmcode,
			CONFIRMFLAG		= @ls_confirmflag,
			PRINTFLAG		= @ls_printflag,
			QCDATE			= @ls_qcdate,
			QCTIME			= @ls_qctime,
			QCLEADTIME		= @ls_qcleadtime,
			QCKBFLAG		= @ls_qckbflag,
			SLNO			= @ls_slno,
			DELIVERYDATE		= @ls_deliverydate,
			DELIVERYTIME		= @ls_deliverytime
		where	AREACODE		= @ls_areacode
		and	DIVISIONCODE		= @ls_divisioncode
		and	SUPPLIERCODE		= @ls_suppliercode
		and	DELIVERYNO		= @ls_deliveryno
		and	ITEMCODE		= @ls_itemcode
		
	update	[ipisjin_svr].ipis.dbo.tqqcresult
	set	lastemp 	= 'N'
	where	AREACODE	= @ls_areacode
	and	DIVISIONCODE	= @ls_divisioncode
	and	SUPPLIERCODE	= @ls_suppliercode
	and	DELIVERYNO	= @ls_deliveryno
	and	ITEMCODE	= @ls_itemcode
	and	LastEmp 	= 'Y'

End	-- while loop end

drop table #tmp_tqqcresult
 
End		-- Procedure End
Go
