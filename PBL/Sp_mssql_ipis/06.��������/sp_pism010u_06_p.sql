SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_06_p]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_06_p]
GO







/**************************************/
/*      작업일보 손실공수 발생내역    */
/**************************************/

CREATE PROCEDURE sp_pism010u_06_p 
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_wday		Char(10)		-- 작업일자 

AS
BEGIN

  SELECT TMHDAILYSUB.DivisionCode,   
         TMHDAILYSUB.AreaCode,   
         TMHDAILYSUB.WorkCenter,   
         TMHDAILYSUB.WorkDay,   
         TMHDAILYSUB.MHGubun,   
         TMHDAILYSUB.MHCode,   
         TMHDAILYSUB.seqNo,   
         TMHDAILYSUB.detailWork,   
         TMHDAILYSUB.FromTime,   
         TMHDAILYSUB.ToTime,   
         TMHDAILYSUB.subMH,   
         TMHCODE.MHName,
	 TMHDAILYSUB.LastEmp, 
	 TMHDAILYSUB.LastDate 
    FROM TMHDAILYSUB,   
         TMHCODE  
   WHERE ( TMHCODE.MHGubun = TMHDAILYSUB.MHGubun ) and  
         ( TMHCODE.MHCode = TMHDAILYSUB.MHCode ) and  
         ( ( TMHDAILYSUB.AreaCode = @ps_area ) AND  
	   ( TMHDAILYSUB.DivisionCode = @ps_div ) AND           
         ( TMHDAILYSUB.WorkCenter = @ps_wc ) AND  
         ( TMHDAILYSUB.WorkDay = @ps_wday ) AND  
         ( TMHDAILYSUB.MHGubun in ( 'F', 'U', 'Z' ) ) )

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

