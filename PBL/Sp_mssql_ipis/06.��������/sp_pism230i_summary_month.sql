SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS OFF 
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism230i_summary_month]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism230i_summary_month]
GO


/*****************************************/ 
/*    공장별 대당 표준 및 실투입MH Summary    */ 
/* exec sp_pism230i_summary_month 'D','A' */
/*****************************************/ 

CREATE PROCEDURE sp_pism230i_summary_month
	@ps_AreaCode Char(1),
  @ps_DivisionCode Char(1)
AS
BEGIN

declare @ls_applymm char(7),
  @ls_bomdate char(8),
  @ls_todate char(10),
  @li_chkcnt      int

set @ls_applymm = convert(char(6), GETDATE(), 112) + '%'
set @ls_bomdate = ''
set @li_chkcnt = 0

-- 전월 작업수행여부
if ( CONVERT(VARCHAR(8),GETDATE(),112) <= CONVERT(VARCHAR(8),DATEADD(DD,6,CAST (convert(char(6), GETDATE(), 112) + '01' AS DATETIME)),112) )
BEGIN
  -- 전월 작업
  set @ls_applymm = convert(char(6), DATEADD(MM,-1,GETDATE()), 112) + '%'
  set @ls_bomdate = ''
  set @li_chkcnt = 0
  while @li_chkcnt = 0
  BEGIN
  
    select distinct top 1 @ls_bomdate = zdate
    from tmhbasebom
    where zcmcd = '01' and zplant = @ps_AreaCode and
      zdiv = @ps_DivisionCode and zdate like @ls_applymm and
      zdate > @ls_bomdate
    order by zdate

    if @@rowcount = 0
      break
  
    -- 해당일자 MH Summary
    set @ls_todate = convert(char(10), cast(@ls_bomdate as datetime), 102)
    exec sp_pism230i_summary @ps_AreaCode,@ps_DivisionCode,@ls_todate
  
  END
END
-- 당월 작업
set @ls_applymm = convert(char(6), GETDATE(), 112) + '%'
set @ls_bomdate = ''
set @li_chkcnt = 0
while @li_chkcnt = 0
BEGIN
  
  select distinct top 1 @ls_bomdate = zdate
  from tmhbasebom
  where zcmcd = '01' and zplant = @ps_AreaCode and
    zdiv = @ps_DivisionCode and zdate like @ls_applymm and
    zdate > @ls_bomdate
  order by zdate

  if @@rowcount = 0
    break
  
  -- 해당일자 MH Summary
  set @ls_todate = convert(char(10), cast(@ls_bomdate as datetime), 102)
  exec sp_pism230i_summary @ps_AreaCode,@ps_DivisionCode,@ls_todate
  
END

END



GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

