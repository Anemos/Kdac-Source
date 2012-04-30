/*
	File Name	: sp_mpm220u_04_01.SQL
	SYSTEM		: 금형공정관리 시스템
	Procedure Name	: sp_mpm220u_04_01
	Description	: 작업지시전표 출력(일괄) - Top 50 percent
	Use DataBase	: MPMS
	Use Program	:
	Parameter : @ps_orderno char(8), @ps_wccode varchar(4)
	Use Table	: trouting
	Initial		: 2004.08.16
	Author		: Kiss Kim
*/


If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[sp_mpm220u_04_01]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[sp_mpm220u_04_01]
GO

/*
Execute sp_mpm220u_04_01 '@ps_orderno','@ps_wccode'
*/

Create Procedure sp_mpm220u_04_01
  @ps_orderno char(8),
  @ps_wccode varchar(4)

As
Begin

Declare @li_cntx integer,
  @li_rowcntx integer,
  @li_cntk integer,
  @li_rowcntk integer,
  @li_rowcount numeric(10,3)

create table #tmp_upperresult (
  printdate char(10) null,
  orderno char(8) null,
  toolname varchar(100) null,
  partno char(6) null,
  partname varchar(50) null,
  planqty integer null,
  material varchar(20) null,
  operno char(3) null,
  wccode char(3) null,
  postwccode char(3) null,
  stdtime integer null,
  workmatter varchar(255) null,
  workstart char(10) null,
  workemp char(6) null,
  workempname varchar(20) null,
  mchno varchar(20) null,
  workdate varchar(10) null,
  begintime varchar(20) null,
  endtime varchar(20) null,
  finalqty integer null,
  scrapqty integer null,
  jobtime integer null)

create table #tmp_upperdivide (
  serialno integer  IDENTITY(1,1),
  printdate char(10) null,
  orderno char(8) null,
  toolname varchar(100) null,
  partno char(6) null,
  partname varchar(50) null,
  planqty integer null,
  material varchar(20) null,
  operno char(3) null,
  wccode char(3) null,
  postwccode char(3) null,
  stdtime integer null,
  workmatter varchar(255) null,
  workstart char(10) null,
  workemp char(6) null,
  workempname varchar(20) null,
  mchno varchar(20) null,
  workdate varchar(10) null,
  begintime varchar(20) null,
  endtime varchar(20) null,
  finalqty integer null,
  scrapqty integer null,
  jobtime integer null)

insert into #tmp_upperdivide(printdate,orderno,toolname,partno,
  partname,planqty,material,operno,wccode,postwccode,
  stdtime,workmatter,workstart,workemp,workempname,mchno,
  workdate,begintime,endtime,finalqty,scrapqty,jobtime)
Select TOP 50 PERCENT PrintDate = Convert(char(10),getdate(),102),
  OrderNo = aa.OrderNo,
  ToolName = aa.ToolName,
  PartNo = bb.PartNo,
  PartName = bb.PartName,
  PlanQty = isnull(bb.Qty1,0) + isnull(bb.Qty2,0),
  Material = bb.Material,
  OperNo = cc.OperNo,
  WcCode = cc.WcCode,
  PostWcCode = ( Select Top 1 wccode from trouting
    where OrderNo = @ps_orderno and PartNo = bb.PartNo and
      OperNo > cc.OperNo
    order by OperNo ),
  StdTime = cc.StdTime * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0)),
  WorkMatter = cc.WorkMatter,
  WorkStart = Convert(char(10),cc.WorkStart,102),
  WorkEmp = ' ',
  WorkEmpName = ' ',
  MchNo = ' ',
  WorkDate = ' ',
  BeginTime = ' ',
  EndTime = ' ',
  FinalQty = 0,
  ScrapQty = 0,
  JobTime = 0
From torder aa inner join tpartlist bb
  on aa.OrderNo = bb.OrderNo
  inner join trouting cc
  on bb.OrderNo = cc.OrderNo and bb.PartNo = cc.PartNo
Where cc.OrderNo = @ps_orderno and cc.WcCode like @ps_wccode and
      cc.WcCode <> 'THT' and cc.OutFlag <> 'P'
order by cc.orderno, cc.wccode, bb.serialno, cc.partno, cc.operno

select @li_rowcount = @@rowcount
select @li_cntx = 1
select @li_rowcntx = ceiling(@li_rowcount / 2)
select @li_cntk = @li_rowcntx + 1
select @li_rowcntk = @li_rowcount

while (@li_cntx <= @li_rowcntx)
Begin
  insert into #tmp_upperresult
  select printdate,orderno,toolname,partno,
  partname,planqty,material,operno,wccode,postwccode,
  stdtime,workmatter,workstart,workemp,workempname,mchno,
  workdate,begintime,endtime,finalqty,scrapqty,jobtime
  from #tmp_upperdivide where serialno = @li_cntx

  select @li_cntx = @li_cntx + 1
  if @li_cntk <= @li_rowcntk
    Begin
      insert into #tmp_upperresult
      select printdate,orderno,toolname,partno,
      partname,planqty,material,operno,wccode,postwccode,
      stdtime,workmatter,workstart,workemp,workempname,mchno,
      workdate,begintime,endtime,finalqty,scrapqty,jobtime
      from #tmp_upperdivide where serialno = @li_cntk

      select @li_cntk = @li_cntk + 1
    End
End

select * from #tmp_upperresult
drop table #tmp_upperdivide
drop table #tmp_upperresult
Return

End		-- Procedure End

Go
