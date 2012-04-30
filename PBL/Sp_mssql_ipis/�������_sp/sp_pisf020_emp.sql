/*
  File Name : sp_pisf020_emp.sql
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf020_emp
  Description : 사후정비 작업지시서 - 예상인원 리스트
  Use DataBase  : cmms
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf020_emp]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf020_emp]
GO

/*
exec sp_pisf020_emp 'BM-M-200310-072', 'D', 'A'
*/

Create Procedure sp_pisf020_emp
  @ps_wocode 		Char(30),  	-- 사후정비코드
	@ps_areacode		Char(1),		-- 지역
	@ps_factorycode	Char(1)		-- 공장

As
Begin

Create Table #Tmp_Emp
	(
		emp_code	char(30) null,
		emp_name	char(50) null,
		manhour_hour		float null,
		manhour_second	float null,
		wo_date		char(10) null  
	)

Declare	@i			Int,
			@totcnt	Int

INSERT INTO #Tmp_Emp
SELECT  wo_emp.emp_code,
		emp_master.emp_name,      
         isnull(wo_emp.manhour_hour, 0),   
         isnull(wo_emp.manhour_second, 0),
		convert(varchar(10),wo_emp.wo_date,120) 
    FROM emp_master,   
         wo_emp  
   WHERE ( emp_master.emp_code = wo_emp.emp_code ) and  
         		( ( wo_emp.wo_code = @ps_wocode )  and
			( wo_emp.area_code = @ps_areacode ) and
			( wo_emp.factory_code = @ps_factorycode ) )

select @i = 1
SELECT @totcnt = count(*)
FROM #Tmp_Emp

if (( @totcnt - 5 ) < 0 )
	while (( @totcnt + @i ) < 6 )
		BEGIN
			select @i = @i + 1
			INSERT INTO #Tmp_Emp(emp_code,emp_name,manhour_hour,manhour_second,wo_date)
			VALUES(' ',' ',null,null,null)
		END

SELECT *
FROM #Tmp_Emp

Drop table #Tmp_Emp
End   -- Procedure End
Go
