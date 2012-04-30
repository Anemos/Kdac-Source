/*
	File Name	: sp_pisi_u_tpartin_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tpartin_interface
	Description	: Upload tpartin_interface(여주자재 입고정보) 
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.06.15
	Author		: kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tpartin_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tpartin_interface]
GO

/*
Execute sp_pisi_u_tpartin_interface
*/

Create Procedure sp_pisi_u_tpartin_interface

	
As
Begin

SET XACT_ABORT OFF

-- 여주전자
INSERT INTO TPARTIN_INTERFACE  
( Logid, Gubun, AreaCode, DivisionCode, Slno, IncomeDate, ItemCode,
  ItemSource, TidNo, InterfaceFlag, LastEmp, LastDate )
select Logid, Gubun, AreaCode, DivisionCode, Slno, IncomeDate, ItemCode,
  ItemSource, TidNo, InterfaceFlag, LastEmp, LastDate
from	[ipisyeo_svr\ipis].ipis.dbo.tpartin_interface
where	interfaceflag = 'Y'

update [ipisyeo_svr\ipis].ipis.dbo.tpartin_interface
set interfaceflag = 'N'
from [ipisyeo_svr\ipis].ipis.dbo.tpartin_interface aa
  inner join tpartin_interface bb
  on aa.Logid = bb.Logid and aa.interfaceflag = 'Y'

Return

End		-- Procedure End
Go
