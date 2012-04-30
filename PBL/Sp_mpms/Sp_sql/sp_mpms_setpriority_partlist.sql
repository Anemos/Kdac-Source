/*
  File Name : sp_mpms_setpriority_partlist.SQL
  SYSTEM    : 금형공정관리 시스템
  Procedure Name  : sp_mpms_setpriority_partlist
  Description : 파트리스트에 작업예정시간순서대로 우선순위를 부여함.
  Use DataBase  : MPMS
  Use Program :
  Use Table : torder
  Parameter : @ps_yyyymm char(7)
  Initial   : 2004.03.31
  Author    : Kiss Kim
*/


If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpms_setpriority_partlist]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpms_setpriority_partlist]
GO

/*
Execute sp_mpms_setpriority_partlist '20100137'
*/

Create Procedure sp_mpms_setpriority_partlist
  @ps_orderno char(8)

As
Begin

CREATE TABLE #tmp_partlist (
  PriorityNo  int  IDENTITY(1,1) not null,
  OrderNo char(8) null,
  PartNo char(6) null )

INSERT INTO #tmp_partlist( OrderNo, PartNo )
select tmp_sum.orderno, tmp_sum.partno
from ( select OrderNo = bb.OrderNo,
  PartNo = bb.PartNo,
  StdTime = Sum(isnull(cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),0))
from torder aa inner join tpartlist bb
  on aa.orderno = bb.orderno
  inner join trouting cc
  on bb.orderno = cc.orderno and bb.partno = cc.partno
where aa.orderno = @ps_orderno and aa.ingstatus <> 'C'
group by bb.OrderNo, bb.PartNo ) tmp_sum
order by tmp_sum.stdtime desc

UPDATE tpartlist
set priorityno = b.priorityno
from tpartlist a inner join #tmp_partlist b
  on a.orderno = b.orderno and a.partno = b.partno

drop table #tmp_partlist

return

End   -- Procedure End

Go
