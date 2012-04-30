/*
  File Name : sp_pisf023_01.sql
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf023_01
  Description : 예방정비 작업지시서 - 예상자재 리스트
  Use DataBase  : cmms
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf023_01]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf023_01]
GO

/*
exec sp_pisf023_01 'PM-200309-055'
*/

Create Procedure sp_pisf023_01
  @ps_taskcode 		Char(30)  	-- 예방정비코드

As
Begin

Create Table #Tmp_Task
	(
		part_name	char(100) null,
		part_cost		float null,
		part_code	char(30) null,
		est_qty		float null,
		qty				float null  
	)

Declare	@i			Int,
			@totcnt	Int

INSERT INTO #Tmp_Task
SELECT part_master.part_name,   
         part_master.part_cost,   
         task_part.part_code,   
         isnull(task_part.est_qty, 0),   
         isnull(task_part.qty, 0)
    FROM part_master,   
         task_part  
   WHERE ( part_master.part_code = task_part.part_code ) and  
         ( task_part.task_code = @ps_taskcode )

select @i = 1
SELECT @totcnt = count(*)
FROM #Tmp_Task

if (( @totcnt - 5 ) < 0 )
	while (( @totcnt + @i ) < 6 )
		BEGIN
			select @i = @i + 1
			INSERT INTO #Tmp_Task(part_name,part_cost,part_code,est_qty,qty)
			VALUES(' ',null,null,null,null)
		END

SELECT *
FROM #Tmp_Task

Drop table #Tmp_Task
End   -- Procedure End
Go
