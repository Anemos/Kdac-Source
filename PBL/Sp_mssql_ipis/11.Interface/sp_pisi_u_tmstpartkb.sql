/*
	File Name	: sp_pisi_u_tmstpartkb.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_tmstpartkb
	Description	: Upload tmstpartkb(���簣�� update) 
			  tmstpartkb
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tmstpartkb]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tmstpartkb]
GO

/*
Execute sp_pisi_u_tmstpartkb
*/

Create Procedure sp_pisi_u_tmstpartkb

	
As
Begin

------------- ���� �߻��� ó��


-- �뱸����
insert into tmstpartkb
select	*
from	[ipisele_svr\ipis].ipis.dbo.tmstpartkb

-- �뱸���
insert into tmstpartkb
select	*
from	[ipismac_svr\ipis].ipis.dbo.tmstpartkb

-- �뱸����
insert into tmstpartkb
select	*
from	[ipishvac_svr\ipis].ipis.dbo.tmstpartkb

-- ��õ
insert into tmstpartkb
select	*
from	[ipisjin_svr].ipis.dbo.tmstpartkb

End		-- Procedure End
Go
