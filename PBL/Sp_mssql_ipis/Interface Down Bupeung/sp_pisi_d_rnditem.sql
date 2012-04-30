/*
	File Name	: sp_pisi_d_rnditem.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_d_rnditem
	Description	: Download 시험제작실 자재
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: interface, cmms
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2006.09.13
	Author		: Kisskim
	Remark		: 
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_d_rnditem]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_d_rnditem]
GO

/*
Execute sp_pisi_d_rnditem
*/

Create Procedure sp_pisi_d_rnditem
	
	
As
Begin


If Exists (select * From pdrnditem)
	Begin

	-- 전장 CMMS DB 연구소 공장
	insert into [ipisele_svr\ipis].cmms.dbo.part_master(area_code, factory_code, part_code, part_name, 
    part_spec, normal_qty, repair_qty, etc_qty, scram_qty, part_unit, part_cost )
  SELECT XPLANT, DIV, ITNO, ITNM, SPEC, 0, 0, 0, 0, XUNIT,0 FROM PDRNDITEM
  WHERE itno not in (select part_code from [ipisele_svr\ipis].cmms.dbo.part_master where area_code = 'D' and factory_code = 'R')
  
	Truncate Table	pdrnditem
End


End		-- Procedure End
GO
