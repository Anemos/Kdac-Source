/*
	File Name	: sp_pisi_u_tpartcancel_interface.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: sp_pisi_u_tpartcancel_interface
	Description	: Upload tpartcancel_interface(여주입고취소정보) 
	Supply		: DAEWOO Information Systems Co., LTD IAS Dept
	Use DataBase	: IPIS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2004.06.15
	Author		: Kiss Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_pisi_u_tpartcancel_interface]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_pisi_u_tpartcancel_interface]
GO

/*
Execute sp_pisi_u_tpartcancel_interface
*/

Create Procedure sp_pisi_u_tpartcancel_interface

	
As
Begin

SET XACT_ABORT OFF

-- 여주전자
INSERT INTO TPARTCANCEL_INTERFACE  
( Logid, Gubun, AreaCode, DivisionCode, ItemCode, ItemSource, CancelDate, InvStatus,
  SupplierCode, Blno, CancelQty, CancelAmt, TidNo, InterfaceFlag, LastEmp, LastDate )
select Logid, Gubun, AreaCode, DivisionCode, ItemCode, ItemSource, CancelDate, InvStatus,
  SupplierCode, Blno, CancelQty, CancelAmt, TidNo, InterfaceFlag, LastEmp, LastDate
from	[ipisyeo_svr\ipis].ipis.dbo.tpartcancel_interface
where	interfaceflag = 'Y'

update	[ipisyeo_svr\ipis].ipis.dbo.tpartcancel_interface
set interfaceflag = 'N'
from [ipisyeo_svr\ipis].ipis.dbo.tpartcancel_interface aa
  inner join tpartcancel_interface bb
  on aa.Logid = bb.Logid and aa.interfaceflag = 'Y'

Return

End		-- Procedure End
Go
