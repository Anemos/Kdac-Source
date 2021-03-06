SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_sumMonth]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_sumMonth]
GO







/****************************/ 
/*      월별 Total 집계     */ 
/****************************/ 

CREATE PROCEDURE sp_pism010u_sumMonth 
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_sMonth		Char(7),		-- 집계년월 
	@ri_err			Int	OutPut 

AS
BEGIN

	Execute sp_pism010u_sumMonth_prod 	@ps_area 	= @ps_area, 
						@ps_div		= @ps_div, 
						@ps_wc		= @ps_wc, 
						@ps_sMonth	= @ps_sMonth, 
						@ri_err		= @ri_err OutPut 
	If @ri_err <> 0 Return @ri_err 

	Execute sp_pism010u_sumMonth_prodLine 	@ps_area 	= @ps_area, 
						@ps_div		= @ps_div, 
						@ps_wc		= @ps_wc, 
						@ps_sMonth	= @ps_sMonth, 
						@ri_err		= @ri_err OutPut 
	If @ri_err <> 0 Return @ri_err 

	Execute sp_pism010u_sumMonth_mh 	@ps_area 	= @ps_area, 
						@ps_div		= @ps_div, 
						@ps_wc		= @ps_wc, 
						@ps_sMonth	= @ps_sMonth, 
						@ri_err		= @ri_err OutPut 
	Return @ri_err 


END





GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

