SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS OFF
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[sp_pism010u_03]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[sp_pism010u_03]
GO




/*********************************/
/*      작업일보 생산수량내역    */
/* 라우팅 이력관리시스템 적용 ( 2008.11.12 ) */
/*********************************/

CREATE PROCEDURE sp_pism010u_03
  @ps_area    Char(1),    -- 지역
  @ps_div     Char(1),    -- 공장
  @ps_wc      Varchar(5),   -- 조
  @ps_wday    Char(10),   -- 작업일자
  @ps_wcItemretChk  Char(1)     -- 조별작업일보내 생산모델 재선택여부

AS
BEGIN

 Declare @actInMH Numeric(4,1)

If @ps_wcItemretChk = '1'
  Begin
  -- '미사용' 항목 삭제

    SELECT @actInMH = sum(IsNull(ActInMH,0))
      FROM TMHDAILY
     WHERE ( AreaCode = @ps_area ) AND
           ( DivisionCode = @ps_div ) AND
           ( WorkCenter = @ps_wc ) AND
           ( WorkDay = @ps_wday )

    If IsNull(@actInMH,0) = 0
       Begin
    DELETE TMHREALPROD
     WHERE ( AreaCode = @ps_area ) AND
           ( DivisionCode = @ps_div ) AND
           ( WorkCenter = @ps_wc ) AND
           ( WorkDay = @ps_wday )
    If @@Error <> 0 Goto Exit_pr
       End
    Else
       Begin
      DELETE TMHREALPROD
        FROM TMHREALPROD A
       WHERE ( ( A.AreaCode = @ps_area ) AND
               ( A.DivisionCode = @ps_div ) AND
               ( A.WorkCenter = @ps_wc ) AND
               ( A.WorkDay = @ps_wday ) And
         ( ( IsNull(A.daypQty, 0) + IsNull(A.nightpQty, 0) ) = 0 ) )
      If @@Error <> 0 Goto Exit_pr


      INSERT INTO TMHREALPROD
              ( AreaCode, DivisionCode, WorkCenter, WorkDay, ItemCode,
          subLineCode, subLineNo, wcItemGroup, Seq )
      SELECT A.AreaCode,
       A.DivisionCode,
       A.WorkCenter,
       @ps_wday,
       A.ItemCode,
             A.subLineCode,
             A.subLineNo,
       A.wcItemGroup,
       A.Seq
      FROM TMHWCITEM A, ( SELECT AreaCode = aa.AreaCode,
          DivisionCode = aa.DivisionCode,
          WorkCenter = aa.WorkCenter,
          ApplyDate = Min(aa.ApplyDate),
          EndDate = Max(aa.EndDate),
          ItemCode = aa.ItemCode,
          SubLineCode = aa.SubLineCode,
          SubLineNo = aa.SubLineNo,
          BasicTime = Cast ( Sum ( IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0) ) as Numeric(9,4) )
        FROM TMSTROUTING aa
        WHERE isnull(aa.ApplyDate,'1900.01.01') <= @ps_wday AND isnull(aa.EndDate,'9999.12.31') >= @ps_wday
        GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) B
      WHERE ( A.AreaCode = B.AreaCode ) and
             ( A.DivisionCode = B.DivisionCode ) and
       ( A.WorkCenter = B.WorkCenter ) and
       ( A.ItemCode = B.ItemCode ) and
       ( A.subLineCode = B.SubLineCode ) and
       ( A.subLineNo = B.SubLineNo ) and
       ( ( A.AreaCode = @ps_area ) AND
         ( A.DivisionCode = @ps_div ) AND
         ( A.WorkCenter = @ps_wc ) AND
         ( IsNull(A.UseFlag,'0') = '1' ) And
    Not Exists ( Select ItemCode From TMHREALPROD
            Where ( AreaCode = A.AreaCode ) And ( DivisionCode = A.DivisionCode ) And
            ( WorkCenter = A.WorkCenter ) And ( WorkDay = @ps_wday ) And
            ( ItemCode = A.ItemCode ) And ( sublinecode = A.sublinecode ) And
            ( SubLineno = A.subLineNo ) ) )
      If @@Error <> 0 Goto Exit_pr

    -- 유사군명칭 갱신
     UPDATE TMHREALPROD
         SET wcItemGroup = B.wcItemGroup,
       Seq = B.seq
        FROM TMHREALPROD A,
             TMHWCITEM B
       WHERE ( A.AreaCode = B.AreaCode ) and
       ( A.DivisionCode = B.DivisionCode ) And
       ( A.WorkCenter = B.WorkCenter ) And
       ( A.ItemCode = B.ItemCode ) And
       ( A.subLineCode = B.subLineCode ) And
       ( A.subLineNo = B.subLineNo ) And
             ( ( A.AreaCode = @ps_area ) AND
               ( A.DivisionCode = @ps_div ) AND
               ( A.WorkCenter = @ps_wc ) AND
               ( A.WorkDay = @ps_wday ) And
         ( IsNull(B.UseFlag,'') = '1' ) )

    -- 표준시간 갱신

      UPDATE TMHREALPROD
         SET BasicTime = B.BasicTime
        FROM TMHREALPROD A,
             ( SELECT AreaCode = aa.AreaCode,
          DivisionCode = aa.DivisionCode,
          WorkCenter = aa.WorkCenter,
          ApplyDate = Min(aa.ApplyDate),
          EndDate = Max(aa.EndDate),
          ItemCode = aa.ItemCode,
          SubLineCode = aa.SubLineCode,
          SubLineNo = aa.SubLineNo,
          BasicTime = Cast ( Sum ( IsNull(aa.BaseManualWorkTime,0) + IsNull(aa.SideManualWorkTime,0) ) as Numeric(9,4) )
        FROM TMSTROUTING aa
        WHERE isnull(aa.ApplyDate,'1900.01.01') <= @ps_wday AND isnull(aa.EndDate,'9999.12.31') >= @ps_wday
        GROUP BY aa.AreaCode, aa.DivisionCode, aa.WorkCenter, aa.ItemCode, aa.SubLineCode, aa.SubLineNo ) B
       WHERE ( A.AreaCode = B.AreaCode ) and
       ( A.DivisionCode = B.DivisionCode ) And
       ( A.WorkCenter = B.WorkCenter ) And
       ( A.ItemCode = B.ItemCode ) And
       ( A.subLineCode = B.subLineCode ) And
       ( A.subLineNo = B.subLineNo ) And
       ( ( A.AreaCode = @ps_area ) AND
       ( A.DivisionCode = @ps_div ) AND
       ( A.WorkCenter = @ps_wc ) AND
       ( A.WorkDay = @ps_wday ) )
      If @@Error <> 0 Goto Exit_pr

    -- 표준생산공수 재계산

      UPDATE TMHREALPROD
         SET BasicMH = Round( ( IsNull(daypQty,0) + IsNull(nightpQty,0) ) * ( BasicTime / 3600 ) , 1 )
       WHERE ( AreaCode = @ps_area ) AND
             ( DivisionCode = @ps_div ) AND
             ( WorkCenter = @ps_wc ) AND
             ( WorkDay = @ps_wday ) And
       ( IsNull(daypQty,0) + IsNull(nightpQty,0) > 0 )
      If @@Error <> 0 Goto Exit_pr

    End
  End

  SELECT A.DivisionCode,
     A.AreaCode,
   A.WorkCenter,
   A.WorkDay,
     A.wcItemGroup,
   A.Seq,
   A.ItemCode,
   A.subLineCode,
   A.subLineNo,
   A.daypQty,
   A.nightpQty,
   A.UnuseMH,
   A.ActMH,
   A.ActInMH,
   A.BasicTime,
   A.BasicMH,
   B.ItemName,
     B.ItemSpec,
   '0' unuse_inputChk,
   '0' act_inputChk,
   A.LastEmp,
   A.LastDate
     FROM TMHREALPROD A,
          TMSTITEM B
   WHERE ( A.ItemCode = B.ItemCode ) and
         ( ( A.AreaCode = @ps_area ) AND
           ( A.DivisionCode = @ps_div ) AND
           ( A.WorkCenter = @ps_wc ) AND
           ( A.WorkDay = @ps_wday ) )

Exit_pr:

END


GO
SET QUOTED_IDENTIFIER OFF
GO
SET ANSI_NULLS ON
GO

