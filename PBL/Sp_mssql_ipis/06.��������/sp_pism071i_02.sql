SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism071i_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism071i_02]
GO

/*
Execute sp_pism071i_02
  @ps_area = 'D',
  @ps_div = 'A',
  @ps_Fromdate  = '2012.10.01',
  @ps_Todate  = '2012.10.10',
  @ps_check = 'Y'

*/

/************************************/
/*     표준시간대비 조별 부하 및 잔업율 조회 ( 휴일제외 )     */
/************************************/

CREATE PROCEDURE [dbo].[sp_pism071i_02]
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_Fromdate	Char(10),	-- From 일
	@ps_Todate	Char(10),		-- To     일
	@ps_check   Char(1)   -- 휴일제외
AS
BEGIN

if @ps_check = 'Y'
  Begin
    SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         D.WorkCenterName,   
         A.totMH,   
         IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) jungsiMH, 
         IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) etcMH, 
         IsNull(A.gunteMH,0) gunteMH, 
         IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) excpaidMH, 
         IsNull(A.bugaMH,0) bugaMH, 
         0 S4MH,
         IsNull(F.F67MH,0) F67MH, 
	   IsNull(I.tarqtyMH,0) tarqtyMH 
    FROM ( select  a.areacode as areacode,a.divisioncode as divisioncode,a.workcenter as workcenter,
      sum(a.totmh) totmh ,sum(a.jungsimh) jungsimh,
		  sum(a.psuppmh) psuppmh ,sum(a.msuppmh) msuppmh ,sum(a.etcmh) etcmh ,sum(a.etcpsuppmh) etcpsuppmh,
		  sum(a.etcmsuppmh) etcmsuppmh ,sum(a.guntemh) guntemh ,sum(a.excunpaidmh) excunpaidmh ,sum(a.excpaidmh) excpaidmh,
		  sum(a.bugamh) bugamh 
		  from tmhdaily a, tcalendarshop b
		  where ( a.areacode = b.areacode ) and ( a.divisioncode = b.divisioncode ) and
		      ( a.workday = b.applydate ) and ( b.workgubun = 'W' ) and
		      ( a.workday between @ps_fromdate and @ps_todate ) and
			    ( a.AreaCode 	= @ps_area ) And 
		    	( a.DivisionCode 	= @ps_div )
		  group by a.areacode,a.divisioncode,a.workcenter ) A,
	  ( Select C.WorkCenter, sum(IsNull(C.subMH,0)) F67MH 
	    From TMHDAILYSTATUS A, tcalendarshop b, TMHDAILYSUB C 
	    Where ( a.areacode = b.areacode ) and ( a.divisioncode = b.divisioncode ) and
		      ( a.workday = b.applydate ) and ( b.workgubun = 'W' ) and
		      ( A.AreaCode = C.AreaCode ) And 
		      ( A.DivisionCode = C.DivisionCode ) And 
		      ( A.WorkCenter = C.WorkCenter ) And 
		      ( A.WorkDay = C.WorkDay ) And
		      ( C.AreaCode = @ps_area ) And 
		      ( C.DivisionCode = @ps_div ) And 
		      ( C.WorkDay between @ps_fromdate and @ps_todate ) And 
		      ( ( C.mhGubun = 'F' ) AND ( C.mhCode in ( 'F6', 'F7' ) ) ) And 
		      ( A.DailyStatus = '1' )
	    Group By C.workCenter ) F, 
	 ( SELECT G.WorkCenter, round( sum(IsNull(G.stdmh,0)), 5 ) tarqtyMH
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
				        ( a.workday 		between @ps_fromdate and @ps_todate  ) 
              group by a.areacode,a.divisioncode,a.workcenter,a.itemcode,a.sublinecode,a.sublineno,substring(a.workday,1,7) ) G
	          Group By G.WorkCenter ) I, 
         TMSTWORKCENTER D 
   WHERE ( A.WorkCenter *= F.WorkCenter ) and  
	  ( A.WorkCenter *= I.WorkCenter ) And 
    ( A.AreaCode = D.AreaCode ) and  
    ( A.DivisionCode = D.DivisionCode ) and  
    ( A.WorkCenter = D.WorkCenter )
  End
Else
  Begin
    SELECT A.AreaCode,   
         A.DivisionCode,   
         A.WorkCenter,   
         D.WorkCenterName,   
         A.totMH,   
         IsNull(A.jungsiMH,0) + ( IsNull(A.psuppmh,0) - IsNull(A.msuppmh,0) ) jungsiMH, 
         IsNull(A.etcMH,0) + ( IsNull(A.etcpsuppmh,0) - IsNull(A.etcmsuppmh,0) ) etcMH, 
         IsNull(A.gunteMH,0) gunteMH, 
         IsNull(A.excunpaidMH,0) + IsNull(A.excpaidMH,0) excpaidMH, 
         IsNull(A.bugaMH,0) bugaMH, 
         0 S4MH,
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
	 ( SELECT G.WorkCenter, round( sum(IsNull(G.stdmh,0)), 5 ) tarqtyMH
	     FROM ( select areacode,divisioncode,workcenter,itemcode,sublinecode,sublineno,
                substring(workday,1,7) workmonth,
                sum(isnull(daypqty,0) + isnull(nightpqty,0)) pqty,
                round( Sum( BasicTime * ( IsNull(daypQty,0) + IsNull(nightpQty,0) ) / 3600 ) , 1) as stdmh
              from tmhrealprod
              where	( AreaCode 		= @ps_area ) AND  
				        ( DivisionCode 		= @ps_div ) AND  
				        ( workday 		between @ps_fromdate and @ps_todate  ) 
              group by areacode,divisioncode,workcenter,itemcode,sublinecode,sublineno,substring(workday,1,7) ) G
	          Group By G.WorkCenter ) I, 
         TMSTWORKCENTER D 
   WHERE -- ( A.WorkCenter *= E.WorkCenter ) and  
         ( A.WorkCenter *= F.WorkCenter ) and  
	 ( A.WorkCenter *= I.WorkCenter ) And 
         ( A.AreaCode = D.AreaCode ) and  
         ( A.DivisionCode = D.DivisionCode ) and  
         ( A.WorkCenter = D.WorkCenter )
  End

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO


