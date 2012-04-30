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
Execute sp_mpm134i_01 '20050101','20050131','%'
*/

Create Procedure sp_mpm134i_01
  @ps_fromdt varchar(10),
  @ps_todt  varchar(10),
  @ps_orderno varchar(9)

As
Begin

Select wccode = aa.wccode,
  mchno = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3),
  orderno = cc.orderno,
  toolname = dd.toolname,
  jobhour = sum(convert(decimal(6,1),isnull(cc.jobtime,0) / 60 ))
From tmachine aa inner join tworkcenter bb
  on aa.wccode = bb.wccode
  inner join tworkjob cc
  on aa.wccode = cc.wccode and aa.mchno = cc.mchno
  inner join torder dd
  on cc.orderno = dd.orderno
Where cc.workdate >= @ps_fromdt and cc.workdate <= @ps_todt and 
  cc.orderno like @ps_orderno
group by aa.wccode, aa.mchno, cc.orderno, dd.toolname

Union all

Select wccode = aa.wccode,
  mchno = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3),
  orderno = 'ALL(예상)',
  toolname = '',
  jobhour = sum(convert(decimal(6,1),isnull(dd.stdtime,0) / 60 ))
From tmachine aa inner join tworkcenter bb
  on aa.wccode = bb.wccode
  inner join ( select orderno = ff.orderno, 
                wccode = ff.wccode, cnt = count(*) from tworkjob ff
                where ff.workdate >= @ps_fromdt and ff.workdate <= @ps_todt and
                  ff.orderno like @ps_orderno
                group by ff.orderno, ff.wccode ) cc
  on bb.wccode = cc.wccode
  inner join trouting dd
  on cc.orderno = dd.orderno and cc.wccode = dd.wccode 
group by aa.wccode, aa.mchno

Union all

Select wccode = aa.wccode,
  mchno = substring(aa.mchno,1,2) + '-' + substring(aa.mchno,3,3),
  orderno = 'ALL(실제)',
  toolname = '',
  jobhour = sum(convert(decimal(6,1),isnull(cc.jobtime,0) / 60 ))
From tmachine aa inner join tworkcenter bb
  on aa.wccode = bb.wccode
  inner join tworkjob cc
  on aa.wccode = cc.wccode and aa.mchno = cc.mchno
Where cc.workdate >= @ps_fromdt and cc.workdate <= @ps_todt and
  cc.orderno like @ps_orderno
group by aa.wccode, aa.mchno


End   -- Procedure End
Go
