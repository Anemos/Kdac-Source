/*
	File Name	: sp_pisi_d_invmaster_fix.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_invmaster_fix
	Description	: invmaster down error시 수정
			  cmms.dbo.invmaster
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_invmaster_fix]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_invmaster_fix]
GO

/*
Execute sp_pisi_d_invmaster_fix
*/

Create Procedure sp_pisi_d_invmaster_fix
	
	
As
Begin

-- 어떤 이유에선지 interface DB의 invmaster data가 cmms DB의 invmaster로 넘어간 후
-- 에러가 발생해서 각 DB로 넘어가지 않는다. 
-- 해서 cmms의 invmaster data를 날려서 job을 다시 수행하게 만든다.  
-- job : job_down_part_master (ipisele_svr server)
 
delete	from cmms..invmaster
where	logid in (select logid from invmaster
		where	stscd = 'N')

End		-- Procedure End
Go
