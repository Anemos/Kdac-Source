SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism180i_01_jin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism180i_01_jin]
GO


/*****************************/
/*     인당 OT시간 조회    */
/* exec sp_pism180i_01_jin 'J','H','2012.04.01','2012.04.25'    */
/*****************************/

CREATE PROCEDURE [dbo].[sp_pism180i_01_jin]
  @ps_area  Char(1),    -- 지역
  @ps_div   Char(1),    -- 공장
  @ps_stFromDate  Char(10),   -- 기준일 From
  @ps_stToDate  Char(10)    -- 기준일 To
AS
BEGIN

Execute [ipisjin_svr].ipis.dbo.sp_pism180i_01_rev1 @ps_area,@ps_div,@ps_stFromDate,@ps_stToDate

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

