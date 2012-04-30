/*
	File Name	: sp_pisi_all_tpartkbstatus.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_all_tpartkbstatus
	Description	: 전공장 Upload tpartkbstatus
			  tpartkbstatus
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12  2007.11.26
	Author		: Gary Kim  kisskim
*/

use interface

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_all_tpartkbstatus]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_all_tpartkbstatus]
GO

/*
Execute sp_pisi_all_tpartkbstatus
*/

Create Procedure sp_pisi_all_tpartkbstatus
	
As
Begin

exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tpartkbstatus_all'
-- ele server
insert into [ipisele_svr\ipis].ipis.dbo.tpartkbstatus_all
select * from [ipisele_svr\ipis].ipis.dbo.tpartkbstatus
-- mac server
insert into [ipisele_svr\ipis].ipis.dbo.tpartkbstatus_all
select * from [ipismac_svr\ipis].ipis.dbo.tpartkbstatus
-- hvac server
insert into [ipisele_svr\ipis].ipis.dbo.tpartkbstatus_all
select * from [ipishvac_svr\ipis].ipis.dbo.tpartkbstatus
-- jin server
insert into [ipisele_svr\ipis].ipis.dbo.tpartkbstatus_all
select * from [ipisjin_svr].ipis.dbo.tpartkbstatus

End		-- Procedure End
Go
