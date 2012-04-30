SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

ALTER  PROCEDURE SP_CREATE_TASK
@LS_area VARCHAR(30),
@LS_factory VARCHAR(30),
@LS_equip_code VARCHAR(30),
@LS_div VARCHAR(30)
AS
BEGIN -- BEGIN PROCEDURE
DECLARE @sNEXTWONO 	varchar(30)	
BEGIN TRAN
EXEC SP_GET_NEXTTASKNO 'PM', @sNEXTWONO  output-- 다음 작업지시 번호를 가져온다.
 INSERT INTO TASK_CLASS
		(task_code, class_div,class_spot, class_item, class_basis,class_process, 
		class_est_time_hour, class_est_time_min, part_code, class_est_qty ) 
	SELECT @sNEXTWONO, class_div,class_spot, class_item, class_basis,class_process, 
		class_est_time_hour, class_est_time_min, part_code,class_qty
	from equip_class
	where equip_code=@LS_equip_code and class_div = @ls_div
IF  @@rowcount = 0
BEGIN
	ROLLBACK TRAN
	RETURN -1
END
else 
begin
	 INSERT INTO TASK_part
		(task_code, part_code, est_qty) 
	SELECT @sNEXTWONO,  part_code,class_qty
	from equip_class
	where equip_code=@LS_equip_code and class_div = @ls_div and part_code<>''
	insert into task
		(task_code,area_code,factory_code,equip_code,exam_date,status_code)
	select @sNEXTWONO, @LS_area,@LS_factory,@LS_equip_code, getdate(),'계획'
	from equip_master
	where area_code = @LS_area and factory_code=@LS_factory and equip_code=@LS_equip_code
	
COMMIT TRAN
RETURN
end
END -- END PROCEDURE

GO
SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

