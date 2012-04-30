/*
	File Name	: sp_pisi_d_tmstproject.SQL
	SYSTEM		: KDAC ���� ���� ���� �ý���
	Procedure Name	: sp_pisi_d_tmstproject
	Description	: Download Project Master
			  tmstproject - �ϰ����� ����
			  �������� �����߰� : 2004.04.19
			  ���򹰷� �����߰� : 2005.10
			  ���깰�� �����߰� : 2005.10
			  
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
	Remark		: ���常 interface�� �������� ����������� update
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstproject]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstproject]
GO

/*
Execute sp_pisi_d_tmstproject
*/

Create Procedure sp_pisi_d_tmstproject
	
	
As
Begin

If Exists (select * From pjt101)
	Begin
		--�뱸����
		exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproject'

		insert into [ipisele_svr\ipis].ipis.dbo.tmstproject
			(ProjectNo,	ProjectName,	
			FromDate,	
			ToDate,
			ComDate,	
			StCd,		LastEmp)
		select	pjno,		pjnm,		
			substring(frdt,1,4)+'.'+substring(frdt,5,2)+'.'+substring(frdt,7,2),	
			substring(etodt,1,4)+'.'+substring(etodt,5,2)+'.'+substring(etodt,7,2),	
			substring(comdt,1,4)+'.'+substring(comdt,5,2)+'.'+substring(comdt,7,2),	
			stcd,		'SYSTEM'
		from	pjt101

		--�뱸����
		exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproject'

		insert into [ipismac_svr\ipis].ipis.dbo.tmstproject
			(ProjectNo,	ProjectName,	
			FromDate,	
			ToDate,
			ComDate,	
			StCd,		LastEmp)
		select	pjno,		pjnm,		
			substring(frdt,1,4)+'.'+substring(frdt,5,2)+'.'+substring(frdt,7,2),	
			substring(etodt,1,4)+'.'+substring(etodt,5,2)+'.'+substring(etodt,7,2),	
			substring(comdt,1,4)+'.'+substring(comdt,5,2)+'.'+substring(comdt,7,2),	
			stcd,		'SYSTEM'
		from	pjt101
		
		-- �뱸����
		exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproject'

		insert into [ipishvac_svr\ipis].ipis.dbo.tmstproject
			(ProjectNo,	ProjectName,	
			FromDate,	
			ToDate,
			ComDate,	
			StCd,		LastEmp)
		select	pjno,		pjnm,		
			substring(frdt,1,4)+'.'+substring(frdt,5,2)+'.'+substring(frdt,7,2),	
			substring(etodt,1,4)+'.'+substring(etodt,5,2)+'.'+substring(etodt,7,2),	
			substring(comdt,1,4)+'.'+substring(comdt,5,2)+'.'+substring(comdt,7,2),	
			stcd,		'SYSTEM'
		from	pjt101
		
		-- ���򹰷�
		exec [ipisbup_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproject'

		insert into [ipisbup_svr\ipis].ipis.dbo.tmstproject
			(ProjectNo,	ProjectName,	
			FromDate,	
			ToDate,
			ComDate,	
			StCd,		LastEmp)
		select	pjno,		pjnm,		
			substring(frdt,1,4)+'.'+substring(frdt,5,2)+'.'+substring(frdt,7,2),	
			substring(etodt,1,4)+'.'+substring(etodt,5,2)+'.'+substring(etodt,7,2),	
			substring(comdt,1,4)+'.'+substring(comdt,5,2)+'.'+substring(comdt,7,2),	
			stcd,		'SYSTEM'
		from	pjt101
		
		-- ���깰��
		exec [ipiskun_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproject'

		insert into [ipiskun_svr\ipis].ipis.dbo.tmstproject
			(ProjectNo,	ProjectName,	
			FromDate,	
			ToDate,
			ComDate,	
			StCd,		LastEmp)
		select	pjno,		pjnm,		
			substring(frdt,1,4)+'.'+substring(frdt,5,2)+'.'+substring(frdt,7,2),	
			substring(etodt,1,4)+'.'+substring(etodt,5,2)+'.'+substring(etodt,7,2),	
			substring(comdt,1,4)+'.'+substring(comdt,5,2)+'.'+substring(comdt,7,2),	
			stcd,		'SYSTEM'
		from	pjt101
		
		-- ��������
		exec [ipisyeo_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstproject'

		insert into [ipisyeo_svr\ipis].ipis.dbo.tmstproject
			(ProjectNo,	ProjectName,	
			FromDate,	
			ToDate,
			ComDate,	
			StCd,		LastEmp)
		select	pjno,		pjnm,		
			substring(frdt,1,4)+'.'+substring(frdt,5,2)+'.'+substring(frdt,7,2),	
			substring(etodt,1,4)+'.'+substring(etodt,5,2)+'.'+substring(etodt,7,2),	
			substring(comdt,1,4)+'.'+substring(comdt,5,2)+'.'+substring(comdt,7,2),	
			stcd,		'SYSTEM'
		from	pjt101
		
		--��õ
		
		exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstproject'

		insert into [ipisjin_svr].ipis.dbo.tmstproject
			(ProjectNo,	ProjectName,	
			FromDate,	
			ToDate,
			ComDate,	
			StCd,		LastEmp)
		select	pjno,		pjnm,		
			substring(frdt,1,4)+'.'+substring(frdt,5,2)+'.'+substring(frdt,7,2),	
			substring(etodt,1,4)+'.'+substring(etodt,5,2)+'.'+substring(etodt,7,2),	
			substring(comdt,1,4)+'.'+substring(comdt,5,2)+'.'+substring(comdt,7,2),	
			stcd,		'SYSTEM'
		from	pjt101
		
		
		Truncate Table	pjt101
	End


End		-- Procedure End
Go
