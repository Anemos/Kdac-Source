/*
	File Name	: sp_pisi_eis_tpartkbhis.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_eis_tpartkbhis
	Description	: EIS Upload tmhmonthtarget
			  tmhmonthtarget
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tpartkbhis]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tpartkbhis]
GO

/*
Execute sp_pisi_eis_tpartkbhis
*/

Create Procedure sp_pisi_eis_tpartkbhis
	
As
Begin

-- �� ������ �ִ� procedure�� �����Ѵ�
exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_eis_tpartkbhis_ipis

exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_eis_tpartkbhis_ipis

exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_eis_tpartkbhis_ipis

exec [ipisjin_svr].ipis.dbo.sp_pisi_eis_tpartkbhis_ipis
 
End		-- Procedure End
Go
