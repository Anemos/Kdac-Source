/*
  File Name : sp_mpm331i_01.SQL
  SYSTEM    : 금형공정관리시스템
  View Name  : sp_mpm331i_01
  Description : W/C별 예상 부하현황표
  Supply    :
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_fromdt char(10), @ps_todt char(10), @ps_daynumber int, @ps_daytime int
  Use Table :
  Initial   : 2005.04
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm331i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm331i_01]
GO

/*
Execute sp_mpm331i_01 '2004.09.01', '2004.09.30', 21, 10
*/

Create Procedure sp_mpm331i_01
  @ps_fromdt    char(10),
  @ps_todt      char(10),
  @ps_daynumber int,
  @ps_daytime   int

As
Begin

Select wccode = aa.wccode,
  gubun = '1. 인원',
  applydata = aa.manratio
from tworkcenter aa
where aa.wccode <> 'THT'

Union all

Select wccode = aa.wccode,
  gubun = '2. 장비수',
  applydata = (select count(*) from tmachine bb where bb.wccode = aa.wccode )
from tworkcenter aa
where aa.wccode <> 'THT'

Union all

Select wccode = aa.wccode,
  gubun = '3. 가용시간',
  applydata = ( @ps_daynumber * @ps_daytime * aa.manratio * (select count(*) from tmachine bb where bb.wccode = aa.wccode ))
from tworkcenter aa
where aa.wccode <> 'THT'

Union all

Select wccode = aa.wccode,
  gubun = '4. 부하시간',
  applydata = sum( convert(decimal(8,1), (isnull(aa.StdTime,0) * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0))) / 60 ) )
from trouting aa inner join tpartlist bb
  on aa.orderno = bb.orderno and aa.partno = bb.partno
where aa.workstatus <> 'C' and aa.outflag <> 'P' and aa.wccode <> 'THT'
group by aa.wccode

Union all

Select wccode = avail_tmp.wccode,
  gubun = '5. 부하율(%)',
  applydata = convert(numeric(8,1), (load_tmp.loadtime / ( case avail_tmp.availtime when 0 then 1 else avail_tmp.availtime end )) * 100)
from ( Select wccode = aa.wccode,
        wcname = aa.wcname,
        manratio = aa.manratio,
        machinecnt = (select count(*) from tmachine bb where bb.wccode = aa.wccode ),
        availtime = ( @ps_daynumber * @ps_daytime * aa.manratio * (select count(*) from tmachine bb where bb.wccode = aa.wccode ))
        from tworkcenter aa
        where aa.wccode <> 'THT' ) avail_tmp inner join
     ( select wccode = aa.wccode,
        loadtime = sum( convert(decimal(8,1), (isnull(aa.StdTime,0) * (isnull(bb.Qty1,0) + isnull(bb.Qty2,0))) / 60 ) )
        from trouting aa inner join tpartlist bb
          on aa.orderno = bb.orderno and aa.partno = bb.partno
        where aa.workstatus <> 'C' and aa.outflag <> 'P' and aa.wccode <> 'THT'
        group by aa.wccode ) load_tmp
     on avail_tmp.wccode = load_tmp.wccode


End   -- Procedure End
Go
