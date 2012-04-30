/*
	File Name	: sp_pisi_truncate_table.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_truncate_table
	Description	: 일간단위 table truncate
			  tmstbom, tmstdept, tmstproject...
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_truncate_table]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_truncate_table]
GO

/*
Execute sp_pisi_truncate_table 'xxx'
*/

Create Procedure sp_pisi_truncate_table
	@ps_table		varchar(30)
	
As
Begin

If @ps_table = 'tmstbom'
	truncate table tmstbom

If @ps_table = 'tmstdept'	
	truncate table tmstdept
	
If @ps_table = 'tmstproject'
	truncate table tmstproject

If @ps_table = 'tmstemp'
	truncate table tmstemp
 
End		-- Procedure End
Go
