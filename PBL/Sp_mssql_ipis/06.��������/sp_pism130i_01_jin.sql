SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism130i_01_jin]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism130i_01_jin]
GO

/*
Execute sp_pism130i_01_jin
  @ps_area  = 'J',
  @ps_div   = 'H',
  @ps_stFromDate  = '2012.08.01',
  @ps_stToDate  = '2012.08.08',
  @ps_retGubun  = '1'

*/

/*****************************/
/*     조별 공수투입 현황    */
/*****************************/

CREATE PROCEDURE [dbo].[sp_pism130i_01_jin]
  @ps_area  Char(1),    -- 지역
  @ps_div   Char(1),    -- 공장
  @ps_stFromDate  Char(10),   -- 기준일From
  @ps_stToDate  Char(10),   -- 기준일To
  @ps_retGubun  Char(1)
AS
BEGIN

Execute [ipisjin_svr].ipis.dbo.sp_pism130i_01 @ps_area,@ps_div,@ps_stFromDate,@ps_stToDate,@ps_retGubun

END

GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

