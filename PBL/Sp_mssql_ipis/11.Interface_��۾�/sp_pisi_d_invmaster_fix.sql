/*
	File Name	: sp_pisi_d_invmaster_fix.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_invmaster_fix
	Description	: invmaster down error�� ����
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

-- � ���������� interface DB�� invmaster data�� cmms DB�� invmaster�� �Ѿ ��
-- ������ �߻��ؼ� �� DB�� �Ѿ�� �ʴ´�. 
-- �ؼ� cmms�� invmaster data�� ������ job�� �ٽ� �����ϰ� �����.  
-- job : job_down_part_master (ipisele_svr server)
 
delete	from cmms..invmaster
where	logid in (select logid from invmaster
		where	stscd = 'N')

End		-- Procedure End
Go
