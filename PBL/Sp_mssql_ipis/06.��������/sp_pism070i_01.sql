SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism070i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism070i_01]
GO







/************************************/
/*     조별 부하 및 잔업율 조회     */
/************************************/

CREATE PROCEDURE [dbo].[sp_pism070i_01]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_stMonth	Char(7)			-- 기준년월
AS
BEGIN

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         D.WorkCenterName,   
         A.sMonth,   
         A.totMH,   
         IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) jungsiMH, 
         IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) etcMH, 
         IsNull(A.gunteMH,0) gunteMH, 
         IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) excpaidMH, 
         IsNull(A.bugaMH,0) + IsNull(P.S78MH,0) bugaMH, 
         IsNull(E.S4MH,0) S4MH, 
         IsNull(F.F67MH,0) F67MH, 
	 IsNull(I.tarqtyMH,0) tarqtyMH 
    FROM TMHMONTH_S A,   
	 ( Select B.WorkCenter, sum(IsNull(B.subMH,0)) S4MH 
	     From TMHDAILYSTATUS A, TMHDAILYDETAIL B 
	    Where ( A.AreaCode = B.AreaCode ) And 
		  ( A.DivisionCode = B.DivisionCode ) And 
		  ( A.WorkCenter = B.WorkCenter ) And 
		  ( A.WorkDay = B.WorkDay ) And 
		  ( ( B.AreaCode = @ps_area ) And 
		    ( B.DivisionCode = @ps_div ) And 	
		    ( substring(B.WorkDay, 1, 7) = @ps_stMonth ) And 
		    ( ( B.mhGubun = 'S' ) AND ( B.mhCode = 'S4' ) ) And 
		    ( A.DailyStatus = '1' ) ) 
	 Group By B.WorkCenter ) E, 
	( Select C.WorkCenter, sum(IsNull(C.subMH,0)) S78MH 
	    From TMHDAILYSTATUS A, TMHDAILYDETAIL C 
	   Where ( A.AreaCode = C.AreaCode ) And 
		 ( A.DivisionCode = C.DivisionCode ) And 
		 ( A.WorkCenter = C.WorkCenter ) And 
		 ( A.WorkDay = C.WorkDay ) And 
		 ( ( C.AreaCode = @ps_area ) And 
		   ( C.DivisionCode = @ps_div ) And 
		   ( substring(C.WorkDay, 1, 7) = @ps_stMonth ) And 
		   ( ( C.mhGubun = 'S' ) AND ( C.mhCode in ( 'S7', 'S8' ) ) ) And 
		   ( A.DailyStatus = '1' ) ) 
	 Group By C.workCenter ) P, 
	( Select C.WorkCenter, sum(IsNull(C.subMH,0)) F67MH 
	    From TMHDAILYSTATUS A, TMHDAILYSUB C 
	   Where ( A.AreaCode = C.AreaCode ) And 
		 ( A.DivisionCode = C.DivisionCode ) And 
		 ( A.WorkCenter = C.WorkCenter ) And 
		 ( A.WorkDay = C.WorkDay ) And 
		 ( ( C.AreaCode = @ps_area ) And 
		   ( C.DivisionCode = @ps_div ) And 
		   ( substring(C.WorkDay, 1, 7) = @ps_stMonth ) And 
		   ( ( C.mhGubun = 'F' ) AND ( C.mhCode in ( 'F6', 'F7' ) ) ) And 
		   ( A.DailyStatus = '1' ) ) 
	 Group By C.workCenter ) F, 
	 ( SELECT G.WorkCenter, round( sum(IsNull(G.pQty,0) * IsNull(H.tarMH,0)), 5 ) tarqtyMH 
	     FROM TMHMONTHPRODLINE_S G,   
		  TMHMONTHTARGET H  
 	    WHERE ( G.AreaCode = H.AreaCode ) and  
		  ( G.DivisionCode = H.DivisionCode ) and  
		  ( G.WorkCenter = H.WorkCenter ) and  
		  ( G.ItemCode = H.ItemCode ) and  
		  ( G.subLineCode = H.subLineCode ) And 
		  ( G.subLineNo = H.subLineNo ) And 
		  ( G.sMonth = H.tarMonth ) and  
		  ( ( G.AreaCode = @ps_area ) AND  
		    ( G.DivisionCode = @ps_div ) AND  
		    ( G.sMonth = @ps_stMonth ) ) 
	 Group By G.WorkCenter ) I, 
         TMSTWORKCENTER D 
   WHERE ( A.WorkCenter *= E.WorkCenter ) and  
         ( A.WorkCenter *= F.WorkCenter ) and  
	 ( A.WorkCenter *= I.WorkCenter ) And 
         ( A.AreaCode = D.AreaCode ) and  
         ( A.DivisionCode = D.DivisionCode ) and  
         ( A.WorkCenter = D.WorkCenter ) and  
	( A.WorkCenter *= P.WorkCenter ) and 	
	 ( ( A.AreaCode = @ps_area ) And 
	   ( A.DivisionCode = @ps_div ) And 
	   ( A.sMonth = @ps_stMonth ) )  

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

