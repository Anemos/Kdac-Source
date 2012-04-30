/*
	File Name	: sp_piss_tmstshipgubun.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_piss_tsmstshipgubun
	Description	: 생산 현황
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 10. 14
	Author		: Kim Jin-Su
*/
If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_piss_tmstshipgubun]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_piss_tmstshipgubun]
GO


/*
Exec sp_piss_tmstshipgubun
*/

Create Procedure sp_piss_tmstshipgubun
	
As
Begin


Select  shipgubun		= A.shipgubun,
	shipgubunname		= A.shipgubunname
  From	tmstshipgubun	A

Return

End		-- Procedure End


GO
