/*
  File Name : sp_mpm240i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm240i_01
  Description : 외주가공진행정보
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno varchar(9) - 의뢰번호
              @ps_deptcode varchar(6) - 의뢰부서
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm240i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm240i_01]
GO

/*
Execute sp_mpm240i_01 '%','%'
*/

Create Procedure sp_mpm240i_01
  @ps_orderno varchar(9),
  @ps_deptcode varchar(6)
As
Begin

--summary standardtime
select OrderNo = bb.OrderNo,
  PartNo = bb.PartNo,
  OutSerial = bb.OutSerial,
  StdMatCost = Sum(isnull(dd.matcost,0)),
  StdTime = Sum(convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 )),
  StdMchCost = Sum(case cc.WcCode when 'THT' then isnull(dd.mchcost,0) else (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) end),
  StdOutCost = Sum(isnull(dd.outcost,0)),
  TBS0 = Sum(case cc.WcCode when 'TBS' then isnull(dd.StdTime ,0) else 0 end),
  TLA0 = Sum(case cc.WcCode when 'TLA' then isnull(dd.StdTime ,0) else 0 end),
  TDM0 = Sum(case cc.WcCode when 'TDM' then isnull(dd.StdTime ,0) else 0 end),
  TPM0 = Sum(case cc.WcCode when 'TPM' then isnull(dd.StdTime ,0) else 0 end),
  TBM0 = Sum(case cc.WcCode when 'TBM' then isnull(dd.StdTime ,0) else 0 end),
  TMM0 = Sum(case cc.WcCode when 'TMM' then isnull(dd.StdTime ,0) else 0 end),
  TJB0 = Sum(case cc.WcCode when 'TJB' then isnull(dd.StdTime ,0) else 0 end),
  THT0 = Sum(case cc.WcCode when 'THT' then isnull(dd.StdTime ,0) else 0 end),
  TUG0 = Sum(case cc.WcCode when 'TUG' then isnull(dd.StdTime ,0) else 0 end),
  TSG0 = Sum(case cc.WcCode when 'TSG' then isnull(dd.StdTime ,0) else 0 end),
  TJG0 = Sum(case cc.WcCode when 'TJG' then isnull(dd.StdTime ,0) else 0 end),
  TVG0 = Sum(case cc.WcCode when 'TVG' then isnull(dd.StdTime ,0) else 0 end),
  TWC0 = Sum(case cc.WcCode when 'TWC' then isnull(dd.StdTime ,0) else 0 end),
  TED0 = Sum(case cc.WcCode when 'TED' then isnull(dd.StdTime ,0) else 0 end),
  TLP0 = Sum(case cc.WcCode when 'TLP' then isnull(dd.StdTime ,0) else 0 end),
  TAM0 = Sum(case cc.WcCode when 'TAM' then isnull(dd.StdTime ,0) else 0 end),
  TBS1 = Sum(case cc.WcCode when 'TBS' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TLA1 = Sum(case cc.WcCode when 'TLA' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TDM1 = Sum(case cc.WcCode when 'TDM' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TPM1 = Sum(case cc.WcCode when 'TPM' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TBM1 = Sum(case cc.WcCode when 'TBM' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TMM1 = Sum(case cc.WcCode when 'TMM' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TJB1 = Sum(case cc.WcCode when 'TJB' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  THT1 = Sum(case cc.WcCode when 'THT' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TUG1 = Sum(case cc.WcCode when 'TUG' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TSG1 = Sum(case cc.WcCode when 'TSG' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TJG1 = Sum(case cc.WcCode when 'TJG' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TVG1 = Sum(case cc.WcCode when 'TVG' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TWC1 = Sum(case cc.WcCode when 'TWC' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TED1 = Sum(case cc.WcCode when 'TED' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TLP1 = Sum(case cc.WcCode when 'TLP' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TAM1 = Sum(case cc.WcCode when 'TAM' then convert(decimal(8,1),(dd.applyqty * isnull(dd.StdTime,0)) / 60 ) else 0 end),
  TBS3 = Sum(case cc.WcCode when 'TBS' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TLA3 = Sum(case cc.WcCode when 'TLA' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TDM3 = Sum(case cc.WcCode when 'TDM' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TPM3 = Sum(case cc.WcCode when 'TPM' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TBM3 = Sum(case cc.WcCode when 'TBM' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TMM3 = Sum(case cc.WcCode when 'TMM' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TJB3 = Sum(case cc.WcCode when 'TJB' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  THT3 = Sum(case cc.WcCode when 'THT' then isnull(dd.mchcost,0) else 0 end),
  TUG3 = Sum(case cc.WcCode when 'TUG' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TSG3 = Sum(case cc.WcCode when 'TSG' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TJG3 = Sum(case cc.WcCode when 'TJG' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TVG3 = Sum(case cc.WcCode when 'TVG' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TWC3 = Sum(case cc.WcCode when 'TWC' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TED3 = Sum(case cc.WcCode when 'TED' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TLP3 = Sum(case cc.WcCode when 'TLP' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end),
  TAM3 = Sum(case cc.WcCode when 'TAM' then (isnull(dd.mchcost,0) - isnull(dd.matcost,0)) else 0 end)
into #tmp_summary
from torder aa inner join toutprocess bb
  on aa.orderno = bb.orderno
  inner join toutprocessdetail dd
  on bb.orderno = dd.orderno and bb.partno = dd.partno and bb.outserial = dd.outserial
  inner join trouting cc
  on dd.orderno = cc.orderno and dd.partno = cc.partno and dd.operno = cc.operno
where aa.OrderNo like @ps_orderno and aa.OrderDept like @ps_deptcode
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
            * (isnull(cc.Qty1,0) + isnull(cc.Qty2,0)) AS NUMERIC(10,0)),
  TBS0 = dd.TBS0,
  TLA0 = dd.TLA0,
  TDM0 = dd.TDM0,
  TPM0 = dd.TPM0,
  TBM0 = dd.TBM0,
  TMM0 = dd.TMM0,
  TJB0 = dd.TJB0,
  THT0 = dd.THT0,
  TUG0 = dd.TUG0,
  TSG0 = dd.TSG0,
  TJG0 = dd.TJG0,
  TVG0 = dd.TVG0,
  TWC0 = dd.TWC0,
  TED0 = dd.TED0,
  TLP0 = dd.TLP0,
  TAM0 = dd.TAM0,
  TBS1 = dd.TBS1,
  TLA1 = dd.TLA1,
  TDM1 = dd.TDM1,
  TPM1 = dd.TPM1,
  TBM1 = dd.TBM1,
  TMM1 = dd.TMM1,
  TJB1 = dd.TJB1,
  THT1 = dd.THT1,
  TUG1 = dd.TUG1,
  TSG1 = dd.TSG1,
  TJG1 = dd.TJG1,
  TVG1 = dd.TVG1,
  TWC1 = dd.TWC1,
  TED1 = dd.TED1,
  TLP1 = dd.TLP1,
  TAM1 = dd.TAM1,
  TBS2 = ( select outcostratio from tworkcenter where wccode = 'TBS' ),
  TLA2 = ( select outcostratio from tworkcenter where wccode = 'TLA' ),
  TDM2 = ( select outcostratio from tworkcenter where wccode = 'TDM' ),
  TPM2 = ( select outcostratio from tworkcenter where wccode = 'TPM' ),
  TBM2 = ( select outcostratio from tworkcenter where wccode = 'TBM' ),
  TMM2 = ( select outcostratio from tworkcenter where wccode = 'TMM' ),
  TJB2 = ( select outcostratio from tworkcenter where wccode = 'TJB' ),
  THT2 = ( select outcostratio from tworkcenter where wccode = 'THT' ),
  TUG2 = ( select outcostratio from tworkcenter where wccode = 'TUG' ),
  TSG2 = ( select outcostratio from tworkcenter where wccode = 'TSG' ),
  TJG2 = ( select outcostratio from tworkcenter where wccode = 'TJG' ),
  TVG2 = ( select outcostratio from tworkcenter where wccode = 'TVG' ),
  TWC2 = ( select outcostratio from tworkcenter where wccode = 'TWC' ),
  TED2 = ( select outcostratio from tworkcenter where wccode = 'TED' ),
  TLP2 = ( select outcostratio from tworkcenter where wccode = 'TLP' ),
  TAM2 = ( select outcostratio from tworkcenter where wccode = 'TAM' ),
  TBS3 = dd.TBS3,
  TLA3 = dd.TLA3,
  TDM3 = dd.TDM3,
  TPM3 = dd.TPM3,
  TBM3 = dd.TBM3,
  TMM3 = dd.TMM3,
  TJB3 = dd.TJB3,
  THT3 = dd.THT3,
  TUG3 = dd.TUG3,
  TSG3 = dd.TSG3,
  TJG3 = dd.TJG3,
  TVG3 = dd.TVG3,
  TWC3 = dd.TWC3,
  TED3 = dd.TED3,
  TLP3 = dd.TLP3,
  TAM3 = dd.TAM3
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
