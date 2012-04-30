/*
	File Name	: sp_pisi_d_tmstemp.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstemp
	Description	: Download Emp Master
			  tmstemp - 일간단위 갱신
			  여주전자 서버 추가 : 2004.04.19
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstemp]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstemp]
GO

/*
Execute sp_pisi_d_tmstemp
*/

Create Procedure sp_pisi_d_tmstemp
	
	
As
Begin

If Exists (Select * From tmisemp)
	Begin
		exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstemp'

		insert into [ipisele_svr\ipis].ipis.dbo.tmstemp
			(EmpNo,		EmpName,	DeptCode,	EmpGubun,	EmpJikchek, 
			RetireDate,	
			EmpClass,	EmpExtd,	
			RetireGubun,	
			EmpBonbu,
			EmpIntDept,	EmpLevel,	
			EmpEnterDate,	
			EmpClassDate,	
			EmpBirthDate, 
			LastEmp)
		select 	peempno,	penamek,	pedept,		pegubun,	pejikchek, 
			case peout 
				when '*' then substring(peoutdt, 1, 4)+'.'+substring(peoutdt, 5, 2)+'.'+substring(peoutdt, 7,2)
				else ''
				end,
			peclass,	extd,		
			case peout
				when '*' then 'Y'
				else 'N'
				end,
			pebonbu,
			peintdept,	pesc,		
			substring(peentdt, 1, 4)+'.'+substring(peentdt, 5, 2)+'.'+substring(peentdt, 7,2),
			substring(peclassdt, 1, 4)+'.'+substring(peclassdt, 5, 2)+'.'+substring(peclassdt, 7,2), 
			'', 'SYSTEM'
		from	tmisemp
		
		-- EIS
		exec [ipisele_svr\ipis].eis.dbo.sp_pisi_truncate_table 'tmstemp'
		
		insert into [ipisele_svr\ipis].eis.dbo.tmstemp
		select *
		from	[ipisele_svr\ipis].ipis.dbo.tmstemp
		
			
		-- 대구 기계
		exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstemp'
		
		insert into [ipismac_svr\ipis].ipis.dbo.tmstemp
		select *
		from	[ipisele_svr\ipis].ipis.dbo.tmstemp
		
		
		-- 대구 공조
		exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstemp'
		
		insert into [ipishvac_svr\ipis].ipis.dbo.tmstemp
		select *
		from	[ipisele_svr\ipis].ipis.dbo.tmstemp
		
		
		-- 진천
		exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstemp'
		
		insert into [ipisjin_svr].ipis.dbo.tmstemp
		select *
		from	[ipisele_svr\ipis].ipis.dbo.tmstemp

		-- 여주
		exec [ipisyeo_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstemp'
		
		insert into [ipisyeo_svr\ipis].ipis.dbo.tmstemp
		select *
		from	[ipisele_svr\ipis].ipis.dbo.tmstemp

		Truncate Table	Tmisemp
	End


End		-- Procedure End
GO
