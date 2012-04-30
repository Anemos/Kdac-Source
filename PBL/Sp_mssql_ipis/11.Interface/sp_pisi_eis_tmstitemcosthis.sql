/*
	File Name	: sp_pisi_eis_tmstitemcosthis.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_eis_tmstitemcosthis
	Description	: EIS Upload tmstitemcosthis
			  tmstitemcosthis -- �ſ� 1�� ���� 8�� 1ȸ
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmstitemcosthis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmstitemcosthis]
GO

/*
Execute sp_pisi_eis_tmstitemcosthis
*/

Create Procedure sp_pisi_eis_tmstitemcosthis
	
As
Begin

Declare	@ls_today		char(10),
	@ls_month		char(7)


select	@ls_today = convert(char(10), getdate(), 102)
select	@ls_month = substring(@ls_today, 1, 7)

-- �ſ� 1�Ͽ��� �����Ѵ�...

If substring(@ls_today, 9, 2) = '01'
begin

-- �뱸����
insert into tmstitemcosthis
	(applymonth, areacode, divisioncode, itemcode, itemclass, itembuysource, itemunit, unitcost, lastemp)
select	@ls_month, areacode, divisioncode, itemcode, itemclass, itembuysource, itemunit, unitcost, lastemp
from	[ipisele_svr\ipis].ipis.dbo.tmstitemcost
order by areacode, divisioncode, itemcode

-- �뱸���
insert into tmstitemcosthis
	(applymonth, areacode, divisioncode, itemcode, itemclass, itembuysource, itemunit, unitcost, lastemp)
select	@ls_month, areacode, divisioncode, itemcode, itemclass, itembuysource, itemunit, unitcost, lastemp
from	[ipismac_svr\ipis].ipis.dbo.tmstitemcost
order by areacode, divisioncode, itemcode

-- �뱸����
insert into tmstitemcosthis
	(applymonth, areacode, divisioncode, itemcode, itemclass, itembuysource, itemunit, unitcost, lastemp)
select	@ls_month, areacode, divisioncode, itemcode, itemclass, itembuysource, itemunit, unitcost, lastemp
from	[ipishvac_svr\ipis].ipis.dbo.tmstitemcost
order by areacode, divisioncode, itemcode

-- ��õ
insert into tmstitemcosthis
	(applymonth, areacode, divisioncode, itemcode, itemclass, itembuysource, itemunit, unitcost, lastemp)
select	@ls_month, areacode, divisioncode, itemcode, itemclass, itembuysource, itemunit, unitcost, lastemp
from	[ipisjin_svr].ipis.dbo.tmstitemcost
order by areacode, divisioncode, itemcode

end
 
End		-- Procedure End
Go
