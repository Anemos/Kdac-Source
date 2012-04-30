/*
  file name : sp_pisf010_report01.sql
  system    : cmms system
  procedure name  : sp_pisf010_report01
  description :
  use database  : cmms
  use program :
  parameter :
  use table :
  initial   : 2002.12
  author    :
*/

if exists (select * from sysobjects
      where id = object_id(N'[dbo].[sp_pisf010_report01]')
        and objectproperty(id, N'isprocedure') = 1)
  drop procedure [dbo].[sp_pisf010_report01]
go

/*
Exec sp_pisf010_report01 'D','A',
    @ps_equipcode        = 'A70001' ,
        @ps_yyyymm        =   '2002.01'
*/

create procedure [dbo].[sp_pisf010_report01]
  @ps_area char(1),
  @ps_factory char(1),
  @ps_equipcode char(30),   -- 장비코드
  @ps_yyyymm  char(7)        -- 기준년월
AS

BEGIN

  -- 저장할 임시테이블
  --
  Create Table #Tmp_daily
  (
    Seq       Int      ,
    EquipCode   Char(30)  ,
    EquipName   Char(30)  ,
    CurDate     Char(7) ,
    ClassDiv      Char(30)  ,
    ClassCode   Char(30)  ,
    ClassItem     Char(150)
  )

  Declare @li_Seq   Int      ,
      @pi_count Int ,
      @pi_cnt   Int ,
      @pi_totrow  Int ,
      @ps_name  Char(30)  ,
      @ps_div   Char(30)  ,
      @ps_code  Char(30)  ,
      @ps_item    Char(150)  ,
      @ps_check Char(30)

  SET @li_Seq = 0
  SET @pi_cnt = 0
  SET @pi_totrow = 22

  Declare daily_cursor Cursor For
    select bb.equip_name,aa.class_div,aa.cycle_code,aa.class_item
    FROM equip_class aa inner join equip_master bb
      ON ( aa.area_code = bb.area_code ) and
        ( aa.factory_code = bb.factory_code ) and
        ( aa.equip_code = bb.equip_code )
    WHERE  ( aa.class_div = '04' ) AND
              ( aa.cycle_code in ('일','주','월') ) AND
              ( aa.equip_code = @ps_equipcode ) AND
              ( aa.area_code = @ps_area ) AND
              ( aa.factory_code = @ps_factory )
    ORDER BY aa.cycle_code

  Open daily_cursor

  Fetch Next From daily_cursor into @ps_name,@ps_div,@ps_code,@ps_item
  SET @ps_check = @ps_code
  While @@Fetch_Status = 0
    Begin
      if @ps_check <> @ps_code
        Begin
          while @pi_cnt <  @pi_totrow
            Begin
              SET @pi_cnt = @pi_cnt + 1
              Insert #Tmp_daily Values(@pi_cnt, @ps_equipcode, @ps_name, @ps_yyyymm,
                @ps_div, @ps_check,space(1))
            End
          SET @pi_cnt = 1
          SET @ps_check = @ps_code
        End
      else
        Begin
          SET @pi_cnt = @pi_cnt + 1
          SET @ps_check = @ps_code
        End
      Insert #Tmp_daily Values(@pi_cnt, @ps_equipcode, @ps_name, @ps_yyyymm,
          @ps_div, @ps_code,@ps_item)
      Fetch Next From daily_cursor into @ps_name,@ps_div,@ps_code,@ps_item
    End
Close daily_cursor
Deallocate daily_cursor

while @pi_cnt <  @pi_totrow
  Begin
    SET @pi_cnt = @pi_cnt + 1
    Insert #Tmp_daily Values(@pi_cnt, @ps_equipcode, @ps_name, @ps_yyyymm,
        @ps_div, @ps_check,space(1))
  End

process_end:

select  Seq ,EquipCode,EquipName,CurDate,ClassDiv,ClassCode,ClassItem
from #Tmp_daily
order by classcode,seq

Drop Table #Tmp_daily

END