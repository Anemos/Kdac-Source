/*
  File Name : sp_pisi_d_tmstrouting.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisi_d_tmstrouting
  Description :
        여주전자 서버추가 : 2004.04.19
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2009.03.31
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisi_d_tmstrouting]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisi_d_tmstrouting]
GO

/*
Execute sp_pisi_d_tmstrouting
*/

Create Procedure sp_pisi_d_tmstrouting

As
Begin

set xact_abort off

Declare @ls_sourceday  char(10), @ls_sourceday_chg  char(10)
Declare @ls_rcitno varchar(15), @ls_lastdate char(8), @ls_chkdate char(8)
Declare @ls_plant char(1), @ls_dvsn char(1), @ls_nextdate char(8)
Select  @ls_sourceday = Convert(char(10),  DateAdd(DD,1,GETDATE()), 102)
Select  @ls_sourceday_chg = substring(@ls_sourceday,1,4) + substring(@ls_sourceday,6,2) + substring(@ls_sourceday,9,2)


If Exists (select * From tmisrouting)
  Begin
    -- set 대구전장공장 plant,dvsn
    select @ls_plant = 'D', @ls_dvsn = 'A'
    exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    -- main routing
    insert into [ipisele_svr\ipis].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_ele
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_ele
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_ele
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipisele_svr\ipis].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_ele

    -- set 대구조향공장 plant,dvsn
    select @ls_plant = 'D', @ls_dvsn = 'S'
    exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    -- main routing
    insert into [ipismac_svr\ipis].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_saw
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_saw
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_saw
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipismac_svr\ipis].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_saw

    -- set 대구제동공장 plant,dvsn
    select @ls_plant = 'D', @ls_dvsn = 'M'
    -- main routing
    insert into [ipismac_svr\ipis].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_mor
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_mor
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_mor
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipismac_svr\ipis].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_mor

    -- set 대구공조공장 plant,dvsn
    select @ls_plant = 'D', @ls_dvsn = 'H'
    exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    -- main routing
    insert into [ipishvac_svr\ipis].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_hvc
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_hvc
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_hvc
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipishvac_svr\ipis].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_hvc

    -- set 대구압축공장 plant,dvsn
    select @ls_plant = 'D', @ls_dvsn = 'V'
    -- main routing
    insert into [ipishvac_svr\ipis].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_vac
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_vac
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_vac
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipishvac_svr\ipis].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_vac

    -- set 진천조향공장 plant,dvsn
    select @ls_plant = 'J', @ls_dvsn = 'S'
    exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    -- main routing
    insert into [ipisjin_svr].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_jsaw
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_jsaw
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_jsaw
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipisjin_svr].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_jsaw

    -- set 진천제동공장 plant,dvsn
    select @ls_plant = 'J', @ls_dvsn = 'M'
    -- main routing
    insert into [ipisjin_svr].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_jmor
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_jmor
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_jmor
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipisjin_svr].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_jmor

    -- set 진천공조공장 plant,dvsn
    select @ls_plant = 'J', @ls_dvsn = 'H'
    -- main routing
    insert into [ipisjin_svr].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_jhvc
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_jhvc
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_jhvc
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipisjin_svr].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_jhvc

    -- set 여주공장 plant,dvsn
    select @ls_plant = 'Y', @ls_dvsn = 'Y'
    exec [ipisyeo_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    -- main routing
    insert into [ipisyeo_svr\ipis].ipis.dbo.tmstrouting
    (AreaCode, DivisionCode, ItemCode, SubLineCode, SubLineNo,
      ProcessNo, ApplyDate,
      Enddate,
      ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant, rcdvsn, rcitno,  upper(rcline1), rcline2,
      rcopno, convert(char(10),cast(rcedfm as datetime),102),
      convert(char(10),cast(rcedto as datetime),102),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = @ls_plant
    and rcdvsn = @ls_dvsn

    -- sub routing
    select distinct rcitno = a.rcitno, rcedto = a.rcedto into #tmp_master_yeo
    from tmisrouting a
    where a.rcplant = @ls_plant and a.rcdvsn = @ls_dvsn and
      exists ( select * from tmisrouting_subitem b where a.rcitno = b.raitno and a.rcitno <> b.raitno1 )

    select @ls_rcitno = ''
    While @@error = 0
      Begin
        select top 1 @ls_rcitno = rcitno
        from #tmp_master_yeo
        where rcitno > @ls_rcitno
        order by rcitno

        if @@rowcount = 0
          Break

        select @ls_lastdate = '19000101', @ls_nextdate = '19000101'

        While @@error = 0
        Begin
          select top 1 @ls_lastdate = rcedto
          from #tmp_master_yeo
          where rcitno = @ls_rcitno and rcedto > @ls_lastdate
          order by rcedto

          if @@rowcount = 0
            Break
          --유사품번 완료일이 주품번 날짜보다 같거나 적다면 생성뒤에 Break
          --크다면 생성뒤에 Continue

          insert into [ipisyeo_svr\ipis].ipis.dbo.tmstrouting
          (AreaCode, DivisionCode, ItemCode, SubLineCode,  SubLineNo,
           ProcessNo, ApplyDate, Enddate,
           ProcessName, ProcessSeq, WorkCenter, GradeGubun, MCGubun,
           BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
           SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
          select  distinct rcplant, rcdvsn, raitno1, upper(rcline1), rcline2,
           rcopno,  case when ( @ls_nextdate = '19000101' or ( raedfm > @ls_nextdate and raedfm <= @ls_lastdate) ) then
              convert(char(10),cast(raedfm as datetime),102) else convert(char(10),cast(@ls_nextdate as datetime),102) end,
           case when raedto <= @ls_lastdate then
              convert(char(10),cast(raedto as datetime),102) else convert(char(10),cast(@ls_lastdate as datetime),102) end,
           ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
           rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
           rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
          from  tmisrouting a inner join tmisrouting_subitem b
            on a.rcplant = b.raplant and a.rcdvsn = b.radvsn and
              a.rcitno = b.raitno and a.rcedfm <= @ls_lastdate and
              a.rcedto >= @ls_lastdate
          where raedfm <= @ls_lastdate
            and raedto >= @ls_lastdate
            and rcplant = @ls_plant
            and rcdvsn = @ls_dvsn
            and raitno1 <> @ls_rcitno
            and raitno = @ls_rcitno

          if @ls_lastdate <> '99991231'
            select @ls_nextdate = convert(char(10),dateadd(dd,1,cast(@ls_lastdate as datetime)),112)
        End
      End

      drop table #tmp_master_yeo
      truncate table tmisrouting
      truncate table tmisrouting_subitem
  End
End   -- Procedure End
