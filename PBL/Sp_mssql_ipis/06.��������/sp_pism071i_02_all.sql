SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism071i_02_all]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism071i_02_all]
GO

/*
Execute sp_pism071i_02_all
  @ps_stFromDate  = '2012.08.01',
  @ps_stToDate  = '2012.08.08',
  @ps_check = 'Y'

*/

/*****************************/
/*   전공장  표준시간대비 조별 부하 및 잔업율 조회 ( 휴일제외 )    */
/*****************************/

CREATE PROCEDURE [dbo].[sp_pism071i_02_all]
  @ps_stFromDate  Char(10),   -- 기준일From
  @ps_stToDate  Char(10),   -- 기준일To
  @ps_check char(1)  -- 휴일제외

AS
BEGIN
  
  Create Table #Temp_dispName_all
  ( AreaCode Char(1) not null,
    DivisionCode Char(1) not null,
    WorkCenter   VarChar(5) not null,
    WorkCenterName VarChar(30)  null,
    totMH   Numeric(8,1)  null,
    jungsiMH    Numeric(8,1)   null,
    etcMH    Numeric(8,1)   null,
    gunteMH    Numeric(8,1)   null,
    excpaidMH    Numeric(8,1)   null,
    bugaMH    Numeric(8,1)   null,
    S4MH    Numeric(8,1)   null,
    F67MH    Numeric(8,1)   null,
    tarqtyMH    Numeric(12,5)   null )

-- 대구전장
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism071i_02 'D','A',@ps_stFromDate,@ps_stToDate,@ps_check

-- 대구공조
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism071i_02 'D','H',@ps_stFromDate,@ps_stToDate,@ps_check

-- 대구제동
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism071i_02 'D','M',@ps_stFromDate,@ps_stToDate,@ps_check

-- 대구조향
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism071i_02 'D','S',@ps_stFromDate,@ps_stToDate,@ps_check

-- 대구압축
insert into #Temp_dispName_all
Execute [ipis_daegu].ipis.dbo.sp_pism071i_02 'D','V',@ps_stFromDate,@ps_stToDate,@ps_check

Select * From #Temp_dispName_all Order By AreaCode, DivisionCode, WorkCenter

Drop Table #Temp_dispName_all

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

