/*
  file name : sp_pisf020_part.sql
  system    : cmms system
  procedure name  : sp_pisf020_part
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf020_part]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf020_part]
go

------------------------------------------------------------------
--  �������� �۾����ü� - �������� ����Ʈ
--  exec sp_pisf020_part 'PM-200309-055'
------------------------------------------------------------------

create PROCEDURE [dbo].[sp_pisf020_part]
  @ps_wocode    Char(30),   -- ���������ڵ�
  @ps_areacode    Char(1),    -- ����
  @ps_factorycode Char(1)   -- ����

AS

BEGIN


Create Table #Tmp_Wo
  (
    part_code char(30) null,
    part_name char(100) null,
    est_qty   float null,
    qty       float null,
    part_cost   float null
  )

Declare @i      Int,
      @totcnt Int

INSERT INTO #Tmp_Wo
SELECT  wo_part.part_code,
    part_master.part_name,
         isnull(wo_part.estqty, 0),
         isnull(wo_part.qty, 0),
    part_master.part_cost
    FROM part_master inner join wo_part
      ON ( part_master.area_code = wo_part.area_code ) and
        ( part_master.factory_code = wo_part.factory_code ) and
        ( part_master.part_code = wo_part.part_code )
   WHERE ( wo_part.wo_code = @ps_wocode ) and
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

END

Drop table #Tmp_Wo