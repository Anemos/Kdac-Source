/*
  File Name : sp_mpm331i_create.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm331i_create
  Description : ���������Ȳ ����Ÿ ����
  Use DataBase  : MPMS
  Use Program :
  Parameter :
  Use Table : tmpmcalendar
  Initial   : 2006.06
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm331i_create]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm331i_create]
GO

/*
Execute sp_mpm331i_create
*/

Create Procedure sp_mpm331i_create

As
Begin       -- Procedure Start

Declare @ldt_systemtime   DateTime, -- ���� DATETIME
  @ls_refapplydate   char(10), -- ������ ������� ����
  @ls_applydate   char(10),
  @li_totcnt1     int,
  @li_totcnt2     int,
  @li_totcnt      int,
  @li_cnt         int,
  @li_chkcnt      int,
  @ls_wccode      char(3),
  @li_rtn         int

/*########################################################################################

  �ý��� �ð�

########################################################################################*/

truncate table tloadplan

SELECT  @ldt_systemtime   = GETDATE()

EXEC  sp_mpms_get_applydate
  @ldt_systemtime,
  @ls_refapplydate   output

/*########################################################################################

  �ʱⵥ��Ÿ ó��

########################################################################################*/

select @li_chkcnt = 0
select @ls_applydate = @ls_refapplydate
while @li_chkcnt = 0
  BEGIN
    -- ���� ����ÿ��� �۾����� ����
    SELECT @li_totcnt1 = count(*)
    FROM ( select orderno = cc.orderno,
      partno = cc.partno,
      operno = cc.operno,
      wccode = cc.wccode,
      outflag = cc.outflag,
      stdtime = isnull(cc.stdtime,0),
      workdate = convert(char(10),cc.workstart,102),
      applyqty = isnull(bb.qty1,0) + isnull(bb.qty2,0),
      preworkstatus = isnull(( select top 1 workstatus from trouting
                where orderno = cc.orderno and partno = cc.partno and operno < cc.operno
                order by operno desc ),'C')
      from torder aa inner join tpartlist bb
        on aa.orderno = bb.orderno and aa.ingstatus <> 'C'
        inner join trouting cc
        on bb.orderno = cc.orderno and bb.partno = cc.partno and cc.workstatus <> 'C'
      where not exists( select dd.orderno from tloadplan dd
          where cc.orderno = dd.orderno and cc.partno = dd.partno )
      ) tmp
    WHERE tmp.preworkstatus = 'C'

    -- �۾����� �������� ã��
    SELECT @li_totcnt2 = count(*)
    FROM tpartlist bb inner join trouting cc
      on bb.orderno = cc.orderno and bb.partno = cc.partno
      inner join ( select orderno = bb.orderno,
        partno = bb.partno,
        operno = bb.operno,
        postoperno = ( select top 1 operno from trouting
                where orderno = bb.orderno and partno = bb.partno and operno > bb.operno
                order by operno )
      from trouting bb inner join ( select orderno, partno, max(operno) as operno from tloadplan
        group by orderno, partno )cc
        on bb.orderno = cc.orderno and bb.partno = cc.partno and bb.operno = cc.operno ) tmp
        on cc.orderno = tmp.orderno and cc.partno = tmp.partno and cc.operno = tmp.postoperno
    
    If @li_totcnt1 = 0 and @li_totcnt2 = 0
      BREAK
    
    -- �۾����ں� ������ġ Procedure ȣ��
    SELECT wccode = bb.wccode, 
      stdtime = sum(isnull(aa.stdtime,0)),
      IDENTITY(int, 1,1) as id_num
    into #tmp_routing
    FROM TLOADPLAN aa right outer join TWORKCENTER bb
      ON aa.WcCode = bb.WcCode
    WHERE aa.WorkDate = @ls_applydate or aa.WorkDate is null
    GROUP BY bb.WcCode
    HAVING sum(isnull(aa.stdtime,0)) < 480
    
    select @li_totcnt = @@rowcount
    select @li_cnt = 0

    while @li_cnt <= (@li_totcnt - 1)
      BEGIN
        select top 1 @ls_wccode = wccode
        from #tmp_routing
        where id_num > @li_cnt
        order by id_num
        
        EXEC  sp_mpm331i_create_01
          @ls_applydate,
          @ls_wccode,
          @li_rtn   output
        select @li_cnt = @li_cnt + 1
      END
    
    drop table #tmp_routing
    -- �۾����� ����
    select top 1 @ls_applydate = applydate from tmpmcalendar
    where applydate > @ls_applydate and workgubun = 'W'
    order by applydate

    if @@rowcount = 0 or @ls_applydate = '2006.06.16'
      RETURN
  END

Return

End   -- Procedure End
Go

