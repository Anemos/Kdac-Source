SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism020u_02]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism020u_02]
GO







/***********************************************/
/*     작업일보 시간단위 지원공수(지원받음)    */
/***********************************************/

CREATE PROCEDURE sp_pism020u_02 
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_wday		Char(10)		-- 작업일자 

AS
BEGIN

SELECT  TMHSUPPORT.DivisionCode ,
	TMHSUPPORT.AreaCode ,
	TMHSUPPORT.WorkDay ,
	TMHSUPPORT.WorkCenter ,
	TMHSUPPORT.supGubun, 
	TMHSUPPORT.EmpNo ,
	TMHSUPPORT.supWorkCenter ,
	TMHSUPPORT.FromTime ,
	TMHSUPPORT.ToTime ,
	TMHSUPPORT.supMH ,
	TMHSUPPORT.etcsupMH ,
	CAST(TMSTEMP.EmpName AS VARCHAR(10)) AS EMPNAME,
	( Select DailyStatus From TMHDAILYSTATUS 
	   Where ( AreaCode = TMHSUPPORT.AreaCode ) And 
		 ( DivisionCode = TMHSUPPORT.DivisionCode ) And 
		 ( WorkCenter = TMHSUPPORT.WorkCenter ) And 
		 ( WorkDay = TMHSUPPORT.WorkDay ) ) supwc_dailystatus,
	TMHLABTAC.DGDNGBR,
	TMHSUPPORT.LastEmp, 
	TMHSUPPORT.LastDate 
   FROM TMHSUPPORT ,
        TMSTEMP ,
	TMHLABTAC     
  WHERE ( TMHSUPPORT.EmpNo *= TMSTEMP.EmpNo ) and 
	( TMHSUPPORT.Workcenter *= TMHLABTAC.DGDEPTE ) And 
	( TMHSUPPORT.WorkDay *= TMHLABTAC.DGDAY ) And 
	( TMHSUPPORT.EmpNo *= TMHLABTAC.DGEMPNO ) And 
	( ( TMHSUPPORT.AreaCode = @ps_area ) and
	  ( TMHSUPPORT.DivisionCode = @ps_div ) and 
	  ( TMHSUPPORT.SupWorkcenter = @ps_wc ) and 
	  ( TMHSUPPORT.WorkDay = @ps_wday ) )  

END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

