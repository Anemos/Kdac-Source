SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism060i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism060i_01]
GO







/************************************/
/*     조별 종합효율 및 LPI 조회    */
/************************************/

CREATE PROCEDURE sp_pism060i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_stMonth	Char(7)			-- 기준년월
AS
BEGIN

Declare @lastYear	char(4) 

Set @lastYear = Cast ( Cast( substring(@ps_stMonth, 1, 4) as Numeric(4) ) - 1 as Char(4) )

SELECT	A.AreaCode,   
	A.DivisionCode,   
	A.WorkCenter,   
	F.WorkCenterName, 
	A.sMonth,   
	totInMH 		=	IsNull(A.totInMH,0),   
	ActMH 		= 	IsNull(A.ActMH,0),    
	BasicMH 	= 	IsNull(A.BasicMH,0), 
	tar_totInMH 	=	IsNull(B.totInMH,0), 
	tar_ActMH 	= 	IsNull(B.ActMH,0),    
	tar_BasicMH 	= 	IsNull(B.basicMH,0),    
	tarLPI 		= 	IsNull(B.tarLPI,0), 
	divtarLPI 	= 	IsNull(G.tarLPI,0), 
	E.lsty_stMH,
	ActInMH 		= 	IsNull(A.ActInMH,0) 
FROM	TMHMONTH_S A,	TMHVALUETARGET B,	TMHDIVVALUETARGET G, 
	(SELECT C.WorkCenter,
		round(sum( IsNull(CASE SUBSTRING(@ps_stMonth,6,2) 
				 	WHEN '01' THEN D.STMH01
				 	WHEN '02' THEN D.STMH02
				 	WHEN '03' THEN D.STMH03
				 	WHEN '04' THEN D.STMH04
				 	WHEN '05' THEN D.STMH05
				 	WHEN '06' THEN D.STMH06
				 	WHEN '07' THEN D.STMH07
				 	WHEN '08' THEN D.STMH08
				 	WHEN '09' THEN D.STMH09
				 	WHEN '10' THEN D.STMH10
				 	WHEN '11' THEN D.STMH11
				 	WHEN '12' THEN D.STMH12 END,0) * IsNull(C.pQty,0) ), 5 ) lsty_stMH
	 FROM 	TMHMONTHPRODLINE_S C,	tmhstandard D 
	 WHERE	( C.AreaCode = D.AreaCode ) and  
		( C.DivisionCode = D.DivisionCode ) and  
		( C.WorkCenter = D.WorkCenter ) and  
		( C.ItemCode = D.ItemCode ) and  
		( C.subLineCode = D.subLineCode ) And 
		( C.subLineNo = D.subLineNo ) And 
		( ( D.stYear = @lastYear ) And 
		( C.AreaCode = @ps_area ) And 
		( C.DivisionCode = @ps_div ) And 
		( C.sMonth = @ps_stMonth ) ) 
	 Group By C.WorkCenter ) E,	TMSTWORKCENTER F  
WHERE 	( A.AreaCode = B.AreaCode ) and  
	( A.DivisionCode = B.DivisionCode ) and  
	( A.AreaCode = G.AreaCode ) and  
	( A.DivisionCode = G.DivisionCode ) and  
	( A.WorkCenter = B.WorkCenter ) and  
	( A.WorkCenter = E.WorkCenter ) And 
	( A.AreaCode = F.Areacode ) And 
	( A.DivisionCode = F.DivisionCode ) And 
	( A.WorkCenter = F.WorkCenter ) And 
	( A.sMonth = B.tarMonth ) and 
	( A.sMonth = G.tarMonth ) and   
	( ( A.AreaCode = @ps_area ) And 
	( A.DivisionCode = @ps_div ) And 
	( A.sMonth = @ps_stMonth ) ) 

END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

