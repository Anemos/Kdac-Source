SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism111i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism111i_01]
GO








/***********************************************/ 
/*     표준대비 월별 부하율, 잔업율 및 인당 O/T 조회    */ 
/***********************************************/ 

CREATE PROCEDURE [dbo].[sp_pism111i_01]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stYear	Char(4)			-- 기준년도
AS
BEGIN

Declare @Month		int,
	@cvtMonth	Char(2),
	@dept		Char(4) 

	CREATE TABLE #Temp_Month 
	(
		stMonth		Char(2)		not null 
	)

Set @Month = 1 
Set @dept = @ps_wc 

	WHILE @Month <= 12
	Begin
		Execute sp_pism000_cvtValue @pi_Value = @Month, @ps_cvtValue = @cvtMonth	Output 
		Insert Into #Temp_Month Values ( @cvtMonth ) 
		Set @Month = @Month + 1 
	End 

/*************************************************************************************/
/* 부하율(실적) = ( 표준대비소요MH + 총부가작업(물류,개선MH제외) ) / 		     */
/*		  ( 정시MH - 평가제외MH - 유급근태사고MH ) 	     */
/*										     */ 
/* 잔업율(실적) = 정시외MH / ( 정시MH - 평가제외MH - 유급근태사고MH ) */
/*************************************************************************************/

 SELECT A.stMonth,
	IsNull(E.tarqtyMH,0) + ( IsNull(B.bugaMH,0) - IsNull(D.F67MH,0) ) buha_bunja, 
	IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) --+ IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) buha_bunmo,
	Case IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) -- + IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) When 0 Then 0 Else 
	     round( ( IsNull(E.tarqtyMH,0) + ( IsNull(B.bugaMH,0) - IsNull(D.F67MH,0) ) ) / 
	    	    ( IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) -- + IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) ) * 100, 1 ) End buha_rate, 
	IsNull(B.etcMH,0) - IsNull(D.F67MH,0) janup_bunja, 
	IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) -- + IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) janup_bunmo,
	Case IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) -- + IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) When 0 Then 0 Else 
	     round( ( IsNull(B.etcMH,0) - IsNull(D.F67MH,0) ) / 
	            ( IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) -- + IsNull(C.S4MH,0) 
		- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) ) * 100, 1 ) End janup_rate, 
/*
	IsNull(B.etcMH,0) otTime_bunja,
	( ( IsNull(F.first_mh,0) + IsNull(G.last_mh,0) ) / 2 ) otTime_bunmo,
	round( IsNull(B.etcMH,0) / ( ( IsNull(F.first_mh,0) + IsNull(G.last_mh,0) ) / 2 ), 1 ) otTime, */
	@dept  
   FROM #Temp_Month A, 
 ( Select substring(sMonth, 6, 2) sMonth, 
	  sum(IsNull(totMH,0)) totMH, 
          sum(IsNull(jungsiMH,0) + ( IsNull(psuppmh,0) - IsNull(msuppmh,0) )) jungsiMH, 
	  sum(IsNull(etcMH,0) + ( IsNull(etcpsuppmh,0) - IsNull(etcmsuppmh,0) )) etcMH, 
	  sum(IsNull(excunpaidMH,0)) excunpaidMH,
	  sum(IsNull(excpaidMH,0)) excpaidMH,
	  sum(IsNull(gunteMH,0)) gunteMH, 
 	  sum(IsNull(ilboMH,0)) ilboMH, 
 	  sum(IsNull(bugaMH,0)) bugaMH 
     From TMHMONTH_S 
    Where ( Areacode = @ps_area ) And 	
	  ( DivisionCode = @ps_div ) And 
	  ( WorkCenter like @ps_wc ) And 	
	  ( substring(sMonth, 1, 4) = @ps_stYear ) 
 Group By substring(sMonth, 6, 2) ) B, 
--  ( Select substring(A.WorkDay, 6, 2) stMonth, 
-- 	  sum(IsNull(A.subMH,0)) S4MH 
--      From TMHDAILYDETAIL A, TMHDAILYSTATUS B 
--     Where ( A.AreaCode = B.AreaCode ) And 
-- 	  ( A.DivisionCode = B.DivisionCode ) And 
-- 	  ( A.WorkCenter = B.WorkCenter ) And 
-- 	  ( A.WorkDay = B.WorkDay ) And 
-- 	  ( ( A.AreaCode = @ps_area ) And 
-- 	    ( A.DivisionCode = @ps_div ) And 	
-- 	    ( A.WorkCenter like @ps_wc ) And 
-- 	    ( substring(A.WorkDay, 1, 4) = @ps_stYear ) And 
-- 	    ( ( A.mhGubun = 'S' ) AND ( A.mhCode = 'S4' ) ) And 
-- 	    ( B.DailyStatus = '1' ) ) 
--  Group By substring(A.WorkDay, 6, 2) ) C, 
 ( Select substring(A.WorkDay, 6, 2) stMonth, 
	  sum(IsNull(A.subMH,0)) F67MH 
     From TMHDAILYSUB A, TMHDAILYSTATUS B 
    Where ( A.AreaCode = B.AreaCode ) And 
	  ( A.DivisionCode = B.DivisionCode ) And 
	  ( A.WorkCenter = B.WorkCenter ) And 
	  ( A.WorkDay = B.WorkDay ) And 
	  ( ( A.AreaCode = @ps_area ) And 
	    ( A.DivisionCode = @ps_div ) And 
	    ( A.WorkCenter like @ps_wc ) And 
	    ( substring(A.WorkDay, 1, 4) = @ps_stYear ) And 
	    ( ( A.mhGubun = 'F' ) AND ( A.mhCode in ( 'F6', 'F7' ) ) ) And 
	    ( B.DailyStatus = '1' ) ) 
 Group By substring(A.WorkDay, 6, 2) ) D, 
 ( SELECT substring(G.sMonth, 6, 2) sMonth, 
	  sum( G.basicmh ) tarqtyMH 
     FROM TMHMONTHPRODLINE_S G
	    WHERE ( G.AreaCode = @ps_area ) AND  
	    ( G.DivisionCode = @ps_div ) AND  
	    ( G.WorkCenter like @ps_wc ) And 
	    ( substring(G.sMonth, 1, 4) = @ps_stYear ) 
 Group By substring(G.sMonth, 6, 2) ) E  
/* 인당O/T 현황은 근태정보에서 호출하므로 과부하 
, 
 ( SELECT substring(A.DGDAY, 6, 2) stMonth, 
	  sum(IsNull(A.DGTIMER,0) / 8.0) first_mh 
     FROM TMHLABTAC A
    WHERE ( A.DGDEPTE like @ps_wc ) AND  
	  ( substring(A.DGDAY, 1, 4) = @ps_stYear ) And 
	  ( substring(A.DGDAY, 9, 2) = ( Select Min(substring(DGDAY, 9, 2)) 
					   From TMHLABTAC 
					  Where ( DGDEPTE = A.DGDEPTE ) And 
					        ( substring(DGDAY, 1, 7) = substring(A.DGDAY, 1, 7) ) And 
					        ( IsNull(DGTIMER,0) > 0 ) ) ) 
Group By substring(A.DGDAY, 6, 2) ) F, 
( Select substring(B.DGDAY, 6, 2) stMonth, 	
	 sum(IsNull(B.DGTIMER,0) / 8.0) last_mh 
    From TMHLABTAC B 
   Where ( B.DGDEPTE like @ps_wc ) AND  
	 ( substring(B.DGDAY, 1, 4) = @ps_stYear ) And
	 ( substring(B.DGDAY, 9, 2) = ( Select Max(substring(DGDAY, 9, 2)) 
					  From TMHLABTAC 
					 Where ( DGDEPTE = B.DGDEPTE ) And 
					       ( substring(DGDAY, 1, 7) = substring(B.DGDAY, 1, 7) ) And 
					       ( IsNull(DGTIMER,0) > 0 ) ) ) 
Group By substring(B.DGDAY, 6, 2) ) G 
*/
   WHERE ( A.stMonth *= B.sMonth ) And 
--	 ( A.stMonth *= C.stMonth ) And 
	 ( A.stMonth *= D.stMonth ) And 
	 ( A.stMonth *= E.sMonth )
/*And 
	 ( A.stMonth *= F.stMonth ) And 
	 ( A.stMonth *= G.stMonth )*/
Order By A.stMonth 	

Drop Table #Temp_Month

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

