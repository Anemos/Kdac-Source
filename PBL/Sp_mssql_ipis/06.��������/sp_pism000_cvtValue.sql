SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism000_cvtValue]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism000_cvtValue]
GO







/*****************************/
/*       월 및 일 변환       */
/*****************************/

CREATE PROCEDURE sp_pism000_cvtValue 
	@pi_Value	Numeric(2),	-- 월
	@ps_cvtValue	Char(2)		Output 

AS
BEGIN
	Set @ps_cvtValue = ''

	If @pi_Value < 10	Set @ps_cvtValue = '0' + Cast ( @pi_Value as Char(1) )
	If @pi_Value >= 10	Set @ps_cvtValue = Cast ( @pi_Value as Char(2) )
		
	Return @ps_cvtValue
END






GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

