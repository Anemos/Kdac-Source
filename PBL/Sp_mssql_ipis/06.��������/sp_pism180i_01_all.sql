SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism180i_01_all]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism180i_01_all]
GO


/*********************************/
/*     인당 OT시간 조회    */
/* exec sp_pism180i_01_all '2012.04.01','2012.04.25'    */
/*********************************/

CREATE PROCEDURE sp_pism180i_01_all
	@ps_stFromDate	Char(10),
  @ps_stToDate	Char(10)
AS
BEGIN

  Create Table #Temp_dispName_all
  ( AreaCode Char(1) not null,
    DivisionCode Char(1) not null,
    WorkCenter   VarChar(5) not null,
    WorkCenterName VarChar(30)  null,
    otTime1 decimal(7,1) null,
    otTime2 decimal(7,1) null,
    otManCnt decimal(7,2) null,
    ExcWCGbn  Char(1)  null,
    etcmSuppMH  decimal(7,1)  null,
    etcpSuppMH  decimal(7,1)  null )
    
  Create Table #Temp_dispName_each
  ( WorkCenter   VarChar(5) not null,
    WorkCenterName VarChar(30)  null,
    otTime1 decimal(7,1) null,
    otTime2 decimal(7,1) null,
    otManCnt decimal(7,2) null,
    ExcWCGbn  Char(1)  null,
    etcmSuppMH  decimal(7,1)  null,
    etcpSuppMH  decimal(7,1)  null )

-- 대구공통
insert into #Temp_dispName_all
SELECT  'X','X', A.DGDEPTE,
B.DEPTNAME,
sum( IsNull(A.DGOTR,0) + IsNull(A.DGJOR,0) + IsNull(A.DGSANGR,0) ) otTime1,
sum( IsNull(A.DGJUHUR,0) ) + Sum( IsNull(A.DGHUMUR,0) ) otTime2,
round( E.otManCnt, 1 ),
'0' ExcWCGbn,
0 etcmSuppMH,
0 etcpSuppMH
FROM [ipis_daegu].ipis.dbo.TMHLABTAC A, [ipis_daegu].ipis.dbo.TMSTDEPT B,
( select dgdepte,CAST(CAST(count(*) AS NUMERIC(5,2))/CAST(count(distinct dgday)
  AS NUMERIC(5,2)) AS NUMERIC(5,2)) as otMancnt From [ipis_daegu].ipis.dbo.tmhlabtac
  where ( dgday between @ps_stFromDate and @ps_stToDate )
  and   ( ISNULL(DGJIKCHEK,' ') NOT IN ( 'A','B','C'))
  group by dgdepte ) e
WHERE ( A.DGDEPTE = B.DeptCode ) and
   ( A.DGDEPTE = E.DGDEPTE ) and
   ( A.DGDAY between @ps_stFromDate and @ps_stToDate ) And
   ( isnull(A.DGJIKCHEK,' ') NOT IN ( 'A','B','C')) And
   ( A.DGDEPTE IN ('2100','2101','2102','4730','4731','4732' ))
Group By  A.DGDEPTE, B.DEPTNAME, E.otManCnt

  -- 대구전장
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism180i_01_rev1 'D','A',@ps_stFromDate,@ps_stToDate
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH )
select 'D','A', WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH
from #Temp_dispName_each

delete from #Temp_dispName_each

-- 대구공조
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism180i_01_rev1 'D','H',@ps_stFromDate,@ps_stToDate
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH )
select 'D','H', WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH
from #Temp_dispName_each

delete from #Temp_dispName_each

-- 대구제동
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism180i_01_rev1 'D','M',@ps_stFromDate,@ps_stToDate
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH )
select 'D','M', WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH
from #Temp_dispName_each

delete from #Temp_dispName_each

-- 대구조향
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism180i_01_rev1 'D','S',@ps_stFromDate,@ps_stToDate
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH )
select 'D','S', WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH
from #Temp_dispName_each

delete from #Temp_dispName_each

-- 대구압축
insert into #Temp_dispName_each
Execute [ipis_daegu].ipis.dbo.sp_pism180i_01_rev1 'D','V',@ps_stFromDate,@ps_stToDate
  
insert into #Temp_dispName_all( AreaCode, DivisionCode, WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH )
select 'D','V', WorkCenter,
 WorkCenterName, otTime1, otTime2, otManCnt, ExcWCGbn, etcmSuppMH, etcpSuppMH
from #Temp_dispName_each

delete from #Temp_dispName_each

Select * From #Temp_dispName_all Order By AreaCode, DivisionCode, WorkCenter

Drop Table #Temp_dispName_all

END
