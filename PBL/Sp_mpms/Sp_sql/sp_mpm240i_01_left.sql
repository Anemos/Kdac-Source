/*
  File Name : sp_mpm240i_01_left.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm240i_01_left
  Description : 발주품번연결 - 외주가공데이타내역
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno varchar(9) - 의뢰번호
  Use Table :
  Initial   : 2006.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm240i_01_left]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm240i_01_left]
GO

/*
Execute sp_mpm240i_01_left '%'
*/

Create Procedure sp_mpm240i_01_left
  @ps_orderno varchar(9)

As
Begin

--summary standardtime
select OrderNo = bb.OrderNo,
  PartNo = bb.PartNo,
  OutSerial = bb.OutSerial,
  StdMatCost = Sum(isnull(dd.matcost,0)),
  StdTime = Sum(convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 )),
  StdMchCost = Sum(case cc.WcCode when 'THT' then isnull(dd.mchcost,0) else (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) end),
  StdOutCost = Sum(isnull(dd.outcost,0))
into #tmp_summary
from torder aa inner join toutprocess bb
  on aa.orderno = bb.orderno
  inner join toutprocessdetail dd
  on bb.orderno = dd.orderno and bb.partno = dd.partno and bb.outserial = dd.outserial
  inner join trouting cc
  on dd.orderno = cc.orderno and dd.partno = cc.partno and dd.operno = cc.operno
where aa.OrderNo = @ps_orderno and bb.outstatus = 'B'
group by bb.OrderNo, bb.PartNo, bb.OutSerial

select OrderNo = bb.OrderNo,
  ToolName = aa.ToolName,
  PartNo = bb.PartNo,
  OutSerial = bb.OutSerial,
  OutStatus = bb.OutStatus,
  PartName = cc.PartName,
  PartSpec = bb.PartSpec,
  Material = cc.Material,
  Qty = isnull(cc.Qty1,0) + isnull(cc.Qty2,0),
  StdTime = dd.stdtime,
  StdMatCost = dd.stdmatcost,
  StdMchCost = dd.stdmchcost,
  StdOutCost = dd.stdoutcost,
  StdUnitCost =  CAST ( ROUND( dd.stdoutcost / (isnull(cc.Qty1,0) + isnull(cc.Qty2,0)), -2, 1 ) AS NUMERIC(10,0)),
  OutCost = CAST ( ROUND( dd.stdoutcost / (isnull(cc.Qty1,0) + isnull(cc.Qty2,0)), -2, 1 )
            * (isnull(cc.Qty1,0) + isnull(cc.Qty2,0)) AS NUMERIC(10,0))
from torder aa inner join toutprocess bb
  on aa.orderno = bb.orderno
  inner join tpartlist cc
  on bb.orderno = cc.orderno and bb.partno = cc.partno
  inner join #tmp_summary dd
  on bb.orderno = dd.orderno and bb.partno = dd.partno and bb.outserial = dd.outserial
order by bb.orderno, bb.partno, bb.outserial

drop table #tmp_summary

End   -- Procedure End
Go
