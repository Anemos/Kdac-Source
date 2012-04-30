/*
	File Name	: sp_pisc_select_rack.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisc_select_rack
	Description	: Rack DDDW을 위한 조회
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS2000
	Use Program	: 
	Parameter	: @ps_codegroup, @ps_codeid
	Use Table	: tmstworkcenter
	Initial		: 2002. 10. 02
	Author		: Kim Jin-Su
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisc_select_rack]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisc_select_rack]
GO

/*
Execute sp_pisc_select_rack
*/


Create Procedure sp_pisc_select_rack
		
As
Begin


Select	RackCode		= A.RackCode,
	RackName		= A.RackName,
	RackSize		= A.RackSize,
	RackQuality		= A.RackQuality,
	DisplayName		= A.RackName + '(' + A.RackCode + ')'
  From	tmstrack		A

Return

End		-- Procedure End
Go
