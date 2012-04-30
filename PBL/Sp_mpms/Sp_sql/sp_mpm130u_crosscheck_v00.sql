/*
  File Name : sp_mpm130u_crosscheck.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm130u_crosscheck
  Description : 입고내역 크로스체크
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(8)
              @ps_todt char(8),
              @ps_empno char(8)
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm130u_crosscheck]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm130u_crosscheck]
GO

/*
Execute sp_mpm130u_crosscheck '20040401','20040430','000030'
*/

Create Procedure sp_mpm130u_crosscheck
  @ps_fromdt char(8),
  @ps_todt char(8),
  @ps_empno char(6)
As
Begin

select * into #inv401_tmp
from p_inv401

--cross check titemstore, p_inv401
delete titemstore
from titemstore aa 
where aa.tdte4 >= @ps_fromdt and aa.tdte4 <= @ps_todt and aa.sliptype <> 'WR'
  and not exists ( select * from #inv401_tmp bb
	  where bb.sliptype = aa.sliptype and bb.srno = aa.srno and
		  bb.srno1 = aa.srno1 and bb.srno2 = aa.srno2 )

--update same data
update titemstore  
  set Rqno = bb.Rqno,
      Itno = bb.Itno,
      Itnm = bb.Itnm,
      Spec = bb.Spec,
      Cls = bb.Cls,
      Srce = bb.Srce,
      Tqty4 = bb.Tqty4,
      Tdte4 = bb.Tdte4,
      Xcost = bb.Xcost,
      Tramt = bb.Tramt
from titemstore aa inner join #inv401_tmp bb
  on aa.sliptype = bb.sliptype and aa.srno = bb.srno and
    aa.srno1 = bb.srno1 and aa.srno2 = bb.srno2
where aa.tdte4 >= @ps_fromdt and aa.tdte4 <= @ps_todt

--insert new data
insert into titemstore  
( SlipType, Srno, Srno1, Srno2, RQNO, Xplant, Div, Itno, Itnm, Spec, Cls, Srce,
  MatCls, OrderNo, PartNo, Vsrno, Vndnm, Tqty4, Tdte4, Xcost, Tramt, LastEmp, LastDate )
select aa.sliptype, aa.srno, aa.srno1, aa.srno2, isnull(aa.rqno,''), aa.xplant, aa.div, aa.itno,
  aa.itnm, aa.spec, aa.cls, aa.srce, 
  Case Substring(aa.Itno,1,1)
          When 'P' then ( Case substring(aa.Itno,3,1) When 'P' Then 'P' Else 'M' End )
          When 'T' then ( Case substring(aa.Itno,1,4) When 'T0EP' Then 'T'
                            When 'T0ER' Then 'T' Else 'W' End )
          Else 'W' End,
  substring(isnull(aa.extd,''),1,8), substring(isnull(aa.extd,''),9,6), 
  aa.vsrno, aa.vndnm, aa.tqty4, aa.tdte4, aa.xcost, aa.tramt, @ps_empno, getdate()
from #inv401_tmp aa 
where aa.tdte4 >= @ps_fromdt and aa.tdte4 <= @ps_todt
  and not exists ( select * from titemstore bb
	  where bb.sliptype = aa.sliptype and bb.srno = aa.srno and
		  bb.srno1 = aa.srno1 and bb.srno2 = aa.srno2 )

drop table #inv401_tmp

return
End   -- Procedure End
Go
