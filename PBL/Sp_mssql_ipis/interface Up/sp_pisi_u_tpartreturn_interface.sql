/*
	File Name	: sp_pisi_u_tpartreturn_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tpartreturn_interface
	Description	: Upload tpartreturn_interface(여주자재 반납정보) 
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.06.15
	Author		: Kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tpartreturn_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tpartreturn_interface]
GO

/*
Execute sp_pisi_u_tpartreturn_interface
*/

Create Procedure sp_pisi_u_tpartreturn_interface

	
As
Begin

SET XACT_ABORT OFF

-- 여주전자
INSERT INTO TPARTRETURN_INTERFACE  
( Logid, Gubun, AreaCode, DivisionCode, ItemCode, RtnDept, RtnUsage, RtnGubun,
  RtnDate, Uqty, Rqty, Sqty, SupplierCode, TidNo, InterfaceFlag, LastEmp, LastDate )
select Logid, Gubun, AreaCode, DivisionCode, ItemCode, RtnDept, RtnUsage, RtnGubun,
  RtnDate, Uqty, Rqty, Sqty, SupplierCode, TidNo, InterfaceFlag, LastEmp, LastDate
from	[ipisyeo_svr\ipis].ipis.dbo.tpartreturn_interface
where	interfaceflag = 'Y'

update	[ipisyeo_svr\ipis].ipis.dbo.tpartreturn_interface
set interfaceflag = 'N'
from [ipisyeo_svr\ipis].ipis.dbo.tpartreturn_interface aa
  inner join tpartreturn_interface bb
  on aa.Logid = bb.Logid and aa.interfaceflag = 'Y'

Return

End		-- Procedure End
Go
