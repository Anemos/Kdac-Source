/*
  File Name : sp_mpm332i_02.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm332i_02
  Description : 공정진행율 (예상작업시간을 기준으로 함 ) - W/C별
  진행중인 Order에 대한 총공정시간,완료공정,잔여공정,진행율을 가져온다.
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno varchar(8)
  Use Table :
  Initial   : 2004.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm332i_02]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm332i_02]
GO

/*
Execute sp_mpm332i_02 '00000000'
*/

Create Procedure sp_mpm332i_02
  @ps_orderno varchar(8)
As
Begin

if @ps_orderno = '00000000'
  select @ps_orderno = '%'
  
-- All WcCode
Select WcCode = 'ALL',
  WcSerial = 0,
  TotalTime = Sum(convert(decimal(6,1),isnull(bb.StdTime * (isnull(cc.Qty1,0) + isnull(cc.Qty2,0)),0) / 60)),
  EndTime =  Sum( Case When bb.workstatus ='C' Then convert(decimal(6,1),isnull(bb.StdTime * (isnull(cc.Qty1,0) + isnull(cc.Qty2,0)),0) / 60) Else 0 End ),
  IngTime =  Sum( Case When bb.workstatus <> 'C' Then convert(decimal(6,1),isnull(bb.StdTime * (isnull(cc.Qty1,0) + isnull(cc.Qty2,0)),0) / 60) Else 0 End )
From trouting bb inner join tpartlist cc
  on bb.orderno = cc.orderno and bb.partno = cc.partno
Where bb.orderno like @ps_orderno and bb.outflag <> 'P'

Union All
-- Each WcCode
Select WcCode = cc.WcCode,
  WcSerial = cc.WcSerial,
  TotalTime = Sum(isnull(bb.totaltime,0)),
  EndTime =  Sum(isnull(bb.endtime,0)),
  IngTime =  Sum(isnull(bb.ingtime,0))
From ( Select WcCode = aa.WcCode,
  TotalTime = Sum(convert(decimal(6,1),isnull(aa.StdTime * (isnull(dd.Qty1,0) + isnull(dd.Qty2,0)),0) / 60)),
  EndTime =  Sum( Case When aa.workstatus = 'C' Then convert(decimal(6,1),isnull(aa.StdTime * (isnull(dd.Qty1,0) + isnull(dd.Qty2,0)),0) / 60) Else 0 End ),
  IngTime =  Sum( Case When aa.workstatus <> 'C' Then convert(decimal(6,1),isnull(aa.StdTime * (isnull(dd.Qty1,0) + isnull(dd.Qty2,0)),0) / 60) Else 0 End )
  From trouting aa inner join tpartlist dd
    on aa.orderno = dd.orderno and aa.partno = dd.partno
  Where aa.orderno like @ps_orderno and aa.outflag <> 'P'
  Group by aa.wccode) bb
  right outer join tworkcenter cc
  on bb.WcCode = cc.WcCode and cc.WcCode <> 'THT'
Group by cc.WcCode, cc.WcSerial
Order by cc.WcSerial

End   -- Procedure End
Go
