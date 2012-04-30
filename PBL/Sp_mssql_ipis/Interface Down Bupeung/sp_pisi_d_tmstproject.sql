/*
	File Name	: sp_pisi_d_tmstproject.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstproject
	Description	: Download Project Master
			  tmstproject - 일간단위 갱신
			  여주전자 서버추가 : 2004.04.19
			  부평물류 서버추가 : 2005.10
			  군산물류 서버추가 : 2005.10
			  
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
	Remark		: 전장만 interface후 각공장은 복제기능으로 update
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
		--대구전장
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

		--대구제동
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
		
		-- 대구공조
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
		
		-- 부평물류
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
		
		-- 군산물류
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
		
		-- 여주전자
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
		
		--진천
		
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
