if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[SP_TASK_PLAN_SCHEDULE]') and OBJECTPROPERTY(id, N'IsProcedure') = 1)
drop procedure [dbo].[SP_TASK_PLAN_SCHEDULE]
GO

--exec sp_task_plan_schedule '2005-06-01', '2005-06-30'

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
DECLARE @CLASS_EST_DATE DATETIME
DECLARE @NEXT_DATE DATETIME

declare @li_serial int, @li_totcnt int


create table #TASK_GEN
 ( serial int identity(1,1) not null, equip_code varchar(9) not null, class_div varchar(30) null, class_spot varchar(50) null,
  class_item varchar(64) null, class_cycle numeric(7,0) null, cycle_code varchar(30) null, class_est_date datetime null)

insert into #TASK_GEN(equip_code, class_div, class_spot,class_item, class_cycle, cycle_code, class_est_date)
SELECT DISTINCT A.EQUIP_CODE, A.CLASS_DIV, A.CLASS_SPOT, A.CLASS_ITEM, A.CLASS_CYCLE, A.CYCLE_CODE, A.CLASS_EST_DATE
  FROM  equip_class a, part_master b, equip_master c
 WHERE  a.part_code *= b.part_code and a.equip_code = c.equip_code and 
    a.class_div <> '04' and c.equip_div_code not in ('9','X') and a.class_est_date is not null

select @li_serial = 0, @li_totcnt = @@rowcount
if ( @li_totcnt = 0 ) return

while @li_serial < @li_totcnt
Begin
  select top 1
    @li_serial = aa.serial,
    @EQUIP_CODE = aa.equip_code,
    @CLASS_DIV = aa.class_div,
    @CLASS_SPOT = aa.class_spot,
    @CLASS_ITEM = aa.class_item,
    @CLASS_CYCLE = aa.class_cycle,
    @CYCLE_CODE = aa.cycle_code,
    @NEXT_DATE = aa.class_est_date
  from #TASK_GEN aa
  where aa.serial > @li_serial
  order by aa.serial

  IF (@CYCLE_CODE not in ('일','주','월','분기','반기','년')) 
    continue
  
	while (@NEXT_DATE <= @PS_YYMMDD_B)
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
				IF @CYCLE_CODE='분기'
					BEGIN
					SET @NEXT_DATE=dateadd(month, @CLASS_CYCLE, @NEXT_DATE)
					END
				IF @CYCLE_CODE='반기'
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
				IF @CYCLE_CODE='분기'
					BEGIN
					SET @NEXT_DATE=dateadd(month, @CLASS_CYCLE, @NEXT_DATE)
					END
				IF @CYCLE_CODE='반기'
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
drop table #TASK_GEN
SELECT 1
END -- END PROCEDURE

GO
