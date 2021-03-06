SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism111i_02_85]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism111i_02_85]
GO



/***********************************************/ 
/*     표준대비 월별 부하율(/0.85), 잔업율 및 인당 O/T 조회 (휴일제외)   */
/* execute sp_pism111i_02_85 'D','A','%','2012','Y' */
/***********************************************/ 

CREATE PROCEDURE [dbo].[sp_pism111i_02_85]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_wc		VarChar(5),		-- 조
	@ps_stYear	Char(4),			-- 기준년도
	@ps_check Char(1)
	
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
if @ps_check = 'Y'
  BEGIN
  SELECT A.stMonth,
	(IsNull(E.tarqtyMH,0) + ( IsNull(B.bugaMH,0) - IsNull(D.F67MH,0) )) / 0.85 buha_bunja, 
	IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) --+ IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) buha_bunmo,
	Case IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) -- + IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) When 0 Then 0 Else 
	     round( (( IsNull(E.tarqtyMH,0) + ( IsNull(B.bugaMH,0) - IsNull(D.F67MH,0) ) ) / 0.85) / 
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
	@dept  
   FROM #Temp_Month A, 
 ( select  substring(a.workday,6,2) as sMonth,
    sum(IsNull(a.totMH,0)) totMH, 
    sum(IsNull(a.jungsiMH,0) + ( IsNull(a.psuppmh,0) - IsNull(a.msuppmh,0) )) jungsiMH, 
	  sum(IsNull(a.etcMH,0) + ( IsNull(a.etcpsuppmh,0) - IsNull(a.etcmsuppmh,0) )) etcMH, 
	  sum(IsNull(a.excunpaidMH,0)) excunpaidMH,
	  sum(IsNull(a.excpaidMH,0)) excpaidMH,
	  sum(IsNull(a.gunteMH,0)) gunteMH, 
 	  sum(IsNull(a.ilboMH,0)) ilboMH, 
 	  sum(IsNull(a.bugaMH,0)) bugaMH 
	from tmhdaily a, tcalendarshop b
	where ( a.areacode = b.areacode ) and ( a.divisioncode = b.divisioncode ) and
		    ( a.workday = b.applydate ) and ( b.workgubun = 'W' ) and
			  ( a.AreaCode 	= @ps_area ) And 
		    ( a.DivisionCode 	= @ps_div ) And
		    ( a.WorkCenter like @ps_wc ) And
		    ( substring(a.workday,1,4) = @ps_stYear )
	group by substring(a.workday,6,2) ) B,  
	
  ( Select substring(C.WorkDay, 6, 2) stMonth, sum(IsNull(C.subMH,0)) F67MH 
	  From TMHDAILYSTATUS A, tcalendarshop b, TMHDAILYSUB C 
	  Where ( a.areacode = b.areacode ) and ( a.divisioncode = b.divisioncode ) and
		      ( a.workday = b.applydate ) and ( b.workgubun = 'W' ) and
		      ( A.AreaCode = C.AreaCode ) And 
		      ( A.DivisionCode = C.DivisionCode ) And 
		      ( A.WorkCenter = C.WorkCenter ) And 
		      ( A.WorkDay = C.WorkDay ) And
		      ( C.AreaCode = @ps_area ) And 
		      ( C.DivisionCode = @ps_div ) And 
		      ( C.WorkCenter like @ps_wc ) And
		      ( substring(C.WorkDay, 1, 4) = @ps_stYear ) And 
		      ( ( C.mhGubun = 'F' ) AND ( C.mhCode in ( 'F6', 'F7' ) ) ) And 
		      ( A.DailyStatus = '1' )
	    Group By substring(C.WorkDay, 6, 2)
 
  ) D, 
 
    ( SELECT substring(G.workmonth, 6, 2) sMonth, round( sum(IsNull(G.stdmh,0)), 5 ) tarqtyMH
	     FROM ( select a.areacode as areacode,a.divisioncode as divisioncode,a.workcenter as workcenter,
	        a.itemcode as itemcode,a.sublinecode as sublinecode,a.sublineno as sublineno,
                substring(a.workday,1,7) workmonth,
                sum(isnull(a.daypqty,0) + isnull(a.nightpqty,0)) pqty,
                round( Sum( a.BasicTime * ( IsNull(a.daypQty,0) + IsNull(a.nightpQty,0) ) / 3600 ) , 1) as stdmh
              from tmhrealprod a, tcalendarshop b
              where	( a.areacode = b.areacode ) and ( a.divisioncode = b.divisioncode ) and
		            ( a.workday = b.applydate ) and ( b.workgubun = 'W' ) and
		            ( a.AreaCode 		= @ps_area ) AND  
				        ( a.DivisionCode 		= @ps_div ) AND 
				        ( a.WorkCenter like @ps_wc ) AND 
				        ( substring(a.workday,1,4) = @ps_stYear  ) 
              group by a.areacode,a.divisioncode,a.workcenter,a.itemcode,a.sublinecode,a.sublineno,substring(a.workday,1,7) ) G
	          Group By substring(G.workmonth, 6, 2)
  ) E
  WHERE ( A.stMonth *= B.sMonth ) And  
	 ( A.stMonth *= D.stMonth ) And 
	 ( A.stMonth *= E.sMonth )
  Order By A.stMonth 	
  END
else
  BEGIN
  SELECT A.stMonth,
	(IsNull(E.tarqtyMH,0) + ( IsNull(B.bugaMH,0) - IsNull(D.F67MH,0) )) / 0.85 buha_bunja, 
	IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) --+ IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) buha_bunmo,
	Case IsNull(B.jungsiMH,0) - ( IsNull(B.excunpaidMH,0) + IsNull(B.excpaidMH,0) ) -- + IsNull(C.S4MH,0) 
				- IsNull(B.gunteMH,0) - IsNull(D.F67MH,0) When 0 Then 0 Else 
	     round( (( IsNull(E.tarqtyMH,0) + ( IsNull(B.bugaMH,0) - IsNull(D.F67MH,0) ) ) / 0.85) / 
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
   WHERE ( A.stMonth *= B.sMonth ) And 
	 ( A.stMonth *= D.stMonth ) And 
	 ( A.stMonth *= E.sMonth )
  Order By A.stMonth 	
    
  END
Drop Table #Temp_Month

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

