SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_05]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_05]
GO







/********************************************/
/*      작업일보 시간단위 지원공수 TOTAL    */
/********************************************/

CREATE PROCEDURE sp_pism010u_05 
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_wday		Char(10)		-- 작업일자 

AS
BEGIN

  SELECT '+' supGbn,
	 TMHSUPPORT.DivisionCode,
         TMHSUPPORT.AreaCode,
         TMHSUPPORT.WorkDay,
	 TMHSUPPORT.supGubun, 
         Sum(IsNull(TMHSUPPORT.supMH,0)) supMH, 
	 Sum(IsNull(TMHSUPPORT.etcsupMH,0)) etcsupMH 
    FROM TMHSUPPORT  
   WHERE ( TMHSUPPORT.AreaCode = @ps_area ) AND  
         ( TMHSUPPORT.DivisionCode = @ps_div ) AND  
         ( TMHSUPPORT.SupWorkcenter = @ps_wc ) AND  
         ( TMHSUPPORT.WorkDay = @ps_wday ) 
Group By TMHSUPPORT.DivisionCode,
         TMHSUPPORT.AreaCode,
         TMHSUPPORT.WorkDay,
	 TMHSUPPORT.supGubun 
Union 
  SELECT '-',
	 TMHSUPPORT.DivisionCode,
         TMHSUPPORT.AreaCode,
         TMHSUPPORT.WorkDay,
	 TMHSUPPORT.supGubun, 
         Sum(IsNull(TMHSUPPORT.supMH,0)) supMH,
	 Sum(IsNull(TMHSUPPORT.etcsupMH,0)) etcsupMH 
    FROM TMHSUPPORT 
   WHERE ( TMHSUPPORT.AreaCode = @ps_area ) AND  
         ( TMHSUPPORT.DivisionCode = @ps_div ) AND  
         ( TMHSUPPORT.WorkCenter = @ps_wc ) AND  
         ( TMHSUPPORT.WorkDay = @ps_wday ) 
Group By TMHSUPPORT.DivisionCode,
         TMHSUPPORT.AreaCode,
         TMHSUPPORT.WorkDay,
	 TMHSUPPORT.supGubun

END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

