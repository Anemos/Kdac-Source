/*
  File Name : sp_pisi_d_tmstrouting_test.SQL
  SYSTEM    : KDAC 통합 생산 정보 시스템
  Procedure Name  : sp_pisi_d_tmstrouting_test
  Description :
        여주전자 서버추가 : 2004.04.19
  Supply    : DAEWOO Information Systems Co., LTD IAS Dept
  Use DataBase  : IPIS2000
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2002.12.31
  Author    : Gary Kim
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

Declare @ls_sourceday   char(10), @ls_sourceday_chg   char(10)

Select  @ls_sourceday = Convert(char(10),  DateAdd(DD,1,GETDATE()), 102)

Select  @ls_sourceday_chg = substring(@ls_sourceday,1,4) + substring(@ls_sourceday,6,2) + substring(@ls_sourceday,9,2)


If Exists (select * From tmisrouting)
  Begin

    -- 대구전장

    exec [ipisele_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'

    insert into [ipisele_svr\ipis].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                         Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant,      rcdvsn,     rcitno,   upper(rcline1),   rcline2,
      rcopno,     substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2),
      substring(rcedto, 1, 4)+'.'+substring(rcedto, 5, 2)+'.'+substring(rcedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = 'D'
    and rcdvsn in ('A')
    and rcitno not in (select distinct itemcode from [ipisele_svr\ipis].ipis.dbo.tmstrouting
          where areacode = 'D' and divisioncode in ('A') )
--                            and   ( @ls_sourceday_chg between rcedfm and rcedto )

    insert into [ipisele_svr\ipis].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                          Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  distinct rcplant,     rcdvsn,     raitno1,    upper(rcline1),   rcline2,
      rcopno,     substring(raedfm, 1, 4)+'.'+substring(raedfm, 5, 2)+'.'+substring(raedfm, 7,2),
      substring(raedto, 1, 4)+'.'+substring(raedto, 5, 2)+'.'+substring(raedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting a, tmisrouting_subitem b
    where rcplant = raplant
    and rcdvsn = radvsn
    and rcitno = raitno
    and rcedto = '99991231'
    and rcplant = 'D'
    and rcdvsn in ('A')
    and raitno1 not in (select distinct itemcode from [ipisele_svr\ipis].ipis.dbo.tmstrouting
          where areacode = 'D' and divisioncode in ('A') )
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )
--    and   ( @ls_sourceday_chg between raedfm and raedto )

    -- 대구기계
    exec [ipismac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    insert into [ipismac_svr\ipis].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                          Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant,      rcdvsn,     rcitno,   upper(rcline1),   rcline2,
      rcopno,     substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2),
      substring(rcedto, 1, 4)+'.'+substring(rcedto, 5, 2)+'.'+substring(rcedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = 'D'
    and rcdvsn in ('M','S')
    and rcitno not in (select distinct itemcode from [ipismac_svr\ipis].ipis.dbo.tmstrouting
          where areacode = 'D' and divisioncode in ('M','S') )
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )


    insert into [ipismac_svr\ipis].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                         Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  distinct rcplant,     rcdvsn,     raitno1,    upper(rcline1),   rcline2,
      rcopno,     substring(raedfm, 1, 4)+'.'+substring(raedfm, 5, 2)+'.'+substring(raedfm, 7,2),
      substring(raedto, 1, 4)+'.'+substring(raedto, 5, 2)+'.'+substring(raedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting a, tmisrouting_subitem b
    where rcplant = raplant
    and rcdvsn = radvsn
    and rcitno = raitno
    and rcedto = '99991231'
    and rcplant = 'D'
    and rcdvsn in ('M','S')
    and raitno1 not in (select distinct itemcode from [ipismac_svr\ipis].ipis.dbo.tmstrouting
          where areacode = 'D' and divisioncode in ('M','S') )
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )
--    and   ( @ls_sourceday_chg between raedfm and raedto )

    -- 진천

    exec [ipisjin_svr].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    insert into [ipisjin_svr].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                         Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant,      rcdvsn,     rcitno,   upper(rcline1),   rcline2,
      rcopno,     substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2),
      substring(rcedto, 1, 4)+'.'+substring(rcedto, 5, 2)+'.'+substring(rcedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = 'J'
    and rcitno not in (select distinct itemcode from [ipisjin_svr].ipis.dbo.tmstrouting
          where areacode = 'J')
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )


    insert into [ipisjin_svr].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                          Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  distinct rcplant,     rcdvsn,     raitno1,    upper(rcline1),   rcline2,
      rcopno,     substring(raedfm, 1, 4)+'.'+substring(raedfm, 5, 2)+'.'+substring(raedfm, 7,2),
      substring(raedto, 1, 4)+'.'+substring(raedto, 5, 2)+'.'+substring(raedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting a, tmisrouting_subitem b
    where rcplant = raplant
    and rcdvsn = radvsn
    and rcitno = raitno
    and rcedto = '99991231'
    and rcplant = 'J'
    and raitno1 not in (select distinct itemcode from [ipisjin_svr].ipis.dbo.tmstrouting
          where areacode = 'J')
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )
--    and   ( @ls_sourceday_chg between raedfm and raedto )



  -- 대구공조

    exec [ipishvac_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    insert into [ipishvac_svr\ipis].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                         Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant,      rcdvsn,     rcitno,   upper(rcline1),   rcline2,
      rcopno,     substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2),
      substring(rcedto, 1, 4)+'.'+substring(rcedto, 5, 2)+'.'+substring(rcedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = 'D'
    and rcdvsn in ('H','V')
    and rcitno not in (select distinct itemcode from [ipishvac_svr\ipis].ipis.dbo.tmstrouting
          where areacode = 'D' and divisioncode in ('H','V') )
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )


    insert into [ipishvac_svr\ipis].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                         Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  distinct rcplant,     rcdvsn,     raitno1,    upper(rcline1),   rcline2,
      rcopno,     substring(raedfm, 1, 4)+'.'+substring(raedfm, 5, 2)+'.'+substring(raedfm, 7,2),
      substring(raedto, 1, 4)+'.'+substring(raedto, 5, 2)+'.'+substring(raedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting a, tmisrouting_subitem b
    where rcplant = raplant
    and rcdvsn = radvsn
    and rcitno = raitno
    and rcedto = '99991231'
    and rcplant = 'D'
    and rcdvsn in ('H','V')
    and raitno1 not in (select distinct itemcode from [ipishvac_svr\ipis].ipis.dbo.tmstrouting
          where areacode = 'D' and divisioncode in ('H','V') )
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )
--    and   ( @ls_sourceday_chg between raedfm and raedto )

    -- 여주전자

    exec [ipisyeo_svr\ipis].ipis.dbo.sp_pisi_truncate_table 'tmstrouting'
    insert into [ipisyeo_svr\ipis].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                          Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  rcplant,      rcdvsn,     rcitno,   upper(rcline1),   rcline2,
      rcopno,     substring(rcedfm, 1, 4)+'.'+substring(rcedfm, 5, 2)+'.'+substring(rcedfm, 7,2),
      substring(rcedto, 1, 4)+'.'+substring(rcedto, 5, 2)+'.'+substring(rcedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting
    where rcplant = 'Y'
    and rcdvsn = 'Y'
    and rcitno not in (select distinct itemcode from [ipisyeo_svr\ipis].ipis.dbo.tmstrouting
          where areacode = 'Y' and divisioncode = 'Y' )
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )


    insert into [ipisyeo_svr\ipis].ipis.dbo.tmstrouting
      (AreaCode,    DivisionCode,     ItemCode, SubLineCode,  SubLineNo,
      ProcessNo,    ApplyDate,                         Enddate,
      ProcessName,    ProcessSeq,   WorkCenter, GradeGubun, MCGubun,
      BaseMCWorkTime, BaseManualWorkTime, BaseWorkTime, SideGubun,
      SideMCWorkTime, SideManualWorkTime, EmpCount, LastEmp)
    select  distinct rcplant,     rcdvsn,     raitno1,    upper(rcline1),   rcline2,
      rcopno,     substring(raedfm, 1, 4)+'.'+substring(raedfm, 5, 2)+'.'+substring(raedfm, 7,2),
      substring(raedto, 1, 4)+'.'+substring(raedto, 5, 2)+'.'+substring(raedto, 7,2),
      ltrim(rtrim(rcopnm)),     rcopsq,     rcline3,    rcgrde,   rcmcyn,
      rcbmtm,     rcbltm,     rcbstm,   rcnvcd,
      rcnvmc,     rcnvlb,     rclbcnt,    'SYSTEM'
    from  tmisrouting a, tmisrouting_subitem b
    where rcplant = raplant
    and rcdvsn = radvsn
    and rcitno = raitno
    and rcedto = '99991231'
    and rcplant = 'Y'
    and rcdvsn = 'Y'
    and raitno1 not in (select distinct itemcode from [ipisyeo_svr\ipis].ipis.dbo.tmstrouting
          where areacode = 'Y' and divisioncode = 'Y' )
--    and   ( @ls_sourceday_chg between rcedfm and rcedto )
--    and   ( @ls_sourceday_chg between raedfm and raedto )

    Truncate Table  Tmisrouting
    Truncate Table  Tmisrouting_subitem
  End
End   -- Procedure End
