SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_01]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_01]
GO







/**********************************/
/*      작업일보 공수발생 내역    */
/**********************************/

CREATE PROCEDURE sp_pism010u_01
	@ps_area		Char(1),		-- 지역
	@ps_div			Char(1),		-- 공장
	@ps_wc			Varchar(5),		-- 조
	@ps_wday		Char(10)		-- 작업일자 

AS
BEGIN

  SELECT TMHDAILY.AreaCode,   
         TMHDAILY.DivisionCode,   
         TMHDAILY.WorkCenter,   
         TMHDAILY.WorkDay,   
         TMHDAILY.EmpGubun,   
         TMHDAILY.totMH, 
         TMHDAILY.jungsiMH,   
         TMHDAILY.mSuppMH,   
         TMHDAILY.pSuppMH,   
         TMHDAILY.etcMH,   
         TMHDAILY.etcmSuppMH,   
         TMHDAILY.etcpSuppMH,   
	 CAST ( NULL AS Numeric(4,1) ) k_1,
	 CAST ( NULL AS Numeric(4,1) ) k_2,
	 CAST ( NULL AS Numeric(4,1) ) k_3,
	 CAST ( NULL AS Numeric(4,1) ) k_4,
	 CAST ( NULL AS Numeric(4,1) ) k_5,
         TMHDAILY.excunpaidMH,   
	 CAST ( NULL AS Numeric(4,1) ) s_1,
	 CAST ( NULL AS Numeric(4,1) ) s_2,
	 CAST ( NULL AS Numeric(4,1) ) s_3,
	 CAST ( NULL AS Numeric(4,1) ) s_4,
	 CAST ( NULL AS Numeric(4,1) ) s_5,
	 CAST ( NULL AS Numeric(4,1) ) s_6,
	 CAST ( NULL AS Numeric(4,1) ) s_7,
	 CAST ( NULL AS Numeric(4,1) ) s_8,
	 CAST ( NULL AS Numeric(4,1) ) s_9,
	 CAST ( NULL AS Numeric(4,1) ) s_10,
	 CAST ( NULL AS Numeric(4,1) ) s_11,
         TMHDAILY.excpaidMH,   
         TMHDAILY.totInMH,   
	 CAST ( NULL AS Numeric(4,1) ) b_1,
	 CAST ( NULL AS Numeric(4,1) ) b_2,
	 CAST ( NULL AS Numeric(4,1) ) b_3,
         TMHDAILY.gunteMH,   
	 CAST ( NULL AS Numeric(4,1) ) g_1,
	 CAST ( NULL AS Numeric(4,1) ) g_2,
	 CAST ( NULL AS Numeric(4,1) ) g_3,
	 CAST ( NULL AS Numeric(4,1) ) g_4,
	 CAST ( NULL AS Numeric(4,1) ) g_5,
	 CAST ( NULL AS Numeric(4,1) ) g_6,
	 CAST ( NULL AS Numeric(4,1) ) g_7,
	 CAST ( NULL AS Numeric(4,1) ) g_8, 
         TMHDAILY.ilboMH,   
         TMHDAILY.bugaMH,   
         TMHDAILY.ActInMH, 
	 CAST ( 0 AS Numeric(4,1) ) input_ActINMH,
	 TMHDAILY.LastEmp, 
	 TMHDAILY.LastDate 
    FROM TMHDAILY  
   WHERE ( TMHDAILY.AreaCode = @ps_area ) AND  
         ( TMHDAILY.DivisionCode = @ps_div ) AND  
         ( TMHDAILY.WorkCenter = @ps_wc ) AND  
         ( TMHDAILY.WorkDay = @ps_wday )

END




GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

