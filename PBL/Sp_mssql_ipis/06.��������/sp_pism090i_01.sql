SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism090i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism090i_01]
GO







/*********************************************/ 
/*     월별 종합효율/가동율/작업효율 조회    */ 
/*********************************************/ 

CREATE PROCEDURE [dbo].[sp_pism090i_01]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stYear	Char(4)			-- 기준년도
AS
BEGIN

Declare @Month		int,
	@cvtMonth	Char(2) 

	CREATE TABLE #Temp_Month 
	(
		stMonth		Char(2)		not null 
	)

Set @Month = 1

	WHILE @Month <= 12
	Begin
		Execute sp_pism000_cvtValue @pi_Value = @Month, @ps_cvtValue = @cvtMonth	Output 
		Insert Into #Temp_Month Values ( @cvtMonth ) 
		Set @Month = @Month + 1 
	End 

  SELECT A.stMonth, 
	 IsNull(B.basicMH,0) tar_basicMH,
	 IsNull(B.totInMH,0) tar_totInMH,
	 IsNull(B.ActMH,0)   tar_ActMH,
	 Case IsNull(B.totInMH,0) When 0 Then 0 Else 
	      round( IsNull(B.basicMH,0) / IsNull(B.totInMH,0) * 100, 1 ) End tar_dispValue1, 
	 Case IsNull(B.totInMH,0) When 0 Then 0 Else 
	      round( IsNull(B.ActMH,0) / IsNull(B.totInMH,0) * 100, 1 ) End tar_dispValue2,
	 Case IsNull(B.ActMH,0) When 0 Then 0 Else 
	      round( IsNull(B.basicMH,0) / IsNull(B.ActMH,0) * 100, 1 ) End tar_dispValue3, 
	 IsNull(C.basicMH,0) basicMH,
	 IsNull(C.totInMH,0) totInMH,
	 IsNull(C.ActMH,0)   ActMH,
      	 Case IsNull(C.totInMH,0) When 0 Then 0 Else 
	      round( IsNull(C.basicMH,0) / IsNull(C.totInMH,0) * 100, 1 ) End dispValue1, 
	 Case IsNull(C.totInMH,0) When 0 Then 0 Else 
	      round( IsNull(C.ActMH,0) / IsNull(C.totInMH,0) * 100, 1 ) End dispValue2, 
	 Case IsNull(C.ActMH,0) When 0 Then 0 Else 
	      round( IsNull(C.basicMH,0) / IsNull(C.ActMH,0) * 100, 1 ) End dispValue3 
    FROM #Temp_Month A, 
	( Select substring(tarMonth, 6, 2) tarMonth, 
		 sum(IsNull(totInMH,0)) totInMH, 
		 sum(IsNull(ActMH,0)) ActMH, 
		 sum(IsNull(basicMH,0)) basicMH 
	    From TMHVALUETARGET 
	   Where ( AreaCode = @ps_area ) And 
		 ( DivisionCode = @ps_div ) And 
		 ( WorkCenter like @ps_wc ) And 
		 ( substring(tarMonth, 1, 4) = @ps_stYear ) 
	Group By substring(tarMonth, 6, 2) ) B, 
	( Select substring(sMonth, 6, 2) sMonth, 
		 sum(IsNull(totInMH,0)) totInMH, 
		 sum(IsNull(ActMH,0)) ActMH, 
		 sum(IsNull(BasicMH,0)) BasicMH 
	    From TMHMONTH_S 
	   Where ( AreaCode = @ps_area ) And 
		 ( DivisionCode = @ps_div ) And 
		 ( WorkCenter like @ps_wc ) And 
		 ( substring(sMonth, 1, 4) = @ps_stYear ) 
	Group By substring(sMonth, 6, 2) ) C 
   WHERE ( A.stMonth *= B.tarMonth ) And 
	 ( A.stMonth *= C.sMonth )  

Drop Table #Temp_Month

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

