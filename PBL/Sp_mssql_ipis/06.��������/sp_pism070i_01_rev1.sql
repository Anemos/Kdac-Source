USE [IPIS]
GO
/****** Object:  StoredProcedure [dbo].[sp_pism070i_01_rev1]    Script Date: 05/04/2012 10:39:36 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO









/************************************/
/*     조별 부하 및 잔업율 조회     */
/************************************/

ALTER	    PROCEDURE [dbo].[sp_pism070i_01_rev1]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_Fromdate	Char(10),	-- From 일
	@ps_Todate	Char(10)		-- To     일
AS
BEGIN

  SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         D.WorkCenterName,   
         A.totMH,   
         IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) jungsiMH, 
         IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) etcMH, 
         IsNull(A.gunteMH,0) gunteMH, 
         IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) excpaidMH, 
--      IsNull(A.bugaMH,0) + IsNull(P.S78MH,0) bugaMH, 
         IsNull(A.bugaMH,0) bugaMH, 
         0 S4MH,
--          IsNull(E.S4MH,0) S4MH, 
         IsNull(F.F67MH,0) F67MH, 
	 IsNull(I.tarqtyMH,0) tarqtyMH 
    FROM ( select  areacode,divisioncode,workcenter,sum(totmh) totmh ,sum(jungsimh) jungsimh,
		sum(psuppmh) psuppmh ,sum(msuppmh) msuppmh ,sum(etcmh) etcmh ,sum(etcpsuppmh) etcpsuppmh,
		sum(etcmsuppmh) etcmsuppmh ,sum(guntemh) guntemh ,sum(excunpaidmh) excunpaidmh ,sum(excpaidmh) excpaidmh,
		sum(bugamh) bugamh from tmhdaily 
		where 	( workday between @ps_fromdate and @ps_todate ) and
			( AreaCode 	= @ps_area ) And 
		    	( DivisionCode 	= @ps_div )
		group by areacode,divisioncode,workcenter ) A,
-- 	 ( Select B.WorkCenter, sum(IsNull(B.subMH,0)) S4MH 
-- 	     From TMHDAILYSTATUS A, TMHDAILYDETAIL B 
-- 	    Where ( A.AreaCode = B.AreaCode ) And 
-- 		  ( A.DivisionCode = B.DivisionCode ) And 
-- 		  ( A.WorkCenter = B.WorkCenter ) And 
-- 		  ( A.WorkDay = B.WorkDay ) And 
-- 		  ( ( B.AreaCode = @ps_area ) And 
-- 		    ( B.DivisionCode = @ps_div ) And 	
-- 		    ( B.WorkDay between @ps_fromdate and @ps_todate ) And 
-- 		    ( ( B.mhGubun = 'S' ) AND ( B.mhCode = 'S4' ) ) And 
-- 		    ( A.DailyStatus = '1' ) ) 
-- 	 Group By B.WorkCenter ) E, 
-- 	( Select C.WorkCenter, sum(IsNull(C.subMH,0)) S78MH 
-- 	    From TMHDAILYSTATUS A, TMHDAILYDETAIL C 
-- 	   Where ( A.AreaCode = C.AreaCode ) And 
-- 		 ( A.DivisionCode = C.DivisionCode ) And 
-- 		 ( A.WorkCenter = C.WorkCenter ) And 
-- 		 ( A.WorkDay = C.WorkDay ) And 
-- 		 ( ( C.AreaCode = @ps_area ) And 
-- 		   ( C.DivisionCode = @ps_div ) And 
-- 	   	   ( C.WorkDay between @ps_fromdate and @ps_todate ) And 
-- 		   ( ( C.mhGubun = 'S' ) AND ( C.mhCode in ( 'S7', 'S8' ) ) ) And 
-- 		   ( A.DailyStatus = '1' ) ) 
-- 	 Group By C.workCenter ) P, 
	( Select C.WorkCenter, sum(IsNull(C.subMH,0)) F67MH 
	    From TMHDAILYSTATUS A, TMHDAILYSUB C 
	   Where ( A.AreaCode = C.AreaCode ) And 
		 ( A.DivisionCode = C.DivisionCode ) And 
		 ( A.WorkCenter = C.WorkCenter ) And 
		 ( A.WorkDay = C.WorkDay ) And 
		 ( ( C.AreaCode = @ps_area ) And 
		   ( C.DivisionCode = @ps_div ) And 
		   ( C.WorkDay between @ps_fromdate and @ps_todate ) And 
		   ( ( C.mhGubun = 'F' ) AND ( C.mhCode in ( 'F6', 'F7' ) ) ) And 
		   ( A.DailyStatus = '1' ) ) 
	 Group By C.workCenter ) F, 
	 ( SELECT G.WorkCenter, round( sum(IsNull(G.pQty,0) * IsNull(H.tarMH,0)), 5 ) tarqtyMH 
	     FROM ( select areacode,divisioncode,workcenter,itemcode,sublinecode,sublineno,
			substring(workday,1,7) workmonth,sum(isnull(daypqty,0) + isnull(nightpqty,0)) pqty from tmhrealprod
			where	( AreaCode 		= @ps_area ) AND  
				( DivisionCode 		= @ps_div ) AND  
				( workday 		between @ps_fromdate and @ps_todate  ) 
			group by areacode,divisioncode,workcenter,itemcode,sublinecode,sublineno,substring(workday,1,7) ) G,
		  TMHMONTHTARGET H  
 	    WHERE ( G.AreaCode 		= H.AreaCode ) and  
		  ( G.DivisionCode 	= H.DivisionCode ) and  
		  ( G.WorkCenter 		= H.WorkCenter ) and  
		  ( G.ItemCode 		= H.ItemCode ) and  
		  ( G.subLineCode 	= H.subLineCode ) And 
		  ( G.subLineNo 		= H.subLineNo ) And 
		  ( G.workmonth 		= H.tarMonth ) 
	 Group By G.WorkCenter ) I, 
         TMSTWORKCENTER D 
   WHERE -- ( A.WorkCenter *= E.WorkCenter ) and  
         ( A.WorkCenter *= F.WorkCenter ) and  
	 ( A.WorkCenter *= I.WorkCenter ) And 
         ( A.AreaCode = D.AreaCode ) and  
         ( A.DivisionCode = D.DivisionCode ) and  
         ( A.WorkCenter = D.WorkCenter ) --and  
--	( A.WorkCenter *= P.WorkCenter )  
--	and 	
--	 ( ( A.AreaCode = @ps_area ) And 
--	   ( A.DivisionCode = @ps_div ) And 
--	   ( A.sMonth = @ps_stMonth ) )  

END










