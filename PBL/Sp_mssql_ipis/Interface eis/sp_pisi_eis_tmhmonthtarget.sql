/*
	File Name	: sp_pisi_eis_tmhmonthtarget.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_eis_tmhmonthtarget
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
	    Where id = object_id(N'[dbo].[sp_pisi_eis_tmhmonthtarget]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_eis_tmhmonthtarget]
GO

/*
Execute sp_pisi_eis_tmhmonthtarget
*/

Create Procedure sp_pisi_eis_tmhmonthtarget
	
As
Begin

-- 각 서버에 있는 procedure를 실행한다
exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_eis_tmhmonthtarget_ipis

exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_eis_tmhmonthtarget_ipis

exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_eis_tmhmonthtarget_ipis

exec [ipisjin_svr].ipis.dbo.sp_pisi_eis_tmhmonthtarget_ipis
 
End		-- Procedure End
Go
