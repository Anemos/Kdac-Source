ALTER	 PROCEDURE SP_CREATE_TASK_AUTO
AS
BEGIN	-- BEGIN PROCEDURE
DECLARE	@sNEXTWONO 	varchar(30)	,
	@sEQUIPCODE		varchar(30)	,
	@sDIV		varchar(30)	,
	@sAREA 	varchar(30)	,
	@sFACTORY	varchar(30),
	@sCYCLE	varchar(30),
	@iCYCLE	INT,
	@sNEXTDATE	DATETIME,
	@sSPOT	varchar(30),
	@sTODATE	DATETIME
declare	@li_serial int,	@li_totcnt int

create table #TASK_GEN
 ( serial	int	identity(1,1)	not	null,	equip_code varchar(9)	null,	class_div	varchar(30)	null,
 area_code char(1) null, factory_code	char(1)	null )

insert into	#TASK_GEN( equip_code, class_div,	area_code, factory_code	)
SELECT DISTINCT	A.EQUIP_CODE,	A.CLASS_DIV, B.AREA_CODE,	B.FACTORY_CODE
	FROM EQUIP_CLASS A,	EQUIP_MASTER B
 WHERE CONVERT(VARCHAR(10),A.CLASS_EST_DATE,120) <=	CONVERT(VARCHAR(10),GETDATE(),120) AND A.EQUIP_CODE=B.EQUIP_CODE AND
	B.EQUIP_DIV_CODE NOT IN	('9','X')	AND	A.CLASS_DIV	<> '04'

select @li_serial	=	0, @li_totcnt	=	@@rowcount
if ( @li_totcnt	=	0	)	return

while	@li_serial < @li_totcnt
Begin
	select top 1
			@li_serial = aa.serial,
			@sEQUIPCODE	=	aa.equip_code,
			@sDIV	=	aa.class_div,
			@sAREA = aa.area_code,
			@sFACTORY	=	aa.factory_code
		from #TASK_GEN aa
		where	aa.serial	>	@li_serial
		order	by aa.serial
	BEGIN	TRAN
		EXEC SP_GET_NEXTTASKNO 'PM', @sNEXTWONO	 output--	다음 작업지시	번호를 가져온다.
		INSERT INTO	TASK_CLASS
			(task_code,	class_div,class_spot,	class_item,	class_basis,class_process,
			class_est_time_hour, class_est_time_min, part_code,	class_est_qty	)
		SELECT @sNEXTWONO, class_div,class_spot, class_item, class_basis,class_process,
			class_est_time_hour, class_est_time_min, part_code,class_qty
		from equip_class
		where	equip_code=@sEQUIPCODE and class_div = @sDIV and
			CONVERT(VARCHAR(10),class_est_date,120)	<= CONVERT(VARCHAR(10),GETDATE(),120)	and	class_div	<> '04'

		INSERT INTO	TASK_part
			(task_code,	part_code, est_qty)
		SELECT @sNEXTWONO,	part_code,class_qty
		from equip_class
		where	equip_code=@sEQUIPCODE and class_div =	@sDIV	and	part_code<>''	and
			CONVERT(VARCHAR(10),class_est_date,120)	<= CONVERT(VARCHAR(10),GETDATE(),120)	and	class_div	<> '04'

		insert into	task
		(task_code,area_code,factory_code,equip_code,exam_date,status_code)
		values(	@sNEXTWONO,	@sAREA,@sFACTORY,@sEQUIPCODE,	getdate(),'계획' )

		UPDATE equip_class
		SET	CLASS_EST_DATE=	case when	cycle_code = '년'	then DATEADD(YEAR, (1	*	class_cycle),	getdate())
			when cycle_code	=	'반기' then	DATEADD(MONTH, (6	*	class_cycle),	getdate())
			when cycle_code	=	'분기' then	DATEADD(MONTH, (3	*	class_cycle),	getdate())
			when cycle_code	=	'월' then	DATEADD(MONTH, (1	*	class_cycle),	getdate())
			when cycle_code	=	'주' then	DATEADD(WEEK,	(1 * class_cycle), getdate())
			when cycle_code	=	'일' then	DATEADD(DAY, (1	*	class_cycle),	getdate())
			else class_est_date	end
		WHERE	EQUIP_CODE=@sEQUIPCODE AND CLASS_DIV=@sDIV AND
			CONVERT(VARCHAR(10),class_est_date,120)	<= CONVERT(VARCHAR(10),GETDATE(),120)	and	class_div	<> '04'

	COMMIT TRAN
End
drop table #TASK_GEN
END	-- END PROCEDURE

GO
