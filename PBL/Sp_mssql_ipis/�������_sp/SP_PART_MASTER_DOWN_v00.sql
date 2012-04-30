/*
	File Name	: SP_PART_MASTER_DOWN.SQL
	SYSTEM		: KDAC 통합 생산 정보 시스템
	Procedure Name	: SP_PART_MASTER_DOWN
	Description	: DOWN INVMASTER
	Supply		: 
	Use DataBase	: CMMS
	Use Program	: 
	Parameter	: 
	Use Table	: 
	Initial		: 2002. 11. 12
	Author		: Gary Kim
*/

If Exists (Select * From sysobjects 
	    Where id = object_id(N'[dbo].[SP_PART_MASTER_DOWN]')
	      And OBJECTPROPERTY(id, N'IsProcedure') = 1)
	Drop Procedure [dbo].[SP_PART_MASTER_DOWN]
GO

/*
Execute SP_PART_MASTER_DOWN
*/

Create  Procedure SP_PART_MASTER_DOWN
AS
BEGIN

DECLARE @sLOGID 	INT
DECLARE @sDATE 	varchar(30)
DECLARE @sAREA 	varchar(30)
DECLARE @sFACTORY 	varchar(30)
DECLARE @sCHGCD 	varchar(30)
DECLARE @sPART_CODE 	varchar(30)
DECLARE @VALUE 	numeric(11,1)
DECLARE @sCOMP 	varchar(30)
DECLARE @sUNIT 	varchar(30)
DECLARE @sLOCATION 	varchar(30)
DECLARE @sPART_NAME 	varchar(50)
DECLARE @sSPEC 	varchar(50)


SELECT LOGID
INTO #TRANS_GEN
FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER
WHERE STSCD ='N'


DECLARE CURSOR_TRANS_GEN CURSOR
    FOR SELECT LOGID FROM #TRANS_GEN
            ORDER BY LOGID
OPEN CURSOR_TRANS_GEN

FETCH NEXT FROM CURSOR_TRANS_GEN INTO @sLOGID

WHILE (@@FETCH_STATUS <> -1)
begin
	if (@@FETCH_STATUS <> -2)
	begin
		
		SELECT  @sAREA = XPLANT, @sFACTORY = DIV, @sCHGCD=CHGCD, @sPART_CODE=ITNO, @VALUE=SAUD, @sCOMP =SRCE, @sUNIT=XUNIT, @sLOCATION=WLOC
		FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER
		WHERE LOGID=@sLOGID

		IF @sAREA = 'D'
		BEGIN

			IF @sFACTORY = 'A'
			BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					INSERT INTO [ipisele_svr\ipis].CMMS.dbo.PART_MASTER 
					(AREA_CODE,FACTORY_CODE,PART_CODE, PART_NAME, PART_SPEC, PART_UNIT,
					PART_COST, COMP_CODE, PART_LOCATION)
					VALUES ( @sAREA, @sFACTORY, @sPART_CODE, @sPART_NAME, @sSPEC, @sUNIT, 
					@VALUE, @sCOMP, @sLOCATION)
				END
				IF @sCHGCD ='R' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					UPDATE [ipisele_svr\ipis].CMMS.dbo.PART_MASTER 
					SET  PART_NAME=@sPART_NAME, PART_SPEC=@sSPEC, PART_UNIT=@sUNIT,
					PART_COST=@VALUE, COMP_CODE= @sCOMP, PART_LOCATION=@sLOCATION
					FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END				
				IF @sCHGCD ='D' 
				BEGIN
					DELETE FROM [ipisele_svr\ipis].CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END				
			END
			
			IF @sFACTORY IN ('S','M')
			BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					INSERT INTO [ipismac_svr\ipis].CMMS.dbo.PART_MASTER 
					(AREA_CODE,FACTORY_CODE,PART_CODE, PART_NAME, PART_SPEC, PART_UNIT,
					PART_COST, COMP_CODE, PART_LOCATION)
					VALUES ( @sAREA, @sFACTORY, @sPART_CODE, @sPART_NAME, @sSPEC, @sUNIT, 
					@VALUE, @sCOMP, @sLOCATION)
				END
				IF @sCHGCD ='R' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					UPDATE [ipismac_svr\ipis].CMMS.dbo.PART_MASTER 
					SET  PART_NAME=@sPART_NAME, PART_SPEC=@sSPEC, PART_UNIT=@sUNIT,
					PART_COST=@VALUE, COMP_CODE= @sCOMP, PART_LOCATION=@sLOCATION
					FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END				
				IF @sCHGCD ='D' 
				BEGIN
					DELETE FROM [ipismac_svr\ipis].CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE

				END
			END
			IF @sFACTORY IN ('H','V')
			BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					INSERT INTO [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER 
					(AREA_CODE,FACTORY_CODE,PART_CODE, PART_NAME, PART_SPEC, PART_UNIT,
					PART_COST, COMP_CODE, PART_LOCATION)
					VALUES ( @sAREA, @sFACTORY, @sPART_CODE, @sPART_NAME, @sSPEC, @sUNIT, 
					@VALUE, @sCOMP, @sLOCATION)
				END
				IF @sCHGCD ='R' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					UPDATE [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER 
					SET  PART_NAME=@sPART_NAME, PART_SPEC=@sSPEC, PART_UNIT=@sUNIT,
					PART_COST=@VALUE, COMP_CODE= @sCOMP, PART_LOCATION=@sLOCATION
					FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END				
				IF @sCHGCD ='D' 
				BEGIN
					DELETE FROM [ipishvac_svr\ipis].CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END
			END
		END
		IF @sAREA = 'J'
		BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					INSERT INTO ipisjin_svr.CMMS.dbo.PART_MASTER 
					(AREA_CODE,FACTORY_CODE,PART_CODE, PART_NAME, PART_SPEC, PART_UNIT,
					PART_COST, COMP_CODE, PART_LOCATION)
					VALUES ( @sAREA, @sFACTORY, @sPART_CODE, @sPART_NAME, @sSPEC, @sUNIT, 
					@VALUE, @sCOMP, @sLOCATION)
				END
				IF @sCHGCD ='R' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					UPDATE ipisjin_svr.CMMS.dbo.PART_MASTER 
					SET  PART_NAME=@sPART_NAME, PART_SPEC=@sSPEC, PART_UNIT=@sUNIT,
					PART_COST=@VALUE, COMP_CODE= @sCOMP, PART_LOCATION=@sLOCATION
					FROM ipisjin_svr.CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END				
				IF @sCHGCD ='D' 
				BEGIN
					DELETE FROM ipisjin_svr.CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END
		END
		IF @sAREA = 'Y'
		BEGIN
				IF @sCHGCD ='A' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					INSERT INTO [ipisyeo_svr\ipis].CMMS.dbo.PART_MASTER 
					(AREA_CODE,FACTORY_CODE,PART_CODE, PART_NAME, PART_SPEC, PART_UNIT,
					PART_COST, COMP_CODE, PART_LOCATION)
					VALUES ( @sAREA, @sFACTORY, @sPART_CODE, @sPART_NAME, @sSPEC, @sUNIT, 
					@VALUE, @sCOMP, @sLOCATION)
				END
				IF @sCHGCD ='R' 
				BEGIN
					SELECT @sPART_NAME=ISNULL(B.ITEMNAME,''),@sSPEC=ISNULL(B.ITEMSPEC,'') FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER A, [ipisele_svr\ipis].IPIS.dbo.TMSTITEM B 
					WHERE A.ITNO=B.ITEMCODE AND A.ITNO=@sPART_CODE
					
					UPDATE [ipisyeo_svr\ipis].CMMS.dbo.PART_MASTER 
					SET  PART_NAME=@sPART_NAME, PART_SPEC=@sSPEC, PART_UNIT=@sUNIT,
					PART_COST=@VALUE, COMP_CODE= @sCOMP, PART_LOCATION=@sLOCATION
					FROM [ipisyeo_svr\ipis].CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END				
				IF @sCHGCD ='D' 
				BEGIN
					DELETE FROM [ipisyeo_svr\ipis].CMMS.dbo.PART_MASTER 
					WHERE AREA_CODE=@sAREA AND FACTORY_CODE=@sFACTORY AND PART_CODE=@sPART_CODE
				END
		END
	END
	
	INSERT INTO [ipisele_svr\ipis].CMMS.dbo.INVMASTER
		SELECT *
		FROM [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER
		WHERE LOGID=@sLOGID

  UPDATE [ipisele_svr\ipis].INTERFACE.dbo.INVMASTER SET STSCD = 'Y' WHERE LOGID=@sLOGID
	
	FETCH NEXT FROM CURSOR_TRANS_GEN INTO @sLOGID
END

DEALLOCATE CURSOR_TRANS_GEN

--tmstitem 과 part_master 에서 품명과 규격이 다른 품번을 update (추가일 : 2003.07.10)
--전장서버
UPDATE [ipisele_svr\ipis].cmms.dbo.part_master 
	SET part_name = b.itemname, part_spec = b.itemspec
	FROM [ipisele_svr\ipis].cmms.dbo.part_master a, [ipisele_svr\ipis].ipis.dbo.tmstitem b
	WHERE a.part_code = b.itemcode
		and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )
--공조서버
UPDATE [ipishvac_svr\ipis].cmms.dbo.part_master 
	SET part_name = b.itemname, part_spec = b.itemspec
	FROM [ipishvac_svr\ipis].cmms.dbo.part_master a, [ipishvac_svr\ipis].ipis.dbo.tmstitem b
	WHERE a.part_code = b.itemcode
		and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )
--제동서버
UPDATE [ipismac_svr\ipis].cmms.dbo.part_master 
	SET part_name = b.itemname, part_spec = b.itemspec
	FROM [ipismac_svr\ipis].cmms.dbo.part_master a, [ipismac_svr\ipis].ipis.dbo.tmstitem b
	WHERE a.part_code = b.itemcode
		and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )
--진천서버
UPDATE ipisjin_svr.cmms.dbo.part_master 
	SET part_name = b.itemname, part_spec = b.itemspec
	FROM ipisjin_svr.cmms.dbo.part_master a, ipisjin_svr.ipis.dbo.tmstitem b
	WHERE a.part_code = b.itemcode
		and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )
--여주서버
UPDATE [ipisyeo_svr\ipis].cmms.dbo.part_master 
	SET part_name = b.itemname, part_spec = b.itemspec
	FROM [ipisyeo_svr\ipis].cmms.dbo.part_master a, [ipisyeo_svr\ipis].ipis.dbo.tmstitem b
	WHERE a.part_code = b.itemcode
		and (a.part_name <> b.itemname or a.part_spec <> b.itemspec )

END

GO
