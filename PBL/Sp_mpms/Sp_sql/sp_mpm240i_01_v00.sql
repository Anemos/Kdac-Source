/*
  File Name : sp_mpm240i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm240i_01
  Description : ���ְ�����������
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(10) - ���������
              @ps_todt char(10) - ����Ϸ���
              @ps_orderno varchar(9) - �Ƿڹ�ȣ
              @ps_deptcode varchar(6) - �Ƿںμ�
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
Execute sp_mpm240i_01 '2006.04.01','2006.05.30','%','%'
*/

Create Procedure sp_mpm240i_01
  @ps_applyfrom char(10),
  @ps_applyto char(10),
  @ps_orderno varchar(9),
  @ps_deptcode varchar(6)
As
Begin

declare @ld_fromdt datetime, @ld_todt datetime

select @ld_fromdt = convert(datetime,@ps_applyfrom,102)
select @ld_todt = dateadd( dd, 1, convert(datetime,@ps_applyto,102))

--summary standardtime
select OrderNo = bb.OrderNo,
  PartNo = bb.PartNo,
  OutSerial = bb.OutSerial,
  StdMatCost = isnull(dd.matcost,0),
  StdTime = Sum(convert(decimal(6,1),isnull(dd.StdTime,0) / 60 )),
  StdMchCost = Sum(isnull(dd.mchcost,0)),
  StdOutCost = Sum(isnull(dd.outcost,0)),
  TBS1 = Sum(case cc.WcCode when 'TBS' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TLA1 = Sum(case cc.WcCode when 'TLA' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TDM1 = Sum(case cc.WcCode when 'TDM' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TPM1 = Sum(case cc.WcCode when 'TPM' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TBM1 = Sum(case cc.WcCode when 'TBM' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TMM1 = Sum(case cc.WcCode when 'TMM' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TJB1 = Sum(case cc.WcCode when 'TJB' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  THT1 = Sum(case cc.WcCode when 'THT' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TUG1 = Sum(case cc.WcCode when 'TUG' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TSG1 = Sum(case cc.WcCode when 'TSG' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TJG1 = Sum(case cc.WcCode when 'TJG' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TVG1 = Sum(case cc.WcCode when 'TVG' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TWC1 = Sum(case cc.WcCode when 'TWC' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TED1 = Sum(case cc.WcCode when 'TED' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TLP1 = Sum(case cc.WcCode when 'TLP' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TAM1 = Sum(case cc.WcCode when 'TAM' then convert(decimal(6,1),isnull(dd.StdTime ,0) / 60 ) else 0 end),
  TBS2 = Sum(case cc.WcCode when 'TBS' then isnull(dd.outcostratio,0) else 0 end),
  TLA2 = Sum(case cc.WcCode when 'TLA' then isnull(dd.outcostratio,0) else 0 end),
  TDM2 = Sum(case cc.WcCode when 'TDM' then isnull(dd.outcostratio,0) else 0 end),
  TPM2 = Sum(case cc.WcCode when 'TPM' then isnull(dd.outcostratio,0) else 0 end),
  TBM2 = Sum(case cc.WcCode when 'TBM' then isnull(dd.outcostratio,0) else 0 end),
  TMM2 = Sum(case cc.WcCode when 'TMM' then isnull(dd.outcostratio,0) else 0 end),
  TJB2 = Sum(case cc.WcCode when 'TJB' then isnull(dd.outcostratio,0) else 0 end),
  THT2 = Sum(case cc.WcCode when 'THT' then isnull(dd.outcostratio,0) else 0 end),
  TUG2 = Sum(case cc.WcCode when 'TUG' then isnull(dd.outcostratio,0) else 0 end),
  TSG2 = Sum(case cc.WcCode when 'TSG' then isnull(dd.outcostratio,0) else 0 end),
  TJG2 = Sum(case cc.WcCode when 'TJG' then isnull(dd.outcostratio,0) else 0 end),
  TVG2 = Sum(case cc.WcCode when 'TVG' then isnull(dd.outcostratio,0) else 0 end),
  TWC2 = Sum(case cc.WcCode when 'TWC' then isnull(dd.outcostratio,0) else 0 end),
  TED2 = Sum(case cc.WcCode when 'TED' then isnull(dd.outcostratio,0) else 0 end),
  TLP2 = Sum(case cc.WcCode when 'TLP' then isnull(dd.outcostratio,0) else 0 end),
  TAM2 = Sum(case cc.WcCode when 'TAM' then isnull(dd.outcostratio,0) else 0 end),
  TBS3 = Sum(case cc.WcCode when 'TBS' then isnull(dd.mchcost,0) else 0 end),
  TLA3 = Sum(case cc.WcCode when 'TLA' then isnull(dd.mchcost,0) else 0 end),
  TDM3 = Sum(case cc.WcCode when 'TDM' then isnull(dd.mchcost,0) else 0 end),
  TPM3 = Sum(case cc.WcCode when 'TPM' then isnull(dd.mchcost,0) else 0 end),
  TBM3 = Sum(case cc.WcCode when 'TBM' then isnull(dd.mchcost,0) else 0 end),
  TMM3 = Sum(case cc.WcCode when 'TMM' then isnull(dd.mchcost,0) else 0 end),
  TJB3 = Sum(case cc.WcCode when 'TJB' then isnull(dd.mchcost,0) else 0 end),
  THT3 = Sum(case cc.WcCode when 'THT' then isnull(dd.mchcost,0) else 0 end),
  TUG3 = Sum(case cc.WcCode when 'TUG' then isnull(dd.mchcost,0) else 0 end),
  TSG3 = Sum(case cc.WcCode when 'TSG' then isnull(dd.mchcost,0) else 0 end),
  TJG3 = Sum(case cc.WcCode when 'TJG' then isnull(dd.mchcost,0) else 0 end),
  TVG3 = Sum(case cc.WcCode when 'TVG' then isnull(dd.mchcost,0) else 0 end),
  TWC3 = Sum(case cc.WcCode when 'TWC' then isnull(dd.mchcost,0) else 0 end),
  TED3 = Sum(case cc.WcCode when 'TED' then isnull(dd.mchcost,0) else 0 end),
  TLP3 = Sum(case cc.WcCode when 'TLP' then isnull(dd.mchcost,0) else 0 end),
  TAM3 = Sum(case cc.WcCode when 'TAM' then isnull(dd.mchcost,0) else 0 end)
into #tmp_summary
from torder aa inner join toutprocess bb
  on aa.orderno = bb.orderno
  inner join toutprocessdetail dd
  on bb.orderno = dd.orderno and bb.partno = dd.partno and bb.outserial = dd.outserial
  inner join trouting cc
  on dd.orderno = cc.orderno and dd.partno = cc.partno and dd.operno = cc.operno
where aa.OrderNo like @ps_orderno and aa.OrderDept like @ps_deptcode and
  aa.startdate <= @ld_todt and
  ( aa.enddate is null or aa.enddate > @ld_todt )
group by bb.OrderNo, bb.PartNo, bb.OutSerial, dd.matcost

select ApplyFrom = @ps_applyfrom,
  Applyto = @ps_applyto,
  OrderNo = bb.OrderNo,
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
  TBS2 = dd.TBS2,
  TLA2 = dd.TLA2,
  TDM2 = dd.TDM2,
  TPM2 = dd.TPM2,
  TBM2 = dd.TBM2,
  TMM2 = dd.TMM2,
  TJB2 = dd.TJB2,
  THT2 = dd.THT2,
  TUG2 = dd.TUG2,
  TSG2 = dd.TSG2,
  TJG2 = dd.TJG2,
  TVG2 = dd.TVG2,
  TWC2 = dd.TWC2,
  TED2 = dd.TED2,
  TLP2 = dd.TLP2,
  TAM2 = dd.TAM2,
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
