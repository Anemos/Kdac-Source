ALTER  PROCEDURE SP_CREATE_TASK_AUTO
AS
BEGIN -- BEGIN PROCEDURE
DECLARE @sNEXTWONO 	varchar(30)	,
	@sEQUIPCODE 	varchar(30)	,
	@sDIV 	varchar(30)	,
	@sAREA 	varchar(30)	,
	@sFACTORY	varchar(30),
	@sCYCLE	varchar(30),
	@iCYCLE	INT,
	@sNEXTDATE	DATETIME,
	@sSPOT	varchar(30),
	@sTODATE	DATETIME
SELECT DISTINCT A.EQUIP_CODE, A.CLASS_DIV, B.AREA_CODE, B.FACTORY_CODE
  INTO #TASK_GEN
  FROM EQUIP_CLASS A, EQUIP_MASTER B
 WHERE CONVERT(VARCHAR(10),A.CLASS_EST_DATE,120) <= CONVERT(VARCHAR(10),GETDATE(),120) AND A.EQUIP_CODE=B.EQUIP_CODE AND
  B.EQUIP_DIV_CODE NOT IN ('9','X') AND A.CLASS_DIV <> '04'
DECLARE CURSOR_TASK_GEN CURSOR
    FOR SELECT EQUIP_CODE, CLASS_DIV,AREA_CODE, FACTORY_CODE  FROM #TASK_GEN
OPEN CURSOR_TASK_GEN
FETCH NEXT FROM CURSOR_TASK_GEN INTO @sEQUIPCODE,@sDIV, @sAREA, @sFACTORY
WHILE (@@FETCH_STATUS <> -1)
begin
	if (@@FETCH_STATUS <> -2)
	begin
		BEGIN TRAN
		EXEC SP_GET_NEXTTASKNO 'PM', @sNEXTWONO  output-- 다음 작업지시 번호를 가져온다.
		 INSERT INTO TASK_CLASS
			(task_code, class_div,class_spot, class_item, class_basis,class_process, 
			class_est_time_hour, class_est_time_min, part_code, class_est_qty ) 
		SELECT @sNEXTWONO, class_div,class_spot, class_item, class_basis,class_process, 
			class_est_time_hour, class_est_time_min, part_code,class_qty
		from equip_class
		where equip_code=@sEQUIPCODE and class_div = @sDIV
	
	
	 INSERT INTO TASK_part
		(task_code, part_code, est_qty) 
	SELECT @sNEXTWONO,  part_code,class_qty
	from equip_class
	where equip_code=@sEQUIPCODE and class_div =  @sDIV and part_code<>''
	
		insert into task
		(task_code,area_code,factory_code,equip_code,exam_date,status_code)
		select @sNEXTWONO, @sAREA,@sFACTORY,@sEQUIPCODE, getdate(),'계획'
		from equip_master
		where area_code = @sAREA and factory_code=@sFACTORY and equip_code=@sEQUIPCODE
		COMMIT TRAN
	
	SELECT EQUIP_CODE,CLASS_DIV,CYCLE_CODE,CLASS_CYCLE, CLASS_SPOT
	INTO #TASK_GEN1
	FROM EQUIP_CLASS 
	where equip_code=@sEQUIPCODE and class_div = @sDIV
	
	DECLARE CURSOR_TASK_GEN1 CURSOR
			    FOR SELECT EQUIP_CODE, CLASS_DIV,CYCLE_CODE, CLASS_CYCLE, CLASS_SPOT  FROM #TASK_GEN1
			OPEN CURSOR_TASK_GEN1
			FETCH NEXT FROM CURSOR_TASK_GEN1 INTO @sEQUIPCODE,@sDIV, @sCYCLE, @iCYCLE,@sSPOT
			
			WHILE (@@FETCH_STATUS <> -1)
			begin
				if (@@FETCH_STATUS <> -2)
				begin
					BEGIN TRAN
					SELECT @sTODATE=GETDATE()
					EXEC SP_GET_NEXTDATE @sCYCLE,@iCYCLE,  @sTODATE, @sNEXTDATE  output-- 다음 예정일 번호를 가져온다.
					UPDATE EQUIP_CLASS
					SET CLASS_EST_DATE=@sNEXTDATE
					WHERE EQUIP_CODE=@sEQUIPCODE AND CLASS_DIV=@sDIV AND CLASS_SPOT=@sSPOT
					COMMIT TRAN
				END
				FETCH NEXT FROM CURSOR_TASK_GEN1 INTO @sEQUIPCODE,@sDIV, @sCYCLE, @iCYCLE,@sSPOT
			END
			drop table #TASK_GEN1
			DEALLOCATE CURSOR_TASK_GEN1
	END
	
FETCH NEXT FROM CURSOR_TASK_GEN INTO @sEQUIPCODE,@sDIV, @sAREA, @sFACTORY
END
END -- END PROCEDURE
DEALLOCATE CURSOR_TASK_GEN

GO
