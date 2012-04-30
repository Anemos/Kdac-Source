/*
	File Name	: sp_pisi_u_err_tpartcancel.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_u_err_tpartcancel
	Description	: �������� �԰�������� Error Data 
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: INTERFACE
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.06.15
	Author		: kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_err_tpartcancel]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_err_tpartcancel]
GO

/*
Execute sp_pisi_u_err_tpartcancel
*/

Create Procedure sp_pisi_u_err_tpartcancel
	
As
Begin

-- �������� �����԰����
select logid = aa.logid,
  errortext = bb.errortext,
  errordate = bb.errordate,
  itemcode = aa.itemcode,
  itemsource = aa.itemsource,
  canceldate = aa.canceldate,
  invstatus = aa.invstatus,
  suppliercode = aa.suppliercode,
  blno = aa.blno,
  cancelqty = aa.cancelqty,
  cancelamt = aa.cancelamt,
  tidno = aa.tidno
from tpartcancel_interface aa inner join errorlog bb
  on bb.userid = 128 and aa.logid = bb.errorcode
where aa.interfaceflag = 'Y'


Return

End		-- Procedure End
Go
