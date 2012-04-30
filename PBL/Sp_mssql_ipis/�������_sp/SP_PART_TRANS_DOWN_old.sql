SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO






ALTER   PROCEDURE SP_PART_TRANS_DOWN
AS
BEGIN

DECLARE @sDATE 	varchar(30)
DECLARE @sAREA 	varchar(30)
DECLARE @sFACTORY 	varchar(30)
DECLARE @sCHGCD 	varchar(30)
DECLARE @sSLIP 	varchar(30)
DECLARE @sPART_CODE 	varchar(30)
DECLARE @QTY 	numeric(11,1)
DECLARE @RQTY 	numeric(11,1)
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
begin
	if (@@FETCH_STATUS <> -2)
	begin
		

		SELECT  @sAREA = XPLANT, @sFACTORY = DIV, @sCHGCD=CHGCD, @sSLIP=SLIPGUBUN, @sPART_CODE=ITNO, @QTY=TQTY4, @sFSTS =INVSTCD, @sLSTS=INVSTCD1
		FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
		WHERE CHGDATE=@sDATE

		IF @sAREA = 'D'
		BEGIN

			IF @sFACTORY = 'A'
			BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE  and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
		
								
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					
						END

						IF @sFSTS='S'
						BEGIN 
							SELECT @RQTY =SCRAM_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					

						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
						
						END

						IF @sFSTS='S'
						BEGIN 
							SELECT @RQTY =SCRAM_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END

				IF @sCHGCD ='D' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
IF @RQTY <@QTY
							SELECT @RQTY =NORMAL_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							UPDATE [ipisele_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='A'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END				
			END
			
			IF @sFACTORY IN ('S')
			
			BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
						
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END

				IF @sCHGCD ='D' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END				

			END
			IF @sFACTORY IN ('M')
			
			BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END

				IF @sCHGCD ='D' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							UPDATE [ipismac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END				
			END
			IF @sFACTORY IN ('H')
			BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 

							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END

				IF @sCHGCD ='D' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END				
			END
		
			IF @sFACTORY IN ('V')
			BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END

				IF @sCHGCD ='D' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							UPDATE [ipishvac_svr\ipis].cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='D' and factory_code='V'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END				
			END
		END
		IF @sAREA = 'J'
		BEGIN
			IF @sFACTORY IN ('M')
			begin
				IF @sCHGCD ='A' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN 
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
					
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN 
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
						
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END

				IF @sCHGCD ='D' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'

							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='M'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
						
						END
					END

				END				
			end
		
			IF @sFACTORY IN ('S')
			begin
				IF @sCHGCD ='A' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
						
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN 
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN 
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
						
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
						
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END

				IF @sCHGCD ='D' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='S'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END				
			end

			IF @sFACTORY IN ('H')
			begin
				IF @sCHGCD ='A' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN 
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@QTY,0)+isnull(@RQTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN 
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END

				IF @sCHGCD ='D' 
				BEGIN
					IF @sSLIP = '1'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '2'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

					IF @sSLIP = '3'
					BEGIN
						IF @sFSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sFSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = @RQTY+@QTY where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='U'
						BEGIN
							SELECT @RQTY =NORMAL_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set NORMAL_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='R'
						BEGIN
							SELECT @RQTY =REPAIR_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set REPAIR_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END

						IF @sLSTS='S'
						BEGIN
							SELECT @RQTY =SCRAM_QTY FROM ipisjin_svr.CMMS.dbo.PART_MASTER where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							UPDATE ipisjin_svr.cmms.dbo.PART_MASTER set SCRAM_QTY = isnull(@RQTY,0)-isnull(@QTY,0) where PART_CODE=@sPART_CODE and area_code='J' and factory_code='H'
							IF @@ROWCOUNT >0 
							BEGIN
								INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVTRANS
								SELECT *
								FROM [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS
								WHERE CHGDATE=@sDATE
						
								UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVTRANS SET STSCD = 'Y' WHERE CHGDATE=@sDATE
							END
							
						END
					END

				END				
			end
		END

	END
	
	FETCH NEXT FROM CURSOR_TRANS_GEN INTO @sDATE
END

END

DEALLOCATE CURSOR_TRANS_GEN


GO
