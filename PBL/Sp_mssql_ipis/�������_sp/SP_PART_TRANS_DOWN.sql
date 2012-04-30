/*
	File Name	: SP_PART_TRANS_DOWN.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: SP_PART_TRANS_DOWN
	Description	: DOWN INVTRANS
	Supply		: 
	Use DataBase	: CMMS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[SP_PART_TRANS_DOWN]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[SP_PART_TRANS_DOWN]
GO

/*
Execute SP_PART_TRANS_DOWN
*/

Create  Procedure SP_PART_TRANS_DOWN
AS
BEGIN

DECLARE @sDATE 	varchar(30)
DECLARE @sAREA 	varchar(30)
DECLARE @sFACTORY 	varchar(30)
DECLARE @sCHGCD 	varchar(30)
DECLARE @sSLIP 	varchar(30)
DECLARE @sPART_CODE 	varchar(30)
DECLARE @QTY 	numeric(11,1)
DECLARE @UQTY 	numeric(11,1)
DECLARE @RQTY 	numeric(11,1)
DECLARE @SQTY 	numeric(11,1)
DECLARE @sFSTS 	varchar(30)
DECLARE @sLSTS 	varchar(30)

SELECT CHGDATE
INTO #TRANS_GEN
FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
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
		FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
		WHERE CHGDATE=@sDATE
-- 전장공장
		IF @sCHGCD ='A'
			BEGIN
			IF @sAREA = 'D' AND @sFACTORY = 'A'
				BEGIN

				SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
					FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER
					where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
				IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
					CONTINUE

				IF @sSLIP = '1'
					BEGIN
					UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

				IF @sSLIP = '2'
					BEGIN
					UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
							BEGIN
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER
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
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END
				END
--제동서버
			IF @sAREA = 'D' AND ( @sFACTORY = 'M' OR @sFACTORY = 'S' )
				BEGIN
					SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
					FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER
					where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
				IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
					CONTINUE

				IF @sSLIP = '1'
					BEGIN
					UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

				IF @sSLIP = '2'
					BEGIN
					UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
							BEGIN
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER
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
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END
				END
--공조서버
			IF @sAREA = 'D' AND ( @sFACTORY = 'H' OR @sFACTORY = 'V' )
				BEGIN
					SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
					FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER
					where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
				IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
					CONTINUE

				IF @sSLIP = '1'
					BEGIN
					UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

				IF @sSLIP = '2'
					BEGIN
					UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
							BEGIN
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER
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
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END
				END
--여주서버
			IF @sAREA = 'Y' AND @sFACTORY = 'Y' 
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END
				END
			END
--내역이 삭제된 경우
		IF @sCHGCD ='D'
			BEGIN
			-- 대구 전장
			IF @sAREA = 'D' AND @sFACTORY = 'A'
				BEGIN

				SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
					FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER
					where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
				IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
					CONTINUE

				IF @sSLIP = '1'
					BEGIN
					UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

				IF @sSLIP = '2'
					BEGIN
					UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
							BEGIN
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER
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
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END
				END
			-- 대구 제동
			IF @sAREA = 'D' AND ( @sFACTORY = 'M' OR @sFACTORY = 'S' )
				BEGIN

					SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
					FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER
					where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY

				IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
					CONTINUE

				IF @sSLIP = '1'
					BEGIN
					UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

				IF @sSLIP = '2'
					BEGIN
					UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
							BEGIN
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER
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
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END
				END
			-- 대구 공조
			IF @sAREA = 'D' AND ( @sFACTORY = 'H' OR @sFACTORY = 'V' )
				BEGIN

					SELECT @UQTY = NORMAL_QTY, @RQTY = REPAIR_QTY, @SQTY = SCRAM_QTY
					FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER
					where PART_CODE=@sPART_CODE and area_code = @sAREA and factory_code = @sFACTORY
				IF @UQTY = NULL AND @RQTY = NULL AND @SQTY = NULL
					CONTINUE

				IF @sSLIP = '1'
					BEGIN
					UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

				IF @sSLIP = '2'
					BEGIN
					UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS = 'U' or @sFSTS = 'R' or @sFSTS = 'S'
							BEGIN
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER
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
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END
				END
			-- 여주 서버
			IF @sAREA = 'Y' AND @sFACTORY = 'Y'
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
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
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					END
				END
			END
	END

	FETCH NEXT FROM CURSOR_TRANS_GEN INTO @sDATE
END

END

DEALLOCATE CURSOR_TRANS_GEN

GO
