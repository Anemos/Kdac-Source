if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_TASK_PLAN_SCHEDULE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_TASK_PLAN_SCHEDULE]
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

CREATE   PROCEDURE SP_TASK_PLAN_SCHEDULE
@PS_YYMMDD_A datetime,
@PS_YYMMDD_B datetime
AS
BEGIN -- BEGIN PROCEDURE
TRUNCATE TABLE SCHEDULE_NEXT
DECLARE @EQUIP_CODE VARCHAR(30)
DECLARE @CLASS_DIV VARCHAR(30)
DECLARE @CLASS_SPOT VARCHAR(50)
DECLARE @CLASS_ITEM VARCHAR(64)
DECLARE @CLASS_CYCLE FLOAT
DECLARE @CYCLE_CODE VARCHAR(30)
DECLARE @NEXT_DATE DATETIME
SELECT DISTINCT A.EQUIP_CODE, A.CLASS_DIV, A.CLASS_SPOT, A.CLASS_ITEM, A.CLASS_CYCLE, A.CYCLE_CODE, A.CLASS_EST_DATE
  INTO #TASK_GEN
  FROM  equip_class a, part_master b
 WHERE  a.part_code *= b.part_code 
DECLARE CURSOR_TASK_GEN CURSOR
    	FOR SELECT EQUIP_CODE, CLASS_DIV, CLASS_SPOT, CLASS_ITEM, CLASS_CYCLE, CYCLE_CODE, CLASS_EST_DATE
	FROM #TASK_GEN
OPEN CURSOR_TASK_GEN
FETCH NEXT FROM CURSOR_TASK_GEN INTO @EQUIP_CODE, @CLASS_DIV, @CLASS_SPOT, @CLASS_ITEM, @CLASS_CYCLE, @CYCLE_CODE, @NEXT_DATE
WHILE (@@FETCH_STATUS <> -1)
begin
	if (@@FETCH_STATUS <> -2)
	begin
		
		
		WHILE (@NEXT_DATE <= @PS_YYMMDD_B)
		BEGIN
			
			IF((@NEXT_DATE >= @PS_YYMMDD_A) AND (@NEXT_DATE <= @PS_YYMMDD_B))
			BEGIN
			insert into schedule_next (equip_code, class_div, class_spot, class_item, class_basis, class_process, class_cycle, 
			cycle_code, class_est_date, class_est_time_hour, class_est_time_min, part_code, part_name, part_spec, class_qty)
			select 	a.equip_code, 
				a.class_div,
				a.class_spot,
				a.class_item, 
				a.class_basis, 
				a.class_process, 
				a.class_cycle, 
				a.cycle_code, 
				@NEXT_DATE,
				a.class_est_time_hour, 
				a.class_est_time_min, 
				a.part_code, 
				b.part_name, 
				b.part_spec, 
				a.class_qty
			
			from 	equip_class a,
				part_master b
			
			where 	a.part_code *= b.part_code AND A.EQUIP_CODE=@EQUIP_CODE AND A.CLASS_DIV=@CLASS_DIV AND A.CLASS_SPOT=@CLASS_SPOT AND A.CLASS_ITEM=@CLASS_ITEM AND A.CLASS_DIV<>'04'
				IF @CYCLE_CODE='일'
					BEGIN
					SET @NEXT_DATE=dateadd(day, @CLASS_CYCLE, @NEXT_DATE)
					END
				IF @CYCLE_CODE='주'
					BEGIN
					SET @NEXT_DATE=dateadd(week, @CLASS_CYCLE, @NEXT_DATE)
					END
				IF @CYCLE_CODE='월'
					BEGIN
					SET @NEXT_DATE=dateadd(month, @CLASS_CYCLE, @NEXT_DATE)
					END
				IF @CYCLE_CODE='년'
					BEGIN
					SET @NEXT_DATE=dateadd(year, @CLASS_CYCLE, @NEXT_DATE)
					END
			END
			IF (@NEXT_DATE < @PS_YYMMDD_A)
			BEGIN 
				IF @CYCLE_CODE='일'
					BEGIN
					SET @NEXT_DATE=dateadd(day, @CLASS_CYCLE, @NEXT_DATE)
					END
				IF @CYCLE_CODE='주'
					BEGIN
					SET @NEXT_DATE=dateadd(week, @CLASS_CYCLE, @NEXT_DATE)
					END
				IF @CYCLE_CODE='월'
					BEGIN
					SET @NEXT_DATE=dateadd(month, @CLASS_CYCLE, @NEXT_DATE)
					END
				IF @CYCLE_CODE='년'
					BEGIN
					SET @NEXT_DATE=dateadd(year, @CLASS_CYCLE, @NEXT_DATE)
					END
			END
			
		END
	END
FETCH NEXT FROM CURSOR_TASK_GEN INTO @EQUIP_CODE, @CLASS_DIV, @CLASS_SPOT, @CLASS_ITEM,@CLASS_CYCLE, @CYCLE_CODE, @NEXT_DATE
END
END -- END PROCEDURE
DEALLOCATE CURSOR_TASK_GEN
SELECT 1
GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

