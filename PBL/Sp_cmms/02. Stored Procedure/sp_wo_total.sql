/*
  file name : sp_wo_total.sql
  system    : cmms system
  procedure name  : sp_wo_total
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_wo_total]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_wo_total]
go

-- 정비현황분석 리포트
-- exec sp_wo_total 17, @Area_Code, @Factory_Code, '2003-10-01','2003-10-17'

create PROCEDURE [dbo].[sp_wo_total]
@Wo_Day   int,
@Area_Code    varchar(1),
@Factory_Code   varchar(1),
@Equip_Div    varchar(1),
@Start_Date varchar(10),
@End_Date varchar(10)



AS
BEGIN


Select Z.Cc_Code, isnull(Y.Cc_Name, W.comp_name) as Cc_Name, X.Equip_Code, X.Equip_Name, Z.Equip_Count,
    Z.Max_Firm_Time, Z.Area_Code, Z.Factory_Code
    Into #Temp_CC
  From (
    Select A.Cc_Code, A.Area_Code, A.Factory_Code, C.Equip_Count,
        Max((isnull(b.Wo_Firm_Time_Hour,0) *60 + isnull(b.Wo_Firm_Time_Minute,0))) as Max_Firm_Time
    From Equip_Master A, Wo_Hist B,
      (Select Cc_Code, count(Equip_code) As Equip_Count
       From Equip_Master
       Where Area_Code = @Area_Code And Factory_Code=@Factory_Code And Equip_Div_Code=@Equip_Div
       Group By CC_Code) C
    Where A.area_code = B.area_code and A.factory_code = B.factory_code
        And A.Area_Code=@Area_Code And A.Factory_Code=@Factory_Code
        And A.Equip_Div_Code=@Equip_Div And B.Wo_Code like '%B%'
        And  Convert(varchar(10),B.Wo_Float_Date,120) between @Start_Date And @End_Date
        And A.CC_Code = C.CC_Code And A.Equip_Code *= b.Equip_Code
    Group by A.Cc_Code, A.Area_Code, A.Factory_Code, C.Equip_Count ) Z,

      ( Select A.Cc_Code, A.Equip_Code, Equip_Name,
          Max((isnull(b.Wo_Firm_Time_Hour,0) *60 + isnull(b.Wo_Firm_Time_Minute,0))) as Max_Firm_Time,
          A.Area_Code, A.Factory_Code
      From Equip_Master A, Wo_Hist B
        Where A.area_code = B.area_code and A.factory_code = B.factory_code
        And A.Area_Code=@Area_Code And A.Factory_Code=@Factory_Code
        And A.Equip_Div_Code=@Equip_Div And B.Wo_Code like '%B%'
        And  Convert(varchar(10),b.Wo_Float_Date,120) between @Start_Date And @End_Date
        And A.Equip_Code = b.Equip_Code
         Group by A.Cc_Code,A.Equip_Code, A.Equip_Name, A.Area_Code, A.Factory_Code) X,

  Cc_Master Y, Comp_Master W

Where Z.Cc_Code *= X.Cc_Code And Z.Max_Firm_Time *= X.Max_Firm_Time
    And Z.Area_Code = Y.Area_Code And Z.Factory_Code = Y.Factory_Code
    And Z.Cc_Code *= Y.Cc_Code And Z.Cc_Code *= W.Comp_Code

select Z.Cc_Code, Z.Cc_Name, Z.Equip_Count,
    Convert(varchar(30),isnull(@Wo_Day * 1170 * Z.Equip_Count / 60,0))
     +':'+Convert(varchar(30),isnull(@Wo_Day*1170*Z.Equip_Count%60,0)) as work_time,
    Convert(varchar(30),Convert(int,isnull(X.Firm_Time,0))/60)
     +':'+Convert(varchar(30),Convert(int,isnull(X.Firm_Time,0))%60)as Firm_Time,
    Convert(varchar(30),Convert(int,isnull(X.Wo_Time,0))/60)
     +':'+Convert(varchar(30),Convert(int,isnull(X.Wo_Time,0))%60)as Wo_Time,
    IsNull(X.Wo_Count, 0) as Wo_Count,
    Convert(varchar(30),Convert(int,isnull( (@Wo_Day*19.5*Z.Equip_Count*60 - X.Firm_Time)/X.Wo_Count , 0))/60)
     +':'+Convert(varchar(30),Convert(int,isnull( (@Wo_Day*19.5*Z.Equip_Count*60 - X.Firm_Time)/X.Wo_Count , 0))%60) as mtbf,
    Convert(varchar(30),Convert(int,isnull(X.Firm_Time/X.Wo_Count,0))/60)
     +':'+Convert(varchar(30),Convert(int,isnull(X.Firm_Time/X.Wo_Count,0))%60) as mttr1,
    Convert(varchar(30),Convert(int,isnull(X.Wo_Time/X.Wo_Count,0))/60)
     +':'+Convert(varchar(30),Convert(int,isnull(X.Wo_Time/X.Wo_Count,0))%60) as mttr2,
    Z.Equip_Code,
    Z.Equip_Name,
    Convert(varchar(30),Convert(int,isnull(Z.Max_Firm_Time,0))/60)
     +':'+Convert(varchar(30),Convert(int,isnull(Z.Max_Firm_Time,0))%60)as Firm_Time2,
    Convert(int,isnull(@Wo_Day*1170 * Z.Equip_Count / 60 ,0)) as aaa,
    Convert(int,isnull(@Wo_Day*1170 * Z.Equip_Count % 60 ,0)) as bbb,
    Convert(int,isnull(X.Firm_Time, 0))/60  as ccc,
    Convert(int,isnull(X.Firm_Time, 0))%60  as ddd,
    Convert(int,isnull(X.Wo_Time, 0))/60 as eee,
    Convert(int,isnull(X.Wo_Time, 0))%60 as fff,
    'Y' as chkflag
From #Temp_CC Z,

  (select A.Cc_Code, sum(b.Wo_Firm_Time_Hour)*60+sum(b.Wo_Firm_Time_Minute) as Firm_Time,
        sum(b.Wo_Time_hour)*60+sum(b.Wo_Time_minute) as Wo_Time,
        count(b.Wo_Code) as Wo_Count
      From Equip_Master A, Wo_Hist B
   Where A.area_code = B.area_code and A.factory_code = B.factory_code
      And A.Area_Code=@Area_Code And A.Factory_Code=@Factory_Code
      And A.equip_div_code=@Equip_Div And B.Wo_Code like '%B%'
      And Convert(varchar(10),B.Wo_Float_Date,120) between @Start_Date And @End_Date
      And A.Equip_Code = B.Equip_Code
   Group by a.Cc_Code) X
Where Z.Cc_Code *= X.Cc_Code

DROP TABLE #Temp_CC


END