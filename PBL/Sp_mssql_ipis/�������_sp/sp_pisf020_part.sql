/*
  File Name : sp_pisf020_part.sql
  SYSTEM    : CMMS System
  Procedure Name  : sp_pisf020_part
  Description : 사후정비 작업지시서 - 예상자재 리스트
  Use DataBase  : cmms
  Use Program :
  Parameter :
  Use Table :
  Initial   : 2004.03
  Author    : Kiss Kim
*/

If Exists (Select * From sysobjects
      Where id = object_id(N'[dbo].[sp_pisf020_part]')
        And OBJECTPROPERTY(id, N'IsProcedure') = 1)
  Drop Procedure [dbo].[sp_pisf020_part]
GO

/*
exec sp_pisf020_part 'PM-200309-055'
*/

Create Procedure sp_pisf020_part
  @ps_wocode 		Char(30),  	-- 사후정비코드
	@ps_areacode		Char(1),		-- 지역
	@ps_factorycode	Char(1)		-- 공장

As
Begin

Create Table #Tmp_Wo
	(
		part_code	char(30) null,
		part_name	char(100) null,
		est_qty		float null,
		qty				float null,
		part_cost		float null 
	)

Declare	@i			Int,
			@totcnt	Int

INSERT INTO #Tmp_Wo
SELECT	wo_part.part_code, 
		part_master.part_name,         
         isnull(wo_part.estqty, 0),   
         isnull(wo_part.qty, 0),
		part_master.part_cost
    FROM part_master,   
         wo_part  
   WHERE ( part_master.part_code = wo_part.part_code ) and  
         		( wo_part.wo_code = @ps_wocode ) and
			( wo_part.area_code = @ps_areacode ) and
			( wo_part.factory_code = @ps_factorycode ) 

select @i = 1
SELECT @totcnt = count(*)
FROM #Tmp_Wo

if (( @totcnt - 5 ) < 0 )
	while (( @totcnt + @i ) < 6 )
		BEGIN
			select @i = @i + 1
			INSERT INTO #Tmp_Wo(part_code,part_name,est_qty,qty,part_cost)
			VALUES(' ',' ',null,null,null)
		END

SELECT *
FROM #Tmp_Wo

Drop table #Tmp_Wo
End   -- Procedure End
Go
