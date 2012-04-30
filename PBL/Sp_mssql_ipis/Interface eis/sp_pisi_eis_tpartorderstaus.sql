/*
	File Name	: sp_pisi_eis_tpartorderstaus.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tpartorderstaus
	Description	: EIS Upload tpartkbstatus
			  tpartkbstatus
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tpartorderstaus]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tpartorderstaus]
GO

/*
Execute sp_pisi_eis_tpartorderstaus
*/

Create Procedure sp_pisi_eis_tpartorderstaus
	
As
Begin

-- 각 서버에 있는 procedure를 실행한다
exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_eis_tpartorderstaus_ipis

exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_eis_tpartorderstaus_ipis

exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_eis_tpartorderstaus_ipis

exec [ipisjin_svr].ipis.dbo.sp_pisi_eis_tpartorderstaus_ipis

End		-- Procedure End
Go
