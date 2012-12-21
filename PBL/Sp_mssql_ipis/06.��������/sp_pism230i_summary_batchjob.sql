SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_summary_batchjob]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_summary_batchjob]
GO


/*****************************************/ 
/*    공장별 대당 표준 및 실투입MH Summary    */ 
/* exec sp_pism230i_summary_batchjob  */
/* JOB TIME : AM 05:00                */
/*****************************************/ 

CREATE PROCEDURE sp_pism230i_summary_batchjob

AS
BEGIN

exec sp_pism230i_summary_month 'B','A'
exec sp_pism230i_summary_month 'B','M'
exec sp_pism230i_summary_month 'B','S'
exec sp_pism230i_summary_month 'B','H'
exec sp_pism230i_summary_month 'B','V'
exec sp_pism230i_summary_month 'B','Y'
exec sp_pism230i_summary_month 'D','A'
exec sp_pism230i_summary_month 'D','M'
exec sp_pism230i_summary_month 'D','S'
exec sp_pism230i_summary_month 'D','H'
exec sp_pism230i_summary_month 'D','V'
exec sp_pism230i_summary_month 'J','M'
exec sp_pism230i_summary_month 'J','S'
exec sp_pism230i_summary_month 'J','H'
exec sp_pism230i_summary_month 'K','M'
exec sp_pism230i_summary_month 'K','S'
exec sp_pism230i_summary_month 'K','H'
exec sp_pism230i_summary_month 'Y','Y'

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

