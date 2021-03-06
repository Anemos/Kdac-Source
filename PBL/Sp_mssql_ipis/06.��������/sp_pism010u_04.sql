SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_04]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_04]
GO








/*************************************/
/*      작업일보STATS 및 특기사항    */
/*************************************/

CREATE PROCEDURE sp_pism010u_04 
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_wday		Char(10)		-- 작업일자 

AS
BEGIN

  SELECT TMHDAILYSTATUS.AreaCode,   
         TMHDAILYSTATUS.DivisionCode,   
         TMHDAILYSTATUS.WorkCenter,   
         TMHDAILYSTATUS.WorkDay,   
         TMHDAILYSTATUS.DailyStatus,   
         TMHDAILYSTATUS.InputTime,   
	 TMHDAILYSTATUS.InputEmp,   
         TMHDAILYSTATUS.Remark,   
         TMHDAILYSTATUS.LastEmp,
	 TMHDAILYSTATUS.LastDate 
    FROM TMHDAILYSTATUS  
   WHERE ( TMHDAILYSTATUS.AreaCode = @ps_area ) AND  
         ( TMHDAILYSTATUS.DivisionCode = @ps_div ) AND  
         ( TMHDAILYSTATUS.WorkCenter = @ps_wc ) AND  
         ( TMHDAILYSTATUS.WorkDay = @ps_wday ) 

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

