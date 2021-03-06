SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism018i_01_all]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism018i_01_all]
GO


/*********************************/
/*     작업일보 작성현황 조회    */
/* exec sp_pism018i_01_all '2012.04.01','2012.04.25'    */
/*********************************/

CREATE PROCEDURE sp_pism018i_01_all
  @ps_stFromDate  Char(10),   -- 기준일 From
  @ps_stToDate  Char(10)    -- 기준일 To
AS
BEGIN

  Create Table #Temp_dispName_all
  ( AreaCode Char(1) not null,
    DivisionCode Char(1) not null,
    WorkCenter   VarChar(5) not null,
    WorkDay VarChar(10) not null,
    WorkCenterName VarChar(30)  null,
    DailyStatus Char(1) null,
    InputTime datetime null,
    Remark VarChar(100) null,
    InputEmp  VarChar(6)  null,
    EmpName  VarChar(10)  null,
    LastDate  datetime  null )

-- 대구전장
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism018i_01 'D','A','%',@ps_stFromDate,@ps_stToDate

-- 대구공조
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism018i_01 'D','H','%',@ps_stFromDate,@ps_stToDate

-- 대구제동
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism018i_01 'D','M','%',@ps_stFromDate,@ps_stToDate

-- 대구조향
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism018i_01 'D','S','%',@ps_stFromDate,@ps_stToDate

-- 대구압축
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism018i_01 'D','V','%',@ps_stFromDate,@ps_stToDate

Select * From #Temp_dispName_all Order By AreaCode, DivisionCode, WorkCenter, WorkDay

END
