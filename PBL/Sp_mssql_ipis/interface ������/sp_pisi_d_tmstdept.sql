/*
	File Name	: sp_pisi_d_tmstdept.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tmstdept
	Description	: Download 부서 master
			  tmstdept - 일간단위 갱신
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
	    Where id = object_id(N'[dbo].[sp_pisi_d_tmstdept]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tmstdept]
GO

/*
Execute sp_pisi_d_tmstdept
*/

Create Procedure sp_pisi_d_tmstdept
	
	
As
Begin


If Exists (select * From tmisdept)
	Begin

		
	-- 대구 전장
	exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstdept'
	
	insert into [ipisele_svr\ipis].ipis.dbo.tmstdept
		(DeptCode,	DeptName,	
		ApplyFrom,	
		ApplyTo,		
		DeptGubun,
		AreaCode,	DivisionCode,	
		DirectGubun,	
		DeptName1,		DeptName2,		DeptName3,	
		DeptName4,		deptshortname4,		DeptEmpNo,	DeptEmpName,	LastEmp)
	select	dcode,		ltrim(rtrim(dname)),
		substring(convert(char(8), dfromdt), 1, 4)+'.'+substring(convert(char(8), dfromdt), 5, 2)+'.'+substring(convert(char(8), dfromdt), 7,2),
		case dtodt
		when '0' then '9999.99.99'
		else substring(convert(char(8), dtodt), 1, 4)+'.'+substring(convert(char(8), dtodt), 5, 2)+'.'+substring(convert(char(8), dtodt), 7,2)
		end,
		'M',
		case ddiv5
			when 'A' then 'D'
			when 'E' then 'D'
			when 'H' then 'D'
			when 'J' then 'J'
			when 'K' then 'K'
			when 'M' then 'D'
			when 'S' then 'D'
			when 'V' then 'D'
			when 'Y' then 'Y'
			when 'Z' then 'Y'		
			else ddiv5
			end,
		case ddiv5
			when 'E' then 'A'
			when 'J' then 
				Case	ddiv2
					When	'B'	Then	'M'
					When	'L'	Then	'S'
					When	'T'	Then	'H'
					Else			'X'
				End
			when 'K' then 'X'
			when 'Z' then 'Y'
			else ddiv5
			end,
		case dsys14
			when 'X' then 'I'
			else 'D'
			end,
		ltrim(rtrim(dfname1)),	ltrim(rtrim(dfname2)),	ltrim(rtrim(dfname3)),	
		ltrim(rtrim(dfname4)),	ltrim(rtrim(daccode)),	dempno,		dempname,	'SYSTEM'
	from	tmisdept
	where	dacttodt = '0' 
	and	dtodt = '0'  
	and	dsys1 = 'X'
	and	ddiv5 <> 'X'
	and	ddiv5 <> ''
	order by dcode
	
	insert into [ipisele_svr\ipis].ipis.dbo.tmstdept
		(DeptCode,	DeptName,	
		ApplyFrom,	
		ApplyTo,		
		DeptGubun,
		AreaCode,	DivisionCode,	
		DirectGubun,	
		DeptName1,		DeptName2,		DeptName3,	
		DeptName4,		deptshortname4,		DeptEmpNo,	DeptEmpName,	LastEmp)
	select	dcode,		ltrim(rtrim(dname)),
		substring(convert(char(8), dfromdt), 1, 4)+'.'+substring(convert(char(8), dfromdt), 5, 2)+'.'+substring(convert(char(8), dfromdt), 7,2),
		case dtodt
		when '0' then '9999.99.99'
		else substring(convert(char(8), dtodt), 1, 4)+'.'+substring(convert(char(8), dtodt), 5, 2)+'.'+substring(convert(char(8), dtodt), 7,2)
		end,
		'A',
		'X',	ddiv5,		
		case dsys14
		when 'X' then 'I'
		else 'D'
		end,
		ltrim(rtrim(dfname1)),	ltrim(rtrim(dfname2)),	ltrim(rtrim(dfname3)),	
		ltrim(rtrim(dfname4)),	ltrim(rtrim(daccode)),	dempno,		dempname,	'SYSTEM'
	from	tmisdept
	where	dacttodt = '0' 
	and	dtodt = '0'
	and	dsys1 = 'X'
	and	ddiv5 = 'X'
	order by dcode
	
	update	[ipisele_svr\ipis].ipis.dbo.tmstdept
	set	divisioncode = 'X'
	where	directgubun = 'I'
	and	deptcode like '%00'
	
	
	-- 대구 기계
	exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstdept'
	
	insert into [ipismac_svr\ipis].ipis.dbo.tmstdept
	select	*
	from	[ipisele_svr\ipis].ipis.dbo.tmstdept
	
	
	-- 대구 공조
	exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstdept'
	
	insert into [ipishvac_svr\ipis].ipis.dbo.tmstdept
	select	*
	from	[ipisele_svr\ipis].ipis.dbo.tmstdept
	
	
	-- 진천
	exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstdept'
	
	insert into [ipisjin_svr].ipis.dbo.tmstdept
	select	*
	from	[ipisele_svr\ipis].ipis.dbo.tmstdept
	
	
	-- EIS
	exec [ipisele_svr\ipis].eis.dbo.sp_pisi_truncate_table 'tmstdept'
	
	insert into [ipisele_svr\ipis].eis.dbo.tmstdept
	select	*
	from	[ipisele_svr\ipis].ipis.dbo.tmstdept

	-- 여주
	exec [ipisyeo_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstdept'
	
	insert into [ipisyeo_svr\ipis].ipis.dbo.tmstdept
	select	*
	from	[ipisele_svr\ipis].ipis.dbo.tmstdept

	Truncate Table	tmisdept
End



End		-- Procedure End
GO
