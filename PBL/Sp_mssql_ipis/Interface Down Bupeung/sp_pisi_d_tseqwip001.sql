/*
	File Name	: sp_pisi_d_tseqwip001.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_tseqwip001
	Description	: Download wip001
			  tseqwip001 - 오전 07시 ~ 08시에 한번 수행
			  부평물류 서버추가 : 2005.10
			  군산물류 서버추가 : 2005.10
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2006.02.20
	Author		: Gary Kim
	Remark		: 
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_tseqwip001]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_tseqwip001]
GO

/*
Execute sp_pisi_d_tseqwip001
*/

Create Procedure sp_pisi_d_tseqwip001
	
	
As
Begin


If Exists (select * From pdwip001)
	Begin

	-- 부평물류
	exec [ipisbup_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tseqwip001'
	
	insert into [ipisbup_svr\ipis].ipis.dbo.tseqwip001( [AreaCode], [DivisionCode], 
    [ItemCode], [BeginQty], [InQty])
	select waplant, wadvsn, waitno, cast( (wabgqt / case convqty when 0 then 1 else convqty end) as integer ), 
	  cast( (wainqt / case convqty when 0 then 1 else convqty end) as integer )
	from pdwip001
	where waplant = 'B'
	
	-- 군산물류
	exec [ipiskun_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tseqwip001'
	
	insert into [ipiskun_svr\ipis].ipis.dbo.tseqwip001( [AreaCode], [DivisionCode], 
    [ItemCode], [BeginQty], [InQty])
	select waplant, wadvsn, waitno, cast( (wabgqt / case convqty when 0 then 1 else convqty end) as integer ), 
	  cast( (wainqt / case convqty when 0 then 1 else convqty end) as integer )
	from pdwip001
	where waplant = 'K'

	Truncate Table	tmisdept
End



End		-- Procedure End
GO
