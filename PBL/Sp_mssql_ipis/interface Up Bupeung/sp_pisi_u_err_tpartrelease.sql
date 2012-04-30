/*
	File Name	: sp_pisi_u_err_tpartrelease.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_err_tpartrelease
	Description	: 여주자재 불출정보 Error Data 
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: INTERFACE
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.06.15
	Author		: kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_err_tpartrelease]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_err_tpartrelease]
GO

/*
Execute sp_pisi_u_err_tpartrelease
*/

Create Procedure sp_pisi_u_err_tpartrelease
	
As
Begin

-- 여주전자 자재불출
select logid = aa.logid,
  errortext = bb.errortext,
  errordate = bb.errordate,
  itemcode = aa.itemcode,
  usedept = aa.usedept,
  usage = aa.usage,
  releasedate = aa.releasedate,
  invstatus = aa.invstatus,
  releaseqty = aa.releaseqty,
  projectno = aa.projectno,
  suppliercode = aa.suppliercode,
  tidno = aa.tidno
from tpartrelease_interface aa inner join errorlog bb
  on bb.userid = 126 and aa.logid = bb.errorcode
where aa.interfaceflag = 'Y'


Return

End		-- Procedure End
Go
