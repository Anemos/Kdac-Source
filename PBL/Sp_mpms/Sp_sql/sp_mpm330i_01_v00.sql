/*
  File Name : sp_mpm330i_01.SQL
  SYSTEM    : MPMS System
  Procedure Name  : sp_mpm330i_01
  Description : Order별 공정현황표
  Use DataBase  : MPMS
  Use Program :
  Parameter : @ps_orderno char(8) 의뢰번호
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_mpm330i_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_mpm330i_01]
GO

/*
Execute sp_mpm330i_01 '20040005'
*/

Create Procedure sp_mpm330i_01
  @ps_orderno char(8)
As
Begin

declare @li_count int, @li_totcnt int, @li_subtot int, @li_subcnt int
declare @li_detailno int, @li_gubuncnt int
declare @ls_toolname  varchar(100), @ls_duedate varchar(8), @ls_enddate varchar(8)
declare @ls_partno char(6), @ls_operno char(3), @ls_wccode char(3)

CREATE TABLE #oper_tmp (
  [SerialNo]    [int]             NULL,
  [GubunNo]     [int]             NULL,
  [TotalCnt]    [int]             NULL,
  [DetailNo]    [int]             NULL,
  [SheetNo]     [int]             NULL,
  [RevNo]       [char]    (2)     NULL,
  [PartNo]      [char]    (6)     NULL,
  [PartName]    [varchar] (50)    NULL,
  [Spec]        [varchar] (100)   NULL,
  [Material]    [varchar] (20)    NULL,
  [Qty]         [numeric] (5,0)   NULL,
  [StartDt]     [varchar] (8)     NULL,
  [Oper01]      [char]    (3)     NULL,
  [EndDt01]     [varchar] (8)     NULL,
  [Oper02]      [char]    (3)     NULL,
  [EndDt02]     [varchar] (8)     NULL,
  [Oper03]      [char]    (3)     NULL,
  [EndDt03]     [varchar] (8)     NULL,
  [Oper04]      [char]    (3)     NULL,
  [EndDt04]     [varchar] (8)     NULL,
  [Oper05]      [char]    (3)     NULL,
  [EndDt05]     [varchar] (8)     NULL,
  [Oper06]      [char]    (3)     NULL,
  [EndDt06]     [varchar] (8)     NULL,
  [Oper07]      [char]    (3)     NULL,
  [EndDt07]     [varchar] (8)     NULL,
  [Oper08]      [char]    (3)     NULL,
  [EndDt08]     [varchar] (8)     NULL,
  [Oper09]      [char]    (3)     NULL,
  [EndDt09]     [varchar] (8)     NULL,
  [Oper10]      [char]    (3)     NULL,
  [EndDt10]     [varchar] (8)     NULL
   )

select @ls_toolname = ToolName,
  @ls_duedate = convert( char(8), DueDate, 112 )
from torder
where orderno = @ps_orderno

select * into #list_tmp
from tpartlist
where OrderNo = @ps_orderno
order by DetailNo

select @li_count = 0, @li_totcnt = @@rowcount, @li_detailno = -1

while @li_count < @li_totcnt
begin
  select @li_gubuncnt = 0
  select top 1
    @li_count = @li_count + 1,
    @li_detailno  = aa.DetailNo,
    @ls_partno  = aa.PartNo
  from #list_tmp aa
  where aa.OrderNo = @ps_orderno and aa.DetailNo > @li_detailno
  
  --Create Operation Status Table
  insert into #oper_tmp
    select @li_count, @li_gubuncnt, @li_totcnt, aa.DetailNo, aa.SheetNo, aa.RevNo, aa.PartNo,
      aa.PartName, aa.Spec, aa.Material, isnull(aa.Qty1,0) + isnull(aa.Qty2,0),
    bb.maxdt, null, null, null, null, null, null, null, null, null, null, null, null,
    null, null, null, null, null, null, null, null
    from #list_tmp aa left outer join ( select partno, convert(char(8),min(workstart),112) as maxdt
      from trouting
      where orderno = @ps_orderno and partno = @ls_partno
      group by partno ) bb
      on aa.PartNo = bb.PartNo
    where aa.DetailNo = @li_detailno
    
  select operno, wccode into #routing_tmp
  from trouting
  where orderno = @ps_orderno and partno = @ls_partno
  order by operno
  
  select @li_subtot = @@rowcount
  select @li_subcnt = 0
  select @ls_operno = '000'
  while @li_subcnt < @li_subtot
    Begin
      select top 1
        @li_subcnt = @li_subcnt + 1,
        @ls_operno = cc.OperNo,
        @ls_wccode = cc.WcCode,
        @ls_enddate = dd.enddt
      from #routing_tmp cc left outer join ( select operno, max(workdate) as enddt
        from tworkjob
        where orderno = @ps_orderno and partno = @ls_partno
        group by operno ) dd
        on cc.operno = dd.operno
      where cc.OperNo > @ls_operno
      
      if (@li_subcnt % 10) = 1 and @li_subcnt > 9
        Begin
          select @li_gubuncnt = @li_gubuncnt + 1
          
          -- N'th insert row at same partno
          insert into #oper_tmp
            select @li_count, @li_gubuncnt, @li_totcnt, aa.DetailNo, aa.SheetNo, aa.RevNo, aa.PartNo,
              aa.PartName, aa.Spec, aa.Material, isnull(aa.Qty1,0) + isnull(aa.Qty2,0),
              bb.maxdt, null, null, null, null, null, null, null, null, null, null, null, null,
              null, null, null, null, null, null, null, null
            from #list_tmp aa left outer join ( select partno, min(workdate) as maxdt
              from tworkjob
              where orderno = @ps_orderno and partno = @ls_partno
              group by partno ) bb
            on aa.PartNo = bb.PartNo
            where aa.DetailNo = @li_detailno
          
        End
      
      if (@li_subcnt % 10) = 1
        update #oper_tmp
        set oper01 = @ls_wccode, enddt01 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 2
        update #oper_tmp
        set oper02 = @ls_wccode, enddt02 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 3
        update #oper_tmp
        set oper03 = @ls_wccode, enddt03 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 4
        update #oper_tmp
        set oper04 = @ls_wccode, enddt04 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 5
        update #oper_tmp
        set oper05 = @ls_wccode, enddt05 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 6
        update #oper_tmp
        set oper06 = @ls_wccode, enddt06 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 7
        update #oper_tmp
        set oper07 = @ls_wccode, enddt07 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 8
        update #oper_tmp
        set oper08 = @ls_wccode, enddt08 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 9
        update #oper_tmp
        set oper09 = @ls_wccode, enddt09 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
      if (@li_subcnt % 10) = 0
        update #oper_tmp
        set oper10 = @ls_wccode, enddt10 = @ls_enddate
        where partno = @ls_partno and gubunno = @li_gubuncnt
    End
    Drop table #routing_tmp
end

select OrderNo = @ps_orderno,
    ToolName = 'Tool 명: ' + @ls_toolname,
    SerialNo = SerialNo,
    TotalCnt = TotalCnt,
    DetailNo = DetailNo,
    SheetNo = SheetNo,
    PartNo = PartNo,
    PartName = PartName,
    Spec  = Spec,
    Material = Material,
    Qty = Qty,
    StartDt = StartDt,
    Oper01 = Oper01,
    EndDt01 = EndDt01,
    Oper02 = Oper02,
    EndDt02 = EndDt02,
    Oper03 = Oper03,
    EndDt03 = EndDt03,
    Oper04 = Oper04,
    EndDt04 = EndDt04,
    Oper05 = Oper05,
    EndDt05 = EndDt05,
    Oper06 = Oper06,
    EndDt06 = EndDt06,
    Oper07 = Oper07,
    EndDt07 = EndDt07,
    Oper08 = Oper08,
    EndDt08 = EndDt08,
    Oper09 = Oper09,
    EndDt09 = EndDt09,
    Oper10 = Oper10,
    EndDt10 = EndDt10,
    DueDate = @ls_duedate,
    Extd = ' '
    from #oper_tmp
    order by serialno, gubunno

drop table #oper_tmp
drop table #list_tmp

End   -- Procedure End
Go
