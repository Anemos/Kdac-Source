/*
  File Name : sp_mpm115u_03.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm115u_03
  Description : 단말기/작업장 연계 데이타 조회
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table : tworkcenter, tworkgroup, tterminal, tterminalworkgroup
  Initial   : 2006.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm115u_03]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm115u_03]
GO

/*
Execute sp_mpm115u_03
*/

Create Procedure sp_mpm115u_03

As
Begin       -- Procedure Start

select TrmCode = bb.TrmCode,
  TrmName = bb.TrmName,
  WgCode = cc.WgCode,
  WgName = cc.WgName,
  WcCode = dd.WcCode,
  WcName = dd.WcName,
  CodeName = ee.CodeName
from tterminalworkgroup aa inner join tterminal bb
  on aa.trmcode = bb.trmcode
  inner join tworkgroup cc
  on aa.wgcode = cc.wgcode
  left outer join tworkcenter dd
  on cc.wgcode = dd.wgcode
  inner join tcodemaster ee
  on dd.wcgubun = ee.cocode and ee.codegubun = 'MPM001'
order by bb.trmcode, cc.wgcode

End   -- Procedure End
Go

