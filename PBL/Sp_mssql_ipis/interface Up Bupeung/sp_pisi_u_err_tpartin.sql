/*
	File Name	: sp_pisi_u_err_tpartin.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_err_tpartin
	Description	: 여주자재 입고정보 Error Data 
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: INTERFACE
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.06.15
	Author		: kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_err_tpartin]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_err_tpartin]
GO

/*
Execute sp_pisi_u_err_tpartin
*/

Create Procedure sp_pisi_u_err_tpartin
	
As
Begin

-- 여주전자 자재입고
select logid = aa.logid,
  errortext = bb.errortext,
  errordate = bb.errordate,
  slno = aa.slno,
  incomedate = aa.incomedate,
  itemcode = aa.itemcode,
  itemsource = aa.itemsource,
  tidno = aa.tidno
from tpartin_interface aa inner join errorlog bb
  on bb.userid = 125 and aa.logid = bb.errorcode
where aa.interfaceflag = 'Y'


Return

End		-- Procedure End
Go
