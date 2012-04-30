/*
  file name : sp_part_trans_down.sql
  system    : cmms system
  procedure name  : sp_part_trans_down
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_part_trans_down]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_part_trans_down]
go

/*
execute sp_part_trans_down
*/

create procedure [dbo].[sp_part_trans_down]
AS
BEGIN

DECLARE @sDATE  varchar(30)
DECLARE @sAREA  varchar(30)
DECLARE @sFACTORY   varchar(30)
DECLARE @sCHGCD   varchar(30)
DECLARE @sSLIP  varchar(30)
DECLARE @sPART_CODE   varchar(30)
DECLARE @QTY  numeric(11,1)
DECLARE @UQTY   numeric(11,1)
DECLARE @RQTY   numeric(11,1)
DECLARE @SQTY   numeric(11,1)
DECLARE @sFSTS  varchar(30)
DECLARE @sLSTS  varchar(30)

SELECT CHGDATE
INTO #TRANS_GEN
FROM [ipis_daegu].INTERFACE.dbo.INVTRANS
WHERE STSCD ='N'


DECLARE CURSOR_TRANS_GEN CURSOR
    FOR SELECT CHGDATE FROM #TRANS_GEN
OPEN CURSOR_TRANS_GEN

FETCH NEXT FROM CURSOR_TRANS_GEN INTO @sDATE

WHILE (@@FETCH_STATUS <> -1)
BEGIN
  if (@@FETCH_STATUS <> -2)
  BEGIN

    SELECT  @sAREA = XPLANT, @sFACTORY = DIV, @sCHGCD=CHGCD, @sSLIP=SLIPGUBUN,
            @sPART_CODE=ITNO, @QTY=TQTY4, @sFSTS =INVSTCD, @sLSTS=INVSTCD1
    FROM [ipis_daegu].INTERFACE.dbo.INVTRANS
    WHERE CHGDATE=@sDATE
-- 대구공장
    IF @sCHGCD ='A'
      BEGIN
      IF @sAREA = 'D'
        BEGIN

        SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
          FROM [ipis_daegu].CMMS.dbo.PART_MASTER
          where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
        IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
          CONTINUE

        IF @sSLIP = '1'
          BEGIN
          UPDATE [ipis_daegu].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

        IF @sSLIP = '2'
          BEGIN
          UPDATE [ipis_daegu].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and  area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

          IF @sSLIP = '3'
          BEGIN
            IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
              BEGIN
              UPDATE [ipis_daegu].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and  area_code = @sAREA and factory_code = @sFACTORY
              END
            IF @sLSTS = 'U' or @sLSTS = 'R' or @sLSTS = 'S'
              BEGIN
              UPDATE [ipis_daegu].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sLSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sLSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sLSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and  area_code = @sAREA and factory_code = @sFACTORY
              END

            IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END
        END

--여주서버
      IF @sAREA = 'Y'
        BEGIN
          SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
          FROM [ipisyeo_svr\ipis].CMMS.dbo.PART_MASTER
          where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
        IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
          CONTINUE

        IF @sSLIP = '1'
          BEGIN
          UPDATE [ipisyeo_svr\ipis].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

        IF @sSLIP = '2'
          BEGIN
          UPDATE [ipisyeo_svr\ipis].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and  area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

          IF @sSLIP = '3'
          BEGIN
            IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
              BEGIN
              UPDATE [ipisyeo_svr\ipis].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE   and area_code = @sAREA and factory_code = @sFACTORY
              END
            IF @sLSTS = 'U' or @sLSTS = 'R' or @sLSTS = 'S'
              BEGIN
              UPDATE [ipisyeo_svr\ipis].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sLSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sLSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sLSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END

            IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END
        END
--진천서버
      IF @sAREA = 'J'
        BEGIN
          SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
          FROM ipisjin_svr.CMMS.dbo.PART_MASTER
          where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
        IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
          CONTINUE

        IF @sSLIP = '1'
          BEGIN
          UPDATE ipisjin_svr.cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

        IF @sSLIP = '2'
          BEGIN
          UPDATE ipisjin_svr.cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

          IF @sSLIP = '3'
          BEGIN
            IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
              BEGIN
              UPDATE ipisjin_svr.cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END
            IF @sLSTS = 'U' or @sLSTS = 'R' or @sLSTS = 'S'
              BEGIN
              UPDATE ipisjin_svr.cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sLSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sLSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sLSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END

            IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END
        END
      END
--내역이 삭제된 경우
    IF @sCHGCD ='D'
      BEGIN
      -- 대구
      IF @sAREA = 'D'
        BEGIN

        SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
          FROM [ipis_daegu].CMMS.dbo.PART_MASTER
          where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
        IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
          CONTINUE

        IF @sSLIP = '1'
          BEGIN
          UPDATE [ipis_daegu].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

        IF @sSLIP = '2'
          BEGIN
          UPDATE [ipis_daegu].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

          IF @sSLIP = '3'
          BEGIN
            IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
              BEGIN
              UPDATE [ipis_daegu].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END
            IF @sLSTS = 'U' or @sLSTS = 'R' or @sLSTS = 'S'
              BEGIN
              UPDATE [ipis_daegu].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sLSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sLSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sLSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END

            IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END
        END

      -- 여주 서버
      IF @sAREA = 'Y'
        BEGIN

          SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
          FROM [ipisyeo_svr\ipis].CMMS.dbo.PART_MASTER
          where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
        IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
          CONTINUE

        IF @sSLIP = '1'
          BEGIN
          UPDATE [ipisyeo_svr\ipis].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

        IF @sSLIP = '2'
          BEGIN
          UPDATE [ipisyeo_svr\ipis].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

          IF @sSLIP = '3'
          BEGIN
            IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
              BEGIN
              UPDATE [ipisyeo_svr\ipis].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END
            IF @sLSTS = 'U' or @sLSTS = 'R' or @sLSTS = 'S'
              BEGIN
              UPDATE [ipisyeo_svr\ipis].cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sLSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sLSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sLSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END

            IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END
        END
      -- 진천
      IF @sAREA = 'J'
        BEGIN
          SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
          FROM ipisjin_svr.CMMS.dbo.PART_MASTER
          where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
        IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
          CONTINUE

        IF @sSLIP = '1'
          BEGIN
          UPDATE ipisjin_svr.cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

        IF @sSLIP = '2'
          BEGIN
          UPDATE ipisjin_svr.cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@SQTY,0)
                                end)
          where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY

          IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END

          IF @sSLIP = '3'
          BEGIN
            IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
              BEGIN
              UPDATE ipisjin_svr.cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sFSTS when 'U' then (isnull(@UQTY,0) + isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sFSTS when 'R' then (isnull(@RQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sFSTS when 'S' then (isnull(@SQTY,0) + isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END
            IF @sLSTS = 'U' or @sLSTS = 'R' or @sLSTS = 'S'
              BEGIN
              UPDATE ipisjin_svr.cmms.dbo.PART_MASTER
              set NORMAL_QTY = (case @sLSTS when 'U' then (isnull(@UQTY,0) - isnull(@QTY,0))
                                else isnull(@UQTY,0)
                                end),
                  REPAIR_QTY = (case @sLSTS when 'R' then (isnull(@RQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end),
                  SCRAM_QTY  = (case @sLSTS when 'S' then (isnull(@SQTY,0) - isnull(@QTY,0))
                                else isnull(@RQTY,0)
                                end)
              where PART_CODE=@sPART_CODE  and area_code = @sAREA and factory_code = @sFACTORY
              END

            IF @@ROWCOUNT > 0
              BEGIN
                UPDATE [ipis_daegu].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
              END
          END
        END
      END
  END

  FETCH NEXT FROM CURSOR_TRANS_GEN INTO @sDATE
END

END

DEALLOCATE CURSOR_TRANS_GEN