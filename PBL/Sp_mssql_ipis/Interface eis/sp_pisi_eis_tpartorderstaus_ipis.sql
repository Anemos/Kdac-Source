/*
	File Name	: sp_pisi_eis_tpartorderstaus_ipis.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tpartorderstaus_ipis
	Description	: EIS Upload tpartorderstaus(IPISELE Server)
			  tpartorderstaus
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

use IPIS

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tpartorderstaus_ipis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tpartorderstaus_ipis]
GO

/*
Execute sp_pisi_eis_tpartorderstaus_ipis
*/

Create Procedure sp_pisi_eis_tpartorderstaus_ipis
	
As
Begin

-- 각 서버에서 통째로 날리고 insert 한다
select	*
into	#tmp_tpartorderstaus
from	tpartorderstaus
where	lastemp = 'Y'

delete	from [ipisele_svr\ipis].eis.dbo.tpartorderstaus
where	ApplyDate+AreaCode+DivisionCode+SupplierCode+ItemCode in 
	(select	ApplyDate+AreaCode+DivisionCode+SupplierCode+ItemCode
	from	#tmp_tpartorderstaus)

insert into [ipisele_svr\ipis].eis.dbo.tpartorderstaus
select * from #tmp_tpartorderstaus

update	tpartorderstaus
set	lastemp = 'N'
from	tpartorderstaus, #tmp_tpartorderstaus
where	tpartorderstaus.applydate = #tmp_tpartorderstaus.applydate
and	tpartorderstaus.areacode = #tmp_tpartorderstaus.areacode
and	tpartorderstaus.divisioncode = #tmp_tpartorderstaus.divisioncode
and	tpartorderstaus.suppliercode = #tmp_tpartorderstaus.suppliercode
and	tpartorderstaus.itemcode = #tmp_tpartorderstaus.itemcode

Drop table #tmp_tpartorderstaus

End		-- Procedure End
Go
