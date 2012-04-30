/*
	File Name	: sp_pisi_u_err_tpartreturn.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_err_tpartreturn
	Description	: �������� �ݳ����� Error Data 
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: INTERFACE
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.06.15
	Author		: kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_err_tpartreturn]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_err_tpartreturn]
GO

/*
Execute sp_pisi_u_err_tpartreturn
*/

Create Procedure sp_pisi_u_err_tpartreturn
	
As
Begin

-- �������� ����ݳ�
select logid = aa.logid,
  errortext = bb.errortext,
  errordate = bb.errordate,
  itemcode = aa.itemcode,
  rtndept = aa.rtndept,
  rtnusage = aa.rtnusage,
  rtngubun = aa.rtngubun,
  rtndate = aa.rtndate,
  uqty = aa.uqty,
  rqty = aa.rqty,
  sqty = aa.sqty,
  suppliercode = aa.suppliercode,
  tidno = aa.tidno
from tpartreturn_interface aa inner join errorlog bb
  on bb.userid = 127 and aa.logid = bb.errorcode
where aa.interfaceflag = 'Y'


Return

End		-- Procedure End
Go
