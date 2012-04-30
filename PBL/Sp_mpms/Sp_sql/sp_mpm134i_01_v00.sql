/*
  File Name : sp_mpm134i_01.SQL
  SYSTEM    : 금형공정관리시스템
  View Name  : sp_mpm134i_01
  Description : 장비별 작업시간 집계
  Supply    : 
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2005.04
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm134i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm134i_01]
GO

/*
Execute sp_mpm134i_01 '2005.01.01','2005.01.31','%'
*/

Create Procedure sp_mpm134i_01
  @ps_fromdt varchar(10),
  @ps_todt  varchar(10),
  @ps_orderno varchar(9)

As
Begin

create table #jobsum_tmp
( id_num int null, wccode char(3) null, mchno char(5) null,
  orderno varchar(20) null, toolname varchar(100) null, jobhour decimal(6,1) null )

Select IDENTITY(int, 1,1) as id_num,
  wccode = aa.wccode,
  mchno = aa.mchno,
  orderno = cc.orderno,
  toolname = dd.toolname,
  jobhour = sum(convert(decimal(6,1),isnull(cc.jobtime,0) / 60 ))
into #job_tmp
From tmachine aa inner join tworkcenter bb
  on aa.wccode = bb.wccode
  inner join tworkjob cc
  on aa.wccode = cc.wccode and aa.mchno = cc.mchno
  inner join torder dd
  on cc.orderno = dd.orderno
Where cc.workdate >= convert(char(8),convert(datetime,@ps_fromdt),112) and 
  cc.workdate <= convert(char(8),convert(datetime,@ps_todt),112) and 
  cc.orderno like @ps_orderno
group by aa.wccode, aa.mchno, cc.orderno, dd.toolname

insert into #jobsum_tmp
select * from #job_tmp

insert into #jobsum_tmp
Select -1 as id_num,
  wccode = aa.wccode,
  mchno = aa.mchno,
  orderno = 'ALL(예상)',
  toolname = '',
  jobhour = sum(convert(decimal(6,1),isnull(dd.stdtime,0) / 60 ))
From tmachine aa inner join tworkcenter bb
  on aa.wccode = bb.wccode
  inner join ( select orderno = ff.orderno, 
                wccode = ff.wccode, cnt = count(*) from tworkjob ff
                where ff.workdate >= convert(char(8),convert(datetime,@ps_fromdt),112) and 
                  ff.workdate <= convert(char(8),convert(datetime,@ps_todt),112) and
                  ff.orderno like @ps_orderno
                group by ff.orderno, ff.wccode ) cc
  on bb.wccode = cc.wccode
  inner join trouting dd
  on cc.orderno = dd.orderno and cc.wccode = dd.wccode 
group by aa.wccode, aa.mchno

insert into #jobsum_tmp
Select 0 as id_num,
  wccode = aa.wccode,
  mchno = aa.mchno,
  orderno = 'ALL(실제)',
  toolname = '',
  jobhour = sum(convert(decimal(6,1),isnull(cc.jobtime,0) / 60 ))
From tmachine aa inner join tworkcenter bb
  on aa.wccode = bb.wccode
  inner join tworkjob cc
  on aa.wccode = cc.wccode and aa.mchno = cc.mchno
Where cc.workdate >= convert(char(8),convert(datetime,@ps_fromdt),112) and 
  cc.workdate <= convert(char(8),convert(datetime,@ps_todt),112) and
  cc.orderno like @ps_orderno
group by aa.wccode, aa.mchno

select * from #jobsum_tmp
drop table #jobsum_tmp
drop table #job_tmp

End   -- Procedure End
Go
