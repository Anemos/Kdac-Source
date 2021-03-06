SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism130i_01_all]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism130i_01_all]
GO

/*
Execute sp_pism130i_01_all
  @ps_stFromDate  = '2012.08.01',
  @ps_stToDate  = '2012.08.08',
  @ps_retGubun  = '1'

*/

/*****************************/
/*   전공장  조별 공수투입 현황    */
/*****************************/

CREATE PROCEDURE [dbo].[sp_pism130i_01_all]
  @ps_stFromDate  Char(10),   -- 기준일From
  @ps_stToDate  Char(10),   -- 기준일To
  @ps_retGubun  Char(1)
AS
BEGIN
  
  Create Table #Temp_dispName_all
  ( AreaCode Char(1) not null,
    DivisionCode Char(1) not null,
    WorkCenter   VarChar(5) not null,
    WorkCenterName VarChar(30)  null,
    Seq1    int,
    Seq2    int   null,
    dispLevel Char(1),
    dispName  VarChar(100)  null,
    dispMH  Numeric(8,1)  null,
    dispRate  Numeric(5,1)  null )
  
  Create Table #Temp_dispName_each
  ( WorkCenter   VarChar(5) not null,
    WorkCenterName VarChar(30)  null,
    Seq1    int,
    Seq2    int   null,
    dispLevel Char(1),
    dispName  VarChar(100)  null,
    dispMH  Numeric(8,1)  null,
    dispRate  Numeric(5,1)  null )

-- 대구전장
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism130i_01 'D','A',@ps_stFromDate,@ps_stToDate,@ps_retGubun
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate )
select 'D','A', WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate
from #Temp_dispName_each

delete from #Temp_dispName_each

-- 대구공조
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism130i_01 'D','H',@ps_stFromDate,@ps_stToDate,@ps_retGubun
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate )
select 'D','H', WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate
from #Temp_dispName_each

delete from #Temp_dispName_each

-- 대구제동
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism130i_01 'D','M',@ps_stFromDate,@ps_stToDate,@ps_retGubun
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate )
select 'D','M', WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate
from #Temp_dispName_each

delete from #Temp_dispName_each

-- 대구조향
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism130i_01 'D','S',@ps_stFromDate,@ps_stToDate,@ps_retGubun
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate )
select 'D','S', WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate
from #Temp_dispName_each

delete from #Temp_dispName_each

-- 대구압축
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism130i_01 'D','V',@ps_stFromDate,@ps_stToDate,@ps_retGubun
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate )
select 'D','V', WorkCenter,
 WorkCenterName, Seq1, Seq2, dispLevel, dispName, dispMH, dispRate
from #Temp_dispName_each

Select * From #Temp_dispName_all Order By WorkCenter, Seq1, Seq2

Drop Table #Temp_dispName_all
Drop Table #Temp_dispName_each
END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

