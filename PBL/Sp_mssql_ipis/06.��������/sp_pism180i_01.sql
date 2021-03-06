SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism180i_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism180i_01]
GO







/***************************/ 
/*     인당 OT시간 조회    */ 
/***************************/ 

CREATE PROCEDURE sp_pism180i_01
	@ps_area	Char(1),		-- 지역
	@ps_div		Char(1),		-- 공장	
	@ps_stMonth	Char(7)			-- 기준월
AS
BEGIN

  SELECT substring(TMHLABTAC.DGDAY, 1, 7) stMonth,
	 TMHLABTAC.DGDEPTE,   
         TMSTWORKCENTER.WorkCenterName,   
         sum( IsNull(TMHLABTAC.DGOTR,0) ) otTime1,
         Sum( IsNull(TMHLABTAC.DGJUHUR,0) ) + Sum( IsNull(TMHLABTAC.DGHUMUR,0) ) otTime2, 
	 C.otManCnt,
	 Case When IsNull(TMSTWORKCENTER.WorkCenterGubun2,'') <> '' Then '1' Else '0' End ExcWCGbn
    FROM TMHLABTAC,   
         TMSTWORKCENTER,
( SELECT TMHLABTAC_a.DGDEPTE, 
       ( sum(TMHLABTAC_a.DGTIMER / 8.0) + sum(TMHLABTAC_b.DGTIMER / 8.0) ) / 2 otManCnt 
    FROM TMHLABTAC TMHLABTAC_a,   
         TMHLABTAC TMHLABTAC_b  
   WHERE ( TMHLABTAC_a.DGEMPNO = TMHLABTAC_b.DGEMPNO ) and  
         ( TMHLABTAC_a.DGDEPTE = TMHLABTAC_b.DGDEPTE ) and  
         ( ( TMHLABTAC_a.DGDAY = ( Select Min(DGDAY) From TMHLABTAC 
				    Where ( DGDEPTE = TMHLABTAC_a.DGDEPTE ) And 
					  ( substring(DGDAY, 1, 7) = @ps_stMonth ) And 
					  ( IsNull(DGTIMER, 0) > 0 ) ) ) AND  
           ( TMHLABTAC_b.DGDAY = ( Select Max(DGDAY) From TMHLABTAC 
				    Where ( DGDEPTE = TMHLABTAC_b.DGDEPTE ) And 
					  ( substring(DGDAY, 1, 7) = @ps_stMonth ) And 
					  ( IsNull(DGTIMER, 0) > 0 ) ) ) ) 
Group By TMHLABTAC_a.DGDEPTE ) C 
   WHERE ( TMHLABTAC.DGDEPTE = TMSTWORKCENTER.WorkCenter ) and  
	 ( TMHLABTAC.DGDEPTE = C.DGDEPTE ) and  
         ( ( TMSTWORKCENTER.AreaCode = @ps_area ) AND  
           ( TMSTWORKCENTER.DivisionCode = @ps_div ) AND  
	( TMSTWORKCENTER.WorkCenterGubun1 = 'K' ) And 
	   ( substring(TMHLABTAC.DGDAY, 1, 7) = @ps_stMonth ) ) 
Group By substring(TMHLABTAC.DGDAY, 1, 7), TMHLABTAC.DGDEPTE,   
         TMSTWORKCENTER.WorkCenterName, C.otManCnt, IsNull(TMSTWORKCENTER.WorkCenterGubun2,'') 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

