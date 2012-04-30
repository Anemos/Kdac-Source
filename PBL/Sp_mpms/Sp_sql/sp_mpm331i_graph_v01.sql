/*
  File Name : sp_mpm331i_graph.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm331i_graph
  Description : W/C별 예상 부하현황표
  매월 1일 ~ 말일까지의 W/C별 예상 부하현황에 대한 그래프데이타
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(10), @ps_todt char(10), @ps_daynumber int, @ps_daytime int
  Use Table :
  Initial   : 2004.09
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm331i_graph]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm331i_graph]
GO

/*
Execute sp_mpm331i_graph '2004.09.01', '2004.09.30', 21, 10
*/

Create Procedure sp_mpm331i_graph
  @ps_fromdt    char(10),
  @ps_todt      char(10),
  @ps_daynumber int,
  @ps_daytime   int
As
Begin


--W/C별 인원비율, 장비대수, 가용시간
select wccode = aa.wccode,
  wcname = aa.wcname,
  manratio = aa.manratio,
	machinecnt = (select count(*) from tmachine bb where bb.wccode = aa.wccode ),
	availtime = ( @ps_daynumber * @ps_daytime * aa.manratio * (select count(*) from tmachine bb where bb.wccode = aa.wccode ))
into #avail_tmp
from tworkcenter aa
where aa.wccode <> 'THT'

--W/C별 부하시간
select wccode = aa.wccode,
  loadtime = sum( convert(decimal(8,1), (isnull(aa.StdTime,0) * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0))) / 60 ) )
into #load_tmp
from trouting aa inner join tpartlist bb
  on aa.orderno = bb.orderno and aa.partno = bb.partno
where aa.workstatus <> 'C' and aa.outflag <> 'P' and aa.wccode <> 'THT'
group by aa.wccode

-- 부하율
select wccode = aa.wccode,
  wcname = aa.wcname,
  manratio = aa.manratio,
  machinecnt = aa.machinecnt,
  loadratio = convert(numeric(8,1), (isnull(bb.loadtime,0) / ( case isnull(aa.availtime,0) when 0 then 1 else aa.availtime end )) * 100),
  availtime = isnull(aa.availtime,0),
  loadtime = isnull(bb.loadtime,0)
from #avail_tmp aa left outer join #load_tmp bb
  on aa.wccode = bb.wccode
  inner join tworkcenter cc
  on aa.wccode = cc.wccode
order by cc.wcserial

drop table #avail_tmp
drop table #load_tmp

Return

End   -- Procedure End
Go
